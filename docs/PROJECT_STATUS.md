# Project status

As of **2026-10-17**. Stage: **matching, fully annotated and moddable disassembly** (readability goal E-0386; moddable-decomp stages M1-M5, E-0388 to E-0396). Current goal: **a modding and translation ecosystem**, stages H1-H7 ([roadmap](ROADMAP.md)); H1 (graduating src/) started. Semantic work continues one mechanic or table at a time ([roadmap](ROADMAP.md)). The current handoff is the first "Current handoff" section below; historical planning and earlier session records remain for provenance.

## Target and decisions

| Item | State | Basis |
| --- | --- | --- |
| First game | DWM2: Cobi's Journey, GB/GBC | User selected during this session |
| Intended edition | US header, version byte 0; catalog cross-check pending | Measured local reference; see target manifest |
| Exact revision / header / mapper / ROM size / RAM size | Header revision 0, MBC5+RAM+battery, 4 MiB ROM, 32 KiB RAM | `config/targets/dwm2-cobi-us-rev0.json` |
| Reference SHA-256 | `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e` | Measured from supplied reference; never derived from generated output |
| Other targets | Deferred | Tara and DWM1 are comparison sources, not supported builds |
| Primary output | Matching assembly plus evidence-backed documentation | Project design decision |
| Implementation foundation | Fresh RGBDS scaffold recommended | See [survey](SURVEY.md); no upstream adopted |
| Working platform | Windows / PowerShell | Observed workspace environment |

Decisions record: **D-015** (2026-10-17, user-approved) makes `src/` the hand-edited source of truth, superseding the generated-source part of D-005: the generator writes `build/regen/src/`, and config/ is retired from the workflow in stages ([graduation](GRADUATION.md)); **D-010** (2026-10-13) keeps each bank file in a pokered-style directory by what the bank holds (`config/banks.json` `dir`: home, engine, scripts, text, data, maps, gfx, audio, unused); **D-001** selects Cobi (user-confirmed); **D-002** makes binary identity and explicit confidence mandatory (user requirement); **D-003** recommends RGBDS with opaque slices for unknown bytes (architecture proposal); **D-004** uses Markdown evidence and task records before introducing a database (architecture proposal); **D-009** (2026-10-13) names story flags after their setters and battle status bits from their observed texts; **D-008** (2026-10-13) includes graphics and map data as named asset files extracted at build time; **D-007** (2026-10-13) names ids from the ROM's name tables (`src/constants.inc`); **D-006** (2026-10-13) names each bank file after its contents (`config/banks.json`); **D-005** (2026-10-13) makes `src/` a reader-facing presentation of the annotated listing, which moves to `build/listing/` (user goal: human-readable code in the style of pokered). Revisit proposals if the baseline build exposes a better option; record the reason.

## Session 2 update (2026-10-09): matching build exists

Binary identity: **PASS for `dwm2-cobi-us-rev0`** on two clean builds (`build/run1`, `build/run2`): 4,194,304 bytes, SHA-256 `8e38a742...766d4e`, 0 differing bytes against `local/roms/dwm2-cobi-us.gbc`. The reference's hash was measured from the supplied file; it is not yet checked against an independent catalog, so "unmodified retail" is unestablished.

What exists (all locally run):

| Item | Where |
| --- | --- |
| Target manifest | `config/targets/dwm2-cobi-us-rev0.json` |
| Toolchain lock (RGBDS v1.0.4 win64, hash matched release metadata) | `config/toolchain.lock.json`; binaries in ignored `tools/rgbds/` |
| Identity verifier with 9 negative tests (`python -I -m unittest discover -s tests`) | `tools/verify_rom.py`, `tests/` |
| Clean build + gate, JSON report | `python -I tools/build.py --out build/runN` |
| Whole-ROM recursive-descent disassembler (regenerates `src/`) | `tools/disasm_all.py`, `tools/trace_disasm.py` |
| Asset decompressor (LZSS-style; C2, cross-checked on 141 emulated calls) | `tools/lzss_gfx.py`, `tests/golden_gfx_assets.json` |
| Emulator for dynamic analysis (own implementation, unverified against hardware) | `tools/sm83.py` |
| Compressed-asset finder and extractor (2,137 streams, 304 KB -> 726 KB; C1) | `tools/disasm_all.py --export-streams`, `tools/extract_assets.py` |
| Structured table layouts (sound-id table + record arrays, 227 records; C2) | `config/tables.json`, emitted into `src/` by `tools/disasm_all.py` |
| Sound track decoder (214 tracks, 27,639 events; grammar C2, validated on the emulator for the commands that ran) | `tools/sound_tracks.py`, `tools/validate_sound_tracks.py` |

Coverage (bytes of the 4,194,304; measured from generated `src/`, not a semantic metric):

| Class | Bytes |
| --- | --- |
| Traced instructions and inline `dw` tables (C0 semantics) | 453,774 in 91 banks (2,094 heuristic entries, each marked `; heuristic: ...; C0` in `src/`) |
| Assembled `ds`/`DS` fills (99 all-zero banks plus zero runs) | 1,622,016 whole-bank plus 357,024 run fills |
| Opaque `INCBIN` slices of the reference (not understood) | 1,510,176 in 4,909 slices |
| Data pointer words (`dw Data_BBB_AAAA`, C1 structure only) | 35,236 bytes: 17,618 pointers in 480 monotone tables (49 self-pointing) |
| Labelled data starts (`Data_BBB_AAAA`, C0/C1 structure only) | 13,776 labels: pointer-table targets plus 1,705 `ld hl/de/bc` loads resolved to them (281 with bank evidence: helper call or the `$D7FE` bank variable; 1,424 same-bank assumed, withheld in 10 banks). 3,778 banked-call operands (`ld hl, ADDR` before `rst $10`) name code in the bank given by `ld b` |
| Data pointer words (`dw Data_BBB_AAAA`, C1 structure only) | 35,236 bytes: 17,618 pointers in 480 monotone tables (49 self-pointing) |

Reachability is not proof of execution; every label is address-derived (C0). Tracer idioms mined from bank 0, **C1 (one local observation, not yet runtime-confirmed)**: `ld hl,ADDR / ld b,BANK / rst $10` is a banked call; `rst $00` takes an inline word table. Observation (C2, measured over the file): byte `$4000` of every non-zero switchable bank equals its bank number, which the `$0010` helper reads.

Disassembler run (2026-10-09, `python -I -u tools/disasm_all.py`, progress in stderr): 135 rounds, about 108 s. Fall-through discovery (code right after a terminator or table, plus `$4001` of each bank) runs to exhaustion before the slow pointer-table scan, because chains of functions otherwise cost one 45 s scan per link. Both heuristics require a clean speculative trace, so output depends on discovery order and is deterministic but not unique. Precision spot-checks: bank `$10` heuristic entries are real `ld hl,ADDR / ld b,BANK / rst $10 / ret` banked-call thunks; the others sampled were plausible code. Not exhaustively validated. 66 non-zero banks still contain no traced code and mostly look like data by opcode frequency.

Untraced banks (second pass, 2026-10-09): the 66 non-empty banks with no traced code look like data (compressed graphics, palettes, pointer tables), not missed code; evidence and caveats in [E-0008](EVIDENCE_LOG.md). Heuristic rules and the one failure found are in E-0009. Reproduce: `python -I -u tools/disasm_all.py` (about 2 minutes, progress on stderr), then `python -I tools/build.py --out build/runN`.

Known limits: code reached only through other banked-call forms, computed `jp hl`, or pointer tables is still opaque; `rst` fall-through may decode inline data as code.

## Readability campaign (goal.md, from 2026-10-14)

The user's goal (goal.md in the main checkout; re-read after any compaction) is to finish pokered-style
readability in batches of read-only sub-agent drafts with one integrator. Completion needs: a hand-written reading
note on every code label and no instruction-named label; no label over 60 characters except documented ones; a
content note on every data label; every unidentified asset identified or documented; every probe-checkable C1
reading probed or listed with why not; ROADMAP marked complete; final commit with identity PASS and full suite.

**Decisions (D-011, 2026-10-14).**
- Work happens in this worktree (branch `claude/pokered-readability-dwm2-d761c7`); the reference ROM and RGBDS
  were copied into its ignored `local/roms/` and `tools/rgbds/` (ROM SHA-256 checked: approved). The main checkout
  held an uncommitted continuation of E-0367 at the same base commit; it was applied here from its config/ diff
  and finished as E-0368. The main checkout itself is left untouched.
