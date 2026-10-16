; ROM bank $85: story scenes: Limbo, the watch and others
; The annotated listing of this bank is build/listing/bank85.asm.

SECTION "Bank 85", ROMX[$4000], BANK[$85]
    db $85

; Runs one frame of script command type CF (SCRIPT_SCENE_KEY_SHOP) by wScriptStep: 0
; SceneKeyShop_CheckObject0Position, 1 SceneKeyShop_WalkRight. The script it belongs to shows 'How
; good of you to overcome' ... 'Welcome to my Key Shop!'; the messages are shown by the script
; commands around it. Reached through ScriptCommandCF in bank $10. (C2, E-0384)
; implements script command type CF (SCRIPT_SCENE_KEY_SHOP): a cutscene step named after the scene
; its only script shows: 'How good of you to overcome' ... 'Welcome to my Key Shop!'; reached
; through ScriptCommandCF in bank $10 (E-0038, E-0245)
SceneKeyShop::
    ld a, [wScriptStep]
    jumptable
    dw SceneKeyShop_CheckObject0Position
    dw SceneKeyShop_WalkRight

; Key shop scene, step 1: object 0 walks right one pixel a frame (StepObjectTowardCoord with object
; 0, direction 1, target X $60). When it reaches X $60 the facing byte of the slot (wSpriteSlots +
; $7) is cleared and wScriptStartRequest = $80 resumes the script. (C2, E-0384)
SceneKeyShop_WalkRight::
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

; Key shop scene, step 0: goes on to step 1 (SceneKeyShop_WalkRight). When object 0 (sprite slot 0,
; X = wSpriteSlots + $B) is not at X $50 it also sets wScriptStartRequest = $80 so the script
; resumes at once; at X $50 the scene waits and the walk of the next step runs. (C2, E-0384)
SceneKeyShop_CheckObject0Position::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wSpriteSlots + $b]
    cp $50
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command type CE (SCRIPT_HIDE_SPRITES): sets wSpriteSlotCount to 0, so the sprite slots are
; no longer drawn, and sets wScriptStartRequest = $80 so the next script command starts at once.
; Reached through ScriptCommandCE in bank $10. (C2, E-0384)
; implements script command type CE (SCRIPT_HIDE_SPRITES): wSpriteSlotCount = 0; reached through
; ScriptCommandCE in bank $10 (E-0038, E-0245)
HideSprites::
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Runs one frame of script command type 2A (SCRIPT_SCENE_WATCH_OUT) by wScriptStep (19 steps): 0
; SceneWatchOut_ShowHmYouAreQuite, 1 SceneWatchOut_WaitMessage, 2 SceneWatchOut_ShowTheFarmHasNo
; (the answer to the yes/no question: the farm and party room decide the message and the next step),
; 3 SceneWatchOut_Resume, 4 wait, 5 SceneWatchOut_ShowPickMonsterForFarm, 6 wait, 7
; SceneWatchOut_OpenPartyBox, 8 SceneWatchOut_BoxCursorStep, 9 SceneWatchOut_ShowLetMeJoinYour, 10
; to 12 SceneWatchOut_GatherUnlessFarmChoice, 13 SceneWatchOut_RestoreScreen, 14
; SceneWatchOut_CreateMonster, 15 SceneWatchOut_Finish, 16 SceneWatchOut_ShowNHeadedOffTo, 17
; SceneWatchOut_WalkObject1, 18 SceneWatchOut_BackToStep14. A monster asks to join the party of the
; player ('You can keep trying, but ...' ... 'Zzz Zzz Huh! Watch out!'); when the party is full the
; player chooses a member to send to the farm, and when the farm is full nothing is added. Reached
; through ScriptCommand2A in bank $10. (C1, E-0384)
; implements script command type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene
; its only script shows: 'You can keep trying, but you're...' ... 'Zzz Zzz Huh! Watch out!'; reached
; through ScriptCommand2A in bank $10 (E-0038, E-0245)
SceneWatchOut::
    ld a, [wScriptStep]
    jumptable
    dw SceneWatchOut_ShowHmYouAreQuite
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_ShowTheFarmHasNo
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_ShowPickMonsterForFarm
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_OpenPartyBox
    dw SceneWatchOut_BoxCursorStep
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_GatherUnlessFarmChoice
    dw SceneWatchOut_GatherUnlessFarmChoice
    dw SceneWatchOut_GatherUnlessFarmChoice
    dw SceneWatchOut_RestoreScreen
    dw SceneWatchOut_CreateMonster
    dw SceneWatchOut_Finish
    dw SceneWatchOut_ShowNHeadedOffTo
    dw SceneWatchOut_WalkObject1
    dw SceneWatchOut_BackToStep14

; Watch Out scene, step 16: creates the new monster on the farm, a record of kind 5
; (CreateMonsterRecordOfKindTemp1 with hTemp1 = 5, hTemp2 = wArg5 as the record slot, hTemp3 = 1 as
; the state, so the record is a kept monster; its species word is $014F), starts message $0D52
; (MSG_KEEP_OPEN | $0D52, '<name> headed off to the farm.'), takes one off wSpriteSlotCount and
; subtracts 1 from wScriptStep, so the next step is step 15 which waits for the message and finishes
; the scene. (C2, E-0384)
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

; Watch Out scene, step 15: after the message restores the screen and sprites, plays the map music,
; sets EVENT_SCENE_WATCH_OUT_078 and resumes the script. (C1, E-0357)
SceneWatchOut_Finish::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    farcall RestoreScreenBufferFromBGMap1
    ld hl, wSpriteSlotCount
    dec [hl]
    farcall DrawFullScreenBufferAtScroll
    farcall ResumeFieldAnimation
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall PlayMapMusic
    ld de, EVENT_SCENE_WATCH_OUT_078
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Watch Out scene, step 14: creates the new monster in the party (record kind 5, hTemp3 2) in place
; wScriptMsgSelect - 1, with its follower position from object 0, reorders the party, reloads the
; name tiles and sprites and shows '<name> joined the party.' (C1, E-0357)
SceneWatchOut_CreateMonster::
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

; Watch Out scene, step 13: restores the screen; choice 3 (no party member picked) goes to the farm
; (step $10); otherwise sends the chosen member to the farm (CopyRecordFields5DTo5BAnd61To5FAndMark)
; and the new monster takes its place (step 14). (C1, E-0357)
SceneWatchOut_RestoreScreen::
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
    jp SceneWatchOut_CreateMonster

; Watch Out scene, step 7: draws the names, opens the party box (ShowBoxFromTable) with the cursor
; on the first and freezes the player and objects. (C1, E-0357)
SceneWatchOut_OpenPartyBox::
    ld de, vTiles1 + $6e0
    call CopyGlyphTilesToVRAM
    xor a
    ld [wScriptSubStep], a
    ld [wScriptMsgSelect], a
    call ShowBoxFromTable
    farcall FreezeFieldAnimation
    ld hl, wScriptStep
    inc [hl]
    ret

; Watch Out scene, step 2: after the yes/no: no gives '... Oh, but... I can be ...' (message $0D12);
; a full farm '... The farm has no room ...' ($0D57); a party with room '... We are partners, and
; good ...' ($01B8) and the joining steps ($11); a full party "... Your party's full... There isn't
; ..." ($0D11) and the choice of who goes. (C1, E-0357)
SceneWatchOut_ShowTheFarmHasNo::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b852
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .check_party_count
    ld hl, MSG_ALREADY_OPEN | $0d57 ; '*: …The farm has no room'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .call_start_message_hl_b85
    ld hl, MSG_ALREADY_OPEN | $01b8 ; '*: We are partners, and good'
    call StartMessageHL_B85
    farcall SaveScreenBufferToBGMap1
    ld a, [wPartyCount]
    inc a
    ld [wScriptMsgSelect], a
    ld a, $11
    ld [wScriptStep], a
    ret

.call_start_message_hl_b85:
    ld hl, MSG_ALREADY_OPEN | $0d11 ; '*: Your party's full… There isn't'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b852:
    ld hl, MSG_ALREADY_OPEN | $0d12 ; '*: Oh, but… I can be'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Watch Out scene, step 0: stores the default name of the new monster, the glyphs of 'Squiz' ended
; by $F0, in wNameGlyphBuf and again in wTextBuf1 + 7 (the text buffer the message reads), starts
; message $0D0F (MSG_KEEP_OPEN | $0D0F, '... Hm, you are quite strong...') and goes on to step 1.
; (C2, E-0384)
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

; Runs one frame of script command type 4D (SCRIPT_SCENE_WATER_REWARD) by wScriptStep (19 steps),
; the same shape as SceneWatchOut with its own messages and monster: 0
; SceneWaterReward_ShowCoohIHeardFrom, 1 SceneWatchOut_WaitMessage, 2
; SceneWaterReward_ShowWaitTheFarmIs, 3 SceneWatchOut_Resume, 4 wait, 5
; SceneWatchOut_ShowPickMonsterForFarm, 6 wait, 7 SceneWaterReward_OpenPartyBox, 8
; SceneWatchOut_BoxCursorStep, 9 SceneWatchOut_ShowLetMeJoinYour, 10 to 12
; SceneWatchOut_GatherUnlessFarmChoice, 13 SceneWaterReward_WalkObject1, 14
; SceneWaterReward_CreateMonster, 15 SceneWaterReward_Finish, 16 SceneWaterReward_ShowNHeadedOffTo,
; 17 SceneWatchOut_WalkObject1, 18 SceneWatchOut_BackToStep14. The monster it offers is a record of
; kind 0 and it ends by setting EVENT_SCENE_WATER_REWARD. Reached through ScriptCommand4D in bank
; $10. (C1, E-0384)
; implements script command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the
; scene its only script shows: 'King This should solve the water...' (creates a monster record);
; reached through ScriptCommand4D in bank $10 (E-0038, E-0245)
SceneWaterReward::
    ld a, [wScriptStep]
    jumptable
    dw SceneWaterReward_ShowCoohIHeardFrom
    dw SceneWatchOut_WaitMessage
    dw SceneWaterReward_ShowWaitTheFarmIs
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_ShowPickMonsterForFarm
    dw SceneWatchOut_WaitMessage
    dw SceneWaterReward_OpenPartyBox
    dw SceneWatchOut_BoxCursorStep
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_GatherUnlessFarmChoice
    dw SceneWatchOut_GatherUnlessFarmChoice
    dw SceneWatchOut_GatherUnlessFarmChoice
    dw SceneWaterReward_WalkObject1
    dw SceneWaterReward_CreateMonster
    dw SceneWaterReward_Finish
    dw SceneWaterReward_ShowNHeadedOffTo
    dw SceneWatchOut_WalkObject1
    dw SceneWatchOut_BackToStep14

; Watch Out scene, step 18: after the message goes to step $0E. (C1, E-0357)
SceneWatchOut_BackToStep14::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    ld a, $0e
    ld [wScriptStep], a
    ret

; Watch Out scene, step 17 (and the walk of the Water reward scene, which also uses it): moves
; object 1 one unit a frame the way it faces (StepObjectCoordByDirection16Frames with HL = wObject1
; + OBJ_STATE); after 16 frames (one tile) wScriptStep goes on, which leads to step 18 and back to
; step 14. (C2, E-0384)
SceneWatchOut_WalkObject1::
    ld hl, wObject1 + OBJ_STATE
    call StepObjectCoordByDirection16Frames
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; Water reward scene, step 16: creates the new monster on the farm, a record of kind 0
; (CreateMonsterRecordOfKindTemp1 with hTemp1 = 0, hTemp2 = wArg5 as the record slot, hTemp3 = 1 as
; the state, so the record is a kept monster; its species word is $004F), starts message $0D52
; (MSG_KEEP_OPEN | $0D52, '<name> headed off to the farm.'), takes one off wSpriteSlotCount and
; subtracts 1 from wScriptStep, so the next step is step 15 which waits for the message and finishes
; the scene. (C2, E-0384)
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

; Water reward scene, step 15: after the message restores the screen and sprites, plays the map
; music, sets EVENT_SCENE_WATER_REWARD and resumes the script. (C1, E-0357)
SceneWaterReward_Finish::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    farcall RestoreScreenBufferFromBGMap1
    ld hl, wSpriteSlotCount
    dec [hl]
    farcall DrawFullScreenBufferAtScroll
    farcall ResumeFieldAnimation
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall PlayMapMusic
    ld de, EVENT_SCENE_WATER_REWARD
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Water reward scene, step 14: creates the new monster in the party (record kind 0) with its
; follower position from object 1, reorders the party, reloads the names and sprites and shows
; '<name> joined the party.' (C1, E-0357)
SceneWaterReward_CreateMonster::
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

