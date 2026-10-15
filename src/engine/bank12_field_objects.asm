; ROM bank $12: field objects and paths, key-world field code, arena rounds
; The annotated listing of this bank is build/listing/bank12.asm.

SECTION "Bank 12", ROMX[$4000], BANK[$12]
    db $12

; Runs SCRIPT_COUNTDOWN_MESSAGE: open message $10 in the current message group, then run its box
; until idle and end the command. wScriptStep selects the two stages. (C1, E-0358)
CountdownMessage::
    ld a, [wScriptStep]
    jumptable
    dw CountdownMessage_Open
    dw CountdownMessage_Finish

; Opens message $10 in the group already in wMessageGroup and advances to the shared message-wait
; stage. It does not select a new group. (C2, E-0358; probed E-0376)
CountdownMessage_Open::
    ld a, $10
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs SCRIPT_ENCOUNTER_MESSAGE: open message $0F in the current message group, then share
; CountdownMessage's wait-and-finish stage. (C1, E-0358)
EncounterCounterMessage::
    ld a, [wScriptStep]
    jumptable
    dw EncounterCounterMessage_Open
    dw CountdownMessage_Finish

; Shared closing stage for CountdownMessage and EncounterCounterMessage. Runs the message box with
; freeze flag A = 0; returns while it is active, and ends the script command with
; wScriptStartRequest = $80 only when the runner returns carry (idle). (C1, E-0358)
CountdownMessage_Finish::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Opens message $0F without changing wMessageGroup, then advances to the shared message-wait stage.
; (C2, E-0358; probed E-0376)
EncounterCounterMessage_Open::
    ld a, $0f
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; Starts a random-battle transition on script step 0. wMapType bit 7 selects intro 1 instead of 0;
; after NextRandomSeed, bit 0 of wKeyRandomLo selects transition substep 0 or 2. Saves the field
; screen and enters mode 3, then advances the step. On a later call, ends this command with
; wScriptStartRequest = $80. (C1, E-0358)
RandomBattleEvent::
    ld a, [wScriptStep]
    or a
    jr z, .clear_battle_intro_kind
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_battle_intro_kind:
    xor a
    ld [wBattleIntroKind], a
    ld a, [wMapType]
    bit 7, a
    jr z, .call_next_random_seed
    ld a, $01
    ld [wBattleIntroKind], a

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $01
    sla a
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs SCRIPT_OBJECT_PATH_1C, a twelve-stage player-and-follower path. Hop the player and each
; follower in turn, leave for map $00 screen (0,2) at ($70,$F0), arrange the entry line, then hop
; them again and finish. wScriptStep selects the stage; hop stages assume wScriptParam0 starts at 0.
; (C1, E-0358)
ObjectPath1C::
    ld a, [wScriptStep]
    jumptable
    dw ObjectPath1C_HopPlayerRight
    dw ObjectPath1C_HopFirstFollower
    dw ObjectPath1C_HopSecondFollower
    dw ObjectPath1C_HopThirdFollowerRight
    dw ObjectPath1C_LeaveMap
    dw ObjectPath1C_PrepareEntryLine
    dw ObjectPath1C_WalkPartyToEntryY
    dw ObjectPath1C_HopPlayerDown
    dw ObjectPath1C_HopFirstFollowerDown
    dw ObjectPath1C_HopSecondFollowerDown
    dw ObjectPath1C_HopThirdFollowerDown
    dw FinishObjectPath

; Last entry hop: face follower 3 down, add one to its Y, then apply the hop curve to that same Y.
; The curve helper advances to FinishObjectPath after sixteen calls from phase 0. (C2, E-0358;
; probed E-0376)
ObjectPath1C_HopThirdFollowerDown::
    xor a
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $c]
    inc a
    ld [wFollowerRecords + $c], a
    ld de, wFollowerRecords + $c
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; Entry hop for follower 2: face it down, apply the curve to its Y and add one to that Y; follower 3
; also adds one to Y. Once the curve resets its phase, a two-monster party skips follower 3's hop
; and goes straight to FinishObjectPath. (C2, E-0358; probed E-0376)
ObjectPath1C_HopSecondFollowerDown::
    xor a
    ld [wFollowerRecords + $5], a
    ld de, wFollowerRecords + $7
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a
    ld hl, wFollowerRecords + $c
    inc [hl]
    ld a, [wScriptParam0]
    or a
    ret nz
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0b
    ld [wScriptStep], a
    ret

; Entry hop for follower 1: face it down, apply the curve to its Y and add one to that Y; followers
; 2 and 3 also add one to Y. On curve completion, a one-monster party skips the other followers'
; hops and finishes. (C2, E-0358; probed E-0376)
ObjectPath1C_HopFirstFollowerDown::
    xor a
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wFollowerRecords + $2]
    inc a
    ld [wFollowerRecords + $2], a
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $c
    inc [hl]
    ld a, [wScriptParam0]
    or a
    ret nz
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0b
    ld [wScriptStep], a
    ret

; Entry hop for the player: face down, apply the curve to hPlayerY, then increment the player's and
; all three followers' Y bytes. Only the curve helper advances the stage, after sixteen calls from
; phase 0. (C2, E-0358; probed E-0376)
ObjectPath1C_HopPlayerDown::
    xor a
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    call ScriptApplyStepDeltaAtDE_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ld hl, wFollowerRecords + $2
    inc [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $c
    inc [hl]
    ret

; Moves the player and all three followers one pixel down per call. Advances when the updated
; hPlayerY equals $20; this is an equality check on an eight-bit coordinate, not a clamp. (C2,
; E-0358; probed E-0376)
ObjectPath1C_WalkPartyToEntryY::
    ld hl, wFollowerRecords + $c
    inc [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $2
    inc [hl]
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $20
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; After the fade, face the player and all followers up and place the followers at Y = $E0, $D0, $C0.
; Set the player's moving bit and advance to walking the entry line; the player's coordinates come
; from the warp. (C2, E-0358; probed E-0376)
ObjectPath1C_PrepareEntryLine::
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $e0
    ld [wFollowerRecords + $2], a
    ld a, $d0
    ld [wFollowerRecords + $7], a
    ld a, $c0
    ld [wFollowerRecords + $c], a
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; Moves the player and all followers down one pixel, facing follower 3 up. When follower 3's updated
; Y equals $B0, request map $00 screen (0,2), destination ($70,$F0), transition kind 0, and start
; the fade that advances the script. Other Y values return without starting a warp. (C1, E-0358)
ObjectPath1C_LeaveMap::
    ld a, $02
    ld [wFollowerRecords + $a], a
    ld hl, hPlayerY
    inc [hl]
    ld hl, wFollowerRecords + $2
    inc [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld a, [wFollowerRecords + $c]
    inc a
    ld [wFollowerRecords + $c], a
    cp $b0
    ret nz
    ld a, $00
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $70
    ld [wWarpDestX], a
    ld a, $f0
    ld [wWarpDestY], a
    xor a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Outgoing follower-3 hop: face it right and increment its X while the curve changes its Y. The
; player and followers 1 and 2 increment Y; followers 1 and 2 face up. AdvanceObjectPathHopPhase
; supplies the shared sixteen-call stage timing. (C2, E-0358; probed E-0376)
ObjectPath1C_HopThirdFollowerRight::
    ld a, $01
    ld [wFollowerRecords + $a], a
    ld hl, hPlayerY
    inc [hl]
    ld hl, wFollowerRecords + $2
    inc [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld a, $02
    ld [wFollowerRecords], a
    ld a, $02
    ld [wFollowerRecords + $5], a
    ld hl, wFollowerRecords + $b
    inc [hl]
    ld de, wFollowerRecords + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jp AdvanceObjectPathHopPhase

; Outgoing follower-2 hop: update the follower chain from the player's pre-move Y, face follower 1
; up, increment the player's Y, and apply the curve to follower 2's Y. Finish through
; AdvanceObjectPathHopPhase. (C2, E-0358; probed E-0376)
ObjectPath1C_HopSecondFollower::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, hPlayerY
    inc [hl]
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jp AdvanceObjectPathHopPhase

; Outgoing follower-1 hop: update the follower chain using the player's pre-move Y, face the player
; up, increment hPlayerY, and apply the curve to follower 1's Y. Finish through
; AdvanceObjectPathHopPhase; facing and coordinate change are preserved as written. (C2, E-0358;
; probed E-0376)
ObjectPath1C_HopFirstFollower::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, $02
    ldh [hPlayerFacing], a
    ld hl, hPlayerY
    inc [hl]
    ld de, wFollowerRecords + $2
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jp AdvanceObjectPathHopPhase

; Begin the outgoing path by setting the player's moving bit. Update followers using the player's
; pre-move X, apply the hop curve to hPlayerY, increment hPlayerX, and use AdvanceObjectPathHopPhase
; to advance after sixteen calls from phase 0. (C2, E-0358; probed E-0376)
ObjectPath1C_HopPlayerRight::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank12
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, hPlayerX
    inc [hl]
    jp AdvanceObjectPathHopPhase

; Runs SCRIPT_OBJECT_PATH_1B, a twelve-stage player-and-follower path. Hop the outgoing chain, leave
; for map $1A screen (2,0) at ($60,$B0), arrange the entry line, walk to Y = $50, then hop left and
; finish. Several stages decrement follower Y rather than X; these stores are preserved, not
; inferred from their facing. (C1, E-0358)
ObjectPath1B::
    ld a, [wScriptStep]
    jumptable
    dw ObjectPath1B_HopPlayerUp
    dw ObjectPath1B_HopFirstFollowerUp
    dw ObjectPath1B_HopSecondFollowerUp
    dw ObjectPath1B_HopThirdFollowerUp
    dw ObjectPath1B_LeaveMap
    dw ObjectPath1B_PrepareEntryLine
    dw ObjectPath1B_WalkPartyToEntryY
    dw ObjectPath1B_HopPlayerLeft
    dw ObjectPath1B_HopFirstFollowerLeft
    dw ObjectPath1B_HopSecondFollowerLeft
    dw ObjectPath1B_HopThirdFollowerLeft
    dw FinishObjectPath

; Shared final stage of ObjectPath1B and ObjectPath1C: clear the player's moving bit and end the
; script command with wScriptStartRequest = $80. Leaves the hop phase and follower records as the
; preceding stage produced them. (C2, E-0358; probed E-0376)
FinishObjectPath::
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Last entry hop: face follower 3 left and decrement its X, while applying the curve to its Y. The
; curve helper advances to FinishObjectPath on completion. Follower 3's direct movement changes from
; the Y decrements in the preceding stages to an X decrement here. (C2, E-0358; probed E-0376)
ObjectPath1B_HopThirdFollowerLeft::
    ld a, $03
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $b]
    dec a
    ld [wFollowerRecords + $b], a
    ld de, wFollowerRecords + $c
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; Entry hop for follower 2: face it left, curve its Y and decrement its X, but decrement follower
; 3's Y. On curve completion, exactly two party members skip follower 3's hop and select
; FinishObjectPath; other counts retain the helper's next stage. (C2, E-0358; probed E-0376)
ObjectPath1B_HopSecondFollowerLeft::
    ld a, $03
    ld [wFollowerRecords + $5], a
    ld de, wFollowerRecords + $7
    call ScriptApplyStepDeltaAtDE_Bank12
    ld hl, wFollowerRecords + $6
    dec [hl]
    ld hl, wFollowerRecords + $c
    dec [hl]
    ld a, [wScriptParam0]
    or a
    ret nz
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0b
    ld [wScriptStep], a
    ret

; Entry hop for follower 1: face it left, curve its Y and decrement its X, but decrement followers 2
; and 3's Y. When the curve resets the phase, exactly one party member selects FinishObjectPath;
; otherwise continue with follower 2. (C2, E-0358; probed E-0376)
ObjectPath1B_HopFirstFollowerLeft::
    ld a, $03
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $c
    dec [hl]
    ld a, [wScriptParam0]
    or a
    ret nz
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0b
    ld [wScriptStep], a
    ret

; Entry hop for the player: face left, curve hPlayerY and decrement hPlayerX, but decrement all
; three followers' Y bytes. The curve helper advances after sixteen calls from phase 0; it does not
; move the followers' X bytes. (C2, E-0358; probed E-0376)
ObjectPath1B_HopPlayerLeft::
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    call ScriptApplyStepDeltaAtDE_Bank12
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $c
    dec [hl]
    ret

; DE points to an eight-bit coordinate. Store DE in wStepPtrLo/wStepPtrHi and far-call
; AddStepDeltaToPointedByte in bank $5F, which adds the curve entry for wScriptParam0 / 2 modulo
; 256. Advance the phase by two; only equality with $20 resets it and advances wScriptStep. Starting
; at phase 0 gives sixteen calls and zero net curve displacement; no bounds check protects other
; phases. (C2, E-0358; probed E-0376)
ScriptApplyStepDeltaAtDE_Bank12::
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Updates followers from the player's pre-move Y, then moves the player one pixel up. Advances only
; when the updated hPlayerY equals $50; the follower helper refreshes its targets at 16-pixel
; boundaries. (C2, E-0358; probed E-0376)
ObjectPath1B_WalkPartyToEntryY::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; After the fade, face the player and followers up and set follower Y to $C0, $D0, $E0. Set the
; player's moving bit and advance to the entry walk. The player's position is supplied by the
; preceding warp. (C2, E-0358; probed E-0376)
ObjectPath1B_PrepareEntryLine::
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $c0
    ld [wFollowerRecords + $2], a
    ld a, $d0
    ld [wFollowerRecords + $7], a
    ld a, $e0
    ld [wFollowerRecords + $c], a
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; Decrements the player's and all three followers' Y bytes. When follower 3's updated Y equals $F0,
; request map $1A screen (2,0) at ($60,$B0), transition kind 0, and start the fade that advances the
; script. Otherwise return and keep walking. (C1, E-0358)
ObjectPath1B_LeaveMap::
    ld hl, hPlayerY
    dec [hl]
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld a, [wFollowerRecords + $c]
    dec a
    ld [wFollowerRecords + $c], a
    cp $f0
    ret nz
    ld a, $1a
    ldh [hMapId], a
    ld a, $02
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wWarpDestX], a
    ld a, $b0
    ld [wWarpDestY], a
    xor a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Outgoing follower-3 hop: face it up and decrement the player's and all followers' Y bytes, then
; add the curve to follower 3's Y. Continue through AdvanceObjectPathHopPhase for stage timing. (C2,
; E-0358; probed E-0376)
ObjectPath1B_HopThirdFollowerUp::
    ld a, $02
    ld [wFollowerRecords + $a], a
    ld hl, hPlayerY
    dec [hl]
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $c
    dec [hl]
    ld de, wFollowerRecords + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jr AdvanceObjectPathHopPhase

; Outgoing follower-2 hop: update the follower chain from the player's pre-move Y, decrement
; hPlayerY, and curve follower 2's Y. AdvanceObjectPathHopPhase handles completion; this stage does
; not explicitly change facing. (C2, E-0358; probed E-0376)
ObjectPath1B_HopSecondFollowerUp::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    dec [hl]
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jr AdvanceObjectPathHopPhase

; Outgoing follower-1 hop: update the follower chain from the player's pre-move Y, decrement
; hPlayerY, and curve follower 1's Y. Continue through AdvanceObjectPathHopPhase, without explicitly
; changing facing. (C2, E-0358; probed E-0376)
ObjectPath1B_HopFirstFollowerUp::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    dec [hl]
    ld de, wFollowerRecords + $2
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jr AdvanceObjectPathHopPhase

; Begin the outgoing path by setting the player's moving bit. Update followers from the player's
; pre-move Y, apply the curve to hPlayerY and decrement that Y. Falls through to
; AdvanceObjectPathHopPhase, which advances after sixteen calls from phase 0. (C2, E-0358; probed
; E-0376)
ObjectPath1B_HopPlayerUp::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, hPlayerY
    dec [hl]

; Shared tail for the outgoing path hops: wScriptParam0 = (wScriptParam0 + 2) modulo 256. Only a
; result of $20 resets the phase and increments the eight-bit wScriptStep. From 0, completion takes
; sixteen calls; odd starting phases never satisfy the equality. The caller applies the curve before
; this tail. (C2, E-0358; probed E-0376)
AdvanceObjectPathHopPhase::
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs SCRIPT_ARENA_ROUNDS through 26 stages: enter map $0B, walk the party into position, approach
; for three battles, stage the next opposing side between battles, then heal and leave. Shared
; ArenaScene stages also serve ArenaGridBattle. Message choices come from ArenaRankMessageTable; the
; next-round branches use the reused arena counter wRecordCapacity, not a farm-capacity query. (C1,
; E-0359)
ArenaRounds::
    ld a, [wScriptStep]
    jumptable
    dw ArenaRounds_EnterArena
    dw ArenaRounds_PrepareEntryWalk
    dw ArenaScene_WalkPartyIntoRing
    dw ArenaScene_WaitMessage
    dw ArenaScene_ApproachForBattle
    dw ArenaRounds_AfterFirstBattle
    dw ArenaScene_WaitMessage
    dw ArenaScene_LoadOpposingSide
    dw ArenaScene_WalkArenaObjectsIn
    dw ArenaScene_ReleaseArenaObjects
    dw ArenaScene_OpenSecondBattleMessage
    dw ArenaScene_WaitMessage
    dw ArenaScene_ApproachForBattle
    dw ArenaRounds_AfterSecondBattle
    dw ArenaScene_WaitMessage
    dw ArenaScene_LoadOpposingSide
    dw ArenaScene_WalkArenaObjectsIn
    dw ArenaScene_ReleaseArenaObjects
    dw ArenaScene_OpenThirdBattleMessage
    dw ArenaScene_WaitMessage
    dw ArenaScene_ApproachForBattle
    dw ArenaRounds_CloseThirdBattle
    dw ArenaScene_WaitMessage
    dw ArenaScene_WaitBeforeExit
    dw ArenaScene_HealAndLeaveArena
    dw ArenaScene_RestoreCallerScript

; After the third battle, start column 7 of ArenaRankMessageTable, advance to its message wait, and
; decrement the eight-bit arena counter wRecordCapacity. Does not inspect a battle-result flag here.
; (C2, E-0359; probed E-0376)
ArenaRounds_CloseThirdBattle::
    ld a, $07
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ret

; Decrement the arena counter. If it becomes exactly 2, show closing column 7 and select stage 22;
; otherwise show column 5 and advance to stage 14. In both branches, increment wArenaRound, rebuild
; the remaining random foes and copy the current round into wEncounterMonsters, even when selecting
; the closing stage. (C2, E-0359; probed E-0376)
ArenaRounds_AfterSecondBattle::
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wRecordCapacity]
    cp $02
    jr nz, .call_start_arena_rank_message
    ld a, $07
    call StartArenaRankMessage
    ld a, $16
    ld [wScriptStep], a
    jr .call_inc_arena_round_and_copy_area_graphics

.call_start_arena_rank_message:
    ld a, $05
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]

.call_inc_arena_round_and_copy_area_graphics:
    farcall IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea
    farcall ArenaRounds_SetUpBattle
    ret

; Decrement the arena counter. A result of exactly 2 selects closing column 7 and stage 22; every
; other result selects column 3 and the next stage. Both paths still increment wArenaRound and
; prepare the remaining round list and current foes. This condition alone does not establish a win
; or loss. (C2, E-0359; probed E-0376)
ArenaRounds_AfterFirstBattle::
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wRecordCapacity]
    cp $02
    jr nz, .call_start_arena_rank_message
    ld a, $07
    call StartArenaRankMessage
    ld a, $16
    ld [wScriptStep], a
    jr .call_inc_arena_round_and_copy_area_graphics

.call_start_arena_rank_message:
    ld a, $03
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]

.call_inc_arena_round_and_copy_area_graphics:
    farcall IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea
    farcall ArenaRounds_SetUpBattle
    ret

; Hold field draw mask $0E while the opening message runs. Once idle, set the player moving and
; facing down at X = $40; put follower X at $40, first follower Y at 0 and followers 2/3 facing
; down. Increment wArenaFlags, reset the message byte for route timing, and advance to the shared
; entrance walk. The other coordinates and wScriptParam1 are left to the caller. (C1, E-0359)
ArenaRounds_PrepareEntryWalk::
    ld a, $0e
    ldh [hFieldDrawFlags], a
    xor a
    call RunMessageBoxThenContinue
    ret nc
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ld hl, wArenaFlags
    inc [hl]
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Request map $0B screen (0,0), destination ($E0,0), transition kind 0, and start the fade that
; advances the script. Open message index wAreaGraphicsIndex + 5 in the current group, wrapping as a
; byte, then set wArenaFlags = $80 to select the special message row and sprite-selection path. (C1,
; E-0359)
ArenaRounds_EnterArena::
    ld a, $0b
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $e0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, [wAreaGraphicsIndex]
    add $05
    call StartMessageA
    ld a, $80
    ld [wArenaFlags], a
    ret

; Runs SCRIPT_ARENA_GRID_BATTLE through 27 stages, sharing the party entrance, battle approach,
; opposing-side arrival and exit with ArenaRounds. It adds an opening follow-up message. Between
; battles it refreshes the grid selection; rank 0 uses the fixed encounter list, other ranks use
; GridEncounterTable. wScriptStep selects the stage. (C1, E-0359)
ArenaGridBattle::
    ld a, [wScriptStep]
    jumptable
    dw ArenaGridBattle_EnterArena
    dw ArenaGridBattle_OpenFollowup
    dw ArenaGridBattle_PrepareEntryWalk
    dw ArenaScene_WalkPartyIntoRing
    dw ArenaScene_WaitMessage
    dw ArenaScene_ApproachForBattle
    dw ArenaGridBattle_AfterFirstBattle
    dw ArenaScene_WaitMessage
    dw ArenaScene_LoadOpposingSide
    dw ArenaScene_WalkArenaObjectsIn
    dw ArenaScene_ReleaseArenaObjects
    dw ArenaScene_OpenSecondBattleMessage
    dw ArenaScene_WaitMessage
    dw ArenaScene_ApproachForBattle
    dw ArenaGridBattle_AfterSecondBattle
    dw ArenaScene_WaitMessage
    dw ArenaScene_LoadOpposingSide
    dw ArenaScene_WalkArenaObjectsIn
    dw ArenaScene_ReleaseArenaObjects
    dw ArenaScene_OpenThirdBattleMessage
    dw ArenaScene_WaitMessage
    dw ArenaScene_ApproachForBattle
    dw ArenaGridBattle_CloseThirdBattle
    dw ArenaScene_WaitMessage
    dw ArenaScene_WaitBeforeExit
    dw ArenaScene_HealAndLeaveArena
    dw ArenaScene_RestoreCallerScript

; After leaving the arena, restart map music, queue talk-event group $65 index 1, and restore
; wScriptReturnBank/Lo/Hi into the active script request and pointer. Select command $F7, mark the
; script as in the data bank, and restore sprite-window clip mode 2. This stage serves both arena
; commands. (C1, E-0359)
ArenaScene_RestoreCallerScript::
    farcall RestartMapMusic
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $65
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $f7
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; Heal the party through FullyHealParty, then request map $04 screen (1,0), destination ($40,$30),
; transition kind 3. Start the fade that advances to restoring the caller script. The heal helper
; uses the incoming SRAM bank and assumes a nonempty party. (C1, E-0359)
ArenaScene_HealAndLeaveArena::
    call FullyHealParty
    ld a, $04
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Shared exit delay: increment wScriptParam0 once per call, queue sound $6D only when it becomes 1,
; and wait for exact equality with $3C. At $3C reset the counter and advance the stage. A fresh
; counter of 0 takes sixty calls; larger starting values wrap instead of being clamped. (C2, E-0359;
; probed E-0376)
ArenaScene_WaitBeforeExit::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $01
    jr nz, .cp_3C
    ld a, $6d
    call QueueSoundEffect
    ret

.cp_3C:
    cp $3c
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; After the third grid battle, show message-table column 7, advance to the shared message wait and
; decrement the reused arena counter wRecordCapacity. No battle-result flag is tested in this stage.
; (C2, E-0359; probed E-0376)
ArenaGridBattle_CloseThirdBattle::
    ld a, $07
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ret

; Show column 6 of ArenaRankMessageTable in the current group and advance to the shared message wait
; before the third battle approach. Used by both arena commands. (C2, E-0359; probed E-0376)
ArenaScene_OpenThirdBattleMessage::
    ld a, $06
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ret

; Show column 5, advance the stage and decrement the arena counter;
; SetupScreenCountPlusOneFromRecordCapacity immediately increments it again and updates the grid
; column from wAreaGraphicsIndex. Prepare the next three foes from the fixed list for rank 0, or
; GridEncounterTable for other ranks. (C2, E-0359; probed E-0376)
ArenaGridBattle_AfterSecondBattle::
    ld a, $05
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wArenaRank]
    or a
    jr nz, .call_setup_screen_count_plus_one_from_record
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_SetUp
    ret

.call_setup_screen_count_plus_one_from_record:
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_SetUpFromGrid
    ret

; Show column 4 of ArenaRankMessageTable, then advance to the shared message wait before the second
; battle approach. Does not change the current message group. (C2, E-0359; probed E-0376)
ArenaScene_OpenSecondBattleMessage::
    ld a, $04
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ret

; Move arena object 0 upward one pixel, facing up, until its updated Y equals $30. Then face all
; four arena objects left, set field event kind 7, clear their moving bits, queue sound 0 and
; advance to the next battle announcement. Other Y values return without advancing. (C2, E-0359;
; probed E-0376)
ArenaScene_ReleaseArenaObjects::
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $c]
    dec a
    ld [wSpriteSlots + $c], a
    cp $30
    ret nz
    ld a, $07
    ld [wFieldEventKind], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank12
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank12
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank12
    ld hl, wObject3 + OBJ_FLAGS
    call ClearBit2AtHL_Bank12
    ld a, $00
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; Bring four arena objects into position, including slots not yet drawable. A timer borrowed from
; wMessageIndex reveals slot counts 2,3,4 at $10,$20,$30 and holds at $60. Each slot increments Y
; through byte wrap to $20, then X to $60, Y to $40 and X toward $70. Each slot whose updated X
; equals $70 increments wScriptStep separately; simultaneous arrivals can advance it multiple times
; in one call. (C2, E-0359; probed E-0376)
ArenaScene_WalkArenaObjectsIn::
    ld a, [wMessageIndex]
    cp $60
    jr z, .skip
    inc a
    ld [wMessageIndex], a
    cp $10
    jr nz, .cp_20
    ld a, $02
    ld [wSpriteSlotCount], a
    jr .skip

.cp_20:
    cp $20
    jr nz, .cp_30
    ld a, $03
    ld [wSpriteSlotCount], a
    jr .skip

.cp_30:
    cp $30
    jr nz, .skip
    ld a, $04
    ld [wSpriteSlotCount], a

.skip:
    ld hl, wSpriteSlots + $c
    ld b, $04

.loop:
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, .skip2
    cp $20
    jr nc, .next

.skip2:
    ld a, [hl]
    inc a
    ld [hl], a
    jp .restore

.next:
    dec hl
    ld a, [hl]
    cp $60
    jr nc, .next2
    ld a, [hl]
    inc a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $01
    jp .restore

.next2:
    inc hl
    ld a, [hl]
    cp $40
    jr nc, .next3
    ld a, [hl]
    inc a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $00
    jp .restore

.next3:
    dec hl
    ld a, [hl]
    inc a
    ld [hl], a
    push af
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $01
    pop af
    cp $70
    jr nz, .restore
    ld hl, wScriptStep
    inc [hl]

.restore:
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    ret

; Set up the next map-$0B objects and their graphics from wEncounterMonsters. Request object
; palettes, show one slot initially, mark all four arena objects moving, disable the field-event
; updater, queue sound $6D, reset the borrowed message timer and advance to their entrance
; animation. (C1, E-0359)
ArenaScene_LoadOpposingSide::
    farcall SetupMap0BMonsterObjects
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B12
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B12
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B12
    ld hl, wObject3 + OBJ_FLAGS
    call SetBit2AtHL_B12
    xor a
    ld [wFieldEventKind], a
    ld a, $6d
    call QueueSoundEffect
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Show column 3, advance, decrement the arena counter, and call the grid-selection helper that
; increments it back and sets wScreenCountPlusOne. Rank 0 selects the fixed encounter list; other
; ranks select GridEncounterTable using the refreshed wGridCursorX. Prepare the next three foes in
; either case. (C2, E-0359; probed E-0376)
ArenaGridBattle_AfterFirstBattle::
    ld a, $03
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wArenaRank]
    or a
    jr nz, .call_setup_screen_count_plus_one_from_record
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_SetUp
    ret

.call_setup_screen_count_plus_one_from_record:
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_SetUpFromGrid
    ret

; Move all three follower X bytes right and all three opposing monster X bytes left, one pixel per
; call. After sixteen calls from phase 0, reset the phase, advance the script, increment the arena
; counter, choose battle intro 4 and transition substep 1, and save the field screen while entering
; battle mode 3. (C1, E-0359)
ArenaScene_ApproachForBattle::
    ld hl, wFollowerRecords + $1
    inc [hl]
    ld hl, wFollowerRecords + $6
    inc [hl]
    ld hl, wFollowerRecords + $b
    inc [hl]
    ld hl, wObject1 + OBJ_X
    dec [hl]
    ld hl, wObject2 + OBJ_X
    dec [hl]
    ld hl, wObject3 + OBJ_X
    dec [hl]
    ld b, $10
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    inc [hl]
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ret

; Shared message wait used throughout both arena dispatch tables. Run the box with freeze flag 0;
; while active return without changing the step. On idle, clear wMessageIndex so it can serve as an
; animation timer, then advance the script stage. (C1, E-0359)
ArenaScene_WaitMessage::
    xor a
    call RunMessageBoxThenContinue
    ret nc
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Walk the player in five legs selected by wScriptParam0: Y to $20, X to $30, Y to $40, X to $20,
; then Y back to $30. Update followers during the first four legs, but not the final upward leg. A
; second timer in wMessageIndex changes field draw masks at $10,$20,$30 and holds at $60. At the
; final coordinate, stop the player, face the party right, show message column 2, restore
; wFieldEventKind from wScriptParam1, clear both parameters and advance. Values above phase 3 also
; use the final leg. (C2, E-0359; probed E-0376)
ArenaScene_WalkPartyIntoRing::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ld a, [wMessageIndex]
    cp $60
    jr z, .check_script_param0
    inc a
    ld [wMessageIndex], a
    cp $10
    jr nz, .cp_20
    ld a, $0c
    ldh [hFieldDrawFlags], a
    jr .check_script_param0

.cp_20:
    cp $20
    jr nz, .cp_30
    ld a, $08
    ldh [hFieldDrawFlags], a
    jr .check_script_param0

.cp_30:
    cp $30
    jr nz, .check_script_param0
    xor a
    ldh [hFieldDrawFlags], a

.check_script_param0:
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $20
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .skip2
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank12
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip2:
    dec a
    jr nz, .skip3
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    xor a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip3:
    dec a
    jr nz, .set_player_facing_to_02
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank12
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp $20
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_player_facing_to_02:
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp $30
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank12
    ld a, $01
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $02
    call StartArenaRankMessage
    ld a, [wScriptParam1]
    ld [wFieldEventKind], a
    ld a, $00
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    xor a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Wait for the follow-up message to become idle, then place the player/follower entry line at X =
; $40 and face the player and followers 2/3 down, with first follower Y = 0. Mark the player moving,
; queue sound $6D, save wFieldEventKind in wScriptParam1 and disable it during the route. Reset the
; borrowed message timer and advance. (C1, E-0359)
ArenaGridBattle_PrepareEntryWalk::
    xor a
    call RunMessageBoxThenContinue
    ret nc
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ld a, $6d
    call QueueSoundEffect
    ld a, [wFieldEventKind]
    ld [wScriptParam1], a
    xor a
    ld [wFieldEventKind], a
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; After the opening message becomes idle, show ArenaRankMessageTable column 1, set field draw mask
; $0E and advance to preparing the entry walk. Returns without these changes while the first box
; remains active. (C1, E-0359)
ArenaGridBattle_OpenFollowup::
    xor a
    call RunMessageBoxThenContinue
    ret nc
    ld a, $01
    call StartArenaRankMessage
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Request map $0B screen (0,0), destination ($E0,0), transition kind 0, and start the fade that
; advances the script. Show message-table column 0 using the incoming wArenaFlags, then clear
; wArenaFlags for subsequent stages; the flag is cleared after, not before, the opening lookup. (C1,
; E-0359)
ArenaGridBattle_EnterArena::
    ld a, $0b
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $e0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call StartArenaRankMessage
    xor a
    ld [wArenaFlags], a
    ret

