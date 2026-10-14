# Reading the scripted player and follower paths

These two commands animate a departure and entry with the player and up to three
followers. Their stage names and explanations come from a full static reading
and direct routine probes (**C1, E-0358**), not a newly observed scene in play.
The source is `src/engine/bank12_field_objects.asm`; the annotated addresses are
in `build/listing/bank12.asm`.

`ObjectPath1B` and `ObjectPath1C` load `wScriptStep` and use `jumptable` to select
one of twelve stages. A stage returns after one update; it changes the step only
when its movement or wait is complete. An increment of the step selects the next
table entry on the next call. A jump to `AdvanceObjectPathHopPhase` shares the
end of a stage, rather than starting another independent command. (**C1, E-0358**)

| Step | ObjectPath1B | ObjectPath1C |
| --- | --- | --- |
| 0 | Hop the player while decreasing Y | Hop the player while increasing X |
| 1 | Hop follower 1, with the player decreasing Y | Hop follower 1, with the player increasing Y |
| 2 | Hop follower 2, with the player decreasing Y | Hop follower 2, with the player increasing Y |
| 3 | Hop follower 3 while the party decreases Y | Hop follower 3 while increasing its X and the other Y bytes |
| 4 | Decrease party Y until follower 3 reaches $F0; fade to map $1A | Increase party Y until follower 3 reaches $B0; fade to map $00 |
| 5 | Set followers' Y to $C0, $D0, $E0 | Set followers' Y to $E0, $D0, $C0 |
| 6 | Walk player Y to $50, updating followers | Walk player and follower Y to player Y $20 |
| 7 | Hop player left; decrease follower Y | Hop player and followers down |
| 8 | Hop follower 1 left; decrease trailing follower Y | Hop follower 1 down; increase trailing follower Y |
| 9 | Hop follower 2 left; decrease follower 3 Y | Hop follower 2 down; increase follower 3 Y |
| 10 | Hop follower 3 left | Hop follower 3 down |
| 11 | Clear the player's moving bit and finish | Same shared finish |

This table describes the stores, not an idealized path. In particular, 1B's
leftward stages decrease trailing followers' **Y**, while the active mover's
**X** decreases. Facing does not establish which coordinate a stage changes.
Stages 8 and 9 skip to step 11 only on hop completion with exactly one or two
party members respectively. (**C1, E-0358**)

The hop helper takes `DE`, a pair of eight-bit registers holding the address of
one coordinate byte. It stores that pointer, then calls the curve reader in
bank $5F. Both banks occupy the CPU's $4000–$7FFF window, so the far-call helper
temporarily selects $5F and restores $12 before the caller continues. The
address alone would not identify which ROM bytes to execute. The routine probes
check that bank $12 is restored. (**C1, E-0358; bank mechanism E-0007**)

The curve reader divides `wScriptParam0` by two with `srl a`, a logical right
shift, and adds that table entry to the coordinate. The byte values $FE/$FF are
-2/-1 under eight-bit wrapping addition. Starting from phase 0, the sixteen
deltas sum to zero: the curve rises six pixels and returns to its starting Y.
A stage may also add or subtract one from a coordinate each call, so the entire
stage can have a net displacement even though its curve does not.
(**C1, E-0358**)

Two `inc a` instructions advance the phase by **two**. `cp $20` followed by
`ret nz` means “continue only on exact equality with $20.” From phase 0 that
takes sixteen calls. An odd phase never reaches that equality; the shared phase
tail cycles through odd byte values. The curve reader has no bounds check, so
arbitrary starting phases can also index beyond its sixteen-byte table. This
is a precondition of the reading, not evidence that normal gameplay supplies
an invalid phase. (**C1, E-0358**)

Reproduce the five boundary probes with:

```text
python -I -m unittest discover -s tests -p test_object_paths.py
```

They execute the original reference bytes in the project's own emulator. They
do not establish display timing, hardware behavior, or the natural scene that
reaches either command. Full source regeneration and byte identity remain
separate checks; see [E-0358](EVIDENCE_LOG.md#e-0358--scripted-player-and-follower-paths-read-through-their-transitions).