; Water reward scene, step 13: object 1 walks one tile; then restores the screen and, with choice 3,
; goes to the farm (step $10), otherwise sends the chosen member to the farm and the new monster
; joins (step 14). (C1, E-0357)
SceneWaterReward_WalkObject1::
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
    jp SceneWaterReward_CreateMonster

; Moves a script object one unit per frame in the direction stored at its first byte. HL = the
; object (a byte of direction 0 down, 1 right, 2 up, 3 left at [HL]; the coordinates at HL + 4 (X)
; and HL + 5 (Y)): direction 0 adds 1 to Y, 1 adds 1 to X, 2 subtracts 1 from Y, 3 subtracts 1 from
; X. It counts the frames in wScriptParam0; at the 16th frame wScriptParam0 is reset to 0 and A = 1,
; otherwise A = 0. The Watch Out and Water reward scenes call it with HL = wObject1 + OBJ_STATE, so
; an object walks one 16-pixel tile the way it faces. (C2, E-0384)
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

; Watch Out scene, steps 10 to 12 (also in SceneWaterReward): when wScriptMsgSelect is 3 (no party
; member was picked, the new monster goes to the farm) it goes on to the next step at once;
; otherwise it runs ScriptStepMoveFollowersToLeader (first frame: sets the follower targets and
; wScriptParam0 = 1; later frames step the followers; when wScriptParam0 reaches $11 wScriptStep
; advances). (C2, E-0384)
SceneWatchOut_GatherUnlessFarmChoice::
    ld a, [wScriptMsgSelect]
    cp $03
    jr nz, .call_script_step_move_followers_to_leader
    ld hl, wScriptStep
    inc [hl]
    ret

.call_script_step_move_followers_to_leader:
    farcall ScriptStepMoveFollowersToLeader
    ret

; Watch Out scene, step 9 (B in the box): restores the screen, asks '... Let me join your party?'
; ($0D56) again and returns to step 1. (C1, E-0357)
SceneWatchOut_ShowLetMeJoinYour::
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0d56 ; '*: Let me join your party?'
    call StartMessageHL_B85
    farcall ResumeFieldAnimation
    ld a, $01
    ld [wScriptStep], a
    ret

; Watch Out scene, step 8: the box cursor (below). (C1, E-0357)
SceneWatchOut_BoxCursorStep::
    call PartyBoxCursor
    ret

; Water reward scene, step 7: draws the names, opens the party box and freezes the player and
; objects. (C1, E-0357)
SceneWaterReward_OpenPartyBox::
    ld de, vTiles1 + $6e0
    call CopyGlyphTilesToVRAM
    xor a
    ld [wScriptSubStep], a
    ld [wScriptMsgSelect], a
    call ShowBoxFromTable
    farcall FreezeFieldAnimation
    ld hl, wScriptStep
    inc [hl]
    ret

; Watch Out scene, step 5 (the Water reward scene uses it too): starts message $0D50 (MSG_KEEP_OPEN
; | $0D50, 'Pick the monster to go to ...') and goes on to the next step. This routine is entry 5 of
; SceneWatchOut and of SceneWaterReward. (C2, E-0384)
SceneWatchOut_ShowPickMonsterForFarm::
    ld hl, MSG_KEEP_OPEN | $0d50 ; 'Pick the monster to go to'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Water reward scene, step 2: after the yes/no: no gives '... Tch, I think I can ...' ($01BA); a
; full farm '... Wait, the farm is full...' ($0D55); a party with room '... We are partners ...'
; ($01B8) and the joining steps; a full party '... But you have no room ...' ($01B9) and the choice
; of who goes. (C1, E-0357)
SceneWaterReward_ShowWaitTheFarmIs::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b852
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr nz, .check_party_count
    ld hl, MSG_ALREADY_OPEN | $0d55 ; '*: …Wait, the farm is full…'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .call_start_message_hl_b85
    ld hl, MSG_ALREADY_OPEN | $01b8 ; '*: We are partners, and good'
    call StartMessageHL_B85
    farcall SaveScreenBufferToBGMap1
    ld a, [wPartyCount]
    inc a
    ld [wScriptMsgSelect], a
    ld a, $11
    ld [wScriptStep], a
    ret

.call_start_message_hl_b85:
    ld hl, MSG_ALREADY_OPEN | $01b9 ; '*: …But you have no room'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b852:
    ld hl, MSG_ALREADY_OPEN | $01ba ; '*: Tch, I think I can'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Water reward scene, step 0: stores the default name of the new monster, the glyphs of 'Biino'
; (plus a blank glyph $90 in wNameGlyphBuf only) ended by $F0, in wNameGlyphBuf and, without the
; blank, in wTextBuf1 + 7 (the text buffer the message reads), starts message $01B7 (MSG_KEEP_OPEN |
; $01B7, '... Cooh, I heard from others ...') and goes on to step 1. (C2, E-0384)
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

; The party box cursor: B goes on one step; A marks the choice ($BC, sound $69) and goes on two;
; Up/Down move it (sound $69); the cursor blinks every 8 frames. (C1, E-0357)
PartyBoxCursor::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld hl, wScriptStep
    inc [hl]
    ret

.check_bit0:
    bit 0, a
    jr z, .check_bit6
    call PartyBoxCursor_RowTileAddress
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
    call PartyBoxCursor_RowTileAddress
    ld a, $c3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    dec [hl]
    ld a, $69
    call QueueSoundEffect
    jr .call_party_box_cursor_row_tile_address

.check_bit7:
    bit 7, a
    jr z, .call_party_box_cursor_row_tile_address
    call PartyBoxCursor_RowTileAddress
    ld a, $c3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    inc [hl]
    ld a, $69
    call QueueSoundEffect

.call_party_box_cursor_row_tile_address:
    call PartyBoxCursor_RowTileAddress
    ld c, $bb
    ld a, [wFrameCounterLo]
    bit 3, a
    jr z, .call_write_vram_byte
    ld c, $c3

.call_write_vram_byte:
    ld a, c
    call WriteVRAMByte
    ret

; Finds the party box cursor place for the row in wScriptMsgSelect. First wScriptMsgSelect is masked
; with 3 and stored back. Returns HL = $9800 + 4 * ((hScrollY + 16 * row + 8) & $F8) with the high
; byte masked with $9B (wrapping inside the map) + (hScrollX + 8) / 8, the BG map entry beside the
; box row. PartyBoxCursor writes the cursor tile $BC or a blank $C3 there. A and C are clobbered.
; (C2, E-0384)
PartyBoxCursor_RowTileAddress::
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

; Opens the party box: saves the screen buffer to BG map 1 (SaveScreenBufferToBGMap1), copies the 8
; x 9 tile rectangle ShowBoxFromTable_TileRect into wScreenTileBuffer (rows 20 bytes apart), on a
; CGB clears the same rectangle of the attribute buffer wScreenAttrBuffer in WRAM bank 2 (then
; selects bank 0), draws the buffer at the scroll position (DrawScreenBufferAtScrollOrigin) and
; queues sound effect $6C. Called by SceneWatchOut_OpenPartyBox and SceneWaterReward_OpenPartyBox.
; (C1, E-0384)
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

; Draws the 20 x 18 screen buffer to the background map at the place of the current scroll: DE =
; $9800 + 4 * (hScrollY & $F8) with its high byte masked with $9B (wrapping inside the 32 x 32 map)
; + hScrollX / 8, then DrawScreenBufferToBGMapWithAttrs with HL = that address. Callers:
; ShowBoxFromTable, SceneWatchOut_RestoreScreen and SceneWaterReward_WalkObject1. (C1, E-0384)
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

; A = a party index: takes the record number from wPartyList[A] and, in that SRAM record, sets
; MON_HP to MON_MAX_HP, MON_MP to MON_MAX_MP, clears MON_STATUS and sets MON_STATE to 1 (a kept
; monster, not in the party). The scenes SceneWatchOut_RestoreScreen and
; SceneWaterReward_WalkObject1 use it to send the chosen party member to the farm, fully healed. It
; enables SRAM (rRAMG = $0A) and disables it at the end; the SRAM bank is whatever is mapped. (C2,
; E-0384)
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

; Runs one frame of script command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES) by wScriptStep: 0
; SceneWarubouLeaves_WalkObjects, 1 SceneWarubouLeaves_WalkUp, 2 SceneWarubouLeaves_WalkAway, 3
; SceneWarubouLeaves_WalkOff. The two objects (Warubou and a companion) walk off the screen; the
; script it belongs to has the lines '...Warubou!' ... 'Have you heard about Magic Keys?'. Reached
; through ScriptCommand1B in bank $10. (C2, E-0384)
; implements script command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the
; scene its only script shows: 'C'mon, Warubou!' ... 'Have you heard about Magic Keys?'; reached
; through ScriptCommand1B in bank $10 (E-0038, E-0245)
SceneWarubouLeaves::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouLeaves_WalkObjects
    dw SceneWarubouLeaves_WalkUp
    dw SceneWarubouLeaves_WalkAway
    dw SceneWarubouLeaves_WalkOff

; Warubou leaves, step 3: objects 1 and 2 (sprite slots) both walk left one pixel a frame towards X
; $E0 (StepObjectTowardCoord, direction 3). Only the arrival of the second walk (object 2) is
; tested: when wStepArrived is set the script resumes (wScriptStartRequest = $80). (C2, E-0384)
SceneWarubouLeaves_WalkOff::
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

; Warubou leaves, step 2: object 1 walks left one pixel a frame towards X $E0 while object 2 walks
; up towards Y $20 (StepObjectTowardCoord, directions 3 and 2); then
; SceneWarubouLeaves_NextStepOnArrival advances wScriptStep when the walk of object 2 (the second
; one) has arrived. (C2, E-0384)
SceneWarubouLeaves_WalkAway::
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
    jr SceneWarubouLeaves_NextStepOnArrival

; Warubou leaves, step 1: object 2 walks up one pixel a frame towards Y $30 and object 1 towards Y
; $20 (StepObjectTowardCoord, direction 2); then SceneWarubouLeaves_NextStepOnArrival advances
; wScriptStep when the walk of object 1 (the second one) has arrived. (C2, E-0384)
SceneWarubouLeaves_WalkUp::
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
    jr SceneWarubouLeaves_NextStepOnArrival

; Warubou leaves, step 0: object 1 walks up one pixel a frame towards Y $50 and object 2 walks left
; towards X $40 (StepObjectTowardCoord, directions 2 and 3); it continues in
; SceneWarubouLeaves_NextStepOnArrival, which advances wScriptStep when the walk of object 2 (the
; second one) has arrived. (C2, E-0384)
SceneWarubouLeaves_WalkObjects::
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

; Shared tail of the Warubou leaves steps: when wStepArrived is non-zero (the last
; StepObjectTowardCoord has reached its target) wScriptStep is incremented, otherwise nothing
; changes. (C2, E-0384)
SceneWarubouLeaves_NextStepOnArrival::
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs one frame of script command type 7A (SCRIPT_SCENE_KAMEHA_MISSING). Step 0 (wScriptStep = 0):
; runs field command 5 (RunFieldCommandTemp0 with hTemp0 = 5, which jumps to
; RunFieldCommandTemp0_LoadSceneObject5, loading a sprite into wObject5 and marking it shown), puts
; object 5 (wObject5) at X $50, Y $10 and goes to step 1. In step 1 it counts wScriptParam0 up to
; $28 (40 frames), then hides object 5 (wObject5 = 0) and asks for the next script command
; (wScriptStartRequest = $80). The script it belongs to comes before the message 'Prince Kameha has
; been missing from...'. Reached through ScriptCommand7A in bank $10. (C1, E-0384)
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

; Runs one frame of script command type 78 (SCRIPT_SAVE_SCREEN) by wScriptStep: 0
; SaveScreen_OpenGiftMenu (keeps the screen in BG map 1 and switches to game mode 2, the gift menu),
; 1 SaveScreen_SetScriptStartRequestTo80 (the script resumes). Reached through ScriptCommand78 in
; bank $10. (C1, E-0384)
; implements script command type 78 (SCRIPT_SAVE_SCREEN): saves the screen buffer to BG map 1
; (SaveScreenBufferToBGMap1); reached through ScriptCommand78 in bank $10 (E-0038, E-0245)
SaveScreen::
    ld a, [wScriptStep]
    jumptable
    dw SaveScreen_OpenGiftMenu
    dw SaveScreen_SetScriptStartRequestTo80

