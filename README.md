# Dragon Warrior Monsters reverse-engineering project

First target: **Dragon Warrior Monsters 2: Cobi's Journey**, Game Boy / Game Boy Color. Baseline prepared **2026-09-12**.

We are building a documented, reproducible disassembly: readable assembly and data that recreate the original ROM byte for byte. Understanding the program is a separate, evidence-based effort. The folder name `dwm2decomp` does not commit us to recovering C or the original developers' source code.

The source in `src/` rebuilds the US release (SHA-256 `8e38a742...766d4e`) byte for byte with RGBDS: `python -I tools/build.py --out build/run1`. You supply the original ROM in `local/roms/`; it is never part of the repository. Read [the reading guide](docs/READING_GUIDE.md) first.

## Start here

| Document | Purpose |
| --- | --- |
| [Reading guide](docs/READING_GUIDE.md) | How the source is laid out and how to read it |
| [Project status](docs/PROJECT_STATUS.md) | What exists, what is unknown, and the next session |
| [Repository and community survey](docs/SURVEY.md) | Existing work, inspected revisions, limitations, and adoption recommendation |
| [Knowledge map](docs/KNOWLEDGE_MAP.md) | Research areas, source leads, dependencies, and first experiments |
| [Architecture](docs/ARCHITECTURE.md) | Project structure, address conventions, tools, and binary identity contract |
| [Roadmap](docs/ROADMAP.md) | Phases with prerequisites and measurable exit gates |
| [Partnership and agent workflow](docs/WORKFLOW.md) | How we choose tasks, investigate, review, and preserve context |
| [Evidence log](docs/EVIDENCE_LOG.md) | Confidence definitions, initial findings, and an investigation template |
| [Assembly learning plan](docs/LEARNING_PLAN.md) | Small lessons tied to useful project work |
| [AGENTS.md](AGENTS.md) | Mandatory operating rules for future coding agents |

## Working agreement

1. Every accepted canonical game build must match the identified reference ROM in length, SHA-256, and a complete byte comparison. Missing verification means unverified, never pass.
2. Every game-semantic claim carries a confidence level and evidence reference. A matching build proves byte preservation; it does not prove a label or explanation is correct.
3. We work in small investigations with a reproducible question, bounded changes, and a durable handoff. You set priorities; I own technical coherence, verification, and clear explanations.

The first implementation milestone is a fully matching scaffold with explicitly unknown regions. The first learning milestone is explaining one short routine and showing the evidence for its behavior.