; A selects one of eight message columns. For normal ranks 0-4, read the low byte at
; ArenaRankMessageTable + 16 * wArenaRank + 2 * A; wArenaFlags bit 7 forces row 5. Pass only that
; byte to StartMessageA, preserving the current message group and discarding the stored high byte.
; The actual arithmetic is eight-bit SLA on A and SWAP on rank with carries into the pointer; no
; index bounds check is performed. (C2, E-0359; probed E-0376)
StartArenaRankMessage::
    ld de, ArenaRankMessageTable
    sla a
    add e
    ld e, a
    jr nc, .check_arena_flags
    inc d

.check_arena_flags:
    ld a, [wArenaFlags]
    bit 7, a
    jr nz, .skip
    ld a, [wArenaRank]
    swap a
    add e
    ld e, a
    jr nc, .call_start_message_a
    inc d

.call_start_message_a:
    ld a, [de]
    call StartMessageA
    ret

.skip:
    ld a, $05
    swap a
    add e
    ld e, a
    jr nc, .call_start_message_a2
    inc d

.call_start_message_a2:
    ld a, [de]
    call StartMessageA
    ret

; six rows of eight stored message words; ranks 0-4 select their row, wArenaFlags bit 7 forces row
; 5. Columns 0/1 are opening/follow-up, 2/4/6 announce the three battles, 3/5 follow the first two
; battles, and 7 closes the sequence. StartArenaRankMessage uses only the low byte of each word and
; leaves wMessageGroup unchanged; stored high bytes and row-5 $FFFF words are preserved (E-0359,
; E-0237, C1)
; record: one row per arena rank
ArenaRankMessageTable::
    dw $0040, $008c, $0013, $0017, $0014, $0018, $0015, $001b ; id 0
    dw $0041, $008d, $0013, $0017, $0014, $0018, $0015, $001c ; id 1
    dw $0042, $008e, $0013, $0017, $0014, $0018, $0015, $001d ; id 2
    dw $0043, $008f, $0013, $0017, $0014, $0018, $0015, $001e ; id 3
    dw $0044, $0090, $0013, $0017, $0014, $0018, $0015, $001f ; id 4
    dw $ffff, $ffff, $0013, $0019, $0014, $001a, $0016, $0020 ; id 5

; Runs SCRIPT_LINK_MESSAGE through 23 stages, using the shared MonsterScene record graphics, timed
; movement and message sequence. Show the two buffered monsters, move them apart, leave and re-enter
; map $14 with field command $0D requested on initialization, show message $0E in the current group,
; then finish by restoring the saved link flag and requesting game mode 8. No serial exchange occurs
; in this dispatcher itself. (C1, E-0360)
LinkMessageEvent::
    ld a, [wScriptStep]
    jumptable
    dw MonsterScene_LoadBufferedGraphics
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_RevealFirst
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideFirstLeft
    dw MonsterScene_RevealSecond
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideSecondRight
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_ReenterWithEffect
    dw MonsterScene_OpenMessage
    dw MonsterScene_WaitMessage
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_Wait30Calls
    dw MonsterScene_HideEffectObject
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw LinkMessageEvent_FinishToMode8

; Finish the link presentation: copy wLinkSaveStateFlag into wSaveStateFlag, request game mode 8
; with substate 0 and mode-change request 1, and stop the script. This copies the saved flag back;
; it does not set wLinkSaveStateFlag or itself perform an SRAM save. (C2, E-0360; probed E-0376)
LinkMessageEvent_FinishToMode8::
    ld a, [wLinkSaveStateFlag]
    ld [wSaveStateFlag], a
    ld a, $08
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a
    ld [wScriptRunning], a
    ret

; Runs SCRIPT_NPC_BREED_WARP through 25 stages. Save/warp preparation is supplied by the caller;
; enter map $14 and use the shared MonsterScene two-record animation, then choose the return map
; from the ten-entry selector table, fade and resume the saved caller script with command $F4 and
; talk group $89 index 1. (C1, E-0360)
NpcBreedWarp::
    ld a, [wScriptStep]
    jumptable
    dw MonsterScene_EnterMap14
    dw MonsterScene_LoadBufferedGraphics
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_RevealFirst
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideFirstLeft
    dw MonsterScene_RevealSecond
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideSecondRight
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_ReenterWithEffect
    dw MonsterScene_OpenMessage
    dw MonsterScene_WaitMessage
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_Wait30Calls
    dw MonsterScene_HideEffectObject
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw NpcBreedWarp_StartReturnFade
    dw NpcBreedWarp_RestoreCallerScript

; Restore slot 0 state from wSavedPlayerState, queue talk group $89 index 1, restore the saved
; script request byte and pointer, select command $F4 and mark the script as using the data bank.
; Player/follower coordinates are restored by the field transition when wSavedPositionValid is set;
; this stage only restores the slot-state byte. (C2, E-0360; probed E-0376)
NpcBreedWarp_RestoreCallerScript::
    ld a, [wSavedPlayerState]
    ld [wSpriteSlots + $7], a
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $89
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $f4
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; Use wScreenTableIndex (valid 0-9) to choose NpcBreedReturnMapIds. Screen X is 0 for selectors
; 1,3,5,6,7 and 2 for the others; screen Y is 0 and destination is ($40,$40). Clear the draw mask,
; select transition kind 0 and start the fade/step helper, then mark the saved position valid. No
; selector bounds check is made. (C1, E-0360)
NpcBreedWarp_StartReturnFade::
    ld a, [wScreenTableIndex]
    ld hl, NpcBreedReturnMapIds
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, [wScreenTableIndex]
    cp $01
    jr z, .set_warp_dest_x_to_40
    cp $03
    jr z, .set_warp_dest_x_to_40
    cp $05
    jr z, .set_warp_dest_x_to_40
    cp $06
    jr z, .set_warp_dest_x_to_40
    cp $07
    jr z, .set_warp_dest_x_to_40
    ld a, $02
    ldh [hMapScreenX], a

.set_warp_dest_x_to_40:
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wSavedPositionValid], a
    ret

; Ten one-byte return-map ids indexed by wScreenTableIndex (0-9); NpcBreedWarp_StartReturnFade
; chooses screen X separately and performs no index bounds check. (C1, E-0360)
NpcBreedReturnMapIds::
    db $04, $17, $04, $17, $04, $17, $17, $17, $04, $04

; Runs SCRIPT_BREED_CHILD_SCENE through 28 stages. Start with the shared two-record presentation on
; map $14; after its first message, replace object 1 graphics with the child species, prepare and
; run the field effect, then show the child species name and optional breeding-plus digits. Finish
; by publishing map $0D and restoring the caller script as command $ED. (C1, E-0360)
BreedChildScene::
    ld a, [wScriptStep]
    jumptable
    dw MonsterScene_EnterMap14
    dw MonsterScene_LoadBufferedGraphics
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_RevealFirst
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideFirstLeft
    dw MonsterScene_RevealSecond
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideSecondRight
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_ReenterWithEffect
    dw MonsterScene_OpenMessage
    dw MonsterScene_WaitMessage
    dw BreedChildScene_LoadChildGraphics
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw BreedChildScene_StartEffect
    dw BreedChildScene_WaitEffect
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw BreedChildScene_OpenChildMessage
    dw BreedChildScene_WaitMessageAndRestoreClip
    dw BreedChildScene_RestoreCallerScript

; Replace object 1 species/sprite word with wChildRecord + MON_SPECIES. Load its monster graphics
; into VRAM $8600 with palette slot 6, then run field command $0D to prepare the shared effect
; object. Request object palettes and advance; object 2 retains its existing data. (C1, E-0360)
BreedChildScene_LoadChildGraphics::
    ld a, $0b
    ld hl, wChildRecord
    add_a_to_hl
    ld a, [hli]
    ld [wObject1 + OBJ_SPRITE_ID], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ldh [hTemp1], a
    xor a
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0d
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs SCRIPT_BREED_CHILD_SPRITE through 17 stages: enter map $14, load only the child into object
; 1, use shared slot-0 movement and timed waits, show the prepared effect object, then run the same
; effect wait, species/plus message and caller return as BreedChildScene. Shared movement still
; writes both object 1 and object 2 states. (C1, E-0360)
BreedChildSprite::
    ld a, [wScriptStep]
    jumptable
    dw MonsterScene_EnterMap14
    dw BreedChildSprite_LoadChildGraphics
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_Wait30Calls
    dw BreedChildSprite_ShowEffectObject
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw BreedChildScene_StartEffect
    dw BreedChildScene_WaitEffect
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw BreedChildScene_OpenChildMessage
    dw BreedChildScene_WaitMessageAndRestoreClip
    dw BreedChildScene_RestoreCallerScript

; Finish the child presentation by assigning map $0D screen (1,0) and player position ($40,$40)
; directly. Hide object 5, clear the slot count and field-event kind, restore clip mode 2, queue
; talk group $6A index 1 and restore the saved script request/pointer with command $ED and
; data-bank-script flag 1. This stage does not initiate a palette fade. (C2, E-0360; probed E-0376)
BreedChildScene_RestoreCallerScript::
    ld a, $0d
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ld a, $40
    ldh [hPlayerY], a
    xor a
    ld [wObject5], a
    xor a
    ld [wSpriteSlotCount], a
    xor a
    ld [wFieldEventKind], a
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $6a
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $ed
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; Run the child message with freeze flag 0 and wait for idle carry. On idle, advance the stage and
; copy wScriptParam0 into the clipping mode. The copy is unconditional: only the nonzero-plus branch
; of the preceding formatter saved clipping into that parameter. (C1, E-0360)
BreedChildScene_WaitMessageAndRestoreClip::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ldh [hSpriteWindowClipMode], a
    ret

; Advance the stage and copy the child species name from bank $08 to wTextBuf2 + 1, preserving byte
; 0: string index is species low byte, category is species high byte + 2 modulo 256. For MON_PLUS =
; 0, show message $17 and return without saving clipping or changing the number buffer. Otherwise
; divide the plus byte by ten, write optional quotient then remainder glyph values and terminator
; $F0, show message $18, save clipping in wScriptParam0 and clear it. Values above 99 are not
; expanded into three decimal digits. (C2, E-0360; probed E-0376)
BreedChildScene_OpenChildMessage::
    ld hl, wScriptStep
    inc [hl]
    ld hl, wChildRecord
    ld a, $0b
    add_a_to_hl
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hl]
    inc a
    inc a
    ld [wStringCategory], a
    ld de, wTextBuf2 + $1
    ld a, e
    ld [wStringDestLo], a
    ld a, d
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank08
    ld hl, wChildRecord
    ld a, $6d
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .call_divide_b_by_a
    ld a, $17
    call StartMessageA
    ret

.call_divide_b_by_a:
    ld b, a
    ld a, $0a
    call DivideBByA
    ld hl, wTextNumber
    push af
    ld a, b
    or a
    jr z, .restore
    ld [hli], a

.restore:
    pop af
    ld [hli], a
    ld [hl], $f0
    ld a, $18
    call StartMessageA
    ldh a, [hSpriteWindowClipMode]
    ld [wScriptParam0], a
    xor a
    ldh [hSpriteWindowClipMode], a
    ret

; Wait for the field effect using the shared byte counter: queue sound $74 when the incoming phase
; is $C2, then increment toward exact $E0. From phase 0 completion takes 224 calls. On completion
; reset the phase, hide object 5, face object 1 down at Y=$3C and advance the stage. This does not
; test whether the graphics animation has finished. (C2, E-0360; probed E-0376)
BreedChildScene_WaitEffect::
    ld a, [wScriptParam0]
    cp $c2
    jr nz, .call_step_script_param0_counter_bank12
    ld a, $74
    call QueueSoundEffect

.call_step_script_param0_counter_bank12:
    ld b, $e0
    call StepScriptParam0Counter_Bank12
    ret nc
    xor a
    ld [wObject5], a
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld a, $3c
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Run field command $0E, which shares the effect placement setter with $0D but selects a different
; graphics record. Advance the script stage; the following wait supplies the delay and sound cue.
; (C1, E-0360)
BreedChildScene_StartEffect::
    ld a, $0e
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Show the prepared script effect by setting object 5 byte 0 to $80, then advance. This stage uses
; the graphics/template prepared earlier; it does not load new graphics. (C2, E-0360; probed E-0376)
BreedChildSprite_ShowEffectObject::
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Clear clipping and enable the low four draw-mask bits. Copy the child species word to object 1,
; load its monster graphics at VRAM $8600/palette slot 6 and prepare field command $0D, then hide
; object 5 until its later show stage. Request object palettes, mark slot 0 moving and advance. (C1,
; E-0360)
BreedChildSprite_LoadChildGraphics::
    xor a
    ldh [hSpriteWindowClipMode], a
    ldh a, [hFieldDrawFlags]
    or $0f
    ldh [hFieldDrawFlags], a
    ld a, $0b
    ld hl, wChildRecord
    add_a_to_hl
    ld a, [hli]
    ld [wObject1 + OBJ_SPRITE_ID], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ldh [hTemp1], a
    xor a
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0d
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a
    ld [wObject5], a
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs SCRIPT_BREED_FADE through 25 stages. Enter map $14 and run the shared two-record MonsterScene
; sequence, then request map $0D screen (1,0) at ($40,$40) and start a palette fade. After the fade
; state reaches zero, resume the saved caller script with command $ED and talk group $6A index 1.
; (C1, E-0360)
BreedFade::
    ld a, [wScriptStep]
    jumptable
    dw MonsterScene_EnterMap14
    dw MonsterScene_LoadBufferedGraphics
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_RevealFirst
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideFirstLeft
    dw MonsterScene_RevealSecond
    dw MonsterScene_Wait30Calls
    dw MonsterScene_SlideSecondRight
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw MonsterScene_Wait30Calls
    dw MonsterScene_ReenterWithEffect
    dw MonsterScene_OpenMessage
    dw MonsterScene_WaitMessage
    dw MonsterScene_WalkSlot0Up
    dw MonsterScene_Wait30Calls
    dw MonsterScene_HideEffectObject
    dw MonsterScene_Wait30Calls
    dw MonsterScene_WalkSlot0Down
    dw MonsterScene_Wait30Calls
    dw BreedFade_StartReturnFade
    dw BreedFade_RestoreCallerWhenIdle

; Return while wFadeState is nonzero. Once it is exactly zero, queue talk group $6A index 1, restore
; the saved script request/pointer, select command $ED and mark the script as using the data bank.
; No stage increment is needed: the command itself is replaced. (C2, E-0360; probed E-0376)
BreedFade_RestoreCallerWhenIdle::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $6a
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $ed
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; Assign map $0D screen (1,0), destination ($40,$40), clear the draw mask and select transition kind
; 0. Start palette fade $0F, mark the saved position valid and advance to the fade wait. The
; duplicate write of screen X = 1 is retained. Unlike the general fade/step helper, this body does
; not reset wScriptParam0 or set wModeState = 4. (C1, E-0360)
BreedFade_StartReturnFade::
    ld a, $0d
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $00
    ld [wFieldTransitionKind], a
    ld a, $0f
    call StartPaletteFade
    ld a, $01
    ld [wSavedPositionValid], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Hide script object 5 by clearing its byte 0 and advance. Shared by the link, NPC breeding and
; breed-fade presentations; no palette or graphics load occurs here. (C2, E-0360; probed E-0376)
MonsterScene_HideEffectObject::
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Run the current message with freeze flag 0. Advance only on idle carry; while the box remains
; active, leave the script step unchanged. Used after the shared message $0E. (C1, E-0360)
MonsterScene_WaitMessage::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Show message index $0E in the group already selected by the caller, then advance to the shared
; message wait. Does not select a new message group. (C2, E-0360; probed E-0376)
MonsterScene_OpenMessage::
    ld a, $0e
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; Set wFieldInitFlag = $8D, requesting field command $0D on the next InitFieldScreen, then jump to
; MonsterScene_EnterMap14. The entry helper starts a fade and advances the script; the field
; initializer masks off bit 7 before dispatching the requested command. (C1, E-0360)
MonsterScene_ReenterWithEffect::
    ld a, $8d
    ld [wFieldInitFlag], a
    jp MonsterScene_EnterMap14

; Face slot 0 down, set its moving bit and increment its Y each call. Only updated Y=$C8 advances
; the stage and sets object 1 facing right and object 2 left. The writes to both object states also
; occur in the child-only variant. Coordinate addition wraps as a byte. (C2, E-0360; probed E-0376)
MonsterScene_WalkSlot0Down::
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B12
    ld a, [wSpriteSlots + $c]
    inc a
    ld [wSpriteSlots + $c], a
    cp $c8
    ret nz
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Face object 2 right and increment the phase byte every call. Move X right by one only when the
; updated phase low two bits are zero, one pixel every four calls from phase 0. At updated X=$58,
; face down, reset the phase and advance; other coordinates keep the current stage. (C2, E-0360;
; probed E-0376)
MonsterScene_SlideSecondRight::
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp $58
    ret nz
    xor a
    ld [wObject2 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Wait sixty calls from phase 0 using the equality-based counter. On completion, reset the phase,
; put object 2 at Y=$40 and advance. This stage does not change its X or explicitly change its
; facing. (C2, E-0360; probed E-0376)
MonsterScene_RevealSecond::
    ld b, $3c
    call StepScriptParam0Counter_Bank12
    ret nc
    ld a, $40
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Face object 1 left and increment the phase byte every call. On updated phases divisible by four,
; decrement its X. At updated X=$48, face down, reset the phase and advance; the counter and X both
; wrap as bytes without a clamp. (C2, E-0360; probed E-0376)
MonsterScene_SlideFirstLeft::
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $48
    ret nz
    xor a
    ld [wObject1 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Shared pause throughout these scene tables: increment the byte phase once per call and return
; until the result equals $1E. At equality reset the phase and advance the script. From phase 0 that
; is thirty calls; arbitrary larger phases wrap before completing. (C2, E-0360; probed E-0376)
MonsterScene_Wait30Calls::
    ld b, $1e
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Wait sixty calls from phase 0; on exact counter completion reset the phase, place object 1 at
; Y=$40 and advance. The scene supplies the object species and X coordinate separately. (C2, E-0360;
; probed E-0376)
MonsterScene_RevealFirst::
    ld b, $3c
    call StepScriptParam0Counter_Bank12
    ret nc
    ld a, $40
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Decrement slot 0 Y each call, including byte wrap. Only when the updated Y equals $58, clear its
; moving bit and advance. The same body is reused before and after the shared message. (C2, E-0360;
; probed E-0376)
MonsterScene_WalkSlot0Up::
    ld a, [wSpriteSlots + $c]
    dec a
    ld [wSpriteSlots + $c], a
    cp $58
    ret nz
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; Clear clipping and enable the low four draw-mask bits. Copy species words from wRecordBufA/B to
; objects 1/2; load their monster graphics at VRAM $8600/$8700 with palette slots 6/7. Request
; object palettes, mark slot 0 moving and advance. These buffers are parents in breeding and
; own/partner records in link presentation. (C1, E-0360)
MonsterScene_LoadBufferedGraphics::
    xor a
    ldh [hSpriteWindowClipMode], a
    ldh a, [hFieldDrawFlags]
    or $0f
    ldh [hFieldDrawFlags], a
    ld a, $0b
    ld hl, wRecordBufA
    add_a_to_hl
    ld a, [hli]
    ld [wObject1 + OBJ_SPRITE_ID], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject1 + OBJ_SPRITE_ID + 1], a
    ldh [hTemp1], a
    xor a
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0b
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hli]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    ldh [hTemp1], a
    xor a
    ldh [hTemp2], a
    ld a, $07
    ldh [hTemp3], a
    ld hl, vTiles0 + $700
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; Shared entry/re-entry helper: request map $14 screen (0,0), destination ($E0,0) and transition
; kind 0, then far-call ScriptStartFadeAndAdvanceStep. That helper starts fade $0F, sets mode
; substate 4, clears the transition step and phase, and advances the script. (C1, E-0360)
MonsterScene_EnterMap14::
    ld a, $14
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $e0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Snapshot thirteen bytes: slot 0 state, player X/Y/facing, then direction/X/Y from each of the
; three five-byte follower records. Skip the followers' target coordinates, and advance the
; eight-bit script step. Does not set wSavedPositionValid; the caller or return stage supplies that
; flag. (C2, E-0360; probed E-0376)
SavePlayerPositionStateAndStep::
    ld a, [wSpriteSlots + $7]
    ld [wSavedPlayerState], a
    ldh a, [hPlayerX]
    ld [wSavedPlayerState + $1], a
    ldh a, [hPlayerY]
    ld [wSavedPlayerState + $2], a
    ldh a, [hPlayerFacing]
    ld [wSavedPlayerState + $3], a
    ld a, [wFollowerRecords]
    ld [wSavedPlayerState + $4], a
    ld a, [wFollowerRecords + $1]
    ld [wSavedPlayerState + $5], a
    ld a, [wFollowerRecords + $2]
    ld [wSavedPlayerState + $6], a
    ld a, [wFollowerRecords + $5]
    ld [wSavedPlayerState + $7], a
    ld a, [wFollowerRecords + $6]
    ld [wSavedPlayerState + $8], a
    ld a, [wFollowerRecords + $7]
    ld [wSavedPlayerState + $9], a
    ld a, [wFollowerRecords + $a]
    ld [wSavedPlayerState + $a], a
    ld a, [wFollowerRecords + $b]
    ld [wSavedPlayerState + $b], a
    ld a, [wFollowerRecords + $c]
    ld [wSavedPlayerState + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

; SCRIPT_FOLLOWERS_STEP_14 has three stages: face down and freeze the player animation counter, move
; player Y down by two toward exact $80 while stepping followers twice, then wait for the last party
; follower Y to equal player Y and request fetching the next script command. The final wait does not
; test X or all follower records. The stage index is unchecked. (C2, E-0361; probed E-0376)
FollowersStep14::
    ld a, [wScriptStep]
    jumptable
    dw FollowerScene_BeginDown
    dw FollowerScene_WalkDownTo80
    dw FollowerScene_FinishWhenLastYMatches

; SCRIPT_WARP_WITH_FOLLOWERS has five stages: shared down-facing initialization, walk to Y=$80, fade
; toward map 1 screen (1,0) with destination (player X,$F0), stagger the three follower Ys while
; player Y wraps toward $50, then use the shared last-follower-Y completion wait. The dispatcher
; only selects a stage; map loading is performed by the field transition. (C1, E-0361)
WarpWithFollowers::
    ld a, [wScriptStep]
    jumptable
    dw FollowerScene_BeginDown
    dw FollowerScene_WalkDownTo80
    dw WarpWithFollowers_StartEntryFade
    dw WarpWithFollowers_StaggerDownTo50
    dw FollowerScene_FinishWhenLastYMatches

; Set player animation-freeze bit 1 and all three follower directions to down. In
; downstream-to-upstream order, add two to follower 3 Y only if follower 2 Y is unsigned below $E0,
; to follower 2 Y only if follower 1 Y is below $E0, and to follower 1 Y only if player Y is below
; $E0. Thus each gate reads the upstream coordinate before this call updates it. Always add two to
; player Y with byte wrap; advance only on updated Y=$50. This does not use follower targets or
; party count. (C2, E-0361; probed E-0376)
WarpWithFollowers_StaggerDownTo50::
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank12
    xor a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $7]
    cp $e0
    jr nc, .check_follower_records
    ld a, [wFollowerRecords + $c]
    inc a
    inc a
    ld [wFollowerRecords + $c], a

.check_follower_records:
    ld a, [wFollowerRecords + $2]
    cp $e0
    jr nc, .check_player_y
    ld a, [wFollowerRecords + $7]
    inc a
    inc a
    ld [wFollowerRecords + $7], a

.check_player_y:
    ldh a, [hPlayerY]
    cp $e0
    jr nc, .check_player_y2
    ld a, [wFollowerRecords + $2]
    inc a
    inc a
    ld [wFollowerRecords + $2], a

.check_player_y2:
    ldh a, [hPlayerY]
    inc a
    inc a
    ldh [hPlayerY], a
    cp $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Request map 1 screen (1,0), destination (current player X,$F0), transition kind 0. Far-call
; ScriptStartFadeAndAdvanceStep in bank $5F, which starts fade $0F, selects mode substate 4, clears
; transition step and phase, and advances the script. The banked-call helper restores bank $12 on
; return; this body does not directly move the player or followers. (C1, E-0361)
WarpWithFollowers_StartEntryFade::
    ld a, $01
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $f0
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; SCRIPT_PLAYER_AND_FOLLOWERS_STEP has six stages: shared initialization, walk down to Y=$80, start
; the next-screen field action with vertical delta $FF80, continue movement/action until request bit
; 7 clears, walk down to exact Y=$20, then wait for the last party follower Y and request the next
; script command. Stage 2 advances immediately after its first movement/action call; stage 3
; supplies the completion wait. (C1, E-0361)
PlayerAndFollowersStep::
    ld a, [wScriptStep]
    jumptable
    dw FollowerScene_BeginDown
    dw FollowerScene_WalkDownTo80
    dw FollowerScene_StartNextScreenAction
    dw FollowerScene_WaitScreenAction
    dw PlayerAndFollowersStep_WalkDownTo20
    dw FollowerScene_FinishWhenLastYMatches

; Step followers using the incoming player Y, increment player Y once, step followers again using
; that intermediate Y, then increment player Y once more. Advance only at updated Y=$20. Every
; addition is eight-bit and wraps; no clamp, facing change or target refresh occurs except through
; the shared follower helper at 16-pixel boundaries. (C2, E-0361; probed E-0376)
PlayerAndFollowersStep_WalkDownTo20::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $20
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; SCRIPT_FOLLOWERS_STEP_11 has three stages: shared down-facing initialization, walk player Y down
; by two toward exact $60 while stepping followers twice, then use the shared last-party-follower Y
; wait and request the next script command. Unlike the six-stage commands, this table does not start
; a next-screen field action. The index is unchecked. (C2, E-0361; probed E-0376)
FollowersStep11::
    ld a, [wScriptStep]
    jumptable
    dw FollowerScene_BeginDown
    dw FollowersStep11_WalkDownTo60
    dw FollowerScene_FinishWhenLastYMatches

; Step followers at the incoming player Y and again after incrementing Y once, then increment Y a
; second time. Advance only when the updated byte equals $60. The two increments wrap and preserve
; input parity, so odd Y cannot reach this even threshold without an intervening writer. (C2,
; E-0361; probed E-0376)
FollowersStep11_WalkDownTo60::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $60
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; SCRIPT_FOLLOWERS_STEP_10 uses the same first four stages as PlayerAndFollowersStep: initialize,
; walk to $80, start the next-screen field action and wait for its request bit 7 to clear. Its fifth
; stage walks down to $50 rather than $20; the sixth uses the shared last-party-follower Y
; completion wait. No bounds check is made on the stage index. (C1, E-0361)
FollowersStep10::
    ld a, [wScriptStep]
    jumptable
    dw FollowerScene_BeginDown
    dw FollowerScene_WalkDownTo80
    dw FollowerScene_StartNextScreenAction
    dw FollowerScene_WaitScreenAction
    dw FollowersStep10_WalkDownTo50
    dw FollowerScene_FinishWhenLastYMatches

; Step followers twice without changing player Y, then read Y at wFollowerRecords + 2 +
; ((wPartyCount - 1) * 5 modulo 256). For valid party counts 1-3 this is the last follower. Return
; unless that Y equals player Y; on equality clear player animation-freeze bit 1 and set
; wScriptStartRequest=$80. X, other followers, flags and targets are not completion conditions.
; Party count 0 underflows and is not checked. (C2, E-0361; probed E-0376)
FollowerScene_FinishWhenLastYMatches::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, [wPartyCount]
    dec a
    ld c, a
    sla a
    sla a
    add c
    ld hl, wFollowerRecords + $2
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ldh a, [hPlayerY]
    cp c
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step followers at the incoming player Y, increment Y, step followers at the intermediate Y and
; increment Y again. Advance only on updated Y=$50. Both Y increments wrap as bytes, and equality
; rather than a crossing/clamp determines completion. Party count does not limit the follower helper
; to fewer than three records. (C2, E-0361; probed E-0376)
FollowersStep10_WalkDownTo50::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Far-call UpdatePlayerMovement and then RunFieldActionRequestActionIfBit7 in bank $02. Advance the
; script only if request bit 7 is clear after both calls; otherwise return at the same stage. This
; checks the field-action lifetime rather than the remaining vertical delta or a follower
; coordinate. Both calls restore bank $12. (C1, E-0361)
FollowerScene_WaitScreenAction::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Set field-action request $80 and screen-scroll direction 8, increment map-screen Y with byte wrap,
; set player step-in-progress bit 0, and write vertical step delta $FF80 (little-endian signed
; -128). Far-call movement and action dispatch in bank $02, then advance the script unconditionally.
; Other player-state bits and the horizontal step delta are preserved; the following wait tests
; action completion. (C1, E-0361)
FollowerScene_StartNextScreenAction::
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $08
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    inc [hl]
    ldh a, [hPlayerStateFlags]
    or $01
    ldh [hPlayerStateFlags], a
    ld hl, -128
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; Step followers using player Y, increment player Y once, step followers again at the intermediate
; Y, then increment Y again. Advance only when updated Y=$80. Boundary-sensitive target capture can
; occur on either helper call, before that call moves the followers. The arithmetic wraps and does
; not clamp or change input parity. (C2, E-0361; probed E-0376)
FollowerScene_WalkDownTo80::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $80
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Face the player down (0), set hPlayerStateFlags bit 1, queue sound $65 and advance the script
; step. The bit freezes the player animation counter; this body does not set moving bit 2,
; initialize coordinates or follower targets, or clear other player-state bits. Script step
; increment wraps as a byte. (C2, E-0361; probed E-0376)
FollowerScene_BeginDown::
    xor a
    ldh [hPlayerFacing], a
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank12
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; SCRIPT_PLAYER_SPRITE_FLASH selects eight unchecked stages: save background palettes/queue sound,
; flash for thirty calls, choose a sprite-slot graphics id, turn once, activate/load the override
; while turning again, turn twice more, then clear clipping and request the next script command. The
; four turns each take three calls from phase 0; graphics load occurs at the start of the second
; turn, not at selection. The override timer is initialized to 100 and is decremented separately
; after the script stops running. (C1, E-0362)
PlayerSpriteFlash::
    ld a, [wScriptStep]
    jumptable
    dw PlayerSpriteFlash_SavePalettes
    dw PlayerSpriteFlash_FlashPalettes
    dw PlayerSpriteFlash_SelectSlotGraphics
    dw PlayerSpriteFlash_TurnAfterThreeCalls
    dw PlayerSpriteFlash_ActivateAndTurn
    dw PlayerSpriteFlash_TurnAfterThreeCalls
    dw PlayerSpriteFlash_TurnAfterThreeCalls
    dw PlayerSpriteFlash_ResumeScript

; Clear sprite-window clipping and set wScriptStartRequest=$80 to request fetching the next opcode.
; Leave override, graphics id, facing, timer and current stage unchanged. This request alone does
; not end the whole script; its next opcode decides that. (C2, E-0362; probed E-0376)
PlayerSpriteFlash_ResumeScript::
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Only when incoming phase is zero, set override bit 7, far-call LoadPlayerSpriteGraphics in bank
; $04 and request object-palette upload $7F. Then fall through to the three-call turn helper.
; Nonzero phases skip loading; an arbitrary phase that wraps to zero can cause a later reload.
; Preserve the other override bits, including bit 0 selecting monster versus field graphics. (C1,
; E-0362)
PlayerSpriteFlash_ActivateAndTurn::
    ld a, [wScriptParam0]
    or a
    jr nz, PlayerSpriteFlash_TurnAfterThreeCalls
    ldh a, [hPlayerSpriteOverride]
    or $80
    ldh [hPlayerSpriteOverride], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

