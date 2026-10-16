; ROM bank $0F: story scenes: Darck, the homecoming, the mermaid and others
; The annotated listing of this bank is build/listing/bank0f.asm.

SECTION "Bank 0F", ROMX
    db $0f

; Script command type C7 (SCRIPT_SCENE_PENDANT_SELLER), run each frame through ScriptCommandC7 in
; bank $10 by Script_ThisPendantIsYours and Script_WhatWhereIGet. By wScriptStep: 0
; ScenePendantSeller_RaiseObject (object 1 rises to Y $30), 1 ScenePendantSeller_WalkObjectDown
; (object 1 walks down to Y $40), 2 ScenePendantSeller_WalkPlayerDown (the player walks down to Y
; $80), 3 ScenePendantSeller_KeepInStep (the followers catch up for $1E frames, then the script
; resumes). (C2, E-0376)
; implements script command type C7 (SCRIPT_SCENE_PENDANT_SELLER): a cutscene step named after the
; scene its only script shows: 'This pendant is yours for 38,000G' ... 'You're going to regret
; seeing us.'; reached through ScriptCommandC7 in bank $10 (E-0038, E-0245)
ScenePendantSeller::
    ld a, [wScriptStep]
    jumptable
    dw ScenePendantSeller_RaiseObject
    dw ScenePendantSeller_WalkObjectDown
    dw ScenePendantSeller_WalkPlayerDown
    dw ScenePendantSeller_KeepInStep

; Pendant seller scene, step 3: keeps the followers in step for $1E frames, then restarts the
; player's animation (hPlayerStateFlags bit 1 cleared) and resumes the script. (C2, E-0357; probed
; E-0376)
ScenePendantSeller_KeepInStep::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $1e
    ret nz
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F ScenePendantSeller_WalkPlayerDown", ROMX

; Pendant seller scene, step 2: walks the player down two pixels per frame (followers following) to
; Y $80. (C2, E-0357; probed E-0376)
ScenePendantSeller_WalkPlayerDown::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $80
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePendantSeller_WalkObjectDown", ROMX

; Pendant seller scene, step 1: walks object 1 down two pixels a frame to Y $40
; (StepObjectTowardCoord); on arrival freezes the player's animation (bit 1) and plays sound $63.
; (C2, E-0357; probed E-0376)
ScenePendantSeller_WalkObjectDown::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePendantSeller_RaiseObject", ROMX

; Pendant seller scene, step 0: moves object 1 up one pixel every other frame to Y $30, then sets
; its moving flag. (C2, E-0357; probed E-0376)
ScenePendantSeller_RaiseObject::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    ret z
    ld a, [wObject1 + OBJ_Y]
    dec a
    ld [wObject1 + OBJ_Y], a
    cp $30
    ret nz
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F PersonalityMessage", ROMX

; Script command type 62 (SCRIPT_PERSONALITY_MESSAGE), run each frame through ScriptCommand62 in
; bank $10 (Script_PersonalityMessage). By wScriptStep: 0 PersonalityMessage_PickMessage starts a
; group-5 message chosen by the family and personality of party monster wScriptParam1; 1
; PersonalityMessage_WaitForMessage waits for the message box to close and resumes the script
; (wScriptStartRequest = $80). (C1, E-0376)
; implements script command type 62 (SCRIPT_PERSONALITY_MESSAGE): shows a message chosen by a party
; monster's personality (PersonalityIndexOfRecord); reached through ScriptCommand62 in bank $10
; (E-0038, E-0245)
PersonalityMessage::
    ld a, [wScriptStep]
    jumptable
    dw PersonalityMessage_PickMessage
    dw PersonalityMessage_WaitForMessage

; A follower's personality message: picks a message in group 5 from the follower's family
; (PersonalityMessage_PickMessage_Data) plus its personality grade (PersonalityIndexOfRecord) and
; starts it. (C2, E-0357; probed E-0376)
PersonalityMessage_PickMessage::
    ld a, $0a
    ld [rRAMG], a
    ld hl, wPartyList
    ld a, [wScriptParam1]
    add_a_to_hl
    push hl
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    ld hl, PersonalityMessage_PickMessage_Data
    add_a_to_hl
    ld a, [hl]
    ld e, a
    pop hl
    ld a, [hl]
    push de
    call PersonalityIndexOfRecord
    pop de
    add e
    ld l, a
    ld h, $05
    call StartMessageHL_B0F
    xor a
    ld [rRAMG], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F PersonalityMessage_PickMessage_Data", ROMX

; Eleven message numbers, one per family 0-10 (the low nibble of MON_FAMILY): $94, $AF, $CA, $AF,
; $94, $CA, $AF, $94, $CA, $CA and $E5. PersonalityMessage_PickMessage adds the personality index of
; the follower (PersonalityIndexOfRecord, 0-26) to the byte and starts the result as a message of
; group 5, so each value is the first of 27 consecutive messages. (C1, E-0381)
PersonalityMessage_PickMessage_Data::
    db $94, $af, $ca, $af, $94, $ca, $af, $94, $ca, $ca, $e5

; Script command type 5F (SCRIPT_SCENE_HOMECOMING), run each frame through ScriptCommand5F in bank
; $10 by Script_CobiHeroCongratulationsI; a 45-step jump table on wScriptStep. Steps 0-6 bring in
; the scene object and Warubou (messages $0548, $0549); 7 fades and requests game mode 0 at state 8;
; 8-37 move objects 1 and 2, the player and the followers with hops and walks around messages
; $0DB0-$0DBA (SceneHomecoming_WaitMessage waits after each); 38-40 hop, walk and fade out; 41 shows
; 'THE END' and sets wGameCompleted; 42 counts a delay; 43 moves to map 6 in game mode 2 at
; wModeState $0B; 44 resumes the script. (C2, E-0376)
; implements script command type 5F (SCRIPT_SCENE_HOMECOMING): a cutscene step named after the scene
; its only script shows: 'Hehehe, no need to worry there!' ... 'Tara 0, congratulations! I was sad';
; reached through ScriptCommand5F in bank $10 (E-0038, E-0245)
SceneHomecoming::
    ld a, [wScriptStep]
    jumptable
    dw SceneHomecoming_PlaceObject
    dw SceneHomecoming_FlyArc
    dw SceneHomecoming_ShowWarubouWaheyInsteadOf
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_ShowWarubouNoOneKnows
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_FaceUp
    dw SceneHomecoming_FadeAndChangeMode
    dw SceneHomecoming_ShowObject
    dw SceneHomecoming_ShiftObjects
    dw SceneHomecoming_ShowWarubouWaheyIWas
    dw SceneHomecoming_ShowWarubouWaheyIWas
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_ShowKamehaIWentAnd
    dw SceneHomecoming_ShowKamehaIWentAnd
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_ShowWarubouWAHEYSomePrince
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_ShowKamehaYoureAGlutton
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_WalkPlayerLeft
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_HopObjects
    dw SceneHomecoming_WalkObject1
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_ShowKamehaNoOnesTaking
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_WalkPlayer
    dw SceneHomecoming_MoveTogether
    dw SceneHomecoming_MoveBack
    dw SceneHomecoming_Msg0DB8_WarubouWaheyIHave
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_WalkFirstFollowerLeft
    dw SceneHomecoming_HopFollower
    dw SceneHomecoming_WaitMessage
    dw SceneHomecoming_MoveTogether
    dw SceneHomecoming_MoveBack
    dw SceneHomecoming_MoveTogether
    dw SceneHomecoming_HopAndWalk
    dw SceneHomecoming_StartFinalFade
    dw SceneHomecoming_FinishFinalFade
    dw SceneHomecoming_ShowTHEEND
    dw SceneHomecoming_CountDelay
    dw SceneHomecoming_GoToMap6
    dw SceneHomecoming_SetScriptStartRequestTo80

; Homecoming scene, step 44: resumes the script. (C2, E-0357; probed E-0376)
SceneHomecoming_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneHomecoming_GoToMap6", ROMX

; Homecoming scene, step 43: moves the player to map 6, screen (0, 0) and switches to game mode 2 at
; wModeState $0B (the pages after the ending). (C2, E-0357; probed E-0376)
SceneHomecoming_GoToMap6::
    ld a, $06
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $02
    ld [wGameMode], a
    ld a, $0b
    ld [wModeState], a
    xor a
    ld [wWorldMapState], a
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_CountDelay", ROMX

; Homecoming scene, step 42: counts down the 16-bit delay in wScriptParam0/1. (C2, E-0357; probed
; E-0376)
SceneHomecoming_CountDelay::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, l
    or h
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowTHEEND", ROMX

; Homecoming scene, step 41: clears the scene's sprites and shows 'THE END' (string $FB of bank $28)
; as eight tiles in the middle of a blank screen, with its attributes and palettes. (C1, E-0357)
SceneHomecoming_ShowTHEEND::
    xor a
    ld [wSpriteSlotCount], a
    xor a
    ld [wObject5], a
    ld a, $e0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0801
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $fb
    ld [wStringIndex], a ; 'THE END…'
    farcall ShowString_Bank28
    ld hl, wScreenTileBuffer
    ld a, $c3
    ld bc, $0168
    call FillBytes
    ld hl, wScreenTileBuffer + $ba
    ld b, $08
    ld a, $80

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ld a, [wIsCGB]
    or a
    jr z, .check_sgb_active
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    xor a
    ld bc, $0168
    call FillBytes
    ld a, $00
    ldh [rSVBK], a

.check_sgb_active:
    ld a, [wSGBActive]
    or a
    jr z, .call_draw_full_screen_buffer_at_scroll
    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ld hl, OBJPaletteBufferPlus20Init_2
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    ld a, $fe
    call StartPaletteFade
    ld hl, $0258
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $01
    ld [wGameCompleted], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F OBJPaletteBufferPlus20Init_2", ROMX

; CopyBytes copies these 8 bytes to wOBJPaletteBuffer + $20 (E-0264)
; record: 8 bytes copied to wOBJPaletteBuffer + $20
OBJPaletteBufferPlus20Init_2::
    db $de, $67, $1f, $33, $3c, $12, $00, $00 ; entry 0

; Homecoming scene, step 40: waits for the fade to finish. (C2, E-0357; probed E-0376)
SceneHomecoming_FinishFinalFade::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_StartFinalFade", ROMX

; Homecoming scene, step 39: starts fade $3F. (C1, E-0357)
SceneHomecoming_StartFinalFade::
    ld a, $3f
    call StartPaletteFade
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_HopAndWalk", ROMX

; Homecoming scene, step 38: makes the scene object hop and walks object 2 left two pixels per frame
; to X $40, then hides the first sprite slot. (C2, E-0357; probed E-0376)
SceneHomecoming_HopAndWalk::
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit1AtHL_Bank0F
    ld a, [wObject2 + OBJ_X]
    dec a
    dec a
    ld [wObject2 + OBJ_X], a
    cp $40
    ret nz
    ld a, $e0
    ld [wSpriteSlots + $b], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_HopFollower", ROMX

; Homecoming scene, step 33: makes the second follower hop; when the hop ends shows message $0DBA.
; (C2, E-0357; probed E-0376)
SceneHomecoming_HopFollower::
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $01
    add $b9
    ld l, a
    ld h, $0d
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_WalkFirstFollowerLeft", ROMX

; Homecoming scene, step 32: walks the first follower left to X $78 and turns it to face up. (C2,
; E-0357; probed E-0376)
SceneHomecoming_WalkFirstFollowerLeft::
    ld a, [wFollowerRecords + $1]
    dec a
    dec a
    ld [wFollowerRecords + $1], a
    cp $78
    ret nz
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_Msg0DB8_WarubouWaheyIHave", ROMX

; Homecoming scene, step 30: Warubou's 'Wahey, I have ...' (message $0DB8). (C2, E-0357; probed
; E-0376)
SceneHomecoming_Msg0DB8_WarubouWaheyIHave::
    ld hl, $0db8 ; 'Warubou: Wa-hey… I have seen this…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_MoveBack", ROMX

; Homecoming scene, step 29: moves object 2, the player and the scene object back by the negated
; amounts of the step-28 table. (C2, E-0357; probed E-0376)
SceneHomecoming_MoveBack::
    ld a, [wScriptParam0]
    ld hl, SceneHomecoming_MoveBack_Data
    add_a_to_hl
    ld a, [hl]
    xor $ff
    inc a
    ld c, a
    jr SceneHomecoming_AddToX

SECTION "Bank 0F SceneHomecoming_MoveTogether", ROMX

; Homecoming scene, step 28: sets object 2 walking and moves it, the player and the scene object
; together by the per-frame amounts of SceneHomecoming_MoveBack_Data for $40 frames. (C2, E-0357;
; probed E-0376)
SceneHomecoming_MoveTogether::
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScriptParam0]
    ld hl, SceneHomecoming_MoveBack_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a

; Adds C to the X of object 2, the player and the scene object; after $40 frames moves on. (C2,
; E-0357; probed E-0376)
SceneHomecoming_AddToX::
    ld a, [wObject2 + OBJ_X]
    add c
    ld [wObject2 + OBJ_X], a
    ldh a, [hPlayerX]
    add c
    ldh [hPlayerX], a
    ld a, [wObject5 + SCRIPTOBJ_X]
    add c
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $40
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_MoveBack_Data", ROMX

; 64 signed bytes ($00, $01 or $FF for -1): the X step added each frame to object 2, the player and
; the scene object, indexed by wScriptParam0 (the frame count 0-$3F). Step 28
; (SceneHomecoming_MoveTogether) adds them as they are and step 29 (SceneHomecoming_MoveBack) adds
; the negated value, so the group returns to its start X: the 64 values sum to 0, and the running
; total in step 28 stays between 0 and +7 (step 29 mirrors it). (C1, E-0381)
SceneHomecoming_MoveBack_Data::
    db $01, $00, $01, $00, $01, $01, $00, $ff, $01, $00, $00, $ff, $00, $ff, $ff, $00
    db $01, $00, $00, $00, $01, $01, $ff, $00, $00, $ff, $00, $00, $00, $ff, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $ff, $00, $00, $00, $ff, $01
    db $ff, $00, $00, $01, $ff, $ff, $ff, $00, $00, $00, $ff, $00, $00, $ff, $ff, $00

; Homecoming scene, step 27: walks the player up to Y $30, then left to X $78. (C2, E-0357; probed
; E-0376)
SceneHomecoming_WalkPlayer::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_player_facing_to_03
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_player_facing_to_03:
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowKamehaNoOnesTaking", ROMX

; Homecoming scene, step 25: makes object 2 hop; then Kameha's 'No one's taking ...' (message
; $0DB7). (C2, E-0357; probed E-0376)
SceneHomecoming_ShowKamehaNoOnesTaking::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db7 ; 'Kameha: No one's taking this pie'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_WalkObject1", ROMX

; Homecoming scene, step 23: walks object 1 down (two pixels a frame) to Y $40, then left to X $58;
; then sets the objects' states and shows message $0DB6. (C2, E-0357; probed E-0376)
SceneHomecoming_WalkObject1::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_target_to_83
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_target_to_83:
    ld a, $83
    ld [wStepTarget], a
    ld a, $58
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    xor a
    ld [wObject2 + OBJ_STATE], a
    ld hl, $0db6 ; 'Warubou: Wa-hey! Now look, warooh! It's'
    call StartMessageHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_HopObjects", ROMX

; Homecoming scene, step 22: both objects hop together; at the end object 1 faces left. (C2, E-0357;
; probed E-0376)
SceneHomecoming_HopObjects::
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld de, wObject2 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_WalkPlayerLeft", ROMX

; Homecoming scene, step 20: stops both objects and walks the player left to X $80; then message
; $0DB5. (C2, E-0357; probed E-0376)
SceneHomecoming_WalkPlayerLeft::
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    add $b4
    ld l, a
    ld h, $0d
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowKamehaYoureAGlutton", ROMX

; Homecoming scene, step 18: makes object 2 hop; then Kameha's 'You're a glutton' (message $0DB3).
; (C2, E-0357; probed E-0376)
SceneHomecoming_ShowKamehaYoureAGlutton::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db3 ; 'Kameha: You're a glutton! You haven't'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowWarubouWAHEYSomePrince", ROMX

; Homecoming scene, step 16: makes object 1 hop; then Warubou's 'WAHEY! Some prince ...' (message
; $0DB2). (C2, E-0357; probed E-0376)
SceneHomecoming_ShowWarubouWAHEYSomePrince::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db2 ; 'Warubou: WA-HEY! Some Prince! Always a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowKamehaIWentAnd", ROMX

; Homecoming scene, step 13: makes object 2 hop; then Kameha's 'I went and ...' (message $0DB1).
; (C2, E-0357; probed E-0376)
SceneHomecoming_ShowKamehaIWentAnd::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db1 ; 'Kameha: I went and faced danger'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowWarubouWaheyIWas", ROMX

; Homecoming scene, step 10: makes object 1 hop; then Warubou's 'Wahey, I was ...' (message $0DB0).
; (C2, E-0357; probed E-0376)
SceneHomecoming_ShowWarubouWaheyIWas::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db0 ; 'Warubou: Wa-hey! I was the plug'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShiftObjects", ROMX

; Homecoming scene, step 9: runs ScriptStepSetObjectBit2AndWait (bank $73): sets bit 2 of OBJ_FLAGS
; of objects 1 and 2, shows the scene object (wObject5 = $80), shifts the objects by
; ShiftObjectsXByTable each frame and moves on once wScriptParam0 is back to 0. (C2, E-0369; probed
; E-0376)
SceneHomecoming_ShiftObjects::
    farcall ScriptStepSetObjectBit2AndWait
    ret

SECTION "Bank 0F SceneHomecoming_ShowObject", ROMX

; Homecoming scene, step 8: places the scene object (field command 1) at ($68, $30) and shows it.
; (C1, E-0357)
SceneHomecoming_ShowObject::
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $68
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_FadeAndChangeMode", ROMX

; Homecoming scene, step 7: starts palette fade $10, requests game mode 0 at mode state 8 (wGameMode
; = 0, wModeState = 8, wModeChangeRequest += 1) and moves on. (C1, E-0369)
SceneHomecoming_FadeAndChangeMode::
    ld a, $10
    call StartPaletteFade
    ld a, $00
    ld [wGameMode], a
    ld a, $08
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_FaceUp", ROMX

; Homecoming scene, step 6: the player faces up for $78 frames. (C2, E-0357; probed E-0376)
SceneHomecoming_FaceUp::
    ld a, $01
    ldh [hPlayerFacing], a
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowWarubouNoOneKnows", ROMX

; Homecoming scene, step 4: shows the scene object rising with a hop; then Warubou's 'No one knows
; ...' (message $0549). (C2, E-0357; probed E-0376)
SceneHomecoming_ShowWarubouNoOneKnows::
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0549 ; 'Warubou: No one knows how many'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_ShowWarubouWaheyInsteadOf", ROMX

; Homecoming scene, step 2: the player faces left; the player and object 2 hop for $20 frames; then
; Warubou's 'Wahey, instead of ...' (message $0548). (C2, E-0357; probed E-0376)
SceneHomecoming_ShowWarubouWaheyInsteadOf::
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + OBJ_Y
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
    ld hl, $0548 ; 'Warubou: Wa-hey! Instead of a quest'
    call StartMessageHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_FlyArc", ROMX

; Homecoming scene, step 1: object 3 flies in an arc (a 16-bit vertical speed growing by $18 per
; frame) moving right two pixels per frame to X $40, then lands at Y $40. (C2, E-0357; probed
; E-0376)
SceneHomecoming_FlyArc::
    ld de, $0018
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    add hl, de
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld c, h
    ld a, [wObject3 + OBJ_Y]
    add c
    ld [wObject3 + OBJ_Y], a
    ld a, [wObject3 + OBJ_X]
    inc a
    inc a
    ld [wObject3 + OBJ_X], a
    cp $40
    ret nz
    ld a, $40
    ld [wObject3 + OBJ_Y], a
    xor a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHomecoming_PlaceObject", ROMX

; Homecoming scene, step 0: places the scene object (field command $13) at ($40, $40), sets the arc
; speed to -$180, plays sound $65 and hides the field sprites. (C1, E-0357)
SceneHomecoming_PlaceObject::
    ld a, $13
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld [wObject5 + SCRIPTOBJ_Y], a
    lb hl, $fe, $80
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $65
    call QueueSoundEffect
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated", ROMX

; Script command type 5E (SCRIPT_SCENE_DARCK_DEFEATED), run each frame through ScriptCommand5E in
; bank $10 by Script_DarckFawahahahYouChased; a 149-step jump table on wScriptStep. It blinks Darck
; out (setting EVENT_SCENE_DARCK_DEFEATED), walks the player, shows messages $055A, $055B, $0533,
; $0DF7, $0537, $0538, $0539 and $053A, most followed by SceneHomecoming_WaitMessage, runs
; BossWinScene and screen shakes, then visits maps $26, $2F, $33, $41, $49, $60, $71 and 3 in turn
; (SceneDarckDefeated_StartMapChange), each with object walks and hops and the scene object rising
; (SceneDarckDefeated_RaiseSceneObject); last it warps to the king (map $19), shows messages $053B
; and $053C and ends with PersonalityMessage_WaitForMessage. (C2, E-0376)
; implements script command type 5E (SCRIPT_SCENE_DARCK_DEFEATED): a cutscene step named after the
; scene its only script shows: 'Darck Wha What? How could I' ... 'Darck Fwahahahah! Bravo!
; Splendid!'; reached through ScriptCommand5E in bank $10 (E-0038, E-0245)
SceneDarckDefeated::
    ld a, [wScriptStep]
    jumptable
    dw SceneDarckDefeated_BlinkOut
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkPlayer
    dw SceneDarckDefeated_HopSprite
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_MoveSprite0Down
    dw SceneDarckDefeated_Msg055A_AVoiceEchoedFrom
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_Msg055B_WaheyCanYouHear
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_ShowWarubouWaheyYouDid
    dw SceneDarckDefeated_RunBossWinScene
    dw SceneDarckDefeated_ResetScene
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_ShakeScreen
    dw SceneDarckDefeated_ShowWarubouWaheyFeelThat
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_StartScrollShake
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_ShowWarubouWawaheyWeWere
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_HopPlayer
    dw SceneDarckDefeated_ClearEventArg
    dw SceneDarckDefeated_WalkObject0Up
    dw SceneDarckDefeated_WalkObject0Down
    dw SceneDarckDefeated_WalkObject0Up
    dw SceneDarckDefeated_WalkObject0Down
    dw SceneDarckDefeated_WalkObject0Up
    dw SceneDarckDefeated_WalkObject0Down
    dw SceneDarckDefeated_WalkObject0Up
    dw SceneDarckDefeated_ShowWarubouWaheyThatsIt
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_WalkPlayerDown
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_ShowWarubouWaheyGetGoing
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_MoveSceneObject
    dw SceneDarckDefeated_ShowWarubouWaheyGreatLogsLife
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_MoveSceneObject
    dw SceneDarckDefeated_WarpToMap26
    dw SceneDarckDefeated_PlaceObject
    dw SceneDarckDefeated_TurnObjects
    dw SceneDarckDefeated_HopObject2
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap2F
    dw SceneDarckDefeated_PlaceObjectAgain
    dw SceneDarckDefeated_WaitAndPlaceSprite
    dw SceneDarckDefeated_WalkObject0DownFar
    dw SceneDarckDefeated_DriftSprite
    dw SceneDarckDefeated_WalkObjectsApart
    dw SceneDarckDefeated_WalkObject0Off
    dw SceneDarckDefeated_WalkObject2Down
    dw SceneDarckDefeated_DriftObject2
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap33
    dw SceneDarckDefeated_PlaceObjectLeft
    dw SceneDarckDefeated_WalkObject1Around
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_HopObject1
    dw SceneDarckDefeated_HopObject1
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObject1Off
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObjectsUp
    dw SceneDarckDefeated_HopObject3
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap41
    dw SceneDarckDefeated_PlaceObjectTop
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_MoveObjectsLeft
    dw SceneDarckDefeated_HopObjectsAndFace
    dw SceneDarckDefeated_MoveObjectsRight
    dw SceneDarckDefeated_HopObjects
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap49
    dw SceneDarckDefeated_PlaceObjectMiddle
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObjects34Up
    dw SceneDarckDefeated_HopObject1Again
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObject1DownRight
    dw SceneDarckDefeated_DriftObject1
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObject2Left
    dw SceneDarckDefeated_WalkObjects34Off
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_FlickerSprite
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap60
    dw SceneDarckDefeated_PlaceObjectLow
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObject4Up
    dw SceneDarckDefeated_WalkObjectsTogether
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObject4Right
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObject4Left
    dw SceneDarckDefeated_WalkObject0DownAgain
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObjectsApartAgain
    dw SceneDarckDefeated_WalkObject0DownLast
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap71
    dw SceneDarckDefeated_PlaceObjectLeftAgain
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WalkObjects23Left
    dw SceneDarckDefeated_FlickerObject1
    dw SceneDarckDefeated_HopObjects23
    dw SceneDarckDefeated_WalkObjects23Right
    dw SceneDarckDefeated_RaiseSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToMap03
    dw SceneDarckDefeated_PlaceObjectLeftLast
    dw SceneDarckDefeated_MoveSceneObjectAgain
    dw SceneDarckDefeated_MoveSceneObjectAgain
    dw SceneDarckDefeated_HideSceneObject
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_Wait
    dw SceneDarckDefeated_WarpToKing
    dw SceneDarckDefeated_Msg053B_KingIThankYou
    dw SceneHomecoming_WaitMessage
    dw SceneDarckDefeated_PlaySound
    dw SceneDarckDefeated_ShowKingEvenThoughThe
    dw PersonalityMessage_WaitForMessage

; Darck defeated scene, step 147: the king's 'Even though the ...' (message $053C) and marks the
; first key of kind 6 (MarkKeyEntryKindTemp0Bit6). (C2, E-0357; probed E-0376)
SceneDarckDefeated_ShowKingEvenThoughThe::
    ld hl, $053c ; 'King: Even though the island's crisis'
    call StartMessageHL_B0F
    ld a, $06
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaySound", ROMX

; Darck defeated scene, step 146: plays sound $6D, waits $78 frames, then restarts the map music.
; (C1, E-0357)
SceneDarckDefeated_PlaySound::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_script_param0
    inc a
    ld [wScriptParam0], a
    ld a, $6d
    call QueueSoundEffect
    ret

.set_script_param0:
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    farcall RestartMapMusic
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_Msg053B_KingIThankYou", ROMX

; Darck defeated scene, step 144: the king's 'I thank you ...' (message $053B). (C2, E-0357; probed
; E-0376)
SceneDarckDefeated_Msg053B_KingIThankYou::
    ld hl, $053b ; 'King: I thank you all for'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToKing", ROMX

; Darck defeated scene, step 143: clears the field event, sets bit 5 of story byte $60, and warps to
; map $19 at ($40, $40) with transition kind 3 and fade $3F. (C1, E-0357)
SceneDarckDefeated_WarpToKing::
    xor a
    ld [wFieldEventArg], a
    ld a, [wStoryFlags + $60]
    set 5, a
    ld [wStoryFlags + $60], a
    ld a, $19
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $3f
    call StartPaletteFade
    ret

SECTION "Bank 0F SceneDarckDefeated_HideSceneObject", ROMX

; Darck defeated scene, step 140: hides the scene object. (C2, E-0357; probed E-0376)
SceneDarckDefeated_HideSceneObject::
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectLeftLast", ROMX

; Darck defeated scene, step 137: places the scene object (field command $11) at ($20, $50), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectLeftLast::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap03", ROMX

; Darck defeated scene, step 136: moves to map 3, screen (0, 0), scene object at ($40, $30), with a
; fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap03::
    ld a, $03
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjects23Right", ROMX

; Darck defeated scene, step 132: moves objects 2 and 3 right two pixels a frame
; (StepObjectTowardCoord with wStepTarget = $81: direction 1, two pixels) toward X $B0 and X $C0;
; wScriptStep + 1 when object 3 arrives (only the second call sets the tested wStepArrived). The $81
; in the old name is the step target, not a coordinate. (C2, E-0376)
; steps objects 2 and 3 toward ($81, $B0) and ($81, $C0) (StepObjectTowardCoord); advances
; wScriptStep once they arrive (E-0124)
SceneDarckDefeated_WalkObjects23Right::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $b0
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $c0
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObjects23", ROMX

; Darck defeated scene, step 131: object 2 hops (ScriptApplyStepDeltaAtDE on its OBJ_Y) and object 3
; copies its Y each frame, so both hop together; when the hop ends (16 frames, carry) wScriptStep +
; 1. (C2, E-0376)
; ScriptApplyStepDeltaAtDE on wObject2 + $C, copies wObject2 + $C to wObject3 + $C, and when the
; move finishes (carry) wScriptStep += 1 (E-0119) (E-0340: the address in its name read as its RAM
; name; was SceneDarckDefeated_HopObjects23)
SceneDarckDefeated_HopObjects23::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject2 + OBJ_Y]
    ld [wObject3 + OBJ_Y], a
    pop af
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_FlickerObject1", ROMX

