; Offsets into the $A5-byte SRAM monster record that have evidence (config/record_fields.json, E-0290).
DEF MON_STATE EQU $00 ; state: 0 empty, 1 kept, 2 in the party (C2 from E-0320: the monster list numbers the three records in state 2 as party members 1-3 and lists the state-1 records after them unnumbered) (E-0104, E-0320)
DEF MON_NAME EQU $01 ; name, 10 bytes ending in $F0 (C2 from E-0320: the status page's monster, Kheri, is spelled at $01) (E-0323: a save and a fresh load keep the name up to its $F0 and pad the rest of the 10 bytes with $F0) (E-0034, E-0320, E-0323)
DEF MON_SPECIES EQU $0B ; species id word (C2 from E-0320: Patta's record holds $0073 and its status page names it Dracky, String_08_02_73, entry $73 of the monster names; talk events $29/$47 compare it with monster ids, E-0236) (E-0236, E-0320)
DEF MON_FAMILY EQU $0D ; low nibble = family (E-0122)
DEF MON_SEX EQU $0E ; bit 0 = sex: 0 male, 1 female (C2: the egg appraiser's script chooses 'No doubt at all-it's male.' for 0 and '...female.' for 1 through wTwoChoiceCursor = this bit, EggServiceMenu_Appraise); breeding steps back when no other listed record has the other sex; DrawRecordListPageMarks draws mark tile $CC + bit 0 when MON_EGG is 2 (E-0291, E-0311)
DEF MON_MASTER_NAME EQU $0F ; the master's name, 10 bytes: ComputeBreedingChild stores the player name here (CopyPlayerNameToWCADF) and copies each parent's into the child's parent master names (E-0297); called 'second name' in E-0034 (E-0034, E-0297)
DEF MON_MASTER_ID EQU $19 ; the id of the player who bred it: ComputeBreedingChild stores wPlayerId here (C1) (E-0306)
DEF MON_PARENT1_SPECIES EQU $1A ; species word of the first parent (from its $0B; CopySixBytesByWCADDBit4Table, the order swapped by bit 4 of $0D) (C2 from E-0328: a child bred from base Vanyl (Gulpple, $92) and mate Moahm ($C2) holds $92 here and $C2 in MON_PARENT2_SPECIES) (E-0297, E-0328)
DEF MON_PARENT2_SPECIES EQU $1C ; species word of the second parent (C2 from E-0328, see MON_PARENT1_SPECIES: the mate's species) (E-0297, E-0328)
DEF MON_PARENT1_MASTER EQU $1E ; master name of the first parent (from its $0F; CopyFourNamesByWCADDBit4Table) (E-0297)
DEF MON_UNUSED_28 EQU $28 ; not read by any code found; presets hold 0 and the unknown-parents placeholder writes $FF (it follows the first parent's master name) (E-0311)
DEF MON_PARENT2_MASTER EQU $29 ; master name of the second parent (E-0297)
DEF MON_UNUSED_33 EQU $33 ; not read by any code found; presets hold 0 and the unknown-parents placeholder writes $FF (it follows the second parent's master name) (E-0311)
DEF MON_SKILLS EQU $34 ; skills, 8 bytes, $FF for an empty slot (C2 from E-0321: the pause menu's skill page lists 'Sleep' for a record holding $2F, $FF x 7; $2F is String_08_04_2F, 'Sleep', in the skill names) (E-0122, E-0321)
DEF MON_SKILL_LIST EQU $3C ; the list AppendMappedSkillsToWCA67 appends to, up to $FF; in E-0321 a Dracky record holds $21, $2F, $32 here, the three natural skills of SpeciesRecord_Dracky (C1: the skills the monster can learn) (E-0237, E-0321)
DEF MON_STATUS EQU $55 ; status bits: bit 7 dead (C2 from E-0330: with bit 7 set and MON_HP 0 the priest's Revive lists the monster and, for 25G, leaves this byte 0 and MON_HP at MON_MAX_HP; by reading, InnMenu_RestoreParty skips records with bit 7 set, E-0276); bit 2 read as poison (E-0085) (E-0085, E-0330)
DEF MON_LEVEL EQU $56 ; level (C2 from E-0320: a monster's status page in tools/sm83.py shows Lv 25, HP 156/156, MP 89/89, ATK 84, DEF 149, AGL 115, INT 366, WLD 387 for SRAM record 0, which holds them at $56 and $5B-$6C in this order) (E-0122, E-0320)
DEF MON_MAX_LEVEL EQU $57 ; level cap (C1): DrawRecordLevelAndStatusRow_1E loads $56-$57 as a pair and draws the cap mark $6F when the level is at least this byte; in E-0320 the Dracky record holds 50, Dracky's species base level cap ($32) (E-0296, E-0320)
DEF MON_EXP EQU $58 ; experience, 24 bits (C2 from E-0320: the status page shows Ex 15 and 12 more for the next level for a level-4 record holding 15; ExpTable row 2 needs 15 for level 4 and 27 for level 5) (E-0125, E-0320)
DEF MON_HP EQU $5B ; current HP word (C2 from E-0326: lowered to 5, the stats page shows 'HP: 5/21'; a Herb raises it by 30-40 up to MON_MAX_HP) (E-0122, E-0320, E-0326)
DEF MON_MAX_HP EQU $5D ; maximum HP word (C2 from E-0326: the second number of 'HP: 5/21' and the cap of a Herb) (E-0122, E-0320, E-0326)
DEF MON_MP EQU $5F ; current MP word (C2 from E-0326: lowered to 7, the stats page shows 'MP: 7/35') (E-0122, E-0320, E-0326)
DEF MON_MAX_MP EQU $61 ; maximum MP word (C2 from E-0326: the second number of 'MP: 7/35') (E-0122, E-0320, E-0326)
DEF MON_ATK EQU $63 ; ATK word (C2 from E-0320: a monster's status page in tools/sm83.py shows Lv 25, HP 156/156, MP 89/89, ATK 84, DEF 149, AGL 115, INT 366, WLD 387 for SRAM record 0, which holds them at $56 and $5B-$6C in this order; first of the stats column, raised by AddAToRecordWordCapped like $65-$69) (E-0290, E-0320)
DEF MON_DEF EQU $65 ; DEF word (C2 from E-0320, see MON_ATK) (E-0290, E-0320)
DEF MON_AGL EQU $67 ; AGL word (C2 from E-0320, see MON_ATK) (E-0290, E-0320)
DEF MON_INT EQU $69 ; INT word (C2 from E-0320, see MON_ATK) (E-0290, E-0320)
DEF MON_WLD EQU $6B ; WLD (wildness) word (C2 from E-0320, see MON_ATK): the fifth word of the stats column after ATK, DEF, AGL and INT, matching the INFO panel's order ATK, DEF, AGL, INT, WLD (E-0046) (E-0296, E-0320)
DEF MON_PLUS EQU $6D ; the breeding plus value (C1): when non-zero, the monster's info screen (WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03) draws glyph $FC and the value in one or two digits after the member number; BreedMenu_CopyToChildThenTalkEvent16 copies it to the child record (E-0296)
DEF MON_EGG EQU $6E ; egg state: 0 not an egg, 1 an egg not yet appraised (set when an egg record is created), 2 an appraised egg (EggServiceMenu_Appraise sets it after charging the 20-gold fee; only then does the record list show the sex mark); CountRecordsByField6E finding none gives 'You have no eggs.' (C2) (E-0296, E-0311)
DEF MON_PERSONALITY EQU $6F ; four personality axes, $6F-$72, from MonsterTable bytes 22-25 (E-0034)
DEF MON_RESISTANCES EQU $73 ; 27 resistance levels: copied from species bytes $12-$2C when a record is created (CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord), rolled for a child by RollChildResistancesToWCB43 and refreshed by RefreshRecordResistancesFromSpecies (E-0114, E-0127) (E-0299)
DEF MON_PARENT1_NAME EQU $8E ; name of the first parent (from its $01; CopyFourNamesByWCADDBit4Table) (C2 from E-0328: the child holds 'Vanyl', the base's name) (E-0297, E-0328)
DEF MON_PARENT1_PLUS EQU $98 ; plus value of the first parent (from its $6D) (E-0297)
DEF MON_PARENT2_NAME EQU $99 ; name of the second parent (C2 from E-0328: the child holds 'Moahm', the mate's name) (E-0297, E-0328)
DEF MON_PARENT2_PLUS EQU $A3 ; plus value of the second parent (E-0297)
DEF MON_ITEM EQU $A4 ; equipped item (E-0125)

; Offsets into the $4E-byte battler record (wBattlerRecords; config/record_fields.json "battler", E-0298).
DEF BATTLER_NAME EQU $00 ; name, 10 bytes ($FF-filled by FillBattlerRecordFromMonster for a wild monster) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0298, E-0320)
DEF BATTLER_SPECIES EQU $0A ; species word (MonsterTable bytes 0-1, also wSpeciesIdLo/Hi) (E-0298)
DEF BATTLER_FAMILY EQU $0C ; family (species byte 0, written by GameMode4_Init_Sub01_Sub07) (E-0310)
DEF BATTLER_SKILLS EQU $0E ; four skills (MonsterTable bytes 2-5) (E-0298)
DEF BATTLER_LEVEL EQU $17 ; level (MonsterTable byte 9 for a wild monster) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0298, E-0320)
DEF BATTLER_EXP EQU $18 ; experience, 24 bits (MonsterTable bytes 6-7 and a zero high byte for a wild monster) (E-0298)
DEF BATTLER_HP EQU $1B ; HP word (MonsterTable base HP) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0298, E-0320)
DEF BATTLER_MAX_HP EQU $1D ; maximum HP word (GetBaseHP) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0062, E-0298, E-0320)
DEF BATTLER_MP EQU $1F ; MP word (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0298, E-0320)
DEF BATTLER_MAX_MP EQU $21 ; maximum MP word (GetBaseMP) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0124, E-0298, E-0320)
DEF BATTLER_ATK EQU $23 ; ATK word (GetBaseATK) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0124, E-0320)
DEF BATTLER_DEF EQU $25 ; DEF word (GetBaseDEF) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0124, E-0320)
DEF BATTLER_AGL EQU $27 ; AGL word (GetBaseAGL) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0124, E-0320)
DEF BATTLER_INT EQU $29 ; INT word (GetBaseINT) (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C) (E-0124, E-0320)
DEF BATTLER_WLD EQU $2B ; WLD word after INT (C2 from E-0320: during that battle battler record 0 holds the same values as SRAM record 0 at $17 and $1B-$2C; WLD 387 sits here as at the main record's $6B) (E-0320)
DEF BATTLER_PERSONALITY EQU $2D ; personality bytes (MonsterTable bytes 22, 23, 25, 24 in that order) (E-0298)
DEF BATTLER_RESISTANCES EQU $31 ; 27 resistance levels: RecomputeTargetStatsFromRecord packs them into the slot's 7-byte wSlotResistances record (LoadBattleArg0PointersThenRunPackResistanceFieldsToDE) (E-0310)
DEF BATTLER_JOIN_CLASS EQU $4D ; MonsterTable byte 8 for a wild monster; copied to wFoeJoinClass1-3 for the three foes, 7 stops the defeated monster from joining (E-0306)

; Offsets into the 47-byte species record (wSpeciesRecord; config/record_fields.json "species", E-0299).
DEF SPECIES_FAMILY EQU $00 ; family (StringTable_MonsterFamilies index) (E-0069)
DEF SPECIES_SEX_RATIO EQU $01 ; sex-ratio class: 0 = always male, otherwise (byte & 3) indexes SexChanceByClass (10, 50, 90: the chance of female) in RollChildSexFromSpecies (E-0307, E-0311)
DEF SPECIES_UNTRIPPABLE EQU $02 ; bit 0 becomes bit 4 of the slot's wSlotBodyFlags at battle start (GameMode4_Init_Sub01); LegSweep and BigTrip skip or fail on such a target (ChooseTarget_LegSweep, ActionEffect_LegSweep) (E-0310)
DEF SPECIES_METAL EQU $03 ; bit 0 becomes bit 0 of the slot's wSlotBodyFlags: MetalCut multiplies damage by 50 against it (MultiplyDamageBy50IfSlotDamageFlagsBit0, ChooseTarget_MetalCut); a non-zero byte also raises a stat cap from 700 to 999 in battle kind 3 (E-0310)
DEF SPECIES_JOIN_CLASS EQU $04 ; join-chance class 0-7: after a battle BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc compares (random mod 200) with the chance table entry for it; 7 = never joins (E-0306)
DEF SPECIES_UNUSED_05 EQU $05 ; values 0-3 in the 324 records but never read: every species read goes through wSpeciesRecord, and no code reads its byte 5 (the two whole-buffer users only clear it) (E-0311)
DEF SPECIES_MAX_LEVEL EQU $06 ; base level cap: copied to a new record's $57 (MON_MAX_LEVEL); BattleEnd_Step3 compares the level with it; ComputeBreedingChild starts the child's cap from it (E-0299)
DEF SPECIES_EXP_CURVE EQU $07 ; the ExpTable row (EXP curve) (E-0148)
DEF SPECIES_SKILLS EQU $08 ; three natural skills: copied to the first three entries of a new record's skill list $3C (MON_SKILL_LIST), the rest $FF (E-0299)
DEF SPECIES_FIELD_ABILITY EQU $0B ; field ability: string index in category $0D, which BeginStringDisplay_Bank08 redirects to bank $95's category 4, StringTable_FieldAbilities: None, Call ship, Call cloud, Smash rock, Burn, Cut, Open door; shown by ShowRecordSpeciesAndSkillNames and the record screens (E-0313)
DEF SPECIES_GROWTH EQU $0C ; six stat growth rows, one per stat in the order of wLevelUpGains (bytes $0C-$11; C1: HP, MP, ATK, DEF, AGL, INT): ComputeLevelUpStatGainsForBattleArg1 passes each to ReadStatGrowthGain, and new and wild monsters pass each to StatFromGrowthRow (E-0299, E-0309)
DEF SPECIES_RESISTANCES EQU $12 ; 27 base resistance levels: copied to a new record's $73-$8D (MON_RESISTANCES); LoadWD01AByteArg4 reads one (E-0299)
DEF SPECIES_EXP EQU $2D ; base EXP word: GameMode4_Init_Sub01_Sub07 writes it as the low word of a new battler's 24-bit EXP (battler $18-$19), as MonsterTable bytes 6-7 do for wild monsters (E-0310)

; Offsets into a 16-byte field object slot (wObject1-4; config/record_fields.json "object", E-0300).
DEF OBJ_SET_MODE EQU $01 ; 0: UpdateAndDrawSpriteSlots takes the sprite set from +2; otherwise another path (E-0300)
DEF OBJ_SPRITE_ID EQU $02 ; sprite id word: with OBJ_SET_MODE 0, bits 0-6 of the low byte are the set index, bit 7 selects DrawMetaSpriteSet_Bank26 and a non-zero high byte DrawMetaSpriteSet_Bank27; monster objects store the species word here (E-0300, E-0308) (E-0308)
DEF OBJ_ATTR EQU $06 ; attribute bits (bits 0-2 to hSpriteAttrXor) (E-0300)
DEF OBJ_STATE EQU $07 ; state (E-0134)
DEF OBJ_TILE_OFFSET EQU $08 ; tile offset (hSpriteTileOffset) (E-0300)
DEF OBJ_ANIM_COUNTER EQU $09 ; animation counter: UpdateSpriteSlots type 0 increments it each frame unless +$D bit 1 is set (C1; E-0134 called it flags) (E-0300)
DEF OBJ_X EQU $0B ; X position (hSpriteOriginX = this + 8 + scroll) (E-0134, E-0300)
DEF OBJ_Y EQU $0C ; Y position (hSpriteOriginY = this + 16 + scroll) (E-0134, E-0300)
DEF OBJ_FLAGS EQU $0D ; flags (bit 1 stops the animation counter, bit 2 selects the frame rule) (E-0134, E-0300)
DEF OBJ_SUBINDEX EQU $0E ; meta-sprite sub-index; bit 7 flips it horizontally (hSpriteAttrXor bit 5) (E-0300)

; Offsets into the script meta-sprite object (wObject5; "script_object", E-0300).
DEF SCRIPTOBJ_TILE_OFFSET EQU $01 ; tile offset of the script meta-sprite (DrawFieldSprites) (E-0300)
DEF SCRIPTOBJ_SPRITE_SET EQU $02 ; sprite set index (bits 0-6); bit 7: a sub-index follows (E-0300)
DEF SCRIPTOBJ_ATTR EQU $03 ; attribute bits (hSpriteAttrXor) (E-0300)
DEF SCRIPTOBJ_X EQU $04 ; X position (hSpriteOriginX = this + 8 + scroll) (E-0300)
DEF SCRIPTOBJ_Y EQU $05 ; Y position (hSpriteOriginY = this + 16 + scroll) (E-0300)

; The resistances, by index into MON_RESISTANCES, BATTLER_RESISTANCES and SPECIES_RESISTANCES: the 27 resistances in record order (MON_RESISTANCES, BATTLER_RESISTANCES, SPECIES_RESISTANCES), named by the skills whose effects read each packed field; PackResistanceFieldsToDE puts index 26 in byte 0 bits 7-6, indexes 0-2 in byte 0 bits 5-0, then four per byte from index 3 (E-0338)
DEF RESIST_BLAZE EQU 0
DEF RESIST_FIREBAL EQU 1
DEF RESIST_BANG EQU 2
DEF RESIST_VACUUM EQU 3
DEF RESIST_BOLT EQU 4
DEF RESIST_ICEBOLT EQU 5
DEF RESIST_RADIANT EQU 6
DEF RESIST_SLEEP EQU 7
DEF RESIST_BEAT EQU 8
DEF RESIST_ROBMAGIC EQU 9
DEF RESIST_STOPSPELL EQU 10
DEF RESIST_PANICALL EQU 11
DEF RESIST_SAP EQU 12
DEF RESIST_SLOW EQU 13
DEF RESIST_SACRIFICE EQU 14
DEF RESIST_MEGAMAGIC EQU 15
DEF RESIST_FIREAIR EQU 16
DEF RESIST_FRIGIDAIR EQU 17
DEF RESIST_POISONGAS EQU 18
DEF RESIST_PALSYAIR EQU 19
DEF RESIST_CURSE EQU 20
DEF RESIST_LEGSWEEP EQU 21
DEF RESIST_DANCESHUT EQU 22
DEF RESIST_MOUTHSHUT EQU 23
DEF RESIST_ROCKTHROW EQU 24
DEF RESIST_GIGASLASH EQU 25
DEF RESIST_WATERSHOT EQU 26
DEF NUM_RESISTANCES EQU 27