; Save screen, step 1: asks for the next script command (wScriptStartRequest = $80). Entry 1 of
; SaveScreen; the game comes back here after the gift menu of step 0 closes. (C2, E-0384)
SaveScreen_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step 0 of SaveScreen (script command 78, run after 'What will you give to the ...' by
; Script_WhatWillYouGive and Script_YHasBeenGiven): keeps the screen in BG map 1
; (SaveScreenBufferToBGMap1), sets wFieldReturnPhase = 1 and switches to game mode 2 with wModeState
; = $0C and wWorldMapState = 0, so GameMode2_Update builds page $0C & 7 = 4 (the item list) and then
; runs PauseMenu_State4, the 'Gift / Exit' menu (PauseMenu_State4_GiftMenu); clears wTemp0, wTemp1,
; wJoypadHeld, wJoypadPressed and wScriptRunning (stopping the script) and advances wScriptStep.
; (C1, E-0371)
SaveScreen_OpenGiftMenu::
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

; Script command type 7D (SCRIPT_SCENE_THIS_WAY): sets wScriptStartRequest = $80 first, so the
; script resumes at once. Then, unless hMapScreenY is 2, it turns the people on this screen: it
; picks a row of 4 bytes from SceneThisWay_Data1 (hMapScreenY = 0) or SceneThisWay_Data2 (any other
; value), at offset hMapScreenX * 4, and writes the bytes one after another to the facing byte of
; sprite slots 0, 1, 2 ... (wSpriteSlots + $7, + $17, ...) until the $FF that ends the row. Reached
; through ScriptCommand7D in bank $10. (C2, E-0384)
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

; Three rows of four bytes, chosen by hMapScreenX times 4 and used when hMapScreenY is 0: ($00, $00,
; $01, $FF), ($00, $FF, ...) and ($03, $01, $00, $FF). SceneThisWay writes the bytes one after
; another to wSpriteSlots + 7, then +$17, +$27 and so on (byte 7 of each 16-byte sprite slot, the
; facing) until it reaches $FF. (C1, E-0381)
SceneThisWay_Data1::
    db $00, $00, $01, $ff, $00, $ff, $ff, $ff, $03, $01, $00, $ff

; Three rows of four bytes, chosen by hMapScreenX times 4 and used when hMapScreenY is 1: ($01, $03,
; $02, $FF), ($01, $FF, ...) and ($02, $02, $01, $FF). SceneThisWay writes the bytes one after
; another to byte 7 (the facing) of consecutive 16-byte sprite slots in wSpriteSlots until it
; reaches $FF; when hMapScreenY is 2 it does nothing. (C1, E-0381)
SceneThisWay_Data2::
    db $01, $03, $02, $ff, $01, $ff, $ff, $ff, $02, $02, $01, $ff

; Runs one frame of script command type 7F (SCRIPT_SCENE_CHEST_SERVANT) by wScriptStep (6 entries):
; 0 SceneChestServant_HidePlayer, 1 to 3 SceneChestServant_WalkUp, 4 SceneChestServant_Warp (puts
; the player and the followers at X $E0, sets the map to $48, screen (8, 7), destination ($40, $40)
; and starts a fade), 5 SceneChestServant_SetScriptStartRequestTo80. The player walks up and out of
; the picture while the hero and followers vanish one by one, then the game warps. The script it
; belongs to has '0 checked the treasure chest.' ... 'How may we serve your mortal...'. Reached
; through ScriptCommand7F in bank $10. (C1, E-0384)
; implements script command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the
; scene its only script shows: '0 checked the treasure chest.' ... 'How may we serve your
; mortal...'; reached through ScriptCommand7F in bank $10 (E-0038, E-0245)
SceneChestServant::
    ld a, [wScriptStep]
    jumptable
    dw SceneChestServant_HidePlayer
    dw SceneChestServant_WalkUp
    dw SceneChestServant_WalkUp
    dw SceneChestServant_WalkUp
    dw SceneChestServant_Warp
    dw SceneChestServant_SetScriptStartRequestTo80

; Chest servant scene, step 5: asks for the next script command (wScriptStartRequest = $80). (C2,
; E-0384)
SceneChestServant_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Chest servant scene, step 4: puts the player and followers at X $E0 and warps to map $48, screen
; (8, 7), position ($40, $40) with a fade. (C1, E-0357)
SceneChestServant_Warp::
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

; Chest servant scene, steps 1 to 3: walks the player up one pixel a frame
; (StepPlayerUpTowardStepPtrLo) towards Y = $10 - 16 * wScriptParam0, so the stops are Y $10, $00
; and $F0. When the player arrives, hFieldDrawFlags is shifted left one bit with bit 0 set (hiding
; the next follower), wScriptParam0 is incremented and wScriptStep advances. Until then it only
; moves the player. (C2, E-0384)
SceneChestServant_WalkUp::
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

; Chest servant scene, step 0: queues sound effect $65, sets hFieldDrawFlags = 1 (bit 0 makes the
; player sprite not drawn, so the player is hidden), clears wScriptParam0 and goes on to the walk
; steps 1 to 3 (SceneChestServant_WalkUp). (C2, E-0384)
SceneChestServant_HidePlayer::
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command type 7E (SCRIPT_SCENE_GOT_TO): blinks object 5 (wObject5 = $80 shown, 0 hidden) for
; 120 frames, counting wScriptParam0: while it is below $1E the object is shown when bit 3 of the
; count is clear (every 8 frames), below $3C when bit 2 is clear (every 4 frames), above that when
; bit 1 is clear (every 2 frames), so the blink speeds up. When the count reaches $78 the object is
; hidden and wScriptStartRequest = $80 asks for the next script command (the count is not reset).
; Reached through ScriptCommand7E in bank $10. (C2, E-0384)
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

; Script command type 74 (SCRIPT_SET_FLAG_REDRAW): takes hPlayerX, adds $10 when hPlayerFacing is 1
; or subtracts $10 when it is 3 (other facings leave it), and searches SetFlagRedraw_Data ($20, $40,
; $50, $80) for that value with B counting the entries passed; there is no end check, so a value
; that is not in the list would run on into the bytes after it. Then it sets story flag $01CF + B
; (SetFlagBit), calls ApplyMapScreenFlagEvents and DrawFullScreenBufferAtScroll to redraw the screen
; and sets wScriptStartRequest = $80. Used after the message '0 checked the treasure chest.'
; (Script_HeroCheckedTheTreasure_3). Reached through ScriptCommand74 in bank $10. (C1, E-0384)
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

; Four X positions, $20, $40, $50 and $80, of treasure chests on the map. SetFlagRedraw takes
; hPlayerX, adds $10 when the player faces right or subtracts $10 when facing left, searches the
; list for that value (there is no end check) and sets the story flag $01CF plus the position in the
; list before redrawing the screen. (C1, E-0381)
SetFlagRedraw_Data::
    db $20, $40, $50, $80

; Runs one frame of script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2) by wScriptStep (5
; steps): 0 start the scripted battle (encounter $30), 1 the result and the key, 2 wait for the
; message, 3 the key message, 4 resume the script; the entries are
; SceneKamehaKeyBattle2_StartBattle, SceneKamehaKeyBattle2_AfterBattle, SceneWatchOut_WaitMessage,
; SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic, SceneWatchOut_Resume. Kameha challenges the player
; and gives a key for winning ('Kameha ... confident, huh?'). Reached through ScriptCommand72 in
; bank $10. (C1, E-0384)
; implements script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2): a cutscene step named after
; the scene its only script shows: the same scene as SCRIPT_SCENE_KAMEHA_KEY_BATTLE; reached through
; ScriptCommand72 in bank $10 (E-0038, E-0245)
SceneKamehaKeyBattle2::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaKeyBattle2_StartBattle
    dw SceneKamehaKeyBattle2_AfterBattle
    dw SceneWatchOut_WaitMessage
    dw SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic
    dw SceneWatchOut_Resume

; Second Kameha key battle, step 3: starts the message about the key just given and goes on to step
; 4. wScriptParam0 = 1 (a story key was written by step 1) gives message $0BC2 ('0 received the
; Magic Key.'); wScriptParam0 = 0 (a generated key) gives message $0B9D. (C2, E-0384)
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

; Second Kameha key battle, step 1: after the battle. If wBattleScene is non-zero (battle lost) it
; starts message $0B97 ('Kameha: Wahahahah! ... weak!') and sets wScriptStep = 4. After a win it
; sets EVENT_SCENE_KAMEHA_KEY_BATTLE2. If the key list has no story key of kind 9
; (KeyListHasKindTemp0) the key is written to the first free entry (CountKeysOrFull, then
; WriteKeyEntryTemp0 with kind 9, or $49 once EVENT_KEY_BOSS_BEATEN_2_205 is set), wScriptParam0 =
; 1; if one is held a generated key is added instead (GenerateNewKeyEntry, wScriptParam0 = 0) and a
; failure there (no free entry) shows message $0B9E and sets wScriptStep = 4. A given key sets
; EVENT_HERO_RECEIVED_THE_TRAVELER_KEY, starts message $0B9C and goes on to step 2. (The 'list is
; full' test of CountKeysOrFull cannot be reached: a missing kind is only reported when an unused
; entry exists.) (C2, E-0384)
SceneKamehaKeyBattle2_AfterBattle::
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

; Kameha's second key battle, step 0: starts scripted encounter $30. (C1, E-0357)
SceneKamehaKeyBattle2_StartBattle::
    ld a, $30
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs one frame of script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE) by wScriptStep (5
; steps): 0 start the scripted battle (encounter $2F), 1 the result and the key, 2 wait for the
; message, 3 the key message, 4 resume the script; the entries are SceneKamehaKeyBattle_StartBattle,
; SceneKamehaKeyBattle_AfterBattle, SceneWatchOut_WaitMessage,
; SceneKamehaKeyBattle_ShowHeroReceivedTheMagic, SceneWatchOut_Resume. Kameha challenges the player
; and gives a key for winning ('Kameha ... confident, huh?'). Reached through ScriptCommand71 in
; bank $10. (C1, E-0384)
; implements script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE): a cutscene step named after
; the scene its only script shows: 'Kameha So you're confident, huh?' (key entry and encounter);
; reached through ScriptCommand71 in bank $10 (E-0038, E-0245)
SceneKamehaKeyBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaKeyBattle_StartBattle
    dw SceneKamehaKeyBattle_AfterBattle
    dw SceneWatchOut_WaitMessage
    dw SceneKamehaKeyBattle_ShowHeroReceivedTheMagic
    dw SceneWatchOut_Resume

