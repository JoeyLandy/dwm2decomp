; ROM bank $12: field objects and paths, key-world field code, arena rounds
; The annotated listing of this bank is build/listing/bank12.asm.

SECTION "Bank 12", ROMX[$4000], BANK[$12]
    db $12

; implements script command type 9D (SCRIPT_COUNTDOWN_MESSAGE): a key-world/field talk event (group
; $1E, dispatched by CountDownTalkCountdownThenDispatchTalkEvent: one message); named from its
; trigger and calls (E-0038)
CountdownMessage::
    ld a, [wScriptStep]
    jumptable
    dw CountdownMessage_ToStartMessageAAndStep
    dw CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12

; step 0 of CountdownMessage: calls StartMessageA; advances wScriptStep (E-0347)
; why: step 0 of CountdownMessage (when wScriptStep = 0); CountdownMessage: implements script
; command type 9D (SCRIPT_COUNTDOWN_MESSAGE): a key-world/field talk event (group $1E, dispatched by
; ... (E-0352)
CountdownMessage_ToStartMessageAAndStep::
    ld a, $10
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9C (SCRIPT_ENCOUNTER_MESSAGE): a key-world/field talk event (group
; $1D, dispatched by TickRandomEncounterCounter: one message (StartMessageA)); named from its
; trigger and calls (E-0038)
EncounterCounterMessage::
    ld a, [wScriptStep]
    jumptable
    dw EncounterCounterMessage_ToStartMessageAAndStep
    dw CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12

; step 1 of CountdownMessage: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 1 of CountdownMessage (when wScriptStep = 1); CountdownMessage: implements script
; command type 9D (SCRIPT_COUNTDOWN_MESSAGE): a key-world/field talk event (group $1E, dispatched by
; ... (E-0352)
CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of EncounterCounterMessage: calls StartMessageA; advances wScriptStep (E-0347)
; why: step 0 of EncounterCounterMessage (when wScriptStep = 0); EncounterCounterMessage: implements
; script command type 9C (SCRIPT_ENCOUNTER_MESSAGE): a key-world/field talk event (group $1D,
; dispatched by ... (E-0352)
EncounterCounterMessage_ToStartMessageAAndStep::
    ld a, $0f
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9A (SCRIPT_RANDOM_BATTLE): a key-world/field talk event (group $19,
; dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: picks a battle intro (NextRandomSeed) and
; starts a battle (SetModeState3AndSaveScreen)); named from its trigger and calls (E-0038)
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

; implements script command type 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group
; $1C: moves an object by step deltas with the followers, then fades); named from its trigger and
; calls (E-0038)
ObjectPath1C::
    ld a, [wScriptStep]
    jumptable
    dw ObjectPath1C_SetBit2AtHL_B12
    dw ObjectPath1C_UpdateFollowersOnStep_Bank12
    dw ObjectPath1C_UpdateFollowersOnStep_Bank12_AddStepDeltaToPointedByte
    dw ObjectPath1C_AddStepDeltaToPointedByte
    dw ObjectPath1C_WriteFollowerRecordsAndMapIdEtc
    dw ObjectPath1C_SetBit2AtHL_B12_SetPlayerFacing
    dw ObjectPath1C_WritePlayerY
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_SetPlayerFacing
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_SetFollowerRecords
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_SetScriptStep
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12
    dw ObjectPath1C_ClearBit2AtHL_Bank12

; step 10 of ObjectPath1C: calls ScriptApplyStepDeltaAtDE_Bank12 (E-0347)
; why: step 10 of ObjectPath1C (when wScriptStep = 10); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12::
    xor a
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $c]
    inc a
    ld [wFollowerRecords + $c], a
    ld de, wFollowerRecords + $c
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; step 9 of ObjectPath1C: calls ScriptApplyStepDeltaAtDE_Bank12; increments wFollowerRecords + $c;
; returns unless wScriptParam0 is 0; sets wScriptStep to $0b; also changes HL, DE and A by register
; arithmetic (E-0347)
; why: step 9 of ObjectPath1C (when wScriptStep = 9); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_SetScriptStep::
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

; step 8 of ObjectPath1C: sets wFollowerRecords to 0; calls ScriptApplyStepDeltaAtDE_Bank12;
; increments wFollowerRecords + $7; increments wFollowerRecords + $c; returns unless wScriptParam0
; is 0; sets wScriptStep to $0b (E-0347)
; why: step 8 of ObjectPath1C (when wScriptStep = 8); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_SetFollowerRecords::
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

; step 7 of ObjectPath1C: sets hPlayerFacing to 0; calls ScriptApplyStepDeltaAtDE_Bank12; increments
; hPlayerY; increments wFollowerRecords + $2; increments wFollowerRecords + $7; increments
; wFollowerRecords + $c (E-0347)
; why: step 7 of ObjectPath1C (when wScriptStep = 7); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_SetPlayerFacing::
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

; step 6 of ObjectPath1C: increments wFollowerRecords + $c; increments wFollowerRecords + $7;
; increments wFollowerRecords + $2; increments hPlayerY; returns unless hPlayerY is $20; advances
; wScriptStep (E-0347)
; why: step 6 of ObjectPath1C (when wScriptStep = 6); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_WritePlayerY::
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

; step 5 of ObjectPath1C: sets hPlayerFacing to 2; sets wFollowerRecords to 2; calls
; SetBit2AtHL_B12; advances wScriptStep (E-0347)
; why: step 5 of ObjectPath1C (when wScriptStep = 5); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_SetBit2AtHL_B12_SetPlayerFacing::
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

; step 4 of ObjectPath1C: increments hPlayerY; increments wFollowerRecords + $2; increments
; wFollowerRecords + $7; may return early; sets hMapId to 0; sets hMapScreenX to 0; sets hMapScreenY
; to 2; sets wWarpDestX to $70; sets wWarpDestY to $f0; sets wFieldTransitionKind to 0; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 4 of ObjectPath1C (when wScriptStep = 4); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_WriteFollowerRecordsAndMapIdEtc::
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

; step 3 of ObjectPath1C: increments hPlayerY; increments wFollowerRecords + $2; increments
; wFollowerRecords + $7; sets wFollowerRecords to 2; increments wFollowerRecords + $b; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; continues in
; ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 3 of ObjectPath1C (when wScriptStep = 3); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_AddStepDeltaToPointedByte::
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
    jp ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; step 2 of ObjectPath1C: calls UpdateFollowersOnStep_Bank12; sets wFollowerRecords to 2; increments
; hPlayerY; copies E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte;
; continues in ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 2 of ObjectPath1C (when wScriptStep = 2); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_UpdateFollowersOnStep_Bank12_AddStepDeltaToPointedByte::
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
    jp ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; step 1 of ObjectPath1C: calls UpdateFollowersOnStep_Bank12; sets hPlayerFacing to 2; increments
; hPlayerY; copies E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte;
; continues in ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 1 of ObjectPath1C (when wScriptStep = 1); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_UpdateFollowersOnStep_Bank12::
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
    jp ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; step 0 of ObjectPath1C: calls SetBit2AtHL_B12; calls UpdateFollowersOnStep_Bank12; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments hPlayerX;
; continues in ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 0 of ObjectPath1C (when wScriptStep = 0); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_SetBit2AtHL_B12::
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
    jp ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; implements script command type 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group
; $1B: moves an object by step deltas with the followers, then fades); named from its trigger and
; calls (E-0038)
ObjectPath1B::
    ld a, [wScriptStep]
    jumptable
    dw ObjectPath1B_SetBit2AtHL_B12
    dw ObjectPath1B_UpdateFollowersOnStep_Bank12
    dw ObjectPath1B_UpdateFollowersOnStep_Bank12_AddStepDeltaToPointedByte
    dw ObjectPath1B_AddStepDeltaToPointedByte
    dw ObjectPath1B_WriteFollowerRecordsAndMapIdEtc
    dw ObjectPath1B_SetBit2AtHL_B12_SetPlayerFacing
    dw ObjectPath1B_UpdateFollowersOnStep_Bank12_SetPlayerY
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_SetPlayerFacing
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_SetFollowerRecords
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_SetScriptStep
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12
    dw ObjectPath1C_ClearBit2AtHL_Bank12

; step 11 of ObjectPath1C: calls ClearBit2AtHL_Bank12; sets wScriptStartRequest to $80 (E-0347)
; why: step 11 of ObjectPath1C (when wScriptStep = 11); ObjectPath1C: implements script command type
; 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1C_ClearBit2AtHL_Bank12::
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 10 of ObjectPath1B: calls ScriptApplyStepDeltaAtDE_Bank12 (E-0347)
; why: step 10 of ObjectPath1B (when wScriptStep = 10); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12::
    ld a, $03
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $b]
    dec a
    ld [wFollowerRecords + $b], a
    ld de, wFollowerRecords + $c
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; step 9 of ObjectPath1B: calls ScriptApplyStepDeltaAtDE_Bank12; decrements wFollowerRecords + $6;
; decrements wFollowerRecords + $c; returns unless wScriptParam0 is 0; sets wScriptStep to $0b
; (E-0347)
; why: step 9 of ObjectPath1B (when wScriptStep = 9); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_SetScriptStep::
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

; step 8 of ObjectPath1B: sets wFollowerRecords to 3; calls ScriptApplyStepDeltaAtDE_Bank12;
; decrements wFollowerRecords + $7; decrements wFollowerRecords + $c; returns unless wScriptParam0
; is 0; sets wScriptStep to $0b (E-0347)
; why: step 8 of ObjectPath1B (when wScriptStep = 8); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_SetFollowerRecords::
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

; step 7 of ObjectPath1B: sets hPlayerFacing to 3; calls ScriptApplyStepDeltaAtDE_Bank12; decrements
; hPlayerX; decrements wFollowerRecords + $2; decrements wFollowerRecords + $7; decrements
; wFollowerRecords + $c (E-0347)
; why: step 7 of ObjectPath1B (when wScriptStep = 7); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_SetPlayerFacing::
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

; DE = address of a byte: adds the step delta for wScriptParam0, then wScriptParam0 += 2; at $20 it
; is reset and wScriptStep += 1 (the bank-$12 form of ScriptApplyStepDeltaAtDE) (E-0117)
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

; step 6 of ObjectPath1B: calls UpdateFollowersOnStep_Bank12; decrements hPlayerY; returns unless
; hPlayerY is $50; advances wScriptStep (E-0347)
; why: step 6 of ObjectPath1B (when wScriptStep = 6); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_UpdateFollowersOnStep_Bank12_SetPlayerY::
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

; step 5 of ObjectPath1B: sets hPlayerFacing to 2; sets wFollowerRecords to 2; calls
; SetBit2AtHL_B12; advances wScriptStep (E-0347)
; why: step 5 of ObjectPath1B (when wScriptStep = 5); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_SetBit2AtHL_B12_SetPlayerFacing::
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

; step 4 of ObjectPath1B: decrements hPlayerY; decrements wFollowerRecords + $2; decrements
; wFollowerRecords + $7; may return early; sets hMapId to $1a; sets hMapScreenX to 2; sets
; hMapScreenY to 0; sets wWarpDestX to $60; sets wWarpDestY to $b0; sets wFieldTransitionKind to 0;
; calls ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 4 of ObjectPath1B (when wScriptStep = 4); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_WriteFollowerRecordsAndMapIdEtc::
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

; step 3 of ObjectPath1B: decrements hPlayerY; decrements wFollowerRecords + $2; decrements
; wFollowerRecords + $7; decrements wFollowerRecords + $c; copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; continues in
; ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 3 of ObjectPath1B (when wScriptStep = 3); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_AddStepDeltaToPointedByte::
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
    jr ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; step 2 of ObjectPath1B: calls UpdateFollowersOnStep_Bank12; decrements hPlayerY; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; continues in
; ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 2 of ObjectPath1B (when wScriptStep = 2); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_UpdateFollowersOnStep_Bank12_AddStepDeltaToPointedByte::
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
    jr ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; step 1 of ObjectPath1B: calls UpdateFollowersOnStep_Bank12; decrements hPlayerY; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; continues in
; ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0 (E-0347)
; why: step 1 of ObjectPath1B (when wScriptStep = 1); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_UpdateFollowersOnStep_Bank12::
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
    jr ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; step 0 of ObjectPath1B: calls SetBit2AtHL_B12; calls UpdateFollowersOnStep_Bank12; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; decrements hPlayerY (E-0347)
; why: step 0 of ObjectPath1B (when wScriptStep = 0); ObjectPath1B: implements script command type
; 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step
; deltas with the ... (E-0352)
ObjectPath1B_SetBit2AtHL_B12::
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

