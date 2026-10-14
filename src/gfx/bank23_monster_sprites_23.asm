; ROM bank $23: compressed monster sprites
; The annotated listing of this bank is build/listing/bank23.asm.

SECTION "Bank 23", ROMX[$4000], BANK[$23]
    db $23

; compressed sprite graphics of monster id $109 (BoneSlave) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BoneSlave::
    INCBIN "gfx/monster_sprites/bone_slave.lz"

; compressed sprite graphics of monster id $10A (Skeletor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skeletor::
    INCBIN "gfx/monster_sprites/skeletor.lz"

; compressed sprite graphics of monster id $10B (Servant) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 256 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Servant::
    INCBIN "gfx/monster_sprites/servant.lz"

; compressed sprite graphics of monster id $10C (Lazamanus) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lazamanus::
    INCBIN "gfx/monster_sprites/lazamanus.lz"

; compressed sprite graphics of monster id $10D (Copycat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Copycat::
    INCBIN "gfx/monster_sprites/copycat.lz"

; compressed sprite graphics of monster id $10E (MadSpirit) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadSpirit::
    INCBIN "gfx/monster_sprites/mad_spirit.lz"

; compressed sprite graphics of monster id $10F (PomPomBom) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PomBom::
    INCBIN "gfx/monster_sprites/pom_bom.lz"

; compressed sprite graphics of monster id $110 (Niterich) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Niterich::
    INCBIN "gfx/monster_sprites/niterich.lz"

; compressed sprite graphics of monster id $119 (JewelBag) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_JewelBag::
    INCBIN "gfx/monster_sprites/jewel_bag.lz"

; compressed sprite graphics of monster id $11A (EvilWand) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 197 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilWand::
    INCBIN "gfx/monster_sprites/evil_wand.lz"

; compressed sprite graphics of monster id $11B (MadCandle) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadCandle::
    INCBIN "gfx/monster_sprites/mad_candle.lz"

; compressed sprite graphics of monster id $11C (CoilBird) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 192 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CoilBird::
    INCBIN "gfx/monster_sprites/coil_bird.lz"

; compressed sprite graphics of monster id $11D (Facer) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 180 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Facer::
    INCBIN "gfx/monster_sprites/facer.lz"

; compressed sprite graphics of monster id $11E (SpikyBoy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SpikyBoy::
    INCBIN "gfx/monster_sprites/spiky_boy.lz"

; compressed sprite graphics of monster id $11F (MadMirror) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadMirror::
    INCBIN "gfx/monster_sprites/mad_mirror.lz"

; compressed sprite graphics of monster id $120 (RogueNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RogueNite::
    INCBIN "gfx/monster_sprites/rogue_nite.lz"

; compressed sprite graphics of monster id $121 (Puppetor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 177 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Puppetor::
    INCBIN "gfx/monster_sprites/puppetor.lz"

; compressed sprite graphics of monster id $122 (Goopi) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Goopi::
    INCBIN "gfx/monster_sprites/goopi.lz"

; compressed sprite graphics of monster id $123 (Voodoll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 144 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Voodoll::
    INCBIN "gfx/monster_sprites/voodoll.lz"

; compressed sprite graphics of monster id $124 (MetalDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MetalDrak::
    INCBIN "gfx/monster_sprites/metal_drak.lz"

; compressed sprite graphics of monster id $125 (Balzak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 240 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Balzak::
    INCBIN "gfx/monster_sprites/balzak.lz"

; compressed sprite graphics of monster id $126 (SabreMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SabreMan::
    INCBIN "gfx/monster_sprites/sabre_man.lz"

; compressed sprite graphics of monster id $127 (CurseLamp) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 144 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CurseLamp::
    INCBIN "gfx/monster_sprites/curse_lamp.lz"

; compressed sprite graphics of monster id $128 (Brushead) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Brushead::
    INCBIN "gfx/monster_sprites/brushead.lz"

; compressed sprite graphics of monster id $129 (Roboster) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Roboster::
    INCBIN "gfx/monster_sprites/roboster.lz"

; compressed sprite graphics of monster id $12A (Roboster2) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 183 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Roboster2::
    INCBIN "gfx/monster_sprites/roboster2.lz"

; compressed sprite graphics of monster id $12B (EvilPot) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 141 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilPot::
    INCBIN "gfx/monster_sprites/evil_pot.lz"

; compressed sprite graphics of monster id $12C (Gismo) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gismo::
    INCBIN "gfx/monster_sprites/gismo.lz"

; compressed sprite graphics of monster id $12D (LavaMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 204 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LavaMan::
    INCBIN "gfx/monster_sprites/lava_man.lz"

; compressed sprite graphics of monster id $12E (IceMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_IceMan::
    INCBIN "gfx/monster_sprites/ice_man.lz"

; compressed sprite graphics of monster id $12F (Mimic) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 199 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mimic::
    INCBIN "gfx/monster_sprites/mimic.lz"

; compressed sprite graphics of monster id $130 (Exaucers) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Exaucers::
    INCBIN "gfx/monster_sprites/exaucers.lz"

; compressed sprite graphics of monster id $131 (MudDoll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MudDoll::
    INCBIN "gfx/monster_sprites/mud_doll.lz"

; compressed sprite graphics of monster id $132 (Golem) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Golem::
    INCBIN "gfx/monster_sprites/golem.lz"

; compressed sprite graphics of monster id $133 (StoneMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 259 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_StoneMan::
    INCBIN "gfx/monster_sprites/stone_man.lz"

; compressed sprite graphics of monster id $134 (BombCrag) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 134 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BombCrag::
    INCBIN "gfx/monster_sprites/bomb_crag.lz"

; compressed sprite graphics of monster id $135 (GoldGolem) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoldGolem::
    INCBIN "gfx/monster_sprites/gold_golem.lz"

; compressed sprite graphics of monster id $136 (DarkMate) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 133 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkMate::
    INCBIN "gfx/monster_sprites/dark_mate.lz"

; compressed sprite graphics of monster id $137 (ProtoMech) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ProtoMech::
    INCBIN "gfx/monster_sprites/proto_mech.lz"

; compressed sprite graphics of monster id $138 (CloudKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CloudKing::
    INCBIN "gfx/monster_sprites/cloud_king.lz"

; compressed sprite graphics of monster id $13C (Petiteel) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Petiteel::
    INCBIN "gfx/monster_sprites/petiteel.lz"

; compressed sprite graphics of monster id $13D (Moray) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 223 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Moray::
    INCBIN "gfx/monster_sprites/moray.lz"

; compressed sprite graphics of monster id $13E (WalrusMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WalrusMan::
    INCBIN "gfx/monster_sprites/walrus_man.lz"

; compressed sprite graphics of monster id $13F (RayGigas) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RayGigas::
    INCBIN "gfx/monster_sprites/ray_gigas.lz"

; compressed sprite graphics of monster id $140 (Anemon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 194 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Anemon::
    INCBIN "gfx/monster_sprites/anemon.lz"

; compressed sprite graphics of monster id $141 (Aquarella) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 190 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Aquarella::
    INCBIN "gfx/monster_sprites/aquarella.lz"

; compressed sprite graphics of monster id $142 (Merman) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 217 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Merman::
    INCBIN "gfx/monster_sprites/merman.lz"

; compressed sprite graphics of monster id $143 (Octokid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 151 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octokid::
    INCBIN "gfx/monster_sprites/octokid.lz"

; compressed sprite graphics of monster id $144 (PutreFish) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PutreFish::
    INCBIN "gfx/monster_sprites/putre_fish.lz"

; compressed sprite graphics of monster id $145 (Octoreach) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 133 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octoreach::
    INCBIN "gfx/monster_sprites/octoreach.lz"

; compressed sprite graphics of monster id $146 (Angleron) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Angleron::
    INCBIN "gfx/monster_sprites/angleron.lz"

; compressed sprite graphics of monster id $147 (FishRider) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FishRider::
    INCBIN "gfx/monster_sprites/fish_rider.lz"

; compressed sprite graphics of monster id $148 (RushFish) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RushFish::
    INCBIN "gfx/monster_sprites/rush_fish.lz"

; compressed sprite graphics of monster id $149 (Gamanian) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gamanian::
    INCBIN "gfx/monster_sprites/gamanian.lz"

; compressed sprite graphics of monster id $14A (Clawster) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 234 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Clawster::
    INCBIN "gfx/monster_sprites/clawster.lz"

; compressed sprite graphics of monster id $14B (CancerMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CancerMan::
    INCBIN "gfx/monster_sprites/cancer_man.lz"

; compressed sprite graphics of monster id $14C (RogueWave) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 251 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RogueWave::
    INCBIN "gfx/monster_sprites/rogue_wave.lz"

; compressed sprite graphics of monster id $14D (Scallopa) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 204 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Scallopa::
    INCBIN "gfx/monster_sprites/scallopa.lz"

; compressed sprite graphics of monster id $14E (SeaHorse) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SeaHorse::
    INCBIN "gfx/monster_sprites/sea_horse.lz"

; compressed sprite graphics of monster id $14F (HoodSquid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HoodSquid::
    INCBIN "gfx/monster_sprites/hood_squid.lz"

; compressed sprite graphics of monster id $150 (MerTiger) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MerTiger::
    INCBIN "gfx/monster_sprites/mer_tiger.lz"

; compressed sprite graphics of monster id $151 (AxeShark) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 191 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AxeShark::
    INCBIN "gfx/monster_sprites/axe_shark.lz"

; compressed sprite graphics of monster id $152 (Octogon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octogon::
    INCBIN "gfx/monster_sprites/octogon.lz"

; compressed sprite graphics of monster id $153 (KingSquid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KingSquid::
    INCBIN "gfx/monster_sprites/king_squid.lz"

; compressed sprite graphics of monster id $154 (Digong) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Digong::
    INCBIN "gfx/monster_sprites/digong.lz"

; compressed sprite graphics of monster id $155 (WhaleMage) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 157 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WhaleMage::
    INCBIN "gfx/monster_sprites/whale_mage.lz"

; compressed sprite graphics of monster id $156 (Aquadon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Aquadon::
    INCBIN "gfx/monster_sprites/aquadon.lz"

; compressed sprite graphics of monster id $157 (Octoraid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Octoraid::
    INCBIN "gfx/monster_sprites/octoraid.lz"

; compressed sprite graphics of monster id $158 (Grakos) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 240 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Grakos::
    INCBIN "gfx/monster_sprites/grakos.lz"

; compressed sprite graphics of monster id $159 (Poseidon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Poseidon::
    INCBIN "gfx/monster_sprites/poseidon.lz"

; compressed sprite graphics of monster id $15A (Pumpoise) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pumpoise::
    INCBIN "gfx/monster_sprites/pumpoise.lz"

; compressed sprite graphics of monster id $15B (Starfish) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Starfish::
    INCBIN "gfx/monster_sprites/starfish.lz"
    ds $42d, $00
