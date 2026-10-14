; ROM bank $85: story scenes: Limbo, the watch and others
; The annotated listing of this bank is build/listing/bank85.asm.

SECTION "Bank 85", ROMX[$4000], BANK[$85]
    db $85

; implements script command type CF (SCRIPT_SCENE_KEY_SHOP): a cutscene step named after the scene
; its only script shows: 'How good of you to overcome' ... 'Welcome to my Key Shop!'; reached
; through ScriptCommandCF in bank $10 (E-0038, E-0245)
SceneKeyShop::
    ld a, [wScriptStep]
    jumptable
    dw SceneKeyShop_WriteScriptStartRequest
    dw SceneKeyShop_StepObjectTowardCoord

; step 1 of SceneKeyShop: sets wStepPtrHi to 0; sets wStepTarget to 1; sets wStepPtrLo to $60; calls
; StepObjectTowardCoord; returns if wStepArrived is 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 1 of SceneKeyShop (when wScriptStep = 1); SceneKeyShop: implements script command type
; CF (SCRIPT_SCENE_KEY_SHOP): a cutscene step named after the scene its only script shows: 'How good
; of you to ... (E-0352, E-0038, E-0245)
SceneKeyShop_StepObjectTowardCoord::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wSpriteSlots + $7], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of SceneKeyShop: advances wScriptStep; may return early; sets wScriptStartRequest to $80
; (E-0347)
; why: step 0 of SceneKeyShop (when wScriptStep = 0); SceneKeyShop: implements script command type
; CF (SCRIPT_SCENE_KEY_SHOP): a cutscene step named after the scene its only script shows: 'How good
; of you to ... (E-0352, E-0038, E-0245)
SceneKeyShop_WriteScriptStartRequest::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wSpriteSlots + $b]
    cp $50
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type CE (SCRIPT_HIDE_SPRITES): wSpriteSlotCount = 0; reached through
; ScriptCommandCE in bank $10 (E-0038, E-0245)
HideSprites::
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene
; its only script shows: 'You can keep trying, but you're...' ... 'Zzz Zzz Huh! Watch out!'; reached
; through ScriptCommand2A in bank $10 (E-0038, E-0245)
SceneWatchOut::
    ld a, [wScriptStep]
    jumptable
    dw SceneWatchOut_ShowHmYouAreQuite
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWatchOut_ShowTheFarmHasNo
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWatchOut_Msg_PickTheMonsterTo
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWatchOut_CopyGlyphTilesToVRAMAndStep
    dw SceneWatchOut_ToSceneWatchOut_ReadJoypadPressedAndFrameCounterLo
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_RestoreScreenBufferFromBGMap1
    dw SceneWatchOut_CreateMonsterRecordOfKindTemp1
    dw SceneWatchOut_RunMessageBoxFar_Bank85_RestoreScreenBufferFromBGMap1
    dw SceneWatchOut_ShowNHeadedOffTo
    dw SceneWatchOut_StepObjectCoordByDirection16Frames
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStep

; step 16 of SceneWatchOut: sets hTemp1 to 5; copies wArg5 to hTemp2; sets hTemp3 to 1; calls
; CreateMonsterRecordOfKindTemp1; shows 'N headed off to the farm.'; decrements wSpriteSlotCount;
; decrements wScriptStep (E-0347)
; why: step 16 of SceneWatchOut (when wScriptStep = 16); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ShowNHeadedOffTo::
    ld a, $05
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, MSG_KEEP_OPEN | $0d52 ; 'N headed off to the farm.'
    call StartMessageHL_B85
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, wScriptStep
    dec [hl]
    ret

; step 15 of SceneWatchOut: calls RunMessageBoxFar_Bank85; may return early; calls
; RestoreScreenBufferFromBGMap1; decrements wSpriteSlotCount; calls DrawFullScreenBufferAtScroll;
; calls ClearBit1OfPlayerAndObjectFlags; sets hSpriteWindowClipMode to 0; calls PlayMapMusic; sets
; EVENT_SCENE_WATCH_OUT_078; sets wScriptStartRequest to $80 (E-0347)
; why: step 15 of SceneWatchOut (when wScriptStep = 15); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_RunMessageBoxFar_Bank85_RestoreScreenBufferFromBGMap1::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    farcall RestoreScreenBufferFromBGMap1
    ld hl, wSpriteSlotCount
    dec [hl]
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall PlayMapMusic
    ld de, EVENT_SCENE_WATCH_OUT_078
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 14 of SceneWatchOut: sets hTemp1 to 5; copies wArg5 to hTemp2; sets hTemp3 to 2; calls
; CreateMonsterRecordOfKindTemp1; increments wPartyCount; calls MoveIncapacitatedPartyMembersBack;
; calls LoadRecordListNameTiles; calls LoadPlayerAndFollowerSpriteGraphics; sets
; wOBJPaletteUploadRequest to $7f; decrements wSpriteSlotCount; shows 'N joined the party.';
; advances wScriptStep (E-0347)
; why: step 14 of SceneWatchOut (when wScriptStep = 14); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_CreateMonsterRecordOfKindTemp1::
    ld a, $05
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $02
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, wPartyCount
    inc [hl]
    ld a, [wScriptMsgSelect]
    dec a
    ld c, a
    add a
    add a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wSpriteSlots + $7]
    ld [hli], a
    ld a, [wSpriteSlots + $b]
    ld [hli], a
    ld a, [wSpriteSlots + $c]
    ld [hl], a
    ld a, [wScriptMsgSelect]
    dec a
    ld hl, wPartyList
    add_a_to_hl
    ld a, [wArg5]
    ld [hl], a
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, MSG_KEEP_OPEN | $0d51 ; 'N joined the party.'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of SceneWatchOut: calls RestoreScreenBufferFromBGMap1; calls
; DrawScreenBufferAtScrollOrigin; branches on wScriptMsgSelect; sets wScriptStep to $10; calls
; CopyRecordFields5DTo5BAnd61To5FAndMark; increments wScriptMsgSelect; decrements wPartyCount;
; advances wScriptStep; continues in SceneWatchOut_CreateMonsterRecordOfKindTemp1 (E-0347)
; why: step 13 of SceneWatchOut (when wScriptStep = 13); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_RestoreScreenBufferFromBGMap1::
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld a, [wScriptMsgSelect]
    cp $03
    jr nz, .call_copy_record_fields5_d_to5_b_and61_to5_f
    ld a, $10
    ld [wScriptStep], a
    ret

.call_copy_record_fields5_d_to5_b_and61_to5_f:
    push af
    call CopyRecordFields5DTo5BAnd61To5FAndMark
    pop af
    ld hl, wScriptMsgSelect
    inc [hl]
    ld hl, wPartyCount
    dec [hl]
    ld hl, wScriptStep
    inc [hl]
    jp SceneWatchOut_CreateMonsterRecordOfKindTemp1

; step 7 of SceneWatchOut: calls CopyGlyphTilesToVRAM; sets wScriptSubStep to 0; sets
; wScriptMsgSelect to 0; calls ShowBoxFromTable; calls SetBit1OfPlayerAndObjectFlags; advances
; wScriptStep (E-0347)
; why: step 7 of SceneWatchOut (when wScriptStep = 7); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_CopyGlyphTilesToVRAMAndStep::
    ld de, vTiles1 + $6e0
    call CopyGlyphTilesToVRAM
    xor a
    ld [wScriptSubStep], a
    ld [wScriptMsgSelect], a
    call ShowBoxFromTable
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneWatchOut: branches on wTextYesNoResult; calls
; ClearArg5IfAtOrAboveLimitForFarmLevel; branches on wArg5; calls StartMessageHL_B85; advances
; wScriptStep; branches on wPartyCount; calls StartMessageHL_B85; calls SaveScreenBufferToBGMap1;
; copies wPartyCount+1 to wScriptMsgSelect; sets wScriptStep to $11; calls StartMessageHL_B85;
; advances wScriptStep; then 2 more steps (see the code) (E-0347)
; why: step 2 of SceneWatchOut (when wScriptStep = 2); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ShowTheFarmHasNo::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b852
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .check_party_count
    ld hl, vTiles1 + $557
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .call_start_message_hl_b85
    ld hl, vTiles0 + $1b8
    call StartMessageHL_B85
    farcall SaveScreenBufferToBGMap1
    ld a, [wPartyCount]
    inc a
    ld [wScriptMsgSelect], a
    ld a, $11
    ld [wScriptStep], a
    ret

.call_start_message_hl_b85:
    ld hl, vTiles1 + $511
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b852:
    ld hl, vTiles1 + $512
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneWatchOut: sets wNameGlyphBuf to $1c; shows 'Hm, you are quite strong…'; advances
; wScriptStep; also changes HL and A by register arithmetic (E-0347)
; why: step 0 of SceneWatchOut (when wScriptStep = 0); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ShowHmYouAreQuite::
    ld a, $1c
    ld [wNameGlyphBuf], a
    ld [wTextBuf1 + $7], a
    ld a, $34
    ld [wNameGlyphBuf + $1], a
    ld [wTextBuf1 + $8], a
    ld a, $38
    ld [wNameGlyphBuf + $2], a
    ld [wTextBuf1 + $9], a
    ld a, $2c
    ld [wNameGlyphBuf + $3], a
    ld [wTextBuf1 + $a], a
    ld a, $3d
    ld [wNameGlyphBuf + $4], a
    ld [wTextBuf1 + $b], a
    ld a, $f0
    ld [wNameGlyphBuf + $5], a
    ld [wTextBuf1 + $c], a
    ld hl, MSG_KEEP_OPEN | $0d0f ; '*: Hm, you are quite strong…'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the
; scene its only script shows: 'King This should solve the water...' (creates a monster record);
; reached through ScriptCommand4D in bank $10 (E-0038, E-0245)
SceneWaterReward::
    ld a, [wScriptStep]
    jumptable
    dw SceneWaterReward_ShowCoohIHeardFrom
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWaterReward_ShowWaitTheFarmIs
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWatchOut_Msg_PickTheMonsterTo
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWaterReward_CopyGlyphTilesToVRAMAndStep
    dw SceneWatchOut_ToSceneWatchOut_ReadJoypadPressedAndFrameCounterLo
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWaterReward_StepObjectCoordByDirection16Frames
    dw SceneWaterReward_CreateMonsterRecordOfKindTemp1
    dw SceneWaterReward_RunMessageBoxFar_Bank85
    dw SceneWaterReward_ShowNHeadedOffTo
    dw SceneWatchOut_StepObjectCoordByDirection16Frames
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStep

; step 18 of SceneWatchOut: calls RunMessageBoxFar_Bank85; may return early; sets wScriptStep to $0e
; (E-0347)
; why: step 18 of SceneWatchOut (when wScriptStep = 18); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStep::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    ld a, $0e
    ld [wScriptStep], a
    ret

; step 17 of SceneWatchOut: calls StepObjectCoordByDirection16Frames; may return early; advances
; wScriptStep (E-0347)
; why: step 17 of SceneWatchOut (when wScriptStep = 17); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_StepObjectCoordByDirection16Frames::
    ld hl, wObject1 + OBJ_STATE
    call StepObjectCoordByDirection16Frames
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; step 16 of SceneWaterReward: sets hTemp1 to 0; copies wArg5 to hTemp2; sets hTemp3 to 1; calls
; CreateMonsterRecordOfKindTemp1; shows 'N headed off to the farm.'; decrements wSpriteSlotCount;
; decrements wScriptStep (E-0347)
; why: step 16 of SceneWaterReward (when wScriptStep = 16); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_ShowNHeadedOffTo::
    ld a, $00
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, MSG_KEEP_OPEN | $0d52 ; 'N headed off to the farm.'
    call StartMessageHL_B85
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, wScriptStep
    dec [hl]
    ret

; step 15 of SceneWaterReward: calls RunMessageBoxFar_Bank85; may return early; calls
; RestoreScreenBufferFromBGMap1; decrements wSpriteSlotCount; calls DrawFullScreenBufferAtScroll;
; calls ClearBit1OfPlayerAndObjectFlags; sets hSpriteWindowClipMode to 0; calls PlayMapMusic; sets
; EVENT_SCENE_WATER_REWARD; sets wScriptStartRequest to $80 (E-0347)
; why: step 15 of SceneWaterReward (when wScriptStep = 15); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_RunMessageBoxFar_Bank85::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    farcall RestoreScreenBufferFromBGMap1
    ld hl, wSpriteSlotCount
    dec [hl]
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall PlayMapMusic
    ld de, EVENT_SCENE_WATER_REWARD
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 14 of SceneWaterReward: sets hTemp1 to 0; copies wArg5 to hTemp2; sets hTemp3 to 2; calls
; CreateMonsterRecordOfKindTemp1; increments wPartyCount; calls MoveIncapacitatedPartyMembersBack;
; calls LoadRecordListNameTiles; calls LoadPlayerAndFollowerSpriteGraphics; sets
; wOBJPaletteUploadRequest to $7f; decrements wSpriteSlotCount; shows 'N joined the party.';
; advances wScriptStep (E-0347)
; why: step 14 of SceneWaterReward (when wScriptStep = 14); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_CreateMonsterRecordOfKindTemp1::
    ld a, $00
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $02
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, wPartyCount
    inc [hl]
    ld a, [wScriptMsgSelect]
    dec a
    ld c, a
    add a
    add a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wObject1 + OBJ_STATE]
    ld [hli], a
    ld a, [wObject1 + OBJ_X]
    ld [hli], a
    ld a, [wObject1 + OBJ_Y]
    ld [hl], a
    ld a, [wScriptMsgSelect]
    dec a
    ld hl, wPartyList
    add_a_to_hl
    ld a, [wArg5]
    ld [hl], a
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, MSG_KEEP_OPEN | $0d51 ; 'N joined the party.'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of SceneWaterReward: calls StepObjectCoordByDirection16Frames; may return early; calls
; RestoreScreenBufferFromBGMap1; calls DrawScreenBufferAtScrollOrigin; branches on wScriptMsgSelect;
; sets wScriptStep to $10; calls CopyRecordFields5DTo5BAnd61To5FAndMark; increments
; wScriptMsgSelect; decrements wPartyCount; advances wScriptStep; continues in
; SceneWaterReward_CreateMonsterRecordOfKindTemp1 (E-0347)
; why: step 13 of SceneWaterReward (when wScriptStep = 13); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_StepObjectCoordByDirection16Frames::
    ld hl, wObject1 + OBJ_STATE
    call StepObjectCoordByDirection16Frames
    or a
    ret z
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld a, [wScriptMsgSelect]
    cp $03
    jr nz, .call_copy_record_fields5_d_to5_b_and61_to5_f
    ld a, $10
    ld [wScriptStep], a
    ret

.call_copy_record_fields5_d_to5_b_and61_to5_f:
    push af
    call CopyRecordFields5DTo5BAnd61To5FAndMark
    pop af
    ld hl, wScriptMsgSelect
    inc [hl]
    ld hl, wPartyCount
    dec [hl]
    ld hl, wScriptStep
    inc [hl]
    jp SceneWaterReward_CreateMonsterRecordOfKindTemp1

; moves the object at HL one unit in direction [HL] (bytes 4/5); A = 1 after 16 steps, else 0
; (E-0125)
StepObjectCoordByDirection16Frames::
    ld a, [hl]
    or a
    jr nz, .skip
    ld a, $05
    add_a_to_hl
    inc [hl]
    jr .check_script_param0

.skip:
    dec a
    jr nz, .skip2
    ld a, $04
    add_a_to_hl
    inc [hl]
    jr .check_script_param0

.skip2:
    dec a
    jr nz, .skip3
    ld a, $05
    add_a_to_hl
    dec [hl]
    jr .check_script_param0

.skip3:
    ld a, $04
    add_a_to_hl
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $10
    jr z, .clear_script_param0
    xor a
    ret

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    ld a, $01
    ret

; step 10 of SceneWatchOut: branches on wScriptMsgSelect; advances wScriptStep; calls
; ScriptStepMoveFollowersToLeader (E-0347)
; why: step 10 of SceneWatchOut (when wScriptStep = 10); SceneWatchOut: implements script command
; type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows:
; 'You can keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ReadScriptMsgSelect::
    ld a, [wScriptMsgSelect]
    cp $03
    jr nz, .call_script_step_move_followers_to_leader
    ld hl, wScriptStep
    inc [hl]
    ret

.call_script_step_move_followers_to_leader:
    farcall ScriptStepMoveFollowersToLeader
    ret

