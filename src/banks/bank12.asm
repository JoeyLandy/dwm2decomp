SECTION "Bank 12", ROMX[$4000], BANK[$12]
    db $12

; implements script command type 9D (SCRIPT_COUNTDOWN_MESSAGE): a key-world/field talk event (group $1E, dispatched by CountDownTalkCountdownThenDispatchTalkEvent: one message); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand9D)
; reads: wScriptStep
CountdownMessage::
Func_012_4001:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw CountdownMessage_ToStartMessageAAndStep
    dw CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12

; entry 0 of the `rst $00` table in CountdownMessage
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
CountdownMessage_ToStartMessageAAndStep::
Jump_012_4009:: ; address name
    ld a, $10
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9C (SCRIPT_ENCOUNTER_MESSAGE): a key-world/field talk event (group $1D, dispatched by TickRandomEncounterCounter: one message (StartMessageA)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand9C)
; reads: wScriptStep
EncounterCounterMessage::
Func_012_4013:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw EncounterCounterMessage_ToStartMessageAAndStep
    dw CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12

; entry 1 of the `rst $00` table in CountdownMessage
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_401B:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in EncounterCounterMessage
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
EncounterCounterMessage_ToStartMessageAAndStep::
Jump_012_4026:: ; address name
    ld a, $0F
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9A (SCRIPT_RANDOM_BATTLE): a key-world/field talk event (group $19, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: picks a battle intro (NextRandomSeed) and starts a battle (SetModeState3AndSaveScreen)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand9A)
; reads: wScriptStep, wMapType, wKeyRandomLo
; writes: wScriptStartRequest, wBattleIntroKind, wBattleTransitionSubStep
; points at: wScriptStep
RandomBattleEvent::
Func_012_4030:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr z, .clear_battle_intro_kind
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_battle_intro_kind:
    xor a, a
    ld [wBattleIntroKind], a
    ld a, [wMapType]
    bit 7, a
    jr z, .call_next_random_seed
    ld a, $01
    ld [wBattleIntroKind], a

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $01
    sla a
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 99 (SCRIPT_OBJECT_PATH_1C): a key-world/field talk event (group $1C: moves an object by step deltas with the followers, then fades); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand99)
; reads: wScriptStep
ObjectPath1C::
Func_012_4064:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ObjectPath1C_SetBit2AtHL_B12
    dw ObjectPath1C_UpdateFollowersOnStep_Bank12
    dw ObjectPath1C_UpdateFollowersOnStep_Bank12_Case02
    dw ObjectPath1C_AddStepDeltaToPointedByte
    dw ObjectPath1C_WriteFollowerRecordsAndMapIdEtc
    dw ObjectPath1C_SetBit2AtHL_B12_Case05
    dw ObjectPath1C_WritePlayerY
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case07
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case08
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case09
    dw ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12
    dw ObjectPath1C_ClearBit2AtHL_Bank12

; entry 10 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12::
Jump_012_4080:: ; address name
    xor a, a
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $C]
    inc a
    ld [wFollowerRecords + $C], a
    ld de, wFollowerRecords + $C
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; entry 9 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, wPartyCount
; writes: wFollowerRecords, wScriptStep
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case09::
Jump_012_4092:: ; address name
    xor a, a
    ld [wFollowerRecords + $5], a
    ld de, wFollowerRecords + $7
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a
    ld hl, wFollowerRecords + $C
    inc [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, wPartyCount
; writes: wFollowerRecords, wScriptStep
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case08::
Jump_012_40B8:: ; address name
    xor a, a
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wFollowerRecords + $2]
    inc a
    ld [wFollowerRecords + $2], a
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $C
    inc [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 7 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerFacing, hPlayerY
; points at: hPlayerY
ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case07::
Jump_012_40E1:: ; address name
    xor a, a
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
    ld hl, wFollowerRecords + $C
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: wScriptStep
ObjectPath1C_WritePlayerY::
Jump_012_40FC:: ; address name
    ld hl, wFollowerRecords + $C
    inc [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $2
    inc [hl]
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $20
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wFollowerRecords
; points at: hPlayerStateFlags, wScriptStep
ObjectPath1C_SetBit2AtHL_B12_Case05::
Jump_012_4115:: ; address name
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $E0
    ld [wFollowerRecords + $2], a
    ld a, $D0
    ld [wFollowerRecords + $7], a
    ld a, $C0
    ld [wFollowerRecords + $C], a
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
; points at: hPlayerY
ObjectPath1C_WriteFollowerRecordsAndMapIdEtc::
Jump_012_413C:: ; address name
    ld a, $02
    ld [wFollowerRecords + $A], a
    ld hl, hPlayerY
    inc [hl]
    ld hl, wFollowerRecords + $2
    inc [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld a, [wFollowerRecords + $C]
    inc a
    ld [wFollowerRecords + $C], a
    cp a, $B0
    ret nz
    ld a, $00
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $70
    ld [wWarpDestX], a
    ld a, $F0
    ld [wWarpDestY], a
    xor a, a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wFollowerRecords, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ObjectPath1C_AddStepDeltaToPointedByte::
Jump_012_4177:: ; address name
    ld a, $01
    ld [wFollowerRecords + $A], a
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
    ld hl, wFollowerRecords + $B
    inc [hl]
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jp ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; entry 2 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wFollowerRecords, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ObjectPath1C_UpdateFollowersOnStep_Bank12_Case02::
Jump_012_41AA:: ; address name
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

; entry 1 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: hPlayerFacing, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ObjectPath1C_UpdateFollowersOnStep_Bank12::
Jump_012_41CC:: ; address name
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

; entry 0 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerStateFlags, hPlayerY, hPlayerX, wScriptStep
ObjectPath1C_SetBit2AtHL_B12::
Jump_012_41ED:: ; address name
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

; implements script command type 98 (SCRIPT_OBJECT_PATH_1B): a key-world/field talk event (group $1B: moves an object by step deltas with the followers, then fades); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand98)
; reads: wScriptStep
ObjectPath1B::
Func_012_4210:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ObjectPath1B_SetBit2AtHL_B12
    dw ObjectPath1B_UpdateFollowersOnStep_Bank12
    dw ObjectPath1B_UpdateFollowersOnStep_Bank12_Case02
    dw ObjectPath1B_AddStepDeltaToPointedByte
    dw ObjectPath1B_WriteFollowerRecordsAndMapIdEtc
    dw ObjectPath1B_SetBit2AtHL_B12_Case05
    dw ObjectPath1B_UpdateFollowersOnStep_Bank12_Case06
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_Case07
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_Case08
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_Case09
    dw ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12
    dw ObjectPath1C_ClearBit2AtHL_Bank12

; entry 11 of the `rst $00` table in ObjectPath1C
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
; points at: hPlayerStateFlags
ObjectPath1C_ClearBit2AtHL_Bank12::
Jump_012_422C:: ; address name
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12::
Jump_012_4238:: ; address name
    ld a, $03
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $B]
    dec a
    ld [wFollowerRecords + $B], a
    ld de, wFollowerRecords + $C
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; entry 9 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wPartyCount
; writes: wFollowerRecords, wScriptStep
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_Case09::
Jump_012_424B:: ; address name
    ld a, $03
    ld [wFollowerRecords + $5], a
    ld de, wFollowerRecords + $7
    call ScriptApplyStepDeltaAtDE_Bank12
    ld hl, wFollowerRecords + $6
    dec [hl]
    ld hl, wFollowerRecords + $C
    dec [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, wPartyCount
; writes: wFollowerRecords, wScriptStep
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_Case08::
Jump_012_426F:: ; address name
    ld a, $03
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $C
    dec [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 7 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hPlayerFacing, hPlayerX
; points at: hPlayerY
ObjectPath1B_ScriptApplyStepDeltaAtDE_Bank12_Case07::
Jump_012_4299:: ; address name
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
    ld hl, wFollowerRecords + $C
    dec [hl]
    ret

; DE = address of a byte: adds the step delta for wScriptParam0, then wScriptParam0 += 2; at $20 it is reset and wScriptStep += 1 (the bank-$12 form of ScriptApplyStepDeltaAtDE) (E-0117)
; 8 call sites from 8 routines (e.g. ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12, ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case09, ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case08, ObjectPath1C_ScriptApplyStepDeltaAtDE_Bank12_Case07, ...)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
ScriptApplyStepDeltaAtDE_Bank12::
Func_012_42B5:: ; address name
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: wScriptStep
ObjectPath1B_UpdateFollowersOnStep_Bank12_Case06::
Jump_012_42D7:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wFollowerRecords
; points at: hPlayerStateFlags, wScriptStep
ObjectPath1B_SetBit2AtHL_B12_Case05::
Jump_012_42E9:: ; address name
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $C0
    ld [wFollowerRecords + $2], a
    ld a, $D0
    ld [wFollowerRecords + $7], a
    ld a, $E0
    ld [wFollowerRecords + $C], a
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
; points at: hPlayerY
ObjectPath1B_WriteFollowerRecordsAndMapIdEtc::
Jump_012_4310:: ; address name
    ld hl, hPlayerY
    dec [hl]
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld a, [wFollowerRecords + $C]
    dec a
    ld [wFollowerRecords + $C], a
    cp a, $F0
    ret nz
    ld a, $1A
    ldh [hMapId], a
    ld a, $02
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wWarpDestX], a
    ld a, $B0
    ld [wWarpDestY], a
    xor a, a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wFollowerRecords, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ObjectPath1B_AddStepDeltaToPointedByte::
Jump_012_4346:: ; address name
    ld a, $02
    ld [wFollowerRecords + $A], a
    ld hl, hPlayerY
    dec [hl]
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $C
    dec [hl]
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    jr ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0

; entry 2 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ObjectPath1B_UpdateFollowersOnStep_Bank12_Case02::
Jump_012_436E:: ; address name
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

; entry 1 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ObjectPath1B_UpdateFollowersOnStep_Bank12::
Jump_012_438A:: ; address name
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

; entry 0 of the `rst $00` table in ObjectPath1B
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerStateFlags, hPlayerY, wScriptStep
ObjectPath1B_SetBit2AtHL_B12::
Jump_012_43A6:: ; address name
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

ObjectPath1B_SetBit2AtHL_B12_CheckScriptParam0::
Jump_012_43C6:: ; address name
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 96 (SCRIPT_ARENA_ROUNDS): the arena's rounds: messages from ArenaRankMessageTable and foes from ArenaEncounterLists by wAreaGraphicsIndex, advancing the round (IncArenaRoundAndCopyArena); reached through ScriptCommand96 in bank $10 (E-0038, E-0246)
; 1 call site from 1 routine (e.g. ScriptCommand96)
; reads: wScriptStep
ArenaRounds::
Func_012_43DA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ArenaRounds_ScriptStartFadeAndAdvanceStep
    dw ArenaRounds_RunMessageBoxThenContinue_684A_Case01
    dw ArenaRounds_SetBit2AtHL_B12
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaRounds_StartArenaRankMessage_Case05
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaRounds_StartArenaRankMessage_Case0D
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep_Case12
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaRounds_StartArenaRankMessage
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_QueueSoundEffect
    dw ArenaRounds_FullyHealParty
    dw ArenaRounds_RestartMapMusic

; entry 21 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep, wRecordCapacity
ArenaRounds_StartArenaRankMessage::
Jump_012_4412:: ; address name
    ld a, $07
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ret

; entry 13 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordCapacity
; writes: wScriptStep
; points at: wRecordCapacity, wScriptStep
ArenaRounds_StartArenaRankMessage_Case0D::
Jump_012_4420:: ; address name
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wRecordCapacity]
    cp a, $02
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

; entry 5 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordCapacity
; writes: wScriptStep
; points at: wRecordCapacity, wScriptStep
ArenaRounds_StartArenaRankMessage_Case05::
Jump_012_444D:: ; address name
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wRecordCapacity]
    cp a, $02
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

; entry 1 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; writes: hFieldDrawFlags, hPlayerFacing, wFollowerRecords, hPlayerX, wMessageIndex
; points at: hPlayerStateFlags, wArenaFlags, wScriptStep
ArenaRounds_RunMessageBoxThenContinue_684A_Case01::
Jump_012_447A:: ; address name
    ld a, $0E
    ldh [hFieldDrawFlags], a
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ld hl, wArenaFlags
    inc [hl]
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wAreaGraphicsIndex
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wArenaFlags
ArenaRounds_ScriptStartFadeAndAdvanceStep::
Jump_012_44AF:: ; address name
    ld a, $0B
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, [wAreaGraphicsIndex]
    add a, $05
    call StartMessageA
    ld a, $80
    ld [wArenaFlags], a
    ret

; implements script command type 95 (SCRIPT_ARENA_GRID_BATTLE): an arena battle: messages from ArenaRankMessageTable (StartArenaRankMessage) and foes from GridEncounterTable by wGridCursorX and wScreenCountPlusOne (battle intro 4, encounter kind 2; ScriptCommand95's Shared02); reached through ScriptCommand95 in bank $10 (E-0038, E-0246)
; 1 call site from 1 routine (e.g. ScriptCommand95)
; reads: wScriptStep
ArenaGridBattle::
Func_012_44DB:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ArenaGridBattle_ScriptStartFadeAndAdvanceStep
    dw ArenaGridBattle_RunMessageBoxThenContinue_684A
    dw ArenaGridBattle_RunMessageBoxThenContinue_684A_Case02
    dw ArenaRounds_SetBit2AtHL_B12
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaGridBattle_StartArenaRankMessage_Case06
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaGridBattle_StartArenaRankMessage_Case0E
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_SetupMap0BMonsterObjects
    dw ArenaRounds_WriteMessageIndexAndSpriteSlotCount
    dw ArenaRounds_ClearBit2AtHL_Bank12
    dw ArenaRounds_ToStartArenaRankMessageAndStep_Case12
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_StepScriptParam0Counter_Bank12
    dw ArenaGridBattle_StartArenaRankMessage
    dw ArenaRounds_RunMessageBoxThenContinue_684A
    dw ArenaRounds_QueueSoundEffect
    dw ArenaRounds_FullyHealParty
    dw ArenaRounds_RestartMapMusic

; entry 25 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi
; writes: wTalkEventIndex, wTalkEventGroup, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, hSpriteWindowClipMode, wScriptCommandType, wScriptInDataBank
ArenaRounds_RestartMapMusic::
Jump_012_4515:: ; address name
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
    ld a, $F7
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 24 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ArenaRounds_FullyHealParty::
Jump_012_4546:: ; address name
    call FullyHealParty
    ld a, $04
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 23 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
ArenaRounds_QueueSoundEffect::
Jump_012_456A:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $01
    jr nz, .cp_3C
    ld a, $6D
    call QueueSoundEffect
    ret

.cp_3C:
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ArenaGridBattle
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep, wRecordCapacity
ArenaGridBattle_StartArenaRankMessage::
Jump_012_4587:: ; address name
    ld a, $07
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ret

; entry 18 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ArenaRounds_ToStartArenaRankMessageAndStep_Case12::
Jump_012_4595:: ; address name
    ld a, $06
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ArenaGridBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
; points at: wScriptStep, wRecordCapacity
ArenaGridBattle_StartArenaRankMessage_Case0E::
Jump_012_459F:: ; address name
    ld a, $05
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wArenaRank]
    or a, a
    jr nz, .call_setup_screen_count_plus_one_from_record
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind
    ret

.call_setup_screen_count_plus_one_from_record:
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_Shared02
    ret

; entry 10 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ArenaRounds_ToStartArenaRankMessageAndStep::
Jump_012_45CC:: ; address name
    ld a, $04
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wSpriteSlots, wFieldEventKind, wObject1, wObject2, wObject3
; points at: wScriptStep
ArenaRounds_ClearBit2AtHL_Bank12::
Jump_012_45D6:: ; address name
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $C]
    dec a
    ld [wSpriteSlots + $C], a
    cp a, $30
    ret nz
    ld a, $07
    ld [wFieldEventKind], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    ld hl, wSpriteSlots + $D
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

; entry 8 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex
; writes: wMessageIndex, wSpriteSlotCount
; points at: wScriptStep
ArenaRounds_WriteMessageIndexAndSpriteSlotCount::
Jump_012_461A:: ; address name
    ld a, [wMessageIndex]
    cp a, $60
    jr z, .skip
    inc a
    ld [wMessageIndex], a
    cp a, $10
    jr nz, .cp_20
    ld a, $02
    ld [wSpriteSlotCount], a
    jr .skip

.cp_20:
    cp a, $20
    jr nz, .cp_30
    ld a, $03
    ld [wSpriteSlotCount], a
    jr .skip

.cp_30:
    cp a, $30
    jr nz, .skip
    ld a, $04
    ld [wSpriteSlotCount], a

.skip:
    ld hl, wSpriteSlots + $C
    ld b, $04

.loop:
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, .skip2
    cp a, $20
    jr nc, .next

.skip2:
    ld a, [hl]
    inc a
    ld [hl], a
    jp .restore

.next:
    dec hl
    ld a, [hl]
    cp a, $60
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
    cp a, $40
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
    cp a, $70
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

; entry 7 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, wSpriteSlotCount, wFieldEventKind, wMessageIndex
; points at: wScriptStep
ArenaRounds_SetupMap0BMonsterObjects::
Jump_012_469E:: ; address name
    farcall SetupMap0BMonsterObjects
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B12
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B12
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B12
    ld hl, wObject3 + OBJ_FLAGS
    call SetBit2AtHL_B12
    xor a, a
    ld [wFieldEventKind], a
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ArenaGridBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank
; points at: wScriptStep, wRecordCapacity
ArenaGridBattle_StartArenaRankMessage_Case06::
Jump_012_46D8:: ; address name
    ld a, $03
    call StartArenaRankMessage
    ld hl, wScriptStep
    inc [hl]
    ld hl, wRecordCapacity
    dec [hl]
    ld a, [wArenaRank]
    or a, a
    jr nz, .call_setup_screen_count_plus_one_from_record
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind
    ret

.call_setup_screen_count_plus_one_from_record:
    farcall SetupScreenCountPlusOneFromRecordCapacity
    farcall ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_Shared02
    ret

; entry 4 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleIntroKind, wBattleTransitionSubStep
; points at: wScriptStep, wRecordCapacity
ArenaRounds_StepScriptParam0Counter_Bank12::
Jump_012_4705:: ; address name
    ld hl, wFollowerRecords + $1
    inc [hl]
    ld hl, wFollowerRecords + $6
    inc [hl]
    ld hl, wFollowerRecords + $B
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

; entry 3 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageIndex
; points at: wScriptStep
ArenaRounds_RunMessageBoxThenContinue_684A::
Jump_012_473C:: ; address name
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ArenaRounds
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wScriptParam0, hPlayerY, hPlayerX, wScriptParam1
; writes: wMessageIndex, hFieldDrawFlags, hPlayerY, hPlayerFacing, hPlayerX, wFollowerRecords, wFieldEventKind, wScriptParam0, ...
; points at: hPlayerStateFlags, wScriptParam0, wScriptStep
ArenaRounds_SetBit2AtHL_B12::
Jump_012_474A:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    ld a, [wMessageIndex]
    cp a, $60
    jr z, .check_script_param0
    inc a
    ld [wMessageIndex], a
    cp a, $10
    jr nz, .cp_20
    ld a, $0C
    ldh [hFieldDrawFlags], a
    jr .check_script_param0

.cp_20:
    cp a, $20
    jr nz, .cp_30
    ld a, $08
    ldh [hFieldDrawFlags], a
    jr .check_script_param0

.cp_30:
    cp a, $30
    jr nz, .check_script_param0
    xor a, a
    ldh [hFieldDrawFlags], a

.check_script_param0:
    ld a, [wScriptParam0]
    or a, a
    jr nz, .skip
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $20
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
    cp a, $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip2:
    dec a
    jr nz, .skip3
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    xor a, a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $40
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
    cp a, $20
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
    cp a, $30
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank12
    ld a, $01
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $02
    call StartArenaRankMessage
    ld a, [wScriptParam1]
    ld [wFieldEventKind], a
    ld a, $00
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ArenaGridBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldEventKind
; writes: hPlayerFacing, wFollowerRecords, hPlayerX, wScriptParam1, wFieldEventKind, wMessageIndex
; points at: hPlayerStateFlags, wScriptStep
ArenaGridBattle_RunMessageBoxThenContinue_684A_Case02::
Jump_012_4814:: ; address name
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B12
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ld a, $6D
    call QueueSoundEffect
    ld a, [wFieldEventKind]
    ld [wScriptParam1], a
    xor a, a
    ld [wFieldEventKind], a
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ArenaGridBattle
; no direct call (reached through a table, a jump or a vector)
; writes: hFieldDrawFlags
; points at: wScriptStep
ArenaGridBattle_RunMessageBoxThenContinue_684A::
Jump_012_4850:: ; address name
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    ld a, $01
    call StartArenaRankMessage
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ArenaGridBattle
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wArenaFlags
ArenaGridBattle_ScriptStartFadeAndAdvanceStep::
Jump_012_4863:: ; address name
    ld a, $0B
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call StartArenaRankMessage
    xor a, a
    ld [wArenaFlags], a
    ret

; starts the message at Data_012_48B9 + 2 * A + 16 * wC82C (16 * 5 when bit 7 of wC94A is set) (E-0125)
; 13 call sites from 11 routines (e.g. ArenaRounds_StartArenaRankMessage, ArenaRounds_StartArenaRankMessage_Case0D, ArenaRounds_StartArenaRankMessage_Case05, ArenaGridBattle_StartArenaRankMessage, ...)
; reads: wArenaFlags, wArenaRank
StartArenaRankMessage::
Func_012_488B:: ; address name
    ld de, ArenaRankMessageTable
    sla a
    add a, e
    ld e, a
    jr nc, .check_arena_flags
    inc d

.check_arena_flags:
    ld a, [wArenaFlags]
    bit 7, a
    jr nz, .skip
    ld a, [wArenaRank]
    swap a
    add a, e
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
    add a, e
    ld e, a
    jr nc, .call_start_message_a2
    inc d

.call_start_message_a2:
    ld a, [de]
    call StartMessageA
    ret

; E-0237 (C1: StartArenaRankMessage reads the low byte at $48B9 + 2 * A + 16 * wArenaRank (row 5 when wArenaFlags bit 7 is set) and passes it to StartMessageA, a string of the group already in wMessageGroup; 6 rows of 8 words).
; record: one row per arena rank
ArenaRankMessageTable::
Data_012_48B9:: ; address name
    dw $0040, $008C, $0013, $0017, $0014, $0018, $0015, $001B ; id 0
    dw $0041, $008D, $0013, $0017, $0014, $0018, $0015, $001C ; id 1
    dw $0042, $008E, $0013, $0017, $0014, $0018, $0015, $001D ; id 2
    dw $0043, $008F, $0013, $0017, $0014, $0018, $0015, $001E ; id 3
    dw $0044, $0090, $0013, $0017, $0014, $0018, $0015, $001F ; id 4
    dw $FFFF, $FFFF, $0013, $0019, $0014, $001A, $0016, $0020 ; id 5

; implements script command type 9F (SCRIPT_LINK_MESSAGE): a key-world/field talk event (group $21, dispatched from the link screens (GameMode5_Update, RunLinkSession4ScreenState): graphics and a message); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand9F)
; reads: wScriptStep
LinkMessageEvent::
Func_012_4919:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case05
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetSaveStateFlag

; entry 22 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptByte65
; writes: wSaveStateFlag, wGameMode, wModeState, wModeChangeRequest, wScriptRunning
LinkMessageEvent_SetSaveStateFlag::
Jump_012_494B:: ; address name
    ld a, [wScriptByte65]
    ld [wSaveStateFlag], a
    ld a, $08
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wScriptRunning], a
    ret

