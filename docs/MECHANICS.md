# Mechanics

Stage M5 of the moddable-decomp goal ([roadmap](ROADMAP.md)), evidence E-0396 (E-0397, E-0399 and E-0404 for damage, E-0398
for skill learning, E-0405 for the bred child) in the [evidence log](EVIDENCE_LOG.md). Five mechanics, each written as a specification from the routine's code and checked by running that routine on
the project's emulator (tools/sm83.py) from thousands of generated states. The check compares every output the
specification predicts. `tools/mechanics.py` holds the specifications as Python models:

```bash
python -I tools/mechanics.py all --n 3000
```

A model that agrees on every generated state supports its specification on this emulator: C2, not hardware. The
models read the game's own tables (join chances, growth rows, breeding rules, species records) from the reference
ROM, so the numbers in those tables are not repeated here. Integer widths are as the code has them: "8-bit" means
the result wraps at 256.

Results (2026-10-16, damage and skill learning 2026-10-17; `--n 3000 --seed 1`):

| Mechanic | Routine | Generated states | Agree |
| --- | --- | --- | --- |
| Join offer | BattleEnd_OfferJoin_DecideJoinOffer (16:$5B7E) | 3,000 | 3,000 |
| Level-up gains | ComputeLevelUpStatGainsForBattleArg1 (1A:$6418) | 3,000 | 3,000 |
| Breeding child | ComputeBreedingChild (0E:$5688) | 3,000 | 3,000 |
| Plain attack damage | ComputeAttackDamage (bank $36) | 3,000 | 3,000 |
| Skill and attack damage scaled by resistance | 16 routines of bank $36, in turn | 3,000 | 3,000 |
| Damage modifiers of resolve step 7 | ResolveStepComputeDamage (bank $36) | 3,000 | 3,000 |
| Damage taken from HP, resolve step 12 | ResolveStepApplyDamage (bank $36, far call to $32) | 3,000 | 3,000 |
| wBattleStatus7 multipliers of the message step | ApplyDamageModifiers (bank $32) | 3,000 | 3,000 |
| The other damage routines | 28 routines of bank $36, in turn | 3,000 | 3,000 |
| The bred child's sex, resistances, skill list and stat bonus | 4 routines of bank $0E, in turn | 3,000 | 3,000 |
| Skill learning on a level-up | FindNewlyLearnableSkills (bank $1A) | 3,000 | 3,000 |

Each check was also run with a deliberately wrong model (one condition changed), and it then reports the states
that condition decides (tests/test_mechanics.py keeps these as negative tests).

## Random numbers

Every random roll here comes from NextTableByte: `wRandomHi = (wRandomHi + 1) & $7F`, then
`wRandomLo = RandomByteTable[wRandomHi]`, and the routine uses the 16-bit value `wRandomHi:wRandomLo` modulo a
number (DivideHLByA: the remainder). The sequence is fixed by the starting `wRandomHi`. The main loop steps it
once per frame while not linked, so in play the roll depends on timing. The models reproduce the exact sequence,
and each check compares `wRandomHi`/`wRandomLo` afterwards, so the number of rolls is checked too.

In battle the rolls go through AdvanceRandom. In link play (wLinkMode not 0) it steps the copy in
wRandomSeed2Lo/Hi instead and writes the result to both places; the damage checks generate link states too and
compare both pairs. RandomInRange(lo, hi) is `lo + R mod (hi - lo + 1)`, 16-bit, with R the word after one step;
when lo equals hi it returns lo and takes no step, so a zero-width range costs no roll.

## Join offer (recruiting a defeated monster)

Inputs: wLinkMode, wBattleKind, wDisplaySlot (the defeated foe's slot), wFoeJoinClass1[0..3], wBattleMonsterId,
the species flags (seen monsters), the species record's join class, wBattleEndFlag, the battle meter (a 16-bit
word) and the random state. Output: wDisplaySlot is left as it is (the foe offers to join) or set to $FF (no offer);
wBattleFoeCount = 1 either way.

