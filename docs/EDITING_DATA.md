# Editing the game's data

Stage H2 of the modding and translation goal ([roadmap](ROADMAP.md)), evidence E-0405 in the
[evidence log](EVIDENCE_LOG.md). The game's tables are `db`/`dw` lines in src/, the source (D-015). You can edit
them there directly, or export them to JSON and CSV files, edit those in a spreadsheet, and import them back.

```bash
python -I tools/datatables.py export --out build/data
python -I tools/datatables.py import build/data/SpeciesRecords.csv
python -I tools/build.py --out build/run1
```

`export` reads src/, so it shows your earlier edits too. `import` changes src/ in place. Only the values of
fields you changed are rewritten, so comments and layout stay. Build afterwards: an edited tree is a mod, so
tools/build.py reports it as `MODDED BUILD` with the number of bytes that differ from the original. Build a copy
instead of src/ itself with `--src DIR`.

## What can be edited

| File | Tables | One entry is |
| --- | --- | --- |
| species.json, SpeciesRecords.csv | SpeciesRecords | a species' family, sex ratio, join class, level cap, EXP curve, natural skills, field ability, six growth rows, 27 resistance levels, base EXP |
| monsters.json, MonsterTable.csv | MonsterTable, MonsterTableA2 | a monster (as met in battle): species, four skills, EXP, join class, level, base HP, MP, ATK, DEF, AGL, INT, personality bytes |
| skills.json, SkillTable.csv | SkillTable | a skill's 17 bytes (family, type, usability and tactic, target, numbers) |
| items.json, ItemTable.csv | ItemTable | an item's 13 bytes (its amount at bytes 1-2) |
| encounters.json | EncounterGroup_*, EncounterGrid_*, ScriptedEncounterTable, ArenaEncounterList0-3 | a wild encounter entry (kind, cap, five thresholds, monsters); the entry each map screen uses; a set battle; an arena list |
| breeding.json | the seven tables ComputeBreedingChild reads | a list of partner species or rule codes, and of results (see the Breeding child section of [mechanics](MECHANICS.md)) |
| shops.json, ShopPercentTable.csv | ShopItemListTable, ShopPercentTable | a shop's item list (ended by $ff); its sell percentage |
| ai.json, AIPersonalityWeightTable.csv | AIPersonalityWeightTable | an AI weight row: 27 signed words, one per personality |

Values are written as in src/: `MONSTER_SLIME`, `SKILL_BLAZE`, `$2d`, `25`, or a label. In a CSV, a field with
several values holds them separated by spaces. What each field does in the game is in its note in src/ and
config/tables.json; most are C1 (a reading, not yet checked in play).

Rules the tool enforces:
- A fixed field keeps its number of values: a field written as two `db` bytes takes two values, not one `dw`.
- A list (breeding rules and results, a shop's items) may grow or shrink. The bank's trailing `ds` fill takes up
  the difference, so the bank keeps its size. When the fill is too small, the import stops and names the bytes
  missing; move a section to another bank first (tools/move_section.py).
- An entry of a pointer table (which list a species or a shop uses) can point to any existing list.

## How it is checked

tests/test_datatables.py, on the project's emulator (C2, not hardware):
- Export then import without changes rewrites nothing, so the original build is unaffected (`datatables.py check`).
- One copy of src/ gets one edit in each of 12 tables. It builds as a mod, and the game's own reader returns each
  edited value from the modded ROM:

| Edit | Reader |
| --- | --- |
| DrakSlime's level cap | LoadSpeciesRecord |
| a monster's base HP | LoadMonsterRecord |
| a skill's word field | LoadSkillRecord |
| an item's amount | LoadItemRecord |
| a shop's sell percentage | ComputeSellPrice |
| a shop's list, one item longer | LoadArg1PointerForScreenTableIndex |
| an AI weight | ReadBank6TableWord |
| an encounter entry's monster | FillEncounterFromEntry, from all 128 random states |
| the entry of a map screen | CollectUniqueEncounterIdsToWorkBuf2_FindTable |
| a set battle's monsters | StartScriptedEncounterTemp0 |
| a breeding result | ComputeBreedingChild |
| an arena list | its bytes at the label in the modded ROM (the arena's reader runs inside a scene) |

## Limits

- The tables above are the ones the tool knows. Other data is edited in src/ directly.
- Adding a new list (a new shop) needs its label in src/ first. Adding records to a fixed-size table changes code
  that indexes it and is not supported by the tool.
- Strings (monster, skill and item names) are text, handled by the text pipeline (H3).
