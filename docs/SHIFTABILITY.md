# Shiftability

Stage M1 of the moddable-decomp goal ([roadmap](ROADMAP.md)), evidence E-0388 in the [evidence log](EVIDENCE_LOG.md).
The question: if code or data in src/ moves, does the game still work? Measured 2026-10-16 on master eb9066a plus
the M1 tools (target `dwm2-cobi-us-rev0`). The matching build is not affected: padded builds are separate outputs
under build/ and are never compared with the reference.

## How it is measured

- **tools/shift_test.py** (dynamic). It copies src/ under build/ and assembles it twice: unchanged, and with N bytes
  of `ds N, $00` inserted before the first label of each bank past its fixed start ($0150 in bank $00, after the
  bank-number byte at $4000 elsewhere). Each bank's last `ds` fill shrinks by N, so the bank keeps its size. The
  unchanged copy must rebuild the reference byte for byte, or the run stops.
  - Both ROMs run in tools/sm83.py from power-on with the same scripted buttons. At the end of every frame the
    video state is compared: both VRAM banks, OAM, CGB palette RAM, LCDC and the scroll and window registers.
    Moving code does not change instruction timing, so a ROM that still works matches frame for frame (not quite:
    see M2 batch 1, where a moved table changed a carry and so a few cycles). A crash
    (an invalid opcode) counts as a difference.
  - `--bisect K` finds the banks whose padding alone causes a difference.
  - `--locate BB` pads one bank, runs both ROMs in lockstep and reports the first instruction whose PC or ROM reads
    are not the base ROM's moved by the padding. That names the routine that uses a fixed address.
  - `--explore` adds tools/boot_trace.py's walking script from frame 4000.
- **tools/hardcoded_refs.py** (static). It lists places in src/ where a number stands for a label, by kind and bank.
  Most kinds are candidate lists: a number can equal an address by chance.

What the dynamic test can show is limited by what runs. 3,000 scripted frames execute 404 labelled routines in 22
banks, and 10,000 frames with --explore 461 in 25 banks: under 5% of the 9,820 code labels. Code that does not run is covered only by the static inventory. These
are observations of the project's own emulator, not hardware.

## Results of the dynamic test

| Run | Banks padded | Banks that could not be | Labels moved | Result |
| --- | --- | --- | --- | --- |
| pad 1, 3,000 frames | 152 | 104 (99 with no label past the fixed start, 5 full) | 31,982 | differs from frame 818; banks $00, $1F, $69, $87 |
| pad 16, 3,000 frames | 152 | 104 | 31,982 | the same four banks ($1F from frame 1011) |
| pad $100, 3,000 frames | 107 | 149 (50 with under $100 bytes free) | 22,811 | banks $1F (frame 1011) and $87 ($00 and $69 could not be padded) |
| pad 16 without the four, 10,000 frames with --explore | 148 | – | 30,255 | no difference |

With banks $00, $1F, $69 and $87 left unpadded, the other 148 banks padded by 1 or 16 bytes run identical to the
original: 3,000 frames, and with 16 bytes also 10,000 frames of walking, talking and menus.

### The breaking references found

| Bank | Routine | What is fixed | Kind |
| --- | --- | --- | --- |
| $00 | FillTilesFromRequest | `ld de, $2940`: the 16 bytes of `db $ff, $00, ...` after its own `ret` (no label) | address as a number, bank $00 |
| $1F | DrawTextGlyph | steps through a glyph's 2-byte rows with `inc e`, not `inc de`, so GlyphFont rows must not cross a 256-byte page; a shift by 1 breaks it, by 16 does not | alignment |
| $1F | (glyph source lists) | `CopyFromBankWaitVRAM` copies from 1F:$40B0 = GlyphFont + $A0, an address that comes from a `dw $40b0, ...` list | tile address as a number |
| $69 | LoadMapObjectsForScreen | `add $74` ... `adc $41`: hMapId * 2 + $4174, the address of MapObjectTable split into two immediates | split address |
| $87 | FieldState_WalkATalks_RunStepTriggers | `add $a0` ... `adc $40`: hMapId * 2 + $40A0, MapStepTriggerTable | split address |

## Static inventory (tools/hardcoded_refs.py)

