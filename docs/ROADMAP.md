# Phased roadmap

Baseline: **2026-09-12**. Work is sequenced by evidence and exit gates. These are planning estimates, not deadlines; re-estimate after the first matching build. All phases inherit the full-ROM identity requirement and C0–C3 semantic standard.

## Moddable decomp: M1-M5 done (2026-10-16, E-0388 to E-0396)

Every stage below has met its exit gate, and the matching build has passed after each one:
- M1-M2: [shiftability](SHIFTABILITY.md).
- M3: [editable assets](ASSETS.md).
- M4: [leftover code bytes](LEFTOVER_CODE.md).
- M5: [mechanics](MECHANICS.md) and [data tables](DATA_TABLES.md).

What stays open is listed in each document and in [readability open questions](READABILITY_OPEN_QUESTIONS.md):
- three address-like split sums;
- 511 pointers whose bank the reading code fixes;
- the scripted runs' reach (under 5% of the routines);
- the other mechanics of phases 4-5 (skills learned, the effect routines beyond roll and scale, the key worlds);
  damage was added after M5 (E-0397).


The goal as set on 2026-10-16, after the readability goal (below): make the source safe to edit (could code and
data move, could assets be edited, was unreached code still `db` bytes), then turn to what the game does.
Throughout, the matching target keeps its identity gate on every change: a shifted or re-encoded build is a
separate, non-matching output and never replaces `dwm2-cobi-us-rev0`. Final state: build/run682 PASS on master
3eeb0ba, serial suite OK (439 tests, 3 skipped).

