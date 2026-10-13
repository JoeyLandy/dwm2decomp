SECTION "Bank 21", ROMX[$4000], BANK[$21]
    db $21

; compressed sprite graphics of monster id $05A (MadGopher) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadGopher::
    INCBIN "dwm2-cobi-us.gbc", $084001, $F3

; compressed sprite graphics of monster id $05B (FairyRat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 191 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FairyRat::
    INCBIN "dwm2-cobi-us.gbc", $0840F4, $BF

; compressed sprite graphics of monster id $05C (Unicorn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Unicorn::
    INCBIN "dwm2-cobi-us.gbc", $0841B3, $E7

; compressed sprite graphics of monster id $05D (Goategon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 184 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Goategon::
    INCBIN "dwm2-cobi-us.gbc", $08429A, $B8

; compressed sprite graphics of monster id $05E (WildApe) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WildApe::
    INCBIN "dwm2-cobi-us.gbc", $084352, $D5

; compressed sprite graphics of monster id $05F (Trumpeter) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Trumpeter::
    INCBIN "dwm2-cobi-us.gbc", $084427, $FD

; compressed sprite graphics of monster id $060 (KingLeo) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KingLeo::
    INCBIN "dwm2-cobi-us.gbc", $084524, $E9

; compressed sprite graphics of monster id $061 (DarkHorn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkHorn::
    INCBIN "dwm2-cobi-us.gbc", $08460D, $D7

; compressed sprite graphics of monster id $062 (MadCat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 212 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadCat::
    INCBIN "dwm2-cobi-us.gbc", $0846E4, $D4

; compressed sprite graphics of monster id $063 (BigEye) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BigEye::
    INCBIN "dwm2-cobi-us.gbc", $0847B8, $E2

; compressed sprite graphics of monster id $064 (Gorago) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gorago::
    INCBIN "dwm2-cobi-us.gbc", $08489A, $F5

; compressed sprite graphics of monster id $065 (CatMage) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CatMage::
    INCBIN "dwm2-cobi-us.gbc", $08498F, $DB

; compressed sprite graphics of monster id $066 (Dumbira) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dumbira::
    INCBIN "dwm2-cobi-us.gbc", $084A6A, $EF

; compressed sprite graphics of monster id $06A (Picky) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Picky::
    INCBIN "dwm2-cobi-us.gbc", $084B59, $D1

; compressed sprite graphics of monster id $06B (Wyvern) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 188 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Wyvern::
    INCBIN "dwm2-cobi-us.gbc", $084C2A, $BC

; compressed sprite graphics of monster id $06C (BullBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BullBird::
    INCBIN "dwm2-cobi-us.gbc", $084CE6, $F8

; compressed sprite graphics of monster id $06D (Florajay) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Florajay::
    INCBIN "dwm2-cobi-us.gbc", $084DDE, $F2

; compressed sprite graphics of monster id $06E (DuckKite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 130 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DuckKite::
    INCBIN "dwm2-cobi-us.gbc", $084ED0, $82

; compressed sprite graphics of monster id $06F (MadPecker) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadPecker::
    INCBIN "dwm2-cobi-us.gbc", $084F52, $ED

; compressed sprite graphics of monster id $070 (MadRaven) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 186 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadRaven::
    INCBIN "dwm2-cobi-us.gbc", $08503F, $BA

; compressed sprite graphics of monster id $071 (MistyWing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 115 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MistyWing::
    INCBIN "dwm2-cobi-us.gbc", $0850F9, $73

; compressed sprite graphics of monster id $072 (AquaHawk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AquaHawk::
    INCBIN "dwm2-cobi-us.gbc", $08516C, $DB

; compressed sprite graphics of monster id $073 (Dracky) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 193 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dracky::
    INCBIN "dwm2-cobi-us.gbc", $085247, $C1

; compressed sprite graphics of monster id $074 (KiteHawk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 205 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KiteHawk::
    INCBIN "dwm2-cobi-us.gbc", $085308, $CD

; compressed sprite graphics of monster id $075 (BigRoost) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BigRoost::
    INCBIN "dwm2-cobi-us.gbc", $0853D5, $DB

; compressed sprite graphics of monster id $076 (StubBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_StubBird::
    INCBIN "dwm2-cobi-us.gbc", $0854B0, $CD

; compressed sprite graphics of monster id $077 (LandOwl) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LandOwl::
    INCBIN "dwm2-cobi-us.gbc", $08557D, $F1

; compressed sprite graphics of monster id $078 (MadGoose) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadGoose::
    INCBIN "dwm2-cobi-us.gbc", $08566E, $DC

; compressed sprite graphics of monster id $079 (MadCondor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_MadCondor::
    INCBIN "dwm2-cobi-us.gbc", $08574A, $DC

; compressed sprite graphics of monster id $07A (Emyu) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 179 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Emyu::
    INCBIN "dwm2-cobi-us.gbc", $085826, $B3

; compressed sprite graphics of monster id $07B (Blizzardy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Blizzardy::
    INCBIN "dwm2-cobi-us.gbc", $0858D9, $E4

; compressed sprite graphics of monster id $07C (Phoenix) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Phoenix::
    INCBIN "dwm2-cobi-us.gbc", $0859BD, $E5

; compressed sprite graphics of monster id $07D (ZapBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_ZapBird::
    INCBIN "dwm2-cobi-us.gbc", $085AA2, $E4

; compressed sprite graphics of monster id $07E (Garudian) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 200 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Garudian::
    INCBIN "dwm2-cobi-us.gbc", $085B86, $C8

; compressed sprite graphics of monster id $07F (WhipBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WhipBird::
    INCBIN "dwm2-cobi-us.gbc", $085C4E, $F3

; compressed sprite graphics of monster id $080 (FunkyBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FunkyBird::
    INCBIN "dwm2-cobi-us.gbc", $085D41, $E5

; compressed sprite graphics of monster id $081 (RainHawk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RainHawk::
    INCBIN "dwm2-cobi-us.gbc", $085E26, $D2

; compressed sprite graphics of monster id $082 (Azurile) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Azurile::
    INCBIN "dwm2-cobi-us.gbc", $085EF8, $D5

; compressed sprite graphics of monster id $083 (Shantak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Shantak::
    INCBIN "dwm2-cobi-us.gbc", $085FCD, $D7

; compressed sprite graphics of monster id $084 (CragDevil) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CragDevil::
    INCBIN "dwm2-cobi-us.gbc", $0860A4, $DA

; compressed sprite graphics of monster id $08D (MadPlant) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadPlant::
    INCBIN "dwm2-cobi-us.gbc", $08617E, $DC

; compressed sprite graphics of monster id $08E (FireWeed) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FireWeed::
    INCBIN "dwm2-cobi-us.gbc", $08625A, $F7

; compressed sprite graphics of monster id $08F (FloraMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 169 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FloraMan::
    INCBIN "dwm2-cobi-us.gbc", $086351, $A9

; compressed sprite graphics of monster id $090 (WingTree) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WingTree::
    INCBIN "dwm2-cobi-us.gbc", $0863FA, $E2

; compressed sprite graphics of monster id $091 (CactiBall) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CactiBall::
    INCBIN "dwm2-cobi-us.gbc", $0864DC, $E8

; compressed sprite graphics of monster id $092 (Gulpple) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 170 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gulpple::
    INCBIN "dwm2-cobi-us.gbc", $0865C4, $AA

; compressed sprite graphics of monster id $093 (Toadstool) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 187 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Toadstool::
    INCBIN "dwm2-cobi-us.gbc", $08666E, $BB

; compressed sprite graphics of monster id $094 (AmberWeed) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AmberWeed::
    INCBIN "dwm2-cobi-us.gbc", $086729, $F7

; compressed sprite graphics of monster id $095 (Slurperon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Slurperon::
    INCBIN "dwm2-cobi-us.gbc", $086820, $E2

; compressed sprite graphics of monster id $096 (Stubsuck) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Stubsuck::
    INCBIN "dwm2-cobi-us.gbc", $086902, $E0

; compressed sprite graphics of monster id $097 (Oniono) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Oniono::
    INCBIN "dwm2-cobi-us.gbc", $0869E2, $E5

; compressed sprite graphics of monster id $098 (DanceVegi) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_DanceVegi::
    INCBIN "dwm2-cobi-us.gbc", $086AC7, $E0

; compressed sprite graphics of monster id $099 (TreeBoy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 171 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TreeBoy::
    INCBIN "dwm2-cobi-us.gbc", $086BA7, $AB

; compressed sprite graphics of monster id $09A (Devipine) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Devipine::
    INCBIN "dwm2-cobi-us.gbc", $086C52, $D3

; compressed sprite graphics of monster id $09B (FaceTree) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 179 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FaceTree::
    INCBIN "dwm2-cobi-us.gbc", $086D25, $B3

; compressed sprite graphics of monster id $09C (HerbMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 192 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HerbMan::
    INCBIN "dwm2-cobi-us.gbc", $086DD8, $C0

; compressed sprite graphics of monster id $09D (BeanMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BeanMan::
    INCBIN "dwm2-cobi-us.gbc", $086E98, $F4

; compressed sprite graphics of monster id $09E (EvilSeed) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 185 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilSeed::
    INCBIN "dwm2-cobi-us.gbc", $086F8C, $B9

; compressed sprite graphics of monster id $09F (ManEater) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ManEater::
    INCBIN "dwm2-cobi-us.gbc", $087045, $F8

; compressed sprite graphics of monster id $0A0 (Snapper) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 171 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Snapper::
    INCBIN "dwm2-cobi-us.gbc", $08713D, $AB

; compressed sprite graphics of monster id $0A1 (GhosTree) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 201 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GhosTree::
    INCBIN "dwm2-cobi-us.gbc", $0871E8, $C9

; compressed sprite graphics of monster id $0A2 (Rosevine) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Rosevine::
    INCBIN "dwm2-cobi-us.gbc", $0872B1, $DD

; compressed sprite graphics of monster id $0A3 (Egdracil) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Egdracil::
    INCBIN "dwm2-cobi-us.gbc", $08738E, $E5

; compressed sprite graphics of monster id $0A4 (Warubou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Warubou::
    INCBIN "dwm2-cobi-us.gbc", $087473, $D5

; compressed sprite graphics of monster id $0A5 (Watabou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 249 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Watabou::
    INCBIN "dwm2-cobi-us.gbc", $087548, $F9

; compressed sprite graphics of monster id $0A6 (Eggplaton) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 167 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Eggplaton::
    INCBIN "dwm2-cobi-us.gbc", $087641, $A7

; compressed sprite graphics of monster id $0A7 (FooHero) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FooHero::
    INCBIN "dwm2-cobi-us.gbc", $0876E8, $E4

; compressed sprite graphics of monster id $0B0 (GiantSlug) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GiantSlug::
    INCBIN "dwm2-cobi-us.gbc", $0877CC, $E6

; compressed sprite graphics of monster id $0B1 (Catapila) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Catapila::
    INCBIN "dwm2-cobi-us.gbc", $0878B2, $F4

; compressed sprite graphics of monster id $0B2 (Gophecada) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 187 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gophecada::
    INCBIN "dwm2-cobi-us.gbc", $0879A6, $BB

; compressed sprite graphics of monster id $0B3 (Butterfly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Butterfly::
    INCBIN "dwm2-cobi-us.gbc", $087A61, $BB

; compressed sprite graphics of monster id $0B4 (WeedBug) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 160 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WeedBug::
    INCBIN "dwm2-cobi-us.gbc", $087B1C, $A0

; compressed sprite graphics of monster id $0B5 (GiantWorm) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 212 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GiantWorm::
    INCBIN "dwm2-cobi-us.gbc", $087BBC, $D4

; compressed sprite graphics of monster id $0B6 (Lipsy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lipsy::
    INCBIN "dwm2-cobi-us.gbc", $087C90, $F2

; compressed sprite graphics of monster id $0B7 (StagBug) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 214 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_StagBug::
    INCBIN "dwm2-cobi-us.gbc", $087D82, $D6
    ds $1a8, $00
