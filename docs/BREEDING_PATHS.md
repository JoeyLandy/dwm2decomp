# Breeding paths

Evidence E-0400 in the [evidence log](EVIDENCE_LOG.md). `tools/breed_path.py` finds the fewest farm breedings
from the wild monsters of chosen maps to a target species. It builds on the breeding-child specification in
[mechanics](MECHANICS.md) (E-0396). The wild lists and the route are read from the reference ROM; label addresses
come from a build's `.sym` file.

```bash
python -I tools/breed_path.py wild --maps 30-45
python -I tools/breed_path.py route DARKDRIUM --maps 30-45
python -I tools/breed_path.py check --maps 30-45 --target DARKDRIUM
```

Map ranges are hexadecimal `hMapId` values; `--maps` can be given more than once. Species names are those of
`src/constants.inc` without `MONSTER_`.

## Wild monsters of a map

A random battle on a story map takes its foes from one encounter entry (C2, E-0375 and the checks below):

1. RunBattleIntroKindCase_RandomEncounter (0A:$49B4) compares `hMapId` with a list of 56 maps. Each map either
   reads a grid table, one word per screen with A screens per row (ReadMapCellWordForScreenXY), or uses one entry
   (FillEncounterFromEntry). On four maps (`$2B` Canal, `$30` Water, `$48` Ice, `$B8` Traveler) `hPlayerStateFlags`
   bit 3 chooses between the two. The tool decodes this dispatch from the routine's bytes and stops on any instruction it
   does not expect.
2. Only screens inside the map record's width and height are read (MapTable, bank `$11`, record bytes +6 and +7,
   E-0142). Maps whose record has an encounter rate of 0 (byte +$0B, bits 0-6) would be listed but not counted, since
   TickRandomEncounterCounter starts no battle then; none of the 56 has rate 0.
3. An entry is 17 bytes: the encounter kind + 1, a cap, five rising thresholds, then one MonsterTable word per
   non-zero threshold. For each of three foes FillEncounterFromEntry takes r = `wRandomLo` & $7F, drawing again
   while r is above the cap, and stores the word of the first slot whose threshold is r or more.
4. `wRandomLo` comes from NextTableByte, which reads RandomByteTable (00:$0973, 128 bytes) at the next
   `wRandomHi`. **Only 94 of the 128 values of r occur**: 6, 15, 18, 19, 29, 31, 36, 37, 43, 44, 47, 48, 49, 60, 61,
   64, 66, 70, 82, 84, 85, 87, 89, 99, 103, 105, 106, 111, 112, 115, 118, 121, 122 and 125 never do. A slot whose
   range holds only missing values is never drawn. That happens twice, on the Float map (`$70`): the last slot of
   entry 0A:$5F83 (Metaly, threshold 19 after 18) and of entry 0A:$5FB0 (Phoenix, the same thresholds). Metaly is
   still met on Float through other entries; Phoenix is not.
5. The MonsterTable record's first word is the species (E-0263).

Which maps make up a world is read from the ROM, not decided by the tool. The key names in bank `$09` run
GreatLog, Oasis, Pirate, Ice, Sky, Limbo, Elf, Lonely, Traveler, Brawn, Baffle, Soul. The map names (system string
10 + map id) group the story maps: `$20`-`$2F` (Desert, Kalka, Asiya, the Canal and Mirage Lake, closed by the
Magic Door at `$29`) and `$30`-`$45` (Water, Yold, Pt.Ritz, Cape, the ship, the volcano, Polona, the lighthouse,
closed by the Magic Door at `$45`). Reading `$30`-`$45` as the Pirate world, the second key, is C1: the key list
order and the map order agree, but no routine linking the two was read.

## The route

Starting from the wild species, the tool breeds every pair it can already make, again and again, and keeps for each
species the recipe with the fewest breedings in total. Each breeding uses up both parents, so a species needed
twice is bred twice. The child comes from `tools/mechanics.breed_species`. Every route uses:

- farm breeding (kind 0);
- both parents at plus 0, so recipes that need a plus are not used;
- parent A first: the first parent record, `wRecordBufA`, whose species and family pick the rule lists.

When several routes have the same number of breedings, the first found in species-id order is kept. Other routes
of the same length exist.

Not modelled:

- the sexes the farm needs;
- any level or other condition the breeding menu checks before ComputeBreedingChild runs;
- recruiting: how likely each monster is to join;
- whether every listed screen can be reached in play.