; Darck defeated scene, step 130: flickers object 1 by setting its OBJ_Y to $40 (shown) or $E0
; (hidden) from a bit of the count wScriptParam0: bit 1 below $1E, bit 2 below $3C, then bit 3, so
; it switches every 2, then 4, then 8 frames. After $78 frames (StepScriptParam0Counter_Bank0F) Y =
; $40 and wScriptStep + 1. (C2, E-0376)
; alternates wObject1 + $C between $E0 and $40 at a rate that slows with wScriptParam0; after $78
; frames sets $40 and advances wScriptStep (E-0125)
SceneDarckDefeated_FlickerObject1::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_object1_to_E0
    jr .set_object1_to_40

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_object1_to_E0
    jr .set_object1_to_40

.check_bit3:
    bit 3, a
    jr z, .set_object1_to_E0
    jr .set_object1_to_40

.set_object1_to_E0:
    ld a, $e0
    ld [wObject1 + OBJ_Y], a
    jr .call_step_script_param0_counter_bank0_f

.set_object1_to_40:
    ld a, $40
    ld [wObject1 + OBJ_Y], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $40
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjects23Left", ROMX

; Darck defeated scene, step 129: moves objects 2 and 3 left one pixel a frame
; (StepObjectTowardCoord with wStepTarget = 3) toward X $40 and X $50; wScriptStep + 1 when object 3
; arrives. The 03 in the old name is the direction, not a coordinate. (C2, E-0376)
; steps objects 2 and 3 toward ($03, $40) and ($03, $50); advances wScriptStep once they arrive
; (E-0124)
SceneDarckDefeated_WalkObjects23Left::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectLeftAgain", ROMX

; Darck defeated scene, step 127: places the scene object (field command $11) at ($20, $40), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectLeftAgain::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap71", ROMX

; Darck defeated scene, step 126: moves to map $71, screen (0, 0), scene object at ($40, $30), with
; a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap71::
    ld a, $71
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject0DownLast", ROMX

; Darck defeated scene, step 121: walks object 0 down to Y $60. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject0DownLast::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjectsApartAgain", ROMX

; Darck defeated scene, step 120: walks object 1 left to X $30 and object 2 right to X $60, then
; stops them. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObjectsApartAgain::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $30
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject0DownAgain", ROMX

; Darck defeated scene, step 118: walks object 0 down to Y $50, then objects 1 and 2 face up. (C2,
; E-0357; probed E-0376)
SceneDarckDefeated_WalkObject0DownAgain::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject4Left", ROMX

; Darck defeated scene, step 117: walks object 4 left to X $40. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject4Left::
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    jr SceneDarckDefeated_WalkObject4ToTarget

SECTION "Bank 0F SceneDarckDefeated_WalkObject4Right", ROMX

; Darck defeated scene, step 115: walks object 4 right to X $50. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject4Right::
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a

; Walks object 4 toward the target set, then it faces up. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject4ToTarget::
    ld a, $04
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ld [wObject4 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjectsTogether", ROMX

; Darck defeated scene, step 113: walks object 1 right to X $40 and object 2 left to X $50 (two
; pixels a frame), then stops them. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObjectsTogether::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject4Up", ROMX

; Darck defeated scene, step 112: walks object 4 up to Y $70. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject4Up::
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $70
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectLow", ROMX

; Darck defeated scene, step 110: places the scene object (field command $11) at ($40, $60), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectLow::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $60
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap60", ROMX

; Darck defeated scene, step 109: moves to map $60, screen (0, 0), scene object at ($40, $30), with
; a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap60::
    ld a, $60
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_FlickerSprite", ROMX

; Darck defeated scene, step 104: makes a sprite flicker for $78 frames (shown at Y $30 or hidden at
; $E0, switching every 2 frames, then every 4 from frame $1E and every 8 from $3C), then leaves it
; shown. (C2, E-0357; probed E-0376)
SceneDarckDefeated_FlickerSprite::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_sprite_slots_to_E0
    jr .set_sprite_slots_to_30

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_sprite_slots_to_E0
    jr .set_sprite_slots_to_30

.check_bit3:
    bit 3, a
    jr z, .set_sprite_slots_to_E0
    jr .set_sprite_slots_to_30

.set_sprite_slots_to_E0:
    ld a, $e0
    ld [wSpriteSlots + $c], a
    jr .call_step_script_param0_counter_bank0_f

.set_sprite_slots_to_30:
    ld a, $30
    ld [wSpriteSlots + $c], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjects34Off", ROMX

; Darck defeated scene, step 102: walks objects 3 and 4 down (two pixels a frame) to Y $B0, off the
; screen. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObjects34Off::
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $b0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $b0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject2Left", ROMX

; Darck defeated scene, step 101: walks object 2 left (two pixels a frame) to X $40 with object 1
; following it, then sets the objects' states; then walks object 2 down to Y $C0 with object 1
; riding 8 pixels above it. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject2Left::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_ptr_hi_to_02
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + OBJ_X]
    ld [wObject1 + OBJ_X], a
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld a, $01
    ld [wObject3 + OBJ_STATE], a
    ld a, $03
    ld [wObject4 + OBJ_STATE], a
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $c0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + OBJ_Y]
    sub $08
    ld [wObject1 + OBJ_Y], a
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wObject3 + OBJ_STATE], a
    ld [wObject4 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_DriftObject1", ROMX

; Darck defeated scene, step 99: object 1 drifts up and right while hopping for $20 frames, then
; faces left. (C2, E-0357; probed E-0376)
SceneDarckDefeated_DriftObject1::
    ld a, [wScriptParam0]
    and $03
    jr nz, .check_script_param0
    ld hl, wObject1 + OBJ_Y
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    and $01
    jr nz, .set_step_ptr_lo
    ld hl, wObject1 + OBJ_X
    inc [hl]

.set_step_ptr_lo:
    ld de, wObject1 + OBJ_Y
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
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject1DownRight", ROMX

; Darck defeated scene, step 98: walks object 1 down to Y $70, then it faces right. (C2, E-0357;
; probed E-0376)
SceneDarckDefeated_WalkObject1DownRight::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $70
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObject1Again", ROMX

; Darck defeated scene, step 96: makes object 1 hop once (16 frames). (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopObject1Again::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjects34Up", ROMX

; Darck defeated scene, step 95: walks objects 3 and 4 up to Y $80, then stops object 1. (C2,
; E-0357; probed E-0376)
SceneDarckDefeated_WalkObjects34Up::
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectMiddle", ROMX

; Darck defeated scene, step 92: places the scene object (field command $11) at ($40, $30), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectMiddle::
    ld a, $11
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

SECTION "Bank 0F SceneDarckDefeated_WarpToMap49", ROMX

; Darck defeated scene, step 91: moves to map $49, screen (0, 0), with a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap49::
    ld a, $49
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObjects", ROMX

; Darck defeated scene, step 86: objects 1-3 hop together while turning every four frames (and a
; sprite 48 pixels above them); then they face up (state 2). (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopObjects::
    ld a, [wScriptParam0]
    and $03
    jr nz, .call_script_apply_step_delta_at_de
    ld a, [wSpriteSlots + $7]
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld a, [wObject1 + OBJ_STATE]
    inc a
    and $03
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a

.call_script_apply_step_delta_at_de:
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject1 + OBJ_Y]
    ld [wObject2 + OBJ_Y], a
    ld [wObject3 + OBJ_Y], a
    sub $30
    ld [wSpriteSlots + $c], a
    pop af
    ret nc
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_MoveObjectsRight", ROMX

; Darck defeated scene, step 85: moves objects 1-3 right one pixel every four frames, 16 pixels
; apart, until object 3 reaches X $60. (C2, E-0357; probed E-0376)
SceneDarckDefeated_MoveObjectsRight::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    add $10
    ld [wObject2 + OBJ_X], a
    add $10
    ld [wObject3 + OBJ_X], a
    cp $60
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObjectsAndFace", ROMX

; Darck defeated scene, step 84: objects 1-3 hop together while turning; then they face right (state
; 1). (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopObjectsAndFace::
    ld a, [wScriptParam0]
    and $03
    jr nz, .call_script_apply_step_delta_at_de
    ld a, [wObject1 + OBJ_STATE]
    inc a
    and $03
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a

.call_script_apply_step_delta_at_de:
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject1 + OBJ_Y]
    ld [wObject2 + OBJ_Y], a
    ld [wObject3 + OBJ_Y], a
    pop af
    ret nc
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_MoveObjectsLeft", ROMX

; Darck defeated scene, step 83: objects 1-3 face left and move left one pixel every four frames
; until object 3 reaches X $50. (C2, E-0357; probed E-0376)
SceneDarckDefeated_MoveObjectsLeft::
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld [wObject3 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    add $10
    ld [wObject2 + OBJ_X], a
    add $10
    ld [wObject3 + OBJ_X], a
    cp $50
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectTop", ROMX

; Darck defeated scene, step 81: places the scene object (field command $11) at ($40, $20), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectTop::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap41", ROMX

; Darck defeated scene, step 80: moves to map $41, screen (0, 0), with a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap41::
    ld a, $41
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObject3", ROMX

; Darck defeated scene, step 75: makes object 3 hop once. (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopObject3::
    ld de, wObject3 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjectsUp", ROMX

; Darck defeated scene, step 74, in three phases by wScriptParam0 (one pixel a frame,
; StepObjectTowardCoord): 0 walks objects 2 and 1 up to Y $60; 1 walks object 1 left to X $20 while
; object 2 first finishes going up to Y $60 and then goes left; 2 walks object 2 left to X $20 and
; object 1 up to Y $50. Each phase ends when object 1 arrives. Then object 3 gets OBJ_STATE 0 and
; object 2 OBJ_STATE 2 (the direction value StepObjectTowardCoord stores for moving up),
; wScriptParam0 = 0 and wScriptStep + 1. The earlier reading said object 2 faces down. (C2, E-0376)
SceneDarckDefeated_WalkObjectsUp::
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .set_step_ptr_lo_to_202
    ld a, [wObject2 + OBJ_Y]
    cp $60
    jr z, .set_step_ptr_lo_to_20
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    jr .set_step_ptr_hi_to_02

.set_step_ptr_lo_to_20:
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_lo_to_202:
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wObject3 + OBJ_STATE], a
    ld a, $02
    ld [wObject2 + OBJ_STATE], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject1Off", ROMX

; Darck defeated scene, step 72: walks object 1 down to Y $60, right to X $40, then down to Y $B0
; (two pixels a frame), off the screen. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject1Off::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .set_step_ptr_lo_to_B0
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_lo_to_B0:
    ld a, $b0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObject1", ROMX

; Darck defeated scene, step 69: makes object 1 hop once. (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopObject1::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject1Around", ROMX

; Darck defeated scene, step 67: walks object 1 up to Y $60, left to X $20, then up to Y $50. (C2,
; E-0357; probed E-0376)
SceneDarckDefeated_WalkObject1Around::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .set_step_ptr_lo_to_50
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_lo_to_50:
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectLeft", ROMX

; Darck defeated scene, step 66: places the scene object (field command $11) at ($20, $40), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectLeft::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap33", ROMX

; Darck defeated scene, step 65: moves to map $33, screen (0, 0), with a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap33::
    ld a, $33
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_DriftObject2", ROMX

; Darck defeated scene, step 60: object 2 faces left and drifts left while hopping once, then stops.
; (C2, E-0357; probed E-0376)
SceneDarckDefeated_DriftObject2::
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject2Down", ROMX

; Darck defeated scene, step 59: walks object 2 down (two pixels a frame) to Y $60, then turns the
; first sprite. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject2Down::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr SceneDarckDefeated_WalkDownAndTurnObject0Left

SECTION "Bank 0F SceneDarckDefeated_WalkObject0Off", ROMX

; Darck defeated scene, step 58: walks object 0 left to X $E0 (two pixels a frame) while object 1
; drifts right and hops; then puts object 2 at Y $30. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject0Off::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $e0
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wObject1 + OBJ_X
    inc [hl]
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld a, $30
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObjectsApart", ROMX

; Darck defeated scene, step 57: walks object 0 left to X $E0 and object 1 down to Y $60. (C2,
; E-0357; probed E-0376)
SceneDarckDefeated_WalkObjectsApart::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $e0
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr SceneDarckDefeated_WalkDownAndTurnObject0Left

SECTION "Bank 0F SceneDarckDefeated_DriftSprite", ROMX

; Darck defeated scene, step 56: the first sprite drifts left while hopping; then object 1 is put at
; Y $30. (C2, E-0357; probed E-0376)
SceneDarckDefeated_DriftSprite::
    ld hl, wSpriteSlots + $b
    dec [hl]
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $30
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject0DownFar", ROMX

; Darck defeated scene, step 55: walks object 0 down (two pixels a frame) to Y $60. (C2, E-0357;
; probed E-0376)
SceneDarckDefeated_WalkObject0DownFar::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a

; Shared tail of steps 55 (SceneDarckDefeated_WalkObject0DownFar), 57
; (SceneDarckDefeated_WalkObjectsApart, for object 1) and 59 (SceneDarckDefeated_WalkObject2Down):
; with wStepPtrHi = the object and wStepPtrLo = the target Y set by the caller, sets wStepTarget =
; $80 (down, two pixels a frame) and steps the object (StepObjectTowardCoord); on arrival sets
; direction 3 (left) at wSpriteSlots + $7, object 0's slot whichever object walked, and advances
; wScriptStep. (C2, E-0369; probed E-0376)
SceneDarckDefeated_WalkDownAndTurnObject0Left::
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WaitAndPlaceSprite", ROMX

; Darck defeated scene, step 54: waits $5A frames, then puts the first sprite at Y $30. (C2, E-0357;
; probed E-0376)
SceneDarckDefeated_WaitAndPlaceSprite::
    ld b, $5a
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObjectAgain", ROMX

; Darck defeated scene, step 53: places the scene object (field command $11) at ($30, $60), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObjectAgain::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $60
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap2F", ROMX

; Darck defeated scene, step 52: moves to map $2F, screen (1, 0), with a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap2F::
    ld a, $2f
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_StartMapChange
    ret

SECTION "Bank 0F SceneDarckDefeated_RaiseSceneObject", ROMX

; Darck defeated scene, step 49: the scene object rises one pixel every other frame for $40 frames,
; then is hidden. (C2, E-0357; probed E-0376)
SceneDarckDefeated_RaiseSceneObject::
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    jr z, .check_script_param0
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    cp $40
    ret nz
    xor a
    ld [wObject5], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_HopObject2", ROMX

; Darck defeated scene, step 47: object 2 hops while objects 3 and 4 turn every eight frames; then
; objects 3 and 4 face up. (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopObject2::
    ld a, [wScriptParam0]
    and $07
    jr nz, .call_script_apply_step_delta_at_de
    ld a, [wObject3 + OBJ_STATE]
    inc a
    and $03
    ld [wObject3 + OBJ_STATE], a
    ld [wObject4 + OBJ_STATE], a

.call_script_apply_step_delta_at_de:
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $02
    ld [wObject3 + OBJ_STATE], a
    ld [wObject4 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_TurnObjects", ROMX

; Darck defeated scene, step 46: objects 3 and 4 turn every four frames for $96 frames. (C2, E-0357;
; probed E-0376)
SceneDarckDefeated_TurnObjects::
    ld a, [wScriptParam0]
    and $03
    jr nz, .call_step_script_param0_counter_bank0_f
    ld a, [wObject3 + OBJ_STATE]
    inc a
    and $03
    ld [wObject3 + OBJ_STATE], a
    ld [wObject4 + OBJ_STATE], a

.call_step_script_param0_counter_bank0_f:
    ld b, $96
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_PlaceObject", ROMX

; Darck defeated scene, step 45: places the scene object (field command $11) at ($40, $10), hidden.
; (C1, E-0357)
SceneDarckDefeated_PlaceObject::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $10
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wObject5], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WarpToMap26", ROMX

; Darck defeated scene, step 44: sets the field event argument and moves to map $26, screen (0, 0),
; with a fade. (C1, E-0357)
SceneDarckDefeated_WarpToMap26::
    ld a, $01
    ld [wFieldEventArg], a
    ld a, $26
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

; Starts a scene map change: the player at X $E0 (the same Y), transition kind 4, the fade
; (ScriptStartFadeAndAdvanceStep), the scene object hidden. (C1, E-0357)
SceneDarckDefeated_StartMapChange::
    ld a, $e0
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    xor a
    ld [wObject5], a
    ret

SECTION "Bank 0F SceneDarckDefeated_ShowWarubouWaheyGreatLogsLife", ROMX

; Darck defeated scene, step 41: Warubou's 'Wahey! Great Log's life ...' (message $053A). (C2,
; E-0357; probed E-0376)
SceneDarckDefeated_ShowWarubouWaheyGreatLogsLife::
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $053a ; 'Warubou: Wa-hey? GreatLog's life force is'
    call StartMessageHL_B0F
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_ShowWarubouWaheyGetGoing", ROMX

; Darck defeated scene, step 37: Warubou's 'Wahey! Get going ...' (message $0539) and places the
; scene object (field command $11). (C1, E-0357)
SceneDarckDefeated_ShowWarubouWaheyGetGoing::
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0539 ; 'Warubou: Wa-hey! Get going!'
    call StartMessageHL_B0F
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a
    ld [wObject5], a
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkPlayerDown", ROMX

; Darck defeated scene, step 35: walks the player down to Y $40, then right to X $80, then faces
; left. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkPlayerDown::
    xor a
    ld [wFieldEventArg], a
    ldh a, [hPlayerY]
    cp $40
    jr z, .set_step_ptr_lo_to_80
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ret

.set_step_ptr_lo_to_80:
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_ShowWarubouWaheyThatsIt", ROMX

; Darck defeated scene, step 33: Warubou's 'Wahey! That's it ...' (message $0538); restores the
; party count from wScriptTemp4 and shows the field sprites again. (C2, E-0357; probed E-0376)
SceneDarckDefeated_ShowWarubouWaheyThatsIt::
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, $0538 ; 'Warubou: Wa-hey… That's it, then. There's'
    call StartMessageHL_B0F
    ld a, $01
    ld [wFieldEventArg], a
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    xor a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkObject0Down", ROMX

; Darck defeated scene, step 27: walks object 0 down to Y $40. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject0Down::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
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

SECTION "Bank 0F SceneDarckDefeated_WalkObject0Up", ROMX

; Darck defeated scene, step 26: walks object 0 up to Y $20. (C2, E-0357; probed E-0376)
SceneDarckDefeated_WalkObject0Up::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_HopPlayer", ROMX

; Darck defeated scene, step 24: makes the player hop, then moves on (ScriptStepDeltaThenNextStep).
; (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopPlayer::
    xor a
    ld [wFieldEventArg], a
    ld de, hPlayerY
    call ScriptStepDeltaThenNextStep
    ret

SECTION "Bank 0F SceneDarckDefeated_ShowWarubouWawaheyWeWere", ROMX

; Darck defeated scene, step 22: Warubou's 'Wawahey! We were ...' (message $0537). (C2, E-0357;
; probed E-0376)
SceneDarckDefeated_ShowWarubouWawaheyWeWere::
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0537 ; 'Warubou: Wa-wa-hey! We were too late!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_StartScrollShake", ROMX

; Darck defeated scene, step 19: starts field event $0C (the scroll shake) and falls into clearing
; the event argument. (C2, E-0357; probed E-0376)
SceneDarckDefeated_StartScrollShake::
    ld a, $0c
    ld [wFieldEventKind], a
    xor a
    ld [wFieldEventTimer], a

; Clears the field event argument and moves on. (C2, E-0357; probed E-0376)
SceneDarckDefeated_ClearEventArg::
    xor a
    ld [wFieldEventArg], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_ShowWarubouWaheyFeelThat", ROMX

; Darck defeated scene, step 16: Warubou's 'Wahey! Feel that ...' (message $0DF7). (C2, E-0357;
; probed E-0376)
SceneDarckDefeated_ShowWarubouWaheyFeelThat::
    xor a
    ld [wFieldEventArg], a
    ld hl, $0df7 ; 'Warubou: Wa-hey? Feel that, warooh? Did'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_ShakeScreen", ROMX

; Darck defeated scene, step 15: shakes the screen ($0F, ScriptStepShakeScreen). (C2, E-0357; probed
; E-0376)
SceneDarckDefeated_ShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

SECTION "Bank 0F SceneDarckDefeated_ResetScene", ROMX

; Darck defeated scene, step 13: puts object 1 at Y $30, hides the scene object and redraws the
; columns beside the screen. (C1, E-0357)
SceneDarckDefeated_ResetScene::
    ld a, $30
    ld [wObject1 + OBJ_Y], a
    xor a
    ld [wObject5], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_RunBossWinScene", ROMX

; Darck defeated scene, step 12: runs the scene's script sub-step (BossWinScene). (C1, E-0357)
SceneDarckDefeated_RunBossWinScene::
    farcall BossWinScene
    ret

SECTION "Bank 0F SceneDarckDefeated_ShowWarubouWaheyYouDid", ROMX

; Darck defeated scene, step 11: warps to map 5, screen (1, 0) at ($50, $30) with a fade and shows
; Warubou's 'Wahey! You did ...' (message $0533). (C1, E-0357)
SceneDarckDefeated_ShowWarubouWaheyYouDid::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    xor a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0533 ; 'Warubou: Wa-hey, you did it, 0!'
    call StartMessageHL_B0F
    xor a
    ld [wScriptSubStep], a
    ret

SECTION "Bank 0F SceneDarckDefeated_Msg055B_WaheyCanYouHear", ROMX

; Darck defeated scene, step 9: 'Wahey! Can you hear ...' (message $055B). (C2, E-0357; probed
; E-0376)
SceneDarckDefeated_Msg055B_WaheyCanYouHear::
    ld hl, $055b ; '*: Wa-hey! can you hear me,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_Msg055A_AVoiceEchoedFrom", ROMX

; Darck defeated scene, step 7: 'A voice echoed from ...' (message $055A). (C2, E-0357; probed
; E-0376)
SceneDarckDefeated_Msg055A_AVoiceEchoedFrom::
    ld hl, $055a ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_MoveSprite0Down", ROMX

; Darck defeated scene, step 6: adds 1 to the Y of the first sprite slot (wSpriteSlots + $C) and
; falls into SceneDarckDefeated_HopSprite, which adds the hop delta to the same byte; so the sprite
; hops while sinking one pixel a frame, 16 pixels over the 16-frame hop, and wScriptStep + 1 when
; the hop ends. (C2, E-0376)
; increments the Y byte of sprite slot 0 (wSpriteSlots + $C)
SceneDarckDefeated_MoveSprite0Down::
    ld hl, wSpriteSlots + $c
    inc [hl]

; Darck defeated scene, step 3: makes the first sprite hop once. (C2, E-0357; probed E-0376)
SceneDarckDefeated_HopSprite::
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_WalkPlayer", ROMX

; Darck defeated scene, step 2: walks the player left to X $40, then up to Y $20; then shows the
; first sprite at Y $10, puts tiles $54 $55 into the screen and redraws it. (C1, E-0357)
SceneDarckDefeated_WalkPlayer::
    ldh a, [hPlayerX]
    cp $40
    jr z, .set_step_ptr_lo_to_20
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ret

.set_step_ptr_lo_to_20:
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $10
    ld [wSpriteSlots + $c], a
    ld a, $54
    ld [wScreenTileBuffer + $30], a
    ld a, $55
    ld [wScreenTileBuffer + $31], a
    farcall DrawFullScreenBufferAtScroll
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_Wait", ROMX

; Darck defeated scene, step 1: waits $3C frames. (C2, E-0357; probed E-0376)
SceneDarckDefeated_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_BlinkOut", ROMX

; Darck defeated scene, step 0: blinks object 1 out (ScriptStepBlinkObjectTemp0); when done keeps
; one sprite, sets EVENT_SCENE_DARCK_DEFEATED and bit 0 of story byte $65. (C2, E-0357; probed
; E-0376)
SceneDarckDefeated_BlinkOut::
    ld a, $01
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call SetFlagBit
    ld a, [wStoryFlags + $65]
    set 0, a
    ld [wStoryFlags + $65], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_MoveSceneObjectAgain", ROMX

; Darck defeated scene, step 138: shows the scene object and runs one of two phases by
; wScriptParam1: moving along a path, then counting the passes. (C2, E-0357; probed E-0376)
SceneDarckDefeated_MoveSceneObjectAgain::
    xor a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and $0f
    jumptable
    dw SceneDarckDefeated_MovePathBackward
    dw SceneDarckDefeated_CountPathPasses

; Moves the scene object backwards along its path (SceneDarckDefeated_ObjectPath, the row chosen by
; wScriptParam1 bits 4-6), one point every other frame, shifted 16 pixels right; after $17 points
; the next phase. (C2, E-0357; probed E-0376)
SceneDarckDefeated_MovePathBackward::
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, .skip
    inc a
    ld [wScriptSubStep], a
    ret

.skip:
    srl a
    ld c, a
    ld a, $17
    sub c
    add a
    ld de, SceneDarckDefeated_ObjectPath
    add e
    ld e, a
    jr nc, .check_script_param1
    inc d

.check_script_param1:
    push de
    ld a, [wScriptParam1]
    and $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hli]
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, [hl]
    add $10
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptSubStep]
    inc a
    ld [wScriptSubStep], a
    srl a
    cp $17
    ret nz
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptParam1
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_CountPathPasses", ROMX

; Counts the path passes: hides the scene object and moves to the next row; after the eighth the
; scene goes on. (C2, E-0357; probed E-0376)
SceneDarckDefeated_CountPathPasses::
    xor a
    ld [wObject5], a
    ld a, [wScriptParam1]
    add $10
    and $f0
    cp $80
    jr nz, .set_script_param1
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    xor a

.set_script_param1:
    ld [wScriptParam1], a
    ret

SECTION "Bank 0F SceneDarckDefeated_MoveSceneObject", ROMX

; Darck defeated scene, step 40: shows the scene object and runs one of two phases by wScriptParam1:
; moving along a path, then counting the passes. (C2, E-0357; probed E-0376)
SceneDarckDefeated_MoveSceneObject::
    xor a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and $0f
    jumptable
    dw SceneDarckDefeated_MovePathForward
    dw SceneDarckDefeated_CountPathPasses2

; Moves the scene object forwards along its path (the row chosen by wScriptParam1 bits 4-6), one
; point every other frame; after $17 points the next phase. (C2, E-0357; probed E-0376)
SceneDarckDefeated_MovePathForward::
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, .skip
    inc a
    ld [wScriptSubStep], a
    ret

.skip:
    and $fe
    ld de, SceneDarckDefeated_ObjectPath
    add e
    ld e, a
    jr nc, .check_script_param1
    inc d

.check_script_param1:
    push de
    ld a, [wScriptParam1]
    and $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hli]
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, [hl]
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptSubStep]
    inc a
    ld [wScriptSubStep], a
    srl a
    cp $17
    ret nz
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptParam1
    inc [hl]
    ret

SECTION "Bank 0F SceneDarckDefeated_CountPathPasses2", ROMX

; Counts the path passes: after the eighth row the scene goes on. (C2, E-0357; probed E-0376)
SceneDarckDefeated_CountPathPasses2::
    ld a, [wScriptParam1]
    add $10
    and $f0
    cp $80
    jr nz, .set_script_param1
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    xor a

.set_script_param1:
    ld [wScriptParam1], a
    ret

SECTION "Bank 0F SceneDarckDefeated_ObjectPath", ROMX

