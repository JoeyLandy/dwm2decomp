SECTION "Bank 7B", ROMX[$4000], BANK[$7B]
    db $7B

; compressed 6 x 6 picture (36 tiles) of monster id $17D (Dimensaur) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPic_Dimensaur:: ; heuristic: monster picture stream; C0
Data_07B_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EC001, $208

; E-0041 (C1: Func_000_1FE3 copies 16 bytes from bank $7B, $4209 + 16 * monster id to the palette buffer wC49F on CGB; the count matches the picture table).
; record: CGB colours of the monster picture (two 4-colour palettes, BGR555 words)
MonsterPaletteTable::
Data_07B_4209:: ; heuristic: start of a structured table; C0
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 0
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 1 DrakSlime
    dw $01DA, $7FFF, $035F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 2 SpotSlime
    dw $35E0, $7FFF, $4BA0, $0000, $00FC, $7FFF, $4BA0, $0000 ; id 3 WingSlime
    dw $000F, $7FFF, $78B4, $0000, $2200, $7FFF, $035F, $0000 ; id 4 TreeSlime
    dw $0224, $7FFF, $03D0, $0000, $0110, $7FFF, $025F, $0000 ; id 5 Snaily
    dw $7D00, $7FFF, $4A92, $0000, $0C5A, $7FFF, $1B40, $0000 ; id 6 SlimeNite
    dw $25A0, $7FFF, $1BE5, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 7 Babble
    dw $000D, $7FFF, $0C1F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 8 BoxSlime
    dw $2DAF, $7FFF, $431B, $0000, $31AB, $7FFF, $6F40, $0000 ; id 9 PearlGel
    dw $5C0F, $7FFF, $7EA0, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 10 Slime
    dw $7CE1, $7FFF, $023F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 11 Healer
    dw $4D21, $7FFF, $023F, $0000, $4D21, $7FFF, $76A0, $0000 ; id 12 FangSlime
    dw $00EF, $7FFF, $15FC, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 13 RockSlime
    dw $18E6, $7FFF, $31AC, $0000, $4CA8, $7FFF, $4631, $0000 ; id 14 SlimeBorg
    dw $0011, $7FFF, $311F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 15 Slabbit
    dw $74E4, $7FFF, $7E42, $0000, $2AA3, $7FFF, $24BF, $0000 ; id 16 KingSlime
    dw $2549, $7FFF, $4A51, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 17 Metaly
    dw $2549, $7FFF, $4A51, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 18 Metabble
    dw $019A, $7FFF, $035F, $0000, $0380, $7FFF, $001F, $0000 ; id 19 SpotKing
    dw $014D, $7FFF, $0235, $0000, $0220, $7FFF, $027F, $0000 ; id 20 TropicGel
    dw $4472, $7FFF, $02BF, $0000, $001F, $7FFF, $02BF, $0000 ; id 21 MimeSlime
    dw $2CDC, $7FFF, $65DF, $0000, $2CDC, $7FFF, $7FCF, $0000 ; id 22 HaloSlime
    dw $2549, $7FFF, $4A51, $0000, $74E4, $7FFF, $209F, $0000 ; id 23 MetalKing
    dw $017D, $7FFF, $02FF, $0000, $7EC0, $7FFF, $02FF, $0000 ; id 24 GoldSlime
    dw $0240, $7FFF, $6AB2, $0000, $181C, $7FFF, $6AB2, $0000 ; id 25 GranSlime
    dw $010C, $7FFF, $22DE, $0000, $010C, $7FFF, $22DE, $0000 ; id 26 WonderEgg
    dw $01DA, $7FFF, $035F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 27 Butch
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 28 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 29 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 30 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 31 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 32 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 33 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 34 ?
    dw $0191, $7FFF, $029F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 35 ?
    dw $01DE, $7FFF, $037F, $0000, $7C1F, $7FFF, $037F, $0000 ; id 36 DragonKid
    dw $0155, $7FFF, $7E80, $0000, $0155, $7FFF, $4633, $0000 ; id 37 Tortragon
    dw $55CA, $7FFF, $7371, $0000, $55CA, $7FFF, $03FF, $0000 ; id 38 Pteranod
    dw $1C37, $7FFF, $029F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 39 Gasgon
    dw $2C11, $7FFF, $209D, $0000, $2C11, $7FFF, $67C0, $0000 ; id 40 FairyDrak
    dw $6D48, $7FFF, $7F27, $0000, $017F, $7FFF, $7F27, $0000 ; id 41 LizardMan
    dw $0D69, $7FFF, $02D7, $0000, $0190, $7FFF, $02D7, $0000 ; id 42 Poisongon
    dw $680A, $7FFF, $7E00, $0000, $680A, $7FFF, $0215, $0000 ; id 43 Swordgon
    dw $6DE7, $7FFF, $7ED2, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 44 Drygon
    dw $01C3, $7FFF, $32A0, $0000, $01C3, $7FFF, $0215, $0000 ; id 45 Dragon
    dw $0119, $7FFF, $02BF, $0000, $001C, $7FFF, $02BF, $0000 ; id 46 MiniDrak
    dw $4D20, $7FFF, $7E80, $0000, $681F, $7FFF, $7E80, $0000 ; id 47 MadDragon
    dw $017F, $7FFF, $02FF, $0000, $681F, $7FFF, $02FF, $0000 ; id 48 Rayburn
    dw $01A0, $7FFF, $06A0, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 49 Chamelgon
    dw $0286, $7FFF, $03B6, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 50 LizardFly
    dw $1525, $7FFF, $424F, $0000, $7C1F, $7FFF, $424F, $0000 ; id 51 Andreal
    dw $1546, $7FFF, $1479, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 52 KingCobra
    dw $4D67, $7FFF, $7230, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 53 Vampirus
    dw $0286, $7FFF, $03B6, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 54 SnakeBat
    dw $00F1, $7FFF, $3E51, $0000, $40A0, $7FFF, $3E51, $0000 ; id 55 Spikerous
    dw $10AC, $7FFF, $061F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 56 GreatDrak
    dw $187D, $7FFF, $06C5, $0000, $0180, $7FFF, $06C5, $0000 ; id 57 Crestpent
    dw $01A1, $7FFF, $7E60, $0000, $0015, $7FFF, $7E60, $0000 ; id 58 WingSnake
    dw $00F8, $7FFF, $0723, $0000, $00F8, $7FFF, $3E55, $0000 ; id 59 Coatol
    dw $014B, $7FFF, $0286, $0000, $5037, $7FFF, $0286, $0000 ; id 60 Orochi
    dw $1E00, $7FFF, $076F, $0000, $3965, $7FFF, $5F8F, $0000 ; id 61 BattleRex
    dw $010D, $7FFF, $023D, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 62 SkyDragon
    dw $001D, $7FFF, $79E0, $0000, $0015, $7FFF, $0309, $0000 ; id 63 Serpentia
    dw $118B, $7FFF, $1BEC, $0000, $385B, $7FFF, $1BEC, $0000 ; id 64 Divinegon
    dw $01C8, $7FFF, $02BF, $0000, $01C8, $7FFF, $6260, $0000 ; id 65 Orligon
    dw $3C6A, $7FFF, $155E, $0000, $0051, $7FFF, $155E, $0000 ; id 66 GigaDraco
    dw $01DE, $7FFF, $037F, $0000, $7C1F, $7FFF, $037F, $0000 ; id 67 ?
    dw $01DE, $7FFF, $037F, $0000, $7C1F, $7FFF, $037F, $0000 ; id 68 ?
    dw $01DE, $7FFF, $037F, $0000, $7C1F, $7FFF, $037F, $0000 ; id 69 ?
    dw $01DE, $7FFF, $037F, $0000, $7C1F, $7FFF, $037F, $0000 ; id 70 ?
    dw $0113, $7FFF, $021A, $0000, $6AC0, $7FFF, $021A, $0000 ; id 71 Tonguella
    dw $7CF7, $7FFF, $7ED9, $0000, $7CF7, $7FFF, $023F, $0000 ; id 72 Almiraj
    dw $00D9, $7FFF, $023F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 73 CatFly
    dw $01E5, $7FFF, $036F, $0000, $023F, $7FFF, $036F, $0000 ; id 74 PillowRat
    dw $04CF, $7FFF, $0176, $0000, $5DA0, $7FFF, $0176, $0000 ; id 75 Saccer
    dw $1D8B, $7FFF, $02B0, $0000, $34D0, $7FFF, $02B0, $0000 ; id 76 GulpBeast
    dw $0179, $7FFF, $035F, $0000, $1D8E, $7FFF, $5F16, $0000 ; id 77 Skullroo
    dw $69A0, $7FFF, $7F00, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 78 WindBeast
    dw $7EE0, $7FFF, $027D, $0000, $011B, $7FFF, $027D, $0000 ; id 79 Beavern
    dw $64E3, $7FFF, $7E23, $0000, $64E3, $7FFF, $017F, $0000 ; id 80 Antbear
    dw $582F, $7FFF, $025F, $0000, $582F, $7FFF, $6C5A, $0000 ; id 81 SuperTen
    dw $01C4, $7FFF, $032E, $0000, $00D6, $7FFF, $4651, $0000 ; id 82 IronTurt
    dw $39EE, $7FFF, $025F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 83 Mommonja
    dw $2C12, $7FFF, $2CDE, $0000, $0511, $7FFF, $01DF, $0000 ; id 84 HammerMan
    dw $3526, $7FFF, $4A0C, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 85 Grizzly
    dw $010E, $7FFF, $3E54, $0000, $010E, $7FFF, $455F, $0000 ; id 86 Yeti
    dw $316A, $7FFF, $5293, $0000, $007D, $7FFF, $5293, $0000 ; id 87 ArrowDog
    dw $3412, $7FFF, $4D1F, $0000, $4585, $7FFF, $4D1F, $0000 ; id 88 NoctoKing
    dw $1CEB, $7FFF, $1CFF, $0000, $6CF1, $7FFF, $1CFF, $0000 ; id 89 BeastNite
    dw $6C6C, $7FFF, $7A87, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 90 MadGopher
    dw $70AD, $7FFF, $713D, $0000, $009C, $7FFF, $025F, $0000 ; id 91 FairyRat
    dw $009C, $7FFF, $5A17, $0000, $009C, $7FFF, $163B, $0000 ; id 92 Unicorn
    dw $75A0, $7FFF, $023E, $0000, $75A0, $7FFF, $6CD6, $0000 ; id 93 Goategon
    dw $486C, $7FFF, $6CD6, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 94 WildApe
    dw $6144, $7FFF, $76F0, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 95 Trumpeter
    dw $062D, $7FFF, $7AC4, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 96 KingLeo
    dw $09C0, $7FFF, $02BF, $0000, $68D5, $7FFF, $02BF, $0000 ; id 97 DarkHorn
    dw $0017, $7FFF, $01BF, $0000, $01F6, $7FFF, $02FF, $0000 ; id 98 MadCat
    dw $00EF, $7FFF, $01D8, $0000, $3680, $7FFF, $01D8, $0000 ; id 99 BigEye
    dw $0016, $7FFF, $027D, $0000, $0016, $7FFF, $3A96, $0000 ; id 100 Gorago
    dw $0136, $7FFF, $025F, $0000, $44B9, $7FFF, $025F, $0000 ; id 101 CatMage
    dw $05EC, $7FFF, $025F, $0000, $451E, $7FFF, $025F, $0000 ; id 102 Dumbira
    dw $0113, $7FFF, $021A, $0000, $6AC0, $7FFF, $021A, $0000 ; id 103 ?
    dw $0113, $7FFF, $021A, $0000, $6AC0, $7FFF, $021A, $0000 ; id 104 ?
    dw $0113, $7FFF, $021A, $0000, $6AC0, $7FFF, $021A, $0000 ; id 105 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 106 Picky
    dw $011B, $7FFF, $02FF, $0000, $011B, $7FFF, $6A94, $0000 ; id 107 Wyvern
    dw $1C49, $7FFF, $00CF, $0000, $2063, $7FFF, $2CC6, $0000 ; id 108 BullBird
    dw $1857, $7FFF, $039F, $0000, $1857, $7FFF, $7E2A, $0000 ; id 109 Florajay
    dw $3C9F, $7FFF, $01DF, $0000, $3C9F, $7FFF, $075F, $0000 ; id 110 DuckKite
    dw $001A, $7FFF, $7C1F, $0000, $001A, $7FFF, $01FF, $0000 ; id 111 MadPecker
    dw $010C, $7FFF, $02BB, $0000, $4C11, $7FFF, $7D9F, $0000 ; id 112 MadRaven
    dw $00DD, $7FFF, $02BF, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 113 MistyWing
    dw $013C, $7FFF, $031F, $0000, $62E0, $7FFF, $031F, $0000 ; id 114 AquaHawk
    dw $007B, $7FFF, $2A97, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 115 Dracky
    dw $540E, $7FFF, $34BF, $0000, $540E, $7FFF, $1B4D, $0000 ; id 116 KiteHawk
    dw $3037, $7FFF, $02FF, $0000, $0156, $7FFF, $02FF, $0000 ; id 117 BigRoost
    dw $7DE0, $7FFF, $025F, $0000, $4500, $7FFF, $025F, $0000 ; id 118 StubBird
    dw $3031, $7FFF, $483B, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 119 LandOwl
    dw $70D6, $7FFF, $0218, $0000, $0019, $7FFF, $70D6, $0000 ; id 120 MadGoose
    dw $3C4F, $7FFF, $51F8, $0000, $38B0, $7FFF, $023E, $0000 ; id 121 MadCondor
    dw $7D26, $7FFF, $001F, $0000, $7D26, $7FFF, $031F, $0000 ; id 122 Emyu
    dw $6120, $7FFF, $76E8, $0000, $6120, $7FFF, $05BF, $0000 ; id 123 Blizzardy
    dw $00BB, $7FFF, $029D, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 124 Phoenix
    dw $7D2F, $7FFF, $7EAB, $0000, $7CED, $7FFF, $01FF, $0000 ; id 125 ZapBird
    dw $6566, $7FFF, $5AB4, $0000, $6566, $7FFF, $02BF, $0000 ; id 126 Garudian
    dw $0033, $7FFF, $015E, $0000, $015F, $7FFF, $02FF, $0000 ; id 127 WhipBird
    dw $7C0D, $7FFF, $7F69, $0000, $34D1, $7FFF, $0A3C, $0000 ; id 128 FunkyBird
    dw $500D, $7FFF, $68FB, $0000, $0019, $7FFF, $02DF, $0000 ; id 129 RainHawk
    dw $7909, $7FFF, $1F3F, $0000, $1192, $7FFF, $1F3F, $0000 ; id 130 Azurile
    dw $348E, $7FFF, $7597, $0000, $1128, $7FFF, $7597, $0000 ; id 131 Shantak
    dw $155E, $7FFF, $7EA0, $0000, $155E, $7FFF, $0E79, $0000 ; id 132 CragDevil
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 133 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 134 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 135 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 136 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 137 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 138 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 139 ?
    dw $10B5, $7FFF, $021E, $0000, $380E, $7FFF, $001E, $0000 ; id 140 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 141 MadPlant
    dw $6470, $7FFF, $69FF, $0000, $0120, $7FFF, $2FEB, $0000 ; id 142 FireWeed
    dw $60B2, $7FFF, $7E6E, $0000, $5870, $7FFF, $398A, $0000 ; id 143 FloraMan
    dw $01C4, $7FFF, $02F1, $0000, $5011, $7FFF, $02F1, $0000 ; id 144 WingTree
    dw $01E1, $7FFF, $032A, $0000, $3D2E, $7FFF, $001F, $0000 ; id 145 CactiBall
    dw $0205, $7FFF, $038D, $0000, $0110, $7FFF, $038D, $0000 ; id 146 Gulpple
    dw $6470, $7FFF, $7EE8, $0000, $4151, $7FFF, $0336, $0000 ; id 147 Toadstool
    dw $008D, $7FFF, $01FF, $0000, $1C0C, $7FFF, $3816, $0000 ; id 148 AmberWeed
    dw $01FF, $7FFF, $170E, $0000, $141F, $7FFF, $461F, $0000 ; id 149 Slurperon
    dw $0110, $7FFF, $021B, $0000, $0110, $7FFF, $1E80, $0000 ; id 150 Stubsuck
    dw $012C, $7FFF, $02ED, $0000, $0093, $7FFF, $021F, $0000 ; id 151 Oniono
    dw $00DA, $7FFF, $025F, $0000, $012C, $7FFF, $0388, $0000 ; id 152 DanceVegi
    dw $012F, $7FFF, $021F, $0000, $012F, $7FFF, $7700, $0000 ; id 153 TreeBoy
    dw $00F4, $7FFF, $023C, $0000, $00F4, $7FFF, $0AAB, $0000 ; id 154 Devipine
    dw $0093, $7FFF, $0217, $0000, $01C1, $7FFF, $03EE, $0000 ; id 155 FaceTree
    dw $01C1, $7FFF, $0217, $0000, $0091, $7FFF, $0217, $0000 ; id 156 HerbMan
    dw $11E1, $7FFF, $032C, $0000, $3D80, $7FFF, $01DB, $0000 ; id 157 BeanMan
    dw $3056, $7FFF, $027E, $0000, $012F, $7FFF, $021F, $0000 ; id 158 EvilSeed
    dw $005B, $7FFF, $0F00, $0000, $005B, $7FFF, $35DF, $0000 ; id 159 ManEater
    dw $01C8, $7FFF, $031C, $0000, $01C8, $7FFF, $005B, $0000 ; id 160 Snapper
    dw $1D6F, $7FFF, $52BA, $0000, $1D6F, $7FFF, $52BA, $0000 ; id 161 GhosTree
    dw $0220, $7FFF, $036C, $0000, $0078, $7FFF, $036C, $0000 ; id 162 Rosevine
    dw $296D, $7FFF, $12C4, $0000, $0186, $7FFF, $12C4, $0000 ; id 163 Egdracil
    dw $1C75, $7FFF, $2DDD, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 164 Warubou
    dw $58E0, $7FFF, $7EA6, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 165 Watabou
    dw $404C, $7FFF, $6CD6, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 166 Eggplaton
    dw $0193, $7FFF, $024A, $0000, $00DD, $7FFF, $4E73, $0000 ; id 167 FooHero
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 168 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 169 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 170 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 171 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 172 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 173 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 174 ?
    dw $0200, $7FFF, $038D, $0000, $4000, $7FFF, $7DA0, $0000 ; id 175 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 176 GiantSlug
    dw $3816, $7FFF, $034D, $0000, $3816, $7FFF, $459F, $0000 ; id 177 Catapila
    dw $3810, $7FFF, $027F, $0000, $3810, $7FFF, $12C4, $0000 ; id 178 Gophecada
    dw $007B, $7FFF, $7DCE, $0000, $007B, $7FFF, $7CB7, $0000 ; id 179 Butterfly
    dw $6D60, $7FFF, $4740, $0000, $38AD, $7FFF, $027F, $0000 ; id 180 WeedBug
    dw $4450, $7FFF, $5D18, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 181 GiantWorm
    dw $0139, $7FFF, $034E, $0000, $0013, $7FFF, $59DF, $0000 ; id 182 Lipsy
    dw $00D0, $7FFF, $023F, $0000, $00D0, $7FFF, $7204, $0000 ; id 183 StagBug
    dw $0572, $7FFF, $421F, $0000, $6C12, $7FFF, $421F, $0000 ; id 184 Pyuro
    dw $7C0B, $7FFF, $6381, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 185 ArmyAnt
    dw $001F, $7FFF, $02FD, $0000, $0118, $7FFF, $02FD, $0000 ; id 186 GoHopper
    dw $3858, $7FFF, $3E76, $0000, $3858, $7FFF, $7E6E, $0000 ; id 187 TailEater
    dw $0416, $7FFF, $019F, $0000, $4C0D, $7FFF, $019F, $0000 ; id 188 ArmorPede
    dw $5C6F, $7FFF, $02FF, $0000, $5C6F, $7FFF, $00FF, $0000 ; id 189 Eyeder
    dw $0152, $7FFF, $027E, $0000, $001A, $7FFF, $027E, $0000 ; id 190 GiantMoth
    dw $141F, $7FFF, $519D, $0000, $00CD, $7FFF, $401F, $0000 ; id 191 Droll
    dw $0018, $7FFF, $01DE, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 192 ArmyCrab
    dw $0411, $7FFF, $02BF, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 193 MadHornet
    dw $381C, $7FFF, $023F, $0000, $381C, $7FFF, $49CE, $0000 ; id 194 Belzebub
    dw $0208, $7FFF, $71B3, $0000, $0208, $7FFF, $0974, $0000 ; id 195 WarMantis
    dw $00AF, $7FFF, $019B, $0000, $00AF, $7FFF, $0218, $0000 ; id 196 HornBeet
    dw $318C, $7FFF, $2BE0, $0000, $001F, $7FFF, $2BEA, $0000 ; id 197 Sickler
    dw $015B, $7FFF, $02BF, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 198 Armorpion
    dw $000C, $7FFF, $04BD, $0000, $600B, $7FFF, $04BD, $0000 ; id 199 Digster
    dw $2012, $7FFF, $541F, $0000, $280C, $7FFF, $4912, $0000 ; id 200 Skularach
    dw $0091, $7FFF, $017D, $0000, $4010, $7FFF, $017D, $0000 ; id 201 MultiEyes
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 202 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 203 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 204 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 205 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 206 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 207 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 208 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 209 ?
    dw $0018, $7FFF, $0371, $0000, $00CF, $7FFF, $021B, $0000 ; id 210 ?
    dw $5C00, $7FFF, $7DC0, $0000, $0012, $7FFF, $7DC0, $0000 ; id 211 Pixy
    dw $025F, $7FFF, $7A00, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 212 MedusaEye
    dw $58E3, $7FFF, $7EE7, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 213 AgDevil
    dw $3478, $7FFF, $023F, $0000, $3478, $7FFF, $04F0, $0000 ; id 214 Demonite
    dw $6D60, $7FFF, $7D57, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 215 DarkEye
    dw $6940, $7FFF, $7EA4, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 216 EyeBall
    dw $6D60, $7FFF, $029F, $0000, $640E, $7FFF, $029F, $0000 ; id 217 SkulRider
    dw $4571, $7FFF, $6A18, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 218 EvilBeast
    dw $0160, $7FFF, $170E, $0000, $04F0, $7FFF, $170E, $0000 ; id 219 Bubblemon
    dw $009B, $7FFF, $027F, $0000, $009B, $7FFF, $7DC0, $0000 ; id 220 1EyeClown
    dw $3835, $7FFF, $71BC, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 221 Gremlin
    dw $01C3, $7FFF, $64B9, $0000, $002B, $7FFF, $64B9, $0000 ; id 222 ArcDemon
    dw $5C70, $7FFF, $023C, $0000, $5C70, $7FFF, $4A33, $0000 ; id 223 Lionex
    dw $0011, $7FFF, $011C, $0000, $5160, $7FFF, $011C, $0000 ; id 224 GoatHorn
    dw $0132, $7FFF, $025D, $0000, $0132, $7FFF, $0268, $0000 ; id 225 Orc
    dw $58C0, $7FFF, $0F68, $0000, $34C0, $7FFF, $3D8F, $0000 ; id 226 Ogre
    dw $406D, $7FFF, $5917, $0000, $280A, $7FFF, $3D8F, $0000 ; id 227 GateGuard
    dw $58B9, $7FFF, $7D8E, $0000, $54C0, $7FFF, $7D8E, $0000 ; id 228 ChopClown
    dw $402F, $7FFF, $032B, $0000, $0152, $7FFF, $032B, $0000 ; id 229 BossTroll
    dw $30AC, $7FFF, $7EA0, $0000, $1895, $7FFF, $027F, $0000 ; id 230 Grendal
    dw $00BB, $7FFF, $029F, $0000, $00AF, $7FFF, $029F, $0000 ; id 231 Akubar
    dw $3123, $7FFF, $7E4F, $0000, $3123, $7FFF, $7D79, $0000 ; id 232 MadKnight
    dw $001B, $7FFF, $0259, $0000, $001B, $7FFF, $3A08, $0000 ; id 233 EvilWell
    dw $6580, $7FFF, $7720, $0000, $00D1, $7FFF, $7720, $0000 ; id 234 Gigantes
    dw $6960, $7FFF, $7720, $0000, $6960, $7FFF, $023F, $0000 ; id 235 Centasaur
    dw $41E7, $7FFF, $001A, $0000, $41E7, $7FFF, $021C, $0000 ; id 236 EvilArmor
    dw $2D11, $7FFF, $027F, $0000, $3123, $7FFF, $5A53, $0000 ; id 237 Jamirus
    dw $5811, $7FFF, $01DF, $0000, $5811, $7FFF, $5254, $0000 ; id 238 Durran
    dw $1C0C, $7FFF, $4692, $0000, $4CE3, $7FFF, $00AF, $0000 ; id 239 Titanis
    dw $748F, $7FFF, $01BF, $0000, $1103, $7FFF, $320C, $0000 ; id 240 LampGenie
    dw $5C00, $7FFF, $7DC0, $0000, $0012, $7FFF, $7DC0, $0000 ; id 241 ?
    dw $5C00, $7FFF, $7DC0, $0000, $0012, $7FFF, $7DC0, $0000 ; id 242 ?
    dw $5C00, $7FFF, $7DC0, $0000, $0012, $7FFF, $7DC0, $0000 ; id 243 ?
    dw $5C00, $7FFF, $7DC0, $0000, $0012, $7FFF, $7DC0, $0000 ; id 244 ?
    dw $5C00, $7FFF, $7DC0, $0000, $0012, $7FFF, $7DC0, $0000 ; id 245 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 246 Spooky
    dw $218E, $7FFF, $3296, $0000, $218E, $7FFF, $027F, $0000 ; id 247 Skullgon
    dw $600C, $7FFF, $7A20, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 248 PutrePup
    dw $240C, $7FFF, $7476, $0000, $240C, $7FFF, $7E0F, $0000 ; id 249 RotRaven
    dw $306F, $7FFF, $7D5A, $0000, $5CCC, $7FFF, $7D5A, $0000 ; id 250 Mummy
    dw $4006, $7FFF, $692F, $0000, $4006, $7FFF, $2C1F, $0000 ; id 251 DarkCrab
    dw $440D, $7FFF, $0196, $0000, $0070, $7FFF, $0196, $0000 ; id 252 DeadNite
    dw $420B, $7FFF, $033F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 253 Shadow
    dw $601A, $7FFF, $2E75, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 254 Skulpent
    dw $0070, $7FFF, $0196, $0000, $0070, $7FFF, $7610, $0000 ; id 255 Hork
    dw $4414, $7FFF, $02DF, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 256 Mudron
    dw $0199, $7FFF, $7E80, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 257 NiteWhip
    dw $6140, $7FFF, $7F46, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 258 WindMerge
    dw $00DC, $7FFF, $02BF, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 259 Reaper
    dw $5A28, $7FFF, $1DD3, $0000, $5A28, $7FFF, $037F, $0000 ; id 260 Inverzon
    dw $7D00, $7FFF, $7EEC, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 261 FoxFire
    dw $001D, $7FFF, $528F, $0000, $02BC, $7FFF, $528F, $0000 ; id 262 CaptDead
    dw $2058, $7FFF, $7DE8, $0000, $30ED, $7FFF, $7DE8, $0000 ; id 263 DeadNoble
    dw $080F, $7FFF, $3C7F, $0000, $280A, $7FFF, $02ED, $0000 ; id 264 WhiteKing
    dw $3D04, $7FFF, $151F, $0000, $00ED, $7FFF, $01FD, $0000 ; id 265 BoneSlave
    dw $2C2E, $7FFF, $6917, $0000, $10A9, $7FFF, $5235, $0000 ; id 266 Skeletor
    dw $24AE, $7FFF, $4190, $0000, $24AE, $7FFF, $01FD, $0000 ; id 267 Servant
    dw $0016, $7FFF, $02BF, $0000, $150B, $7FFF, $51D4, $0000 ; id 268 Lazamanus
    dw $75A0, $7FFF, $035F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 269 Copycat
    dw $380F, $7FFF, $6939, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 270 MadSpirit
    dw $1012, $7FFF, $501F, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 271 PomPomBom
    dw $7C2E, $7FFF, $3C1D, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 272 Niterich
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 273 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 274 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 275 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 276 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 277 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 278 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 279 ?
    dw $5815, $7FFF, $011E, $0000, $00BB, $7FFF, $023F, $0000 ; id 280 ?
    dw $0C16, $7FFF, $031F, $0000, $40B3, $7FFF, $75A0, $1060 ; id 281 JewelBag
    dw $00EF, $7FFF, $021A, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 282 EvilWand
    dw $021F, $7FFF, $7F0A, $0000, $001A, $7FFF, $7F0A, $0000 ; id 283 MadCandle
    dw $5589, $7FFF, $02FF, $0000, $340A, $7FFF, $7DD9, $0000 ; id 284 CoilBird
    dw $190F, $7FFF, $031F, $0000, $190F, $7FFF, $7CE1, $0000 ; id 285 Facer
    dw $0244, $7FFF, $036D, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 286 SpikyBoy
    dw $1417, $7FFF, $035F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 287 MadMirror
    dw $5033, $7FFF, $7E24, $0000, $5033, $7FFF, $021A, $0000 ; id 288 RogueNite
    dw $0160, $7FFF, $170E, $0000, $015B, $7FFF, $033D, $0000 ; id 289 Puppetor
    dw $0153, $7FFF, $025C, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 290 Goopi
    dw $240C, $7FFF, $5815, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 291 Voodoll
    dw $71C9, $7FFF, $7F54, $0000, $06A0, $7FFF, $7F54, $0000 ; id 292 MetalDrak
    dw $7129, $7FFF, $7EC4, $0000, $38ED, $7FFF, $7EC4, $0000 ; id 293 Balzak
    dw $02DF, $7FFF, $7F0B, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 294 SabreMan
    dw $00FA, $7FFF, $02BF, $0000, $38F4, $7FFF, $02BF, $0000 ; id 295 CurseLamp
    dw $0160, $7FFF, $170E, $0000, $0160, $7FFF, $021F, $0000 ; id 296 Brushead
    dw $64C6, $7FFF, $7EC5, $0000, $2D10, $7FFF, $7EC5, $0000 ; id 297 Roboster
    dw $7DC0, $7FFF, $031E, $0000, $2107, $7FFF, $02F8, $0000 ; id 298 Roboster2
    dw $0153, $7FFF, $025C, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 299 EvilPot
    dw $4DCD, $7FFF, $62D4, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 300 Gismo
    dw $0018, $7FFF, $025F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 301 LavaMan
    dw $029E, $7FFF, $7E09, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 302 IceMan
    dw $3926, $7FFF, $59EC, $0000, $5C53, $7FFF, $59EC, $0000 ; id 303 Mimic
    dw $486A, $7FFF, $7EEC, $0000, $0175, $7FFF, $7EEC, $0000 ; id 304 Exaucers
    dw $00EF, $7FFF, $021A, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 305 MudDoll
    dw $00D3, $7FFF, $025B, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 306 Golem
    dw $25CE, $7FFF, $4AB5, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 307 StoneMan
    dw $6186, $7FFF, $726C, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 308 BombCrag
    dw $4CCF, $7FFF, $061F, $0000, $1017, $7FFF, $061F, $0000 ; id 309 GoldGolem
    dw $2836, $7FFF, $7969, $0000, $2108, $7FFF, $7969, $0000 ; id 310 DarkMate
    dw $7D00, $7FFF, $24DB, $0000, $7D00, $7FFF, $360D, $0000 ; id 311 ProtoMech
    dw $7C20, $7FFF, $7E87, $0000, $24D3, $7FFF, $7E87, $0000 ; id 312 CloudKing
    dw $0C16, $7FFF, $031F, $0000, $40B3, $7FFF, $75A0, $1060 ; id 313 ?
    dw $0C16, $7FFF, $031F, $0000, $40B3, $7FFF, $75A0, $1060 ; id 314 ?
    dw $0C16, $7FFF, $031F, $0000, $40B3, $7FFF, $75A0, $1060 ; id 315 ?
    dw $4051, $7FFF, $6D5B, $0000, $4051, $7FFF, $3A75, $0000 ; id 316 Petiteel
    dw $50D2, $7FFF, $027F, $0000, $7CA3, $7FFF, $027F, $0000 ; id 317 Moray
    dw $1592, $7FFF, $169F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 318 WalrusMan
    dw $1C1A, $7FFF, $01FD, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 319 RayGigas
    dw $0071, $7FFF, $0D7A, $0000, $1B2E, $7FFF, $0E5F, $0000 ; id 320 Anemon
    dw $488C, $7FFF, $7EEC, $0000, $4051, $7FFF, $6D5B, $0000 ; id 321 Aquarella
    dw $4D67, $7FFF, $7230, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 322 Merman
    dw $212A, $7FFF, $493F, $0000, $05B0, $7FFF, $493F, $0000 ; id 323 Octokid
    dw $24D3, $7FFF, $0619, $0000, $7C20, $7FFF, $7E80, $0000 ; id 324 PutreFish
    dw $4D67, $7FFF, $7230, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 325 Octoreach
    dw $008E, $7FFF, $3152, $0000, $008E, $7FFF, $7E54, $0000 ; id 326 Angleron
    dw $4826, $7FFF, $7EEC, $0000, $4826, $7FFF, $751A, $0000 ; id 327 FishRider
    dw $60A3, $7FFF, $7DEC, $0000, $60A3, $7FFF, $42B9, $0000 ; id 328 RushFish
    dw $0010, $7FFF, $009F, $0000, $150C, $7FFF, $023F, $0000 ; id 329 Gamanian
    dw $08D2, $7FFF, $023B, $0000, $009F, $7FFF, $023B, $0000 ; id 330 Clawster
    dw $00BF, $7FFF, $1E7F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 331 CancerMan
    dw $4D67, $7FFF, $7230, $0000, $001F, $7FFF, $7230, $0000 ; id 332 RogueWave
    dw $306F, $7FFF, $0258, $0000, $306F, $7FFF, $7D5A, $0000 ; id 333 Scallopa
    dw $68F6, $7FFF, $3A1D, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 334 SeaHorse
    dw $281B, $7FFF, $7210, $0000, $281B, $7FFF, $759A, $0000 ; id 335 HoodSquid
    dw $00F4, $7FFF, $023C, $0000, $2DA1, $7FFF, $023C, $0000 ; id 336 MerTiger
    dw $7D00, $7FFF, $7EEC, $0000, $0018, $7FFF, $023F, $0000 ; id 337 AxeShark
    dw $5904, $7FFF, $7DCD, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 338 Octogon
    dw $306F, $7FFF, $7D5A, $0000, $5CCC, $7FFF, $7D5A, $0000 ; id 339 KingSquid
    dw $0011, $7FFF, $011F, $0000, $0011, $7FFF, $45F2, $0000 ; id 340 Digong
    dw $4C8B, $7FFF, $39D0, $0000, $4C8B, $7FFF, $0050, $0000 ; id 341 WhaleMage
    dw $4104, $7FFF, $69EE, $0000, $0250, $7FFF, $69EE, $0000 ; id 342 Aquadon
    dw $0035, $7FFF, $017F, $0000, $2D2C, $7FFF, $017F, $0000 ; id 343 Octoraid
    dw $0140, $7FFF, $0369, $0000, $0091, $7FFF, $0369, $0000 ; id 344 Grakos
    dw $2DC1, $7FFF, $5B21, $0000, $2DC1, $7FFF, $6598, $0000 ; id 345 Poseidon
    dw $0240, $7FFF, $6AB2, $0000, $501F, $7FFF, $6AB2, $0000 ; id 346 Pumpoise
    dw $1854, $7FFF, $56A0, $0000, $7FE0, $7FE0, $7FE0, $7FE0 ; id 347 Starfish
    dw $4051, $7FFF, $6D5B, $0000, $4051, $7FFF, $3A75, $0000 ; id 348 ?
    dw $4051, $7FFF, $6D5B, $0000, $4051, $7FFF, $3A75, $0000 ; id 349 ?
    dw $4051, $7FFF, $6D5B, $0000, $4051, $7FFF, $3A75, $0000 ; id 350 ?
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 351 DracoLord
    dw $3C64, $7FFF, $6C73, $0000, $000F, $7FFF, $0419, $0000 ; id 352 DracoLord
    dw $4013, $7FFF, $001F, $0000, $4013, $7FFF, $653B, $0000 ; id 353 LordDraco
    dw $0056, $7FFF, $7E0C, $0000, $0056, $7FFF, $7D9F, $0000 ; id 354 Hargon
    dw $0053, $7FFF, $7E20, $0000, $3C64, $7FFF, $7E20, $0000 ; id 355 Sidoh
    dw $58AA, $7FFF, $51D4, $0000, $58AA, $7FFF, $015A, $0000 ; id 356 Genosidoh
    dw $0CED, $7FFF, $0211, $0000, $0CED, $7FFF, $6939, $0000 ; id 357 Baramos
    dw $0058, $7FFF, $029F, $0000, $340E, $7FFF, $7E0C, $0000 ; id 358 Zoma
    dw $75A0, $7FFF, $1B6B, $0000, $0C17, $7FFF, $4295, $0000 ; id 359 AsuraZoma
    dw $0145, $7FFF, $0E71, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 360 Pizzaro
    dw $24CB, $7FFF, $60DD, $0000, $24CB, $7FFF, $2708, $0000 ; id 361 PsychoPiz
    dw $00F3, $7FFF, $02DF, $0000, $00F3, $7FFF, $009F, $0000 ; id 362 Esterk
    dw $2C53, $7FFF, $0310, $0000, $44CA, $7FFF, $7E0C, $0000 ; id 363 Mirudraas
    dw $0414, $7FFF, $493F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 364 Mirudraas
    dw $0091, $7FFF, $02E0, $0000, $0091, $7FFF, $2E36, $0000 ; id 365 Mudou
    dw $2431, $7FFF, $0307, $0000, $2431, $7FFF, $493F, $0000 ; id 366 DeathMore
    dw $0414, $7FFF, $493F, $0000, $7C1F, $7C1F, $7C1F, $7C1F ; id 367 DeathMore
    dw $1015, $7FFF, $7539, $0000, $44C8, $7FFF, $7539, $0000 ; id 368 DeathMore
    dw $008E, $7FFF, $3152, $0000, $008E, $7FFF, $7E54, $0000 ; id 369 Darkdrium
    dw $480D, $7FFF, $4250, $0000, $480D, $7FFF, $0952, $0000 ; id 370 Orgodemir
    dw $05A3, $7FFF, $46CA, $0000, $38E8, $7FFF, $2A16, $0000 ; id 371 Orgodemir
    dw $00B1, $7FFF, $021F, $0000, $3410, $7FFF, $1640, $0000 ; id 372 Darck
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 373 Tatsu
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 374 Diago
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 375 Samsi
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 376 Bazoo
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 377 ?
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 378 ?
    dw $3C64, $7FFF, $4414, $0000, $000F, $7FFF, $4414, $0000 ; id 379 ?
    dw $183E, $7FFF, $037F, $0000, $2AA0, $7FFF, $5A6D, $0000 ; id 380 Lamia
    dw $4C6D, $7FFF, $6E30, $0000, $4C6D, $7FFF, $6F50, $0000 ; id 381 Dimensaur
    dw $09F2, $7FFF, $331F, $0000, $0137, $7FFF, $021F, $0000 ; id 382 Kagebou

