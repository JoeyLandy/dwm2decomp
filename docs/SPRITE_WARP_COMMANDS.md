# Sprite overrides and map-link warp stages

These are C1 readings for `dwm2-cobi-us-rev0`, reference SHA-256
`8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
[E-0362](EVIDENCE_LOG.md#e-0362--sprite-override-selection-rendering-and-map-link-warps)
records the evidence, contrasting probes and limits. Core source is bank $12
CPU [$4FEA,$51F4), file offsets [$48FEA,$491F4), in
[bank12_field_objects.asm](../src/engine/bank12_field_objects.asm).
The shared lift is at $12:$557C. Graphics loading and rendering are in
[bank04_field_events.asm](../src/engine/bank04_field_events.asm); the override
countdown is at $0A:$5748. Bank numbers are hexadecimal and ranges half-open.

Each command reads `wScriptStep` and dispatches through the inline `rst $00`
word table. Bank-$10 wrappers `ScriptCommandA0`, `ScriptCommandA1` and
`ScriptCommand8E` at [$496A,$497F) far-call the bank-$12 command once per update.
None of these tables validates the stage index. Writing script request $80
asks the script engine to fetch the next opcode. The small scripts for these
commands have `$FF` afterward, but the request itself does not mean termination.
(C1, E-0362; request consumer E-0361.)

| Command | Stages, from step 0 |
| --- | --- |
| `PlayerSpriteFlash` ($4FEA) | Save palettes; flash; select slot graphics; turn; activate/load and turn; turn; turn; resume script |
| `PlayerSpriteMessage` ($50B3) | Open message $12; wait for idle; restore default graphics and resume |
| `MapLinkWarp` ($50E5) | Lift player/followers for 90 calls; select destination and request the next opcode |

These sequences and the following contracts are C1, E-0362. The flash starts
with sound $7A and a copy of all 64 background-palette bytes on CGB. Its shared
palette helper tests **incoming phase bit 2**: four-call groups alternate the
saved background bytes with their bytewise complements. DMG palette bytes
alternate between ($D2,$D2,$E2) and ($2D,$2D,$1D). CGB object palettes are not
complemented here. The phase increments toward exact 30, then resets and
advances; from phase 0 its final group restores the normal background copy.
An arbitrary larger phase wraps before completion.

The selector uses `(updated RNG high byte & 7)` as the slot index and retries
until it is below the captured `wSpriteSlotCount`, with slot X<$A0 and Y<$90.
Only slots 0–7 can be selected, even if the count is larger. It does not test
slot state byte 0. The pointer detail matters: reading X with `[hli]` advances
HL to byte 12; reading Y without increment leaves it there; subtracting $0B
then points to **byte 1**. The next three bytes are graphics kind and a
little-endian graphics ID, not bytes 0–2 and not a compressed-stream pointer.
The exact triple (1,$5E,0) is rejected; (kind $81,id $005E) is accepted.
There is no retry limit if the first eight slots have no eligible candidate.
The recurrence is `(5*seed+11) modulo 65536`; this does not establish uniform
selection or statistically independent draws.

Selection sets timer 100 and facing down. Each turn stage increments a byte
phase toward exact 3, then sets facing `(facing+1)&3`, resets phase and advances.
There are four three-call turns from phase 0. At the start of the second turn,
the activation stage sets override bit 7, loads graphics and requests object
palette upload. Its later calls skip the load while phase is nonzero. The
final stage clears clipping and requests the next opcode while keeping the
override and timer active.

The corrected HRAM names `hPlayerSpriteGfxIdLo/Hi` ($FF94/$FF95) describe the
table ID. Override byte $FF93 bit 0 selects monster graphics (0) or field
graphics (1); bit 7 activates override rendering and the countdown. The loader
uses the full word: monster entries contain a pointer and bank, while field
entries contain a pointer and use bank $7D/$7E according to the low ID byte.
Player graphics load at $8000 and their CGB palette uses object slot 0.
The general loader can load other destinations/slots and does not request an
upload itself. Clearing override chooses default field graphics 0/1 from
story flag 0 and updates the default variant; override loads preserve that
variant. The restore command keeps the ID/timer bytes but disables their use.

The renderer uses the field ID low byte directly, or the monster low seven
bits with descriptor bank $25/$26/$27 selected from the ID high byte and low
bit 7. It adds wrapped player X+8/Y+16 to the stored scroll words. Carry from
the initial byte bias is discarded; carry from adding scroll low propagates
to its high byte. Mode 2 subtracts eight from the resulting Y origin. This
supersedes the older “minus scroll” explanation with the observed arithmetic.
The rendering probe stops at the descriptor-drawing callee to check routing
and computed inputs; it does not certify the final OAM picture.

`UseSpecialSpritePoseAtPosition` ($04:$4E0F) controls another renderer input.
During a fade it returns 1 only on map $5A screen (0,0) with player Y=$80.
Without a fade it searches the nine six-byte `SpecialSpritePoseRegions`
records: map, screen X/Y, exact pixel X and inclusive minimum/maximum pixel Y.
A match selects pose value 2 before the animation bit is added to the frame.
Thus the earlier fade-only helper name and explanation were incomplete.
All nine region boundaries are probed; the table has a final $FF byte.

The countdown runs only while override bit 7 is set and `wScriptRunning=0`.
It decrements the 16-bit timer and tests the updated sign bit. Starting at 100,
the 100th eligible call reaches zero without dispatch; the 101st reaches $FFFF
and starts talk group $0A index 0. That event supplies the three-stage restore
command, whose message group is already set by its caller. The countdown body
does not clear override or reset the timer itself.

The warp's shared lift subtracts four from player Y each call except at exact
$E0. Facing comes from `(incoming phase>>1)&3` when player Y moves. Follower
1/2/3 begin at incoming phases 8/16/24 and copy player facing when moved.
Each follower has its own exact-$E0 sentinel; Y=$E1 still subtracts to $DD.
It ignores party count, targets and delay. At updated phase 90, reset phase,
clear player flag bits 3/6 and advance. All coordinate arithmetic wraps.

Normal-map destination selection walks sixteen five-byte records in
`MapExitWarpTable`: matching map, new map, saved-goal key selector, packed pixel
position and packed screen. It writes the new map before choosing table
destination or saved goal. An active key with `(key-1) modulo 256` equal to
record byte 2 selects `wKeyWorldGoal` instead. A table miss requests the next
opcode but leaves destination and transition untouched. With map-type bit 7,
an active key whose bit 7 is set and low seven bits match the slot uses that
packed saved goal; otherwise use the two direct goal-position bytes and packed
goal screen. Those paths preserve the map ID and warp-facing byte.

Packed pixel coordinates decode high/low nibbles into multiples of 16;
screen coordinates decode high/low nibbles into 0–15. The common transition
sets step $80/kind 1, starts fade 4, increments field-init stage, selects mode
substate 4, clears player flag bits 3/7 and sets bit 5. It does not update warp
facing, phase or script stage. Direct probes do not establish destination
validity, complete map loading, natural scene entry or hardware timing.

Reproduce the 17 probes with
`python -I -m unittest discover -s tests -p test_sprite_warp_commands.py -v`.
They execute supplied reference bytes in the project's unvalidated emulator
with interrupts disabled and WRAM bank 1. Regenerate using
`python -I tools/disasm_all.py`, then run a clean full-ROM identity gate with
`python -I tools/build.py --out build/runN`. Semantic confidence and byte
identity remain separate under the [evidence standard](EVIDENCE_LOG.md).