```text
no offer when: linked; wBattleKind is 3, 4, 5 or 8 and above; the slot is not 4-6; the slot's join class
               (wFoeJoinClass1[slot & 3]) is 7
seen = the species flag of wBattleMonsterId[slot]
if not seen:
    roll = random % 200
    class = SPECIES_JOIN_CLASS of the species             # 7 means never
    if class == 7: no offer
    if JoinChanceByClass[class] >= roll: OFFER            # a first sighting can join outright
    if wBattleEndFlag: OFFER
    table = BattleEnd_OfferJoin_DecideJoinOffer_Data1     # scales x5, x2, x1, /2, /5, /16 by join class
else:
    table = BattleEnd_OfferJoin_DecideJoinOffer_Data2     # scales x1, /4, /8, /8, /8, /20 by join class
m = table[join class]
if m == 0: OFFER;  if m == 7: no offer;  if wBattleEndFlag: OFFER
value = meter scaled by m (16-bit: x5 and x2 wrap at 65536; divisions round down)
value = value - (random % 91 + 10)                        # 16-bit
if bit 15 of value is set: no offer                       # also when the meter scaled to 32768 or more
if random % 100 + 1 < 91: OFFER else no offer             # a final 90 in 100
```

Notes: when the first-sighting roll succeeds, no further roll is taken. A meter that scales to $8000 or more is
treated as negative, so a huge meter refuses instead of guaranteeing the offer. That is a property of the code, not
seen in play.

## Level-up stat gains

Input: an SRAM monster record (wBattleArg1 = its number; records are $A5 bytes from sRecords). Output: the 8 bytes
of wLevelUpGains: the gains for MAX HP, MAX MP, ATK, DEF, AGL and INT, then the item-bonus stat and amount.

```text
gains = 0 x 8
if MON_LEVEL >= MON_MAX_LEVEL: return gains               # no growth at the cap
bonus stat, bonus = $FF, 0
if MON_ITEM is $1D-$22 (the six growth items):
    bonus stat = MON_ITEM - $1D                           # 0 HP ... 5 INT
    values = MON_LEVEL, the low bytes of MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL, MON_INT, MON_WLD,
             and the name's length (MON_NAME bytes before $F0, not counting $8D and $8E)
    bonus = (number of values whose bit 0 equals bit 0 of MON_PLUS) / 2     # 0 to 4
for each stat i in HP, MP, ATK, DEF, AGL, INT:
    row = the species record's SPECIES_GROWTH + i
    gain = StatGrowthTable[row][MON_LEVEL]                # 32 rows of 99 bytes
    if i == bonus stat: gain = (gain + bonus) & $FF
    gains[i] = what still fits under 999 for that stat word (ClampDeltaTo999)
gains[6], gains[7] = bonus stat, bonus
```

ClampDeltaTo999(word, gain) uses 16-bit arithmetic:
- the gain itself when word + gain is at most 999;
- 999 - word when it is not;
- 0 when the word is exactly 999.

A word above 999 gives a meaningless value, the low byte of 256 - (word - 999), which the model reproduces. The
level-up itself (ApplyLevelUpToRecordBattleArg0) adds gains[0..5] to the record; it is not part of this check.

## Breeding child

Inputs: the parent records wRecordBufA (A) and wRecordBufB (B) and wArg1 = the kind of breeding (0 the farm,
1 a townsperson, 2 a link). Outputs checked:
- the child species (wArg6/wArg7 and MON_SPECIES);
- MON_PLUS and MON_MAX_LEVEL;
- the four personality bytes;
- MON_LEVEL = 1, MON_EGG = 1 and MON_STATE = 1.

Not checked: sex, resistances, skills and stats. Those come from later routines that roll random numbers
(RollChildSexFromSpecies, RollChildResistancesToChildRecordResistances, BuildChildRecordSkillListCandidateList,
ApplyBreedingBonusToChildStats).

The species is the first match of four tables (bank $0E):

