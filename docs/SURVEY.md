# Repository and community survey

Survey date: **2026-09-12**. Primary project target: **DWM2: Cobi's Journey**. This is a bounded survey of accessible work, not a claim that every repository, fork, forum archive, or private community has been discovered.

## Recommendation

Start a fresh, small RGBDS project with strict verification and incremental replacement of opaque bytes. Evaluate existing work as source material before adopting it. None of the Cobi-related repositories surveyed was built locally in this session, so none supplies a verified baseline for this workspace.

The strongest opportunities are complementary: DWM2 low-level assembly for orientation; an incremental DWM1 source layout for build methodology; a DWM2 randomizer and research wiki for table hypotheses; and specialist research for resistance breeding and audio. Recovering and validating these connections will be more useful than treating one repository as a complete account of the engine.

## How this survey was performed

Searched for DWM/DWM2 disassemblies, randomizers, ROM/RAM maps, and author-linked research. Inspected public repository pages, selected source/build files, GitHub metadata and file trees, and community documentation. Read-only GitHub API calls supplied the five exact HEAD revisions below. No repositories were cloned, no upstream commands were executed, and no ROMs were fetched or built.

Inspection depth is stated per source. A listed file is weaker evidence than a read file; a read build script is weaker evidence than a reproduced build. For mutable pages and search-index text, pin a revision or preserve permitted provenance before relying on details in implementation.

## Disassembly repositories

### S01 — NiyaDev/DWM2: closest direct target

