> **Completed 2026-10-16 (E-0386).** This goal is done; see docs/ROADMAP.md, "Readability goal: complete". It is kept
> as the record of what was asked. The later moddable-decomp goal (M1-M5) is also done.

Goal: finish the pokered-style readability goal for dwm2-cobi-us-rev0 as fast as possible without weakening any gate. Work in batches of read-only sub-agent drafts, with you as the only integrator. Keep going until the completion criteria below are met. Do not stop to ask me anything: decide, record the decision in docs/PROJECT_STATUS.md, and continue.

## Authorization
- Sub-agents: I explicitly authorize them for read-only drafting, as AGENTS.md requires.
- Commits: commit each accepted batch to the current branch. Do not push.
- AGENTS.md, docs/WORKFLOW.md and docs/READING_GUIDE.md stay in force. Read them and docs/PROJECT_STATUS.md before starting.

## Before the first batch
1. If a round is in progress (for example E-0368), finish it, pass the full suite, and commit it.
2. Time one full cycle: regenerate (python -I -u tools/disasm_all.py), build (python -I tools/build.py --out build/runN), the scoped tests, and the full suite (python -I -m unittest discover -s tests). Record each phase's time and the 10 slowest test files in PROJECT_STATUS.md.
3. If the full suite takes more than 40% of a cycle, add a runner that runs test files in parallel processes. Run the parallel and serial runners on the same tree and confirm identical results, including test counts, failures and skips, before using it. Keep the serial run as the final check before every commit unless that comparison has passed on at least three separate trees.

## Roles
- You are the only one who edits config/, tools/, tests/, src/ or docs/, regenerates, builds, runs the suite or commits.
- Sub-agents only read. Each writes one draft JSON file to your scratchpad and edits nothing in the repo.
- No parallel writer sessions or worktrees: names.json and the generated src/ would conflict.

## Work queue, in priority order
1. Instruction-named labels (`..._Etc`, `..._ReadByteAtHLPlusA` and similar).
2. Labels longer than 50 characters.
3. Code labels without a hand-written reading note.
4. Data labels described only by their reader and size.
5. Opaque INCBIN slices without an identification.
6. C1 readings that can be checked with an emulator probe, to raise them to C2.
Recompute the queue from the current source at the start of every batch.

## Each batch
1. Split the next part of the queue into 4-6 slices of about 80 labels each (adjusted by the rules below). Group them by call-graph cluster or bank, so a worker sees a routine together with its callers, steps and the tables it reads.
2. Brief each sub-agent with:
   - the target SHA-256 and the exact commit SHA
   - its exclusive label list and its output path
   - the naming and note conventions from READING_GUIDE.md
   - the rules: read every routine whole; grep callers in other banks before naming; cite what was read as evidence, with a confidence level (C0-C3); never invent meaning; mark anything unclear as an open question; list existing labels its names might collide with
   - the draft schema, one entry per label: `{label, bank, address, proposed_name, note, confidence, evidence_read, open_questions}`
3. Validate every draft: name collisions, existing-label checks, names.json vs tables.json placement (data labels go in tables.json), and the naming rules the tests enforce.
4. Spot-check at least 10% of each worker's entries (at least 5) by reading the code yourself. If any spot-checked entry is wrong, reject that worker's whole draft and re-queue its labels.
5. Before applying, list every derived label whose name will change or drop because its parent is renamed, and name those in the same batch. If predicting this by hand is unreliable, write a small tool for it, with tests.
6. Apply, then regenerate, build and run the scoped tests. Fix failures at their cause. If the batch cannot pass identity or the suite after two fix attempts, revert it, re-queue its labels in smaller slices, and record why.
7. Before committing: a full-ROM identity PASS (exact length, approved SHA-256, zero differing bytes) and the full suite passing. Commit one batch per E-entry, in the existing commit style.
8. Update PROJECT_STATUS.md after every batch, so a context compaction loses nothing:
   - drafts accepted and rejected, with the main rejection reasons
   - time per phase
   - identity result with the run directory
   - measures from tools/readability.py and tools/doc_coverage.py
   - counts of labels over 50 characters and of `_Etc` names
   - remaining queue sizes

## Adaptive rules (apply them automatically)
- Batch rejection rate (rejected labels / drafted labels):
  - above 20%: halve the slice size and add each routine's callers and tables to the brief
  - below 5% for two batches in a row: grow the slice size by half, up to 150
- A label rejected or re-queued twice: give it to one dedicated worker with full context. If that also fails, record it as an open question in docs with its evidence and move on.
- Cycle time keeps growing as rounds go on: re-measure the phases and fix the slowest one before the next batch.
- A tool change that affects generation: only after a fresh identity PASS on the changed tooling, recorded in the evidence log.

## Completion criteria (all of them)
- Every code label has a hand-written reading note, and no label is named after its instructions.
- No label is longer than 60 characters, except exceptions listed in docs with a reason for each.
- Every data label has a note describing its content.
- Every opaque INCBIN slice is either identified or listed in docs as unidentified, with what was tried.
- Every C1 reading that can be checked with a probe has been probed; the rest are listed in docs with why not.
- docs/ROADMAP.md's readability goal is marked complete, with the final run directory, the measures and the remaining open questions.
- The final commit passes full-ROM identity and the full suite.

## Never
Weaken a gate, skip the identity check or full suite before a commit, update expected hashes, copy reference bytes over assembled code, let a sub-agent edit the repo, or accept a draft you haven't validated.