## Example: Darkdrium from the Pirate world

`route DARKDRIUM --maps 30-45` (2026-10-17): 37 wild species, 260 more reachable by breeding. Darkdrium takes
**132 breedings from 133 wild monsters**. The Oasis maps added (`--maps 20-2F --maps 30-45`, 46 wild species) give
the same count.

Depth is the longest chain of breedings below a step; ×N is how many copies the route needs (parent A first).

| Depth | Breedings |
| --- | --- |
| 1 | Grizzly ×12 = CatFly × DarkEye; Gulpple ×13 = DanceVegi × 1EyeClown; MedusaEye ×8 = DarkEye × DragonKid; RogueNite = JewelBag × RotRaven; Sickler = Pyuro × 1EyeClown; Tonguella ×2 = CatFly × Snaily; Vampirus ×2 = Pteranod × Pteranod; WalrusMan ×6 = Moray × CatFly |
| 2 | AgDevil ×3 = MedusaEye × DragonKid; Andreal ×13 = DragonKid × Gulpple; Grendal ×2 = MedusaEye × CatFly; Skeletor ×12 = Hork × Grizzly; Superten ×2 = Tonguella × JewelBag; WarMantis = Sickler × DarkEye |
| 3 | Akubar = Grendal × Grendal; Armorpion = WarMantis × RogueNite; Blizzardy ×2 = Wyvern × Superten; MetalDrak ×4 = JewelBag × Andreal; Ogre ×3 = AgDevil × WalrusMan; Orochi ×3 = Andreal × MedusaEye; Servant ×6 = Skeletor × Skeletor |
| 4 | BossTroll ×3 = Ogre × WalrusMan; **DracoLord ×6 = Servant × Andreal**; LavaMan ×3 = MetalDrak × Orochi; RainHawk ×2 = Blizzardy × Vampirus |
| 5 | Azurile = RainHawk × DracoLord; GoldGolem ×3 = LavaMan × BossTroll; Jamirus = Akubar × RainHawk; KingSlime ×3 = Snaily × DracoLord; RoseVine = DanceVegi × DracoLord |
| 6 | GoldSlime ×2 = KingSlime × GoldGolem; MetalKing = KingSlime × MetalDrak; Sidoh = Jamirus × RoseVine |
| 7 | DarkMate = GoldGolem × MetalKing; GranSlime = GoldSlime × GoldSlime; Zoma = DracoLord × Sidoh |
| 8-10 | Deathmore = Zoma × Azurile; its second form = Deathmore × Armorpion; its third form = second form × DarkMate |
| 11 | **Darkdrium = Deathmore (third form) × GranSlime** |

Wild catches: DragonKid 24, CatFly 22, DarkEye 21, 1EyeClown 14, DanceVegi 14, Hork 12, JewelBag 7, Moray 6,
Snaily 5, Pteranod 4, Wyvern 2, Pyuro 1, RotRaven 1 (133).

## Checks

`check` runs three comparisons against the game's own routines on tools/sm83.py (C2 for what they compare, not
hardware). Results on 2026-10-17:

| Check | What it runs | Result |
| --- | --- | --- |
| Lists | CollectUniqueEncounterIdsToWorkBuf2_FindTable (0A:$4D5E), the game's listing of an entry's species, for every in-bounds screen of all 56 maps and both values of bit 3 (map `$B8`'s listing ignores bit 3, so only clear there) | all agree |
| Draws | FillEncounterFromEntry (0A:$4CD4) from each of the 128 random states, for each of the 109 distinct entries | the slots drawn are exactly those counted as reachable |
| Pairings | ComputeBreedingChild (0E:$5688) for each breeding of the route | 40 of 40 give the child |

The draws check is exhaustive: NextTableByte's state is `wRandomHi` alone (0-127), and every draw goes through it.

tests/test_breed_path.py keeps two wrong models as negative tests:

- a slot model that lets every r from 0 to 127 occur claims Metaly and Phoenix in the two Float entries, and the
  game never draws them;
- a model with the parents swapped disagrees with ComputeBreedingChild on some breedings of the route.

The two dispatches (the battle's and the listing's) are also compared table by table.

## Limits

- The world grouping is C1 (above).
- Scripted battles, bosses, the arena, key worlds and link breeding are not sources of wild monsters here.
- A route is the fewest breedings under the assumptions above. It is not the fastest in play time.
