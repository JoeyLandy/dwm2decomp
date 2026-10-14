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
| `src/<dir>/bankNN_<topic>.asm` | One ROM bank each, named and headed by what it holds and kept in a directory by kind, as in pokered (D-010):<br>`home/` (bank 0);<br>`engine/` (mostly code: `engine/bank36_battle_effects.asm`);<br>`scripts/` (the event scripts);<br>`text/` (messages and strings: `text/bank2f_battle_text.asm`);<br>`data/` (tables);<br>`maps/` (maps, key worlds, map objects);<br>`gfx/` (sprites, pictures, tile sets);<br>`audio/` (sound tracks);<br>`unused/` (the empty banks).<br>The topics and directories are in `config/banks.json`. |
| `src/ram.asm` | Names for work RAM (`w...`), high RAM (`h...`) and save RAM (`s...`) addresses, each with a note. |
| `src/records.inc` | Field offsets inside the game's records: `MON_*` (a monster in the save, $A5 bytes), `BATTLER_*` (a monster in battle), `SPECIES_*`, `OBJ_*` (a field object), and `RESIST_*`, the 27 resistances. Code names a field as `ld c, MON_LEVEL` before a record-access routine. |
| `src/constants.inc` | Named ids made from the ROM's own name tables: `MONSTER_DRACKY`, `SKILL_DEMAGIC`, `ITEM_HERB`, and `ACTION_FIGHT` for the plain attack. Code compares battle actions by name (`cp SKILL_DEMAGIC`), and data tables list skills and monsters by name (`db SKILL_BEDRAGON, SKILL_FIREAIR, SKILL_SUCKAIR ; natural skills`). |
| `src/macros.inc` | Macros for the ROM's own idioms (below) and the event-script command constants. |
| `src/charmap.inc` | The text encoding: characters, and the text printer's commands as `<TOKENS>`. |
| `src/constants.inc` (continued) | Story flags as `EVENT_*`, named after what sets them (`EVENT_THANKS_FOR_COMING_BY` is set by the talk routine that says it; the comment names the setter), and battle status bits as `BSTAT<byte>_<NAME>` (`bit BSTAT0_ASLEEP, [hl]` on `wBattleStatus`). |
| `src/assets.txt` | The asset files the source includes by name (`INCBIN "gfx/monster_sprites/drak_slime.lz"`, `maps/map00/screens0_y1_x1.bin`, ...): each one's offset and length in the original ROM. The build extracts them from your copy of the ROM into its own directory, so no game data is stored in the repository. `.lz` files are compressed with the game's LZSS scheme (`tools/lzss_gfx.py`). |
| `src/hardware.inc` | Game Boy hardware register names, each with what the register does. |

The files are generated from `config/*.json` by `tools/disasm_all.py`, so edit the config, not `src/`. Every run also writes an annotated listing to `build/listing/bankNN.asm`, with each label's address, the heuristic that found it, its callers, and the RAM it reads and writes. Use it when the source alone is not enough.

## Names

- **Routines** have names that say what they do: `RunTextCommand`, `TryAllyGuard`, `InnMenu_ShowPrice`.
  - A name like `Parent_Step` is a step of `Parent`: a case of its jump table or a routine only it calls.
  - `_Bank36` marks one of several identical copies of a helper, one per bank.
  - Every routine has a comment above it. A note written by reading says what the routine does, its inputs and outputs (`A = level`, `HL = ...`, `carry = success`), and the evidence for it (`E-0337`, see below).
  - A comment ending in `(E-0347)` is generated from the instructions by `tools/describe.py`. The `; why:` line under it says what the routine is for: which step of which jumptable (and the RAM byte that picks it), which routine it helps or continues, and what that documented routine does (E-0352). It says what the code does, not why: `; step 1 of SceneRoltElder: increments wObject1 + OBJ_X; decrements wObject2 + OBJ_Y; returns unless wObject2 + OBJ_Y is $60; ...`. "step N of P" is entry N of P's jump table, and "may return early" or "branches on X" marks control flow that the one line leaves out.
  - A written note that says the body was not read is followed by a `; code:` line, which restates the body the same way.