; SceneDarckDefeated_MovePathForward reads, every other frame, the pair at $5284 + $30 *
; ((wScriptParam1 & $70) >> 4) + 2 * step into wObject5 + 5 and + 4, for 23 steps per path; 8 paths
; end at SceneThreeItems (E-0206, C1)
; record: 24 steps of two bytes (wObject5 + 5, wObject5 + 4), 12 per line
SceneDarckDefeated_ObjectPath::
    db $fe, $06, $00, $09, $02, $0c, $04, $0f, $06, $12, $08, $15, $0a, $18, $0c, $1b, $0e, $1e, $10, $21, $12, $23, $14, $26 ; id 0
    db $16, $28, $18, $2b, $1a, $2d, $1c, $30, $1e, $32, $20, $34, $22, $36, $24, $38, $26, $3a, $28, $3c, $2a, $3e, $2c, $40
    db $fe, $63, $00, $61, $02, $5f, $04, $5d, $06, $5b, $08, $59, $0a, $57, $0c, $55, $0e, $53, $10, $52, $12, $50, $14, $4f ; id 1
    db $16, $4d, $18, $4b, $1a, $4a, $1c, $48, $1e, $47, $20, $46, $22, $45, $24, $44, $26, $43, $28, $42, $2a, $41, $2c, $40
    db $fe, $1d, $00, $1f, $02, $21, $04, $23, $06, $25, $08, $27, $0a, $29, $0c, $2b, $0e, $2d, $10, $2f, $12, $30, $14, $32 ; id 2
    db $16, $33, $18, $35, $1a, $36, $1c, $38, $1e, $39, $20, $3a, $22, $3b, $24, $3c, $26, $3d, $28, $3e, $2a, $3f, $2c, $40
    db $fe, $76, $00, $74, $02, $71, $04, $6e, $06, $6c, $08, $69, $0a, $67, $0c, $64, $0e, $62, $10, $5f, $12, $5d, $14, $5a ; id 3
    db $16, $58, $18, $55, $1a, $53, $1c, $50, $1e, $4e, $20, $4c, $22, $4a, $24, $48, $26, $46, $28, $44, $2a, $42, $2c, $40
    db $0c, $fc, $0c, $ff, $0c, $03, $0d, $07, $0d, $0b, $0e, $0f, $0f, $13, $10, $17, $11, $1c, $13, $20, $14, $23, $16, $26 ; id 4
    db $17, $28, $19, $2b, $1a, $2d, $1c, $30, $1e, $32, $20, $34, $22, $36, $24, $38, $26, $3a, $28, $3c, $2a, $3e, $2c, $40
    db $fe, $63, $00, $61, $02, $5f, $04, $5d, $06, $5b, $08, $59, $0a, $57, $0c, $55, $0e, $53, $10, $52, $12, $50, $14, $4f ; id 5
    db $16, $4d, $18, $4b, $1a, $4a, $1c, $48, $1e, $47, $20, $46, $22, $45, $24, $44, $26, $43, $28, $42, $2a, $41, $2c, $40
    db $0c, $89, $0c, $85, $0c, $81, $0d, $7d, $0d, $79, $0e, $75, $0f, $71, $10, $6d, $11, $69, $13, $65, $14, $61, $16, $5e ; id 6
    db $17, $5a, $19, $57, $1a, $54, $1c, $51, $1e, $4e, $20, $4c, $22, $4a, $24, $48, $26, $46, $28, $44, $2a, $42, $2c, $40
    db $fe, $76, $00, $74, $02, $71, $04, $6e, $06, $6c, $08, $69, $0a, $67, $0c, $64, $0e, $62, $10, $5f, $12, $5d, $14, $5a ; id 7
    db $16, $58, $18, $55, $1a, $53, $1c, $50, $1e, $4e, $20, $4c, $22, $4a, $24, $48, $26, $46, $28, $44, $2a, $42, $2c, $40

; Three items scene, run each frame by ScriptCommand58 (script command type $58,
; SCRIPT_SCENE_THREE_ITEMS): jumps on wScriptStep through 44 steps. Steps 0-19: the BG columns are
; redrawn and the screen shakes, Kameha and Darck talk, step 12 takes the answer to the question of
; Darck (SceneThreeItems_ShowDarckIImagineThat) and step 16 is 'received the Limbo Key'; steps
; 20-29: the palettes are saved, a negative flash, story flags and an in-place transition, then
; Kameha and the voice of Warubou; steps 30-43: the warp to map 5, the party heal (step 34), a
; second shake, the last messages, and step 43 (SceneThreeItems_GiveKeys) marks the keys and resumes
; the script. Each message step is followed by SceneHomecoming_WaitMessage, which waits for the box
; to close. (C1, E-0376)
; implements script command type 58 (SCRIPT_SCENE_THREE_ITEMS): a cutscene step named after the
; scene its only script shows: 'Kameha If the three items that...'; reached through ScriptCommand58
; in bank $10 (E-0038, E-0245)
SceneThreeItems::
    ld a, [wScriptStep]
    jumptable
    dw SceneThreeItems_RedrawSideColumns
    dw SceneThreeItems_ShakeScreen
    dw SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_PlayMusic
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Msg0485_GreetingsIAmDarck
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Object0HopThenKamehaWhatWhy
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Msg0487_DarckWellForMe
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_ShowDarckIImagineThat
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_DropObject
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Msg048D_HeroReceivedTheLimbo
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Msg048E_DarckIWillBe
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_SavePalettes
    dw SceneThreeItems_LimitSpritesAndFlash
    dw SceneThreeItems_SetFlags
    dw SceneThreeItems_TurnObject0
    dw SceneThreeItems_Object2HopThenKamehaOurTreasures
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Msg0490_AVoiceEchoedFrom
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_Msg0491_WaheyCanYouHear
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_ShowWarubouWaheyHeroAnd
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_PlaySound
    dw SceneThreeItems_FlashScreenNegative
    dw SceneThreeItems_ShowWarubouThereAllHealed
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_RedrawSideColumns
    dw SceneThreeItems_ShakeScreen
    dw SceneThreeItems_Msg0A7C_KamehaIIHave
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_ShowWarubouWaheyThereIs
    dw SceneHomecoming_WaitMessage
    dw SceneThreeItems_PlayerHopThenWarubouWeDontHave
    dw SceneThreeItems_GiveKeys

; Three items scene, step 43: after the message box closes, marks the key of kind 5, sets bit 4 of
; story byte $60, gives a key of kind 6 (WriteKeyEntryTemp0) and resumes the script. (C1, E-0357)
SceneThreeItems_GiveKeys::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $05
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 4, a
    ld [wStoryFlags + $60], a
    farcall CountKeysOrFull
    ld a, $06
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneThreeItems_PlayerHopThenWarubouWeDontHave", ROMX

; Three items scene, step 42: the player hops (ScriptStepDeltaThenMessage on hPlayerY), then message
; $0A7E, Warubou's 'Wa-hey, we don't have the time to be in shock'. (C2, E-0369; probed E-0376)
SceneThreeItems_PlayerHopThenWarubouWeDontHave::
    ld de, hPlayerY
    ld hl, $0a7e
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneThreeItems_ShowWarubouWaheyThereIs", ROMX

; Three items scene, step 40: walks object 1 right (two pixels a frame) to X $B0; then sets
; EVENT_SCENE_THREE_ITEMS_0C3, plays the map music and shows Warubou's 'Wahey! There is ...'
; (message $0A7D). (C1, E-0357)
SceneThreeItems_ShowWarubouWaheyThereIs::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $b0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld de, EVENT_SCENE_THREE_ITEMS_0C3
    call SetFlagBit
    farcall PlayMapMusic
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, $0a7d ; 'Warubou: Wa-hey, there is little time'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Msg0A7C_KamehaIIHave", ROMX

; Three items scene, step 38: Kameha's 'I... I have ...' (message $0A7C). (C2, E-0357; probed
; E-0376)
SceneThreeItems_Msg0A7C_KamehaIIHave::
    ld hl, $0a7c ; 'Kameha: I… I have to go'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_ShowWarubouThereAllHealed", ROMX

; Three items scene, step 34: fully heals the party, moves fallen members to the back, reloads the
; names and sprites and shows Warubou's 'There! All healed' (message $0A7B). (C1, E-0357)
SceneThreeItems_ShowWarubouThereAllHealed::
    farcall FullyHealParty
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, $0a7b ; 'Warubou: There! All healed now! There'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_ShowWarubouWaheyHeroAnd", ROMX

; Three items scene, step 30: warps to map 5, screen (1, 0) at ($50, $30), sets
; EVENT_SCENE_THREE_ITEMS and shows Warubou's 'Wahey! Hero and ...' (message $0A7A). (C1, E-0357)
SceneThreeItems_ShowWarubouWaheyHeroAnd::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld de, EVENT_SCENE_THREE_ITEMS
    call SetFlagBit
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0a7a ; 'Warubou: Wa-hey! 0 and Kameha! I'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneThreeItems_Msg0491_WaheyCanYouHear", ROMX

; Three items scene, step 28: 'Wahey! Can you hear ...' (message $0491). (C2, E-0357; probed E-0376)
SceneThreeItems_Msg0491_WaheyCanYouHear::
    ld hl, $0491 ; '*: Wa-hey! Can you hear me,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Msg0490_AVoiceEchoedFrom", ROMX

; Three items scene, step 26: 'A voice echoed from ...' (message $0490). (C2, E-0357; probed E-0376)
SceneThreeItems_Msg0490_AVoiceEchoedFrom::
    ld hl, $0490 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Object2HopThenKamehaOurTreasures", ROMX

; Three items scene, step 24: object 2 hops (ScriptStepDeltaThenMessage on wObject2 + OBJ_Y), then
; message $048F, Kameha's 'Our treasures!'. (C2, E-0369; probed E-0376)
SceneThreeItems_Object2HopThenKamehaOurTreasures::
    ld de, wObject2 + OBJ_Y
    ld hl, $048f
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneThreeItems_TurnObject0", ROMX

; Three items scene, step 23: object 0 faces right and left in turn every 64 frames for $B4 frames,
; then faces down. (C2, E-0357; probed E-0376)
SceneThreeItems_TurnObject0::
    ld a, [wScriptParam0]
    swap a
    srl a
    srl a
    and $01
    add a
    inc a
    ld [wSpriteSlots + $7], a
    ld b, $b4
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_SetFlags", ROMX

; Three items scene, step 22: sets bit 3 of story byte $64 and EVENT_SCENE_THREE_ITEMS_0C2, and
; starts a transition in place (fade 1, transition kind 3). (C1, E-0357)
SceneThreeItems_SetFlags::
    ld a, [wStoryFlags + $64]
    set 3, a
    ld [wStoryFlags + $64], a
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $01
    call StartPaletteFade
    ld a, $03
    ld [wFieldTransitionKind], a
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_LimitSpritesAndFlash", ROMX

; Three items scene, step 21: draws one sprite slot only, then falls into the negative screen flash
; below. (C2, E-0357; probed E-0376)
SceneThreeItems_LimitSpritesAndFlash::
    ld a, $01
    ld [wSpriteSlotCount], a

; Three items scene, step 33, also reached from step 21 (SceneThreeItems_LimitSpritesAndFlash): runs
; the negative screen flash (ScriptStepFlashScreenNegative). (C2, E-0369; probed E-0376)
SceneThreeItems_FlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

SECTION "Bank 0F SceneThreeItems_PlaySound", ROMX

; Three items scene, step 32: plays sound $7A, then falls into saving the palettes below. (C2,
; E-0357; probed E-0376)
SceneThreeItems_PlaySound::
    ld a, $7a
    call QueueSoundEffect

; Three items scene, step 20: on the GBC saves the 64-byte background palette buffer in
; wBGPaletteCopy (for the flash to restore), then moves on. (C2, E-0357; probed E-0376)
SceneThreeItems_SavePalettes::
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

SECTION "Bank 0F SceneThreeItems_Msg048E_DarckIWillBe", ROMX

; Three items scene, step 18: Darck's 'I will be readying a ...' (message $048E). (C2, E-0357;
; probed E-0376)
SceneThreeItems_Msg048E_DarckIWillBe::
    ld hl, $048e ; 'Darck: I will be readying a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Msg048D_HeroReceivedTheLimbo", ROMX

; Three items scene, step 16: '<hero> received the Limbo Key.' (message $048D). (C2, E-0357; probed
; E-0376)
SceneThreeItems_Msg048D_HeroReceivedTheLimbo::
    ld hl, $048d ; '0 received the Limbo Key.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_DropObject", ROMX

; Three items scene, step 14: the scene object flashes (every 4 frames) while falling one pixel a
; frame to the player's Y; then it is hidden and Darck says 'That key will bring you ...' (message
; $048C). (C2, E-0357; probed E-0376)
SceneThreeItems_DropObject::
    ld a, [wFrameCounterLo]
    bit 2, a
    jr z, .set_object5_to_80
    xor a
    ld [wObject5], a
    jr .read_player_y

.set_object5_to_80:
    ld a, $80
    ld [wObject5], a

.read_player_y:
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    cp c
    ret nz
    xor a
    ld [wObject5], a
    ld hl, $048c ; 'Darck: That key will bring you'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_ShowDarckIImagineThat", ROMX

; Three items scene, step 12: the answer: any choice but the first shows message $048A in the open
; box (kept open) and asks again; the first shows message $048B, runs field command 4 and puts the
; scene object above the screen at the player's X. (C1, E-0357)
SceneThreeItems_ShowDarckIImagineThat::
    ld a, [wTextYesNoResult]
    or a
    jr z, .call_start_message_hl_b0_f
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $048a ; 'Darck: I imagine that you don't'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    dec [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, MSG_ALREADY_OPEN | $048b ; 'Darck: Good! We have a deal!'
    call StartMessageHL_B0F
    ld a, $04
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $e0
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Msg0487_DarckWellForMe", ROMX

; Three items scene, step 10: Darck's 'Well, for me, anything that ...' (message $0487, the box kept
; open). (C2, E-0357; probed E-0376)
SceneThreeItems_Msg0487_DarckWellForMe::
    ld hl, MSG_KEEP_OPEN | $0487 ; 'Darck: Well, for me, anything that'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Object0HopThenKamehaWhatWhy", ROMX

; Three items scene, step 8: object 0 hops (ScriptStepDeltaThenMessage on wSpriteSlots + $C), then
; message $0486, Kameha's 'What? Why do you do that?'. (C2, E-0369; probed E-0376)
SceneThreeItems_Object0HopThenKamehaWhatWhy::
    ld de, wSpriteSlots + $c
    ld hl, $0486
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneThreeItems_Msg0485_GreetingsIAmDarck", ROMX

; Three items scene, step 6: 'Greetings! I am Darck, the ...' (message $0485). (C2, E-0357; probed
; E-0376)
SceneThreeItems_Msg0485_GreetingsIAmDarck::
    ld hl, $0485 ; '*: Greetings! I am Darck, the'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_PlayMusic", ROMX

; Three items scene, step 4: starts music $1F on the first frame, puts object 3 at Y $18 and
; flickers object 1 (Y $10 shown, $C0 hidden; every 2 frames, then 4 from frame $1E, 8 from $3C) for
; $78 frames; then object 0 faces up and Kameha says 'Who are you to disturb ...' (message $0484).
; (C2, E-0357; probed E-0376)
SceneThreeItems_PlayMusic::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_object3_to_18
    ld a, $1f
    call QueueMusic

.set_object3_to_18:
    ld a, $18
    ld [wObject3 + OBJ_Y], a
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_object1_to_10
    jr .set_object1_to_C0

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_object1_to_10
    jr .set_object1_to_C0

.check_bit3:
    bit 3, a
    jr z, .set_object1_to_10
    jr .set_object1_to_C0

.set_object1_to_10:
    ld a, $10
    ld [wObject1 + OBJ_Y], a
    jr .call_step_script_param0_counter_bank0_f

.set_object1_to_C0:
    ld a, $c0
    ld [wObject1 + OBJ_Y], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld hl, $0484 ; 'Kameha: Who are you to disturb'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat", ROMX

; Three items scene, step 2: Kameha's 'Wha-wha whaaaat? ...' (message $0483). (C2, E-0357; probed
; E-0376)
SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat::
    ld hl, $0483 ; 'Kameha: Wha-wha whaaaat? What just happened'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneThreeItems_ShakeScreen", ROMX

; Three items scene, steps 1 and 37: shakes the screen for $78 frames (ScriptStepShakeScreen), then
; moves on. (C2, E-0369; probed E-0376)
SceneThreeItems_ShakeScreen::
    ld b, $78
    call ScriptStepShakeScreen
    ret

SECTION "Bank 0F SceneThreeItems_RedrawSideColumns", ROMX

; Three items scene, steps 0 and 36: redraws the BG map columns just off the screen's left and right
; edges (RedrawColumnsBesideScreen) and moves on. (C1, E-0369)
SceneThreeItems_RedrawSideColumns::
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneGrave", ROMX

; Grave scene, run each frame by ScriptCommand4E (script command type $4E, SCRIPT_SCENE_GRAVE):
; jumps on wScriptStep through 5 steps: 0 object 1 flickers and the voice speaks by story progress
; (SceneGrave_Flicker, which goes on to step 1 for a question or jumps to step 3), 1 waits for the
; box, 2 takes the answer (SceneGrave_ShowAhYoullDoIt), 3 waits for the box, 4 blinks object 1 out
; and resumes the script. (C1, E-0376)
; implements script command type 4E (SCRIPT_SCENE_GRAVE): a cutscene step named after the scene its
; only script shows: '0 checked the grave.' ... 'Fine! You've done well...'; reached through
; ScriptCommand4E in bank $10 (E-0038, E-0245)
SceneGrave::
    ld a, [wScriptStep]
    jumptable
    dw SceneGrave_Flicker
    dw SceneHomecoming_WaitMessage
    dw SceneGrave_ShowAhYoullDoIt
    dw SceneHomecoming_WaitMessage
    dw SceneGrave_BlinkOut

; Grave scene, step 4: blinks object 1 (at Y $40) out; when done resumes the script. (C2, E-0357;
; probed E-0376)
SceneGrave_BlinkOut::
    ld a, $40
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneGrave_ShowAhYoullDoIt", ROMX

; Grave scene, step 2: the answer: the first choice shows message $0416 'Ah, you'll do it?
; Excellent!' in the open box and sets EVENT_SCENE_GRAVE_0A6; another choice shows message $0417 and
; sets EVENT_SCENE_GRAVE_0A5. (C2, E-0357; probed E-0376)
SceneGrave_ShowAhYoullDoIt::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, MSG_ALREADY_OPEN | $0416 ; '*: Ah, you'll do it? Excellent!'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_GRAVE_0A6
    call SetFlagBit
    ret

.call_start_message_hl_b0_f:
    ld hl, MSG_ALREADY_OPEN | $0417 ; '*: I had thought that you'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_GRAVE_0A5
    call SetFlagBit
    ret

SECTION "Bank 0F SceneGrave_Flicker", ROMX

; Grave scene, step 0: object 1 at Y $40 flickers in and out (2 or 1 sprite slots drawn, slowing)
; for $78 frames; then the voice speaks by story progress: $0493 after EVENT_SCENE_THREE_ITEMS_0C2,
; $0452 'The Change Staff will open' after EVENT_HERO_CHECKED_BEHIND_THE, $0416 once agreed (0A6),
; the question again ($0419) after a refusal (0A5); after EVENT_SCENE_MADCONDOR the question ($0418,
; or $0415 before EVENT_SCENE_GRAVE); otherwise $040D or $040C. Questions go on to step 1, the rest
; end at step 3. (C2, E-0357; probed E-0376)
SceneGrave_Flicker::
    ld a, $40
    ld [wObject1 + OBJ_Y], a
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_sprite_slot_count_to_02
    jr .set_sprite_slot_count_to_01

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_sprite_slot_count_to_02
    jr .set_sprite_slot_count_to_01

.check_bit3:
    bit 3, a
    jr z, .set_sprite_slot_count_to_02
    jr .set_sprite_slot_count_to_01

.set_sprite_slot_count_to_02:
    ld a, $02
    ld [wSpriteSlotCount], a
    jr .call_step_script_param0_counter_bank0_f

.set_sprite_slot_count_to_01:
    ld a, $01
    ld [wSpriteSlotCount], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlotCount], a
    xor a
    ld [wScriptParam0], a
    ld de, EVENT_SCENE_THREE_ITEMS_0C2
    call TestFlagBit
    jp c, .call_start_message_hl_b0_f6
    ld de, EVENT_HERO_CHECKED_BEHIND_THE
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f5
    ld de, EVENT_SCENE_GRAVE_0A6
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f4
    ld de, EVENT_SCENE_GRAVE_0A5
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f3
    ld de, EVENT_SCENE_MADCONDOR
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, EVENT_SCENE_GRAVE
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $040c ; '*: Who disturbs my sleep? A'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

.call_start_message_hl_b0_f:
    ld hl, $040d ; '*: What? You again? You seem'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

.call_test_flag_bit:
    ld de, EVENT_SCENE_GRAVE
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f2
    ld hl, MSG_KEEP_OPEN | $0415 ; '*: Who disturbs my sleep? A'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f2:
    ld hl, MSG_KEEP_OPEN | $0418 ; '*: Who disturbs my sleep? Oh,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f3:
    ld hl, MSG_KEEP_OPEN | $0419 ; '*: Well? Will you go look'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f4:
    ld hl, $0416 ; '*: Ah, you'll do it? Excellent!'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

.call_start_message_hl_b0_f5:
    ld hl, $0452 ; '*: The Change Staff will open'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

.call_start_message_hl_b0_f6:
    ld hl, $0493 ; '*: Who disturbs my sleep? The'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneShield2", ROMX

; Shield scene 2, run each frame by ScriptCommand4B (script command type $4B,
; SCRIPT_SCENE_SHIELD_2): jumps on wScriptStep through 23 steps: the scene object rises from the
; player and message $0DCA (0-4), waits and fades with warps to maps $48 and $49 (5-10), object 2
; flickers, message $0A07, then object 0 sinks and the hero receives the Sky Shield (11-13), the
; voice of Warubou and the warp to map 5 (14-17), the shared boss-win sequence (18), the scene
; object falls onto the player (19-21), and SceneShield2_GiveKey resumes the script (22). (C1,
; E-0376)
; implements script command type 4B (SCRIPT_SCENE_SHIELD_2): a cutscene step named after the scene
; its only script shows: after '0 checked the shield.'; reached through ScriptCommand4B in bank $10
; (E-0038, E-0245)
SceneShield2::
    ld a, [wScriptStep]
    jumptable
    dw SceneShield2_ShowObject
    dw SceneShield2_RaiseObject
    dw SceneShield2_Wait
    dw SceneShield2_ShowLetMeShowYou
    dw SceneHomecoming_WaitMessage
    dw SceneShield2_Wait
    dw SceneShield2_WarpIn
    dw SceneShield2_Wait
    dw SceneShield2_Fade
    dw SceneShield2_Wait
    dw SceneShield2_Warp
    dw SceneShield2_Flicker
    dw SceneHomecoming_WaitMessage
    dw SceneShield2_ShowHeroReceivedTheSky
    dw SceneShield2_ShowAVoiceEchoedFrom
    dw SceneShield2_ShowWaheyHeroCanYou
    dw SceneHomecoming_WaitMessage
    dw SceneShield2_ShowWarubouWaheyYouDid
    dw SceneShield2_PlayBossWin
    dw SceneShield2_ShowObject2
    dw SceneShield2_ShowWarubouWaheyYouCan
    dw SceneHomecoming_WaitMessage
    dw SceneShield2_GiveKey

; Shield scene 2, step 22: sets EVENT_SCENE_SHIELD2_023, marks the key of kind 4
; (MarkKeyEntryKindTemp0Bit6), sets bit 3 of story byte $60 and resumes the script. (C2, E-0357;
; probed E-0376)
SceneShield2_GiveKey::
    ld de, EVENT_SCENE_SHIELD2_023
    call SetFlagBit
    ld a, $04
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 3, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneShield2_ShowWarubouWaheyYouCan", ROMX

; Shield scene 2, step 20: the scene object falls one pixel a frame to the player's Y and is hidden;
; then Warubou's 'Wa-hey, you can now fly ...' (message $0DCB) and EVENT_SCENE_SHIELD2. (C2, E-0357;
; probed E-0376)
SceneShield2_ShowWarubouWaheyYouCan::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    cp c
    ret nz
    xor a
    ld [wObject5], a
    ld hl, $0dcb ; 'Warubou: Wa-hey, you can now fly'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_SHIELD2
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_ShowObject2", ROMX

; Shield scene 2, step 19: object 0 faces away from the player (facing + 2), runs field command $11,
; shows the scene object 32 pixels above the player and plays sound $85. (C1, E-0357)
SceneShield2_ShowObject2::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + SCRIPTOBJ_X], a
    ldh a, [hPlayerY]
    sub $20
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_PlayBossWin", ROMX

; Shield scene 2, step 18: plays the shared boss-win sequence (BossWinScene, run by wScriptSubStep:
; sprites, flash, party heal, hops and shakes); its last sub-step advances wScriptStep. (C1, E-0370)
SceneShield2_PlayBossWin::
    farcall BossWinScene
    ret

SECTION "Bank 0F SceneShield2_ShowWarubouWaheyYouDid", ROMX

; Shield scene 2, step 17: warps to map 5, screen (1, 0) at ($50, $30) (transition kind 1) with a
; fade; Warubou's 'Wa-hey! You did it, <hero>!' (message $02A7); clears the sub-step and bit 2 of
; hPlayerStateFlags. (C1, E-0357)
SceneShield2_ShowWarubouWaheyYouDid::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $02a7 ; 'Warubou: Wa-hey! You did it, 0!'
    call StartMessageHL_B0F
    xor a
    ld [wScriptSubStep], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ret

SECTION "Bank 0F SceneShield2_ShowWaheyHeroCanYou", ROMX

; Shield scene 2, step 15: after the box closes, '...Wa-hey! <hero>, can you hear ...' (message
; $0A0A). (C1, E-0357)
SceneShield2_ShowWaheyHeroCanYou::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0a0a ; '*: …Wa-hey! 0, can you hear'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_ShowAVoiceEchoedFrom", ROMX

; Shield scene 2, step 14: after the box closes, 'A voice echoed from nowhere...' (message $0A09).
; (C1, E-0357)
SceneShield2_ShowAVoiceEchoedFrom::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0a09 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_ShowHeroReceivedTheSky", ROMX

; Shield scene 2, step 13: object 0 sinks with a hop; then it is hidden, '<hero> received the Sky
; Shield.' (message $0A08) and EVENT_SCENE_SHIELD2_1E5. (C2, E-0357; probed E-0376)
SceneShield2_ShowHeroReceivedTheSky::
    ld hl, wSpriteSlots + $c
    inc [hl]
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld hl, $0a08 ; '0 received the Sky Shield.'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_SHIELD2_1E5
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_Flicker", ROMX

; Shield scene 2, step 11: puts object 2 at Y $18 and flickers it (3 or 2 sprite slots drawn,
; slowing) for $78 frames; then 'The Kingdoms should return to ...' (message $0A07). (C2, E-0357;
; probed E-0376)
SceneShield2_Flicker::
    ld a, $18
    ld [wObject2 + OBJ_Y], a
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_sprite_slot_count_to_03
    jr .set_sprite_slot_count_to_02

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_sprite_slot_count_to_03
    jr .set_sprite_slot_count_to_02

.check_bit3:
    bit 3, a
    jr z, .set_sprite_slot_count_to_03
    jr .set_sprite_slot_count_to_02

.set_sprite_slot_count_to_03:
    ld a, $03
    ld [wSpriteSlotCount], a
    jr .call_step_script_param0_counter_bank0_f

.set_sprite_slot_count_to_02:
    ld a, $02
    ld [wSpriteSlotCount], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $0a07 ; '*: The Kingdoms should return to'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_Warp", ROMX

; Shield scene 2, step 10: moves to map $49, screen (0, 0), warp Y $40, with a fade. (C1, E-0357)
SceneShield2_Warp::
    ld a, $49
    ldh [hMapId], a
    ld a, $00
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestY], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneShield2_Fade", ROMX

; Shield scene 2, step 8: sets bit 1 of story byte $63 and fades. (C1, E-0357)
SceneShield2_Fade::
    ld a, [wStoryFlags + $63]
    set 1, a
    ld [wStoryFlags + $63], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneShield2_WarpIn", ROMX

; Shield scene 2, step 6: moves to map $48, screen (7, 5), the player entering from the top at the
; same X (transition kind 3), with a fade. (C1, E-0357)
SceneShield2_WarpIn::
    ld a, $48
    ldh [hMapId], a
    ld a, $07
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $e0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneShield2_ShowLetMeShowYou", ROMX

; Shield scene 2, step 3: the scene object rises one pixel a frame with a hop; then it is hidden and
; 'Let me show you my ...' (message $0DCA). (C2, E-0357; probed E-0376)
SceneShield2_ShowLetMeShowYou::
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wObject5], a
    ld hl, $0dca ; '*: Let me show you my'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_Wait", ROMX

; Shield scene 2, steps 2, 5, 7 and 9: waits $3C frames (StepScriptParam0Counter_Bank0F on
; wScriptParam0), then the next step. (C2, E-0376)
SceneShield2_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_RaiseObject", ROMX

; Shield scene 2, step 1: the scene object rises one pixel a frame with a hop. (C2, E-0357; probed
; E-0376)
SceneShield2_RaiseObject::
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield2_ShowObject", ROMX

; Shield scene 2, step 0: runs field command $10 and shows the scene object on the player. (C1,
; E-0357)
SceneShield2_ShowObject::
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + SCRIPTOBJ_X], a
    ldh a, [hPlayerY]
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield", ROMX

