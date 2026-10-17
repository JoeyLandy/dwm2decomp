# Graduating src/

Stage H1 of the modding and translation goal ([roadmap](ROADMAP.md)), decision D-015 in
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
| tests/test_generated_source.py | data_regions, symbols | yes | |
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

**H1b. Checks on src/, not on the listing.** Each test that reads build/listing/ or imports the generator is
rewritten to check src/ and the built `.sym` and `.map`. Where a test needs an instruction's address, it reads it
from a listing derived from the build: src/ assembled, with each instruction's address taken from the
assembler's output. It no longer comes from the generator's trace. One test file at a time, each passing before
and after.

**H1c. config/ files sorted by role.**
- Some files only fed names and notes into src/ (names.json, annotations.json, name_families.json, banks.json,
  operands.json, story_flags.json, battle_status.json, script_commands.json, record_fields.json). They are frozen,
  then removed once nothing reads them, since src/ holds the same names and notes.
- Analysis inputs that only re-tracing needs (code_entries, data_regions, indexed_dispatch, arg_banks,
  observed_streams, stream_chains) stay with disasm_all.py as a re-analysis tool.
- What the tools need at run time stays, moved where useful: targets/, toolchain.lock.json, the probes/ files,
  tables.json (layouts tables_export.py packs) and symbols.json.

**H1d. Tools that write config/ retargeted or retired.** apply_drafts.py, readability_queue.py and
rank_unnamed.py served the readability batches. A rename becomes a whole-tree rename of the label in src/, and a
note an edit of the comment above it. A small rename tool keeps every reference in step.

**Exit gate.** In a scratch copy with config/names.json, config/annotations.json and build/listing/ removed, the
matching build PASSes and the full suite passes. A hand edit to src/ survives every step of the documented
workflow.

## During the transition

- Edit src/ directly. Do not run `disasm_all.py --write-src` once src/ has hand edits, because it would overwrite
  them. tools/src_drift.py shows what such a run would change.
- config/names.json and config/annotations.json are no longer the place for new names and notes. They stay only
  until H1c removes their last readers.