; Kameha key battle, step 3: starts the message about the key just given and goes on to step 4.
; wScriptParam0 = 1 (a story key was written by step 1) gives message $0BC2 ('0 received the Magic
; Key.'); wScriptParam0 = 0 (a generated key) gives message $0B93. (C2, E-0384)
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

; Kameha key battle, step 1: after the battle. If wBattleScene is non-zero (battle lost) it starts
; message $0B97 ('Kameha: Wahahahah! ... weak!') and sets wScriptStep = 4. After a win it sets
; EVENT_SCENE_KAMEHA_KEY_BATTLE. If the key list has no story key of kind 7 (KeyListHasKindTemp0)
; the key is written to the first free entry (CountKeysOrFull, then WriteKeyEntryTemp0 with kind 7,
; or $47 once EVENT_KEY_BOSS_BEATEN_203 is set), wScriptParam0 = 1; if one is held a generated key
; is added instead (GenerateNewKeyEntry, wScriptParam0 = 0) and a failure there (no free entry)
; shows message $0B94 and sets wScriptStep = 4. A given key sets EVENT_HERO_RECEIVED_THE_ELF_KEY,
; starts message $0B92 and goes on to step 2. (The 'list is full' test of CountKeysOrFull cannot be
; reached: a missing kind is only reported when an unused entry exists.) (C2, E-0384)
SceneKamehaKeyBattle_AfterBattle::
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

; Kameha's key battle, step 0: starts scripted encounter $2F. (C1, E-0357)
SceneKamehaKeyBattle_StartBattle::
    ld a, $2f
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs one frame of script command type 7B (SCRIPT_SCENE_ARENA_CHALLENGE) by wScriptStep (3 steps):
; 0 SceneArenaChallenge_StartBattle (starts scripted encounter $15 and goes on), 1
; SceneArenaChallenge_ShowAwwILoseYou, 2 SceneWatchOut_Resume. The script before it says 'Really?'
; about going to the Arena. Reached through ScriptCommand7B in bank $10. (C1, E-0384)
; implements script command type 7B (SCRIPT_SCENE_ARENA_CHALLENGE): a cutscene step named after the
; scene its only script shows: 'Really? Let's go to the Arena!' (encounter); reached through
; ScriptCommand7B in bank $10 (E-0038, E-0245)
SceneArenaChallenge::
    ld a, [wScriptStep]
    jumptable
    dw SceneArenaChallenge_StartBattle
    dw SceneArenaChallenge_ShowAwwILoseYou
    dw SceneWatchOut_Resume

; Arena challenge, step 1: goes on to step 2 and starts a message by the result of the scripted
; battle: wBattleScene = 0 (the player won) gives message $0D82 ('*: Aww... I lose. You are ...'),
; otherwise message $0D83 ('*: Yay! I won! ...'). (C2, E-0384)
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

; Arena challenge, step 0: starts scripted encounter $15. (C1, E-0357)
SceneArenaChallenge_StartBattle::
    ld a, $15
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs one frame of script command type 7C (SCRIPT_SCENE_TERRY_BATTLE) by wScriptStep (3 steps): 0
; SceneTerryBattle_Start (sets EVENT_SCENE_TERRY_BATTLE, starts scripted encounter $14 and goes on),
; 1 SceneTerryBattle_ShowTerryWellThisProves, 2 SceneWatchOut_Resume. Terry challenges the player
; ('Terry Humph Confident, huh?'). Reached through ScriptCommand7C in bank $10. (C1, E-0384)
; implements script command type 7C (SCRIPT_SCENE_TERRY_BATTLE): a cutscene step named after the
; scene its only script shows: 'Terry Humph Confident, huh?' (encounter); reached through
; ScriptCommand7C in bank $10 (E-0038, E-0245)
SceneTerryBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneTerryBattle_Start
    dw SceneTerryBattle_ShowTerryWellThisProves
    dw SceneWatchOut_Resume

; Terry battle scene, step 1: goes on to step 2 and starts a message by the result of the scripted
; battle. wBattleScene = 0 (the player won): message $0BB1 ('Terry: Well, this proves that I ...'),
; wLinkSetting = 1 and EVENT_SCENE_TERRY_BATTLE_038 is set. Otherwise (lost): message $0BB2 ('Terry:
; Humph...'). (C2, E-0384)
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

; Terry's battle, step 0: sets EVENT_SCENE_TERRY_BATTLE and starts scripted encounter $14. (C1,
; E-0357)
SceneTerryBattle_Start::
    ld de, EVENT_SCENE_TERRY_BATTLE
    call SetFlagBit
    ld a, $14
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs one frame of script command type 70 (SCRIPT_SCENE_TERRY). Step 0 (wScriptStep = 0) warps the
; player: hMapScreenX and hMapScreenY = 0, wWarpDestY = $80, wFieldTransitionKind = 3; when hPlayerX
; is $20 the destination is map $0F with wWarpDestX $20, otherwise it is map $0F when
; EVENT_THANKS_FOR_COMING_BY_025 is set and map $10 when it is clear, with wWarpDestX $70; then
; ScriptStartFadeAndAdvanceStep and StartPaletteFade with A = 4 run. Any later step only sets
; wScriptStartRequest = $80. The script it belongs to has '0 obtained the Magic Key.' ... 'Humph ...
; a master'. Reached through ScriptCommand70 in bank $10. (C1, E-0384)
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

; Script command type 6F (SCRIPT_DESK_KEY), the desk animation before the key message. Step 0
; (wScriptStep = 0): every frame adds 1 to the Y of object 1 (wObject1 + OBJ_Y) and then the hop
; delta (ScriptApplyStepDeltaAtDE_Bank85), 16 frames in all; on the 16th frame wSpriteSlotCount = 1
; (only the first slot is drawn) and wScriptStep goes to 1. Any later step sets wScriptStartRequest
; = $80 so the script resumes. Reached through ScriptCommand6F in bank $10. (C2, E-0384)
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

; Runs one frame of script command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2) by wScriptStep (16 steps):
; 0 SceneLimboMonster2_ShowWarubouWaheyIWas, 1 SceneWatchOut_Resume, 2 SceneWatchOut_WaitMessage, 3
; SceneLimboMonster2_ShowWarubouWaheyGoodGood, 4 wait, 5 to 7 SceneLimboMonster2_GatherFollowers, 8
; SceneLimboMonster2_SpinRight, 9 and 10 SceneLimboMonster2_HopObject2ThenMessage, 11 wait, 12
; SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid, 13 wait, 14 SceneLimboMonster2_WalkObject1, 15
; SceneLimboMonster2_WalkOffAndCreate. Warubou asks whether to take his kid along, the kid hops and
; spins, then walks off and a monster record is created on the farm. Same scene as SceneLimboMonster
; with other messages and a kind 3 record. Reached through ScriptCommand6E in bank $10. (C1, E-0384)
; implements script command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the
; scene its only script shows: the same scene as SCRIPT_SCENE_LIMBO_MONSTER; reached through
; ScriptCommand6E in bank $10 (E-0038, E-0245)
SceneLimboMonster2::
    ld a, [wScriptStep]
    jumptable
    dw SceneLimboMonster2_ShowWarubouWaheyIWas
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_GatherFollowers
    dw SceneLimboMonster2_GatherFollowers
    dw SceneLimboMonster2_GatherFollowers
    dw SceneLimboMonster2_SpinRight
    dw SceneLimboMonster2_HopObject2ThenMessage
    dw SceneLimboMonster2_HopObject2ThenMessage
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_WalkObject1
    dw SceneLimboMonster2_WalkOffAndCreate

; Limbo monster 2, step 15: clears hFieldDrawFlags and walks object 1 right one pixel a frame
; towards X $C0 (StepObjectTowardCoord, direction 1). When it arrives it creates the monster on the
; farm (CreateMonsterRecordOfKindTemp1 with kind 3, record slot wArg5, state 1), sets
; EVENT_SCENE_LIMBO_MONSTER2 and sets wScriptStartRequest = $80. (C2, E-0384)
SceneLimboMonster2_WalkOffAndCreate::
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

; Limbo monster 2, step 14: object 1 first walks right one pixel a frame towards X $70
; (wScriptParam0 = 0; on arrival wScriptParam0 = 1), then down towards Y $40 (StepObjectTowardCoord,
; directions 1 and 0); on arrival wScriptParam0 = 0 and wScriptStep advances. (C2, E-0384)
SceneLimboMonster2_WalkObject1::
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

; Limbo monster 2, step 12: starts message $0BA7 ('Warubou: Wa-hey, my kid has a ...') and goes on
; to step 13, which waits for it. (C2, E-0384)
SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid::
    ld hl, $0ba7 ; 'Warubou: Wa-hey, my kid has a'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Limbo monster 2, steps 9 and 10 (the same entry twice): the Y of object 2 (wObject2 + OBJ_Y)
; follows the hop curve for 32 frames (ScriptStepAdjust32TimesThenMessage_Bank85, DE = wObject2 +
; OBJ_Y, HL = $0BA6); on the 32nd frame message $0BA6 is started, wScriptParam0 is cleared and the
; step advances, so the hop lasts 64 frames over the two steps; step 11 waits for the message. (C2,
; E-0384)
SceneLimboMonster2_HopObject2ThenMessage::
    ld de, wObject2 + OBJ_Y
    ld hl, $0ba6
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; Limbo monster 2, step 3: after the yes/no question. Yes (wTextYesNoResult = 0): starts message
; $0BA5 (MSG_ALREADY_OPEN, 'Warubou: Wa-hey! Good, good, good! ...'), puts object 2 beside the lead
; object of the player by the facing of object 1 (wObject1 + OBJ_STATE, 0-3, picks one of the X, Y
; pairs ($D0, $10), ($C0, $20), ($D0, $30), ($E0, $20)) and goes on. No: starts message $0D95
; ('Warubou: Wa-hey...' and a refusal) and sets wScriptStep = 1 to ask again. (C2, E-0384)
SceneLimboMonster2_ShowWarubouWaheyGoodGood::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, MSG_ALREADY_OPEN | $0ba5 ; 'Warubou: Wa-hey! Good, good, good! I'
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
    ld hl, MSG_ALREADY_OPEN | $0d95 ; 'Warubou: Wa-hey… That's cold of you.'
    call StartMessageHL_B85
    ld a, $01
    ld [wScriptStep], a
    ret

; Four (X, Y) pairs in sprite coordinates, ($D0, $10), ($C0, $20), ($D0, $30) and ($E0, $20), a
; diamond around ($D0, $20), indexed by wObject1 + OBJ_STATE (0-3) times 2. After a yes answer
; SceneLimboMonster2_ShowWarubouWaheyGoodGood copies the pair into wObject2 + OBJ_X and wObject2 +
; OBJ_Y. The same 8 bytes are SceneLimboMonster_ShowWarubouWaheyGoodGood_Data. (C1, E-0381)
SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data::
    db $d0, $10, $c0, $20, $d0, $30, $e0, $20

; Limbo monster 2, step 0: asks ClearArg5IfAtOrAboveLimitForFarmLevel whether the farm has room
; (wArg5 = the first free record, or $FF when there is none or it is at the limit of wFarmLevel).
; With room it starts message $0BA4 (MSG_KEEP_OPEN, 'Warubou: Wa-hey! ...') and sets wScriptStep = 2
; (the question); with a full farm it starts message $0BA3 and goes on to step 1, which resumes the
; script without asking. (C2, E-0384)
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

; Runs one frame of script command type 6D (SCRIPT_SCENE_LIMBO_MONSTER) by wScriptStep (15 steps): 0
; SceneLimboMonster_ShowWarubouWaheyIHave, 1 SceneWatchOut_Resume, 2 SceneWatchOut_WaitMessage, 3
; SceneLimboMonster_ShowWarubouWaheyGoodGood, 4 wait, 5 to 7 SceneLimboMonster2_GatherFollowers, 8
; SceneLimboMonster2_SpinRight, 9 and 10 SceneLimboMonster_HopObject2ThenMessage, 11 wait, 12
; SceneLimboMonster_SpinLeft, 13 wait, 14 SceneWatchOut_Resume. Warubou asks a favour, the player
; may agree, and the kid spins and hops away; the monster record (kind 4) is created in step 12. The
; script before it says 'Prince Kameha has been missing'. Reached through ScriptCommand6D in bank
; $10. (C1, E-0384)
; implements script command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the
; scene its only script shows: 'Limbo is the King's domain!' ... 'Prince Kameha has been missing'
; (creates a monster record); reached through ScriptCommand6D in bank $10 (E-0038, E-0245)
SceneLimboMonster::
    ld a, [wScriptStep]
    jumptable
    dw SceneLimboMonster_ShowWarubouWaheyIHave
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_GatherFollowers
    dw SceneLimboMonster2_GatherFollowers
    dw SceneLimboMonster2_GatherFollowers
    dw SceneLimboMonster2_SpinRight
    dw SceneLimboMonster_HopObject2ThenMessage
    dw SceneLimboMonster_HopObject2ThenMessage
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster_SpinLeft
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_Resume

; Limbo monster, step 12: for 64 frames (wScriptParam0 counts 0 to $3F) object 2 spins and hops to
; the left: sound $65 at the first frame; each frame the Y of object 2 gets the hop delta of index
; wScriptParam0 / 4 (AddStepDeltaToPointedByte with wScriptParam0 halved first), on even counts its
; facing (wObject2 + OBJ_STATE) goes to the next of four, and its X (wObject2 + OBJ_X) shrinks by 2.
; After the 64th frame it starts message $0B2C ('Warubou: Wa-hey, my kid has a ...'), creates the
; monster on the farm (CreateMonsterRecordOfKindTemp1 with kind 4, slot wArg5, state 1), sets
; EVENT_SCENE_LIMBO_MONSTER, clears hFieldDrawFlags and wScriptParam0 and advances wScriptStep. (C2,
; E-0384)
SceneLimboMonster_SpinLeft::
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

; Limbo monster, steps 9 and 10 (the same entry twice): the Y of object 2 (wObject2 + OBJ_Y) follows
; the hop curve for 32 frames (ScriptStepAdjust32TimesThenMessage_Bank85, DE = wObject2 + OBJ_Y, HL
; = $0B2B); on the 32nd frame message $0B2B ('Petibou: What? This little kid?') is started,
; wScriptParam0 is cleared and the step advances, so the hop lasts 64 frames over the two steps;
; step 11 waits for the message. (C2, E-0384)
SceneLimboMonster_HopObject2ThenMessage::
    ld de, wObject2 + OBJ_Y
    ld hl, $0b2b
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; Limbo monster 2, step 8: sets hFieldDrawFlags = $0E and, for 64 frames (wScriptParam0 counts 0 to
; $3F), makes object 2 spin and hop to the right: sound $65 at the first frame; each frame the Y of
; object 2 gets the hop delta of index wScriptParam0 / 4 (AddStepDeltaToPointedByte with
; wScriptParam0 halved first), on even counts the facing (wObject2 + OBJ_STATE) goes to the next of
; four, and the X (wObject2 + OBJ_X) grows by 2. After the 64th frame it plays sound $72, gives
; object 2 the facing of object 1, clears wScriptParam0 and advances wScriptStep. Used by the Limbo
; monster and Limbo monster 2 scenes. (C2, E-0384)
SceneLimboMonster2_SpinRight::
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