- **Local labels** start with a dot (`.loop`, `.skip`, `.read_battle_target`) and belong to the routine above them.
- **Data** labels name what is there, and each table has one comment above its first label (text needs none; the text is its own documentation). A small block with no note is described by its reader and size (`; data read by VaultMenu (8 bytes)`). `String_08_04_01` is string 1 of category 4 in bank `$08` (a skill name), `Message_00_00` the first story message, `MonsterSprite_DrakSlime` a compressed sprite, `SoundTrack_...` a music track.
- **RAM** names: `wTextSpeed`, `wPersonalityActs`, `sSaveSignature`. A work byte that different routines reuse is named after its main use; `config/symbols.json` lists the others (E-0345).

## Idioms and macros

- `jumptable` (`rst $00`) jumps through the list of `dw` labels right after it, picking entry `a`. Game modes, menus, battle steps and text commands all dispatch this way:

  ```
      ld a, [wScreenState]
      jumptable
      dw InnMenu_Init       ; state 0
      dw InnMenu_ShowPrice  ; state 1
  ```

- `farcall Label` calls a routine in another bank; `dfar Label` is a pointer with its bank in data.
- `lb bc, $14, $08` loads B and C separately (B = 20, C = 8). The source uses it wherever a pair holds two bytes: rectangles (B = width, C = rows), resolve messages (B = argument, C = flags; H = target, L = actor), sprite steps toward a point (D = X, E = Y), text windows. Negative constants are written signed (`ld hl, -999`), amounts in decimal (`ld hl, 20000`). A message word reads `MSG_KEEP_OPEN | $0487`: the low byte is the message, H bits 0-5 its group, and bits 6-7 the box flags in `constants.inc`.
- `add_a_to_hl` (`hl += a`) and `deref_hl` (`hl = [hl]`, a word) are short helper idioms.
- `script_*` macros write the event-script language that runs scenes and conversations: `script_message`, `script_walk`, `script_set_flag`, `script_jump`, and the command types named in `macros.inc`.
- `objsel_*` macros write the map object selectors, which choose which people and objects a map shows from story flags.

## Text

For a worked example of a jump table, shared stage tail, byte overflow and a
call between ROM banks, see [the scripted player and follower paths](OBJECT_PATHS.md)
(C1, E-0358). [The arena scene](ARENA_SCENE.md) shows shared stage tables,
borrowed RAM counters, message-word lookups and caller bank assumptions (C1, E-0359).
[The link and breeding presentations](LINK_BREEDING_SCENES.md) show shared
animation stages, distinct returns and a branch that skips saving a work byte (C1, E-0360).
[The follower commands](FOLLOWER_COMMANDS.md) explain exact coordinate stops,
target snapshots and the screen-action wait (C1, E-0361).
[Sprite overrides and map-link warps](SPRITE_WARP_COMMANDS.md) follow a slot
graphics ID through loading, rendering, countdown and restoration, with the
packed destination and position-region tables (C1, E-0362).

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

The confidence of each routine and RAM name is in `config/names.json` and `config/symbols.json`. Whole-routine explanations also live in `config/annotations.json` (E-0357, E-0358), which is the editable source for those comments. A note that says "C2 from E-0320" was observed when the game ran in `tools/sm83.py`, the project's own emulator.

## Building

```bash
python -I tools/build.py --out build/run1
```

The build assembles `src/` with RGBDS and compares the result with the original ROM byte for byte. It first checks that ROM against the target's SHA-256 and extracts the asset files of `src/assets.txt` from it. It reports `RESULT: PASS | differing bytes: 0` when they match. The original ROM is not part of the repository; it is read from `local/roms/`.
