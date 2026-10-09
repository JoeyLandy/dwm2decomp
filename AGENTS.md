# Agent operating instructions

## Mission and current stage

Reverse engineer and document **Dragon Warrior Monsters 2: Cobi's Journey** for GB/GBC, preserving binary identity. Read [project status](docs/PROJECT_STATUS.md), [architecture](docs/ARCHITECTURE.md), and [evidence standards](docs/EVIDENCE_LOG.md) before work. The user is technical and new to assembly: explain unfamiliar instructions and bank behavior through the task at hand.

Locally verified facilities (2026-10-09): `python -I tools/build.py --out build/runN` (clean RGBDS build plus identity gate), `python -I -m unittest discover -s tests`, and `python -I tools/disasm_all.py` (regenerates `src/`; rebuild and verify afterwards). The reference is `local/roms/dwm2-cobi-us.gbc` (ignored); the target is `config/targets/dwm2-cobi-us-rev0.json`. Other planned commands and layouts remain unverified. Edition: US header, version byte 0; catalog cross-check pending. DWM1, Tara, Japanese releases, remakes, and hacks are distinct targets.

## Binary identity is mandatory

- Preserve every canonical ROM byte, including header, checksums, padding, unused regions, and apparent bugs. Never optimize, fix gameplay, relocate code, normalize the ROM, or silently regenerate header bytes in the matching target.
- Before accepting any change to assembly, data, assets, linker layout, extraction/generation, dependencies, or build tooling, run a clean full-ROM build and verification for every affected supported target. Require exact length, approved SHA-256, and zero differing bytes against the immutable reference.
- Reference identity must be established independently of the generated output. Never update expected hashes to make a mismatch pass. A new revision needs a separate manifest and explicit target decision.
- Missing ROM, toolchain, manifest, or logs means **UNVERIFIED** and blocks acceptance of build-affecting work. Investigations may remain drafts. Documentation-only work can proceed with its build status explicitly marked not run.
- Unknown regions may use fixed-offset `INCBIN` slices from the local reference. Record them as opaque, not understood. Whole-ROM copying is scaffolding, not disassembly progress.
- Never repair mismatching output by copying reference bytes over assembled code. Resolve the source/layout/toolchain error or leave the work unaccepted.
- Preserve a build report tied to the exact source revision (and dirty-tree digest if applicable), tool versions, input/output hashes, sizes, and diff result. Reverify after integration; a branch's earlier pass does not certify a different combined tree.

## Semantic claims need evidence

Use the project scale: **C0 unknown**, **C1 hypothesis**, **C2 supported**, **C3 verified within a stated scope**. Definitions and promotion requirements are in [the evidence log](docs/EVIDENCE_LOG.md).

- Every semantic label/comment, RAM field, table schema, pseudocode explanation, and subsystem claim needs a confidence tag and evidence ID. External assertions start at C1 for our target until reproduced locally.
- Separate source observations, hardware facts, project decisions, and game semantics. Observing that an upstream file calls something `memcpy` does not verify that function's meaning in our ROM.
- Use stable address names until meaning is supported: illustrative forms `Func_035_401C`, `Data_035_433B`, `wUnk_02_D008`. Bank numbers here are hexadecimal; these names alone establish no semantics.
- Record target/hash, address space, bank, address or file range, width, byte order, callers, side effects, and limitations. Use zero-based file offsets and half-open ranges `[start, end)`.
- Track code and data separately. Disassembler output does not prove a region executes. Preserve ambiguous bytes without inventing routines or function boundaries.
- Pseudocode must preserve relevant integer widths, overflow, flags, bank state, pointer interpretation, and side effects. Do not infer familiar high-level algorithms from names alone.
- Preserve contradictory and rejected hypotheses with their evidence. Cross-links must not turn multiple copies of one source into independent corroboration.

## Work and review

- Follow [the workflow](docs/WORKFLOW.md): question, baseline, evidence, bounded change, verification, review, handoff.
- Prefer one routine, table, or coherent byte range per task. Maintain one active implementation task by default. Do not launch sub-agents unless the user explicitly requests delegation; the listed roles are responsibilities, not standing permission to spawn agents.
- If delegation is requested, give each worker a target hash, exact revision, exclusive file/range ownership, deliverable, and acceptance checks. One integrator owns shared symbols and linker changes. Require a fresh verification of the integrated result.
- Read upstream scripts before executing them. Do not run commit/push helpers or mirror/delete operations just because an upstream build uses them.
- Keep local reference ROMs, generated game binaries, extracted assets, saves, emulator states, and large traces outside tracked artifacts by default. Commit original analysis, reproducible tools, manifests, and permitted source with attribution. Check file-level reuse terms before importing upstream code; a public repository is not a license grant.
- Use local reference files supplied for the project; do not fetch or upload game ROMs. Do not contact maintainers or post messages without the user's explicit authorization.
- Run meaningful checks appropriate to changes. For the verifier itself, include negative cases such as missing inputs, byte corruption, length mismatch, and stale output. Never mask a failed match behind a successful docs-only check.
- Update status, evidence, knowledge-map entries, and relevant roadmap gates when facts change. End each session with outcome, verification status, unresolved questions, and the next reproducible action.

## Definition of accepted work

Build-affecting work: scoped diff reviewed, required identity gates pass, semantic claims carry evidence/confidence, generated outputs are reproducible, and status is current. A bytes-only transcription may pass with C0 semantics if labeled honestly.

Documentation-only work: links and internal consistency checked, sources attributed, observations distinguished from proposals, and no unsupported claim of a successful rebuild.