; step 9 of SceneWatchOut: calls RestoreScreenBufferFromBGMap1; calls
; DrawScreenBufferAtScrollOrigin; calls StartMessageHL_B85; calls ClearBit1OfPlayerAndObjectFlags;
; sets wScriptStep to 1 (E-0347)
; why: step 9 of SceneWatchOut (when wScriptStep = 9); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ShowLetMeJoinYour::
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld hl, wKeyWorldBossMonsters + $6
    call StartMessageHL_B85
    farcall ClearBit1OfPlayerAndObjectFlags
    ld a, $01
    ld [wScriptStep], a
    ret

; step 8 of SceneWatchOut: calls SceneWatchOut_ReadJoypadPressedAndFrameCounterLo (E-0347)
; why: step 8 of SceneWatchOut (when wScriptStep = 8); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ToSceneWatchOut_ReadJoypadPressedAndFrameCounterLo::
    call SceneWatchOut_ReadJoypadPressedAndFrameCounterLo
    ret

; step 7 of SceneWaterReward: calls CopyGlyphTilesToVRAM; sets wScriptSubStep to 0; sets
; wScriptMsgSelect to 0; calls ShowBoxFromTable; calls SetBit1OfPlayerAndObjectFlags; advances
; wScriptStep (E-0347)
; why: step 7 of SceneWaterReward (when wScriptStep = 7); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_CopyGlyphTilesToVRAMAndStep::
    ld de, vTiles1 + $6e0
    call CopyGlyphTilesToVRAM
    xor a
    ld [wScriptSubStep], a
    ld [wScriptMsgSelect], a
    call ShowBoxFromTable
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneWatchOut: shows 'Pick the monster to go to'; advances wScriptStep (E-0347)
; why: step 5 of SceneWatchOut (when wScriptStep = 5); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_Msg_PickTheMonsterTo::
    ld hl, MSG_KEEP_OPEN | $0d50 ; 'Pick the monster to go to'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneWaterReward: branches on wTextYesNoResult; calls
; ClearArg5IfAtOrAboveLimitForFarmLevel; branches on wArg5; calls StartMessageHL_B85; advances
; wScriptStep; branches on wPartyCount; calls StartMessageHL_B85; calls SaveScreenBufferToBGMap1;
; copies wPartyCount+1 to wScriptMsgSelect; sets wScriptStep to $11; calls StartMessageHL_B85;
; advances wScriptStep; then 2 more steps (see the code) (E-0347)
; why: step 2 of SceneWaterReward (when wScriptStep = 2); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_ShowWaitTheFarmIs::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b852
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .check_party_count
    ld hl, vTiles1 + $555
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .call_start_message_hl_b85
    ld hl, vTiles0 + $1b8
    call StartMessageHL_B85
    farcall SaveScreenBufferToBGMap1
    ld a, [wPartyCount]
    inc a
    ld [wScriptMsgSelect], a
    ld a, $11
    ld [wScriptStep], a
    ret

.call_start_message_hl_b85:
    ld hl, vTiles0 + $1b9
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b852:
    ld hl, vTiles0 + $1ba
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneWaterReward: sets wNameGlyphBuf to $0b; shows 'Cooh, I heard from others'; advances
; wScriptStep; also changes HL and A by register arithmetic (E-0347)
; why: step 0 of SceneWaterReward (when wScriptStep = 0); SceneWaterReward: implements script
; command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script
; shows: 'King This ... (E-0352, E-0038, E-0245)
SceneWaterReward_ShowCoohIHeardFrom::
    ld a, $0b
    ld [wNameGlyphBuf], a
    ld [wTextBuf1 + $7], a
    ld a, $2c
    ld [wNameGlyphBuf + $1], a
    ld [wTextBuf1 + $8], a
    ld a, $2c
    ld [wNameGlyphBuf + $2], a
    ld [wTextBuf1 + $9], a
    ld a, $31
    ld [wNameGlyphBuf + $3], a
    ld [wTextBuf1 + $a], a
    ld a, $32
    ld [wNameGlyphBuf + $4], a
    ld [wTextBuf1 + $b], a
    ld a, $90
    ld [wNameGlyphBuf + $5], a
    ld a, $f0
    ld [wNameGlyphBuf + $6], a
    ld [wTextBuf1 + $c], a
    ld hl, MSG_KEEP_OPEN | $01b7 ; '*: Cooh, I heard from others'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; called from SceneWatchOut_ToSceneWatchOut_ReadJoypadPressedAndFrameCounterLo: branches on
; wJoypadPressed; advances wScriptStep; branches on wJoypadPressed; calls
; SceneWatchOut_WriteScriptMsgSelect; calls WriteVRAMByte; plays sound $69; advances wScriptStep;
; calls SceneWatchOut_WriteScriptMsgSelect; calls WriteVRAMByte; decrements wScriptMsgSelect; plays
; sound $69; calls SceneWatchOut_WriteScriptMsgSelect; then 6 more steps (see the code) (E-0347)
; why: a helper of SceneWatchOut_ToSceneWatchOut_ReadJoypadPressedAndFrameCounterLo, in step 8 of
; SceneWatchOut (when wScriptStep = 8); SceneWatchOut: implements script command type 2A
; (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_ReadJoypadPressedAndFrameCounterLo::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld hl, wScriptStep
    inc [hl]
    ret

.check_bit0:
    bit 0, a
    jr z, .check_bit6
    call SceneWatchOut_WriteScriptMsgSelect
    ld a, $bc
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.check_bit6:
    bit 6, a
    jr z, .check_bit7
    call SceneWatchOut_WriteScriptMsgSelect
    ld a, $c3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    dec [hl]
    ld a, $69
    call QueueSoundEffect
    jr .call_scene_watch_out_write_script_msg_select

.check_bit7:
    bit 7, a
    jr z, .call_scene_watch_out_write_script_msg_select
    call SceneWatchOut_WriteScriptMsgSelect
    ld a, $c3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    inc [hl]
    ld a, $69
    call QueueSoundEffect

.call_scene_watch_out_write_script_msg_select:
    call SceneWatchOut_WriteScriptMsgSelect
    ld c, $bb
    ld a, [wFrameCounterLo]
    bit 3, a
    jr z, .call_write_vram_byte
    ld c, $c3

.call_write_vram_byte:
    ld a, c
    call WriteVRAMByte
    ret

; Copies wScriptMsgSelect & $03 to wScriptMsgSelect; also changes HL, A and C by register arithmetic
; (E-0347)
; why: part of SceneWatchOut; SceneWatchOut: implements script command type 2A
; (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_WriteScriptMsgSelect::
    ld a, [wScriptMsgSelect]
    and $03
    ld [wScriptMsgSelect], a
    swap a
    add $08
    ld c, a
    ldh a, [hScrollY]
    add c
    and $f8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, h
    and $9b
    ld h, a
    ldh a, [hScrollX]
    add $08
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; saves the screen buffer to vBGMap1, copies the 8 x 9 box $4583 to wScreenTileBuffer (clearing CGB
; attributes), draws it and plays sound $6C (E-0125) (E-0344: the address in its name dropped or
; read as the label there; was ShowBoxFromTable)
ShowBoxFromTable::
    farcall SaveScreenBufferToBGMap1
    ld hl, wScreenTileBuffer
    ld de, ShowBoxFromTable_TileRect
    ld b, $09

.loop:
    push hl
    ld c, $08

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec c
    jr nz, .loop2
    pop hl
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, .loop
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_screen_buffer_at_scroll_origin
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    ld b, $09

.loop3:
    push hl
    ld c, $08

.loop4:
    xor a
    ld [hli], a
    dec c
    jr nz, .loop4
    pop hl
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, .loop3
    xor a
    ldh [rSVBK], a

.call_draw_screen_buffer_at_scroll_origin:
    call DrawScreenBufferAtScrollOrigin
    ld a, $6c
    call QueueSoundEffect
    ret

; draws the screen buffer at the BG map address of the scroll position
; (DrawScreenBufferToBGMapWithAttrs) (E-0125)
DrawScreenBufferAtScrollOrigin::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .call_draw_screen_buffer_to_bg_map_with_attrs
    inc d

.call_draw_screen_buffer_to_bg_map_with_attrs:
    ld l, e
    ld h, d
    call DrawScreenBufferToBGMapWithAttrs
    ret

; no reference found; the bytes form an 8 x 9 window frame ($B0 $B1.. $B2 top, $B6/$B7 sides with
; $E1-$E3 in the left column of rows 1, 3 and 5, $B3 $B4.. $B5 bottom), after the ret of the routine
; that ends at $4582 (E-0239, C1)
; record: 8 x 9 tiles, one row per line
ShowBoxFromTable_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $e1, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $e2, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $e3, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $ee, $ef, $f0, $f1, $f2, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; for record wPartyList[A]: field $5B = word field $5D, field $5F = word field $61, field $55 = 0,
; field 0 = 1 (E-0121)
CopyRecordFields5DTo5BAnd61To5FAndMark::
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
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
    push af
    ld c, MON_STATUS
    call SRAMRecordAddress
    xor a
    ld [hl], a
    pop af
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a
    ld [rRAMG], a
    ret

; implements script command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the
; scene its only script shows: 'C'mon, Warubou!' ... 'Have you heard about Magic Keys?'; reached
; through ScriptCommand1B in bank $10 (E-0038, E-0245)
SceneWarubouLeaves::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouLeaves_StepObjectTowardCoord
    dw SceneWarubouLeaves_StepObjectTowardCoord_SetStepPtrHi_3
    dw SceneWarubouLeaves_StepObjectTowardCoord_SetStepPtrHi_2
    dw SceneWarubouLeaves_StepObjectTowardCoord_SetStepPtrHi

; step 3 of SceneWarubouLeaves: sets wStepPtrHi to 1; sets wStepTarget to 3; sets wStepPtrLo to $e0;
; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepTarget to 3; sets wStepPtrLo to $e0;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wScriptStartRequest to $80
; (E-0347)
; why: step 3 of SceneWarubouLeaves (when wScriptStep = 3); SceneWarubouLeaves: implements script
; command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the scene its only
; script shows: 'C'mon, ... (E-0352, E-0038, E-0245)
SceneWarubouLeaves_StepObjectTowardCoord_SetStepPtrHi::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 2 of SceneWarubouLeaves: sets wStepPtrHi to 1; sets wStepTarget to 3; sets wStepPtrLo to $e0;
; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepTarget to 2; sets wStepPtrLo to $20;
; calls StepObjectTowardCoord; continues in
; SceneWarubouLeaves_StepObjectTowardCoord_CheckStepArrived (E-0347)
; why: step 2 of SceneWarubouLeaves (when wScriptStep = 2); SceneWarubouLeaves: implements script
; command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the scene its only
; script shows: 'C'mon, ... (E-0352, E-0038, E-0245)
SceneWarubouLeaves_StepObjectTowardCoord_SetStepPtrHi_2::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr SceneWarubouLeaves_StepObjectTowardCoord_CheckStepArrived

; step 1 of SceneWarubouLeaves: sets wStepPtrHi to 2; sets wStepTarget to 2; sets wStepPtrLo to $30;
; calls StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget to 2; sets wStepPtrLo to $20;
; calls StepObjectTowardCoord; continues in
; SceneWarubouLeaves_StepObjectTowardCoord_CheckStepArrived (E-0347)
; why: step 1 of SceneWarubouLeaves (when wScriptStep = 1); SceneWarubouLeaves: implements script
; command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the scene its only
; script shows: 'C'mon, ... (E-0352, E-0038, E-0245)
SceneWarubouLeaves_StepObjectTowardCoord_SetStepPtrHi_3::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr SceneWarubouLeaves_StepObjectTowardCoord_CheckStepArrived

; step 0 of SceneWarubouLeaves: sets wStepPtrHi to 1; sets wStepTarget to 2; sets wStepPtrLo to $50;
; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepTarget to 3; sets wStepPtrLo to $40;
; calls StepObjectTowardCoord (E-0347)
; why: step 0 of SceneWarubouLeaves (when wScriptStep = 0); SceneWarubouLeaves: implements script
; command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the scene its only
; script shows: 'C'mon, ... (E-0352, E-0038, E-0245)
SceneWarubouLeaves_StepObjectTowardCoord::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

; Returns if wStepArrived is 0; advances wScriptStep (E-0347)
; why: part of SceneWarubouLeaves_StepObjectTowardCoord, in step 0 of SceneWarubouLeaves (when
; wScriptStep = 0); SceneWarubouLeaves: implements script command type 1B
; (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the scene its only script shows:
; 'C'mon, ... (E-0352, E-0038, E-0245)
SceneWarubouLeaves_StepObjectTowardCoord_CheckStepArrived::
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7A (SCRIPT_SCENE_KAMEHA_MISSING): a cutscene step named after the
; scene its only script shows: before 'Prince Kameha has been missing from...'; reached through
; ScriptCommand7A in bank $10 (E-0038, E-0245)
SceneKamehaMissing::
    ld a, [wScriptStep]
    or a
    jr nz, .check_script_param0
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $10
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $28
    ret nz
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 78 (SCRIPT_SAVE_SCREEN): saves the screen buffer to BG map 1
; (SaveScreenBufferToBGMap1); reached through ScriptCommand78 in bank $10 (E-0038, E-0245)
SaveScreen::
    ld a, [wScriptStep]
    jumptable
    dw SaveScreen_BufferToBGMap1
    dw SaveScreen_SetScriptStartRequestTo80

; step 1 of SaveScreen: sets wScriptStartRequest to $80 (E-0347)
; why: step 1 of SaveScreen (when wScriptStep = 1); SaveScreen: implements script command type 78
; (SCRIPT_SAVE_SCREEN): saves the screen buffer to BG map 1 (SaveScreenBufferToBGMap1) (E-0352,
; E-0038, E-0245)
SaveScreen_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of SaveScreen: calls SaveScreenBufferToBGMap1; sets wFieldReturnPhase to 1; sets wGameMode
; to 2; sets wModeState to $0c; sets wWorldMapState to 0; sets wTemp0 to 0; sets wTemp1 to 0; sets
; wJoypadHeld to 0; sets wJoypadPressed to 0; sets wScriptRunning to 0; advances wScriptStep
; (E-0347)
; why: step 0 of SaveScreen (when wScriptStep = 0); SaveScreen: implements script command type 78
; (SCRIPT_SAVE_SCREEN): saves the screen buffer to BG map 1 (SaveScreenBufferToBGMap1) (E-0352,
; E-0038, E-0245)
SaveScreen_BufferToBGMap1::
    farcall SaveScreenBufferToBGMap1
    ld a, $01
    ld [wFieldReturnPhase], a
    ld a, $02
    ld [wGameMode], a
    ld a, $0c
    ld [wModeState], a
    xor a
    ld [wWorldMapState], a
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    xor a
    ld [wScriptRunning], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7D (SCRIPT_SCENE_THIS_WAY): a cutscene step named after the scene
; its only script shows: 'This way Here Here' ... 'I heard from Lord Darck, but...'; reached through
; ScriptCommand7D in bank $10 (E-0038, E-0245)
SceneThisWay::
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hMapScreenY]
    cp $02
    ret z
    ld de, SceneThisWay_Data1
    or a
    jr z, .read_map_screen_x
    ld de, SceneThisWay_Data2

.read_map_screen_x:
    ldh a, [hMapScreenX]
    add a
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld hl, wSpriteSlots + $7

.skip2:
    ld a, [de]
    cp $ff
    ret z
    ld [hl], a
    ld a, $10
    add_a_to_hl
    inc de
    jr .skip2

; data read by SceneThisWay (12 bytes) (E-0347)
SceneThisWay_Data1::
    db $00, $00, $01, $ff, $00, $ff, $ff, $ff, $03, $01, $00, $ff

SceneThisWay_Data2::
    db $01, $03, $02, $ff, $01, $ff, $ff, $ff, $02, $02, $01, $ff

; implements script command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the
; scene its only script shows: '0 checked the treasure chest.' ... 'How may we serve your
; mortal...'; reached through ScriptCommand7F in bank $10 (E-0038, E-0245)
SceneChestServant::
    ld a, [wScriptStep]
    jumptable
    dw SceneChestServant_QueueSoundEffectAndStep
    dw SceneChestServant_StepPlayerUpTowardStepPtrLo
    dw SceneChestServant_StepPlayerUpTowardStepPtrLo
    dw SceneChestServant_StepPlayerUpTowardStepPtrLo
    dw SceneChestServant_ScriptStartFadeAndAdvanceStep
    dw SceneChestServant_SetScriptStartRequestTo80

; step 5 of SceneChestServant: sets wScriptStartRequest to $80 (E-0347)
; why: step 5 of SceneChestServant (when wScriptStep = 5); SceneChestServant: implements script
; command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the scene its only
; script shows: '0 checked the ... (E-0352, E-0038, E-0245)
SceneChestServant_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 4 of SceneChestServant: sets hPlayerX to $e0; sets hFieldDrawFlags to 0; sets hMapId to $48;
; sets hMapScreenX to 8; sets hMapScreenY to 7; sets wWarpDestX to $40; sets wWarpDestY to $40; sets
; wFieldTransitionKind to 1; calls ScriptStartFadeAndAdvanceStep (E-0347)
; why: step 4 of SceneChestServant (when wScriptStep = 4); SceneChestServant: implements script
; command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the scene its only
; script shows: '0 checked the ... (E-0352, E-0038, E-0245)
SceneChestServant_ScriptStartFadeAndAdvanceStep::
    ld a, $e0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $48
    ldh [hMapId], a
    ld a, $08
    ldh [hMapScreenX], a
    ld a, $07
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; step 1 of SceneChestServant: sets wStepPtrLo; calls StepPlayerUpTowardStepPtrLo; returns if
; wStepArrived is 0; sets hFieldDrawFlags; increments wScriptParam0; advances wScriptStep (E-0347)
; why: step 1 of SceneChestServant (when wScriptStep = 1); SceneChestServant: implements script
; command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the scene its only
; script shows: '0 checked the ... (E-0352, E-0038, E-0245)
SceneChestServant_StepPlayerUpTowardStepPtrLo::
    ld a, [wScriptParam0]
    swap a
    ld c, a
    ld a, $10
    sub c
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ldh a, [hFieldDrawFlags]
    add a
    or $01
    ldh [hFieldDrawFlags], a
    ld hl, wScriptParam0
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneChestServant: plays sound $65; sets hFieldDrawFlags to 1; sets wScriptParam0 to 0;
; advances wScriptStep (E-0347)
; why: step 0 of SceneChestServant (when wScriptStep = 0); SceneChestServant: implements script
; command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the scene its only
; script shows: '0 checked the ... (E-0352, E-0038, E-0245)
SceneChestServant_QueueSoundEffectAndStep::
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7E (SCRIPT_SCENE_GOT_TO): a cutscene step named after the scene its
; only script shows: 'That's true I've got to...'; reached through ScriptCommand7E in bank $10
; (E-0038, E-0245)
SceneGotTo::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 3, a
    jr z, .set_object5_to_80
    jr .clear_object5

.cp_3C:
    cp $3c
    jr nc, .check_bit1
    bit 2, a
    jr z, .set_object5_to_80
    jr .clear_object5

.check_bit1:
    bit 1, a
    jr z, .set_object5_to_80
    jr .clear_object5

.set_object5_to_80:
    ld a, $80
    ld [wObject5], a
    jr .check_script_param0

.clear_object5:
    xor a
    ld [wObject5], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 74 (SCRIPT_SET_FLAG_REDRAW): sets a story flag, applies the
; map-screen flag events and redraws the screen (treasure chests); reached through ScriptCommand74
; in bank $10 (E-0038, E-0245)
SetFlagRedraw::
    ld b, $00
    ldh a, [hPlayerX]
    ld c, a
    ldh a, [hPlayerFacing]
    cp $01
    jr z, .skip
    cp $03
    jr z, .skip2
    jr .skip3

.skip:
    ld a, c
    add $10
    ld c, a
    jr .skip3

.skip2:
    ld a, c
    sub $10
    ld c, a

.skip3:
    ld hl, SetFlagRedraw_Data

.skip4:
    ld a, [hl]
    cp c
    jr z, .skip5
    inc hl
    inc b
    jr .skip4

.skip5:
    ld de, $01cf
    ld a, b
    add e
    ld e, a
    jr nc, .call_set_flag_bit
    inc d

.call_set_flag_bit:
    call SetFlagBit
    farcall ApplyMapScreenFlagEvents
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by SetFlagRedraw (4 bytes) (E-0347)
SetFlagRedraw_Data::
    db $20, $40, $50, $80

; implements script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2): a cutscene step named after
; the scene its only script shows: the same scene as SCRIPT_SCENE_KAMEHA_KEY_BATTLE; reached through
; ScriptCommand72 in bank $10 (E-0038, E-0245)
SceneKamehaKeyBattle2::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaKeyBattle2_StartScriptedEncounterTemp0AndStep
    dw SceneKamehaKeyBattle2_SetFlagBit
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 3 of SceneKamehaKeyBattle2: branches on wScriptParam0; shows '0 received the Magic Key.';
; advances wScriptStep (E-0347)
; why: step 3 of SceneKamehaKeyBattle2 (when wScriptStep = 3); SceneKamehaKeyBattle2: implements
; script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2): a cutscene step named after the scene
; its only script shows: the same ... (E-0352, E-0038, E-0245)
SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic::
    ld hl, $0b9d
    ld a, [wScriptParam0]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, $0bc2 ; '0 received the Magic Key.'