; Shield scene, run each frame by ScriptCommand4A (script command type $4A, SCRIPT_SCENE_SHIELD):
; jumps on wScriptStep through 12 steps: 0 tells the first visit from a repeat (EVENT_SCENE_SHIELD;
; a repeat jumps to the battle at step 5), 1 a negative screen flash, 2 object 1 flickers and a
; question, 4 the answer (a refusal ends at step $0B), 5 scripted battle $19, 6-10 the messages
; after the battle with object 1 blinking out and EVENT_SCENE_SHIELD_1E4, and 11
; (PersonalityMessage_WaitForMessage) waits for the box and resumes the script. (C1, E-0376)
; implements script command type 4A (SCRIPT_SCENE_SHIELD): a cutscene step named after the scene its
; only script shows: after '0 checked the shield.' (starts a scripted encounter); reached through
; ScriptCommand4A in bank $10 (E-0038, E-0245)
SceneShield::
    ld a, [wScriptStep]
    jumptable
    dw SceneShield_ShowTchObstinateAndFoolish
    dw SceneShield_FlashScreen
    dw SceneShield_Flicker
    dw SceneHomecoming_WaitMessage
    dw SceneShield_ShowImpetuousFoolIllShow
    dw SceneShield_StartBattle
    dw SceneShield_ShowWhaNoMyMonsters
    dw SceneHomecoming_WaitMessage
    dw SceneShield_ShowABeautifulVoiceEchoed
    dw SceneHomecoming_WaitMessage
    dw SceneShield_ShowIBoreWitnessTo
    dw PersonalityMessage_WaitForMessage

; Shield scene, step 10: 'I bore witness to it ...' (message $0A05) and EVENT_SCENE_SHIELD_1E4. (C2,
; E-0357; probed E-0376)
SceneShield_ShowIBoreWitnessTo::
    ld hl, $0a05 ; '*: I bore witness to it'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_SHIELD_1E4
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield_ShowABeautifulVoiceEchoed", ROMX

; Shield scene, step 8: blinks object 1 (at the Y saved in step 6) out; then 'A beautiful voice
; echoed...' (message $0DDF). (C2, E-0357; probed E-0376)
SceneShield_ShowABeautifulVoiceEchoed::
    ld a, [wScriptParam1]
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld hl, $0ddf ; 'A beautiful voice echoed…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield_ShowWhaNoMyMonsters", ROMX

; Shield scene, step 6: 'Wha... No! My monsters! It ...' (message $0A04); saves object 1's Y in
; wScriptParam1. (C2, E-0357; probed E-0376)
SceneShield_ShowWhaNoMyMonsters::
    ld hl, $0a04 ; '*: Wha… No! My monsters! It'
    call StartMessageHL_B0F
    ld a, [wObject1 + OBJ_Y]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield_StartBattle", ROMX

; Shield scene, step 5: after the box closes, starts scripted battle $19. (C1, E-0357)
SceneShield_StartBattle::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $19
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield_ShowImpetuousFoolIllShow", ROMX

; Shield scene, step 4: the answer: the first choice shows message $0DD0 in the open box and goes on
; to the battle; another shows $0DD1 and ends at step $0B. (C2, E-0357; probed E-0376)
SceneShield_ShowImpetuousFoolIllShow::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, MSG_ALREADY_OPEN | $0dd0 ; '*: Impetuous fool! I'll show you!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, MSG_ALREADY_OPEN | $0dd1 ; '*: Hm, fine, I'll ignore it.'
    call StartMessageHL_B0F
    ld a, $0b
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneShield_Flicker", ROMX

; Shield scene, step 2: object 1 flickers (Y $20 shown, $E0 hidden, slowing) for $78 frames; then
; 'So it was you holding ...' (message $0A02, kept open for the question). (C2, E-0357; probed
; E-0376)
SceneShield_Flicker::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.check_bit3:
    bit 3, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.set_object1_to_20:
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    jr .call_step_script_param0_counter_bank0_f

.set_object1_to_E0:
    ld a, $e0
    ld [wObject1 + OBJ_Y], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    ld hl, MSG_KEEP_OPEN | $0a02 ; '*: So it was you holding'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShield_FlashScreen", ROMX

; Shield scene, step 1: runs the negative screen flash. (C2, E-0357; probed E-0376)
SceneShield_FlashScreen::
    farcall ScriptStepFlashScreenNegative
    ret

SECTION "Bank 0F SceneShield_ShowTchObstinateAndFoolish", ROMX

; Shield scene, step 0: after a refusal (EVENT_SCENE_SHIELD set) 'Tch, obstinate and foolish ...'
; (message $0A03) and straight to the battle (step 5); the first time saves the GBC background
; palettes, sets EVENT_SCENE_SHIELD and moves on. (C2, E-0357; probed E-0376)
SceneShield_ShowTchObstinateAndFoolish::
    ld de, EVENT_SCENE_SHIELD
    call TestFlagBit
    jr nc, .check_is_cgb
    ld hl, $0a03 ; '*: Tch, obstinate and foolish. You'
    call StartMessageHL_B0F
    ld a, $01
    ld [wScriptParam1], a
    ld a, $05
    ld [wScriptStep], a
    ret

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .call_set_flag_bit
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_set_flag_bit:
    ld de, EVENT_SCENE_SHIELD
    call SetFlagBit
    xor a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian", ROMX

; Shield guardian scene, run each frame by ScriptCommand66 (script command type $66,
; SCRIPT_SCENE_SHIELD_GUARDIAN): jumps on wScriptStep through 16 steps: 0 on the first visit removes
; item $34 (ITEM_SLEEPHERB) and sets EVENT_SCENE_SHIELD_GUARDIAN, a repeat jumps to the battle at
; step 5; 2 object 2 flickers and a question; 4 the answer (a refusal ends at step $0F); 5 scripted
; battle 4; 6-14 the messages after the battle, with object 2 blinking out, object 0 becoming sprite
; $0F and EVENT_SCENE_SHIELD_GUARDIAN_1E2; 15 waits for the box and resumes the script. (C1, E-0376)
; implements script command type 66 (SCRIPT_SCENE_SHIELD_GUARDIAN): a cutscene step named after the
; scene its only script shows: before '0 checked the shield.' (encounter); reached through
; ScriptCommand66 in bank $10 (E-0038, E-0245)
SceneShieldGuardian::
    ld a, [wScriptStep]
    jumptable
    dw SceneShieldGuardian_ShowIWishYouWouldnt
    dw SceneHomecoming_WaitMessage
    dw SceneShieldGuardian_Flicker
    dw SceneHomecoming_WaitMessage
    dw SceneShieldGuardian_ShowISeeButI
    dw SceneShieldGuardian_StartBattle
    dw SceneShieldGuardian_Msg0AF0_WhatLoseToA
    dw SceneHomecoming_WaitMessage
    dw SceneShieldGuardian_ShowOhMyGoodnessThank
    dw SceneHomecoming_WaitMessage
    dw SceneShieldGuardian_ShowThatWasALovely
    dw SceneHomecoming_WaitMessage
    dw SceneShieldGuardian_HopObject1
    dw SceneHomecoming_WaitMessage
    dw SceneShieldGuardian_ShowHelenIPutYou
    dw PersonalityMessage_WaitForMessage

; Shield guardian scene, step 14: object 0 faces down; Helen's 'I put you through trouble...'
; (message $0AF5) and EVENT_SCENE_SHIELD_GUARDIAN_1E2. (C2, E-0357; probed E-0376)
SceneShieldGuardian_ShowHelenIPutYou::
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, $0af5 ; 'Helen: I put you through trouble…'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_SHIELD_GUARDIAN_1E2
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian_HopObject1", ROMX

; Shield guardian scene, step 12: object 1 faces up and hops; then message $0AF4. (C2, E-0357;
; probed E-0376)
SceneShieldGuardian_HopObject1::
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld de, wObject1 + OBJ_Y
    ld hl, $0af4
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneShieldGuardian_ShowThatWasALovely", ROMX

; Shield guardian scene, step 10: decompresses FieldSpriteGfx0F to VRAM $8500, gives object 0 sprite
; $0F facing right; then 'That was a lovely sleep.' (message $0AF3). (C1, E-0357)
SceneShieldGuardian_ShowThatWasALovely::
    ld de, FieldSpriteGfx0F
    ld b, BANK(FieldSpriteGfx0F)
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    xor a
    ld [wSpriteSlots + $7], a
    ld a, $0f
    ld [wSpriteSlots + $2], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, $0af3 ; '*: That was a lovely sleep.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian_ShowOhMyGoodnessThank", ROMX

; Shield guardian scene, step 8: blinks object 2 (at Y $20) out; then two sprite slots, object 1
; faces left and 'Oh, my goodness! Thank you!' (message $0AF2). (C2, E-0357; probed E-0376)
SceneShieldGuardian_ShowOhMyGoodnessThank::
    ld a, $02
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld hl, $0af2 ; '*: Oh, my goodness! Thank you!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian_Msg0AF0_WhatLoseToA", ROMX

; Shield guardian scene, step 6: 'What? Lose to a child's ...' (message $0AF0). (C2, E-0357; probed
; E-0376)
SceneShieldGuardian_Msg0AF0_WhatLoseToA::
    ld hl, $0af0 ; '*: What? Lose to a child's'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian_StartBattle", ROMX

; Shield guardian scene, step 5: after the box closes, starts scripted battle 4. (C1, E-0357)
SceneShieldGuardian_StartBattle::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $04
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian_ShowISeeButI", ROMX

; Shield guardian scene, step 4: the answer: the first choice shows message $0DCE in the open box
; and goes on to the battle; another shows $0DCF and ends at step $0F. (C2, E-0357; probed E-0376)
SceneShieldGuardian_ShowISeeButI::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, MSG_ALREADY_OPEN | $0dce ; '*: I see… But I will'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, MSG_ALREADY_OPEN | $0dcf ; '*: I see… Then leave at'
    call StartMessageHL_B0F
    ld a, $0f
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneShieldGuardian_Flicker", ROMX

; Shield guardian scene, step 2: puts object 2 at Y $20 and flickers it (3 or 2 sprite slots,
; slowing) for $78 frames; then 'Our plan called for chaos ...' (message $0AEE, kept open for the
; question). (C2, E-0357; probed E-0376)
SceneShieldGuardian_Flicker::
    ld a, $20
    ld [wObject2 + OBJ_Y], a
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_sprite_slot_count_to_03
    jr .set_sprite_slot_count_to_02

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_sprite_slot_count_to_03
    jr .set_sprite_slot_count_to_02

.check_bit3:
    bit 3, a
    jr z, .set_sprite_slot_count_to_03
    jr .set_sprite_slot_count_to_02

.set_sprite_slot_count_to_03:
    ld a, $03
    ld [wSpriteSlotCount], a
    jr .call_step_script_param0_counter_bank0_f

.set_sprite_slot_count_to_02:
    ld a, $02
    ld [wSpriteSlotCount], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, MSG_KEEP_OPEN | $0aee ; '*: Our plan called for chaos'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneShieldGuardian_ShowIWishYouWouldnt", ROMX

; Shield guardian scene, step 0: the first time 'I wish you wouldn't do ...' (message $0AED),
; removes item $34 from the inventory (without checking it was found) and sets
; EVENT_SCENE_SHIELD_GUARDIAN; again 'Heh, such a show of ...' (message $0AEF) and straight to the
; battle (step 5). (C2, E-0357; probed E-0376)
SceneShieldGuardian_ShowIWishYouWouldnt::
    ld de, EVENT_SCENE_SHIELD_GUARDIAN
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $0aed ; '*: I wish you wouldn't do'
    call StartMessageHL_B0F
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, EVENT_SCENE_SHIELD_GUARDIAN
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, $0aef ; '*: Heh, such a show of'
    call StartMessageHL_B0F
    ld a, $05
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneMedicineGiven", ROMX

; Medicine given scene, run each frame by ScriptCommand49 (script command type $49,
; SCRIPT_SCENE_MEDICINE_GIVEN): jumps on wScriptStep through 4 steps: 0 object 0 and the player walk
; left and up and a scroll to the screen above starts, 1 runs the scroll until the field action
; ends, 2 object 1 and the player walk into place, 3 they walk on, face up and the script resumes.
; (C1, E-0376)
; implements script command type 49 (SCRIPT_SCENE_MEDICINE_GIVEN): a cutscene step named after the
; scene its only script shows: after 'Pardon me? You have medicine?'; reached through
; ScriptCommand49 in bank $10 (E-0038, E-0245)
SceneMedicineGiven::
    ld a, [wScriptStep]
    jumptable
    dw SceneMedicineGiven_WalkUp
    dw SceneMedicineGiven_Scroll
    dw SceneMedicineGiven_WalkObject1
    dw SceneMedicineGiven_WalkObject1Back

; Medicine given scene, step 3: object 1 walks up to Y $40, then right to X $50; the player walks up
; to Y $40, then right to X $40, then faces up with object 1, and the script resumes. (C2, E-0357;
; probed E-0376)
SceneMedicineGiven_WalkObject1Back::
    ld a, [wObject1 + OBJ_Y]
    cp $40
    jr z, .set_step_ptr_hi_to_01
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr .check_player_y

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

.check_player_y:
    ldh a, [hPlayerY]
    cp $40
    jr z, .set_step_ptr_lo_to_40
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ret

.set_step_ptr_lo_to_40:
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wObject1 + OBJ_STATE], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneMedicineGiven_WalkObject1", ROMX

; Medicine given scene, step 2: object 1 walks left to X $30, then up to Y $40; the player walks up
; to Y $70, then left to X $30. (C2, E-0357; probed E-0376)
SceneMedicineGiven_WalkObject1::
    ld a, [wObject1 + OBJ_X]
    cp $30
    jr z, .set_step_ptr_hi_to_01
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr .check_player_y

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

.check_player_y:
    ldh a, [hPlayerY]
    cp $70
    jr z, .set_step_ptr_lo_to_30
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ret

.set_step_ptr_lo_to_30:
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMedicineGiven_Scroll", ROMX

; Medicine given scene, step 1: moves the player and runs the field action until its request (bit 7)
; ends. (C1, E-0357)
SceneMedicineGiven_Scroll::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMedicineGiven_WalkUp", ROMX

; Medicine given scene, step 0: object 0 walks left to X $50, then up off the screen; the player
; walks left to X $50, then up to Y 0; then starts a scroll to the screen above (field action $80,
; direction 4, map screen Y - 1). (C1, E-0357)
SceneMedicineGiven_WalkUp::
    ld a, [wSpriteSlots + $b]
    cp $50
    jr z, .set_step_ptr_hi_to_00
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr .check_player_x

.set_step_ptr_hi_to_00:
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

.check_player_x:
    ldh a, [hPlayerX]
    cp $50
    jr z, .set_step_ptr_lo_to_00
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ret

.set_step_ptr_lo_to_00:
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    dec [hl]
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

SECTION "Bank 0F ScenePrincessMedicine", ROMX

; Princess medicine scene, run each frame by ScriptCommand48 (script command type $48,
; SCRIPT_SCENE_PRINCESS_MEDICINE): jumps on wScriptStep through 13 steps: 0 checks that object 1 is
; at ($80, $10) (otherwise straight to the battle at step 6), 1 object 1 hops away and object 2
; takes its place, 2 object 0 hops with message $0AD2 the first time
; (EVENT_SCENE_PRINCESS_MEDICINE), 4 removes item $33 (ITEM_YUNASOUL) and takes the answer (a
; refusal ends at step $0C), 6 scripted battle $18, 7-11 the messages after the battle with object 2
; blinking out and EVENT_SCENE_PRINCESS_MEDICINE_09D, 12 waits for the box and resumes the script.
; (C1, E-0376)
; implements script command type 48 (SCRIPT_SCENE_PRINCESS_MEDICINE): a cutscene step named after
; the scene its only script shows: 'STOP DON'T MEDDLE' ... 'Pardon me? You have medicine?'
; (encounter, removes an item); reached through ScriptCommand48 in bank $10 (E-0038, E-0245)
ScenePrincessMedicine::
    ld a, [wScriptStep]
    jumptable
    dw ScenePrincessMedicine_Start
    dw ScenePrincessMedicine_HopObject1
    dw ScenePrincessMedicine_HopObject0
    dw SceneHomecoming_WaitMessage
    dw ScenePrincessMedicine_TakeItem
    dw SceneHomecoming_WaitMessage
    dw ScenePrincessMedicine_StartBattle
    dw ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS
    dw SceneHomecoming_WaitMessage
    dw ScenePrincessMedicine_ShowYunasSoulFilledHer
    dw SceneHomecoming_WaitMessage
    dw ScenePrincessMedicine_ShowIveFinallyRememberedIm
    dw PersonalityMessage_WaitForMessage

; Princess medicine scene, step 11: 'I've finally remembered. I'm Yuna, ...' (message $0AD5) and
; EVENT_SCENE_PRINCESS_MEDICINE_09D. (C2, E-0357; probed E-0376)
ScenePrincessMedicine_ShowIveFinallyRememberedIm::
    ld hl, $0ad5 ; '*: I've finally remembered. I'm Yuna,'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePrincessMedicine_ShowYunasSoulFilledHer", ROMX

; Princess medicine scene, step 9: blinks object 2 (at Y $30) out, drops one sprite slot and shows
; 'Yuna's soul filled her body.' (message $0AD0). (C2, E-0357; probed E-0376)
ScenePrincessMedicine_ShowYunasSoulFilledHer::
    ld a, $02
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, $0ad0 ; 'Yuna's soul filled her body.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS", ROMX

; Princess medicine scene, step 7: 'H-HOW... BUT I... THIS ISN'T...' (message $0AD4). (C2, E-0357;
; probed E-0376)
ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS::
    ld hl, $0ad4 ; '*: H-HOW… BUT I… THIS ISN'T……'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePrincessMedicine_StartBattle", ROMX

; Princess medicine scene, step 6: starts scripted battle $18. (C1, E-0357)
ScenePrincessMedicine_StartBattle::
    ld a, $18
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePrincessMedicine_TakeItem", ROMX

; Princess medicine scene, step 4: removes item $33 from the inventory when present; the first
; choice shows message $0DCC in the open box, another shows $0DCD and ends at step $0C. (C2, E-0357;
; probed E-0376)
ScenePrincessMedicine_TakeItem::
    ld a, $33
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .check_text_yes_no_result
    farcall RemoveInventorySlotShiftDown

.check_text_yes_no_result:
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, MSG_ALREADY_OPEN | $0dcc ; '*: YOUR LIFE ENDS HERE! GIVE'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, MSG_ALREADY_OPEN | $0dcd ; '*: KAHAHAHA! THEN LEAVE!'
    call StartMessageHL_B0F
    ld a, $0c
    ld [wScriptStep], a
    ret

SECTION "Bank 0F ScenePrincessMedicine_HopObject0", ROMX

; Princess medicine scene, step 2: object 0 hops while moving up (wScriptParam1 = 0) or down a pixel
; a frame; then the first time 'NEVER DID I EXPECT YUNA'S ...' (message $0AD2, kept open) and
; EVENT_SCENE_PRINCESS_MEDICINE, otherwise straight to the battle (step 6). (C2, E-0357; probed
; E-0376)
ScenePrincessMedicine_HopObject0::
    ld a, [wScriptParam1]
    or a
    jr nz, .skip
    ld hl, wSpriteSlots + $c
    dec [hl]
    jr .call_script_apply_step_delta_at_de

.skip:
    ld hl, wSpriteSlots + $c
    inc [hl]

.call_script_apply_step_delta_at_de:
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_SCENE_PRINCESS_MEDICINE
    call TestFlagBit
    jr c, .set_script_step_to_06
    ld hl, MSG_KEEP_OPEN | $0ad2 ; '*: NEVER DID I EXPECT YUNA'S'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_PRINCESS_MEDICINE
    call SetFlagBit
    ret

.set_script_step_to_06:
    ld a, $06
    ld [wScriptStep], a
    ret

SECTION "Bank 0F ScenePrincessMedicine_HopObject1", ROMX

; Princess medicine scene, step 1: object 1 moves left and down a pixel a frame with a hop, turning
; every four frames, for $20 frames; then objects 1 and 2 both take the facing of object 0, object 2
; takes the place of object 1, object 1 is hidden (X $E0), sound $63 plays and the next step starts.
; wScriptParam1 picks the direction of step 2 (1 = down): 1 when the player is at Y $20, 0 at Y $40,
; otherwise 1 only when the party has more than one monster and the second follower
; (wFollowerRecords + 7) is at Y $20. (C2, E-0376)
ScenePrincessMedicine_HopObject1::
    ld hl, wObject1 + OBJ_X
    dec [hl]
    ld hl, wObject1 + OBJ_Y
    inc [hl]
    ld de, wObject1 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    jr nz, .check_script_param0
    ld a, [wObject1 + OBJ_STATE]
    inc a
    and $03
    ld [wObject1 + OBJ_STATE], a

.check_script_param0:
    ld a, [wScriptParam0]
    cp $20
    ret nz
    ld a, [wSpriteSlots + $7]
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_X]
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_Y]
    ld [wObject2 + OBJ_Y], a
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    ld a, $63
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    xor a
    ld [wScriptParam1], a
    ldh a, [hPlayerY]
    cp $20
    jr z, .set_script_param1_to_01
    cp $40
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    ld a, [wFollowerRecords + $7]
    cp $20
    ret nz

.set_script_param1_to_01:
    ld a, $01
    ld [wScriptParam1], a
    ret

SECTION "Bank 0F ScenePrincessMedicine_Start", ROMX

; Princess medicine scene, step 0: with object 1 at ($80, $10) plays sound $65 and moves on;
; otherwise skips to the battle (step 6). (C2, E-0357; probed E-0376)
ScenePrincessMedicine_Start::
    ld a, [wObject1 + OBJ_X]
    cp $80
    jr nz, .set_script_step_to_06
    ld a, [wObject1 + OBJ_Y]
    cp $10
    jr nz, .set_script_step_to_06
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

.set_script_step_to_06:
    ld a, $06
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneCheerYuna", ROMX

; Cheer Yuna scene, run each frame by ScriptCommand46 (script command type $46,
; SCRIPT_SCENE_CHEER_YUNA): jumps on wScriptStep through 17 steps: object 2 dances, hops and turns
; (0-6), says message $03A0, hops and walks off down (7-10), the player walks to X $40 and up to Y
; $40 for message $03A1 of the King (11-13), the followers perform (14-15,
; SceneCheerYuna_FollowersPerform), and step 16 turns the player up and resumes the script. (C1,
; E-0376)
; implements script command type 46 (SCRIPT_SCENE_CHEER_YUNA): a cutscene step named after the scene
; its only script shows: 'You're here to cheer Lady Yuna.' ... 'King Magnificent!'; reached through
; ScriptCommand46 in bank $10 (E-0038, E-0245)
SceneCheerYuna::
    ld a, [wScriptStep]
    jumptable
    dw SceneCheerYuna_Dance
    dw SceneCheerYuna_Hop
    dw SceneCheerYuna_FaceLeft
    dw SceneCheerYuna_Pause
    dw SceneCheerYuna_FaceRight
    dw SceneCheerYuna_Pause
    dw SceneCheerYuna_FaceRight
    dw SceneCheerYuna_ShowEnoughEnoughOfThat
    dw SceneHomecoming_WaitMessage
    dw SceneCheerYuna_HopInPlace
    dw SceneCheerYuna_WalkOff
    dw SceneCheerYuna_WalkPlayerAcross
    dw SceneCheerYuna_ShowIAmTheKing
    dw SceneHomecoming_WaitMessage
    dw SceneCheerYuna_PrepareFollowers
    dw SceneCheerYuna_FollowersPerform
    dw SceneCheerYuna_FaceUp

; Cheer Yuna scene, step 16: the player faces up and the script resumes. (C2, E-0357; probed E-0376)
SceneCheerYuna_FaceUp::
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneCheerYuna_FollowersPerform", ROMX

; Cheer Yuna scene, step 15: runs the walking sub-steps (RunScriptSubStep, by wScriptSubStep: the
; followers catch up and spread out, object 5 hops, the followers run round the player, everyone
; faces down and stands, object 5 sinks, the followers return); the last sub-step advances
; wScriptStep. (C1, E-0370)
SceneCheerYuna_FollowersPerform::
    farcall RunScriptSubStep
    ret

SECTION "Bank 0F SceneCheerYuna_PrepareFollowers", ROMX

; Cheer Yuna scene, step 14: clears wScriptSubStep and wScriptParam0 for the walking sub-steps of
; step 15 (SceneCheerYuna_FollowersPerform) and moves on. (C2, E-0370; probed E-0376)
SceneCheerYuna_PrepareFollowers::
    xor a
    ld [wScriptSubStep], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_ShowIAmTheKing", ROMX

; Cheer Yuna scene, step 12: walks the player up to Y $40; then the King's 'I am the King. What ...'
; (message $03A1). (C2, E-0357; probed E-0376)
SceneCheerYuna_ShowIAmTheKing::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $03a1 ; '*: I am the King. What'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_WalkPlayerAcross", ROMX

; Cheer Yuna scene, step 11: walks the player one pixel a frame toward X $40, facing the way it
; goes, with the followers following. (C2, E-0357; probed E-0376)
SceneCheerYuna_WalkPlayerAcross::
    ldh a, [hPlayerX]
    cp $40
    jr nz, .skip
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    jr nc, .read_player_x
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    inc [hl]
    ret

.read_player_x:
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    dec [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_WalkOff", ROMX

; Cheer Yuna scene, step 10: walks object 2 down to Y $A0; then sets bit 2 of hPlayerStateFlags and
; plays the map music. (C1, E-0357)
SceneCheerYuna_WalkOff::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $a0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    farcall PlayMapMusic
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_HopInPlace", ROMX

; Cheer Yuna scene, step 9: object 2 hops, then the next step. (C2, E-0357; probed E-0376)
SceneCheerYuna_HopInPlace::
    ld de, wObject2 + OBJ_Y
    call ScriptStepDeltaThenNextStep
    ret

SECTION "Bank 0F SceneCheerYuna_ShowEnoughEnoughOfThat", ROMX

; Cheer Yuna scene, step 7: object 2 faces up, clears its flag bit 2 and 'Enough... Enough of that
; dancing!' (message $03A0). (C2, E-0357; probed E-0376)
SceneCheerYuna_ShowEnoughEnoughOfThat::
    ld a, $02
    ld [wObject2 + OBJ_STATE], a
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, $03a0 ; '*: Enough… Enough of that dancing!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_FaceRight", ROMX

; Cheer Yuna scene, steps 4 and 6: after $4B frames object 2 faces right and clears its flag bit 1,
; then the next step. (C2, E-0376)
SceneCheerYuna_FaceRight::
    ld b, $4b
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_Pause", ROMX

; Cheer Yuna scene, steps 3 and 5: sets flag bit 2 of object 2 every frame; after $1E frames sets
; its flag bit 1 and moves on. (C2, E-0376)
SceneCheerYuna_Pause::
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_FaceLeft", ROMX

; Cheer Yuna scene, step 2: after $4B frames object 2 faces left and clears its flag bit 1. (C2,
; E-0357; probed E-0376)
SceneCheerYuna_FaceLeft::
    ld b, $4b
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_Hop", ROMX

; Cheer Yuna scene, step 1: object 2 hops while moving right one pixel every other frame and turning
; every eight frames, for $20 frames; then faces down and sets its flag bit 1. (C2, E-0357; probed
; E-0376)
SceneCheerYuna_Hop::
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld a, [wFrameCounterLo]
    srl a
    srl a
    srl a
    and $03
    ld [wObject2 + OBJ_STATE], a
    ld de, wObject2 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_script_param0
    ld hl, wObject2 + OBJ_X
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wObject2 + OBJ_STATE], a
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit1AtHL_Bank0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_Dance", ROMX

; Cheer Yuna scene, step 0: object 2 dances: walks right to X $70, left to X $20, then right to X
; $40, turning every four frames. (C2, E-0357; probed E-0376)
SceneCheerYuna_Dance::
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call SceneCheerYuna_Dance_TurnObject2
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .set_step_ptr_hi_to_02
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call SceneCheerYuna_Dance_TurnObject2
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call SceneCheerYuna_Dance_TurnObject2
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCheerYuna_Dance_TurnObject2", ROMX

; Turns object 2 every four frames (its state = frame counter bits 2-3). (C2, E-0357; probed E-0376)
SceneCheerYuna_Dance_TurnObject2::
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and $03
    ld [wObject2 + OBJ_STATE], a
    ret

SECTION "Bank 0F SceneExplosion", ROMX