; implements script command type 8F (SCRIPT_NPC_BREED_WARP): a key-world/field talk event (group $20, dispatched by NpcBreedMenu_Case04_DispatchTalkEvent: fades, sets the warp destination and wSavedPositionValid, and queues the next script and talk event); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand8F)
; reads: wScriptStep
NpcBreedWarp::
Func_012_4965:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case05
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw NpcBreedWarp_WriteMapIdAndMapScreenXEtc
    dw NpcBreedWarp_WriteSpriteSlotsAndTalkEventIndexEtc

; entry 24 of the `rst $00` table in NpcBreedWarp
; no direct call (reached through a table, a jump or a vector)
; reads: wSavedPlayerState, wScriptReturnBank, wScriptReturnLo, wScriptReturnHi
; writes: wSpriteSlots, wTalkEventIndex, wTalkEventGroup, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScriptCommandType, wScriptInDataBank
NpcBreedWarp_WriteSpriteSlotsAndTalkEventIndexEtc::
Jump_012_499B:: ; address name
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
    ld a, $F4
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 23 of the `rst $00` table in NpcBreedWarp
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTableIndex
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, hFieldDrawFlags, wFieldTransitionKind, wSavedPositionValid
NpcBreedWarp_WriteMapIdAndMapScreenXEtc::
Jump_012_49C8:: ; address name
    ld a, [wScreenTableIndex]
    ld hl, NpcBreedWarp_WriteMapIdAndMapScreenXEtc_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, [wScreenTableIndex]
    cp a, $01
    jr z, .set_warp_dest_x_to_40
    cp a, $03
    jr z, .set_warp_dest_x_to_40
    cp a, $05
    jr z, .set_warp_dest_x_to_40
    cp a, $06
    jr z, .set_warp_dest_x_to_40
    cp a, $07
    jr z, .set_warp_dest_x_to_40
    ld a, $02
    ldh [hMapScreenX], a

.set_warp_dest_x_to_40:
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wSavedPositionValid], a
    ret

; address loaded by NpcBreedWarp_WriteMapIdAndMapScreenXEtc
NpcBreedWarp_WriteMapIdAndMapScreenXEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_4A14:: ; address name
    db $04, $17, $04, $17, $04, $17, $17, $17, $04, $04

; implements script command type 8D (SCRIPT_BREED_CHILD_SCENE): a key-world/field talk event (group $17, dispatched by BreedMenu_TalkEvent17ThenNameEntry: a field object with loaded graphics, a message with a name from the string database (CopyStringToBuffer_Bank08)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand8D)
; reads: wScriptStep
BreedChildScene::
Func_012_4A1E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case05
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw BreedChildScene_DecompressGraphicsTemp0ToTemp4
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw BreedChildScene_RunFieldCommandTemp0AndStep
    dw BreedChildScene_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw BreedChildScene_CopyStringToBuffer_Bank08
    dw BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12
    dw BreedChildScene_WriteMapIdAndMapScreenXEtc

; entry 17 of the `rst $00` table in BreedChildScene
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wOBJPaletteUploadRequest
; points at: wChildRecord, wScriptStep
BreedChildScene_DecompressGraphicsTemp0ToTemp4::
Jump_012_4A5A:: ; address name
    ld a, $0B
    ld hl, wChildRecord
    add_a_to_hl
    ld a, [hl+]
    ld [wObject1 + OBJ_SPRITE_SET], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject1 + $3], a
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0D
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8C (SCRIPT_BREED_CHILD_SPRITE): a key-world/field talk event (group $16, dispatched by BreedMenu_CopyToChildThenTalkEvent16: loads graphics (DecompressGraphicsTemp0ToTemp4) for a field object (RunFieldCommandTemp0)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand8C)
; reads: wScriptStep
BreedChildSprite::
Func_012_4A9A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw BreedChildSprite_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw BreedChildSprite_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw BreedChildScene_RunFieldCommandTemp0AndStep
    dw BreedChildScene_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw BreedChildScene_CopyStringToBuffer_Bank08
    dw BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12
    dw BreedChildScene_WriteMapIdAndMapScreenXEtc

; entry 27 of the `rst $00` table in BreedChildScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi
; writes: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wObject5, wSpriteSlotCount, wFieldEventKind, ...
BreedChildScene_WriteMapIdAndMapScreenXEtc::
Jump_012_4AC0:: ; address name
    ld a, $0D
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ld a, $40
    ldh [hPlayerY], a
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wFieldEventKind], a
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $6A
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $ED
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 26 of the `rst $00` table in BreedChildScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hSpriteWindowClipMode
; points at: wScriptStep
BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_4B0A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ldh [hSpriteWindowClipMode], a
    ret

; entry 25 of the `rst $00` table in BreedChildScene
; no direct call (reached through a table, a jump or a vector)
; reads: hSpriteWindowClipMode
; writes: wStringIndex, wStringCategory, wStringDestLo, wStringDestHi, wScriptParam0, hSpriteWindowClipMode
; points at: wScriptStep, wChildRecord, wTextNumber
BreedChildScene_CopyStringToBuffer_Bank08::
Jump_012_4B19:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, wChildRecord
    ld a, $0B
    add_a_to_hl
    ld a, [hl+]
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
    ld a, $6D
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, .call_divide_b_by_a
    ld a, $17
    call StartMessageA
    ret

.call_divide_b_by_a:
    ld b, a
    ld a, $0A
    call DivideBByA
    ld hl, wTextNumber
    push af
    ld a, b
    or a, a
    jr z, .restore
    ld [hl+], a

.restore:
    pop af
    ld [hl+], a
    ld [hl], $F0
    ld a, $18
    call StartMessageA
    ldh a, [hSpriteWindowClipMode]
    ld [wScriptParam0], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ret

; entry 21 of the `rst $00` table in BreedChildScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject5, wObject1
; points at: wScriptStep
BreedChildScene_StepScriptParam0Counter_Bank12::
Jump_012_4B77:: ; address name
    ld a, [wScriptParam0]
    cp a, $C2
    jr nz, .call_step_script_param0_counter_bank12
    ld a, $74
    call QueueSoundEffect

.call_step_script_param0_counter_bank12:
    ld b, $E0
    call StepScriptParam0Counter_Bank12
    ret nc
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wObject1 + OBJ_STATE], a
    ld a, $3C
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in BreedChildScene
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
BreedChildScene_RunFieldCommandTemp0AndStep::
Jump_012_4B9B:: ; address name
    ld a, $0E
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in BreedChildSprite
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
BreedChildSprite_SetObject5::
Jump_012_4BAA:: ; address name
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in BreedChildSprite
; no direct call (reached through a table, a jump or a vector)
; reads: hFieldDrawFlags
; writes: hSpriteWindowClipMode, hFieldDrawFlags, wObject1, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
; points at: wChildRecord, wScriptStep
BreedChildSprite_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc::
Jump_012_4BB4:: ; address name
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ldh a, [hFieldDrawFlags]
    or a, $0F
    ldh [hFieldDrawFlags], a
    ld a, $0B
    ld hl, wChildRecord
    add_a_to_hl
    ld a, [hl+]
    ld [wObject1 + OBJ_SPRITE_SET], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject1 + $3], a
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0D
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wObject5], a
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8B (SCRIPT_BREED_FADE): a key-world/field talk event (group $15, dispatched by BreedMenu_TalkEvent15: a palette fade); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand8B)
; reads: wScriptStep
BreedFade::
Func_012_4C07:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw NpcBreedWarp_ScriptStartFadeAndAdvanceStep
    dw LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject1AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case05
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteObject2AndScriptParam0
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc
    dw LinkMessageEvent_ToStartMessageAAndStep
    dw LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw LinkMessageEvent_ClearBit2AtHL_Bank12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetObject5
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw LinkMessageEvent_SetBit2AtHL_B12
    dw LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03
    dw BreedFade_StartPaletteFade
    dw BreedFade_WaitFadeState

; entry 24 of the `rst $00` table in BreedFade
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScriptReturnBank, wScriptReturnLo, wScriptReturnHi
; writes: wTalkEventIndex, wTalkEventGroup, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScriptCommandType, wScriptInDataBank
BreedFade_WaitFadeState::
Jump_012_4C3D:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $01
    ld [wTalkEventIndex], a
    ld a, $6A
    ld [wTalkEventGroup], a
    ld a, [wScriptReturnBank]
    ld [wScriptStartRequest], a
    ld a, [wScriptReturnLo]
    ld [wScriptPointerLo], a
    ld a, [wScriptReturnHi]
    ld [wScriptPointerHi], a
    ld a, $ED
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 23 of the `rst $00` table in BreedFade
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, hFieldDrawFlags, wFieldTransitionKind, wSavedPositionValid
; points at: wScriptStep
BreedFade_StartPaletteFade::
Jump_012_4C69:: ; address name
    ld a, $0D
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $00
    ld [wFieldTransitionKind], a
    ld a, $0F
    call StartPaletteFade
    ld a, $01
    ld [wSavedPositionValid], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
LinkMessageEvent_SetObject5::
Jump_012_4C97:: ; address name
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_4CA0:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
LinkMessageEvent_ToStartMessageAAndStep::
Jump_012_4CAA:: ; address name
    ld a, $0E
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldInitFlag, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
LinkMessageEvent_WriteFieldInitFlagAndMapIdEtc::
Jump_012_4CB4:: ; address name
    ld a, $8D
    ld [wFieldInitFlag], a
    jp NpcBreedWarp_ScriptStartFadeAndAdvanceStep

; entry 10 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wSpriteSlots, wObject1, wObject2
; points at: wScriptStep
LinkMessageEvent_SetBit2AtHL_B12::
Jump_012_4CBC:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B12
    ld a, [wSpriteSlots + $C]
    inc a
    ld [wSpriteSlots + $C], a
    cp a, $C8
    ret nz
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2
; writes: wObject2, wScriptParam0
; points at: wScriptStep
LinkMessageEvent_WriteObject2AndScriptParam0::
Jump_012_4CDF:: ; address name
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp a, $58
    ret nz
    xor a, a
    ld [wObject2 + OBJ_STATE], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
LinkMessageEvent_StepScriptParam0Counter_Bank12_Case05::
Jump_012_4D05:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank12
    ret nc
    ld a, $40
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wScriptParam0
; points at: wScriptStep
LinkMessageEvent_WriteObject1AndScriptParam0::
Jump_012_4D15:: ; address name
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp a, $48
    ret nz
    xor a, a
    ld [wObject1 + OBJ_STATE], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03::
Jump_012_4D3B:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
; points at: wScriptStep
LinkMessageEvent_StepScriptParam0Counter_Bank12::
Jump_012_4D46:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank12
    ret nc
    ld a, $40
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wSpriteSlots
; points at: wScriptStep
LinkMessageEvent_ClearBit2AtHL_Bank12::
Jump_012_4D56:: ; address name
    ld a, [wSpriteSlots + $C]
    dec a
    ld [wSpriteSlots + $C], a
    cp a, $58
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in LinkMessageEvent
; no direct call (reached through a table, a jump or a vector)
; reads: hFieldDrawFlags
; writes: hSpriteWindowClipMode, hFieldDrawFlags, wObject1, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
; points at: wRecordBufA, wRecordBufB, wScriptStep
LinkMessageEvent_WriteSpriteWindowClipModeAndFieldDrawFlagsEtc::
Jump_012_4D6B:: ; address name
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ldh a, [hFieldDrawFlags]
    or a, $0F
    ldh [hFieldDrawFlags], a
    ld a, $0B
    ld hl, wRecordBufA
    add_a_to_hl
    ld a, [hl+]
    ld [wObject1 + OBJ_SPRITE_SET], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject1 + $3], a
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0B
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl+]
    ld [wObject2 + OBJ_SPRITE_SET], a
    ldh [hTemp0], a
    ld a, [hl]
    ld [wObject2 + $3], a
    ldh [hTemp1], a
    xor a, a
    ldh [hTemp2], a
    ld a, $07
    ldh [hTemp3], a
    ld hl, vTiles0 + $700
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in NpcBreedWarp
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
NpcBreedWarp_ScriptStartFadeAndAdvanceStep::
Jump_012_4DDC:: ; address name
    ld a, $14
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; copies wCB86, the player position and facing, wFollowerRecords and wC8F0-wC8FB fields into wC937-wC943, then advances wScriptStep (E-0121)
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords
; writes: wSavedPlayerState
; points at: wScriptStep
SavePlayerPositionStateAndStep:: ; heuristic: follows a terminator; C0
Func_012_4DFB:: ; address name
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
    ld a, [wFollowerRecords + $A]
    ld [wSavedPlayerState + $A], a
    ld a, [wFollowerRecords + $B]
    ld [wSavedPlayerState + $B], a
    ld a, [wFollowerRecords + $C]
    ld [wSavedPlayerState + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 94 (SCRIPT_FOLLOWERS_STEP_14): a key-world/field talk event (group $14: steps the followers, toggling object flag bit 1, with a sound); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand94)
; reads: wScriptStep
FollowersStep14::
Func_012_4E4B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_Case02

; implements script command type 93 (SCRIPT_WARP_WITH_FOLLOWERS): a key-world/field talk event (group $13: sets an object flag, fades, then sets the warp destination, wFollowerRecords and the field transition); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand93)
; reads: wScriptStep
WarpWithFollowers::
Func_012_4E55:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw WarpWithFollowers_ScriptStartFadeAndAdvanceStep
    dw WarpWithFollowers_SetBit1AtHL_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_Case02

; entry 3 of the `rst $00` table in WarpWithFollowers
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, hPlayerY
; writes: wFollowerRecords, hPlayerY
; points at: hPlayerStateFlags, wScriptStep
WarpWithFollowers_SetBit1AtHL_Bank12::
Jump_012_4E63:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank12
    xor a, a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $7]
    cp a, $E0
    jr nc, .check_follower_records
    ld a, [wFollowerRecords + $C]
    inc a
    inc a
    ld [wFollowerRecords + $C], a

.check_follower_records:
    ld a, [wFollowerRecords + $2]
    cp a, $E0
    jr nc, .check_player_y
    ld a, [wFollowerRecords + $7]
    inc a
    inc a
    ld [wFollowerRecords + $7], a

.check_player_y:
    ldh a, [hPlayerY]
    cp a, $E0
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
    cp a, $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in WarpWithFollowers
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
WarpWithFollowers_ScriptStartFadeAndAdvanceStep::
Jump_012_4EAD:: ; address name
    ld a, $01
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $F0
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; implements script command type 92 (SCRIPT_PLAYER_AND_FOLLOWERS_STEP): a key-world/field talk event (group $12: moves the player (UpdatePlayerMovement) and the followers); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand92)
; reads: wScriptStep
PlayerAndFollowersStep::
Func_012_4ECE:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw PlayerAndFollowersStep_UpdatePlayerMovement
    dw PlayerAndFollowersStep_UpdatePlayerMovement_Case03
    dw PlayerAndFollowersStep_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_Case02

; entry 4 of the `rst $00` table in PlayerAndFollowersStep
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
PlayerAndFollowersStep_UpdateFollowersOnStep_Bank12::
Jump_012_4EDE:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $20
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 91 (SCRIPT_FOLLOWERS_STEP_11): a key-world/field talk event (group $11: steps the followers (UpdateFollowersOnStep)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand91)
; reads: wScriptStep
FollowersStep11::
Func_012_4EF9:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep11_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_Case02

; entry 1 of the `rst $00` table in FollowersStep11
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
FollowersStep11_UpdateFollowersOnStep_Bank12::
Jump_012_4F03:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $60
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 90 (SCRIPT_FOLLOWERS_STEP_10): a key-world/field talk event (group $10: steps the followers (UpdateFollowersOnStep)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand90)
; reads: wScriptStep
FollowersStep10::
Func_012_4F1E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw FollowersStep14_SetBit1AtHL_Bank12AndStep
    dw FollowersStep14_UpdateFollowersOnStep_Bank12
    dw PlayerAndFollowersStep_UpdatePlayerMovement
    dw PlayerAndFollowersStep_UpdatePlayerMovement_Case03
    dw FollowersStep10_UpdateFollowersOnStep_Bank12
    dw FollowersStep14_UpdateFollowersOnStep_Bank12_Case02

; entry 2 of the `rst $00` table in FollowersStep14
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wPartyCount
; writes: wScriptStartRequest
; points at: hPlayerStateFlags
FollowersStep14_UpdateFollowersOnStep_Bank12_Case02::
Jump_012_4F2E:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, [wPartyCount]
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wFollowerRecords + $2
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in FollowersStep10
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
FollowersStep10_UpdateFollowersOnStep_Bank12::
Jump_012_4F5C:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PlayerAndFollowersStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest
; points at: wScriptStep
PlayerAndFollowersStep_UpdatePlayerMovement_Case03::
Jump_012_4F77:: ; address name
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PlayerAndFollowersStep
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags
; writes: wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, hFF80, wScriptStep
PlayerAndFollowersStep_UpdatePlayerMovement::
Jump_012_4F8E:: ; address name
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $08
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    inc [hl]
    ldh a, [hPlayerStateFlags]
    or a, $01
    ldh [hPlayerStateFlags], a
    ld hl, $FF80
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in FollowersStep14
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
FollowersStep14_UpdateFollowersOnStep_Bank12::
Jump_012_4FBC:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $80
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in FollowersStep14
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing
; points at: hPlayerStateFlags, wScriptStep
FollowersStep14_SetBit1AtHL_Bank12AndStep::
Jump_012_4FD7:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank12
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type A0 (SCRIPT_PLAYER_SPRITE_FLASH): a key-world/field talk event (group $09, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: reloads the player sprite graphics with a negative screen flash); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommandA0)
; reads: wScriptStep
PlayerSpriteFlash::
Func_012_4FEA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw PlayerSpriteFlash_QueueSoundEffect
    dw PlayerSpriteFlash_ToScriptStepFlashScreenNegative
    dw PlayerSpriteFlash_NextRandomSeed
    dw PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    dw PlayerSpriteFlash_LoadPlayerSpriteGraphics
    dw PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    dw PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    dw PlayerSpriteFlash_WriteSpriteWindowClipModeAndScriptStartRequest

; entry 7 of the `rst $00` table in PlayerSpriteFlash
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wScriptStartRequest
PlayerSpriteFlash_WriteSpriteWindowClipModeAndScriptStartRequest::
Jump_012_4FFE:: ; address name
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in PlayerSpriteFlash
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerSpriteOverride, hPlayerFacing
; writes: hPlayerSpriteOverride, wOBJPaletteUploadRequest, wScriptParam0, hPlayerFacing
; points at: wScriptStep
PlayerSpriteFlash_LoadPlayerSpriteGraphics::
Jump_012_5007:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing
    ldh a, [hPlayerSpriteOverride]
    or a, $80
    ldh [hPlayerSpriteOverride], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

; entry 3 of the `rst $00` table in PlayerSpriteFlash
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, hPlayerFacing
; points at: wScriptStep
PlayerSpriteFlash_WriteScriptParam0AndPlayerFacing::
Jump_012_501E:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $03
    ret nz
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PlayerSpriteFlash
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlotCount, wKeyRandomHi, hPlayerSpriteOverride, hPlayerSpriteStreamLo, hPlayerSpriteStreamHi
; writes: hPlayerFacing, hPlayerSpriteOverride, hPlayerSpriteStreamLo, hPlayerSpriteStreamHi, hPlayerSpriteTimerLo, hPlayerSpriteTimerHi, wScriptParam0
; points at: wScriptStep
PlayerSpriteFlash_NextRandomSeed::
Jump_012_5038:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wSpriteSlotCount]
    ld c, a

.loop:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    cp a, c
    jr nc, .loop
    swap a
    ld hl, wSpriteSlots + $B
    add_a_to_hl
    ld a, [hl+]
    cp a, $A0
    jr nc, .loop
    ld a, [hl]
    cp a, $90
    jr nc, .loop
    ld a, l
    sub a, $0B
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl+]
    ldh [hPlayerSpriteOverride], a
    ld a, [hl+]
    ldh [hPlayerSpriteStreamLo], a
    ld a, [hl]
    ldh [hPlayerSpriteStreamHi], a
    ldh a, [hPlayerSpriteOverride]
    cp a, $01
    jr nz, .set_player_sprite_timer_lo_to_64
    ldh a, [hPlayerSpriteStreamLo]
    cp a, $5E
    jr nz, .set_player_sprite_timer_lo_to_64
    ldh a, [hPlayerSpriteStreamHi]
    or a, a
    jr z, .loop

.set_player_sprite_timer_lo_to_64:
    ld a, $64
    ldh [hPlayerSpriteTimerLo], a
    xor a, a
    ldh [hPlayerSpriteTimerHi], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PlayerSpriteFlash
; no direct call (reached through a table, a jump or a vector)
PlayerSpriteFlash_ToScriptStepFlashScreenNegative::
Jump_012_5090:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 0 of the `rst $00` table in PlayerSpriteFlash
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
PlayerSpriteFlash_QueueSoundEffect::
Jump_012_5097:: ; address name
    ld a, $7A
    call QueueSoundEffect
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type A1 (SCRIPT_PLAYER_SPRITE_MESSAGE): a key-world/field talk event (group $0A, dispatched by UpdatePlayerMovement: reloads the player sprite graphics and shows a message); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommandA1)
; reads: wScriptStep
PlayerSpriteMessage::
Func_012_50B3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw PlayerSpriteMessage_ToStartMessageAAndStep
    dw PlayerSpriteMessage_RunMessageBoxCarryWhenIdle_Bank12
    dw PlayerSpriteMessage_LoadPlayerSpriteGraphics

; entry 2 of the `rst $00` table in PlayerSpriteMessage
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerSpriteOverride, wOBJPaletteUploadRequest, wScriptStartRequest
PlayerSpriteMessage_LoadPlayerSpriteGraphics::
Jump_012_50BD:: ; address name
    xor a, a
    ldh [hPlayerSpriteOverride], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in PlayerSpriteMessage
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
PlayerSpriteMessage_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_50D1:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in PlayerSpriteMessage
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
PlayerSpriteMessage_ToStartMessageAAndStep::
Jump_012_50DB:: ; address name
    ld a, $12
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8E (SCRIPT_MAP_LINK_WARP): a key-world/field talk event (group $08, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: a timed palette fade, then the warp destination from the map link records (E-0238) or wKeyWorldGoal); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand8E)
; reads: wScriptStep
MapLinkWarp::
Func_012_50E5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw MapLinkWarp_WritePlayerYAndPlayerFacingEtc
    dw MapLinkWarp_WriteScriptStartRequestAndMapIdEtc

; entry 1 of the `rst $00` table in MapLinkWarp
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId, wKeyWorldActive, wKeyWorldKey, wKeyWorldSlot, wKeyWorldGoalPos, wKeyWorldGoalPos2
; writes: wScriptStartRequest, hMapId, wWarpDestX, wWarpDestY
; points at: wKeyWorldGoal, wKeyWorldGoalScreen
MapLinkWarp_WriteScriptStartRequestAndMapIdEtc::
Jump_012_50ED:: ; address name
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
    cp a, $FF
    jr nz, .skip2
    ld c, $00
    ret

.skip2:
    cp a, c
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
    or a, a
    jr z, .call_map_link_warp_case01_write_warp_dest_x
    ld a, [wKeyWorldKey]
    dec a
    cp a, b
    jr nz, .call_map_link_warp_case01_write_warp_dest_x
    ld de, wKeyWorldGoal

.call_map_link_warp_case01_write_warp_dest_x:
    call MapLinkWarp_Case01_WriteWarpDestXAndWarpDestYEtc
    ret