```text
1. BreedSpeciesRuleTable[A species]: a list of 2-byte entries, result index n = 0
     $FFxx  end of the list
     $FDxx  n + 1
     $FBxx  n + 1 in link breeding (kind 2); the end of the list otherwise
     $FEtt  matches when B's plus >= tt and A and B are the same species
     $FCtt  matches when A's plus >= tt and A and B are the same species
     other  matches when it equals B's species
   a match gives BreedSpeciesResultTable[A species][n]
2. BreedFamilyRuleTable[A species]: one family per byte, n = the entry's position
     $FF end;  $FE skipped in link breeding, the end otherwise;  other: matches B's family (MON_FAMILY & $0F)
   a match gives BreedFamilyResultTable[A species][n]
3. FamilyBreedRuleTable[A family]: species words as in 1, with $FD and $FFxx only, matched against B's species
   a match gives FamilyBreedResultTable[A family][n]
4. FamilyPairResultTable[A family][B family]: a species; $FFxx = A's species; $FExx = no child
```

On "no child" the routine sets wArg6/7 = $FFFF, wNameEntryState = 6 and wArg5 = $FF, and stops. No pair of the 11
real families gives $FExx; only out-of-range families reach it.

```text
plus base = A's plus when kind is 1 or 2, otherwise the larger of A's and B's plus
level sum = (A's level + B's level) & $FF
plus = base + (5 if sum >= 100, 4 if >= 76, 3 if >= 60, 2 if >= 40, else 1), at most 99
max level = SPECIES_MAX_LEVEL of the child species + 3 x plus, at most 99
personality[k] = ((A's byte k + B's byte k) & $FF) / 2      # the carry of the sum is lost
```

Checked over 3,000 generated pairs:
- half the B parents are taken from A's rule list, so stage 1 is exercised;
- 10 in 100 are the same species, with pluses around the thresholds;
- the rest are random species with a real family.

Rule-list matches (stages 1 to 3), the family-pair table and its "A's species" result all occur (641, 1,078 and 281 of 2,000 in one run). Parents whose species record has family 15 are not real
monsters: their tables read past their ends, so they were not generated.

[Breeding paths](BREEDING_PATHS.md) uses this specification to find the fewest breedings from a map's wild
monsters to a species (E-0400).

## Damage

Battle slots 0-7 index word arrays (wBattleATK, wBattleDEF: slot x 2) and the status bytes (wBattleStatus1-8:
slot x 9); wBattleActor and wBattleTarget are slots. The damage word is wBattleDamageLo/Hi, 16-bit throughout.

### The plain attack (ComputeAttackDamage, the formula ComputeBasicDamage)

```text
one random step (its value is not used)
d = DEF of the target / 2                                  # ComputeBasicDamage takes d from its caller
if ATK <= d:  damage = RandomInRange(0, 1)
half = (ATK - d) / 2
if ATK / 16 >= half:  damage = RandomInRange(0, ATK / 16)  # a weak hit: up to a sixteenth of ATK
else:  damage = half + RandomInRange(-(half / 16), half / 16) + RandomInRange(-1, 1)
```

All divisions round down. So the attack does (ATK - DEF / 2) / 2, give or take a sixteenth, and when that is
small, up to a sixteenth of ATK instead. Fight (ActionEffect_Fight) is this plus the hit message;
ActionEffect_ActionD7_Damage calls ComputeBasicDamage with d = 0 for two slots.

### Skill damage and resistance (16 routines)

`tools/mechanics.py` reads these routines from src/ (one that does not end in `ret` runs into the next, as the
code does) and checks each one: a roll, a 2-bit resistance level and a table.

```text
roll (skills):  base word and spread byte from the skill record, at +$D/+$E/+$F for an actor in slots 4-7 unless
                wLinkMode is 1, otherwise at +$9/+$A/+$B;  damage = RandomInRange(base, base + spread)
roll (attack):  the plain attack above                     # the AttackDamageScaledBy...Resistance routines
level = a 2-bit field of the target's 7-byte wSlotResistances record (below); 0 for ActionEffect_ActionD1_Damage
table = by the target's wBattleStatus8 byte: bit 6 (BSTAT8_MAGIC_WALL) first, then bit 7 (BSTAT8_EERIE_LITE),
        else the routine's default
damage = table[level](damage)
```

