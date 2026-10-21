# Phased roadmap

Baseline: **2026-09-12**. Work is sequenced by evidence and exit gates. These are planning estimates, not deadlines; re-estimate after the first matching build. All phases inherit the full-ROM identity requirement and C0–C3 semantic standard.

## Current goal: a modding and translation ecosystem (from 2026-10-17, D-015)

The user's goal: anyone can easily translate the game into another language or make a mod or romhack from this
source. M1-M5 made the source safe to move and the assets and main tables editable. What stands in the way now is
mostly who owns the source, how data and text are exposed, and how mods are shipped. The matching target keeps
its identity gate on every change. A mod or translation is a separate, non-matching output and never replaces
`dwm2-cobi-us-rev0`. Mods are shipped as patches, never as ROMs.

| Stage | Work | Exit gate |
| --- | --- | --- |
| H1. Graduate src/ (done 2026-10-17, E-0402, E-0403, E-0407; [graduation](GRADUATION.md)) | src/ becomes the hand-edited source of truth, as in pokered. The generator stops writing src/ (it writes build/regen/src/ and a drift report); the checks that rely on config/ and build/listing/ become checks on src/ and the built .sym/.map; names.json and annotations.json are retired; the tools that write config/ are retargeted or retired | In a scratch copy with config/names.json, config/annotations.json and build/listing/ removed, the matching build PASSes and the full suite passes; a hand edit to src/ survives every tool the workflow runs |
| H2. Game data as files (done 2026-10-17, E-0408; [editing data](EDITING_DATA.md)) | Encounters, breeding rules, shops, arena and AI tables join species, skills and items as editable files packed back by the build, one table at a time | Each table packs back byte-identical and its readers (run on tools/sm83.py) load the packed bytes; matching build PASS |
| H3. Text pipeline (done 2026-10-17, E-0409; [translating](TRANSLATING.md); message bank overflow 2026-10-19, E-0416; text in code banks and battle text room 2026-10-20, E-0417, E-0418; banks $09 and $0D 2026-10-20, E-0420) | Every string to a translator file (id, context, width limit); reinsertion that repacks the text banks; build-time width checks; the font as PNG; room in the charmap for more letters | Unchanged English reinserts byte-identical; a test translation that grows text builds and its screens draw on tools/sm83.py; the limits (name fields, banks fixed by their readers) documented |
| H4. Full shiftability (done 2026-10-17, E-0414; readers by BANK() or reader 2026-10-20, E-0419; wDataBank and bank-copy numbers by label, E-0420; event scripts in any bank for mods, E-0421; [shiftability](SHIFTABILITY.md)) | E-0401 already pads 152 banks by 16 (107 by 256) over the 147 recipe runs, resolves the split sums and asserts the 512 fixed-bank pointer loads at link time. Left: the read gate reaches 2,299 routines, so more recipes or later save states (key worlds, late story, link play) are needed; moving a pointer whose reader fixes its bank still needs that reader changed | The recipe gate covers the code a mod is likely to touch (the routines H2 and H3 change at least); a moved fixed-bank table builds with its reader updated |
| H5. Mod smoke test (done 2026-10-17, E-0411; tools/mod_check.py) | One command that boots a modded ROM on tools/sm83.py, runs the scripted runs and reports crashes and divergence | Negative tests: a mod that breaks a pointer and one that breaks a table are both reported |
| H6. Distribution (done 2026-10-17 on Windows, E-0412; Linux 2026-10-19, E-0415) | BPS patches from a mod build; a patcher page (patch + your own ROM); a mod template; a cross-platform setup (RGBDS is pinned for Windows today) | A clean checkout on Windows and one other platform builds a mod and its patch, and the patch applied to the reference gives the mod build byte for byte |
| H7. Modder documentation (done 2026-10-17, E-0413; [making a mod](MODDING.md)) | A modder's guide (confidence tags in plain words) and three tutorials: a monster's stats, a line of text, a breeding recipe | Each tutorial is followed from a clean checkout and its result checked by H5 |