- Queue definitions (tools/readability_queue.py): **instruction** = a global code label whose name is not given
  by config/names.json, except per-bank copies of a given name (`_BankNN`, `_BNN`), names made from the message a
  step shows (`_Show...`, `Msg....`, `TalkMsg....`) and table-index names (`ScriptCommandEE`); **long** = over 50
  characters; **unread** = a code label whose comment has no hand-written whole-routine reading (an evidence id in
  tools/present.py HAND_EVIDENCE, as "(C1, E-0369)"); older notes from earlier rule passes (E-0038 "runs one frame
  of script command type 9E", E-0268 "starts message ...") count as unread; **data** = a data label whose only
  description is "data read by X (N bytes)" or "data block"; **asset** = an INCBIN that only the catch-all rule put
  in gfx/misc/. Local `.labels` belong to their routine and are covered by its note.
- Each batch gets one evidence id (E-0369, E-0370, ...), added to HAND_EVIDENCE; notes are written by
  tools/apply_drafts.py as "<note> (C1, E-03xx)" in config/annotations.json; names go to config/names.json (data
  labels with "data": true, or their config/tables.json layout).
- Count floors that only guarded against a vacuous test of generated names (tests/test_step_names.py's 150) are
  replaced by an upper-bound ratchet on instruction-named, over-60 and `Etc` labels (tests/test_doc_coverage.py),
  since the batches remove generated names by design.
- From E-0371 on, the parallel runner is the final suite check before a commit: it agreed with the serial suite test
  by test on three separate trees (E-0368 suite604/par604, E-0369 suite606/par606b, E-0370 suite610/par610b). A
  serial run is repeated whenever the test files' set or the runner changes, and at the end of the goal.
- The parallel runner (tools/run_tests.py) is used for the scoped and intermediate runs; the serial
  `python -I -m unittest discover -s tests` stays the final check before every commit until the two have agreed on
  three separate trees.

**Decision D-012 (2026-10-15): what "a C1 reading a probe can check" means.** A probe runs one routine of the
reference ROM on tools/sm83.py from a chosen register, RAM and SRAM state until it returns, and compares registers,
flags, RAM and SRAM with the note (tools/probe.py; probes in config/probes/*.json, run by tests/test_probes.py). A
reading is probe-checkable when tools/probe_scope.py finds that the routine and everything it reaches (calls, jumps,
far calls, jump-table entries, fall-through) touch only CPU registers, WRAM, HRAM, SRAM and the memory-bank
registers, with no halt/stop/ei/di and no computed `jp hl`. The rest are listed by category with the reason: their
effect is on the display, sound, serial link or joypad (what they do is seen there, not in RAM), or depends on
interrupt timing, or jumps through a computed address. A passing probe raises the mechanical part of a note to C2
(the project's emulator, not hardware); what a routine is for stays C1.

**Decision D-014 (2026-10-15): two batches drafted at once.** Read-only drafting of a code batch and a data-label
batch may run at the same time (12 workers), each against the same commit. Integration stays one batch at a time and
one E-entry per batch: the second batch is validated against the snapshot after the first is applied, with its
citations of renamed labels rewritten first.

**Decision D-013 (2026-10-15): cheaper drafting models.** From E-0378 the user asked for cheaper sub-agents where
appropriate. Drafting workers run on Sonnet or Haiku instead of the session model; E-0378 splits them three and three
(Sonnet slices 1, 5, 6; Haiku slices 2, 3, 4) to compare rejection rates. The gates do not change: every draft is
validated and spot-checked by the integrator (session model), and a wrong spot-checked entry rejects the whole draft.
A model whose drafts are rejected at more than 20% is dropped for the rest of the goal. Outcome (E-0378): all three
Haiku drafts were rejected (partial reads, line-number citations, a wrong input) and all three Sonnet drafts accepted,
so drafting continues on Sonnet only.

**Cycle timing (E-0368 tree).** Regenerate 3m50s-3m58s (`python -I -u tools/disasm_all.py`); build and identity
12.8s; full serial suite 25m54s (377 tests); parallel suite 8m04s wall (32 processes; bounded by
test_generated_source.py). The serial suite is about 86% of a cycle (25m54s of 30m00s), hence the parallel runner. Ten
slowest test files (wall time of each file's own process in the parallel run, which includes class set-up that
unittest's --durations leaves out): test_generated_source 476s, test_act_check 272s, test_play_chain 234s,
test_story_flags 136s, test_ai_check 121s, test_effect_check 118s, test_talk_check 117s, test_text_check 112s,
test_world_map 109s, test_boot_trace 63s. By summed test durations (serial --durations 0, no set-up):
test_generated_source 467s, test_story_flags 45s, test_act_check 41s, test_text_check 19s, test_present 12s,
test_note_grounding 6s, test_routine_behaviour 4s, test_doc_coverage 4s, test_build_assets 2s, test_name_claims 1s.
Parallel and serial runs agreed test by test on the E-0368 tree (377 run, 374 ok, 3 skipped): agreement 1 of 3.

**Batch log.**

| Batch | Evidence | Drafted | Accepted | Rejected (reason) | Identity | Suite |
| --- | --- | --- | --- | --- | --- | --- |
| E-0368 (finish E-0367 continuation, tools) | E-0368 | - | 591 names | - | PASS build/run604 | suite604 OK (377, 3 skipped); par604 identical |
| 1: instruction-named, banks $00-$0F (6 slices of 80-109, plus 18 derived) | E-0369 | 547 | 547 (5 names withheld: helper families) | 0 (54 spot checks, all correct) | PASS build/run606 | suite606 OK; par606b identical |
| 2: instruction-named, banks $0F-$31 (6 slices of 80-118, 10 derived, 7 renumbered siblings, 2 parents) | E-0370 | 553 | 553 (equipment table renamed as a whole) | 0 (60 spot checks, all correct) | PASS build/run610 | suite610 OK (387, 4 skipped); par610b identical (agreement 3 of 3) |
| 3: instruction-named, banks $31-$F2 (5 slices of 120-141, 7 derived) | E-0371 | 649 | 516 | 133 (worker 1: a name repeated a wrong 'link menu' note; 20.7%: slices halved to 60) | PASS build/run614 | par613 OK (392, 4 skipped) |
| 4: 130 re-queued instruction-named + 288 long (6 slices of 60-80 with callers and tables) | E-0372 | 418 | 418 | 0 (43 spot checks, all correct) | PASS build/run616 | par616 OK (392, 4 skipped) |
| 5: 101 long + 243 unread with probes (6 slices of 50-63) | E-0373 | 345 | 345 (135 probed, 257 probes) | 0 (35 spot checks, all correct) | PASS build/run618 | par618 OK (392, 3 skipped) |
| 6: unread + probe scope, banks $00-$04 (6 slices of 90) | E-0374 | 544 | 544 (378 probed, 729 probes) | 0 (54 spot checks, all correct) | PASS build/run621 | par621 OK (393, 3 skipped) |
| 7: unread + probe scope, banks $00-$0A (6 slices of 135) | E-0375 | 816 | 816 (768 probed, 1,803 probes; re-applied from final drafts) | 0 (84 spot checks, all correct) | PASS build/run624 | par624 OK (393, 3 skipped) |
| 8: unread + probe scope, banks $0A-$12 (6 slices of 150) | E-0376 | 912 | 912 (727 probed, 1,266 probes) | 0 (90 spot checks, all correct) | PASS build/run626 | par626 OK (393, 3 skipped) |
| 9: unread + probe scope, banks $10-$16 (6 slices of 150-152) | E-0377 | 904 | 904 (808 probed, 1,639 probes; 14 names) | 0 (91 spot checks, all correct) | PASS build/run_E-0377 | par627 OK (394, 3 skipped) |
| 10: unread + probe scope, banks $16-$31 (6 slices of 150-153; 3 Sonnet, 3 Haiku) | E-0378 | 903 | 452 (330 probed, 1,152 probes; 29 names + 65 children) | 451 (all three Haiku drafts: partial reads, line-number citations, a wrong input; 50%: slices halved to 75, Haiku dropped) | PASS build/run629 | par629 OK (394, 3 skipped) |
| 11: unread + probe scope, banks $19-$31 (6 slices of 75-80, Sonnet) | E-0379 | 459 | 459 (233 probed, 823 probes; 49 names + 4 derived) | 0 (48 spot checks, all correct) | PASS build/run631 | par631 OK (395, 3 skipped) |
| 12: unread + probe scope, banks $31-$36 (6 slices of 75-80, Sonnet) | E-0380 | 457 | 457 (352 probed, 1,519 probes; 46 names + 14 child steps) | 0 (48 spot checks, all correct) | PASS build/run633 | par633 OK (396, 3 skipped) |
| 13: data labels described only by their reader (6 slices of 81-82, Sonnet, drafted with batch 12) | E-0381 | 491 | 491 notes (30 names; 35 second names point at their table) | 0 (54 spot checks, all correct) | PASS build/run636 | par636 OK (396, 3 skipped) |
| 14: unread + probe scope, banks $36-$3A (6 slices of 112-150, Sonnet) | E-0382 | 723 | 723 (675 probed, 2,558 probes; 33 names) | 0 (78 spot checks, all correct) | PASS build/run638 | par638 OK (396, 3 skipped) |
| 15: opaque INCBIN slices (6 slices of 23-26, Sonnet, drafted with batch 14) | E-0383 | 153 | 140 identified and named, 13 documented as unidentified | 0 (18 entries reviewed, 1 stream claim checked) | PASS build/run_E-0383b | par639 OK (396, 3 skipped) |
| 16: unread + probe scope, slices 1-6 of 12 (150 each, Sonnet; 4 reruns after a usage stop) | E-0384 | 900 | 900 (783 probed, 2,646 probes; 55 names + 7 children) | 0 (90 spot checks, all correct) | PASS build/run640 | par640 OK (396, 3 skipped) |
| 17: unread + probe scope, slices 7-12 of 12 (150 each, Sonnet; 3 reruns) | E-0385 | 900 | 900 (742 probed, 2,281 probes; 38 names + 10 children) | 0 (90 spot checks, all correct) | PASS build/run641 | par641 OK (396, 3 skipped) |
| 18: the last 89 routines, banks $F1-$F2 (4 slices of 20-23, Sonnet) | E-0386 | 89 | 89 (40 probed, 109 probes; 16 names + 9 children; GiftEffect_None) | 0 (20 spot checks, all correct) | PASS build/run643 | serial suite643 OK (397, 3 skipped) |

**Measures after E-0369.** readability.py: 33,311 labels, 0 mechanical, 0 raw pointer operands, 3,550 INCBIN.
doc_coverage.py: 9,822 code labels (5,274 with a hand reading), 23,489 data labels, all commented, no stale name.
Queue: instruction 1,182; long (over 50) 764; over 60: 172; `Etc`: 1; unread 4,548; reader-only data 524;
unidentified assets 155. Batch E-0369 phases: drafting about 18 min (six workers in parallel, then 8 min for the
derived labels); validation and spot checks about 20 min; regeneration 3m50s; build 13s; parallel suite 3m52s
(test_generated_source.py fixed: 476s to 24s); serial suite 18m33s (OK, 377 tests; parallel par606b identical: agreement 2 of 3). Rejection rate 0% (first batch below 5%).

**Measures after E-0368.** readability.py: 33,311 labels, 0 mechanical, 0 raw pointer operands, 3,550 INCBIN
(all named asset files). doc_coverage.py: 9,822 code labels (5,246 with a hand reading), 23,489 data labels, all
commented, no stale name. Queue: instruction 1,751; long (over 50) 939; over 60: 209; `Etc`: 1; unread 4,576;
reader-only data 524; unidentified assets 155.

## Current handoff (2026-10-17, E-0411 to E-0414): the goal's H stages done

The modding and translation goal's stages H1-H7 are done ([roadmap](ROADMAP.md)), with one part not run: H6's build
on a second platform.
- **H4 (E-0414).** The recipe gate reaches every reader H2 and H3 change. The new tools/recipes/h4_readers.txt
  passes padded by 16 (151 runs, 4,792,239 reads). ScreenNumberListTable's readers name its bank with BANK(), and
  the table moves to bank $8A with the game's shop totals unchanged.
- **H5 (E-0411).** tools/mod_check.py runs a mod beside the original and reports crashes, code running data, lost
  progress (the order of game modes) and stalls, and where the screens first differ. A broken pointer and a broken
  table are both reported, and an unchanged build is not.
- **H6 (E-0412).** tools/patch.py (BPS), patcher/index.html (applies a patch in the browser), tools/make_mod.py and
  mods/example (a mod folder to a smoke-tested patch), and tools/setup.py with tools/toolchain.py (RGBDS for
  Windows, Linux and macOS, checked against the lock). Verified on Windows only: no Linux or macOS machine was
  available. The Linux and macOS archives' digests and contents were checked.
- **H7 (E-0413).** docs/MODDING.md and three tutorials, each followed from a clean copy by tests/test_tutorials.py.

Checks: build/run17 PASS (zero differing bytes); data and text round trips identical; tools/bank_check.py 0 errors and
0 warnings; serial suite build/logs/suite_h4h7.log OK (532 tests, 3 skipped).
Merged with the parallel E-0410 (docs and three recipes): build/run18 PASS, tests/test_link_play.py OK.

Open:
1. Run `python -I tools/setup.py --rom ...` and `python -I tools/make_mod.py mods/example` on Linux or macOS (H6's
   second platform).
2. Readers of other fixed-bank tables (the 508 asserted loads, most of them scripts) changed to follow their
   tables.
3. The overflow split of message banks for translations that outgrow a bank (docs/TRANSLATING.md).

## Prior handoff (2026-10-17, E-0407 to E-0409): H1, H2 and H3 done

- **H1, src/ graduated (E-0407).** Every check reads src/ (and the .sym of a build of it), or is a check of the
  generator that skips without its listing. With config/names.json, config/annotations.json and build/listing/
  removed, the build passes and 491 tests pass. Removed: apply_drafts.py and rank_unnamed.py. Added: rename.py.
  Fixed: three comments in bank $60 naming a RAM symbol that does not exist.
- **H2, data as files (E-0408).** tools/datatables.py exports 181 tables from src/ to JSON and CSV and imports
  edits back; a list's growth comes out of the bank's fill. An edit in each of 12 tables reaches the game's
  readers on a modded build. docs/EDITING_DATA.md.
- **H3, text (E-0409).** tools/text.py exports 5,407 text entries with their width limits and reinserts
  translations; the font goes to a PNG and back; free glyph codes take new letters. A German test translation
  with "ü" builds, and the game draws it on the emulator. docs/TRANSLATING.md.

Checks: build/run11 PASS (zero differing bytes); serial suite build/logs/suite_e0406.log OK (501 tests, 3 skipped); the H1
exit gate as in E-0407. Merged with the parallel E-0404 to E-0406: build/run12 PASS, both round trips identical, serial
suite build/logs/suite_merge2.log OK (514 tests, 3 skipped).

Next: H4. The parallel E-0406 widened the recipe gate to 2,638 routines (later worlds and link play); check that it
reaches the readers H2 and H3 change (shops, breeding, the arena, conversations), then move a fixed-bank table with
its reader updated.

## Prior handoff (2026-10-17, E-0403): H1b started

tests/test_generated_source.py is split (docs/GRADUATION.md). tests/test_source_audits.py checks src/ itself, and
tests/test_generator_listing.py keeps the generator's own checks, skipping without build/listing/.
tools/source_tree.py gives the moved checks label banks from src/ alone, and a .sym only from a build of the
current tree (tools/build.py now records `source_digest`). A hand-added comment in src/ leaves the audits passing;
a raw RAM address is caught. build/run7 PASS; serial suite OK (479 tests, 3 skipped).

Next: the other listing readers, one file at a time, in docs/GRADUATION.md's table: tests/test_present.py,
test_fold_idioms.py, test_incbin_identified.py, test_note_grounding.py, test_resistances.py, test_step_names.py,
test_story_flags.py, test_text.py, then the tests that import the generator.

## Prior handoff (2026-10-17, E-0402): new goal, and H1a done

The user set a new goal: an ecosystem in which people can easily translate the game or make mods and romhacks.
docs/ROADMAP.md lists its stages H1-H7: graduate src/, game data as files, a text pipeline, full shiftability, a
mod smoke test, distribution, modder documentation. D-015 makes src/ the hand-edited source.

H1a (E-0402): tools/disasm_all.py and tools/present.py write build/regen/src/ unless given `--write-src`, and
tools/src_drift.py compares that tree with src/. On this tree the regeneration reported no drift (265 files
identical) and left src/ untouched. tests/test_present.py's two listing-equality tests now check build/regen/src/.
Merged onto master after E-0398 to E-0401: no drift, build/run5 PASS, serial suite OK (474 tests, 3 skipped).

Open, in order (docs/GRADUATION.md):
1. H1b: the tests that read build/listing/ or import the generator become checks on src/ and the build's .sym and
   .map, one file at a time.
2. H1c: config/ files sorted by role; names.json and annotations.json retired.
3. H1d: apply_drafts.py, readability_queue.py and rank_unnamed.py retargeted or retired; a rename tool.

Next reproducible action: `python -I tools/disasm_all.py` then `python -I tools/src_drift.py` (expect no drift
until src/ is edited), then start H1b with tests/test_generated_source.py.

## Parallel handoff (2026-10-17, E-0404 to E-0406, E-0410): the open items of the E-0401 handoff done

Done alongside H1, from the open items of the E-0401 handoff (no change to the H1 plan above):
1. **The other damage routines** (E-0404): all 28 remaining damage routines of bank $36 agree with models on
   3,000 states. They include Watershot, MegaMagic, MultiCut, CallHelp, Kamikaze, the family attacks, BiAttack and
   actions $D7-$D9.
2. **The bred child's later rolls** (E-0405): sex, resistances, skill list and stat bonus agree on 3,000 families.
3. **Later worlds and link play for the shift gate** (E-0406):
   - a 25-map world tour recipe;
   - a serial port in tools/sm83.py and tools/link_play.py, with a linked breeding session from the title menu
     (in E-0406 no child was bred; E-0410 completes it, below);
   - `--link-recipe`.
   - The tour found two byte lists the generator had misread as pointer words (EnterStatusEffectFieldState_Data
     and AddSkillCToFreeOrWeakerSlot_Data), both now layouts.
   - All 222 recipe runs (2,638 routines) and the link session PASS padded by 16 and by 256.

build/run702 PASS; serial suite OK (473 tests, 3 skipped). Merged onto master after H1b (E-0403): no drift
(tools/src_drift.py, 265 files identical), build/run703 PASS, serial suite OK (487 tests, 3 skipped).

The items it left (E-0410):
- **A completed link breeding.** Done: tools/recipes/link_e0406_breeding.txt runs to two eggs (A's PearlGel, B's
  Petiteel) and the title menu, 54 runs, PASS padded by 16 and by 256. E-0406's reading that console B's presses
  did not move its choice was wrong: B was on the Info / OK box, where each Down press toggles the cursor.
- **The story's way into a key world.** Done: tools/recipes/e0406_key_world.txt takes a key to the shrine (map 3),
  has it appraised, uses it at the gate and walks from the gate room into the world and a battle.
- **Darck's taunt.** Done: it runs on Darck's castle (map $A2) from the line after his battle.
- The key world's chain: 200 runs, 2,644 routines, PASS padded by 16 and by 256. On master with H1 to H3: build/run706
  PASS, the gates PASS again, serial suite OK (509 tests, 3 skipped).

Next reproducible action: `python -I tools/link_play.py tools/recipes/link_e0406_breeding.txt --sram-recipe
tools/recipes/e0323_save.txt --shots build/link` (both consoles' screens, ending on the title menu).

## Prior handoff (2026-10-17, E-0398 to E-0401): the open actions done

The three actions the E-0397 handoff left are done:
1. **Skill learning** (E-0398): FindNewlyLearnableSkills agrees with a model on 3,000 generated records (learned
   from the list, upgraded, devised, MegaMagic's own rule); docs/MECHANICS.md.
2. **Applying damage** (E-0399): ResolveStepApplyDamage (through ApplyDamageToTarget) and ApplyDamageModifiers
   each agree on 3,000 states.
3. **Shiftability** (E-0401): tools/shift_test.py `--recipe` replays the 13 play recipes on padded ROMs, comparing
   each instruction's ROM reads; it and static scans found ten fixed references (raw code and far-pointer tables,
   bank-$00 addresses, a selector inside an object list), all now labels. The three split sums are resolved, and
   the 512 fixed-bank pointer loads carry link-time ASSERTs. All 147 runs (2,299 routines) PASS padded by 16 and by
   256. docs/SHIFTABILITY.md.

Merged onto master after the breeding-paths batch (E-0400): build/run697 PASS; serial suite OK (465 tests, 3
skipped).

Open: the effect routines beyond roll and scale (Watershot, MegaMagic, MultiCut, CallHelp), the breeding child's
later rolls (sex, resistances, skills, stats), more recipes (key worlds, late story, link play) for the read gate.
Next reproducible action: `python -I tools/shift_test.py --pad 16 --reads all --recipe tools/recipes/e0335_swap.txt`
(about 30 minutes) after any generator change, alongside the build.

## Prior handoff (2026-10-17, E-0400): breeding paths

tools/breed_path.py lists the wild monsters of each story map from the ROM and finds the fewest farm breedings
from them to a species (docs/BREEDING_PATHS.md). Three checks agree with the game on tools/sm83.py: the game's own
encounter listing on every screen of the 56 maps, FillEncounterFromEntry from all 128 random states for the 109
entries, and ComputeBreedingChild for every breeding of a route. Finding: RandomByteTable gives only 94 of the 128
roll values, so Phoenix's slot on the Float map is never drawn. Example: Darkdrium from the Pirate maps ($30-$45)
in 132 breedings. build/run3 PASS; serial suite OK (457 tests, 3 skipped). E-0398 and E-0399 belonged to the branch
claude/skill-learning (merged since, with its E-0400 renumbered E-0401).

Open: sex, level and plus conditions in routes; the routine that ties keys to map ranges (the world grouping is
C1); the open items of the previous handoff below.

Next reproducible action: `python -I tools/breed_path.py check --maps 30-45 --target DARKDRIUM`.

## Prior handoff (2026-10-17, E-0397): damage checked against the game

tools/mechanics.py has three new checks (docs/MECHANICS.md, Damage): the plain attack (ComputeAttackDamage), the 16
bank-$36 routines that roll damage and scale it by a resistance level (read from src/), and the modifiers of resolve
step 7 (ResolveStepComputeDamage). Each agrees with the game on 3,000 of 3,000 generated states, including link
play's second random stream; three wrong models are caught (tests/test_mechanics.py). build/run684 PASS; serial suite OK
(443 tests, 3 skipped).

Open, in the order they are most useful:
1. Skill learning, to the same standard.
2. ResolveStepApplyDamage and the damage message step's multipliers, which finish what step 7 starts.
3. Widen what the scripted runs reach (under 5% of the routines); the split sums and fixed-bank pointers of
   docs/SHIFTABILITY.md.

Next reproducible action: `python -I tools/mechanics.py all --n 3000`, then read the skill-learning routines (the
callers of the skill list in the monster record, MON_SKILL_LIST) and write their model.

## Prior handoff (2026-10-17): documentation brought up to date

A documentation-only pass after M5: README, ARCHITECTURE (the repository layout in use), READING_GUIDE (src/layout.link,
label expressions for banks and split addresses, building a modded ROM), ROADMAP (a status line per phase),
KNOWLEDGE_MAP and SHIFTABILITY now describe the state after M1-M5; stale "in progress" and "not merged" notes are
marked historical; temporary render paths are gone from UNIDENTIFIED_ASSETS. No source, config or tool changed; build/run683
PASS on this tree (0 differing bytes). The generated docs (LEFTOVER_CODE, DATA_TABLES, PROBE_SCOPE) were regenerated
and are unchanged; the doc tests pass.

Open, in the order they are most useful:
1. Another mechanic to the M5 standard (damage and resistance, or skill learning): a model in tools/mechanics.py,
   checked against the routine on generated states, with a wrong-model negative test.
2. Widen what the scripted runs reach (under 5% of the routines), so the shift test's read gate covers more code.
3. The three address-like split sums and the 511 pointers whose bank the reader fixes (docs/SHIFTABILITY.md).

Next reproducible action: `python -I tools/mechanics.py all --n 3000` (baseline agreement), then read ResolveStepComputeDamage
(src/engine/bank36_battle_effects.asm, step 7 of the battle resolve table) with its callees and write its model.

## Prior handoff (2026-10-16, E-0396): M5 done; the moddable-decomp goal M1-M5 is complete

tools/mechanics.py checks three mechanics against the game's own routines on tools/sm83.py: the join offer, the
level-up gains and the breeding child each agree on 3,000 of 3,000 generated states (docs/MECHANICS.md has them as
specifications). tools/tables_export.py exports the species, skill and item tables, packs them back byte for byte
and runs the game's loaders for every id (docs/DATA_TABLES.md). build/run682 PASS; serial suite OK (439 tests, 3 skipped).
docs/ROADMAP.md marks M1-M5 done. What is open is listed there, in each stage's document and in
docs/READABILITY_OPEN_QUESTIONS.md.

## Prior handoff (2026-10-16, E-0395): M4 done, leftover code bytes

tools/leftover_code.py trial-decodes the bytes after every routine end. 80 gaps that call or jump into known code
became config/code_entries.json entries, and tracing them found 102 unreached routines in all: string stubs,
battle getters, a block of Warubou talk handlers and link-session starters. They are named, read (C1) and probed
(115 probes, all passing; one note corrected). The 634 routines the generator had accepted by a guess alone are
now pinned, so discovery order no longer drops code. The other 384 gaps are listed with their verdict in
docs/LEFTOVER_CODE.md. build/run681 PASS; parallel suite OK (432 tests, 3 skipped). Next: M5 mechanics.

## Prior handoff (2026-10-16, E-0394): M3 done, editable assets

tools/lzss_encode.py (Okumura's LZSS.C with the game's ring start, 96-byte lookahead and marker format) reproduces
all 3,546 compressed streams byte for byte. tools/build.py now builds every asset from decoded data, and
`build.py --mod DIR` builds from edited PNG (rgbgfx) and .bin files, with bank fills absorbing size changes; a
recoloured Slime builds and runs. docs/ASSETS.md is the guide. build/run672 PASS; serial suite OK (427 tests, 3 skipped). Next:
M4 (leftover code bytes) or M5 (mechanics).

## Prior handoff (2026-10-16, E-0393): M2 done, code can move between banks

src/ is 9,071 floating sections placed by src/layout.link (rgblink -l). tools/bank_check.py finds jumps and
pointers that would break when a section changes bank. tools/move_section.py lists 255 sections free to move, and
moves one in a scratch copy: ScriptWaitFrames and ScriptStepObject run identically from other banks. A routine
reached by plain calls is caught. build/run670 PASS; parallel suite OK (418 tests, 3 skipped); the read gate passes. Next: M3,
editable assets with a byte-identical LZSS encoder.

## Prior handoff (2026-10-16, E-0392): M2 batch 4

Six of the nine unresolved split sums now resolve: the bank hint looks further ahead and back to a preceding
rROMB0 switch, and A2:$4056 is MonsterTableA2 - $1A. 65 split pairs are label expressions; 3 address-like sums
remain, explained in E-0392. build/run667 PASS; parallel suite OK (411 tests, 3 skipped); the read gate passes.
Left in M2: those 3, and one fixed section per bank, which still stops code moving between banks. Then M3,
editable assets.

## Prior handoff (2026-10-16, E-0391): M2 batch 3

Bank numbers beside pointers are BANK(label) (382 `ld b` setups, 14 `ld a` bank switches; farcall folding
unchanged at 3,842). Literal-bank candidates fall from 468 to 96, none of them real. build/run665 PASS; parallel suite
OK (411 tests, 3 skipped); the read gate still passes with every bank padded by 16. Next in M2: the nine unresolved
split sums (E-0390), then per-bank sections so code can move between banks.

## Prior handoff (2026-10-16, E-0390): M2 batch 2

Split table addresses are now resolved in other banks too (the bank of a following far read), and inside tables or
data blocks: 59 add/adc pairs are LOW/HIGH(label expression). The 65 sums left are 56 constants and 9 addresses
still to read, listed in E-0390. Gate: all 152 paddable banks padded by 16 pass the read comparison over 10,000
explore frames. build/run663 PASS; parallel suite OK (411 tests, 3 skipped). Next in M2: those nine,
then literal bank numbers as BANK(label).

## Prior handoff (2026-10-16, E-0389): M2 batch 1

Every hard-coded reference the shift test found is now a label expression, made by the generator:
- SolidColor1Tile, MapMarkerRecords and Tiles_00_1D07 for bank-$00 numbers (config/operands.json, plus a rule for
  repeats);
- LOW/HIGH(Label) for 35 split table addresses;
- GlyphFont + offset for the glyph source lists;
- a link-time ASSERT for GlyphFont's alignment.

tools/shift_test.py now has a timing-proof read comparison (`--reads all`), because padding bank $00 shifts timing.
With all 152 paddable banks padded by 16: PASS, all 1,202,485 reads match (build/m2_readsall). Left for M2: 89 split sums that are not exactly a label,
468 literal bank numbers, and widening what the scripted runs reach (under 5% of routines).
Branch claude/m2-labels (merged to master since).

## Prior handoff (2026-10-16, E-0388): M1 shiftability audit done

tools/shift_test.py pads a copy of src/ and compares the padded ROM's video state with the original's, frame by
frame, in tools/sm83.py; tools/hardcoded_refs.py counts numbers that stand for labels. Padding banks $00, $1F, $69
or $87 breaks the game. The causes, located to the instruction:
- a raw `ld de, $2940`;
- a font that must not cross a page (`inc e`);
- glyph source lists of numbers;
- two table addresses split into `add`/`adc` immediates.

The other 148 banks padded by 16 run 10,000 frames identical. The scripted runs reach under 5% of the routines,
so the static counts carry the rest: 124 split addresses, 592 tile addresses as numbers, 468 literal banks. The M2
plan is in docs/SHIFTABILITY.md. Branch claude/m1-shiftability (merged to master since).

## Prior handoff (2026-10-16): next goal, a moddable decomp

The source matches and is fully annotated (E-0386, E-0387; master eb9066a), but it is not yet a pokered-level
decomp: it is unknown whether code and data can move, the assets come out of the reference ROM, some unreached
code is still `db` bytes, and most readings are C1. docs/ROADMAP.md now sets the next goal in five stages: M1
shiftability audit, M2 labels for hard-coded references, M3 editable assets with a byte-identical LZSS encoder, M4
leftover code bytes, M5 mechanics. M1 started 2026-10-16 in its own session and worktree (tools/shift_test.py,
docs/SHIFTABILITY.md, evidence E-0388); its result was integrated later (E-0388 below). Build status for this documentation-only
change: not run (the last identity gate is build/run651 on eb9066a).

## Prior handoff (2026-10-16, E-0387): the three generator follow-ups

E-0387 does the three follow-ups the readability goal left (all generator changes; no ROM byte moves):
- **Split streams.** A stream found only by config/stream_chains.json is dropped when it starts inside another
  stream or runs over the start of one (28 streams in banks $46-$93). tests/test_asset_streams.py checks every
  compressed slice in src/assets.txt holds its whole stream; 8 unidentified slices merged back into their streams,
  5 remain in docs/UNIDENTIFIED_ASSETS.md.
- **Code at bank $32 $4F00.** config/code_entries.json traces it: RunBattleActions_StatusChecks_PairRefusal, the
  two-monster action branch. The labels $4F0A (one byte into a `jp z`), $4ECA and $7A49 and their two probes are gone.
- **One name per table.** fold_table_names in tools/disasm_all.py folds the second label of 373 tables (a
  config/names.json name wins, then a config/tables.json label, then the referrer's name over a generated address
  name); 17 first-record labels of record series stay, with an "entry 0 of" comment. Table notes from names.json now
  print in src/. No label is over 50 characters.

Checks: build/run651 PASS (approved size and SHA-256, zero differing bytes); serial full suite
build/logs/suite651.log OK (398 tests, 3 skipped). Measures: 9,820 code labels, all with a hand note; 23,160 data labels; 5,872 routines in
probe scope, all probed (16,780 probes). Next: the open questions in docs/READABILITY_OPEN_QUESTIONS.md, or a
semantic phase from docs/ROADMAP.md.

## Prior handoff (2026-10-16, E-0386): readability goal complete

The goal.md completion criteria hold on build/run643 (approved size and SHA-256, zero differing bytes) and the
serial full suite build/logs/suite643.log (397 tests OK, 3 skipped, 28m38s): every code label (9,822) has a
hand-written reading note and none is named after its instructions; no label is over 60 characters (two of 56-57,
documented in docs/ROADMAP.md); every data label (23,561) has a note on its content; the 153 opaque INCBIN slices
are identified (140) or listed with what was tried in docs/UNIDENTIFIED_ASSETS.md (13); every routine a probe can
check (5,874) has a passing probe and the 3,948 others are listed with the reason in docs/PROBE_SCOPE.md;
docs/ROADMAP.md marks the goal complete with these measures and the open questions. Batches E-0368 to E-0386,
drafted by read-only workers (Sonnet from E-0378, D-013) and integrated one at a time. Open questions:
docs/READABILITY_OPEN_QUESTIONS.md (1,852 entries). Follow-ups outside readability: merge the 11 split asset
streams (config/stream_chains.json), mark bank $32 $4F00 as code, fold the second-name table labels.

## Prior handoff (2026-10-15, E-0381)

Batches 12 (E-0380, code: 457 entries, 352 probed, 1,519 probes) and 13 (E-0381, all 491 reader-only data labels)
were drafted together (D-014, 12 Sonnet workers) and integrated one after the other, both at 0% rejection. Phases:
drafting about 35 min, validation and spot checks about 40 min for both, four regenerations (child renames, the
32:$4F00 note, the second-name comment), parallel suite about 5 min each. Measures: readability.py 33,381 labels, 0
mechanical; doc_coverage.py 8,573 hand readings, all labels commented, no stale name in any src file. Over 50: 2 (the
referrer aliases); over 60: 0; `Etc`: 1; 9,188 probes. Queue: unread 1,249, combined (unread + probe scope without a
probe) about 2,460, reader-only data 0, assets 153.

Stopped here at the user's request (usage limit); no workers are running. Next, when resumed: E-0382, the combined
queue in six slices of 112 (0% rejection two batches in a row grows them by half), Sonnet workers; then the asset
batch (scratchpad assetsl.py and brief_assets.md, six slices of about 26; identified assets get a content name and a
hand note, unidentified ones a hand note saying what was tried); then docs/PROBE_SCOPE.md (tools/probe_scope.py --doc),
the long-label exceptions, ROADMAP completion, the final serial suite and identity check. Follow-up recorded: bank $32
$4F00 is code that the generator prints as `dw` (open question for the disassembly, not readability).

## Prior handoff (2026-10-15, E-0379)

Batch 11 (E-0379): 459 entries (364 notes, 233 probed, 823 probes; 7,669 in all), 0% rejection with Sonnet workers
on slices of 75. Also cleaned the stale names out of the include files and RAM comments (58 names) with a new test.
Phases: drafting 37 min (slowest worker), validation and spot checks about 20 min, apply + regeneration + build 3m55s
(twice more for the derived names and the generator strings), parallel suite 5m01s. Measures: 33,381 labels, 0
mechanical, 8,289 hand readings, no stale name in src/. Over 50: 2; over 60: 0; `Etc`: 1. Queue: unread 1,533,
reader-only data 491, assets 155. Next: E-0380, the combined queue in six slices of 75 (one more batch under 5%
grows them to 112).

## Prior handoff (2026-10-15, E-0378)

Batch 10 (E-0378) accepted the three Sonnet drafts (452 entries: 307 notes, 330 probed, 1,152 probes; 6,846 in all)
and rejected the three Haiku drafts (451 labels re-queued). Phases: drafting 32 min (slowest worker), validation and
spot checks about 30 min, apply + regeneration + build 3m57s (twice more for the child renames and one probe), parallel
suite 5m07s. Measures: readability.py 33,381 labels, 0 mechanical, 0 raw pointer operands, 3,550 INCBIN;
doc_coverage.py 7,936 hand readings, all labels commented, no stale name. Over 50: 2; over 60: 0; `Etc`: 1. Queue:
unread 1,886, reader-only data 491, assets 155. Next: E-0379, the combined queue in six slices of 75 (halved after the
50% rejection), Sonnet workers.

## Prior handoff (2026-10-15, E-0377)

Batch 9 (E-0377) read or probed 904 routines in banks $10-$16 (652 notes, 808 probed, 1,639 probes; 5,694 in all).
Phases: drafting 27 min (six workers in parallel; the slowest set the pace), validation and spot checks about 25
min, apply + regeneration + build 3m57s, parallel suite 3m54s. Decision (D-012 addendum): a probe may name the routine
it checks with `"target"` when it has to enter through a runner; the runner then needs its own untargeted probe.
Measures: readability.py 33,381 labels, 0 mechanical, 0 raw pointer operands, 3,550 INCBIN; doc_coverage.py 9,822
code labels (7,638 with a hand reading), 23,559 data labels, all commented, no stale name. Over 50: 2 (the referrer
aliases); over 60: 0; `Etc`: 1. Queue: unread 2,184, reader-only data 491, assets 155. Next: E-0378, the combined
queue in six slices of 150, plus the notes reported wrong outside the E-0377 slices (READABILITY_OPEN_QUESTIONS.md).

## Prior handoff (2026-10-15, E-0376)

Batch 8 (E-0376) read or probed 910 routines in banks $0A-$12 (481 notes, 727 probed, 1,266 probes; 4,055 in all).
Queue: unread 2,809, reader-only data 490, assets 155. Next: E-0377, the combined queue in six slices of 150.

## Prior handoff (2026-10-15, E-0375)

Batch 7 (E-0375) read or probed 816 routines (623 notes, 768 probed, 1,803 probes; 2,789 probes in all). A draft is
now applied only after its worker reports done (one batch had to be re-applied). Queue: unread 3,275, reader-only
data 490, assets 155. Next: E-0376, the combined queue in six slices of 150 (the cap).

## Prior handoff (2026-10-15, E-0374)

Batch 6 (E-0374) covered the combined queue (unread routines and probe-scope routines without a probe) in banks
$00-$04: 402 notes, 378 routines probed (729 probes; 986 in config/probes/ in all). Queue: unread 3,896, reader-only
data 490, assets 155. Next: E-0375, the next six slices of the combined queue at 135 (0% rejection twice more).

## Prior handoff (2026-10-15, E-0373)

Batch 5 (E-0373) finished the long labels (none over 60; two referrer aliases of 51-57 characters remain) and read
243 routines, probing 135 of them (257 probes in config/probes/E-0373.json, run by the suite). Queue: unread 4,252,
reader-only data 490, assets 155, `Etc` 1. Next: E-0374, unread routines with probes in six slices of 90 (the
second batch at 0% grew them by half).

## Prior handoff (2026-10-15, E-0372)

Batch 4 (E-0372) finished the instruction-named queue (0 left) and shortened 288 long labels; 0 rejected.
Queue: long (over 50) 102, over 60: 14, `Etc`: 1 (GiftEffect_BookmarkEtc), unread 4,499, reader-only data 501,
assets 155. Next: E-0373, the last long labels plus the first reader-only data labels, slices of 60 (the second
batch at 0% would grow them to 90).

## Prior handoff (2026-10-15, E-0371)

Batch 3 (E-0371) named 516 routines; worker 1's draft (133 labels, banks $31-$36) was rejected for a name that
repeated a wrong note, so those labels are back in the queue (instruction-named: 130). Rejection 20.7%: the next
slices are 60 labels with callers and tables listed in the brief. Queue: instruction 130, long 427, over 60: 57,
unread 4,535, reader-only data 525, assets 155. Next: E-0372, the 130 re-queued labels (two slices of 60-70, one
dedicated worker each) and the long-name queue in slices of 60.

## Prior handoff (2026-10-15, E-0370)

Batch 2 (E-0370) named 553 more instruction-named routines (banks $0F-$31), 0 rejected; the equipment table is
RemoveEquipmentBonus (it takes back a given-up item's bonus). Probe tools exist (tools/probe.py,
tools/probe_scope.py, tests/test_probes.py; D-012). Queue after E-0370: instruction 655, long 587, over 60: 108,
unread 4,535, reader-only data 525, assets 155; probe scope 5,694 code labels (4,124 hardware, 3 interrupts, 1
unresolved). Next: batch E-0371, the remaining instruction-named labels in six slices of up to 120 (slice size grown
by half after two batches at 0% rejection).

## Prior handoff (2026-10-14, E-0369)

Batch 1 (E-0369) named 547 instruction-named routines in banks $00-$0F from readings by six read-only workers
(0 rejected) and corrected about 40 earlier notes. Binary identity: **PASS**, `build/run606/report.json`.
Open questions: [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md). Next: batch E-0370, the next six
slices of the instruction-named queue (from bank $0F on), slice size 80 (grows by half after a second batch
below 5% rejection).

## Prior handoff (2026-10-14, E-0368)

E-0368 finished the uncommitted continuation of E-0367 (588 routines named after the RAM they touch, now named
from their E-0357 notes) and added the batch tools: tools/run_tests.py, tools/readability_queue.py,
tools/label_map.py, tools/apply_drafts.py. Binary identity: **PASS**, `build/run604/report.json`; full serial
suite `build/logs/suite604.log` OK, parallel `build/logs/par604.log` identical. Next: batch E-0369, the first six
slices of the instruction-named queue (529 labels, banks $00-$0F), drafted by read-only workers.

## Prior handoff (2026-10-14, E-0367)

E-0366 was committed after suite580 (OK). This round renamed the steps of the
game's state machines: the jumptable entries that the step-naming pass had
named after their first callee (`KeyAppraisalMenu_CopyBytesDEToHL_Bank0D`)
are named from their hand notes in the pokered manner
(`KeyAppraisalMenu_Init`, `ArenaMenu_PayEntryFee`,
`RunBattleSetup_PlanMenu_ChooseAction`), with 50 dispatchers renamed to match
(TitleMenu, TitleOpening, LinkRulesEditor, ForgetSkillMenu,
LinkBattleSetupMenu, ...): 1,878 labels in all. Only 16 jumptable entries,
all without a hand note, keep a callee name. Final binary identity:
**PASS**, `build/run602/report.json`, 4,194,304 bytes, approved SHA-256, zero
differences; full suite: `build/logs/suite602.log`. Next: names that still
describe instructions rather than purpose outside the state machines
(`Write...Etc`, `..._ReadByteAtHLPlusA`), and a read-through of a few banks
as a reader would meet them. The full readability goal remains active.

## Prior handoff (2026-10-14, E-0366)

E-0365 was committed after suite578 (OK). This round reads the last 105
routines that only had a generated restatement (95 AI scorers in bank $E2 and
ten others), so every code label now carries a note written after reading the
whole routine or an older reading. Reading the save copies corrected E-0109:
the routine named CopySaveBlocksToSRAM copies from SRAM into WRAM, and the
sequence called RunSaveSteps only restores the save; they are now
LoadSaveBlocksFromSRAM and RunLoadGameSteps (with UnpackNextSavedRecord,
RestoreSRAMBank2FromBank3, LoadGM2TimerBlockFromSRAM). 5,246 hand notes, 0
restatements. Final binary identity: **PASS**, `build/run580/report.json`,
4,194,304 bytes, approved SHA-256, zero differences; full suite:
`build/logs/suite580.log`. Next: the long generated step labels (2,087 over 50
characters, many repeating their parent after `_To`), then a review pass over
names that still describe instructions rather than purpose. The full
readability goal remains active.

## Prior handoff (2026-10-14, E-0365)

The E-0364 round was committed after suite576 (OK). This round adds 553 notes:
the rest of bank $73's scenes and the 406 routines whose older notes admitted
a gap: bank $39's AI target choosers, bank $36's action effects (quoting the
battle texts their resolve messages pick), bank $E2's AI scorers, bank $16's
item checks, and talk handlers in banks $04 and $13. A hand note now replaces
the generated "; code:" restatement under such a note, and the stale "not
interpreted" clauses are gone from those routines' names-notes. Action ids
from 175 on whose string only repeats a skill's name are ACTION_<hex> instead
of SKILL_HIGHJUMP_B2 and the like; AddAIWeight / AddAIWeightToScore2 and
StoreHitMessage_Bank36 replace names that hid what they do. Now 5,141 hand
notes and 105 restatements. Final binary identity: **PASS**,
`build/run578/report.json`, 4,194,304 bytes, approved SHA-256, zero
differences; full suite: `build/logs/suite578.log`. Next: the last 105
restatements, then the long generated step labels (`..._ReadWordTableEntryForSlotC_BankA0_3`).
The full readability goal remains active.

## Prior handoff (2026-10-14, E-0357, E-0363 and E-0364)

E-0357 notes are written after reading each whole routine; E-0358 to E-0362
(a parallel session) read bank-$12 scenes with original-ROM probes, and where
both covered a routine the probed note was kept. Two rounds were committed
this session after full suites (suite572 and suite573, both OK).

This round adds 555 notes: banks $3B (item use), $61 (key-world maps and
warps), $E2 (AI scores), $F2, $60 (key-world generation), $84, $19 (battle
start), $39, $A3, $1A, $10, $31 (battle menus, fleeing, experience), the
one- and two-routine banks, and the first part of $73. Now 4,588 hand notes
and 569 restatements, most of the rest in bank $73. E-0364 corrects what the
reading exposed: bank $73's traveler events quote and are named from the right
message table (bank $09, category 5: the casino ship, merchants, masters, a
card game, a thief), bank $3B's compares name items, the key-world room table
and the battle menus are renamed. Final binary identity: **PASS**,
`build/run576/report.json`, 4,194,304 bytes, approved SHA-256, zero
differences; full suite: `build/logs/suite576.log`. Next: the rest of bank
$73, then a pass over the remaining E-0347 restatements and the long labels.
The full readability goal remains active.

## Prior handoff (2026-10-14, E-0361)

Read the five follower/player movement and warp command tables at bank $12
CPU [$4E4B,$4FEA), their ten stage routines and three related follower helpers.
There are 18 additional whole-routine notes and ten new explicit stage names.
Shared stages now read as `FollowerScene_BeginDown`,
`FollowerScene_WalkDownTo80` and `FollowerScene_FinishWhenLastYMatches`.
[FOLLOWER_COMMANDS.md](FOLLOWER_COMMANDS.md) explains their exact thresholds,
target snapshots, wrap and distinct transition contracts (C1, E-0361).

Ten original-ROM probes pass, including all five command dispatchers,
intermediate-boundary capture, last-Y-only completion, unsigned stagger gates,
four-pixel overshoot, delay preservation, fade parameters and action wait.
The next-screen setup probe checks input at the first callee; it does not
certify complete map loading. The earlier partial Y/direction reading E-0093
is completed here. No game code behavior changed; these remain C1 readings
in the project's emulator, without new hardware or full-scene validation.

Baseline `build/run566/report.json`: PASS. Final binary identity: **PASS**,
`build/run568/report.json`, 4,194,304 bytes, approved SHA-256, zero differences.
The companion `review.json` records revision, exact dirty tree and tool hashes.
All 54 scoped source/probe checks pass; documentation links and whitespace
checks pass. The full gameplay suite was not run this turn. Logs are under
`build/logs/e0361-*`; the initial family-name collision log is retained, and
regeneration passed after removing the duplicate explicit name, repairing
text encoding and correcting the fetch-request reading.
Remaining generated routine restatements: 3,639. Next: PlayerSpriteFlash
at $12:$4FEA, PlayerSpriteMessage and MapLinkWarp, tracing sprite override,
message and map-return consumers, then regenerate, check and build anew.
The full readability goal remains active.

## Prior handoff (2026-10-14, E-0360)

Read the five link/breeding presentation tables and their 32 core routines at
bank $12 CPU [$4919,$4E4B), plus the related field dispatcher, placement setter
and both graphics readers. There are 36 additional whole-routine notes, 26 new
explicit code-stage names and the named return-map table. Shared routines now
read as `MonsterScene_SlideFirstLeft`, `MonsterScene_RevealSecond` and
`MonsterScene_Wait30Calls`. [LINK_BREEDING_SCENES.md](LINK_BREEDING_SCENES.md)
explains the shared sequence, child message and distinct returns (C1, E-0360).

Ten original-ROM probes pass, including the conditional clipping save,
coordinate/counter wrap, graphics and palette slots, return selector and saved
state. Corrected older claims: both field loaders return table byte 2, while
using different VRAM/palette slots; the link finish routine reads the saved
link flag and copies it back, rather than setting it. No code behavior changed.
These remain C1 readings; no new full link/breeding session or hardware-timing
verification is claimed.

Baseline `build/run564/report.json`: PASS. Final binary identity: **PASS**,
`build/run565/report.json`, 4,194,304 bytes, approved SHA-256, zero differences.
Its `review.json` ties the result to the exact dirty tree, revision and tools.
All 54 scoped source/probe checks pass; documentation links and whitespace
checks pass. The full gameplay suite was not run this turn. Logs are under
`build/logs/e0360-*`; initial fixture-address failures are retained separately.
Remaining generated routine restatements: 3,650. Next: read FollowersStep14 at
$12:$4E4B, WarpWithFollowers and neighboring follower/player step commands,
tracing flags, coordinates, warp destinations and script returns, then regenerate,
run the appropriate checks and a fresh full-ROM build. The full goal stays active.

## Prior handoff (2026-10-14, E-0359)

Read the arena block at bank $12 CPU [$43DA,$4919), including both dispatcher
tables, 25 routines and the message table, plus the related round/grid helpers,
random foe builder and party heal. There are 29 new or revised whole-routine
notes (28 additional readings in the coverage count) and 23 new explicit stage
or helper names. Shared stages now read as `ArenaScene_WalkPartyIntoRing`,
`ArenaScene_WaitMessage` and `ArenaScene_HealAndLeaveArena`. See
[ARENA_SCENE.md](ARENA_SCENE.md) and E-0359 for the stage map and contracts.

Eight original-ROM probes pass in the project's emulator. They preserve exact
counter checks, low-byte-only message lookups, multiple step advances inside
the object loop and the heal helper's incoming SRAM bank. The random builder's
old "foe group" wording is corrected: each draw supplies one encounter word.
These remain C1 readings; a full arena playthrough and hardware timing are not
newly verified.

Baseline `build/run562/report.json`: PASS. Final binary identity: **PASS**,
`build/run563/report.json`, 4,194,304 bytes, approved SHA-256, zero differences;
`review.json` records the revision, dirty-tree and tool hashes. The scoped run
passed all 52 tests; 39 presentation/annotation/probe checks passed again after
final wording changes. Documentation links and whitespace checks pass. The
full gameplay suite was not run this turn. Logs are under
`build/logs/e0359-*`; the eight probes' initial fixture-address failure is also
retained. Remaining generated routine restatements: 3,679. Next: read
LinkMessageEvent at $12:$4919, NPC breeding warp and child-display stages with
their message, graphics and script-return consumers, then regenerate and run
the appropriate checks and a fresh full-ROM build. The full readability goal
remains active.

## Prior handoff (2026-10-14, E-0358)

Read the complete bank-$12 CPU range [$4001,$43DA), covering 33 routines for
countdown/encounter messages, a random-battle stub, and the two player/follower
paths. Their comments now explain the stages and transitions; 27 formerly
generated stage/helper names have concise action names. [OBJECT_PATHS.md](OBJECT_PATHS.md)
walks through the dispatch, banked curve call and eight-bit arithmetic.
The reading remains C1: five direct routine probes pass in our own emulator,
without independent hardware or full-scene validation. Asymmetric X/Y stores
are recorded and preserved (E-0358).

Baseline `build/run559/report.json`: PASS, zero differences. Final combined-tree
verification: **PASS**, `build/run561/report.json`, 4,194,304 bytes, approved
SHA-256, zero differing bytes. `build/run561/review.json` ties the report to the
revision, dirty-tree file hashes and tool binaries. Logs are under
`build/logs/e0358-*`: 79 source-wide checks/probes initially had two failures in
earlier work; both are corrected and pass on rerun, together with the note-count
check and three new audit controls (six tests, OK). A 63-case presentation/probe
run encountered the same two failures before those fixes; its log is retained.
All other checks in both runs passed. Documentation: 23 local links checked and
`git diff --check` clean. The full gameplay suite was interrupted before a
completion report; no full-suite pass is claimed. Readings remain C1.
Next reproducible action: read ArenaRounds at $12:$43DA and ArenaGridBattle,
including ArenaRankMessageTable and both encounter producers, then regenerate,
run the relevant checks and perform a fresh full-ROM build. The full readability
goal remains active, with 3,701 generated routine restatements still to replace.

## Readability state (2026-10-14, after E-0362)

Measured from `src/` by `tools/readability.py` and `tools/doc_coverage.py`; E-0361's final gate is recorded in the current handoff.

| Measure | State |
| --- | --- |
| Source form | pret style (D-005): no address aliases or machine bookkeeping in `src/`, `xor a` / `cp $10` / `[hli]` spelling, `jumptable` and `lb` macros, wrapped notes; one file per bank named by its contents (D-006), in a directory by kind: `home/`, `engine/`, `scripts/`, `text/`, `data/`, `maps/`, `gfx/`, `audio/`, `unused/` (D-010) |
| Text | 25,715 lines use the printer's command tokens (`<LINE>`, `<NEXT>`, `<PROMPT>`, `@`, ...; E-0336); no control byte is left raw in prose |
| Ids | 9,278 uses of `MONSTER_*`, `SKILL_*`, `ITEM_*`, `ACTION_*` and `RESIST_*` (D-007, E-0338), in code comparisons and data tables |
| Story flags and status | 347 story flags named `EVENT_*` (1,573 uses), after their setters, the message the setting routine shows, or (34 flags with no setter found) a routine that tests them, 11 by reading (`config/story_flags.json`); no flag number is left in a flag operand. All 72 battle status bits are named `BSTATn_*`, from forcing each bit in a battle, the skill that sets it, or the masks that treat two bits as one field; 8 with no reader or writer are `UNUSED_*` (D-009, E-0339, E-0346) |
| Assets | 3,550 graphics and map files included by name (`gfx/monster_sprites/drak_slime.lz`), extracted from the reference at build time (D-008); no offset into the ROM is left in `src/` |
| Labels | 33,306 global labels. None is an address name or spells a RAM or ROM address, none carries a `_CaseNN`/`_SubNN` state-machine index, and none lacks a description beyond its structure (E-0340, E-0344). Steps say what they show, call or write (`FhuntTalkEvents_ShowHeroCheckedBehindThe`, `..._SetDataBankSave`); data is named by its content or its reader (`Script_HowMayWeServe`, `MapObjects_Map94_3_Unlisted_0`). Copies and repeats are numbered `_2`, `_3`. A step name no longer repeats its parent's name (683 shortened in the current generation, E-0356); 722 labels are longer than 60 characters |
| RAM | 957 named addresses; none spells a byte number. Work bytes that different routines reuse are named after their main use, and the note lists the others (E-0345) |
| Pointers | No operand is a bare address (readability.py raw_pointer_operands 0). Pointers name their target, in another bank where the code shows which (`ld de, GlyphFont`, `ld hl, MonsterAttributeMapTable`, `NameEntryTileSrcListB + $..`). Values say what they are: `lb bc, $40, $90` pairs, `ld hl, -999`, `ld hl, 20000`, `PAL_WHITE`, `MSG_KEEP_OPEN | $0487`, `MSG_ALREADY_OPEN | $048b` (E-0357). 99 operands were read one by one (config/operands.json, E-0348, E-0350) |
| Documentation | Every label has a comment (9,822 code, 23,484 data; tools/doc_coverage.py), and every routine comment and table header cites an evidence or decision id. Notes written by reading cite their entry; restatements of the instructions cite E-0347; the 185 early readings were re-read against the code and 8 corrected (E-0353). Every restated routine also says what it is for (`; why:`): the step, helper, part or copy it is and the documented routine it serves (E-0352); no purpose line quotes a note that only names a dispatch (E-0354). A review of 30 random restated routines found every claim accurate and two weaknesses, both fixed (E-0355). 5,246 routines are now described by a note written after reading the whole routine (E-0357 through E-0362, E-0365, E-0366), which replaces the restatement; no code label is described only by the restatement. No comment names a label, RAM symbol or constant that does not exist. Every RAM symbol and hardware register has a comment (E-0347, E-0350) |
| Guide | [READING_GUIDE.md](READING_GUIDE.md) explains the layout, idioms, text tokens, constants, assets and evidence |

## Source presentation (2026-10-13, decision D-005)

`src/` is now written for readers, with the pret disassemblies (pokered) as the model. `tools/disasm_all.py` writes the annotated analysis listing to `build/listing/` (untracked, regenerated on every run), and `tools/present.py` writes `src/banks/` from it:

- no address-name aliases (`Func_BBB_AAAA`) or `; heuristic: ...` tags on labels;
- no machine-made cross-reference comments (call sites, reads/writes, "only called from");
- a comment repeated on every record of a table is written once;
- address names and `BB:AAAA` in comments become label names; evidence ids move to the end of the comment; long comments wrap at 100 columns;
- pret instruction spelling: `xor a`, `cp $10`, `ld a, [hli]`, lowercase hex, and the `jumptable` macro for `rst $00`.

Each bank file is named and headed by what it holds (D-006, `config/banks.json`): `bank00_home.asm`, `bank36_battle_effects.asm`, `bank2f_battle_text.asm`. The titles come from the names the bank's labels carry; the annotated listing keeps the plain `bankNN.asm` names.

Ids are named (D-007, `src/constants.inc`, made by `tools/gb_constants.py` from the ROM's name tables): `MONSTER_*`, `SKILL_*` (with `ACTION_FIGHT` and `ACTION_<hex>` for unnamed action ids) and `ITEM_*`. 225 comparisons of battle actions (`wBattleActionId`) and items (`wItemId`) use them, as do 200 table fields: natural skills, MonsterTable and preset-record skills, skill prerequisites, item order lists, and the monster ids of the breeding, library, encounter-band and key-world tables.

Graphics and map data are included as named asset files (D-008): `INCBIN "gfx/monster_sprites/drak_slime.lz"` instead of an offset into the ROM. `src/assets.txt` lists each file's slice of the reference; `tools/build.py` checks the reference's SHA-256 and extracts them into the build directory (3,550 files, never tracked). Lists indexed by monster id are named after the monster (`BreedSpeciesRules_DrakSlime`).

Text is written with charmap tokens for the text printer's 32 commands (E-0336): `db "<VOICE1>Cobi: <BUF0>!<LINE>"`, `db "Blaze@"`, with `<NEXT>`, `<PROMPT>`, `<WAIT>` and others named in `src/charmap.inc`. The font glyphs …()+~/★© are mapped too.

The instructions and data lines are unchanged, so the ROM is identical (build/run473, build/run475 with the text tokens). `tests/test_present.py` checks that `src/banks` is exactly the presented listing and that no code or data line is lost. The analysis tools and the tests that check annotations read `build/listing/`, so run `tools/disasm_all.py` before the suite. Confidence and evidence of every name stay in `config/` and in the listing. `tools/readability.py` measures what still reads as machine output.

## Readability state (2026-10-12, after E-0308)

Binary identity passes: SHA-256 `8e38a742...766d4e`, 0 differing bytes (build/run470). Tests: 235 run, 3 skipped. The figures below are measured from the generated `src/`:

| Measure | State |
| --- | --- |
| Labels with only an address name | 0. No primary `Func_`/`Jump_`/`Data_` label is left (`tools/rank_unnamed.py`: 0 routines). Address names remain as aliases under the names. |
| RAM operands with only an address name | 0 (`tools/rank_unnamed.py --ram`) |
| Structural labels | 0 left unnamed: no bare dispatcher and no bare step (generator count, E-0305). Every dispatcher is named, by reading (E-0288 to E-0304) or, for the smallest, from its steps. Global names that still contain `_CaseNN`/`_SubNN` keep it for a state number or to keep a descriptive name unique. |
| Branch targets | 13,086 named by shape (E-0287). Most are local labels such as `.loop`, `.set_sprite_slot_count`, `.call_queue_music`, `.return_01`; the rest are `<Routine>_<Shape>` globals. |
| Record and structure fields | 1,818 operands use field constants from src/records.inc (E-0290 to E-0308): `MON_*` (the $A5-byte monster record), `BATTLER_*` (the $4E-byte battler record), `SPECIES_*` (the 47-byte species record), `OBJ_*` and `SCRIPTOBJ_*` (field objects). |
| Monster record bytes not read | none: $28 and $33 are not read by any code (MON_UNUSED_28/33, E-0311) |
| Species record bytes not read | none: byte 5 is not read by any code (SPECIES_UNUSED_05, E-0311); $0B is the field ability (E-0313) |
| Event scripts and talk events | Every command type is a named constant (E-0244, E-0286, E-0293). Talk categories are named by region (E-0288). |
| String quotes | Message words, string displays (including through category and index wrappers, E-0292 and E-0294) and battle text are quoted at their call sites. |
| `INCBIN` without an asset comment | 0 (E-0301 corrected E-0289's reading of 17:5D79) |

How far the names can be trusted (E-0316):

| Kind of name | Count | Confidence |
| --- | --- | --- |
| Rule-made names that describe their instructions: branch targets (`.loop`, `.set_x`, `.call_x`, ...) and steps (`Parent_To<X>`, `_Set<V>To<NN>`, `_Write<V>`, `_Wait<V>`, ...) | 12,814 | C2: tests/test_name_claims.py checks every claim against the code |
| Strings and messages named by their identity (`String_BB_CC_II`, `Message_GG_II`, ...), plus streams, screens, sound tracks and table records named from their contents | 6,090 strings and messages, plus over 1,000 others | C2: named from the bytes themselves (E-0249 to E-0267) |
| Names given by reading (config/names.json): game meaning of routines and data | 5,443 | C1 or C2 as each entry's evidence states. Every routine or RAM name their notes mention (6,669, address forms read as their symbols) is connected to the code, with a negative control (E-0317). 10 readings executed in tools/sm83.py (E-0314, E-0315). A power-on run places the title, name-entry, field and opening-scene names in the game modes they claim, 413 named routines executed (E-0318). Every string the game looks up in an exploring run (13) sits at its String_/Message_ label, each talk routine entered looks up the message its name quotes, and screen pictures confirm the text reading, adding the glyphs 'v ($42) and ' ($95) (E-0319). Played in the emulator, story scenes run with the text their names quote, and a debug-menu battle runs 785 named routines in battle mode 4; the status page confirms the monster and battler record stat fields (C2) (E-0320). A key world's random encounters, the field menu, the pause menu (game mode 2) and PLAN in battle run with the screens their names describe, and confirm the gold, skills and location variables (E-0321). The field menu's choices, the bag's item ids, item use and the save refusal are observed; PauseMenu_Main and PauseMenu_State3 are renamed PauseMenu_Info and PauseMenu_Plan, and SaveForbiddenHere is named (E-0322). A save and a fresh-power-on CONTINUE round-trip every record, and both save checksums are recomputed from the cartridge RAM (E-0323). All 466 TalkMsg routines, called in the emulator, start the message their name quotes, after ten stale names were corrected (E-0324). GreatLog's Vault, Egg Evaluator and Christener run their menus and confirm the vault storage format and renaming (E-0325). MON_HP and MON_MP are the current values and the Herb's effect is measured (E-0326). A shop's buy and sell prices, the gold cap and an inn stay are measured (E-0327). Breeding runs from the menu to the hatched child and matches the family pair table and the parent fields (E-0328). The monster library's counts per family match a model of the seen-species flags (E-0329). The priest revives a monster whose MON_STATUS bit 7 is set (E-0330). Hibernation and the TinyMedal prizes are observed; wArenaWinsLo/Hi are renamed wTinyMedalsLo/Hi and an inventory slot's stray name removed (E-0331). The AI's per-skill scoring routines run only for skills their table assigns and a battle slot holds; AIScore_Skill00 is AIScore_Fight (E-0332). Battle actions run their table's effect routine after the battle text names the same skill; ActionEffect_Action00 is ActionEffect_Fight (E-0333). A Magic Key's appraisal confirms the key list's entry format (E-0334). The swap menu's Drop off and Pick up write MON_STATE as its meaning says (E-0335) |

Open questions:
- Answered since E-0308: MON_SEX bit 0 is 0 male, 1 female (E-0311); MON_EGG is 0 none, 1 unappraised egg, 2 appraised egg (E-0311); gifts go to an Egg whose record is wGiftRecord: they raise its max HP and shift its family scores, which pick its species (E-0312).
- Confirming the C1 readings in play. tests/test_readings_behaviour.py and tests/test_helpers_behaviour.py execute ten of them in tools/sm83.py (E-0314, E-0315). Execution corrected the battle result counters and found two palette-step quirks; most other names remain C1.

## Readability state (2026-10-12, after E-0291) (superseded above)

Binary identity passes: SHA-256 `8e38a742...766d4e`, 0 differing bytes (build/run393). Tests: 173 run, 3 skipped. The figures below are measured from the generated `src/`:

| Measure | State |
| --- | --- |
| Labels with only an address name (routines, branch targets, data) | 0. `tools/rank_unnamed.py` reports 0 routines; there is no primary `Func_`/`Jump_`/`Data_` label left. Address names remain as aliases under the names. |
| RAM operands with only an address name | 0 (`tools/rank_unnamed.py --ram`) |
| Branch targets | 13,086 former `Jump_BBB_AAAA` targets now have names (E-0287). Each is named by its shape: `.loop`, `.done`, `.return`, `.return_01`, `.set_sprite_slot_count`, `.check_script_param0`, `.call_queue_music`, `.next`, `.skip`, and so on. A target used by one routine is an RGBDS local label; 12,485 of them are local. A target shared by several routines is a global `<Routine>_<Shape>`. |
| Global labels with a structural part (`_CaseNN`/`_SubNN`/`_SharedNN`) | 2,820 of 33,238, down from about 4,270. The generator leaves 249 labels structural, 151 of them dispatchers whose cases inherit their name. 1,012 labels sit under those dispatchers. |
| Dispatchers named by reading (E-0276, E-0288) | Talk categories by region: Field, GreatLog, Kalka, Yold, Norden, Fhunt, Darck, ElvenVillage, KeyWorld, Readable. Menu flows: BreedMenu_ChooseParents, PriestMenu_PayForService, PauseMenu_Items_UseItem, and others. Battle phases: BattleEnd_GainExperience, RunBattleSetup_FleeCommand, RunBattleActions_UseItem, and others. |
| Event scripts | Every command type is a named constant. This includes the field and key-world talk events $80-$A1: StepTriggerReward, PartyDefeatedReturn, HealPartyEvent, KeyWorldBossBattle, and the rest (E-0286). |
| Monster record fields | src/records.inc (E-0290, E-0291) has `MON_*` constants for 21 offsets: state, name, species, family, sex, second name, skills, skill list, status, level, EXP, HP, max HP, MP, max MP, ATK, DEF, AGL, INT, personality, item. 416 `ld c, $NN` loads before record-access routines use them. |
| `INCBIN` without an asset comment | 1 slice of 359 bytes: SGBPacketSet18 (17:5D79). Only its first 64 bytes are identified (E-0289). |
| Battle results | ComputeBattleResultRank and ApplyBattleResultStatChanges are read, with their threshold and adjustment tables (E-0289). |

Most names are C1 readings, and many describe mechanics rather than game meaning. Still open:
- 151 dispatchers keep structural names. The largest is RollCounterChanceAndRunEvent_Sub01, with 75 cases that change wTopStat1 and wFamilyScores; its meaning is not established.
- Monster record bytes not yet read: $19-$33, $57, $6B, $6D, $6E, $73-$A3.
- Species records beyond family and EXP curve.
- MonsterTable bytes 6-9.
- Object slot bytes 0 and $F.
- Which sex value bit 0 of $0E stands for.

## Readability state (2026-10-12, after E-0276; superseded above)

Binary identity passes (SHA-256 `8e38a742...766d4e`, 0 differing bytes, build/run357; 160 tests, 3 skipped). Measured from the generated `src/`:

| Measure | State |
| --- | --- |
| Routines with only an address name (`tools/rank_unnamed.py`) | 0 |
| RAM operands with only an address name (`tools/rank_unnamed.py --ram`) | 0 |
| Code labels | 9,450: about 4,270 still structural (from 5,495). Named by rule from their instructions: 450 talk cases from their message (TalkMsgWWWW_..., E-0268), 138 one-time treasures (ChestItem_/VaseItem_/BarrelItem_..., E-0269, correcting E-0081), 94 script starters (TalkScriptXXXX_..., E-0271), about 550 single-purpose steps (Parent_To<Target>[AndStep], _Set<V>To<n>, _Advance<V>, _Return, _MsgWWWW_..., E-0270 to E-0273), 231 steps after the string they show (Parent_Show..., E-0274); shop, Vault and inn states named by reading (E-0276); dispatchers named by caller rather than address (RunLinkSession and its eight exchanges, E-0259/E-0260); (`_CaseNN`/`_SubNN`/`_SharedNN` state-machine steps), all prefixed by a named parent (E-0245: no `Func_BBB_AAAA_CaseNN` left); 151 still spelling a RAM address (E-0155) |
| `INCBIN` without an asset comment | 0 (build/measure2.py, E-0240/E-0241) |
| Data labels with only an address name | 1,029 (from 12,533 before E-0249). Labelled by identity: 6,175 strings (`Message_GG_II` = message word $GGII, `MessageBank0E_II`, `String_BB_CC_II`); 2,352 map screen streams and 732 key-world chunk screens by position; key-world rooms; 218 sound tracks; species records, item descriptions and default names by monster, item and family; skill prerequisite lists by skill; SGB packets by command; RAM init blocks, streams and bank-copy sources by destination (E-0249 to E-0267). Most of the rest are same-bank loads whose comment names their readers |
| Event scripts | 3,580 script lines. Every opcode with inline bytes has a named macro (E-0242). All 176 command types used are named constants: menus (`SCRIPT_SHOP`, `SCRIPT_BREED`, ...), actions (`SCRIPT_GIVE_MONSTER`, `SCRIPT_TAKE_ITEM`, ...), cutscene steps `SCRIPT_SCENE_*` named after their scene, and key-world talk events `SCRIPT_TALKGG_CC` (E-0244 to E-0246) |
| Tables | small multi-field tables print one field per line with its name (E-0262); the $A5-byte monster record and species records are laid out by field |
| Message quotes | read on LookupString's two levels (E-0243; they were one string off before), under the script's wMessageMode (E-0242), and in code: 1,354 `ld hl, $XXXX` message words before message calls, plus the first message of every script a routine starts (E-0248), string displays with constant category and index (E-0257) and battle text (E-0258) |
| Encounters | encounter words are MonsterTable ids and print their species; MonsterTable rows show theirs; `script_encounter` lines list the words (E-0263) |
| Likely game bugs | six executed and pinned by emulator tests (E-0075, E-0099, E-0154) |

Most routine and RAM names are C1 readings, and many describe mechanics or which routines use a byte rather than game meaning. Not yet done: meanings for most `_CaseNN` state-machine steps; many record fields (the SRAM monster record beyond its names, species records beyond family and EXP curve, MonsterTable bytes 6-9, object slot bytes 0 and $F); the states of the key-world talk-event commands; message quotes for key-world talk events (they use the wMapType bit-7 path).

## Readability state (2026-10-09, after E-0027)

Binary identity still passes (SHA-256 `8e38a742...766d4e`, 0 differing bytes, repeated clean builds); 102 tests pass. Readability measures from the generated `src/`, none of them a claim about game meaning:

| Measure | State |
| --- | --- |
| Call sites that reach a named routine | 50.7% of 21,781 (evidence-named; about 5,000 routines remain address-named) |
| Hardware, VRAM and RAM operands with names | 54,500; only 64 RAM names carry evidence, the rest are address names (`wC52B`) |
| Far calls as `farcall` macros | 3,775 |
| Idiom macros | `add_a_to_hl` 1,744, `deref_hl` 219 (E-0027) |
| Jump-table targets named `Parent_CaseNN` | 4,337 (E-0040), plus 191 script command stubs and 184 implementations named by command type (E-0038) |
| Library routine families named across banks | 30 families (`config/name_families.json`) |
| Text rendered as strings | 2,531 runs, 331,955 bytes (E-0024); `--no-text` keeps it as `INCBIN` |
| String display entry points | named, including 38 per-bank stubs (E-0026, E-0027) |
| Data tables laid out field by field | SkillTable (175), MonsterTable (592), ItemTable (99), MapTable, MapWarpTable, script command and opcode tables (E-0032 to E-0039); compressed streams 3,427 (E-0035) |
| Sound tracks decoded | 214 tracks; the engine's tick routine is not decoded |

Not done: most game logic (battle, menus, map, monster data) is unnamed; roughly 1.2 MB of `INCBIN` data (much of it probably compressed graphics) is unidentified; banks `$4A`-`$4D` hold 20x18 grids of unknown meaning. No external RAM map for this game was found (a web search turned up only a few addresses from a Japanese-version speedrun note), so names come from reading the code.

Dynamic analysis (E-0029, E-0030): `tools/explore.py` boots the reference ROM on our emulator with scripted input, draws frames (`tools/render_frame.py`) and lists the functions that run. It reached the title screen, name entry and the field (mode 1). [GAME_STRUCTURE.md](GAME_STRUCTURE.md) summarises the frame loop, the nine game modes and the named systems.

## Inventory and verification (historical, session 1)


The workspace was empty at inspection. `Get-ChildItem -Force -Recurse` returned no entries, and Git reported that this directory was not a repository. No existing project files or instructions were replaced. This session created the documentation linked from [README](../README.md); Git has not been initialized.

| Measure | Baseline value |
| --- | --- |
| Source/community survey | Completed for this baseline; limits recorded in [survey](SURVEY.md) |
| Reference ROMs present | 0 |
| Implemented build/verifier | None |
| Local ROM rebuilds performed | 0 |
| Binary identity | **UNVERIFIED — no input or build** |
| ROM bytes assembled or classified | Not measured; no ROM denominator |
| Game-semantic claims locally at C2 / C3 | 0 / 0 |
| Runtime traces or experimental game results | None |
| Upstream code imported / executed | None / none |
| Documentation QA | Relative links, Markdown structure, and target/confidence consistency checked at handoff |

Do not report a disassembly percentage yet. Later we will separately measure opaque bytes, decoded assembly, structured data, locally classified ranges, and semantic confidence. Matching is a pass/fail property, not a proxy for those measures.

## What the survey changes (historical, session 1)

Existing work gives us useful entry points but has not established a locally reproducible Cobi build. The most promising starting paths are low-level routines in the DWM2 repository, monster tables and encounter data in community research, and a DWM1 example of incremental extraction. Exact revisions and inspected files are in [the survey](SURVEY.md); leads and experiments are in [the knowledge map](KNOWLEDGE_MAP.md).

## Dependencies and risks (historical, session 1)

| Dependency or risk | Effect | Resolution |
| --- | --- | --- |
| No reference ROM | Blocks target fingerprint and all binary verification | Next session, locate the user's local reference and establish a manifest |
| Historical assembler syntax and unpinned tooling | Upstream commands may not reproduce their results | Audit a pinned revision in scratch space; pin our tested RGBDS version |
| Mixed versions in community maps | A correct offset elsewhere may be wrong here | Target hash on every local claim; reject out-of-bounds offsets |
| Missing or unclear upstream reuse terms | Adoption decision remains open | Inspect relevant file notices before copying code |
| Plausible but wrong semantics | Byte identity can coexist with incorrect documentation | Confidence tags, disconfirming tests, and claim-level review |
| Incomplete web access | Some research is visible only through indexed text | Preserve access depth; retrieve a revision before promotion or import |

## Next session: a concrete first milestone (historical, session 1; done by 2026-10-09)

1. Establish the reference identity: edition, revision evidence, full size, SHA-256, header fields, and cartridge mapping. Preserve the original unchanged.
2. Initialize version control and artifact exclusions; choose and pin the build environment. These are planned actions, not work already done.
3. Implement the verifier with tests that prove it rejects corruption, missing inputs, truncation, and stale output.
4. Build a scaffold containing every original byte at its original location; obtain two clean matching builds.
5. Replace one small, proven code region with equivalent assembly, rebuild, and explain the instructions together.

Success is a recorded full-ROM match plus one understandable, evidenced change. Roadmap phases 0–1 contain the detailed gates. Choosing a local ROM and setting up tools belongs to that next implementation session, not this planning deliverable.