Counts from src/ at eb9066a with build/run651/dwm2.sym.

| Kind | Count | Banks | What it is | Likely real |
| --- | --- | --- | --- | --- |
| `code_split` | 124 | 39 | `add $LO` then `adc $HI`: a table address in two immediates (banks $02 14, $60 8, $00 7, $1A 6, $0A 6) | most; two confirmed above |
| `data_tiles` | 592 addresses | 9 | `dw` lists of tile addresses ($4000-$7FFF, multiples of 16) into another bank's graphics (banks $14 216, $1E 103, $1C 96, $5D 56, $F0 52) | yes; confirmed for the glyph lists |
| `code_bank` | 468 | 38 | `ld r, $NN` beside a label whose bank is $NN (363 `ld b`, 100 `ld a`); `ld b, $1f` for the font alone is 164 | yes, but matters only when data moves to another bank |
| `code_address` | 86 | 9 | an operand number equal to a label in bank $00 or its own bank | few: 75 are message ids and others are flag ids or counts; `ld de, $1d07` (Tiles_00_1D07, PatchTilesOnMap1Or2) is real |
| `code_number` | 0 | – | `ld rr, $4000-$7FFF` in a switchable bank | – |
| `data_word` | 149 | 37 | a `dw` number equal to a label | partly: many are palette colours or ids; some are the tile lists above |
| `data_bank` | 8 | 1 | a lone `db $NN` beside a `dw` label of bank $NN | no: bank $40's channel-slot offsets |
| `data_pair` | 5,107 | 130 | two `db` bytes that spell a label address | mostly coincidences (sound notes, tile numbers) |
| `incbin_raw` | 0 | – | asset slices that are not LZSS streams | – (all 3,546 slices are compressed streams) |

Other limits on moving things, seen while building the test:

- **One fixed section per bank.** src/main.asm places each bank as `SECTION "Bank NN", ROMX[$4000], BANK[$NN]`.
  Code can move within a bank (into its trailing `ds`), not between banks, until sections are split.
- **Free space.** 5 banks with labels have no `ds` after their first label ($13, $41, $52, $97, $98); 50 have less than $100 bytes free.
- **Bank-number bytes.** Byte $4000 of each switchable bank holds its bank number, read by the `$0010` helper
  (observed over the whole ROM; [project status](PROJECT_STATUS.md)). It must stay first.
- **What this does not cover.** RAM layout (src/ram.asm), the order of records inside tables, and code that the
  scripted runs never reach.

## M2 batch 1 (E-0389)

Every reference the runs found is now a label expression, made by tools/disasm_all.py (no hand edits in src/):

| Was | Now | How |
| --- | --- | --- |
| `ld de, $2940` (FillTilesBxC, FillTilesFromRequest) and 17 `ld hl, $2940` in bank $0C | `SolidColor1Tile` | config/operands.json names the target by hand; then every `ld hl/de/bc` of exactly a hand-confirmed bank-$00 address uses its label |
| `ld de, $1d07` (PatchTilesOnMap1Or2) | `Tiles_00_1D07` | config/operands.json |
| `ld hl, $1ab4` (LoadMapScreen_DrawMarker), found by `--reads 00` | `MapMarkerRecords` | config/operands.json |
| `add $74` / `adc $41` and 34 more split addresses | `add LOW(MapObjectTable)` / `adc HIGH(MapObjectTable)` | `name_split_addresses`: the sum is exactly a data label in the instruction's own bank (35 pairs) |
| glyph and tile source lists, `dw $40b0, ...` (532 words; the other 60 of the 592 counted were palette colours) | `dw GlyphFont + $a0, ...` | words of `TileCopySrcList` tables and of the eight tables.json lists of bank-$1F sources (`rom_bank`) are written as the table that holds them plus an offset |
| DrawTextGlyph's `inc e` | `ASSERT (GlyphFont & 1) == 0, ...` under GlyphFont | tables.json `assert`; padding bank $1F by 1 now fails the link with the reason instead of building a broken ROM |

The shift test gained two checks, because bank $00 showed that frames are not enough:

- `--persist N` (default 8): a frame difference counts only when it lasts N frames.
- `--reads BB` or `--reads all`: compares the order of every ROM data read (fetches left out), mapped through the
  padding, instead of the frames.