; Increment the eight-bit phase and return unless the updated value equals 3. On equality, facing
; becomes (facing + 1) & 3, phase resets to 0 and the script stage increments. From phase 0 this
; takes three calls; larger phases wrap before equality. Shared by all four turn stages, including
; the activation stage fallthrough. (C2, E-0362; probed E-0376)
PlayerSpriteFlash_TurnAfterThreeCalls::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $03
    ret nz
    ldh a, [hPlayerFacing]
    inc a
    and $03
    ldh [hPlayerFacing], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Face down and rejection-sample NextRandomSeed high byte & 7 until the index is below the captured
; slot count and the slot X/Y are unsigned below $A0/$90. HL remains at slot byte 12 after reading
; Y, then subtracting $0B puts it at byte 1: copy bytes 1,2,3 to override kind and little-endian
; graphics id. Reject the exact copied triple (1,$5E,0); other kind values with the same id are
; accepted. Slot state byte 0 is not checked. Set timer=100, phase=0 and advance. Only slots 0-7 can
; be sampled; no retry limit exists if none is eligible. (C2, E-0362; probed E-0376)
PlayerSpriteFlash_SelectSlotGraphics::
    xor a
    ldh [hPlayerFacing], a
    ld a, [wSpriteSlotCount]
    ld c, a

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    cp c
    jr nc, .loop
    swap a
    ld hl, wSpriteSlots + $b
    add_a_to_hl
    ld a, [hli]
    cp $a0
    jr nc, .loop
    ld a, [hl]
    cp $90
    jr nc, .loop
    ld a, l
    sub $0b
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, [hli]
    ldh [hPlayerSpriteOverride], a
    ld a, [hli]
    ldh [hPlayerSpriteGfxIdLo], a
    ld a, [hl]
    ldh [hPlayerSpriteGfxIdHi], a
    ldh a, [hPlayerSpriteOverride]
    cp $01
    jr nz, .set_player_sprite_timer_lo_to_64
    ldh a, [hPlayerSpriteGfxIdLo]
    cp $5e
    jr nz, .set_player_sprite_timer_lo_to_64
    ldh a, [hPlayerSpriteGfxIdHi]
    or a
    jr z, .loop

.set_player_sprite_timer_lo_to_64:
    ld a, $64
    ldh [hPlayerSpriteTimerLo], a
    xor a
    ldh [hPlayerSpriteTimerHi], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Far-call ScriptStepFlashScreenNegative in bank $12 and return. The helper owns the phase counter,
; palette writes and stage advance; this wrapper adds no independent wait or state change. The
; banked-call convention is retained even though the callee is in this bank. (C2, E-0362; probed
; E-0376)
PlayerSpriteFlash_FlashPalettes::
    farcall ScriptStepFlashScreenNegative
    ret

; Queue sound $7A. On CGB copy all 64 background-palette bytes to wBGPaletteCopy; on DMG leave that
; copy untouched. Increment the script stage without clearing its phase or altering clipping. The
; following flash helper uses the saved copy and controls timing. (C2, E-0362; probed E-0376)
PlayerSpriteFlash_SavePalettes::
    ld a, $7a
    call QueueSoundEffect
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; SCRIPT_PLAYER_SPRITE_MESSAGE has three unchecked stages: open message $12 in the existing group,
; wait for idle carry, then clear the player override, reload default graphics and request the next
; script opcode. The group-$0A talk event is supplied by the override countdown path; this
; dispatcher itself does not decrement the timer or select a group. (C1, E-0362)
PlayerSpriteMessage::
    ld a, [wScriptStep]
    jumptable
    dw PlayerSpriteMessage_OpenMessage
    dw PlayerSpriteMessage_WaitMessage
    dw PlayerSpriteMessage_RestoreAndResume

; Clear the entire override byte, far-call LoadPlayerSpriteGraphics in bank $04 to select the
; default player variant from story flag 0, request object-palette upload $7F and set script fetch
; request $80. Keep the graphics-id and timer bytes unchanged; clearing override disables their use.
; Do not increment the current stage. (C1, E-0362)
PlayerSpriteMessage_RestoreAndResume::
    xor a
    ldh [hPlayerSpriteOverride], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Run the bank-$12 message helper with freeze flag 0. Return without advancing while idle carry is
; clear; on idle carry increment the eight-bit script stage. The override stays active until the
; following restore stage. (C1, E-0362)
PlayerSpriteMessage_WaitMessage::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Start message index $12 in the group already selected by the caller: StartMessageA writes the
; index and clears message state to 0. Increment the script stage, without loading graphics,
; clearing override or changing the message group. (C2, E-0362; probed E-0376)
PlayerSpriteMessage_OpenMessage::
    ld a, $12
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; SCRIPT_MAP_LINK_WARP has two unchecked stages: the shared timed player/follower lift, then a
; destination-selection stage that requests the next script command and starts a transition only if
; it finds a normal-map record or takes the key-world path. The normal-map sentinel case leaves the
; destination and transition state unchanged. (C1, E-0362)
MapLinkWarp::
    ld a, [wScriptStep]
    jumptable
    dw WarpScene_LiftPartyFor90Calls
    dw MapLinkWarp_SelectDestination

; Set script fetch request $80 first. If map-type bit 7 is set, jump to the key-world selector.
; Otherwise search five-byte MapExitWarpTable records by incoming map id until $FF; a miss returns
; C=0 without starting a fade. A match replaces map id with record byte 1, then uses packed
; destination bytes 3/4 unless a key world is active and (key byte - 1) modulo 256 equals record
; byte 2; that case uses wKeyWorldGoal instead. Matching the saved goal does not undo the
; destination-map write. (C1, E-0362)
MapLinkWarp_SelectDestination::
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wMapType]
    bit 7, a
    jp nz, MapLinkWarp_SelectKeyWorldGoal
    ldh a, [hMapId]
    ld c, a
    ld hl, MapExitWarpTable

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .skip2
    ld c, $00
    ret

.skip2:
    cp c
    jr z, .skip3
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.skip3:
    ld e, l
    ld d, h
    inc de
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [de]
    inc de
    ld b, a
    ld a, [wKeyWorldActive]
    or a
    jr z, .call_map_link_warp_decode_packed_destination
    ld a, [wKeyWorldKey]
    dec a
    cp b
    jr nz, .call_map_link_warp_decode_packed_destination
    ld de, wKeyWorldGoal

.call_map_link_warp_decode_packed_destination:
    call MapLinkWarp_DecodePackedDestination
    ret

; Sixteen five-byte normal-map link records and $FF sentinel. Byte 0 matches incoming map, byte 1
; becomes map id, byte 2 matches (active key - 1) modulo 256 to select saved goal bytes; bytes 3/4
; otherwise hold packed pixel position and screen nibbles. A miss requests the next script opcode
; but starts no transition. (C1, E-0362; earlier E-0238)
; record: map, new map, key; destination position and screen
MapExitWarpTable::
    db $20, $20, $00 ; id 0: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $2f, $20, $00 ; id 1: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $30, $30, $01 ; id 2: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $76 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $43, $30, $01 ; id 3: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $76 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $48, $48, $02 ; id 4: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $b4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $49, $48, $02 ; id 5: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $b4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $70, $70, $03 ; id 6: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $b4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $7a, $70, $03 ; id 7: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $b4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $a0, $a0, $04 ; id 8: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $10 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $a8, $a8, $05 ; id 9: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $aa, $a8, $05 ; id 10: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $b0, $b0, $06 ; id 11: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $01 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $b8, $b8, $07 ; id 12: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $44 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $c8, $c8, $08 ; id 13: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $01 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $d1, $d1, $09 ; id 14: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $da, $da, $0a ; id 15: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $ff ; end

; For an active key world with key bit 7 set and slot equal to key & $7F, decode the packed
; position/screen at wKeyWorldGoal. Otherwise copy the two direct goal-position bytes to warp X/Y
; and use the packed screen byte at wKeyWorldGoalScreen. Both paths start the common transition,
; preserve map id and warp facing, and make no destination validity check. (C1, E-0362)
MapLinkWarp_SelectKeyWorldGoal::
    ld a, [wKeyWorldActive]
    or a
    jr z, .read_key_world_goal_pos
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_pos
    and $7f
    ld c, a
    ld a, [wKeyWorldSlot]
    cp c
    jr nz, .read_key_world_goal_pos
    ld de, wKeyWorldGoal
    call MapLinkWarp_DecodePackedDestination
    ret

.read_key_world_goal_pos:
    ld a, [wKeyWorldGoalPos]
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoalPos2]
    ld [wWarpDestY], a
    ld de, wKeyWorldGoalScreen
    call MapLinkWarp_StartTransition
    ret

; DE points at a packed position byte: high nibble is pixel X, low nibble shifted left four is pixel
; Y. Write warp X/Y, increment DE and fall through to the packed-screen/transition helper. No
; coordinate bias is added; valid values are multiples of 16. (C1, E-0362)
MapLinkWarp_DecodePackedDestination::
    ld a, [de]
    and $f0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and $f0
    ld [wWarpDestY], a
    inc de

; Decode the byte at DE into screen X=high nibble and Y=low nibble, then increment DE. Set
; transition step $80/kind 1, start fade 4, increment the field-init stage and select mode substate
; 4. Clear player flag bits 3 and 7, set bit 5 and preserve the remaining bits. Do not write map id,
; warp facing, phase or script stage. (C1, E-0362)
MapLinkWarp_StartTransition::
    ld a, [de]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [de]
    and $0f
    inc de
    ldh [hMapScreenY], a
    ld a, $80
    ld [wFieldTransitionStep], a
    ld a, $01
    ld [wFieldTransitionKind], a
    ld a, $04
    call StartPaletteFade
    ld hl, wFieldInitStage
    inc [hl]
    ld a, $04
    ld [wModeState], a
    ldh a, [hPlayerStateFlags]
    and $f7
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerStateFlags]
    or $20
    and $7f
    ldh [hPlayerStateFlags], a
    ret

; Script command type 8A (SCRIPT_MAP_EXIT_WARP), run through ScriptCommand8A for Script_MapExitWarp,
; which Talk_MapExitWarp starts. wScriptStep picks two steps: 0 lifts the player and followers for
; 90 calls (WarpScene_LiftPartyFor90Calls); 1 (MapExitWarp_StartFade) requests the next script
; command and starts the fade to the destination taken from the key world floor or from
; MapExitDestinationTable. (C1, E-0376)
; implements script command type 8A (SCRIPT_MAP_EXIT_WARP): a key-world/field talk event (group $07,
; dispatched by RunFieldReturnPhase_RunReturnAction: fades, then sets the warp destination from the
; map exit records (E-0182), wMapType, the map size and the field transition); named from its
; trigger and calls
MapExitWarp::
    ld a, [wScriptStep]
    jumptable
    dw WarpScene_LiftPartyFor90Calls
    dw MapExitWarp_StartFade

; Map exit warp, step 1: resumes the script and starts a fade (transition kind 1, step $80). In a
; key world: the floor's screen from wKeyWorldFloorInfo (4 bytes a floor), position ($40, $40)
; facing down, the map size from the key world and map type $80. Otherwise the map's record in
; MapExitDestinationTable (7 bytes; the second destination when wLastWarpIndex is 2): map, screen
; and position; maps $52, $89 and $BB also clear hPlayerStateFlags bit 7. (C1, E-0357)
MapExitWarp_StartFade::
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerStateFlags]
    or $80
    and $df
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $80
    ld [wFieldTransitionStep], a
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    ld a, [wKeyWorldFloor]
    add a
    add a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    push af
    swap a
    and $0f
    ldh [hMapScreenX], a
    pop af
    and $0f
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    ld a, $80
    ld [wMapType], a
    ret

.read_map_id:
    ldh a, [hMapId]
    ld c, a
    ld hl, MapExitDestinationTable

.skip:
    ld a, [hl]
    cp c
    jr z, .check_last_warp_index
    ld a, $07
    add_a_to_hl
    jr .skip

.check_last_warp_index:
    ld a, [wLastWarpIndex]
    dec a
    dec a
    jr nz, .set_map_id
    inc hl
    inc hl
    inc hl

.set_map_id:
    inc hl
    ld a, [hli]
    ldh [hMapId], a
    ld a, [hl]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [hli]
    and $0f
    ldh [hMapScreenY], a
    ld a, [hl]
    and $f0
    ld [wWarpDestX], a
    ld a, [hl]
    and $0f
    swap a
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ldh a, [hMapId]
    cp $52
    jr z, .check_player_state_flags
    cp $89
    jr z, .check_player_state_flags
    cp $bb
    jr z, .check_player_state_flags
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $7f
    ldh [hPlayerStateFlags], a
    ret

; MapExitWarp_StartFade, for maps without bit 7 of wMapType, scans 7-byte records from $52AD for the
; one whose first byte equals hMapId (there is no terminator and no bounds check), skips three more
; bytes when wLastWarpIndex = 2, then loads hMapId, hMapScreenX/Y from the nibbles of the next byte
; and wWarpDestX/Y from the nibbles of the byte after (each nibble x16), clearing wWarpDestFacing;
; 87 records end at the routine at $550E, and every map id is unique (E-0182, C1)
; record: map id; exit A (map, screen XY nibbles, position XY nibbles); exit B (same, used when
; wLastWarpIndex = 2)
MapExitDestinationTable::
    db $2b, $2a, $00, $12, $24, $11, $25 ; id 0
    db $35, $30, $03, $44, $00, $00, $00 ; id 1
    db $38, $30, $53, $44, $00, $00, $00 ; id 2
    db $39, $30, $53, $44, $00, $00, $00 ; id 3
    db $3a, $30, $53, $44, $00, $00, $00 ; id 4
    db $3b, $30, $53, $44, $00, $00, $00 ; id 5
    db $3e, $30, $62, $44, $00, $00, $00 ; id 6
    db $3f, $30, $62, $44, $00, $00, $00 ; id 7
    db $40, $30, $62, $44, $00, $00, $00 ; id 8
    db $53, $52, $20, $41, $52, $00, $41 ; id 9
    db $54, $52, $20, $41, $52, $00, $41 ; id 10
    db $55, $52, $20, $41, $52, $00, $41 ; id 11
    db $56, $52, $20, $41, $52, $00, $41 ; id 12
    db $57, $52, $20, $41, $52, $00, $41 ; id 13
    db $5d, $48, $5a, $44, $00, $00, $00 ; id 14
    db $62, $48, $a5, $44, $00, $00, $00 ; id 15
    db $63, $48, $87, $44, $00, $00, $00 ; id 16
    db $64, $48, $87, $44, $00, $00, $00 ; id 17
    db $65, $48, $87, $44, $00, $00, $00 ; id 18
    db $66, $48, $87, $44, $00, $00, $00 ; id 19
    db $67, $48, $87, $44, $00, $00, $00 ; id 20
    db $73, $89, $01, $56, $00, $00, $00 ; id 21
    db $74, $89, $01, $56, $00, $00, $00 ; id 22
    db $75, $89, $01, $56, $00, $00, $00 ; id 23
    db $76, $89, $01, $56, $00, $00, $00 ; id 24
    db $81, $70, $5b, $44, $00, $00, $00 ; id 25
    db $82, $70, $5b, $44, $00, $00, $00 ; id 26
    db $83, $70, $5b, $44, $00, $00, $00 ; id 27
    db $84, $70, $5b, $44, $00, $00, $00 ; id 28
    db $85, $70, $1b, $44, $00, $00, $00 ; id 29
    db $86, $70, $1b, $44, $00, $00, $00 ; id 30
    db $87, $70, $1b, $44, $00, $00, $00 ; id 31
    db $88, $70, $1b, $44, $00, $00, $00 ; id 32
    db $8a, $70, $ba, $44, $00, $00, $00 ; id 33
    db $8b, $70, $ba, $44, $00, $00, $00 ; id 34
    db $8c, $70, $ba, $44, $00, $00, $00 ; id 35
    db $8d, $70, $ba, $44, $00, $00, $00 ; id 36
    db $8e, $70, $ba, $44, $00, $00, $00 ; id 37
    db $8f, $70, $ba, $44, $00, $00, $00 ; id 38
    db $90, $70, $ba, $44, $00, $00, $00 ; id 39
    db $91, $70, $ba, $44, $00, $00, $00 ; id 40
    db $93, $70, $41, $44, $00, $00, $00 ; id 41
    db $94, $70, $41, $44, $00, $00, $00 ; id 42
    db $95, $70, $41, $44, $00, $00, $00 ; id 43
    db $96, $70, $41, $44, $00, $00, $00 ; id 44
    db $97, $70, $41, $44, $00, $00, $00 ; id 45
    db $98, $70, $41, $44, $00, $00, $00 ; id 46
    db $99, $70, $41, $44, $00, $00, $00 ; id 47
    db $9a, $70, $41, $44, $00, $00, $00 ; id 48
    db $9b, $70, $41, $44, $00, $00, $00 ; id 49
    db $a1, $a0, $12, $44, $00, $00, $00 ; id 50
    db $a2, $a0, $12, $44, $00, $00, $00 ; id 51
    db $a3, $a0, $12, $44, $00, $00, $00 ; id 52
    db $ac, $a8, $51, $44, $00, $00, $00 ; id 53
    db $ad, $a8, $51, $44, $00, $00, $00 ; id 54
    db $ae, $a8, $51, $44, $00, $00, $00 ; id 55
    db $b3, $b1, $00, $13, $00, $00, $00 ; id 56
    db $b4, $b1, $00, $13, $00, $00, $00 ; id 57
    db $b5, $b1, $00, $13, $00, $00, $00 ; id 58
    db $b6, $b1, $00, $13, $00, $00, $00 ; id 59
    db $bb, $b8, $40, $44, $00, $00, $00 ; id 60
    db $bd, $bb, $00, $41, $00, $00, $00 ; id 61
    db $be, $bb, $00, $41, $00, $00, $00 ; id 62
    db $bf, $bb, $00, $41, $00, $00, $00 ; id 63
    db $c0, $bb, $00, $41, $00, $00, $00 ; id 64
    db $c1, $bb, $00, $41, $00, $00, $00 ; id 65
    db $c2, $bb, $00, $41, $00, $00, $00 ; id 66
    db $c3, $bb, $00, $41, $00, $00, $00 ; id 67
    db $c4, $bb, $00, $41, $00, $00, $00 ; id 68
    db $c9, $c8, $00, $44, $00, $00, $00 ; id 69
    db $ca, $c8, $00, $44, $00, $00, $00 ; id 70
    db $cb, $c8, $00, $44, $00, $00, $00 ; id 71
    db $cc, $c8, $00, $44, $00, $00, $00 ; id 72
    db $cd, $c8, $00, $44, $00, $00, $00 ; id 73
    db $ce, $c8, $00, $44, $00, $00, $00 ; id 74
    db $d2, $d1, $01, $44, $00, $00, $00 ; id 75
    db $d3, $d1, $01, $44, $00, $00, $00 ; id 76
    db $d4, $d1, $01, $44, $00, $00, $00 ; id 77
    db $d5, $d1, $01, $44, $00, $00, $00 ; id 78
    db $d6, $d1, $01, $44, $00, $00, $00 ; id 79
    db $d7, $d1, $01, $44, $00, $00, $00 ; id 80
    db $db, $da, $10, $44, $00, $00, $00 ; id 81
    db $dc, $da, $10, $44, $00, $00, $00 ; id 82
    db $dd, $da, $10, $44, $00, $00, $00 ; id 83
    db $de, $da, $10, $44, $00, $00, $00 ; id 84
    db $df, $da, $10, $44, $00, $00, $00 ; id 85
    db $e0, $da, $10, $44, $00, $00, $00 ; id 86

; Script command type 9B (SCRIPT_HEAL_PARTY), run through ScriptCommand9B for Script_HealParty,
; which Talk_HealParty starts. Seven steps by wScriptStep: turn the player
; (HealPartyEvent_FacePlayer), the greeting message, after the box closes save the palettes and play
; sound $7A, the negative screen flash (ScriptStepFlashScreenNegative), heal the party
; (HealPartyEvent_HealParty, which skips the next step when nobody had fallen), move the fallen
; members back, then wait for the box and request the next script command. (C1, E-0376)
; implements script command type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A,
; dispatched by WarpEffect: heals the party (FullyHealParty) after a flag-chosen message); named
; from its trigger and calls
HealPartyEvent::
    ld a, [wScriptStep]
    jumptable
    dw HealPartyEvent_FacePlayer
    dw HealPartyEvent_ShowGreeting
    dw HealPartyEvent_PlayHealSound
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_HealParty
    dw HealPartyEvent_MoveFallenBack
    dw HealPartyEvent_WaitAndResume

; Heal party event, step 0: the player faces left, or up after EVENT_THANKS_FOR_COMING_BY_025. (C2,
; E-0357; probed E-0376)
HealPartyEvent_FacePlayer::
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    ret nc
    ld a, $02
    ldh [hPlayerFacing], a
    ret

; Script command type 89 (SCRIPT_RETURN_WARP), run through ScriptCommand89 for Script_ReturnWarp,
; which Talk_ReturnWarp starts. Eight steps by wScriptStep: lift the party for 90 calls
; (WarpScene_LiftPartyFor90Calls), start the return warp (ReturnWarp_StartWarp:
; StartReturnWarpByFlag25 and wFieldTransitionStep = $80), then the greeting, palette save, flash,
; heal, move-back and resume steps of HealPartyEvent. (C1, E-0376)
; implements script command type 89 (SCRIPT_RETURN_WARP): a key-world/field talk event (group $06,
; dispatched by RunFieldReturnPhase_RunReturnAction: StartReturnWarpByFlag25); named from its
; trigger and calls
ReturnWarp::
    ld a, [wScriptStep]
    jumptable
    dw WarpScene_LiftPartyFor90Calls
    dw ReturnWarp_StartWarp
    dw HealPartyEvent_ShowGreeting
    dw HealPartyEvent_PlayHealSound
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_HealParty
    dw HealPartyEvent_MoveFallenBack
    dw HealPartyEvent_WaitAndResume

; Heal party event, step 1: message $15 after EVENT_SCENE_LIMBO_MONSTER2, otherwise $0D; object 0
; faces right, or after EVENT_THANKS_FOR_COMING_BY_025 object 1 faces down. (C2, E-0357; probed
; E-0376)
HealPartyEvent_ShowGreeting::
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_SCENE_LIMBO_MONSTER2
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $0d
    call StartMessageA
    jr .call_test_flag_bit

.call_start_message_a:
    ld a, $15
    call StartMessageA

.call_test_flag_bit:
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .clear_object1
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

.clear_object1:
    xor a
    ld [wObject1 + OBJ_STATE], a
    ret

; Return warp, step 1: starts the return warp (StartReturnWarpByFlag25) with transition step $80.
; (C1, E-0357)
ReturnWarp_StartWarp::
    call StartReturnWarpByFlag25
    ld a, $80
    ld [wFieldTransitionStep], a
    ret

; Each call subtracts four from player Y unless it equals $E0; when moved, facing=(incoming phase >>
; 1)&3. Starting at incoming phases 8,16,24, likewise subtract four from follower 1,2,3 Y unless
; that Y equals $E0, and copy player facing to each moved record. This bypasses targets, delay and
; party count. Increment phase using the exact-90 counter; on completion reset phase, clear player
; flag bits 3/6 and advance. Byte subtraction wraps: $E0 is an equality sentinel, not an unsigned
; cutoff or clamp. (C2, E-0362; probed E-0376)
WarpScene_LiftPartyFor90Calls::
    ldh a, [hPlayerY]
    cp $e0
    jr z, .check_script_param0
    sub $04
    ldh [hPlayerY], a
    ld a, [wScriptParam0]
    srl a
    and $03
    ldh [hPlayerFacing], a

.check_script_param0:
    ld a, [wScriptParam0]
    cp $08
    jr c, .check_script_param02
    ld a, [wFollowerRecords + $2]
    cp $e0
    jr z, .check_script_param02
    sub $04
    ld [wFollowerRecords + $2], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a

.check_script_param02:
    ld a, [wScriptParam0]
    cp $10
    jr c, .check_script_param03
    ld a, [wFollowerRecords + $7]
    cp $e0
    jr z, .check_script_param03
    sub $04
    ld [wFollowerRecords + $7], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords + $5], a

.check_script_param03:
    ld a, [wScriptParam0]
    cp $18
    jr c, .call_step_script_param0_counter_bank12
    ld a, [wFollowerRecords + $c]
    cp $e0
    jr z, .call_step_script_param0_counter_bank12
    sub $04
    ld [wFollowerRecords + $c], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords + $a], a

.call_step_script_param0_counter_bank12:
    ld b, $5a
    call StepScriptParam0Counter_Bank12
    ret nc
    ldh a, [hPlayerStateFlags]
    and $b7
    ldh [hPlayerStateFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 88 (SCRIPT_RETURN_MESSAGE), run through ScriptCommand88 for
; Script_ReturnMessage, which Talk_ReturnMessage starts. Six steps by wScriptStep: halve the gold
; and show a message chosen by story flags (ReturnMessage_SetGoldAndShow), then the palette save,
; flash, heal, move-back and resume steps of HealPartyEvent. (C1, E-0376)
; implements script command type 88 (SCRIPT_RETURN_MESSAGE): a key-world/field talk event (group
; $05, dispatched by RunFieldReturnPhase_AfterBattle and PartyDefeatedReturn: a message chosen by a
; story flag); named from its trigger and calls
ReturnMessage::
    ld a, [wScriptStep]
    jumptable
    dw ReturnMessage_SetGoldAndShow
    dw HealPartyEvent_PlayHealSound
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_HealParty
    dw HealPartyEvent_MoveFallenBack
    dw HealPartyEvent_WaitAndResume

; Starts the return warp; called by ReturnWarp_StartWarp and PartyDefeatedReturn_StartWarp. On a
; special map (wMapType bit 7) it first far-calls SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot.
; Sets the destination ($50, $30) with wWarpDestFacing = 0, wFieldTransitionKind = 3 when
; EVENT_THANKS_FOR_COMING_BY_025 is set or 4 when it is not, wReturnWarpFlag = 1, then far-calls
; ScriptStartFadeAndAdvanceStep (fade $0F, wModeState = 4, wFieldTransitionStep = 0, wScriptParam0 =
; 0, wScriptStep + 1). It does not set hMapId or the screen. (C2, E-0376)
; with bit 7 of wMapType saves the wKeyWorldFlags record; sets the position ($50, $30),
; wFieldTransitionKind = 3 (story flag $25) or 4, wReturnWarpFlag = 1 and starts the fade (E-0126)
StartReturnWarpByFlag25::
    ld a, [wMapType]
    bit 7, a
    jr z, .set_warp_dest_x_to_50
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

.set_warp_dest_x_to_50:
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .set_field_transition_kind_to_03
    ld a, $04
    ld [wFieldTransitionKind], a
    jr .set_return_warp_flag_to_01

.set_field_transition_kind_to_03:
    ld a, $03
    ld [wFieldTransitionKind], a

.set_return_warp_flag_to_01:
    ld a, $01
    ld [wReturnWarpFlag], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Return message, step 0: sets the gold (HalveGold); before EVENT_THANKS_FOR_COMING_BY_025 message
; $0C with object 0 facing right; after it object 1 faces down and message $14 (after
; EVENT_SCENE_LIMBO_MONSTER2) or $13. (C2, E-0357; probed E-0376)
ReturnMessage_SetGoldAndShow::
    ld hl, wScriptStep
    inc [hl]
    farcall HalveGold
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .clear_object1
    ld a, $0c
    call StartMessageA
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

.clear_object1:
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld de, EVENT_SCENE_LIMBO_MONSTER2
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $13
    call StartMessageA
    ret

.call_start_message_a:
    ld a, $14
    call StartMessageA
    ret

; Heal party event, step 2: after the box closes, saves the GBC background palettes and plays sound
; $7A. (C1, E-0357)
HealPartyEvent_PlayHealSound::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.skip:
    ld hl, wScriptStep
    inc [hl]
    ld a, $7a
    call QueueSoundEffect
    ret

; Heal party event, step 4: notes whether a party member has fallen (MON_STATUS bit 7) and fully
; heals the party; with none fallen shows message $16 (after EVENT_SCENE_LIMBO_MONSTER2) or $11 and
; skips step 5; otherwise hides the followers and goes to step 5. (C2, E-0357; probed E-0376)
HealPartyEvent_HealParty::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hli]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .set_script_param0_to_01
    dec b
    jr nz, .loop
    xor a
    ld [wScriptParam0], a
    jr .call_fully_heal_party

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a

.call_fully_heal_party:
    xor a
    ld [rRAMG], a
    call FullyHealParty
    ld a, [wScriptParam0]
    or a
    jr nz, .set_field_draw_flags_to_0E
    ld de, EVENT_SCENE_LIMBO_MONSTER2
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $11
    call StartMessageA
    jr .clear_script_param0

.call_start_message_a:
    ld a, $16
    call StartMessageA

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    ld a, [wScriptStep]
    inc a
    inc a
    ld [wScriptStep], a
    ret

.set_field_draw_flags_to_0E:
    ld a, $0e
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Heal party event, step 5: moves the fallen members to the back, reloads the names and sprites,
; shows the followers again and shows message $16 or $11. (C1, E-0357)
HealPartyEvent_MoveFallenBack::
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    xor a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_SCENE_LIMBO_MONSTER2
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $11
    call StartMessageA
    ret

.call_start_message_a:
    ld a, $16
    call StartMessageA
    ret

; Heal party event, step 6: waits for the message box to close, then resumes the script. (C1,
; E-0357)
HealPartyEvent_WaitAndResume::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command type 87 (SCRIPT_PARTY_DEFEATED_RETURN), run through ScriptCommand87 for
; Script_PartyDefeatedReturn, which Talk_PartyDefeatedReturn starts. Nine steps by wScriptStep:
; count the members marked in wStatusFieldStep, name each in turn (messages $0A and $0B), move the
; fallen members to the back, then, when every member has fallen (MON_STATUS bit 7), play music $42,
; wait $B4 calls, start the return warp (StartReturnWarpByFlag25) and dispatch talk event group 5
; index 0; when anyone still stands, step 5 requests the next script command instead. (C1, E-0376)
; implements script command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event
; (group $04, dispatched from FieldState_StepChecks: moves incapacitated members back
; (MoveIncapacitatedPartyMembersBack) and starts the return warp (StartReturnWarpByFlag25)); named
; from its trigger and calls
PartyDefeatedReturn::
    ld a, [wScriptStep]
    jumptable
    dw PartyDefeatedReturn_CountMarked
    dw PartyDefeatedReturn_ShowFallenName
    dw PartyDefeatedReturn_CheckMarkedMembers
    dw PartyDefeatedReturn_ShowNextFallenName
    dw PartyDefeatedReturn_MoveFallenBack
    dw PartyDefeatedReturn_CheckAllFallen
    dw PartyDefeatedReturn_Wait
    dw PartyDefeatedReturn_StartWarp
    dw PartyDefeatedReturn_ShowReturnMessage

; Party defeated return, step 8: starts talk event 0 of group 5 (the return message). (C1, E-0357)
PartyDefeatedReturn_ShowReturnMessage::
    ld a, $05
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; Party defeated return, step 7: starts the return warp (StartReturnWarpByFlag25), field return
; phase 0, transition step $80. (C1, E-0357)
PartyDefeatedReturn_StartWarp::
    call StartReturnWarpByFlag25
    xor a
    ld [wFieldReturnPhase], a
    ld a, $80
    ld [wFieldTransitionStep], a
    ret

; Party defeated return, step 6: waits $B4 frames. (C2, E-0357; probed E-0376)
PartyDefeatedReturn_Wait::
    ld b, $b4
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Party defeated return, step 5: when every party member has fallen (MON_STATUS bit 7) plays music
; $42 and goes on to the return; otherwise resumes the script. (C2, E-0357; probed E-0376)
PartyDefeatedReturn_CheckAllFallen::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hli]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr z, .skip
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld a, $42
    call QueueMusic
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    xor a
    ld [rRAMG], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Party defeated return, step 3: shows message $000B with the next marked member's name in the open
