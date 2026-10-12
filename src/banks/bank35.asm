SECTION "Bank 35", ROMX[$4000], BANK[$35]
    db $35

; copies the whole 47-byte species record of monster id wSpeciesIdLo/Hi to wSpeciesRecord; byte 0 is the family (E-0069)
; 37 call sites from 36 routines (e.g. DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess, CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord, WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03, ShowRecordSpeciesAndSkillNames, ...)
; points at: wSpeciesRecord
LoadSpeciesRecord::
Func_035_4001:: ; address name
    ld de, wSpeciesRecord
    ld b, $2F
    call CopySpeciesRecordPrefix
    ret

; copies byte 0 of the species record of monster id wSpeciesIdLo/Hi, the family (0 Slime ... 9 Water, 10 Boss; $FF for an unused id), to wSpeciesRecord (E-0069)
; 8 call sites from 7 routines (e.g. GetSlotSpeciesFamily, CountSpeciesPerFamilyFlaggedOrListed, BattleEnd_Step3_Sub01_LoadSpeciesFamily, FamilyNibbleOrSpeciesFamily, ...)
; points at: wSpeciesRecord
LoadSpeciesFamily::
Func_035_400A:: ; address name
    ld de, wSpeciesRecord
    ld b, $01
    call CopySpeciesRecordPrefix
    ret

; copies bytes 0-1 of the species record of monster id wSpeciesIdLo/Hi (the family and byte 1) to wSpeciesRecord (E-0069)
; 1 call site from 1 routine (e.g. RollWCADEFromSpeciesFlag)
; points at: wSpeciesRecord
LoadSpeciesRecordWord0::
Func_035_4013:: ; address name
    ld de, wSpeciesRecord
    ld b, $02
    call CopySpeciesRecordPrefix
    ret

; B = byte count, DE = destination: copies the first B bytes of the species record for monster id wSpeciesIdLo/Hi (pointer table SpeciesRecordPointers, 384 entries, 47-byte records) to DE (E-0062, E-0069)
; 3 call sites from 3 routines (e.g. LoadSpeciesFamily, LoadSpeciesRecord, LoadSpeciesRecordWord0)
; reads: wSpeciesIdLo, wSpeciesIdHi
CopySpeciesRecordPrefix::
Func_035_401C:: ; address name
    push bc
    push de
    ld a, [wSpeciesIdLo]
    ld c, a
    ld a, [wSpeciesIdHi]
    ld b, a
    sla c
    rl b
    ld hl, SpeciesRecordPointers
    add hl, bc
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    pop bc

Jump_035_4034::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_035_4034
    ret

; E-0253 (C1: CopySpeciesRecordPrefix reads the word at $403B + 2 * monster id (wSpeciesIdLo/Hi) and copies the first B bytes of the record it points at (E-0062, E-0069); 384 words, 324 distinct records).
; record: 47-byte species record
SpeciesRecordPointers::
Data_035_403B:: ; address name
    dw SpeciesRecords ; id 0
    dw SpeciesRecord_DrakSlime ; id 1 DrakSlime
    dw SpeciesRecord_SpotSlime ; id 2 SpotSlime
    dw SpeciesRecord_WingSlime ; id 3 WingSlime
    dw SpeciesRecord_TreeSlime ; id 4 TreeSlime
    dw SpeciesRecord_Snaily ; id 5 Snaily
    dw SpeciesRecord_SlimeNite ; id 6 SlimeNite
    dw SpeciesRecord_Babble ; id 7 Babble
    dw SpeciesRecord_BoxSlime ; id 8 BoxSlime
    dw SpeciesRecord_PearlGel ; id 9 PearlGel
    dw SpeciesRecord_Slime ; id 10 Slime
    dw SpeciesRecord_Healer ; id 11 Healer
    dw SpeciesRecord_FangSlime ; id 12 FangSlime
    dw SpeciesRecord_RockSlime ; id 13 RockSlime
    dw SpeciesRecord_SlimeBorg ; id 14 SlimeBorg
    dw SpeciesRecord_Slabbit ; id 15 Slabbit
    dw SpeciesRecord_KingSlime ; id 16 KingSlime
    dw SpeciesRecord_Metaly ; id 17 Metaly
    dw SpeciesRecord_Metabble ; id 18 Metabble
    dw SpeciesRecord_SpotKing ; id 19 SpotKing
    dw SpeciesRecord_TropicGel ; id 20 TropicGel
    dw SpeciesRecord_MimeSlime ; id 21 MimeSlime
    dw SpeciesRecord_HaloSlime ; id 22 HaloSlime
    dw SpeciesRecord_MetalKing ; id 23 MetalKing
    dw SpeciesRecord_GoldSlime ; id 24 GoldSlime
    dw SpeciesRecord_GranSlime ; id 25 GranSlime
    dw SpeciesRecord_WonderEgg ; id 26 WonderEgg
    dw SpeciesRecord_Butch ; id 27 Butch
    dw SpeciesRecords ; id 28 ?
    dw SpeciesRecords ; id 29 ?
    dw SpeciesRecords ; id 30 ?
    dw SpeciesRecords ; id 31 ?
    dw SpeciesRecords ; id 32 ?
    dw SpeciesRecords ; id 33 ?
    dw SpeciesRecords ; id 34 ?
    dw SpeciesRecords ; id 35 ?
    dw SpeciesRecord_DragonKid ; id 36 DragonKid
    dw SpeciesRecord_Tortragon ; id 37 Tortragon
    dw SpeciesRecord_Pteranod ; id 38 Pteranod
    dw SpeciesRecord_Gasgon ; id 39 Gasgon
    dw SpeciesRecord_FairyDrak ; id 40 FairyDrak
    dw SpeciesRecord_LizardMan ; id 41 LizardMan
    dw SpeciesRecord_Poisongon ; id 42 Poisongon
    dw SpeciesRecord_Swordgon ; id 43 Swordgon
    dw SpeciesRecord_Drygon ; id 44 Drygon
    dw SpeciesRecord_Dragon ; id 45 Dragon
    dw SpeciesRecord_MiniDrak ; id 46 MiniDrak
    dw SpeciesRecord_MadDragon ; id 47 MadDragon
    dw SpeciesRecord_Rayburn ; id 48 Rayburn
    dw SpeciesRecord_Chamelgon ; id 49 Chamelgon
    dw SpeciesRecord_LizardFly ; id 50 LizardFly
    dw SpeciesRecord_Andreal ; id 51 Andreal
    dw SpeciesRecord_KingCobra ; id 52 KingCobra
    dw SpeciesRecord_Vampirus ; id 53 Vampirus
    dw SpeciesRecord_SnakeBat ; id 54 SnakeBat
    dw SpeciesRecord_Spikerous ; id 55 Spikerous
    dw SpeciesRecord_GreatDrak ; id 56 GreatDrak
    dw SpeciesRecord_Crestpent ; id 57 Crestpent
    dw SpeciesRecord_WingSnake ; id 58 WingSnake
    dw SpeciesRecord_Coatol ; id 59 Coatol
    dw SpeciesRecord_Orochi ; id 60 Orochi
    dw SpeciesRecord_BattleRex ; id 61 BattleRex
    dw SpeciesRecord_SkyDragon ; id 62 SkyDragon
    dw SpeciesRecord_Serpentia ; id 63 Serpentia
    dw SpeciesRecord_Divinegon ; id 64 Divinegon
    dw SpeciesRecord_Orligon ; id 65 Orligon
    dw SpeciesRecord_GigaDraco ; id 66 GigaDraco
    dw SpeciesRecords ; id 67 ?
    dw SpeciesRecords ; id 68 ?
    dw SpeciesRecords ; id 69 ?
    dw SpeciesRecords ; id 70 ?
    dw SpeciesRecord_Tonguella ; id 71 Tonguella
    dw SpeciesRecord_Almiraj ; id 72 Almiraj
    dw SpeciesRecord_CatFly ; id 73 CatFly
    dw SpeciesRecord_PillowRat ; id 74 PillowRat
    dw SpeciesRecord_Saccer ; id 75 Saccer
    dw SpeciesRecord_GulpBeast ; id 76 GulpBeast
    dw SpeciesRecord_Skullroo ; id 77 Skullroo
    dw SpeciesRecord_WindBeast ; id 78 WindBeast
    dw SpeciesRecord_Beavern ; id 79 Beavern
    dw SpeciesRecord_Antbear ; id 80 Antbear
    dw SpeciesRecord_SuperTen ; id 81 SuperTen
    dw SpeciesRecord_IronTurt ; id 82 IronTurt
    dw SpeciesRecord_Mommonja ; id 83 Mommonja
    dw SpeciesRecord_HammerMan ; id 84 HammerMan
    dw SpeciesRecord_Grizzly ; id 85 Grizzly
    dw SpeciesRecord_Yeti ; id 86 Yeti
    dw SpeciesRecord_ArrowDog ; id 87 ArrowDog
    dw SpeciesRecord_NoctoKing ; id 88 NoctoKing
    dw SpeciesRecord_BeastNite ; id 89 BeastNite
    dw SpeciesRecord_MadGopher ; id 90 MadGopher
    dw SpeciesRecord_FairyRat ; id 91 FairyRat
    dw SpeciesRecord_Unicorn ; id 92 Unicorn
    dw SpeciesRecord_Goategon ; id 93 Goategon
    dw SpeciesRecord_WildApe ; id 94 WildApe
    dw SpeciesRecord_Trumpeter ; id 95 Trumpeter
    dw SpeciesRecord_KingLeo ; id 96 KingLeo
    dw SpeciesRecord_DarkHorn ; id 97 DarkHorn
    dw SpeciesRecord_MadCat ; id 98 MadCat
    dw SpeciesRecord_BigEye ; id 99 BigEye
    dw SpeciesRecord_Gorago ; id 100 Gorago
    dw SpeciesRecord_CatMage ; id 101 CatMage
    dw SpeciesRecord_Dumbira ; id 102 Dumbira
    dw SpeciesRecords ; id 103 ?
    dw SpeciesRecords ; id 104 ?
    dw SpeciesRecords ; id 105 ?
    dw SpeciesRecord_Picky ; id 106 Picky
    dw SpeciesRecord_Wyvern ; id 107 Wyvern
    dw SpeciesRecord_BullBird ; id 108 BullBird
    dw SpeciesRecord_Florajay ; id 109 Florajay
    dw SpeciesRecord_DuckKite ; id 110 DuckKite
    dw SpeciesRecord_MadPecker ; id 111 MadPecker
    dw SpeciesRecord_MadRaven ; id 112 MadRaven
    dw SpeciesRecord_MistyWing ; id 113 MistyWing
    dw SpeciesRecord_AquaHawk ; id 114 AquaHawk
    dw SpeciesRecord_Dracky ; id 115 Dracky
    dw SpeciesRecord_KiteHawk ; id 116 KiteHawk
    dw SpeciesRecord_BigRoost ; id 117 BigRoost
    dw SpeciesRecord_StubBird ; id 118 StubBird
    dw SpeciesRecord_LandOwl ; id 119 LandOwl
    dw SpeciesRecord_MadGoose ; id 120 MadGoose
    dw SpeciesRecord_MadCondor ; id 121 MadCondor
    dw SpeciesRecord_Emyu ; id 122 Emyu
    dw SpeciesRecord_Blizzardy ; id 123 Blizzardy
    dw SpeciesRecord_Phoenix ; id 124 Phoenix
    dw SpeciesRecord_ZapBird ; id 125 ZapBird
    dw SpeciesRecord_Garudian ; id 126 Garudian
    dw SpeciesRecord_WhipBird ; id 127 WhipBird
    dw SpeciesRecord_FunkyBird ; id 128 FunkyBird
    dw SpeciesRecord_RainHawk ; id 129 RainHawk
    dw SpeciesRecord_Azurile ; id 130 Azurile
    dw SpeciesRecord_Shantak ; id 131 Shantak
    dw SpeciesRecord_CragDevil ; id 132 CragDevil
    dw SpeciesRecords ; id 133 ?
    dw SpeciesRecords ; id 134 ?
    dw SpeciesRecords ; id 135 ?
    dw SpeciesRecords ; id 136 ?
    dw SpeciesRecords ; id 137 ?
    dw SpeciesRecords ; id 138 ?
    dw SpeciesRecords ; id 139 ?
    dw SpeciesRecords ; id 140 ?
    dw SpeciesRecord_MadPlant ; id 141 MadPlant
    dw SpeciesRecord_FireWeed ; id 142 FireWeed
    dw SpeciesRecord_FloraMan ; id 143 FloraMan
    dw SpeciesRecord_WingTree ; id 144 WingTree
    dw SpeciesRecord_CactiBall ; id 145 CactiBall
    dw SpeciesRecord_Gulpple ; id 146 Gulpple
    dw SpeciesRecord_Toadstool ; id 147 Toadstool
    dw SpeciesRecord_AmberWeed ; id 148 AmberWeed
    dw SpeciesRecord_Slurperon ; id 149 Slurperon
    dw SpeciesRecord_Stubsuck ; id 150 Stubsuck
    dw SpeciesRecord_Oniono ; id 151 Oniono
    dw SpeciesRecord_DanceVegi ; id 152 DanceVegi
    dw SpeciesRecord_TreeBoy ; id 153 TreeBoy
    dw SpeciesRecord_Devipine ; id 154 Devipine
    dw SpeciesRecord_FaceTree ; id 155 FaceTree
    dw SpeciesRecord_HerbMan ; id 156 HerbMan
    dw SpeciesRecord_BeanMan ; id 157 BeanMan
    dw SpeciesRecord_EvilSeed ; id 158 EvilSeed
    dw SpeciesRecord_ManEater ; id 159 ManEater
    dw SpeciesRecord_Snapper ; id 160 Snapper
    dw SpeciesRecord_GhosTree ; id 161 GhosTree
    dw SpeciesRecord_Rosevine ; id 162 Rosevine
    dw SpeciesRecord_Egdracil ; id 163 Egdracil
    dw SpeciesRecord_Warubou ; id 164 Warubou
    dw SpeciesRecord_Watabou ; id 165 Watabou
    dw SpeciesRecord_Eggplaton ; id 166 Eggplaton
    dw SpeciesRecord_FooHero ; id 167 FooHero
    dw SpeciesRecords ; id 168 ?
    dw SpeciesRecords ; id 169 ?
    dw SpeciesRecords ; id 170 ?
    dw SpeciesRecords ; id 171 ?
    dw SpeciesRecords ; id 172 ?
    dw SpeciesRecords ; id 173 ?
    dw SpeciesRecords ; id 174 ?
    dw SpeciesRecords ; id 175 ?
    dw SpeciesRecord_GiantSlug ; id 176 GiantSlug
    dw SpeciesRecord_Catapila ; id 177 Catapila
    dw SpeciesRecord_Gophecada ; id 178 Gophecada
    dw SpeciesRecord_Butterfly ; id 179 Butterfly
    dw SpeciesRecord_WeedBug ; id 180 WeedBug
    dw SpeciesRecord_GiantWorm ; id 181 GiantWorm
    dw SpeciesRecord_Lipsy ; id 182 Lipsy
    dw SpeciesRecord_StagBug ; id 183 StagBug
    dw SpeciesRecord_Pyuro ; id 184 Pyuro
    dw SpeciesRecord_ArmyAnt ; id 185 ArmyAnt
    dw SpeciesRecord_GoHopper ; id 186 GoHopper
    dw SpeciesRecord_TailEater ; id 187 TailEater
    dw SpeciesRecord_ArmorPede ; id 188 ArmorPede
    dw SpeciesRecord_Eyeder ; id 189 Eyeder
    dw SpeciesRecord_GiantMoth ; id 190 GiantMoth
    dw SpeciesRecord_Droll ; id 191 Droll
    dw SpeciesRecord_ArmyCrab ; id 192 ArmyCrab
    dw SpeciesRecord_MadHornet ; id 193 MadHornet
    dw SpeciesRecord_Belzebub ; id 194 Belzebub
    dw SpeciesRecord_WarMantis ; id 195 WarMantis
    dw SpeciesRecord_HornBeet ; id 196 HornBeet
    dw SpeciesRecord_Sickler ; id 197 Sickler
    dw SpeciesRecord_Armorpion ; id 198 Armorpion
    dw SpeciesRecord_Digster ; id 199 Digster
    dw SpeciesRecord_Skularach ; id 200 Skularach
    dw SpeciesRecord_MultiEyes ; id 201 MultiEyes
    dw SpeciesRecords ; id 202 ?
    dw SpeciesRecords ; id 203 ?
    dw SpeciesRecords ; id 204 ?
    dw SpeciesRecords ; id 205 ?
    dw SpeciesRecords ; id 206 ?
    dw SpeciesRecords ; id 207 ?
    dw SpeciesRecords ; id 208 ?
    dw SpeciesRecords ; id 209 ?
    dw SpeciesRecords ; id 210 ?
    dw SpeciesRecord_Pixy ; id 211 Pixy
    dw SpeciesRecord_MedusaEye ; id 212 MedusaEye
    dw SpeciesRecord_AgDevil ; id 213 AgDevil
    dw SpeciesRecord_Demonite ; id 214 Demonite
    dw SpeciesRecord_DarkEye ; id 215 DarkEye
    dw SpeciesRecord_EyeBall ; id 216 EyeBall
    dw SpeciesRecord_SkulRider ; id 217 SkulRider
    dw SpeciesRecord_EvilBeast ; id 218 EvilBeast
    dw SpeciesRecord_Bubblemon ; id 219 Bubblemon
    dw SpeciesRecord_1EyeClown ; id 220 1EyeClown
    dw SpeciesRecord_Gremlin ; id 221 Gremlin
    dw SpeciesRecord_ArcDemon ; id 222 ArcDemon
    dw SpeciesRecord_Lionex ; id 223 Lionex
    dw SpeciesRecord_GoatHorn ; id 224 GoatHorn
    dw SpeciesRecord_Orc ; id 225 Orc
    dw SpeciesRecord_Ogre ; id 226 Ogre
    dw SpeciesRecord_GateGuard ; id 227 GateGuard
    dw SpeciesRecord_ChopClown ; id 228 ChopClown
    dw SpeciesRecord_BossTroll ; id 229 BossTroll
    dw SpeciesRecord_Grendal ; id 230 Grendal
    dw SpeciesRecord_Akubar ; id 231 Akubar
    dw SpeciesRecord_MadKnight ; id 232 MadKnight
    dw SpeciesRecord_EvilWell ; id 233 EvilWell
    dw SpeciesRecord_Gigantes ; id 234 Gigantes
    dw SpeciesRecord_Centasaur ; id 235 Centasaur
    dw SpeciesRecord_EvilArmor ; id 236 EvilArmor
    dw SpeciesRecord_Jamirus ; id 237 Jamirus
    dw SpeciesRecord_Durran ; id 238 Durran
    dw SpeciesRecord_Titanis ; id 239 Titanis
    dw SpeciesRecord_LampGenie ; id 240 LampGenie
    dw SpeciesRecords ; id 241 ?
    dw SpeciesRecords ; id 242 ?
    dw SpeciesRecords ; id 243 ?
    dw SpeciesRecords ; id 244 ?
    dw SpeciesRecords ; id 245 ?
    dw SpeciesRecord_Spooky ; id 246 Spooky
    dw SpeciesRecord_Skullgon ; id 247 Skullgon
    dw SpeciesRecord_PutrePup ; id 248 PutrePup
    dw SpeciesRecord_RotRaven ; id 249 RotRaven
    dw SpeciesRecord_Mummy ; id 250 Mummy
    dw SpeciesRecord_DarkCrab ; id 251 DarkCrab
    dw SpeciesRecord_DeadNite ; id 252 DeadNite
    dw SpeciesRecord_Shadow ; id 253 Shadow
    dw SpeciesRecord_Skulpent ; id 254 Skulpent
    dw SpeciesRecord_Hork ; id 255 Hork
    dw SpeciesRecord_Mudron ; id 256 Mudron
    dw SpeciesRecord_NiteWhip ; id 257 NiteWhip
    dw SpeciesRecord_WindMerge ; id 258 WindMerge
    dw SpeciesRecord_Reaper ; id 259 Reaper
    dw SpeciesRecord_Inverzon ; id 260 Inverzon
    dw SpeciesRecord_FoxFire ; id 261 FoxFire
    dw SpeciesRecord_CaptDead ; id 262 CaptDead
    dw SpeciesRecord_DeadNoble ; id 263 DeadNoble
    dw SpeciesRecord_WhiteKing ; id 264 WhiteKing
    dw SpeciesRecord_BoneSlave ; id 265 BoneSlave
    dw SpeciesRecord_Skeletor ; id 266 Skeletor
    dw SpeciesRecord_Servant ; id 267 Servant
    dw SpeciesRecord_Lazamanus ; id 268 Lazamanus
    dw SpeciesRecord_Copycat ; id 269 Copycat
    dw SpeciesRecord_MadSpirit ; id 270 MadSpirit
    dw SpeciesRecord_PomPomBom ; id 271 PomPomBom
    dw SpeciesRecord_Niterich ; id 272 Niterich
    dw SpeciesRecords ; id 273 ?
    dw SpeciesRecords ; id 274 ?
    dw SpeciesRecords ; id 275 ?
    dw SpeciesRecords ; id 276 ?
    dw SpeciesRecords ; id 277 ?
    dw SpeciesRecords ; id 278 ?
    dw SpeciesRecords ; id 279 ?
    dw SpeciesRecords ; id 280 ?
    dw SpeciesRecord_JewelBag ; id 281 JewelBag
    dw SpeciesRecord_EvilWand ; id 282 EvilWand
    dw SpeciesRecord_MadCandle ; id 283 MadCandle
    dw SpeciesRecord_CoilBird ; id 284 CoilBird
    dw SpeciesRecord_Facer ; id 285 Facer
    dw SpeciesRecord_SpikyBoy ; id 286 SpikyBoy
    dw SpeciesRecord_MadMirror ; id 287 MadMirror
    dw SpeciesRecord_RogueNite ; id 288 RogueNite
    dw SpeciesRecord_Puppetor ; id 289 Puppetor
    dw SpeciesRecord_Goopi ; id 290 Goopi
    dw SpeciesRecord_Voodoll ; id 291 Voodoll
    dw SpeciesRecord_MetalDrak ; id 292 MetalDrak
    dw SpeciesRecord_Balzak ; id 293 Balzak
    dw SpeciesRecord_SabreMan ; id 294 SabreMan
    dw SpeciesRecord_CurseLamp ; id 295 CurseLamp
    dw SpeciesRecord_Brushead ; id 296 Brushead
    dw SpeciesRecord_Roboster ; id 297 Roboster
    dw SpeciesRecord_Roboster2 ; id 298 Roboster2
    dw SpeciesRecord_EvilPot ; id 299 EvilPot
    dw SpeciesRecord_Gismo ; id 300 Gismo
    dw SpeciesRecord_LavaMan ; id 301 LavaMan
    dw SpeciesRecord_IceMan ; id 302 IceMan
    dw SpeciesRecord_Mimic ; id 303 Mimic
    dw SpeciesRecord_Exaucers ; id 304 Exaucers
    dw SpeciesRecord_MudDoll ; id 305 MudDoll
    dw SpeciesRecord_Golem ; id 306 Golem
    dw SpeciesRecord_StoneMan ; id 307 StoneMan
    dw SpeciesRecord_BombCrag ; id 308 BombCrag
    dw SpeciesRecord_GoldGolem ; id 309 GoldGolem
    dw SpeciesRecord_DarkMate ; id 310 DarkMate
    dw SpeciesRecord_ProtoMech ; id 311 ProtoMech
    dw SpeciesRecord_CloudKing ; id 312 CloudKing
    dw SpeciesRecords ; id 313 ?
    dw SpeciesRecords ; id 314 ?
    dw SpeciesRecords ; id 315 ?
    dw SpeciesRecord_Petiteel ; id 316 Petiteel
    dw SpeciesRecord_Moray ; id 317 Moray
    dw SpeciesRecord_WalrusMan ; id 318 WalrusMan
    dw SpeciesRecord_RayGigas ; id 319 RayGigas
    dw SpeciesRecord_Anemon ; id 320 Anemon
    dw SpeciesRecord_Aquarella ; id 321 Aquarella
    dw SpeciesRecord_Merman ; id 322 Merman
    dw SpeciesRecord_Octokid ; id 323 Octokid
    dw SpeciesRecord_PutreFish ; id 324 PutreFish
    dw SpeciesRecord_Octoreach ; id 325 Octoreach
    dw SpeciesRecord_Angleron ; id 326 Angleron
    dw SpeciesRecord_FishRider ; id 327 FishRider
    dw SpeciesRecord_RushFish ; id 328 RushFish
    dw SpeciesRecord_Gamanian ; id 329 Gamanian
    dw SpeciesRecord_Clawster ; id 330 Clawster
    dw SpeciesRecord_CancerMan ; id 331 CancerMan
    dw SpeciesRecord_RogueWave ; id 332 RogueWave
    dw SpeciesRecord_Scallopa ; id 333 Scallopa
    dw SpeciesRecord_SeaHorse ; id 334 SeaHorse
    dw SpeciesRecord_HoodSquid ; id 335 HoodSquid
    dw SpeciesRecord_MerTiger ; id 336 MerTiger
    dw SpeciesRecord_AxeShark ; id 337 AxeShark
    dw SpeciesRecord_Octogon ; id 338 Octogon
    dw SpeciesRecord_KingSquid ; id 339 KingSquid
    dw SpeciesRecord_Digong ; id 340 Digong
    dw SpeciesRecord_WhaleMage ; id 341 WhaleMage
    dw SpeciesRecord_Aquadon ; id 342 Aquadon
    dw SpeciesRecord_Octoraid ; id 343 Octoraid
    dw SpeciesRecord_Grakos ; id 344 Grakos
    dw SpeciesRecord_Poseidon ; id 345 Poseidon
    dw SpeciesRecord_Pumpoise ; id 346 Pumpoise
    dw SpeciesRecord_Starfish ; id 347 Starfish
    dw SpeciesRecords ; id 348 ?
    dw SpeciesRecords ; id 349 ?
    dw SpeciesRecords ; id 350 ?
    dw SpeciesRecord_DracoLord ; id 351 DracoLord
    dw Data_035_7906 ; id 352 DracoLord
    dw SpeciesRecord_LordDraco ; id 353 LordDraco
    dw SpeciesRecord_Hargon ; id 354 Hargon
    dw SpeciesRecord_Sidoh ; id 355 Sidoh
    dw SpeciesRecord_Genosidoh ; id 356 Genosidoh
    dw SpeciesRecord_Baramos ; id 357 Baramos
    dw SpeciesRecord_Zoma ; id 358 Zoma
    dw SpeciesRecord_AsuraZoma ; id 359 AsuraZoma
    dw SpeciesRecord_Pizzaro ; id 360 Pizzaro
    dw SpeciesRecord_PsychoPiz ; id 361 PsychoPiz
    dw SpeciesRecord_Esterk ; id 362 Esterk
    dw SpeciesRecord_Mirudraas ; id 363 Mirudraas
    dw Data_035_7B3A ; id 364 Mirudraas
    dw SpeciesRecord_Mudou ; id 365 Mudou
    dw SpeciesRecord_DeathMore ; id 366 DeathMore
    dw Data_035_7BC7 ; id 367 DeathMore
    dw Data_035_7BF6 ; id 368 DeathMore
    dw SpeciesRecord_Darkdrium ; id 369 Darkdrium
    dw SpeciesRecord_Orgodemir ; id 370 Orgodemir
    dw Data_035_7C83 ; id 371 Orgodemir
    dw SpeciesRecord_Darck ; id 372 Darck
    dw SpeciesRecord_Tatsu ; id 373 Tatsu
    dw SpeciesRecord_Diago ; id 374 Diago
    dw SpeciesRecord_Samsi ; id 375 Samsi
    dw SpeciesRecord_Bazoo ; id 376 Bazoo
    dw SpeciesRecord_179 ; id 377 ?
    dw SpeciesRecord_17A ; id 378 ?
    dw SpeciesRecord_17B ; id 379 ?
    dw SpeciesRecord_Lamia ; id 380 Lamia
    dw SpeciesRecord_Dimensaur ; id 381 Dimensaur
    dw SpeciesRecord_Kagebou ; id 382 Kagebou
    dw SpeciesRecords ; id 383 ?