[Repository at surveyed revision](https://github.com/NiyaDev/DWM2/tree/055ecee52ce0c9be928817c03f7dc9d37c005f03). Branch `master`; commit `055ecee52ce0c9be928817c03f7dc9d37c005f03`; commit date **2022-07-23 UTC**.

The README describes a Cobi comparison workflow and incomplete platform setup. Its historical progress numbers are not a meaningful measure of semantic documentation; the displayed fraction and percentage are also inconsistent. Do not carry either into our status. [README](https://github.com/NiyaDev/DWM2/blob/055ecee52ce0c9be928817c03f7dc9d37c005f03/README.md)

Read the batch build and notes; inspected the recursive tree. The source inventory is concentrated around bank 0, with additional bank-specific files and function/variable documentation. [Source tree](https://github.com/NiyaDev/DWM2/tree/055ecee52ce0c9be928817c03f7dc9d37c005f03/src), [documentation](https://github.com/NiyaDev/DWM2/tree/055ecee52ce0c9be928817c03f7dc9d37c005f03/documentation)

The build uses date-based output paths, `wmic`, a `ROBOCOPY /mir` source snapshot, RGBDS tools, header editing, and a binary comparison. It lacks explicit intermediate-tool failure handling and a pinned reference identity. Audit these assumptions in isolation; do not reuse the wrapper unchanged. [Build script](https://github.com/NiyaDev/DWM2/blob/055ecee52ce0c9be928817c03f7dc9d37c005f03/build.bat)

**Disposition:** high-priority archaeology and candidate symbol/routine evidence; adoption pending local match, toolchain work, and file-level reuse review. Existing names begin at C1 for our target.

### S02 — ketsuban/dwm1: useful incremental-build model

[Repository at surveyed revision](https://github.com/ketsuban/dwm1/tree/e46bf427bf06a4df6a17a7937b1a6d0ec0bbb5ea). Branch `trunk`; commit `e46bf427bf06a4df6a17a7937b1a6d0ec0bbb5ea`; commit date **2024-10-23 UTC**.

Read `main.asm`, `Makefile`, and `checksums.sha256`. The main source preserves large original-ROM slices and includes structured tables/text. The Makefile has a SHA-256 comparison target and explicit linker layout. These are useful patterns for separating preservation from understanding. The supported DWM1 edition was not established by this survey; its checksum must never be reused as a Cobi identity. [Main source](https://github.com/ketsuban/dwm1/blob/e46bf427bf06a4df6a17a7937b1a6d0ec0bbb5ea/main.asm), [Makefile](https://github.com/ketsuban/dwm1/blob/e46bf427bf06a4df6a17a7937b1a6d0ec0bbb5ea/Makefile), [checksum](https://github.com/ketsuban/dwm1/blob/e46bf427bf06a4df6a17a7937b1a6d0ec0bbb5ea/checksums.sha256)

**Disposition:** methodology and comparative data-model reference. No local build, completeness percentage, or DWM2 semantic equivalence is established.

### S03 — NiyaDev/DWM: another DWM1 lineage

[Repository at surveyed revision](https://github.com/NiyaDev/DWM/tree/e5d0c57fce9288e2625b585aafa6ea390206e308). Branch `main`; commit `e5d0c57fce9288e2625b585aafa6ea390206e308`; commit date **2026-02-02 UTC**.

Read README and shell build script; inspected the source directory listing. The script invokes RGBDS, edits header/padding, and emits comparison output using additional Unix tools. It is useful for comparing this author's approach across titles, but build dependencies and failure handling need auditing. [Build script](https://github.com/NiyaDev/DWM/blob/e5d0c57fce9288e2625b585aafa6ea390206e308/build.sh)

**Disposition:** DWM1 comparison lead; not a Cobi foundation or verified matching build. The commit date establishes a repository event, not current maintainer availability.

### S04 — Ebernacher90/DragonQuestMonstersGerman: regional comparison

[Repository](https://github.com/Ebernacher90/DragonQuestMonstersGerman). Inspected landing-page README and bank-file listing; exact commit not captured.

The project identifies itself as a German DQM disassembly and exposes many bank assembly files. This survey did not establish its build process, extent of understanding, reference hash, or reuse terms. **Disposition:** regional DWM1 research lead; inspect specific routines only when there is a comparison question. A long bank-file listing alone proves neither completeness nor binary identity.

## Tools containing relevant research

### S05 — TheCowness/DWM2Randomizer

[Repository at surveyed revision](https://github.com/TheCowness/DWM2Randomizer/tree/05e559ba64ef9ffb3c6fac7f443dc7bb7445c5e8). Branch `master`; commit `05e559ba64ef9ffb3c6fac7f443dc7bb7445c5e8`; commit date **2019-03-12 UTC**.

Read the README and selected PHP sections; inspected the tree containing SQL data files. The author describes changes to monsters, encounters, growth, resistances, and skills, and lists known issues. This makes it useful as a record of attempted data manipulation, not as a specification of unmodified mechanics. [README](https://github.com/TheCowness/DWM2Randomizer/blob/05e559ba64ef9ffb3c6fac7f443dc7bb7445c5e8/README.md)

The PHP application depends on MySQL and a local settings file. Its host-side RNG is described as borrowed from Dragon Warrior III; it is not evidence of the game's RNG. Inspect offset writes and their consumers without deploying the old web application. [PHP source](https://github.com/TheCowness/DWM2Randomizer/blob/05e559ba64ef9ffb3c6fac7f443dc7bb7445c5e8/Dragon%20Warrior%20Monsters%202%20Randomizer/index.php)

**Disposition:** high-value table/patch lead, with each offset and meaning revalidated against the selected reference. SQL contents were located but not audited exhaustively.

### S06 — turboboy215/TOSE2MID

[Repository at surveyed revision](https://github.com/turboboy215/TOSE2MID/tree/d563c853f81816b83b928f77a7afba61d5d9e3a2). Branch `main`; commit `d563c853f81816b83b928f77a7afba61d5d9e3a2`; commit date **2024-12-31 UTC**.

The author's README lists DWM1 and both DWM2 versions, describes game-specific configuration, and identifies the converter as based on their sound-engine research. Format notes and converter C files are present; the decoder and game configurations were not validated locally. [README and files](https://github.com/turboboy215/TOSE2MID)

**Disposition:** targeted lead for later music-driver and sequence work. Extraction into MIDI does not demonstrate lossless encoding back into the original ROM.

For S01, S02, S03, and S05, GitHub returned no detected repository license. That is an incomplete metadata observation, not a conclusion about every file. S06 reports GPL-3.0; inspect the actual license and file notices when considering reuse. S04's terms were not audited. No third-party source was imported into this baseline.

## Community knowledge and retrieval depth

All game-specific contents below remain external leads (C1 for the selected target). Follow author attribution and version context; multiple copies of a guide are one evidence lineage.

| ID / source | Useful contribution | What was actually inspected / limitation |
| --- | --- | --- |
| S07 — [DWM2 Modding Wiki ROM Map](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/ROM_Map) | Index into monster, encounter, breeding, skill, item, text, and key data | Substantial search-index page text; direct open failed; revision not pinned |
| S08 — [Core monster data](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/Core_monster_data) | Candidate species records and pointer lookup | Indexed text; includes an inconsistent bank endpoint recorded in E-0003 |
| S09 — [Data Crystal DWM2 RAM map](https://datacrystal.tcrf.net/w/index.php?title=Dragon_Warrior_Monsters_2/RAM_map&oldid=59319) | Candidate battle-state watchpoints | Page body read; revision 59319 identified; target revision and RAM-bank context not supplied |
| S10 — [Data Crystal DWM2 ROM map](https://datacrystal.tcrf.net/wiki/Dragon_Warrior_Monsters_2/ROM_map) | Additional table/offset index | Search result only; direct open denied; lower-priority cross-check |
| S11 — [DwM2_DD's Breeding Resistance Guide](https://gamefaqs.gamespot.com/gbc/525414-dragon-warrior-monsters-2-cobis-journey/faqs/62849) | Firsthand experiments and reported assembly analysis for Cobi | Version 2, updated 2012-04-28; introduction and selected content read; formulas not locally reproduced |
| S12 — [Random encounter data](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/Random_encounter_data) | Candidate map-pointer/encounter layout and stated exceptions | Indexed page text; must separate fixed maps from generated worlds |
| S13 — [Breeding data](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/Breeding_data) | Candidate pointer/list organization | Indexed text; page credits DwM2_DD, so do not count it as independent confirmation of that author's work |
| S14 — [Magic key generation](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/Magic_key_generation) | Leads for key-generation rules | Search excerpt only; full algorithm not reviewed |
| S15 — [List of useful sites](https://dragon-warrior-monsters-2-modding.fandom.com/wiki/List_of_useful_sites) | Trails to Jimeous, GameFAQs, DQShrine, and older communities | Indexed page text; linked legacy resources not individually validated |
| S16 — [Data Crystal DWM1 ROM map](https://datacrystal.tcrf.net/wiki/Dragon_Warrior_Monsters/ROM_map) | DWM1 comparison source | Search excerpt; direct open failed; no offsets transferred |
| S17 — [Bynine's Dragon's Den randomizer thread](https://www.woodus.com/forums/topic/36046-dragon-warrior-monsters-2-randomizer/) | Author's historical tool announcement and link to TheCowness | Author-post text inspected; historical download not executed or audited |
| S18 — [pret/pokecrystal](https://github.com/pret/pokecrystal) | Mature methodological comparison: explicitly named build targets and hashes | README inspected; useful process example, no DWM engine evidence |

Pan Docs, RGBDS, BGB, SameBoy, and the GB assembly tutorial are linked in [architecture](ARCHITECTURE.md) and [learning plan](LEARNING_PLAN.md). These are platform/tool references, not DWM semantic authorities.

## Next archaeology actions

1. Reproduce S01's historical build only after identifying the exact reference and inspecting all executed commands. Record failure just as carefully as success.
2. Audit the relevant file notices and compare the cost of importing narrow source regions against transcribing them independently with attribution to research leads.
3. Resolve S08's range inconsistency and validate one pointer consumer locally. Use that first investigation to establish our evidence format.
4. Retrieve stable versions of the highest-value wiki pages and the exact GameFAQs passages used by an investigation. Preserve URL, author, revision/date, access depth, and short original notes rather than copying whole guides.
5. Review forks or newer tool descendants only for a concrete missing capability; track what differs from the inspected parent. Unreviewed downloads and community mentions remain discovery leads.

No claim is made about current activity in private Discord servers or the completeness of inaccessible archives. No maintainers were contacted. This survey provides a starting map and a reproducibility strategy; all local build and semantic validation remains future work.
