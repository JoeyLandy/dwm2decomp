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

- Kind: OBSERVATION of traced code plus a DECISION on bank resolution. Confidence **C1** for helper-paired loads, **C0** for same-bank loads.
- Rule: `ld hl|de|bc, $4000-$7FFF` becomes a labelled data start. Strong case (238 loads): argument of a call to a bank-0 routine that writes `$2100` within its first 10 instructions; the nearby `ld b, BANK` names the bank (235 of 238 point to a different bank than the caller, as expected for a cross-bank copy helper). Weak case (2,894 loads): bare load in a switchable bank, same bank assumed. Bank-0 loads without a helper call are skipped.
- Why same-bank is plausible but unproven: code in a switchable bank cannot switch away from itself, so cross-bank reads go through bank-0 helpers. It fails for any bank-switching routine this rule does not recognise. Each such label says `bank assumed`.
- Sanity example (not verified): bank `$01`, `ld de, Data_001_412F / ld hl, $9800 / ld bc, $1412 / call Func_000_15DE` is consistent with copying a 20x18 tilemap to VRAM.
- Binary verification: PASS, two identical clean builds (`build/run8`, `build/run9`). Labels and operand spelling changed; assembled values did not.
- Open: 452 loads land inside an already-decoded instruction or table word; these may indicate data decoded as code and are not yet examined.

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