| Stage | Work | Exit gate |
| --- | --- | --- |
| M1. Shiftability audit (done 2026-10-16, E-0388: [shiftability](SHIFTABILITY.md); four banks break, five references located) | A shift test assembles a scratch copy of src/ with padding inserted and reports what breaks; an inventory of hard-coded references: CPU addresses as numbers in `db`/`dw` data, far pointers written as bytes, bank numbers as literals instead of `BANK(label)`, pointers inside INCBIN slices | tools/shift_test.py with negative tests; docs/SHIFTABILITY.md with counts by kind and bank; matching build still PASS |
| M2. Labels for hard-coded references (done 2026-10-16, E-0389 to E-0393: every reference the runs found is a label; 65 split table addresses and the bank numbers beside pointers are label expressions; all banks padded by 16 pass the read gate; 9,071 floating sections placed by src/layout.link, and two routines moved to other banks run identically; open: 3 split sums, and 511 pointers whose bank the reader fixes) | Replace each inventoried reference with a label expression, one bank or table at a time | Matching build PASS after each batch; the shift test's count of breaking references falls to 0; a padded build boots to the title screen on tools/sm83.py like the matching one |
| M3. Editable assets (done 2026-10-16, E-0394: [editable assets](ASSETS.md); the encoder reproduces all 3,546 streams, assets build from decoded data, `--mod` builds from edited PNG and .bin files) | Extract graphics to PNG and maps and tables to text formats, built back with rgbgfx and project tools; an LZSS encoder that reproduces the original compressed bytes | The build needs the reference ROM for no asset slice (or each remaining one is documented); matching build PASS; a test that every stream re-encodes byte-identically |
| M4. Leftover code bytes (done 2026-10-16, E-0395: [leftover code bytes](LEFTOVER_CODE.md); 102 unreached routines decoded, named, read and probed; the 384 other gaps after a routine end listed with their verdict) | Find `db` runs that decode as code no traced path reaches (for example bank $29 `db $cd, $01, $40, $cd, $11, $26, $c9`, which would read as call, call, ret; C1, not yet checked) and decode or document each | Every such run decoded or listed with its reason; matching build PASS |
| M5. Mechanics (done 2026-10-16, E-0396: [mechanics](MECHANICS.md), [data tables](DATA_TABLES.md); the join offer, level-up gains and breeding child as specifications that agree with the game on 3,000 generated states each; the species, skill and item tables exported, packed back byte for byte and read by the game's loaders for every id) | Species, skill and item tables, then one mechanic at a time (breeding, recruitment, growth), with emulator experiments | Per the phase gates below; claims promoted above C1 only with recorded experiments |

M1 to M3 made the source moddable. The open questions in
[readability open questions](READABILITY_OPEN_QUESTIONS.md) (1,852) remain the queue for later semantic work.

## Readability goal: complete (2026-10-16, E-0386)

The pokered-style readability goal for `dwm2-cobi-us-rev0` (goal.md) is complete. Final run directory:
**build/run643** (approved size and SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`,
zero differing bytes); the final commit passed that identity check and the full test suite, serially and in
parallel ([project status](PROJECT_STATUS.md), E-0386 in the [evidence log](EVIDENCE_LOG.md)).

Measures at completion (tools/readability.py, tools/doc_coverage.py, tools/readability_queue.py,
tools/probe_scope.py):

| Criterion | Result |
| --- | --- |
| Code labels with a hand-written reading note | 9,822 of 9,822 |
| Labels named after their instructions (`_Etc`, `_ReadByteAtHLPlusA` and similar) | 0 |
| Labels over 60 characters | 0 (exceptions: none needed) |
| Labels over 50 characters | 2 (0 after E-0387, which gives each table one name), each one of two names for the same palette table, made from the routine that references it from another bank: `RunWorldMapState_CopyScrollToHardware_BGPaletteBufferData` (57; the other name is `RunWorldMapState_DrawOverview_BGPaletteBufferData`) and `LoadPlayerAndFollowerSpriteGraphics_OBJPaletteBufferData` (56; the other name is `SharedOBJPalettes`) |
| Data labels described only by their reader and size | 0 of 23,561 |
| Opaque INCBIN slices | 0: 140 identified and named, 13 listed with what was tried in [unidentified assets](UNIDENTIFIED_ASSETS.md) (5 after E-0387 merged 8 split streams back) |
| Routines a probe can check | 5,874, all with a passing probe (16,782 probes in config/probes/) |
| Routines a probe cannot check | 3,948, each with its reason in [probe scope](PROBE_SCOPE.md) (display, sound, serial or joypad hardware 3,899; interrupt timing 5; computed jumps 44) |
| Mechanical labels, raw pointer operands, stale names in comments | 0, 0, 0 |

The readings are C1 (static) unless a probe checks their mechanical claims (C2 on the project's emulator, not
hardware); what a routine is for stays C1. Open questions: 1,852 entries by batch and label in
[readability open questions](READABILITY_OPEN_QUESTIONS.md). The main ones that need work outside readability:

- **Generator stream splits, code typed as data, second-name labels: done (E-0387).** The chaining heuristic
  (config/stream_chains.json) no longer splits a stream: 28 chain streams that started inside another stream, or ran
  over the start of one, are dropped, and tests/test_asset_streams.py checks that every compressed slice holds its
  whole stream. The five `dw` lines at bank $32 $4F00 are decoded as the routine RunBattleActions_StatusChecks_PairRefusal.
  The generator now gives each table one name (373 tables), so no label is over 50 characters. Measures after
  E-0387 (build/run651): 9,820 code labels, all read; 23,160 data labels; 5 slices listed in
  [unidentified assets](UNIDENTIFIED_ASSETS.md); 5,872 routines in probe scope, all probed (16,780 probes).
- **Unused content.** 98 key-world floor screens, three map records and several routines have no reference in the
  shipped ROM (listed in their notes); some may be reached in ways the static listing does not show.
- **Probe limits.** Writes to WRAM bank 2 (the CGB attribute buffers) are not observed by the probe runner, so those
  parts of probed notes stay C1.

## Current goal and next gate (2026-10-14, historical)

The active goal was full pokered-style readability for the matching Cobi target (completed above).
The matching build exists; the dated phase plans below are historical. Their
semantic exit gates remain separate from source presentation and have not all
been certified. Current progress and counts are in [project status](PROJECT_STATUS.md).

Replace the remaining generated routine restatements with whole-routine
explanations and concise action names, reading callers, tables and stage
transitions together. E-0358 covers the bank-$12 path block and E-0359 its arena
block beginning at $43DA. E-0360 covers the link/breeding presentation beginning
at $4919; E-0361 covers the following follower/player step and warp block
[$4E4B,$4FEA). E-0362 covers sprite-flash/message and map-link warp
[$4FEA,$51F4), including graphics-id loading/rendering and the shared lift.
Next are MapExitWarp at $51F4, its destination table and ReturnWarp stages. Each accepted block requires regeneration, grounded
documentation/naming checks and a fresh full-ROM match of the combined tree.
Completion also requires reviewing table/RAM contracts, residual opaque assets,
unsupported semantics and reproducibility; zero address labels alone does not
establish full readability. (Completed 2026-10-16: see the section above.)

## Phase 0 — Archaeological survey and target definition

**Status (2026-10-17):** done except the catalog cross-check. The reference is identified by its measured hash and header (`config/targets/dwm2-cobi-us-rev0.json`); no upstream source was adopted (fresh scaffold, [survey](SURVEY.md)); whether the hash is an unmodified retail dump is not checked against an independent catalog.

Read existing repositories and community sources without running their scripts. Record exact commits, target variants, source provenance, inspected files, build claims, dependency assumptions, and reuse terms. Search forks and author-linked resources when they can fill a specific gap. Preserve source conflicts and distinguish firsthand research from copied summaries.

Deliverables: [survey](SURVEY.md), [knowledge map](KNOWLEDGE_MAP.md), [initial evidence](EVIDENCE_LOG.md), target decision, later ROM manifest and adoption decision. The title selection is done; the manifest cannot be completed without the local reference.

**Exit gate:** identify one reference ROM and its hash; establish what source may be reused; document whether any upstream Cobi build actually matches under captured conditions. A failed or incomplete upstream build does not block a fresh scaffold, provided its result is recorded honestly.

Planning allowance: 1–3 focused sessions to finish target and adoption work once inputs are available.

## Phase 1 — Baseline build and trustworthy binary diff

**Status:** done (2026-10-09, [project status](PROJECT_STATUS.md), session 2): two clean full-ROM matches (build/run1, build/run2), the verifier's negative tests, RGBDS pinned in config/toolchain.lock.json.

Dependencies: identified local reference and a tested toolchain choice.

Initialize Git and exclusions, pin RGBDS and helper-tool versions, implement the verifier and its negative tests, and generate a fixed-bank scaffold preserving every original byte. Review unknown slices as build dependencies. Capture complete build/diff reports and source maps. Reproduce from clean directories; do not make emulator booting the acceptance criterion.

Deliverables: manifest, toolchain lock, reproducible extraction, one documented build/verify entry point, symbols/map, reports, and opaque-range coverage inventory.

**Exit gate:** two clean full-ROM matches against the reference; failure cases rejected; no stale-output fallback; a changed test byte is detected; one small code or data slice replaced with authored assembly and the full ROM still matches. Opaque bytes remain counted explicitly.

Planning allowance: 2–5 sessions, depending on toolchain setup and upstream compatibility. First usable milestone is matching scaffolding, not a large renamed bank.

## Phase 2 — Orientation and first teaching investigations

**Status:** partly. The boot path, frame loop and game modes are in [game structure](GAME_STRUCTURE.md) (C1, run on tools/sm83.py); bank transitions and routine contracts are in the notes of every routine. The gate's C3 routine claim is not certified (claims stop at C2, the project's emulator).

Dependencies: phase 1 passes.

Trace the cartridge entry path, enabled interrupts, one bank-switch path, and one short copy/input routine. Locate a small data consumer to connect a banked ROM read to observable behavior. Build an initial ROM/RAM map and learn the debugger together.

Deliverables: a short boot-path document; one example of a bank transition with before/after context; routine contracts; two or three reproducible evidence records; learning exercises 1–4 completed.

**Exit gate:** locally supported entry/bank observations, one C3 routine claim within a narrow scope, the user can walk through a small instruction sequence, and all accepted source changes preserve the full match. Unknown callers and RAM-bank state are visible rather than guessed.

Planning allowance: 3–6 sessions. Do not wait for all of bank 0 to be understood before tackling a useful data path.

## Phase 3 — High-value data recovery

**Status:** the species, skill and item tables meet the per-table gate (M5, [data tables](DATA_TABLES.md): bounds, pointers, exact round trip, every id through the game's loader; C2). Other tables are laid out in config/tables.json with C1 field notes.

Dependencies: address/bank conventions and a reliable scaffold.

Investigate monster species IDs and records, name lookup, growth/experience tables, skills, items, and fixed encounters. Start with a small bounded subset, trace the reader, then expand. Treat core species IDs, prebuilt encounter IDs, and runtime party slots as potentially distinct namespaces.

Deliverables: original schemas with unknown fields preserved; deterministic extractors; exact data round trips; small readable tables; evidence for pointer interpretation, record sizes, and consuming code. Link each data explanation to gameplay context.

**Exit gate per table:** bounds, pointer handling, count/stride, holes/aliases, and terminators checked; output bytes equal the reference; at least representative consumers tested; field confidence recorded individually. A decoder that prints plausible monster names is not sufficient.

Planning allowance: several weeks of regular sessions; recover one coherent table at a time.

## Phase 4 — Mechanics and state transitions

**Status:** four mechanics meet the gate on the project's emulator ([mechanics](MECHANICS.md)): the join offer, level-up gains and the breeding child (M5, E-0396), and damage: the plain attack, the 16 roll-and-resistance routines and the step-7 modifiers (E-0397). Skill learning, the other effect routines, applying damage to HP, and the child's sex, resistances, skills and stats are open.

Dependencies: relevant phase 3 records and routines, plus reproducible saves/input recipes.

Choose one mechanic according to user interest: recruitment, damage and resistance, growth, skill learning, or breeding. Trace its complete data flow, including integer widths, rounding, flags, RNG consumption, and special cases. Define experiments before relying on a plausible formula.

Deliverables: an explanation suitable for a technical newcomer to assembly, constrained pseudocode, evidence-linked assembly, and a small set of contrasting/boundary cases. Native game behavior and intentionally modified experiments remain distinguishable.

**Exit gate per mechanic:** a bounded specification reproduced from local bytes and execution; evidence includes counterexamples considered; uncertainty remains explicit; canonical build matches. Models of a random process must distinguish arithmetic correctness from distribution assumptions.

Planning allowance: multiple iterations per mechanic. Breeding and RNG are likely to need more investigation; that is a planning judgment, not a verified engine-complexity measurement.

## Phase 5 — World, presentation, persistence, and communication

**Status:** partly. Graphics compression meets its gate (an encoder reproduces all 3,546 streams, M3, [editable assets](ASSETS.md)); sound tracks are decoded (E-0018, E-0019); the save round trip and checksums were observed (E-0323). Maps, key-world generation, text rendering and link remain C1 readings.

Dependencies vary by subsystem. Trace maps and events, procedural keys/worlds, graphics decoding, text rendering, audio dispatch, save format/checksums, and serial/link operations. Pursue each through a bounded question instead of parallel broad rewrites.

Deliverables: format and state-machine documents, read/write contracts, decoding and round-trip tools where feasible, save fixtures with local storage rules, and recorded emulator configurations. Use the audio converter and existing map research as leads, with target-specific validation.

**Exit gate per subsystem:** documented external interfaces and important state transitions, tested failure/boundary cases, exact byte preservation, and confidence-qualified claims. Compression work must preserve the original compressed stream until an encoder produces identical bytes; visually identical decoded graphics do not satisfy the build gate.

Planning allowance: ongoing work over months. Link behavior may require coordinated emulator instances or hardware; defer that dependency until its investigation is selected.

## Phase 6 — Consolidation and optional variants

**Status:** not started.

Dependencies: stable Cobi build and enough recovered structure to make comparison useful.

Reconcile duplicate concepts, review old C1/C2 assumptions, generate searchable indexes and coverage maps, test setup from a fresh checkout, and prepare a clear contribution guide. Consider Tara first as a separate target, then DWM1 or regional variants if the user wants them.

**Exit gate for a new target:** separate manifest and identity check, separately measured rebuild, explicit mapping of shared versus variant-specific ranges, and evidence for each transferred semantic claim. Never apply a single global address delta without proving it across the relevant ranges.

Project completion is not defined by a green byte comparison alone. A long-term completion review must account for every byte, the residual opaque regions, unresolved semantics, runtime scope, and reproducibility from preserved instructions.

## First task queue (2026-09-12; T-001 to T-004 and T-006 done, see the phase status above)

| ID | Task | Owner role | Prerequisite | Acceptance |
| --- | --- | --- | --- | --- |
| T-001 | Identify local Cobi reference and write manifest | Lead + user for reference provenance | Local reference path | Measured size/hash/header; revision certainty recorded |
| T-002 | Pin and audit candidate build environment | Lead | T-001; relevant upstream notices | Tested version/flags and adoption note |
| T-003 | Implement complete-file verifier | Lead | Manifest contract | Positive/negative fixtures pass; failure propagates |
| T-004 | Create fixed-bank opaque scaffold | Lead | T-001–003 | Two clean complete matches; no hidden repair step |
| T-005 | Explain and transcribe one short routine | Lead + user | T-004 | Full match plus scoped evidence and teach-back |
| T-006 | Validate one monster-table pointer path | Lead | T-004 and bank conventions | Local consumer evidence; unknown fields preserved |

## Progress reporting

Report binary identity as PASS/FAIL/UNVERIFIED with a source revision. Report opaque bytes, decoded assembly bytes, structured data bytes, and classification coverage as distinct, non-overlapping measures where possible. Record mixed-use ranges explicitly and avoid double-counting. Report C0/C1/C2/C3 claims separately from byte coverage; known data is valuable progress, not code disassembly.

After each phase gate, compare actual effort with the estimate, identify the highest-value unanswered question, and revise the next phase. Do not use calendar pressure to weaken the matching requirement or inflate confidence.