; Limbo monster 2 (and Limbo monster), steps 5 to 7: runs ScriptStepMoveFollowersToLeader once per
; frame (first frame sets the follower targets and wScriptParam0 = 1; later frames move the
; followers towards them and count wScriptParam0 up; when it reaches $11 wScriptStep advances and
; the count is cleared), so the followers gather around the leader before the next part of the
; scene. (C2, E-0384)
SceneLimboMonster2_GatherFollowers::
    farcall ScriptStepMoveFollowersToLeader
    ret

; Limbo monster, step 3: after the yes/no question. Yes (wTextYesNoResult = 0): starts message $0B2A
; (MSG_ALREADY_OPEN, 'Warubou: Wa-hey! Good, good, good! ...'), places object 2 by the state of
; object 1 (wObject1 + OBJ_STATE, 0-3, picks one of the X, Y pairs ($D0, $10), ($C0, $20), ($D0,
; $30), ($E0, $20)) and goes on. No: starts message $0D95 ('Warubou: Wa-hey...' and a refusal) and
; sets wScriptStep = 1 to ask again. (C2, E-0384)
SceneLimboMonster_ShowWarubouWaheyGoodGood::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b85
    ld hl, MSG_ALREADY_OPEN | $0b2a ; 'Warubou: Wa-hey! Good, good, good! I'
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
    ld hl, MSG_ALREADY_OPEN | $0d95 ; 'Warubou: Wa-hey… That's cold of you.'
    call StartMessageHL_B85
    ld a, $01
    ld [wScriptStep], a
    ret

; Four (X, Y) pairs in sprite coordinates, ($D0, $10), ($C0, $20), ($D0, $30) and ($E0, $20), a
; diamond around ($D0, $20), indexed by wObject1 + OBJ_STATE (0-3) times 2. After a yes answer
; SceneLimboMonster_ShowWarubouWaheyGoodGood copies the pair into wObject2 + OBJ_X and wObject2 +
; OBJ_Y. The same 8 bytes are SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data. (C1, E-0381)
SceneLimboMonster_ShowWarubouWaheyGoodGood_Data::
    db $d0, $10, $c0, $20, $d0, $30, $e0, $20

; Limbo monster, step 0: asks ClearArg5IfAtOrAboveLimitForFarmLevel whether the farm has room (wArg5
; = the first free record, or $FF when there is none or it is at the limit of wFarmLevel). With room
; it starts message $0B29 (MSG_KEEP_OPEN, 'Warubou: Wa-hey! ...') and sets wScriptStep = 2 (the
; question); with a full farm it starts message $0B28 and goes on to step 1, which resumes the
; script without asking. (C2, E-0384)
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

; Script command type 6C (SCRIPT_GIVE_MONSTER): creates a monster record of kind 1
; (CreateMonsterRecordOfKindTemp1 with hTemp1 = 1, record slot hTemp2 = wArg5, state hTemp3 = 1); a
; kind 1 record is an egg not yet appraised (MON_EGG = 1). It then sets wScriptStartRequest = $80.
; The script before it says 'take it? Excellent!' ... Reached through ScriptCommand6C in bank $10.
; (C2, E-0384)
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

; Runs one frame of script command type 79 (SCRIPT_SCENE_POOR_CHURCH) by wScriptStep: 0
; ScenePoorChurch_WalkUp, 1 ScenePoorChurch_LoadFrame (draws one frame of the screen animation, four
; times), 2 ScenePoorChurch_StepFrames (next frame, six frames in all), 3
; ScenePoorChurch_TurnRandomly. The script it belongs to says 'Our church is impoverished, so I...'.
; Reached through ScriptCommand79 in bank $10. (C1, E-0384)
; implements script command type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the
; scene its only script shows: ... 'Our church is impoverished, so I...'; reached through
; ScriptCommand79 in bank $10 (E-0038, E-0245)
ScenePoorChurch::
    ld a, [wScriptStep]
    jumptable
    dw ScenePoorChurch_WalkUp
    dw ScenePoorChurch_LoadFrame
    dw ScenePoorChurch_StepFrames
    dw ScenePoorChurch_TurnRandomly

; Poor church scene, step 3: every 8th frame (wScriptParam0 & 7 = 0) two NextRandomSeed draws pick
; one of sprite slots 0 to 3 (low 2 bits of wKeyRandomLo) and set its facing byte to 1 or 3 (bit 0
; of wKeyRandomHi: 1 or 3); wScriptParam0 counts up and at $3C wScriptStartRequest = $80 resumes the
; script. (C2, E-0384)
ScenePoorChurch_TurnRandomly::
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

; Poor church scene, step 2: adds 1 to wScriptParam0 and acts only when it becomes 1 (that is, once
; per step: it was 0). Then wScriptParam0 = 0 and: while wScriptParam1 is below 5 it adds 1 to
; wScriptParam1 and goes back to step 1 (the next animation frame); at 5 it sets bit 3 of the story
; flag byte wStoryFlags + $61, goes on to step 3 and, unless EVENT_SCENE_TREASURE_THEFT is set, sets
; wScriptStartRequest = $80. (C2, E-0384)
ScenePoorChurch_StepFrames::
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

; Poor church scene, step 1: decompresses animation frame wScriptParam1's screen (and on the GBC its
; attributes) from ScreenAnimationTable into the screen buffer and draws it, four times, then goes
; on. (C1, E-0357)
ScenePoorChurch_LoadFrame::
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

; ScenePoorChurch_LoadFrame indexes it with 8 * wScriptParam1 + 4 * (wScriptParam0 & 1) and
; decompresses the two words from bank $93 into wScreenTileBuffer and, on CGB, wScreenAttrBuffer; it
; runs four steps, alternating the two frames; entries 0-5 decode to 360-byte screens, the bytes
; after them do not (E-0145, C1)
; record: frame 0 tile map (bank $93); frame 0 attribute map; frame 1 tile map; frame 1 attribute
; map
ScreenAnimationTable::
    dw Map2FScreens0_Y1X0 ; id 0: frame 0 tile map (bank $93)
    dw Map2FAttrs0_Y1X0 ; frame 0 attribute map
    dw ScreenMap_ScreenAnimationTable_2 ; frame 1 tile map
    dw SandShoreWaterAttrMap ; frame 1 attribute map
    dw ScreenMap_ScreenAnimationTable_2 ; id 1: frame 0 tile map (bank $93)
    dw SandShoreWaterAttrMap ; frame 0 attribute map
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

; Poor church scene, step 0: if EVENT_SCENE_TREASURE_THEFT is set, objects 1, 2, 3 and 0 each walk
; up one pixel a frame towards Y $10, $40, $20 and $30 (StepObjectTowardCoord, direction 2) and only
; the arrival of the last one (object 0) lets the step finish; if the flag is clear nothing walks.
; Finishing sets wScriptParam1 = 0 (the animation frame) and goes on to step 1. (C2, E-0384)
ScenePoorChurch_WalkUp::
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

; Runs one frame of script command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL) by wScriptStep (11 steps):
; 0 to 4 SceneGiveBackCyal_DropObject (object 2 drops and rises back, five times), 5
; SceneGiveBackCyal_ShowHumphHowBoring, 6 SceneWatchOut_WaitMessage, 7
; SceneGiveBackCyal_TurnAndMove, 8 SceneGiveBackCyal_MoveRight, 9 SceneGiveBackCyal_Shake, 10
; SceneGiveBackCyal_SetScriptStartRequestTo80. The script it belongs to has 'Rolt Shut up! Give back
; Cyal!'. Reached through ScriptCommandC2 in bank $10. (C1, E-0384)
; implements script command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the
; scene its only script shows: 'Rolt Shut up! Give back Cyal!'; reached through ScriptCommandC2 in
; bank $10 (E-0038, E-0245)
SceneGiveBackCyal::
    ld a, [wScriptStep]
    jumptable
    dw SceneGiveBackCyal_DropObject
    dw SceneGiveBackCyal_DropObject
    dw SceneGiveBackCyal_DropObject
    dw SceneGiveBackCyal_DropObject
    dw SceneGiveBackCyal_DropObject
    dw SceneGiveBackCyal_ShowHumphHowBoring
    dw SceneWatchOut_WaitMessage
    dw SceneGiveBackCyal_TurnAndMove
    dw SceneGiveBackCyal_MoveRight
    dw SceneGiveBackCyal_Shake
    dw SceneGiveBackCyal_SetScriptStartRequestTo80

; Give back Cyal scene, step 10: asks for the next script command (wScriptStartRequest = $80). (C2,
; E-0384)
SceneGiveBackCyal_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Give back Cyal scene, step 9: shakes the screen sideways for 30 frames (ShakeScreenSideways with B
; = $1E); after the 30th frame the scroll is reset and wScriptStep advances to step 10. (C2, E-0384)
SceneGiveBackCyal_Shake::
    ld b, $1e
    call ShakeScreenSideways
    ret

; Give back Cyal scene, step 8: object 2 moves right 4 pixels a frame (wObject2 + OBJ_X); when its X
; equals $60 bit 1 of its flags (wObject2 + OBJ_FLAGS) is cleared (animation counter runs again) and
; wScriptStep advances. (C2, E-0384)
SceneGiveBackCyal_MoveRight::
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

; Give back Cyal scene, step 7: object 0 faces left (wSpriteSlots + $7 = 3) for the first 3 frames;
; from the 4th frame on each frame queues sound $66 and sets the facing to down (0); on the 8th
; frame it faces right (1), object 2 gets bit 2 of its flags cleared and bit 1 set and its state
; (wObject2 + OBJ_STATE) = 3 (starting to move left), wScriptParam0 is reset and wScriptStep
; advances. (C2, E-0384)
SceneGiveBackCyal_TurnAndMove::
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

; Give back Cyal scene, step 5: object 0 faces left (wSpriteSlots + $7 = 3), starts message $0737
; ('*: Humph... How boring...') and goes on to step 6, which waits for it. (C2, E-0384)
SceneGiveBackCyal_ShowHumphHowBoring::
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, $0737 ; '*: Humph… How boring…'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Cyal's return, step 0: object 2 drops to Y $48 (sound $63), then rises two pixels a frame back to
; $40 and the side columns are redrawn. (C1, E-0357)
SceneGiveBackCyal_DropObject::
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

; Shakes the screen sideways for B frames. Input B = the number of frames. On every frame whose
; wFrameCounterLo has bit 0 clear, the 16-bit scroll X (hScrollXHi:hScrollX) changes by 2: minus 2
; when wFrameCounterLo & 3 is 0 and plus 2 when it is 2 (odd frames change nothing). Each call adds
; 1 to wScriptParam0; when it equals B, hScrollX and hScrollXHi are set to 0, wScriptParam0 is
; cleared and wScriptStep advances. Used by SceneGiveBackCyal_Shake with B = $1E. (C2, E-0384)
ShakeScreenSideways::
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

; Runs one frame of script command type CD (SCRIPT_SCENE_YOU_DID_IT) by wScriptStep: 0
; SceneYouDidIt_ShowMessage, 1 SceneWatchOut_Resume. The script it belongs to has 'Warubou Wa-hey!
; You did it, 0!'. Reached through ScriptCommandCD in bank $10. (C1, E-0384)
; implements script command type CD (SCRIPT_SCENE_YOU_DID_IT): a cutscene step named after the scene
; its only script shows: ... 'Warubou Wa-hey! You did it, 0!'; reached through ScriptCommandCD in
; bank $10 (E-0038, E-0245)
SceneYouDidIt::
    ld a, [wScriptStep]
    jumptable
    dw SceneYouDidIt_ShowMessage
    dw SceneWatchOut_Resume

; You did it scene, step 0: goes on to step 1 (SceneWatchOut_Resume) and starts the message of the
; current map: SceneYouDidIt_ShowMessage_Data lists 12 maps ($CA to $DF) with consecutive message
; indexes $4A to $55; the matching index goes in the low byte and group $0C in the high byte of the
; message word (StartMessageHL_B85). A map that is not in the list shows nothing. (C2, E-0384)
SceneYouDidIt_ShowMessage::
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hMapId]
    ld c, a
    ld de, SceneYouDidIt_ShowMessage_Data

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