.call_start_message_hl_b85:
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneKamehaKeyBattle2: branches on wBattleScene; sets EVENT_SCENE_KAMEHA_KEY_BATTLE2;
; sets hTemp0 to 9; calls KeyListHasKindTemp0; branches on hTemp0; calls CountKeysOrFull; branches
; on hTemp0; shows 'Kameha: That was a good warmup!'; sets wScriptStep to 4; sets hTemp1 to 9;
; checks EVENT_KEY_BOSS_BEATEN_2_205; sets hTemp1 to $49; then 10 more steps (see the code) (E-0347)
; why: step 1 of SceneKamehaKeyBattle2 (when wScriptStep = 1); SceneKamehaKeyBattle2: implements
; script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2): a cutscene step named after the scene
; its only script shows: the same ... (E-0352, E-0038, E-0245)
SceneKamehaKeyBattle2_SetFlagBit::
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b85
    ld de, EVENT_SCENE_KAMEHA_KEY_BATTLE2
    call SetFlagBit
    ld a, $09
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_09

.loop:
    ld hl, $0b9e ; 'Kameha: That was a good warmup!'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

.set_temp1_to_09:
    ld a, $09
    ldh [hTemp1], a
    ld de, EVENT_KEY_BOSS_BEATEN_2_205
    call TestFlagBit
    jr nc, .call_write_key_entry_temp0
    ld a, $49
    ldh [hTemp1], a

.call_write_key_entry_temp0:
    farcall WriteKeyEntryTemp0
    ld a, $01
    ld [wScriptParam0], a
    jr .call_set_flag_bit

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .loop
    xor a
    ld [wScriptParam0], a

.call_set_flag_bit:
    ld de, EVENT_HERO_RECEIVED_THE_TRAVELER_KEY
    call SetFlagBit
    ld hl, $0b9c ; 'Kameha: That was a good warmup!'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, $0b97 ; 'Kameha: Wahahahah! You're weak! You're a'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

; step 0 of SceneKamehaKeyBattle2: sets hTemp0 to $30; calls StartScriptedEncounterTemp0; advances
; wScriptStep (E-0347)
; why: step 0 of SceneKamehaKeyBattle2 (when wScriptStep = 0); SceneKamehaKeyBattle2: implements
; script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2): a cutscene step named after the scene
; its only script shows: the same ... (E-0352, E-0038, E-0245)
SceneKamehaKeyBattle2_StartScriptedEncounterTemp0AndStep::
    ld a, $30
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE): a cutscene step named after
; the scene its only script shows: 'Kameha So you're confident, huh?' (key entry and encounter);
; reached through ScriptCommand71 in bank $10 (E-0038, E-0245)
SceneKamehaKeyBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaKeyBattle_StartScriptedEncounterTemp0AndStep
    dw SceneKamehaKeyBattle_SetFlagBit
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneKamehaKeyBattle_ShowHeroReceivedTheMagic
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 3 of SceneKamehaKeyBattle: branches on wScriptParam0; shows '0 received the Magic Key.';
; advances wScriptStep (E-0347)
; why: step 3 of SceneKamehaKeyBattle (when wScriptStep = 3); SceneKamehaKeyBattle: implements
; script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE): a cutscene step named after the scene its
; only script shows: 'Kameha So ... (E-0352, E-0038, E-0245)
SceneKamehaKeyBattle_ShowHeroReceivedTheMagic::
    ld hl, $0b93
    ld a, [wScriptParam0]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, $0bc2 ; '0 received the Magic Key.'

.call_start_message_hl_b85:
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneKamehaKeyBattle: branches on wBattleScene; sets EVENT_SCENE_KAMEHA_KEY_BATTLE; sets
; hTemp0 to 7; calls KeyListHasKindTemp0; branches on hTemp0; calls CountKeysOrFull; branches on
; hTemp0; shows 'Kameha: Well, uh, luck and status'; sets wScriptStep to 4; sets hTemp1 to 7; checks
; EVENT_KEY_BOSS_BEATEN_203; sets hTemp1 to $47; then 10 more steps (see the code) (E-0347)
; why: step 1 of SceneKamehaKeyBattle (when wScriptStep = 1); SceneKamehaKeyBattle: implements
; script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE): a cutscene step named after the scene its
; only script shows: 'Kameha So ... (E-0352, E-0038, E-0245)
SceneKamehaKeyBattle_SetFlagBit::
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b85
    ld de, EVENT_SCENE_KAMEHA_KEY_BATTLE
    call SetFlagBit
    ld a, $07
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a
    jr nz, .call_generate_new_key_entry
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, .set_temp1_to_07

.loop:
    ld hl, $0b94 ; 'Kameha: Well, uh, luck and status'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

.set_temp1_to_07:
    ld a, $07
    ldh [hTemp1], a
    ld de, EVENT_KEY_BOSS_BEATEN_203
    call TestFlagBit
    jr nc, .call_write_key_entry_temp0
    ld a, $47
    ldh [hTemp1], a

.call_write_key_entry_temp0:
    farcall WriteKeyEntryTemp0
    ld a, $01
    ld [wScriptParam0], a
    jr .call_set_flag_bit

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .loop
    xor a
    ld [wScriptParam0], a

.call_set_flag_bit:
    ld de, EVENT_HERO_RECEIVED_THE_ELF_KEY
    call SetFlagBit
    ld hl, $0b92 ; 'Kameha: Well, uh, luck and status'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, $0b97 ; 'Kameha: Wahahahah! You're weak! You're a'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

; step 0 of SceneKamehaKeyBattle: sets hTemp0 to $2f; calls StartScriptedEncounterTemp0; advances
; wScriptStep (E-0347)
; why: step 0 of SceneKamehaKeyBattle (when wScriptStep = 0); SceneKamehaKeyBattle: implements
; script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE): a cutscene step named after the scene its
; only script shows: 'Kameha So ... (E-0352, E-0038, E-0245)
SceneKamehaKeyBattle_StartScriptedEncounterTemp0AndStep::
    ld a, $2f
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7B (SCRIPT_SCENE_ARENA_CHALLENGE): a cutscene step named after the
; scene its only script shows: 'Really? Let's go to the Arena!' (encounter); reached through
; ScriptCommand7B in bank $10 (E-0038, E-0245)
SceneArenaChallenge::
    ld a, [wScriptStep]
    jumptable
    dw SceneArenaChallenge_StartScriptedEncounterTemp0AndStep
    dw SceneArenaChallenge_ShowAwwILoseYou
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 1 of SceneArenaChallenge: advances wScriptStep; branches on wBattleScene; shows 'Aww… I lose.
; You are'; shows 'Yay! I won! Am I' (E-0347)
; why: step 1 of SceneArenaChallenge (when wScriptStep = 1); SceneArenaChallenge: implements script
; command type 7B (SCRIPT_SCENE_ARENA_CHALLENGE): a cutscene step named after the scene its only
; script shows: 'Really? ... (E-0352, E-0038, E-0245)
SceneArenaChallenge_ShowAwwILoseYou::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, $0d82 ; '*: Aww… I lose. You are'
    call StartMessageHL_B85
    ret

.call_start_message_hl_b85:
    ld hl, $0d83 ; '*: Yay! I won! Am I'
    call StartMessageHL_B85
    ret

; step 0 of SceneArenaChallenge: sets hTemp0 to $15; calls StartScriptedEncounterTemp0; advances
; wScriptStep (E-0347)
; why: step 0 of SceneArenaChallenge (when wScriptStep = 0); SceneArenaChallenge: implements script
; command type 7B (SCRIPT_SCENE_ARENA_CHALLENGE): a cutscene step named after the scene its only
; script shows: 'Really? ... (E-0352, E-0038, E-0245)
SceneArenaChallenge_StartScriptedEncounterTemp0AndStep::
    ld a, $15
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7C (SCRIPT_SCENE_TERRY_BATTLE): a cutscene step named after the
; scene its only script shows: 'Terry Humph Confident, huh?' (encounter); reached through
; ScriptCommand7C in bank $10 (E-0038, E-0245)
SceneTerryBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneTerryBattle_SetFlagBitAndStep
    dw SceneTerryBattle_ShowTerryWellThisProves
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 1 of SceneTerryBattle: advances wScriptStep; branches on wBattleScene; shows 'Terry: Well,
; this proves that I'; sets wLinkSetting to 1; sets EVENT_SCENE_TERRY_BATTLE_038; shows 'Terry:
; Humph… Don't take it hard.' (E-0347)
; why: step 1 of SceneTerryBattle (when wScriptStep = 1); SceneTerryBattle: implements script
; command type 7C (SCRIPT_SCENE_TERRY_BATTLE): a cutscene step named after the scene its only script
; shows: 'Terry Humph ... (E-0352, E-0038, E-0245)
SceneTerryBattle_ShowTerryWellThisProves::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, $0bb1 ; 'Terry: Well, this proves that I'
    call StartMessageHL_B85
    ld a, $01
    ld [wLinkSetting], a
    ld de, EVENT_SCENE_TERRY_BATTLE_038
    call SetFlagBit
    ret

.call_start_message_hl_b85:
    ld hl, $0bb2 ; 'Terry: Humph… Don't take it hard.'
    call StartMessageHL_B85
    ret

; step 0 of SceneTerryBattle: sets EVENT_SCENE_TERRY_BATTLE; sets hTemp0 to $14; calls
; StartScriptedEncounterTemp0; advances wScriptStep (E-0347)
; why: step 0 of SceneTerryBattle (when wScriptStep = 0); SceneTerryBattle: implements script
; command type 7C (SCRIPT_SCENE_TERRY_BATTLE): a cutscene step named after the scene its only script
; shows: 'Terry Humph ... (E-0352, E-0038, E-0245)
SceneTerryBattle_SetFlagBitAndStep::
    ld de, EVENT_SCENE_TERRY_BATTLE
    call SetFlagBit
    ld a, $14
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 70 (SCRIPT_SCENE_TERRY): a cutscene step named after the scene its
; only script shows: '0 obtained the Magic Key.' ... 'Humph I'm Terry. I'm a master'; reached
; through ScriptCommand70 in bank $10 (E-0038, E-0245)
SceneTerry::
    ld a, [wScriptStep]
    or a
    jr z, .clear_map_screen_x
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_map_screen_x:
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    ldh a, [hPlayerX]
    cp $20
    jr nz, .call_test_flag_bit
    ld a, $0f
    ldh [hMapId], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .set_warp_dest_x_to_20
    ld a, $20
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

.set_warp_dest_x_to_20:
    ld a, $20
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

.call_test_flag_bit:
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .set_map_id_to_0F
    ld a, $10
    ldh [hMapId], a
    ld a, $70
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

.set_map_id_to_0F:
    ld a, $0f
    ldh [hMapId], a
    ld a, $70
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

; implements script command type 6F (SCRIPT_DESK_KEY): the desk animation before '0 obtained the
; Brawn/Baffle/Soul/Magic Key.'; reached through ScriptCommand6F in bank $10 (E-0038, E-0245)
DeskKey::
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    ld hl, wObject1 + OBJ_Y
    inc [hl]
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the
; scene its only script shows: the same scene as SCRIPT_SCENE_LIMBO_MONSTER; reached through
; ScriptCommand6E in bank $10 (E-0038, E-0245)
SceneLimboMonster2::
    ld a, [wScriptStep]
    jumptable
    dw SceneLimboMonster2_ShowWarubouWaheyIWas
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster2_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_AddStepDeltaToPointedByte
    dw SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster2_StepObjectTowardCoord
    dw SceneLimboMonster2_StepObjectTowardCoord_SetFieldDrawFlags