; Explosion scene, run each frame by ScriptCommand41 (script command type $41,
; SCRIPT_SCENE_EXPLOSION): jumps on wScriptStep through 10 steps: 0 on the first visit sets
; EVENT_SCENE_EXPLOSION (a repeat shows message $0347 and jumps to step 3), 1 object 0 walks down, 2
; the screen shakes while the party hops down and message $0346, 3 scripted battle 3, 4-5 message
; $0348 'Darn! Take this! SACRIFICE!', 6 the party walks down to Y $40, 7-8 object 0 is hidden, the
; screen flashes and shakes, 9 the scene object drops, object 2 becomes sprite $52 and the script
; resumes. (C1, E-0376)
; implements script command type 41 (SCRIPT_SCENE_EXPLOSION): a cutscene step named after the scene
; its only script shows: 'What? What was that explosion?' (screen shake and flash); reached through
; ScriptCommand41 in bank $10 (E-0038, E-0245)
SceneExplosion::
    ld a, [wScriptStep]
    jumptable
    dw SceneExplosion_Start
    dw SceneExplosion_WalkObject0Down
    dw SceneExplosion_Shake
    dw SceneExplosion_StartBattle
    dw SceneExplosion_Msg0348_DarnTakeThisSACRIFICE
    dw SceneHomecoming_WaitMessage
    dw SceneExplosion_WalkDown
    dw SceneExplosion_Flash
    dw SceneExplosion_ShakeAfterFlash
    dw SceneExplosion_DropObject

; Explosion scene, step 9: the scene object falls two pixels a frame to Y $10; then sound $72,
; object 2 becomes sprite $52 (graphics decompressed to VRAM $8700), the object palettes are
; reloaded and the script resumes. (C1, E-0357)
SceneExplosion_DropObject::
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    cp $10
    ret nz
    ld a, $72
    call QueueSoundEffect
    ld a, $52
    ld [wObject2 + OBJ_SPRITE_ID], a
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ld a, $01
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
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneExplosion_ShakeAfterFlash", ROMX

; Explosion scene, step 8: shakes the screen for $0F frames. (C2, E-0357; probed E-0376)
SceneExplosion_ShakeAfterFlash::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

SECTION "Bank 0F SceneExplosion_Flash", ROMX

; Explosion scene, step 7: hides object 0 (X $E0) and runs the negative screen flash. (C2, E-0357;
; probed E-0376)
SceneExplosion_Flash::
    ld a, $e0
    ld [wSpriteSlots + $b], a
    farcall ScriptStepFlashScreenNegative
    ret

SECTION "Bank 0F SceneExplosion_WalkDown", ROMX

; Explosion scene, step 6: speeds up the player's walking animation (hPlayerStateFlags bit 2) while
; the player and the followers move down one pixel every four frames to Y $40; then field command 9,
; saves the GBC background palettes, plays sound $7A and ends the fast animation. (C1, E-0357)
SceneExplosion_WalkDown::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    cp $40
    ret nz
    ld a, $09
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, [wIsCGB]
    or a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7a
    call QueueSoundEffect
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneExplosion_Msg0348_DarnTakeThisSACRIFICE", ROMX

; Explosion scene, step 4: 'Darn! Take this! SACRIFICE!' (message $0348). (C2, E-0357; probed
; E-0376)
SceneExplosion_Msg0348_DarnTakeThisSACRIFICE::
    ld hl, $0348 ; '*: Darn! Take this! SACRIFICE!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneExplosion_StartBattle", ROMX

; Explosion scene, step 3: after the box closes, starts scripted battle 3. (C1, E-0357)
SceneExplosion_StartBattle::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $03
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneExplosion_Shake", ROMX

; Explosion scene, step 2: shakes the screen (ScriptStepShakeScreen with B = $3C) while the player
; and the three followers move down a pixel a frame with a hop. The shake and this step both count
; wScriptParam0, so it rises by 2 a frame: after 16 frames it reaches $20, message $0346 starts,
; wScriptParam0 = 0 and the next step begins. The shake never reaches its own $3C end, so hScrollX
; is not reset here. (C2, E-0376)
SceneExplosion_Shake::
    ld b, $3c
    call ScriptStepShakeScreen
    ld hl, hPlayerY
    inc [hl]
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, wFollowerRecords + $2
    inc [hl]
    ld de, wFollowerRecords + $2
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, wFollowerRecords + $c
    inc [hl]
    ld de, wFollowerRecords + $c
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
    ld hl, $0346 ; '*: Don't you touch that. If'
    call StartMessageHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneExplosion_WalkObject0Down", ROMX

; Explosion scene, step 1: walks object 0 down (two pixels a frame) to Y $20; then sound $66. (C2,
; E-0357; probed E-0376)
SceneExplosion_WalkObject0Down::
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $66
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneExplosion_Start", ROMX

; Explosion scene, step 0: the first time redraws the columns beside the screen and sets
; EVENT_SCENE_EXPLOSION; again 'You again? I'll have to ...' (message $0347) and straight to the
; battle (step 3). (C1, E-0357)
SceneExplosion_Start::
    ld de, EVENT_SCENE_EXPLOSION
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    farcall RedrawColumnsBesideScreen
    ld de, EVENT_SCENE_EXPLOSION
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, $0347 ; '*: You again? I'll have to'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

SECTION "Bank 0F ScenePlanRuined", ROMX

; Plan ruined scene, run each frame by ScriptCommand45 (script command type $45,
; SCRIPT_SCENE_PLAN_RUINED): jumps on wScriptStep through 4 steps: 0 objects 0 and 2 swap places in
; a $78-frame flicker (skipped to step 2 when EVENT_SCENE_PLAN_RUINED is set), 1 waits $1E frames
; and sets EVENT_SCENE_PLAN_RUINED, 2 starts scripted battle $0C, 3 blinks object 0 out and resumes
; the script. (C1, E-0376)
; implements script command type 45 (SCRIPT_SCENE_PLAN_RUINED): a cutscene step named after the
; scene its only script shows: 'Arrgh, you've ruined my plan' ... 'Bravo! We're saved!' (starts a
; scripted encounter); reached through ScriptCommand45 in bank $10 (E-0038, E-0245)
ScenePlanRuined::
    ld a, [wScriptStep]
    jumptable
    dw ScenePlanRuined_Start
    dw ScenePlanRuined_Wait
    dw ScenePlanRuined_StartBattle
    dw ScenePlanRuined_BlinkOut

; Plan ruined scene, step 3: blinks object 0 (at Y $40) out, hides it and resumes the script. (C2,
; E-0357; probed E-0376)
ScenePlanRuined_BlinkOut::
    ld a, $00
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F ScenePlanRuined_StartBattle", ROMX

; Plan ruined scene, step 2: starts scripted battle $0C. (C1, E-0357)
ScenePlanRuined_StartBattle::
    ld a, $0c
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePlanRuined_Wait", ROMX

; Plan ruined scene, step 1: waits $1E frames, then sets EVENT_SCENE_PLAN_RUINED. (C2, E-0357;
; probed E-0376)
ScenePlanRuined_Wait::
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, EVENT_SCENE_PLAN_RUINED
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScenePlanRuined_Start", ROMX

; Plan ruined scene, step 0: when EVENT_SCENE_PLAN_RUINED is set skips to the battle (step 2);
; otherwise object 0 takes object 2's facing and the two swap places on screen (one at Y $40, the
; other hidden; every 2 frames, slowing to 4 and 8) for $78 frames, ending with object 0 shown. (C2,
; E-0357; probed E-0376)
ScenePlanRuined_Start::
    ld de, EVENT_SCENE_PLAN_RUINED
    call TestFlagBit
    jr nc, .read_object2
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.read_object2:
    ld a, [wObject2 + OBJ_STATE]
    ld [wSpriteSlots + $7], a
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_sprite_slots_to_40
    jr .set_sprite_slots_to_E0

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_sprite_slots_to_40
    jr .set_sprite_slots_to_E0

.check_bit3:
    bit 3, a
    jr z, .set_sprite_slots_to_40
    jr .set_sprite_slots_to_E0

.set_sprite_slots_to_40:
    ld a, $40
    ld [wSpriteSlots + $c], a
    ld a, $e0
    ld [wObject2 + OBJ_Y], a
    jr .call_step_script_param0_counter_bank0_f

.set_sprite_slots_to_E0:
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld a, $40
    ld [wObject2 + OBJ_Y], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $40
    ld [wSpriteSlots + $c], a
    ld a, $e0
    ld [wObject2 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWallExit", ROMX

; Wall exit scene, run each frame by ScriptCommand43 (script command type $43,
; SCRIPT_SCENE_WALL_EXIT): jumps on wScriptStep through 13 steps: the scene object appears at ($30,
; $40), step 1 saves the player X in wScriptParam1 and Kameha speaks (0-2), the player steps aside
; and the followers gather (3-6), object 1 moves right to the saved X and up, is lowered, then walks
; up off the top (7-9); step 10 opens the exit when the saved X was $30 (bit 0 of story byte $63,
; tiles $38-$3B) and resumes the script, otherwise it shows message $0362 and step 12 walks object 1
; back down before the script resumes. (C1, E-0376)
; implements script command type 43 (SCRIPT_SCENE_WALL_EXIT): a cutscene step named after the scene
; its only script shows: '0 tapped on the wall.' ... 'Kameha That's it! That's the exit!'; reached
; through ScriptCommand43 in bank $10 (E-0038, E-0245)
SceneWallExit::
    ld a, [wScriptStep]
    jumptable
    dw SceneWallExit_Start
    dw SceneWallExit_ShowKamehaSoThatsWhere
    dw SceneHomecoming_WaitMessage
    dw SceneWallExit_WalkPlayer
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_MoveObject1
    dw SceneWallExit_LowerObject1
    dw SceneWallExit_WalkObject1
    dw SceneWallExit_ShowKamehaHeroThatWasnt
    dw SceneHomecoming_WaitMessage
    dw SceneWallExit_WalkObject1Down

; Wall exit scene, step 12: walks object 1 down (two pixels a frame) to Y $50, then moves it left
; two pixels a frame to X $30; then it faces right, stops and the script resumes. (C2, E-0357;
; probed E-0376)
SceneWallExit_WalkObject1Down::
    ld a, [wObject1 + OBJ_Y]
    cp $50
    jr z, .check_object1
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ret

.check_object1:
    ld a, [wObject1 + OBJ_X]
    cp $30
    jr z, .set_object1_to_01
    dec a
    dec a
    ld [wObject1 + OBJ_X], a
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ret

.set_object1_to_01:
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneWallExit_ShowKamehaHeroThatWasnt", ROMX

; Wall exit scene, step 10: object 1 sinks a pixel a frame with a hop while the screen shakes, for
; $20 frames; then, when the player stood at X $30, sets bit 0 of story byte $63, puts tiles $38-$3B
; into the screen buffer, redraws it and resumes the script; otherwise Kameha's '... <hero>... That
; wasn't it...' (message $0362). (C1, E-0357)
SceneWallExit_ShowKamehaHeroThatWasnt::
    ld hl, wObject1 + OBJ_Y
    inc [hl]
    ld de, wObject1 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $3c
    call ScriptStepShakeScreen
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, [wScriptParam1]
    cp $30
    jr z, .read_story_flags
    ld hl, $0362 ; 'Kameha: … 0… That wasn't it…'
    call StartMessageHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

.read_story_flags:
    ld a, [wStoryFlags + $63]
    set 0, a
    ld [wStoryFlags + $63], a
    ld a, $38
    ld [wScreenTileBuffer + $6], a
    ld a, $39
    ld [wScreenTileBuffer + $7], a
    ld a, $3a
    ld [wScreenTileBuffer + $1a], a
    ld a, $3b
    ld [wScreenTileBuffer + $1b], a
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneWallExit_WalkObject1", ROMX

; Wall exit scene, step 9: walks object 1 up (two pixels a frame) to Y 0; then plays sound $66 when
; the player stood at X $30, $63 otherwise. (C2, E-0357; probed E-0376)
SceneWallExit_WalkObject1::
    ld a, $00
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam1]
    cp $30
    jr z, .call_queue_sound_effect
    ld a, $63
    call QueueSoundEffect
    ret

.call_queue_sound_effect:
    ld a, $66
    call QueueSoundEffect
    ret

SECTION "Bank 0F SceneWallExit_LowerObject1", ROMX

; Wall exit scene, step 8: object 1 moves down one pixel every eight frames to Y $30. (C2, E-0357;
; probed E-0376)
SceneWallExit_LowerObject1::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $07
    ret nz
    ld a, [wObject1 + OBJ_Y]
    inc a
    ld [wObject1 + OBJ_Y], a
    cp $30
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWallExit_MoveObject1", ROMX

; Wall exit scene, step 7: object 1 moves right two pixels a frame (facing right) to the player's
; saved X, then up to Y $20, then stops. (C2, E-0357; probed E-0376)
SceneWallExit_MoveObject1::
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wObject1 + OBJ_X]
    cp c
    jr z, .set_step_ptr_lo_to_20
    inc a
    inc a
    ld [wObject1 + OBJ_X], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ret

.set_step_ptr_lo_to_20:
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWallExit_WalkPlayer", ROMX

; Wall exit scene, step 3: walks the player (fast animation, bit 2) one pixel a frame for 16 frames
; (right when the saved X is below $40, left otherwise, the followers following); then turns it
; around and lets it go. (C2, E-0357; probed E-0376)
SceneWallExit_WalkPlayer::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam1]
    cp $40
    jr nc, .check_player_x
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    ld a, $01
    ldh [hPlayerFacing], a
    jr .check_script_param0

.check_player_x:
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    ld a, $03
    ldh [hPlayerFacing], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $10
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ret

SECTION "Bank 0F SceneWallExit_ShowKamehaSoThatsWhere", ROMX

; Wall exit scene, step 1: waits $3C frames, hides the scene object, saves the player's X in
; wScriptParam1 and shows Kameha's 'So that's where the exit ...' (message $0361). (C2, E-0357;
; probed E-0376)
SceneWallExit_ShowKamehaSoThatsWhere::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    ld [wScriptParam1], a
    ld hl, $0361 ; 'Kameha: So that's where the exit'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneWallExit_Start", ROMX

; Wall exit scene, step 0: redraws the columns beside the screen, runs field command 5 and puts the
; scene object at ($30, $40). (C1, E-0357)
SceneWallExit_Start::
    farcall RedrawColumnsBesideScreen
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing", ROMX

; Report to king scene, run each frame by ScriptCommand42 (script command type $42,
; SCRIPT_SCENE_REPORT_TO_KING): jumps on wScriptStep through 18 steps: object 1 and the player walk
; up and the screen scrolls up (0-1), object 1 walks into place, messages $0322 and $035A, a hop and
; message $035B as object 1 walks off (2-7), tile $6A is drawn and the player and the followers are
; hidden one by one while the followers gather (8-14; a smaller party skips to step $0F), a warp to
; map $4D (15), and the party drops in from above the screen and the script resumes (16-17). (C1,
; E-0376)
; implements script command type 42 (SCRIPT_SCENE_REPORT_TO_KING): a cutscene step named after the
; scene its only script shows: 'We reported to the King that...'; reached through ScriptCommand42 in
; bank $10 (E-0038, E-0245)
SceneReportToKing::
    ld a, [wScriptStep]
    jumptable
    dw SceneReportToKing_WalkUp
    dw SceneReportToKing_Scroll
    dw SceneReportToKing_WalkObject1
    dw SceneReportToKing_Msg035A_WhatIsItYou
    dw SceneHomecoming_WaitMessage
    dw SceneReportToKing_HopObject1
    dw SceneReportToKing_WalkObject1Off
    dw SceneHomecoming_WaitMessage
    dw SceneReportToKing_DrawTiles
    dw SceneWallExit_GatherFollowers
    dw SceneReportToKing_HideFollower
    dw SceneWallExit_GatherFollowers
    dw SceneReportToKing_HideSecondFollower
    dw SceneWallExit_GatherFollowers
    dw SceneReportToKing_HideThirdFollower
    dw SceneReportToKing_Warp
    dw SceneReportToKing_HideParty
    dw SceneReportToKing_WalkDown

; Report to king scene, step 17: the player and the followers walk down two pixels a frame to Y $40;
; once the player is there objects 0 and 1 hop; when the last follower arrives the player's
; animation restarts (bit 1) and the script resumes. (C2, E-0357; probed E-0376)
SceneReportToKing_WalkDown::
    ld a, [wScriptParam1]
    or a
    jr nz, .skip
    ldh a, [hPlayerY]
    cp $40
    jr nz, .check_player_y
    ld hl, wScriptParam1
    inc [hl]
    jr .check_player_y

.skip:
    dec a
    jr nz, .check_player_y
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    jr nc, .check_player_y
    ld hl, wScriptParam1
    inc [hl]

.check_player_y:
    ldh a, [hPlayerY]
    cp $40
    jr z, .check_follower_records
    inc a
    inc a
    ldh [hPlayerY], a

.check_follower_records:
    ld a, [wFollowerRecords + $2]
    cp $40
    jr z, .check_follower_records2
    inc a
    inc a
    ld [wFollowerRecords + $2], a

.check_follower_records2:
    ld a, [wFollowerRecords + $7]
    cp $40
    jr z, .check_follower_records3
    inc a
    inc a
    ld [wFollowerRecords + $7], a

.check_follower_records3:
    ld a, [wFollowerRecords + $c]
    inc a
    inc a
    ld [wFollowerRecords + $c], a
    cp $40
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneReportToKing_HideParty", ROMX

; Report to king scene, step 16: freezes the player's animation (bit 1), puts the followers above
; the screen (Y $D0, $C0, $B0) and plays sound $65. (C2, E-0357; probed E-0376)
SceneReportToKing_HideParty::
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank0F
    ld a, $d0
    ld [wFollowerRecords + $2], a
    ld a, $c0
    ld [wFollowerRecords + $7], a
    ld a, $b0
    ld [wFollowerRecords + $c], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing_Warp", ROMX

; Report to king scene, step 15: moves the player and the followers off the screen (X $E0), shows
; them again (hFieldDrawFlags 0) and warps to map $4D, screen (0, 1) at ($40, $E0) (transition kind
; 1) with a fade. (C1, E-0357)
SceneReportToKing_Warp::
    ld a, $e0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $4d
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $e0
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneReportToKing_HideThirdFollower", ROMX

; Report to king scene, step 14: hides the third follower too (hFieldDrawFlags $0F). (C2, E-0357;
; probed E-0376)
SceneReportToKing_HideThirdFollower::
    ld a, $0f
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing_HideSecondFollower", ROMX

; Report to king scene, step 12: hides the second follower too (hFieldDrawFlags 7); with two party
; monsters skips to step $0F. (C2, E-0357; probed E-0376)
SceneReportToKing_HideSecondFollower::
    ld hl, wScriptStep
    inc [hl]
    ld a, $07
    ldh [hFieldDrawFlags], a
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0f
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneReportToKing_HideFollower", ROMX

; Report to king scene, step 10: hides the first follower too (hFieldDrawFlags 3); with one party
; monster skips to step $0F. (C2, E-0357; probed E-0376)
SceneReportToKing_HideFollower::
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hFieldDrawFlags], a
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0f
    ld [wScriptStep], a
    ret

SECTION "Bank 0F SceneReportToKing_DrawTiles", ROMX

; Report to king scene, step 8: puts tile $6A into four screen buffer cells and redraws the screen,
; hides the player (hFieldDrawFlags 1) and plays sound $65. (C1, E-0357)
SceneReportToKing_DrawTiles::
    ld a, $6a
    ld [wScreenTileBuffer + $a8], a
    ld [wScreenTileBuffer + $a9], a
    ld [wScreenTileBuffer + $bc], a
    ld [wScreenTileBuffer + $bd], a
    farcall DrawFullScreenBufferAtScroll
    ld a, $01
    ldh [hFieldDrawFlags], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing_WalkObject1Off", ROMX

; Report to king scene, step 6: walks object 1 right (two pixels a frame) to X $40, then down to Y
; $A0; then 'You're no envoy of the ...' (message $035B). (C2, E-0357; probed E-0376)
SceneReportToKing_WalkObject1Off::
    ld a, [wObject1 + OBJ_X]
    cp $40
    jr z, .set_step_ptr_lo_to_A0
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ret

.set_step_ptr_lo_to_A0:
    ld a, $a0
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $035b ; '*: You're no envoy of the'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing_HopObject1", ROMX

; Report to king scene, step 5: object 1 faces up and hops, then the next step. (C2, E-0357; probed
; E-0376)
SceneReportToKing_HopObject1::
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld de, wObject1 + OBJ_Y
    call ScriptStepDeltaThenNextStep
    ret

SECTION "Bank 0F SceneReportToKing_Msg035A_WhatIsItYou", ROMX

; Report to king scene, step 3: 'What is it, you whelp!?' (message $035A). (C2, E-0357; probed
; E-0376)
SceneReportToKing_Msg035A_WhatIsItYou::
    ld hl, $035a ; '*: What is it, you whelp!?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneSpiritEnvoy", ROMX

; Spirit envoy scene, run each frame by ScriptCommand40 (script command type $40,
; SCRIPT_SCENE_SPIRIT_ENVOY): jumps on wScriptStep through 11 steps; steps 0-2 are those of
; SceneReportToKing (walk up, scroll, object 1 into place and message $0322), then the player walks
; down and the screen scrolls down (4-5), the player walks to Y $10 (6), the followers gather (7-9)
; and step 10 resumes the script. (C1, E-0376)
; implements script command type 40 (SCRIPT_SCENE_SPIRIT_ENVOY): a cutscene step named after the
; scene its only script shows: 'Ah, you are the spirit's envoy.' ... 'We reported to the King
; that...'; reached through ScriptCommand40 in bank $10 (E-0038, E-0245)
SceneSpiritEnvoy::
    ld a, [wScriptStep]
    jumptable
    dw SceneReportToKing_WalkUp
    dw SceneReportToKing_Scroll
    dw SceneReportToKing_WalkObject1
    dw SceneHomecoming_WaitMessage
    dw SceneSpiritEnvoy_WalkDownAndScroll
    dw SceneReportToKing_Scroll
    dw SceneSpiritEnvoy_WalkPlayerDown
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_GatherFollowers
    dw SceneSpiritEnvoy_ResumeScript

; Spirit envoy scene, step 10: resumes the script. (C2, E-0357; probed E-0376)
SceneSpiritEnvoy_ResumeScript::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneSpiritEnvoy_WalkPlayerDown", ROMX

; Spirit envoy scene, step 6: walks the player down to Y $10. (C2, E-0357; probed E-0376)
SceneSpiritEnvoy_WalkPlayerDown::
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneSpiritEnvoy_WalkDownAndScroll", ROMX

; Spirit envoy scene, step 4: walks the player down to Y $80, then starts a scroll to the screen
; below (field action $80, direction 8, map screen Y + 1). (C1, E-0357)
SceneSpiritEnvoy_WalkDownAndScroll::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
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

SECTION "Bank 0F SceneReportToKing_WalkObject1", ROMX

; Step 2 of both SceneReportToKing and SceneSpiritEnvoy: object 1 walks up to Y $60, then left to X
; $30 and faces right, one pixel a frame; the player walks up to Y $40; then message $0322 and the
; next step. (C2, E-0376)
SceneReportToKing_WalkObject1::
    ld a, [wObject1 + OBJ_Y]
    cp $60
    jr z, .check_object1
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    jr .set_step_ptr_lo_to_40

.check_object1:
    ld a, [wObject1 + OBJ_X]
    cp $30
    jr z, .set_object1_to_01
    ld a, $30
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    jr .set_step_ptr_lo_to_40

.set_object1_to_01:
    ld a, $01
    ld [wObject1 + OBJ_STATE], a

.set_step_ptr_lo_to_40:
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $0322 ; '*: You're the envoy? …Well, no'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing_Scroll", ROMX

; Report to king scene, step 1: moves the player and runs the field action until its request (bit 7)
; ends. (C1, E-0357)
SceneReportToKing_Scroll::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneReportToKing_WalkUp", ROMX

; Report to king scene, step 0: walks object 1 up off the screen and the player up to Y 0; then
; starts a scroll to the screen above (field action $80, direction 4, map screen Y - 1). (C1,
; E-0357)
SceneReportToKing_WalkUp::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    dec [hl]
    ldh a, [hPlayerStateFlags]
    or $01
    ldh [hPlayerStateFlags], a
    ld hl, $0080
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom", ROMX

; Mermaid kingdom scene, run each frame by ScriptCommand39 and by ScriptCommand3B
; (SCRIPT_SCENE_MERMAID_KINGDOM is type $39; no constant names type $3B): jumps on wScriptStep
; through 50 steps: the player walks to X $40 and the followers gather (0-3; a player already there
; skips to 4), objects walk and Kameha speaks (4-10), the scene object rises and objects 0 and 1 get
; new sprites (11-19), object 2 hops five times with screen shakes (20-29), story flags and an
; in-place transition (30), objects 1 and 2 turn and the scene object rises (31-32), the player
; walks and Kameha speaks (33-35), object 0 walks off and the player walks left (36-37), the scene
; object drifts away and a voice calls (38-43), the warp to map 5, the shared boss-win sequence and
; the scene object falling onto the player (44-48), and SceneMermaidKingdom_GiveKey resumes the
; script (49). (C1, E-0376)
; implements script command type 39 (also 3B); reached through ScriptCommand39 in bank $10 (E-0038)
SceneMermaidKingdom::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidKingdom_WalkPlayerLeftAndFaceDown
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_GatherFollowers
    dw SceneWallExit_GatherFollowers
    dw SceneMermaidKingdom_ShowKamehaGaspHackI
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_WalkObject1
    dw SceneMermaidKingdom_MoveObject1
    dw SceneMermaidKingdom_MoveObject2
    dw SceneMermaidKingdom_ShowKamehaWhatIsThis
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_WalkDown
    dw SceneMermaidKingdom_ShowKahahaha
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_LoadSprites
    dw SceneMermaidKingdom_ShowThisIsWhatIt
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_SinkObject
    dw SceneMermaidKingdom_ShowKamehaUrrrggh
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_HopObject2
    dw SceneMermaidKingdom_Shake
    dw SceneMermaidKingdom_HopObject2
    dw SceneMermaidKingdom_Shake
    dw SceneMermaidKingdom_HopObject2
    dw SceneMermaidKingdom_Shake
    dw SceneMermaidKingdom_HopObject2
    dw SceneMermaidKingdom_Shake
    dw SceneMermaidKingdom_HopObject2
    dw SceneMermaidKingdom_Shake
    dw SceneMermaidKingdom_SetFlags
    dw SceneMermaidKingdom_TurnObjects
    dw SceneMermaidKingdom_RaiseObject
    dw SceneMermaidKingdom_WalkPlayerDown
    dw SceneMermaidKingdom_ShowKamehaIWasStupid
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_WalkObject0
    dw SceneMermaidKingdom_WalkPlayerLeft
    dw SceneMermaidKingdom_DriftObject
    dw SceneMermaidKingdom_Wait
    dw SceneMermaidKingdom_ShowAVoiceEchoedFrom
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_Msg0873_WaheyHeroHearMe
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_ShowWarubouWaheyYouDid
    dw SceneMermaidKingdom_PlayBossWin
    dw SceneMermaidKingdom_ShowObject
    dw SceneMermaidKingdom_ShowWarubouWaheyYouCan
    dw SceneHomecoming_WaitMessage
    dw SceneMermaidKingdom_GiveKey

; Mermaid kingdom scene, step 49: sets EVENT_SCENE_MERMAID_KINGDOM_022, marks the key of kind 3
; (MarkKeyEntryKindTemp0Bit6), sets bit 2 of story byte $60 and wFarmLevel 2, and resumes the
; script. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_GiveKey::
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call SetFlagBit
    ld a, $03
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 2, a
    ld [wStoryFlags + $60], a
    ld a, $02
    ld [wFarmLevel], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowWarubouWaheyYouCan", ROMX

; Mermaid kingdom scene, step 47: the scene object falls one pixel a frame to the player's Y and is
; hidden; then Warubou's 'Wa-hey, you can now crush ...' (message $0DC1) and
; EVENT_SCENE_MERMAID_KINGDOM. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_ShowWarubouWaheyYouCan::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    cp c
    ret nz
    xor a
    ld [wObject5], a
    ld hl, $0dc1 ; 'Warubou: Wa-hey, you can now crush'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_MERMAID_KINGDOM
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowObject", ROMX

; Mermaid kingdom scene, step 46: object 0 faces away from the player, runs field command $11, shows
; the scene object 32 pixels above the player and plays sound $85. (C1, E-0357)
SceneMermaidKingdom_ShowObject::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + SCRIPTOBJ_X], a
    ldh a, [hPlayerY]
    sub $20
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_PlayBossWin", ROMX

; Mermaid kingdom scene, step 45: plays the shared boss-win sequence (BossWinScene, run by
; wScriptSubStep: sprites, flash, party heal, hops and shakes); its last sub-step advances
; wScriptStep. (C1, E-0370)
SceneMermaidKingdom_PlayBossWin::
    farcall BossWinScene
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowWarubouWaheyYouDid", ROMX

; Mermaid kingdom scene, step 44: warps to map 5, screen (1, 0) at ($50, $30) (transition kind 1)
; with a fade, the scene object at ($50, $30); Warubou's 'Wa-hey! You did it, <hero>!' (message
; $02A7); clears the sub-step and bits 2 and 6 of hPlayerStateFlags. (C1, E-0357)
SceneMermaidKingdom_ShowWarubouWaheyYouDid::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, $02a7 ; 'Warubou: Wa-hey! You did it, 0!'
    call StartMessageHL_B0F
    xor a
    ld [wScriptSubStep], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ldh a, [hPlayerStateFlags]
    and $bf
    ldh [hPlayerStateFlags], a
    ret