; E-0238 (C1: the code at Jump_012_50ED walks 5-byte records up to $FF for the one whose byte 0 is hMapId, stores byte 1 to hMapId and passes DE = bytes 3-4 to MapLinkWarp_Case01_Sub01 (high nibble to wWarpDestX, low nibble * 16 to wWarpDestY, then the screen), or DE = wKeyWorldGoal when a key world is active and wKeyWorldKey - 1 equals byte 2; 16 records and $FF).
; record: map, new map, key; destination position and screen
MapExitWarpTable::
Data_012_5130:: ; address name
    db $20, $20, $00 ; id 0: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $2F, $20, $00 ; id 1: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $30, $30, $01 ; id 2: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $76 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $43, $30, $01 ; id 3: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $76 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $48, $48, $02 ; id 4: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $B4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $49, $48, $02 ; id 5: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $B4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $70, $70, $03 ; id 6: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $B4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $7A, $70, $03 ; id 7: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $B4 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $A0, $A0, $04 ; id 8: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $10 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $A8, $A8, $05 ; id 9: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $AA, $A8, $05 ; id 10: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $B0, $B0, $06 ; id 11: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $01 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $B8, $B8, $07 ; id 12: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $44 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $C8, $C8, $08 ; id 13: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $01 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $D1, $D1, $09 ; id 14: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $DA, $DA, $0A ; id 15: map to match, new hMapId, key number + 1 that uses wKeyWorldGoal instead
    db $44, $00 ; destination: X / Y nibbles (wWarpDestX / wWarpDestY), screen byte
    db $FF ; end

MapExitWarpTable_CheckKeyWorldActive::
Jump_012_5181:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    jr z, .read_key_world_goal_pos
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .read_key_world_goal_pos
    and a, $7F
    ld c, a
    ld a, [wKeyWorldSlot]
    cp a, c
    jr nz, .read_key_world_goal_pos
    ld de, wKeyWorldGoal
    call MapLinkWarp_Case01_WriteWarpDestXAndWarpDestYEtc
    ret

.read_key_world_goal_pos:
    ld a, [wKeyWorldGoalPos]
    ld [wWarpDestX], a
    ld a, [wKeyWorldGoalPos2]
    ld [wWarpDestY], a
    ld de, wKeyWorldGoalScreen
    call MapLinkWarp_Case01_StartPaletteFade
    ret

; only called from MapLinkWarp_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. MapLinkWarp_WriteScriptStartRequestAndMapIdEtc)
; reads: hPlayerStateFlags
; writes: wWarpDestX, wWarpDestY, hMapScreenX, hMapScreenY, wFieldTransitionStep, wFieldTransitionKind, wModeState, hPlayerStateFlags
; points at: wFieldInitStage
MapLinkWarp_Case01_WriteWarpDestXAndWarpDestYEtc::
Func_012_51B1:: ; address name
    ld a, [de]
    and a, $F0
    ld [wWarpDestX], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wWarpDestY], a
    inc de

; only called from MapLinkWarp_Case01 (E-0047)
; 1 call site from 1 routine (e.g. MapLinkWarp_WriteScriptStartRequestAndMapIdEtc)
; reads: hPlayerStateFlags
; writes: hMapScreenX, hMapScreenY, wFieldTransitionStep, wFieldTransitionKind, wModeState, hPlayerStateFlags
; points at: wFieldInitStage
MapLinkWarp_Case01_StartPaletteFade::
Func_012_51C0:: ; address name
    ld a, [de]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [de]
    and a, $0F
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
    and a, $F7
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerStateFlags]
    or a, $20
    and a, $7F
    ldh [hPlayerStateFlags], a
    ret

; implements script command type 8A (SCRIPT_MAP_EXIT_WARP): a key-world/field talk event (group $07, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: fades, then sets the warp destination from the map exit records (E-0182), wMapType, the map size and the field transition); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand8A)
; reads: wScriptStep
MapExitWarp::
Func_012_51F4:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw MapLinkWarp_WritePlayerYAndPlayerFacingEtc
    dw MapExitWarp_ScriptStartFadeAndAdvanceStep

; entry 1 of the `rst $00` table in MapExitWarp
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wMapType, wKeyWorldFloor, wKeyWorldWidth, wKeyWorldHeight, hMapId, wLastWarpIndex
; writes: wScriptStartRequest, hPlayerStateFlags, wFieldTransitionKind, wFieldTransitionStep, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, ...
; points at: wKeyWorldFloorInfo
MapExitWarp_ScriptStartFadeAndAdvanceStep::
Jump_012_51FC:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerStateFlags]
    or a, $80
    and a, $DF
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
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo
    add_a_to_hl
    ld a, [hl]
    push af
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    pop af
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    xor a, a
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
    cp a, c
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
    ld a, [hl+]
    ldh [hMapId], a
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl+]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [hl]
    and a, $F0
    ld [wWarpDestX], a
    ld a, [hl]
    and a, $0F
    swap a
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ldh a, [hMapId]
    cp a, $52
    jr z, .check_player_state_flags
    cp a, $89
    jr z, .check_player_state_flags
    cp a, $BB
    jr z, .check_player_state_flags
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and a, $7F
    ldh [hPlayerStateFlags], a
    ret

; E-0182 (C1: MapExitWarp_Case01, for maps without bit 7 of wMapType, scans 7-byte records from $52AD for the one whose first byte equals hMapId (there is no terminator and no bounds check), skips three more bytes when wLastWarpIndex = 2, then loads hMapId, hMapScreenX/Y from the nibbles of the next byte and wWarpDestX/Y from the nibbles of the byte after (each nibble x16), clearing wWarpDestFacing; 87 records end at the routine at $550E, and every map id is unique).
; record: map id; exit A (map, screen XY nibbles, position XY nibbles); exit B (same, used when wLastWarpIndex = 2)
MapExitDestinationTable::
Data_012_52AD:: ; address name
    db $2B, $2A, $00, $12, $24, $11, $25 ; id 0
    db $35, $30, $03, $44, $00, $00, $00 ; id 1
    db $38, $30, $53, $44, $00, $00, $00 ; id 2
    db $39, $30, $53, $44, $00, $00, $00 ; id 3
    db $3A, $30, $53, $44, $00, $00, $00 ; id 4
    db $3B, $30, $53, $44, $00, $00, $00 ; id 5
    db $3E, $30, $62, $44, $00, $00, $00 ; id 6
    db $3F, $30, $62, $44, $00, $00, $00 ; id 7
    db $40, $30, $62, $44, $00, $00, $00 ; id 8
    db $53, $52, $20, $41, $52, $00, $41 ; id 9
    db $54, $52, $20, $41, $52, $00, $41 ; id 10
    db $55, $52, $20, $41, $52, $00, $41 ; id 11
    db $56, $52, $20, $41, $52, $00, $41 ; id 12
    db $57, $52, $20, $41, $52, $00, $41 ; id 13
    db $5D, $48, $5A, $44, $00, $00, $00 ; id 14
    db $62, $48, $A5, $44, $00, $00, $00 ; id 15
    db $63, $48, $87, $44, $00, $00, $00 ; id 16
    db $64, $48, $87, $44, $00, $00, $00 ; id 17
    db $65, $48, $87, $44, $00, $00, $00 ; id 18
    db $66, $48, $87, $44, $00, $00, $00 ; id 19
    db $67, $48, $87, $44, $00, $00, $00 ; id 20
    db $73, $89, $01, $56, $00, $00, $00 ; id 21
    db $74, $89, $01, $56, $00, $00, $00 ; id 22
    db $75, $89, $01, $56, $00, $00, $00 ; id 23
    db $76, $89, $01, $56, $00, $00, $00 ; id 24
    db $81, $70, $5B, $44, $00, $00, $00 ; id 25
    db $82, $70, $5B, $44, $00, $00, $00 ; id 26
    db $83, $70, $5B, $44, $00, $00, $00 ; id 27
    db $84, $70, $5B, $44, $00, $00, $00 ; id 28
    db $85, $70, $1B, $44, $00, $00, $00 ; id 29
    db $86, $70, $1B, $44, $00, $00, $00 ; id 30
    db $87, $70, $1B, $44, $00, $00, $00 ; id 31
    db $88, $70, $1B, $44, $00, $00, $00 ; id 32
    db $8A, $70, $BA, $44, $00, $00, $00 ; id 33
    db $8B, $70, $BA, $44, $00, $00, $00 ; id 34
    db $8C, $70, $BA, $44, $00, $00, $00 ; id 35
    db $8D, $70, $BA, $44, $00, $00, $00 ; id 36
    db $8E, $70, $BA, $44, $00, $00, $00 ; id 37
    db $8F, $70, $BA, $44, $00, $00, $00 ; id 38
    db $90, $70, $BA, $44, $00, $00, $00 ; id 39
    db $91, $70, $BA, $44, $00, $00, $00 ; id 40
    db $93, $70, $41, $44, $00, $00, $00 ; id 41
    db $94, $70, $41, $44, $00, $00, $00 ; id 42
    db $95, $70, $41, $44, $00, $00, $00 ; id 43
    db $96, $70, $41, $44, $00, $00, $00 ; id 44
    db $97, $70, $41, $44, $00, $00, $00 ; id 45
    db $98, $70, $41, $44, $00, $00, $00 ; id 46
    db $99, $70, $41, $44, $00, $00, $00 ; id 47
    db $9A, $70, $41, $44, $00, $00, $00 ; id 48
    db $9B, $70, $41, $44, $00, $00, $00 ; id 49
    db $A1, $A0, $12, $44, $00, $00, $00 ; id 50
    db $A2, $A0, $12, $44, $00, $00, $00 ; id 51
    db $A3, $A0, $12, $44, $00, $00, $00 ; id 52
    db $AC, $A8, $51, $44, $00, $00, $00 ; id 53
    db $AD, $A8, $51, $44, $00, $00, $00 ; id 54
    db $AE, $A8, $51, $44, $00, $00, $00 ; id 55
    db $B3, $B1, $00, $13, $00, $00, $00 ; id 56
    db $B4, $B1, $00, $13, $00, $00, $00 ; id 57
    db $B5, $B1, $00, $13, $00, $00, $00 ; id 58
    db $B6, $B1, $00, $13, $00, $00, $00 ; id 59
    db $BB, $B8, $40, $44, $00, $00, $00 ; id 60
    db $BD, $BB, $00, $41, $00, $00, $00 ; id 61
    db $BE, $BB, $00, $41, $00, $00, $00 ; id 62
    db $BF, $BB, $00, $41, $00, $00, $00 ; id 63
    db $C0, $BB, $00, $41, $00, $00, $00 ; id 64
    db $C1, $BB, $00, $41, $00, $00, $00 ; id 65
    db $C2, $BB, $00, $41, $00, $00, $00 ; id 66
    db $C3, $BB, $00, $41, $00, $00, $00 ; id 67
    db $C4, $BB, $00, $41, $00, $00, $00 ; id 68
    db $C9, $C8, $00, $44, $00, $00, $00 ; id 69
    db $CA, $C8, $00, $44, $00, $00, $00 ; id 70
    db $CB, $C8, $00, $44, $00, $00, $00 ; id 71
    db $CC, $C8, $00, $44, $00, $00, $00 ; id 72
    db $CD, $C8, $00, $44, $00, $00, $00 ; id 73
    db $CE, $C8, $00, $44, $00, $00, $00 ; id 74
    db $D2, $D1, $01, $44, $00, $00, $00 ; id 75
    db $D3, $D1, $01, $44, $00, $00, $00 ; id 76
    db $D4, $D1, $01, $44, $00, $00, $00 ; id 77
    db $D5, $D1, $01, $44, $00, $00, $00 ; id 78
    db $D6, $D1, $01, $44, $00, $00, $00 ; id 79
    db $D7, $D1, $01, $44, $00, $00, $00 ; id 80
    db $DB, $DA, $10, $44, $00, $00, $00 ; id 81
    db $DC, $DA, $10, $44, $00, $00, $00 ; id 82
    db $DD, $DA, $10, $44, $00, $00, $00 ; id 83
    db $DE, $DA, $10, $44, $00, $00, $00 ; id 84
    db $DF, $DA, $10, $44, $00, $00, $00 ; id 85
    db $E0, $DA, $10, $44, $00, $00, $00 ; id 86

; implements script command type 9B (SCRIPT_HEAL_PARTY): a key-world/field talk event (group $1A, dispatched by RunMenuStateMenuState: heals the party (FullyHealParty) after a flag-chosen message); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand9B)
; reads: wScriptStep
HealPartyEvent::
Func_012_550E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw HealPartyEvent_TestFlagBit_Case00
    dw HealPartyEvent_TestFlagBit
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_FullyHealParty
    dw HealPartyEvent_MoveIncapacitatedPartyMembersBack
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_Case06

; entry 0 of the `rst $00` table in HealPartyEvent
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing
; points at: wScriptStep
HealPartyEvent_TestFlagBit_Case00::
Jump_012_5520:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, $0025
    call TestFlagBit
    ret nc
    ld a, $02
    ldh [hPlayerFacing], a
    ret

; implements script command type 89 (SCRIPT_RETURN_WARP): a key-world/field talk event (group $06, dispatched by RunFieldReturnPhase_OpenFieldMenuOnA: StartReturnWarpByFlag25); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand89)
; reads: wScriptStep
ReturnWarp::
Func_012_5534:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw MapLinkWarp_WritePlayerYAndPlayerFacingEtc
    dw ReturnWarp_StartReturnWarpByFlag25
    dw HealPartyEvent_TestFlagBit
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_FullyHealParty
    dw HealPartyEvent_MoveIncapacitatedPartyMembersBack
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_Case06

; entry 1 of the `rst $00` table in HealPartyEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots, wObject1
; points at: wScriptStep
HealPartyEvent_TestFlagBit::
Jump_012_5548:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld de, $002B
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $0D
    call StartMessageA
    jr .call_test_flag_bit

.call_start_message_a:
    ld a, $15
    call StartMessageA

.call_test_flag_bit:
    ld de, $0025
    call TestFlagBit
    jr c, .clear_object1
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

.clear_object1:
    xor a, a
    ld [wObject1 + OBJ_STATE], a
    ret

; entry 1 of the `rst $00` table in ReturnWarp
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldTransitionStep
ReturnWarp_StartReturnWarpByFlag25::
Jump_012_5573:: ; address name
    call StartReturnWarpByFlag25
    ld a, $80
    ld [wFieldTransitionStep], a
    ret

; entry 0 of the `rst $00` table in MapLinkWarp
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0, wFollowerRecords, hPlayerFacing, hPlayerStateFlags
; writes: hPlayerY, hPlayerFacing, wFollowerRecords, hPlayerStateFlags
; points at: wScriptStep
MapLinkWarp_WritePlayerYAndPlayerFacingEtc::
Jump_012_557C:: ; address name
    ldh a, [hPlayerY]
    cp a, $E0
    jr z, .check_script_param0
    sub a, $04
    ldh [hPlayerY], a
    ld a, [wScriptParam0]
    srl a
    and a, $03
    ldh [hPlayerFacing], a

.check_script_param0:
    ld a, [wScriptParam0]
    cp a, $08
    jr c, .check_script_param02
    ld a, [wFollowerRecords + $2]
    cp a, $E0
    jr z, .check_script_param02
    sub a, $04
    ld [wFollowerRecords + $2], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a

.check_script_param02:
    ld a, [wScriptParam0]
    cp a, $10
    jr c, .check_script_param03
    ld a, [wFollowerRecords + $7]
    cp a, $E0
    jr z, .check_script_param03
    sub a, $04
    ld [wFollowerRecords + $7], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords + $5], a

.check_script_param03:
    ld a, [wScriptParam0]
    cp a, $18
    jr c, .call_step_script_param0_counter_bank12
    ld a, [wFollowerRecords + $C]
    cp a, $E0
    jr z, .call_step_script_param0_counter_bank12
    sub a, $04
    ld [wFollowerRecords + $C], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords + $A], a

.call_step_script_param0_counter_bank12:
    ld b, $5A
    call StepScriptParam0Counter_Bank12
    ret nc
    ldh a, [hPlayerStateFlags]
    and a, $B7
    ldh [hPlayerStateFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 88 (SCRIPT_RETURN_MESSAGE): a key-world/field talk event (group $05, dispatched by RunFieldReturnPhase_ResetLeadRecordFields55And5B and PartyDefeatedReturn: a message chosen by a story flag); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand88)
; reads: wScriptStep
ReturnMessage::
Func_012_55E8:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ReturnMessage_TestFlagBit
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw ScriptStepFlashScreenNegative
    dw HealPartyEvent_FullyHealParty
    dw HealPartyEvent_MoveIncapacitatedPartyMembersBack
    dw HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_Case06

; with bit 7 of wCC44 saves the wCD07 record; sets the position ($50, $30), wC8C6 = 3 (story flag $25) or 4, wC957 = 1 and starts the fade (E-0126)
; 2 call sites from 2 routines (e.g. ReturnWarp_StartReturnWarpByFlag25, PartyDefeatedReturn_StartReturnWarpByFlag25)
; reads: wMapType
; writes: wWarpDestX, wWarpDestY, wWarpDestFacing, wFieldTransitionKind, wReturnWarpFlag
StartReturnWarpByFlag25::
Func_012_55F8:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr z, .set_warp_dest_x_to_50
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot

.set_warp_dest_x_to_50:
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    ld de, $0025
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

; entry 0 of the `rst $00` table in ReturnMessage
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots, wObject1
; points at: wScriptStep
ReturnMessage_TestFlagBit::
Jump_012_5633:: ; address name
    ld hl, wScriptStep
    inc [hl]
    farcall ReturnMessage_Case00_WriteGoldHiAndGoldMidEtc
    ld de, $0025
    call TestFlagBit
    jr c, .clear_object1
    ld a, $0C
    call StartMessageA
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

.clear_object1:
    xor a, a
    ld [wObject1 + OBJ_STATE], a
    ld de, $002B
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $13
    call StartMessageA
    ret

.call_start_message_a:
    ld a, $14
    call StartMessageA
    ret

; entry 2 of the `rst $00` table in HealPartyEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_5668:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.skip:
    ld hl, wScriptStep
    inc [hl]
    ld a, $7A
    call QueueSoundEffect
    ret

; entry 4 of the `rst $00` table in HealPartyEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wScriptParam0, wScriptStep
; writes: rRAMG, wScriptParam0, wScriptStep, hFieldDrawFlags
; points at: wPartyList, wScriptStep
HealPartyEvent_FullyHealParty::
Jump_012_5689:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl+]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, .set_script_param0_to_01
    dec b
    jr nz, .loop
    xor a, a
    ld [wScriptParam0], a
    jr .call_fully_heal_party

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a

.call_fully_heal_party:
    xor a, a
    ld [rRAMG], a
    call FullyHealParty
    ld a, [wScriptParam0]
    or a, a
    jr nz, .set_field_draw_flags_to_0E
    ld de, $002B
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $11
    call StartMessageA
    jr .clear_script_param0

.call_start_message_a:
    ld a, $16
    call StartMessageA

.clear_script_param0:
    xor a, a
    ld [wScriptParam0], a
    ld a, [wScriptStep]
    inc a
    inc a
    ld [wScriptStep], a
    ret

.set_field_draw_flags_to_0E:
    ld a, $0E
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in HealPartyEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, hFieldDrawFlags
; points at: wScriptStep
HealPartyEvent_MoveIncapacitatedPartyMembersBack::
Jump_012_56E8:: ; address name
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $002B
    call TestFlagBit
    jr c, .call_start_message_a
    ld a, $11
    call StartMessageA
    ret

.call_start_message_a:
    ld a, $16
    call StartMessageA
    ret

; entry 6 of the `rst $00` table in HealPartyEvent
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
HealPartyEvent_RunMessageBoxCarryWhenIdle_Bank12_Case06::
Jump_012_571D:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 87 (SCRIPT_PARTY_DEFEATED_RETURN): a key-world/field talk event (group $04, dispatched from FieldModeStateDispatch_Case07: moves incapacitated members back (MoveIncapacitatedPartyMembersBack) and starts the return warp (StartReturnWarpByFlag25)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand87)
; reads: wScriptStep
PartyDefeatedReturn::
Func_012_5728:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw PartyDefeatedReturn_WriteScriptParam0AndScriptParam1
    dw PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc
    dw PartyDefeatedReturn_RunMessageBoxCarryWhenIdle_Bank12
    dw PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_Case03
    dw PartyDefeatedReturn_WriteScriptParam0AndFieldDrawFlagsEtc
    dw PartyDefeatedReturn_QueueMusic
    dw PartyDefeatedReturn_StepScriptParam0Counter_Bank12
    dw PartyDefeatedReturn_StartReturnWarpByFlag25
    dw PartyDefeatedReturn_DispatchTalkEvent

; entry 8 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; writes: wTalkEventGroup, wTalkEventIndex
PartyDefeatedReturn_DispatchTalkEvent::
Jump_012_573E:: ; address name
    ld a, $05
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ret

; entry 7 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldReturnPhase, wFieldTransitionStep
PartyDefeatedReturn_StartReturnWarpByFlag25::
Jump_012_574E:: ; address name
    call StartReturnWarpByFlag25
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $80
    ld [wFieldTransitionStep], a
    ret

; entry 6 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
PartyDefeatedReturn_StepScriptParam0Counter_Bank12::
Jump_012_575B:: ; address name
    ld b, $B4
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: rRAMG, wScriptStartRequest
; points at: wPartyList, wScriptStep
PartyDefeatedReturn_QueueMusic::
Jump_012_5766:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl+]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    bit 7, a
    jr z, .skip
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ld a, $42
    call QueueMusic
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    xor a, a
    ld [rRAMG], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wPartyList
; writes: wScriptParam0, wMessageIndex, wMessageGroup, wMessageState, wScriptParam1, rRAMG
; points at: wScriptStep, wNameGlyphBuf
PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_Case03::
Jump_012_5797:: ; address name
    ld hl, wScriptStep
    dec [hl]
    ld de, wShadowOAM + $B
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a, a
    jr nz, PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex
    ld de, vTiles0 + $B
    jr PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex

; entry 2 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wScriptStep
; points at: wScriptStep
PartyDefeatedReturn_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_57AD:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    or a, a
    jr nz, .done
    xor a, a
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptStep], a
    ret

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wPartyList
; writes: wScriptParam0, wMessageIndex, wMessageGroup, wMessageState, wScriptParam1, rRAMG
; points at: wScriptStep, wNameGlyphBuf
PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc::
Jump_012_57C7:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld de, $400A
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a, a
    jr nz, PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex
    ld de, $000A

PartyDefeatedReturn_WriteScriptParam0AndMessageIndexEtc_SetMessageIndex::
Jump_012_57DB:: ; address name
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ld a, [wScriptParam1]
    sra a
    jr nc, .skip
    ld a, [wScriptParam1]
    and a, $FE
    ld [wScriptParam1], a
    ld a, [wPartyList]
    jr .skip2

.skip:
    sra a
    jr nc, .check_script_param1
    ld a, [wScriptParam1]
    and a, $FC
    ld [wScriptParam1], a
    ld a, [wPartyList + $1]
    jr .skip2

.check_script_param1:
    ld a, [wScriptParam1]
    and a, $F7
    ld [wScriptParam1], a
    ld a, [wPartyList + $2]

.skip2:
    ld c, $01
    push af
    ld a, $0A
    ld [rRAMG], a
    pop af
    call CopyRecordNameToNameGlyphBuf
    xor a, a
    ld [rRAMG], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld bc, $000B
    call CopyBytes
    ret

; entry 0 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wStatusFieldStep
; writes: wScriptParam0, wScriptParam1
; points at: wScriptStep
PartyDefeatedReturn_WriteScriptParam0AndScriptParam1::
Jump_012_5834:: ; address name
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