; step 15 of SceneLimboMonster2: sets hFieldDrawFlags to 0; sets wStepTarget to 1; sets wStepPtrHi
; to 1; sets wStepPtrLo to $c0; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets
; hTemp1 to 3; copies wArg5 to hTemp2; sets hTemp3 to 1; calls CreateMonsterRecordOfKindTemp1; sets
; EVENT_SCENE_LIMBO_MONSTER2; sets wScriptStartRequest to $80 (E-0347)
; why: step 15 of SceneLimboMonster2 (when wScriptStep = 15); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_StepObjectTowardCoord_SetFieldDrawFlags::
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $c0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $03
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld de, EVENT_SCENE_LIMBO_MONSTER2
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 14 of SceneLimboMonster2: sets wStepPtrHi to 1; branches on wScriptParam0; sets wStepTarget
; to 1; sets wStepPtrLo to $70; calls StepObjectTowardCoord; returns if wStepArrived is 0;
; increments wScriptParam0; sets wStepTarget to 0; sets wStepPtrLo to $40; calls
; StepObjectTowardCoord; returns if wStepArrived is 0; sets wScriptParam0 to 0; then 1 more step
; (see the code) (E-0347)
; why: step 14 of SceneLimboMonster2 (when wScriptStep = 14); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_StepObjectTowardCoord::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_target_to_00
    ld a, $01
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_target_to_00:
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 12 of SceneLimboMonster2: shows 'Warubou: Wa-hey, my kid has a'; advances wScriptStep
; (E-0347)
; why: step 12 of SceneLimboMonster2 (when wScriptStep = 12); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid::
    ld hl, $0ba7 ; 'Warubou: Wa-hey, my kid has a'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of SceneLimboMonster2: calls ScriptStepAdjust32TimesThenMessage_Bank85 (E-0347)
; why: step 9 of SceneLimboMonster2 (when wScriptStep = 9); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85::
    ld de, wObject2 + OBJ_Y
    ld hl, $0ba6
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; step 3 of SceneLimboMonster2: branches on wTextYesNoResult; calls StartMessageHL_B85; copies the
; byte at SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data to wObject2 + OBJ_X; copies the byte at
; SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data to wObject2 + OBJ_Y; advances wScriptStep; calls
; StartMessageHL_B85; sets wScriptStep to 1 (E-0347)
; why: step 3 of SceneLimboMonster2 (when wScriptStep = 3); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_ShowWarubouWaheyGoodGood::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, vTiles1 + $3a5
    call StartMessageHL_B85
    ld a, [wObject1 + OBJ_STATE]
    add a
    ld hl, SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data
    add_a_to_hl
    ld a, [hli]
    ld [wObject2 + OBJ_X], a
    ld a, [hl]
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, vTiles1 + $595
    call StartMessageHL_B85
    ld a, $01
    ld [wScriptStep], a
    ret

; data read by SceneLimboMonster2 (8 bytes) (E-0347)
SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data::
    db $d0, $10, $c0, $20, $d0, $30, $e0, $20

; step 0 of SceneLimboMonster2: calls ClearArg5IfAtOrAboveLimitForFarmLevel; branches on wArg5;
; shows 'Warubou: Wa-hey! I was thinking… GreatLog'; advances wScriptStep; shows 'Warubou: Wa-hey! I
; was thinking… GreatLog'; sets wScriptStep to 2 (E-0347)
; why: step 0 of SceneLimboMonster2 (when wScriptStep = 0); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_ShowWarubouWaheyIWas::
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .call_start_message_hl_b85
    ld hl, $0ba3 ; 'Warubou: Wa-hey! I was thinking… GreatLog'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, MSG_KEEP_OPEN | $0ba4 ; 'Warubou: Wa-hey! I was thinking… GreatLog'
    call StartMessageHL_B85
    ld a, $02
    ld [wScriptStep], a
    ret

; implements script command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the
; scene its only script shows: 'Limbo is the King's domain!' ... 'Prince Kameha has been missing'
; (creates a monster record); reached through ScriptCommand6D in bank $10 (E-0038, E-0245)
SceneLimboMonster::
    ld a, [wScriptStep]
    jumptable
    dw SceneLimboMonster_ShowWarubouWaheyIHave
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_AddStepDeltaToPointedByte
    dw SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimboMonster_AddStepDeltaToPointedByte
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 12 of SceneLimboMonster: branches on wScriptParam0; plays sound $65; sets wScriptParam0;
; copies E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; sets
; wScriptParam0; copies wObject2 + OBJ_STATE & $03 to wObject2 + OBJ_STATE; decrements wObject2 +
; OBJ_X; increments wScriptParam0; returns unless wScriptParam0 is $40; shows 'Warubou: Wa-hey, my
; kid has a'; then 8 more steps (see the code) (E-0347)
; why: step 12 of SceneLimboMonster (when wScriptStep = 12); SceneLimboMonster: implements script
; command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the scene its only
; script shows: 'Limbo is the ... (E-0352, E-0038, E-0245)
SceneLimboMonster_AddStepDeltaToPointedByte::
    ld a, [wScriptParam0]
    or a
    jr nz, .read_script_param0
    ld a, $65
    call QueueSoundEffect

.read_script_param0:
    ld a, [wScriptParam0]
    push af
    sra a
    ld [wScriptParam0], a
    ld de, wObject2 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_object2
    ld a, [wObject2 + OBJ_STATE]
    inc a
    and $03
    ld [wObject2 + OBJ_STATE], a

.check_object2:
    ld a, [wObject2 + OBJ_X]
    dec a
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $40
    ret nz
    ld hl, $0b2c ; 'Warubou: Wa-hey, my kid has a'
    call StartMessageHL_B85
    ld a, $04
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld de, EVENT_SCENE_LIMBO_MONSTER
    call SetFlagBit
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of SceneLimboMonster: calls ScriptStepAdjust32TimesThenMessage_Bank85 (E-0347)
; why: step 9 of SceneLimboMonster (when wScriptStep = 9); SceneLimboMonster: implements script
; command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the scene its only
; script shows: 'Limbo is the ... (E-0352, E-0038, E-0245)
SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85::
    ld de, wObject2 + OBJ_Y
    ld hl, $0b2b
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; step 8 of SceneLimboMonster2: sets hFieldDrawFlags to $0e; branches on wScriptParam0; plays sound
; $65; sets wScriptParam0; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; sets wScriptParam0; copies wObject2 + OBJ_STATE & $03 to wObject2 +
; OBJ_STATE; increments wObject2 + OBJ_X; increments wScriptParam0; returns unless wScriptParam0 is
; $40; then 4 more steps (see the code) (E-0347)
; why: step 8 of SceneLimboMonster2 (when wScriptStep = 8); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_AddStepDeltaToPointedByte::
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld a, [wScriptParam0]
    or a
    jr nz, .read_script_param0
    ld a, $65
    call QueueSoundEffect

.read_script_param0:
    ld a, [wScriptParam0]
    push af
    sra a
    ld [wScriptParam0], a
    ld de, wObject2 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_object2
    ld a, [wObject2 + OBJ_STATE]
    inc a
    and $03
    ld [wObject2 + OBJ_STATE], a

.check_object2:
    ld a, [wObject2 + OBJ_X]
    inc a
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $40
    ret nz
    ld a, $72
    call QueueSoundEffect
    ld a, [wObject1 + OBJ_STATE]
    ld [wObject2 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneLimboMonster2: calls ScriptStepMoveFollowersToLeader (E-0347)
; why: step 5 of SceneLimboMonster2 (when wScriptStep = 5); SceneLimboMonster2: implements script
; command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only
; script shows: the same ... (E-0352, E-0038, E-0245)
SceneLimboMonster2_ToScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ret

; step 3 of SceneLimboMonster: branches on wTextYesNoResult; calls StartMessageHL_B85; copies the
; byte at SceneLimboMonster_ShowWarubouWaheyGoodGood_Data to wObject2 + OBJ_X; copies the byte at
; SceneLimboMonster_ShowWarubouWaheyGoodGood_Data to wObject2 + OBJ_Y; advances wScriptStep; calls
; StartMessageHL_B85; sets wScriptStep to 1 (E-0347)
; why: step 3 of SceneLimboMonster (when wScriptStep = 3); SceneLimboMonster: implements script
; command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the scene its only
; script shows: 'Limbo is the ... (E-0352, E-0038, E-0245)
SceneLimboMonster_ShowWarubouWaheyGoodGood::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, vTiles1 + $32a
    call StartMessageHL_B85
    ld a, [wObject1 + OBJ_STATE]
    add a
    ld hl, SceneLimboMonster_ShowWarubouWaheyGoodGood_Data
    add_a_to_hl
    ld a, [hli]
    ld [wObject2 + OBJ_X], a
    ld a, [hl]
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, vTiles1 + $595
    call StartMessageHL_B85
    ld a, $01
    ld [wScriptStep], a
    ret

; data read by SceneLimboMonster (8 bytes) (E-0347)
SceneLimboMonster_ShowWarubouWaheyGoodGood_Data::
    db $d0, $10, $c0, $20, $d0, $30, $e0, $20

; step 0 of SceneLimboMonster: calls ClearArg5IfAtOrAboveLimitForFarmLevel; branches on wArg5; shows
; 'Warubou: Wa-hey, I have a favor'; advances wScriptStep; shows 'Warubou: Wa-hey, I have a favor';
; sets wScriptStep to 2 (E-0347)
; why: step 0 of SceneLimboMonster (when wScriptStep = 0); SceneLimboMonster: implements script
; command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the scene its only
; script shows: 'Limbo is the ... (E-0352, E-0038, E-0245)
SceneLimboMonster_ShowWarubouWaheyIHave::
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .call_start_message_hl_b85
    ld hl, $0b28 ; 'Warubou: Wa-hey, I have a favor'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, MSG_KEEP_OPEN | $0b29 ; 'Warubou: Wa-hey, I have a favor'
    call StartMessageHL_B85
    ld a, $02
    ld [wScriptStep], a
    ret

; implements script command type 6C (SCRIPT_GIVE_MONSTER): creates a monster record of kind hTemp1
; (CreateMonsterRecordOfKindTemp1); 'You'll take it? Excellent! I'll send...'; reached through
; ScriptCommand6C in bank $10 (E-0038, E-0245)
GiveMonster::
    ld a, $01
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the
; scene its only script shows: ... 'Our church is impoverished, so I...'; reached through
; ScriptCommand79 in bank $10 (E-0038, E-0245)
ScenePoorChurch::
    ld a, [wScriptStep]
    jumptable
    dw ScenePoorChurch_TestFlagBit
    dw ScenePoorChurch_WriteSVBKAndScriptParam0
    dw ScenePoorChurch_WriteScriptParam0AndScriptParam1Etc
    dw ScenePoorChurch_NextRandomSeed

; step 3 of ScenePoorChurch: calls NextRandomSeed; increments wScriptParam0; returns unless
; wScriptParam0 is $3c; sets wScriptStartRequest to $80; also changes HL and A by register
; arithmetic (E-0347)
; why: step 3 of ScenePoorChurch (when wScriptStep = 3); ScenePoorChurch: implements script command
; type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the scene its only script shows:
; ... 'Our church ... (E-0352, E-0038, E-0245)
ScenePoorChurch_NextRandomSeed::
    ld a, [wScriptParam0]
    and $07
    jr nz, .check_script_param0
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    swap a
    ld hl, wSpriteSlots + $7
    add_a_to_hl
    push hl
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $01
    add a
    inc a
    pop hl
    ld [hl], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 2 of ScenePoorChurch: increments wScriptParam0; returns unless wScriptParam0 is $01; sets
; wScriptParam0 to 0; branches on wScriptParam1; increments wScriptParam1; decrements wScriptStep;
; advances wScriptStep; checks EVENT_SCENE_TREASURE_THEFT; may return early; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 2 of ScenePoorChurch (when wScriptStep = 2); ScenePoorChurch: implements script command
; type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the scene its only script shows:
; ... 'Our church ... (E-0352, E-0038, E-0245)
ScenePoorChurch_WriteScriptParam0AndScriptParam1Etc::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $01
    ret nz
    xor a
    ld [wScriptParam0], a
    ld a, [wScriptParam1]
    cp $05
    jr z, .read_story_flags
    inc a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    dec [hl]
    ret

.read_story_flags:
    ld a, [wStoryFlags + $61]
    set 3, a
    ld [wStoryFlags + $61], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    ret c
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 1 of ScenePoorChurch: calls DecompressToVRAM; branches on wIsCGB; sets rSVBK to 2; calls
; DecompressToVRAM; sets rSVBK to 0; calls DrawFullScreenBufferAtScroll; increments wScriptParam0;
; returns unless wScriptParam0 is $04; sets wScriptParam0 to 0; advances wScriptStep; also changes
; HL, DE, A and B by register arithmetic (E-0347)
; why: step 1 of ScenePoorChurch (when wScriptStep = 1); ScenePoorChurch: implements script command
; type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the scene its only script shows:
; ... 'Our church ... (E-0352, E-0038, E-0245)
ScenePoorChurch_WriteSVBKAndScriptParam0::
    ld a, [wScriptParam1]
    add a
    add a
    add a
    ld hl, ScreenAnimationTable
    add_a_to_hl
    ld a, [wScriptParam0]
    and $01
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    push hl
    ld b, $93
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld b, $93
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $04
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; ScenePoorChurch_WriteSVBKAndScriptParam0 indexes it with 8 * wScriptParam1 + 4 * (wScriptParam0 &
; 1) and decompresses the two words from bank $93 into wScreenTileBuffer and, on CGB,
; wScreenAttrBuffer; it runs four steps, alternating the two frames; entries 0-5 decode to 360-byte
; screens, the bytes after them do not (E-0145, C1)
; record: frame 0 tile map (bank $93); frame 0 attribute map; frame 1 tile map; frame 1 attribute
; map
ScreenAnimationTable::
    dw Map2FScreens0_Y1X0 ; id 0: frame 0 tile map (bank $93)
    dw Map2FAttrs0_Y1X0 ; frame 0 attribute map
    dw ScreenMap_ScreenAnimationTable_2 ; frame 1 tile map
    dw ScriptScreenAttrMap_ScreenAnimationTable_3 ; frame 1 attribute map
    dw ScreenMap_ScreenAnimationTable_2 ; id 1: frame 0 tile map (bank $93)
    dw ScriptScreenAttrMap_ScreenAnimationTable_3 ; frame 0 attribute map
    dw ScreenMap_ScreenAnimationTable_6 ; frame 1 tile map
    dw ScriptScreenAttrMap_ScreenAnimationTable_7 ; frame 1 attribute map
    dw ScreenMap_ScreenAnimationTable_6 ; id 2: frame 0 tile map (bank $93)
    dw ScriptScreenAttrMap_ScreenAnimationTable_7 ; frame 0 attribute map
    dw ScreenMap_ScreenAnimationTable_10 ; frame 1 tile map
    dw ScriptScreenAttrMap_ScreenAnimationTable_11 ; frame 1 attribute map
    dw ScreenMap_ScreenAnimationTable_10 ; id 3: frame 0 tile map (bank $93)
    dw ScriptScreenAttrMap_ScreenAnimationTable_11 ; frame 0 attribute map
    dw ScreenMap_ScreenAnimationTable_14 ; frame 1 tile map
    dw ScriptScreenAttrMap_ScreenAnimationTable_15 ; frame 1 attribute map
    dw ScreenMap_ScreenAnimationTable_14 ; id 4: frame 0 tile map (bank $93)
    dw ScriptScreenAttrMap_ScreenAnimationTable_15 ; frame 0 attribute map
    dw ScreenMap_ScreenAnimationTable_18 ; frame 1 tile map
    dw ScriptScreenAttrMap_ScreenAnimationTable_19 ; frame 1 attribute map
    dw ScreenMap_ScreenAnimationTable_18 ; id 5: frame 0 tile map (bank $93)
    dw ScriptScreenAttrMap_ScreenAnimationTable_19 ; frame 0 attribute map
    dw Map2FScreens4_Y1X0 ; frame 1 tile map
    dw Map2FAttrs4_Y1X0 ; frame 1 attribute map

; step 0 of ScenePoorChurch: checks EVENT_SCENE_TREASURE_THEFT; sets wStepPtrHi to 1; sets
; wStepTarget to 2; sets wStepPtrLo to $10; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets
; wStepTarget to 2; sets wStepPtrLo to $40; calls StepObjectTowardCoord; sets wStepPtrHi to 3; sets
; wStepTarget to 2; sets wStepPtrLo to $20; then 8 more steps (see the code) (E-0347)
; why: step 0 of ScenePoorChurch (when wScriptStep = 0); ScenePoorChurch: implements script command
; type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the scene its only script shows:
; ... 'Our church ... (E-0352, E-0038, E-0245)
ScenePoorChurch_TestFlagBit::
    ld de, EVENT_SCENE_TREASURE_THEFT
    call TestFlagBit
    jr nc, .clear_script_param1
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z

.clear_script_param1:
    xor a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the
; scene its only script shows: 'Rolt Shut up! Give back Cyal!'; reached through ScriptCommandC2 in
; bank $10 (E-0038, E-0245)
SceneGiveBackCyal::
    ld a, [wScriptStep]
    jumptable
    dw SceneGiveBackCyal_SetBit2AtHL_B0F_Bank85
    dw SceneGiveBackCyal_SetBit2AtHL_B0F_Bank85
    dw SceneGiveBackCyal_SetBit2AtHL_B0F_Bank85
    dw SceneGiveBackCyal_SetBit2AtHL_B0F_Bank85
    dw SceneGiveBackCyal_SetBit2AtHL_B0F_Bank85
    dw SceneGiveBackCyal_ShowHumphHowBoring
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneGiveBackCyal_ClearBit2AtHL_Bank85
    dw SceneGiveBackCyal_ClearBit1AtHL_Bank85
    dw SceneGiveBackCyal_ToSceneGiveBackCyal_WriteScrollXAndScrollXHiEtc
    dw SceneGiveBackCyal_SetScriptStartRequestTo80

; step 10 of SceneGiveBackCyal: sets wScriptStartRequest to $80 (E-0347)
; why: step 10 of SceneGiveBackCyal (when wScriptStep = 10); SceneGiveBackCyal: implements script
; command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only
; script shows: 'Rolt Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 9 of SceneGiveBackCyal: calls SceneGiveBackCyal_WriteScrollXAndScrollXHiEtc (E-0347)
; why: step 9 of SceneGiveBackCyal (when wScriptStep = 9); SceneGiveBackCyal: implements script
; command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only
; script shows: 'Rolt Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_ToSceneGiveBackCyal_WriteScrollXAndScrollXHiEtc::
    ld b, $1e
    call SceneGiveBackCyal_WriteScrollXAndScrollXHiEtc
    ret

; step 8 of SceneGiveBackCyal: increments wObject2 + OBJ_X; returns unless wObject2 + OBJ_X is $60;
; calls ClearBit1AtHL_Bank85; advances wScriptStep (E-0347)
; why: step 8 of SceneGiveBackCyal (when wScriptStep = 8); SceneGiveBackCyal: implements script
; command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only
; script shows: 'Rolt Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_ClearBit1AtHL_Bank85::
    ld a, [wObject2 + OBJ_X]
    inc a
    inc a
    inc a
    inc a
    ld [wObject2 + OBJ_X], a
    cp $60
    ret nz
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit1AtHL_Bank85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 7 of SceneGiveBackCyal: increments wScriptParam0; returns if wScriptParam0 is below $04;
; plays sound $66; may return early; calls ClearBit2AtHL_Bank85; calls SetBit1AtHL_Bank85; sets
; wObject2 + OBJ_STATE to 3; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 7 of SceneGiveBackCyal (when wScriptStep = 7); SceneGiveBackCyal: implements script
; command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only
; script shows: 'Rolt Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_ClearBit2AtHL_Bank85::
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $04
    ret c
    push af
    ld a, $66
    call QueueSoundEffect
    xor a
    ld [wSpriteSlots + $7], a
    pop af
    cp $08
    ret nz
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank85
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit1AtHL_Bank85
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneGiveBackCyal: shows 'Humph… How boring…'; advances wScriptStep (E-0347)
; why: step 5 of SceneGiveBackCyal (when wScriptStep = 5); SceneGiveBackCyal: implements script
; command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only
; script shows: 'Rolt Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_ShowHumphHowBoring::
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, $0737 ; '*: Humph… How boring…'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneGiveBackCyal: calls SetBit2AtHL_B0F_Bank85; branches on wScriptParam0; increments
; wObject2 + OBJ_Y; returns unless wObject2 + OBJ_Y is $48; plays sound $63; increments
; wScriptParam0; decrements wObject2 + OBJ_Y; returns unless wObject2 + OBJ_Y is $40; calls
; RedrawColumnsBesideScreen; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 0 of SceneGiveBackCyal (when wScriptStep = 0); SceneGiveBackCyal: implements script
; command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only
; script shows: 'Rolt Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_SetBit2AtHL_B0F_Bank85::
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F_Bank85
    ld a, [wScriptParam0]
    or a
    jr nz, .check_object2
    ld a, [wObject2 + OBJ_Y]
    inc a
    ld [wObject2 + OBJ_Y], a
    cp $48
    ret nz
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptParam0
    inc [hl]
    ret

.check_object2:
    ld a, [wObject2 + OBJ_Y]
    dec a
    dec a
    ld [wObject2 + OBJ_Y], a
    cp $40
    ret nz
    farcall RedrawColumnsBesideScreen
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; called from SceneGiveBackCyal_ToSceneGiveBackCyal_WriteScrollXAndScrollXHiEtc: branches on
; wFrameCounterLo & $03; sets hScrollX; sets hScrollXHi; sets hScrollX; sets hScrollXHi; increments
; wScriptParam0; returns unless wScriptParam0 is b; sets hScrollX to 0; sets hScrollXHi to 0; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: a helper of SceneGiveBackCyal_ToSceneGiveBackCyal_WriteScrollXAndScrollXHiEtc, in step 9 of
; SceneGiveBackCyal (when wScriptStep = 9); SceneGiveBackCyal: implements script command type C2
; (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only script shows: 'Rolt
; Shut ... (E-0352, E-0038, E-0245)
SceneGiveBackCyal_WriteScrollXAndScrollXHiEtc::
    ld a, [wFrameCounterLo]
    and $03
    bit 0, a
    jr nz, .check_script_param0
    dec a
    add a
    ld c, a
    bit 7, a
    jr z, .read_scroll_x
    cpl
    inc a
    ld c, a
    ldh a, [hScrollX]
    sub c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    sbc $00
    ldh [hScrollXHi], a
    jr .check_script_param0

.read_scroll_x:
    ldh a, [hScrollX]
    add c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hScrollXHi], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp b
    ret nz
    xor a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type CD (SCRIPT_SCENE_YOU_DID_IT): a cutscene step named after the scene
; its only script shows: ... 'Warubou Wa-hey! You did it, 0!'; reached through ScriptCommandCD in
; bank $10 (E-0038, E-0245)
SceneYouDidIt::
    ld a, [wScriptStep]
    jumptable
    dw SceneYouDidIt_StartMessageHL_B85
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 0 of SceneYouDidIt: advances wScriptStep; returns if the byte at
; SceneYouDidIt_StartMessageHL_B85_Data is $ff; branches on the byte at
; SceneYouDidIt_StartMessageHL_B85_Data; calls StartMessageHL_B85; also changes HL, DE, A and C by
; register arithmetic (E-0347)
; why: step 0 of SceneYouDidIt (when wScriptStep = 0); SceneYouDidIt: implements script command type
; CD (SCRIPT_SCENE_YOU_DID_IT): a cutscene step named after the scene its only script shows: ...
; 'Warubou ... (E-0352, E-0038, E-0245)
SceneYouDidIt_StartMessageHL_B85::
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hMapId]
    ld c, a
    ld de, SceneYouDidIt_StartMessageHL_B85_Data