; Twelve (map id, message index) byte pairs ended by $FF: maps $CA, $CB, $CC, $CD, $D3, $D4, $D5,
; $D6, $DC, $DD, $DE and $DF get the consecutive indexes $4A-$55. SceneYouDidIt_ShowMessage searches
; for hMapId, puts the index in L with group $0C in H and starts that message with
; StartMessageHL_B85; a map that is not listed shows nothing. (C1, E-0381)
SceneYouDidIt_ShowMessage_Data::
    db $ca, $4a, $cb, $4b, $cc, $4c, $cd, $4d, $d3, $4e, $d4, $4f, $d5, $50, $d6, $51
    db $dc, $52, $dd, $53, $de, $54, $df, $55, $ff

; Script command type 73 (SCRIPT_FOLLOWER_FACE_PLAYER): copies hPlayerFacing to the first byte of
; wFollowerRecords (the facing of the first follower) and sets wScriptStartRequest = $80. Reached
; through ScriptCommand73 in bank $10. (C2, E-0384)
; implements script command type 73 (SCRIPT_FOLLOWER_FACE_PLAYER): copies hPlayerFacing to the first
; follower record; reached through ScriptCommand73 in bank $10 (E-0038, E-0245)
FollowerFacePlayer::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Runs one frame of script command type 65 (SCRIPT_GROWTH_LIMIT_INFO) by wScriptStep: 0
; GrowthLimitInfo_ShowGrowthLimit (message for party member wScriptParam1), 1
; SceneWatchOut_WaitMessage, 2 GrowthLimitInfo_NextMember. It tells the player the growth limit of
; each party member in turn ('Everyone has a growth limit. Whether...'). Reached through
; ScriptCommand65 in bank $10. (C1, E-0384)
; implements script command type 65 (SCRIPT_GROWTH_LIMIT_INFO): shows a monster's name and a record
; byte as digits: 'Everyone has a growth limit. Whether...'; reached through ScriptCommand65 in bank
; $10 (E-0038, E-0245)
GrowthLimitInfo::
    ld a, [wScriptStep]
    jumptable
    dw GrowthLimitInfo_ShowGrowthLimit
    dw SceneWatchOut_WaitMessage
    dw GrowthLimitInfo_NextMember

; Growth limit info, step 2: sets wScriptStep back to 0, adds 1 to wScriptParam1 (the party member
; shown) and, when it now equals wPartyCount, sets wScriptStartRequest = $80 so the script resumes;
; otherwise step 0 shows the next member. (C2, E-0384)
GrowthLimitInfo_NextMember::
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

; Growth limit info, step 0: goes on to step 1 and describes party member number wScriptParam1: the
; name of the record wPartyList[wScriptParam1] is copied to wNameGlyphBuf and, 10 glyphs plus $F0,
; to wTextBuf1 + 7. When MON_LEVEL equals MON_MAX_LEVEL it starts message $0A56 (MSG_KEEP_OPEN |
; MSG_ALREADY_OPEN, '<name> has reached its growth limit.'); otherwise the maximum level is turned
; into decimal (HLToDecimalDigits: the tens digit only when it is not 0, then the ones digit, then
; $F0) in wTextNumber and message $0A55 ('... growth limit is Lv <n>.') is started. SRAM is enabled
; for the reads and disabled again. (C2, E-0384)
GrowthLimitInfo_ShowGrowthLimit::
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
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0a56 ; 'N has reached its growth limit.'
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
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0a55 ; 'N's growth limit is Lv .'
    call StartMessageHL_B85
    ret

; Runs one frame of script command type C4 (SCRIPT_SCENE_BARREL) by wScriptStep (10 steps): 0
; SceneBarrel_CountBarrel, 1 SceneBarrel_ShowMessage, 2 SceneWatchOut_WaitMessage, 3
; SceneBarrel_StartBattle, 4 SceneBarrel_SetBarrelFlag, 5 SceneBarrel_JiggleObject1, 6
; SceneWatchOut_WaitMessage, 7 SceneBarrel_Flicker, 8 SceneBarrel_ShowRobosterStoppedMoving, 9
; SceneWatchOut_Resume. wScriptParam1 & 3 (set by step 0) is the barrel number that picks the
; message of step 1 and the encounter of step 3. The script it belongs to has '0 peered into the
; barrel.' and 'Kiral: Ah! Back!'. Reached through ScriptCommandC4 in bank $10. (C1, E-0384)
; implements script command type C4 (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its
; only script shows: '0 peered into the barrel.' ... 'Kiral Ah! Back!' (encounter); reached through
; ScriptCommandC4 in bank $10 (E-0038, E-0245)
SceneBarrel::
    ld a, [wScriptStep]
    jumptable
    dw SceneBarrel_CountBarrel
    dw SceneBarrel_ShowMessage
    dw SceneWatchOut_WaitMessage
    dw SceneBarrel_StartBattle
    dw SceneBarrel_SetBarrelFlag
    dw SceneBarrel_JiggleObject1
    dw SceneWatchOut_WaitMessage
    dw SceneBarrel_Flicker
    dw SceneBarrel_ShowRobosterStoppedMoving
    dw SceneWatchOut_Resume

; Barrel scene, step 8: puts the Y of object 0 (wSpriteSlots + $C) at $E0 and wObject1 + OBJ_Y at
; $20, the same state in which SceneBarrel_Flicker ends, so object 0 is off the screen and object 1
; is shown. It starts message $078D ('...Roboster stopped moving...'), clears wScriptParam0 and goes
; on to step 9 (SceneWatchOut_Resume). (C2, E-0384)
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

; Barrel scene, step 7: for $78 frames swaps which of object 0 (Y at wSpriteSlots + $C) and object 1
; (wObject1 + OBJ_Y) is shown: one gets Y $20 and the other Y $E0 (off the screen), chosen by bit 1
; of wScriptParam0 while it is below $1E, bit 2 below $3C and bit 3 after, so the swap happens every
; 2, then 4, then 8 frames (the flicker slows down). wScriptParam0 + 1 each frame; on the 120th
; frame ($78) object 0 is left hidden (Y $E0) and object 1 shown (Y $20), wScriptParam0 = 0 and
; wScriptStep advances. (C2, E-0384)
SceneBarrel_Flicker::
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

; Barrel scene, step 5: adds 1 to wScriptParam0; when the new count is odd it calls
; SceneBarrel_JiggleObject1_PickX, which moves wObject1 + OBJ_X to $3F, $40 or $41; when the count
; reaches $78 it is cleared and wScriptStep advances, so the object jiggles on alternate frames for
; 120 frames. (C2, E-0384)
SceneBarrel_JiggleObject1::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    jr z, .check_script_param0
    call SceneBarrel_JiggleObject1_PickX

.check_script_param0:
    ld a, [wScriptParam0]
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Calls NextTableByte (wRandomHi = (wRandomHi + 1) & $7F, wRandomLo = the table byte at that index)
; until the low two bits of wRandomHi are not 3, then sets wObject1 + OBJ_X to $40 + (those two
; bits) - 1, that is $3F, $40 or $41 for bits 0, 1 or 2. The value comes from the table index, not
; from the table byte, so when nothing else uses the table the X cycles $3F, $40, $41. Used by
; SceneBarrel_JiggleObject1. (C2, E-0384)
SceneBarrel_JiggleObject1_PickX::
    call NextTableByte
    ld a, [wRandomHi]
    and $03
    cp $03
    jr z, SceneBarrel_JiggleObject1_PickX
    dec a
    ld c, a
    ld a, $40
    add c
    ld [wObject1 + OBJ_X], a
    ret

; Barrel scene, step 4: sets story flag $015F + the barrel number (unless it is 3); without
; EVENT_KIRAL_PLEASE_GO_STOP_HIM the script resumes; with it sets EVENT_SCENE_BARREL and shows '...
; PROFE... SOR... ORDER... MUST... OBEY...' ($0779). (C2, E-0357; probed E-0384)
SceneBarrel_SetBarrelFlag::
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

; Barrel scene, step 3: starts the barrel's scripted encounter (SceneBarrel_StartBattle_Data). (C1,
; E-0357)
SceneBarrel_StartBattle::
    ld a, [wScriptParam1]
    and $03
    ld de, SceneBarrel_StartBattle_Data
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

; Four ScriptedEncounterTable record numbers, $0D, $0E, $0F and $10, one per barrel (index
; wScriptParam1 AND 3). SceneBarrel_StartBattle puts the byte in hTemp0 and calls
; StartScriptedEncounterTemp0. (C1, E-0381)
SceneBarrel_StartBattle_Data::
    db $0d, $0e, $0f, $10

; Barrel scene, step 1: starts the barrel's message (SceneBarrel_ShowMessage_Data). (C2, E-0357;
; probed E-0384)
SceneBarrel_ShowMessage::
    ld a, [wScriptParam1]
    and $03
    add a
    ld de, SceneBarrel_ShowMessage_Data
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

; Four little-endian message words, $076C, $076F, $0772 and $0775 (index $6C, $6F, $72 and $75 in
; message group 7), one per barrel (index wScriptParam1 AND 3). SceneBarrel_ShowMessage loads the
; word into HL and starts it with StartMessageHL_B85. (C1, E-0381)
SceneBarrel_ShowMessage_Data::
    db $6c, $07, $6f, $07, $72, $07, $75, $07

; Barrel scene, step 0: goes on to step 1 and sets wScriptParam1 (the barrel number, 0 to 3) to the
; number of these story flags that are set, testing them in order and stopping at the first clear
; one: EVENT_KIRAL_FETCH_ME_MY, EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY,
; EVENT_ROBOSTER_STOPPED_MOVING_ENTIRELY_161. SceneBarrel_SetBarrelFlag later sets the flag of the
; same number, so each barrel is met once, in turn. (C2, E-0384)
SceneBarrel_CountBarrel::
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

; Runs one frame of script command type 5B (SCRIPT_SCENE_LIMBO) by wScriptStep (16 steps): three
; rounds of 0 SceneLimbo_PlaceItem, 1 SceneLimbo_RaiseItem, 2 SceneLimbo_ShowMessage, 3
; SceneLimbo_DropItem, 4 SceneWatchOut_WaitMessage (steps 0-4, 5-9 and 10-14), then 15
; SceneLimbo_AddItems. wScriptParam1 counts the round (0 to 2) and picks the item. The script it
; belongs to has 'Warubou: Wa-hey! Take the treasures that...'. Reached through ScriptCommand5B in
; bank $10. (C1, E-0384)
; implements script command type 5B (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its
; only script shows: 'Warubou Wa-hey! Take the treasures that...' ... 'Limbo is the King's domain!';
; reached through ScriptCommand5B in bank $10 (E-0038, E-0245)
SceneLimbo::
    ld a, [wScriptStep]
    jumptable
    dw SceneLimbo_PlaceItem
    dw SceneLimbo_RaiseItem
    dw SceneLimbo_ShowMessage
    dw SceneLimbo_DropItem
    dw SceneWatchOut_WaitMessage
    dw SceneLimbo_PlaceItem
    dw SceneLimbo_RaiseItem
    dw SceneLimbo_ShowMessage
    dw SceneLimbo_DropItem
    dw SceneWatchOut_WaitMessage
    dw SceneLimbo_PlaceItem
    dw SceneLimbo_RaiseItem
    dw SceneLimbo_ShowMessage
    dw SceneLimbo_DropItem
    dw SceneWatchOut_WaitMessage
    dw SceneLimbo_AddItems

; The Limbo scene, step 15: adds items $36, $37 and $38 at the end of the inventory, sets inventory
; sort flag bit 6 and resumes the script. (C2, E-0357; probed E-0384)
SceneLimbo_AddItems::
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

; The Limbo scene, step 3: the item (wObject5) falls. Each frame, by the facing of object 0
; (wSpriteSlots + $7): 0 adds 2 to the item Y, 1 adds 1 to X and 1 to Y, 2 changes nothing, any
; other value (3) subtracts 1 from X and adds 1 to Y; then ScriptApplyStepDeltaAtDE_Bank85 adds the
; hop-curve delta to the item Y (wScriptParam0 counts 2 per frame). After the 16th frame the item is
; hidden (wObject5 = 0) and wScriptStep advances. (C2, E-0384)
SceneLimbo_DropItem::
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

; The Limbo scene, step 2: after 60 frames starts message $052C + the item number and counts the
; item. (C2, E-0357; probed E-0384)
SceneLimbo_ShowMessage::
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

; The Limbo scene, step 1: the item rises along the hop curve. (C2, E-0357; probed E-0384)
SceneLimbo_RaiseItem::
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

; The Limbo scene, step 0: starts the item's field command (SceneLimbo_PlaceItem_Data) at ($40,
; $30), hidden. (C1, E-0357)
SceneLimbo_PlaceItem::
    ld a, [wScriptParam1]
    ld hl, SceneLimbo_PlaceItem_Data
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