; implements script command type 85 (SCRIPT_KEY_WORLD_BOSS_BATTLE): talk category 9, group 0: a random message ($00D0 + 0..F), a battle against wKeyWorldEncounter (one or three monsters), then after the 'Warubou' message sets wKeyWorldFlags bit 7, marks every floor entry of wKeyWorldEncounterTable done and sets bit 6 of the current key entry byte 7; a C1 name from its calls and writes
; 1 call site from 1 routine (e.g. ScriptCommand85)
; reads: wScriptStep
KeyWorldBossBattle::
Func_012_5854:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw KeyWorldBossBattle_StartMessageHL_B0F_Bank12
    dw KeyWorldBossBattle_RunMessageBoxFar_Bank12
    dw KeyWorldBossBattle_CopyBytes
    dw KeyWorldBossBattle_ToScriptStepFlashScreenNegative
    dw KeyWorldBossBattle_ShowWarubouWaheyNoGood
    dw KeyWorldBossBattle_WriteScriptParam0
    dw KeyWorldBossBattle_WriteSpriteSlotCountAndScriptParam0
    dw KeyWorldBossBattle_WriteKeyWorldFlagsAndScriptStartRequest

; entry 7 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFlags, wCurrentKeyIndex
; writes: wKeyWorldFlags, wScriptStartRequest
KeyWorldBossBattle_WriteKeyWorldFlagsAndScriptStartRequest::
Jump_012_5868:: ; address name
    ld a, [wKeyWorldFlags]
    or a, $80
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
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    set 6, a
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlotCount, wScriptParam0
; points at: wScriptStep
KeyWorldBossBattle_WriteSpriteSlotCountAndScriptParam0::
Jump_012_589B:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, .cp_3C
    bit 3, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.cp_3C:
    cp a, $3C
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
    xor a, a
    ld [wSpriteSlotCount], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
KeyWorldBossBattle_WriteScriptParam0::
Jump_012_58D6:: ; address name
    xor a, a
    call KeyWorldBossBattle_Case05_ReadMessageState
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
KeyWorldBossBattle_ShowWarubouWaheyNoGood::
Jump_012_58E4:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0129 ; 'Warubou Wa-hey! No good, no good!'
    call StartMessageHL_B0F_Bank12
    ret

; entry 3 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
KeyWorldBossBattle_ToScriptStepFlashScreenNegative::
Jump_012_58EF:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 2 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
KeyWorldBossBattle_CopyBytes::
Jump_012_58F6:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldEncounter
; writes: wBattleIntroKind, wEncounterMonsters, wWildLevel, wEncounterKind, wBattleTransitionSubStep, wWildBand, wWildByteE5
; points at: wScriptStep
KeyWorldBossBattle_RunMessageBoxFar_Bank12::
Jump_012_590D:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ld [wBattleIntroKind], a
    ld a, [wKeyWorldEncounter + $3]
    ld c, a
    ld a, [wKeyWorldEncounter + $4]
    or a, c
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
    xor a, a
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
    ld [wWildByteE5], a
    ld a, $02
    ld [wEncounterKind], a

.set_battle_transition_sub_step_to_01:
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ret

; entry 0 of the `rst $00` table in KeyWorldBossBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomHi
; points at: wScriptStep
KeyWorldBossBattle_StartMessageHL_B0F_Bank12::
Jump_012_5994:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    ld hl, $00D0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE): talk category 9, group 3: a random message ($00E0 + 0..F), a battle against the wKeyWorldEncounterTable entry of wKeyWorldFloor, then after the 'Warubou' message marks that floor entry done (byte 3 = 1); a C1 name from its calls and writes
; 1 call site from 1 routine (e.g. ScriptCommand9E)
; reads: wScriptStep
KeyWorldFloorBattle::
Func_012_59AC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw KeyWorldFloorBattle_StartMessageHL_B0F_Bank12
    dw KeyWorldFloorBattle_RunMessageBoxFar_Bank12
    dw KeyWorldFloorBattle_ShowWarubouWaheyThatWas
    dw KeyWorldBossBattle_WriteScriptParam0
    dw KeyWorldBossBattle_WriteSpriteSlotCountAndScriptParam0
    dw KeyWorldFloorBattle_WriteScriptStartRequest

; entry 5 of the `rst $00` table in KeyWorldFloorBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: wScriptStartRequest
KeyWorldFloorBattle_WriteScriptStartRequest::
Jump_012_59BC:: ; address name
    ld a, [wKeyWorldFloor]
    and a, $7F
    add a, a
    add a, a
    ld hl, wKeyWorldEncounterTable + $3
    add_a_to_hl
    ld [hl], $01
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in KeyWorldFloorBattle
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
KeyWorldFloorBattle_ShowWarubouWaheyThatWas::
Jump_012_59D3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $012A ; 'Warubou Wa-hey That was no good.'
    call StartMessageHL_B0F_Bank12
    ret

; entry 1 of the `rst $00` table in KeyWorldFloorBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: wBattleIntroKind, wEncounterMonsters, wWildLevel, wEncounterKind, wBattleTransitionSubStep
; points at: wScriptStep, wKeyWorldEncounterTable
KeyWorldFloorBattle_RunMessageBoxFar_Bank12::
Jump_012_59DE:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ld [wBattleIntroKind], a
    ld a, [wKeyWorldFloor]
    and a, $7F
    add a, a
    add a, a
    ld hl, wKeyWorldEncounterTable
    add_a_to_hl
    ld a, [hl+]
    ld [wEncounterMonsters], a
    ld a, [hl+]
    ld [wEncounterMonsters + $1], a
    ld a, [hl]
    ld [wWildLevel], a
    xor a, a
    ld [wEncounterKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    ret

; entry 0 of the `rst $00` table in KeyWorldFloorBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomHi
; points at: wScriptStep
KeyWorldFloorBattle_StartMessageHL_B0F_Bank12::
Jump_012_5A17:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    ld hl, $00E0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 84 (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched from FieldModeStateDispatch: random gold (AddGoldCapped) or item (AppendItemWC928ToInventory)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand84)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
RandomGoldOrItem::
Func_012_5A2F:: ; address name
    ld a, [wScriptStep]
    cp a, $07
    jr z, .read_script_step
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.read_script_step:
    ld a, [wScriptStep]
    rst $00
    dw SetupScriptSpriteFromMapSpriteKind
    dw PlaySound83AndAdvanceScriptStep
    dw ScriptStepAnimateSpriteBySteps
    dw RandomGoldOrItem_WriteSVBKAndFieldDrawFlags
    dw RandomGoldOrItem_ToRandomGoldOrItem_Case04_NextRandomSeed
    dw RandomGoldOrItem_AddStepDeltaToPointedByte
    dw RandomGoldOrItem_Number24ToPackedBCD
    dw RandomGoldOrItem_RunMessageBoxCarryWhenIdle_Bank12
    dw RandomGoldOrItem_AddGoldCapped

; entry 8 of the `rst $00` table in RandomGoldOrItem
; no direct call (reached through a table, a jump or a vector)
; reads: wTriggerMarkerFlags, wScriptParam1
; writes: hTemp0, hTemp1, wTriggerMarkerFlags, wScriptStartRequest, wStepPtrLo
RandomGoldOrItem_AddGoldCapped::
Jump_012_5A53:: ; address name
    ld a, [wTriggerMarkerFlags]
    and a, $7F
    jr z, .read_script_param1
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    call AddGoldCapped
    jr .clear_trigger_marker_flags

.read_script_param1:
    ld a, [wScriptParam1]
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory

.clear_trigger_marker_flags:
    xor a, a
    ld [wTriggerMarkerFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in RandomGoldOrItem
; no direct call (reached through a table, a jump or a vector)
; writes: wTriggerKind
; points at: wScriptStep
RandomGoldOrItem_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_5A7A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $FF
    ld [wTriggerKind], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RandomGoldOrItem
; no direct call (reached through a table, a jump or a vector)
; reads: wTriggerMarkerFlags, wScriptParam1
; writes: wDigits, wMessageGroup
; points at: wScriptStep, wTextNumber
RandomGoldOrItem_Number24ToPackedBCD::
Jump_012_5A89:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTriggerMarkerFlags]
    and a, $7F
    jr z, .read_script_param1
    ld [wDigits], a
    xor a, a
    ld [wDigits + $1], a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ld a, $05
    call StartMessageA
    xor a, a
    ld [wMessageGroup], a
    ret

.read_script_param1:
    ld a, [wScriptParam1]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, $06
    call StartMessageA
    xor a, a
    ld [wMessageGroup], a
    ret

; entry 5 of the `rst $00` table in RandomGoldOrItem
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wTriggerIndex, wScriptStep
RandomGoldOrItem_AddStepDeltaToPointedByte::
Jump_012_5AC4:: ; address name
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
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RandomGoldOrItem
; no direct call (reached through a table, a jump or a vector)
RandomGoldOrItem_ToRandomGoldOrItem_Case04_NextRandomSeed::
Jump_012_5AE9:: ; address name
    farcall RandomGoldOrItem_Case04_NextRandomSeed
    ret

; entry 3 of the `rst $00` table in RandomGoldOrItem
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wMessageIndex, wIsCGB, wMapType, hMapId
; writes: rSVBK, hFieldDrawFlags
; points at: wScriptStep
RandomGoldOrItem_WriteSVBKAndFieldDrawFlags::
Jump_012_5AF0:: ; address name
    ld a, [wMessageGroup]
    swap a
    and a, $0F
    add a, a
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
    and a, $0F
    sla a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
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
    or a, a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld c, $01
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip2
    ldh a, [hMapId]
    cp a, $63
    jr z, .skip
    cp a, $64
    jr z, .skip
    cp a, $65
    jr z, .skip
    cp a, $66
    jr z, .skip
    cp a, $53
    jr z, .skip
    cp a, $54
    jr z, .skip
    cp a, $55
    jr z, .skip
    cp a, $56
    jr nz, .cp_57

.skip:
    ld c, $03
    jr .skip2

.cp_57:
    cp a, $57
    jr nz, .skip2
    ld c, $03

.skip2:
    ld a, $02
    ldh [rSVBK], a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    xor a, a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wScriptParam1 = wScriptParam0 / 6 (capped at 4), draws the script sprite, and advances wScriptStep after $1E frames (E-0125)
; 1 call site from 1 routine (e.g. SceneStrongestMaster_ToScriptStepAnimateSpriteBySteps)
; reads: wScriptParam0
; writes: wScriptParam1
; points at: wScriptStep
ScriptStepAnimateSpriteBySteps::
Func_012_5B9A:: ; address name
    ld a, [wScriptParam0]
    cp a, $06
    jr nc, .cp_0C
    xor a, a
    ld [wScriptParam1], a
    jr .call_draw_script_meta_sprite_at_scroll_offset

.cp_0C:
    cp a, $0C
    jr nc, .cp_12
    ld a, $01
    ld [wScriptParam1], a
    jr .call_draw_script_meta_sprite_at_scroll_offset

.cp_12:
    cp a, $12
    jr nc, .cp_18
    ld a, $02
    ld [wScriptParam1], a

.cp_18:
    cp a, $18
    jr nc, .set_script_param1_to_04
    ld a, $03
    ld [wScriptParam1], a
    jr .call_draw_script_meta_sprite_at_scroll_offset

.set_script_param1_to_04:
    ld a, $04
    ld [wScriptParam1], a

.call_draw_script_meta_sprite_at_scroll_offset:
    call DrawScriptMetaSpriteAtScrollOffset
    ld b, $1E
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; draws metasprite set $23 + ($10 >> 4) - 1, sub-index wScriptParam1, at the scroll position plus (wMessageIndex + 8, wMessageGroup + $10), used here as coordinates (E-0121)
; 1 call site from 1 routine (e.g. ScriptStepAnimateSpriteBySteps)
; reads: wMapSpriteKind, wScriptParam1, hScrollX, hScrollXHi, wMessageIndex, hScrollY, hScrollYHi, wMessageGroup
; writes: hSpriteSetIndex, hSpriteSubIndex, hSpriteAttrXor, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
DrawScriptMetaSpriteAtScrollOffset::
Func_012_5BD9:: ; address name
    ld a, [wMapSpriteKind]
    ld a, $10
    swap a
    and a, $0F
    dec a
    add a, $23
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
    add a, $08
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
    add a, $10
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; QueueSoundEffect $83, then wScriptStep += 1 (E-0114)
; 1 call site from 1 routine (e.g. SceneStrongestMaster_ToPlaySound83AndAdvanceScriptStep)
; points at: wScriptStep
PlaySound83AndAdvanceScriptStep::
Func_012_5C27:: ; address name
    ld a, $83
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; A = wC195 >> 4, DE = KeyWorldBossBattle_Case00, B = $7E, then continues at SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM (E-0126)
; 1 call site from 1 routine (e.g. SceneStrongestMaster_SetupScriptSpriteFromMapSpriteKind)
; reads: wMapSpriteKind, wIsCGB, hPlayerX, hPlayerY, hPlayerFacing
; writes: wOBJPaletteUploadRequest, wMessageIndex, wMessageGroup, wFollowerRecords, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
SetupScriptSpriteFromMapSpriteKind::
Func_012_5C31:: ; address name
    ld a, [wMapSpriteKind]
    swap a
    and a, $0F
    ld de, KeyWorldBossBattle_StartMessageHL_B0F_Bank12
    ld b, $7E
    jr SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM

; decompresses sprite graphics from bank $7E to vTiles0 + $700 (with a CGB palette), places it 16 pixels in front of the player and advances wScriptStep (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wMapSpriteKind, hPlayerX, hPlayerY, hPlayerFacing
; writes: wOBJPaletteUploadRequest, wMessageIndex, wMessageGroup, wFollowerRecords, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
SpawnScriptSpriteInFrontOfPlayer:: ; heuristic: follows a terminator; C0
Func_012_5C3F:: ; address name
    dec a
    jr nz, .skip
    ld de, $5A15
    ld b, $7E
    jr SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM

.skip:
    ld de, Tiles0Plus700Gfx_7E_5A9A
    ld b, $7E

SpawnScriptSpriteInFrontOfPlayer_CallDecompressToVRAM::
Jump_012_5C4E:: ; address name
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, .read_player_x
    ld a, [wMapSpriteKind]
    ld a, $10
    swap a
    and a, $0F
    add a, $22
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.read_player_x:
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, .set_message_index
    dec a
    jr z, .set_message_index2
    dec a
    jr z, .set_message_index3
    ld a, d
    sub a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .read_player_facing

.set_message_index:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add a, $10
    ld [wMessageGroup], a
    jr .read_player_facing

.set_message_index2:
    ld a, d
    add a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .read_player_facing

.set_message_index3:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub a, $10
    ld [wMessageGroup], a

.read_player_facing:
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 83 (SCRIPT_FIELD_SCENE_01): a key-world/field talk event (group $01, dispatched from FieldModeStateDispatch: draws script meta-sprite 21, moves objects, changes the music); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand83)
; reads: wScriptParam1
FieldScene01::
Func_012_5CE5:: ; address name
    ld a, [wScriptParam1]
    dec a
    jr nz, .skip
    call FieldScene01_WriteJoypadHeldAndJoypadPressed
    ret

.skip:
    dec a
    jr nz, .call_field_scene01_write_joypad_held_and
    call FieldScene01_WriteJoypadHeldAndJoypadPressed_Sub03
    ret

.call_field_scene01_write_joypad_held_and:
    call FieldScene01_WriteJoypadHeldAndJoypadPressed_Sub01
    ret

; only called from FieldScene01 (E-0047)
; 1 call site from 1 routine (e.g. FieldScene01)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
FieldScene01_WriteJoypadHeldAndJoypadPressed_Sub01::
Func_012_5CFA:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    rst $00
    dw FieldScene01_Sub01_WritePlayerStateFlagsAndFieldDrawFlagsEtc
    dw FieldScene01_Sub01_AddStepDeltaToPointedByte

; entry 0 of the `rst $00` table in Func_012_5CFA
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, hPlayerY
; writes: hPlayerStateFlags, hFieldDrawFlags, hPlayerSpriteMode, hPlayerY, wScriptParam0
; points at: wScriptStep
FieldScene01_Sub01_WritePlayerStateFlagsAndFieldDrawFlagsEtc::
Jump_012_5D09:: ; address name
    ldh a, [hPlayerStateFlags]
    and a, $F7
    ldh [hPlayerStateFlags], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    xor a, a
    ldh [hPlayerSpriteMode], a
    ldh a, [hPlayerY]
    sub a, $08
    ldh [hPlayerY], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_012_5CFA
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerX, hPlayerY, hPlayerFacing, hPlayerStateFlags
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wFollowerRecords, hFieldDrawFlags, wScriptStartRequest, hPlayerStateFlags, hPlayerStepDXLo, ...
; points at: hPlayerY, hPlayerX
FieldScene01_Sub01_AddStepDeltaToPointedByte::
Jump_012_5D25:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, .check_script_param02
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerStateFlags]
    or a, $01
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
    and a, $01
    ret z
    ldh a, [hPlayerFacing]
    or a, a
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

; only called from FieldScene01 (E-0047)
; 1 call site from 1 routine (e.g. FieldScene01)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
FieldScene01_WriteJoypadHeldAndJoypadPressed::
Func_012_5DB6:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    rst $00
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw FieldScene01_Sub02_DecompressToVRAM
    dw FieldScene01_Sub02_StepScriptParam0Counter_Bank12
    dw FieldScene01_Sub02_AddStepDeltaToPointedByte
    dw FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset
    dw FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset_Case07
    dw FieldScene01_Sub02_AddStepDeltaToPointedByte_Case08

; entry 8 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, hPlayerStateFlags, hPlayerFacing
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, hPlayerY, hPlayerStateFlags, hPlayerSpriteMode, wScriptStartRequest
; points at: hPlayerY, hPlayerX
FieldScene01_Sub02_AddStepDeltaToPointedByte_Case08::
Jump_012_5DD3:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, .call_draw_script_meta_sprite21_at_scroll
    ldh a, [hPlayerY]
    add a, $08
    and a, $F0
    ldh [hPlayerY], a
    ldh a, [hPlayerStateFlags]
    or a, $08
    and a, $5F
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerSpriteMode], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_draw_script_meta_sprite21_at_scroll:
    call DrawScriptMetaSprite21AtScrollOffset
    ld a, [wScriptParam0]
    and a, $01
    ret z
    ldh a, [hPlayerFacing]
    or a, a
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

; entry 7 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wMapType, hMapId
; points at: wScriptStep
FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset_Case07::
Jump_012_5E3C:: ; address name
    call DrawScriptMetaSprite21AtScrollOffset
    ld hl, wScriptStep
    inc [hl]
    ld a, [wMapType]
    bit 7, a
    jr z, .read_map_id
    cp a, $80
    jr z, .call_queue_music
    ret

.read_map_id:
    ldh a, [hMapId]
    ld c, a
    ld hl, FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset_Case07_Data

.loop:
    ld a, [hl+]
    cp a, $FF
    ret z
    cp a, c
    jr nz, .loop

.call_queue_music:
    ld a, $2B
    call QueueMusic
    ret

; address loaded by FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset_Case07
FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset_Case07_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_5E62:: ; address name
    db $30, $FF

; entry 3 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, hPlayerFacing
; writes: wOBJPaletteUploadRequest, wMessageIndex, wMessageGroup, hFieldDrawFlags, wFollowerRecords, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
FieldScene01_Sub02_DecompressToVRAM::
Jump_012_5E64:: ; address name
    ld de, Tiles0Plus700Gfx_7E_58FF
    ld b, $7E
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $0108
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, .set_message_index
    dec a
    jr z, .set_message_index2
    dec a
    jr z, .set_message_index3
    ld a, d
    sub a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add a, $10
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index2:
    ld a, d
    add a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index3:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub a, $10
    ld [wMessageGroup], a

.set_field_draw_flags_to_0E:
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from FieldScene01 (E-0047)
; 1 call site from 1 routine (e.g. FieldScene01)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
FieldScene01_WriteJoypadHeldAndJoypadPressed_Sub03::
Func_012_5EE7:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    rst $00
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw FieldScene01_Sub03_DecompressToVRAM
    dw FieldScene01_Sub02_StepScriptParam0Counter_Bank12
    dw FieldScene01_Sub02_AddStepDeltaToPointedByte
    dw FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset
    dw FieldScene01_Sub03_AddStepDeltaToPointedByte
    dw FieldScene01_Sub03_WaitFieldActionRequest
    dw FieldScene01_Sub03_AddStepDeltaToPointedByte_Case09

; entry 4 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
FieldScene01_Sub02_StepScriptParam0Counter_Bank12::
Jump_012_5F06:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing, wFollowerRecords
; writes: wStepPtrLo, wStepPtrHi, hPlayerFacing, wScriptParam0
; points at: hPlayerY, wScriptStep
FieldScene01_Sub02_AddStepDeltaToPointedByte::
Jump_012_5F11:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, .check_script_param0
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, [wFollowerRecords]
    ldh [hPlayerFacing], a
    ld a, $7A
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0, hPlayerX, hPlayerY, hPlayerFacing
; writes: wTriggerEnable, hPlayerStateFlags, wStepPtrLo, wStepPtrHi, wScriptParam0, wFollowerRecords, hFieldDrawFlags, wScriptStartRequest, ...
; points at: hPlayerY
FieldScene01_Sub03_AddStepDeltaToPointedByte_Case09::
Jump_012_5F4D:: ; address name
    ld a, $01
    ld [wTriggerEnable], a
    ldh a, [hPlayerStateFlags]
    or a, $A0
    ldh [hPlayerStateFlags], a
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, .return
    ldh a, [hPlayerStateFlags]
    and a, $5F
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerStateFlags]
    or a, $01
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
    xor a, a
    ld [wTriggerEnable], a
    ret

.return:
    ret

; entry 8 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest, hPlayerStateFlags, hPlayerX, hPlayerY, hPlayerFacing, wJoypadHeld, wSpriteSlotCount, wSpriteSlots, ...
; writes: wJoypadHeld, hPlayerSpriteMode, hPlayerY, wScriptParam0, hPlayerFacing
; points at: wTilesUnderPoint, wScriptStep
FieldScene01_Sub03_WaitFieldActionRequest::
Jump_012_5FC9:: ; address name
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
    or a, a
    jr z, .read_joypad_held
    dec a
    jr z, .read_joypad_held2
    dec a
    jr z, .read_joypad_held3
    ld a, [wJoypadHeld]
    set 5, a
    ld [wJoypadHeld], a
    ld a, b
    or a, a
    ret z
    sub a, $10
    ld b, a
    jr .check_sprite_slot_count

.read_joypad_held:
    ld a, [wJoypadHeld]
    set 7, a
    ld [wJoypadHeld], a
    ld a, c
    cp a, $80
    ret z
    add a, $10
    ld c, a
    jr .check_sprite_slot_count

.read_joypad_held2:
    ld a, [wJoypadHeld]
    set 4, a
    ld [wJoypadHeld], a
    ld a, b
    cp a, $90
    ret z
    add a, $10
    ld b, a
    jr .check_sprite_slot_count

.read_joypad_held3:
    ld a, [wJoypadHeld]
    set 6, a
    ld [wJoypadHeld], a
    ld a, c
    or a, a
    ret z
    sub a, $10
    ld c, a

.check_sprite_slot_count:
    ld a, [wSpriteSlotCount]
    or a, a
    jr z, .call_read_tile_buffer2x2_at_pixel_bank12_6854
    ld a, [wSpriteSlots + $B]
    cp a, b
    jr nz, .call_read_tile_buffer2x2_at_pixel_bank12_6854
    ld a, [wSpriteSlots + $C]
    cp a, c
    jr z, .check_player_facing

.call_read_tile_buffer2x2_at_pixel_bank12_6854:
    call ReadTileBuffer2x2AtPixel_Bank12_6854
    ld b, $04
    ld hl, wTilesUnderPoint
    ld b, $02
    ld a, [wMaxBlockingTile]
    ld e, a
    ld a, [wMapTallTileMin]
    ld d, a

