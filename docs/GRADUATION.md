# Graduating src/

Stage H1 of the modding and translation goal ([roadmap](ROADMAP.md)), done 2026-10-17 (E-0402, E-0403, E-0407); decision D-015 in
[project status](PROJECT_STATUS.md). Measured 2026-10-17 on master f276d52.

## Why

Until now src/ was generated. tools/disasm_all.py traced the ROM, named and annotated the result from config/
(names.json, annotations.json and 14 other files), and tools/present.py wrote src/ from that listing. That suited
the readability goal: one place for every name and note, and a whole-tree regeneration after each batch. It does
not suit modders or translators. An edit made in src/ was lost at the next regeneration, so changing the game
meant learning the config/ formats. pokered and pokecrystal, the models for this project, are edited directly.
After H1, src/ is the source and config/ is no longer needed to build, read or check it.

## What already holds

- tools/build.py needs only src/, the reference ROM (for the asset files, D-008) and the target manifest. It
  reads nothing else from config/.
- tools/doc_coverage.py and tests/test_doc_coverage.py check the notes on src/ itself.

## What depends on the generator (2026-10-17)

45 tools and tests read config/, read build/listing/ (the annotated listing with addresses), or import
disasm_all.py or present.py:

| File | config/ files read | build/listing/ | Imports the generator |
| --- | --- | --- | --- |
| tools/apply_drafts.py | annotations, names, probe_exclusions, tables | yes | |
| tools/check_note_grounding.py | names | yes | |
| tools/collect_streams.py | observed_streams | | |
| tools/describe.py | names | | |
| tools/disasm_all.py | 16 files | writes it | |
| tools/doc_coverage.py | annotations, name_families | | yes |
| tools/explore.py | | yes | |
| tools/find_stream_chains.py | stream_chains | | |
| tools/gb_constants.py | battle_status, story_flags | | |
| tools/label_map.py | names | yes | |
| tools/leftover_code.py | code_entries | | |
| tools/mechanics.py | symbols | | |
| tools/present.py | annotations, banks, name_families, names | yes | |
| tools/probe_scope.py | probe_exclusions, probes | yes | yes |
| tools/ram_uses.py, status_bits.py, talk_check.py | | yes | |
| tools/rank_unnamed.py | symbols | yes | |
| tools/readability_queue.py | indexed_dispatch, name_families, names | | yes |
| tools/tables_export.py | tables | | |
| tests/test_apply_drafts.py | annotations, names, tables | | yes |
| tests/test_battle_trace.py | record_fields | | |
| tests/test_constants.py, test_label_map.py | names | | |
| tests/test_doc_coverage.py | annotations, names | | yes |
| tests/test_dynamic.py | names, symbols | | |
| tests/test_fold_idioms.py, test_present.py | | yes | yes |
| tests/test_generated_source.py (split in H1b, E-0403) | data_regions, symbols | yes | |
| tests/test_incbin_identified.py, test_note_grounding.py, test_resistances.py, test_step_names.py, test_story_flags.py, test_text.py | | yes | |
| tests/test_local_labels.py, test_sections.py, test_structure_data.py | | | yes |
| tests/test_name_claims.py | names | yes | yes |
| tests/test_probe_scope.py | probe_exclusions | yes | yes |
| tests/test_probes.py | annotations | | |
| tests/test_record_fields.py | record_fields | yes | yes |
| tests/test_routine_behaviour.py | name_families, names, stream_chains | yes | |
| tests/test_sprite_warp_commands.py | symbols | | |
| tests/test_tables.py | tables | yes | |