.skip:
    ld a, [de]
    cp $ff
    ret z
    ld a, [de]
    cp c
    jr z, .next
    inc de
    inc de
    jr .skip

.next:
    inc de
    ld a, [de]
    ld l, a
    ld h, $0c
    call StartMessageHL_B85
    ret

; data read by SceneYouDidIt (25 bytes) (E-0347)
SceneYouDidIt_StartMessageHL_B85_Data::
    db $ca, $4a, $cb, $4b, $cc, $4c, $cd, $4d, $d3, $4e, $d4, $4f, $d5, $50, $d6, $51
    db $dc, $52, $dd, $53, $de, $54, $df, $55, $ff

; implements script command type 73 (SCRIPT_FOLLOWER_FACE_PLAYER): copies hPlayerFacing to the first
; follower record; reached through ScriptCommand73 in bank $10 (E-0038, E-0245)
FollowerFacePlayer::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 65 (SCRIPT_GROWTH_LIMIT_INFO): shows a monster's name and a record
; byte as digits: 'Everyone has a growth limit. Whether...'; reached through ScriptCommand65 in bank
; $10 (E-0038, E-0245)
GrowthLimitInfo::
    ld a, [wScriptStep]
    jumptable
    dw GrowthLimitInfo_CopyRecordNameToNameGlyphBuf
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw GrowthLimitInfo_WriteScriptStepAndScriptParam1Etc

; step 2 of GrowthLimitInfo: sets wScriptStep to 0; increments wScriptParam1; returns unless
; wPartyCount is c; sets wScriptStartRequest to $80 (E-0347)
; why: step 2 of GrowthLimitInfo (when wScriptStep = 2); GrowthLimitInfo: implements script command
; type 65 (SCRIPT_GROWTH_LIMIT_INFO): shows a monster's name and a record byte as digits: 'Everyone
; has a growth ... (E-0352, E-0038, E-0245)
GrowthLimitInfo_WriteScriptStepAndScriptParam1Etc::
    xor a
    ld [wScriptStep], a
    ld a, [wScriptParam1]
    inc a
    ld [wScriptParam1], a
    ld c, a
    ld a, [wPartyCount]
    cp c
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of GrowthLimitInfo: advances wScriptStep; sets rRAMG to $0a; calls
; CopyRecordNameToNameGlyphBuf; calls LoadSRAMRecordByte; sets rRAMG to 0; branches on hTemp0; calls
; StartMessageHL_B85; calls HLToDecimalDigits; calls StartMessageHL_B85; also changes HL, DE, BC and
; A by register arithmetic (E-0347)
; why: step 0 of GrowthLimitInfo (when wScriptStep = 0); GrowthLimitInfo: implements script command
; type 65 (SCRIPT_GROWTH_LIMIT_INFO): shows a monster's name and a record byte as digits: 'Everyone
; has a growth ... (E-0352, E-0038, E-0245)
GrowthLimitInfo_CopyRecordNameToNameGlyphBuf::
    ld hl, wScriptStep
    inc [hl]
    ld a, $0a
    ld [rRAMG], a
    ld hl, wPartyList
    ld a, [wScriptParam1]
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    pop af
    push af
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld e, a
    pop af
    ld c, MON_MAX_LEVEL
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG], a
    ldh a, [hTemp0]
    cp e
    jr nz, .call_hl_to_decimal_digits
    ld hl, wRecordBufB + $2b
    call StartMessageHL_B85
    ret

.call_hl_to_decimal_digits:
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wTextNumber
    ld a, [wDigits + $1]
    or a
    jr z, .read_digits
    ld [de], a
    inc de

.read_digits:
    ld a, [wDigits + $2]
    ld [de], a
    inc de
    ld a, $f0
    ld [de], a
    ld hl, wRecordBufB + $2a
    call StartMessageHL_B85
    ret