.loop:
    ld a, [hl+]
    cp a, d
    jr z, .next
    jr c, .next
    cp a, e
    jr z, .check_player_facing
    jr c, .check_player_facing
    xor a, a
    ldh [hPlayerSpriteMode], a
    ldh a, [hPlayerY]
    sub a, $08
    ldh [hPlayerY], a
    xor a, a
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
    and a, $03
    ldh [hPlayerFacing], a
    xor a, a
    ld [wJoypadHeld], a
    ret

; entry 7 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, hPlayerFacing
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, hPlayerY, hPlayerSpriteMode
; points at: hPlayerY, wScriptStep, hPlayerX
FieldScene01_Sub03_AddStepDeltaToPointedByte::
Jump_012_6077:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .check_script_param0
    ld hl, hPlayerY
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, .call_draw_script_meta_sprite21_at_scroll
    ldh a, [hPlayerY]
    add a, $08
    and a, $F0
    ldh [hPlayerY], a
    ld a, $02
    ldh [hPlayerSpriteMode], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_draw_script_meta_sprite21_at_scroll:
    call DrawScriptMetaSprite21AtScrollOffset
    ld a, [wScriptParam0]
    and a, $01
    ret z
    ldh a, [hPlayerFacing]
    or a, a
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

; entry 6 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFieldDrawFlags
; points at: wScriptStep
FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset::
Jump_012_60DB:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, .cp_3C
    bit 1, a
    jr z, .call_draw_script_meta_sprite21_at_scroll
    jr .check_script_param0

.cp_3C:
    cp a, $3C
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
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ret

; draws metasprite set $21 (or $22 unless wC195 & $0F = 1), flipped by the player facing, at the scroll position plus (wMessageIndex + 8, wMessageGroup + $10) (E-0125)
; 4 call sites from 4 routines (e.g. FieldScene01_Sub03_AddStepDeltaToPointedByte, FieldScene01_Sub02_AddStepDeltaToPointedByte_Case08, FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset_Case07, FieldScene01_Sub02_DrawScriptMetaSprite21AtScrollOffset)
; reads: wMapSpriteKind, hPlayerFacing, hScrollX, hScrollXHi, wMessageIndex, hScrollY, hScrollYHi, wMessageGroup
; writes: hSpriteSetIndex, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
; points at: hSpriteSetIndex
DrawScriptMetaSprite21AtScrollOffset::
Func_012_6114:: ; address name
    ld a, $21
    ldh [hSpriteSetIndex], a
    ld a, [wMapSpriteKind]
    and a, $0F
    dec a
    jr z, .set_sprite_attr_xor_to_07
    ld hl, hSpriteSetIndex
    inc [hl]

.set_sprite_attr_xor_to_07:
    ld a, $07
    ldh [hSpriteAttrXor], a
    ldh a, [hPlayerFacing]
    cp a, $01
    jr nz, .clear_sprite_sub_index
    ld a, $27
    ldh [hSpriteAttrXor], a

.clear_sprite_sub_index:
    xor a, a
    ldh [hSpriteSubIndex], a
    ld a, $70
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld l, a
    ldh a, [hScrollXHi]
    ld h, a
    ld a, [wMessageIndex]
    add a, $08
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
    add a, $10
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; entry 3 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, hPlayerFacing
; writes: wOBJPaletteUploadRequest, wMessageIndex, wMessageGroup, hFieldDrawFlags, wFollowerRecords, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
FieldScene01_Sub03_DecompressToVRAM::
Jump_012_616C:: ; address name
    ld de, Tiles0Plus700Gfx_7E_594A
    ld b, $7E
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $0108
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, .set_message_index
    dec a
    jr z, .set_message_index2
    dec a
    jr z, .set_message_index3
    ld a, d
    sub a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add a, $10
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index2:
    ld a, d
    add a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr .set_field_draw_flags_to_0E

.set_message_index3:
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub a, $10
    ld [wMessageGroup], a

.set_field_draw_flags_to_0E:
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; script step: first frame sets the follower targets from the leader; later frames step the followers until the wC921 counter reaches $11, then advances wScriptStep (E-0122)
; 7 call sites from 7 routines (e.g. SceneWallExit_ToScriptStepMoveFollowersToLeader, SceneKamehaFlees_ScriptStepMoveFollowersToLeader, SceneKamehaStole_ToScriptStepMoveFollowersToLeader, GatherFollowers_ScriptStepMoveFollowersToLeader, ...)
; reads: wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptStepMoveFollowersToLeader::
Func_012_61EF:: ; address name
    ld a, [wScriptParam0]
    or a, a
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

; implements script command type 86 (SCRIPT_KEY_WORLD_DOOR_ITEM): a key-world/field talk event (group $0B: random item or key entry (GenerateNewKeyEntry) and door tiles for the key-world floor (DrawDoorTilesForKeyWorldFloor)); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand86)
; reads: wScriptStep
KeyWorldDoorItem::
Func_012_6211:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw KeyWorldDoorItem_StartMessageA
    dw KeyWorldDoorItem_RunMessageBoxCarryWhenIdle_Bank12
    dw KeyWorldDoorItem_WriteScriptStartRequestAndStepPtrLo
    dw KeyWorldDoorItem_RunMessageBoxCarryWhenIdle_Bank12
    dw KeyWorldDoorItem_DrawDoorTilesForKeyWorldFloor

; entry 4 of the `rst $00` table in KeyWorldDoorItem
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldFloor
; writes: wScriptStartRequest
KeyWorldDoorItem_DrawDoorTilesForKeyWorldFloor::
Jump_012_621F:: ; address name
    farcall KeyWorldDoorItem_Case04_RandomModulo29_BankF0
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $3
    add_a_to_hl
    ld a, $FF
    ld [hl], a
    farcall DrawDoorTilesForKeyWorldFloor
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in KeyWorldDoorItem
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wKeyWorldFloor
; writes: wScriptStartRequest, wStepPtrLo
KeyWorldDoorItem_WriteScriptStartRequestAndStepPtrLo::
Jump_012_6247:: ; address name
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or a, l
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
    ld a, $FF
    ld [hl], a
    pop hl
    ld a, l
    bit 7, a
    jr nz, .call_draw_door_tiles_for_key_world_floor
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    jr .call_draw_door_tiles_for_key_world_floor

.call_draw_door_tiles_for_key_world_floor:
    farcall DrawDoorTilesForKeyWorldFloor
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in KeyWorldDoorItem
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
KeyWorldDoorItem_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_628B:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in KeyWorldDoorItem
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wInventory, wGM2Mode, hTemp0
; writes: wScriptParam0, wScriptParam1, wScriptStep
; points at: wScriptStep
KeyWorldDoorItem_StartMessageA::
Jump_012_6295:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or a, l
    jr nz, .skip
    ld a, $00
    call StartMessageA
    ret

.skip:
    ld a, l
    cp a, $80
    jr z, .loop
    cp a, $81
    jr z, .check_gm2_mode
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .call_start_message_a
    cp a, $00
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
    or a, a
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

.check_gm2_mode:
    ld a, [wGM2Mode]
    cp a, $01
    jr z, .loop
    ld a, $19
    call StartMessageA
    ld a, $03
    ld [wScriptStep], a
    ret

; implements script command type 81 (SCRIPT_AREA_ITEM): a key-world/field talk event (group $0E, dispatched from FieldModeStateDispatch: gives an item (AppendItemWC928ToInventory) after CheckTwoWCDB0EntriesForKeyWorldArea, redrawing the screen); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand81)
; reads: wScriptStep
AreaItemEvent::
Func_012_630E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw AreaItemEvent_StartMessageA
    dw AreaItemEvent_RunMessageBoxCarryWhenIdle_Bank12
    dw AreaItemEvent_WriteScriptStartRequestAndStepPtrLo

; entry 2 of the `rst $00` table in AreaItemEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptStartRequest, wStepPtrLo
AreaItemEvent_WriteScriptStartRequestAndStepPtrLo::
Jump_012_6318:: ; address name
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or a, l
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
    farcall AppendItemWC928ToInventory
    farcall CheckTwoWCDB0EntriesForKeyWorldArea
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in AreaItemEvent
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
AreaItemEvent_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_6351:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in AreaItemEvent
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wInventory
; writes: wScriptParam0, wScriptParam1
; points at: wScriptStep
AreaItemEvent_StartMessageA::
Jump_012_635B:: ; address name
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
    or a, a
    jr z, .next
    ld a, $00
    call StartMessageA
    ret

.next:
    dec hl
    dec hl
    ld a, [hl]
    and a, $7F
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .call_start_message_a
    cp a, $00
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

; implements script command type 80 (SCRIPT_STEP_TRIGGER_REWARD): a key-world/field talk event (group $0F, dispatched by CheckStepTriggerAndDispatchTalk: gives gold (a byte * 10, AddGoldCapped), an item (AppendItemWC928ToInventory) or starts a battle with intro 5); named from its trigger and calls
; 1 call site from 1 routine (e.g. ScriptCommand80)
; reads: wScriptStep
StepTriggerReward::
Func_012_63A1:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw StepTriggerReward_CopyItemNameToDE
    dw StepTriggerReward_RunMessageBoxCarryWhenIdle_Bank12
    dw StepTriggerReward_AddGoldCapped
    dw StepTriggerReward_AppendItemWC928ToInventory
    dw StepTriggerReward_SetModeState3AndSaveScreen
    dw StepTriggerReward_SetScriptStartRequestTo80

; entry 5 of the `rst $00` table in StepTriggerReward
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
StepTriggerReward_SetScriptStartRequestTo80::
Jump_012_63B1:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in StepTriggerReward
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleIntroKind, wBattleTransitionSubStep, wScriptStartRequest
StepTriggerReward_SetModeState3AndSaveScreen::
Jump_012_63B7:: ; address name
    ld a, $05
    ld [wBattleIntroKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    farcall SetModeState3AndSaveScreen
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in StepTriggerReward
; no direct call (reached through a table, a jump or a vector)
; writes: wStepPtrLo, wTriggerKind, wScriptStartRequest
StepTriggerReward_AppendItemWC928ToInventory::
Jump_012_63D4:: ; address name
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
    inc hl
    ld a, [hl]
    ld [wStepPtrLo], a
    dec hl
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $FF
    ld [wTriggerKind], a
    farcall AppendItemWC928ToInventory
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in StepTriggerReward
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, hTemp1, wTriggerKind, wScriptStartRequest
StepTriggerReward_AddGoldCapped::
Jump_012_63F2:: ; address name
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
    or a, $80
    ld [hl], a
    ld a, $FF
    ld [wTriggerKind], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in StepTriggerReward
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptStep
StepTriggerReward_RunMessageBoxCarryWhenIdle_Bank12::
Jump_012_641F:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in StepTriggerReward
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory
; writes: wScriptParam0, wDigits
; points at: wScriptStep, wTextNumber
StepTriggerReward_CopyItemNameToDE::
Jump_012_642B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    call StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex
    ld a, [hl]
    or a, a
    jr nz, .skip
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .next
    cp a, $00
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
    xor a, a
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
    cp a, $FF
    jr z, .next3
    cp a, $00
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

; only called from routines of StepTriggerReward (E-0098)
; 4 call sites from 4 routines (e.g. StepTriggerReward_SetModeState3AndSaveScreen, StepTriggerReward_AppendItemWC928ToInventory, StepTriggerReward_AddGoldCapped, StepTriggerReward_CopyItemNameToDE)
; reads: wScreenTriggerCount, wTriggerIndex
; points at: wMapObjects, wScreenTriggers
StepTriggerReward_ReadScreenTriggerCountAndTriggerIndex::
Func_012_64D5:: ; address name
    ld a, [wScreenTriggerCount]
    or a, a
    jr nz, .read_trigger_index
    ld a, [wTriggerIndex]
    add a, a
    add a, a
    add a, a
    ld hl, wMapObjects
    add_a_to_hl
    ret

.read_trigger_index:
    ld a, [wTriggerIndex]
    add a, a
    add a, a
    ld hl, wScreenTriggers
    add_a_to_hl
    ret

; with SRAM enabled sets every party record's HP to max HP, MP to max MP and field $55 to 0 (E-0125)
; 11 call sites from 10 routines (e.g. ArenaRounds_FullyHealParty, HealPartyEvent_FullyHealParty, RunFieldReturnPhase_ResetLeadRecordFields55And5B, GameMode5_Init_SendSGBPaletteSetPacket_Case06, ...)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList
FullyHealParty::
Func_012_64F8:: ; address name
    ld a, $0A
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
    ld [hl+], a
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
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl], a
    pop af
    ld c, MON_STATUS
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ret

; for 30 frames alternates every 4 frames between the normal palettes and their inverse (DMG palettes $D2/$E2 and $2D/$1D), then advances wScriptStep (E-0127)
; 7 call sites from 7 routines (e.g. SceneThreeItems_ToScriptStepFlashScreenNegative, SceneShield_ToScriptStepFlashScreenNegative, SceneExplosion_ScriptStepFlashScreenNegative, PlayerSpriteFlash_ToScriptStepFlashScreenNegative, ...)
; reads: wScriptParam0, wIsCGB
; writes: wBGPaletteUploadRequest, wScriptParam0
; points at: wDMGPaletteBGP, wBGPaletteCopy, wBGPaletteBuffer, wScriptStep
ScriptStepFlashScreenNegative::
Func_012_653F:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    and a, $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .check_script_param0
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .check_script_param0
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 10 call sites from 10 routines (e.g. ArenaRounds_StepScriptParam0Counter_Bank12, BreedChildScene_StepScriptParam0Counter_Bank12, LinkMessageEvent_StepScriptParam0Counter_Bank12_Case05, LinkMessageEvent_StepScriptParam0Counter_Bank12_Case03, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepScriptParam0Counter_Bank12::
Func_012_65A4:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    jr z, .clear_script_param0
    sub a, a
    ret

.clear_script_param0:
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; entry 4 of the `rst $00` table in PartyDefeatedReturn
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFieldDrawFlags, wOBJPaletteUploadRequest
; points at: wScriptStep
PartyDefeatedReturn_WriteScriptParam0AndFieldDrawFlagsEtc::
Jump_012_65B6:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, .call_move_incapacitated_party_members_back
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ret

.call_move_incapacitated_party_members_back:
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. WarpWithFollowers_SetBit1AtHL_Bank12, FollowersStep14_SetBit1AtHL_Bank12AndStep)
SetBit1AtHL_Bank12::
Func_012_65EB:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. FollowersStep14_UpdateFollowersOnStep_Bank12_Case02)
ClearBit1AtHL_Bank12::
Func_012_65F0:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 14 call sites from 11 routines (e.g. ObjectPath1C_SetBit2AtHL_B12_Case05, ObjectPath1C_SetBit2AtHL_B12, ObjectPath1B_SetBit2AtHL_B12_Case05, ObjectPath1B_SetBit2AtHL_B12, ...)
SetBit2AtHL_B12::
Func_012_65F5:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 7 call sites from 4 routines (e.g. ObjectPath1C_ClearBit2AtHL_Bank12, ArenaRounds_ClearBit2AtHL_Bank12, ArenaRounds_SetBit2AtHL_B12, LinkMessageEvent_ClearBit2AtHL_Bank12)
ClearBit2AtHL_Bank12::
Func_012_65FA:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same 17 bytes appear in 3 banks)
; 21 call sites from 13 routines (e.g. ObjectPath1C_UpdateFollowersOnStep_Bank12_Case02, ObjectPath1C_UpdateFollowersOnStep_Bank12, ObjectPath1C_SetBit2AtHL_B12, ObjectPath1B_UpdateFollowersOnStep_Bank12_Case06, ...)
UpdateFollowersOnStep_Bank12::
Func_012_65FF:: ; address name
    and a, $0F
    jr nz, .call_step_followers_toward_targets
    farcall SetFollowerTargetsFromLeader

.call_step_followers_toward_targets:
    farcall StepFollowersTowardTargets
    ret

; the bank-$12 message runner: the same four states as RunMessageBox, with A on the stack as the freeze flag instead of wC928 (state 0 also reads hMapId; not compared in full) (E-0079)
; 1 call site from 1 routine (e.g. RunMessageBoxCarryWhenIdle_Bank12)
; reads: wMessageState
RunMessageBox_Bank12::
Func_012_6610:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, .skip
    pop af
    ret

.skip:
    rst $00
    dw RunMessageBox_Bank12_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBox_Bank12_BeginStringDisplay_Bank09
    dw RunMessageBox_Bank12_WriteMessageStateAndTextWindowStateEtc
    dw RunMessageBox_Bank12_WriteMessageState

; entry 0 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, hMapId, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_Bank12_SetBit1OfPlayerAndObjectFlags::
Jump_012_6623:: ; address name
    pop af
    or a, a
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
    cp a, $14
    jr z, .check_player_y
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.check_player_y:
    ldh a, [hPlayerY]
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
RunMessageBox_Bank12_BeginStringDisplay_Bank09::
Jump_012_666D:: ; address name
    pop af
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMessageGroup, hPlayerY
; writes: wMessageState, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_Bank12_WriteMessageStateAndTextWindowStateEtc::
Jump_012_668A:: ; address name
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr z, .call_queue_sound_effect
    ld a, $FF
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
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wMessageState
RunMessageBox_Bank12_WriteMessageState::
Jump_012_66C1:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    or a, a
    jr nz, .set_message_state_to_FF
    farcall ClearBit1OfPlayerAndObjectFlags

.set_message_state_to_FF:
    ld a, $FF
    ld [wMessageState], a
    ret

; unless wMessageState is $FF (idle), runs the message box step for wMessageState (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunMessageBoxThenContinue_684A)
; reads: wMessageState
RunMessageBoxStateIfActive_Bank12::
Func_012_66DA:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, .skip
    pop af
    ret

.skip:
    rst $00
    dw RunMessageBoxStateIfActive_Bank12_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBoxStateIfActive_Bank12_BeginStringDisplay_Bank09
    dw RunMessageBoxStateIfActive_Bank12_WriteMessageStateAndTextWindowStateEtc
    dw RunMessageBox_Bank12_WriteMessageState

; entry 0 of the `rst $00` table in RunMessageBoxStateIfActive_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBoxStateIfActive_Bank12_SetBit1OfPlayerAndObjectFlags::
Jump_012_66ED:: ; address name
    pop af
    or a, a
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
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBoxStateIfActive_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
RunMessageBoxStateIfActive_Bank12_BeginStringDisplay_Bank09::
Jump_012_6731:: ; address name
    pop af
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    and a, $3F
    ld [wStringIndex], a
    ld a, $09
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBoxStateIfActive_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMessageIndex, hPlayerY
; writes: wMessageState, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBoxStateIfActive_Bank12_WriteMessageStateAndTextWindowStateEtc::
Jump_012_6750:: ; address name
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageIndex]
    bit 6, a
    jr z, .call_queue_sound_effect
    ld a, $FF
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
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; only called from KeyWorldBossBattle_Case05_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. KeyWorldBossBattle_Case05_ReadMessageState)
; reads: wMessageState
KeyWorldBossBattle_Case05_Sub01_ReadMessageState::
Func_012_6787:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, .skip
    pop af
    ret

.skip:
    rst $00
    dw KeyWorldBossBattle_Case05_Sub01_Sub01_SetBit1OfPlayerAndObjectFlags
    dw KeyWorldBossBattle_Case05_Sub01_Sub01_BeginStringDisplay_Bank8A
    dw KeyWorldBossBattle_Case05_Sub01_Sub01_WriteTextWindowStateAndTextWindowStepEtc
    dw RunMessageBox_Bank12_WriteMessageState

; entry 0 of the `rst $00` table in Func_012_6787
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
KeyWorldBossBattle_Case05_Sub01_Sub01_SetBit1OfPlayerAndObjectFlags::
Jump_012_679A:: ; address name
    pop af
    or a, a
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
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_012_6787
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
KeyWorldBossBattle_Case05_Sub01_Sub01_BeginStringDisplay_Bank8A::
Jump_012_67D2:: ; address name
    pop af
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_012_6787
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
KeyWorldBossBattle_Case05_Sub01_Sub01_WriteTextWindowStateAndTextWindowStepEtc::
Jump_012_67EE:: ; address name
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
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; the same 13 bytes as StartMessageHL_B0F (0F:7F68)
; 4 call sites from 4 routines (e.g. KeyWorldFloorBattle_ShowWarubouWaheyThatWas, KeyWorldFloorBattle_StartMessageHL_B0F_Bank12, KeyWorldBossBattle_ShowWarubouWaheyNoGood, KeyWorldBossBattle_StartMessageHL_B0F_Bank12)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B0F_Bank12::
Func_012_6813:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; wMessageIndex = A, wMessageState = 0: the next RunMessageBox call opens the window and shows that string of the group already in wMessageGroup (E-0063, E-0079)
; 35 call sites from 15 routines (e.g. PlayerSpriteMessage_ToStartMessageAAndStep, CountdownMessage_ToStartMessageAAndStep, EncounterCounterMessage_ToStartMessageAAndStep, StartArenaRankMessage, ...)
; writes: wMessageIndex, wMessageState
StartMessageA::
Func_012_6820:: ; address name
    ld [wMessageIndex], a
    xor a, a
    ld [wMessageState], a
    ret

; wC928 = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. KeyWorldFloorBattle_RunMessageBoxFar_Bank12, KeyWorldBossBattle_RunMessageBoxFar_Bank12)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxFar_Bank12::
Func_012_6828:: ; address name
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, .return_carry
    sub a, a
    ret

.return_carry:
    scf
    ret

; RunMessageBox_Bank12 (A = the freeze flag), then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079)
; 11 call sites from 11 routines (e.g. PlayerSpriteMessage_RunMessageBoxCarryWhenIdle_Bank12, CountdownMessage_RunMessageBoxCarryWhenIdle_Bank12, BreedChildScene_RunMessageBoxCarryWhenIdle_Bank12, LinkMessageEvent_RunMessageBoxCarryWhenIdle_Bank12, ...)
; reads: wMessageState
RunMessageBoxCarryWhenIdle_Bank12::
Func_012_683C:: ; address name
    call RunMessageBox_Bank12

RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState::
Jump_012_683F:: ; address name
    ld a, [wMessageState]
    cp a, $FF
    jr z, .return_carry
    sub a, a
    ret

.return_carry:
    scf
    ret

; runs RunMessageBoxStateIfActive_Bank12, then continues at RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState (E-0126)
; 4 call sites from 4 routines (e.g. ArenaRounds_RunMessageBoxThenContinue_684A_Case01, ArenaRounds_RunMessageBoxThenContinue_684A, ArenaGridBattle_RunMessageBoxThenContinue_684A_Case02, ArenaGridBattle_RunMessageBoxThenContinue_684A)
; reads: wMessageState
RunMessageBoxThenContinue_684A::
Func_012_684A:: ; address name
    call RunMessageBoxStateIfActive_Bank12
    jr RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState

; only called from KeyWorldBossBattle_Case05 (E-0047)
; 1 call site from 1 routine (e.g. KeyWorldBossBattle_WriteScriptParam0)
; reads: wMessageState
KeyWorldBossBattle_Case05_ReadMessageState::
Func_012_684F:: ; address name
    call KeyWorldBossBattle_Case05_Sub01_ReadMessageState
    jr RunMessageBoxCarryWhenIdle_Bank12_CheckMessageState

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries); copies the 2 x 2 entries there to wC910, wC911 (top row) and wC912, wC913 (bottom row); HL ends on the bottom-right entry (E-0064) (the same 63 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. FieldScene01_Sub03_WaitFieldActionRequest)
; writes: wTilesUnderPoint
ReadTileBuffer2x2AtPixel_Bank12_6854::
Func_012_6854:: ; address name
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
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wTilesUnderPoint], a
    ld a, [hl-]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ret

