SECTION "Bank 38", ROMX[$4000], BANK[$38]
    db $38

; E-0041 (C1: Func_000_1FE3 indexes it with the monster id and decompresses the stream to VRAM; the debug monster viewer shows the picture; every one of the 383 entries parses as a 576-byte stream; entry 0 is a placeholder). Each entry is a 3-byte far pointer: address, then bank.
; record: compressed picture stream (36 tiles, drawn 6 x 6); ROM bank of that data
MonsterPictureTable::
Data_038_4001:: ; heuristic: start of a structured table; C0
    dw MonsterPic_DrakSlime ; id 0
    db $74
    dw MonsterPic_DrakSlime ; id 1 DrakSlime
    db $74
    dw MonsterPic_SpotSlime ; id 2 SpotSlime
    db $74
    dw MonsterPic_WingSlime ; id 3 WingSlime
    db $74
    dw MonsterPic_TreeSlime ; id 4 TreeSlime
    db $74
    dw MonsterPic_Snaily ; id 5 Snaily
    db $74
    dw MonsterPic_SlimeNite ; id 6 SlimeNite
    db $74
    dw MonsterPic_Babble ; id 7 Babble
    db $74
    dw MonsterPic_BoxSlime ; id 8 BoxSlime
    db $74
    dw MonsterPic_PearlGel ; id 9 PearlGel
    db $74
    dw MonsterPic_Slime ; id 10 Slime
    db $74
    dw MonsterPic_Healer ; id 11 Healer
    db $74
    dw MonsterPic_FangSlime ; id 12 FangSlime
    db $74
    dw MonsterPic_RockSlime ; id 13 RockSlime
    db $74
    dw MonsterPic_SlimeBorg ; id 14 SlimeBorg
    db $74
    dw MonsterPic_Slabbit ; id 15 Slabbit
    db $74
    dw MonsterPic_KingSlime ; id 16 KingSlime
    db $74
    dw MonsterPic_Metaly ; id 17 Metaly
    db $74
    dw MonsterPic_Metabble ; id 18 Metabble
    db $74
    dw MonsterPic_SpotKing ; id 19 SpotKing
    db $74
    dw MonsterPic_TropicGel ; id 20 TropicGel
    db $74
    dw MonsterPic_MimeSlime ; id 21 MimeSlime
    db $74
    dw MonsterPic_HaloSlime ; id 22 HaloSlime
    db $74
    dw MonsterPic_MetalKing ; id 23 MetalKing
    db $74
    dw MonsterPic_GoldSlime ; id 24 GoldSlime
    db $74
    dw MonsterPic_GranSlime ; id 25 GranSlime
    db $74
    dw MonsterPic_WonderEgg ; id 26 WonderEgg
    db $74
    dw MonsterPic_SpotSlime ; id 27 Butch
    db $74
    dw MonsterPic_DrakSlime ; id 28 ?
    db $74
    dw MonsterPic_DrakSlime ; id 29 ?
    db $74
    dw MonsterPic_DrakSlime ; id 30 ?
    db $74
    dw MonsterPic_DrakSlime ; id 31 ?
    db $74
    dw MonsterPic_DrakSlime ; id 32 ?
    db $74
    dw MonsterPic_DrakSlime ; id 33 ?
    db $74
    dw MonsterPic_DrakSlime ; id 34 ?
    db $74
    dw MonsterPic_DrakSlime ; id 35 ?
    db $74
    dw MonsterPic_DragonKid ; id 36 DragonKid
    db $74
    dw MonsterPic_Tortragon ; id 37 Tortragon
    db $74
    dw MonsterPic_Pteranod ; id 38 Pteranod
    db $74
    dw MonsterPic_Gasgon ; id 39 Gasgon
    db $74
    dw MonsterPic_FairyDrak ; id 40 FairyDrak
    db $74
    dw MonsterPic_LizardMan ; id 41 LizardMan
    db $74
    dw MonsterPic_Poisongon ; id 42 Poisongon
    db $74
    dw MonsterPic_Swordgon ; id 43 Swordgon
    db $74
    dw MonsterPic_Drygon ; id 44 Drygon
    db $74
    dw MonsterPic_Dragon ; id 45 Dragon
    db $74
    dw MonsterPic_MiniDrak ; id 46 MiniDrak
    db $74
    dw MonsterPic_MadDragon ; id 47 MadDragon
    db $74
    dw MonsterPic_Rayburn ; id 48 Rayburn
    db $74
    dw MonsterPic_Chamelgon ; id 49 Chamelgon
    db $74
    dw MonsterPic_LizardFly ; id 50 LizardFly
    db $74
    dw MonsterPic_Andreal ; id 51 Andreal
    db $74
    dw MonsterPic_KingCobra ; id 52 KingCobra
    db $74
    dw MonsterPic_Vampirus ; id 53 Vampirus
    db $74
    dw MonsterPic_SnakeBat ; id 54 SnakeBat
    db $74
    dw MonsterPic_Spikerous ; id 55 Spikerous
    db $74
    dw MonsterPic_GreatDrak ; id 56 GreatDrak
    db $74
    dw MonsterPic_Crestpent ; id 57 Crestpent
    db $74
    dw MonsterPic_WingSnake ; id 58 WingSnake
    db $74
    dw MonsterPic_Coatol ; id 59 Coatol
    db $74
    dw MonsterPic_Orochi ; id 60 Orochi
    db $74
    dw MonsterPic_BattleRex ; id 61 BattleRex
    db $74
    dw MonsterPic_SkyDragon ; id 62 SkyDragon
    db $75
    dw MonsterPic_Serpentia ; id 63 Serpentia
    db $75
    dw MonsterPic_Divinegon ; id 64 Divinegon
    db $75
    dw MonsterPic_Orligon ; id 65 Orligon
    db $75
    dw MonsterPic_GigaDraco ; id 66 GigaDraco
    db $75
    dw MonsterPic_DrakSlime ; id 67 ?
    db $74
    dw MonsterPic_DrakSlime ; id 68 ?
    db $74
    dw MonsterPic_DrakSlime ; id 69 ?
    db $74
    dw MonsterPic_DrakSlime ; id 70 ?
    db $74
    dw MonsterPic_Tonguella ; id 71 Tonguella
    db $75
    dw MonsterPic_Almiraj ; id 72 Almiraj
    db $75
    dw MonsterPic_CatFly ; id 73 CatFly
    db $75
    dw MonsterPic_PillowRat ; id 74 PillowRat
    db $75
    dw MonsterPic_Saccer ; id 75 Saccer
    db $75
    dw MonsterPic_GulpBeast ; id 76 GulpBeast
    db $75
    dw MonsterPic_Skullroo ; id 77 Skullroo
    db $75
    dw MonsterPic_WindBeast ; id 78 WindBeast
    db $75
    dw MonsterPic_Beavern ; id 79 Beavern
    db $75