H1 comes first because every later stage edits src/ or data that src/ includes. H2 and H3 can then run side by side.
Now that H1-H7 are in place, static recompilation and progressive decompilation into C for a native PC port are
sequenced in stages P1-P4 below.

## Planned goal: native PC port and idiomatic C decompilation (stages P1-P4)

The goal: get the game running natively on PC (Linux, Windows, macOS) and progressively replace mechanical
instruction-level C with human-readable, idiomatic C—without losing or altering any part of the matching Game Boy
Color disassembly (`src/`), verification suite (`tests/`), or modding/translation tools (`tools/`).

### Architectural principles

1. **Additive layout (`port/` alongside `src/`):** `src/` remains the canonical RGBDS assembly source that builds
   `dwm2-cobi-us-rev0` byte for byte. Because commercial GB/GBC games were written in handwritten SM83 assembly
   rather than C, C source targets native PC executables rather than compiling back into the `.gbc` ROM.
2. **"Ship of Theseus" scaffold (Recomp -> Decomp):** Rewriting all 9,820 routines in idiomatic C before
   booting would delay any runnable build for months. Instead, `tools/recomp_c.py` first translates `src/*.asm` (and
   the build's `.sym`) into mechanical C functions in `port/generated/` (`gb_ctx_t` register/flag operations, with
   weak linkage or build-time override tables). Once the full game runs and passes every probe and recipe in native
   C, routines and banks are rewritten one module at a time into clean, idiomatic C in `port/src/` with typed structs
   (`MonsterRecord`, `BattleState`), parameters, and control flow.
3. **Bring-Your-Own-ROM (BYOR) asset extraction:** Like the rest of the repository, the PC port never distributes
   copyrighted ROM bytes. On first launch or build setup, it verifies the user's local `dwm2-cobi-us.gbc` against the
   approved SHA-256 (`8e38a742...766d4e`) and extracts the required ROM tables and assets locally.
4. **Leveraging existing project invariants:**
   - **Code/data separation:** All 9,820 code labels and 23,160 data labels are already separated into 9,071 sections
     in `src/layout.link` ([leftover code](LEFTOVER_CODE.md)).
   - **Computed jumps:** Only 44 routines are affected by computed `jp hl` jumps ([probe scope](PROBE_SCOPE.md)), and
     every `rst $00` (`JumpTable`) inline word table and `farcall` target is already decoded in `src/`.
   - **Frame loop and `halt`:** The main loop (`$02D2`) `halt`s while almost all per-frame logic executes inside
     `VBlankHandler` (`$03A4`, [game structure](GAME_STRUCTURE.md)). In C, `WaitForVRAMAccess` becomes a no-op and
     `halt` yields via a lightweight coroutine (`libco`) back to the host frame loop.

### Planned directory structure

```text
src/                        canonical RGBDS assembly (untouched; builds byte-identical .gbc ROM)
config/probes/              16,780 routine probes shared by both tools/sm83.py and tools/probe_c.py
tools/
  recomp_c.py               transpiles src/*.asm + .sym -> port/generated/*.c for routines not yet in port/src/
  probe_c.py                runs config/probes/*.json and tools/recipes/*.txt against the native C build
port/                       native PC port and idiomatic C decompilation (C11/C++20, CMake + Ninja, SDL3)
  CMakeLists.txt
  include/                  typed C headers, hardware context (gb_ctx_t), and game structs
  runtime/                  SDL3 window/input, CGB scanline PPU, 4-channel APU (blip_buf), libco halt yield,
                            MBC5/RAM map, SRAM .sav persistence, and UDP/local serial link shim
  src/                      hand-written, idiomatic C decompilation modules (replaces port/generated/ piece by piece)
  generated/                (git-ignored) mechanical C fallback emitted from src/*.asm by tools/recomp_c.py
```

### Stages and exit gates