; E-0253 (C1: the 324 records SpeciesRecordPointers points at, 47 bytes each and contiguous up to $7EB7; each is labelled SpeciesRecord_<monster> after the first id that uses it; byte 0 is the family (E-0069) and byte 7 the EXP curve (E-0148); the other bytes are not read here).
; record: family; bytes 1-6; EXP curve; bytes 8-46
SpeciesRecords::
SpeciesRecord_000:: ; heuristic: species record; C0
Data_035_433B:: ; address name
    db $FF ; id 0: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $00, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $00, $00 ; bytes 40-46
SpeciesRecord_DrakSlime:: ; heuristic: species record; C0
Data_035_436A:: ; address name
    db $00 ; id 1: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3B, $40, $89, $00, $10, $0A, $0D, $08, $14, $10, $01, $01, $01, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $02, $02, $03, $02, $02, $01, $00, $01, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $4F, $00 ; bytes 40-46
SpeciesRecord_SpotSlime:: ; heuristic: species record; C0
Data_035_4399:: ; address name
    db $00 ; id 2: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $8B, $9E, $00, $11, $01, $11, $04, $11, $08, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $03, $03, $02, $02, $00, $00, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $41, $00 ; bytes 40-46
SpeciesRecord_WingSlime:: ; heuristic: species record; C0
Data_035_43C8:: ; address name
    db $00 ; id 3: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $48, $62, $99, $00, $0D, $02, $0B, $0B, $18, $08, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $44, $00 ; bytes 40-46
SpeciesRecord_TreeSlime:: ; heuristic: species record; C0
Data_035_43F7:: ; address name
    db $00 ; id 4: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $60, $71, $00, $0D, $0B, $08, $0E, $11, $11, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $02, $02, $02, $03, $03, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $00, $00, $02, $4B, $00 ; bytes 40-46
SpeciesRecord_Snaily:: ; heuristic: species record; C0
Data_035_4426:: ; address name
    db $00 ; id 5: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $10, $23, $4E, $00, $0B, $0A, $11, $14, $14, $08, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $03, $02, $02, $03, $02, $02, $02, $02, $02, $00, $00, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $02, $4E, $00 ; bytes 40-46
SpeciesRecord_SlimeNite:: ; heuristic: species record; C0
Data_035_4455:: ; address name
    db $00 ; id 6: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $25, $56, $00, $0E, $01, $0F, $0E, $14, $0E, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $02, $02, $03, $02, $01, $00, $00, $01, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $4E, $00 ; bytes 40-46
SpeciesRecord_Babble:: ; heuristic: species record; C0
Data_035_4484:: ; address name
    db $00 ; id 7: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2E, $5F, $80, $00, $11, $07, $11, $08, $0E, $0D, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $03, $03, $03, $02, $02, $03, $02, $02, $02, $02, $00, $00, $03, $01, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $4A, $00 ; bytes 40-46
SpeciesRecord_BoxSlime:: ; heuristic: species record; C0
Data_035_44B3:: ; address name
    db $00 ; id 8: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $25, $6F, $00, $0B, $0A, $0E, $13, $0E, $0D, $00, $00, $01, $00, $00, $01 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $02, $02, $03, $02, $00, $01, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $48, $00 ; bytes 40-46
SpeciesRecord_PearlGel:: ; heuristic: species record; C0
Data_035_44E2:: ; address name
    db $00 ; id 9: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $68, $7F, $01, $0A, $10, $08, $16, $0E, $09, $00, $00, $00, $00, $00, $01 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $01, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $02, $46, $00 ; bytes 40-46
SpeciesRecord_Slime:: ; heuristic: species record; C0
Data_035_4511:: ; address name
    db $00 ; id 10: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $01, $00, $28 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $3D, $7F, $00, $16, $0B, $0E, $11, $0B, $0D, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $46, $00 ; bytes 40-46
SpeciesRecord_Healer:: ; heuristic: species record; C0
Data_035_4540:: ; address name
    db $00 ; id 11: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $19, $25, $00, $0B, $0F, $0B, $0B, $14, $12, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $02, $02, $02, $03, $03, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; bytes 24-39
    db $02, $02, $00, $00, $00, $4E, $00 ; bytes 40-46
SpeciesRecord_FangSlime:: ; heuristic: species record; C0
Data_035_456F:: ; address name
    db $00 ; id 12: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $68, $90, $00, $19, $01, $12, $0D, $14, $0D, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $03, $03, $03, $02, $00, $00, $00, $01, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $54, $00 ; bytes 40-46
SpeciesRecord_RockSlime:: ; heuristic: species record; C0
Data_035_459E:: ; address name
    db $00 ; id 13: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6A, $6F, $94, $03, $0D, $0A, $0E, $17, $10, $0E, $00, $00, $01, $00, $00, $02 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $02, $02, $03, $02, $00, $02, $00, $00, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $51, $00 ; bytes 40-46
SpeciesRecord_SlimeBorg:: ; heuristic: species record; C0
Data_035_45CD:: ; address name
    db $00 ; id 14: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4A, $65, $96, $00, $12, $0B, $14, $0F, $0E, $0D, $01, $01, $00, $01, $02, $01 ; bytes 8-23
    db $02, $02, $03, $02, $02, $03, $02, $02, $03, $02, $01, $01, $00, $01, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $57, $00 ; bytes 40-46
SpeciesRecord_Slabbit:: ; heuristic: species record; C0
Data_035_45FC:: ; address name
    db $00 ; id 15: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $04, $00, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $7D, $8D, $A2, $00, $0F, $07, $0E, $08, $15, $0F, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $03, $03, $02, $02, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $01, $01, $02, $01, $01, $4C, $00 ; bytes 40-46
SpeciesRecord_KingSlime:: ; heuristic: species record; C0
Data_035_462B:: ; address name
    db $00 ; id 16: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1B, $38, $1E, $00, $12, $0E, $0F, $0E, $14, $0F, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $03, $02, $03, $02, $02, $03, $03, $03, $03, $02, $01, $01, $01, $01, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $67, $00 ; bytes 40-46
SpeciesRecord_Metaly:: ; heuristic: species record; C0
Data_035_465A:: ; address name
    db $00 ; id 17: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $01, $06, $00, $14 ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $10, $13, $00, $00, $1E, $0B, $1E, $1F, $0D, $03, $03, $03, $03, $03, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $03, $03, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $03, $00, $03, $C8, $00 ; bytes 40-46
SpeciesRecord_Metabble:: ; heuristic: species record; C0
Data_035_4689:: ; address name
    db $00 ; id 18: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $01, $06, $00, $23 ; bytes 1-6
    db $1B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $07, $15, $00, $00, $1E, $0E, $1F, $1F, $0F, $03, $03, $03, $03, $03, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $03, $03, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $03, $00, $03, $BC, $02 ; bytes 40-46
SpeciesRecord_SpotKing:: ; heuristic: species record; C0
Data_035_46B8:: ; address name
    db $00 ; id 19: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $06, $00, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5C, $61, $93, $00, $12, $0B, $12, $0B, $14, $0F, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $03, $02, $03, $02, $02, $03, $03, $03, $03, $02, $01, $01, $00, $01, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $67, $00 ; bytes 40-46
SpeciesRecord_TropicGel:: ; heuristic: species record; C0
Data_035_46E7:: ; address name
    db $00 ; id 20: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1B, $71, $8B, $00, $0F, $14, $13, $09, $0E, $0F, $01, $01, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $4E, $00 ; bytes 40-46
SpeciesRecord_MimeSlime:: ; heuristic: species record; C0
Data_035_4716:: ; address name
    db $00 ; id 21: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $11 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $34, $8F, $A1, $00, $0A, $0C, $08, $13, $14, $11, $01, $01, $01, $01, $00, $01 ; bytes 8-23
    db $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $55, $00 ; bytes 40-46
SpeciesRecord_HaloSlime:: ; heuristic: species record; C0
Data_035_4745:: ; address name
    db $00 ; id 22: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $23 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $9C, $A0, $02, $09, $14, $0B, $0D, $0C, $16, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $02, $02 ; bytes 24-39
    db $02, $02, $01, $00, $00, $52, $00 ; bytes 40-46
SpeciesRecord_MetalKing:: ; heuristic: species record; C0
Data_035_4774:: ; address name
    db $00 ; id 23: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $01, $06, $00, $37 ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0D, $35, $3F, $00, $00, $1F, $0F, $1F, $1F, $12, $03, $03, $03, $03, $03, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $03, $03, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $03, $01, $03, $84, $03 ; bytes 40-46
SpeciesRecord_GoldSlime:: ; heuristic: species record; C0
Data_035_47A3:: ; address name
    db $00 ; id 24: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $46 ; bytes 1-6
    db $1F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3C, $3E, $81, $03, $00, $1F, $13, $1F, $1F, $12, $03, $03, $03, $03, $03, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $03, $03, $03, $03, $03, $01 ; bytes 24-39
    db $01, $01, $03, $02, $03, $9C, $00 ; bytes 40-46
SpeciesRecord_GranSlime:: ; heuristic: species record; C0
Data_035_47D2:: ; address name
    db $00 ; id 25: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $50 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $20, $8A, $A6, $02, $19, $1D, $1B, $1F, $06, $1F, $03, $03, $03, $03, $03, $03 ; bytes 8-23
    db $01, $01, $03, $03, $03, $03, $03, $03, $03, $02, $03, $03, $03, $02, $03, $02 ; bytes 24-39
    db $02, $02, $02, $03, $02, $A7, $00 ; bytes 40-46
SpeciesRecord_WonderEgg:: ; heuristic: species record; C0
Data_035_4801:: ; address name
    db $00 ; id 26: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $01, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $15, $35, $3C, $00, $08, $0D, $0B, $13, $0B, $14, $01, $01, $01, $02, $01, $02 ; bytes 8-23
    db $01, $02, $03, $01, $00, $03, $00, $00, $00, $00, $02, $01, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $01, $01, $03, $4D, $00 ; bytes 40-46
SpeciesRecord_Butch:: ; heuristic: species record; C0
Data_035_4830:: ; address name
    db $00 ; id 27: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $03, $03, $02, $02, $02, $02, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $02, $00, $00 ; bytes 40-46
SpeciesRecord_DragonKid:: ; heuristic: species record; C0
Data_035_485F:: ; address name
    db $01 ; id 28: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $71, $95, $00, $0A, $03, $11, $02, $05, $05, $01, $02, $02, $00, $00, $02 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $01, $01, $03, $01, $02, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $30, $00 ; bytes 40-46
SpeciesRecord_Tortragon:: ; heuristic: species record; C0
Data_035_488E:: ; address name
    db $01 ; id 29: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $11 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $35, $36, $4A, $03, $0F, $0B, $12, $06, $07, $0D, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $01, $01, $02, $00, $02, $01, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $3F, $00 ; bytes 40-46
SpeciesRecord_Pteranod:: ; heuristic: species record; C0
Data_035_48BD:: ; address name
    db $01 ; id 30: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $23 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $48, $99, $02, $0E, $0B, $12, $02, $14, $04, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $02, $00, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $3A, $00 ; bytes 40-46
SpeciesRecord_Gasgon:: ; heuristic: species record; C0
Data_035_48EC:: ; address name
    db $01 ; id 31: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $32 ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $15, $20, $6E, $02, $11, $0F, $0D, $0B, $07, $12, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $00, $00, $00, $01, $01, $00, $00, $00, $02, $00, $02, $00, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $00, $00, $00, $43, $00 ; bytes 40-46
SpeciesRecord_FairyDrak:: ; heuristic: species record; C0
Data_035_491B:: ; address name
    db $01 ; id 32: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $01, $00, $03, $01, $1E ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2E, $71, $8B, $00, $09, $0D, $11, $10, $0E, $04, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $01, $00, $00, $00, $01, $00, $00, $02, $00, $02, $00, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $00, $3C, $00 ; bytes 40-46