; runs Func_012_722A and Func_012_6EB7; shared by the field mode states (E-0122)
; 6 call sites from 6 routines (e.g. FieldModeStateDispatch_UpdatePlayerMovement, FieldModeStateDispatch_RunEventScriptFrame, FieldModeStateDispatch_DrawFieldSprites, FieldModeStateDispatch_RunBattleTransitionStep, ...)
RunFunc722AAnd6EB7::
Func_012_6893:: ; address name
    call DrawTriggerMarkerSprite
    call RunFunc722AAnd6EB7_WaitFieldActionRequest
    ret

; writes a generated key (kind $FE) into a free key slot, rerolling while it duplicates an existing key, and saves the random seed in wC787; hFFC6 = 1, or 0 when the list is full (E-0129)
; 14 call sites from 11 routines (e.g. ArenaMenu_RandomModulo52, ArenaMenu_SetFlagBit, KeyWorldDoorItem_StartMessageA, GreatLogTalkEvents_GenerateNewKeyEntry, ...)
; reads: hTemp0, hTemp2, hTemp1, hTempA, wKeyRetryCount, wKeyRandomLo, wKeyRandomHi, wGameFlags836
; writes: wKeyRetryCount, hTemp0, hTemp1, hTempA, wGameFlags836
; points at: wKeySeeds
GenerateNewKeyEntry::
Func_012_689A:: ; address name
    xor a, a
    ld [wKeyRetryCount], a

.call_find_free_key_slot_to_temp0:
    call FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_FE
    xor a, a
    ldh [hTemp0], a
    ret

.set_temp1_to_FE:
    push af
    ld a, $FE
    ldh [hTemp1], a
    call WriteKeyEntryTemp0
    pop af
    or a, a
    jr z, .set_temp0_to_01
    ldh [hTempA], a
    ld b, a
    ld hl, wKeyList + $3

.loop:
    push hl
    ld a, [hl-]
    bit 7, a
    jr nz, .restore
    ld a, [hl-]
    ld c, a
    ldh a, [hTemp2]
    cp a, c
    jr nz, .restore
    ld a, [hl]
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr nz, .check_key_retry_count
    pop hl

.loop2:
    ldh a, [hTempA]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    jr .call_find_free_key_slot_to_temp0

.check_key_retry_count:
    pop hl
    ld a, [wKeyRetryCount]
    inc a
    ld [wKeyRetryCount], a
    cp a, $14
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
    add a, a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [wKeyRandomLo]
    ld [hl+], a
    ld a, [wKeyRandomHi]
    ld [hl], a
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ret

; hFFC6 = the index of the first free wKeyList entry, or $80 when none is free or 20 entries lack bit 7 of byte 3 (E-0125)
; 3 call sites from 3 routines (e.g. GenerateNewKeyEntry, ScriptStepCheckKeyListFull_6A80, ScriptStepCheckKeyListFull_6B45)
; writes: hTemp0
; points at: wKeyList
FindFreeKeySlotToTemp0::
Func_012_691F:: ; address name
    ld b, $00
    ld d, $00
    ld hl, wKeyList

.loop:
    push hl
    ld a, [hl]
    cp a, $FF
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
    cp a, $20
    jr nz, .loop
    ld a, $80
    ldh [hTemp0], a
    ret

.set_temp0:
    pop hl
    ld a, b
    ldh [hTemp0], a
    ld a, d
    cp a, $14
    ret nz
    ld a, $80
    ldh [hTemp0], a
    ret

; writes key entry hFFC6: byte 0 = hFFC7 and byte 3 = $80; for kind $FE generates the remaining bytes (Func_061_40B4, Func_060_6916) from hFFC7-hFFC9 (E-0125)
; 15 call sites from 11 routines (e.g. GenerateNewKeyEntry, MapEventCountKeysAndStartScript5039, ArenaMenu_SetFlagBit, SceneThreeItems_RunMessageBoxFar_Bank0F, ...)
; reads: hTemp0, hTemp1, wPartyStrength, hTemp2, hTemp3
; writes: hTemp0
WriteKeyEntryTemp0::
Func_012_6955:: ; address name
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    push hl
    ldh a, [hTemp1]
    ld [hl], a
    cp a, $FE
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
    ld [hl+], a
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl], a
    ret

; counts the 4-byte wKeyList entries before the first $FF: hFFC6 = the count, or $80 when all 32 are in use (E-0074)
; 14 call sites from 10 routines (e.g. MapEventCountKeysAndStartScript5039, ArenaMenu_SetFlagBit, SceneThreeItems_RunMessageBoxFar_Bank0F, TalkMsg0512_KamehaYo0Thanks, ...)
; writes: hTemp0
; points at: wKeyList
CountKeysOrFull::
Func_012_6990:: ; address name
    ld b, $00
    ld hl, wKeyList

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .set_temp0
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp a, $20
    jr nz, .loop
    ld a, $80
    ldh [hTemp0], a
    ret

.set_temp0:
    ld a, b
    ldh [hTemp0], a
    ret

; removes key entry hFFC6: clears the matching wC88E link, marks its SRAM-bank-2 slot free and shifts the later entries down (E-0130)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_ChooseListEntry_TestListEntryBit7_Case10, LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Case21)
; reads: hTemp0, wCurrentKeyIndex
; writes: rRAMB, rRAMG
; points at: wKeySeeds, wCurrentKeyIndex
DeleteKeyEntryTemp0::
Func_012_69B0:: ; address name
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $7F
    cp a, $06
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
    cp a, $FE
    jr z, .check_temp0
    bit 7, a
    jr z, .check_temp0
    and a, $1F
    push af
    ld a, $02
    ld [rRAMB], a
    pop af
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, $0A
    ld [rRAMG], a
    ld a, $FF
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a

.check_temp0:
    ldh a, [hTemp0]
    cp a, $1F
    jr nz, .skip
    ld hl, wKeyList + $7C
    jr .skip2

.skip:
    push af
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    pop af
    ld c, a
    ld a, $1F
    sub a, c
    ld b, a

.loop:
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop

.skip2:
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ldh a, [hTemp0]
    cp a, $1F
    jr z, .read_current_key_index
    ld c, a
    add a, a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, $1F
    sub a, c
    ld b, a

.loop2:
    ld e, l
    ld d, h
    inc de
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    dec b
    jr nz, .loop2

.read_current_key_index:
    ld a, [wCurrentKeyIndex]
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    ret nc
    ld hl, wCurrentKeyIndex
    dec [hl]
    ret

; on map $7F or $92 at screen (0, 0), or with wCC44 = $82, runs field command $12 and places objects at wCBD3/4 and wCBCF (E-0127)
; 2 call sites from 2 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_FindTriggerEntryForCurrentScreen)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY
; writes: hTemp0, wObject5
PlaceSpecialMapObjectsOnEntry::
Func_012_6A6A:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, .check_map_type
    ldh a, [hMapId]
    cp a, $7F
    jr nz, .check_map_id
    ldh a, [hMapScreenX]
    or a, a
    jr nz, .check_map_id
    ldh a, [hMapScreenY]
    or a, a
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
    cp a, $92
    ret nz
    ldh a, [hMapScreenX]
    or a, a
    ret nz
    ldh a, [hMapScreenY]
    or a, a
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
    cp a, $82
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

; decompresses Data_07E_5595 to vTiles0 + $300 (or + $700 when hFFC6 is set), wC949 = $30, and on CGB copies an 8-byte palette from bank $7E (E-0125)
; 2 call sites from 2 routines (e.g. RunSceneScriptSubStep_LoadSpriteGraphics7E5595ToTiles0, SceneWarubouFood2_AddStepDeltaToPointedByte)
; reads: hTemp0, wIsCGB
; writes: wSpriteFloatY, wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
LoadSpriteGraphics7E5595ToTiles0::
Func_012_6AD9:: ; address name
    ldh a, [hTemp0]
    or a, a
    jr nz, .skip
    ld hl, vTiles0 + $300
    jr .call_decompress_to_vram

.skip:
    ld hl, vTiles0 + $700

.call_decompress_to_vram:
    ld de, Tiles0Plus700Gfx_7E_5595
    ld b, $7E
    call DecompressToVRAM
    ld a, $30
    ld [wSpriteFloatY], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ldh a, [hTemp0]
    or a, a
    jr nz, .skip2
    ld a, $18
    jr .skip3

.skip2:
    ld a, $38

.skip3:
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld a, $D8
    ld de, OBJPaletteBufferData_7E_4BBD
    add a, e
    ld e, a
    jr nc, .call_copy_from_bank
    inc d

.call_copy_from_bank:
    ld b, $7E
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; wC949 -= 2, and when the result is $C0 or more it becomes $30 (E-0117)
; 11 call sites from 11 routines (e.g. RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0D, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0C, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0B, ...)
; reads: wSpriteFloatY
; writes: wSpriteFloatY
CycleSpriteFloatYDown::
Func_012_6B22:: ; address name
    ld a, [wSpriteFloatY]
    dec a
    dec a
    ld [wSpriteFloatY], a
    cp a, $C0
    ret c
    ld a, $30
    ld [wSpriteFloatY], a
    ret

; draws metasprite set $1B with a frame from Data_012_6B7A chosen by the frame counter / 30, at ($48, wC949 + $10) (E-0125)
; 11 call sites from 11 routines (e.g. RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0D, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0C, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0B, ...)
; reads: hTemp0, wFrameCounterLo, wFrameCounterHi, wSpriteFloatY
; writes: hSpriteTileOffset, hSpriteAttrXor, hSpriteSubIndex, hSpriteSetIndex, hSpriteOriginX, hSpriteOriginY
DrawAnimatedMetaSprite1B::
Func_012_6B33:: ; address name
    ldh a, [hTemp0]
    or a, a
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
    ld a, $1E
    call DivideHLByA
    ld hl, DrawAnimatedMetaSprite1B_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ld a, $1B
    ldh [hSpriteSetIndex], a
    ld a, $40
    add a, $08
    ldh [hSpriteOriginX], a
    ld a, [wSpriteFloatY]
    add a, $10
    ldh [hSpriteOriginY], a
    farcall DrawMetaSprite
    ret

; address loaded by DrawAnimatedMetaSprite1B
DrawAnimatedMetaSprite1B_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_6B7A:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

; runs the field command for hFFC6 (jump table of 22; called from 49 routines) (E-0124)
; 53 call sites from 51 routines (e.g. PlaceSpecialMapObjectsOnEntry, InitFieldScreen, RunFieldReturnPhase_Case01_WaitMapType, StartScript4F7CAndSetFlag06, ...)
; reads: hTemp0
RunFieldCommandTemp0::
Func_012_6B98:: ; address name
    ldh a, [hTemp0]
    rst $00
    dw RunFieldCommandTemp0_WriteObject5
    dw RunFieldCommandTemp0_WriteObject5_Case01
    dw RunFieldCommandTemp0_WriteObject5_Case02
    dw RunFieldCommandTemp0_WriteObject5_Case03
    dw RunFieldCommandTemp0_WriteObject5_Case04
    dw RunFieldCommandTemp0_WriteObject5_Case05
    dw RunFieldCommandTemp0_WriteObject5_Case06
    dw RunFieldCommandTemp0_WriteObject5_Case07
    dw RunFieldCommandTemp0_WriteObject5_Case08
    dw RunFieldCommandTemp0_WriteObject5_Case09
    dw RunFieldCommandTemp0_WriteObject5_Case0A
    dw RunFieldCommandTemp0_WriteObject5_Case0B
    dw RunFieldCommandTemp0_WriteObject5_Case0C
    dw RunFieldCommandTemp0_WriteObject5_Case0D
    dw RunFieldCommandTemp0_WriteObject5_Case0D
    dw RunFieldCommandTemp0_WriteObject5_Case0F
    dw RunFieldCommandTemp0_WriteObject5_Case10
    dw RunFieldCommandTemp0_WriteObject5_Case11
    dw RunFieldCommandTemp0_WriteObject5_Case12
    dw RunFieldCommandTemp0_WriteObject5_Case13
    dw RunFieldCommandTemp0_WriteObject5_Case14
    dw RunFieldCommandTemp0_WriteObject5_Case14

; entry 20 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case14::
Jump_012_6BC7:: ; address name
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

; entry 19 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case13::
Jump_012_6BED:: ; address name
    call RunFieldCommandTemp0_DecompressToVRAM_Shared02
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    xor a, a
    ld [wObject5], a
    ret

; entry 18 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case12::
Jump_012_6C01:: ; address name
    call RunFieldCommandTemp0_DecompressToVRAM
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; entry 17 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case11::
Jump_012_6C20:: ; address name
    call RunFieldCommandTemp0_DecompressToVRAM
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; entry 16 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case10::
Jump_012_6C3F:: ; address name
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
    xor a, a
    ld [wObject5], a
    ret

; entry 15 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case0F::
Jump_012_6C59:: ; address name
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
    ld [hl], $E0
    xor a, a
    ld [wObject5], a
    ret

; entry 13 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case0D::
Jump_012_6C73:: ; address name
    call RunFieldCommandTemp0_DecompressToVRAM_Shared02
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
    ld a, $3C
    ld [hl], a
    ld a, $80
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; entry 12 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case0C::
Jump_012_6C9B:: ; address name
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
    xor a, a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; entry 11 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case0B::
Jump_012_6CC2:: ; address name
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
    xor a, a
    ld [wObject5], a
    ld hl, $0000
    ld a, l
    ld [wObject5 + $6], a
    ld a, h
    ld [wObject5 + $7], a
    ret

; entry 10 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case0A::
Jump_012_6CE9:: ; address name
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
    ld [hl], $E0
    xor a, a
    ld [wObject5], a
    ret

; entry 9 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case09::
Jump_012_6D03:: ; address name
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
    ld [hl], $E0
    ld a, $80
    ld [wObject5], a
    ret

; entry 8 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case08::
Jump_012_6D1E:: ; address name
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
    xor a, a
    ld [wObject5], a
    ret

; entry 7 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case07::
Jump_012_6D38:: ; address name
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
    ld [hl], $E0
    ld a, $80
    ld [wObject5], a
    ret

; entry 6 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case06::
Jump_012_6D53:: ; address name
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

; entry 5 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case05::
Jump_012_6D79:: ; address name
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

; entry 4 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case04::
Jump_012_6D94:: ; address name
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
    xor a, a
    ld [wObject5], a
    ret

; entry 3 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case03::
Jump_012_6DAE:: ; address name
    call RunFieldCommandTemp0_DecompressToVRAM
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wObject5], a
    ret

; entry 2 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case02::
Jump_012_6DC2:: ; address name
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
    xor a, a
    ld [wObject5], a
    ret

; entry 1 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5_Case01::
Jump_012_6DDC:: ; address name
    call RunFieldCommandTemp0_DecompressToVRAM
    push af
    ld hl, wObject5 + SCRIPTOBJ_TILE_OFFSET
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wObject5], a
    ret

; entry 0 of the `rst $00` table in RunFieldCommandTemp0
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
RunFieldCommandTemp0_WriteObject5::
Jump_012_6DF0:: ; address name
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

; only called from routines of RunFieldCommandTemp0 (E-0098)
; 18 call sites from 18 routines (e.g. RunFieldCommandTemp0_WriteObject5_Case14, RunFieldCommandTemp0_WriteObject5_Case12, RunFieldCommandTemp0_WriteObject5_Case11, RunFieldCommandTemp0_WriteObject5_Case10, ...)
; reads: hTemp0, wIsCGB
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
RunFieldCommandTemp0_DecompressToVRAM::
Func_012_6E0B:: ; address name
    ldh a, [hTemp0]
    and a, $7F
    add a, a
    add a, a
    ld hl, FieldCommandSpriteTable
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $7E
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    pop hl
    push hl
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $20
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.done:
    pop hl
    ld a, [hl]
    ret

; only called from routines of RunFieldCommandTemp0 (E-0098)
; 2 call sites from 2 routines (e.g. RunFieldCommandTemp0_WriteObject5_Case13, RunFieldCommandTemp0_WriteObject5_Case0D)
; reads: hTemp0, wIsCGB
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
RunFieldCommandTemp0_DecompressToVRAM_Shared02::
Func_012_6E61:: ; address name
    ldh a, [hTemp0]
    and a, $7F
    add a, a
    add a, a
    ld hl, FieldCommandSpriteTable
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $7E
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    pop hl
    push hl
    ld a, [wIsCGB]
    or a, a
    jr z, .done
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $18
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.done:
    pop hl
    ld a, [hl]
    ret

; only called from RunFunc722AAnd6EB7 (E-0047)
; 1 call site from 1 routine (e.g. RunFunc722AAnd6EB7)
; reads: wFieldActionRequest, hScrollX, hScrollXHi, hScrollY, hScrollYHi
; writes: hSpriteTileOffset, hSpriteSetIndex, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSubIndex
; points at: wObject5
RunFunc722AAnd6EB7_WaitFieldActionRequest::
Func_012_6EB7:: ; address name
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld de, wObject5
    ld a, [de]
    bit 6, a
    ret z
    jr DrawFieldSprites_SetSpriteTileOffset

; unless the map is loading or wCBCF bit 7 is clear: reads the sprite entries starting at wCBCF (tile offset, set index with bit 7 selecting a sub index, attribute, position bytes), sets the hSprite inputs and 16-bit positions from them plus the scroll, and draws each with DrawMetaSprite
; 9 call sites from 9 routines (e.g. FieldModeStateDispatch_UpdatePlayerMovement, FieldModeStateDispatch_RunEventScriptFrame, FieldModeStateDispatch_DrawFieldSprites, FieldModeStateDispatch_RunBattleTransitionStep, ...)
; reads: wFieldActionRequest, hScrollX, hScrollXHi, hScrollY, hScrollYHi
; writes: hSpriteTileOffset, hSpriteSetIndex, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSubIndex
; points at: wObject5
DrawFieldSprites::
Func_012_6EC6:: ; address name
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld de, wObject5
    ld a, [de]
    bit 7, a
    ret z

DrawFieldSprites_SetSpriteTileOffset::
Jump_012_6ED3:: ; address name
    inc de
    ld a, [de]
    ldh [hSpriteTileOffset], a
    inc de
    ld a, [de]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [de]
    bit 7, a
    jr z, .clear_sprite_sub_index
    call DrawFieldSprites_WriteSpriteSubIndex
    jr .set_sprite_attr_xor

.clear_sprite_sub_index:
    xor a, a
    ldh [hSpriteSubIndex], a

.set_sprite_attr_xor:
    inc de
    ld a, [de]
    ldh [hSpriteAttrXor], a
    ld l, e
    ld h, d
    inc hl
    ld a, [hl]
    add a, $08
    ld d, a
    ldh a, [hScrollX]
    add a, d
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    inc hl
    ld a, [hl]
    add a, $10
    ld d, a
    ldh a, [hScrollY]
    add a, d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from DrawFieldSprites (E-0047)
; 1 call site from 1 routine (e.g. DrawFieldSprites)
; reads: wObject5
; writes: hSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex::
Func_012_6F17:: ; address name
    push af
    ld hl, wObject5 + $6
    inc [hl]
    pop af
    and a, $7F
    cp a, $13
    jr nz, .cp_1A
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_6FF2
    call DrawFieldSprites_Sub01_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_1A:
    cp a, $1A
    jr nz, .cp_17
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_6FF7
    call DrawFieldSprites_Sub01_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_17:
    cp a, $17
    jr nz, .cp_1F
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_6FFA
    call DrawFieldSprites_Sub01_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_1F:
    cp a, $1F
    jr nz, .cp_1E
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_6FFE
    call DrawFieldSprites_Sub01_WriteObject5
    ld a, [wObject5 + $7]
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_700E
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ret

.cp_1E:
    cp a, $1E
    jr nz, .cp_18
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_701E
    call DrawFieldSprites_Sub01_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_18:
    cp a, $18
    jr nz, .cp_20
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_7023
    call DrawFieldSprites_Sub01_WriteObject5
    ld a, [wObject5 + $7]
    ldh [hSpriteSubIndex], a
    ret

.cp_20:
    cp a, $20
    jr nz, .return
    ld hl, DrawFieldSprites_WriteSpriteSubIndex_Data_7026
    call DrawFieldSprites_Sub01_WriteObject5_Sub02
    ldh [hSpriteSubIndex], a
    ret

.return:
    ret

; only called from DrawFieldSprites_Sub01 (E-0047)
; 6 call sites from 1 routine (e.g. DrawFieldSprites_WriteSpriteSubIndex)
; reads: wObject5
; writes: wObject5
DrawFieldSprites_Sub01_WriteObject5::
Func_012_6F96:: ; address name
    ld a, [wObject5 + $7]
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wObject5 + $6]
    cp a, c
    jr nz, .return
    xor a, a
    ld [wObject5 + $6], a
    inc hl
    ld a, [hl]
    cp a, $FF
    jr nz, .check_object5
    xor a, a
    ld [wObject5 + $7], a
    jr .return

.check_object5:
    ld a, [wObject5 + $7]
    inc a
    ld [wObject5 + $7], a

.return:
    ret

; only called from DrawFieldSprites_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DrawFieldSprites_WriteSpriteSubIndex)
; reads: wObject5
; writes: wObject5
DrawFieldSprites_Sub01_WriteObject5_Sub02::
Func_012_6FBE:: ; address name
    push hl
    ld a, [wObject5 + $7]
    add a, a
    add_a_to_hl
    inc hl
    ld a, [hl]
    ld c, a
    ld a, [wObject5 + $6]
    cp a, c
    jr nz, .read_object5
    xor a, a
    ld [wObject5 + $6], a
    ld hl, wObject5 + $7
    inc [hl]

.read_object5:
    ld a, [wObject5 + $7]
    add a, a
    pop hl
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, [wObject5 + $7]
    dec a
    ld [wObject5 + $7], a
    dec hl
    dec hl
    ld a, [hl]
    ret

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_6FF2:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_6FF2:: ; address name
    db $08, $08, $08, $08, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_6FF7:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_6FF7:: ; address name
    db $08, $08, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_6FFA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_6FFA:: ; address name
    db $07, $07, $09, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_6FFE:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_6FFE:: ; address name
    db $0E, $0E, $0E, $0E, $0E, $0E, $0E, $36, $0E, $0E, $0E, $40, $FF, $FF, $FF, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_700E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_700E:: ; address name
    db $00, $01, $02, $01, $02, $01, $02, $00, $03, $04, $05, $06, $FF, $FF, $FF, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_701E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_701E:: ; address name
    db $04, $07, $07, $04, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_7023:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7023:: ; address name
    db $20, $20, $FF

; address loaded by DrawFieldSprites_WriteSpriteSubIndex
DrawFieldSprites_WriteSpriteSubIndex_Data_7026:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7026:: ; address name
    db $00, $1E, $00, $05, $01, $04, $02, $05, $01, $04, $00, $05, $01, $04, $02, $05
    db $03, $04, $04, $05, $03, $04, $02, $05, $05, $04, $06, $05, $05, $04, $02, $05
    db $01, $04, $00, $05, $FF, $FF