; box (kept open unless it is the last) and goes back to step 2. (C2, E-0357; probed E-0376)
PartyDefeatedReturn_ShowNextFallenName::
    ld hl, wScriptStep
    dec [hl]
    ld de, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $000b
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a
    jr nz, PartyDefeatedReturn_ShowFallenName_SetMessageIndex
    ld de, MSG_ALREADY_OPEN | $000b
    jr PartyDefeatedReturn_ShowFallenName_SetMessageIndex

; Party defeated return, step 2: after the box closes, goes to step 4 when no marked member is left,
; otherwise to step 3. (C1, E-0357)
PartyDefeatedReturn_CheckMarkedMembers::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    or a
    jr nz, .done
    xor a
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptStep], a
    ret

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; Party defeated return, step 1: shows message $000A with the first marked member's name (kept open
; when more follow). (C2, E-0357; probed E-0376)
PartyDefeatedReturn_ShowFallenName::
    ld hl, wScriptStep
    inc [hl]
    ld de, MSG_KEEP_OPEN | $000a
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a
    jr nz, PartyDefeatedReturn_ShowFallenName_SetMessageIndex
    ld de, $000a

; Starts the message word in DE (wMessageIndex = E, wMessageGroup = D, wMessageState = 0) and copies
; the name of a marked party member into wTextBuf1 + 7 (CopyRecordNameToNameGlyphBuf from the SRAM
; record, then 11 bytes of wNameGlyphBuf). The lowest set bit of wScriptParam1 picks the member: bit
; 0 gives wPartyList[0] and clears bit 0; bit 1 gives wPartyList[1] and clears bits 0-1; otherwise
; wPartyList[2], and the AND with $F7 clears bit 3, so bit 2 stays set. (C2, E-0376)
PartyDefeatedReturn_ShowFallenName_SetMessageIndex::
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ld a, [wScriptParam1]
    sra a
    jr nc, .skip
    ld a, [wScriptParam1]
    and $fe
    ld [wScriptParam1], a
    ld a, [wPartyList]
    jr .skip2

.skip:
    sra a
    jr nc, .check_script_param1
    ld a, [wScriptParam1]
    and $fc
    ld [wScriptParam1], a
    ld a, [wPartyList + $1]
    jr .skip2

.check_script_param1:
    ld a, [wScriptParam1]
    and $f7
    ld [wScriptParam1], a
    ld a, [wPartyList + $2]

.skip2:
    ld c, $01
    push af
    ld a, $0a
    ld [rRAMG], a
    pop af
    call CopyRecordNameToNameGlyphBuf
    xor a
    ld [rRAMG], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld bc, $000b
    call CopyBytes
    ret

; Party defeated return, step 0: counts the party members marked in wStatusFieldStep (one bit each)
; into wScriptParam0 and keeps the bits in wScriptParam1. (C2, E-0357; probed E-0376)
PartyDefeatedReturn_CountMarked::
    ld a, [wPartyCount]
    ld b, a
    ld c, $00
    ld a, [wStatusFieldStep]

.loop:
    sra a
    jr nc, .next
    inc c

.next:
    dec b
    jr nz, .loop
    ld a, c
    ld [wScriptParam0], a
    ld a, [wStatusFieldStep]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE), run through ScriptCommand85 for
; Script_KeyWorldBossBattle, which Talk_KeyWorldBossBattle starts. Eight steps by wScriptStep: a
; random message $00D0-$00DF, after the box closes the boss battle against wKeyWorldEncounter, then
; save the palettes, flash the screen, Warubou says 'Wa-hey! No good, no good!' (message $0129),
; wait for the box, flicker the boss for $78 calls and mark the key world cleared
; (KeyWorldBossBattle_MarkCleared: wKeyWorldFlags bit 7, every floor entry done, bit 6 of byte 0 of
; the current wKeyList entry). (C1, E-0376)
; implements script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a
; random message ($00D0 + 0..F), a battle against wKeyWorldEncounter (one or three monsters), then
; after the 'Warubou' message sets wKeyWorldFlags bit 7, marks every floor entry of
; wKeyWorldEncounterTable done and sets bit 6 of the current key entry byte 7; a C1 name from its
; calls and writes
KeyWorldBossBattle::
    ld a, [wScriptStep]
    jumptable
    dw KeyWorldBossBattle_ShowMessage
    dw KeyWorldBossBattle_StartBattle
    dw KeyWorldBossBattle_SavePalettes
    dw KeyWorldBossBattle_FlashScreen
    dw KeyWorldBossBattle_ShowWarubouWaheyNoGood
    dw KeyWorldBossBattle_RunMessageToEnd
    dw KeyWorldBossBattle_FlickerBoss
    dw KeyWorldBossBattle_MarkCleared

; Key world boss battle, step 7: sets wKeyWorldFlags bit 7, marks all four floor entries of
; wKeyWorldEncounterTable done (byte 3 of each 4-byte entry = 1), sets bit 6 of byte 0 of key entry
; wCurrentKeyIndex in wKeyList (the byte at wKeyList + 4 x wCurrentKeyIndex, an address the code
; builds as $C707 + 4 x the index) and resumes the script (wScriptStartRequest = $80). (C2, E-0376)
KeyWorldBossBattle_MarkCleared::
    ld a, [wKeyWorldFlags]
    or $80
    ld [wKeyWorldFlags], a
    ld hl, wKeyWorldEncounterTable + $3
    ld b, $04

.loop:
    ld [hl], $01
    ld a, $04
    add_a_to_hl
    dec b
    jr nz, .loop
    ld a, [wCurrentKeyIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    set 6, a
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Key world boss battle, step 6: the boss sprite flickers (one sprite slot or none; every 8 frames,
; then 4 from frame $1E, 2 from $3C) for $78 frames. (C2, E-0357; probed E-0376)
KeyWorldBossBattle_FlickerBoss::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 3, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.cp_3C:
    cp $3c
    jr nc, .check_bit1
    bit 2, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.check_bit1:
    bit 1, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.set_sprite_slot_count_to_01:
    ld a, $01
    ld [wSpriteSlotCount], a
    jr .check_script_param0

.clear_sprite_slot_count:
    xor a
    ld [wSpriteSlotCount], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Key world boss battle step 5 and floor battle step 3 (KeyWorldFloorBattle): runs the key world's
; message box each frame (KeyWorldBossBattle_RunMessageBox with A = 0, so the animation is frozen
; while it is open) until it is idle, then clears wScriptParam0 and moves on. (C1, E-0370)
KeyWorldBossBattle_RunMessageToEnd::
    xor a
    call KeyWorldBossBattle_RunMessageBox
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Key world boss battle, step 4: Warubou's 'Wa-hey! No good, no good!' (message $0129). (C2, E-0357;
; probed E-0376)
KeyWorldBossBattle_ShowWarubouWaheyNoGood::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0129 ; 'Warubou: Wa-hey! No good, no good!'
    call StartMessageHL_B0F_Bank12
    ret

; Key world boss battle, step 3: runs the negative screen flash. (C2, E-0357; probed E-0376)
KeyWorldBossBattle_FlashScreen::
    farcall ScriptStepFlashScreenNegative
    ret

; Key world boss battle, step 2: saves the GBC background palettes for the flash. (C2, E-0357;
; probed E-0376)
KeyWorldBossBattle_SavePalettes::
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; Key world boss battle, step 1: after the box closes starts the boss battle (intro 3): one monster
; (wKeyWorldEncounter word 0 at level byte 2, encounter kind 0) when bytes 3-4 are zero, otherwise
; three (words 3, 0 and 6, level byte 5, band byte 2, class byte 8, kind 2). (C1, E-0357)
KeyWorldBossBattle_StartBattle::
    xor a
    call RunMessageBoxFar_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ld [wBattleIntroKind], a
    ld a, [wKeyWorldEncounter + $3]
    ld c, a
    ld a, [wKeyWorldEncounter + $4]
    or c
    jr nz, .read_key_world_encounter
    ld a, [wKeyWorldEncounter]
    ld l, a
    ld a, [wKeyWorldEncounter + $1]
    ld h, a
    ld a, l
    ld [wEncounterMonsters], a
    ld a, h
    ld [wEncounterMonsters + $1], a
    ld a, [wKeyWorldEncounter + $2]
    ld [wWildLevel], a
    xor a
    ld [wEncounterKind], a
    jr .set_battle_transition_sub_step_to_01

.read_key_world_encounter:
    ld a, [wKeyWorldEncounter + $3]
    ld l, a
    ld a, [wKeyWorldEncounter + $4]
    ld h, a
    ld a, l
    ld [wEncounterMonsters], a
    ld a, h
    ld [wEncounterMonsters + $1], a
    ld a, [wKeyWorldEncounter + $5]
    ld [wWildLevel], a
    ld a, [wKeyWorldEncounter]
    ld l, a
    ld a, [wKeyWorldEncounter + $1]
    ld h, a
    ld a, l
    ld [wEncounterMonsters + $2], a
    ld a, h
    ld [wEncounterMonsters + $3], a
    ld a, [wKeyWorldEncounter + $2]
    ld [wWildBand], a
    ld a, [wKeyWorldEncounter + $6]
    ld l, a
    ld a, [wKeyWorldEncounter + $7]
    ld h, a
    ld a, l
    ld [wEncounterMonsters + $4], a
    ld a, h
    ld [wEncounterMonsters + $5], a
    ld a, [wKeyWorldEncounter + $8]
    ld [wEncounterClass], a
    ld a, $02
    ld [wEncounterKind], a

.set_battle_transition_sub_step_to_01:
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ret

; Key world boss battle, step 0: a random message of $00D0-$00DF. (C2, E-0357; probed E-0376)
KeyWorldBossBattle_ShowMessage::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    ld hl, $00d0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE), run through ScriptCommand9E for
; Script_KeyWorldFloorBattle, which Talk_KeyWorldFloorBattle starts. Six steps by wScriptStep: a
; random message $00E0-$00EF, after the box closes the battle against the wKeyWorldEncounterTable
; entry of wKeyWorldFloor, the Warubou message $012A, wait for the box
; (KeyWorldBossBattle_RunMessageToEnd), flicker for $78 calls (KeyWorldBossBattle_FlickerBoss) and
; mark the floor entry done (byte 3 = 1). (C1, E-0376)
; implements script command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a
; random message ($00E0 + 0..F), a battle against the wKeyWorldEncounterTable entry of
; wKeyWorldFloor, then after the 'Warubou' message marks that floor entry done (byte 3 = 1); a C1
; name from its calls and writes
KeyWorldFloorBattle::
    ld a, [wScriptStep]
    jumptable
    dw KeyWorldFloorBattle_ShowMessage
    dw KeyWorldFloorBattle_StartBattle
    dw KeyWorldFloorBattle_ShowWarubouWaheyThatWas
    dw KeyWorldBossBattle_RunMessageToEnd
    dw KeyWorldBossBattle_FlickerBoss
    dw KeyWorldFloorBattle_MarkCleared

; Key world floor battle, step 5: marks the floor's entry of wKeyWorldEncounterTable done (byte 3 =
; 1) and resumes the script. (C2, E-0357; probed E-0376)
KeyWorldFloorBattle_MarkCleared::
    ld a, [wKeyWorldFloor]
    and $7f
    add a
    add a
    ld hl, wKeyWorldEncounterTable + $3
    add_a_to_hl
    ld [hl], $01
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Key world floor battle, step 2: Warubou's 'Wa-hey... That was no good.' (message $012A). (C2,
; E-0357; probed E-0376)
KeyWorldFloorBattle_ShowWarubouWaheyThatWas::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $012a ; 'Warubou: Wa-hey… That was no good.'
    call StartMessageHL_B0F_Bank12
    ret

; Key world floor battle, step 1: after the box closes starts a battle (intro 3, kind 0) against the
; floor's entry: its monster word and level. (C1, E-0357)
KeyWorldFloorBattle_StartBattle::
    xor a
    call RunMessageBoxFar_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ld [wBattleIntroKind], a
    ld a, [wKeyWorldFloor]
    and $7f
    add a
    add a
    ld hl, wKeyWorldEncounterTable
    add_a_to_hl
    ld a, [hli]
    ld [wEncounterMonsters], a
    ld a, [hli]
    ld [wEncounterMonsters + $1], a
    ld a, [hl]
    ld [wWildLevel], a
    xor a
    ld [wEncounterKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ret

; Key world floor battle, step 0: a random message of $00E0-$00EF. (C2, E-0357; probed E-0376)
KeyWorldFloorBattle_ShowMessage::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    ld hl, $00e0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM), run through ScriptCommand84 for
; Script_RandomGoldOrItem, which Talk_RandomGoldOrItem starts. Clears wJoypadHeld and wJoypadPressed
; on every step except 7, then runs nine steps by wScriptStep: load and place the script sprite
; (SetupScriptSpriteInFrontOfPlayer), sound $83, animate the sprite for 30 calls, replace the tiles
; at the trigger, pick gold or an item, hop the marker, show the find, mark the trigger used up
; after the box closes, and give the gold or item. (C1, E-0376)
; implements script command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event
; (group $02, dispatched from FieldModeStateDispatch: random gold (AddGoldCapped) or item
; (AppendItemStepPtrLoToInventory)); named from its trigger and calls
RandomGoldOrItem::
    ld a, [wScriptStep]
    cp $07
    jr z, .read_script_step
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.read_script_step:
    ld a, [wScriptStep]
    jumptable
    dw SetupScriptSpriteInFrontOfPlayer
    dw PlaySound83AndAdvanceScriptStep
    dw ScriptStepAnimateSpriteBySteps
    dw RandomGoldOrItem_ReplaceTiles
    dw RandomGoldOrItem_PickFind
    dw RandomGoldOrItem_HopMarker
    dw RandomGoldOrItem_ShowMessage
    dw RandomGoldOrItem_UseUpTrigger
    dw RandomGoldOrItem_Give

; Random gold or item, step 8: gives the gold (wTriggerMarkerFlags low bits, AddGoldCapped) or item
; wScriptParam1, clears the marker flags and resumes the script. (C2, E-0357; probed E-0376)
RandomGoldOrItem_Give::
    ld a, [wTriggerMarkerFlags]
    and $7f
    jr z, .read_script_param1
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    call AddGoldCapped
    jr .clear_trigger_marker_flags

.read_script_param1:
    ld a, [wScriptParam1]
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory

.clear_trigger_marker_flags:
    xor a
    ld [wTriggerMarkerFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Random gold or item, step 7: after the box closes sets the trigger kind to $FF (used up). (C1,
; E-0357)
RandomGoldOrItem_UseUpTrigger::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $ff
    ld [wTriggerKind], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Random gold or item, step 6: message 5 with the amount of gold, or message 6 with the item's name.
; (C2, E-0357; probed E-0376)
RandomGoldOrItem_ShowMessage::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTriggerMarkerFlags]
    and $7f
    jr z, .read_script_param1
    ld [wDigits], a
    xor a
    ld [wDigits + $1], a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ld a, $05
    call StartMessageA
    xor a
    ld [wMessageGroup], a
    ret

.read_script_param1:
    ld a, [wScriptParam1]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, $06
    call StartMessageA
    xor a
    ld [wMessageGroup], a
    ret

; Random gold or item, step 5: makes the trigger marker hop (the hop curve on wTriggerIndex) for 16
; frames. (C2, E-0357; probed E-0376)
RandomGoldOrItem_HopMarker::
    ld de, wTriggerIndex
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Random gold or item, step 4: picks the gold or item at random
; (RandomGoldOrItem_PickFind_RollFind). (C1, E-0357)
RandomGoldOrItem_PickFind::
    farcall RandomGoldOrItem_PickFind_RollFind
    ret

; Random gold or item, step 3: replaces the 2x2 tiles at the trigger's spot (wMessageGroup and
; wMessageIndex high nibbles) with tiles $40 $41 / $50 $51; on the GBC their palette becomes 1 (3 on
; maps $53-$57 and $63-$66); redraws the screen and shows the field sprites. (C1, E-0357)
RandomGoldOrItem_ReplaceTiles::
    ld a, [wMessageGroup]
    swap a
    and $0f
    add a
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    ld a, [wMessageIndex]
    swap a
    and $0f
    sla a
    add_a_to_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    push hl
    ld [hl], $40
    inc hl
    ld [hl], $41
    ld a, $13
    add_a_to_hl
    ld [hl], $50
    inc hl
    ld [hl], $51
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld a, l
    sub $98
    ld l, a
    ld a, h
    sbc $c1
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld c, $01
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip2
    ldh a, [hMapId]
    cp $63
    jr z, .skip
    cp $64
    jr z, .skip
    cp $65
    jr z, .skip
    cp $66
    jr z, .skip
    cp $53
    jr z, .skip
    cp $54
    jr z, .skip
    cp $55
    jr z, .skip
    cp $56
    jr nz, .cp_57

.skip:
    ld c, $03
    jr .skip2

.cp_57:
    cp $57
    jr nz, .skip2
    ld c, $03

.skip2:
    ld a, $02
    ldh [rSVBK], a
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    xor a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script step (RandomGoldOrItem step 2, and far-called by SceneStrongestMaster_AnimateSprite): sets
; the frame wScriptParam1 from the counter wScriptParam0 before counting it: 0-5 give 0, 6-11 give
; 1, 12-23 give 3 and 24 or more give 4 (the 2 stored for 12-17 is overwritten, because A then holds
; 2 when it is compared with $18). It draws the sprite (DrawScriptMetaSpriteAtScrollOffset), and
; after $1E calls from 0 resets wScriptParam0 and advances wScriptStep. (C2, E-0376)
; wScriptParam1 = wScriptParam0 / 6 (capped at 4), draws the script sprite, and advances wScriptStep
; after $1E frames (E-0125)
ScriptStepAnimateSpriteBySteps::
    ld a, [wScriptParam0]
    cp $06
    jr nc, .cp_0C
    xor a
    ld [wScriptParam1], a
    jr .call_draw_script_meta_sprite_at_scroll_offset

.cp_0C:
    cp $0c
    jr nc, .cp_12
    ld a, $01
    ld [wScriptParam1], a
    jr .call_draw_script_meta_sprite_at_scroll_offset

.cp_12:
    cp $12
    jr nc, .cp_18
    ld a, $02
    ld [wScriptParam1], a

.cp_18:
    cp $18
    jr nc, .set_script_param1_to_04
    ld a, $03
    ld [wScriptParam1], a
    jr .call_draw_script_meta_sprite_at_scroll_offset

.set_script_param1_to_04:
    ld a, $04
    ld [wScriptParam1], a

.call_draw_script_meta_sprite_at_scroll_offset:
    call DrawScriptMetaSpriteAtScrollOffset
    ld b, $1e
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Draws metasprite set $23 (the read of wMapSpriteKind is dead: A is reloaded with $10, so the set
; is always $23) with sub-index wScriptParam1, attribute XOR 7 and tile offset $70, at the 16-bit
; scroll position plus (wMessageIndex + 8, wMessageGroup + $10), through DrawMetaSprite.
; wMessageIndex and wMessageGroup hold the sprite position here (set by
; SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace). Only caller: ScriptStepAnimateSpriteBySteps. (C2,
; E-0376)
; draws metasprite set $23 + ($10 >> 4) - 1, sub-index wScriptParam1, at the scroll position plus
; (wMessageIndex + 8, wMessageGroup + $10), used here as coordinates (E-0121)
DrawScriptMetaSpriteAtScrollOffset::
    ld a, [wMapSpriteKind]
    ld a, $10
    swap a
    and $0f
    dec a
    add $23
    ldh [hSpriteSetIndex], a
    ld a, [wScriptParam1]
    ldh [hSpriteSubIndex], a
    ld a, $07
    ldh [hSpriteAttrXor], a
    ld a, $70
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld l, a
    ldh a, [hScrollXHi]
    ld h, a
    ld a, [wMessageIndex]
    add $08
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld l, a
    ldh a, [hScrollYHi]
    ld h, a
    ld a, [wMessageGroup]
    add $10
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; Script step (RandomGoldOrItem step 1, and far-called by SceneStrongestMaster_PlaySound): queues
; sound effect $83 (wSoundEffectRequest) and increments wScriptStep. (C2, E-0376)
; QueueSoundEffect $83, then wScriptStep += 1 (E-0114)
PlaySound83AndAdvanceScriptStep::
    ld a, $83
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; Script step (RandomGoldOrItem step 0, and far-called by SceneStrongestMaster_SetUpSprite): sets DE
; = $5994 and B = $7E, the compressed graphics Gfx7E_7 (the source spells the address as the
; bank-$12 label KeyWorldBossBattle_ShowMessage), and goes on at
; SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace, which decompresses them to vTiles0 + $700, places
; the sprite 16 pixels in front of the player and advances wScriptStep. It computes A =
; wMapSpriteKind >> 4 but nothing uses A, so the graphics do not depend on wMapSpriteKind. (C1,
; E-0376)
; A = wMapSpriteKind >> 4, DE = KeyWorldBossBattle_ShowMessage, B = $7E, then continues at
; SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace (E-0126)
SetupScriptSpriteInFrontOfPlayer::
    ld a, [wMapSpriteKind]
    swap a
    and $0f
    ld de, KeyWorldBossBattle_ShowMessage
    ld b, $7e
    jr SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace

; A picks compressed graphics in bank $7E: 1 gives SpawnScriptSpriteInFrontOfPlayer_Data, any other
; value Tiles0Plus700Gfx_4; then it goes on at SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace
; (decompress to vTiles0 + $700, place the sprite 16 pixels in front of the player, turn the
; followers the same way, clear wScriptParam0, advance wScriptStep). No caller in src/ or in the
; listing. (C1, E-0376)
; decompresses sprite graphics from bank $7E to vTiles0 + $700 (with a CGB palette), places it 16
; pixels in front of the player and advances wScriptStep (E-0129)
SpawnScriptSpriteInFrontOfPlayer::
    dec a
    jr nz, .skip
    ld de, SpawnScriptSpriteInFrontOfPlayer_Data
    ld b, $7e
    jr SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace

.skip:
    ld de, Tiles0Plus700Gfx_4
    ld b, $7e

; DE = compressed sprite graphics, B = their bank: decompresses them to vTiles0 + $700; on the GBC
; copies eight palette bytes from bank $7E ($4BBD + 8 * $23 every time, since the wMapSpriteKind
; load is overwritten by $10) into OBJ palette 7 (wOBJPaletteBuffer + $38) and requests the upload;
; puts the sprite's position 16 pixels in front of the player by hPlayerFacing (X in wMessageIndex,
; Y in wMessageGroup), turns the three followers (wFollowerRecords) the player's way, clears
; wScriptParam0 and advances wScriptStep. (C1, E-0370)
SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace::
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .read_player_x
    ld a, [wMapSpriteKind]
    ld a, $10
    swap a
    and $0f
    add $22
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $bd
    ld e, a
    ld a, d
    adc $4b
    ld d, a
    ld b, $7e
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.read_player_x:
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .set_message_index
    dec a
    jr z, .set_message_index2
    dec a
    jr z, .set_message_index3
    ld a, d
    sub $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .read_player_facing

.set_message_index:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add $10
    ld [wMessageGroup], a
    jr .read_player_facing

.set_message_index2:
    ld a, d
    add $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .read_player_facing

.set_message_index3:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub $10
    ld [wMessageGroup], a

.read_player_facing:
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 83 (SCRIPT_FIELD_SCENE_01), run through ScriptCommand83 for
; Script_FieldScene01, which Talk_FieldScene01 starts. wScriptParam1 picks the variant: 1 runs
; FieldScene01_Variant1 (gather the followers, load a sprite in front of the player and hop onto
; it), 2 runs FieldScene01_Variant2 (the same, then travel until land and get off), and any other
; value runs FieldScene01_GetOff (the player hops off forward). (C1, E-0376)
; implements script command type 83 (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group
; $01, dispatched from FieldModeStateDispatch: draws script meta-sprite 21, moves objects, changes
; the music); named from its trigger and calls
FieldScene01::
    ld a, [wScriptParam1]
    dec a
    jr nz, .skip
    call FieldScene01_Variant1
    ret

.skip:
    dec a
    jr nz, .call_field_scene01_get_off
    call FieldScene01_Variant2
    ret

.call_field_scene01_get_off:
    call FieldScene01_GetOff
    ret

; Field scene 1, the getting-off variant (wScriptParam1 not 1 or 2): clears the joypad and runs its
; two steps by wScriptStep. (C1, E-0357)
FieldScene01_GetOff::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    jumptable
    dw FieldScene01_GetOff_Start
    dw FieldScene01_HopForward

; Field scene 1, getting off, step 0: clears hPlayerStateFlags bit 3, hides the followers, player
; sprite mode 0, and lifts the player 8 pixels. (C2, E-0357; probed E-0376)
FieldScene01_GetOff_Start::
    ldh a, [hPlayerStateFlags]
    and $f7
    ldh [hPlayerStateFlags], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    xor a
    ldh [hPlayerSpriteMode], a
    ldh a, [hPlayerY]
    sub $08
    ldh [hPlayerY], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Field scene 1, getting off, step 1: the player hops forward (a pixel in its facing every other
; frame, down a pixel every four) for $20 frames; then the followers gather on the player and are
; shown, the script resumes, a zero step starts and the map music plays. (C1, E-0357)
FieldScene01_HopForward::
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    jr nz, .check_script_param02
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerStateFlags]
    or $01
    ldh [hPlayerStateFlags], a
    ld hl, $0000
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall PlayMapMusic
    ret

.check_script_param02:
    ld a, [wScriptParam0]
    and $01
    ret z
    ldh a, [hPlayerFacing]
    or a
    jr z, .done
    dec a
    jr z, .done2
    dec a
    jr z, .done3
    ld hl, hPlayerX
    dec [hl]
    ret

.done:
    ld hl, hPlayerY
    inc [hl]
    ret

.done2:
    ld hl, hPlayerX
    inc [hl]
    ret

.done3:
    ld hl, hPlayerY
    dec [hl]
    ret

; Field scene 1, variant 1 (wScriptParam1 = 1): clears the joypad and runs its steps by wScriptStep:
; gather the followers, load the sprite, wait, spin, flicker, show it, and climb on. (C1, E-0357)
FieldScene01_Variant1::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    jumptable
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw FieldScene01_LoadSprite
    dw FieldScene01_Wait
    dw FieldScene01_HopAndSpin
    dw FieldScene01_FlickerSprite
    dw FieldScene01_DrawSprite
    dw FieldScene01_HopOnSprite

; Field scene 1, variant 1, step 8: the player hops onto the sprite in front (a pixel toward it
; every other frame, rising a pixel every four) for $20 frames, the sprite drawn; then the player's
; Y snaps to the tile grid, hPlayerStateFlags bit 3 is set (bits 5 and 7 cleared), player sprite
; mode 2, and the script resumes. (C1, E-0357)
FieldScene01_HopOnSprite::
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    jr nz, .call_draw_script_meta_sprite21_at_scroll
    ldh a, [hPlayerY]
    add $08
    and $f0
    ldh [hPlayerY], a
    ldh a, [hPlayerStateFlags]
    or $08
    and $5f
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerSpriteMode], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_draw_script_meta_sprite21_at_scroll:
    call DrawScriptMetaSprite21AtScrollOffset
    ld a, [wScriptParam0]
    and $01
    ret z
    ldh a, [hPlayerFacing]
    or a
    jr z, .done
    dec a
    jr z, .done2
    dec a
    jr z, .done3
    ld hl, hPlayerX
    dec [hl]
    ret

.done:
    ld hl, hPlayerY
    inc [hl]
    ret

.done2:
    ld hl, hPlayerX
    inc [hl]
    ret

.done3:
    ld hl, hPlayerY
    dec [hl]
    ret

; Field scene 1, variant 1, step 7: draws the sprite and moves on; plays music $2B in a key world of
; map type $80 or on a map listed in FieldScene01_DrawSprite_Data. (C1, E-0357)
FieldScene01_DrawSprite::
    call DrawScriptMetaSprite21AtScrollOffset
    ld hl, wScriptStep
    inc [hl]
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    cp $80
    jr z, .call_queue_music
    ret

.read_map_id:
    ldh a, [hMapId]
    ld c, a
    ld hl, FieldScene01_DrawSprite_Data

.loop:
    ld a, [hli]
    cp $ff
    ret z
    cp c
    jr nz, .loop

.call_queue_music:
    ld a, $2b
    call QueueMusic
    ret

; data read by FieldScene01 (2 bytes) (E-0347)
FieldScene01_DrawSprite_Data::
    db $30, $ff

; Field scene 1, variant 1, step 3: decompresses the sprite (Tiles0Plus700Gfx_2) to VRAM $8700 with
; its palette from bank $7E, puts it 16 pixels in front of the player (wMessageIndex/wMessageGroup)
; and turns the followers the player's way. (C1, E-0357)
FieldScene01_LoadSprite::
    ld de, Tiles0Plus700Gfx_2
    ld b, $7e
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $0108
    ld a, e
    add $bd
    ld e, a
    ld a, d
    adc $4b
    ld d, a
    ld b, $7e
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .set_message_index
    dec a
    jr z, .set_message_index2
    dec a
    jr z, .set_message_index3
    ld a, d
    sub $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add $10
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index2:
    ld a, d
    add $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index3:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub $10
    ld [wMessageGroup], a

.set_field_draw_flags_to_0E:
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Field scene 1, variant 2 (wScriptParam1 = 2): clears the joypad and runs its steps by wScriptStep:
; as variant 1 up to the climb, then travel until land and get off. (C1, E-0357)
FieldScene01_Variant2::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    jumptable
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw FieldScene01_LoadSprite2
    dw FieldScene01_Wait
    dw FieldScene01_HopAndSpin
    dw FieldScene01_FlickerSprite
    dw FieldScene01_HopOnSprite2
    dw FieldScene01_Variant2_RideUntilLand
    dw FieldScene01_EnableTriggers

; Field scene 1, step 4: waits $1E frames. (C2, E-0357; probed E-0376)
FieldScene01_Wait::
    ld b, $1e
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Field scene 1, step 5: the player hops while spinning (a quarter turn every other frame) for $20
; frames; then faces the first follower's way and sound $7A plays. (C2, E-0357; probed E-0376)
FieldScene01_HopAndSpin::
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_script_param0
    ldh a, [hPlayerFacing]
    inc a
    and $03
    ldh [hPlayerFacing], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, [wFollowerRecords]
    ldh [hPlayerFacing], a
    ld a, $7a
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Field scene 1, variant 2, step 9: enables triggers and sets hPlayerStateFlags bits 5 and 7 while
; the player hops down off the sprite for $20 frames; then clears them, gathers and shows the
; followers, resumes the script, stops the step deltas and disables triggers. (C2, E-0357; probed
; E-0376)
FieldScene01_EnableTriggers::
    ld a, $01
    ld [wTriggerEnable], a
    ldh a, [hPlayerStateFlags]
    or $a0
    ldh [hPlayerStateFlags], a
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    jr nz, .return
    ldh a, [hPlayerStateFlags]
    and $5f
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerStateFlags]
    or $01
    ldh [hPlayerStateFlags], a
    ld hl, $0000
    ld a, l
    ldh [hPlayerStepDXLo], a
    ld a, h
    ldh [hPlayerStepDXHi], a
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    xor a
    ld [wTriggerEnable], a
    ret

.return:
    ret

; Field scene 1, variant 2, step 8: once the step is done, holds the direction the player faces (one
; tile on, within the screen); when the tiles there are above wMaxBlockingTile the player gets off
; (sprite mode 0, lifted 8 pixels, next step); when they block, or object 0 stands there, the player
; turns around; tiles at or below wMapTallTileMin let it go on. (C2, E-0357; probed E-0376)
FieldScene01_Variant2_RideUntilLand::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .read_joypad_held
    dec a
    jr z, .read_joypad_held2
    dec a
    jr z, .read_joypad_held3
    ld a, [wJoypadHeld]
    set 5, a
    ld [wJoypadHeld], a
    ld a, b
    or a
    ret z
    sub $10
    ld b, a
    jr .check_sprite_slot_count

