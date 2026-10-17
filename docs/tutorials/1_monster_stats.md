# Tutorial 1: a monster's stats

Goal: make the Slimes you meet in the wild tougher, with 99 base HP instead of 25. You need the setup of
[making a mod](../MODDING.md) done once. The finished mod is mods/tutorial_stats/.

## 1. Find the monster

Monsters you meet are rows of MonsterTable. Export the tables:

```bash
python -I tools/datatables.py export --out build/data
```

Open build/data/MonsterTable.csv in a spreadsheet. Each row is one monster as it appears in battle:
- `species` (MONSTER_SLIME, ...);
- its four skills;
- `level`;
- the base `hp`, `mp`, `atk`, `def`, `agl` and `int`.

Row `id` 1 is a Slime with `hp` 25.

## 2. Change it, and keep only that row

Set row 1's `hp` to 99. Then make a mod folder holding only what you changed:

```text
mods/my_tougher_slimes/
  mod.json             {"name": "my_tougher_slimes", "version": "1"}
  data/MonsterTable.csv
```

In the CSV keep the header line and row 1, and delete the other rows. The tool only rewrites what the file lists,
and a small file shows clearly what your mod does. The file name is the table's name.

## 3. Build it

```bash
python -I tools/make_mod.py mods/my_tougher_slimes
```

It prints `data: 1 lines and 0 lists`, builds, runs the smoke test (the Slime is not met in the scripted opening,
so the screens stay the original's), and writes build/mods/my_tougher_slimes/my_tougher_slimes.bps.

## What changed, and how we know

The game copies a monster's row with LoadMonsterRecord when a battle sets it up. tests/test_tutorials.py builds
this tutorial's mod and runs that routine for monster 1 on the modded ROM: the base HP it copies is 99. That the
word is the base HP is C2: tested on the emulator, not in a full battle.