Why frames are not enough: a 16-byte shift changes RandomByteTable's low byte, so `add_a_to_hl` carries where it did
not and the code takes a few cycles more. With bank $00 padded, the random calls and their values were identical
but one call fell after the frame-1369 boundary, and from then on the random effects differed. A read comparison
does not depend on timing. It found MapMarkerRecords, and after the fix all 234,924 reads of 3,000 frames matched.

**Result.** With all 152 paddable banks padded by 16, every ROM data read of 10,000 frames with --explore lands
where the padded build put it: PASS, all 1,202,485 reads match (build/m2_readsall).

Static counts after batch 1 (src/ at this commit, build/run659):

| Kind | Before | After | What is left |
| --- | --- | --- | --- |
| `code_split` | 124 | 89 | sums that are not exactly a label: an index base before a table (`Label - 2`), sums into the middle of a block, and arithmetic constants such as `$0400` |
| `data_tiles` | 592 | 60 | none real: palette colours such as `$7C00`, which are multiples of 16 |
| `code_address` | 86 | 84 | none real: message ids, flag ids, step values and a byte count |
| `code_bank` | 468 | 468 | literal bank numbers; they matter when data moves to another bank |

## M2 batch 2 (E-0390)

The split-address rule now looks for the target bank: its own bank first, then a bank named for a far read just
after the sum (`ld b, $NN`, or `ld a, $NN` into B, rROMB0 or wDataBank). It accepts `Table + $offset` and `Data + $10`
(within $100 bytes of a data label with no code between), and bank-$00 code is included. 59 pairs are now label
expressions (35 after batch 1). Examples: SharedOBJPalettes from bank $12, MonsterSpritePalettes from four banks,
KeyWorldRoomPointers in bank $72, and StringTable_ItemNames in bank $08. Two were read by hand (config/operands.json
`splits`): SGBPaletteSets + $200, and the new label SkillTargetBoxRectIndex.

| Kind | After batch 1 | After batch 2 | What is left |
| --- | --- | --- | --- |
| `code_split` | 89 | 65 | 56 are not addresses (buffer offsets, cursor and row steps, checksum seeds); 9 look like addresses with no label or bank yet (E-0390) |

Gate: all 152 paddable banks padded by 16, all 1,202,485 ROM data reads of 10,000 explore frames match.

## M2 batch 3 (E-0391)

Bank numbers that name the bank of a pointer loaded next to them are written BANK(Label): `ld b, $NN` beside a
pointer into bank $NN, and `ld a, $NN` that goes straight into B, rROMB0 or wDataBank. There are 382 `ld b,
BANK(...)` setups and 14 `ld a, BANK(...)` switches; the `farcall` fold also accepts the BANK form, so the 3,842
`farcall` lines stay as they were. tools/hardcoded_refs.py `code_bank`: 468 to 96, and the 96 left are not banks.

## M2 batch 5 (E-0393): code can move between banks

Each bank file is now floating sections, and src/layout.link places them, so the matching build is unchanged while
a section moves to another bank by moving its line in the layout. Sections split only after an unconditional
ret, reti, jp or jr (9,071 sections); the cartridge header is pinned with `ORG $0104`.

- tools/bank_check.py: a call, jp or jr into another switchable bank is an error. A pointer into another bank with
  no bank named beside it is a warning: 511 on the matching layout, mostly script and data pointers whose bank is
  fixed by the code that reads them.
- tools/move_section.py: `--list` (255 sections with no unbanked tie to their bank) and `--move NAME --to BB`.
  ScriptWaitFrames and ScriptStepObject moved from bank $5F to empty banks run 3,000 identical frames. A routine
  reached by plain `call`s from its bank is caught by the bank check and diverges at frame 803 when moved.

## After M2 (E-0401): recipe runs, and every fixed-bank pointer asserted

**Wider runs.** `--recipe FILE` (with `--reads`) replays a tools/play.py recipe chain on both ROMs instead of the
scripted joypad: the 13 recipes in tools/recipes/ (included by e0335_swap.txt) play to the farm, battles, menus,
the save, GreatLog's town services, breeding, the library, the priest, keys and the swap. A script pointer poked
by a recipe moves with the padding; `call:LABEL` is looked up in each ROM's own symbols. The runs reach
2,299 routines (the explore script 461).

