; ROM bank $22: compressed monster sprites
; The annotated listing of this bank is build/listing/bank22.asm.

SECTION "Bank 22", ROMX[$4000], BANK[$22]
    db $22

; compressed sprite graphics of monster id $0B8 (Pyuro) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pyuro::
    INCBIN "gfx/monster_sprites/pyuro.lz"

; compressed sprite graphics of monster id $0B9 (ArmyAnt) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 199 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArmyAnt::
    INCBIN "gfx/monster_sprites/army_ant.lz"

; compressed sprite graphics of monster id $0BA (GoHopper) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 181 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoHopper::
    INCBIN "gfx/monster_sprites/go_hopper.lz"

; compressed sprite graphics of monster id $0BB (TailEater) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TailEater::
    INCBIN "gfx/monster_sprites/tail_eater.lz"

; compressed sprite graphics of monster id $0BC (ArmorPede) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArmorPede::
    INCBIN "gfx/monster_sprites/armor_pede.lz"

; compressed sprite graphics of monster id $0BD (Eyeder) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Eyeder::
    INCBIN "gfx/monster_sprites/eyeder.lz"

; compressed sprite graphics of monster id $0BE (GiantMoth) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GiantMoth::
    INCBIN "gfx/monster_sprites/giant_moth.lz"