| Stage | Work | Exit gate |
| --- | --- | --- |
| P1. Headless C transpiler & verification harness | Write `tools/recomp_c.py` to emit mechanical C (`port/generated/`) from `src/*.asm` and `.sym` (`rst $00` tables as C `switch` blocks, `farcall` as direct cross-bank calls, `halt` as `libco` coroutine yield) plus a headless memory/MBC5/WRAM/VRAM/SRAM/serial runtime ported from `tools/sm83.py`. Add `tools/probe_c.py` | All 5,872 probe-scope routines (16,780 probes in `config/probes/`) and all 222 scripted recipe runs + link-breeding runs pass in native C with identical RAM/VRAM/trace results to `tools/sm83.py`; canonical RGBDS ROM build still PASSes |
| P2. Playable SDL3 PC runtime | Add `port/runtime/` with SDL3 windowing, controller/keyboard input, a CGB scanline PPU renderer (2 VRAM banks, BG/OBJ RGB555 palettes, OAM, STAT window/scroll split), a 4-channel CGB APU audio synth (`blip_buf`), `.sav` SRAM persistence, and startup BYOR SHA-256 verification | Clean native CMake/Ninja build on Linux and Windows boots from a user-supplied reference ROM through title, field, battle, breeding, save/load, and two-instance link play with matching visual frames and audio output |
| P3. Progressive idiomatic C decompilation | Replace mechanical C in `port/generated/` one subsystem at a time with human-readable C in `port/src/`, starting with the C2-verified specifications in [mechanics](MECHANICS.md) (join offer, level-up gains, breeding child and rolls, skill learning, bank `$36` battle damage/effects) and [data tables](DATA_TABLES.md) loaders, then battle core (`bank31`), menus, scripts, and field logic | Each hand-written C module replaces its `port/generated/` counterpart with 0 regressions across all 16,780 probes, 3,000-state mechanics checks, and 222 recipe runs; exact integer widths, overflow, flags, and RNG consumption preserved |
| P4. Native PC enhancements & mod integration | Direct loading of `.bps` patches and loose `mods/` folders (JSON/CSV table edits from H2, text/font edits from H3), UDP/local-socket link cable for online or dual-window Link Breeding and Battles, fast-forward/turbo toggle, and optional ImGui debug/state overlays | `mods/example` and the three H7 tutorial mods load and pass `tools/mod_check.py` parity on the native PC build; two PC instances complete a link breeding and battle over the socket shim |

## Moddable decomp: M1-M5 done (2026-10-16, E-0388 to E-0396)

Every stage below has met its exit gate, and the matching build has passed after each one:
- M1-M2: [shiftability](SHIFTABILITY.md).
- M3: [editable assets](ASSETS.md).
- M4: [leftover code bytes](LEFTOVER_CODE.md).
- M5: [mechanics](MECHANICS.md) and [data tables](DATA_TABLES.md).

What stays open is listed in each document and in [readability open questions](READABILITY_OPEN_QUESTIONS.md):
- the key worlds' generation and the late story's scenes as mechanics; damage (all of bank $36's damage routines),
  skill learning, applying damage and the bred child's later rolls were added after M5 (E-0397 to E-0399, E-0404,
  E-0405);
- the scripted runs' reach: 2,638 routines with the recipe chain and 25 later-world maps, a completed link breeding,
  a key world entered at the shrine (E-0401, E-0406, E-0410); the rest only by the static inventory.
The split sums and fixed-bank pointers left after M2 are done (E-0401).


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

**Status:** five mechanics meet the gate on the project's emulator ([mechanics](MECHANICS.md)): the join offer, level-up gains and the breeding child (M5, E-0396); damage: the plain attack, the 16 roll-and-resistance routines, the step-7 modifiers (E-0397) and applying it to HP (E-0399); skill learning (E-0398); the other 28 damage routines of bank $36 (E-0404); and the bred child's sex, resistances,
skill list and stat bonus (E-0405). The key worlds' generation is open.

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