; Increments wScriptParam0; returns unless wScriptParam0 is $20; sets wScriptParam0 to 0; advances
; wScriptStep (E-0347)
; why: part of ObjectPath1B_SetBit2AtHL_B12, in step 0 of ObjectPath1B (when wScriptStep = 0);
; ObjectPath1B: implements script command type 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk
; event (group $1B: moves an object by step deltas with the ... (E-0352)
ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0::
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

; implements script command type 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from
; ArenaRankMessageTable and foes from ArenaEncounterLists by wAreaGraphicsIndex, advancing the round
; (IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea); reached through ScriptCommand96 in bank $10
; (E-0038, E-0246)
ArenaRounds::
    ld a, [wScriptStep]
    jumptable
    dw ArenaRounds_ScriptStartFadeAndAdvanceStep
    dw ArenaRounds_RunMessageBoxThenContinue_SetBit2AtHL_B12
    dw ArenaRounds_SetBit2AtHL_B12
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaRounds_StartArenaRankMessage_BackRecordCapacity_2
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaRounds_StartArenaRankMessage_BackRecordCapacity
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep_AdvanceScriptStep
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaRounds_StartArenaRankMessage
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_QueueSoundEffect
    dw ArenaRounds_FullyHealParty
    dw ArenaRounds_RestartMapMusic

; step 21 of ArenaRounds: calls StartArenaRankMessage; advances wScriptStep; decrements
; wRecordCapacity (E-0347)
; why: step 21 of ArenaRounds (when wScriptStep = 21); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_StartArenaRankMessage::
    ld a, $07
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ret

; step 13 of ArenaRounds: decrements wRecordCapacity; branches on wRecordCapacity; calls
; StartArenaRankMessage; sets wScriptStep to $16; calls StartArenaRankMessage; advances wScriptStep;
; calls IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea; calls
; ArenaRounds_WriteBattleIntroKindAndEncounterKind (E-0347)
; why: step 13 of ArenaRounds (when wScriptStep = 13); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_StartArenaRankMessage_BackRecordCapacity::
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
    farcall ArenaRounds_WriteBattleIntroKindAndEncounterKind
    ret

; step 5 of ArenaRounds: decrements wRecordCapacity; branches on wRecordCapacity; calls
; StartArenaRankMessage; sets wScriptStep to $16; calls StartArenaRankMessage; advances wScriptStep;
; calls IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea; calls
; ArenaRounds_WriteBattleIntroKindAndEncounterKind (E-0347)
; why: step 5 of ArenaRounds (when wScriptStep = 5); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_StartArenaRankMessage_BackRecordCapacity_2::
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
    farcall ArenaRounds_WriteBattleIntroKindAndEncounterKind
    ret

; step 1 of ArenaRounds: sets hFieldDrawFlags to $0e; calls RunMessageBoxThenContinue; may return
; early; calls SetBit2AtHL_B12; sets hPlayerFacing to 0; sets hPlayerX to $40; increments
; wArenaFlags; sets wMessageIndex to 0; advances wScriptStep (E-0347)
; why: step 1 of ArenaRounds (when wScriptStep = 1); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_RunMessageBoxThenContinue_SetBit2AtHL_B12::
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

; step 0 of ArenaRounds: sets hMapId to $0b; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $e0; sets wWarpDestY to 0; sets wFieldTransitionKind to 0; calls
; ScriptStartFadeAndAdvanceStep; calls StartMessageA; sets wArenaFlags to $80 (E-0347)
; why: step 0 of ArenaRounds (when wScriptStep = 0); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_ScriptStartFadeAndAdvanceStep::
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

; implements script command type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from
; ArenaRankMessageTable (StartArenaRankMessage) and foes from GridEncounterTable by wGridCursorX and
; wScreenCountPlusOne (battle intro 4, encounter kind 2; ScriptCommand95's Shared02); reached
; through ScriptCommand95 in bank $10 (E-0038, E-0246)
ArenaGridBattle::
    ld a, [wScriptStep]
    jumptable
    dw ArenaGridBattle_ScriptStartFadeAndAdvanceStep
    dw ArenaGridBattle_RunMessageBoxThenContinue
    dw ArenaGridBattle_RunMessageBoxThenContinue_SetBit2AtHL_B12
    dw ArenaRounds_SetBit2AtHL_B12
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaGridBattle_StartArenaRankMessage_SetupScreenCountPlusOneFromRecordCapacity_2
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaGridBattle_StartArenaRankMessage_SetupScreenCountPlusOneFromRecordCapacity
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep_AdvanceScriptStep
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaGridBattle_StartArenaRankMessage
    dw ArenaRounds_RunMessageBoxThenContinue
    dw ArenaRounds_QueueSoundEffect
    dw ArenaRounds_FullyHealParty
    dw ArenaRounds_RestartMapMusic

; step 25 of ArenaRounds: calls RestartMapMusic; sets wTalkEventIndex to 1; sets wTalkEventGroup to
; $65; copies wScriptReturnBank to wScriptStartRequest; copies wScriptReturnLo to wScriptPointerLo;
; copies wScriptReturnHi to wScriptPointerHi; sets hSpriteWindowClipMode to 2; sets
; wScriptCommandType to $f7; sets wScriptInDataBank to 1 (E-0347)
; why: step 25 of ArenaRounds (when wScriptStep = 25); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_RestartMapMusic::
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

; step 24 of ArenaRounds: calls FullyHealParty; sets hMapId to 4; sets hMapScreenX to 1; sets
; hMapScreenY to 0; sets wWarpDestX to $40; sets wWarpDestY to $30; sets wFieldTransitionKind to 3;
; calls ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 24 of ArenaRounds (when wScriptStep = 24); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_FullyHealParty::
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

; step 23 of ArenaRounds: increments wScriptParam0; branches on wScriptParam0; plays sound $6d; may
; return early; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 23 of ArenaRounds (when wScriptStep = 23); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_QueueSoundEffect::
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

; step 22 of ArenaGridBattle: calls StartArenaRankMessage; advances wScriptStep; decrements
; wRecordCapacity (E-0347)
; why: step 22 of ArenaGridBattle (when wScriptStep = 22); ArenaGridBattle: implements script
; command type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable
; (StartArenaRankMessage) ... (E-0352, E-0038, E-0246)
ArenaGridBattle_StartArenaRankMessage::
    ld a, $07
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ret

; step 18 of ArenaRounds: calls StartArenaRankMessage; advances wScriptStep (E-0347)
; why: step 18 of ArenaRounds (when wScriptStep = 18); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_ToStartArenaRankMessageAndStep_AdvanceScriptStep::
    ld a, $06
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ret

; step 14 of ArenaGridBattle: calls StartArenaRankMessage; advances wScriptStep; decrements
; wRecordCapacity; branches on wArenaRank; calls SetupScreenCountPlusOneFromRecordCapacity; calls
; ArenaGridBattle_WriteBattleIntroKindAndEncounterKind; calls
; SetupScreenCountPlusOneFromRecordCapacity; calls
; ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_SetBattleIntroKind (E-0347)
; why: step 14 of ArenaGridBattle (when wScriptStep = 14); ArenaGridBattle: implements script
; command type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable
; (StartArenaRankMessage) ... (E-0352, E-0038, E-0246)
ArenaGridBattle_StartArenaRankMessage_SetupScreenCountPlusOneFromRecordCapacity::
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
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind
    ret

.call_setup_screen_count_plus_one_from_record:
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_SetBattleIntroKind
    ret

; step 10 of ArenaRounds: calls StartArenaRankMessage; advances wScriptStep (E-0347)
; why: step 10 of ArenaRounds (when wScriptStep = 10); ArenaRounds: implements script command type
; 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from
; ... (E-0352, E-0038, E-0246)
ArenaRounds_ToStartArenaRankMessageAndStep::
    ld a, $04
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of ArenaRounds: may return early; sets wFieldEventKind to 7; sets wObject1 + OBJ_STATE to
; 3; sets wObject2 + OBJ_STATE to 3; sets wObject3 + OBJ_STATE to 3; calls ClearBit2AtHL_Bank12;
; plays sound $00; advances wScriptStep (E-0347)
; why: step 9 of ArenaRounds (when wScriptStep = 9); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_ClearBit2AtHL_Bank12::
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

; step 8 of ArenaRounds: branches on wMessageIndex; increments wMessageIndex; branches on
; wMessageIndex; sets wSpriteSlotCount to 2; branches on $02; sets wSpriteSlotCount to 3; branches
; on $03; sets wSpriteSlotCount to 4; branches on the byte at wSpriteSlots + $c; sets wSpriteSlots +
; $c to 1; branches on the byte at wSpriteSlots + $c; sets wSpriteSlots + $c to 0; then 3 more steps
; (see the code) (E-0347)
; why: step 8 of ArenaRounds (when wScriptStep = 8); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_WriteMessageIndexAndSpriteSlotCount::
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

; step 7 of ArenaRounds: calls SetupMap0BMonsterObjects; sets wOBJPaletteUploadRequest to $7f; sets
; wSpriteSlotCount to 1; calls SetBit2AtHL_B12; sets wFieldEventKind to 0; plays sound $6d; sets
; wMessageIndex to 0; advances wScriptStep (E-0347)
; why: step 7 of ArenaRounds (when wScriptStep = 7); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_SetupMap0BMonsterObjects::
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

; step 6 of ArenaGridBattle: calls StartArenaRankMessage; advances wScriptStep; decrements
; wRecordCapacity; branches on wArenaRank; calls SetupScreenCountPlusOneFromRecordCapacity; calls
; ArenaGridBattle_WriteBattleIntroKindAndEncounterKind; calls
; SetupScreenCountPlusOneFromRecordCapacity; calls
; ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_SetBattleIntroKind (E-0347)
; why: step 6 of ArenaGridBattle (when wScriptStep = 6); ArenaGridBattle: implements script command
; type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable
; (StartArenaRankMessage) ... (E-0352, E-0038, E-0246)
ArenaGridBattle_StartArenaRankMessage_SetupScreenCountPlusOneFromRecordCapacity_2::
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
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind
    ret

.call_setup_screen_count_plus_one_from_record:
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_SetBattleIntroKind
    ret

; step 4 of ArenaRounds: increments wFollowerRecords + $1; increments wFollowerRecords + $6;
; increments wFollowerRecords + $b; decrements wObject1 + OBJ_X; decrements wObject2 + OBJ_X;
; decrements wObject3 + OBJ_X; calls StepScriptParam0Counter_Bank12; may return early; advances
; wScriptStep; increments wRecordCapacity; sets wBattleIntroKind to 4; sets wBattleTransitionSubStep
; to 1; then 1 more step (see the code) (E-0347)
; why: step 4 of ArenaRounds (when wScriptStep = 4); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_StepScriptParam0Counter_Bank12::
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

; step 3 of ArenaRounds: calls RunMessageBoxThenContinue; may return early; sets wMessageIndex to 0;
; advances wScriptStep (E-0347)
; why: step 3 of ArenaRounds (when wScriptStep = 3); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_RunMessageBoxThenContinue::
    xor a
    call RunMessageBoxThenContinue
    ret nc
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of ArenaRounds: calls SetBit2AtHL_B12; branches on wMessageIndex; increments wMessageIndex;
; branches on wMessageIndex; sets hFieldDrawFlags to $0c; branches on $0c; sets hFieldDrawFlags to
; 8; branches on $08; sets hFieldDrawFlags to 0; branches on wScriptParam0; calls
; UpdateFollowersOnStep_Bank12; increments hPlayerY; then 32 more steps (see the code) (E-0347)
; why: step 2 of ArenaRounds (when wScriptStep = 2); ArenaRounds: implements script command type 96
; (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ...
; (E-0352, E-0038, E-0246)
ArenaRounds_SetBit2AtHL_B12::
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

; step 2 of ArenaGridBattle: calls RunMessageBoxThenContinue; may return early; calls
; SetBit2AtHL_B12; sets hPlayerFacing to 0; sets hPlayerX to $40; plays sound $6d; copies
; wFieldEventKind to wScriptParam1; sets wFieldEventKind to 0; sets wMessageIndex to 0; advances
; wScriptStep (E-0347)
; why: step 2 of ArenaGridBattle (when wScriptStep = 2); ArenaGridBattle: implements script command
; type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable
; (StartArenaRankMessage) ... (E-0352, E-0038, E-0246)
ArenaGridBattle_RunMessageBoxThenContinue_SetBit2AtHL_B12::
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

; step 1 of ArenaGridBattle: calls RunMessageBoxThenContinue; may return early; calls
; StartArenaRankMessage; sets hFieldDrawFlags to $0e; advances wScriptStep (E-0347)
; why: step 1 of ArenaGridBattle (when wScriptStep = 1); ArenaGridBattle: implements script command
; type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable
; (StartArenaRankMessage) ... (E-0352, E-0038, E-0246)
ArenaGridBattle_RunMessageBoxThenContinue::
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

; step 0 of ArenaGridBattle: sets hMapId to $0b; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $e0; sets wWarpDestY to 0; sets wFieldTransitionKind to 0; calls
; ScriptStartFadeAndAdvanceStep; calls StartArenaRankMessage; sets wArenaFlags to 0 (E-0347)
; why: step 0 of ArenaGridBattle (when wScriptStep = 0); ArenaGridBattle: implements script command
; type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable
; (StartArenaRankMessage) ... (E-0352, E-0038, E-0246)
ArenaGridBattle_ScriptStartFadeAndAdvanceStep::
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

; starts the message at ArenaRankMessageTable + 2 * A + 16 * wArenaRank (16 * 5 when bit 7 of
; wArenaFlags is set) (E-0125)
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

; StartArenaRankMessage reads the low byte at $48B9 + 2 * A + 16 * wArenaRank (row 5 when
; wArenaFlags bit 7 is set) and passes it to StartMessageA, a string of the group already in
; wMessageGroup; 6 rows of 8 words (E-0237, C1)
; record: one row per arena rank
ArenaRankMessageTable::
    dw $0040, $008c, $0013, $0017, $0014, $0018, $0015, $001b ; id 0
    dw $0041, $008d, $0013, $0017, $0014, $0018, $0015, $001c ; id 1
    dw $0042, $008e, $0013, $0017, $0014, $0018, $0015, $001d ; id 2
    dw $0043, $008f, $0013, $0017, $0014, $0018, $0015, $001e ; id 3
    dw $0044, $0090, $0013, $0017, $0014, $0018, $0015, $001f ; id 4
    dw $ffff, $ffff, $0013, $0019, $0014, $001a, $0016, $0020 ; id 5

; implements script command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21,
; dispatched from the link screens (GameMode5_Update, RunLinkSession4ScreenState): graphics and a
; message); named from its trigger and calls (E-0038)
LinkMessageEvent::
    ld a, [wScriptStep]
    jumptable
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetSaveStateFlag

; step 22 of LinkMessageEvent: copies wLinkSaveStateFlag to wSaveStateFlag; sets wGameMode to 8;
; sets wModeState to 0; sets wModeChangeRequest to 1; sets wScriptRunning to 0 (E-0347)
; why: step 22 of LinkMessageEvent (when wScriptStep = 22); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_SetSaveStateFlag::
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

; implements script command type 8F (SCRIPT_NPC_BREED_WARP): a key-world/field talk event (group
; $20, dispatched by NpcBreedMenu_ChooseAndBreed_DispatchTalkEvent: fades, sets the warp destination
; and wSavedPositionValid, and queues the next script and talk event); named from its trigger and
; calls (E-0038)
NpcBreedWarp::
    ld a, [wScriptStep]
    jumptable
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw NpcBreedWarp_WriteMapIdAndMapScreenXEtc
    dw NpcBreedWarp_WriteSpriteSlotsAndTalkEventIndexEtc

; step 24 of NpcBreedWarp: sets wTalkEventIndex to 1; sets wTalkEventGroup to $89; copies
; wScriptReturnBank to wScriptStartRequest; copies wScriptReturnLo to wScriptPointerLo; copies
; wScriptReturnHi to wScriptPointerHi; sets wScriptCommandType to $f4; sets wScriptInDataBank to 1
; (E-0347)
; why: step 24 of NpcBreedWarp (when wScriptStep = 24); NpcBreedWarp: implements script command type
; 8F (SCRIPT_NPC_BREED_WARP): a key-world/field talk event (group $20, dispatched by ... (E-0352)
NpcBreedWarp_WriteSpriteSlotsAndTalkEventIndexEtc::
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

; step 23 of NpcBreedWarp: copies the byte at NpcBreedWarp_WriteMapIdAndMapScreenXEtc_Data to
; hMapId; sets hMapScreenX to 0; sets hMapScreenY to 0; branches on wScreenTableIndex; sets
; hMapScreenX to 2; sets wWarpDestX to $40; sets wWarpDestY to $40; sets hFieldDrawFlags to 0; sets
; wFieldTransitionKind to 0; calls ScriptStartFadeAndAdvanceStep; sets wSavedPositionValid to 1
; (E-0347)
; why: step 23 of NpcBreedWarp (when wScriptStep = 23); NpcBreedWarp: implements script command type
; 8F (SCRIPT_NPC_BREED_WARP): a key-world/field talk event (group $20, dispatched by ... (E-0352)
NpcBreedWarp_WriteMapIdAndMapScreenXEtc::
    ld a, [wScreenTableIndex]
    ld hl, NpcBreedWarp_WriteMapIdAndMapScreenXEtc_Data
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

; data read by NpcBreedWarp (10 bytes) (E-0347)
NpcBreedWarp_WriteMapIdAndMapScreenXEtc_Data::
    db $04, $17, $04, $17, $04, $17, $17, $17, $04, $04

; implements script command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group
; $17, dispatched by BreedMenu_TalkEvent17ThenNameEntry: a field object with loaded graphics, a
; message with a name from the string database (CopyStringToBuffer_Bank08)); named from its trigger
; and calls (E-0038)
BreedChildScene::
    ld a, [wScriptStep]
    jumptable
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw BreedChildScene_DecompressGraphicsTemp0ToTemp4
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw BreedChildScene_RunFieldCommandTemp0AndStep
    dw BreedChildScene_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw BreedChildScene_CopyStringToBuffer_Bank08
    dw BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12
    dw BreedChildScene_WriteMapIdAndMapScreenXEtc

; step 17 of BreedChildScene: copies the byte at wChildRecord to wObject1 + OBJ_SPRITE_ID; copies
; the byte at wChildRecord to hTemp0; copies the byte at wChildRecord to hTemp1; sets hTemp2 to 0;
; sets hTemp3 to 6; copies L to hTemp4; copies H to hTemp5; calls DecompressGraphicsTemp0ToTemp4;
; sets hTemp0 to $0d; calls RunFieldCommandTemp0; sets wOBJPaletteUploadRequest to $7f; advances
; wScriptStep (E-0347)
; why: step 17 of BreedChildScene (when wScriptStep = 17); BreedChildScene: implements script
; command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by
; ... (E-0352)
BreedChildScene_DecompressGraphicsTemp0ToTemp4::
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

; implements script command type 8C (SCRIPT_BREED_CHILD_SPRITE): a key-world/field talk event (group
; $16, dispatched by BreedMenu_CopyToChildThenTalkEvent16: loads graphics
; (DecompressGraphicsTemp0ToTemp4) for a field object (RunFieldCommandTemp0)); named from its
; trigger and calls (E-0038)
BreedChildSprite::
    ld a, [wScriptStep]
    jumptable
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw BreedChildSprite_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw BreedChildSprite_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw BreedChildScene_RunFieldCommandTemp0AndStep
    dw BreedChildScene_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw BreedChildScene_CopyStringToBuffer_Bank08
    dw BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12
    dw BreedChildScene_WriteMapIdAndMapScreenXEtc

; step 27 of BreedChildScene: sets hMapId to $0d; sets hMapScreenX to 1; sets hMapScreenY to 0; sets
; hPlayerX to $40; sets hPlayerY to $40; sets wObject5 to 0; sets wSpriteSlotCount to 0; sets
; wFieldEventKind to 0; sets wTalkEventIndex to 1; sets wTalkEventGroup to $6a; copies
; wScriptReturnBank to wScriptStartRequest; copies wScriptReturnLo to wScriptPointerLo; then 4 more
; steps (see the code) (E-0347)
; why: step 27 of BreedChildScene (when wScriptStep = 27); BreedChildScene: implements script
; command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by
; ... (E-0352)
BreedChildScene_WriteMapIdAndMapScreenXEtc::
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

; step 26 of BreedChildScene: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; advances
; wScriptStep; copies wScriptParam0 to hSpriteWindowClipMode (E-0347)
; why: step 26 of BreedChildScene (when wScriptStep = 26); BreedChildScene: implements script
; command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by
; ... (E-0352)
BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ldh [hSpriteWindowClipMode], a
    ret

; step 25 of BreedChildScene: advances wScriptStep; copies the byte at wChildRecord to wStringIndex;
; copies the byte at wChildRecord to wStringCategory; copies E to wStringDestLo; copies D to
; wStringDestHi; calls CopyStringToBuffer_Bank08; branches on the byte at wChildRecord; calls
; StartMessageA; branches on B; sets wTextNumber to $f0; calls StartMessageA; copies
; hSpriteWindowClipMode to wScriptParam0; then 2 more steps (see the code) (E-0347)
; why: step 25 of BreedChildScene (when wScriptStep = 25); BreedChildScene: implements script
; command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by
; ... (E-0352)
BreedChildScene_CopyStringToBuffer_Bank08::
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

; step 21 of BreedChildScene: branches on wScriptParam0; plays sound $74; calls
; StepScriptParam0Counter_Bank12; may return early; sets wObject5 to 0; sets wObject1 + OBJ_STATE to
; 0; sets wObject1 + OBJ_Y to $3c; advances wScriptStep (E-0347)
; why: step 21 of BreedChildScene (when wScriptStep = 21); BreedChildScene: implements script
; command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by
; ... (E-0352)
BreedChildScene_StepScriptParam0Counter_Bank12::
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

; step 20 of BreedChildScene: sets hTemp0 to $0e; calls RunFieldCommandTemp0; advances wScriptStep
; (E-0347)
; why: step 20 of BreedChildScene (when wScriptStep = 20); BreedChildScene: implements script
; command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by
; ... (E-0352)
BreedChildScene_RunFieldCommandTemp0AndStep::
    ld a, $0e
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of BreedChildSprite: sets wObject5 to $80; advances wScriptStep (E-0347)
; why: step 4 of BreedChildSprite (when wScriptStep = 4); BreedChildSprite: implements script
; command type 8C (SCRIPT_BREED_CHILD_SPRITE): a key-world/field talk event (group $16, dispatched
; by ... (E-0352)
BreedChildSprite_SetObject5::
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of BreedChildSprite: sets hSpriteWindowClipMode to 0; sets hFieldDrawFlags; copies the byte
; at wChildRecord to wObject1 + OBJ_SPRITE_ID; copies the byte at wChildRecord to hTemp0; copies the
; byte at wChildRecord to hTemp1; sets hTemp2 to 0; sets hTemp3 to 6; copies L to hTemp4; copies H
; to hTemp5; calls DecompressGraphicsTemp0ToTemp4; sets hTemp0 to $0d; calls RunFieldCommandTemp0;
; then 4 more steps (see the code) (E-0347)
; why: step 1 of BreedChildSprite (when wScriptStep = 1); BreedChildSprite: implements script
; command type 8C (SCRIPT_BREED_CHILD_SPRITE): a key-world/field talk event (group $16, dispatched
; by ... (E-0352)
BreedChildSprite_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc::
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

; implements script command type 8B (SCRIPT_BREED_FADE): a key-world/field talk event (group $15,
; dispatched by BreedMenu_TalkEvent15: a palette fade); named from its trigger and calls (E-0038)
BreedFade::
    ld a, [wScriptStep]
    jumptable
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2
    dw BreedFade_StartPaletteFade
    dw BreedFade_WaitFadeState

; step 24 of BreedFade: returns unless wFadeState is 0; sets wTalkEventIndex to 1; sets
; wTalkEventGroup to $6a; copies wScriptReturnBank to wScriptStartRequest; copies wScriptReturnLo to
; wScriptPointerLo; copies wScriptReturnHi to wScriptPointerHi; sets wScriptCommandType to $ed; sets
; wScriptInDataBank to 1 (E-0347)
; why: step 24 of BreedFade (when wScriptStep = 24); BreedFade: implements script command type 8B
; (SCRIPT_BREED_FADE): a key-world/field talk event (group $15, dispatched by BreedMenu_TalkEvent15:
; a ... (E-0352)
BreedFade_WaitFadeState::
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

; step 23 of BreedFade: sets hMapId to $0d; sets hMapScreenX to 1; sets hMapScreenY to 0; sets
; wWarpDestX to $40; sets wWarpDestY to $40; sets hFieldDrawFlags to 0; sets wFieldTransitionKind to
; 0; calls StartPaletteFade; sets wSavedPositionValid to 1; advances wScriptStep (E-0347)
; why: step 23 of BreedFade (when wScriptStep = 23); BreedFade: implements script command type 8B
; (SCRIPT_BREED_FADE): a key-world/field talk event (group $15, dispatched by BreedMenu_TalkEvent15:
; a ... (E-0352)
BreedFade_StartPaletteFade::
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

; step 18 of LinkMessageEvent: sets wObject5 to 0; advances wScriptStep (E-0347)
; why: step 18 of LinkMessageEvent (when wScriptStep = 18); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_SetObject5::
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 15 of LinkMessageEvent: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; advances
; wScriptStep (E-0347)
; why: step 15 of LinkMessageEvent (when wScriptStep = 15); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 14 of LinkMessageEvent: calls StartMessageA; advances wScriptStep (E-0347)
; why: step 14 of LinkMessageEvent (when wScriptStep = 14); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_ToStartMessageAAndStep::
    ld a, $0e
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of LinkMessageEvent: sets wFieldInitFlag to $8d; continues in
; NpcBreedWarp_ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 13 of LinkMessageEvent (when wScriptStep = 13); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc::
    ld a, $8d
    ld [wFieldInitFlag], a
    jp NpcBreedWarp_ScriptStartFadeAndAdvanceStep

; step 10 of LinkMessageEvent: calls SetBit2AtHL_B12; may return early; sets wObject1 + OBJ_STATE to
; 1; sets wObject2 + OBJ_STATE to 3; advances wScriptStep (E-0347)
; why: step 10 of LinkMessageEvent (when wScriptStep = 10); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_SetBit2AtHL_B12::
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

; step 7 of LinkMessageEvent: sets wObject2 + OBJ_STATE to 1; increments wScriptParam0; may return
; early; increments wObject2 + OBJ_X; returns unless wObject2 + OBJ_X is $58; sets wObject2 +
; OBJ_STATE to 0; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 7 of LinkMessageEvent (when wScriptStep = 7); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_WriteObject2AndScriptParam0::
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

; step 5 of LinkMessageEvent: calls StepScriptParam0Counter_Bank12; may return early; sets wObject2
; + OBJ_Y to $40; advances wScriptStep (E-0347)
; why: step 5 of LinkMessageEvent (when wScriptStep = 5); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep::
    ld b, $3c
    call StepScriptParam0Counter_Bank12
    ret nc
    ld a, $40
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of LinkMessageEvent: sets wObject1 + OBJ_STATE to 3; increments wScriptParam0; may return
; early; decrements wObject1 + OBJ_X; returns unless wObject1 + OBJ_X is $48; sets wObject1 +
; OBJ_STATE to 0; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 4 of LinkMessageEvent (when wScriptStep = 4); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_WriteObject1AndScriptParam0::
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

; step 3 of LinkMessageEvent: calls StepScriptParam0Counter_Bank12; may return early; advances
; wScriptStep (E-0347)
; why: step 3 of LinkMessageEvent (when wScriptStep = 3); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_StepScriptParam0Counter_Bank12_AdvanceScriptStep_2::
    ld b, $1e
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of LinkMessageEvent: calls StepScriptParam0Counter_Bank12; may return early; sets wObject1
; + OBJ_Y to $40; advances wScriptStep (E-0347)
; why: step 2 of LinkMessageEvent (when wScriptStep = 2); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_StepScriptParam0Counter_Bank12::
    ld b, $3c
    call StepScriptParam0Counter_Bank12
    ret nc
    ld a, $40
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of LinkMessageEvent: may return early; calls ClearBit2AtHL_Bank12; advances wScriptStep
; (E-0347)
; why: step 1 of LinkMessageEvent (when wScriptStep = 1); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_ClearBit2AtHL_Bank12::
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

; step 0 of LinkMessageEvent: sets hSpriteWindowClipMode to 0; sets hFieldDrawFlags; copies the byte
; at wRecordBufA to wObject1 + OBJ_SPRITE_ID; copies the byte at wRecordBufA to hTemp0; copies the
; byte at wRecordBufA to hTemp1; sets hTemp2 to 0; sets hTemp3 to 6; copies L to hTemp4; copies H to
; hTemp5; calls DecompressGraphicsTemp0ToTemp4; copies the byte at wRecordBufB to wObject2 +
; OBJ_SPRITE_ID; copies the byte at wRecordBufB to hTemp0; then 9 more steps (see the code) (E-0347)
; why: step 0 of LinkMessageEvent (when wScriptStep = 0); LinkMessageEvent: implements script
; command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from
; the link screens ... (E-0352)
LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc::
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

; step 0 of NpcBreedWarp: sets hMapId to $14; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $e0; sets wWarpDestY to 0; sets wFieldTransitionKind to 0; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 0 of NpcBreedWarp (when wScriptStep = 0); NpcBreedWarp: implements script command type
; 8F (SCRIPT_NPC_BREED_WARP): a key-world/field talk event (group $20, dispatched by ... (E-0352)
NpcBreedWarp_ScriptStartFadeAndAdvanceStep::
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

; copies wSpriteSlots + $7, the player position and facing, wFollowerRecords and wFollowerRecords +
; $1-wFollowerRecords + $C fields into wSavedPlayerState-wSavedPlayerState + $C, then advances
; wScriptStep (E-0121)
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

; implements script command type 94 (SCRIPT_FOLLOWERS_STEP_14): a key-world/field talk event (group
; $14: steps the followers, toggling object flag bit 1, with a sound); named from its trigger and
; calls (E-0038)
FollowersStep14::
    ld a, [wScriptStep]
    jumptable
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_SetScriptStartRequest

; implements script command type 93 (SCRIPT_WARP_WITH_FOLLOWERS): a key-world/field talk event
; (group $13: sets an object flag, fades, then sets the warp destination, wFollowerRecords and the
; field transition); named from its trigger and calls (E-0038)
WarpWithFollowers::
    ld a, [wScriptStep]
    jumptable
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw WarpWithFollowers_ScriptStartFadeAndAdvanceStep
    dw WarpWithFollowers_SetBit1AtHL_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_SetScriptStartRequest

; step 3 of WarpWithFollowers: calls SetBit1AtHL_Bank12; sets wFollowerRecords to 0; branches on
; hPlayerY; increments hPlayerY; returns unless hPlayerY is $50; advances wScriptStep; also changes
; HL and A by register arithmetic (E-0347)
; why: step 3 of WarpWithFollowers (when wScriptStep = 3); WarpWithFollowers: implements script
; command type 93 (SCRIPT_WARP_WITH_FOLLOWERS): a key-world/field talk event (group $13: sets an
; object flag, fades, then ... (E-0352)
WarpWithFollowers_SetBit1AtHL_Bank12::
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

; step 2 of WarpWithFollowers: sets hMapId to 1; sets hMapScreenX to 1; sets hMapScreenY to 0;
; copies hPlayerX to wWarpDestX; sets wWarpDestY to $f0; sets wFieldTransitionKind to 0; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 2 of WarpWithFollowers (when wScriptStep = 2); WarpWithFollowers: implements script
; command type 93 (SCRIPT_WARP_WITH_FOLLOWERS): a key-world/field talk event (group $13: sets an
; object flag, fades, then ... (E-0352)
WarpWithFollowers_ScriptStartFadeAndAdvanceStep::
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

; implements script command type 92 (SCRIPT_PLAYER_AND_FOLLOWERS_STEP): a key-world/field talk event
; (group $12: moves the player (UpdatePlayerMovement) and the followers); named from its trigger and
; calls (E-0038)
PlayerAndFollowersStep::
    ld a, [wScriptStep]
    jumptable
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw PlayerAndFollowersStep_UpdatePlayerMovement
    dw PlayerAndFollowersStep_UpdatePlayerMovement_RunFieldActionRequestActionIfBit7
    dw PlayerAndFollowersStep_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_SetScriptStartRequest

; step 4 of PlayerAndFollowersStep: calls UpdateFollowersOnStep_Bank12; increments hPlayerY; calls
; UpdateFollowersOnStep_Bank12; increments hPlayerY; returns unless hPlayerY is $20; advances
; wScriptStep (E-0347)
; why: step 4 of PlayerAndFollowersStep (when wScriptStep = 4); PlayerAndFollowersStep: implements
; script command type 92 (SCRIPT_PLAYER_AND_FOLLOWERS_STEP): a key-world/field talk event (group
; $12: moves the player ... (E-0352)
PlayerAndFollowersStep_UpdateFollowersOnStep_Bank12::
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

; implements script command type 91 (SCRIPT_FOLLOWERS_STEP_11): a key-world/field talk event (group
; $11: steps the followers (UpdateFollowersOnStep_Bank12)); named from its trigger and calls
; (E-0038)
FollowersStep11::
    ld a, [wScriptStep]
    jumptable
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep11_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_SetScriptStartRequest

; step 1 of FollowersStep11: calls UpdateFollowersOnStep_Bank12; increments hPlayerY; calls
; UpdateFollowersOnStep_Bank12; increments hPlayerY; returns unless hPlayerY is $60; advances
; wScriptStep (E-0347)
; why: step 1 of FollowersStep11 (when wScriptStep = 1); FollowersStep11: implements script command
; type 91 (SCRIPT_FOLLOWERS_STEP_11): a key-world/field talk event (group $11: steps the followers
; ... (E-0352)
FollowersStep11_UpdateFollowersOnStep_Bank12::
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

; implements script command type 90 (SCRIPT_FOLLOWERS_STEP_10): a key-world/field talk event (group
; $10: steps the followers (UpdateFollowersOnStep_Bank12)); named from its trigger and calls
; (E-0038)
FollowersStep10::
    ld a, [wScriptStep]
    jumptable
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw PlayerAndFollowersStep_UpdatePlayerMovement
    dw PlayerAndFollowersStep_UpdatePlayerMovement_RunFieldActionRequestActionIfBit7
    dw FollowersStep10_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_SetScriptStartRequest

; step 2 of FollowersStep14: calls UpdateFollowersOnStep_Bank12; returns unless hPlayerY is c; calls
; ClearBit1AtHL_Bank12; sets wScriptStartRequest to $80; also changes HL, A and C by register
; arithmetic (E-0347)
; why: step 2 of FollowersStep14 (when wScriptStep = 2); FollowersStep14: implements script command
; type 94 (SCRIPT_FOLLOWERS_STEP_14): a key-world/field talk event (group $14: steps the followers,
; toggling object ... (E-0352)
FollowersStep14_UpdateFollowersOnStep_Bank12_SetScriptStartRequest::
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

; step 4 of FollowersStep10: calls UpdateFollowersOnStep_Bank12; increments hPlayerY; calls
; UpdateFollowersOnStep_Bank12; increments hPlayerY; returns unless hPlayerY is $50; advances
; wScriptStep (E-0347)
; why: step 4 of FollowersStep10 (when wScriptStep = 4); FollowersStep10: implements script command
; type 90 (SCRIPT_FOLLOWERS_STEP_10): a key-world/field talk event (group $10: steps the followers
; ... (E-0352)
FollowersStep10_UpdateFollowersOnStep_Bank12::
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

; step 3 of PlayerAndFollowersStep: calls UpdatePlayerMovement; calls
; RunFieldActionRequestActionIfBit7; returns if bit 7 of wFieldActionRequest is set; advances
; wScriptStep (E-0347)
; why: step 3 of PlayerAndFollowersStep (when wScriptStep = 3); PlayerAndFollowersStep: implements
; script command type 92 (SCRIPT_PLAYER_AND_FOLLOWERS_STEP): a key-world/field talk event (group
; $12: moves the player ... (E-0352)
PlayerAndFollowersStep_UpdatePlayerMovement_RunFieldActionRequestActionIfBit7::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of PlayerAndFollowersStep: sets wFieldActionRequest to $80; sets wScreenScrollDir to 8;
; increments hMapScreenY; sets hPlayerStateFlags; copies L to hPlayerStepDYLo; copies H to
; hPlayerStepDYHi; calls UpdatePlayerMovement; calls RunFieldActionRequestActionIfBit7; advances
; wScriptStep (E-0347)
; why: step 2 of PlayerAndFollowersStep (when wScriptStep = 2); PlayerAndFollowersStep: implements
; script command type 92 (SCRIPT_PLAYER_AND_FOLLOWERS_STEP): a key-world/field talk event (group
; $12: moves the player ... (E-0352)
PlayerAndFollowersStep_UpdatePlayerMovement::
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

; step 1 of FollowersStep14: calls UpdateFollowersOnStep_Bank12; increments hPlayerY; calls
; UpdateFollowersOnStep_Bank12; increments hPlayerY; returns unless hPlayerY is $80; advances
; wScriptStep (E-0347)
; why: step 1 of FollowersStep14 (when wScriptStep = 1); FollowersStep14: implements script command
; type 94 (SCRIPT_FOLLOWERS_STEP_14): a key-world/field talk event (group $14: steps the followers,
; toggling object ... (E-0352)
FollowersStep14_UpdateFollowersOnStep_Bank12::
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

; step 0 of FollowersStep14: sets hPlayerFacing to 0; calls SetBit1AtHL_Bank12; plays sound $65;
; advances wScriptStep (E-0347)
; why: step 0 of FollowersStep14 (when wScriptStep = 0); FollowersStep14: implements script command
; type 94 (SCRIPT_FOLLOWERS_STEP_14): a key-world/field talk event (group $14: steps the followers,
; toggling object ... (E-0352)
FollowersStep14_SetBit1AtHL_Bank12AndStep::
    xor a
    ldh [hPlayerFacing], a
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank12
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event
; (group $09, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: reloads the player sprite graphics
; with a negative screen flash); named from its trigger and calls (E-0038)
PlayerSpriteFlash::
    ld a, [wScriptStep]
    jumptable
    dw PlayerSpriteFlash_QueueSoundEffect
    dw PlayerSpriteFlash_ToScriptStepFlashScreenNegative
    dw PlayerSpriteFlash_NextRandomSeed
    dw PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    dw PlayerSpriteFlash_LoadPlayerSpriteGraphics
    dw PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    dw PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    dw PlayerSpriteFlash_WriteSpriteWindowClipModeAndScriptStartRequest

; step 7 of PlayerSpriteFlash: sets hSpriteWindowClipMode to 0; sets wScriptStartRequest to $80
; (E-0347)
; why: step 7 of PlayerSpriteFlash (when wScriptStep = 7); PlayerSpriteFlash: implements script
; command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched
; by ... (E-0352)
PlayerSpriteFlash_WriteSpriteWindowClipModeAndScriptStartRequest::
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 4 of PlayerSpriteFlash: may continue in PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing;
; sets hPlayerSpriteOverride; calls LoadPlayerSpriteGraphics; sets wOBJPaletteUploadRequest to $7f
; (E-0347)
; why: step 4 of PlayerSpriteFlash (when wScriptStep = 4); PlayerSpriteFlash: implements script
; command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched
; by ... (E-0352)
PlayerSpriteFlash_LoadPlayerSpriteGraphics::
    ld a, [wScriptParam0]
    or a
    jr nz, PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    ldh a, [hPlayerSpriteOverride]
    or $80
    ldh [hPlayerSpriteOverride], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

; step 3 of PlayerSpriteFlash: increments wScriptParam0; returns unless wScriptParam0 is $03; copies
; hPlayerFacing & $03 to hPlayerFacing; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 3 of PlayerSpriteFlash (when wScriptStep = 3); PlayerSpriteFlash: implements script
; command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched
; by ... (E-0352)
PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing::
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

; step 2 of PlayerSpriteFlash: sets hPlayerFacing to 0; calls NextRandomSeed; branches on
; wKeyRandomHi & $07; branches on the byte at wSpriteSlots + $b; copies the byte at wSpriteSlots +
; $b to hPlayerSpriteOverride; copies the byte at wSpriteSlots + $b to hPlayerSpriteStreamLo; copies
; the byte at wSpriteSlots + $b to hPlayerSpriteStreamHi; branches on hPlayerSpriteOverride;
; branches on hPlayerSpriteStreamLo; branches on hPlayerSpriteStreamHi; sets hPlayerSpriteTimerLo to
; $64; sets hPlayerSpriteTimerHi to 0; then 3 more steps (see the code) (E-0347)
; why: step 2 of PlayerSpriteFlash (when wScriptStep = 2); PlayerSpriteFlash: implements script
; command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched
; by ... (E-0352)
PlayerSpriteFlash_NextRandomSeed::
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
    ldh [hPlayerSpriteStreamLo], a
    ld a, [hl]
    ldh [hPlayerSpriteStreamHi], a
    ldh a, [hPlayerSpriteOverride]
    cp $01
    jr nz, .set_player_sprite_timer_lo_to_64
    ldh a, [hPlayerSpriteStreamLo]
    cp $5e
    jr nz, .set_player_sprite_timer_lo_to_64
    ldh a, [hPlayerSpriteStreamHi]
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

; step 1 of PlayerSpriteFlash: calls ScriptStepFlashScreenNegative (E-0347)
; why: step 1 of PlayerSpriteFlash (when wScriptStep = 1); PlayerSpriteFlash: implements script
; command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched
; by ... (E-0352)
PlayerSpriteFlash_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

; step 0 of PlayerSpriteFlash: plays sound $7a; branches on wIsCGB; calls CopyBytes; advances
; wScriptStep (E-0347)
; why: step 0 of PlayerSpriteFlash (when wScriptStep = 0); PlayerSpriteFlash: implements script
; command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched
; by ... (E-0352)
PlayerSpriteFlash_QueueSoundEffect::
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

; implements script command type A1 (SCRIPT_PLAYER_SPRITE_MESSAGE): a key-world/field talk event
; (group $0A, dispatched by UpdatePlayerMovement: reloads the player sprite graphics and shows a
; message); named from its trigger and calls (E-0038)
PlayerSpriteMessage::
    ld a, [wScriptStep]
    jumptable
    dw PlayerSpriteMessage_ToStartMessageAAndStep
    dw PlayerSpriteMessage_RunMessageBoxCarryWhenIdle_Bank12
    dw PlayerSpriteMessage_LoadPlayerSpriteGraphics

; step 2 of PlayerSpriteMessage: sets hPlayerSpriteOverride to 0; calls LoadPlayerSpriteGraphics;
; sets wOBJPaletteUploadRequest to $7f; sets wScriptStartRequest to $80 (E-0347)
; why: step 2 of PlayerSpriteMessage (when wScriptStep = 2); PlayerSpriteMessage: implements script
; command type A1 (SCRIPT_PLAYER_SPRITE_MESSAGE): a key-world/field talk event (group $0A,
; dispatched by ... (E-0352)
PlayerSpriteMessage_LoadPlayerSpriteGraphics::
    xor a
    ldh [hPlayerSpriteOverride], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 1 of PlayerSpriteMessage: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; advances
; wScriptStep (E-0347)
; why: step 1 of PlayerSpriteMessage (when wScriptStep = 1); PlayerSpriteMessage: implements script
; command type A1 (SCRIPT_PLAYER_SPRITE_MESSAGE): a key-world/field talk event (group $0A,
; dispatched by ... (E-0352)
PlayerSpriteMessage_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of PlayerSpriteMessage: calls StartMessageA; advances wScriptStep (E-0347)
; why: step 0 of PlayerSpriteMessage (when wScriptStep = 0); PlayerSpriteMessage: implements script
; command type A1 (SCRIPT_PLAYER_SPRITE_MESSAGE): a key-world/field talk event (group $0A,
; dispatched by ... (E-0352)
PlayerSpriteMessage_ToStartMessageAAndStep::
    ld a, $12
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8E (SCRIPT_MAP_LINK_WARP): a key-world/field talk event (group $08,
; dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: a timed palette fade, then the warp
; destination from the map link records (E-0238) or wKeyWorldGoal); named from its trigger and calls
MapLinkWarp::
    ld a, [wScriptStep]
    jumptable
    dw MapLinkWarp_WritePlayerYAndPlayerFacingEtc
    dw MapLinkWarp_WriteScriptStartRequestAndMapIdEtc

; step 1 of MapLinkWarp: sets wScriptStartRequest to $80; may continue in
; MapExitWarpTable_CheckKeyWorldActive; branches on the byte at MapExitWarpTable; sets hMapId;
; branches on wKeyWorldActive; branches on wKeyWorldKey; calls
; MapLinkWarp_WriteWarpDestXAndWarpDestYEtc; also changes HL, DE, BC and A by register arithmetic
; (E-0347)
; why: step 1 of MapLinkWarp (when wScriptStep = 1); MapLinkWarp: implements script command type 8E
; (SCRIPT_MAP_LINK_WARP): a key-world/field talk event (group $08, dispatched by ... (E-0352,
; E-0238)
MapLinkWarp_WriteScriptStartRequestAndMapIdEtc::
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wMapType]
    bit 7, a
    jp nz, MapExitWarpTable_CheckKeyWorldActive
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
    jr z, .call_map_link_warp_write_warp_dest_x_and_warp
    ld a, [wKeyWorldKey]
    dec a
    cp b
    jr nz, .call_map_link_warp_write_warp_dest_x_and_warp
    ld de, wKeyWorldGoal

.call_map_link_warp_write_warp_dest_x_and_warp:
    call MapLinkWarp_WriteWarpDestXAndWarpDestYEtc
    ret

; the code at MapLinkWarp_WriteScriptStartRequestAndMapIdEtc walks 5-byte records up to $FF for the
; one whose byte 0 is hMapId, stores byte 1 to hMapId and passes DE = bytes 3-4 to
; MapLinkWarp_WriteWarpDestXAndWarpDestYEtc (high nibble to wWarpDestX, low nibble * 16 to
; wWarpDestY, then the screen), or DE = wKeyWorldGoal when a key world is active and wKeyWorldKey -
; 1 equals byte 2; 16 records and $FF (E-0238, C1)
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

; Branches on wKeyWorldActive; branches on wKeyWorldKey; branches on wKeyWorldSlot; calls
; MapLinkWarp_WriteWarpDestXAndWarpDestYEtc; copies wKeyWorldGoalPos to wWarpDestX; copies
; wKeyWorldGoalPos2 to wWarpDestY; calls MapLinkWarp_StartPaletteFade; also changes DE, A and C by
; register arithmetic (E-0347)
; why: part of MapExitWarpTable; MapExitWarpTable: E-0238, or DE = wKeyWorldGoal when a key world is
; active and wKeyWorldKey - 1 equals byte 2 (E-0352, E-0238)
MapExitWarpTable_CheckKeyWorldActive::
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
    call MapLinkWarp_WriteWarpDestXAndWarpDestYEtc
    ret

.read_key_world_goal_pos:
    ld a, [wKeyWorldGoalPos]
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoalPos2]
    ld [wWarpDestY], a
    ld de, wKeyWorldGoalScreen
    call MapLinkWarp_StartPaletteFade
    ret

; called from MapLinkWarp_WriteScriptStartRequestAndMapIdEtc: sets wWarpDestX; sets wWarpDestY
; (E-0347)
; why: a helper of MapLinkWarp_WriteScriptStartRequestAndMapIdEtc, in step 1 of MapLinkWarp (when
; wScriptStep = 1); MapLinkWarp: implements script command type 8E (SCRIPT_MAP_LINK_WARP): a
; key-world/field talk event (group $08, dispatched by ... (E-0352, E-0238)
MapLinkWarp_WriteWarpDestXAndWarpDestYEtc::
    ld a, [de]
    and $f0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and $f0
    ld [wWarpDestY], a
    inc de

; called from MapLinkWarp_WriteScriptStartRequestAndMapIdEtc: sets hMapScreenX; sets hMapScreenY;
; sets wFieldTransitionStep to $80; sets wFieldTransitionKind to 1; calls StartPaletteFade;
; increments wFieldInitStage; sets wModeState to 4; copies hPlayerStateFlags & $f7 to
; hPlayerStateFlags; sets hPlayerStateFlags (E-0347)
; why: a helper of MapLinkWarp_WriteScriptStartRequestAndMapIdEtc, in step 1 of MapLinkWarp (when
; wScriptStep = 1); MapLinkWarp: implements script command type 8E (SCRIPT_MAP_LINK_WARP): a
; key-world/field talk event (group $08, dispatched by ... (E-0352, E-0238)
MapLinkWarp_StartPaletteFade::
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

; implements script command type 8A (SCRIPT_MAP_EXIT_WARP): a key-world/field talk event (group $07,
; dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: fades, then sets the warp destination from the
; map exit records (E-0182), wMapType, the map size and the field transition); named from its
; trigger and calls
MapExitWarp::
    ld a, [wScriptStep]
    jumptable
    dw MapLinkWarp_WritePlayerYAndPlayerFacingEtc
    dw MapExitWarp_ScriptStartFadeAndAdvanceStep

; step 1 of MapExitWarp: sets wScriptStartRequest to $80; sets hPlayerStateFlags; sets
; wFieldTransitionKind to 1; calls ScriptStartFadeAndAdvanceStep; sets wFieldTransitionStep to $80;
; branches on wMapType; copies the byte at wKeyWorldFloorInfo & $0f to hMapScreenX; sets
; hMapScreenY; sets wWarpDestX to $40; sets wWarpDestY to $40; sets wWarpDestFacing to 0; copies
; wKeyWorldWidth to wMapWidthScreens; then 12 more steps (see the code) (E-0347)
; why: step 1 of MapExitWarp (when wScriptStep = 1); MapExitWarp: implements script command type 8A
; (SCRIPT_MAP_EXIT_WARP): a key-world/field talk event (group $07, dispatched by ... (E-0352,
; E-0182)
MapExitWarp_ScriptStartFadeAndAdvanceStep::
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

; MapExitWarp_ScriptStartFadeAndAdvanceStep, for maps without bit 7 of wMapType, scans 7-byte
; records from $52AD for the one whose first byte equals hMapId (there is no terminator and no
; bounds check), skips three more bytes when wLastWarpIndex = 2, then loads hMapId, hMapScreenX/Y
; from the nibbles of the next byte and wWarpDestX/Y from the nibbles of the byte after (each nibble
; x16), clearing wWarpDestFacing; 87 records end at the routine at $550E, and every map id is unique
; (E-0182, C1)
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

; implements script command type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A,
; dispatched by RunMenuStateMenuState: heals the party (FullyHealParty) after a flag-chosen
; message); named from its trigger and calls (E-0038)
HealPartyEvent::
    ld a, [wScriptStep]
    jumptable
    dw HealPartyEvent_TestFlagBit_AdvanceScriptStep
    dw HealPartyEvent_TestFlagBit
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_FullyHealParty
    dw HealPartyEvent_MoveIncapacitatedPartyMembersBack
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_SetScriptStartRequest

; step 0 of HealPartyEvent: advances wScriptStep; sets hPlayerFacing to 3; checks
; EVENT_THANKS_FOR_COMING_BY_025; may return early; sets hPlayerFacing to 2 (E-0347)
; why: step 0 of HealPartyEvent (when wScriptStep = 0); HealPartyEvent: implements script command
; type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by
; RunMenuStateMenuState: heals ... (E-0352)
HealPartyEvent_TestFlagBit_AdvanceScriptStep::
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

; implements script command type 89 (SCRIPT_RETURN_WARP): a key-world/field talk event (group $06,
; dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: StartReturnWarpByFlag25); named from its
; trigger and calls (E-0038)
ReturnWarp::
    ld a, [wScriptStep]
    jumptable
    dw MapLinkWarp_WritePlayerYAndPlayerFacingEtc
    dw ReturnWarp_StartReturnWarpByFlag25
    dw HealPartyEvent_TestFlagBit
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_FullyHealParty
    dw HealPartyEvent_MoveIncapacitatedPartyMembersBack
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_SetScriptStartRequest

; step 1 of HealPartyEvent: advances wScriptStep; checks EVENT_SCENE_LIMBO_MONSTER2; calls
; StartMessageA; checks EVENT_THANKS_FOR_COMING_BY_025; sets wObject1 + OBJ_STATE to 0 (E-0347)
; why: step 1 of HealPartyEvent (when wScriptStep = 1); HealPartyEvent: implements script command
; type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by
; RunMenuStateMenuState: heals ... (E-0352)
HealPartyEvent_TestFlagBit::
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

; step 1 of ReturnWarp: calls StartReturnWarpByFlag25; sets wFieldTransitionStep to $80 (E-0347)
; why: step 1 of ReturnWarp (when wScriptStep = 1); ReturnWarp: implements script command type 89
; (SCRIPT_RETURN_WARP): a key-world/field talk event (group $06, dispatched by ... (E-0352)
ReturnWarp_StartReturnWarpByFlag25::
    call StartReturnWarpByFlag25
    ld a, $80
    ld [wFieldTransitionStep], a
    ret

; step 0 of MapLinkWarp: branches on hPlayerY; sets hPlayerY; copies wScriptParam0 & $03 to
; hPlayerFacing; branches on wScriptParam0; copies hPlayerFacing to wFollowerRecords; branches on
; wScriptParam0; calls StepScriptParam0Counter_Bank12; may return early; copies hPlayerStateFlags &
; $b7 to hPlayerStateFlags; advances wScriptStep; also changes HL, A and B by register arithmetic
; (E-0347)
; why: step 0 of MapLinkWarp (when wScriptStep = 0); MapLinkWarp: implements script command type 8E
; (SCRIPT_MAP_LINK_WARP): a key-world/field talk event (group $08, dispatched by ... (E-0352,
; E-0238)
MapLinkWarp_WritePlayerYAndPlayerFacingEtc::
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

; implements script command type 88 (SCRIPT_RETURN_MESSAGE): a key-world/field talk event (group
; $05, dispatched by RunFieldReturnPhase_ResetLeadRecordFields55And5B and PartyDefeatedReturn: a
; message chosen by a story flag); named from its trigger and calls (E-0038)
ReturnMessage::
    ld a, [wScriptStep]
    jumptable
    dw ReturnMessage_TestFlagBit
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_FullyHealParty
    dw HealPartyEvent_MoveIncapacitatedPartyMembersBack
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_SetScriptStartRequest

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

; step 0 of ReturnMessage: advances wScriptStep; calls ReturnMessage_WriteGoldHiAndGoldMidEtc;
; checks EVENT_THANKS_FOR_COMING_BY_025; calls StartMessageA; sets wObject1 + OBJ_STATE to 0; checks
; EVENT_SCENE_LIMBO_MONSTER2; calls StartMessageA (E-0347)
; why: step 0 of ReturnMessage (when wScriptStep = 0); ReturnMessage: implements script command type
; 88 (SCRIPT_RETURN_MESSAGE): a key-world/field talk event (group $05, dispatched by ... (E-0352)
ReturnMessage_TestFlagBit::
    ld hl, wScriptStep
    inc [hl]
    farcall ReturnMessage_WriteGoldHiAndGoldMidEtc
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

; step 2 of HealPartyEvent: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; branches on
; wIsCGB; calls CopyBytes; advances wScriptStep; plays sound $7a (E-0347)
; why: step 2 of HealPartyEvent (when wScriptStep = 2); HealPartyEvent: implements script command
; type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by
; RunMenuStateMenuState: heals ... (E-0352)
HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12::
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

; step 4 of HealPartyEvent: sets rRAMG to $0a; calls LoadSRAMRecordByte; sets wScriptParam0 to 0;
; sets wScriptParam0 to 1; sets rRAMG to 0; calls FullyHealParty; branches on wScriptParam0; checks
; EVENT_SCENE_LIMBO_MONSTER2; calls StartMessageA; sets wScriptParam0 to 0; increments wScriptStep;
; sets hFieldDrawFlags to $0e; then 2 more steps (see the code) (E-0347)
; why: step 4 of HealPartyEvent (when wScriptStep = 4); HealPartyEvent: implements script command
; type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by
; RunMenuStateMenuState: heals ... (E-0352)
HealPartyEvent_FullyHealParty::
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

; step 5 of HealPartyEvent: calls MoveIncapacitatedPartyMembersBack; calls LoadRecordListNameTiles;
; calls LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest to $7f; sets
; hFieldDrawFlags to 0; advances wScriptStep; checks EVENT_SCENE_LIMBO_MONSTER2; calls StartMessageA
; (E-0347)
; why: step 5 of HealPartyEvent (when wScriptStep = 5); HealPartyEvent: implements script command
; type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by
; RunMenuStateMenuState: heals ... (E-0352)
HealPartyEvent_MoveIncapacitatedPartyMembersBack::
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

; step 6 of HealPartyEvent: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 6 of HealPartyEvent (when wScriptStep = 6); HealPartyEvent: implements script command
; type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by
; RunMenuStateMenuState: heals ... (E-0352)
HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_SetScriptStartRequest::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event
; (group $04, dispatched from FieldState_StepChecks: moves incapacitated members back
; (MoveIncapacitatedPartyMembersBack) and starts the return warp (StartReturnWarpByFlag25)); named
; from its trigger and calls (E-0038)
PartyDefeatedReturn::
    ld a, [wScriptStep]
    jumptable
    dw PartyDefeatedReturn_WriteScriptParam0AndScriptParam1
    dw PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc
    dw PartyDefeatedReturn_RunMessageBoxCarryWhenIdle_Bank12
    dw PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_BackScriptStep
    dw PartyDefeatedReturn_WriteScriptParam0AndFieldDrawFlagsEtc
    dw PartyDefeatedReturn_QueueMusic
    dw PartyDefeatedReturn_StepScriptParam0Counter_Bank12
    dw PartyDefeatedReturn_StartReturnWarpByFlag25
    dw PartyDefeatedReturn_DispatchTalkEvent

; step 8 of PartyDefeatedReturn: sets wTalkEventGroup to 5; sets wTalkEventIndex to 0; calls
; DispatchTalkEvent (E-0347)
; why: step 8 of PartyDefeatedReturn (when wScriptStep = 8); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_DispatchTalkEvent::
    ld a, $05
    ld [wTalkEventGroup], a
    xor a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; step 7 of PartyDefeatedReturn: calls StartReturnWarpByFlag25; sets wFieldReturnPhase to 0; sets
; wFieldTransitionStep to $80 (E-0347)
; why: step 7 of PartyDefeatedReturn (when wScriptStep = 7); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_StartReturnWarpByFlag25::
    call StartReturnWarpByFlag25
    xor a
    ld [wFieldReturnPhase], a
    ld a, $80
    ld [wFieldTransitionStep], a
    ret

; step 6 of PartyDefeatedReturn: calls StepScriptParam0Counter_Bank12; may return early; advances
; wScriptStep (E-0347)
; why: step 6 of PartyDefeatedReturn (when wScriptStep = 6); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_StepScriptParam0Counter_Bank12::
    ld b, $b4
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of PartyDefeatedReturn: sets rRAMG to $0a; calls LoadSRAMRecordByte; sets rRAMG to 0; plays
; music $42; advances wScriptStep; sets rRAMG to 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 5 of PartyDefeatedReturn (when wScriptStep = 5); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_QueueMusic::
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

; step 3 of PartyDefeatedReturn: decrements wScriptStep; decrements wScriptParam0; may continue in
; PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex; continues in
; PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex (E-0347)
; why: step 3 of PartyDefeatedReturn (when wScriptStep = 3); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_BackScriptStep::
    ld hl, wScriptStep
    dec [hl]
    ld de, wShadowOAM + $b
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a
    jr nz, PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex
    ld de, vTiles0 + $b
    jr PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex

; step 2 of PartyDefeatedReturn: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; branches
; on wScriptParam0; sets wScriptParam0 to 0; sets wScriptStep to 4; advances wScriptStep (E-0347)
; why: step 2 of PartyDefeatedReturn (when wScriptStep = 2); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_RunMessageBoxCarryWhenIdle_Bank12::
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

; step 1 of PartyDefeatedReturn: advances wScriptStep; decrements wScriptParam0; may continue in
; PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex (E-0347)
; why: step 1 of PartyDefeatedReturn (when wScriptStep = 1); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc::
    ld hl, wScriptStep
    inc [hl]
    ld de, MSG_KEEP_OPEN | $000a
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a
    jr nz, PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex
    ld de, $000a

; Copies E to wMessageIndex; copies D to wMessageGroup; sets wMessageState to 0; copies
; wScriptParam1 & $fe to wScriptParam1; copies wScriptParam1 & $fc to wScriptParam1; copies
; wScriptParam1 & $f7 to wScriptParam1; sets rRAMG to $0a; calls CopyRecordNameToNameGlyphBuf; sets
; rRAMG to 0; calls CopyBytes (E-0347)
; why: part of PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc, in step 1 of
; PartyDefeatedReturn (when wScriptStep = 1); PartyDefeatedReturn: implements script command type 87
; (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04, dispatched from ...
; (E-0352)
PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex::
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

; step 0 of PartyDefeatedReturn: copies C to wScriptParam0; copies wStatusFieldStep to
; wScriptParam1; advances wScriptStep; also changes HL, BC and A by register arithmetic (E-0347)
; why: step 0 of PartyDefeatedReturn (when wScriptStep = 0); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_WriteScriptParam0AndScriptParam1::
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

; implements script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a
; random message ($00D0 + 0..F), a battle against wKeyWorldEncounter (one or three monsters), then
; after the 'Warubou' message sets wKeyWorldFlags bit 7, marks every floor entry of
; wKeyWorldEncounterTable done and sets bit 6 of the current key entry byte 7; a C1 name from its
; calls and writes (E-0038)
KeyWorldBossBattle::
    ld a, [wScriptStep]
    jumptable
    dw KeyWorldBossBattle_StartMessageHL_B0F_Bank12
    dw KeyWorldBossBattle_RunMessageBoxFar_Bank12
    dw KeyWorldBossBattle_CopyBytes
    dw KeyWorldBossBattle_ToScriptStepFlashScreenNegative
    dw KeyWorldBossBattle_ShowWarubouWaheyNoGood
    dw KeyWorldBossBattle_WriteScriptParam0
    dw KeyWorldBossBattle_WriteSpriteSlotCountAndScriptParam0
    dw KeyWorldBossBattle_WriteKeyWorldFlagsAndScriptStartRequest

; step 7 of KeyWorldBossBattle: sets wKeyWorldFlags; sets wKeyWorldEncounterTable + $3 to 1; sets
; wScriptStartRequest to $80; also changes HL, A and B by register arithmetic (E-0347)
; why: step 7 of KeyWorldBossBattle (when wScriptStep = 7); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_WriteKeyWorldFlagsAndScriptStartRequest::
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

; step 6 of KeyWorldBossBattle: branches on wScriptParam0; sets wSpriteSlotCount to 1; sets
; wSpriteSlotCount to 0; increments wScriptParam0; returns unless wScriptParam0 is $78; sets
; wScriptParam0 to 0; advances wScriptStep; also changes HL and A by register arithmetic (E-0347)
; why: step 6 of KeyWorldBossBattle (when wScriptStep = 6); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_WriteSpriteSlotCountAndScriptParam0::
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

; step 5 of KeyWorldBossBattle: calls KeyWorldBossBattle_ReadMessageState_2; may return early; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 5 of KeyWorldBossBattle (when wScriptStep = 5); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_WriteScriptParam0::
    xor a
    call KeyWorldBossBattle_ReadMessageState_2
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of KeyWorldBossBattle: advances wScriptStep; shows 'Warubou: Wa-hey! No good, no good!'
; (E-0347)
; why: step 4 of KeyWorldBossBattle (when wScriptStep = 4); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_ShowWarubouWaheyNoGood::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0129 ; 'Warubou: Wa-hey! No good, no good!'
    call StartMessageHL_B0F_Bank12
    ret

; step 3 of KeyWorldBossBattle: calls ScriptStepFlashScreenNegative (E-0347)
; why: step 3 of KeyWorldBossBattle (when wScriptStep = 3); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

; step 2 of KeyWorldBossBattle: branches on wIsCGB; calls CopyBytes; advances wScriptStep (E-0347)
; why: step 2 of KeyWorldBossBattle (when wScriptStep = 2); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_CopyBytes::
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

; step 1 of KeyWorldBossBattle: calls RunMessageBoxFar_Bank12; may return early; advances
; wScriptStep; sets wBattleIntroKind to 3; copies L to wEncounterMonsters; sets wWildLevel; sets
; wEncounterKind to 0; copies L to wEncounterMonsters; sets wWildLevel; sets wWildBand; sets
; wEncounterClass; sets wEncounterKind to 2; then 3 more steps (see the code) (E-0347)
; why: step 1 of KeyWorldBossBattle (when wScriptStep = 1); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_RunMessageBoxFar_Bank12::
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

; step 0 of KeyWorldBossBattle: calls NextRandomSeed; calls StartMessageHL_B0F_Bank12; advances
; wScriptStep (E-0347)
; why: step 0 of KeyWorldBossBattle (when wScriptStep = 0); KeyWorldBossBattle: implements script
; command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0
; + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_StartMessageHL_B0F_Bank12::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    ld hl, $00d0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a
; random message ($00E0 + 0..F), a battle against the wKeyWorldEncounterTable entry of
; wKeyWorldFloor, then after the 'Warubou' message marks that floor entry done (byte 3 = 1); a C1
; name from its calls and writes (E-0038)
KeyWorldFloorBattle::
    ld a, [wScriptStep]
    jumptable
    dw KeyWorldFloorBattle_StartMessageHL_B0F_Bank12
    dw KeyWorldFloorBattle_RunMessageBoxFar_Bank12
    dw KeyWorldFloorBattle_ShowWarubouWaheyThatWas
    dw KeyWorldBossBattle_WriteScriptParam0
    dw KeyWorldBossBattle_WriteSpriteSlotCountAndScriptParam0
    dw KeyWorldFloorBattle_WriteScriptStartRequest

; step 5 of KeyWorldFloorBattle: sets wKeyWorldEncounterTable + $3 to 1; sets wScriptStartRequest to
; $80 (E-0347)
; why: step 5 of KeyWorldFloorBattle (when wScriptStep = 5); KeyWorldFloorBattle: implements script
; command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a random message ($00E0
; + 0..F), a battle ... (E-0352)
KeyWorldFloorBattle_WriteScriptStartRequest::
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

; step 2 of KeyWorldFloorBattle: advances wScriptStep; shows 'Warubou: Wa-hey… That was no good.'
; (E-0347)
; why: step 2 of KeyWorldFloorBattle (when wScriptStep = 2); KeyWorldFloorBattle: implements script
; command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a random message ($00E0
; + 0..F), a battle ... (E-0352)
KeyWorldFloorBattle_ShowWarubouWaheyThatWas::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $012a ; 'Warubou: Wa-hey… That was no good.'
    call StartMessageHL_B0F_Bank12
    ret

; step 1 of KeyWorldFloorBattle: calls RunMessageBoxFar_Bank12; may return early; advances
; wScriptStep; sets wBattleIntroKind to 3; copies the byte at wKeyWorldEncounterTable to
; wEncounterMonsters; copies the byte at wKeyWorldEncounterTable to wWildLevel; sets wEncounterKind
; to 0; sets wBattleTransitionSubStep to 1; calls SetModeState3AndSaveScreen (E-0347)
; why: step 1 of KeyWorldFloorBattle (when wScriptStep = 1); KeyWorldFloorBattle: implements script
; command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a random message ($00E0
; + 0..F), a battle ... (E-0352)
KeyWorldFloorBattle_RunMessageBoxFar_Bank12::
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

; step 0 of KeyWorldFloorBattle: calls NextRandomSeed; calls StartMessageHL_B0F_Bank12; advances
; wScriptStep (E-0347)
; why: step 0 of KeyWorldFloorBattle (when wScriptStep = 0); KeyWorldFloorBattle: implements script
; command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a random message ($00E0
; + 0..F), a battle ... (E-0352)
KeyWorldFloorBattle_StartMessageHL_B0F_Bank12::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    ld hl, $00e0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event
; (group $02, dispatched from FieldModeStateDispatch: random gold (AddGoldCapped) or item
; (AppendItemStepPtrLoToInventory)); named from its trigger and calls (E-0038)
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
    dw SetupScriptSpriteFromMapSpriteKind
    dw PlaySound83AndAdvanceScriptStep
    dw ScriptStepAnimateSpriteBySteps
    dw RandomGoldOrItem_WriteSVBKAndFieldDrawFlags
    dw RandomGoldOrItem_ToRandomGoldOrItem_NextRandomSeed
    dw RandomGoldOrItem_AddStepDeltaToPointedByte
    dw RandomGoldOrItem_Number24ToPackedBCD
    dw RandomGoldOrItem_RunMessageBoxCarryWhenIdle_Bank12
    dw RandomGoldOrItem_AddGoldCapped

; step 8 of RandomGoldOrItem: copies wTriggerMarkerFlags & $7f to hTemp0; sets hTemp1 to 0; calls
; AddGoldCapped; copies wScriptParam1 to wStepPtrLo; calls AppendItemStepPtrLoToInventory; sets
; wTriggerMarkerFlags to 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 8 of RandomGoldOrItem (when wScriptStep = 8); RandomGoldOrItem: implements script
; command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched
; from ... (E-0352)
RandomGoldOrItem_AddGoldCapped::
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

; step 7 of RandomGoldOrItem: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; sets
; wTriggerKind to $ff; advances wScriptStep (E-0347)
; why: step 7 of RandomGoldOrItem (when wScriptStep = 7); RandomGoldOrItem: implements script
; command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched
; from ... (E-0352)
RandomGoldOrItem_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $ff
    ld [wTriggerKind], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 6 of RandomGoldOrItem: advances wScriptStep; copies wTriggerMarkerFlags & $7f to wDigits;
; calls Number24ToPackedBCD; calls WritePackedBCDNoLeadingZeros; calls StartMessageA; sets
; wMessageGroup to 0; calls CopyItemNameToDE; calls StartMessageA; sets wMessageGroup to 0 (E-0347)
; why: step 6 of RandomGoldOrItem (when wScriptStep = 6); RandomGoldOrItem: implements script
; command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched
; from ... (E-0352)
RandomGoldOrItem_Number24ToPackedBCD::
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

; step 5 of RandomGoldOrItem: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; returns unless wScriptParam0 is $20; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 5 of RandomGoldOrItem (when wScriptStep = 5); RandomGoldOrItem: implements script
; command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched
; from ... (E-0352)
RandomGoldOrItem_AddStepDeltaToPointedByte::
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

; step 4 of RandomGoldOrItem: calls RandomGoldOrItem_NextRandomSeed (E-0347)
; why: step 4 of RandomGoldOrItem (when wScriptStep = 4); RandomGoldOrItem: implements script
; command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched
; from ... (E-0352)
RandomGoldOrItem_ToRandomGoldOrItem_NextRandomSeed::
    farcall RandomGoldOrItem_NextRandomSeed
    ret

; step 3 of RandomGoldOrItem: branches on wIsCGB; branches on wMapType; branches on hMapId; sets
; rSVBK to 2; sets rSVBK to 0; calls DrawFullScreenBufferAtScroll; sets hFieldDrawFlags to 0;
; advances wScriptStep; also changes HL, DE, A and C by register arithmetic (E-0347)
; why: step 3 of RandomGoldOrItem (when wScriptStep = 3); RandomGoldOrItem: implements script
; command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched
; from ... (E-0352)
RandomGoldOrItem_WriteSVBKAndFieldDrawFlags::
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

; QueueSoundEffect $83, then wScriptStep += 1 (E-0114)
PlaySound83AndAdvanceScriptStep::
    ld a, $83
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; A = wMapSpriteKind >> 4, DE = KeyWorldBossBattle_StartMessageHL_B0F_Bank12, B = $7E, then
; continues at SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM (E-0126)
SetupScriptSpriteFromMapSpriteKind::
    ld a, [wMapSpriteKind]
    swap a
    and $0f
    ld de, KeyWorldBossBattle_StartMessageHL_B0F_Bank12
    ld b, $7e
    jr SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM

; decompresses sprite graphics from bank $7E to vTiles0 + $700 (with a CGB palette), places it 16
; pixels in front of the player and advances wScriptStep (E-0129)
SpawnScriptSpriteInFrontOfPlayer::
    dec a
    jr nz, .skip
    ld de, SpawnScriptSpriteInFrontOfPlayer_Data
    ld b, $7e
    jr SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM

.skip:
    ld de, Tiles0Plus700Gfx_4
    ld b, $7e

; Calls DecompressToVRAM; branches on wIsCGB; calls CopyFromBank; sets wOBJPaletteUploadRequest to
; $7f; branches on hPlayerFacing; sets wMessageIndex; copies E to wMessageGroup; copies D to
; wMessageIndex; sets wMessageGroup; sets wMessageIndex; copies E to wMessageGroup; copies D to
; wMessageIndex; then 5 more steps (see the code) (E-0347)
; why: part of SpawnScriptSpriteInFrontOfPlayer; SpawnScriptSpriteInFrontOfPlayer: decompresses
; sprite graphics from bank $7E to vTiles0 + $700 (with a CGB palette), places it 16 pixels in front
; of the player and advances ... (E-0352, E-0129)
SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM::
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

; implements script command type 83 (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group
; $01, dispatched from FieldModeStateDispatch: draws script meta-sprite 21, moves objects, changes
; the music); named from its trigger and calls (E-0038)
FieldScene01::
    ld a, [wScriptParam1]
    dec a
    jr nz, .skip
    call FieldScene01_WriteJoypadHeldAndJoypadPressed
    ret

.skip:
    dec a
    jr nz, .call_field_scene01_write_joypad_held_and
    call FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2
    ret

.call_field_scene01_write_joypad_held_and:
    call FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld
    ret

; called from FieldScene01: sets wJoypadHeld to 0; sets wJoypadPressed to 0; dispatches on
; wScriptStep (E-0347)
; why: a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    jumptable
    dw FieldScene01_WritePlayerStateFlagsAndFieldDrawFlagsEtc
    dw FieldScene01_AddStepDeltaToPointedByte

; step 0 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld: copies hPlayerStateFlags &
; $f7 to hPlayerStateFlags; sets hFieldDrawFlags to $0e; sets hPlayerSpriteMode to 0; sets hPlayerY;
; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 0 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld (when wScriptStep = 0),
; in a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_WritePlayerStateFlagsAndFieldDrawFlagsEtc::
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

; step 1 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld: copies E to wStepPtrLo;
; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments hPlayerY; increments
; wScriptParam0; branches on wScriptParam0; copies hPlayerFacing to wFollowerRecords; sets
; hFieldDrawFlags to 0; sets wScriptStartRequest to $80; sets hPlayerStateFlags; copies L to
; hPlayerStepDXLo; copies H to hPlayerStepDXHi; then 9 more steps (see the code) (E-0347)
; why: step 1 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld (when wScriptStep = 1),
; in a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_AddStepDeltaToPointedByte::
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

; called from FieldScene01: sets wJoypadHeld to 0; sets wJoypadPressed to 0; dispatches on
; wScriptStep; also changes A by register arithmetic (E-0347)
; why: a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_WriteJoypadHeldAndJoypadPressed::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    jumptable
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw FieldScene01_DecompressToVRAM
    dw FieldScene01_StepScriptParam0Counter_Bank12
    dw FieldScene01_AddStepDeltaToPointedByte_2
    dw FieldScene01_DrawScriptMetaSprite21AtScrollOffset
    dw FieldScene01_AdvanceScriptStep
    dw FieldScene01_SetStepPtrLo

; step 8 of FieldScene01_WriteJoypadHeldAndJoypadPressed: copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; decrements hPlayerY; increments wScriptParam0;
; branches on wScriptParam0; sets hPlayerY; sets hPlayerStateFlags; sets hPlayerSpriteMode to 2;
; sets wScriptStartRequest to $80; calls DrawScriptMetaSprite21AtScrollOffset; may return early;
; then 5 more steps (see the code) (E-0347)
; why: step 8 of FieldScene01_WriteJoypadHeldAndJoypadPressed (when wScriptStep = 8), in a helper of
; FieldScene01; FieldScene01: implements script command type 83 (SCRIPT_FIELD_SCENE_01): a
; key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: ... (E-0352)
FieldScene01_SetStepPtrLo::
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

; step 7 of FieldScene01_WriteJoypadHeldAndJoypadPressed: calls
; DrawScriptMetaSprite21AtScrollOffset; advances wScriptStep; branches on wMapType; returns if the
; byte at FieldScene01_DrawScriptMetaSprite21AtScrollOffset_Data is $ff; branches on the byte at
; FieldScene01_DrawScriptMetaSprite21AtScrollOffset_Data; plays music $2b; also changes HL, A and C
; by register arithmetic (E-0347)
; why: step 7 of FieldScene01_WriteJoypadHeldAndJoypadPressed (when wScriptStep = 7), in a helper of
; FieldScene01; FieldScene01: implements script command type 83 (SCRIPT_FIELD_SCENE_01): a
; key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: ... (E-0352)
FieldScene01_AdvanceScriptStep::
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
    ld hl, FieldScene01_DrawScriptMetaSprite21AtScrollOffset_Data

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
FieldScene01_DrawScriptMetaSprite21AtScrollOffset_Data::
    db $30, $ff

; step 3 of FieldScene01_WriteJoypadHeldAndJoypadPressed: calls DecompressToVRAM; calls
; CopyFromBank; sets wOBJPaletteUploadRequest to $7f; branches on hPlayerFacing; sets wMessageIndex;
; copies E to wMessageGroup; copies D to wMessageIndex; sets wMessageGroup; sets wMessageIndex;
; copies E to wMessageGroup; copies D to wMessageIndex; sets wMessageGroup; then 5 more steps (see
; the code) (E-0347)
; why: step 3 of FieldScene01_WriteJoypadHeldAndJoypadPressed (when wScriptStep = 3), in a helper of
; FieldScene01; FieldScene01: implements script command type 83 (SCRIPT_FIELD_SCENE_01): a
; key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: ... (E-0352)
FieldScene01_DecompressToVRAM::
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

; called from FieldScene01: sets wJoypadHeld to 0; sets wJoypadPressed to 0; dispatches on
; wScriptStep; also changes A by register arithmetic (E-0347)
; why: a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    jumptable
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw FieldScene01_DecompressToVRAM_2
    dw FieldScene01_StepScriptParam0Counter_Bank12
    dw FieldScene01_AddStepDeltaToPointedByte_2
    dw FieldScene01_DrawScriptMetaSprite21AtScrollOffset
    dw FieldScene01_AddStepDeltaToPointedByte_3
    dw FieldScene01_WaitFieldActionRequest
    dw FieldScene01_SetTriggerEnable

; step 4 of FieldScene01_WriteJoypadHeldAndJoypadPressed: calls StepScriptParam0Counter_Bank12; may
; return early; advances wScriptStep (E-0347)
; why: step 4 of FieldScene01_WriteJoypadHeldAndJoypadPressed (when wScriptStep = 4), in a helper of
; FieldScene01; FieldScene01: implements script command type 83 (SCRIPT_FIELD_SCENE_01): a
; key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: ... (E-0352)
FieldScene01_StepScriptParam0Counter_Bank12::
    ld b, $1e
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of FieldScene01_WriteJoypadHeldAndJoypadPressed: copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; copies hPlayerFacing & $03 to hPlayerFacing;
; increments wScriptParam0; returns unless wScriptParam0 is $20; copies wFollowerRecords to
; hPlayerFacing; plays sound $7a; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 5 of FieldScene01_WriteJoypadHeldAndJoypadPressed (when wScriptStep = 5), in a helper of
; FieldScene01; FieldScene01: implements script command type 83 (SCRIPT_FIELD_SCENE_01): a
; key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: ... (E-0352)
FieldScene01_AddStepDeltaToPointedByte_2::
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

; step 9 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2: sets wTriggerEnable to 1;
; sets hPlayerStateFlags; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments hPlayerY; increments wScriptParam0; branches on
; wScriptParam0; copies hPlayerStateFlags & $5f to hPlayerStateFlags; copies hPlayerFacing to
; wFollowerRecords; sets hFieldDrawFlags to 0; sets wScriptStartRequest to $80; then 6 more steps
; (see the code) (E-0347)
; why: step 9 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2 (when wScriptStep =
; 9), in a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_SetTriggerEnable::
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

; step 8 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2: returns if bit 7 of
; wFieldActionRequest is set; returns if bit 0 of hPlayerStateFlags is set; branches on
; hPlayerFacing; sets wJoypadHeld; returns if B is 0; sets wJoypadHeld; returns if C is $80; sets
; wJoypadHeld; returns if B is $90; sets wJoypadHeld; returns if C is 0; branches on
; wSpriteSlotCount; then 10 more steps (see the code) (E-0347)
; why: step 8 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2 (when wScriptStep =
; 8), in a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_WaitFieldActionRequest::
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

; step 7 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2: copies E to wStepPtrLo;
; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; decrements hPlayerY; increments
; wScriptParam0; branches on wScriptParam0; sets hPlayerY; sets hPlayerSpriteMode to 2; sets
; wScriptParam0 to 0; advances wScriptStep; calls DrawScriptMetaSprite21AtScrollOffset; may return
; early; then 5 more steps (see the code) (E-0347)
; why: step 7 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2 (when wScriptStep =
; 7), in a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_AddStepDeltaToPointedByte_3::
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

; step 6 of FieldScene01_WriteJoypadHeldAndJoypadPressed: branches on wScriptParam0; calls
; DrawScriptMetaSprite21AtScrollOffset; increments wScriptParam0; returns unless wScriptParam0 is
; $78; sets wScriptParam0 to 0; advances wScriptStep; sets hFieldDrawFlags to $0e; also changes HL
; and A by register arithmetic (E-0347)
; why: step 6 of FieldScene01_WriteJoypadHeldAndJoypadPressed (when wScriptStep = 6), in a helper of
; FieldScene01; FieldScene01: implements script command type 83 (SCRIPT_FIELD_SCENE_01): a
; key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: ... (E-0352)
FieldScene01_DrawScriptMetaSprite21AtScrollOffset::
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

; step 3 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2: calls DecompressToVRAM;
; calls CopyFromBank; sets wOBJPaletteUploadRequest to $7f; branches on hPlayerFacing; sets
; wMessageIndex; copies E to wMessageGroup; copies D to wMessageIndex; sets wMessageGroup; sets
; wMessageIndex; copies E to wMessageGroup; copies D to wMessageIndex; sets wMessageGroup; then 5
; more steps (see the code) (E-0347)
; why: step 3 of FieldScene01_WriteJoypadHeldAndJoypadPressed_SetJoypadHeld_2 (when wScriptStep =
; 3), in a helper of FieldScene01; FieldScene01: implements script command type 83
; (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from
; FieldModeStateDispatch: ... (E-0352)
FieldScene01_DecompressToVRAM_2::
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

; implements script command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event
; (group $0B: random item or key entry (GenerateNewKeyEntry) and door tiles for the key-world floor
; (DrawDoorTilesForKeyWorldFloor)); named from its trigger and calls (E-0038)
KeyWorldDoorItem::
    ld a, [wScriptStep]
    jumptable
    dw KeyWorldDoorItem_StartMessageA
    dw KeyWorldDoorItem_RunMessageBoxCarryWhenIdle_Bank12
    dw KeyWorldDoorItem_WriteScriptStartRequestAndStepPtrLo
    dw KeyWorldDoorItem_RunMessageBoxCarryWhenIdle_Bank12
    dw KeyWorldDoorItem_DrawDoorTilesForKeyWorldFloor

; step 4 of KeyWorldDoorItem: calls KeyWorldDoorItem_RandomModulo29_BankF0; calls
; DrawDoorTilesForKeyWorldFloor; calls DrawFullScreenBufferAtScroll; sets wScriptStartRequest to $80
; (E-0347)
; why: step 4 of KeyWorldDoorItem (when wScriptStep = 4); KeyWorldDoorItem: implements script
; command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event (group $0B: random item
; or key entry ... (E-0352)
KeyWorldDoorItem_DrawDoorTilesForKeyWorldFloor::
    farcall KeyWorldDoorItem_RandomModulo29_BankF0
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

; step 2 of KeyWorldDoorItem: sets wScriptStartRequest to $80; branches on L; copies L to
; wStepPtrLo; calls AppendItemStepPtrLoToInventory; calls DrawDoorTilesForKeyWorldFloor; calls
; DrawFullScreenBufferAtScroll; sets wScriptStartRequest to $80; also changes HL and A by register
; arithmetic (E-0347)
; why: step 2 of KeyWorldDoorItem (when wScriptStep = 2); KeyWorldDoorItem: implements script
; command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event (group $0B: random item
; or key entry ... (E-0352)
KeyWorldDoorItem_WriteScriptStartRequestAndStepPtrLo::
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

; step 1 of KeyWorldDoorItem: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; advances
; wScriptStep (E-0347)
; why: step 1 of KeyWorldDoorItem (when wScriptStep = 1); KeyWorldDoorItem: implements script
; command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event (group $0B: random item
; or key entry ... (E-0352)
KeyWorldDoorItem_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of KeyWorldDoorItem: advances wScriptStep; calls StartMessageA; branches on L; calls
; CopyItemNameToDE; calls StartMessageA; copies L to wScriptParam0; copies H to wScriptParam1; calls
; GenerateNewKeyEntry; branches on hTemp0; calls StartMessageA; copies L to wScriptParam0; copies H
; to wScriptParam1; then 4 more steps (see the code) (E-0347)
; why: step 0 of KeyWorldDoorItem (when wScriptStep = 0); KeyWorldDoorItem: implements script
; command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event (group $0B: random item
; or key entry ... (E-0352)
KeyWorldDoorItem_StartMessageA::
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

; implements script command type 81 (SCRIPT_AREA_ITEM): a key-world/field talk event (group $0E,
; dispatched from FieldModeStateDispatch: gives an item (AppendItemStepPtrLoToInventory) after
; CheckTwoKeyWorldFloorState4EntriesForKeyWorldArea, redrawing the screen); named from its trigger
; and calls (E-0038)
AreaItemEvent::
    ld a, [wScriptStep]
    jumptable
    dw AreaItemEvent_StartMessageA
    dw AreaItemEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw AreaItemEvent_WriteScriptStartRequestAndStepPtrLo

; step 2 of AreaItemEvent: sets wScriptStartRequest to $80; sets wStepPtrLo; calls
; AppendItemStepPtrLoToInventory; calls CheckTwoKeyWorldFloorState4EntriesForKeyWorldArea; calls
; DrawFullScreenBufferAtScroll; sets wScriptStartRequest to $80 (E-0347)
; why: step 2 of AreaItemEvent (when wScriptStep = 2); AreaItemEvent: implements script command type
; 81 (SCRIPT_AREA_ITEM): a key-world/field talk event (group $0E, dispatched from
; FieldModeStateDispatch: ... (E-0352)
AreaItemEvent_WriteScriptStartRequestAndStepPtrLo::
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

; step 1 of AreaItemEvent: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; advances
; wScriptStep (E-0347)
; why: step 1 of AreaItemEvent (when wScriptStep = 1); AreaItemEvent: implements script command type
; 81 (SCRIPT_AREA_ITEM): a key-world/field talk event (group $0E, dispatched from
; FieldModeStateDispatch: ... (E-0352)
AreaItemEvent_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of AreaItemEvent: advances wScriptStep; branches on the byte at wScriptStep; calls
; StartMessageA; calls CopyItemNameToDE; calls StartMessageA; copies L to wScriptParam0; copies H to
; wScriptParam1; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 0 of AreaItemEvent (when wScriptStep = 0); AreaItemEvent: implements script command type
; 81 (SCRIPT_AREA_ITEM): a key-world/field talk event (group $0E, dispatched from
; FieldModeStateDispatch: ... (E-0352)
AreaItemEvent_StartMessageA::
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

; implements script command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event
; (group $0F, dispatched by CheckStepTriggerAndDispatchTalk: gives gold (a byte * 10,
; AddGoldCapped), an item (AppendItemStepPtrLoToInventory) or starts a battle with intro 5); named
; from its trigger and calls (E-0038)
StepTriggerReward::
    ld a, [wScriptStep]
    jumptable
    dw StepTriggerReward_CopyItemNameToDE
    dw StepTriggerReward_RunMessageBoxCarryWhenIdle_Bank12
    dw StepTriggerReward_AddGoldCapped
    dw StepTriggerReward_AppendItemStepPtrLoToInventory
    dw StepTriggerReward_SetModeState3AndSaveScreen
    dw StepTriggerReward_SetScriptStartRequestTo80

; step 5 of StepTriggerReward: sets wScriptStartRequest to $80 (E-0347)
; why: step 5 of StepTriggerReward (when wScriptStep = 5); StepTriggerReward: implements script
; command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched
; by ... (E-0352)
StepTriggerReward_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 4 of StepTriggerReward: sets wBattleIntroKind to 5; sets wBattleTransitionSubStep to 1; calls
; SetModeState3AndSaveScreen; calls StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 4 of StepTriggerReward (when wScriptStep = 4); StepTriggerReward: implements script
; command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched
; by ... (E-0352)
StepTriggerReward_SetModeState3AndSaveScreen::
    ld a, $05
    ld [wBattleIntroKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
    ld a, [hl]
    or $80
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 3 of StepTriggerReward: calls StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex; sets
; wStepPtrLo; sets wTriggerKind to $ff; calls AppendItemStepPtrLoToInventory; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 3 of StepTriggerReward (when wScriptStep = 3); StepTriggerReward: implements script
; command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched
; by ... (E-0352)
StepTriggerReward_AppendItemStepPtrLoToInventory::
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
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

; step 2 of StepTriggerReward: calls StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex; copies
; L to hTemp0; copies H to hTemp1; calls AddGoldCapped; sets wTriggerKind to $ff; sets
; wScriptStartRequest to $80; also changes HL, DE and A by register arithmetic (E-0347)
; why: step 2 of StepTriggerReward (when wScriptStep = 2); StepTriggerReward: implements script
; command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched
; by ... (E-0352)
StepTriggerReward_AddGoldCapped::
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
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

; step 1 of StepTriggerReward: calls RunMessageBoxCarryWhenIdle_Bank12; may return early; copies
; wScriptParam0 to wScriptStep (E-0347)
; why: step 1 of StepTriggerReward (when wScriptStep = 1); StepTriggerReward: implements script
; command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched
; by ... (E-0352)
StepTriggerReward_RunMessageBoxCarryWhenIdle_Bank12::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    ld [wScriptStep], a
    ret

; step 0 of StepTriggerReward: advances wScriptStep; calls
; StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex; branches on the byte at wScriptStep;
; calls CopyItemNameToDE; calls StartMessageA; sets wScriptParam0 to 3; calls CopyItemNameToDE;
; calls StartMessageA; sets wScriptParam0 to 5; copies L to wDigits; calls Number24ToPackedBCD;
; calls WritePackedBCDNoLeadingZeros; then 11 more steps (see the code) (E-0347)
; why: step 0 of StepTriggerReward (when wScriptStep = 0); StepTriggerReward: implements script
; command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched
; by ... (E-0352)
StepTriggerReward_CopyItemNameToDE::
    ld hl, wScriptStep
    inc [hl]
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
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

; Changes HL and A; branches on wScreenTriggerCount (E-0347)
; why: part of StepTriggerReward; StepTriggerReward: implements script command type 80
; (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched by ... (E-0352)
StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex::
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

; with SRAM enabled sets every party record's HP to max HP, MP to max MP and field $55 to 0 (E-0125)
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

; for 30 frames alternates every 4 frames between the normal palettes and their inverse (DMG
; palettes $D2/$E2 and $2D/$1D), then advances wScriptStep (E-0127)
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

; wScriptParam0 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear;
; returns A = 0 either way (the same 18 bytes appear in 3 banks) (E-0353)
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

; step 4 of PartyDefeatedReturn: branches on wScriptParam0; increments wScriptParam0; sets
; hFieldDrawFlags to $0e; calls MoveIncapacitatedPartyMembersBack; calls LoadRecordListNameTiles;
; calls LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest to $7f; sets
; hFieldDrawFlags to 0; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 4 of PartyDefeatedReturn (when wScriptStep = 4); PartyDefeatedReturn: implements script
; command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04,
; dispatched from ... (E-0352)
PartyDefeatedReturn_WriteScriptParam0AndFieldDrawFlagsEtc::
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

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks) (E-0353)
SetBit1AtHL_Bank12::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks) (E-0353)
ClearBit1AtHL_Bank12::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered (E-0353)
SetBit2AtHL_B12::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks) (E-0353)
ClearBit2AtHL_Bank12::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

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
    dw RunMessageBox_Bank12_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBox_Bank12_BeginStringDisplay_Bank09
    dw RunMessageBox_Bank12_WriteMessageStateAndTextWindowStateEtc
    dw RunMessageBox_Bank12_WriteMessageState

; step 0 of RunMessageBox_Bank12: calls SetBit1OfPlayerAndObjectFlags; branches on wMessageGroup;
; calls FillTilesRequest; calls FillTilesFromRequest; plays sound $69; sets wTextWindowState to 1;
; sets wTextWindowStep to 0; branches on hMapId; sets hSpriteWindowClipMode to 2; branches on
; hPlayerY; sets wTextWindowState to $81; sets hSpriteWindowClipMode to 1; then 1 more step (see the
; code) (E-0347)
; why: step 0 of RunMessageBox_Bank12; RunMessageBox_Bank12: the bank-$12 message runner: the same
; four states as RunMessageBox, with A on the stack as the freeze flag instead of wStepPtrLo (state
; 0 ... (E-0352, E-0079)
RunMessageBox_Bank12_SetBit1OfPlayerAndObjectFlags::
    pop af
    or a
    jr nz, .check_message_group
    farcall SetBit1OfPlayerAndObjectFlags

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

; step 1 of RunMessageBox_Bank12: may return early; copies wMessageIndex to wStringIndex; sets
; wStringCategory to 1; calls BeginStringDisplay_Bank09; advances wMessageState (E-0347)
; why: step 1 of RunMessageBox_Bank12; RunMessageBox_Bank12: the bank-$12 message runner: the same
; four states as RunMessageBox, with A on the stack as the freeze flag instead of wStepPtrLo (state
; 0 ... (E-0352, E-0079)
RunMessageBox_Bank12_BeginStringDisplay_Bank09::
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

; step 2 of RunMessageBox_Bank12: returns if bit 0 of wTextFlags is set; branches on wMessageGroup;
; sets wMessageState to $ff; plays sound $69; sets wTextWindowState to 2; sets wTextWindowStep to 0;
; sets hSpriteWindowClipMode to 0; branches on hPlayerY; sets wTextWindowState to $82; advances
; wMessageState (E-0347)
; why: step 2 of RunMessageBox_Bank12; RunMessageBox_Bank12: the bank-$12 message runner: the same
; four states as RunMessageBox, with A on the stack as the freeze flag instead of wStepPtrLo (state
; 0 ... (E-0352, E-0079)
RunMessageBox_Bank12_WriteMessageStateAndTextWindowStateEtc::
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

; step 3 of RunMessageBox_Bank12: calls ClearBit1OfPlayerAndObjectFlags; sets wMessageState to $ff;
; also changes A by register arithmetic (E-0347)
; why: step 3 of RunMessageBox_Bank12; RunMessageBox_Bank12: the bank-$12 message runner: the same
; four states as RunMessageBox, with A on the stack as the freeze flag instead of wStepPtrLo (state
; 0 ... (E-0352, E-0079)
RunMessageBox_Bank12_WriteMessageState::
    ld a, [wTextWindowState]
    and $03
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    or a
    jr nz, .set_message_state_to_FF
    farcall ClearBit1OfPlayerAndObjectFlags

.set_message_state_to_FF:
    ld a, $ff
    ld [wMessageState], a
    ret

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
    dw RunMessageBoxStateIfActive_Bank12_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBoxStateIfActive_Bank12_BeginStringDisplay_Bank09
    dw RunMessageBoxStateIfActive_Bank12_WriteMessageStateAndTextWindowStateEtc
    dw RunMessageBox_Bank12_WriteMessageState

; step 0 of RunMessageBoxStateIfActive_Bank12: calls SetBit1OfPlayerAndObjectFlags; branches on
; wMessageIndex; calls FillTilesRequest; calls FillTilesFromRequest; plays sound $69; sets
; wTextWindowState to 1; sets wTextWindowStep to 0; sets hSpriteWindowClipMode to 2; branches on
; hPlayerY; sets wTextWindowState to $81; sets hSpriteWindowClipMode to 1; advances wMessageState
; (E-0347)
; why: step 0 of RunMessageBoxStateIfActive_Bank12; RunMessageBoxStateIfActive_Bank12: unless
; wMessageState is $FF (idle), runs the message box step for wMessageState (jump table) (E-0352,
; E-0122)
RunMessageBoxStateIfActive_Bank12_SetBit1OfPlayerAndObjectFlags::
    pop af
    or a
    jr nz, .check_message_index
    farcall SetBit1OfPlayerAndObjectFlags

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

; step 1 of RunMessageBoxStateIfActive_Bank12: may return early; copies wMessageIndex & $3f to
; wStringIndex; sets wStringCategory to 9; calls BeginStringDisplay_Bank09; advances wMessageState
; (E-0347)
; why: step 1 of RunMessageBoxStateIfActive_Bank12; RunMessageBoxStateIfActive_Bank12: unless
; wMessageState is $FF (idle), runs the message box step for wMessageState (jump table) (E-0352,
; E-0122)
RunMessageBoxStateIfActive_Bank12_BeginStringDisplay_Bank09::
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

; step 2 of RunMessageBoxStateIfActive_Bank12: returns if bit 0 of wTextFlags is set; branches on
; wMessageIndex; sets wMessageState to $ff; plays sound $69; sets wTextWindowState to 2; sets
; wTextWindowStep to 0; sets hSpriteWindowClipMode to 0; branches on hPlayerY; sets wTextWindowState
; to $82; advances wMessageState (E-0347)
; why: step 2 of RunMessageBoxStateIfActive_Bank12; RunMessageBoxStateIfActive_Bank12: unless
; wMessageState is $FF (idle), runs the message box step for wMessageState (jump table) (E-0352,
; E-0122)
RunMessageBoxStateIfActive_Bank12_WriteMessageStateAndTextWindowStateEtc::
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

; Branches on wMessageState; dispatches through the table that follows (E-0347)
; why: part of KeyWorldBossBattle; KeyWorldBossBattle: implements script command type 85
; (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0 + 0..F), a
; battle ... (E-0352)
KeyWorldBossBattle_ReadMessageState::
    push af
    ld a, [wMessageState]
    cp $ff
    jr nz, .skip
    pop af
    ret

.skip:
    jumptable
    dw KeyWorldBossBattle_SetBit1OfPlayerAndObjectFlags
    dw KeyWorldBossBattle_BeginStringDisplay_Bank8A
    dw KeyWorldBossBattle_WriteTextWindowStateAndTextWindowStepEtc
    dw RunMessageBox_Bank12_WriteMessageState

; step 0 of KeyWorldBossBattle_ReadMessageState: calls SetBit1OfPlayerAndObjectFlags; calls
; FillTilesRequest; calls FillTilesFromRequest; sets wTextWindowState to 1; sets wTextWindowStep to
; 0; sets hSpriteWindowClipMode to 2; branches on hPlayerY; sets wTextWindowState to $81; sets
; hSpriteWindowClipMode to 1; advances wMessageState (E-0347)
; why: step 0 of KeyWorldBossBattle_ReadMessageState, in part of KeyWorldBossBattle;
; KeyWorldBossBattle: implements script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk
; category 9, group 0: a random message ($00D0 + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_SetBit1OfPlayerAndObjectFlags::
    pop af
    or a
    jr nz, .call_fill_tiles_request
    farcall SetBit1OfPlayerAndObjectFlags

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

; step 1 of KeyWorldBossBattle_ReadMessageState: may return early; copies wMessageIndex to
; wStringIndex; sets wStringCategory to 0; calls BeginStringDisplay_Bank8A; advances wMessageState
; (E-0347)
; why: step 1 of KeyWorldBossBattle_ReadMessageState, in part of KeyWorldBossBattle;
; KeyWorldBossBattle: implements script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk
; category 9, group 0: a random message ($00D0 + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_BeginStringDisplay_Bank8A::
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

; step 2 of KeyWorldBossBattle_ReadMessageState: returns if bit 0 of wTextFlags is set; sets
; wTextWindowState to 2; sets wTextWindowStep to 0; sets hSpriteWindowClipMode to 0; branches on
; hPlayerY; sets wTextWindowState to $82; advances wMessageState (E-0347)
; why: step 2 of KeyWorldBossBattle_ReadMessageState, in part of KeyWorldBossBattle;
; KeyWorldBossBattle: implements script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk
; category 9, group 0: a random message ($00D0 + 0..F), a battle ... (E-0352)
KeyWorldBossBattle_WriteTextWindowStateAndTextWindowStepEtc::
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

; the same 13 bytes as StartMessageHL_B0F (StartMessageHL_B0F) (E-0353)
StartMessageHL_B0F_Bank12::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; wMessageIndex = A, wMessageState = 0: the next RunMessageBox call opens the window and shows that
; string of the group already in wMessageGroup (E-0063, E-0079)
StartMessageA::
    ld [wMessageIndex], a
    xor a
    ld [wMessageState], a
    ret

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

; RunMessageBox_Bank12 (A = the freeze flag), then carry set when wMessageState = $FF (idle), else A
; = 0 and carry clear (E-0079)
RunMessageBoxCarryWhenIdle_Bank12::
    call RunMessageBox_Bank12

; Changes A; branches on wMessageState (E-0347)
; why: part of RunMessageBoxCarryWhenIdle_Bank12; RunMessageBoxCarryWhenIdle_Bank12:
; RunMessageBox_Bank12 (A = the freeze flag), then carry set when wMessageState = $FF (idle), else A
; = 0 and carry clear (E-0352, E-0079)
RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState::
    ld a, [wMessageState]
    cp $ff
    jr z, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; runs RunMessageBoxStateIfActive_Bank12, then continues at
; RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState (E-0126) (E-0344: the address in its name
; dropped or read as the label there; was RunMessageBoxThenContinue)
RunMessageBoxThenContinue::
    call RunMessageBoxStateIfActive_Bank12
    jr RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState

; called from KeyWorldBossBattle_WriteScriptParam0: calls KeyWorldBossBattle_ReadMessageState;
; continues in RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState (E-0347)
; why: a helper of KeyWorldBossBattle_WriteScriptParam0, in step 5 of KeyWorldBossBattle (when
; wScriptStep = 5); KeyWorldBossBattle: implements script command type 85
; (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0 + 0..F), a
; battle ... (E-0352)
KeyWorldBossBattle_ReadMessageState_2::
    call KeyWorldBossBattle_ReadMessageState
    jr RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState

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

; runs DrawTriggerMarkerSprite and RunDrawTriggerMarkerSprite_WaitFieldActionRequest; shared by the
; field mode states (E-0122) (E-0344: the address in its name dropped or read as the label there;
; was RunDrawTriggerMarkerSprite)
RunDrawTriggerMarkerSprite::
    call DrawTriggerMarkerSprite
    call RunDrawTriggerMarkerSprite_WaitFieldActionRequest
    ret

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
    ld de, LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData_2
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

; the 22 field commands that scenes and map entry run with hTemp0 = command: each places script
; object 5 (wObject5) and decompresses its graphics to VRAM, setting up a scripted figure of a scene
; (E-0354; was: runs the field command for hTemp0 (jump table of 22; called from 49 routines)
; (E-0124))
RunFieldCommandTemp0::
    ldh a, [hTemp0]
    jumptable
    dw RunFieldCommandTemp0_WriteObject5
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_17
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_16
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_15
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_14
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_13
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_12
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_11
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_10
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_9
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_8
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_7
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_6
    dw RunFieldCommandTemp0_WriteObject5_SetObject5_2
    dw RunFieldCommandTemp0_WriteObject5_SetObject5_2
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_5
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_4
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_3
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_2
    dw RunFieldCommandTemp0_WriteObject5_SetObject5
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM
    dw RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM

; step 20 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 to $80; also changes HL and A by register arithmetic
; (E-0347)
; why: step 20 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 19 of RunFieldCommandTemp0: calls
; RunFieldCommandTemp0_DecompressToVRAM_SetOBJPaletteUploadRequest; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 3; sets wObject5 to 0
; (E-0347)
; why: step 19 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_SetObject5::
    call RunFieldCommandTemp0_DecompressToVRAM_SetOBJPaletteUploadRequest
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

; step 18 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 to 0; also
; changes HL and A by register arithmetic (E-0347)
; why: step 18 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_2::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 17 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 to 0; also
; changes HL and A by register arithmetic (E-0347)
; why: step 17 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_3::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 16 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 to 0
; (E-0347)
; why: step 16 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_4::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 15 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $e0; sets wObject5 to 0
; (E-0347)
; why: step 15 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_5::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 13 of RunFieldCommandTemp0: calls
; RunFieldCommandTemp0_DecompressToVRAM_SetOBJPaletteUploadRequest; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 3; sets wObject5 to $80;
; also changes HL and A by register arithmetic (E-0347)
; why: step 13 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_SetObject5_2::
    call RunFieldCommandTemp0_DecompressToVRAM_SetOBJPaletteUploadRequest
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

; step 12 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 to 0; also
; changes HL and A by register arithmetic (E-0347)
; why: step 12 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_6::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 11 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 to 0; also
; changes HL and A by register arithmetic (E-0347)
; why: step 11 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_7::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 10 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $e0; sets wObject5 to 0
; (E-0347)
; why: step 10 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_8::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 9 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $e0; sets wObject5 to $80
; (E-0347)
; why: step 9 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_9::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 8 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $50; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 to 0
; (E-0347)
; why: step 8 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_10::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 7 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $e0; sets wObject5 to $80
; (E-0347)
; why: step 7 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_11::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 6 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $70; sets wObject5 to $80
; (E-0347)
; why: step 6 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_12::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 5 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 0; sets wObject5 to $80
; (E-0347)
; why: step 5 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_13::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 4 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $50; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 to 0
; (E-0347)
; why: step 4 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_14::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 3 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 to 0
; (E-0347)
; why: step 3 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_15::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 2 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $30; sets wObject5 to 0
; (E-0347)
; why: step 2 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_16::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 1 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 to 0
; (E-0347)
; why: step 1 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5_RunFieldCommandTemp0_DecompressToVRAM_17::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; step 0 of RunFieldCommandTemp0: calls RunFieldCommandTemp0_DecompressToVRAM; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to 4; sets wObject5 +
; SCRIPTOBJ_TILE_OFFSET to $60; sets wObject5 + SCRIPTOBJ_TILE_OFFSET to $40; sets wObject5 to $80
; (E-0347)
; why: step 0 of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and
; map entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its
; ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_WriteObject5::
    call RunFieldCommandTemp0_DecompressToVRAM
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

; Calls DecompressToVRAM; branches on wIsCGB; calls CopyFromBank; sets wOBJPaletteUploadRequest to
; $7f; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of RunFieldCommandTemp0; RunFieldCommandTemp0: the 22 field commands that scenes and map
; entry run with hTemp0 = command: each places script object 5 (wObject5) and decompresses its ...
; (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_DecompressToVRAM::
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

; Calls DecompressToVRAM; branches on wIsCGB; calls CopyFromBank; sets wOBJPaletteUploadRequest to
; $7f; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of RunFieldCommandTemp0_DecompressToVRAM, in part of RunFieldCommandTemp0;
; RunFieldCommandTemp0: the 22 field commands that scenes and map entry run with hTemp0 = command:
; each places script object 5 (wObject5) and decompresses its ... (E-0352, E-0354, E-0124)
RunFieldCommandTemp0_DecompressToVRAM_SetOBJPaletteUploadRequest::
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

; called from RunDrawTriggerMarkerSprite: returns if bit 7 of wFieldActionRequest is set; returns
; unless bit 6 of the byte at wObject5 is set; continues in DrawFieldSprites_SetSpriteTileOffset
; (E-0347)
; why: a helper of RunDrawTriggerMarkerSprite; RunDrawTriggerMarkerSprite: runs
; DrawTriggerMarkerSprite and RunDrawTriggerMarkerSprite_WaitFieldActionRequest (E-0352, E-0122,
; E-0344)
RunDrawTriggerMarkerSprite_WaitFieldActionRequest::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld de, wObject5
    ld a, [de]
    bit 6, a
    ret z
    jr DrawFieldSprites_SetSpriteTileOffset

; unless the map is loading or wObject5 bit 7 is clear: reads the sprite entries starting at
; wObject5 (tile offset, set index with bit 7 selecting a sub index, attribute, position bytes),
; sets the hSprite inputs and 16-bit positions from them plus the scroll, and draws each with
; DrawMetaSprite (E-0030)
DrawFieldSprites::
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld de, wObject5
    ld a, [de]
    bit 7, a
    ret z

; Sets hSpriteTileOffset; sets hSpriteSetIndex; calls DrawFieldSprites_WriteSpriteSubIndex; sets
; hSpriteSubIndex to 0; sets hSpriteAttrXor; sets hSpriteOriginX; sets hSpriteOriginXHi; sets
; hSpriteOriginY; sets hSpriteOriginYHi; calls DrawMetaSprite; also changes HL, DE and A by register
; arithmetic (E-0347)
; why: part of DrawFieldSprites; DrawFieldSprites: unless the map is loading or wObject5 bit 7 is
; clear: reads the sprite entries starting at wObject5 (tile offset, set index with bit 7 ...
; (E-0352)
DrawFieldSprites_SetSpriteTileOffset::
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
    call DrawFieldSprites_WriteSpriteSubIndex
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

; called from DrawFieldSprites: increments wObject5 + $6; calls DrawFieldSprites_WriteObject5; sets
; hSpriteSubIndex; calls DrawFieldSprites_WriteObject5; sets hSpriteSubIndex; calls
; DrawFieldSprites_WriteObject5; sets hSpriteSubIndex; calls DrawFieldSprites_WriteObject5; copies
; the byte at DrawFieldSprites_WriteSpriteSubIndex_Data5 to hSpriteSubIndex; branches on the byte at
; DrawFieldSprites_WriteSpriteSubIndex_Data5; calls DrawFieldSprites_WriteObject5; sets
; hSpriteSubIndex; then 4 more steps (see the code) (E-0347)
; why: a helper of DrawFieldSprites; DrawFieldSprites: unless the map is loading or wObject5 bit 7
; is clear: reads the sprite entries starting at wObject5 (tile offset, set index with bit 7 ...
; (E-0352)
DrawFieldSprites_WriteSpriteSubIndex::
    push af
    ld hl, wObject5 + $6
    inc [hl]
    pop af
    and $7f
    cp $13
    jr nz, .cp_1A
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data1
    call DrawFieldSprites_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_1A:
    cp $1a
    jr nz, .cp_17
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data2
    call DrawFieldSprites_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_17:
    cp $17
    jr nz, .cp_1F
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data3
    call DrawFieldSprites_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_1F:
    cp $1f
    jr nz, .cp_1E
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data4
    call DrawFieldSprites_WriteObject5
    ld a, [wObject5 + $7]
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data5
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ret

.cp_1E:
    cp $1e
    jr nz, .cp_18
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data6
    call DrawFieldSprites_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_18:
    cp $18
    jr nz, .cp_20
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data7
    call DrawFieldSprites_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_20:
    cp $20
    jr nz, .return
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data8
    call DrawFieldSprites_WriteObject5_2
    ldh [hSpriteSubIndex], a
    ret

.return:
    ret

; Takes HL; changes HL, A and C (E-0347)
; why: part of DrawFieldSprites; DrawFieldSprites: unless the map is loading or wObject5 bit 7 is
; clear: reads the sprite entries starting at wObject5 (tile offset, set index with bit 7 ...
; (E-0352)
DrawFieldSprites_WriteObject5::
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

; Increments wObject5 + $7; returns unless the byte at wObject5 + $7 is $ff; also changes HL, A and
; C by register arithmetic (E-0347)
; why: part of DrawFieldSprites_WriteObject5, in part of DrawFieldSprites; DrawFieldSprites: unless
; the map is loading or wObject5 bit 7 is clear: reads the sprite entries starting at wObject5 (tile
; offset, set index with bit 7 ... (E-0352)
DrawFieldSprites_WriteObject5_2::
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

; data read by DrawFieldSprites_WriteSpriteSubIndex (5 bytes) (E-0347)
DrawFieldSprites_WriteSpriteSubIndex_Data1::
    db $08, $08, $08, $08, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data2::
    db $08, $08, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data3::
    db $07, $07, $09, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data4::
    db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $36, $0e, $0e, $0e, $40, $ff, $ff, $ff, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data5::
    db $00, $01, $02, $01, $02, $01, $02, $00, $03, $04, $05, $06, $ff, $ff, $ff, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data6::
    db $04, $07, $07, $04, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data7::
    db $20, $20, $ff

DrawFieldSprites_WriteSpriteSubIndex_Data8::
    db $00, $1e, $00, $05, $01, $04, $02, $05, $01, $04, $00, $05, $01, $04, $02, $05
    db $03, $04, $04, $05, $03, $04, $02, $05, $05, $04, $06, $05, $05, $04, $02, $05
    db $01, $04, $00, $05, $ff, $ff

; RunFieldCommandTemp0_DecompressToVRAM and _Shared02 index it with hTemp0 & $7F: the word is
; decompressed from bank $7E to vTiles0 + $400 (DecompressToVRAM); on CGB, byte 2 & $7F selects the
; palette at 7E:$4BBD + 8 * index copied to wOBJPaletteBuffer + $20; byte 3 is returned in A; 22
; records (E-0238, C1)
; record: bank-$7E graphics stream; palette index; returned byte
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
    jr FindTriggerEntryForCurrentScreen_ScreenTriggers_SetTriggerCell

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
    jr FindTriggerEntryForCurrentScreen_ScreenTriggers_SetTriggerCell

; Sets wTriggerCell; returns if the byte at FindTriggerEntryForCurrentScreen_ScreenTriggers_Data is
; 0; copies the byte at FindTriggerEntryForCurrentScreen_ScreenTriggers_Data to wTriggerKind; also
; changes HL and A by register arithmetic (E-0347)
; why: part of FindTriggerEntryForCurrentScreen_ScreenTriggers;
; FindTriggerEntryForCurrentScreen_ScreenTriggers: on maps from $30 (or special map $85) finds the
; wScreenTriggers entry for the current screen and sets wTriggerIndex, wTriggerCell and ... (E-0352,
; E-0128)
FindTriggerEntryForCurrentScreen_ScreenTriggers_SetTriggerCell::
    inc hl
    ld a, [hl]
    ld [wTriggerCell], a
    pop hl
    ld a, [hl]
    and $03
    jr nz, .skip
    inc hl
    ld a, [hl]
    ld hl, FindTriggerEntryForCurrentScreen_ScreenTriggers_Data
    add_a_to_hl
    ld a, [hl]

.skip:
    or a
    ret z
    ld [wTriggerKind], a

; Calls DecompressToVRAM; returns if wIsCGB is 0; branches on wIsCGB; calls CopyFromBank; sets
; wOBJPaletteUploadRequest to $7f; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: part of RandomGoldOrItem; RandomGoldOrItem: implements script command type 84
; (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched from ...
; (E-0352)
RandomGoldOrItem_DecompressToVRAM::
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
    ld de, LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData_2
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
FindTriggerEntryForCurrentScreen_ScreenTriggers_Data::
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0a, $06, $00, $01

; record 0 of the 6-byte records RandomGoldOrItem_DecompressToVRAM reads at $71E8 + 6 * wTriggerKind
; (TriggerSpriteTable holds 1-10); all six bytes are zero (E-0239, C1)
; record: record 0 of the trigger sprite records: all zero
TriggerSpriteRecord0::
    db $00, $00, $00, $00, $00, $00 ; id 0

; RandomGoldOrItem_DecompressToVRAM reads the 6-byte record at $71E8 + 6 * wTriggerKind,
; decompresses the far-pointed stream to vTiles0 + $400 (DecompressToVRAM) and on CGB copies the 8
; bytes at 7E:$4BBD + byte 3 to wOBJPaletteBuffer + $20; records 1-10 here; record 0 is
; TriggerSpriteRecord0 (E-0239, C1)
; record: graphics stream, bank; palette offset; two bytes
TriggerSpriteTable::
    dfar Gfx_FieldCommandSpriteTable_16 ; id 1: compressed sprite graphics
    db $48 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_2 ; id 2: compressed sprite graphics
    db $08 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_2 ; id 3: compressed sprite graphics
    db $08 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_4 ; id 4: compressed sprite graphics
    db $10 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_5 ; id 5: compressed sprite graphics
    db $18 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_6 ; id 6: compressed sprite graphics
    db $20 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_7 ; id 7: compressed sprite graphics
    db $28 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_8 ; id 8: compressed sprite graphics
    db $30 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Gfx_TriggerSpriteTable_9 ; id 9: compressed sprite graphics
    db $38 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here
    dfar Tiles0Gfx_2 ; id 10: compressed sprite graphics
    db $40 ; palette byte offset from 7E:$4BBD (LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_OBJPaletteBufferData)
    db $00, $00 ; not read here

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

; called from FieldState_WalkAMenu: may return early; returns if bit 7 of wFieldActionRequest is
; set; returns if bit 0 of hPlayerStateFlags is set; returns unless bit 0 of wJoypadPressed is set;
; returns unless bit 7 of wMapType is set; branches on wMapType; returns unless wMapType is $86;
; branches on hPlayerFacing; calls ReadTileBuffer2x2AtPixel_Bank12; branches on wMapType; branches
; on wTilesUnderPoint; copies L to wScriptParam0; then 31 more steps (see the code) (E-0347)
; why: a helper of FieldState_WalkAMenu; FieldState_WalkAMenu: field state 5: walking where A opens
; the field menu (OpenFieldMenuOnA) instead of talking (E-0352, E-0339)
FieldState_WalkAMenu_WaitTextWindowState::
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
    ld de, FieldState_WalkAMenu_WaitTextWindowState_Data
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
    ld de, FieldState_WalkAMenu_WaitTextWindowState_Data
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

; data read by FieldState_WalkAMenu_WaitTextWindowState (8 bytes) (E-0347)
FieldState_WalkAMenu_WaitTextWindowState_Data::
    db $01, $10, $12, $13, $20, $21, $23, $32

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
    call TriggerEventForStatusedMemberHP
    ret c
    call TriggerEventC7IfGold1000AndNoItems19To1C
    ret c
    call RunPeriodicFieldEventChecks_WriteRAMGAndPendingFieldEvent
    ret c
    call TriggerEventC9IfExpDigitsRepeat
    ret c
    call TriggerEventC4OrC5IfGold1000
    ret c
    sub a
    ret

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

; with at least 1000 gold: checks party members with status bits 7, 2 or 0 of field $55 against half
; their max HP and may set an event (E-0128) (E-0344: the address in its name dropped or read as the
; label there; was TriggerEventForStatusedMemberHP)
TriggerEventForStatusedMemberHP::
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

; called from RunPeriodicFieldEventChecks: branches on wEventItemSlot; branches on wGoldHi; branches
; on wGoldMid; branches on wGoldLo; sets rRAMG to $0a; calls LoadSRAMRecordWord; sets rRAMG to 0;
; sets rRAMG to $0a; calls LoadSRAMRecordWord; sets rRAMG to 0; branches on D; branches on E; then 2
; more steps (see the code) (E-0347)
; why: a helper of RunPeriodicFieldEventChecks; RunPeriodicFieldEventChecks: on town maps, every 100
; calls (wTownEventTimer), tries the gold, party-stat and digit events in turn until one sets
; wPendingFieldEvent (E-0352, E-0128)
RunPeriodicFieldEventChecks_WriteRAMGAndPendingFieldEvent::
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

; returns unless ClearPendingFieldEventWhenFieldIdle_TestFlagBit is 0, wTriggerKind is $FF and no
; script runs; then, unless bit 7 of wMapType is set, wPendingFieldEvent = 0 (E-0122)
ClearPendingFieldEventWhenFieldIdle::
    call ClearPendingFieldEventWhenFieldIdle_TestFlagBit
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
    jr nz, RunPendingFieldEventPendingFieldEvent_Skip
    xor a
    ld [wPendingFieldEvent], a
    ret

; on town maps runs the pending event in wPendingFieldEvent (bits 7 and 6 select the stage; some
; kinds need wInventory + $17); otherwise clears it (E-0130)
RunPendingFieldEventPendingFieldEvent::
    ld a, [wPendingFieldEvent]
    and $0f
    cp $08
    jr z, .clear_pending_field_event
    ldh a, [hMapId]
    cp $20
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $30
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $48
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $70
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $a8
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $b0
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $b8
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp $c8
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent

.clear_pending_field_event:
    xor a
    ld [wPendingFieldEvent], a
    ret

; Takes A; changes A; may return early (E-0347)
; why: part of RunPendingFieldEventPendingFieldEvent; RunPendingFieldEventPendingFieldEvent: on town
; maps runs the pending event in wPendingFieldEvent (bits 7 and 6 select the stage (E-0352, E-0130)
RunPendingFieldEventPendingFieldEvent_Skip::
    and $7f
    ret nz

; Returns unless bit 7 of wPendingFieldEvent is set; branches on wPendingFieldEvent; branches on
; wPendingFieldEvent & $0f; sets wPendingFieldEvent to 0; sets wTownEventTimer to $63; calls
; RunPeriodicFieldEventChecks; calls NextTableByte; calls ReadTileBuffer2x2AtPixel_Bank12; calls
; RollFieldEventOnTallTiles; may return early; sets wSpriteSlots to 3; copies wPendingFieldEvent &
; $bf to wPendingFieldEvent; then 10 more steps (see the code) (E-0347)
; why: part of RunPendingFieldEventPendingFieldEvent; RunPendingFieldEventPendingFieldEvent: on town
; maps runs the pending event in wPendingFieldEvent (bits 7 and 6 select the stage (E-0352, E-0130)
RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent::
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
    ld hl, RunPendingFieldEventPendingFieldEvent_Data2
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
    ld hl, RunPendingFieldEventPendingFieldEvent_Data1
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

; data read by RunPendingFieldEventPendingFieldEvent (16 bytes) (E-0347)
RunPendingFieldEventPendingFieldEvent_Data1::
    db $12, $15, $3d, $3e, $10, $11, $17, $15, $14, $13, $57, $12, $15, $12, $14, $10

RunPendingFieldEventPendingFieldEvent_Data2::
    db $20, $20, $70, $60, $20, $60, $70, $20

; called from ClearPendingFieldEventWhenFieldIdle: branches on wMapType; branches on hMapId;
; branches on hMapScreenX; branches on hMapScreenY; checks EVENT_SCENE_CRATE; checks
; EVENT_WELCOME_YOUNG_HUMAN_I_HEARD; sets wPendingFieldEvent to 0; also changes DE and A by register
; arithmetic (E-0347)
; why: a helper of ClearPendingFieldEventWhenFieldIdle; ClearPendingFieldEventWhenFieldIdle: returns
; unless ClearPendingFieldEventWhenFieldIdle_TestFlagBit is 0, wTriggerKind is $FF and no script
; runs (E-0352, E-0122)
ClearPendingFieldEventWhenFieldIdle_TestFlagBit::
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

; hTemp0 = the index of the first byte of the 24-entry list at wInventory equal to hTemp0; $FF when
; an entry is $00 or $FF first or no entry matches (E-0353)
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

; called from GreatLogTalkEvents_StartScriptAtHL_B13_GreatLogTalkEvents_WriteTemp1: sets hTemp1 to 0
; (E-0347)
; why: a helper of GreatLogTalkEvents_StartScriptAtHL_B13_GreatLogTalkEvents_WriteTemp1, in step 204
; of GreatLogTalkEvents (when wTalkEventGroup = 204); GreatLogTalkEvents: talk category 1: jumps by
; wTalkEventGroup to the talk handlers of the Great Log home island (messages from $0000-$02DF:
; Warubou, Prince ... (E-0352)
GreatLogTalkEvents_WriteTemp1::
    xor a
    ldh [hTemp1], a
    ret

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

; called from ReturnMessage_TestFlagBit: sets wGoldHi; sets wGoldMid; sets wGoldLo (E-0347)
; why: a helper of ReturnMessage_TestFlagBit, in step 0 of ReturnMessage (when wScriptStep = 0);
; ReturnMessage: implements script command type 88 (SCRIPT_RETURN_MESSAGE): a key-world/field talk
; event (group $05, dispatched by ... (E-0352)
ReturnMessage_WriteGoldHiAndGoldMidEtc::
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