SpeciesRecord_LizardMan:: ; heuristic: species record; C0
Data_035_494A:: ; address name
    db $01 ; id 33: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5D, $67, $6B, $05, $11, $0A, $13, $0D, $05, $10, $00, $02, $02, $01, $01, $01 ; bytes 8-23
    db $01, $00, $02, $00, $00, $01, $00, $00, $03, $00, $02, $00, $00, $01, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $43, $00 ; bytes 40-46
SpeciesRecord_Poisongon:: ; heuristic: species record; C0
Data_035_4979:: ; address name
    db $01 ; id 34: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $2D ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5F, $73, $8B, $00, $15, $10, $0F, $0D, $07, $01, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $01, $01, $00, $00, $01, $00, $00, $02, $00, $02, $00, $02, $01, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $3E, $00 ; bytes 40-46
SpeciesRecord_Swordgon:: ; heuristic: species record; C0
Data_035_49A8:: ; address name
    db $01 ; id 35: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5C, $65, $96, $05, $09, $03, $17, $06, $01, $05, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $01, $01, $01, $00, $00, $00, $00, $00, $03, $00, $02, $01, $01, $00, $01, $01 ; bytes 24-39
    db $00, $00, $00, $00, $01, $31, $00 ; bytes 40-46
SpeciesRecord_Drygon:: ; heuristic: species record; C0
Data_035_49D7:: ; address name
    db $01 ; id 36: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $6F, $90, $00, $0B, $02, $13, $0D, $07, $05, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $00, $00, $03, $00, $02, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $33, $00 ; bytes 40-46
SpeciesRecord_Dragon:: ; heuristic: species record; C0
Data_035_4A06:: ; address name
    db $01 ; id 37: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $50, $9D, $00, $11, $01, $14, $10, $07, $04, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $01, $00, $00, $02, $00, $02, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $38, $00 ; bytes 40-46
SpeciesRecord_MiniDrak:: ; heuristic: species record; C0
Data_035_4A35:: ; address name
    db $01 ; id 38: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $6F, $7E, $00, $0E, $08, $11, $0E, $12, $0A, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $00, $01, $00, $00, $01, $00, $00, $02, $00, $02, $00, $00, $01, $02, $02 ; bytes 24-39
    db $01, $02, $01, $01, $01, $43, $00 ; bytes 40-46
SpeciesRecord_MadDragon:: ; heuristic: species record; C0
Data_035_4A64:: ; address name
    db $01 ; id 39: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6B, $6C, $7A, $00, $13, $00, $15, $05, $08, $00, $01, $01, $00, $00, $00, $00 ; bytes 8-23
    db $00, $01, $00, $00, $00, $00, $01, $01, $02, $00, $02, $00, $00, $00, $01, $02 ; bytes 24-39
    db $02, $01, $02, $02, $01, $3E, $00 ; bytes 40-46
SpeciesRecord_Rayburn:: ; heuristic: species record; C0
Data_035_4A93:: ; address name
    db $01 ; id 40: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $11 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $51, $5A, $5F, $02, $0E, $02, $11, $10, $0F, $05, $02, $02, $02, $02, $02, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $01, $00, $00, $02, $00, $02, $01, $00, $00, $00, $00 ; bytes 24-39
    db $02, $01, $02, $01, $01, $45, $00 ; bytes 40-46
SpeciesRecord_Chamelgon:: ; heuristic: species record; C0
Data_035_4AC2:: ; address name
    db $01 ; id 41: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $34, $60, $72, $00, $11, $12, $0B, $06, $08, $0D, $01, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $00, $02, $01, $00, $03, $00, $00, $03, $00, $03, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $3D, $00 ; bytes 40-46
SpeciesRecord_LizardFly:: ; heuristic: species record; C0
Data_035_4AF1:: ; address name
    db $01 ; id 42: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $1E ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $27, $40, $00, $0B, $0B, $11, $11, $0D, $05, $01, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $01, $00, $00, $00, $01, $00, $00, $02, $00, $03, $00, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $00, $3C, $00 ; bytes 40-46
SpeciesRecord_Andreal:: ; heuristic: species record; C0
Data_035_4B20:: ; address name
    db $01 ; id 43: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $2E, $73, $05, $15, $0F, $13, $11, $13, $0C, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $02, $02, $02, $00, $02, $00, $00, $02, $00, $02, $02, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $00, $00, $01, $55, $00 ; bytes 40-46
SpeciesRecord_KingCobra:: ; heuristic: species record; C0
Data_035_4B4F:: ; address name
    db $01 ; id 44: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5F, $75, $79, $00, $12, $08, $10, $0D, $13, $0B, $01, $02, $02, $00, $00, $00 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $01, $01, $03, $01, $02, $00, $02, $00, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $49, $00 ; bytes 40-46
SpeciesRecord_Vampirus:: ; heuristic: species record; C0
Data_035_4B7E:: ; address name
    db $01 ; id 45: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $23 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $4E, $63, $02, $0E, $07, $0A, $08, $13, $08, $01, $02, $02, $01, $00, $00 ; bytes 8-23
    db $01, $01, $01, $00, $00, $00, $00, $01, $02, $00, $02, $00, $01, $00, $01, $01 ; bytes 24-39
    db $00, $00, $00, $00, $00, $37, $00 ; bytes 40-46
SpeciesRecord_SnakeBat:: ; heuristic: species record; C0
Data_035_4BAD:: ; address name
    db $01 ; id 46: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $23 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4B, $8B, $A7, $02, $0A, $09, $15, $0F, $09, $08, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $00, $02, $00, $00, $01, $00, $00, $00, $02, $00, $01, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $38, $00 ; bytes 40-46
SpeciesRecord_Spikerous:: ; heuristic: species record; C0
Data_035_4BDC:: ; address name
    db $01 ; id 47: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4B, $6E, $70, $03, $14, $08, $13, $18, $01, $02, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $00, $01, $01, $00, $00, $01, $00, $00, $03, $00, $02, $00, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $01, $45, $00 ; bytes 40-46
SpeciesRecord_GreatDrak:: ; heuristic: species record; C0
Data_035_4C0B:: ; address name
    db $01 ; id 48: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $3C ; bytes 1-6
    db $17 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $44, $53, $9D, $02, $15, $05, $17, $0E, $10, $0B, $02, $03, $02, $01, $01, $01 ; bytes 8-23
    db $01, $02, $03, $01, $01, $02, $01, $01, $03, $00, $03, $01, $01, $03, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $64, $00 ; bytes 40-46
SpeciesRecord_Crestpent:: ; heuristic: species record; C0
Data_035_4C3A:: ; address name
    db $01 ; id 49: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $01, $00, $23 ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $33, $3B, $5F, $00, $0E, $04, $0F, $05, $13, $08, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $02, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $01, $01, $01, $01, $3B, $00 ; bytes 40-46
SpeciesRecord_WingSnake:: ; heuristic: species record; C0
Data_035_4C69:: ; address name
    db $01 ; id 50: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $2D ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $62, $6A, $73, $00, $0F, $08, $14, $11, $0E, $0B, $03, $03, $02, $01, $01, $00 ; bytes 8-23
    db $00, $00, $02, $00, $01, $00, $00, $00, $03, $00, $03, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $01, $01, $01, $00, $4E, $00 ; bytes 40-46
SpeciesRecord_Coatol:: ; heuristic: species record; C0
Data_035_4C98:: ; address name
    db $01 ; id 51: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $3C ; bytes 1-6
    db $17 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $52, $6B, $00, $19, $0E, $14, $16, $12, $0E, $02, $02, $02, $01, $01, $01 ; bytes 8-23
    db $01, $02, $02, $01, $01, $01, $01, $01, $03, $01, $03, $01, $01, $01, $01, $02 ; bytes 24-39
    db $02, $01, $01, $01, $02, $6C, $00 ; bytes 40-46
SpeciesRecord_Orochi:: ; heuristic: species record; C0
Data_035_4CC7:: ; address name
    db $01 ; id 52: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $3C ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $50, $63, $00, $18, $0D, $18, $15, $0B, $08, $02, $02, $02, $01, $01, $01 ; bytes 8-23
    db $02, $02, $02, $01, $01, $03, $01, $01, $03, $00, $03, $01, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $01, $01, $02, $6C, $00 ; bytes 40-46
SpeciesRecord_BattleRex:: ; heuristic: species record; C0
Data_035_4CF6:: ; address name
    db $01 ; id 53: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $3C ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $5E, $6B, $05, $17, $10, $1A, $14, $11, $10, $02, $02, $02, $02, $02, $01 ; bytes 8-23
    db $01, $02, $02, $01, $01, $01, $01, $01, $03, $00, $03, $01, $01, $02, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $6D, $00 ; bytes 40-46
SpeciesRecord_SkyDragon:: ; heuristic: species record; C0
Data_035_4D25:: ; address name
    db $01 ; id 54: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $01, $00, $06, $01, $28 ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $66, $89, $02, $0F, $0B, $14, $0E, $12, $08, $00, $00, $00, $02, $02, $01 ; bytes 8-23
    db $01, $02, $02, $01, $01, $01, $01, $01, $03, $00, $03, $01, $01, $02, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $61, $00 ; bytes 40-46
SpeciesRecord_Serpentia:: ; heuristic: species record; C0
Data_035_4D54:: ; address name
    db $01 ; id 55: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $37 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $54, $5A, $65, $00, $17, $07, $18, $15, $12, $08, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $02, $02, $02, $01, $01, $02, $01, $01, $03, $00, $02, $00, $01, $01, $01, $01 ; bytes 24-39
    db $01, $01, $02, $02, $02, $67, $00 ; bytes 40-46
SpeciesRecord_Divinegon:: ; heuristic: species record; C0
Data_035_4D83:: ; address name
    db $01 ; id 56: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $06, $01, $46 ; bytes 1-6
    db $1C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3E, $44, $9F, $02, $1A, $19, $1C, $18, $14, $17, $02, $03, $03, $02, $02, $02 ; bytes 8-23
    db $02, $02, $03, $02, $02, $03, $02, $02, $03, $01, $03, $02, $02, $03, $02, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $96, $00 ; bytes 40-46
SpeciesRecord_Orligon:: ; heuristic: species record; C0
Data_035_4DB2:: ; address name
    db $01 ; id 57: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $4B ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2D, $6E, $94, $03, $19, $18, $1C, $19, $15, $18, $03, $03, $03, $02, $02, $01 ; bytes 8-23
    db $02, $02, $03, $02, $02, $03, $02, $02, $03, $00, $03, $02, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $02, $02, $02, $99, $00 ; bytes 40-46
SpeciesRecord_GigaDraco:: ; heuristic: species record; C0
Data_035_4DE1:: ; address name
    db $01 ; id 58: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $01, $46 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $4B, $6C, $03, $1E, $18, $1D, $0C, $06, $0B, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $01, $01, $01, $01, $01, $01, $03, $01, $02, $00, $03, $02, $02, $01 ; bytes 24-39
    db $01, $02, $02, $02, $01, $7A, $00 ; bytes 40-46
SpeciesRecord_Tonguella:: ; heuristic: species record; C0
Data_035_4E10:: ; address name
    db $02 ; id 59: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $61, $71, $8B, $00, $0E, $05, $0F, $0C, $0B, $10, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $03, $03, $01, $01, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $44, $00 ; bytes 40-46
SpeciesRecord_Almiraj:: ; heuristic: species record; C0
Data_035_4E3F:: ; address name
    db $02 ; id 60: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $03, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $68, $6E, $00, $12, $05, $0E, $09, $0F, $04, $01, $01, $01, $00, $00, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $02, $02, $01, $00, $01, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $3B, $00 ; bytes 40-46
SpeciesRecord_CatFly:: ; heuristic: species record; C0
Data_035_4E6E:: ; address name
    db $02 ; id 61: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2B, $33, $76, $00, $0B, $0A, $0D, $08, $12, $0E, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $00, $01, $00, $00, $01, $02, $02, $00, $00, $00, $00, $00, $01, $01, $03 ; bytes 24-39
    db $03, $03, $03, $03, $00, $40, $00 ; bytes 40-46
SpeciesRecord_PillowRat:: ; heuristic: species record; C0
Data_035_4E9D:: ; address name
    db $02 ; id 62: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2B, $6F, $7D, $00, $0E, $11, $08, $08, $13, $0D, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $00, $00, $01, $01, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $01, $44, $00 ; bytes 40-46
SpeciesRecord_Saccer:: ; heuristic: species record; C0
Data_035_4ECC:: ; address name
    db $02 ; id 63: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $69, $72, $00, $10, $05, $09, $11, $00, $0D, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $01, $00, $00, $00, $01, $02, $02, $00, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $03, $03, $01, $3A, $00 ; bytes 40-46
SpeciesRecord_GulpBeast:: ; heuristic: species record; C0
Data_035_4EFB:: ; address name
    db $02 ; id 64: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6C, $6F, $90, $00, $18, $01, $1A, $0D, $07, $01, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $47, $00 ; bytes 40-46
SpeciesRecord_Skullroo:: ; heuristic: species record; C0
Data_035_4F2A:: ; address name
    db $02 ; id 65: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $68, $78, $A8, $00, $0E, $0A, $0B, $08, $10, $02, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $01, $01, $00, $00, $01, $02, $02, $01, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $3C, $00 ; bytes 40-46
SpeciesRecord_WindBeast:: ; heuristic: species record; C0
Data_035_4F59:: ; address name
    db $02 ; id 66: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $10, $51, $02, $0D, $14, $0D, $0F, $0F, $0D, $00, $00, $00, $02, $00, $01 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $48, $00 ; bytes 40-46
SpeciesRecord_Beavern:: ; heuristic: species record; C0
Data_035_4F88:: ; address name
    db $02 ; id 67: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $10, $68, $91, $00, $16, $08, $08, $15, $0A, $07, $00, $00, $00, $01, $00, $02 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $02, $02, $01, $00, $00, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $02, $44, $00 ; bytes 40-46
SpeciesRecord_Antbear:: ; heuristic: species record; C0
Data_035_4FB7:: ; address name
    db $02 ; id 68: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $02, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5E, $62, $8B, $00, $0E, $07, $11, $0B, $09, $0B, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $38, $00 ; bytes 40-46
SpeciesRecord_SuperTen:: ; heuristic: species record; C0
Data_035_4FE6:: ; address name
    db $02 ; id 69: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $79, $7C, $9E, $00, $12, $07, $0D, $0C, $0B, $07, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $02, $01, $00, $00, $02, $02, $02, $00, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $43, $00 ; bytes 40-46
SpeciesRecord_IronTurt:: ; heuristic: species record; C0
Data_035_5015:: ; address name
    db $02 ; id 70: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $39, $94, $97, $03, $12, $05, $11, $17, $02, $0B, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $02, $02, $01, $00, $02, $02, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $47, $00 ; bytes 40-46
SpeciesRecord_Mommonja:: ; heuristic: species record; C0
Data_035_5044:: ; address name
    db $02 ; id 71: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $7A, $93, $A8, $00, $0E, $0B, $10, $0E, $14, $08, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $00, $01, $00, $00, $01, $02, $02, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $48, $00 ; bytes 40-46
SpeciesRecord_HammerMan:: ; heuristic: species record; C0
Data_035_5073:: ; address name
    db $02 ; id 72: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $68, $6B, $70, $03, $11, $13, $11, $0B, $11, $0A, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $01, $4F, $00 ; bytes 40-46
SpeciesRecord_Grizzly:: ; heuristic: species record; C0
Data_035_50A2:: ; address name
    db $02 ; id 73: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $05, $00, $2D ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $62, $63, $8D, $00, $14, $00, $1B, $07, $09, $01, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $02, $02, $03, $02, $01, $42, $00 ; bytes 40-46
SpeciesRecord_Yeti:: ; heuristic: species record; C0
Data_035_50D1:: ; address name
    db $02 ; id 74: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $10, $53, $90, $00, $12, $0B, $0F, $09, $0A, $08, $01, $01, $01, $01, $01, $02 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $03, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $48, $00 ; bytes 40-46
SpeciesRecord_ArrowDog:: ; heuristic: species record; C0
Data_035_5100:: ; address name
    db $02 ; id 75: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $4E, $93, $00, $09, $07, $15, $13, $0D, $0E, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $01, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $40, $00 ; bytes 40-46
SpeciesRecord_NoctoKing:: ; heuristic: species record; C0
Data_035_512F:: ; address name
    db $02 ; id 76: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2E, $71, $84, $02, $16, $0D, $12, $0F, $14, $08, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $00, $01, $01, $01, $00, $02, $02, $00, $00, $00, $00, $00, $00, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $4B, $00 ; bytes 40-46
SpeciesRecord_BeastNite:: ; heuristic: species record; C0
Data_035_515E:: ; address name
    db $02 ; id 77: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $65, $67, $05, $15, $04, $16, $0E, $08, $06, $00, $00, $00, $01, $00, $00 ; bytes 8-23
    db $00, $02, $01, $00, $00, $00, $02, $02, $01, $00, $00, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $43, $00 ; bytes 40-46
SpeciesRecord_MadGopher:: ; heuristic: species record; C0
Data_035_518D:: ; address name
    db $02 ; id 78: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $57, $5B, $A6, $00, $0E, $0D, $11, $09, $08, $0B, $01, $01, $00, $00, $00, $01 ; bytes 8-23
    db $00, $00, $02, $00, $00, $00, $02, $02, $02, $00, $01, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $42, $00 ; bytes 40-46
SpeciesRecord_FairyRat:: ; heuristic: species record; C0
Data_035_51BC:: ; address name
    db $02 ; id 79: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $01, $00, $04, $01, $2D ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2B, $2E, $54, $00, $0C, $05, $0D, $0E, $11, $07, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $00, $01, $00, $00, $00, $01, $02, $02, $01, $00, $01, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $40, $00 ; bytes 40-46
SpeciesRecord_Unicorn:: ; heuristic: species record; C0
Data_035_51EB:: ; address name
    db $02 ; id 80: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $1E, $A7, $02, $13, $15, $0E, $0D, $0C, $19, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $02, $02, $01, $01, $02, $03, $03, $01, $01, $00, $02, $00, $01, $01, $03 ; bytes 24-39
    db $02, $02, $03, $02, $02, $63, $00 ; bytes 40-46
SpeciesRecord_Goategon:: ; heuristic: species record; C0
Data_035_521A:: ; address name
    db $02 ; id 81: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $2B, $71, $00, $13, $09, $11, $0D, $11, $03, $00, $01, $01, $00, $00, $02 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $03, $03, $01, $01, $01, $02, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $50, $00 ; bytes 40-46
SpeciesRecord_WildApe:: ; heuristic: species record; C0
Data_035_5249:: ; address name
    db $02 ; id 82: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6D, $7D, $A7, $00, $0D, $01, $14, $0A, $08, $04, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $40, $00 ; bytes 40-46
SpeciesRecord_Trumpeter:: ; heuristic: species record; C0
Data_035_5278:: ; address name
    db $02 ; id 83: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6E, $7E, $90, $03, $11, $08, $15, $11, $0E, $0D, $00, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $00, $02, $00, $00, $01, $02, $03, $01, $00, $00, $01, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $58, $00 ; bytes 40-46
SpeciesRecord_KingLeo:: ; heuristic: species record; C0
Data_035_52A7:: ; address name
    db $02 ; id 84: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $3C ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $44, $63, $00, $14, $0E, $18, $17, $11, $0E, $01, $01, $01, $02, $02, $01 ; bytes 8-23
    db $01, $01, $03, $01, $01, $02, $03, $03, $03, $01, $01, $02, $01, $02, $01, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $7C, $00 ; bytes 40-46
SpeciesRecord_DarkHorn:: ; heuristic: species record; C0
Data_035_52D6:: ; address name
    db $02 ; id 85: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $33, $69, $00, $11, $04, $13, $12, $0A, $0C, $01, $01, $00, $00, $00, $01 ; bytes 8-23
    db $01, $02, $03, $01, $03, $01, $03, $03, $03, $01, $01, $01, $00, $02, $01, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $64, $00 ; bytes 40-46