; E-0238 (C1: RunFieldCommandTemp0_Shared01 and _Shared02 index it with hTemp0 & $7F: the word is decompressed from bank $7E to vTiles0 + $400 (DecompressToVRAM); on CGB, byte 2 & $7F selects the palette at 7E:$4BBD + 8 * index copied to wOBJPaletteBuffer + $20; byte 3 is returned in A; 22 records).
; record: bank-$7E graphics stream; palette index; returned byte
FieldCommandSpriteTable::
Data_012_704C:: ; address name
    dw Tiles0Plus300Gfx_7E_4F22 ; id 0
    db $0A, $00
    dw Tiles0Plus300Gfx_7E_4F22 ; id 1
    db $0A, $00
    dw Tiles0Gfx_7E_4CED ; id 2
    db $00, $00
    dw Gfx_7E_56C3 ; id 3
    db $1D, $00
    dw Tiles0Gfx_7E_4CED ; id 4
    db $00, $00
    dw Tiles0Plus600Gfx_7E_52BC ; id 5
    db $15, $00
    dw Gfx_7E_51A8 ; id 6
    db $93, $00
    dw Gfx_7E_52F9 ; id 7
    db $16, $00
    dw Gfx_7E_4FE8 ; id 8
    db $0D, $00
    dw Gfx_7E_50EB ; id 9
    db $11, $00
    dw Gfx_7E_5027 ; id 10
    db $0E, $00
    dw Gfx_7E_5513 ; id 11
    db $9A, $00
    dw Gfx_7E_5370 ; id 12
    db $97, $00
    dw Gfx_7E_5756 ; id 13
    db $1F, $00
    dw Gfx_7E_5756 ; id 14
    db $9F, $00
    dw Gfx_7E_4F63 ; id 15
    db $0B, $00
    dw Gfx_7E_4EF1 ; id 16
    db $09, $00
    dw Tiles0Plus100Gfx_7E_5706 ; id 17
    db $9E, $00
    dw Gfx_7E_541A ; id 18
    db $98, $00
    dw Tiles0Gfx_7E_4CED ; id 19
    db $00, $00
    dw Gfx_7E_5870 ; id 20
    db $20, $00
    dw Gfx_7E_5870 ; id 21
    db $A0, $00

; wC8FE = $FF; on town maps (or special maps of type 0) finds the wCC48 entry for the current screen and sets wC900, wC8FF and wC8FE from it (E-0128)
; 2 call sites from 2 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_FindTriggerEntryForCurrentScreen)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, wMapObjectCount, wTriggerKind, wIsCGB
; writes: wTriggerKind, wTriggerIndex, wTriggerCell, wOBJPaletteUploadRequest
; points at: wMapObjects, wOBJPaletteBuffer
FindTriggerEntryForCurrentScreen::
Func_012_70A4:: ; address name
    ld a, $FF
    ld [wTriggerKind], a
    ld a, [wMapType]
    bit 7, a
    jr nz, .check_map_type
    ldh a, [hMapId]
    cp a, $20
    jr z, .read_map_screen_x
    cp a, $30
    jr z, .read_map_screen_x
    cp a, $48
    jr z, .read_map_screen_x
    cp a, $70
    jr z, .read_map_screen_x
    cp a, $A8
    jr z, .read_map_screen_x
    cp a, $B0
    jr z, .read_map_screen_x
    cp a, $B8
    jr z, .read_map_screen_x
    ret

.check_map_type:
    ld a, [wMapType]
    and a, $07
    ret nz

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wMapObjectCount]
    or a, a
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
    cp a, c
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
    sub a, b
    ld [wTriggerIndex], a
    jr FindTriggerEntryForCurrentScreen_ScreenTriggers_SetTriggerCell

; on maps from $30 (or special map $85) finds the wCCEB entry for the current screen and sets wC900, wC8FF and wC8FE from it (E-0128)
; 2 call sites from 2 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_FindTriggerEntryForCurrentScreen)
; reads: wMapType, hMapId, wScreenTriggerCount, hMapScreenX, hMapScreenY, wTriggerKind, wIsCGB
; writes: wScreenTriggerCount, wTriggerIndex, wTriggerCell, wTriggerKind, wOBJPaletteUploadRequest
; points at: wScreenTriggers, wOBJPaletteBuffer
FindTriggerEntryForCurrentScreen_ScreenTriggers::
Func_012_710A:: ; address name
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_85
    ldh a, [hMapId]
    cp a, $30
    jr nc, .check_screen_trigger_count
    xor a, a
    ld [wScreenTriggerCount], a
    ret

.cp_85:
    cp a, $85
    ret nz
    ld a, [wScreenTriggerCount]
    or a, a
    ret z
    ld b, a
    ld hl, wScreenTriggers
    jr .read_map_screen_x

.check_screen_trigger_count:
    ld a, [wScreenTriggerCount]
    or a, a
    ret z
    ld b, $03
    ld hl, wScreenTriggers

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a

.loop:
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, .restore
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
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
    sub a, b
    ld [wTriggerIndex], a
    jr FindTriggerEntryForCurrentScreen_ScreenTriggers_SetTriggerCell

FindTriggerEntryForCurrentScreen_ScreenTriggers_SetTriggerCell::
Jump_012_715E:: ; address name
    inc hl
    ld a, [hl]
    ld [wTriggerCell], a
    pop hl
    ld a, [hl]
    and a, $03
    jr nz, .skip
    inc hl
    ld a, [hl]
    ld hl, FindTriggerEntryForCurrentScreen_ScreenTriggers_Data
    add_a_to_hl
    ld a, [hl]

.skip:
    or a, a
    ret z
    ld [wTriggerKind], a

; only called from RandomGoldOrItem_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RandomGoldOrItem_Case04_NextRandomSeed)
; reads: wTriggerKind, wIsCGB
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
RandomGoldOrItem_Case04_Sub01_DecompressToVRAM::
Func_012_7179:: ; address name
    ld a, [wTriggerKind]
    ld c, a
    add a, a
    add a, c
    add a, a
    ld hl, TriggerSpriteRecord0
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [hl]
    ld de, $4BBD
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $7E
    ld a, $20
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; address loaded by FindTriggerEntryForCurrentScreen_ScreenTriggers
FindTriggerEntryForCurrentScreen_ScreenTriggers_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_71BB:: ; address name
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0A, $06, $00, $01

; E-0239 (C1: record 0 of the 6-byte records RandomGoldOrItem_Case04_Sub01_Sub01 reads at $71E8 + 6 * wTriggerKind (TriggerSpriteTable holds 1-10); all six bytes are zero).
; record: record 0 of the trigger sprite records: all zero
TriggerSpriteRecord0::
Data_012_71E8:: ; address name
    db $00, $00, $00, $00, $00, $00 ; id 0

; E-0239 (C1: RandomGoldOrItem_Case04_Sub01_Sub01 reads the 6-byte record at $71E8 + 6 * wTriggerKind, decompresses the far-pointed stream to vTiles0 + $400 (DecompressToVRAM) and on CGB copies the 8 bytes at 7E:$4BBD + byte 3 to wOBJPaletteBuffer + $20; records 1-10 here; record 0 is TriggerSpriteRecord0).
; record: graphics stream, bank; palette offset; two bytes
TriggerSpriteTable::
Data_012_71EE:: ; address name
    dfar Gfx_7E_4EF1 ; id 1: compressed sprite graphics
    db $48 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4D1A ; id 2: compressed sprite graphics
    db $08 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4D1A ; id 3: compressed sprite graphics
    db $08 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4D4F ; id 4: compressed sprite graphics
    db $10 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4D8A ; id 5: compressed sprite graphics
    db $18 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4DCC ; id 6: compressed sprite graphics
    db $20 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4E06 ; id 7: compressed sprite graphics
    db $28 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4E37 ; id 8: compressed sprite graphics
    db $30 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Gfx_7E_4E79 ; id 9: compressed sprite graphics
    db $38 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here
    dfar Tiles0Gfx_7E_4EB3 ; id 10: compressed sprite graphics
    db $40 ; palette byte offset from 7E:$4BBD (ObjPalettes_7E_4BBD)
    db $00, $00 ; not read here

; unless bit 7 of wC468 is set or no trigger is active (wC8FE = $FF), draws the trigger marker sprite (Data_012_7308) at the trigger cell wC8FF (E-0130)
; 2 call sites from 2 routines (e.g. RunFunc722AAnd6EB7, FieldModeStateDispatch_FieldStateCommonUpdate)
; reads: wFieldActionRequest, wTriggerKind, wTriggerMarkerFlags, wScreenTriggerCount, wMapType, hScrollX, hScrollXHi, wTriggerCell, ...
; writes: hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
DrawTriggerMarkerSprite::
Func_012_722A:: ; address name
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld a, [wTriggerKind]
    cp a, $FF
    ret z
    ld hl, DrawTriggerMarkerSprite_Data_7308
    add_a_to_hl
    ld a, [hl+]
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    ld a, $40
    ldh [hSpriteTileOffset], a
    ld a, $04
    ldh [hSpriteAttrXor], a
    ld a, [wTriggerMarkerFlags]
    bit 7, a
    jp nz, .read_scroll_x2
    ld a, [wScreenTriggerCount]
    or a, a
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
    and a, $F0
    add a, $08
    add a, e
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
    and a, $0F
    swap a
    add a, $10
    add a, e
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
    add a, a
    ld hl, DrawTriggerMarkerSprite_Data_7313
    add_a_to_hl
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [hl+]
    add a, $08
    add a, e
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
    ld a, [hl+]
    add a, $10
    add a, e
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
    add a, $08
    add a, e
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
    add a, $10
    add a, e
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

; address loaded by DrawTriggerMarkerSprite
DrawTriggerMarkerSprite_Data_7308:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7308:: ; address name
    db $00, $09, $01, $01, $02, $03, $04, $05, $06, $07, $08

; address loaded by DrawTriggerMarkerSprite
DrawTriggerMarkerSprite_Data_7313:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7313:: ; address name
    db $10, $20, $10, $70, $20, $10, $20, $40, $20, $60, $30, $30, $40, $50, $40, $70
    db $50, $10, $50, $30, $60, $50, $70, $20, $70, $40, $70, $70, $80, $10, $80, $60

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_UpdatePlayerMovement, FieldModeStateDispatch_UpdatePlayerMovement_Case05)
; reads: wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, wTriggerKind, hPlayerX, hPlayerY, hPlayerFacing, ...
; writes: wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_WaitTextWindowState::
Func_012_7333:: ; address name
    ld a, [wTextWindowState]
    and a, $03
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
    cp a, $02
    jr z, .read_player_x
    cp a, $03
    jr z, .read_player_x
    ret

.read_player_x:
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .call_is_player_on_trigger_cell
    dec b
    jr .call_is_player_on_trigger_cell2

.skip:
    ld a, c
    add a, $11
    ld c, a
    jr .call_is_player_on_trigger_cell2

.skip2:
    ld a, b
    add a, $11
    ld b, a
    jr .call_is_player_on_trigger_cell2

.call_is_player_on_trigger_cell:
    dec c

.call_is_player_on_trigger_cell2:
    call IsPlayerOnTriggerCell
    or a, a
    jr z, .return
    ld a, $0F
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

.return:
    ret

; when the player stands on a trigger (Func_012_7536) and nothing blocks it, sets wC916 = $0F and far-calls DispatchTalkEvent, clearing the joypad state (E-0125)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_FieldStateCommonUpdate, UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7)
; reads: wTriggerEnable, wFieldStepFlags, wTriggerKind, hPlayerX, hPlayerY, wScriptRunning, wTalkEventIndex, wTalkEventGroup
; writes: wEncounterDelay, wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
CheckStepTriggerAndDispatchTalk::
Func_012_73A1:: ; address name
    ld a, [wTriggerEnable]
    dec a
    ret z
    ld a, [wFieldStepFlags]
    cp a, $C0
    ret z
    ld a, [wTriggerKind]
    cp a, $FF
    ret z
    cp a, $02
    ret z
    cp a, $03
    ret z
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call IsPlayerOnTriggerCell
    or a, a
    jr z, .return
    ld a, [wScriptRunning]
    or a, a
    jr z, .set_talk_event_group_to_0F
    ld a, [wTalkEventIndex]
    or a, a
    jr nz, .set_talk_event_group_to_0F
    ld a, [wTalkEventGroup]
    cp a, $1D
    jr nz, .set_talk_event_group_to_0F
    ld a, $01
    ld [wEncounterDelay], a

.set_talk_event_group_to_0F:
    ld a, $0F
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.return:
    ret

; only called from FieldModeStateDispatch_Case05 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_UpdatePlayerMovement_Case05)
; reads: wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, wMapType, hPlayerX, hPlayerY, hPlayerFacing, ...
; writes: wScriptParam0, wScriptParam1, wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
; points at: wKeyWorldByte8B
FieldModeStateDispatch_Case05_WaitTextWindowState::
Func_012_73F3:: ; address name
    ld a, [wTextWindowState]
    and a, $03
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
    cp a, $85
    jr z, .read_player_x
    cp a, $86
    ret nz

.read_player_x:
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, .skip
    dec a
    jr z, .skip2
    dec a
    jr z, .skip3
    ld a, b
    sub a, $10
    ld b, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.skip:
    ld a, c
    add a, $10
    ld c, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.skip2:
    ld a, b
    add a, $10
    ld b, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.skip3:
    ld a, c
    sub a, $10
    ld c, a
    jr .call_read_tile_buffer2x2_at_pixel_bank12

.call_read_tile_buffer2x2_at_pixel_bank12:
    call ReadTileBuffer2x2AtPixel_Bank12
    ld a, [wMapType]
    cp a, $86
    jp z, .check_tiles_under_point
    ld a, [wTilesUnderPoint]
    cp a, $2C
    jr z, .read_map_screen_x
    cp a, $2E
    jr z, .loop
    ret

.loop:
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0E
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

.read_map_screen_x:
    ldh a, [hMapScreenX]
    swap a
    ld b, a
    ldh a, [hMapScreenY]
    or a, b
    ld b, a
    ld a, [wKeyWorldFloor]
    swap a
    ld hl, wKeyWorldFloorState + $4
    add_a_to_hl
    ld a, [wKeyWorldArea]
    ld c, a
    ld a, [hl]
    cp a, c
    jr nz, .next
    inc hl
    inc hl
    ld a, [hl]
    ld de, FieldModeStateDispatch_Case05_WaitTextWindowState_Data
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    cp a, b
    jr nz, .next2
    dec hl
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0E
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
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
    ld de, FieldModeStateDispatch_Case05_WaitTextWindowState_Data
    add a, e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    cp a, b
    jr nz, .return
    dec hl
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0E
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

.return:
    ret

.check_tiles_under_point:
    ld a, [wTilesUnderPoint]
    cp a, $1A
    jr z, .read_key_world_floor
    cp a, $1C
    jp z, .loop
    ret

.read_key_world_floor:
    ld a, [wKeyWorldFloor]
    ld hl, wKeyWorldByte8B
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld a, $0D
    ld [wTalkEventGroup], a
    xor a, a
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

; address loaded by FieldModeStateDispatch_Case05_WaitTextWindowState
FieldModeStateDispatch_Case05_WaitTextWindowState_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_752E:: ; address name
    db $01, $10, $12, $13, $20, $21, $23, $32

; A = 1 when the player cell (B, C high nibbles) equals the trigger cell wC8FF (or its Data_012_7581 entry on special maps), else 0 (E-0127)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_WaitTextWindowState, CheckStepTriggerAndDispatchTalk)
; reads: wMapType, wTriggerCell
IsPlayerOnTriggerCell::
Func_012_7536:: ; address name
    push bc
    jr .skip

.loop:
    xor a, a
    pop bc
    ret

.skip:
    ld a, b
    swap a
    and a, $0F
    ld b, a
    ld a, c
    swap a
    and a, $0F
    ld c, a
    ld a, [wMapType]
    bit 7, a
    jr nz, .cp_85

.loop2:
    ld a, [wTriggerCell]
    swap a
    and a, $0F
    cp a, b
    jr nz, .loop
    ld a, [wTriggerCell]
    and a, $0F
    cp a, c
    jr nz, .loop
    ld a, $01
    pop bc
    ret

.cp_85:
    cp a, $85
    jr z, .loop2
    ld a, [wTriggerCell]
    add a, a
    ld hl, IsPlayerOnTriggerCell_Data
    add_a_to_hl
    ld a, [hl+]
    cp a, b
    jr nz, .loop
    ld a, [hl]
    cp a, c
    jr nz, .loop
    ld a, $01
    pop bc
    ret

; address loaded by IsPlayerOnTriggerCell
IsPlayerOnTriggerCell_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7581:: ; address name
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries); copies the 2 x 2 entries there to wC910, wC911 (top row) and wC912, wC913 (bottom row); HL ends on the bottom-right entry (E-0064) (the same 63 bytes appear in 3 banks)
; 2 call sites from 2 routines (e.g. RunPendingFieldEventPendingFieldEvent, FieldModeStateDispatch_Case05_WaitTextWindowState)
; writes: wTilesUnderPoint
ReadTileBuffer2x2AtPixel_Bank12::
Func_012_75A1:: ; address name
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
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wTilesUnderPoint], a
    ld a, [hl-]
    ld [wTilesUnderPoint + $1], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wTilesUnderPoint + $2], a
    ld a, [hl]
    ld [wTilesUnderPoint + $3], a
    ret

; on town maps, every 100 calls (wC832), tries the gold, party-stat and digit events in turn until one sets wC935 (E-0128)
; 3 call sites from 3 routines (e.g. RunPendingFieldEventPendingFieldEvent, UpdatePlayerMovement_RedrawScreenBufferIfPartyWindowFlagsBit7, RunFieldActionRequestActionIfBit7_AdvanceStepCounterAndUpdateStoredRecords)
; reads: wScriptRunning, wPendingFieldEvent, wMapType, hMapId, wTownEventTimer
; writes: wTownEventTimer
RunPeriodicFieldEventChecks::
Func_012_75E0:: ; address name
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wPendingFieldEvent]
    bit 7, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ldh a, [hMapId]
    cp a, $20
    jr z, .check_town_event_timer
    cp a, $30
    jr z, .check_town_event_timer
    cp a, $48
    jr z, .check_town_event_timer
    cp a, $70
    jr z, .check_town_event_timer
    cp a, $A8
    jr z, .check_town_event_timer
    cp a, $B0
    jr z, .check_town_event_timer
    cp a, $B8
    jr z, .check_town_event_timer
    cp a, $C8
    jr z, .check_town_event_timer
    ret

.skip:
    and a, $7F
    ret nz

.check_town_event_timer:
    ld a, [wTownEventTimer]
    cp a, $63
    jr z, .clear_town_event_timer
    inc a
    ld [wTownEventTimer], a
    ret

.clear_town_event_timer:
    xor a, a
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
    call TriggerEventC6IfGoldAtLeast5000
    ret c
    call TriggerEventForStatusedMemberHP_781E
    ret c
    call TriggerEventC7IfGold1000AndNoItems19To1C
    ret c
    call RunPeriodicFieldEventChecks_WriteRAMGAndPendingFieldEvent
    ret c
    call TriggerEventC9IfExpDigitsRepeat
    ret c
    call TriggerEventC4OrC5IfGold1000
    ret c
    sub a, a
    ret

; when story flag $192 is set, flag $193 is clear and gold >= 10,000 ($2710): wC935 = $CC and carry set; otherwise A = 0 and carry clear (E-0075)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wGoldHi, wGoldMid, wGoldLo
; writes: wPendingFieldEvent
EventCheckGoldAtLeast10000::
Func_012_7662:: ; address name
    ld de, $0192
    call TestFlagBit
    jr nc, .done
    ld de, $0193
    call TestFlagBit
    jr c, .done
    ld a, [wGoldHi]
    or a, a
    jr nz, .set_pending_field_event_to_CC
    ld a, [wGoldMid]
    cp a, $27
    jr z, .check_gold_lo
    jr nc, .set_pending_field_event_to_CC
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $10
    jr c, .done

.set_pending_field_event_to_CC:
    ld a, $CC
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; with story flag $195 set and $196 clear: when the party's total HP is below 100, wC935 = $CD and carry (E-0127)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wPartyCount, hTemp0, hTemp1, hTemp2, hTemp3
; writes: hTemp2, hTemp3, rRAMG, wPendingFieldEvent
; points at: wPartyList
TriggerEventCDIfPartyHPTotalBelow100::
Func_012_7693:: ; address name
    ld de, $0195
    call TestFlagBit
    jr nc, .done
    ld de, $0196
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
    ld a, $0A
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
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp3]
    or a, a
    jr nz, .done
    ldh a, [hTemp2]
    cp a, $64
    jr nc, .done
    ld a, $CD
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; with story flag $198 set and $199 clear: when the party's total MP is below 100, wC935 = $CE and carry (E-0127)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wPartyCount, hTemp0, hTemp1, hTemp2, hTemp3
; writes: hTemp2, hTemp3, rRAMG, wPendingFieldEvent
; points at: wPartyList
TriggerEventCEIfPartyMPTotalBelow100::
Func_012_76F1:: ; address name
    ld de, $0198
    call TestFlagBit
    jr nc, .done
    ld de, $0199
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
    ld a, $0A
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
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp3]
    or a, a
    jr nz, .done
    ldh a, [hTemp2]
    cp a, $64
    jr nc, .done
    ld a, $CE
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; with story flag $19B set and $19C clear: when the party's total level is below 100, wC935 = $CF and carry (E-0127)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wPartyCount, hTemp0, hTemp2, hTemp3
; writes: hTemp2, hTemp3, rRAMG, wPendingFieldEvent
; points at: wPartyList
TriggerEventCFIfPartyLevelTotalBelow100::
Func_012_774F:: ; address name
    ld de, $019B
    call TestFlagBit
    jr nc, .done
    ld de, $019C
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
    ld a, $0A
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
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp3]
    or a, a
    jr nz, .done
    ldh a, [hTemp2]
    cp a, $64
    jr nc, .done
    ld a, $CF
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; with at least 1000 gold: when a party member's EXP has its last three decimal digits equal, wC935 = $C9 and carry (E-0128)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wGoldHi, wGoldMid, wPartyCount, hTemp0, hTemp1, hTemp2, wGoldLo
; writes: rRAMG, wDigits, wPendingFieldEvent
; points at: wPartyList
TriggerEventC9IfExpDigitsRepeat::
Func_012_77AC:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, .read_party_count
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .read_party_count
    jr .skip

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
    jr c, .skip

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld a, $0A
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
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    swap a
    and a, $0F
    cp a, c
    jr nz, .restore
    ldh a, [hTemp1]
    and a, $0F
    cp a, c
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
    xor a, a
    ld [rRAMG], a
    ld a, $C9
    ld [wPendingFieldEvent], a
    scf
    ret

.skip:
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

; with at least 1000 gold: checks party members with status bits 7, 2 or 0 of field $55 against half their max HP and may set an event (E-0128)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wGoldHi, wGoldMid, wPartyCount, hTemp0, hTemp1, hTemp3, hTemp2, wGoldLo
; writes: rRAMG, hTemp2, hTemp3, wPendingFieldEvent
; points at: wPartyList
TriggerEventForStatusedMemberHP_781E::
Func_012_781E:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, .read_party_count
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .read_party_count
    jr .skip

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
    jr c, .skip

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld a, $0A
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
    cp a, c
    jr c, .loop2
    jr nz, .restore
    ldh a, [hTemp2]
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr c, .loop2

.restore:
    pop hl
    xor a, a
    ld [rRAMG], a
    ld a, $CB
    ld [wPendingFieldEvent], a
    scf
    ret

.skip:
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

; only called from RunPeriodicFieldEventChecks (E-0047)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wEventItemSlot, wGoldHi, wGoldMid, wPartyCount, hTemp0, hTemp1, wGoldLo
; writes: rRAMG, wPendingFieldEvent
; points at: wPartyList
RunPeriodicFieldEventChecks_WriteRAMGAndPendingFieldEvent::
Func_012_789E:: ; address name
    ld a, [wEventItemSlot]
    cp a, $FF
    jr z, .check_gold_hi
    or a, a
    jp nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a, a
    jr nz, .read_party_count
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .read_party_count
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
    jr c, .done

.read_party_count:
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, $0000

.loop:
    ld a, [hl+]
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
    xor a, a
    ld [rRAMG], a
    ld l, e
    ld h, d
    ld a, $64
    call DivideHLByA
    ld c, l
    ld b, h
    ld a, $1E
    call Multiply8By16
    push hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, $0000