Recomputed with a scan for `config/<name>.json`, `build/listing` and `import disasm_all` or `import present` in
tools/*.py and tests/*.py.

## Steps

**H1a. The generator stops writing src/ (2026-10-17).** disasm_all.py and present.py write build/regen/src/ by
default. `--write-src` keeps the old behaviour for the transition. tools/src_drift.py compares the regenerated
tree with src/ and lists each file that differs, is missing or is extra. It reported no difference on the tree
that made this switch, so the switch changed no source byte. build/listing/ is still written, so the tests that
read it keep working.

**H1b. Checks on src/, not on the listing (done 2026-10-17, E-0403 and E-0407).** Each test that read
build/listing/ or imported the generator now checks src/, with addresses from the .sym of a build of the same tree,
or became a check of the generator that skips without its listing.

tools/source_tree.py is what the moved checks read:
- the bank files;
- each label's bank, from the SECTION it is defined in and the bank src/layout.link gives that section, so no
  build is needed;
- each label's note (the comment block above it);
- `listing_spelling`, which turns a src/ instruction back into the listing's spelling (`xor a` is `xor a, a`,
  `cp $2b` is `cp a, $2B`), so audits written against the listing read src/ unchanged;
- a digest of every src/ file, which tools/build.py now records in its report as `source_digest`;
- the .sym of the newest passing build whose digest is the current tree's (fresh_sym). A check that needs an
  address skips when no build matches, instead of reading a build of another tree.

| Test file | Now |
| --- | --- |
| test_generated_source.py | Split (E-0403): test_source_audits.py checks src/; test_generator_listing.py keeps the 7 checks of the generator's copy of config/ |
| test_probes.py | C2 notes read from src/ and matched to probes through the fresh .sym (the same 5,948 keys as config/annotations.json) |
| test_constants.py | an entry named after an item sits at that item's index, without config/names.json |
| test_fold_idioms.py | macros counted, and unfolded idioms looked for, in src/ |
| test_routine_behaviour.py | skill table rows, stream files, case and copy names read from src/; the family-name check moved to the generator's tests |
| test_present.py | the checks of src/ run always; the two that compare the listing with the regenerated tree skip without them |
| test_story_flags.py, test_resistances.py, test_tables.py, test_text.py | read src/ (the field parser takes `and $03` as well as `and a, $03`; sound headers follow their track label) |
| test_name_claims.py | reads src/ through listing_spelling; the 97 names given by reading whose own part reads like a rule claim are listed in tests/data/names_given_by_reading.txt |
| test_note_grounding.py | tools/check_note_grounding.py reads every code note and the code from src/ (34,771 mentions, against 6,605 in config/names.json); the 3,339 that older C1 notes make loosely are recorded in tests/data/ungrounded_mentions.txt, and any new one fails |
| test_probe_scope.py | tools/probe_scope.py reads src/; docs/PROBE_SCOPE.md regenerated from src/ and the .sym is unchanged |
| test_doc_coverage.py | the readability ratchets read the names given by reading from config/names.json while it is present, else from tests/data/given_names.txt (10,828 names, frozen at graduation) |
| test_step_names.py, test_incbin_identified.py | checks of the generator's own records (its rename maps, its asset comments): they skip without the listing |

Tools that read the listing now read src/ (ram_uses.py, status_bits.py, talk_check.py; status_bits.py gives the
same 69 lines) or the fresh .sym (explore.py's address table). present.Names runs without names.json.

**H1c. config/ files by role (2026-10-17).** Nothing that builds, reads or checks the source needs
config/names.json or config/annotations.json: that is the exit gate below. They stay in the repository, frozen, as
inputs of the generator, which remains a re-analysis tool that writes build/listing/ and build/regen/src/.
- Frozen generator inputs (no new names or notes go here): names.json, annotations.json, name_families.json,
  banks.json, operands.json, story_flags.json, battle_status.json, script_commands.json, record_fields.json, and
  the analysis inputs code_entries, data_regions, indexed_dispatch, arg_banks, observed_streams, stream_chains.
- Read by tools at run time: targets/, toolchain.lock.json, probes/ and probe_exclusions.json (the emulator
  probes), tables.json (the table layouts tools/datatables.py and tools/tables_export.py use) and symbols.json
  (buffer-offset aliases).

**H1d. Tools that wrote config/ (2026-10-17).** apply_drafts.py (and its test) and rank_unnamed.py served the
readability batches and are removed. readability_queue.py stays as the readability ratchet. tools/rename.py
renames a label, constant or RAM symbol everywhere in src/ (definition, references, notes, its section and the
layout line) and refuses unsafe renames; renaming NextTableByte in a copy of src/ still builds the reference.

**Exit gate (met 2026-10-17, E-0407).** In a scratch copy with config/names.json, config/annotations.json and
build/listing/ removed, the matching build PASSes and the full suite passes (the generator's own checks skip). A
hand edit to src/ survives: three comment lines in bank $60 that named a RAM symbol that no longer exists were
corrected in src/ (found by the note check), and every check and build passes with them.

## Working on src/ now

- Edit src/ directly: code, comments and data. `python -I tools/build.py --out build/runN` checks the result.
- Rename with tools/rename.py; edit data tables in a spreadsheet with tools/datatables.py (H2).
- tools/disasm_all.py is for re-analysis. It writes build/regen/src/, and tools/src_drift.py lists how that differs
  from src/; `--write-src` would overwrite src/ and must not be used.