SpeciesRecord_MadCat:: ; heuristic: species record; C0
Data_035_5305:: ; address name
    db $02 ; id 86: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $51, $62, $8D, $00, $0F, $07, $12, $0E, $11, $0B, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $00, $01, $03, $00, $00, $00, $02, $02, $03, $00, $01, $01, $00, $01, $00, $03 ; bytes 24-39
    db $02, $02, $02, $02, $01, $53, $00 ; bytes 40-46
SpeciesRecord_BigEye:: ; heuristic: species record; C0
Data_035_5334:: ; address name
    db $02 ; id 87: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $10, $44, $A1, $00, $0E, $08, $0E, $0B, $07, $09, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $01, $03, $00, $02, $00, $02, $02, $03, $00, $00, $00, $00, $01, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $48, $00 ; bytes 40-46
SpeciesRecord_Gorago:: ; heuristic: species record; C0
Data_035_5363:: ; address name
    db $02 ; id 88: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $41 ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $6C, $80, $00, $1D, $1C, $1E, $18, $18, $06, $02, $02, $02, $01, $01, $02 ; bytes 8-23
    db $02, $02, $02, $02, $02, $01, $03, $03, $03, $01, $01, $02, $02, $01, $01, $03 ; bytes 24-39
    db $03, $02, $02, $02, $02, $90, $00 ; bytes 40-46
SpeciesRecord_CatMage:: ; heuristic: species record; C0
Data_035_5392:: ; address name
    db $02 ; id 89: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $2E, $3A, $00, $07, $06, $0A, $04, $06, $0F, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $00, $02, $01, $02, $02, $01, $01, $00, $00, $00, $00, $00, $02, $03, $00 ; bytes 24-39
    db $03, $00, $00, $00, $00, $3D, $00 ; bytes 40-46
SpeciesRecord_Dumbira:: ; heuristic: species record; C0
Data_035_53C1:: ; address name
    db $02 ; id 90: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5E, $65, $6D, $05, $0F, $0A, $09, $08, $0E, $07, $00, $00, $01, $00, $00, $02 ; bytes 8-23
    db $02, $01, $03, $00, $00, $01, $02, $02, $01, $00, $01, $02, $01, $01, $01, $03 ; bytes 24-39
    db $01, $02, $02, $02, $01, $49, $00 ; bytes 40-46
SpeciesRecord_Picky:: ; heuristic: species record; C0
Data_035_53F0:: ; address name
    db $03 ; id 91: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $2E, $58, $00, $0B, $0C, $0E, $08, $12, $0D, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $44, $00 ; bytes 40-46
SpeciesRecord_Wyvern:: ; heuristic: species record; C0
Data_035_541F:: ; address name
    db $03 ; id 92: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $2D ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $2F, $44, $02, $11, $0D, $13, $0B, $10, $14, $01, $01, $01, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $4C, $00 ; bytes 40-46
SpeciesRecord_BullBird:: ; heuristic: species record; C0
Data_035_544E:: ; address name
    db $03 ; id 93: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $59, $68, $6F, $00, $0E, $08, $11, $09, $06, $04, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $03, $03, $00, $3B, $00 ; bytes 40-46
SpeciesRecord_Florajay:: ; heuristic: species record; C0
Data_035_547D:: ; address name
    db $03 ; id 94: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $32 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $29, $56, $A0, $00, $06, $12, $0C, $03, $15, $13, $00, $00, $00, $03, $03, $00 ; bytes 8-23
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $00, $43, $00 ; bytes 40-46
SpeciesRecord_DuckKite:: ; heuristic: species record; C0
Data_035_54AC:: ; address name
    db $03 ; id 95: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $1E ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $34, $75, $00, $0B, $0B, $09, $0C, $12, $07, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $01, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $03, $03, $00, $43, $00 ; bytes 40-46
SpeciesRecord_MadPecker:: ; heuristic: species record; C0
Data_035_54DB:: ; address name
    db $03 ; id 96: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $27, $51, $00, $09, $07, $14, $0E, $17, $0D, $01, $01, $01, $03, $03, $01 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $4B, $00 ; bytes 40-46
SpeciesRecord_MadRaven:: ; heuristic: species record; C0
Data_035_550A:: ; address name
    db $03 ; id 97: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6A, $99, $A8, $00, $06, $0E, $11, $0C, $12, $05, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $3F, $00 ; bytes 40-46
SpeciesRecord_MistyWing:: ; heuristic: species record; C0
Data_035_5539:: ; address name
    db $03 ; id 98: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $32 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $38, $80, $A6, $02, $0C, $11, $08, $0F, $16, $0D, $00, $00, $00, $02, $02, $01 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $48, $00 ; bytes 40-46
SpeciesRecord_AquaHawk:: ; heuristic: species record; C0
Data_035_5568:: ; address name
    db $03 ; id 99: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $24, $62, $9B, $00, $07, $08, $06, $0D, $0E, $13, $00, $00, $00, $02, $02, $02 ; bytes 8-23
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $02, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $02, $41, $00 ; bytes 40-46
SpeciesRecord_Dracky:: ; heuristic: species record; C0
Data_035_5597:: ; address name
    db $03 ; id 100: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $02, $01, $32 ; bytes 1-6
    db $02 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $21, $2F, $32, $00, $0B, $04, $08, $0D, $11, $0B, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $34, $00 ; bytes 40-46
SpeciesRecord_KiteHawk:: ; heuristic: species record; C0
Data_035_55C6:: ; address name
    db $03 ; id 101: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $39, $75, $99, $02, $0D, $08, $08, $07, $09, $01, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $01, $01, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $31, $00 ; bytes 40-46
SpeciesRecord_BigRoost:: ; heuristic: species record; C0
Data_035_55F5:: ; address name
    db $03 ; id 102: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $28 ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $51, $7E, $95, $00, $08, $05, $0E, $0C, $11, $08, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $34, $00 ; bytes 40-46
SpeciesRecord_StubBird:: ; heuristic: species record; C0
Data_035_5624:: ; address name
    db $03 ; id 103: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2D, $58, $65, $00, $10, $0C, $14, $14, $0E, $0B, $00, $00, $00, $02, $02, $02 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $02, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $54, $00 ; bytes 40-46
SpeciesRecord_LandOwl:: ; heuristic: species record; C0
Data_035_5653:: ; address name
    db $03 ; id 104: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $52, $7D, $00, $0F, $0A, $15, $0D, $0B, $12, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $00, $00, $01, $02, $02, $01, $00, $00, $00, $00, $01, $01, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $51, $00 ; bytes 40-46
SpeciesRecord_MadGoose:: ; heuristic: species record; C0
Data_035_5682:: ; address name
    db $03 ; id 105: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $1E ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $48, $7A, $00, $11, $06, $11, $0F, $14, $08, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $02, $01, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $01, $01, $02 ; bytes 24-39
    db $02, $02, $03, $03, $01, $4D, $00 ; bytes 40-46
SpeciesRecord_MadCondor:: ; heuristic: species record; C0
Data_035_56B1:: ; address name
    db $03 ; id 106: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $2D ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $19, $66, $02, $0E, $0B, $12, $0C, $11, $0D, $01, $01, $00, $02, $02, $01 ; bytes 8-23
    db $00, $00, $02, $00, $01, $01, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $4E, $00 ; bytes 40-46
SpeciesRecord_Emyu:: ; heuristic: species record; C0
Data_035_56E0:: ; address name
    db $03 ; id 107: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $48, $7C, $A7, $00, $09, $0D, $14, $13, $17, $1E, $00, $00, $00, $03, $02, $00 ; bytes 8-23
    db $01, $00, $01, $02, $02, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $59, $00 ; bytes 40-46
SpeciesRecord_Blizzardy:: ; heuristic: species record; C0
Data_035_570F:: ; address name
    db $03 ; id 108: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $01, $00, $05, $01, $32 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $44, $53, $02, $14, $07, $0B, $11, $13, $0B, $01, $01, $00, $02, $02, $03 ; bytes 8-23
    db $00, $00, $02, $00, $00, $01, $00, $00, $01, $00, $01, $03, $00, $01, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $54, $00 ; bytes 40-46
SpeciesRecord_Phoenix:: ; heuristic: species record; C0
Data_035_573E:: ; address name
    db $03 ; id 109: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $01, $00, $06, $01, $32 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $62, $99, $00, $10, $0D, $13, $08, $13, $0C, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $03, $00, $00, $01, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $00, $54, $00 ; bytes 40-46
SpeciesRecord_ZapBird:: ; heuristic: species record; C0
Data_035_576D:: ; address name
    db $03 ; id 110: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $32 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3F, $4A, $52, $02, $14, $07, $13, $11, $16, $0C, $01, $01, $01, $03, $03, $01 ; bytes 8-23
    db $00, $00, $01, $02, $00, $02, $00, $00, $01, $00, $01, $01, $00, $01, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $5A, $00 ; bytes 40-46
SpeciesRecord_Garudian:: ; heuristic: species record; C0
Data_035_579C:: ; address name
    db $03 ; id 111: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $32 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $48, $5D, $02, $0A, $07, $08, $0E, $16, $09, $01, $01, $01, $02, $02, $01 ; bytes 8-23
    db $03, $00, $03, $00, $02, $00, $00, $00, $01, $01, $01, $01, $02, $03, $03, $03 ; bytes 24-39
    db $02, $02, $02, $02, $00, $46, $00 ; bytes 40-46
SpeciesRecord_WhipBird:: ; heuristic: species record; C0
Data_035_57CB:: ; address name
    db $03 ; id 112: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $06, $01, $3C ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $35, $84, $85, $03, $1B, $13, $0C, $14, $17, $17, $01, $01, $01, $02, $02, $01 ; bytes 8-23
    db $01, $01, $02, $00, $00, $01, $00, $00, $02, $00, $01, $01, $00, $02, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $67, $00 ; bytes 40-46
SpeciesRecord_FunkyBird:: ; heuristic: species record; C0
Data_035_57FA:: ; address name
    db $03 ; id 113: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $78, $7B, $7C, $00, $0E, $14, $08, $09, $10, $14, $00, $00, $00, $03, $03, $00 ; bytes 8-23
    db $01, $00, $02, $01, $01, $01, $00, $00, $03, $00, $00, $00, $00, $02, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $01, $54, $00 ; bytes 40-46
SpeciesRecord_RainHawk:: ; heuristic: species record; C0
Data_035_5829:: ; address name
    db $03 ; id 114: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $46 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3D, $81, $94, $02, $19, $1B, $0F, $18, $12, $18, $02, $02, $02, $03, $02, $02 ; bytes 8-23
    db $01, $01, $02, $01, $01, $03, $03, $01, $03, $01, $02, $03, $01, $02, $01, $03 ; bytes 24-39
    db $03, $03, $03, $03, $01, $8A, $00 ; bytes 40-46
SpeciesRecord_Azurile:: ; heuristic: species record; C0
Data_035_5858:: ; address name
    db $03 ; id 115: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $06, $01, $4B ; bytes 1-6
    db $1C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3F, $9F, $A0, $02, $1B, $18, $18, $0C, $18, $0C, $02, $02, $02, $03, $03, $02 ; bytes 8-23
    db $01, $01, $02, $02, $02, $03, $02, $02, $02, $02, $03, $03, $03, $01, $01, $03 ; bytes 24-39
    db $03, $03, $03, $03, $02, $90, $00 ; bytes 40-46
SpeciesRecord_Shantak:: ; heuristic: species record; C0
Data_035_5887:: ; address name
    db $03 ; id 116: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $06, $01, $3C ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $19, $40, $9D, $02, $18, $16, $12, $14, $18, $16, $01, $01, $01, $02, $02, $02 ; bytes 8-23
    db $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $02, $02, $02, $03 ; bytes 24-39
    db $03, $03, $03, $03, $02, $84, $00 ; bytes 40-46
SpeciesRecord_CragDevil:: ; heuristic: species record; C0
Data_035_58B6:: ; address name
    db $03 ; id 117: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $01, $00, $23 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $34, $A8, $00, $07, $08, $0D, $05, $0E, $0B, $00, $00, $00, $00, $00, $03 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $03, $00, $01, $00, $02 ; bytes 24-39
    db $01, $01, $00, $00, $02, $8A, $00 ; bytes 40-46
SpeciesRecord_MadPlant:: ; heuristic: species record; C0
Data_035_58E5:: ; address name
    db $04 ; id 118: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $23, $27, $2B, $00, $0F, $18, $0B, $0D, $06, $12, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $03, $03, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $4C, $00 ; bytes 40-46
SpeciesRecord_FireWeed:: ; heuristic: species record; C0
Data_035_5914:: ; address name
    db $04 ; id 119: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $2D ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $22, $72, $00, $0E, $1A, $0A, $0C, $05, $11, $01, $01, $01, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $00, $00, $01, $00, $02, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $01, $48, $00 ; bytes 40-46
SpeciesRecord_FloraMan:: ; heuristic: species record; C0
Data_035_5943:: ; address name
    db $04 ; id 120: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $21, $24, $00, $11, $14, $06, $09, $02, $13, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $02, $44, $00 ; bytes 40-46
SpeciesRecord_WingTree:: ; heuristic: species record; C0
Data_035_5972:: ; address name
    db $04 ; id 121: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $20, $5B, $A4, $02, $0C, $14, $06, $0B, $0E, $07, $00, $00, $00, $03, $03, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $01, $41, $00 ; bytes 40-46
SpeciesRecord_CactiBall:: ; heuristic: species record; C0
Data_035_59A1:: ; address name
    db $04 ; id 122: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $01, $00, $1E ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $60, $6A, $76, $00, $12, $12, $0C, $0F, $09, $05, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $01, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $01, $01, $02, $44, $00 ; bytes 40-46
SpeciesRecord_Gulpple:: ; heuristic: species record; C0
Data_035_59D0:: ; address name
    db $04 ; id 123: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $61, $6A, $71, $00, $10, $11, $09, $06, $02, $0E, $01, $01, $01, $02, $02, $01 ; bytes 8-23
    db $00, $00, $01, $02, $02, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $3C, $00 ; bytes 40-46
SpeciesRecord_Toadstool:: ; heuristic: species record; C0
Data_035_59FF:: ; address name
    db $04 ; id 124: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $61, $71, $93, $00, $0E, $12, $08, $09, $0D, $0D, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $02, $02, $01, $00, $00, $01, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $44, $00 ; bytes 40-46
SpeciesRecord_AmberWeed:: ; heuristic: species record; C0
Data_035_5A2E:: ; address name
    db $04 ; id 125: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2D, $38, $39, $00, $0C, $18, $08, $11, $0C, $0A, $00, $00, $00, $02, $02, $01 ; bytes 8-23
    db $00, $00, $01, $02, $02, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $47, $00 ; bytes 40-46
SpeciesRecord_Slurperon:: ; heuristic: species record; C0
Data_035_5A5D:: ; address name
    db $04 ; id 126: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $76, $8B, $00, $08, $05, $07, $02, $07, $02, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $00, $00, $01, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $2A, $00 ; bytes 40-46
SpeciesRecord_Stubsuck:: ; heuristic: species record; C0
Data_035_5A8C:: ; address name
    db $04 ; id 127: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $5B, $A4, $00, $11, $0B, $04, $02, $09, $0E, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $02, $03, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $33, $00 ; bytes 40-46
SpeciesRecord_Oniono:: ; heuristic: species record; C0
Data_035_5ABB:: ; address name
    db $04 ; id 128: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $32, $68, $71, $00, $0D, $14, $0E, $0B, $03, $10, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $01, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $01, $01, $02, $44, $00 ; bytes 40-46
SpeciesRecord_DanceVegi:: ; heuristic: species record; C0
Data_035_5AEA:: ; address name
    db $04 ; id 129: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $79, $7A, $7D, $00, $0B, $15, $07, $06, $14, $0B, $01, $01, $00, $02, $02, $01 ; bytes 8-23
    db $00, $00, $02, $03, $02, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $02 ; bytes 24-39
    db $03, $03, $00, $00, $02, $47, $00 ; bytes 40-46
SpeciesRecord_TreeBoy:: ; heuristic: species record; C0
Data_035_5B19:: ; address name
    db $04 ; id 130: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1B, $24, $7C, $00, $0F, $12, $08, $03, $0C, $0F, $01, $01, $01, $03, $03, $01 ; bytes 8-23
    db $00, $01, $02, $02, $02, $01, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $49, $00 ; bytes 40-46
SpeciesRecord_Devipine:: ; heuristic: species record; C0
Data_035_5B48:: ; address name
    db $04 ; id 131: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $71, $73, $00, $0E, $07, $08, $04, $05, $03, $01, $01, $01, $02, $02, $00 ; bytes 8-23
    db $00, $00, $00, $02, $02, $00, $00, $00, $01, $00, $01, $00, $01, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $34, $00 ; bytes 40-46
SpeciesRecord_FaceTree:: ; heuristic: species record; C0
Data_035_5B77:: ; address name
    db $04 ; id 132: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $33, $75, $76, $00, $0C, $14, $0B, $08, $0A, $11, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $02, $02, $02, $02, $01, $00, $00, $03, $00, $00, $00, $01, $02, $02, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $51, $00 ; bytes 40-46
SpeciesRecord_HerbMan:: ; heuristic: species record; C0
Data_035_5BA6:: ; address name
    db $04 ; id 133: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $75, $8A, $92, $00, $13, $11, $07, $0A, $0F, $17, $00, $00, $00, $03, $03, $00 ; bytes 8-23
    db $00, $00, $02, $02, $02, $00, $00, $00, $03, $00, $00, $00, $00, $02, $00, $03 ; bytes 24-39
    db $03, $03, $01, $01, $02, $58, $00 ; bytes 40-46
SpeciesRecord_BeanMan:: ; heuristic: species record; C0
Data_035_5BD5:: ; address name
    db $04 ; id 134: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2D, $32, $A9, $00, $0E, $0F, $0C, $0E, $0F, $09, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $00, $00, $01, $02, $02, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $02, $02, $01, $4B, $00 ; bytes 40-46
SpeciesRecord_EvilSeed:: ; heuristic: species record; C0
Data_035_5C04:: ; address name
    db $04 ; id 135: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5C, $60, $7F, $02, $08, $0B, $08, $05, $01, $03, $01, $01, $01, $03, $03, $01 ; bytes 8-23
    db $00, $00, $01, $02, $02, $01, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $02, $32, $00 ; bytes 40-46
SpeciesRecord_ManEater:: ; heuristic: species record; C0
Data_035_5C33:: ; address name
    db $04 ; id 136: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $55, $69, $71, $00, $0E, $0C, $13, $07, $0A, $06, $01, $01, $01, $02, $02, $01 ; bytes 8-23
    db $00, $00, $01, $03, $03, $01, $00, $00, $02, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $00, $00, $01, $47, $00 ; bytes 40-46
SpeciesRecord_Snapper:: ; heuristic: species record; C0
Data_035_5C62:: ; address name
    db $04 ; id 137: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $33, $4E, $65, $00, $11, $0E, $14, $0D, $0A, $10, $01, $01, $01, $02, $02, $01 ; bytes 8-23
    db $00, $00, $02, $03, $03, $01, $00, $00, $03, $00, $00, $00, $00, $00, $00, $03 ; bytes 24-39
    db $03, $03, $00, $00, $01, $57, $00 ; bytes 40-46
SpeciesRecord_GhosTree:: ; heuristic: species record; C0
Data_035_5C91:: ; address name
    db $04 ; id 138: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $32, $7A, $80, $00, $08, $0D, $09, $06, $07, $0F, $00, $00, $00, $02, $02, $00 ; bytes 8-23
    db $01, $01, $01, $02, $02, $01, $00, $00, $02, $00, $00, $00, $01, $01, $01, $02 ; bytes 24-39
    db $02, $02, $00, $00, $01, $3E, $00 ; bytes 40-46
