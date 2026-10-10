# Agent work plan (from 2026-10-10)

This plan is for the agent that continues the naming work. Follow `AGENTS.md` first. This file only covers order of work and working habits.

## Where things stand

- Binary identity passes: SHA-256 `8e38a742…766d4e`, 0 differing bytes. The full test suite passes.
- 77 commits. `config/names.json` has 532 named routines. The evidence log runs E-0001 to E-0057.
- The generated `src/` still has **4,826 `Func_BBB_AAAA` labels**. Every resolve step of the battle engine is named. Most other subsystems are still address-named.
- Uncommitted work: the `SlotStatusBlock` test class in `tests/test_routine_behaviour.py`. It passes, but its names and E-0058 are not written yet. See Task 0.

"Full human-readable code" is not a goal you can finish in one session. The open-ended goal kept a Stop hook firing with no end. The bounded goal, "every battle resolve step named", worked and finished cleanly. **Set bounded goals**, such as "name the next 25 routines on the fan-in list" or "name every routine in the menu dispatcher". Report the remaining `Func_` count at the end of each one.

## Working habits that save time

1. **Batch your names.** One regeneration costs about 2 minutes, then the build and tests run. Past commits named 1–2 routines each, so most of the time went to the gate. Read 5–10 routines first, then add all their names, then run one regeneration, one build and one test run, and make one commit.
2. **Run the gate the same way every time.** Use timeout 600000 and send the generator's output to a log:
   ```
   python -I -u tools/disasm_all.py --stats --quiet > build/logs/<tag>.log 2>&1
   python -I tools/build.py --out build/runN
   python -I -m unittest discover -s tests
   ```
   Don't run `python -m unittest tests.test_routine_behaviour`, because it fails. Use `discover -s tests -p test_routine_behaviour.py`.
3. **Use the cheapest evidence that meets the claim:**
   - A leaf routine with no branches: a full reading is enough (`"evidence": "reading"`).
   - A routine that branches, reads a table or produces a result code: add one emulator test in `tests/test_routine_behaviour.py` and an E-entry.
   - Don't write a test for every leaf.
4. **Use the propagation built into the generator:**
   - Naming a parent automatically names its single-caller helpers (`Parent_SubNN`) and its jump-table cases (`Parent_CaseNN`).
   - When a leaf routine has byte-identical copies in other banks, add it to `config/name_families.json`. That names every copy at once (E-0027).
5. **Known traps from earlier sessions:**
   - Emulator banks are hex. Write `call(0x32, …)`, not `call(32, …)`.
   - Bank file names are lowercase hex: `src/banks/bank3a.asm` holds bank `$3A`. To find a routine's file, run `grep -l "^Func_BBB_AAAA:" src/banks/*.asm`. Don't map banks by hand.
   - Set every RAM input the routine reads before the call. One test failed because `wRecordBufferData` (`$CFEE`) was not set.
   - Before committing a note, check each claim against the instructions again. Four notes had errors in the last session: wrong control flow, a miscount, wording that went too far, and a wrong early-return condition.
   - `config/names.json` has a `_comment` string entry. Skip values that aren't dicts when you scan it.
6. **Commit format:** use a Conventional Commit subject (`feat: name …`, `docs: record E-00NN`) and end the message with the attribution trailer the harness gives you.

## Task order

### Task 0: finish the pending work

1. Add the two names below to `config/names.json`.

   **`00:3E25` → `CheckSlotStatusBlock`**
   - note: "A = slot: returns carry set when the slot is absent (CarryUnlessWDA63SlotEmpty) or when status +0 & $D0, +3 & $3F, +5 & $C0 or +8 bit 3 is set (wBattleStatus + 9 * slot); otherwise carry clear; A, BC, HL kept (E-0058)"
   - evidence: "reading + execution (E-0058)"

   **`32:57FD` → `ReadByteAtHLPlusA`**
   - note: "HL += A, then A = the byte at HL"
   - evidence: "reading"
2. Add E-0058 to `docs/EVIDENCE_LOG.md`. It is backed by the `SlotStatusBlock` test.
3. Run the gate and commit.

### Task 1: commit a ranking tool

The fan-in ranking was produced with throwaway scripts in `build/`. Write `tools/rank_unnamed.py` and commit it.

- It counts `call`, `jp`, `rst $10` banked-call and `dw` references to each `Func_BBB_AAAA` in `src/banks/*.asm`.
- It prints the routines by count. The count runs until the next label.
- Add an option that limits the output to a set of banks.

Use it at the start of every batch.

### Task 2: name routines by fan-in (main loop)

Each name makes every caller easier to read, so work in fan-in order. These are the last measured counts:

| Calls | Routine | Calls | Routine |
| --- | --- | --- | --- |
| 73 | 00:24F8 (reads hScrollX) | 18 | 39:71EA, 39:6FE2, 31:753F |
| 41 | 31:72CC | 17 | 00:3F32 |
| 28 | 39:71F9 | 16 | 36:65B6 |
| 24 | 00:18A5 | 15 | 36:6594, 36:651C, 36:6159 |
| 23 | 00:2E81 | 14 | 36:5013 |
| 22 | 00:222B | | |
| 19 | 03:4425 | | |

Read all of bank `$00` first. Its routines are shared by every bank, so names there make the most code readable.

### Task 3: finish the battle subsystem

The battle subsystem is half done. Remaining items:

- The resolve-step sub-routines: Case00_Sub01, Table2_Case00_Sub01–04, Case04_Sub02/03 and Case07_Sub01/02.
- The `DispatchActionEffectTable` entries beyond the first 40.
- The effect tables behind `SelectEffectByWDAD2Flags` and `SelectEffectByWDAD3Flags`.
- The skill record fields beyond byte 0.

Open question to record: `FilterSkillListByMP` keeps a skill when cost < MP, but `CheckSkillMPCost` allows cost ≤ MP. Find out which one the game shows the player.

### Task 4: work subsystem by subsystem

Use `docs/KNOWLEDGE_MAP.md` and `docs/GAME_STRUCTURE.md` to pick a dispatcher. Good candidates are the menu, the text engine, save records and the overworld scripts. Name the dispatcher first, then its cases, then their leaf routines.

### Task 5: housekeeping, at most once per few batches

- `docs/PROJECT_STATUS.md` still opens with "implementation not started". Update its header and readability numbers: the `Func_` count, the names count and the last E-number.

## Stop conditions

- **Identity gate fails:** stop. Find the cause in the generator or config. Never copy reference bytes.
- **The behaviour isn't clear after a full reading:** leave the address name. Write what you saw in the evidence log as an OBSERVATION with an explicit unknown. Don't guess.
- **A run is killed or interrupted by the user:** don't rerun it without asking.
