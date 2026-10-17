# Mechanics

Stage M5 of the moddable-decomp goal ([roadmap](ROADMAP.md)), evidence E-0396 in the [evidence log](EVIDENCE_LOG.md).
Three mechanics, each written as a specification from the routine's code and checked by running that routine on
the project's emulator (tools/sm83.py) from thousands of generated states. The check compares every output the
specification predicts. `tools/mechanics.py` holds the specifications as Python models:

```bash
python -I tools/mechanics.py all --n 3000
```

A model that agrees on every generated state supports its specification on this emulator: C2, not hardware. The
models read the game's own tables (join chances, growth rows, breeding rules, species records) from the reference
ROM, so the numbers in those tables are not repeated here. Integer widths are as the code has them: "8-bit" means
the result wraps at 256.

Results (2026-10-16, `--n 3000 --seed 1`):

| Mechanic | Routine | Generated states | Agree |
| --- | --- | --- | --- |
| Join offer | BattleEnd_OfferJoin_DecideJoinOffer (16:$5B7E) | 3,000 | 3,000 |
| Level-up gains | ComputeLevelUpStatGainsForBattleArg1 (1A:$6418) | 3,000 | 3,000 |
| Breeding child | ComputeBreedingChild (0E:$5688) | 3,000 | 3,000 |

Each check was also run with a deliberately wrong model (one condition changed), and it then reports the states
that condition decides (tests/test_mechanics.py keeps these as negative tests).

## Random numbers

Both random rolls here come from NextTableByte: `wRandomHi = (wRandomHi + 1) & $7F`, then
`wRandomLo = RandomByteTable[wRandomHi]`, and the routine uses the 16-bit value `wRandomHi:wRandomLo` modulo a
number (DivideHLByA: the remainder). The sequence is fixed by the starting `wRandomHi`. The main loop steps it
once per frame while not linked, so in play the roll depends on timing. The models reproduce the exact sequence,
and each check compares `wRandomHi`/`wRandomLo` afterwards, so the number of rolls is checked too.

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

## Limits

- These are mechanics as code; whether a value matters in play (how the battle meter grows, which items a player
  holds) is outside the check.
- The checks run single routines from set-up memory; they do not play the game to these points.
- The emulator is the project's own (tools/sm83.py), not hardware: timing and hardware registers play no part in
  these routines, but C3 would need hardware.