SpeciesRecord_Rosevine:: ; heuristic: species record; C0
Data_035_5CC0:: ; address name
    db $04 ; id 139: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $06, $00, $46 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $63, $82, $96, $00, $18, $1E, $17, $15, $12, $12, $01, $01, $01, $03, $03, $01 ; bytes 8-23
    db $01, $01, $02, $03, $03, $01, $01, $01, $03, $01, $01, $01, $01, $02, $01, $03 ; bytes 24-39
    db $03, $03, $01, $01, $03, $81, $00 ; bytes 40-46
SpeciesRecord_Egdracil:: ; heuristic: species record; C0
Data_035_5CEF:: ; address name
    db $04 ; id 140: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $46 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1E, $71, $9D, $00, $19, $12, $15, $18, $0F, $17, $01, $01, $01, $03, $03, $01 ; bytes 8-23
    db $02, $02, $03, $03, $03, $01, $01, $01, $03, $01, $01, $01, $02, $01, $01, $03 ; bytes 24-39
    db $03, $03, $01, $01, $03, $80, $00 ; bytes 40-46
SpeciesRecord_Warubou:: ; heuristic: species record; C0
Data_035_5D1E:: ; address name
    db $04 ; id 141: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $50 ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1B, $83, $A3, $00, $16, $07, $0C, $0D, $18, $04, $02, $02, $02, $03, $03, $03 ; bytes 8-23
    db $01, $01, $03, $03, $03, $01, $01, $01, $03, $02, $02, $02, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $02, $01, $02, $72, $00 ; bytes 40-46
SpeciesRecord_Watabou:: ; heuristic: species record; C0
Data_035_5D4D:: ; address name
    db $04 ; id 142: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $50 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3C, $9E, $A2, $00, $0A, $1B, $0B, $0E, $18, $1E, $02, $02, $02, $03, $03, $03 ; bytes 8-23
    db $01, $03, $03, $03, $03, $03, $01, $01, $03, $01, $02, $03, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $01, $01, $02, $8F, $00 ; bytes 40-46
SpeciesRecord_Eggplaton:: ; heuristic: species record; C0
Data_035_5D7C:: ; address name
    db $04 ; id 143: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $02, $00, $1E ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1B, $76, $7A, $00, $08, $0E, $0D, $13, $07, $0E, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $01, $01, $03, $03, $01, $01, $01, $01, $00, $00, $00, $01, $01, $02, $00 ; bytes 24-39
    db $00, $00, $00, $01, $02, $32, $00 ; bytes 40-46
SpeciesRecord_FooHero:: ; heuristic: species record; C0
Data_035_5DAB:: ; address name
    db $04 ; id 144: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $01, $00, $2D ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0D, $16, $67, $00, $08, $04, $07, $04, $09, $07, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $01, $02, $03, $03, $02, $02, $01, $02, $00, $01, $01, $01, $02, $00, $01 ; bytes 24-39
    db $03, $00, $01, $01, $02, $4D, $00 ; bytes 40-46
SpeciesRecord_GiantSlug:: ; heuristic: species record; C0
Data_035_5DDA:: ; address name
    db $05 ; id 145: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $02 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $8B, $95, $A2, $00, $0B, $08, $0E, $09, $0B, $07, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $03, $01, $01, $01, $03, $01, $01, $01, $01, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $00, $3C, $00 ; bytes 40-46
SpeciesRecord_Catapila:: ; heuristic: species record; C0
Data_035_5E09:: ; address name
    db $05 ; id 146: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $5F, $84, $00, $0D, $05, $0B, $0E, $0B, $09, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $00, $00, $01, $00, $01, $01, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $01, $3F, $00 ; bytes 40-46
SpeciesRecord_Gophecada:: ; heuristic: species record; C0
Data_035_5E38:: ; address name
    db $05 ; id 147: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $01 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $36, $4E, $00, $06, $0B, $0E, $12, $08, $07, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $01, $01, $00, $00, $00, $00, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $03, $03, $00, $3E, $00 ; bytes 40-46
SpeciesRecord_Butterfly:: ; heuristic: species record; C0
Data_035_5E67:: ; address name
    db $05 ; id 148: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $1E ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2E, $4E, $75, $00, $0B, $02, $0D, $07, $0C, $08, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $03, $03, $00, $36, $00 ; bytes 40-46
SpeciesRecord_WeedBug:: ; heuristic: species record; C0
Data_035_5E96:: ; address name
    db $05 ; id 149: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $32, $38, $39, $00, $11, $0D, $0A, $0C, $05, $13, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $02, $00, $01, $01, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $02, $02, $01, $45, $00 ; bytes 40-46
SpeciesRecord_GiantWorm:: ; heuristic: species record; C0
Data_035_5EC5:: ; address name
    db $05 ; id 150: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $56, $76, $A4, $00, $0D, $08, $10, $08, $0D, $0E, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $02, $01, $00, $00, $02, $00, $00, $01, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $01, $41, $00 ; bytes 40-46
SpeciesRecord_Lipsy:: ; heuristic: species record; C0
Data_035_5EF4:: ; address name
    db $05 ; id 151: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $8B, $8F, $A3, $00, $0C, $08, $09, $09, $04, $01, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $03, $01, $00, $00, $03, $00, $00, $01, $00, $00, $00, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $02, $02, $01, $33, $00 ; bytes 40-46
SpeciesRecord_StagBug:: ; heuristic: species record; C0
Data_035_5F23:: ; address name
    db $05 ; id 152: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $40, $8D, $00, $0D, $07, $10, $14, $09, $07, $01, $01, $00, $00, $00, $01 ; bytes 8-23
    db $00, $02, $01, $00, $00, $02, $00, $00, $01, $00, $01, $01, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $01, $40, $00 ; bytes 40-46
SpeciesRecord_Pyuro:: ; heuristic: species record; C0
Data_035_5F52:: ; address name
    db $05 ; id 153: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $28 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $29, $48, $93, $02, $08, $08, $07, $0D, $0B, $0E, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $02, $01, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $02, $3A, $00 ; bytes 40-46
SpeciesRecord_ArmyAnt:: ; heuristic: species record; C0
Data_035_5F81:: ; address name
    db $05 ; id 154: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $02, $00, $23 ; bytes 1-6
    db $02 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $61, $70, $00, $08, $04, $0B, $11, $0D, $01, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $00, $2F, $00 ; bytes 40-46
SpeciesRecord_GoHopper:: ; heuristic: species record; C0
Data_035_5FB0:: ; address name
    db $05 ; id 155: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $32, $4E, $68, $00, $0B, $04, $08, $0E, $0E, $04, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $00, $30, $00 ; bytes 40-46
SpeciesRecord_TailEater:: ; heuristic: species record; C0
Data_035_5FDF:: ; address name
    db $05 ; id 156: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $02, $00, $2D ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $53, $73, $7F, $00, $0C, $0A, $10, $0B, $0E, $05, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $02, $00, $01, $01, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $02, $02, $02, $02, $01, $40, $00 ; bytes 40-46
SpeciesRecord_ArmorPede:: ; heuristic: species record; C0
Data_035_600E:: ; address name
    db $05 ; id 157: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $2D, $6D, $03, $0F, $0A, $11, $14, $0B, $02, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $00, $00, $00, $00, $01, $01, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $03, $03, $00, $4A, $00 ; bytes 40-46
SpeciesRecord_Eyeder:: ; heuristic: species record; C0
Data_035_603D:: ; address name
    db $05 ; id 158: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $2D ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $16, $A9, $02, $09, $0B, $06, $03, $0A, $09, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $00, $02, $01, $01, $01, $02, $00, $00, $01, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $02, $02, $01, $36, $00 ; bytes 40-46
SpeciesRecord_GiantMoth:: ; heuristic: species record; C0
Data_035_606C:: ; address name
    db $05 ; id 159: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $01, $00, $04, $01, $1E ; bytes 1-6
    db $02 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $48, $60, $7F, $02, $0E, $09, $10, $0C, $14, $0C, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $03, $01, $00, $00, $02, $01, $01, $01, $00, $00, $00, $03, $02, $02, $01 ; bytes 24-39
    db $01, $01, $03, $03, $00, $4C, $00 ; bytes 40-46
SpeciesRecord_Droll:: ; heuristic: species record; C0
Data_035_609B:: ; address name
    db $05 ; id 160: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2B, $59, $A4, $00, $11, $0A, $0F, $10, $07, $0E, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $03, $01, $01, $00, $03, $00, $00, $01, $00, $00, $00, $03, $03, $03, $01 ; bytes 24-39
    db $01, $01, $02, $02, $01, $4C, $00 ; bytes 40-46
SpeciesRecord_ArmyCrab:: ; heuristic: species record; C0
Data_035_60CA:: ; address name
    db $05 ; id 161: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $4E, $5E, $01, $10, $08, $0E, $13, $05, $01, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $01, $03, $01, $00, $00, $03, $00, $00, $00, $00, $00, $00, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $03, $03, $01, $41, $00 ; bytes 40-46
SpeciesRecord_MadHornet:: ; heuristic: species record; C0
Data_035_60F9:: ; address name
    db $05 ; id 162: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5F, $60, $99, $00, $14, $05, $13, $0D, $14, $04, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $00, $02, $00, $00, $00, $02, $01, $01, $00, $00, $01, $01, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $03, $03, $00, $4D, $00 ; bytes 40-46
SpeciesRecord_Belzebub:: ; heuristic: species record; C0
Data_035_6128:: ; address name
    db $05 ; id 163: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $23 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $20, $6F, $00, $17, $13, $08, $07, $0E, $03, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $02, $03, $00, $00, $03, $00, $00, $01, $01, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $02, $02, $00, $45, $00 ; bytes 40-46
SpeciesRecord_WarMantis:: ; heuristic: species record; C0
Data_035_6157:: ; address name
    db $05 ; id 164: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $51, $59, $67, $05, $17, $10, $0C, $09, $0B, $08, $01, $00, $00, $01, $00, $01 ; bytes 8-23
    db $01, $02, $03, $01, $01, $02, $01, $01, $01, $01, $01, $01, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $02, $02, $01, $5A, $00 ; bytes 40-46
SpeciesRecord_HornBeet:: ; heuristic: species record; C0
Data_035_6186:: ; address name
    db $05 ; id 165: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4B, $52, $5A, $00, $15, $13, $17, $14, $0C, $0E, $02, $02, $02, $00, $00, $02 ; bytes 8-23
    db $00, $02, $01, $00, $00, $02, $00, $00, $01, $00, $02, $02, $02, $03, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $02, $65, $00 ; bytes 40-46
SpeciesRecord_Sickler:: ; heuristic: species record; C0
Data_035_61B5:: ; address name
    db $05 ; id 166: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $5A, $62, $00, $13, $0D, $09, $07, $0E, $05, $00, $00, $01, $01, $00, $01 ; bytes 8-23
    db $01, $02, $02, $01, $01, $02, $01, $01, $01, $01, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $02, $02, $01, $49, $00 ; bytes 40-46
SpeciesRecord_Armorpion:: ; heuristic: species record; C0
Data_035_61E4:: ; address name
    db $05 ; id 167: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $37 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5B, $65, $6B, $03, $16, $14, $18, $17, $0F, $12, $01, $02, $02, $01, $00, $02 ; bytes 8-23
    db $01, $03, $02, $01, $01, $03, $01, $01, $03, $01, $02, $02, $03, $03, $03, $01 ; bytes 24-39
    db $01, $01, $03, $03, $01, $81, $00 ; bytes 40-46
SpeciesRecord_Digster:: ; heuristic: species record; C0
Data_035_6213:: ; address name
    db $05 ; id 168: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $32 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $20, $94, $9D, $01, $18, $0A, $13, $1A, $01, $0F, $01, $01, $01, $00, $00, $01 ; bytes 8-23
    db $01, $02, $02, $00, $00, $02, $00, $00, $03, $00, $01, $01, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $02, $02, $03, $59, $00 ; bytes 40-46
SpeciesRecord_Skularach:: ; heuristic: species record; C0
Data_035_6242:: ; address name
    db $05 ; id 169: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $41 ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4A, $63, $73, $00, $12, $17, $19, $18, $1E, $15, $03, $03, $03, $02, $01, $03 ; bytes 8-23
    db $01, $03, $02, $01, $01, $01, $01, $01, $02, $01, $03, $03, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $03, $03, $01, $92, $00 ; bytes 40-46
SpeciesRecord_MultiEyes:: ; heuristic: species record; C0
Data_035_6271:: ; address name
    db $05 ; id 170: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $2D, $72, $00, $0E, $0F, $13, $0D, $02, $03, $00, $01, $00, $00, $00, $00 ; bytes 8-23
    db $03, $03, $01, $02, $02, $02, $01, $01, $00, $00, $00, $00, $01, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $3F, $00 ; bytes 40-46
SpeciesRecord_Pixy:: ; heuristic: species record; C0
Data_035_62A0:: ; address name
    db $06 ; id 171: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $02, $00, $28 ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $21, $2D, $9C, $00, $0B, $07, $0F, $08, $0F, $04, $02, $02, $01, $01, $01, $02 ; bytes 8-23
    db $01, $01, $03, $02, $02, $02, $01, $01, $03, $01, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $3E, $00 ; bytes 40-46
SpeciesRecord_MedusaEye:: ; heuristic: species record; C0
Data_035_62CF:: ; address name
    db $06 ; id 172: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $1E ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $2E, $59, $00, $0B, $0D, $0E, $0F, $08, $0B, $02, $02, $02, $01, $01, $01 ; bytes 8-23
    db $00, $01, $02, $00, $00, $01, $00, $00, $02, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $00, $01, $01, $01, $44, $00 ; bytes 40-46
SpeciesRecord_AgDevil:: ; heuristic: species record; C0
Data_035_62FE:: ; address name
    db $06 ; id 173: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $15, $71, $00, $10, $0B, $12, $0C, $10, $13, $01, $01, $02, $02, $02, $02 ; bytes 8-23
    db $00, $00, $02, $00, $00, $00, $01, $01, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $01, $01, $02, $01, $01, $52, $00 ; bytes 40-46
SpeciesRecord_Demonite:: ; heuristic: species record; C0
Data_035_632D:: ; address name
    db $06 ; id 174: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $40, $44, $00, $0D, $01, $05, $04, $09, $14, $01, $01, $01, $03, $03, $02 ; bytes 8-23
    db $00, $00, $02, $00, $00, $02, $00, $00, $02, $00, $00, $00, $00, $01, $01, $01 ; bytes 24-39
    db $02, $02, $02, $01, $00, $37, $00 ; bytes 40-46
SpeciesRecord_DarkEye:: ; heuristic: species record; C0
Data_035_635C:: ; address name
    db $06 ; id 175: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5C, $72, $7F, $00, $0B, $12, $0A, $10, $09, $0C, $02, $02, $01, $03, $03, $01 ; bytes 8-23
    db $00, $00, $02, $01, $01, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $01, $00, $00, $01, $44, $00 ; bytes 40-46
SpeciesRecord_EyeBall:: ; heuristic: species record; C0
Data_035_638B:: ; address name
    db $06 ; id 176: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $36, $90, $A5, $00, $10, $11, $0E, $0E, $0D, $08, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $00, $01, $02, $00, $00, $01, $00, $00, $02, $00, $00, $00, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $01, $4A, $00 ; bytes 40-46
SpeciesRecord_SkulRider:: ; heuristic: species record; C0
Data_035_63BA:: ; address name
    db $06 ; id 177: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $50, $65, $8D, $00, $11, $0B, $11, $0D, $0F, $0C, $02, $02, $02, $01, $01, $02 ; bytes 8-23
    db $01, $01, $03, $00, $00, $01, $00, $00, $03, $00, $00, $00, $02, $02, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $4C, $00 ; bytes 40-46
SpeciesRecord_EvilBeast:: ; heuristic: species record; C0
Data_035_63E9:: ; address name
    db $06 ; id 178: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $35, $44, $03, $10, $0A, $14, $16, $04, $0C, $02, $02, $01, $02, $02, $03 ; bytes 8-23
    db $00, $00, $03, $01, $01, $01, $00, $00, $03, $00, $00, $01, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $4A, $00 ; bytes 40-46
SpeciesRecord_Bubblemon:: ; heuristic: species record; C0
Data_035_6418:: ; address name
    db $06 ; id 179: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4C, $53, $96, $01, $0E, $0D, $0F, $07, $07, $04, $01, $01, $01, $01, $01, $03 ; bytes 8-23
    db $00, $00, $03, $00, $00, $00, $00, $00, $03, $00, $00, $03, $00, $00, $01, $00 ; bytes 24-39
    db $00, $02, $00, $00, $02, $3D, $00 ; bytes 40-46
SpeciesRecord_1EyeClown:: ; heuristic: species record; C0
Data_035_6447:: ; address name
    db $06 ; id 180: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $19 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $04, $10, $00, $0A, $01, $05, $09, $09, $11, $01, $01, $01, $02, $02, $02 ; bytes 8-23
    db $00, $00, $03, $00, $01, $00, $00, $00, $03, $00, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $30, $00 ; bytes 40-46
SpeciesRecord_Gremlin:: ; heuristic: species record; C0
Data_035_6476:: ; address name
    db $06 ; id 181: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $01, $00, $03, $01, $19 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $16, $33, $00, $0D, $07, $08, $04, $02, $12, $02, $02, $02, $01, $01, $01 ; bytes 8-23
    db $00, $00, $03, $00, $00, $01, $00, $00, $03, $00, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $31, $00 ; bytes 40-46
SpeciesRecord_ArcDemon:: ; heuristic: species record; C0
Data_035_64A5:: ; address name
    db $06 ; id 182: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $51, $52, $03, $0E, $0D, $11, $0C, $07, $15, $02, $03, $02, $02, $02, $02 ; bytes 8-23
    db $00, $00, $03, $00, $01, $00, $00, $00, $03, $00, $01, $00, $00, $02, $01, $00 ; bytes 24-39
    db $00, $00, $00, $01, $01, $53, $00 ; bytes 40-46
SpeciesRecord_Lionex:: ; heuristic: species record; C0
Data_035_64D4:: ; address name
    db $06 ; id 183: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $15 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $19, $51, $03, $0F, $0B, $0E, $0F, $0C, $13, $01, $03, $02, $02, $02, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $01, $00, $00, $03, $00, $02, $02, $01, $00, $02, $02 ; bytes 24-39
    db $00, $00, $00, $00, $00, $54, $00 ; bytes 40-46
SpeciesRecord_GoatHorn:: ; heuristic: species record; C0
Data_035_6503:: ; address name
    db $06 ; id 184: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $0A, $10, $03, $14, $0B, $11, $0D, $0B, $14, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $00, $00, $03, $00, $01, $01, $02, $02, $03, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $02, $00, $5F, $00 ; bytes 40-46
SpeciesRecord_Orc:: ; heuristic: species record; C0
Data_035_6532:: ; address name
    db $06 ; id 185: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $05, $00, $32 ; bytes 1-6
    db $11 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1E, $27, $57, $00, $13, $07, $13, $0D, $0D, $12, $01, $01, $01, $03, $03, $02 ; bytes 8-23
    db $00, $00, $02, $01, $01, $00, $01, $01, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $00, $4F, $00 ; bytes 40-46
SpeciesRecord_Ogre:: ; heuristic: species record; C0
Data_035_6561:: ; address name
    db $06 ; id 186: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $05, $00, $28 ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5E, $69, $6C, $03, $0F, $08, $14, $0C, $0A, $0C, $01, $01, $02, $02, $02, $02 ; bytes 8-23
    db $00, $00, $02, $00, $00, $00, $01, $01, $02, $00, $00, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $02, $01, $00, $4C, $00 ; bytes 40-46
SpeciesRecord_GateGuard:: ; heuristic: species record; C0
Data_035_6590:: ; address name
    db $06 ; id 187: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $32 ; bytes 1-6
    db $17 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $5C, $84, $00, $12, $0C, $12, $0E, $0A, $0E, $02, $02, $02, $03, $03, $02 ; bytes 8-23
    db $01, $01, $03, $00, $00, $00, $00, $00, $03, $00, $00, $00, $00, $00, $00, $01 ; bytes 24-39
    db $02, $02, $02, $01, $01, $56, $00 ; bytes 40-46