Data_038_40F1:: ; heuristic: label inside a table; C0
    dw MonsterPic_Antbear ; id 80 Antbear
    db $75
    dw MonsterPic_SuperTen ; id 81 SuperTen
    db $75
    dw MonsterPic_IronTurt ; id 82 IronTurt
    db $75
    dw MonsterPic_Mommonja ; id 83 Mommonja
    db $75
    dw MonsterPic_HammerMan ; id 84 HammerMan
    db $75
    dw MonsterPic_Grizzly ; id 85 Grizzly
    db $75
    dw MonsterPic_Yeti ; id 86 Yeti
    db $75
    dw MonsterPic_ArrowDog ; id 87 ArrowDog
    db $75
    dw MonsterPic_NoctoKing ; id 88 NoctoKing
    db $75
    dw MonsterPic_BeastNite ; id 89 BeastNite
    db $75
    dw MonsterPic_MadGopher ; id 90 MadGopher
    db $75
    dw MonsterPic_FairyRat ; id 91 FairyRat
    db $75
    dw MonsterPic_Unicorn ; id 92 Unicorn
    db $75
    dw MonsterPic_Goategon ; id 93 Goategon
    db $75
    dw MonsterPic_WildApe ; id 94 WildApe
    db $75
    dw MonsterPic_Trumpeter ; id 95 Trumpeter
    db $75
    dw MonsterPic_KingLeo ; id 96 KingLeo
    db $75
    dw MonsterPic_DarkHorn ; id 97 DarkHorn
    db $75
    dw MonsterPic_MadCat ; id 98 MadCat
    db $75
    dw MonsterPic_BigEye ; id 99 BigEye
    db $75
    dw MonsterPic_Gorago ; id 100 Gorago
    db $75
    dw MonsterPic_CatMage ; id 101 CatMage
    db $75
    dw MonsterPic_Dumbira ; id 102 Dumbira
    db $75
    dw MonsterPic_DrakSlime ; id 103 ?
    db $74
    dw MonsterPic_DrakSlime ; id 104 ?
    db $74
    dw MonsterPic_DrakSlime ; id 105 ?
    db $74
    dw MonsterPic_Picky ; id 106 Picky
    db $77
    dw MonsterPic_Wyvern ; id 107 Wyvern
    db $75
    dw MonsterPic_BullBird ; id 108 BullBird
    db $75
    dw MonsterPic_Florajay ; id 109 Florajay
    db $75
    dw MonsterPic_DuckKite ; id 110 DuckKite
    db $75
    dw MonsterPic_MadPecker ; id 111 MadPecker
    db $76
    dw MonsterPic_MadRaven ; id 112 MadRaven
    db $76
    dw MonsterPic_MistyWing ; id 113 MistyWing
    db $76
    dw MonsterPic_AquaHawk ; id 114 AquaHawk
    db $76
    dw MonsterPic_Dracky ; id 115 Dracky
    db $76
    dw MonsterPic_KiteHawk ; id 116 KiteHawk
    db $76
    dw MonsterPic_BigRoost ; id 117 BigRoost
    db $76
    dw MonsterPic_StubBird ; id 118 StubBird
    db $76
    dw MonsterPic_LandOwl ; id 119 LandOwl
    db $76
    dw MonsterPic_MadGoose ; id 120 MadGoose
    db $76
    dw MonsterPic_MadCondor ; id 121 MadCondor
    db $76
    dw MonsterPic_Emyu ; id 122 Emyu
    db $76
    dw MonsterPic_Blizzardy ; id 123 Blizzardy
    db $76
    dw MonsterPic_Phoenix ; id 124 Phoenix
    db $76
    dw MonsterPic_ZapBird ; id 125 ZapBird
    db $76
    dw MonsterPic_Garudian ; id 126 Garudian
    db $76
    dw MonsterPic_WhipBird ; id 127 WhipBird
    db $76
    dw MonsterPic_FunkyBird ; id 128 FunkyBird
    db $76
    dw MonsterPic_RainHawk ; id 129 RainHawk
    db $76
    dw MonsterPic_Azurile ; id 130 Azurile
    db $76
    dw MonsterPic_Shantak ; id 131 Shantak
    db $76
    dw MonsterPic_CragDevil ; id 132 CragDevil
    db $76
    dw MonsterPic_DrakSlime ; id 133 ?
    db $74
    dw MonsterPic_DrakSlime ; id 134 ?
    db $74
    dw MonsterPic_DrakSlime ; id 135 ?
    db $74
    dw MonsterPic_DrakSlime ; id 136 ?
    db $74
    dw MonsterPic_DrakSlime ; id 137 ?
    db $74
    dw MonsterPic_DrakSlime ; id 138 ?
    db $74
    dw MonsterPic_DrakSlime ; id 139 ?
    db $74
    dw MonsterPic_DrakSlime ; id 140 ?
    db $74
    dw MonsterPic_MadPlant ; id 141 MadPlant
    db $7A
    dw MonsterPic_FireWeed ; id 142 FireWeed
    db $76
    dw MonsterPic_FloraMan ; id 143 FloraMan
    db $76
    dw MonsterPic_WingTree ; id 144 WingTree
    db $76
    dw MonsterPic_CactiBall ; id 145 CactiBall
    db $76
    dw MonsterPic_Gulpple ; id 146 Gulpple
    db $76
    dw MonsterPic_Toadstool ; id 147 Toadstool
    db $76
    dw MonsterPic_AmberWeed ; id 148 AmberWeed
    db $76
    dw MonsterPic_Slurperon ; id 149 Slurperon
    db $76
    dw MonsterPic_Stubsuck ; id 150 Stubsuck
    db $76
    dw MonsterPic_Oniono ; id 151 Oniono
    db $76
    dw MonsterPic_DanceVegi ; id 152 DanceVegi
    db $76
    dw MonsterPic_TreeBoy ; id 153 TreeBoy
    db $76
    dw MonsterPic_Devipine ; id 154 Devipine
    db $76
    dw MonsterPic_FaceTree ; id 155 FaceTree
    db $76
    dw MonsterPic_HerbMan ; id 156 HerbMan
    db $76
    dw MonsterPic_BeanMan ; id 157 BeanMan
    db $76
    dw MonsterPic_EvilSeed ; id 158 EvilSeed
    db $76
    dw MonsterPic_ManEater ; id 159 ManEater
    db $76
    dw MonsterPic_Snapper ; id 160 Snapper
    db $76
    dw MonsterPic_GhosTree ; id 161 GhosTree
    db $76
    dw MonsterPic_Rosevine ; id 162 Rosevine
    db $76
    dw MonsterPic_Egdracil ; id 163 Egdracil
    db $77
    dw MonsterPic_Warubou ; id 164 Warubou
    db $77
    dw MonsterPic_Watabou ; id 165 Watabou
    db $77
    dw MonsterPic_Eggplaton ; id 166 Eggplaton
    db $77
    dw MonsterPic_FooHero ; id 167 FooHero
    db $77
    dw MonsterPic_DrakSlime ; id 168 ?
    db $74
    dw MonsterPic_DrakSlime ; id 169 ?
    db $74
    dw MonsterPic_DrakSlime ; id 170 ?
    db $74
    dw MonsterPic_DrakSlime ; id 171 ?
    db $74
    dw MonsterPic_DrakSlime ; id 172 ?
    db $74
    dw MonsterPic_DrakSlime ; id 173 ?
    db $74
    dw MonsterPic_DrakSlime ; id 174 ?
    db $74
    dw MonsterPic_DrakSlime ; id 175 ?
    db $74
    dw MonsterPic_GiantSlug ; id 176 GiantSlug
    db $77
    dw MonsterPic_Catapila ; id 177 Catapila
    db $77
    dw MonsterPic_Gophecada ; id 178 Gophecada
    db $77
    dw MonsterPic_Butterfly ; id 179 Butterfly
    db $77
    dw MonsterPic_WeedBug ; id 180 WeedBug
    db $77
    dw MonsterPic_GiantWorm ; id 181 GiantWorm
    db $77
    dw MonsterPic_Lipsy ; id 182 Lipsy
    db $77
    dw MonsterPic_StagBug ; id 183 StagBug
    db $77
    dw MonsterPic_Pyuro ; id 184 Pyuro
    db $77
    dw MonsterPic_ArmyAnt ; id 185 ArmyAnt
    db $77
    dw MonsterPic_GoHopper ; id 186 GoHopper
    db $77
    dw MonsterPic_TailEater ; id 187 TailEater
    db $77
    dw MonsterPic_ArmorPede ; id 188 ArmorPede
    db $77
    dw MonsterPic_Eyeder ; id 189 Eyeder
    db $77
    dw MonsterPic_GiantMoth ; id 190 GiantMoth
    db $77
    dw MonsterPic_Droll ; id 191 Droll
    db $77
    dw MonsterPic_ArmyCrab ; id 192 ArmyCrab
    db $77
    dw MonsterPic_MadHornet ; id 193 MadHornet
    db $77
    dw MonsterPic_Belzebub ; id 194 Belzebub
    db $77
    dw MonsterPic_WarMantis ; id 195 WarMantis
    db $77
    dw MonsterPic_HornBeet ; id 196 HornBeet
    db $77
    dw MonsterPic_Sickler ; id 197 Sickler
    db $77
    dw MonsterPic_Armorpion ; id 198 Armorpion
    db $77
    dw MonsterPic_Digster ; id 199 Digster
    db $77
    dw MonsterPic_Skularach ; id 200 Skularach
    db $77
    dw MonsterPic_MultiEyes ; id 201 MultiEyes
    db $77
    dw MonsterPic_DrakSlime ; id 202 ?
    db $74
    dw MonsterPic_DrakSlime ; id 203 ?
    db $74
    dw MonsterPic_DrakSlime ; id 204 ?
    db $74
    dw MonsterPic_DrakSlime ; id 205 ?
    db $74
    dw MonsterPic_DrakSlime ; id 206 ?
    db $74
    dw MonsterPic_DrakSlime ; id 207 ?
    db $74
    dw MonsterPic_DrakSlime ; id 208 ?
    db $74
    dw MonsterPic_DrakSlime ; id 209 ?
    db $74
    dw MonsterPic_DrakSlime ; id 210 ?
    db $74
    dw MonsterPic_Pixy ; id 211 Pixy
    db $78
    dw MonsterPic_MedusaEye ; id 212 MedusaEye
    db $78
    dw MonsterPic_AgDevil ; id 213 AgDevil
    db $78
    dw MonsterPic_Demonite ; id 214 Demonite
    db $78
    dw MonsterPic_DarkEye ; id 215 DarkEye
    db $78
    dw MonsterPic_EyeBall ; id 216 EyeBall
    db $78
    dw MonsterPic_SkulRider ; id 217 SkulRider
    db $78
    dw MonsterPic_EvilBeast ; id 218 EvilBeast
    db $78
    dw MonsterPic_Bubblemon ; id 219 Bubblemon
    db $78
    dw MonsterPic_1EyeClown ; id 220 1EyeClown
    db $78
    dw MonsterPic_Gremlin ; id 221 Gremlin
    db $78
    dw MonsterPic_ArcDemon ; id 222 ArcDemon
    db $78
    dw MonsterPic_Lionex ; id 223 Lionex
    db $78
    dw MonsterPic_GoatHorn ; id 224 GoatHorn
    db $78