; implements script command type C4 (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its
; only script shows: '0 peered into the barrel.' ... 'Kiral Ah! Back!' (encounter); reached through
; ScriptCommandC4 in bank $10 (E-0038, E-0245)
SceneBarrel::
    ld a, [wScriptStep]
    jumptable
    dw SceneBarrel_TestFlagBit
    dw SceneBarrel_StartMessageHL_B85
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneBarrel_StartScriptedEncounterTemp0
    dw SceneBarrel_SetFlagBit
    dw SceneBarrel_WriteScriptParam0
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneBarrel_WriteSpriteSlotsAndObject1Etc
    dw SceneBarrel_ShowRobosterStoppedMoving
    dw SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest

; step 8 of SceneBarrel: sets wObject1 + OBJ_Y to $20; shows '…Roboster stopped moving…'; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 8 of SceneBarrel (when wScriptStep = 8); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_ShowRobosterStoppedMoving::
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    ld hl, $078d ; '…Roboster stopped moving…'
    call StartMessageHL_B85
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 7 of SceneBarrel: branches on wScriptParam0; sets wObject1 + OBJ_Y to $e0; sets wObject1 +
; OBJ_Y to $20; increments wScriptParam0; returns unless wScriptParam0 is $78; sets wObject1 + OBJ_Y
; to $20; sets wScriptParam0 to 0; advances wScriptStep; also changes HL and A by register
; arithmetic (E-0347)
; why: step 7 of SceneBarrel (when wScriptStep = 7); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_WriteSpriteSlotsAndObject1Etc::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_sprite_slots_to_20
    jr .set_sprite_slots_to_E0

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_sprite_slots_to_20
    jr .set_sprite_slots_to_E0

.check_bit3:
    bit 3, a
    jr z, .set_sprite_slots_to_20
    jr .set_sprite_slots_to_E0

.set_sprite_slots_to_20:
    ld a, $20
    ld [wSpriteSlots + $c], a
    ld a, $e0
    ld [wObject1 + OBJ_Y], a
    jr .check_script_param0

.set_sprite_slots_to_E0:
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld a, $20
    ld [wObject1 + OBJ_Y], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneBarrel: increments wScriptParam0; calls SceneBarrel_NextTableByte; returns unless
; wScriptParam0 is $78; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 5 of SceneBarrel (when wScriptStep = 5); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_WriteScriptParam0::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    jr z, .check_script_param0
    call SceneBarrel_NextTableByte

.check_script_param0:
    ld a, [wScriptParam0]
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; called from SceneBarrel_WriteScriptParam0: calls NextTableByte; may continue in
; SceneBarrel_NextTableByte; sets wObject1 + OBJ_X (E-0347)
; why: a helper of SceneBarrel_WriteScriptParam0, in step 5 of SceneBarrel (when wScriptStep = 5);
; SceneBarrel: implements script command type C4 (SCRIPT_SCENE_BARREL): a cutscene step named after
; the scene its only script shows: '0 peered into the ... (E-0352, E-0038, E-0245)
SceneBarrel_NextTableByte::
    call NextTableByte
    ld a, [wRandomHi]
    and $03
    cp $03
    jr z, SceneBarrel_NextTableByte
    dec a
    ld c, a
    ld a, $40
    add c
    ld [wObject1 + OBJ_X], a
    ret

; step 4 of SceneBarrel: branches on wScriptParam1 & $03; sets $015f; checks
; EVENT_KIRAL_PLEASE_GO_STOP_HIM; sets wScriptStartRequest to $80; sets EVENT_SCENE_BARREL; shows
; 'PROFE… SOR… ORDER… MUST… OBEY…'; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 4 of SceneBarrel (when wScriptStep = 4); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_SetFlagBit::
    ld a, [wScriptParam1]
    and $03
    cp $03
    jr z, .call_test_flag_bit
    ld de, $015f
    add e
    ld e, a
    jr nc, .call_set_flag_bit
    inc d

.call_set_flag_bit:
    call SetFlagBit

.call_test_flag_bit:
    ld de, EVENT_KIRAL_PLEASE_GO_STOP_HIM
    call TestFlagBit
    jr c, .call_set_flag_bit2
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_set_flag_bit2:
    ld de, EVENT_SCENE_BARREL
    call SetFlagBit
    ld hl, $0779 ; '*: PROFE… SOR… ORDER… MUST… OBEY…'
    call StartMessageHL_B85
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneBarrel: copies the byte at SceneBarrel_StartScriptedEncounterTemp0_Data to hTemp0;
; calls StartScriptedEncounterTemp0; advances wScriptStep; also changes HL, DE and A by register
; arithmetic (E-0347)
; why: step 3 of SceneBarrel (when wScriptStep = 3); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_StartScriptedEncounterTemp0::
    ld a, [wScriptParam1]
    and $03
    ld de, SceneBarrel_StartScriptedEncounterTemp0_Data
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, [de]
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; data read by SceneBarrel (4 bytes) (E-0347)
SceneBarrel_StartScriptedEncounterTemp0_Data::
    db $0d, $0e, $0f, $10

; step 1 of SceneBarrel: calls StartMessageHL_B85; advances wScriptStep; also changes HL, DE and A
; by register arithmetic (E-0347)
; why: step 1 of SceneBarrel (when wScriptStep = 1); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_StartMessageHL_B85::
    ld a, [wScriptParam1]
    and $03
    add a
    ld de, SceneBarrel_StartMessageHL_B85_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; data read by SceneBarrel (8 bytes) (E-0347)
SceneBarrel_StartMessageHL_B85_Data::
    db $6c, $07, $6f, $07, $72, $07, $75, $07

; step 0 of SceneBarrel: advances wScriptStep; sets wScriptParam1 to 0; checks
; EVENT_KIRAL_FETCH_ME_MY; may return early; increments wScriptParam1; checks
; EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY; may return early; increments wScriptParam1; checks
; EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY_161; may return early; increments wScriptParam1 (E-0347)
; why: step 0 of SceneBarrel (when wScriptStep = 0); SceneBarrel: implements script command type C4
; (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into
; the ... (E-0352, E-0038, E-0245)
SceneBarrel_TestFlagBit::
    ld hl, wScriptStep
    inc [hl]
    xor a
    ld [wScriptParam1], a
    ld de, EVENT_KIRAL_FETCH_ME_MY
    call TestFlagBit
    ret nc
    ld hl, wScriptParam1
    inc [hl]
    ld de, EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY
    call TestFlagBit
    ret nc
    ld hl, wScriptParam1
    inc [hl]
    ld de, EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY_161
    call TestFlagBit
    ret nc
    ld hl, wScriptParam1
    inc [hl]
    ret

; implements script command type 5B (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its
; only script shows: 'Warubou Wa-hey! Take the treasures that...' ... 'Limbo is the King's domain!';
; reached through ScriptCommand5B in bank $10 (E-0038, E-0245)
SceneLimbo::
    ld a, [wScriptStep]
    jumptable
    dw SceneLimbo_RunFieldCommandTemp0
    dw SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85
    dw SceneLimbo_StartMessageHL_B85
    dw SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85_2
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimbo_RunFieldCommandTemp0
    dw SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85
    dw SceneLimbo_StartMessageHL_B85
    dw SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85_2
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimbo_RunFieldCommandTemp0
    dw SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85
    dw SceneLimbo_StartMessageHL_B85
    dw SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85_2
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneLimbo_WriteInventorySortFlagsAndScriptStartRequest

; step 15 of SceneLimbo: branches on the byte at wInventory; sets wInventory to $36; sets wInventory
; to $37; sets wInventory to $38; sets wInventorySortFlags; sets wScriptStartRequest to $80 (E-0347)
; why: step 15 of SceneLimbo (when wScriptStep = 15); SceneLimbo: implements script command type 5B
; (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its only script shows: 'Warubou
; Wa-hey! Take ... (E-0352, E-0038, E-0245)
SceneLimbo_WriteInventorySortFlagsAndScriptStartRequest::
    ld hl, wInventory

.skip:
    ld a, [hl]
    cp $ff
    jr z, .skip2
    or a
    jr z, .skip2
    inc hl
    jr .skip

.skip2:
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $38
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 3 of SceneLimbo: increments wObject5 + SCRIPTOBJ_Y; increments wObject5 + SCRIPTOBJ_X;
; increments wObject5 + SCRIPTOBJ_Y; decrements wObject5 + SCRIPTOBJ_X; increments wObject5 +
; SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE_Bank85; may return early; sets wObject5 to 0; advances
; wScriptStep (E-0347)
; why: step 3 of SceneLimbo (when wScriptStep = 3); SceneLimbo: implements script command type 5B
; (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its only script shows: 'Warubou
; Wa-hey! Take ... (E-0352, E-0038, E-0245)
SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85_2::
    ld a, [wSpriteSlots + $7]
    or a
    jr nz, .skip
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    jr .call_script_apply_step_delta_at_de_bank85

.skip:
    dec a
    jr nz, .skip2
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank85

.skip2:
    dec a
    jr z, .call_script_apply_step_delta_at_de_bank85
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]

.call_script_apply_step_delta_at_de_bank85:
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneLimbo: increments wScriptParam0; returns unless wScriptParam0 is $3c; calls
; StartMessageHL_B85; sets wScriptParam0 to 0; increments wScriptParam1; advances wScriptStep
; (E-0347)
; why: step 2 of SceneLimbo (when wScriptStep = 2); SceneLimbo: implements script command type 5B
; (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its only script shows: 'Warubou
; Wa-hey! Take ... (E-0352, E-0038, E-0245)
SceneLimbo_StartMessageHL_B85::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    ld a, [wScriptParam1]
    ld hl, $052c
    add_a_to_hl
    call StartMessageHL_B85
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptParam1
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneLimbo: sets wObject5 to $80; decrements wObject5 + SCRIPTOBJ_Y; calls
; ScriptApplyStepDeltaAtDE_Bank85; may return early; advances wScriptStep (E-0347)
; why: step 1 of SceneLimbo (when wScriptStep = 1); SceneLimbo: implements script command type 5B
; (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its only script shows: 'Warubou
; Wa-hey! Take ... (E-0352, E-0038, E-0245)
SceneLimbo_ScriptApplyStepDeltaAtDE_Bank85::
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneLimbo: copies the byte at SceneLimbo_RunFieldCommandTemp0_Data to hTemp0; calls
; RunFieldCommandTemp0; sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30; sets
; wObject5 to 0; advances wScriptStep (E-0347)
; why: step 0 of SceneLimbo (when wScriptStep = 0); SceneLimbo: implements script command type 5B
; (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its only script shows: 'Warubou
; Wa-hey! Take ... (E-0352, E-0038, E-0245)
SceneLimbo_RunFieldCommandTemp0::
    ld a, [wScriptParam1]
    ld hl, SceneLimbo_RunFieldCommandTemp0_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; data read by SceneLimbo (3 bytes) (E-0347)
SceneLimbo_RunFieldCommandTemp0_Data::
    db $03, $08, $0a

; implements script command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the
; scene its only script shows: 'I'm surprised anyone managed to find...' ... 'Ah, so good of you
; to...' (encounter); reached through ScriptCommand69 in bank $10 (E-0038, E-0245)
SceneFoundMeBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneFoundMeBattle_StartMessageHL_B85
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneFoundMeBattle_WriteScriptStepAndTemp0
    dw SceneFoundMeBattle_ScriptStepBlinkObjectTemp0
    dw SceneFoundMeBattle_StepObjectTowardCoord
    dw SceneFoundMeBattle_SetFlagBit

; step 5 of SceneFoundMeBattle: sets wSpriteSlotCount to 0; branches on hMapId; branches on
; hMapScreenX; sets $00b9; sets wScriptStartRequest to $80; also changes DE and A by register
; arithmetic (E-0347)
; why: step 5 of SceneFoundMeBattle (when wScriptStep = 5); SceneFoundMeBattle: implements script
; command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the scene its only
; script shows: 'I'm ... (E-0352, E-0038, E-0245)
SceneFoundMeBattle_SetFlagBit::
    xor a
    ld [wSpriteSlotCount], a
    ldh a, [hMapId]
    cp $96
    jr nz, .check_map_screen_x
    ld de, $0201
    jr .call_set_flag_bit

.check_map_screen_x:
    ld de, $00b9
    ldh a, [hMapScreenX]
    or a
    jr z, .call_set_flag_bit
    inc de
    dec a
    jr z, .call_set_flag_bit
    inc de

.call_set_flag_bit:
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 4 of SceneFoundMeBattle: sets wStepPtrLo to $e0; sets wStepPtrHi to 0; branches on hMapId;
; sets wStepTarget to 2; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances
; wScriptStep; sets wStepTarget to 3; calls StepObjectTowardCoord; returns if wStepArrived is 0;
; advances wScriptStep (E-0347)
; why: step 4 of SceneFoundMeBattle (when wScriptStep = 4); SceneFoundMeBattle: implements script
; command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the scene its only
; script shows: 'I'm ... (E-0352, E-0038, E-0245)
SceneFoundMeBattle_StepObjectTowardCoord::
    ld a, $e0
    ld [wStepPtrLo], a
    xor a
    ld [wStepPtrHi], a
    ldh a, [hMapId]
    cp $96
    jr z, .set_step_target_to_03
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

.set_step_target_to_03:
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneFoundMeBattle: sets hTemp1 to $20; branches on hMapId; sets hTemp1 to $40; sets
; hTemp0 to 0; calls ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wScriptStep to 5
; (E-0347)
; why: step 3 of SceneFoundMeBattle (when wScriptStep = 3); SceneFoundMeBattle: implements script
; command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the scene its only
; script shows: 'I'm ... (E-0352, E-0038, E-0245)
SceneFoundMeBattle_ScriptStepBlinkObjectTemp0::
    ld a, $20
    ldh [hTemp1], a
    ldh a, [hMapId]
    cp $96
    jr nz, .clear_temp0
    ld a, $40
    ldh [hTemp1], a

.clear_temp0:
    xor a
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $05
    ld [wScriptStep], a
    ret

; step 2 of SceneFoundMeBattle: branches on wScriptParam1; sets wScriptStep to 4; sets hTemp0 to
; $1b; calls StartScriptedEncounterTemp0; advances wScriptStep (E-0347)
; why: step 2 of SceneFoundMeBattle (when wScriptStep = 2); SceneFoundMeBattle: implements script
; command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the scene its only
; script shows: 'I'm ... (E-0352, E-0038, E-0245)
SceneFoundMeBattle_WriteScriptStepAndTemp0::
    ld a, [wScriptParam1]
    cp $01
    jr nz, .set_temp0_to_1B
    ld a, $04
    ld [wScriptStep], a
    ret

.set_temp0_to_1B:
    ld a, $1b
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneFoundMeBattle: advances wScriptStep; branches on hPlayerSpriteOverride; sets
; wScriptParam1 to 0; shows 'You! I've never seen you'; branches on hPlayerSpriteStreamHi; branches
; on hPlayerSpriteStreamLo; sets wScriptParam1 to 1; shows 'Oh, you're the cooking crew.'; sets
; wScriptParam1 to 2; shows 'Hm? Are you a new'; also changes HL and A by register arithmetic
; (E-0347)
; why: step 0 of SceneFoundMeBattle (when wScriptStep = 0); SceneFoundMeBattle: implements script
; command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the scene its only
; script shows: 'I'm ... (E-0352, E-0038, E-0245)
SceneFoundMeBattle_StartMessageHL_B85::
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .loop
    and $01
    jr z, .check_player_sprite_stream_hi

.loop:
    ld a, $00
    ld [wScriptParam1], a
    ld hl, $0473 ; '*: You! I've never seen you'
    call StartMessageHL_B85
    ret

.check_player_sprite_stream_hi:
    ldh a, [hPlayerSpriteStreamHi]
    cp $00
    jr nz, .loop
    ldh a, [hPlayerSpriteStreamLo]
    cp $d6
    jr nz, .cp_EC
    ld a, $01
    ld [wScriptParam1], a
    ld hl, $0475 ; '*: Oh, you're the cooking crew.'
    call StartMessageHL_B85
    ret

.cp_EC:
    cp $ec
    jr nz, .loop
    ld a, $02
    ld [wScriptParam1], a
    ld hl, $0474 ; '*: Hm? Are you a new'
    call StartMessageHL_B85
    ret

; implements script command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS): a cutscene step named after the
; scene its only script shows: 'How could we die before enjoying...' ... 'The treasures are ours';
; reached through ScriptCommand31 in bank $10 (E-0038, E-0245)
ScenePirateGhosts::
    ld a, [wScriptStep]
    jumptable
    dw ScenePirateGhosts_ReadMapId
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw ScenePirateGhosts_ScriptStepBlinkObjectTemp0

; step 0 of ScenePirateGhosts: advances wScriptStep; branches on hMapId; advances wScriptStep; shows
; 'Check the wooden crate…' (E-0347)
; why: step 0 of ScenePirateGhosts (when wScriptStep = 0); ScenePirateGhosts: implements script
; command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS): a cutscene step named after the scene its only
; script shows: 'How could we ... (E-0352, E-0038, E-0245)
ScenePirateGhosts_ReadMapId::
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hMapId]
    cp $43
    jr z, .call_start_message_hl_b85
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b85:
    ld hl, $085d ; '*: Check the wooden crate…'
    call StartMessageHL_B85
    ret

; step 2 of ScenePirateGhosts: branches on hMapId; branches on $10; sets hTemp1 to $30; sets hTemp0
; to 0; calls ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wSpriteSlotCount to 0; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 2 of ScenePirateGhosts (when wScriptStep = 2); ScenePirateGhosts: implements script
; command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS): a cutscene step named after the scene its only
; script shows: 'How could we ... (E-0352, E-0038, E-0245)
ScenePirateGhosts_ScriptStepBlinkObjectTemp0::
    ldh a, [hMapId]
    cp $37
    jr nz, .cp_42
    ld a, $10
    jr .set_temp1

.cp_42:
    cp $42
    jr nz, .set_temp1_to_30
    ld a, $60
    jr .set_temp1

.set_temp1_to_30:
    ld a, $30

.set_temp1:
    ldh [hTemp1], a
    ld a, $00
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the
; scene its only script shows: 'King What? Arrrrgh! Round up all...' ... 'King I apologize, but my
; treasures...'; reached through ScriptCommand24 in bank $10 (E-0038, E-0245)
SceneTreasureTheft::
    ld a, [wScriptStep]
    jumptable
    dw SceneTreasureTheft_ShowKingTheHideoutOf
    dw SceneTreasureTheft_WriteFieldDrawFlags
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneTreasureTheft_NextRandomSeed
    dw SceneTreasureTheft_StepObjectTowardCoord
    dw SceneTreasureTheft_WriteScriptParam0
    dw SceneTreasureTheft_ShowKingGoodYourValor
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneTreasureTheft_StepObjectTowardCoord_SetStepPtrHi

; step 8 of SceneTreasureTheft: sets wStepPtrHi to 1; branches on the byte at wObject1 + OBJ_X; sets
; wStepTarget to 1; sets wStepPtrLo to $50; calls StepObjectTowardCoord; sets wStepTarget to 0; sets
; wStepPtrLo to $b0; calls StepObjectTowardCoord; advances wStepPtrHi; branches on wObject3 + OBJ_X;
; sets wScriptParam0 to 1; returns if wScriptParam0 is 0; then 11 more steps (see the code) (E-0347)
; why: step 8 of SceneTreasureTheft (when wScriptStep = 8); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_StepObjectTowardCoord_SetStepPtrHi::
    ld a, $01
    ld [wStepPtrHi], a
    ld b, $03
    ld hl, wObject1 + OBJ_X

.loop:
    push bc
    push hl
    ld a, [hl]
    cp $50
    jr z, .set_step_target_to_00
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr .skip

.set_step_target_to_00:
    ld a, $00
    ld [wStepTarget], a
    ld a, $b0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

.skip:
    ld hl, wStepPtrHi
    inc [hl]
    pop hl
    ld a, $10
    add_a_to_hl
    pop bc
    dec b
    jr nz, .loop
    ld a, [wObject3 + OBJ_X]
    cp $50
    jr nz, .check_script_param0
    ld a, $01
    ld [wScriptParam0], a

.check_script_param0:
    ld a, [wScriptParam0]
    or a
    ret z
    ld a, [wObject4 + OBJ_X]
    cp $50
    jr z, .set_step_target_to_002
    ld a, $03
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.set_step_target_to_002:
    ld a, $00
    ld [wStepTarget], a
    ld a, $b0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 6 of SceneTreasureTheft: sets wStepTarget to 2; sets wStepPtrLo to $40; sets wStepPtrHi to 1;
; calls StepObjectTowardCoord; sets wStepPtrHi to 3; calls StepObjectTowardCoord; sets wStepPtrHi to
; 4; calls StepObjectTowardCoord; returns if wStepArrived is 0; shows 'King: Good! Your valor be
; praised!'; advances wScriptStep (E-0347)
; why: step 6 of SceneTreasureTheft (when wScriptStep = 6); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_ShowKingGoodYourValor::
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $0186 ; 'King: Good! Your valor be praised!'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneTreasureTheft: increments wScriptParam0; returns unless wScriptParam0 is $3c; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 5 of SceneTreasureTheft (when wScriptStep = 5); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_WriteScriptParam0::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneTreasureTheft: sets wStepPtrHi to 2; sets wStepTarget to 2; sets wStepPtrLo to $40;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep (E-0347)
; why: step 4 of SceneTreasureTheft (when wScriptStep = 4); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_StepObjectTowardCoord::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneTreasureTheft: calls NextRandomSeed; calls NextTableByte; increments wScriptParam0;
; returns unless wScriptParam0 is $f0; sets wObject1 + OBJ_STATE to 2; sets wObject2 + OBJ_STATE to
; 2; sets wObject3 + OBJ_STATE to 2; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
; why: step 3 of SceneTreasureTheft (when wScriptStep = 3); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_NextRandomSeed::
    ld a, [wScriptParam0]
    and $0f
    jr nz, .check_script_param0
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    inc a
    swap a
    ld hl, wSpriteSlots + $7
    add_a_to_hl
    push hl
    call NextTableByte
    ld a, [wRandomHi]
    and $01
    sla a
    inc a
    pop hl
    ld [hl], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $f0
    ret nz
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneTreasureTheft: sets hFieldDrawFlags to $0e; advances wScriptStep (E-0347)
; why: step 1 of SceneTreasureTheft (when wScriptStep = 1); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_WriteFieldDrawFlags::
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneTreasureTheft: sets hMapId to $26; sets hMapScreenX to 0; sets hMapScreenY to 0;
; sets wWarpDestX to $60; sets wWarpDestY to $20; sets wFieldTransitionKind to 1; calls
; ScriptStartFadeAndAdvanceStep; shows 'King: The hideout of the thieves' (E-0347)
; why: step 0 of SceneTreasureTheft (when wScriptStep = 0); SceneTreasureTheft: implements script
; command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only
; script shows: 'King What? ... (E-0352, E-0038, E-0245)
SceneTreasureTheft_ShowKingTheHideoutOf::
    ld a, $26
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wWarpDestX], a
    ld a, $20
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0185 ; 'King: The hideout of the thieves'
    call StartMessageHL_B85
    ret

; implements script command type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene
; its only script shows: 'What? Open the Canal Gate more?'; reached through ScriptCommand22 in bank
; $10 (E-0038, E-0245)
SceneCanalGate::
    ld a, [wScriptStep]
    jumptable
    dw SceneCanalGate_ScriptApplyStepDeltaAtDE_Bank85
    dw SceneCanalGate_ScriptApplyStepDeltaAtDE_Bank85
    dw SceneCanalGate_Msg0172_KingArrghIKnow
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneCanalGate_WriteScriptParam0AndSpriteSlots
    dw SceneCanalGate_StepObjectTowardCoord
    dw SceneCanalGate_ClearBit1AtHL_Bank85

; step 6 of SceneCanalGate: decrements wObject1 + OBJ_Y; returns unless wObject1 + OBJ_Y is $10;
; calls ClearBit1AtHL_Bank85; sets wScriptStartRequest to $80 (E-0347)
; why: step 6 of SceneCanalGate (when wScriptStep = 6); SceneCanalGate: implements script command
; type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene its only script shows:
; 'What? Open the ... (E-0352, E-0038, E-0245)
SceneCanalGate_ClearBit1AtHL_Bank85::
    ld a, [wObject1 + OBJ_Y]
    dec a
    dec a
    ld [wObject1 + OBJ_Y], a
    cp $10
    ret nz
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit1AtHL_Bank85
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 5 of SceneCanalGate: sets wStepPtrHi to 0; sets wStepTarget to $82; sets wStepPtrLo to $50;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; calls SetBit1AtHL_Bank85; plays sound
; $63; advances wScriptStep (E-0347)
; why: step 5 of SceneCanalGate (when wScriptStep = 5); SceneCanalGate: implements script command
; type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene its only script shows:
; 'What? Open the ... (E-0352, E-0038, E-0245)
SceneCanalGate_StepObjectTowardCoord::
    xor a
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit1AtHL_Bank85
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneCanalGate: increments wScriptParam0; may return early; sets wScriptParam0 to 0;
; advances wScriptStep; also changes HL and A by register arithmetic (E-0347)
; why: step 4 of SceneCanalGate (when wScriptStep = 4); SceneCanalGate: implements script command
; type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene its only script shows:
; 'What? Open the ... (E-0352, E-0038, E-0245)
SceneCanalGate_WriteScriptParam0AndSpriteSlots::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    ret z
    ld a, [wSpriteSlots + $c]
    inc a
    ld [wSpriteSlots + $c], a
    cp $60
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneCanalGate: shows 'King: Arrgh! I know that! I'; advances wScriptStep (E-0347)
; why: step 2 of SceneCanalGate (when wScriptStep = 2); SceneCanalGate: implements script command
; type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene its only script shows:
; 'What? Open the ... (E-0352, E-0038, E-0245)
SceneCanalGate_Msg0172_KingArrghIKnow::
    ld hl, $0172 ; 'King: Arrgh! I know that! I'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneCanalGate: calls ScriptApplyStepDeltaAtDE_Bank85; may return early; advances
; wScriptStep (E-0347)
; why: step 0 of SceneCanalGate (when wScriptStep = 0); SceneCanalGate: implements script command
; type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene its only script shows:
; 'What? Open the ... (E-0352, E-0038, E-0245)
SceneCanalGate_ScriptApplyStepDeltaAtDE_Bank85::
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 18 (SCRIPT_SCENE_GREATLOG_KEY): a cutscene step named after the
; scene its only script shows: before '0 received the GreatLog Key.'; reached through
; ScriptCommand18 in bank $10 (E-0038, E-0245)
SceneGreatlogKey::
    ld a, [wScriptStep]
    jumptable
    dw SceneGreatlogKey_ShowWarubouWaheyForgotSomething
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneGreatlogKey_ShowWarubouThisYouUse
    dw SceneWatchOut_RunMessageBoxFar_Bank85
    dw SceneGreatlogKey_QueueSoundEffect

; step 4 of SceneGreatlogKey: branches on wScriptParam0; plays sound $65; branches on wScriptParam1;
; decrements wObject5 + SCRIPTOBJ_X; copies the byte at SceneGreatlogKey_QueueSoundEffect_Data to
; wObject5 + SCRIPTOBJ_X; increments wObject5 + SCRIPTOBJ_Y; copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; increments wScriptParam0; returns unless
; wScriptParam0 is $20; sets wObject5 to 0; then 1 more step (see the code) (E-0347)
; why: step 4 of SceneGreatlogKey (when wScriptStep = 4); SceneGreatlogKey: implements script
; command type 18 (SCRIPT_SCENE_GREATLOG_KEY): a cutscene step named after the scene its only script
; shows: before '0 ... (E-0352, E-0038, E-0245)
SceneGreatlogKey_QueueSoundEffect::
    ld a, [wScriptParam0]
    or a
    jr nz, .check_script_param1
    ld a, $65
    call QueueSoundEffect

.check_script_param1:
    ld a, [wScriptParam1]
    or a
    jr nz, .read_script_param0
    ld a, [wObject5 + SCRIPTOBJ_X]
    dec a
    dec a
    ld [wObject5 + SCRIPTOBJ_X], a
    jr .check_object5

.read_script_param0:
    ld a, [wScriptParam0]
    ld hl, SceneGreatlogKey_QueueSoundEffect_Data
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + SCRIPTOBJ_X], a

.check_object5:
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by SceneGreatlogKey (32 bytes) (E-0347)
SceneGreatlogKey_QueueSoundEffect_Data::
    db $42, $45, $47, $4a, $4c, $4f, $51, $54, $56, $59, $5b, $5e, $60, $63, $65, $68
    db $6a, $6d, $6f, $72, $74, $77, $79, $7c, $7e, $81, $83, $86, $88, $8b, $8d, $90

; step 2 of SceneGreatlogKey: sets wObject5 to $80; decrements wObject5 + SCRIPTOBJ_Y; calls
; ScriptApplyStepDeltaAtDE_Bank85; may return early; shows 'Warubou: This you use to come'; advances
; wScriptStep (E-0347)
; why: step 2 of SceneGreatlogKey (when wScriptStep = 2); SceneGreatlogKey: implements script
; command type 18 (SCRIPT_SCENE_GREATLOG_KEY): a cutscene step named after the scene its only script
; shows: before '0 ... (E-0352, E-0038, E-0245)
SceneGreatlogKey_ShowWarubouThisYouUse::
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld hl, $0084 ; 'Warubou: This you use to come'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneGreatlogKey: sets hTemp0 to 2; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30; shows 'Warubou: Wa-hey! Forgot
; something!'; advances wScriptStep; branches on hPlayerX; sets hPlayerFacing to 1; sets
; wFollowerRecords to 1; sets wScriptParam1 to 0; sets hPlayerFacing to 3; sets wFollowerRecords to
; 3; then 1 more step (see the code) (E-0347)
; why: step 0 of SceneGreatlogKey (when wScriptStep = 0); SceneGreatlogKey: implements script
; command type 18 (SCRIPT_SCENE_GREATLOG_KEY): a cutscene step named after the scene its only script
; shows: before '0 ... (E-0352, E-0038, E-0245)
SceneGreatlogKey_ShowWarubouWaheyForgotSomething::
    ld a, $02
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, $0083 ; 'Warubou: Wa-hey! Forgot something!'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    or a
    jr nz, .set_player_facing_to_03
    ld a, $01
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    xor a
    ld [wScriptParam1], a
    ret

.set_player_facing_to_03:
    ld a, $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $01
    ld [wScriptParam1], a
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks) (E-0353)
SetBit1AtHL_Bank85::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks) (E-0353)
ClearBit1AtHL_Bank85::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; the same 5 bytes as SetBit2AtHL_B0F (SetBit2AtHL_B0F) (E-0353)
SetBit2AtHL_B0F_Bank85::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks) (E-0353)
ClearBit2AtHL_Bank85::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise
; returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
RotateDirectionAtDEEvery32_Bank85::
    ld a, [wScriptParam0]
    and $1f
    ret nz
    ld a, [de]
    inc a
    and $03
    ld [de], a
    ret

