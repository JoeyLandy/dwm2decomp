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

## Left after M2

1. Done (E-0392, E-0401): no address-like split sum is left.
2. Done (E-0393, E-0401). Plain calls inside a bank and the 512 asserted pointers still tie code to its bank; the
   link says which when a move breaks them, and moving one of those needs its reader changed too.
3. Widened (E-0401): the recipe runs reach 2,299 routines. Most of the game (key worlds, late story, link
   play) is still reached only by the static inventory; more recipes extend the gate.
