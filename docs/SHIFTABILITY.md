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
    Moving code does not change instruction timing, so a ROM that still works matches frame for frame. A crash
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

## Next (M2)

1. Write the five confirmed references with labels: `ld de, FillTilesFromRequest_Pattern`; `ld de, Tiles_00_1D07`;
   the split additions as `LOW(MapObjectTable)` and `HIGH(MapObjectTable)` with carry; the glyph lists as
   `GlyphFont + $A0`-style expressions; an `ALIGN` or assert for DrawTextGlyph's rows.
2. Work through `code_split` and `data_tiles` bank by bank. These are the generator's job: tools/disasm_all.py emits
   them, so the fix belongs there, with an identity build after each batch.
3. Then `code_bank` as `BANK(label)`, which is needed before anything moves between banks.
4. Rerun tools/shift_test.py after each batch. The M2 gate: no difference over a long `--explore` run with every
   bank padded, and the static counts of the confirmed kinds at 0.