; the same 34 bytes as ScriptApplyStepDeltaAtDE (ScriptApplyStepDeltaAtDE) (E-0062)
ScriptApplyStepDeltaAtDE_Bank85::
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
    jr z, .clear_script_param0
    sub a
    ret

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    scf
    ret

; stores DE in wStepPtrLo/9 and far-calls AddStepDeltaToPointedByte each frame; after 32 frames
; starts message HL, clears wScriptParam0 and advances wScriptStep (E-0121)
ScriptStepAdjust32TimesThenMessage_Bank85::
    push hl
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    pop hl
    cp $20
    ret nz
    call StartMessageHL_B85
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0 (E-0353)
StartMessageHL_B85::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; wStepPtrLo = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A =
; 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
RunMessageBoxFar_Bank85::
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

; step 1 of SceneWatchOut: calls RunMessageBoxFar_Bank85; may return early; advances wScriptStep
; (E-0347)
; why: step 1 of SceneWatchOut (when wScriptStep = 1); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_RunMessageBoxFar_Bank85::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneWatchOut: calls RunMessageBoxFar_Bank85; may return early; sets wScriptStartRequest
; to $80 (E-0347)
; why: step 3 of SceneWatchOut (when wScriptStep = 3); SceneWatchOut: implements script command type
; 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can
; keep ... (E-0352, E-0038, E-0245)
SceneWatchOut_RunMessageBoxFar_Bank85_SetScriptStartRequest::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; hTemp0 = 1 when a party record has field $6F >= $C0 and bit 7 of field $55 clear, else 0 (E-0125)
PartyHasField6FAtLeastC0Without55Bit7::
    ld a, [wPartyCount]
    or a
    jr nz, .skip

.clear_temp0:
    xor a
    ldh [hTemp0], a
    ret

.skip:
    ld b, a
    ld a, $0a
    ld [rRAMG], a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_PERSONALITY
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    cp $c0
    jr c, .next
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr z, .skip2

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    jr .clear_temp0

.skip2:
    xor a
    ld [rRAMG], a
    ld a, $01
    ldh [hTemp0], a
    ret

; called from FhuntTalkEvents_ShowBeGoneIfYour: branches on wPartyCount; sets rRAMG to 0; sets
; hTemp0 to 0; sets rRAMG to $0a; calls LoadSRAMRecordByte; branches on hTemp0; calls
; LoadSRAMRecordWord; sets rRAMG to 0; sets hTemp0 to 1; also changes HL, BC and A by register
; arithmetic (E-0347)
; why: a helper of FhuntTalkEvents_ShowBeGoneIfYour, in step 15 of FhuntTalkEvents (when
; wTalkEventGroup = 15); FhuntTalkEvents: talk category 5: jumps by wTalkEventGroup to the talk
; handlers of Fhunt village and Pei (messages $0400-$04AF) (E-0352)
FhuntTalkEvents_WriteRAMGAndTemp0::
    ld a, [wPartyCount]
    or a
    jr nz, .skip

.loop:
    xor a
    ld [rRAMG], a
    xor a
    ldh [hTemp0], a
    ret

.skip:
    ld b, a
    ld a, $0a
    ld [rRAMG], a
    ld hl, wPartyList

.loop2:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .next
    push bc
    ld a, [hl]
    ld c, MON_WLD
    call LoadSRAMRecordWord
    pop bc
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    or c
    jr nz, .loop

.next:
    inc hl
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG], a
    ld a, $01
    ldh [hTemp0], a
    ret

; called from FhuntTalkEvents_TestFlagBit_Kweeeeeh: branches on hPlayerSpriteOverride; branches on
; the byte at TalkEvent29WordList; sets hTemp0 to 1; branches on wPartyCount; sets hTemp0 to 0; sets
; rRAMG to $0a; calls LoadSRAMRecordByte; branches on hTemp0; calls LoadSRAMRecordWord; branches on
; the byte at TalkEvent29WordList; sets rRAMG to 0; sets hTemp0 to 0; then 2 more steps (see the
; code) (E-0347)
; why: a helper of FhuntTalkEvents_TestFlagBit_Kweeeeeh, in step 41 of FhuntTalkEvents (when
; wTalkEventGroup = 41); FhuntTalkEvents: talk category 5: jumps by wTalkEventGroup to the talk
; handlers of Fhunt village and Pei (messages $0400-$04AF) (E-0352)
FhuntTalkEvents_WriteTemp0AndRAMG::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .check_party_count2
    and $01
    jr nz, .check_party_count2
    ld de, TalkEvent29WordList
    ldh a, [hPlayerSpriteStreamLo]
    ld l, a
    ldh a, [hPlayerSpriteStreamHi]
    ld h, a

.skip:
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or c
    jr z, .check_party_count
    ld a, [de]
    cp l
    jr nz, .restore
    inc de
    ld a, [de]
    cp h
    jr nz, .restore
    pop de
    ld a, $01
    ldh [hTemp0], a
    ret

.restore:
    pop de
    inc de
    inc de
    jr .skip

.check_party_count:
    pop de

.check_party_count2:
    ld a, [wPartyCount]
    or a
    jr nz, .skip2
    xor a
    ldh [hTemp0], a
    ret

.skip2:
    ld b, a
    ld a, $0a
    ld [rRAMG], a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .next
    push bc
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    pop bc
    ld de, TalkEvent29WordList

.skip3:
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or c
    jr z, .restore3
    ldh a, [hTemp0]
    ld c, a
    ld a, [de]
    cp c
    jr nz, .restore2
    inc de
    ldh a, [hTemp1]
    ld c, a
    ld a, [de]
    cp c
    jr z, .read_party_count

.restore2:
    pop de
    inc de
    inc de
    jr .skip3

.restore3:
    pop de

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    xor a
    ldh [hTemp0], a
    ret

.read_party_count:
    pop de
    ld a, [wPartyCount]
    sub b
    inc a
    ldh [hTemp0], a
    ret

; FhuntTalkEvents_WriteTemp0AndRAMG compares the words of this list, up to $0000, with
; hPlayerSpriteStreamLo/Hi when hPlayerSpriteOverride bit 7 is set and bit 0 clear, and otherwise
; with the word at byte $0B of each party record whose byte $55 bit 7 is clear (LoadSRAMRecordWord);
; a match sets hTemp0 to 1 or to the party position; 29 words; what the words identify is not read
; (E-0236, C1)
; record: words to match, then $0000
TalkEvent29WordList::
    dw $0009, $000e, $0011, $0012, $0016, $0018, $0019, $002b ; entry 0
    dw $0038, $0040, $0041, $0094, $00c6, $00ec, $0101, $0105
    dw $0119, $011b, $011f, $0120, $0124, $0126, $0127, $0129
    dw $012a, $012f, $0130, $0135, $0137, $0000

; called from FhuntTalkEvents_ShowHeroCheckedTheSmall: checks EVENT_NEVER_SET; branches on
; hPlayerSpriteOverride; sets hTemp0 to 0; branches on hPlayerSpriteOverride; sets hTemp0 to 0;
; branches on the byte at TalkEvent47WordList; sets hTemp0 to 2; also changes HL, DE, A and C by
; register arithmetic (E-0347)
; why: a helper of FhuntTalkEvents_ShowHeroCheckedTheSmall, in step 71 of FhuntTalkEvents (when
; wTalkEventGroup = 71); FhuntTalkEvents: talk category 5: jumps by wTalkEventGroup to the talk
; handlers of Fhunt village and Pei (messages $0400-$04AF) (E-0352)
FhuntTalkEvents_TestFlagBit_3::
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .set_temp0_to_02
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .clear_temp0
    and $01
    jr z, .read_player_sprite_stream_lo

.clear_temp0:
    xor a
    ldh [hTemp0], a
    ret