.loop2:
    ld a, [hl+]
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
    xor a, a
    ld [rRAMG], a
    pop hl
    ld a, d
    cp a, h
    jr c, .set_pending_field_event_to_C8
    jr nz, .done
    ld a, e
    cp a, l
    jr c, .set_pending_field_event_to_C8
    jr nz, .done

.set_pending_field_event_to_C8:
    ld a, $C8
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; when wC627 is $FF or 0, the gold is at least 1000 and no inventory slot before the first empty one holds items $19-$1C: wC935 = $C7 and carry (E-0125)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wEventItemSlot, wGoldHi, wGoldMid, wGoldLo
; writes: wPendingFieldEvent
; points at: wInventory
TriggerEventC7IfGold1000AndNoItems19To1C::
Func_012_7934:: ; address name
    ld a, [wEventItemSlot]
    cp a, $FF
    jr z, .check_gold_hi
    or a, a
    jr nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a, a
    jr nz, .skip
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .skip
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
    jr c, .done

.skip:
    ld hl, wInventory

.skip2:
    ld a, [hl+]
    or a, a
    jr z, .set_pending_field_event_to_C7
    cp a, $FF
    jr z, .set_pending_field_event_to_C7
    cp a, $19
    jr z, .done
    cp a, $1A
    jr z, .done
    cp a, $1B
    jr z, .done
    cp a, $1C
    jr z, .done
    jr .skip2

.set_pending_field_event_to_C7:
    ld a, $C7
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; when wC627 is $FF or 0 and the gold is at least 5000, wC935 = $C6 and carry; otherwise A = 0, no carry (E-0124)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wEventItemSlot, wGoldHi, wGoldMid, wGoldLo
; writes: wPendingFieldEvent
TriggerEventC6IfGoldAtLeast5000::
Func_012_797C:: ; address name
    ld a, [wEventItemSlot]
    cp a, $FF
    jr z, .check_gold_hi
    or a, a
    jr nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a, a
    jr nz, .set_pending_field_event_to_C6
    ld a, [wGoldMid]
    cp a, $13
    jr z, .check_gold_lo
    jr nc, .set_pending_field_event_to_C6
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $88
    jr c, .done

.set_pending_field_event_to_C6:
    ld a, $C6
    ld [wPendingFieldEvent], a
    scf
    ret

.done:
    sub a, a
    ret

; when the gold is at least 1000 and wC634 is $FF or 0: wC935 = $C4 or $C5 at random and carry (E-0125)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wGoldHi, wGoldMid, wInventory, wRandomHi, wGoldLo
; writes: wPendingFieldEvent
TriggerEventC4OrC5IfGold1000::
Func_012_79A7:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, .check_inventory
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .check_inventory
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
    jr c, .done

.check_inventory:
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .skip
    or a, a
    jr nz, .done

.skip:
    jr .call_next_table_byte

.done:
    sub a, a
    ret

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    and a, $01
    add a, $C4
    ld [wPendingFieldEvent], a
    scf
    ret

; with at least 5000 gold and wC634 $FF or 0: when the gold's decimal digits sum to at least 30, wC935 = $C3 and carry (E-0128)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wGoldHi, wGoldMid, wInventory, wGoldLo, hTemp0, hTemp1, hTemp2, hTemp3
; writes: wDigits, wPendingFieldEvent
TriggerEventC3IfGoldDigitSum30::
Func_012_79DC:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, .check_inventory
    ld a, [wGoldMid]
    cp a, $13
    jr z, .check_gold_lo
    jr nc, .check_inventory
    jr .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $88
    jr c, .done

.check_inventory:
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .read_gold_lo
    or a, a
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
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp1]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp1]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp2]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp2]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp3]
    and a, $0F
    add a, c
    cp a, $1E
    jr nc, .set_pending_field_event_to_C3

.done:
    sub a, a
    ret

.set_pending_field_event_to_C3:
    ld a, $C3
    ld [wPendingFieldEvent], a
    scf
    ret

; with at least 1000 gold: when every party member's HP ends in the same decimal digit, wC935 = $C2 and carry (E-0128)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wGoldHi, wGoldMid, wPartyCount, wPartyList, hTemp0, hTemp1, wDigits, wGoldLo
; writes: rRAMG, wPendingFieldEvent
TriggerEventC2IfPartyHPLastDigitsMatch::
Func_012_7A4D:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, .check_party_count
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .check_party_count
    jp .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
    jr c, .done

.check_party_count:
    ld a, $0A
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
    cp a, b
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
    cp a, b
    jr nz, .skip2

.skip:
    xor a, a
    ld [rRAMG], a
    ld a, $C2
    ld [wPendingFieldEvent], a
    scf
    ret

.skip2:
    xor a, a
    ld [rRAMG], a

.done:
    sub a, a
    ret

; with at least 1000 gold and wC634 $FF or 0: when the gold's decimal digits sum to at most 12, wC935 = $C1 and carry (E-0128)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wInventory, wGoldHi, wGoldMid, wGoldLo, hTemp0, hTemp1, hTemp2, hTemp3
; writes: wDigits, wPendingFieldEvent
TriggerEventC1IfGoldDigitSumAtMost12::
Func_012_7AD0:: ; address name
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .check_gold_hi
    or a, a
    jr nz, .done

.check_gold_hi:
    ld a, [wGoldHi]
    or a, a
    jr nz, .read_gold_lo
    ld a, [wGoldMid]
    cp a, $03
    jr z, .check_gold_lo
    jr nc, .read_gold_lo
    jp .done

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $E8
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
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp1]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp1]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp2]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp2]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hTemp3]
    and a, $0F
    add a, c
    cp a, $0C
    jr z, .set_pending_field_event_to_C1
    jr c, .set_pending_field_event_to_C1

.done:
    sub a, a
    ret

.set_pending_field_event_to_C1:
    ld a, $C1
    ld [wPendingFieldEvent], a
    scf
    ret

; when a party member's HP has all decimal digits equal (for example 77 or 333), wC935 = $C0 and carry (E-0127)
; 1 call site from 1 routine (e.g. RunPeriodicFieldEventChecks)
; reads: wPartyCount, hTemp0, hTemp1, wDigits
; writes: rRAMG, wPendingFieldEvent
; points at: wPartyList
TriggerEventC0IfHPDigitsRepeat::
Func_012_7B45:: ; address name
    ld a, $0A
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
    or a, a
    jr z, .check_digits
    ld c, a
    ld a, [wDigits + $1]
    cp a, c
    jr nz, .restore
    ld a, [wDigits + $2]
    cp a, c
    jr nz, .restore
    jr .restore2

.check_digits:
    ld a, [wDigits + $1]
    or a, a
    jr z, .restore2
    ld c, a
    ld a, [wDigits + $2]
    cp a, c
    jr nz, .restore
    jr .restore2

.restore:
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

.restore2:
    pop hl
    pop bc
    xor a, a
    ld [rRAMG], a
    ld a, $C0
    ld [wPendingFieldEvent], a
    scf
    ret

; when wC935 has bit 7 set and bit 6 clear: wC935 = 0 and wC832 = 0 (E-0117)
; 9 call sites from 7 routines (e.g. CheckWarpAtPlayer, CheckWarpsAtPlayerPosition, ScriptWarpToMapFromBytesAtDE, CheckMapExitTable4480_WriteWarpPendingAndMapIdEtc, ...)
; reads: wPendingFieldEvent
; writes: wPendingFieldEvent, wTownEventTimer
ClearPendingFieldEventIfBit7AndNot6::
Func_012_7B9F:: ; address name
    ld a, [wPendingFieldEvent]
    bit 7, a
    ret z
    bit 6, a
    ret nz
    xor a, a
    ld [wPendingFieldEvent], a
    ld [wTownEventTimer], a
    ret

; returns unless Func_012_7D5E is 0, wC8FE is $FF and no script runs; then, unless bit 7 of wCC44 is set, wC935 = 0 (E-0122)
; 2 call sites from 2 routines (e.g. InitFieldScreen, RunFieldActionRequestActionIfBit7_FindTriggerEntryForCurrentScreen)
; reads: wTriggerKind, wScriptRunning, wMapType, wPendingFieldEvent, wRandomHi, wSpriteSlots, wInventory
; writes: wPendingFieldEvent, wSpriteSlots, wSpriteSlotCount, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
ClearPendingFieldEventWhenFieldIdle::
Func_012_7BB0:: ; address name
    call ClearPendingFieldEventWhenFieldIdle_TestFlagBit
    or a, a
    ret nz
    ld a, [wTriggerKind]
    cp a, $FF
    ret nz
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jr nz, RunPendingFieldEventPendingFieldEvent_Skip
    xor a, a
    ld [wPendingFieldEvent], a
    ret

; on town maps runs the pending event in wC935 (bits 7 and 6 select the stage; some kinds need wC634); otherwise clears it (E-0130)
; no direct call (reached through a table, a jump or a vector)
; reads: wPendingFieldEvent, hMapId, wRandomHi, wSpriteSlots, wInventory
; writes: wPendingFieldEvent, wSpriteSlots, wSpriteSlotCount, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
RunPendingFieldEventPendingFieldEvent:: ; heuristic: follows a terminator; C0
Func_012_7BCC:: ; address name
    ld a, [wPendingFieldEvent]
    and a, $0F
    cp a, $08
    jr z, .clear_pending_field_event
    ldh a, [hMapId]
    cp a, $20
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $30
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $48
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $70
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $A8
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $B0
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $B8
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent
    cp a, $C8
    jr z, RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent

.clear_pending_field_event:
    xor a, a
    ld [wPendingFieldEvent], a
    ret

RunPendingFieldEventPendingFieldEvent_Skip::
Jump_012_7BFC:: ; address name
    and a, $7F
    ret nz

RunPendingFieldEventPendingFieldEvent_CheckPendingFieldEvent::
Jump_012_7BFF:: ; address name
    ld a, [wPendingFieldEvent]
    bit 7, a
    ret z
    bit 6, a
    jp z, .set_sprite_slot_count_to_01
    ld a, [wPendingFieldEvent]
    and a, $0F
    cp a, $01
    jr z, .check_inventory
    cp a, $03
    jr z, .check_inventory
    cp a, $04
    jr z, .check_inventory
    cp a, $05
    jr z, .check_inventory
    cp a, $07
    jr z, .check_inventory
    jr .call_next_table_byte

.check_inventory:
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .call_next_table_byte
    or a, a
    jr z, .call_next_table_byte
    xor a, a
    ld [wPendingFieldEvent], a
    ld a, $63
    ld [wTownEventTimer], a
    call RunPeriodicFieldEventChecks

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    and a, $03
    add a, a
    ld hl, RunPendingFieldEventPendingFieldEvent_Data_7D56
    add_a_to_hl
    ld a, [hl+]
    ld [wSpriteSlots + $4], a
    ld [wSpriteSlots + $B], a
    ld a, [hl]
    ld [wSpriteSlots + $5], a
    ld [wSpriteSlots + $C], a
    ld a, [wSpriteSlots + $4]
    ld b, a
    ld a, [wSpriteSlots + $5]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank12
    call RollFieldEventOnTallTiles
    cp a, $01
    ret z
    ld a, $03
    ld [wSpriteSlots], a
    ld a, $01
    ld [wSpriteSlots + $1], a
    xor a, a
    ld [wSpriteSlots + $3], a
    ld a, $05
    ld [wSpriteSlots + $6], a
    ld a, $00
    ld [wSpriteSlots + $7], a
    ld a, $50
    ld [wSpriteSlots + $8], a
    xor a, a
    ld [wSpriteSlots + $9], a
    xor a, a
    ld [wSpriteSlots + $A], a
    xor a, a
    ld [wSpriteSlots + $D], a
    ld a, $FF
    ld [wSpriteSlots + $F], a
    ld a, [wPendingFieldEvent]
    and a, $BF
    ld [wPendingFieldEvent], a

.set_sprite_slot_count_to_01:
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wPendingFieldEvent]
    and a, $0F
    ld hl, RunPendingFieldEventPendingFieldEvent_Data_7D46
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a, a
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; on map type 1, standing on tiles at or above wC196, a 1-in-8 roll sets event $0A in wC935 unless item $2C is owned or the gold is below 100; then A = 1 when any tile under the player is blocking (E-0128)
; 1 call site from 1 routine (e.g. RunPendingFieldEventPendingFieldEvent)
; reads: wMapSpriteKind, wMapTallTileMin, wKeyRandomHi, hTemp0, wInventory, wGoldHi, wGoldMid, wGoldLo, ...
; writes: hTemp0, wPendingFieldEvent
; points at: wTilesUnderPoint
RollFieldEventOnTallTiles::
Func_012_7CD9:: ; address name
    ld a, [wMapSpriteKind]
    and a, $0F
    dec a
    jr nz, .skip
    ld b, $04
    ld hl, wTilesUnderPoint

.loop:
    ld a, [hl+]
    ld c, a
    ld a, [wMapTallTileMin]
    cp a, c
    jr c, .next
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    jr nz, .skip
    ld a, $2C
    ldh [hTemp0], a
    call FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .skip
    ld a, [wInventory + $17]
    or a, a
    jr z, .read_gold_hi
    cp a, $FF
    jr nz, .skip

.read_gold_hi:
    ld a, [wGoldHi]
    ld c, a
    ld a, [wGoldMid]
    or a, c
    jr nz, .check_pending_field_event
    ld a, [wGoldLo]
    cp a, $64
    jr c, .skip

.check_pending_field_event:
    ld a, [wPendingFieldEvent]
    and a, $F0
    or a, $0A
    ld [wPendingFieldEvent], a
    xor a, a
    ret

.next:
    dec b
    jr nz, .loop

.skip:
    ld b, $04
    ld hl, wTilesUnderPoint

.loop2:
    ld a, [hl+]
    ld c, a
    ld a, [wMaxBlockingTile]
    cp a, c
    jr c, .next2
    jr .return_01

.next2:
    dec b
    jr nz, .loop2
    xor a, a
    ret

.return_01:
    ld a, $01
    ret

; address loaded by RunPendingFieldEventPendingFieldEvent
RunPendingFieldEventPendingFieldEvent_Data_7D46:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7D46:: ; address name
    db $12, $15, $3D, $3E, $10, $11, $17, $15, $14, $13, $57, $12, $15, $12, $14, $10

; address loaded by RunPendingFieldEventPendingFieldEvent
RunPendingFieldEventPendingFieldEvent_Data_7D56:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_012_7D56:: ; address name
    db $20, $20, $70, $60, $20, $60, $70, $20

; only called from ClearPendingFieldEventWhenFieldIdle (E-0047)
; 1 call site from 1 routine (e.g. ClearPendingFieldEventWhenFieldIdle)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY
; writes: wPendingFieldEvent
ClearPendingFieldEventWhenFieldIdle_TestFlagBit::
Func_012_7D5E:: ; address name
    ld a, [wMapType]
    bit 7, a
    jp nz, .return_0
    ldh a, [hMapId]
    cp a, $30
    jp nz, .return_0
    ldh a, [hMapScreenX]
    cp a, $05
    jp nz, .return_0
    ldh a, [hMapScreenY]
    cp a, $05
    jp nz, .return_0
    ld de, $0076
    call TestFlagBit
    jr c, .return_0
    ld de, $0070
    call TestFlagBit
    jr nc, .return_0
    ld a, $00
    ld [wPendingFieldEvent], a
    ld a, $01
    ret

.return_0:
    xor a, a
    ret

; hFFC6 = the party index whose record species (field $0B) equals the word hFFC6/7, or $80 when none (E-0125)
; 7 call sites from 7 routines (e.g. TalkMsg0016_ItSeemsToMeThatThe_TestFlagBit, GreatLogTalkEvents_TestFlagBit_Case27, GreatLogTalkEvents_TestFlagBit_Case7F, LoadListedRecordNameTilesForTemp0, ...)
; reads: hTemp0, hTemp1, wPartyCount
; writes: rRAMG, hTemp0
; points at: wPartyList
FindPartyIndexOfSpeciesTemp0::
Func_012_7D95:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl+]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    cp a, e
    jr nz, .next
    ldh a, [hTemp1]
    cp a, d
    jr z, .read_party_count

.next:
    dec b
    jr nz, .loop
    ld a, $80
    ldh [hTemp0], a
    xor a, a
    ld [rRAMG], a
    ret

.read_party_count:
    ld a, [wPartyCount]
    sub a, b
    ldh [hTemp0], a
    xor a, a
    ld [rRAMG], a
    ret

; hFFC6 = the index of the first byte of the 24-entry list at wC61D equal to hFFC6; $FF when an entry is $00 or $FF first or no entry matches
; 48 call sites from 24 routines (e.g. RollFieldEventOnTallTiles, YoldTalkEvents_ShowHeroCheckedThePedestal, YoldTalkEvents_StartScriptAtHL_B04_Case6A, KalkaTalkEvents_TestFlagBit_Case38, ...)
; reads: hTemp0
; writes: hTemp0
; points at: wInventory
FindTemp0InInventoryList::
Func_012_7DCE:: ; address name
    ldh a, [hTemp0]
    ld c, a
    ld b, $00
    ld hl, wInventory

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .set_temp0_to_FF
    or a, a
    jr z, .set_temp0_to_FF
    cp a, c
    jr z, .set_temp0
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr nz, .loop

.set_temp0_to_FF:
    ld a, $FF
    ldh [hTemp0], a
    ret

.set_temp0:
    ld a, b
    ldh [hTemp0], a
    ret

; hFFC6 = inventory slot: moves each wInventory byte after it down by one up to slot $17 (the last slot keeps its old value), then wC634 = $FF; nothing moves when the slot is $17 (E-0106)
; 18 call sites from 11 routines (e.g. YoldTalkEvents_StartScriptAtHL_B04_Case6A, KalkaTalkEvents_StartScriptAtHL_B04_Case39, Talk075F_KiralFetchMeMy, Talk07A4_CouldYouHumorThis, ...)
; reads: hTemp0
; writes: wInventory
; points at: wInventory
RemoveInventorySlotShiftDown::
Func_012_7DF1:: ; address name
    ldh a, [hTemp0]
    cp a, $17
    jr z, .set_inventory_to_FF
    ld b, a
    ld hl, wInventory
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    inc hl
    ld a, [hl-]
    ld [hl+], a
    inc b
    ld a, b
    cp a, $17
    jr nz, .loop

.set_inventory_to_FF:
    ld a, $FF
    ld [wInventory + $17], a
    ret

; hFFC7 = the index of the first party member knowing skill $76-$7D or $92 and hFFC8 = that skill, or hFFC7 = $80 (E-0128)
; 1 call site from 1 routine (e.g. YoldTalkEvents_TestFlagBit_Case13)
; reads: wPartyCount, hTemp1, hTemp0
; writes: rRAMG, hTemp1, hTemp2
; points at: wPartyList
FindPartyMemberWithSkill76To7DOr92::
Func_012_7E0F:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    xor a, a
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
    cp a, $FF
    jr z, .check_temp1
    ld e, $76
    cp a, e
    jr z, .set_temp2
    ld e, $77
    cp a, e
    jr z, .set_temp2
    ld e, $78
    cp a, e
    jr z, .set_temp2
    ld e, $79
    cp a, e
    jr z, .set_temp2
    ld e, $7A
    cp a, e
    jr z, .set_temp2
    ld e, $7B
    cp a, e
    jr z, .set_temp2
    ld e, $7C
    cp a, e
    jr z, .set_temp2
    ld e, $7D
    cp a, e
    jr z, .set_temp2
    ld e, $92
    cp a, e
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
    xor a, a
    ld [rRAMG], a
    ret

.set_temp2:
    ld a, e
    ldh [hTemp2], a
    pop bc
    xor a, a
    ld [rRAMG], a
    ret

; only called from GreatLogTalkEvents_CaseCC (E-0047)
; 1 call site from 1 routine (e.g. GreatLogTalkEvents_StartScriptAtHL_B13_CaseCC)
; writes: hTemp1
GreatLogTalkEvents_CaseCC_WriteTemp1::
Func_012_7E80:: ; address name
    xor a, a
    ldh [hTemp1], a
    ret

; wGold -= the word hFFC6/hFFC7; when gold is smaller than the amount it becomes 0 instead (E-0075)
; 5 call sites from 5 routines (e.g. GreatLogFieldEvents_GoHelpYourMotherScene_ShowIfSomeMonsterMasters, GreatLogFieldEvents_TaraWellBeOK_ShowHeroCheckedTheBookshelf, GreatLogFieldEvents_GoodToHear_ShowIsThatSoToo, GreatLogFieldEvents_YouFolksRunA_ShowTheresASpiritIn, ...)
; reads: hTemp0, hTemp1, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldLo, wGoldMid, wGoldHi
SubtractGoldFloorZero::
Func_012_7E84:: ; address name
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [wGoldHi]
    or a, a
    jr z, .read_gold_lo
    ld a, [wGoldMid]
    cp a, h
    jr c, .clear_gold_lo
    jr z, .check_gold_lo
    jr .read_gold_lo

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, l
    jr c, .clear_gold_lo

.read_gold_lo:
    ld a, [wGoldLo]
    sub a, l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    sbc a, h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc a, $00
    ld [wGoldHi], a
    ret

.clear_gold_lo:
    xor a, a
    ld [wGoldLo], a
    ld [wGoldMid], a
    ld [wGoldHi], a
    ret

; adds the word hFFC6/hFFC7 to the 24-bit wGoldLo/Mid/Hi and caps the result at $01869F (99,999) (E-0074)
; 13 call sites from 6 routines (e.g. RandomGoldOrItem_AddGoldCapped, ScriptFetch0E, StepTriggerReward_AddGoldCapped, TalkMsg0A3C_KingIfYouSee, ...)
; reads: hTemp0, hTemp1, wGoldLo, wGoldMid, wGoldHi
; writes: wGoldLo, wGoldMid, wGoldHi
AddGoldCapped::
Func_012_7EC2:: ; address name
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [wGoldLo]
    add a, l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    adc a, h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    adc a, $00
    ld [wGoldHi], a
    cp a, $01
    ret c
    jr z, .check_gold_mid
    jr .set_gold_lo_to_9F

.check_gold_mid:
    ld a, [wGoldMid]
    cp a, $86
    ret c
    jr z, .check_gold_lo
    jr .set_gold_lo_to_9F

.check_gold_lo:
    ld a, [wGoldLo]
    cp a, $9F
    ret c

.set_gold_lo_to_9F:
    ld a, $9F
    ld [wGoldLo], a
    ld a, $86
    ld [wGoldMid], a
    ld a, $01
    ld [wGoldHi], a
    ret

; only called from ReturnMessage_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ReturnMessage_TestFlagBit)
; reads: wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
ReturnMessage_Case00_WriteGoldHiAndGoldMidEtc::
Func_012_7F05:: ; address name
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

; takes gold: all of it when below 150, 150 when below 1,500 ($05DC), otherwise one tenth (Divide24ByA, rounded down) (E-0075)
; 1 call site from 1 routine (e.g. DeductGoldPenaltyAndFormatLoss)
; reads: wGoldHi, wGoldMid, wGoldLo
; writes: wGoldLo, wGoldMid, wGoldHi
DeductGoldPenalty::
Func_012_7F1C:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, .read_gold_lo
    ld a, [wGoldMid]
    or a, a
    jr nz, .check_gold_mid
    ld a, [wGoldLo]
    cp a, $96
    jr nc, .check_gold_mid
    ld l, a
    ld h, $00
    jr .read_gold_lo2

.check_gold_mid:
    ld a, [wGoldMid]
    cp a, $05
    jr c, .skip
    jr nz, .read_gold_lo
    ld a, [wGoldLo]
    cp a, $DC
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
    ld a, $0A
    call Divide24ByA

.read_gold_lo2:
    ld a, [wGoldLo]
    sub a, l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    sbc a, h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc a, $00
    ld [wGoldHi], a
    ret
    ds $8F, $00