; Three field command numbers, $03, $08 and $0A, indexed by wScriptParam1 (0-2).
; SceneLimbo_PlaceItem puts the byte in hTemp0, calls RunFieldCommandTemp0 and then sets wObject5 to
; X $40, Y $30, hidden. (C1, E-0381)
SceneLimbo_PlaceItem_Data::
    db $03, $08, $0a

; Runs one frame of script command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE) by wScriptStep (6 steps):
; 0 SceneFoundMeBattle_ShowMessage, 1 SceneWatchOut_WaitMessage, 2 SceneFoundMeBattle_StartBattle, 3
; SceneFoundMeBattle_BlinkGuard, 4 SceneFoundMeBattle_WalkOff, 5 SceneFoundMeBattle_SetGuardFlag.
; The message of step 0 depends on the graphics the player wears; wScriptParam1 = 1 (the cooking
; crew) skips the battle. The script it belongs to has 'Ah, so good of you to...'. Reached through
; ScriptCommand69 in bank $10. (C1, E-0384)
; implements script command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the
; scene its only script shows: 'I'm surprised anyone managed to find...' ... 'Ah, so good of you
; to...' (encounter); reached through ScriptCommand69 in bank $10 (E-0038, E-0245)
SceneFoundMeBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneFoundMeBattle_ShowMessage
    dw SceneWatchOut_WaitMessage
    dw SceneFoundMeBattle_StartBattle
    dw SceneFoundMeBattle_BlinkGuard
    dw SceneFoundMeBattle_WalkOff
    dw SceneFoundMeBattle_SetGuardFlag

; Found me battle, step 5: sets wSpriteSlotCount = 0 (no sprite slots are drawn), then sets a story
; flag: $0201 when hMapId is $96, otherwise $00B9 for hMapScreenX 0, $00BA for 1 and $00BB for any
; larger column. It sets wScriptStartRequest = $80 so the script resumes. (C2, E-0384)
SceneFoundMeBattle_SetGuardFlag::
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

; Found me battle, step 4: object 0 walks off the screen, one pixel a frame towards coordinate $E0
; (StepObjectTowardCoord with wStepPtrHi = 0 and wStepPtrLo = $E0): up (decreasing Y) normally, left
; (decreasing X) when hMapId is $96. When it arrives it sets the state of object 0 (wSpriteSlots +
; $7) to 0 and goes on to step 5 (SceneFoundMeBattle_SetGuardFlag). The disguised player skips the
; battle and reaches this step from step 2. (C2, E-0384)
SceneFoundMeBattle_WalkOff::
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

; Found me battle, step 3: blinks object 0 at Y $20 ($40 on map $96) for $78 frames, then step 5.
; (C2, E-0357; probed E-0384)
SceneFoundMeBattle_BlinkGuard::
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

; Found me battle, step 2: in disguise (wScriptParam1 1) skips to step 4; otherwise starts scripted
; encounter $1B. (C1, E-0357)
SceneFoundMeBattle_StartBattle::
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

; Found me battle, step 0: by the player's disguise (hPlayerSpriteOverride bit 7 with sprite $D6 or
; $EC): "... Oh, you're the cooking crew." ($0475), '... Hm? Are you a new ...' ($0474), or "...
; You! I've never seen you ..." ($0473). (C2, E-0357; probed E-0384)
SceneFoundMeBattle_ShowMessage::
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .loop
    and $01
    jr z, .check_player_sprite_gfx_id_hi

.loop:
    ld a, $00
    ld [wScriptParam1], a
    ld hl, $0473 ; '*: You! I've never seen you'
    call StartMessageHL_B85
    ret

.check_player_sprite_gfx_id_hi:
    ldh a, [hPlayerSpriteGfxIdHi]
    cp $00
    jr nz, .loop
    ldh a, [hPlayerSpriteGfxIdLo]
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

; Runs one frame of script command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS) by wScriptStep (3 steps): 0
; ScenePirateGhosts_CrateHint, 1 SceneWatchOut_WaitMessage, 2 ScenePirateGhosts_BlinkOut. The script
; it belongs to has 'How could we die before enjoying...' and 'The treasures are ours'. Reached
; through ScriptCommand31 in bank $10. (C1, E-0384)
; implements script command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS): a cutscene step named after the
; scene its only script shows: 'How could we die before enjoying...' ... 'The treasures are ours';
; reached through ScriptCommand31 in bank $10 (E-0038, E-0245)
ScenePirateGhosts::
    ld a, [wScriptStep]
    jumptable
    dw ScenePirateGhosts_CrateHint
    dw SceneWatchOut_WaitMessage
    dw ScenePirateGhosts_BlinkOut

; Pirate ghosts, step 0: on map $43 '... Check the wooden crate...' ($085D); elsewhere skips a step.
; (C2, E-0357; probed E-0384)
ScenePirateGhosts_CrateHint::
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

; Pirate ghosts, step 2: blinks object 0 at Y $10, $60 or $30 (by map) for $78 frames, then removes
; the sprites and resumes the script. (C2, E-0357; probed E-0384)
ScenePirateGhosts_BlinkOut::
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

; Runs one frame of script command type 24 (SCRIPT_SCENE_TREASURE_THEFT) by wScriptStep (9 steps): 0
; SceneTreasureTheft_ShowKingTheHideoutOf, 1 SceneTreasureTheft_HideFollowers, 2
; SceneWatchOut_WaitMessage, 3 SceneTreasureTheft_TurnRandomly, 4 SceneTreasureTheft_WalkObject2, 5
; SceneTreasureTheft_Pause, 6 SceneTreasureTheft_ShowKingGoodYourValor, 7 SceneWatchOut_WaitMessage,
; 8 SceneTreasureTheft_WalkOff. The script it belongs to is between 'King: What? Arrrrgh! Round up
; all...' and 'King: I apologize, but my treasures...'. Reached through ScriptCommand24 in bank $10.
; (C1, E-0384)
; implements script command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the
; scene its only script shows: 'King What? Arrrrgh! Round up all...' ... 'King I apologize, but my
; treasures...'; reached through ScriptCommand24 in bank $10 (E-0038, E-0245)
SceneTreasureTheft::
    ld a, [wScriptStep]
    jumptable
    dw SceneTreasureTheft_ShowKingTheHideoutOf
    dw SceneTreasureTheft_HideFollowers
    dw SceneWatchOut_WaitMessage
    dw SceneTreasureTheft_TurnRandomly
    dw SceneTreasureTheft_WalkObject2
    dw SceneTreasureTheft_Pause
    dw SceneTreasureTheft_ShowKingGoodYourValor
    dw SceneWatchOut_WaitMessage
    dw SceneTreasureTheft_WalkOff

; Treasure theft, step 8: objects 1-3 walk right to X $50 and then down off the screen ($B0); once
; object 3 reaches $50, object 4 follows; when it has left, one sprite slot remains and the script
; resumes. (C1, E-0357)
SceneTreasureTheft_WalkOff::
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

; Treasure theft, step 6: objects 1, 3 and 4 walk up to Y $40; then 'King: Good! Your valor be
; praised!' (message $0186). (C1, E-0357)
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

; Treasure theft, step 5: a 60-frame wait. (C1, E-0357)
SceneTreasureTheft_Pause::
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

; Treasure theft, step 4: object 2 walks up to Y $40. (C1, E-0357)
SceneTreasureTheft_WalkObject2::
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

; Treasure theft, step 3: every 16 frames turns a random one of objects 1-4 left or right, for $F0
; frames; then objects 1-3 face up. (C1, E-0357)
SceneTreasureTheft_TurnRandomly::
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

; Treasure theft, step 1: sets hFieldDrawFlags = $0E, so DrawPartyFollowerSprites skips all three
; followers (bits 1-3) while the player (bit 0 clear) is still drawn; next step. (C1, E-0371)
SceneTreasureTheft_HideFollowers::
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Treasure theft, step 0: warps to map $26 at ($60, $20) with a fade and shows 'King: The hideout of
; the thieves ...' (message $0185). (C1, E-0357)
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
    dw SceneCanalGate_Hop
    dw SceneCanalGate_Hop
    dw SceneCanalGate_Msg0172_KingArrghIKnow
    dw SceneWatchOut_WaitMessage
    dw SceneCanalGate_LowerObject0
    dw SceneCanalGate_WalkUp
    dw SceneCanalGate_RaiseGate

; Canal gate, step 6: object 1 rises two pixels a frame to Y $10, stops animating, and the script
; resumes. (C1, E-0357)
SceneCanalGate_RaiseGate::
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

; Canal gate, step 5: object 0 walks up two pixels a frame to Y $50; then object 1 animates and
; sound $63 plays. (C1, E-0357)
SceneCanalGate_WalkUp::
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

; Canal gate, step 4: object 0 moves down a pixel every other frame to Y $60. (C1, E-0357)
SceneCanalGate_LowerObject0::
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

; Canal gate, step 2: 'King: Arrgh! I know that! I ...' (message $0172). (C1, E-0357)
SceneCanalGate_Msg0172_KingArrghIKnow::
    ld hl, $0172 ; 'King: Arrgh! I know that! I'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Canal gate, step 0: object 0 hops along the hop curve. (C1, E-0357)
SceneCanalGate_Hop::
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
    dw SceneWatchOut_WaitMessage
    dw SceneGreatlogKey_ShowWarubouThisYouUse
    dw SceneWatchOut_WaitMessage
    dw SceneGreatlogKey_FlyOff

; GreatLog key scene, step 4: the key flies off for 32 frames (sound $65 first): left two pixels a
; frame, or along SceneGreatlogKey_FlyOff_Data when thrown the other way, falling along the step
; curve; then hides it and resumes the script. (C1, E-0357)
SceneGreatlogKey_FlyOff::
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
    ld hl, SceneGreatlogKey_FlyOff_Data
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

; Thirty-two X positions for wObject5 (SCRIPTOBJ_X), one per frame (index wScriptParam0, 0-31),
; rising from $42 to $90 in steps of alternately 3 and 2 pixels. SceneGreatlogKey_FlyOff uses them
; only when wScriptParam1 is nonzero (the key thrown the other way); otherwise the key moves left 2
; pixels a frame. The Y position falls along AddStepDeltaToPointedByte_Data. (C1, E-0381)
SceneGreatlogKey_FlyOff_Data::
    db $42, $45, $47, $4a, $4c, $4f, $51, $54, $56, $59, $5b, $5e, $60, $63, $65, $68
    db $6a, $6d, $6f, $72, $74, $77, $79, $7c, $7e, $81, $83, $86, $88, $8b, $8d, $90

; GreatLog key scene, step 2: the key rises along the hop curve; then 'Warubou: This you use to come
; ...' (message $0084). (C1, E-0357)
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

; GreatLog key scene, step 0: shows the key (field command 2) at ($40, $30), 'Warubou: Wa-hey!
; Forgot something!' (message $0083), and turns the player and object 0 to face each other by the
; player's X (and the throw direction in wScriptParam1). (C1, E-0357)
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

; Watch Out scene, step 1: after the message goes on. (C1, E-0357)
SceneWatchOut_WaitMessage::
    xor a
    call RunMessageBoxFar_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Watch Out scene, step 3: after the message the script resumes. (C1, E-0357)
SceneWatchOut_Resume::
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

; hTemp0 = 1 when every living party member has a wildness (MON_WLD) of 0, otherwise 0; 0 with no
; party. (C1, E-0357)
FhuntTalkEvents_PartyIsTame::
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

; hTemp0 = 1 when the player is disguised as a monster in TalkEvent29WordList or a living party
; member's species is in it. (C1, E-0357)
FhuntTalkEvents_GiantBird_IsBirdPresent::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .check_party_count2
    and $01
    jr nz, .check_party_count2
    ld de, TalkEvent29WordList
    ldh a, [hPlayerSpriteGfxIdLo]
    ld l, a
    ldh a, [hPlayerSpriteGfxIdHi]
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

; FhuntTalkEvents_GiantBird_IsBirdPresent compares the words of this list, up to $0000, with
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

