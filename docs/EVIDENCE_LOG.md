# Evidence standard and initial log

Baseline: **2026-09-12**. No local ROM has been inspected. External game-semantic leads below are **C1**, even when their authors report strong evidence.

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
