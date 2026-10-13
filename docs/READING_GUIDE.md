# Reading the source

This guide explains how `src/` is laid out and how to read it. The style follows the pret disassemblies (pokered and others). Every byte of the ROM comes from these files, and the build checks the result against the original cartridge. The first section explains the Game Boy terms the rest of the guide uses.

## The Game Boy in one page

- **CPU.** The SM83 is an 8-bit CPU with registers `a` (the accumulator), `b`, `c`, `d`, `e`, `h` and `l`. They pair up as `bc`, `de` and `hl` for 16-bit addresses. `[hl]` means "the byte at the address in hl"; `[hli]` reads or writes it, then increments `hl`. The flags `z` (zero) and `c` (carry) are set by arithmetic and comparisons (`cp $10` compares `a` with `$10`) and tested by `jr z`, `jr nc`, `ret c`, and so on.
- **Memory map.**
  - `$0000-$3FFF` is ROM bank 0, always mapped.
  - `$4000-$7FFF` is one switchable ROM bank at a time; the cartridge has 256 banks of 16 KB.
  - `$8000-$9FFF` is video RAM: tiles and background maps.
  - `$A000-$BFFF` is the cartridge's battery-backed save RAM.
  - `$C000-$DFFF` is work RAM.
  - `$FF00-$FF7F` holds the hardware registers (`rLCDC`, `rNR50`, ...) and `$FF80-$FFFE` the fast "high RAM" (`h...` names).
- **Banks.** Code in one switchable bank calls code in another with `farcall Label`. It loads `hl` and `b` and runs `rst $10`, which maps the bank, calls the label and maps the caller's bank back. Each switchable bank holds its own number in its first byte (`db $36` at the top of bank `$36`).

## Files

| File | Holds |
| --- | --- |
| `src/main.asm` | The include list: definitions first, then the 256 bank files in order. |
| `src/banks/bankNN_<topic>.asm` | One ROM bank each, named and headed by what it holds (`bank00_home.asm`, `bank36_battle_effects.asm`, `bank2f_battle_text.asm`). The topics are in `config/banks.json`. |
| `src/ram.asm` | Names for work RAM (`w...`), high RAM (`h...`) and save RAM (`s...`) addresses, each with a note. |
| `src/records.inc` | Field offsets inside the game's records: `MON_*` (a monster in the save, $A5 bytes), `BATTLER_*` (a monster in battle), `SPECIES_*`, `OBJ_*` (a field object), and `RESIST_*`, the 27 resistances. Code names a field as `ld c, MON_LEVEL` before a record-access routine. |
| `src/constants.inc` | Named ids made from the ROM's own name tables: `MONSTER_DRACKY`, `SKILL_DEMAGIC`, `ITEM_HERB`, and `ACTION_FIGHT` for the plain attack. Code compares battle actions by name (`cp SKILL_DEMAGIC`), and data tables list skills and monsters by name (`db SKILL_BEDRAGON, SKILL_FIREAIR, SKILL_SUCKAIR ; natural skills`). |
| `src/macros.inc` | Macros for the ROM's own idioms (below) and the event-script command constants. |
| `src/charmap.inc` | The text encoding: characters, and the text printer's commands as `<TOKENS>`. |
| `src/constants.inc` (continued) | Story flags as `EVENT_*`, named after what sets them (`EVENT_THANKS_FOR_COMING_BY` is set by the talk routine that says it; the comment names the setter), and battle status bits as `BSTAT<byte>_<NAME>` (`bit BSTAT0_ASLEEP, [hl]` on `wBattleStatus`). |
| `src/assets.txt` | The asset files the source includes by name (`INCBIN "gfx/monster_sprites/drak_slime.lz"`, `maps/map00/screens0_y1_x1.bin`, ...): each one's offset and length in the original ROM. The build extracts them from your copy of the ROM into its own directory, so no game data is stored in the repository. `.lz` files are compressed with the game's LZSS scheme (`tools/lzss_gfx.py`). |
| `src/hardware.inc` | Game Boy hardware register names. |

The files are generated from `config/*.json` by `tools/disasm_all.py`, so edit the config, not `src/`. Every run also writes an annotated listing to `build/listing/bankNN.asm`, with each label's address, the heuristic that found it, its callers, and the RAM it reads and writes. Use it when the source alone is not enough.

