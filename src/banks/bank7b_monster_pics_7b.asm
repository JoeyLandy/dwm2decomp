; ROM bank $7B: compressed monster pictures and palettes
; The annotated listing of this bank is build/listing/bank7b.asm.

SECTION "Bank 7B", ROMX[$4000], BANK[$7B]
    db $7b

; compressed 6 x 6 picture (36 tiles) of monster id $17D (Dimensaur) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 520 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Dimensaur::
    INCBIN "gfx/monster_pics/dimensaur.lz"

; LoadMonsterPicture copies 16 bytes from bank $7B, $4209 + 16 * monster id to the palette buffer
; wBGPaletteBuffer on CGB; the count matches the picture table (E-0041, C1)
; record: CGB colours of the monster picture (two 4-colour palettes, BGR555 words)
MonsterPaletteTable::
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 0
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 1 DrakSlime
    dw $01da, $7fff, $035f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 2 SpotSlime
    dw $35e0, $7fff, $4ba0, $0000, $00fc, $7fff, $4ba0, $0000 ; id 3 WingSlime
    dw $000f, $7fff, $78b4, $0000, $2200, $7fff, $035f, $0000 ; id 4 TreeSlime
    dw $0224, $7fff, $03d0, $0000, $0110, $7fff, $025f, $0000 ; id 5 Snaily
    dw $7d00, $7fff, $4a92, $0000, $0c5a, $7fff, $1b40, $0000 ; id 6 SlimeNite
    dw $25a0, $7fff, $1be5, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 7 Babble
    dw $000d, $7fff, $0c1f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 8 BoxSlime
    dw $2daf, $7fff, $431b, $0000, $31ab, $7fff, $6f40, $0000 ; id 9 PearlGel
    dw $5c0f, $7fff, $7ea0, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 10 Slime
    dw $7ce1, $7fff, $023f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 11 Healer
    dw $4d21, $7fff, $023f, $0000, $4d21, $7fff, $76a0, $0000 ; id 12 FangSlime
    dw $00ef, $7fff, $15fc, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 13 RockSlime
    dw $18e6, $7fff, $31ac, $0000, $4ca8, $7fff, $4631, $0000 ; id 14 SlimeBorg
    dw $0011, $7fff, $311f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 15 Slabbit
    dw $74e4, $7fff, $7e42, $0000, $2aa3, $7fff, $24bf, $0000 ; id 16 KingSlime
    dw $2549, $7fff, $4a51, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 17 Metaly
    dw $2549, $7fff, $4a51, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 18 Metabble
    dw $019a, $7fff, $035f, $0000, $0380, $7fff, $001f, $0000 ; id 19 SpotKing
    dw $014d, $7fff, $0235, $0000, $0220, $7fff, $027f, $0000 ; id 20 TropicGel
    dw $4472, $7fff, $02bf, $0000, $001f, $7fff, $02bf, $0000 ; id 21 MimeSlime
    dw $2cdc, $7fff, $65df, $0000, $2cdc, $7fff, $7fcf, $0000 ; id 22 HaloSlime
    dw $2549, $7fff, $4a51, $0000, $74e4, $7fff, $209f, $0000 ; id 23 MetalKing
    dw $017d, $7fff, $02ff, $0000, $7ec0, $7fff, $02ff, $0000 ; id 24 GoldSlime
    dw $0240, $7fff, $6ab2, $0000, $181c, $7fff, $6ab2, $0000 ; id 25 GranSlime
    dw $010c, $7fff, $22de, $0000, $010c, $7fff, $22de, $0000 ; id 26 WonderEgg
    dw $01da, $7fff, $035f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 27 Butch
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 28 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 29 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 30 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 31 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 32 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 33 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 34 ?
    dw $0191, $7fff, $029f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 35 ?
    dw $01de, $7fff, $037f, $0000, $7c1f, $7fff, $037f, $0000 ; id 36 DragonKid
    dw $0155, $7fff, $7e80, $0000, $0155, $7fff, $4633, $0000 ; id 37 Tortragon
    dw $55ca, $7fff, $7371, $0000, $55ca, $7fff, $03ff, $0000 ; id 38 Pteranod
    dw $1c37, $7fff, $029f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 39 Gasgon
    dw $2c11, $7fff, $209d, $0000, $2c11, $7fff, $67c0, $0000 ; id 40 FairyDrak
    dw $6d48, $7fff, $7f27, $0000, $017f, $7fff, $7f27, $0000 ; id 41 LizardMan
    dw $0d69, $7fff, $02d7, $0000, $0190, $7fff, $02d7, $0000 ; id 42 Poisongon
    dw $680a, $7fff, $7e00, $0000, $680a, $7fff, $0215, $0000 ; id 43 Swordgon
    dw $6de7, $7fff, $7ed2, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 44 Drygon
    dw $01c3, $7fff, $32a0, $0000, $01c3, $7fff, $0215, $0000 ; id 45 Dragon
    dw $0119, $7fff, $02bf, $0000, $001c, $7fff, $02bf, $0000 ; id 46 MiniDrak
    dw $4d20, $7fff, $7e80, $0000, $681f, $7fff, $7e80, $0000 ; id 47 MadDragon
    dw $017f, $7fff, $02ff, $0000, $681f, $7fff, $02ff, $0000 ; id 48 Rayburn
    dw $01a0, $7fff, $06a0, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 49 Chamelgon
    dw $0286, $7fff, $03b6, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 50 LizardFly
    dw $1525, $7fff, $424f, $0000, $7c1f, $7fff, $424f, $0000 ; id 51 Andreal
    dw $1546, $7fff, $1479, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 52 KingCobra
    dw $4d67, $7fff, $7230, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 53 Vampirus
    dw $0286, $7fff, $03b6, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 54 SnakeBat
    dw $00f1, $7fff, $3e51, $0000, $40a0, $7fff, $3e51, $0000 ; id 55 Spikerous
    dw $10ac, $7fff, $061f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 56 GreatDrak
    dw $187d, $7fff, $06c5, $0000, $0180, $7fff, $06c5, $0000 ; id 57 Crestpent
    dw $01a1, $7fff, $7e60, $0000, $0015, $7fff, $7e60, $0000 ; id 58 WingSnake
    dw $00f8, $7fff, $0723, $0000, $00f8, $7fff, $3e55, $0000 ; id 59 Coatol
    dw $014b, $7fff, $0286, $0000, $5037, $7fff, $0286, $0000 ; id 60 Orochi
    dw $1e00, $7fff, $076f, $0000, $3965, $7fff, $5f8f, $0000 ; id 61 BattleRex
    dw $010d, $7fff, $023d, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 62 SkyDragon
    dw $001d, $7fff, $79e0, $0000, $0015, $7fff, $0309, $0000 ; id 63 Serpentia
    dw $118b, $7fff, $1bec, $0000, $385b, $7fff, $1bec, $0000 ; id 64 Divinegon
    dw $01c8, $7fff, $02bf, $0000, $01c8, $7fff, $6260, $0000 ; id 65 Orligon
    dw $3c6a, $7fff, $155e, $0000, $0051, $7fff, $155e, $0000 ; id 66 GigaDraco
    dw $01de, $7fff, $037f, $0000, $7c1f, $7fff, $037f, $0000 ; id 67 ?
    dw $01de, $7fff, $037f, $0000, $7c1f, $7fff, $037f, $0000 ; id 68 ?
    dw $01de, $7fff, $037f, $0000, $7c1f, $7fff, $037f, $0000 ; id 69 ?
    dw $01de, $7fff, $037f, $0000, $7c1f, $7fff, $037f, $0000 ; id 70 ?
    dw $0113, $7fff, $021a, $0000, $6ac0, $7fff, $021a, $0000 ; id 71 Tonguella
    dw $7cf7, $7fff, $7ed9, $0000, $7cf7, $7fff, $023f, $0000 ; id 72 Almiraj
    dw $00d9, $7fff, $023f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 73 CatFly
    dw $01e5, $7fff, $036f, $0000, $023f, $7fff, $036f, $0000 ; id 74 PillowRat
    dw $04cf, $7fff, $0176, $0000, $5da0, $7fff, $0176, $0000 ; id 75 Saccer
    dw $1d8b, $7fff, $02b0, $0000, $34d0, $7fff, $02b0, $0000 ; id 76 GulpBeast
    dw $0179, $7fff, $035f, $0000, $1d8e, $7fff, $5f16, $0000 ; id 77 Skullroo
    dw $69a0, $7fff, $7f00, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 78 WindBeast
    dw $7ee0, $7fff, $027d, $0000, $011b, $7fff, $027d, $0000 ; id 79 Beavern
    dw $64e3, $7fff, $7e23, $0000, $64e3, $7fff, $017f, $0000 ; id 80 Antbear
    dw $582f, $7fff, $025f, $0000, $582f, $7fff, $6c5a, $0000 ; id 81 SuperTen
    dw $01c4, $7fff, $032e, $0000, $00d6, $7fff, $4651, $0000 ; id 82 IronTurt
    dw $39ee, $7fff, $025f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 83 Mommonja
    dw $2c12, $7fff, $2cde, $0000, $0511, $7fff, $01df, $0000 ; id 84 HammerMan
    dw $3526, $7fff, $4a0c, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 85 Grizzly
    dw $010e, $7fff, $3e54, $0000, $010e, $7fff, $455f, $0000 ; id 86 Yeti
    dw $316a, $7fff, $5293, $0000, $007d, $7fff, $5293, $0000 ; id 87 ArrowDog
    dw $3412, $7fff, $4d1f, $0000, $4585, $7fff, $4d1f, $0000 ; id 88 NoctoKing
    dw $1ceb, $7fff, $1cff, $0000, $6cf1, $7fff, $1cff, $0000 ; id 89 BeastNite
    dw $6c6c, $7fff, $7a87, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 90 MadGopher
    dw $70ad, $7fff, $713d, $0000, $009c, $7fff, $025f, $0000 ; id 91 FairyRat
    dw $009c, $7fff, $5a17, $0000, $009c, $7fff, $163b, $0000 ; id 92 Unicorn
    dw $75a0, $7fff, $023e, $0000, $75a0, $7fff, $6cd6, $0000 ; id 93 Goategon
    dw $486c, $7fff, $6cd6, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 94 WildApe
    dw $6144, $7fff, $76f0, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 95 Trumpeter
    dw $062d, $7fff, $7ac4, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 96 KingLeo
    dw $09c0, $7fff, $02bf, $0000, $68d5, $7fff, $02bf, $0000 ; id 97 DarkHorn
    dw $0017, $7fff, $01bf, $0000, $01f6, $7fff, $02ff, $0000 ; id 98 MadCat
    dw $00ef, $7fff, $01d8, $0000, $3680, $7fff, $01d8, $0000 ; id 99 BigEye
    dw $0016, $7fff, $027d, $0000, $0016, $7fff, $3a96, $0000 ; id 100 Gorago
    dw $0136, $7fff, $025f, $0000, $44b9, $7fff, $025f, $0000 ; id 101 CatMage
    dw $05ec, $7fff, $025f, $0000, $451e, $7fff, $025f, $0000 ; id 102 Dumbira
    dw $0113, $7fff, $021a, $0000, $6ac0, $7fff, $021a, $0000 ; id 103 ?
    dw $0113, $7fff, $021a, $0000, $6ac0, $7fff, $021a, $0000 ; id 104 ?
    dw $0113, $7fff, $021a, $0000, $6ac0, $7fff, $021a, $0000 ; id 105 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 106 Picky
    dw $011b, $7fff, $02ff, $0000, $011b, $7fff, $6a94, $0000 ; id 107 Wyvern
    dw $1c49, $7fff, $00cf, $0000, $2063, $7fff, $2cc6, $0000 ; id 108 BullBird
    dw $1857, $7fff, $039f, $0000, $1857, $7fff, $7e2a, $0000 ; id 109 Florajay
    dw $3c9f, $7fff, $01df, $0000, $3c9f, $7fff, $075f, $0000 ; id 110 DuckKite
    dw $001a, $7fff, $7c1f, $0000, $001a, $7fff, $01ff, $0000 ; id 111 MadPecker
    dw $010c, $7fff, $02bb, $0000, $4c11, $7fff, $7d9f, $0000 ; id 112 MadRaven
    dw $00dd, $7fff, $02bf, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 113 MistyWing
    dw $013c, $7fff, $031f, $0000, $62e0, $7fff, $031f, $0000 ; id 114 AquaHawk
    dw $007b, $7fff, $2a97, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 115 Dracky
    dw $540e, $7fff, $34bf, $0000, $540e, $7fff, $1b4d, $0000 ; id 116 KiteHawk
    dw $3037, $7fff, $02ff, $0000, $0156, $7fff, $02ff, $0000 ; id 117 BigRoost
    dw $7de0, $7fff, $025f, $0000, $4500, $7fff, $025f, $0000 ; id 118 StubBird
    dw $3031, $7fff, $483b, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 119 LandOwl
    dw $70d6, $7fff, $0218, $0000, $0019, $7fff, $70d6, $0000 ; id 120 MadGoose
    dw $3c4f, $7fff, $51f8, $0000, $38b0, $7fff, $023e, $0000 ; id 121 MadCondor
    dw $7d26, $7fff, $001f, $0000, $7d26, $7fff, $031f, $0000 ; id 122 Emyu
    dw $6120, $7fff, $76e8, $0000, $6120, $7fff, $05bf, $0000 ; id 123 Blizzardy
    dw $00bb, $7fff, $029d, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 124 Phoenix
    dw $7d2f, $7fff, $7eab, $0000, $7ced, $7fff, $01ff, $0000 ; id 125 ZapBird
    dw $6566, $7fff, $5ab4, $0000, $6566, $7fff, $02bf, $0000 ; id 126 Garudian
    dw $0033, $7fff, $015e, $0000, $015f, $7fff, $02ff, $0000 ; id 127 WhipBird
    dw $7c0d, $7fff, $7f69, $0000, $34d1, $7fff, $0a3c, $0000 ; id 128 FunkyBird
    dw $500d, $7fff, $68fb, $0000, $0019, $7fff, $02df, $0000 ; id 129 RainHawk
    dw $7909, $7fff, $1f3f, $0000, $1192, $7fff, $1f3f, $0000 ; id 130 Azurile
    dw $348e, $7fff, $7597, $0000, $1128, $7fff, $7597, $0000 ; id 131 Shantak
    dw $155e, $7fff, $7ea0, $0000, $155e, $7fff, $0e79, $0000 ; id 132 CragDevil
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 133 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 134 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 135 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 136 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 137 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 138 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 139 ?
    dw $10b5, $7fff, $021e, $0000, $380e, $7fff, $001e, $0000 ; id 140 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 141 MadPlant
    dw $6470, $7fff, $69ff, $0000, $0120, $7fff, $2feb, $0000 ; id 142 FireWeed
    dw $60b2, $7fff, $7e6e, $0000, $5870, $7fff, $398a, $0000 ; id 143 FloraMan
    dw $01c4, $7fff, $02f1, $0000, $5011, $7fff, $02f1, $0000 ; id 144 WingTree
    dw $01e1, $7fff, $032a, $0000, $3d2e, $7fff, $001f, $0000 ; id 145 CactiBall
    dw $0205, $7fff, $038d, $0000, $0110, $7fff, $038d, $0000 ; id 146 Gulpple
    dw $6470, $7fff, $7ee8, $0000, $4151, $7fff, $0336, $0000 ; id 147 Toadstool
    dw $008d, $7fff, $01ff, $0000, $1c0c, $7fff, $3816, $0000 ; id 148 AmberWeed
    dw $01ff, $7fff, $170e, $0000, $141f, $7fff, $461f, $0000 ; id 149 Slurperon
    dw $0110, $7fff, $021b, $0000, $0110, $7fff, $1e80, $0000 ; id 150 Stubsuck
    dw $012c, $7fff, $02ed, $0000, $0093, $7fff, $021f, $0000 ; id 151 Oniono
    dw $00da, $7fff, $025f, $0000, $012c, $7fff, $0388, $0000 ; id 152 DanceVegi
    dw $012f, $7fff, $021f, $0000, $012f, $7fff, $7700, $0000 ; id 153 TreeBoy
    dw $00f4, $7fff, $023c, $0000, $00f4, $7fff, $0aab, $0000 ; id 154 Devipine
    dw $0093, $7fff, $0217, $0000, $01c1, $7fff, $03ee, $0000 ; id 155 FaceTree
    dw $01c1, $7fff, $0217, $0000, $0091, $7fff, $0217, $0000 ; id 156 HerbMan
    dw $11e1, $7fff, $032c, $0000, $3d80, $7fff, $01db, $0000 ; id 157 BeanMan
    dw $3056, $7fff, $027e, $0000, $012f, $7fff, $021f, $0000 ; id 158 EvilSeed
    dw $005b, $7fff, $0f00, $0000, $005b, $7fff, $35df, $0000 ; id 159 ManEater
    dw $01c8, $7fff, $031c, $0000, $01c8, $7fff, $005b, $0000 ; id 160 Snapper
    dw $1d6f, $7fff, $52ba, $0000, $1d6f, $7fff, $52ba, $0000 ; id 161 GhosTree
    dw $0220, $7fff, $036c, $0000, $0078, $7fff, $036c, $0000 ; id 162 Rosevine
    dw $296d, $7fff, $12c4, $0000, $0186, $7fff, $12c4, $0000 ; id 163 Egdracil
    dw $1c75, $7fff, $2ddd, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 164 Warubou
    dw $58e0, $7fff, $7ea6, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 165 Watabou
    dw $404c, $7fff, $6cd6, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 166 Eggplaton
    dw $0193, $7fff, $024a, $0000, $00dd, $7fff, $4e73, $0000 ; id 167 FooHero
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 168 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 169 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 170 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 171 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 172 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 173 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 174 ?
    dw $0200, $7fff, $038d, $0000, $4000, $7fff, $7da0, $0000 ; id 175 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 176 GiantSlug
    dw $3816, $7fff, $034d, $0000, $3816, $7fff, $459f, $0000 ; id 177 Catapila
    dw $3810, $7fff, $027f, $0000, $3810, $7fff, $12c4, $0000 ; id 178 Gophecada
    dw $007b, $7fff, $7dce, $0000, $007b, $7fff, $7cb7, $0000 ; id 179 Butterfly
    dw $6d60, $7fff, $4740, $0000, $38ad, $7fff, $027f, $0000 ; id 180 WeedBug
    dw $4450, $7fff, $5d18, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 181 GiantWorm
    dw $0139, $7fff, $034e, $0000, $0013, $7fff, $59df, $0000 ; id 182 Lipsy
    dw $00d0, $7fff, $023f, $0000, $00d0, $7fff, $7204, $0000 ; id 183 StagBug
    dw $0572, $7fff, $421f, $0000, $6c12, $7fff, $421f, $0000 ; id 184 Pyuro
    dw $7c0b, $7fff, $6381, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 185 ArmyAnt
    dw $001f, $7fff, $02fd, $0000, $0118, $7fff, $02fd, $0000 ; id 186 GoHopper
    dw $3858, $7fff, $3e76, $0000, $3858, $7fff, $7e6e, $0000 ; id 187 TailEater
    dw $0416, $7fff, $019f, $0000, $4c0d, $7fff, $019f, $0000 ; id 188 ArmorPede
    dw $5c6f, $7fff, $02ff, $0000, $5c6f, $7fff, $00ff, $0000 ; id 189 Eyeder
    dw $0152, $7fff, $027e, $0000, $001a, $7fff, $027e, $0000 ; id 190 GiantMoth
    dw $141f, $7fff, $519d, $0000, $00cd, $7fff, $401f, $0000 ; id 191 Droll
    dw $0018, $7fff, $01de, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 192 ArmyCrab
    dw $0411, $7fff, $02bf, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 193 MadHornet
    dw $381c, $7fff, $023f, $0000, $381c, $7fff, $49ce, $0000 ; id 194 Belzebub
    dw $0208, $7fff, $71b3, $0000, $0208, $7fff, $0974, $0000 ; id 195 WarMantis
    dw $00af, $7fff, $019b, $0000, $00af, $7fff, $0218, $0000 ; id 196 HornBeet
    dw $318c, $7fff, $2be0, $0000, $001f, $7fff, $2bea, $0000 ; id 197 Sickler
    dw $015b, $7fff, $02bf, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 198 Armorpion
    dw $000c, $7fff, $04bd, $0000, $600b, $7fff, $04bd, $0000 ; id 199 Digster
    dw $2012, $7fff, $541f, $0000, $280c, $7fff, $4912, $0000 ; id 200 Skularach
    dw $0091, $7fff, $017d, $0000, $4010, $7fff, $017d, $0000 ; id 201 MultiEyes
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 202 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 203 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 204 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 205 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 206 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 207 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 208 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 209 ?
    dw $0018, $7fff, $0371, $0000, $00cf, $7fff, $021b, $0000 ; id 210 ?
    dw $5c00, $7fff, $7dc0, $0000, $0012, $7fff, $7dc0, $0000 ; id 211 Pixy
    dw $025f, $7fff, $7a00, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 212 MedusaEye
    dw $58e3, $7fff, $7ee7, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 213 AgDevil
    dw $3478, $7fff, $023f, $0000, $3478, $7fff, $04f0, $0000 ; id 214 Demonite
    dw $6d60, $7fff, $7d57, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 215 DarkEye
    dw $6940, $7fff, $7ea4, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 216 EyeBall
    dw $6d60, $7fff, $029f, $0000, $640e, $7fff, $029f, $0000 ; id 217 SkulRider
    dw $4571, $7fff, $6a18, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 218 EvilBeast
    dw $0160, $7fff, $170e, $0000, $04f0, $7fff, $170e, $0000 ; id 219 Bubblemon
    dw $009b, $7fff, $027f, $0000, $009b, $7fff, $7dc0, $0000 ; id 220 1EyeClown
    dw $3835, $7fff, $71bc, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 221 Gremlin
    dw $01c3, $7fff, $64b9, $0000, $002b, $7fff, $64b9, $0000 ; id 222 ArcDemon
    dw $5c70, $7fff, $023c, $0000, $5c70, $7fff, $4a33, $0000 ; id 223 Lionex
    dw $0011, $7fff, $011c, $0000, $5160, $7fff, $011c, $0000 ; id 224 GoatHorn
    dw $0132, $7fff, $025d, $0000, $0132, $7fff, $0268, $0000 ; id 225 Orc
    dw $58c0, $7fff, $0f68, $0000, $34c0, $7fff, $3d8f, $0000 ; id 226 Ogre
    dw $406d, $7fff, $5917, $0000, $280a, $7fff, $3d8f, $0000 ; id 227 GateGuard
    dw $58b9, $7fff, $7d8e, $0000, $54c0, $7fff, $7d8e, $0000 ; id 228 ChopClown
    dw $402f, $7fff, $032b, $0000, $0152, $7fff, $032b, $0000 ; id 229 BossTroll
    dw $30ac, $7fff, $7ea0, $0000, $1895, $7fff, $027f, $0000 ; id 230 Grendal
    dw $00bb, $7fff, $029f, $0000, $00af, $7fff, $029f, $0000 ; id 231 Akubar
    dw $3123, $7fff, $7e4f, $0000, $3123, $7fff, $7d79, $0000 ; id 232 MadKnight
    dw $001b, $7fff, $0259, $0000, $001b, $7fff, $3a08, $0000 ; id 233 EvilWell
    dw $6580, $7fff, $7720, $0000, $00d1, $7fff, $7720, $0000 ; id 234 Gigantes
    dw $6960, $7fff, $7720, $0000, $6960, $7fff, $023f, $0000 ; id 235 Centasaur
    dw $41e7, $7fff, $001a, $0000, $41e7, $7fff, $021c, $0000 ; id 236 EvilArmor
    dw $2d11, $7fff, $027f, $0000, $3123, $7fff, $5a53, $0000 ; id 237 Jamirus
    dw $5811, $7fff, $01df, $0000, $5811, $7fff, $5254, $0000 ; id 238 Durran
    dw $1c0c, $7fff, $4692, $0000, $4ce3, $7fff, $00af, $0000 ; id 239 Titanis
    dw $748f, $7fff, $01bf, $0000, $1103, $7fff, $320c, $0000 ; id 240 LampGenie
    dw $5c00, $7fff, $7dc0, $0000, $0012, $7fff, $7dc0, $0000 ; id 241 ?
    dw $5c00, $7fff, $7dc0, $0000, $0012, $7fff, $7dc0, $0000 ; id 242 ?
    dw $5c00, $7fff, $7dc0, $0000, $0012, $7fff, $7dc0, $0000 ; id 243 ?
    dw $5c00, $7fff, $7dc0, $0000, $0012, $7fff, $7dc0, $0000 ; id 244 ?
    dw $5c00, $7fff, $7dc0, $0000, $0012, $7fff, $7dc0, $0000 ; id 245 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 246 Spooky
    dw $218e, $7fff, $3296, $0000, $218e, $7fff, $027f, $0000 ; id 247 Skullgon
    dw $600c, $7fff, $7a20, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 248 PutrePup
    dw $240c, $7fff, $7476, $0000, $240c, $7fff, $7e0f, $0000 ; id 249 RotRaven
    dw $306f, $7fff, $7d5a, $0000, $5ccc, $7fff, $7d5a, $0000 ; id 250 Mummy
    dw $4006, $7fff, $692f, $0000, $4006, $7fff, $2c1f, $0000 ; id 251 DarkCrab
    dw $440d, $7fff, $0196, $0000, $0070, $7fff, $0196, $0000 ; id 252 DeadNite
    dw $420b, $7fff, $033f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 253 Shadow
    dw $601a, $7fff, $2e75, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 254 Skulpent
    dw $0070, $7fff, $0196, $0000, $0070, $7fff, $7610, $0000 ; id 255 Hork
    dw $4414, $7fff, $02df, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 256 Mudron
    dw $0199, $7fff, $7e80, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 257 NiteWhip
    dw $6140, $7fff, $7f46, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 258 WindMerge
    dw $00dc, $7fff, $02bf, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 259 Reaper
    dw $5a28, $7fff, $1dd3, $0000, $5a28, $7fff, $037f, $0000 ; id 260 Inverzon
    dw $7d00, $7fff, $7eec, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 261 FoxFire
    dw $001d, $7fff, $528f, $0000, $02bc, $7fff, $528f, $0000 ; id 262 CaptDead
    dw $2058, $7fff, $7de8, $0000, $30ed, $7fff, $7de8, $0000 ; id 263 DeadNoble
    dw $080f, $7fff, $3c7f, $0000, $280a, $7fff, $02ed, $0000 ; id 264 WhiteKing
    dw $3d04, $7fff, $151f, $0000, $00ed, $7fff, $01fd, $0000 ; id 265 BoneSlave
    dw $2c2e, $7fff, $6917, $0000, $10a9, $7fff, $5235, $0000 ; id 266 Skeletor
    dw $24ae, $7fff, $4190, $0000, $24ae, $7fff, $01fd, $0000 ; id 267 Servant
    dw $0016, $7fff, $02bf, $0000, $150b, $7fff, $51d4, $0000 ; id 268 Lazamanus
    dw $75a0, $7fff, $035f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 269 Copycat
    dw $380f, $7fff, $6939, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 270 MadSpirit
    dw $1012, $7fff, $501f, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 271 PomPomBom
    dw $7c2e, $7fff, $3c1d, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 272 Niterich
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 273 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 274 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 275 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 276 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 277 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 278 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 279 ?
    dw $5815, $7fff, $011e, $0000, $00bb, $7fff, $023f, $0000 ; id 280 ?
    dw $0c16, $7fff, $031f, $0000, $40b3, $7fff, $75a0, $1060 ; id 281 JewelBag
    dw $00ef, $7fff, $021a, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 282 EvilWand
    dw $021f, $7fff, $7f0a, $0000, $001a, $7fff, $7f0a, $0000 ; id 283 MadCandle
    dw $5589, $7fff, $02ff, $0000, $340a, $7fff, $7dd9, $0000 ; id 284 CoilBird
    dw $190f, $7fff, $031f, $0000, $190f, $7fff, $7ce1, $0000 ; id 285 Facer
    dw $0244, $7fff, $036d, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 286 SpikyBoy
    dw $1417, $7fff, $035f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 287 MadMirror
    dw $5033, $7fff, $7e24, $0000, $5033, $7fff, $021a, $0000 ; id 288 RogueNite
    dw $0160, $7fff, $170e, $0000, $015b, $7fff, $033d, $0000 ; id 289 Puppetor
    dw $0153, $7fff, $025c, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 290 Goopi
    dw $240c, $7fff, $5815, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 291 Voodoll
    dw $71c9, $7fff, $7f54, $0000, $06a0, $7fff, $7f54, $0000 ; id 292 MetalDrak
    dw $7129, $7fff, $7ec4, $0000, $38ed, $7fff, $7ec4, $0000 ; id 293 Balzak
    dw $02df, $7fff, $7f0b, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 294 SabreMan
    dw $00fa, $7fff, $02bf, $0000, $38f4, $7fff, $02bf, $0000 ; id 295 CurseLamp
    dw $0160, $7fff, $170e, $0000, $0160, $7fff, $021f, $0000 ; id 296 Brushead
    dw $64c6, $7fff, $7ec5, $0000, $2d10, $7fff, $7ec5, $0000 ; id 297 Roboster
    dw $7dc0, $7fff, $031e, $0000, $2107, $7fff, $02f8, $0000 ; id 298 Roboster2
    dw $0153, $7fff, $025c, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 299 EvilPot
    dw $4dcd, $7fff, $62d4, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 300 Gismo
    dw $0018, $7fff, $025f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 301 LavaMan
    dw $029e, $7fff, $7e09, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 302 IceMan
    dw $3926, $7fff, $59ec, $0000, $5c53, $7fff, $59ec, $0000 ; id 303 Mimic
    dw $486a, $7fff, $7eec, $0000, $0175, $7fff, $7eec, $0000 ; id 304 Exaucers
    dw $00ef, $7fff, $021a, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 305 MudDoll
    dw $00d3, $7fff, $025b, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 306 Golem
    dw $25ce, $7fff, $4ab5, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 307 StoneMan
    dw $6186, $7fff, $726c, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 308 BombCrag
    dw $4ccf, $7fff, $061f, $0000, $1017, $7fff, $061f, $0000 ; id 309 GoldGolem
    dw $2836, $7fff, $7969, $0000, $2108, $7fff, $7969, $0000 ; id 310 DarkMate
    dw $7d00, $7fff, $24db, $0000, $7d00, $7fff, $360d, $0000 ; id 311 ProtoMech
    dw $7c20, $7fff, $7e87, $0000, $24d3, $7fff, $7e87, $0000 ; id 312 CloudKing
    dw $0c16, $7fff, $031f, $0000, $40b3, $7fff, $75a0, $1060 ; id 313 ?
    dw $0c16, $7fff, $031f, $0000, $40b3, $7fff, $75a0, $1060 ; id 314 ?
    dw $0c16, $7fff, $031f, $0000, $40b3, $7fff, $75a0, $1060 ; id 315 ?
    dw $4051, $7fff, $6d5b, $0000, $4051, $7fff, $3a75, $0000 ; id 316 Petiteel
    dw $50d2, $7fff, $027f, $0000, $7ca3, $7fff, $027f, $0000 ; id 317 Moray
    dw $1592, $7fff, $169f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 318 WalrusMan
    dw $1c1a, $7fff, $01fd, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 319 RayGigas
    dw $0071, $7fff, $0d7a, $0000, $1b2e, $7fff, $0e5f, $0000 ; id 320 Anemon
    dw $488c, $7fff, $7eec, $0000, $4051, $7fff, $6d5b, $0000 ; id 321 Aquarella
    dw $4d67, $7fff, $7230, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 322 Merman
    dw $212a, $7fff, $493f, $0000, $05b0, $7fff, $493f, $0000 ; id 323 Octokid
    dw $24d3, $7fff, $0619, $0000, $7c20, $7fff, $7e80, $0000 ; id 324 PutreFish
    dw $4d67, $7fff, $7230, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 325 Octoreach
    dw $008e, $7fff, $3152, $0000, $008e, $7fff, $7e54, $0000 ; id 326 Angleron
    dw $4826, $7fff, $7eec, $0000, $4826, $7fff, $751a, $0000 ; id 327 FishRider
    dw $60a3, $7fff, $7dec, $0000, $60a3, $7fff, $42b9, $0000 ; id 328 RushFish
    dw $0010, $7fff, $009f, $0000, $150c, $7fff, $023f, $0000 ; id 329 Gamanian
    dw $08d2, $7fff, $023b, $0000, $009f, $7fff, $023b, $0000 ; id 330 Clawster
    dw $00bf, $7fff, $1e7f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 331 CancerMan
    dw $4d67, $7fff, $7230, $0000, $001f, $7fff, $7230, $0000 ; id 332 RogueWave
    dw $306f, $7fff, $0258, $0000, $306f, $7fff, $7d5a, $0000 ; id 333 Scallopa
    dw $68f6, $7fff, $3a1d, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 334 SeaHorse
    dw $281b, $7fff, $7210, $0000, $281b, $7fff, $759a, $0000 ; id 335 HoodSquid
    dw $00f4, $7fff, $023c, $0000, $2da1, $7fff, $023c, $0000 ; id 336 MerTiger
    dw $7d00, $7fff, $7eec, $0000, $0018, $7fff, $023f, $0000 ; id 337 AxeShark
    dw $5904, $7fff, $7dcd, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 338 Octogon
    dw $306f, $7fff, $7d5a, $0000, $5ccc, $7fff, $7d5a, $0000 ; id 339 KingSquid
    dw $0011, $7fff, $011f, $0000, $0011, $7fff, $45f2, $0000 ; id 340 Digong
    dw $4c8b, $7fff, $39d0, $0000, $4c8b, $7fff, $0050, $0000 ; id 341 WhaleMage
    dw $4104, $7fff, $69ee, $0000, $0250, $7fff, $69ee, $0000 ; id 342 Aquadon
    dw $0035, $7fff, $017f, $0000, $2d2c, $7fff, $017f, $0000 ; id 343 Octoraid
    dw $0140, $7fff, $0369, $0000, $0091, $7fff, $0369, $0000 ; id 344 Grakos
    dw $2dc1, $7fff, $5b21, $0000, $2dc1, $7fff, $6598, $0000 ; id 345 Poseidon
    dw $0240, $7fff, $6ab2, $0000, $501f, $7fff, $6ab2, $0000 ; id 346 Pumpoise
    dw $1854, $7fff, $56a0, $0000, $7fe0, $7fe0, $7fe0, $7fe0 ; id 347 Starfish
    dw $4051, $7fff, $6d5b, $0000, $4051, $7fff, $3a75, $0000 ; id 348 ?
    dw $4051, $7fff, $6d5b, $0000, $4051, $7fff, $3a75, $0000 ; id 349 ?
    dw $4051, $7fff, $6d5b, $0000, $4051, $7fff, $3a75, $0000 ; id 350 ?
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 351 DracoLord
    dw $3c64, $7fff, $6c73, $0000, $000f, $7fff, $0419, $0000 ; id 352 DracoLord
    dw $4013, $7fff, $001f, $0000, $4013, $7fff, $653b, $0000 ; id 353 LordDraco
    dw $0056, $7fff, $7e0c, $0000, $0056, $7fff, $7d9f, $0000 ; id 354 Hargon
    dw $0053, $7fff, $7e20, $0000, $3c64, $7fff, $7e20, $0000 ; id 355 Sidoh
    dw $58aa, $7fff, $51d4, $0000, $58aa, $7fff, $015a, $0000 ; id 356 Genosidoh
    dw $0ced, $7fff, $0211, $0000, $0ced, $7fff, $6939, $0000 ; id 357 Baramos
    dw $0058, $7fff, $029f, $0000, $340e, $7fff, $7e0c, $0000 ; id 358 Zoma
    dw $75a0, $7fff, $1b6b, $0000, $0c17, $7fff, $4295, $0000 ; id 359 AsuraZoma
    dw $0145, $7fff, $0e71, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 360 Pizzaro
    dw $24cb, $7fff, $60dd, $0000, $24cb, $7fff, $2708, $0000 ; id 361 PsychoPiz
    dw $00f3, $7fff, $02df, $0000, $00f3, $7fff, $009f, $0000 ; id 362 Esterk
    dw $2c53, $7fff, $0310, $0000, $44ca, $7fff, $7e0c, $0000 ; id 363 Mirudraas
    dw $0414, $7fff, $493f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 364 Mirudraas
    dw $0091, $7fff, $02e0, $0000, $0091, $7fff, $2e36, $0000 ; id 365 Mudou
    dw $2431, $7fff, $0307, $0000, $2431, $7fff, $493f, $0000 ; id 366 DeathMore
    dw $0414, $7fff, $493f, $0000, $7c1f, $7c1f, $7c1f, $7c1f ; id 367 DeathMore
    dw $1015, $7fff, $7539, $0000, $44c8, $7fff, $7539, $0000 ; id 368 DeathMore
    dw $008e, $7fff, $3152, $0000, $008e, $7fff, $7e54, $0000 ; id 369 Darkdrium
    dw $480d, $7fff, $4250, $0000, $480d, $7fff, $0952, $0000 ; id 370 Orgodemir
    dw $05a3, $7fff, $46ca, $0000, $38e8, $7fff, $2a16, $0000 ; id 371 Orgodemir
    dw $00b1, $7fff, $021f, $0000, $3410, $7fff, $1640, $0000 ; id 372 Darck
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 373 Tatsu
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 374 Diago
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 375 Samsi
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 376 Bazoo
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 377 ?
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 378 ?
    dw $3c64, $7fff, $4414, $0000, $000f, $7fff, $4414, $0000 ; id 379 ?
    dw $183e, $7fff, $037f, $0000, $2aa0, $7fff, $5a6d, $0000 ; id 380 Lamia
    dw $4c6d, $7fff, $6e30, $0000, $4c6d, $7fff, $6f50, $0000 ; id 381 Dimensaur
    dw $09f2, $7fff, $331f, $0000, $0137, $7fff, $021f, $0000 ; id 382 Kagebou

