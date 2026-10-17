# Dragon Warrior Monsters reverse-engineering project

First target: **Dragon Warrior Monsters 2: Cobi's Journey**, Game Boy / Game Boy Color. Baseline prepared **2026-09-12**.

We are building a documented, reproducible disassembly: readable assembly and data that recreate the original ROM byte for byte. Understanding the program is a separate, evidence-based effort. The folder name `dwm2decomp` does not commit us to recovering C or the original developers' source code.

The source in `src/` rebuilds the US release (SHA-256 `8e38a742...766d4e`) byte for byte with RGBDS: `python -I tools/build.py --out build/run1`. You supply the original ROM in `local/roms/`; it is never part of the repository. Read [the reading guide](docs/READING_GUIDE.md) first.

State (2026-10-17): every routine and data label is named and has a note; the code is floating sections placed by `src/layout.link`, so it can move ([shiftability](docs/SHIFTABILITY.md)); every compressed asset is rebuilt from decoded data, and `build.py --mod DIR` builds a modded ROM from edited PNG and `.bin` files ([editable assets](docs/ASSETS.md)). A modded ROM is a separate output, never the matching target. Most readings are static (C1); [mechanics](docs/MECHANICS.md) and [data tables](docs/DATA_TABLES.md) are checked against the game's own routines on the project's emulator (C2).

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
| [How the game is put together](docs/GAME_STRUCTURE.md) | Frame loop, game modes and the main systems |
| [Mechanics](docs/MECHANICS.md) and [data tables](docs/DATA_TABLES.md) | Join offer, level-up gains and breeding as checked specifications; the species, skill and item tables |
| [Breeding paths](docs/BREEDING_PATHS.md) | The wild monsters of each story map and the fewest breedings from them to a species (`tools/breed_path.py`) |
| [Editable assets](docs/ASSETS.md) and [shiftability](docs/SHIFTABILITY.md) | Building a modded ROM; moving code and data |
| [Leftover code](docs/LEFTOVER_CODE.md), [unidentified assets](docs/UNIDENTIFIED_ASSETS.md), [open questions](docs/READABILITY_OPEN_QUESTIONS.md) | What is still not understood |
| [Assembly learning plan](docs/LEARNING_PLAN.md) | Small lessons tied to useful project work |
| [AGENTS.md](AGENTS.md) | Mandatory operating rules for future coding agents |

## Working agreement

1. Every accepted canonical game build must match the identified reference ROM in length, SHA-256, and a complete byte comparison. Missing verification means unverified, never pass.
2. Every game-semantic claim carries a confidence level and evidence reference. A matching build proves byte preservation; it does not prove a label or explanation is correct.
3. We work in small investigations with a reproducible question, bounded changes, and a durable handoff. You set priorities; I own technical coherence, verification, and clear explanations.

The matching build, the readability goal and the moddable-decomp stages M1-M5 are done; what remains is in the [roadmap](docs/ROADMAP.md).

## License

Original work here (tools, tests, documentation, labels, and comments) is MIT licensed; see [LICENSE](LICENSE). The license does not cover the game's own code and data reproduced in `src/`, which remain the property of their rights holders. No ROM is included; supply your own copy to build.