Data_038_42A4:: ; heuristic: label inside a table; C0
    dw MonsterPic_Orc ; id 225 Orc
    db $78
    dw MonsterPic_Ogre ; id 226 Ogre
    db $78
    dw MonsterPic_GateGuard ; id 227 GateGuard
    db $78
    dw MonsterPic_ChopClown ; id 228 ChopClown
    db $78
    dw MonsterPic_BossTroll ; id 229 BossTroll
    db $78
    dw MonsterPic_Grendal ; id 230 Grendal
    db $78
    dw MonsterPic_Akubar ; id 231 Akubar
    db $78
    dw MonsterPic_MadKnight ; id 232 MadKnight
    db $78
    dw MonsterPic_EvilWell ; id 233 EvilWell
    db $78
    dw MonsterPic_Gigantes ; id 234 Gigantes
    db $78
    dw MonsterPic_Centasaur ; id 235 Centasaur
    db $78
    dw MonsterPic_EvilArmor ; id 236 EvilArmor
    db $78
    dw MonsterPic_Jamirus ; id 237 Jamirus
    db $78
    dw MonsterPic_Durran ; id 238 Durran
    db $78
    dw MonsterPic_Titanis ; id 239 Titanis
    db $78
    dw MonsterPic_LampGenie ; id 240 LampGenie
    db $78
    dw MonsterPic_DrakSlime ; id 241 ?
    db $74
    dw MonsterPic_DrakSlime ; id 242 ?
    db $74
    dw MonsterPic_DrakSlime ; id 243 ?
    db $74
    dw MonsterPic_DrakSlime ; id 244 ?
    db $74
    dw MonsterPic_DrakSlime ; id 245 ?
    db $74
    dw MonsterPic_Spooky ; id 246 Spooky
    db $78
    dw MonsterPic_Skullgon ; id 247 Skullgon
    db $78
    dw MonsterPic_PutrePup ; id 248 PutrePup
    db $78
    dw MonsterPic_RotRaven ; id 249 RotRaven
    db $78
    dw MonsterPic_Mummy ; id 250 Mummy
    db $78
    dw MonsterPic_DarkCrab ; id 251 DarkCrab
    db $78
    dw MonsterPic_DeadNite ; id 252 DeadNite
    db $78
    dw MonsterPic_Shadow ; id 253 Shadow
    db $78
    dw MonsterPic_Skulpent ; id 254 Skulpent
    db $78
    dw MonsterPic_Hork ; id 255 Hork
    db $78
    dw MonsterPic_Mudron ; id 256 Mudron
    db $78
    dw MonsterPic_NiteWhip ; id 257 NiteWhip
    db $78
    dw MonsterPic_WindMerge ; id 258 WindMerge
    db $78
    dw MonsterPic_Reaper ; id 259 Reaper
    db $79
    dw MonsterPic_Inverzon ; id 260 Inverzon
    db $79
    dw MonsterPic_FoxFire ; id 261 FoxFire
    db $79
    dw MonsterPic_CaptDead ; id 262 CaptDead
    db $79
    dw MonsterPic_DeadNoble ; id 263 DeadNoble
    db $79
    dw MonsterPic_WhiteKing ; id 264 WhiteKing
    db $79
    dw MonsterPic_BoneSlave ; id 265 BoneSlave
    db $79
    dw MonsterPic_Skeletor ; id 266 Skeletor
    db $79
    dw MonsterPic_Servant ; id 267 Servant
    db $79
    dw MonsterPic_Lazamanus ; id 268 Lazamanus
    db $79
    dw MonsterPic_Copycat ; id 269 Copycat
    db $79
    dw MonsterPic_MadSpirit ; id 270 MadSpirit
    db $79
    dw MonsterPic_PomPomBom ; id 271 PomPomBom
    db $79
    dw MonsterPic_Niterich ; id 272 Niterich
    db $79
    dw MonsterPic_DrakSlime ; id 273 ?
    db $74
    dw MonsterPic_DrakSlime ; id 274 ?
    db $74
    dw MonsterPic_DrakSlime ; id 275 ?
    db $74
    dw MonsterPic_DrakSlime ; id 276 ?
    db $74
    dw MonsterPic_DrakSlime ; id 277 ?
    db $74
    dw MonsterPic_DrakSlime ; id 278 ?
    db $74
    dw MonsterPic_DrakSlime ; id 279 ?
    db $74
    dw MonsterPic_DrakSlime ; id 280 ?
    db $74
    dw MonsterPic_JewelBag ; id 281 JewelBag
    db $79
    dw MonsterPic_EvilWand ; id 282 EvilWand
    db $79
    dw MonsterPic_MadCandle ; id 283 MadCandle
    db $79
    dw MonsterPic_CoilBird ; id 284 CoilBird
    db $79
    dw MonsterPic_Facer ; id 285 Facer
    db $79
    dw MonsterPic_SpikyBoy ; id 286 SpikyBoy
    db $79
    dw MonsterPic_MadMirror ; id 287 MadMirror
    db $79
    dw MonsterPic_RogueNite ; id 288 RogueNite
    db $79
    dw MonsterPic_Puppetor ; id 289 Puppetor
    db $79
    dw MonsterPic_Goopi ; id 290 Goopi
    db $79
    dw MonsterPic_Voodoll ; id 291 Voodoll
    db $79
    dw MonsterPic_MetalDrak ; id 292 MetalDrak
    db $79
    dw MonsterPic_Balzak ; id 293 Balzak
    db $79
    dw MonsterPic_SabreMan ; id 294 SabreMan
    db $79
    dw MonsterPic_CurseLamp ; id 295 CurseLamp
    db $79
    dw MonsterPic_Brushead ; id 296 Brushead
    db $79
    dw MonsterPic_Roboster ; id 297 Roboster
    db $79
    dw MonsterPic_Roboster2 ; id 298 Roboster2
    db $79
    dw MonsterPic_EvilPot ; id 299 EvilPot
    db $79
    dw MonsterPic_Gismo ; id 300 Gismo
    db $79
    dw MonsterPic_LavaMan ; id 301 LavaMan
    db $79
    dw MonsterPic_IceMan ; id 302 IceMan
    db $79
    dw MonsterPic_Mimic ; id 303 Mimic
    db $79
    dw MonsterPic_Exaucers ; id 304 Exaucers
    db $79
    dw MonsterPic_MudDoll ; id 305 MudDoll
    db $79
    dw MonsterPic_Golem ; id 306 Golem
    db $79
    dw MonsterPic_StoneMan ; id 307 StoneMan
    db $79
    dw MonsterPic_BombCrag ; id 308 BombCrag
    db $79
    dw MonsterPic_GoldGolem ; id 309 GoldGolem
    db $79
    dw MonsterPic_DarkMate ; id 310 DarkMate
    db $79
    dw MonsterPic_ProtoMech ; id 311 ProtoMech
    db $79
    dw MonsterPic_CloudKing ; id 312 CloudKing
    db $79
    dw MonsterPic_DrakSlime ; id 313 ?
    db $74
    dw MonsterPic_DrakSlime ; id 314 ?
    db $74
    dw MonsterPic_DrakSlime ; id 315 ?
    db $74
    dw MonsterPic_Petiteel ; id 316 Petiteel
    db $77
    dw MonsterPic_Moray ; id 317 Moray
    db $77
    dw MonsterPic_WalrusMan ; id 318 WalrusMan
    db $77
    dw MonsterPic_RayGigas ; id 319 RayGigas
    db $77
    dw MonsterPic_Anemon ; id 320 Anemon
    db $77
    dw MonsterPic_Aquarella ; id 321 Aquarella
    db $77
    dw MonsterPic_Merman ; id 322 Merman
    db $77
    dw MonsterPic_Octokid ; id 323 Octokid
    db $77
    dw MonsterPic_PutreFish ; id 324 PutreFish
    db $77
    dw MonsterPic_Octoreach ; id 325 Octoreach
    db $77
    dw MonsterPic_Angleron ; id 326 Angleron
    db $77
    dw MonsterPic_FishRider ; id 327 FishRider
    db $77
    dw MonsterPic_RushFish ; id 328 RushFish
    db $77
    dw MonsterPic_Gamanian ; id 329 Gamanian
    db $77
    dw MonsterPic_Clawster ; id 330 Clawster
    db $77
    dw MonsterPic_CancerMan ; id 331 CancerMan
    db $77
    dw MonsterPic_RogueWave ; id 332 RogueWave
    db $77
    dw MonsterPic_Scallopa ; id 333 Scallopa
    db $77
    dw MonsterPic_SeaHorse ; id 334 SeaHorse
    db $77
    dw MonsterPic_HoodSquid ; id 335 HoodSquid
    db $77
    dw MonsterPic_MerTiger ; id 336 MerTiger
    db $7A
    dw MonsterPic_AxeShark ; id 337 AxeShark
    db $7A
    dw MonsterPic_Octogon ; id 338 Octogon
    db $7A
    dw MonsterPic_KingSquid ; id 339 KingSquid
    db $7A
    dw MonsterPic_Digong ; id 340 Digong
    db $7A
    dw MonsterPic_WhaleMage ; id 341 WhaleMage
    db $7A
    dw MonsterPic_Aquadon ; id 342 Aquadon
    db $7A
    dw MonsterPic_Octoraid ; id 343 Octoraid
    db $7A
    dw MonsterPic_Grakos ; id 344 Grakos
    db $7A
    dw MonsterPic_Poseidon ; id 345 Poseidon
    db $7A
    dw MonsterPic_Pumpoise ; id 346 Pumpoise
    db $7A
    dw MonsterPic_Starfish ; id 347 Starfish
    db $7A
    dw MonsterPic_DrakSlime ; id 348 ?
    db $74
    dw MonsterPic_DrakSlime ; id 349 ?
    db $74
    dw MonsterPic_DrakSlime ; id 350 ?
    db $74
    dw MonsterPic_DracoLord ; id 351 DracoLord
    db $7A
    dw MonsterPic_DracoLord_160 ; id 352 DracoLord
    db $7A
    dw MonsterPic_LordDraco ; id 353 LordDraco
    db $7A
    dw MonsterPic_Hargon ; id 354 Hargon
    db $7A
    dw MonsterPic_Sidoh ; id 355 Sidoh
    db $7A
    dw MonsterPic_Genosidoh ; id 356 Genosidoh
    db $7A
    dw MonsterPic_Baramos ; id 357 Baramos
    db $7A
    dw MonsterPic_Zoma ; id 358 Zoma
    db $7A
    dw MonsterPic_AsuraZoma ; id 359 AsuraZoma
    db $7A
    dw MonsterPic_Pizzaro ; id 360 Pizzaro
    db $7A
    dw MonsterPic_PsychoPiz ; id 361 PsychoPiz
    db $7A
    dw MonsterPic_Esterk ; id 362 Esterk
    db $7A
    dw MonsterPic_Mirudraas ; id 363 Mirudraas
    db $7A
    dw MonsterPic_Mirudraas_16C ; id 364 Mirudraas
    db $7A
    dw MonsterPic_Mudou ; id 365 Mudou
    db $7A
    dw MonsterPic_DeathMore ; id 366 DeathMore
    db $7A
    dw MonsterPic_DeathMore_16F ; id 367 DeathMore
    db $7A
    dw MonsterPic_DeathMore_170 ; id 368 DeathMore
    db $7A
    dw MonsterPic_Darkdrium ; id 369 Darkdrium
    db $7A
    dw MonsterPic_Orgodemir ; id 370 Orgodemir
    db $7A
    dw MonsterPic_Orgodemir_173 ; id 371 Orgodemir
    db $7A
    dw MonsterPic_Darck ; id 372 Darck
    db $7A
    dw MonsterPic_DrakSlime ; id 373 Tatsu
    db $74
    dw MonsterPic_DrakSlime ; id 374 Diago
    db $74
    dw MonsterPic_DrakSlime ; id 375 Samsi
    db $74
    dw MonsterPic_DrakSlime ; id 376 Bazoo
    db $74
    dw MonsterPic_DrakSlime ; id 377 ?
    db $74
    dw MonsterPic_DrakSlime ; id 378 ?
    db $74
    dw MonsterPic_DrakSlime ; id 379 ?
    db $74
    dw MonsterPic_Lamia ; id 380 Lamia
    db $76
    dw MonsterPic_Dimensaur ; id 381 Dimensaur
    db $7B
    dw MonsterPic_Kagebou ; id 382 Kagebou
    db $75