.read_joypad_held:
    ld a, [wJoypadHeld]
    set 7, a
    ld [wJoypadHeld], a
    ld a, c
    cp $80
    ret z
    add $10
    ld c, a
    jr .check_sprite_slot_count

.read_joypad_held2:
    ld a, [wJoypadHeld]
    set 4, a
    ld [wJoypadHeld], a
    ld a, b
    cp $90
    ret z
    add $10
    ld b, a
    jr .check_sprite_slot_count

.read_joypad_held3:
    ld a, [wJoypadHeld]
    set 6, a
    ld [wJoypadHeld], a
    ld a, c
    or a
    ret z
    sub $10
    ld c, a

.check_sprite_slot_count:
    ld a, [wSpriteSlotCount]
    or a
    jr z, .call_read_tile_buffer2x2_at_pixel_bank12_2
    ld a, [wSpriteSlots + $b]
    cp b
    jr nz, .call_read_tile_buffer2x2_at_pixel_bank12_2
    ld a, [wSpriteSlots + $c]
    cp c
    jr z, .check_player_facing

.call_read_tile_buffer2x2_at_pixel_bank12_2:
    call ReadTileBuffer2x2AtPixel_Bank12_2
    ld b, $04
    ld hl, wTilesUnderPoint
    ld b, $02
    ld a, [wMaxBlockingTile]
    ld e, a
    ld a, [wMapTallTileMin]
    ld d, a

.loop:
    ld a, [hli]
    cp d
    jr z, .next
    jr c, .next
    cp e
    jr z, .check_player_facing
    jr c, .check_player_facing
    xor a
    ldh [hPlayerSpriteMode], a
    ldh a, [hPlayerY]
    sub $08
    ldh [hPlayerY], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

.next:
    dec b
    jr nz, .loop
    ret

.check_player_facing:
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ldh [hPlayerFacing], a
    xor a
    ld [wJoypadHeld], a
    ret

; Field scene 1, variant 2, step 7: the player hops onto the sprite in front (as variant 1, step 8)
; for $20 frames; then its Y snaps to the tile grid and player sprite mode 2. (C1, E-0357)
FieldScene01_HopOnSprite2::
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    jr nz, .call_draw_script_meta_sprite21_at_scroll
    ldh a, [hPlayerY]
    add $08
    and $f0
    ldh [hPlayerY], a
    ld a, $02
    ldh [hPlayerSpriteMode], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_draw_script_meta_sprite21_at_scroll:
    call DrawScriptMetaSprite21AtScrollOffset
    ld a, [wScriptParam0]
    and $01
    ret z
    ldh a, [hPlayerFacing]
    or a
    jr z, .done
    dec a
    jr z, .done2
    dec a
    jr z, .done3
    ld hl, hPlayerX
    dec [hl]
    ret

.done:
    ld hl, hPlayerY
    inc [hl]
    ret

.done2:
    ld hl, hPlayerX
    inc [hl]
    ret

.done3:
    ld hl, hPlayerY
    dec [hl]
    ret

; Field scene 1, step 6: the sprite flickers (every 2 frames, slowing to 4 and 8) for $78 frames;
; then hides the followers. (C1, E-0357)
FieldScene01_FlickerSprite::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .call_draw_script_meta_sprite21_at_scroll
    jr .check_script_param0

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .call_draw_script_meta_sprite21_at_scroll
    jr .check_script_param0

.check_bit3:
    bit 3, a
    jr z, .call_draw_script_meta_sprite21_at_scroll
    jr .check_script_param0

.call_draw_script_meta_sprite21_at_scroll:
    call DrawScriptMetaSprite21AtScrollOffset
    jr .check_script_param0

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ret

; Draws the FieldScene01 sprite: metasprite set $21 when wMapSpriteKind & $0F is 1, otherwise $22,
; sub-index 0, tile offset $70, attribute XOR 7, or $27 (which adds OAM bit 5, the horizontal flip)
; when hPlayerFacing is 1, at the scroll position plus (wMessageIndex + 8, wMessageGroup + $10),
; through DrawMetaSprite. Callers: FieldScene01_HopOnSprite, FieldScene01_DrawSprite,
; FieldScene01_HopOnSprite2 and FieldScene01_FlickerSprite. (C2, E-0376)
; draws metasprite set $21 (or $22 unless wMapSpriteKind & $0F = 1), flipped by the player facing,
; at the scroll position plus (wMessageIndex + 8, wMessageGroup + $10) (E-0125)
DrawScriptMetaSprite21AtScrollOffset::
    ld a, $21
    ldh [hSpriteSetIndex], a
    ld a, [wMapSpriteKind]
    and $0f
    dec a
    jr z, .set_sprite_attr_xor_to_07
    ld hl, hSpriteSetIndex
    inc [hl]

.set_sprite_attr_xor_to_07:
    ld a, $07
    ldh [hSpriteAttrXor], a
    ldh a, [hPlayerFacing]
    cp $01
    jr nz, .clear_sprite_sub_index
    ld a, $27
    ldh [hSpriteAttrXor], a

.clear_sprite_sub_index:
    xor a
    ldh [hSpriteSubIndex], a
    ld a, $70
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld l, a
    ldh a, [hScrollXHi]
    ld h, a
    ld a, [wMessageIndex]
    add $08
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld l, a
    ldh a, [hScrollYHi]
    ld h, a
    ld a, [wMessageGroup]
    add $10
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; Field scene 1, variant 2, step 3: as variant 1's step 3 with the sprite Tiles0Plus700Gfx_3:
; decompresses it to VRAM $8700 with its palette from bank $7E, puts it 16 pixels in front of the
; player and turns the followers the player's way. (C1, E-0357)
FieldScene01_LoadSprite2::
    ld de, Tiles0Plus700Gfx_3
    ld b, $7e
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $0108
    ld a, e
    add $bd
    ld e, a
    ld a, d
    adc $4b
    ld d, a
    ld b, $7e
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .set_message_index
    dec a
    jr z, .set_message_index2
    dec a
    jr z, .set_message_index3
    ld a, d
    sub $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add $10
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index2:
    ld a, d
    add $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index3:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub $10
    ld [wMessageGroup], a

.set_field_draw_flags_to_0E:
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script step that brings the followers onto the leader chain: when wScriptParam0 is 0 it far-calls
; SetFollowerTargetsFromLeader (targets become the current positions of the player and of followers
; 1 and 2) and sets wScriptParam0 = 1; later calls far-call StepFollowersTowardTargets and count
; wScriptParam0 up, and when it reaches $11 (17 calls in all from 0) it is reset and wScriptStep
; advances. FieldScene01_Variant1 and FieldScene01_Variant2 use it for steps 0-2; scenes in banks
; $0F, $73 and $85 far-call it. (C2, E-0376)
; script step: first frame sets the follower targets from the leader; later frames step the
; followers until the wScriptParam0 counter reaches $11, then advances wScriptStep (E-0122)
ScriptStepMoveFollowersToLeader::
    ld a, [wScriptParam0]
    or a
    jr nz, .call_step_followers_toward_targets
    farcall SetFollowerTargetsFromLeader
    ld hl, wScriptParam0
    inc [hl]
    ret

.call_step_followers_toward_targets:
    farcall StepFollowersTowardTargets
    ld b, $11
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM), run through ScriptCommand86 for
; Script_KeyWorldDoorItem, which Talk_KeyWorldDoorItem starts; the item is in wScriptParam0/1. Five
; steps by wScriptStep: show the item message (KeyWorldDoorItem_ShowItemMessage), wait for the box,
; give the item and open the door (KeyWorldDoorItem_GiveItem, which requests the next script
; command), wait again, then KeyWorldDoorItem_OpenDoor; the $81 path of step 0 jumps to step 3. (C1,
; E-0376)
; implements script command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event
; (group $0B: random item or key entry (GenerateNewKeyEntry) and door tiles for the key-world floor
; (DrawDoorTilesForKeyWorldFloor)); named from its trigger and calls
KeyWorldDoorItem::
    ld a, [wScriptStep]
    jumptable
    dw KeyWorldDoorItem_ShowItemMessage
    dw KeyWorldDoorItem_WaitForMessage
    dw KeyWorldDoorItem_GiveItem
    dw KeyWorldDoorItem_WaitForMessage
    dw KeyWorldDoorItem_OpenDoor

; Key world door item, step 4: runs KeyWorldDoorItem_OpenDoor_BuildGiftRecord, marks the floor's
; door opened (state byte 3 = $FF), redraws the door tiles and the screen and resumes the script.
; (C1, E-0357)
KeyWorldDoorItem_OpenDoor::
    farcall KeyWorldDoorItem_OpenDoor_BuildGiftRecord
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $3
    add_a_to_hl
    ld a, $ff
    ld [hl], a
    farcall DrawDoorTilesForKeyWorldFloor
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Key world door item, step 2: with no item resumes at once; otherwise marks the door opened, adds
; item wScriptParam0 to the inventory unless its bit 7 is set, redraws the door tiles and the screen
; and resumes the script. (C1, E-0357)
KeyWorldDoorItem_GiveItem::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or l
    jr nz, .read_key_world_floor
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_key_world_floor:
    push hl
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $3
    add_a_to_hl
    ld a, $ff
    ld [hl], a
    pop hl
    ld a, l
    bit 7, a
    jr nz, .call_draw_door_tiles_for_key_world_floor
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    jr .call_draw_door_tiles_for_key_world_floor

.call_draw_door_tiles_for_key_world_floor:
    farcall DrawDoorTilesForKeyWorldFloor
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Key world door item, step 1: waits for the message box to close. (C1, E-0357)
KeyWorldDoorItem_WaitForMessage::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Key world door item, step 0: no item: message 0; item $80: a new key (GenerateNewKeyEntry) with
; message 8, or message 9 and no item when it returns hTemp0 = 0; item $81: the same new key when
; wGiftRecord is 1, otherwise message $19 and step 3; any other item: its name, message 2 when the
; last inventory slot is free, otherwise message 3 and no item. (C2, E-0357; probed E-0376)
KeyWorldDoorItem_ShowItemMessage::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or l
    jr nz, .skip
    ld a, $00
    call StartMessageA
    ret

.skip:
    ld a, l
    cp $80
    jr z, .loop
    cp $81
    jr z, .check_gift_record
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_start_message_a
    cp $00
    jr nz, .call_start_message_a2

.call_start_message_a:
    ld a, $02
    call StartMessageA
    ret

.call_start_message_a2:
    ld a, $03
    call StartMessageA
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ret

.loop:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .call_start_message_a3
    ld a, $08
    call StartMessageA
    ret

.call_start_message_a3:
    ld a, $09
    call StartMessageA
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ret

.check_gift_record:
    ld a, [wGiftRecord]
    cp $01
    jr z, .loop
    ld a, $19
    call StartMessageA
    ld a, $03
    ld [wScriptStep], a
    ret

; Script command type 81 (SCRIPT_AREA_ITEM), run through ScriptCommand81 for Script_AreaItem, which
; Talk_AreaItem starts. wScriptParam0/1 point at the item record (byte 1 the item, byte 3 nonzero
; once taken). Three steps by wScriptStep: show the item message, wait for the box, then give the
; item, mark the record taken and redraw (AreaItemEvent_GiveItem). (C1, E-0376)
; implements script command type 81 (SCRIPT_AREA_ITEM): a key-world/field talk event (group $0E,
; dispatched from FieldModeStateDispatch: gives an item (AppendItemStepPtrLoToInventory) after
; CheckTwoKeyWorldFloorState4EntriesForKeyWorldArea, redrawing the screen); named from its trigger
; and calls
AreaItemEvent::
    ld a, [wScriptStep]
    jumptable
    dw AreaItemEvent_ShowItemMessage
    dw AreaItemEvent_WaitForMessage
    dw AreaItemEvent_GiveItem

; Area item, step 2: with no item resumes at once; otherwise gives the item (record byte 1), marks
; the record taken (byte 3 = 1), updates the floor's item state
; (CheckTwoKeyWorldFloorState4EntriesForKeyWorldArea), redraws and resumes the script. (C1, E-0357)
AreaItemEvent_GiveItem::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or l
    jr nz, .read_script_param0
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_script_param0:
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    inc hl
    ld a, [hl]
    ld [wStepPtrLo], a
    inc hl
    inc hl
    ld [hl], $01
    farcall AppendItemStepPtrLoToInventory
    farcall CheckTwoKeyWorldFloorState4EntriesForKeyWorldArea
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Area item, step 1: waits for the message box to close. (C1, E-0357)
AreaItemEvent_WaitForMessage::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Area item, step 0: an item already taken (record byte 3 set) gives message 0; otherwise its name,
; message 2 when the last inventory slot is free, or message 3 and no item. (C2, E-0357; probed
; E-0376)
AreaItemEvent_ShowItemMessage::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a
    jr z, .next
    ld a, $00
    call StartMessageA
    ret

.next:
    dec hl
    dec hl
    ld a, [hl]
    and $7f
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_start_message_a
    cp $00
    jr nz, .call_start_message_a2

.call_start_message_a:
    ld a, $02
    call StartMessageA
    ret

.call_start_message_a2:
    ld a, $03
    call StartMessageA
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ret

; Script command type 80 (SCRIPT_STEP_TRIGGER_REWARD), run through ScriptCommand80 for
; Script_StepTriggerReward, which Talk_StepTriggerReward starts. Step 0 shows a message chosen by
; the kind byte of the active trigger record (ActiveTriggerRecord) and stores the next step in
; wScriptParam0; step 1 waits for the box and sets wScriptStep to it: 2 gives gold, 3 an item, 4
; starts a battle, and 5 only requests the next script command. (C1, E-0376)
; implements script command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event
; (group $0F, dispatched by CheckStepTriggerAndDispatchTalk: gives gold (a byte * 10,
; AddGoldCapped), an item (AppendItemStepPtrLoToInventory) or starts a battle with intro 5); named
; from its trigger and calls
StepTriggerReward::
    ld a, [wScriptStep]
    jumptable
    dw StepTriggerReward_ShowMessage
    dw StepTriggerReward_WaitMessage
    dw StepTriggerReward_GiveGold
    dw StepTriggerReward_GiveItem
    dw StepTriggerReward_StartBattle
    dw StepTriggerReward_SetScriptStartRequestTo80

; Step trigger reward, step 5: resumes the script. (C2, E-0357; probed E-0376)
StepTriggerReward_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step trigger reward, step 4: starts a battle (intro 5), marks the trigger used (bit 7) and resumes
; the script. (C1, E-0357)
StepTriggerReward_StartBattle::
    ld a, $05
    ld [wBattleIntroKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    call ActiveTriggerRecord
    ld a, [hl]
    or $80
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step trigger reward, step 3: gives the trigger's item, marks it used and sets the trigger kind to
; $FF. (C2, E-0357; probed E-0376)
StepTriggerReward_GiveItem::
    call ActiveTriggerRecord
    inc hl
    ld a, [hl]
    ld [wStepPtrLo], a
    dec hl
    ld a, [hl]
    or $80
    ld [hl], a
    ld a, $ff
    ld [wTriggerKind], a
    farcall AppendItemStepPtrLoToInventory
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step trigger reward, step 2: gives ten times the trigger's value in gold (AddGoldCapped), marks it
; used and sets the trigger kind to $FF. (C2, E-0357; probed E-0376)
StepTriggerReward_GiveGold::
    call ActiveTriggerRecord
    inc hl
    ld a, [hl]
    push hl
    ld l, a
    ld h, $00
    ld e, a
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    pop hl
    dec hl
    ld a, [hl]
    or $80
    ld [hl], a
    ld a, $ff
    ld [wTriggerKind], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step trigger reward, step 1: after the box closes, goes to the step chosen in step 0
; (wScriptParam0). (C1, E-0357)
StepTriggerReward_WaitMessage::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    ld [wScriptStep], a
    ret

; Step trigger reward, step 0: by the trigger's kind: 0, an item: message 6 then the item (step 3),
; or message 7 when the bag is full (step 5); 1, gold: message 5 with ten times its value (step 2);
; 2, an item: message 2 (step 3) or 3 when full (step 5); others: message 4 and a battle (step 4).
; (C2, E-0357; probed E-0376)
StepTriggerReward_ShowMessage::
    ld hl, wScriptStep
    inc [hl]
    call ActiveTriggerRecord
    ld a, [hl]
    or a
    jr nz, .skip
    ld a, [wInventory + $17]
    cp $ff
    jr z, .next
    cp $00
    jr nz, .next2

.next:
    inc hl
    ld a, [hl]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, $06
    call StartMessageA
    ld a, $03
    ld [wScriptParam0], a
    ret

.next2:
    inc hl
    ld a, [hl]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, $07
    call StartMessageA
    ld a, $05
    ld [wScriptParam0], a
    ret

.skip:
    dec a
    jr nz, .skip2
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    ld e, a
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ld a, $05
    call StartMessageA
    ld a, $02
    ld [wScriptParam0], a
    ret

.skip2:
    dec a
    jr nz, .call_start_message_a
    ld a, [wInventory + $17]
    cp $ff
    jr z, .next3
    cp $00
    jr nz, .next4

.next3:
    inc hl
    ld a, [hl]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, $02
    call StartMessageA
    ld a, $03
    ld [wScriptParam0], a
    ret

.next4:
    inc hl
    ld a, [hl]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, $03
    call StartMessageA
    ld a, $05
    ld [wScriptParam0], a
    ret

.call_start_message_a:
    ld a, $04
    call StartMessageA
    ld a, $04
    ld [wScriptParam0], a
    ret

; Points HL at the active trigger's record: wScreenTriggers + 4 x wTriggerIndex when the screen has
; triggers, otherwise wMapObjects + 8 x wTriggerIndex. (C2, E-0357; probed E-0377)
ActiveTriggerRecord::
    ld a, [wScreenTriggerCount]
    or a
    jr nz, .read_trigger_index
    ld a, [wTriggerIndex]
    add a
    add a
    add a
    ld hl, wMapObjects
    add_a_to_hl
    ret

.read_trigger_index:
    ld a, [wTriggerIndex]
    add a
    add a
    ld hl, wScreenTriggers
    add_a_to_hl
    ret

; Heal the records indexed by wPartyList, for a nonzero wPartyCount: copy each maximum HP/MP word to
; its current HP/MP and clear the entire MON_STATUS byte. Enable SRAM while doing so and disable it
; on return. Does not select a cartridge RAM bank; the caller supplies the bank holding those
; records, normally bank 0. There is no empty-party guard. (C2, E-0359; probed E-0377)
FullyHealParty::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push hl
    ld a, [hl]
    push af
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, MON_HP
    call SRAMRecordAddress
    ldh a, [hTemp0]
    ld [hli], a
    ldh a, [hTemp1]
    ld [hl], a
    pop af
    push af
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, MON_MP
    call SRAMRecordAddress
    ldh a, [hTemp0]
    ld [hli], a
    ldh a, [hTemp1]
    ld [hl], a
    pop af
    ld c, MON_STATUS
    call SRAMRecordAddress
    xor a
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; Use incoming phase bit 2 to alternate four-call palette groups. When set, write DMG bytes
; ($D2,$D2,$E2) and on CGB copy the 64 saved background bytes; otherwise write ($2D,$2D,$1D) and
; complement each saved background byte on CGB. Request background upload $7F only on CGB. Increment
; the eight-bit phase toward exact 30; on equality reset phase and advance. From phase 0 the final
; palette group is the normal copy. Object CGB palettes are not inverted by this body. (C2, E-0362;
; probed E-0377)
ScriptStepFlashScreenNegative::
    ld a, [wScriptParam0]
    srl a
    srl a
    and $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .check_script_param0
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2d
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $1d
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .check_script_param0
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hli]
    xor $ff
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $1e
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Frame counter for a script step: wScriptParam0 += 1; when it then equals B it is reset to 0 and
; carry is set, otherwise carry is clear; A = 0 either way. Ten script steps in this bank call it
; with B = the number of frames to wait before moving on (the same 18 bytes appear in 3 banks). (C2,
; E-0377)
; wScriptParam0 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear;
; returns A = 0 either way (the same 18 bytes appear in 3 banks)
StepScriptParam0Counter_Bank12::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp b
    jr z, .clear_script_param0
    sub a
    ret

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    scf
    ret

; Party defeated return, step 4: the first call hides the followers; the next moves the fallen
; members to the back, reloads the names and sprites and shows the followers again. (C1, E-0357)
PartyDefeatedReturn_MoveFallenBack::
    ld a, [wScriptParam0]
    or a
    jr nz, .call_move_incapacitated_party_members_back
    inc a
    ld [wScriptParam0], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ret

.call_move_incapacitated_party_members_back:
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; [HL] |= $02 (sets bit 1 of the byte at HL); A = the new byte, other registers kept. Its two
; callers, WarpWithFollowers_StaggerDownTo50 and FollowerScene_BeginDown, set bit 1 of
; hPlayerStateFlags with it (the same 5 bytes appear in 4 banks). (C2, E-0377)
; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
SetBit1AtHL_Bank12::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

; [HL] &= $FD (clears bit 1 of the byte at HL); A = the new byte, other registers kept. Its one
; caller in this bank clears bit 1 of hPlayerStateFlags with it (the same 5 bytes appear in 4
; banks). (C2, E-0377)
; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit1AtHL_Bank12::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; [HL] |= $04 (sets bit 2 of the byte at HL); A = the new byte, other registers kept. Steps of this
; bank set bit 2 of hPlayerStateFlags (ObjectPath1C_HopPlayerRight and others) or of the sprite flag
; bytes (wSpriteSlots + $D, wObject1 + OBJ_FLAGS and the next objects) with it. (C2, E-0377)
; sets bit 2 of the byte at [HL]; only A is clobbered
SetBit2AtHL_B12::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

; [HL] &= $FB (clears bit 2 of the byte at HL); A = the new byte, other registers kept. Callers in
; this bank clear bit 2 of hPlayerStateFlags (FinishObjectPath) or of the sprite flag bytes
; (wSpriteSlots + $D, wObject1 + OBJ_FLAGS and the next objects) with it (the same 5 bytes appear in
; 4 banks). (C2, E-0377)
; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit2AtHL_Bank12::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

; Use incoming A low four bits as the tile-boundary test: when they are zero, far-call
; SetFollowerTargetsFromLeader in bank $02 to capture the current leader chain positions. Always
; far-call StepFollowersTowardTargets afterward. A controls only whether targets refresh; it is not
; copied into a coordinate. All three records are processed regardless of party count, and the
; banked calls restore the calling bank. (C2, E-0361; probed E-0377)
; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls
; SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same
; 17 bytes appear in 3 banks)
UpdateFollowersOnStep_Bank12::
    and $0f
    jr nz, .call_step_followers_toward_targets
    farcall SetFollowerTargetsFromLeader

.call_step_followers_toward_targets:
    farcall StepFollowersTowardTargets
    ret

; The bank-$12 message box runner, one frame per call: A = the freeze flag, kept on the stack (0
; freezes the field animation in state 0 and resumes it in state 3). Returns at once while
; wMessageState is $FF (idle); otherwise runs state wMessageState: 0 RunMessageBox_Bank12_Open, 1
; RunMessageBox_Bank12_ShowText (string wMessageIndex of category 1), 2 RunMessageBox_Bank12_Close
; and 3 RunMessageBox_Bank12_Finish, which sets $FF again. wMessageGroup bit 7 (box already open)
; and bit 6 (keep it open) steer states 0 and 2. Only RunMessageBoxCarryWhenIdle_Bank12 calls it.
; (C2, E-0377)
; the bank-$12 message runner: the same four states as RunMessageBox, with A on the stack as the
; freeze flag instead of wStepPtrLo (state 0 also reads hMapId; not compared in full) (E-0079)
RunMessageBox_Bank12::
    push af
    ld a, [wMessageState]
    cp $ff
    jr nz, .skip
    pop af
    ret

.skip:
    jumptable
    dw RunMessageBox_Bank12_Open
    dw RunMessageBox_Bank12_ShowText
    dw RunMessageBox_Bank12_Close
    dw RunMessageBox_Bank12_Finish

; Bank-$12 message box, state 0: unless the flag on the stack is set, freezes the player's and
; objects' animation (FreezeFieldAnimation); unless wMessageGroup bit 7 says the box is open, clears
; its tiles, plays sound $69 and opens the window at the bottom (or at the top when the player is
; low on the screen, Y $48 or more), sprite clip mode 2 except on map $14. (C1, E-0357)
RunMessageBox_Bank12_Open::
    pop af
    or a
    jr nz, .check_message_group
    farcall FreezeFieldAnimation

.check_message_group:
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, .done
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ldh a, [hMapId]
    cp $14
    jr z, .check_player_y
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.check_player_y:
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Bank-$12 message box, state 1: once the window is open, starts string wMessageIndex of category 1
; (BeginStringDisplay_Bank09). (C1, E-0357)
RunMessageBox_Bank12_ShowText::
    pop af
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; Bank-$12 message box, state 2: when the text has finished, goes idle at once if wMessageGroup bit
; 6 keeps the box open; otherwise plays sound $69 and closes the window. (C2, E-0357; probed E-0377)
RunMessageBox_Bank12_Close::
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr z, .call_queue_sound_effect
    ld a, $ff
    ld [wMessageState], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Final state (3) shared by the bank-$12 message runners (RunMessageBox_Bank12,
; RunMessageBoxStateIfActive_Bank12 and KeyWorldBossBattle_RunMessageBoxState): once the window is
; closed (wTextWindowState low bits 0), unfreezes the animation unless the flag on the stack is set
; and sets wMessageState to $FF (idle). (C2, E-0370; probed E-0377)
RunMessageBox_Bank12_Finish::
    ld a, [wTextWindowState]
    and $03
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    or a
    jr nz, .set_message_state_to_FF
    farcall ResumeFieldAnimation

.set_message_state_to_FF:
    ld a, $ff
    ld [wMessageState], a
    ret

; The bank-$12 short message box runner, one frame per call: as RunMessageBox_Bank12 (A = the freeze
; flag on the stack, nothing while wMessageState is $FF), but its box flags are in wMessageIndex
; (bit 7 box already open, bit 6 keep it open) and the string is wMessageIndex & $3F of category 9.
; States: RunMessageBoxStateIfActive_Bank12_Open, RunMessageBoxStateIfActive_Bank12_ShowText,
; RunMessageBoxStateIfActive_Bank12_Close, then RunMessageBox_Bank12_Finish. Only
; RunMessageBoxThenContinue calls it. (C2, E-0377)
; unless wMessageState is $FF (idle), runs the message box step for wMessageState (jump table)
; (E-0122)
RunMessageBoxStateIfActive_Bank12::
    push af
    ld a, [wMessageState]
    cp $ff
    jr nz, .skip
    pop af
    ret

.skip:
    jumptable
    dw RunMessageBoxStateIfActive_Bank12_Open
    dw RunMessageBoxStateIfActive_Bank12_ShowText
    dw RunMessageBoxStateIfActive_Bank12_Close
    dw RunMessageBox_Bank12_Finish

; Bank-$12 short message box, state 0: as the message box's state 0, with the box-open flag in
; wMessageIndex bit 7. (C1, E-0357)
RunMessageBoxStateIfActive_Bank12_Open::
    pop af
    or a
    jr nz, .check_message_index
    farcall FreezeFieldAnimation

.check_message_index:
    ld a, [wMessageIndex]
    bit 7, a
    jr nz, .done
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Bank-$12 short message box, state 1: once the window is open, starts string wMessageIndex & $3F of
; category 9 (BeginStringDisplay_Bank09). (C1, E-0357)
RunMessageBoxStateIfActive_Bank12_ShowText::
    pop af
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wMessageIndex]
    and $3f
    ld [wStringIndex], a
    ld a, $09
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; Bank-$12 short message box, state 2: when the text has finished, goes idle if wMessageIndex bit 6
; keeps the box open; otherwise sound $69 and closes the window. (C2, E-0357; probed E-0377)
RunMessageBoxStateIfActive_Bank12_Close::
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageIndex]
    bit 6, a
    jr z, .call_queue_sound_effect
    ld a, $ff
    ld [wMessageState], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; The key world's message box: unless idle, runs its state (four states: open, text from bank $8A,
; close, finish) by wMessageState. (C1, E-0357)
KeyWorldBossBattle_RunMessageBoxState::
    push af
    ld a, [wMessageState]
    cp $ff
    jr nz, .skip
    pop af
    ret

.skip:
    jumptable
    dw KeyWorldBossBattle_OpenMessageBox
    dw KeyWorldBossBattle_StartMessageText
    dw KeyWorldBossBattle_CloseMessageBox
    dw RunMessageBox_Bank12_Finish

; Key world message box, state 0: freezes the animation unless the flag is set, clears the box tiles
; and opens the window (at the top when the player is low), with no sound. (C1, E-0357)
KeyWorldBossBattle_OpenMessageBox::
    pop af
    or a
    jr nz, .call_fill_tiles_request
    farcall FreezeFieldAnimation

.call_fill_tiles_request:
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Key world message box, state 1: once the window is open, starts string wMessageIndex of category 0
; in bank $8A (BeginStringDisplay_Bank8A). (C1, E-0357)
KeyWorldBossBattle_StartMessageText::
    pop af
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ld hl, wMessageState
    inc [hl]
    ret

; Key world message box, state 2: when the text has finished, closes the window (no sound). (C2,
; E-0357; probed E-0377)
KeyWorldBossBattle_CloseMessageBox::
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Starts a message box: wMessageIndex = L and wMessageGroup = H (the message word: H bits 0-5 the
; group, bits 6-7 the box flags), wMessageState = 0 so the next RunMessageBoxFar_Bank12 call opens
; it; returns A = 0. KeyWorldBossBattle_ShowWarubouWaheyNoGood, KeyWorldBossBattle_ShowMessage,
; KeyWorldFloorBattle_ShowWarubouWaheyThatWas and KeyWorldFloorBattle_ShowMessage call it (the same
; 13 bytes as StartMessageHL_B0F). (C2, E-0377)
; the same 13 bytes as StartMessageHL_B0F (StartMessageHL_B0F) (E-0353)
StartMessageHL_B0F_Bank12::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; Starts string A: wMessageIndex = A and wMessageState = 0, so the next message box call opens the
; window and shows it; wMessageGroup is left as it is (its bits 7 and 6 are the box flags that
; RunMessageBox_Bank12 reads). Returns A = 0. The script steps of this bank call it before running
; the box with RunMessageBoxCarryWhenIdle_Bank12. (C2, E-0377)
; wMessageIndex = A, wMessageState = 0: the next RunMessageBox call opens the window and shows that
; string of the group already in wMessageGroup (E-0063, E-0079)
StartMessageA::
    ld [wMessageIndex], a
    xor a
    ld [wMessageState], a
    ret

; One frame of the bank-$5F message box: wStepPtrLo = A (the freeze flag of RunMessageBox: 0 freezes
; the field animation while the box is shown), far-calls RunMessageBox, then returns carry set once
; wMessageState is $FF (idle), otherwise A = 0 and carry clear. KeyWorldBossBattle_StartBattle and
; KeyWorldFloorBattle_StartBattle call it with A = 0 (the same 20 bytes appear in 4 banks). (C1,
; E-0377)
; wStepPtrLo = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A =
; 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
RunMessageBoxFar_Bank12::
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp $ff
    jr z, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; One frame of the bank-$12 message box: RunMessageBox_Bank12 with A = the freeze flag, then falls
; into RunMessageBoxCarryWhenIdle_Bank12_CheckIdle: carry set once wMessageState is $FF (idle),
; otherwise A = 0 and carry clear. Eleven script steps in this bank (CountdownMessage_Finish,
; MonsterScene_WaitMessage and others) call it each frame with A = 0, after a step started the
; message, and move on when carry is set. (C1, E-0377)
; RunMessageBox_Bank12 (A = the freeze flag), then carry set when wMessageState = $FF (idle), else A
; = 0 and carry clear (E-0079)
RunMessageBoxCarryWhenIdle_Bank12::
    call RunMessageBox_Bank12

; Returns carry when the message box is idle (wMessageState $FF), otherwise A = 0 and no carry. (C2,
; E-0357; probed E-0377)
RunMessageBoxCarryWhenIdle_Bank12_CheckIdle::
    ld a, [wMessageState]
    cp $ff
    jr z, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; One frame of the short message box: RunMessageBoxStateIfActive_Bank12 with A = the freeze flag,