## Names

- **Routines** have names that say what they do: `RunTextCommand`, `TryAllyGuard`, `InnMenu_ShowPrice`.
  - A name like `Parent_Step` is a step of `Parent`: a case of its jump table or a routine only it calls.
  - `_Bank36` marks one of several identical copies of a helper, one per bank.
  - A comment above a routine says what it does, its inputs and outputs (`A = level`, `HL = ...`, `carry = success`), and the evidence for it (`E-0337`, see below).
- **Local labels** start with a dot (`.loop`, `.skip`, `.read_battle_target`) and belong to the routine above them.
- **Data** labels name what is there: `String_08_04_01` is string 1 of category 4 in bank `$08` (a skill name), `Message_00_00` the first story message, `MonsterSprite_DrakSlime` a compressed sprite, `SoundTrack_...` a music track.
- **RAM** names: `wTextSpeed`, `wPersonalityActs`, `sSaveSignature`. A name that still spells a byte number (`wBankF0ByteA8`) is one whose purpose is only partly read.

## Idioms and macros

- `jumptable` (`rst $00`) jumps through the list of `dw` labels right after it, picking entry `a`. Game modes, menus, battle steps and text commands all dispatch this way:

  ```
      ld a, [wScreenState]
      jumptable
      dw InnMenu_Init       ; state 0
      dw InnMenu_ShowPrice  ; state 1
  ```

- `farcall Label` calls a routine in another bank; `dfar Label` is a pointer with its bank in data.
- `lb bc, $14, $08` loads B and C separately (B = 20, C = 8). The source uses it before calls to the rectangle routines, which take a width in B and a number of rows in C.
- `add_a_to_hl` (`hl += a`) and `deref_hl` (`hl = [hl]`, a word) are short helper idioms.
- `script_*` macros write the event-script language that runs scenes and conversations: `script_message`, `script_walk`, `script_set_flag`, `script_jump`, and the command types named in `macros.inc`.
- `objsel_*` macros write the map object selectors, which choose which people and objects a map shows from story flags.

## Text

Strings use the charmap. Ordinary characters are written as text, and the text printer's commands (bytes `$E0-$FF`) as tokens:

```
Message_00_01::
    db "<VOICE1>Cobi: <BUF0>!<LINE>"
    db "Papa's calling.<PROMPT>"
    db "<NEXT>He's at the stern."
    db "<NEXT>Hustle, hustle!<WAIT>"
    db "@"
```

| Token | Meaning |
| --- | --- |
| `@` | end of the text |
| `<LINE>` | start the second line |
| `<NEXT>` | next line, scrolling the window up when it is full |
| `<WAIT>` | wait for a button |
| `<PROMPT>` | show the blinking arrow and wait for a button |
| `<BUF0>`-`<BUF3>` | insert a name or word the game filled in (`wTextBuf0`-`3`) |
| `<PLAYER>` | the player's name |
| `<VOICE1>`, `<VOICE2>` | the speech beep while a person talks |
| `<INSTANT>`, `<PAUSE>`, `<CLEAR>`, `<CHOICE>`, ... | see `src/charmap.inc` |

A command that takes an argument has it right after the string as `$xx`: `"<SFX_WAIT>", $7e`.

## Confidence and evidence

Names and notes carry evidence ids such as `E-0336`; [EVIDENCE_LOG.md](EVIDENCE_LOG.md) records what each one rests on. The confidence scale is:

- C1: a reading of the code;
- C2: supported, for example observed in the emulator;
- C3: verified within a stated scope.

The confidence of each routine and RAM name is in `config/names.json` and `config/symbols.json`. A note that says "C2 from E-0320" was observed when the game ran in `tools/sm83.py`, the project's own emulator.

## Building

```bash
python -I tools/build.py --out build/run1
```

The build assembles `src/` with RGBDS and compares the result with the original ROM byte for byte. It first checks that ROM against the target's SHA-256 and extracts the asset files of `src/assets.txt` from it. It reports `RESULT: PASS | differing bytes: 0` when they match. The original ROM is not part of the repository; it is read from `local/roms/`.