SpeciesRecord_ChopClown:: ; heuristic: species record; C0
Data_035_65BF:: ; address name
    db $06 ; id 188: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2D, $51, $62, $00, $11, $0C, $14, $0B, $14, $0F, $02, $02, $02, $02, $02, $03 ; bytes 8-23
    db $01, $00, $03, $01, $01, $00, $01, $01, $03, $00, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $55, $00 ; bytes 40-46
SpeciesRecord_BossTroll:: ; heuristic: species record; C0
Data_035_65EE:: ; address name
    db $06 ; id 189: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $05, $00, $32 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $6C, $6F, $97, $03, $18, $03, $19, $16, $04, $01, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $00, $03, $00, $00, $00, $00, $00, $03, $00, $01, $01, $00, $02, $00, $01 ; bytes 24-39
    db $00, $00, $00, $01, $00, $49, $00 ; bytes 40-46
SpeciesRecord_Grendal:: ; heuristic: species record; C0
Data_035_661D:: ; address name
    db $06 ; id 190: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $3C ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $50, $55, $97, $05, $17, $01, $12, $18, $0C, $0C, $02, $02, $02, $02, $02, $01 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $01, $03, $00, $00, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $55, $00 ; bytes 40-46
SpeciesRecord_Akubar:: ; heuristic: species record; C0
Data_035_664C:: ; address name
    db $06 ; id 191: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $46 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $44, $8A, $00, $18, $1E, $17, $15, $12, $15, $02, $02, $03, $02, $02, $02 ; bytes 8-23
    db $01, $02, $03, $01, $03, $02, $01, $01, $03, $00, $02, $01, $00, $02, $00, $01 ; bytes 24-39
    db $00, $00, $00, $00, $01, $7C, $00 ; bytes 40-46
SpeciesRecord_MadKnight:: ; heuristic: species record; C0
Data_035_667B:: ; address name
    db $06 ; id 192: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $37 ; bytes 1-6
    db $17 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $56, $67, $6C, $05, $11, $09, $12, $14, $0A, $0C, $01, $01, $01, $01, $01, $02 ; bytes 8-23
    db $02, $02, $03, $00, $01, $01, $01, $01, $03, $00, $01, $01, $02, $02, $02, $01 ; bytes 24-39
    db $00, $00, $00, $00, $01, $52, $00 ; bytes 40-46
SpeciesRecord_EvilWell:: ; heuristic: species record; C0
Data_035_66AA:: ; address name
    db $06 ; id 193: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $68, $90, $00, $17, $0E, $0A, $0F, $06, $08, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $01, $01, $03, $00, $00, $01, $01, $01, $03, $01, $01, $01, $01, $01, $01, $00 ; bytes 24-39
    db $01, $01, $00, $00, $03, $4E, $00 ; bytes 40-46
SpeciesRecord_Gigantes:: ; heuristic: species record; C0
Data_035_66D9:: ; address name
    db $06 ; id 194: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $04, $00, $2D ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $54, $68, $6B, $03, $1B, $00, $1B, $07, $00, $00, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $00, $01, $03, $00, $00, $00, $02, $02, $03, $00, $00, $00, $00, $02, $00, $02 ; bytes 24-39
    db $01, $01, $01, $01, $00, $41, $00 ; bytes 40-46
SpeciesRecord_Centasaur:: ; heuristic: species record; C0
Data_035_6708:: ; address name
    db $06 ; id 195: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $17 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $33, $50, $65, $02, $14, $01, $18, $15, $12, $13, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $01, $00, $02, $00, $01, $01, $01, $01, $03, $00, $00, $01, $01, $02, $01, $02 ; bytes 24-39
    db $00, $00, $00, $00, $01, $5B, $00 ; bytes 40-46
SpeciesRecord_EvilArmor:: ; heuristic: species record; C0
Data_035_6737:: ; address name
    db $06 ; id 196: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $50, $52, $5D, $05, $10, $01, $11, $1D, $05, $0D, $00, $02, $00, $02, $00, $00 ; bytes 8-23
    db $00, $01, $03, $00, $00, $01, $00, $00, $02, $00, $00, $00, $01, $02, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $01, $4C, $00 ; bytes 40-46
SpeciesRecord_Jamirus:: ; heuristic: species record; C0
Data_035_6766:: ; address name
    db $06 ; id 197: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $3C ; bytes 1-6
    db $15 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $63, $99, $02, $18, $09, $15, $18, $17, $12, $02, $02, $02, $03, $03, $01 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $01, $03, $00, $00, $00, $00, $02, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $6D, $00 ; bytes 40-46
SpeciesRecord_Durran:: ; heuristic: species record; C0
Data_035_6795:: ; address name
    db $06 ; id 198: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $46 ; bytes 1-6
    db $1C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $48, $55, $57, $05, $19, $18, $17, $0F, $11, $14, $02, $02, $03, $02, $01, $03 ; bytes 8-23
    db $02, $02, $03, $01, $02, $02, $01, $01, $03, $01, $01, $01, $03, $03, $02, $02 ; bytes 24-39
    db $00, $00, $00, $00, $02, $7D, $00 ; bytes 40-46
SpeciesRecord_Titanis:: ; heuristic: species record; C0
Data_035_67C4:: ; address name
    db $06 ; id 199: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $4B ; bytes 1-6
    db $1B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $6E, $82, $03, $19, $18, $19, $16, $17, $0D, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $01, $01, $03, $01, $01, $02, $01, $01, $03, $01, $02, $02, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $01, $02, $7F, $00 ; bytes 40-46
SpeciesRecord_LampGenie:: ; heuristic: species record; C0
Data_035_67F3:: ; address name
    db $06 ; id 200: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $3C ; bytes 1-6
    db $15 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $2F, $99, $02, $0A, $0C, $0B, $16, $0F, $0A, $01, $01, $01, $01, $00, $00 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $01, $03, $00, $01, $01, $01, $02, $01, $00 ; bytes 24-39
    db $00, $00, $01, $00, $02, $51, $00 ; bytes 40-46
SpeciesRecord_Spooky:: ; heuristic: species record; C0
Data_035_6822:: ; address name
    db $07 ; id 201: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $7F, $93, $A5, $00, $0B, $0C, $0D, $08, $12, $0F, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $03, $03, $03, $01, $01, $03, $01, $01, $03, $01, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $47, $00 ; bytes 40-46
SpeciesRecord_Skullgon:: ; heuristic: species record; C0
Data_035_6851:: ; address name
    db $07 ; id 202: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $44, $53, $6D, $03, $06, $01, $17, $0F, $04, $06, $01, $01, $01, $00, $00, $02 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $03, $00, $00, $02, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $44, $00 ; bytes 40-46
SpeciesRecord_PutrePup:: ; heuristic: species record; C0
Data_035_6880:: ; address name
    db $07 ; id 203: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $2B, $36, $00, $11, $0D, $11, $08, $0B, $04, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $01, $01, $02, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $43, $00 ; bytes 40-46
SpeciesRecord_RotRaven:: ; heuristic: species record; C0
Data_035_68AF:: ; address name
    db $07 ; id 204: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $23 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4A, $52, $70, $00, $0E, $08, $0C, $0B, $12, $09, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $41, $00 ; bytes 40-46
SpeciesRecord_Mummy:: ; heuristic: species record; C0
Data_035_68DE:: ; address name
    db $07 ; id 205: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $60, $6B, $00, $0F, $11, $0C, $09, $04, $08, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $02, $02, $02, $01, $01, $02, $00, $00, $02, $00, $00, $00, $02, $02, $03, $01 ; bytes 24-39
    db $01, $01, $00, $00, $00, $41, $00 ; bytes 40-46
SpeciesRecord_DarkCrab:: ; heuristic: species record; C0
Data_035_690D:: ; address name
    db $07 ; id 206: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $1E ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $35, $39, $A4, $01, $0C, $08, $0F, $14, $01, $0B, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $03, $02, $00, $00, $03, $00, $00, $02, $00, $00, $00, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $01, $01, $00, $42, $00 ; bytes 40-46
SpeciesRecord_DeadNite:: ; heuristic: species record; C0
Data_035_693C:: ; address name
    db $07 ; id 207: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $22, $24, $00, $11, $07, $13, $09, $0C, $08, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $02, $02, $03, $00, $00, $02, $00, $00, $03, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $43, $00 ; bytes 40-46
SpeciesRecord_Shadow:: ; heuristic: species record; C0
Data_035_696B:: ; address name
    db $07 ; id 208: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $32 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $44, $79, $84, $02, $09, $06, $06, $14, $08, $0C, $00, $00, $00, $00, $00, $01 ; bytes 8-23
    db $02, $02, $03, $00, $00, $03, $00, $00, $03, $00, $00, $01, $02, $03, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $3B, $00 ; bytes 40-46
SpeciesRecord_Skulpent:: ; heuristic: species record; C0
Data_035_699A:: ; address name
    db $07 ; id 209: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $5F, $95, $00, $11, $13, $17, $09, $0C, $0A, $01, $01, $01, $01, $00, $01 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $01, $01, $01, $01, $01, $01 ; bytes 24-39
    db $01, $00, $00, $00, $01, $4D, $00 ; bytes 40-46
SpeciesRecord_Hork:: ; heuristic: species record; C0
Data_035_69C9:: ; address name
    db $07 ; id 210: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $73, $80, $8B, $00, $11, $0D, $10, $08, $0B, $0A, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $3F, $00 ; bytes 40-46
SpeciesRecord_Mudron:: ; heuristic: species record; C0
Data_035_69F8:: ; address name
    db $07 ; id 211: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $1B, $1E, $01, $06, $0A, $0B, $11, $07, $0E, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $03, $02, $00, $00, $03, $01, $01, $02, $00, $00, $00, $03, $03, $03, $00 ; bytes 24-39
    db $00, $00, $01, $01, $02, $42, $00 ; bytes 40-46
SpeciesRecord_NiteWhip:: ; heuristic: species record; C0
Data_035_6A27:: ; address name
    db $07 ; id 212: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $03, $01, $23 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $48, $4A, $A6, $00, $11, $04, $0A, $03, $0F, $09, $00, $00, $00, $02, $01, $01 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $3D, $00 ; bytes 40-46
SpeciesRecord_WindMerge:: ; heuristic: species record; C0
Data_035_6A56:: ; address name
    db $07 ; id 213: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $24, $57, $02, $10, $13, $13, $0C, $0D, $06, $00, $00, $00, $03, $01, $00 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $01, $01, $02, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $4F, $00 ; bytes 40-46
SpeciesRecord_Reaper:: ; heuristic: species record; C0
Data_035_6A85:: ; address name
    db $07 ; id 214: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $5A, $75, $80, $00, $13, $03, $15, $11, $13, $06, $00, $00, $00, $01, $01, $00 ; bytes 8-23
    db $02, $03, $02, $01, $01, $03, $00, $00, $02, $00, $00, $01, $03, $03, $03, $01 ; bytes 24-39
    db $01, $00, $01, $01, $01, $53, $00 ; bytes 40-46
SpeciesRecord_Inverzon:: ; heuristic: species record; C0
Data_035_6AB4:: ; address name
    db $07 ; id 215: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2E, $73, $7D, $00, $07, $02, $0E, $07, $04, $01, $00, $00, $00, $01, $00, $01 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $00, $01, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $2C, $00 ; bytes 40-46
SpeciesRecord_FoxFire:: ; heuristic: species record; C0
Data_035_6AE3:: ; address name
    db $07 ; id 216: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $07 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $04, $A5, $00, $09, $0F, $06, $08, $0D, $04, $02, $02, $00, $01, $00, $00 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $02, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $00, $00, $00, $00, $3E, $00 ; bytes 40-46
SpeciesRecord_CaptDead:: ; heuristic: species record; C0
Data_035_6B12:: ; address name
    db $07 ; id 217: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $28 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $5D, $62, $01, $09, $14, $11, $10, $08, $05, $01, $01, $01, $02, $01, $02 ; bytes 8-23
    db $02, $02, $02, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $03, $4A, $00 ; bytes 40-46
SpeciesRecord_DeadNoble:: ; heuristic: species record; C0
Data_035_6B41:: ; address name
    db $07 ; id 218: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $19, $5D, $85, $00, $15, $02, $1A, $13, $0F, $0D, $00, $01, $01, $01, $00, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $02, $00, $00, $03, $00, $00, $02, $02, $03, $02, $03 ; bytes 24-39
    db $00, $00, $00, $00, $00, $5F, $00 ; bytes 40-46
SpeciesRecord_WhiteKing:: ; heuristic: species record; C0
Data_035_6B70:: ; address name
    db $07 ; id 219: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $3C ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $0D, $3C, $00, $14, $18, $0E, $14, $0F, $1B, $01, $01, $02, $03, $01, $03 ; bytes 8-23
    db $02, $02, $03, $01, $01, $03, $01, $01, $03, $01, $01, $02, $03, $03, $03, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $7A, $00 ; bytes 40-46
SpeciesRecord_BoneSlave:: ; heuristic: species record; C0
Data_035_6B9F:: ; address name
    db $07 ; id 220: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $28 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $52, $63, $00, $0E, $0D, $11, $0C, $07, $01, $00, $00, $00, $01, $00, $01 ; bytes 8-23
    db $02, $02, $02, $01, $01, $02, $00, $00, $02, $00, $00, $00, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $3B, $00 ; bytes 40-46
SpeciesRecord_Skeletor:: ; heuristic: species record; C0
Data_035_6BCE:: ; address name
    db $07 ; id 221: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $37 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $57, $63, $05, $10, $0B, $12, $0C, $10, $13, $00, $00, $01, $02, $00, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $02, $00, $00, $03, $00, $00, $01, $02, $02, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $55, $00 ; bytes 40-46
SpeciesRecord_Servant:: ; heuristic: species record; C0
Data_035_6BFD:: ; address name
    db $07 ; id 222: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $46 ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $10, $8A, $05, $17, $15, $19, $12, $0F, $14, $01, $01, $03, $02, $01, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $03, $01, $01, $03, $01, $01, $02, $03, $03, $03, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $7A, $00 ; bytes 40-46
SpeciesRecord_Lazamanus:: ; heuristic: species record; C0
Data_035_6C2C:: ; address name
    db $07 ; id 223: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $4B ; bytes 1-6
    db $1A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $31, $79, $7B, $00, $18, $14, $1E, $14, $0C, $0E, $02, $02, $02, $02, $01, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $03, $01, $01, $03, $00, $02, $02, $01, $01, $01, $01 ; bytes 24-39
    db $01, $01, $01, $02, $01, $78, $00 ; bytes 40-46
SpeciesRecord_Copycat:: ; heuristic: species record; C0
Data_035_6C5B:: ; address name
    db $07 ; id 224: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $28 ; bytes 1-6
    db $01 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3A, $76, $9E, $00, $0B, $14, $01, $02, $15, $05, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $03, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $03, $02, $01 ; bytes 24-39
    db $00, $00, $00, $00, $01, $38, $00 ; bytes 40-46
SpeciesRecord_MadSpirit:: ; heuristic: species record; C0
Data_035_6C8A:: ; address name
    db $07 ; id 225: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $32 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $71, $7F, $84, $02, $0E, $0C, $0F, $0C, $10, $0A, $00, $00, $00, $01, $01, $01 ; bytes 8-23
    db $02, $02, $03, $01, $01, $03, $00, $00, $03, $00, $00, $00, $02, $02, $02, $01 ; bytes 24-39
    db $01, $01, $00, $00, $01, $4D, $00 ; bytes 40-46
SpeciesRecord_PomPomBom:: ; heuristic: species record; C0
Data_035_6CB9:: ; address name
    db $07 ; id 226: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $84, $7B, $00, $05, $15, $0D, $0B, $0E, $15, $00, $00, $02, $01, $01, $00 ; bytes 8-23
    db $03, $03, $03, $00, $01, $02, $00, $00, $02, $00, $00, $01, $01, $01, $03, $01 ; bytes 24-39
    db $00, $00, $00, $00, $00, $48, $00 ; bytes 40-46
SpeciesRecord_Niterich:: ; heuristic: species record; C0
Data_035_6CE8:: ; address name
    db $07 ; id 227: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $41 ; bytes 1-6
    db $14 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $84, $96, $05, $1B, $0D, $18, $17, $13, $15, $00, $00, $00, $02, $02, $03 ; bytes 8-23
    db $03, $03, $03, $01, $01, $02, $01, $01, $03, $01, $00, $03, $01, $03, $03, $01 ; bytes 24-39
    db $00, $01, $01, $02, $02, $3B, $00 ; bytes 40-46
SpeciesRecord_JewelBag:: ; heuristic: species record; C0
Data_035_6D17:: ; address name
    db $08 ; id 228: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $04, $00, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $33, $34, $00, $0D, $0B, $09, $12, $11, $0F, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $01, $03, $01, $00, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $43, $00 ; bytes 40-46
SpeciesRecord_EvilWand:: ; heuristic: species record; C0
Data_035_6D46:: ; address name
    db $08 ; id 229: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $22, $44, $A9, $00, $0E, $0F, $11, $0C, $09, $0D, $01, $01, $01, $00, $00, $02 ; bytes 8-23
    db $00, $00, $03, $00, $00, $02, $00, $00, $03, $00, $01, $02, $00, $00, $03, $01 ; bytes 24-39
    db $01, $01, $00, $00, $01, $3D, $00 ; bytes 40-46
SpeciesRecord_MadCandle:: ; heuristic: species record; C0
Data_035_6D75:: ; address name
    db $08 ; id 230: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $69, $A2, $00, $0C, $0A, $0E, $06, $11, $0C, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $00, $02, $00, $00, $00, $01, $01, $02, $00, $02, $00, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $37, $00 ; bytes 40-46
SpeciesRecord_CoilBird:: ; heuristic: species record; C0
Data_035_6DA4:: ; address name
    db $08 ; id 231: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $22, $23, $9D, $00, $10, $0D, $05, $0E, $0E, $07, $00, $00, $00, $01, $01, $02 ; bytes 8-23
    db $02, $00, $02, $00, $00, $00, $00, $00, $02, $00, $00, $02, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $39, $00 ; bytes 40-46
SpeciesRecord_Facer:: ; heuristic: species record; C0
Data_035_6DD3:: ; address name
    db $08 ; id 232: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $15, $A0, $00, $08, $17, $0B, $0C, $03, $13, $00, $00, $00, $01, $01, $02 ; bytes 8-23
    db $00, $00, $02, $01, $01, $00, $00, $00, $02, $00, $00, $02, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $00, $00, $01, $3C, $00 ; bytes 40-46
SpeciesRecord_SpikyBoy:: ; heuristic: species record; C0
Data_035_6E02:: ; address name
    db $08 ; id 233: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $15, $54, $6A, $00, $09, $0D, $0E, $11, $07, $0B, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $00, $01, $02, $00, $00, $01, $00, $00, $02, $00, $00, $02, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $01, $3A, $00 ; bytes 40-46
SpeciesRecord_MadMirror:: ; heuristic: species record; C0
Data_035_6E31:: ; address name
    db $08 ; id 234: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $36, $3A, $A5, $00, $0F, $0B, $08, $06, $0B, $13, $01, $01, $01, $01, $01, $02 ; bytes 8-23
    db $00, $00, $03, $00, $00, $00, $00, $00, $03, $00, $00, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $02, $3D, $00 ; bytes 40-46
SpeciesRecord_RogueNite:: ; heuristic: species record; C0
Data_035_6E60:: ; address name
    db $08 ; id 235: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $5E, $6B, $00, $0E, $04, $14, $15, $0A, $0D, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $01, $01, $03, $00, $00, $01, $00, $00, $03, $00, $00, $02, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $02, $47, $00 ; bytes 40-46