| Table | Level 0 | 1 | 2 | 3 |
| --- | --- | --- | --- | --- |
| 1_085_05_0 | d | d x 85 / 100 | d / 2 | 0 |
| 1_075_04_0 | d | d/2 + d/4 | (d x 8 / 10) / 2 | 0 |
| 131_116_075_03 | d + d/4 + d/16 | d + d/8 + d/32 | d/2 + d/4 | (d x 6 / 10) / 2 |
| 075_05_025_0 | d/2 + d/4 | d / 2 | d / 4 | 0 |

| Picker | Bit 6 | Bit 7 | Neither | Used by |
| --- | --- | --- | --- | --- |
| ScaleDamageByFlagsAtHL | 1_075_04_0 | 131_116_075_03 | 1_085_05_0 | Blaze, Firebal, Bang, Infernos, Bolt, IceBolt, RockThrow, GigaSlash, ActionD1 |
| ScaleDamageByFlagsAtHLAlt | 075_05_025_0 | 131_116_075_03 | 1_075_04_0 | BigBang, FireAir, FrigidAir |
| ScaleDamageByFlagsAtHLBit6 | 1_085_05_0 | 131_116_075_03 | 131_116_075_03 | the four AttackDamageScaledBy...Resistance routines |

Resistance fields read (byte: bits): byte 0: 1-0 Bang, 3-2 Firebal, 5-4 Blaze and BigBang; byte 1: 7-6 Vacuum
(Infernos), 5-4 Bolt, 3-2 IceBolt; byte 4: 5-4 FireAir, 3-2 FrigidAir; byte 6: 5-4 RockThrow, 3-2 GigaSlash.

Properties of the code (C2 on the emulator; what the status bits mean in play is C1):
- Level 3 gives 0 damage except under bit 7, where it gives 30 percent.
- Under bit 7 a target with level 0 or 1 takes more than the roll: 21/16 or 37/32.
- The attack-based routines' picker has no plain table: without bit 6 it uses the bit-7 table, so an unresisted
  hit does 21/16 of the attack.
- The 21/16 and 37/32 sums wrap at 65,536.

### Resolve step 7 (ResolveStepComputeDamage)

The step that finishes the damage after the action's effect routine has set it. With the actor's
BSTAT2_CRITICAL_ROLLED set it first returns unchanged (the step not advanced) until wSoundChannelSlots AND
wSoundChannel1 is $FF. Then the step advances. rec5 and rec6 are bytes 5 and 6 of the skill record in
wRecordBufferData.

```text
the first that applies:
    rec6 bit 4 and the actor's BSTAT1_ATK_DOUBLED:      damage x 2
    rec6 bit 3 and the actor's BSTAT2_CRITICAL_ROLLED:  clear that bit; store the hit message (actor $35, target
                                                        $D0, flags $A8, argument $88); damage =
                                                        RandomInRange(ATK - ATK/20, ATK + ATK/20); skip the next line
    rec6 bit 5 and the actor's BSTAT4_CHARGE_UP:        damage x 2
    rec5 bit 1 and the actor's BSTAT4_SUCK_AIR:         damage = RandomInRange(2 d, 2 d + d/2)
bit 6 of the actor's wPersonalityActs byte:             damage + damage / 2
the target's wBattleStatus7 bits 0-2, when any is set:
    only bit 2, with rec5 bit 7:                        damage / 2
    bit 0 or 1, with rec6 bit 7:                        damage / 2 for bit 0, else damage / 10
    after either change, bit 1 of the target's wPersonalityActs byte:  damage / 2 again
the target's BSTAT6_BERSERK with rec5 bit 7, unless the action is SKILL_RAMMING or SKILL_KAMIKAZE:  damage x 2
```