; 6 x 6 CGB attribute map of the picture of monster id $003 (WingSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WingSlime::
    ds $13, $00
    db $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $004 (TreeSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_TreeSlime::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $005 (Snaily) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Snaily::
    ds $14, $00
    db $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $006 (SlimeNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_SlimeNite::
    ds $15, $00
    db $01, $01, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $009 (PearlGel) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_PearlGel::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $00C (FangSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FangSlime::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $00E (SlimeBorg) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_SlimeBorg::
    ds $15, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $010 (KingSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_KingSlime::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $013 (SpotKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_SpotKing::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $014 (TropicGel) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_TropicGel::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $015 (MimeSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MimeSlime::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    db $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $016 (HaloSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_HaloSlime::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $017 (MetalKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MetalKing::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $018 (GoldSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GoldSlime::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $019 (GranSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GranSlime::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $01A (WonderEgg) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WonderEgg::
    ds $1b, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $024 (DragonKid) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DragonKid::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $01, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $025 (Tortragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Tortragon::
    ds $14, $00
    db $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $026 (Pteranod) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Pteranod::
    ds $13, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $028 (FairyDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FairyDrak::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $029 (LizardMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_LizardMan::
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $02A (Poisongon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Poisongon::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $02B (Swordgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Swordgon::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $02D (Dragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Dragon::
    ds $13, $00
    db $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $00, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $02E (MiniDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MiniDrak::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $02F (MadDragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadDragon::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $030 (Rayburn) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Rayburn::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $15, $00

; 6 x 6 CGB attribute map of the picture of monster id $033 (Andreal) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Andreal::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $1b, $00

; 6 x 6 CGB attribute map of the picture of monster id $035 (Vampirus) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Vampirus::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $036 (SnakeBat) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_SnakeBat::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $037 (Spikerous) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Spikerous::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $039 (Crestpent) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Crestpent::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $03A (WingSnake) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WingSnake::
    db $01, $01, $00, $00, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01
    db $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $03B (Coatol) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Coatol::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $03C (Orochi) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Orochi::
    db $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $01, $01, $00, $00
    db $01, $01, $01, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $03D (BattleRex) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BattleRex::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $01, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $03F (Serpentia) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Serpentia::
    db $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
    ds $12, $01

; 6 x 6 CGB attribute map of the picture of monster id $040 (Divinegon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Divinegon::
    ds $18, $00
    db $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $041 (Orligon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Orligon::
    ds $12, $00
    db $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $00, $01, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $042 (GigaDraco) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GigaDraco::
    ds $14, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $047 (Tonguella) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Tonguella::
    ds $14, $00
    db $01, $00, $00, $00, $00, $00, $01
    ds $17, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04A (PillowRat) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_PillowRat::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04B (Saccer) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Saccer::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $04C (GulpBeast) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GulpBeast::
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04D (Skullroo) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Skullroo::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04F (Beavern) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Beavern::
    db $00, $01, $01, $01, $00, $00, $00, $00, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $050 (Antbear) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Antbear::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01
    db $01, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $051 (SuperTen) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_SuperTen::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $052 (IronTurt) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_IronTurt::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $00, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $054 (HammerMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_HammerMan::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $056 (Yeti) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Yeti::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $057 (ArrowDog) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ArrowDog::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $01, $01, $00, $00
    db $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $058 (NoctoKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_NoctoKing::
    db $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $059 (BeastNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BeastNite::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $05B (FairyRat) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FairyRat::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $05C (Unicorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Unicorn::
    db $01, $00, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $00, $00
    db $00, $01, $00, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $05D (Goategon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Goategon::
    ds $1f, $00
    db $01, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $061 (DarkHorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DarkHorn::
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $062 (MadCat) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadCat::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $01, $01
    db $01, $00, $01, $01, $01, $01, $01, $00, $01, $00, $01, $01, $00, $00, $01, $01
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $063 (BigEye) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BigEye::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $064 (Gorago) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Gorago::
    ds $1f, $00
    db $01, $01, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $065 (CatMage) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CatMage::
    ds $15, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $066 (Dumbira) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Dumbira::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $06A (Picky) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Picky::
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $06B (Wyvern) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Wyvern::
    db $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01
    db $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $06C (BullBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BullBird::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $01
    ds $11, $00

; 6 x 6 CGB attribute map of the picture of monster id $06D (Florajay) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Florajay::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $01, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $06E (DuckKite) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DuckKite::
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $06F (MadPecker) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadPecker::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01
    db $00, $00, $00, $01, $01, $00, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $070 (MadRaven) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadRaven::
    ds $1a, $00
    db $01, $01, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $072 (AquaHawk) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_AquaHawk::
    db $00, $00, $01, $01, $01, $01, $00, $01, $01, $00, $01, $00, $01, $01, $00, $00
    db $01, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $074 (KiteHawk) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_KiteHawk::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $075 (BigRoost) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BigRoost::
    db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $01, $01, $00, $00
    db $00, $00, $00, $01, $00, $00, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $076 (StubBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_StubBird::
    ds $1c, $00
    db $01, $00, $00, $00, $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $078 (MadGoose) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadGoose::
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $00
    db $01, $01, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $079 (MadCondor) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadCondor::
    ds $12, $00
    db $01, $00, $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $07A (Emyu) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Emyu::
    ds $13, $00
    db $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $07B (Blizzardy) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Blizzardy::
    db $00, $00, $00, $00, $00, $00, $00, $01
    ds $1c, $00

; 6 x 6 CGB attribute map of the picture of monster id $07D (ZapBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ZapBird::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $01, $00
    db $00, $00, $01, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $07E (Garudian) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Garudian::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $07F (WhipBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WhipBird::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
    db $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $00, $00, $01, $01, $00, $01
    db $00, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $080 (FunkyBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FunkyBird::
    ds $1f, $00
    db $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $081 (RainHawk) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_RainHawk::
    db $01, $00, $01, $00, $01, $00, $00, $01, $01, $01, $00, $01
    ds $13, $00
    db $01, $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $082 (Azurile) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Azurile::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $00, $00, $01, $00
    db $00, $01, $00, $01, $01, $00, $00, $00, $01, $01, $00, $01, $01, $00, $00, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $083 (Shantak) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Shantak::
    ds $13, $00
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $084 (CragDevil) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CragDevil::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $08D (MadPlant) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadPlant::
    ds $10, $00
    db $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $08E (FireWeed) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FireWeed::
    ds $10, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $08F (FloraMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FloraMan::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $090 (WingTree) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WingTree::
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00
    db $01, $01
    ds $12, $00

; 6 x 6 CGB attribute map of the picture of monster id $091 (CactiBall) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CactiBall::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1a, $00

; 6 x 6 CGB attribute map of the picture of monster id $092 (Gulpple) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Gulpple::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $093 (Toadstool) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Toadstool::
    ds $14, $00
    db $01, $01, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $094 (AmberWeed) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_AmberWeed::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $01, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $095 (Slurperon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Slurperon::
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $096 (Stubsuck) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Stubsuck::
    ds $12, $00
    db $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $097 (Oniono) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Oniono::
    ds $14, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $098 (DanceVegi) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DanceVegi::
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01
    ds $16, $00

; 6 x 6 CGB attribute map of the picture of monster id $099 (TreeBoy) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_TreeBoy::
    db $00, $00, $00, $00, $01, $01
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $09A (Devipine) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Devipine::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01
    db $00, $00, $00, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $09B (FaceTree) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FaceTree::
    db $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00, $01, $00, $00
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $09C (HerbMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_HerbMan::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $09D (BeanMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BeanMan::
    ds $14, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $09E (EvilSeed) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_EvilSeed::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $00, $01, $01, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $09F (ManEater) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ManEater::
    db $00, $00, $01, $00, $00, $00, $01, $00, $01, $00, $01, $01, $01, $01, $00, $00
    db $00, $01, $00, $00, $00, $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0A0 (Snapper) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Snapper::
    ds $18, $00
    db $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A1 (GhosTree) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GhosTree::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A2 (Rosevine) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Rosevine::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A3 (Egdracil) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Egdracil::
    db $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A4 (Warubou) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Warubou::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A7 (FooHero) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FooHero::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B0 (GiantSlug) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GiantSlug::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $00, $01, $01, $01, $00, $01, $00, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0B1 (Catapila) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Catapila::
    ds $17, $00
    db $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B3 (Butterfly) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Butterfly::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B4 (WeedBug) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WeedBug::
    db $00, $00, $01, $01
    ds $1b, $00
    db $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B6 (Lipsy) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Lipsy::
    ds $13, $00
    db $01, $01, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01, $01, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $0B7 (StagBug) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_StagBug::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B8 (Pyuro) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Pyuro::
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BA (GoHopper) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GoHopper::
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BB (TailEater) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_TailEater::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BC (ArmorPede) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ArmorPede::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BD (Eyeder) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Eyeder::
    ds $13, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $0BE (GiantMoth) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GiantMoth::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BF (Droll) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Droll::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C2 (Belzebub) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Belzebub::
    ds $12, $00
    db $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C3 (WarMantis) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WarMantis::
    db $00, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C4 (HornBeet) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_HornBeet::
    db $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $00, $01, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C5 (Sickler) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Sickler::
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C7 (Digster) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Digster::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C8 (Skularach) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Skularach::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0C9 (MultiEyes) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MultiEyes::
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01
    ds $19, $00

; 6 x 6 CGB attribute map of the picture of monster id $0D3 (Pixy) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Pixy::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0D6 (Demonite) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Demonite::
    ds $13, $00
    db $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $0D9 (SkulRider) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_SkulRider::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DB (Bubblemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Bubblemon::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01
    db $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DC (1EyeClown) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_1EyeClown::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DE (ArcDemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ArcDemon::
    db $00, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $01, $01, $00, $00, $00, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DF (Lionex) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Lionex::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E0 (GoatHorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GoatHorn::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01

; 6 x 6 CGB attribute map of the picture of monster id $0E1 (Orc) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Orc::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E2 (Ogre) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Ogre::
    ds $10, $00
    db $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E3 (GateGuard) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GateGuard::
    db $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E4 (ChopClown) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ChopClown::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
    db $01, $00, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E5 (BossTroll) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BossTroll::
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01
    ds $17, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E6 (Grendal) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Grendal::
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $01, $01, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E7 (Akubar) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Akubar::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E8 (MadKnight) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadKnight::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0E9 (EvilWell) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_EvilWell::
    ds $19, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EA (Gigantes) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Gigantes::
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EB (Centasaur) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Centasaur::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EC (EvilArmor) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_EvilArmor::
    db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $01, $01, $00, $00
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0ED (Jamirus) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Jamirus::
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $01, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EE (Durran) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Durran::
    db $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $01, $00, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EF (Titanis) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Titanis::
    ds $14, $00
    db $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0F0 (LampGenie) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_LampGenie::
    ds $12, $00
    ds $12, $01

; 6 x 6 CGB attribute map of the picture of monster id $0F6 (Spooky) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Spooky::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0F7 (Skullgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Skullgon::
    db $00, $00, $01, $01
    ds $20, $00

; 6 x 6 CGB attribute map of the picture of monster id $0F9 (RotRaven) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_RotRaven::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FA (Mummy) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Mummy::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FB (DarkCrab) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DarkCrab::
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FC (DeadNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DeadNite::
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FF (Hork) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Hork::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $104 (Inverzon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Inverzon::
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $106 (CaptDead) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CaptDead::
    ds $13, $00
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01

; 6 x 6 CGB attribute map of the picture of monster id $107 (DeadNoble) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DeadNoble::
    ds $13, $00
    db $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $108 (WhiteKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WhiteKing::
    ds $10, $00
    db $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $109 (BoneSlave) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_BoneSlave::
    db $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $01, $00, $01, $01, $01, $01, $01, $00, $01, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $10A (Skeletor) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Skeletor::
    ds $14, $00
    db $01, $01, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $10B (Servant) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Servant::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $10C (Lazamanus) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Lazamanus::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $01, $01, $01, $01
    db $00, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $10F (PomPomBom) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_PomBom::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $119 (JewelBag) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_JewelBag::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $11B (MadCandle) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MadCandle::
    ds $13, $00
    db $01, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $11C (CoilBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CoilBird::
    db $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $11D (Facer) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Facer::
    ds $13, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $120 (RogueNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_RogueNite::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $121 (Puppetor) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Puppetor::
    ds $19, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $124 (MetalDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MetalDrak::
    ds $16, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $125 (Balzak) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Balzak::
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $127 (CurseLamp) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CurseLamp::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $128 (Brushead) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Brushead::
    db $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $01, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $01, $01, $01, $00, $00, $00
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $129 (Roboster) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Roboster::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $12A (Roboster2) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Roboster2::
    db $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $12F (Mimic) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Mimic::
    ds $15, $00
    db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $130 (Exaucers) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Exaucers::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $135 (GoldGolem) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_GoldGolem::
    db $00, $01, $01, $01, $00, $00, $01, $01, $01
    ds $1b, $00

; 6 x 6 CGB attribute map of the picture of monster id $136 (DarkMate) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DarkMate::
    db $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $137 (ProtoMech) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_ProtoMech::
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $01, $01, $01, $00, $00
    db $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $138 (CloudKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_CloudKing::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $13C (Petiteel) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Petiteel::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $13D (Moray) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Moray::
    ds $19, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $140 (Anemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Anemon::
    db $00, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $141 (Aquarella) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Aquarella::
    ds $1b, $00
    db $01, $01, $00, $01, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $143 (Octokid) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Octokid::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $00, $00
    db $01, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00, $00
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $144 (PutreFish) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_PutreFish::
    ds $1a, $00
    db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $146 (Angleron) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Angleron::
    ds $10, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $147 (FishRider) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_FishRider::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $148 (RushFish) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_RushFish::
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $00
    db $00, $00, $01, $01, $01, $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $149 (Gamanian) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Gamanian::
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $01, $00, $00
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $14A (Clawster) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Clawster::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $15, $00

; 6 x 6 CGB attribute map of the picture of monster id $14C (RogueWave) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_RogueWave::
    ds $1a, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $14D (Scallopa) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Scallopa::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $14F (HoodSquid) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_HoodSquid::
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01
    ds $11, $00

; 6 x 6 CGB attribute map of the picture of monster id $150 (MerTiger) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_MerTiger::
    ds $12, $00
    db $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $00, $00, $01, $01
    db $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $151 (AxeShark) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_AxeShark::
    ds $18, $00
    db $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $153 (KingSquid) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_KingSquid::
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $154 (Digong) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Digong::
    ds $12, $00
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $155 (WhaleMage) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_WhaleMage::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $156 (Aquadon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Aquadon::
    db $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $01, $01
    ds $18, $00

; 6 x 6 CGB attribute map of the picture of monster id $157 (Octoraid) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Octoraid::
    db $01, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $01, $01, $01
    db $01, $01, $00, $01, $01, $01, $01, $01, $00, $01, $00, $00, $01, $00, $01, $00
    db $00, $00, $00, $01

; 6 x 6 CGB attribute map of the picture of monster id $158 (Grakos) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Grakos::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $01
    db $00, $00, $00, $01, $01, $01, $00, $00, $01, $00, $00, $01, $01, $00, $01, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $159 (Poseidon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Poseidon::
    db $00, $01, $00, $00, $01, $00, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $15A (Pumpoise) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Pumpoise::
    ds $13, $00
    db $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $15F (DracoLord) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DracoLord::
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01
    db $00, $00, $01, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $160 (DracoLord) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DracoLord_160::
    db $01, $01, $00, $00, $01, $00, $00, $01, $01
    ds $1b, $00

; 6 x 6 CGB attribute map of the picture of monster id $161 (LordDraco) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_LordDraco::
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $162 (Hargon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Hargon::
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $164 (Genosidoh) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Genosidoh::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $165 (Baramos) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Baramos::
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $01, $00, $00, $01, $00, $01
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $166 (Zoma) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Zoma::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $167 (AsuraZoma) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_AsuraZoma::
    ds $13, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $169 (PsychoPiz) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_PsychoPiz::
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $01, $01, $00, $01, $00, $00, $01, $01, $00, $01, $01, $00, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $16A (Esterk) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Esterk::
    db $00, $01, $01, $01, $01
    ds $1f, $00

; 6 x 6 CGB attribute map of the picture of monster id $16B (Mirudraas) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Mirudraas::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01
    db $00, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $16D (Mudou) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Mudou::
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $01, $00, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $01, $01, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $16E (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DeathMore::
    db $00, $01, $01, $00, $00, $00, $01, $01, $01, $00, $01, $00, $01, $01, $01, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $170 (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_DeathMore_170::
    db $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $171 (Darkdrium) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Darkdrium::
    db $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $172 (Orgodemir) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Orgodemir::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $173 (Orgodemir) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Orgodemir_173::
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $174 (Darck) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Darck::
    db $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $00, $00, $00, $01, $01, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $00, $00, $01

; 6 x 6 CGB attribute map of the picture of monster id $17C (Lamia) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Lamia::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $17D (Dimensaur) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Dimensaur::
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01
    db $00, $01, $01, $00, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $17E (Kagebou) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPicAttr_Kagebou::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01
    ds $508, $00
