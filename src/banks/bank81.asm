SECTION "Bank 81", ROMX[$4000], BANK[$81]
    db $81

; only called from CallFunc4001InBank81KeepRegs (E-0047)
; 1 call site from 1 routine (e.g. CallFunc4001InBank81KeepRegs)
; reads: wRecordBufB, wSpeciesRecord, wAIWeights
; writes: wAIWeights, wSpeciesIdLo, wSpeciesIdHi, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
CallFunc4001InBank81KeepRegs_WriteAIWeightsAndSpeciesIdLoEtc::
Func_081_4001:: ; address name
    ld a, [wRecordBufB + $B]
    ld l, a
    ld a, [wRecordBufB + $C]
    ld h, a
    push hl
    ld a, l
    ld [wAIWeights], a
    ld a, h
    ld [wAIWeights + $1], a
    ld a, [wRecordBufB + $D]
    ld [wAIWeights + $6], a
    ld a, [wRecordBufB + $1A]
    ld l, a
    ld a, [wRecordBufB + $1B]
    ld h, a
    ld a, l
    ld [wAIWeights + $2], a
    ld a, h
    ld [wAIWeights + $3], a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    ld [wAIWeights + $7], a
    ld a, [wRecordBufB + $1C]
    ld l, a
    ld a, [wRecordBufB + $1D]
    ld h, a
    ld a, l
    ld [wAIWeights + $4], a
    ld a, h
    ld [wAIWeights + $5], a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    ld [wAIWeights + $8], a
    ld a, [wAIWeights]
    ld l, a
    ld a, [wAIWeights + $1]
    ld h, a
    add hl, hl
    ld a, l
    add a, $67
    ld l, a
    ld a, h
    adc a, $41
    ld h, a
    deref_hl
    push hl
    ld a, [wAIWeights + $2]
    ld e, a
    ld a, [wAIWeights + $3]
    ld d, a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ld a, [wAIWeights + $4]
    ld e, a
    ld a, [wAIWeights + $5]
    ld d, a
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, [wAIWeights + $7]
    ldh [hTemp4], a
    ld a, [wAIWeights + $8]
    ldh [hTemp5], a
    call CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC
    pop hl
    ld a, c
    or a, a
    jr z, .set_species_id_lo
    ld a, [wAIWeights + $4]
    ld e, a
    ld a, [wAIWeights + $5]
    ld d, a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ld a, [wAIWeights + $2]
    ld e, a
    ld a, [wAIWeights + $3]
    ld d, a
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, [wAIWeights + $8]
    ldh [hTemp4], a
    ld a, [wAIWeights + $7]
    ldh [hTemp5], a
    call CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC
    ld a, c
    or a, a
    jr nz, .set_species_id_lo
    ld a, [wRecordBufB + $D]
    set 4, a
    ld [wRecordBufB + $D], a

.set_species_id_lo:
    pop hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    ret

; only called from CallFunc4001InBank81KeepRegs_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. CallFunc4001InBank81KeepRegs_WriteAIWeightsAndSpeciesIdLoEtc)
; reads: hTemp0, hTemp1, hTemp5, hTemp2, hTemp3, wAIWeights
; points at: hTemp5
CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC::
Func_081_40E2:: ; address name
    ld a, [hl+]
    ld d, [hl]
    inc hl
    cp a, $FF
    jr z, .read_temp0
    cp a, $00
    jr z, .skip
    cp a, $01
    jp z, .skip2
    jr CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC

.read_temp0:
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [wAIWeights]
    ld c, a
    ld a, [wAIWeights + $1]
    ld b, a
    call CompareHLToBC
    jr nz, .done
    ld a, [wAIWeights + $6]
    ld hl, hTemp5
    cp a, [hl]
    jr nz, .done

.loop:
    ld c, $00
    ret

.done:
    ld c, $FF
    ret

.skip:
    ld c, [hl]
    inc hl
    inc hl
    ld a, [wAIWeights + $6]
    cp a, c
    jr z, .loop3

.loop2:
    inc hl
    inc hl
    dec d
    jr nz, .loop2
    jr CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC

.loop3:
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    bit 7, b
    jr nz, .read_temp2
    ldh a, [hTemp5]
    cp a, c
    jp z, .loop
    jr .next

.read_temp2:
    res 7, b
    push hl
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    call CompareHLToBC
    pop hl
    jp z, .loop

.next:
    dec d
    jr nz, .loop3
    jp CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC

.skip2:
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call CompareHLToBC
    pop hl
    jr z, .skip3

.loop4:
    inc hl
    inc hl
    dec d
    jr nz, .loop4
    jp CallFunc4001InBank81KeepRegs_Sub01_CompareHLToBC

.skip3:
    jr .loop3