; then RunMessageBoxCarryWhenIdle_Bank12_CheckIdle: carry set once wMessageState is $FF (idle),
; otherwise A = 0 and carry clear. Four script steps in this bank call it. (C1, E-0377)
; runs RunMessageBoxStateIfActive_Bank12, then continues at
; RunMessageBoxCarryWhenIdle_Bank12_CheckIdle (E-0126) (E-0344: the address in its name dropped or
; read as the label there; was RunMessageBoxThenContinue)
RunMessageBoxThenContinue::
    call RunMessageBoxStateIfActive_Bank12
    jr RunMessageBoxCarryWhenIdle_Bank12_CheckIdle

; Runs the key world message box, then returns carry when it is idle. (C1, E-0357)
KeyWorldBossBattle_RunMessageBox::
    call KeyWorldBossBattle_RunMessageBoxState
    jr RunMessageBoxCarryWhenIdle_Bank12_CheckIdle

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 x (C / 8) + B / 8 (rows of 20 entries);
; copies that entry and the next to wTilesUnderPoint and wTilesUnderPoint + $1, and the two entries
; below them to wTilesUnderPoint + $2 and + $3; returns HL on the bottom-right entry, BC kept.
; FieldScene01_Variant2_RideUntilLand calls it; ReadTileBuffer2x2AtPixel_Bank12 is an identical copy
; in this bank (the same 63 bytes appear in 3 banks). (C2, E-0377)
; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries);
; copies the 2 x 2 entries there to wTilesUnderPoint, wTilesUnderPoint + $1 (top row) and
; wTilesUnderPoint + $2, wTilesUnderPoint + $3 (bottom row); HL ends on the bottom-right entry
; (E-0064) (the same 63 bytes appear in 3 banks)
ReadTileBuffer2x2AtPixel_Bank12_2::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld a, [hli]
    ld [wTilesUnderPoint], a
    ld a, [hld]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hli]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ret

; Draws the trigger marker and the scene object for the frame: DrawTriggerMarkerSprite, then
; RunDrawTriggerMarkerSprite_DrawSceneObject (wObject5 when its bit 6 is set). Six field states in
; bank $02 far-call it each frame after DrawFieldSprites. (C1, E-0377)
; runs DrawTriggerMarkerSprite and RunDrawTriggerMarkerSprite_DrawSceneObject; shared by the field
; mode states (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; RunDrawTriggerMarkerSprite)
RunDrawTriggerMarkerSprite::
    call DrawTriggerMarkerSprite
    call RunDrawTriggerMarkerSprite_DrawSceneObject
    ret

; Adds a generated key: clears wKeyRetryCount, takes the first free wKeyList slot
; (FindFreeKeySlotToTemp0; with none it returns hTemp0 = 0) and writes kind $FE there
; (WriteKeyEntryTemp0: level from the party strength, bytes 1-2 rolled). An earlier generated key
; (byte 3 bit 7 clear) with the same byte 2 makes it erase the entry and roll again: always when
; byte 1 also matches, and otherwise while the incremented wKeyRetryCount is below 20. Then hTemp0 =
; 1, the seed wKeyRandomLo/Hi is saved at wKeySeeds + 2 x hTempA, and wInventorySortFlags bit 7 is
; set. hTempA is only set to the slot when it is not 0, so a key in slot 0 saves its seed at the
; index left in hTempA. Called by talk events (the Magic Key chests), the library and arena code and
; scenes. (C2, E-0377)
; writes a generated key (kind $FE) into a free key slot, rerolling while it duplicates an existing
; key, and saves the random seed in wKeySeeds; hTemp0 = 1, or 0 when the list is full (E-0129)
GenerateNewKeyEntry::
    xor a
    ld [wKeyRetryCount], a

.call_find_free_key_slot_to_temp0:
    call FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_FE
    xor a
    ldh [hTemp0], a
    ret

.set_temp1_to_FE:
    push af
    ld a, $fe
    ldh [hTemp1], a
    call WriteKeyEntryTemp0
    pop af
    or a
    jr z, .set_temp0_to_01
    ldh [hTempA], a
    ld b, a
    ld hl, wKeyList + $3

.loop:
    push hl
    ld a, [hld]
    bit 7, a
    jr nz, .restore
    ld a, [hld]
    ld c, a
    ldh a, [hTemp2]
    cp c
    jr nz, .restore
    ld a, [hl]
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr nz, .check_key_retry_count
    pop hl

.loop2:
    ldh a, [hTempA]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    jr .call_find_free_key_slot_to_temp0

.check_key_retry_count:
    pop hl
    ld a, [wKeyRetryCount]
    inc a
    ld [wKeyRetryCount], a
    cp $14
    jr c, .loop2
    jr .set_temp0_to_01

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, .loop

.set_temp0_to_01:
    ld a, $01
    ldh [hTemp0], a
    ldh a, [hTempA]
    add a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [wKeyRandomLo]
    ld [hli], a
    ld a, [wKeyRandomHi]
    ld [hl], a
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ret

; hTemp0 = the index of the first free wKeyList entry (byte 0 = $FF), or $80 when the 32 entries are
; all used or 20 of the entries before the free one are generated keys (byte 3 bit 7 clear; entries
; with bit 7 set are not counted). GenerateNewKeyEntry and two key events in bank $0D call it. (C2,
; E-0377)
; hTemp0 = the index of the first free wKeyList entry, or $80 when none is free or 20 entries lack
; bit 7 of byte 3 (E-0125)
FindFreeKeySlotToTemp0::
    ld b, $00
    ld d, $00
    ld hl, wKeyList

.loop:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .set_temp0
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, .restore
    inc d

.restore:
    pop hl
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp $20
    jr nz, .loop
    ld a, $80
    ldh [hTemp0], a
    ret

.set_temp0:
    pop hl
    ld a, b
    ldh [hTemp0], a
    ld a, d
    cp $14
    ret nz
    ld a, $80
    ldh [hTemp0], a
    ret

; Writes key entry hTemp0 of wKeyList with kind hTemp1 in byte 0. For a kind other than $FE byte 3
; becomes $80 and bytes 1-2 are left as they were. For kind $FE (a generated key) it far-calls
; ComputePartyStrengthForKey and RollKeyContentsForLevelTemp0 with hTemp0 = wPartyStrength, then
; writes hTemp1, hTemp2 and hTemp3 (the rolled name bytes and the level) to bytes 1-3. hTemp0 is
; overwritten in that case. Called by GenerateNewKeyEntry and key events in banks $04, $0C, $0F,
; $13, $73 and others. (C2, E-0377)
; writes key entry hTemp0: byte 0 = hTemp1 and byte 3 = $80; for kind $FE generates the remaining
; bytes (ComputePartyStrengthForKey, RollKeyContentsForLevelTemp0) from hTemp1-hTemp3 (E-0125)
WriteKeyEntryTemp0::
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    push hl
    ldh a, [hTemp1]
    ld [hl], a
    cp $fe
    jr z, .call_compute_party_strength_for_key
    pop hl
    inc hl
    inc hl
    inc hl
    ld [hl], $80
    ret

.call_compute_party_strength_for_key:
    farcall ComputePartyStrengthForKey
    ld a, [wPartyStrength]
    ldh [hTemp0], a
    farcall RollKeyContentsForLevelTemp0
    pop hl
    inc hl
    ldh a, [hTemp1]
    ld [hli], a
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hl], a
    ret

; hTemp0 = the number of wKeyList entries before the first one whose byte 0 is $FF, or $80 when all
; 32 entries are used. Key events in banks $04, $0C, $0F, $13, $73 and others call it before giving
; a key. (C2, E-0377)
; counts the 4-byte wKeyList entries before the first $FF: hTemp0 = the count, or $80 when all 32
; are in use (E-0074)
CountKeysOrFull::
    ld b, $00
    ld hl, wKeyList

.loop:
    ld a, [hl]
    cp $ff
    jr z, .set_temp0
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp $20
    jr nz, .loop
    ld a, $80
    ldh [hTemp0], a
    ret

.set_temp0:
    ld a, b
    ldh [hTemp0], a
    ret

; Removes key entry hTemp0: far-calls ClearKeyWorldActiveForMatchingKeyEntry (the and $7F before the
; bit 7 test makes this unconditional); when the kind byte has bit 7 set and is not $FE, writes $FF
; at SRAM bank 2 $A000 + $195 x (kind & $1F) with SRAM enabled, then sets rRAMG and rRAMB to 0. It
; then moves the later entries and their wKeySeeds pairs down one place and sets the last entry to
; $FF (the last seed pair is left); for entry $1F only the last entry is cleared. wCurrentKeyIndex
; drops by 1 when it was above hTemp0. Called by the pause menu (bank $03) and the link code in bank
; $1B. (C2, E-0377)
; removes key entry hTemp0: clears the matching wKeyWorldActive link, marks its SRAM-bank-2 slot
; free and shifts the later entries down (E-0130)
DeleteKeyEntryTemp0::
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    and $7f
    cp $06
    jr c, .call_clear_key_world_active_for_matching_key
    bit 7, a
    ret nz

.call_clear_key_world_active_for_matching_key:
    push hl
    farcall ClearKeyWorldActiveForMatchingKeyEntry
    pop hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp $fe
    jr z, .check_temp0
    bit 7, a
    jr z, .check_temp0
    and $1f
    push af
    ld a, $02
    ld [rRAMB], a
    pop af
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $a0
    ld h, a
    ld a, $0a
    ld [rRAMG], a
    ld a, $ff
    ld [hl], a
    xor a
    ld [rRAMG], a
    ld [rRAMB], a

.check_temp0:
    ldh a, [hTemp0]
    cp $1f
    jr nz, .skip
    ld hl, wKeyList + $7c
    jr .skip2

.skip:
    push af
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    pop af
    ld c, a
    ld a, $1f
    sub c
    ld b, a

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop

.skip2:
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ldh a, [hTemp0]
    cp $1f
    jr z, .read_current_key_index
    ld c, a
    add a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, $1f
    sub c
    ld b, a

.loop2:
    ld e, l
    ld d, h
    inc de
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    dec b
    jr nz, .loop2

.read_current_key_index:
    ld a, [wCurrentKeyIndex]
    ld c, a
    ldh a, [hTemp0]
    cp c
    ret nc
    ld hl, wCurrentKeyIndex
    dec [hl]
    ret

; On screen entry (two map-load paths in bank $02 far-call it after the screen is drawn): on map $7F
; or $92 at screen (0, 0) outside the special map types, or on map type $82, runs field command $12
; (RunFieldCommandTemp0, which loads the scene-object sprite of
; RunFieldCommandTemp0_LoadSceneObject18) and shows the scene object: wObject5 = $40 (bit 6, drawn
; by RunDrawTriggerMarkerSprite_DrawSceneObject) at ($40, $10) on map $7F, ($40, $40) on map $92 and
; ($40, $30) on map type $82. (C1, E-0377)
; on map $7F or $92 at screen (0, 0), or with wMapType = $82, runs field command $12 and places
; objects at wObject5 + $4/4 and wObject5 (E-0127)
PlaceSpecialMapObjectsOnEntry::
    ld a, [wMapType]
    bit 7, a
    jr nz, .check_map_type
    ldh a, [hMapId]
    cp $7f
    jr nz, .check_map_id
    ldh a, [hMapScreenX]
    or a
    jr nz, .check_map_id
    ldh a, [hMapScreenY]
    or a
    jr nz, .check_map_id
    ld a, $12
    ldh [hTemp0], a
    call RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $10
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $40
    ld [wObject5], a
    ret

.check_map_id:
    ldh a, [hMapId]
    cp $92
    ret nz
    ldh a, [hMapScreenX]
    or a
    ret nz
    ldh a, [hMapScreenY]
    or a
    ret nz
    ld a, $12
    ldh [hTemp0], a
    call RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $40
    ld [wObject5], a
    ret

.check_map_type:
    ld a, [wMapType]
    cp $82
    ret nz
    ld a, $12
    ldh [hTemp0], a
    call RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $40
    ld [wObject5], a
    ret

; Loads the floating scene sprite drawn by DrawAnimatedMetaSprite1B: decompresses Tiles0Plus700Gfx
; (bank $7E) to vTiles0 + $300 when hTemp0 is 0, or to vTiles0 + $700 otherwise, and sets
; wSpriteFloatY = $30. On CGB it copies the 8 palette bytes at SharedOBJPalettes + $D8 (bank $7E) to
; wOBJPaletteBuffer + $18 (OBJ palette 3) or + $38 (palette 7) and sets wOBJPaletteUploadRequest =
; $7F. BossWinScene_LoadSprites (bank $5F) far-calls it with hTemp0 = 1 and a scene in bank $73 with
; hTemp0 = 0. (C1, E-0377)
; decompresses Tiles0Plus700Gfx to vTiles0 + $300 (or + $700 when hTemp0 is set), wSpriteFloatY =
; $30, and on CGB copies an 8-byte palette from bank $7E (E-0125) (E-0344: the address in its name
; dropped or read as the label there; was LoadSpriteGraphics7EToTiles0)
LoadSpriteGraphics7EToTiles0::
    ldh a, [hTemp0]
    or a
    jr nz, .skip
    ld hl, vTiles0 + $300
    jr .call_decompress_to_vram

.skip:
    ld hl, vTiles0 + $700

.call_decompress_to_vram:
    ld de, Tiles0Plus700Gfx
    ld b, $7e
    call DecompressToVRAM
    ld a, $30
    ld [wSpriteFloatY], a
    ld a, [wIsCGB]
    or a
    ret z
    ldh a, [hTemp0]
    or a
    jr nz, .skip2
    ld a, $18
    jr .skip3

.skip2:
    ld a, $38

.skip3:
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld a, $d8
    ld de, LoadPlayerAndFollowerSpriteGraphics_OBJPaletteBufferData
    add e
    ld e, a
    jr nc, .call_copy_from_bank
    inc d

.call_copy_from_bank:
    ld b, $7e
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; wSpriteFloatY -= 2; when the result is $C0 or more (it went below 0) it becomes $30 again, so the
; floating sprite moves up 2 pixels a call and restarts at $30. Scene steps in banks $5F and $73
; far-call it each frame before DrawAnimatedMetaSprite1B. (C2, E-0377)
; wSpriteFloatY -= 2, and when the result is $C0 or more it becomes $30 (E-0117)
CycleSpriteFloatYDown::
    ld a, [wSpriteFloatY]
    dec a
    dec a
    ld [wSpriteFloatY], a
    cp $c0
    ret c
    ld a, $30
    ld [wSpriteFloatY], a
    ret

; Draws meta-sprite set $1B (DrawMetaSprite) for the sprite LoadSpriteGraphics7EToTiles0 loaded:
; hTemp0 = 0 uses tile offset $30 and attribute bits 3, otherwise $70 and 7. The sub-index is
; DrawAnimatedMetaSprite1B_Data[the frame counter wFrameCounterLo/Hi modulo 30] (DivideHLByA returns
; the remainder in A): 0 for remainders 0-9, 1 for 10-19, 2 for 20-29. The origin is ($48,
; wSpriteFloatY + $10). Scene steps in banks $5F and $73 far-call it after CycleSpriteFloatYDown.
; (C1, E-0377)
; draws metasprite set $1B with a frame from DrawAnimatedMetaSprite1B_Data chosen by the frame
; counter / 30, at ($48, wSpriteFloatY + $10) (E-0125)
DrawAnimatedMetaSprite1B::
    ldh a, [hTemp0]
    or a
    jr nz, .set_sprite_tile_offset_to_70
    ld a, $30
    ldh [hSpriteTileOffset], a
    ld a, $03
    ldh [hSpriteAttrXor], a
    jr .read_frame_counter_lo

.set_sprite_tile_offset_to_70:
    ld a, $70
    ldh [hSpriteTileOffset], a
    ld a, $07
    ldh [hSpriteAttrXor], a

.read_frame_counter_lo:
    ld a, [wFrameCounterLo]
    ld l, a
    ld a, [wFrameCounterHi]
    ld h, a
    ld a, $1e
    call DivideHLByA
    ld hl, DrawAnimatedMetaSprite1B_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ld a, $1b
    ldh [hSpriteSetIndex], a
    ld a, $40
    add $08
    ldh [hSpriteOriginX], a
    ld a, [wSpriteFloatY]
    add $10
    ldh [hSpriteOriginY], a
    farcall DrawMetaSprite
    ret

; data read by DrawAnimatedMetaSprite1B (30 bytes) (E-0347)
DrawAnimatedMetaSprite1B_Data::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

; Dispatch the field-effect command in hTemp0 (valid indexes 0-21, without a bounds check). In the
; link/breeding presentation, commands $0D and $0E share the placement setter for object 5 but
; select their own graphics records. Scene and map-entry callers use this same command interface.
; (C1, E-0360)
RunFieldCommandTemp0::
    ldh a, [hTemp0]
    jumptable
    dw RunFieldCommandTemp0_LoadSceneObject0
    dw RunFieldCommandTemp0_LoadSceneObject1
    dw RunFieldCommandTemp0_LoadSceneObject2
    dw RunFieldCommandTemp0_LoadSceneObject3
    dw RunFieldCommandTemp0_LoadSceneObject4
    dw RunFieldCommandTemp0_LoadSceneObject5
    dw RunFieldCommandTemp0_LoadSceneObject6
    dw RunFieldCommandTemp0_LoadSceneObject7
    dw RunFieldCommandTemp0_LoadSceneObject8
    dw RunFieldCommandTemp0_LoadSceneObject9
    dw RunFieldCommandTemp0_LoadSceneObject10
    dw RunFieldCommandTemp0_LoadSceneObject11
    dw RunFieldCommandTemp0_LoadSceneObject12
    dw RunFieldCommandTemp0_LoadSceneObject13
    dw RunFieldCommandTemp0_LoadSceneObject13
    dw RunFieldCommandTemp0_LoadSceneObject15
    dw RunFieldCommandTemp0_LoadSceneObject16
    dw RunFieldCommandTemp0_LoadSceneObject17
    dw RunFieldCommandTemp0_LoadSceneObject18
    dw RunFieldCommandTemp0_LoadSceneObject19
    dw RunFieldCommandTemp0_LoadSceneObject20
    dw RunFieldCommandTemp0_LoadSceneObject20

; Field command 20: the scene object (wObject5) gets the command's sprite (tile $40, palette 4) at
; ($40, $40), shown, its animation reset. (C1, E-0357)
; (renamed from RunFieldCommandTemp0_ShowSceneObject from its E-0357 note, E-0367)
RunFieldCommandTemp0_LoadSceneObject20::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $40
    ld a, $80
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 19: the scene object (wObject5) gets the command's sprite at tile $30 with palette 3
; (RunFieldCommandTemp0_LoadGfxPalette3), hidden, position left as it was. (C1, E-0370)
RunFieldCommandTemp0_LoadSceneObject19::
    call RunFieldCommandTemp0_LoadGfxPalette3
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    xor a
    ld [wObject5], a
    ret

; Field command 18: the scene object gets the command's sprite (tile $40, palette 4), hidden,
; position left as it was, its animation reset. (C1, E-0357)
; (renamed from RunFieldCommandTemp0_LoadSceneObject from its E-0357 note, E-0367)
RunFieldCommandTemp0_LoadSceneObject18::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 17: the scene object gets the command's sprite (tile $40, palette 4), hidden,
; position left as it was, its animation reset. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject17::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 16: the scene object gets the command's sprite (tile $40, palette 4) at ($30, $40),
; hidden. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject16::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $40
    xor a
    ld [wObject5], a
    ret

; Field command 15: the scene object gets the command's sprite (tile $40, palette 4) at ($40, $E0),
; hidden. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject15::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $e0
    xor a
    ld [wObject5], a
    ret

; Placement shared by field commands $0D/$0E: load the selected effect graphics, then set object 5
; tile offset $30, sprite-set selector from returned A, attributes 3 and position ($50,$3C). Show it
; with byte 0 = $80 and clear the final two object bytes. Graphics differ by the incoming command
; even though placement is shared. (C1, E-0360)
RunFieldCommandTemp0_LoadSceneObject13::
    call RunFieldCommandTemp0_LoadGfxPalette3
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    inc hl
    ld a, $50
    ld [hl], a
    inc hl
    ld a, $3c
    ld [hl], a
    ld a, $80
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 12: the scene object gets the command's sprite (tile $40, palette 4) at ($78, $50),
; hidden, its animation reset. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject12::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld a, $78
    ld [hl], a
    inc hl
    ld a, $50
    ld [hl], a
    xor a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 11: the scene object gets the command's sprite (tile $40, palette 4) at the player's
; position, hidden, its animation reset. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject11::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ldh a, [hPlayerX]
    ld [hl], a
    inc hl
    ldh a, [hPlayerY]
    ld [hl], a
    xor a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 10: the scene object gets the command's sprite (tile $40, palette 4) at ($40, $E0),
; hidden. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject10::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $e0
    xor a
    ld [wObject5], a
    ret

; Field command 9: the scene object gets the command's sprite (tile $40, palette 4) at ($40, $E0),
; shown (above the screen until moved). (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject9::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $e0
    ld a, $80
    ld [wObject5], a
    ret

; Field command 8: the scene object gets the command's sprite (tile $40, palette 4) at ($50, $30),
; hidden. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject8::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $50
    inc hl
    ld [hl], $30
    xor a
    ld [wObject5], a
    ret

; Field command 7: the scene object gets the command's sprite (tile $40, palette 4) at ($30, $E0),
; shown (above the screen until moved). (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject7::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $e0
    ld a, $80
    ld [wObject5], a
    ret

; Field command 6: the scene object gets the command's sprite (tile $40, palette 4) at ($40, $70),
; shown, its animation reset. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject6::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $70
    ld a, $80
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; Field command 5: the scene object gets the command's sprite (tile $40, palette 4) at ($40, 0),
; shown. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject5::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $00
    ld a, $80
    ld [wObject5], a
    ret

; Field command 4: the scene object gets the command's sprite (tile $40, palette 4) at ($50, $30),
; hidden. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject4::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $50
    inc hl
    ld [hl], $30
    xor a
    ld [wObject5], a
    ret

; Field command 3: the scene object gets the command's sprite (tile $40, palette 4), hidden,
; position left as it was. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject3::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a
    ld [wObject5], a
    ret

; Field command 2: the scene object gets the command's sprite (tile $40, palette 4) at ($40, $30),
; hidden. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject2::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $30
    xor a
    ld [wObject5], a
    ret

; Field command 1: the scene object gets the command's sprite (tile $40, palette 4), hidden,
; position left as it was. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject1::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a
    ld [wObject5], a
    ret

; Field command 0: the scene object gets the command's sprite (tile $40, palette 4) at ($60, $40),
; shown. (C1, E-0357)
RunFieldCommandTemp0_LoadSceneObject0::
    call RunFieldCommandTemp0_LoadGfxPalette4
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $60
    inc hl
    ld [hl], $40
    ld a, $80
    ld [wObject5], a
    ret

; hTemp0 selects a four-byte FieldCommandSpriteTable record after masking bit 7 and multiplying by
; four with byte wrap. Decompress the bank-$7E pointer to VRAM $8400. On CGB copy eight palette
; bytes indexed by record byte 2 low seven bits into object palette slot 4 and request upload.
; Return complete record byte 2 in A, just like the $8300/slot-3 variant; the trailing record byte
; is not consumed by either reader. (C1, E-0360)
RunFieldCommandTemp0_LoadGfxPalette4::
    ldh a, [hTemp0]
    and $7f
    add a
    add a
    ld hl, FieldCommandSpriteTable
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    push hl
    ld b, $7e
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    pop hl
    push hl
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, [hl]
    and $7f
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $bd
    ld e, a
    ld a, d
    adc $4b
    ld d, a
    ld b, $7e
    ld a, $20
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.done:
    pop hl
    ld a, [hl]
    ret

; hTemp0 selects a four-byte FieldCommandSpriteTable record: mask bit 7, multiply the remaining byte
; by four with byte wrap and add it to the table. Decompress its pointer from bank $7E into VRAM
; $8300. On CGB use record byte 2 low seven bits to select eight palette bytes at $7E:$4BBD +
; 8*index, copy them to object palette slot 3 and request upload. Return the complete record byte 2
; in A for the caller's sprite-set selector. (C1, E-0360)
RunFieldCommandTemp0_LoadGfxPalette3::
    ldh a, [hTemp0]
    and $7f
    add a
    add a
    ld hl, FieldCommandSpriteTable
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    push hl
    ld b, $7e
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    pop hl
    push hl
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, [hl]
    and $7f
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $bd
    ld e, a
    ld a, d
    adc $4b
    ld d, a
    ld b, $7e
    ld a, $18
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.done:
    pop hl
    ld a, [hl]
    ret

; Unless wFieldActionRequest bit 7 is set, draws the scene object (wObject5) when its bit 6 is set,
; through DrawFieldSprites' entry drawing (DrawFieldSprites_DrawEntry with DE = wObject5); runs each
; field frame after DrawTriggerMarkerSprite. (C1, E-0370)
RunDrawTriggerMarkerSprite_DrawSceneObject::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld de, wObject5
    ld a, [de]
    bit 6, a
    ret z
    jr DrawFieldSprites_DrawEntry

; Draws the script meta-sprite object: returns when wFieldActionRequest bit 7 is set or wObject5 bit
; 7 is clear; otherwise falls into DrawFieldSprites_DrawEntry with DE = wObject5, which draws that
; one entry: tile offset SCRIPTOBJ_TILE_OFFSET, set SCRIPTOBJ_SPRITE_SET & $7F (sub-index from
; DrawFieldSprites_AnimateSubIndex when bit 7 is set, else 0), attribute bits SCRIPTOBJ_ATTR, origin
; SCRIPTOBJ_X + 8 and SCRIPTOBJ_Y + $10 plus the 16-bit scroll, one DrawMetaSprite call. Six field
; states in bank $02 and screens in banks $24, $F1 and $F2 far-call it each frame. (C1, E-0377)
; unless the map is loading or wObject5 bit 7 is clear: reads the sprite entries starting at
; wObject5 (tile offset, set index with bit 7 selecting a sub index, attribute, position bytes),
; sets the hSprite inputs and 16-bit positions from them plus the scroll, and draws each with
; DrawMetaSprite
DrawFieldSprites::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld de, wObject5
    ld a, [de]
    bit 7, a
    ret z

; Draws one sprite entry at DE: its tile offset, sprite set (with an animated sub-index when bit 7
; is set), attribute bits, and the origin at its position plus (8, 16) and the scroll. (C1, E-0357)
DrawFieldSprites_DrawEntry::
    inc de
    ld a, [de]
    ldh [hSpriteTileOffset], a
    inc de
    ld a, [de]
    and $7f
    ldh [hSpriteSetIndex], a
    ld a, [de]
    bit 7, a
    jr z, .clear_sprite_sub_index
    call DrawFieldSprites_AnimateSubIndex
    jr .set_sprite_attr_xor

.clear_sprite_sub_index:
    xor a
    ldh [hSpriteSubIndex], a

.set_sprite_attr_xor:
    inc de
    ld a, [de]
    ldh [hSpriteAttrXor], a
    ld l, e
    ld h, d
    inc hl
    ld a, [hl]
    add $08
    ld d, a
    ldh a, [hScrollX]
    add d
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hSpriteOriginXHi], a
    inc hl
    ld a, [hl]
    add $10
    ld d, a
    ldh a, [hScrollY]
    add d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc $00
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; A = the entry's sprite-set byte (bit 7 set): wObject5 + $6 (frame counter) += 1, then by set (A &
; $7F): sets $13, $1A, $17, $1E and $18 step their looping duration lists
; (DrawFieldSprites_StepFrameLoop) and use the frame wObject5 + $7 as hSpriteSubIndex; set $1F steps
; its list and maps the frame through DrawFieldSprites_AnimateSubIndex_Data5; set $20 steps the
; (sub-index, duration) pairs of DrawFieldSprites_AnimateSubIndex_Data8
; (DrawFieldSprites_StepFramePairs); any other set leaves hSpriteSubIndex unchanged. (C2, E-0370;
; probed E-0377)
DrawFieldSprites_AnimateSubIndex::
    push af
    ld hl, wObject5 + $6
    inc [hl]
    pop af
    and $7f
    cp $13
    jr nz, .cp_1A
    ld hl, DrawFieldSprites_AnimateSubIndex_Data1
    call DrawFieldSprites_StepFrameLoop
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_1A:
    cp $1a
    jr nz, .cp_17
    ld hl, DrawFieldSprites_AnimateSubIndex_Data2
    call DrawFieldSprites_StepFrameLoop
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_17:
    cp $17
    jr nz, .cp_1F
    ld hl, DrawFieldSprites_AnimateSubIndex_Data3
    call DrawFieldSprites_StepFrameLoop
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_1F:
    cp $1f
    jr nz, .cp_1E
    ld hl, DrawFieldSprites_AnimateSubIndex_Data4
    call DrawFieldSprites_StepFrameLoop
    ld a, [wObject5 + $7]
    ld hl, DrawFieldSprites_AnimateSubIndex_Data5
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ret

.cp_1E:
    cp $1e
    jr nz, .cp_18
    ld hl, DrawFieldSprites_AnimateSubIndex_Data6
    call DrawFieldSprites_StepFrameLoop
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_18:
    cp $18
    jr nz, .cp_20
    ld hl, DrawFieldSprites_AnimateSubIndex_Data7
    call DrawFieldSprites_StepFrameLoop
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_20:
    cp $20
    jr nz, .return
    ld hl, DrawFieldSprites_AnimateSubIndex_Data8
    call DrawFieldSprites_StepFramePairs
    ldh [hSpriteSubIndex], a
    ret

.return:
    ret

; Steps a frame-duration list: when the counter reaches the current frame's duration it restarts and
; the frame advances, wrapping to 0 at $FF. (C2, E-0357; probed E-0377)
DrawFieldSprites_StepFrameLoop::
    ld a, [wObject5 + $7]
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wObject5 + $6]
    cp c
    jr nz, .return
    xor a
    ld [wObject5 + $6], a
    inc hl
    ld a, [hl]
    cp $ff
    jr nz, .check_object5
    xor a
    ld [wObject5 + $7], a
    jr .return

.check_object5:
    ld a, [wObject5 + $7]
    inc a
    ld [wObject5 + $7], a

.return:
    ret

; Steps a list of (sub-index, duration) pairs, holding on the last frame at $FF; returns the current
; sub-index. (C2, E-0357; probed E-0377)
DrawFieldSprites_StepFramePairs::
    push hl
    ld a, [wObject5 + $7]
    add a
    add_a_to_hl
    inc hl
    ld a, [hl]
    ld c, a
    ld a, [wObject5 + $6]
    cp c
    jr nz, .read_object5
    xor a
    ld [wObject5 + $6], a
    ld hl, wObject5 + $7
    inc [hl]

.read_object5:
    ld a, [wObject5 + $7]
    add a
    pop hl
    add_a_to_hl
    ld a, [hl]
    cp $ff
    ret nz
    ld a, [wObject5 + $7]
    dec a
    ld [wObject5 + $7], a
    dec hl
    dec hl
    ld a, [hl]
    ret

; data read by DrawFieldSprites_AnimateSubIndex (5 bytes) (E-0347)
DrawFieldSprites_AnimateSubIndex_Data1::
    db $08, $08, $08, $08, $ff

DrawFieldSprites_AnimateSubIndex_Data2::
    db $08, $08, $ff

DrawFieldSprites_AnimateSubIndex_Data3::
    db $07, $07, $09, $ff

DrawFieldSprites_AnimateSubIndex_Data4::
    db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $36, $0e, $0e, $0e, $40, $ff, $ff, $ff, $ff

DrawFieldSprites_AnimateSubIndex_Data5::
    db $00, $01, $02, $01, $02, $01, $02, $00, $03, $04, $05, $06, $ff, $ff, $ff, $ff

DrawFieldSprites_AnimateSubIndex_Data6::
    db $04, $07, $07, $04, $ff

DrawFieldSprites_AnimateSubIndex_Data7::
    db $20, $20, $ff

