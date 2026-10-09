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

Known limits: code reached only through other banked-call forms, computed `jp hl`, or pointer tables is still opaque; `rst` fall-through may decode inline data as code; the cartridge header (`$0104-$014F`) is an INCBIN slice, not annotated.

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
