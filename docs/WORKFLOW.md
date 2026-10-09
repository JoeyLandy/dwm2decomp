# Partnership and agent workflow

Baseline: **2026-09-12**. Default team: you and one lead engineering agent. Roles below are responsibilities, not separate agents automatically running in parallel.

## How we work together

You choose what is interesting, clarify player-visible behavior, and supply context about your reference copy and play sessions. You can review findings before being comfortable writing assembly. I own the technical architecture, small task selection, source archaeology, reproducible tools, verification, evidence hygiene, and explanations.

Within an agreed task, I handle routine reversible implementation decisions and continue through verification. I ask for missing information when it changes the target or blocks an experiment. A change of game/revision, publication, or outside communication is a separate decision. I will not repeatedly ask permission for normal steps already in scope.

We use a short learning loop: show a concrete observation, explain the few instructions or hardware rules that matter, predict a contrasting result, test it, and write down what survived. Your questions become useful investigation prompts rather than interruptions to an opaque coding session.

## One investigation from start to finish

1. **Orient:** read status, the last handoff, relevant evidence, and instructions. Inspect the working tree. Select one question and one byte range or data path; identify the target hash.
2. **Establish baseline:** record the exact source revision. Run the existing identity check before build-affecting work; if it fails, diagnose that first. No implementation exists in this planning baseline, so this step begins in phase 1.
3. **State a prediction:** write the claim, current confidence, likely alternative, and what observation would distinguish them. Prefer "this field is the battle working copy of current HP" to "understand battle."
4. **Inspect and reproduce:** use upstream references as leads; inspect local bytes, decode relevant instructions, and trace a small scenario. Preserve ROM bank, RAM bank, registers, flags, machine mode, and save/input context.
5. **Make a bounded change:** transcribe bytes, name supported fields, or add original documentation. Preserve unknown fields and include ranges. Temporary memory edits used to test a claim are recorded as experiments.
6. **Verify:** run the full-ROM identity gate for build-affecting changes, plus relevant parser round trips and experiments. Confirm the verifier is comparing freshly generated output against the approved reference.
7. **Review:** read the explanation independently of the proposed name. Check instruction behavior, caller assumptions, alternate interpretations, and whether confidence is justified. Self-review is labeled; agent agreement alone is not corroboration.
8. **Integrate and hand off:** reverify the final combined source tree, update evidence and status, and leave a reproducible next action. Keep a failed investigation as a useful negative result, not an invented success.

## Task packet

Each implementation task should fit this small contract:

```text
Task ID and question:
Why this helps the project or learning:
Target manifest and reference SHA-256:
Starting source revision:
Owned files and ROM/RAM ranges:
Inputs / relevant evidence IDs / source revisions:
Deliverable and explicit scope limits:
Prediction / alternative / reproduction recipe:
Required identity and semantic checks:
Handoff fields and next action:
```

A task with no input hash may be source survey or planning, but cannot certify local game behavior.

## If parallel agents are later requested

Keep one integrator. Delegate only independent, bounded work after the build gate exists, such as an upstream license/source audit, a table-consumer investigation, or review of a specific evidence packet. Use isolated branches/worktrees or exclusive file/range ownership. The integrator controls shared symbols, manifests, and linker layout.

Every worker receives the same target identity and confidence rules. Handoffs include actual artifacts, commands, findings, failed tests, and exact source revisions. Conflicting semantics become competing hypotheses. Do not resolve them by majority vote or merge overlapping edits without review. Build every affected target again after combining changes.

Useful roles are **archaeologist** (provenance), **build engineer** (identity/reproducibility), **investigator** (bytes and behavior), **reviewer** (challenge claims), and **editor/teacher** (clear explanation). One agent can fill them sequentially. This document grants no standing authorization to spawn workers.

## Acceptance and branches

Keep the canonical build matching. Branches may contain unfinished investigation, but mark them draft/unverified and retain their failed diff reports. Purposeful gameplay changes are separate experiments; a modified ROM never becomes the new expected canonical output.

Once Git and checks exist, a review record should include the problem/question, precise changes, evidence IDs and confidence, exact build report, scope limits, and next step. Use commits that preserve a working matching state wherever possible. Do not mix unrelated renaming, table extraction, toolchain upgrades, and behavioral experiments in one change.

For documentation-only work, inspect links, consistency, provenance, and unsupported semantic claims. For tooling, test behavior that can invalidate evidence, including bank arithmetic, missing input handling, and complete-file comparison. For assembly/data, full binary identity remains the mandatory check even if a change looks cosmetic.

## Session handoff

```text
Date / task / source revision:
Outcome and files changed:
Binary status: PASS | FAIL | UNVERIFIED; report:
New or changed claims: evidence ID, confidence, scope:
Checks run and meaningful results:
Unresolved questions / rejected ideas:
Local artifacts required to reproduce, with hashes:
Next action and exact prerequisite:
One assembly concept learned or still unclear:
```

Keep handoffs short and link detailed evidence. Update the status document so a new session can resume without reconstructing chat history. Record architecture changes as decisions with context and consequences; keep exploratory reasoning in the evidence log.