; hTemp0 = 2 when the player is disguised as a monster in TalkEvent47WordList (also behind
; EVENT_NEVER_SET), otherwise 0. (C1, E-0357)
FhuntTalkEvents_IsDisguisedAsListedMonster::
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .set_temp0_to_02
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .clear_temp0
    and $01
    jr z, .read_player_sprite_gfx_id_lo

.clear_temp0:
    xor a
    ldh [hTemp0], a
    ret

.read_player_sprite_gfx_id_lo:
    ld de, TalkEvent47WordList
    ldh a, [hPlayerSpriteGfxIdLo]
    ld l, a
    ldh a, [hPlayerSpriteGfxIdHi]
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

; FhuntTalkEvents_IsDisguisedAsListedMonster (unless flag 0 is set) compares the words of this list,
; up to $0000, with hPlayerSpriteStreamLo/Hi when hPlayerSpriteOverride bit 7 is set and bit 0
; clear; a match sets hTemp0 to 2; 113 words; what the words identify is not read (E-0236, C1)
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

; hTemp1 = 1 when the player's monster disguise is sprite $00F6-$00FF or any $01xx sprite (the
; second test compares the decremented high byte, always 0, with $11), otherwise hTemp0 = 0. (C1,
; E-0357)
FhuntTalkEvents_PowerOfJustice_IsDisguised::
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, .loop
    and $01
    jr z, .check_player_sprite_gfx_id_hi

.loop:
    xor a
    ldh [hTemp0], a
    ret

.check_player_sprite_gfx_id_hi:
    ldh a, [hPlayerSpriteGfxIdHi]
    cp $00
    jr nz, .skip
    ldh a, [hPlayerSpriteGfxIdLo]
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

; For Talk04CB_ThatKeyIUsed: hTemp0 = 1 when a party member (wPartyList, wPartyCount of them)
; without MON_STATUS bit 7 (dead) has a species word in the list after this routine
; (MONSTER_LORDDRACO, MONSTER_GENOSIDOH, MONSTER_ASURAZOMA, MONSTER_PSYCHOPIZ, MONSTER_DARCK; $0000
; ends it), otherwise 0; the talk then starts Script_OhGoodnessI for 1. Reads the records with
; LoadSRAMRecordByte and LoadSRAMRecordWord with SRAM enabled (rRAMG = $0A, then 0). With an empty
; party it returns at once and leaves hTemp0 unchanged. (C1, E-0371)
Talk04CB_ThatKeyIUsed_CheckPartySpecies::
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
    ld de, Talk04CB_ThatKeyIUsed_CheckPartySpecies_Data

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

; A list of five species words ended by a zero word: $0161, $0164, $0167, $0169 and $0174
; (MONSTER_LORDDRACO, MONSTER_GENOSIDOH, MONSTER_ASURAZOMA, MONSTER_PSYCHOPIZ and MONSTER_DARCK).
; Talk04CB_ThatKeyIUsed_CheckPartySpecies compares the MON_SPECIES word of each party member that is
; not marked dead (MON_STATUS bit 7 clear) with the list and sets hTemp0 to 1 when one matches,
; otherwise 0. (C1, E-0381)
Talk04CB_ThatKeyIUsed_CheckPartySpecies_Data::
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

; Five rows of four bytes (20 bytes), indexed by wArenaRank * 4 + wRecordCapacity (rank 0-4, column
; 0-3): $06 $19 $18 $00, $15 $09 $16 $00, $14 $1E $2A $00, $0D $2B $12 $00, $28 $11 $20 $00.
; SetupMap0BMonsterObjects uses it when bit 7 of wArenaFlags is clear and stores the byte in
; wSpriteSlots + 2 and in hTemp0 as the field sprite graphics id, which
; DecompressGraphicsTemp0ToTemp4 loads to vTiles0 + $400. Column 3 is $00 in every row. (C1, E-0381)
SetupMap0BMonsterObjects_Data1::
    db $06, $19, $18, $00, $15, $09, $16, $00, $14, $1e, $2a, $00, $0d, $2b, $12, $00
    db $28, $11, $20, $00

; Thirty-two field sprite graphics ids in ascending order ($06-$0D, $10-$16, $1A-$1D, $21, $24-$26,
; $28-$2A, $2E, $2F, $33, $38, $39, $3D), picked with wKeyRandomHi AND $1F. SetupMap0BMonsterObjects
; uses it when bit 7 of wArenaFlags is set: the byte goes to wSpriteSlots + 2 and hTemp0 and is
; loaded as graphics id to vTiles0 + $400 by DecompressGraphicsTemp0ToTemp4. (C1, E-0381)
SetupMap0BMonsterObjects_Data2::
    db $06, $07, $08, $09, $0a, $0b, $0c, $0d, $10, $11, $12, $13, $14, $15, $16, $1a
    db $1b, $1c, $1d, $21, $24, $25, $26, $28, $29, $2a, $2e, $2f, $33, $38, $39, $3d

; The body of step 4 of RandomGoldOrItem (far-called by RandomGoldOrItem_PickFind). A find needs
; wTriggerKind $FF (no trigger), bit 7 of wPendingFieldEvent clear, the 24th bag slot (wInventory +
; $17) $FF or 0, and wRandomLo & $1F = 0 (the NextRandomSeed call just before advances
; wKeyRandomLo/Hi, not wRandomLo); otherwise it clears wTriggerMarkerFlags and sets
; wScriptStartRequest to $80, so the script resumes with no find. For map sprite kind 1
; (wMapSpriteKind high nibble) a 0-98 roll (RandomGoldOrItem_PickFind_RollFind_RandomUnder99) below
; 5 gives ITEM_TINYMEDAL (marker flags $80, no gold), otherwise gold: flags $80 | (wPartyStrength
; from ComputePartyStrengthLevelPartyStrength + a random -16..15 from wKeyRandomHi, made 1 when bit
; 7 is set; a sum of exactly 0 leaves no gold, so the medal is given), with wScriptParam1 =
; ITEM_TINYMEDAL either way. For any other kind the flags are $80 and a 0-98 roll picks tier 0-5
; (below 50, 70, 80, 90, 95, or above) in row ((kind - 2) & 1) of
; RandomGoldOrItem_PickFind_RollFind_Data1 (row 0 ITEM_BEEFJERKY, ITEM_PORKCHOP, ITEM_RIB, ITEM_RIB,
; ITEM_SIRLOIN, ITEM_TINYMEDAL; row 1 ITEM_HERB, ITEM_MOONHERB, ITEM_WARP, ITEM_MIST,
; ITEM_WORLDLEAF, ITEM_TINYMEDAL) into wScriptParam1. Then wTriggerKind =
; RandomGoldOrItem_PickFind_RollFind_Data2[wScriptParam1] (no find when 0; every id these rows give
; has a nonzero entry), LoadTriggerMarkerGraphics, wTriggerCell = wMessageIndex, wTriggerIndex =
; wMessageGroup, wScriptParam0 = 0 and wScriptStep += 1, on to RandomGoldOrItem_HopMarker. (C1,
; E-0370)
RandomGoldOrItem_PickFind_RollFind::
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
    call RandomGoldOrItem_PickFind_RollFind_RandomUnder99
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
    call RandomGoldOrItem_PickFind_RollFind_RandomUnder99
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
    ld hl, RandomGoldOrItem_PickFind_RollFind_Data1
    add_a_to_hl
    ld a, [hl]

.set_script_param1:
    ld [wScriptParam1], a
    ld hl, RandomGoldOrItem_PickFind_RollFind_Data2
    add_a_to_hl
    ld a, [hl]
    or a
    jp z, .loop
    ld [wTriggerKind], a
    farcall LoadTriggerMarkerGraphics
    ld a, [wMessageIndex]
    ld [wTriggerCell], a
    ld a, [wMessageGroup]
    ld [wTriggerIndex], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Returns A = a random number 0-98 for RandomGoldOrItem_PickFind_RollFind (its only caller, twice):
; advances NextRandomSeed and takes wKeyRandomLo & $7F, rerolling while it is 99 or more. (C1,
; E-0370)
RandomGoldOrItem_PickFind_RollFind_RandomUnder99::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $7f
    cp $63
    jr nc, RandomGoldOrItem_PickFind_RollFind_RandomUnder99
    ret

; Two rows of eight bytes (the last two of each row unused), one row for each parity of the map
; sprite kind high nibble minus 2, six item ids per row picked by a roll tier 0-5 (a 0-98 roll below
; 50, 70, 80, 90, 95, or higher). Row 0 is ITEM_BEEFJERKY, ITEM_PORKCHOP, ITEM_RIB, ITEM_RIB,
; ITEM_SIRLOIN, ITEM_TINYMEDAL; row 1 is ITEM_HERB, ITEM_MOONHERB, ITEM_WARP, ITEM_MIST,
; ITEM_WORLDLEAF, ITEM_TINYMEDAL. RandomGoldOrItem_PickFind_RollFind stores the id in wScriptParam1
; and uses it to index RandomGoldOrItem_PickFind_RollFind_Data2. (C1, E-0381)
RandomGoldOrItem_PickFind_RollFind_Data1::
    db $19, $1a, $1b, $1b, $1c, $2c, $00, $00, $01, $07, $28, $22, $0c, $2c, $00, $00

; Forty-five bytes indexed by item id (0-$2C): the trigger kind that
; RandomGoldOrItem_PickFind_RollFind stores in wTriggerKind for the find, or 0 for no find. The ids
; the finds can give map to kind 8 for the four meats ($19-$1C), 4 for ITEM_HERB, ITEM_MOONHERB and
; ITEM_WORLDLEAF, 9 for ITEM_WARP and ITEM_MIST, and 1 for ITEM_TINYMEDAL ($2C); other entries hold
; 4-10 or 0. LoadTriggerMarkerGraphics then loads the marker sprite for the kind. (C1, E-0381)
RandomGoldOrItem_PickFind_RollFind_Data2::
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

; A 48-byte bit set for wSpeciesFlags (one bit per monster id, id / 8 byte, id AND 7 bit), the
; preset chosen when register C is 0; 15 data bytes followed by zeros. 101 ids are set, in the runs
; 1-26, 36-66, 71-102 and 106-117, and the set is contained in the sets of the other two presets.
; LoadSpeciesFlagsPresetC copies 48 bytes from it into wSpeciesFlags;
; GreatLogTalkEvents_SpeciesPreset selects it when the player stands at X $30. (C1, E-0381)
LoadSpeciesFlagsPresetC_Data1::
    db $fe, $ff, $ff, $07, $f0, $ff, $ff, $ff, $87, $ff, $ff, $ff, $7f, $fc, $3f
    ds $21, $00

; A 48-byte bit set for wSpeciesFlags (one bit per monster id, id / 8 byte, id AND 7 bit), the
; preset chosen when register C is 1; 31 data bytes followed by zeros. 201 ids are set (runs 1-26,
; 36-66, 71-102, 106-132, 141-167, 176-201, 211-240 and 246-247); it contains preset 0 and is
; contained in preset 2. LoadSpeciesFlagsPresetC copies 48 bytes from it into wSpeciesFlags;
; GreatLogTalkEvents_SpeciesPreset selects it when the player stands at X $40. (C1, E-0381)
LoadSpeciesFlagsPresetC_Data2::
    db $fe, $ff, $ff, $07, $f0, $ff, $ff, $ff, $87, $ff, $ff, $ff, $7f, $fc, $ff, $ff
    db $1f, $e0, $ff, $ff, $ff, $00, $ff, $ff, $ff, $03, $f8, $ff, $ff, $ff, $c1
    ds $11, $00

; A 48-byte bit set for wSpeciesFlags (one bit per monster id, id / 8 byte, id AND 7 bit), the
; preset chosen when register C is 2 or more; 47 data bytes, after which the bank is zero filled.
; 312 ids are set (runs 1-26, 36-66, 71-102, 106-132, 141-167, 176-201, 211-240, 246-272, 281-312,
; 316-347 and 351-372), a superset of the other two presets. LoadSpeciesFlagsPresetC copies the
; first 48 bytes into wSpeciesFlags; GreatLogTalkEvents_SpeciesPreset selects it for any other
; player X. (C1, E-0381)
LoadSpeciesFlagsPresetC_Data3::
    db $fe, $ff, $ff, $07, $f0, $ff, $ff, $ff, $87, $ff, $ff, $ff, $7f, $fc, $ff, $ff
    db $1f, $e0, $ff, $ff, $ff, $00, $ff, $ff, $ff, $03, $f8, $ff, $ff, $ff, $c1, $ff
    db $ff, $ff, $01, $fe, $ff, $ff, $ff, $f1, $ff, $ff, $ff, $8f, $ff, $ff, $1f
    ds $2160, $00