; compressed sprite graphics of monster id $0BF (Droll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Droll::
    INCBIN "gfx/monster_sprites/droll.lz"

; compressed sprite graphics of monster id $0C0 (ArmyCrab) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArmyCrab::
    INCBIN "gfx/monster_sprites/army_crab.lz"

; compressed sprite graphics of monster id $0C1 (MadHornet) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadHornet::
    INCBIN "gfx/monster_sprites/mad_hornet.lz"

; compressed sprite graphics of monster id $0C2 (Belzebub) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Belzebub::
    INCBIN "gfx/monster_sprites/belzebub.lz"

; compressed sprite graphics of monster id $0C3 (WarMantis) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 234 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WarMantis::
    INCBIN "gfx/monster_sprites/war_mantis.lz"

; compressed sprite graphics of monster id $0C4 (HornBeet) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 183 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HornBeet::
    INCBIN "gfx/monster_sprites/horn_beet.lz"

; compressed sprite graphics of monster id $0C5 (Sickler) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Sickler::
    INCBIN "gfx/monster_sprites/sickler.lz"

; compressed sprite graphics of monster id $0C6 (Armorpion) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 246 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Armorpion::
    INCBIN "gfx/monster_sprites/armorpion.lz"

; compressed sprite graphics of monster id $0C7 (Digster) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Digster::
    INCBIN "gfx/monster_sprites/digster.lz"

; compressed sprite graphics of monster id $0C8 (Skularach) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skularach::
    INCBIN "gfx/monster_sprites/skularach.lz"

; compressed sprite graphics of monster id $0C9 (MultiEyes) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 252 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MultiEyes::
    INCBIN "gfx/monster_sprites/multi_eyes.lz"

; compressed sprite graphics of monster id $0D3 (Pixy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 187 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pixy::
    INCBIN "gfx/monster_sprites/pixy.lz"

; compressed sprite graphics of monster id $0D4 (MedusaEye) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MedusaEye::
    INCBIN "gfx/monster_sprites/medusa_eye.lz"

; compressed sprite graphics of monster id $0D5 (AgDevil) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AgDevil::
    INCBIN "gfx/monster_sprites/ag_devil.lz"

; compressed sprite graphics of monster id $0D6 (Demonite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 201 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Demonite::
    INCBIN "gfx/monster_sprites/demonite.lz"

; compressed sprite graphics of monster id $0D7 (DarkEye) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 197 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkEye::
    INCBIN "gfx/monster_sprites/dark_eye.lz"

; compressed sprite graphics of monster id $0D8 (EyeBall) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EyeBall::
    INCBIN "gfx/monster_sprites/eye_ball.lz"

; compressed sprite graphics of monster id $0D9 (SkulRider) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 208 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SkulRider::
    INCBIN "gfx/monster_sprites/skul_rider.lz"

; compressed sprite graphics of monster id $0DA (EvilBeast) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 257 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilBeast::
    INCBIN "gfx/monster_sprites/evil_beast.lz"

; compressed sprite graphics of monster id $0DB (Bubblemon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Bubblemon::
    INCBIN "gfx/monster_sprites/bubblemon.lz"

; compressed sprite graphics of monster id $0DC (1EyeClown) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_1EyeClown::
    INCBIN "gfx/monster_sprites/1_eye_clown.lz"

; compressed sprite graphics of monster id $0DD (Gremlin) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 174 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gremlin::
    INCBIN "gfx/monster_sprites/gremlin.lz"

; compressed sprite graphics of monster id $0DE (ArcDemon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArcDemon::
    INCBIN "gfx/monster_sprites/arc_demon.lz"

; compressed sprite graphics of monster id $0DF (Lionex) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 254 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lionex::
    INCBIN "gfx/monster_sprites/lionex.lz"

; compressed sprite graphics of monster id $0E0 (GoatHorn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoatHorn::
    INCBIN "gfx/monster_sprites/goat_horn.lz"

; compressed sprite graphics of monster id $0E1 (Orc) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_Orc::
    INCBIN "gfx/monster_sprites/orc.lz"

; compressed sprite graphics of monster id $0E2 (Ogre) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Ogre::
    INCBIN "gfx/monster_sprites/ogre.lz"

; compressed sprite graphics of monster id $0E3 (GateGuard) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GateGuard::
    INCBIN "gfx/monster_sprites/gate_guard.lz"

; compressed sprite graphics of monster id $0E4 (ChopClown) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ChopClown::
    INCBIN "gfx/monster_sprites/chop_clown.lz"

; compressed sprite graphics of monster id $0E5 (BossTroll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BossTroll::
    INCBIN "gfx/monster_sprites/boss_troll.lz"

; compressed sprite graphics of monster id $0E6 (Grendal) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Grendal::
    INCBIN "gfx/monster_sprites/grendal.lz"

; compressed sprite graphics of monster id $0E7 (Akubar) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 256 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Akubar::
    INCBIN "gfx/monster_sprites/akubar.lz"

; compressed sprite graphics of monster id $0E8 (MadKnight) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 251 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadKnight::
    INCBIN "gfx/monster_sprites/mad_knight.lz"

; compressed sprite graphics of monster id $0E9 (EvilWell) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilWell::
    INCBIN "gfx/monster_sprites/evil_well.lz"

; compressed sprite graphics of monster id $0EA (Gigantes) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_Gigantes::
    INCBIN "gfx/monster_sprites/gigantes.lz"

; compressed sprite graphics of monster id $0EB (Centasaur) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Centasaur::
    INCBIN "gfx/monster_sprites/centasaur.lz"

; compressed sprite graphics of monster id $0EC (EvilArmor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilArmor::
    INCBIN "gfx/monster_sprites/evil_armor.lz"

; compressed sprite graphics of monster id $0ED (Jamirus) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Jamirus::
    INCBIN "gfx/monster_sprites/jamirus.lz"

; compressed sprite graphics of monster id $0EE (Durran) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 255 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Durran::
    INCBIN "gfx/monster_sprites/durran.lz"

; compressed sprite graphics of monster id $0EF (Titanis) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Titanis::
    INCBIN "gfx/monster_sprites/titanis.lz"

; compressed sprite graphics of monster id $0F0 (LampGenie) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 197 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LampGenie::
    INCBIN "gfx/monster_sprites/lamp_genie.lz"

; compressed sprite graphics of monster id $0F6 (Spooky) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_Spooky::
    INCBIN "gfx/monster_sprites/spooky.lz"

; compressed sprite graphics of monster id $0F7 (Skullgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 257 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skullgon::
    INCBIN "gfx/monster_sprites/skullgon.lz"

; compressed sprite graphics of monster id $0F8 (PutrePup) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PutrePup::
    INCBIN "gfx/monster_sprites/putre_pup.lz"

; compressed sprite graphics of monster id $0F9 (RotRaven) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RotRaven::
    INCBIN "gfx/monster_sprites/rot_raven.lz"

; compressed sprite graphics of monster id $0FA (Mummy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mummy::
    INCBIN "gfx/monster_sprites/mummy.lz"

; compressed sprite graphics of monster id $0FB (DarkCrab) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkCrab::
    INCBIN "gfx/monster_sprites/dark_crab.lz"

; compressed sprite graphics of monster id $0FC (DeadNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DeadNite::
    INCBIN "gfx/monster_sprites/dead_nite.lz"

; compressed sprite graphics of monster id $0FD (Shadow) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 180 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Shadow::
    INCBIN "gfx/monster_sprites/shadow.lz"

; compressed sprite graphics of monster id $0FE (Skulpent) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skulpent::
    INCBIN "gfx/monster_sprites/skulpent.lz"

; compressed sprite graphics of monster id $0FF (Hork) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Hork::
    INCBIN "gfx/monster_sprites/hork.lz"

; compressed sprite graphics of monster id $100 (Mudron) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mudron::
    INCBIN "gfx/monster_sprites/mudron.lz"

; compressed sprite graphics of monster id $101 (NiteWhip) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 238 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_NiteWhip::
    INCBIN "gfx/monster_sprites/nite_whip.lz"

; compressed sprite graphics of monster id $102 (WindMerge) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WindMerge::
    INCBIN "gfx/monster_sprites/wind_merge.lz"

; compressed sprite graphics of monster id $103 (Reaper) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 182 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Reaper::
    INCBIN "gfx/monster_sprites/reaper.lz"

; compressed sprite graphics of monster id $104 (Inverzon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Inverzon::
    INCBIN "gfx/monster_sprites/inverzon.lz"

; compressed sprite graphics of monster id $105 (FoxFire) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FoxFire::
    INCBIN "gfx/monster_sprites/fox_fire.lz"

; compressed sprite graphics of monster id $106 (CaptDead) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_CaptDead::
    INCBIN "gfx/monster_sprites/capt_dead.lz"

; compressed sprite graphics of monster id $107 (DeadNoble) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 249 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DeadNoble::
    INCBIN "gfx/monster_sprites/dead_noble.lz"

; compressed sprite graphics of monster id $108 (WhiteKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WhiteKing::
    INCBIN "gfx/monster_sprites/white_king.lz"

; compressed sprite graphics of monster id $17C (Lamia) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lamia::
    INCBIN "gfx/monster_sprites/lamia.lz"

; compressed sprite graphics of monster id $17D (Dimensaur) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dimensaur::
    INCBIN "gfx/monster_sprites/dimensaur.lz"

; compressed sprite graphics of monster id $17E (Kagebou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 195 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Kagebou::
    INCBIN "gfx/monster_sprites/kagebou.lz"
    ds $327, $00
