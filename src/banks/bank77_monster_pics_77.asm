; ROM bank $77: compressed monster pictures
; The annotated listing of this bank is build/listing/bank77.asm.

SECTION "Bank 77", ROMX[$4000], BANK[$77]
    db $77

; compressed 6 x 6 picture (36 tiles) of monster id $06A (Picky) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Picky::
    INCBIN "dwm2-cobi-us.gbc", $1DC001, $174

; compressed 6 x 6 picture (36 tiles) of monster id $0A3 (Egdracil) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 509 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Egdracil::
    INCBIN "dwm2-cobi-us.gbc", $1DC175, $1FD

; compressed 6 x 6 picture (36 tiles) of monster id $0A4 (Warubou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 323 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Warubou::
    INCBIN "dwm2-cobi-us.gbc", $1DC372, $143

; compressed 6 x 6 picture (36 tiles) of monster id $0A5 (Watabou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 264 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Watabou::
    INCBIN "dwm2-cobi-us.gbc", $1DC4B5, $108

; compressed 6 x 6 picture (36 tiles) of monster id $0A6 (Eggplaton) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 232 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Eggplaton::
    INCBIN "dwm2-cobi-us.gbc", $1DC5BD, $E8

; compressed 6 x 6 picture (36 tiles) of monster id $0A7 (FooHero) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 223 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FooHero::
    INCBIN "dwm2-cobi-us.gbc", $1DC6A5, $DF

; compressed 6 x 6 picture (36 tiles) of monster id $0B0 (GiantSlug) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 250 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GiantSlug::
    INCBIN "dwm2-cobi-us.gbc", $1DC784, $FA

; compressed 6 x 6 picture (36 tiles) of monster id $0B1 (Catapila) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 234 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Catapila::
    INCBIN "dwm2-cobi-us.gbc", $1DC87E, $EA

; compressed 6 x 6 picture (36 tiles) of monster id $0B2 (Gophecada) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 174 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gophecada::
    INCBIN "dwm2-cobi-us.gbc", $1DC968, $AE

; compressed 6 x 6 picture (36 tiles) of monster id $0B3 (Butterfly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 268 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Butterfly::
    INCBIN "dwm2-cobi-us.gbc", $1DCA16, $10C

; compressed 6 x 6 picture (36 tiles) of monster id $0B4 (WeedBug) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 288 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WeedBug::
    INCBIN "dwm2-cobi-us.gbc", $1DCB22, $120

; compressed 6 x 6 picture (36 tiles) of monster id $0B5 (GiantWorm) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 256 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GiantWorm::
    INCBIN "dwm2-cobi-us.gbc", $1DCC42, $100

; compressed 6 x 6 picture (36 tiles) of monster id $0B6 (Lipsy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 218 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Lipsy::
    INCBIN "dwm2-cobi-us.gbc", $1DCD42, $DA

; compressed 6 x 6 picture (36 tiles) of monster id $0B7 (StagBug) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 253 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_StagBug::
    INCBIN "dwm2-cobi-us.gbc", $1DCE1C, $FD

; compressed 6 x 6 picture (36 tiles) of monster id $0B8 (Pyuro) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 445 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pyuro::
    INCBIN "dwm2-cobi-us.gbc", $1DCF19, $1BD

; compressed 6 x 6 picture (36 tiles) of monster id $0B9 (ArmyAnt) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 199 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArmyAnt::
    INCBIN "dwm2-cobi-us.gbc", $1DD0D6, $C7

; compressed 6 x 6 picture (36 tiles) of monster id $0BA (GoHopper) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 158 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoHopper::
    INCBIN "dwm2-cobi-us.gbc", $1DD19D, $9E

; compressed 6 x 6 picture (36 tiles) of monster id $0BB (TailEater) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 299 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TailEater::
    INCBIN "dwm2-cobi-us.gbc", $1DD23B, $12B

; compressed 6 x 6 picture (36 tiles) of monster id $0BC (ArmorPede) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 231 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArmorPede::
    INCBIN "dwm2-cobi-us.gbc", $1DD366, $E7

; compressed 6 x 6 picture (36 tiles) of monster id $0BD (Eyeder) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 204 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Eyeder::
    INCBIN "dwm2-cobi-us.gbc", $1DD44D, $CC

; compressed 6 x 6 picture (36 tiles) of monster id $0BE (GiantMoth) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 338 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GiantMoth::
    INCBIN "dwm2-cobi-us.gbc", $1DD519, $152

; compressed 6 x 6 picture (36 tiles) of monster id $0BF (Droll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 281 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Droll::
    INCBIN "dwm2-cobi-us.gbc", $1DD66B, $119

; compressed 6 x 6 picture (36 tiles) of monster id $0C0 (ArmyCrab) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 295 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArmyCrab::
    INCBIN "dwm2-cobi-us.gbc", $1DD784, $127

; compressed 6 x 6 picture (36 tiles) of monster id $0C1 (MadHornet) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 346 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadHornet::
    INCBIN "dwm2-cobi-us.gbc", $1DD8AB, $15A

; compressed 6 x 6 picture (36 tiles) of monster id $0C2 (Belzebub) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 391 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Belzebub::
    INCBIN "dwm2-cobi-us.gbc", $1DDA05, $187

; compressed 6 x 6 picture (36 tiles) of monster id $0C3 (WarMantis) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 393 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WarMantis::
    INCBIN "dwm2-cobi-us.gbc", $1DDB8C, $189

; compressed 6 x 6 picture (36 tiles) of monster id $0C4 (HornBeet) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 335 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HornBeet::
    INCBIN "dwm2-cobi-us.gbc", $1DDD15, $14F

; compressed 6 x 6 picture (36 tiles) of monster id $0C5 (Sickler) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 280 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Sickler::
    INCBIN "dwm2-cobi-us.gbc", $1DDE64, $118

; compressed 6 x 6 picture (36 tiles) of monster id $0C6 (Armorpion) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 392 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Armorpion::
    INCBIN "dwm2-cobi-us.gbc", $1DDF7C, $188

; compressed 6 x 6 picture (36 tiles) of monster id $0C7 (Digster) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 429 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Digster::
    INCBIN "dwm2-cobi-us.gbc", $1DE104, $1AD

; compressed 6 x 6 picture (36 tiles) of monster id $0C8 (Skularach) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 412 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skularach::
    INCBIN "dwm2-cobi-us.gbc", $1DE2B1, $19C

; compressed 6 x 6 picture (36 tiles) of monster id $0C9 (MultiEyes) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 456 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MultiEyes::
    INCBIN "dwm2-cobi-us.gbc", $1DE44D, $1C8

; compressed 6 x 6 picture (36 tiles) of monster id $13C (Petiteel) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 222 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Petiteel::
    INCBIN "dwm2-cobi-us.gbc", $1DE615, $DE

; compressed 6 x 6 picture (36 tiles) of monster id $13D (Moray) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 316 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Moray::
    INCBIN "dwm2-cobi-us.gbc", $1DE6F3, $13C

; compressed 6 x 6 picture (36 tiles) of monster id $13E (WalrusMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 459 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WalrusMan::
    INCBIN "dwm2-cobi-us.gbc", $1DE82F, $1CB

; compressed 6 x 6 picture (36 tiles) of monster id $13F (RayGigas) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 309 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RayGigas::
    INCBIN "dwm2-cobi-us.gbc", $1DE9FA, $135

; compressed 6 x 6 picture (36 tiles) of monster id $140 (Anemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 324 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Anemon::
    INCBIN "dwm2-cobi-us.gbc", $1DEB2F, $144

; compressed 6 x 6 picture (36 tiles) of monster id $141 (Aquarella) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 300 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Aquarella::
    INCBIN "dwm2-cobi-us.gbc", $1DEC73, $12C

; compressed 6 x 6 picture (36 tiles) of monster id $142 (Merman) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 275 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Merman::
    INCBIN "dwm2-cobi-us.gbc", $1DED9F, $113

; compressed 6 x 6 picture (36 tiles) of monster id $143 (Octokid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 293 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octokid::
    INCBIN "dwm2-cobi-us.gbc", $1DEEB2, $125

; compressed 6 x 6 picture (36 tiles) of monster id $144 (PutreFish) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 215 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PutreFish::
    INCBIN "dwm2-cobi-us.gbc", $1DEFD7, $D7

; compressed 6 x 6 picture (36 tiles) of monster id $145 (Octoreach) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 281 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octoreach::
    INCBIN "dwm2-cobi-us.gbc", $1DF0AE, $119

; compressed 6 x 6 picture (36 tiles) of monster id $146 (Angleron) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 290 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Angleron::
    INCBIN "dwm2-cobi-us.gbc", $1DF1C7, $122

; compressed 6 x 6 picture (36 tiles) of monster id $147 (FishRider) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 367 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FishRider::
    INCBIN "dwm2-cobi-us.gbc", $1DF2E9, $16F

; compressed 6 x 6 picture (36 tiles) of monster id $148 (RushFish) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 278 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RushFish::
    INCBIN "dwm2-cobi-us.gbc", $1DF458, $116

; compressed 6 x 6 picture (36 tiles) of monster id $149 (Gamanian) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 282 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gamanian::
    INCBIN "dwm2-cobi-us.gbc", $1DF56E, $11A

; compressed 6 x 6 picture (36 tiles) of monster id $14A (Clawster) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 443 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Clawster::
    INCBIN "dwm2-cobi-us.gbc", $1DF688, $1BB

; compressed 6 x 6 picture (36 tiles) of monster id $14B (CancerMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 371 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CancerMan::
    INCBIN "dwm2-cobi-us.gbc", $1DF843, $173

; compressed 6 x 6 picture (36 tiles) of monster id $14C (RogueWave) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RogueWave::
    INCBIN "dwm2-cobi-us.gbc", $1DF9B6, $174

; compressed 6 x 6 picture (36 tiles) of monster id $14D (Scallopa) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 242 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Scallopa::
    INCBIN "dwm2-cobi-us.gbc", $1DFB2A, $F2

; compressed 6 x 6 picture (36 tiles) of monster id $14E (SeaHorse) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 288 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SeaHorse::
    INCBIN "dwm2-cobi-us.gbc", $1DFC1C, $120

; compressed 6 x 6 picture (36 tiles) of monster id $14F (HoodSquid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 497 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HoodSquid::
    INCBIN "dwm2-cobi-us.gbc", $1DFD3C, $1F1
    ds $d3, $00