**A timing-proof comparison per instruction.** A moved address can change timing by a few cycles (a carry), and
then an interrupt lands elsewhere, a time-budgeted loop (FillTilesFromRequest) does more or less in one frame, and
the VBlank handler finds another bank mapped. So the recipe gate compares each reading instruction's own stream of
ROM data reads (its address mapped through the padding, and the interrupt it runs in), not one global order; byte
$4000 of a bank (its number, which says which bank is mapped) is left out. A fixed address still shows: the
instruction that reads it reads another address than its moved twin. `--until STATE` stops after one run.

**What it found** (each fixed by the generator or config, bytes unchanged):

| Where | Was | Now |
| --- | --- | --- |
| bank $69, the object list of map $1C screen 0 | ObjSelector_Map1C_1 as `db $fe, $ff, $fc, $76, ...`: MapObjects_Map1C_0_0's count of 2 reaches over the selector and the list it points to | `objsel_list MapObjects_Map1C_1_0` inside that list (a selector inside a list is printed as macros) |
| LoadMonsterPictureAttributes, LoadMonsterPictureAttributeBlock | `ld de, $20e9` | `ZeroPictureAttributes`, the 36 zero bytes after the routine |
| TextCmd_Pause | `ld hl, $2a66` | `TextPauseFrames` |
| FlagBitHandlerTable (bank $30) | 16 code addresses as `db` | `dw` of the eight personality rolls and the new routine FlagBitHandlerNone (xor a, ret; probed) |
| StartMessageForGroup_Data (bank $10) | 11 far pointers as `db` | `dfar` of the per-mode begin-message routines |

A static pass over the same kinds found:
- SoundNextEvent's `ld hl, $38a0`, now `SoundNextEvent.next5 + 4` (16 note bytes inside the routine);
- StartSoundAfterBankTable's `ld hl, $3e24`, now `SoundBankTable + $11` (one byte past its end; no caller);
- five more far-pointer runs as `db`, now `dfar`: NpcBreedMenu_RedrawListScreen_LoadTiles_Data1 and _Data2,
  DrawSpriteSlots_Data, three extra entries after Map06Screens0 and Map06Attrs0, and an unlisted screen and
  attribute set for map $1B (Map1BScreensUnlisted, Map1BAttrsUnlisted).

A scan of every `db` run for four or more words that are code-label addresses in the same bank, and three or more
far pointers to labels, finds nothing else outside sound data.

**The three split sums** of E-0392 are resolved: 60:$4BF4 is the new table KeyWorldSizeByStrength (100 size
bytes indexed by the party strength rounded down to 10 plus a roll of 0-9, ending where KeyWorldLayout_Start_Data
begins), and 0F:$4000 x2 is not an address but MSG_KEEP_OPEN added to a message word. `code_split` is 57, all
constants (offsets, steps, the $0400 background-map wrap).

**The 511 fixed-bank pointers.** tools/present.py writes `ASSERT BANK(Label) == $BB, "..."` after every pointer load
into another switchable bank with no bank named beside it: 512 loads, whose readers map that bank themselves
(script, text and graphics banks). No bytes; tools/bank_check.py counts them as asserted (0 warnings). A section
moved away from the bank its readers assume now fails the link: moving Bank 10 Script_HehSoTheseAre to bank $F8
stops with 424 such errors, where it used to build a ROM that reads the wrong bank.

**Result.** All 147 recipe runs, padding every paddable bank, PASS: 4,741,338 ROM data reads, each reading instruction's stream equal, with 152 banks padded by 16 (build/shift_recipe16) and with 107 banks padded by 256 (build/shift_recipe256), which also keeps every address's low byte and so the timing.

## The later worlds and link play (E-0406)

**The world tour.** tools/recipes/e0406_world_tour.txt adds 75 runs to the recipe chain: 25 of the 56 encounter
maps (tools/breed_path.py), from the Canal ($2B) to the Old maps ($C3), each entered by its location bytes, walked
and fought in. The chain then reaches 2,638 routines.

