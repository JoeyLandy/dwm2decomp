# Evidence standard and initial log

Historical baseline: **2026-09-12**, before local ROM inspection. Target-bound local findings begin at E-0006. External game-semantic leads below are **C1** until reproduced for this target.

## Two independent questions

**Binary verification:** does this exact source tree produce every byte of the identified reference? Record `PASS`, `FAIL`, or `UNVERIFIED`, with a report reference.

**Semantic confidence:** how well does the evidence establish the meaning of a routine, field, or algorithm? Use the scale below. A PASS build cannot promote semantic confidence. The scale is ordinal; it is not a probability estimate.

| Level | Meaning | Minimum evidence and naming rule |
| --- | --- | --- |
| C0 — unknown | No supported interpretation | Preserve bytes; use address-based identifiers |
| C1 — hypothesis | External assertion or plausible local interpretation | Cite provenance, alternatives, and the next test; qualify names as candidates |
| C2 — supported | Local evidence establishes the claim, with material gaps | Target-bound byte/range analysis and reproducible static reasoning or runtime observation; document what is still untested |
| C3 — verified within scope | The specific claim has been reproduced and reviewed | Local static analysis plus a reproducing experiment with relevant contrasting/boundary cases, or an exhaustive static proof where suitable; record review, scope, and remaining limits |

C3 is always bounded: proving a lookup for tested valid IDs does not prove every invalid-ID behavior. Split claims when confidence differs, such as a verified copy length and an unknown caller purpose. Downgrade claims when contradictory evidence appears. Keep old reasoning with `superseded` or `rejected` status.

Use `OBSERVATION` for directly inspected source/tool output, `HARDWARE` for cited platform behavior, and `DECISION` for project choices. These categories are not game-semantic confidence levels. An observation that a document contains an offset can be certain while its applicability to Cobi remains C1.

## Initial records

### E-0001 — Local starting state

- Kind: OBSERVATION; date: 2026-09-12.
- Scope: this workspace before documentation creation.
- Evidence: recursive hidden-file listing was empty; `git status --short` and `git remote -v` reported no Git repository.
- Conclusion: no local build or game-semantics result exists to inherit. This says nothing about files elsewhere on the computer.
- Binary verification: UNVERIFIED. Semantic confidence: not applicable.

### E-0002 — An upstream comparison is not our build certificate

- Kind: OBSERVATION; source: [NiyaDev/DWM2 build script at 055ecee](https://github.com/NiyaDev/DWM2/blob/055ecee52ce0c9be928817c03f7dc9d37c005f03/build.bat).
- Observation: the batch file assembles, links, edits the output header, and runs `fc /b` against `ROM\Cobi.gbc`. It has no explicit per-tool error checks or immutable reference hash.
- Conclusion: useful build archaeology; no locally demonstrated identity. Do not execute its mirror operation during survey.
- Binary verification: UNVERIFIED. Next action: isolated reproduction with pinned inputs and captured exit codes.

### E-0003 — Candidate core-monster table and an inconsistent range

- Kind: game-semantic lead; confidence: C1; target applicability: unverified Cobi revision.
- Source: [Core monster data](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/Core_monster_data), indexed page text inspected; live open failed.
- Claim: bank `0x35` contains a pointer lookup and 47-byte species records. The prose ends the bank at `0xD4FFF`; its detailed table ends at `0xD7FFF`.
- Local reasoning: a 16 KiB bank starting at `0xD4000` ends at exclusive `0xD8000`. This exposes a documentation inconsistency; it does not validate the proposed data contents.
- Next test: on the identified ROM, validate bounds, pointer interpretation, record size, holes/aliases, and the consumer before assigning field meanings.
- Binary verification: UNVERIFIED. Keep the conflicting source text in provenance; do not silently repair and promote it.

### E-0004 — Candidate battle HP watchpoint

- Kind: game-semantic lead; confidence: C1.
- Source: [Data Crystal RAM map, revision 59319](https://datacrystal.tcrf.net/w/index.php?title=Dragon_Warrior_Monsters_2/RAM_map&oldid=59319).
- Claim: CPU address `$D8BF`, width 2, represents the first player's monster's current HP. The entry does not establish our ROM revision, active WRAM bank, or lifetime.
- Next test: record CGB/DMG mode and WRAM bank; compare status, battle damage, healing, and leaving battle. Trace writers and distinguish a working copy from persistent monster data. A changing number alone is insufficient.
- Binary verification: UNVERIFIED.

### E-0005 — Randomizer RNG is not evidence of game RNG

- Kind: OBSERVATION with a rejected inference.
- Source: [TheCowness index.php](https://github.com/TheCowness/DWM2Randomizer/blob/05e559ba64ef9ffb3c6fac7f443dc7bb7445c5e8/Dragon%20Warrior%20Monsters%202%20Randomizer/index.php), `Random()`.
- Observation: the author identifies the randomizer's RNG as originating from Dragon Warrior III. Treat it as host-tool behavior. It supplies no evidence that Cobi uses that algorithm.
- Game RNG confidence: C0. Next test: trace in-game state changes and consumers after establishing the matching scaffold.


### E-0006 — Every non-empty switchable bank stores its own number at offset 0

- Kind: OBSERVATION; target `dwm2-cobi-us-rev0` (SHA-256 `8e38a742...766d4e`); date: 2026-10-09.
- Scope: file offsets `bank * 0x4000` for all 156 non-zero switchable banks (1..255; CPU `$4000`).
- Evidence: a script compared byte 0 of each non-zero bank with its bank index; 0 mismatches.
- Interpretation (C1): the `$0010` helper's `ld a, [$4000]` reads the current bank's number so it can restore it. Not confirmed at runtime.
- Binary verification: PASS (see report `build/run6/report.json`); semantic confidence is separate.

### E-0007 — Banked-call idiom and `rst $00` inline tables

- Kind: OBSERVATION of bank-0 bytes plus tracer behavior. Confidence **C1**.
- Claim: `ld hl, ADDR / ld b, BANK / rst $10` calls `ADDR` in `BANK` (1,806 sites; 2 unresolved); `rst $00` pops its return address as a word table and jumps through entry `A` (301 sites, all parsed).
- Support: bank-0 bytes `$0000-$0010`; the tracer's mined targets assembled and linked into a ROM that matches. A matching build does not prove this meaning.
- Next test: break at `$0010` in an emulator and compare hl/b with the mined target.

### E-0008 — The 66 untraced non-empty banks are overwhelmingly data

- **Corrected by E-0017/E-0018:** the guesses below about banks `$40`-`$42` ("compressed-graphics indexes") were wrong; `$40`-`$43` hold sound data. `$4A`-`$4D` are mostly 20x18 byte grids, not graphics.

- Kind: OBSERVATION (static statistics); confidence **C2** that they are not mainly code, **C0** for what each contains.
- Evidence: after tracing, 66 non-zero banks have no reachable code. Their absolute `jp`/`call` targets are in ROM range 20-45% of the time (known code banks 85-99%) with 3-6% invalid opcodes (known code ~0.2%); entropy 6.8-7.2 bits in many (compressed-looking). Heads inspected by hand: `$40-$42` start with `(word, pointer)` records whose pointers rise within the bank; `$56` with `bank, pointer` records; `$50`/`$65` hold values such as `ff 7f` (RGB555 white) consistent with palettes; `$67`/`$68`/`$72` start with pointer tables. These are candidate labels, not verified meanings.
- Alternatives not excluded: some of these banks may contain code reached only through mechanisms not yet mined.
- Limits: banks `$15` and `$1E` have 60% and 77% in-ROM targets and are mixed code/data.

### E-0009 — Heuristic code entries and pointer tables are plausibility, not execution

- Kind: DECISION plus OBSERVATION. Confidence **C0** for every heuristic entry.
- Rule: a candidate must pass a clean speculative trace (valid opcodes, no overlap with known bytes, in-ROM targets) and a mix check; candidates are the byte after a terminator/table, `$4001` of each bank, and targets of >= 4 consecutive in-ROM pointers. Data pointer tables are runs of >= 8 non-decreasing in-bank words (>= 4 distinct) at a fixed 2-6 byte stride whose targets are after the table.
- Result (2026-10-09): 2,157 heuristic code entries; 483 pointer tables / 17,599 pointers. Spot checks: bank `$10` entries are `ld hl,ADDR / ld b,BANK / rst $10 / ret` thunks; banks `$08` and `$88` tables have 974/1139 and 667/768 distinct sorted targets (not coincidence). Not exhaustively reviewed.
- Failure seen and fixed: two table targets fell inside another table's words, so a label was never emitted and the link failed; such tables are now dropped.
- Binary verification: PASS, two identical clean builds (`build/run6`, `build/run7`).


### E-0010 — Pointer loads in traced code name data starts (bank partly assumed)

- **Corrected by E-0012:** the counts and the "657 thunk operands" claim below were wrong; `rst $10` arguments were mis-modelled as same-bank data pointers.

- Kind: OBSERVATION of traced code plus a DECISION on bank resolution. Confidence **C1** for helper-paired loads, **C0** for same-bank loads.
- Rule: `ld hl|de|bc, $4000-$7FFF` becomes a labelled data start. Strong case (238 loads): argument of a call to a bank-0 routine that writes `$2100` within its first 10 instructions; the nearby `ld b, BANK` names the bank (235 of 238 point to a different bank than the caller, as expected for a cross-bank copy helper). Weak case (2,894 loads): bare load in a switchable bank, same bank assumed. Bank-0 loads without a helper call are skipped.
- Why same-bank is plausible but unproven: code in a switchable bank cannot switch away from itself, so cross-bank reads go through bank-0 helpers. It fails for any bank-switching routine this rule does not recognise. Each such label says `bank assumed`.
- Sanity example (not verified): bank `$01`, `ld de, Data_001_412F / ld hl, $9800 / ld bc, $1412 / call Func_000_15DE` is consistent with copying a 20x18 tilemap to VRAM.
- Binary verification: PASS, two identical clean builds (`build/run8`, `build/run9`). Labels and operand spelling changed; assembled values did not.
- Open: 452 loads land inside an already-decoded instruction or table word; these may indicate data decoded as code and are not yet examined.


### E-0011 — Data-pointer evidence vetoes some heuristic code

- **Corrected by E-0012:** the veto evidence included `rst $10` code arguments, so the 14% figure and the 3.3 KB removal below were overstated. Current figures are in E-0012.

- Kind: OBSERVATION plus DECISION. Confidence **C1**.
- Observation: before the veto, 292 of 2,101 heuristic code entries (14%) had at least one pointer load from directly traced code landing strictly inside one of their instructions (up to about 68 KB, overlap not deduplicated). Code is rarely entered mid-instruction, so this suggests data decoded as code.
- Rule: the pointer targets of directly traced code (2,236 targets, snapshotted after round 1 so bogus heuristic code cannot veto good code) reject any heuristic candidate that has one strictly inside an instruction. Same-bank is assumed. Effect: traced code 454,369 -> 451,068 bytes; heuristic entries 2,157 -> 2,058.
- Not resolved: directly traced code is also hit (for example `ld hl, $400F` in bank `$01` targets the high byte of `ld de, $1007` at `$400D`, although `Func_001_4001` is reached by a banked call). Either those loads are constants that look like pointers or the region mixes code and data. Nothing is vetoed for them.
- Binary verification: PASS, two identical clean builds (`build/run10`, `build/run11`).


### E-0012 — Defect: banked-call arguments were treated as same-bank data pointers

- Kind: OBSERVATION of a defect in this project's own tooling; found while investigating mid-instruction pointer loads. Confidence **C2** (reproduced by a test).
- What was wrong: `ld hl, ADDR` / `ld b, BANK` / `rst $10` loads ADDR as a **code** pointer into BANK. The data-reference pass treated `ld hl` as a same-bank data pointer. Effects in commits `e62176f` and `9dd0ee5`: (1) 1,634 of 1,734 banked-call operands were spelled with a label from the caller's bank (for example `ld hl, Func_001_4001` with `ld b, $08`); the assembled value was unchanged, so the build still matched, but the names were wrong. (2) The veto evidence contained those loads, so valid code was removed.
- Evidence: `ld hl, $402B / ld b, $08 / rst $10` at `01:42A1` is a call into bank `$08`, not a pointer into the middle of an instruction in bank `$01`.
- Fix: banked-call arguments are tracked separately (`Rom.banked_call_args`), excluded from the data-pointer evidence and from same-bank labelling, and rewritten to the code label in the named bank. `tests/test_generated_source.py` anchors on each `rst $10`, reads its own `ld hl`/`ld b`, and fails if a label's bank differs; it fails on the previously committed source (1,634 of 1,734) and passes now (0 of 3,763).
- Result: evidence targets 2,236 -> 1,443; traced code 451,068 -> 453,774 bytes; heuristic entries 2,058 -> 2,094; banked-call operands resolved to code labels 3,778; same-bank data loads 3,026 -> 1,843.
- Binary verification: PASS, two identical clean builds (`build/run12`, `build/run13`). Lesson: a matching build does not check names; a build pass was true before and after the defect.


### E-0013 — Pointer loads that land inside code: the same-bank guess is false for many; `$D7FE` selects a data bank

- Kind: OBSERVATION (static statistics) with an INFERENCE. Confidence **C1** for `$D7FE`, **C2** that the same-bank guess is unreliable in the listed banks.
- Observation: after E-0012, 395 of 2,741 non-banked-call pointer loads (14%) in switchable banks land strictly inside a decoded instruction, always on an operand byte; the per-bank median rate is 3%, but bank `$36` has 27/31, `$13` 115/217, `$04` 78/191, `$E0` 58/189. Bank `$01` shows it concretely: `ld de, $4A80` and `$4A90` target operand bytes of a genuine VRAM copy loop at `$4A7F`.
- Inference: those loads point at data in another bank. In code-dense banks a same-bank pointer would rarely land in code, so the guess fails there. Same-bank labels are withheld in banks `04 07 0F 13 1E 36 73 85 A1 E0` (>= 5 hits and >= 10% of loads).
- **Upgraded by E-0014:** the reader of `$D7FE` was found and the mechanism is established by static reading.
- Bank variable: for pairs `ld a, N` / `ld [$Dxxx], a` / `ld hl|de|bc, $4000-$7FFF` (within 8 instructions), pairing the pointer with bank N lands inside decoded code for 6% of 49 `$D7FE` pairs versus 81% under the same-bank guess. No other WRAM variable met the threshold (`$D7FB` 41% vs 75%). 34 labels now name data via `$D7FE`, 23 in bank `$10`; the sampled data (`$FF`-terminated records) is consistent with command/script streams, not verified.
- Alternatives: `$D7FE` might hold a bank for something other than ROM reads; the correlation does not show the access path. Other bank selectors may exist below the 20-pair threshold.
- Binary verification: PASS, two identical clean builds (`build/run14`, `build/run15`).


### E-0014 — How `$D7FE` is read: `Func_000_0B6C` fetches a word from ROM bank `[$D7FE]`

- Kind: OBSERVATION (static reading of traced code, target `dwm2-cobi-us-rev0`); confidence **C2** for the mechanism, not runtime-confirmed.
- Reader: `Func_000_0B6C` (bank 0, `$0B6C`) saves the caller's bank from `$4000`, writes `ld a,[$D7FE]` to the bank register `$2100`, reads `B = [HL]`, `C = [HL+1]` (HL unchanged), and restores the caller's bank. It has 30 call sites (banks `01 0D 10 15 1B 1D 1E 24 E2 F2`). It is the only reader of `$D7FE` that reaches the bank register.
- The 14 other reads of `$D7FE` do not read through it: 11 save it before a temporary override (`push af` ... restored by `pop af` / `ld [$D7FE], a`), 2 copy it to `$D067` (4 later writes restore it from there), 1 compares it. Of 89 writes, 74 store an immediate.
- Worked example: `Func_001_5BAD` (`01:5BAD`) saves `$D7FE`, sets it to `$08`, loads `hl = $4032`, forms `$4032 + 2*index`, and calls `$0B6C`. Bank `$08` at `$4032` holds 22 sorted bank-window pointers (`4044 4242 4258 4458 ...`), as a word-table read implies. This agrees with E-0013's statistical finding.
- Alternatives and gaps: indexed access through a base pointer (for example `ld hl, $D7F1`, loaded 24 times) could reach `$D7FE` and was not traced; code in untraced or mixed banks and RAM-resident code could also read it. The table at bank `$08:$4032` points into itself at its start (first pointer `$4044` is inside the table), which my pointer-table rule excludes ("targets lie after the table"), so its first words were raw `db` (fixed in E-0015).
- Source: the routines `$0000`, `$0010`, `$0B18`, `$0B2B`, `$0B46`, `$0B6C` now carry `config/annotations.json` notes in `src/` (`tests/test_generated_source.py` checks they are emitted).
- Binary verification: PASS, two identical clean builds (`build/run16`, `build/run17`).


### E-0015 — Pointer tables may point into themselves (multi-level indexes)

- Kind: DECISION plus OBSERVATION. Confidence **C1** (structure only).
- Defect: the table rule required every target to lie after the end of the table, so a multi-level index whose first words point into the table itself was rejected as a whole and only a later fragment survived. Example: bank `$08` at `$4032` held 6 raw bytes where the first of 22 pointers (`$4044`) lies inside the table.
- Rule now: a chain of >= 8 non-decreasing in-window words (>= 4 distinct, stride 2-6, targets in untraced bytes) is a table if no target precedes the table's own start. Pointing into the table is allowed.
- Review: 49 accepted tables are self-pointing (median 112 entries); typically 1-3 entries point inside and the rest point outward to many distinct targets (bank `$0B` `$4016`: 403 entries, 332 distinct). Least certain: bank `$38`'s sparse stride-3 table whose first entries repeat `$4001`.
- Effect: tables 483 -> 480 (sub-chains merged into their parents), pointers 17,604 -> 17,618, dropped-for-label-conflict 3 -> 4. Bank `$08`'s index is now `dw Data_008_4044` ... and shows the two-level structure: nine first-level pointers, each leading to a sub-table of string-looking pointers.
- Tests: `tests/test_structure_data.py` (7 synthetic cases); the self-pointing case fails on the previous rule.
- Binary verification: PASS, two identical clean builds (`build/run18`, `build/run19`).


### E-0016 — The asset decompressor (`Func_000_0C69` / `0CF5`), cross-checked on an emulator

- Kind: OBSERVATION (static reading plus dynamic cross-check); target `dwm2-cobi-us-rev0`. Confidence **C2** for the algorithm; **C0** for what any given asset contains.
- How found: static function-signature scoring failed (it surfaced palette, cursor and sound code: `Func_000_33E8` is the sound engine, bank in `$FFDD`). A small emulator (`tools/sm83.py`) logged which instructions write bulk data into VRAM; the writers clustered at `$0C7A`, `$0CDE`, `$0D19`, `$0D8C`, inside `Func_000_0C69` (RAM destination) and `Func_000_0CF5` (VRAM, with STAT waits), both using the header reader `Func_000_0DA8`.
- Format (from the instructions): `u16 size`, `u8 marker`; non-marker bytes are literals; the marker introduces `lo, b2`: length `(b2 & 15) + 4` (when that is `$13`, one more byte gives `byte + $13`), offset `((b2 >> 4) << 8) | lo` from the start of the output; a source at or past the output end moves back `$1000` and reads 0 if that falls before the start (a zero-prefilled 4 KiB window). `tools/lzss_gfx.py` implements it.
- Cross-check: with hooks on both entry points, every decompress call in a 100,000,000-instruction run with varied button presses (141 calls, 31 distinct assets, 52,944 output bytes) left memory equal to `tools/lzss_gfx.py`'s output, byte for byte, including 220 extended lengths, 112 window wraps and 1,726 zero fills. 17 of the 31 assets are multiples of 16 bytes (tile data); sizes 360 and 1024 match 20x18 and 32x32 tilemaps. Golden digests: `tests/golden_gfx_assets.json`.
- Limits: the emulator is our own implementation, written for this and unverified against hardware or another emulator; it ran roughly 100 M instructions with scripted input and visited few screens, so the 31 assets are a small sample of the ROM. The agreement does show that the static reading and the emulated CPU model are consistent on this code path. Assets that need other modes were not exercised. Encoder behavior (needed to recompress identically) is not recovered.
- Tests: `tests/test_lzss_gfx.py` (8 synthetic branch cases plus the real-asset digests), `tests/test_sm83.py` (12 hand-computed instruction cases).
- Binary verification: PASS, two identical clean builds (`build/run20`, `build/run21`); this entry adds tools, tests and annotations only.


### E-0017 — Most "opaque data" is compressed assets; most of those are 20x18 byte grids

- Kind: OBSERVATION (static, using the E-0016 decompressor); target `dwm2-cobi-us-rev0`. Confidence **C1** for "this target is a stream of that format", **C0** for what an asset means.
- Method: for each monotone pointer table (E-0009, E-0015) with >= 8 distinct targets, every target is run through `tools/lzss_gfx.py`. A target is a stream when it decodes without reading unwritten output, yields 1..$4000 bytes and stays inside its bank. A table is an asset index when >= 60% of its targets parse. Random data fails both: in the accepted tables, 1,577 of 2,294 streams end exactly where the next target begins.
- Result: 116 index tables, 2,137 distinct streams in 37 banks (most in `$0E`, `$4D`, `$4C`, `$4A`, `$59`, `$5A`); 304,034 compressed bytes expand to 725,839; extraction reproduces every one. All are annotated in `src/` (`; LZSS-compressed asset: C bytes expand to S`); `tests/test_generated_source.py` re-decompresses each from the ROM.
- Contents (no meaning claimed): 1,637 of the 2,137 decompress to exactly 360 bytes = 20x18, one screen's worth of cells. Their values are small (`00`-`04` dominate, maximum `$FD`), so they look like grids of codes, not tile graphics. Only 55 assets are whole 16-byte tile multiples. One 360-byte example is a 20-byte stream expanding to a solid fill of `$03`.
- Correction to earlier guesses: banks `$4A`-`$4D` were described as probably compressed graphics (E-0008); they are mostly these 20x18 grids. Banks `$40`-`$43` (index of `(word, pointer)` records) contain no stream of this format; their blobs remain unidentified.
- Gaps: only pointer-table targets were tested; streams referenced from code, from tables the monotone rule misses, or inside code banks are not found. 1,577 exact-adjacent endings leave about 700 streams whose end does not meet the next target (padding or non-sequential order is not distinguished). The encoder is not recovered, so these bytes cannot yet be regenerated from decompressed source.
- Tools: `tools/disasm_all.py --export-streams build/streams.json`, then `tools/extract_assets.py` (writes under the git-ignored `build/assets/`).
- Binary verification: PASS, two identical clean builds (`build/run22`, `build/run23`).


### E-0018 — Banks `$40`-`$43` hold sound data; the sound-id table and record arrays

- Kind: OBSERVATION (static reading plus emulator cross-check); target `dwm2-cobi-us-rev0`. Confidence **C2** for the lookup structure, **C1** that the engine is the sound engine, **C0** for the meaning of the second record byte and of the track streams.
- Trail: an emulator log of ROM reads while banks `$40`-`$43` were mapped showed every bank-switch to them coming from `$3428` or `$336C` and every read from `$337F`-`$38DF`, all inside the sound engine. `Func_000_33E8` writes `$FF1A` (the wave channel's enable register), keeps channel state at `$DC00`/`$DDxx` and takes its bank from `$FFDD`.
- Structure (from `Func_000_3354`, "start sound A"): a 4-entry table at `$3E13` in bank 0, entries `(first sound id, record-array pointer, ROM bank)`, ends at a first byte of `$FF`. The entry whose range holds A gives the bank and array; the 4-byte record at `array + 4*(A - first id)` is copied into the channel slot at `$DC00 + record[0]` (record[1] to slot +2, the pointer to +3/+4, the bank to +5). Ids 0-27 -> bank `$40`, 28-48 -> `$41`, 49-167 -> `$42`, 168-222 -> `$43` (223 records). The table nominally allows ids up to 254; bank `$43`'s array ends at `$40DD`, after 55 records, and what follows is track data.
- Evidence: in all 223 records the slot offset is a multiple of `$20` below `$C0` and the pointer lies past the end of the array in the same bank. In a 60,000,000-instruction emulated run with varied input, 495 sound starts (13 distinct ids) read exactly the banks this table names, with zero mismatches. At boot the game starts ids 221 and 222, then 6-11 in order (six tracks), and later requests id 105 hundreds of times; these suggest a song and a short repeated sound but were not confirmed by sound output.
- Source: `config/tables.json` now describes the five tables, and `src/` emits them field by field (`dw SoundRecords_Bank40`, `db slot, byte ; id N`, `dw` to each track stream). `tests/test_tables.py` checks the layouts against the ROM.
- Gaps: track stream format and the engine's update loop are not decoded; the second record byte takes values 0-3 in bank `$40` but its meaning is unverified; whether ids are songs or effects is not established. The emulator has no audio, so nothing here was heard.
- Binary verification: PASS, two identical clean builds (`build/run25`, `build/run26`).


### E-0019 — The sound track stream format (events, header, commands, pitch)

- Kind: OBSERVATION (static reading of `Func_000_35CD` and its handlers, cross-checked on the emulator); target `dwm2-cobi-us-rev0`. Confidence **C2** for the grammar and the pitch formula, **C0** for any musical meaning. Command names in `tools/sound_tracks.py` describe the register or variable each command changes; none claims more.
- Format: a track starts at its record pointer. Its first 4 bytes are a header read by the channel-start code at `$3554`: byte 0 low nibble -> `$FFDF`, byte 1 -> duty bits of `$FFDE` (wave channel: `$FFE6`), byte 2 swapped -> `$FFE0` (initial volume nibble), byte 3 -> `$FFE2`; playback begins at event 2. After that the track is 2-byte events; the engine keeps a position counted in events in `$FFD8/$FFD9` and fetches base + 2*position. First byte: `00-9F` note (high nibble octave, low nibble semitone, `0C-0F` = no pitch; operand duration), `A0-AF` settings, `B0` jump to a label (operand `F?`), `B1-BF` repeat n more times from a label, `C0-CF`, `D0-DF`, `E0-EF` settings, `FD` defines a label (16 per channel, 3 bytes each, at `$DCC0 + channel*12 + id*3`), `FF` ends the channel (its operand byte may be absent), `AC` calls a section (the next event is a byte offset from the track start) and `AD` returns; `A4`, `AB`, `F0-FC`, `FE` are skipped by the engine.
- Pitch: frequency register value = `$0800 - (period[semitone] >> octave)`, periods from `$3B5C` (or `$3B74` when `$FFDE` bit 4 is set); the noise channel uses a table at `$38A0`.
- Evidence, static: 214 of 214 tracks between two record pointers decode in alignment through to the next pointer (27,639 events; 15 end in a lone `FF`); only `A4` occurs among the engine-skipped commands (6 times).
- Evidence, runtime (`tools/validate_sound_tracks.py`, 240,000,000 emulated instructions with varied input): 5,154 of 5,154 event fetches at base + 2*(position-1); 4,000 successor checks with no mismatch (580 restarts at event 2 counted separately); 1,928 of 1,928 note frequencies equal the formula. Executed commands: notes, `A0 A1 A2 A3 A5 AF`, `B0 B1 B2`, `C0 C1 C2 CA CB CC`, `FD`, `FF`. Commands never executed in that run (`A6-A9`, `AA`, `AC`, `AD`, `AE`, `B3` and up, `D*`, `E*`) rest on static reading only.
- Observations that fix earlier impressions: only 42% of 15,494 note durations are multiples of 6, so there is no format-wide grid; common durations are 6, 12, 2, 4, 1, 8, 5, 24, 16. Command frequency: `A0` 6,978, `C1` 865, `A2` 760, `A1` 685, `A3` 625; `FD` and `B1-BF` each occur 319 times.
- Source: 214 tracks are emitted as events in `src/` (a header line, then `db b0, b1 ; mnemonic`), 27,639 events; the last track of each bank has no known end and stays raw data. Tests: `tests/test_sound_tracks.py` (13), `tests/test_tables.py`.
- Gaps: command semantics beyond the register names are not decoded; the update/tick routine that consumes durations and drives envelopes and vibrato is not decoded; whether a track is music or an effect is not established; the A9 jump-table data and the AC target sections are shown as raw events.
- Binary verification: PASS, two identical clean builds (`build/run28`, `build/run29`).


### E-0020 — Symbolic operands: hardware names (HARDWARE) and RAM names (address names unless evidenced)

- Kind: HARDWARE (register names and addresses are Pan Docs / hardware.inc facts) plus DECISION (naming policy). Target `dwm2-cobi-us-rev0`.
- What changed: instruction operands no longer repeat addresses. Memory operands and 16-bit pointer immediates name the I/O register (`ldh [rLCDC], a`), the MBC register the game writes (`ld [rROMB0], a`), VRAM region (`ld hl, vBGMap0 + $20`), and RAM (`ld a, [wC5FC]`, `ldh a, [hFFC6]`, SRAM `sA000`). `src/hardware.inc` and `src/ram.asm` (generated) define them; `src/main.asm` includes both first. 54,536 operands are symbolic and 1,750 RAM addresses are named.
- Naming policy: a RAM name of the form `wXXXX` / `hXXXX` / `sXXXX` is an ADDRESS name and claims no meaning (and WRAM bank 1-7 at `$D000-$DFFF` is not distinguished). Only the 17 addresses in `config/symbols.json` carry a meaning, each citing its evidence (for example `wDataBank` = `$D7FE`, E-0014; `wIsCGB` = `$C525`, set at `$0150` from the boot value A = `$11`; the sound variables from E-0018/E-0019; the decompressor variables from E-0016).
- MBC names are the addresses this game writes, because a register decodes a whole range and the assembled bytes must not change: `rRAMG` = `$0100` and `rRAMG2` = `$1FFF` (both RAM-enable range), `rROMB0` = `$2100`, `rROMB1` = `$3100`, `rRAMB` = `$4100`. Counts in the generated source: `$4100` 520, `$0100` 339, `$1FFF` 315, `$2100` 75, `$3100` 1; the heavy use of the RAM registers suggests save-RAM code, not examined.
- By-product: a few operands remain numeric because their address is not hardware (`ld [$F800], sp` in bank `$3E`, `ld [$FA0A], sp` in `$85`, `ldh [$FF08], a` in `$92`, an unassigned I/O address). They sit in heuristic-discovered code and are probably data decoded as code; not yet examined.
- Tests: `tests/test_generated_source.py` asserts that no instruction uses a raw address of a named register, the MBC, VRAM, SRAM, WRAM or HRAM, and that `main.asm` includes the two symbol files; both fail on the previous source.
- Binary verification: PASS, two identical clean builds (`build/run30`, `build/run31`): symbolic operands assemble to the same bytes.


### E-0021 — Far calls written as macros

- Kind: DECISION over the observation in E-0007 (`ld hl, ADDR` / `ld b, BANK` / `rst $10` calls ADDR in BANK; C2 static reading, 1,806 sites). Target `dwm2-cobi-us-rev0`.
- Change: when the label operand lives in the bank the `ld b` names, the three instructions are written `farcall LABEL` (or `farcall_b LABEL` when the ROM loads `b` first). `src/macros.inc` expands them to the same instructions with `BANK(LABEL)`, so the bytes are unchanged. 3,775 sites use the macros; 41 `rst $10` remain explicit (arguments not adjacent, or a numeric target).
- Why two macros: the ROM contains both load orders (3,751 hl-first, 24 b-first), and a single macro would reorder bytes.
- Tests: `tests/test_generated_source.py` requires the macros to be used, audits the remaining explicit setups, and requires `main.asm` to include `macros.inc`.
- Binary verification: PASS, two identical clean builds (`build/run32`, `build/run33`).


### E-0022 — Routine names from behaviour (first batch of 37), and a correction

- Kind: OBSERVATION (complete static reading of each routine's instructions; the sound and decompressor routines also have the E-0014/E-0016/E-0018/E-0019 emulator evidence). Target `dwm2-cobi-us-rev0`. Confidence **C2-C3** for the described behaviour; **no claim** about game purpose.
- Naming rule: a name describes what the routine provably does (`FillBytes`, `CopyBytes`, `Multiply8`, `DivideHLByA`, `HLToDecimalDigits`, `NextRandomSeed` = seed * 5 + 11, `TestFlagBit`/`SetFlagBit` on the bit array at `wCBD7`, `SRAMRecordAddress` for $A5-byte records, `WaitForVRAMAccess`, `WriteVRAMByte`, ...). Purpose-based names (for example "story flag") would need more evidence and are not used. Each entry in `config/names.json` records inputs and outputs; the address name stays as an alias label, so `Func_000_0949` still resolves.
- Reach: the 37 names cover the heavily shared library; for example `TestFlagBit` has 864 call sites, `StoreWC60B` 403, `AddAx9ToHL` 295, `WaitForVRAMAccess` 252.
- Notes checked against the instructions during review, three corrected before commit: `AddAx9ToHL` multiplies in 8 bits and wraps; `Multiply8` clobbers A, B and C; `FillTilesFromRequest` waits per byte, not per row.
- Correction to E-0020: the pointer-immediate rule had named `$FF9C` and `$FFF6` (-100 and -10, added to HL in `HLToDecimalDigits`) as HRAM variables. A 16-bit immediate of `$FF00` or more in BC/DE that feeds `add hl, <reg>` now stays numeric (47 BC/DE HRAM immediates were examined; the constants are `$FF9C` and `$FFF6`).
- Tests: `tests/test_generated_source.py` checks that every name is a label followed by its address alias, that callers use the new name, and the corrected constant rule.
- Binary verification: PASS, two identical clean builds (`build/run35`, `build/run36`).


### E-0023 — Cross-reference headers on every routine

- Kind: OBSERVATION (static facts derived from the traced code); target `dwm2decomp` build `dwm2-cobi-us-rev0`. Confidence **C3** within the stated scope: counts are exact for the code the tracer decoded.
- What each routine's header now states: how many call sites reach it and from how many routines (with up to four names), or "no direct call (reached through a table, a jump or a vector)"; and the RAM and hardware symbols it reads and writes (`ld a, [sym]` / `ld [sym], a`) and the RAM it takes a pointer to (`ld hl, sym`), following the routine's own jumps and branches but never into its callees.
- Scope and limits: call sites are `call`/`call cc` and the far calls the tracer mined (3,711 routines, 21,750 sites); indirect transfers (`jp hl`, the `rst $00` tables, far pointers read from data) are not counted, so "no direct call" does not mean unreachable. RAM accesses through a pointer register (`[hl]`) are not attributed to a variable.
- Also named in this step: 15 more routines in six groups of copies (the same helper is duplicated in each bank that needs it, so a body match names every copy; copies carry a `_Bnn` suffix): the request-block setters around `wC919`-`wC926`, `SetBit2AtHL`, `CarryUnlessWDA63SlotEmpty`, `ResetWDA6E` (52 names in total). Names state what the instructions do, never a guessed purpose.
- Tests: for every named routine the header's call count equals the number of `call`/`farcall` lines in the source (checked for all 52); no RAM list names a register operand.
- Binary verification: PASS, two identical clean builds (`build/run37`, `build/run38`).


### E-0024 — The text encoding, and prose rendered as strings

- Kind: OBSERVATION (decoded passages read as ordinary sentences); target `dwm2-cobi-us-rev0`. Confidence **C2** for the letter, digit, space and listed punctuation values; **C0** for what the other codes between words do.
- How found: searching the ROM for monster names under a constant letter offset produced hits for all-caps words (offset -29) and for lowercase words (offset -87), which showed the two cases are 26 apart, not 32. Decoding around the hits, with the case assignment that makes sentences read correctly, gives: `$00-$09` digits, `$0A-$23` `A`-`Z`, `$24-$3D` `a`-`z`, `$90` space, `$B5` `.`, `$AB` `,`, `$99` `!`, `$98` `?`, `$9C` `-`, and single contraction glyphs `$3E` `'s`, `$3F` `'m`, `$40` `'r`, `$41` `'t`, `$43` `'l` (each confirmed in context, for example "Dragon's", "I'm", "They're", "shouldn't", "you'll"). `$42` is probably another contraction but is kept raw.
- Control and glyph codes: `$EA`-`$EF`, `$F0`-`$F2`, `$F7`, `$F9`, `$FA`, `$A3`, `$A4`, `$95`, `$45` occur between words, e.g. `$F7` after sentence ends, `$EF $EE` between lines, `$F9` followed by a digit inside sentences. Their meaning is NOT established, so they stay as `$XX` operands.
- Detection (`tools/gb_text.py`): a 24-byte window is prose when its average character score is at least 0.72 and it holds at least two spaces; runs grow over text-like bytes, are trimmed to letters or punctuation, must be at least 24 bytes and at least 6% spaces. On the whole ROM this finds 2,531 runs, 331,955 bytes (7.9%) in 39 banks, concentrated in `$28`-`$2F`, `$7C`, `$80`-`$83`, `$89`, `$96`-`$99`. Bytes already owned by code, pointer words, tables, tracks and compressed streams are masked first.
- Source: prose is emitted as `db "..."` strings through `src/charmap.inc` (4,617 blocks); 0 round-trip mismatches over every detected run, and the build is byte-identical. `--no-text` keeps prose as `INCBIN`. Bank `$08`'s text turns out to be developer debug-menu strings.
- Repository note: rendering text embeds the game's dialogue in the committed source (the opaque regions were `INCBIN` references before). The project README defines the product as readable assembly and data, so this is in scope, but `--no-text` restores the previous behaviour if the text should stay out of the repository.
- Limits: detection is heuristic (prose-like, not a parse of message boundaries), so some data between runs may be text that is missed, and a few false runs may exist; neither can change bytes. Text that uses a different character table (one debug string shows `$A3` as a separator) is only partly mapped.
- Tests: `tests/test_text.py` (13): charmap uniqueness, render/parse round trip on random bytes, detection on synthetic prose, random bytes, space-free letter data and short fragments, the title text in the ROM, and the generated source.
- Binary verification: PASS, two identical clean builds (`build/run40`, `build/run41`).


### E-0025 — Streams from decompress call sites; a pairing defect and a vacuous-test defect, both fixed

- Kind: OBSERVATION plus two defects found in this project's own tooling. Target `dwm2-cobi-us-rev0`.
- Discovery: calls to `DecompressToRAM`, `DecompressToRAMLocked` and `DecompressToVRAM` (160 sites) set `de` = stream and `b` = bank. 130 sites use literals; they name 80 distinct streams, **all 80 decode** (E-0016 format, no unwritten reads), and 75 were not found through pointer tables. With them: 2,212 streams (330,676 compressed bytes -> 773,679), of which 110 are whole 16-byte tile multiples (55 before). The other 30 call sites read their arguments from descriptor tables at run time and are not resolved. The literal `ld de` operands now name their stream label.
- Defect 1 (pairing): the backward scan that pairs `ld b` with `ld de/hl/bc` ran past an earlier `call`, so one setup's pointer could be re-paired with the next setup's bank. The previous commit had **21 of 235** pointer labels in a call setup naming a bank that disagreed with the call's `ld b` (for example `Data_00C_5C14` with `ld b, $F1`). The scans now stop at a call, return, jump or `rst` (`SETUP_BARRIER`). After the fix: 0 of 585 disagree.
- Defect 2 (vacuous tests): a patch script turned `` into a literal backspace byte in `tests/test_generated_source.py`. In the banked-call barrier regex this meant no `call` ever ended a setup window; in the register-name check it meant that test could never fail (it had passed since E-0023 without checking anything). Both regexes are repaired, no control bytes remain in `tests/` or `tools/` (checked), and both tests now fail on bad input (the audit fails on the previous commit's source).
- Tests: `BankSwitchingCallSites` audits every call to a bank-taking helper (`CopyFromBank*`, `OrFromBank*`, `DecompressTo*`, `ReadByteInBank`), using the nearest write to `b` and stopping at barriers; `DecompressCallSites` checks that literal `ld de` arguments name a stream label.
- Lesson recorded: a green test is not evidence until it has been seen to fail on bad input; both defects were found by writing the stricter audit and watching it fail on the existing source.
- Binary verification: PASS, two identical clean builds (`build/run43`, `build/run44`).


### E-0026 — Bank `$08` is the game's string database (named from its contents)

- Kind: OBSERVATION (decoded text, E-0024, plus static reading of the accessor routines); target `dwm2-cobi-us-rev0`. Confidence **C2** for what each table holds (the strings say so), **C2** for the accessor behaviour; **C0** for how the game uses the strings beyond that.
- Structure: a pointer table at `$4032` has 9 first-level entries; each points at a table of string pointers; strings end with `$F0`. Entry counts and contents, read from the decoded text: `$4044` 255 debug-menu and system strings ("DEBUG MODE", "? EDIT ?", "MONSTER BGSD CHARA"); `$4242` 11 monster families (Slime, Dragon, Beast, Bird, Plant, ...); `$4258` 256 monster names ("DrakSlime", "SpotSlime", ... entry 0 empty, 212 distinct); `$4458` 128 further monster names ("Mudron", "NiteWhip", ...); `$4558` 223 skill names ("Blaze", "Blazemore", "Blazemost", "Firebal", ...); `$4716` 112 item names ("Herb", "LoveWater", "WorldDew", "Potion", ...); `$47F6` 112 item descriptions ("Restores HP of one monster", ...); `$48D6` 27 personality names ("Hotblood", "Eager", "Smug", "Earnest", "Pushy", ...); `$490C` 15 item-menu messages ("No items", "Toss this away?", ...).
- Accessors: five routines in banks `$01`, `$0D`, `$15`, `$24`, `$F2` (copies of the same helper in several register encodings; four more copies sit inside larger routines) select bank `$08` through `wDataBank`, read first-level entry 2 (`$4032 + 4` = the monster-name table), index it by `HL`, and copy 16 bytes of the string to `wC8CF`. They are named `CopyMonsterNameToBuffer_Bxx`.
- Source: the nine tables and the index carry names (`StringDatabase`, `StringTable_MonsterNames`, ...) with their address names kept as aliases; the index now reads `dw StringTable_System / dw StringTable_MonsterFamilies / dw StringTable_MonsterNames ...`.
- Limits: the names say what the strings are, not how the game selects them; the second monster-name table's relation to the first (for example monster numbers above 255) is not established; category 0 appears to be developer text; whether entry numbers equal the game's monster numbers is assumed from the accessor taking the number in `HL`, not verified at runtime.
- Binary verification: PASS, two identical clean builds (`build/run45`, `build/run46`).

### E-0027 — Idiom macros, library routine families, and the string-display entry points

- Kind: OBSERVATION (static reading, plus execution on our own emulator `tools/sm83.py`, unchecked against hardware); target `dwm2-cobi-us-rev0`. Confidence **C1** for every behaviour note (each routine was read in full and the arithmetic and table routines were run against the reference ROM); **C0** for any game purpose.
- Idiom macros: `add_a_to_hl` (1,744 sites) and `deref_hl` (219 sites) replace multi-instruction sequences with macros that expand to the same instructions. `add_a_to_hl` folds only when its branch label has no other reference, so nothing can jump into the idiom.
- Families: the ROM repeats a small library of leaf routines in many banks. `config/name_families.json` names one canonical routine; the generator names every function entry whose bytes are identical (no call, jump or restart inside, so identical bytes behave identically). 26 families, for example `AddDoubleAToHL` in 11 banks, `BGMapAddressAtScroll` (two encodings), `StoreBAtWordTableEntry`, `CopyTileBytesToVRAM`, `BuildOamFromSpriteTable` (five copies).
- Execution checks (`tests/test_routine_behaviour.py`): multiply A by BC into E:H:L (`Func_000_16AA`), divide B by A, divide E:H:L by A (`Func_000_16E2`), clamped add and subtract on a byte, the BG-map address and word-table routines. They pass on random inputs.
- String display: `LookupString` (two-level table lookup), `BeginStringDisplay`, `CopyStringToBuffer` and `RunStringDisplayToEnd` are named from reading; 38 per-bank stubs that load their own string table are named `BeginStringDisplay_BankBB`, `CopyStringToBuffer_BankBB`, `ShowString_BankBB`. RAM: `wStringCategory`, `wStringIndex`, `wStringBank`, `hScrollX`, `hScrollY`, `hOamNextEntry`.
- Limits: names describe behaviour, not game purpose. `BeginStringDisplay` is named because the state it sets is later read by the routine that writes characters to VRAM; the full state machine at `$2620`/`$2637` is not decoded. The two `hScroll` names rest on the copies into `rSCX`/`rSCY`; whether other code treats them differently is not established.
- Binary verification: PASS, identical SHA-256 `8e38a742...766d4e`; 102 tests pass.

### E-0028 — Sprite slots, BG-map shadow, glyph copy, bank-6 table and number formatting

- Kind: OBSERVATION (static reading; arithmetic and decimal routines also executed on our own emulator, unchecked against hardware); target `dwm2-cobi-us-rev0`. Confidence **C1** for behaviour notes, **C0** for game purpose.
- Named from reading: the sprite-slot system (`DrawSpriteSlots` reads 8-byte slots at `wSpriteSlots` and far-calls a renderer per slot type; it fills the inputs of `BuildOamFromSpriteTable`, so `hSpriteOriginX/Y`, `hSpriteSetIndex`, `hSpriteSubIndex`, `hSpriteTileOffset`, `hSpriteAttrXor` take their names from that use); the screen tile buffer at `$C198` (rows of 32 bytes for the copy routines, 20 in field mode) `wScreenTileBuffer` (`CopyTileBufferToBGMap`, `CopyRectToBGMap`, `CopyBlockToTileBuffer`, `ClearScreenTileBuffer`); `CopyGlyphTilesToVRAM` (font tiles at bank `$1F`, `$4010 + 16 * character`); number formatting (`HLToDecimalDigits`, `WriteDecimalDigitTiles`, `Number24ToPackedBCD`); the 24-bit multiply and divide helpers.
- Bank 6 is a table of $36-byte rows of 27 signed 16-bit words (values such as 30, 25, 20, 15, 5, 0, -5); `ReadBank6TableWord` reads one, and the two most-called routines in bank `$E2` (`AccumulateBank6WordToDA6E`/`...ToDA70`, 304 and 223 call sites) add it to one of two 16-bit words by sign. What the table means is not established.
- Limits: `StartPaletteFade` is named from palette-buffer writes (`$7FFF` white or `$0000` black fills) and is an inference. Tile `$C3` as blank and `$E0` + digit as digits come from the routines that write them. Bank-local game-logic routines in bank 5 were read but not named: their purpose needs more evidence than the code gives.
- Result: 47.6% of call sites reach a named routine. Binary verification: PASS, identical SHA-256; 104 tests pass.

### E-0029 — Frame loop, game-mode dispatch, sound queue and joypad, from reading and from running the game

- Kind: OBSERVATION (static reading plus execution on our own emulator `tools/sm83.py`, with `tools/render_frame.py` drawing frames; neither is checked against hardware); target `dwm2-cobi-us-rev0`. Confidence **C1**. Reproduce with `python -I tools/explore.py play`, `... modes` and `... scene BUTTON...` (screenshots go to `build/shots/`, which is ignored; the ROM is read from `local/roms/`).
- Frame structure (reading): the VBlank vector at `$0040` jumps to `VBlankHandler`, which does all per-frame work: OAM DMA, palette uploads, scroll and LCDC restore, joypad poll, `SoundTick`, random seed, `ProcessSoundQueue`, `GameFrameUpdate`, the string-display step and the 16-bit frame counter. The main loop at `$02D2` runs `RunGameModeInit`, then halts until `wModeChangeRequest` is set.
- Game modes (reading): `wGameMode` ($C5DB) indexes two 9-entry tables, one of start-up routines and one of per-frame routines (banks `$01`, `$02`, `$03`, none for mode 3, `$31`, `$07`, `$24`, `$A0`, `$F2`). Execution: setting `wGameMode` to 0-8 and `wModeChangeRequest` at the title screen showed, for mode 0 the text "DEBUG MODE SELECT / 1:GOTO PROGRAM", mode 1 a water map with the player sprite, mode 2 a monster panel, mode 4 sparkles on black, mode 5 the title and sparkles, mode 6 "YOU WIN!" with a result window, mode 7 two monster panels, mode 8 "...receive's egg." Forcing a mode skips its normal set-up, so screens are incomplete; the names stay index-based (`GameMode0_Init` ... `GameMode8_Update`) and the screens are notes only.
- Title and name entry: the title logo appears with the boot state; pressing Start twice and A twice reached an "Enter Name" screen with default name "Cobi" and a character grid (`Func_014_*` and `Func_07F_*` run there).
- Sound: `SoundTick` (`$33E8`) is the sound engine's per-frame routine: 561,213 of 1.5 million instructions at the title screen, looping the 6 channel slots. `QueueMusic`/`QueueSoundEffect` (403 call sites) store a request that `ProcessSoundQueue` starts on the next frame.
- Super Game Boy: `SendSGBPacketSet`, `DetectSGB` and the tile-transfer routines match the documented SGB packet protocol (reset pulse, 128 bits as `$10`/`$20` writes, stop bit); `wSGBActive` gates them.
- Limits: the renderer draws once per frame and ignores raster effects; mode screens depend on leftover state; `wC58A` (which skips joypad and string work when non-zero) is not named. Binary verification: PASS, identical SHA-256; 109 tests pass.

### E-0030 — Field mode (mode 1): player facing and position, play time, sprite drawing

- Kind: OBSERVATION (static reading plus execution on `tools/sm83.py`; not checked against hardware); target `dwm2-cobi-us-rev0`. Confidence **C1**. Executable check: `DWM2_SLOW=1 python -I -m unittest discover -s tests -p test_dynamic.py` (about a minute).
- Reach: from the title, Start, Start, A, A reaches name entry; Start then eleven A presses reach `wGameMode` = 1 on a ship deck (the opening of the game, screenshot via `tools/explore.py play`).
- Observed in mode 1: pressing left, right, up and down sets `$FF98` to 3, 1, 2 and 0; up lowers `$FF91` by 16 (64 to 48), left lowers `$FF8E` by 16 (80 to 64), so `hPlayerFacing`, `hPlayerX` and `hPlayerY` are the names (steps of 16; the names claim the axes and facing, not the coordinate system). `CheckInteractionInFront` adds or subtracts 16 on the same axes by facing for an A press.
- Play time: `$C82D`-`$C831` count frames, seconds, minutes and a 16-bit hour value; the seconds byte advanced during emulation, so `IncrementPlayTime` and `wPlay*` are named from reading and execution.
- Sprites: `DrawFieldSprites` reads entries at `wCBCF` and calls `DrawMetaSprite`, which converts 16-bit world positions to screen positions with the scroll-offset words and writes OAM entries.
- Limits: `wModeState` ($C5DC) is a per-mode sub-state; mode 1 uses its low nibble as an index into nine handlers whose purposes are not yet named. The subroutines under each state (map loading, collision tests at `Func_002_59CD`/`5A51`/`5AB6`, the warp table at `Data_002_5B89`) are read but not named. Binary verification: PASS, identical SHA-256; 112 tests (3 slow).

### E-0031 — The personality index, the bank-6 table's columns, and a save record

- Kind: OBSERVATION (reading plus execution on `tools/sm83.py`); target `dwm2-cobi-us-rev0`. Confidence **C1** for the index computation (tested), **C2** that it is the monster personality index, because the status screen passes it as an index into string category 7, the 27 personality names (`StringTable_PersonalityNames`: Hotblood ... Lazy).
- `PersonalityIndexOfRecord` grades three bytes of a save record (offsets `$6F`, `$72`, `$70`) into 0, 1 or 2 (`$C0` and `$40` thresholds) and returns 9 * g1 + 3 * g2 + g3 (0-26); `tests/test_routine_behaviour.py` runs it on the reference ROM for 15 byte triples and all 27 combinations. `PersonalityIndexOfSlot` (7 identical copies) does the same for eight battle or party slots from three RAM arrays at `wSlotPersonalityHi/Mid/Lo`.
- Consequence: the bank-6 table read by `ReadBank6TableWord` has 27 word columns, one per personality, indexed by `wPersonalityIndex` (set from `PersonalityIndexOfSlot` in banks `$30` and `$E0`); its `$36`-byte rows are selected by a row number the caller passes in BC (for example `$0E` in the bank-`$E2` wrappers). What a row means is not established; the two accumulators `wDA6E`/`wDA70` receive its signed values.
- Save record (observed after the opening of a new game, record 0 of `sA000`, `$A5` bytes): byte 0 = 2, bytes 1-10 = a name in the game's encoding ending in `$F0` ("Slash"), bytes 15-20 = another name ("CobiA", the name typed at name entry). `CopyRecordNameToWC8CF` copies a 10-byte name from a record offset. Other offsets the code reads: 0, 1, 11, 13, 14, 52, 85, 86, 91, 93, 95, 97, 99, 101, ... 114, 164; their meaning is not established.
- Debug mode (mode 0) contains a string viewer over the per-bank text tables (`wC0A0` selects among 34 banks: `$08`, `$09`, `$28`-`$2E`, `$7C`, `$80`, `$82`, ...), which identifies those banks as text banks.
- Monster names in the string database run in 10 families of 35 slots (ids start at 0 for the first slime; unused slots read "?"); a search of the ROM for a per-monster family byte at that stride found nothing, so the monster stat table is still unlocated.
- Binary verification: PASS, identical SHA-256; 114 tests.

### E-0032 / E-0033 — The skill table and the monster table, found through the debug mode

- Kind: OBSERVATION (reading plus execution on `tools/sm83.py`; screens drawn by `tools/render_frame.py`); target `dwm2-cobi-us-rev0`. Confidence **C1**.
- How they were found: the debug menu (mode 0, forced from the title; item order by pressing Down) has a skill viewer (wCFEC id, `wC5F8` index wrapping at `$AF`) and a monster viewer (index wrapping at `$02AB`). Reading the viewers' loaders gave the tables.
- Skill table (E-0032): `LoadSkillRecord` copies 17 bytes from bank `$1A`, `$40D4` + 17 * id. 175 records, now emitted as `SkillTable` with one `db` run per record. The viewer showed "Attack" for id 0, "Blaze" for id 1 and "ZoneOut" for id 174, with attribute strings (category `$12` family such as "Infer", `$13` "Type", `$14` "Batt", `$10` "Charge", `$11` target "1 enemy"/"All enem"). The first byte rises across spell families (Blaze 2, Blazemore 4, Blazemost 10).
- Monster table (E-0033): `LoadMonsterRecord` copies 26 bytes from bank `$34`, `$4075` + 26 * id; ids at or above `$250` use bank `$A2`. 592 records (`MonsterTable`; the last non-zero record is 591). Record 1 holds 25, 0, 10, 7, 8, 7, `$C8 $C8 $64 $C8`, the same values the opening monster's save record shows for its HP, MP, ATK, DEF, AGL, INT and next four bytes. Four bytes per record look like skill ids (`$FF` = none; all below 175 except one). Monster names come from string bank `$88`: category = id high byte, index = id low byte (`DebugShowMonsterRecord`).
- Not established: the first word, the word at bytes 6-7 (up to `$E8EE`), bytes 8-9 and the last four bytes of a monster record; the numbers in a skill record; the mapping of table ids to names beyond the viewer. Two real defects found on the way: the table emitter dropped the second byte of two-byte `db` fields (fixed; the identity gate caught it), and `wCFEC` is a scratch buffer shared by both loaders, so it is named `wRecordBuffer`, not a skill id.
- Binary verification: PASS, identical SHA-256; 116 tests.

### E-0034 — The item table, the bag, and save-record offsets

- Kind: OBSERVATION (reading plus execution); target `dwm2-cobi-us-rev0`. Confidence **C1**.
- `LoadItemRecord` (bank `$16`) copies 13 bytes from `$4CC2` + 13 * `wItemId` to `wItemRecord`; `RunItemEffect` jumps through one handler per id. 99 records follow before another table begins (`ItemTable`). `wInventory` (`$C61D`) is a 24-slot bag of item ids; at the start of a new game it is empty, matching the item menu's "No items" (screen read on the emulator). The first amounts are 10, 50, 500, 200, 2000 for ids 1-5 (consistent with prices, not confirmed). Item names are in the string database; the id-to-name offset is not confirmed.
- Save record (`$A5` bytes, `sA000 + 165 * record`), observed offsets for the opening monster: `$5B` and `$5D` are words of 25 (the herb handler refuses use when they are equal, which fits current and maximum HP, order not proven); `$63`, `$65`, `$67`, `$69` are 10, 7, 8, 7 and equal the monster table's ATK, DEF, AGL, INT words for monster 1; `$6F`-`$72` are `$C8 $C8 $64 $C8` and equal monster-table bytes 22-25, with `$6F`, `$72` and `$70` the three personality axes (E-0031). Not established: offsets `$55` (76 uses), `$56`, `$57`, `$5F`, `$61`, `$0B`-`$0E` and the rest.
- Binary verification: PASS, identical SHA-256; 116 tests.

### E-0035 — More compressed streams: observed at run time and found in back-to-back runs

- Kind: OBSERVATION (decoder plus emulator); target `dwm2-cobi-us-rev0`. Confidence **C1**.
- Two new sources feed the stream finder of `tools/disasm_all.py`, which still verifies each stream with `tools/lzss_gfx.py` before use. (1) `tools/collect_streams.py` hooks `DecompressReadHeader` while scripted scenes run (title, name entry, opening field, each game mode forced, each debug-menu item) and records 32 streams, 10 of them new (banks `$24`, `$57`, `$74`, `$7D`, `$7E`, `$90`). (2) `tools/find_stream_chains.py` scans every bank for runs of six or more streams where each starts where the previous ends (the shape of an asset pack), skipping tiny or one-byte-run outputs and anything inside structured tables or decoded code; it found 87 runs holding 1,749 streams, for example 80 in bank `$7D`, 76 in `$20`, 75 in `$21`, 52 in `$74`.
- Why six: runs of 3-4 also occur in table data (the monster table in bank `$34` gave several); the shortest run in the file has six.
- Result: 3,427 streams (was 2,212) covering 658,314 compressed bytes (was 330,676) and expanding to 1,260,441 bytes. The 1.19 MB of `INCBIN` data is now mostly accounted for by streams (658 KB) plus unidentified tables and uncompressed data.
- Look: `tools/tile_sheet.py` draws a stream as 2bpp tiles; the first streams of bank `$7D` (256 and 224 bytes) show small face-like icons.
- Limits: a run can still contain a false stream at its edges; a pack whose streams are not adjacent (the index-table packs in banks `$46`, `$57`) is found only by the older sources; what each pack is (monster pictures, maps, scenery) is not established.
- Binary verification: PASS, identical SHA-256; 118 tests.

### E-0036 — Maps: the map number, the map table, and map-loading streams

- Kind: OBSERVATION (execution on `tools/sm83.py`, reading); target `dwm2-cobi-us-rev0`. Confidence **C1**; **C2** that `hMapId` is the map number.
- `hMapId` (`$FF90`) is 29 on the opening ship deck and 56 when the first scene is built. The system strings from index 10 are 245 map names ("MonsterFarm", "GreatLog", ... "Deck" at index 39 = 10 + 29); the unused maps read "NO" at indices 40, 41 and 49, which are exactly map numbers 30, 31 and 39, the entries whose `MapTable` words are not valid pointers.
- `MapTable` (bank `$11`, `$44B8`, 256 words) is indexed by map number; its records start at `$46B8`. Map 56's record is the one whose first far pointer (`57:6E96`, address then bank byte) the game decompressed to `$9000` on the emulator while `hMapId` was 56; later far pointers in the same record name the streams loaded to `$C198` (screen tile ids, `57:71C6`) and `$D000` (attributes in WRAM bank 2, `57:77E5`). Records are 48 or 66 bytes; their fields are not yet laid out. The streams in bank `$57` sit in 3-byte far-pointer tables at `$7166` and `$7196`.
- `MapWarpTable` (bank `$11`, `$67A6`, 256 words) gives a list of warps per map; `CheckWarpAtPlayer` matches facing and position and starts a map change.
- Table emission fix: a structured table now gets a data label at its start so that a data slice begins there (the map table lay inside a larger slice).
- A single scene's map is one screen of 360 tile ids (20 x 18) loaded into `wScreenTileBuffer`; larger maps and how a map is scrolled are not yet understood.
- Binary verification: PASS, identical SHA-256; 118 tests.

### E-0037 — Map records, screens and the blocking-tile limit

- Kind: OBSERVATION (reading plus execution); target `dwm2-cobi-us-rev0`. Confidence **C1**.
- `LoadMapScreen` (`$19A9`) builds one screen of a map: `MapRecordPointer` gives the record for `hMapId`; the record's word at offset `$10` points at a RAM flag byte (for map 56 `$CC39`) whose highest set bit selects one of up to eight 6-byte variants (a far pointer to a grid of stream pointers, plus a far pointer to the attribute grid); the grid is indexed by `hMapScreenY * wMapWidthScreens + hMapScreenX`; the selected stream goes to `wScreenTileBuffer` and the attribute stream to `wD000` in WRAM bank 2 (observed on the emulator: `57:71C6` to `$C198` and `57:77E5` to `$D000` for map 56, `90:76E0` and `90:781B` for map 29). Then the map's tile-replacement list (`Func_084_43B8`, 8-byte entries keyed by map and screen and a story flag) runs.
- Map record header (observed for map 29 at `11:4E0E` and map 56 at `11:52F4`): bytes 0-2 far pointer to the tileset stream (decompressed to `$9000`), bytes 3-5 a second far pointer, byte 6 width in screens (`wMapWidthScreens`, 2 for the ship deck, 4 for map 56), byte 7 height, byte 8 `wMaxBlockingTile` (`$37` and `$3F`), byte 9 `wC193`, byte 10 `wC90D` (`$0E` for map 29), then the flag-byte pointer at `$10`. On map 29 the registers after loading read width 2, height 1, blocking tile 55, `wC90D` 14, player screen (1, 0).
- `TileBlockedAtPixel` compares tile ids with `wMaxBlockingTile`, so the first N tile ids of a tileset are the blocking ones.
- Not established: bytes 9-15 and the variant selection flags (which story flags `wCC39` and its siblings are); the tile-replacement list's entries; the special-map table at bank `$61`, `$60D8`.
- Binary verification: PASS, identical SHA-256; 118 tests.

### E-0038 — The event-script engine

- Kind: OBSERVATION (reading plus execution: a hook logged the opening cutscene's opcodes); target `dwm2-cobi-us-rev0`. Confidence **C1**.
- `StartEventScript` (28 call sites) stores a script address in `wScriptPointer`; each frame `RunEventScriptFrame` runs `FetchScriptCommand` (reads the next opcode, 13 opcodes in a jump table, `$FF` ends the script) and `ExecuteScriptCommand` (runs one frame of the current command through `ScriptCommandHandlers`, 248 words at bank `$10`, `$46F5`, of which 193 are code pointers and 55 are zero). The table is now emitted as a structured table whose code pointers seed the tracer (new `code` flag in `config/tables.json`), so about 190 handlers are now traced code.
- Observed during the opening: opcode 3 with a word of 30 (a 30-frame wait is likely), opcode 0 (starts a message; the string display begins right after it), opcodes 1, 5, 10 and 11 with small parameters; opcode 7 jumps to a word address, opcode 6 skips forward when `wC552` is zero. Which command types do what beyond type 1 (a message box drawn by `Jump_010_4A1B`) is not yet named.
- Defect fixed on the way: the table emitter now drops an inline `dw` the tracer had put at the start of a table (the first six entries) instead of failing.
- Binary verification: PASS, identical SHA-256; 118 tests.

### E-0039 — The script opcode table

- Kind: OBSERVATION (reading); target `dwm2-cobi-us-rev0`. Confidence **C1**.
- `FetchScriptCommand` ends in an inline `rst $00` table of 249 words (`ScriptOpcodeHandlers`, bank `$10`, `$4056`), indexed by the script byte. Opcodes 0-12 have handlers of their own (message, waits, jumps, a conditional skip, ...); 123 further opcodes share `ScriptFetchGeneric` and 30 share `ScriptFetchGeneric2`, which make the opcode byte the command type; the command then reads its own arguments from the script pointer. So a script is a stream of command numbers (1-248) with command-specific arguments, run by `ExecuteScriptCommand` through `ScriptCommandHandlers`.
- The command handlers live in banks `$5F` (types `$02`-`$0E`), `$73` (`$11`-`$67` and `$C0`-`$CC`), `$0F`, `$85`, `$12` (`$80`-`$A1`), `$1C` (`$E0`-`$E6`), `$1E`, `$14` (`$EB`, `$EC`: the name-entry screen), `$15`, `$0D` (`$EF`-`$F4`), `$0C`, `$24`.
- Table emission now drops a guessed address constant (a C0 `ld hl` pointer label) that falls inside a table the configuration defines; two such constants (`$408D`, `$4097`, loaded by command `$1D`) sit in this range and look like numbers, not addresses.
- Binary verification: PASS, identical SHA-256; 118 tests.

### E-0040 — Jump-table targets named by their table

- Kind: DECISION (naming by structure); no new behavioural claim. Every `rst $00` inline table the tracer found (the game's dispatch idiom: the byte after `rst $00` starts a list of code addresses indexed by A) gives its plain `Jump_` targets the name `Parent_CaseNN`, where Parent is the routine holding the table (its name or its address name) and NN is the entry's index; a second table in the same routine uses `Parent_TableK_CaseNN`. 4,337 labels were renamed (for example `RunGameModeInit_Case00` ... `Case08`). The address names stay as aliases.
- Why: the names say which dispatch a block belongs to and which value selects it, without claiming what it does.
- Binary verification: PASS, identical SHA-256; 119 tests.

### E-0041 — Monster pictures, sprites, palettes and the debug screens

- Kind: OBSERVATION (reading plus execution; pictures drawn with `tools/tile_sheet.py`); target `dwm2-cobi-us-rev0`. Confidence **C1**; **C2** for the picture number (the drawn pictures match the names).
- Four tables indexed by a picture or monster number: `MonsterPictureTable` (bank `$38`, `$4001`, 383 far pointers to 576-byte streams: 36 tiles drawn 6 x 6), `MonsterAttributeMapTable` (`$447E`, far pointers to raw 6 x 6 attribute bytes), `MonsterSpriteTable` (bank `$04`, `$4EAA`, 384 far pointers to 32- or 256-byte small-sprite streams) and `MonsterPaletteTable` (bank `$7B`, `$4209`, 16 bytes per entry). Loaders: `LoadMonsterPicture`, `LoadMonsterPictureAttributes`. The streams live in banks `$74`-`$7A` and others (the packs found in E-0035 are monster pictures).
- The first word of a `MonsterTable` record is the picture number: records 1, 2, 3 ("Slime", "SpotSlime", "CactiBall", names from string bank `$88`) point at pictures 10, 2 and 145, which are a slime, another slime and a spiky ball.
- Debug mode screens, by `wModeState` (set with `wGameMode` 0 and `wModeChangeRequest`): 0-1 menu, 2 map editor ("? EDIT ?", world and map number and position), 3 automap, 4 monster picture viewer, 5 sound test, 6 battle setup ("? BATTLE ?": number of foes, three monsters, skill, levels), 7 results display, 8 staff roll ("SCENARIO & GAME DESIGNERS YUJI HORII ..."), 9 skill viewer, 10 monster record viewer, 11 message test.
- Table emission: labels guessed by earlier heuristics (pointer loads, monotone-table targets, streams) that fall inside a configured table are dropped.
- Binary verification: PASS, identical SHA-256; 119 tests.

### E-0042 — Mode 4 is the battle

- Kind: OBSERVATION (execution on `tools/sm83.py`, screens drawn by `tools/render_frame.py`); target `dwm2-cobi-us-rev0`. Confidence **C2** that mode 4 is the battle.
- Reach: force `wGameMode` 0 and `wModeState` 6 (the debug "? BATTLE ?" setup), set `wModeChangeRequest`, press Start: `wGameMode` becomes 4 and a fight runs: panels for three party monsters ("Porpo", "Baron", "Iwan" with HP, MP and level), a Slime, FIGHT / ITEM / PLAN / FLEE, "Monster was defeated!", an experience message, "Allow Slime to join you?", "But there is no more room!", "Release a monster to make room?". The earlier "sparkles" screen was this mode forced without set-up.
- Battle RAM (observed): eight-slot word arrays at `$D8BF` (current HP), `$D8CF` (maximum HP), `$D8DF` (MP), `$D8EF` (maximum MP); party in slots 0-2, a foe in slot 4. After the first attack the foe's current HP fell from 20 to 0 while its maximum stayed 25. `wBattlePhase` (`$CFC8`) was 2 and `wBattleStep` (`$CFC9`) went 1, 2, 4, 5 in the first turn.
- Per frame, `GameMode4_Update` runs `IncrementPlayTime_Bank31` and the phase machine at `Func_031_40CC` (a copy of the play-time routine sits in this bank). `wC58A`, which gates the serial routines, is the link-play flag, not a battle flag.
- Not established: the battle's phases and steps beyond the first turn, the other stat arrays (`$D8FF` onward look like four more stats), the foe slots, and the damage and AI code (the AI scores of bank `$E2` use `wDA6E`/`wDA70`).
- Binary verification: PASS, identical SHA-256; 119 tests.

### E-0043 — Battle: where HP changes, base stats, and the layered state machines

- Kind: OBSERVATION (a write hook on the HP arrays during a debug battle, then reading); target `dwm2decomp`'s `dwm2-cobi-us-rev0`. Confidence **C1**; **C2** for the two HP writers.
- The only writers of the HP arrays in the first turn were `ApplyDamageToTarget` (bank `$32`, `$59DF`: subtracts the 16-bit damage in `wBattleDamageLo/Hi` from `wBattleHP[wBattleTarget]`, clamping at zero) and `DefeatTarget` (`$5B12`: sets the slot's HP to 0, marks `wBattleSlotOut` and clears the 9-byte status record). `RecomputeTargetMaxHPAndMP` (`$5C3F`) refreshes the maximum HP and MP.
- Bank `$3B` holds six base-stat accessors, `GetBaseHP`, `GetBaseMP`, `GetBaseATK`, `GetBaseDEF`, `GetBaseAGL`, `GetBaseINT` (the order is the game's usual one, assumed): for slots 3 and 7 they read the monster record (HP is the word at record byte 10, matching `MonsterTable`), otherwise the word at offsets `$1D`, `$21`, `$23`, `$25`, `$27`, `$29` of a 78-byte battler record at `$D0D5` (found with `Func_000_3F32`).
- State variables: `wBattlePhase` ($CFC8), `wBattleStep` ($CFC9), `wBattleSubPhase` ($CFCA), `wBattleResolveStep` ($CFCB, 16 cases in `RunBattleResolveStep`), `wBattleSubStep` ($CFCC), `wBattleSubStep2` ($CFCD): each indexes a jump table, nested six deep. `wBattleActor` and `wBattleTarget` ($D8A4, $D8A5) are the acting and acted-on slots; `wBattleStatus` ($D80C) is a 9-byte record per slot.
- Not established: what each resolve step does beyond the damage and defeat steps, how a skill's SkillTable record turns into damage, the AI that chooses actions.
- Binary verification: PASS, identical SHA-256; 119 tests.

### E-0044 — The shape of a battle, from the state variables (correction to E-0042/E-0043)

- Kind: OBSERVATION (a poll of `wCFC8`-`wCFCB` at every VBlank during a debug battle, plus the text the battle began to display); confidence **C1**.
- Correction: `wBattlePhase` ($CFC8) is 1 during the fight and 2 afterwards; the earlier note that it was 2 "during the fight" came from sampling after the foe had already fallen.
- Phase 1: step 1 sets the battle up (`wBattleSubPhase` runs 0-12); step 2 is command entry, a loop in which `wBattleSubPhase` alternates 1 and 2 once per party member; step 3 executes the chosen actions: `wBattleSubPhase` counts the actions (0, 1, 2, ...) and `wBattleResolveStep` runs through the 16 resolve cases for each (the sequence 0, 2, 5-8, 10-15 showed in the first action), with battle text shown at some steps (strings of bank `$2F`, category 1: indices 2, 53, 139 in the first round). Phase 2: steps 0-5 show a result message (bank `$2F`, category 0, index 134), then category 5 and the recruit questions.
- Binary verification: PASS, identical SHA-256; 122 tests.

### E-0045 — Battle messages and the damage and defeat resolve steps

- Kind: OBSERVATION (execution plus decoded text; `tools/string_bank.py` prints a bank's strings); confidence **C1**.
- Battle text is in string bank `$2F` (table `$4016`). Category 1 holds per-action lines such as "<actor> attacked!", "<actor> cast <skill>!", "<name> took <n> damage!" (index 53), "<name> was defeated!" (139); category 0 holds results ("Monster was defeated!" at 134). In the first fight the resolve steps showed these in order: step 3 an action line (index 2), step 10 ("took damage", index 53), step 12 `ApplyDamageToTarget`, step 13 ("defeated", 139).
- `ResolveStepDamageMessage` (step `$0A`), `ResolveStepApplyDamage` (`$0C`), `ResolveStepDefeat` (`$0D`, running `RunDefeatSequence`) are named. `wBattleActionId` (`$D8A6`) is the action being resolved.
- Not established: the other 13 resolve steps, how a skill's record chooses its message and effect, the special cases keyed by action id.
- Binary verification: PASS, identical SHA-256; 122 tests.

### E-0046 — Mode 2 is the pause menu; the opening monster is a Slime with the monster-table stats

- Kind: OBSERVATION (execution, forcing `wGameMode` 2 with `wModeState` 0-4 in the opening field); confidence **C2**.
- State 0 shows the PLAN list (Keys, Plan, Text Speed, Re-Order, Info, Journal) and an INFO panel for the first monster: a slime sprite, Lv 1, ATK 10, DEF 7, AGL 8, INT 7, WLD 0, HP 25/25, MP 0/0. These are the numbers of `MonsterTable` record 1 ("Slime"), which settles the HP, MP, ATK, DEF, AGL, INT order of that table's six words. State 1 is the ITEM list ("No items"), state 2 the SKILLS list ("No skills"). The `GameMode2_Update` cases are named `PauseMenu_*`.
- Not established: what WLD (wildness) reads, how the menu is opened in normal play (it did not open on the ship), and the sub-screens behind each PLAN entry.
- Binary verification: PASS, identical SHA-256; 122 tests.

### E-0047 — Single-caller helpers named `Parent_SubNN`

- Kind: DECISION (naming by call graph); no behavioural claim. A routine whose every call site lies in one named routine, which is not reached through a jump table, is renamed `Parent_SubNN` (NN counts that parent's helpers in address order); three passes name helpers of helpers (for example `StepFade_Sub01_Sub02`). The name states where the routine is used and nothing about what it does. 333 routines; the address names stay as aliases.
- Binary verification: PASS, identical SHA-256; 122 tests.

### E-0048 — Skill byte 0 is read as an MP cost in the battle

- Kind: OBSERVATION with a game-semantic reading (C2 on our emulator; not checked on hardware). Claim: byte 0 of a skill's 17-byte record (SkillTable, bank $1A) is compared with the acting battler's MP word (wD8DF + 2 * slot) in two places, with different results at equality.
- Evidence, all by the emulator harness in `tests/test_routine_behaviour.py` (class `BattleSkillCost`):
  - `FilterSkillListByMP` (`30:5129`) keeps skill numbers in wC0A0 only when the cost is strictly below the MP. Checked for MP 0, 1, 2, 3, 5, 10, 40 against the ROM costs of skills 1-8 (costs 2, 4, 10, 4, 6, 10, 5, 8).
  - `CheckSkillMPCost` (`32:51F9`) refuses a skill action with D = 1 when MP - cost is negative, and allows cost = MP. Four runs: cost 2 / MP 10, cost 10 / MP 10, cost 6 / MP 4, cost 11 / MP 10. The routine does not store the difference.
- Consequence to check on the real game: a skill that costs exactly the actor's MP is dropped from the list built by `FilterSkillListByMP` but would pass `CheckSkillMPCost`. Whether the list reaches the screen, and whether the screen hides that skill at equality, is not established (Func_030_502D builds the list; not traced to the menu).
- Method: `build/exp_skill_mp.py`, `build/exp_affordable.py` (scratch) and the test class above. Routine calls use bank $30 or $32 (hex, as in the file names).
- Binary verification: PASS, identical SHA-256; see the commit for the test count.

### E-0049 — The battle action gates return a refusal code in D

- Kind: OBSERVATION (C2 on our emulator; not checked on hardware) plus a naming decision. `CheckSkillMPCost` (`32:51F9`) returns carry set when the acting battler's action may proceed, and clear with D set to the reason when it may not. The gate routines it calls are selected by bits 6, 4 and 5 of wCFF3.
- Refusal codes observed (D; routine):
  - 1: MP minus cost is negative (`CheckSkillMPCost`; four runs in E-0048).
  - 2: the action matches the queued action wQueuedActionId (wDAAC) through `QueuedActionMatches` (`00:3F47`). Executed: action $34 with queued $AD and cost within MP gives D = 2.
  - 3: bit 0 of the actor's status byte 1 (wD80D + 9 * actor) (`CheckActorStatusAndFoeTargets`, `32:529E`). Executed.
  - 4: bit 3 of the side flag (wD80A for slots 0-3, wD80B for 4-7) (`32:529E`). Executed.
  - 5: bit 7 of status byte 1 (`CheckActorStatusBit7AndFoeBit6`, `32:5303`). Executed.
  - 6: bit 6 of status byte 1 (`CheckActorStatusBit6`, `32:534A`). Executed.
  - 7: when wDA53[actor] >= 2 and wCFF2 = $12, every present opposite-side slot fails its status-byte-2 test (`32:529E` and `32:5303`). Reading only.
- `QueuedActionMatches` is symmetric: it compares A with C = wDAAC for equality and for each of the five pairs in both directions. Executed for every pair.
- Status bytes are offsets of wBattleStatus (wD80C) within the 9-byte per-slot record: +0 wD80C, +1 wD80D, +2 wD80E, +3 wD80F.
- Not established: what each status bit means in the game (the names describe the tests only). Whether the screen shows a message per code. The meaning of the queued action.
- Method: `tests/test_routine_behaviour.py`, classes `BattleSkillCost` and `ActionGates` (routine calls with chosen registers and memory; bank $00 and $32 are hex).
- Binary verification: PASS, identical SHA-256; see the commit for the test count.

### E-0050 — Resolve steps $02, $03, $0B and $0F, and the action-91 predicate

- Kind: OBSERVATION (C2 on our emulator) and naming decisions. Names describe the tests and writes shown by the instructions; the game meaning of the actions and of the called routines (3A:4001, 3A:6EE5, 36:4FD1, 36:4A9D, 36:4B16) is not established.
- Named, with the evidence used:
  - `ResolveStepAdvanceSubPhase` (`36:490F`, step $0F): increments wBattleSubPhase, clears wBattleResolveStep. Executed.
  - `ActionIs91AndStatusBit6Set` (`36:433F`): Z set only when wBattleActionId = $91 and bit 6 of wD80F + 9 * actor is set. Executed for $91 with the bit set and clear, and for $90.
  - `ResolveStepCallEffect82` (`36:431F`, step $02), `ResolveStepFlagBit7Effect` (`36:4356`, step $03), `ResolveStepBranchOnAction` (`36:48DE`, step $0B). Reading only; the calls they make are not yet traced.
- Still unnamed in the resolve table after this entry: steps $00, $01, $04-$09 and $0E (`RunBattleResolveStep_Case0E` farcalls the bank-32 `Sub01`, not yet read). That is 9 of 16 still structural names; steps $02, $03, $0A, $0C, $0D, $0F and $0B are named.
- Method: `tests/test_routine_behaviour.py`, class `ResolveStepHelpers`.
- Binary verification: PASS, identical SHA-256; see the commit for the test count.

### E-0051 — Resolve step $0E dispatches to an action-specific effect routine

- Kind: OBSERVATION (reading only). `RunBattleResolveStep_Case0E` farcalls `32:5EAB`, which dispatches on wBattleSubStep (wCFCC) to ten cases. Case 0 branches on the action id: $15 and $20 to `32:5F20`, $3B to `32:5F3B`, $5F to `32:5F63`, $60 to `32:5FAE`, $61 to `32:5FF8`, $6D to `32:5F35`. Named `ResolveStep0EEffect`.
- Not yet read: the other action ids in case 0, cases 1-9, and the routines the branches reach. Step $0E is therefore only partly named.
- Binary verification: PASS, identical SHA-256; see the commit.

### E-0052 — Resolve step $05 is a chance roll for a status effect

- Kind: OBSERVATION (reading only; C1). Step $05 (`36:458E`, `ResolveStepChanceRoll`) runs for wCFF4 bits 3-4. The roll (`RollWC5E7BelowChance`, `36:4918`) compares wC5E7, set by a routine not yet read, with hFFC6. On success the step sets bit 7 of the actor's status byte 2 and shows message $9C or $9D; the roll's source and the meaning of wCFF4 are not established.
- Binary verification: PASS, identical SHA-256; see the commit.

### E-0053 — Resolve steps $00, $01, $06, $08, $09 and $0E named

- Kind: OBSERVATION (reading only; C1). Names describe the tests and the messages, sounds and routines each step calls. The routines called but not read (`RunBattleResolveStep_Case00_Sub01`, `RunBattleResolveStep_Table2_Case00_Sub01`-`Sub04`, `3A:4001`, `3A:5762`) keep their address names.
- `DispatchActionEffectTable` (`36:6717`) reads a table at `36:6726` indexed by wBattleActionId. The first 40 entries point at routines in bank $36 (`Func_036_6B75`-`6D87`); the rest of the table is unread.
- Binary verification: pending; see the commit.

### E-0054 — Resolve steps $04 and $07 named; every resolve step now has a behaviour name

- Kind: OBSERVATION (reading only; C1). `ResolveStepEffectChecks` (`36:438A`, step $04) and `ResolveStepComputeDamage` (`36:460B`, step $07) are named by their tests and writes. The routines they call that are not read (`RunBattleResolveStep_Case04_Sub02`, `_Sub03`, `RunBattleResolveStep_Case07_Sub01`, `_Sub02`, `Func_036_4930`'s callees, `Func_036_5009`, `Func_036_4FD1`) keep address or structural names. The meaning of the messages and the AGL bands is not established.
- After this entry, the 16 entries of the `RunBattleResolveStep` table carry behaviour names. Entries 0 to 9 and $0E are behaviour-named in names.json; $0A, $0B, $0C, $0D and $0F already were. The step $0E effect table (`ResolveStep0EEffect`) has only its first action ids read.
- Binary verification: pending; see the commit.

### E-0055 — Two helpers that set wBattleSubPhase and restart the resolve steps

- Kind: OBSERVATION (reading only; C1). `SetSubPhase2AndRestartResolve` (`36:4FD1`, 8 call sites) and `SetSubPhase3AndRestartResolve` (`36:5009`, 2 call sites) write wBattleSubPhase (2 and 3) and clear wBattleResolveStep. The meaning of sub-phases 2 and 3 is not established beyond E-0044; `Func_0A3_413F` (called for actions $D0-$E3) is not read.
- Binary verification: pending; see the commit.

### E-0056 — Func_03A_7193 is the battle text display (ShowBattleText)

- Kind: OBSERVATION (reading plus emulator; C2 on our emulator). `ShowBattleText` (`3A:7193`) has 66 call sites in 56 routines, the most of any unnamed battle routine. It takes the message index in D, optionally runs the per-index routine from a pointer table, then stores the index in wStringIndex and 1 in wStringCategory and farcalls `BeginStringDisplay_Bank2F`. The emulator test (`BattleText`) confirms the stored category and index for indices $05, $35 and $8B. The per-index routines are not read.
- `ShowBattleTextCategory0` (`3A:6EE5`, 22 call sites) is the category-0 twin of `ShowBattleText`. The emulator test (`BattleText`) checks its stored category.
- Consistent with E-0045, which found battle text in bank $2F, category 1.
- Binary verification: pending; see the commit.

### E-0057 — Effect selectors driven by wDAD2 and wDAD3

- Kind: OBSERVATION (reading only; C1). `SelectEffectByWDAD2Flags` (`3A:4001`, 15 call sites) and `SelectEffectByWDAD3Flags` (`3A:5762`, 15 call sites) test the bits of the effect-flag bytes that the resolve steps write (wDAD2 and wDAD3) and choose a display table indexed by the action id. The table contents and the effect routines they reach are not read; the names state only the bit tests and the table choices.
- Binary verification: pending; see the commit.

### E-0058 — CheckSlotStatusBlock

- Kind: OBSERVATION (full reading plus execution on our emulator; C2 for the emulator behaviour). `00:3E25` (33 call sites) returns carry set for slot 8 (out of range), for a slot whose wBattleSlotOut entry is non-zero, and for each of the masks status +0 & `$10`, +3 & `$01`, +5 & `$40`, +8 & `$08` set alone; carry is clear for a present slot with clear status. Test: `SlotStatusBlock` in `tests/test_routine_behaviour.py`. The full masks from reading are +0 & `$D0`, +3 & `$3F`, +5 & `$C0`, +8 bit 3; only one bit of each was executed. What the status bits mean is unknown, so the name says "block" without naming the statuses.
- Binary verification: pending; see the commit.

### E-0059 — Bank 0 helpers by fan-in (batch 1)

- Kind: OBSERVATION (full reading only; C1). Five high fan-in bank-0 routines, read instruction by instruction: `StepBGMapAddressBackOnScrollWrap` (`00:24F8`, 73 call sites), `CopyRectToBGMapWrapped` (`00:18A5`, 24), `CopyStringHLToDE` (`00:2E81`, 23), `LoadRecordListNameTiles` (`00:222B`, 22) and `WD0D5RecordFieldAddress` (`00:3F32`, 17); plus `ReadByteAtHLPlusA` (`32:57FD`, 18) and the RAM words wStringDestLo/Hi (`$C53D`/`$C53E`, read by CopyStringToBuffer). The notes state register effects only.
- Unknowns: why `00:24F8` steps back one row when a column wraps (the callers are not read); what the wC6FE record list is (three 5-tile slots suggest a party of three, not checked); what the `$4E`-byte records at wD0D5 hold and why index 3 maps to record 2. `LoadRecordListNameTiles` leaves SRAM enabled when the list is empty; whether any caller relies on that is not checked.
- Binary verification: pending; see the commit.

### E-0060 — Fan-in batch 2 (banks $03, $31, $39)

- Kind: OBSERVATION (full reading only; C1).
  - The seven bank-$39 stat getters (`39:71E5`–`39:7203`) share a tail (`add a, a / add_a_to_hl / deref_hl`) and have the same shape as the bank-$36 `GetBattle*` set. They get the same names with a `_Bank39` suffix; `GetBattleAGL_Bank39` has no bank-$36 counterpart named yet.
  - `LayoutTileBlocksForWD890Count` (`31:72CC`, 41 call sites) uses two pointer tables (`Data_031_7317`, `Data_031_731D`) of wC278 offsets. The centred layouts and the 1–3 count are read from the code; what wD890 counts (the number of enemies is plausible) is not checked.
  - `CopyRect32StrideToVRAM` (`31:753F`, 18) and `SetActorWDA1DFromHRAMChoice` (`39:6FE2`, 18) are register-level descriptions only.
  - `UpdateMenuCursor` (`03:4425`, 19) and the RAM names wMenuRowCount, wMenuPageCount, wMenuLastPageRows and wMenuPage come from this one routine. The joypad bit order (4 Right, 5 Left, 6 Up, 7 Down) is the standard Game Boy order. The two helpers it calls are taken to erase and draw the cursor from how they are used; they were not read.
- Binary verification: pending; see the commit.

### E-0061 — Battle target picker (bank $39) and batch 3

- Kind: OBSERVATION (full reading only; C1).
- `ChooseActionTarget` (`39:4001`) copies byte 0 of the actor's word in wBattleActionChoice (`$DA1C`) to wBattleActionId. It indexes `Data_039_41AC` by wDA53[actor] (4 bytes per mode: two table pointers), takes the second pointer for slots 4-7 when wC58A is 0 or 2, and calls the table entry for the action through `JumpToWordAtHL` (`00:000B`). Every entry read writes a slot number to byte 1 of the same word (wBattleTargetChoice, `$DA1D`).
- Target routines read:

  | Routine | Address |
  | --- | --- |
  | TargetSelf | `39:412B`, 334 table entries |
  | TargetFirstFoe | `39:4078` |
  | TargetFirstAlly | `39:40A2`, 97 entries |
  | TargetRandomFoe | `39:404B` |
  | TargetSavedSlotOrRandomFoe | `39:4055` |
  | TargetRandomAllySlot | `39:40C2` |
  | TargetOwnSideFirstSlot | `39:413C` |
  | TargetRandomOtherSlot | `39:414F` |
  | TargetFoeWeightedBySlotOrder | `39:6691`, 142 |

  `PickWeightedTargetCandidate` (`39:704E`) uses weights 128/85/43 of 256.
- The slot layout (three slots per side, 0-2 and 4-6, with 3 and 7 unused) is inferred from the three-slot loops and the exclusion of slots 3 and 7 in `TargetRandomOtherSlot`.
- Untraced table targets: `$409A` (bytes decode as `ld a, [wBattleActor] / and 4 / jp $417C`, a random present ally) and `$40E8` (in an `INCBIN`) are referenced by the table but not traced, so they are not named.
- Unknowns: what wDA53 (the mode) and wC58A select.
- Also read in this batch: `StepObjectTowardCoord` (`5F:6B54`, 145 call sites), `ScriptStartFadeAndAdvanceStep` (`5F:6C5A`, 51), `AddBToWordAtHLCapped` and `CompareHLWithDE` (`F0:7C64`, 66; `F0:7C81`). For StepObjectTowardCoord, the object-entry offsets agree with ScriptSlideObjectY's Y byte at wCB8B + 16n (E-0038).
- Binary verification: pending; see the commit.

### E-0062 — Screen-buffer draw copies, bank-$35 records, battler records

- Kind: OBSERVATION (full reading only; C1).
- **Screen-buffer draw copies.** Eight per-bank copies of one routine (`DrawScreenBufferRect_BankXX` in banks $0C, $0D, $14, $15, $1E, $F0 and $F1, plus `DrawScreenBufferRectNoOrigin_Bank24`) share one core. They draw a rectangle of wScreenTileBuffer, and on CGB its attributes from WRAM bank 2 `wD000`, through CopyRectToBGMapWrapped. They differ only in how they set wC554/wC555; each rule is in its note. The bodies were compared instruction by instruction after the same normalisation.
- **Copies not named.** Banks $1B and $1C (`Func_01B_6277`, `Func_01C_449F`) and `Func_024_4E57` share the opening but not the verified tail, so they are not named.
- **wC554/wC555.** This value is HL + $1C1, row 14 column 1 of the drawn area, and is probably where text is placed. That is a guess and not checked.
- **Bank-$35 records.** `LoadBank35Record` and its two prefix variants copy part or all of a 47-byte record, numbered by the 16-bit wD006/wD007, from the 384-entry table at `Data_035_403B`. The table ends exactly where the first record starts (`$403B + $300 = $433B`). What the records are is unknown. The debug results-display screen (species, gender) is among the callers, but that is not evidence of species data.
- **Script delta step.** `ScriptApplyStepDeltaAtDE` (`0F:7EE9`, 38 call sites) uses the same 32-step parameter count as ScriptSlideObjectY (E-0038).
- **Battler records (correction to E-0059).** GetBaseHP's note (E-0043) already says the `$4E`-byte records at wD0D5 belong to battle slots, and that slots 3 and 7 are handled separately. So `00:3F32`'s index-3 adjustment maps slots 4-6 to records 3-5. It is renamed `BattlerRecordFieldAddress`, and wD0D5 is named wBattlerRecords.
- Binary verification: pending; see the commit.

### E-0063 — Inventory, MP and SRAM helpers (batch 5)

- Kind: OBSERVATION (full reading only; C1).
- Routines read:
  - `ConsumeSelectedItemByChance` (`16:4C1D`, 33 call sites) and `CompactInventory` (`16:4C48`).
  - `ActorCanPayMPCost_Bank05` (`05:413F`, 35).
  - `ShowStringA10_Bank1B` (`1B:7439`, 32).
  - `SRAMRecordAddressOfWD7F1` (`1D:7B0F`, 27).
  - `SetWC924ClearWC926` (`12:6820`, 35).
- `ActorCanPayMPCost_Bank05` is a second routine that allows cost = MP. That puts `FilterSkillListByMP`'s strict cost < MP (E-0048) in the minority, which is still unexplained.
- The roll in `ConsumeSelectedItemByChance` is (wC5E8:wC5E7) mod 100, where wC5E8 is a 7-bit table index, so it is not exactly uniform.
- Unknowns:
  - which item uses consume this way;
  - what wD087 (the chance) and wD082 (the bag slot) are set from;
  - what wC924 and wC926 do.
- Binary verification: pending; see the commit.

### E-0064 — Damage divisors corrected; library families; stat getters in every battle bank

- Kind: OBSERVATION (reading; the damage correction is also executed on our emulator, C2).
- **Correction to ComputeBasicDamage (E-0043's note).** The helper it calls three times (`36:6510`) shifts HL right twice and then falls through `36:6518` (one shift) and `36:651C` (one shift). That is four shifts, a division by 16, not 4. Executed with actor ATK 1000:
  - BC = 0: damage stayed within 469–531 over 512 random states, i.e. 500 ± 31 ± 1. The old note predicted 250–750.
  - BC = 990: damage stayed within 0–62. The old note predicted 0–250.
  - Test: `DamageDivisors`. The corrected formula: with half = (ATK − BC) / 2, damage = RandomInRange(0, ATK/16) when ATK/16 ≥ half, else half ± half/16 ± 1.
- **ComputeAttackDamage.** `36:5013` (14 call sites) sets BC = target DEF / 2 before falling into ComputeBasicDamage.
- **Library families** added to `config/name_families.json`, each read once:
  - CopyBytesDEToHL (13 copies);
  - ActorOnLocalSide and TargetOnLocalSide (11 copies each);
  - CopyBBytesDEToHL, RotateDirectionAtDEEvery32, ReadTileBuffer2x2AtPixel and SetMenuRowsForPage (3 each).
  - The "local side" reading of the wC58A = 1 / wC57F bit 1 reversal is an inference.
- **Stat getters.** 18 more per-bank `GetBattle*` stubs (banks $05, $32, $3A, $3B, $A1, $A3, $E2). A script matched `ld hl, wBattleX / jr` to the shared tail `add a, a / add_a_to_hl / deref_hl / ret`, so they get `GetBattleX_BankBB`.
- Binary verification: pending; see the commit.

### E-0065 — Second family pass (two or more copies)

- Kind: OBSERVATION (full reading of one canonical copy each; C1).
- **Method.** A scan (`build/find_families.py`, not committed) grouped address-only leaf routines with no call, `jp` or `rst` by their normalised instructions. Thirteen groups were read and added to `config/name_families.json`, and the generator names each identical-byte copy.
- **Groups added:**
  - Screen and buffer: BGTileUnderPointIsHFFBA (5 copies), CopyRectToStride32, ReadScreenBufferRectHeader, CopyRecordRectToScreenBuffer.
  - Word and table helpers: ReadWordTableEntry, AddAToWordAtHL, StoreHFFC8WordAtHL, CountTableBytesAtOrBelowA.
  - Byte copy, fill and search: FillBBytesAtHL, FindByteAtHLInEightAtDE, CopyWD01ARecordToHL, CopyBytesWithChecksum.
  - Bit test: WDA77EntryHasBits2And3.
- **Names are register-level only.** None claims what the data is: the checksum's use (a save check is plausible) and the meaning of hFFBA, wD01A and wDA77 are unknown.
- Binary verification: pending; see the commit.

### E-0066 — Short high fan-in routines (batch 6)

- Kind: OBSERVATION (full reading only; C1).
- Ten routines read in full:
  - ShowStringIndexA_Bank37.
  - AnyFoeNotBlocked and FewerThanTwoFoesPresent: bank-$05 battle predicates that return C = $FF / $00, the same convention as ActorCanPayMPCost_Bank05.
  - CheckRecordFlag55Bit7 and its wD083 wrapper.
  - CopyRect32StrideToVRAM_Bank16 and CopyRectTo20ByteRowsJp_Bank24, which repeat the steps of already-named routines with different encodings.
  - The save and restore pair SaveScreenBufferToBGMap1 and RestoreScreenBufferFromBGMap1, which use the off-screen vBGMap1 as storage for 20 × 18 screen-buffer entries.
  - The EnableSRAMBank0 family.
- Unknowns: what record byte $55 bit 7 marks, and why only $168 of wScreenTileBuffer's $240 bytes are saved. The 20 × 18 visible area is the likely reason, but that is not checked.
- Binary verification: pending; see the commit.

### E-0067 — Families that call into bank 0

- Kind: OBSERVATION (full reading of one canonical copy each; C1).
- **Why these qualify.** `routine_extent` already accepts calls and jumps into bank 0, which is fixed in every bank, and far calls, which carry their own bank and address. Identical bytes therefore still behave identically.
- **Method.** A second scan (kept in `build/`, not committed) grouped address-only routines whose calls all target bank-0 labels.
- **23 families added** to `config/name_families.json`:
  - Slot status: SlotHasStatus3Or4Bits (8 copies), CheckSlotStatusBlockWide (6), BattlerRecordAddress.
  - Slot counting: CountPresentSlotsOfWC57FSide, CountPresentFoesOfWC57FSide.
  - String window: three ShowStringBank0xAtTilesHL wrappers (save, set and restore the window wC52D–wC530 around a string call), SetDefaultStringWindow.
  - Menu: SetupInventoryMenuPages (24 slots, pages of 4), DrawMenuPageNumber.
  - VRAM drawing: CopyRectToVRAMSourceStrideBPlus14, DrawSevenDigitsFromWD7F1, WriteBCTileAtWordTableEntry, WriteThreeC3TilesAtHL, WriteTileC0/C1/C2AtHL.
  - Numbers and buffers: SplitWD7ABBy4, ScaleHLTo80Percent, StoreRandomByteAtHL, ClearBank35RecordBuffer.
- **Shared name.** Two ShowStringBank08AtTilesHL copies differ only in register order during the restore, have the same effect and sit in different banks, so they share a name.
- **wC52D–wC530.** These are the string window, tile destination plus size, as already noted at the routine that sets them (comment generated in `src/`).
- Binary verification: pending; see the commit.

### E-0068 — Menu cursor routines in banks $1B and $1D

- Kind: OBSERVATION (full reading only; C1).
- **Routines read:**
  - `UpdateTwoChoiceCursor_Bank1D` (`1D:6540`, 27 references) and its four helpers.
  - `UpdatePagedListCursor` (`1D:66B6`, 34).
  - `1B:63CB` has the same instructions as `1D:6540` once label names are normalised, so it gets the same name with its bank. Its position table was not compared.
- **wMenuInputResult (wD7F9).** Both routines report their outcome there with the same codes: $FF A, $FE B, $FD row move, $FB page move, 0 none. They use the same cursor tiles as UpdateMenuCursor (E-0060): $BB cursor, $C3 blank, $BC confirmed.
- **Joypad bits.** As in E-0060, the standard Game Boy order is assumed.
- **Unknowns:** which screens use these menus. The 1D:6540 position table (two entries, BG-map offsets $012F/$016F) suggests a yes/no prompt; not checked.
- Binary verification: pending; see the commit.

### E-0069 — The bank-$35 records are per-species monster data

- Kind: OBSERVATION (reading plus a scan of the ROM data; C2 for the family byte).
- **Claim.** `SpeciesRecordPointers` (`35:403B`, 384 entries) is indexed by monster id, and byte 0 of each 47-byte record is the family.
- **Scan.** For every entry, byte 0 is either $FF (61 unused ids) or a family number. The numbers start a new family at ids 1, 36, 71, 106, 141, 176, 211, 246, 281, 316 and 351 (blocks of 35), then a second Slime run at 373-378 and Boss from 379.
- **Name check.** Monster names from StringTable_MonsterNames (category 2, read with `tools/string_bank.py 08 4032 2 N`) agree at every boundary checked: 1 DrakSlime (Slime), 36 DragonKid (Dragon), 71 Tonguella (Beast), 106 Picky and 107 Wyvern (Bird). The family numbers 0-9 match StringTable_MonsterFamilies (Slime … Water), and 10 is Boss.
- **Code check.** Battle code loads the record with the word in wD958 + 2 * slot, and `16:6A36` turns the same word into a monster-name string reference (category 2 + high byte, index = low byte). So wD958 is the per-slot monster id, named wBattleMonsterId.
- **Correction to E-0062.** The pointers are not all 47 apart (unused ids share records); the records themselves are 47 bytes.
- **Renames.** LoadBank35Record and its variants become LoadSpeciesRecord, LoadSpeciesFamily, LoadSpeciesRecordWord0, CopySpeciesRecordPrefix and ClearSpeciesRecordBuffer. wD006/wD007/wD008 become wSpeciesIdLo/Hi and wSpeciesRecord.
- **New names:** GetSlotSpeciesFamily, SlotFamilyBelowWater, GetTargetSpeciesFamily, TargetMonsterIdAddress, CopyMonsterNameOfWDAABSlotToDE.
- **Unknowns:** bytes 1-46 of the record (bytes 18-23 look like small per-element values 0-3, possibly resistances; not checked), and how this table relates to the 26-byte MonsterTable read by LoadMonsterRecord.
- Binary verification: pending; see the commit.

### E-0070 — Per-species flag bits

- Kind: OBSERVATION (full reading only; C1).
- **The bit field.** `TestSpeciesFlag` (`16:5A7E`, 12 call sites) addresses one bit per monster id in a bit field at wC7CC (wSpeciesFlags), and `SetSpeciesFlag` (`16:5AAF`, 8) sets it.
- **The per-family count.** `CountSpeciesPerFamilyFlaggedOrListed` (`16:5AC0`) walks ids 0-372, skips unused ids through LoadSpeciesFamily (E-0069), and counts per family into 11 bytes at wD09D. It stops before the second Slime run (373-378) and the Boss block (379+).
- **Unknowns.**
  - What the flag records. A monster-library "registered" flag would fit the per-family count, but no screen has been tied to it.
  - What list Func_015_68FA searches at wC7FC.
  - What wC7FB's high nibble means.
- Binary verification: pending; see the commit.

### E-0071 — Bank-$05 skill checks, player steps, screen and text helpers (batch 7)

- Kind: OBSERVATION (full reading only; C1).
- **Bank-$05 skill checks.** These follow the C = $FF (pass) / $00 (fail) convention:
  - AnySlotLacksStatusMask and its users AnyFoeLacksStatus5Bits67, AnyFoeLacksStatus2Bit3, AnyFoeLacksStatus3And4Bits and AnyFoeLacksStatus0Bit6.
  - ActorLacksStatus4Bits67.
  - SkillPassesRepeatCheck, SkillPassesStatus1Bit0Check and SkillPassesSideFlagBit3Check.
  - Two chains that reset wDA6E at the first failed check: CheckSkillUsableElseResetWDA6E and CheckSkillUsableStatusElseResetWDA6E.
- **Comparison with the bank-$32 gates.** Several of these mirror refusal codes 2, 3 and 4 of CheckSkillMPCost and the bank-$32 gates (E-0049). The side-flag check differs: bank $05 ORs both sides' flags, while bank $32 tests the actor's side only. The bank-$05 callers are probably the enemy AI choosing a skill (inference).
- **Player steps.** Four StepPlayer*TowardWC928 routines (script movement) set hPlayerFacing 0-3 for down, right, up and left, the same direction numbering as StepObjectTowardCoord's direction byte (E-0061). wC92C is named wStepArrived.
- **Other routines:**
  - DrawFullScreenBufferToBGMap and CopyRectFromBankToVRAM (bank 0).
  - CopyItemNameToDE: bank $08 table at `$4716` = StringTable_ItemNames.
  - WriteHexByteTilesAtDE (debug screens).
  - CopyRecordRectToScreenBuffer_Bank07, AppendItemWC928ToInventory, SetBattleSubStep1 and ClearAndLayoutTileBlocksForWD890Count.
- **Not code.** `Func_003_460B` decodes as a run of `sbc`/`and` with a final `jp hl`. It is probably data reached by a heuristic, so it is left unnamed.
- Binary verification: pending; see the commit.

### E-0072 — Batch 8: string wrappers, status predicates, small helpers

- Kind: OBSERVATION (full reading only; C1).
- **Fourteen routines read:**
  - String display: ShowStringCategory5_Bank16, ShowStringAInDefaultWindow_Bank24.
  - Battle status predicates using the C = $FF/$00 convention: ActorLacksStatus2Bit1And4Bits01 and ActorLacksStatus1Bits23And4Bits01.
  - Indexing helpers: GridIndexFromWD786WD787 (6 columns), ActorActionChoiceAddress, GetActorWDA43Low2, MapIndexViaWC6FEKeepHL.
  - Object and counter state: ClearBit1OfPlayerAndObjectFlags, ResetWD7C2Counters.
  - Small helpers: CopyFiveGlyphsPlusMarks, IncrementD.
  - A family, WriteBCTileToScreenBufferAtTableEntry.
  - CopyRectTo20ByteRowsJp_Bank33, which has the same instructions as the bank-$24 copy.
- **Why the bank-$33 copy needed a hand name.** The automatic copy naming skips hand names that end in `_BankBB`.
- **The $2998 offset.** It maps $9800 to $C198 (wScreenTileBuffer), so the table holds BG-map addresses for positions mirrored in the buffer.
- **Unknowns.** $8D and $8E have no charmap entry. Being skipped in the 5-glyph count suggests combining marks left over from the Japanese text system; not checked.
- Binary verification: pending; see the commit.

### E-0073 — Batch 9: screen copies, serial start, small helpers

- Kind: OBSERVATION (full reading only; C1).
- **Routines read:**
  - Screen copies: DrawWC338RowsToBGMapRow13, DrawScreenBufferToBGMap0_Bank07, CopyRect32StrideToVRAM_Bank07 and CopyRectTo20ByteRowsJp_Bank1C. The last two have the same instructions as already-named copies.
  - FillRectWithTileSequence.
  - ClearDamageAndStoreWDAC0 in banks $36 and $3B.
  - StartSerialTransferInternalClock.
  - Small helpers: StoreBCAtWordEntryWD871, LoadWD7FFFromWC7C7Table, RunFrameTickFadeAndCounter_Bank1B and IsWD7F1Above24BitWC617.
  - The AddHFFC6WordToHL family.
- **The 24-bit comparison.** It treats wC617-wC619 as a 24-bit number (perhaps gold; not checked).
- **Serial start.** It uses the documented SM83/Game Boy serial-control bits: rSC bit 7 starts a transfer, bit 0 selects the internal clock.
- Binary verification: pending; see the commit.

### E-0074 — Gold, decimal output, cursor helpers (batch 10)

- Kind: OBSERVATION (full reading only; C1).
- **Gold.** The 24-bit value at wC617-wC619 is named wGoldLo/Mid/Hi. Evidence:
  - `InitGoldAndClearInventory` (`07:695A`) sets it to 100 in the same routine that empties the 24 wInventory slots. wInventory is already known to be empty at a new game.
  - `AddGoldCapped` (`12:7EC2`) caps it at 99,999.
  - A debug or test setup (`Func_007_6975`) sets it to 99,999.
  - `DrawGoldPanel_Bank24` converts it to BCD and draws the digits.
  - `IsAmountInWD7F1AboveGold` (renamed from E-0073) compares a 24-bit amount with it. That fits a price check, but the callers are not read.
- **Other routines:**
  - Decimal output: WriteDecimalByteString and WriteDecimalDigitForE. Digit glyphs are 0-9 = $00-$09 per the charmap.
  - SRAM and lists: StoreHFFC6BytesToSRAMRecord, CountWC707EntriesOrFull.
  - Screen: BlankWordTableTargets, the four-row cursor helpers DrawWD7B5Cursor, EraseWD7B5Cursor and DrawWD7B5CursorConfirmed, and two entry-tile families.
  - TestBitInFieldAtWD7F3 (MSB-first bit order).
  - ShowStringCategory5Immediate_Bank16 and SetWC5E9PatternAndIncWD804.
- Binary verification: pending; see the commit.

### E-0075 — Gold arithmetic, a status check that reads its own address, batch 11

- Kind: OBSERVATION (reading; `05:6972` also executed on our emulator, C2).
- **Gold routines (bank $12):**
  - SubtractGoldFloorZero.
  - DeductGoldPenalty: all gold below 150, 150 below 1,500, else a tenth. Which event uses it (for example losing a battle) is not established.
  - EventCheckGoldAtLeast10000, which tests story flags $192 and $193 with gold ≥ 10,000.
  - Other bank-$12 routines compare gold with thresholds (5,000; 1,000) and sum BCD digits. They are not named yet.
- **A probable game bug: `ActorStatus4CheckReadsAddress` (`05:6972`).**
  - Its neighbours (ActorLacksStatus2Bit1And4Bits01 and others) load a status byte with `ld a, [hl]` before masking. This routine calls AddAx9ToHL and masks A directly, so A holds the low byte of the address wD810 + 9 × actor.
  - Executed result: C = $FF for slots 0 and 4 and C = $00 for 1, 2, 5 and 6, both with status byte 4 clear and with it set to $03. Pinned by the test `Status4CheckReadsAddress`.
  - Whether this changes play depends on its callers, which are not read.
- **Also named:** DrawWC278RowsToBGMapRow7, GetWD789Cell4Address and GetWD789Cell5Address.
- Binary verification: pending; see the commit.

### E-0076 — CGB palette fade writers (bank $02)

- Kind: OBSERVATION (full reading only; C1).
- **Twelve routines** write faded copies of the palette buffers wBGPaletteBuffer (`$C49F`) and wOBJPaletteBuffer (`$C4DF`) to the CGB palette data registers:
  - two component rules, FadeColorComponentFloor and FadeColorComponentAdd;
  - per-colour writers for BG and OBJ under each rule;
  - per-palette wrappers (four colours) for each;
  - two whole-set routines, WriteAllFadedPalettesFloor and WriteAllFadedPalettesAdd, each covering 8 + 8 palettes after setting rBGPI/rOBPI to $80, the auto-increment bit.
- **The level and direction.** wC572 (wFadeLevel) is the per-component amount. wC56D bit 7 selects darkening (subtract, floor 0); clear selects lightening (floor rule: raise to at least the level; add rule: add, cap $1F).
- **Dead store.** The OBJ per-colour writers load wC572 into D and immediately overwrite DE.
- **Unknowns.** Which caller uses which rule. StartPaletteFade/StepFade (named earlier) are the likely drivers; not traced.
- **Also named:** ShowSkillNameAtSlotB (category 4 = StringTable_SkillNames), CopyTileBytesToVRAMCounted_BankF2, DrawWC338RowsToBGMapRow13_BankA0.
- Binary verification: pending; see the commit.

### E-0077 — CGB fade step, battler names, batch 12

- Kind: OBSERVATION (full reading only, except where marked; C1).
- **Fade step.** `StepCGBFade` (`02:4071`) is the CGB fade step that drives the E-0076 writers. Its RAM is named wFadeDelay (`$C573`) and wFadeDelayCounter (`$C574`).
- **Battler names.** `CopyBattlerNameToHL` (`3A:79A0`) shows that offset 0 of each 78-byte battler record (wBattlerRecords) holds the monster's name, copied as 5 glyphs.
- **Partly read.** CopySlotNameToHL and CopyTargetNameToWC130 cover more slots than were read, and their notes say so. The CGB tail of ClearScreenBufferAndAttributes_BankF1 is not read; it fills $90 bytes past wScreenTileBuffer.
- **Also named:**
  - sound and text: WriteChannelRegisterC (sound-register write relative to wDD0D), StoreAThenTerminator;
  - tiles: WriteTwoDigitTilesFromWC8C1, FillVRAMRectWithTileSequence, three DrawWCxxxRows routines;
  - battle and helpers: AnyFoeLacksStatus0MaskCC, RandomBelowC, LoadBCFromHL, StoreBCAtActorWordEntry.
- Binary verification: pending; see the commit.

### E-0078 — Batch 13

- Kind: OBSERVATION (full reading only; C1).
- **Routines read:**
  - Bank-0 arithmetic and BG-map helpers: DivideBCByDE (8-bit quotient by subtraction), AdvanceBGMapColumnsByB.
  - Battle helpers: AnyFoeHasClearStatus3, SetActorTargetFromHFFC6OrHFFC9, ClearDamageAndReadTargetStatus0.
  - Screen and buffer copies: three bank-$31 rectangle draws, CopyRectRecordForWD88F_Bank31, CopyStringMaxBToDE.
  - A save and restore pair for sprite state: the SaveAndHideSpriteState family and RestoreSpriteStateFromWD7BA. The restore writes $80 to hFFBA instead of the old value.
  - Other: AddWD09CIfWD09BMatchesB, SetModeState3AndSaveScreen.
- **Identical copies.** `31:74B4` and `31:74E1` are byte-identical routines at two addresses; both are named.
- Binary verification: pending; see the commit.

### E-0079 — The message-box runner

- Kind: OBSERVATION (full reading of states 0-3; C1).
- **What it is.** `RunMessageBox` (`5F:6936`) is a 4-state machine driven by wC926 (wMessageState, $FF = idle). Each state does its step and advances the state byte.
  - State 0 requests a text window at vTiles1 with size $1202 (the same values as SetDefaultStringWindow), plays sound $69, and sets the window position. It uses the top when hPlayerY ≥ $48, so the box avoids the player.
  - State 1 starts the text through ShowMessageFromWC924.
  - State 2 waits for wC52B bit 0, then requests the window close.
  - State 3 waits for it.
- **The message word.** `ShowMessageHL` (`5F:69FB`, already reached as ScriptCommand0A_Run_Case02_Sub01) takes L as wStringIndex with category 0, and H & $3F as a 12-entry message-group dispatch. So wC924 is the string index (wMessageIndex), and wC925 holds the group plus two flags: bit 7 skips the window open, bit 6 skips the close (wMessageGroup).
- **Renames and new names.**
  - The routine named SetWC924ClearWC926 in E-0063 sets the string index and resets the state to 0, so it is renamed StartMessageA.
  - Wrappers named: RunMessageBoxFar (family, far call), RunMessageBoxCarryWhenIdle_Bank5F, RunMessageBox_Bank12 (a bank-$12 variant taking the freeze flag on the stack) and RunMessageBoxCarryWhenIdle_Bank12.
- **Unknowns.**
  - What Func_004_4470 does. It is called in state 0 when the freeze flag wC928/A is 0, and state 3 then calls ClearBit1OfPlayerAndObjectFlags, which suggests freezing and releasing movement.
  - Everything after state 3.
  - The 12 message groups.
- **Also named in this batch:** WriteTileBAtScrollOffset47PlusWCFC2, WriteBCTileAtHLOrHLPlusBC, LoadHFFC6WordFromWCA2B, CopyRecordRectToScreenBuffer_Bank1A and two wrappers of it.
- Binary verification: pending; see the commit.

### E-0080 — Message string banks and their overflow banks

- Kind: OBSERVATION (pattern match plus reading of representative cases; C1).
- **The pattern.** ShowMessageHL (E-0079) far-calls the `$4001` entry of one bank per message group: $28, $29, $2A, $2B, $2C, $2D, $2E, $7C, $80, $82, $86 and $89. Bank $83 has the same stubs.
  - Each such bank starts with two stubs. `$4001` handles BeginStringDisplay and `$4016` handles CopyStringToBuffer: when wStringIndex is below the bank's threshold, they use the bank's own string table (`$4032`). Otherwise they far-call an overflow entry in banks $96-$99.
  - That overflow entry subtracts the threshold from wStringIndex and uses a second table there.
- **Detection.** A script (`build/string_stubs.py`, not committed) matched the exact instruction shapes. It found 26 stubs and 26 overflow entries. The thresholds are unique per bank ($88 bank $0E, $DA $28, $8E $29, $95 $2A, $8A $2B, $91 $2C, $D5 $2D, $A6 $2E, $87 $7C, $C8 $80, $90 $82, $C7 $83, $DE $89), so each overflow entry pairs with its bank.
- **Names.** Stubs are named BeginStringDisplay_BankBB / CopyStringToBuffer_BankBB, overflow entries ..._BankBB_Overflow, and tables MessageStrings_BankBB(_Overflow).
- **A likely bug.** Bank $82's CopyStringToBuffer stub far-calls `96:4026`, the BeginStringDisplay overflow entry. The matching copy entry `96:4035` exists right after it but is not used, so a copy request for string $90 or above starts a display instead.
- **Not covered.** Bank $86's entry is named already and has a different shape, and the overflow entries' `call` stubs (`db $CD …` runs) are untraced data.
- Binary verification: pending; see the commit.

### E-0081 — Message stubs named from their text

- Kind: OBSERVATION (pattern match plus decoding of ROM text; C1 for what each stub displays).
- **Superseded by E-0269:** DE is a story flag and the stubs are one-time treasures (ChestItem_* etc.); the message reading below is wrong.
- **The stubs.** 69 routines (54 in bank $04, 15 in bank $13) share one shape: `ld a, P0 / ld [wScriptParam0], a / ld a, P1 / ld [wScriptParam1], a / ld de, W / call SetRequestPtrC924FromDE / ret`. That helper stores DE as the message word and starts script command $0A, whose case 2 is ShowMessageHL (E-0079), so it is renamed StartMessageScriptDE_B04/_B13.
- **Decoding the text.** Each stub's text was found with the E-0080 tables: group = high byte & $3F, then the bank from ShowMessageHL's dispatch, then string = low byte, using the bank's table below its threshold and the overflow table above it. It was rendered with the game charmap by a script (`build/msg_stubs.py`, not committed).
- **Names.** Stubs are named `MsgGGII_FirstWords` after the message word and the first words of the string; notes quote at most six words.
- **Shared and empty strings (real data).** Several table entries share one string. For example, entries 56-66 of bank $29's overflow table all point to the same egg-spot line, and entries from 71 on point to an empty string. Stubs whose text resolves to an empty string keep an ID-only name.
- **Limits.**
  - ShowMessageHL takes a different path when wCC44 has bit 7 set (and is not $80), and that path is not read, so the quoted text holds for the normal path only.
  - wScriptParam0/1 are not interpreted.
- Binary verification: pending; see the commit.

### E-0082 — Flag-gated talk routines named from their text

- Kind: OBSERVATION (pattern match plus ROM text decoding; C1).
- **Script command $09.** It is a message runner like RunMessageBox, with the message word in wScriptParam0/1. Its show step (`10:4AD0`) uses the same 14-way group dispatch as ShowMessageHL when wD7F0 = 0. A non-zero wD7F0 selects an override table (`Data_010_4AFF`), which is not read.
- **Helper renames.**
  - The helper that stores HL in wScriptParam0/1 and starts command $09 is renamed StartMessageCommand09HL_B04/_B13 (was SetRequestPtrC921). Its earlier note named the old addresses wC921/wC922, which are wScriptParam0/1.
  - The script-pointer helper becomes StartScriptAtHL_B04/_B13 (was SetRequestPtrC91A).
- **46 routines** have the shape: zero or more `ld de, FLAG / call TestFlagBit / (jr|jp) c or ret nc`, then `ld hl, W / call StartMessageCommand09HL / ret`.
  - The 8 with a single `ret nc` are named IfFlagFFFFMsgWWWW_Words: they show the message only when the flag is set (TestFlagBit returns carry when the bit is 1).
  - The others are named TalkMsgWWWW_Words. Their notes list the flag branches; the default message is the one named.
- **Text.** Decoded as in E-0081. Duplicate message words get the routine address appended.
- **Unknowns:** the meaning of each story flag, and the wD7F0 override path.
- Binary verification: pending; see the commit.

### E-0083 — Per-skill AI scoring routines (bank $E2)

- Kind: OBSERVATION (reading of the dispatch plus a scan of the table data; C1).
- **The dispatch.** `ScoreSkillForAI` (`30:4BA0`) takes a skill number in A.
  - It calls AddSkillBaseWeightAndLoadSkill, which returns A unchanged after adding a per-skill base weight and loading the skill record.
  - It then uses A to index a table of 3-byte far pointers (address low, high, bank) held in wDA6B/wDA6C. With wDA6E-wDA71 cleared, it calls the entry through `rst $10`.
  - The two tables, `Data_030_5785` and `Data_030_59E0`, are named AIScoreRoutineTableA/B. They are equal in all 201 entries, and every entry is in bank $E2.
- **Mapping skills to routines.** Entry i was paired with skill name i of StringTable_SkillNames (bank-$08 database, category 4).
  - Entries that share a routine are skill families: Blaze/Blazemore/Blazemost; Heal/HealMore/HealAll; MPass/MPassmore/MPassmost; Firebal…Explodet.
  - That supports the index being the skill number.
  - From 175 on, the name table repeats "HighJump" and the entries point at `$64C0`/`$64C1`, so only indices below 175 are used for names.
- **Names.** 118 bank-$E2 routines are named `AIScore_<first skill>`, with the full skill list in each note. The checks inside each routine (calls into the bank-$05 predicates of E-0071/E-0072 and AccumulateBank6WordToDA6E/DA70 weights) are not interpreted.
- **Unknowns.**
  - How the scores are compared to pick a skill.
  - When table B is used instead of A.
  - Skill 0 (no name), which has its own routine, AIScore_Skill00.
- Binary verification: pending; see the commit.

### E-0084 — Action effect routines named after their skills

- Kind: OBSERVATION (table scan plus the skill-name mapping of E-0083; C1).
- **The table.** DispatchActionEffectTable (`36:6717`, E-0053) jumps through the word table at `36:6726`, indexed by wBattleActionId.
  - Reading words until the first address the table itself would reach gives 240 entries (ids 0-239). The table ends at `$6906`, the lowest target.
  - It has the same family sharing as the AI table: entries 1-3 → one routine (Blaze/Blazemore/Blazemost), 4-6 (Firebal/Firebane/Firebolt), 7-9 (Bang/Boom/Explodet), 10-12 (Infernos…), 16-18 (IceBolt/SnowStorm/Blizzard). That again supports the action id being the skill number below 175.
- **Names.** 119 routines are named `ActionEffect_<first skill>`, with the action list in each note. Ids 175 and up (including the $D0-$E3 specials of E-0045) have no skill name, so routines used only by them get `ActionEffect_ActionXX`.
- **Not named.** 36 target addresses are already named or sit inside another routine (shared tails).
- **Limits.** The effect bodies are not read. Each name says which actions reach the routine, not what it does.
- Binary verification: pending; see the commit.

### E-0085 — Item-use handlers named after their items

- Kind: OBSERVATION (table plus item-name mapping; C1).
- **The table.** RunItemEffect (`16:4025`) dispatches on wItemId through an inline `rst $00` table of 99 entries.
- **Mapping.** Entry i was paired with string i of StringTable_ItemNames (bank-$08 database, category 5).
  - The shared entries fit item kinds: Herb and LoveWater share the handler that refuses when the monster's current and maximum HP are equal (already noted at RunItemEffect); Potion and ElfWater share one; WorldDew and SageRock share one.
- **Names.** 42 distinct handlers are named `ItemEffect_<first item>`. Hand names replace the generated RunItemEffect_CaseNN names.
- **Limits.** The handler bodies are not read; each name says which items reach the routine.
- Binary verification: pending; see the commit.

### E-0086 — Per-action target routines named after their skills

- Kind: OBSERVATION (table scan plus the skill-name mapping; C1).
- **The tables.** Data_039_41AC (E-0061) holds, for AI modes 0-4 (wDA53), two table pointers each.
  - The ten tables start at `$41C0` and are $1C8 bytes (228 action entries) apart. The last ends at `$5390`, where the first table target starts.
  - The entries for modes 5 and up in Data_039_41AC are routine addresses (`$404B`, `$4078`), not tables, so the mode count is 5 (inference from layout).
- **Names.** Every routine reached from those tables that was still address-named, 98 in all, is named `ChooseTarget_<first skill>`, with the action list in the note. Several distinct routines serve the same first skill in different modes, so the address is appended (for example ChooseTarget_Heal and ChooseTarget_Heal_5593).
- **Limits.** The selection rules inside are not read.
- Binary verification: pending; see the commit.

### E-0087 — Proven data regions: bank-$E0 strings were decoded as code

- Kind: OBSERVATION (reading of the string loader plus the table bytes; C2 for the region boundaries).
- **The problem.** BeginStringDisplay_BankE0 passes DE = `$76FC` to BeginStringDisplay. That address holds one category pointer (`$76FE`); `$76FE-$773F` holds 33 string pointers, the first being `$7740`; the strings run to the $F0 at `$79C8`. The pointer-table heuristic had read the string pointers as a code table and traced 32 "routines" (`Func_0E0_7740`…`Func_0E0_79BA`) through the text. None had a caller outside the table.
- **The fix.**
  - New `config/data_regions.json` lists ranges proven to be data. `tools/disasm_all.py` now refuses heuristic entries, speculative fall-through starts and pointer-table runs inside them.
  - The bank-$E0 range now emits as `dw Data_…` string pointers and string data, and the 32 false routine labels are gone. Binary identity is unchanged.
  - Test `DataRegions` in `tests/test_generated_source.py` fails if a code label is generated inside a declared region.
- **A candidate rejected.** A similar scan proposed a bank-$1F range, but it would have covered `1F:5C15`, which eight banks far-call. The scan's string-end walk was wrong there, so that region is not declared.
- Binary verification: pending; see the commit.

### E-0088 — The bank-$A2 half of the bank-$E0 string database

- Kind: OBSERVATION (reading plus table bytes and a reference check; C2 for the boundaries).
- **How it was found.** A scan for heuristic routine entries whose bytes are at least 90% charmap text ending in $F0 found 18 in bank $A2. They lie inside the database that BeginStringDisplay_BankE0_Sub01 (`A2:49E2`, used for string categories ≥ 1 of bank $E0) passes in DE.
- **The region.** The database at `$49F8` has two category pointers ($49FC and $4A3E): a 33-entry table and a 1-entry table, the latter pointing at $4FCB. The strings run from `$4A40` to the $F0 at `$4FE6`.
- **Declared as data.** All 86 code labels the heuristics had placed in `$49F8-$4FE7` are referenced only from inside the range, so it is declared in `config/data_regions.json`. Binary identity is unchanged.
- **Also flagged, not acted on.** The same scan flagged `60:690E` (8 text-like bytes); it is not checked.
- Binary verification: pending; see the commit.

### E-0089 — Item usability checks versus item effects

- Kind: OBSERVATION (reading of four handlers per table plus the item-name mapping; C1).
- **Correction to E-0085.** The table behind `16:4025` holds usability checks, not effects.
  - Its Herb entry returns non-zero unless current and maximum HP are equal.
  - Its Antidote entry sets wItemId = $FF (refuse) unless record byte $55 bit 2 is set.
  - Its seed entries compare a stat with 999.
  - So `16:4025` is renamed CheckItemUsable and its handlers ItemUsable_<item>. Record byte $55 bit 2 being poison is an inference from the Antidote check.
- **The effects.** `16:468E` (ApplyItemEffect, a 95-entry table, called from other menu cases) holds the effects.
  - Its Herb entry adds (random / 11) + wD08F to the selected record's HP through Func_016_57D1, then runs ConsumeSelectedItemByChance.
  - Its handlers are named ItemApply_<item>: 64 new names. Item numbers above the named items get ItemApply_ItemNN.
- **Limits.** Bodies other than the ones quoted here are not read.
- Binary verification: pending; see the commit.

### E-0090 — Key names and bank-0 helpers

- Kind: OBSERVATION (reading plus decoded strings; C1).
- **Key names.**
  - `00:2458` writes the literal glyphs for "Magic Key" (decoded with the charmap) when A = $FE.
  - Otherwise it builds a two-word name from a 4-byte entry at $C708 + 4 × A: word byte0 + 1, then word byte1 + $11, both through `00:24A2`.
  - `00:24A2` copies a string of the bank-$09 database's category 3, whose entries begin Ylw, Plain, Green, Blue, … (1-16), then Slime, Draco, Beast, Bird, Tree, Bug, … and Cave, Isle, Torch, Gardn.
  - So wC707 is named wKeyList (32 entries, the count routine renamed CountKeysOrFull), and the two routines are named WriteKeyNameToDE and CopyKeyNameWordToDE.
  - That entries are the travel keys of the game is an inference from "Magic Key" and the name words.
- **Bank-0 helpers named:**
  - IncrementWC533Word, ReadFarPointerAtDEInBankB, AddHLToTextCursorWC554 and NextTableByteSecondStream (a second random stream kept in wC5BA/wC5BB);
  - CopyRectFromBankToBGMapWrapped, BlankBGMapEntriesRight, CopyCBytesToVRAMWaitSTAT, BGMapAddressAtScrollPlusHL and ResetFadeFromWC5E9;
  - the 24-bit divide pair Divide24ByHFFCCDE and Quotient24ByHFFCCDE. The latter overwrites wMenuRowCount as scratch.
- Binary verification: pending; see the commit.

### E-0091 — AI rule checks on wD044 and their weight wrappers

- Kind: OBSERVATION (full reading only; C1).
- **The five checks.** `05:55F3`, `5628`, `565D`, `5692` and `56C7` are one routine each for bits 5, 4, 3, 2 and 1 of wD044, named CheckWD044RuleBitN.
  - Each fails (C = 0) when wC58A is neither 0 nor 2, wD044 bit 7 and bit N are set, and either wD045 bit N is clear or the actor side's wD057 byte has bit N set.
- **The wrappers.** `E2:6854`-`6898` far-call one check each and add weight entry $0E to wDA70 on failure. They are used by many AIScore routines (36 references to the bit-5 one) and are named WeighWD044RuleBitN.
- **Also named:** CheckLoneFoeHPNotBelowWD2C1 (`05:4C5D`, 32 references).
- **Unknowns.** What the wD044/wD045/wD057 bits mean. Player-set battle orders or AI tactics would fit the shape of the checks, but this is not checked.
- Binary verification: pending; see the commit.

### E-0092 — More bank-$05 AI checks

- Kind: OBSERVATION (full reading only; C1).
- **Seven checks named:**
  - HPBandOfSlotHFFC6 returns C = 0-5 for HP at or above 2/3, 1/2, 1/3, 1/4 and 1/10 of max, else 5. It is used by AIScore routines such as AIScore_HealUs.
  - FoeOfFamilyEPresent (family numbers of E-0069).
  - CheckFoeStatus6Bit3 and CheckWD2CCSetModeGated, which return C = 1 below AI mode 3.
  - AllOtherAlliesHaveStatus0Bit6.
  - SlotHasSkillWithFlagD, which shows wD989 + 16 × slot holding the slot's 8 skill numbers in every other byte.
  - Get2BitFieldEOfHL.
- **Convention.** The C = 1 "mode below threshold" result joins the C = $FF/$00 pass/fail convention of the earlier bank-$05 predicates.
- Binary verification: pending; see the commit.

### E-0093 — Followers, tile-rectangle drawing, digit blanking

- Kind: OBSERVATION (full reading only; C1).
- **Followers.** `02:5923` copies the player's position into record 0's target and each record's position into the next record's target, over three 5-byte records at wC8EF. `02:5946` moves each record one pixel (four when wC468 bit 7) toward its target and sets its direction byte.
  - This is the party trail behind the player. The records are named wFollowerRecords, and they agree with ScriptSetDirection's "5-byte records at wC8EF" (E-0038).
  - The three-copy wrapper UpdateFollowersOnStep refreshes the targets at each 16-pixel boundary and is called from the StepPlayer*TowardWC928 routines (E-0071).
- **Tile rectangles.** `1F:5D2A` (DrawTileRectFromWD7F1Params) draws a tile rectangle whose parameters sit in wD7F1-wD7F7. A four-copy family, DrawTileRectAtHLFromDE, sets the destination and source and calls it.
- **Leading zeros.** The BlankLeadingZeroDigitsWC8C0 families store $E3 in leading zero digits. $E3 + $E0 (the digit-tile base) = $C3, the blank tile.
- **Also named:** DrawFullScreenBufferAtScroll, DrawPageOfPagesAtWD7F1, DecompressGraphicsHFFC6ToHFFCA (partly read).
- Binary verification: pending; see the commit.

### E-0094 — Unreferenced bank-$05 AI predicates

- Kind: OBSERVATION (full reading only; C1).
- **How they are reached.** 184 heuristic routine entries have no reference in the traced source. The bank-$05 ones read as real AI predicates in the same style as the referenced ones, so they are probably reached in a way the tracer does not follow. How they are called is not established.
- **Fourteen named:**
  - status predicates: AnyFoeLacksStatus5Bits01, AnyFoeLacksStatus5Bit0And1Bit1, AnyFoeLacksStatus5Bit1And1Bit1, ActorLacksStatus4Bits01 (the correct version of the test ActorStatus4CheckReadsAddress gets wrong, E-0075), ActorLacksStatus1Bit2, ActorLacksStatus1Bit3, AnyAllyWDA76Bits2To5NotAllSet;
  - HP comparisons: CompareHPWithHalfMax, CompareHPWithQuarterMax, CompareHPWithTenthMax;
  - score accumulators: AddBCToWDA6E, AddBCToWDA70;
  - others: CountSlotSkills40To47 and CheckWCFC5Not4Or5.
- **Probably unused.** A follow-up search found no encoding of most of these addresses anywhere in the ROM: no `call`/`jp` with the address, no 3-byte far pointer with bank $05, and no `ld hl` immediate.
  - The exceptions are `$456B` (5 call/jump byte matches), `$4E0F` (3), `$47E5` (1 word in a battle bank) and `$6F01` (8 words), not checked; these may be coincidental byte patterns.
  - So most of these predicates are probably leftover code that the game never calls (inference; a computed call cannot be fully excluded).
- Binary verification: pending; see the commit.

### E-0095 — Level-based chance rolls and damage scaling (bank $36)

- Kind: OBSERVATION (full reading of every routine named; C1).
- **Chance rolls.** Four routines take a level 0-3 in A and return carry for success. Each draws AdvanceRandom and compares wC5E7 with thresholds:
  - $D8/$7F;
  - always/$BF;
  - $BF/$66;
  - a side-dependent set: $7F/$4C/$26 against slots 0-3, otherwise $BF/$7F/$3F.
  - Level 3 always fails and level 0 always succeeds, except in the side-dependent set.
- **Damage scaling.** Four routines scale the damage word by level:
  - 1/0.85/0.5/0;
  - 1/0.75/0.4/0;
  - 21/16, 37/32, 3/4, 0.3;
  - 3/4, 1/2, 1/4, 0.
  - They are built from the scale helpers named here; the factors follow from the shift and multiply/divide sequences.
- **Selectors.** Three selectors pick a table by bits 6/7 of [HL]: RollChanceByFlagsAtHL, RollChanceByFlagsAtHLSided and ScaleDamageByFlagsAtHL.
- **Also named:**
  - RollSkillDamageFromRecord: base and spread from skill-record fields chosen by the actor's side.
  - RollDamageBaseToBasePlusWD86A.
  - Seven GetTargetWDA72ByteK getters for a 7-byte per-slot record at wDA72.
- **Inference, not checked.** The level is most likely a resistance level. The AI reads 2-bit fields out of the same wDA72 records (Get2BitFieldEOfHL, E-0092), and levels 0-3 map to "normal … immune" in the tables.
- Binary verification: pending; see the commit.

### E-0096 — Battle helpers: family targeting, base stats, status edits

- Kind: OBSERVATION (full reading unless marked; C1).
- **Family targeting.** TargetWeakestFoeOfFamilyD (`39:7093`) and TargetRandomFoeOfFamilyD (`39:70FD`, choice rule not read to the end) select foes by species family (E-0069). Their callers are the ChooseTarget routines of the family-named slash moves (DrakSlash, DevilCut, ZombieCut, CleanCut, …), which fits.
- **Other battle helpers named:**
  - ComputeAttackDamageWithHalvedDEF (effective DEF one quarter);
  - ForceLevel4IfActorWD854Bit2 and RollChanceVsTargetWDA72Byte5Bits23, both using the E-0095 tables;
  - ScaleDamageByFlagsAtHLAlt and ScaleDamageByFlagsAtHLBit6;
  - GetBaseATK/DEF/AGLOfSlotA;
  - TargetStatus3Address, SetSlotStatus6Bit6, ClearTargetStatus5Bits23And7Bits012 and AnySlotStatusMaskSet;
  - the four-choice SetActorTargetFromHRAMChoice4.
- Binary verification: pending; see the commit.

### E-0097 — The talk-event dispatcher and talk handlers named from their first message

- Kind: OBSERVATION (reading of the dispatcher plus ROM text decoding; C1).
- **The dispatcher.** `13:405C` (39 references) either starts script command $09 or jumps through an 11-entry table by wC917.
  - Group 4 dispatches on wC916 through a 257-entry table whose entries include the TalkMsg routines of E-0082.
  - It is named DispatchTalkEvent. That wC917/wC916 are a talk group and entry is an inference from those targets.
- **Talk handlers.** 36 unnamed bank-$04/$13 routines contain at least one constant message start: `ld hl, W` / StartMessageCommand09HL, or `ld de, W` / StartMessageScriptDE. They are named `TalkWWWW_Words` after the first such message in the code, with the message count in the note. Examples: Talk0A41_ThisIsGreatLogCastle, Talk0DD8_QueenHelenIsWracked, Talk0D90_HumphImTerryTerry.
- **The player name.** A leading "0" in decoded text is where the player's name is substituted (as in "<F9>0 received an Herb"), so names write it as "Hero". Earlier Msg/TalkMsg/IfFlag names with that token are renamed the same way.
- **Limits.** The flag branching inside each handler is not interpreted.
- Binary verification: pending; see the commit.

### E-0098 — Helpers shared inside one named routine: Root_SharedNN

- Kind: DECISION (naming rule) on call-graph facts (C0/C1: the name says where a routine is used, not what it does).
- **The rule.** `name_single_caller_helpers` in `tools/disasm_all.py` now also names a routine with several calling routines, provided all of them belong to one named routine: its `_SubNN`, `_CaseNN`, `_TableN_CaseNN` or `_SharedNN` helpers, or the routine itself. The new name is `Root_SharedNN`.
  - The same exclusions apply: no table targets, no unnamed roots, and no self-calls.
  - It runs in the same three rounds, so the helpers of shared helpers are named too.
- **Effect.** 52 routines were named this way, and the count of address-only routines fell from 2,280 to 2,220. Binary identity is unchanged.
- **Examples:** ScriptCommandF7_Run_Shared01-04 and AIScore_TwinHits_Shared01.
- Binary verification: pending; see the commit.

### E-0099 — AI-scorer-only predicates, and an MP check that reads the wrong offset

- Kind: OBSERVATION (reading; `05:4259` also executed, C2).
- **The set.** 68 address-only routines are called only from AIScore routines, mostly short bank-$05 predicates in the C = $FF/$00 (and C = 1 below an AI mode) convention. Fifteen are named here:
  - status checks: AnyFoeLacksStatus0Bits01, AnyFoeLacksStatus1Bit0, AnyFoeLacksStatus1Bit7, AnyAllyLacksStatus2Bit6, CheckFoeStatus7Bit2, AnyAllyLacksStatus1Bits23And4Bits01;
  - skill and stat checks: AnyActiveFoeHasSkillFlag40, AnyFoeHasSkillFlag10, AnyFoeHasDEFAtLeast2;
  - checks on the per-slot level fields: AnyFoeOpenToWDA73Field0, AnyFoeOpenToWDA76Field0, AnyFoeOpenToWDA77Field3;
  - side checks: AnyOwnSideSlotOutIs1, CheckSideWC984Not1;
  - AnyFoeHasMPReadsWrongOffset (below).
- **A likely game bug: `AnyFoeHasMPReadsWrongOffset` (`05:4259`).**
  - It indexes wBattleMP with `swap a` (16 × slot), although the array has one word per slot (2 × slot).
  - Executed with actor 0, so the foes are slots 4-6: the real MP word of slot 4 set to 50 gives C = 0, while a byte at wBattleMP + $40 gives C = $FF.
  - Pinned by the test `FoeMPCheckOffset`.
- Binary verification: pending; see the commit.

### E-0100 — More AI-scorer predicates

- Kind: OBSERVATION (full reading only; C1).
- **Twelve named:**
  - status checks: AnyFoeLacksStatus5Bits01And1Bit1, AnyAllyLacksStatus2Bit2 (and its twin, below), ActorLacksStatus4Bits45, AnySlotHasStatusMask (the opposite test to AnySlotLacksStatusMask);
  - level-field checks: AnyFoeWithMPOpenToWDA74Field1, AnyFoeOpenToWDA74Field3;
  - counts and amounts: AtLeastTwoFoesPresent, ActorMPBelowThreeQuarters;
  - battle-state checks: CheckWCFC5Not2Or3, CheckWCFC5AtLeast2OrWC58ASet, CheckActorSlot0To3OrWC58ASet.
- **A possible slip.** `05:5D31` computes the side with `and a, $04` twice. Every opposite-side predicate uses `and a, $04 / xor a, $04`, so it tests the actor's own side exactly like `05:5D20`. It is named AnyAllyLacksStatus2Bit2_5D31, and the note says it probably meant the foes. Not executed.
- Binary verification: pending; see the commit.

### E-0101 — A bank-$03 cursor table decoded as code; menu helpers

- Kind: OBSERVATION (reading plus table bytes; C2 for the table extent).
- **The table.** `03:460B` (flagged as probably data in E-0071) is loaded into HL or DE by eleven bank-$03 menu routines and indexed as a word table. Its bytes are ten BG-map addresses ($9861 … $98E9) running up to `Data_003_461F`.
  - It is declared in `config/data_regions.json` and named MenuCursorPositions_Bank03.
  - Rows 3-13 of column 1 and rows 1-7 of column 9 match the two-column menus that use it.
- **Helpers named:**
  - ShowSelectedItemDescription (category 6 of the bank-$08 database: item descriptions, confirmed by `tools/string_bank.py 08 4032 6`);
  - DrawMenuCursorTileInBuffer;
  - the screen-block loaders LoadScreenBlock21, LoadScreenBlock21WithCursor and LoadScreenBlocks1CAnd0C;
  - ByteAToDecimalDigits and CopyTenBytesToWC130.
- Binary verification: pending; see the commit.

### E-0102 — Indexed tables that had been decoded as routines

- Kind: OBSERVATION (reading of each loader plus a reference check; C1/C2).
- **How they were found.** A scan for `Func_` labels whose only references are `ld hl/de/bc` loads (no call, jump, far call or `dw`) found eleven. Every load is followed by indexing (`add_a_to_hl`, or `add a, e` / `adc`) and a read, so each label is a data table.
- **The regions.** Each region runs from the label to the next label referenced from outside, and none of the heuristic labels inside is referenced from outside. They are added to `config/data_regions.json`: `05:5A33`, `05:5AF8`, `0C:72C0`, `11:42AC`, `15:5A67`, `16:5CFB`, `3B:4A24`, `60:690E` (the E-0088 flag), `E2:6727` (narrowed to six bytes after the `DataRegions` test showed `E2:672D` is code called as AIScore_Cover_Sub02; the first scan had missed references made through generated names) and `F1:4A5E`.
- **The bank-$30 table.** `30:4F46` holds 16 bit-mask words, followed at `$4F66` by a 16-entry jump table to code. Only the masks are declared as data, so the pointer-table pass can still find the handlers. Names: BitMaskWords16, RunHandlersForSetBitsInBC (`30:4F14`) and CallFlagBitHandlerE (`30:4F3B`).
- **Not checked.** The contents of the other ten tables are not interpreted.
- Binary verification: pending; see the commit.

### E-0103 — Save-record stat edits (bank $16)

- Kind: OBSERVATION (full reading unless marked; C1).
- **The cap.** CapDETo999 limits a word to 999.
- **The edits.** Four routines edit words of the selected save record wD083 at field offset C:
  - AddAToRecordWordCapped and AddAToRecordWordPairCapped (the pair form also edits the word two bytes before, a maximum-and-current pair is likely);
  - SubtractAFromRecordWordFloor1 and SubtractAFromRecordWordPairFloor1. These leave 999 untouched and never go below 1.
  - These are the record edits the item effects (E-0089) and seeds use. The 999 cap matches the 999 test in the seeds' usability checks.
- **Also named:** ShowRaiseAmountOrRefuse, StoreHLToRecordField, BlankTileAtTableEntryDE, and the party tile loaders LoadTilesForPartyRecords and LoadTileForRecordByte0D (partly read).
- Binary verification: pending; see the commit.

### E-0104 — Save-record list builders and bit packing (bank $1D)

- Kind: OBSERVATION (full reading unless marked; C1).
- **The record filters.** Four routines walk the first wD7FF SRAM records ($A5 bytes each), where wD7FF comes from a table indexed by wC7C7. They filter on record byte 0 (0 = empty, 1 or 2 = in use) and byte $6E:
  - CountRecordsInUse;
  - ListRecordsState1WithByte6EClear, ListRecordsInUseWithByte6EClear and ListRecordsInUseWithByte6ESet, which build a list of record numbers in wD789 with its length in wD7A9.
  - What states 1 and 2 and byte $6E mean is not established.
- **Bit packing.** UnpackByteAtHLTo2BitFieldsWD7F5 and Pack2BitFieldsFromWD7E2 convert between a byte and four 2-bit fields.
- **Also named:** DrawThreeDigitsAtScrollOffset6E, and DecompressGraphicsWD7F1ToWD7F4, which uses the same far-pointer table at `04:4EAA` as DecompressGraphicsHFFC6ToHFFCA (E-0093).
- Binary verification: pending; see the commit.

### E-0105 — Copies of hand names that carry a bank suffix

- Kind: DECISION (naming rule).
- **The rule.** `name_copies_of_named_routines` used to skip every name ending in `_BankBB`. It now skips only data names and names derived from table position, stub shape or the call graph. A copy is named after the base name: a copy of `X_Bank1B` in bank $33 becomes `X_Bank33`.
- **Effect.** One new copy was named: ShowStringA10_Bank33, which replaces the call-graph name BeginString_Bank07_Cat5_Shared02. Binary identity is unchanged.
- Binary verification: pending; see the commit.

### E-0106 — List cursor, inventory removal, gold subtraction

- Kind: OBSERVATION (full reading unless marked; C1).
- **Named:**
  - UpdateListCursorWD7AB, with the same result codes as UpdatePagedListCursor (E-0068);
  - DrawRecordListNameTiles_Bank1D;
  - CopyTenBytesThenSelectSRAMBank0;
  - RemoveInventorySlotShiftDown, which leaves the last slot duplicated rather than cleared;
  - SubtractWD7F1AmountFromGold (no floor);
  - UnpackBCDToDigitsWD7F1, partly read;
  - DrawPageOfPagesAtScrollOffset, the scroll-relative form of DrawPageOfPagesAtWD7F1.
- Binary verification: pending; see the commit.

### E-0107 — Structural twins of named routines

- Kind: OBSERVATION (structural comparison; C1 for the shape, the behaviour follows the twin's own evidence).
- **Method.** A script (`build/twin_all.py`, not committed) compared every routine body after replacing all label operands with one placeholder.
  - It found 41 address-only routines whose body matches exactly one named routine elsewhere.
  - Only matches whose twin carries a hand name are used, because generated `_Sub`/`_Case`/`_Shared` names do not describe behaviour.
- **Named (nine):** UpdateMenuCursor_BankF1, ShowSelectedItemDescription_BankF1, HPBandOfSlotHFFC6_6312, ScriptCommandEF_Run_Bank1B, DrawPageOfPagesAtScrollOffset_BankF0, RunBattleCommandEntry_BankA1, RunBattleSetup_BankA0, RollChanceByLevel_100_100_75_0_Bank3B and DrawMetaSpriteAt_40CC.
- **Limits.**
  - Because labels are erased, the called routines and tables are each bank's own and may differ in content. For the dispatchers (ScriptCommandEF_Run_Bank1B, RunBattleSetup_BankA0, RunBattleCommandEntry_BankA1) the case code is the copy's own.
  - Banks $31 and $A0 are not copies of each other (30 unique twins).
- Binary verification: pending; see the commit.

### E-0108 — DMG palette fade steps and bank-0 hardware helpers

- Kind: OBSERVATION (full reading; hardware register meanings from the documented Game Boy behaviour, HARDWARE).
- **DMG fade.** DarkenDMGPaletteByFadeLevel and LightenDMGPaletteByFadeLevel rebuild a DMG palette byte shade by shade, through four small helpers. The shift by wFadeLevel is capped at 3 or floored at 0. They are the DMG counterpart of the CGB writers (E-0076).
- **Hardware helpers.** ClearSGBPacketBuffer, CopySGBPacketFieldsAndSend, ClearSTATInterruptSources (rSTAT &= 7) and WaitSerialTransferDone (rSC bit 7).
- **Record helper.** LoadRecordThreeBytesToHFFC6.
- **Not named.** `00:3340` sets wSoundId and searches a table at `$3E24`, which is the $FF terminator of SoundBankTable followed by code. Its callers have no references, so it may be unused or broken; it is left unnamed.
- Binary verification: pending; see the commit.

### E-0109 — Save-data check and save steps (bank $02)

- Kind: OBSERVATION (reading, several routines partly; C1).
- **The check.** CheckSaveData (`02:706E`) tests the signature byte $55 at SRAM bank 1 `$BB00`, then two checksum routines over SRAM banks 1 and 3. It reports 1 = no save, 2 = damaged, 0 = valid in hFFC6.
- **The save steps.** CopySaveBlocksToSRAM walks a list of (WRAM address, length) blocks at Data_002_75F7 into SRAM bank 1 from `$BB01`. RunSaveSteps sequences the save over two calls through wC8C3, setting bit 7 when done. SnapshotSpritesForSave stores sprite state first.
- **Partly read.** The checksum comparisons, the sum accumulation in CopySaveBlocksToSRAMWithSum, and the other step routines (`7333` and `7347` follow the same pattern). Their notes say so.
- Binary verification: pending; see the commit.

### E-0110 — Bank-$31 battle display helpers

- Kind: OBSERVATION (full reading unless marked; C1).
- **Named:**
  - ReadWordTableEntryForSlotC and DerefHL_Bank31;
  - LoadMonsterPictureAttributesFromDE;
  - the rectangle draws DrawWC2A4AndWC2B8Rects and DrawWC278Rect12x11ToBGMapRow7;
  - ClearAttributesAndScreenBuffer_Bank31 (partly read);
  - ShowStringHL_Bank31;
  - two `xor a / ret` stubs, ReturnZero_6286 and ReturnZero_61A2.
- **Left unnamed.** The per-slot routines that branch on wC58A/wC57F (`77B9`, `76AE`, `785F`, `7806`) hand mode 2 to bank $A0. They are not named yet.
- Binary verification: pending; see the commit.

### E-0111 — Battle status panel: HP, MP, name row and status marks per slot

- Kind: OBSERVATION (full reading unless marked; C1).
- **Bank $31.** DrawSlotHPDigits, DrawSlotMPDigits, CopySlotPanelRowToVRAM and DrawSlotStatusMarks draw one slot's panel entries.
  - Only the displayed side is drawn: slots 0-2 normally, or 4-6 when wC58A = 1 with wC57F bit 1.
  - With wC58A = 2 they far-call the bank-$A0 forms, named with `_BankA0`. Those take slots 0-2 and their own position tables (Data_0A0_6D47/4B/53).
- **Bank $A0, also named:**
  - WriteUnknownNamePlaceholder ("???" by the charmap);
  - DrawSlotLevel_BankA0 (tiles $EA $AF, then wD8B7[slot]; that this is a level is an inference);
  - DrawWC2B8Rect11x9ToBGMapRow9_BankA0 and ReturnZero_6871.
- **Unknowns.** What wC58A = 1/2 and wC57F bit 1 select. Link-battle roles would fit the side swap; not checked.
- Binary verification: pending; see the commit.

### E-0112 — Bank-$E0 value display helpers

- Kind: OBSERVATION (full reading unless marked; C1).
- **Digit and hex helpers:**
  - four DrawBitsNN routines that write one 2-bit field of [DE] as a digit tile;
  - DrawPacked2BitFieldsInRows;
  - WriteHexDigitTile (10-15 as n - 2), DrawFourBytesAsHexRows, DrawEightBytesAsHexColumns and DrawHexByteAtBGMap8A.
- **Others named:** DrawSlotHPMPStats_BankE0, ShowSkillNumberAndName_BankE0 and ChooseTargetIfUnset.
- **Where they are used.** The hex and 2-bit displays look like a debug or battle-setup viewer (the same bank holds the debug battle code), but the screen is not identified.
- Binary verification: pending; see the commit.

### E-0113 — Bank-$3A battle message name helpers

- Kind: OBSERVATION (full reading unless marked; C1).
- **Name copies for battle messages:** CopyActorNameToWC130, CopyTargetSideNameToWC130, CopyMappedSlotNameToWC140 and WriteMonstersWordToWC130. The last writes the fixed word "Monsters", decoded with the charmap.
- **Others:** SetWDA5BForPresentSlots and CopyVRAMRectToBuffer (its source-row step is not read).
- Binary verification: pending; see the commit.

### E-0114 — Short routines read in bulk

- Kind: OBSERVATION (full reading of each routine, at most 8 instructions; vector names from the documented Game Boy memory map, HARDWARE).
- **Method.** A listing of every address-only routine of up to eight instructions ending in `ret`/`jp` (315 of them) was read in one pass. 59 were named, including three three-copy families: SetWC2DFTileC2, SetWC2DFTileC1, SetWC2DETileC0.
- **Interrupt vectors and entry point** (by address):
  - Rst30Vector and Rst38Vector (bare `ret`);
  - StatInterruptVector ($0048) and SerialInterruptVector ($0058);
  - ROMEntryPoint ($0100).
- **Bank-0 helpers:** EnableLYCInterruptSource, ReadJoypadIntoWC560, StoreAFourTimesAtHL, ClearStringDisplayFlags, ShowStringHL_Bank08, ClearChannelLengthBits.
- **Battle predicates:** AnyFoeLacksStatus2Mask22, AnyFoeLacksStatus0Bit4, TestSlotStatus1Bit6 and CompareSlotHPWith1, plus MultiplyHLByAPercent.
- **Menu helpers:** MenuCursorAddressWC46E, DrawMenuCursorWC46E and EraseMenuCursorWC46E, WriteByteAAsTwoDigitTiles, and four screen-block loaders.
- **Bit and record helpers:** SetBit5/0AtHL/DE, SetBitInFieldAtWD7F3, StoreCToRecordField and TestWD083RecordFlag55Bit7.
- **Ten CopyRectRecordNNNNToScreenBuffer wrappers** in bank $1A.
- **Others:** three ShowStringHL wrappers and assorted setters.
- Binary verification: pending; see the commit.

### E-0115 — Short routines, second chunk: family-slayer and resistance damage

- Kind: OBSERVATION (full reading; C1).
- **Family-slayer damage.** Ten bank-$36 routines (`5566`-`55C9`) each compare the target's species family (E-0069) with one constant (0-9) and use ComputeAttackDamageWithHalvedDEF on a match, plain ComputeAttackDamage otherwise. They are named AttackDamageHalvedDEFVs<family> after StringTable_MonsterFamilies. They pair with the family-slaying moves' target routines (E-0096).
- **Resistance-scaled damage.** Four AttackDamageScaledByWDA72ByteNBitsXY routines, ScaleDamageByWDA72Byte1Bits76 and SkillDamageScaledByWDA72Byte6Bits32 scale damage by one 2-bit field of the target's wDA72 record (E-0095).
- **Battle sub-phase setters** SetSubPhase2AndResetResolveStep, SetSubPhase7AndResetResolveStep and SetSubPhase7AndResetSteps, with SkipTurnIfActorAbsent.
- **Bank-$31 battle screen helpers:** BuildBattleScreenBuffer and BuildAndDrawBattleScreen, four ShowStringAAtTiles routines, and seven far wrappers of the bank-$1A screen records.
- **Copies and small helpers:** CopyEBytesBCToHL, CopyBBytesHLToDE_Bank37, Copy26BytesThenWD034, AddAx4EToHL, ScaleHLBy3Over2, CopyMonsterNameToDE_Bank31, and others.
- **Not named.** `36:6A59` decodes as `ld [bc], a / cpl / ld [hl], a / nop / jr / reti` and is probably data.
- Binary verification: pending; see the commit.

### E-0116 — Short routines, third chunk

- Kind: OBSERVATION (full reading; C1).
- **Forty names**, including:
  - battle message buffers: the CopyXNameToWC1x0 copies, CopyActionSkillNameToWC140 (category 4) and CopyActionItemNameToWC150 (category 5), ShowActionBattleText;
  - resolve steps: SetResolveStep0A and its wDAC0 variant;
  - chance rolls and damage: RollChance3FOf256, RollChance80Of256, RandomBelow100, SetDamageRandomInRange;
  - bank-$3B dispatch: DispatchActionEffectTable_Bank3B;
  - the bank-$73 message runner and its idle check;
  - bank-$A0 counterparts of the bank-$31 screen helpers;
  - full-screen tile-map draws from banks $A1 and $E0;
  - PersonalityLevelOfA (the 0/1/2 rule of PersonalityIndexOfSlot);
  - return stubs.
- **Not named.** `3D:4E56` and `E0:55BF` decode as implausible instruction runs (data), and the per-skill AIScore wrappers in bank $E2 wait on Func_0E2_67F9.
- Binary verification: pending; see the commit.

### E-0117 — Medium-length routines read in bulk (first half)

- Kind: OBSERVATION (full reading of 9-16-instruction routines; C1).
- **Method.** A listing of all 205 address-only routines of 9-16 instructions was read in chunks. Fifty-two are named in this half (plus the family WriteTwoDigitTilesWC8C1NoBlank).
- **Palettes and fades:** SetDefaultDMGPaletteBytes, LightenSelectedDMGPalettes, LoadBGPaletteBufferFromBank, and LoadPalette0FromData4322/4ACC.
- **Screen blocks:** the LoadScreenBlocks… and LoadBlankedBlocks…WithCursor sets, and CopyBlockToTileBufferBlankingText (`33:402B`, which writes $C3 over tiles $15-$A3).
- **Save records:**
  - FullHealRecordWD083 and FullHealPartyRecordA copy record field $5D into $5B. These are the fields ItemUsable_Herb compares, so $5B/$5D are probably HP and max HP.
  - ClearPartyRecordFlag55Bit0. ItemUsable_Antidote tests bit 2 of the same byte, so this bit is another status.
  - SRAMBank1RecordAddress ($6F-byte records in SRAM bank 1).
- **Sprites, followers and SRAM:** RestoreSpriteSnapshot (undoes SnapshotSpritesForSave), ResetFollowersToPlayer and ClearSRAMBanks2And3.
- **Script movement:** the ScriptStepDelta… variants and ScriptApplyStepDeltaAtDE_Bank12.
- **Random and species helpers:** RandomModulo52/29 and LoadSpeciesBytes8To10….
- **Others:** grid and window helpers.
- Binary verification: pending; see the commit.

### E-0118 — Medium-length routines read in bulk (second half)

- Kind: OBSERVATION (full reading; C1).
- **Fifty-eight names from the rest of the 9-16-instruction listing:**
  - inventory: SwapInventorySlotCWithNext, LoadSelectedInventoryItemRecord, CopyItemStringToWC152;
  - battle start: InitSlotFromRecordFlags, which maps record flag bits 2/0 to battle status bits 0/5;
  - damage: DamageEightyPercentOfTargetHPScaled, ScaleDamageBy3Over2, ScaleHLBy29Over32, HalveDamageIfTargetStatus2Bit2;
  - battle messages: ShowSpecialActionMessage (the $D0+ actions) and ShowActionBattleTextFrom6DAA;
  - maps: SetMapScreenFromAAndCenterPlayer, LoadMapPositionFromHL, WarpToMap41;
  - sound and battle records: ClearSoundChannelSlots, BackupBattlerRecords0And1;
  - the battle-panel side swap DisplayedSlotOfActor;
  - several bank copies of earlier helpers (`_BankA0`, `_BankF0`, `_BankF1`).
- **Data tables named by structure only.** RunEffectTestEntryA reads 4-byte (actor, target, action, flags) entries, which looks like a test list. DecompressGraphicsAToTiles0 reads a far-pointer table.
- Binary verification: pending; see the commit.

### E-0119 — Remaining self-contained short routines

- Kind: OBSERVATION (full reading; C1).
- **What is named.** 38 short routines skipped in E-0114-E-0118 because their purpose was unclear are named by what they do, mechanically where the meaning is unknown. These include:
  - story-flag-gated script starts (IfFlag000AStartScript4F9D …) and script-start wrappers;
  - sound-engine state setters (wDD15/wDD09) and ReturnTwiceIfWDD08AndWDD0B, which pops the caller's return address;
  - screen-buffer draw steps that advance wD781;
  - item-refusal markers (wD08D = $12 or $14);
  - table readers.
- **Possibly data.** `36:6A59`, `3D:4E56`, `3E:7615` and `92:580E` decode as implausible runs (`halt`, `rst $20`, `ld sp, hl`) and remain unnamed.
- Binary verification: pending; see the commit.

### E-0120 — Routines of 17-26 instructions, first half

- Kind: OBSERVATION (full reading; C1).
- **What is named.** 50 routines of 17-26 instructions and one family are named by what they do. These include:
  - more copies of the "x of y" bracket draw (DrawC5BEC6AtScrollOffsetDE_Bank0D/14/1B/1E);
  - the six name-entry loaders of a record (LoadRecordNameEntry0-5), which unpack bytes $21-$26 into 2-bit fields;
  - inventory-page item names and the page indicator in bank $31;
  - HP and MP checks against three quarters of the maximum used by the AI;
  - the AI action chooser for one actor (AIChooseActionForActor) and its personality weight;
  - small damage helpers: a random spread of +/- 5 percent and an attack computed with ATK fixed at 200.
- Unknown meanings stay mechanical (for example InitWD043PresetA/B and LoadTable4E60EntryToHFFC8).
- Binary verification: pending; see the commit.

### E-0121 — Routines of 17-45 instructions, remainder

- Kind: OBSERVATION (full reading; C1).
- **What is named.** About 110 routines of 17-45 instructions are named by what they do. These include:
  - saving the game to SRAM with its checksum (SaveGameToSRAMWithChecksum, 02:7688);
  - saving and restoring the player position state (12:4DFB, 13:7FB0, 15:6E14);
  - the script warp command that reads a destination at DE (11:4340);
  - adding a record to the party as a follower (73:5F55);
  - counting a slot's active status effects (05:6E30) and summing its stats (05:6741);
  - battle helpers: a sixth of max HP lost (32:4D2C), damage times 50 when a flag is set (39:6E61), and AGL/DEF reset to base (32:5BE8);
  - 24-bit by 8-bit multiplies (19:4A74, 1C:6CAB);
  - per-bank copies of earlier names (the bracket and page indicator, skill-page names, effect-sprite setup in five banks).
- 32:4D2C subtracts the damage from HP without a floor check; callers may guarantee HP > max HP / 6. Executed in E-0154.
- Binary verification: pending; see the commit.

### E-0122 — Short routines that fall through or branch, and jump-table dispatchers

- Kind: OBSERVATION (full reading; C1).
- **What is named.** About 430 routines of 16 or fewer instructions are named; the earlier length lists missed them because they branch to internal labels or fall into the next routine. Naming dispatchers (`ld a, [state]; rst $00`) also renames their generated `_CaseNN` entries, so the unnamed count fell from 1500 to 943. These include:
  - field mode: FieldModeStateDispatch (02:4AE0), PlayMapMusic and RestartMapMusic (02:6050, 02:604B) with their story-flag music cases, and RunBattlePhase (31:40CC);
  - record fields from the code: $5B HP, $5D max HP, $5F MP, $61 max MP (85:45CB, 16:57D1, 16:57E8); $0D low nibble = family; $34 = the eight skills; $56 = level;
  - LoadFamilyPaletteForWD09D (16:7A48, 19 callers) and its per-bank wrappers;
  - status cures (3B:4BE8-4C5A) and AI trait rolls (30:4F86-4FB6);
  - blinking-cursor helpers in many banks (cursor tile $BB, blank $C3).
- 00:1CA1 has a check that never fires: `ld a, [wCC37]; ret nz` tests flags left by the earlier comparison. Executed in E-0154.
- Data mis-decoded as code, left unnamed: 12:55F8, 36:6A59, 36:746B, 3D:4E3D, 7A:4001, 92:5805, 92:580E, E0:55BF.
- Binary verification: pending; see the commit.

### E-0123 — Tables inside jump-table cases are named after their case

- Kind: DECISION (generator rule; structural naming, C1).
- **Problem.** `name_dispatch_cases` named a `rst $00` table's targets after the nearest routine label before the table. A table inside a case (for example the table at 37:53C0, inside `Func_037_4AFD_Case0D`) was attributed to an unrelated routine. Its targets were then called `ShowString0EAndStep_Bank37_CaseNN`, which says the wrong thing once that routine had a name.
- **Rule.** When the nearest label before the table is already named (a case or a hand name) and lies after the chosen routine label, it becomes the parent. 1993 nested case labels change, for example `Func_037_4AFD_Case0D_Case04`, `DispatchTalkEvent_Case05_Case61` and `ScriptCommandF8_Run_Case02_Case09`. Address-only routines fall from 943 to 786, because helper names now resolve through the corrected parents.
- **Test.** `tests/test_generated_source.py::NestedDispatchCases`.
- **Commits.** The regenerated `src/` for E-0120-E-0122 was not committed with those entries; it is committed here.
- Binary verification: build/run81 PASS, 0 differing bytes; 140 tests OK (3 skipped) before the new test was added.

### E-0124 — Routines of 17-30 instructions; family icon tiles corrected

- Kind: OBSERVATION (full reading; C1).
- **What is named.** About 205 routines of 17-30 instructions are named; the unnamed count goes from 786 to 542. These include:
  - AI usability checks in bank $05 (AIHealUsable, AIPanicAllUsable, AIParalyzeUsable, AIDanceUsable …);
  - inventory add and remove (16:4C78, 16:4C9E);
  - SRAM slot load (60:6CD1), the counterpart of the E-0121 save routine;
  - forced actions from status (30:5287: $CC-$CF);
  - stat buff caps (39:6F32, 39:6F66);
  - the per-bank meta-sprite builders (25-27:4001);
  - the gold-threshold event (12:797C, 5000 gold).
- **Correction.** E-0122 named 16:7A48 `LoadFamilyPaletteForWD09D`. Its helper 16:7AAF writes the bytes to VRAM tile wD09E ($8000 + 16 * index, indices below $80 in the $9000 area), not to a palette. The family data at Data_016_7ACD is 16 bytes per family, one tile each. Renamed `LoadFamilyIconTileForWD09D`, `LoadAllFamilyIconTiles` and `LoadFamilyIconTileForRecordB_*`.
- Binary verification: build/run82 PASS, 0 differing bytes.

### E-0125 — Routines of 31-45 instructions

- Kind: OBSERVATION (full reading; C1).
- **What is named.** About 135 routines of 31-45 instructions are named; the unnamed count goes from 542 to 391. These include:
  - experience gain capped at 9,999,999 (31:6885, 31:6B2E: record field $58 is a 3-byte EXP total);
  - a full party heal (12:64F8) and item equipping into record field $A4 (16:4A48);
  - the AI damage estimate (ATK - DEF/2)/2 per foe (30:4C63) and the weakest-target pick (39:6D89);
  - map links and visited-screen bitmaps (11:4268, A1:4435, A1:58BA);
  - gold-gated events (12:7934, 12:79A7);
  - key generation (12:6955, 60:6916);
  - the 1bpp glyph expansion (00:30A1);
  - the boot-time RAM clear (00:08D0). It also clears SRAM banks 0 and 2; when it runs relative to the save check is not yet traced.
- **Likely slip.** 05:6494 (now FoeHPCheckReadsWrongSlot) loops three times with `dec b` but never `inc c`, so it tests the first foe slot three times. Executed and extended in E-0154.
- **Data.** 3D:4E56, 3E:7615 and 92:5827 are pointer tables decoded as code; left unnamed.
- Binary verification: build/run83 PASS, 0 differing bytes.

### E-0126 — Misdecoded tables fixed; leftover entry points named

- Kind: DECISION (generator rules and data layouts) + OBSERVATION (reading; C1).
- **Structured code tables.** `config/tables.json` now describes two bank-$36 pointer tables, so they decode at word alignment:
  - `EffectHandlerTable` (36:7DDE, 40 entries, read by RunEffectHandlerForActionId);
  - `ActionEffectTable` (36:6726, 240 entries, read by DispatchActionEffectTable).
- **What the misalignment had caused.** False entries at 00:1350/1355/1362 and 36:7850/7872. It had also hidden 35 effect routines, which are now named `ActionEffect_<skill>` from the skill string database, as in E-0084.
- **Table trimming.** A new `trim_tables` pass cuts an inline `rst $00` table at the first word that is also a routine entry found later, then traces that address as code. Example: 12:55F8, which two routines call, was emitted as `dw $44FA` plus `db` bytes; it now decodes as `ld a, [wCC44] …` (StartReturnWarpByFlag25). Test: `tests/test_generated_source.py::InlineTableTrim`.
- **Data regions.** Ten ranges are now proven data:
  - sprite frame records (3D:4E3D, 3E:7615, 3E:675A, 92:5805);
  - bytes before compressed streams (7A:4001);
  - byte tables (E0:55BF, 36:6A59);
  - tile map bytes (1E:44EF);
  - the personality weight table at 30:5587;
  - map words in bank $0A (0A:61FB).
  The pointer-table scan or the follows-a-terminator guess had made code entries from them.
- **Names.** About 55 fall-through and mid-routine entry points are named (StartThreeSoundTracks and StartTwoSoundTracks, which rely on StartSound returning A + 1; TryAddSkillIfPrerequisitesKnown …). Unnamed routines: 391 to 316.
- Binary verification: build/run88 PASS, 0 differing bytes; 142 tests OK (3 skipped).

### E-0127 — Routines of 46-60 instructions

- Kind: OBSERVATION (full reading; C1).
- **What is named.** About 120 routines of 46-60 instructions are named; the unnamed count goes from 316 to 191. These include:
  - level-up stat gains, their 999 cap and their application (1A:6418, 1A:6587, 31:6A2D, 31:6BCA), and the next-level EXP check (31:6D28);
  - the AI mode taken from INT (19:4298: modes 0-4 below 30, 100, 550, 900, or more);
  - the AI's highest-weight action choice (30:4C00);
  - save checksum verification (02:760B) and the record backup to SRAM bank 1 (02:741B);
  - party stat-total events (12:7693, 12:76F1, 12:774F) and the repeated-digit HP event (12:7B45);
  - child resistance rolls for breeding (0E:5CB2) and the resistance refresh from species (0E:5C50);
  - key-world monster selection (60:4698, 60:4724).
- Field $57 is read as the level cap next to field $56 (31:6D28, 03:4ACE). C1.
- Binary verification: build/run89 PASS, 0 differing bytes; tests OK.

### E-0128 — Routines of 61-80 instructions

- Kind: OBSERVATION (full reading; C1).
- **What is named.** 67 routines of 61-80 instructions are named; the unnamed count goes from 191 to 120. These include:
  - the map header loader (00:1C0C) and the species-to-family ranges (0E:615A);
  - the periodic town event checks (12:75E0) and their digit and gold events (12:77AC, 12:79DC, 12:7A4D, 12:7AD0);
  - inventory sorting (16:590C);
  - DEF and AGL buffs, a third of base or half for actions $25/$29 (36:5360, 36:5441);
  - MP cost payment (32:5397) and the link-rule violation check (32:55EE);
  - record restore from the SRAM bank-1 backup (02:71ED);
  - link transfer steps (00:0535, 1B:468A, 1B:4736).
- 32:4C9C is named mechanically (RollStatusTickEffect): which status it serves is not established.
- Binary verification: build/run90 PASS, 0 differing bytes; tests OK.

### E-0129 — Routines of 81-100 instructions; record stat fields

- Kind: OBSERVATION (full reading; C1).
- **What is named.** 47 routines of 81-100 instructions are named; the unnamed count goes from 120 to 72. These include:
  - the field entry routine (02:4628 InitFieldScreen) and the sprite slot drawer (04:44CE);
  - the AI scoring entry for table A (30:4AD3) and the healing effect (36:5223);
  - the SRAM bank-1 record checksum (02:737F) and the title-screen save summary (16:75EE);
  - link record unpacking (37:5BC6);
  - the voicing-mark toggle for name entry (14:60E6).
- **Record stat words.** Fields $5D, $61, $63, $65, $67, $69 are max HP, max MP, ATK, DEF, AGL and INT. Evidence: the level-up gains in 1A:6587 and 31:6A2D walk them in that order, and 73:4956 lists the same six. C1.
- **85:5D7C to 5DB9.** This range is data. Its false code entry covered $5DB9, which Talk00FC_YouHaveToEat far-calls (`ld hl, $5DB9 / ld b, $85 / rst $10`). With a new data region in `config/data_regions.json`, $5DB9 decodes as AddHundredToPartyINTCapped999: INT + 100, capped at 999, after the "eat your vegetables" talk.
- Binary verification: build/run91 PASS, 0 differing bytes; tests OK.

### E-0130 — Routines of 101-140 instructions; two more data artifacts

- Kind: OBSERVATION (full reading; C1) + DECISION (data regions).
- **What is named.** 40 routines of 101-140 instructions are named. These include:
  - the field menu and idle party window (02:64E5, 02:66CC);
  - map screen chunk loading (00:1906);
  - Super Game Boy border sets (00:13E5);
  - the step counter that updates stored records every 100 steps (0A:561E);
  - key-world object placement (60:53E5, 60:54BB, 61:58BC);
  - the battle effect animation (3A:4ADB).
- **Data regions.**
  - 07:5149-5163 is the head of tile-map data; it had been decoded as code ending in `jp ROMEntryPoint`.
  - 32:5078-50B7 is a byte list of action ids. Its consecutive ids $40-$4A had been read as five code pointers, giving the false entries 32:4140, 4342, 4544, 4746 and 4A49, all inside the animation data named by Data_032_40A6.
- Unnamed routines: 72 to 25.
- Binary verification: build/run92 PASS, 0 differing bytes; tests OK.

### E-0131 — Last 25 routines; no address-only routine names remain

- Kind: OBSERVATION (full reading; C1).
- **What is named.** The last 25 routines (141-599 instructions) are named. These include:
  - BootAndMainLoop (00:0150);
  - breeding (0E:5688 ComputeBreedingChild);
  - skill learning (1A:5FA7, 1A:60F1);
  - record packing to SRAM bank 1 (1D:6E39, 1D:7492);
  - warps (11:4130), the encounter timer (0A:43EC) and the wild level from party strength (A0:46CC);
  - the title-screen save summary (16:7783).
- **Measured state.** `tools/rank_unnamed.py` reports 0 routines with only an address name. All 22,058 `call`/`farcall` operands reach a named routine.
- **Limits.**
  - Most names are C1 readings. Many describe mechanics (which RAM is read and written) rather than game meaning, for example `LoadWC969TripleForWCD05` and `RunFunc5925At0280`.
  - RAM operands are still mostly address names (`wC52B`).
  - About 1.2 MB of INCBIN data is not interpreted.
  - These are the next readability fronts.
- Binary verification: build/run93 PASS, SHA-256 8e38a742...766d4e, 0 differing bytes; tests: see the commit.

### E-0132 — RAM naming begins: HRAM, buffers, constants

- Kind: OBSERVATION (reading; C1) + DECISION (generator rules).
- **Measure.** `tools/rank_unnamed.py --ram` counts RAM operands that still use an address name (`wXXXX`, `hFFXX`, `sXXXX`). Baseline: 1,611 addresses, 31,337 uses.
- **Constants, not addresses.** `ld hl, $FFF0` / `$FF80` / `$FFF8` / `$FF70`, when immediately split with `ld a, l` into hFF9B or hFF9D, are step deltas (-16, -128, -8, -144), not HRAM or `rSVBK`. The generator now keeps them numeric, and `SymbolicOperands` accepts them.
- **Named buffers.** A `config/symbols.json` entry may carry a `size`. Addresses inside it render as `Name + $offset` unless they have their own name. New buffers:
  - wShadowOAM ($C000, $A0);
  - wScreenTileBuffer ($C198, $240, the size of its clear);
  - wBGPaletteCopy ($C0F0);
  - the message text slots wTextBuf0-3 ($C130-$C16F) and wTextNumber ($C17E).
- **HRAM (70 names).**
  - Player movement: hPlayerStateFlags, hPlayerTurnDelay, hPlayerStepDX/DY.
  - Player sprite override and its timer.
  - Window position (hWindowX/Y, copied to rWX/rWY).
  - Metasprite builder temporaries, decompressor header bytes, and the general argument bytes hTemp0-hTempA ($FFC6-$FFD0).
  - The sound engine's 32-byte channel copy at $FFD8 (each slot is copied in and out by SoundTick); fields are named from the track commands that set them ($A0-$AC, $Cx, $Dx/$Ex).
- Result: 1,313 address-named RAM addresses remain (26,306 uses).
- Binary verification: build/run94 PASS, 0 differing bytes; tests OK.

### E-0133 — WRAM $C000-$C8C7

- Kind: OBSERVATION (reading; C1).
- **What is named.** About 220 names and buffers. These include:
  - the VBlank BG/attribute write queues (FlushQueuedBGMapWrite);
  - the map header bytes after wMaxBlockingTile;
  - menu state and cursors;
  - the text engine (window address, rows and width; string position; text cursor; yes/no result);
  - palette upload requests, the fade state and the DMG palette bytes;
  - Super Game Boy palette set and attribute file;
  - the link state (role, mode, transfer pointer and count, send byte, timeouts);
  - the random value (wRandomLo/Hi) and the second stream;
  - the debug-screen variables;
  - the save block (wPlayerName, wInventory with $18 slots, wItemStorage of 100 entries, wPartyCount, wPartyList, wKeyList, wKeySeeds);
  - save and field transition steps.
- **wWindowTileBuffer.** $C300-$C467 is a 20 x 18 window buffer: menus and boxes are drawn into it with 20-byte rows (the two-choice box at +$112), and it ends right before wFieldActionRequest.
- **Limits.** Names marked as bank-$F0 or link "Byte" entries are mechanical: what they mean is not yet read.
- Result: 1,004 address-named RAM addresses remain (19,217 uses).
- Binary verification: build/run95 PASS, 0 differing bytes; tests OK.

### E-0134 — WRAM $C8C8-$CC4F

- Kind: OBSERVATION (reading; C1).
- **What is named.**
  - Warp destination; text window and party-window state; trigger entry.
  - Encounter rate and countdown; battle intro and transition; field event kind.
  - Talk event group and index; script return position; the object-step pointer and target (wStepPtr/wStepTarget).
  - Pending field event (wPendingFieldEvent) and the saved player state.
  - Formation choices; key-world slot, area, level and objects; map type (wMapType).
- **Buffers.**
  - Three $A5-byte monster records in the SRAM record format: wRecordBufA, wRecordBufB (the breeding parents and link records) and wChildRecord.
  - The field objects wObject1-5 (16-byte entries after wSpriteSlots).
  - wStoryFlags ($CBD7, $6B bytes): TestFlagBit adds flag / 8 to $CBD7, and this is the second save block.
- Result: 691 address-named RAM addresses remain (14,424 uses).
- Binary verification: build/run96 PASS, 0 differing bytes; tests OK.

### E-0135 — WRAM $CC49-$CFFF

- Kind: OBSERVATION (reading; C1).
- **What is named.**
  - The key-world state: random value (wKeyRandomLo/Hi, from NextRandomSeed), size, band, monster tables, areas, objects, encounters, and the visited-screen bitmap.
  - The $D8-byte block saved separately (from $CE9B): timer bytes, a family bit array and its count, 11 family scores and their ranking.
  - The name-entry screen (state, cursor, entered text with voicing marks).
  - wBattleKind; the battle command and list paging bytes; the encounter entry and wild level/band.
  - The record buffers as sized symbols (wMonsterId, wRecordBuffer, wRecordBufferData).
- **Limits.** The $CE9B block and its timer are named by structure only: which game feature uses them (game mode 2 and the bank-$F0 screens) is not read.
- Result: 515 address-named RAM addresses remain (12,425 uses); all of $C000-$CFFF and HRAM is named.
- Binary verification: build/run97 PASS, 0 differing bytes; tests OK.

### E-0136 — WRAM $D000-$D7FF

- Kind: OBSERVATION (reading; C1).
- **Bank 2 and bank 1 share these addresses.**
  - On CGB the code switches rSVBK to 2 before it touches the attribute buffers.
  - Those buffers mirror the tile buffers at a fixed offset of $E68: wScreenAttrBuffer at $D000 (for wScreenTileBuffer $C198), wWindowAttrBuffer at $D168 (for $C300), and wSavedScreenAttrs at $D2D0.
  - In WRAM bank 1 the same addresses hold the species and item records, the shared work area wWorkBuf, and the six $4E-byte battler records.
- **Generator change.** A symbol may carry `"of": "<base>"` instead of a name.
  - The address then renders as `<base name> + $offset`, whatever sized buffer it also falls in.
  - The attribute positions use this (for example $D1CC becomes wWindowAttrBuffer + $64, matching wWindowTileBuffer + $64).
  - Test: BufferOffsetAliases.
- **What is named.**
  - **Bank-1 records and title data:** each battler record as a sized symbol (wBattlerRecords and wBattlerRecordSlot1-6), so record fields read as `slot + $offset`. The title-screen save summary that LoadSaveFileSummary writes over battler record 0.
  - **Link and battle state:** the link rule bytes, the link screen state (wLinkScreenState/SubState), and the item-effect fields of the item record. The level-up gains, the AI weights, and the battle-end timer.
  - **The $D780 screen work area:** state, step, sub-step and counter, the list, page and grid cursors, the cursor blink counters, the digit editors, and the argument bytes wArg1-wArg8 that many helpers pass values in.
- **Limits.**
  - Names in the $D780 area describe the role each byte plays in the routines read. Many script-command screens reuse these bytes, so several names stay generic (wScreenByteXX).
  - The arena bytes ($D580-$D5B1) are named by their writers only.
  - Each address keeps one name for every bank and context. Where bank-1 and bank-2 uses collide, the name follows the bank-1 use unless an `of` entry or an exact name says otherwise.
- Result: 236 address-named RAM addresses remain (2,793 uses).
- Binary verification: build/run136 PASS, 0 differing bytes; tests OK.

### E-0137 — WRAM $D800-$DFFF, SRAM, and immediates that are not addresses

- Kind: OBSERVATION (reading; C1). The SRAM save layout is C2: it follows from the copy routine's block list and its sizes.
- **Battle RAM.**
  - The effect animation state ($D800-$D807).
  - The 9-byte status records: wBattleStatus, with status bytes 1-8 as array bases (stride 9).
  - The damage word (wBattleDamageHi), the action queue, the turn counter, and the 16-bit battle meter (capped at 1800).
  - The per-slot arrays: level, tactic (3 = manual command), AI mode, control bits, skills, and the 7-byte resistance records.
  - The AI choice weights, the EXP award, and the message bytes wResolveMsg*.
  - The existing per-slot stat arrays are now sized, so byte offsets read as `wBattleHP + $2`.
- **Sound engine.** The five channel slots after wSoundChannelSlots ($20 bytes each), the current channel's register base, and the engine mode and state bytes. Most sound-engine bytes are still named by their readers only.
- **SRAM.**
  - The $A5-byte records at sRecords, the compact $6F-byte records, the backup, and the checksums.
  - The save block at sSaveData ($BB01) is hFF8A ($0E bytes), wPlayerName ($291), wStoryFlags ($6B), and wKeyWorldSlot ($B5), copied in that order, $3BF bytes in all, ending at $BEC0 where the $D8-byte block goes.
  - Each SRAM byte the code reads is named after the WRAM variable it saves; for example, sBD36 is the saved wCurrentKeyIndex.
- **Immediates that are not addresses** (generator rule plus SymbolicOperands and NumericArguments tests). These now stay numeric:
  - `ld hl, n` (or `ld l, n`) / `ld bc, n` pairs that go into the routines that store L/H/C/B into wResolveMsgActor/Target/Flags/Arg. These pairs carry message bytes and had been shown as fake SRAM or VRAM names, such as `ld hl, sB58E` / `ld bc, vTiles0 + $A8`.
  - `ld de, n` before a call to StepSpriteSlotToward*: DE is a (y, x) screen position, such as `$A070`.
- Result: no RAM operand is left with only an address name (tools/rank_unnamed.py --ram reports 0).
- **Limits.** Many names here are role names (wBattleTemp7A, wEffectByte06, wScreenByteB2): they say which routines use the byte, not what it means in the game.
- Binary verification: build/run137 PASS, 0 differing bytes; tests OK.

### E-0138 — Monster asset streams named by monster

- Kind: OBSERVATION (C1 for the names; the table links are C1 from E-0041).
- **Source.** MonsterPictureTable (38:4001), MonsterAttributeMapTable (38:447E), and MonsterSpriteTable (04:4EAA) are indexed by monster id.
- **Name lookup.** The monster name comes from the routine CopyMonsterNameOfWDAABSlotToDE reads with:
  - ids below $100: StringTable_MonsterNames (08:4258);
  - ids from $100 to $1FF: StringTable_MonsterNames2 (08:4458), indexed by the low byte.
- **What changed.**
  - Each distinct stream or attribute map is named `MonsterPic_<Name>`, `MonsterPicAttr_<Name>` or `MonsterSprite_<Name>`, after the first non-zero id that points to it. 864 data labels in all.
  - The generator appends the monster name to the `; id N` comment of tables marked `"id_names": "monster"` in config/tables.json (the three tables above and MonsterPaletteTable).
- **Limits.**
  - Many unused ids point to the DrakSlime stream; its note gives the count of those ids.
  - MonsterSpriteTable id $17F points to 8C:5347, which has no data label and no name, so it stays unnamed.
  - MonsterTable (592 records) is not marked: the mapping from its ids above $1FF to names is not read.
- Binary verification: build/run138 PASS, 0 differing bytes; tests OK.

### E-0139 — Key-world tilesets and palettes; palette words

- Kind: OBSERVATION (reading plus decoding; C1).
- **Source.** LoadKeyWorldTilesetAndHeader (61:43CF, case 0 of RunWCC44Type_420D) computes HL = $5728 + 6 * wKeyWorldGoalKind (with `add a, $28` / `adc a, $57`, so no pointer to $5728 appears in the ROM) and reads two far pointers:
  - the first goes to DecompressToVRAM with destination vTiles2;
  - the second goes to CopyFromBank ($40 bytes to wBGPaletteBuffer) on CGB.
- **Checks.** The 10 entries ($5728-$5763) were decoded with tools/lzss_gfx.py:
  - every tile stream decodes to exactly 2048 bytes (128 tiles) with no unwritten reads;
  - every palette set is 32 words with bit 15 clear.
  - Before this, the generator had decoded these bytes as code-adjacent `db` and bogus `dw Data_061_*` pointers.
- **What changed.**
  - config/tables.json declares KeyWorldTilesetTable and the ten 8-palette tables KeyWorldPalettes0-9.
  - The tile streams are named KeyWorldTiles0-9.
  - A pointer field marked `"stream": true` now registers its target as a compressed stream (a fifth stream source in tools/disasm_all.py).
  - A new field type `words` prints little-endian words; MonsterPaletteTable uses it too, so its colours read as BGR555 `dw` values.
- **Limits.** Which key-world kind each entry belongs to (the meaning of wKeyWorldGoalKind 0-9) is not read.
- Binary verification: build/run139 PASS, 0 differing bytes; tests OK.

### E-0140 — Map type 5 tilesets and palettes

- Kind: OBSERVATION (reading plus decoding; C1).
- **Source.** LoadMapType5TilesetAndHeader (61:4261, case 5 of RunWCC44Type_420D) indexes Data_061_42DD by 6 * byte 2 of the floor's wKeyWorldFloorState entry. Like LoadKeyWorldTilesetAndHeader (E-0139), it reads two far pointers:
  - compressed tiles, decompressed to vTiles2;
  - $40 bytes of CGB palettes, copied to wBGPaletteBuffer.
- **Checks.** Entries 0-11 decode to 2048-byte tile sets with 15-bit palettes. Entry 12 onward gives nonsense pointers (for example bank $CD), so the table holds 12 records.
- **What changed.** MapType5TilesetTable, MapType5Palettes0-11 and MapType5Tiles0-11 are declared (tables.json, names.json). This adds 12 streams the stream finders had missed.
- **Limits.** Which places use map type 5 is not read.
- Binary verification: build/run140 PASS, 0 differing bytes; tests OK.

### E-0141 — Key-world rooms in bank $72; `dfar` far pointers

- Kind: OBSERVATION (reading plus decoding; C1).
- **Source.** Func_061_4472_Case05 (61:4533) takes a room number from wKeyWorldRoomTable and reads the word at 72:$4001 + 2 * room with ReadByteInBank.
  - It skips 3 bytes and adds 12 * hMapScreenY + 3 * hMapScreenX.
  - It decompresses that far pointer into wScreenTileBuffer.
  - On CGB, it decompresses the far pointer $30 bytes further on as the attribute map.
- **Layout.** A room record is therefore a 3-byte header, 16 tile-map far pointers (a 4 x 4 grid of screens), and 16 attribute-map far pointers: $63 bytes.
- **Checks.**
  - KeyWorldRoomPointers: 192 words at $4001-$4180, each $0000 or $4181 + $63 * n.
  - KeyWorldRooms: 160 records from $4181 to $7F61.
  - All 5,056 non-zero pointers decode to 360 bytes (20 x 18): 336 distinct streams in banks $6C-$71, 219 of them new to the generator.
  - Before this, the scan had read the table bytes as `dw`/`db` noise.
- **Generator: `dfar`.** A new macro `dfar Label` (`dw Label` / `db BANK(Label)`) prints a far pointer in one line, with the bank taken from the label, so the bytes stay identical.
  - The table renderer uses it wherever a pointer field's bank is the next one-byte field and the target has a label: 6,313 far pointers in all, including the monster asset tables.
- **Limits.** The meaning of the 3-byte room header is not read; the screens are tile maps that are not described further.
- Binary verification: build/run141 PASS, 0 differing bytes; tests OK.

### E-0142 — Map records, screen arrays and palettes derived from MapTable

- Kind: OBSERVATION (reading of LoadMapHeader 00:1C0C and LoadMapScreen 00:19A9, plus decoding; C1).
- **Record layout.** A bank-$11 map record is:
  - +0: far pointer to the tileset stream (decompressed to vTiles2);
  - +3: far pointer to the $40-byte BG palette set (LoadBGPaletteBufferFromBank);
  - +6 to +$0F: width and height in screens, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind, the encounter rate (stored OR $80), wMapMoveType, wMapSpriteKind, and two bytes LoadMapHeader reads depending on wMapSpriteKind;
  - +$10: the RAM address of a flag byte;
  - +$12 onward: 6-byte variants, each a far pointer to a tile-map array and one to an attribute-map array. LoadMapScreen starts at +$42 and steps back 6 bytes for each clear bit of the flag byte from bit 7, so the highest set bit picks variant 1-8 and no bit picks variant 0.
- **Screen arrays.** An array holds width * height far pointers. LoadMapScreen indexes it with 3 * (hMapScreenY * width + hMapScreenX) and decompresses the screen into wScreenTileBuffer (or, for attributes, into wScreenAttrBuffer).
- **Generator.** add_map_schemas in tools/disasm_all.py derives the layouts from MapTable instead of listing them in config.
  - A record ends where the next one starts; the last ends at MapWarpTable.
  - Leading variants are kept while both of their arrays decode completely to 360-byte screens. Later bytes stay `db`, because some records carry bytes that do not decode as variants.
  - Overlapping arrays and palette sets are skipped.
  - Results: 183 records, 446 arrays, 135 palette sets, and 844 screen streams the stream finders had missed.
  - Labels:
    - MapRecordNN, MapNNTileset, MapNNPalettes;
    - MapNNScreensK / MapNNAttrsK, named after the first map number using them.
  - The variant flag address prints as a RAM symbol through a new `ram` option of the `words` field.
- **Findings.**
  - The "20x18 grids of unknown meaning" in banks $4A-$4D (PROJECT_STATUS) are compressed map screens.
  - Unidentified INCBIN data fell to 405,041 bytes, from 609,917 before E-0139 (727,264 bytes are now in known streams).
- **Limits.**
  - Which flag byte values occur, and therefore which variants are reachable, is not read.
  - The two conditional header bytes and wMapHeaderByte7 are named by their stores only.
- Binary verification: build/run142 PASS, 0 differing bytes; tests OK.

### E-0143 — Field sprite graphics and the sprite palettes

- Kind: OBSERVATION (reading of DecompressGraphicsHFFC6ToHFFCA 04:431F, plus decoding; C1).
- **Graphics.** With hFFC8 non-zero, the routine reads the word $43AC + 2 * graphics number in bank $04 and decompresses it from bank $7D, or from bank $7E for numbers $50 and up.
  - The 98 words decode as streams; the word after them does not.
  - The generator had shown these bytes as an INCBIN slice and stray `dw`s, one of them a message label.
- **Palettes (on CGB).**
  - Monster sprites (hFFC8 = 0): the 8 bytes at 27:$7328 + 8 * monster id.
  - Field sprites: the 8 bytes at 7E:$4B15 + 8 * (the byte at 04:$4A46 + number). The index bytes take values 0-20.
  - Either way the palette goes to wOBJPaletteBuffer + 8 * hFFC9.
- **What changed.**
  - FieldSpriteGraphicsTable ($00-$4F) and FieldSpriteGraphicsTable50 ($50-$61) are declared. A new pointer option `target_bank` gives a fixed target bank.
  - Also declared: FieldSpritePaletteIndex, FieldSpritePalettes (21) and MonsterSpritePalettes (384, with monster names).
  - The streams are named FieldSpriteGfxNN.
  - The DecompressCallSites test now accepts named stream labels.
- **Limits.** Which character each field sprite number shows is not read.
- Binary verification: build/run143 PASS, 0 differing bytes; tests OK.

### E-0144 — Special map records

- Kind: OBSERVATION (reading of LoadSpecialMapHeader 00:1BAD and LoadMapScreenFromChunk 00:1906, plus decoding; C1).
- **Layout.** Both routines map bank $61 and read the word $60D8 + 2 * hFFC6.
  - SpecialMapTable has 128 words; 91 are zero and the rest point to 35 contiguous 26-byte records at $61D8-$6565.
  - A record is: tileset far pointer (decompressed to vTiles2), palette far pointer (LoadBGPaletteBufferFromBank), five header bytes (width, height, wMaxBlockingTile, wMapHeaderByte7, wFieldEventKind), nine bytes these routines do not read, then the far pointers to the screen array (+$14) and the attribute array (+$17). LoadMapScreenFromChunk indexes the arrays the same way as LoadMapScreen (E-0142).
- **Checks.** All 70 arrays decode to 360-byte screens.
- **What changed.** add_map_schemas now also derives the special map arrays and palette sets: 514 arrays and 165 palette sets in all, and 100 more screen streams. The labels are SpecialMapNNScreens/Attrs/Palettes/Tileset.
- **Limits.** The nine unread header bytes (they look like further far pointers to bank $80) are left as `db`.
- Binary verification: build/run144 PASS, 0 differing bytes; tests OK.

### E-0145 — Battle effect graphics, area graphics, script screen animations

- Kind: OBSERVATION (reading plus decoding; C1).
- **BattleEffectGraphicsTable (3A:52B9).** DecompressGraphicsAToTiles0 decompresses the far pointer at $52B9 + 3 * A to vTiles0. All 60 entries decode, and the streams are named BattleEffectGfxNN. These $B4 bytes had been an INCBIN slice.
- **AreaTilesetTable / AreaPaletteTable (1D:5D78 / 1D:5D7E).** LoadAreaGraphicsForWD7FC indexes both with 3 * wAreaGraphicsIndex. Two tile streams and two $40-byte palette sets (AreaPalettes0-1) are valid; the third tile entry would run into the palette table.
- **ScreenAnimationTable (85:4E7A).** ScriptCommand79_Run_Case01 takes 8 * wScriptParam1 + 4 * (wScriptParam0 & 1) and decompresses two words from bank $93: a tile map to wScreenTileBuffer and an attribute map to wScreenAttrBuffer, alternating the two frames over four steps. Six entries decode to 360-byte screens, which registers 5 new streams.
- **Generator.** Derived map layouts now give way to layouts already in config/tables.json. Map00Palettes at 48:4001 is AreaPalettes0.
- Binary verification: build/run145 PASS, 0 differing bytes; tests OK.

### E-0146 — Key-world chunk groups

- Kind: OBSERVATION (reading of RunRandomPatternCase_Case00-02 (bank $60) and Func_061_4472_Case00 (61:5443), plus decoding; C1).
- **The lists.** The key-world generator picks entry (random & $1F) of far-pointer lists at 60:$610D, $616D and $61E5 and stores the far pointer in the area data (StoreThreeBytesBeforeHFFC6Pointer). The lists run on to $62F8: 164 far pointers to 88 chunk groups in banks $67 and $68.
- **The groups.** Func_061_4472_Case00 reads the stored far pointer and adds $60 * the area's sub-chunk byte, then 12 * (hMapScreenY & 3) + 3 * (hMapScreenX & 3).
  - It reads a far pointer there, skips 8 bytes, and decompresses the rest into wScreenTileBuffer.
  - On CGB it decompresses the far pointer $30 bytes later into wScreenAttrBuffer.
  - A group of n sub-chunks is therefore n * $60 bytes of these grids followed by n bytes. The generator reads +$60 (one sub-chunk) or +$C0/$C1 (two).
  - In every group the trailing bytes are a permutation of 0..n-1; that fixes the size of the last group in each bank (6 and 9).
- **Checks.** All 88 groups (n = 1, 2, 3, 4, 6, 9) validate: every tile map (after its 8-byte header) and every attribute map decodes to 360 bytes.
- **What changed.**
  - config/tables.json declares KeyWorldChunkLists. add_map_schemas derives KeyWorldChunkGroupNN and KeyWorldChunkGroupNNOrder.
  - A pointer option `stream_skip` registers the stream N bytes past the target (488 new streams). The 8-byte headers stay as labelled `db`.
  - A table option `record` replaces the long field-name lists in the `; record:` comment.
- **Limits.** The meaning of the 8-byte screen headers (they look like exit or connection bytes) and of the order bytes is not read.
- Binary verification: build/run146 PASS, 0 differing bytes; tests OK.

### E-0147 — Meta-sprite sets and frames

- Kind: OBSERVATION (reading of DrawMetaSpriteSet_Bank25_Sub01 and its copies, BuildOamFromSpriteTable_*, and DrawMetaSpriteAt; C1).
- **Format.** Every builder takes DE = a word table of sets and reads three levels:
  - the set: the word at DE + 2 * hSpriteSetIndex;
  - the frame: the word at set + 2 * hSpriteSubIndex;
  - the sprites: 4-byte entries (Y offset, X offset, tile, attribute), drawn until a $80 in the Y position (or 40 OAM entries).
- **Tables.**
  - $25, $26, $27 at $401E (128, 128 and 127 sets). Each has an attribute table after it ($411E, $411E, $411C), whose bit 0 enables ORing the high nibble into hSpriteAttrXor.
  - 3B:507C, 3D:4077, 3E:4024, 3F:407E and 92:4024: the tables the BuildOamFromSpriteTable copies receive.
  - 7F:4008 (DrawMetaSprite4008) and 7F:7011 (DrawMetaSprite).
  - The counts run to the code or table that follows each table.
- **Generator.** add_metasprite_schemas derives, under tables marked `"metasprite"`:
  - each set's frame-pointer list, which ends where its first frame begins;
  - each frame: rows of 4 bytes, one per line, plus the $80 terminator, through a new table option `tail`;
  - a new field option `line` puts each row on its own `db` line.
  - Results: 512 sets and 3,397 frames. Later (build/run171) frames of up to 127 sprites are accepted: the builders stop drawing at 40 OAM entries, but 49 frames hold 40 or more sprites before their $80, which the first limit had rejected (3,447 frames).
  - Sets are labelled `<table>SetNN`, numbered by the first set index that uses them, and frames `<table>SetNNFrameK`.
- **Effect.** Unidentified INCBIN fell from 284,366 to 197,278 bytes.
- **Limits.** Which monster or object each set draws is not read (banks $25-$27 hold 383 sets, close to the 384 monster sprites, but no mapping was checked).
- Binary verification: build/run147 PASS, 0 differing bytes; tests OK.

### E-0148 — The EXP table

- Kind: OBSERVATION (reading of LoadTable4E60EntryForWC991ToWC9DE 19:73A2 and its twin, plus a value check; C1).
- **Source.** The routine loads the species record, multiplies species byte 7 by $129, adds 3 * (level - 1) and $4E60, and copies 3 bytes to the record's EXP field (+$58). $129 = 99 * 3, one 24-bit value per level. RecordReachedNextLevelExp and DrawWCA83ExpAndToNextLevel read the same table through a 3-byte copy helper.
- **Checks.** The $2520-byte slice at 19:4E60 is exactly 32 rows. Every row starts at 0 and rises; for example row 0 ends at 1,521,048 and row 31 at 7,198,692.
- **What changed.**
  - ExpTable is declared with a new `u24` field type, printed through a new `d24` macro (`db LOW(x), HIGH(x), LOW(x >> 16)`) in decimal.
  - wSpeciesExpCurve names species record byte 7 ($D00F).
- **Limits.** Which EXP curve each species uses is data in the species records; the curves' game-facing names are not known.
- Binary verification: build/run148 PASS, 0 differing bytes; tests OK.

### E-0149 — The AI personality weight table (bank $06)

- Kind: OBSERVATION (reading of ReadBank6TableWord E2:654B and AccumulateBank6WordToDA6E / DA70; C1).
- **Source.** The word at 06:$4001 + $36 * BC + 2 * wPersonalityIndex is added to an AI score. A low byte of $FF counts as 5000, and a negative word is subtracted.
  - The rows are 27 words, one per personality index.
  - The 527 call sites pass rows $00-$D3.
  - The bank holds only zeros after row $D3 ($6CB9), so the table has 212 rows.
- **What changed.** AIPersonalityWeightTable is declared, with a new `per_line` option for word fields (9 words per line, 3 lines per row). This ~11 KB had been INCBIN slices.
- **Limits.** What each row number means (the situation an AI routine scores) is known only through its callers' names (AIScore_*).
- Binary verification: build/run149 PASS, 0 differing bytes; tests OK.

### E-0150 — Super Game Boy border streams

- Kind: OBSERVATION (reading of LoadSGBBorderForSetA 00:13E5 and SGBTransferCompressed 00:06A8, plus decoding; C1).
- **Source.** For each of five border sets, LoadSGBBorderForSetA calls SGBTransferCompressed three times with A = packet set $10, $11, $0F.
  - It loads the stream address as separate `ld e` / `ld d` immediates and the bank with `ld b`.
  - SGBTransferCompressed clears vTiles1 ($1000 bytes), decompresses the stream there and sends it with SendSGBPacketSet.
- **Checks.**
  - The 4096-byte streams read output positions before writing them. With the cleared buffer those reads are zeros, so the streams are valid only under that condition.
  - The sizes (4096, 4096, $880) match two CHR_TRN tile halves and a PCT_TRN map with palettes (Pan Docs SGB command layout; the packet contents were not decoded).
- **What changed.**
  - SGBTransferCompressed counts as a decompress routine.
  - The literal-argument stream finder combines split `ld e`/`ld d` loads.
  - Streams found at SGBTransferCompressed calls may read their zero-filled destination; their note says "into a zero-filled buffer" and the CompressedAssetNotes test accepts them.
  - 10 more streams in all. The 15 border streams are named SGBBorderN{TilesA,TilesB,MapAndPalettes}.
  - The split loads print as `ld e, LOW(Label)` / `ld d, HIGH(Label)` / `ld b, BANK(Label)`, with the same bytes.
- **Limits.** The streams that BootAndMainLoop sends through SGBTransferCompressed (SGB system data) are not named.
- Binary verification: build/run150 PASS, 0 differing bytes; tests OK.

### E-0151 — A second EXP table (bank $81) and map-screen flag tiles

- Kind: OBSERVATION (reading plus a value check; C1).
- **ExpCurveIndex81 / ExpTable81.**
  - LoadTable555DEntryForWD0A6ToWD0EA (81:5453; called from bank $37) reads the row from the byte $5486 + wWorkBuf+9 (215 bytes, values 0-31).
  - It copies 3 bytes from $555D + $129 * row + 3 * (wLinkMenuEntry - 1) to wLinkMenuEntryBytes.
  - The table at $555D has ExpTable's layout (32 rows of 99 24-bit values) with different values; row 6 is the only one that does not rise throughout.
- **MapScreenFlagTiles (84:4461).** ApplyMapScreenFlagEvents walks 8-byte entries until $FF: map number, screen X, screen Y, tile, story flag number, offset into wScreenTileBuffer.
  - When the map, the screen and the story flag match, ApplyMapScreenFlagEvents_Sub01 writes the tile and tile + 1 at that offset.
  - There are 108 entries.
- Binary verification: build/run151 PASS, 0 differing bytes; tests OK.

### E-0152 — Event scripts in bank $10

- Kind: OBSERVATION (reading of FetchScriptCommand, ScriptOpcodeHandlers and the fetch handlers in bank $10; C2 for the byte grammar, C1 for what the commands do).
- **Grammar.** FetchScriptCommand reads one opcode from the script pointer, in the current bank $10 unless wScriptInDataBank is set. $FF ends the script. The dedicated fetch handlers read these inline bytes:
  - $00, $EA, $F5 (message word): 2;
  - $01, $02: 3;
  - $03, $04, $05: 2;
  - $06 (skip forward by the byte when wTextYesNoResult is 0): 1;
  - $07 (jump to the word): 2;
  - $0A (SetFlagBit): 2;
  - $0B, $0C, $0D: 1;
  - $0E (AddGoldCapped): 2;
  - $0F (music below $60, sound effect from $60, $FF restarts the map music): 1;
  - $E4 (forward offset chosen by wTwoChoiceCursor): 2 for the two-choice menus;
  - $E7 (continue at the word in the data bank): 2.
  - Every other valid opcode only sets the command type: no generic handler or command reads inline bytes (the few that touch the pointer save and restore it around nested talk events).
- **Entry points.** Each `ld hl, n` before a call to StartScriptAtHL_* is an entry, unless wScriptInDataBank is written nearby. There are 392 start sites, and the scripts are in bank $10, not in the bank set in wDataBank. For example, talk event 5/$3B sets wDataBank = $1F, but its script runs at 10:6083; 1F:6083 holds box tiles.
- **What changed.**
  - prepare_scripts traces 2,120 commands in 107 regions and emits them with new macros: script_message, script_skip_if_no, script_jump, script_set_flag, script_add_gold, script_sound, script_choice_jump, script_jump_data_bank, script_op, script_command, script_end. The macros expand to the same bytes; inside a db list `@` is the address of the byte being assembled, which the offset macros account for.
  - Entries and jump targets are labelled Script_XXXX, and callers load them as `ld hl, Script_XXXX`. The wrong wDataBank-based labels at those loads are removed.
- **Limits.**
  - Scripts that run in data-bank mode (reached through $E7 or code that sets wScriptInDataBank) are not traced.
  - Message words are left as numbers, and the command types are not named beyond their handler labels (ScriptCommandXX).
- Binary verification: build/run152 PASS, 0 differing bytes; tests OK.

### E-0153 — Script messages quoted from their text

- Kind: OBSERVATION (reading of ShowMessageHL's 14-way group dispatch plus the E-0080 string tables; C1).
- **Lookup.** message_preview in tools/disasm_all.py resolves a message word on ShowMessageHL's normal path:
  - group = high byte & $3F picks the bank: groups 0-6 → banks $28-$2E, 7 → $2E, 8 → $7C, 9-10 → $80, 11 → $82, 12 → $86, 13 → $89 (from the farcall in each ShowMessageHL_CaseNN);
  - the low byte indexes MessageStrings_BankBB at $4032 (bank $86: its table at $4016);
  - at or above the bank's threshold (the `cp` operand at $4005), the index minus the threshold selects the bank's overflow table;
  - the text is read up to $F0 with the game charmap.
- **What changed.** 724 `script_message` lines (and the $EA/$F5 message variants) end with a comment quoting the first six words of the message, for example `script_message $0031 ; 'Heh, so these are the newcomers?'`.
- **Limits.** Bits 6 and 7 of the high byte (window open/close flags, E-0079) are not shown. The other ShowMessageHL path (wCC44 bit 7 set) is not used for the quotes.
- Binary verification: build/run153 PASS, 0 differing bytes; tests OK.

### E-0154 — The likely game bugs, executed

- Kind: OBSERVATION (execution on tools/sm83.py against the reference ROM; C2 on our emulator, not checked on hardware). Pinned in tests/test_routine_behaviour.py.
- **05:6494 FoeHPCheckReadsWrongSlot** (was FailIfFoeHPBelowFourTimesWD2C1).
  - Besides never advancing C (E-0125), `deref_hl` leaves the estimate's low byte in A, so GetBattleHP_Bank05 reads the HP of the slot numbered by that byte.
  - With estimates of 1: slot 1's HP of 100 gives C = $FF although every foe's HP is 1; slot 1's HP of 2 gives C = $00 although every foe's HP is 100.
  - Test FoeHPCheckReadsWrongSlot.
- **32:4D2C ActorLosesSixthOfMaxHP.** HP 10 with max HP 120 takes damage 20, and HP becomes $FFF6 (no floor). Test SixthOfMaxHPWithoutFloor.
- **00:1CA1 SetFieldEventKindOnMap19IfFlagD1** (was SetWC90DTo0BOnMap19IfFlagD1). With wStoryFlags + $60 = $00 or $FF, wFieldEventKind still becomes $0B, so the `ret nz` never fires. Test Map19StoryByteCheckNeverReturns.
- **82:4016 CopyStringToBuffer_Bank82 (E-0080).**
  - For string $90 the 16-byte destination is unchanged; string $8F, and bank $28's overflow string $DA, are copied.
  - Test Bank82OverflowCopyDoesNotCopy.
- **Already pinned:** 05:6972 (Status4CheckReadsAddress) and 05:4259 (FoeMPCheckOffset).
- **Limits.** Whether these change play depends on callers and on reachable game states, which are not traced. ROM bytes are unchanged; these are observations, not fixes.
- Binary verification: build/run154 PASS, 0 differing bytes; tests OK (now 47 behaviour tests).

### E-0155 — Routine names use the RAM names

- Kind: PROJECT DECISION (mechanical rename; no new semantic claim beyond the RAM names' own evidence).
- **Rule.** In 508 routine and family names, each token WCxxx/WDxxx/HFFxx was replaced by the name of that RAM address (E-0132 to E-0137), without its w/h prefix, and a CamelCase word doubled by the substitution was collapsed. For example:
  - ReadJoypadIntoWC560 now uses the joypad variable's name;
  - SetWDA43AndWDA4BForWCFD4 → SetSlotTacticAndSlotLastTacticForCommandMonster;
  - RemoveCFromWD895Queue → RemoveCFromActionQueue.
- **Safeguards.**
  - Tokens of RAM bytes whose notes say other routines borrow them as scratch (for example wStepPtrLo) are kept as addresses, because the RAM name would mislead there.
  - No collisions arose.
  - The old names are replaced in config/names.json, name_families.json, symbols.json and tables.json notes. The evidence log keeps the names as they were when written.
- **Result.** Of 9,100 code labels, 148 still carry a raw RAM token (borrowed scratch bytes, and addresses inside sized buffers that have no exact name); 5,337 remain structural (Parent_CaseNN / _SubNN / _SharedNN).
- Binary verification: build/run155 PASS, 0 differing bytes; tests OK.

### E-0156 — The skill requirement table (bank $1A)

- Kind: OBSERVATION (byte-level reading of CheckSkillsLearnableAtLevel 1A:5FA7 and BattleEnd_Step3_Sub02_Sub02 1A:62D0; C1 for the field meanings).
- **CheckSkillsLearnableAtLevel.** It walks 18-byte records from $4FF8. It compares the battler's byte at +$17 with the record's byte 0, and its words at +$1D, +$21, +$23, +$25, +$27, +$29 with the record's six words (a borrow rejects the skill).
- **BattleEnd_Step3_Sub02_Sub02.** It compares a skill with bytes 13-17 of all 170 records (it starts at $5005 = $4FF8 + 13, stride 18). On a match it hands the record number to BattleEnd_Step3_Shared01, which looks for it among the eight skills at wRecordBufA + $34.
- **Bounds.** 170 * 18 bytes end exactly at the table at $5BEC (TryAddSkillIfPrerequisitesKnown's lists).
- **Declared.** SkillRequirementTable: a level byte, six stat words in decimal (a new `decimal` option for word fields), and five skill numbers ($FF = none). These 3 KB had been an INCBIN slice.
- **Limits.** Battler record +$17 as the level and +$1D as base HP rest on E-0131/E-0062; the other four words' stats are not named. Record N is taken to be skill N because of the lookup at wRecordBufA + $34, which was not executed.
- Binary verification: build/run156 PASS, 0 differing bytes; tests OK.

### E-0157 — Map interaction spots (bank $87)

- Kind: OBSERVATION (reading of FieldModeStateDispatch_Shared03 87:42A0; C1).
- **Source.** When A is pressed in the field (and no sprite slot answers), the routine reads the word at $4539 + 2 * hMapId (`add $39` / `adc $45`). It walks that list of 10-byte entries until $FF.
- **Entry.**
  - byte 0, kind: 0 skips; 1-4 require hPlayerFacing = kind - 1; 5 matches the tile in front of the player;
  - map number (ignored on special maps);
  - screen X and Y; player X and Y;
  - a story flag word ($FFFF = none; a set flag skips the entry);
  - a talk event group and index for DispatchTalkEvent.
- **Bounds.** The table holds 232 words, up to FieldModeStateDispatch_Shared03_Sub02 at $4709.
- **Generator.** A new `lists` option on pointer tables derives one table per distinct list: records of a given size plus the terminator, labelled MapInteractionsNN after the first map number that uses them. 128 lists, about 3.6 KB that had been INCBIN or bogus `dw`/`db`.
- Binary verification: build/run157 PASS, 0 differing bytes; tests OK.

### E-0158 — The stat growth table (bank $1A)

- Kind: OBSERVATION (reading of 1A:63A7 and 1A:6562; C1).
- **Readers.**
  - StatFromGrowthRow (was SumTable6616RowForTemp0) gives hFFC8/9 = the byte $63F8 + row, plus the sum of the first hFFC7 bytes of row hFFC6 at $6616 + $63 * row. That is the stat of growth row hFFC6 at level hFFC7.
  - ReadStatGrowthGain (was ReadByteTable6616Row) reads one byte of a row for ComputeLevelUpStatGainsForBattleArg1.
- **Bounds.** $C60 bytes = 32 rows of 99 per-level gains. StatGrowthBase holds the 32 starting values.
- **Declared.** StatGrowthTable (11 gains per line) and StatGrowthBase.
- **Limits.**
  - The 32 bytes at 1A:63D8, just before StatGrowthBase, decode as an untraced routine of the same shape that copies one gain into hFFC8/9. It has no caller in the traced code and stays `db`.
  - Which species stat uses which row is data in the species records.
- Binary verification: build/run158 PASS, 0 differing bytes; tests OK.

### E-0159 — Skill prerequisite lists (bank $1A)

- Kind: OBSERVATION (reading of TryAddSkillIfPrerequisitesKnown, 1A:631F; C1).
- **Source.** The routine reads the word $5BEC + 2 * skill. It adds the skill only when every skill of that $FF-terminated list is already among the eight (or equals C).
- **Bounds.** 170 words, one per SkillRequirementTable record, point into $5D40-$5D8A. The lists share tails, for example $5D41 = [2, 3] and $5D42 = [3].
- **Declared.** SkillPrerequisitePointers, and SkillPrerequisiteLists (one byte per line, with each list's label on its first byte).
- Binary verification: build/run159 PASS, 0 differing bytes; tests OK.

### E-0160 — Data-bank scripts reached by $E7

- Kind: OBSERVATION (reading of the start sites plus decoding; C1).
- **Source.** Script opcode $E7 sets wScriptInDataBank = 1 and continues at its word, read through ReadWordFromDataBank, that is, in the bank held in wDataBank. Many StartScriptAtHL_* callers store a bank there just before the call (`ld a, n` / `ld [wDataBank], a`).
- **Rule.** prepare_scripts now records that bank per start site and carries it along the traced script. Each $E7 target is traced as a script in that bank with the same grammar (the data-bank paths of the fetch handlers read the same byte counts).
- **Result.**
  - 10 data-bank entries in banks $10, $15, $1D, $96, $1F and $0C decode cleanly to $FF ends.
  - 2,672 commands in 170 regions, from 2,120 in 107.
  - Labels are Script_BB_XXXX outside bank $10.
  - 38 `script_jump_data_bank` operands now name their target. The other 51 keep the number with a comment, because no caller in the scan window sets wDataBank or the callers disagree.
- **Limits.**
  - Bytes after a `script_choice_jump` that no offset reaches stay `db`. Some menus may have more than two choices, which this reading does not cover.
  - The callers whose wDataBank is set elsewhere are not traced.
- Binary verification: build/run160 PASS, 0 differing bytes; tests OK.

### E-0161 — Tile rectangles from their copiers

- Kind: OBSERVATION (derived from call sites; C1 for the sizes, which come from the code that copies them).
- **Records.** CopyRecordRectToScreenBuffer and its copies read a word offset into wScreenTileBuffer (32-byte rows), a width, a row count, then width * rows tiles from HL. The `ld hl, n` within three instructions before such a call gives 29 records, laid out with the header and one row per line; the note gives the row and column.
- **Raw rectangles.**
  - The copiers CopyRectToBGMap, CopyRectToBGMapWrapped (and its two bank copies), CopyRectTo20ByteRowsJp_Bank24, and every routine with the same first 16 bytes as the CopyRectTo20ByteRows family read a packed rectangle at DE, with B = width and C = rows.
  - Literal `ld de, n` / `ld bc, $WWRR` before such a call give 159 rectangles. When call sites disagree on the width the source is skipped; otherwise the largest row count is used.
  - The copiers that read 32-byte source rows are excluded.
  - CopyRectFromBankToVRAM and CopyRectFromBankToBGMapWrapped also read a packed source. Their bank is A, taken from the `ld a, n` before the call (for example the 20 x 18 screen 5E:4238 of game mode 2), which adds 14 rectangles (173 in all, build/run164).
- **Safety.**
  - A rectangle is used only when it touches no code, table, layout or stream.
  - An inline `dw` whose guessed target label was dropped inside a new layout now prints its number. The one case, 33:41BB `dw $6362`, is tile bytes $62, $63, not a pointer.
- **Labels.** TileRect_BB_AAAA.
- Binary verification: build/run161 PASS, 0 differing bytes; tests OK.

### E-0162 — Data labels name the routines that load them

- Kind: OBSERVATION (cross-reference from the resolved `ld rr, n` data references; no meaning claimed).
- **What changed.** Every data label that code loads by address now has a comment `; address loaded by A, B (and N more)`. The names are the nearest named code label before each loading instruction. 950 labels get one, so each remaining INCBIN slice says where to start reading.
- **Limits.** Pointers held in tables (the `dw` heuristics) are not listed as readers.
- Binary verification: build/run162 PASS, 0 differing bytes; tests OK.

### E-0163 — Map object selectors and object lists (bank $69)

- Kind: OBSERVATION (reading of LoadMapObjectsForScreen 69:4001 plus derivation; C1).
- **Chain.**
  - MapObjectTable ($4174, 228 words, indexed by hMapId) points to a per-screen word array, indexed by 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX); each entry is a selector.
  - A selector is tried entry by entry:
    - flag word (high byte not $FF) + list pointer: use the list when the story flag is clear;
    - $FFFF: no objects;
    - $FFFE + pointer: always use the list;
    - $FFFD + two flags + pointer;
    - $FFFC / $FFFB + flag + two bytes: skip that many bytes when the flag is clear / set.
  - An object list is a count followed by 11 bytes per object. The loader copies them into wSpriteSlots and decompresses each object's graphics (DecompressGraphicsTemp0ToTemp4).
- **Validation.**
  - Screen-array sizes come from the map records (width * height).
  - A selector is kept only when it decodes completely, all its list pointers have a count of 1-40 that fits the bank, and it is not itself a list. Some arrays read past their real size, which this filters out.
  - Results: 291 object lists, 135 screen arrays, 255 selectors.
  - New macros: objsel_none, objsel_list, objsel_unless_flag, objsel_unless_flags, objsel_skip_if_clear, objsel_skip_if_set.
- **Limits.** The 11 object bytes are not named field by field. The second skip byte's role is not read.
- Binary verification: build/run163 PASS, 0 differing bytes; tests OK.

### E-0164 — Palette sources from palette-buffer copies

- Kind: OBSERVATION (derived from call sites; C1).
- **Rule.** These sources are laid out as BGR555 palette tables:
  - CopyFromBank with a literal source (DE), bank (B), destination (HL) in wBGPaletteBuffer/wOBJPaletteBuffer ($C49F-$C51E) and length (C);
  - LoadBGPaletteBufferFromBank (DE, B, $40 bytes);
  - CopyBytesDEToHL_Bank00 into those buffers, which is not matched yet because its family name is assigned after this pass.
  - A source is used only when every word has bit 15 clear and it touches no code or layout.
- **Result.** 5 palette sets (for example 5D:4139 and 5E:422F, loaded for game mode 2), labelled Palettes_BB_AAAA. A sixth candidate, 6E:77E0, was already MapType5Palettes5.
- Binary verification: build/run165 PASS, 0 differing bytes; tests OK.

### E-0165 — Tile bytes that the pointer scan had read as pointers

- Kind: PROJECT DECISION (heuristic cleanup; removes C0 guesses, adds no claim).
- **Problem.** The monotone pointer-table scan had turned runs of tile-map bytes into `dw` pointers, for example 179 × `dw Data_05D_5757` in game mode 2's screens in bank $5D. The words had equal low and high bytes ($5757, $5656, $5858) and alternated with `db` bytes.
- **Rule.** drop_tile_pointer_runs undoes any run that meets all of these:
  - four or more heuristic pointer words, at most 6 bytes apart;
  - at least 60% of them with equal low and high bytes.
  - Target labels that only those words created, with no code reference and no layout or name, are removed.
- **Result.** 336 words go back to bytes and 30 bogus labels are removed. The remaining equal-byte `dw` operands outside such runs fell from 324 to 29.
- Binary verification: build/run166 PASS, 0 differing bytes; tests OK.

### E-0166 — Automap blocks and the key-world screen header

- Kind: OBSERVATION (reading of RunGameMode2State_Case04_Sub01_Sub01, A1:4640; C1).
- **Source.** The game mode 2 map view reads a key-world screen's tile-map far pointer, as Func_061_4472_Case00 does. It then reads the word at bytes 6-7 of the 8-byte header in front of the stream (E-0146), and writes the tile at 5E:$43A0 + 25 * (word - 1) + 5 * row + column to the BG map. So each screen is drawn as a 5 x 5 block, and header bytes 6-7 are its block number.
- **Bounds.** The block numbers in the decoded chunk groups run 1-281, which fits before Map49Tileset ($5F2A). The blocks start right after the 20 x 18 screen TileRect_5E_4238.
  - Some header slots begin with $68 $01, a 360-byte stream's size word. Their words are not block numbers, and those slots were left out of the bound.
- **What changed.** AutomapBlocks (281 blocks, 5 lines of 5 tiles each). The chunk-group record description names the header bytes. About 7 KB of tile bytes are laid out.
- Binary verification: build/run167 PASS, 0 differing bytes; tests OK.

### E-0167 — World map view rectangles (banks $A1/$5D)

- Kind: OBSERVATION (reading of RunGameMode2State_Case01_Sub02, A1:52D4; C1).
- **Source.** For non-special maps, game mode 2 takes the 8-byte entry at A1:$533C + 8 * wGameMode2Byte44: a source address, rows, width, then four bytes. It centres a rectangle of that size with CenteredBGMapOriginForSizeBC and copies it from bank $5D with CopyRectFromBankToVRAM.
- **Declared.**
  - WorldMapViewTable: 11 valid entries. The entry after them is not a record.
  - WorldMapView0-10: rectangles from 8 x 8 to 1 x 2, contiguous from 5D:$41B9 to $43AE, one row per line.
- **Limits.** Byte 4 of each entry ($20, $30, $48, $70, $A0, ...) matches the map-number bands used elsewhere for talk events but is not read here. Which world area each view shows is not read.
- Binary verification: build/run168 PASS, 0 differing bytes; tests OK.

### E-0168 — Uncompressed tile sources

- Kind: OBSERVATION (derived from call sites; C1).
- **Rule.** Literal-argument copies into vTiles ($8000-$97FF) whose length is a multiple of 16 lay out their source as 16-byte tiles, one per line. The copiers are CopyBBytesToVRAMFromDE, CopyCBytesToVRAMWaitSTAT and CopyFromBank.
- **Result.** One source (Tiles_BB_AAAA). Most tile copies take their arguments from tables or registers, so this rule finds little.
- Binary verification: build/run169 PASS, 0 differing bytes; tests OK.

### E-0169 — The text glyph font (bank $1F)

- Kind: OBSERVATION (reading of GlyphCopyArgsForA 1F:5CF8, LoadSixteenGlyphTilesFromTable73BC and CopyGlyphTilesToVRAM; C2 for "glyph number = text byte", because the bit patterns match the charmap).
- **Source.** The glyph copiers take the 16 bytes at 1F:$4010 + 16 * glyph. CopyGlyphTilesToVRAM copies one glyph per byte of a text string. The patterns agree with the charmap (tools/gb_text.py): glyph 0 is a drawn 0, glyph 10 an A, glyph 12 a C.
- **Declared.** GlyphFont: 259 glyphs up to SendSGBPacketSet at $5040, one per line. A new `id_names: "charmap"` option appends the character for each glyph number. About 4 KB of slices and labels inside are now laid out.
- Binary verification: build/run170 PASS, 0 differing bytes; tests OK.

### E-0170 — Special-map interaction lists (bank $87)

- Kind: OBSERVATION (reading of FieldModeStateDispatch_Shared03_Sub01, 87:4507; C1).
- **Source.** On special maps the A-button handler takes its list from FieldModeStateDispatch_Shared03_Sub01 instead of MapInteractionTable:
  - $5D28 for map type $84 (1 entry);
  - $5CA4 for map type $83 when the floor's info byte is 2 (9 entries);
  - $5CFF for map type $83 when it is 3 (4 entries).
  - The entries have the 10-byte format of E-0157.
- Binary verification: build/run172 PASS, 0 differing bytes; tests OK.

### E-0171 — The per-monster argument permutation (bank $F2)

- Kind: OBSERVATION (reading of F2:5181, plus a value check; C1).
- **Source.** PermuteArg5To7ByMonster (was ScriptCommandF6_Run_Case10_Case04_Sub01) reads the 3 bytes at F2:$51C3 + 3 * (wArg2:wArg1). It stores wArg5 + k at wArg1 + byte k, then copies wArg1-3 back to wArg5-7.
- **Checks.** All 384 triples are permutations of 0, 1, 2: 237 are the identity, the rest are the five other orders.
- **Declared.** MonsterArgOrderTable, with monster names in the id comments. Its caller (script command $F6, case $10/4) shows the same id as a monster name (string category 2).
- **Limits.** What the three bytes stand for in that screen is not read.
- Binary verification: build/run173 PASS, 0 differing bytes; tests OK.

### E-0172 — Formations: combined actions and the compatibility roll (bank $A3)

- Kind: OBSERVATION (reading of A3:41CF and A3:44C4; C1).
- **FindFormationForSide** (was SaveActionChoicesAndPickFormations_Sub01) walks FormationTable ($4289), 114 five-byte records up to a 0 byte. Each record holds:
  - the action each of the side's three slots must have chosen ($FF = any);
  - a roll flag;
  - a combined action $D0-$E3.
  - A record applies when the actions match and each required slot can act. It then returns the combined action in hFFC6, after FormationCompatibilityRoll when the flag is 1, or always in link mode 2.
- **FormationCompatibilityRoll** (was ..._Sub01_Sub01).
  - It picks the slot pair from B / 3 and reads PersonalityCompatibility[personality of one][personality of the other] ($45B7, 27 rows of 32), adding 1.
  - It multiplies that by the pair's wSlotTrait sum and by FormationChanceFactors[action - $D0] ($45A3, 20 bytes), then divides by 10, capped at 255.
  - It succeeds when a random 0-99 is below the result.
- **Bounds.** The three tables fill $4289-$4916.
- **Limits.** That these combined actions are the game's combination attacks rests only on the names; which actions they are is in the skill tables, not read here.
- Binary verification: build/run174 PASS, 0 differing bytes; tests OK.

### E-0173 — Effect OBJ palettes and personality/tactic weights

- Kind: OBSERVATION (reading; C1).
- **EffectOBJPalettes (3A:7D9A).** LoadEffectOBJPaletteC copies the 8 bytes at $7D9A + 8 * C to wOBJPaletteBuffer on CGB. 59 whole palettes lie before the label at $7F79.
- **PersonalityTacticWeights (30:5587).** AddPersonalityWeightToBattleArg0 adds the byte $5587 + 4 * wPersonalityIndex + (the actor's wSlotTactic & 3) to wBattleArg0. That gives 27 rows of 4 tactic weights.
- Binary verification: build/run175 PASS, 0 differing bytes; tests OK.

### E-0174 — AI scoring routine tables and heal-skill MP costs

- Kind: OBSERVATION (reading; C1).
- **AIScoreRoutineTableA / B (30:5785, 30:59E0).** ScoreActionsWithAIScoreTableA and UseAIScoreTableB store these addresses as the AI's routine-table pointer, and ScoreSkillForAI far-calls entry 3 * skill. Both are 131 far pointers, all to named AIScore_* routines, now printed as `dfar`.
- **HealSkillMPCosts (05:5A33).** FailIfAllyLacksMPForHealSkill compares an ally's MP with the byte $5A33 + (skill - $16) for skills $16-$1A: 2, 5, 7, 18, 36. The $184 bytes after these five decode as an untraced routine starting `ld a, [wBattleActor]`, which no traced code reaches; they stay data.
- **Generator.** A table whose first data label already carries the table's name (from names.json) prints that name once and keeps the address alias.
- Binary verification: build/run177 PASS, 0 differing bytes; tests OK.

### E-0175 — Configured code entries, and nine routines named

- Kind: OBSERVATION (reading; C1) plus a PROJECT DECISION (the new config file).
- **Configured code entries.** config/code_entries.json lists entry points that no traced code reaches but whose bytes decode as complete routines, and tools/disasm_all.py traces from them.
  - 05:5A38 FailIfAbleAllyKnowsSkillList6D1A. It sits right after the five HealSkillMPCosts bytes. The E-0102 data region 05:5A33-5A4B is trimmed to end at $5A38. Tracing it exposes FailIfAllyLacksMPForSkillList5AF8 (05:5A73), the sibling of FailIfAllyLacksMPForHealSkill.
  - 1A:63D8 ReadStatGrowthGainToTemp2, a one-gain reader of StatGrowthTable.
- **Also named.**
  - CountSkillsInList6D1A (05:6D1A; was a single-caller _Sub01 name until the new routine also called it).
  - IsFadingAtMap5AScreen00Y80, DrawPlayerOverlaySprite21Or22, DrawFollowerSpriteIfFlag1B, DrawPartyFollowerSprites (bank $04).
  - CopyF0StringAndRedrawNameEntry (14:6CEA).
  - tools/rank_unnamed.py reports 0 address-only routines again.
- **Limits.** Whether the two configured entries are ever called (for example through a table not yet decoded) is not known; they are code by shape, not by an observed caller.
- Binary verification: build/run178 PASS, 0 differing bytes; tests OK.

### E-0176 — Map object record fields

- Kind: OBSERVATION (reading of LoadMapObjectsForScreen's copy loop, 69:40FC, and of the A-button handler 87:42A0; C1).
- **Fields.** Each 11-byte object record (E-0163) feeds a 16-byte sprite slot and DecompressGraphicsHFFC6ToHFFCA:
  - byte 0: hFFCB, the VRAM page of the object's graphics (hFFCA = 0);
  - byte 1: hFFC8, the graphics table (0 = MonsterSpriteTable, otherwise FieldSpriteGraphicsTable); also slot +1;
  - bytes 2-3: hFFC6/7, the graphics number; slot +2/+3;
  - byte 4: slot +0;
  - bytes 5-6: X and Y, stored twice, at slot +4/+5 and +$B/+$C. The A-button handler matches the screen-cell nibbles at +$B/+$C;
  - byte 7: hFFC9, the palette slot; slot +6;
  - byte 8: slot +7;
  - byte 9: slot +8. The A-button handler treats it as the talk event group ($FF, $FE and $FC-$FA select fixed events; other values are paired with an index from the map-number band).
  - byte 10: slot +$F.
  - The loader also sets slot +9 = slot number & 3 and clears +$A and +$D.
- **What changed.** The MapObjects_ record descriptions list these fields.
- Binary verification: build/run179 PASS, 0 differing bytes; tests OK.

### E-0177 — Rectangles drawn through wArg parameters

- Kind: OBSERVATION (derived from call sites; C1).
- **Rule.** DrawTileRectFromArg1Params (and every routine with its first 16 bytes) takes the source in wArg1/wArg2 (high, low), the width in wArg3 and the rows in wArg4. Call sites set them with `ld a, n` / `ld [wArgN], a`, or with `ld de, n` / `ld a, d` / `ld a, e`. The raw-rectangle rule of E-0161 now reads those stores too, which adds 12 rectangles (185 raw rectangles in all), for example 1F:5E13 (12 x 3) and 1F:66DF (8 x 7).
- **Limits.** The bytes after such a rectangle stay data unless another call site names them. The larger slices after 1F:5E13 and 1F:66DF are still undecoded.
- Binary verification: build/run180 PASS, 0 differing bytes; tests OK.

### E-0178 — SGB palette sets (bank $17)

- Kind: OBSERVATION (reading of SendSGBPaletteSetPacket, 17:41CF; Pan Docs for the PAL_SET layout; C1).
- **Source.** The routine starts a PAL_SET packet ($51), copies the 8 bytes at 17:$426C + 8 * wSGBPaletteSet after the command byte (and into wSGBPaletteNum0Lo onward), and adds the attribute file wSGBAttrFile | $80.
- **Checks.** Entries 0-63 are four words below 512, the number of SGB system palettes. The words after them are not.
- **Declared.** SGBPaletteSets (64 entries, decimal palette numbers).
- Binary verification: build/run181 PASS, 0 differing bytes; tests OK.

### E-0179 — SGB packet sets (bank $1F)

- Kind: OBSERVATION (reading of SendSGBPacketSet, 1F:5040; Pan Docs for the packet layout; C1).
- **Source.** SendSGBPacketSet takes the word at $5094 + 2 * wSGBPacketIndex ($FF uses wSGBPacketBuffer instead). It sends (byte 0 & 7) 16-byte packets from there through the joypad register.
- **Declared.**
  - SGBPacketSetTable: 21 pointers.
  - SGBPackets: 21 single-packet sets at $50BE-$520D, one per line. Byte 0 is command * 8 + count (the first is $79 = command $0F DATA_SND, one packet).
- **Limits.** The packets' payloads (data sent to SGB RAM) are not interpreted.
- Binary verification: build/run182 PASS, 0 differing bytes; tests OK.

### E-0180 — Battle text preparation routines

- Kind: OBSERVATION (reading of ShowBattleText, 3A:7193; C1).
- **Source.** ShowBattleText takes the word at 3A:$71B4 + 2 * D. When it is non-zero it calls it (JumpToWordAtHL), then shows string D of category 1 from bank $2F.
- **Declared.** BattleTextPrepTable: 256 words up to the first routine at $73B4; 211 are non-zero. It is marked as a code table, so the routines are traced. Each is named BattleTextPrepNN after the first entry that uses it. They copy names (actor, target, item) and numbers into the text buffers before the string is shown.
- **Also named.** WriteBCAsDecimalString (00:2F84), now reached through those routines. tools/rank_unnamed.py reports 0 again.
- Binary verification: build/run183 PASS, 0 differing bytes; tests OK.

### E-0181 — AI mode and choice routine tables (bank $30)

- Kind: OBSERVATION (reading; C1).
- **AIModeRoutineTable ($45D0).** AIChooseActionResolveStep and AIChooseActionForActor call the word at $45D0 + 2 * AI mode: mode 0 AIRunNextChoice, modes 1-3 ScoreActionsWithAIScoreTableA, mode 4 UseAIScoreTableB. It is declared explicitly because declaring the next table removed the heuristic pointer run that had found it.
- **AIChoiceRoutineTable ($4998).** AIRunNextChoice calls the word at $4998 + 2 * (wAIChoiceWeights[wAIChoiceIndex] - 1). It has three words, and the three routines follow it directly in what had been an INCBIN slice ($12E bytes):
  - AIPickRandomActionOfKind1: action 0 plus the skills of kind 1 (the byte before each skill number in wBattleSkills);
  - AIPickRandomSkillOfKind2;
  - AIPickRandomSkillOfKind3 (adds skill $AC in one case).
  - Each picks one entry at random as the action choice.
- **Limits.** What the per-skill kind byte means (it is set when the battler is loaded) is not read.
- Binary verification: build/run184 PASS, 0 differing bytes; tests OK.

### E-0182 — Map exit destination table (bank $12)

- Kind: OBSERVATION (reading; C1).
- **Reader.** ScriptCommand8A_Run_Case01, on maps where bit 7 of wMapType is clear, looks up MapExitDestinationTable ($52AD):
  - It scans 7-byte records for the one whose first byte equals hMapId. There is no terminator and no bounds check.
  - When wLastWarpIndex = 2 it skips three more bytes.
  - It loads hMapId from the next byte, hMapScreenX/Y from the high and low nibbles of the byte after that, and wWarpDestX/Y from the nibbles of the third byte (each nibble x16). It clears wWarpDestFacing.
- **Layout.** 87 records end exactly at the routine at $550E, and every map id appears once. Exit B (the second three bytes) is non-zero only in records 0 and 9-13.
- **Limits.** What sets wLastWarpIndex to 2, and what the player sees, are not read; the label is a neutral description.
- Binary verification: build/run185 PASS, 0 differing bytes.

### E-0183 — Arena encounter lists (bank $0C)

- Kind: OBSERVATION (reading; C1).
- **Sizes.** ScriptCommand96_Run_Shared01_Sub01 reads ArenaEncounterListSizes[wAreaGraphicsIndex] ($78FF; six bytes, all 39). It reduces a random number below that size by repeated subtraction, and steps past entries already drawn three times (counted in wArenaList).
- **Lists.** It reads the word at ArenaEncounterLists ($7905) + 2 * wAreaGraphicsIndex, then the word at that pointer + 2 * entry, and stores it in wArenaList2 (3 rounds x 3 words). Indexes 0-2 share one list, so there are four lists of 40 words at $7911, $7961, $79B1 and $7A01. Entry 39 is never drawn.
- **Use.** ScriptCommandF7_Run_Case1C_Sub01 copies one round's three words (wArenaRound) to wEncounterMonsters.
- **Limits.** The words are encounter identifiers ($0104-$0276). Which table they index is not traced. The bytes after the last list ($7A51) are an event script (E-0184).
- Binary verification: build/run186 PASS, 0 differing bytes.

### E-0184 — Data banks of $E7 script jumps from wider caller context

- Kind: TOOL (generator heuristic; C1 per site).
- **Problem.** prepare_scripts (E-0160) took a script's data bank only from an `ld a, n` / `ld [wDataBank], a` pair within the ten instructions before the StartScriptAtHL call. That left 51 $E7 jumps without a bank.
- **New searches.** When that window has no store, the generator now looks in two more places:
  - **After the call.** It walks forward from the call, following unconditional `jr` and `jp`, for up to 16 instructions. It stops at any other control-flow instruction. A store found here is used first.
    - Example: DispatchTalkEvent_Case01_Case4C sets wDataBank to $1D after starting Script_54AB.
    - Example: Func_004_7B29_Case02 sets it to $10 at a shared tail after starting Script_65AA.
    - StartScriptAtHL only queues the script, so the value stored before the routine returns is the one the script sees.
  - **Above the call.** It walks back through contiguous instructions until it reaches a routine entry (a named routine, a call target or an rst $00 table target).
    - Example: DispatchTalkEvent_Case01_Case65 stores $0C at its head, above the branches that start Script_5559, Script_5560, Script_556A and Script_5571.
- **Result.** All 89 $E7 jumps now resolve to exactly one bank, and none is left marked "data bank not known here".
  - New data-bank scripts include Script_0C_7A51 (the arena scripts), Script_1D_4335 and Script_15_764B.
  - The decoder covers 2,885 commands in 193 regions (it was 2,672). Unidentified INCBIN is 73,764 bytes.
- **Limits.** A callee between the store and the script's next run could change wDataBank. This is not checked, so each resolution stays C1.
- Binary verification: build/run189 PASS, 0 differing bytes; tests OK.

### E-0185 — World map screen cell grids (banks $A1 and $5D)

- Kind: OBSERVATION (reading; C1).
- **WorldMapScreenCellTable (A1:$497C).** RunGameMode2State_Case04_Sub02_Sub01 reads the 4-byte record at $497C + 4 * wGameMode2Byte44 (the same index as WorldMapViewTable, E-0167).
  - Byte 0 gives the width in screens (high nibble) and the height in screens (low nibble).
  - Bytes 1-3 are a 24-bit pointer (address, then bank).
  - The routine adds (hMapScreenX - 2) * 25 + (hMapScreenY - 2) * width * 25 to the pointer and reads 5 cells per row from there.
- **Grids.** Each grid is exactly width * height * 25 bytes. The 11 grids (WorldMapScreenCells0-10, from 8 x 8 down to 1 x 2 screens) fill bank $5D from $45A5 to $7692, and only zero padding follows. Cell values are mostly $56-$58.
- **Palettes_5D_4139.** The block is 128 bytes, but only palette 0 is copied (8 bytes, RunGameMode2State_Case01). Palette 8 is palette 0 with two colours swapped; the rest is $7C00 fill.
- **Limits.** What each cell value draws, and which world each index is, are not read.
- Binary verification: build/run191 PASS, 0 differing bytes.

### E-0186 — 1F:5D9A fills a rectangle with one tile (corrects E-0120, E-0121, E-0129)

- Kind: OBSERVATION (reading; C2 for the instruction-level difference).
- **The difference.** Func_01F_5D9A has the same structure as DrawTileRectFromArg1Params (1F:5D2A, E-0093) but no `inc de` in its row loop.
  - It therefore writes the single byte at [wArg1/wArg2] to every entry of the wArg3 x wArg4 BG rectangle.
  - On CGB, when wArg7 is 0, it also zeroes the attributes of those entries, as before.
  - All ten callers pass $5E12, which holds the one byte $C3 (BGFillTile).
- **Corrections.**
  - E-0129 said Func_01F_5D9A "writes a rectangle from wD7F1/2". It is renamed FillTileRectWithArg1Tile.
  - E-0120 and E-0121 said three routines "draw the 32 x 32 tile map at $5E12". They clear the 32 x 32 BG map to tile $C3, and are renamed ClearBGMapAtScrollAndResetScroll (1E:65FE, F0:5E2C) and ClearBGMapAndLoadFrameTiles (1F:7494).
  - The rejected reading stays recorded here.
  - The tile rectangles that follow $5E13 (E-0161) are separate data read by other routines.
- **Generator.** `ld de, SRC` stored to wArg1/wArg2 before a far call (`rst $10`) to DrawTileRectFromArg1Params or FillTileRectWithArg1Tile now takes the callee's bank (C1).
  - The callers in banks $0C and $F1 had produced wrong-bank labels Data_00C_5E12 and Data_0F1_5E12; these are removed.
  - The callers in banks $14, $15, $1E, $37 and $F0 had raw operands; all ten now read `ld de, BGFillTile`.
- Binary verification: build/run192 PASS, 0 differing bytes.

### E-0187 — Bank $1F tile rectangles reached through relays and far calls

- Kind: TOOL plus OBSERVATION (C1).
- **Relays.** DrawTileRectAtHLFromDE (E-0093) exists in four banks ($1E, $37, $F0, $F1). Each copy stores DE in wArg1/wArg2 and far-calls DrawTileRectFromArg1Params, so DE always points into bank $1F.
  - The generator now finds the copies by their first 23 bytes.
  - It gives the `ld de` before each call bank $1F, and derives the rectangle from the caller's wArg3/wArg4 stores.
  - Banks $37, $F0 and $F1 had wrong-bank labels (for example Data_037_63D7 and Data_0F1_66DF); these now read Data_01F_*. Bank $1E's raw operands are labelled too.
- **Far calls.** The E-0177 derivation now also accepts a far call (`rst $10`) to DrawTileRectFromArg1Params and uses the callee's bank. This gives, for example, the 20 x 18 rectangle at $6FE7 that bank $14 draws.
  - Rectangles derived in bank $1F went from 12 to over 20.
- **Declared.**
  - TileRect_1F_720D: three 20 x 6 panels. Jump_024_513A draws the panel at $720D + (wScreenByteBD - 1) * $78.
  - TileScreen_1F_5F9F, _6107 and _626F: 20 x 18 screens with the same box layout as TileRect_1F_5E37, contiguous with it. No reader was found.
- **Heuristic order.** A "bank from RAM variable $D7FE" label now gives way to a proven table, like the other guesses. It had paired `ld hl, Script_65B8` with bank $1F.
- Binary verification: build/run194 PASS, 0 differing bytes.

### E-0188 — $E4 is an N-way branch on the menu cursor

- Kind: OBSERVATION (reading ScriptFetchE4; C2 for the mechanism, C1 for the per-site count).
- **Mechanism.** ScriptFetchE4 (10:4694) takes the script pointer just after the opcode and steps forward wTwoChoiceCursor bytes. It then adds the byte it lands on to the address after that byte. Equivalently, target i = opcode address + 2 + i + offset[i].
  - So a menu of N options needs N offsets, and the script does not encode N.
  - E-0152 had fixed it at two.
- **Count rule.** $E4 always jumps, so nothing falls through to the byte after the offsets. In every site, that byte is the nearest target.
  - The decoder takes N as the smallest count of 2 or more whose nearest target is the byte after the Nth offset.
  - Example: 10:6681 `E4 0C 04 00` has three targets ($668F, $6688, $6685). A two-offset reading would leave the $00 at $6684 decoded as a message opcode.
  - All 149 sites fit the rule (0 fallbacks): 76 two-way, 46 three-way, 18 four-way, 6 five-way, 1 six-way, 2 seven-way.
- **Effect.** `script_choice_jump` takes any number of labels (REPT _NARG over `db (\1) - @ - 1`).
  - The decoder now covers 3,359 script commands in 118 regions (it was 2,885 in 193); misread offsets had split regions.
  - Unidentified INCBIN is 62,381 bytes.
- **Limits.** Which command sets the cursor range for each menu is not traced.
- Binary verification: build/run196 PASS, 0 differing bytes; tests OK.

### E-0189 — Sound wave set and modulation rows (bank 0); operands name their tables

- Kind: OBSERVATION (reading; C1) plus TOOL.
- **SoundWaveSetTable (00:$30CC).** Jump_000_35A8 (and two other paths) clears rNR30, then reads the word at $30CC + (hSndA8Param >> 4) * 2.
  - It adds wave number * 16 and copies 16 bytes to $FF30-$FF3F (wave RAM).
  - The table has one entry, SoundWaveSet0 ($30CE): 16 waves of 16 bytes. Wave 0 is a sine, 1 a triangle, 2 a square, 3 a sawtooth.
- **SoundModulationTable (00:$31CE).** Jump_000_3A94 reads the word at $31CE + (hSndA8Param & $0F) * 2. It then reads the byte at that pointer - $10 + (hSndVibratoDepth | a 4-bit phase from hSndVibratoCounter and hSndVibratoDelay).
  - The table has one entry, SoundModulationRows0 ($31D0): 12 rows of 16 bytes, ending at the routine at $3290.
  - How each step changes pitch or volume is not read.
- **Bank-0 tables.** A load of an address in $0150-$3FFF that starts a declared bank-0 table now names that table from any bank. Bank 0 is always mapped there, so no bank evidence is needed.
- **Table names in operands.** A declared or derived table's label now replaces the address name (Data_BBB_AAAA) at its start, and the address name stays as an alias.
  - 347 operands changed, for example `ld hl, MapExitDestinationTable` and `ld hl, ArenaEncounterLists`.
  - `ld r16, Data_*` operands went from 1,724 to 1,382.
- Binary verification: build/run200 PASS, 0 differing bytes; tests OK.

### E-0190 — The last sound track of each table

- Kind: TOOL (C2 grammar from E-0019; region end C1).
- **Problem.** prepare_tracks decoded a track only up to the next track pointer, so the last track of each table had no end and stayed INCBIN. An example is 40:$7B9B (850 bytes).
- **Rule.** The last track now runs to the first `end` event after which the bytes up to the next label, decoded code or the end of the bank are a single repeated value. At 40:$7B9B it ends at $7EED (`B0 F3`, `FF FF`), and $113 zero bytes follow.
- **Result.** 218 tracks are decoded (214 before), with none skipped. Unidentified INCBIN is 60,460 bytes.
- Binary verification: build/run201 PASS, 0 differing bytes; tests OK.

### E-0191 — Rejected name list (bank $14)

- Kind: OBSERVATION (reading; C1).
- **Reader.** RunNameEntryStateWhenNotFading_Case03_Case00_Sub02 walks 10-byte records from $70F0 until a record starts with $FF. It compares each record with wNameEntryText, skipping $9F bytes in the entry, up to the record's $F0.
- **Layout.** There are 84 records, then the $FF terminator. Each is a short word that the name entry refuses, given in mixed case and in capitals, and zero padded to 10 bytes.
- **Tool.** A new `text` field type shows the bytes up to $F0 through charmap.inc and the padding as raw bytes, because $00 is the digit 0 in the charmap.
- Binary verification: build/run202 PASS, 0 differing bytes.

### E-0192 — Key generation tables (bank $60) and fixed-bank pointer arguments

- Kind: OBSERVATION (reading; C1) plus TOOL.
- **KeyWorldLevelTable ($47C5).** 100 records of 8 bytes, indexed by wPartyStrength. LoadKeyWorldLevelBaseTripleForPartyStrength copies bytes 0-2 to wKeyWorldLevelBase/Area/Monster. Bytes 3-7 are $64, $64, $64, 0, 0 in every record and are not read here.
- **KeyWorldBandAdjustTable ($43C7, 16 bytes) and KeyWorldBandRows ($43D7, 56 rows of 8).** LoadKeyWorldParamsForCurrentKeyIndex indexes these by bytes 0 and 1 of the current key's entry.
  - From a row it copies the $FF-terminated band list to wKeyWorldMonsterBands.
  - It adds the row's byte 6 to wKeyWorldBandAdjust (negative becomes 0).
- **KeyWorldBossBandPickRows ($4123).** 34 rows of 8. RollKeyWorldMonsterTableKeyWorldBossMonsters picks byte (random & 7) of row wKeyWorldBandAdjust; that byte selects a band-list pointer at $6D6D + $90.
- **KeyWorldGoalKindRows ($4CC1).** 56 rows of 4, indexed by key entry byte 1. A random non-zero entry minus 1 becomes wKeyWorldGoalKind.
- **KeyContentsKindChanceRows ($6969, 10 x 16) and KeyContentsChanceRows ($6A09, 10 x 60).** RollKeyContentsForLevelTemp0 compares these per 10 levels with a random 0-99.
- **KeyContentsColumnPicks ($6677, 37 bytes) and KeyContentsWordRows ($669C, 29 x 16).** WriteTable669CWordForTemp2Temp3 reads these. Rows 10-28 are zero.
  - The one-byte "monotone pointer table" labels over those zeros were artefacts and are gone.
- **config/arg_banks.json (new).** It lists routines that read a pointer argument in a fixed bank.
  - Its first entry is RemoveMapObjectsEntryMatching: the HL argument is read by Func_060_64F3 with ReadByteInBank, B = $61.
  - The `ld hl` before each call now names bank-$61 data. Data_060_6705, _6B05, _6F85, _7405 and _7525 were wrong-bank labels; they now read Data_061_*.
- Binary verification: build/run205 PASS, 0 differing bytes.

### E-0193 — Key-world area layouts (banks $84 and $60)

- Kind: OBSERVATION (reading; C1).
- **Tables.** KeyWorldAreaLayoutTable (84:$4CCB) and KeyWorldAreaLayoutTable_Bank60 (60:$6D0D) hold the same 48 pointers, indexed by wKeyWorldAreaCount.
- **Layouts.** Each layout KeyWorldAreaLayout00-47 is a block count n, then n blocks of 16 bytes, then $FF (size 2 + 16n for all 48, contiguous from $4D2B to $5E0B).
  - DebugAutomap_Update_Sub01_Sub01_Sub0C passes one block per wKeyWorldFloorInfo entry to RunDebugAutomapCaseTemp0, with DE stepping through wKeyWorldFloorState.
- **KeyWorldMonsterBaseRows (84:$42C7).** 6 rows: 10 base values then 6 zero bytes. Jump_084_4282 picks a random 0-9 and adds a random 0-7.
- **LogTwigSpotList (84:$49A1).** 50 records of 4 bytes, then $FF: map id, screen XY, and two tile positions ($FF = none). ItemUsable_LogTwig_Sub01 matches these against hMapId, the screen and the player's tile.
- **Limits.** The meaning of the bytes inside a layout block is not read.
- Binary verification: build/run208 PASS, 0 differing bytes; tests OK.

### E-0194 — Town object spot grids replace five false compressed streams (bank $61)

- Kind: OBSERVATION (reading; C1) and a correction to E-0035.
- **Reader.** SetupTownObjectsForMap passes seven bank-$61 pointers to RemoveMapObjectsEntryMatching ($6705, $6905, $6B05, $6F85, $7405, $7525, $7555, per E-0192).
  - Func_060_64F3 picks a random screen and reads the pair at pointer + (screen Y * wMapWidthScreens + screen X) * 8 + 2 * (random & 3).
  - A first byte of $FE draws a new screen, and $FF draws a new spot.
- **Grids.** The pointer gaps give 64, 64, 144, 144, 36 and 6 screens. The last grid is 25 screens and ends at $761D, followed by zero padding. The bytes show the $FE screens and $FF pairs the reader expects.
- **Correction.** E-0035's chain finder had registered five back-to-back LZSS streams at $6710, $696F, $6A15, $6E56 and $6FAB inside these grids. LZSS accepts almost any bytes, and nothing loads those addresses as streams.
  - With the grids declared as tables, the finder skips them (it already rejects starts inside structured tables). config/stream_chains.json is unchanged.
  - The streams count goes from 4,926 to 4,921.
- Binary verification: build/run209 PASS, 0 differing bytes; tests OK. Unidentified INCBIN is 56,140 bytes.

### E-0195 — Key-world screen spots and warp lists (bank $61)

- Kind: OBSERVATION (reading; C1).
- **KeyWorldEntryScreenXY ($4810, 8 bytes).** CheckTwoWCDB0EntriesForKeyWorldArea_Sub01 compares the byte at $4810 + B with hMapScreenX/Y packed as nibbles.
- **KeyWorldScreenSpotRecords ($4818).** 192 records of 16 bytes (eight X, Y pairs), ending at the code at $5418.
  - LookupTable4818NibblePairForTemp0 reads pair hTemp0 of record [$CE2C + 2 * floor state byte 1 + 2 * wKeyWorldArea]. Func_061_462F reads the same records.
- **KeyWorldWarpListTable ($6566).** 128 words, indexed by floor state byte 0 & $7F. CheckKeyWorldWarpTable and RunMapType_596F_Case03_Sub01 walk 9-byte entries until $80.
  - Kind $FE or $FF, a screen match and byte 4 = $FF warp to (byte 7, byte 8).
  - The lists (KeyWorldWarpsNN, derived with the E-0157 `lists` option) fill $6666-$6705 exactly.
- **Result.** Bank $61 has no INCBIN left.
- Binary verification: build/run211 PASS, 0 differing bytes.

### E-0196 — Key-world object grids (bank $04); MonsterSpriteTable has 383 entries

- Kind: OBSERVATION (reading; C1) plus TOOL.
- **Chain.** SetupKeyWorldObjectsForMapType passes $5327 + 2 * (kind - 1), or + 6 / + $E for the goal room, to SetupKeyWorldObjectsForMapType_Sub01. That routine follows four levels:
  - KeyWorldObjectGridTable (16 words) gives a grid.
  - The grid holds one word per screen (index hMapScreenY * wMapWidthScreens + hMapScreenX) pointing at a screen entry; 0 = none.
  - A screen entry is a marker word ($FFFF = no objects; all 19 here are $FFFE) and a pointer to the object list.
  - An object list is a count, then 11-byte records filling sprite slots like the bank-$69 map object records (E-0176). Bytes 2-3 are replaced by the key-world encounter when hTemp9 is set.
- **Layout.** The 10 grids, 19 screen entries and 19 lists are contiguous and end exactly at $55BB, the end of the old INCBIN slice.
- **Correction.** The word table starts at $5327, the last entry of MonsterSpriteTable as declared (E-0139, `dw $5347` with bank $8C). MonsterSpriteTable therefore has 383 far pointers, not 384.
- **Tool.** A load whose value is the exact start of a declared table in the caller's own bank now names it, even in banks where the generic same-bank guess is withheld. This renamed 11 operands, each matching the loader in that table's note (for example `ld hl, KeyWorldObjectGridTable` ×4 and `ld hl, WorldMapViewTable`).
- Binary verification: build/run213 PASS, 0 differing bytes.

### E-0197 — Bank $1B word list and an unreferenced routine; one more monster picture stream

- Kind: OBSERVATION (reading and a byte comparison; C1).
- **Text_1B_5190.** This is the last target of the bank-$1B message pointer table: $EA, $45, then " Accessories will / be in the Vault." up to $F0.
- **RejectedNameListCopy_1B ($51B6-$5352).** 84 $F0-terminated words, identical in order to RejectedNameList (14:$70F0, E-0191) without the zero padding. A script compared all 84. No reader was found.
- **Func_01B_5352.** No traced code, pointer or far call reaches it; a search for `cd 52 53`, `ld hl, $5352` with `ld b, $1B`, and the word $5352 in bank $1B found only unrelated bytes.
  - Its bytes decode as one routine that ends in `jp $077A`. The routine clears $6F bytes from wScreenState, decompresses bank $46 $4001 to $8800, far-calls F1:$4AA8 and LoadPalette0FromData53C6, then waits on wC8CB.
  - It is a configured code entry (config/code_entries.json) and carries an annotation. Whether the game can run it is not known.
- **MonsterPic_Dimensaur (7B:$4001).** The pointer fields of MonsterPictureTable and MonsterSpriteTable are now marked `stream`.
  - The one picture no back-to-back run had found is now a verified stream (520 bytes expanding to 576).
- Binary verification: build/run215 PASS, 0 differing bytes.

### E-0198 — Map step trigger lists (bank $87)

- Kind: OBSERVATION (reading; C1).
- **Reader.** FieldModeStateDispatch_Case00_Sub02 runs once per step (guarded by wStepTriggerFlag). It reads the word at $40A0 + 2 * hMapId and walks 10-byte entries until $FF.
  - An entry fires when byte 0 is 0, the map and screen match, the player position matches (skipped when player X is $FF), and the story flag is $FFFF or clear.
  - It then sets wTalkEventGroup/Index and far-calls DispatchTalkEvent.
- **Layout.** MapStepTriggerTable has 256 words and ends at the code at $42A0; its bytes had been emitted as anonymous `db` lines after the routine.
  - The lists (MapStepTriggersNN, derived with the E-0157 `lists` option) fill $5D33-$5F25, right after SpecialMapInteractions_5D28.
  - Bank $87 has no INCBIN left.
- Binary verification: build/run216 PASS, 0 differing bytes.

### E-0199 — Breeding tables (bank $0E)

- Kind: OBSERVATION (reading ComputeBreedingChild, 0E:5688; C1).
- **Overview.** The child's species comes from the first of four stages that matches. Parent A is wRecordBufA (species at +$B, family at +$D & $0F, + value at +$6D); parent B is wRecordBufB.
  1. **BreedSpeciesRuleTable ($6208, 384 words, by parent A's species).** Each list is words:
     - a species equal to parent B's species matches;
     - $FDxx moves to the next result;
     - $FExx / $FCxx match when both parents are the same species and parent B / parent A has + of at least xx;
     - $FBxx moves on only when wArg1 = 2;
     - $FFxx ends the list.
     - A match takes result [number of moves] from BreedSpeciesResultTable ($6E14).
  2. **BreedFamilyRuleTable ($734E, by parent A's species).** Each list is family bytes compared with parent B's family ($FE = only when wArg1 = 2, $FF = end). Results come from BreedFamilyResultTable ($774F).
  3. **FamilyBreedRuleTable ($7B83, 11 words, by parent A's family).** Each list holds partner species ($FDxx = next result, $FFxx = end). Results come from FamilyBreedResultTable ($7DBF).
  4. **FamilyPairResultTable ($7E83, 11 rows of 11 words).** Word [parent B's family] of row [parent A's family]:
     - $FFFF = parent A's species;
     - $FExx = no child (wNameEntryState = 6, wArg5 = $FF);
     - otherwise the child's species.
     - The rows end at Script_0E_7F8B.
- **Layout.** In each table the lists are contiguous and run to the next table. Pointers equal to the table end name empty lists.
- **Tools.**
  - The `lists` option gains `until` (lists tile the range up to an address) and `one_line`.
  - Word fields gain `names`: monster names, rule codes, or breeding results. Notes of species-indexed lists name parent A's species.
  - The output shows, for example, the Slime-family row giving DrakSlime, SpotSlime, WingSlime and so on for the other ten families.
- **Limits.** What wArg1 = 2 selects, and the family names, are not read here.
- Binary verification: build/run219 PASS, 0 differing bytes; tests OK. Unidentified INCBIN is 50,799 bytes.

### E-0200 — Skill line table, personality matrix (bank $0E); glyph copy lists (bank $1E)

- Kind: OBSERVATION (reading; C1).
- **SkillLineBaseTable (0E:$5B03, 176 bytes).** MapWCB0CEntriesThroughTable5B03 replaces each of the $19 skill bytes at wChildRecord + $3C by the byte at $5B03 + skill.
  - A script confirmed that no entry exceeds its index. Runs of related skills share the first one's number (1-3 → 1, 4-6 → 4), so the table maps a skill to the first skill of its line.
- **PersonalityPairMatrix (0E:$603F, 27 rows of 8).** PersonalityPairValueToArg5 reads the byte at $603F + 8 * A + B / 4 (A, B = CombinedPersonalityLevelIndexOfRecord of the two parents). It masks two bits with Data_00E_6117[B & 3] into wArg5. Each row ends with $FF padding.
- **GlyphCopyDestList0-5 / GlyphCopySrcList0-5 (1E:$778C-$795C).** These are the HL/DE pairs that bank-$1E callers pass to ScriptCommandE8_Run_Shared05.
  - It copies 16 bytes from bank $1F at each source to each VRAM destination, until a destination of $FFFF.
  - Each source list has the same length as its destination list, including an unread $FFFF.
- **CursorCellTable7880 / CursorCellTable788A.** Screen-buffer addresses used with StoreBAtWordTableEntry_Bank1E for cursor cells.
- **Result.** The old INCBIN slices 0E:$5B03, 0E:$603F and 1E:$778C are decoded.
- Binary verification: build/run221 PASS, 0 differing bytes.

### E-0424 — The wider mislabel candidates reviewed: one more same-address label, and a bank_check rule that finds only it

- Date: 2026-10-24. Kind: OBSERVATION (source reading, the reference ROM and tools/sm83.py), source change (no byte changed) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 53a346a. Details: [shiftability](SHIFTABILITY.md), "E-0424".
- **The question (E-0423's open item 2).** E-0423's bank_check rule warns about a code label of a routine's own bank, loaded into hl/de/bc and followed within ten lines by a far call to another bank. Without the "code label" condition, the same rule lists 75 loads on this tree (E-0423 reported 64; the form it counted was not recorded). Each was read here, with what the far routine receives.
- **74 of the 75 hand over no address (C1 by reading; DE checked on tools/sm83.py).**
  - The far call cannot receive HL: the farcall macro loads HL with the routine's address (`ld hl, Routine / ld b, BANK(Routine) / rst $10`), and CallInBank passes on only BC, DE and memory.
  - 19 use the address in place first. 17 read through it (`ld a, [hl]`, `ld a, [hli]`, `ld a, [de]`, `deref_hl`) and hand the far routine only the bytes, for example GameMode1_Init's SGB palette set and attribute file, and SceneChestBattle_StartBattle's and SceneBarrel_StartBattle's encounter ids in hTemp0. In BattleEnd_OfferJoin_DecideJoinOffer, the far-called LoadSpeciesRecord loads DE itself. ShowActionRefusedMessage jumps back to a read of its byte table.
  - 55 hand the address first to a routine of the caller's own bank (54) or the home bank (CopyBytes), which reads it with the caller's bank mapped: CopyRectTo20ByteRows_BankNN, StoreBAtWordTableEntry_BankNN, WriteBCTileToScreenBufferAtTableEntry_Bank03, CopyTileListFromBank1F_Bank03, SwapMonstersMenu_CopyGlyphTiles, ThreeEntryCursor_BankA0, ShowSkillPageNames_BankA0, and CopyBytesDEFromHL_BankNN for the 13 graphics argument blocks copied to hTemp0 for DecompressGraphicsTemp0ToTemp4.
  - In 23 of the 74, DE may still hold the address at the far call (DE was loaded, no store, no later `ld de`). Their 15 far routines do not read DE. CopyBlockToTileBuffer starts with `ld d, $00`, and its callers set E just before the call. The other 14 were run on tools/sm83.py from 6 states with 6 values of DE: LoadTilesForPartyRecords, ClampRecordListPageCursor4, BlankLeadingZeroDigits_F_Bank15, DrawRecordStatsBoxForArg1, HibernateMenu_DrawSleeperStatsBox, MarkPartyMembersInRecordListPage, LoadPlayerAndFollowerSpriteGraphics, LoadSpeciesRecord, BuildKeyListIndexListEntries, ClampKeyListPageCursor, ListRecordsInUseNotEggs, StartScriptedEncounterTemp0, ClearAndLayoutTileBlocksForBattleFoeCount and CopyRectRecordsAndToScreenBuffer. Each returned the same RAM, VRAM, OAM, SRAM, palettes and registers other than D and E for every DE. Runs that did not return from a random state were left out: 2 of 6 states for ClearAndLayoutTileBlocksForBattleFoeCount, and 4 of 6 for LoadPlayerAndFollowerSpriteGraphics, whose first instructions load DE.
  - CopyTileListFromBank1F_Bank03 and SwapMonstersMenu_CopyGlyphTiles map bank $1F only inside CopyFromBankWaitVRAM, for the tile bytes; they read the two lists with the caller's bank mapped, so TacticsGlyphTileDests/Sources and GlyphCopyDestList5/SrcList5 are in the right bank.
- **One is a label at the right address in the wrong bank (C2 on tools/sm83.py).** DebugResultsDisplay_Update_ShowChild (the debug breeding screen, bank $01) stored `ld de, $75C5` in wArg3/wArg4 for the far-called TestBitInFieldAtArg3 (bank $15), which reads the field with bank $15 mapped. The generator had named the number DebugResultsDisplay_Update_ShowChild_Data, a label it made inside bank $01's zero fill at $75C5. The routine's E-0369 note already said the bytes read are BreedShowNameSpeciesBits (15:$75C5), and the bank-$0D reader of that field was written this way (config/operands.json "0D:76E2"). The load now names BreedShowNameSpeciesBits with `ASSERT BANK(BreedShowNameSpeciesBits) == BANK(TestBitInFieldAtArg3)` (config/operands.json "01:559C"; 549 asserted). The bank-$01 label is gone, and its two fills `ds $4a6` and `ds $a3b` are one `ds $ee1` (same bytes). Run on tools/sm83.py from the routine's `.read_arg6` step, the routine reads 15:$75C5 for species 1 and 15:$75C7 for species 18, both from TestBitInFieldAtArg3 (PC 15:$6928), and leaves wArg5 = $FF and 0. Bank $01 holds only zeros there.
- **bank_check's new rule (TOOL).** A label of any kind in the loading routine's own bank warns when a byte of its address is stored to memory before the far call (`ld a, e` / `ld [wArg3], a` and the like). The rule follows the address through register copies (`ld e, l`), arithmetic with its halves and `add hl, rr`. A read through the address (`ld a, [hl]`), `deref_hl`, a reload of the pair, or a call in between ends the trail. A call ends it because it may be the routine that reads what was stored, as BreedMenu_ChooseParents_ComputeChild's own-bank TestBitInFieldAtArg3 does. On the tree before the fix it finds exactly the debug load out of the 75. It finds the same one with windows of 60 and 200 lines, which reach the next ret, jp or routine. Without the call rule, a 60-line window gave three false hits. The E-0423 code-label rule stays as it was. It would also have caught E-0423's tile list, whose loads store D and E in wArg3/wArg4.
- **A related class, all clean.** Of the 273 calls to CopyFromBank, CopyFromBankWaitVRAM and OrFromBankWaitVRAM (B = the bank, DE = the source), 214 load DE with a ROMX label (or label + offset) in the straight-line code before the call, and every one passes B = BANK(that same label). The other 59 compute DE or set it before that code.
- **Probes (config/probes/E-0424.json, 2 of 2 pass).** TestBitInFieldAtArg3 with wArg3/4 = $75C5, as the debug screen stores it: index 1 gives wArg5 = $FF (bit $40 of $FF), index 18 gives 0 (bit $20 of $DC).
- **Tests.** tests/test_sections.py: the new rule warns for a stored address, a stored address plus an offset, and an address copied to another pair and stored; it does not warn for a byte read through the address, a dereferenced pointer, a reloaded pair or a store that a local call takes. Its whole-source test failed on the tree before the fix with this one warning.
- **Checks.** No drift (265 files); build/run_e0424c PASS, 0 differing bytes; bank_check 0 errors, 0 warnings, 549 asserted, 0 literal, 1 unread. Suite (tools/run_tests.py --jobs 16, Windows): build/logs/suite_e0424.log, 596 tests, 592 OK, 3 skipped, 1 failure: test_probes' C2 check, because the new probes targeted the bit field, whose note is C1. They now count for TestBitInFieldAtArg3 (its note is C2, E-0377), and test_probes.py and test_probe_scope.py pass (13 tests).
- **Limits.** Static reading over straight-line text, as before: an address that a local routine stores for a later far call, or one handed over after a conditional jump elsewhere, is not followed. The DE checks cover 6 states per routine, not every path. The debug screen is not reached by any recipe.

### E-0423 — Every data-bank script section moved and run; a mislabelled tile list; an interpreter patch with the original timing

- Date: 2026-10-21. Kind: OBSERVATION (tools/sm83.py), source change (no byte changed) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 54a7cb9. Details: [shiftability](SHIFTABILITY.md), "E-0423".
- **All eleven data-bank script sections moved.** Arena x2 ($0C), key appraisal ($0D), NPC breeding ($0E), breeding ($15), hibernation x3 ($1D), priest and library, swap ($1F), and egg service with renaming ($96): 5,251 bytes, all moved to bank $9F in one build. A new recipe, tools/recipes/e0423_menus.txt, calls the egg evaluator's, the Christener's and the traveling merchant's talk routines on Main Street and presses A through their menus; until now no recipe started those three. With all eleven moved, three chains are identical VBlank by VBlank to the reference, with the same script trace:
  - the key-world chain: 200 runs, 52,889 VBlanks, 398 fetches; it contains every chain from the farm through the swap and the late story, so breeding, library, priest, hibernation and medals, keys and swap are all in it;
  - the arena chain: 107 runs;
  - the menus chain: 110 runs, 620 fetches.
- **Two faults the first all-sections run found.**
  - **Empty banks had no number at $4000 (tools/move_section.py).** Every non-empty bank keeps its number in its first byte (BANK_NUMBER_BYTE): the VBlank handler's sound code and ReadWordFromDataBank read it to map the interrupted bank back. move_section placed a section moved into an empty bank at $4000, so that byte was the section's own first byte. move_section now gives such a bank `db $BB` in its first section and puts the fill in a last section "Bank BB Fill", which moved sections go before. The E-0422 moves had the same flaw and passed because no interrupt fell while bank $9F was mapped; all were run again here.
  - **A tile list named after the wrong bank's label (C2).** The breeding menu's three tile-reload steps (BreedMenu_ChooseParents_ReloadTiles, ..._ReloadTilesAgain, the .set_arg1_to_9C step of BreedMenu_ChooseEgg_DrawGoldBox) pass `ld de, $6DE6` to LoadTileListSixPerCall in bank $1D. The generator had named that number after the bank-$15 routine at $6DE6, SRAMBank1RecordAddress. The list is the 18 bytes at 1D:$6DE6: VRAM tile addresses $8C00-$8CB0, then $FFFF. E-0381 had read them as unreached bytes after LoadPedigreeSpeciesSpriteGraphics_Data3. With bank $1D's sections moved, the bytes at $6DE6 changed, LoadTileListSixPerCall took a destination in the MBC register range ($2000-$3FFF), and writing a tile switched the ROM bank: the key-world chain crashed in run bb07!. The list is now BreedMenu_ReloadTiles_DestList (config/operands.json, config/names.json), named by the three loads with `ASSERT BANK(...) == BANK(LoadTileListSixPerCall)` (548 asserted). tools/bank_check.py now warns about a code label of the loading routine's own bank handed to a routine far-called in another bank. That rule finds exactly these three in the committed source and none now; a wider form, with data labels too, gave 64 candidates, mostly local data used after an unrelated far call (not reviewed one by one).
- **The interpreter patch keeps the original timing (tools/script_bank.py redesigned).** E-0421's patch made every operand read of every script take `call ReadScriptByte` (76 cycles instead of 8), which shifted frames. The game's own handlers are now left unchanged:
  - a moved script runs in the game's data-bank mode (wScriptInDataBank = 1, wDataBank = its bank), where FetchScriptCommand and the message, jump, skip and choice handlers already read through wDataBank;
  - the opcodes whose handlers read the mapped bank get far variants in unused slots: $A2-$AC for walk, walk fast, wait, hold pad, face, set flag, slide, hide, encounter, add gold and sound (copies of the original handlers with their reads through ReadWordFromDataBank); $09 for a generic command, its type in the next byte; $10 for command $62;
  - `script_jump_data_bank` in a moved script becomes `script_jump_far` to its target's bank (E-0420: the bank the talk routine stores);
  - the only change on the game's path is StartScriptAtHL clearing wScriptInDataBank: 36 cycles per script start. None of the 440 starts sets that byte first (checked in src/);
  - a moved script sets wDataBank, which E-0421's design did not. Six bank-$10 scripts run while a data-bank script waits: Script_BreedFade, Script_BreedChildSprite, Script_BreedChildScene, Script_ArenaGridBattle, Script_ArenaRounds and Script_NpcBreedWarp. They are the scripts of FieldTalkEvents groups $15-$18, $1F and $20, which the seven routines that save wScriptPointer dispatch, and the menus resume the waiting script in data-bank mode with the wDataBank it had. Moved, Script_BreedChildScene left wDataBank = $9F, and the breeding script went on reading its continuation, Script_WillYouTakeHero, from bank $9F (key-world chain, run bb19!). These six stay in bank $10, recognised by their commands (script_bank.NESTED), so 650 of the 656 runs move (6,440 bytes, 418 stubs).
  The patched tree changes nothing in bank $10's original lines but its fill and 14 unused table entries (tests/test_script_bank.py).
  - **Patch only, nothing moved:** the farm chain's 35 runs (13,620 VBlanks) are identical to the reference, where E-0421's patch differed in four runs. Over five chains with the patch alone (build/logs/e0423_patch_only.log): key world (200 runs, 52,889 VBlanks), world tour (222 runs, 80,553), the H4 readers (151 runs) and the menus chain (110 runs) are identical VBlank for VBlank; in the arena chain one run of 107 (ar03!) differs for 3 of its 2,976 VBlanks and ends on the same screen. The script traces are the same in all five.
  - **Every movable bank-$10 run moved (650, 418 stubs):** the farm chain fetches the same instructions as the reference, compared by instruction index after each label, since a far command can be a byte longer. The same 1-3-VBlank blips as E-0421 remain: a moved script is read the way the game reads its own data-bank scripts, which costs more cycles than reading bank $10 directly. Over five chains (build/logs/e0423_move_all.log: key world, world tour, H4 readers, arena, menus; 790 runs, 257,909 VBlanks) the traces are the same, and every run ends on the reference's screen; 51 runs differ for a few VBlanks (at most 5, in ar03!). E-0421's design had ended two runs on other screens (bb19! a frame behind, ls12b!'s battle on another turn); neither happens now.
- **A recipe offset into a script.** The late-story recipe started DARCK_TAUNT at Script_SurprisinglyObedientAreYou+33. In a moved copy, far commands can be longer, so the offset lands elsewhere. The point now has a label, Script_SurprisinglyObedientAreYou_AfterBattle (config/script_entries.json entries may also name a point inside a started script), and tests/test_script_bank.py refuses `label+offset` script pokes in recipes.
- **Tests.** tests/test_script_sections.py: the empty-bank number, and the moves (bank $9F begins with $9F). tests/test_script_bank.py: the far variants' sizes, the game handlers unchanged, the moved farm chain. tests/test_sections.py: the new bank_check warning.
- **Probes (config/probes/E-0423.json, 3 of 3 pass).** GreatLogTalkEvents_Breeder sets wDataBank = $0E and wScreenTableIndex = 0 and starts Script_ILostAgainI, or Script_ILostAgainI_2 with EVENT_I_LOST_AGAIN_I_NEED set (the E-0422 note's probe). LoadTileListSixPerCall, given BreedMenu_ReloadTiles_DestList as the breeding menu passes it, copies the tiles at $9D00 + 16 * n to $8C00, $8C10, $8C20, $8C70, $8C80 and $8C90.
- **Checks.** No drift (265 files); build/run_e0423d PASS, 0 differing bytes; bank_check 0 errors, 0 warnings, 548 asserted, 0 literal, 1 unread.
- **Limits.** C2 on the project's emulator. "Timing-neutral" is shown for the recipe chains, not proven for all code paths; it rests on the game's handlers being unchanged. Moved bank-$10 scripts still cost more cycles per byte than unmoved ones. The 64 wider bank_check candidates were not reviewed.

### E-0422 — The leftover scripts read as script; data-bank script sections move; the breeder's wDataBank is unread

- Date: 2026-10-21. Kind: OBSERVATION (source, the reference ROM and tools/sm83.py), source change (no byte changed) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 3d5b733. Details: [shiftability](SHIFTABILITY.md), "E-0422".
- **The raw bytes after eight bank-$10 scripts (C2 for the bytes, C1 for "leftover").** E-0421 left 8 runs (10 with the runs their skips reach) in bank $10 because they ended in `db` lines after their `script_end`. Read with the opcode table, every one of those bytes decodes as script up to the last byte: 21 short scripts. Two are lone `$FF` end bytes, as other scripts keep after a jump. No label, pointer or recipe names the others, so nothing starts them; they are leftovers. config/script_entries.json lists the 19 as script entries that tools/disasm_all.py traces like the started ones. Each is named after the script it follows (Script_OhYou_4_Leftover, ..._Leftover2), so it takes no number from the quote-based names. Their `script_set_flag` lines name no story flag (D-009), so no existing name changed. Two continue with `script_jump_data_bank` to Script_Shop and Script_It_3; they are traced with wDataBank = $10, as the scripts beside them are started (C1). Now all 656 bank-$10 runs (6,458 bytes) can move with tools/script_bank.py, with 424 stubs; bank $10 gains 4,685 bytes.
- **Arena and breeding scripts (C2).** No bank-$10 script uses SCRIPT_ARENA, SCRIPT_BREED or SCRIPT_NPC_BREED; those scripts are data-bank scripts in banks $0C, $0E and $15. The talk routines name their bank with BANK(target) (E-0420). In bank $15, Script_Breed sat inside a section of tile data that bank-$15 code reads in place, so it could not move without that data. tools/present.py now starts a section at a Script_ label after data or ended code, and at a non-script label after a script's last line. That gives 16 new sections (9,244 to 9,260), the same bytes and the same order:
  - Script_Arena and Script_Arena_9 ($0C), Script_KeyAppraisal ($0D), Script_ItsAccessoryIsIn ($0E), Script_Breed ($15), Script_Hibernate and two more parts ($1D), Script_SwapMonsters ($1F), Script_EggService ($96);
  - the code or text after them.
  `script_boundary` takes a lone `db $ff` for a script's end byte; a `db $ff, ...` data line is not one.
- **A script jump between banks is an error.** tools/bank_check.py now reports a `script_jump`, `script_skip_if_no` or `script_choice_jump` whose target lands in another bank. The interpreter reads on in the bank the script comes from, so sections that jump to each other must move together. Moving Script_Arena alone is refused (`script_jump Script_Arena_9 jumps to bank 0C`); tools/move_section.py now takes `--move` more than once, and the two arena sections move together.
- **Moved and run (tools/sm83.py).**
  - **Breeding.** With Script_Breed moved to $9F, all 122 runs of the breeding chain (31,573 VBlanks) are identical to the reference, and the script trace is the same (187 fetches). This covers the breeding menu's resume of its script in data-bank mode after the nested talk events.
  - **Priest and library.** With the Script_Priest section (priest and library) moved to $9F, all 128 runs of the priest chain are identical (210 fetches, 15 in the moved scripts).
  - **Arena.** With both arena sections moved to $9F, an arena run from Main Street (A every 30 frames for 18,000 frames) goes through a grid battle and back. At the end of every battle, BattleEnd_Result_SetResult restores wDataBank from wDataBankSave, so the script resumes after ArenaScene_RestoreCallerScript in mode 1 from bank $9F (bank $0C in the reference). All 55 fetches, the game modes and 600 sampled screens are the same as the reference's.
    The run is kept as tools/recipes/e0422_arena.txt. Replayed as a chain on both ROMs, its 107 runs (46,666 VBlanks, with e0327's) are identical VBlank by VBlank, with the same trace (176 fetches, 32 of them the arena's; build/logs/e0422_arena_moved.log).
  - Moving data adds no cycles, so these runs match frame for frame, unlike E-0421's interpreter patch.
- **The recipes name their scripts.** Eight more recipe lines started data-bank scripts by raw addresses (breeding, library, priest, hibernation, medals, keys twice, swap); they now use BANK/LOW/HIGH(label) (E-0421), and tests/test_script_bank.py checks that no recipe pokes a raw script address.
- **GreatLogTalkEvents_Breeder's wDataBank = $0E (E-0420's one literal, C2).** On tools/sm83.py, from Main Street with every read of wDataBank logged, the talk runs Script_ILostAgainI to its end, and Script_ILostAgainI_2 with EVENT_I_LOST_AGAIN_I_NEED set by hand. Each was run with the answer yes and with no, and 300 frames on: wDataBank is never read. Neither script has an opcode that reads through it, and nothing sets EVENT_I_LOST_AGAIN_I_NEED, so Script_ILostAgainI_2 is unreachable in play. The store is a leftover of the NPC breeders' form, whose scripts go on in bank $0E. Its routine's note said "(scripts in bank $0E)"; both scripts are in bank $10, and the note now says so (config/annotations.json). The line keeps its number with the comment "nothing reads it", which tools/bank_check.py lists as "unread" (literal: 0).
- **Checks.** No drift (265 files); build/run_e0422c PASS, 0 differing bytes; bank_check 0 errors, 0 warnings, 545 asserted, 0 literal, 1 unread. Tests: tests/test_script_sections.py (new), tests/test_script_bank.py and tests/test_sections.py updated.
- **Limits.** "Leftover" rests on finding no reference, not on running them. The arena run covers one battle and one resume; the other data-bank sections (keys, swap, hibernation, NPC breeding, egg service) were not moved and run, only given sections.

### E-0421 — Event scripts in any bank, for mods: the interpreter patched, bank $10's scripts moved

- Date: 2026-10-20. Kind: TOOL and OBSERVATION (tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit e2e6208 (with E-0420). Details: [shiftability](SHIFTABILITY.md), "E-0421"; guide: [making a mod](MODDING.md#event-scripts-in-other-banks).
- **Correction of E-0419.** Bank $10 is not full: it ends in 5,848 bytes of fill (`ds $16d8` in src/; the reference's bank $10 ends in 5,848 zero bytes from $6928).
- **How the interpreter reads (C2, read from src/ bank $10).** FetchScriptCommand reads a script from the mapped bank, or, after `script_jump_data_bank` (opcode $E7, wScriptInDataBank = 1), from the bank in wDataBank. Only FetchScriptCommand_NextOpcode and the message, skip, jump, choice, message-unless-flag-0 and message-by-screen handlers read through wDataBank. The walk, face, wait, hold-pad, set-flag, slide, hide, encounter, add-gold, sound and generic handlers read their operands with `ld a, [hli]` from the mapped bank, so the game's data-bank scripts (banks $1F and others) use only opcodes that work there. Scripts are started by StartScriptAtHL_B04 and StartScriptAtHL_B13 (the only writers of wScriptPointer outside bank $10 besides the arena and breeding resumes, which set mode 1 themselves).
- **tools/script_bank.py (new), on a mod's copy only.**
  - `patch`: ReadScriptWord and ReadScriptByte (home bank) read in modes 0 (mapped bank), 1 (wDataBank, as the game) and 2 and up (that bank). Every handler's script reads go through them: 7 `call ReadWordFromDataBank` become `call ReadScriptWord` and 20 `ld a, [hli]` become `call ReadScriptByte`. ScriptFetchJumpDataBank reads its address before setting mode 1. Opcode $08 (unused) becomes `script_jump_far`, a bank byte and an address; bank $10 gives mode 0. Both StartScriptAtHL routines jump to a home-bank StartScriptAtHL, which first clears a mode of 2 or more.
  - `move LABEL... | --all --to BB`: bank $10's scripts form 637 runs, each from a label after a terminator to the next. 627 can move (6,207 bytes); 10 hold raw bytes not read as script and stay. Runs joined by relative jumps move together. Moved labels become X_Far; a `script_jump` to a script left in bank $10 becomes `script_jump_far`. Every label named outside the moved runs keeps a stub, `X:: script_jump_far X_Far` (416 stubs for `--all`), so the 440 asserted starters and every script table stay as they are. It refuses runs with SCRIPT_ARENA, SCRIPT_BREED or SCRIPT_NPC_BREED (their menus resume the script in mode 1) and labels used with an offset. A refusal changes nothing. mod.json `"scripts"` runs it in tools/make_mod.py.
- **A fault the chains found.** The first move left the far mode set when a scene command ended a moved script without `$FF`. The next script, Script_ListenYouTwoQuit, was then read from bank $9F at its stub's address, and Tara never joined the party (farm chain, run s25). The game's own scripts run in mode 0, so this never arose there. The StartScriptAtHL change above fixes it.
- **Checks (tools/sm83.py, C2).** `move --all --to 9F` builds, with every bank exactly full (linker map: 0 bytes free in ROM0 and all ROMX banks). All 17 recipe chains (279 distinct runs, every chain but the link ones) were replayed on the reference and on the moved ROM (build/logs/e0421_chains_part1.log, part2.log). At every opcode fetch the script position was recorded as label + offset (`_Far` dropped, stubs skipped). The traces are the same in every chain, up to 398 fetches (the key-world chain). The screens were compared at each VBlank:
  - most runs are identical, or differ for 1-3 VBlanks and end on the same screen;
  - sh13! (in the shop) differs for 8 VBlanks and ends the same;
  - bb19! (breeding, the chain's last run) ends one frame behind: 580 of 580 later VBlanks match at a shift of one;
  - ls12b! (the boss battle after the CYAL_ROLT scene) takes another turn ("Patta took 166 damage!" for "Moahm attacked!"). RAM is the same as the reference's at the end of ls12! apart from the script pointer, wDataBank and the stack. A build with the interpreter patch alone, nothing moved, gives the moved build's screen exactly, so the cause is the patch's extra cycles moving a button press, not the moved scripts (C1).
- **The late-story recipe.** e0406_late_story.txt started 14 scenes by poking raw bank-$10 addresses into wScriptPointer; on the moved ROM those ran other bytes. Pokes may now be `BANK(label)`, `LOW(label)` or `HIGH(label)` (tools/play.py), resolved from the played ROM's symbols, with X_Far preferred to a stub. The 14 lines name their scripts, and tools/shift_test.py leaves such pokes to the symbols. mod_check.py gains `--recipe FILE --compare`, a VBlank-by-VBlank comparison of a chain with the original.
- **Tests.** tests/test_script_bank.py: runs and sizes, refusals, label pokes, the move and its link map, bank_check on the moved tree, the farm chain's trace and screens (35 runs; at most 3 differing VBlanks a run, all ending the same), and a broken stub caught.
- **Limits.** C2 on the project's emulator, not hardware. The traces cover the scripts the recipes reach (up to 398 fetches), not all 627 runs. Commands that end a script without `$FF` are handled at the next start, not where they end. The ten raw-byte runs and the arena and breeding scripts stay in bank $10.

### E-0420 — Bank numbers stored in wDataBank or passed to a bank copy; room in banks $09 and $0D

- Date: 2026-10-20. Kind: OBSERVATION (source, the reference ROM and tools/sm83.py), source change (no byte changed) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit e2e6208. Details: [shiftability](SHIFTABILITY.md), "E-0420"; [translating](TRANSLATING.md).
- **Two forms E-0419 did not check (C2, read from src/ and the build's .sym).** `ld a, $NN / ld [wDataBank], a` (70 sites) gives ReadWordFromDataBank, and the scripts' data-bank mode, a bank by number; `ld b, $NN` before CopyFromBankWaitVRAM or OrFromBankWaitVRAM (21 sites) gives the bank they copy from. None had an ASSERT. Bank $09's key names were read this way (`ld b, $09` in DrawKeyListPageNames, LinkKeyTrade_WriteStoryKeyName and CopyDataBankStringToTextBuf0; `ld a, $09` twice before the last), which is what kept bank $09's table from moving.
- **90 of 91 now name a label** (config/operands.json, written by the generator; same bytes):
  - 66 wDataBank stores in talk routines, before or after starting a script: the bank of the scripts' `script_jump_data_bank` targets, all in one bank per routine (`BANK(Script_Priest)`, `BANK(Script_Shop_5)`, `BANK(Script_Rename)`, ...). So the game already reads scripts from banks $0C, $0D, $0E, $15, $1D, $1F and $96 besides $10;
  - 9 tile copies from bank $1F: `BANK(GlyphFont)`. All 534 pointer words into bank $1F from outside it are `GlyphFont + n`;
  - 9 name copies from bank $08: `BANK(StringDatabase)`, the list each routine reads through wDataBank just before;
  - bank $09: `BANK(StringList_Bank09_StringCategories_6)` x2, `BANK(CopyKeyNameWordToDE_StringList)` x3;
  - ReadBank6TableWord: `BANK(AIPersonalityWeightTable)`.
  Left: GreatLogTalkEvents_Breeder's `ld a, $0e`; its two scripts (Script_ILostAgainI, Script_ILostAgainI_2) read nothing through wDataBank (C1, read from the scripts). Five local labels lost the number in their name (`.set_data_bank_to_10` is `.set_data_bank`).
- **tools/bank_check.py** reports both forms as "literal": 91 on the source before, 1 after (tests/test_sections.py).
- **Bank $09 (tools/text_spill.py spill-categories).** It now accepts code outside the two lookups that reads one category in the form `ld a, BANK(table) / ld [wDataBank], a / ld hl, table / ld a, 2 x category / add_a_to_hl`. When that category moves, such a reader is pointed at the new bank's table, which has the category at the same index. It refuses a moved list that anything but its table names (BANK(list) excepted) or that an ASSERT ties. `spill-categories 09 4 --to 9D` moves categories 4-9 (7,052 bytes). Category 3 (CopyKeyNameWordToDE_StringList) cannot move: the home-bank CopyKeyNameWordToDE reads it by address.
- **Bank $0D (new: spill-strings BANK N --to BB).** One category of 47 strings, 152 bytes free. The lookups gain `cp N` on wStringIndex and far-call the new bank below it. The list keeps its length with `dw $0000` for the moved ids, because MedalPrizeMenu_DrawPrizeNames and MedalPrizeMenu_ChoosePrize_ShowDescription read ids from $28 on straight from the list (`add $28`). N stops below the lowest such base, and below a string that ids on both sides share: ids $25-$28 share String_0D_00_25, so N is at most 37 (1,313 bytes). E-0418 said bank $0D's lookup has 7 extra bytes. Its lookups pass the shape check; the refusal was the two direct readers.
- **Checks (tests/test_text_spill.py, ReaderSpills, on tools/sm83.py, C2).**
  - Both banks are spilled in one copy, and ten bank-$0D strings are grown by more than its 152 free bytes (refused before the spill). The copy builds.
  - All ten bank-$09 categories (260 ids) and all 47 bank-$0D ids show and copy the reference's string, except the grown ones.
  - DrawKeyListPageNames draws the same names for the 13 story keys (category 6, read through bank $9D).
  - MedalPrizeMenu_DrawPrizeNames draws the same 7 prize names.
  - With the key-name reader's bank put back to $09 in the ROM, the names differ.
- **Checks (source).** The generator writes src/ again (tools/src_drift.py: 265 files identical). build/run_e0420 PASS, 0 differing bytes.
- **Limits.** "All targets in one bank" and "the scripts read nothing through wDataBank" were read from the scripts in bank $10 (following jumps, skips and choices), not run for every talk.

### E-0419 — Readers that named a table's bank by number: BANK(table), the reader's bank, or an ASSERT

- Date: 2026-10-20. Kind: OBSERVATION (source and tools/sm83.py) and source change (no byte changed). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 429fb20. Details: [shiftability](SHIFTABILITY.md), "E-0419".
- **Scripts (C2, read from src/ and the map).** The 424 asserted script loads, which are now 440, put a pointer in wScriptPointer with no bank. The interpreter in bank $10 reads script bytes from its own bank, and bank $10 has 0 free bytes: about 12 KB of scripts and 4 KB of interpreter. A script can leave bank $10 only if the interpreter changes. No same-bytes edit can do that, so they stay asserted.
- **A number beside the load → BANK(table)** (config/operands.json, written by the generator):
  - 9 `ld b, $NN` in switchable banks, the bank of a copy helper (FieldSpritePalettes, SharedOBJPalettes x4, GlyphFont x4);
  - 7 in the home bank: 2 `ld b, $NN`, and 5 `ld a, $NN` written to rROMB0 to read the table (MonsterPaletteTable, SharedOBJPalettes, MonsterSpriteTable, CopyKeyNameWordToDE_StringList, GlyphFont, MonsterAttributeMapTable x2).
- **A routine in the table's bank reads it → `ASSERT BANK(T) == BANK(Reader)`.** 23 loads whose code far-calls DrawTileRectFromArg1Params, FillTileRectWithArg1Tile (bank $1F), LoadTileListSixPerCall (bank $1D) or TestBitInFieldAtArg3 (bank $15). Those routines read the table with their own bank mapped and switch no bank (read from src/). The table now moves with its reader, not with a number.
- **Loads that were tied to a bank without an ASSERT.** tools/present.py and tools/bank_check.py counted any `ld b, $NN` or farcall within three lines as naming the bank, and skipped the home bank. That hid 46 more fixed ties:
  - 16 script loads, title-screen tile maps ($E1), digit tiles ($31), sprite graphics ($7D), map screens and tile rectangles;
  - 5 home-bank loads (MapTable, GlyphFont x2, CopyGlyphTilesToVRAM_Data1/2).
  Only BANK(label) beside the load, or in the code that runs on to the read, now counts. Those 46 carry ASSERTs. The walk (`_run_after`) passes conditional `jr` and local labels jumped to only from it, and bank_check uses the same walk. Result: 545 asserted loads (522 by number, 23 by reader), 0 warnings, 0 errors. tools/move_section.py, which used the old rule to decide which references cross banks safely, now uses the same per-label one.
- **A table moved (tests/test_fixed_bank_readers.py).** MonsterAttributeMapTable (383 far pointers) moves to the empty bank $9E in a copy, and the copy builds. LoadMonsterPictureAttributes then writes the same VRAM attributes for all 383 monster ids on tools/sm83.py (227 of them not the plain palette). With its operand put back to $38, 351 ids differ.
- **A test that never ran.** E-0410's two tests in tests/test_present.py sat after a module function's `return`, so Python never ran them. They are back in their class and pass, beside two tests of the new rules.
- **Checks.** The generator writes src/ again (tools/src_drift.py: 265 files identical). build/run_e0419b PASS, 0 differing bytes.
- **Limits.** Most of the 522 numbered asserts are scripts and graphics read through a helper in another bank, or with a bank stored in RAM earlier: those readers still fix the bank. "Read by X in its own bank" is a reading of X's code (C1), checked by the link equality, not by running every caller.

### E-0418 — Room for battle text: whole string categories moved to an empty bank

- Date: 2026-10-20. Kind: TOOL and OBSERVATION (tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Guide: [translating](TRANSLATING.md#moving-messages-out-of-a-full-bank).
- **The battle text (bank $2F, read from src/).** It has no split. BeginStringDisplay_Bank2F and CopyStringToBuffer_Bank2F are `ld de, table / call / ret`, with six categories:
  - 0: 137 strings, about 6 KB;
  - 1: 256 strings, about 7.6 KB;
  - 2-4: six short strings;
  - 5: 34 strings, about 1.2 KB.
  Only 725 bytes are free.
- **`tools/text_spill.py spill-categories BANK FIRST --to BB`.** In a mod's copy, it moves categories FIRST and up, with their lists and strings, to an empty bank. That bank gets the number at $4000, two lookups and a category table, with $0000 for the categories that stay. The bank's two lookups become `cp FIRST` on wStringCategory, with a farcall to the new bank: 21 bytes instead of 7, the same form bank $08's lookups use from category 9 on. It refuses when:
  - a lookup is not that shape (bank $0D's has 7 more bytes after it);
  - the table is named anywhere else (bank $09);
  - a string is shared with a category that stays;
  - the target bank is not empty.
  A refusal changes nothing. mod.json `"spill": [{"bank": "2F", "categories_from": 1, "to": "9D"}]` runs it in tools/make_mod.py.
- **Checks (tests/test_text_spill.py, CategorySpill).**
  - Categories 1-5 to bank $9D move 9,394 bytes, and bank $2F's fill goes from 725 to 10,101 bytes.
  - All 433 (category, id) pairs show and copy the reference's bytes.
  - In the E-0320 debug battle (from d06!, 1,310 printer events), the spilled ROM draws the same glyphs on the same frames. Nineteen lookups go through bank $9D, for categories 1 and 5.
  - With 60 category-1 strings grown by 18 bytes each (more than bank $2F had free), only those ids differ. The battle draws the reference's text up to a grown string, then its added words.
- **Limits.** C2 on the project's emulator. One battle is replayed, not every battle message.

### E-0417 — The text in code and data banks, exported for translators; bank $0E's message group

- Date: 2026-10-20. Kind: TOOL and OBSERVATION (tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Guide: [translating](TRANSLATING.md).
- **What H3 missed.** tools/text.py read src/text/ only (5,407 entries), but 1,084 more text blocks sit in code and data banks:
  - bank $0E's 152 messages;
  - item descriptions (bank $24), default names (bank $14), the gift and link banks' dialogue;
  - the staff credits (bank $E0), the name-entry keyboard;
  - name fields of records.
  None of them were translatable, and `free-glyphs` listed 75 codes when only 26 are unused (4 blank). The other 49 are used by that text, 53 codes in all by it alone (the keyboard among them). A letter drawn over one would have changed it.
- **tools/text.py now reads every bank file but the home bank,** whose one quoted block is the cartridge header: 6,491 entries in all.
  - A db line's `; comment` is cut off before parsing, since a `$0B` in it would read as a byte. Edits keep each line's comment.
  - An entry outside src/text/ is a message when it waits or speaks (<PROMPT>, <WAIT>, <VOICEn>), and a string otherwise.
- **Fixed lengths.** An entry may change length only when the game finds it by its own label (a pointer list or a load), it ends with $F0, and a label, blank line, comment, fill or section follows it. The other 26, such as the 10-byte names in PresetMonsterRecords and the 181-byte keyboard, must keep their bytes. Their edits are written along the old lines, so `db $01` and `db "Bob@", $f0, ...` keep their form and comments.
- **Bank $0E's group.** BeginMessageDisplay_Bank0E and CopyStringToBuffer_Bank0E split at $88 into bank $96, like the twelve groups of E-0416. tools/text_spill.py now takes that name and src/data/: thirteen groups. Bank $0E has 19 free bytes.
- **Checks (tests/test_text_banks.py).**
  - The round trip of all 6,491 entries is identical.
  - Refusals: a record field one byte longer, and ten bank-$0E messages grown with no spill.
  - A copy with bank $0E spilled by 11 (to $7D, in bank $96) and four entries edited builds. On tools/sm83.py, BeginMessageDisplay_Bank0E shows the new message for ids 0-11, the ids that name it, and the other 148 ids are unchanged. The gift bank's and the credits' lookups show their new text. ItemDescriptionTable[13] points at the new description.
  - The opening's 3,000 frames match the reference.
- **Limits.** The fixed-length rule is static: a string the game reads by position but that also has a pointer would be let change length. Widths of strings outside a list are their own longest line.

### E-0416 — Room in a full message bank: the split message groups spilled to their overflow tables

- Date: 2026-10-19. Kind: OBSERVATION (source and tools/sm83.py) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit dc53d37. No change to src/. Guide: [translating](TRANSLATING.md#moving-messages-out-of-a-full-bank).
- **The twelve split groups (read from src/).** Banks $28, $29, $2A, $2B, $2C, $2D, $2E, $7C, $80, $82, $83, $89. In each, BeginStringDisplay_BankBB and CopyStringToBuffer_BankBB compare wStringIndex with a split byte (`cp`). Ids below it use the bank's one-category table; ids from it on far-call the overflow routines in bank $96-$99, which `sub` the split and use the overflow table. In all twelve the split equals the first list's length. No message body is named by two lists, though a list may name one body for two ids (Message_00_AC). Ids per group: 256, except bank $2B's 251 (138 + 113). Bank $83's overflow ids from $F2 (and seven ids of bank $89's) point at bodies with no $F0 end in their bank: Text_HeroHeroHeroHero is the zero tail of bank $97, written as "0" glyphs (byte $00).
- **The copy routine of bank $82 (E-0080, kept).** CopyStringToBuffer_Bank82 far-calls BeginStringDisplay_Bank82_Overflow; the tool accepts either target and keeps it.
- **tools/text_spill.py.** `groups` lists them; `spill BANK N [--to BB]` on a copy of src/ (refused on src/ itself) moves the last N pointers to the front of the overflow list and their bodies to the overflow bank. It lowers the `cp` and `sub` by N, so ids keep their messages. With --to, the overflow group (its three routines, table, list and every body) first moves to an empty bank, with the bank number at $4000 because LookupString stores the byte there in wStringBank. The routine shapes are matched line by line first. All changes are written at once, so a refusal changes nothing. tools/make_mod.py applies mod.json "spill" before the text, and tools/text.py's no-room refusal names the tool.
- **Check: all twelve groups.** In build/spilltest, all twelve groups were spilled in one copy: ten to empty banks, $2D and $80 in place, and N from 1 to 60. The copy builds. For every id, BeginStringDisplay_BankBB (wStringBank and wTextPos) and CopyStringToBuffer_BankBB (the buffer) give the same bytes as the reference on tools/sm83.py: 3,046 ids, 0 differences. 21 ids with no end mark were skipped. Bank $82's copies were compared below the lower split only. The opening's 6,000 scripted frames show the same screens as the reference.
- **Check: tests/test_text_spill.py.** It spills $28 by 9 to $9A, $80 by 17 in place and $82 by 15 to $8F. Then 30 bank-$28 messages grown by 15 bytes each, refused before the spill, fit. The differing ids are exactly those 30, and the opening first differs at frame 2,042, where the grown narration is drawn; the spill alone differs at none. Two swapped pointers are reported. The text round trip stays identical, and the moved entries export from the new file. Every refusal leaves the copy byte-identical. The same spill and growth as a mod folder (build/spillmod): tools/make_mod.py builds it, makes its patch, and its smoke test reports no crash, data run, lost progress or stall.
- **Limits.** C2 on the project's emulator, not hardware. Only the twelve groups in src/text/; bank $0E's group (src/data/) and other text banks are not handled. Comments in the moved and lowered routines get the new split, but other notes that name the old overflow bank are left as they were in a mod's copy.

### E-0415 — H6 on Linux: setup, the matching build, a mod and its patch; the suite and the generator

- Date: 2026-10-19. Kind: TEST (local runs). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit dc53d37. Machine: Fedora Linux (kernel 7.2.10, x86-64), Python 3.14.8; the project's earlier runs were on Windows.
- **Setup.** In a checkout with no tools/rgbds/ and no local/roms/, `python -I tools/setup.py --rom ...` downloaded rgbds-linux-x86_64.tar.xz (SHA-256 `3e19e50e...dbb7`, the lock's value), unpacked rgbasm, rgblink, rgbfix and rgbgfx (`rgbasm v1.0.4`), checked the ROM's SHA-256 and copied it.
- **Matching build.** `python -I tools/build.py --out build/run1`: PASS, 4,194,304 bytes, SHA-256 `8e38a742...766d4e`, 0 differing bytes. The report records the Linux archive.
- **A mod and its patch.** `python -I tools/make_mod.py mods/example`: the shop and text edits build, and the smoke test shows the original's screens for 6,000 frames. The patch is 507 bytes (the size E-0412 recorded on Windows). `tools/patch.py apply` of it to the reference gives the mod build byte for byte (SHA-256 `d0f36788...e68860`). This meets H6's second-platform gate.
- **Generator.** `python -I tools/disasm_all.py` (2m36s), then tools/src_drift.py: no drift, 265 files identical.
- **Suite.** `tools/run_tests.py --jobs 16`: 532 tests, 515 ok, 17 skipped, 0 failures. Fourteen skips need build/listing/, which this checkout had not yet generated; three are the usual DWM2_SLOW skips. The runner exited 1 with "530 outcomes parsed for 532": test_rename and test_src_drift print a line between a test's dots and its outcome. Its pattern now allows one such line, and tests/test_run_tests.py has a case for it. Progress while a run goes: tools/run_tests.py prints a line as each file ends, and tools/suite_progress.py watches a serial `-v` log (done of total, outcomes, failures as they happen, the test running).
- **Limits.** macOS is not run, and is deferred until a Mac is available (user decision, 2026-10-19).

### E-0414 — H4: the readers mods change are in the recipe gate; a fixed-bank table moved with its readers

- Date: 2026-10-17. Kind: OBSERVATION (tools/sm83.py) and source change (no byte changed). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Description: [shiftability](SHIFTABILITY.md), H4 section.
- **Coverage.** tools/play.py --chain over e0406_world_tour, e0406_late_story and e0406_key_world: 2,720 routines, among them the H2 and H3 readers (LoadSpeciesRecord, LoadMonsterRecord, LoadSkillRecord, LoadItemRecord, ComputeSellPrice, LoadArg1PointerForScreenTableIndex, LoadScreenNumberListPointer, ShopMenu_Buy_EnterQuantity_ComputeTotal, ReadBank6TableWord, FillEncounterFromEntry, ComputeBreedingChild, BeginStringDisplay, DrawTextGlyph) except three. tools/recipes/h4_readers.txt reaches those (CollectUniqueEncounterIdsToWorkBuf2_FindTable, StartScriptedEncounterTemp0, ArenaRounds_RandomModulo52); 2,833 routines with it. A first version that played the set battle on reached Rst38Vector (no `rst $38` is in src/: $FF bytes run as code), so the set battle runs 30 frames, past the table read; the final chain reaches no Rst38Vector.
- **Recipe gate.** `shift_test.py --pad 16 --reads all --recipe tools/recipes/h4_readers.txt`: 151 runs, 2,316 routines, 4,792,239 reads, PASS with 152 banks padded by 16 (build/shift_h4).
- **Moved table.** ScreenNumberListTable and its price lists became a section of their own; its four readers' `ld b, $f2` and MonsterSpriteTable's three `ld b, $04` became `ld b, BANK(...)` (the same bytes; build PASS; 508 asserted loads, 0 warnings with tools/bank_check.py's new later-BANK rule, tests/test_sections.py). `move_section.py --move "Bank F2 ScreenNumberListTable" --to 8A`: builds, no bank-check error, frames equal; the game's ShopMenu_Buy_EnterQuantity_ComputeTotal gives the same 342 totals on both builds, with and without the GoldPass (tests/test_move_table.py).
- **Limits.** The gate covers what the recipes reach (2,833 of about 9,800 routines); other tables read with a fixed bank (the 508 asserted loads, most of them scripts in bank $10) still need their readers changed before they can move.

### E-0413 — H7: a modder's guide and three tutorials, each followed from a clean copy

- Date: 2026-10-17. Kind: DOCUMENTATION and TEST. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
- **Docs.** docs/MODDING.md (setup, the three ways to change the game, mod folders, the smoke test, sharing patches, the confidence tags in plain words) and docs/tutorials/1_monster_stats.md, 2_text.md, 3_breeding.md, each with its mod folder in mods/tutorial_*.
- **Checks** (tests/test_tutorials.py, on tools/sm83.py): tools/make_mod.py builds each tutorial's mod from a copy of src/ and runs the smoke test (no crash, no data run, the original's progress), then the game's own routine shows the change on the modded ROM:
  - LoadMonsterRecord copies base HP 99 for monster 1 (the Slime);
  - the narration's bytes at Message_00_00 are the new text, and the screens differ from where the scripted opening draws it;
  - ComputeBreedingChild gives MetalKing for DrakSlime x Slime and still SlimeBorg for DrakSlime x SwordGon (two lists grown, taken from bank $0E's fill).
- **Limits.** "From a clean checkout" is a copy of src/ in the test; tools/setup.py's download on a fresh machine is checked in E-0412, the second platform not run.

### E-0412 — H6: patches, a patcher page, mod folders and a cross-platform setup

- Date: 2026-10-17. Kind: TOOL and TEST. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
- **tools/patch.py.** BPS patches (make, apply, info): SourceRead where bytes are unchanged in place, SourceCopy for runs found elsewhere in the source (moved data), TargetRead for the rest; apply refuses a source whose size or CRC32 is not the patch's, and a damaged patch.
- **patcher/index.html.** A page that applies a BPS patch to the player's own ROM in the browser (no network); its JavaScript, run under Node.js, applies the example mod's patch to the same bytes as tools/patch.py and refuses an already patched ROM.
- **tools/make_mod.py and mods/example.** A mod is a folder of edits (data, text, charmap lines, font PNG, replacement source files) applied to a copy of src/, built, smoke-tested and turned into NAME.bps. The example (a shop percentage and a line of text) gives a 507-byte patch; applied to the reference it gives the mod build byte for byte.
- **tools/setup.py, tools/toolchain.py.** config/toolchain.lock.json records the RGBDS v1.0.4 asset and SHA-256 for Windows, Linux x86-64 and macOS (from the release's published metadata). setup.py downloads and checks the asset for the platform it runs on and unpacks the four programs; build.py, assets.py, shift_test.py and move_section.py find them through toolchain.py instead of `.exe` names. The Linux and macOS archives were downloaded and checked against their digests here and hold ELF and Mach-O programs.
- **Gate.** Windows: a clean copy builds a mod and its patch, and the patch gives the mod. The second platform: NOT RUN (no Linux or macOS machine or WSL in this session); the commands are in docs/MODDING.md.

### E-0411 — H5: a smoke test for mods

- Date: 2026-10-17. Kind: TOOL and TEST (observations of tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
- **tools/mod_check.py.** Runs a mod and the reference from power-on with tools/shift_test.py's scripted buttons and compares every frame's video state. It reports:
  - a crash (invalid opcode) with its routine;
  - code running data: an instruction fetched from a data label of the mod's tree (the reference fetches none in 6,000 frames);
  - lost progress: the order of game modes in wGameMode (reference: 0, 5 from frame 22, 1 from frame 1,331);
  - a stall;
  - the first differing frame and how many differ.
- **Negative tests** (tests/test_mod_check.py, 3,000 frames). An unchanged build: identical, nothing reported. The title's entry of the game-mode jump table pointed at GlyphFont (a broken pointer): the modes go 0, 5, 0 from frame 63 and never reach the field, so progress is reported. That mod does not crash and does not fetch from a data label, because the jump lands on code in whatever bank is mapped at $4010, which is why progress is checked. The glyph of 'I' blanked (a broken table): the screens differ, with the same progress and no crash.
- **Limits.** Only what the scripted play reaches (the opening and the first walk); differences in what is shown are reported, not judged.

### E-0410 — A completed link breeding, a key world entered at the shrine, and Darck's taunt on his map

- Date: 2026-10-17. Kind: OBSERVATION (emulator runs; recipes only, no source or byte change). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 41a7d3d. Details: [shiftability](SHIFTABILITY.md), "A linked breeding, the shrine and Darck's taunt". Observations of tools/sm83.py and its serial model, not hardware (C2 within that scope).
- **E-0406's link reading rejected.** E-0406 read console B's presses as not moving its choice. Its trace showed B on link step 14, which runs BreedMenu with wScreenState 4 and so BreedMenu_ChooseParents_YesNoCursor: the Info / OK box. There each Up or Down press (wJoypadPressedRepeat bits 6 and 7) toggles wChoiceCursor, and B's four Down presses ended on Info, whose A press opens the stats screen. Each press did reach the screen (wJoypadPressed $80 for one call). The serial model's timing is not implicated.
- **Linked breeding.** tools/recipes/link_e0406_breeding.txt now runs 54 runs to the end, replayed twice with the same screens (tools/link_play.py with `--shots`):
  - A picks Stera (male WingSlime, level 11).
  - B is refused Patta (level 4, "This one is too young to breed.") and Moahm (a party member, "Choose from the farm's roster."), then picks Reny (female Petiteel, level 12) on the second list page.
  - Both choose Breed and Yes to "Is it OK to record the results?", and "The monsters like each other." follows.
  - The egg scene runs ("The two monsters went away quietly..."); A receives PearlGel's egg and B Petiteel's egg, then "Please raise it with loving care.".
  - Both return to the title menu; their cartridge RAM differs from before the session in 5,024 (A) and 4,916 (B) bytes.
- **The shrine.** Header byte 7 of the bank-$11 map records (wMapHeaderByte7, LoadMapHeader) is non-zero in 13 records, always $2C: map 3, map $3B and the 11 maps sharing record $500C (read from MapTable).
  - Map 3 is the key shrine. Facing its gate one tile up, an A press runs CheckInteractionInFront: game mode 2, wModeState $0B, the plan page's key list ("Magic Key to where?").
  - A key fresh from GenerateNewKeyEntry (entry byte $FE) answers "The key could not be used yet." (PauseMenu_Plan_Keys_UseKey, message $0C).
  - Appraised first (Script_0D_62B8, as in E-0334: "This is the BlueIslet!"), the key is used: "... inserted the key.", the warp effect, and the key world's gate room (wMapType $87, player at ($40, $40)).
  - Walking down leaves the room for the world (wMapType $80, screen (3, 5)), an island; a battle starts there.
  - Recipe: tools/recipes/e0406_key_world.txt, sk01 to sk19, from the party state k03!; the party is moved to map 3 by its location bytes and given the key by a call, as reward events would.
- **Darck's taunt.** tools/recipes/e0406_late_story.txt dk01 to dk03: from k03! the party enters Darck's castle (map $A2), and Script_SurprisinglyObedientAreYou (10:$61D4, the line after its battle: "N... No... How could my") leads into DARCK_TAUNT's scene there. E-0406 had left it out: forced on Main Street it drew text through a pointer left at $010D.
- **Result.** The key world's chain (tools/recipes/e0406_key_world.txt with its includes, without the tour): 200 runs, 7,480,100 ROM data reads, 2,644 routines, PASS padded by 16 (152 banks) and by 256 (107 banks). The link recipe: 54 runs, 710,191 ROM data reads, 579 routines, PASS padded by 16 and by 256.
- **Checks.** tools/shift_test.py `--recipe tools/recipes/e0406_key_world.txt` and `--link-recipe tools/recipes/link_e0406_breeding.txt`, `--pad 16` and `--pad 256` (build/logs/e407kw16.log, e407kw256.log, e407ln16.log, e407ln256.log); build/run705 PASS (approved size and SHA-256, zero differing bytes); tools/src_drift.py: no drift, 265 files identical; serial full suite build/logs/suite705.log OK (487 tests, 3 skipped), with the doc and link test files rerun OK after the last doc edits. Rebased onto master 94845d6 (H1 to H3, E-0407 to E-0409): build/run706 PASS; the four gates again PASS with the same counts (build/logs/e410kw16.log, e410kw256.log, e410ln16.log, e410ln256.log); serial suite build/logs/suite706.log OK (509 tests, 3 skipped).
- **Drift resolved.** After the rebase tools/src_drift.py reported one file: E-0407 had fixed three comments in bank $60 by hand (wKeyWorldBossMonsters, not defined in src/ram.asm, now wKeyWorldMonsters + $40 and + $41), but the generator still wrote the old name from the notes of GenerateKeyWorld_RollMonsters_Boss, _BossLevels and _BossLevelsAlt in config/names.json. Those three notes now say the same as src/, and src/ takes the generator's line wrapping for the two longer comments (comment lines only). tools/disasm_all.py then tools/src_drift.py: no drift, 265 files identical; build/run707 PASS (zero differing bytes); serial suite build/logs/suite707.log OK (509 tests, 3 skipped).
- **Drift after H4 (E-0414) resolved.** Rebased again onto master 737180e (H4 to H7), the regeneration differed from src/ in five files: E-0414 had written seven `ld b, $04` / `ld b, $f2` loads as `ld b, BANK(MonsterSpriteTable)` and `ld b, BANK(ScreenNumberListTable)` (dropping their ASSERTs) and given ScreenNumberListTable a section of its own. The generator now writes them too: config/operands.json `values` entries for the seven loads (01:63AB, 1D:6926, 1D:6985, 1C:4B10, 1C:5064, 1C:5F04, 1C:5F37, found as `06 bb CD` + the reader's address in the reference ROM), whose `expr` now also applies to an 8-bit `ld r, $XX` with an optional `comment` (tools/disasm_all.py); tools/present.py leaves out the ASSERT when the same block, before any label, loads BANK(name) (a load after a label keeps it, as in bank $F0), and starts a section at a label listed in SECTION_STARTS. tests/test_present.py covers both. tools/disasm_all.py then tools/src_drift.py: no drift, 265 files identical; build/run709 PASS (zero differing bytes); serial suite build/logs/suite709.log OK (532 tests, 3 skipped).

### E-0409 — H3: the text for translators, the font as a PNG, a test translation drawn by the game

- Date: 2026-10-17. Kind: TOOL and OBSERVATION (C2 on tools/sm83.py for what the test translation shows; widths C1). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Description: [translating](TRANSLATING.md).
- **tools/text.py.** 5,407 entries: every labelled block of `db` text in src/text/, with the pointer tables that use it. The text form is the db strings joined, with argument bytes as {$xx}. Import re-renders a changed entry with tools/gb_text.py (all 5,407 blocks re-render from their bytes to the same bytes; 5,405 to the same lines, and Message_0B_8F and String_88_02_AD end in raw bytes after their end mark that re-render as text). The bank's trailing fill takes the change in length. Import stops on an unknown character, a line wider than its limit, or a bank without room. The charmap is read from src/charmap.inc too, so a CHARMAP line adds a letter.
- **Widths (C1).** The longest dialogue line in the 12 message banks and the battle text is 18 cells (one 20-cell case is two parts joined by <CURSOR>); the text window is 20 tiles. String limits are the longest original entry of the same list.
- **Font.** GlyphFont (bank $1F) is 185 glyphs, codes $00-$B8, 1 bit per pixel in the odd bytes. font-export and font-import convert it to a 128 x 96 PNG and back; the round trip changes nothing. 75 codes are used by no text and named by no CHARMAP line, 49 of them blank.
- **Test translation** (tests/test_text_pipeline.py). In a copy of src/:
  - `CHARMAP "ü", $49` added, and its glyph drawn in the font PNG and imported (one glyph changed);
  - Message_00_0A's first part made German ("Gleich sind wir / über GreatLog da." and "Ich bin gespannt!"), longer than the English, taken from bank $28's 47-byte fill.
  - It builds as a mod. The E-0320 chain is replayed on the reference to state s13, the modded ROM is swapped in (it differs only in banks $1F and $28), and the conversation is played (U2 W10 A W4, then 300 frames). DrawTextGlyph draws the German bytes in order, $49 among them, and GlyphFont + 16 x $49 in the modded ROM holds the new rows.
- **Refusals.** Grüße without its CHARMAP line, a 29-cell line, and 30 entries of bank $28 grown past its fill are refused.
- **Limits.** Only src/text/; moving messages to an overflow bank (the $DA split of message group 0 into bank $97) is a code change by hand, documented but not done by the tool; widths C1.

### E-0408 — H2: the data tables as editable files, checked against the game's readers

- Date: 2026-10-17. Kind: TOOL and OBSERVATION (C2 on tools/sm83.py for the reader checks; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Description: [editing data](EDITING_DATA.md).
- **tools/datatables.py.** Reads the tables from src/ as value tokens, mapped onto fields by byte width with config/tables.json's layouts: 181 tables (species, monsters, skills, items, 111 encounter entries and 48 grids, scripted and arena encounters, the seven breeding tables and their lists, shops, AI weights), 4,116 records or entries. `import` rewrites only changed tokens; a list may change length and the bank's trailing `ds` fill takes the difference (refused when it is too small). tools/build.py `--src DIR` builds another tree (a mod unless identical).
- **Round trip.** `datatables.py check`: export, then import unchanged into a copy, leaves every file identical.
- **Edits reach the readers** (tests/test_datatables.py): one copy of src/ with an edit in each of 12 tables builds as a mod, and on the modded ROM LoadSpeciesRecord, LoadMonsterRecord, LoadSkillRecord, LoadItemRecord, ComputeSellPrice, LoadArg1PointerForScreenTableIndex (the shop list one item longer), ReadBank6TableWord, FillEncounterFromEntry (all 128 random states), CollectUniqueEncounterIdsToWorkBuf2_FindTable, StartScriptedEncounterTemp0 and ComputeBreedingChild each return the edited value; the arena list is checked by its bytes at its label. A field given a different number of values than its tokens is refused.
- **Limits.** Only these tables; new lists need their label in src/ first; adding records to a fixed table is not supported.

### E-0407 — H1 complete: src/ is checked without the generator's config or listing

- Date: 2026-10-17. Kind: TEST and TOOL (one comment correction in src/; no byte changed). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit f7cb6cd. Plan and per-file record: [graduation](GRADUATION.md).
- **Method.** A scratch copy of the tree with config/names.json, config/annotations.json and build/listing/ removed ran the full suite (tools/run_tests.py): 27 failures and 54 skips at first. Each was fixed so that the check reads src/ (and the .sym of a fresh build for addresses), or recognized as a check of the generator, which skips without the listing.
- **Moved to src/.** test_probes (the same 5,948 C2-note keys as config/annotations.json), test_constants, test_fold_idioms, test_routine_behaviour, test_present, test_story_flags, test_resistances, test_tables, test_text, test_name_claims, test_note_grounding, test_probe_scope, test_doc_coverage (details in GRADUATION.md). tools/source_tree.py adds notes, labels by address and listing_spelling (the listing's spelling of a src/ instruction). docs/PROBE_SCOPE.md regenerated from src/ is byte-identical; status_bits.py gives the same 69 lines.
- **Frozen lists.** tests/data/names_given_by_reading.txt (97 names test_name_claims exempts), tests/data/given_names.txt (10,828 names given by reading, for the readability ratchets) and tests/data/ungrounded_mentions.txt (3,339 note mentions the grounding check does not find connected, out of 34,771 now checked in every code note, against 6,605 in config/names.json; any new one fails).
- **Found and fixed.** Three comment lines in bank $60 named wKeyWorldBossMonsters, which src/ram.asm does not define; they now say wKeyWorldMonsters + $40 and + $41 (the boss entries, as the hand notes above them say).
- **Retired.** tools/apply_drafts.py (and tests/test_apply_drafts.py) and tools/rank_unnamed.py. **Added** tools/rename.py (whole-word renames across src/, refusing unsafe ones; a copy with NextTableByte renamed still builds the reference).
- **Exit gate.** A copy of the tree in build/gate/ with config/names.json, config/annotations.json and build/listing/ removed: build PASS (zero differing bytes), and tools/run_tests.py ran 491 tests with no failure (build/logs/gate3.log; 17 skipped: the generator's own checks and the 3 slow tests).

### E-0406 — The later worlds and link play for the shift gate; a serial model; two byte lists misread as pointers

- Date: 2026-10-17. Kind: OBSERVATION, TOOL and DECISION (generator config; bytes unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit e0bc01b. Details: [shiftability](SHIFTABILITY.md), "The later worlds and link play".
- **World tour.** tools/recipes/e0406_world_tour.txt: 25 encounter maps from $2B to $C3, entered by their location bytes from the party state of E-0321, walked and fought in. Screens of the Float map and of a battle on the Old maps confirm the runs reach them.
- **Serial model** (tools/sm83.py). An internal-clock transfer ends after 4,096 cycles (128 with the fast bit). If the partner has a transfer started (either clock), the SB bytes are swapped and both get the serial interrupt; otherwise $FF comes in. With no cable a transfer never ends, as before, so unlinked observations are unchanged. A model: real hardware's behavior with two clocking consoles, and its timing, are not reproduced exactly (C1). tests/test_link_play.py.
- **Link runner** (tools/link_play.py). Two consoles in cycle lockstep with separate recipes, each run ending on the same frame. The first version let them end apart, and the console behind then played alone while its partner waited, which lost its presses.
- **Link session.** Choosing BREEDING on the title menu with one console first connects, as RunLinkSession_FindPartner expects: one side sends its option code while the other waits on the same option. The breeding screens follow. A console in link role 3 reads its pad only in its send step inside the serial interrupt. Its later presses did not move its choice, so no child is bred; the cause (game or model timing) is open. (Rejected by E-0410: the presses toggled the Info / OK box, and a child is bred.)
- **Found by the tour gate.** EnterStatusEffectFieldState_Data had eleven map-id pairs decoded as `dw` of labels with the same values. In a padded ROM the scan read $5C where the base read $5D, so map $5D left the list: found in run t5Db! by stepping both ROMs in lockstep. AddSkillCToFreeOrWeakerSlot_Data (bank $1A, 170 words) had unlabelled targets as raw bytes. Both are now config/tables.json layouts, the lists named SkillSupersedes_<skill> (target_names). No `dw` of a pointer-run label is left.
- **Result.** All 222 runs of the chain with the tour (tools/recipes/e0406_world_tour.txt and its includes), 9,702,777 ROM data reads, PASS padded by 16 (152 banks) and by 256 (107 banks). Link recipe: 338,121 ROM data reads on two consoles, PASS padded by 16 and by 256.
- **Late story and a key world.** tools/recipes/e0406_late_story.txt starts 13 scene scripts of bank $10 (LAND_HO to YOU_DID_IT, without DARCK_TAUNT) by their RAM bytes on Main Street. tools/recipes/e0406_key_world.txt generates and enters the world of key 0 through the debug menu's AUTOMAP CHECK (GenerateKeyWorld) from the party state k03!, then walks and fights there. From a state with no party the first battle crashes in the emulator: GameMode4_Init_CopyPartyToBattlers runs from wBattlePartyCount 0, and its sixth $4E-byte battler record ($E00F) and fifth ($DFC1) overlap the stack, so a return address is overwritten (watched writes). That is a forced state, not play. Their chain (on e0335_swap.txt, without the tour), 178 runs, 6,690,279 reads and 2,522 routines, PASS padded by 16 and by 256. DARCK_TAUNT's script is left out: forced on Main Street it draws text through a pointer left at $010D, reading the cartridge header and the code after it (in the 16-byte gate a linear read across the padding start; in the 256-byte gate SoundNextEvent then reads a bank $140).
- **Checks.** tools/shift_test.py --recipe and --link-recipe as above; build/run702 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite702.log OK (473 tests, 3 skipped).

### E-0405 — The bred child's later rolls: sex, resistances, skill list and stat bonus

- Date: 2026-10-17. Kind: OBSERVATION (C2 on tools/sm83.py for what the check compares; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit e0bc01b. Specification: "The bred child's later rolls" in [mechanics](MECHANICS.md).
- **Method.** tools/mechanics.py `child` runs RollChildSexFromSpecies, RollChildResistancesToChildRecordResistances, BuildChildRecordSkillListCandidateList and ApplyBreedingBonusToChildStats, in turn, on generated child and parent records, and compares the child's bytes (MON_SEX, the 27 resistances, MON_SKILLS and the skill list, the eight stat words) and wRandomHi/Lo.
- **Result.** 3,000 of 3,000 agree. Every line of the four models ran.
- **RandomModulo29.** The quotient of `((lo << 1) & mask) x 256 + lo` by 41; the `rl a` takes in a carry that is always 0 at RandomByteTable's address ($0973 + at most $7F).
- **Findings** (properties of the code):
  - TestResistanceEntry hides a parent's level-2 resistance named by its item.
  - The stat bonus divides only the low 16 bits of the 24-bit product.
  - The skill list's compaction leaves old bytes after the moved ones, which the second ClearDuplicateChildSkills clears.
- **Negative checks** (tests/test_mechanics.py). A model without the item test, and one that divides the whole product, are each caught.
- **Limits.** The routines are checked one at a time from generated states, not in the order ComputeBreedingChild's caller runs them; what the bonus and resistance gains mean in play is C1.
- **Checks.** tools/mechanics.py child --n 3000: all agree; build/run702 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite702.log OK (473 tests, 3 skipped).

### E-0404 — The other damage routines of bank $36

- Date: 2026-10-17. Kind: OBSERVATION (C2 on tools/sm83.py for what the check compares; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit e0bc01b. Specification: "The other damage routines" in [mechanics](MECHANICS.md).
- **Method.** tools/mechanics.py `effects` models 28 routines, reading the families the family-dependent ones test from src/. It runs each on generated battle states: levels, HP, monster ids with their species families, body flags, MP spent, battle kind, action id, formation bytes, and register E for D9. It compares the damage word, both random states, wBattleArg2 where a skill roll sets it, Kamikaze's carry, and that the ATK and DEF words and wBattleActor are put back.
- **Result.** 3,000 of 3,000 agree (about 107 per routine). Kamikaze's three outcomes occur: failure 47, success with damage 1 59, other damage 14.
- **Findings** (properties of the code, C2 on the emulator):
  - ActionEffect_Vacuum_Damage tests wLinkMode where the others test the actor's side, so foes get the player formula.
  - ActionEffect_ActionD9_Damage takes a level from register E, which it never loads.
  - Kamikaze reads the word at the address its actor's HP value names.
  - BiAttack's 30 x ATK and 30 x DEF products keep 16 bits.
- **Negative checks** (tests/test_mechanics.py). A model that halves DEF against every family, and one without Kamikaze's word read, are each caught.
- **Limits.** Routines are checked alone from generated states; which skill uses which routine, and the effect of the status bits in play, stay as their notes give them (C1).
- **Checks.** tools/mechanics.py effects --n 3000: all agree; build/run702 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite702.log OK (473 tests, 3 skipped).

### E-0403 — H1b, first file: tests/test_generated_source.py split into source audits and generator checks

- Date: 2026-10-17. Kind: TOOL and TEST (no source byte changed). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 6a7f1a2. Plan: [graduation](GRADUATION.md), H1b.
- **tools/source_tree.py.** Bank files; each global label's bank from its SECTION and src/layout.link (33,096 labels, all equal to the bank in build/run6's .sym); a digest of every src/ file, path and bytes, which tools/build.py now records as `source_digest` (the older `source_tree_sha256` left out the .inc files and is kept as it was); fresh_build and fresh_sym, which use only a passing build whose digest is the current tree's.
- **tests/test_source_audits.py (31 tests, src/).** Ported from the listing to src/'s spelling (lower-case hex, the `lb` macro read as the `ld` it assembles to, ASSERT lines skipped):
  - the raw-address audit;
  - the helper-call bank audit (label banks from source_tree);
  - the spot checks of E-0123 to E-0364;
  - the main.asm includes;
  - the field-message helpers.
  - Changed where src/ differs. Banked calls: every literal setup is now a farcall (3,843), so the check is that no bare `rst $10` with a literal label and bank is left; three computed ones remain (banks $30, $E0, $10), which no macro spells. Decompress arguments: the 126 `ld de, X` before DecompressTo name a stream in the ROM built from src/, decoding to at most 4,096 bytes with no unwritten read and ending at or before the next label; 17 of them are db bytes, not asset files, so a file test could not cover them. On 2026-10-17, 6 of 400 code labels in banks $0A, $10, $12 and $36 would also pass that rule; the label of DecompressTo itself is a negative case. 12:$55F8 is found through the fresh .sym (StartReturnWarpByFlag25).
- **tests/test_generator_listing.py (7 tests, build/listing/).** These check the generator, which stays as a re-analysis tool, and skip without the listing: notes above labels, configured names with address aliases, call-count headers, RAM lists, stream notes against a fresh decompression, data regions, and its banked-call labels.
- **Hand-edit experiment.** A comment line added above ComputeAttackDamage in src/: tools/src_drift.py reports 1 line of drift; tests/test_source_audits.py passes, with its two build-dependent tests skipped because no build matches the edited tree. Then `ld a, [$c0a0]` added there: the raw-address audit fails with `bank36_battle_effects.asm:2767 ld a, [$C0A0]`. The file was restored (git status clean).
- **Limits.** The stream rule is a plausibility check (above). The .sym-dependent checks skip until the tree is built.
- **Checks run.** build/run7 PASS (approved size and SHA-256, zero differing bytes; its report's source_digest is the tree's, so it is the fresh build); serial full suite build/logs/suite_e0403.log OK (479 tests, 3 skipped: the 33 tests of the old file became 31 + 7).

### E-0402 — H1a: the generator no longer writes src/ (D-015)

- Date: 2026-10-17. Kind: DECISION (D-015, user-approved: the user asked for the recommended path, whose first step is making src/ the hand-edited source) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit f276d52, merged with master e0bc01b (E-0398 to E-0401) before acceptance. Plan: [graduation](GRADUATION.md), stage H1 of the [roadmap](ROADMAP.md).
- **Change.** tools/disasm_all.py and tools/present.py write the presented tree (bank files, main.asm, layout.link, assets.txt and the six .inc and ram.asm files) to build/regen/src/ unless `--write-src` is given. present.Names reads ram.asm from the tree being written. build/listing/ is written as before.
- **Drift tool.** tools/src_drift.py lists files that differ (with changed lines), are only in the regenerated tree, or are only in src/; exit 0, 1 or 2 (no regenerated tree). tests/test_src_drift.py checks identical trees, a hand edit, a one-byte change, a line-ending change, missing and extra files, the missing tree and `--diff`, and that present.main into a scratch folder leaves src/ unchanged.
- **Result.** `python -I tools/disasm_all.py` (181.7 s) wrote build/regen/src/ and left src/ unchanged (git status clean); tools/src_drift.py: no drift, 265 files identical. So the switch changes no source byte.
- **Tests retargeted.** tests/test_present.py's test_regen_is_the_presented_listing (was test_src_is_the_presented_listing) and test_no_code_or_data_line_is_lost compare the listing with build/regen/src/, so a hand edit to src/ does not fail them. Other tests that read build/listing/ test the generator's own output and are moved to src/ in H1b.
- **Limits.** Until H1b-H1d, config/names.json and config/annotations.json still feed the regenerated tree and some tests. A hand edit to src/ shows as drift; it is not yet checked by those tests.
- **Checks run.** Before the merge: build/run4 PASS (approved size and SHA-256, zero differing bytes); serial full suite OK (466 tests, 3 skipped). On the merged tree (b77d2b0, with E-0398 to E-0401): regeneration left src/ unchanged and tools/src_drift.py reported no drift (265 files); build/run5 PASS; serial full suite build/logs/suite_e0402.log OK (474 tests, 3 skipped).

### E-0401 — Shiftability after M2: recipe runs, fixed references found by them, and asserted fixed-bank pointers

- Date: 2026-10-17. Kind: OBSERVATION and DECISION (generator, config and tool changes; bytes unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 142e245 (E-0399). Details: [shiftability](SHIFTABILITY.md), "After M2".
- **Recipe gate.** tools/shift_test.py `--recipe FILE` replays a tools/play.py recipe chain on the base and the padded ROM (script-pointer pokes moved with the padding, `call:` labels from each ROM's symbols) and compares, per reading instruction (its address mapped through the padding, and the interrupt it runs in), the stream of ROM data reads; bank-number bytes ($4000) are left out. Why per instruction: with a 16-byte pad an interrupt arrived a few cycles apart (a carry), FillTilesFromRequest copied more or fewer bytes in one VBlank, and the VBlank handler found another bank mapped; a global read order called these differences although every address read was right.
- **Fixed references found by it** (each run that failed, then fixed, then passed):
  - ObjSelector_Map1C_1 (69:$76F8): a selector inside MapObjects_Map1C_0_0, whose count of 2 reaches over the selector and the list at $76FC it points to; the generator now prints a selector inside a list as macros (`objsel_list MapObjects_Map1C_1_0`). Whether the game ever shows that second "object" is not known (C1).
  - `ld de, $20e9` in LoadMonsterPictureAttributes and LoadMonsterPictureAttributeBlock: ZeroPictureAttributes.
  - `ld hl, $2a66` in TextCmd_Pause: TextPauseFrames.
  - FlagBitHandlerTable (30:$4F66): 16 code addresses as `db`, now `dw`; its stub at $4FC6 is the new routine FlagBitHandlerNone (xor a / ret), probed (config/probes/E-0401.json).
  - StartMessageForGroup_Data (10:$4AFF): 11 far pointers as `db`, now `dfar`; with the pad the Egg Evaluator called the old address (found by stepping both ROMs in lockstep: the base reached BeginStringDisplay_BankF2, the padded ROM GameMode8_Update_SetUpScene + $88).
- **Found by static passes** (no run reaches them, or not yet):
  - SoundNextEvent's `ld hl, $38a0`, now `SoundNextEvent.next5 + 4`;
  - StartSoundAfterBankTable's `ld hl, $3e24`, now `SoundBankTable + $11`;
  - far pointers as `db`, now `dfar` tables: NpcBreedMenu_RedrawListScreen_LoadTiles_Data1/_Data2, DrawSpriteSlots_Data, Map06ScreensExtra, Map06AttrsExtra, Map1BScreensUnlisted, Map1BAttrsUnlisted;
  - after these, a scan of every `db` run finds no run of four or more same-bank code-label words, or three or more far pointers to labels, outside sound data.
- **Split sums.** 60:$4BF4 is KeyWorldSizeByStrength (config/tables.json; 100 bytes, $44 for 0-9, $88 after), and 0F:$4000 x2 is MSG_KEEP_OPEN added to a message word (config/operands.json `splits`). tools/hardcoded_refs.py `code_split`: 60 to 57, none an address.
- **Fixed-bank pointers.** tools/present.py adds `ASSERT BANK(Label) == $BB` after each of the 512 pointer loads into another switchable bank with no bank named beside it (tools/bank_check.py: 0 warnings, 512 asserted). Moving the section Bank 10 Script_HehSoTheseAre to bank $F8 (tools/move_section.py) fails the link with 424 such assertion errors.
- **Result.** All 147 runs of the recipe chain (tools/recipes/e0335_swap.txt and its includes), 2,299 routines executed, 4,741,338 ROM data reads: PASS with 152 banks padded by 16 and with 107 banks padded by 256. The base and the 256-padded ROM keep equal cycle counts at the end of every run.
- **Checks.** tools/shift_test.py --recipe, as above; on master with E-0400 merged: build/run697 PASS and serial suite build/logs/suite697.log OK (465 tests, 3 skipped); before the merge: build/run696 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite696.log OK (451 tests, 3 skipped); the explore read gate (10,000 frames, 152 banks padded by 16) still PASS.

### E-0400 — Breeding paths: the wild monsters of each story map and the fewest breedings to a species

- Date: 2026-10-17. Kind: OBSERVATION (C2 on tools/sm83.py for what the checks compare; not hardware) and TOOL. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 2c912f8. E-0398 and E-0399 are used on the unmerged branch claude/skill-learning, so this entry skips them. Description: [breeding paths](BREEDING_PATHS.md).
- **Wild species.** tools/breed_path.py decodes RunBattleIntroKindCase_RandomEncounter (0A:$49B4, file offset 0x289B4) from its bytes: 56 maps, each a grid table read by screen (A per row) or one entry, four of them ($2B, $30, $48, $B8) by hPlayerStateFlags bit 3. Screens are limited to the MapTable record's width and height (+6, +7; E-0142); none of the 56 maps has encounter rate 0. Entries are read as FillEncounterFromEntry uses them (cap, five thresholds, monster words); a monster word's species is its MonsterTable record's first word (E-0263).
- **RandomByteTable (00:$0973, file [0x973, 0x9F3)).** Its 128 bytes give wRandomLo & $7F only 94 values; 34 never occur (19 among them). So the last slot of two Float ($70) entries, 0A:$5F83 (Metaly) and 0A:$5FB0 (Phoenix), thresholds 18 then 19, is never drawn. Every FillEncounterFromEntry draw goes through NextTableByte, whose state is wRandomHi (0-127) alone, so running the routine from all 128 states is exhaustive.
- **Checks** (`python -I tools/breed_path.py check`, all on tools/sm83.py):
  - lists: CollectUniqueEncounterIdsToWorkBuf2_FindTable (0A:$4D5E) gives the species the tool reads, for every in-bounds screen of the 56 maps and both values of bit 3 (map $B8's listing ignores bit 3; only clear there): all agree;
  - draws: FillEncounterFromEntry (0A:$4CD4) from all 128 random states draws exactly the slots counted as reachable, for all 109 distinct entries;
  - the two dispatches (battle and listing) pick the same tables for every map.
- **Route.** Fewest breedings by repeated pairing with tools/mechanics.breed_species (E-0396; farm breeding, plus 0). From the maps $30-$45 (37 species), Darkdrium takes 132 breedings from 133 wild monsters, ending Deathmore (third form) × GranSlime; ComputeBreedingChild (0E:$5688) gives the child of all 40 distinct breedings of the route. Adding $20-$2F (46 species) gives the same count.
- **World grouping (C1).** $30-$45 as the Pirate world, the second key: the key names in bank $09 (GreatLog, Oasis, Pirate, Ice, …) and the map names (Desert to Mirage Lake at $20-$2F, Water to the Magic Door at $45) agree in order, but no routine linking keys to map ranges was read.
- **Negative checks** (tests/test_breed_path.py): a slot model letting every r in 0-127 occur claims Metaly and Phoenix in the two Float entries, and the game never draws them; a model with the parents swapped disagrees with ComputeBreedingChild on some breedings of the route; the dispatch decoder rejects an unexpected opcode and a routine that does not start with `ldh a, [hMapId]`.
- **Limits.** Sex, level, plus-gated recipes, recruiting odds and whether a screen can be reached in play are not modelled. Scripted battles, the arena and key worlds are not wild sources here.
- **Checks run.** tests/test_breed_path.py OK (14 tests); build/run3 PASS on the final tree (approved size and SHA-256, zero differing bytes; src/ regenerated unchanged); serial full suite build/logs/suite_e0400b.log OK (457 tests, 3 skipped). A first serial run (suite_e0400.log) had 27 failures, all from build/listing missing in a fresh worktree; they pass once tools/disasm_all.py has run.

### E-0399 — Applying the damage: ResolveStepApplyDamage and ApplyDamageModifiers

- Date: 2026-10-17. Kind: OBSERVATION (C2 on tools/sm83.py for what the checks compare; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 7ae74c2 (E-0398). Specification: the Damage section of [mechanics](MECHANICS.md).
- **Applying** (`apply`, ResolveStepApplyDamage through its far call to ApplyDamageToTarget, bank $32). 3,000 of 3,000 generated states agree on all eight wBattleHP words, all eight wLevelUpGains bytes, wBattleResolveStep, wBattleSubStep and wBattleSubStep2:
  - the step +2;
  - the top two bits of wResolveMsgArg: 00 nothing, 01 only the flag bits, 10 or 11 the HP subtraction;
  - an HP result of 0 or below clamps to 0, steps back to the defeat step 13 and clears wBattleSubStep2.
  - Damage equal to the HP, one above and one below are generated on purpose.
- **Multipliers** (`modifiers`, ApplyDamageModifiers, called by the damage message step for ACTION_D7). 3,000 of 3,000 agree on the damage word and the target's wBattleStatus7: bits 0-3 cleared, then x2 for bit 0, else x10 for bit 1, else x2 for bit 2, 16-bit.
- **Negative checks** (tests/test_mechanics.py). A model that does not count exactly 0 HP as a defeat, and one that tries bit 2 before bit 1, are each caught.
- **Limits.** The display of the damage message, the defeat sequence (RunDefeatSequence) and the aftermath (ResolveStep0EEffect) are not checked; what wLevelUpGains bits 0-2 mean for a battle slot is as their notes give it (C1).
- **Checks.** tools/mechanics.py apply and modifiers --n 3000: all agree; build/run696 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite696.log OK (451 tests, 3 skipped); the explore read gate (10,000 frames, 152 banks padded by 16) still PASS.

### E-0398 — Skill learning: FindNewlyLearnableSkills as a checked specification

- Date: 2026-10-17. Kind: OBSERVATION (C2 on tools/sm83.py for what the check compares; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 2c912f8 (E-0397). Specification: the Skill learning section of [mechanics](MECHANICS.md).
- **Method.** As E-0396. tools/mechanics.py `learn` sets up an SRAM record (through wPartyList, or the slot itself in a link battle in game mode 4), wWorkBuf and hTemp5/6, runs FindNewlyLearnableSkills, and compares hTemp3-6 and the record's 25-byte MON_SKILL_LIST.
- **Result.** 3,000 of 3,000 generated states agree. In one run: 1,353 results from the skill list, 194 upgrades, 176 devised (38 of them skill $3D) and 1,277 with no result. The rules:
  - rows in skill order, skipping skills already in wWorkBuf;
  - (MON_LEVEL + 1) & $FF against the row's level, six unsigned 16-bit stat words against the required words;
  - the 25-byte skill list first (its entry cleared to $FF);
  - then an upgrade from a known first prerequisite (hTemp5 = it), except for skill $3D (SKILL_MEGAMAGIC), which needs it and is devised;
  - then devised when every further prerequisite (at least one) is known;
  - hTemp6 = the first prerequisite of the last row that reached that test.
- **Generation.** A quarter of the states are built around a row that can be devised, with the earlier rows the record meets put in wWorkBuf, so that the devised result occurs; one in five of those is skill $3D.
- **Negative checks** (tests/test_mechanics.py). A model that compares MON_LEVEL without the + 1, and one that reports skill $3D as an upgrade, are each caught.
- **Limits.** The caller's display, wWorkBuf and MON_SKILLS updates, and CheckSkillsLearnableAtLevel (foe battle records) are not checked. Skill $3D is SKILL_MEGAMAGIC in src/constants.inc, named from the ROM's skill-name table (D-007).
- **Checks.** tools/mechanics.py learn --n 3000: all agree; build/run696 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite696.log OK (451 tests, 3 skipped); the explore read gate (10,000 frames, 152 banks padded by 16) still PASS.

### E-0397 — Damage: the plain attack, resistance scaling and resolve step 7 as checked specifications

- Date: 2026-10-17. Kind: OBSERVATION (C2 on tools/sm83.py for what the checks compare; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 202a594. Specification: the Damage section of [mechanics](MECHANICS.md).
- **Method.** As E-0396: tools/mechanics.py models written from the routines' code, run against the routines on tools/sm83.py from generated battle states (actor and target slots, ATK and DEF words, status bytes, resistance records, personality bytes, the skill record, the random state, wLinkMode 0, 1 or 2). The checks compare the damage word, both random states (wRandomHi/Lo and wRandomSeed2Hi/Lo, since AdvanceRandom uses the second in link play) and the routine's other outputs.
- **Plain attack** (`attack`, ComputeAttackDamage and ComputeBasicDamage). 3,000 of 3,000 agree: one discarded random step; d = DEF / 2; RandomInRange(0, 1) when ATK <= d; RandomInRange(0, ATK / 16) when ATK / 16 >= (ATK - d) / 2; otherwise half + RandomInRange(-half/16, half/16) + RandomInRange(-1, 1). A zero-width RandomInRange takes no step.
- **Resistance scaling** (`resistance`). tools/mechanics.py reads from src/engine/bank36_battle_effects.asm the 16 routines that are a roll (RollSkillDamageFromRecord, or ComputeAttackDamage) followed by a 2-bit field of the target's wSlotResistances record and a ScaleDamageByFlagsAtHL picker (following fall-through into the next label). 3,000 of 3,000 states, the routines in turn, agree on the damage, wBattleArg2 (the spread) and both random states. All 16 combinations of the four level tables and four levels occur (at least 16 times each). The skill roll reads base and spread at +$D-$F for slots 4-7 unless wLinkMode is 1, else +$9-$B. The status8 bits pick the table, bit 6 before bit 7. The attack-based routines' picker (ScaleDamageByFlagsAtHLBit6) uses the 21/16 table when bit 6 is clear.
- **Resolve step 7** (`step7`, ResolveStepComputeDamage). 3,000 of 3,000 agree on the step counter, damage, the actor's wBattleStatus2, the four resolve-message bytes and both random states:
  - the wait for the critical-hit sound;
  - the first of four modifiers (ATK doubled, the critical hit as ATK within 5 percent with the hit message and no personality bonus, ChargeUp, SuckAir 2 to 2.5 times);
  - the actor's personality bit 6 (x 1.5);
  - the target's wBattleStatus7 bits 0-2 (/2 or /10, then /2 again for its personality bit 1);
  - the target's Berserk doubling except for Ramming and Kamikaze.
  - A line-coverage trace of the three models over the 9,000 states executed every line except an unreachable division-by-zero guard.
- **Negative checks** (tests/test_mechanics.py). Each of these wrong models is caught: an attack that does not halve DEF, an 85 percent level 1 replaced by 75 percent, a step 7 that forgets Berserk.
- **Limits.** The effect routines that do more than roll and scale (Watershot, MegaMagic, MultiCut, CallHelp and others), ResolveStepApplyDamage and the damage message step's multipliers are not checked. What the status bits mean in play (Magic Wall, Eerie Lite, Berserk) stays as their notes give it (C1).
- **Checks.** tools/mechanics.py all --n 3000: all six checks agree; build/run684 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite684.log OK (443 tests, 3 skipped).

### E-0396 — M5: three mechanics as checked specifications; the species, skill and item tables

- Date: 2026-10-16. Kind: OBSERVATION (C2 on tools/sm83.py for what the checks compare; not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 7edc4f4 (E-0395). Specifications: [mechanics](MECHANICS.md); tables: [data tables](DATA_TABLES.md).
- **Method.** tools/mechanics.py holds a Python model of each mechanic, written from the routine's code. It runs the routine on tools/sm83.py from generated states (memory and SRAM set up, the routine called, its outputs read) and compares every output the model predicts. The models read the game's tables from the reference ROM and reproduce NextTableByte's random sequence, so the number of random rolls is compared too.
- **Join offer** (BattleEnd_OfferJoin_DecideJoinOffer). 3,000 of 3,000 states agree: the eligibility tests, the first-sighting roll against JoinChanceByClass, the battle-meter scaling by the two class tables, and the two final rolls; the states reach 0 to 3 rolls, with and without an offer. A meter that scales to $8000 or more counts as negative (no offer).
- **Level-up gains** (ComputeLevelUpStatGainsForBattleArg1). 3,000 of 3,000 records agree on all 8 bytes of wLevelUpGains:
  - StatGrowthTable[row][level] for the six growth rows;
  - the growth-item bonus: half the count of eight record values and the name length whose bit 0 matches the plus;
  - ClampDeltaTo999, including its meaningless result for a stat above 999;
  - no gain at the level cap.
- **Breeding child** (ComputeBreedingChild). 3,000 of 3,000 parent pairs agree on the child species, plus, level cap, personality, level, egg and state:
  - the four rule tables in order, with the $FD/$FB/$FE/$FC rules of the species list and the family rules;
  - plus = base + 1 to 5 by the 8-bit level sum, at most 99;
  - level cap = species cap + 3 x plus, at most 99;
  - personality = the 8-bit sum halved.
  - No pair of the 11 real families reaches "no child". Parents whose species record gives family 15 read past the tables and were not generated.
  - Sex, resistances, skills and stats come from later random routines and are not compared.
- **Negative checks.** A model that never offers, one with no growth and one with a wrong wArg5 are each caught (tests/test_mechanics.py). In exploration, models with one condition flipped disagreed on exactly the states that condition decides: 78, 300 and 469.
- **Tables** (tools/tables_export.py):
  - SpeciesRecordPointers: 384 monster ids point at the 324 records of SpeciesRecords, all on record boundaries and all used.
  - SpeciesRecords (324 x 47 bytes, fields from src/records.inc), SkillTable (228 x 17) and ItemTable (99 x 13) export to JSON and pack back to the ROM's bytes.
  - LoadSpeciesRecord, LoadSkillRecord and LoadItemRecord, run for every id, copy exactly the exported record.
  - A changed export no longer packs to the ROM (negative test).
  - Field meanings and their confidence are those of src/records.inc and config/tables.json (most C1), listed in docs/DATA_TABLES.md.
- **Checks.** tools/mechanics.py all --n 3000: all agree; tools/tables_export.py check: ok; build/run682 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite682.log OK (439 tests, 3 skipped).

### E-0395 — M4: leftover code bytes decoded or listed

- Date: 2026-10-16. Kind: OBSERVATION and DECISION (static decoding C1; 115 probes on tools/sm83.py, C2 for what they check). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit fb47357 (E-0394). List: [leftover code bytes](LEFTOVER_CODE.md).
- **Method.**
  - `tools/disasm_all.py --leftover PATH` records every byte range the generator writes as plain `db` (6,207), with the instruction that ends where each begins.
  - tools/leftover_code.py trial-decodes those that start right after an unconditional ret, reti, jp or jr in a bank with code. Verdicts: code, code?, open, not code, fill.
  - A gap that decodes to an end and calls a label start, or jumps to a known instruction outside itself, became a config/code_entries.json entry. Repeated until none was left: 80 entries in four rounds.
- **What they are.** Tracing the 80 found 22 more routines after them (102 new code labels), all unreached in the static listing:
  - 51 string stubs left in the string banks beside each bank's BeginStringDisplay: CopyStringToBuffer_* (`ld de, table; call CopyStringToBuffer; ret`) and ShowStringAtOnce_* (begin, then RunStringDisplayToEnd);
  - 28 battle helpers that are the same shape as their neighbours: GetBattle* stat getters, ReadSlotAIModeIndexed_* and two resistance-byte getters;
  - seven Warubou talk handlers in bank $13 with their own flags, messages and scripts;
  - nine link-session starters in bank $1B (wGameMode 5, wLinkSession 2-8);
  - SubtractBCFromWordAtHLMin0 (beside AddBCToWordAtHL), ListCellSRAMRecordAddress, DrawSelectedMemberCursor_BankF1, ReorderAndStoreKeyList, Talk_CheckedThePeculiarDoor, and two one-call wrappers in bank $00.
  - Names and notes (C1) are in config/names.json and config/annotations.json; 65 names were chosen from the code, the others came from name families.
- **Discovery order.** The generator's fall-through guess accepts a routine only when its speculative trace has 4 or more new instructions, and a trace stops at code already traced. A 5-byte getter (`ld hl, wBattleX; jr shared tail`) was accepted only while its tail was untraced. New entries traced the tails first, and 16 such routines were dropped (A1:$4010 and others), along with $4001 routines named in config/names.json.
  - `--reasons PATH` writes why each entry was traced. A run on the committed entries gave the 634 routines accepted by a guess alone, and all of them are now config/code_entries.json entries (674 with the $4001 ones), so new entries cannot drop them.
  - Eleven of them had taken their names from that guess; they keep those names in config/names.json. Four pairs of byte-identical copies numbered by discovery order (ReadSlotAIModeIndexed_Bank05 and _2, CopyBytesDEToHL_Bank24, BGTileUnderPointIsSpriteHideTile_Bank7F, CountTableBytesAtOrBelowA_BankA0) swapped their `_2`; the six notes that cite them were swapped to match, so each names the same address as before.
  - No annotated routine is lost: every address with a hand note is still a code label (build/lost.py check).
- **Probes.** config/probes/E-0395.json has 115 probes for 58 of the 60 new routines in probe scope, all passing (getters, AI mode reads, resistance bytes, string copies with the bytes read from the ROM, the talk handlers' script and message state, the subtraction). One note was wrong and is corrected: SubtractBCFromWordAtHLMin0 returns HL + 1, not HL. Two have a reason in config/probe_exclusions.json: CopyStringToBuffer_Bank8A (its strings are not $F0-ended within 255 bytes) and ReorderAndStoreKeyList (two probed calls).
- **Left as data** (docs/LEFTOVER_CODE.md, one row each), 384 gaps after a routine's end:
  - fill 51 (padding);
  - not code 81 (invalid opcode or an instruction past the gap);
  - open 204 (no end);
  - code? 34 (a jump or call to no known instruction);
  - code 14 (decodes to an end with no call or jump into known code, too short to tell: `xor a; ret`, `scf; ccf; ret`, word lists such as `xor a, c; nop; jp hl`).
- **Checks.** build/run681 PASS (approved size and SHA-256, zero differing bytes); every readability queue at 0; 33,087 labels; parallel full suite build/logs/par681.log OK (432 tests, 3 skipped; the serial run build/logs/suite680.log found two problems, now fixed: two note phrases read as names, and probed notes still tagged C1).

### E-0394 — M3: a byte-identical LZSS encoder; assets built from decoded, editable data

- Date: 2026-10-16. Kind: OBSERVATION and DECISION. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit a68afb6 (E-0393). Guide: [editable assets](ASSETS.md).
- **What the streams show** (all 3,546 of src/assets.txt, decoded with tools/lzss_gfx.py):
  - the marker is always the lowest byte value absent from the data;
  - the parse is greedy (no literal stands where a match of 4 or more existed);
  - no reference is longer than 96 bytes (967 are exactly 96, where longer matches existed);
  - no stream decodes to more than 4,096 bytes;
  - ties between equally long matches follow no simple first or last rule, which points to a tree search.
- **Encoder.** tools/lzss_encode.py is Okumura's LZSS.C (public-domain 1989 reference code) with N = 4096, F = 96, THRESHOLD = 3 and the game's token format.
  - The ring starts at 0, zero-filled, with r = 0 and s = r + F.
  - The 96 positions 4000-4095 are inserted first, with the ring's mirror holding the start of the data, so the strings there run on into it: the first reference of many streams reads leading zeros from 4095.
  - All 3,546 streams re-encode byte for byte (`tools/lzss_encode.py --check`; tests/test_lzss_encode.py). Two first attempts failed: an unfilled mirror (6 of 3,546 matched) and s = 0 (9).
- **Build.** tools/build.py writes every asset file by decoding the reference's stream and encoding it again (tools/assets.py); it stops if a stream differs. Raw bytes are kept for three slices with bytes after their stream (8, 161 and 3 bytes) and four streams ending inside the next slice.
- **Editing.** `tools/assets.py export` writes `.bin` for every asset and PNG (rgbgfx) for 1,020 tile assets. `build.py --mod DIR` takes edited files from DIR in a scratch copy of src/, where each bank's trailing fill absorbs the edited assets' change in size, and reports a MODDED BUILD.
  - A full export built with --mod gives the reference byte for byte (0 differing bytes; every PNG converts back exactly).
  - The Slime picture with inverted colours grows by 1 byte, and bank $74's fill goes from 74 to 73 bytes. MonsterPic_Slime decodes to the edited data; the 51 other pictures of the bank decode as before, 42 of them moved; the ROM runs 3,000 frames (tools/sm83.py).
- **Checks.** build/run672 PASS (approved size and SHA-256, zero differing bytes) with every asset encoded from decoded data; serial full suite build/logs/suite672.log OK (427 tests, 3 skipped).

### E-0393 — M2 batch 5: floating sections placed by src/layout.link; code moved between banks

- Date: 2026-10-16. Kind: DECISION and OBSERVATION (layout change; bytes unchanged; moves observed on tools/sm83.py, not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 22111cb (E-0392).
- **Layout.** tools/present.py now writes each bank file as floating sections (`SECTION "Bank NN Label", ROMX`, `ROM0` for bank $00).
  - A section starts at a top-level label whose code above ends in an unconditional ret, reti, jp or jr, so no code falls from one section into the next. Comments stay with their label; data after a routine stays in that routine's section. 9,071 sections in all.
  - src/layout.link lists every bank and its sections in ROM order, and tools/build.py links with `rgblink -l src/layout.link`. Sections follow one another with no gaps, and the trailing `ds` fills pad each bank.
  - The cartridge header section is pinned with `ORG $0104`, after the entry point at $0100, so anything growing into it fails the link. build/listing and the tests that read it keep one section per bank.
- **Bank check.** tools/bank_check.py reads a build's .sym and src/.
  - An error is a call, jp or jr from a switchable bank to a label in a different switchable bank.
  - A warning is an `ld hl/de/bc` of a label in another switchable bank with no BANK(), farcall or literal `ld b` within three lines.
  - On the matching layout: 0 errors, 511 warnings. These are pointers whose bank is fixed elsewhere, e.g. scripts in bank $10, which the script engine reads from bank $10. They are the dependencies to read before moving that data.
- **Moves.** tools/move_section.py `--list` finds sections with no unbanked reference to or from the rest of their bank or bank $00: 255 of 9,071 (a call, jp or jr is never banked). `--move NAME --to BB` moves one in a scratch copy (its layout line, plus BB's last `ds` shortened by its size), links, runs the bank check, and compares 3,000 frames with the unmoved copy (persist 8).
  - ScriptWaitFrames (32 bytes, bank $5F to $F4): bank check clean, all frames identical; it runs 240 times in those frames.
  - ScriptStepObject (132 bytes, $5F to $F5): clean, identical; it runs 176 times.
  - Negative case: FarClearRollCounterWhenGM2TimerMinutesIs59 ($02 to $F3), which five bank-$02 routines reach with a plain `call`. The bank check reports the five calls, and the frames differ from 803. Before the jump rule, `--list` had offered it because an unrelated `ld b` was within three lines.
- **Tests.** tests/test_sections.py (6):
  - split points: after unconditional ends only; comments stay with their label;
  - the header pin;
  - layout moves, with unknown names and banks refused;
  - the bank check's errors and warnings, and bank $00 skipped.
- **Checks.** build/run670 PASS from a full regeneration (approved size and SHA-256, zero differing bytes); parallel full suite build/logs/par670.log OK (418 tests, 3 skipped; the serial run build/logs/suite670.log had 2 failures in tests/test_present.py, which now applies split_sections and checks that src/layout.link places every section once); the read gate passes with all 152 paddable banks padded by 16 (sections in place).

### E-0392 — M2 batch 4: six of the nine unresolved split sums

- Date: 2026-10-16. Kind: OBSERVATION and DECISION (generator and config; bytes unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 9b6451f (E-0391).
- **Bank hints.** `name_split_addresses` looks twelve instructions ahead for the far-read bank, not eight, and also back up to twelve for an `ld a, $NN` / `ld [rROMB0], a` switch made just before the sum. New resolutions:
  - ReadBank6TableWord (bank $E2): `ld a, $06` / `ld [wDataBank], a` nine instructions later gives AIPersonalityWeightTable (06:$4001).
  - LoadSpecialMapScreen and a second bank-$00 routine (rROMB0 = $61 before the sum): SpecialMapTable.
  - DebugMapEditor_CheckPosition (rROMB0 = $11): MapTable.
- **By hand.** A2:$4056 is MonsterTableA2 - $1A. CopyMonsterTableBytes and LoadMonsterRecordTo_HighIds compute (monster id - $250) + 1, a 1-based index, times one $1A-byte record (config/operands.json `splits`, C1).
- **Left** (3 address-like sums):
  - 60:$4BF4 is $64 bytes below KeyWorldLayout_Start_Data; KeyWorldLayout_Start adds wPartyStrength - C plus a roll of 0-9 and reads a nibble. Its index range is not read, so the expression is not certain.
  - 0F:$4000 x2 is the start of the switchable window plus 256 x wMessageGroup, a base in whichever bank is mapped; no single label names it.
- **Counts.** 65 split pairs are label expressions; code_split 59 = 56 constants + the 3 above.
- **Checks.** build/run667 PASS (approved size and SHA-256, zero differing bytes); parallel full suite build/logs/par667.log OK (411 tests, 3 skipped); the read gate passes with all 152 paddable banks padded by 16 over 10,000 explore frames.

### E-0391 — M2 batch 3: literal bank numbers written BANK(label)

- Date: 2026-10-16. Kind: DECISION (generator change; bytes unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit df12480 (E-0390).
- **Rule.** `name_bank_literals` writes a bank number as BANK(Label) when it names the bank of a pointer loaded next to it:
  - `ld b, $NN` when an instruction within three of it loads a resolved pointer or split table address into bank $NN (B = bank for far calls and far copies);
  - `ld a, $NN` only when the next instruction is `ld b, a`, `ld [rROMB0], a` or `ld [wDataBank], a`.
  - Bank $00 and numbers that match no nearby pointer stay numbers.
- **Results.**
  - 4,222 setups qualify. compress_farcalls now also folds `ld hl, L` / `ld b, BANK(L)` / `rst $10`, so the 3,842 `farcall` lines are unchanged.
  - The visible change is 382 `ld b, BANK(...)` setups for copy and decompress helpers and 14 `ld a, BANK(...)` bank switches (`ld a, BANK(StringDatabase)` / `ld [wDataBank], a`).
  - tools/hardcoded_refs.py code_bank 468 to 96; the 96 are not banks: skill slot numbers and argument bytes that equal a nearby label's bank.
- **Tests.** test_generated_source's helper-call audit reads `ld b, BANK(L)` as L's bank and still compares it with the pointer labels of the setup.
- **Gate.** All 152 paddable banks padded by 16 still pass the read comparison over 10,000 explore frames. build/run665 PASS (approved size and SHA-256, zero differing bytes); parallel full suite build/logs/par665.log OK (411 tests, 3 skipped).

### E-0390 — M2 batch 2: split table addresses in other banks, inside tables and data blocks

- Date: 2026-10-16. Kind: OBSERVATION and DECISION (generator changes; bytes unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 785747f (E-0389). Details: [shiftability](SHIFTABILITY.md).
- **Rule.** `name_split_addresses` now resolves an `add $LO` / `adc $HI` sum first in the instruction's own bank. Failing that, it uses the bank named for a far read within the next eight instructions: `ld b, $NN`, or `ld a, $NN` then `ld b, a`, `ld [rROMB0], a` or `ld [wDataBank], a`. Bank-$00 code is included.
  - A sum is written when it is exactly a data label, lies inside a table (`Table + $offset`), or lies within $100 bytes after a data label with no code between (`Data + $10`).
  - A count in B after the sum (`ld b, $11` before a copy loop) would be taken for a bank, so the own bank wins when it matches.
- **Results.** 59 pairs written (35 in batch 1), among them:
  - SharedOBJPalettes from bank $12 (`ld b, $7e`); MonsterSpritePalettes from banks $00, $01, $04, $1D (`ld b, $27`); KeyWorldRoomPointers from banks $61, $84 (`ld b, $72`).
  - StringTable_ItemNames and StringTable_SkillNames from bank $00 (rROMB0 = $08); AutomapBlocks (`ld b, $5e`); ItemTable + $1 (`ld b, $16`); KeyWorldScreenSpotRecords + $1.
  - RollKeyWorldObjectKind_Data + $10 and FieldState_MapTransition_RollTriggerContents_Data + $10 (their notes say the first 16 bytes are never read).
- **By hand** (config/operands.json `splits`): 17:$446C as SGBPaletteSets + $200 (LoadSGBObjectPalettesFromPointers_CopyPaletteEntry copies 8 bytes from $446C + 8 * index, after the 64 system-palette sets); 03:$6851 labelled SkillTargetBoxRectIndex (one byte per skill; note in config/names.json, C1).
- **Left as numbers** (65 sums):
  - 56 are not addresses: the screen-buffer offset $0E68 (with WRAM bank 2), the text-cursor step $01C1, VRAM row steps ($0160-$0240), the checksum seeds $1234 and $4321, $0400, $0180 and $0195, and $2998 added to a pointer read just before.
  - Nine look like addresses but have no label or bank yet: 60:$4BF4 (index base below KeyWorldLayout_Start_Data, index range not read), E2:$4001 (ReadBank6TableWord, bank 6 by wDataBank, no label there), A2:$4056 x2, 00:$60D8 x2, 00:$44B8, 0F:$4000 x2 (a message bank base per wMessageGroup).
- **Gate.** All 152 paddable banks padded by 16: all 1,202,485 ROM data reads of 10,000 frames with --explore match. Build/run663 PASS (approved size and SHA-256, zero differing bytes); parallel full suite build/logs/par663.log OK (411 tests, 3 skipped).

### E-0389 — M2 batch 1: the located hard-coded references written as labels

- Date: 2026-10-16. Kind: OBSERVATION and DECISION (generator changes; bytes unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit e9e76a0 (E-0388). Details: [shiftability](SHIFTABILITY.md).
- **References.**
  - config/operands.json labels the bank-$00 targets read through numbers: SolidColor1Tile ($2940; FillTilesBxC, FillTilesFromRequest), MapMarkerRecords ($1AB4; LoadMapScreen_DrawMarker) and Tiles_00_1D07 (PatchTilesOnMap1Or2).
  - New rule: a `ld hl/de/bc` of exactly a hand-confirmed bank-$00 address is that pointer (17 more, LibraryMenu_LeaveReloadNames and kin, which copy SolidColor1Tile with CopyTileBytesToVRAM_Bank0C).
  - `name_split_addresses` writes 35 `add $LO` / `adc $HI` pairs as LOW/HIGH(Label) when the sum is exactly a data label of the instruction's bank (MapObjectTable, MapStepTriggerTable, SkillTable, ExpTable, ...).
  - The bank-$1F source lists (generated `TileCopySrcList` tables and the eight declared ones, `rom_bank`) print each word as the table holding it plus an offset (`GlyphFont + $a0`; 532 words).
  - GlyphFont carries `ASSERT (GlyphFont & 1) == 0`, the requirement of DrawTextGlyph's `inc e`. Padding bank $1F by 1 now fails the link with that message.
  - Notes: SolidColor1Tile and MapMarkerRecords in config/names.json (C1). tools/present.py, tools/doc_coverage.py and tools/probe_scope.py skip `ASSERT` lines when they decide code or data.
- **Timing.** A 16-byte shift of bank $00 changes RandomByteTable's low byte, so `add_a_to_hl` carries where it did not. With bank $00 padded, the random calls and values were the same, but one call fell after the frame-1369 boundary; later random effects (OBJ palettes 6-7) differed, and a frame was dropped at 1418. VRAM and OAM were identical. tools/shift_test.py therefore gained `--persist N` (a frame difference counts when it lasts N frames) and `--reads BB|all`, which compares the order of ROM data reads mapped through the padding. Read order does not depend on timing. It found MapMarkerRecords, and the reader handles MBC5 bank 0 selected at $4000 (SoundTick).
- **Gate.** With all 152 paddable banks padded by 16, ROM data reads over 10,000 frames with --explore: PASS, all 1,202,485 reads match (build/m2_readsall). With every bank except $00 padded by 16, the 10,000 frames match exactly (0 differing frames).
- **Static counts** (build/run659): code_split 124 to 89; data_tiles 592 to 60 (all remaining are palette colours); code_address 86 to 84 (none real: message ids, flag ids, step values, a byte count); code_bank 468 (unchanged).
- Binary verification: build/run659 PASS (approved size and SHA-256, zero differing bytes); parallel full suite build/logs/par659.log OK (411 tests, 3 skipped).

### E-0388 — Shiftability audit (M1): what breaks when code and data move

- Date: 2026-10-16. Kind: OBSERVATION (project emulator tools/sm83.py, not hardware; C2 for the routines named below, C1 for the static counts). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit d4f8d17 (source as eb9066a). Details and the M2 plan: [shiftability](SHIFTABILITY.md).
- **Method.** tools/shift_test.py assembles a copy of src/ unchanged and with `ds N, $00` inserted before the first label of each bank past its fixed start, shrinking the bank's last `ds` by N. The unchanged copy must equal the reference. It then compares the video state of both ROMs (VRAM, OAM, palette RAM, LCD registers) frame by frame under the same scripted buttons. A crash counts as a difference. `--bisect` isolates banks; `--locate` reports the first instruction whose PC or ROM reads do not follow the padding. tools/hardcoded_refs.py counts numbers that stand for labels, by kind and bank.
- **Dynamic results.** Pad 1 and pad 16 (152 banks padded, 31,982 labels moved): the screens differ from frame 818, caused by banks $00, $1F, $69 and $87. Pad $100 (107 banks; 50 lack the room): banks $1F and $87. Without those four, 148 banks padded by 16 run 10,000 frames with --explore (30,255 labels moved) with no difference. Located causes:
  - FillTilesFromRequest reads `ld de, $2940`, unlabelled bytes after its `ret`.
  - DrawTextGlyph steps 2-byte glyph rows with `inc e`, so GlyphFont rows must not cross a page (pad 1 breaks it, pad 16 does not).
  - CopyFromBankWaitVRAM copies from 1F:$40B0 = GlyphFont + $A0, an address from a glyph source list written as `dw $40b0, ...`.
  - LoadMapObjectsForScreen builds MapObjectTable's address as `add $74` / `adc $41`.
  - FieldState_WalkATalks_RunStepTriggers builds MapStepTriggerTable's as `add $a0` / `adc $40`.
- **Static counts** (src/ at eb9066a, build/run651/dwm2.sym):
  - code_split 124 in 39 banks; data_tiles 592 addresses in 9 banks; code_bank 468 in 38 banks.
  - code_address 86, mostly message ids: `ld de, $1d07` for Tiles_00_1D07 is real.
  - code_number 0; data_word 149 (many palette colours); data_bank 8 (all coincidences); data_pair 5,107 (mostly coincidences).
  - incbin_raw 0: all 3,546 asset slices are LZSS streams.
- **Limits.** The scripted runs reach 404 (3,000 frames) and 461 (10,000 frames with --explore) labelled routines, under 5% of 9,820 code labels. Other code is covered only by the static counts, which are candidates, not proofs. Banks are one fixed section each, so nothing can yet move between banks. RAM layout is not tested.
- **Tests.** tests/test_shift_test.py (10): padding placement and `ds` shrinking; refusal with no room or no label; bank $00 below $0150 untouched; first-difference and crash handling; bad arguments; each inventory kind with negatives.
- Binary verification of the matching target: build/run652 PASS (approved size and SHA-256, zero differing bytes); serial full suite build/logs/suite652.log OK (408 tests, 3 skipped). The padded builds are not identity checks.

### E-0387 — Generator follow-ups: whole compressed streams, code at bank $32 $4F00, one name per table

- Date: 2026-10-16. Kind: OBSERVATION and DECISION (generator changes; byte layout unchanged). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 947c078.
- **Split streams.** `find_compressed_assets` registers a stream from config/stream_chains.json (a run of back-to-back LZSS streams) where the previous stream ends. When that stream really ends a few bytes later, the next "chain" stream starts inside it and splits it in two slices. A chain-only stream is now dropped, with the address label it alone created, when it starts inside the bytes of a stream from another source, or its bytes run over the start of one; among chain streams an earlier one keeps its bytes. 28 dropped: 46:$518D, 4B:$5E5D, 4C:$4E1D/$5275/$5689/$5C00/$725A, 54:$4078, 55:$4A4D, 65:$5F7A/$615F/$6644/$6844/$6A41/$6C46, 66:$4F5A/$518A/$53BA/$55AF/$57B9/$59C0, 6D:$6D4C, 6E:$5A20, 6F:$6475, 70:$4192/$6556, 71:$4E34, 93:$56F3. New test tests/test_asset_streams.py decompresses every `.lz` slice in src/assets.txt with tools/lzss_gfx.py and requires the stream to fit its slice; against the old src/assets.txt it found 30 short slices, now none except four whose decoder reads one or two bytes of the next slice (`SHARED_TAIL`). Overlapping pseudo-streams from other sources in banks $03 and $F1 (BuildItemScreen records) are not chain streams and are left as they were. 8 of the 13 unidentified slices of E-0383 were such tails and are gone; 5 remain in docs/UNIDENTIFIED_ASSETS.md. Eleven names.json entries at dropped addresses were removed.
- **Code at bank $32 $4F00.** The bytes at $4F00, printed since E-0380 as five `dw` words after the five-entry table at $4EF2, are the target of a `jp` in RunBattleActions_StatusChecks_CheckAction_CheckMP (taken when ActorActionIsD0ToE3 sets hTemp0). config/code_entries.json now traces $4F00 as code: it decodes as `call` CheckFormationPartnersCanAct, `jr c`, `ld a, d`, `cp 7`, `jp z`, `and $07`... and is named RunBattleActions_StatusChecks_PairRefusal (C1; note in config/annotations.json). The old labels ApplyActionResultAndMarkFormation ($4F0A, one byte into the `jp z`), RollSleepWakeUp_SetWakingAction ($4ECA) and BattleActions_ZeroPadding ($7A49) are gone with their two E-0380 probes; the routines in probe scope fall from 5,874 to 5,872 and the code labels from 9,822 to 9,820, all read.
- **One name per table.** A table label (config/tables.json or a generated layout) and a data label (a config/names.json name, a heuristic name or a referrer's name) at the same address printed two labels; E-0381 had pointed the second at the first's note. tools/disasm_all.py `fold_table_names` now keeps one: a config/names.json name wins, then a config/tables.json label, then the data label over a generated address name (Kind_BB_AAAA, Kind_AAAA); the header, operands and pointer fields use it, and derived notes that named the dropped label are rewritten. 373 tables folded; 17 data labels that name entry 0 of a record series (DefaultName_Slime_00, SpeciesRecord_000 and the like: another label inside the table shares the stem) stay, under an "entry 0 of" comment. Names chosen by hand: WorldMapOverviewPalettes (5D:$4139; it was RunWorldMapState_CopyScrollToHardware_BGPaletteBufferData, 57 characters, with a second name of 48; read by RunWorldMapState_DrawOverview); Map0DPalettes, Map0APalettes, Map13Palettes and Map19Palettes keep their map names over BreedMenuPalettes, EggServicePalettes, RenameMenuPalettes and DebugStaffRoll_Scene03_Load_BGPaletteBufferData (each is the palette set of its map, which the menu or staff roll also copies; three open questions of E-0381 resolved). A config/names.json note on a table now prints above it in src/ (before, the second label's note was not printed). Notes that cited a dropped name were rewritten (tools/label_map.py) and redundant "X (X)" pairs removed.
- **Measures** (build/run651): 32,980 labels (33,383 before), 0 mechanical, 0 raw pointer operands; 9,820 code labels, all with a hand note; 23,160 data labels; no label over 50 characters; 3,546 INCBIN lines; 5,872 routines in probe scope, all probed (16,780 probes); every readability queue at 0.
- **Checks.** build/run645 (streams), build/run647 ($4F00), build/run649 to build/run651 (names) PASS: approved size and SHA-256, zero differing bytes. Serial full suite build/logs/suite651.log OK (398 tests, 3 skipped). tests/test_doc_coverage.py hand-note floor 9,822 to 9,820 (the labels removed above).

### E-0386 — Readability batch 18 and completion: the last 89 routines; every queue at 0

- Date: 2026-10-16. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit bf033a8.
- **Method.** The rest of the combined queue (89 routines in banks $F1-$F2: 71 without a hand note, 40 in probe scope without a probe) in four Sonnet slices of 20-23. 89 entries: 74 notes, 40 routines probed (109 probes, all passing; config/probes/E-0386.json). The integrator read 20 entries against the code: all correct. Integrator changes: nine child and data labels took the new prefix of their renamed parents (DrawRecordBufBParents_DrawNames and _DrawIcons, DrawRecordBufBHpMpDigits_Data1); GiftEffect_BookmarkEtc, the shared gift case that only clears wPendingGiftItem, became GiftEffect_None, which leaves no `Etc` name.
- **Tools and tests.** tools/probe_scope.py writes docs/PROBE_SCOPE.md with a Limits paragraph (WRAM bank 2 writes are not observed by a probe; a video-RAM symbol used as a number puts a routine out of scope). New tests: tests/test_probe_scope.py checks that every in-scope routine has a passing probe or a documented reason; the ratchet in tests/test_doc_coverage.py now holds the unread, instruction-named, data, asset and `Etc` counts at 0.
- **Final measures** (tools/readability.py, tools/doc_coverage.py, tools/readability_queue.py, tools/probe_scope.py on build/run643): 33,383 labels, 0 mechanical labels, 0 raw pointer operands; 9,822 code labels, all 9,822 with a hand-written reading note and none named after its instructions; 23,561 data labels, all commented, none described only by its reader; no label over 60 characters (two second-name aliases of 56 and 57 characters, documented in docs/ROADMAP.md); 3,550 INCBIN slices, 140 of the 153 that were opaque identified and 13 listed in docs/UNIDENTIFIED_ASSETS.md; 5,874 routines in probe scope, all with a passing probe (16,782 probes in config/probes/), and 3,948 out of scope with the reason in docs/PROBE_SCOPE.md; no stale name in any src file.
- **Checks.** build/run643 PASS (approved size and SHA-256, zero differing bytes); no stale name; serial full suite build/logs/suite643.log OK (397 tests, 3 skipped). docs/ROADMAP.md marks the readability goal complete.

### E-0385 — Readability batch 17: 900 routines in banks $85-$F1 read or probed (742 probed, 2,281 probes)

- Date: 2026-10-16. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 9a0cd8c (E-0384).
- **Method.** Slices 7-12 of the twelve drafted with E-0384 (D-014), three of them rerun after the usage stop. Before validation the drafts were moved onto the post-E-0384 names (62 renames). 900 entries: 537 notes, 742 routines probed (2,281 probes, all passing; config/probes/E-0385.json). The integrator read 90 entries (15 per draft) against the code: all correct, 0% rejection. Integrator changes: nine child and data labels took the new prefix of their renamed parents (SetWorldMapPlayerScreenByMapType_PlaceAtExit and the others, DrawMetaSpriteSet_BankE1_BuildOam, FindMinOfSixStatWords_Data); a derived table label of 54 characters was named EffectViewerScreenTileRect.
- **Names.** 38, among them FindMinOfSixStatWords and FindMaxOfSixStatWords (they compare six record words, not five), SetWorldMapPlayerScreenByMapType (game mode 2 is the pause menu; its only caller is the world map), LoadBattleSlotC_A0 and its party and foe steps, the seven unreferenced AIScoreB_ wrappers (AIScore_<Skill>_UnreferencedVariant: no table entry or pointer reaches them), RaiseLowestResistances (the pick is not random) and the staff-roll hop steps (they add the hop to Y).
- **Earlier readings corrected** (with passing probes): ComputeBattleResultRank only reads wWildLevel; ApplyBattleResultStatChanges searches six words and caps the gold; SubtractCFromWordMin1's B; RunBattleCommandEntry_BankA1_MarkEnemySlots marks slots 4-6; SaveActionChoicesAndPickFormations stops in link mode 1; AddBCToWordAtHL returns HL + 1; the AI weight routines send negative rows to wAISkillScore2; InitBattleSlotsForFoeCount's slot 6 and 7; the canal gate hop runs twice; FormationCompatibilityRoll uses B mod 3.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0385.
- **Checks.** build/run_E-0385, build/run_E-0385b and build/run641 (after the child renames) PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par641.log OK (396 tests, 3 skipped; 16,673 probes). Queue: unread 554 to 71; hand readings 9,751.

### E-0384 — Readability batch 16: 900 routines in banks $01-$85 read or probed (783 probed, 2,646 probes)

- Date: 2026-10-16. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 3e8d4ae (E-0383).
- **Method.** The first six of twelve slices of 150 of the combined queue (the other six are E-0385, drafted at the same time; D-014). Four workers were stopped part-way by a usage limit and rerun; the reruns reused their own earlier scripts after re-running every probe, and an unfinished draft whose worker had not reported was set aside rather than used. 900 entries: 471 notes, 783 routines probed (2,646 probes, all passing; config/probes/E-0384.json). The integrator read 90 entries (15 per draft) against the code: all correct, 0% rejection. Integrator changes: one note's reading that object 2 is placed "beside the lead object" was cut to what the code shows (a position picked by the state of object 1); seven child and data labels took the new prefix of their renamed parents (for example KeyWorldLayout_BuildEntrance_Kind1_Data, SetupTownObjectsForMap_RollObjects_PlaceObject, AddMenuStateToPartyStatCapped_StatOffsets).
- **Names.** 55, among them the key-world generator (GenerateKeyWorld_RollMonsters_Normal and the others, CheckKeyWorldCellIsOpen: it answers 1 for an open cell), the key-world entrance builder (KeyWorldLayout_BuildEntrance and its kinds, which the debug automap name hid), the battle item effects (ItemEffect_Meat and the others), the slot getters (GetSlotLevel, GetSlotTrait), MedicineMaster_FindLowestStat (it picks the lowest of six stats; the copied strings are stat names) and DrawMetaSprite_Sets98.
- **Earlier readings corrected** (with passing probes): SubtractGoldFloorZero wraps the gold when wGoldHi is 0 (the merchant and the casino ship); EggServiceMenu_ChooseAndPay_CheckPrice and the appraisal pay at different steps; EggServiceMenu_Appraise_NameTrait compares three personality bytes, not all; BreedMenu_DoOption's option 0; HibernateMenu checks a free hibernation slot; the CheckBreedingRecipes bit 4 rule; ScriptStepBlinkSpritesThenEnd blinks faster, not slower; SceneRealKing moves the objects together; SceneLearnQuick slows on 8 of each 16 frames.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0384.
- **Checks.** build/run_E-0384 and build/run640 (after the child renames) PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par640.log OK (396 tests, 3 skipped; 14,392 probes). Queue: unread 920 to 554; hand readings 9,268.

### E-0383 — Readability batch 15: the 153 opaque INCBIN slices identified (140) or documented (13)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (C1: loaders read, streams decompressed and rendered with tools/tile_sheet.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 22fc8b4 (E-0382).
- **Method.** The asset queue (INCBIN slices placed only by the catch-all rule in gfx/misc/) in six slices of 23-26, Sonnet workers with image access, drafted alongside E-0382 (D-014). Each worker read the loaders, decompressed and rendered every stream and wrote a note: kind (tiles, tile map, attribute map), decompressed size, who loads it where, what the render shows, or what is still unknown. The integrator reviewed 18 sampled entries and checked one stream-tail claim against the decompressor (Map2FTileset at 93:$533D consumes 1,059 bytes and ends at Map2FPalettes, $5760, so Gfx93_1 at $56F3 is its tail): no rejection. Integrator changes: the key-world screen maps named by three workers now all end in `Tilemap` (49 names; one worker had `_Tiles` on tile maps), two names over 50 characters were shortened, and four notes were reworded to cite existing labels.
- **Result.** 140 identified and named: the title logo, intro and copyright screens, the link result banners (LinkResultYouWinTiles and the others), the world map overview tiles, field command and trigger sprites (EggHatchSpriteTiles, FoundItemBottleSpriteTiles), the unused door rooms of three unlisted map records, and 98 key-world floor screens that no room record points to (KeyWorldIceLowerPitTilemap and the others; their tile set is inferred from bank position and a coherent render, C1). 13 stay unidentified and are listed in [UNIDENTIFIED_ASSETS.md](UNIDENTIFIED_ASSETS.md) with what was tried: 11 are not assets but the tail or middle of another stream that the generator's chaining heuristic (config/stream_chains.json) split off (Gfx4C_5, Gfx54_1, Gfx65_1, Gfx65_3, Gfx65_4, Gfx66_6, Gfx6D_1, Gfx6F_1, Gfx70_1, Gfx71_1, Gfx93_1), plus Gfx16_1 (a valid 4-tile stream with no loader) and SpawnScriptSpriteInFrontOfPlayer_Data (its only routine has no caller). tools/readability_queue.py counts a hand-noted INCBIN label as identified (since E-0380); a ratchet in tests/test_doc_coverage.py keeps the asset queue at 0.
- **Also found.** Tiles1Gfx_2 holds a TARAS ADVENTURE banner row the US title maps never place (a leftover of the Tara release); ScenePoorChurch renders as a sand shore with palms, not a church; DrawTitleSaveSummaryScreen has no caller.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0383.
- **Checks.** build/run_E-0383 and build/run_E-0383b PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par639.log OK (396 tests, 3 skipped). Queue: assets 153 to 0.

### E-0382 — Readability batch 14: 723 routines in banks $36-$3A read or probed (675 probed, 2,558 probes)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 159d322 (the merge into master).
- **Method.** The combined queue in six slices of 112-150 (grown by half after two batches under 5%; the slicer now caps a slice at 150), Sonnet workers, drafted alongside the asset batch E-0383 (D-014). 723 entries: 356 notes, 675 routines probed (2,558 probes, all passing; config/probes/E-0382.json). The integrator read 78 entries (13 per draft) against the code: all correct, 0% rejection. Integrator change: three notes named "the ActionTargetRoutines tables", now ActionTargetRoutines0 to ActionTargetRoutines4.
- **Names.** 33, among them CheckBattleDecided (its five callers read carry as the battle being decided), SlotOutOrParalyzed, ShowActionRefusedMessage, ActionEffect_Surround (entry 46 of ActionEffectTable, filed as a resolve step), TargetAllyConfused / Paralyzed / Cursed, the link record converters (PackRecordBufAToLinkWorkBuf: it packs this side's record for sending; ConvertLinkNameBytesToGameGlyphs; ScaleStatWordsFromLinkFormat) and CopyBBytesDEToHL_Bank37 (its family name: it copies [DE] to [HL]).
- **Probe scope (tools/probe_scope.py).** rRAMG2 ($1FFF, the top of the MBC5 RAM-enable range, which tools/sm83.py maps like rRAMG) was counted as hardware, so 151 routines that only enable save RAM through it were out of probe scope. It is now a bank register (D-012), with a fixture case in tests/test_probe_scope.py: probe scope 5,723 to 5,874 routines.
- **Earlier readings corrected** (with passing probes): SlotDEFBelowBuffCap's cap rule (4 x base DEF for slots 0-3 or link mode 1, else 2 x); BuffCapOfBaseDEF and BuffCapOfBaseAGL return a base of 999 or more unchanged; ChooseTarget_Heal_2, _Heal_3, _Beat, _Transform and _MegaMagic (the estimate is 90/100 of the loop pair, not of the actor MP and level); ActionEffect_Upper adds half the base DEF and Increase a third; MagicWall, TailWind, Cover and two formation actions visit only the first three slots of a side; RemoveCFromActionQueue shifts nine bytes; RunBattleActions has 11 sub-steps and returns in link mode; the effect-routine notes (palette inversion and flash steps).
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0382.
- **Checks.** build/run_E-0382 and build/run638 (after the derived-citation regeneration, which tools now repeat automatically) PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par638.log OK (396 tests, 3 skipped; 11,746 probes). Queue: unread 1,249 to 920; hand readings 8,902.

### E-0381 — Readability batch 13: notes for all 491 data labels described only by their reader

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1), plus a comment-only generation change. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 9251d6b (E-0380).
- **Method.** The data queue (labels whose only comment was "data read by X (N bytes)") in six slices of 81-82, Sonnet workers drafting at the same time as E-0380 (D-014). Each note gives the entry layout and width, the number of entries, what the values mean as their readers use them (BG-map offsets decoded to row and column, VRAM tile addresses, record field offsets, string tables) and the index that selects an entry. Before validation the drafts were moved onto the post-E-0380 names (61 renames). The integrator read 54 entries (9 per draft) against the bytes and readers, decoding the offsets and counts: all correct, 0% rejection. 491 notes, 30 names (among them the bank $17 Super Game Boy packets that were filed as PointerRun_Entry*, now SgbDataSnd_Bank17_Id2 and the others; BattleMenu_FourRowCursorOffsets and BattleMenu_ThreeRowCursorOffsets, the cursor tables shared by eight and twelve battle menu routines; StringDatabase_ItemNames).
- **Integrator changes.** (1) The entry at bank $32 $4F00 (RunBattleActions_StatusChecks_CheckAction_Skip) is a code label whose bytes the generator prints as `dw`; its note says so and went into the label's config/names.json entry rather than a data note. (2) 35 drafted labels are second names for a table that has its own label at the same address; their notes went to the table (config/tables.json), and tools/present.py now writes "another name for the data at <label>, whose note is above (E-0381)" above such a second label instead of the generic reader comment (comment-only; src/ regenerated, build/run635 and build/run636 PASS on the changed tool). 380 labels get that line. (3) A ratchet in tests/test_doc_coverage.py keeps the data queue at 0. Committed with E-0380: tools/readability_queue.py counts an INCBIN asset as identified when its label has a hand-written note (test in tests/test_label_map.py), for the asset batch.
- **Wrong comments found** (the old reader comments, now replaced): sizes that counted only the written `db` values (CheckLinkRuleViolation_Data is 232 bytes, RollKeyWorldObjectKind_Data 1,040, two debug screen images 360 and 320 bytes); StartPaletteFade_SetUpTiming_Data is used for its address ($7FFF, white), never read; DrawNameGlyph_Bank1D_Data is the tail of a code wrapper whose address serves as the GlyphFont base; several tables have entries their readers cannot reach, or readers that can run past them (BreedMenu_ReturnToMap_CopySixteenTiles, WriteFiveTilesFromTable_2_Data). The EVENT_KING_IF_YOU_SEE constants said "no setter found"; TravelerEvents_Thief_ShowTheFugitiveMasterWas sets them (open question, constants not changed here).
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0381.
- **Checks.** build/run636 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par636.log OK (396 tests, 3 skipped). Queue: data 491 to 0; unread 1,249; assets 153.

### E-0380 — Readability batch 12: 457 routines in banks $31-$36 read or probed (352 probed, 1,519 probes)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 795c941 (E-0379).
- **Method.** The combined queue in six slices of 75-80, Sonnet workers (D-013). The data-label batch E-0381 was drafted at the same time by six other read-only workers and integrated after this one (D-014). 457 entries: 297 notes, 352 routines probed (1,519 probes, all passing; config/probes/E-0380.json). The integrator read 48 entries (8 per draft) against the code: all correct, 0% rejection (the second batch in a row under 5%).
- **Names.** 46 names, among them the battle defeat-step runners (RunEffectSubStep, _2, _3, RunBattleSubStep2, _2_2 became RecoilEffect_DefeatSteps, SacrificeEffect_DefeatSteps, QuarterRecoilEffect_DefeatSteps, RunBattleSubStep_DefeatSteps and UseItemDefeat_RunSteps), the resolve steps named after what they show (ResolveStepCriticalRoll, ResolveStepRolledOutOfWay), BattleEnd_Records_StoreMP (it stores, it does not subtract), the PayActionMP steps (any action, not only pairs) and RefreshTargetResistancesFromRecord. The integrator renamed the 14 given child steps of the five defeat-step runners to their new parent prefixes (RecoilEffect_DefeatSteps_Defeat and the others) and regenerated after the derived-citation rewrite, which the first regeneration had preceded (the generated-source annotation test caught it).
- **Earlier readings corrected** (with passing probes): ResolveStepEffectChecks dodges by target AGL minus actor AGL; ResolveStepCriticalRoll reads the actor byte of wPersonalityActs; ApplyDamageToTarget rewinds on a result of exactly 0 too; CopyBlockToTileBuffer uses only E; ActionEffect_MegaMagic_Damage and ActionEffect_ActionD9_Damage do not cut the damage to 40 percent (40 percent / 4 is the size of the random spread); SetSubPhase2AndRestartResolve clears bits 2-3 for ACTION_CC; RaiseTargetDEF and RaiseTargetAGL differ at the cap; CheckSkillMPCost leaves D on success.
- **Code typed as data.** Two workers found that the five `dw` under RunBattleActions_StatusChecks_CheckAction_Skip (bank $32, $4F00) are instructions that RunBattleActions_StatusChecks_CheckAction_CheckMP jumps into (call CheckFormationPartnersCanAct, jr c, ld a, d, cp 7, jp z), falling into ApplyActionResultAndMarkFormation. The bytes are preserved; the code/data map is an open question for the disassembly (not a readability change).
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0380.
- **Checks.** build/run_E-0380 and build/run633 (after the child renames) PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par633.log OK (396 tests, 3 skipped; 9,188 probes). Queue: unread 1,533 to 1,249; hand readings 8,573.

### E-0379 — Readability batch 11: 459 routines in banks $19-$31 read or probed; stale names in the include files

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py), plus a comment-only generation change. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 4bbd32b (E-0378).
- **Method.** The combined queue in six slices of 75-80 (halved after E-0378), all drafted by Sonnet workers (D-013). The brief now lists the defects that rejected the E-0378 Haiku drafts. Every draft was applied only after its worker reported done. 459 entries: 364 notes, 233 routines probed (823 probes, all passing; config/probes/E-0379.json). The integrator read 48 entries (8 per draft) against the code: all correct, 0% rejection.
- **Names.** 49 names, among them the cursor helpers of the shop, vault and swap menus named after their menu (ShopMenu_Buy_YesNoCursor_Blink and the others), the link battle setup states that were filed under EggServiceMenu_Bank1B (LinkBattleSetupMenu_WaitForPartner, _PickRecords, _ConfirmAndStart), TryAddSkillUnlessBetterKnown (the skill lists hold later stages, not prerequisites), and the Pedigree sprite routines. 18 derived labels followed their parents; four of them were named by the integrator: VaultMenu_ItemsGoldExit_Cursor, SwapMonstersMenu_MonstersOrEggsCursor, LinkBattleSetupMenu_ShowBattlePrizeExit and BreedingStrings_Category0.
- **Stale names in the include files.** The stale-name check covered only the bank files. src/ram.asm, src/records.inc, src/macros.inc and src/charmap.inc still cited 58 old names (73 uses). One read-only Sonnet worker traced each to today's routine through its RAM symbol's readers and writers or its address alias; the integrator checked the traces against the code and applied them in config/symbols.json, config/record_fields.json and config/script_commands.json, and in the comment strings of tools/gb_text.py and tools/disasm_all.py (generation of comments only). Six comments were also wrong by today's code and were reworded: wStepTriggerFlag (set when the step triggers have been scanned, cleared at the end of a step), wSoundFadeLevel (StepMusicVolumeFade counts it down; the halving is in the uncalled UnreferencedStartSoundFadeA), wLinkSeedCopy (copied when the partner message 5 arrives, used as the partner name), wLinkTradeByte, the AGL/DEF reset (ResetTargetAGLAndDEFToBase) and the CheckLinkRules1RuleBit routines. A new test (test_include_and_ram_comments_name_only_current_labels) keeps these files clean.
- **Earlier readings corrected** (with passing probes): LinkKeyTrade_HasLikeKey answers $FF only for a story key of the same kind; ComputeSellPrice returns E:HL; ShopMenu_Setup_AdvanceScreenStep falls into the tile copy; the BlinkCD helpers draw the edited digit and tile $CB; ReadF2FarPointerForScreenTableIndex (now LoadScreenNumberListPointer) reads 2-byte words; the BG-map rectangle helpers of the vault save to BG map 1 rather than draw; SetBattlerFamilyAndSex pops its own return address; AccumulateGrowthForLevelsTemp1 stores the foe experience over BATTLER_EXP.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0379.
- **Checks.** build/run630 (before the generator-string change) and build/run631 (after it) PASS (approved size and SHA-256, zero differing bytes); no stale name in any src file; parallel suite build/logs/par631.log OK (395 tests, 3 skipped; 7,669 probes). Queue: unread 1,886 to 1,533; hand readings 8,289.

### E-0378 — Readability batch 10: 452 routines in banks $16-$31 read or probed; three Haiku drafts rejected

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit a0b8f61 (E-0377).
- **Method.** The combined queue in six slices of 150-153, plus five notes reported wrong in E-0377 as "recheck" items. Under D-013 slices 1, 5 and 6 were drafted by Sonnet workers and slices 2, 3 and 4 by Haiku workers. Every draft was applied only after its worker reported done.
- **Rejected (451 labels, 50%).** Slice 2: notes that say parts of the routine were "not read" (LoadBattleSlotFromBattlerRecord_2) and not-probed reasons that do not hold (a 32-entry key list is easy to set up). Slice 3: 90 notes cite callers by source line number, which changes at every regeneration. Slice 4: DrawSpeciesMetaSpriteAtScrollOffset was read as taking C as an input, but its first instruction sets C = 0. Their labels go back to the queue. Under the adaptive rules the slice size is halved to 75, and Haiku is dropped for drafting.
- **Accepted (slices 1, 5, 6).** 452 entries: 307 notes, 330 routines probed (1,152 probes, all passing; config/probes/E-0378.json). The integrator read 46 entries against the code: all correct. Integrator changes: two one-line notes expanded (StoreTileADAtHL, StoreTileAEAtHL); a recheck entry without a change dropped (ItemUsable_MoonHerb, whose existing note was confirmed); one note reworded to name an existing label; one probe added (16:425E#4: a fallen member before a qualifying one leaves wItemId = $FF, the claim of the new ListPartyMembersWithField55Bit0 note).
- **Names.** 29 names, among them the battle-phase steps (BattlePhase0_Step0-4, BattleFight_Step0/1/3, BattleEnd_Step0-9) named after what each step does. Three parents were shortened (BattleEnd_Records, BattleEnd_Result, BattlePhase0_Intro) so that the 65 child labels could take the new parent prefix within 50 characters (BattlePhase0_Step2_IntroMessage* became BattlePhase0_Intro_Message*). A stale name in config/record_fields.json (the SPECIES_JOIN_CLASS reader) was corrected to BattleEnd_OfferJoin_DecideJoinOffer.
- **Earlier readings corrected** (with passing probes): FieldSkillEffect_HealPartyHurt heals 90-120; FieldSkillEffect_Revive restores HP only; HealRecordHPByRandomAmount uses wRandomLo mod (amount + 1); AddDEToWordAtHLCappedAtBC stores the wrapped sum on a 16-bit carry; CountSpeciesPerFamilyFlaggedOrListed counts when wArg5 is $FF; BreedMenu_ChooseParents_CheckChildIsNew needs the bit clear in all three bit fields; BGTileUnderPointIsSpriteHideTile callers skip a part on carry clear (tile at or above hSpriteHideTile); GameMode6_Init clears 256 bytes; the AI weight routines (AIChooseActionForActor_AddHPWeights, SortAIChoiceWeightsAndWeightSkills) had their totals and tie handling wrong; RollPersonalityActsForChosenAction runs for the party slots, not the foes.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0378.
- **Checks.** build/run629 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par629.log OK (394 tests, 3 skipped; 6,846 probes). Queue: unread 2,184 to 1,886; hand readings 7,936.

### E-0377 — Readability batch 9: 904 routines in banks $10-$16 read or probed (808 probed, 1,639 probes)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit fb740fb (E-0376).
- **Method.** The combined queue in six slices of 150-152 (the cap), covering the talk tables of bank $13 (Fhunt, Norden, Great Log), the field objects of bank $12, the name entry and hibernation menus of bank $14, the breeding menu of bank $15 and the items of bank $16. Every draft was applied only after its worker reported done. The workers wrote 652 notes and probed 808 routines (1,639 probes, all passing again; config/probes/E-0377.json). The integrator read 91 entries (at least 10% of each draft) against the code, including every talk-table index and branch message cited in the sample: all correct, 0% rejection. 14 names were proposed and applied (for example IfFlag0021StartScript became GreatLogTalkEvents_YoureTheChildAfterRival, CheckRecordFlag55Bit7 became RefuseItemIfRecordFallen, HibernateMenu_IndexListEntry became HibernateMenu_ReleaseSleeper); no derived label changed.
- **Tool change (not generation).** Some jumptable states pop a flag their runner pushed, so a probe can only enter them through the runner (RunMessageBox_Bank12_Close through RunMessageBox_Bank12). A probe may now carry `"target": "BB:AAAA"`, the routine it checks when that is not the routine it runs from; tools/probe.py `checks()` gives that key, and tools/apply_drafts.py, tools/probe_scope.py and tests/test_probes.py use it. Covered by a new test in tests/test_apply_drafts.py (a targeted probe counts for its target and not for the routine it runs from). The two runners got their own untargeted copy of one passing probe each. Generation is unchanged: src/ was regenerated by the same tools/present.py.
- **Earlier readings corrected** (with passing probes): FieldSkillEffect_HealOne heals 30-40 HP and FieldSkillEffect_HealOneMore 75-90; SubtractAFromRecordWordFloor1 and the RemoveEquipmentBonus steps leave an exact 0 at 0; FieldSkillUsable_CurePartyPoison lists members with MON_STATUS bit 0, not the poison bit 2; the FhuntTalkEvents_PowerOfJustice handlers choose between the script and the message on an hTemp0 their helper does not always set; seven NordenTalkEvents entry numbers were wrong; NordenTalkEvents_SecondShieldScene never checks for the Crest; GreatLogTalkEvents has 247 entries and messages up to $0DEF; GreatLogTalkEvents_ArenaClassChoice, GreatLogTalkEvents_Shopkeeper and Talk04CB_ThatKeyIUsed had wrong conditions; BreedMenu_ChooseParents_BackToOptions returns to state 2; CopyScreenBufferRectWithAttrs_Bank14 copies a 16-bit count per row; CopyF0StringAndRedrawNameEntry draws no glyphs; RemoveRecordBFromParty leaves a copy of the last entry; PrepareCounterEntry stops at the first matching or empty entry; RollFieldEventOnTallTiles rolls at or below wMapTallTileMin and needs the TinyMedal; SubtractGoldFloorZero's floor test is inverted; DrawAnimatedMetaSprite1B uses the frame counter modulo 30; DrawFieldSprites draws one entry; TriggerEventCBIfMemberStatused compares MON_MAX_HP with itself.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0377, with the notes workers reported wrong outside their slices (queued for the next batch).
- **Checks.** build/run_E-0377 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par627.log OK (394 tests, 3 skipped; 5,694 probes). Queue: unread 2,809 to 2,184; hand readings 7,638.

### E-0376 — Readability batch 8: 910 routines in banks $0A-$12 read or probed (727 probed, 1,266 probes)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit f57a421 (E-0375).
- **Method.** The combined queue in six slices of 150-154 (the cap). Every draft was applied only after its worker reported done. The workers wrote 481 notes and probed 727 routines (1,266 probes, all passing again; config/probes/E-0376.json). The integrator read 90 entries (10% of each draft) against the code: all correct, 0% rejection.
- **Integrator changes.** ScriptCommand6C had a probe that checked only wScriptStartRequest while its note is about the monster record it creates: the probe was dropped and the reason recorded in config/probe_exclusions.json. Three C2 claims without a probe were set to C1, and the two scene dispatchers SceneHomecoming and SceneDarckDefeated, which had passing probes, were marked probed. The derived tile lists of EggServiceMenu_DrawPrice_LoadTiles became EggPriceGlyphDestList and EggPriceGlyphSrcList.
- **Earlier readings corrected** (with passing probes): SceneWarubouWarning_Answer turns MSG_KEEP_OPEN into MSG_ALREADY_OPEN, so the box closes after the answer; SceneLandHo_ScrollUp makes 15 one-pixel steps; SceneExplosion_Shake runs 16 frames (wScriptParam0 climbs by two); MedalPrizeMenu_DrawPrices draws two digits; MedalPrizeMenu_RemoveItem2C clears every $2C slot unless B is 1; the key appraisal looks for the next unappraised key ($FE kind byte), not an end mark; RollChildRecordPlusChanceOrIncArg5 had its outcomes swapped; KeyWorldBossBattle_MarkCleared sets bit 6 of byte 0 of the key entry; ScriptStepAnimateSpriteBySteps gives 3 for counts 12-17; StartEventScript only sets up a script command (BeginScriptCommand); ScriptCommand03 falls into ScriptCommand02 (two pixels a frame for script_walk_fast).
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0376 (stale names in macros.inc comments; unreachable script command types; SceneShieldGuardian removing an item it did not find).
- **Checks.** build/run626 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par626.log OK (393 tests, 3 skipped; 4,055 probes). Queue: unread 3,275 to 2,809; hand readings 7,013.

### E-0375 — Readability batch 7: 816 routines in banks $00-$0A read or probed (768 probed, 1,803 probes)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit eee8846 (E-0374).
- **Method.** The combined queue (routines without a hand reading, and probe-scope routines without a probe) in six slices of 135-139, grown by half after two batches at 0%. The workers wrote 623 notes and probed 768 routines (1,803 probes, all passing again under tools/apply_drafts.py; config/probes/E-0375.json). The integrator read 84 entries (10% of each draft) against the code: all correct, 0% rejection.
- **A re-apply.** The integrator first applied the batch as soon as every draft file held one entry per slice item; worker 4 was still refining its file and later changed 58 notes. The applied config and source were reverted to E-0374, all six final drafts were validated again (816 entries, 1,803 probes), draft 4 was spot-checked again (14 entries, all correct) and the batch was applied from the final files. Rule from here on: a draft is applied only after its worker has reported that it is done.
- **Integrator changes.** One routine still without a hand reading, AllOtherAlliesHaveStatus0Bit6 (05:4777), was probed but given no note; its older E-0092 reading matches the three probes and is now its hand note (C2, E-0375). tools/apply_drafts.py now refuses a draft entry that leaves a routine without a hand reading. A wildcard citation in one note ('AnyFoeLacks*') was reworded.
- **Earlier readings corrected** (with passing probes): YoldTalkEvents_ShowHeroCheckedThePedestal shows 'It has a hole' only without the MoonRock; DarckTalkEvents_HeardFromLord needs all three items for its second script; AIScore_MetalCut's condition passes only when a metal foe is present (AIScore_MetalCut_Conditions_MetalFoePresent); AIScore_UltraDown's DEF, AGL and blind tests never run (`ld a, h` / `jr nz` tests a flag left by an address addition); AIScore_TakeMagic reads the bytes before the skill ids; AIAddScoresForTwoLists_SealingFoes cannot return 0 (C holds an address byte); AIScore_MPass compares max MP with MP the wrong way round; the skill-list checks FailIfFoeKnowsSkills42To47 and others read their list from a nibble-swapped address byte; several AI checks read status bytes 1, 3 or 5 where the notes said 0, 2 or 4; FillEncounterFromEntry's 17-byte entries hold five thresholds; the ElvenVillageTalkEvents table also uses messages $07C0-$07DD and has 29 zero entries.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0375 (likely game bugs found by reading and probing; routines with no caller; the unconditional `ret` in GameMode5_Update_ShowScreen0 that makes the intro skip unreachable).
- **Checks.** build/run624 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par624.log OK (393 tests, 3 skipped; 2,789 probes). Queue: unread 3,896 to 3,275; hand readings 6,548.
- **Limits.** Probes run on the project's emulator for the inputs they use; the likely bugs are readings, not observed play.

### E-0374 — Readability batch 6: 544 routines in banks $00-$04 read or probed (378 probed, 729 probes)

- Date: 2026-10-15. Kind: REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 5c77973 (E-0373).
- **Method.** From this batch on one pass covers queue 3 and queue 6 together: each slice is the next run of code labels that either lack a hand reading or are in probe scope without a probe, in source order, slices of 90 (grown after two batches at 0%), with callers and tables listed. The six workers stopped once on a usage limit and were resumed with their context; they wrote 402 notes (new readings and corrections), probed 378 routines with 729 probes, all passing again under tools/apply_drafts.py, and left one routine unprobed with a reason (UpdateSpriteSlots_NoHandler, a bare `ret` reached only through its jump table), now in config/probe_exclusions.json. A probe of a kept hand note turns its ending into "(C2, E-03xx; probed E-0374)". The integrator read 54 entries (10% of each draft) against the code, all correct: 0% rejection.
- **Earlier readings corrected** (with passing probes where in scope): VerifySaveChecksum had its C cases reversed (now ReloadSaveBlocksWithChecksum); MapMusicByFlag23 plays $19; WarpEffect's note described the field menu; StartSound_FromTable's $FF goes to slot byte 10 and its stereo mask comes from the old byte 1; LoadWavePattern's offset is A x 256 + E; SoundTick_StepEnvelope overflows at 15 + 15; YoldTalkEvents_MermaidPast had its first test backwards; the UpdateSpriteSlots path steps play looping frame lists (now UpdateSpriteSlots_FrameLoopType4/5) and do not move objects; the wander routines move left and right within $20 of home; the field-skill checks only check (FieldSkillEffect applies); BrightenFieldMenuColors keeps blue, green, red; GameMode1_Init_StepCount returns the SGB border set (GameMode1_Init_PickSGBBorderSet); IncrementPlayTime stops at 999:59:00.
- **Integrator changes.** tools/apply_drafts.py accepts entries that only probe a kept note or record a reason for not probing, requires a reason for every unprobed entry, and writes those reasons to config/probe_exclusions.json. tools/present.py's hand-note pattern accepts the "; probed E-xxxx" ending wrapped across comment lines (a full regeneration reproduced the tested source). tools/probe_scope.py skips padding after a routine's last instruction (it had counted `db` padding as code, so a bare `ret` seemed to run on) and explains each out-of-scope routine for docs/PROBE_SCOPE.md (`--doc`).
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0374 (a presented operand `ld hl, hSndNoteTimer` that is the value -16; 7 unreached bytes after Talk_ListenYouTwoQuitYourHorsing that look like ReadableTalkEvents entry 3).
- **Checks.** build/run621 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par621.log OK (393 tests, 3 skipped), including 986 probes. Queue: unread 4,252 to 3,896; hand readings 5,948 (test floor raised).
- **Limits.** Probes run on the project's emulator for the inputs they use.

### E-0373 — Readability batch 5: the last long labels; 243 routines read and 135 probed on the emulator

- Date: 2026-10-15. Kind: PRESENTATION, REVIEW and OBSERVATION (static readings C1; probed claims C2 on tools/sm83.py, not hardware). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 26a4f93 (E-0372).
- **Method.** Two workers shortened the last 101 labels over 50 characters. Four workers took the first 243 code labels without a hand-written reading (bank $00 and the start of bank $01), wrote a whole-routine note for each and, for the 133 that tools/probe_scope.py places in probe scope (D-012), wrote probes and ran them read-only with tools/probe.py; two workers also probed a routine the classifier had left out (ReadFarPointerAtDEInBankB and UploadTwoTilesFromScriptTileBuf0 only touch registers and RAM). tools/apply_drafts.py ran every probe again on the reference ROM before applying (257 probes, all pass) and wrote them to config/probes/E-0373.json; the 135 probed notes end "(C2, E-0373)". The integrator read 35 entries (10% of each draft) against the code: all correct, so no draft was rejected (0%, the second batch in a row: slices grow to 90).
- **Integrator changes.** The referrer alias at 7E:$4BBD (beside SharedOBJPalettes) got neither a name nor a note in its draft and was left out; such doubled labels are a follow-up. The derived step F1:543D became RunScreenStateWhenNotFading_F1_StatsPage2Names and the 6 x 5 yes/no box at F1:5A72 BreedYesNoBoxTileRect.
- **Earlier readings corrected by probes or reading** (in the notes): ClearScrollPositions zeroes eight bytes, not four (probe 00:0B9B#1); CopyCGB40BytesFromBankAndMark7F puts the $7F at HL + $40 + C (00:080A); the first joypad auto-repeat comes 21 calls after a press, then every 6 (00:0A8D#1-4); ReadFarPointerAtDEInBankB leaves DE on the bank byte (DE + 2); Multiply8 returns A unchanged; WriteTwoDigitTilesFromDigits1 and WriteDecimalDigitTiles end DE on the last tile; FillTilesFromRequest returns only when both counts are 0; UploadTwoTilesFromScriptTileBuf0 saves VRAM tiles into wScriptTileBuf0/1 (now SaveTwoTilesToScriptTileBuf); ExpandGlyphTileToHL copies the glyph unchanged (CopyGlyphTileToHL); StartSound_FromTable writes $FF at slot byte 10; the link string $0F is the 'BredInfoExit' choice box, not the partner's monster.
- **Observations for later** (open questions): wLinkTimeoutLo/Hi is used as a send pointer and wLinkRole bit 1 as 'not the clock side' (ram.asm notes disagree); src/charmap.inc and the wTextNumber note cite former names; PrintTextStep's beep test compares the speed count, not the glyph.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0373.
- **Checks.** build/run618 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par618.log OK (392 tests, 3 skipped), now running the 257 probes and the check that every C2 batch note has a probe. Queue: over 50 characters 102 to 2 (two referrer aliases), over 60 characters 0; unread 4,499 to 4,252; tests/test_doc_coverage.py's hand-note floor raised to 5,570.
- **Limits.** Probes run on the project's emulator; they confirm the mechanical claims they test, for the inputs they use.

### E-0372 — Readability batch 4: the last instruction-named routines and 288 long labels

- Date: 2026-10-15. Kind: PRESENTATION and REVIEW (static readings, C1). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 291bfeef (E-0371).
- **Method.** After E-0371's 20.7% rejection the slices were halved to 60 and each slice item listed its callers (every line of src/ naming it) and the tables its body loads. Two slices (61 and 69 labels) re-drafted the 130 labels of the rejected E-0371 draft; four (60-80) took the first 288 labels over 50 characters, code and data. The brief added a rule from the rejection: a game-mode or state target is named by the current label of the jump-table entry it selects. 418 entries validated; the integrator read 43 (10% of each draft), all correct, so no draft was rejected (0%).
- **Names.** The re-queued slice now names TeamMode_Screen_Leave_WaitTextFlags_2 TeamMode_Screen_Leave_ExitToTitleMenu (its target, GameMode5_Init entry 1, is GameMode5_Init_TitleMenu). Long names were shortened for what the code does (RunBattleSetup_PlanMenu_RedrawLowerRows, whose four callers are all PLAN-menu steps; DrawGoldBoxFromScreenList); data labels are named by content (LibraryClassBlock_Class0-7, LibraryRowLastColumns_<Family>, NameEntryKeyboardTileRect, SharedOBJPalettes, BreedShowNameSpeciesBits) with notes on what the bytes are and who reads them (114 data notes).
- **Integrator changes.** Draft 6's notes quoted tile text with an apostrophe that unbalanced the quote stripping of the stale-name check; the phrases were rewritten as separate quoted words ('RESULTS', 'DuoW+', ...). StringCategories_95 became StringCategories_Bank95. A tables.json note that named the referrer alias of 7E:$4BBD by an old name now reads 'A table of CGB OBJ palettes'.
- **Earlier readings corrected** (in the labels' notes): RollSleepWakeUp either sets action $BF or shows text $82, not both, and RollSleepWakeUp_SetWakingAction is its tail (not a step of CheckAction); BattleEnd_GainExperience_Start always returns with part 9 (its `ld a, $08` path cannot run); BattleEnd_Step3_SubtractBattleMP stores wBattleMP capped at MON_MAX_MP; the MegaMagic and action $D9 damage keeps its value (40% only sizes a 10% spread); the forced-$CD check reads status 3, the $CA/$CB check status 0; A and B were swapped in two swap-menu notes; NamingScreenTileDestListA runs on into list B (31 destinations).
- **Observations for later** (open questions): 348 addresses carry two labels, a table label and a referrer alias such as TileRect_03 beside SkillTargetBoxRect_Default; the five `dw` words after RunBattleActions_StatusChecks_CheckAction_Skip decode as code; glyph destination lists in banks $0D and $14 pair a seventh tile with the $FFFF end word.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0372.
- **Checks.** build/run616 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par616.log OK (392 tests, 4 skipped). Queue: instruction-named 130 to 0; over 50 characters 427 to 102; over 60 characters 57 to 14; unread 4,499; reader-only data 501.
- **Limits.** Static readings; 10% of each draft checked.

### E-0371 — Readability batch 3: 516 instruction-named routines in banks $31-$F2 named; one draft rejected

- Date: 2026-10-15. Kind: PRESENTATION and REVIEW (static readings, C1). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 8a9e78fd (E-0370).
- **Method.** The rest of the instruction-named queue (642 labels) in five slices of 120-141 (the slice size grew by half after two batches at 0% rejection). Every entry validated; the integrator read 66 entries (10% of each draft).
- **Rejected draft.** In worker 1's draft (133 labels, banks $31-$36) the sampled TeamMode_Screen_Leave_WaitTextFlags_2 was named TeamMode_Screen_Leave_ExitToLinkMenu, repeating its old note's 'game mode 5, state 1 (the link menu)'; entry 1 of GameMode5_Init's jump table is GameMode5_Init_TitleMenu, as E-0370 had found. Under the batch rules the whole draft was rejected and its labels go back to the queue (130 instruction-named labels remain). Rejection rate 133 / 642 = 20.7%, above 20%: the next slices are halved to 60 and their briefs list each routine's callers and tables.
- **Integrator changes.** Twin helpers that two workers named differently were made consistent: the bank-$3B resolve-message stores take the bank-$36 names with `_Bank3B` (StoreActorMessage_Bank3B, StoreTargetMessage_Bank3B, StoreMessageFlags_Bank3B), the bank-$3B chance rolls RollChance84Percent_Bank3B ... RollChance15Percent_Bank3B, and the shared word-read tails of the GetBattle* getters GetBattleStatWord_BankNN (as GetBattleStatWord_Bank05). Two level-chance names with trailing numbers became RollChanceForLevel50Down and RollChanceForLevel100Down_Bank3B. Seven code labels whose derived names changed with their parents were named by the integrator (ActionEffect_Transform_TakeTargetStats, ShakeAndFlash_EndShake, ...).
- **Presentation fix.** tools/present.py writes the resolve-message register pairs as `lb hl, target, actor` / `lb bc, argument, flags` when the callee's name says so; the renamed stores no longer contain "ResolveMsg", so 86 operands fell back to `ld` and 37 read as bare addresses. Its pattern now also matches `Store...Message` and `StoreMessageFlags`; the lb counts of banks $36 and $3B are again those of E-0370. A full regeneration with the changed tool reproduced the tested source exactly (build/run614 PASS).
- **Earlier readings corrected** (in the labels' notes): ChooseTarget_Blaze and ChooseTarget_MegaMagic scale the caller's BC through Multiply8By16, not their estimate (a likely game bug, C1); the Transform slot-7 name write; DrawSlotHPMPStats digit counts and the name-suffix bit; the debug automap's entrance kinds 4 and 5 were swapped; SaveScreen_OpenGiftMenu opens the gift menu, not the save menu; several notes that covered only one of a step's table entries.
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0371.
- **Checks.** build/run614 PASS (approved size and SHA-256, zero differing bytes), no stale name; full parallel suite build/logs/par613.log OK (392 tests, 4 skipped), the final check since three agreements with the serial suite (D-011). Queue: instruction-named 655 to 130, over 60 characters 108 to 57.
- **Limits.** Static readings; 10% of each draft checked.

### E-0370 — Readability batch 2: 553 instruction-named routines in banks $0F-$31 named from readings

- Date: 2026-10-14. Kind: PRESENTATION and REVIEW (static readings, C1). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 3301a4c38127862316d807b51e43158db9f20813.
- **Method.** As E-0369: six read-only workers drafted 534 labels (slices of 80-118, banks $0F-$31); every entry validated; the integrator read 55 of them (10% of each draft, at least five) against the code, all correct, so no draft was rejected (rejection 0%, the second batch below 5%: the next slices grow by half to 120). A further worker named the ten code labels whose derived names changed with their parents.
- **Integrator changes.** The equipment table at 16:4A98 was split between two workers, who named its steps differently. Its caller EquipItemOnRecordTargetRecord puts the monster's old item back in wInventory and then calls the table with that item, and its steps lower the stats an item gave, so the whole table is renamed for that: RemoveEquipmentBonusKeepA (was ApplyEquipmentEffectKeepA), RemoveEquipmentBonus (was ApplyEquipmentEffectKeepA_ByItem) and its steps RemoveEquipmentBonus_VITbelt ... RemoveEquipmentBonus_Wise, _DScale, _Capes, _NoneItems, _LevelUpItems and _LastItem.
- **Earlier readings corrected** (in the labels' new notes): SubtractAFromRecordWordFloor1 and its pair make only a negative result 1 (an exact 0 stays 0) and skip a word at 999; the BattleEnd_Step1 species suffix appends $33 $34 ('pq'), never shown; the third-intro-message choice and the AI side-HP comparison (only the party's HP is saved); exits that the notes called the link menu go to the title menu (GameMode5_Init_TitleMenu); the vault store/count cases were reversed; wLinkRules + 9 bit 7 (the prize rule), not the turn limit, picks the box; ScaleWordBy6Or12Capped10000's BC is the cap, and its 101% path pops a word it never pushed (a latent stack imbalance above 64,887); LoadTileListSixPerFrame and SetupTileMapAtBGMap1 save tiles to $9E00/$9C00 (their names are a further question); Norden talk numbers 160 and 161; several "E-0248" script lines printed one label early.
- **New observations** (C1, open questions): cape items raise battler resistances when a battle loads; War to Cleric give level-up bonuses; no reader of the Life and Divine values was found; the name packer can write past its five-byte field; a personality roll can return carry on the wrong side (30:4FC8).
- **Open questions** are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0370.
- **Tools.** tools/probe.py runs routine probes on tools/sm83.py (start registers, flags, RAM and SRAM; expected values after the routine returns) and tools/probe_scope.py sorts code labels by whether a register-and-RAM probe can observe them (D-012); tests/test_probes.py tests the runner (a true claim passes, a false one, wrong memory or flags fail, a routine that does not return fails) and runs config/probes/*.json once probes exist. tools/present.py counts E-0370 notes as hand readings.
- **Checks.** build/run610 PASS; serial suite build/logs/suite610.log; parallel build/logs/par610b.log. Queue: instruction-named 1,182 to 655, over 60 characters 172 to 108. Renaming one numbered sibling renumbers the rest (`_Arg12` became `_Arg1`), so the batch named such clusters whole (seven more labels) and settled after three regenerations. The equipment cases are named by config/indexed_dispatch.json, whose family name is now RemoveEquipmentBonus; tests/test_constants.py and the D-011 count floors of tests/test_name_claims.py (1000) and tests/test_step_names.py (50) follow.
- **Limits.** Static readings; 10% of each draft checked by the integrator.

### E-0369 — Readability batch 1: 547 instruction-named routines in banks $00-$0F named from readings

- Date: 2026-10-14. Kind: PRESENTATION and REVIEW (static readings, C1). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Base commit 4f14a4374106e515aa4085c62525962f0106b8e2.
- **Method.** tools/readability_queue.py cut the first 529 instruction-named labels (banks $00-$0F, in source order, a routine kept with its steps) into six slices. Six read-only workers each read every routine whole, its callers in all banks and the tables it reads, and drafted a name, a note where none was a hand reading or the old one was wrong, a confidence and the evidence read (D-011). tools/apply_drafts.py validated every entry; the integrator read 10% of each draft (at least five entries) against the code: 54 entries, all correct, so no draft was rejected. The regeneration renamed 18 more code labels by derivation (the steps of renamed parents); a seventh worker named them in the same batch and its five sampled entries were correct.
- **Integrator changes.** Five drafted names were not applied: four second copies of a per-bank helper family in one bank (`CopyBytesWithChecksum_Bank02_2`, `SetMenuRowsForPage_Bank03_2`, `ReadSlotAIModeIndexed_Bank05_2`, `SlotResistances5EntryHasBits2And3_Bank05_2`) and the family name `AddTemp0WordToHL`: a family keeps its name (config/name_families.json), and tools/readability_queue.py now counts family names as given. `ArenaMenu_PickPrize_Give6000Gold` became ArenaMenu_PickPrize_GiveGold (digits in a name read as an address to tools/readability.py). One new note was corrected from the seventh worker's reading: RunLinkSession4ScreenState_PrepareSetupMenu_Run clears 256 bytes from wScreenState (`ld bc, $006F` leaves B = 0, and the loop counts B), not $6F.
- **Earlier readings corrected** (each in its label's new note; the draft's open question gives the detail): AIScore_Transform's check counts the stats where a foe is lower than the actor (CompareHLToBC sets carry for HL < BC), not higher; the AIAddScoresForTwoLists checks, the Ramming, Berserker, Kamikaze, MPass and Sacrifice conditions had inverted or missing tests; StartFourSoundTracks (was StartMusic_StartSound) starts four sound ids; the link clock side in RunLinkSession4ScreenState_CheckLinkMessage is the driving side; refused link battles go to wTitleScreenState 2 ('Refused the VS battle.'); the arena's level-5 branch is unreachable (`cp $00` never sets carry); the medal-prize removal count wraps in 8 bits; several stat orders, counts and table names. A note of the DebugResultsDisplay child test reads a field at $75C5 with bank $15 mapped, so it tests NpcBreedMenu data, not its own table (an open question).
- **Game mode 7** is named LinkBattle (RunGameModeInit_LinkBattle): the link session 6 fight-info step, whose note calls it the Team Mode battle, and the hatching scene set it, and GameMode7_Update exchanges the joypad and runs the battle effect animation. C1; E-0029 had found its use unknown by forcing the mode.
- **Open questions.** 256 questions the readers left are in [READABILITY_OPEN_QUESTIONS.md](READABILITY_OPEN_QUESTIONS.md) under E-0369 (possible dead code, an `ret` that would jump into WRAM for sprite slot type 1, a SuckAir check that tests slot $FF, unread callers).
- **Tools.** tools/present.py retries a source write that Windows refuses for a moment (OSError 22 twice during regeneration, from a process holding the file); the text written is the same. tests/test_generated_source.py's call-count check counts every call operand in one pass instead of one regex per name over the whole listing (448 s to 0.2 s; the same counts on a 150-name sample). tests/test_step_names.py's callee-named floor (5) follows D-011.
- **Checks.** build/run606 PASS (approved size and SHA-256, zero differing bytes); no stale name; parallel suite build/logs/par606.log OK; serial suite build/logs/suite606.log. Queue: instruction-named 1,751 to 1,182, over 60 characters 209 to 172.
- **Limits.** Static readings; the integrator's spot checks cover 10% of each draft.

### E-0368 — Instruction-listing names finished; tools for the readability batches

- Date: 2026-10-14. Kind: PRESENTATION (names from the E-0357 notes, C1 like the notes) and TOOLING. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
- **Names.** An uncommitted continuation of E-0367 was found in the main checkout (same base commit b06d5bb) and finished here: 588 routines that the RAM-touch rule had named after the RAM they write or read (`StepFade_WriteSoundFadeTargetAndNR50Etc`, 271 of them ending in `Etc`) are named from their E-0357 notes (`StepMusicVolumeFade`, `WarpEffect_GrowWave`, `DrawSaveCompletionMark`). Their config/names.json evidence reads "E-0367 (named from its E-0357 note; was ...)" because they were written as part of that pass; they are committed under this entry. Three labels that still repeated an old step name are renamed here: the dispatcher TeamMode_Screen_Leave (33:556F, "session 6, screen state 2 (leaving)" in its note) and two table labels in config/tables.json, SceneDarckDefeated_ObjectPath and ShopMenu_Buy_ListTileDests. One `Etc` name is left (GiftEffect_BookmarkEtc).
- **Regenerated source checked against the main checkout.** Applying the main checkout's config/ diff here and regenerating gave src/ files byte-identical to the main checkout's uncommitted src/ (54 files compared), so the round was finished from its configuration, not copied output.
- **Tools.** tools/run_tests.py runs each test file in its own `python -I -m unittest discover -s tests -p <file> -v` process in parallel and compares two -v logs test by test (tests/test_run_tests.py, including a changed outcome, a missing test and an unparsed line). tools/readability_queue.py recomputes the readability work queue from src/ (instruction-named, long, unread, reader-only data, unidentified assets) and cuts it into slices that keep a routine with its steps. tools/label_map.py snapshots every listing label by address, maps old to new names after a regeneration and rewrites citations in config/ and tests/ (keeping those after "was", "from", "renamed from"). tools/apply_drafts.py validates reading drafts (label at the address, CamelCase, at most 50 characters, no mechanical parts, unique, notes that cite only existing names, ASCII, confidence, evidence) and writes accepted ones into config/ without reformatting config/names.json. tests/test_label_map.py and tests/test_apply_drafts.py cover them, with negative cases.
- **Hand-note evidence list.** tools/present.py now holds the list of evidence ids that mark a hand-written whole-routine reading (E-0357 to E-0362, and E-0369 for the first batch), and tools/doc_coverage.py uses the same list. No annotation cites E-0369 yet, so the regenerated source is unchanged by this.
- **Tests.** tests/test_step_names.py's floor of 150 generated step names (a check that the pass is not vacuous) became 1: the batches from E-0369 replace those names by design (D-011). tests/test_doc_coverage.py gains a ratchet that is stricter in the direction of the goal: at most 1,751 instruction-named labels, 209 labels over 60 characters and one `Etc` name, lowered as batches land.
- **Checks.** build/run604 PASS (approved size and SHA-256, zero differing bytes). Full serial suite: build/logs/suite604.log; parallel run of the same tree: build/logs/par604.log, compared test by test with tools/run_tests.py --compare.
- **Limits.** The 588 names are only as good as their E-0357 notes (static readings, C1).

### E-0367 — State handlers named for what they do

- Date: 2026-10-14. Kind: PRESENTATION (names from the E-0357 notes, C1 like the notes). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
- **Question.** 1,314 entries of `jumptable` dispatches (the steps of menus, scenes, battle phases and link sessions) were named `Parent_<first callee>` by the step-naming pass (E-0293/E-0356): `KeyAppraisalMenu_CopyBytesDEToHL_Bank0D` for state 0 of the key appraisal, `RunBattleSetup_PlanMenu_FillScreenTileBufferRow11Col4WithC3_Bank31` for the PLAN menu's action step. The name described an incidental call, not the step. Each of these routines now has a hand note (E-0357), so each can be named for what that note says it does.
- **Change.** They are named from their notes, in the pokered manner of `Parent_ShortPurpose` (`KeyAppraisalMenu_Init`, `ArenaMenu_PayEntryFee`, `RunBattleSetup_PlanMenu_ChooseAction`, `BattleEnd_AskToJoin_CheckFarmRoom`); each renaming let the step-naming pass re-derive the names of sibling steps (`_2`, `_3` copies of the same callee name), so the pass was repeated until no jumptable entry with a hand note was named after a callee; 16 entries without a hand note keep their names. Where a group of steps had a dispatcher named after one of its own steps or an instruction, the dispatcher is renamed with them (49 of them: `RunGameMode5Case01SubStates` is TitleMenu, `RunLinkSession4ScreenState_EditRules` LinkRulesEditor, `GameMode6_Update_SavePrompt` GameMode6_Update_TakePrize, `PauseMenu_Info_Blocks00To03` PauseMenu_Info_Page1, `SwapMonstersMenu_ChooseToView` SwapMonstersMenu_Check, `RunBattleEndStep4SubSteps` ForgetSkillMenu, the field-skill tables FieldSkillUsable and FieldSkillEffect, and so on). `EggServiceMenu_Bank1B` (1B:665E), which E-0363 found to run the link battle set-up and not the egg service, is LinkBattleSetupMenu with its steps. In all 1,878 labels are renamed (1,841 new config/names.json entries and 37 existing ones). Each name goes into config/names.json with evidence "E-0367 (named from its E-0357 note; was <old name>)", or, for an entry that already had one, a "renamed from" clause in its note. Labels derived from these names (their own local steps and tables) follow on regeneration; notes, tables and the other configs that cited an old name were updated by mapping each bank file's labels in order before and after (a label that only moved keeps its meaning), never after 'was' or 'from'. Message-derived step names (`GreatLogTalkEvents_ShowYoDidYouEnjoy`) were left as they are; the few instruction-derived ones met on the way (`SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_10`, `..._SetMapId_7`) were named from their notes too.
- **Correction found on the way.** The note of 07:6C32 (the link set-up's first step) said it "saves the game"; it calls RunLoadGameSteps (E-0366), so it loads the save; the note is corrected.
- **Checks.** build/run602 PASS (approved size and SHA-256, zero differing bytes). tools/doc_coverage.py: no stale name; no Func_/Data_ address name left (13 labels whose derived names the renamed dispatchers no longer produced were named from their notes, and two tables MonsterIconBlockPointers and MonsterIconBlocks replace a step-derived data name); tests/test_doc_coverage.py's new check finds at most 16 callee-named jumptable entries and the KeyAppraisalMenu table as Init, DrawGoldBox, ...; tests/test_play_chain.py and tests/test_generated_source.py follow the renames; full suite: build/logs/suite602.log. tests/test_step_names.py now expects at least 150 generated step names and 5 call-backed ones (the pass names far fewer since E-0367).
- **Limits.** The names are only as good as the notes they come from (C1, static readings). A name says what a step does, not every case; the note above each label stays the full account.

### E-0366 — The load-game steps were named as saves; the last restatements read

- Date: 2026-10-14. Kind: REVIEW of E-0109 / E-0121 against the instructions (the copy direction is a byte fact, C2; the game meaning C1). Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
- **Finding.** CopySaveBlocksToSRAM (02:72B0) walks its (address, length) list with DE = sSaveData and HL = the block's WRAM address and copies `ld a, [de]` / `ld [hli], a`: from SRAM into WRAM. E-0109 read it the other way. Every other routine RunSaveSteps (02:717D) calls on its first pass restores too (SRAM bank 2 from bank 3, the records from their bank-1 backup, the game-mode-2 timer block from SRAM), and its later passes unpack one saved record each. Its callers are the title screen's Continue and returning-to-title steps, the debug menu and the link sessions, which E-0357 notes already described as "loads the save". The save itself is CopySaveBlocksToSRAMWithSum (02:7598: WRAM to SRAM with a byte sum, then signature $55 and the sum + $9753 as checksum), reached from RunSaveGameSteps.
- **Change.** RunSaveSteps is RunLoadGameSteps, CopySaveBlocksToSRAM is LoadSaveBlocksFromSRAM, ScanBank1RecordStepSaveRecordIndex is UnpackNextSavedRecord; its two unnamed steps are RestoreSRAMBank2FromBank3 (02:7247) and LoadGM2TimerBlockFromSRAM (02:72E9); RunLinkSession4ScreenState_SaveAndSync (07:6C28) is RunLinkSession4ScreenState_LoadAndSync. wSaveStep's note names both step routines. The bank-$1B link note that said option 7 "saves first" now says it reloads the save; SoundTick's E-0018 annotation is folded into its full reading. Step labels derived from the old names follow on regeneration.
- **Last restatements.** The 105 routines still described only by an E-0347 restatement now have E-0357 notes: 95 bank-$E2 AI scorers (each: the gate it needs, then which weight rows go to wAISkillScore or wAISkillScore2 when which check returns C = 0, and the shared tail it continues in), the sound engine's frame step, the load and save block copies, the BCD unpacker (seven digits: hTemp3 is one), a picture-and-palette loader, the parent-name drawer, a tile-rectangle copier, the battle status marks, ActorLosesSixthOfMaxHP (no floor) and RunMessageBox. The 23 E-0365 scorer notes use the same wording.
- **Checks.** build/run580 PASS (approved size and SHA-256, zero differing bytes). tools/doc_coverage.py: 5,246 code labels with a hand note, none described only by a restatement, no stale name. tests/test_doc_coverage.py (restatement ratchet 0, floor 5,246) and tests/test_play_chain.py pass; full suite: build/logs/suite580.log.
- **Limits.** Static reading; the load path was not stepped in an emulator for this entry.

### E-0365 — Gap notes answered by whole-routine readings; repeated-name action ids

- Date: 2026-10-14. Kind: OBSERVATION (whole-routine readings, C1) and PRESENTATION. Target `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`; starting revision de554e9.
- **Question.** 406 routines kept an older note that admits a gap ("the body is not interpreted", "the selection rule is not interpreted", "not read ..."), so tools/present.py appended a generated "; code:" restatement under them and tools/doc_coverage.py counted them as restated. Can each be read whole, and can the stale gap clauses go?
- **Readings (E-0357 notes, 553 added).** Bank $39's 99 AI target choosers (ChooseTarget_*); bank $36's 127 action effects (ActionEffect_*, the resolve steps and RollRandomLoBelowChance); bank $E2's 23 AI scorers; 21 talk handlers in bank $13 and 16 in bank $04; bank $16's 101 item checks; bank $73's last 157 scene steps; 9 routines in banks $3A, $E0 and $A0. Findings worth keeping in mind (each C1, from the instructions):
  - Resolve messages (wResolveMsgActor/Target) are battle text indexes (bank $2F, table $4016, category 1; ResolveStepDamageMessage passes them to ShowBattleText), so the notes quote them ('<name> was instantly slain!', 'The <name> shattered!', ...).
  - Several AI target choosers read another skill's resistance field: ChooseTarget_Slow reads Sap's (byte 3 bits 4-5), ChooseTarget_UltraDown Beat's (byte 2 bits 4-5).
  - Apparent slips, kept as read: ChooseTarget_MetalCut starts its best sum at $FFFF and skips sums below it, so it never picks and falls back to the last present foe; ChooseTarget_Ramming's first pass never picks (hTemp4 stays $FF; `and $05` after `and $20` is always 0) and its third pass tests a carry no compare set; ChooseTarget_Beat's no-candidate pass stores C after C was overwritten; ChooseTarget_SquallHit_3 never increases its count and passes the count as the slot. Talk/scene slips: 73:6729 compares an address byte, not the record's Y.
  - Bank $E2's scorers add rows of the personality weight table (06:$4001, rows of 27 words) to wAISkillScore or wAISkillScore2, each when its check returns C = 0.
- **Presentation.**
  - tools/present.py adds the "; code:" restatement to a gap note only when no hand note (E-0357 to E-0362) sits in the same comment; tools/doc_coverage.py no longer counts such a routine as an unanswered gap.
  - config/names.json: in the 380 notes of hand-read routines, the clauses "the body is not interpreted" (also "... beyond the Herb case"), "the individual checks are not interpreted", "the selection rule is not interpreted" and "the branching is not interpreted" are dropped (their evidence ids stay); 16 older notes that were partial readings of the same routines ("(not read)", "the rest is not read", ...) are retired in favour of the full readings.
  - tools/gb_constants.py: ids from 175 ($AF) on whose string only repeats an earlier skill's name are battle actions, not skills, and are now ACTION_<hex> (the 33 SKILL_HIGHJUMP_AF ... SKILL_LOVERAIN_CF constants); their comment says which name the string repeats and which routines handle them.
  - Renames: AccumulateBank6WordToDA6E / DA70 (E2:64CE / E2:64F5) are AddAIWeight / AddAIWeightToScore2 (BC = weight row); UnreferencedStoreResolveMessage35D0_Bank36 (36:7C85), which bank $36's effect routines jump to 65 times, is StoreHitMessage_Bank36. Bank $3B's copy keeps its name: nothing there calls it.
- **Checks.** build/run578 PASS (approved size and SHA-256, zero differing bytes). tools/doc_coverage.py: 5,141 code labels with a hand note, 105 described only by a restatement, no unanswered gap note, no stale name. tests/test_doc_coverage.py (ratchet 105, floor 5,141, a new check that no hand-read routine keeps a restatement; the older gap check exempts hand-read routines) and tests/test_constants.py (ACTION_B2, ACTION_CF) pass; full suite: build/logs/suite578.log.
- **Limits.** The readings are static; slips are what the instructions do, not confirmed in play. The weight rows' per-personality values and what each check tests in game terms are not restated in the notes.

### E-0364 — Message tables, item constants and names corrected from reading

- Date: 2026-10-14. Kind: REVIEW and PRESENTATION fixes found while writing E-0357 notes (C1 for game meaning; the table reads are byte facts).
- **Traveler events (bank $73).** TravelerEvents (73:4001, was GreatLogFieldEvents) and its 13 scenes wait with RunMessageBox_Bank73, whose step 1 (73:4F3C) shows wMessageIndex as a string of **category 5 of bank $09's table**. tools/disasm_all.py quoted their message words from ShowMessageHL's bank $28 table instead, and E-0293 named the scenes from those quotes ('Go help your mother', 'Papa's calling', ...). The real lines show a healer, two merchants, a paid healer, three masters to battle, the high-low card game, a map seller, a medicine master, the casino ship's slot machine, a healer to battle and a thief. `message_text` now quotes code in 73:4001-73:51D7 from bank $09 category 5 (EVENT_MESSAGE_RANGES); the 14 names, SCRIPT_TRAVELER_EVENT, Talk_TravelerEvent and the casino reel tables (CasinoReel1-3Symbols) follow. tests/test_generated_source.py checks a casino line and the absence of the old quote.
- **Item numbers in bank $3B.** RunBattleActions_UseItem copies wBattleItemId into wBattleActionId, so bank $3B's compares of wBattleActionId are item numbers: `cp SKILL_HEALUS` was ITEM_BEEFJERKY, `cp SKILL_FIREBANE` ITEM_ELFWATER. ID_VARS_BY_BANK names them as items in that bank (13 operands).
- **KeyWorldNextRoomRows (84:$42C7).** E-0193's KeyWorldMonsterBaseRows is read only by 84:41F2, which stores the sum as the next room's record in wKeyWorldRoomTable, one row per exit: room bases, not monster bases.
- **Battle menus (bank $31).** RunBattleSetup_FleeCommand is the main menu (FIGHT, PLAN, ITEM, RUN; its RUN choice includes the flee strings E-0288 named it from) and is now RunBattleSetup_MainMenu; RunBattleSetup_CommandMenu is the PLAN menu (tactics Charge, Mixed, Defense, Command) and RunBattleSetup_ItemCommand the ITEM menu.
- **Checks.** build/run576 PASS; tests/test_doc_coverage.py, tests/test_generated_source.py and tests/test_play_chain.py (which names RunBattleSetup_PlanMenu in a recorded run) pass.

### E-0363 — Dispatcher twins that share only their dispatch

- Date: 2026-10-14. Kind: REVIEW of E-0107 against an instruction diff (C2 for the differences, which are byte facts; behaviour C1).
- **Question.** E-0107 called RunBattleCommandEntry_BankA1 (A1:413F), RunBattleSetup_BankA0 (A0:5E07) and EggServiceMenu_Bank1B (1B:665E) "the same instruction sequence" as their bank $30, $31 and $0D twins. Its limits already said the dispatchers' case code is each copy's own, but the generated source comments dropped that limit, and the A1 notes read as a full copy.
- **Method.** Each routine and its steps (labels that extend its name) were compared with every label operand replaced by one placeholder (a throwaway script; the nine E-0107 twins were all checked).
- **Result.**
  - Six twins match exactly (UpdateMenuCursor_BankF1 apart from a trailing data run, ShowSelectedItemDescription_BankF1, HPBandOfSlotTemp0_2, DrawPageOfPagesAtScrollOffset_BankF0, RollChanceByLevel_100_100_75_0_Bank3B, DrawMetaSpriteAt_2).
  - RunBattleCommandEntry_BankA1 has the same seven steps, but step 0 marks the enemy slots 4-7 instead of choosing wCommandEntryMonster, the second random stream always advances, step 3 far-calls ChooseActionTarget, step 4 lists no item entry, and the skill speed bonus is $07D0 (2,000) where bank $30 has $03E8 (1,000).
  - RunBattleSetup_BankA0 (13 steps) and EggServiceMenu_Bank1B (16 steps) match only in the dispatch; EggServiceMenu_Bank1B's steps run a link exchange (a message, waiting for the partner, picking records, starting the link battle), not the egg service, so its name describes the twin rather than itself.
- **Change.** The three config/names.json notes now say what matches and what does not, citing this entry. No byte changes; build/run573 PASS.
- **Open.** EggServiceMenu_Bank1B keeps its name until its steps are named; a later rename should follow them.

### E-0362 — Sprite override selection, rendering and map-link warps

- Date: 2026-10-14. Kind: OBSERVATION / whole-routine READING. Confidence: **C1**. Author/reviewer: lead agent, self-review. Direct original-ROM execution uses tools/sm83.py, unvalidated against hardware. No natural full-scene/map-load playthrough, timing or statistical selection guarantee is claimed.
- **Target:** `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`, 4,194,304 bytes. Starting revision `21a2e68ffa6f15be4a456e9138a5361b3977e603` plus the inherited dirty E-0361 tree. Baseline `build/run569/report.json`: PASS, approved size/hash and zero differences. Final integrated gate: pending regeneration and checks.
- **Question/predictions:** which slot bytes supply the override and is the word a stream pointer; does selection reject inactive slots or every kind-$5E combination; does the countdown dispatch at zero or signed underflow; is the pose helper fade-only; does a missing map record start a transition? Competing readings are tested with distinct bytes 0/1/2/3, an inactive eligible slot, exact (1,$5E,0) versus kind $81, timer 1/0/$8000, all normal pose boundaries and a table miss.
- **Locations:** core bank $12 CPU [$4FEA,$51F4), file [0x48FEA,0x491F4), sixteen code entries plus MapExitWarpTable data CPU [$5130,$5181), file [0x49130,0x49181), sixteen five-byte records and $FF. Shared lift CPU [$557C,$55E8), file [0x4957C,0x495E8); flash helper CPU [$653F,$65A4), file [0x4A53F,0x4A5A4). Bank $04 graphics helper CPU [$431F,$43AC), file [0x1031F,0x103AC); player loader CPU [$4B2D,$4B7E), file [0x10B2D,0x10B7E); renderer CPU [$4C96,$4D43), file [0x10C96,0x10D43); pose helper CPU [$4E0F,$4E73), file [0x10E0F,0x10E73); pose data CPU [$4E73,$4EAA), file [0x10E73,0x10EAA), nine six-byte records and $FF. Bank $0A timer CPU [$5748,$5773), file [0x29748,0x29773). Bank $00 RNG CPU/file [$09F3,$0A17). Byte phase/coordinates/kind/flags; little-endian graphics id, timer, scroll words and pointers. Bank numbers are hexadecimal, offsets zero-based and ranges half-open.
- **Callers/state:** bank-$10 wrappers ScriptCommandA0/A1/8E at CPU [$496A,$497F), file [0x4096A,0x4097F), far-call the stage dispatcher once per script update. Talk_PlayerSpriteFlash/Message/MapLinkWarp in bank $04 start the corresponding command-plus-$FF scripts in bank $10. The timer is called by the bank-$02 player movement tail. The renderer is shared by all three player-sprite modes; its pose helper also serves the follower renderers. Graphics loader uses HRAM scratch and slot-0 object palette; sprite kind/id/timer live in HRAM $FF93-$FF97 across the flash and restore scripts.
- **Deliverable:** 24 whole-routine notes (22 additional hand readings; renderer and countdown replace earlier E-0357 notes), sixteen renamed code stages/helpers, two corrected HRAM graphics-id names and five RAM notes. Name and structure SpecialSpritePoseRegions, and correct the map-link table header. [SPRITE_WARP_COMMANDS.md](SPRITE_WARP_COMMANDS.md) explains the sequences, banked tables, arithmetic and return conditions. No canonical bytes change.
- **Selection/loading:** NextRandomSeed becomes (5*seed+11) modulo 65536, preserving BC/HL. Sample updated high & 7; require index<count and X<$A0/Y<$90, with no slot-state filter or retry bound. HL is at byte 12 after the non-incrementing Y read; subtract $0B reaches byte 1. Copy kind at byte 1 and id at bytes 2/3, rejecting only exact (1,$5E,0). Timer=100, phase=0, facing=0. Four three-call turns follow; load at phase 0 of the second turn, set override bit 7 and request palettes. The id selects a graphics table; it is not the decompression pointer. Slot 0 receives the palette. Restore clears override, loads default field id 0/1 from story flag 0, preserves id/timer and requests the next opcode.
- **Palette/timer:** flash uses incoming phase bit 2 for four-call inverse/normal groups, with exact updated phase 30 resetting and advancing. CGB only complements the saved background bytes, while DMG changes all three DMG palette bytes. The override countdown returns unless bit 7 is on and no script runs; decrement modulo 65536 and dispatch group $0A/index 0 only when updated high bit 7 is set. From 100 the 100th eligible call reaches zero; the 101st reaches $FFFF and dispatches. No claim is made that every field frame is an eligible call.
- **Rendering/corrections:** old E-0127/E-0132 stream-pointer wording is superseded by table-id meaning in names/notes. The earlier E-0357 minus-scroll wording is replaced by exact stored-scroll addition; initial player byte-bias carry is discarded, scroll-add carry propagates, mode 2 subtracts eight from Y. The old E-0175 fade-only pose name was incomplete: with no fade, nine map/screen/X/inclusive-Y regions can return A=1. Preserve those older claims in the historical log; new notes/data carry E-0362. Renderer probe stops on entry to its draw callee and checks routing/input, not complete OAM output.
- **Map link:** shared lift subtracts four except at exact Y=$E0, followers start at phase 8/16/24, exact updated 90 advances and clears flags 3/6. Normal destination lookup writes the matched new map before choosing record destination or saved goal; miss leaves transition unchanged despite fetch request. Key-world selection distinguishes active key bit 7/slot match from direct goal bytes. Packed position becomes multiples of 16 and screen nibbles 0-15. Transition step $80/kind 1, fade 4, field-init increment, mode 4, flags clear 3/7 and set 5; preserve warp facing/phase/script stage.
- **Reproduction:** `python -I -m unittest discover -s tests -p test_sprite_warp_commands.py -v`: seventeen probes pass (`build/logs/e0362-probes-complete.log`). Original-ROM direct calls disable interrupts and use WRAM bank 1. Explicit synthetic slot/VRAM/HRAM fixtures cover both graphics kinds and high-byte monster id, CGB/DMG palettes, low-ID $50 bank boundary via field id $5E, palette-slot byte wrap, exact phase/wrap, timer signs/gates, all sixteen map records, map miss, saved/direct goal branches, all nine pose-region inclusive boundaries and render-prefix routing. The renderer stops at its original draw callee without stubbing it. An initial fixture import did not filter a nameless metadata dictionary in symbols.json; that import failure is retained in e0362-probes.log, and the corrected lookup passes. The authoring helper's first name-collision check likewise needed to skip metadata; its later write completed.
- **Review/limits:** instructions and caller/record widths checked against candidate names; no stream-pointer assumption, uniform RNG assumption, threshold clamp or untested full-scene completion is substituted. IDs/counts/stages are unchecked; zero eligible slots can loop indefinitely and invalid fields can index outside tables. Hardware/rendering timing, natural map initialization and invalid-destination safety remain unverified. Next: MapExitWarp at $12:$51F4, its destination table and adjoining ReturnWarp stages.

### E-0361 — Follower command coordinates and completion

- Date: 2026-10-14. Kind: OBSERVATION / whole-routine READING. Confidence: **C1**. Author/reviewer: lead agent, self-review. The dynamic evidence is limited to tools/sm83.py, unvalidated against hardware; no complete map-warp or story-event playthrough is claimed.
- **Target:** `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`, 4,194,304 bytes. Starting revision `21a2e68ffa6f15be4a456e9138a5361b3977e603` plus the inherited dirty E-0360 tree. Baseline `build/run566/report.json`: PASS, approved length/hash, zero differences. Final integrated `build/run568/report.json`: PASS, same approved length/hash and zero differences; companion `review.json` ties the report to the exact dirty tree, revision, input/output and tool hashes.
- **Question/predictions:** do the walk stages finish at a crossed threshold or exact updated Y; are targets captured from upstream positions or upstream targets; does the finish wait require all coordinates; do warp gates use incoming or already-updated Ys? Alternatives are distinguished by the intermediate-boundary, X-mismatch, overshoot and $DF/$E0 gate probes.
- **Locations:** bank $12 CPU [$4E4B,$4FEA), file [0x48E4B,0x48FEA): five complete dispatcher tables and ten stage routines. Related helper CPU [$65FF,$6610), file [0x4A5FF,0x4A610). Bank $02 helpers CPU [$5923,$59CD), file [0x9923,0x99CD): target capture and stepping. Eight-bit positions/counters/requests; five-byte records; vertical delta and dispatcher pointers are little-endian words. Fixed WRAM records $C8EF-$C8FD inclusive; HRAM coordinates/flags are named in src/ram.asm. Bank numbers are hexadecimal, offsets zero-based and ranges half-open.
- **Method/deliverable:** read all 15 core entries, their callers, all five complete stage tables and the three follower helpers; inspect the called movement/action/fade interfaces. Add 18 whole-routine annotations and 10 new explicit stage names. Root command names and helper names stay stable. [FOLLOWER_COMMANDS.md](FOLLOWER_COMMANDS.md) explains the stages, byte arithmetic, targets and banked calls.
- **Walk and finish contracts:** each ordinary walk calls follower stepping at the old player Y and again at old Y+1, then ends at old Y+2 modulo 256. Only equality at $20/$50/$60/$80 advances; odd input Y cannot hit these even thresholds without another writer. The finish wait steps twice and checks only Y at offset 2 + ((party count - 1)*5 modulo 256). For valid counts 1-3 this is the last follower. It clears animation-freeze bit 1 and requests fetching the next script command with $80 on equality, regardless of X or other follower Ys. Count 0 is unchecked and underflows beyond the array.
- **Request correction:** FetchScriptCommand at $10:$4008 tests and clears request bit 7, then fetches the next opcode. A normal opcode starts another command; only $FF ends the script. Reject the initial reading that the follower finish request $80 itself stops the whole script. The new contrasting normal/$FF consumer probe confirms this distinction. A proposed extension to the earlier link finish was rejected on reading its body: it clears wScriptRunning directly and does not write this request. Its E-0360 annotation is retained.
- **Callers/state:** bank-$10 ScriptCommand90-94 wrappers at CPU [$4924,$4947), file [0x40924,0x40947), far-call these bank-$12 commands once per script update and return. The current command uses the shared byte wScriptStep; stages return to the wrapper rather than forming nested scripts. Registers/flags are working outputs, not preserved interfaces; completion is recorded in RAM. The follower targets survive until another capture, while the action request is maintained by the bank-$02 action stages.
- **Follower helpers:** capture current positions as targets for all three records, then move X before Y, with unsigned comparisons, one pixel or four when action bit 7 is set. Four-pixel movement may overshoot and wrap. All three records are processed even with party count 1. Nonzero delay prevents movement but is not decremented. This completes the Y/direction reading left partial in E-0093; that earlier limitation is retained in its historical entry.
- **Transitions:** entry fade publishes map 1 screen (1,0), destination (player X,$F0), kind 0 and invokes the bank-$5F fade/step helper. Stagger stage reads downstream first, gating each follower's +2 on its incoming upstream Y being unsigned below $E0, while always adding two to player Y and advancing only at $50. Next-screen setup sets action $80/direction 8, increments map-screen Y, preserves horizontal delta and other state bits, and writes vertical delta $FF80. The following stage calls movement/action and waits only for action bit 7 to clear. Bank-$02/$5F far calls restore bank $12.
- **Reproduction/probes:** `python -I -m unittest discover -s tests -p test_follower_commands.py -v`: ten tests pass, log `build/logs/e0361-probes.log`. Original-ROM direct calls use interrupts disabled, WRAM bank 1 and explicit RAM fixtures derived from src/ram.asm. Contrasting inputs cover exact/crossed thresholds, wrap, intermediate boundary capture, party counts 1-3, X/other-Y mismatch, delay, X priority, unsigned stagger gates and four-pixel overshoot. The next-screen setup probe stops at entry to the first movement callee and checks input only; it does not stub or certify map loading. Fade parameters and action wait are separately exercised through their real callees.
- **Acceptance:** full regeneration passes (`build/logs/e0361-generation-accepted.log`), 54 scoped source/probe checks pass (`build/logs/e0361-checks-accepted.log`), documentation links and `git diff --check` pass. Coverage is 1,507 hand-written whole-routine notes and 3,639 generated restatements remaining. The initial generation collision arose from giving a family-named helper an explicit name; remove that duplicate while retaining its annotation, then regenerate. Failed log `build/logs/e0361-generation.log` is retained. A local helper used the Windows default encoding when rewriting two documents and names.json; repair the UTF-8 punctuation, then fully regenerate and rerun the checks/build. The final log includes both those repairs and the fetch-request correction; earlier successful builds do not certify this final combined tree.
- **Review/limits:** all names compared against stores and dispatch order. Preserve equality, record ordering, unknown natural entry state and unchecked invalid indexes. No code/data layout or gameplay behavior changed. The full gameplay suite and hardware timing are not newly validated. Next: PlayerSpriteFlash at $12:$4FEA, PlayerSpriteMessage and adjacent map-link warp with sprite override and map-return consumers.

### E-0360 — Link and breeding presentation stages

- Date: 2026-10-14. Kind: OBSERVATION / whole-routine READING. Confidence: **C1**. Author/reviewer: lead agent, self-review. Dynamic observations are of tools/sm83.py; no independent hardware validation, full link session or new complete breeding playthrough.
- **Target:** `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Starting revision `21a2e68ffa6f15be4a456e9138a5361b3977e603` plus the inherited dirty E-0357–E-0359 tree. Baseline clean `build/run564/report.json`: PASS, 4,194,304 bytes, approved hash, zero differences. Final gate: `build/run565/report.json`, PASS, same size/hash and zero differences; companion `review.json` records the exact tree, revision, tools and checks.
- **Question/predictions:** do these commands share a presentation sequence while retaining distinct return contracts; does the zero-plus early return omit the clipping save; which field-record byte is returned by the two graphics readers? Alternatives: all message branches save/restore the same clipping value, each frame moves the monsters, and the field loader returns byte 3 as E-0238 claimed. The instructions and contrasting probes distinguish these cases.
- **Locations:** bank $12 CPU [$4919,$4E4B), file [0x48919,0x48E4B): 32 code entries, including five complete dispatch tables and the snapshot helper; separate data CPU [$4A14,$4A1E), file [0x48A14,0x48A1E): ten return-map bytes. Related field dispatcher CPU [$6B98,$6BC7), file [0x4AB98,0x4ABC7); setter CPU [$6C73,$6C9B), file [0x4AC73,0x4AC9B); both graphics readers CPU [$6E0B,$6EB7), file [0x4AE0B,0x4AEB7). FieldCommandSpriteTable: CPU [$704C,$70A4), file [0x4B04C,0x4B0A4), 22 four-byte records. RAM $C965 is a fixed-WRAM byte, not banked RAM; the setup copy/clear sequences are $07:[$6B65,$6B6F), file [0x1EB65,0x1EB6F), and $07:[$7D93,$7D9D), file [0x1FD93,0x1FD9D). Bank numbers are hexadecimal, offsets zero-based and ranges half-open. Species/pointers are little-endian words; counters, clipping, coordinates and saved state fields are bytes.
- **Method/deliverable:** read all 32 core bodies, all five full dispatcher tables, snapshot/save-position consumers, monster graphics loader, bank-$08 string-copy wrapper, fade/step helper, field initializer, field dispatcher and the three related setter/loader bodies. Write 36 whole-routine annotations, 26 explicit code-stage names plus one data label, a corrected field-table header and corrected saved-flag RAM note. Runtime inputs are constrained separately from the scene interpretation. Root command names retain their existing ids; shared stages are MonsterScene_*.
- **Shared flow:** LinkMessageEvent has 23 entries, NpcBreedWarp 25, BreedChildScene 28, BreedChildSprite 17 and BreedFade 25. Species words from wRecordBufA/B supply object 1/2 graphics at $8600/$8700 with palette slots 6/7. Slot 0 Y compares after decrement to $58 or after increment to $C8. Reveal stages use exact sixty-call counters; shared pauses use thirty. Left/right slides change X only when the updated phase & 3 is zero, with destinations $48/$58; byte overflow is retained. The child-only variant still executes the shared writes of both object facing states.
- **Child display:** MON_SPECIES supplies child graphics and the name lookup (index low byte; category high byte + 2 modulo 256). Copy the name to wTextBuf2 + 1 without touching its prefix. MON_PLUS 0 opens message $17 and returns without changing the number buffer or saving clipping. Nonzero plus opens $18, emits optional quotient and remainder from byte division by ten plus $F0 terminator, and saves/clears clipping. No three-digit expansion for values above 99. The following message-wait stage unconditionally copies wScriptParam0 to clipping on idle. A deliberately stale parameter tests the zero-branch distinction; ordinary-game reachability of such a stale value is unestablished. The effect wait queues $74 on incoming phase $C2, increments to exact $E0 and then clears object 5, sets object 1 Y=$3C/facing 0, and advances.
- **Returns/snapshot:** NPC return maps are $04/$17, with screen X 2/0 selected separately; all ten table inputs are tested. Generic fade/step clears phase and sets mode substate 4, while BreedFade's own return preparation calls StartPaletteFade directly and retains its duplicate screen-X write. BreedFade waits for exactly zero fade state before restoring the caller request/pointer as command $ED. Child completion assigns map/position directly, without starting a fade. NPC completion selects $F4 and restores slot-0 state; the field transition restores player/follower coordinates when the validity flag is set. The thirteen-byte snapshot includes direction/X/Y, skips each follower's target coordinates and leaves the validity flag alone.
- **Corrections/contradictions:** E-0238's header claimed field-record byte 3 was returned and combined two loader contracts. Both actual bodies return byte 2. The general body loads VRAM $8400/palette slot 4; the scene-effect variant loads $8300/slot 3. Both use byte 2 low seven bits as the CGB palette index, and preserve the trailing byte without a new interpretation. Command 0's selector differs from byte 3, providing a contrasting runtime case. The old wLinkSaveStateFlag note said it was "set by LinkMessageEvent_SetSaveStateFlag"; that finish routine reads $C965 and copies it to wSaveStateFlag before requesting mode 8. The two bank-$07 setup sequences perform the opposite copy and then clear wSaveStateFlag. Earlier wording is superseded here; this is one local source, not independent corroboration.
- **Reproduction:** `python -I -m unittest discover -s tests -p test_breeding_scene.py -v`. Ten tests in `tests/test_breeding_scene.py` use the existing direct-call harness: ROM bank $12, default WRAM bank 1, interrupts initially disabled/IE=0, return sentinel $C800 and stack $DFF0. No save state. Cases cover phase 0/2/3/$FF and left/right destinations, reveal-counter 58/59/60/$FF, coordinate wrap, all ten NPC selectors, plus 0/5/10/99/100/255 with known Dracky name bytes and preserved prefix/group, stale clip parameters, sound-cue/completion edges, parent species $0073/$0100 loaded against independent LZSS output, snapshot layout/step overflow, distinct command/mode returns, and fade 0/1/$80. Both field loaders are checked on commands 0/13/14/20, CGB flag 0/1, comparing decompressed VRAM and the original eight palette bytes as well as returned A. Ten tests pass (`build/logs/e0360-probes-complete.log`). Initial fixtures used wrong talk-event and palette-buffer addresses; those were corrected against src/ram.asm and the failure logs retained. They are fixture errors, not new game defects.
- **Review/limits:** exact comparisons, pre-increment cue timing, byte/nibble arithmetic, bank restoration and output memory were reviewed against the bodies and cases. Keep both clipping branches, duplicate write and distinct loader slots intact. Treat registers/flags as scratch except the local helper returns stated here; no complete scene ABI, rendering/timing or serial protocol claim. Normal callers supply valid species/field-command/table ids; no new safety claim for other inputs. Game semantics remain C1.
- **Acceptance/handoff:** `python -I -u tools/disasm_all.py` regenerated the complete source after all loader/table corrections (`build/logs/e0360-generation-final.log`). All 54 documentation/presentation/name/grounding/annotation/operand/probe checks pass (`build/logs/e0360-checks.log`). Clean `python -I tools/build.py --out build/run565`: PASS. Preserve the combined-tree report/review and logs; the full gameplay suite was not run this turn. Continue at FollowersStep14 ($12:$4E4B), WarpWithFollowers and the neighboring follower/player step commands, tracing flags, coordinates, warp destinations and return scripts together.

### E-0359 — Arena scene stages and their shared data

- Date: 2026-10-14. Kind: OBSERVATION / whole-routine READING. Confidence: **C1**, with emulator observations confined to the direct inputs below. Author/reviewer: lead agent, self-review. No independent hardware validation or full arena playthrough.
- **Target:** `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Starting revision `21a2e68ffa6f15be4a456e9138a5361b3977e603` plus the existing uncommitted E-0357/E-0358 tree. Baseline: clean `build/run562/report.json`, PASS, 4,194,304 bytes, approved hash, zero differences. Final verification: `build/run563/report.json`, PASS, same size/hash, zero differences; companion `review.json` records revision, dirty-tree digest, file/tool hashes and check results.
- **Question/prediction:** can the two arena dispatch tables be explained as a shared entrance/battle/opponent-arrival/exit sequence, preserving exact counter conditions, reused RAM meanings and the individual foe-word format? Alternatives to challenge: one step increment per object-animation call, message-table high bytes selecting groups, a random draw choosing a complete group, and a threshold rather than equality ending each leg.
- **Ranges:** bank $12 CPU [$43DA,$48B9), file [0x483DA,0x488B9): 25 routines. Message table at CPU [$48B9,$4919), file [0x488B9,0x48919): six rows of eight little-endian words (96 bytes). Related helpers: $0C:[$703D,$7064), file [0x3303D,0x33064); random builder $0C:[$7326,$73B3), file [0x33326,0x333B3); heal $12:[$64F8,$653F), file [0x4A4F8,0x4A53F). All bank numbers are hexadecimal. RAM widths: counters, state, coordinates, message index/group are bytes; foe/HP/MP records use little-endian words.
- **Method:** read all 25 bodies and both complete dispatcher tables, the message consumer/table, the bank-$0C encounter producers, random builder and encounter lists, the round/grid counter helpers, the map-$0B object loader and complete party heal. Trace script-command $95/$96 stubs into the dispatchers. Write 29 whole-routine notes (one replaces an earlier E-0357 note) and explicit action names in config/annotations.json/config/names.json; improve the table header in config/tables.json. The scene, caller assumptions and player meaning remain C1.
- **Transitions:** ArenaRounds has 26 entries and ArenaGridBattle 27. Shared message waits clear wMessageIndex on idle before it becomes an animation timer. The five player legs compare updated Y=$20, X=$30, Y=$40, X=$20, Y=$30; the last leg omits the follower updater. The grid entry saves wFieldEventKind in wScriptParam1 and the final leg restores it. Approach lasts sixteen calls from phase 0, increments the reused wRecordCapacity counter, chooses intro 4/substep 1 and enters battle mode 3. The first command's after-first/second-battle stages test the decremented counter for **exactly 2**, choosing closing stage 22 in that case while still preparing foes. They do not themselves read a battle outcome, so the branch is not newly named as a win/loss decision.
- **Object loop:** uses four slots regardless of wSpriteSlotCount. The borrowed message timer reveals counts 2/3/4 at $10/$20/$30 and holds at $60. Y increments while bit 7 is set or Y<$20, then X increments to $60, Y to $40, and X toward $70. Each slot reaching X=$70 separately increments the script step **inside** the loop. The direct probe with four simultaneous arrivals advances it four times; no claim that this setup occurs in normal play. Facing and flags are written as the code specifies.
- **Message table:** for valid columns 0-7 and ranks 0-4, index = 2*column + 16*rank; arena flag bit 7 forces row 5. Only the stored low byte reaches StartMessageA; wMessageGroup stays unchanged. Stored high bytes, including the $FFFF words, are retained. Actual byte arithmetic uses SLA(column) and SWAP(rank), with carries into DE; invalid values are unguarded. The probe with A=$80 wraps to column 0, and rank $10 reads offset 1 instead of offset $100. This limits the earlier formula in E-0125/E-0237 to valid inputs.
- **Foe builder correction:** E-0357's old note said it chose a random "foe group." The local pointer list and stores show it selects **one encounter word per draw**, writes three per remaining round, and leaves earlier round words intact (as E-0183 already described). It consumes L, the quotient after DivideHLByA, rather than RandomModulo52's remainder in A; folds the index to the class list size; and skips indexes with usage count 3 in this rebuild. It clears forty usage bytes on each call. Valid inputs tested: initial rounds 0-2 and class indexes 0-5. No uniform-distribution claim. Earlier wording is superseded here, not independent corroboration.
- **Heal contract:** currently selected SRAM bank, nonzero party count and valid party record indexes are caller preconditions. Enables RAM, follows wPartyList, copies max HP/MP to current values and zeros all MON_STATUS bits, then disables RAM. Does not write the SRAM bank selector. Direct calls in banks 0 and 1 reproduce that bank dependency; bank 1 is an experimental input, not a claim that normal party records reside there.
- **Reproduction:** `python -I -m unittest discover -s tests -p test_arena_scene.py -v`. Eight tests in `tests/test_arena_scene.py` execute the immutable ROM using tools/sm83.py and the existing `test_routine_behaviour.call` harness: bank mapped explicitly, default WRAM bank 1, interrupts disabled, return sentinel $C800, stack $DFF0, initial memory/expected values given in each test. Cases include every valid message row/column plus forced row 5, preserved group flags, invalid byte/nibble inputs, negative Y wrap, timer reveal boundaries, one/four object arrivals, each player leg, counter 3/2/0, counter overflow, all six encounter lists from starting rounds 0/1/2, and healing noncontiguous record indexes in selected SRAM banks. Eight tests pass (`build/logs/e0359-probes-final.log`). An initial fixture used the wrong numeric address for wEncounterKind; it was corrected against src/ram.asm, retaining the failed log.
- **Review/limits:** read names against the actual stores and table order; retain simultaneous-arrival step increments, zero-count absence, high-byte discard and all asymmetric operations. Notes state exact comparisons and input widths rather than inferred familiar algorithms. Calls alone do not establish natural scene reachability, rendering, menu-result meaning, interrupts or hardware timing. Original compressed graphics and all ROM bytes remain unchanged.
- **Acceptance/handoff:** `python -I -u tools/disasm_all.py` regenerated the source. Two final comment-only wording changes were synchronized to the listing's literal config-comment lines and `python -I tools/present.py build/listing` rerun: say Y **increments** rather than "walks Y up," and use the presenter's accepted evidence-prefix syntax so the table header's ids move to its end. No instruction, data, discovery input or layout changed. The 52-case documentation/presentation/name/grounding/annotation/operand/probe run passes; 39 presentation/annotation/probe checks pass after final wording changes. Clean `python -I tools/build.py --out build/run563`: PASS. The full gameplay suite was not run this turn. Preserve all logs and the exact-tree review report. Continue at LinkMessageEvent ($12:$4919), then the NPC breeding warp and bred-child display, reading their messages, graphics and return paths together.

### E-0358 — Scripted player and follower paths, read through their transitions

- Date: 2026-10-14. Kind: OBSERVATION / whole-routine READING. Confidence: **C1**; static interpretation and observations of the project's emulator, not independent hardware validation. Author and reviewer: the lead agent, self-review.
- **Target:** `dwm2-cobi-us-rev0`, SHA-256 `8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`. Starting revision `21a2e68ffa6f15be4a456e9138a5361b3977e603` with existing uncommitted E-0357 work. Baseline: `build/run559/report.json`, PASS, zero differences. Final combined-tree report: `build/run561/report.json`, PASS, 4,194,304 bytes, approved hash, zero differing bytes; its companion `review.json` records the revision and dirty-tree file hashes.
- **Question/prediction:** do SCRIPT_OBJECT_PATH_1B and SCRIPT_OBJECT_PATH_1C perform sequential sixteen-call hops with a zero-net Y curve, and do their one/two-member branches skip only the absent followers' hops? Alternative: timing is a threshold, or all stages move X/Y consistently with facing. Neither alternative describes the instructions.
- **Locations:** 33 code entries in bank $12 CPU [$4001,$43DA), file [0x48001,0x483DA): CountdownMessage, EncounterCounterMessage, RandomBattleEvent, both twelve-stage paths, their shared finish, curve wrapper and phase tail. The bank-number byte at $4000 is outside the scope. Consult the listing's address aliases for each entry. Related consumer: AddStepDeltaToPointedByte at $5F:$6BCD, file [0x17EBCD,0x17EBE8); its 16-byte curve at $5F:$6BE8, file [0x17EBE8,0x17EBF8). Existing follower-record interpretation: E-0093; direction offsets: hPlayerFacing and CheckInteractionInFront (E-0357).
- **Method:** read every body in the range, its full jump tables, the curve consumer and table, UpdateFollowersOnStep_Bank12, SetFollowerTargetsFromLeader, StepFollowersTowardTargets, the message-start/idle wrappers, and CallInBank. Give each stage a short action name and a written explanation in `config/names.json` and `config/annotations.json`. The root dispatch names retain their talk-group ids; no new scene identity is inferred.
- **Hop contract:** ScriptApplyStepDeltaAtDE_Bank12 takes a byte pointer in DE, stores it in wStepPtrLo/wStepPtrHi, and uses a far call to bank $5F. The table index is the unsigned phase divided by two (`srl a`); byte addition wraps modulo 256. The deltas are -2,-1,-1,0,-1,0,-1,0,0,1,0,1,0,1,1,2. Their sum is zero and their lowest cumulative displacement is -6. Phase 0 reaches $20 after sixteen increments of two; only equality resets the phase and increments the eight-bit script step. Odd starting phases never satisfy that equality in the shared tail. The curve reader itself has no bounds check, so this tail result does **not** establish valid reads for arbitrary phases. The far call restores bank $12; registers and flags are scratch, not a return-value contract.
- **Paths:** 1C leaves for map $00 screen (0,2), destination ($70,$F0); 1B leaves for map $1A screen (2,0), destination ($60,$B0). Their leave stages compare the updated third follower Y with $B0/$F0 before fading. Each entry path sets a follower line, then walks to player Y $20/$50. The active first/second entry hop skips to shared stage 11 only for party count exactly 1/2 after its curve phase resets. Other counts keep the helper's next stage. Every direct store is retained: 1B's player hop decrements player X but follower Y; its first/second follower hops decrement the active follower X but trailing follower Y; its third follower hop decrements third follower X. This is an observation, not a diagnosed gameplay bug.
- **Messages/battle:** the countdown and encounter-counter commands start message $10/$0F in the existing group, share an idle wait and finish with request $80. RandomBattleEvent chooses intro 0/1 by map-type bit 7 and transition substep 0/2 by the low random bit after updating the seed; it enters mode 3 on step 0 and finishes on a later call. Player-visible message identity and natural scene reachability are not newly verified.
- **Reproduction:** `python -I -m unittest discover -s tests -p test_object_paths.py`. Five tests execute the immutable ROM in `tools/sm83.py`, with interrupts disabled, bank $12 mapped, default WRAM bank 1, sentinel return $C800 and stack $DFF0, through the existing `test_routine_behaviour.call` harness. No save or emulator state is required. Cases cover phase 0/30/31/254/255, script-step overflow, a complete hop starting at Y=0 (wrapping through $FA back to 0), bank restoration, one/two-member shortcuts versus counts 0..3, and the third follower's X/Y distinction. Each case's initial memory and expected results are in the test file. All five pass.
- **Limits/review:** these tests call routines directly; no claim about frame timing, rendered motion, a full scene, interrupt interleaving, or safety of invalid phases. Self-review compared names and notes with the actual writes, both dispatcher tables and the helpers, explicitly retaining the asymmetric stores. A previous generated phase-tail summary said only "increments"; the new note states the increment of two.
- **Integration findings:** the initial 79-case source-check/probe run had two failures in earlier E-0357 work. The $02:$6DEE annotation retained a former name for the palette table at $02:$6E20, although the listing correctly uses RunMenuStateMenuState_Data; the editable note now uses that name. The operand audit classified 59 flagged field-message words as RAM/VRAM pointers. It now identifies consumers from their instruction bodies (HL copied to message fields, to command-$09 parameters, or to the masked-group string lookup), and permits only an immediate call/jump from a numeric HL load to those consumers. Three controls cover a real message-word store, a misleading name/quote on a pointer reader, and intervening instructions or memory operands. Both failing checks and the note-count check pass on rerun, as do all three new controls (`build/logs/e0358-corrected-checks.log`: six tests, OK). The initial failure log is preserved. The final phase-tail wording says the caller applies the curve before the tail, avoiding the presenter's literal "not read" gap detector; that one annotation line was synchronized to the generated listing and `tools/present.py build/listing` rerun, without changing any instructions or data.
- **Acceptance/handoff:** `python -I -u tools/disasm_all.py`; source-wide tests in `test_doc_coverage`, `test_generated_source`, `test_present`, `test_name_claims`, `test_step_names`, `test_note_grounding`, `test_local_labels`, plus `test_object_paths`; final wording presented with `python -I tools/present.py build/listing`; clean `python -I tools/build.py --out build/run561`, PASS. The initial 79-case run and subsequent 63-case presentation/probe run both encountered the two integration failures described above; all other cases passed. The corrected cases and three new controls pass on rerun. The full gameplay-suite attempt was stopped before a completion report while finalizing the reader-facing tree; no full-suite pass is claimed. Source presentation changes only names and comments. Continue at ArenaRounds ($12:$43DA) and its shared ArenaGridBattle stages, reading their message table and encounter producers before naming them.

### E-0357 — Routines described by hand

- Kind: READING. Each routine was read in full; what it does is a static reading of its instructions, and what it is for (the scene, menu or state it serves) is C1.
- **The gap.** 4,710 routines were described only by the generated restatement (E-0347) and a purpose line borrowed from their parent (E-0352): a list of effects, not an explanation. The E-0355 review sampled 30 of them.
- **The method.** For each routine: its whole body, its callees' notes, the messages it starts (quoted from the message table), the flags it sets or tests, and the dispatcher and scene it belongs to. The note says, in a sentence or a few, what happens in game terms (who walks where, which message, which battle, which story flag) and, where it matters, how (counters, flicker timing, the order of legs in a walk).
- **Readings used throughout** (each checked in the code it relies on):
  - StepObjectTowardCoord: wStepPtrHi = object number, wStepPtrLo = target coordinate, wStepTarget bits 0-1 = direction, bit 7 = two pixels a frame. Directions 0, 1, 2, 3 are down, right, up, left: the order of CheckInteractionInFront's offsets for hPlayerFacing (+Y, +X, -Y, -X), which the object states share (a step walking right sets state 1, left state 3).
  - "Object 0" is the slot at wSpriteSlots + $B/$C (X/Y), the one StepObjectTowardCoord moves for wStepPtrHi = 0; objects 1-3 follow at $10-byte intervals.
  - ScriptApplyStepDeltaAtDE adds a 16-frame hop curve to a coordinate; ScriptStepBlinkObjectTemp0 takes the object (hTemp0) and the Y to show it at (hTemp1).
  - The scenes' flicker (wScriptParam0 below $1E tests bit 1, below $3C bit 2, else bit 3) switches every 2 frames, then 4, then 8: it slows down.
- **Where.** config/annotations.json, one note per routine ending "(C1, E-0357)"; tools/disasm_all.py emits it above the label, where it replaces the restatement and the purpose line.
- **Coverage so far.** 4,448 routines under this entry: banks $00, $01, $02, $03, $04, $05, $07, $0A, $0C, $0D, $0E, $0F, $10, $11, $13, $14, $15, $16, $17, $19, $1A, $1B, $1C, $1D, $1E, $24, $25, $26, $27, $30, $31, $32, $33, $36, $37, $39, $3A, $3B, $3D, $3F, $5F, $60, $61, $81, $84, $85, $87, $95, $96, $97, $A0, $A1, $A2, $A3, $E0, $E1, $E2, $F0, $F1, $F2, part of $73, and bank $12 outside the ranges read with probes in E-0358 to E-0362 (those entries' notes were kept wherever both covered a routine; a later draft never replaces an existing note). With them, 4,588 code labels carry a hand-written note and 569 are still described only by a restatement (most of them in bank $73). E-0365 adds 553 more (the rest of bank $73, the gap routines of banks $04, $13, $16, $36, $39, $3A, $A0, $E0 and $E2): 5,141 hand notes and 105 restatements. E-0366 reads the last 105: 5,246 hand notes and no routine described only by a restatement. tools/doc_coverage.py prints both counts, and tests/test_doc_coverage.py keeps the second from growing and checks that each hand note sits above exactly one code label.
- **Found while reading.**
  - A message word with bit 15 set ("the box is already open") was written as an address: `ld hl, vTiles0 + $48b`, `ld hl, wSGBPacketBuffer + $b`. tools/disasm_all.py now leaves an `ld hl` right before a message routine numeric, so it gets its quote and tools/present.py writes `MSG_ALREADY_OPEN | $048b` or `MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $048a`. 58 operands changed; each now quotes its message.
  - The shield guardian scene removes item $34 without checking that FindTemp0InInventoryList found it; the princess medicine scene checks bit 7 first.
  - Several lines of Cobi's sit behind EVENT_NEVER_SET, in place of Tara's (long faces steps 1 and 8, the Warubou warning, the vault): the other edition's dialogue, kept but never shown (C1).
  - The Land ho row copy writes each attribute byte twice; Mermaid kingdom step 11 has a redundant `ld a, a`.
  - hPlayerStateFlags bit 1 freezes the player's animation counter and bit 2 adds 3 to it each frame (the fast walking animation; DrawPlayerSprite's caller in bank $04): earlier drafts that said "freezes the player" or "holds the player" were reworded.
  - Edition choices compiled as constants: `ld a, 1 / or a` before Tara's or Cobi's script (13:6978), `$02 & 1 + $0B` for a message number (13:69B8), key kind $0A over $0B (13:7B91); the default player name is 'Cobi' with 'Tara' behind EVENT_NEVER_SET or wArg2 (14:5EBF, 14:6D28).
  - Drafts corrected before merging: three notes that read state 2 as facing down, one that halved a turning period (64 frames, not 32), and one that said the flicker speeds up.
  - The priest (bank $24) charges gold by service: Revive (level x 10 + 10) / 2, Detox 3, Uncurse 20 (PriestMenu_PayForService step 6); the services test status bits 7, 2 and 0.
  - At the end of a turn an Ironized slot skips the poison step (3A:6480); poison takes max HP / 16 (at most 50), bad poison max HP / 6 (at most 150).
  - In a link battle with a turn limit, passing it ends the battle as a draw (wBattleScene $80, 3A:6677), the value bank $24's result screen tests.
  - Battle text $BE's name helpers (3A:774F, 3A:77D6, 3A:785D) copy the target's name when all targets share a species and then overwrite it with 'Monsters', so two or more targets always read 'Monsters' (or 'The monsters' for mixed species in the third copy).
  - Game mode 7 (bank $A0) is a two-player link battle in which each side commands one monster (battlers 0 and 1 from wRecordBufA/B) through three rounds of foes, ending in a results screen; one result builds a level-1 copy of record A with unknown parents and quartered stats as an egg (wBattleScene $08).
  - Drafts corrected before merging: "every fourth frame" for `and 3 / ret z` gates (they move on three counts of four), a copy direction between wScreenTileBuffer and wWindowTileBuffer, and a link-role test that is really a link-mode test (3A:51DF).
  - Turn order (30:4160-30:434C): each acting slot gets a random speed between 3/10 of its agility and its agility, plus 3,000 for actions $62 and $D8, 1,000 for a skill whose record byte 5 has bit 2 set (2,000 in bank $A1's copy) and 10 for other skills; action $69 instead takes a random 1-9. An item in use is listed at 2,010. The list is sorted fastest first into wActionQueue.
  - Vacuum's foe branch (36:592E) compares wLinkMode, not the actor, with 4, so foes use the player's formula; Kamikaze (36:5A98) reads the word at the address given by the actor's HP, an apparent second dereference; in 32:5A95 the KODance compare is overwritten by the next one and never decides anything; 85:5A75's second test compares a decremented high byte that is always 0 (C1 for all four as bugs: the bytes are as the code reads).
  - Shops and services: the GoldPass gives 10% off (1C:5EEC); the inn costs 10 gold (1C:4463); the vault refuses a deposit that would bring the banked gold to 999,901 or more and a withdrawal that would bring the gold in hand over 99,999 (1D:549D, 1D:5573).
  - Link breeding (F1:4EA7): the same sex cannot breed; a personality pair value of 3 is incompatible, and 2 only breeds when both parents are level 40 or more with a plus of 5 or more. Link session 5 is breeding with Terry's Wonderland (37:4AFD); session 6 is Team Mode, charging 1000G (or 2000G when one side pays for both) and switching to game mode 7 (33:5215-33:5BE9).
  - The scene after the rival, Mermaid Kingdom, Shield 2 and Darck battles (5F:7700-5F:738B) shares one dispatcher: it fully heals the party, flashes the palette and picks its message set by story flags.
  - Seven reads of $D000 just before $D001 (banks $01, $07, $0D, $36, $3B), each among reads of the record's neighbouring bytes or right after LoadMonsterRecord, were named wScreenAttrBuffer, the WRAM bank 2 buffer at that address; they read byte $12 of the record at wRecordBufferData in WRAM bank 1. tools/disasm_all.py now writes `[wRecordBufferData + $12]` for such a pair, and tests/test_generated_source.py checks it. A hand note between a message argument pair and the label it falls into no longer hides the pair from the raw-address test (it skips comment lines as it skipped blank ones).
  - Drafts corrected before merging: a "healer scene" label that was really the shared boss-win scene, and a 1-29 range for action $69's speed that is 1-9 (DivideBByA leaves the remainder in A).
  - Fleeing (31:4D95): it always works on the first turn or when the party's highest level is more than 5 above the foes', otherwise with a chance of turn / 8 (7 in 8 from turn 4), or when no foe can act; a failed attempt loses the turn. Outside link battles a successful flight lowers the party's personality bytes (31:4E54). RUN refuses in battle kinds 2, 3, 5, 6 and 7 and offers 'Retire now?' in kinds 4 and 8 and up.
  - Experience (31:67C2-31:6BAC): the foes' experience is divided by the number of party monsters still standing; farm monsters get the award divided by 20, 15 or 10 by wFarmLevel. Battle kinds 4, 5 and 8 and up give none. The "learned skill" step (31:6CA0) calls ClearTemp0AndA, which clears the skill it then tests, so its rest never runs (C1).
  - A monster acting on its own (30:502D) uses SKILL_ZONEOUT ($AB) when all three personality bytes are below $40 and SKILL_GUARD ($AC) unless Hi is the largest; the disobedience message $28 of bank $2F reads '<name> ignored orders!'.
  - Key worlds (bank $60): the layout comes from the key's seed (60:4035); floor entrances are spread over the cells and the layout is generated again when they do not fit (60:51B7); a goal chunk whose first byte is $FF would hang in an endless loop (60:5E42).
  - Drafts corrected before merging: a "healer" reading of 5F:7700 (it is the scene shared by the boss wins), the direction of HealUs's foe-status weights (E2:432D), the record HP after battle (31:66E2: the battle HP, capped at the max), and the menu names of bank $31 (FIGHT, PLAN, ITEM, RUN from bank $09's strings).
- **Limitations.** Not run in an emulator; story context (who is speaking, which scene) comes from the quoted messages and flag names. The ROM is identical (build/run602).

### E-0356 — Step names that repeated their parent, shortened

- Kind: PRESENTATION rule (names only; no instruction or data byte changes).
- **The gap.** Step names were built by appending a callee's name to the routine they sit in. When the callee was itself a step of the same routine, its name already began with the routine's name, so the label said it twice: `RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc`. 1,324 labels were longer than 60 characters before this entry.
- **The rule** (tools/disasm_all.py `shorten_repeated_parents`, the last naming pass):
  - `A_B_A_C` becomes `A_B_C` when `A` is a label it extends;
  - a name still longer than 60 characters drops its middle levels (`Top_Mid_Own` becomes `Top_Own`) while `Top_Own` is free.
- **What it leaves alone:** labels that code calls by name, names given in config/names.json, table labels from config/tables.json, labels that other labels extend (so their parts still read as parts of them), and any rename whose new own part is itself a routine's name (`Top_EraseCursorAtEntryHL_Bank07` would read as calling `EraseCursorAtEntryHL_Bank07`, a different routine), or that would collide.
- **Purpose lines keep the middle level.** build/listing/short_names.json records each shortened name's former form; tools/present.py climbs to the parent through the former form, so a purpose line still names the step the routine belonged to.
- **Tests.** tests/test_name_claims.py accepts a callee that is a step of an ancestor (`Top_Own` calling `Top_Own`'s callee); tests/test_step_names.py reads each step's tag from its former name.
- **Result.** 687 labels shortened; 730 labels are longer than 60 characters (80 longer than 80), the longest 109. The ROM is identical (build/run550).

### E-0355 — A review of 30 restated routines against their code

- Kind: REVIEW (a human-style reading of generated documentation). Sample: 30 routines with a `; why:` line, drawn with random.seed(2026) from all of them, each read against its instructions.
- **Accuracy.**
  - All 30 restatements say what the instructions do: stores, flags, calls, the register copies, and the step a routine advances.
  - All 30 purpose lines name the right parent, step and dispatch byte, and quote that parent's note correctly.
  - No claim contradicted the code.
- **Weaknesses found, and the fixes:**
  - The dispatch condition dropped a mask: "when wMapType = 3" for a table indexed by wMapType & 7. The condition now keeps an `and $NN` or `dec a` between the load and the jumptable ("when wMapType & $07 = 3").
  - A routine whose recognised clauses cover little of a long body read as if that were all it did. SceneWatchOut_WriteScriptMsgSelect was "copies wScriptMsgSelect & $03 to wScriptMsgSelect", although most of its body computes a BG map address from the scroll position. When at least 12 instructions carry fewer than one clause per four, the restatement now adds "also changes HL, A and C by register arithmetic", so the omission is visible.
- **Not changed:**
  - Some step labels are very long (RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc). That is a naming matter, outside this entry.
  - Restatements of branchy routines list effects rather than reasoning, as E-0347 says.

### E-0354 — What the dispatchers are for

- Kind: READING (C1) of each dispatcher's steps and callers, and a presentation rule.
- **The gap.** Purpose lines (E-0352) quoted parent notes that only named a dispatch: "runs the routine for wLinkExchangeState (jump table of two)", "per-frame routine for wGameMode = 5", "wBattlePhase 2, wBattleStep 3". 1,715 purpose lines quoted such a note.
- **The rule.** tools/present.py THIN_NOTE recognises such notes. The purpose search now climbs past them to an ancestor whose note says what it is for, and uses the thin note only when none is found. That left 35 dispatchers quoted by 392 purpose lines.
- **35 notes written by reading their steps and callers**, among them:
  - link sessions 5, 6 and 8;
  - the name-entry screen: used for the player's name, renaming, a bred child, and a monster that joins;
  - the world map;
  - the 22 field commands that place a scene's scripted figure;
  - game modes 2, 5, 6 and 8;
  - the field menu;
  - AI command entry and action resolution;
  - the debug viewer of bank $E0;
  - the title screen's opening and link menu;
  - the warp checks by map type;
  - the field-return phases;
  - battle end steps 1-7 (closing message, waiting for the sound, experience, the join offer, music, the link end).
  - Each keeps the old text after "was:" and cites E-0354.
- After: no purpose line quotes a thin note. tests/test_doc_coverage.py checks this.

### E-0353 — The readings without entry numbers, re-read

- Kind: REVIEW of existing claims against the code.
- **Scope.** All 185 names and families whose evidence was "reading" with no entry number (154 config/names.json entries, 31 config/name_families.json families, cited as E-0351).
- **Method.** Each routine's instructions were read beside its note. These checks were also made:
  - the 10 bytes InstallOamDmaRoutine copies ($3E $C0 $E0 $46 $3E $28 $3D $20 $FD $C9: ld a, $C0 / ldh [rDMA], a / a 40-count wait / ret);
  - Multiply8's bit loop;
  - the SGB and DMG paths of StartPaletteFade.
- **Result: 177 accurate, 8 corrected.** Each corrected note keeps the old text after "was:".
  - SetFlagBit with DE >= $0300 never returns (`.skip2` is a `jr` to itself); the note said it did nothing.
  - StartPaletteFade: the buffer copy and white/black fill is the Super Game Boy path, which sends SGB palette packets, not the DMG path.
  - CopyScrollToHardware also copies hWindowX/hWindowY to rWX/rWY.
  - FillTilesRequest: E goes to wTextWindowRows and D to wTextWindowWidth (the note had width and height the other way round).
  - InitSoundHardware: the steps in their actual order.
  - The bank-$1B CopyTileBytesToVRAM copy clobbers C as well as A.
  - HLToBattleStatus8EntryOfBattleTarget: A is clobbered; it is not the target.
- Their evidence now reads "reading, re-read against the code (E-0353)".
- **Address names in comments.** Notes written early still named RAM by address (wC5E8, hFFC6, wD0A2, and a capitalised WD789). Comments now show the symbol, or `symbol + $N` up to $3F inside one: wRandomHi, hTemp0, wWorkBuf + $5, wListEntries. A home-bank address after "at" or "table" is its label ("the byte at RandomByteTable + wRandomHi"). No address-form RAM name is left in a comment.

### E-0352 — What each restated routine is for

- Kind: presentation rule. Each purpose is drawn from evidence already recorded; nothing is newly read.
- **The gap.** E-0347 gave the 4,710 routines without a written note a restatement of their instructions: what the code does, not what it is for.
- **The rule (tools/present.py, Names.purpose).** Each such routine now has a second line, `; why: ...`. It follows what the routine is part of until it reaches a routine whose note was written by reading, and quotes that note's first clause and evidence ids. The links it follows, in order:
  - the jumptable it is an entry of, with the RAM byte that picks the entry ("step 5 of InnMenu (when wScreenState = 5)");
  - the one routine that calls it ("a helper of InnMenu_Pay");
  - the routine it continues, by its name prefix ("part of WriteTargetNameOrTheMonsters");
  - its callers ("used by ...");
  - for a per-bank copy, the note of a documented sibling copy ("a copy of ClearBattleStatusBitsWithMaskD_Bank05").
- Example:
  ```
  ; called from InnMenu_Pay: sets wGoldHi; copies B to wGoldMid; copies C to wGoldLo (E-0347)
  ; why: a helper of InnMenu_Pay; InnMenu_Pay: checks the price against the gold
  ; (IsAmountInArg1AboveGold) and redraws the gold (E-0352, E-0276)
  ```
- Names in the quoted clause go through the same resolution as every comment. A recorded parent whose name no longer exists is skipped in favour of the name prefix.
- **Result.** All 4,710 restated routines have a purpose line. tests/test_doc_coverage.py checks this, and checks the purpose search on a synthetic listing.
- **Limits.**
  - A purpose is only as good as the documented note it quotes; some parent notes are themselves short ("runs the routine for wScreenStep").
  - The line says what the routine serves. It does not reason about each instruction's intent.
- Binary verification: build/run544 PASS, 0 differing bytes.

### E-0351 — Names read before per-name evidence ids

- Kind: OBSERVATION about the record, not a new reading.
- 138 entries of config/names.json and 32 library families in config/name_families.json give their evidence as "reading" with no entry number. Seven of them add "+ execution (tests/test_routine_behaviour.py)", and five add a hardware reference: the SGB packet protocol, or the Pan Docs layout of rP1.
- They were written in the early naming sessions (E-0040 to E-0130, 2026-10-10 to 2026-10-11), when a note cited an entry only for findings that needed one. Each note restates what its routine's instructions do, and its confidence is C1.
- Their comments in src/ now cite this entry, so a reader can see the claim is a plain reading. Promoting one needs its own entry, with a contrast case or an emulator observation.

### E-0350 — No bare address operands; every routine comment cites evidence

- Kind: READING (C1) per operand, and presentation rules. The assembled bytes do not change: each form evaluates to the same 16-bit value, and the build checks every byte.
- **Before.** tools/readability.py counted 167 bare operands (`ld rr, $XXXX`, `call/jp $XXXX` with an address-like number):
  - 94 into ROM without a quote;
  - 31 message words;
  - 30 above $C000;
  - 7 in SRAM's range;
  - 5 in VRAM's range.
- **Rules in tools/present.py (operand_forms).**
  - `lb rr, $HI, $LO` for a pair holding two bytes:
    - HL and BC before the resolve-message routines (H = target, L = actor, B = argument, C = flags), also through `jr`, local labels, or falling into the routine;
    - DE before the sprite steps toward a point.
  - Signed numbers for negative constants (`ld hl, -999` before `add hl, de`, `ld hl, -128` as a step delta).
  - `call hOAMDMARoutine` for `call $ff80`.
  - The listing's label for a same-bank pointer that is indexed or dispatched at once (`ld hl, ActionEffectTable`).
  - `MSG_KEEP_OPEN | $0487` for a quoted message word given to a message routine.
- **Message word flags** (constants.inc). RunMessageBox (bank $5F) reads H bits 6 and 7 of a message word:
  - Bit 7 (MSG_ALREADY_OPEN, $8000) skips the opening: the tile fill of vTiles1, sound $69 and window state 1.
  - Bit 6 (MSG_KEEP_OPEN, $4000) skips the closing: sound $69 and window state 2, and lets the next step run without waiting for the window.
- **config/operands.json**: 82 pointers and 17 values read one by one, each keyed by its instruction's address and given the reason.
  - Pointer banks come from the code beside each load:
    - `ld b, $56` / `$7E` before a decompressor;
    - `rROMB0 = $38` / `$09` / `$04`;
    - `ld a, $5E` before CopyRectFromBankToVRAM;
    - the glyph font GlyphFont at $1F:$4010 for `$4010 + 16 * glyph`;
    - MapTable in bank $11;
    - the bank of the routine that reads the argument: TestBitInFieldAtArg3 in $15, LoadTileListSixPerCall in $1D;
    - same-bank readers and tables.
  - disasm_all.py labels the exact target, or writes `Table + $offset` when the target lies inside a field of a declared table (NameEntryTileSrcListB + $..).
  - One target was a 16-word handler table that the tracer had decoded as `dw` words: entries 0-7 are RollPersonality*/RollSlotTrait*, 8-15 all $4FC6. It is now FlagBitHandlerTable, and CallFlagBitHandlerE loads it by name.
  - Values:
    - gold amounts for AddGoldCapped (20000, 30000);
    - a busy-wait count (24576);
    - the CGB colour white (PAL_WHITE in hardware.inc);
    - two-byte pairs: text window rows/width, the title state and link byte, scroll bytes, script parameters, resolve-message flags;
    - message words with their flags.
- **Evidence ids on every comment.**
  - Generated restatements and data notes end with (E-0347).
  - Names from a table's entries cite that table's entry (E-0038, E-0039, ...).
  - Copies of a named routine cite the source's entry (else E-0105).
  - "starts Script_X" lines cite E-0248.
  - A written note without an id gets the id config records for its name, or E-0351 for readings recorded without one.
  - Restatements keep 12 clauses instead of 7 and count the rest ("then 9 more steps (see the code)").
- **After.**
  - raw_pointer_operands: 0.
  - Address-named labels: 0.
  - Every one of the 9,822 routine comments and 649 table headers cites an evidence or decision id.
  - tests/test_doc_coverage.py checks both.
- Binary verification: build/run543 PASS, 0 differing bytes.

### E-0349 — Bank files in pokered-style directories (D-010); register flow in summaries

- Kind: DECISION (D-010) and presentation. The assembled bytes do not change.
- **D-010.** pokered keeps its source in directories by kind (home/, engine/, data/, text/, audio/, gfx/, maps/). The 256 bank files now live in `src/<dir>/bankNN_<topic>.asm`.
  - The directory of each bank is the `dir` field of config/banks.json. It was set once, by script, from the bank's file name and contents:
    - home: bank 0;
    - audio: the sound banks;
    - text: banks named messages, strings or battle text;
    - engine: at least half code;
    - scripts: more than 30% script commands;
    - maps: maps, key worlds, map objects and the world map;
    - gfx: sprites, pictures, tile sets, the SGB border, or more than 30% INCBIN;
    - data: everything else;
    - unused: the 99 empty banks.
  - Result: home 1, engine 44, scripts 1, text 25, data 10, maps 46, gfx 26, audio 4, unused 99.
  - tools/present.py writes the files there and updates src/main.asm's INCLUDE lines. `present.bank_files()` lists them for tools and tests. src/banks/ is removed.
- **Register flow.** A generated summary that names only control flow ("may return early", "continues in X") now says which registers the routine takes and changes, in straight-line order ("takes DE and A; changes A; may return early"). It is the input and output note pokered gives its helpers. A lone `jp X` reads "continues in X".
- Binary verification: build/run536 PASS, 0 differing bytes.

### E-0348 — Pointer operands named where their bank is clear; byte pairs written with lb

- Kind: generator rules (C1, same-bank reading) and presentation. The assembled bytes do not change.
- **Why pointers stayed numbers.** label_data_refs withholds its same-bank guess in banks where many `ld rr, $4000-$7FFF` operands land inside decoded code. In those banks the values are often not pointers: message flags in BC, coordinates in DE, message words in HL. The rule was right for those values but also left real local tables as numbers.
- **New rules, applied per operand in those banks:**
  - **Used as a pointer.** The next instructions index the register as a table before any call, return or jump: `add a, l`, `add hl, de|bc`, `add a, e` for DE, a read through it (`[hl]`, `[de]`, `[bc]`), or a call to a bank-0 table reader (`...TableEntry`, `IndexWord`). The target must not lie inside a decoded instruction. Example: ActionEffect_LoveRain's sixteen heal amounts are now ActionEffect_LoveRain_Data.
  - **Passed to a same-bank reader.** The register goes, before any other control transfer, to a routine in this bank or bank 0 whose first 40 instructions never switch the ROM bank (no write to $2100, no rst $10, no bank-switching helper). The target must be an existing data label of this bank, or lie inside one. A pointer inside a table is written `Label + $offset` (`CursorPositionWords_Bank07 + $10`). No new label is made.
  - **Bank in A.** `ld a, BANK` before a bank-switching copy helper (CopyRectFromBankToVRAM) names the bank when it is the current one.
- **Byte pairs.** `ld bc, $WWRR` / `ld de, $XXYY` holding two separate bytes are written `lb bc, $WW, $RR` / `lb de, $XX, $YY`, as pokered writes them:
  - before rectangle routines (B = width, C = rows), as before;
  - before the resolve-message routines (B = argument, C = flags, E-0073);
  - before the sprite steps toward a point (D = X, E = Y, E-0127): StepSpriteSlotToward and StepSpriteSlotTowardDE.
  - The `lb` macro assembles to the same `ld`.
- **Summaries.**
  - tools/describe.py reads `ldh` loads and stores.
  - It follows A through `and $NN` ("returns unless hJoyPressed & $0f is $03").
  - It forgets A after arithmetic and shifts.
  - It names register copies ("copies L to wResolveMsgActor").
- **Result.**
  - tools/readability.py raw_pointer_operands: 447 to 167.
  - `ld rr, $4000-$7FFF` operands with no quote: 389 to 94.
  - The 31 message words with a quote are message ids, documented by their text.
  - What remains are home-bank loads into whatever bank the caller maps, pointers passed to routines that read another bank, and values the rules cannot tell from pointers.
- Binary verification: build/run534 PASS, 0 differing bytes.

### E-0347 — Every label documented; comments name only what exists

- Kind: OBSERVATION and a presentation rule. Generated comments restate instructions; they make no semantic claim.
- **Coverage before** (tools/doc_coverage.py on src/banks after E-0346):
  - code labels: 5,112 of 9,822 had a comment above them;
  - data labels: 22,977 of 23,390 were documented. A data label counts as documented when it has its own comment, its body is text, or an earlier label of its unbroken data run has a header comment (pokered documents a table once).
- **Restatements (tools/describe.py, called by tools/present.py).** A code label that reaches src/ without a note gets a comment built from its instructions and the listing's bookkeeping above it:
  - "step N of P", from the jumptable entry;
  - "called from X", only when X is a current label;
  - RAM stores ("sets X to 3", "copies Y to X", "increments X", "advances wScriptStep", bit set and clear through HL);
  - story flags checked, set or cleared;
  - messages shown (with their first words), scripts started, sounds played;
  - calls, except address arithmetic and waits;
  - early returns with their condition ("returns unless X is $60");
  - "branches on X", "continues in Y", and "dispatches on X" at a jumptable.
  - Seven clauses at most; "..." marks more.
- **Data blocks.** A data block with no note is described by its reader (the label it extends, or the first routine whose operand names it) and its size: "data read by VaultMenu (8 bytes)".
- **Notes that admit a gap.** A written note that says "not read", "not interpreted" or "unknown" about a code body is followed by a `; code:` line with the restatement (438 notes, among them the ActionEffect_* and ItemApply_* routines of E-0084).
- **Names in comments.** Comments named 1,471 identifiers that are no label, RAM symbol or constant (2,616 uses). These were names from before later renames.
  - present.py now maps such a name to the current label through:
    - the listing's address aliases;
    - former names recorded in config/names.json ("was X", "shortened from X");
    - build/listing/step_names.json;
    - the parent's jumptables for `Parent_CaseNN`, `_SubNN` and `_TableK_CaseNN` names;
    - the copy in the same bank for a family name (StartScriptAtHL in bank $13 is StartScriptAtHL_B13).
  - 104 stale names in config notes were rewritten through the address they had in revisions before D-005 (git history, where every label still had its address alias). 27 more were fixed by hand: local labels for addresses inside routines, and the current names of renamed tables and steps.
  - A first attempt that also mapped every "was X" word replaced ordinary words ("was a", "was you") with labels. It was reverted before anything was committed; the rewrite now accepts only label-shaped names that the metric reports as stale.
- **After.** Documented: 9,822 of 9,822 code labels and 23,390 of 23,390 data labels. Gap notes without a restatement: 0. Names in comments that are no label, RAM symbol, constant, family name, test class or game word: 0. Former names after "was" or "from" are history and are not counted. tests/test_doc_coverage.py checks all four counts and the summarizer's reading of common shapes.
- Limits:
  - A restatement says what the instructions do, not why.
  - Branchy routines are summarized only by their first clauses.
  - Pointer operands that are raw numbers (389 `ld rr, $4000-$7FFF` operands) stay as they are. Most are constants, message words or pointers into another bank, and labelling them needs each one's bank.
- **Include files.**
  - Every hardware symbol in src/hardware.inc (67) has a comment saying what the register or region does. These are Pan Docs facts (HARDWARE), from tools/gb_symbols.py.
  - The 15 battle actions with no name (ACTION_D0 ... ACTION_DE) name the effect routine that handles them.
  - The src/ram.asm header no longer says that some names are bare addresses. All 958 RAM symbols carry a comment.
  - Monster, skill and item ids stay without comments. Each name is its id's own name string, and its value is in the `EQU`.
- Binary verification: build/run529 PASS, 0 differing bytes.

### E-0346 — The other 36 battle status bits; every story flag named; unlisted object selectors

- Kind: READING (C1) and generator naming rules, with the forced-bit runs of E-0339 (`build/status/s0.json` ... `s8.json`, tools/status_check.py).
- **Status bits** (config/battle_status.json, now 72 of 72). Several unnamed bits are halves of 2-bit fields: each is named after its field, from the masks applied to the status byte.
  - Byte 0, bits 2-3: SLEEP_TURNS_LO/HI. ActionEffect_Sleep sets bits 7, 3 and 2 together (`or $8C`).
  - Byte 0, bit 6: PARALYZED. ActionEffect_ActionC6 sets it with resolve message $76, '0 became paralyzed!'.
  - Byte 1, bit 1: BLINDED. It is set when RollVsRadiantResistance succeeds.
  - Byte 1, bit 2: ATK_DOUBLED. ActionEffect_TwinHits sets it with message $43, '0's ATK doubled!'.
  - Byte 2:
    - bit 0, TAKE_MAGIC;
    - bit 1, BOUNCE (lasting) and bit 5, MAGIC_BACK (one-time): TryWallOfLightBounce tests $22 and clears bit 5 unless bit 1 is set;
    - bit 2, DAMAGE_HALVED (HalveDamageIfTargetStatus2Bit2);
    - bit 7, CRITICAL_ROLLED: ResolveStepChanceRoll sets it, and ResolveStepComputeDamage then uses ATK within 5% as the damage.
  - Byte 3, bit 7: AIRBORNE_HI. Byte 3 is tested with `and $C0` in about 40 places.
  - Byte 4:
    - bit 1, CHARGE_UP_HI (`or $03` in ChargeUp);
    - bit 2, HIGH_JUMP: ForcedActionForActorStatus forces action $CC; bit 3 is HIGH_JUMP_HI;
    - bit 5, SUCK_AIR_HI (`or $30`);
    - bit 6, FOCUS_LO.
  - Byte 5:
    - bits 0 and 1, RADIANT_BLIND and SANDSTORM_BLIND: Radiant uses D = 1 and SandStorm D = 2, against this byte;
    - bits 2-3, SIDE_STEP and SIDE_STEP_HI;
    - bit 4, SONG_FORCED (forced action $CE);
    - bit 7, IRONIZE_TURNS_HI: the wear-off step subtracts $40 a turn.
  - Byte 6, bits 6-7: STATS_RAISED and STATS_LOWERED. They are set through SetSlotStatus6Bit6/7 by Speed, Upper, LushLicks and UltraDown, and DefeatTarget resets AGL and DEF when either is set.
  - Byte 7:
    - bit 1, DAMAGE_X10: the damage message step multiplies the damage by 10;
    - bit 3, DAMAGE_DOUBLED.
  - Byte 8:
    - bit 0, LOVE_RAIN_FORCED (forced action $CF);
    - bit 1, LOVE_RAIN: set by ActionEffect_LoveRain; forcing it shows 'A gentle rain fell!'.
  - UNUSED_* (2.4, 7.4-7.7, 8.2, 8.3, 8.5): no static reader or writer was found, and forcing them showed no new battle text.
  - Open contradiction: the damage message step doubles the damage for byte 7 bit 0, which E-0339 named GUARD because Guard sets it. One of the two readings is incomplete.
- **Story flags**: 347 named, and no flag number is left in a flag operand.
  - Rules added to name_story_flags:
    - a setter whose routine name says nothing is described by the last message its routine shows before, or just after, setting the flag;
    - a setter inside a script uses the script's name;
    - DE loaded as two bytes (`ld e` / `ld d`) counts as a setter and is written `LOW(EVENT_X)` / `HIGH(EVENT_X)`;
    - a flag with no setter is named after its first tester that says something; its constants.inc comment says "no setter found; tested by" (34 flags);
    - an `objsel_unless_flag` in a listed ObjSelector_MapXX selector names a flag MAP_XX_OBJECT_REMOVED.
  - config/story_flags.json holds 11 names read by hand. Among them:
    - EVENT_NEVER_SET for flag 0, which about 20 routines test and no code sets;
    - the Found-Me foe flags $B9-$BB and $201, which SceneFoundMeBattle_SetFlagBit sets from the map screen;
    - EVENT_STAFF_ROLL_PARTY_SAVED ($19F).
  - The pass now runs after the final naming passes, so scripts and selectors carry their names when it reads them.
- **Unlisted object selectors.** 252 selectors and object lists found by tiling a gap were numbered `ObjSelector_N` / `MapObjects_N`. A selector is now named after the listed selector just before it (ObjSelector_Map94_3_Unlisted), and its lists follow (MapObjects_Map94_3_Unlisted_0). The flags above support the placement: the foes of ObjSelector_Map94_3/4/5_Unlisted are the Found-Me foes of map screens 0-2.
- **Scripts without a message.** These are named by their jump target (Script_ToWhatWouldYouLike) or by their first command (Script_Encounter). No `Script_N` is left.
- **Table labels.** The 299 labels in config/tables.json that still spelled an address now hold the emitted names.
  - The encounter and key-world families were shortened: EncounterGrid_13, EncounterGroup_Grid13_104, EncounterGroup_Direct2 and KeyWorldObjectList_0_0_1, from RunBattleIntroKindCase_ReadMapIdAndPlayerStateFlags_EncounterGrid_13 and similar.
  - Tests that named old labels follow the new names: Text_ strings, Talk_ListenYouTwoQuitYourHorsing and ListRecordsInUseEggs.
- Binary verification: build/run526 PASS, 0 differing bytes. Full suite: 278 tests OK (3 skipped).

### E-0345 — RAM bytes named from their users

- Kind: READING (C1).
- 102 RAM bytes that still spelled a byte number (wArenaByte37, wScreenByteBD and others) are named from the routines that read and write them. Each entry in config/symbols.json says "named from its users; was X".
- Bytes that different routines reuse for different values get the name of their main use. The note lists the other users.
- Collisions:
  - $DAE8 is wCommandEntryMonster, because wCommandMonster already existed.
  - $FF80 is hOAMDMARoutine, the HRAM copy of the OAM DMA routine.
  - $FFF8 is hUnusedTail.
- Notes in config/names.json that used the old names now use the new ones; a former name may stay after "was".
- RAM names that spell a byte number: 0 of 958.

### E-0344 — Data and address naming passes; configured names without addresses

- Kind: generator naming rules (structure, C0 to C1 by rule), with readings where noted.
- **name_data_by_reference.** A data label still named by its address is named in this order:
  1. by its content: a script by its first message or scene command, a string by its words;
  2. by its first referrer: an id entry of a top table (Script_Map30), an entry of a named block, or `<Routine>_<Kind>` for the routine that loads it.
  - Meta-sprite tables become table ordinals.
  - What only computed pointers reach is numbered within its kind.
- **strip_address_tokens.** A ROM address kept in a name only to tell copies apart is dropped; copies are numbered _2, _3 in address order.
- **resolve_embedded_addresses.** An address inside a name becomes the name of the label there. When that label has no name, the kind word stays (StartScript5709 becomes StartScript...), and a Func address is dropped.
- **strip_structural_tokens.** The _CaseNN, _SubNN and _TableN parts of a described step are dropped.
- **Copies of library routines.** A second copy in one bank is now `Name_BankBB_2`, not `Name_BB_AAAA`.
- **config/names.json.**
  - 427 configured names that spelled an address were rewritten to the names the passes emit. Each note says "was X".
  - The address passes skip configured names, so the config and the listing agree. tests/test_generated_source.py checks this.
  - Edits by reading:
    - 44 TalkScript_N routines are now named after the script they start (Talk_BreedFade, Talk_HealParty);
    - 14 names that the passes had built from the routine's own data label were shortened;
    - 8 trailing prepositions were removed.
  - CheckWarpsByMapType_RunThreeWarpChecks and CheckWarpsByMapType_KeyWorldGoalWarp were named by reading.
- **Tests.**
  - Event-script and pointer-bank tests check structure instead of address names.
  - The global name-claim test follows a step into a numbered copy of itself (X calls X_2) and reads the whole step.
- Labels: 33,212.
  - Address or structural tokens: 0.
  - No description beyond their structure: 0 (tools/readability.py).
- Binary verification: build/run523 PASS, 0 differing bytes (before E-0346).

### E-0343 — Completion flag, item use message, packing and key-world generator bytes

- Kind: READING (C1).
- **The game-completed flag.**
  - $C837 is wGameCompleted (was wArenaByte37). SceneHomecoming_ShowTHEEND sets it to 1 when the ending shows "THE END".
  - It is saved at $BD3A, sSavedGameCompleted (was sSavedArenaByte37).
  - The title summary copies it to $D10A, wTitleGameCompleted (was wTitleByte0A).
  - The TinyMedal prize menu and script command $F3 read it.
- **The item's use message.** $D08E is wItemUseMessage (was wItemRecordByte0A). It holds item record byte $0A, which the ItemUsable_* routines write. It is copied to wStringIndex or wItemMessage when the item is applied ($FF none), and the field skills reuse it.
- **Record packing.**
  - $D7E1 is wPackFieldIndex (was wPackByteE1): the record field PackRecordFieldsToBank1Slot is packing.
  - $D7E6 is wPackValue (was wPackByteE6): the value put into a 2-bit field.
- **Key-world generator.** $CC46 is wKeyWorldGenRoom (was wKeyWorldByte46): the room index into wKeyWorldRoomTable while the debug automap generates a key world.
- RAM names that still spell a byte number: 104 of 958.
- Binary verification: build/run508 PASS, 0 differing bytes.

### E-0342 — Interrupt handlers; jump-table entries named after their id

- Kind: READING and a generator naming rule.
- **Interrupt handlers.** The serial and LCD STAT vectors jump to code that was named as branch targets inside another routine. They are now named:
  - SerialInterruptHandler (00:$255B, was ComputeSpriteScrollOffsets_Skip): it saves the registers, runs RunLinkSession and returns with reti.
  - StatInterruptHandler (00:$256A, was ComputeSpriteScrollOffsets_Skip2): with WRAM bank 0 mapped, it runs the split chosen by wSTATSplitEnable & 3, and its cases write SCX or SCY and LYC.
- **Indexed jump tables.** config/indexed_dispatch.json lists jump tables indexed by an id. In such a table, an entry that only one id reaches is named <name>_<Id> from that id's constant.
  - ApplyEquipmentEffectKeepA is called with the item id in A and jumps by A - $40 (E-0122, E-0259).
  - So 13 equipment cases are named after their items: ApplyEquipmentEffect_VITbelt, _DracoBelt, _MagicBelt, _StoneFang, _MermScale, and so on.
- **Script loads.** Every `ld hl, Script_X` that starts an event script now carries the script's first message as a comment (`ld hl, Script_4F54 ; script '*: Heh, so these are the'`). The step-naming rule of E-0340 then reads it too. Undescribed labels number 177 and labels with a structural part 3,887.
- **Tests.** tests/test_constants.py checks that each ApplyEquipmentEffect_<Item> sits at entry item - $40, and tests/test_generated_source.py checks the script comment.
- Binary verification: build/run507 PASS, 0 differing bytes.

### E-0341 — Shorter step names; battle scratch and item bytes

- Kind: READING and generator naming rules.
- **Step names.** name_steps_by_text (E-0340) now runs in two places:
  - right after the idioms are folded, before branch targets are named after the routines they call, so those local labels see the final names;
  - again at the end, only for labels no instruction calls (jump-table steps).
- **Name forms.**
  - A described step is named <routine>_<description> when that name is free (RunLinkSession6Exchange_ClearAndDrawListEntriesCell5NameAtTiles1780). Otherwise it keeps the full structural chain before the description.
  - A call description takes the first non-generic routine among the first 12 instructions. That routine must not be a sibling in the same family, an address name, or another label still to be described.
- **Counts.** 803 steps are described. Undescribed labels number 189, and labels with any structural part 3,927, down from 4,384.
- **RAM read.**
  - $D87A/$D87B are wBattleTempPtrLo/Hi: a scratch pointer kept by RunBattleCommandEntry (into wBattleTempBuf) and CopyBattlerNameToHL.
  - $D87C is wBattleTempSlot.
  - $D87D is wBattleTempBuf, an 18-byte scratch buffer: RunBattleCommandEntry clears it, and the battle end keeps two words in it. Its bytes $D87E-$D880 are now offsets into it.
  - $D893 is wBattleItemId, the item chosen in battle. It comes from wItemId, and RunBattleActions_UseItem makes it the action id, so its comparisons use ITEM_* names.
  - $D892 is wBattleItemTarget: $FF none, $10 and $20 groups, otherwise a slot in bits 0-2.
- **Tests.** tests/test_step_names.py reads each description from build/listing/step_names.json (old → new). It checks that a Set/Advance description writes its variable and that a routine description is called. tests/test_name_claims.py still checks every rule-made name and local label.
- Binary verification: build/run503 PASS, 0 differing bytes.

### E-0340 — Names without addresses; structural steps described

- Kind: READING and generator naming rules; no new behavioural claim beyond the RAM readings below.
- **Addresses inside names.** 130 names in config/names.json and 7 family names in config/name_families.json spelled a RAM address (StepPlayerDownTowardWC928, FillWC278WithC3). The address is now read as its RAM name:
  - the symbol itself (wStepPtrLo → StepPtrLo);
  - inside a monster-record buffer, the MON_ field (wRecordBufB + $0B → RecordBufBSpecies);
  - inside a screen buffer, its row and column (wScreenTileBuffer + $E0 → ScreenTileBufferRow11Col4);
  - otherwise the buffer and offset (wLinkRules + 1 → LinkRules1).
  - Each changed entry's note keeps the old name ("was ...").
- **Structural steps.** tools/disasm_all.py's last naming pass, name_steps_by_text, gives a label whose name is only structural (Parent_Case05, Parent_Sub01_Table2_Case00) a description from its body, in this order:
  - the first words of the first string it shows;
  - the first routine it calls that is not a generic helper and not already in its name;
  - its first write to a named RAM byte (Set<X>, or Advance<X> for `ld hl, wX` / `inc [hl]`).
  - 761 labels are described this way; build/listing/step_names.json records them. Labels with no description at all fall from 790 to 235 (tools/readability.py "undescribed_labels").
- **RAM read.**
  - $C836 wInventorySortFlags (was wGameFlags836): bit 0 the sort table, toggled by SortInventory; bit 7 keep the order; bit 6 an item was added or changed (AppendItemWC928ToInventory, CheckItem, the treasure events); bit 1 the plan list's order.
  - $DABA wMultiHitCount (was wDefeatFlagsBA): RollRepeatCountForAction rolls 1-4 hits into bits 0-6 with bit 7 set, and RunMultiHitCounter counts down.
  - $D7B2/$D7B3 wReturnScreenState/wReturnScreenStep (were wScreenByteB2/B3): the record-list menus save the state and step to return to after a sub-screen and copy them back.
  - $C83C-$C83E wLogTwigKeyWorldGoal, wLogTwigKeyWorldGoalCell and wLogTwigKeyWorldKey: the Log Twig saves those key-world bytes, and the field return phase compares them back.
  - Menu work bytes such as wScreenByteBD-$C1 hold different things in different menus (a price's digits in the shop, an SRAM bank and address in hibernation), so no single name fits; they keep their byte names.
- **Tests.** tests/test_step_names.py checks every recorded step name against its body: a Set<X> or Advance<X> step writes or advances X, and a routine-name step calls that routine.
- Binary verification: build/run497 PASS, 0 differing bytes.

### E-0339 — Battle status bits, story flags, field states and the world map

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware; battles forced through the debug menu as in E-0332, the field by location pokes as in E-0321), plus READING and a naming DECISION (D-009).
- **Battle status bits (C2 where forced).** tools/status_check.py sets one bit of a status byte (wBattleStatus ... wBattleStatus8, stride 9) for all eight slots whenever an action starts resolving or the turn's status checks run. It records the bank-$2F battle texts looked up, against template 95, and compares them with an unforced battle; all 72 bits were run.
  - Bits with texts of their own:
    - byte 0: bit 0 poison ("suffers from poison"), bit 1 bad poison ("wracked by poison", "dropped dead"), bit 4 confusion ("snapped out of confusion"), bit 5 curse ("is cursed! can't move"), bit 7 sleep ("woke up!");
    - byte 1: bit 3 critical hits;
    - byte 3: bits 0-6 frozen, dancing, tripped ("can't get back up"), shivering, cowering, vacant, airborne ("fell out of the sky");
    - byte 5: bit 5 LifeSong ("song ended", "came back to life"), bits 6-7 Ironize ("a hunk of iron");
    - byte 6: bit 3 "struck back", bit 5 "shunted the attack";
    - byte 7: bit 2 counterstrike;
    - byte 8: bit 4 SealPray ("SealPray was broken!").
  - Bits named by the one skill whose effect routine sets them (tools/status_bits.py; the skill of each routine is C2 from E-0333):
    - StopSpell, BeDragon, Transform, DanceShut and MouthShut in byte 1;
    - AquaWall and TailWind in byte 2;
    - ChargeUp, SuckAir and Focus in byte 4;
    - SuckAll, Berserker, Imitate and Dodge in byte 6;
    - Guard in byte 7;
    - SealPray, MagicWall and EerieLite in byte 8.
  - The bits are kept in config/battle_status.json. src/constants.inc defines them as BSTAT<byte>_<NAME>, and 112 `bit/set/res N, [hl]` on a status byte use them.
- **Story flags (D-009).** 229 of the 330 flags the code sets or tests are named EVENT_<what the first setter says>. The setter is the routine or script that calls SetFlagBit or `script_set_flag` with the flag:
  - a talk routine's message (EVENT_THANKS_FOR_COMING_BY);
  - a scene (EVENT_SCENE_MERMAID_KINGDOM);
  - a talk event's shown words;
  - inside a script, its last scene command (EVENT_SCENE_VAULT_SETTLED) or message before the flag is set ("0" in a quote reads HERO).
  - Each constant's comment names its setters. 1,150 uses in code, scripts and object selectors use them; flags only tested, or set by routines whose names say nothing, keep their numbers. The names say who sets a flag, not what it means for the story (C1 for meaning).
- **Field states.** The nine states of FieldModeStateDispatch (wModeState) are named from what each runs:
  - FieldState_WalkATalks (A checks in front) and FieldState_WalkAMenu (A opens the field menu);
  - FieldState_RunScript, FieldState_Still, FieldState_BattleTransition and FieldState_MapTransition;
  - FieldState_FieldMenu, FieldState_StepChecks and FieldState_WorldMap.
  - Their shared A-button helpers are now CheckTileInFrontOnA, CheckTriggerCellOnA and CheckMapInteractionOnA.
- **World map (C2).** From the desert party of E-0321, moved to map $30, Select switches wModeState to 8. The world map appears showing the Water region (pictured with tools/screen.py), $C5DD becomes 2 and $C944 becomes 1. B does nothing as a control.
  - TryOpenWorldMap (was FieldModeStateDispatch_WriteTemp0AndGameMode2Byte44Etc) stores a region by hMapId band.
  - Renames: $C944 is wWorldMapRegion (was wGameMode2Byte44), $C5DD wWorldMapState (was wGameMode2State), and RunGameMode2State is RunWorldMapState.
- **Tests.**
  - tests/test_story_flags.py checks that every EVENT_ constant is set under its name, that every `ld de, EVENT_` feeds a flag routine, and that every BSTATk_ use sits on status byte k. It also forces sleep, frozen and Ironize in a battle and finds their texts, absent without the bit.
  - tests/test_world_map.py checks the world map opening, with the B control.
- Binary verification: build/run489 PASS, 0 differing bytes.

### E-0338 — The 27 resistances, named by the skills that read them

- Kind: READING of bank $36's effect helpers and bank $19's PackResistanceFieldsToDE, plus a TOOL check.
- **Packing.** A monster record keeps 27 resistance levels, one byte each (MON_RESISTANCES at $73, copied from SPECIES_RESISTANCES). PackResistanceFieldsToDE packs them into a battle slot's 7-byte record in wSlotResistances:
  - index 26 goes in byte 0 bits 7-6;
  - indexes 0-2 go in byte 0 bits 5-4, 3-2 and 1-0;
  - from index 3, four per byte, bits 7-6 first;
  - byte 6 bits 1-0 stay 0.
- **Readers.** Each effect helper loads one byte (GetTargetSlotResistancesByteN), isolates a 2-bit field with rotates and `and $03`, and scales damage or rolls a chance by it. The skills whose effects do so are C2 from E-0333 (which routine runs for which skill). They name the 27, in record order: Blaze, Firebal, Bang, Vacuum, Bolt, IceBolt, Radiant, Sleep, Beat, RobMagic, StopSpell, PanicAll, Sap, Slow, Sacrifice, MegaMagic, FireAir, FrigidAir, PoisonGas, PalsyAir, Curse, LegSweep, DanceShut, MouthShut, RockThrow, GigaSlash, Watershot. Each name is the skill, or the first of several, whose effect reads the field:
  - Blaze reads index 0 (byte 0 bits 5-4), Firebal index 1, Bang index 2;
  - Watershot and Geyser read index 26;
  - FireSlash, VacuSlash, BoltSlash and IceSlash read the same fields as Blaze, Vacuum, Bolt and IceBolt;
  - Ahhh, LegSweep, LureDance, LushLicks and WarCry share index 21;
  - GigaSlash and actions $D2-$D5 share index 25.
- **Names.**
  - src/records.inc gains RESIST_BLAZE ... RESIST_WATERSHOT (0-26) and NUM_RESISTANCES, from config/record_fields.json.
  - 23 helpers are renamed from their byte and bits to their resistance: RollVsSleepResistance, ScaleDamageByVacuumResistance, AttackDamageScaledByBlazeResistance, SkillDamageScaledByGigaSlashResistance, and so on.
  - GetTargetSlotResistancesByte6_ReadBattleTarget is now GetTargetResistanceByte.
  - wSlotResistances's note lists every field.
- **Confidence.** C1 for the names as game meaning: a field is named by the skill that reads it, not by an observed in-game resistance screen. The field positions are checked mechanically.
- **Tests.** tests/test_resistances.py checks:
  - the packing formula;
  - that every `...<Name>Resistance` reader isolates RESIST_<NAME>'s packed field (17 readers);
  - a control: with the names shifted by one index, the readers fail.
- Binary verification: build/run479 PASS, 0 differing bytes.

### E-0337 — Personality acts and the target's reactions in battle

- Kind: READING of banks $30, $32, $36 and $3A plus EMULATION (tools/sm83.py, our own emulator; not checked against hardware). The battle is forced through the debug menu, as in E-0332, with template 95.
- **Personality acts.** $D854 holds a word per battle slot; both battle set-ups clear it each turn. Eight roll routines in bank $30 OR one bit each into the low byte (RollPersonality* for three personality bytes, RollSlotTrait* for wSlotTrait): a "high" bit when the value is $80 or more, a "low" bit when it is below.
- **Forced in the emulator (C2).** tools/act_check.py ORs one bit into every slot's word before each routine that reads it, and records the category-0 battle texts looked up. With no bit forced only $03 "Monsters appear!" is looked up. Forced:
  - bit 0 brings $2E "struck at full power!";
  - bit 1 brings $2F "tucked tighter in fear!";
  - bit 2 brings $30 "concentrated!";
  - bit 4 brings $32 "Light fell softly on 0!";
  - bit 5 brings $33 "0 ducked behind G!";
  - bit 6 brings $34 "pumped itself up!";
  - bit 7 brings $35 "rolled out of the way!", and $2E.
  - Bit 3 showed no text in this battle.
  - Bits 1, 2 and 4 also brought $14 "is confused!", which is recorded, not explained.
  - $D854 is renamed wPersonalityActs (was wSlotFlags854).
- **The target's reactions (reading, C1).** ResolveTargetReaction, case 0 of ResolveStepTargetAndSubEffects (36:$407F):
  - A target that inhales attacks takes the hit ("0 inhaled the attack!"): $DAB2 is renamed wAttackInhaled.
  - Otherwise bits 7, 4 and 6 of the action's record byte 5 pick one of four routines:
    - TryShuntOrGuard: "failed to reach", an ally's guard, or a shunt when the duck act is set, to PickShuntSlot's slot;
    - TryWindBounce: "The wind around 0 bounced the attack!";
    - TryWallOfLightBounce: "The wall of light bounced the spell!";
    - CheckTargetOutOfReach.
  - TryAllyGuard moves the attack to a guarding ally (text $CA "0 guarded G!").
  - A bounce turns the action back on the actor (TurnActionBackOnActor). It saves both slots' state, swaps actor and target, and ORs 1 (wind) or 4 (wall) into wFollowUpAction.
  - RAM renamed: $DAD1 wOriginalTarget (was wDefeatByteD1), the slot first targeted. $DABF wRedirectFlags (was wDefeatByteBF): bit 0 a shunt, bit 1 a guard. $C981 wAttackDeflected (was wResolveByte81), 1 after a bounce or guard. $C971 wDuckBehindSlot (was wResolveByte71), the ally named by text $33.
- **Tests.** tests/test_act_check.py checks that no act text appears without a flag, and that bits 5, 6, 7 and 2 each bring their own text and no other act's.
- Binary verification: build/run477 PASS, 0 differing bytes.

### E-0336 — The text printer's commands; text in source as charmap tokens

- Kind: READING of bank 0's text printer (00:$2620-$2D33) plus EMULATION (tools/sm83.py, our own emulator; not checked against hardware) of a farmhand's conversation (state s13 of E-0320) and a debug-menu battle (d06!, forced).
- **The printer.** Each frame, StepTextPrinter (was StepStringDisplayUntilDone) runs PrintTextStep (was ..._AddHLToTextCursorTextCursorLo) with the string's bank mapped. It waits on a sound, a choice, a button, a delay or a timeout. Otherwise, once wTextGlyphTimer reaches the text speed, it takes the next byte:
  - a glyph is drawn (DrawTextGlyph);
  - $8D/$8E marks go to CallFunc28BDInBank1F;
  - bytes $E0-$FF go to RunTextCommand, which jumps to entry byte - $E0 of a 32-entry table.
- **The 32 commands** (each handler read; names in tools/gb_text.py TOKENS and src/charmap.inc):
  - $E0-$E4 play a sound effect and wait until every channel is idle; $E5 the same for music.
  - $E6, $E7 and $FF open the yes/no choice (OpenTextChoice, was AcknowledgeTextPrompt), with the cursor on yes, on no ($E7) or without the confirm sound ($E6).
  - $E8 x, y moves the glyph cursor; $E9 id plays a sound without waiting ($FF restarts the map music).
  - $EA and $EB turn the speech beep on with sound $6B or $6A; $FD and $FE turn it on and off.
  - $EC pauses for a time from the text speed: 6, 12, 20, 26, 32, 40 or 48 frames from the table at $2A66, or a button at speed 7.
  - $ED prints at once until a wait; $F4 ends that and $F5; $F5 prints without the per-glyph wait.
  - $EF $EE is the next line: on the first line $EF moves to the second and skips the $EE; on the second it scrolls the line up, waits 4 frames, and $EE clears the new line.
  - $F0 ends the text, or an inserted text (back to the saved position).
  - $F1 starts the next line without scrolling; $F2 clears the window (FillTilesFromRequest fills it with the blank pattern at $2940) and goes to the first line; $F3 goes to the first line.
  - $F6 prints the player's name; $F9 n prints the $F0-terminated text at wTextBuf0 + n.
  - $F7 waits for a button; $FA shows the blinking arrow (tiles $BD/$B4) while it waits.
  - $F8 n sets frames per glyph; $FB n waits n frames or a button; $FC n waits n frames.
- **Observed (C2).**
  - Glyphs printed back to back come wTextSpeed frames apart, sometimes one more: speed 0 and 1 give 1-2, speed 2 gives 2-3, speed 6 gives 6-7.
  - The printer stops at $FA $F7 and holds for 200 frames without input; after A it goes on.
  - $EF is followed by $EE 4 or more frames later.
  - In the battle, 29 inserts at offsets $00 and $10 printed exactly the text in wTextBuf0 and wTextBuf1 at that moment. Where the other slot held different text, the glyphs never matched it.
- **RAM names.**
  - $C964 is the text speed: renamed wTextSpeed (was wBattleKindFlags). A new game sets 1, battle set-up copies $C834 into it (3 in a link battle), and battle end sets 1 again.
  - $C834 is renamed wBattleTextSpeed (was wMenuSaveByte34). It is C1: probably the battle message speed setting; a new game sets it to 4.
  - $C54F is renamed wTextGlyphTimer (was wTextLineCount). It counts frames since the last glyph, not lines.
- **Glyphs from the font** (bank $1F, 8 one-bit rows per glyph at $4010 + 16 * glyph, the odd bytes): $A4 is "…" (952 uses in text), $A0 "(", $A1 ")", $A2 "+", $9D "~", $9E "/", $AC "★", $B8 "©" (C2). Icon glyphs ($50-$5D, $44, $9F) stay $XX.
- **Source.** tools/gb_text.py renders text with these tokens: `db "<VOICE1>Cobi: <BUF0>!<LINE>"`, `db "Blaze@"`, with an argument byte as `$xx` after its token. Pairs come first (<NEXT>, <PROMPT>, <BUF0>-<BUF3>, <MAP_MUSIC>). A line starts before <NEXT>, <CLEAR> and <HOME>, and ends after <LINE>, <WAIT>, <PROMPT>, @ and a choice. Bytes are unchanged (render and parse round-trip).
- **Tests.**
  - tests/test_text.py checks the tokens, pairs, arguments and line breaks, and that every byte $E0-$FF has exactly one token and no character shares one.
  - tests/test_text_check.py (about 2 minutes) checks the glyph timing per speed (with a fast/slow control), the wait, the <NEXT> pause and the inserts (with the other-slot control).
- Binary verification: build/run475 PASS, 0 differing bytes.

### E-0335 — Cobi's monster swap: drop off and pick up

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced: Script_1F_5A3A is started by its RAM bytes on Main Street.
- **The menu.** Drawn with the per-scanline renderer of E-0328, the menu reads Drop off / Pick up / Check / Release / Exit. E-0331's picture had hidden most of it.
- **Drop off.** Choosing Patta and OK runs SwapMonstersMenu_MoveRecords_StoreTemp0BytesToSRAMRecord. Her MON_STATE goes from 2 to 1, and the party list then shows Vanyl and Moahm.
- **Pick up.** It lists the state-1 records (ListRecordsState1ThenContinue). Choosing Stera and OK turns her MON_STATE from 1 to 2. Both writes agree with MON_STATE's meaning (E-0320).
- **Reproduction and tests.** tools/recipes/e0335_swap.txt includes e0334_keys.txt. tests/test_play_chain.py checks the five record states after each step.
- Binary verification: build/run470 PASS, 0 differing bytes; tests OK (235, skipped=3).

### E-0334 — A Magic Key appraised: the key list's entries

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced.
- **A key.** GenerateNewKeyEntry, called at the main loop's halt on Main Street as a reward event would call it, writes the entry $FE, $06, $25, $0D to wKeyList, which was empty.
  - The debug battle set-up's DebugBattleSetup_Update_FillKeyListFromTable copies $80 bytes of $FF into the list, so it empties it rather than filling it. The list reads $FF throughout after it. It is renamed DebugBattleSetup_ClearKeyList.
- **Appraisal** (Script_0D_62B8 by its RAM bytes). KeyAppraisalMenu lists the key (KeyAppraisalMenu_ChooseKey_*) and asks for confirmation. It charges 140 gold (99,999 to 99,859) and saves (KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_7347).
  - It shows "I got it! This is the WhiteMtn!" (WriteKeyNameToDE, CopyKeyNameWordToDE).
  - The entry becomes $00, $06, $25, $0D. So byte 0 is $FE for an unappraised generated key and 0 once appraised. Bytes 1 and 2 pick the name's words, word (byte 1 + 1) = "White" and word (byte 2 + $11) = "Mtn" of the list at 09:$4078, as E-0090 read (C2).
  - With no key, KeyAppraisalMenu_HasAnyKey ends the script at once.
- **Reproduction and tests.** tools/recipes/e0334_keys.txt includes e0331_hibernate_medals.txt. tests/test_play_chain.py checks the entry before and after, the 140 gold, and the two words from the ROM.
- Binary verification: build/run469 PASS, 0 differing bytes; tests OK (234, skipped=3).

### E-0333 — Battle action effects follow the skill the battle text names

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware) and TOOL, forced through the debug battle as in E-0332.
- **The check.** tools/effect_check.py reads wBattleActionId at each DispatchActionEffectTable (36:$6717) and pairs it with the next ActionEffect_* routine that starts. It keeps the skill-name lookups (bank $08, category 4) made since the previous dispatch.
- **What a battle turn shows.** For a skill, the battle text first looks up that skill's name, and then the dispatch runs with wBattleActionId equal to the same number: (8, 4, 120) PaniDance before action 120, (8, 4, 72) WindBeast before 72, (8, 4, 49) TakeMagic before 49.
  - The routine that runs is ActionEffectTable's entry for the id. Its name is the first skill that uses it (ActionEffect_PanicAll for 52 PanicAll, 120 PaniDance and 173), so wBattleActionId is the skill number of the action (C2).
  - Action 0 runs on turns whose text names no skill. It is the plain attack, so ActionEffect_Action00 is renamed ActionEffect_Fight, matching AIScore_Fight (C2).
- **Result.** Over 14 templates there are 161 effects through 15 routines and no mismatch (16 skill uses had their name shown; the rest are attacks and repeated targets).
- **Tests.** tests/test_effect_check.py runs three battles (about 110 s) and checks:
  - no mismatch;
  - a control: a shown skill name is rarely the id of the next different action.
- Binary verification: build/run468 PASS, 0 differing bytes; tests OK (233, skipped=3).

### E-0332 — The AI's per-skill scoring routines, checked in battle

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware) and TOOL, forced through the debug battle.
- **Varying the foes.** The debug battle screen keeps its fields as words in wWorkBuf. +$0 is the foe count and +$2 the first "Monster" row, a MonsterTable template id: the foes of the first debug battle were Slimes, template 1. +$C and +$E are the first Species and Level rows.
  - Writing +$C/+$E changed nothing in 25 battles. Writing +$2 changes the foes.
  - A sweep over templates (every sixth id) adds several hundred named routines (build/states/coverage.json; not pinned).
- **The check.** tools/ai_check.py records the skill number in A at each call of ScoreSkillForAI (30:$4BA0) and pairs it with the next AIScore_* routine that starts. Each pair must match two things:
  - the ROM table that ScoreSkillForAI indexes (AIScoreRoutineTableA or B, three bytes per skill);
  - a skill held by some battle slot in wBattleSkills (8 slots of 16 bytes, skills at even offsets).
- **Result.** Over seven templates there are 550 calls to 25 routines and no mismatch.
  - My first version took the held skills from the battler records' four BATTLER_SKILLS. That missed skills such as BigBang, FireAir and DeMagic, which are in wBattleSkills, so wBattleSkills is the list the battle uses (C2).
- **Fight and Guard.** Skills 0 (no name in the skill table) and $AC ("Guard") are scored on every monster's turn although no record holds them, as the Command menu offers Fight / Skill / Guard. So skill 0 is the plain attack, and AIScore_Skill00 and its conditions are renamed AIScore_Fight and AIScore_Fight_Conditions (C2).
- **Tests.** tests/test_ai_check.py runs three battles (templates 95, 295, 370; about 110 s). It requires no mismatch and more than 10 routines, and has a negative control: a routine paired with a random other skill is that skill's table entry less than 15% of the time.
- Binary verification: build/run467 PASS, 0 differing bytes; tests OK (231, skipped=3).

### E-0331 — Hibernation, TinyMedals, key appraisal and the swap menu; two RAM names corrected

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced: each script is started by its RAM bytes on Main Street.
- **Hibernation** (Script_1D_4335). HibernateMenu lists the kept monsters (state 1). Choosing Stera and OK takes her full record out of the list; the 30 full records close up, one fewer in use.
  - A compact record appears at sCompactRecords ($B356, bank 0): $A0, $00, $03, then her name at bytes 3-7.
  - So hibernating monsters are kept as compact records there. The compact format's other bytes are not read here.
- **TinyMedals** (Script_0C_7BA9). MedalPrizeMenu shows "Medal: 80" for the word at $C838, and prizes priced in medals (MeteOrb 3, MadCat 3, …).
  - With a full bag it checks MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot and gives nothing.
  - With the last slot emptied, MeteOrb takes 3 medals (77 left) and item $1E (String_08_05_1E, MeteOrb) goes into that slot.
  - The debug battle set-up writes 80 there with its debug inventory. So $C838/$C839, named wArenaWinsLo/Hi from the drawing routine (E-0133), are the TinyMedal count. They are now wTinyMedalsLo/Hi, and DrawArenaWinsLoCountBoxAndStep is DrawTinyMedalCountBoxAndStep (C2).
- **An inventory slot with its own name.** $C632 was named wSaveByte32 ("save-data byte read by talk event 1/$19"). It is byte $15 of wInventory's 24 bytes, filled and shifted like the other slots in every bag listing of E-0322-E-0327, and the debug set-up writes it in sequence with the other slots. The symbol is removed, so the code reads wInventory + $15.
- **Key appraisal** (Script_0D_62B8). KeyAppraisalMenu runs KeyAppraisalMenu_HasAnyKey and the script ends at once; no key is held.
- **Swap** (Script_1F_5A3A). Ten scripts jump to this address with script_jump_data_bank. The last two words (ids 62, 63) of StringList_1F_5225, which E-0217 bounds by its lowest string, also point here, so the string pass had named it String_1F_00_3E. The script pass now replaces a String_ label at a script entry, as it did a Data_ one. SwapMonstersMenu lists the party. Its Info page shows "Base: ??? / Mate: ???" for a record whose parent species are $FFFF. No swap was completed.
- **Reproduction and tests.** tools/recipes/e0331_hibernate_medals.txt includes e0330_priest.txt. tests/test_play_chain.py checks the hibernation record move and the medal trade.
- Binary verification: build/run465 (renames) and build/run466 (the script label) PASS, 0 differing bytes; tests OK (229, skipped=3).

### E-0330 — The priest revives a dead monster: MON_STATUS bit 7

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced: Script_1F_77D4 is started by its RAM bytes on Main Street, with Patta's MON_STATUS set to $80 and MON_HP to 0 in cartridge RAM.
- **The menu.** PriestMenu shows Revive / De-Tox / Uncurse / Exit. Revive lists the party with a mark beside Patta (PriestMenu_PayForService_WriteMarkC0/C2) and asks "… 25G. Do you accept?".
- **Paying.** Yes takes 25 gold (99,999 to 99,974, PriestMenu_PayForService_SubtractArg1AmountFromGold) and shows "Please summon the soul of Patta!".
- **After.** Patta's MON_STATUS is 0 and MON_HP is 21, MON_MAX_HP. So bit 7 of MON_STATUS marks a dead monster, which the priest revives to full HP (C2).
  - InnMenu_RestoreParty, by reading, skips records with that bit set (E-0276).
- **Reproduction and tests.** tools/recipes/e0330_priest.txt includes e0329_library.txt. tests/test_play_chain.py checks the record before and after and the 25 gold.
- **The arena, observed but not pinned.** Script_0C_7A51 started the same way runs ArenaMenu, the arena rounds (ArenaRounds_*, ArenaGridBattle_*) and battles that do damage (Patta at 17 of 21 HP on the battle panel), with skill effects such as ActionEffect_CallHelp (Moahm's YellHelp) and BattleEnd_GainExperience_LearnSkill. After the first class the menu offers C, B, A and S classes at 100, 500, 1000 and 5000G. These steps are not in a recipe.
- Binary verification: build/run464 PASS, 0 differing bytes; tests OK (227, skipped=3).

### E-0329 — The monster library's counts per family

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced: Script_1F_787B is started by its RAM bytes on Main Street.
- **The screen.** LibraryMenu shows one family icon and count per line on two pages: 4, 2, 3, 1, 1, 1, then 2, 2, 5, 4, 0. The digits are tiles $E0 + d in column 7 of rows 1-11, and the page indicator is $E1 $BE $E2 ("1/2").
- **The model.** For each species id 0-372 whose wSpeciesFlags bit is set, add 1 to the family named by byte 0 of its SpeciesRecordPointers record. This gives exactly those eleven counts.
  - The list at wMonsterLibraryBuf, the routine's second source, is empty here, so only the flag source is confirmed (C2 for CountSpeciesPerFamilyFlaggedOrListed's flag path, wSpeciesFlags and LibraryMenu).
  - wWorkBuf ($D09D), where the counts are built, is reused afterwards. Its first two bytes no longer hold the counts when the screen is up, so the test reads the drawn digits instead.
- **Reproduction and tests.** tools/recipes/e0329_library.txt includes e0328_breed.txt. tests/test_play_chain.py compares the drawn digits on both pages with the model.
- Binary verification: build/run463 PASS, 0 differing bytes.

### E-0328 — Breeding, from the menu to the hatched child; shared script steps

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced.
- **Starting the breeding script.** A script outside bank $10 is started with five RAM writes: wDataBank, wScriptInDataBank = 1, wScriptPointerLo/Hi, wScriptStartRequest = $80, and wModeState = 1. FetchScriptCommand then reads through ReadWordFromDataBank.
  - Without wScriptInDataBank it reads bank $10 at that address and shows the opening narration. This confirms that flag's role.
  - Script_15_764B, started this way on Main Street, runs BreedMenu: Breed / Hatch / Exit.
- **Choosing.** Base Vanyl (Gulpple $92, family 4, ♂, level 14).
  - With the mate cursor on Patta (Dracky, family 3) the preview reads WingTree. On Moahm ($C2, family 5) it reads CactiBall.
  - Both previews run ComputeBreedingChild. wChildRecord's species is $90 and then $91.
  - Neither species has a rule list (BreedSpeciesRuleTable entries are BreedSpeciesRules000), so stage 4 decides: FamilyPairResultTable[4][3] = $0090 WingTree and [4][5] = $0091 CactiBall. So the base is parent A, the table's row (C2 for these entries).
- **The game's checks.** The two-choice result after a pick feeds the script's four-way branch: mate allowed / "You won't have a monster" / "That's too low in level" / "There's no potential mate".
  - My first attempt confirmed Patta at level 4 and got the fourth branch (wTwoChoiceCursor = 3). The message itself could not be seen then (see the screen picture below), so which rule refused her is not established.
- **Hatching.** "Hatching that will cost 20G." and "Should I hatch it too?" lead to BreedChildScene (script command $8D): the parents on the altar, then an egg, then name entry for a CactiBall ♀.
  - Named "AB", the child is a new record with:
    - species $91, family 4, level 1, MON_PLUS 1;
    - master = the user's name;
    - MON_PARENT1/2_SPECIES = $92, $C2;
    - MON_PARENT1/2_NAME = Vanyl, Moahm.
  - Vanyl's and Moahm's records are gone, and the list closes up (29 records in use, one fewer). MON_PARENT1/2_SPECIES and _NAME are C2.
- **Shared steps.** BreedChildScene's step table points at routines named LinkMessageEvent_* (for example LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03), because a case takes the name of the first table that lists it. LinkMessageEvent itself never ran here.
  - The generator now lists every table that uses such a step. For this one, five tables share it: LinkMessageEvent, NpcBreedWarp, BreedChildScene, BreedChildSprite and BreedFade.
  - Names are unchanged; only comments change.
- **The screen picture.** tools/play.py records the LCD registers of each scanline and tools/screen.py draws each line with them. So a text window placed by a mid-frame change now shows; the breeding messages were invisible before.
- **Reproduction and tests.** tools/recipes/e0328_breed.txt includes e0327_shop_inn.txt. tests/test_play_chain.py (about 190 s) checks:
  - BreedMenu ran;
  - the preview's species equals FamilyPairResultTable[4][5] read from the ROM;
  - the parents' records are gone and the child record has the fields above.
- Binary verification: build/run461 (shared-step comments) and build/run462 (notes) PASS, 0 differing bytes.

### E-0327 — A shop and an inn: prices, the gold cap, and resting

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced. tools/play.py `--call LABEL` (and `call:LABEL` in a recipe line) calls a routine at the main loop's `halt`, as a talk event would.
- **Finding the shop.** The shop script Script_6659 is reached from Script_5345 ("Welcome! How may I serve you today?"). That script is started by TalkMsg0035_TheKingIsTooLenientOn, a GreatLog townsperson, when story flags $25 and $CE are set. With only flag 2 the same person says "I am a dealer—a merchant who buys and sells useful items…" and no shop opens.
- **The shop.** With those two flags poked and the routine called on Main Street, ShopMenu shows Buy / Sell / Exit.
  - **Selling.** The sell list shows Herb 7G, LoveWater 37G, WorldDew 375G and Potion 150G. ItemValueTable holds 10, 50, 500 and 200 for those ids, and ComputeSellPrice multiplies by ShopPercentTable[wScreenTableIndex] (75: the talk routine sets the index to 0) and divides by 100.
  - **The cap.** Selling a Herb at 99,999 gold leaves 99,999 (AddArg1ToGoldCapped99999), while the Herb leaves the bag.
  - **Buying.** The buy list prices are the values themselves (Herb 10G, LoveWater 50G, Antidote 4G). Buying a Herb takes 10 gold (SubtractArg1AmountFromGold) and puts it in the free last slot.
- **The inn.** In the Kalka inn (map $22), "Welcome to our inn!" leads to InnMenu.
  - With Patta at HP 5/21 and MP 7/35, a stay costs 10 gold. It runs InnMenu_FadeOut, InnMenu_RestoreParty and InnMenu_Morning, and leaves 21/21 and 35/35.
- **Reproduction and tests.** tools/recipes/e0327_shop_inn.txt includes e0326_hp.txt. tests/test_play_chain.py (about 160 s) checks:
  - the price formula against the two tables;
  - the cap, the buy, and the bag changes;
  - the inn's restoration.
- Binary verification: build/run460 PASS, 0 differing bytes.

### E-0326 — The current HP and MP words, and the Herb

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced: one record word is written straight into cartridge RAM (tools/play.py `--poke sram+HEX=VALUE`) at the field menu of E-0321.
- **Why it was open.** In every screen of E-0320-E-0322 the two words of each pair were equal. Battles against the debug foes, even one at level 82, did no damage to the debug party.
- **HP.** With Patta's MON_HP ($5B) set to 5, INFO's stats page shows "HP: 5/21". So $5B is the current HP and MON_MAX_HP ($5D) the maximum (C2).
- **MP.** With MON_MP ($5F) set to 7, it shows "MP: 7/35". So $5F is the current MP and $61 the maximum (C2).
- **The Herb.**
  - On Patta at 5 of 21 HP, a Herb runs ApplyItemEffect, ItemApply_Herb, AddHLToRecordHPCapped, ConsumeSelectedItemByChance and CompactInventory. HP becomes 21 and the Herb leaves the bag, which closes up.
  - On Moahm at 50 of 138 HP it gives 89, inside the description's "30~40", and the maximum stays 138.
- **Reproduction and tests.** tools/recipes/e0326_hp.txt includes e0325_town.txt. tests/test_play_chain.py checks the two Herb results and the routines that ran. The two screen readings are recorded here with their recipe lines (hp01!, hp03!).
- Binary verification: build/run459 PASS, 0 differing bytes; tests OK (222, skipped=3).

### E-0325 — GreatLog's Vault, Egg Evaluator and Christener, and a battle-loop plateau

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced as in E-0321: the location bytes (screen 0,0, player $50,$70) with the party and story flag 2.
- **The Vault (map 8).** The clerk's talk (Talk0046_ThanksForComingBy …) runs VaultMenu: "Deposit: Item / Gold / Exit", G99999, "Qty:24".
  - The item list shows each distinct bag item once (ListDistinctInventoryItemsToItemGrid).
  - Depositing the first ($28) runs RemoveItemCountFromInventory. The bag loses it and closes up with a 0 at the end, and Qty becomes 23.
  - wItemStorage's first entry goes from 0, 0 to $28, 1, so its two-byte entries are item id then count (C2).
- **The Egg Evaluator (map $0A).** "Um… I'm the Egg Evaluator." leads to EggServiceMenu, which offers Evaluate / Bless / Exit.
  - Evaluate runs ListRecordsInUseWithByte6ESet and shows "Um… You don't have any eggs…". No record in use has MON_EGG set.
- **The Christener (map $13).** "Welcome. I'm the Christener." leads to RenameMenu and its name entry. BACK plus "A" turns record 0's MON_NAME from Patta into PattA.
- **A battle loop.** Repeated walking and fighting in the Desert world (f01!-f19!) adds about 150 named routines.
  - It also exercises releasing a monster when the list is full: DeleteSRAMRecordAndCompact runs, "… was set free" is shown, and naming the newcomer reuses the name-entry routines in mode 4. The game rejects the name "AAAAA" ("Sorry, that name can't be used.").
  - Then "Anvar joined the party." runs SetRecordState2ForB, which agrees with MON_STATE 2 meaning in the party.
  - The loop then plateaus at the same few monsters and AI paths. These steps are not in a recipe.
- **Reproduction and tests.** tools/recipes/e0325_town.txt includes e0323_save.txt. tests/test_play_chain.py replays it (about 135 s) and checks the vault entry and the bag, the egg listing, and the rename.
- Binary verification: build/run458 PASS, 0 differing bytes; tests OK (221, skipped=3).

### E-0324 — All 466 talk-message names checked by running them

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware) and TOOL.
- **The check.** tools/talk_check.py takes a field state from a recipe, replayed in memory: s26, the farm reached by play in E-0320, with nothing forced. For each TalkMsgNNNN_<words> routine (466 in banks $04 and $13):
  1. it runs to the main loop's `halt`;
  2. it clears the story flags, because the names quote the flag-clear path;
  3. it pushes the return address, maps the routine's bank and calls it;
  4. it runs frames until LookupString returns. The text the game looks up must begin with <words>; the "0" before a name is the hero insert and is read as Hero.
- **Result.** All 466 pass after ten names were corrected (below), which raises them to C2.
  - Messages from an overflow table (E-0243) come from bank $97/$98 string lists at String_97_474A_00_06-style labels, and messages that share a string carry the first one's number (TalkMsg0130 looks up Message_01_2E for index $30). So the label is not part of the check.
- **Ten names corrected.** Nine had been read in E-0268 before $42 was known as "'v" (E-0319), e.g. TalkMsg0327_InAllMyYearsIE is now TalkMsg0327_InAllMyYearsIve, and TalkMsg0402_YouEComeAllThisWay is now TalkMsg0402_YouveComeAllThisWay. TalkMsg0512_KamehaYo0Thanks is now TalkMsg0512_KamehaYoHeroThanks, the convention of the other names. Twelve quotes in notes that still showed the gap ("I e never") now read "I've".
- **Negative control.** Each name compared with the text its neighbour looked up passes 14 times in 466 (3.0%). Those are neighbouring messages that begin alike, such as "Hero peered into the vase".
- **Tests.** tests/test_talk_check.py runs the check (about 100 s) and the control (below 10%).
- **Other quote names, measured only.** `python -I tools/talk_check.py --quoted` applies the same call to the 201 other labels whose name ends in words from a quote comment in their first lines (…Show<Words>, …MsgNNNN_<Words>, TalkScriptNNNN_<Words>).
  - 57 look up their text.
  - 133 reach no lookup within 240 frames. These are mostly scene and event-table labels whose message waits for a scene engine that is not running.
  - 10 look up other text, and 1 runs into data. These are dispatcher cases and mid-routine labels entered out of their context.
  - This shows no wrong name, but it does not raise these names either, so they keep their confidence.
- Binary verification: build/run457 PASS, 0 differing bytes; tests OK (218, skipped=3).

### E-0323 — Saving and continuing: the checksums recomputed, the records round-tripped

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware). The party comes from the forced states of E-0321; the farm (map 0, MapItemUseFlags bit 4 set) is entered by the location bytes.
- **Recording the journey.** PLAN > Journal on the farm runs TestSaveForbiddenHere and SaveForbiddenHere (allowed), then PauseMenu_Plan_RecordJourney. It shows "Want to record your journey?" over the slot summary "Not in use." (LoadSaveFileSummary).
  - Yes runs the save: RunSaveGameSteps_7347, BackupRecordsToSRAMBank1, PackRecordFieldsToBank1Slot, ComputeSRAMBank1RecordChecksum, CopySaveBlocksToSRAMWithSum, SaveGM2TimerFramesBlockToSRAMBank1 and others.
  - It shows "Your progress has been recorded", and the slot summary becomes "Master: … 000:03", the three party monsters with their levels, and "MonsterFarm".
- **The checksums, recomputed from the cartridge RAM.**
  - SRAM bank 1: the little-endian word at sBank1Checksum ($BA73) equals (~sum + $4321) & $FFFF of the $29A × 10 bytes from $A06F, which end exactly at $BA73. VerifySaveBank1Checksum compares the same word.
  - SRAM bank 3: the word at $BFFE equals (~sum + $1234) & $FFFF of the bank's first $1FFE bytes, as VerifySaveBank3Checksum reads it. Bank 3 is all zeros here, so its checksum is $1233.
  - Both words were 0 before the save. The comparisons E-0109 had not read are now read and confirmed (C2).
- **Continuing.** A fresh power-on with that cartridge RAM (tools/play.py `--sram-from`, or `sram:STATE` in a recipe) shows the title logo. Its menu now offers CONTINUE, NEW GAME, BREEDING, KEY TRADE, VS MODE, DREAM EGG and TEAM MODE; with empty RAM it offered only NEW GAME.
  - CONTINUE shows the same summary and resumes on the farm (wGameMode 1, hMapId 0). It runs RunSaveSteps, RestoreRecordsFromSRAMBank1Backup, UnpackRecordFromBank1Slot and LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot.
  - All eight records come back byte for byte, except that each name keeps its letters and $F0 and pads the rest of its 10 bytes with $F0 (the debug-made records had $FF or $00 there). Gold, the bag and the map are kept.
- **Reproduction and tests.** tools/recipes/e0323_save.txt includes e0322_menus.txt. tests/test_play_chain.py replays it (about 105 s) and checks:
  - the save routines ran;
  - both checksum formulas against the saved RAM, with the words 0 before;
  - CONTINUE restores every record as described.
- Binary verification: build/run456 PASS, 0 differing bytes; tests OK (216, skipped=3).

### E-0322 — The field menu's four choices, the bag, an item, and saving refused

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), forced as in E-0321 (the Desert world, story flag 2).
- **The four choices.** The field menu's cursor is wMenuState: a tap of Right moves it from 0 to 1, and Down from 0 to 2. Its wMenuSubState runs the cursor's blink, so a single picture may not show the cursor.
  - Choosing enters game mode 2 with wModeState = the choice: 0 INFO (PauseMenu_Info), 1 ITEM (PauseMenu_Items), 2 SKILLS (PauseMenu_Skills), 3 PLAN.
  - PLAN shows Keys, Plan, Text Speed, Re-Order, Info and Journal. E-0046 had read state 0 as holding PLAN and state 3 as an item list, so PauseMenu_Main is now PauseMenu_Info and PauseMenu_State3 is PauseMenu_Plan, with their sub-routines (C2).
  - From the idle party window (shown when the player stands still), A selects the remembered choice at once.
- **The bag.** ITEM lists Herb, LoveWater, WorldDew, Potion on page 1 of 6, with "Restores HP of one monster by 30~40." (ShowSelectedItemDescription).
  - wInventory starts $01, $02, $03, $04, and String_08_05_01-04 are those four names. So wInventory holds item ids, which index category 5 of the bank-$08 strings (C2).
- **An item.** Use > Patta on the Herb runs PauseMenu_Items_UseItem_*, CheckItemUsable, ItemUsable_Herb and CheckRecordFlag55Bit7, and shows "… used the Herb on". With HP at its maximum the Herb stays in the bag.
  - The user's name prints as "ar'lh⌂", apparently overwritten by the debug set-up; this was not investigated.
- **Saving refused.** PLAN > Journal shows "You can't save here." It runs Func_003_6B5E, which far-calls Func_016_4645 (rule names Bank16Func4645ResultTest and …_ReadMapTypeAndEncounterRateEtc). These are now TestSaveForbiddenHere and SaveForbiddenHere.
  - SaveForbiddenHere returns C = 1 when saving is refused: when wMapType bit 7 is set, while wEncounterRate & $7F is non-zero; otherwise when bit 4 of MapItemUseFlags + hMapId is clear.
  - Here wMapType is 0 and hMapId is $20, whose flag byte $C0 has bit 4 clear. Bit 4 is set for all of GreatLog's maps $00-$1F and the towns $21-$26. So bit 4 means saving is allowed on that map (C2).
  - E-0229 had said a clear bit "gives C = 0" for this routine; it gives C = 1. The wMapType branch stays C1.
- **Reproduction and tests.** tools/recipes/e0322_menus.txt includes e0321_desert.txt. tests/test_play_chain.py replays it (about 95 s) and pins:
  - the four choices and their mode states;
  - the bag's item ids and names;
  - the Herb kept at full HP;
  - the refusal with its map flag.
- Binary verification: build/run453-455 PASS, 0 differing bytes; tests OK (214, skipped=3).

### E-0321 — A key world, random encounters, the field menu and the pause menu, played in the emulator

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware). Everything here is forced from the farm state of E-0320, so it shows what the code does, not how the story reaches it.
- **The location editor.** The debug menu's 2:EDIT screen ("? EDIT ?", DebugMapEditor_Init and DebugMapEditor_Update) shows WORLD, MAP X/Y and POS X/Y. On the farm these read MonsterFarm, 01, 02, 05, 05, while hMapId = 0, hMapScreenX = 1, hMapScreenY = 2 and hPlayerX = hPlayerY = $50.
  - So hMapId is the map number, named by system string 10 + number as E-0036 found; hMapScreenX and hMapScreenY are the screen within the map; hPlayerX and hPlayerY are pixels (POS is pixels / 16). All four are C2.
  - A copies wDebugValue0-3 and wDebugState into hMapId, hMapScreenX, hPlayerX, hMapScreenY and hPlayerY, then restarts the mode, so the screen is a teleport.
  - Stepping WORLD shows two more glyphs: $57 is a house (towns, "Asiya ⌂") and $5C a globe (worlds, "Desert ⊕"). They are not added to the character table.
- **A broken state, recorded.** Teleporting from the farm, where the save holds no monster yet, and then meeting a monster ends at an invalid opcode ($DD at 19:5FDC). Battle set-up reads garbage party records; IncrementTableByteCappedAt3 adds a byte from one of them to HL, writes into the stack, and a later `ret` returns into data. This is a state the game cannot reach, not an emulator fault.
- **The Desert world with a party.** From the debug battle (whose save holds the debug party), the location bytes are poked for map $20 and wGameMode = 1 is started.
  - Walking runs TickRandomEncounterCounter, then RunBattleIntroKindCase and RunBattleTransitionStep, and the game enters mode 4 against a CactiBall.
  - After the win, RunFieldReturnPhase_ResetLeadRecordFields55And5B runs on the way back to the field.
- **The field menu.** OpenFieldMenuOnA needs story flag 2 (bit 2 of wStoryFlags). With it set, A opens INFO / ITEM / SKIL / PLAN with "G99999" and the party window (ShowIdlePartyStatusWindow, BuildPartyStatusWindowRows, DrawGoldDigitsAtHLWrapped). wGoldHi:wGoldMid:wGoldLo is $01869F = 99999 (C2).
- **The pause menu is game mode 2.** INFO enters mode 2 (GameMode2_Update, PauseMenu_Main and its block loaders). E-0029 had seen mode 2 only as an incomplete status panel when forced.
  - The pages show Patta's level, sex, species, EXP (now 17), then ATK 26, DEF 11, AGL 42, INT 72, WLD 110, HP 21/21, MP 35/35, all equal to the record's MON_* words.
  - Then the skill page shows "Sleep" (ShowRecordSpeciesAndSkillNames, ShowSkillNameAtSlotB). MON_SKILLS holds $2F, $FF x 7, and $2F is String_08_04_2F, "Sleep", so MON_SKILLS is C2.
  - MON_SKILL_LIST holds $21, $2F, $32, the three natural skills of SpeciesRecord_Dracky (C1: the skills it can learn).
- **PLAN in battle.** In a second encounter, PLAN lists Charge / Mixed / Defense / Command per monster (RunBattleSetup_CommandMenu).
  - Command runs SetSlotTacticAndSlotLastTacticForCommandMonster and offers Fight / Skill / Guard.
  - Skill shows "Sleep" with "MP: 3" (ShowSkillPageNames).
  - The round then runs the command resolution (RunCommandEntryResolveStep_*, FilterSkillListByMP, AddPersonalityWeightToBattleArg0).
- **Not settled.** After that fight the SRAM records still hold full HP and MP (EXP rose from 17 to 18), so which word of each HP/MP pair is the current value is still open. The messages were skipped, so it is unknown whether Sleep was cast.
- **Reproduction and tests.** tools/recipes/e0321_desert.txt (which includes e0320_farm_battle.txt through `@`) holds the chain. tests/test_play_chain.py now replays it in memory (about 90 s) and pins:
  - the encounter routines and mode 4;
  - the field menu routines and the gold;
  - the pause menu in mode 2, the skill byte, the "Sleep" string and the natural skills;
  - the PLAN/Command routines.
- wGameMode's note now gives modes 0, 1, 2, 4 and 5.
- Binary verification: build/run451 (record and gold notes) and build/run452 (location notes) PASS, 0 differing bytes; tests OK (210, skipped=3).

### E-0320 — Played in the emulator: story scenes, the debug battle, and the monster record on screen

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), with TOOL changes.
- **The tool.** tools/play.py steers the ROM by an input recipe and saves the emulator state (a pickle in build/states, local only) plus a picture of the screen. The picture is now drawn with sprites (tools/screen.py).
  - Each run adds the named routines that executed, and the wGameMode values they ran in, to build/states/coverage.json.
  - `--poke SYMBOL=VALUE` writes a WRAM byte first. Such a state, and any state continued from it, is marked forced with a `!`.
- **Story, played by hand from power-on.** New game, default name "Cobi". On the ship:
  - talking to the mother runs TalkMsg000A_WellSoonBeReachingGreatLog;
  - talking to Papa shows Message_00_0B (he asks Cobi to stay with Tara);
  - talking to Tara starts SceneLandHo, which shows the island while SceneLandHo_ShowThisIsATale runs ("This is a tale of children who came");
  - on the farm, SceneHorsingAround and TalkScript5111_ListenYouTwoQuitYourHorsing run while "Quit your horsing around and go" is on screen.

  So these names given by reading agree with what the game shows when they run. No name of a routine reached in play contradicts its game mode. The only overlaps are generic words: "Slot" for sprite slots, "Field" for record fields, "Title" in LoadBattleMonsterPictureAndTitle.
- **The debug battle (forced).** wGameMode = 0 with wModeChangeRequest = 1 opens the debug menu (E-0029): GameMode0_Init, DebugMainMenu_Init and DebugMainMenu_Update run.
  - Its 6:BATTLE entry shows "? BATTLE ?" with No. foe, three Monster rows, Debug, Skill and three Species/Level rows (DebugBattleSetup_Init, DebugBattleSetup_Update).
  - With one foe, own monster 001 (Slime) and foe species 001 (DrakSlime) at level 5, Start enters wGameMode 4.
  - In mode 4 the game shows the FIGHT/ITEM/PLAN/FLEE menu. A FIGHT round runs the AI scoring (AIChooseActionForActor, AIScore_*, the AnyFoe*/Actor* condition checks) and the battle end (BattleEnd_GainExperience; BattleEnd_AskToJoin_ShowHeroGotUpLooking while "Slime♀ got up, looking hopeful." is on screen).
  - Forced from the title screen (frame 800), the same recipe runs 859 named routines by frame 2,680, 785 of them in mode 4, in about 9 s.
- **The monster record on screen.** The status page then shows a monster: Lv 25 ♂, ATK 84, DEF 149, AGL 115, INT 366, WLD 387, HP 156/156, MP 89/89.
  - SRAM record 0 holds exactly these at our MON_* offsets: name "Kheri" at $01, MON_SEX bit 0 = 0, level 25 at $56, and HP, max HP, MP, max MP, ATK, DEF, AGL, INT and WLD as words at $5B-$6C in that order.
  - Battler record 0 (wBattlerRecords, $D0D5) holds the same values at our BATTLER_* offsets ($00, $17, $1B-$2A), and WLD at $2B, a field we had not named; it is now BATTLER_WLD.
  - MON_NAME, MON_LEVEL, MON_ATK to MON_WLD and the BATTLER_* equivalents are C2. The HP and MP pairs are C2 as pairs; which word of a pair is the current value is not shown, since both were equal.
- **A party member's page (the farm path).** In the battle forced from the farm, the join flow opens the page of party member 1, Patta: Lv 4, ♀, "Pushy", Dracky, Ex 15, and 12 to the next level.
  - Its SRAM record holds level 4, cap 50, MON_SEX bit 0 = 1, MON_EXP = 15 and species $0073.
  - $73 is Dracky in the monster names (String_08_02_73). Dracky's species record has base level cap $32 = 50 and EXP curve 2, and ExpTable row 2 needs 15 EXP for level 4 and 27 for level 5.
  - The monster list numbers the three records in state 2 as party members 1-3 and lists the state-1 records after them unnumbered.
  - So MON_EXP and MON_SPECIES are C2, MON_STATE is C2 as 0 empty / 1 kept / 2 in the party, and MON_MAX_LEVEL gains this agreement but stays C1.
  - tools/recipes/e0320_farm_battle.txt holds the whole played chain, one run per line. `python -I tools/play.py --chain FILE` replays it, and the replay reproduced the saved state exactly (cycles, SRAM, WRAM). tests/test_play_chain.py replays it in memory (about 67 s) and pins the scene routines of each step and these record values.
- **Glyphs.** The debug menu pictures "1:GOTO PROGRAM" for "1", $A3, "GOTO PROGRAM", so $A3 is ":". $45 is a single character cell holding "*:", the mark before an unnamed speaker's words. Both are in the character table (C2); the bytes are unchanged.
- **Tests.** tests/test_battle_trace.py replays the forced battle from power-on and checks five things:
  - the debug-menu names run only in mode 0;
  - battle, AI and battle-end names run only in mode 4;
  - field and title code does not run in mode 4;
  - no Battle/AI routine runs on the title screen;
  - SRAM record 0 and battler record 0 agree on every field both layouts name.
- **Scope.** The battle start is forced through the game's own debug menu, so it shows what the battle code does, not how the game reaches a battle in play. The pictures are our emulator's.
- **Address names in comments.** Notes from config/names.json and config/symbols.json still wrote RAM by address (for example "wC5E8 = (wC5E8 + 1) & $7F" in NextTableByte's note) where the address has had a name for a long time (wRandomHi).
  - The generator now writes such mentions, after the first `;` of a line only, as the symbol at that address, or as `Buffer + $n` inside a named buffer, as the operands already do. Thousands of comment mentions changed; 6 remain, hFF80 and hFFF8, which have no symbol.
  - tools/check_note_grounding.py reads those mentions the same way. It now checks 6,669 mentions instead of 4,369, and all are connected to their routine.
  - Seven notes still named wLinkScreenState and wLinkScreenSubState, replaced in E-0318; the check had skipped them as non-symbols. They now name wTitleScreenState and wTitleScreenSubState.
  - tests/test_note_grounding.py adds a test that every RAM name in a note is a symbol, the stem of several (wGold for wGoldLo/Mid/Hi), or a former name after "was". It fails on the old notes.
- Tests OK (206, skipped=3).
- Binary verification: build/run445 (BATTLER_WLD), build/run446 (glyphs), build/run447 (comment names), build/run448 (notes), build/run449 (an annotation written with its symbol) and build/run450 (record notes) PASS, 0 differing bytes.

### E-0319 — The game's own string lookups and screen pictures check our text reading

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware), with TOOL changes.
- **The run.** tools/boot_trace.py gains `--explore`: from frame 4000 the player walks in a square, presses A every 30 frames, B every 97 and Start every 997. The trace also logs two kinds of event in order:
  - the entry of each routine named TalkMsg*, TalkScript*, Msg*, ShowString* or ShowMessage*;
  - each return of LookupString (0:$2E5C), with the current ROM bank, DE (the string pointer), wStringCategory, wStringIndex, and the bytes from DE up to $F0, read through the emulator's own bank mapping.

  tools/screen.py draws VRAM (background and window layers, CGB attributes and palette RAM; no sprites) as a PNG.
- **Strings.** The 40,000,000-instruction exploring run (9,152 frames) looks up 13 distinct strings: the title menu, the name-entry question, the opening narration, Tara's lines and three talks on the ship. The 400,000,000-instruction run (83,302 frames) looks up the same 13; random walking on the ship reaches nothing more, and no battle. Each lookup's DE is a label of the source, and its category and index match the game's:
  - String_07_00_02 is the title menu ("CONTINUE NEW GAME ...");
  - Message_00_00 and on are the narration and talks.
- **A table the static pass missed.** The name-entry question "Is 0 correct?" was looked up at 14:$700D, which had no label. RunNameEntryStateWhenNotFading_Case* loads `ld de, $7003` and then jumps (`jr`) to the shared `call BeginStringDisplay`. E-0217 only looked at `ld de` in the four instructions before the call.
  - The rule now also takes `ld de, n` followed by an unconditional jump straight to such a call.
  - 14:$7003 is now StringCategories_14_7003, one category list of four strings (String_14_7003_00_00 to _03). The second string repeats the first.
- **Talk names.** Each TalkMsgNNNN_<words> routine the run entered is followed by a lookup of message index $NN, category 0, at label Message_00_NN, whose text begins with <words> ("0" is read as Hero). Three are checked: TalkMsg0005_YouFolksRunAMonsterFarm, TalkMsg0010_HeroPeeredIntoTheVaseFreshly and TalkMsg000F_HeroPeeredIntoTheBarrelIt.
- **The screen.** Pictures 25 to 90 frames after those talks show "We've never had" and "It was filled with", the decoded text.
  - The picture of message $05 shows a glyph our table lacked: the bytes "We", $42, "e" are drawn "We've". $42 is now "'v" (C2), as in "You've", "I've" and "We've". Four rule-made names read better, e.g. SceneRivalDefeated_ShowKingWahahWeveBagged (was ...WeE).
  - The name-entry keyboard picture (frame 1100) shows NameEntryKeyboard row 4 ($95 "," "." $94 $93 " ") as an apostrophe, comma, period, a semicolon-like glyph, a two-dot glyph and an arrow. In text $95 reads as an apostrophe ("oasis' water", "Girls' clothes", "to 'Defense'"), so it is now "'" (C2).
  - gb_text.render keeps $95 raw before s/m/r/t/v/l, where "'" plus that letter would re-encode as a contraction glyph.
  - $94 and $93 appear in no text, so they stay raw (C1: ";" and "‥" from one picture). The arrow at the space position may be the keyboard's own picture of space, so $90 is unchanged.
  - The question picture (frame 1250) shows "Is CobiA correct?" for the bytes "Is ", $F9, "0 correct?". $F9 "0" prints the player's name (C2 within this one string, observed; not yet generalized).
- **Scope.** These are our emulator's picture of VRAM, not hardware. The charmap entries rest on the glyph shapes in VRAM and on reading the text.
- **Tests.** tests/test_boot_trace.py now runs with `explore=True` and adds three checks:
  - every LookupString result is at a String_/Message_ label whose category and index match the game's;
  - each TalkMsg routine looks up the message its name quotes;
  - the strings read as game text.
- Binary verification: build/run442 (string table), run443 ('v) and run444 (apostrophe) PASS, 0 differing bytes. Tests OK (197, skipped=3). Routines, RAM and INCBIN measures stay at 0.

### E-0318 — A power-on run: names agree with where the code runs

- Kind: EMULATION (tools/sm83.py, our own emulator; not checked against hardware).
- **The run.** tools/boot_trace.py runs the reference ROM from power-on with scripted presses: A for four frames every 120 frames, Start in between. It records each named routine the first time it executes, together with wGameMode at that moment. 40,000,000 instructions (10,073 frames, about 55 s) reach 413 named routines; the counts below are from the 60,000,000-instruction run, which reaches the same 413.
- **What runs where.**
  - Mode 0, power-on (8 routines): ROMEntryPoint, BootAndMainLoop, InstallOamDmaRoutine, ClearWRAMHRAMAndSRAMBanks0And2, and others.
  - Mode 5 (254 routines): GameMode5_Init, the opening screens (GameMode5_Update_LoadScreens with QueueMusic), name entry (44 RunNameEntryStateWhenNotFading routines), GameMode5_Update_NewPlayerSetup, CheckSaveData.
  - Mode 1 (151 routines): the field (FieldModeStateDispatch, UpdatePlayerMovement, map-screen code), the event-script engine (FetchScriptCommand, ExecuteScriptCommand, ScriptCommand01-09), and the opening scene SceneAtSea.
  - No battle routine runs (RunBattleSetup*, BattleEnd_*), as expected before any battle.
- **Names corrected.** wLinkScreenState and wLinkScreenSubState drive the opening, title and name-entry flow of mode 5 before any link screen, so they are now wTitleScreenState and wTitleScreenSubState. wGameMode's note records the observed meanings of modes 5 and 1.
- **Tests.** tests/test_boot_trace.py pins the title flow in mode 5, the field and SceneAtSea in mode 1, and no battle code. These game-meaning names are now C2 within the emulator's scope.
- Binary verification: build/run441 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0317 — Reading notes are grounded in the code they describe (with a negative control)

- Kind: TOOL (a consistency check of the 4,318 code names in config/names.json).
- **The check.** tools/check_note_grounding.py takes every RAM symbol and routine name a code note mentions: 4,369 mentions in 3,286 notes. Each must be connected to the named routine in the generated code, in one of these ways:
  - its body or its own sub-labels;
  - its xref lines;
  - its callers, direct or through a `dw`/`dfar` table and that table's owner;
  - its callees, up to three levels;
  - or a mention only as a comparison ("like X", "as X", "see X").
- **Result.** All 4,369 mentions are connected.
- **Negative control.** One random RAM symbol per note is accepted 113 times in 4,318 (2.6%), and one random routine per note 7 times in 4,318 (0.16%). So the check tells real references from unrelated ones. A note that named a routine, table or variable its code does not reach would fail.
- **Tests.** tests/test_note_grounding.py asserts both results: no ungrounded mention, and controls below 10%.
- **What it does not show.** That a note describes its routine's game meaning correctly. That still rests on each entry's evidence, and on execution for the readings tested in E-0314 and E-0315.
- Binary verification: unchanged (build/run440 PASS, 0 differing bytes); tests OK (skipped=3).

### E-0316 — Rule-made names checked against their instructions; a padding mis-trace from E-0305 found and fixed

- Kind: TOOL (C2 for the mechanical claims: each name is checked against the code it describes).
- **The claim checker.** tests/test_name_claims.py reads the generated source and confirms that every rule-made name says what its instructions do:
  - **10,185 local labels**, each by its shape:
    - `.loop`: a conditional branch comes back to it;
    - `.return` and `.return_NN`, `.return_0`, `.return_carry`, `.return_no_carry`: the instructions that end it;
    - `.set_x`, `.clear_x`, `.check_x`, `.read_x`, `.call_x`, `.to_x`: the store, load, call or jump named;
    - `.cp_NN`, `.check_bitN`, `.next`, `.restore`, `.set_carry`, `.done`: the first instruction;
    - only `.skip` makes no claim.
  - **2,629 global names**: Parent_To<Target>, Parent_<Callee>[AndStep], Parent_Call<X>, Parent_Set<V>To<NN>, Parent_Write/Read/Check/Set/Clear<V> (V a RAM symbol), and Parent_Wait<V>. Only the label's own part after its parent counts. Names from config/names.json carry their own evidence and are left out.
  - All claims hold after the fixes below. These names are therefore verified descriptions of the code (C2), not guesses.
- **Stale names fixed.** 11 Parent_To<Target> names kept a target name that a later pass changed, for example GameMode6_Update_SavePrompt_ToGameMode6_Update_Shared03. A new pass, refresh_to_names, re-reads each target's final name.
- **Regression found and fixed.**
  - E-0305 named a case target RunBattleActions_StatusChecks_CheckAction_NopRun, a run of nop (zero) bytes. Named routines become copy signatures (discover_copies: the first 16 bytes), so this all-zero signature matched padding throughout the ROM. That traced about 46,000 bytes of padding as code. It also turned two AI-table pointer runs and an 83-byte region into unexplained INCBIN slices (503 bytes; build/measure2.py).
  - The build still matched byte for byte and the tests passed, because nothing tested that measure.
  - Fix: discover_copies now ignores signatures with fewer than 4 distinct byte values. Code is back to 455,507 bytes, 181 more than before, from genuine copies.
  - tests/test_incbin_identified.py now fails on any INCBIN without an asset comment.
- **AI scoring tables are 201 entries long.** AIScoreRoutineTableA (30:$5785) and B (30:$59E0) were laid out with 131 entries. Both have 201: the 3-byte far pointers continue to skill number 200, and A ends exactly where B starts, at $59E0.
  - The old bytes-as-pointer-run reading had put the targets' labels in bank $30.
  - Three targets were never traced and are now configured code entries: AIScore_NoWeightA and AIScore_NoWeightB (lone `ret` for skill numbers 175-191 and 192-199) and AIScore_Skill200 (which can call ResetAISkillScoreE2).
- **Counts.** Unidentified INCBIN: 0. Routines with only an address name: 0. Data labels with only an address name: 0.
- Binary verification: build/run440 PASS, 0 differing bytes; tests OK (skipped=3), 189 run.

### E-0315 — Helpers from E-0305 executed in tools/sm83.py; two palette quirks

- Kind: EMULATION (our own emulator; not checked against hardware).
- **New tests.** tests/test_helpers_behaviour.py (7 tests) runs helpers named by reading and compares them with their notes. These agree as written:
  - KeyWorldDoorItem_ModuloBPlusOne: DE = (L mod B) + 1.
  - BattleEnd_Step3_RecordKnowsSkill: A = $FF when the skill is among record buffer A's eight skills, else A is unchanged.
  - GameMode4_Init_CountBattlerRecords: 1, 2 or 3 by the in-use bytes $4E and $9C on.
  - MedalPrizeMenu_CountItem2C (count, or $FF when none) and MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot.
  - RunBattleSetup_FleeCommand_SubtractFloor0 and ApplyMeatToRecordField6B_SubtractDEFloor0.
- **Palette routines.** Both walk the three DMG palette bytes from wDMGPaletteBGP. Execution revealed two quirks that the notes did not mention.
  - **C is never cleared.** C collects the three low shades of each byte and carries into the next one, so the second and third bytes also get the earlier bytes' low shades ORed in. This affects both LightenDMGPaletteOneStep and RunEffectRoutineEffectEvery5Frames_DarkenPaletteStep.
  - **Darkening wraps the top shade.** The top shade goes from 3 to 0, because $C0 + $40 overflows to $00 and passes the `cp $C1` cap check. Palette $E4 becomes $39.
  - An exact model of both routines matches 60 random palettes each. The routine notes are rewritten, and the two quirks are recorded as likely game bugs (C2).
- Binary verification: build/run435 PASS, 0 differing bytes; tests OK (skipped=3), 186 run. The first E-0315 commit (07516ed) said the notes were rewritten, but a script error had left them unchanged. The follow-up commit applies them.

### E-0314 — Readings executed in tools/sm83.py; the battle result has four counters (correction to E-0289)

- Kind: EMULATION (our own SM83 emulator against the reference ROM; it has not been checked against hardware) and a correction.
- **New tests.** tests/test_readings_behaviour.py runs three routines and compares each with its written reading.
- **ComputeBattleResultRank (200 random cases).** The emulator disproved part of E-0289.
  - The "reward bytes" wBattleRewardByte97/98 ($C897-$C898) are not rewards. They are result counters 2 and 3 of four that start at wKeyNameBuf ($C895).
  - wBattleResultStep (0-3) picks the counter that gets +1, up to 99.
  - The band is (counter 0 + counter 1) × 10 / (sum of all four).
  - With that model, all 200 cases match the counters, wWildBand, wWildByteE5 and wWorkBuf + 1.
  - Renamed: wBattleResultCount2 and wBattleResultCount3. The routine's note is updated.
- **RollChildSexFromSpecies.** Run on 43 species × 12 random seeds:
  - sex-ratio class 0 always gives 0;
  - the result is always 0 or 1;
  - class 1 gives 1 less than 35% of the time;
  - class 2 gives 1 less often than class 3.

  This agrees with E-0307 and E-0311, together with the appraiser's strings: 0 = male, 1 = female.
- **ApplyGiftEffectByItem with the Herb (item 1).** wGiftRecord + MON_MAX_HP goes up by 1, capped at 999 (tested at 0, 500 and 999), and wPendingGiftItem is cleared, as E-0295 and E-0312 state.
- **Confidence.** These readings are now C2: executed, within the scope of our emulator.
- Binary verification: build/run433 PASS, 0 differing bytes; tests OK (skipped=3), 179 run.

### E-0313 — Species byte $0B is the field ability

- Kind: STATIC (C2).
- **The redirect.** BeginStringDisplay_Bank08 and CopyStringToBuffer_Bank08 send categories 9 and up to bank $95: BeginStringDisplay_Bank08_BeginStringDisplay subtracts 9 and uses StringCategories_95_4675. Category $0D is therefore bank $95's category 4, at 95:$4839.
- **The table.** Its strings are 'None', 'Call ship', 'Call cloud', 'Smash rock', 'Burn', 'Cut', 'Open door': the monsters' field abilities.
- **Names given.** Species byte $0B is SPECIES_FIELD_ABILITY, and the list is StringTable_FieldAbilities (was StringTable95_Cat0D). Three readers show it: ShowRecordSpeciesAndSkillNames, ShowSpeciesCategory13StringOfListEntriesCell5Record, ShowSpeciesCategory13StringAtTiles2680.
- **Result.** Every byte of the 47-byte species record is now named or shown to be unread. Species byte 5 is the only one no code reads (E-0311).
- Binary verification: build/run432 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0312 — Gifts go to an Egg: $CECE is that egg's monster record (wGiftRecord)

- Kind: STATIC (C2 for the layout and the recipient).
- **The layout.** The scattered names in $CECE-$CF72 are the fields of one $A5-byte monster record. Each old symbol matches a record field at base $CECE:

  | Address | Old name | Field |
  | --- | --- | --- |
  | $CECE | wGM2Mode | MON_STATE |
  | $CECF | wTopSpeciesName | MON_NAME |
  | $CED9-$CEDC | wTopSpeciesLo/Hi/Byte/ByteDC | MON_SPECIES, MON_FAMILY, MON_SEX |
  | $CEE7 | wGM2Byte | MON_MASTER_ID |
  | $CF0A | wTopSpeciesGrowth | MON_SKILL_LIST |
  | $CF29-$CF37 | wTopStat0-7 | HP, max HP, MP, max MP, ATK, DEF, AGL, INT |
  | $CF41 | wResistanceLevels | MON_RESISTANCES |

  More evidence for the layout:
  - LoadTopSpeciesLoSpeciesStatsToTopSpeciesGrowth copies species bytes 8-10 to $CF0A (record $3C) and species $12-$2C to $CF41 (record $73), as CreateMonsterRecordOfKindTemp1 does for SRAM records.
  - bank $F0 writes wPlayerId and then four $FF bytes at $CEE7, which are record $19 and $1A-$1D.
- **Who receives the gifts.** GreatLogTalkEvents case $E5 runs only while MON_STATE is 1.
  - With no gift pending it shows message $0D60, 'What will you give to the ...'.
  - Otherwise it shows $0D61, 'Y has been given to the Egg. What will you give it next?'
  - RunFieldReturnPhase_Case01_WaitMapType shows the field object wObject5 on one map screen while MON_STATE is 1.
- **Names.**
  - The record is now one sized symbol, wGiftRecord (size $A5, replacing 17 entries). Its operands use MON_* through the buffer pass, for example `ld hl, wGiftRecord + MON_MAX_HP` in every GiftEffect_*.
  - wFamilyScores is the Egg's 11 family scores, and wPendingGiftItem and wGiftCount refer to gifts to the Egg.
- **What the gift effects change.** A gift raises the Egg's maximum HP by 1, 2, 3, 5 or 8 depending on the item (counted over the 70 effects that start with `ld hl, wGiftRecord + MON_MAX_HP`; capped at 999; some effects do other things) and raises one family's score while lowering others. RankFamilyScoresIntoFamilyRanking ranks the families, and the top family picks the species when the egg hatches (RunLinkSession8Exchange_EggHatched: 'G hatched from the egg that ...'). That answers the open question from E-0295.
- Binary verification: build/run431 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0311 — Sex 0 = male, 1 = female; egg states; the bytes no code reads

- Kind: STATIC (C2).
- **Which sex is which.** The egg appraiser's script (bank $96, Script_96_6FA6) is `script_command SCRIPT_EGG_SERVICE` then `script_choice_jump`, and opcode $E4 jumps by wTwoChoiceCursor (E-0242).
  - Choice 0 shows 'No doubt at all-it's male.' and choice 1 shows '...it's female.'
  - The service step that precedes it (EggServiceMenu_ChooseAndPay_CheckAndPay, step 5) sets wTwoChoiceCursor = MON_SEX & 1.
  - So bit 0 = 0 is male and 1 is female. SexChanceByClass (0, 10, 50, 90) is therefore the chance of a female child, and sex-ratio class 0 is always male.
- **Egg states (MON_EGG, $6E).**
  - 0: not an egg.
  - 1: an egg not yet appraised. The creation code sets it.
  - 2: an appraised egg. EggServiceMenu_ChooseAndPay_CheckAndPay sets it after charging the 20-gold fee, and DrawRecordListPageMarks shows the sex mark only for 2.
- **Bytes no code reads.**
  - Record bytes $28 and $33 sit after the two parent master names. The presets hold 0, and only the unknown-parents placeholder writes them ($FF). Named MON_UNUSED_28 and MON_UNUSED_33.
  - Species byte 5 (values 0-3) is never read: all species reads go through wSpeciesRecord, LoadSpeciesRecord copies the 47 bytes, and the only code that touches the whole buffer clears it. Named SPECIES_UNUSED_05.
- **Result.** No species, monster-record or battler byte up to these ranges is left unexplained. Species byte $0B is still only "a category-$0D string index".
- Binary verification: build/run429 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0310 — Species body flags, base EXP; battler family and resistances

- Kind: STATIC (C1).
- **Body flags.** At battle start GameMode4_Init_Sub01 stores (species byte 2 << 4) | species byte 3 into each slot's wSlotBodyFlags (was wSlotDamageFlags).
  - Bit 0, from species byte 3: MetalCut multiplies damage by 50 against it (MultiplyDamageBy50IfSlotDamageFlagsBit0), and ChooseTarget_MetalCut picks such slots. A non-zero byte 3 also raises a stat cap from 700 to 999 in battle kind 3. So byte 3 is SPECIES_METAL.
  - Bit 4, from species byte 2: ChooseTarget_LegSweep skips such slots, and ActionEffect_LegSweep (LegSweep, BigTrip) treats them differently. So byte 2 is SPECIES_UNTRIPPABLE.
- **Species bytes $2D-$2E = base EXP word.** GameMode4_Init_Sub01_Sub07 builds a battler record and writes them as the low word of its 24-bit EXP, at battler $18-$19. MonsterTable bytes 6-7 do the same for wild monsters (E-0298). Named SPECIES_EXP.
- **Battler fields.**
  - $0C is the family (BATTLER_FAMILY).
  - $31 holds 27 resistance levels (BATTLER_RESISTANCES). RecomputeTargetStatsFromRecord packs them into the slot's 7-byte wSlotResistances record (LoadBattleArg0PointersThenRunPackResistanceFieldsToDE).
- Binary verification: build/run428 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0309 — Species bytes $0C-$11 are six stat growth rows (correction to E-0299)

- Kind: STATIC (C1 for the stat order).
- **Correction.** E-0299 named species byte $10 alone the stat growth row. In fact bytes $0C-$11 are six rows, one per stat, read in the same order each time:
  - ComputeLevelUpStatGainsForBattleArg1 passes each to ReadStatGrowthGain with B = 0-5, filling wLevelUpGains + 0-5.
  - GameMode4_Init_Sub01_Sub07 and ApplyLevelScaledStatsToSlots pass each to StatFromGrowthRow for new and wild monsters.
- **Stat order.** Assumed to be HP, MP, ATK, DEF, AGL, INT, the game's usual order, as for the base-stat accessors (E-0124). That makes it C1.
- **Names given.** SPECIES_GROWTH is now a 6-byte field at $0C, used as SPECIES_GROWTH + 0-5 (18 operands). In the SpeciesRecords layout, byte 11 is the category-$0D string index and bytes 12-17 are the growth rows.
- **Still unread.** Species bytes 2-3, 5, $2D-$2E. GameMode4_Init_Sub01_Sub07 copies $2D-$2E into a new battler record.
- Binary verification: build/run427 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0308 — Field object bytes 2-3 are one sprite id word

- Kind: STATIC (C1).
- **The draw rule.** UpdateAndDrawSpriteSlots reads +2 and +3 together when OBJ_SET_MODE (+1) is 0:
  - bits 0-6 of +2 give the sprite set index;
  - when +3 is non-zero it draws with DrawMetaSpriteSet_Bank27;
  - otherwise bit 7 of +2 chooses DrawMetaSpriteSet_Bank26 over DrawMetaSpriteSet_Bank25.
- **What stores there.** Scenes write a monster's species word there: wRecordBufA/B + MON_SPECIES + 1 goes to + $3. Species ids at or above $100 therefore draw from bank $27.
- **Rename.** OBJ_SPRITE_SET becomes OBJ_SPRITE_ID, a 2-byte field. Object byte 3 now reads as OBJ_SPRITE_ID + 1 in all 33 uses.
- **Still numeric.** wObject1/2 + $4/$5: 3 uses.
- Binary verification: build/run426 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0307 — Species byte 1 is the sex-ratio class

- Kind: STATIC (C1).
- **The roll.** RollChildSexFromSpecies (0E:$61C1, was RollWCADEFromSpeciesFlag) loads the child's species record and sets the child's MON_SEX ($0E):
  - When species byte 1 is 0, the sex is 0.
  - Otherwise it rolls RandomModulo29 and gives 1 when the result is not above SexChanceByClass[byte & 3]. That table, at 0E:$61FC, holds 0, 10, 50, 90, so classes 1-3 give sex 1 about 10%, 50% and 90% of the time.
  - ComputeBreedingChild and MedalPrizeMenu_ChoosePrize call it.
- **Names given.** Species byte 1 is SPECIES_SEX_RATIO; the SpeciesRecords layout names it.
- **Still unread.**
  - Species bytes 2-3: GameMode4_Init_Sub01 packs them as nibbles into one byte. A non-zero byte 3 raises a stat cap from 700 to 999 in battle kind 3 (ScaleStatAndCapByBattleKind).
  - Species bytes 5, $0B-$0F, $11, $2D-$2E.
  - Record bytes $28 and $33.
- Binary verification: build/run425 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0306 — Player id, master id, and the join-chance classes

- Kind: STATIC (C1).
- **wPlayerId (was wSaveByte16, $C616).** GameMode5_Update_NewPlayerSetup copies wRandomLo into it after the player's name entry, so it is chosen once per new player. ComputeBreedingChild stores it in the child record at $19, and the link code sends it (bank $F0). It reads as the player's id.
  - Record byte $19 is therefore MON_MASTER_ID: the id of the player who bred the monster.
- **Join-chance classes.** BattleEnd_Step5_Case00_WriteBattleFoeCountAndSpeciesIdLoEtc runs before BattleEnd_AskToJoin and decides whether the defeated monster may join:
  - Nothing joins in link battles or battle kinds 3-5 and 8 and above.
  - Nothing joins when the foe's wFoeJoinClass entry is 7.
  - Nothing joins when species byte 4 is 7.
  - Otherwise the monster may join when (random mod 200) is below JoinChanceByClass[species byte 4]. That table, at 16:$5CFB, holds 100, 50, 24, 10, 6, 2, 1, 0.
- **Names given.**
  - Species byte 4: SPECIES_JOIN_CLASS.
  - MonsterTable byte 8, copied to battler byte $4D: BATTLER_JOIN_CLASS. GameMode4_Init_Sub01 copies it for the three foes into wFoeJoinClass1-3 (were wBattleInitA1-3).
  - The table layouts name these bytes.
- **Not read.** Record bytes $28 and $33. Two `ld c, $28` loads turned out to be arguments to a list helper, not record offsets.
- Binary verification: build/run424 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0305 — No structural label left: a shape fallback and 70 helpers named by reading

- (Note from E-0316: one name given here, RunBattleActions_StatusChecks_CheckAction_NopRun, made an all-zero copy signature that traced padding as code until E-0316 fixed it.)

- Kind: TOOL + STATIC (C1/C2 per name).
- **The fallback pass.** name_structural_by_shape runs after the other naming passes. A step that still has only a structural name (Parent_CaseNN / _SubNN / _SharedNN) and is not a dispatcher gets Parent_<Shape>:
  - The shape comes from its first instructions, by the branch-target rules (_target_shape): CallX, SetX, CheckX, ReadX, ClearX, ReturnNN, CpNN, ...
  - When that gives only Skip, Done, Next or Restore, the name comes from the first named routine the step calls; otherwise it becomes ReturnAfterSetup, StepCounter or RestoreRegisters.
  - A callee name loses the parts it shares with the parent and any structural tail. It is not cut at a fixed length.
  - Examples: RunLinkSession4ScreenState_EditRules_CheckLinkMessage, BattleEnd_Step3_Sub02_CallShared01, PauseMenu_State3_PagedMenu_Shared01_CpFF.

  The generator also writes the list behind its "structural labels left" count to build/structural_left.txt for review. That file is not a build input and is not tracked.
- **Helpers named by reading (70).** These are the helpers the fallback could not describe, mostly loops and arithmetic. Examples:
  - Multiply8_AddFourBits.
  - Several WriteUnknownName routines: three or nine $98 placeholder glyphs, then $F0.
  - Name entry: RunNameEntryStateWhenNotFading_ClearNameEntryText, _ApplyChosenCharacter, _FinishNameEntry, RunGameMode2State_CenterName.
  - Medals and keys: MedalPrizeMenu_CountItem2C and _RemoveItem2C, KeyAppraisalMenu_HasAnyKey and _CountKeys.
  - BuildWCB0CCandidateList_RemoveDuplicateSkills, BattleEnd_Step3_RecordKnowsSkill, ChooseTarget_MouthShut_CountMouthSkills.
  - RunLinkSession4ScreenState_EditRules_DrawRuleMark, GreatLogTalkEvents_ClearArenaData, PauseMenu_State3_RecordJourney_RestartGame.
  - RunEffectRoutineEffectEvery5Frames_DarkenPaletteStep, KeyWorldDoorItem_ModuloBPlusOne.
- **Counts.** Structural labels left unnamed: 112 → 0, measured after the fallback. Routines with only an address name: 0.
- **Why there is no test for the count.** A source-only test cannot tell a rule-made descriptive name that carries a uniqueness number (PlayMapMusic_ReadCurrentMusic_Case21) from a purely structural one. Only the generator's shape_named set records that, so the generator's count is the measure.
- Binary verification: build/run422 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0304 — The last 27 dispatchers named

- Kind: STATIC (C1, from the RAM and calls each dispatcher's steps use).
- **Link and battle:**
  - RunLinkSession4ScreenState_EditRules: wLinkRules (19 uses) and wLinkRuleTurnLimit.
  - RunLinkSession4ScreenState_SetBattleKindAndSync.
  - RunBattleSetup_ItemCommand: wItemId, wItemRecord, wSlotChoices.
  - RunBattleSetup_BankA0_EntrySelect: sets and clears bit 6 on entry tiles.
  - ResolveStep0EEffect_DamageAndSelectEffect, RunBattleTransitionStep_StagedSteps.
- **Breeding and services:**
  - BreedMenu_ChooseEgg: the list of records with the egg flag set (E-0296).
  - BreedMenu_RestoreScreen, _RedrawListScreen, _ClearListMarks, _ListMonsters, _ShowSelectedRecord.
  - NpcBreedMenu_RedrawListScreen, EggServiceMenu_ChooseAndPay_CheckAndPay (subtracts 20 gold), EggServiceMenu_Bank1B_ListAvailableRecords2.
- **Lists and screens:**
  - RunScreenStateWhenNotFading_F1_ShowChosenRecord and _ResetListAndShowString, plus their RunLinkSession5Exchange counterparts.
  - GameMode6_Update_ChooseRecordList.
  - HibernateMenu_ChooseWithStats (MarkPartyMembersInRecordListPage, DrawRecordStatsBoxForArg1), HibernateMenu_IndexListEntry.
  - PauseMenu_State3_ChooseListEntry.
  - GameMode5_Update_LoadScreens_Screen0/1/2/WithMusic.
- **Counts.** Bare dispatchers: 27 → 0. Structural labels the generator leaves unnamed: 133 → 112, none of them dispatchers. Routines with only an address name: 0.
- Binary verification: build/run419 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0303 — 34 small dispatchers named from their steps

- Kind: STATIC (C1, or C2 where the name only lists what the steps build).
- **What these are.** Dispatchers of two to five steps, named from what their steps do.
- **Screen-block menus**, named by the screen blocks they build:
  - PauseMenu_Main_Blocks00To03, _Blocks04To06 (which draws the INFO panel's meta-sprite, E-0046), _Blocks07And08, _Blocks09And0A.
  - PauseMenu_State3_Block21Menu, _TileBufferMenu, _Blocks21And2C, _PagedMenu, _Block2DNumber.
  - PauseMenu_Items_MemberList, PauseMenu_Items_SubMenu.
- **Waits and transitions:**
  - the two LinkBreed `_WaitTextThenPartner` dispatchers;
  - RunBattlePhaseWhenTextIdle_A0_ResultsScreen_FadeOut and _BlankPartnerRecord;
  - BattleEnd_Step5_DrawThenAskToJoin;
  - RunBattleTransitionStep_Case01_CheckStage and _SetCounts;
  - GameMode5_Update_LoadScreens;
  - RunLinkSession4ScreenState_ResetAndSignal;
  - RunLinkSession8Exchange_ShowMessage, RunLinkSession5Exchange_ShowMessages.
- **List redraws:** SwapMonstersMenu_ShowMonsterDetails(3)_CursorThenRedrawList, _CursorThenRedrawList2 and 3, and _SpriteThenRedrawList.
- **Battle:** ResolveStep0EEffect_Scale80Percent (ScaleHLTo80Percent_Bank32) and ResolveStep0EEffect_Brutalize_DefeatTarget.
- **Other:** PriestMenu_PayForService_CopyBuffers, GameMode6_Update_Case04_PageList.
- **Counts.** Bare dispatchers: 61 → 27. Labels under them: 349 → 213. Structural labels the generator leaves unnamed: 133.
- Binary verification: build/run418 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0302 — SwapMonstersMenu and HibernateMenu screen states named from their option handlers

- Kind: STATIC (C1).
- **SwapMonstersMenu (script command $E8).** Screen state 2 is a five-option menu: wGridCursorX 0-3, and 4 cancels. State 3's handler (SwapMonstersMenu_Case03_ListPartyRecordsWithState2ToListEntries, bank $1D) picks the next state from the option:
  - option 0 lists the party and goes to state 4 (SwapMonstersMenu_MoveRecords);
  - option 1 lists the farm records that are not eggs and goes to state 5, or returns when there are none;
  - options 2 and 3 go to states 6 and 7.

  Names given:
  - SwapMonstersMenu_ChooseFromFarm (state 5).
  - SwapMonstersMenu_ChooseToView and _ChooseToView2 (states 6 and 7, which lead to the detail and parents screens).
  - SwapMonstersMenu_ShowPartyMemberDetails ($08), _ShowFarmMonsterDetails ($0A), _ShowMonsterDetails2 and 3 ($0C, $0E): the detail screens, by the list each uses.
  - SwapMonstersMenu_ShowParents and _ShowParents2 ($0B, $0D): these call DrawRecordParentNames.
- **HibernateMenu (script command $EB).** In state 3, option 0 lists the farm records that are not eggs, checks capacity and goes to state 4: HibernateMenu_ChooseToHibernate. The script asks 'Which monster will hibernate?'. Option 1 leads to state 5 (HibernateMenu_ChooseRecords, which unpacks records from SRAM bank 1, so it wakes a monster); option 2 leads to state 7.
- **Test.** The floor on remaining `_CaseNN` labels in tests/test_routine_behaviour.py drops from 1000 to 500, because cases keep getting descriptive names.
- **Counts.** Bare dispatchers: 71 → 61. Labels under them: 450 → 349.
- Binary verification: build/run417 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0301 — 17:5D79 was a false pointer target; pointer runs stop at their own targets (correction to E-0289)

- Kind: TOOL and a correction.
- **What was wrong.** E-0289 named the 359-byte slice at 17:5D79 "SGBPacketSet18": the target of SGB packet-set table entry $18, with its first 64 bytes read as packets. That reading was wrong in two ways.
  - The word that pointed at 5D79 is at 17:407F, which is table entry $15, not $18; I had counted `dw` lines.
  - 407F is not a table entry at all. The table at 17:4055 indexes the packets that follow it, so it has (407F - 4055) / 2 = $15 entries. 407F is the first packet: `79 5D 08 00 0B 8C D0 F4 60 ...`, a DATA_SND packet (command $0F, one packet). Its first two bytes had been taken for the pointer $5D79.
- **What 5D79 really is.** It lies inside SGBBorder0MapAndPalettes, the LZSS stream that starts at 17:5B03 and runs for 989 bytes to $5EE0, where SGBBorder1MapAndPalettes starts. The tile/attribute pairs at its start ($8E $14, $8F $14, ...) are literals in that stream.
- **Tool fix.** structure_data now drops a run's trailing entries when they sit on a position that an earlier entry of the same run points to. Such a position is the data the table indexes. A multi-level index keeps the sub-tables inside it, because the run continues through them.
  - The first commit, cf2c93c, cut the run at the first such position instead. That broke tests/test_structure_data.py's self-pointing-index test, which I committed while it was failing.
  - The narrowed rule produces the same generated source, passes that test, and adds a test of its own.
  - The only change in the generated source is in bank $17:
    - packet 0 is plain `db` bytes;
    - the border-0 stream is one `INCBIN` of $3DD bytes;
    - the false label and its names.json entry are removed.
- **Counts.** INCBIN slices without an asset comment: 0 (build/measure2.py). Data labels with only an address name: 0.
- Binary verification: build/run416 PASS, 0 differing bytes; tests OK (skipped=3) after the narrowing.

### E-0300 — Field object slots and the script meta-sprite object (OBJ_*, SCRIPTOBJ_*)

- Kind: STATIC (C1).
- **wObject1-4, 16-byte slots after wSpriteSlots.**
  - UpdateSpriteSlots jumps through six routines on each slot's byte 0, so byte 0 is the behaviour type. This answers the "byte 0" question.
  - UpdateAndDrawSpriteSlots reads, per slot:
    - +1: when 0, the sprite set comes from +2 (bits 0-6);
    - +6: bits 0-2 go to hSpriteAttrXor;
    - +8: tile offset;
    - +$B and +$C: X and Y, plus 8 and 16 and the scroll;
    - +$E: sub-index; bit 7 flips the sprite (attribute bit 5).
  - UpdateSpriteSlots type 0 increments +9 every frame unless +$D bit 1 is set, so +9 is an animation counter (E-0134 had called it "flags"). +$D bit 2 picks the frame rule.
  - Byte $F is never addressed directly; it stays unread.
- **wObject5, an 8-byte script meta-sprite object.** It runs up to the story flags at $CBD7, and DrawFieldSprites reads it with a different layout:
  - byte 0 bit 7: shown (the draw returns when it is clear);
  - +1: tile offset;
  - +2: sprite set (bit 7: a sub-index follows);
  - +3: attributes;
  - +4 and +5: X and Y.

  This is the layout the scenes write: `ld [wObject5 + $4], $68`, `ld [wObject5], $80`.
- **Generator.** config/record_fields.json gains "object" (10 OBJ_* fields) and "script_object" (5 SCRIPTOBJ_* fields). Operands inside wObject1-4 and wObject5 are named, for example `ld [wObject2 + OBJ_X], a` and `ld [wObject5 + SCRIPTOBJ_Y], a`: 642 + 238. wSpriteSlots is left alone, because the bank-$E0 intro uses 8-byte slots there. The wObject notes in config/symbols.json describe byte 0.
- **Still numeric.** wObject1/2 + $3 (33 uses), and wObject5 + $6 and + $7.
- Binary verification: build/run413 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0299 — Species record fields; record $73-$8D are the resistances

- Kind: STATIC (C2 for the copies, C1 for the meanings).
- **The new-record copy.** CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord copies parts of the species record (wSpeciesRecord, $D008) into a new SRAM record. It starts with HL at the record's $0D (family), and GameMode5_Update_NewPlayerSetup and MedalPrizeMenu_ChoosePrize do the same. The copies:

  | Species bytes | Record bytes |
  | --- | --- |
  | 8-10 | $3C-$3E, the first three entries of the skill list (MON_SKILL_LIST); $FF fills the rest up to $54 |
  | 6 | $57 (MON_MAX_LEVEL) |
  | $12-$2C (27 bytes) | $73-$8D |
- **Species byte 6 = base level cap.** BattleEnd_Step3 compares MON_LEVEL with it, and ComputeBreedingChild starts the child's cap from it.
- **Species bytes 8-10 = the three natural skills.** LoadSpeciesBytes8To10FromHL and LoadSpeciesBytes8To10ToArg5 also read them as a group.
- **Species byte $10 = stat growth row.** StatFromGrowthRow (new records) and ReadStatGrowthGain (ComputeLevelUpStatGainsForBattleArg1) take it.
- **Species bytes $12-$2C = 27 base resistance levels.** Record $73-$8D receives them. RefreshRecordResistancesFromSpecies works on "the 27 resistances of species wCADB" (E-0127), and RollChildResistancesToWCB43 writes the child's to wCB43 = wChildRecord + $73. LoadWD01AByteArg4 reads one of them.
- **Generator.** config/record_fields.json gains:
  - MON_RESISTANCES ($73, 27 bytes);
  - a "species" section: SPECIES_FAMILY, SPECIES_MAX_LEVEL, SPECIES_EXP_CURVE, SPECIES_SKILLS, SPECIES_GROWTH, SPECIES_RESISTANCES.

  Operands inside wSpeciesRecord are named: 45. The SpeciesRecords and monster-record layouts are split to match.
- **Still unread.**
  - Species bytes 1-5: byte 1 has flags (RollWCADEFromSpeciesFlag reads `and $03`); bytes 2-3 are packed into one byte; byte 4 = 7 stops the battle-end join.
  - Species byte $0B: a string index in category $0D, which lies outside the bank-8 database's nine categories.
  - Species bytes $0C-$0F, $11, $2D-$2E.
  - Record bytes $19, $28 and $33.
- Binary verification: build/run411 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0298 — MonsterTable bytes 6-9; the battler record fields (BATTLER_*)

- Kind: STATIC (C1) and TOOL.
- **The battler builder.** LoadMonsterAndSpeciesForListEntryC loads a MonsterTable entry (LoadMonsterRecord into wRecordBuffer). Its helper LoadMonsterAndSpeciesForListEntryC_ReadRecordBufferAndRecordBufferData then writes a battler record at DE. Simulating the routine gives this layout:

  | Battler offset | Contents |
  | --- | --- |
  | $00-$09 | $FF (a blank name) |
  | $0A-$0B | MonsterTable bytes 0-1, which are also the wSpeciesIdLo/Hi used next |
  | $0E-$11 | skills (bytes 2-5) |
  | $12-$15 | $FF |
  | $16 | 0 |
  | $17 | MonsterTable byte 9 |
  | $18-$19 | MonsterTable bytes 6-7 |
  | $1A | 0 |
  | $1B / $1D | HP / max HP (both base HP) |
  | $1F / $21 | MP / max MP |
  | $23 / $25 / $27 / $29 | ATK / DEF / AGL / INT |
  | $2B | the word $03E7 |
  | $2D-$30 | MonsterTable bytes 22, 23, 25, 24 |
  | $4D | MonsterTable byte 8 |

  The offsets $1D and $21-$29 are the ones GetBaseHP and the other base-stat accessors read (E-0062, E-0124), so this is the 78-byte battler record.
- **MonsterTable bytes.** Byte 9 (values 0-99) is the level. It sits right before a 24-bit EXP, matching the monster record's level-then-EXP order. Bytes 6-7 (up to $E8EE) are that EXP's low word. Byte 8 (values 0-7) goes to battler byte $4D, whose meaning is not established. Both MonsterTable layouts (banks $34 and $A2) now say so.
- **Generator.** name_record_offsets now takes the register and the buffer names as parameters. A second run handles the battler record:
  - `ld e, $NN` before BattlerRecordFieldAddress;
  - operands inside wBattlerRecords or wBattlerRecordSlot1-6.

  config/record_fields.json gains a "battler" section with 14 fields (name, species, skills, level, EXP, HP, max HP, MP, max MP, ATK, DEF, AGL, INT, personality). src/records.inc defines them as BATTLER_*. 82 battler references are named.
- **Fix.** Name fields are marked "text". An operand inside a name now keeps its number instead of becoming `NAME + n`. Before this fix, `wBattlerRecords + $4`, the start of a 25-byte copy, was rendered as BATTLER_NAME + 4.
- **Tests.** One new test covers the E-register form, including an `ld de` that blocks it.
- Binary verification: build/run410 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0297 — Parent fields of the monster record; buffer operands named by field

- Kind: STATIC (C2 for the copies; C1 for "master").
- **The copies.** ComputeBreedingChild fills the child record (wChildRecord, $CAD0) from the two parents: wRecordBufA at $C986 and wRecordBufB at $CA2B. It uses two address tables, and bit 4 of the child's byte $0D (wCADD) selects the alternate source table, which swaps the two parents.
  - CopyFourNamesByWCADDBit4Table: sources 0E:$5ED0, or $5ED8 when the bit is set; destinations 0E:$5EE0. Parent A $01 → child $8E, parent B $01 → $99, parent A $0F → $1E, parent B $0F → $29.
  - CopySixBytesByWCADDBit4Table: sources 0E:$5E61 / $5E6D; destinations 0E:$5E79. Parent A $0B-$0C → child $1A-$1B, parent B's → $1C-$1D, parent A $6D → $98, parent B's → $A3.
  - CopyPlayerNameToWCADF stores the player name at the child's $0F.
- **New fields.**
  - $1A / $1C: parent species words.
  - $1E / $29: parent master names.
  - $8E / $99: parent names.
  - $98 / $A3: parent plus values.

  Which parent is the father and which the mother is not established, so they are numbered 1 and 2. DrawRecordParentNames uses this area (E-0131).
- **Rename.** $0F is the master's name. The player's own name goes there, and it is passed on as a parent's master name. MON_SECOND_NAME is now MON_MASTER_NAME; E-0034 had called it the "second name".
- **Battle results placeholder.** RunBattlePhaseWhenTextIdle_A0_ResultsScreen_Case09_WriteUnknownNamePlaceholder fills these same parent fields with "???" names and $FF species. This fits a record whose parents are unknown.
- **Generator.** Operands inside the three record buffers are now written buffer + field, for example `ld a, [wRecordBufB + MON_LEVEL]` and `ld hl, wChildRecord + MON_PARENT1_NAME`. Fields with a size also give `+ n`. Record field references: 445 → 755.
- **Still unread.**
  - $19: ComputeBreedingChild stores wSaveByte16 there.
  - $28 and $33: set to $FF by the placeholder.
  - $73-$8D: 27 bytes that the debug results display copies and shows as numbers.
- **Table layouts.** The monster record layouts are split to match the new fields.
- Binary verification: build/run407 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0296 — Record bytes $57, $6B, $6D, $6E read; offsets inside fields named

- Kind: STATIC (C1) and TOOL.
- **$57 = level cap.** DrawRecordLevelAndStatusRow_1E loads $56-$57 as a pair (level, then this byte) and draws the cap mark $6F instead of $C3 when the level is at least this byte. This fits the category-5 string 'It has reached the limit for growth.'
- **$6B = WLD (wildness) word.** It is the fifth word of the stats column (F2:509F: $63, $65, $67, $69, $6B), after ATK, DEF, AGL and INT. That matches the INFO panel's order 'ATK, DEF, AGL, INT, WLD' observed in E-0046. The pause menu draws it through the same stat path as $63-$67.
- **$6D = breeding plus value.** When it is non-zero, the monster info screen draws glyph $FC and the value in one or two digits after the member number. BreedMenu_CopyToChildThenTalkEvent16 copies it to the child record. The glyph $FC is not verified as '+'.
- **$6E = egg flag.**
  - When CountRecordsByField6E counts no record with it set, the battle-end flow shows 'You have no eggs.'
  - The egg lists ('Switch which egg?', ListRecordsInUseWithByte6ESet) take the records that have it set.
  - CreateMonsterRecordOfKindTemp1 sets it to 1 for kinds 1 and 2.
  - DrawRecordListPageMarks shows the sex mark only when it is 2. What 1 versus 2 means is not established.
- **New constants.** MON_MAX_LEVEL, MON_WLD, MON_PLUS and MON_EGG are added to config/record_fields.json, and the table layouts name these bytes.
- **Offsets inside fields.** Fields now carry a "size". An offset inside a field is written `MON_FIELD + n`: MON_PERSONALITY + 1/+3 (12 loads), MON_MAX_HP + 1, MON_MAX_MP + 1. Record loads through the record-access routines: 416 → 445. None is left numeric. A new test covers the case.
- **Record bytes still unread:** $19-$33 and $73-$A3.
- Binary verification: build/run405 PASS, 0 differing bytes. Commit 53a7f4d contained a test with broken string escapes (one error). It was fixed in the next commit, and the suite is then OK (skipped=3).

### E-0295 — The largest dispatcher is the per-item gift effect; 16 link and gift states named

- Kind: STATIC (C1).
- **The gift path.** PauseMenu_State4_GiftMenu_GiveGift (the pause menu's 'Gift / Exit' window) works as follows:
  - It refuses some items ($1F, $21, $2B-$2D, $2F-$3F) and shows string $22.
  - For any other item it stores wItemId in wArg1 and far-calls the routine at F0:7284.
  - It then removes the item from the inventory (CompactInventory) and returns to the field.
- **F0:7284, renamed RecordGiftAndMaybeApplyPrevious** (was RollCounterChanceAndRunEvent).
  - It counts gifts in wGiftCount (was wRollCounter), up to $0F.
  - When a gift is pending in wPendingGiftItem (was wRollState), it applies that gift's effect if a random value is below 100 - 5 × wGiftCount.
  - The new item then becomes the pending gift. Each gift therefore takes effect on a later gift, and less often as gifts accumulate.
- **ApplyGiftEffectByItem** (was RollCounterChanceAndRunEvent_Sub01) jumps by the pending item id. Each of its cases adds to or subtracts from wTopStat1 and wFamilyScores entries. The 75 distinct cases are named GiftEffect_<item name>, with the names taken from the item-name table (bank 8, $4716): GiftEffect_Herb, GiftEffect_LoveWater, GiftEffect_WorldDew, and so on. A case reached by several ids ends in Etc. What wTopStat1 and the family scores change in the game is not established.
- **Also named** from strings the E-0294 note now quotes:
  - EggServiceMenu_Bank1B_StartLinkBattle ('Begin battle?', 'Your pal refused to battle.').
  - RunLinkSession8Exchange_EggHatched, _EggsTraded and _ObtainedEgg ('G hatched from the egg that ...', 'Eggs were traded with 0.', 'Obtained an egg from 0.'), and _WaitForPartner.
  - LinkKeyTrade_Start, _KeysSameName, _KeyCannotBeTraded and _WaitForPartner.
  - EggServiceMenu_Bank1B_WaitForPartner, RunScreenStateWhenNotFading_F1_ChooseBreedingMonster, RunLinkSession6Exchange_ChooseTeamMonster.
  - RunBattlePhaseWhenTextIdle_A0_RunTurn, PauseMenu_State4_GiftMenu_ShowChoices, _ChooseGift and _GiveGift.
- **Counts.** Bare dispatchers: 88 → 71. Labels under them: 601 → 450.
- Binary verification: build/run402 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0294 — Strings passed in A to index wrappers are quoted

- Kind: TOOL.
- **New note.** string_arg_note quotes `ld a, $NN` when it is followed by a call to a wrapper with this shape:
  - the wrapper stores A in wStringIndex, after an optional `add a, $KK`;
  - it then sets the category (`xor a` or `ld a, $CC`, then `ld [wStringCategory], a`), or leaves it unset, in which case a constant store among the caller's previous six instructions counts;
  - finally it calls or far-calls a string displayer.

  This covers ShowStringA10_Bank1B (index + $10), BeginString_Bank1B_Cat0, BeginString_Bank0E_Cat0, BeginString_BankF0_Cat0 and ShowStringIndexA_Bank37. The tail of string_index_note became string_quote, shared by both notes.
- **Effect.** 126 more string displays are quoted. Examples from LinkKeyTrade: 'Starting key trade', 'Please choose the key to trade.', 'That key cannot be traded.', "Keys can't have the same name." The Parent_Show<words> rule (E-0274) uses the new note too: 228 → 290 steps named after the string they show.
- **Counts.** Structural labels the generator leaves unnamed: 243 → 182.
- Binary verification: build/run399 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0293 — Command $82 is GreatLogFieldEvents (correction); 54 more dispatchers and five helpers named

- Kind: STATIC (C1 names) and a correction.
- **Correction to E-0286.** Script command $82 (talk category 8) was named GoldItemOrLoss from the calls in its subtree. That reading was wrong. It jumps by wPendingFieldEvent & $0F to 13 scripted scenes on the Great Log island: the dialogue of Cobi, Tara, Warubou and Kameha. Only scene $0A gives gold or items, and only scene $0C takes the gold loss.
  - It is now SCRIPT_GREATLOG_FIELD_EVENT, routine GreatLogFieldEvents.
  - Its scenes are named by their opening messages: PapaCalling, TaraThereYouAre, YouFolksRunA, GoodToHear, KingAskedUs, WarubouGiveMe, ThisIsATale, WarubouItsADead, TaraWellBeOK, WarubouWhatIsThis, GoHelpYourMotherScene, KamehaNoGoing, MajorFacilities.
- **Dispatchers named from their strings:**
  - GameMode6_Update_SwitchEgg ('Switch which egg?'), GameMode6_Update_ObtainedEgg ('obtained an egg of 0.').
  - RenameMenu_PickMonster ('Pick the monster to rename.'), GameMode5_Update_SaveDataLost ('Saved data has been lost.').
  - PriestMenu_ShowServices ('Revive / Detox / Uncurse'), PauseMenu_State4_GiftMenu ('Gift / Exit').
  - The two ShatterChecks dispatchers ('G was shattered!', 'SealPray was broken!'), RunBattleActions_StatusChecks_DroppedDead, BattleEnd_GainExperience_LearnSkill ('0 learned G!').
- **Dispatchers named from their steps:**
  - Object animations: GameMode6_Update_Save_ObjectScene, GameMode6_Update_SavePrompt_ObjectScene, RunLinkSession8Exchange_ObjectScene and _ObjectSceneThenSave, SceneDancing_DanceSteps, SceneMermaidSong2_MoveSteps.
  - Setup, link and lists: GameMode5_Update_NewPlayerSetup, RunNameEntryStateWhenNotFading_Setup, RunLinkSession4ScreenState_SaveAndSync, SwapMonstersMenu_SetupPartyList, HibernateMenu_SetupPartyList.
  - Menu drawing: EggServiceMenu_DrawListAndPrice, EggServiceMenu_DrawPrice, EggServiceMenu_Bank1B_ListAvailableRecords, MedalPrizeMenu_DrawCountBox, KeyAppraisalMenu_DrawGoldBox, RenameMenu_DrawFrame, RenameMenu_DrawNameList.
  - Effect sequences: FlashPalette, FlashOnce, FlashTwice, FlashAndMoveSprite (two), ScrollShake, Delay.
  - Battle: ResolveStep0EEffect_Brutalize, RunBattleActions_StatusChecks_StartAction and _CheckAction, BattleEnd_GainExperience_CheckLevelUp.
  - Debug: RunDebugState_E0_ChooseActionTargets, DebugMode_InitByModeState.
- **Helpers.** Five helpers that lost derived names:
  - DrawSymbolTilesForTemp1;
  - WriteHexDigitTilesOfTemp1Temp0 and WriteLowHexDigitTilesOfTemp1Temp0;
  - DisplayedTargetChoiceOfActor: flips the side bit for the link partner;
  - LightenDMGPaletteOneStep: lowers each 2-bit shade of wDMGPaletteBGP by one.
- **Counts.** Bare dispatchers: 128 → 88. Labels under them: 746 → 601. Routines with only an address name: 0.
- Binary verification: build/run397 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0292 — Strings shown through category-setting wrappers are quoted; joining after battle

- Kind: TOOL + STATIC (C1 names).
- **Quoting through wrappers.** string_index_note quoted a `ld [wStringIndex], a` only when the caller also stored a constant wStringCategory. It now also handles a callee that stores the category itself: the callee starts with `ld a, $NN` / `ld [wStringCategory], a`, as ShowStringCategory5_Bank16 does. The note takes that category and follows the callee's first call or far call to the real displayer. 25 more string displays are quoted. Examples:
  - '0 got up, looking hopeful. Allow 0 to join you?'
  - 'But there is no more room!'
  - 'You have no eggs.'
  - "You can't travel all alone."

  The Parent_Show<words> rule (E-0274) then names the steps that show them.
- **Dispatchers named:**
  - BattleEnd_AskToJoin: bank $2F category-5 strings $0B, $0D and $0E.
  - BattleEnd_AddJoinedMonster: SetRecordState2ForB, SwapMonstersMenu, RestoreRecordAFully.
  - PauseMenu_State3_RecordJourney: 'Want to record your journey?', 'Your progress has been recorded.'
  - RunBattleActions_WearOffAndDefeat: "0's Ironize wore off!", '0 dropped dead!'
  - GameMode6_Update_SwitchMonster: 'Switch with which?'
- **Counts.** Structural labels the generator leaves unnamed: 249 → 243. Bare dispatchers: 151 → 146.
- **Pause menu.** Also named, from their steps and order: PauseMenu_Skills_ChooseMember ('A dead monster can't use a ...'), PauseMenu_Skills_ChooseSkill and PauseMenu_Skills_ChooseTarget (screens built from record field $5F, MP), PauseMenu_Items_ChooseItem.
- Binary verification: build/run395 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0291 — Record byte $0E bit 0 is the monster's sex; observations on $6D and $6E

- Kind: STATIC (C1).
- **$0E bit 0 = sex.** Two readings support this.
  - In BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case11 (bank $15), after the first parent is picked, the code loads bit 0 of that record's byte $0E. It then compares it with bit 0 of every listed record. When none differs, the menu steps back (wScreenStep -= 2, wTwoChoiceCursor = 3). Breeding therefore needs a partner whose bit 0 is different.
  - DrawRecordListPageMarks (1D:$6320) draws mark tile $CC + (byte $0E & 1) when byte $6E is 2, and tile $CE otherwise.
  - Which value means which sex is not established. The glyphs $CC/$CD have no charmap entry.
  - The table layouts (PresetMonsterRecords, DefaultMonsterRecord) now name the field.
- **Constant.** MON_SEX ($0E) is added to config/record_fields.json. Record field loads named: 398 → 416.
- **Not named, observations only.**
  - $6E: CreateMonsterRecordOfKindTemp1 sets it to 1 for kinds 1 and 2. BreedMenu and EggServiceMenu store values into it. The record list shows the sex mark only when it is 2. The lists ListRecordsInUseWithByte6EClear and ListRecordsInUseWithByte6ESet filter on it. What it means is not established.
  - $6D: copied into wChildRecord by BreedMenu_CopyToChildThenTalkEvent16. Bank 03 reads it with `and a, $0F`.
- Binary verification: build/run393 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0290 — Monster record field constants (MON_*); ATK/DEF/AGL/INT words

- Kind: TOOL + STATIC (C1 for the stat fields; the other fields keep their earlier evidence).
- **Stat words.** The four stat words $63, $65, $67 and $69 are ATK, DEF, AGL and INT (C1). Three readings support this:
  - DrawFiveRecordBufBStatsColumn draws the record words at offsets $63, $65, $67, $69 and $6B as one column. The table it uses is at F2:509F.
  - The screen's label strings run "HP", "MP", "ATK", "DEF", "AGL" (09:533A-5348), and the stat-column string is "ATKDEFGLIN...".
  - AddAToRecordWordCapped and SubtractAFromRecordWordFloor1 (the seed and equipment changes, E-0103) are called with exactly these four offsets.
- **Not established.** The fifth word in the column, $6B, is not identified.
- **config/record_fields.json (new).** It lists the record offsets that have evidence, 20 in all:
  - state, name, species word (C1, E-0236), family, second name, skills, skill list;
  - status, level, EXP, HP, max HP, MP, max MP;
  - ATK, DEF, AGL, INT, personality, equipped item.
  It also lists the 15 record-access routines that take the field offset in C. The comment above each routine (E-0074/E-0103/E-0108/E-0122) states this, and each was checked to pass C to SRAMRecordAddress or SRAMRecordAddressMapped.
- **Generator.**
  - It writes src/records.inc (`DEF MON_HP EQU $5B ; ...`) and includes it from src/main.asm.
  - name_record_offsets rewrites `ld c, $NN` as `ld c, MON_<FIELD>` when the value reaches one of those routines. Up to three instructions may sit between the load and the call, and none of them may change C.
  - 398 loads are named. The commonest are MON_STATUS (78), MON_NAME (41), MON_HP (35) and MON_SPECIES (30).
  - Offsets without evidence ($0E, $57, $6B, $6D, $6E, ...) stay numeric.
- **Table layouts.** PresetMonsterRecords and DefaultMonsterRecord now show the four stat words as one `dw` line, followed by `$6B-$6E`.
- **Tests.** tests/test_record_fields.py (5 cases) covers:
  - a named load;
  - loads with instructions between that keep C;
  - an `inc c` that blocks the rewrite;
  - other callees and unknown offsets left numeric;
  - unique constants with evidence, and callees that exist.
- Binary verification: build/run391 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0289 — The last address-only data labels; battle result rank; eight helpers named

- Kind: TOOL + STATIC.
- **Name collisions.** A string whose words match an earlier string's name now gets `<Name>_<AAAA>` instead of keeping its address name. This change is in name_string_targets' give().
- **Naming by kind.** Labels named from their dreason, by kind:

  | Kind | Name |
  | --- | --- |
  | Stream found by tiling, or decompressed by a call or in the emulator | Gfx_BB_AAAA (ScreenMap_BB_AAAA for 360 bytes) |
  | Script screen animation attribute map | ScriptScreenAttrMap_BB_AAAA |
  | Map object screen array | MapObjectScreens_BB_AAAA |
  | Map object selector | ObjSelector_BB_AAAA |
  | Item name | ItemNameBB_AAAA |
  | Item description | ItemDescription_BB_AAAA |
- **ComputeBattleResultRank (A0:5A6C, C1)** (corrected by E-0314: the two "reward" bytes are result counters 2 and 3).
  - Adds one to the result count wKeyNameBuf[wBattleResultStep], capped at 99.
  - Scores the counts and rewards into a band (wWildBand) using BattleResultBandThresholds.
  - Adds the signed entries of BattleResultTurnLimitAdjust (+20, +10, +5, 0, -5, -10, -20 by turn-limit bracket) and BattleResultBandAdjust (-20, -10, -5, 0, +5, +10) to wWildLevel, then clamps it to 0-99.
  - Counts how many BattleResultRankThresholds (20, 40, 50, 60, 70, 80, 90) are at or below that value. The count, 0-7, is the rank in wWildByteE5. The results screen's rank string is 'GFEDCBAS', eight letters, one per rank.
- **ApplyBattleResultStatChanges (A0:5B47, C1).**
  - Results 0 and 1 raise the lowest of five record words by BattleResultStatBonusByRank[rank].
  - Result 2 lowers the highest word by BattleResultStatPenaltyByRank[rank]. Any other result lowers all five.
  - A word from BattleResultGoldByRank, or 1000, goes to wWorkBuf+$10.
- **Helpers.** Eight routines had lost the helper names derived from their old parents when E-0288 renamed those parents: RunBackupAndSaveSteps, InitBattleSlotsForFoeCount, PrepareTwoFoeSlots, PrepareThreeFoeSlots, ComputeWildLevelAndScaleStats, StoreBattleStateToPartyRecords, WriteThreeTwoDigitRows, ApplyBattleResultStatChanges.
- **SGBPacketSet18 (17:5D79)** (superseded by E-0301: a false pointer target inside the SGBBorder0MapAndPalettes stream). The target of entry $18 of the SGB packet-set table. Its first byte, $14, gives 4 packets (64 bytes). The other 295 bytes of the 359-byte slice are not identified and are not a valid LZSS stream. build/measure2.py still counts this slice as unidentified (359 bytes).
- **Counts.** Data labels with only an address name: 18 → 0. Code labels with only an address name (primary `Func_`/`Jump_`): 0. tools/rank_unnamed.py reports 0.
- Binary verification: build/run389 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0288 — Cases of named dispatchers count as bare; bit steps; 34 dispatchers named by reading

- Kind: TOOL + STATIC (C1 names, read from each dispatcher's steps and quoted strings).
- **Bare test.** name_trampoline_cases used to treat `Parent_Desc_Case05` as descriptive, so the shape rules skipped the cases of dispatchers that already had a descriptive name. Now a structural label is bare when the root left after removing its trailing `_CaseNN`/`_SubNN` is a live label. A numbered descriptive name made by a rule is still exempt, because shape_named holds those names.
- **Bit steps.** A new rule names a step made of `ld hl, V` with `set n, [hl]` or `res n, [hl]` pairs, then `ret` or a jump. It becomes Parent_Set<V>Bit<n> or Parent_Clear<V>Bit<n>, with Etc when there are more pairs. Example: the text control codes $0D, $15, $1A, $1D and $1E are SetTextControlBit7, SetTextFlagsBit1, SetTextFlagsBit5, SetTextControlBit0 and ClearTextControlBit0.
- **Talk categories.** DispatchTalkEvent's categories are named by the region their quoted messages describe. Each category's group dispatcher now carries that name, so its handlers do too:

  | Category | Name | What the messages describe |
  | --- | --- | --- |
  | 0 | FieldTalkEvents | field events |
  | 1 | GreatLogTalkEvents | messages $00xx–$02xx: Warubou, Prince Kameha |
  | 2 | KalkaTalkEvents | messages $013x–$01Cx: the Kalka oasis |
  | 3 | YoldTalkEvents | messages $08xx: Yold, Polona, Port Ritz |
  | 4 | NordenTalkEvents | messages $03xx, $0ABx |
  | 5 | FhuntTalkEvents | messages $04xx: Fhunt, Pei |
  | 6 | DarckTalkEvents | Darck's scripts |
  | 7 | ElvenVillageTalkEvents | messages $07xx, $0Cxx |
  | 9 | KeyWorldTalkEvents | the key world |
  | $0A | ReadableTalkEvents | notices and bookshelves |

  The farcall stubs follow as DispatchTalkEvent_To<Name>.
- **Menu and battle dispatchers**, each by its step calls or strings:
  - Breeding: BreedMenu_ChooseParents, NpcBreedMenu_ChooseAndBreed, EggServiceMenu_ChooseAndPay, EggServiceMenu_Bank1B_PickRecords.
  - Other menus: HibernateMenu_ChooseRecords, PriestMenu_PayForService, LibraryMenu_ShowMonsterEntry, MedalPrizeMenu_ChoosePrize, KeyAppraisalMenu_ChooseKey, GameMode6_Update_SavePrompt.
  - Monster lists and stats: SwapMonstersMenu_ShowMonsterDetails, SwapMonstersMenu_MoveRecords, RunScreenStateWhenNotFading_F1_ShowRecordStats, RunLinkSession5Exchange_ShowRecordStats.
  - Pause menu: PauseMenu_Skills_UseFieldSkill, PauseMenu_Items_UseItem.
  - Link: LinkKeyTrade, RunScreenStateWhenNotFading_F1_LinkBreed, RunLinkSession5Exchange_LinkBreed.
  - Battle: RunBattleSetup_FleeCommand ('Retire now?', '0 fled!'), RunBattleSetup_CommandMenu, RunBattleActions_StatusChecks ('0 woke up!', 'SealPray was broken!'), RunBattlePhaseWhenTextIdle_A0_IntroduceMonsters ('The first monster is 0!'), RunBattlePhaseWhenTextIdle_A0_ResultsScreen ('RESULTS', 'received WG.').
- **Not named.** RollCounterChanceAndRunEvent_Sub01 is the largest bare dispatcher: 75 cases that add to wTopStat1 and adjust wFamilyScores. Its meaning is not established, so it keeps its structural name.
- **Counts.**
  - Bare dispatchers: 200 → 166.
  - Labels under a bare dispatcher: 2,201 → 1,245.
  - Structural labels the generator leaves unnamed: 308 → 266.
- **Second batch** (same method):
  - Battle: BattleEnd_GainExperience, RunBattleActions_UseItem, RunBattleStep4_ResolveSkill, RunBattleSetup_BankA0_CommandMenu.
  - Indexed and debug: ApplyEquipmentEffectKeepA_ByItem (indexed by item id - $40), DebugStaffRoll_Scene00-04.
  - Save screens: GameMode6_Update_Save, GameMode6_Update_ChooseRecordAndSave.
  - Link and effects: RunLinkSession4ScreenState_StartWithPresetRules, RunEffectRoutineEffectEvery5Frames_ShakeScreen, RunBattlePhaseWhenTextIdle_A0_SyncLink.
  - After both batches: bare dispatchers 151; labels under them 1,012; structural labels unnamed 250.
- Binary verification: build/run386 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0287 — Branch targets become local labels named by shape; two sound routines named

- Kind: TOOL (naming of branch targets; C2 for the shape each name states, no claim about purpose).
- **What changed.** Every branch target that had only an address name (`Jump_BBB_AAAA::` without an alias) now has a name. There were 13,086 of them. localize_jump_labels runs on the rendered text after fold_idioms.
- **Local labels.** A target becomes an RGBDS local label (`.loop:`) when every code reference to it is in its own scope, between the same two global labels.
- **Global targets.** A target referenced from another routine stays global. It is named `<Routine>_<Shape>` after the routine it falls in, and keeps its address name as an alias.
- **Scope splitting.** A target that stays global splits the scope around it. The pass therefore repeats until the global set stops changing. A target that another file uses also stays global; the build is one assembly unit, so this only affects scope.
- **Shapes.**
  - `loop`: a conditional branch later in the same routine comes back to it. An unconditional jump back is a join and is named by what follows.
  - `return`: a lone `ret`.
  - `return_NN`, `return_0`, `return_carry`, `return_no_carry`: it sets A or the carry flag, then returns.
  - First RAM store, RAM load or named call within three instructions and before any branch: `set_x` (`clear_x` after `xor a`, `set_x_to_NN` after `ld a, $NN`), `check_x` or `read_x`, `call_x`.
  - `done`: it reaches `ret` first.
  - First instruction: `cp_NN`, `check_bitN`, `next` (inc/dec of a counter or pointer), `restore` (pop), `set_carry`, `to_x` (`jp` to a named routine).
  - `skip`: anything else (2,298 of them).
  - A repeated shape in one scope is numbered: `.skip2`.
- **Comments.** A comment that mentioned an address name now names the local as `Routine.local`.
- **Counts after the change.**
  - Shapes: `.call` 2,808; `.loop` 1,896; `.check` 1,264; `.set` 1,213; `.read` 876; `.next` 580; `.done` 529; `.return` 415; `.restore` 357; `.clear` 273; `.cp` 209.
  - Branch targets with only an address name: 13,088 → 0.
- **Two annotated targets named.** 00:3554 is StartChannelFromTrackHeader and 00:3938 is ComputeNotePitch, from their C2 annotations (E-0019). Before this, their annotations sat above bare address labels.
- **Tests.**
  - tests/test_local_labels.py covers 8 cases: a loop, the forward shapes, numbering, a target kept global with its alias, a reference from another file, scope splitting, comment rewriting, and that aliases are left alone.
  - The operand test now recognises local labels and skips alias lines.
- Binary verification: build/run382 PASS, 0 differing bytes; tests OK (skipped=3).

### E-0286 — Key-world and field talk-event commands named from their triggers and calls

- Kind: STATIC (C1 names; C2 for the trigger and call relations).
- Talk events are dispatched by DispatchTalkEvent on wTalkEventIndex (category), then wTalkEventGroup. Each category-0 group, category 8 and the category-9 groups start a one-command script whose command ($80–$A1) holds the event's state machine (E-0246). We found the constant groups by searching for their stores to wTalkEventGroup. Each command is named from the routine that stores its group and from the calls its states make.
- Examples:
  - $80 StepTriggerReward: group $0F, from CheckStepTriggerAndDispatchTalk. It gives gold (byte × 10), gives an item, or starts a battle.
  - $87 PartyDefeatedReturn: group $04. It calls MoveIncapacitatedPartyMembersBack, then StartReturnWarpByFlag25.
  - $9B HealPartyEvent: group $1A. It calls FullyHealParty.
  - $8B/$8C/$8D BreedFade/BreedChildSprite/BreedChildScene: groups $15–$17, from BreedMenu states.
  - $82 GoldItemOrLoss: category 8. It gives random gold or an item, or takes a gold loss (DeductGoldPenaltyAndFormatLoss). (Superseded by E-0293: the command is GreatLogFieldEvents, 13 scripted scenes; only two of them handle gold.)
  - $8A MapExitWarp and $8E MapLinkWarp: groups $07 and $08. Each fades, then sets the warp destination from the map exit records (E-0182) or the map link records (E-0238).
  - $93 WarpWithFollowers and $8F NpcBreedWarp: also set a warp destination.
  - $9A RandomBattleEvent: starts a battle (SetModeState3AndSaveScreen).
- $85 KeyWorldBossBattle (category 9, group 0):
  - shows a random message from $00D0–$00DF;
  - fights the monsters in wKeyWorldEncounter (one monster, or three when bytes 3–4 are non-zero);
  - after the "Warubou" message, sets wKeyWorldFlags bit 7, sets byte 3 of every wKeyWorldEncounterTable entry to 1, and sets bit 6 of byte 7 of the current key entry.
- $9E KeyWorldFloorBattle (category 9, group 3):
  - shows a random message from $00E0–$00EF;
  - fights the wKeyWorldEncounterTable entry for wKeyWorldFloor;
  - then sets that entry's byte 3 to 1.
- Names such as "Boss", "Floor" and "Return" are C1 readings of these writes. They have not been checked in play.
- No SCRIPT_TALKnn_xx constant or Talk0nEventxx routine name remains. The names.json notes for these routines now quote the new command notes.
- Binary verification: build/run377 PASS, 0 differing bytes; tests OK.

### E-0285 — Data labels named after reader, pointer run, stream kind or record; shared-helper roots

- Kind: TOOL (structural naming; C2 for the relations used).
- **Reader.** A data label with only an address name that code loads (`ld rr, n`) is named <Reader>_Data, or <Reader>_Data_AAAA when that routine loads several. The reader is the routine whose instructions load it; the comment still lists every reader. 483 labels.
- **Pointer run.** A target of a monotone pointer run is named <run label>_EntryNN, after the entry that points at it. PointerRun_BB_AAAA stands in when the run's first word has no name.
- **Stream kind.** Streams found only by tiling or in back-to-back runs are named KeyWorldScreen_BB_AAAA, ScreenMap_BB_AAAA (360 bytes) or Gfx_BB_AAAA. Together with pointer runs, 498 labels.
- **Record.** A label at a record boundary inside a laid-out table is named <Table>_<id>. 30 labels.
- Data labels with only an address name went from 1,029 to 18.
- **Fix.** Shared helpers (Root_SharedNN, E-0098) take the callers' common named root when their callers sit under differently named states (VaultMenu_Store and VaultMenu_TakeOut both lead to VaultMenu). E-0276 had left 8 routines with only an address name; there are 0 again.
- Binary verification: build/run373 PASS, 0 differing bytes; tests OK.

### E-0284 — No compounding; RAM names for wider routines; what is left

- Kind: TOOL.
- The naming rules now remember every label they give (shape_named) and never rename one again. An earlier test for "bare" had let a numbered descriptive name be renamed in the second pass ("..._ReadCurrentMusic_ReadCurrentMusic_Case21"). No compound names remain.
- The RAM rule (E-0282) also names routines that touch more than two symbols: Parent_Write<V>And<W>Etc, or Parent_Read<V>And<W>Etc.
- The generator logs what is left: 314 structural labels unnamed, of which 200 are dispatchers (`ld a, [state] / rst $00`). A dispatcher's CaseNN is the state value of its parent, so those numbers stay. The other 114 are steps that touch no named RAM and call only local code.
- Binary verification: build/run368 PASS, 0 differing bytes; tests OK.

### E-0283 — A second naming pass

- Kind: TOOL.
- The shape, string, main-call and RAM rules (E-0270 to E-0282) now act only on bare structural labels: a root followed only by CaseNN/SubNN/SharedNN parts. Already descriptive names are never compounded.
- The rules run twice, so a step whose only call went to a routine named in the first pass is named in the second. The second pass renames about 230 more.
- Bare structural labels: 754, of which 200 are dispatchers (`ld a, [state] / rst $00`). Their numbered cases are the state values, and they keep their numbers. The rest are steps that call only unnamed code or touch more RAM than two symbols.
- Binary verification: build/run365 PASS, 0 differing bytes; tests OK.

### E-0282 — Remaining helpers named by the RAM they touch

- Kind: TOOL (from build_xrefs' RAM use, which follows a routine's own branches to its returns but not into callees; C2 for the listed accesses).
- A bare structural routine (a root followed only by CaseNN/SubNN/SharedNN parts) that is not a dispatcher is named Parent_Write<V>[And<W>] when it writes one or two RAM symbols. Otherwise, when it reads one or two, it is named Parent_Read<V>[And<W>]. Examples: SoundNextEvent_WriteNR32, LibraryMenu_ReadScreenStep.
- The name records the RAM a routine touches, not what it computes.
- Dispatchers keep their numbers, since their cases carry their name.
- Binary verification: build/run364 PASS, 0 differing bytes; tests OK.

### E-0281 — Wait steps and constant-store steps

- Kind: TOOL (structural naming from the instructions; C2).
- A structural step that starts `ld a, [V]` (or `ldh`), then `or a` / `and` / `cp` / `bit`, then `ret z/nz/c/nc` is named Parent_Wait<V>, for example ..._WaitTextFlags. The name only records that the step returns early unless V passes the test.
- A step made only of constant stores to RAM (`ld a, n` or `xor a`, then stores, `ld [hl], n`, `inc hl`, a counter increment), then `ret`, is named Parent_Set<first V>.
- 226 wait steps and 95 store steps are renamed. Bare structural labels (a root followed only by CaseNN/SubNN/SharedNN parts) go from 1,631 to 1,395.
- Binary verification: build/run363 PASS, 0 differing bytes; tests OK.

### E-0280 — Branching steps named after their main call

- Kind: TOOL (structural naming from the instructions; C2 that the step makes the call, not that the call is all it does).
- The E-0278 rule is extended to steps of up to 24 instructions with conditional branches inside. A step ends at an unconditional `ret`/`jp` or at the next named label.
- A step is named Parent_<main call>. The main call is the first call that is not a generic helper; the generic list grows to cover screen-buffer rect draws, SRAM record access, list-cell addresses, table reads, compares and random-number steps.
  - Calls to structural or address-named routines are not used.
  - When a name repeats in a family, the case number is kept as a suffix.
- 2,354 steps are renamed, for example SwapMonstersMenu_Case04_LoadRecordCapacityFromFarmLevelTable, SwapMonstersMenu_Case05_WritePlayerNameWithFlag0SuffixToTextBuf0, SwapMonstersMenu_Case09_Case06_UpdatePagedListCursor.
- **Limit.** The name records one call the step makes; a step that branches may do other things on other paths.
- Labels ending in a bare case number go from 3,866 to 2,204. That count includes descriptive names that keep a case number for uniqueness.
- Binary verification: build/run362 PASS, 0 differing bytes; tests OK.

### E-0279 — AI skill score conditions

- Kind: OBSERVATION (reading; C1).
- Each AIScore_<skill>_Sub01 starts with a call and then calls check routines in turn, testing C after each (`ld a, c / and a, a`). All 80 reach ResetAISkillScore on a failing branch. They are renamed AIScore_<skill>_Conditions, and the notes list the checks.
- Structural labels go from 3,946 to 3,866.
- Binary verification: build/run360 PASS, 0 differing bytes; tests OK.

### E-0278 — Branch-free steps named after their main call

- Kind: TOOL (structural naming from the instructions; C2 for what is called).
- A structural step that is short and branch-free (at most 12 instructions, no conditional or relative jump, ending in `ret`) and calls at least one named routine is named Parent_<main call>, plus AndStep when it ends by advancing a counter.
  - The main call is the first call that is not a generic helper (BG-map address, rect copy, tile copy, sound, byte copy, multiply, divide); otherwise it is the first call.
  - Examples: BreedMenu_Case04_DrawRecordListPageNames, BreedMenu_Case04_ClearTileAreas1240_1700_14E0.
- 477 steps are renamed. Structural labels go from 4,262 to 3,946.
- Binary verification: build/run359 PASS, 0 differing bytes; tests OK.

### E-0277 — BreedMenu states that the code identifies

- Kind: OBSERVATION (reading; C1).
- BreedMenu states named where the code makes the role plain:
  - Init (clears $6F bytes); Setup (boxes, gold box);
  - NameEntry: RunNameEntryStateWhenNotFading on the record in list cell 4, plus DeleteSRAMRecordAndCompact;
  - ReturnToMap: LoadMapHeader, RestorePlayerPositionState;
  - TalkEvent17ThenNameEntry: talk event group $17, then state 6;
  - CopyToChildThenTalkEvent16: copies record word $0B and byte $6D to wChildRecord, talk event $16, then state 6;
  - TalkEvent15.
- The list and paging states (3-5, $0B-$12) share steps and stay structural until they are read.
- Binary verification: build/run358 PASS, 0 differing bytes.

### E-0276 — Menu states named: shop, Vault, inn

- Kind: OBSERVATION (reading; C1).
- Naming a menu's top-level states renames their whole subtrees (the generated cases follow the parent).
- **ShopMenu.** Init, Setup and ChooseAction (Up/Down/A/B), then:
  - Buy: ShopItemListTable, IsAmountInArg1AboveGold, SubtractArg1AmountFromGold;
  - Sell: inventory items priced by ComputeSellPrice (was ShopMenu_Shared03: ItemValueTable * ShopPercentTable / 100) and paid with AddArg1ToGoldCapped99999.
- **VaultMenu.** Init, Setup and ChooseAction, then Store (RemoveItemCountFromInventory into wItemStorage) and TakeOut.
- **InnMenu.** The states in order:
  - Init, ShowPrice, Pay (IsAmountInArg1AboveGold), FadeOut, WaitFade;
  - RestoreParty: for each party record whose byte $55 bit 7 is clear, HP = max HP and MP = max MP;
  - Morning (after $90 frames: SGB palette set, fade in, refresh objects), RestartMusic.
- build/name_by_label.py adds names.json entries for routines found by their current label.
- Binary verification: build/run357 PASS, 0 differing bytes; tests OK.

### E-0275 — Register-preset entries

- Kind: TOOL.
- A structural entry that only loads one register with a constant, then falls through or `jr`s into named code, is named <Target>With<R><n>, for example WriteTileBAtBGMap20FPlusGlyphListStartWithBC3. Entries into address-named local code (most of the 54 found) keep their structural names. 2 renamed.
- Binary verification: build/run356 PASS, 0 differing bytes; tests OK.

### E-0274 — Steps named after the string they show

- Kind: TOOL (C1 names from the E-0243, E-0248, E-0257 and E-0258 quotes).
- A structural step whose body, up to the next label, quotes exactly one string is named Parent_Show<first four words>. The quote can be a message word, a constant string display or battle text. Examples: PauseMenu_Items_Case02_ShowButNothingHappened, PauseMenu_Skills_Case00_ShowADeadMonsterCant.
- When a name repeats in a family, the case number is kept. 231 steps are renamed, and structural labels go from 4,539 to 4,297.
- The quotes follow the normal ShowMessageHL path, so a step in a key world or a menu with its own message mode can show different text.
- Binary verification: build/run355 PASS, 0 differing bytes; tests OK.

### E-0273 — Scene steps named after the message they show

- Kind: TOOL (C1 names from the E-0243 lookup).
- In the E-0272 shape rule, when the target is a message routine (names matching MessageHL or MessageCommand09HL) and the step loads HL with a constant message word, the routine is named Parent_MsgWWWW_<first four words>. Examples: SceneDarckDefeated_Msg053B_KingIThankYou, SceneThreeItems_Msg0A7C_KamehaIIHave.
- 34 cutscene steps are named this way. The quotes use the normal ShowMessageHL path, as in E-0248.
- Binary verification: build/run354 PASS, 0 differing bytes; tests OK.

### E-0272 — Single-purpose structural routines named from their shape

- Kind: TOOL (structural naming from the instructions; C2 for what each does).
- name_trampoline_cases (E-0270) now names more shapes of structural routine:
  - constant argument loads, one call or far call, an optional step increment (`ld hl, V / inc [hl]` or `ld a, [V] / inc a / ld [V], a`), then `ret`, or a lone `jp`: Parent_To<Target>, plus AndStep when it advances;
  - `ld a, n / ld [V], a / ret`: Parent_Set<V>To<n>;
  - a step increment alone: Parent_Advance<V>;
  - a lone `ret`: Parent_Return.
  - When a name repeats within a family, the case number is kept as a suffix.
- 389 routines are renamed, for example RunGameModeInit_Return, PauseMenu_State3_Case01_To…AndStep and RunPauseMenuScreen_AdvancePauseMenuScreen. Two tests that pinned case names now check the same property by pattern.
- Structural labels went from 5,044 to 4,539 (case_shapes count, which includes non-case structural names).
- Binary verification: build/run353 PASS, 0 differing bytes; tests OK.

### E-0271 — Script-starting talk cases named from the script's first message

- Kind: TOOL (C1 names from the E-0248 quotes).
- A structural routine whose body is an optional `ld a, n / ld [wDataBank], a`, then `ld hl, Script_X / call StartScriptAtHL_* / ret`, is named TalkScriptXXXX_<first words>. The words come from the first message of Script_X (the generated `; starts Script_X:` line), for example TalkScript4F54_HehSoTheseAreTheNewcomers and TalkScript5BA8_HowMayOurChurchServeYou.
- 94 routines are renamed (build/name_scriptcases.py, applied in place by build/apply_names_inplace.py).
- Binary verification: build/run352 PASS, 0 differing bytes; tests OK.

### E-0270 — Trampoline cases named after their target

- Kind: TOOL (structural naming from the instructions; C2 for what each does).
- name_trampoline_cases renames structural routines (Parent_CaseNN / _SubNN / _SharedNN) that only forward: one `call` then `ret`, one `jp`, or a far call (`ld hl` / `ld b` / `rst $10`) then `ret`. The new name is Parent_To<Target>, for example RunGameModeInit_ToGameMode0_Init and DebugMessageTest_Update_ToBeginStringDisplay_Bank28.
- It skips names from config/names.json, address-named targets, and targets that are siblings in the same family. 163 routines are renamed.
- Binary verification: build/run351 PASS, 0 differing bytes; tests OK.

### E-0269 — One-time treasures (script command $0A); a correction to E-0081

- Kind: OBSERVATION (reading plus ROM text; C1). **Correction** to E-0081.
- **Command $0A (RunOneTimeTreasure, was ScriptCommand0A_Run).** It reads three things:
  - wScriptParam0 = kind: 0 chest, 1 vase, 2 barrel, 3 chest with a Magic Key;
  - wScriptParam1 = item;
  - the word in wMessageIndex/wMessageGroup, passed to TestFlagBit and SetFlagBit, so a story flag.
  - When the flag is set it shows group-0 message $A1 + 3 * kind ("But it was empty"). Otherwise it adds the item to wInventory (kind 3: GenerateNewKeyEntry), sets the flag, and shows $A0 + 3 * kind ("0 obtained the Y."). When there is no room it shows $A2 + 3 * kind.
- **E-0081 had read DE as a message word.** The helper is renamed StartTreasureFlagDE_B04/_B13 (was StartMessageScriptDE_*). Its 69 configured MsgWWWW stubs and 69 more routines with the same shape are renamed ChestItem_<item>, VaseItem_<item>, BarrelItem_<item> or ChestMagicKey, with _FlagFFFF added for duplicates. The notes give kind, item and flag.
  - Their old names quoted unrelated strings: the "message word" was a flag number.
- Binary verification: build/run350 PASS, 0 differing bytes; tests OK.

### E-0268 — Talk-event cases named from their message (the E-0082 shape)

- Kind: OBSERVATION (pattern match plus ROM text; C1).
- **Check of E-0082.** The 38 TalkMsg/IfFlag names E-0082 derived from message text were compared with the corrected two-level lookup (E-0243). All match except for the player-name token: E-0082 used the separate E-0081 decoder, which read the tables correctly. Only the generator's quoting had been one string off.
- **Rule.** A routine with a structural name (`_CaseNN`/`_SubNN`/`_SharedNN`) whose whole body has E-0082's shape is named the same way:
  - the shape is zero or more `ld de, FLAG / call TestFlagBit / jr|jp|ret c|nc` tests, then `ld hl, $WWWW` and a `call` (then `ret`) or `jp` to StartMessageCommand09HL_*;
  - the name is TalkMsgWWWW_<first words>, or IfFlagFFFFMsgWWWW_<words> when a single `ret nc` gates it;
  - the words run until the tag reaches about 24 characters, with "0" written as Hero, and duplicates get the address appended.
  - The notes list the flag tests and quote the message. build/name_talkcases.py writes the entries.
- 450 DispatchTalkEvent cases were renamed. A test's floor on structural case names drops from 4,000 to 1,000.
- Binary verification: build/run349 PASS, 0 differing bytes; tests OK.

### E-0267 — Streams and bank-copy sources named after their destination

- Kind: TOOL (derived from call sites; C1).
- A call to DecompressToVRAM, DecompressToRAMLocked, CopyFromBankWaitVRAM or CopyFromBank is preceded by `ld de, source` and `ld hl, destination`, plus `ld b, bank` for the copies. When those loads are constants, a still address-named source is labelled after the destination:
  - `<Destination>Gfx_BB_AAAA` for compressed streams;
  - `<Destination>Tiles_BB_AAAA` for copies into VRAM;
  - `<Destination>Data_BB_AAAA` for copies elsewhere.
  - Examples: Tiles1Plus6E0Gfx_16_7B7D, Tiles2Plus7F0Tiles_1F_4110.
- Strings and other labels are only given these names when config/names.json does not name the address. This was also enforced for the E-0249 to E-0266 passes after two tests caught a clash.
- A test that checks pointer labels against `ld b` now also reads the bank from a `_BB_AAAA` suffix.
- Address-named data labels went from 1,236 to 1,029.
- Binary verification: build/run348 PASS, 0 differing bytes; tests OK.

### E-0266 — SGB packets named by command; special map records by index

- Kind: HARDWARE (SGB command codes) and TOOL.
- An SGB packet's first byte is command * 8 + packet count. The packets of the SGB packet sets (E-0179) are now labelled Sgb<Command>_BB_AAAA after that command (Pal01 ... DataSnd, MltReq, ChrTrn, PctTrn, ...). The SGB start-up sequence's DATA_SND packets in bank $1F are an example.
- The records of SpecialMapRecords are labelled SpecialMapRecordNN.
- Binary verification: build/run346 PASS, 0 differing bytes; tests OK.

### E-0265 — Skill prerequisite lists named by skill

- Kind: TOOL (C1 names from E-0159 and E-0026).
- `target_names` gains `"by": "skill"`, which uses skill names from StringTable_SkillNames (08:$4558). SkillPrerequisitePointers uses it, so each $FF-terminated list is labelled SkillPrerequisites_<skill>.
- The lists overlap: skill 1 (Blaze) points at [2, 3], and skill 2 at its tail [3]. The empty list is shared by many skills and takes the name of the first named skill that uses it.
- Binary verification: build/run345 PASS, 0 differing bytes; tests OK.

### E-0264 — Blocks copied into RAM, named after their destination

- Kind: TOOL (derived from call sites; C1).
- add_copy_source_blocks looks at each call to a copier whose registers are known:
  - CopyBytes (HL to DE, BC bytes), CopyBytesDEFromHL and CopyBBytesHLToDE (HL to DE, B bytes), CopyBytesDEToHL (DE to HL, BC bytes) and CopyBBytesDEToHL (DE to HL, B bytes);
  - byte-identical copies in other banks count too.
- When the five instructions before the call load a constant same-bank source, a RAM destination and a constant count, the source is laid out as `<RamName>Init_BB_AAAA` with that many bytes, for example SpriteSlotsInit_F0_6A18, Object1Init_..., OBJPaletteBufferPlus20Init_07_58FA. Sources that overlap another layout or carry a label inside are skipped.
- 11 blocks are laid out. A source loaded before a `jr` to a shared copy is only seen on the fall-through path.
- Binary verification: build/run344 PASS, 0 differing bytes; tests OK.

### E-0263 — Encounter words name their monsters

- Kind: OBSERVATION (reading; C1) and TOOL.
- **What an encounter word is.** LoadMonsterAndSpeciesForListEntryC (bank $19) takes word C of wEncounterMonsters as wMonsterId and loads that MonsterTable record (LoadMonsterRecord; ids from $250 come from MonsterTableA2). It then uses the record's first word (the picture number, E-0041) as wSpeciesId for LoadSpeciesRecord. So an encounter word is a MonsterTable id; random picks add 0-9 to a base (bank $0A).
- **Tool.** A new word-note kind `monster_table` follows the id to its record's species and names it ("MonsterTable $08A: WindBeast"). It applies to ScriptedEncounterTable, the EncounterGroup lists, ArenaEncounterList0-3 and GridEncounters0-3 (120 fields).
- `script_encounter n` lines list the three words of ScriptedEncounterTable record n. How many of them are fought is not read here; repeated $0001 (Slime) words may be filler.
- MonsterTable and MonsterTableA2 rows are tagged with the species of their first word (`id_names: monster_table`), for example `; id 1 Slime` and `; id 592 GoldSlime` (build/run343 PASS).
- Binary verification: build/run342 PASS, 0 differing bytes; tests OK.

### E-0262 — Monster record fields; per-field comments

- Kind: OBSERVATION (collected from earlier readings; C1) and TOOL.
- **The $A5-byte monster record.** PresetMonsterRecords and DefaultMonsterRecord are now laid out field by field from existing evidence:
  - state (byte 0, E-0104); name (1-10) and second name (15-24, E-0034);
  - word $0B (E-0236); $0D, whose low nibble is the family (E-0122);
  - skills $34-$3B (E-0122); the list at $3C-$54 that AppendMappedSkillsToWCA67 appends to (E-0237);
  - status bits $55 (E-0085); level $56 (E-0122); 24-bit EXP $58 (E-0125);
  - HP, max HP, MP and max MP at $5B-$62 (E-0122); personality axes $6F-$72 (E-0034); equipped item $A4 (E-0125).
  - The other bytes keep their offsets as names.
- **Tool.** A table marked `"field_comments": true` prints each field on its own line, ending with the field's name (after the id tag on the first). This is turned on for the monster records, SpeciesRecords, CartridgeHeader, KeyListMapDestinationTable and MapExitWarpTable.
- **Default.** Field comments are now on by default for any table, configured or derived, with 32 records or fewer and three or more distinctly named fields; the far-pointer bank bytes are ignored in that check. This covers map records ("tileset", "palettes", "variant 0 screens" ...), sound bank and record tables, key-world tilesets and area layouts, among others. Pointer lines (`dw`/`dfar`) carry the comment too.
  - Three tests that pinned exact lines now accept a trailing comment.
  - build/run340 PASS, 0 differing bytes; tests OK.
- Binary verification: build/run339 PASS, 0 differing bytes; tests OK.

### E-0261 — Bank $1C item name copy; a target-naming table option

- Kind: OBSERVATION (reading; C1) and TOOL.
- **ItemNamesCopy_1C (1C:$63FE, 99 words).** ShopMenu_Case03_Case03, ShopMenu_Case04_Case03 and VaultMenu_Case03_Case09 read the word for an item number and draw the $F0-terminated name as bank-$1F glyph tiles ($4010 + 16 * character). The names equal StringTable_ItemNames. Each is labelled ItemName1C_<item>.
- **Tool.** A table can now carry `"target_names": {"by": "item" | "monster" | "index", "prefix": ...}`, and its pointer targets are labelled prefix + name. A named item wins a shared target over item 0.
- A scan of the remaining address-named data found no other pointer table of 20 or more $F0-terminated names.
- Binary verification: build/run337 PASS, 0 differing bytes; tests OK.

### E-0260 — Names that spelled a callee's or table's address

- Kind: naming (TOOL-assisted, reviewed by hand).
- build/propose_names.py replaces a hex address in a configured name with the current label at that address (same bank, or bank 0 below $4000).
- 15 proposals were kept after review, for example:
  - ShowActionBattleTextFrom6DAA -> ShowActionBattleTextFromActionBattleTextTable;
  - RunFunc5E85Twice -> RunMoveIncapacitatedPartyMembersBackTwice;
  - MapAndCompactSkillList63D3/62F5 -> ...LinkSkillMapTable_A/_B;
  - InvertedResultOfFunc4E48 -> InvertedResultOfFailIfFoeAIDamageEstimatesAtLeastEstimate.
- Rejected proposals:
  - tokens that are numbers, not addresses (GoldAtLeast10000, message and talk-event ids);
  - matches running across a word boundary ("4D1A" in "...74D1And");
  - a name whose address is in another bank ("Func4001InBank81").
- A second pass, with stricter token boundaries (a token may not start inside a hex run, and a following capital must begin a word) and names that say InBankXX skipped, kept five more: LoadExpTableEntryToTemp2, AppendSpeciesToLinkCodeByteForWordAtDE, AddSignedEToByteAtHLClampedForActorEntryOfHL, OrDIntoTestBitDEOfBitArrayHLByte, StartArenaRankMessage (build/run336 PASS).
- Binary verification: build/run335 PASS, 0 differing bytes; tests OK.

### E-0259 — Dispatchers named by caller instead of address

- Kind: OBSERVATION (reading; C1) and naming.
- **RunLinkSession (1B:$4001).** It was a structural `ComputeSpriteScrollOffsets_Sub01`. Unless wLinkStatus bit 7 is set, it runs the routine for wLinkSession: 0 waits for the serial transfer, and 1-8 each run their own exchange state machine when wLinkMode is set and wLinkRole bit 0 is set. These are renamed from RunLinkExchangeState / _4431 ... _457B to RunLinkSession1Exchange ... RunLinkSession8Exchange.
- **Renamed by caller or role** (E-0122/E-0124 named them by state variable and address):
  - RunLinkSession4ScreenState (was RunLinkScreenState_6C12); RunLinkSession8Case01Steps / Case03Steps (RunScreenStep_F0_5B50/5DE8);
  - RunSceneScriptSubStep (RunScriptSubStep_7363, used by four cutscene commands);
  - RunGameMode5Case00SubStates / Case01SubStates (RunLinkScreenSubStateSubState_5B14/60E9);
  - CheckWarpsByMapType, LoadMapHeaderByMapType, RunGameMode2MapTypeState (RunMapType_596F/420D/A1_4744);
  - RunCommandEntryResolveStep, RunActionResolveStep (RunBattleResolveStep_43C4/69AA);
  - RunBattleEndStep4SubSteps / Step5SubSteps (RunBattleSubStep_6E67/6A4E);
  - ApplyEquipmentEffectKeepA (CallFunc4A98KeepA: item - $40 jump table from EquipItemOnRecordTargetRecord);
  - WithSRAMDrawMemberRecordByte0D (WithSRAMRun4E02);
  - RollCounterChanceAndRunEvent (RollCounterChanceAndRun72C8).
  - Their structural children follow. Config references are updated by build/rename_names.py.
- Binary verification: build/run334 PASS, 0 differing bytes; tests OK.

### E-0258 — Battle text quoted in code

- Kind: TOOL (C1 quotes).
- ShowBattleText runs the BattleTextPrepTable routine for D, then shows string D of category 1 in bank $2F (E-0045). An `ld d, n` followed within four instructions by a call or far call to ShowBattleText now ends with the quoted text, for example `ld d, $82 ; battle text '0 woke up!'`. There are 50 such sites; the others pass D in a register.
- Binary verification: build/run332 PASS, 0 differing bytes; tests OK.

### E-0257 — String displays quoted in code

- Kind: TOOL (C1 quotes).
- An `ld [wStringIndex], a` right after `ld a, n` now ends with the quoted string when the string can be resolved:
  - the category is a constant stored within a few instructions (`ld a, n` or `xor a`, then `ld [wStringCategory], a`);
  - the next call or far call goes to a BeginStringDisplay/ShowString/CopyStringToBuffer routine;
  - that routine either loads its table (`ld de, table`) directly or after one `call` (the ShowString_* entries), or is a message bank's entry.
  - Example: `ld [wStringIndex], a ; 'Pick the monster to rename.'` in RenameMenu.
- 72 sites are quoted. The rest set the category elsewhere or compute the index, so they stay unquoted.
- Binary verification: build/run331 PASS, 0 differing bytes; tests OK.

### E-0256 — Species lists by family and band (banks $F0, $60, $A0)

- Kind: OBSERVATION (reading; C1).
- **FamilyBandSpeciesTable (F0:$6CB5, 11 words).** RankFamilyScoresIntoFamilyRanking reads two words:
  - the word for the family (wFamilyRanking order);
  - then the word at 2 * wRankBand (BandOfFamilyBitCount: 4-7) of that family's list.
  - It walks the species words up to $FEFE, taking one when RandomModulo29_BankF0 gives an odd number, and stores the pick in wTopSpecies.
  - Families 0-9 have contiguous band lists (FamilyBandSpecies_<family>_NNN). The boss family's eight bands start at successive words of one list (FamilyBandSpecies_Boss).
- **KeyWorldBandSpeciesTable (60:$6D6D) and EncounterBandSpeciesTable (A0:$6D57), 88 words each (11 families x 8 bands).**
  - PickRandomMonsterFromBandList (bank $60) indexes the table with 16 * hTemp1 + 2 * hTemp0.
  - PickEncounterMonsterForSlotC (bank $A0) indexes it with 16 * PickRandomBand0To10 + 2 * wWildBand.
  - Each list is a count byte, then that many species words. They are laid out as KeyWorldBandSpecies_<family>_<band> and EncounterBandSpecies_<family>_<band>, with monster names on the words.
- Binary verification: build/run330 PASS, 0 differing bytes; tests OK.

### E-0255 — Item descriptions

- Kind: OBSERVATION (reading; C1).
- **ItemDescriptionTable (24:$7158, 99 words).** StepItemDescriptionText reads the word for the item number under the item grid cursor and shows the text from there, plus its counters wTextCounter1/2. There is one entry per ItemTable item.
- Each description is labelled ItemDescription_<item>, using the name from StringTable_ItemNames (08:$4716). When items share a description, a named item takes it over nameless item 0; for example Herb and item 0 share "Restores HP of one...".
- Binary verification: build/run328 PASS, 0 differing bytes; tests OK.

### E-0254 — Default monster names by family; name entry suggestions

- Kind: OBSERVATION (reading; C1).
- **DefaultMonsterNameTable (14:$7439, 11 words) and DefaultMonsterNames_<family> / DefaultMonsterNameStrings_<family>.** The table is indexed by the family as in StringTable_MonsterFamilies: 0 Slime, 1 Dragon, 2 Beast, 3 Bird, 4 Plant, 5 Bug, 6 Demon, 7 Zombie, 8 Material, 9 Water, 10 "????".
  - Each family block is 14 name pointers, then 14 six-byte names ($F0-terminated, padded).
  - The name entry screen copies name 7 * wArg2 + B (B < 7) of family wArg3 & $0F to wNameEntryText.
  - CreateMonsterRecordOfKindTemp1_Sub01_Sub01_Sub01 copies one (family wWorkBuf, name wWorkBuf + 1) into a new record.
  - The names are labelled DefaultName_<family>_NN.
- **NameEntrySuggestionTable (14:$791F, 140 words) and NameEntrySuggestions ($7A37-$7D7F).** For B >= 7, the name entry screen copies name 70 * (wArg2 & 1) + B - 7. The names are labelled SuggestedName_NN.
- This replaces about 300 monotone-pointer-table guesses.
- Binary verification: build/run327 PASS, 0 differing bytes; tests OK.

### E-0253 — Species records laid out and labelled by monster

- Kind: OBSERVATION (C1) and TOOL.
- **SpeciesRecordPointers (35:$403B, 384 words, by monster id) and SpeciesRecords ($433B-$7EB7, 324 contiguous 47-byte records).** CopySpeciesRecordPrefix (E-0062, E-0069) reads the word at $403B + 2 * id and copies from the record it points at.
  - The rows name byte 0, the family (E-0069), and byte 7, the EXP curve (E-0148). The other bytes are kept as rows.
  - Each record is labelled SpeciesRecord_<monster>, after the first id whose pointer names it.
- This replaces 324 monotone-pointer-table guesses.
- Binary verification: build/run324 PASS, 0 differing bytes; tests OK.

### E-0252 — Orphan pointer-table guesses dropped

- Kind: TOOL.
- drop_orphan_guess_labels removes a data label whose only reason was "target of a monotone pointer table" once nothing points at it any more: no `dw` word, code load, table, stream, script, sound track or configured name.
  - Such labels were left behind when their runs were undone (E-0165, E-0240) or laid out by tables.
  - Most marked zero padding in bank $38 or the insides of other data.
- 537 labels were dropped. Address-named data labels went from 2,845 to 2,308.
- Binary verification: build/run323 PASS, 0 differing bytes; tests OK.

### E-0251 — Key-world rooms labelled; the bank $95 string extension derived

- Kind: TOOL (derived from E-0141 and E-0217; C2 for the positions).
- **Key-world rooms.** Record n of KeyWorldRooms ($4181 + $63 * n) is labelled KeyWorldRoomNN. Its 16 tile maps and 16 attribute maps are labelled KeyWorldRoomNN_Y<row>X<column>_Tiles/_Attrs.
- **String tables.** add_string_table_schemas now looks four instructions back for the `ld de` before BeginStringDisplay/CopyStringToBuffer, instead of three. This finds bank $95's category table Data_095_4675, which BeginStringDisplay_Bank08_Sub01 and CopyStringToBuffer_Bank08_Sub01 use after subtracting 9 from wStringCategory.
  - There are now 51 derived string tables.
  - Bank $95's strings (skill descriptions, tactics, targets, ...) are labelled String_95_CC_II. The game's category number is CC + 9.
- Address-named data labels went from 3,652 to 2,845.
- Binary verification: build/run322 PASS, 0 differing bytes; tests OK.

### E-0250 — Map screens, key-world screens and sound tracks labelled by position

- Kind: TOOL (derived from E-0142, E-0144, E-0146 and E-0019 layouts; C2 for the positions).
- **Map screen streams** (2,352) are named `<array>_Y<row>X<column>`, for example Map49Screens0_Y0X0. The array is MapNNScreensK/AttrsK or SpecialMapNNScreens/Attrs, read row by row, and the width comes from the map record.
- **Key-world chunk groups** (732 labels) give `KeyWorldGG_K_Y<row>X<column>_Header/_Tiles/_Attrs`: sub-chunk K, the screen's place in its 4 x 4 grid, and the header (with the tile map 8 bytes after it) or the attribute map.
- **Sound tracks** (218) are named SoundTrack_BB_RR, after the bank and the first record of SoundRecords_BankBB that points at them.
- Address-named data labels went from 12,533 to 3,652, mostly guesses from monotone pointer tables and same-bank pointer loads.
- Binary verification: build/run320 PASS, 0 differing bytes; tests OK.

### E-0249 — Strings labelled by identity

- Kind: TOOL (derived from the E-0217 string tables, the E-0080 overflow tables and the E-0243 lookup; C2 for the identities).
- name_string_targets labels every string reached through a derived string table, 5,821 in all:
  - **Message_GG_II** for message banks: group GG (MESSAGE_GROUP_BANKS, first group per bank), index II in category 0 of MessageStrings_BankBB. From the bank's threshold up, the index runs on into its overflow table in another bank (Message_00_DA ...). Message word $GGII (bits 6-7 of GG are window flags) shows Message_GG_II.
  - **MessageBank0E_II** for bank $0E (wMessageMode 8), including its overflow in bank $96.
  - **String_BB_CC_II** (bank, category, index) for the other string tables; the table address follows the bank when a bank has two tables.
  - The first index naming a string wins. Entries that point at code are skipped. Address names stay as aliases.
- No string label keeps an address-only name (5,264 before).
- Binary verification: build/run317 PASS, 0 differing bytes; tests OK.

### E-0248 — Message words and started scripts quoted in code

- Kind: TOOL (C1 quotes, by the E-0243 lookup).
- **Message words.** An `ld hl, $XXXX` directly before a call or jump to a routine that takes a message word in HL (names matching MessageHL or MessageCommand09HL: StartMessageCommand09HL_*, StartMessageHL_*, ShowMessageHL) now ends with the quoted message. It uses the normal ShowMessageHL path (group = high byte & $3F). There are 1,354 such lines, most of them DispatchTalkEvent cases, for example `ld hl, $04CF ; '0 peered into the vase. It'`.
- **Started scripts.** A routine whose first four instructions load an event script gets a header line `; starts Script_XXXX: '<first message>'`; there are 160 such routines. The message is quoted under the script's message mode (E-0242).
- **Limits.** Talk events in key worlds go through the wMapType bit-7 path (banks $83/$8A), and menus through wMessageMode. Those messages are quoted by the normal path, so they can be wrong.
- Binary verification: build/run315 PASS, 0 differing bytes; tests OK.

### E-0247 — Map object records: byte 8 is the facing

- Kind: OBSERVATION (reading; C1).
- Record byte 8 goes to object slot byte 7 (E-0176). ScriptSetDirection writes a direction there for targets $80 + n, and ScriptStepObject stores the walking direction there. So the MapObjects_ record descriptions now call it "facing".
- Slot bytes 0 and $F (record bytes 4 and 10) stay unnamed. Their only direct writers set fixed values ($02, $FF), and no reader was found.
- Binary verification: build/run314 PASS, 0 differing bytes; tests OK.

### E-0246 — The last numbered script commands: key-world talk events and the arena

- Kind: OBSERVATION (C1 for the arena and $29; the talk-event names are structural).
- **$80-$A1 except $95/$96.** Each is the only command of a one-command script started by DispatchTalkEvent_Case00_Sub01 (talk event category 0, indexed by wTalkEventGroup), _Case09_Sub01 or _Case08. They are named after that case: SCRIPT_TALK00_0F (Talk00Event0F), SCRIPT_TALK09_03, SCRIPT_TALK08, and so on.
  - Their messages depend on the wMessageGroup each talk event sets, so they are not quoted.
  - $80's states give gold (a byte * 10), an item, or start a battle with intro 5.
- **$95 SCRIPT_ARENA_GRID_BATTLE / $96 SCRIPT_ARENA_ROUNDS.** Both start with StartMessageFromTable48B9ByArenaRank (ArenaRankMessageTable).
  - $95 takes its foes from GridEncounterTable (E-0236).
  - $96 takes its foes from ArenaEncounterLists and advances the round.
- **$29 SCRIPT_SCENE_WHO_ARE_YOU** comes before "Who are you? This is our...".
- After this entry, no `script_command` line uses a bare number. config/script_commands.json names 176 command types.
- Binary verification: build/run313 PASS, 0 differing bytes; tests OK.

### E-0245 — Cutscene and action script commands named; structural names re-prefixed by their parents

- Kind: OBSERVATION (C1) and TOOL.
- **121 more command types in config/script_commands.json.**
  - Action commands are read from the code: SCRIPT_CHECK_ITEM, SHAKE_SCREEN, WARP_MAP41, GIVE_ITEM_BLINK, TAKE_ITEM, GIVE_MONSTER, GATHER_FOLLOWERS, FOLLOWER_FACE_PLAYER, HIDE_SPRITES, BLINK_SPRITES, SAVE_SCREEN, SET_FLAG_322, SET_FLAG_REDRAW, SET_TILES_FLAG_310, SET_TILES_D2, KEY_BOSS_BEATEN, REWARD_ITEM_OR_KEY, PERSONALITY_MESSAGE, GROWTH_LIMIT_INFO and DESK_KEY.
  - One-off cutscene steps are named SCRIPT_SCENE_* after the scene their only script shows. Each note quotes the dialogue before and after the command, for example SCRIPT_SCENE_WATER_SHORTAGE ("King The town's water shortage seems...").
  - The implementations are renamed to match (SceneWaterShortage, GiveMonster, ...).
  - These scene names identify a scene; they are not a reading of what each step's code does.
  - Still numbered: $29 (no quoted context) and the key-world field events $80-$A1 in bank $12. The latter run from DispatchTalkEvent's group cases, and $80 is the treasure chest (gold = byte * 10, an item, or a battle with intro 5). They need a reading each.
- **Tool.** rename_address_prefixed_children runs after name_single_caller_helpers. Structural names derived from a parent's address name (Func_004_6892_Case00) now take the parent's name (DispatchTalkEvent_Case00_Sub01_Case00): 1,050 labels, with 0 address-prefixed structural labels left. Config notes and one test are updated.
- Binary verification: build/run311 PASS, 0 differing bytes; tests OK.

### E-0244 — The menu script commands named

- Kind: OBSERVATION (C1: the messages the scripts show around each command, quoted under the E-0242/E-0243 message modes, plus the tables and routines the implementations use).
- **config/script_commands.json** names 21 command types. The generator writes a `DEF SCRIPT_* EQU $XX` constant for each into src/macros.inc, and `script_command` lines use the constant. The implementations, which were ScriptCommandXX_Run, are renamed together with their structural children and every reference in config:
  - E0/E1 InnMenu/CloseInnMenu ("It's 0G a night");
  - E2/E3 ShopMenu/CloseShopMenu (ShopItemListTable, ItemValueTable);
  - E5/E6 VaultMenu/CloseVaultMenu (item storage);
  - E8 SwapMonstersMenu (Cobi: "What'll you switch it with?") and E9 CloseMenuE9;
  - EB/EC HibernateMenu/CloseHibernateMenu;
  - ED/EE BreedMenu/CloseBreedMenu;
  - EF EggServiceMenu (appraise and bless eggs);
  - F0/F1 RenameMenu/CloseRenameMenu (the Christener);
  - F2 KeyAppraisalMenu; F3 MedalPrizeMenu (TinyMedals);
  - F4 NpcBreedMenu ("Who will breed with my SpikyBoy?", one partner per wScreenTableIndex);
  - F6 LibraryMenu; F7 ArenaMenu; F8 PriestMenu (revival).
- These cover 429 of the 633 `script_command` lines. The remaining 204 lines use about 150 types, most of them once each: cutscene steps (object choreography, item and key hand-overs), which keep their numbers.
- Binary verification: build/run309 PASS, 0 differing bytes; tests OK.

### E-0243 — Message quotes were one string off; message modes through $E7 and the closing commands

- Kind: OBSERVATION (reading of BeginStringDisplay/LookupString use by the message banks; C2 for the lookup) and TOOL. **Correction** to E-0153 and every message quote since.
- **The off-by-one.** Each message bank's displayer passes MessageStrings_BankBB ($4032; bank $86: $4016) in DE to BeginStringDisplay. LookupString then reads two levels: the word for category 0 (wStringCategory = 0, which is $4034, the list right after it), then word `index` of that list. message_preview had read $4032 itself as the list, so every quote showed string index - 1.
  - Example: message $0001 is "Cobi 0! Papa's calling. He's at the stern.", not "In the middle of the sea". In bank $28, flat word 1 equals list word 0.
  - The overflow tables go to BeginStringDisplay too and are read the same way.
  - Message-word notes in tables (`names: message`) use the same routine and are corrected with it.
- **Modes, continued from E-0242.**
  - The mode is carried through $E7 into the data bank the caller set.
  - F0 (the Christener's renaming) runs ScriptCommandEF_Run in its first state, so it sets mode 6.
  - F6 (the library) keeps mode 9 for the farewell it shows between calls.
  - Mode 8 (0E:$4001) is a message bank like the group banks (threshold $88, overflow in bank $96), so its messages are quoted.
  - The closing commands (E1, E3, E6, E9, EC, EE, F1) clear the mode only on an immediate second call, so the farewell between the two calls is quoted from the menu's table. The shop's "Thank you! Please come again." is an example.
  - $EA and $F5 quotes are prefixed "flag 0 set:" and "screen 0:", since they quote the index as written.
- Binary verification: build/run308 PASS, 0 differing bytes; tests OK.

### E-0242 — Named script opcodes; script message quotes follow wMessageMode

- Kind: OBSERVATION (reading of the fetch handlers, ScriptCommand09_Case01_Sub01 and the menu commands; C1) and TOOL. **Correction** to E-0153's quotes.
- **Opcodes with inline bytes, now named macros.** Every `script_op` line is gone:
  - $01 `script_walk object, direction, tiles`: type 02, ScriptStepObject. Param0 = direction << 4 | object; one pixel a frame, 16 frames a tile; directions 0 down, 1 right, 2 up, 3 left.
  - $02 `script_walk_fast`: type 03, whose stub runs ScriptStepObject twice a frame.
  - $03 `script_wait frames`: a 16-bit little-endian count (ScriptWaitFrames).
  - $04 `script_hold_dpad direction, frames`: ScriptCommand05_Run sets the D-pad bit of wJoypadHeld (down/right/up/left = bits 7/4/6/5) for that many frames.
  - $05 `script_face target, direction` (ScriptSetDirection).
  - $0B `script_slide_y target` (ScriptSlideObjectY).
  - $0C `script_hide_object n`: ScriptFetch0C stores $E0 in byte $C of sprite slot n at once.
  - $0D `script_encounter n`: ScriptCommand0E_Run calls StartScriptedEncounterTemp0 with n.
  - $EA `script_message_unless_flag0`: the index gets + $20 unless story flag 0 is set.
  - $F5 `script_message_by_screen`: the index gets + 16 * wScreenTableIndex.
- **Message modes.** ScriptCommand09_Case01_Sub01 is the script message display. When wMessageMode is non-zero it ignores the group byte. It passes the low byte as the string index (category 0) to the displayer the mode picks from Data_010_4AFF (3-byte far pointers):
  - modes 1-2: F0:$4001; 3: 1F:$520E; 4: 1D:$4001; 5: 1B:$4C86; 6: F2:$43D0; 7: 0D:$4001; 8: 0E:$4001; 9: 0B:$4001; 10: 33:$6490; 11: 24:$5D10.
  - The menu commands set the mode in their first state: E0 1, E2/E5 2, E8 3, EB 4, ED 5, EF 6, F2/F3 7, F4 8, F6 9, F7 10, F8 11.
  - E1, E3, EC and EE (and a later state of F6) clear it.
- **Tool.** prepare_scripts propagates the mode along each script's flow, starting from 0 at every start site and data-bank entry. Where paths disagree the mode is marked unknown. Messages under a known non-zero mode are quoted from that mode's string table; under an unknown mode they get no quote.
  - Example: the ship shop script Script_6659 now reads 'What would you like to buy?', 'That comes to 0G. OK?' instead of unrelated story lines.
  - Mode 8's displayer has no `ld de, table`, so its messages are not quoted.
- Binary verification: build/run305 PASS, 0 differing bytes; tests OK.

### E-0241 — Last uncommented INCBIN (F0:$70C5)

- Kind: OBSERVATION (C0).
- **UnreferencedBytes_F0_70C5 ($70C5-$7245, 24 rows of 16).** No reference was found in any bank: no address load, no word, and no split high/low load. The values are 0-7, in runs that climb to 6 or 7 separated by zeros. The meaning is unknown.
- After this entry, every INCBIN left in src/ carries an asset comment (an LZSS stream with its expanded size, an SGB transfer, and so on). build/measure2.py reports 0 unidentified bytes.
- Binary verification: build/run303 PASS, 0 differing bytes; tests OK.

### E-0240 — MonsterTableA2, sequence frame lists (bank $32), pointer words inside streams; a stricter measure

- Kind: OBSERVATION (reading; C1) and TOOL.
- **MonsterTableA2 (A2:$4070, 93 x 26).** CopyMonsterTableBytesFrom4056 and LoadMonsterRecordTo_Sub01 read $4056 + 26 * (id - $250 + 1) for ids from $250 (E-0033), so id $250 starts at $4070. The records run up to the code at $49E2 with the MonsterTable layout. This removes 12 false "back-to-back" streams.
- **SequenceFrameTable (32:$40A6, 60 words) and SequenceFrames* ($411E-$4ADC).** LookupSequencePtrLoFrameWord takes list [seq + 2] and entry [seq + 3].
  - Each entry is a frame byte and a timer byte. Low byte $FE steps back B entries; $FFFF ends the sequence.
  - The LZSS comments on these lists were false pointer-run streams; declaring the table removes them.
- **Tool.** drop_stream_pointer_runs undoes heuristic `dw` words, and removes the target labels only they created or that are left unreferenced, strictly inside a compressed stream that has its own evidence. A stream counts as having evidence when it was found from a decompress call or a layout table, or when it is a 360-byte screen in a back-to-back run. Such labels had cut streams into unannotated INCBIN pieces:
  - SGBBorder2TilesA (18:$49C1);
  - Map49Tileset and Map58Tileset (bank $5E);
  - key-world screens in bank $50.
  - In total, 132 words and 74 labels were undone.
- **Measure.** measure_data counted an INCBIN as identified when any exported candidate stream overlapped it, including overlapping phantom candidates. build/measure2.py instead counts only slices introduced by an asset comment.
  - By that rule, unidentified bytes were 5,590 before this entry and 384 after it: F0:$70C5-$7245 (values 0-7, no reader found yet).
- Binary verification: build/run302 PASS, 0 differing bytes; tests OK.

### E-0239 — Action-id effect table (bank $3B), cartridge header, prompt window, glyph tile tables (bank $1D), trigger sprites, remaining small layouts

- Kind: OBSERVATION (reading; C1, code entries C0), HARDWARE (header layout) and a correction.
- **ActionIdEffectTable_3B ($4B11, 64 code words).** Func_03B_4B02 jumps to the word at 2 * wBattleActionId. Entries 0 ($4B91) and the 12 at $4C94 are lone `ret`s (ActionIdEffectNone_*).
  - **Correction:** two entries are $4E60 and $4E66, which E-0236 had named Unreferenced*. They are renamed RollTableDamageWithMessage35 and RaiseWord3FAndRestoreHP; E-0236 is annotated.
  - The search for references there had looked only for labels, and this table was a `dw`/`db` run rendered from an `ld hl, $4B11` literal.
- **CartridgeHeader (00:$0104-$014F).** Laid out by the standard header fields: logo, title "DWM2-C", manufacturer "BQLE", CGB flag $80, licensee "B4", SGB $03, type $1B, ROM $07, RAM $03, destination $01, old licensee $33, version 0, and both checksums as stored. The bytes are unchanged.
- **TextPromptWindowTiles/Attrs (00:$2DFA, $2E1D).** AcknowledgeTextPrompt_Sub01 writes 5 rows of 6 bytes ($FD = next row, $FE = end) to the BG map; the attributes go to VRAM bank 1 on CGB.
- **Bank $00 code.** UnreferencedReturn_00_1339 is a lone `ret`. UnreferencedStartSoundFadeA ($133A) sets the sound fade level, target, timer and NR50 copy from A; no reference to it was found.
- **DefaultMonsterRecord (24:$52ED).** CopyDefaultRecordToRecordBufB copies it to wRecordBufB; it has the E-0235 record layout.
- **RecordA4StringTileCounts_F1/_03 (F1:$45CB, 03:$5C43; identical, 36 pairs).** These are the tile counts for the two rows of the string selected by record byte $A4.
- **GlyphTileDestTable_1D_0-4 ($61D9-$62AD).** The bank-$1D copy of the E-0235 selector; it has five tables (wArg5 0-3, else).
- **TileRect_85_4583.** An unreferenced 8 x 9 frame.
- **TriggerSpriteRecord0/TriggerSpriteTable (12:$71E8, 11 x 6).** ScriptCommand84_Run_Case04_Sub01_Sub01 indexes the records with wTriggerKind and reads:
  - a far pointer to sprite graphics, decompressed to vTiles0 + $400;
  - a palette byte offset from 7E:$4BBD (copied on CGB).
  - Record 0 is all zero.
- Unidentified INCBIN went from 1,598 to 798 bytes.
- Binary verification: build/run299 PASS, 0 differing bytes; tests OK.

### E-0238 — OBJ palettes (bank $7E), field command sprites, shop item lists, sound test tables, map exit warps, tile upload runs

- Kind: OBSERVATION (reading; C1, code entries C0) and TOOL.
- **ObjPalettes_7E_4BBD (38 palettes, up to the stream at $4CED).** It continues FieldSpritePalettes. Loaders in banks $00, $07, $12, $A1 and $E0 copy 8 bytes from $4BBD (+ $C8), $4C0D, $4C65 or $4CAD, or from $4BBD + 8 * index, to wOBJPaletteBuffer slots.
- **FieldCommandSpriteTable (12:$704C, 22 x 4).** RunFieldCommandTemp0_Shared01/_Shared02 index it with hTemp0 & $7F:
  - they decompress the bank-$7E word to vTiles0 + $400;
  - on CGB, byte 2 & $7F picks the ObjPalettes_7E_4BBD palette copied to wOBJPaletteBuffer + $20;
  - byte 3 is returned.
- **ShopItemListTable (1C:$6158, 24 words; ShopItems* lists up to $6289).** LoadArg1PointerForScreenTableIndex and LoadArg1ByteForItemGridXItemGridY read byte 4 * wItemGridY + wItemGridX of the list for wScreenTableIndex. Each list is item numbers ending with $FF.
- **TileDestTable_1C_6289 (4 lists of 9 VRAM addresses).** Indexed by wScreenCounter, then wGlyphListPos. The bank-$1F tile at $4910 is copied to each address.
- **DebugSoundTestMusic (01:$65DE, 32) and DebugSoundTestEffects (01:$65FE, 84).** DebugSoundTest_Update passes the bytes to QueueMusic and QueueSoundEffect and draws them in hex.
- **MapExitWarpTable (12:$5130, 16 x 5, then $FF).** Matched on hMapId. Byte 1 becomes hMapId. Bytes 3-4 go to ScriptCommand8E_Run_Case01_Sub01 as the destination (X/Y nibbles, then the screen byte), unless the active key world's wKeyWorldKey - 1 equals byte 2, in which case wKeyWorldGoal is used.
- **Bank $A0/$31 code.** The 80 identical bytes after ShowStringBank08AtTilesHL_BankA0 ($6CF7) and at 31:$7A78 are UnreferencedShowFiveGlyphsAtTilesHL_*. They copy five glyphs to wTextBuf0 and show string 2/0 in a 5 x 1 window at HL.
- **Tool.** add_tile_upload_runs treats `ld hl, n` followed by k calls to a 16-byte VRAM copier as k tiles at n. Only `ld de, n` may come between the calls. A copier is any routine named CopyTileBytesToVRAM*, including byte-identical name-family copies. The pass found 10 runs; F1:$57A7 was renamed CopyTileBytesToVRAM_BankF1.
- Unidentified INCBIN went from 2,656 to 1,598 bytes.
- Binary verification: build/run297 PASS, 0 differing bytes; tests OK.

### E-0237 — Action handler masks, key-world return destinations, arena messages, item order lists, shop values, skill replacement pairs

- Kind: OBSERVATION (reading; C1, code entries C0).
- **ActionHandlerMaskTable (30:$4D34, 240 words).** ActorActionDataWord reads the word for the actor's chosen action byte. RunActorActionHandlersForAISlots skips $FFFF and passes any other word to RunHandlersForSetBitsInBC. The table runs up to that routine.
- **KeyListMapDestinationTable (02:$7006, 13 x 8).** After Jump_002_6EC7, the code indexes it with the key list byte & $3F and loads hMapId, hMapScreenX, hMapScreenY, hPlayerX and hPlayerY from bytes 0-4. Bytes 5-7 are not read.
- **ArenaRankMessageTable (12:$48B9, 6 x 8 words).** StartMessageFromTable48B9ByArenaRank passes the low byte at 2 * A + 16 * wArenaRank (row 5 when wArenaFlags bit 7 is set) to StartMessageA.
- **ItemOrderListA/B (F2:$6526, $6586).** Each list is 95 bytes plus $FF. ScriptCommandE5_Run_Case03_Case0E_Sub03_Sub01 copies the wInventory bytes that match, in list order, to wWorkBuf. That makes these an inventory sort order.
- **ShopPercentTable (1C:$6320, 24 bytes) and ItemValueTable (1C:$6338, 99 words).** ScriptCommandE2_Run_Shared03 computes word[DE] * byte[wScreenTableIndex] / 100, and its three callers pass DE = 2 * a wItemGrid byte. The percentages are 75, 80 and one 0.
- **SkillReplacementPairs (A0:$597A, 44 pairs, then $FF $FF).** AppendMappedSkillsToWCA67 maps each byte at wRecordBufB + $34 through the pairs and appends it after the used bytes at wRecordBufB + $3C.
- **Tiles_0C_4718.** ScriptCommandF6_Run_Case10_Case00 copies these 6 tiles to vTiles2 + $610.
- **Bank $05 code ($61C4-$6226).** UnreferencedEstimateStrongestFoeHit computes the highest opposing ATK minus half the actor's DEF and subtracts it from the actor's HP, but returns C = $FF on both paths. After its `ret`, an unreachable `ld c, $00 / ret` follows (UnreferencedReturnC0_05_6223).
- Unidentified INCBIN went from 3,690 to 2,656 bytes.
- Binary verification: build/run294 PASS, 0 differing bytes; tests OK.

### E-0236 — Unreferenced battle routines (bank $3B), increment rows, grid encounters, talk-event word lists, listed strings as text

- Kind: OBSERVATION (reading; C1, code entries C0) and TOOL.
- **Bank $3B code ($4E60-$4ECF).** Bytes after `jp Jump_03B_4F15` at $4E5D decode as two unreferenced routines; configured code entries at $4E60 and $4EB8.
  - UnreferencedRollDamageWithMessage35 ($4E60). **Superseded by E-0239:** ActionIdEffectTable_3B points at it, and it is now RollTableDamageWithMessage35.
  - UnreferencedRaiseWord3FAndRestoreHP ($4E66). **Superseded by E-0239:** also a table entry, now RaiseWord3FAndRestoreHP.
  - $4EB8 is a 6-byte `ld hl, $D035 / ld bc, $88A8` that the `jr` before it skips; it falls into the message store at $4EBE (UnreferencedStoreResolveMessage35D0).
  - The new caller turned $483A from a structural `_Sub01` into a shared routine, now named RestoreTargetHPByActionAmount: max HP for action $03, a random 30-40 for actions $01/$38, else a random 60-70, added to HP and capped at max HP.
- **IncrementOffsetRows_A0 (A0:$4387) and IncrementOffsetRows_19 (19:$4641).** These are 7 identical rows of 16 bytes. ApplyTable4387IncrementsForA0DTo13 (and the bank $19 copy for $4641) takes row A - $0D and, for each byte before $80, increments the byte at DE + $FF00 + byte, capped at 3.
- **UnreferencedMetaSpriteSet_E1 (E1:$5D3C).** Two frame pointers and two E-0147-shaped frames (12 and 14 sprites, each list ending with $80). This is the shape only: no reference was found and the bytes occur nowhere else.
- **GridEncounterTable (0C:$7897).** ScriptCommand95_Run_Shared02 sets battle intro 4 and encounter kind 2, then reads two words:
  - the word at 2 * wGridCursorX;
  - then the word at 2 * wScreenCountPlusOne of that list.
  - It copies 6 bytes from there to wEncounterMonsters. There are 4 lists of 3 pointers, each list followed by its three 6-byte records.
- **TalkEvent29WordList (85:$5912, 29 words) and TalkEvent47WordList (85:$5991, 113 words), each ending with $0000.**
  - DispatchTalkEvent_Case05_Case29_Sub01 and _Case47_Sub01 compare the words with hPlayerSpriteStreamLo/Hi (when hPlayerSpriteOverride bit 7 is set and bit 0 clear).
  - The first one otherwise compares them with record word $0B of party records whose byte $55 bit 7 is clear.
  - The earlier `dw Data_085_5A00 ...` pointer run inside the second list was false.
- **Tool.** text_runs_for now also treats each string named by a derived string list (E-0217) as text, from its start through its $F0. It stops at masked bytes or at the next listed start, even where control-code arguments (for example `$E8, "60"`) defeat the prose heuristic. This brings 2F:$78B7 and others out of INCBIN.
- Unidentified INCBIN went from 4,601 to 3,690 bytes.
- Binary verification: build/run293 PASS, 0 differing bytes; tests OK.

### E-0235 — Glyph tile destination lists and preset monster records (bank $0D)

- Kind: OBSERVATION (reading; C1).
- **GlyphTileDestTable0-3 ($5F89, $5FF1, $6041, $60A9) and GlyphTileDests*.** The routine ending at $5F86 picks a table by wArg5 (0, 1, 2, else $60A9) and then reads two words:
  - the word at 2 * C in that table;
  - then the word at 2 * wGlyphListStart in the list it points at.
  - It returns that word as HL (a VRAM tile address), with DE = $4010 + 16 * glyph, B = $1F and C = $10, for a bank-$1F tile copy.
  - Tables 0-2 hold four lists each, of 12, 9 and 12 words; table 3 holds one list of 12 words.
- **PresetMonsterRecordTable ($78D6, 16 words) and PresetMonsterRecords ($78F6, 10 x $A5).** ScriptCommandF4_Run_Case04_Case13 copies $A5 bytes from the record at word [2 * wScreenTableIndex] to wRecordBufB.
  - The last six words repeat the first.
  - The records use the SRAM record format. Only byte 0 (E-0104) and the two names at bytes 1-10 and 15-24 (E-0034) have read meanings; both names are "???". The other bytes are kept as rows.
- Unidentified INCBIN went from 5,677 to 4,601 bytes.
- Binary verification: build/run290 PASS, 0 differing bytes; tests OK.

### E-0234 — Tactic offsets (bank $30), effect tile blocks (bank $3A), unreferenced frames, key-world screens after tables

- Kind: OBSERVATION (reading; C1) and TOOL.
- **TacticOffsetTable (30:$5384, 4 words) and TacticOffsets0-3 ($538C-$540C).** The code at Jump_030_5307 indexes the table with GetActorSlotTacticLow2 (wSlotTactic & 3) and adds two offsets to the block address:
  - E is $10 when wSlotTrait >= $97, else 0;
  - C is 0, 4, 8 or 12 from a threshold test on A.
  - CopyFourBytesNegatedByActorSlotTactic then copies four bytes to hTemp0, negating each one when bit 6 of the tactic byte is set. Each block is eight 4-byte records. What the bytes mean is not read.
- **EffectTileBlockTable (3A:$4D5C, 4 words) and EffectTileBlock0-3.** Two effect routines read the word at index 3 or wBattleTarget & 3 and pass it to CopyVRAMRectToBuffer with C = 6. Each block is 6 x 6 tile numbers; block 3 is all $C3.
- **Unreferenced frames (0C:$7796, $77F1, $7809; F0:$65AE, $65D1, $65F4).** No reference was found.
  - The bytes form window frames out of the same frame tiles as the referenced rectangles beside them: top row $B0 $B1.. $B2, sides $B6/$B7, bottom row $B3 $B4.. $B5.
  - F0:$65F4 is the top row of a 7 x 5 frame; its other four rows are the referenced TileRect_F0_65FB.
  - F0:$65A5 (9 bytes, $B2 then eight $B7) stays C0 bytes.
- **Tool.** tile_keyworld_screen_gaps (E-0222) now also seeds a gap at the end of a declared table, in banks that already hold a key-world screen stream. This finds the header-plus-screen pairs that follow a key-world palette set (65:$4CB9, 63:$51B0). It added 2 streams (4,676 total).
- Unidentified INCBIN went from 6,435 to 5,677 bytes.
- Binary verification: build/run289 PASS, 0 differing bytes; tests OK.

### E-0233 — Debug menu names and message test table (bank $01)

- Kind: OBSERVATION (reading; C1).
- **DebugMenuNames ($5F56).** 10 rows of 16 bytes plus an 8-byte last row. The debug menu copies the row at 16 * (wDebugState - 1) up to $F0 to wNameGlyphBuf and draws it with CopyGlyphTilesToVRAM.
  - The bytes are glyph codes that charmap.inc renders as nonsense Latin letters, so they are kept as bytes.
- **DebugMessageTestTable ($4E54, 34 words) and DebugMessageTestSubLists ($4E98-$4ED4).** DebugMessageTest_Update_Case21 takes word wTemp0. A zero high byte is a value; otherwise the word points at one of seven sub-lists, whose format is not read.
- Binary verification: build/run287 PASS, 0 differing bytes; tests OK.

### E-0232 — Screen block records (bank $33); 27 false streams removed

- Kind: OBSERVATION (reading; C1) and TOOL.
- **ScreenBlockTable ($405F, 51 words).** CopyBlockToTileBuffer and CopyBlockToTileBufferBlankingText index it by E, deref the word, and read the record header inline (word offset into wScreenTileBuffer, width, rows) before copying the tiles. The 40 distinct records tile $40C5-$51C6 and are laid out as TileRect_33_*.
- **Correction.** The pointer-run stream source (E-0016) had registered 27 of these records as LZSS streams (for example 33:$4529, "390 bytes expand to 387"). Declared as tables, they are no longer tried (E-0203's rule). The stream count is now 4,674.
- **Generator.** The rectangle derivation also recognises the inline form: `ld hl, T`, index, deref, then `ld e, [hl] / inc hl / ld d, [hl] / inc hl / ld b, [hl] / inc hl / ld c, [hl]`. No table beyond this one uses it.
- Unidentified INCBIN is 6,731 bytes.
- Binary verification: build/run285 PASS, 0 differing bytes.

### E-0231 — Map warp lists laid out

- Kind: OBSERVATION (reading CheckWarpAtPlayer; C1).
- **Format.** CheckWarpAtPlayer walks the list at MapWarpTable[hMapId] in 9-byte entries until $80:
  - a facing byte (0-3 must equal hPlayerFacing; $FE/$FF match any facing; $FD skips the entry);
  - screen X/Y nibbles, player X and player Y (all matched);
  - five destination bytes.
- **Generator.** MapWarpTable now carries a `lists` option, so every list is a table (MapWarpsNN). 1,305 record lists are derived in all.
  - 15 pointer-run "streams" inside the lists are no longer registered (E-0203's rule), so the stream count is 4,701.
- Unidentified INCBIN is 7,503 bytes.
- Binary verification: build/run283 PASS, 0 differing bytes; tests OK.

### E-0230 — Streams found by tiling the gap after another stream

- Kind: TOOL (C1).
- **Rule.** After any stream other than a 360-byte screen (those are E-0222), the bytes up to the next label, stream, layout or code are tiled with streams that decompress cleanly to whole tiles (a multiple of 16 bytes). At most one repeated fill byte may follow the last stream.
- **Result.** Deliberately strict, it adds one stream: 16:$7D12 (67 bytes expanding to 64), after DecompressMenuTilesTo16E0's stream and before zero padding. No reference to it was found.
- Binary verification: build/run282 PASS, 0 differing bytes.

### E-0229 — Map item-use flags, family icon tiles, inventory sort keys (bank $16)

- Kind: OBSERVATION (reading; C1).
- **MapItemUseFlags ($51C9, 256 bytes, one per map).** ItemUsable_WarpWing tests bit 6, the ExitBell check (Func_016_44D0) bit 5, and Func_016_4645 bit 4. A clear bit refuses the item.
- **FamilyIconTiles ($7ACD).** 11 tiles of 16 bytes, read by LoadFamilyIconTileForWorkBuf at $7ACD + 16 * family.
- **InventorySortKeysA / B ($599E, $5A0E).** 112 bytes each: SortInventory sorts the 24 inventory slots by the key of each item id, in either of two orders.
- Binary verification: build/run281 PASS, 0 differing bytes.

### E-0228 — Two more unreferenced AI routines (bank $05)

- Kind: OBSERVATION (reading; C1).
- **AllySkillMPCosts_5AF8.** 6 MP costs that FailIfAllyLacksMPForSkillList5AF8 compares with an ally's MP.
  - The E-0102 data region at $5AF8 ran to $5B11. It is trimmed to $5AFE, as was done at $5A33 in E-0175.
- **FailIfAbleAllyKnowsSkill42To47 ($5AFE) and FailIfAbleAllyWithStatus6KnowsSkill78To92 ($5B57).** Both have the shape of FailIfAbleAllyKnowsSkillList6D1A (E-0175).
  - When the actor's AI mode is at least 3, they look for another able slot of the actor's side with a status bit clear or set that knows one of the listed skills.
  - No caller was found; they are configured code entries.
- Binary verification: build/run280 PASS, 0 differing bytes; tests OK.

### E-0227 — Two order lists and an unreferenced VRAM clear (bank $1D)

- Kind: OBSERVATION (reading; C1).
- **OrderList_1D_5186 / _51E6.** Two $FF-terminated lists of 95 numbers each, holding $01-$62 (with gaps) in two different orders. No reader was found, directly or through a computed base.
- **ClearVRAM9700Block_Unreferenced ($5246).** It writes $80 zero bytes from vTiles2 + $700, waiting for VRAM around each write. No caller was found; it is a configured code entry.
  - A first attempt seeded $5258, inside this routine; the entry was corrected to $5246, where the second list's $FF ends.
- Binary verification: build/run277 PASS, 0 differing bytes.

### E-0226 — "ClearRect" wrappers copy from DE; bank-$1D tile runs

- Kind: OBSERVATION (reading; C1) and a correction to E-0121 and E-0124.
- **Correction.** ClearRectSetTextCursorLoPlus21_Bank1D (1D:$5A32), ClearRectBothBanksSetTextCursorLoPlus1C1_Bank1D (1D:$59F0) and ClearRectBothBanksSetTextCursorLoPlus1C1 (1C:$67D0) do not clear.
  - They call CopyRectToBGMapWrapped with the rectangle at DE (B columns, C rows), set wTextCursorLo/Hi, and the two "both banks" versions copy again on CGB with VRAM bank 1 selected and WRAM bank 2 switched in.
  - They are renamed DrawRectSetTextCursorLoPlus21_Bank1D, DrawRectBothBanksSetTextCursorLoPlus1C1_Bank1D and DrawRectBothBanksSetTextCursorLoPlus1C1.
- **Raw rectangles.** The three wrappers are added to the E-0161 raw-rectangle copiers. 206 raw rectangles are now derived, including the 12 x 9 rectangles at 1D:$48FC and $4968.
- **BGMap1TileRun_1D_44E3 / _4547.** ScriptCommandE5_Run_Case03_Case00_Sub01 copies bytes to vBGMap1 + $300 until $7F: 99 tiles each.
- Unidentified INCBIN is 9,571 bytes.
- Binary verification: build/run276 PASS, 0 differing bytes.

### E-0225 — Tile copy lists derived from their copiers

- Kind: TOOL (C1).
- **Copiers.** A routine whose first 64 bytes load B = $1F and C = $10, call CopyFromBankWaitVRAM and compare with $FF copies one 16-byte bank-$1F tile per destination word until a low byte of $FF. 30 such routines are found, including CopyTileListFromBank1F_1C and the bank-$14/$1E routines of E-0200 and E-0224.
- **Lists.** For each call with `ld hl, A` / `ld de, B` in the four instructions before it, A is laid out as a destination list (up to and including the $FFxx word) and B as a source list of as many words (plus $FFFF when present). Lists that overlap another layout or code are skipped.
- **Result.** 29 lists derived (TileCopyDestList_* / TileCopySrcList_*), for example 1C:$5F86 / $5FE8. Unidentified INCBIN is 9,987 bytes.
- Binary verification: build/run275 PASS, 0 differing bytes.

### E-0224 — Name entry and naming screen tile lists (bank $14)

- Kind: OBSERVATION (reading; C1).
- **NameEntryKeyPositions ($61E2).** 5 rows of 17 position words, indexed by wNameEntryCursorY and wNameEntryCursorX.
- **Copy lists.** RunNameEntryStateWhenNotFading_Shared05 and ScriptCommandEB_Run_Shared04 copy one 16-byte bank-$1F tile per entry of a VRAM destination list, until $FFFF, from a parallel source list. The lists here:
  - NameEntryTileDestList ($6D56, 79 entries; ScriptCommandEC_Run_Case01 also starts from entry 23 at $6D84);
  - NameEntryTileDestListEmpty ($6DF6): only $FFFF, so the two cases that pass it copy nothing;
  - NameEntryTileSrcListA ($6DF8) and NameEntryTileSrcListB ($6E98, then 16 bytes of $FF);
  - NamingScreenTileDestListA/B ($5A28, $5A60).
- **Result.** Bank $14 has no INCBIN left.
- Binary verification: build/run273 PASS, 0 differing bytes; tests OK.

### E-0223 — Species pair-check lists (bank $81)

- Kind: OBSERVATION (reading; C1).
- **Table.** The routine at 81:$4001 reads the word at SpeciesPairCheckTable ($4167) + 2 * parent B's species. It parses that list twice with CallFunc4001InBank81KeepRegs_Sub01_Sub01, once with the parents swapped.
- **List format.** A list is groups of: kind, count, a key word, then count words.
  - Kind 0 applies when the key's low byte equals the family; kind 1 when the key equals the species.
  - Each word matches the other parent: a species when bit 15 is set, otherwise a family in the low byte.
  - Kind $FF ends the list.
  - When neither order matches, bit 4 of wRecordBufB + $D is set.
- **Layout.** The table has 321 words, and the lists tile $43E9-$5453 exactly (`lists` with `until`, one line per list). Bank $81 has no INCBIN left.
- **Limits.** What bit 4 of the record's byte $D means is not read.
- Binary verification: build/run271 PASS, 0 differing bytes.

### E-0222 — Key-world screens found by tiling gaps

- Kind: TOOL (C1).
- **Problem.** A key-world screen map stream was printed as an INCBIN up to the next label. When no chunk group (E-0146) reached the screens after it, they stayed inside that INCBIN. For example, 66:$5CD0's 28-byte stream sat in an INCBIN of $468 bytes.
- **Rule.** After a 360-byte stream labelled as a key-world screen map, the bytes up to the next label, stream, layout or code are tiled with streams that decompress cleanly to 360 bytes. Each stream may sit behind an 8-byte screen header. A gap is used only when it tiles exactly.
  - Example: 66:$5CEC-$6138 holds seven header-plus-tile-map pairs.
- **Result.** At first, 24 gaps tiled into 44 streams, with their headers as KeyWorldScreenHeader tables.
  - Widening the starting point to any 360-byte stream labelled as a screen (key-world room screens and map screens too) raises this to 50 gaps and 132 streams.
  - The stream count is now 4,693, and unidentified INCBIN is 14,638 bytes.
  - A final 8-byte remainder before a known stream is that stream's header. With this, 282 gaps tile (154 streams), the stream count is 4,715, and unidentified INCBIN is 12,141 bytes.
- **Limits.** Which rooms, if any, use these screens is not traced.
- Binary verification: build/run268 PASS, build/run269 PASS with the wider rule, build/run270 PASS with trailing headers; 0 differing bytes; tests OK.

### E-0221 — Key-world goal graphics (bank $04); party-count rectangles (bank $31)

- Kind: OBSERVATION (reading; C1) and TOOL.
- **KeyWorldGoalGraphicsTable (04:$423D).** 9 rows of 16 bytes. SetupKeyWorldObjectsForMapType_Sub01 replaces an object's graphics number n < 9 (when hTemp2 is set) with the byte at $423D + 16 * n + wKeyWorldGoalKind. Each row has 10 entries and 6 zero bytes.
- **PartyCountRects (31:$72C3, 3 words) and TileRect_31_757C / _75B8 / _761E.** CopyRectRecordForBattlePartyCount_Bank31 picks word wD88F - 1 and copies that record: 8, 14 or 20 columns by 7 rows.
- **Generator.** The rectangle derivation also follows `ld hl, T` / index / `ld a, [hl+] / ld h, [hl] / ld l, a` before a record copier: T is laid out as a word table of records, up to its first record. It found no tables beyond the ones declared here.
- Binary verification: build/run267 PASS, 0 differing bytes.

### E-0220 — Random byte table (bank 0); save-check rectangles and cursor positions (bank $07)

- Kind: OBSERVATION (reading; C1).
- **RandomByteTable (00:$0973, 128 bytes).** NextTableByte steps wRandomHi through 0-$7F and loads wRandomLo from $0973 + wRandomHi. The table ends at NextRandomSeed.
- **SaveCheckScreenRects (07:$5149, 3 words) and TileRect_07_514F / _52D7 / _52FF.** Jump_007_4A68 reads the word at $5149 + 2 * hTemp0 (CheckSaveData's result, at least 1) and copies that rectangle record.
  - The table has three words. Index 3 would read the first record's offset word ($0000) as a pointer.
- **CursorPositionWords_07_5086.** 60 BG map addresses. Bank-$07 menus read runs of them from $5086, $5096, $509E ... $50FA with the cursor helpers.
- **Result.** Bank $07 has no INCBIN left.
- Binary verification: build/run265 PASS, 0 differing bytes; tests OK.

### E-0219 — Action target routine tables (bank $39)

- Kind: OBSERVATION (reading; C1).
- **ActionTargetModeTable ($41AC).** 5 records of two words. ChooseActionTarget indexes it by 4 * wSlotAIMode[actor]. It takes the second word for battlers 4-7 when wLinkMode is 0 or 2, otherwise the first, then calls entry wBattleActionId through JumpToWordAtHL.
- **ActionTargetRoutines0-9 ($41C0-$5390).** Ten tables of 228 code words, one per action id (the SkillTable count, E-0204), back to back. They had been split between INCBIN slices and a few `dw` runs.
- **New code.** Their targets now trace six more routines, named by what they do: TargetRandomOtherAlly, TargetRandomAlly, TargetByAllyAGL and TargetAllyWithStatusBit10/40/20. `tools/rank_unnamed.py` reports 0 address-only routines.
- Binary verification: build/run263 PASS, 0 differing bytes; tests OK.

### E-0218 — Map object lists and selectors found by tiling gaps (bank $69)

- Kind: TOOL (C1).
- **Problem.** E-0163 reaches selectors only through the screen arrays that the map records size (width x height). Lists and selectors between them that no such array reaches stayed INCBIN. An example is $6D6D-$6E3B: four lists, then `$FFFE` + pointer selectors each followed by their list.
- **Rule.** Each gap between known bank-$69 layouts (at most $400 bytes, no code) is parsed in sequence. An object list (a count of 1-40 and a VRAM page byte $8x, then 11 bytes per object) or a selector (the E-0163 grammar, with every list pointer valid) is taken at each step. The gap is used only when it tiles exactly.
- **Result.** 80 gaps tiled, and bank $69 has no INCBIN left. The totals are now 421 object lists, 135 screen arrays and 373 selectors. Unidentified INCBIN is 27,051 bytes.
- **Limits.** Which maps or states use the tiled selectors is not traced.
- Binary verification: build/run261 PASS, 0 differing bytes; tests OK.

### E-0217 — Link conversion tables (bank $37); string tables in every bank

- Kind: OBSERVATION (reading plus a consistency check; C1, C2 for the species pairing) and TOOL.
- **LinkCodeToSpeciesTable ($5FC7, 215 words) and SpeciesToLinkCodeTable ($6175, 384 bytes).**
  - FamilyNibbleOrSpeciesFamily (in UnpackLinkRecordToWorkBuf) reads a species through the first; AppendTable6175ByteForWordAtDE appends a byte through the second.
  - For all 215 codes, the second table maps the species back to its code.
- **LinkSkillMapTable_B ($62F5, 222 bytes) and LinkSkillMapTable_A ($63D3, 170 bytes).** MapAndCompactSkillList62F5 (UnpackLinkRecordToRecordBufB) and MapAndCompactSkillList63D3 (UnpackLinkRecordToWorkBuf) map $21 skill bytes through them and drop $FE/$FF entries. For 155 of A's 170 entries, B maps the result back.
- **String tables (generator).** LookupString reads word wStringCategory of the table at DE, then word wStringIndex of that list.
  - For every `ld de, X` before a call or jump to BeginStringDisplay or CopyStringToBuffer, the table at X is laid out: the category table runs to its lowest target, and each list runs to the next list, the last one to the lowest string named.
  - Tables that overlap another layout or code are skipped. 36 tables are derived, for example StringCategories_37_4016 with two lists of 54 and 32 strings.
- Unidentified INCBIN is 29,801 bytes.
- Binary verification: build/run260 PASS, 0 differing bytes.

### E-0216 — Rectangle records through family copies, the name entry keyboard, decompress arguments set before a jump

- Kind: TOOL plus OBSERVATION (C1).
- **Rectangle records.** The E-0161 derivation now also takes every copy of the CopyRecordRectToScreenBuffer and ReadScreenBufferRectHeader families (same first 16 bytes) as a header reader. This adds the bank-$A0 records at $4D37 and $4DC7 (31 records in all).
- **NameEntryKeyboard (14:$6F4E).** RunNameEntryStateWhenNotFading_Case01_Case02 reads the byte at $6F4E + 17 * wNameEntryCursorY + wNameEntryCursorX.
  - It has 10 rows of 17 character codes (A-M 0-3, N-Z 4-7, a-m 8 9 ! ?, n-z, then symbols), then 11 bytes.
- **Decompress arguments.** The call-site source of compressed streams now also scans back from every unconditional `jr`/`jp` that lands inside the scanned instructions before a DecompressTo* call.
  - GameMode6_Init sets DE and B in three branches that jump to one call. Two of those streams (24:$6F4E and 24:$6CE4) had been missed.
  - Literal call arguments go from 147 to 155, and new streams from 91 to 97.
- Binary verification: build/run258 PASS, 0 differing bytes.

### E-0215 — World map viewer tables (bank $A1)

- Kind: OBSERVATION (reading; C1).
- **WorldMapStartPositions ($59D6).** Jump_0A1_4A67 reads the record at $59D6 + 4 * wGameMode2Byte44 with LoadMapPositionFromHL. Only the first two bytes are read. There are 11 indexes, so record 10 is a 2-byte tail.
- **WorldMapCursorSpriteLists ($5A00) and WorldMapMarkerLists ($5A49).** 11 words each, by wGameMode2Byte44. Each list is a count, then two bytes per entry:
  - sprite X/Y offsets from the cursor cell, drawn with DrawMetaSpriteSet26 (Func_0A1_5654);
  - or entries walked by Func_0A1_4DA4.
  - The lists tile $5A16-$5A92.
- **WorldMapCursorCellTable ($5A92) and WorldMapScreenPositionTable ($5D80).** 150 five-byte records each, with the same rising map ids: a map id, then a pair of bytes, then a second pair used when wLastWarpIndex = 2.
  - The pairs are cursor cell X/Y in the first table, and screen/position nibbles (LoadMapPositionFromHL) in the second.
  - They are searched by map id with no terminator. The first ends exactly where the second begins, and the second ends at zero padding ($606E).
- **Result.** Bank $A1 has no INCBIN left.
- Binary verification: build/run256 PASS, 0 differing bytes.

### E-0214 — Bank $73: symbol tiles and tables, two unreferenced routines, a map message table

- Kind: OBSERVATION (reading; C1).
- **SymbolTiles_73_44EA.** Five 16-byte 2bpp tiles. The routine at Jump_073_44C6 copies all or part of one to VRAM.
- **SymbolRowTable_453A / _4544 / _454E.** 10 bytes each, values 0-4, indexed by the high nibble of wMenuState, wMenuSubState and wMenuSelectedMember. Bank-$73 code compares the three values with each other.
- **AddRewardToCounterCappedAt999 ($4558) and RewardAmounts_73_45CA.** The routine adds the byte at $45CA + wScriptParam0 to a 16-bit value read with SRAM enabled, caps it at 999, writes it back and shows the difference. No caller was found; it is a configured entry.
- **UnreferencedScriptStepDispatch_73_6D52.** It starts `ld a, [wScriptStep] / rst $00` with a six-entry table, the shape of a ScriptCommandXX_Run implementation, but no stub reaches it. It was the only such prologue left in any INCBIN slice.
- **MapMessageTable_530C.** 54 message words, one per map from $C8, read by ScriptCommandCB_Run_Shared01 at DE + 2 * (hMapId - $C8). The `names` word option gains `message`, which quotes the message as script messages do.
- Binary verification: build/run255 PASS, 0 differing bytes.

### E-0213 — Bank $E0 debug tables and its library copy

- Kind: OBSERVATION (reading; C1).
- **DebugSoundEffectList ($55BF, 60 bytes).** DrawHexByteAtBGMap8A_Sub03 plays the byte at $55BF + wDebugSubState.
- **EffectTestEntries ($55FB, 51 entries).** RunEffectTestEntryA loads actor, target, action id and wEffectFlags2 from entry A and far-calls SelectEffectByEffectFlags2Flags.
- **DebugScreenLayout_E0_4D95.** 20 x 18 tiles copied to vBGMap0 (BC = $1412).
- **Palette_E0_7641.** 8 bytes copied to wOBJPaletteBuffer + $20.
- **WorkBufSequenceTable ($7649, 5 words).** Func_0E0_5AD3_Table2_Case00 walks one sequence per id: a first byte, then count/value pairs with $FE/$FF markers. The lists run to $76E0; the pairs are not interpreted.
- **Library copy at $79C9.** It follows a short string. It is seeded as GetBattleATK_BankE0 (configured entry), and fall-through plus copy discovery (E-0212) trace the rest of the block.
- **Result.** Bank $E0 has no INCBIN left.
- Binary verification: build/run252 PASS, 0 differing bytes.

### E-0212 — Copies of traced routines; the bank-$31 library copy

- Kind: TOOL (C1 per copy) plus OBSERVATION.
- **Bank $31.** SlotPanelRowOffsets ($7ADA, 3 words) feeds CopySlotPanelRowToVRAM. After it, $7AE0-$7BEE is a copy of the battle library:
  - GetBattleATK/DEF/MaxHP/MaxMP/HP/MP/AGL stubs and their shared tail;
  - the E-0205 block (ClearBattleStatusBitsWithMaskD_Bank31 and the set-bit routines);
  - ClearBitMaskTable_Bank31 ($7B69).
  - None of it is reached from traced code. It is seeded through configured code entries, and the existing comments match it to the traced bank-$39 copy ("the same 55 bytes as GetBattleATK_Bank39").
- **Generator: discover_copies.** When fall-through discovery is exhausted, a fall-through candidate (right after a covered terminator or table word) whose next 16 bytes equal the first 16 bytes of a traced routine (all decoded as code there) is queued as code. Proven data regions and declared tables are excluded.
  - It queued 25 copies, for example the GetBattle* stubs at $4006-$401A in banks $A1 and $A3, GetBattleDEF_BankE2, Multiply24By8_BankA0, and a bank-$E0 copy of the bank-0 routine at $2E98.
  - A first version that tried every uncovered byte seeded inside a run of 6-byte target routines in bank $39 and broke ChooseTarget_BeastCut; limiting it to fall-through candidates fixed that.
- **Generator: name_copies.** A copy takes its source routine's name with its own bank suffix; a second copy in the same bank adds its address.
- **Relocated copies.** The match compares whole instructions over 16 bytes. A 16-bit operand into the switchable window (other than `ld bc`, usually a count) counts as its offset from the routine start, so a block copied to another address still matches.
  - Example: bank $E2's copy of the E-0205 block loads its mask table at $6932 instead of $408A.
- **Block extension.** After a match, the source's later routine entries (up to $200 bytes on) are tried at the same distance. This reaches routines that follow a small table rather than a terminator.
- **Result.** 55 copies queued, and bank $E2 has no INCBIN left. Unidentified INCBIN is 34,739 bytes.
- Binary verification: build/run248 PASS, then build/run250 PASS with relocation and block extension, 0 differing bytes; tests OK; `tools/rank_unnamed.py` reports 0 address-only routines.

### E-0211 — Monster pedigree tables (bank $0C)

- Kind: OBSERVATION (reading plus a cross-check against E-0199; C1, C2 where cross-checked).
- **Reader.** ScriptCommandF6_Run_Case10_Case06 takes a monster number from GridCellAddressFromGridCursorXAndGrid2CursorX: a page base from Data_00C_5916 plus the grid position. It draws the words at $599F + 2 * number and $5F9F + 2 * number (graphics at vTiles2 + $300 / + $390, sprite parts $42 / $43).
- **Layout.** MonsterPedigreeTableA ($599F) and MonsterPedigreeTableB ($5F9F) have 384 words each, one per monster: $00xx/$01xx is a specific monster, $FExx is "any monster of family xx", and $FEFE is none.
  - A second pair with the same layout, MonsterPedigreeTableA_Alt ($5C9F) and MonsterPedigreeTableB_Alt ($629F, ending at ScriptCommandF7_Run, $659F), has no reader found. It differs from A/B for only 7 monsters, and its 95 family-pair entries pass the same cross-check.
- **Cross-check.** For all 95 monsters whose two entries are both families, FamilyPairResultTable (E-0199) row A, column B gives that monster or "parent A's species". So the tables list the parents shown for each monster.
- **Correction.** `ld hl, $6101` in ScriptCommandF6_Run_Shared07 is the text window's rows and width (L and H go straight to wTextWindowRows and wTextWindowWidth). It is no longer labelled as data (Data_00C_6101 removed).
- The `names` word option gains `pedigree`.
- Binary verification: build/run243 PASS; with the second pair, build/run244 PASS, 0 differing bytes; tests OK.

### E-0210 — Action sound and battle text tables, battle text hooks (bank $3A)

- Kind: OBSERVATION (reading; C1).
- **ActionSoundTable_Flag7/6/5A/5B ($57F7, $59BF, $5B87, $5D4F; 228 entries), _Flag3 ($5F17; 208), _Flag0 ($60B7; 40) and _Flag2 ($6107; 40).** SelectEffectByEffectFlags2Flags picks one by wEffectFlags2 and indexes it by wBattleActionId. Byte 1 is used for a near-side actor; a value other than $FF goes to QueueSoundEffect. Each table runs to the next.
- **ActionBattleTextTable ($6DAA, 232 bytes) and ActionBattleTextTable2 ($6EA5, 64 bytes).** One battle text index per action ($FF = none), read by ShowActionBattleTextFrom6DAA and ShowActionBattleText. Each ends at the routine after it.
- **BattleTextCategory0HookTable ($6F06, 256 code words).** ShowBattleTextCategory0 calls word D through JumpToWordAtHL when it is non-zero, before showing string D of category 0.
  - The 256 words end exactly at the first target ($7106).
  - The targets (the old INCBIN at $710C) are now traced: bare rets and small hooks that copy the actor, target, skill or slot name, or the damage, into the text buffers.
  - Two hooks jump into the middle of CheckAllTargetsSame ($77D6) and WriteTargetNameOrTheMonsters ($785D). Once those tails were traced from the hooks, the fall-through heuristic no longer found the routines' own starts, so 3A:$77D3 and 3A:$785A are kept as configured code entries.
- The hooks are named, and `tools/rank_unnamed.py` reports 0 address-only routines.
- Binary verification: build/run241 PASS, 0 differing bytes.

### E-0209 — Sound note tables (bank 0); action effect tables (bank $3A)

- Kind: OBSERVATION (reading; C1, the period table C2 through E-0019).
- **SoundNotePeriodTable (00:$3B5C).** Two rows of 12 periods. The note routine indexes $3B5C by the semitone, or $3B74 when $FFDE bit 4 is set (E-0019's formula matched every emulated note).
- **SoundEnvelopeScaleTable (00:$3B8C).** 16 rows of 16 scaled volume nibbles. Jump_000_3B0E reads it before WriteChannelEnvelopeIfChanged.
- **SoundPitchOffsetRows (00:$3C8C).** 15 rows of 16 signed offsets added to hSndFreqLo by tick phase. They end at SoundNextEvent_Sub04.
- **ActionEffectTable_Flag7/6/5 ($40CC, $4294, $445C; 228 entries) and _Flag2/_Flag3 ($47EC, $486C; 64 entries).** SelectEffectByEffectFlags picks the table from wEffectFlags and indexes it by wBattleActionId. Each entry has two bytes:
  - byte 1 is used for an actor on the near side (ActorOnLocalSide), byte 0 otherwise;
  - $FF does nothing;
  - with bit 7 set, the value & $7F starts wEffectRoutine;
  - other values go to Jump_03A_48EC.
  - The debug viewer shows the first three tables by skill number, which fits the 228 records of SkillTable (E-0204).
- **ActionEffectTable_Unused ($4624).** 456 bytes of $FF, the size of one more table, with no reader found.
- Binary verification: build/run239 PASS, 0 differing bytes.

### E-0208 — Species record byte, AI skill weights, screen number lists

- Kind: OBSERVATION (reading; C1).
- **SpeciesNewRecordByteTable (19:$741C).** 384 bytes, values 1-7. GameMode4_Init_Sub01_Sub07_Sub01 stores the byte at $741C + wSpeciesId into a new monster record, right after the zero that follows the copied name. It is not the family, which FamilyForSpeciesIdArg6 computes from id ranges.
- **SkillAIBaseWeightTable (30:$55F3).** 201 words. AddSkillBaseWeightAndLoadSkill (from ScoreSkillForAI) adds the word at $55F3 + 2 * skill to the score when it is non-zero. The table ends at the far-pointer table at $5785.
- **ScreenNumberListTable (F2:$5643).** 24 words indexed by wScreenTableIndex (ReadF2FarPointerForScreenTableIndex in bank $1C). Each points at a list of 24-bit numbers that Jump_01C_4AFA indexes by 3 * entry and shows in digits.
  - The lists (ScreenNumberListNN, `lists` with `until`) run contiguously to ReturnStub_6333.
  - They may be prices; that is not confirmed, hence the neutral name.
- Binary verification: build/run237 PASS, 0 differing bytes; tests OK.

### E-0207 — `rst $00` tables longer than 128 words, with unused indexes

- Kind: TOOL (C1 per table).
- **Problem.** The inline table after `rst $00` was cut at 128 words (MAX_TABLE) and at the first $0000 word. DispatchTalkEvent_Case01's table (13:$5945) is longer: its lowest target, the `ret` at $5B33, marks where the table ends, which gives 247 words, two of them $0000.
  - The talk handlers listed after the cut had been left as data labels (for example 13:$7B8A, `ld hl, $04D1 / call $4001 / ret`).
- **Rule.** A dispatch table may now run up to 256 words, bounded as before by its lowest target. Once that bound is known, a $0000 word is kept as an unused index: no target, and the case numbering of later entries is preserved. A table never ends on an unused index.
- **Result.** $0000 words now appear inside tables in banks $02 (PlayMapMusic), $04, $13 and $73, each between valid entries. The newly traced handlers take their `_CaseNN` names.
- Configured routines from E-0197 and E-0205 are named, and `tools/rank_unnamed.py` reports 0 address-only routines.
- Binary verification: build/run234 PASS, 0 differing bytes; tests OK.

### E-0206 — Object path table (bank $0F); per-monster class tables (banks $16, $0C)

- Kind: OBSERVATION (reading; C1).
- **ObjectPathTable_5284 (0F:$5284).** 8 paths of 24 two-byte steps. ScriptCommand5E_Run_Case28_Case00 reads, every other frame, the pair at $5284 + $30 * ((wScriptParam1 & $70) >> 4) + 2 * step into wObject5 + 5 / + 4, for 23 steps.
- **MonsterClassByteTable_71AC (16:$71AC, 373 bytes, values 0-7).** BattleMonsterTable71ACAtLeast6 returns 1 when a battler's entry is 6 or more.
- **MonsterClassByteTable_5562 (0C:$5562).** The same 373 values except at 9 ids. ScriptCommandF6_Run_Case10_Case01_Sub02 uses the value to pick a 4-byte tile block (Data_00C_5513) for wScreenBlock9C.
- **MonsterIconKindTable_536A (0C:$536A, values 0-4).** ScriptCommandF6_Run_Case10_Case01_Sub01 uses the value to pick one of the five 2-byte blocks of Data_00C_54DF for the same screen.
- **Limits.** Each table has one byte per monster id up to $174. What the classes mean is not read.
- Binary verification: build/run232 PASS, 0 differing bytes.

### E-0205 — An unreferenced routine block at $4075 in banks $05, $A1 and $A3

- Kind: OBSERVATION (byte comparison and decoding; C1).
- **The block.** The 202 bytes at $4075-$413F are identical in banks $05, $A1 and $A3, between TargetOnLocalSide_Bank* and ActorCanPayMPCost_Bank*. No traced code, table or far call reaches them in any of the three banks.
- **Decoding.** Split at each `ret`, the bytes form seven routines (configured code entries at $4075, $4091, $409E, $40AB, $40B8, $410F, $412E in each bank) and one 7-byte table, ClearBitMaskTable ($408A). The table contains $FD, an opcode the CPU does not have, so it is not code.
  - The routine at $4075 ANDs mask [D] into wBattleStatus + 9 * E.
  - The routines at $4091-$40B7 set bits 0-2 of wLevelUpGains + A. Existing name families already name these copies (the same 13 bytes appear in 7 banks).
- **Limits.** Whether the game ever runs these copies is not known; they are code by structure only.
- Binary verification: build/run231 PASS, 0 differing bytes; tests OK.

### E-0204 — SkillTable has 228 records; per-monster chance tables (bank $A3)

- Kind: OBSERVATION (reading; C1).
- **SkillTable (1A:$40D4).** LoadSkillRecord multiplies the 16-bit index in wRecordBuffer by 17. The records continue past the debug viewer's 175 (E-0032) up to SkillRequirementTable at $4FF8: 901 more bytes, exactly 53 records with the same layout.
  - The table now has 228 records, and bank $1A has no INCBIN left.
  - The SkillTableSource test checks all 228 against the ROM.
- **MonsterResolveChanceTable (A3:$4B57) and MonsterResolveChanceTable_Foes (A3:$4CD7).** 384 bytes each, valued 0-3, one per monster id. RollRandomLoBelowChance_Sub01 indexes them by the actor's wBattleMonsterId:
  - the foe table serves battlers 4 and up when wLinkMode is 0 or 2;
  - the other table serves everyone else.
  - RollRandomLoBelowChance treats 3 as 4 and returns carry when wRandomLo is below the value, a chance of 0-4 in 256 (ResolveStepChanceRoll).
- Binary verification: build/run229 PASS, 0 differing bytes.

### E-0203 — Pointer-run stream guesses inside declared tables

- Kind: TOOL (correction of a C1 heuristic from E-0016/E-0017).
- **Problem.** The first stream source registers every target of a pointer run when at least 60% of the targets parse as LZSS. A short word list whose first word is a small number parses as an LZSS "size". The breeding result lists (E-0199) and the bank-$84 area layouts (E-0193) were registered as streams this way, although they are declared tables.
- **Fix.** Targets inside a declared table are no longer tried.
- **Result.** The stream registry shrinks from 4,931 to 4,560 entries. The generated source is unchanged (diff empty), because the tables already took precedence in the output.
- Binary verification: build/run227 PASS, 0 differing bytes.

### E-0202 — Wild and scripted encounters (bank $0A)

- Kind: OBSERVATION (reading; C1).
- **ScriptedEncounterTable ($481C).** 51 records of 8 bytes. StartScriptedEncounterTemp0 (14 callers) copies byte 0 to wEncounterKind and bytes 2-7 to wEncounterMonsters (three words). Records $14, $15 and $2F-$31 use battle intro 7, the rest intro 2.
- **Encounter grids and groups ($5773-$63D4).**
  - RunBattleIntroKindCase_Case00, and the parallel CollectUniqueEncounterIdsToWD09F_Sub01, pick by hMapId either:
    - a grid, passed with its width in A to ReadMapCellWordForScreenXY (one word per screen, row by row); or
    - a group, passed directly to RunBattleIntroKindCase_Case00_Sub01.
  - A group record is: wEncounterKind + 1; a limit for a random 0-127; five rising slot thresholds; then one encounter word per non-zero threshold.
    - The routine draws three times and stores, each time, the word of the first slot whose threshold is not below the draw.
  - Walking the region with that length rule tiles it exactly: 48 grids and 111 groups.
  - Two groups ($5A7B and $5B3A) have no reference found. Each repeats the group before it with a different kind.
- **EncounterRateTable ($44FE).** 36 records of 8 bytes, indexed by wEncounterRate (Jump_00A_4451).
  - Mode 0 compares up to seven tile numbers with wTilesUnderPoint to choose the wEncounterCountdown decrement.
  - Any other mode subtracts byte 1.
- **TransitionRowStepTable ($560C).** Nine code pointers for JumpToWordAtHL_Bank0A, indexed by wTransitionStage. Each target adds a constant row step to DE; the targets were the INCBIN slice at $5597 and are now traced code.
- **Result.** Bank $0A has no INCBIN left.
- Binary verification: build/run226 PASS, 0 differing bytes.

### E-0201 — Map records that no map uses (11:$59E4, $6248, $62F0)

- Kind: OBSERVATION (byte search and layout; C1).
- **The record.** After MapRecord9B (11:$6218) comes a complete second 48-byte map record at $6248, up to MapRecordA0 at $6278. It has tileset 93:$7745, palettes 93:$78D4, a 1 x 1 screen size, flag wStoryFlags + $64, and five variants that all name the same screen arrays (93:$7914 / $7917).
  - No MapTable word points to $6248; a ROM search found the word only inside the record itself.
  - E-0142 had folded it into MapRecord9B as trailing bytes.
- **Its data.** The tileset stream (608 bytes) and the two screens (360 bytes each, tile and attribute maps) decompress cleanly. They had been the INCBIN slices 93:$7745 and 93:$7914.
- **Two more.** The same search found two more: $59E4 (after MapRecord67; tileset 90:$58E9, three variants) and $62F0 (after MapRecordA3; tileset 90:$6FB4, palettes 68:$7DBE, two variants). Both are 1 x 1, and no word in bank $11 points to either.
- **Tool.** MapTable gains `extra_records` for records reached by no entry; such records are labelled MapRecordX<address>.
- Binary verification: build/run223 PASS (the $6248 record), then build/run224 PASS with all three, 0 differing bytes; tests OK.

## Reusable investigation record

Copy this structure into a new entry or a future `docs/evidence/E-NNNN.md` file. Keep IDs unique. Required fields may say `unknown`, with a reason; unknown target identity prevents promotion to C2/C3.

```text
ID / title / date / author / reviewer:
Kind: OBSERVATION | HARDWARE | DECISION | game-semantic claim
Status: open | supported | verified | rejected | superseded
Claim (one falsifiable sentence):
Confidence: C0 | C1 | C2 | C3; promotion/downgrade reason:
Target ID, edition, revision, reference SHA-256:
Source tree revision and dirty-tree digest if relevant:
Location: ROM offset [start,end), ROM bank:CPU address,
          or RAM space/bank/address; width and byte order:
Provenance: URL, author, commit/page revision, accessed date,
            exact source file/section; original vs derivative:
Observed bytes / decoded instructions / data shape:
Inputs, outputs, flags, clobbered registers, bank preconditions:
Callers, side effects, lifetimes, aliases, relevant interrupts:
Method: commands and tool versions; static derivation or trace:
Reproduction: emulator/version, machine mode, boot settings,
              save/state hash, reset point, input sequence, RNG/timing state:
Expected observation / actual observation / artifact hashes:
Alternatives and disconfirming or boundary cases:
Conclusion, scope limits, unresolved questions:
Binary verification: PASS | FAIL | UNVERIFIED; report path/hash:
Changed symbols/files and dependent claim IDs:
Next action; supersedes/is superseded by:
```

Screenshots can explain a finding, but preserve commands or an input recipe and trace context so someone can reproduce it. Emulator save states can contain ROM or other bulk data: keep them local by default and commit their hashes and creation recipes. Distinguish emulator saves from cartridge SRAM saves.

## Promotion and review

1. Check provenance and exact target before interpreting an address.
2. Test a concrete prediction against the local bytes or execution; record failures too.
3. Review the narrow claim, its assumptions, and at least one plausible alternative. A second agent agreeing is not independent evidence.
4. Assign confidence; update dependent names and knowledge-map rows. Review can be done by the user and lead engineer together; if one worker fills both roles, disclose that it was a self-review.
5. Run the identity gate for build-affecting changes. Keep the semantic decision and the build report separate.
