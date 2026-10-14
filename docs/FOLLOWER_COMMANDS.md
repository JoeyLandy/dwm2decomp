# Follower movement and screen transition commands

This is a C1 reading for `dwm2-cobi-us-rev0`, reference SHA-256
`8e38a7420ef5239c7196aa4fd4b1499e65db2823e875bbf8241bb2199e766d4e`.
[E-0361](EVIDENCE_LOG.md#e-0361--follower-command-coordinates-and-completion)
records the evidence and limits. The core range is bank $12 CPU [$4E4B,$4FEA),
file offsets [$48E4B,$48FEA). The matching assembly is in
[bank12_field_objects.asm](../src/engine/bank12_field_objects.asm).
Names describe candidate behavior in this target; they do not establish a
particular story event or a hardware-verified playthrough.

Each command reads `wScriptStep` and executes `rst $00`. Here the restart
helper treats the words immediately following it as a table and selects the
word indexed by A. The selected word is a CPU address in the currently mapped
bank $12. `dw` emits each address as a little-endian two-byte word. These
dispatchers make no stage-index bounds check. (C1, E-0361; helper E-0007.)

The bank-$10 `ScriptCommand90` through `ScriptCommand94` wrappers at
[$4924,$4947) far-call these bank-$12 commands once per script update, then
return. Progress and completion live in RAM rather than a preserved register
result. (C1, E-0361.)

| Command / entry | Stage sequence, from step 0 |
| --- | --- |
| `FollowersStep14`, $4E4B | Begin down; walk to $80; finish when last Y matches |
| `WarpWithFollowers`, $4E55 | Begin down; walk to $80; start entry fade; stagger down to $50; finish when last Y matches |
| `PlayerAndFollowersStep`, $4ECE | Begin down; walk to $80; start next-screen action; wait for action; walk to $20; finish when last Y matches |
| `FollowersStep11`, $4EF9 | Begin down; walk to $60; finish when last Y matches |
| `FollowersStep10`, $4F1E | Begin down; walk to $80; start next-screen action; wait for action; walk to $50; finish when last Y matches |

All table sequences above are C1, E-0361. `FollowerScene_BeginDown` ($4FD7)
sets player facing 0, sets state bit 1, queues sound $65 and increments the
script step. The state bit freezes the animation counter according to its
consumer (earlier E-0132); this initialization does not set moving bit 2 or
initialize the follower targets. Other state bits survive. (C1, E-0361.)

The four ordinary walk stages call `UpdateFollowersOnStep_Bank12` with the
current player Y, increment that Y, call the helper again with the intermediate
Y, then increment Y once more. `cp` compares the resulting byte with the
stage's threshold; `ret nz` returns when they differ. Only equality advances
the stage. Addition wraps from $FF to $00 and preserves parity: an odd input
Y cannot reach one of these even thresholds without another writer. The
follower updates occur before each of the two player increments. (C1, E-0361.)

The follower helper ($12:$65FF) checks the incoming A with `and $0F`. At a
16-pixel boundary it calls `SetFollowerTargetsFromLeader` ($02:$5923), then it
always calls `StepFollowersTowardTargets` ($02:$5946). A decides whether targets
refresh; the helper does not assign A to player or follower coordinates.
The `farcall` macro supplies bank $02 and its address to the bank-switching
helper, which restores the caller's bank afterward. (C1, E-0361; E-0007.)

There are three five-byte records at `wFollowerRecords` ($C8EF), with byte
offsets direction 0, X 1, Y 2, target X 3 and target Y 4. Target capture assigns
player position to follower 1, follower 1 position to follower 2 and follower 2
position to follower 3. It captures current positions, without stepping them.
Stepping processes all three records, even with a smaller party count, and
returns immediately if `wFollowerDelay` is nonzero without decrementing it.
An X mismatch takes priority; Y is considered only when X already equals its
target. Unsigned comparisons select right/left (1/3) or down/up (0/2). The step
is one pixel, or four while field-action request bit 7 is set; no clamp
prevents overshoot or wrap. A matched record retains its direction.
(C1, E-0361; extends the partial reading E-0093.)

`FollowerScene_FinishWhenLastYMatches` ($4F2E) updates followers twice, then
reads the last party follower's Y for valid party counts 1-3. It requires only
equality with player Y. X and the earlier followers can still differ. On
equality it clears player state bit 1 and writes script request $80, without
incrementing the stage. FetchScriptCommand tests/clears request bit 7 and
fetches the next opcode; this request alone does not end the whole script.
A following $FF ends it, while a normal opcode starts the next command. The
probe contrasts those two cases through the real consumer. The byte offset calculation is
`2 + ((party_count - 1) * 5 modulo 256)` from the record-array base;
party count 0 underflows and reads beyond the three records. There is no
validation here. (C1, E-0361.)

`WarpWithFollowers_StartEntryFade` ($4EAD) publishes map 1, screen (1,0),
destination (current player X,$F0), and transition kind 0. Its bank-$5F fade
helper selects fade $0F/mode substate 4, resets the transition step and phase,
then increments the script step. Actual relocation belongs to the field
transition. The following stagger stage ($4E63) sets all follower directions
down and uses three unsigned upstream gates: follower 3 moves by two if
follower 2 Y is below $E0, follower 2 if follower 1 Y is below $E0, and
follower 1 if player Y is below $E0. Reading downstream first preserves the
incoming upstream coordinates for these tests. Player Y always adds two with
wrap; equality at $50 advances. This stage bypasses target stepping and does
not inspect party count. (C1, E-0361.)

`FollowerScene_StartNextScreenAction` ($4F8E) sets action request $80,
scroll direction 8, increments map-screen Y and sets player step bit 0. It
writes $FF80 into the little-endian vertical delta: interpreted as a signed
16-bit value, that is -128. The horizontal delta and other state bits are
preserved. It calls the ordinary movement and field-action dispatchers and
advances immediately. The subsequent wait ($4F77) calls both again and advances
only after action request bit 7 is clear. Its completion test does not directly
check the delta, player position or follower position. (C1, E-0361.)

Ten probes in [test_follower_commands.py](../tests/test_follower_commands.py)
execute supplied reference bytes with interrupts disabled and WRAM bank 1.
They check exact thresholds and wrap, intermediate-boundary target capture,
last-Y completion with contrasting X/other Ys, all stagger gates, target
snapshots, X priority, four-pixel overshoot, delay behavior, fade parameters and
the action wait. The setup probe stops on entry to `UpdatePlayerMovement` to
inspect its input; it does not certify that the complete screen action runs.
The project's emulator remains unvalidated against hardware. Full scene entry,
map-loading state, input/interrupt timing and invalid stage/party-count behavior
remain outside these probes. (C1, E-0361.)

Reproduce with `python -I -m unittest discover -s tests -p test_follower_commands.py -v`.
Regenerate using `python -I tools/disasm_all.py`, then run a fresh clean build
with `python -I tools/build.py --out build/runN`. Build identity and semantic
confidence are separate checks under the [evidence standard](EVIDENCE_LOG.md).