; 6 x 6 CGB attribute map of the picture of monster id $003 (WingSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WingSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_59F9:: ; address name
    ds $13, $00
    db $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $004 (TreeSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_TreeSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5A1D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $005 (Snaily) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Snaily:: ; heuristic: monster picture attribute map; C0
Data_07B_5A41:: ; address name
    ds $14, $00
    db $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $006 (SlimeNite) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_SlimeNite:: ; heuristic: monster picture attribute map; C0
Data_07B_5A65:: ; address name
    ds $15, $00
    db $01, $01, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $009 (PearlGel) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_PearlGel:: ; heuristic: monster picture attribute map; C0
Data_07B_5A89:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $00C (FangSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FangSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5AAD:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $00E (SlimeBorg) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_SlimeBorg:: ; heuristic: monster picture attribute map; C0
Data_07B_5AD1:: ; address name
    ds $15, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $010 (KingSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_KingSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5AF5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $013 (SpotKing) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_SpotKing:: ; heuristic: monster picture attribute map; C0
Data_07B_5B19:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $014 (TropicGel) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_TropicGel:: ; heuristic: monster picture attribute map; C0
Data_07B_5B3D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $015 (MimeSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MimeSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5B61:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    db $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $016 (HaloSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_HaloSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5B85:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $017 (MetalKing) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MetalKing:: ; heuristic: monster picture attribute map; C0
Data_07B_5BA9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $018 (GoldSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GoldSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5BCD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $019 (GranSlime) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GranSlime:: ; heuristic: monster picture attribute map; C0
Data_07B_5BF1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $01A (WonderEgg) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WonderEgg:: ; heuristic: monster picture attribute map; C0
Data_07B_5C15:: ; address name
    ds $1B, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $024 (DragonKid) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DragonKid:: ; heuristic: monster picture attribute map; C0
Data_07B_5C39:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $01, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $025 (Tortragon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Tortragon:: ; heuristic: monster picture attribute map; C0
Data_07B_5C5D:: ; address name
    ds $14, $00
    db $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $026 (Pteranod) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Pteranod:: ; heuristic: monster picture attribute map; C0
Data_07B_5C81:: ; address name
    ds $13, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $028 (FairyDrak) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FairyDrak:: ; heuristic: monster picture attribute map; C0
Data_07B_5CA5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $029 (LizardMan) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_LizardMan:: ; heuristic: monster picture attribute map; C0
Data_07B_5CC9:: ; address name
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $02A (Poisongon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Poisongon:: ; heuristic: monster picture attribute map; C0
Data_07B_5CED:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $02B (Swordgon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Swordgon:: ; heuristic: monster picture attribute map; C0
Data_07B_5D11:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $02D (Dragon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Dragon:: ; heuristic: monster picture attribute map; C0
Data_07B_5D35:: ; address name
    ds $13, $00
    db $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $00, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $02E (MiniDrak) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MiniDrak:: ; heuristic: monster picture attribute map; C0
Data_07B_5D59:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $02F (MadDragon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadDragon:: ; heuristic: monster picture attribute map; C0
Data_07B_5D7D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $030 (Rayburn) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Rayburn:: ; heuristic: monster picture attribute map; C0
Data_07B_5DA1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $15, $00

; 6 x 6 CGB attribute map of the picture of monster id $033 (Andreal) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Andreal:: ; heuristic: monster picture attribute map; C0
Data_07B_5DC5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $1B, $00

; 6 x 6 CGB attribute map of the picture of monster id $035 (Vampirus) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Vampirus:: ; heuristic: monster picture attribute map; C0
Data_07B_5DE9:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $036 (SnakeBat) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_SnakeBat:: ; heuristic: monster picture attribute map; C0
Data_07B_5E0D:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $037 (Spikerous) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Spikerous:: ; heuristic: monster picture attribute map; C0
Data_07B_5E31:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $039 (Crestpent) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Crestpent:: ; heuristic: monster picture attribute map; C0
Data_07B_5E55:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $03A (WingSnake) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WingSnake:: ; heuristic: monster picture attribute map; C0
Data_07B_5E79:: ; address name
    db $01, $01, $00, $00, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01
    db $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $03B (Coatol) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Coatol:: ; heuristic: monster picture attribute map; C0
Data_07B_5E9D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $03C (Orochi) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Orochi:: ; heuristic: monster picture attribute map; C0
Data_07B_5EC1:: ; address name
    db $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $01, $01, $00, $00
    db $01, $01, $01, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $03D (BattleRex) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BattleRex:: ; heuristic: monster picture attribute map; C0
Data_07B_5EE5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $01, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $03F (Serpentia) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Serpentia:: ; heuristic: monster picture attribute map; C0
Data_07B_5F09:: ; address name
    db $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
    ds $12, $01

; 6 x 6 CGB attribute map of the picture of monster id $040 (Divinegon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Divinegon:: ; heuristic: monster picture attribute map; C0
Data_07B_5F2D:: ; address name
    ds $18, $00
    db $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $041 (Orligon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Orligon:: ; heuristic: monster picture attribute map; C0
Data_07B_5F51:: ; address name
    ds $12, $00
    db $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $00, $01, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $042 (GigaDraco) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GigaDraco:: ; heuristic: monster picture attribute map; C0
Data_07B_5F75:: ; address name
    ds $14, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $047 (Tonguella) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Tonguella:: ; heuristic: monster picture attribute map; C0
Data_07B_5F99:: ; address name
    ds $14, $00
    db $01, $00, $00, $00, $00, $00, $01
    ds $17, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04A (PillowRat) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_PillowRat:: ; heuristic: monster picture attribute map; C0
Data_07B_5FE1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04B (Saccer) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Saccer:: ; heuristic: monster picture attribute map; C0
Data_07B_6005:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $04C (GulpBeast) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GulpBeast:: ; heuristic: monster picture attribute map; C0
Data_07B_6029:: ; address name
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04D (Skullroo) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Skullroo:: ; heuristic: monster picture attribute map; C0
Data_07B_604D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $04F (Beavern) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Beavern:: ; heuristic: monster picture attribute map; C0
Data_07B_6071:: ; address name
    db $00, $01, $01, $01, $00, $00, $00, $00, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $050 (Antbear) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Antbear:: ; heuristic: monster picture attribute map; C0
Data_07B_6095:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01
    db $01, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $051 (SuperTen) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_SuperTen:: ; heuristic: monster picture attribute map; C0
Data_07B_60B9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $052 (IronTurt) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_IronTurt:: ; heuristic: monster picture attribute map; C0
Data_07B_60DD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $00, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $054 (HammerMan) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_HammerMan:: ; heuristic: monster picture attribute map; C0
Data_07B_6101:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $056 (Yeti) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Yeti:: ; heuristic: monster picture attribute map; C0
Data_07B_6125:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $057 (ArrowDog) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ArrowDog:: ; heuristic: monster picture attribute map; C0
Data_07B_6149:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $01, $01, $00, $00
    db $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $058 (NoctoKing) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_NoctoKing:: ; heuristic: monster picture attribute map; C0
Data_07B_616D:: ; address name
    db $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $059 (BeastNite) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BeastNite:: ; heuristic: monster picture attribute map; C0
Data_07B_6191:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $05B (FairyRat) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FairyRat:: ; heuristic: monster picture attribute map; C0
Data_07B_61B5:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $05C (Unicorn) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Unicorn:: ; heuristic: monster picture attribute map; C0
Data_07B_61D9:: ; address name
    db $01, $00, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $00, $00
    db $00, $01, $00, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $05D (Goategon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Goategon:: ; heuristic: monster picture attribute map; C0
Data_07B_61FD:: ; address name
    ds $1F, $00
    db $01, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $061 (DarkHorn) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DarkHorn:: ; heuristic: monster picture attribute map; C0
Data_07B_6221:: ; address name
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $062 (MadCat) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadCat:: ; heuristic: monster picture attribute map; C0
Data_07B_6245:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $01, $01
    db $01, $00, $01, $01, $01, $01, $01, $00, $01, $00, $01, $01, $00, $00, $01, $01
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $063 (BigEye) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BigEye:: ; heuristic: monster picture attribute map; C0
Data_07B_6269:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $064 (Gorago) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Gorago:: ; heuristic: monster picture attribute map; C0
Data_07B_628D:: ; address name
    ds $1F, $00
    db $01, $01, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $065 (CatMage) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CatMage:: ; heuristic: monster picture attribute map; C0
Data_07B_62B1:: ; address name
    ds $15, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $066 (Dumbira) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Dumbira:: ; heuristic: monster picture attribute map; C0
Data_07B_62D5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $06A (Picky) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Picky:: ; heuristic: monster picture attribute map; C0
Data_07B_62F9:: ; address name
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $06B (Wyvern) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Wyvern:: ; heuristic: monster picture attribute map; C0
Data_07B_631D:: ; address name
    db $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01
    db $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $06C (BullBird) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BullBird:: ; heuristic: monster picture attribute map; C0
Data_07B_6341:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $01
    ds $11, $00

; 6 x 6 CGB attribute map of the picture of monster id $06D (Florajay) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Florajay:: ; heuristic: monster picture attribute map; C0
Data_07B_6365:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $01, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $06E (DuckKite) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DuckKite:: ; heuristic: monster picture attribute map; C0
Data_07B_6389:: ; address name
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $06F (MadPecker) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadPecker:: ; heuristic: monster picture attribute map; C0
Data_07B_63AD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01
    db $00, $00, $00, $01, $01, $00, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $070 (MadRaven) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadRaven:: ; heuristic: monster picture attribute map; C0
Data_07B_63D1:: ; address name
    ds $1A, $00
    db $01, $01, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $072 (AquaHawk) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_AquaHawk:: ; heuristic: monster picture attribute map; C0
Data_07B_63F5:: ; address name
    db $00, $00, $01, $01, $01, $01, $00, $01, $01, $00, $01, $00, $01, $01, $00, $00
    db $01, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $074 (KiteHawk) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_KiteHawk:: ; heuristic: monster picture attribute map; C0
Data_07B_6419:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $075 (BigRoost) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BigRoost:: ; heuristic: monster picture attribute map; C0
Data_07B_643D:: ; address name
    db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $01, $01, $00, $00
    db $00, $00, $00, $01, $00, $00, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $076 (StubBird) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_StubBird:: ; heuristic: monster picture attribute map; C0
Data_07B_6461:: ; address name
    ds $1C, $00
    db $01, $00, $00, $00, $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $078 (MadGoose) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadGoose:: ; heuristic: monster picture attribute map; C0
Data_07B_6485:: ; address name
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $00
    db $01, $01, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $079 (MadCondor) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadCondor:: ; heuristic: monster picture attribute map; C0
Data_07B_64A9:: ; address name
    ds $12, $00
    db $01, $00, $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $07A (Emyu) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Emyu:: ; heuristic: monster picture attribute map; C0
Data_07B_64CD:: ; address name
    ds $13, $00
    db $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $07B (Blizzardy) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Blizzardy:: ; heuristic: monster picture attribute map; C0
Data_07B_64F1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01
    ds $1C, $00

; 6 x 6 CGB attribute map of the picture of monster id $07D (ZapBird) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ZapBird:: ; heuristic: monster picture attribute map; C0
Data_07B_6515:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $01, $00
    db $00, $00, $01, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $07E (Garudian) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Garudian:: ; heuristic: monster picture attribute map; C0
Data_07B_6539:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $07F (WhipBird) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WhipBird:: ; heuristic: monster picture attribute map; C0
Data_07B_655D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
    db $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $00, $00, $01, $01, $00, $01
    db $00, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $080 (FunkyBird) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FunkyBird:: ; heuristic: monster picture attribute map; C0
Data_07B_6581:: ; address name
    ds $1F, $00
    db $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $081 (RainHawk) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_RainHawk:: ; heuristic: monster picture attribute map; C0
Data_07B_65A5:: ; address name
    db $01, $00, $01, $00, $01, $00, $00, $01, $01, $01, $00, $01
    ds $13, $00
    db $01, $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $082 (Azurile) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Azurile:: ; heuristic: monster picture attribute map; C0
Data_07B_65C9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $00, $00, $01, $00
    db $00, $01, $00, $01, $01, $00, $00, $00, $01, $01, $00, $01, $01, $00, $00, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $083 (Shantak) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Shantak:: ; heuristic: monster picture attribute map; C0
Data_07B_65ED:: ; address name
    ds $13, $00
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $084 (CragDevil) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CragDevil:: ; heuristic: monster picture attribute map; C0
Data_07B_6611:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $08D (MadPlant) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadPlant:: ; heuristic: monster picture attribute map; C0
Data_07B_6635:: ; address name
    ds $10, $00
    db $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $08E (FireWeed) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FireWeed:: ; heuristic: monster picture attribute map; C0
Data_07B_6659:: ; address name
    ds $10, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $08F (FloraMan) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FloraMan:: ; heuristic: monster picture attribute map; C0
Data_07B_667D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $090 (WingTree) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WingTree:: ; heuristic: monster picture attribute map; C0
Data_07B_66A1:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00
    db $01, $01
    ds $12, $00

; 6 x 6 CGB attribute map of the picture of monster id $091 (CactiBall) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CactiBall:: ; heuristic: monster picture attribute map; C0
Data_07B_66C5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $1A, $00

; 6 x 6 CGB attribute map of the picture of monster id $092 (Gulpple) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Gulpple:: ; heuristic: monster picture attribute map; C0
Data_07B_66E9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $093 (Toadstool) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Toadstool:: ; heuristic: monster picture attribute map; C0
Data_07B_670D:: ; address name
    ds $14, $00
    db $01, $01, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $094 (AmberWeed) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_AmberWeed:: ; heuristic: monster picture attribute map; C0
Data_07B_6731:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $01, $01, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $095 (Slurperon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Slurperon:: ; heuristic: monster picture attribute map; C0
Data_07B_6755:: ; address name
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $096 (Stubsuck) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Stubsuck:: ; heuristic: monster picture attribute map; C0
Data_07B_6779:: ; address name
    ds $12, $00
    db $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $097 (Oniono) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Oniono:: ; heuristic: monster picture attribute map; C0
Data_07B_679D:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $098 (DanceVegi) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DanceVegi:: ; heuristic: monster picture attribute map; C0
Data_07B_67C1:: ; address name
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01
    ds $16, $00

; 6 x 6 CGB attribute map of the picture of monster id $099 (TreeBoy) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_TreeBoy:: ; heuristic: monster picture attribute map; C0
Data_07B_67E5:: ; address name
    db $00, $00, $00, $00, $01, $01
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $09A (Devipine) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Devipine:: ; heuristic: monster picture attribute map; C0
Data_07B_6809:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01
    db $00, $00, $00, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $09B (FaceTree) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FaceTree:: ; heuristic: monster picture attribute map; C0
Data_07B_682D:: ; address name
    db $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00, $01, $00, $00
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $09C (HerbMan) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_HerbMan:: ; heuristic: monster picture attribute map; C0
Data_07B_6851:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $09D (BeanMan) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BeanMan:: ; heuristic: monster picture attribute map; C0
Data_07B_6875:: ; address name
    ds $14, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $09E (EvilSeed) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_EvilSeed:: ; heuristic: monster picture attribute map; C0
Data_07B_6899:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $00, $01, $01, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $09F (ManEater) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ManEater:: ; heuristic: monster picture attribute map; C0
Data_07B_68BD:: ; address name
    db $00, $00, $01, $00, $00, $00, $01, $00, $01, $00, $01, $01, $01, $01, $00, $00
    db $00, $01, $00, $00, $00, $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0A0 (Snapper) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Snapper:: ; heuristic: monster picture attribute map; C0
Data_07B_68E1:: ; address name
    ds $18, $00
    db $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A1 (GhosTree) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GhosTree:: ; heuristic: monster picture attribute map; C0
Data_07B_6905:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A2 (Rosevine) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Rosevine:: ; heuristic: monster picture attribute map; C0
Data_07B_6929:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A3 (Egdracil) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Egdracil:: ; heuristic: monster picture attribute map; C0
Data_07B_694D:: ; address name
    db $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A4 (Warubou) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Warubou:: ; heuristic: monster picture attribute map; C0
Data_07B_6971:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $0A7 (FooHero) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FooHero:: ; heuristic: monster picture attribute map; C0
Data_07B_6995:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B0 (GiantSlug) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GiantSlug:: ; heuristic: monster picture attribute map; C0
Data_07B_69B9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $00, $01, $01, $01, $00, $01, $00, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0B1 (Catapila) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Catapila:: ; heuristic: monster picture attribute map; C0
Data_07B_69DD:: ; address name
    ds $17, $00
    db $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B3 (Butterfly) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Butterfly:: ; heuristic: monster picture attribute map; C0
Data_07B_6A01:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B4 (WeedBug) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WeedBug:: ; heuristic: monster picture attribute map; C0
Data_07B_6A25:: ; address name
    db $00, $00, $01, $01
    ds $1B, $00
    db $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B6 (Lipsy) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Lipsy:: ; heuristic: monster picture attribute map; C0
Data_07B_6A49:: ; address name
    ds $13, $00
    db $01, $01, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01, $01, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $0B7 (StagBug) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_StagBug:: ; heuristic: monster picture attribute map; C0
Data_07B_6A6D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0B8 (Pyuro) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Pyuro:: ; heuristic: monster picture attribute map; C0
Data_07B_6A91:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BA (GoHopper) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GoHopper:: ; heuristic: monster picture attribute map; C0
Data_07B_6AB5:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BB (TailEater) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_TailEater:: ; heuristic: monster picture attribute map; C0
Data_07B_6AD9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BC (ArmorPede) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ArmorPede:: ; heuristic: monster picture attribute map; C0
Data_07B_6AFD:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BD (Eyeder) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Eyeder:: ; heuristic: monster picture attribute map; C0
Data_07B_6B21:: ; address name
    ds $13, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $0BE (GiantMoth) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GiantMoth:: ; heuristic: monster picture attribute map; C0
Data_07B_6B45:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0BF (Droll) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Droll:: ; heuristic: monster picture attribute map; C0
Data_07B_6B69:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C2 (Belzebub) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Belzebub:: ; heuristic: monster picture attribute map; C0
Data_07B_6B8D:: ; address name
    ds $12, $00
    db $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C3 (WarMantis) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WarMantis:: ; heuristic: monster picture attribute map; C0
Data_07B_6BB1:: ; address name
    db $00, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C4 (HornBeet) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_HornBeet:: ; heuristic: monster picture attribute map; C0
Data_07B_6BD5:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $00, $01, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C5 (Sickler) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Sickler:: ; heuristic: monster picture attribute map; C0
Data_07B_6BF9:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C7 (Digster) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Digster:: ; heuristic: monster picture attribute map; C0
Data_07B_6C1D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0C8 (Skularach) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Skularach:: ; heuristic: monster picture attribute map; C0
Data_07B_6C41:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0C9 (MultiEyes) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MultiEyes:: ; heuristic: monster picture attribute map; C0
Data_07B_6C65:: ; address name
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01
    ds $19, $00

; 6 x 6 CGB attribute map of the picture of monster id $0D3 (Pixy) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Pixy:: ; heuristic: monster picture attribute map; C0
Data_07B_6C89:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0D6 (Demonite) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Demonite:: ; heuristic: monster picture attribute map; C0
Data_07B_6CAD:: ; address name
    ds $13, $00
    db $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $0D9 (SkulRider) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_SkulRider:: ; heuristic: monster picture attribute map; C0
Data_07B_6CD1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DB (Bubblemon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Bubblemon:: ; heuristic: monster picture attribute map; C0
Data_07B_6CF5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01
    db $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DC (1EyeClown) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_1EyeClown:: ; heuristic: monster picture attribute map; C0
Data_07B_6D19:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DE (ArcDemon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ArcDemon:: ; heuristic: monster picture attribute map; C0
Data_07B_6D3D:: ; address name
    db $00, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $01, $01, $00, $00, $00, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0DF (Lionex) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Lionex:: ; heuristic: monster picture attribute map; C0
Data_07B_6D61:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E0 (GoatHorn) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GoatHorn:: ; heuristic: monster picture attribute map; C0
Data_07B_6D85:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01

; 6 x 6 CGB attribute map of the picture of monster id $0E1 (Orc) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Orc:: ; heuristic: monster picture attribute map; C0
Data_07B_6DA9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E2 (Ogre) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Ogre:: ; heuristic: monster picture attribute map; C0
Data_07B_6DCD:: ; address name
    ds $10, $00
    db $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E3 (GateGuard) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GateGuard:: ; heuristic: monster picture attribute map; C0
Data_07B_6DF1:: ; address name
    db $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E4 (ChopClown) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ChopClown:: ; heuristic: monster picture attribute map; C0
Data_07B_6E15:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
    db $01, $00, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E5 (BossTroll) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BossTroll:: ; heuristic: monster picture attribute map; C0
Data_07B_6E39:: ; address name
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01
    ds $17, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E6 (Grendal) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Grendal:: ; heuristic: monster picture attribute map; C0
Data_07B_6E5D:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $01, $01, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E7 (Akubar) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Akubar:: ; heuristic: monster picture attribute map; C0
Data_07B_6E81:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0E8 (MadKnight) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadKnight:: ; heuristic: monster picture attribute map; C0
Data_07B_6EA5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0E9 (EvilWell) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_EvilWell:: ; heuristic: monster picture attribute map; C0
Data_07B_6EC9:: ; address name
    ds $19, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EA (Gigantes) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Gigantes:: ; heuristic: monster picture attribute map; C0
Data_07B_6EED:: ; address name
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EB (Centasaur) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Centasaur:: ; heuristic: monster picture attribute map; C0
Data_07B_6F11:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EC (EvilArmor) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_EvilArmor:: ; heuristic: monster picture attribute map; C0
Data_07B_6F35:: ; address name
    db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $01, $01, $00, $00
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $0ED (Jamirus) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Jamirus:: ; heuristic: monster picture attribute map; C0
Data_07B_6F59:: ; address name
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $01, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EE (Durran) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Durran:: ; heuristic: monster picture attribute map; C0
Data_07B_6F7D:: ; address name
    db $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $01, $00, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0EF (Titanis) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Titanis:: ; heuristic: monster picture attribute map; C0
Data_07B_6FA1:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $0F0 (LampGenie) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_LampGenie:: ; heuristic: monster picture attribute map; C0
Data_07B_6FC5:: ; address name
    ds $12, $00
    ds $12, $01

; 6 x 6 CGB attribute map of the picture of monster id $0F6 (Spooky) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Spooky:: ; heuristic: monster picture attribute map; C0
Data_07B_6FE9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0F7 (Skullgon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Skullgon:: ; heuristic: monster picture attribute map; C0
Data_07B_700D:: ; address name
    db $00, $00, $01, $01
    ds $20, $00

; 6 x 6 CGB attribute map of the picture of monster id $0F9 (RotRaven) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_RotRaven:: ; heuristic: monster picture attribute map; C0
Data_07B_7031:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FA (Mummy) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Mummy:: ; heuristic: monster picture attribute map; C0
Data_07B_7055:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FB (DarkCrab) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DarkCrab:: ; heuristic: monster picture attribute map; C0
Data_07B_7079:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FC (DeadNite) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DeadNite:: ; heuristic: monster picture attribute map; C0
Data_07B_709D:: ; address name
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $0FF (Hork) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Hork:: ; heuristic: monster picture attribute map; C0
Data_07B_70C1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $104 (Inverzon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Inverzon:: ; heuristic: monster picture attribute map; C0
Data_07B_70E5:: ; address name
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01
    db $01
    ds $13, $00

; 6 x 6 CGB attribute map of the picture of monster id $106 (CaptDead) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CaptDead:: ; heuristic: monster picture attribute map; C0
Data_07B_7109:: ; address name
    ds $13, $00
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01

; 6 x 6 CGB attribute map of the picture of monster id $107 (DeadNoble) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DeadNoble:: ; heuristic: monster picture attribute map; C0
Data_07B_712D:: ; address name
    ds $13, $00
    db $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $108 (WhiteKing) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WhiteKing:: ; heuristic: monster picture attribute map; C0
Data_07B_7151:: ; address name
    ds $10, $00
    db $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $109 (BoneSlave) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_BoneSlave:: ; heuristic: monster picture attribute map; C0
Data_07B_7175:: ; address name
    db $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $01, $00, $01, $01, $01, $01, $01, $00, $01, $01
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $10A (Skeletor) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Skeletor:: ; heuristic: monster picture attribute map; C0
Data_07B_7199:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $10B (Servant) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Servant:: ; heuristic: monster picture attribute map; C0
Data_07B_71BD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $10C (Lazamanus) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Lazamanus:: ; heuristic: monster picture attribute map; C0
Data_07B_71E1:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $01, $01, $01, $01
    db $00, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $10F (PomPomBom) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_PomPomBom:: ; heuristic: monster picture attribute map; C0
Data_07B_7205:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $119 (JewelBag) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_JewelBag:: ; heuristic: monster picture attribute map; C0
Data_07B_7229:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $11B (MadCandle) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MadCandle:: ; heuristic: monster picture attribute map; C0
Data_07B_724D:: ; address name
    ds $13, $00
    db $01, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $11C (CoilBird) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CoilBird:: ; heuristic: monster picture attribute map; C0
Data_07B_7271:: ; address name
    db $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $11D (Facer) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Facer:: ; heuristic: monster picture attribute map; C0
Data_07B_7295:: ; address name
    ds $13, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $120 (RogueNite) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_RogueNite:: ; heuristic: monster picture attribute map; C0
Data_07B_72B9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $121 (Puppetor) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Puppetor:: ; heuristic: monster picture attribute map; C0
Data_07B_72DD:: ; address name
    ds $19, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $124 (MetalDrak) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MetalDrak:: ; heuristic: monster picture attribute map; C0
Data_07B_7301:: ; address name
    ds $16, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $125 (Balzak) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Balzak:: ; heuristic: monster picture attribute map; C0
Data_07B_7325:: ; address name
    ds $24, $00

; 6 x 6 CGB attribute map of the picture of monster id $127 (CurseLamp) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CurseLamp:: ; heuristic: monster picture attribute map; C0
Data_07B_7349:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $128 (Brushead) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Brushead:: ; heuristic: monster picture attribute map; C0
Data_07B_736D:: ; address name
    db $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $01, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $01, $01, $01, $00, $00, $00
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $129 (Roboster) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Roboster:: ; heuristic: monster picture attribute map; C0
Data_07B_7391:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $12A (Roboster2) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Roboster2:: ; heuristic: monster picture attribute map; C0
Data_07B_73B5:: ; address name
    db $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $12F (Mimic) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Mimic:: ; heuristic: monster picture attribute map; C0
Data_07B_73D9:: ; address name
    ds $15, $00
    db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $130 (Exaucers) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Exaucers:: ; heuristic: monster picture attribute map; C0
Data_07B_73FD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $135 (GoldGolem) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_GoldGolem:: ; heuristic: monster picture attribute map; C0
Data_07B_7421:: ; address name
    db $00, $01, $01, $01, $00, $00, $01, $01, $01
    ds $1B, $00

; 6 x 6 CGB attribute map of the picture of monster id $136 (DarkMate) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DarkMate:: ; heuristic: monster picture attribute map; C0
Data_07B_7445:: ; address name
    db $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $137 (ProtoMech) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_ProtoMech:: ; heuristic: monster picture attribute map; C0
Data_07B_7469:: ; address name
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $01, $01, $01, $00, $00
    db $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $138 (CloudKing) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_CloudKing:: ; heuristic: monster picture attribute map; C0
Data_07B_748D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $13C (Petiteel) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Petiteel:: ; heuristic: monster picture attribute map; C0
Data_07B_74B1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $01
    db $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $13D (Moray) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Moray:: ; heuristic: monster picture attribute map; C0
Data_07B_74D5:: ; address name
    ds $19, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $140 (Anemon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Anemon:: ; heuristic: monster picture attribute map; C0
Data_07B_74F9:: ; address name
    db $00, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01
    db $01, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $141 (Aquarella) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Aquarella:: ; heuristic: monster picture attribute map; C0
Data_07B_751D:: ; address name
    ds $1B, $00
    db $01, $01, $00, $01, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $143 (Octokid) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Octokid:: ; heuristic: monster picture attribute map; C0
Data_07B_7541:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $00, $00
    db $01, $00, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00, $00
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $144 (PutreFish) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_PutreFish:: ; heuristic: monster picture attribute map; C0
Data_07B_7565:: ; address name
    ds $1A, $00
    db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $146 (Angleron) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Angleron:: ; heuristic: monster picture attribute map; C0
Data_07B_7589:: ; address name
    ds $10, $00
    db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $147 (FishRider) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_FishRider:: ; heuristic: monster picture attribute map; C0
Data_07B_75AD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00
    db $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $148 (RushFish) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_RushFish:: ; heuristic: monster picture attribute map; C0
Data_07B_75D1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $00, $00
    db $00, $00, $01, $01, $01, $00, $01, $01, $00, $01, $01, $01, $01, $00, $00, $00
    db $01, $01, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $149 (Gamanian) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Gamanian:: ; heuristic: monster picture attribute map; C0
Data_07B_75F5:: ; address name
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $01, $00, $00
    db $00, $00, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $14A (Clawster) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Clawster:: ; heuristic: monster picture attribute map; C0
Data_07B_7619:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    ds $15, $00

; 6 x 6 CGB attribute map of the picture of monster id $14C (RogueWave) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_RogueWave:: ; heuristic: monster picture attribute map; C0
Data_07B_763D:: ; address name
    ds $1A, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $14D (Scallopa) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Scallopa:: ; heuristic: monster picture attribute map; C0
Data_07B_7661:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $14F (HoodSquid) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_HoodSquid:: ; heuristic: monster picture attribute map; C0
Data_07B_7685:: ; address name
    db $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00
    db $01, $01, $01
    ds $11, $00

; 6 x 6 CGB attribute map of the picture of monster id $150 (MerTiger) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_MerTiger:: ; heuristic: monster picture attribute map; C0
Data_07B_76A9:: ; address name
    ds $12, $00
    db $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $00, $00, $01, $01
    db $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $151 (AxeShark) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_AxeShark:: ; heuristic: monster picture attribute map; C0
Data_07B_76CD:: ; address name
    ds $18, $00
    db $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $153 (KingSquid) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_KingSquid:: ; heuristic: monster picture attribute map; C0
Data_07B_76F1:: ; address name
    db $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01
    ds $14, $00

; 6 x 6 CGB attribute map of the picture of monster id $154 (Digong) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Digong:: ; heuristic: monster picture attribute map; C0
Data_07B_7715:: ; address name
    ds $12, $00
    db $01, $01, $01, $00, $00, $00, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00
    db $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $155 (WhaleMage) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_WhaleMage:: ; heuristic: monster picture attribute map; C0
Data_07B_7739:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $156 (Aquadon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Aquadon:: ; heuristic: monster picture attribute map; C0
Data_07B_775D:: ; address name
    db $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $01, $01
    ds $18, $00

; 6 x 6 CGB attribute map of the picture of monster id $157 (Octoraid) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Octoraid:: ; heuristic: monster picture attribute map; C0
Data_07B_7781:: ; address name
    db $01, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $01, $01, $01
    db $01, $01, $00, $01, $01, $01, $01, $01, $00, $01, $00, $00, $01, $00, $01, $00
    db $00, $00, $00, $01

; 6 x 6 CGB attribute map of the picture of monster id $158 (Grakos) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Grakos:: ; heuristic: monster picture attribute map; C0
Data_07B_77A5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $01
    db $00, $00, $00, $01, $01, $01, $00, $00, $01, $00, $00, $01, $01, $00, $01, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $159 (Poseidon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Poseidon:: ; heuristic: monster picture attribute map; C0
Data_07B_77C9:: ; address name
    db $00, $01, $00, $00, $01, $00, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $15A (Pumpoise) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Pumpoise:: ; heuristic: monster picture attribute map; C0
Data_07B_77ED:: ; address name
    ds $13, $00
    db $01
    ds $10, $00

; 6 x 6 CGB attribute map of the picture of monster id $15F (DracoLord) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DracoLord:: ; heuristic: monster picture attribute map; C0
Data_07B_7811:: ; address name
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $01
    db $00, $00, $01, $00, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $160 (DracoLord) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DracoLord_160:: ; heuristic: monster picture attribute map; C0
Data_07B_7835:: ; address name
    db $01, $01, $00, $00, $01, $00, $00, $01, $01
    ds $1B, $00

; 6 x 6 CGB attribute map of the picture of monster id $161 (LordDraco) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_LordDraco:: ; heuristic: monster picture attribute map; C0
Data_07B_7859:: ; address name
    ds $14, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $162 (Hargon) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Hargon:: ; heuristic: monster picture attribute map; C0
Data_07B_787D:: ; address name
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $164 (Genosidoh) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Genosidoh:: ; heuristic: monster picture attribute map; C0
Data_07B_78A1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00
    db $00, $01, $01, $00

; 6 x 6 CGB attribute map of the picture of monster id $165 (Baramos) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Baramos:: ; heuristic: monster picture attribute map; C0
Data_07B_78C5:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $01, $00, $00, $01, $00, $01
    db $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $166 (Zoma) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Zoma:: ; heuristic: monster picture attribute map; C0
Data_07B_78E9:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $167 (AsuraZoma) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_AsuraZoma:: ; heuristic: monster picture attribute map; C0
Data_07B_790D:: ; address name
    ds $13, $00
    db $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01
    db $00

; 6 x 6 CGB attribute map of the picture of monster id $169 (PsychoPiz) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_PsychoPiz:: ; heuristic: monster picture attribute map; C0
Data_07B_7931:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00
    db $00, $00, $01, $01, $00, $01, $00, $00, $01, $01, $00, $01, $01, $00, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $16A (Esterk) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Esterk:: ; heuristic: monster picture attribute map; C0
Data_07B_7955:: ; address name
    db $00, $01, $01, $01, $01
    ds $1F, $00

; 6 x 6 CGB attribute map of the picture of monster id $16B (Mirudraas) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Mirudraas:: ; heuristic: monster picture attribute map; C0
Data_07B_7979:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $00, $01, $00, $00
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01
    db $00, $00, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $16D (Mudou) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Mudou:: ; heuristic: monster picture attribute map; C0
Data_07B_799D:: ; address name
    db $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $01, $00, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $01, $01, $00, $01, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $16E (DeathMore) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DeathMore:: ; heuristic: monster picture attribute map; C0
Data_07B_79C1:: ; address name
    db $00, $01, $01, $00, $00, $00, $01, $01, $01, $00, $01, $00, $01, $01, $01, $00
    db $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $170 (DeathMore) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_DeathMore_170:: ; heuristic: monster picture attribute map; C0
Data_07B_79E5:: ; address name
    db $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $171 (Darkdrium) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Darkdrium:: ; heuristic: monster picture attribute map; C0
Data_07B_7A09:: ; address name
    db $00, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01
    db $01, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $172 (Orgodemir) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Orgodemir:: ; heuristic: monster picture attribute map; C0
Data_07B_7A2D:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00

; 6 x 6 CGB attribute map of the picture of monster id $173 (Orgodemir) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Orgodemir_173:: ; heuristic: monster picture attribute map; C0
Data_07B_7A51:: ; address name
    db $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01, $01, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $174 (Darck) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Darck:: ; heuristic: monster picture attribute map; C0
Data_07B_7A75:: ; address name
    db $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $00, $00, $00, $01, $01, $00, $00, $01, $00, $00, $00, $00, $01, $01, $00, $00
    db $00, $00, $00, $01

; 6 x 6 CGB attribute map of the picture of monster id $17C (Lamia) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Lamia:: ; heuristic: monster picture attribute map; C0
Data_07B_7A99:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $17D (Dimensaur) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Dimensaur:: ; heuristic: monster picture attribute map; C0
Data_07B_7ABD:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $01
    db $00, $01, $01, $00, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $01

; 6 x 6 CGB attribute map of the picture of monster id $17E (Kagebou) (MonsterPictureTable / MonsterAttributeMapTable)
MonsterPicAttr_Kagebou:: ; heuristic: monster picture attribute map; C0
Data_07B_7AE1:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    db $01, $00, $00, $01, $01, $01, $01
    ds $508, $00
