; ROM bank $23: compressed monster sprites
; The annotated listing of this bank is build/listing/bank23.asm.

SECTION "Bank 23", ROMX[$4000], BANK[$23]
    db $23

; compressed sprite graphics of monster id $109 (BoneSlave) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BoneSlave::
    INCBIN "dwm2-cobi-us.gbc", $08C001, $F7

; compressed sprite graphics of monster id $10A (Skeletor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skeletor::
    INCBIN "dwm2-cobi-us.gbc", $08C0F8, $D2

; compressed sprite graphics of monster id $10B (Servant) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 256 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Servant::
    INCBIN "dwm2-cobi-us.gbc", $08C1CA, $100

; compressed sprite graphics of monster id $10C (Lazamanus) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lazamanus::
    INCBIN "dwm2-cobi-us.gbc", $08C2CA, $D8

; compressed sprite graphics of monster id $10D (Copycat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Copycat::
    INCBIN "dwm2-cobi-us.gbc", $08C3A2, $FD

; compressed sprite graphics of monster id $10E (MadSpirit) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadSpirit::
    INCBIN "dwm2-cobi-us.gbc", $08C49F, $E2

; compressed sprite graphics of monster id $10F (PomPomBom) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PomBom::
    INCBIN "dwm2-cobi-us.gbc", $08C581, $CF

; compressed sprite graphics of monster id $110 (Niterich) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Niterich::
    INCBIN "dwm2-cobi-us.gbc", $08C650, $F5

; compressed sprite graphics of monster id $119 (JewelBag) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_JewelBag::
    INCBIN "dwm2-cobi-us.gbc", $08C745, $F4

; compressed sprite graphics of monster id $11A (EvilWand) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 197 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilWand::
    INCBIN "dwm2-cobi-us.gbc", $08C839, $C5

; compressed sprite graphics of monster id $11B (MadCandle) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadCandle::
    INCBIN "dwm2-cobi-us.gbc", $08C8FE, $DA

; compressed sprite graphics of monster id $11C (CoilBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 192 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CoilBird::
    INCBIN "dwm2-cobi-us.gbc", $08C9D8, $C0

; compressed sprite graphics of monster id $11D (Facer) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 180 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Facer::
    INCBIN "dwm2-cobi-us.gbc", $08CA98, $B4

; compressed sprite graphics of monster id $11E (SpikyBoy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SpikyBoy::
    INCBIN "dwm2-cobi-us.gbc", $08CB4C, $D2

; compressed sprite graphics of monster id $11F (MadMirror) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadMirror::
    INCBIN "dwm2-cobi-us.gbc", $08CC1E, $CB

; compressed sprite graphics of monster id $120 (RogueNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RogueNite::
    INCBIN "dwm2-cobi-us.gbc", $08CCE9, $DB

; compressed sprite graphics of monster id $121 (Puppetor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 177 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Puppetor::
    INCBIN "dwm2-cobi-us.gbc", $08CDC4, $B1

; compressed sprite graphics of monster id $122 (Goopi) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Goopi::
    INCBIN "dwm2-cobi-us.gbc", $08CE75, $E0

; compressed sprite graphics of monster id $123 (Voodoll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 144 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Voodoll::
    INCBIN "dwm2-cobi-us.gbc", $08CF55, $90

; compressed sprite graphics of monster id $124 (MetalDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MetalDrak::
    INCBIN "dwm2-cobi-us.gbc", $08CFE5, $DE

; compressed sprite graphics of monster id $125 (Balzak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 240 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Balzak::
    INCBIN "dwm2-cobi-us.gbc", $08D0C3, $F0

; compressed sprite graphics of monster id $126 (SabreMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SabreMan::
    INCBIN "dwm2-cobi-us.gbc", $08D1B3, $CA

; compressed sprite graphics of monster id $127 (CurseLamp) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 144 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CurseLamp::
    INCBIN "dwm2-cobi-us.gbc", $08D27D, $90

; compressed sprite graphics of monster id $128 (Brushead) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Brushead::
    INCBIN "dwm2-cobi-us.gbc", $08D30D, $F3

; compressed sprite graphics of monster id $129 (Roboster) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Roboster::
    INCBIN "dwm2-cobi-us.gbc", $08D400, $CB

; compressed sprite graphics of monster id $12A (Roboster2) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 183 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Roboster2::
    INCBIN "dwm2-cobi-us.gbc", $08D4CB, $B7

; compressed sprite graphics of monster id $12B (EvilPot) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 141 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilPot::
    INCBIN "dwm2-cobi-us.gbc", $08D582, $8D

; compressed sprite graphics of monster id $12C (Gismo) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gismo::
    INCBIN "dwm2-cobi-us.gbc", $08D60F, $CA

; compressed sprite graphics of monster id $12D (LavaMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 204 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LavaMan::
    INCBIN "dwm2-cobi-us.gbc", $08D6D9, $CC

; compressed sprite graphics of monster id $12E (IceMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_IceMan::
    INCBIN "dwm2-cobi-us.gbc", $08D7A5, $CC

; compressed sprite graphics of monster id $12F (Mimic) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 199 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mimic::
    INCBIN "dwm2-cobi-us.gbc", $08D871, $C7

; compressed sprite graphics of monster id $130 (Exaucers) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Exaucers::
    INCBIN "dwm2-cobi-us.gbc", $08D938, $F2

; compressed sprite graphics of monster id $131 (MudDoll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MudDoll::
    INCBIN "dwm2-cobi-us.gbc", $08DA2A, $E3

; compressed sprite graphics of monster id $132 (Golem) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Golem::
    INCBIN "dwm2-cobi-us.gbc", $08DB0D, $EC

; compressed sprite graphics of monster id $133 (StoneMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 259 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_StoneMan::
    INCBIN "dwm2-cobi-us.gbc", $08DBF9, $103

; compressed sprite graphics of monster id $134 (BombCrag) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 134 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BombCrag::
    INCBIN "dwm2-cobi-us.gbc", $08DCFC, $86

; compressed sprite graphics of monster id $135 (GoldGolem) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoldGolem::
    INCBIN "dwm2-cobi-us.gbc", $08DD82, $F7

; compressed sprite graphics of monster id $136 (DarkMate) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 133 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkMate::
    INCBIN "dwm2-cobi-us.gbc", $08DE79, $85

; compressed sprite graphics of monster id $137 (ProtoMech) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ProtoMech::
    INCBIN "dwm2-cobi-us.gbc", $08DEFE, $DD

; compressed sprite graphics of monster id $138 (CloudKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CloudKing::
    INCBIN "dwm2-cobi-us.gbc", $08DFDB, $D3

; compressed sprite graphics of monster id $13C (Petiteel) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Petiteel::
    INCBIN "dwm2-cobi-us.gbc", $08E0AE, $E1

; compressed sprite graphics of monster id $13D (Moray) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 223 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Moray::
    INCBIN "dwm2-cobi-us.gbc", $08E18F, $DF

; compressed sprite graphics of monster id $13E (WalrusMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WalrusMan::
    INCBIN "dwm2-cobi-us.gbc", $08E26E, $E0

; compressed sprite graphics of monster id $13F (RayGigas) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RayGigas::
    INCBIN "dwm2-cobi-us.gbc", $08E34E, $EF

; compressed sprite graphics of monster id $140 (Anemon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 194 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Anemon::
    INCBIN "dwm2-cobi-us.gbc", $08E43D, $C2

; compressed sprite graphics of monster id $141 (Aquarella) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 190 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Aquarella::
    INCBIN "dwm2-cobi-us.gbc", $08E4FF, $BE

; compressed sprite graphics of monster id $142 (Merman) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 217 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Merman::
    INCBIN "dwm2-cobi-us.gbc", $08E5BD, $D9

; compressed sprite graphics of monster id $143 (Octokid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 151 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octokid::
    INCBIN "dwm2-cobi-us.gbc", $08E696, $97

; compressed sprite graphics of monster id $144 (PutreFish) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PutreFish::
    INCBIN "dwm2-cobi-us.gbc", $08E72D, $E9

; compressed sprite graphics of monster id $145 (Octoreach) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 133 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octoreach::
    INCBIN "dwm2-cobi-us.gbc", $08E816, $85

; compressed sprite graphics of monster id $146 (Angleron) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Angleron::
    INCBIN "dwm2-cobi-us.gbc", $08E89B, $CF

; compressed sprite graphics of monster id $147 (FishRider) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FishRider::
    INCBIN "dwm2-cobi-us.gbc", $08E96A, $FD

; compressed sprite graphics of monster id $148 (RushFish) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RushFish::
    INCBIN "dwm2-cobi-us.gbc", $08EA67, $DC

; compressed sprite graphics of monster id $149 (Gamanian) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gamanian::
    INCBIN "dwm2-cobi-us.gbc", $08EB43, $DD

; compressed sprite graphics of monster id $14A (Clawster) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 234 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Clawster::
    INCBIN "dwm2-cobi-us.gbc", $08EC20, $EA

; compressed sprite graphics of monster id $14B (CancerMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CancerMan::
    INCBIN "dwm2-cobi-us.gbc", $08ED0A, $D7

; compressed sprite graphics of monster id $14C (RogueWave) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 251 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RogueWave::
    INCBIN "dwm2-cobi-us.gbc", $08EDE1, $FB

; compressed sprite graphics of monster id $14D (Scallopa) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 204 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Scallopa::
    INCBIN "dwm2-cobi-us.gbc", $08EEDC, $CC

; compressed sprite graphics of monster id $14E (SeaHorse) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SeaHorse::
    INCBIN "dwm2-cobi-us.gbc", $08EFA8, $DA

; compressed sprite graphics of monster id $14F (HoodSquid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HoodSquid::
    INCBIN "dwm2-cobi-us.gbc", $08F082, $F7

; compressed sprite graphics of monster id $150 (MerTiger) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MerTiger::
    INCBIN "dwm2-cobi-us.gbc", $08F179, $E6

; compressed sprite graphics of monster id $151 (AxeShark) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 191 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AxeShark::
    INCBIN "dwm2-cobi-us.gbc", $08F25F, $BF

; compressed sprite graphics of monster id $152 (Octogon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octogon::
    INCBIN "dwm2-cobi-us.gbc", $08F31E, $E8

; compressed sprite graphics of monster id $153 (KingSquid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KingSquid::
    INCBIN "dwm2-cobi-us.gbc", $08F406, $E3

; compressed sprite graphics of monster id $154 (Digong) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Digong::
    INCBIN "dwm2-cobi-us.gbc", $08F4E9, $F5

; compressed sprite graphics of monster id $155 (WhaleMage) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 157 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WhaleMage::
    INCBIN "dwm2-cobi-us.gbc", $08F5DE, $9D

; compressed sprite graphics of monster id $156 (Aquadon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Aquadon::
    INCBIN "dwm2-cobi-us.gbc", $08F67B, $DC

; compressed sprite graphics of monster id $157 (Octoraid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octoraid::
    INCBIN "dwm2-cobi-us.gbc", $08F757, $DE

; compressed sprite graphics of monster id $158 (Grakos) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 240 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Grakos::
    INCBIN "dwm2-cobi-us.gbc", $08F835, $F0

; compressed sprite graphics of monster id $159 (Poseidon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Poseidon::
    INCBIN "dwm2-cobi-us.gbc", $08F925, $E8

; compressed sprite graphics of monster id $15A (Pumpoise) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pumpoise::
    INCBIN "dwm2-cobi-us.gbc", $08FA0D, $E3

; compressed sprite graphics of monster id $15B (Starfish) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Starfish::
    INCBIN "dwm2-cobi-us.gbc", $08FAF0, $E3
    ds $42d, $00