SpeciesRecord_Puppetor:: ; heuristic: species record; C0
Data_035_6E8F:: ; address name
    db $08 ; id 236: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $23 ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $76, $7A, $A3, $00, $0D, $09, $07, $04, $07, $0B, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $01, $01, $02, $01, $01, $02, $00, $00, $02, $00, $00, $02, $00, $00, $01, $01 ; bytes 24-39
    db $00, $00, $00, $00, $00, $34, $00 ; bytes 40-46
SpeciesRecord_Goopi:: ; heuristic: species record; C0
Data_035_6EBE:: ; address name
    db $08 ; id 237: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $8D, $95, $00, $08, $0D, $0B, $0E, $07, $04, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $00, $00, $02, $00, $00, $00, $00, $00, $02, $00, $00, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $2C, $00 ; bytes 40-46
SpeciesRecord_Voodoll:: ; heuristic: species record; C0
Data_035_6EED:: ; address name
    db $08 ; id 238: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $2E, $34, $00, $0E, $11, $0C, $0C, $08, $0E, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $00, $01, $02, $00, $00, $01, $00, $00, $02, $00, $00, $02, $02, $02, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $01, $42, $00 ; bytes 40-46
SpeciesRecord_MetalDrak:: ; heuristic: species record; C0
Data_035_6F1C:: ; address name
    db $08 ; id 239: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $2D ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $6C, $7E, $03, $12, $0D, $14, $17, $09, $0A, $01, $01, $01, $00, $00, $02 ; bytes 8-23
    db $01, $00, $03, $00, $00, $02, $00, $00, $03, $00, $01, $03, $02, $03, $02, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $51, $00 ; bytes 40-46
SpeciesRecord_Balzak:: ; heuristic: species record; C0
Data_035_6F4B:: ; address name
    db $08 ; id 240: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $23 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $0D, $66, $03, $15, $0B, $17, $15, $12, $13, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $01, $01, $02, $01, $01, $01, $01, $01, $02, $01, $00, $02, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $5D, $00 ; bytes 40-46
SpeciesRecord_SabreMan:: ; heuristic: species record; C0
Data_035_6F7A:: ; address name
    db $08 ; id 241: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $1E ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $32, $5A, $60, $00, $08, $03, $09, $0B, $0C, $06, $00, $00, $01, $01, $00, $02 ; bytes 8-23
    db $00, $01, $02, $01, $01, $01, $00, $00, $02, $00, $00, $02, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $00, $35, $00 ; bytes 40-46
SpeciesRecord_CurseLamp:: ; heuristic: species record; C0
Data_035_6FA9:: ; address name
    db $08 ; id 242: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $2D ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $29, $2D, $02, $0C, $12, $09, $13, $0D, $0F, $00, $00, $00, $02, $01, $02 ; bytes 8-23
    db $00, $00, $02, $01, $01, $00, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $00, $00, $00, $44, $00 ; bytes 40-46
SpeciesRecord_Brushead:: ; heuristic: species record; C0
Data_035_6FD8:: ; address name
    db $08 ; id 243: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $1E ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $76, $7E, $A1, $00, $07, $06, $0E, $04, $04, $03, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $00, $00, $02, $01, $01, $00, $00, $00, $02, $00, $00, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $02, $28, $00 ; bytes 40-46
SpeciesRecord_Roboster:: ; heuristic: species record; C0
Data_035_7007:: ; address name
    db $08 ; id 244: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $05, $00, $28 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $62, $63, $65, $05, $0C, $05, $15, $16, $18, $11, $01, $01, $01, $01, $01, $02 ; bytes 8-23
    db $01, $02, $03, $00, $00, $00, $00, $00, $03, $00, $01, $02, $02, $02, $01, $02 ; bytes 24-39
    db $00, $00, $00, $00, $00, $53, $00 ; bytes 40-46
SpeciesRecord_Roboster2:: ; heuristic: species record; C0
Data_035_7036:: ; address name
    db $08 ; id 245: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $2D ; bytes 1-6
    db $16 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $52, $5E, $67, $03, $17, $0D, $18, $1A, $16, $0C, $02, $02, $02, $02, $02, $03 ; bytes 8-23
    db $02, $03, $03, $00, $00, $00, $00, $00, $03, $00, $02, $03, $03, $03, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $6F, $00 ; bytes 40-46
SpeciesRecord_EvilPot:: ; heuristic: species record; C0
Data_035_7065:: ; address name
    db $08 ; id 246: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $6C, $A5, $00, $12, $13, $0F, $12, $09, $13, $00, $00, $00, $00, $00, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $01, $01, $01, $03, $01, $00, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $4F, $00 ; bytes 40-46
SpeciesRecord_Gismo:: ; heuristic: species record; C0
Data_035_7094:: ; address name
    db $08 ; id 247: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $04, $01, $28 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $44, $89, $02, $0D, $0F, $0B, $0E, $14, $12, $00, $00, $00, $02, $01, $02 ; bytes 8-23
    db $00, $00, $02, $00, $00, $00, $00, $01, $02, $00, $00, $02, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $44, $00 ; bytes 40-46
SpeciesRecord_LavaMan:: ; heuristic: species record; C0
Data_035_70C3:: ; address name
    db $08 ; id 248: family (StringTable_MonsterFamilies index; $FF unused)
    db $03, $00, $00, $06, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $40, $97, $00, $12, $0C, $11, $18, $04, $07, $03, $03, $01, $02, $00, $01 ; bytes 8-23
    db $00, $00, $03, $00, $00, $01, $00, $00, $03, $00, $03, $01, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $4A, $00 ; bytes 40-46
SpeciesRecord_IceMan:: ; heuristic: species record; C0
Data_035_70F2:: ; address name
    db $08 ; id 249: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $2D ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $10, $44, $94, $00, $10, $06, $12, $18, $04, $07, $01, $01, $01, $02, $00, $03 ; bytes 8-23
    db $00, $00, $03, $00, $00, $00, $01, $00, $03, $00, $01, $03, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $02, $47, $00 ; bytes 40-46
SpeciesRecord_Mimic:: ; heuristic: species record; C0
Data_035_7121:: ; address name
    db $08 ; id 250: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $28 ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $13, $A8, $00, $19, $0A, $14, $0C, $01, $14, $00, $00, $01, $02, $01, $02 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $01, $03, $01, $00, $01, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $4E, $00 ; bytes 40-46
SpeciesRecord_Exaucers:: ; heuristic: species record; C0
Data_035_7150:: ; address name
    db $08 ; id 251: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $05, $01, $2D ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $31, $48, $78, $00, $14, $0D, $0F, $06, $07, $04, $01, $01, $00, $00, $00, $02 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $01, $02, $00, $01, $02, $01, $01, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $40, $00 ; bytes 40-46
SpeciesRecord_MudDoll:: ; heuristic: species record; C0
Data_035_717F:: ; address name
    db $08 ; id 252: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $76, $7C, $7D, $00, $0C, $03, $0D, $0E, $01, $0F, $00, $00, $01, $01, $00, $03 ; bytes 8-23
    db $01, $00, $03, $00, $00, $00, $00, $00, $03, $00, $00, $03, $00, $00, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $01, $33, $00 ; bytes 40-46
SpeciesRecord_Golem:: ; heuristic: species record; C0
Data_035_71AE:: ; address name
    db $08 ; id 253: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $2D ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $68, $69, $9F, $03, $11, $04, $0C, $15, $04, $06, $00, $00, $01, $01, $00, $03 ; bytes 8-23
    db $01, $01, $03, $00, $00, $00, $00, $00, $03, $00, $00, $03, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $02, $43, $00 ; bytes 40-46
SpeciesRecord_StoneMan:: ; heuristic: species record; C0
Data_035_71DD:: ; address name
    db $08 ; id 254: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $00, $32 ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $94, $97, $9D, $03, $18, $0A, $17, $18, $01, $0E, $00, $01, $01, $01, $00, $03 ; bytes 8-23
    db $01, $01, $03, $00, $01, $00, $00, $00, $03, $00, $01, $03, $00, $02, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $02, $5D, $00 ; bytes 40-46
SpeciesRecord_BombCrag:: ; heuristic: species record; C0
Data_035_720C:: ; address name
    db $08 ; id 255: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $00, $32 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $15, $20, $4B, $03, $0F, $0B, $11, $14, $00, $0D, $01, $01, $00, $00, $00, $02 ; bytes 8-23
    db $00, $01, $03, $01, $01, $01, $01, $01, $03, $00, $02, $02, $01, $01, $01, $00 ; bytes 24-39
    db $00, $00, $01, $01, $02, $4D, $00 ; bytes 40-46
SpeciesRecord_GoldGolem:: ; heuristic: species record; C0
Data_035_723B:: ; address name
    db $08 ; id 256: family (StringTable_MonsterFamilies index; $FF unused)
    db $01, $00, $00, $06, $00, $4B ; bytes 1-6
    db $12 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3E, $81, $85, $05, $18, $15, $18, $1B, $11, $17, $02, $02, $02, $02, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $02, $02, $03, $01, $02, $02, $03, $03, $03, $02 ; bytes 24-39
    db $02, $02, $01, $01, $02, $92, $00 ; bytes 40-46
SpeciesRecord_DarkMate:: ; heuristic: species record; C0
Data_035_726A:: ; address name
    db $08 ; id 257: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $00, $46 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $13, $3F, $80, $00, $18, $15, $0C, $19, $15, $0A, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $02, $02, $03, $02, $02, $02, $03, $03, $03, $01 ; bytes 24-39
    db $01, $03, $01, $01, $02, $88, $00 ; bytes 40-46
SpeciesRecord_ProtoMech:: ; heuristic: species record; C0
Data_035_7299:: ; address name
    db $08 ; id 258: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $02, $00, $28 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $54, $68, $6F, $00, $03, $02, $06, $03, $04, $06, $00, $00, $00, $01, $00, $00 ; bytes 8-23
    db $01, $01, $03, $01, $01, $01, $01, $00, $02, $00, $00, $00, $03, $02, $00, $00 ; bytes 24-39
    db $00, $00, $00, $00, $00, $4F, $00 ; bytes 40-46
SpeciesRecord_CloudKing:: ; heuristic: species record; C0
Data_035_72C8:: ; address name
    db $08 ; id 259: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $05, $01, $2D ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0A, $38, $81, $02, $08, $18, $0E, $10, $0B, $1A, $01, $00, $00, $01, $03, $01 ; bytes 8-23
    db $00, $02, $03, $02, $02, $01, $00, $00, $01, $00, $02, $02, $03, $02, $01, $01 ; bytes 24-39
    db $01, $00, $00, $02, $02, $75, $00 ; bytes 40-46
SpeciesRecord_Petiteel:: ; heuristic: species record; C0
Data_035_72F7:: ; address name
    db $09 ; id 260: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $02, $23 ; bytes 1-6
    db $03 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $29, $2D, $6F, $00, $0F, $11, $0C, $09, $0E, $0A, $02, $02, $00, $00, $00, $00 ; bytes 8-23
    db $00, $02, $01, $00, $01, $00, $00, $02, $00, $00, $02, $00, $03, $02, $00, $00 ; bytes 24-39
    db $00, $02, $00, $00, $02, $42, $00 ; bytes 40-46
SpeciesRecord_Moray:: ; heuristic: species record; C0
Data_035_7326:: ; address name
    db $09 ; id 261: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $28 ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2F, $69, $73, $01, $0C, $11, $12, $13, $16, $09, $00, $00, $00, $01, $00, $00 ; bytes 8-23
    db $00, $02, $01, $00, $01, $01, $00, $02, $00, $00, $02, $00, $03, $00, $00, $00 ; bytes 24-39
    db $00, $02, $00, $00, $02, $4C, $00 ; bytes 40-46
SpeciesRecord_WalrusMan:: ; heuristic: species record; C0
Data_035_7355:: ; address name
    db $09 ; id 262: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $28 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $58, $6B, $6C, $03, $17, $08, $17, $10, $07, $08, $01, $01, $00, $01, $00, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $01, $00, $02, $01, $00, $02, $00, $01, $02, $02, $01 ; bytes 24-39
    db $01, $02, $00, $00, $02, $4A, $00 ; bytes 40-46
SpeciesRecord_RayGigas:: ; heuristic: species record; C0
Data_035_7384:: ; address name
    db $09 ; id 263: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $28 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $93, $9B, $02, $16, $09, $18, $13, $09, $07, $02, $02, $01, $01, $00, $00 ; bytes 8-23
    db $01, $02, $00, $00, $00, $01, $00, $02, $00, $00, $02, $00, $00, $00, $00, $02 ; bytes 24-39
    db $02, $02, $01, $00, $02, $4D, $00 ; bytes 40-46
SpeciesRecord_Anemon:: ; heuristic: species record; C0
Data_035_73B3:: ; address name
    db $09 ; id 264: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $28 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $60, $73, $00, $09, $0E, $0A, $0D, $05, $07, $01, $01, $01, $01, $00, $00 ; bytes 8-23
    db $01, $02, $01, $01, $00, $00, $00, $02, $01, $00, $02, $00, $01, $02, $00, $00 ; bytes 24-39
    db $01, $02, $00, $00, $01, $3A, $00 ; bytes 40-46
SpeciesRecord_Aquarella:: ; heuristic: species record; C0
Data_035_73E2:: ; address name
    db $09 ; id 265: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $2D ; bytes 1-6
    db $06 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $38, $62, $91, $00, $0B, $08, $11, $0E, $06, $04, $02, $02, $01, $01, $00, $00 ; bytes 8-23
    db $00, $02, $01, $00, $00, $00, $00, $02, $01, $00, $02, $00, $02, $02, $01, $00 ; bytes 24-39
    db $00, $02, $00, $00, $01, $3A, $00 ; bytes 40-46
SpeciesRecord_Merman:: ; heuristic: species record; C0
Data_035_7411:: ; address name
    db $09 ; id 266: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $23 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1E, $27, $71, $01, $10, $11, $0E, $12, $14, $13, $02, $02, $02, $01, $00, $00 ; bytes 8-23
    db $00, $02, $00, $01, $01, $01, $00, $02, $01, $00, $02, $00, $02, $01, $01, $01 ; bytes 24-39
    db $01, $02, $01, $00, $02, $59, $00 ; bytes 40-46
SpeciesRecord_Octokid:: ; heuristic: species record; C0
Data_035_7440:: ; address name
    db $09 ; id 267: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $16, $1B, $7A, $01, $07, $0F, $07, $0D, $11, $15, $01, $01, $01, $01, $00, $00 ; bytes 8-23
    db $01, $02, $01, $01, $01, $00, $00, $02, $00, $00, $02, $00, $01, $01, $01, $01 ; bytes 24-39
    db $00, $02, $00, $00, $02, $44, $00 ; bytes 40-46
SpeciesRecord_PutreFish:: ; heuristic: species record; C0
Data_035_746F:: ; address name
    db $09 ; id 268: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $02, $23 ; bytes 1-6
    db $04 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $34, $4C, $6F, $01, $05, $04, $08, $03, $0E, $07, $00, $00, $00, $00, $00, $01 ; bytes 8-23
    db $01, $02, $01, $01, $01, $00, $00, $00, $00, $00, $01, $01, $02, $01, $01, $00 ; bytes 24-39
    db $00, $00, $00, $00, $03, $3F, $00 ; bytes 40-46
SpeciesRecord_Octoreach:: ; heuristic: species record; C0
Data_035_749E:: ; address name
    db $09 ; id 269: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $28 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $76, $78, $91, $01, $17, $15, $18, $14, $08, $0E, $02, $02, $01, $01, $00, $00 ; bytes 8-23
    db $00, $02, $01, $00, $01, $01, $01, $02, $01, $00, $02, $00, $01, $01, $01, $01 ; bytes 24-39
    db $02, $02, $01, $00, $02, $59, $00 ; bytes 40-46
SpeciesRecord_Angleron:: ; heuristic: species record; C0
Data_035_74CD:: ; address name
    db $09 ; id 270: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $2D ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0D, $2E, $71, $01, $11, $10, $17, $14, $09, $13, $02, $02, $00, $02, $00, $00 ; bytes 8-23
    db $00, $02, $00, $02, $02, $00, $00, $02, $00, $00, $02, $00, $01, $00, $00, $00 ; bytes 24-39
    db $00, $02, $00, $00, $02, $4F, $00 ; bytes 40-46
SpeciesRecord_FishRider:: ; heuristic: species record; C0
Data_035_74FC:: ; address name
    db $09 ; id 271: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $32 ; bytes 1-6
    db $0D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $52, $65, $95, $01, $12, $13, $10, $16, $0D, $07, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $01, $02, $01, $01, $01, $00, $02, $02, $01, $00, $02, $00, $00, $00, $02, $00 ; bytes 24-39
    db $00, $02, $01, $01, $02, $55, $00 ; bytes 40-46
SpeciesRecord_RushFish:: ; heuristic: species record; C0
Data_035_752B:: ; address name
    db $09 ; id 272: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $28 ; bytes 1-6
    db $08 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $70, $7E, $03, $09, $06, $0C, $07, $12, $06, $02, $02, $01, $01, $00, $00 ; bytes 8-23
    db $00, $02, $00, $00, $00, $01, $02, $02, $00, $00, $02, $00, $00, $01, $01, $01 ; bytes 24-39
    db $00, $02, $01, $00, $02, $3D, $00 ; bytes 40-46
SpeciesRecord_Gamanian:: ; heuristic: species record; C0
Data_035_755A:: ; address name
    db $09 ; id 273: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $02, $28 ; bytes 1-6
    db $0E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $61, $8B, $00, $0B, $0A, $15, $11, $16, $0F, $01, $01, $00, $00, $00, $00 ; bytes 8-23
    db $01, $02, $03, $00, $00, $01, $01, $02, $00, $00, $02, $00, $00, $00, $02, $01 ; bytes 24-39
    db $01, $02, $01, $00, $02, $4D, $00 ; bytes 40-46
SpeciesRecord_Clawster:: ; heuristic: species record; C0
Data_035_7589:: ; address name
    db $09 ; id 274: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $2D ; bytes 1-6
    db $0B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $55, $5E, $63, $01, $0C, $14, $18, $12, $14, $0E, $02, $02, $02, $01, $00, $01 ; bytes 8-23
    db $00, $03, $02, $01, $01, $00, $00, $02, $01, $01, $02, $01, $00, $00, $00, $01 ; bytes 24-39
    db $01, $02, $00, $00, $02, $5B, $00 ; bytes 40-46
SpeciesRecord_CancerMan:: ; heuristic: species record; C0
Data_035_75B8:: ; address name
    db $09 ; id 275: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $2D ; bytes 1-6
    db $0F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $52, $56, $65, $05, $17, $0D, $18, $15, $0E, $09, $02, $02, $02, $00, $01, $01 ; bytes 8-23
    db $01, $02, $00, $01, $01, $01, $00, $02, $01, $00, $02, $00, $01, $01, $00, $00 ; bytes 24-39
    db $00, $02, $01, $01, $02, $5B, $00 ; bytes 40-46
SpeciesRecord_RogueWave:: ; heuristic: species record; C0
Data_035_75E7:: ; address name
    db $09 ; id 276: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $03, $02, $28 ; bytes 1-6
    db $09 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4C, $73, $9B, $01, $0B, $07, $12, $09, $18, $13, $02, $02, $01, $01, $00, $00 ; bytes 8-23
    db $01, $02, $02, $00, $00, $01, $01, $02, $01, $00, $02, $01, $00, $01, $01, $01 ; bytes 24-39
    db $02, $02, $00, $01, $02, $4F, $00 ; bytes 40-46
SpeciesRecord_Scallopa:: ; heuristic: species record; C0
Data_035_7616:: ; address name
    db $09 ; id 277: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $23 ; bytes 1-6
    db $0A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $39, $7F, $01, $11, $13, $09, $17, $07, $13, $02, $02, $02, $02, $01, $01 ; bytes 8-23
    db $01, $02, $01, $00, $00, $01, $00, $02, $00, $00, $02, $01, $02, $02, $00, $00 ; bytes 24-39
    db $02, $02, $00, $01, $02, $54, $00 ; bytes 40-46