.read_player_sprite_stream_lo:
    ld de, TalkEvent47WordList
    ldh a, [hPlayerSpriteStreamLo]
    ld l, a
    ldh a, [hPlayerSpriteStreamHi]
    ld h, a

.skip:
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or c
    jr nz, .skip2
    pop de
    xor a
    ldh [hTemp0], a
    ret

.skip2:
    ld a, [de]
    cp l
    jr nz, .restore
    inc de
    ld a, [de]
    cp h
    jr nz, .restore
    pop de
    jr .set_temp0_to_02

.restore:
    pop de
    inc de
    inc de
    jr .skip

.set_temp0_to_02:
    ld a, $02
    ldh [hTemp0], a
    ret

; FhuntTalkEvents_TestFlagBit_3 (unless flag 0 is set) compares the words of this list, up to $0000,
; with hPlayerSpriteStreamLo/Hi when hPlayerSpriteOverride bit 7 is set and bit 0 clear; a match
; sets hTemp0 to 2; 113 words; what the words identify is not read (E-0236, C1)
; record: words to match, then $0000
TalkEvent47WordList::
    dw $0001, $0002, $0004, $0005, $0007, $0008, $0009, $000a ; entry 0
    dw $000b, $000d, $000f, $0011, $0012, $0016, $001a, $0024
    dw $0028, $002e, $0031, $0032, $0034, $0036, $0039, $003a
    dw $0048, $0049, $004a, $004b, $004d, $004f, $0050, $0053
    dw $0054, $0057, $005a, $005b, $0065, $006a, $006d, $006f
    dw $0070, $0071, $0073, $0074, $0076, $0084, $008d, $008e
    dw $0091, $0092, $0093, $0094, $0095, $0096, $0097, $0099
    dw $009a, $009e, $00a4, $00a5, $00a6, $00a7, $00b0, $00b1
    dw $00b2, $00b3, $00b4, $00b5, $00b6, $00b7, $00b9, $00ba
    dw $00bb, $00bd, $00bf, $00c5, $00d3, $00d6, $00d7, $00d8
    dw $00dc, $00dd, $00d4, $00f0, $00f6, $00f8, $00f9, $00fd
    dw $0100, $0101, $0103, $0105, $010d, $010e, $0119, $011b
    dw $011c, $011e, $0121, $0122, $0126, $0127, $012b, $012c
    dw $013c, $013d, $0140, $015a, $0149, $014d, $014e, $015b
    dw $0144, $0000

; Branches on hPlayerSpriteOverride; sets hTemp0 to 0; branches on hPlayerSpriteStreamHi; branches
; on hPlayerSpriteStreamLo; sets hTemp1 to 1; also changes A by register arithmetic (E-0347)
; why: part of FhuntTalkEvents; FhuntTalkEvents: talk category 5: jumps by wTalkEventGroup to the
; talk handlers of Fhunt village and Pei (messages $0400-$04AF) (E-0352)
FhuntTalkEvents_WriteTemp0AndTemp1::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .loop
    and $01
    jr z, .check_player_sprite_stream_hi

.loop:
    xor a
    ldh [hTemp0], a
    ret

.check_player_sprite_stream_hi:
    ldh a, [hPlayerSpriteStreamHi]
    cp $00
    jr nz, .skip
    ldh a, [hPlayerSpriteStreamLo]
    cp $f6
    jr c, .loop
    jr .set_temp1_to_01

.skip:
    dec a
    jr nz, .loop
    cp $11
    jr nc, .loop

.set_temp1_to_01:
    ld a, $01
    ldh [hTemp1], a
    ret

; called from Talk04CB_ThatKeyIUsed: returns if wPartyCount is 0; sets rRAMG to $0a; calls
; LoadSRAMRecordByte; branches on hTemp0; calls LoadSRAMRecordWord; branches on the byte at
; Talk04CB_ThatKeyIUsed_LoadSRAMRecordByte_Data; sets rRAMG to 0; sets hTemp0 to 0; sets rRAMG to 0;
; sets hTemp0 to 1; also changes HL, DE, BC and A by register arithmetic (E-0347)
; why: a helper of Talk04CB_ThatKeyIUsed; Talk04CB_ThatKeyIUsed: talk handler (bank-$04/$13 event
; code, reached from the DispatchTalkEvent groups): starts 5 constant message(s) depending on story
; flags ... (E-0352, E-0097)
Talk04CB_ThatKeyIUsed_LoadSRAMRecordByte::
    ld a, [wPartyCount]
    or a
    ret z
    ld b, a
    ld a, $0a
    ld [rRAMG], a
    ld hl, wPartyList

.loop:
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .next
    push bc
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    pop bc
    ld de, Talk04CB_ThatKeyIUsed_LoadSRAMRecordByte_Data

.skip:
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or c
    jr z, .restore2
    ldh a, [hTemp0]
    ld c, a
    ld a, [de]
    cp c
    jr nz, .restore
    inc de
    ldh a, [hTemp1]
    ld c, a
    ld a, [de]
    cp c
    jr z, .restore3

.restore:
    pop de
    inc de
    inc de
    jr .skip

.restore2:
    pop de

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    xor a
    ldh [hTemp0], a
    ret

.restore3:
    pop de
    xor a
    ld [rRAMG], a
    ld a, $01
    ldh [hTemp0], a
    ret

; data read by Talk04CB_ThatKeyIUsed_LoadSRAMRecordByte (12 bytes) (E-0347)
Talk04CB_ThatKeyIUsed_LoadSRAMRecordByte_Data::
    db $61, $01, $64, $01, $67, $01, $69, $01, $74, $01, $00, $00

; runs CountSpeciesPerFamilyFlaggedOrListed and sums the eleven per-family counts at wWorkBuf into
; hTemp0/hTemp1 (E-0122)
TotalSpeciesFlaggedOrListed::
    farcall CountSpeciesPerFamilyFlaggedOrListed
    ld hl, $0000
    ld de, wWorkBuf
    ld b, $0b

.loop:
    ld a, [de]
    add_a_to_hl
    inc de
    dec b
    jr nz, .loop
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ret

; hTemp0 = 1 when a used key entry has kind hTemp0, else 0 (E-0125)
KeyListHasKindTemp0::
    ldh a, [hTemp0]
    ld c, a
    ld hl, wKeyList
    ld b, $20

.loop:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .clear_temp0
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .restore
    pop hl
    ld a, [hl]
    and $3f
    cp c
    jr nz, .next
    ld a, $01
    ldh [hTemp0], a
    ret

.restore:
    pop hl

.next:
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    ret

.clear_temp0:
    pop hl
    xor a
    ldh [hTemp0], a
    ret

; on map $0B places four monster objects and picks the monster for the wArenaRank / wRecordCapacity
; entry (table $5C5E) or a random one (E-0130)
SetupMap0BMonsterObjects::
    ldh a, [hMapId]
    cp $0b
    ret nz
    ld a, [wArenaFlags]
    bit 7, a
    jr nz, .skip
    ld a, [wRecordCapacity]
    or a
    jr z, .check_arena_flags
    jr .set_sprite_slots_to_50

.skip:
    and $03
    jr z, .check_arena_flags

.set_sprite_slots_to_50:
    ld a, $50
    ld [wSpriteSlots + $b], a
    ld [wObject1 + OBJ_X], a
    ld [wObject2 + OBJ_X], a
    ld [wObject3 + OBJ_X], a
    ld a, $00
    ld [wSpriteSlots + $c], a
    ld a, $f0
    ld [wObject1 + OBJ_Y], a
    ld a, $e0
    ld [wObject2 + OBJ_Y], a
    ld a, $d0
    ld [wObject3 + OBJ_Y], a
    xor a
    ld [wSpriteSlots + $7], a
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    ld a, $30
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    xor a
    ld [wSpriteSlotCount], a

.check_arena_flags:
    ld a, [wArenaFlags]
    bit 7, a
    jr nz, .call_next_random_seed
    ld a, [wArenaRank]
    add a
    add a
    ld hl, SetupMap0BMonsterObjects_Data1
    add_a_to_hl
    ld a, [wRecordCapacity]
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    jr .set_temp2_to_01

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $1f
    ld hl, SetupMap0BMonsterObjects_Data2
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a

.set_temp2_to_01:
    ld a, $01
    ldh [hTemp2], a
    ld a, $04
    ldh [hTemp3], a
    ld hl, vTiles0 + $400
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld b, $00
    ld de, wEncounterMonsters
    ld hl, vTiles0 + $500

.loop:
    push hl
    push de
    push bc
    ld a, b
    add $05
    ldh [hTemp3], a
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    ld a, [de]
    ld [wMonsterId], a
    inc de
    ld a, [de]
    ld [wMonsterId + $1], a
    ld a, $02
    ldh [hTemp0], a
    ld de, hTemp0
    ld c, $00
    farcall CopyMonsterTableBytesFromMonsterTable
    pop bc
    push bc
    ld a, b
    swap a
    ld hl, wObject1 + OBJ_SPRITE_ID
    add_a_to_hl
    ldh a, [hTemp0]
    ld [hli], a
    ldh a, [hTemp1]
    ld [hl], a
    xor a
    ldh [hTemp2], a
    farcall DecompressGraphicsTemp0ToTemp4
    pop bc
    pop de
    pop hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $01
    ld h, a
    inc de
    inc de
    inc b
    ld a, b
    cp $03
    jr nz, .loop
    ret

; data read by SetupMap0BMonsterObjects (20 bytes) (E-0347)
SetupMap0BMonsterObjects_Data1::
    db $06, $19, $18, $00, $15, $09, $16, $00, $14, $1e, $2a, $00, $0d, $2b, $12, $00
    db $28, $11, $20, $00

SetupMap0BMonsterObjects_Data2::
    db $06, $07, $08, $09, $0a, $0b, $0c, $0d, $10, $11, $12, $13, $14, $15, $16, $1a
    db $1b, $1c, $1d, $21, $24, $25, $26, $28, $29, $2a, $2e, $2f, $33, $38, $39, $3d

; called from RandomGoldOrItem_ToRandomGoldOrItem_NextRandomSeed: branches on wTriggerKind; branches
; on wPendingFieldEvent; calls NextRandomSeed; sets wTriggerMarkerFlags to 0; sets
; wScriptStartRequest to $80; calls RandomGoldOrItem_NextRandomSeed_2; sets wTriggerMarkerFlags to
; $80; calls ComputePartyStrengthLevelPartyStrength; calls NextRandomSeed; sets wTriggerMarkerFlags;
; sets wTriggerMarkerFlags to $80; calls RandomGoldOrItem_NextRandomSeed_2; then 13 more steps (see
; the code) (E-0347)
; why: a helper of RandomGoldOrItem_ToRandomGoldOrItem_NextRandomSeed, in step 4 of RandomGoldOrItem
; (when wScriptStep = 4); RandomGoldOrItem: implements script command type 84
; (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched from ...
; (E-0352)
RandomGoldOrItem_NextRandomSeed::
    ld a, [wTriggerKind]
    cp $ff
    jr nz, .loop
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr nz, .loop
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_next_random_seed
    or a
    jr nz, .loop

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wRandomLo]
    and $1f
    jr z, .read_map_sprite_kind

.loop:
    xor a
    ld [wTriggerMarkerFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_map_sprite_kind:
    ld a, [wMapSpriteKind]
    swap a
    and $0f
    dec a
    jr nz, .set_trigger_marker_flags_to_80
    call RandomGoldOrItem_NextRandomSeed_2
    cp $05
    jr nc, .call_compute_party_strength_level_party
    ld a, $80
    ld [wTriggerMarkerFlags], a
    ld a, $2c
    jr .set_script_param1

.call_compute_party_strength_level_party:
    farcall ComputePartyStrengthLevelPartyStrength
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $1f
    sub $10
    ld c, a
    ld a, [wPartyStrength]
    add c
    bit 7, a
    jr z, .set_trigger_marker_flags
    ld a, $01

.set_trigger_marker_flags:
    or $80
    ld [wTriggerMarkerFlags], a
    ld a, $2c
    jr .set_script_param1

.set_trigger_marker_flags_to_80:
    push af
    ld a, $80
    ld [wTriggerMarkerFlags], a
    call RandomGoldOrItem_NextRandomSeed_2
    cp $32
    jr nc, .cp_46
    ld a, $00
    jr .skip2

.cp_46:
    cp $46
    jr nc, .cp_50
    ld a, $01
    jr .skip2

.cp_50:
    cp $50
    jr nc, .cp_5A
    ld a, $02
    jr .skip2

.cp_5A:
    cp $5a
    jr nc, .cp_5F
    ld a, $03
    jr .skip2

.cp_5F:
    cp $5f
    jr nc, .skip
    ld a, $04
    jr .skip2

.skip:
    ld a, $05

.skip2:
    ld c, a
    pop af
    dec a
    and $01
    add a
    add a
    add a
    add c
    ld hl, RandomGoldOrItem_NextRandomSeed_Data1
    add_a_to_hl
    ld a, [hl]

.set_script_param1:
    ld [wScriptParam1], a
    ld hl, RandomGoldOrItem_NextRandomSeed_Data2
    add_a_to_hl
    ld a, [hl]
    or a
    jp z, .loop
    ld [wTriggerKind], a
    farcall RandomGoldOrItem_DecompressToVRAM
    ld a, [wMessageIndex]
    ld [wTriggerCell], a
    ld a, [wMessageGroup]
    ld [wTriggerIndex], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Calls NextRandomSeed; may continue in RandomGoldOrItem_NextRandomSeed_2 (E-0347)
; why: part of RandomGoldOrItem_NextRandomSeed, in a helper of
; RandomGoldOrItem_ToRandomGoldOrItem_NextRandomSeed, in step 4 of RandomGoldOrItem (when
; wScriptStep = 4); RandomGoldOrItem: implements script command type 84
; (SCRIPT_RANDOM_GOLD_OR_ITEM): a key-world/field talk event (group $02, dispatched from ...
; (E-0352)
RandomGoldOrItem_NextRandomSeed_2::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $7f
    cp $63
    jr nc, RandomGoldOrItem_NextRandomSeed_2
    ret

; data read by RandomGoldOrItem_NextRandomSeed (16 bytes) (E-0347)
RandomGoldOrItem_NextRandomSeed_Data1::
    db $19, $1a, $1b, $1b, $1c, $2c, $00, $00, $01, $07, $28, $22, $0c, $2c, $00, $00

RandomGoldOrItem_NextRandomSeed_Data2::
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0a, $06, $00, $01

; for each party record adds 100 to the INT word (field $69), capped at 999; far-called by
; Talk00FC_YouHaveToEat (E-0129)
AddHundredToPartyINTCapped999::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

.loop:
    push hl
    ld a, [hl]
    ld c, MON_INT
    call SRAMRecordAddress
    push hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, $0064
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, d
    cp $03
    jr c, .skip2
    jr nz, .skip
    ld a, e
    cp $e7
    jr c, .skip2

.skip:
    ld de, $03e7

.skip2:
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; copies the 48-byte preset $5E11, $5E41 or $5E71 (C = 0, 1, other) to wSpeciesFlags (E-0124)
LoadSpeciesFlagsPresetC::
    ld a, c
    ld de, LoadSpeciesFlagsPresetC_Data1
    or a
    jr z, .skip
    ld de, LoadSpeciesFlagsPresetC_Data2
    dec a
    jr z, .skip
    ld de, LoadSpeciesFlagsPresetC_Data3

.skip:
    ld b, $30
    ld hl, wSpeciesFlags

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; data read by LoadSpeciesFlagsPresetC (15 bytes) (E-0347)
LoadSpeciesFlagsPresetC_Data1::
    db $fe, $ff, $ff, $07, $f0, $ff, $ff, $ff, $87, $ff, $ff, $ff, $7f, $fc, $3f
    ds $21, $00

LoadSpeciesFlagsPresetC_Data2::
    db $fe, $ff, $ff, $07, $f0, $ff, $ff, $ff, $87, $ff, $ff, $ff, $7f, $fc, $ff, $ff
    db $1f, $e0, $ff, $ff, $ff, $00, $ff, $ff, $ff, $03, $f8, $ff, $ff, $ff, $c1
    ds $11, $00

LoadSpeciesFlagsPresetC_Data3::
    db $fe, $ff, $ff, $07, $f0, $ff, $ff, $ff, $87, $ff, $ff, $ff, $7f, $fc, $ff, $ff
    db $1f, $e0, $ff, $ff, $ff, $00, $ff, $ff, $ff, $03, $f8, $ff, $ff, $ff, $c1, $ff
    db $ff, $ff, $01, $fe, $ff, $ff, $ff, $f1, $ff, $ff, $ff, $8f, $ff, $ff, $1f
    ds $2160, $00