SECTION "Bank 0F SceneMermaidKingdom_Msg0873_WaheyHeroHearMe", ROMX

; Mermaid kingdom scene, step 42: '...Wa-hey! <hero>, hear me? I ...' (message $0873). (C2, E-0357;
; probed E-0376)
SceneMermaidKingdom_Msg0873_WaheyHeroHearMe::
    ld hl, $0873 ; '*: …Wa-hey! 0, hear me? I'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowAVoiceEchoedFrom", ROMX

; Mermaid kingdom scene, step 40: the scene object sinks with a hop and is hidden; then 'A voice
; echoed from nowhere...' (message $0872). (C2, E-0357; probed E-0376)
SceneMermaidKingdom_ShowAVoiceEchoedFrom::
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wObject5], a
    ld hl, $0872 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_Wait", ROMX

; Mermaid kingdom scene, step 39: waits $1E frames. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_Wait::
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_DriftObject", ROMX

; Mermaid kingdom scene, step 38: the scene object moves up and right a pixel a frame with a hop.
; (C2, E-0357; probed E-0376)
SceneMermaidKingdom_DriftObject::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_WalkPlayerLeft", ROMX

; Mermaid kingdom scene, step 37: walks the player left to X $50, then sets
; EVENT_SCENE_MERMAID_KINGDOM_05F. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_WalkPlayerLeft::
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld de, EVENT_SCENE_MERMAID_KINGDOM_05F
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_WalkObject0", ROMX

; Mermaid kingdom scene, step 36: walks object 0 (two pixels a frame) left to X $70, up to Y $30,
; left to X $50 and up to Y 0; then draws no sprite slots and plays the map music. (C1, E-0357)
SceneMermaidKingdom_WalkObject0::
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $83
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_00

.skip:
    dec a
    jr nz, .skip2
    ld a, $82
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_00

.skip2:
    dec a
    jr nz, .set_step_target_to_82
    ld a, $83
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_00

.set_step_target_to_82:
    ld a, $82
    ld [wStepTarget], a
    ld a, $00
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_00:
    ld a, $00
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $04
    ret nz
    xor a
    ld [wSpriteSlotCount], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    farcall PlayMapMusic
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowKamehaIWasStupid", ROMX

; Mermaid kingdom scene, step 34: object 0 turns every eight frames for $38 frames; then
; FieldSpriteGfx03 is decompressed to VRAM $8500 as its sprite 3 and Kameha says 'I was stupid to
; trust ...' (message $0871). (C1, E-0357)
SceneMermaidKingdom_ShowKamehaIWasStupid::
    ld a, [wScriptParam0]
    srl a
    srl a
    srl a
    and $03
    ld [wSpriteSlots + $7], a
    ld b, $38
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, FieldSpriteGfx03
    ld b, BANK(FieldSpriteGfx03)
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $03
    ld [wSpriteSlots + $2], a
    ld hl, $0871 ; 'Kameha: I was stupid to trust'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_WalkPlayerDown", ROMX

; Mermaid kingdom scene, step 33: walks the player down to Y $10, right to X $80, then down to Y
; $30. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_WalkPlayerDown::
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .set_step_ptr_lo_to_30
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_lo_to_30:
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_RaiseObject", ROMX

; Mermaid kingdom scene, step 32: the scene object rises two pixels a frame with a hop; then sound
; $65 and one sprite slot. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_RaiseObject::
    ld a, [wObject5 + SCRIPTOBJ_Y]
    dec a
    dec a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_TurnObjects", ROMX

; Mermaid kingdom scene, step 31: objects 1 and 2 face opposite ways, swapping between right and
; left every 16 frames, for $78 frames; then shows the scene object, plays sound $65 and hides
; object 1. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_TurnObjects::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    push af
    bit 4, a
    jr z, .set_object1_to_03
    ld a, $01
    jr .set_object1

.set_object1_to_03:
    ld a, $03

.set_object1:
    ld [wObject1 + OBJ_STATE], a
    inc a
    inc a
    and $03
    ld [wObject2 + OBJ_STATE], a
    pop af
    cp $78
    ret nz
    ld a, $80
    ld [wObject5], a
    ld a, $65
    call QueueSoundEffect
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_SetFlags", ROMX

; Mermaid kingdom scene, step 30: sets bit 3 of story byte $62 and EVENT_SCENE_MERMAID_KINGDOM_07F
; and starts a transition in place (transition kind 0) with a fade. (C1, E-0357)
SceneMermaidKingdom_SetFlags::
    ld a, [wStoryFlags + $62]
    set 3, a
    ld [wStoryFlags + $62], a
    ld de, EVENT_SCENE_MERMAID_KINGDOM_07F
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneMermaidKingdom_Shake", ROMX

; Mermaid kingdom scene, steps 21, 23, 25, 27 and 29 (each after a hop of object 2,
; SceneMermaidKingdom_HopObject2): shakes the screen for $0F frames (ScriptStepShakeScreen), then
; the next step. (C2, E-0370; probed E-0376)
SceneMermaidKingdom_Shake::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

SECTION "Bank 0F SceneMermaidKingdom_HopObject2", ROMX

; Mermaid kingdom scene, steps 20, 22, 24, 26 and 28 (each followed by SceneMermaidKingdom_Shake):
; object 2 hops (ScriptApplyStepDeltaAtDE, 16 frames); then sound $63 and the next step. (C2,
; E-0376)
SceneMermaidKingdom_HopObject2::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowKamehaUrrrggh", ROMX

; Mermaid kingdom scene, step 18: object 2 hops; then Kameha's 'Urrrggh... You tricked me!' (message
; $0870). (C2, E-0370; probed E-0376)
SceneMermaidKingdom_ShowKamehaUrrrggh::
    ld de, wObject2 + OBJ_Y
    ld hl, $0870
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneMermaidKingdom_SinkObject", ROMX

; Mermaid kingdom scene, step 17: the scene object sinks with a hop and is hidden. (C2, E-0357;
; probed E-0376)
SceneMermaidKingdom_SinkObject::
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowThisIsWhatIt", ROMX

; Mermaid kingdom scene, step 15: object 0 (wSpriteSlots + $c) hops; then 'This is what it means,
; nincompoop!' (message $086F). (C2, E-0370; probed E-0376)
SceneMermaidKingdom_ShowThisIsWhatIt::
    ld de, wSpriteSlots + $c
    ld hl, $086f
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneMermaidKingdom_LoadSprites", ROMX

; Mermaid kingdom scene, step 14: loads new sprites: object 0 becomes sprite $E3 (graphics to VRAM
; $8500) and object 1 sprite $D6 (to $8600), and the object palettes are reloaded. (C1, E-0357)
SceneMermaidKingdom_LoadSprites::
    xor a
    ld [wSpriteSlots + $1], a
    ld a, $e3
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ld a, $00
    ldh [hTemp2], a
    ld a, $05
    ldh [hTemp3], a
    ld hl, vTiles0 + $500
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    xor a
    ld [wObject1 + OBJ_SET_MODE], a
    ld a, $d6
    ld [wObject1 + OBJ_SPRITE_ID], a
    ldh [hTemp0], a
    xor a
    ldh [hTemp1], a
    ld a, $00
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowKahahaha", ROMX

; Mermaid kingdom scene, step 12: the scene object rises two pixels a frame with a hop; then
; 'Kahahaha...' (message $086E). (C2, E-0357; probed E-0376)
SceneMermaidKingdom_ShowKahahaha::
    ld a, [wObject5 + SCRIPTOBJ_Y]
    dec a
    dec a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $086e ; '*: Kahahaha…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_WalkDown", ROMX

; Mermaid kingdom scene, step 11: walks objects 0 and 1 down to Y $50; then runs field command 8 and
; shows the scene object at ($40, $60). (C1, E-0357)
SceneMermaidKingdom_WalkDown::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $08
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $60
    ld a, a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowKamehaWhatIsThis", ROMX

; Mermaid kingdom scene, step 9: object 2 hops; then Kameha's 'What?! What is this?' (message
; $086D). (C2, E-0370; probed E-0376)
SceneMermaidKingdom_ShowKamehaWhatIsThis::
    ld de, wObject2 + OBJ_Y
    ld hl, $086d
    call ScriptStepDeltaThenMessage
    ret

SECTION "Bank 0F SceneMermaidKingdom_MoveObject2", ROMX

; Mermaid kingdom scene, step 8: object 2 moves right two pixels a frame up to X $80 while $3C
; frames pass. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_MoveObject2::
    ld a, [wObject2 + OBJ_X]
    cp $80
    jr z, .call_step_script_param0_counter_bank0_f
    inc a
    inc a
    ld [wObject2 + OBJ_X], a

.call_step_script_param0_counter_bank0_f:
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_MoveObject1", ROMX

; Mermaid kingdom scene, step 7: object 1 moves left one pixel every four frames to X $30, then
; right two pixels a frame to X $40; then sound $63. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_MoveObject1::
    ld a, [wScriptParam1]
    or a
    jr nz, .check_object1
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $30
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

.check_object1:
    ld a, [wObject1 + OBJ_X]
    inc a
    inc a
    ld [wObject1 + OBJ_X], a
    cp $40
    ret nz
    ld a, $63
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_WalkObject1", ROMX

; Mermaid kingdom scene, step 6: object 1 walks (two pixels a frame, facing its way) left to X $40,
; down to Y $50, right to X $60, up to Y $30, left to X $40 and down to Y $40; then faces right and
; stops, and object 2 becomes sprite $45 (FieldSpriteGfx45 to VRAM $8700). (C1, E-0357)
SceneMermaidKingdom_WalkObject1::
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_X]
    dec a
    dec a
    ld [wObject1 + OBJ_X], a
    cp $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .skip2
    ld a, $00
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_Y]
    inc a
    inc a
    ld [wObject1 + OBJ_Y], a
    cp $50
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip2:
    dec a
    jr nz, .skip3
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_X]
    inc a
    inc a
    ld [wObject1 + OBJ_X], a
    cp $60
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip3:
    dec a
    jr nz, .skip4
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_Y]
    dec a
    dec a
    ld [wObject1 + OBJ_Y], a
    cp $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.skip4:
    dec a
    jr nz, .set_object1_to_00
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_X]
    dec a
    dec a
    ld [wObject1 + OBJ_X], a
    cp $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_object1_to_00:
    ld a, $00
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_Y]
    inc a
    inc a
    ld [wObject1 + OBJ_Y], a
    cp $40
    ret nz
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld de, FieldSpriteGfx45
    ld b, BANK(FieldSpriteGfx45)
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, $45
    ld [wObject2 + OBJ_SPRITE_ID], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMermaidKingdom_ShowKamehaGaspHackI", ROMX

; Mermaid kingdom scene, step 4: walks objects 0-2 down (two pixels a frame) to Y $40; then redraws
; the columns beside the screen and Kameha says '...Gasp... ...Hack... I did it...' (message $086C).
; (C1, E-0357)
SceneMermaidKingdom_ShowKamehaGaspHackI::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    farcall RedrawColumnsBesideScreen
    ld hl, $086c ; 'Kameha: …Gasp… …Hack… I did it…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWallExit_GatherFollowers", ROMX

; Shared scene step (SceneWallExit steps 4-6, SceneReportToKing steps 9, 11 and 13, SceneSpiritEnvoy
; steps 7-9, SceneMermaidKingdom steps 1-3): runs ScriptStepMoveFollowersToLeader, which sets the
; follower targets from the leader on the first frame, then steps the followers until the
; wScriptParam0 counter reaches $11 and advances wScriptStep. (C2, E-0370; probed E-0376)
SceneWallExit_GatherFollowers::
    farcall ScriptStepMoveFollowersToLeader
    ret

SECTION "Bank 0F SceneMermaidKingdom_WalkPlayerLeftAndFaceDown", ROMX

; Mermaid kingdom scene, step 0: walks the player left to X $40 and turns it down; a player already
; at X $40 skips to step 4. (C2, E-0357; probed E-0376)
SceneMermaidKingdom_WalkPlayerLeftAndFaceDown::
    ldh a, [hPlayerX]
    cp $40
    jr nz, .set_step_ptr_lo_to_40
    ld a, $04
    ld [wScriptStep], a
    ret

.set_step_ptr_lo_to_40:
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees", ROMX

; Kameha flees scene, run each frame by ScriptCommand38 (script command type $38,
; SCRIPT_SCENE_KAMEHA_FLEES): jumps on wScriptStep through 13 steps: the followers gather while
; objects 0-2 are set moving (0-2), objects 0-2 move up and the player walks up behind them (3-7),
; they move up and left and the scene object drops (8-9), objects 0-2 hop while the screen shakes
; sideways (10), they walk off right (11), and the scene object bobs on to X $A0, which sets
; EVENT_SCENE_KAMEHA_FLEES and resumes the script (12). (C1, E-0376)
; implements script command type 38 (SCRIPT_SCENE_KAMEHA_FLEES): a cutscene step named after the
; scene its only script shows: 'Kameha Arrrrh, clear the way!' ... 'Kameha Aiyeeeeeh'; reached
; through ScriptCommand38 in bank $10 (E-0038, E-0245)
SceneKamehaFlees::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaFlees_Gather
    dw SceneKamehaFlees_Gather
    dw SceneKamehaFlees_Gather
    dw SceneKamehaFlees_Wait
    dw SceneKamehaFlees_MoveUp
    dw SceneKamehaFlees_WalkPlayerUp
    dw SceneKamehaFlees_KeepInStep
    dw SceneKamehaFlees_Wait
    dw SceneKamehaFlees_MoveObjectsUp
    dw SceneKamehaFlees_DropObject
    dw SceneKamehaFlees_ShakeAndHop
    dw SceneKamehaFlees_WalkRight
    dw SceneKamehaFlees_BobObjectOff

; Kameha flees scene, step 12: moves the scene object on (SceneKamehaFlees_BobObjectRight) until it
; reaches X $A0, which sets EVENT_SCENE_KAMEHA_FLEES and resumes the script. (C2, E-0370; probed
; E-0376)
SceneKamehaFlees_BobObjectOff::
    call SceneKamehaFlees_BobObjectRight
    ret

SECTION "Bank 0F SceneKamehaFlees_BobObjectRight", ROMX

; Moves the scene object right one pixel a frame, bobbing by the eight Y values of
; SceneKamehaFlees_BobObjectRight_Data; at X $A0 sets EVENT_SCENE_KAMEHA_FLEES and resumes the
; script. (C2, E-0357; probed E-0376)
SceneKamehaFlees_BobObjectRight::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    and $07
    ld [wScriptParam0], a
    ld hl, SceneKamehaFlees_BobObjectRight_Data
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, [wObject5 + SCRIPTOBJ_X]
    cp $a0
    ret nz
    ld de, EVENT_SCENE_KAMEHA_FLEES
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneKamehaFlees_BobObjectRight_Data", ROMX

; Eight Y positions for the scene object (SCRIPTOBJ_Y): 64, 63, 64, 63, 64, 62, 64, 65 ($40, $3F,
; $40, $3F, $40, $3E, $40, $41). SceneKamehaFlees_BobObjectRight advances wScriptParam0 by 1 each
; frame modulo 8, so the object bobs about the row of $40 while it moves right. (C1, E-0381)
SceneKamehaFlees_BobObjectRight_Data::
    db $40, $3f, $40, $3f, $40, $3e, $40, $41

; Kameha flees scene, step 11: moves the scene object as above while objects 0-2 walk right (two
; pixels a frame) to X $A0; then draws no sprite slots. (C2, E-0357; probed E-0376)
SceneKamehaFlees_WalkRight::
    call SceneKamehaFlees_BobObjectRight
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $a0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $a0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $a0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + OBJ_X]
    cp $a0
    ret nz
    xor a
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees_ShakeAndHop", ROMX

; Kameha flees scene, step 10: objects 0-2 hop while the screen shakes sideways (2 pixels every
; other frame) for $20 frames; then the scroll is rounded to a whole tile, sound $7D plays and every
; field sprite is shown again. (C2, E-0357; probed E-0376)
SceneKamehaFlees_ShakeAndHop::
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wFrameCounterLo]
    and $03
    bit 0, a
    jr nz, .call_step_script_param0_counter_bank0_f
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add c
    ldh [hScrollX], a

.call_step_script_param0_counter_bank0_f:
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add $07
    and $f8
    ldh [hScrollX], a
    ld a, $7d
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    xor a
    ldh [hFieldDrawFlags], a
    ret

SECTION "Bank 0F SceneKamehaFlees_DropObject", ROMX

; Kameha flees scene, step 9: the scene object falls two pixels a frame to Y $40; then redraws the
; columns beside the screen, plays sound $66 and hides the followers (hFieldDrawFlags $0E). (C1,
; E-0357)
SceneKamehaFlees_DropObject::
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    cp $40
    ret nz
    farcall RedrawColumnsBesideScreen
    ld a, $66
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ret

SECTION "Bank 0F SceneKamehaFlees_MoveObjectsUp", ROMX

; Kameha flees scene, step 8: objects 0-2 each move up two pixels a frame to Y $40, then left
; (facing left) until object 0 reaches X $40; then they stop, object 2 faces left, field command 7
; runs, the scene object is shown and sound $65 plays. (C1, E-0357)
SceneKamehaFlees_MoveObjectsUp::
    ld b, $03
    ld hl, wSpriteSlots + $c

.loop:
    push hl
    ld a, [hl]
    cp $40
    jr z, .next
    dec a
    dec a
    ld [hl], a
    jr .restore

.next:
    dec hl
    ld a, [hl]
    dec a
    dec a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $03

.restore:
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    ld a, [wSpriteSlots + $b]
    cp $40
    ret nz
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld a, $07
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $80
    ld [wObject5], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees_Wait", ROMX

; Kameha flees scene, steps 3 and 7: waits $3C frames, then sets flag bit 2 of objects 0-2 (moving)
; and moves on. (C2, E-0376)
SceneKamehaFlees_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees_KeepInStep", ROMX

; Kameha flees scene, step 6: keeps the followers in step for $1E frames, then restarts the player's
; animation (bit 1). (C2, E-0357; probed E-0376)
SceneKamehaFlees_KeepInStep::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $1e
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees_WalkPlayerUp", ROMX

; Kameha flees scene, step 5: walks the player up two pixels a frame (the followers following) to Y
; $30. (C2, E-0357; probed E-0376)
SceneKamehaFlees_WalkPlayerUp::
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp $30
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees_MoveUp", ROMX

; Kameha flees scene, step 4: the player faces down while objects 0-2 move up two pixels a frame
; until object 0 reaches Y $70; then they stop, the player's animation is frozen (bit 1) and sound
; $63 plays. (C2, E-0357; probed E-0376)
SceneKamehaFlees_MoveUp::
    xor a
    ldh [hPlayerFacing], a
    ld a, [wObject2 + OBJ_Y]
    dec a
    dec a
    ld [wObject2 + OBJ_Y], a
    ld a, [wObject1 + OBJ_Y]
    dec a
    dec a
    ld [wObject1 + OBJ_Y], a
    ld a, [wSpriteSlots + $c]
    dec a
    dec a
    ld [wSpriteSlots + $c], a
    cp $70
    ret nz
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank0F
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaFlees_Gather", ROMX

; Shared scene step (SceneKamehaFlees steps 0-2, SceneRivalDefeated steps 4-6): runs
; ScriptStepMoveFollowersToLeader (the follower targets are set from the leader on the first frame,
; then the followers step until the wScriptParam0 counter reaches $11 and wScriptStep advances) and
; sets flag bit 2 of objects 0-2 (moving) every frame. (C2, E-0376)
SceneKamehaFlees_Gather::
    farcall ScriptStepMoveFollowersToLeader
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ret

SECTION "Bank 0F SceneCrewFollows", ROMX

; Crew follows scene, run each frame by ScriptCommand37 (script command type $37,
; SCRIPT_SCENE_CREW_FOLLOWS): jumps on wScriptStep through 4 steps: 0 objects 0-2 move right until
; object 0 is at X $60, 1 a sideways screen shake ending with EVENT_SCENE_CREW_FOLLOWS_07D, bit 2 of
; story byte $62 and an in-place transition, 2 sets objects 0-2 moving, 3 turns them for $78 frames
; and resumes the script. (C1, E-0376)
; implements script command type 37 (SCRIPT_SCENE_CREW_FOLLOWS): a cutscene step named after the
; scene its only script shows: 'Aye, aye, sir! Right behind you!'; reached through ScriptCommand37
; in bank $10 (E-0038, E-0245)
SceneCrewFollows::
    ld a, [wScriptStep]
    jumptable
    dw SceneCrewFollows_MoveRight
    dw SceneCrewFollows_ShakeScreen
    dw SceneCrewFollows_StartMoving
    dw SceneCrewFollows_TurnObjects

; Crew follows scene, step 3: objects 0 and 2 face one way and object 1 the other, swapping between
; left and right every 16 frames, for $78 frames; then the script resumes. (C2, E-0357; probed
; E-0376)
SceneCrewFollows_TurnObjects::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    push af
    bit 4, a
    jr z, .set_sprite_slots_to_03
    ld a, $01
    jr .set_sprite_slots

.set_sprite_slots_to_03:
    ld a, $03

.set_sprite_slots:
    ld [wSpriteSlots + $7], a
    ld [wObject2 + OBJ_STATE], a
    inc a
    inc a
    and $03
    ld [wObject1 + OBJ_STATE], a
    pop af
    cp $78
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneCrewFollows_StartMoving", ROMX

; Crew follows scene, step 2: sets objects 0-2 moving and clears the counter. (C2, E-0357; probed
; E-0376)
SceneCrewFollows_StartMoving::
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneCrewFollows_ShakeScreen", ROMX

; Crew follows scene, step 1: shakes the screen sideways for $78 frames, rounds the scroll to a
; whole tile, sets EVENT_SCENE_CREW_FOLLOWS_07D and bit 2 of story byte $62, starts a transition in
; place (kind 0) with a fade and plays sound 0. (C1, E-0357)
SceneCrewFollows_ShakeScreen::
    ld a, [wFrameCounterLo]
    and $03
    bit 0, a
    jr nz, .call_step_script_param0_counter_bank0_f
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add c
    ldh [hScrollX], a

.call_step_script_param0_counter_bank0_f:
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add $07
    and $f8
    ldh [hScrollX], a
    ld de, EVENT_SCENE_CREW_FOLLOWS_07D
    call SetFlagBit
    ld a, [wStoryFlags + $62]
    set 2, a
    ld [wStoryFlags + $62], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    xor a
    ld [wFieldReturnPhase], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call QueueSoundEffect
    ret

SECTION "Bank 0F SceneCrewFollows_MoveRight", ROMX

; Crew follows scene, step 0: objects 0-2 move right two pixels a frame until object 0 reaches X
; $60; then they stop and sound $7D plays. (C2, E-0357; probed E-0376)
SceneCrewFollows_MoveRight::
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld b, $03
    ld hl, wSpriteSlots + $b

.loop:
    ld a, [hl]
    inc a
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    ld a, [wSpriteSlots + $b]
    cp $60
    ret nz
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld a, $7d
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaCaught", ROMX

; Kameha caught scene, run each frame by ScriptCommand36 (script command type $36,
; SCRIPT_SCENE_KAMEHA_CAUGHT): jumps on wScriptStep: step 0 (SceneKamehaCaught_StartMoving) sets
; flag bit 2 of objects 0-2, clears wScriptParam0 and moves on; step 1 (SceneKamehaCaught_MoveOff)
; moves them up two pixels a frame off the screen (Y $E0), then draws no sprite slots and resumes
; the script. (C2, E-0376)
; implements script command type 36 (SCRIPT_SCENE_KAMEHA_CAUGHT): a cutscene step named after the
; scene its only script shows: 'Kameha Wahahahah! Thanks for guiding me' ... 'Kameha Urk! How you
; catch up?'; reached through ScriptCommand36 in bank $10 (E-0038, E-0245)
SceneKamehaCaught::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaCaught_StartMoving
    dw SceneKamehaCaught_MoveOff

; Kameha caught scene, step 0: sets objects 0-2 moving and clears the counter. (C2, E-0357; probed
; E-0376)
SceneKamehaCaught_StartMoving::
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneKamehaCaught_MoveOff", ROMX

; Kameha caught scene, step 1: objects 0-2 move up two pixels a frame off the screen (Y $E0); then
; draws no sprite slots and resumes the script. (C2, E-0357; probed E-0376)
SceneKamehaCaught_MoveOff::
    ld b, $03
    ld hl, wSpriteSlots + $c

.loop:
    ld a, [hl]
    cp $e0
    jr z, .skip
    dec a
    dec a
    ld [hl], a

.skip:
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    ld a, [wObject2 + OBJ_Y]
    cp $e0
    ret nz
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F GiveItemBlink", ROMX

; Item-giving blink, run each frame by ScriptCommand32 (script command type $32,
; SCRIPT_GIVE_ITEM_BLINK): a one-entry jump table on wScriptStep whose only step is
; GiveItemBlink_BlinkAndGive: object 0 blinks out (at Y $40 when EVENT_GIVE_ITEM_BLINK is set, else
; at Y $20) and, when both EVENT_GIVE_ITEM_BLINK and EVENT_YOU_WILL_THANK_YOU_LET are set, item $33
; (ITEM_YUNASOUL) is added to the first empty inventory slot; then no sprite slots are drawn and the
; script resumes. (C2, E-0376)
; implements script command type 32 (SCRIPT_GIVE_ITEM_BLINK): adds item wStepPtrLo to the inventory
; (AppendItemStepPtrLoToInventory) and blinks object hTemp0; '0 obtained YunaSoul.'; reached through
; ScriptCommand32 in bank $10 (E-0038, E-0245)
GiveItemBlink::
    ld a, [wScriptStep]
    jumptable
    dw GiveItemBlink_BlinkAndGive

; Item-giving blink, step 0: with EVENT_GIVE_ITEM_BLINK set blinks object 0 (at Y $40) out and, when
; EVENT_YOU_WILL_THANK_YOU_LET is set, adds item $33 to the inventory; otherwise blinks object 0 (at
; Y $20) out. Then draws no sprite slots and resumes the script. (C2, E-0357; probed E-0376)
GiveItemBlink_BlinkAndGive::
    ld de, EVENT_GIVE_ITEM_BLINK
    call TestFlagBit
    jr c, .set_temp0_to_00
    ld a, $00
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_temp0_to_00:
    ld a, $00
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld de, EVENT_YOU_WILL_THANK_YOU_LET
    call TestFlagBit
    jr nc, .clear_sprite_slot_count
    ld a, $33
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory

.clear_sprite_slot_count:
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneWhoAreYou", ROMX

; Who are you scene, run each frame by ScriptCommand29 (script command type $29,
; SCRIPT_SCENE_WHO_ARE_YOU): jumps on wScriptStep through 10 steps: objects 0-2 move down to Y $40
; and message $0831, then message $0832 (0-2), object 0 hops and walks down for message $0833 of
; Kameha (3-5), object 0 walks into place and the player walks right to X $70 (6-8), and step 9
; keeps the followers in step, sets EVENT_SCENE_WHO_ARE_YOU and resumes the script. (C1, E-0376)
; implements script command type 29 (SCRIPT_SCENE_WHO_ARE_YOU): a cutscene step named after the
; scene its only script shows: after a sound and a 140-frame wait, before 'Who are you? This is
; our...' and 'Zzz Zzz Huh! Watch out!'; reached through ScriptCommand29 in bank $10 (E-0038,
; E-0246)
SceneWhoAreYou::
    ld a, [wScriptStep]
    jumptable
    dw SceneWhoAreYou_MoveDown
    dw SceneWhoAreYou_ShowTchMadeMeWaste
    dw SceneHomecoming_WaitMessage
    dw SceneWhoAreYou_HopObject0
    dw SceneWhoAreYou_ShowKamehaHeyYoureHero
    dw SceneHomecoming_WaitMessage
    dw SceneWhoAreYou_WalkObject0
    dw SceneWhoAreYou_MoveObject0
    dw SceneWhoAreYou_WalkPlayerRight
    dw SceneWhoAreYou_KeepInStep

; Who are you scene, step 9: keeps the followers in step for $1E frames, restarts the player's
; animation (bit 1), sets EVENT_SCENE_WHO_ARE_YOU and resumes the script. (C2, E-0357; probed
; E-0376)
SceneWhoAreYou_KeepInStep::
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $1e
    ret nz
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld de, EVENT_SCENE_WHO_ARE_YOU
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneWhoAreYou_WalkPlayerRight", ROMX

; Who are you scene, step 8: walks the player right two pixels a frame (the followers following) to
; X $70. (C2, E-0357; probed E-0376)
SceneWhoAreYou_WalkPlayerRight::
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp $70
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWhoAreYou_MoveObject0", ROMX

