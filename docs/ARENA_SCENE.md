# Reading the arena scene

`ArenaRounds` and `ArenaGridBattle` in `src/engine/bank12_field_objects.asm`
share the entrance, battle approach, opponent arrival and cleanup. The first
has 26 dispatch entries, the second 27. These are **C1 readings, E-0359**,
supported by direct original-ROM probes in the project's emulator. This work
does not establish a full arena playthrough or hardware timing.

| Part | ArenaRounds step | ArenaGridBattle step | What selects the next part |
| --- | --- | --- | --- |
| Enter map $0B and show the opening | 0 | 0–1 | Fade starts, then message becomes idle |
| Prepare the entry line and walk into the ring | 1–2 | 2–3 | Five coordinate-equality checks |
| First announcement and battle approach | 3–4 | 4–5 | Message idle, then sixteen approach calls |
| Prepare the next opposing side | 5–9 | 6–10 | Message idle, object arrival and movement |
| Second announcement and battle approach | 10–12 | 11–13 | Same shared message/approach stages |
| Prepare the next opposing side | 13–17 | 14–18 | Same shared object stages |
| Third announcement and battle approach | 18–20 | 19–21 | Same shared message/approach stages |
| Closing message and exit delay | 21–23 | 22–24 | Message idle, then sixty delay calls |
| Heal, leave for map $04 and restore caller script | 24–25 | 25–26 | Fade starts, then script state is restored |

The first command's stages 5 and 13 have an additional branch: decrement
`wRecordCapacity`, and if the result is exactly 2 select the closing message
and stage 22. The other branch continues through the next opponent entrance.
Both branches still advance the round counter and prepare foes. These routines
do not inspect a battle-result flag themselves; a win/loss interpretation needs
the surrounding menu and battle-return flow. (**C1, E-0359**)

Several RAM names describe their usual use. Here `wRecordCapacity` is an arena
counter, and `wMessageIndex` becomes a timer after a message finishes. The shared
wait clears that message byte before the object animation. The grid command
also saves `wFieldEventKind` in `wScriptParam1`, disables the field event during
the entry walk and restores it at the final coordinate. (**C1, E-0359**)

The player route is down to Y=$20, left to X=$30, down to Y=$40, left to X=$20,
then up to Y=$30. The first four legs call the follower updater; the last leg
only moves the player. At the end the party faces right and the first battle
announcement starts. Each leg checks equality after changing the byte; these
are neither clamps nor distance calculations. (**C1, E-0359**)

The four arena object slots enter along a second route: increment Y through
off-screen byte wrap to $20, increment X to $60, increment Y to $40, then
increment X toward $70. All four slots update even while the display count is
only one. The timer raises that count to 2, 3 and 4 at $10, $20 and $30, then
holds at $60. An `inc [hl]` on `wScriptStep` sits **inside** the object loop,
so every object reaching X=$70 can advance the script in the same call. One
arrival advances once; four simultaneous arrivals advance four times in the
probe. Normal scene reachability of that simultaneous setup is unestablished.
(**C1, E-0359**)

`StartArenaRankMessage` looks up a byte in a table stored as words. For columns
0–7 and ranks 0–4, the pointer is the table base plus twice the column plus
sixteen times the rank; flag bit 7 selects row 5 instead. Only the low byte is
passed to `StartMessageA`. The current group, including its window flags, stays
in `wMessageGroup`; the stored high byte does not select that group. Row 5's
first two words are $FFFF and still produce index $FF. Invalid indexes have no
guard: `sla a` wraps at eight bits, while `swap a` exchanges nibbles rather than
multiplying every possible rank by sixteen. (**C1, E-0359**)

Random rounds use an encounter-word list selected by `wAreaGraphicsIndex`.
The builder fills three individual words for each remaining round, preserves
earlier round words, and counts selected list indexes in `wArenaList`. No index
is used more than three times within one rebuild. It consumes the quotient in
L returned by `RandomModulo52`, not that routine's remainder in A. The grid
command instead selects one already-defined three-word encounter, using the
fixed list for rank 0 or `GridEncounterTable` for other ranks. These values are
MonsterTable encounter ids, rather than the species ids used by `MONSTER_*`.
(**C1, E-0359; table structure E-0183, E-0236**)

The exit heal follows the record indexes in `wPartyList`, copies maximum HP/MP
to current HP/MP and clears the whole status byte. It enables and later disables
cartridge RAM, but does not select its bank. The caller must supply the bank
containing those records, normally 0, and a nonzero party count. (**C1, E-0359**)

Reproduce the eight boundary probes with:

```text
python -I -m unittest discover -s tests -p test_arena_scene.py -v
```

The probes cover the message table, byte overflow, route transitions, simultaneous
object arrivals, counter branches, remaining-round writes and SRAM-bank use.
See [E-0359](EVIDENCE_LOG.md#e-0359--arena-scene-stages-and-their-shared-data) for
the target identity, ranges, review and binary verification.
