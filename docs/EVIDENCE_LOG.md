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
  - Results: 512 sets and 3,397 frames.
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
