; ROM bank $21: compressed monster sprites
; The annotated listing of this bank is build/listing/bank21.asm.

SECTION "Bank 21", ROMX[$4000], BANK[$21]
    db $21

; compressed sprite graphics of monster id $05A (MadGopher) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadGopher::
    INCBIN "gfx/monster_sprites/mad_gopher.lz"

; compressed sprite graphics of monster id $05B (FairyRat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 191 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FairyRat::
    INCBIN "gfx/monster_sprites/fairy_rat.lz"

; compressed sprite graphics of monster id $05C (Unicorn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Unicorn::
    INCBIN "gfx/monster_sprites/unicorn.lz"

; compressed sprite graphics of monster id $05D (Goategon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 184 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Goategon::
    INCBIN "gfx/monster_sprites/goategon.lz"

; compressed sprite graphics of monster id $05E (WildApe) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WildApe::
    INCBIN "gfx/monster_sprites/wild_ape.lz"

; compressed sprite graphics of monster id $05F (Trumpeter) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Trumpeter::
    INCBIN "gfx/monster_sprites/trumpeter.lz"

; compressed sprite graphics of monster id $060 (KingLeo) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KingLeo::
    INCBIN "gfx/monster_sprites/king_leo.lz"

; compressed sprite graphics of monster id $061 (DarkHorn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkHorn::
    INCBIN "gfx/monster_sprites/dark_horn.lz"

; compressed sprite graphics of monster id $062 (MadCat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 212 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadCat::
    INCBIN "gfx/monster_sprites/mad_cat.lz"

; compressed sprite graphics of monster id $063 (BigEye) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BigEye::
    INCBIN "gfx/monster_sprites/big_eye.lz"

; compressed sprite graphics of monster id $064 (Gorago) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gorago::
    INCBIN "gfx/monster_sprites/gorago.lz"

; compressed sprite graphics of monster id $065 (CatMage) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CatMage::
    INCBIN "gfx/monster_sprites/cat_mage.lz"

; compressed sprite graphics of monster id $066 (Dumbira) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dumbira::
    INCBIN "gfx/monster_sprites/dumbira.lz"

; compressed sprite graphics of monster id $06A (Picky) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Picky::
    INCBIN "gfx/monster_sprites/picky.lz"

; compressed sprite graphics of monster id $06B (Wyvern) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 188 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Wyvern::
    INCBIN "gfx/monster_sprites/wyvern.lz"

; compressed sprite graphics of monster id $06C (BullBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BullBird::
    INCBIN "gfx/monster_sprites/bull_bird.lz"

; compressed sprite graphics of monster id $06D (Florajay) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Florajay::
    INCBIN "gfx/monster_sprites/florajay.lz"

; compressed sprite graphics of monster id $06E (DuckKite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 130 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DuckKite::
    INCBIN "gfx/monster_sprites/duck_kite.lz"

; compressed sprite graphics of monster id $06F (MadPecker) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadPecker::
    INCBIN "gfx/monster_sprites/mad_pecker.lz"

; compressed sprite graphics of monster id $070 (MadRaven) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 186 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadRaven::
    INCBIN "gfx/monster_sprites/mad_raven.lz"

; compressed sprite graphics of monster id $071 (MistyWing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 115 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MistyWing::
    INCBIN "gfx/monster_sprites/misty_wing.lz"

; compressed sprite graphics of monster id $072 (AquaHawk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AquaHawk::
    INCBIN "gfx/monster_sprites/aqua_hawk.lz"

; compressed sprite graphics of monster id $073 (Dracky) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 193 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dracky::
    INCBIN "gfx/monster_sprites/dracky.lz"

; compressed sprite graphics of monster id $074 (KiteHawk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 205 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KiteHawk::
    INCBIN "gfx/monster_sprites/kite_hawk.lz"

; compressed sprite graphics of monster id $075 (BigRoost) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BigRoost::
    INCBIN "gfx/monster_sprites/big_roost.lz"

; compressed sprite graphics of monster id $076 (StubBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_StubBird::
    INCBIN "gfx/monster_sprites/stub_bird.lz"

; compressed sprite graphics of monster id $077 (LandOwl) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LandOwl::
    INCBIN "gfx/monster_sprites/land_owl.lz"

; compressed sprite graphics of monster id $078 (MadGoose) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadGoose::
    INCBIN "gfx/monster_sprites/mad_goose.lz"

; compressed sprite graphics of monster id $079 (MadCondor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_MadCondor::
    INCBIN "gfx/monster_sprites/mad_condor.lz"

; compressed sprite graphics of monster id $07A (Emyu) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 179 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Emyu::
    INCBIN "gfx/monster_sprites/emyu.lz"

; compressed sprite graphics of monster id $07B (Blizzardy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Blizzardy::
    INCBIN "gfx/monster_sprites/blizzardy.lz"

; compressed sprite graphics of monster id $07C (Phoenix) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Phoenix::
    INCBIN "gfx/monster_sprites/phoenix.lz"

; compressed sprite graphics of monster id $07D (ZapBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_ZapBird::
    INCBIN "gfx/monster_sprites/zap_bird.lz"

; compressed sprite graphics of monster id $07E (Garudian) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 200 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Garudian::
    INCBIN "gfx/monster_sprites/garudian.lz"

; compressed sprite graphics of monster id $07F (WhipBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WhipBird::
    INCBIN "gfx/monster_sprites/whip_bird.lz"

; compressed sprite graphics of monster id $080 (FunkyBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FunkyBird::
    INCBIN "gfx/monster_sprites/funky_bird.lz"

; compressed sprite graphics of monster id $081 (RainHawk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RainHawk::
    INCBIN "gfx/monster_sprites/rain_hawk.lz"

; compressed sprite graphics of monster id $082 (Azurile) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Azurile::
    INCBIN "gfx/monster_sprites/azurile.lz"

; compressed sprite graphics of monster id $083 (Shantak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Shantak::
    INCBIN "gfx/monster_sprites/shantak.lz"

; compressed sprite graphics of monster id $084 (CragDevil) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CragDevil::
    INCBIN "gfx/monster_sprites/crag_devil.lz"

; compressed sprite graphics of monster id $08D (MadPlant) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadPlant::
    INCBIN "gfx/monster_sprites/mad_plant.lz"

; compressed sprite graphics of monster id $08E (FireWeed) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FireWeed::
    INCBIN "gfx/monster_sprites/fire_weed.lz"

; compressed sprite graphics of monster id $08F (FloraMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 169 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FloraMan::
    INCBIN "gfx/monster_sprites/flora_man.lz"

; compressed sprite graphics of monster id $090 (WingTree) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WingTree::
    INCBIN "gfx/monster_sprites/wing_tree.lz"

; compressed sprite graphics of monster id $091 (CactiBall) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CactiBall::
    INCBIN "gfx/monster_sprites/cacti_ball.lz"

; compressed sprite graphics of monster id $092 (Gulpple) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 170 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gulpple::
    INCBIN "gfx/monster_sprites/gulpple.lz"

; compressed sprite graphics of monster id $093 (Toadstool) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 187 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Toadstool::
    INCBIN "gfx/monster_sprites/toadstool.lz"

; compressed sprite graphics of monster id $094 (AmberWeed) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AmberWeed::
    INCBIN "gfx/monster_sprites/amber_weed.lz"

; compressed sprite graphics of monster id $095 (Slurperon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Slurperon::
    INCBIN "gfx/monster_sprites/slurperon.lz"

; compressed sprite graphics of monster id $096 (Stubsuck) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Stubsuck::
    INCBIN "gfx/monster_sprites/stubsuck.lz"

; compressed sprite graphics of monster id $097 (Oniono) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Oniono::
    INCBIN "gfx/monster_sprites/oniono.lz"

; compressed sprite graphics of monster id $098 (DanceVegi) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_DanceVegi::
    INCBIN "gfx/monster_sprites/dance_vegi.lz"

; compressed sprite graphics of monster id $099 (TreeBoy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 171 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TreeBoy::
    INCBIN "gfx/monster_sprites/tree_boy.lz"

; compressed sprite graphics of monster id $09A (Devipine) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Devipine::
    INCBIN "gfx/monster_sprites/devipine.lz"

; compressed sprite graphics of monster id $09B (FaceTree) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 179 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FaceTree::
    INCBIN "gfx/monster_sprites/face_tree.lz"

; compressed sprite graphics of monster id $09C (HerbMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 192 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HerbMan::
    INCBIN "gfx/monster_sprites/herb_man.lz"

; compressed sprite graphics of monster id $09D (BeanMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BeanMan::
    INCBIN "gfx/monster_sprites/bean_man.lz"

; compressed sprite graphics of monster id $09E (EvilSeed) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 185 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilSeed::
    INCBIN "gfx/monster_sprites/evil_seed.lz"

; compressed sprite graphics of monster id $09F (ManEater) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ManEater::
    INCBIN "gfx/monster_sprites/man_eater.lz"

; compressed sprite graphics of monster id $0A0 (Snapper) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 171 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Snapper::
    INCBIN "gfx/monster_sprites/snapper.lz"

; compressed sprite graphics of monster id $0A1 (GhosTree) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 201 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GhosTree::
    INCBIN "gfx/monster_sprites/ghos_tree.lz"

; compressed sprite graphics of monster id $0A2 (Rosevine) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Rosevine::
    INCBIN "gfx/monster_sprites/rosevine.lz"

; compressed sprite graphics of monster id $0A3 (Egdracil) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Egdracil::
    INCBIN "gfx/monster_sprites/egdracil.lz"

; compressed sprite graphics of monster id $0A4 (Warubou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Warubou::
    INCBIN "gfx/monster_sprites/warubou.lz"

; compressed sprite graphics of monster id $0A5 (Watabou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 249 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Watabou::
    INCBIN "gfx/monster_sprites/watabou.lz"

; compressed sprite graphics of monster id $0A6 (Eggplaton) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 167 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Eggplaton::
    INCBIN "gfx/monster_sprites/eggplaton.lz"

; compressed sprite graphics of monster id $0A7 (FooHero) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FooHero::
    INCBIN "gfx/monster_sprites/foo_hero.lz"

; compressed sprite graphics of monster id $0B0 (GiantSlug) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GiantSlug::
    INCBIN "gfx/monster_sprites/giant_slug.lz"

; compressed sprite graphics of monster id $0B1 (Catapila) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Catapila::
    INCBIN "gfx/monster_sprites/catapila.lz"

; compressed sprite graphics of monster id $0B2 (Gophecada) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 187 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gophecada::
    INCBIN "gfx/monster_sprites/gophecada.lz"

; compressed sprite graphics of monster id $0B3 (Butterfly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_Butterfly::
    INCBIN "gfx/monster_sprites/butterfly.lz"

; compressed sprite graphics of monster id $0B4 (WeedBug) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 160 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WeedBug::
    INCBIN "gfx/monster_sprites/weed_bug.lz"

; compressed sprite graphics of monster id $0B5 (GiantWorm) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 212 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GiantWorm::
    INCBIN "gfx/monster_sprites/giant_worm.lz"

; compressed sprite graphics of monster id $0B6 (Lipsy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lipsy::
    INCBIN "gfx/monster_sprites/lipsy.lz"

; compressed sprite graphics of monster id $0B7 (StagBug) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 214 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_StagBug::
    INCBIN "gfx/monster_sprites/stag_bug.lz"
    ds $1a8, $00