SpeciesRecord_SeaHorse:: ; heuristic: species record; C0
Data_035_7645:: ; address name
    db $09 ; id 278: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $28 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $44, $91, $96, $01, $15, $09, $11, $0E, $0F, $08, $02, $02, $01, $00, $00, $00 ; bytes 8-23
    db $00, $03, $01, $00, $00, $01, $00, $02, $01, $00, $02, $00, $01, $01, $01, $01 ; bytes 24-39
    db $00, $03, $00, $00, $01, $47, $00 ; bytes 40-46
SpeciesRecord_HoodSquid:: ; heuristic: species record; C0
Data_035_7674:: ; address name
    db $09 ; id 279: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $2D ; bytes 1-6
    db $11 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $63, $7A, $01, $0B, $15, $10, $0A, $0E, $13, $02, $02, $01, $01, $00, $01 ; bytes 8-23
    db $01, $02, $00, $01, $01, $01, $01, $02, $01, $00, $02, $00, $00, $00, $01, $02 ; bytes 24-39
    db $02, $02, $01, $02, $02, $59, $00 ; bytes 40-46
SpeciesRecord_MerTiger:: ; heuristic: species record; C0
Data_035_76A3:: ; address name
    db $09 ; id 280: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $32 ; bytes 1-6
    db $10 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $10, $2F, $90, $05, $17, $05, $1A, $18, $0A, $0D, $02, $02, $02, $02, $00, $01 ; bytes 8-23
    db $01, $02, $02, $01, $01, $01, $00, $02, $02, $00, $02, $01, $01, $02, $02, $01 ; bytes 24-39
    db $00, $02, $01, $02, $01, $63, $00 ; bytes 40-46
SpeciesRecord_AxeShark:: ; heuristic: species record; C0
Data_035_76D2:: ; address name
    db $09 ; id 281: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $32 ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $27, $65, $97, $05, $19, $14, $1C, $15, $0E, $0D, $01, $01, $01, $01, $00, $00 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $02, $02, $02, $01, $02, $00, $02, $02, $02, $01 ; bytes 24-39
    db $02, $02, $01, $01, $03, $76, $00 ; bytes 40-46
SpeciesRecord_Octogon:: ; heuristic: species record; C0
Data_035_7701:: ; address name
    db $09 ; id 282: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $2D ; bytes 1-6
    db $13 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1B, $63, $7C, $01, $18, $09, $19, $12, $09, $14, $02, $02, $02, $01, $01, $00 ; bytes 8-23
    db $00, $02, $01, $00, $02, $01, $01, $02, $02, $00, $02, $00, $02, $01, $01, $01 ; bytes 24-39
    db $02, $02, $01, $01, $03, $64, $00 ; bytes 40-46
SpeciesRecord_KingSquid:: ; heuristic: species record; C0
Data_035_7730:: ; address name
    db $09 ; id 283: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $02, $37 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $1E, $65, $69, $01, $19, $0E, $1A, $17, $0C, $15, $02, $02, $02, $02, $01, $01 ; bytes 8-23
    db $01, $02, $00, $02, $02, $01, $01, $03, $01, $01, $02, $01, $02, $01, $01, $01 ; bytes 24-39
    db $01, $02, $01, $02, $03, $75, $00 ; bytes 40-46
SpeciesRecord_Digong:: ; heuristic: species record; C0
Data_035_775F:: ; address name
    db $09 ; id 284: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $37 ; bytes 1-6
    db $15 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $6F, $73, $03, $12, $17, $19, $0B, $0A, $0A, $02, $02, $02, $01, $01, $01 ; bytes 8-23
    db $02, $02, $02, $01, $01, $01, $02, $03, $01, $01, $03, $01, $01, $02, $02, $01 ; bytes 24-39
    db $01, $02, $01, $00, $03, $6A, $00 ; bytes 40-46
SpeciesRecord_WhaleMage:: ; heuristic: species record; C0
Data_035_778E:: ; address name
    db $09 ; id 285: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $2D ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $21, $4C, $91, $01, $1D, $15, $17, $12, $03, $0A, $02, $02, $01, $01, $02, $01 ; bytes 8-23
    db $02, $02, $03, $01, $01, $01, $00, $02, $02, $02, $02, $01, $01, $02, $02, $01 ; bytes 24-39
    db $00, $02, $00, $01, $03, $68, $00 ; bytes 40-46
SpeciesRecord_Aquadon:: ; heuristic: species record; C0
Data_035_77BD:: ; address name
    db $09 ; id 286: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $02, $32 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $32, $48, $6E, $05, $18, $14, $1A, $0A, $11, $09, $03, $03, $02, $02, $01, $02 ; bytes 8-23
    db $02, $02, $02, $01, $01, $02, $02, $03, $02, $01, $03, $01, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $02, $02, $03, $7D, $00 ; bytes 40-46
SpeciesRecord_Octoraid:: ; heuristic: species record; C0
Data_035_77EC:: ; address name
    db $09 ; id 287: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $02, $32 ; bytes 1-6
    db $1A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $55, $62, $67, $03, $12, $09, $1B, $15, $15, $0D, $02, $02, $02, $02, $01, $01 ; bytes 8-23
    db $02, $02, $02, $03, $02, $02, $01, $02, $02, $02, $02, $01, $01, $01, $01, $01 ; bytes 24-39
    db $01, $02, $01, $02, $02, $73, $00 ; bytes 40-46
SpeciesRecord_Grakos:: ; heuristic: species record; C0
Data_035_781B:: ; address name
    db $09 ; id 288: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $05, $02, $37 ; bytes 1-6
    db $15 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $2D, $6A, $7E, $01, $17, $12, $19, $12, $10, $0A, $00, $02, $00, $00, $00, $01 ; bytes 8-23
    db $02, $02, $03, $01, $01, $02, $02, $03, $01, $00, $00, $02, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $02, $01, $03, $77, $00 ; bytes 40-46
SpeciesRecord_Poseidon:: ; heuristic: species record; C0
Data_035_784A:: ; address name
    db $09 ; id 289: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $02, $41 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0D, $8A, $95, $03, $1C, $16, $17, $18, $0D, $09, $03, $03, $03, $03, $01, $01 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $03, $02, $02, $02, $02, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $02, $02, $03, $03, $8E, $00 ; bytes 40-46
SpeciesRecord_Pumpoise:: ; heuristic: species record; C0
Data_035_7879:: ; address name
    db $09 ; id 290: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $04, $02, $23 ; bytes 1-6
    db $0C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $4E, $89, $95, $01, $11, $08, $0D, $16, $07, $08, $02, $02, $01, $01, $00, $01 ; bytes 8-23
    db $00, $02, $01, $00, $00, $00, $01, $02, $01, $00, $02, $00, $00, $00, $00, $00 ; bytes 24-39
    db $00, $02, $01, $00, $02, $44, $00 ; bytes 40-46
SpeciesRecord_Starfish:: ; heuristic: species record; C0
Data_035_78A8:: ; address name
    db $09 ; id 291: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $00, $00, $06, $03, $1E ; bytes 1-6
    db $05 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $25, $5F, $76, $01, $07, $13, $05, $09, $09, $0F, $01, $01, $01, $01, $00, $00 ; bytes 8-23
    db $01, $02, $00, $02, $00, $00, $01, $00, $01, $00, $01, $01, $03, $01, $00, $01 ; bytes 24-39
    db $00, $00, $00, $00, $03, $8E, $00 ; bytes 40-46
SpeciesRecord_DracoLord:: ; heuristic: species record; C0
Data_035_78D7:: ; address name
    db $0A ; id 292: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $32 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $3B, $9F, $02, $14, $1E, $15, $14, $17, $17, $01, $01, $00, $00, $00, $01 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $03, $03, $03, $00, $01, $01, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $00, $00, $00, $10, $02 ; bytes 40-46
Data_035_7906:: ; heuristic: species record; C0
    db $0A ; id 293: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $46 ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $6C, $81, $02, $15, $1E, $18, $15, $17, $15, $02, $02, $01, $01, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $01, $01, $01, $58, $02 ; bytes 40-46
SpeciesRecord_LordDraco:: ; heuristic: species record; C0
Data_035_7935:: ; address name
    db $0A ; id 294: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $06, $01, $50 ; bytes 1-6
    db $1B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0D, $3F, $8A, $03, $16, $1F, $18, $16, $18, $16, $02, $02, $02, $02, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $02, $02, $84, $02 ; bytes 40-46
SpeciesRecord_Hargon:: ; heuristic: species record; C0
Data_035_7964:: ; address name
    db $0A ; id 295: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $3C ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $07, $85, $00, $13, $1E, $14, $15, $17, $17, $01, $01, $01, $01, $00, $01 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $03, $03, $03, $01, $00, $00, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $02, $00, $01, $1C, $02 ; bytes 40-46
SpeciesRecord_Sidoh:: ; heuristic: species record; C0
Data_035_7993:: ; address name
    db $0A ; id 296: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $06, $01, $46 ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3F, $40, $44, $01, $18, $1E, $18, $15, $17, $17, $01, $01, $01, $01, $01, $01 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $00, $00, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $01, $01, $44, $02 ; bytes 40-46
SpeciesRecord_Genosidoh:: ; heuristic: species record; C0
Data_035_79C2:: ; address name
    db $0A ; id 297: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $06, $01, $50 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $38, $48, $66, $01, $19, $1F, $19, $11, $12, $16, $02, $02, $02, $01, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $01, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $02, $02, $68, $02 ; bytes 40-46
SpeciesRecord_Baramos:: ; heuristic: species record; C0
Data_035_79F1:: ; address name
    db $0A ; id 298: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $3C ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $3F, $4B, $00, $14, $1E, $14, $14, $16, $15, $01, $01, $01, $02, $00, $02 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $02, $02, $03, $01, $01, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $00, $00, $01, $1C, $02 ; bytes 40-46
SpeciesRecord_Zoma:: ; heuristic: species record; C0
Data_035_7A20:: ; address name
    db $0A ; id 299: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $46 ; bytes 1-6
    db $19 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3E, $44, $83, $02, $18, $1E, $1A, $15, $17, $17, $01, $02, $03, $03, $01, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $01, $02, $84, $02 ; bytes 40-46
SpeciesRecord_AsuraZoma:: ; heuristic: species record; C0
Data_035_7A4F:: ; address name
    db $0A ; id 300: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $50 ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $67, $8A, $05, $1A, $1E, $1D, $16, $17, $0C, $02, $02, $03, $03, $01, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $02, $02, $90, $02 ; bytes 40-46
SpeciesRecord_Pizzaro:: ; heuristic: species record; C0
Data_035_7A7E:: ; address name
    db $0A ; id 301: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $46 ; bytes 1-6
    db $18 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3F, $40, $63, $03, $15, $1E, $1A, $15, $17, $17, $01, $01, $01, $01, $00, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $00, $00, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $01, $01, $48, $02 ; bytes 40-46
SpeciesRecord_PsychoPiz:: ; heuristic: species record; C0
Data_035_7AAD:: ; address name
    db $0A ; id 302: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $50 ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3E, $44, $83, $05, $1E, $1E, $1B, $12, $18, $15, $01, $01, $01, $01, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $01, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $01, $02, $74, $02 ; bytes 40-46
SpeciesRecord_Esterk:: ; heuristic: species record; C0
Data_035_7ADC:: ; address name
    db $0A ; id 303: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $50 ; bytes 1-6
    db $1F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $63, $65, $67, $05, $1D, $1E, $1A, $18, $17, $17, $01, $02, $02, $02, $00, $01 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $02, $02, $03, $01, $02, $01, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $01, $01, $01, $58, $02 ; bytes 40-46
SpeciesRecord_Mirudraas:: ; heuristic: species record; C0
Data_035_7B0B:: ; address name
    db $0A ; id 304: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $46 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $01, $07, $0D, $02, $15, $1E, $1A, $15, $17, $17, $02, $02, $02, $01, $02, $02 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $03, $03, $03, $01, $01, $02, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $01, $01, $01, $50, $02 ; bytes 40-46
Data_035_7B3A:: ; heuristic: species record; C0
    db $0A ; id 305: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $50 ; bytes 1-6
    db $1F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $83, $89, $02, $1D, $1E, $1A, $15, $17, $17, $02, $02, $02, $00, $00, $00 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $02, $02, $03, $01, $03, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $01, $01, $02, $60, $02 ; bytes 40-46
SpeciesRecord_Mudou:: ; heuristic: species record; C0
Data_035_7B69:: ; address name
    db $0A ; id 306: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $3C ; bytes 1-6
    db $1C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $44, $73, $02, $15, $1E, $1A, $18, $17, $17, $00, $00, $00, $03, $00, $01 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $02, $03, $03, $00, $03, $03, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $00, $00, $01, $38, $02 ; bytes 40-46
SpeciesRecord_DeathMore:: ; heuristic: species record; C0
Data_035_7B98:: ; address name
    db $0A ; id 307: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $06, $01, $3C ; bytes 1-6
    db $1B ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3E, $3F, $85, $02, $15, $1E, $1A, $15, $17, $17, $01, $02, $02, $01, $01, $02 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $03, $03, $03, $01, $01, $02, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $01, $00, $02, $48, $02 ; bytes 40-46
Data_035_7BC7:: ; heuristic: species record; C0
    db $0A ; id 308: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $46 ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $6F, $82, $03, $18, $1E, $1A, $15, $17, $17, $02, $02, $02, $02, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $02, $02, $03, $01, $01, $02, $03, $02, $03, $03 ; bytes 24-39
    db $03, $03, $02, $01, $03, $6C, $02 ; bytes 40-46
Data_035_7BF6:: ; heuristic: species record; C0
    db $0A ; id 309: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $06, $01, $50 ; bytes 1-6
    db $1F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3E, $83, $8A, $01, $1D, $1E, $1E, $18, $17, $17, $03, $03, $03, $03, $02, $03 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $03, $02, $03, $C0, $02 ; bytes 40-46
SpeciesRecord_Darkdrium:: ; heuristic: species record; C0
Data_035_7C25:: ; address name
    db $0A ; id 310: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $50 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $0D, $40, $44, $02, $1F, $1E, $1F, $18, $17, $17, $02, $02, $02, $02, $02, $03 ; bytes 8-23
    db $03, $03, $02, $02, $03, $03, $02, $03, $03, $02, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $03, $03, $02, $AC, $02 ; bytes 40-46
SpeciesRecord_Orgodemir:: ; heuristic: species record; C0
Data_035_7C54:: ; address name
    db $0A ; id 311: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $41 ; bytes 1-6
    db $1E ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $07, $6B, $8A, $02, $18, $19, $1A, $17, $16, $1F, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $02, $02, $03, $01, $02, $02, $02, $03, $02, $01 ; bytes 24-39
    db $02, $02, $02, $02, $02, $6C, $02 ; bytes 40-46
Data_035_7C83:: ; heuristic: species record; C0
    db $0A ; id 312: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $46 ; bytes 1-6
    db $1F ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3D, $83, $A0, $05, $1B, $1F, $1E, $17, $18, $1F, $03, $03, $03, $03, $02, $03 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $02, $03, $03, $02, $02, $03, $03, $03, $03, $02 ; bytes 24-39
    db $01, $01, $01, $01, $02, $20, $03 ; bytes 40-46
SpeciesRecord_Darck:: ; heuristic: species record; C0
Data_035_7CB2:: ; address name
    db $0A ; id 313: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $06, $00, $3C ; bytes 1-6
    db $1A ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $04, $07, $68, $02, $17, $19, $12, $17, $0E, $11, $00, $02, $00, $00, $00, $01 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $03, $02, $03, $02, $00, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $01, $00, $01, $24, $02 ; bytes 40-46
SpeciesRecord_Tatsu:: ; heuristic: species record; C0
Data_035_7CE1:: ; address name
    db $00 ; id 314: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $01, $01, $02, $02, $03, $01 ; bytes 8-23
    db $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $00, $00 ; bytes 40-46
SpeciesRecord_Diago:: ; heuristic: species record; C0
Data_035_7D10:: ; address name
    db $00 ; id 315: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $03, $02, $02, $00, $00, $01 ; bytes 8-23
    db $01, $01, $02, $01, $00, $01, $01, $01, $00, $00, $03, $00, $01, $01, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $00, $00, $00 ; bytes 40-46
SpeciesRecord_Samsi:: ; heuristic: species record; C0
Data_035_7D3F:: ; address name
    db $00 ; id 316: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $03, $00, $01 ; bytes 8-23
    db $02, $02, $03, $01, $01, $01, $00, $01, $00, $00, $01, $02, $01, $01, $01, $01 ; bytes 24-39
    db $01, $01, $01, $01, $01, $00, $00 ; bytes 40-46
SpeciesRecord_Bazoo:: ; heuristic: species record; C0
Data_035_7D6E:: ; address name
    db $00 ; id 317: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $01, $02, $02, $01, $02, $03 ; bytes 8-23
    db $03, $03, $03, $02, $02, $02, $02, $02, $01, $00, $01, $03, $02, $02, $02, $02 ; bytes 24-39
    db $02, $02, $02, $02, $01, $00, $00 ; bytes 40-46
SpeciesRecord_179:: ; heuristic: species record; C0
Data_035_7D9D:: ; address name
    db $00 ; id 318: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $02, $02, $03, $01, $01, $02, $02, $01, $01, $00, $03, $03, $02, $03, $02, $02 ; bytes 24-39
    db $01, $01, $02, $02, $01, $00, $00 ; bytes 40-46
SpeciesRecord_17A:: ; heuristic: species record; C0
Data_035_7DCC:: ; address name
    db $00 ; id 319: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $00, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00 ; bytes 8-23
    db $02, $02, $02, $02, $02, $02, $03, $03, $02, $02, $02, $02, $00, $00, $00, $01 ; bytes 24-39
    db $01, $01, $01, $01, $02, $00, $00 ; bytes 40-46
SpeciesRecord_17B:: ; heuristic: species record; C0
Data_035_7DFB:: ; address name
    db $0A ; id 320: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $00, $00, $07, $01, $00 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $01, $02 ; bytes 8-23
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $01, $02, $02, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $02, $02, $00, $00 ; bytes 40-46
SpeciesRecord_Lamia:: ; heuristic: species record; C0
Data_035_7E2A:: ; address name
    db $0A ; id 321: family (StringTable_MonsterFamilies index; $FF unused)
    db $02, $01, $00, $07, $01, $63 ; bytes 1-6
    db $1C ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $19, $1B, $1E, $00, $14, $18, $13, $15, $12, $18, $01, $01, $01, $02, $02, $02 ; bytes 8-23
    db $03, $03, $03, $02, $03, $03, $01, $01, $02, $01, $01, $01, $02, $03, $03, $02 ; bytes 24-39
    db $01, $02, $02, $01, $02, $00, $00 ; bytes 40-46
SpeciesRecord_Dimensaur:: ; heuristic: species record; C0
Data_035_7E59:: ; address name
    db $0A ; id 322: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $07, $01, $09 ; bytes 1-6
    db $1D ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $40, $3D, $3F, $00, $1F, $1F, $1F, $1F, $1F, $1F, $02, $02, $02, $02, $02, $02 ; bytes 8-23
    db $02, $02, $03, $02, $02, $02, $02, $03, $02, $01, $02, $01, $03, $03, $03, $03 ; bytes 24-39
    db $03, $01, $02, $01, $01, $00, $00 ; bytes 40-46
SpeciesRecord_Kagebou:: ; heuristic: species record; C0
Data_035_7E88:: ; address name
    db $0A ; id 323: family (StringTable_MonsterFamilies index; $FF unused)
    db $00, $01, $00, $07, $01, $63 ; bytes 1-6
    db $00 ; EXP curve: ExpTable row (wSpeciesExpCurve)
    db $3C, $3E, $85, $00, $17, $0F, $18, $10, $18, $09, $00, $00, $00, $00, $00, $00 ; bytes 8-23
    db $00, $03, $03, $01, $01, $03, $03, $01, $02, $01, $00, $00, $03, $03, $03, $03 ; bytes 24-39
    db $03, $03, $02, $00, $00, $00, $00 ; bytes 40-46
    ds $149, $00