**The late story and a key world.** tools/recipes/e0406_late_story.txt starts 13 later scenes, one script each,
on Main Street by their RAM bytes and presses through them: the arrival, Kameha's return, the homecoming, the water,
the rival, the pirate ghosts, the explosion, the princess, the shield guardian, the grave, Darck's defeat,
Cyal and Rolt, and the ending. tools/recipes/e0406_key_world.txt opens the debug menu's AUTOMAP CHECK from a state with
a party; its A press generates the world of key 0 (GenerateKeyWorld) and enters it, and the party walks it and
fights. The same route from a state with no monsters crashes in the first battle: the battler copy runs from a party
count of 0 and overwrites the stack, a state play does not reach. Their chain (e0335_swap.txt, the late story and
the key world, without the tour) is 178 runs and reaches 2,522 routines.

**Link play.** tools/sm83.py now has a serial port. A transfer clocked by one console ends after 4,096 cycles (128
with the CGB fast bit). When the other console has a transfer started, the two SB bytes are swapped and both get
the serial interrupt; otherwise $FF comes in. The game's per-frame exchange has both consoles clocking at once, and
the model treats that as one exchange. Without a cable a transfer never ends, as before, so earlier observations
stay comparable. Real hardware would end it with $FF.

tools/link_play.py runs two linked consoles in cycle lockstep, each with its own recipe, and ends every run on
the same frame. tools/recipes/link_e0406_breeding.txt powers both on with a save and chooses BREEDING on the title
menu, A first while B's cursor waits on it. It then plays the link breeding screens: the farm list, info and
stats pages, and the "leveled up more" and "farm's roster" refusals. In this first version B's presses seemed not to
move its choice, so no child was bred; E-0410 found that they did (below), and the recipe now breeds one.
`--link-recipe` replays it on two linked base and two linked padded consoles.

**What they found.** EnterStatusEffectFieldState_Data, the list of 64 maps where the field status steps do not
run, had eleven byte pairs decoded as pointer words (`dw` of labels that happened to share their values). In a
padded ROM those words moved, so map $5D dropped out of the list and the poison step ran there. Reading the run of
pointer labels it shared led to AddSkillCToFreeOrWeakerSlot_Data in bank $1A: 170 words, one per skill, whose
unlabelled targets had been left as raw bytes. Both are now config/tables.json layouts, the lists named
SkillSupersedes_<skill>. No `dw` of a pointer-run label is left in src/.

**Result.** All 222 runs of the chain with the tour (tools/recipes/e0406_world_tour.txt and its includes), 9,702,777 ROM data reads, PASS padded by 16 (152 banks) and by 256 (107 banks). The late story and key world's chain (tools/recipes/e0406_key_world.txt, without the tour): 178 runs, 6,690,279 reads, 2,522 routines, PASS padded by 16 and by 256. The link recipe: 15 runs, 338,121 ROM data reads on two consoles, PASS
padded by 16 and by 256.

## A linked breeding, the shrine and Darck's taunt (E-0410)

