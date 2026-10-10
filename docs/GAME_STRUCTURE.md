# How the game is put together (from reading and from running it)

Everything here is an OBSERVATION of the reference ROM at confidence C1 unless marked: static reading of the
generated source plus execution on our own emulator (`tools/sm83.py`, not checked against hardware). Evidence:
E-0027 to E-0030 in [EVIDENCE_LOG.md](EVIDENCE_LOG.md). Names describe behaviour; the purposes of game systems are
not claimed beyond what the screens and code show. To see it yourself: `python -I tools/explore.py play start start a a`
(screenshots land in `build/shots/`; the reference ROM stays in `local/roms/`).

## Boot and the frame loop

- `$0150` (`Func_000_0150`) sets `wIsCGB`, clears VRAM, probes for a Super Game Boy (`DetectSGB`) and starts the
  main loop at `$02D2`.
- The main loop calls `RunGameModeInit`, then `halt`s until `wModeChangeRequest` becomes non-zero. Everything else
  happens in the VBlank interrupt.
- `VBlankHandler` (`$03A4`, entered from `$0040`) runs once per frame: OAM DMA, palette upload, queued BG-map write,
  scroll and LCDC restore, screen shake, joypad poll, `SoundTick`, random seed, `ProcessSoundQueue`,
  `GameFrameUpdate` (which calls `RunGameModeUpdate`), the string-display step, `StepFade`, the frame counter. The
  game resets when A, B, Select and Start are all held.

## Game modes

`wGameMode` (`$C5DB`) picks one of nine modes. `RunGameModeInit` and `RunGameModeUpdate` each jump through a table.
Forcing a mode at the title screen showed:

| Mode | Banks (init / update) | What forcing it shows |
| --- | --- | --- |
| 0 | `$01` | "DEBUG MODE SELECT / 1:GOTO PROGRAM" |
| 1 | `$02` | the field: a map with the player sprite (the opening ship deck in a normal game) |
| 2 | `$03` | a monster panel (incomplete state) |
| 3 | none | black |
| 4 | `$31` | sparkles on black |
| 5 | `$07` | title screen and its intro; the boot mode |
| 6 | `$24` | a victory screen ("YOU WIN!") |
| 7 | `$A0` | two monster panels |
| 8 | `$F2` | an egg-received dialogue |

Forcing skips set-up, so the screens are partial. The routines are `GameMode0_Init` ... `GameMode8_Update`.

## Systems with names

- **Input:** `ReadJoypadDirect`, `PollJoypad`, `UpdateJoypadPresses`; state in `wJoypadHeld`, `wJoypadPressed`,
  `wJoypadPressedRepeat` (auto-repeat after 20 frames, then every 6).
- **Sound:** `SoundTick` runs the 6 channel slots every frame; music and effects are requested with `QueueMusic` and
  `QueueSoundEffect` (403 call sites) and started by `ProcessSoundQueue`. Tracks are decoded in
  [E-0018/E-0019](EVIDENCE_LOG.md).
- **Text:** strings are looked up with `LookupString` (category in `wStringCategory`, index in `wStringIndex`),
  started with `BeginStringDisplay` and drawn by the step routine at `$2620`. Bank `$08` holds the shared string
  database; 38 banks have their own table (`BeginStringDisplay_BankBB`).
- **Graphics:** compressed assets use the decoder in `tools/lzss_gfx.py`; sprites are drawn through
  `BuildOamFromSpriteTable` (fixed screen position) and `DrawMetaSprite` (world position, 16-bit); `wSpriteSlots`
  holds eight animated sprite slots (`DrawSpriteSlots`); `wScreenTileBuffer` holds the screen's tile ids.
- **Field mode:** `UpdatePlayerMovement` and `CheckInteractionInFront` read the D-pad and A button; the player's
  facing is `hPlayerFacing` (0 down, 1 right, 2 up, 3 left), its position `hPlayerX`/`hPlayerY` in steps of 16;
  `TileBlockedAtPixel` tests the tiles ahead; `IncrementPlayTime` keeps the play clock (`wPlay*`).
- **Super Game Boy:** `SendSGBPacketSet`, `SGBTransferCompressed`, `SGBTransferRaw` follow the documented packet
  protocol and are skipped unless `wSGBActive`.
- **Saves:** records of `$A5` bytes at `sA000` (`SRAMRecordAddress`).
- **Data tables (E-0031 to E-0033):**
  - `SkillTable` (bank `$1A`, 175 records of 17 bytes) and `MonsterTable` (bank `$34`, 592 records of 26 bytes, with the
    base HP, MP, ATK, DEF, AGL and INT words and four skill ids) are emitted field by field in `src/`; loaders are
    `LoadSkillRecord` and `LoadMonsterRecord` (ids from `$250` use bank `$A2`).
  - Bank 6 is a table of `$36`-byte rows of 27 signed words, one column per personality, read by `ReadBank6TableWord`;
    `PersonalityIndexOfRecord` and `PersonalityIndexOfSlot` compute the column (0-26, the 27 personality names).
  - Strings: bank `$08` holds categories 0-8; categories `$09`-`$14` (skill descriptions, tactics, targets, skill families,
    types, usability) live in bank `$95`; monster names are in bank `$88` (category = id high byte).
- **Debug mode (mode 0):** a developer menu reachable by forcing the mode: program launcher, message test, skill viewer,
  monster viewer, sound test, automap. It is the quickest route to the tables above.

## Not yet known

Battle, menus, monster data, map data and the per-state handlers inside each mode are present in the source but not
named. About half of all call sites reach a named routine; the rest need the same reading and running.