DrawFieldSprites_AnimateSubIndex_Data8::
    db $00, $1e, $00, $05, $01, $04, $02, $05, $01, $04, $00, $05, $01, $04, $02, $05
    db $03, $04, $04, $05, $03, $04, $02, $05, $05, $04, $06, $05, $05, $04, $02, $05
    db $01, $04, $00, $05, $ff, $ff

; 22 four-byte records: little-endian graphics pointer into bank $7E, sprite-set/palette selector in
; byte 2, preserved trailing byte. Both field-graphics readers return byte 2 in A and use its low
; seven bits for the palette index. The general reader loads VRAM $8400/palette slot 4; the
; scene-effect variant loads $8300/slot 3. The earlier byte-3 return claim is superseded; no record
; byte changes (E-0360, E-0238, C1)
; record: bank-$7E graphics pointer; sprite-set/palette selector; trailing byte
FieldCommandSpriteTable::
    dw Tiles0Plus300Gfx ; id 0
    db $0a, $00
    dw Tiles0Plus300Gfx ; id 1
    db $0a, $00
    dw Tiles0Gfx ; id 2
    db $00, $00
    dw Gfx_FieldCommandSpriteTable_3 ; id 3
    db $1d, $00
    dw Tiles0Gfx ; id 4
    db $00, $00
    dw Tiles0Plus600Gfx ; id 5
    db $15, $00
    dw Gfx_FieldCommandSpriteTable_6 ; id 6
    db $93, $00
    dw Gfx_FieldCommandSpriteTable_7 ; id 7
    db $16, $00
    dw Gfx_FieldCommandSpriteTable_8 ; id 8
    db $0d, $00
    dw Gfx_FieldCommandSpriteTable_9 ; id 9
    db $11, $00
    dw Gfx_FieldCommandSpriteTable_10 ; id 10
    db $0e, $00
    dw Gfx_FieldCommandSpriteTable_11 ; id 11
    db $9a, $00
    dw Gfx_FieldCommandSpriteTable_12 ; id 12
    db $97, $00
    dw Gfx_FieldCommandSpriteTable_13 ; id 13
    db $1f, $00
    dw Gfx_FieldCommandSpriteTable_13 ; id 14
    db $9f, $00
    dw Gfx_FieldCommandSpriteTable_15 ; id 15
    db $0b, $00
    dw Gfx_FieldCommandSpriteTable_16 ; id 16
    db $09, $00
    dw Tiles0Plus100Gfx ; id 17
    db $9e, $00
    dw Gfx_FieldCommandSpriteTable_18 ; id 18
    db $98, $00
    dw Tiles0Gfx ; id 19
    db $00, $00
    dw Gfx_FieldCommandSpriteTable_20 ; id 20
    db $20, $00
    dw Gfx_FieldCommandSpriteTable_20 ; id 21
    db $a0, $00

; Sets up the trigger of the current screen on map load: wTriggerKind = $FF (none); then, on the
; town maps $20, $30, $48, $70, $A8, $B0 and $B8, or on a special map type whose low three bits are
; 0, finds the first of the wMapObjectCount 8-byte wMapObjects entries whose byte 0 has bit 7 clear
; and whose byte 4 is the screen (hMapScreenX in the high nibble, hMapScreenY in the low).
; wTriggerIndex = its index and FindTriggerEntryForCurrentScreen_StoreTrigger stores byte 5 in
; wTriggerCell and the kind (byte 0 & 3, or FindTriggerEntryForCurrentScreen_StoreTrigger_Data[byte
; 1] when that is 0) in wTriggerKind, loading the marker graphics when the kind is not 0. Two
; map-load paths in bank $02 far-call it, then FindTriggerEntryForCurrentScreen_ScreenTriggers. (C1,
; E-0377)
; wTriggerKind = $FF; on town maps (or special maps of type 0) finds the wMapObjects entry for the
; current screen and sets wTriggerIndex, wTriggerCell and wTriggerKind from it (E-0128)
FindTriggerEntryForCurrentScreen::
    ld a, $ff
    ld [wTriggerKind], a
    ld a, [wMapType]
    bit 7, a
    jr nz, .check_map_type
    ldh a, [hMapId]
    cp $20
    jr z, .read_map_screen_x
    cp $30
    jr z, .read_map_screen_x
    cp $48
    jr z, .read_map_screen_x
    cp $70
    jr z, .read_map_screen_x
    cp $a8
    jr z, .read_map_screen_x
    cp $b0
    jr z, .read_map_screen_x
    cp $b8
    jr z, .read_map_screen_x
    ret

.check_map_type:
    ld a, [wMapType]
    and $07
    ret nz

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wMapObjectCount]
    or a
    ret z
    ld b, a
    ld hl, wMapObjects

.loop:
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, .restore
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    cp c
    jr z, .read_map_object_count

.restore:
    pop hl
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, .loop
    ret

.read_map_object_count:
    ld a, [wMapObjectCount]
    sub b
    ld [wTriggerIndex], a
    jr FindTriggerEntryForCurrentScreen_StoreTrigger

; The same search over wScreenTriggers (4-byte entries: the screen in byte 2, the cell in byte 3):
; on maps $30 and above (not special map types) it searches the first three entries whatever
; wScreenTriggerCount is (it returns when the count is 0), on map type $85 wScreenTriggerCount
; entries, on maps below $30 it sets wScreenTriggerCount = 0, and on other special map types it
; returns. A match sets wTriggerIndex = wScreenTriggerCount minus the entries left (the entry index
; only when the count is 3) and goes on to FindTriggerEntryForCurrentScreen_StoreTrigger. Called
; right after FindTriggerEntryForCurrentScreen. (C1, E-0377)
; on maps from $30 (or special map $85) finds the wScreenTriggers entry for the current screen and
; sets wTriggerIndex, wTriggerCell and wTriggerKind from it (E-0128)
FindTriggerEntryForCurrentScreen_ScreenTriggers::
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_85
    ldh a, [hMapId]
    cp $30
    jr nc, .check_screen_trigger_count
    xor a
    ld [wScreenTriggerCount], a
    ret

.cp_85:
    cp $85
    ret nz
    ld a, [wScreenTriggerCount]
    or a
    ret z
    ld b, a
    ld hl, wScreenTriggers
    jr .read_map_screen_x

.check_screen_trigger_count:
    ld a, [wScreenTriggerCount]
    or a
    ret z
    ld b, $03
    ld hl, wScreenTriggers

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a

.loop:
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, .restore
    inc hl
    inc hl
    ld a, [hl]
    cp c
    jr z, .read_screen_trigger_count

.restore:
    pop hl
    ld a, $04
    add_a_to_hl
    dec b
    jr nz, .loop
    ret

.read_screen_trigger_count:
    ld a, [wScreenTriggerCount]
    sub b
    ld [wTriggerIndex], a
    jr FindTriggerEntryForCurrentScreen_StoreTrigger

; The end of the trigger search (the found entry's address on the stack, HL past its first byte):
; stores the next byte in wTriggerCell and the kind in wTriggerKind (the entry's low two bits, or
; for 0 a kind from FindTriggerEntryForCurrentScreen_ScreenTriggers_Data by the entry's next byte);
; returns when the kind is 0, otherwise falls into LoadTriggerMarkerGraphics. (C1, E-0370)
FindTriggerEntryForCurrentScreen_StoreTrigger::
    inc hl
    ld a, [hl]
    ld [wTriggerCell], a
    pop hl
    ld a, [hl]
    and $03
    jr nz, .skip
    inc hl
    ld a, [hl]
    ld hl, FindTriggerEntryForCurrentScreen_StoreTrigger_Data
    add_a_to_hl
    ld a, [hl]

.skip:
    or a
    ret z
    ld [wTriggerKind], a

; Loads the trigger marker's sprite: the graphics of TriggerSpriteRecord0 + 6 x wTriggerKind
; (pointer and bank) to VRAM $8400 and, on the GBC, eight palette bytes from bank $7E
; (SharedOBJPalettes + the record's next byte) into OBJ palette 4, with an upload request. Reached
; by falling through from FindTriggerEntryForCurrentScreen_StoreTrigger and by far call from
; RandomGoldOrItem_NextRandomSeed. (C1, E-0370)
LoadTriggerMarkerGraphics::
    ld a, [wTriggerKind]
    ld c, a
    add a
    add c
    add a
    ld hl, TriggerSpriteRecord0
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld b, a
    push hl
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, [hl]
    ld de, LoadPlayerAndFollowerSpriteGraphics_OBJPaletteBufferData
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $7e
    ld a, $20
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; data read by FindTriggerEntryForCurrentScreen (45 bytes) (E-0347)
FindTriggerEntryForCurrentScreen_StoreTrigger_Data::
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0a, $06, $00, $01

; record 0 of the 6-byte records LoadTriggerMarkerGraphics reads at $71E8 + 6 * wTriggerKind
; (TriggerSpriteTable holds 1-10); all six bytes are zero (E-0239, C1)
; record: record 0 of the trigger sprite records: all zero
TriggerSpriteRecord0::
    db $00, $00, $00, $00, $00, $00 ; id 0

; LoadTriggerMarkerGraphics reads the 6-byte record at $71E8 + 6 * wTriggerKind, decompresses the
; far-pointed stream to vTiles0 + $400 (DecompressToVRAM) and on CGB copies the 8 bytes at 7E:$4BBD
; + byte 3 to wOBJPaletteBuffer + $20; records 1-10 here; record 0 is TriggerSpriteRecord0 (E-0239,
; C1)
; record: graphics stream, bank; palette offset; two bytes
TriggerSpriteTable::
    dfar Gfx_FieldCommandSpriteTable_16 ; id 1: compressed sprite graphics
    db $48 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_2 ; id 2: compressed sprite graphics
    db $08 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_2 ; id 3: compressed sprite graphics
    db $08 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_4 ; id 4: compressed sprite graphics
    db $10 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_5 ; id 5: compressed sprite graphics
    db $18 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_6 ; id 6: compressed sprite graphics
    db $20 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_7 ; id 7: compressed sprite graphics
    db $28 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_8 ; id 8: compressed sprite graphics
    db $30 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_9 ; id 9: compressed sprite graphics
    db $38 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here
    dfar Tiles0Gfx_2 ; id 10: compressed sprite graphics
    db $40 ; palette byte offset from 7E:$4BBD (SharedOBJPalettes)
    db $00, $00 ; not read here

; Draws the trigger marker each field frame: returns when wFieldActionRequest bit 7 is set or
; wTriggerKind is $FF; otherwise meta-sprite set DrawTriggerMarkerSprite_Data1[wTriggerKind],
; sub-index 0, tile offset $40, attribute bits 4, drawn (DrawMetaSprite) at a position plus the
; 16-bit scroll. With wTriggerMarkerFlags bit 7 set the position is (wTriggerCell + 8, wTriggerIndex
; + $10); otherwise, when the screen has triggers or the map type bit 7 is clear, the cell
; wTriggerCell (X cell in the high nibble, Y cell in the low) at (16 x X + 8, 16 x Y + $10); on
; special maps without screen triggers the pixel pair DrawTriggerMarkerSprite_Data2[2 x
; wTriggerCell] plus (8, $10). RunDrawTriggerMarkerSprite and one field state in bank $02 call it.
; (C1, E-0377)
; unless bit 7 of wFieldActionRequest is set or no trigger is active (wTriggerKind = $FF), draws the
; trigger marker sprite (DrawTriggerMarkerSprite_Data1) at the trigger cell wTriggerCell (E-0130)
DrawTriggerMarkerSprite::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wTriggerKind]
    cp $ff
    ret z
    ld hl, DrawTriggerMarkerSprite_Data1
    add_a_to_hl
    ld a, [hli]
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    ld a, $40
    ldh [hSpriteTileOffset], a
    ld a, $04
    ldh [hSpriteAttrXor], a
    ld a, [wTriggerMarkerFlags]
    bit 7, a
    jp nz, .read_scroll_x2
    ld a, [wScreenTriggerCount]
    or a
    jr nz, .read_scroll_x
    ld a, [wMapType]
    bit 7, a
    jr nz, .read_trigger_cell

.read_scroll_x:
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [wTriggerCell]
    and $f0
    add $08
    add e
    ld e, a
    jr nc, .set_sprite_origin_x
    inc d

.set_sprite_origin_x:
    ld a, e
    ldh [hSpriteOriginX], a
    ld a, d
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld e, a
    ldh a, [hScrollYHi]
    ld d, a
    ld a, [wTriggerCell]
    and $0f
    swap a
    add $10
    add e
    ld e, a
    jr nc, .set_sprite_origin_y
    inc d

.set_sprite_origin_y:
    ld a, e
    ldh [hSpriteOriginY], a
    ld a, d
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

.read_trigger_cell:
    ld a, [wTriggerCell]
    add a
    ld hl, DrawTriggerMarkerSprite_Data2
    add_a_to_hl
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [hli]
    add $08
    add e
    ld e, a
    jr nc, .set_sprite_origin_x2
    inc d

.set_sprite_origin_x2:
    ld a, e
    ldh [hSpriteOriginX], a
    ld a, d
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld e, a
    ldh a, [hScrollYHi]
    ld d, a
    ld a, [hli]
    add $10
    add e
    ld e, a
    jr nc, .set_sprite_origin_y2
    inc d

.set_sprite_origin_y2:
    ld a, e
    ldh [hSpriteOriginY], a
    ld a, d
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

.read_scroll_x2:
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [wTriggerCell]
    add $08
    add e
    ld e, a
    jr nc, .set_sprite_origin_x3
    inc d

.set_sprite_origin_x3:
    ld a, e
    ldh [hSpriteOriginX], a
    ld a, d
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld e, a
    ldh a, [hScrollYHi]
    ld d, a
    ld a, [wTriggerIndex]
    add $10
    add e
    ld e, a
    jr nc, .set_sprite_origin_y3
    inc d

.set_sprite_origin_y3:
    ld a, e
    ldh [hSpriteOriginY], a
    ld a, d
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; data read by DrawTriggerMarkerSprite (11 bytes) (E-0347)
DrawTriggerMarkerSprite_Data1::
    db $00, $09, $01, $01, $02, $03, $04, $05, $06, $07, $08

DrawTriggerMarkerSprite_Data2::
    db $10, $20, $10, $70, $20, $10, $20, $40, $20, $60, $30, $30, $40, $50, $40, $70
    db $50, $10, $50, $30, $60, $50, $70, $20, $70, $40, $70, $70, $80, $10, $80, $60

; The A button on a trigger in the field (two field states in bank $02 far-call it): returns while
; the text window is busy (wTextWindowState low bits), wFieldActionRequest bit 7 or
; hPlayerStateFlags bit 0 is set, A is not newly pressed (wJoypadPressed bit 0), or wTriggerKind is
; not 2 or 3. Otherwise tests the point in front of the player (hPlayerX, hPlayerY moved by
; hPlayerFacing: 0 Y + $11, 1 X + $11, 2 Y - 1, 3 X - 1) with IsPlayerOnTriggerCell; on the cell it
; starts talk group $0F of category 0, Talk_StepTriggerReward (wTalkEventGroup = $0F,
; wTalkEventIndex = 0, DispatchTalkEvent), clears wJoypadHeld and wJoypadPressed, and redraws the
; screen (RedrawScreenBufferIfPartyWindowFlagsBit7) when wPartyWindowFlags bit 7 is set. (C1,
; E-0377)
; A in the field when nothing blocks input: checks whether the player stands on a trigger cell
; (wTriggerKind 2 or 3, IsPlayerOnTriggerCell) (E-0339; was CheckTriggerCellOnA)
CheckTriggerCellOnA::
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wTriggerKind]
    cp $02
    jr z, .read_player_x
    cp $03
    jr z, .read_player_x
    ret

.read_player_x:
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .call_is_player_on_trigger_cell
    dec b
    jr .call_is_player_on_trigger_cell2

.skip:
    ld a, c
    add $11
    ld c, a
    jr .call_is_player_on_trigger_cell2

.skip2:
    ld a, b
    add $11
    ld b, a
    jr .call_is_player_on_trigger_cell2

.call_is_player_on_trigger_cell:
    dec c

.call_is_player_on_trigger_cell2:
    call IsPlayerOnTriggerCell
    or a
    jr z, .return
    ld a, $0f
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.return:
    ret

; Stepping onto a trigger (the field movement update in bank $02 far-calls it): returns when
; wTriggerEnable is 1, wFieldStepFlags is $C0, or wTriggerKind is $FF, 2 or 3 (those wait for the A
; button, CheckTriggerCellOnA). When the player position (hPlayerX, hPlayerY) is on the trigger cell
; (IsPlayerOnTriggerCell) it starts Talk_StepTriggerReward (talk group $0F of category 0 through
; DispatchTalkEvent) and clears wJoypadHeld and wJoypadPressed; when a script is running with
; wTalkEventIndex 0 and wTalkEventGroup $1D it first sets wEncounterDelay = 1. (C1, E-0377)
; when the player stands on a trigger (IsPlayerOnTriggerCell) and nothing blocks it, sets
; wTalkEventGroup = $0F and far-calls DispatchTalkEvent, clearing the joypad state (E-0125)
CheckStepTriggerAndDispatchTalk::
    ld a, [wTriggerEnable]
    dec a
    ret z
    ld a, [wFieldStepFlags]
    cp $c0
    ret z
    ld a, [wTriggerKind]
    cp $ff
    ret z
    cp $02
    ret z
    cp $03
    ret z
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call IsPlayerOnTriggerCell
    or a
    jr z, .return
    ld a, [wScriptRunning]
    or a
    jr z, .set_talk_event_group_to_0F
    ld a, [wTalkEventIndex]
    or a
    jr nz, .set_talk_event_group_to_0F
    ld a, [wTalkEventGroup]
    cp $1d
    jr nz, .set_talk_event_group_to_0F
    ld a, $01
    ld [wEncounterDelay], a

.set_talk_event_group_to_0F:
    ld a, $0f
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.return:
    ret

; Field state 5's A button in a key world: when idle and A is pressed on map type $85, a treasure
; tile $2C in front starts talk event group $0E (the area item) with a pointer to whichever of the
; floor's item records belongs to this screen (FieldState_WalkAMenu_CheckKeyWorldItemOnA_Data), tile
; $2E starts it with no item; on map type $86 tile $1A starts group $0D (the door item) with the
; floor's wKeyWorldMenuFlag, tile $1C group $0E with no item. (C1, E-0357)
FieldState_WalkAMenu_CheckKeyWorldItemOnA::
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wMapType]
    bit 7, a
    ret z
    cp $85
    jr z, .read_player_x
    cp $86
    ret nz

.read_player_x:
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .skip3
    ld a, b
    sub $10
    ld b, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.skip:
    ld a, c
    add $10
    ld c, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.skip2:
    ld a, b
    add $10
    ld b, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.skip3:
    ld a, c
    sub $10
    ld c, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.call_read_tile_buffer2x2_at_pixel_bank12:
    call ReadTileBuffer2x2AtPixel_Bank12
    ld a, [wMapType]
    cp $86
    jp z, .check_tiles_under_point
    ld a, [wTilesUnderPoint]
    cp $2c
    jr z, .read_map_screen_x
    cp $2e
    jr z, .loop
    ret

.loop:
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0e
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld b, a
    ldh a, [hMapScreenY]
    or b
    ld b, a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $4
    add_a_to_hl
    ld a, [wKeyWorldArea]
    ld c, a
    ld a, [hl]
    cp c
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    ld de, FieldState_WalkAMenu_CheckKeyWorldItemOnA_Data
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    cp b
    jr nz, .next2
    dec hl
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0e
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

.next:
    inc hl
    inc hl

.next2:
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld de, FieldState_WalkAMenu_CheckKeyWorldItemOnA_Data
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    cp b
    jr nz, .return
    dec hl
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0e
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.return:
    ret

.check_tiles_under_point:
    ld a, [wTilesUnderPoint]
    cp $1a
    jr z, .read_key_world_floor
    cp $1c
    jp z, .loop
    ret

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    ld hl, wKeyWorldMenuFlag
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld a, $0d
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; data read by FieldState_WalkAMenu_CheckKeyWorldItemOnA (8 bytes) (E-0347)
FieldState_WalkAMenu_CheckKeyWorldItemOnA_Data::
    db $01, $10, $12, $13, $20, $21, $23, $32

; B = X pixel, C = Y pixel: A = 1 when the 16-pixel cell (B / 16, C / 16) is the trigger cell,
; otherwise A = 0; BC kept. The trigger cell is wTriggerCell (X in the high nibble, Y in the low) on
; ordinary maps and map type $85, and the (X, Y) byte pair IsPlayerOnTriggerCell_Data[2 x
; wTriggerCell] on the other special map types. CheckTriggerCellOnA and
; CheckStepTriggerAndDispatchTalk call it. (C2, E-0377)
; A = 1 when the player cell (B, C high nibbles) equals the trigger cell wTriggerCell (or its
; IsPlayerOnTriggerCell_Data entry on special maps), else 0 (E-0127)
IsPlayerOnTriggerCell::
    push bc
    jr .skip

.loop:
    xor a
    pop bc
    ret

.skip:
    ld a, b
    swap a
    and $0f
    ld b, a
    ld a, c
    swap a
    and $0f
    ld c, a
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_85

.loop2:
    ld a, [wTriggerCell]
    swap a
    and $0f
    cp b
    jr nz, .loop
    ld a, [wTriggerCell]
    and $0f
    cp c
    jr nz, .loop
    ld a, $01
    pop bc
    ret

.cp_85:
    cp $85
    jr z, .loop2
    ld a, [wTriggerCell]
    add a
    ld hl, IsPlayerOnTriggerCell_Data
    add_a_to_hl
    ld a, [hli]
    cp b
    jr nz, .loop
    ld a, [hl]
    cp c
    jr nz, .loop
    ld a, $01
    pop bc
    ret

; data read by IsPlayerOnTriggerCell (32 bytes) (E-0347)
IsPlayerOnTriggerCell_Data::
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 x (C / 8) + B / 8 (rows of 20 entries);
; copies that entry and the next to wTilesUnderPoint and wTilesUnderPoint + $1, and the two entries
; below them to wTilesUnderPoint + $2 and + $3; returns HL on the bottom-right entry, BC kept.
; FieldState_WalkAMenu_CheckKeyWorldItemOnA and RunPendingFieldEventPendingFieldEvent_PlaceSprite
; call it; ReadTileBuffer2x2AtPixel_Bank12_2 is an identical copy in this bank (the same 63 bytes
; appear in 3 banks). (C2, E-0377)
; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries);
; copies the 2 x 2 entries there to wTilesUnderPoint, wTilesUnderPoint + $1 (top row) and
; wTilesUnderPoint + $2, wTilesUnderPoint + $3 (bottom row); HL ends on the bottom-right entry
; (E-0064) (the same 63 bytes appear in 3 banks)
ReadTileBuffer2x2AtPixel_Bank12::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld a, [hli]
    ld [wTilesUnderPoint], a
    ld a, [hld]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hli]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ret

; Once every 100 calls on the town maps ($20, $30, $48, $70, $A8, $B0, $B8, $C8) or in the key world
; (map type $80), tries the town events in turn until one sets wPendingFieldEvent and returns carry:
; EventCheckGoldAtLeast10000, TriggerEventCDIfPartyHPTotalBelow100,
; TriggerEventCEIfPartyMPTotalBelow100, TriggerEventCFIfPartyLevelTotalBelow100,
; TriggerEventC0IfHPDigitsRepeat, TriggerEventC1IfGoldDigitSumAtMost12,
; TriggerEventC2IfPartyHPLastDigitsMatch, TriggerEventC3IfGoldDigitSum30,
; TriggerEventC6IfGoldAtLeast, TriggerEventCBIfMemberStatused,
; TriggerEventC7IfGold1000AndNoItems19To1C, RunPeriodicFieldEventChecks_LowHPTownEvent,
; TriggerEventC9IfExpDigitsRepeat and TriggerEventC4OrC5IfGold1000; A = 0 and no carry when none
; does. wTownEventTimer counts the calls (at 99 it resets to 0 and the checks run). Returns at once
; while a script runs or wPendingFieldEvent bit 7 is set. The field movement update in bank $02
; far-calls it each step, and RunPendingFieldEventPendingFieldEvent_PlaceSprite calls it with the
; timer at 99. (C2, E-0377)
; on town maps, every 100 calls (wTownEventTimer), tries the gold, party-stat and digit events in
; turn until one sets wPendingFieldEvent (E-0128)
RunPeriodicFieldEventChecks::
    ld a, [wScriptRunning]
    or a
    ret nz
    ld a, [wPendingFieldEvent]
    bit 7, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ldh a, [hMapId]
    cp $20
    jr z, .check_town_event_timer
    cp $30
    jr z, .check_town_event_timer
    cp $48
    jr z, .check_town_event_timer
    cp $70
    jr z, .check_town_event_timer
    cp $a8
    jr z, .check_town_event_timer
    cp $b0
    jr z, .check_town_event_timer
    cp $b8
    jr z, .check_town_event_timer
    cp $c8
    jr z, .check_town_event_timer
    ret

.skip:
    and $7f
    ret nz

.check_town_event_timer:
    ld a, [wTownEventTimer]
    cp $63
    jr z, .clear_town_event_timer
    inc a
    ld [wTownEventTimer], a
    ret

.clear_town_event_timer:
    xor a
    ld [wTownEventTimer], a
    call EventCheckGoldAtLeast10000
    ret c
    call TriggerEventCDIfPartyHPTotalBelow100
    ret c
    call TriggerEventCEIfPartyMPTotalBelow100
    ret c
    call TriggerEventCFIfPartyLevelTotalBelow100
    ret c
    call TriggerEventC0IfHPDigitsRepeat
    ret c
    call TriggerEventC1IfGoldDigitSumAtMost12
    ret c
    call TriggerEventC2IfPartyHPLastDigitsMatch
    ret c
    call TriggerEventC3IfGoldDigitSum30
    ret c
    call TriggerEventC6IfGoldAtLeast
    ret c
    call TriggerEventCBIfMemberStatused
    ret c
    call TriggerEventC7IfGold1000AndNoItems19To1C
    ret c
    call RunPeriodicFieldEventChecks_LowHPTownEvent
    ret c
    call TriggerEventC9IfExpDigitsRepeat
    ret c
    call TriggerEventC4OrC5IfGold1000
    ret c
    sub a
    ret

; Town event $CC, the first check of RunPeriodicFieldEventChecks: when EVENT_KING_YOU_WILL_I_KNEW is
; set, EVENT_KING_IF_YOU_SEE is clear and the gold is at least 10,000 ($2710), wPendingFieldEvent =
; $CC and carry set; otherwise A = 0 and carry clear. (C2, E-0377)
; when story flag $192 is set, flag $193 is clear and gold >= 10,000 ($2710): wPendingFieldEvent =
; $CC and carry set; otherwise A = 0 and carry clear (E-0075)
EventCheckGoldAtLeast10000::
    ld de, EVENT_KING_YOU_WILL_I_KNEW
    call TestFlagBit
    jr nc, .done
    ld de, EVENT_KING_IF_YOU_SEE
    call TestFlagBit
    jr c, .done
    ld a, [wGoldHi]
    or a
    jr nz, .set_pending_field_event_to_CC
    ld a, [wGoldMid]
    cp $27
    jr z, .check_gold_lo
    jr nc, .set_pending_field_event_to_CC
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $10
    jr c, .done

.set_pending_field_event_to_CC:
    ld a, $cc
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $CD: with EVENT_KING_YOU_WILL_I_KNEW_195 set and EVENT_KING_IF_YOU_SEE_196 clear, sums
; the MON_HP words of the wPartyCount records in wPartyList (16 bits in hTemp2/hTemp3, SRAM enabled
; for the loop and disabled after); a total below 100 sets wPendingFieldEvent = $CD and carry,
; otherwise A = 0 and carry clear. There is no empty-party guard. Called by
; RunPeriodicFieldEventChecks. (C2, E-0377)
; with story flag $195 set and $196 clear: when the party's total HP is below 100,
; wPendingFieldEvent = $CD and carry (E-0127)
TriggerEventCDIfPartyHPTotalBelow100::
    ld de, EVENT_KING_YOU_WILL_I_KNEW_195
    call TestFlagBit
    jr nc, .done
    ld de, EVENT_KING_IF_YOU_SEE_196
    call TestFlagBit
    jr c, .done
    ld a, [wPartyCount]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ldh a, [hTemp3]
    or a
    jr nz, .done
    ldh a, [hTemp2]
    cp $64
    jr nc, .done
    ld a, $cd
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $CE: with EVENT_KING_YOU_WILL_I_KNEW_198 set and EVENT_KING_IF_YOU_SEE_199 clear, sums
; the MON_MP words of the wPartyCount records in wPartyList (16 bits in hTemp2/hTemp3, SRAM enabled
; for the loop and disabled after); a total below 100 sets wPendingFieldEvent = $CE and carry,
; otherwise A = 0 and carry clear. There is no empty-party guard. Called by
; RunPeriodicFieldEventChecks. (C2, E-0377)
; with story flag $198 set and $199 clear: when the party's total MP is below 100,
; wPendingFieldEvent = $CE and carry (E-0127)
TriggerEventCEIfPartyMPTotalBelow100::
    ld de, EVENT_KING_YOU_WILL_I_KNEW_198
    call TestFlagBit
    jr nc, .done
    ld de, EVENT_KING_IF_YOU_SEE_199
    call TestFlagBit
    jr c, .done
    ld a, [wPartyCount]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ldh a, [hTemp3]
    or a
    jr nz, .done
    ldh a, [hTemp2]
    cp $64
    jr nc, .done
    ld a, $ce
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $CF: with EVENT_KING_YOU_WILL_I_KNEW_19B set and EVENT_KING_IF_YOU_SEE_19C clear, sums
; the MON_LEVEL bytes of the wPartyCount records in wPartyList (16 bits in hTemp2/hTemp3, SRAM
; enabled for the loop and disabled after); a total below 100 sets wPendingFieldEvent = $CF and
; carry, otherwise A = 0 and carry clear. Called by RunPeriodicFieldEventChecks. (C2, E-0377)
; with story flag $19B set and $19C clear: when the party's total level is below 100,
; wPendingFieldEvent = $CF and carry (E-0127)
TriggerEventCFIfPartyLevelTotalBelow100::
    ld de, EVENT_KING_YOU_WILL_I_KNEW_19B
    call TestFlagBit
    jr nc, .done
    ld de, EVENT_KING_IF_YOU_SEE_19C
    call TestFlagBit
    jr c, .done
    ld a, [wPartyCount]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ldh a, [hTemp3]
    or a
    jr nz, .done
    ldh a, [hTemp2]
    cp $64
    jr nc, .done
    ld a, $cf
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $C9: with at least 1,000 gold, when a party member has a 24-bit MON_EXP whose ones,
; tens and hundreds digits are equal (Number24ToPackedBCD), wPendingFieldEvent = $C9 and carry;
; otherwise A = 0 and carry clear. SRAM is enabled for the loop and rRAMG is cleared on every
; return. Called by RunPeriodicFieldEventChecks. (C2, E-0377)
; with at least 1000 gold: when a party member's EXP has its last three decimal digits equal,
; wPendingFieldEvent = $C9 and carry (E-0128)
TriggerEventC9IfExpDigitsRepeat::
    ld a, [wGoldHi]
    or a
    jr nz, .read_party_count
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .read_party_count
    jr .skip

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .skip

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_EXP
    call LoadRecordThreeBytesToTemp0
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    ldh a, [hTemp2]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp0]
    and $0f
    ld c, a
    ldh a, [hTemp0]
    swap a
    and $0f
    cp c
    jr nz, .restore
    ldh a, [hTemp1]
    and $0f
    cp c
    jr z, .restore2

.restore:
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop
    jr .skip

.restore2:
    pop hl
    pop bc
    xor a
    ld [rRAMG], a
    ld a, $c9
    ld [wPendingFieldEvent], a
    scf
    ret

.skip:
    xor a
    ld [rRAMG], a
    sub a
    ret