So a critical hit ignores the target's DEF: it is the actor's ATK within 5 percent, before the target's modifiers.
The doublings wrap at 65,536.

### The message step's multipliers (ApplyDamageModifiers)

Resolve step 10 (ResolveStepDamageMessage) far-calls it before the damage message, for ACTION_D7 only:

```text
b = the target's wBattleStatus7;  its bits 0-3 are cleared (bits 4-7 kept)
damage x 2 if bit 0, else x 10 if bit 1, else x 2 if bit 2      # 16-bit, wrapping; bit 3 has no effect
```

Step 7 reads the same bits the other way (bit 0 halves, bit 1 divides by 10); for ACTION_D7 the two meet.

### Applying the damage (ResolveStepApplyDamage, resolve step 12)

It far-calls ApplyDamageToTarget in bank $32:

```text
wBattleResolveStep += 2 (to step 14, the aftermath);  wBattleSubStep = 0
by the top two bits of wResolveMsgArg:
    00:  nothing more
    01:  set bits 0-2 of the target's wLevelUpGains byte
    10, 11:  HP = the target's wBattleHP word - damage;
             when that is 0 or below: HP = 0, wBattleResolveStep -= 1 (to step 13, the defeat), wBattleSubStep2 = 0;
             then set bits 0-2 of the target's wLevelUpGains byte
```

A hit that leaves exactly 0 HP is a defeat, like one that would go below 0. The resolve message argument decides
whether the action touches HP at all (StoreHitMessage_Bank36 stores $88, top bits 10).

### The other damage routines (E-0404)

`tools/mechanics.py effects` checks 28 more routines of bank $36, each against its model (the family a routine
tests is read from its `cp $NN` in src/). The target's family is byte 0 of its species record
(GetTargetSpeciesFamily: wBattleMonsterId of the target, LoadSpeciesRecord).