; E-0041 (C1: Func_000_2090 indexes it with the monster id; the 36 bytes it points at are added to hFFC6 and written to VRAM bank 1 as the picture's tile attributes). Far pointers: address, bank.
; record: raw 6 x 6 attribute map for the picture (a zero entry selects a default); ROM bank of that data
MonsterAttributeMapTable::
Data_038_447E:: ; heuristic: start of a structured table; C0
    dw JumpTable ; id 0
    db $00
    dw JumpTable ; id 1 DrakSlime
    db $00
    dw JumpTable ; id 2 SpotSlime
    db $00
    dw MonsterPicAttr_WingSlime ; id 3 WingSlime
    db $7B
    dw MonsterPicAttr_TreeSlime ; id 4 TreeSlime
    db $7B
    dw MonsterPicAttr_Snaily ; id 5 Snaily
    db $7B
    dw MonsterPicAttr_SlimeNite ; id 6 SlimeNite
    db $7B
    dw JumpTable ; id 7 Babble
    db $00
    dw JumpTable ; id 8 BoxSlime
    db $00
    dw MonsterPicAttr_PearlGel ; id 9 PearlGel
    db $7B
    dw JumpTable ; id 10 Slime
    db $00
    dw JumpTable ; id 11 Healer
    db $00
    dw MonsterPicAttr_FangSlime ; id 12 FangSlime
    db $7B
    dw JumpTable ; id 13 RockSlime
    db $00
    dw MonsterPicAttr_SlimeBorg ; id 14 SlimeBorg
    db $7B
    dw JumpTable ; id 15 Slabbit
    db $00
    dw MonsterPicAttr_KingSlime ; id 16 KingSlime
    db $7B
    dw JumpTable ; id 17 Metaly
    db $00
    dw JumpTable ; id 18 Metabble
    db $00
    dw MonsterPicAttr_SpotKing ; id 19 SpotKing
    db $7B
    dw MonsterPicAttr_TropicGel ; id 20 TropicGel
    db $7B
    dw MonsterPicAttr_MimeSlime ; id 21 MimeSlime
    db $7B
    dw MonsterPicAttr_HaloSlime ; id 22 HaloSlime
    db $7B
    dw MonsterPicAttr_MetalKing ; id 23 MetalKing
    db $7B
    dw MonsterPicAttr_GoldSlime ; id 24 GoldSlime
    db $7B
    dw MonsterPicAttr_GranSlime ; id 25 GranSlime
    db $7B
    dw MonsterPicAttr_WonderEgg ; id 26 WonderEgg
    db $7B
    dw JumpTable ; id 27 Butch
    db $00
    dw JumpTable ; id 28 ?
    db $00
    dw JumpTable ; id 29 ?
    db $00
    dw JumpTable ; id 30 ?
    db $00
    dw JumpTable ; id 31 ?
    db $00
    dw JumpTable ; id 32 ?
    db $00
    dw JumpTable ; id 33 ?
    db $00
    dw JumpTable ; id 34 ?
    db $00
    dw JumpTable ; id 35 ?
    db $00
    dw MonsterPicAttr_DragonKid ; id 36 DragonKid
    db $7B
    dw MonsterPicAttr_Tortragon ; id 37 Tortragon
    db $7B
    dw MonsterPicAttr_Pteranod ; id 38 Pteranod
    db $7B
    dw JumpTable ; id 39 Gasgon
    db $00
    dw MonsterPicAttr_FairyDrak ; id 40 FairyDrak
    db $7B
Data_038_44F9:: ; heuristic: label inside a table; C0
    dw MonsterPicAttr_LizardMan ; id 41 LizardMan
    db $7B
    dw MonsterPicAttr_Poisongon ; id 42 Poisongon
    db $7B
    dw MonsterPicAttr_Swordgon ; id 43 Swordgon
    db $7B
    dw JumpTable ; id 44 Drygon
    db $00
    dw MonsterPicAttr_Dragon ; id 45 Dragon
    db $7B
    dw MonsterPicAttr_MiniDrak ; id 46 MiniDrak
    db $7B
    dw MonsterPicAttr_MadDragon ; id 47 MadDragon
    db $7B
    dw MonsterPicAttr_Rayburn ; id 48 Rayburn
    db $7B
    dw JumpTable ; id 49 Chamelgon
    db $00
    dw JumpTable ; id 50 LizardFly
    db $00
    dw MonsterPicAttr_Andreal ; id 51 Andreal
    db $7B
    dw JumpTable ; id 52 KingCobra
    db $00
    dw MonsterPicAttr_Vampirus ; id 53 Vampirus
    db $7B
    dw MonsterPicAttr_SnakeBat ; id 54 SnakeBat
    db $7B
    dw MonsterPicAttr_Spikerous ; id 55 Spikerous
    db $7B
    dw JumpTable ; id 56 GreatDrak
    db $00
    dw MonsterPicAttr_Crestpent ; id 57 Crestpent
    db $7B
    dw MonsterPicAttr_WingSnake ; id 58 WingSnake
    db $7B
    dw MonsterPicAttr_Coatol ; id 59 Coatol
    db $7B
    dw MonsterPicAttr_Orochi ; id 60 Orochi
    db $7B
    dw MonsterPicAttr_BattleRex ; id 61 BattleRex
    db $7B
    dw JumpTable ; id 62 SkyDragon
    db $00
    dw MonsterPicAttr_Serpentia ; id 63 Serpentia
    db $7B
    dw MonsterPicAttr_Divinegon ; id 64 Divinegon
    db $7B
    dw MonsterPicAttr_Orligon ; id 65 Orligon
    db $7B
    dw MonsterPicAttr_GigaDraco ; id 66 GigaDraco
    db $7B
    dw JumpTable ; id 67 ?
    db $00
    dw JumpTable ; id 68 ?
    db $00
    dw JumpTable ; id 69 ?
    db $00
    dw JumpTable ; id 70 ?
    db $00
    dw MonsterPicAttr_Tonguella ; id 71 Tonguella
    db $7B
    dw JumpTable ; id 72 Almiraj
    db $00
    dw JumpTable ; id 73 CatFly
    db $00
    dw MonsterPicAttr_PillowRat ; id 74 PillowRat
    db $7B
    dw MonsterPicAttr_Saccer ; id 75 Saccer
    db $7B
    dw MonsterPicAttr_GulpBeast ; id 76 GulpBeast
    db $7B
    dw MonsterPicAttr_Skullroo ; id 77 Skullroo
    db $7B
    dw JumpTable ; id 78 WindBeast
    db $00
    dw MonsterPicAttr_Beavern ; id 79 Beavern
    db $7B
    dw MonsterPicAttr_Antbear ; id 80 Antbear
    db $7B
    dw MonsterPicAttr_SuperTen ; id 81 SuperTen
    db $7B
    dw MonsterPicAttr_IronTurt ; id 82 IronTurt
    db $7B
    dw JumpTable ; id 83 Mommonja
    db $00
    dw MonsterPicAttr_HammerMan ; id 84 HammerMan
    db $7B
    dw JumpTable ; id 85 Grizzly
    db $00
    dw MonsterPicAttr_Yeti ; id 86 Yeti
    db $7B
    dw MonsterPicAttr_ArrowDog ; id 87 ArrowDog
    db $7B
    dw MonsterPicAttr_NoctoKing ; id 88 NoctoKing
    db $7B
    dw MonsterPicAttr_BeastNite ; id 89 BeastNite
    db $7B
    dw JumpTable ; id 90 MadGopher
    db $00
    dw MonsterPicAttr_FairyRat ; id 91 FairyRat
    db $7B
    dw MonsterPicAttr_Unicorn ; id 92 Unicorn
    db $7B
    dw MonsterPicAttr_Goategon ; id 93 Goategon
    db $7B
    dw JumpTable ; id 94 WildApe
    db $00
    dw JumpTable ; id 95 Trumpeter
    db $00
    dw JumpTable ; id 96 KingLeo
    db $00
    dw MonsterPicAttr_DarkHorn ; id 97 DarkHorn
    db $7B
    dw MonsterPicAttr_MadCat ; id 98 MadCat
    db $7B
    dw MonsterPicAttr_BigEye ; id 99 BigEye
    db $7B
    dw MonsterPicAttr_Gorago ; id 100 Gorago
    db $7B
    dw MonsterPicAttr_CatMage ; id 101 CatMage
    db $7B
Data_038_45B0:: ; heuristic: label inside a table; C0
    dw MonsterPicAttr_Dumbira ; id 102 Dumbira
    db $7B
    dw JumpTable ; id 103 ?
    db $00
    dw JumpTable ; id 104 ?
    db $00
    dw JumpTable ; id 105 ?
    db $00
    dw MonsterPicAttr_Picky ; id 106 Picky
    db $7B
    dw MonsterPicAttr_Wyvern ; id 107 Wyvern
    db $7B
    dw MonsterPicAttr_BullBird ; id 108 BullBird
    db $7B
    dw MonsterPicAttr_Florajay ; id 109 Florajay
    db $7B
    dw MonsterPicAttr_DuckKite ; id 110 DuckKite
    db $7B
    dw MonsterPicAttr_MadPecker ; id 111 MadPecker
    db $7B
    dw MonsterPicAttr_MadRaven ; id 112 MadRaven
    db $7B
    dw JumpTable ; id 113 MistyWing
    db $00
    dw MonsterPicAttr_AquaHawk ; id 114 AquaHawk
    db $7B
    dw JumpTable ; id 115 Dracky
    db $00
    dw MonsterPicAttr_KiteHawk ; id 116 KiteHawk
    db $7B
    dw MonsterPicAttr_BigRoost ; id 117 BigRoost
    db $7B
    dw MonsterPicAttr_StubBird ; id 118 StubBird
    db $7B
    dw JumpTable ; id 119 LandOwl
    db $00
    dw MonsterPicAttr_MadGoose ; id 120 MadGoose
    db $7B
    dw MonsterPicAttr_MadCondor ; id 121 MadCondor
    db $7B
    dw MonsterPicAttr_Emyu ; id 122 Emyu
    db $7B
    dw MonsterPicAttr_Blizzardy ; id 123 Blizzardy
    db $7B
    dw JumpTable ; id 124 Phoenix
    db $00
    dw MonsterPicAttr_ZapBird ; id 125 ZapBird
    db $7B
    dw MonsterPicAttr_Garudian ; id 126 Garudian
    db $7B
    dw MonsterPicAttr_WhipBird ; id 127 WhipBird
    db $7B
    dw MonsterPicAttr_FunkyBird ; id 128 FunkyBird
    db $7B
    dw MonsterPicAttr_RainHawk ; id 129 RainHawk
    db $7B
    dw MonsterPicAttr_Azurile ; id 130 Azurile
    db $7B
    dw MonsterPicAttr_Shantak ; id 131 Shantak
    db $7B
    dw MonsterPicAttr_CragDevil ; id 132 CragDevil
    db $7B
    dw JumpTable ; id 133 ?
    db $00
    dw JumpTable ; id 134 ?
    db $00
    dw JumpTable ; id 135 ?
    db $00
    dw JumpTable ; id 136 ?
    db $00
    dw JumpTable ; id 137 ?
    db $00
    dw JumpTable ; id 138 ?
    db $00
    dw JumpTable ; id 139 ?
    db $00
    dw JumpTable ; id 140 ?
    db $00
    dw MonsterPicAttr_MadPlant ; id 141 MadPlant
    db $7B
    dw MonsterPicAttr_FireWeed ; id 142 FireWeed
    db $7B
    dw MonsterPicAttr_FloraMan ; id 143 FloraMan
    db $7B
    dw MonsterPicAttr_WingTree ; id 144 WingTree
    db $7B
    dw MonsterPicAttr_CactiBall ; id 145 CactiBall
    db $7B
    dw MonsterPicAttr_Gulpple ; id 146 Gulpple
    db $7B
    dw MonsterPicAttr_Toadstool ; id 147 Toadstool
    db $7B
    dw MonsterPicAttr_AmberWeed ; id 148 AmberWeed
    db $7B
    dw MonsterPicAttr_Slurperon ; id 149 Slurperon
    db $7B
    dw MonsterPicAttr_Stubsuck ; id 150 Stubsuck
    db $7B
    dw MonsterPicAttr_Oniono ; id 151 Oniono
    db $7B
    dw MonsterPicAttr_DanceVegi ; id 152 DanceVegi
    db $7B
    dw MonsterPicAttr_TreeBoy ; id 153 TreeBoy
    db $7B
    dw MonsterPicAttr_Devipine ; id 154 Devipine
    db $7B
    dw MonsterPicAttr_FaceTree ; id 155 FaceTree
    db $7B
    dw MonsterPicAttr_HerbMan ; id 156 HerbMan
    db $7B
    dw MonsterPicAttr_BeanMan ; id 157 BeanMan
    db $7B
    dw MonsterPicAttr_EvilSeed ; id 158 EvilSeed
    db $7B
    dw MonsterPicAttr_ManEater ; id 159 ManEater
    db $7B
    dw MonsterPicAttr_Snapper ; id 160 Snapper
    db $7B
    dw MonsterPicAttr_GhosTree ; id 161 GhosTree
    db $7B
    dw MonsterPicAttr_Rosevine ; id 162 Rosevine
Data_038_4666:: ; heuristic: label inside a table; C0
    db $7B
    dw MonsterPicAttr_Egdracil ; id 163 Egdracil
    db $7B
    dw MonsterPicAttr_Warubou ; id 164 Warubou
    db $7B
    dw JumpTable ; id 165 Watabou
    db $00
    dw JumpTable ; id 166 Eggplaton
    db $00
    dw MonsterPicAttr_FooHero ; id 167 FooHero
    db $7B
    dw JumpTable ; id 168 ?
    db $00
    dw JumpTable ; id 169 ?
    db $00
    dw JumpTable ; id 170 ?
    db $00
    dw JumpTable ; id 171 ?
    db $00
    dw JumpTable ; id 172 ?
    db $00
    dw JumpTable ; id 173 ?
    db $00
    dw JumpTable ; id 174 ?
    db $00
    dw JumpTable ; id 175 ?
    db $00
    dw MonsterPicAttr_GiantSlug ; id 176 GiantSlug
    db $7B
    dw MonsterPicAttr_Catapila ; id 177 Catapila
    db $7B
    dw JumpTable ; id 178 Gophecada
    db $00
    dw MonsterPicAttr_Butterfly ; id 179 Butterfly
    db $7B
    dw MonsterPicAttr_WeedBug ; id 180 WeedBug
    db $7B
    dw JumpTable ; id 181 GiantWorm
    db $00
    dw MonsterPicAttr_Lipsy ; id 182 Lipsy
    db $7B
    dw MonsterPicAttr_StagBug ; id 183 StagBug
    db $7B
    dw MonsterPicAttr_Pyuro ; id 184 Pyuro
    db $7B
    dw JumpTable ; id 185 ArmyAnt
    db $00
    dw MonsterPicAttr_GoHopper ; id 186 GoHopper
    db $7B
    dw MonsterPicAttr_TailEater ; id 187 TailEater
    db $7B
    dw MonsterPicAttr_ArmorPede ; id 188 ArmorPede
    db $7B
    dw MonsterPicAttr_Eyeder ; id 189 Eyeder
    db $7B
    dw MonsterPicAttr_GiantMoth ; id 190 GiantMoth
    db $7B
    dw MonsterPicAttr_Droll ; id 191 Droll
    db $7B
    dw JumpTable ; id 192 ArmyCrab
    db $00
    dw JumpTable ; id 193 MadHornet
    db $00
    dw MonsterPicAttr_Belzebub ; id 194 Belzebub
    db $7B
    dw MonsterPicAttr_WarMantis ; id 195 WarMantis
    db $7B
    dw MonsterPicAttr_HornBeet ; id 196 HornBeet
    db $7B
    dw MonsterPicAttr_Sickler ; id 197 Sickler
    db $7B
    dw JumpTable ; id 198 Armorpion
    db $00
    dw MonsterPicAttr_Digster ; id 199 Digster
    db $7B
    dw MonsterPicAttr_Skularach ; id 200 Skularach
    db $7B
    dw MonsterPicAttr_MultiEyes ; id 201 MultiEyes
    db $7B
    dw JumpTable ; id 202 ?
    db $00
    dw JumpTable ; id 203 ?
    db $00
    dw JumpTable ; id 204 ?
    db $00
    dw JumpTable ; id 205 ?
    db $00
    dw JumpTable ; id 206 ?
    db $00
    dw JumpTable ; id 207 ?
    db $00
    dw JumpTable ; id 208 ?
    db $00
    dw JumpTable ; id 209 ?
    db $00
    dw JumpTable ; id 210 ?
    db $00
    dw MonsterPicAttr_Pixy ; id 211 Pixy
    db $7B
    dw JumpTable ; id 212 MedusaEye
    db $00
    dw JumpTable ; id 213 AgDevil
    db $00
    dw MonsterPicAttr_Demonite ; id 214 Demonite
    db $7B
    dw JumpTable ; id 215 DarkEye
    db $00
    dw JumpTable ; id 216 EyeBall
    db $00
    dw MonsterPicAttr_SkulRider ; id 217 SkulRider
    db $7B
    dw JumpTable ; id 218 EvilBeast
    db $00
    dw MonsterPicAttr_Bubblemon ; id 219 Bubblemon
    db $7B
    dw MonsterPicAttr_1EyeClown ; id 220 1EyeClown
    db $7B
    dw JumpTable ; id 221 Gremlin
    db $00
    dw MonsterPicAttr_ArcDemon ; id 222 ArcDemon
    db $7B
    dw MonsterPicAttr_Lionex ; id 223 Lionex
    db $7B
    dw MonsterPicAttr_GoatHorn ; id 224 GoatHorn
    db $7B
    dw MonsterPicAttr_Orc ; id 225 Orc
    db $7B
    dw MonsterPicAttr_Ogre ; id 226 Ogre
    db $7B
    dw MonsterPicAttr_GateGuard ; id 227 GateGuard
    db $7B
    dw MonsterPicAttr_ChopClown ; id 228 ChopClown
    db $7B
    dw MonsterPicAttr_BossTroll ; id 229 BossTroll
    db $7B
    dw MonsterPicAttr_Grendal ; id 230 Grendal
    db $7B
    dw MonsterPicAttr_Akubar ; id 231 Akubar
    db $7B
    dw MonsterPicAttr_MadKnight ; id 232 MadKnight
    db $7B
    dw MonsterPicAttr_EvilWell ; id 233 EvilWell
    db $7B
    dw MonsterPicAttr_Gigantes ; id 234 Gigantes
    db $7B
    dw MonsterPicAttr_Centasaur ; id 235 Centasaur
    db $7B
    dw MonsterPicAttr_EvilArmor ; id 236 EvilArmor
    db $7B
    dw MonsterPicAttr_Jamirus ; id 237 Jamirus
    db $7B
    dw MonsterPicAttr_Durran ; id 238 Durran
    db $7B
    dw MonsterPicAttr_Titanis ; id 239 Titanis
    db $7B
    dw MonsterPicAttr_LampGenie ; id 240 LampGenie
    db $7B
    dw JumpTable ; id 241 ?
    db $00
    dw JumpTable ; id 242 ?
    db $00
    dw JumpTable ; id 243 ?
    db $00
    dw JumpTable ; id 244 ?
    db $00
    dw JumpTable ; id 245 ?
    db $00
    dw MonsterPicAttr_Spooky ; id 246 Spooky
    db $7B
    dw MonsterPicAttr_Skullgon ; id 247 Skullgon
    db $7B
    dw JumpTable ; id 248 PutrePup
    db $00
    dw MonsterPicAttr_RotRaven ; id 249 RotRaven
    db $7B
    dw MonsterPicAttr_Mummy ; id 250 Mummy
    db $7B
Data_038_476F:: ; heuristic: label inside a table; C0
    dw MonsterPicAttr_DarkCrab ; id 251 DarkCrab
    db $7B
    dw MonsterPicAttr_DeadNite ; id 252 DeadNite
    db $7B
    dw JumpTable ; id 253 Shadow
    db $00
    dw JumpTable ; id 254 Skulpent
    db $00
    dw MonsterPicAttr_Hork ; id 255 Hork
    db $7B
    dw JumpTable ; id 256 Mudron
    db $00
    dw JumpTable ; id 257 NiteWhip
    db $00
    dw JumpTable ; id 258 WindMerge
    db $00
    dw JumpTable ; id 259 Reaper
    db $00
    dw MonsterPicAttr_Inverzon ; id 260 Inverzon
    db $7B
    dw JumpTable ; id 261 FoxFire
    db $00
    dw MonsterPicAttr_CaptDead ; id 262 CaptDead
    db $7B
    dw MonsterPicAttr_DeadNoble ; id 263 DeadNoble
    db $7B
    dw MonsterPicAttr_WhiteKing ; id 264 WhiteKing
    db $7B
    dw MonsterPicAttr_BoneSlave ; id 265 BoneSlave
    db $7B
    dw MonsterPicAttr_Skeletor ; id 266 Skeletor
    db $7B
    dw MonsterPicAttr_Servant ; id 267 Servant
    db $7B
    dw MonsterPicAttr_Lazamanus ; id 268 Lazamanus
    db $7B
    dw JumpTable ; id 269 Copycat
    db $00
    dw JumpTable ; id 270 MadSpirit
    db $00
    dw MonsterPicAttr_PomPomBom ; id 271 PomPomBom
    db $7B
    dw JumpTable ; id 272 Niterich
    db $00
    dw JumpTable ; id 273 ?
    db $00
    dw JumpTable ; id 274 ?
    db $00
    dw JumpTable ; id 275 ?
    db $00
    dw JumpTable ; id 276 ?
    db $00
    dw JumpTable ; id 277 ?
    db $00
    dw JumpTable ; id 278 ?
    db $00
    dw JumpTable ; id 279 ?
    db $00
    dw JumpTable ; id 280 ?
    db $00
    dw MonsterPicAttr_JewelBag ; id 281 JewelBag
    db $7B
    dw JumpTable ; id 282 EvilWand
    db $00
    dw MonsterPicAttr_MadCandle ; id 283 MadCandle
    db $7B
    dw MonsterPicAttr_CoilBird ; id 284 CoilBird
Data_038_47D4:: ; heuristic: label inside a table; C0
    db $7B
    dw MonsterPicAttr_Facer ; id 285 Facer
    db $7B
    dw JumpTable ; id 286 SpikyBoy
    db $00
    dw JumpTable ; id 287 MadMirror
    db $00
    dw MonsterPicAttr_RogueNite ; id 288 RogueNite
    db $7B
    dw MonsterPicAttr_Puppetor ; id 289 Puppetor
    db $7B
    dw JumpTable ; id 290 Goopi
    db $00
    dw JumpTable ; id 291 Voodoll
    db $00
    dw MonsterPicAttr_MetalDrak ; id 292 MetalDrak
    db $7B
    dw MonsterPicAttr_Balzak ; id 293 Balzak
    db $7B
    dw JumpTable ; id 294 SabreMan
    db $00
    dw MonsterPicAttr_CurseLamp ; id 295 CurseLamp
    db $7B
    dw MonsterPicAttr_Brushead ; id 296 Brushead
    db $7B
    dw MonsterPicAttr_Roboster ; id 297 Roboster
    db $7B
    dw MonsterPicAttr_Roboster2 ; id 298 Roboster2
    db $7B
    dw JumpTable ; id 299 EvilPot
    db $00
    dw JumpTable ; id 300 Gismo
    db $00
    dw JumpTable ; id 301 LavaMan
    db $00
    dw JumpTable ; id 302 IceMan
    db $00
    dw MonsterPicAttr_Mimic ; id 303 Mimic
    db $7B
    dw MonsterPicAttr_Exaucers ; id 304 Exaucers
    db $7B
    dw JumpTable ; id 305 MudDoll
    db $00
    dw JumpTable ; id 306 Golem
    db $00
    dw JumpTable ; id 307 StoneMan
    db $00
    dw JumpTable ; id 308 BombCrag
    db $00
    dw MonsterPicAttr_GoldGolem ; id 309 GoldGolem
    db $7B
    dw MonsterPicAttr_DarkMate ; id 310 DarkMate
    db $7B
    dw MonsterPicAttr_ProtoMech ; id 311 ProtoMech
    db $7B
    dw MonsterPicAttr_CloudKing ; id 312 CloudKing
    db $7B
    dw JumpTable ; id 313 ?
    db $00
    dw JumpTable ; id 314 ?
    db $00
    dw JumpTable ; id 315 ?
    db $00
    dw MonsterPicAttr_Petiteel ; id 316 Petiteel
    db $7B
    dw MonsterPicAttr_Moray ; id 317 Moray
    db $7B
    dw JumpTable ; id 318 WalrusMan
    db $00
    dw JumpTable ; id 319 RayGigas
    db $00
    dw MonsterPicAttr_Anemon ; id 320 Anemon
    db $7B
    dw MonsterPicAttr_Aquarella ; id 321 Aquarella
    db $7B
    dw JumpTable ; id 322 Merman
    db $00
    dw MonsterPicAttr_Octokid ; id 323 Octokid
    db $7B
    dw MonsterPicAttr_PutreFish ; id 324 PutreFish
    db $7B
    dw JumpTable ; id 325 Octoreach
    db $00
    dw MonsterPicAttr_Angleron ; id 326 Angleron
    db $7B
    dw MonsterPicAttr_FishRider ; id 327 FishRider
    db $7B
    dw MonsterPicAttr_RushFish ; id 328 RushFish
    db $7B
    dw MonsterPicAttr_Gamanian ; id 329 Gamanian
    db $7B
    dw MonsterPicAttr_Clawster ; id 330 Clawster
    db $7B
    dw JumpTable ; id 331 CancerMan
    db $00
    dw MonsterPicAttr_RogueWave ; id 332 RogueWave
    db $7B
    dw MonsterPicAttr_Scallopa ; id 333 Scallopa
    db $7B
    dw JumpTable ; id 334 SeaHorse
    db $00
    dw MonsterPicAttr_HoodSquid ; id 335 HoodSquid
    db $7B
    dw MonsterPicAttr_MerTiger ; id 336 MerTiger
Data_038_4870:: ; heuristic: label inside a table; C0
    db $7B
    dw MonsterPicAttr_AxeShark ; id 337 AxeShark
    db $7B
    dw JumpTable ; id 338 Octogon
    db $00
    dw MonsterPicAttr_KingSquid ; id 339 KingSquid
    db $7B
    dw MonsterPicAttr_Digong ; id 340 Digong
    db $7B
    dw MonsterPicAttr_WhaleMage ; id 341 WhaleMage
    db $7B
    dw MonsterPicAttr_Aquadon ; id 342 Aquadon
    db $7B
    dw MonsterPicAttr_Octoraid ; id 343 Octoraid
    db $7B
    dw MonsterPicAttr_Grakos ; id 344 Grakos
    db $7B
    dw MonsterPicAttr_Poseidon ; id 345 Poseidon
    db $7B
    dw MonsterPicAttr_Pumpoise ; id 346 Pumpoise
    db $7B
    dw JumpTable ; id 347 Starfish
    db $00
    dw JumpTable ; id 348 ?
    db $00
    dw JumpTable ; id 349 ?
    db $00
    dw JumpTable ; id 350 ?
    db $00
    dw MonsterPicAttr_DracoLord ; id 351 DracoLord
    db $7B
    dw MonsterPicAttr_DracoLord_160 ; id 352 DracoLord
    db $7B
    dw MonsterPicAttr_LordDraco ; id 353 LordDraco
    db $7B
    dw MonsterPicAttr_Hargon ; id 354 Hargon
    db $7B
    dw JumpTable ; id 355 Sidoh
    db $00
    dw MonsterPicAttr_Genosidoh ; id 356 Genosidoh
    db $7B
    dw MonsterPicAttr_Baramos ; id 357 Baramos
    db $7B
    dw MonsterPicAttr_Zoma ; id 358 Zoma
    db $7B
    dw MonsterPicAttr_AsuraZoma ; id 359 AsuraZoma
    db $7B
    dw JumpTable ; id 360 Pizzaro
    db $00
    dw MonsterPicAttr_PsychoPiz ; id 361 PsychoPiz
    db $7B
    dw MonsterPicAttr_Esterk ; id 362 Esterk
    db $7B
    dw MonsterPicAttr_Mirudraas ; id 363 Mirudraas
    db $7B
    dw JumpTable ; id 364 Mirudraas
    db $00
    dw MonsterPicAttr_Mudou ; id 365 Mudou
    db $7B
    dw MonsterPicAttr_DeathMore ; id 366 DeathMore
    db $7B
    dw JumpTable ; id 367 DeathMore
    db $00
    dw MonsterPicAttr_DeathMore_170 ; id 368 DeathMore
    db $7B
    dw MonsterPicAttr_Darkdrium ; id 369 Darkdrium
    db $7B
    dw MonsterPicAttr_Orgodemir ; id 370 Orgodemir
    db $7B
    dw MonsterPicAttr_Orgodemir_173 ; id 371 Orgodemir
    db $7B
    dw MonsterPicAttr_Darck ; id 372 Darck
    db $7B
    dw JumpTable ; id 373 Tatsu
    db $00
    dw JumpTable ; id 374 Diago
    db $00
    dw JumpTable ; id 375 Samsi
    db $00
    dw JumpTable ; id 376 Bazoo
    db $00
    dw JumpTable ; id 377 ?
    db $00
    dw JumpTable ; id 378 ?
    db $00
    dw JumpTable ; id 379 ?
    db $00
    dw MonsterPicAttr_Lamia ; id 380 Lamia
    db $7B
    dw MonsterPicAttr_Dimensaur ; id 381 Dimensaur
    db $7B
    dw MonsterPicAttr_Kagebou ; id 382 Kagebou
    db $7B
    ds $5C, $00

Data_038_4957:: ; heuristic: target of a monotone pointer table; C0
    ds $94, $00

Data_038_49EB:: ; heuristic: target of a monotone pointer table; C0
    ds $AC, $00

Data_038_4A97:: ; heuristic: target of a monotone pointer table; C0
    ds $C4, $00

Data_038_4B5B:: ; heuristic: target of a monotone pointer table; C0
    ds $148, $00

Data_038_4CA3:: ; heuristic: target of a monotone pointer table; C0
    ds $65, $00

Data_038_4D08:: ; heuristic: target of a monotone pointer table; C0
    ds $B7, $00

Data_038_4DBF:: ; heuristic: target of a monotone pointer table; C0
    ds $166, $00

Data_038_4F25:: ; heuristic: target of a monotone pointer table; C0
    ds $D9, $00

Data_038_4FFE:: ; heuristic: target of a monotone pointer table; C0
    ds $10A, $00

Data_038_5108:: ; heuristic: target of a monotone pointer table; C0
    ds $AB, $00

Data_038_51B3:: ; heuristic: target of a monotone pointer table; C0
    ds $149, $00

Data_038_52FC:: ; heuristic: target of a monotone pointer table; C0
    ds $1EB, $00

Data_038_54E7:: ; heuristic: target of a monotone pointer table; C0
    ds $1FD, $00

Data_038_56E4:: ; heuristic: target of a monotone pointer table; C0
    ds $435, $00

Data_038_5B19:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5B3D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5B61:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5B85:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5BA9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5BCD:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5BF1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5C15:: ; heuristic: target of a monotone pointer table; C0
    ds $1B0, $00

Data_038_5DC5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5DE9:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5E31:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5E55:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5E9D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5EE5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5F09:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5F51:: ; heuristic: target of a monotone pointer table; C0
    ds $3A8, $00

Data_038_62F9:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6341:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6389:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_63D1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_63F5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6419:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6461:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6485:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_64CD:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6515:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6539:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_655D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6581:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_65A5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_65C9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_65ED:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6611:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6635:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6659:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_667D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_66A1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_66C5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_66E9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_670D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6731:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6755:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6779:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_679D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_67C1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_67E5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6809:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_682D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6851:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6875:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6899:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_68BD:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_68E1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6905:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6929:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_694D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6971:: ; heuristic: target of a monotone pointer table; C0
    ds $3A8, $00

Data_038_6D19:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6D3D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6D85:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6DCD:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6E15:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6E5D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6EA5:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6EED:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6F35:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6F7D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6FC5:: ; heuristic: target of a monotone pointer table; C0
    ds $47B, $00

Data_038_7440:: ; heuristic: target of a monotone pointer table; C0
    ds $17, $00

Data_038_7457:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7458:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_745A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_745B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_745D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_745E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7460:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7461:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7463:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7465:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7466:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7467:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7469:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_746B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_746C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_746E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_746F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7470:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7472:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7473:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7475:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7477:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7478:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_747A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_747C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_747E:: ; heuristic: target of a monotone pointer table; C0
    ds $C2, $00

Data_038_7540:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7541:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7543:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7545:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7547:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7549:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7550:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7551:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7552:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7554:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7556:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7557:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7558:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7559:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_755B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_755C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_755E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_755F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7561:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7563:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7564:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7566:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7567:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7569:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_756B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_756D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_756F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7570:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7572:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7574:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7575:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7577:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_757A:: ; heuristic: target of a monotone pointer table; C0
    ds $C6, $00

Data_038_7640:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7642:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7644:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7646:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7649:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_764C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_764F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7652:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_7656:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7659:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_765D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7660:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_7664:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7666:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7669:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_766B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_766E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7670:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7673:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7676:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7678:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_767B:: ; heuristic: target of a monotone pointer table; C0
    ds $76, $00

Data_038_76F1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_7715:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_7739:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_038_7743:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7745:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7747:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7748:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7749:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7750:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7751:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7752:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7753:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7754:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7755:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7756:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7757:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7758:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_775A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_775B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_775D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_775E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_775F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7761:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7762:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7764:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7766:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7768:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7769:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_776B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7770:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7771:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7772:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7774:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7775:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7776:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7778:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7779:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_777B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_777C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_777D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_7781:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_77A5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_77C9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_77ED:: ; heuristic: target of a monotone pointer table; C0
    ds $53, $00

Data_038_7840:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7841:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7843:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7844:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7845:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7846:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7847:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7849:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_784B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_784C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_784D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_784E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7851:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7852:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7854:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7855:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7857:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7859:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_785B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_785D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_785F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7861:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7862:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7864:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7866:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7868:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_786A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_786B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_786E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_786F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7870:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7872:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7873:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7874:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7875:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7876:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7878:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7879:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_787A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_787B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_787D:: ; heuristic: target of a monotone pointer table; C0
    ds $C3, $00

Data_038_7940:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7941:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7942:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7944:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7945:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7947:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7949:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_794A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_794C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_794E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7950:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7951:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7952:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7954:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7955:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7956:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7957:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7958:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7959:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_795C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7960:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7962:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7964:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7965:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7966:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7967:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7969:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_796B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7970:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7972:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7973:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7975:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7976:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7977:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7979:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_797B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_797D:: ; heuristic: target of a monotone pointer table; C0
    ds $C4, $00

Data_038_7A41:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A43:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A45:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A47:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A48:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A4A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A4C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A4E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A50:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A52:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A54:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A56:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A58:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A59:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7A5C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A5D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A5F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A61:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A63:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A65:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A67:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A69:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A6B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A6D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A6E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7A71:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A73:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A74:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A76:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A78:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A7A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A7B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A7D:: ; heuristic: target of a monotone pointer table; C0
    ds $583, $00