**A linked breeding.** E-0406's reading that console B's presses did not move its choice was wrong. B was on the
Info / OK box (BreedMenu_ChooseParents_YesNoCursor), where each Up or Down press toggles the cursor, and its four
Down presses had brought it back to Info. tools/recipes/link_e0406_breeding.txt now runs to the end. A picks Stera
(a male WingSlime, level 11). B is refused Patta (level 4, "too young to breed") and Moahm (in the party, "Choose
from the farm's roster"), then picks Reny (a female Petiteel, level 12). Both choose Breed and record the results.
The egg scene runs, A receives PearlGel's egg and B Petiteel's egg, and both return to the title menu with their
cartridge RAM rewritten. 54 runs, 710,191 ROM data reads on two consoles, 579 routines.

**The shrine.** Header byte 7 (wMapHeaderByte7) is non-zero in 13 map records, always $2C: map 3, map $3B and the
11 maps sharing record $500C. On map 3, the shrine, $2C is the gate's tile: an A press facing it
(CheckInteractionInFront) opens the plan page's key list. tools/recipes/e0406_key_world.txt now also moves the party there, gives it a key
(GenerateNewKeyEntry) and has it appraised (Script_0D_62B8: BlueIslet). It then uses the key at the gate, which
warps into the key's world at its gate room (wMapType $87); the party walks down into the world (wMapType $80)
and fights. Before the appraisal the gate answers "The key could not be used yet."

**Darck's taunt.** tools/recipes/e0406_late_story.txt runs DARCK_TAUNT on Darck's castle (map $A2), from the line after
its battle (Script_SurprisinglyObedientAreYou, 10:$61D4).

**Result.** The key world's chain (tools/recipes/e0406_key_world.txt with its includes, without the tour): 200 runs,
7,480,100 ROM data reads, 2,644 routines, PASS padded by 16 (152 banks) and by 256 (107 banks). The link recipe
PASS padded by 16 and by 256.

## H4 (E-0414): the readers mods change, and a table moved with its readers

**The readers H2 and H3 change are in the gate.** The recipe chains with coverage (e0406_world_tour, e0406_late_story,
e0406_key_world) reach the readers of species, monsters, skills, items, shop prices and lists, AI weights, random
encounters, breeding and the text printer. tools/recipes/h4_readers.txt adds the three they miss, each called in a
field state on map $35:
- the encounter listing of field skill 16 (CollectUniqueEncounterIdsToWorkBuf2 and its table lookup);
- a set battle's start (StartScriptedEncounterTemp0), for 30 frames only: started outside a scene, the battle that
  follows is not a real one and later runs $FF bytes as `rst $38`;
- the arena's foe builder (ArenaRounds_RandomModulo52).

`shift_test.py --pad 16 --reads all --recipe tools/recipes/h4_readers.txt`: 151 runs, 2,316 routines, 4,792,239 ROM
data reads, PASS with 152 banks padded by 16.

**A fixed-bank table moved.** ScreenNumberListTable (the shops' price lists, bank $F2) was read by four routines
with a literal `ld b, $f2`: LoadScreenNumberListPointer, ShopMenu_Buy_DrawPrices,
ShopMenu_Buy_EnterQuantity_ComputeTotal and ShopMenu_Buy_ApplyGoldPass. Each now writes
`ld b, BANK(ScreenNumberListTable)`, which assembles to the same bytes. The table and its lists are their own
section (`Bank F2 ScreenNumberListTable`, placed right after the section they came from, so the ROM is unchanged).
The three reads of MonsterSpriteTable with `ld b, $04` are written the same way. That leaves 508 asserted loads, and
tools/bank_check.py now also accepts a `ld b, BANK(Label)` of the same label later in the straight-line code.

`move_section.py --move "Bank F2 ScreenNumberListTable" --to 8A` moves the 3,313-byte section in a copy:
- it builds;
- bank_check finds nothing;
- the frames match;
- ShopMenu_Buy_EnterQuantity_ComputeTotal gives the same total for all 342 items of the 24 shops, with and without
  the GoldPass (tests/test_move_table.py).

## E-0419: readers that named a table's bank by number

A table can move only if every reader finds its bank by the table's label. After H4, 508 loads carried
`ASSERT BANK(T) == $BB`: a move fails the link, and the reader still names the bank by number. E-0419 went through
them, and through the loads the old rule let pass:
- **A number beside the load becomes `BANK(T)`** (config/operands.json, so the generator writes it; same bytes). There
  are 9 `ld b, $NN` in switchable banks, copy helpers' bank for FieldSpritePalettes, SharedOBJPalettes and GlyphFont.
  There are 7 in the home bank: `ld b, $NN`, or `ld a, $NN / ld [rROMB0], a` before it reads the table
  (MonsterPaletteTable, MonsterSpriteTable, CopyKeyNameWordToDE_StringList, MonsterAttributeMapTable and others).
- **A routine in the table's own bank reads it:** `ASSERT BANK(T) == BANK(Reader)`, for 23 loads read by
  DrawTileRectFromArg1Params or FillTileRectWithArg1Tile (bank $1F), LoadTileListSixPerCall ($1D) or
  TestBitInFieldAtArg3 ($15). The table moves with its reader.
- **Ties no ASSERT showed.** Any `ld b, $NN` (often a count) or farcall within three lines counted as naming the
  bank, and the home bank was not checked. That hid 46 loads: 16 scripts, title-screen tile maps ($E1), digit tiles
  ($31), sprite graphics ($7D), map screens, and 5 home-bank loads. Only BANK(label) counts now, so they are asserted.
  tools/bank_check.py and tools/present.py share one walk of the code from the load to its read: past a conditional
  `jr`, and past a local label jumped to only from that code.

Result: 545 asserted loads (522 by number, 23 by reader), 0 warnings. The 440 script loads cannot follow their
scripts without an interpreter change: the interpreter in bank $10 reads script bytes from its own bank. (E-0419
also said that bank has no free byte. That was wrong: it ends in 5,848 bytes of fill, `ds $16d8` in src/ and zeros
in the reference; E-0421.)

**A moved table** (tests/test_fixed_bank_readers.py). MonsterAttributeMapTable (383 far pointers, bank $38) moves to
the empty bank $9E in a copy. LoadMonsterPictureAttributes writes the same VRAM attributes for all 383 monsters. With
its operand put back to $38, 351 differ.

## E-0420: bank numbers stored in wDataBank or passed to a bank copy

E-0419 checked pointer loads. Two more ways name a bank by number, and neither had an ASSERT:
- `ld a, $NN / ld [wDataBank], a`: the bank ReadWordFromDataBank reads, and the bank a script reads after
  `script_jump_data_bank` (70 sites);
- `ld b, $NN` before CopyFromBankWaitVRAM or OrFromBankWaitVRAM, which copy from bank B (21 sites).
Bank $09's key names were among them, and they blocked moving that bank's text. 90 of the 91 now name a label
(config/operands.json; same bytes):
- 66 stores in talk routines set wDataBank for the scripts the routine starts (before or after the start), whose
  `script_jump_data_bank` targets are in that bank (Script_Priest and Script_Library in $1F, Script_Shop_5 and
  Script_Vault in $10, Script_Rename and Script_EggService in $96, Script_Breed in $15, ...): `ld a,
  BANK(target)`. All the targets of a routine's scripts are in one bank, checked when the entries were written;
- 9 tile copies from bank $1F: `ld b, BANK(GlyphFont)`. Every pointer word into bank $1F from outside it (534) is
  `GlyphFont + n`;
- 9 name copies from bank $08, read through a list the routine loads with BANK(StringDatabase) just before:
  `ld b, BANK(StringDatabase)`;
- bank $09's key names: 3 copies (`BANK(StringList_Bank09_StringCategories_6)` twice,
  `BANK(CopyKeyNameWordToDE_StringList)` once) and the 2 wDataBank stores before CopyDataBankStringToTextBuf0;
- ReadBank6TableWord's wDataBank: `BANK(AIPersonalityWeightTable)`.
One is left: GreatLogTalkEvents_Breeder sets wDataBank = $0E, and the two scripts it starts read nothing through it.
tools/bank_check.py reports both forms as "literal" (91 before, 1 now); tests/test_sections.py holds the count.

## E-0421: event scripts in other banks (mods)

The interpreter in bank $10 reads a script from the mapped bank (its own), or, in the game's data-bank mode
(wScriptInDataBank = 1, after `script_jump_data_bank`), from the bank in wDataBank. Only the message, jump, skip,
choice and two message-form handlers read through wDataBank; the walk, face, wait, flag, sound and command handlers
read the mapped bank. tools/script_bank.py changes a mod's copy so a script can be anywhere ([making a
mod](MODDING.md#event-scripts-in-other-banks)):
- wScriptInDataBank 2 and up names the script's own bank. Two home-bank helpers (ReadScriptWord, ReadScriptByte)
  read in all three modes, and every fetch handler reads through them; modes 0 and 1 behave as before.
- Opcode $08, unused, becomes `script_jump_far`: a bank byte and an address.
- The two routines that start scripts clear a far mode first, through a home-bank StartScriptAtHL. A moved script
  that a scene command ends without `$FF` would otherwise leave the next script read from the wrong bank (found by
  the farm chain: the first move ran Script_ListenYouTwoQuit from bank $9F).
- `move` takes bank $10's scripts as runs (to the next terminator) joined by relative jumps, renames the moved labels
  X_Far and leaves a stub `X:: script_jump_far X_Far` for each label named elsewhere, so the 440 asserted starters
  and every table of scripts stay as they are.

All 627 movable runs of the 637 (6,207 bytes) move to bank $9F, with 416 stubs; bank $10 gains 4,466 bytes and every
bank is exactly full (the linker map: 0 bytes free). Over all 17 recipe chains (279 runs; see the evidence log,
E-0421) the moved ROM fetches the same script positions as the reference. The screens differ only by timing, since
the patched reads take more cycles: a few VBlanks in some runs, one run a frame behind (bb19!), and one boss battle
(ls12b!) where a button press lands on another turn, as it does with the interpreter patch alone, nothing moved.
The late-story recipe started its scenes by poking raw bank-$10 addresses; it now names them (BANK/LOW/HIGH of the
label, tools/play.py), so a moved script is still found.

## E-0422: the leftover scripts, and data-bank script sections that move

- **Leftovers.** The raw bytes after eight bank-$10 scripts decode as script to the last byte: 19 short scripts
  that nothing starts, now read as script (config/script_entries.json, named `..._Leftover`). With them, all 656
  bank-$10 runs could move with tools/script_bank.py (E-0423 keeps six back; below).
- **Script sections.** The data-bank scripts (arena $0C, key appraisal $0D, NPC breeding $0E, breeding $15,
  hibernation $1D, swap $1F, egg service $96; the priest and library already had one) get sections of their own
  (tools/present.py: a section starts at a Script_ label after data or ended code, and at another label after a
  script's last line). Their talk routines name the bank (E-0420), so a section moves with tools/move_section.py
  like any other. A script jump into another bank is a bank_check error, so sections that jump to each other (the
  arena's two, hibernation's three) move together: `--move` may be given more than once.
- **Checked on tools/sm83.py:** breeding (122 runs), priest and library (128 runs) and an arena battle with its
  resume, each with its scripts in bank $9F, play frame for frame as the original. A battle saves wDataBank in
  wDataBankSave and restores it at its end, so a script resumed in data-bank mode reads the bank its talk routine
  named.
- **The one literal left** (GreatLogTalkEvents_Breeder's wDataBank = $0E) is read by nothing; bank_check lists it as
  "unread".

## E-0423: every data-bank script section moved; the original timing kept

- **All eleven data-bank script sections** (arena, key appraisal, NPC breeding, breeding, hibernation, priest and
  library, swap, egg service and renaming) moved together to bank $9F play VBlank for VBlank as the original over
  the key-world chain (200 runs, every chain from the farm on), the arena chain and a new menus chain
  (tools/recipes/e0423_menus.txt: egg service, renaming, NPC breeding).
- **Two faults found on the way.** tools/move_section.py now gives an empty target bank its number byte at $4000
  (the VBlank handler and ReadWordFromDataBank map the interrupted bank back from it). And the breeding menu's
  tile-reload steps named their bank-$1D tile list after a bank-$15 routine at the same address
  (SRAMBank1RecordAddress); it is now BreedMenu_ReloadTiles_DestList, asserted in LoadTileListSixPerCall's bank.
  tools/bank_check.py warns about a code label of a routine's own bank handed to a routine far-called in another
  bank, which is how that one hid.
- **tools/script_bank.py keeps the original timing.** Moved bank-$10 scripts run in the game's data-bank mode with
  far variants of the opcodes whose handlers read the mapped bank (in unused opcode slots), so the game's handlers
  stay as they are. With the patch alone, the recipe chains play VBlank for VBlank as the original; only script
  starts cost 36 cycles more (StartScriptAtHL clears data-bank mode). A moved bank-$10 script costs what the game's
  data-bank scripts cost, so a few VBlanks can still shift around it. Because a moved script sets wDataBank, the six
  talk scripts the breeding, arena and NPC breeding menus run while their data-bank script waits stay in bank $10
  (650 of 656 runs move).

## Left after M2

1. Done (E-0392, E-0401): no address-like split sum is left.
2. Done (E-0393, E-0401, E-0414). Plain calls inside a bank and the 508 asserted pointers still tie code to its bank; the
   link says which when a move breaks them, and moving one of those needs its reader changed too.
3. Widened (E-0401, E-0406): the recipe runs reach 2,638 routines, with 25 later-world maps and a
   link session; the chain with the late story's scenes and a generated key world, 2,522. E-0410 adds a completed
   link breeding, a key world entered at the shrine and Darck's taunt on his own map (above).