| Routines | Damage |
| --- | --- |
| AttackDamageHalvedDEFVs... (10, one per family 0-9) | the plain attack; against the named family DEF is halved first (so DEF / 4 is used) |
| ComputeAttackDamageWithHalvedDEF | the plain attack against DEF / 4; the DEF word is put back |
| AttackDamageWithATK200 | the plain attack with ATK 200; the ATK word is put back |
| AttackDamageTimes1_5IfSlotBodyFlagsBit0 | the plain attack, then d + d/2 + 1 when bit 0 of the target's wSlotBodyFlags is set (a metal body) |
| ActionEffect_ActionD2/D3/D4_ScaleByGigaSlashResistance | GigaSlash's roll and scaling, then d + d/2 against families 0, 8, 9 / 1, 3, 6 / 2, 4, 5 |
| ActionEffect_BiAttack_Damage | ATK' = 30 x ATK (16-bit) cut to 75% (BiAttack) or 62.5% (QuadHits); ComputeBasicDamage(ATK', (30 x DEF) / 2) / 30 |
| ActionEffect_WindBeast_Damage | L = the actor's level: 3L + 10 (L + L/2 for a foe outside link mode 1), at most 180; plus RandomInRange(-q, q), q = ((d x 6/10) / 2) / 2; Vacuum resistance |
| ActionEffect_Vacuum_Damage | 2L + 30 (L + L/2 only when wLinkMode is 4 or more and not 1), at most 150; plus about 10%; Vacuum resistance |
| ActionEffect_Lightning_Damage | 2L + 20 (L + L/2 for a foe), at most 180 (220 against family 9); plus about 10%; Bolt resistance |
| ActionEffect_CallHelp_Damage | 2L (L + L/2 for a foe), scaled by byte 6 bits 5-4 |
| ActionEffect_MegaMagic_Damage | 2 x wAllMPSpent + 2L, plus about 10%; byte 4 bits 7-6 with the Alt table picker |
| ActionEffect_ActionD9_Damage | 8 x wAllMPSpent + 8 x the level of slot E (the E the caller left), 16-bit; then as MegaMagic |
| ActionEffect_ActionD7_Damage, _ActionD8_Damage | the actor's ComputeBasicDamage against 0 (D7) or plain attack (D8), plus its formation partner's; wBattleActor is put back |
| ActionEffect_MultiCut_Damage | the skill record of wBattleActionId (LoadSkillRecord), its roll; d + d/4 + d/16 against family 7; Vacuum resistance with the Alt picker |
| ActionEffect_Watershot_Damage | the skill roll, byte 0 bits 7-6, the plain picker for SKILL_WATERSHOT and the Alt picker otherwise |
| ActionEffect_Kamikaze_Damage | a chance roll by byte 3 bits 1-0 (RollChanceByFlagsAtHL); on failure 0 and no carry; on success carry and: 1 when the word at the address the actor's HP names is 1, else the target's HP - 1 (no link, wBattleKind 0 or 1) or (the actor's HP - 1) / 2, at least 1 |

"About 10%" is RandomInRange(-q, q) with q = ((d x 8/10) / 2) / 4, no roll when q is 0. The formation partner
(ActorFormationSlotToTemp0) is the other slot of the pair (0,1), (0,2) or (1,2) that the side's formation byte
picks. Kamikaze's word read takes the HP value as an address (bank $00 for HP below $4000): HP 362, 382 and 613
read a word of 1, so the damage is 1 then. It looks like a second dereference by mistake (C1); the check follows
it exactly. The chance roll: level 0 always succeeds and level 3 never; levels 1 and 2 take a new wRandomLo below
$D8 / $7F (neither status bit), $BF / $66 (bit 6) or always / $BF (bit 7).

Checked: 3,000 of 3,000 states, about 107 for each routine, with the ATK and DEF words and wBattleActor compared
afterwards. A model that halves DEF against every family, and one without Kamikaze's word read, are each caught.

Not checked here: the defeat sequence of step 13 and the aftermath of step 14.

## The bred child's later rolls (E-0405)

After ComputeBreedingChild, four routines of bank $0E finish the child in wChildRecord from its parents in
wRecordBufA and wRecordBufB. `tools/mechanics.py child` checks each one.

The random value is RandomModulo29: one NextTableByte step, then `((lo << 1) & mask) x 256 + lo` divided by 41,
0-99 with mask $0F and 0-199 with mask $1F. Its `rl a` shifts in the carry NextTableByte leaves, which is always 0
because RandomByteTable sits at $0973 and an index of at most $7F never carries.

```text
sex (RollChildSexFromSpecies): the child species' SPECIES_SEX_RATIO byte; 0 gives male (0); otherwise female (1)
    when a roll 0-99 is not above SexChanceByClass[byte & 3] (0, 10, 50, 90), else male
resistances (RollChildResistancesToChildRecordResistances), for each of the 27, from the species level:
    3 stays; the parents' levels (each $FF when it is 2 and the parent's MON_ITEM, 1-$1B, hides that resistance
    by TestResistanceEntry_Data) are added: at least 5 for a level 2, at least 3 for a level 0 or 1, else no roll;
    no roll either when the child's MON_PLUS is 0
    level 2: sum 5 rolls 0-199 against the plus (+1 when not above); other sums: +1 by a plus roll of factor 2
    level 0-1: sum 3 factor 1; 4 factor 3; 5 factor 10, and when that succeeds factor 3 once more; 6 or more +1
        and then factor 5
    a plus roll of factor f succeeds when f x plus is 100 or more, or a roll 0-99 is not above it
    the result's low two bits go to MON_RESISTANCES
skill list (BuildChildRecordSkillListCandidateList): MON_SKILLS all $FF; the 25-byte list = the three natural
    skills of the child, parent A and parent B species, then the eight MON_SKILLS of A and of B; each mapped to
    the first of its line (SkillLineBaseTable); zeros and repeats become $FF; the rest move to the front (the
    places after them keep their old bytes), and the repeats this leaves become $FF again
stat bonus (ApplyBreedingBonusToChildStats): 5 when the parents' PersonalityPairMatrix value is 0, 5 when both
    are at their level cap, 2 when both pluses are 5 or more with an even sum, 3 for a link or townsperson breeding
    (wArg1 not 0); with a total c, each of the eight stat words w gains (c x w) / 100 rounded up, capped at 999
```

The stat bonus divides only the low 16 bits of the 24-bit product c x w, so a stat word above 4,369 (for c = 15)
gains less than its percentage. The check generates such words too. The personality value: each parent's index is
9 x grade(MON byte $6F) + 3 x grade($72) + grade($70), with grade 0 for $C0 and up, 1 for $40-$BF and 2 below.
Matrix byte 8 x index(A) + index(B) / 4 holds four 2-bit values, the highest pair first.

Checked: 3,000 of 3,000 generated families, the four routines in turn, comparing the child's bytes and the random
state. Half of parent A's records carry an item that hides a level-2 resistance. A model without that item test,
and one that divides the whole product, are each caught.

## Skill learning (FindNewlyLearnableSkills)

After a level-up, BattleEnd_GainExperience_ShowNewSkills fills wWorkBuf ($38 bytes) with the monster's 8 skills
(MON_SKILLS) and $FF, then calls FindNewlyLearnableSkills once for each new skill, adding each result to wWorkBuf.
wBattleArg0 is the party slot; its record is wPartyList[slot & $7F] (the slot itself in a link battle,
wGameMode 4). SkillRequirementTable (bank $1A) has 170 rows of 18 bytes, one per skill number: a level byte, six
required words (MAX HP, MAX MP, ATK, DEF, AGL, INT) and five prerequisite bytes ($FF = none).

```text
for skill c = 0 .. 169, the first that gives a result:
    skip c if it is in wWorkBuf
    skip c if (MON_LEVEL + 1) & $FF < the row's level      # the level the monster is reaching
    skip c if any of MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL, MON_INT < its required word (16-bit)
    if c is in the 25-byte MON_SKILL_LIST:  set that entry to $FF;  result 0 ("learned")
    p1..p5 = the prerequisite bytes
    if p1 is not $FF:
        hTemp6 = p1
        if c is not $3D:  if p1 is among MON_SKILLS: hTemp5 = p1; result 1 ("p1 became c")  else skip c
        else (skill $3D):  skip c unless p1 is among MON_SKILLS, then go on below
    skip c if p2 is $FF
    if p2 and each further prerequisite up to a $FF are all among MON_SKILLS:  result 2 ("devised")
    else skip c
no result: hTemp3 = hTemp4 = $FF
```

The result is hTemp3 = c and hTemp4 = 0, 1 or 2. So a skill comes from the monster's own list (its species'
natural skills and those added by breeding) once the level and stats allow it; an upgrade replaces the skill it
grows from; and a skill with several prerequisites and no single "from" skill is devised when all of them are
known. Skill $3D (SKILL_MEGAMAGIC, from the ROM's skill names) is the one row with both: it needs its first
prerequisite and the others, and is devised, not an upgrade.

The check generates records around one row at a time (the level and stats at, just above or below its
requirements; its prerequisites mostly known), so all four results occur: 1,353 learned, 194 upgrades, 176
devised (38 of them skill $3D) and 1,277 with none, in one run of 3,000. A model that compares MON_LEVEL without
the + 1, and one that treats skill $3D as an upgrade, are each caught.

Not checked here: the caller's display and its update of wWorkBuf and MON_SKILLS, and CheckSkillsLearnableAtLevel,
which builds the skills of a foe's battle record from the same table.

## Limits

- These are mechanics as code; whether a value matters in play (how the battle meter grows, which items a player
  holds) is outside the check.
- The checks run single routines from set-up memory; they do not play the game to these points.
- The emulator is the project's own (tools/sm83.py), not hardware: timing and hardware registers play no part in
  these routines, but C3 would need hardware.