; E-0223 (C1: the routine at 81:$4001 reads the word at $4167 + 2 * species (parent B's, wRecordBufB + $B) and runs CallFunc4001InBank81KeepRegs_Sub01_Sub01 over it twice, with the two parents swapped; a group of kind 0 applies when its key's low byte equals the family, kind 1 when its key equals the species, and then its words are matched against the other parent; when neither order matches, bit 4 of wRecordBufB + $D is set; 321 words, and the lists tile $43E9-$5453).
; record: pair-check list for this species
SpeciesPairCheckTable::
Data_081_4167:: ; address name
    dw SpeciesPairChecks000 ; id 0
    dw SpeciesPairChecks001 ; id 1 DrakSlime
    dw SpeciesPairChecks002 ; id 2 SpotSlime
    dw SpeciesPairChecks003 ; id 3 WingSlime
    dw SpeciesPairChecks004 ; id 4 TreeSlime
    dw SpeciesPairChecks005 ; id 5 Snaily
    dw SpeciesPairChecks006 ; id 6 SlimeNite
    dw SpeciesPairChecks007 ; id 7 Babble
    dw SpeciesPairChecks008 ; id 8 BoxSlime
    dw SpeciesPairChecks009 ; id 9 PearlGel
    dw SpeciesPairChecks00A ; id 10 Slime
    dw SpeciesPairChecks00B ; id 11 Healer
    dw SpeciesPairChecks00C ; id 12 FangSlime
    dw SpeciesPairChecks00D ; id 13 RockSlime
    dw SpeciesPairChecks00E ; id 14 SlimeBorg
    dw SpeciesPairChecks00F ; id 15 Slabbit
    dw SpeciesPairChecks010 ; id 16 KingSlime
    dw SpeciesPairChecks011 ; id 17 Metaly
    dw SpeciesPairChecks012 ; id 18 Metabble
    dw SpeciesPairChecks013 ; id 19 SpotKing
    dw SpeciesPairChecks014 ; id 20 TropicGel
    dw SpeciesPairChecks015 ; id 21 MimeSlime
    dw SpeciesPairChecks016 ; id 22 HaloSlime
    dw SpeciesPairChecks017 ; id 23 MetalKing
    dw SpeciesPairChecks018 ; id 24 GoldSlime
    dw SpeciesPairChecks019 ; id 25 GranSlime
    dw SpeciesPairChecks01A ; id 26 WonderEgg
    dw SpeciesPairChecks01B ; id 27 Butch
    dw SpeciesPairChecks01C ; id 28 ?
    dw SpeciesPairChecks01D ; id 29 ?
    dw SpeciesPairChecks01E ; id 30 ?
    dw SpeciesPairChecks01F ; id 31 ?
    dw SpeciesPairChecks020 ; id 32 ?
    dw SpeciesPairChecks021 ; id 33 ?
    dw SpeciesPairChecks022 ; id 34 ?
    dw SpeciesPairChecks023 ; id 35 ?
    dw SpeciesPairChecks024 ; id 36 DragonKid
    dw SpeciesPairChecks025 ; id 37 Tortragon
    dw SpeciesPairChecks026 ; id 38 Pteranod
    dw SpeciesPairChecks027 ; id 39 Gasgon
    dw SpeciesPairChecks028 ; id 40 FairyDrak
    dw SpeciesPairChecks029 ; id 41 LizardMan
    dw SpeciesPairChecks02A ; id 42 Poisongon
    dw SpeciesPairChecks02B ; id 43 Swordgon
    dw SpeciesPairChecks02C ; id 44 Drygon
    dw SpeciesPairChecks02D ; id 45 Dragon
    dw SpeciesPairChecks02E ; id 46 MiniDrak
    dw SpeciesPairChecks02F ; id 47 MadDragon
    dw SpeciesPairChecks030 ; id 48 Rayburn
    dw SpeciesPairChecks031 ; id 49 Chamelgon
    dw SpeciesPairChecks032 ; id 50 LizardFly
    dw SpeciesPairChecks033 ; id 51 Andreal
    dw SpeciesPairChecks034 ; id 52 KingCobra
    dw SpeciesPairChecks035 ; id 53 Vampirus
    dw SpeciesPairChecks036 ; id 54 SnakeBat
    dw SpeciesPairChecks037 ; id 55 Spikerous
    dw SpeciesPairChecks038 ; id 56 GreatDrak
    dw SpeciesPairChecks039 ; id 57 Crestpent
    dw SpeciesPairChecks03A ; id 58 WingSnake
    dw SpeciesPairChecks03B ; id 59 Coatol
    dw SpeciesPairChecks03C ; id 60 Orochi
    dw SpeciesPairChecks03D ; id 61 BattleRex
    dw SpeciesPairChecks03E ; id 62 SkyDragon
    dw SpeciesPairChecks03F ; id 63 Serpentia
    dw SpeciesPairChecks040 ; id 64 Divinegon
    dw SpeciesPairChecks041 ; id 65 Orligon
    dw SpeciesPairChecks042 ; id 66 GigaDraco
    dw SpeciesPairChecks043 ; id 67 ?
    dw SpeciesPairChecks044 ; id 68 ?
    dw SpeciesPairChecks045 ; id 69 ?
    dw SpeciesPairChecks046 ; id 70 ?
    dw SpeciesPairChecks047 ; id 71 Tonguella
    dw SpeciesPairChecks048 ; id 72 Almiraj
    dw SpeciesPairChecks049 ; id 73 CatFly
    dw SpeciesPairChecks04A ; id 74 PillowRat
    dw SpeciesPairChecks04B ; id 75 Saccer
    dw SpeciesPairChecks04C ; id 76 GulpBeast
    dw SpeciesPairChecks04D ; id 77 Skullroo
    dw SpeciesPairChecks04E ; id 78 WindBeast
    dw SpeciesPairChecks04F ; id 79 Beavern
    dw SpeciesPairChecks050 ; id 80 Antbear
    dw SpeciesPairChecks051 ; id 81 SuperTen
    dw SpeciesPairChecks052 ; id 82 IronTurt
    dw SpeciesPairChecks053 ; id 83 Mommonja
    dw SpeciesPairChecks054 ; id 84 HammerMan
    dw SpeciesPairChecks055 ; id 85 Grizzly
    dw SpeciesPairChecks056 ; id 86 Yeti
    dw SpeciesPairChecks057 ; id 87 ArrowDog
    dw SpeciesPairChecks058 ; id 88 NoctoKing
    dw SpeciesPairChecks059 ; id 89 BeastNite
    dw SpeciesPairChecks05A ; id 90 MadGopher
    dw SpeciesPairChecks05B ; id 91 FairyRat
    dw SpeciesPairChecks05C ; id 92 Unicorn
    dw SpeciesPairChecks05D ; id 93 Goategon
    dw SpeciesPairChecks05E ; id 94 WildApe
    dw SpeciesPairChecks05F ; id 95 Trumpeter
    dw SpeciesPairChecks060 ; id 96 KingLeo
    dw SpeciesPairChecks061 ; id 97 DarkHorn
    dw SpeciesPairChecks062 ; id 98 MadCat
    dw SpeciesPairChecks063 ; id 99 BigEye
    dw SpeciesPairChecks064 ; id 100 Gorago
    dw SpeciesPairChecks065 ; id 101 CatMage
    dw SpeciesPairChecks066 ; id 102 Dumbira
    dw SpeciesPairChecks067 ; id 103 ?
    dw SpeciesPairChecks068 ; id 104 ?
    dw SpeciesPairChecks069 ; id 105 ?
    dw SpeciesPairChecks06A ; id 106 Picky
    dw SpeciesPairChecks06B ; id 107 Wyvern
    dw SpeciesPairChecks06C ; id 108 BullBird
    dw SpeciesPairChecks06D ; id 109 Florajay
    dw SpeciesPairChecks06E ; id 110 DuckKite
    dw SpeciesPairChecks06F ; id 111 MadPecker
    dw SpeciesPairChecks070 ; id 112 MadRaven
    dw SpeciesPairChecks071 ; id 113 MistyWing
    dw SpeciesPairChecks072 ; id 114 AquaHawk
    dw SpeciesPairChecks073 ; id 115 Dracky
    dw SpeciesPairChecks074 ; id 116 KiteHawk
    dw SpeciesPairChecks075 ; id 117 BigRoost
    dw SpeciesPairChecks076 ; id 118 StubBird
    dw SpeciesPairChecks077 ; id 119 LandOwl
    dw SpeciesPairChecks078 ; id 120 MadGoose
    dw SpeciesPairChecks079 ; id 121 MadCondor
    dw SpeciesPairChecks07A ; id 122 Emyu
    dw SpeciesPairChecks07B ; id 123 Blizzardy
    dw SpeciesPairChecks07C ; id 124 Phoenix
    dw SpeciesPairChecks07D ; id 125 ZapBird
    dw SpeciesPairChecks07E ; id 126 Garudian
    dw SpeciesPairChecks07F ; id 127 WhipBird
    dw SpeciesPairChecks080 ; id 128 FunkyBird
    dw SpeciesPairChecks081 ; id 129 RainHawk
    dw SpeciesPairChecks082 ; id 130 Azurile
    dw SpeciesPairChecks083 ; id 131 Shantak
    dw SpeciesPairChecks084 ; id 132 CragDevil
    dw SpeciesPairChecks085 ; id 133 ?
    dw SpeciesPairChecks086 ; id 134 ?
    dw SpeciesPairChecks087 ; id 135 ?
    dw SpeciesPairChecks088 ; id 136 ?
    dw SpeciesPairChecks089 ; id 137 ?
    dw SpeciesPairChecks08A ; id 138 ?
    dw SpeciesPairChecks08B ; id 139 ?
    dw SpeciesPairChecks08C ; id 140 ?
    dw SpeciesPairChecks08D ; id 141 MadPlant
    dw SpeciesPairChecks08E ; id 142 FireWeed
    dw SpeciesPairChecks08F ; id 143 FloraMan
    dw SpeciesPairChecks090 ; id 144 WingTree
    dw SpeciesPairChecks091 ; id 145 CactiBall
    dw SpeciesPairChecks092 ; id 146 Gulpple
    dw SpeciesPairChecks093 ; id 147 Toadstool
    dw SpeciesPairChecks094 ; id 148 AmberWeed
    dw SpeciesPairChecks095 ; id 149 Slurperon
    dw SpeciesPairChecks096 ; id 150 Stubsuck
    dw SpeciesPairChecks097 ; id 151 Oniono
    dw SpeciesPairChecks098 ; id 152 DanceVegi
    dw SpeciesPairChecks099 ; id 153 TreeBoy
    dw SpeciesPairChecks09A ; id 154 Devipine
    dw SpeciesPairChecks09B ; id 155 FaceTree
    dw SpeciesPairChecks09C ; id 156 HerbMan
    dw SpeciesPairChecks09D ; id 157 BeanMan
    dw SpeciesPairChecks09E ; id 158 EvilSeed
    dw SpeciesPairChecks09F ; id 159 ManEater
    dw SpeciesPairChecks0A0 ; id 160 Snapper
    dw SpeciesPairChecks0A1 ; id 161 GhosTree
    dw SpeciesPairChecks0A2 ; id 162 Rosevine
    dw SpeciesPairChecks0A3 ; id 163 Egdracil
    dw SpeciesPairChecks0A4 ; id 164 Warubou
    dw SpeciesPairChecks0A5 ; id 165 Watabou
    dw SpeciesPairChecks0A6 ; id 166 Eggplaton
    dw SpeciesPairChecks0A7 ; id 167 FooHero
    dw SpeciesPairChecks0A8 ; id 168 ?
    dw SpeciesPairChecks0A9 ; id 169 ?
    dw SpeciesPairChecks0AA ; id 170 ?
    dw SpeciesPairChecks0AB ; id 171 ?
    dw SpeciesPairChecks0AC ; id 172 ?
    dw SpeciesPairChecks0AD ; id 173 ?
    dw SpeciesPairChecks0AE ; id 174 ?
    dw SpeciesPairChecks0AF ; id 175 ?
    dw SpeciesPairChecks0B0 ; id 176 GiantSlug
    dw SpeciesPairChecks0B1 ; id 177 Catapila
    dw SpeciesPairChecks0B2 ; id 178 Gophecada
    dw SpeciesPairChecks0B3 ; id 179 Butterfly
    dw SpeciesPairChecks0B4 ; id 180 WeedBug
    dw SpeciesPairChecks0B5 ; id 181 GiantWorm
    dw SpeciesPairChecks0B6 ; id 182 Lipsy
    dw SpeciesPairChecks0B7 ; id 183 StagBug
    dw SpeciesPairChecks0B8 ; id 184 Pyuro
    dw SpeciesPairChecks0B9 ; id 185 ArmyAnt
    dw SpeciesPairChecks0BA ; id 186 GoHopper
    dw SpeciesPairChecks0BB ; id 187 TailEater
    dw SpeciesPairChecks0BC ; id 188 ArmorPede
    dw SpeciesPairChecks0BD ; id 189 Eyeder
    dw SpeciesPairChecks0BE ; id 190 GiantMoth
    dw SpeciesPairChecks0BF ; id 191 Droll
    dw SpeciesPairChecks0C0 ; id 192 ArmyCrab
    dw SpeciesPairChecks0C1 ; id 193 MadHornet
    dw SpeciesPairChecks0C2 ; id 194 Belzebub
    dw SpeciesPairChecks0C3 ; id 195 WarMantis
    dw SpeciesPairChecks0C4 ; id 196 HornBeet
    dw SpeciesPairChecks0C5 ; id 197 Sickler
    dw SpeciesPairChecks0C6 ; id 198 Armorpion
    dw SpeciesPairChecks0C7 ; id 199 Digster
    dw SpeciesPairChecks0C8 ; id 200 Skularach
    dw SpeciesPairChecks0C9 ; id 201 MultiEyes
    dw SpeciesPairChecks0CA ; id 202 ?
    dw SpeciesPairChecks0CB ; id 203 ?
    dw SpeciesPairChecks0CC ; id 204 ?
    dw SpeciesPairChecks0CD ; id 205 ?
    dw SpeciesPairChecks0CE ; id 206 ?
    dw SpeciesPairChecks0CF ; id 207 ?
    dw SpeciesPairChecks0D0 ; id 208 ?
    dw SpeciesPairChecks0D1 ; id 209 ?
    dw SpeciesPairChecks0D2 ; id 210 ?
    dw SpeciesPairChecks0D3 ; id 211 Pixy
    dw SpeciesPairChecks0D4 ; id 212 MedusaEye
    dw SpeciesPairChecks0D5 ; id 213 AgDevil
    dw SpeciesPairChecks0D6 ; id 214 Demonite
    dw SpeciesPairChecks0D7 ; id 215 DarkEye
    dw SpeciesPairChecks0D8 ; id 216 EyeBall
    dw SpeciesPairChecks0D9 ; id 217 SkulRider
    dw SpeciesPairChecks0DA ; id 218 EvilBeast
    dw SpeciesPairChecks0DB ; id 219 Bubblemon
    dw SpeciesPairChecks0DC ; id 220 1EyeClown
    dw SpeciesPairChecks0DD ; id 221 Gremlin
    dw SpeciesPairChecks0DE ; id 222 ArcDemon
    dw SpeciesPairChecks0DF ; id 223 Lionex
    dw SpeciesPairChecks0E0 ; id 224 GoatHorn
    dw SpeciesPairChecks0E1 ; id 225 Orc
    dw SpeciesPairChecks0E2 ; id 226 Ogre
    dw SpeciesPairChecks0E3 ; id 227 GateGuard
    dw SpeciesPairChecks0E4 ; id 228 ChopClown
    dw SpeciesPairChecks0E5 ; id 229 BossTroll
    dw SpeciesPairChecks0E6 ; id 230 Grendal
    dw SpeciesPairChecks0E7 ; id 231 Akubar
    dw SpeciesPairChecks0E8 ; id 232 MadKnight
    dw SpeciesPairChecks0E9 ; id 233 EvilWell
    dw SpeciesPairChecks0EA ; id 234 Gigantes
    dw SpeciesPairChecks0EB ; id 235 Centasaur
    dw SpeciesPairChecks0EC ; id 236 EvilArmor
    dw SpeciesPairChecks0ED ; id 237 Jamirus
    dw SpeciesPairChecks0EE ; id 238 Durran
    dw SpeciesPairChecks0EF ; id 239 Titanis
    dw SpeciesPairChecks0F0 ; id 240 LampGenie
    dw SpeciesPairChecks0F1 ; id 241 ?
    dw SpeciesPairChecks0F2 ; id 242 ?
    dw SpeciesPairChecks0F3 ; id 243 ?
    dw SpeciesPairChecks0F4 ; id 244 ?
    dw SpeciesPairChecks0F5 ; id 245 ?
    dw SpeciesPairChecks0F6 ; id 246 Spooky
    dw SpeciesPairChecks0F7 ; id 247 Skullgon
    dw SpeciesPairChecks0F8 ; id 248 PutrePup
    dw SpeciesPairChecks0F9 ; id 249 RotRaven
    dw SpeciesPairChecks0FA ; id 250 Mummy
    dw SpeciesPairChecks0FB ; id 251 DarkCrab
    dw SpeciesPairChecks0FC ; id 252 DeadNite
    dw SpeciesPairChecks0FD ; id 253 Shadow
    dw SpeciesPairChecks0FE ; id 254 Skulpent
    dw SpeciesPairChecks0FF ; id 255 Hork
    dw SpeciesPairChecks100 ; id 256 Mudron
    dw SpeciesPairChecks101 ; id 257 NiteWhip
    dw SpeciesPairChecks102 ; id 258 WindMerge
    dw SpeciesPairChecks103 ; id 259 Reaper
    dw SpeciesPairChecks104 ; id 260 Inverzon
    dw SpeciesPairChecks105 ; id 261 FoxFire
    dw SpeciesPairChecks106 ; id 262 CaptDead
    dw SpeciesPairChecks107 ; id 263 DeadNoble
    dw SpeciesPairChecks108 ; id 264 WhiteKing
    dw SpeciesPairChecks109 ; id 265 BoneSlave
    dw SpeciesPairChecks10A ; id 266 Skeletor
    dw SpeciesPairChecks10B ; id 267 Servant
    dw SpeciesPairChecks10C ; id 268 Lazamanus
    dw SpeciesPairChecks10D ; id 269 Copycat
    dw SpeciesPairChecks10E ; id 270 MadSpirit
    dw SpeciesPairChecks10F ; id 271 PomPomBom
    dw SpeciesPairChecks110 ; id 272 Niterich
    dw SpeciesPairChecks111 ; id 273 ?
    dw SpeciesPairChecks112 ; id 274 ?
    dw SpeciesPairChecks113 ; id 275 ?
    dw SpeciesPairChecks114 ; id 276 ?
    dw SpeciesPairChecks115 ; id 277 ?
    dw SpeciesPairChecks116 ; id 278 ?
    dw SpeciesPairChecks117 ; id 279 ?
    dw SpeciesPairChecks118 ; id 280 ?
    dw SpeciesPairChecks119 ; id 281 JewelBag
    dw SpeciesPairChecks11A ; id 282 EvilWand
    dw SpeciesPairChecks11B ; id 283 MadCandle
    dw SpeciesPairChecks11C ; id 284 CoilBird
    dw SpeciesPairChecks11D ; id 285 Facer
    dw SpeciesPairChecks11E ; id 286 SpikyBoy
    dw SpeciesPairChecks11F ; id 287 MadMirror
    dw SpeciesPairChecks120 ; id 288 RogueNite
    dw SpeciesPairChecks121 ; id 289 Puppetor
    dw SpeciesPairChecks122 ; id 290 Goopi
    dw SpeciesPairChecks123 ; id 291 Voodoll
    dw SpeciesPairChecks124 ; id 292 MetalDrak
    dw SpeciesPairChecks125 ; id 293 Balzak
    dw SpeciesPairChecks126 ; id 294 SabreMan
    dw SpeciesPairChecks127 ; id 295 CurseLamp
    dw SpeciesPairChecks128 ; id 296 Brushead
    dw SpeciesPairChecks129 ; id 297 Roboster
    dw SpeciesPairChecks12A ; id 298 Roboster2
    dw SpeciesPairChecks12B ; id 299 EvilPot
    dw SpeciesPairChecks12C ; id 300 Gismo
    dw SpeciesPairChecks12D ; id 301 LavaMan
    dw SpeciesPairChecks12E ; id 302 IceMan
    dw SpeciesPairChecks12F ; id 303 Mimic
    dw SpeciesPairChecks130 ; id 304 Exaucers
    dw SpeciesPairChecks131 ; id 305 MudDoll
    dw SpeciesPairChecks132 ; id 306 Golem
    dw SpeciesPairChecks133 ; id 307 StoneMan
    dw SpeciesPairChecks134 ; id 308 BombCrag
    dw SpeciesPairChecks135 ; id 309 GoldGolem
    dw SpeciesPairChecks136 ; id 310 DarkMate
    dw SpeciesPairChecks137 ; id 311 ProtoMech
    dw SpeciesPairChecks138 ; id 312 CloudKing
    dw SpeciesPairChecks139 ; id 313 ?
    dw SpeciesPairChecks13A ; id 314 ?
    dw SpeciesPairChecks13B ; id 315 ?
    dw SpeciesPairChecks13C ; id 316 Petiteel
    dw SpeciesPairChecks13D ; id 317 Moray
    dw SpeciesPairChecks13E ; id 318 WalrusMan
    dw SpeciesPairChecks13F ; id 319 RayGigas
    dw SpeciesPairChecks140 ; id 320 Anemon

; E-0199 (derived: list for entry $00 of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks000::
Data_081_43E9:: ; address name
    db $FF, $FF ; id 0

; E-0199 (derived: list for entry $01 (DrakSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks001::
Data_081_43EB:: ; address name
    db $00, $01, $00, $00, $01, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $02 (SpotSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks002::
Data_081_43F3:: ; address name
    db $00, $01, $00, $00, $02, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $03 (WingSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks003::
Data_081_43FB:: ; address name
    db $00, $01, $00, $00, $03, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $04 (TreeSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks004::
Data_081_4403:: ; address name
    db $00, $01, $00, $00, $04, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $05 (Snaily) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks005::
Data_081_440B:: ; address name
    db $00, $01, $00, $00, $05, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $06 (SlimeNite) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks006::
Data_081_4413:: ; address name
    db $00, $01, $00, $00, $06, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $07 (Babble) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks007::
Data_081_441B:: ; address name
    db $00, $03, $00, $00, $07, $00, $BE, $80, $2A, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $08 (BoxSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks008::
Data_081_4427:: ; address name
    db $00, $01, $00, $00, $08, $00, $FF, $00 ; id 0

; E-0199 (derived: list for entry $09 (PearlGel) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks009::
Data_081_442F:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $0A (Slime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks00A::
Data_081_4431:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $0B (Healer) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks00B::
Data_081_4433:: ; address name
    db $00, $04, $00, $00, $4A, $80, $80, $80, $8D, $80, $0D, $81, $FF, $00 ; id 0

; E-0199 (derived: list for entry $0C (FangSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks00C::
Data_081_4441:: ; address name
    db $00, $06, $00, $00, $48, $80, $62, $80, $60, $80, $4C, $80, $61, $80, $5F, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $0D (RockSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks00D::
Data_081_4453:: ; address name
    db $00, $05, $00, $00, $33, $81, $32, $81, $FC, $80, $C7, $80, $34, $81, $FF, $00 ; id 0

; E-0199 (derived: list for entry $0E (SlimeBorg) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks00E::
Data_081_4463:: ; address name
    db $01, $05, $0D, $00, $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $01, $05, $06, $00, $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $01, $05, $01, $00, $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $01, $05, $12, $00, $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $00, $01, $00, $00, $29, $81, $FF, $00 ; id 0

; E-0199 (derived: list for entry $0F (Slabbit) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks00F::
Data_081_44A3:: ; address name
    db $00, $01, $00, $00, $4D, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $10 (KingSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks010::
Data_081_44AB:: ; address name
    db $01, $01, $0A, $00, $0A, $80, $00, $01, $00, $00, $0A, $00, $01, $0C, $0E, $00, $EA, $80, $60, $80, $38, $80, $7D, $80, $07, $81, $40, $80, $EB, $80, $3D, $80, $79, $80, $5C, $80, $7F, $80, $08, $81, $FF, $00 ; id 0

; E-0199 (derived: list for entry $11 (Metaly) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks011::
Data_081_44D5:: ; address name
    db $00, $01, $00, $00, $24, $81, $FF, $00 ; id 0

; E-0199 (derived: list for entry $12 (Metabble) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks012::
Data_081_44DD:: ; address name
    db $01, $01, $11, $00, $11, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $13 (SpotKing) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks013::
Data_081_44E5:: ; address name
    db $01, $0C, $10, $00, $EA, $80, $60, $80, $38, $80, $7D, $80, $07, $81, $40, $80, $EB, $80, $3D, $80, $79, $80, $5C, $80, $7F, $80, $08, $81, $01, $0C, $17, $00, $EA, $80, $60, $80, $38, $80, $7D, $80, $07, $81, $40, $80, $EB, $80, $3D, $80, $79, $80, $5C, $80, $7F, $80, $08, $81, $01, $01, $02, $00, $02, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $14 (TropicGel) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks014::
Data_081_4525:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $15 (MimeSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks015::
Data_081_4527:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $16 (HaloSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks016::
Data_081_4529:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $17 (MetalKing) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks017::
Data_081_452B:: ; address name
    db $01, $01, $10, $00, $24, $81, $01, $01, $13, $00, $24, $81, $01, $01, $12, $00, $12, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $18 (GoldSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks018::
Data_081_453F:: ; address name
    db $01, $01, $10, $00, $35, $81, $01, $01, $13, $00, $35, $81, $01, $02, $17, $00, $35, $81, $17, $80, $FF, $00 ; id 0

; E-0199 (derived: list for entry $19 (GranSlime) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks019::
Data_081_4555:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $1A (WonderEgg) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks01A::
Data_081_4557:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $1B (Butch) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks01B::
Data_081_4559:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $1C (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks01C::
Data_081_455B:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $1D (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks01D::
Data_081_455D:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $1E (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks01E::
Data_081_455F:: ; address name
    db $FF, $00 ; id 0

; E-0199 (derived: list for entry $1F (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks01F::
Data_081_4561:: ; address name
    db $00, $01, $01, $00, $00, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $20 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks020::
Data_081_4569:: ; address name
    db $00, $01, $01, $00, $02, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $21 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks021::
Data_081_4571:: ; address name
    db $00, $01, $01, $00, $03, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $22 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks022::
Data_081_4579:: ; address name
    db $00, $01, $01, $00, $04, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $23 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks023::
Data_081_4581:: ; address name
    db $00, $01, $01, $00, $05, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $24 (DragonKid) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks024::
Data_081_4589:: ; address name
    db $00, $01, $01, $00, $06, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $25 (Tortragon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks025::
Data_081_4591:: ; address name
    db $00, $01, $01, $00, $07, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $26 (Pteranod) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks026::
Data_081_4599:: ; address name
    db $00, $01, $01, $00, $08, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $27 (Gasgon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks027::
Data_081_45A1:: ; address name
    db $FF, $01 ; id 0

; E-0199 (derived: list for entry $28 (FairyDrak) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks028::
Data_081_45A3:: ; address name
    db $01, $01, $1F, $00, $24, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $29 (LizardMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks029::
Data_081_45AB:: ; address name
    db $00, $01, $01, $00, $6A, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $2A (Poisongon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks02A::
Data_081_45B3:: ; address name
    db $00, $01, $01, $00, $4C, $80, $01, $01, $22, $00, $02, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $2B (Swordgon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks02B::
Data_081_45C1:: ; address name
    db $00, $01, $01, $00, $79, $80, $01, $08, $24, $00, $E0, $80, $EA, $80, $62, $80, $E3, $80, $9B, $80, $5F, $80, $03, $80, $DF, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $2C (Drygon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks02C::
Data_081_45DD:: ; address name
    db $00, $01, $01, $00, $23, $81, $FF, $01 ; id 0

; E-0199 (derived: list for entry $2D (Dragon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks02D::
Data_081_45E5:: ; address name
    db $00, $01, $01, $00, $BA, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $2E (MiniDrak) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks02E::
Data_081_45ED:: ; address name
    db $00, $01, $01, $00, $92, $80, $01, $0C, $39, $00, $DE, $80, $E7, $80, $E0, $80, $E2, $80, $5D, $80, $32, $81, $07, $81, $5F, $80, $80, $80, $79, $80, $DF, $80, $7F, $80, $01, $0C, $2A, $00, $DE, $80, $E7, $80, $E0, $80, $E2, $80, $5D, $80, $32, $81, $07, $81, $5F, $80, $80, $80, $79, $80, $DF, $80, $7F, $80, $01, $0C, $38, $00, $DE, $80, $E7, $80, $E0, $80, $E2, $80, $5D, $80, $32, $81, $07, $81, $5F, $80, $80, $80, $79, $80, $DF, $80, $7F, $80, $01, $0C, $22, $00, $DE, $80, $E7, $80, $E0, $80, $E2, $80, $5D, $80, $32, $81, $07, $81, $5F, $80, $80, $80, $79, $80, $DF, $80, $7F, $80, $00, $01, $01, $00, $92, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $2F (MadDragon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks02F::
Data_081_466B:: ; address name
    db $00, $01, $01, $00, $07, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $30 (Rayburn) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks030::
Data_081_4673:: ; address name
    db $FF, $01 ; id 0

; E-0199 (derived: list for entry $31 (Chamelgon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks031::
Data_081_4675:: ; address name
    db $FF, $01 ; id 0

; E-0199 (derived: list for entry $32 (LizardFly) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks032::
Data_081_4677:: ; address name
    db $00, $02, $01, $00, $C0, $80, $C7, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $33 (Andreal) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks033::
Data_081_4681:: ; address name
    db $01, $01, $28, $00, $2D, $80, $01, $01, $1F, $00, $24, $80, $00, $09, $01, $00, $EA, $80, $10, $80, $7D, $80, $EB, $80, $3D, $80, $13, $80, $17, $80, $5C, $80, $7F, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $34 (KingCobra) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks034::
Data_081_46A5:: ; address name
    db $00, $01, $01, $00, $75, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $35 (Vampirus) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks035::
Data_081_46AD:: ; address name
    db $01, $01, $34, $00, $39, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $36 (SnakeBat) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks036::
Data_081_46B5:: ; address name
    db $01, $01, $35, $00, $3A, $80, $01, $04, $39, $00, $E8, $80, $33, $81, $61, $80, $0D, $81, $01, $04, $38, $00, $E8, $80, $33, $81, $61, $80, $0D, $81, $01, $04, $22, $00, $E8, $80, $33, $81, $61, $80, $0D, $81, $01, $04, $21, $00, $E8, $80, $33, $81, $61, $80, $0D, $81, $01, $04, $24, $00, $E8, $80, $33, $81, $61, $80, $0D, $81, $FF, $01 ; id 0

; E-0199 (derived: list for entry $37 (Spikerous) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks037::
Data_081_46F9:: ; address name
    db $01, $01, $2E, $00, $D4, $80, $01, $01, $33, $00, $D4, $80, $00, $01, $01, $00, $0A, $00, $FF, $01 ; id 0

; E-0199 (derived: list for entry $38 (GreatDrak) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks038::
Data_081_470D:: ; address name
    db $00, $05, $01, $00, $E8, $80, $E2, $80, $60, $80, $EC, $80, $DF, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $39 (Crestpent) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks039::
Data_081_471D:: ; address name
    db $00, $01, $01, $00, $7C, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $3A (WingSnake) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks03A::
Data_081_4725:: ; address name
    db $FF, $01 ; id 0

; E-0199 (derived: list for entry $3B (Coatol) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks03B::
Data_081_4727:: ; address name
    db $01, $01, $39, $00, $3C, $80, $FF, $01 ; id 0

; E-0199 (derived: list for entry $3C (Orochi) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks03C::
Data_081_472F:: ; address name
    db $FF, $01 ; id 0

; E-0199 (derived: list for entry $3D (BattleRex) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks03D::
Data_081_4731:: ; address name
    db $00, $01, $02, $00, $00, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $3E (SkyDragon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks03E::
Data_081_4739:: ; address name
    db $00, $01, $02, $00, $01, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $3F (Serpentia) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks03F::
Data_081_4741:: ; address name
    db $00, $01, $02, $00, $03, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $40 (Divinegon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks040::
Data_081_4749:: ; address name
    db $00, $01, $02, $00, $04, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $41 (Orligon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks041::
Data_081_4751:: ; address name
    db $00, $01, $02, $00, $05, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $42 (GigaDraco) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks042::
Data_081_4759:: ; address name
    db $01, $06, $48, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $01, $0C, $4C, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $0A, $81, $07, $81, $F7, $80, $C7, $80, $08, $81, $01, $00, $01, $0B, $54, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $0A, $81, $07, $81, $F7, $80, $C7, $80, $08, $81, $01, $0D, $4B, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $0A, $81, $07, $81, $F7, $80, $C7, $80, $08, $81, $01, $00, $06, $00, $01, $06, $53, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $01, $0B, $52, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $0A, $81, $07, $81, $F7, $80, $C7, $80, $08, $81, $01, $06, $55, $00, $0A, $81, $07, $81, $F7, $80, $C7, $80, $08, $81, $01, $00, $01, $05, $3D, $00, $0A, $81, $07, $81, $F7, $80, $C7, $80, $08, $81, $01, $01, $59, $00, $01, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $43 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks043::
Data_081_480D:: ; address name
    db $00, $01, $02, $00, $07, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $44 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks044::
Data_081_4815:: ; address name
    db $01, $01, $3F, $00, $03, $00, $00, $01, $02, $00, $08, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $45 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks045::
Data_081_4823:: ; address name
    db $FF, $02 ; id 0

; E-0199 (derived: list for entry $46 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks046::
Data_081_4825:: ; address name
    db $01, $01, $41, $00, $01, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $47 (Tonguella) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks047::
Data_081_482D:: ; address name
    db $01, $0C, $42, $00, $19, $81, $DD, $80, $9B, $80, $04, $80, $0C, $80, $2F, $80, $80, $80, $D6, $80, $8D, $80, $0D, $81, $2F, $81, $B6, $80, $01, $0C, $3D, $00, $19, $81, $DD, $80, $9B, $80, $04, $80, $0C, $80, $2F, $80, $80, $80, $D6, $80, $8D, $80, $0D, $81, $2F, $81, $B6, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $48 (Almiraj) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks048::
Data_081_4867:: ; address name
    db $00, $01, $02, $00, $25, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $49 (CatFly) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks049::
Data_081_486F:: ; address name
    db $00, $01, $02, $00, $6E, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $4A (PillowRat) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks04A::
Data_081_4877:: ; address name
    db $00, $01, $02, $00, $96, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $4B (Saccer) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks04B::
Data_081_487F:: ; address name
    db $00, $07, $02, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81, $06, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $4C (GulpBeast) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks04C::
Data_081_4893:: ; address name
    db $01, $06, $48, $00, $3E, $80, $2B, $80, $2F, $80, $3D, $80, $27, $80, $26, $80, $01, $06, $54, $00, $3E, $80, $2B, $80, $2F, $80, $3D, $80, $27, $80, $26, $80, $01, $06, $58, $00, $3E, $80, $2B, $80, $2F, $80, $3D, $80, $27, $80, $26, $80, $01, $06, $53, $00, $3E, $80, $2B, $80, $2F, $80, $3D, $80, $27, $80, $26, $80, $00, $01, $02, $00, $E1, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $4D (Skullroo) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks04D::
Data_081_48DB:: ; address name
    db $FF, $02 ; id 0

; E-0199 (derived: list for entry $4E (WindBeast) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks04E::
Data_081_48DD:: ; address name
    db $FF, $02 ; id 0

; E-0199 (derived: list for entry $4F (Beavern) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks04F::
Data_081_48DF:: ; address name
    db $FF, $02 ; id 0

; E-0199 (derived: list for entry $50 (Antbear) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks050::
Data_081_48E1:: ; address name
    db $00, $01, $02, $00, $26, $81, $FF, $02 ; id 0

; E-0199 (derived: list for entry $51 (SuperTen) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks051::
Data_081_48E9:: ; address name
    db $00, $01, $02, $00, $32, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $52 (IronTurt) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks052::
Data_081_48F1:: ; address name
    db $01, $01, $4C, $00, $00, $00, $01, $01, $54, $00, $00, $00, $01, $01, $4B, $00, $00, $00, $01, $01, $53, $00, $00, $00, $01, $01, $42, $00, $00, $00, $01, $01, $55, $00, $00, $00, $01, $01, $3D, $00, $00, $00, $00, $01, $02, $00, $0C, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $53 (Mommonja) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks053::
Data_081_4923:: ; address name
    db $00, $02, $02, $00, $01, $80, $29, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $54 (HammerMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks054::
Data_081_492D:: ; address name
    db $01, $01, $3E, $00, $01, $00, $00, $01, $02, $00, $6F, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $55 (Grizzly) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks055::
Data_081_493B:: ; address name
    db $01, $04, $4C, $00, $7D, $80, $79, $80, $77, $80, $7F, $80, $01, $04, $4B, $00, $7D, $80, $79, $80, $77, $80, $7F, $80, $01, $0B, $42, $00, $7D, $80, $79, $80, $77, $80, $7F, $80, $33, $81, $29, $81, $32, $81, $25, $81, $2E, $81, $24, $81, $2D, $81, $01, $04, $3D, $00, $7D, $80, $79, $80, $77, $80, $7F, $80, $01, $01, $54, $00, $5E, $80, $01, $01, $47, $00, $01, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $56 (Yeti) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks056::
Data_081_4987:: ; address name
    db $01, $06, $01, $01, $62, $80, $51, $80, $4C, $80, $61, $80, $5F, $80, $5C, $80, $01, $04, $55, $00, $35, $81, $5F, $80, $25, $81, $24, $81, $FF, $02 ; id 0

; E-0199 (derived: list for entry $57 (ArrowDog) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks057::
Data_081_49A5:: ; address name
    db $00, $01, $02, $00, $0A, $00, $FF, $02 ; id 0

; E-0199 (derived: list for entry $58 (NoctoKing) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks058::
Data_081_49AD:: ; address name
    db $00, $01, $02, $00, $2D, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $59 (BeastNite) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks059::
Data_081_49B5:: ; address name
    db $00, $01, $02, $00, $D8, $80, $FF, $02 ; id 0

; E-0199 (derived: list for entry $5A (MadGopher) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks05A::
Data_081_49BD:: ; address name
    db $FF, $02 ; id 0

; E-0199 (derived: list for entry $5B (FairyRat) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks05B::
Data_081_49BF:: ; address name
    db $00, $01, $03, $00, $00, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $5C (Unicorn) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks05C::
Data_081_49C7:: ; address name
    db $00, $01, $03, $00, $01, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $5D (Goategon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks05D::
Data_081_49CF:: ; address name
    db $00, $01, $03, $00, $02, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $5E (WildApe) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks05E::
Data_081_49D7:: ; address name
    db $00, $01, $03, $00, $04, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $5F (Trumpeter) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks05F::
Data_081_49DF:: ; address name
    db $00, $01, $03, $00, $05, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $60 (KingLeo) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks060::
Data_081_49E7:: ; address name
    db $00, $01, $03, $00, $06, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $61 (DarkHorn) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks061::
Data_081_49EF:: ; address name
    db $00, $01, $03, $00, $07, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $62 (MadCat) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks062::
Data_081_49F7:: ; address name
    db $00, $01, $03, $00, $08, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $63 (BigEye) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks063::
Data_081_49FF:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $64 (Gorago) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks064::
Data_081_4A01:: ; address name
    db $01, $01, $5B, $00, $00, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $65 (CatMage) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks065::
Data_081_4A09:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $66 (Dumbira) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks066::
Data_081_4A0B:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $67 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks067::
Data_081_4A0D:: ; address name
    db $00, $01, $03, $00, $0D, $80, $FF, $03 ; id 0

; E-0199 (derived: list for entry $68 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks068::
Data_081_4A15:: ; address name
    db $01, $01, $5D, $00, $02, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $69 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks069::
Data_081_4A1D:: ; address name
    db $01, $02, $5C, $00, $07, $00, $01, $00, $01, $02, $6D, $00, $07, $00, $01, $00, $01, $02, $6A, $00, $07, $00, $01, $00, $01, $02, $69, $00, $07, $00, $01, $00, $00, $01, $03, $00, $BF, $80, $FF, $03 ; id 0

; E-0199 (derived: list for entry $6A (Picky) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks06A::
Data_081_4A45:: ; address name
    db $01, $01, $68, $00, $06, $00, $00, $01, $03, $00, $1C, $81, $FF, $03 ; id 0

; E-0199 (derived: list for entry $6B (Wyvern) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks06B::
Data_081_4A53:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $6C (BullBird) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks06C::
Data_081_4A55:: ; address name
    db $00, $0C, $03, $00, $56, $80, $0A, $81, $5D, $80, $07, $81, $51, $80, $F7, $80, $5F, $80, $12, $80, $2E, $81, $0B, $81, $11, $80, $08, $81, $FF, $03 ; id 0

; E-0199 (derived: list for entry $6D (Florajay) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks06D::
Data_081_4A73:: ; address name
    db $00, $08, $03, $00, $DE, $80, $52, $80, $2C, $81, $55, $80, $4C, $80, $01, $80, $0D, $81, $2D, $81, $FF, $03 ; id 0

; E-0199 (derived: list for entry $6E (DuckKite) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks06E::
Data_081_4A89:: ; address name
    db $01, $01, $6D, $00, $2C, $81, $01, $01, $6A, $00, $2C, $81, $01, $01, $70, $00, $2C, $81, $00, $01, $03, $00, $0A, $00, $FF, $03 ; id 0

; E-0199 (derived: list for entry $6F (MadPecker) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks06F::
Data_081_4AA3:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $70 (MadRaven) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks070::
Data_081_4AA5:: ; address name
    db $01, $06, $69, $00, $33, $81, $32, $81, $0D, $80, $0E, $80, $C7, $80, $24, $81, $01, $06, $6E, $00, $33, $81, $32, $81, $0D, $80, $0E, $80, $C7, $80, $24, $81, $01, $06, $6A, $00, $33, $81, $32, $81, $0D, $80, $0E, $80, $C7, $80, $24, $81, $01, $06, $6C, $00, $33, $81, $32, $81, $0D, $80, $0E, $80, $C7, $80, $24, $81, $01, $06, $68, $00, $33, $81, $32, $81, $0D, $80, $0E, $80, $C7, $80, $24, $81, $00, $01, $03, $00, $98, $80, $FF, $03 ; id 0

; E-0199 (derived: list for entry $71 (MistyWing) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks071::
Data_081_4AFD:: ; address name
    db $00, $01, $03, $00, $98, $80, $FF, $03 ; id 0

; E-0199 (derived: list for entry $72 (AquaHawk) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks072::
Data_081_4B05:: ; address name
    db $01, $01, $6C, $00, $7C, $80, $FF, $03 ; id 0

; E-0199 (derived: list for entry $73 (Dracky) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks073::
Data_081_4B0D:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $74 (KiteHawk) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks074::
Data_081_4B0F:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $75 (BigRoost) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks075::
Data_081_4B11:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $76 (StubBird) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks076::
Data_081_4B13:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $77 (LandOwl) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks077::
Data_081_4B15:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $78 (MadGoose) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks078::
Data_081_4B17:: ; address name
    db $FF, $03 ; id 0

; E-0199 (derived: list for entry $79 (MadCondor) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks079::
Data_081_4B19:: ; address name
    db $00, $01, $04, $00, $00, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $7A (Emyu) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks07A::
Data_081_4B21:: ; address name
    db $00, $01, $04, $00, $01, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $7B (Blizzardy) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks07B::
Data_081_4B29:: ; address name
    db $00, $01, $04, $00, $03, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $7C (Phoenix) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks07C::
Data_081_4B31:: ; address name
    db $00, $01, $04, $00, $02, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $7D (ZapBird) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks07D::
Data_081_4B39:: ; address name
    db $00, $01, $04, $00, $05, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $7E (Garudian) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks07E::
Data_081_4B41:: ; address name
    db $00, $01, $04, $00, $06, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $7F (WhipBird) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks07F::
Data_081_4B49:: ; address name
    db $00, $01, $04, $00, $07, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $80 (FunkyBird) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks080::
Data_081_4B51:: ; address name
    db $00, $01, $04, $00, $08, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $81 (RainHawk) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks081::
Data_081_4B59:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $82 (Azurile) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks082::
Data_081_4B5B:: ; address name
    db $01, $01, $80, $00, $02, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $83 (Shantak) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks083::
Data_081_4B63:: ; address name
    db $00, $01, $04, $00, $B2, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $84 (CragDevil) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks084::
Data_081_4B6B:: ; address name
    db $01, $01, $79, $00, $02, $00, $00, $01, $04, $00, $1D, $81, $FF, $04 ; id 0

; E-0199 (derived: list for entry $85 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks085::
Data_081_4B79:: ; address name
    db $00, $01, $04, $00, $D3, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $86 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks086::
Data_081_4B81:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $87 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks087::
Data_081_4B83:: ; address name
    db $01, $01, $88, $00, $01, $00, $00, $01, $04, $00, $01, $81, $FF, $04 ; id 0

; E-0199 (derived: list for entry $88 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks088::
Data_081_4B91:: ; address name
    db $01, $01, $84, $00, $06, $00, $00, $01, $04, $00, $80, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $89 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks089::
Data_081_4B9F:: ; address name
    db $00, $01, $04, $00, $4A, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $8A (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks08A::
Data_081_4BA7:: ; address name
    db $00, $08, $04, $00, $1F, $81, $D8, $80, $B3, $80, $D7, $80, $0D, $80, $6E, $80, $63, $80, $BD, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $8B (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks08B::
Data_081_4BBD:: ; address name
    db $01, $01, $8A, $00, $9E, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $8C (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks08C::
Data_081_4BC5:: ; address name
    db $01, $01, $8B, $00, $9F, $80, $FF, $04 ; id 0

; E-0199 (derived: list for entry $8D (MadPlant) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks08D::
Data_081_4BCD:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $8E (FireWeed) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks08E::
Data_081_4BCF:: ; address name
    db $00, $01, $04, $00, $0A, $00, $FF, $04 ; id 0

; E-0199 (derived: list for entry $8F (FloraMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks08F::
Data_081_4BD7:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $90 (WingTree) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks090::
Data_081_4BD9:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $91 (CactiBall) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks091::
Data_081_4BDB:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $92 (Gulpple) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks092::
Data_081_4BDD:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $93 (Toadstool) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks093::
Data_081_4BDF:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $94 (AmberWeed) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks094::
Data_081_4BE1:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $95 (Slurperon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks095::
Data_081_4BE3:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $96 (Stubsuck) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks096::
Data_081_4BE5:: ; address name
    db $FF, $04 ; id 0

; E-0199 (derived: list for entry $97 (Oniono) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks097::
Data_081_4BE7:: ; address name
    db $00, $01, $05, $00, $00, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $98 (DanceVegi) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks098::
Data_081_4BEF:: ; address name
    db $00, $01, $05, $00, $01, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $99 (TreeBoy) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks099::
Data_081_4BF7:: ; address name
    db $00, $01, $05, $00, $02, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $9A (Devipine) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks09A::
Data_081_4BFF:: ; address name
    db $00, $01, $05, $00, $03, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $9B (FaceTree) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks09B::
Data_081_4C07:: ; address name
    db $00, $01, $05, $00, $04, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $9C (HerbMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks09C::
Data_081_4C0F:: ; address name
    db $00, $01, $05, $00, $06, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $9D (BeanMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks09D::
Data_081_4C17:: ; address name
    db $00, $01, $05, $00, $07, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $9E (EvilSeed) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks09E::
Data_081_4C1F:: ; address name
    db $00, $01, $05, $00, $08, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $9F (ManEater) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks09F::
Data_081_4C27:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $A0 (Snapper) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A0::
Data_081_4C29:: ; address name
    db $01, $01, $97, $00, $00, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A1 (GhosTree) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A1::
Data_081_4C31:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $A2 (Rosevine) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A2::
Data_081_4C33:: ; address name
    db $01, $01, $9B, $00, $04, $00, $00, $01, $05, $00, $8F, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A3 (Egdracil) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A3::
Data_081_4C41:: ; address name
    db $01, $01, $9C, $00, $08, $00, $01, $01, $A6, $00, $01, $00, $00, $01, $05, $00, $52, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A4 (Warubou) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A4::
Data_081_4C55:: ; address name
    db $01, $01, $98, $00, $02, $00, $00, $01, $05, $00, $94, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A5 (Watabou) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A5::
Data_081_4C63:: ; address name
    db $01, $01, $9A, $00, $06, $00, $00, $01, $05, $00, $4B, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A6 (Eggplaton) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A6::
Data_081_4C71:: ; address name
    db $01, $03, $9A, $00, $B3, $80, $BB, $80, $BD, $80, $01, $03, $A2, $00, $B3, $80, $BB, $80, $BD, $80, $01, $03, $A4, $00, $B3, $80, $BB, $80, $BD, $80, $01, $01, $9D, $00, $00, $00, $00, $01, $05, $00, $F6, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A7 (FooHero) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A7::
Data_081_4C9D:: ; address name
    db $00, $01, $05, $00, $FB, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A8 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A8::
Data_081_4CA5:: ; address name
    db $01, $01, $A6, $00, $07, $00, $01, $01, $A4, $00, $07, $00, $00, $01, $05, $00, $5B, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $A9 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0A9::
Data_081_4CB9:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $AA (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0AA::
Data_081_4CBB:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $AB (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0AB::
Data_081_4CBD:: ; address name
    db $01, $01, $9E, $00, $B7, $80, $01, $01, $A3, $00, $06, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $AC (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0AC::
Data_081_4CCB:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $AD (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0AD::
Data_081_4CCD:: ; address name
    db $01, $01, $AB, $00, $C4, $80, $FF, $05 ; id 0

; E-0199 (derived: list for entry $AE (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0AE::
Data_081_4CD5:: ; address name
    db $00, $01, $05, $00, $0A, $00, $FF, $05 ; id 0

; E-0199 (derived: list for entry $AF (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0AF::
Data_081_4CDD:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $B0 (GiantSlug) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B0::
Data_081_4CDF:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $B1 (Catapila) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B1::
Data_081_4CE1:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $B2 (Gophecada) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B2::
Data_081_4CE3:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $B3 (Butterfly) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B3::
Data_081_4CE5:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $B4 (WeedBug) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B4::
Data_081_4CE7:: ; address name
    db $FF, $05 ; id 0

; E-0199 (derived: list for entry $B5 (GiantWorm) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B5::
Data_081_4CE9:: ; address name
    db $00, $01, $06, $00, $00, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $B6 (Lipsy) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B6::
Data_081_4CF1:: ; address name
    db $01, $0C, $CC, $00, $33, $80, $33, $81, $10, $80, $60, $80, $38, $80, $7D, $80, $5F, $80, $13, $80, $17, $80, $24, $81, $3C, $80, $7F, $80, $01, $0C, $C8, $00, $33, $80, $33, $81, $10, $80, $60, $80, $38, $80, $7D, $80, $5F, $80, $13, $80, $17, $80, $24, $81, $3C, $80, $7F, $80, $01, $0C, $B7, $00, $33, $80, $33, $81, $10, $80, $60, $80, $38, $80, $7D, $80, $5F, $80, $13, $80, $17, $80, $24, $81, $3C, $80, $7F, $80, $01, $01, $C4, $00, $01, $00, $01, $01, $C5, $00, $07, $00, $00, $01, $06, $00, $0A, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $B7 (StagBug) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B7::
Data_081_4D59:: ; address name
    db $01, $01, $BF, $00, $01, $00, $01, $01, $BB, $00, $01, $00, $01, $01, $BC, $00, $01, $00, $01, $01, $C0, $00, $01, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $B8 (Pyuro) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B8::
Data_081_4D73:: ; address name
    db $00, $01, $06, $00, $03, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $B9 (ArmyAnt) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0B9::
Data_081_4D7B:: ; address name
    db $00, $01, $06, $00, $04, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $BA (GoHopper) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0BA::
Data_081_4D83:: ; address name
    db $00, $01, $06, $00, $05, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $BB (TailEater) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0BB::
Data_081_4D8B:: ; address name
    db $00, $01, $06, $00, $07, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $BC (ArmorPede) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0BC::
Data_081_4D93:: ; address name
    db $00, $01, $06, $00, $08, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $BD (Eyeder) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0BD::
Data_081_4D9B:: ; address name
    db $FF, $06 ; id 0

; E-0199 (derived: list for entry $BE (GiantMoth) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0BE::
Data_081_4D9D:: ; address name
    db $01, $01, $BA, $00, $00, $00, $01, $01, $B5, $00, $00, $00, $01, $01, $B8, $00, $00, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $BF (Droll) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0BF::
Data_081_4DB1:: ; address name
    db $00, $01, $06, $00, $02, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C0 (ArmyCrab) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C0::
Data_081_4DB9:: ; address name
    db $01, $01, $BF, $00, $07, $00, $01, $01, $B9, $00, $07, $00, $01, $01, $BE, $00, $07, $00, $00, $01, $06, $00, $01, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C1 (MadHornet) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C1::
Data_081_4DD3:: ; address name
    db $01, $01, $B6, $00, $07, $00, $00, $01, $06, $00, $29, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C2 (Belzebub) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C2::
Data_081_4DE1:: ; address name
    db $01, $01, $B6, $00, $02, $00, $00, $01, $06, $00, $61, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C3 (WarMantis) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C3::
Data_081_4DEF:: ; address name
    db $00, $01, $06, $00, $9D, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C4 (HornBeet) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C4::
Data_081_4DF7:: ; address name
    db $01, $04, $CC, $00, $29, $81, $4C, $80, $C7, $80, $5C, $80, $01, $04, $C8, $00, $29, $81, $4C, $80, $C7, $80, $5C, $80, $01, $04, $B7, $00, $29, $81, $4C, $80, $C7, $80, $5C, $80, $01, $01, $C5, $00, $01, $00, $00, $01, $06, $00, $54, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C5 (Sickler) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C5::
Data_081_4E29:: ; address name
    db $01, $01, $C4, $00, $07, $00, $01, $0A, $CC, $00, $3B, $80, $07, $81, $F7, $80, $0E, $80, $2B, $80, $BE, $80, $79, $80, $71, $80, $A2, $80, $08, $81, $01, $0A, $C8, $00, $3B, $80, $07, $81, $F7, $80, $0E, $80, $2B, $80, $BE, $80, $79, $80, $71, $80, $A2, $80, $08, $81, $01, $0A, $B7, $00, $3B, $80, $07, $81, $F7, $80, $0E, $80, $2B, $80, $BE, $80, $79, $80, $71, $80, $A2, $80, $08, $81, $01, $01, $B8, $00, $D6, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C6 (Armorpion) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C6::
Data_081_4E7F:: ; address name
    db $01, $01, $BE, $00, $DC, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C7 (Digster) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C7::
Data_081_4E87:: ; address name
    db $FF, $06 ; id 0

; E-0199 (derived: list for entry $C8 (Skularach) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C8::
Data_081_4E89:: ; address name
    db $01, $01, $BF, $00, $02, $00, $01, $01, $BB, $00, $02, $00, $01, $01, $BC, $00, $02, $00, $01, $01, $C0, $00, $02, $00, $00, $01, $06, $00, $2F, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $C9 (MultiEyes) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0C9::
Data_081_4EA9:: ; address name
    db $01, $01, $B6, $00, $E3, $80, $01, $01, $C8, $00, $E6, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $CA (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0CA::
Data_081_4EB7:: ; address name
    db $00, $01, $06, $00, $20, $81, $FF, $06 ; id 0

; E-0199 (derived: list for entry $CB (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0CB::
Data_081_4EBF:: ; address name
    db $FF, $06 ; id 0

; E-0199 (derived: list for entry $CC (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0CC::
Data_081_4EC1:: ; address name
    db $01, $01, $BB, $00, $07, $00, $01, $01, $BC, $00, $07, $00, $01, $01, $C0, $00, $07, $00, $00, $01, $06, $00, $63, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $CD (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0CD::
Data_081_4EDB:: ; address name
    db $01, $01, $B6, $00, $01, $00, $01, $01, $C4, $00, $02, $00, $01, $01, $C5, $00, $02, $00, $FF, $06 ; id 0

; E-0199 (derived: list for entry $CE (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0CE::
Data_081_4EEF:: ; address name
    db $01, $01, $B6, $00, $08, $00, $01, $01, $C4, $00, $08, $00, $01, $01, $C5, $00, $08, $00, $00, $01, $06, $00, $BC, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $CF (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0CF::
Data_081_4F09:: ; address name
    db $01, $01, $C9, $00, $81, $80, $01, $01, $72, $00, $E6, $80, $FF, $06 ; id 0

; E-0199 (derived: list for entry $D0 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D0::
Data_081_4F17:: ; address name
    db $01, $01, $0D, $01, $EB, $80, $01, $01, $CD, $00, $35, $81, $FF, $06 ; id 0

; E-0199 (derived: list for entry $D1 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D1::
Data_081_4F25:: ; address name
    db $FF, $06 ; id 0

; E-0199 (derived: list for entry $D2 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D2::
Data_081_4F27:: ; address name
    db $FF, $06 ; id 0

; E-0199 (derived: list for entry $D3 (Pixy) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D3::
Data_081_4F29:: ; address name
    db $00, $01, $07, $00, $00, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $D4 (MedusaEye) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D4::
Data_081_4F31:: ; address name
    db $01, $01, $E7, $00, $01, $00, $01, $01, $E4, $00, $01, $00, $01, $01, $D4, $00, $01, $00, $01, $01, $E6, $00, $01, $00, $01, $01, $E5, $00, $01, $00, $00, $07, $07, $00, $33, $80, $38, $80, $40, $80, $2B, $80, $3D, $80, $3C, $80, $30, $80, $00, $04, $01, $00, $07, $81, $F7, $80, $0B, $81, $08, $81, $FF, $07 ; id 0

; E-0199 (derived: list for entry $D5 (AgDevil) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D5::
Data_081_4F6F:: ; address name
    db $00, $01, $07, $00, $02, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $D6 (Demonite) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D6::
Data_081_4F77:: ; address name
    db $00, $01, $07, $00, $03, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $D7 (DarkEye) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D7::
Data_081_4F7F:: ; address name
    db $00, $01, $07, $00, $04, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $D8 (EyeBall) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D8::
Data_081_4F87:: ; address name
    db $00, $01, $07, $00, $05, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $D9 (SkulRider) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0D9::
Data_081_4F8F:: ; address name
    db $00, $01, $07, $00, $06, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $DA (EvilBeast) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0DA::
Data_081_4F97:: ; address name
    db $00, $01, $07, $00, $08, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $DB (Bubblemon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0DB::
Data_081_4F9F:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $DC (1EyeClown) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0DC::
Data_081_4FA1:: ; address name
    db $01, $01, $D3, $00, $02, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $DD (Gremlin) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0DD::
Data_081_4FA9:: ; address name
    db $00, $0A, $07, $00, $56, $80, $B0, $80, $0C, $80, $98, $80, $BF, $80, $80, $80, $47, $80, $08, $80, $8D, $80, $B6, $80, $FF, $07 ; id 0

; E-0199 (derived: list for entry $DE (ArcDemon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0DE::
Data_081_4FC3:: ; address name
    db $01, $01, $EB, $00, $06, $00, $01, $01, $D8, $00, $06, $00, $00, $01, $07, $00, $71, $80, $FF, $07 ; id 0

; E-0199 (derived: list for entry $DF (Lionex) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0DF::
Data_081_4FD7:: ; address name
    db $00, $01, $07, $00, $4E, $80, $01, $01, $D6, $00, $03, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E0 (GoatHorn) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E0::
Data_081_4FE5:: ; address name
    db $01, $01, $DC, $00, $06, $00, $01, $01, $D3, $00, $06, $00, $00, $01, $07, $00, $B4, $80, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E1 (Orc) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E1::
Data_081_4FF9:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $E2 (Ogre) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E2::
Data_081_4FFB:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $E3 (GateGuard) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E3::
Data_081_4FFD:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $E4 (ChopClown) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E4::
Data_081_4FFF:: ; address name
    db $01, $05, $EB, $00, $DE, $80, $29, $81, $E3, $80, $24, $81, $DF, $80, $01, $06, $E7, $00, $DE, $80, $29, $81, $E3, $80, $24, $81, $DF, $80, $0D, $81, $01, $06, $E6, $00, $DE, $80, $29, $81, $E3, $80, $24, $81, $DF, $80, $0D, $81, $01, $06, $DD, $00, $DE, $80, $29, $81, $E3, $80, $24, $81, $DF, $80, $0D, $81, $01, $02, $D9, $00, $FC, $80, $0D, $81, $01, $01, $D4, $00, $0D, $81, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E5 (BossTroll) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E5::
Data_081_504D:: ; address name
    db $01, $0A, $E7, $00, $33, $80, $10, $80, $60, $80, $38, $80, $35, $81, $7D, $80, $13, $80, $7B, $80, $17, $80, $7F, $80, $01, $0A, $E4, $00, $33, $80, $10, $80, $60, $80, $38, $80, $35, $81, $7D, $80, $13, $80, $7B, $80, $17, $80, $7F, $80, $01, $0A, $D4, $00, $33, $80, $10, $80, $60, $80, $38, $80, $35, $81, $7D, $80, $13, $80, $7B, $80, $17, $80, $7F, $80, $01, $0A, $E8, $00, $33, $80, $10, $80, $60, $80, $38, $80, $35, $81, $7D, $80, $13, $80, $7B, $80, $17, $80, $7F, $80, $00, $01, $07, $00, $0A, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E6 (Grendal) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E6::
Data_081_50B5:: ; address name
    db $01, $07, $DC, $00, $78, $80, $DD, $80, $0D, $80, $0E, $80, $8F, $80, $C4, $80, $77, $80, $01, $07, $D9, $00, $78, $80, $DD, $80, $0D, $80, $0E, $80, $8F, $80, $C4, $80, $77, $80, $01, $07, $D7, $00, $78, $80, $DD, $80, $0D, $80, $0E, $80, $8F, $80, $C4, $80, $77, $80, $01, $01, $DC, $00, $FF, $80, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E7 (Akubar) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E7::
Data_081_50F3:: ; address name
    db $01, $09, $DC, $00, $33, $81, $E2, $80, $62, $80, $55, $80, $32, $81, $4C, $80, $70, $80, $79, $80, $DA, $80, $01, $09, $D9, $00, $33, $81, $E2, $80, $62, $80, $55, $80, $32, $81, $4C, $80, $70, $80, $79, $80, $DA, $80, $01, $09, $DD, $00, $33, $81, $E2, $80, $62, $80, $55, $80, $32, $81, $4C, $80, $70, $80, $79, $80, $DA, $80, $01, $09, $D7, $00, $33, $81, $E2, $80, $62, $80, $55, $80, $32, $81, $4C, $80, $70, $80, $79, $80, $DA, $80, $01, $01, $EB, $00, $01, $00, $01, $01, $E6, $00, $09, $81, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E8 (MadKnight) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E8::
Data_081_5159:: ; address name
    db $01, $01, $E7, $00, $0A, $81, $01, $01, $E5, $00, $06, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $E9 (EvilWell) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0E9::
Data_081_5167:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $EA (Gigantes) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0EA::
Data_081_5169:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $EB (Centasaur) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0EB::
Data_081_516B:: ; address name
    db $01, $01, $E7, $00, $03, $00, $01, $01, $E4, $00, $03, $00, $01, $01, $D9, $00, $03, $00, $01, $01, $D4, $00, $03, $00, $01, $01, $E6, $00, $03, $00, $01, $01, $DD, $00, $03, $00, $00, $01, $07, $00, $01, $00, $FF, $07 ; id 0

; E-0199 (derived: list for entry $EC (EvilArmor) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0EC::
Data_081_5197:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $ED (Jamirus) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0ED::
Data_081_5199:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $EE (Durran) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0EE::
Data_081_519B:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $EF (Titanis) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0EF::
Data_081_519D:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $F0 (LampGenie) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F0::
Data_081_519F:: ; address name
    db $FF, $07 ; id 0

; E-0199 (derived: list for entry $F1 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F1::
Data_081_51A1:: ; address name
    db $00, $01, $08, $00, $00, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F2 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F2::
Data_081_51A9:: ; address name
    db $00, $01, $08, $00, $01, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F3 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F3::
Data_081_51B1:: ; address name
    db $00, $01, $08, $00, $02, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F4 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F4::
Data_081_51B9:: ; address name
    db $00, $01, $08, $00, $03, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F5 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F5::
Data_081_51C1:: ; address name
    db $00, $01, $08, $00, $04, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F6 (Spooky) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F6::
Data_081_51C9:: ; address name
    db $00, $01, $08, $00, $05, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F7 (Skullgon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F7::
Data_081_51D1:: ; address name
    db $00, $01, $08, $00, $06, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F8 (PutrePup) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F8::
Data_081_51D9:: ; address name
    db $00, $01, $08, $00, $07, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $F9 (RotRaven) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0F9::
Data_081_51E1:: ; address name
    db $FF, $08 ; id 0

; E-0199 (derived: list for entry $FA (Mummy) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0FA::
Data_081_51E3:: ; address name
    db $01, $01, $F1, $00, $00, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $FB (DarkCrab) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0FB::
Data_081_51EB:: ; address name
    db $01, $04, $0B, $01, $0D, $80, $05, $80, $06, $80, $01, $80, $01, $04, $0A, $01, $0D, $80, $05, $80, $06, $80, $01, $80, $00, $01, $08, $00, $B6, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $FC (DeadNite) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0FC::
Data_081_520B:: ; address name
    db $01, $07, $2E, $00, $33, $81, $29, $81, $10, $80, $32, $81, $F7, $80, $0E, $80, $C7, $80, $01, $07, $33, $00, $33, $81, $29, $81, $10, $80, $32, $81, $F7, $80, $0E, $80, $C7, $80, $01, $07, $32, $00, $33, $81, $29, $81, $10, $80, $32, $81, $F7, $80, $0E, $80, $C7, $80, $01, $01, $01, $01, $01, $00, $01, $01, $FC, $00, $01, $00, $00, $01, $08, $00, $33, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $FD (Shadow) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0FD::
Data_081_5255:: ; address name
    db $01, $01, $06, $01, $06, $00, $01, $01, $05, $01, $06, $00, $00, $01, $08, $00, $0A, $00, $FF, $08 ; id 0

; E-0199 (derived: list for entry $FE (Skulpent) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0FE::
Data_081_5269:: ; address name
    db $01, $04, $0B, $01, $78, $80, $7C, $80, $80, $80, $77, $80, $01, $04, $F2, $00, $78, $80, $7C, $80, $80, $80, $77, $80, $01, $04, $0A, $01, $78, $80, $7C, $80, $80, $80, $77, $80, $01, $04, $FB, $00, $78, $80, $7C, $80, $80, $80, $77, $80, $00, $01, $08, $00, $B5, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $FF (Hork) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks0FF::
Data_081_52A1:: ; address name
    db $01, $01, $01, $01, $03, $00, $00, $01, $08, $00, $90, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $100 (Mudron) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks100::
Data_081_52AF:: ; address name
    db $FF, $08 ; id 0

; E-0199 (derived: list for entry $101 (NiteWhip) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks101::
Data_081_52B1:: ; address name
    db $01, $08, $FE, $00, $E2, $80, $0A, $81, $38, $80, $E6, $80, $07, $81, $0E, $80, $EC, $80, $5C, $80, $00, $05, $08, $00, $60, $80, $55, $80, $D9, $80, $4C, $80, $5F, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $102 (WindMerge) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks102::
Data_081_52D5:: ; address name
    db $FF, $08 ; id 0

; E-0199 (derived: list for entry $103 (Reaper) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks103::
Data_081_52D7:: ; address name
    db $01, $01, $04, $01, $06, $00, $00, $01, $08, $00, $05, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $104 (Inverzon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks104::
Data_081_52E5:: ; address name
    db $01, $06, $F7, $00, $9E, $80, $8E, $80, $6B, $80, $01, $80, $7C, $80, $71, $80, $01, $06, $F3, $00, $9E, $80, $8E, $80, $6B, $80, $01, $80, $7C, $80, $71, $80, $01, $06, $FA, $00, $9E, $80, $8E, $80, $6B, $80, $01, $80, $7C, $80, $71, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $105 (FoxFire) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks105::
Data_081_5317:: ; address name
    db $01, $05, $FC, $00, $DE, $80, $60, $80, $7D, $80, $EB, $80, $3C, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $106 (CaptDead) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks106::
Data_081_5327:: ; address name
    db $01, $01, $01, $01, $60, $80, $01, $02, $FC, $00, $F7, $80, $08, $81, $FF, $08 ; id 0

; E-0199 (derived: list for entry $107 (DeadNoble) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks107::
Data_081_5337:: ; address name
    db $01, $01, $01, $01, $07, $00, $00, $01, $08, $00, $08, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $108 (WhiteKing) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks108::
Data_081_5345:: ; address name
    db $FF, $08 ; id 0

; E-0199 (derived: list for entry $109 (BoneSlave) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks109::
Data_081_5347:: ; address name
    db $01, $01, $FA, $00, $22, $81, $FF, $08 ; id 0

; E-0199 (derived: list for entry $10A (Skeletor) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks10A::
Data_081_534F:: ; address name
    db $01, $01, $09, $01, $31, $81, $FF, $08 ; id 0

; E-0199 (derived: list for entry $10B (Servant) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks10B::
Data_081_5357:: ; address name
    db $01, $01, $0A, $01, $32, $81, $00, $02, $08, $00, $C7, $80, $C4, $80, $FF, $08 ; id 0

; E-0199 (derived: list for entry $10C (Lazamanus) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks10C::
Data_081_5367:: ; address name
    db $01, $01, $01, $01, $05, $00, $01, $01, $F6, $00, $1E, $81, $FF, $08 ; id 0

; E-0199 (derived: list for entry $10D (Copycat) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks10D::
Data_081_5375:: ; address name
    db $01, $01, $06, $01, $2D, $81, $FF, $08 ; id 0

; E-0199 (derived: list for entry $10E (MadSpirit) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks10E::
Data_081_537D:: ; address name
    db $FF, $08 ; id 0

; E-0199 (derived: list for entry $10F (PomPomBom) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks10F::
Data_081_537F:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $110 (Niterich) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks110::
Data_081_5381:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $111 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks111::
Data_081_5383:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $112 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks112::
Data_081_5385:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $113 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks113::
Data_081_5387:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $114 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks114::
Data_081_5389:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $115 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks115::
Data_081_538B:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $116 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks116::
Data_081_538D:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $117 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks117::
Data_081_538F:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $118 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks118::
Data_081_5391:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $119 (JewelBag) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks119::
Data_081_5393:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $11A (EvilWand) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks11A::
Data_081_5395:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $11B (MadCandle) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks11B::
Data_081_5397:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $11C (CoilBird) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks11C::
Data_081_5399:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $11D (Facer) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks11D::
Data_081_539B:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $11E (SpikyBoy) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks11E::
Data_081_539D:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $11F (MadMirror) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks11F::
Data_081_539F:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $120 (RogueNite) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks120::
Data_081_53A1:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $121 (Puppetor) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks121::
Data_081_53A3:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $122 (Goopi) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks122::
Data_081_53A5:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $123 (Voodoll) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks123::
Data_081_53A7:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $124 (MetalDrak) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks124::
Data_081_53A9:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $125 (Balzak) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks125::
Data_081_53AB:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $126 (SabreMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks126::
Data_081_53AD:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $127 (CurseLamp) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks127::
Data_081_53AF:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $128 (Brushead) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks128::
Data_081_53B1:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $129 (Roboster) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks129::
Data_081_53B3:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $12A (Roboster2) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks12A::
Data_081_53B5:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $12B (EvilPot) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks12B::
Data_081_53B7:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $12C (Gismo) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks12C::
Data_081_53B9:: ; address name
    db $FF, $09 ; id 0

; E-0199 (derived: list for entry $12D (LavaMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks12D::
Data_081_53BB:: ; address name
    db $01, $02, $E8, $00, $33, $80, $38, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $12E (IceMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks12E::
Data_081_53C5:: ; address name
    db $01, $01, $2D, $01, $40, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $12F (Mimic) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks12F::
Data_081_53CD:: ; address name
    db $FF, $0A ; id 0

; E-0199 (derived: list for entry $130 (Exaucers) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks130::
Data_081_53CF:: ; address name
    db $01, $01, $E5, $00, $17, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $131 (MudDoll) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks131::
Data_081_53D7:: ; address name
    db $01, $01, $CF, $00, $A2, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $132 (Golem) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks132::
Data_081_53DF:: ; address name
    db $FF, $0A ; id 0

; E-0199 (derived: list for entry $133 (StoneMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks133::
Data_081_53E1:: ; address name
    db $01, $01, $30, $01, $3C, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $134 (BombCrag) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks134::
Data_081_53E9:: ; address name
    db $01, $01, $2D, $01, $65, $81, $01, $01, $2E, $01, $65, $81, $FF, $0A ; id 0

; E-0199 (derived: list for entry $135 (GoldGolem) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks135::
Data_081_53F7:: ; address name
    db $FF, $0A ; id 0

; E-0199 (derived: list for entry $136 (DarkMate) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks136::
Data_081_53F9:: ; address name
    db $01, $01, $D0, $00, $40, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $137 (ProtoMech) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks137::
Data_081_5401:: ; address name
    db $FF, $0A ; id 0

; E-0199 (derived: list for entry $138 (CloudKing) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks138::
Data_081_5403:: ; address name
    db $01, $01, $36, $01, $60, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $139 (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks139::
Data_081_540B:: ; address name
    db $01, $01, $38, $01, $18, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $13A (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks13A::
Data_081_5413:: ; address name
    db $01, $01, $39, $01, $37, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $13B (?) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks13B::
Data_081_541B:: ; address name
    db $01, $01, $33, $01, $61, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $13C (Petiteel) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks13C::
Data_081_5423:: ; address name
    db $01, $02, $34, $01, $6B, $81, $6C, $81, $01, $01, $39, $01, $66, $81, $01, $01, $3A, $01, $66, $81, $FF, $0A ; id 0

; E-0199 (derived: list for entry $13D (Moray) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks13D::
Data_081_5439:: ; address name
    db $01, $01, $3C, $01, $C6, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $13E (WalrusMan) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks13E::
Data_081_5441:: ; address name
    db $01, $01, $3D, $01, $6D, $81, $FF, $0A ; id 0

; E-0199 (derived: list for entry $13F (RayGigas) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks13F::
Data_081_5449:: ; address name
    db $01, $01, $3E, $01, $A5, $80, $FF, $0A ; id 0

; E-0199 (derived: list for entry $140 (Anemon) of SpeciesPairCheckTable; it runs to the next list)
; record: groups of kind, count, key word, count words; $FF ends
SpeciesPairChecks140::
Data_081_5451:: ; address name
    db $FF, $0A ; id 0

; copies three bytes of table $555D entry ($5486[wD0A6] * $129 + 3 * (wD0E8 - 1)) to wD0EA (E-0121)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
; reads: wWorkBuf, wLinkMenuEntry
; points at: wLinkMenuEntryBytes
LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes::
Func_081_5453:: ; address name
    ld a, [wWorkBuf + $9]
    ld l, a
    ld h, $00
    ld a, l
    add a, $86
    ld l, a
    ld a, h
    adc a, $54
    ld h, a
    ld a, [hl]
    ld bc, $0129
    call Multiply8By16
    ld a, [wLinkMenuEntry]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $5D
    ld l, a
    ld a, h
    adc a, $55
    ld h, a
    ld de, wLinkMenuEntryBytes
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

; E-0151 (C1: LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes reads the byte $5486 + wWorkBuf+9 and uses it as the row of the $129-byte table at $555D; 215 bytes up to that table, values 0-31).
; record: row of ExpTable81 (0-31)
ExpCurveIndex81::
Data_081_5486:: ; address name
    db $0D ; id 0
    db $0A ; id 1
    db $0A ; id 2
    db $0B ; id 3
    db $08 ; id 4
    db $0F ; id 5
    db $0C ; id 6
    db $0B ; id 7
    db $10 ; id 8
    db $0B ; id 9
    db $0A ; id 10
    db $0B ; id 11
    db $0B ; id 12
    db $0A ; id 13
    db $09 ; id 14
    db $0C ; id 15
    db $19 ; id 16
    db $1B ; id 17
    db $1D ; id 18
    db $1F ; id 19
    db $07 ; id 20
    db $11 ; id 21
    db $10 ; id 22
    db $12 ; id 23
    db $0F ; id 24
    db $14 ; id 25
    db $13 ; id 26
    db $14 ; id 27
    db $14 ; id 28
    db $10 ; id 29
    db $13 ; id 30
    db $11 ; id 31
    db $13 ; id 32
    db $10 ; id 33
    db $16 ; id 34
    db $14 ; id 35
    db $13 ; id 36
    db $17 ; id 37
    db $12 ; id 38
    db $14 ; id 39
    db $17 ; id 40
    db $16 ; id 41
    db $16 ; id 42
    db $12 ; id 43
    db $1C ; id 44
    db $0C ; id 45
    db $0D ; id 46
    db $0A ; id 47
    db $0B ; id 48
    db $09 ; id 49
    db $0D ; id 50
    db $0C ; id 51
    db $0C ; id 52
    db $08 ; id 53
    db $09 ; id 54
    db $0A ; id 55
    db $09 ; id 56
    db $0B ; id 57
    db $0E ; id 58
    db $0D ; id 59
    db $0C ; id 60
    db $0B ; id 61
    db $0E ; id 62
    db $0B ; id 63
    db $0D ; id 64
    db $0E ; id 65
    db $0F ; id 66
    db $0D ; id 67
    db $0C ; id 68
    db $0B ; id 69
    db $04 ; id 70
    db $06 ; id 71
    db $05 ; id 72
    db $05 ; id 73
    db $03 ; id 74
    db $04 ; id 75
    db $05 ; id 76
    db $05 ; id 77
    db $02 ; id 78
    db $03 ; id 79
    db $06 ; id 80
    db $05 ; id 81
    db $03 ; id 82
    db $06 ; id 83
    db $07 ; id 84
    db $07 ; id 85
    db $07 ; id 86
    db $0F ; id 87
    db $05 ; id 88
    db $18 ; id 89
    db $0A ; id 90
    db $0F ; id 91
    db $07 ; id 92
    db $07 ; id 93
    db $06 ; id 94
    db $0B ; id 95
    db $09 ; id 96
    db $0C ; id 97
    db $08 ; id 98
    db $09 ; id 99
    db $0C ; id 100
    db $0B ; id 101
    db $09 ; id 102
    db $0D ; id 103
    db $0A ; id 104
    db $06 ; id 105
    db $09 ; id 106
    db $0B ; id 107
    db $18 ; id 108
    db $00 ; id 109
    db $02 ; id 110
    db $04 ; id 111
    db $01 ; id 112
    db $00 ; id 113
    db $04 ; id 114
    db $06 ; id 115
    db $04 ; id 116
    db $03 ; id 117
    db $02 ; id 118
    db $00 ; id 119
    db $05 ; id 120
    db $06 ; id 121
    db $04 ; id 122
    db $02 ; id 123
    db $05 ; id 124
    db $06 ; id 125
    db $07 ; id 126
    db $07 ; id 127
    db $18 ; id 128
    db $0B ; id 129
    db $13 ; id 130
    db $14 ; id 131
    db $10 ; id 132
    db $0D ; id 133
    db $12 ; id 134
    db $10 ; id 135
    db $12 ; id 136
    db $14 ; id 137
    db $0D ; id 138
    db $0D ; id 139
    db $13 ; id 140
    db $15 ; id 141
    db $16 ; id 142
    db $11 ; id 143
    db $13 ; id 144
    db $17 ; id 145
    db $16 ; id 146
    db $14 ; id 147
    db $1E ; id 148
    db $17 ; id 149
    db $16 ; id 150
    db $17 ; id 151
    db $16 ; id 152
    db $15 ; id 153
    db $1C ; id 154
    db $0B ; id 155
    db $0D ; id 156
    db $06 ; id 157
    db $05 ; id 158
    db $0A ; id 159
    db $08 ; id 160
    db $0D ; id 161
    db $0C ; id 162
    db $08 ; id 163
    db $0A ; id 164
    db $0C ; id 165
    db $0D ; id 166
    db $09 ; id 167
    db $0A ; id 168
    db $10 ; id 169
    db $19 ; id 170
    db $0A ; id 171
    db $0C ; id 172
    db $14 ; id 173
    db $01 ; id 174
    db $0C ; id 175
    db $0E ; id 176
    db $0A ; id 177
    db $0A ; id 178
    db $0C ; id 179
    db $08 ; id 180
    db $0E ; id 181
    db $0C ; id 182
    db $08 ; id 183
    db $0B ; id 184
    db $0F ; id 185
    db $0D ; id 186
    db $0B ; id 187
    db $09 ; id 188
    db $0D ; id 189
    db $0B ; id 190
    db $09 ; id 191
    db $0D ; id 192
    db $0D ; id 193
    db $0B ; id 194
    db $08 ; id 195
    db $12 ; id 196
    db $0F ; id 197
    db $0E ; id 198
    db $12 ; id 199
    db $18 ; id 200
    db $19 ; id 201
    db $18 ; id 202
    db $19 ; id 203
    db $18 ; id 204
    db $19 ; id 205
    db $18 ; id 206
    db $1F ; id 207
    db $1E ; id 208
    db $1F ; id 209
    db $1C ; id 210
    db $1B ; id 211
    db $1D ; id 212
    db $1F ; id 213
    db $1E ; id 214

; E-0151 (C1: LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes copies the 3 bytes at $555D + $129 * row + 3 * (wLinkMenuEntry - 1) to wLinkMenuEntryBytes; the layout of ExpTable (E-0148) with different values; 31 of the 32 rows rise from 0).
; record: 24-bit values for levels 1-99
ExpTable81::
Data_081_555D:: ; address name
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 0
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 12900, 15700, 18900, 22500, 26500, 30900, 35700, 40900, 46500, 52500, 58900
    d24 65700, 72900, 80500, 88500, 96900, 105700, 114900, 124500, 134500, 145500, 157500
    d24 170500, 184500, 199500, 215500, 232500, 250500, 269500, 289500, 310500, 332500, 355500
    d24 379500, 404500, 429500, 454500, 479500, 504500, 529500, 554500, 579500, 604500, 629500
    d24 654500, 679500, 704500, 729500, 754500, 779500, 804500, 829500, 854500, 879500, 904500
    d24 929500, 954500, 979500, 1004500, 1029500, 1054500, 1079500, 1104500, 1129500, 1154500, 1179500
    d24 1204500, 1229500, 1254500, 1279500, 1304500, 1329500, 1354500, 1379500, 1404500, 1429500, 1454500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 1
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 12900, 15700, 18900, 22500, 26500, 30900, 35700, 40900, 46500, 52500, 58900
    d24 65700, 72900, 80500, 88500, 96900, 105700, 114900, 124500, 134500, 146500, 160500
    d24 176500, 194500, 214500, 236500, 260500, 286500, 314500, 344500, 374500, 404500, 434500
    d24 464500, 494500, 524500, 554500, 584500, 614500, 644500, 674500, 704500, 734500, 764500
    d24 794500, 824500, 854500, 884500, 914500, 944500, 974500, 1004500, 1034500, 1064500, 1094500
    d24 1124500, 1154500, 1184500, 1214500, 1244500, 1274500, 1304500, 1334500, 1364500, 1394500, 1424500
    d24 1454500, 1484500, 1514500, 1544500, 1574500, 1604500, 1634500, 1664500, 1694500, 1724500, 1754500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 2
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13100, 16300, 20100, 24500, 29500, 35100, 41300, 48100, 55500, 63500, 72100
    d24 81300, 91100, 101500, 112500, 124100, 136300, 149100, 162500, 176500, 191500, 207500
    d24 224500, 242500, 261500, 281500, 302500, 324500, 347500, 371500, 396500, 421500, 446500
    d24 471500, 496500, 521500, 546500, 571500, 596500, 621500, 646500, 671500, 696500, 721500
    d24 746500, 771500, 796500, 821500, 846500, 871500, 896500, 921500, 946500, 971500, 996500
    d24 1021500, 1046500, 1071500, 1096500, 1121500, 1146500, 1171500, 1196500, 1221500, 1246500, 1271500
    d24 1296500, 1321500, 1346500, 1371500, 1396500, 1421500, 1446500, 1471500, 1496500, 1521500, 1546500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 3
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13100, 16300, 20100, 24500, 29500, 35100, 41300, 48100, 55500, 63500, 72100
    d24 81300, 91100, 101500, 112500, 124100, 136300, 149100, 162500, 176500, 192500, 210500
    d24 230500, 252500, 276500, 302500, 330500, 360500, 390500, 420500, 450500, 480500, 510500
    d24 540500, 570500, 600500, 630500, 660500, 690500, 720500, 750500, 780500, 810500, 840500
    d24 870500, 900500, 930500, 960500, 990500, 1020500, 1050500, 1080500, 1110500, 1140500, 1170500
    d24 1200500, 1230500, 1260500, 1290500, 1320500, 1350500, 1380500, 1410500, 1440500, 1470500, 1500500
    d24 1530500, 1560500, 1590500, 1620500, 1650500, 1680500, 1710500, 1740500, 1770500, 1800500, 1830500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 4
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13300, 16900, 21300, 26500, 32500, 39300, 46900, 55300, 64500, 74500, 85300
    d24 96900, 109300, 122500, 136500, 151300, 166900, 183300, 200500, 218500, 237500, 257500
    d24 278500, 300500, 323500, 347500, 372500, 397500, 422500, 447500, 472500, 497500, 522500
    d24 547500, 572500, 597500, 622500, 647500, 672500, 697500, 722500, 747500, 772500, 797500
    d24 822500, 847500, 872500, 897500, 922500, 947500, 972500, 997500, 1022500, 1047500, 1072500
    d24 1097500, 1122500, 1147500, 1172500, 1197500, 1222500, 1247500, 1272500, 1297500, 1322500, 1347500
    d24 1372500, 1397500, 1422500, 1447500, 1472500, 1497500, 1522500, 1547500, 1572500, 1597500, 1622500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 5
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13300, 16900, 21300, 26500, 32500, 39300, 46900, 55300, 64500, 74500, 85300
    d24 96900, 109300, 122500, 136500, 151300, 166900, 183300, 200500, 218500, 238500, 260500
    d24 284500, 310500, 338500, 368500, 398500, 428500, 458500, 488500, 518500, 548500, 578500
    d24 608500, 638500, 668500, 698500, 728500, 758500, 788500, 818500, 848500, 878500, 908500
    d24 938500, 968500, 998500, 1028500, 1058500, 1088500, 1118500, 1148500, 1178500, 1208500, 1238500
    d24 1268500, 1298500, 1328500, 1358500, 1388500, 1418500, 1448500, 1478500, 1508500, 1538500, 1568500
    d24 1598500, 1628500, 1658500, 1688500, 1718500, 1748500, 1778500, 1808500, 1838500, 1868500, 1898500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 6
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13500, 17500, 22500, 28500, 35500, 43500, 52500, 62500, 73500, 85500, 98500
    d24 112500, 127500, 143500, 160500, 178500, 197500, 217500, 238500, 260500, 283500, 307500
    d24 332500, 357500, 382500, 407500, 432500, 457500, 482500, 507500, 532500, 557500, 582500
    d24 607500, 632500, 657500, 682500, 707500, 732500, 757500, 782500, 807500, 832500, 857500
    d24 882500, 907500, 932500, 957500, 982500, 1007500, 1032500, 1057500, 1082500, 1107500, 1132500
    d24 1157500, 1182500, 1207500, 1232500, 1257500, 1282500, 1207500, 1332500, 1357500, 1382500, 1407500
    d24 1432500, 1457500, 1482500, 1507500, 1532500, 1557500, 1582500, 1607500, 1632500, 1657500, 1682500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 7
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13500, 17500, 22500, 28500, 35500, 43500, 52500, 62500, 73500, 85500, 98500
    d24 112500, 127500, 143500, 160500, 178500, 197500, 217500, 238500, 260500, 284500, 310500
    d24 338500, 368500, 398500, 428500, 458500, 488500, 518500, 548500, 578500, 608500, 638500
    d24 668500, 698500, 728500, 758500, 788500, 818500, 848500, 878500, 908500, 938500, 968500
    d24 998500, 1028500, 1058500, 1088500, 1118500, 1148500, 1178500, 1208500, 1238500, 1268500, 1298500
    d24 1328500, 1358500, 1388500, 1418500, 1448500, 1478500, 1508500, 1538500, 1568500, 1598500, 1628500
    d24 1658500, 1688500, 1718500, 1748500, 1778500, 1808500, 1838500, 1868500, 1898500, 1928500, 1958500
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 8
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 25800, 31400, 37800, 45000, 53000, 61800, 71400, 81800, 93000, 105000, 117800
    d24 131400, 145800, 161000, 177000, 193800, 211400, 229800, 249000, 269000, 290250, 312750
    d24 336500, 361500, 387750, 415250, 444000, 474000, 506000, 540000, 576000, 614000, 654000
    d24 695000, 737000, 780000, 824000, 869000, 915000, 962000, 1010000, 1059000, 1109000, 1159000
    d24 1209000, 1259000, 1309000, 1338520, 1409000, 1459000, 1509000, 1559000, 1609000, 1659000, 1709000
    d24 1759000, 1809000, 1859000, 1909000, 1959000, 2009000, 2059000, 2109000, 2159000, 2209000, 2259000
    d24 2309000, 2359000, 2409000, 2459000, 2509000, 2559000, 2609000, 2659000, 2709000, 2759000, 2809000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 9
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 25800, 31400, 37800, 45000, 53000, 61800, 71400, 81800, 93000, 105000, 117800
    d24 131400, 145800, 161000, 177000, 193800, 211400, 229800, 249000, 269000, 292100, 318300
    d24 347600, 380000, 415500, 454100, 495900, 540900, 586900, 633900, 681900, 730900, 780900
    d24 831900, 883900, 936900, 990900, 1045900, 1101900, 1158900, 1216900, 1275900, 1335900, 1395900
    d24 1455900, 1515900, 1575900, 1635900, 1695900, 1755900, 1815900, 1875900, 1935900, 1995900, 2055900
    d24 2115900, 2175900, 2235900, 2295900, 2355900, 2415900, 2475900, 2535900, 2595900, 2655900, 2715900
    d24 2775900, 2835900, 2895900, 2955900, 3015900, 3075900, 3135900, 3195900, 3255900, 3315900, 3375900
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 10
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26200, 32600, 40200, 49000, 59000, 70200, 82600, 96200, 111000, 127000, 144200
    d24 162600, 182200, 203000, 225000, 248200, 272600, 298200, 325000, 353000, 382500, 413500
    d24 446256, 480000, 515500, 552500, 591000, 631000, 671600, 712800, 754600, 797000, 840000
    d24 883600, 927800, 972600, 1018000, 1064000, 1110800, 1158400, 1206800, 1256000, 1306000, 1356000
    d24 1406000, 1456000, 1506000, 1556000, 1606000, 1656000, 1706000, 1756000, 1806000, 1856000, 1906000
    d24 1956000, 2006000, 2056000, 2106000, 2156000, 2206000, 2256000, 2306000, 2356000, 2406000, 2456000
    d24 2506000, 2556000, 2606000, 2656000, 2706000, 2756000, 2806000, 2856000, 2906000, 2956000, 3006000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 11
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26200, 32600, 40200, 49000, 59000, 70200, 82600, 96200, 111000, 127000, 144200
    d24 162600, 182200, 203000, 225000, 248200, 272600, 298200, 325000, 353000, 383750, 417250
    d24 453500, 492500, 534250, 578750, 626000, 676000, 726600, 777800, 829600, 882000, 935000
    d24 988600, 1042800, 1097600, 1153000, 1209000, 1265800, 1323400, 1381800, 1441000, 1501000, 1561000
    d24 1621000, 1681000, 1741000, 1801000, 1861000, 1921000, 1981000, 2041000, 2101000, 2161000, 2221000
    d24 2281000, 2341000, 2401000, 2461000, 2521000, 2581000, 2641000, 2701000, 2761000, 2821000, 2881000
    d24 2941000, 3001000, 3061000, 3121000, 3181000, 3241000, 3301000, 3361000, 3421000, 3481000, 3541000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 12
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26600, 33800, 42600, 53000, 65000, 78600, 93800, 110600, 129000, 149000, 170600
    d24 193800, 218600, 245000, 273000, 302600, 333800, 366600, 401000, 435550, 470250, 505100
    d24 540100, 575600, 611600, 648100, 685100, 722600, 760600, 799100, 838100, 877600, 917600
    d24 957600, 997600, 1037600, 1077600, 1117600, 1157600, 1197600, 1237600, 1277600, 1317600, 1357600
    d24 1397600, 1437600, 1477600, 1517600, 1557600, 1597600, 1637600, 1677600, 1717600, 1757600, 1797600
    d24 1837600, 1877600, 1917600, 1957600, 1997600, 2037600, 2077600, 2117600, 2157600, 2197600, 2237600
    d24 2277600, 2317600, 2357600, 2397600, 2437600, 2477600, 2517600, 2557600, 2597600, 2637600, 2677600
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 13
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26600, 33800, 42600, 53000, 65000, 78600, 93800, 110600, 129000, 149000, 170600
    d24 193800, 218600, 245000, 273000, 302600, 333800, 366600, 401000, 436800, 474000, 512600
    d24 552600, 593600, 635600, 678600, 722600, 767600, 813600, 860600, 908600, 957600, 1007600
    d24 1057600, 1107600, 1157600, 1207600, 1257600, 1307600, 1357600, 1407600, 1457600, 1507600, 1557600
    d24 1607600, 1657600, 1707600, 1757600, 1807600, 1857600, 1907600, 1957600, 2007600, 2057600, 2107600
    d24 2157600, 2207600, 2257600, 2307600, 2357600, 2407600, 2457600, 2507600, 2557600, 2607600, 2657600
    d24 2707600, 2757600, 2807600, 2857600, 2907605, 2957600, 3007600, 3057600, 3107600, 3157600, 3207600
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 14
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 27000, 35000, 45000, 57000, 71000, 87000, 105000, 125000, 147000, 171000, 197000
    d24 225000, 255000, 287000, 321000, 357000, 395000, 435000, 477000, 519750, 563250, 607500
    d24 652500, 697000, 741000, 784500, 827500, 870000, 912000, 953500, 994500, 1035000, 1075000
    d24 1115000, 1155000, 1195000, 1235000, 1275000, 1315000, 1355000, 1395000, 1435000, 1475000, 1515000
    d24 1555000, 1595000, 1635000, 1675000, 1715000, 1755000, 1795000, 1835000, 1875000, 1915000, 1955000
    d24 1995000, 2035000, 2075000, 2115000, 2155000, 2195000, 2235000, 2275000, 2315000, 2355000, 2395000
    d24 2435000, 2475000, 2515000, 2555000, 2595000, 2635000, 2675000, 2715000, 2755000, 2795000, 2835000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 15
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 27000, 35000, 45000, 57000, 71000, 87000, 105000, 125000, 147000, 171000, 197000
    d24 225000, 255000, 285500, 316500, 348000, 380000, 412500, 445500, 479000, 513000, 547500
    d24 582500, 619000, 657000, 696500, 737500, 780000, 824000, 869500, 916500, 965000, 1015000
    d24 1066000, 1118000, 1171000, 1225000, 1280000, 1336000, 1393000, 1451000, 1510000, 1570000, 1630000
    d24 1690000, 1750000, 1809744, 1870000, 1930000, 1990000, 2050000, 2110000, 2170000, 2230000, 2290000
    d24 2350000, 2410000, 2470000, 2530000, 2590000, 2650000, 2710000, 2770000, 2830000, 2890000, 2950000
    d24 3010000, 3070000, 3130000, 3190000, 3250000, 3310000, 3370000, 3430000, 3490000, 3550000, 3610000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 16
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 51000, 61000, 72000, 84000, 97000, 111000, 126000, 142000, 159800, 179400, 200800
    d24 224000, 249000, 275000, 302000, 330000, 359000, 389000, 420000, 452000, 485000, 519000
    d24 554000, 590500, 628500, 668000, 709000, 751500, 795500, 841000, 888000, 936500, 986500
    d24 1038500, 1092500, 1148500, 1206500, 1266500, 1328500, 1392500, 1458500, 1526500, 1596500, 1666500
    d24 1736500, 1806500, 1876500, 1946500, 2016500, 2086500, 2156500, 2226500, 2296500, 2366500, 2436500
    d24 2506500, 2576500, 2646500, 2716500, 2786500, 2856500, 2926500, 2996500, 3066500, 3136500, 3206500
    d24 3276500, 3346500, 3416500, 3486500, 3556500, 3626500, 3696500, 3766500, 3836500, 3906500, 3976500
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 17
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 51000, 61000, 72000, 84000, 97000, 111000, 126000, 142000, 159800, 179400, 200800
    d24 224000, 249000, 275500, 303500, 333000, 364000, 396500, 430500, 466000, 503000, 541500
    d24 581500, 623500, 667500, 713500, 761500, 811500, 863500, 917500, 973500, 1031500, 1091500
    d24 1152500, 1214500, 1277500, 1341500, 1406500, 1472500, 1539500, 1607500, 1676500, 1746500, 1816500
    d24 1886500, 1956500, 2026500, 2096500, 2166516, 2236500, 2306500, 2376500, 2446500, 2516500, 2586500
    d24 2656500, 2726500, 2796500, 2866500, 2936500, 3006500, 3076500, 3146500, 3216500, 3286500, 3356500
    d24 3426500, 3496500, 3566500, 3636500, 3706500, 3776500, 3846500, 3916500, 3986500, 4056500, 4126500
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 18
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 52400, 65200, 80400, 98000, 118000, 140400, 165200, 192400, 222000, 254000, 288400
    d24 325200, 364400, 405600, 448400, 492400, 537200, 582800, 629200, 676400, 724400, 773400
    d24 823400, 874400, 926400, 979400, 1033400, 1088400, 1144400, 1201400, 1259400, 1318400, 1378400
    d24 1439400, 1501400, 1564400, 1628400, 1693400, 1759400, 1826400, 1894400, 1963400, 2033400, 2103400
    d24 2173400, 2243400, 2313400, 2383400, 2453400, 2523400, 2593400, 2663400, 2733400, 2803400, 2873400
    d24 2943400, 3013400, 3083400, 3153400, 3223400, 3293400, 3363400, 3433400, 3503400, 3573400, 3643400
    d24 3713400, 3783400, 3853400, 3923400, 3993400, 4063400, 4133400, 4203400, 4273400, 4343400, 4413400
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 19
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 52400, 65200, 80400, 98000, 118000, 140400, 165200, 192400, 222000, 254000, 288400
    d24 325200, 364400, 406000, 450000, 496400, 545200, 596400, 650000, 706000, 770000, 842000
    d24 922000, 1010000, 1106000, 1210000, 1322000, 1442000, 1562000, 1682000, 1802000, 1922000, 2042000
    d24 2162000, 2282000, 2402000, 2522000, 2642000, 2762000, 2882000, 3002000, 3122000, 3242000, 3362000
    d24 3482000, 3602000, 3722000, 3842000, 3962000, 4082000, 4202000, 4322000, 4442000, 4562000, 4682000
    d24 4802000, 4922000, 5042000, 5162000, 5282000, 5402000, 5522000, 5642000, 5762000, 5882000, 6002000
    d24 6122000, 6242000, 6362000, 6482000, 6602000, 6722000, 6842000, 6962000, 7082000, 7202000, 7322000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 20
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 52500, 65500, 81000, 99000, 120000, 144000, 171000, 201000, 233000, 267000, 303000
    d24 341000, 381000, 422000, 464000, 507000, 551000, 596000, 642000, 689000, 737000, 786000
    d24 836000, 887000, 939000, 992000, 1046000, 1101000, 1157000, 1214000, 1272000, 1331000, 1391000
    d24 1452000, 1514000, 1577000, 1641000, 1706000, 1772000, 1839000, 1907000, 1976000, 2046000, 2116000
    d24 2186000, 2256000, 2326000, 2396000, 2466000, 2536000, 2606000, 2676000, 2746000, 2816000, 2886000
    d24 2956000, 3026000, 3096000, 3166000, 3236000, 3306000, 3376000, 3446000, 3516000, 3586000, 3656000
    d24 3726000, 3796000, 3866000, 3936000, 4006000, 4076000, 4146000, 4216000, 4286000, 4356000, 4426000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 21
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 53200, 67600, 85200, 106000, 130000, 156000, 184000, 214000, 246000, 280000, 316000
    d24 354000, 394000, 436000, 480000, 526000, 574000, 624000, 676000, 730000, 786000, 844000
    d24 904000, 965000, 1027000, 1090000, 1154000, 1219000, 1285000, 1352000, 1420000, 1489000, 1559000
    d24 1630000, 1702000, 1775000, 1849000, 1924000, 2000000, 2077000, 2155000, 2234000, 2314000, 2394000
    d24 2474000, 2554000, 2634000, 2714000, 2794000, 2874000, 2954000, 3034000, 3114000, 3194000, 3274000
    d24 3354000, 3434000, 3514000, 3594000, 3674000, 3754000, 3834000, 3914000, 3994000, 4074000, 4154000
    d24 4234000, 4314000, 4394000, 4474000, 4554000, 4634000, 4714000, 4794000, 4874000, 4954000, 5034000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 22
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 54000, 70000, 90000, 112000, 136000, 162000, 190000, 220000, 252000, 286000, 322000
    d24 360000, 400000, 441000, 483000, 526000, 570000, 615000, 661000, 708000, 756000, 805000
    d24 855000, 906000, 958000, 1011000, 1065000, 1120000, 1176000, 1233000, 1291000, 1350000, 1410000
    d24 1470000, 1530000, 1590000, 1650000, 1710000, 1770000, 1830000, 1890000, 1950000, 2010000, 2070000
    d24 2130000, 2190000, 2250000, 2310000, 2370000, 2430000, 2490000, 2550000, 2610000, 2670000, 2730000
    d24 2790000, 2850000, 2910000, 2970000, 3030000, 3090000, 3150000, 3210000, 3270000, 3330000, 3390000
    d24 3450000, 3510000, 3570000, 3630000, 3690000, 3750000, 3810000, 3870000, 3930000, 3990000, 4050000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 23
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 54000, 70000, 90000, 113000, 139000, 168000, 200000, 235000, 273000, 314000, 358000
    d24 405000, 455000, 506000, 558000, 611000, 665000, 720000, 776000, 833000, 891000, 950000
    d24 1010000, 1070000, 1130000, 1190000, 1250000, 1310000, 1370000, 1430000, 1490000, 1550000, 1610000
    d24 1671000, 1733000, 1796000, 1860000, 1925000, 1991000, 2058000, 2126000, 2195000, 2265000, 2335000
    d24 2405000, 2475000, 2545000, 2615000, 2685000, 2755000, 2825000, 2895000, 2965000, 3035000, 3105000
    d24 3175000, 3245000, 3315000, 3385000, 3455000, 3525000, 3595000, 3665000, 3735000, 3805000, 3875000
    d24 3945000, 4015000, 4085000, 4155000, 4225000, 4295000, 4365000, 4435000, 4505000, 4575000, 4645000
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 24
    d24 30400, 43200, 59200, 79200, 101700, 126700, 152700, 180700, 210700, 242700, 276700
    d24 312700, 350700, 390700, 431700, 473700, 516700, 560700, 605700, 651700, 698700, 746700
    d24 795700, 845700, 895700, 945700, 995700, 1045700, 1095700, 1145700, 1195700, 1245700, 1295700
    d24 1345700, 1396200, 1447200, 1498700, 1550700, 1603200, 1656200, 1709700, 1763700, 1818200, 1873200
    d24 1929700, 1987700, 2047200, 2108200, 2170700, 2234700, 2300200, 2367200, 2435700, 2505700, 2575700
    d24 2645700, 2715700, 2785700, 2855700, 2925700, 2995700, 3065700, 3135700, 3205700, 3275700, 3345700
    d24 3415700, 3485700, 3555700, 3625700, 3695700, 3776992, 3835700, 3905700, 3975700, 4045700, 4115700
    d24 4185700, 4255700, 4325700, 4395700, 4465700, 4535700, 4605700, 4675700, 4745700, 4815700, 4885700
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 25
    d24 30400, 43200, 59200, 79200, 104200, 134200, 168200, 205200, 245200, 287200, 330200
    d24 374200, 418700, 463700, 509200, 555200, 601700, 648700, 696200, 744200, 792700, 841700
    d24 891200, 941200, 991700, 1042700, 1094200, 1146200, 1198700, 1251700, 1305200, 1359200, 1413700
    d24 1468700, 1524200, 1580200, 1636700, 1693700, 1751200, 1809200, 1867700, 1926700, 1986200, 2046200
    d24 2108200, 2172200, 2238200, 2306200, 2376200, 2448200, 2522200, 2598200, 2676200, 2756200, 2836200
    d24 2916200, 2996200, 3076200, 3156200, 3236200, 3316200, 3396200, 3476200, 3556200, 3636200, 3716200
    d24 3796200, 3876200, 3956200, 4036200, 4116200, 4196200, 4276200, 4356200, 4436200, 4516200, 4596200
    d24 4676200, 4756200, 4836200, 4916200, 4996200, 5076200, 5156200, 5236200, 5316200, 5396200, 5476200
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 26
    d24 30400, 43200, 59200, 79200, 104200, 134200, 168200, 205200, 245200, 288200, 333200
    d24 380200, 429200, 479200, 529700, 580700, 632200, 684200, 736700, 789700, 843200, 897200
    d24 951700, 1006700, 1062200, 1118200, 1174700, 1231700, 1289200, 1347200, 1405700, 1464700, 1524200
    d24 1584200, 1644200, 1704200, 1764200, 1824200, 1884200, 1944200, 2004200, 2064200, 2124200, 2184200
    d24 2245200, 2307200, 2370200, 2434200, 2499200, 2565200, 2632200, 2700200, 2769200, 2839200, 2909200
    d24 2979200, 3049200, 3119200, 3189200, 3259200, 3329200, 3399200, 3469200, 3539200, 3609208, 3679200
    d24 3749200, 3819200, 3889200, 3959200, 4029200, 4099200, 4169200, 4239200, 4309200, 4379200, 4449200
    d24 4519200, 4589200, 4659200, 4729200, 4799200, 4869200, 4939200, 5009200, 5079200, 5149200, 5219200
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 27
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 575900, 626900, 678400, 730400, 782900, 835900, 889400, 943400
    d24 997900, 1052900, 1108400, 1164400, 1220900, 1277900, 1335400, 1393400, 1451900, 1510900, 1570400
    d24 1630400, 1690900, 1751900, 1813400, 1875400, 1937900, 2000900, 2064400, 2128400, 2192900, 2257900
    d24 2324400, 2392400, 2461900, 2532900, 2605400, 2679400, 2754900, 2831900, 2910400, 2990400, 3070400
    d24 3150400, 3230400, 3310400, 3390400, 3470400, 3550400, 3630400, 3710400, 3790400, 3870400, 3950400
    d24 4030400, 4110400, 4190400, 4270400, 4350400, 4430400, 4510400, 4590400, 4670400, 4750400, 4830400
    d24 4910400, 4990400, 5070400, 5150400, 5230400, 5310400, 5390400, 5470400, 5550400, 5630400, 5710400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 28
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 575900, 626900, 678400, 730400, 782900, 835900, 889400, 943400
    d24 997900, 1052900, 1108400, 1164400, 1220900, 1277900, 1335400, 1393400, 1451900, 1510900, 1570400
    d24 1630400, 1691400, 1753400, 1816400, 1880400, 1945400, 2011400, 2078400, 2146400, 2215400, 2285400
    d24 2356400, 2428400, 2501400, 2575400, 2650400, 2726400, 2803400, 2881400, 2960400, 3040400, 3120400
    d24 3200400, 3280400, 3360400, 3440400, 3520400, 3600400, 3680400, 3760400, 3840400, 3920400, 4000400
    d24 4080400, 4160400, 4240400, 4320400, 4400400, 4480400, 4560400, 4640400, 4720400, 4800400, 4880400
    d24 4960400, 5040400, 5120400, 5200400, 5280400, 5360400, 5440400, 5520400, 5600400, 5680400, 5760400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 29
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 575900, 626900, 678400, 730400, 782900, 835900, 889400, 943400
    d24 997900, 1052900, 1108400, 1164400, 1220900, 1277900, 1335400, 1393400, 1451900, 1510900, 1570400
    d24 1630400, 1692400, 1756400, 1822400, 1890400, 1960400, 2032400, 2106400, 2182400, 2260400, 2340400
    d24 2422400, 2506400, 2592400, 2680400, 2770400, 2862400, 2956400, 3052400, 3150400, 3250400, 3350400
    d24 3450400, 3550400, 3650400, 3750400, 3850400, 3950400, 4050400, 4150400, 4250400, 4350400, 4450400
    d24 4550400, 4650400, 4750400, 4850400, 4950400, 5050400, 5150400, 5250400, 5350400, 5450400, 5550400
    d24 5650400, 5750400, 5850400, 5950400, 6050400, 6150400, 6250400, 6350400, 6450400, 6550400, 6650400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 30
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 576400, 628400, 681400, 735392, 790400, 846400, 903400, 961400
    d24 1020400, 1080400, 1141400, 1203400, 1266400, 1330400, 1395400, 1461400, 1528400, 1596400, 1665400
    d24 1735400, 1806400, 1878400, 1951400, 2025400, 2100400, 2176400, 2253400, 2331400, 2410400, 2490400
    d24 2572400, 2656400, 2742400, 2830400, 2920400, 3012400, 3106400, 3202400, 3300400, 3400400, 3500400
    d24 3600400, 3700400, 3800400, 3900400, 4000400, 4100400, 4200400, 4300400, 4400400, 4500400, 4600400
    d24 4700400, 4800400, 4900400, 5000400, 5100400, 5200400, 5300400, 5400400, 5500400, 5600400, 5700400
    d24 5800400, 5900400, 6000400, 6100400, 6200400, 6300400, 6400400, 6500400, 6600400, 6700400, 6800400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 31
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 327400, 381400
    d24 437400, 495400, 555400, 616400, 678400, 741400, 805400, 870400, 936400, 1003400, 1071400
    d24 1140400, 1210400, 1281400, 1353400, 1426400, 1500400, 1575400, 1651400, 1728400, 1806400, 1885400
    d24 1965400, 2046400, 2128400, 2211400, 2295400, 2380400, 2466400, 2553400, 2641400, 2730400, 2820400
    d24 2911400, 3003400, 3096400, 3190400, 3285400, 3381400, 3478400, 3576400, 3675400, 3775400, 3875400
    d24 3975400, 4075400, 4175400, 4275400, 4375400, 4475400, 4575400, 4675400, 4775400, 4875400, 4975400
    d24 5075400, 5175400, 5275400, 5375400, 5475400, 5575400, 5675400, 5775400, 5875400, 5975400, 6075400
    d24 6175400, 6275400, 6375400, 6475400, 6575400, 6675400, 6775400, 6875400, 6975400, 7075400, 7175400
    ds $583, $00