; Who are you scene, step 7: object 0 moves left one pixel every four frames to X $20, then right
; (two pixels a frame) to X $30; then freezes the player's animation (bit 1) and plays sound $63.
; (C2, E-0357; probed E-0376)
SceneWhoAreYou_MoveObject0::
    ld a, [wScriptParam1]
    or a
    jr nz, .set_step_ptr_hi_to_00
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $20
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

.set_step_ptr_hi_to_00:
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    ld a, $63
    call QueueSoundEffect
    xor a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWhoAreYou_WalkObject0", ROMX

; Who are you scene, step 6: walks object 0 left to X $30, then down to Y $70; then object 0 faces
; right and the player left. (C2, E-0357; probed E-0376)
SceneWhoAreYou_WalkObject0::
    ld a, [wSpriteSlots + $b]
    cp $30
    jr z, .set_step_ptr_hi_to_00
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.set_step_ptr_hi_to_00:
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWhoAreYou_ShowKamehaHeyYoureHero", ROMX

; Who are you scene, step 4: objects 1 and 2 face down; object 0 walks down to Y $60; then Kameha's
; 'Hey! You're <hero>, the farmer!' (message $0833). (C2, E-0357; probed E-0376)
SceneWhoAreYou_ShowKamehaHeyYoureHero::
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $0833 ; 'Kameha: Hey! You're 0, the farmer!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWhoAreYou_HopObject0", ROMX

; Who are you scene, step 3: object 0 hops, then the next step. (C2, E-0357; probed E-0376)
SceneWhoAreYou_HopObject0::
    ld de, wSpriteSlots + $c
    call ScriptStepDeltaThenNextStep
    ret

SECTION "Bank 0F SceneWhoAreYou_ShowTchMadeMeWaste", ROMX

; Who are you scene, step 1: after the box closes, object 1 faces right and message $0832 starts.
; (C1, E-0357)
SceneWhoAreYou_ShowTchMadeMeWaste::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, $0832 ; '*: Tch, made me waste my'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWhoAreYou_MoveDown", ROMX

; Who are you scene, step 0: objects 0-2 move down a pixel a frame (moving) until object 0 reaches Y
; $40; then they stop, object 2 faces left and 'Heh, that old man, he ...' (message $0831). (C2,
; E-0357; probed E-0376)
SceneWhoAreYou_MoveDown::
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wSpriteSlots + $c
    ld b, $03

.loop:
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, .loop
    ld a, [wSpriteSlots + $c]
    cp $40
    ret nz
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld hl, $0831 ; '*: Heh, that old man, he'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ShakeScreen", ROMX

; Script command $28 (SCRIPT_SHAKE_SCREEN), run each frame by ScriptCommand28 in bank $10 (far
; call): wScriptStep picks the step: 0 ShakeScreen_Start (redraws the columns beside the screen,
; sound $7D), 1 ShakeScreen_Shake (shakes the screen for $78 frames), 2 ShakeScreen_Finish (sound 0,
; then wScriptStartRequest = $80 resumes the script). (C1, E-0376)
; implements script command type 28 (SCRIPT_SHAKE_SCREEN): shakes the screen (ScriptStepShakeScreen)
; with a sound effect; reached through ScriptCommand28 in bank $10 (E-0038, E-0245)
ShakeScreen::
    ld a, [wScriptStep]
    jumptable
    dw ShakeScreen_Start
    dw ShakeScreen_Shake
    dw ShakeScreen_Finish

; Screen shake, step 0: redraws the columns beside the screen and plays sound $7D. (C1, E-0357)
ShakeScreen_Start::
    farcall RedrawColumnsBesideScreen
    ld a, $7d
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ShakeScreen_Shake", ROMX

; Screen shake, step 1: shakes the screen for $78 frames. (C2, E-0357; probed E-0376)
ShakeScreen_Shake::
    ld b, $78
    call ScriptStepShakeScreen
    ret

SECTION "Bank 0F ShakeScreen_Finish", ROMX

; Screen shake, step 2: plays sound 0 and resumes the script. (C2, E-0357; probed E-0376)
ShakeScreen_Finish::
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F ShakeScreenForStepCount", ROMX

; Shakes the screen for wStepPtrLo frames: puts the count in B and falls into ScriptStepShakeScreen.
; (C2, E-0357; probed E-0376)
ShakeScreenForStepCount::
    ld a, [wStepPtrLo]
    ld b, a

; B = frame count. Shakes the 16-bit horizontal scroll hScrollX/hScrollXHi by the frame counter:
; when wFrameCounterLo & 3 is 0 it subtracts 2, when it is 2 it adds 2, odd frames leave it. Then
; counts wScriptParam0 up (StepScriptParam0Counter_Bank0F with B); when the count reaches B the
; scroll is reset to 0 and wScriptStep += 1. Carry is clear on return either way (the xor that
; clears the scroll clears it). Used by ShakeScreen_Shake ($78 frames), ShakeScreenForStepCount
; (falls into it) and six other scene steps of this bank. (C2, E-0376)
; shakes hScrollX left and right with the frame counter until the wScriptParam0 counter expires,
; then resets the scroll and advances wScriptStep (E-0125)
ScriptStepShakeScreen::
    ld a, [wFrameCounterLo]
    and $03
    bit 0, a
    jr nz, .call_step_script_param0_counter_bank0_f
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
    jr .call_step_script_param0_counter_bank0_f

.read_scroll_x:
    ldh a, [hScrollX]
    add c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    adc $00
    ldh [hScrollXHi], a

.call_step_script_param0_counter_bank0_f:
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated", ROMX

; Script command $27 (SCRIPT_SCENE_RIVAL_DEFEATED), run each frame by ScriptCommand27 in bank $10
; (far call); wScriptStep picks one of 36 steps. In order: object 0 blinks out; objects walk up and
; the King speaks (messages $0199, $019A); sounds and the two pleas $019B and $019C; objects are
; placed and walk off; the King and the 'TidalBell' ($019D-$019F, the party count held at 2
; meanwhile); $01A0; a voice from nowhere ($01A1, $01A2); a warp to map 5 and Warubou ($0125); the
; shared boss-win sequence (BossWinScene); Warubou again ($0DC0); last SceneRivalDefeated_GiveKey,
; which resumes the script. Steps 2, 8, 11, 14, 18, 21, 23, 25, 27, 29 and 34 wait for the message
; box (SceneHomecoming_WaitMessage); steps 4-6 run SceneKamehaFlees_Gather. (C1, E-0376)
; implements script command type 27 (SCRIPT_SCENE_RIVAL_DEFEATED): a cutscene step named after the
; scene its only script shows: 'You defeated my monster? Urggh' ... 'You again! You're determined!';
; reached through ScriptCommand27 in bank $10 (E-0038, E-0245)
SceneRivalDefeated::
    ld a, [wScriptStep]
    jumptable
    dw SceneRivalDefeated_BlinkOut
    dw SceneRivalDefeated_ShowKingYouThievesTheres
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_WalkPlayerLeft
    dw SceneKamehaFlees_Gather
    dw SceneKamehaFlees_Gather
    dw SceneKamehaFlees_Gather
    dw SceneRivalDefeated_ShowKingSurrenderAndLive
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_PlaySounds
    dw SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_PlaySounds
    dw SceneRivalDefeated_Msg019C_UrgahMercyISurrender
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_PlaceObjects
    dw SceneRivalDefeated_WalkObjectsDown
    dw SceneRivalDefeated_ShowKingWahahWeveBagged
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_ShowObject5
    dw SceneRivalDefeated_ShowKingThisIsThe
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_ShowHeroObtainedTheTidalBell
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_Msg01A0_KingIveBeenA
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_ShowAVoiceEchoedFrom
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_Msg01A2_WaheyCanYouHear
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_ShowWarubouWaheyYouDid
    dw SceneRivalDefeated_PlayBossWin
    dw SceneRivalDefeated_ShowObject
    dw SceneRivalDefeated_ShowWarubouWaheyTheAbility
    dw SceneHomecoming_WaitMessage
    dw SceneRivalDefeated_GiveKey

; Rival defeated scene, step 35: sets EVENT_SCENE_RIVAL_DEFEATED_021, marks the key of kind 2
; (MarkKeyEntryKindTemp0Bit6), sets bit 1 of story byte $60 and wFarmLevel 1, and resumes the
; script. (C2, E-0357; probed E-0376)
SceneRivalDefeated_GiveKey::
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call SetFlagBit
    ld a, $02
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 1, a
    ld [wStoryFlags + $60], a
    ld a, $01
    ld [wFarmLevel], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowWarubouWaheyTheAbility", ROMX

; Rival defeated scene, step 33: the scene object falls one pixel a frame to the player's Y and is
; hidden; then Warubou's 'Wa-hey, the ability to cross ...' (message $0DC0) and
; EVENT_SCENE_RIVAL_DEFEATED. (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowWarubouWaheyTheAbility::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    cp c
    ret nz
    xor a
    ld [wObject5], a
    ld hl, $0dc0 ; 'Warubou: Wa-hey, the ability to cross'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_RIVAL_DEFEATED
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowObject", ROMX

; Rival defeated scene, step 32: object 0 faces away from the player, runs field command $11, shows
; the scene object 32 pixels above the player and plays sound $85. (C1, E-0357)
SceneRivalDefeated_ShowObject::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + SCRIPTOBJ_X], a
    ldh a, [hPlayerY]
    sub $20
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_PlayBossWin", ROMX

; Rival defeated scene, step 31: plays the shared boss-win sequence (BossWinScene, run by
; wScriptSubStep: sprites, flash, party heal, hops and shakes); its last sub-step advances
; wScriptStep. (C1, E-0370)
SceneRivalDefeated_PlayBossWin::
    farcall BossWinScene
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowWarubouWaheyYouDid", ROMX

; Rival defeated scene, step 30: warps to map 5, screen (1, 0) at ($50, $30) (transition kind 1)
; with a fade; Warubou's 'Wa-hey! You did it, <hero>!' (message $0125); clears the sub-step. (C1,
; E-0357)
SceneRivalDefeated_ShowWarubouWaheyYouDid::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0125 ; 'Warubou: Wa-hey! You did it, 0!'
    call StartMessageHL_B0F
    xor a
    ld [wScriptSubStep], a
    ret

SECTION "Bank 0F SceneRivalDefeated_Msg01A2_WaheyCanYouHear", ROMX

; Rival defeated scene, step 28: '...Wa-hey! Can you hear me?' (message $01A2). (C2, E-0357; probed
; E-0376)
SceneRivalDefeated_Msg01A2_WaheyCanYouHear::
    ld hl, $01a2 ; '*: …Wa-hey! Can you hear me?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowAVoiceEchoedFrom", ROMX

