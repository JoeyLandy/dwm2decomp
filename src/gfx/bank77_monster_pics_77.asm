; ROM bank $77: compressed monster pictures
; The annotated listing of this bank is build/listing/bank77.asm.

SECTION "Bank 77", ROMX
    db $77

; compressed 6 x 6 picture (36 tiles) of monster id $06A (Picky) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Picky::
    INCBIN "gfx/monster_pics/picky.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A3 (Egdracil) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 509 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Egdracil::
    INCBIN "gfx/monster_pics/egdracil.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A4 (Warubou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 323 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Warubou::
    INCBIN "gfx/monster_pics/warubou.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A5 (Watabou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 264 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Watabou::
    INCBIN "gfx/monster_pics/watabou.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A6 (Eggplaton) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 232 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Eggplaton::
    INCBIN "gfx/monster_pics/eggplaton.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A7 (FooHero) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 223 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FooHero::
    INCBIN "gfx/monster_pics/foo_hero.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B0 (GiantSlug) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 250 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GiantSlug::
    INCBIN "gfx/monster_pics/giant_slug.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B1 (Catapila) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 234 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Catapila::
    INCBIN "gfx/monster_pics/catapila.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B2 (Gophecada) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 174 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gophecada::
    INCBIN "gfx/monster_pics/gophecada.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B3 (Butterfly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 268 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Butterfly::
    INCBIN "gfx/monster_pics/butterfly.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B4 (WeedBug) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 288 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WeedBug::
    INCBIN "gfx/monster_pics/weed_bug.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B5 (GiantWorm) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 256 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GiantWorm::
    INCBIN "gfx/monster_pics/giant_worm.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B6 (Lipsy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 218 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Lipsy::
    INCBIN "gfx/monster_pics/lipsy.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B7 (StagBug) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 253 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_StagBug::
    INCBIN "gfx/monster_pics/stag_bug.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B8 (Pyuro) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 445 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pyuro::
    INCBIN "gfx/monster_pics/pyuro.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0B9 (ArmyAnt) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 199 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArmyAnt::
    INCBIN "gfx/monster_pics/army_ant.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0BA (GoHopper) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 158 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoHopper::
    INCBIN "gfx/monster_pics/go_hopper.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0BB (TailEater) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 299 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TailEater::
    INCBIN "gfx/monster_pics/tail_eater.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0BC (ArmorPede) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 231 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArmorPede::
    INCBIN "gfx/monster_pics/armor_pede.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0BD (Eyeder) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 204 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Eyeder::
    INCBIN "gfx/monster_pics/eyeder.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0BE (GiantMoth) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 338 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GiantMoth::
    INCBIN "gfx/monster_pics/giant_moth.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0BF (Droll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 281 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Droll::
    INCBIN "gfx/monster_pics/droll.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C0 (ArmyCrab) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 295 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArmyCrab::
    INCBIN "gfx/monster_pics/army_crab.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C1 (MadHornet) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 346 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadHornet::
    INCBIN "gfx/monster_pics/mad_hornet.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C2 (Belzebub) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 391 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Belzebub::
    INCBIN "gfx/monster_pics/belzebub.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C3 (WarMantis) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 393 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WarMantis::
    INCBIN "gfx/monster_pics/war_mantis.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C4 (HornBeet) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 335 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HornBeet::
    INCBIN "gfx/monster_pics/horn_beet.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C5 (Sickler) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 280 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Sickler::
    INCBIN "gfx/monster_pics/sickler.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C6 (Armorpion) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 392 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Armorpion::
    INCBIN "gfx/monster_pics/armorpion.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C7 (Digster) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 429 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Digster::
    INCBIN "gfx/monster_pics/digster.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C8 (Skularach) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 412 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skularach::
    INCBIN "gfx/monster_pics/skularach.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0C9 (MultiEyes) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 456 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MultiEyes::
    INCBIN "gfx/monster_pics/multi_eyes.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $13C (Petiteel) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 222 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Petiteel::
    INCBIN "gfx/monster_pics/petiteel.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $13D (Moray) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 316 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Moray::
    INCBIN "gfx/monster_pics/moray.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $13E (WalrusMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 459 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WalrusMan::
    INCBIN "gfx/monster_pics/walrus_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $13F (RayGigas) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 309 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RayGigas::
    INCBIN "gfx/monster_pics/ray_gigas.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $140 (Anemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 324 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Anemon::
    INCBIN "gfx/monster_pics/anemon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $141 (Aquarella) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 300 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Aquarella::
    INCBIN "gfx/monster_pics/aquarella.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $142 (Merman) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 275 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Merman::
    INCBIN "gfx/monster_pics/merman.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $143 (Octokid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 293 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octokid::
    INCBIN "gfx/monster_pics/octokid.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $144 (PutreFish) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 215 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PutreFish::
    INCBIN "gfx/monster_pics/putre_fish.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $145 (Octoreach) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 281 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octoreach::
    INCBIN "gfx/monster_pics/octoreach.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $146 (Angleron) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 290 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Angleron::
    INCBIN "gfx/monster_pics/angleron.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $147 (FishRider) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 367 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FishRider::
    INCBIN "gfx/monster_pics/fish_rider.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $148 (RushFish) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 278 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RushFish::
    INCBIN "gfx/monster_pics/rush_fish.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $149 (Gamanian) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 282 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gamanian::
    INCBIN "gfx/monster_pics/gamanian.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $14A (Clawster) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 443 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Clawster::
    INCBIN "gfx/monster_pics/clawster.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $14B (CancerMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 371 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CancerMan::
    INCBIN "gfx/monster_pics/cancer_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $14C (RogueWave) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RogueWave::
    INCBIN "gfx/monster_pics/rogue_wave.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $14D (Scallopa) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 242 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Scallopa::
    INCBIN "gfx/monster_pics/scallopa.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $14E (SeaHorse) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 288 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SeaHorse::
    INCBIN "gfx/monster_pics/sea_horse.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $14F (HoodSquid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 497 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HoodSquid::
    INCBIN "gfx/monster_pics/hood_squid.lz"
    ds $d3, $00
