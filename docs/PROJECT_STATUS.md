# Project status

As of **2026-09-12**. Stage: **planning baseline complete; implementation not started**.

## Target and decisions

| Item | State | Basis |
| --- | --- | --- |
| First game | DWM2: Cobi's Journey, GB/GBC | User selected during this session |
| Intended edition | US English working assumption | Resolve against the actual reference; do not infer revision from filename |
| Exact revision / header / mapper / ROM size / RAM size | Unknown | No local ROM inspected |
| Reference SHA-256 | Unknown | Must be measured and recorded before baseline build |
| Other targets | Deferred | Tara and DWM1 are comparison sources, not supported builds |
| Primary output | Matching assembly plus evidence-backed documentation | Project design decision |
| Implementation foundation | Fresh RGBDS scaffold recommended | See [survey](SURVEY.md); no upstream adopted |
| Working platform | Windows / PowerShell | Observed workspace environment |

Decisions record: **D-001** selects Cobi (user-confirmed); **D-002** makes binary identity and explicit confidence mandatory (user requirement); **D-003** recommends RGBDS with opaque slices for unknown bytes (architecture proposal); **D-004** uses Markdown evidence and task records before introducing a database (architecture proposal). Revisit proposals if the baseline build exposes a better option; record the reason.

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

## Readability state (2026-10-12, after E-0308)

Binary identity passes: SHA-256 `8e38a742...766d4e`, 0 differing bytes (build/run449). Tests: 203 run, 3 skipped. The figures below are measured from the generated `src/`:

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
| Names given by reading (config/names.json): game meaning of routines and data | 5,443 | C1 or C2 as each entry's evidence states. Every routine or RAM name their notes mention (6,669, address forms read as their symbols) is connected to the code, with a negative control (E-0317). 10 readings executed in tools/sm83.py (E-0314, E-0315). A power-on run places the title, name-entry, field and opening-scene names in the game modes they claim, 413 named routines executed (E-0318). Every string the game looks up in an exploring run (13) sits at its String_/Message_ label, each talk routine entered looks up the message its name quotes, and screen pictures confirm the text reading, adding the glyphs 'v ($42) and ' ($95) (E-0319). Played in the emulator, story scenes run with the text their names quote, and a debug-menu battle runs 785 named routines in battle mode 4; the status page confirms the monster and battler record stat fields (C2) (E-0320) |

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

## What the survey changes

Existing work gives us useful entry points but has not established a locally reproducible Cobi build. The most promising starting paths are low-level routines in the DWM2 repository, monster tables and encounter data in community research, and a DWM1 example of incremental extraction. Exact revisions and inspected files are in [the survey](SURVEY.md); leads and experiments are in [the knowledge map](KNOWLEDGE_MAP.md).

## Dependencies and risks

| Dependency or risk | Effect | Resolution |
| --- | --- | --- |
| No reference ROM | Blocks target fingerprint and all binary verification | Next session, locate the user's local reference and establish a manifest |
| Historical assembler syntax and unpinned tooling | Upstream commands may not reproduce their results | Audit a pinned revision in scratch space; pin our tested RGBDS version |
| Mixed versions in community maps | A correct offset elsewhere may be wrong here | Target hash on every local claim; reject out-of-bounds offsets |
| Missing or unclear upstream reuse terms | Adoption decision remains open | Inspect relevant file notices before copying code |
| Plausible but wrong semantics | Byte identity can coexist with incorrect documentation | Confidence tags, disconfirming tests, and claim-level review |
| Incomplete web access | Some research is visible only through indexed text | Preserve access depth; retrieve a revision before promotion or import |

## Next session: a concrete first milestone

1. Establish the reference identity: edition, revision evidence, full size, SHA-256, header fields, and cartridge mapping. Preserve the original unchanged.
2. Initialize version control and artifact exclusions; choose and pin the build environment. These are planned actions, not work already done.
3. Implement the verifier with tests that prove it rejects corruption, missing inputs, truncation, and stale output.
4. Build a scaffold containing every original byte at its original location; obtain two clean matching builds.
5. Replace one small, proven code region with equivalent assembly, rebuild, and explain the instructions together.

Success is a recorded full-ROM match plus one understandable, evidenced change. Roadmap phases 0–1 contain the detailed gates. Choosing a local ROM and setting up tools belongs to that next implementation session, not this planning deliverable.