; Rival defeated scene, step 26: walks object 0 down to Y $A0; then draws no sprite slots and shows
; 'A voice echoed from nowhere...' (message $01A1). (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowAVoiceEchoedFrom::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $a0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld hl, $01a1 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_Msg01A0_KingIveBeenA", ROMX

; Rival defeated scene, step 24: the King's 'I've been a burden to ...' (message $01A0). (C2,
; E-0357; probed E-0376)
SceneRivalDefeated_Msg01A0_KingIveBeenA::
    ld hl, $01a0 ; 'King: I've been a burden to'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowHeroObtainedTheTidalBell", ROMX

; Rival defeated scene, step 22: the scene object moves left and down with a hop; then '<hero>
; obtained the TidalBell.' (message $019F), the object is hidden and put back at ($50, $30), and the
; party count is restored from wScriptTemp4. (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowHeroObtainedTheTidalBell::
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $019f ; '0 obtained the TidalBell.'
    call StartMessageHL_B0F
    xor a
    ld [wObject5], a
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowKingThisIsThe", ROMX

; Rival defeated scene, step 20: the scene object rises with a hop; then the King's 'This is the
; TidalBell. It's ...' (message $019E). (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowKingThisIsThe::
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $019e ; 'King: This is the TidalBell. It's'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowObject5", ROMX

; Rival defeated scene, step 19: shows the scene object at ($40, $20); saves the party count in
; wScriptTemp4 and lowers a count of 3 to 2 for the scene. (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowObject5::
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    cp $03
    jr nz, .done
    ld a, $02
    ld [wPartyCount], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowKingWahahWeveBagged", ROMX

; Rival defeated scene, step 17: walks object 0 down to Y $20; then the King's 'Wahah! We've bagged
; the lot!' (message $019D) and object 0 faces left. (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowKingWahahWeveBagged::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $019d ; 'King: Wahah! We've bagged the lot!'
    call StartMessageHL_B0F
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_WalkObjectsDown", ROMX

; Rival defeated scene, step 16: walks objects 0-3 down to Y $A0, off the screen; then one sprite
; slot, object 0 becomes sprite $22 (FieldSpriteGfx22 to VRAM $8500), hidden. (C1, E-0357)
SceneRivalDefeated_WalkObjectsDown::
    ld a, $00
    ld [wStepTarget], a
    ld a, $a0
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, FieldSpriteGfx22
    ld b, BANK(FieldSpriteGfx22)
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $22
    ld [wSpriteSlots + $2], a
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_PlaceObjects", ROMX

; Rival defeated scene, step 15: places the objects off the screen (object 0 at Y $D0, 1 at $C0, 2
; at $E0, 3 at $B0) and gives objects 0 and 1 sprite $27 (FieldSpriteGfx27 to VRAM $8500 and $8600).
; (C1, E-0357)
SceneRivalDefeated_PlaceObjects::
    ld a, $e0
    ld [wObject2 + OBJ_Y], a
    ld a, $b0
    ld [wObject3 + OBJ_Y], a
    ld a, $d0
    ld [wSpriteSlots + $c], a
    ld a, $c0
    ld [wObject1 + OBJ_Y], a
    ld de, FieldSpriteGfx27
    ld b, BANK(FieldSpriteGfx27)
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $27
    ld [wSpriteSlots + $2], a
    ld de, FieldSpriteGfx27
    ld b, BANK(FieldSpriteGfx27)
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld a, $27
    ld [wObject1 + OBJ_SPRITE_ID], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_Msg019C_UrgahMercyISurrender", ROMX

; Rival defeated scene, step 13: 'Urgah! Mercy! I surrender!' (message $019C). (C2, E-0357; probed
; E-0376)
SceneRivalDefeated_Msg019C_UrgahMercyISurrender::
    ld hl, $019c ; '*: Urgah! Mercy! I surrender!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss", ROMX

; Rival defeated scene, step 10: 'Aiyeeh! Help me, boss!' (message $019B). (C2, E-0357; probed
; E-0376)
SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss::
    ld hl, $019b ; '*: Aiyeeh! Help me, boss!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_PlaySounds", ROMX

; Rival defeated scene, step 9: plays sound $7C at once and $81 at frame $3C, and waits $78 frames.
; (C2, E-0357; probed E-0376)
SceneRivalDefeated_PlaySounds::
    ld a, [wScriptParam0]
    or a
    jr nz, .cp_3C
    ld a, $7c
    call QueueSoundEffect
    jr .check_script_param0

.cp_3C:
    cp $3c
    jr nz, .check_script_param0
    ld a, $81
    call QueueSoundEffect

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

SECTION "Bank 0F SceneRivalDefeated_ShowKingSurrenderAndLive", ROMX

; Rival defeated scene, step 7: walks objects 1-3 up off the screen; then the King's 'Surrender and
; live!' (message $019A). (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowKingSurrenderAndLive::
    ld a, $02
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $019a ; 'King: Surrender and live!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_WalkPlayerLeft", ROMX

; Rival defeated scene, step 3: walks the player left to X $30 and turns it right. (C2, E-0357;
; probed E-0376)
SceneRivalDefeated_WalkPlayerLeft::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_ShowKingYouThievesTheres", ROMX

; Rival defeated scene, step 1: walks objects 3, 2 and 1 up to Y $40; then the player faces down and
; the King says 'You thieves! There's no escape!' (message $0199). (C2, E-0357; probed E-0376)
SceneRivalDefeated_ShowKingYouThievesTheres::
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ldh [hPlayerFacing], a
    ld hl, $0199 ; 'King: You thieves! There's no escape!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneRivalDefeated_BlinkOut", ROMX

; Rival defeated scene, step 0: blinks object 0 (at Y $10) out; then sets bit 5 of story byte $61
; and EVENT_SCENE_RIVAL_DEFEATED_05A. (C2, E-0357; probed E-0376)
SceneRivalDefeated_BlinkOut::
    xor a
    ldh [hTemp0], a
    ld a, $10
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, [wStoryFlags + $61]
    set 5, a
    ld [wStoryFlags + $61], a
    ld de, EVENT_SCENE_RIVAL_DEFEATED_05A
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWaterShortage", ROMX

; Script command $23 (SCRIPT_SCENE_WATER_SHORTAGE), run each frame by ScriptCommand23 in bank $10;
; ScriptFetch23 sets bit 2 of story byte $61 when the command starts. wScriptStep picks: 0
; SceneWaterShortage_WalkPlayer (left to X $40, down to Y $80), 1 SceneWaterShortage_Warp (map $25),
; 2 SceneWaterShortage_WalkDown (the player and object 0 walk), 3 SceneWaterShortage_WalkAndWarp
; (map $2E), 4 SceneWaterShortage_Finish (resumes the script). It shows no message itself. (C1,
; E-0376)
; implements script command type 23 (SCRIPT_SCENE_WATER_SHORTAGE): a cutscene step named after the
; scene its only script shows: 'King The town's water shortage seems...' ... 'King Wha-what? What
; happened?'; reached through ScriptCommand23 in bank $10 (E-0038, E-0245)
SceneWaterShortage::
    ld a, [wScriptStep]
    jumptable
    dw SceneWaterShortage_WalkPlayer
    dw SceneWaterShortage_Warp
    dw SceneWaterShortage_WalkDown
    dw SceneWaterShortage_WalkAndWarp
    dw SceneWaterShortage_Finish

; Water shortage scene, step 4: resumes the script. (C2, E-0357; probed E-0376)
SceneWaterShortage_Finish::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneWaterShortage_WalkAndWarp", ROMX

; Water shortage scene, step 3: walks the player left to X $20; then warps to map $2E, screen (0, 0)
; at ($20, $60) (transition kind 1) with a fade and plays sound $60. (C1, E-0357)
SceneWaterShortage_WalkAndWarp::
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $2e
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $20
    ld [wWarpDestX], a
    ld a, $60
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

SECTION "Bank 0F SceneWaterShortage_WalkDown", ROMX

; Water shortage scene, step 2: the player walks down to Y $60, then left to X $30, while object 0
; walks down to Y $60, then left to X $20 (wScriptParam0's low and high nibbles track the two legs);
; when object 0 arrives it is hidden. (C2, E-0357; probed E-0376)
SceneWaterShortage_WalkDown::
    ld a, [wScriptParam0]
    and $0f
    jr nz, .set_step_ptr_lo_to_30
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    jr z, .set_step_ptr_hi_to_00
    ld hl, wScriptParam0
    inc [hl]
    jr .set_step_ptr_hi_to_00

.set_step_ptr_lo_to_30:
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo

.set_step_ptr_hi_to_00:
    ld a, $00
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    and $f0
    jr nz, .set_step_target_to_03
    ld a, $00
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, [wScriptParam0]
    or $10
    ld [wScriptParam0], a
    ret

.set_step_target_to_03:
    ld a, $03
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $e0
    ld [wSpriteSlots + $b], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWaterShortage_Warp", ROMX

; Water shortage scene, step 1: warps to map $25, screen (0, 0) at ($40, $08) (transition kind 1)
; with a fade and plays sound $60. (C1, E-0357)
SceneWaterShortage_Warp::
    ld a, $25
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $08
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

SECTION "Bank 0F SceneWaterShortage_WalkPlayer", ROMX

; Water shortage scene, step 0: walks the player left to X $40, then down to Y $80. (C2, E-0357;
; probed E-0376)
SceneWaterShortage_WalkPlayer::
    ldh a, [hPlayerX]
    cp $40
    jr z, .set_step_ptr_lo_to_80
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ret

.set_step_ptr_lo_to_80:
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMonsterInspection", ROMX

; Script command $1F (SCRIPT_SCENE_MONSTER_INSPECTION), run each frame by ScriptCommand1F in bank
; $10; wScriptStep picks one of 10 steps: 0 moves to map $25 with message $0151, 1 sound $6D after
; the box closes, 2 waits $B4 frames then message $0152, 3 waits for the box, 4 walks up and moves
; to map $26, 5 walks up to Y $40, 6 waits $B4 frames, 7 the followers perform (RunScriptSubStep), 8
; walks down and warps back to map $25, 9 plays the map music, sets bit 0 of story byte $61 and
; resumes the script. (C1, E-0376)
; implements script command type 1F (SCRIPT_SCENE_MONSTER_INSPECTION): a cutscene step named after
; the scene its only script shows: 'Ah, three healthy monsters! Very well' ... 'Very good show! That
; was splendid'; reached through ScriptCommand1F in bank $10 (E-0038, E-0245)
SceneMonsterInspection::
    ld a, [wScriptStep]
    jumptable
    dw SceneMonsterInspection_ShowAndThatWasThe
    dw SceneMonsterInspection_PlaySound
    dw SceneMonsterInspection_ShowNextMonstersWillPerform
    dw SceneHomecoming_WaitMessage
    dw SceneMonsterInspection_WalkUpAndWarp
    dw SceneMonsterInspection_WalkUp
    dw SceneMonsterInspection_Wait
    dw SceneMonsterInspection_FollowersPerform
    dw SceneMonsterInspection_WalkDownAndWarp
    dw SceneMonsterInspection_Finish

; Monster inspection scene, step 0: moves to map $25, screen (0, 0) at ($50, $30) (transition kind
; 3) with a fade; 'And that was the firebreather!' (message $0151). (C1, E-0357)
SceneMonsterInspection_ShowAndThatWasThe::
    ld a, $25
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0151 ; '*: And that was the firebreather!'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneMonsterInspection_PlaySound", ROMX

; Monster inspection scene, step 1: after the box closes, plays sound $6D. (C1, E-0357)
SceneMonsterInspection_PlaySound::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $6d
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMonsterInspection_ShowNextMonstersWillPerform", ROMX

; Monster inspection scene, step 2: waits $B4 frames, restarts the map music and shows 'Next,
; monsters will perform some ...' (message $0152). (C1, E-0357)
SceneMonsterInspection_ShowNextMonstersWillPerform::
    ld b, $b4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    ld hl, $0152 ; '*: Next, monsters will perform some'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMonsterInspection_WalkUpAndWarp", ROMX

; Monster inspection scene, step 4: walks the player up to Y 0; then moves to map $26, screen (0, 0)
; at ($50, $80) (transition kind 3) with a fade and plays sound $60. (C1, E-0357)
SceneMonsterInspection_WalkUpAndWarp::
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $26
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

SECTION "Bank 0F SceneMonsterInspection_WalkUp", ROMX

; Monster inspection scene, step 5: walks the player up to Y $40; then ends its fast animation (bit
; 2), faces it up and plays sound $6D. (C2, E-0357; probed E-0376)
SceneMonsterInspection_WalkUp::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $6d
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMonsterInspection_Wait", ROMX

; Monster inspection scene, step 6: waits $B4 frames, restarts the map music and clears the
; sub-step. (C1, E-0357)
SceneMonsterInspection_Wait::
    ld b, $b4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneMonsterInspection_FollowersPerform", ROMX

; Monster inspection scene, step 7 (step 6 cleared wScriptSubStep): runs the walking sub-steps
; (RunScriptSubStep, by wScriptSubStep: the followers catch up and spread out, object 5 hops, the
; followers run round the player, everyone faces down and stands, object 5 sinks, the followers
; return); the last sub-step advances wScriptStep. (C1, E-0370)
SceneMonsterInspection_FollowersPerform::
    farcall RunScriptSubStep
    ret

SECTION "Bank 0F SceneMonsterInspection_WalkDownAndWarp", ROMX

; Monster inspection scene, step 8: plays sound $6D on the first frame and walks the player down to
; Y $80; then warps to map $25, screen (1, 0) at ($30, $40) (transition kind 1) with a fade, music 2
; and sound $60. (C1, E-0357)
SceneMonsterInspection_WalkDownAndWarp::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_ptr_lo_to_80
    inc a
    ld [wScriptParam0], a
    ld a, $6d
    call QueueSoundEffect

.set_step_ptr_lo_to_80:
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $25
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $30
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $02
    call QueueMusic
    ld a, $60
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ret

SECTION "Bank 0F SceneMonsterInspection_Finish", ROMX

; Monster inspection scene, step 9: plays the map music, sets bit 0 of story byte $61 and resumes
; the script. (C1, E-0357)
SceneMonsterInspection_Finish::
    farcall PlayMapMusic
    ld a, [wStoryFlags + $61]
    or $01
    ld [wStoryFlags + $61], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneLongFaces", ROMX

; Script command $1D (SCRIPT_SCENE_LONG_FACES), run each frame by ScriptCommand1D in bank $10;
; ScriptFetch1D starts it with the question $0097 kept open (the Cobi line $008D behind
; EVENT_NEVER_SET). wScriptStep picks one of 13 steps: 0 waits for the box, 1 SceneLongFaces_Answer,
; 2 SceneLongFaces_AskAgain (back to step 1), 3 waits, 4 object 0 walks, 5 object 0 hops and Slash
; speaks ($0090), 6 waits, 7 object 0 walks, then $0091, 8 Tara ($009A), 9 the player hops, 10 Slash
; ($0093), 11 a fade with the party count set to 1 and EVENT_SCENE_LONG_FACES_002, 12 sets bit 0 of
; story byte $60 and resumes the script. (C1, E-0376)
; implements script command type 1D (SCRIPT_SCENE_LONG_FACES): a cutscene step named after the scene
; its only script shows: 'Slash Hey, why the long faces?'; reached through ScriptCommand1D in bank
; $10 (E-0038, E-0245)
SceneLongFaces::
    ld a, [wScriptStep]
    jumptable
    dw SceneHomecoming_WaitMessage
    dw SceneLongFaces_Answer
    dw SceneLongFaces_AskAgain
    dw SceneHomecoming_WaitMessage
    dw SceneLongFaces_WalkObject0
    dw SceneLongFaces_ShowSlashDontWorryIm
    dw SceneHomecoming_WaitMessage
    dw SceneLongFaces_ShowSlashAndHeroHas
    dw SceneLongFaces_ShowTaraThenItsYour
    dw SceneLongFaces_HopPlayer
    dw SceneLongFaces_ShowSlashThatsSettledThen
    dw SceneLongFaces_Fade
    dw SceneLongFaces_Finish

; Long faces scene, step 12: sets bit 0 of story byte $60 and resumes the script. (C2, E-0357;
; probed E-0376)
SceneLongFaces_Finish::
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneLongFaces_Fade", ROMX

; Long faces scene, step 11: after the box closes, starts a transition in place (kind 1) with a
; fade, sets the party count to 1 and EVENT_SCENE_LONG_FACES_002. (C1, E-0357)
SceneLongFaces_Fade::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wPartyCount], a
    ld de, EVENT_SCENE_LONG_FACES_002
    call SetFlagBit
    ret

SECTION "Bank 0F SceneLongFaces_ShowSlashThatsSettledThen", ROMX

; Long faces scene, step 10: after the box closes, Slash's 'That's settled, then! We'll leave ...'
; (message $0093). (C1, E-0357)
SceneLongFaces_ShowSlashThatsSettledThen::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0093 ; 'Slash: That's settled, then! We'll leave'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneLongFaces_HopPlayer", ROMX

; Long faces scene, step 9: the player hops (the first follower at the same height); then the player
; faces right and the follower left. (C2, E-0357; probed E-0376)
SceneLongFaces_HopPlayer::
    ld de, hPlayerY
    call ScriptApplyStepDeltaAtDE
    push af
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    pop af
    ret nc
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLongFaces_ShowTaraThenItsYour", ROMX

; Long faces scene, step 8: after the box closes, Tara's 'Then it's your job, <hero>!' (message
; $009A); Cobi's line $0092 is behind EVENT_NEVER_SET and never shown. (C1, E-0357)
SceneLongFaces_ShowTaraThenItsYour::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $009a ; 'Tara: Then it's your job, 0!'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $0092 ; 'Cobi: Fine, 0. It's up to'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneLongFaces_ShowSlashAndHeroHas", ROMX

; Long faces scene, step 7: walks object 0 left to X $70 and turns it down; then Slash's 'And <hero>
; has potential, I ...' (message $0091). (C2, E-0357; probed E-0376)
SceneLongFaces_ShowSlashAndHeroHas::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wSpriteSlots + $7], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0091 ; 'Slash: And 0 has potential, I'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneLongFaces_ShowSlashDontWorryIm", ROMX

; Long faces scene, step 5: object 0 hops for $20 frames; then the player and the first follower
; face up and Slash says 'Don't worry! I'm riding along!' (message $0090). (C2, E-0357; probed
; E-0376)
SceneLongFaces_ShowSlashDontWorryIm::
    ld de, wSpriteSlots + $c
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
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld hl, $0090 ; 'Slash: Don't worry! I'm riding along!'
    call StartMessageHL_B0F
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLongFaces_WalkObject0", ROMX

; Long faces scene, step 4: walks object 0 left to X $60, up to Y $40, then right to X $78, and
; turns it down. (C2, E-0357; probed E-0376)
SceneLongFaces_WalkObject0::
    ld a, [wScriptParam0]
    or a
    jr nz, .check_sprite_slots
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.check_sprite_slots:
    ld a, [wSpriteSlots + $c]
    cp $40
    jr z, .set_step_ptr_hi_to_00
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.set_step_ptr_hi_to_00:
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $78
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wSpriteSlots + $7], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLongFaces_AskAgain", ROMX

; Long faces scene, step 2: after the box closes, moves the message number back one and returns to
; step 1 to ask again. (C1, E-0357)
SceneLongFaces_AskAgain::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    dec hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    dec [hl]
    ret

SECTION "Bank 0F SceneLongFaces_Answer", ROMX

; Long faces scene, step 1: the answer to the question in wMessageIndex/wMessageGroup: the first
; choice shows the message two after it in the open box and skips to step 3; another shows the next
; one in the open box, kept open, and goes on to step 2 (the flags are written back into
; wMessageGroup). (C2, E-0357; probed E-0376)
SceneLongFaces_Answer::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .read_message_index
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld h, $80
    inc hl
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

.read_message_index:
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld h, $c0
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneWarubouWarning", ROMX

; Script command $1C (SCRIPT_SCENE_WARUBOU_WARNING), run each frame by ScriptCommand1C in bank $10;
; ScriptFetch1C starts it with the first follower facing away from the player and message $0088 (the
; Cobi line $0087 behind EVENT_NEVER_SET). wScriptStep picks: 0 after the box closes moves to map 6,
; 1 the follower walks right and Tara asks ($0094, kept open), 2 waits for the box, 3
; SceneWarubouWarning_Answer, 4 waits for the box and resumes the script
; (PersonalityMessage_WaitForMessage). (C1, E-0376)
; implements script command type 1C (SCRIPT_SCENE_WARUBOU_WARNING): a cutscene step named after the
; scene its only script shows: 'Warubou Dangerous are other worlds!' ... 'Slash Hey, why the long
; faces?'; reached through ScriptCommand1C in bank $10 (E-0038, E-0245)
SceneWarubouWarning::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouWarning_Warp
    dw SceneWarubouWarning_ShowTaraIfWeDont
    dw SceneHomecoming_WaitMessage
    dw SceneWarubouWarning_Answer
    dw PersonalityMessage_WaitForMessage

; Warubou warning scene, step 3: wScriptStep += 1 first; then answers the question in
; wMessageIndex/wMessageGroup ($0094 or $0089, kept open): the first choice (wTextYesNoResult 0)
; starts the next message, another the one after that. Both add $40 to the group byte, which turns
; MSG_KEEP_OPEN into MSG_ALREADY_OPEN, so the answer shows in the box that is already open and the
; box closes after it. (C2, E-0376)
SceneWarubouWarning_Answer::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .read_message_index
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $40
    ld h, a
    inc hl
    call StartMessageHL_B0F
    ret

.read_message_index:
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $40
    ld h, a
    inc hl
    inc hl
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneWarubouWarning_ShowTaraIfWeDont", ROMX

; Warubou warning scene, step 1: the first follower faces right and walks right one pixel a frame to
; X $80; then the player faces right, the follower left, and Tara says 'If we don't go find ...'
; (message $0094, kept open); Cobi's line $0089 is behind EVENT_NEVER_SET. (C2, E-0357; probed
; E-0376)
SceneWarubouWarning_ShowTaraIfWeDont::
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    inc a
    ld [wFollowerRecords + $1], a
    cp $80
    ret nz
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, MSG_KEEP_OPEN | $0094 ; 'Tara: If we don't go find'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, MSG_KEEP_OPEN | $0089 ; 'Cobi: If we don't find a'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneWarubouWarning_Warp", ROMX

; Warubou warning scene, step 0: after the box closes, warps to map 6, screen (0, 0) at ($70, $50)
; (transition kind 2) with a fade. (C1, E-0357)
SceneWarubouWarning_Warp::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $06
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $70
    ld [wWarpDestX], a
    ld a, $50
    ld [wWarpDestY], a
    ld a, $02
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneLandHo", ROMX

; Script command $77 (SCRIPT_SCENE_LAND_HO), run each frame by ScriptCommand77 in bank $10;
; wScriptStep picks one of 15 steps: 0 moves to map $1C with the player off the screen, 1 waits $3C
; frames and loads the map screen above, 2 object 0 rises to Y $50, 3-8 SceneLandHo_ScrollUp six
; times, 9-10 the row-by-row scroll (SceneLandHo_PrepareScrollRows, SceneLandHo_ScrollRows), 11
; waits $78 frames then message $0014, 12 waits for the box, 13 warps to map 0 and sets
; EVENT_SCENE_LAND_HO, 14 starts talk event $0A of group 2 (DispatchTalkEvent). (C1, E-0376)
; implements script command type 77 (SCRIPT_SCENE_LAND_HO): a cutscene step named after the scene
; its only script shows: 'Land ho! There's GreatLog!'; reached through ScriptCommand77 in bank $10
; (E-0038, E-0245)
SceneLandHo::
    ld a, [wScriptStep]
    jumptable
    dw SceneLandHo_Warp
    dw SceneLandHo_Wait
    dw SceneLandHo_RaiseObject
    dw SceneLandHo_ScrollUp
    dw SceneLandHo_ScrollUp
    dw SceneLandHo_ScrollUp
    dw SceneLandHo_ScrollUp
    dw SceneLandHo_ScrollUp
    dw SceneLandHo_ScrollUp
    dw SceneLandHo_PrepareScrollRows
    dw SceneLandHo_ScrollRows
    dw SceneLandHo_ShowThisIsATale
    dw SceneHomecoming_WaitMessage
    dw SceneLandHo_WarpHome
    dw SceneLandHo_StartTalk

; Land ho scene, step 14: starts talk event $0A of group 2 (DispatchTalkEvent). (C1, E-0357)
SceneLandHo_StartTalk::
    ld a, $0a
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    ret

SECTION "Bank 0F SceneLandHo_WarpHome", ROMX

; Land ho scene, step 13: warps to map 0, screen (1, 2) at ($50, $50) (transition kind 1) with a
; fade; sets EVENT_SCENE_LAND_HO, player sprite mode 1, and clears wMessageIndex/wMessageGroup. (C1,
; E-0357)
SceneLandHo_WarpHome::
    ld a, $00
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld de, EVENT_SCENE_LAND_HO
    call SetFlagBit
    ld a, $01
    ldh [hPlayerSpriteMode], a
    xor a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ret

SECTION "Bank 0F SceneLandHo_ShowThisIsATale", ROMX

; Land ho scene, step 11: waits $78 frames, then 'This is a tale of children ...' (message $0014).
; (C2, E-0357; probed E-0376)
SceneLandHo_ShowThisIsATale::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, $0014 ; 'This is a tale of children'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLandHo_ScrollRows", ROMX

; Land ho scene, step 10: every four frames scrolls up one pixel and copies a 20-tile row of
; wScreenTileBuffer (row $11 - wFieldActionStep / 8) into the background row above the screen; after
; $90 steps aligns the scroll to a whole tile. (C2, E-0357; probed E-0376)
SceneLandHo_ScrollRows::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
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
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    sub $20
    ld e, a
    ld a, d
    sbc $00
    ld d, a
    ld a, d
    cp $97
    jr nz, .read_field_action_step
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $04
    ld d, a

.read_field_action_step:
    ld a, [wFieldActionStep]
    srl a
    srl a
    srl a
    ld c, a
    ld a, $11
    sub c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    call QueueBGMapRow
    ldh a, [hScrollY]
    sub $01
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp $90
    jr nc, .check_scroll_y
    ret

.check_scroll_y:
    ldh a, [hScrollY]
    and $f8
    ldh [hScrollY], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F QueueBGMapRow", ROMX

; Queues a 20-tile background row write at DE from HL (wBGWriteData) and, on the GBC, its attributes
; from WRAM bank 2 at HL + $0E68 (low three bits, the palette). (C2, E-0357; probed E-0376)
QueueBGMapRow::
    ld a, e
    ld [wBGWriteDestLo], a
    ld a, d
    ld [wBGWriteDestHi], a
    xor a
    ld [wBGWriteVertical], a
    ld a, $14
    ld [wBGWriteCount], a
    push hl
    push de
    ld b, $14
    ld de, wBGWriteData

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, e
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $00
    ld [wAttrWriteVertical], a
    ld a, $14
    ld [wAttrWriteCount], a
    ld de, $0e68
    add hl, de
    ld b, $14
    ld de, wAttrWriteData

.loop2:
    ld a, $02
    ldh [rSVBK], a
    ld a, [hli]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ret

SECTION "Bank 0F SceneLandHo_PrepareScrollRows", ROMX

; Land ho scene, step 9: clears wFieldActionStep, which step 10 (SceneLandHo_ScrollRows) uses as its
; row counter up to $90, and moves on. (C2, E-0370; probed E-0376)
SceneLandHo_PrepareScrollRows::
    xor a
    ld [wFieldActionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLandHo_ScrollUp", ROMX

; Land ho scene, steps 3-8: counts wScriptParam0 up each frame; every fourth frame scrolls the view
; up one pixel (hScrollY - 1, then ComputeSpriteScrollOffsets); on the 16th such frame
; (wScriptParam0 = $40) it instead clears wScriptParam0, hScrollY and hScrollYHi and advances
; wScriptStep: 15 one-pixel steps, then the scroll snaps back to 0. (C2, E-0376)
SceneLandHo_ScrollUp::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wScriptParam0]
    srl a
    srl a
    cp $10
    jr z, .clear_script_param0
    ld hl, hScrollY
    dec [hl]
    call ComputeSpriteScrollOffsets
    ret

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    call ComputeSpriteScrollOffsets
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLandHo_RaiseObject", ROMX

; Land ho scene, step 2: object 0 (moving) rises one pixel every four frames to Y $50. (C2, E-0357;
; probed E-0376)
SceneLandHo_RaiseObject::
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld a, [wSpriteSlots + $c]
    dec a
    ld [wSpriteSlots + $c], a
    cp $50
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLandHo_Wait", ROMX

; Land ho scene, step 1: waits $3C frames, then loads the map screen above (LoadMapScreen). (C1,
; E-0357)
SceneLandHo_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, hMapScreenY
    dec [hl]
    call LoadMapScreen
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneLandHo_Warp", ROMX

; Land ho scene, step 0: moves to map $1C, screen (0, 1), the player off the screen at ($E0, 0)
; (transition kind 3), with a fade. (C1, E-0357)
SceneLandHo_Warp::
    ld a, $1c
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $e0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SECTION "Bank 0F SceneIslandSinking", ROMX

; Script command $76 (no script command constant names it), run each frame by ScriptCommand76 in
; bank $10; wScriptStep picks: 0 and 1 SceneIslandSinking_ShowTheIslandIsSinking (object 3 hops,
; then message $0076 'The island is sinking? Hahah, no worries!' when EVENT_IN_THE_MIDDLE_OF_THE is
; set, otherwise message $0078), 2 waits for the box, 3 ScriptCommand76_Run_PlaceFollower (sound
; $76, EVENT_SCENE_LAND_HO, the first follower placed, script resumed). Because steps 0 and 1 run
; the same routine, object 3 hops twice and the message is started twice before step 2 runs the box.
; (C1, E-0376)
; implements script command type 76; reached through ScriptCommand76 in bank $10 (E-0038)
SceneIslandSinking::
    ld a, [wScriptStep]
    jumptable
    dw SceneIslandSinking_ShowTheIslandIsSinking
    dw SceneIslandSinking_ShowTheIslandIsSinking
    dw SceneHomecoming_WaitMessage
    dw ScriptCommand76_Run_PlaceFollower

; Script command $76, step 3: plays sound $76, sets EVENT_SCENE_LAND_HO, puts the first follower
; facing left at ($60, $50), hides object 3 and resumes the script. (C2, E-0357; probed E-0376)
ScriptCommand76_Run_PlaceFollower::
    ld a, $76
    call QueueSoundEffect
    ld de, EVENT_SCENE_LAND_HO
    call SetFlagBit
    ld a, $03
    ld [wFollowerRecords], a
    ld a, $60
    ld [wFollowerRecords + $1], a
    ld a, $50
    ld [wFollowerRecords + $2], a
    ld a, $e0
    ld [wObject3 + OBJ_Y], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneIslandSinking_ShowTheIslandIsSinking", ROMX

; Script command $76, step 0: object 3 hops; then 'The island is sinking? Hahah, ...' (message
; $0076) with EVENT_IN_THE_MIDDLE_OF_THE set, otherwise 'It's pointless if you're dead.' (message
; $0078). (C2, E-0357; probed E-0376)
SceneIslandSinking_ShowTheIslandIsSinking::
    ld de, wObject3 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_IN_THE_MIDDLE_OF_THE
    call TestFlagBit
    jr nc, .call_start_message_hl_b0_f
    ld hl, $0076 ; '*: The island is sinking? Hahah,'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $0078 ; '*: It's pointless if you're dead.'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneAtSea", ROMX

; Script command $75 (SCRIPT_SCENE_AT_SEA), run each frame by ScriptCommand75 in bank $10;
; wScriptStep picks: 0 moves to map $1D with player sprite mode 1, 1 waits $5A frames, 2 object 3
; moves down to Y $30 and faces left, 3 object 3 hops left and down, then the script resumes. (C1,
; E-0376)
; implements script command type 75 (SCRIPT_SCENE_AT_SEA): a cutscene step named after the scene its
; only script shows: after 'In the middle of the sea'; reached through ScriptCommand75 in bank $10
; (E-0038, E-0245)
SceneAtSea::
    ld a, [wScriptStep]
    jumptable
    dw SceneAtSea_Warp
    dw SceneAtSea_Wait
    dw SceneAtSea_MoveObject3Down
    dw SceneAtSea_MoveObject3

; At sea scene, step 3: object 3 moves left and down a pixel a frame with a hop; then the script
; resumes. (C2, E-0357; probed E-0376)
SceneAtSea_MoveObject3::
    ld hl, wObject3 + OBJ_X
    dec [hl]
    ld hl, wObject3 + OBJ_Y
    inc [hl]
    ld de, wObject3 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneAtSea_MoveObject3Down", ROMX

; At sea scene, step 2: object 3 moves down two pixels a frame to Y $30 and faces left. (C2, E-0357;
; probed E-0376)
SceneAtSea_MoveObject3Down::
    ld a, [wObject3 + OBJ_Y]
    inc a
    inc a
    ld [wObject3 + OBJ_Y], a
    cp $30
    ret nz
    ld a, $03
    ld [wObject3 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneAtSea_Wait", ROMX

; At sea scene, step 1: waits $5A frames. (C2, E-0357; probed E-0376)
SceneAtSea_Wait::
    ld b, $5a
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneAtSea_Warp", ROMX

; At sea scene, step 0: moves to map $1D, screen (1, 0) at ($50, $40) (transition kind 2) with a
; fade and sets player sprite mode 1. (C1, E-0357)
SceneAtSea_Warp::
    ld a, $1d
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $02
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ldh [hPlayerSpriteMode], a
    ret

SECTION "Bank 0F SceneVaultSettled", ROMX

; Script command $6B (SCRIPT_SCENE_VAULT_SETTLED), run each frame by ScriptCommand6B in bank $10;
; wScriptStep picks: 0 the first follower takes the facing of the player and hops, 1 Tara speaks
; ($0021; the Cobi line $001F behind EVENT_NEVER_SET), 2 waits for the box and resumes the script
; (PersonalityMessage_WaitForMessage). (C1, E-0376)
; implements script command type 6B (SCRIPT_SCENE_VAULT_SETTLED): a cutscene step named after the
; scene its only script shows: 'You've come at the right...' ... 'Good, that's settled then. The
; Vault...'; reached through ScriptCommand6B in bank $10 (E-0038, E-0245)
SceneVaultSettled::
    ld a, [wScriptStep]
    jumptable
    dw SceneVaultSettled_HopFollower
    dw SceneVaultSettled_ShowTaraWellBeOK
    dw PersonalityMessage_WaitForMessage

; Vault settled scene, step 1: Tara's 'We'll be OK! I'm going ...' (message $0021); Cobi's line
; $001F is behind EVENT_NEVER_SET. (C2, E-0357; probed E-0376)
SceneVaultSettled_ShowTaraWellBeOK::
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $0021 ; 'Tara: We'll be OK! I'm going'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $001f ; 'Cobi: Sure, Mama! We'll be fine.'
    call StartMessageHL_B0F
    ret

SECTION "Bank 0F SceneVaultSettled_HopFollower", ROMX

; Vault settled scene, step 0: the first follower faces the player's way and hops. (C2, E-0357;
; probed E-0376)
SceneVaultSettled_HopFollower::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHorsingAround", ROMX

; Script command $6A (SCRIPT_SCENE_HORSING_AROUND), run each frame by ScriptCommand6A in bank $10;
; wScriptStep picks: 0 the player walks its loop for $140 frames, 1 object 0 walks down to Y $50 and
; faces right, 2 $20 more frames, 3 object 0 hops, then the script resumes. Every step first moves
; the player two pixels along its six-leg loop (SceneHorsingAround_StepPlayerAlongLoop). (C2,
; E-0376)
; implements script command type 6A (SCRIPT_SCENE_HORSING_AROUND): a cutscene step named after the
; scene its only script shows: before 'Listen you two! Quit your horsing...'; reached through
; ScriptCommand6A in bank $10 (E-0038, E-0245)
SceneHorsingAround::
    ld a, [wScriptStep]
    jumptable
    dw SceneHorsingAround_WalkLoop
    dw SceneHorsingAround_WalkObject0
    dw SceneHorsingAround_WalkLoopMore
    dw SceneHorsingAround_HopObject0

; Horsing around scene, step 3: the player keeps walking its loop while object 0 hops; then the fast
; animation ends (bit 2) and the script resumes. (C2, E-0357; probed E-0376)
SceneHorsingAround_HopObject0::
    call SceneHorsingAround_StepPlayerAlongLoop
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F SceneHorsingAround_WalkLoopMore", ROMX

; Horsing around scene, step 2: the player keeps walking its loop for $20 frames (counted in
; wMessageIndex). (C2, E-0357; probed E-0376)
SceneHorsingAround_WalkLoopMore::
    call SceneHorsingAround_StepPlayerAlongLoop
    ld a, [wMessageIndex]
    inc a
    ld [wMessageIndex], a
    cp $20
    ret nz
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHorsingAround_WalkObject0", ROMX

; Horsing around scene, step 1: the player keeps walking its loop while object 0 walks down to Y
; $50; then object 0 faces right. (C2, E-0357; probed E-0376)
SceneHorsingAround_WalkObject0::
    call SceneHorsingAround_StepPlayerAlongLoop
    ld a, $00
    ld [wStepTarget], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHorsingAround_WalkLoop", ROMX

; Horsing around scene, step 0: the player walks its loop for $140 frames (counted in
; wMessageIndex/wMessageGroup). (C2, E-0357; probed E-0376)
SceneHorsingAround_WalkLoop::
    call SceneHorsingAround_StepPlayerAlongLoop
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, h
    cp $01
    ret nz
    ld a, l
    cp $40
    ret nz
    xor a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F SceneHorsingAround_StepPlayerAlongLoop", ROMX

; Walks the player two pixels a frame around a six-leg loop (left to X $40, down to Y $80, right to
; X $80, up to Y $60, left to X $70, up to Y $50), going on to the next leg (wScriptParam1, wrapping
; after 5) on each arrival. (C2, E-0357; probed E-0376)
SceneHorsingAround_StepPlayerAlongLoop::
    ld a, [wScriptParam1]
    or a
    jr nz, .skip
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    farcall StepPlayerLeftTowardStepPtrLo
    jr .check_step_arrived

.skip:
    dec a
    jr nz, .skip2
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    farcall StepPlayerDownTowardStepPtrLo
    jr .check_step_arrived

.skip2:
    dec a
    jr nz, .skip3
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardStepPtrLo
    farcall StepPlayerRightTowardStepPtrLo
    jr .check_step_arrived

.skip3:
    dec a
    jr nz, .skip4
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    farcall StepPlayerUpTowardStepPtrLo
    jr .check_step_arrived

.skip4:
    dec a
    jr nz, .set_step_ptr_lo_to_50
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    farcall StepPlayerLeftTowardStepPtrLo
    jr .check_step_arrived

.set_step_ptr_lo_to_50:
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    farcall StepPlayerUpTowardStepPtrLo

.check_step_arrived:
    ld a, [wStepArrived]
    or a
    ret z
    ld a, [wScriptParam1]
    inc a
    cp $06
    jr nz, .set_script_param1
    xor a

.set_script_param1:
    ld [wScriptParam1], a
    ret

SECTION "Bank 0F StepScriptParam0Counter_Bank0F", ROMX

; B = limit: wScriptParam0 += 1; when it then equals B it is reset to 0 and carry is set, otherwise
; carry is clear (Z set). A = 0 either way. The frame counter behind the timed waits of this bank (B
; = $78, $B4, $5A, ...); the same 18 bytes appear in 3 banks. (C2, E-0376)
; wScriptParam0 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear;
; returns A = 0 either way (the same 18 bytes appear in 3 banks)
StepScriptParam0Counter_Bank0F::
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

SECTION "Bank 0F SetBit1AtHL_Bank0F", ROMX

; [HL] |= $02 (sets bit 1, which stops the animation counter in OBJ_FLAGS and hPlayerStateFlags); A
; = the new byte. Callers pass wObject2 + OBJ_FLAGS or hPlayerStateFlags; the same 5 bytes appear in
; 4 banks. (C2, E-0376)
; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
SetBit1AtHL_Bank0F::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

SECTION "Bank 0F ClearBit1AtHL_Bank0F", ROMX

; [HL] &= $FD (clears bit 1, letting the animation counter run again); A = the new byte. Callers
; pass wObject2 + OBJ_FLAGS or hPlayerStateFlags; the same 5 bytes appear in 4 banks. (C2, E-0376)
; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit1AtHL_Bank0F::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

SECTION "Bank 0F SetBit2AtHL_B0F", ROMX

; [HL] |= $04 (sets bit 2, the moving bit of OBJ_FLAGS and hPlayerStateFlags); A = the new byte.
; Callers pass wSpriteSlots + $D, wObject1/wObject2 + OBJ_FLAGS or hPlayerStateFlags. (C2, E-0376)
; sets bit 2 of the byte at [HL]; only A is clobbered
SetBit2AtHL_B0F::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

SECTION "Bank 0F ClearBit2AtHL_Bank0F", ROMX

; [HL] &= $FB (clears bit 2, the moving bit); A = the new byte. Callers pass wSpriteSlots + $D,
; wObject1/wObject2 + OBJ_FLAGS or hPlayerStateFlags; the same 5 bytes appear in 4 banks. (C2,
; E-0376)
; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit2AtHL_Bank0F::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

SECTION "Bank 0F UpdateFollowersOnStep_Bank0F", ROMX

; A = the moving coordinate of the player (hPlayerX or hPlayerY at every caller): when A & $0F is 0
; (a 16-pixel boundary) it first far-calls SetFollowerTargetsFromLeader (each follower targets the
; position of the one ahead); then always far-calls StepFollowersTowardTargets. The same 17 bytes
; appear in 3 banks. (C2, E-0376)
; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls
; SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same
; 17 bytes appear in 3 banks)
UpdateFollowersOnStep_Bank0F::
    and $0f
    jr nz, .call_step_followers_toward_targets
    farcall SetFollowerTargetsFromLeader

.call_step_followers_toward_targets:
    farcall StepFollowersTowardTargets
    ret

SECTION "Bank 0F ScriptApplyStepDeltaAtDE", ROMX

; DE = address of a coordinate byte: stores DE in wStepPtrLo/wStepPtrHi and adds the step delta for
; wScriptParam0 (AddStepDeltaToPointedByte: entry wScriptParam0 / 2 of a 16-byte table that sums to
; 0, a hop up and back down); then wScriptParam0 += 2; when it reaches $20 it is reset to 0 and
; carry is set, otherwise A = 0 and carry clear. So a hop takes 16 calls; scene steps call it each
; frame with an object, follower or player Y. (C2, E-0376)
; DE = address of a byte: adds the step delta for wScriptParam0 (AddStepDeltaToPointedByte), then
; wScriptParam0 += 2; when it reaches $20 it is reset to 0 and carry is set, otherwise A = 0 and
; carry is clear (16 calls per move) (E-0062)
ScriptApplyStepDeltaAtDE::
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

SECTION "Bank 0F ScriptStepDeltaThenNextStep", ROMX

; DE = address of a coordinate byte: adds the step delta for wScriptParam0
; (AddStepDeltaToPointedByte through wStepPtrLo/wStepPtrHi), then counts wScriptParam0 up by one
; (StepScriptParam0Counter_Bank0F with B = $20), so each delta is used twice and the hop takes 32
; frames; when the counter wraps, wScriptStep += 1. (C2, E-0376)
; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wStepPtrLo/wStepPtrHi)
; and counts wScriptParam0 up (StepScriptParam0Counter_Bank0F with B = $20); when the counter wraps,
; wScriptStep += 1 (E-0117)
ScriptStepDeltaThenNextStep::
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScriptStepDeltaThenMessage", ROMX

; DE = address of a coordinate byte, HL = message word: the same 32-frame hop as
; ScriptStepDeltaThenNextStep (AddStepDeltaToPointedByte, StepScriptParam0Counter_Bank0F with B =
; $20); when the counter wraps it starts message HL (StartMessageHL_B0F) and wScriptStep += 1. (C2,
; E-0376)
; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wStepPtrLo/wStepPtrHi)
; and counts wScriptParam0 up (StepScriptParam0Counter_Bank0F with B = $20); when the counter wraps,
; StartMessageHL_B0F with the caller's HL and wScriptStep += 1 (E-0117)
ScriptStepDeltaThenMessage::
    push hl
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    pop hl
    ret nc
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F ScriptStepDeltaThenRequestFetch", ROMX

; DE = address of a coordinate byte: the same 32-frame hop as ScriptStepDeltaThenNextStep
; (AddStepDeltaToPointedByte, StepScriptParam0Counter_Bank0F with B = $20); when the counter wraps,
; wScriptStartRequest = $80 (the script fetches its next command). No caller in src/ names it. (C2,
; E-0376)
; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wStepPtrLo/wStepPtrHi)
; and counts wScriptParam0 up (StepScriptParam0Counter_Bank0F with B = $20); when the counter wraps,
; wScriptStartRequest = $80 (E-0117)
ScriptStepDeltaThenRequestFetch::
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 0F RotateDirectionAtDEEvery32_Bank0F", ROMX

; DE = address of a direction byte: when wScriptParam0 & $1F is 0, [DE] = ([DE] + 1) & 3, the next
; of four directions, and A = that; otherwise returns at once with A = wScriptParam0 & $1F. It does
; not change wScriptParam0. No caller in this bank names it; the copies in banks $73 and $85 are
; called. (C2, E-0376)
; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise
; returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
RotateDirectionAtDEEvery32_Bank0F::
    ld a, [wScriptParam0]
    and $1f
    ret nz
    ld a, [de]
    inc a
    and $03
    ld [de], a
    ret

SECTION "Bank 0F StartMessageHL_B0F", ROMX

; HL = message word (low byte the message, high byte its group and the MSG_KEEP_OPEN /
; MSG_ALREADY_OPEN flags): stores it in wMessageIndex (low) and wMessageGroup (high) and sets
; wMessageState = 0, so the next RunMessageBox call opens the box and shows it. The scene steps of
; this bank start every message this way. (C2, E-0376)
; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0
StartMessageHL_B0F::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

SECTION "Bank 0F RunMessageBoxFar_Bank0F", ROMX

; A = argument kept in wStepPtrLo for RunMessageBox (0 also freezes the field animation while the
; box opens and releases it when it closes): far-calls RunMessageBox for one step of the message
; box, then returns carry set when wMessageState is $FF (no message running), else A = 0 and carry
; clear. Every caller in this bank passes A = 0 (SceneHomecoming_WaitMessage and the other scene
; waits). The same 20 bytes appear in 4 banks. (C1, E-0376)
; wStepPtrLo = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A =
; 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
RunMessageBoxFar_Bank0F::
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

SECTION "Bank 0F SceneHomecoming_WaitMessage", ROMX

; Homecoming scene, step 3: waits for the message box to close. (C1, E-0357)
SceneHomecoming_WaitMessage::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 0F PersonalityMessage_WaitForMessage", ROMX

; Personality message, step 1: waits for the message box to close, then resumes the script. (C1,
; E-0357)
PersonalityMessage_WaitForMessage::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $62, $00
