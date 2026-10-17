# Tutorial 3: a breeding recipe

Goal: breeding a DrakSlime (the first parent) with a Slime gives a MetalKing. The finished mod is
mods/tutorial_breeding/.

## 1. How the game finds a child

ComputeBreedingChild looks the child up in four tables. The first one checked is a list kept for the first
parent's species: partner species, and codes between them. [Mechanics](../MECHANICS.md) has the full rules (C2,
checked on 3,000 pairs). In that list:
- a partner species matches the second parent;
- `$fdfd` moves on to the next result;
- `$ffff` ends the list.

A match gives the result at the current position in the species' result list.

Export the tables and open build/data/breeding.json. DrakSlime's lists are:

```text
BreedSpeciesRules_DrakSlime     MONSTER_SWORDGON, $ffff
BreedSpeciesResults_DrakSlime   MONSTER_SLIMEBORG
```

So DrakSlime with SwordGon gives SlimeBorg.

## 2. Add the recipe

Add a second rule, after a `$fdfd` so that it gets its own result, and add that result:

```text
BreedSpeciesRules_DrakSlime     MONSTER_SWORDGON, $fdfd, MONSTER_SLIME, $ffff
BreedSpeciesResults_DrakSlime   MONSTER_SLIMEBORG, MONSTER_METALKING
```

In the mod folder, data/breeding.json holds only these two lists (mods/tutorial_breeding/data/breeding.json).
Both lists grow. The tool takes the extra bytes from the free space at the end of the bank, and stops if there is
none.

## 3. Build it

```bash
python -I tools/make_mod.py mods/my_breeding
```

## What changed, and how we know

tests/test_tutorials.py builds this mod and runs the game's own ComputeBreedingChild on the modded ROM:
- a DrakSlime and a Slime give a MetalKing;
- a DrakSlime and a SwordGon still give a SlimeBorg.

The routine is the game's; that it is what the farm calls is C2 (E-0396).