; Town event $CB: with at least 1,000 gold, when a party member has MON_STATUS bit 7, 2 or 0 set,
; wPendingFieldEvent = $CB and carry; otherwise A = 0 and carry clear. For such a member it compares
; MON_MAX_HP with half of MON_MAX_HP (both loads read MON_MAX_HP), so the HP test always passes.
; SRAM is enabled for the loop and disabled on return. Called by RunPeriodicFieldEventChecks. (C2,
; E-0377)
; with at least 1000 gold: checks party members with status bits 7, 2 or 0 of field $55 against half
; their max HP and may set an event (E-0128) (E-0344: the address in its name dropped or read as the
; label there; was TriggerEventCBIfMemberStatused)
TriggerEventCBIfMemberStatused::
    ld a, [wGoldHi]
    or a
    jr nz, .read_party_count
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .read_party_count
    jr .skip

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .skip

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG], a

.loop:
    push hl
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .call_load_sram_record_word
    bit 2, a
    jr nz, .call_load_sram_record_word
    bit 0, a
    jr nz, .call_load_sram_record_word

.loop2:
    pop hl
    inc hl
    dec b
    jr nz, .loop
    jr .skip

.call_load_sram_record_word:
    ld a, [hl]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    srl d
    rr e
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, [hl]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp1]
    cp c
    jr c, .loop2
    jr nz, .restore
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp0]
    cp c
    jr c, .loop2

.restore:
    pop hl
    xor a
    ld [rRAMG], a
    ld a, $cb
    ld [wPendingFieldEvent], a
    scf
    ret

.skip:
    xor a
    ld [rRAMG], a
    sub a
    ret

; Town event $C8: when wEventItemSlot is $FF or 0 and the gold is at least 1,000, sums the party
; MON_MAX_HP words, divides the sum by 100 (rounded down) and multiplies by 30; when the party total
; MON_HP is at or below that, wPendingFieldEvent = $C8 and carry, otherwise A = 0 and carry clear.
; SRAM is enabled for each sum and disabled after. Called by RunPeriodicFieldEventChecks. (C2,
; E-0377)
RunPeriodicFieldEventChecks_LowHPTownEvent::
    ld a, [wEventItemSlot]
    cp $ff
    jr z, .check_gold_hi
    or a
    jp nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a
    jr nz, .read_party_count
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .read_party_count
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .done

.read_party_count:
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, $0000

.loop:
    ld a, [hli]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld l, e
    ld h, d
    ld a, $64
    call DivideHLByA
    ld c, l
    ld b, h
    ld a, $1e
    call Multiply8By16
    push hl
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, $0000

.loop2:
    ld a, [hli]
    ld c, MON_HP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG], a
    pop hl
    ld a, d
    cp h
    jr c, .set_pending_field_event_to_C8
    jr nz, .done
    ld a, e
    cp l
    jr c, .set_pending_field_event_to_C8
    jr nz, .done

.set_pending_field_event_to_C8:
    ld a, $c8
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $C7: when wEventItemSlot is $FF or 0 and the gold is at least 1,000, scans wInventory
; up to the first $00 or $FF byte (there is no 24-slot limit); when no item before it is $19-$1C
; (ITEM_BEEFJERKY, ITEM_PORKCHOP, ITEM_RIB, ITEM_SIRLOIN), wPendingFieldEvent = $C7 and carry;
; otherwise A = 0 and carry clear. Called by RunPeriodicFieldEventChecks. (C2, E-0377)
; when wEventItemSlot is $FF or 0, the gold is at least 1000 and no inventory slot before the first
; empty one holds items $19-$1C: wPendingFieldEvent = $C7 and carry (E-0125)
TriggerEventC7IfGold1000AndNoItems19To1C::
    ld a, [wEventItemSlot]
    cp $ff
    jr z, .check_gold_hi
    or a
    jr nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a
    jr nz, .skip
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .skip
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .done

.skip:
    ld hl, wInventory

.skip2:
    ld a, [hli]
    or a
    jr z, .set_pending_field_event_to_C7
    cp $ff
    jr z, .set_pending_field_event_to_C7
    cp $19
    jr z, .done
    cp $1a
    jr z, .done
    cp $1b
    jr z, .done
    cp $1c
    jr z, .done
    jr .skip2

.set_pending_field_event_to_C7:
    ld a, $c7
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $C6: when wEventItemSlot is $FF or 0 and the gold is at least 5,000 ($1388),
; wPendingFieldEvent = $C6 and carry; otherwise A = 0 and carry clear. Called by
; RunPeriodicFieldEventChecks. (C2, E-0377)
; when wEventItemSlot is $FF or 0 and the gold is at least 5000, wPendingFieldEvent = $C6 and carry;
; otherwise A = 0, no carry (E-0124) (E-0344: the address in its name dropped or read as the label
; there; was TriggerEventC6IfGoldAtLeast)
TriggerEventC6IfGoldAtLeast::
    ld a, [wEventItemSlot]
    cp $ff
    jr z, .check_gold_hi
    or a
    jr nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a
    jr nz, .set_pending_field_event_to_C6
    ld a, [wGoldMid]
    cp $13
    jr z, .check_gold_lo
    jr nc, .set_pending_field_event_to_C6
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $88
    jr c, .done

.set_pending_field_event_to_C6:
    ld a, $c6
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a
    ret

; Town event $C4 or $C5, the last check of RunPeriodicFieldEventChecks: with at least 1,000 gold and
; the last bag slot (wInventory + $17) $FF or 0, steps NextTableByte and sets wPendingFieldEvent =
; $C4 + (wRandomHi & 1) with carry; otherwise A = 0 and carry clear. (C2, E-0377)
; when the gold is at least 1000 and wInventory + $17 is $FF or 0: wPendingFieldEvent = $C4 or $C5
; at random and carry (E-0125)
TriggerEventC4OrC5IfGold1000::
    ld a, [wGoldHi]
    or a
    jr nz, .check_inventory
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .check_inventory
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .done

.check_inventory:
    ld a, [wInventory + $17]
    cp $ff
    jr z, .skip
    or a
    jr nz, .done

.skip:
    jr .call_next_table_byte

.done:
    sub a
    ret

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    and $01
    add $c4
    ld [wPendingFieldEvent], a
    scf
    ret

; Town event $C3: with at least 5,000 gold and the last bag slot (wInventory + $17) $FF or 0, adds
; up the decimal digits of the 24-bit gold (Number24ToPackedBCD); a sum of 30 or more sets
; wPendingFieldEvent = $C3 and carry, otherwise A = 0 and carry clear. With the last slot taken it
; returns with carry clear and A nonzero. Called by RunPeriodicFieldEventChecks. (C2, E-0377)
; with at least 5000 gold and wInventory + $17 $FF or 0: when the gold's decimal digits sum to at
; least 30, wPendingFieldEvent = $C3 and carry (E-0128)
TriggerEventC3IfGoldDigitSum30::
    ld a, [wGoldHi]
    or a
    jr nz, .check_inventory
    ld a, [wGoldMid]
    cp $13
    jr z, .check_gold_lo
    jr nc, .check_inventory
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $88
    jr c, .done

.check_inventory:
    ld a, [wInventory + $17]
    cp $ff
    jr z, .read_gold_lo
    or a
    ret nz

.read_gold_lo:
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp0]
    and $0f
    ld c, a
    ldh a, [hTemp0]
    swap a
    and $0f
    add c
    ld c, a
    ldh a, [hTemp1]
    and $0f
    add c
    ld c, a
    ldh a, [hTemp1]
    swap a
    and $0f
    add c
    ld c, a
    ldh a, [hTemp2]
    and $0f
    add c
    ld c, a
    ldh a, [hTemp2]
    swap a
    and $0f
    add c
    ld c, a
    ldh a, [hTemp3]
    and $0f
    add c
    cp $1e
    jr nc, .set_pending_field_event_to_C3

.done:
    sub a
    ret

.set_pending_field_event_to_C3:
    ld a, $c3
    ld [wPendingFieldEvent], a
    scf
    ret

; Town event $C2: with at least 1,000 gold, compares the ones digits (HLToDecimalDigits) of the
; MON_HP of the first two, or three, wPartyList members; when they all match, or the party has one
; member, wPendingFieldEvent = $C2 and carry; otherwise A = 0 and carry clear. SRAM is enabled for
; the check and disabled after. Called by RunPeriodicFieldEventChecks. (C2, E-0377)
; with at least 1000 gold: when every party member's HP ends in the same decimal digit,
; wPendingFieldEvent = $C2 and carry (E-0128)
TriggerEventC2IfPartyHPLastDigitsMatch::
    ld a, [wGoldHi]
    or a
    jr nz, .check_party_count
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .check_party_count
    jp .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .done

.check_party_count:
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    dec a
    jr z, .skip
    ld a, [wPartyList]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    ld a, [wDigits + $2]
    ld b, a
    ld a, [wPartyList + $1]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, [wDigits + $2]
    cp b
    jr nz, .skip2
    ld a, [wPartyCount]
    dec a
    dec a
    jr z, .skip
    ld a, [wPartyList + $2]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, [wDigits + $2]
    cp b
    jr nz, .skip2

.skip:
    xor a
    ld [rRAMG], a
    ld a, $c2
    ld [wPendingFieldEvent], a
    scf
    ret

.skip2:
    xor a
    ld [rRAMG], a

.done:
    sub a
    ret

; Town event $C1: with the last bag slot (wInventory + $17) $FF or 0 and at least 1,000 gold, adds
; up the decimal digits of the 24-bit gold (Number24ToPackedBCD); a sum of 12 or less sets
; wPendingFieldEvent = $C1 and carry, otherwise A = 0 and carry clear. Called by
; RunPeriodicFieldEventChecks. (C2, E-0377)
; with at least 1000 gold and wInventory + $17 $FF or 0: when the gold's decimal digits sum to at
; most 12, wPendingFieldEvent = $C1 and carry (E-0128)
TriggerEventC1IfGoldDigitSumAtMost12::
    ld a, [wInventory + $17]
    cp $ff
    jr z, .check_gold_hi
    or a
    jr nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a
    jr nz, .read_gold_lo
    ld a, [wGoldMid]
    cp $03
    jr z, .check_gold_lo
    jr nc, .read_gold_lo
    jp .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp $e8
    jr c, .done

.read_gold_lo:
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp0]
    and $0f
    ld c, a
    ldh a, [hTemp0]
    swap a
    and $0f
    add c
    ld c, a
    ldh a, [hTemp1]
    and $0f
    add c
    ld c, a
    ldh a, [hTemp1]
    swap a
    and $0f
    add c
    ld c, a
    ldh a, [hTemp2]
    and $0f
    add c
    ld c, a
    ldh a, [hTemp2]
    swap a
    and $0f
    add c
    ld c, a
    ldh a, [hTemp3]
    and $0f
    add c
    cp $0c
    jr z, .set_pending_field_event_to_C1
    jr c, .set_pending_field_event_to_C1

.done:
    sub a
    ret

.set_pending_field_event_to_C1:
    ld a, $c1
    ld [wPendingFieldEvent], a
    scf
    ret

; Town event $C0: when a party member has a MON_HP whose decimal digits (HLToDecimalDigits) are all
; equal, such as 77 or 333, or a single-digit HP (0-9), wPendingFieldEvent = $C0 and carry;
; otherwise A = 0 and carry clear. There is no gold condition. SRAM is enabled for the loop and
; disabled on return. Called by RunPeriodicFieldEventChecks. (C2, E-0377)
; when a party member's HP has all decimal digits equal (for example 77 or 333), wPendingFieldEvent
; = $C0 and carry (E-0127)
TriggerEventC0IfHPDigitsRepeat::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    ld a, [wDigits]
    or a
    jr z, .check_digits
    ld c, a
    ld a, [wDigits + $1]
    cp c
    jr nz, .restore
    ld a, [wDigits + $2]
    cp c
    jr nz, .restore
    jr .restore2

.check_digits:
    ld a, [wDigits + $1]
    or a
    jr z, .restore2
    ld c, a
    ld a, [wDigits + $2]
    cp c
    jr nz, .restore
    jr .restore2

.restore:
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    sub a
    ret

.restore2:
    pop hl
    pop bc
    xor a
    ld [rRAMG], a
    ld a, $c0
    ld [wPendingFieldEvent], a
    scf
    ret

; When wPendingFieldEvent has bit 7 set and bit 6 clear (an event whose sprite has been placed),
; clears wPendingFieldEvent and wTownEventTimer; otherwise changes nothing. Scenes in bank $61 and
; map code in bank $11 far-call it (nine sites). (C2, E-0377)
; when wPendingFieldEvent has bit 7 set and bit 6 clear: wPendingFieldEvent = 0 and wTownEventTimer
; = 0 (E-0117)
ClearPendingFieldEventIfBit7AndNot6::
    ld a, [wPendingFieldEvent]
    bit 7, a
    ret z
    bit 6, a
    ret nz
    xor a
    ld [wPendingFieldEvent], a
    ld [wTownEventTimer], a
    ret

; On map load (two map-load paths in bank $02 far-call it after the screen objects are set up):
; returns when ClearPendingFieldEventWhenFieldIdle_BeforeCrate returns A nonzero (it cleared the
; event itself), when wTriggerKind is not $FF, or while a script runs. Otherwise on ordinary maps it
; clears wPendingFieldEvent, and on special map types it goes to
; RunPendingFieldEventPendingFieldEvent_IfKeyWorld, which places the pending event sprite only in
; the key world (map type $80). (C1, E-0377)
; returns unless ClearPendingFieldEventWhenFieldIdle_BeforeCrate is 0, wTriggerKind is $FF and no
; script runs; then, unless bit 7 of wMapType is set, wPendingFieldEvent = 0 (E-0122)
ClearPendingFieldEventWhenFieldIdle::
    call ClearPendingFieldEventWhenFieldIdle_BeforeCrate
    or a
    ret nz
    ld a, [wTriggerKind]
    cp $ff
    ret nz
    ld a, [wScriptRunning]
    or a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jr nz, RunPendingFieldEventPendingFieldEvent_IfKeyWorld
    xor a
    ld [wPendingFieldEvent], a
    ret

; No call, jump or table entry in src/ reaches it (it follows the ret of
; ClearPendingFieldEventWhenFieldIdle). It clears wPendingFieldEvent when the kind (low nibble) is 8
; or the map is not one of the town maps $20, $30, $48, $70, $A8, $B0, $B8 and $C8; on those maps it
; goes to RunPendingFieldEventPendingFieldEvent_PlaceSprite, which places and draws the pending
; event sprite. (C1, E-0377)
; on town maps runs the pending event in wPendingFieldEvent (bits 7 and 6 select the stage; some
; kinds need wInventory + $17); otherwise clears it (E-0130)
RunPendingFieldEventPendingFieldEvent::
    ld a, [wPendingFieldEvent]
    and $0f
    cp $08
    jr z, .clear_pending_field_event
    ldh a, [hMapId]
    cp $20
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $30
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $48
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $70
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $a8
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $b0
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $b8
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite
    cp $c8
    jr z, RunPendingFieldEventPendingFieldEvent_PlaceSprite

.clear_pending_field_event:
    xor a
    ld [wPendingFieldEvent], a
    ret

; Entered from ClearPendingFieldEventWhenFieldIdle with A = wMapType (bit 7 set): returns unless A
; is exactly $80 (the key world), then falls into RunPendingFieldEventPendingFieldEvent_PlaceSprite.
; (C1, E-0370)
RunPendingFieldEventPendingFieldEvent_IfKeyWorld::
    and $7f
    ret nz

; Places the pending field event's sprite: returns unless wPendingFieldEvent bit 7 is set. With bit
; 6 (the first stage): for kinds 1, 3, 4, 5 and 7, when the last inventory slot is taken it clears
; wPendingFieldEvent, sets wTownEventTimer to $63 and runs RunPeriodicFieldEventChecks, then goes on
; anyway; it puts sprite slot 0 at one of four random spots (PendingFieldEventSpritePositions),
; returns when RollFieldEventOnTallTiles reports a blocking tile there, otherwise sets up the slot
; and clears bit 6. Then one sprite slot is drawn with the kind's sprite
; (PendingFieldEventSpriteIds) loaded to VRAM $8500. (C1, E-0370)
RunPendingFieldEventPendingFieldEvent_PlaceSprite::
    ld a, [wPendingFieldEvent]
    bit 7, a
    ret z
    bit 6, a
    jp z, .set_sprite_slot_count_to_01
    ld a, [wPendingFieldEvent]
    and $0f
    cp $01
    jr z, .check_inventory
    cp $03
    jr z, .check_inventory
    cp $04
    jr z, .check_inventory
    cp $05
    jr z, .check_inventory
    cp $07
    jr z, .check_inventory
    jr .call_next_table_byte

.check_inventory:
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_next_table_byte
    or a
    jr z, .call_next_table_byte
    xor a
    ld [wPendingFieldEvent], a
    ld a, $63
    ld [wTownEventTimer], a
    call RunPeriodicFieldEventChecks

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    and $03
    add a
    ld hl, PendingFieldEventSpritePositions
    add_a_to_hl
    ld a, [hli]
    ld [wSpriteSlots + $4], a
    ld [wSpriteSlots + $b], a
    ld a, [hl]
    ld [wSpriteSlots + $5], a
    ld [wSpriteSlots + $c], a
    ld a, [wSpriteSlots + $4]
    ld b, a
    ld a, [wSpriteSlots + $5]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank12
    call RollFieldEventOnTallTiles
    cp $01
    ret z
    ld a, $03
    ld [wSpriteSlots], a
    ld a, $01
    ld [wSpriteSlots + $1], a
    xor a
    ld [wSpriteSlots + $3], a
    ld a, $05
    ld [wSpriteSlots + $6], a
    ld a, $00
    ld [wSpriteSlots + $7], a
    ld a, $50
    ld [wSpriteSlots + $8], a
    xor a
    ld [wSpriteSlots + $9], a
    xor a
    ld [wSpriteSlots + $a], a
    xor a
    ld [wSpriteSlots + $d], a
    ld a, $ff
    ld [wSpriteSlots + $f], a
    ld a, [wPendingFieldEvent]
    and $bf
    ld [wPendingFieldEvent], a

.set_sprite_slot_count_to_01:
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wPendingFieldEvent]
    and $0f
    ld hl, PendingFieldEventSpriteIds
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp2], a
    ld a, $05
    ldh [hTemp3], a
    ld hl, vTiles0 + $500
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; Called by RunPendingFieldEventPendingFieldEvent_PlaceSprite after ReadTileBuffer2x2AtPixel_Bank12
; filled wTilesUnderPoint. When the wMapSpriteKind low nibble is 1 and a tile there is at or below
; wMapTallTileMin, steps NextRandomSeed once; when wKeyRandomHi & 7 is then 0, the bag holds item
; $2C (ITEM_TINYMEDAL, FindTemp0InInventoryList), the last bag slot is $FF or 0 and the gold is at
; least 100, it sets the low nibble of wPendingFieldEvent to $0A (high nibble kept) and returns A =
; 0. Otherwise it returns A = 1 when any of the four tiles is at or below wMaxBlockingTile, else A =
; 0. (C2, E-0377)
; on map type 1, standing on tiles at or above wMapTallTileMin, a 1-in-8 roll sets event $0A in
; wPendingFieldEvent unless item $2C is owned or the gold is below 100; then A = 1 when any tile
; under the player is blocking (E-0128)
RollFieldEventOnTallTiles::
    ld a, [wMapSpriteKind]
    and $0f
    dec a
    jr nz, .skip
    ld b, $04
    ld hl, wTilesUnderPoint

.loop:
    ld a, [hli]
    ld c, a
    ld a, [wMapTallTileMin]
    cp c
    jr c, .next
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    jr nz, .skip
    ld a, $2c
    ldh [hTemp0], a
    call FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .skip
    ld a, [wInventory + $17]
    or a
    jr z, .read_gold_hi
    cp $ff
    jr nz, .skip

.read_gold_hi:
    ld a, [wGoldHi]
    ld c, a
    ld a, [wGoldMid]
    or c
    jr nz, .check_pending_field_event
    ld a, [wGoldLo]
    cp $64
    jr c, .skip

.check_pending_field_event:
    ld a, [wPendingFieldEvent]
    and $f0
    or $0a
    ld [wPendingFieldEvent], a
    xor a
    ret

.next:
    dec b
    jr nz, .loop

.skip:
    ld b, $04
    ld hl, wTilesUnderPoint

.loop2:
    ld a, [hli]
    ld c, a
    ld a, [wMaxBlockingTile]
    cp c
    jr c, .next2
    jr .return_01

.next2:
    dec b
    jr nz, .loop2
    xor a
    ret

.return_01:
    ld a, $01
    ret

; Sixteen bytes indexed by the pending event's kind (wPendingFieldEvent & $0F): the field sprite
; graphics id of that kind. RunPendingFieldEventPendingFieldEvent_PlaceSprite stores the byte in
; wSpriteSlots + 2 and in hTemp0 (hTemp1 = 0, hTemp2 = 1 to use FieldSpriteGraphicsTable, hTemp3 =
; palette slot 5, destination vTiles0 + $500) and runs DecompressGraphicsTemp0ToTemp4. (C1, E-0372)
PendingFieldEventSpriteIds::
    db $12, $15, $3d, $3e, $10, $11, $17, $15, $14, $13, $57, $12, $15, $12, $14, $10

; Four (X, Y) pixel pairs, 8 bytes: ($20, $20), ($70, $60), ($20, $60), ($70, $20).
; RunPendingFieldEventPendingFieldEvent_PlaceSprite picks one with NextTableByte (wRandomHi & 3),
; writes X to wSpriteSlots + 4 and + $0B and Y to wSpriteSlots + 5 and + $0C, then tests the tiles
; there (ReadTileBuffer2x2AtPixel_Bank12 with B = X, C = Y, then RollFieldEventOnTallTiles). (C1,
; E-0372)
PendingFieldEventSpritePositions::
    db $20, $20, $70, $60, $20, $60, $70, $20

; Returns A = 1, clearing the pending town event, on map $30 screen (5, 5) outside key worlds after
; EVENT_WELCOME_YOUNG_HUMAN_I_HEARD but before EVENT_SCENE_CRATE; otherwise A = 0. (C2, E-0357;
; probed E-0377)
ClearPendingFieldEventWhenFieldIdle_BeforeCrate::
    ld a, [wMapType]
    bit 7, a
    jp nz, .return_0
    ldh a, [hMapId]
    cp $30
    jp nz, .return_0
    ldh a, [hMapScreenX]
    cp $05
    jp nz, .return_0
    ldh a, [hMapScreenY]
    cp $05
    jp nz, .return_0
    ld de, EVENT_SCENE_CRATE
    call TestFlagBit
    jr c, .return_0
    ld de, EVENT_WELCOME_YOUNG_HUMAN_I_HEARD
    call TestFlagBit
    jr nc, .return_0
    ld a, $00
    ld [wPendingFieldEvent], a
    ld a, $01
    ret

.return_0:
    xor a
    ret

; hTemp0/hTemp1 = a species word: hTemp0 = the party index (wPartyList order) of the first member
; whose MON_SPECIES word equals it, or $80 when none does. SRAM is enabled for the search and
; disabled after. Talk events in bank $13 and scenes in banks $5F and $73 far-call it. (C2, E-0377)
; hTemp0 = the party index whose record species (field $0B) equals the word hTemp0/7, or $80 when
; none (E-0125)
FindPartyIndexOfSpeciesTemp0::
    ld a, $0a
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hli]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    cp e
    jr nz, .next
    ldh a, [hTemp1]
    cp d
    jr z, .read_party_count

.next:
    dec b
    jr nz, .loop
    ld a, $80
    ldh [hTemp0], a
    xor a
    ld [rRAMG], a
    ret

.read_party_count:
    ld a, [wPartyCount]
    sub b
    ldh [hTemp0], a
    xor a
    ld [rRAMG], a
    ret

; hTemp0 = an item id: hTemp0 = the index of the first wInventory slot holding it, or $FF when an
; empty slot ($00 or $FF) comes first or none of the 24 slots holds it. B, C and HL change. Talk and
; field events in banks $04, $12, $13 and others far-call it to test whether the bag holds an item.
; (C2, E-0377)
; hTemp0 = the index of the first byte of the 24-entry list at wInventory equal to hTemp0; $FF when
; an entry is $00 or $FF first or no entry matches
FindTemp0InInventoryList::
    ldh a, [hTemp0]
    ld c, a
    ld b, $00
    ld hl, wInventory

.loop:
    ld a, [hl]
    cp $ff
    jr z, .set_temp0_to_FF
    or a
    jr z, .set_temp0_to_FF
    cp c
    jr z, .set_temp0
    inc hl
    inc b
    ld a, b
    cp $18
    jr nz, .loop

.set_temp0_to_FF:
    ld a, $ff
    ldh [hTemp0], a
    ret

.set_temp0:
    ld a, b
    ldh [hTemp0], a
    ret

; hTemp0 = an inventory slot (0-$17): removes it by moving each later wInventory byte down one slot
; and setting the last slot, wInventory + $17, to $FF; for slot $17 only that store happens. There
; is no range check (a slot above $17 runs the copy past the bag). Item-taking events in banks $04,
; $0F, $13 and others call it, usually with a slot from FindTemp0InInventoryList. (C2, E-0377)
; hTemp0 = inventory slot: moves each wInventory byte after it down by one up to slot $17 (the last
; slot keeps its old value), then wInventory + $17 = $FF; nothing moves when the slot is $17
; (E-0106)
RemoveInventorySlotShiftDown::
    ldh a, [hTemp0]
    cp $17
    jr z, .set_inventory_to_FF
    ld b, a
    ld hl, wInventory
    add l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    inc hl
    ld a, [hld]
    ld [hli], a
    inc b
    ld a, b
    cp $17
    jr nz, .loop

.set_inventory_to_FF:
    ld a, $ff
    ld [wInventory + $17], a
    ret

; Searches the party for a dancer: for each wPartyList record reads the MON_SKILLS bytes up to the
; first $FF (at most 8); hTemp1 = the party index of the first member knowing one of SKILL_ODDDANCE
; to SKILL_SIDESTEP ($76-$7D) or SKILL_DANCESHUT ($92) and hTemp2 = that skill, or hTemp1 = $80 with
; hTemp2 unchanged. SRAM is enabled for the search and disabled after. YoldTalkEvents_MermaidPast
; (bank $04) far-calls it. (C2, E-0377)
; hTemp1 = the index of the first party member knowing skill $76-$7D or $92 and hTemp2 = that skill,
; or hTemp1 = $80 (E-0128)
FindPartyMemberWithSkill76To7DOr92::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    xor a
    ldh [hTemp1], a

.loop:
    push bc
    ldh a, [hTemp1]
    ld hl, wPartyList
    add_a_to_hl
    ld b, $08
    ld c, $34

.loop2:
    ld a, [hl]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp $ff
    jr z, .check_temp1
    ld e, $76
    cp e
    jr z, .set_temp2
    ld e, $77
    cp e
    jr z, .set_temp2
    ld e, $78
    cp e
    jr z, .set_temp2
    ld e, $79
    cp e
    jr z, .set_temp2
    ld e, $7a
    cp e
    jr z, .set_temp2
    ld e, $7b
    cp e
    jr z, .set_temp2
    ld e, $7c
    cp e
    jr z, .set_temp2
    ld e, $7d
    cp e
    jr z, .set_temp2
    ld e, $92
    cp e
    jr z, .set_temp2
    inc c
    dec b
    jr nz, .loop2

.check_temp1:
    ldh a, [hTemp1]
    inc a
    ldh [hTemp1], a
    pop bc
    dec b
    jr nz, .loop
    ld a, $80
    ldh [hTemp1], a
    xor a
    ld [rRAMG], a
    ret

.set_temp2:
    ld a, e
    ldh [hTemp2], a
    pop bc
    xor a
    ld [rRAMG], a
    ret

; Clears hTemp1 and returns. GreatLogTalkEvents_Talk204 far-calls it and returns early only when
; hTemp1 bit 7 is set, so its test always passes. (C2, E-0370; probed E-0377)
GreatLogTalkEvents_Talk204_PassCheck::
    xor a
    ldh [hTemp1], a
    ret

; hTemp0/hTemp1 = an amount taken from the 24-bit gold (wGoldLo/Mid/Hi), but the floor test is
; inverted: with wGoldHi = 0 the amount is subtracted with no check, so a larger amount wraps the
; gold to $FFxxxx; with wGoldHi nonzero a wGoldMid:wGoldLo below the amount clears all the gold to 0
; (65,552 - 32 gives 0), otherwise it subtracts normally. Casino and other Great Log scenes in bank
; $73 far-call it (the casino ship takes 100 gold with it). (C2, E-0377)
; wGold -= the word hTemp0/hTemp1; when gold is smaller than the amount it becomes 0 instead
; (E-0075)
SubtractGoldFloorZero::
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [wGoldHi]
    or a
    jr z, .read_gold_lo
    ld a, [wGoldMid]
    cp h
    jr c, .clear_gold_lo
    jr z, .check_gold_lo
    jr .read_gold_lo

.check_gold_lo:
    ld a, [wGoldLo]
    cp l
    jr c, .clear_gold_lo

.read_gold_lo:
    ld a, [wGoldLo]
    sub l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    sbc h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc $00
    ld [wGoldHi], a
    ret

.clear_gold_lo:
    xor a
    ld [wGoldLo], a
    ld [wGoldMid], a
    ld [wGoldHi], a
    ret

; hTemp0/hTemp1 = an amount: adds it to the 24-bit gold (wGoldLo/Mid/Hi) and caps the result at
; 99,999 ($01869F). Talk events in bank $13, Great Log scenes in bank $73 and two routines of this
; bank call it. (C2, E-0377)
; adds the word hTemp0/hTemp1 to the 24-bit wGoldLo/Mid/Hi and caps the result at $01869F (99,999)
; (E-0074)
AddGoldCapped::
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [wGoldLo]
    add l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    adc h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    adc $00
    ld [wGoldHi], a
    cp $01
    ret c
    jr z, .check_gold_mid
    jr .set_gold_lo_to_9F

.check_gold_mid:
    ld a, [wGoldMid]
    cp $86
    ret c
    jr z, .check_gold_lo
    jr .set_gold_lo_to_9F

.check_gold_lo:
    ld a, [wGoldLo]
    cp $9f
    ret c

.set_gold_lo_to_9F:
    ld a, $9f
    ld [wGoldLo], a
    ld a, $86
    ld [wGoldMid], a
    ld a, $01
    ld [wGoldHi], a
    ret

; Halves the gold (the 24-bit wGoldHi/Mid/Lo shifted right): the return message's penalty. (C2,
; E-0357; probed E-0377)
HalveGold::
    ld a, [wGoldHi]
    srl a
    ld [wGoldHi], a
    ld a, [wGoldMid]
    rra
    ld [wGoldMid], a
    ld a, [wGoldLo]
    rra
    ld [wGoldLo], a
    ret

; The gold penalty of DeductGoldPenaltyAndFormatLoss (bank $73): takes all the gold when it is below
; 150, 150 when it is below 1,500, otherwise one tenth of it rounded down (Divide24ByA by 10). (C2,
; E-0377)
; takes gold: all of it when below 150, 150 when below 1,500 ($05DC), otherwise one tenth
; (Divide24ByA, rounded down) (E-0075)
DeductGoldPenalty::
    ld a, [wGoldHi]
    or a
    jr nz, .read_gold_lo
    ld a, [wGoldMid]
    or a
    jr nz, .check_gold_mid
    ld a, [wGoldLo]
    cp $96
    jr nc, .check_gold_mid
    ld l, a
    ld h, $00
    jr .read_gold_lo2

.check_gold_mid:
    ld a, [wGoldMid]
    cp $05
    jr c, .skip
    jr nz, .read_gold_lo
    ld a, [wGoldLo]
    cp $dc
    jr nc, .read_gold_lo

.skip:
    ld hl, $0096
    jr .read_gold_lo2

.read_gold_lo:
    ld a, [wGoldLo]
    ld l, a
    ld a, [wGoldMid]
    ld h, a
    ld a, [wGoldHi]
    ld e, a
    ld a, $0a
    call Divide24ByA

.read_gold_lo2:
    ld a, [wGoldLo]
    sub l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    sbc h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc $00
    ld [wGoldHi], a
    ret
    ds $8f, $00
