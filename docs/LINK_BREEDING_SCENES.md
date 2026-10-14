# Reading the link and breeding presentations

Five commands in `src/engine/bank12_field_objects.asm` reuse the same movement
and message stages. The stages are now named `MonsterScene_*`, with separate
names for the returns and child display. These are **C1 readings, E-0360**,
with direct probes on the original ROM in the project's emulator. They describe
presentation and state changes, not newly verified link protocol or breeding
mechanics.

| Command | Dispatch entries | Distinct work and return |
| --- | --- | --- |
| LinkMessageEvent, $9F | 23 | Shared two-record presentation, then restore the saved link flag and request game mode 8 |
| NpcBreedWarp, $8F | 25 | Enter map $14, shared presentation, selector-based return fade, then restore caller as command $F4 |
| BreedChildScene, $8D | 28 | Shared parent presentation, child graphics/effect/message, then restore caller as command $ED |
| BreedChildSprite, $8C | 17 | Start with child graphics, use a shorter effect sequence, then share the child message and return |
| BreedFade, $8B | 25 | Shared presentation, palette fade, then wait for fade state 0 and restore caller as command $ED |

The shared sequence loads species words from `wRecordBufA/B` into objects 1/2
and decompresses their monster graphics to $8600/$8700. Slot 0 moves up until
its updated Y is $58. After separate sixty-call waits, each of the two monsters
is placed at Y=$40; object 1 slides left to X=$48 and object 2 right to X=$58.
Those slides change X only when the **updated** phase has its low two bits
clear: one pixel every four calls from phase 0. Other pauses use a thirty-call
equality counter. Coordinates and counters wrap as bytes. (**C1, E-0360**)

Slot 0 later moves down to Y=$C8, setting object 1 facing right and object 2
left. This shared stage writes both states even in the child-only variant.
The longer presentations request field command $0D on re-entering map $14,
then show message index $0E in the current group. No speaker or exact dialogue
is newly inferred from that index alone. (**C1, E-0360**)

`BreedChildScene` replaces object 1 with the child after the shared message;
`BreedChildSprite` loads it at the start. Both use `MON_SPECIES` from
`wChildRecord`, graphics slot $8600 and object palette slot 6. Field commands
$0D and $0E share the same effect-object placement at ($50,$3C) but select
different graphics records. The effect wait queues sound $74 on **incoming**
phase $C2, then increments toward exact $E0. Completion hides object 5 and
places object 1 at Y=$3C, facing down. From phase 0 it takes 224 calls.
(**C1, E-0360**)

The child message copies the species name from bank $08 into `wTextBuf2 + 1`.
Its lookup index is the species low byte and category is the high byte plus
two; the prefix at buffer byte 0 is preserved. A zero `MON_PLUS` selects
message $17 and returns early, leaving the number buffer and clipping parameter
alone. A nonzero value selects $18, writes quotient/remainder glyph values
from division by ten, saves clipping in `wScriptParam0` and clears clipping.
This is a one/two-glyph formatter: values above 99 do not become three decimal
digits. (**C1, E-0360**)

The following message wait always copies `wScriptParam0` back to clipping once
the box becomes idle. Only the nonzero-plus branch saved clipping there.
The probe with a deliberately stale parameter demonstrates that distinction;
it does not establish a clipping fault during ordinary gameplay.
(**C1, E-0360**)

The NPC return selector has ten map bytes and a separate screen-X decision.
Selectors 1,3,5,6,7 return to map $17 screen (0,0); the other selectors 0–9
return to map $04 screen (2,0). Destination is ($40,$40), and the return marks
the saved position valid. `SavePlayerPositionStateAndStep` saves thirteen
bytes: slot-0 state, player X/Y/facing and direction/X/Y for all three followers.
It skips follower targets and does not set the validity flag itself.
(**C1, E-0360**)

The field graphics table contains a pointer, a selector byte and a trailing
byte. Both readers return **byte 2** (the selector); the older byte-3 comment
was wrong. The general reader loads $8400 and object palette slot 4; the
scene-effect reader loads $8300 and slot 3. A direct probe distinguishes these
contracts in both DMG-style and CGB-style branches. The trailing byte is
preserved without a new meaning. (**C1, E-0360; refines E-0238**)

The link return also corrects an older RAM description: `wLinkSaveStateFlag`
is saved from `wSaveStateFlag` by the link setup code and copied **back** by
`LinkMessageEvent_FinishToMode8`. That finish routine reads the saved byte;
it does not set it or itself save to SRAM. (**C1, E-0360**)

Reproduce the ten boundary probes with:

```text
python -I -m unittest discover -s tests -p test_breeding_scene.py -v
```

No save state is required. See [E-0360](EVIDENCE_LOG.md#e-0360--link-and-breeding-presentation-stages)
for the target identity, exact ranges, inputs, contrasting cases and full-ROM
verification. Natural scene reachability and hardware timing remain outside
these direct-call experiments.
