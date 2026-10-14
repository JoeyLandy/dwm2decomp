; ROM bank $0F: story scenes: Darck, the homecoming, the mermaid and others
; The annotated listing of this bank is build/listing/bank0f.asm.

SECTION "Bank 0F", ROMX[$4000], BANK[$0F]
    db $0f

; implements script command type C7 (SCRIPT_SCENE_PENDANT_SELLER): a cutscene step named after the
; scene its only script shows: 'This pendant is yours for 38,000G' ... 'You're going to regret
; seeing us.'; reached through ScriptCommandC7 in bank $10 (E-0038, E-0245)
ScenePendantSeller::
    ld a, [wScriptStep]
    jumptable
    dw ScenePendantSeller_SetBit2AtHL_B0F
    dw ScenePendantSeller_StepObjectTowardCoord
    dw ScenePendantSeller_UpdateFollowersOnStep_Bank0F
    dw ScenePendantSeller_UpdateFollowersOnStep_Bank0F_SetScriptParam0

; step 3 of ScenePendantSeller: calls UpdateFollowersOnStep_Bank0F; increments wScriptParam0;
; returns unless wScriptParam0 is $1e; copies hPlayerStateFlags & $fd to hPlayerStateFlags; sets
; wScriptStartRequest to $80
ScenePendantSeller_UpdateFollowersOnStep_Bank0F_SetScriptParam0::
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

; step 2 of ScenePendantSeller: calls UpdateFollowersOnStep_Bank0F; increments hPlayerY; calls
; UpdateFollowersOnStep_Bank0F; increments hPlayerY; returns unless hPlayerY is $80; sets
; wScriptParam0 to 0; advances wScriptStep
ScenePendantSeller_UpdateFollowersOnStep_Bank0F::
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

; step 1 of ScenePendantSeller: sets wStepPtrHi to 1; sets wStepTarget to $80; sets wStepPtrLo to
; $40; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets hPlayerStateFlags; plays
; sound $63; ...
ScenePendantSeller_StepObjectTowardCoord::
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

; step 0 of ScenePendantSeller: increments wScriptParam0; may return early; decrements wObject1 +
; OBJ_Y; returns unless wObject1 + OBJ_Y is $30; calls SetBit2AtHL_B0F; sets wScriptParam0 to 0;
; advances wScriptStep
ScenePendantSeller_SetBit2AtHL_B0F::
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

; implements script command type 62 (SCRIPT_PERSONALITY_MESSAGE): shows a message chosen by a party
; monster's personality (PersonalityIndexOfRecord); reached through ScriptCommand62 in bank $10
; (E-0038, E-0245)
PersonalityMessage::
    ld a, [wScriptStep]
    jumptable
    dw PersonalityMessage_LoadSRAMRecordByte
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 0 of PersonalityMessage: sets rRAMG to $0a; calls LoadSRAMRecordByte; calls
; PersonalityIndexOfRecord; calls StartMessageHL_B0F; sets rRAMG to 0; advances wScriptStep
PersonalityMessage_LoadSRAMRecordByte::
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
    ld hl, PersonalityMessage_LoadSRAMRecordByte_Data
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

; data read by PersonalityMessage (11 bytes)
PersonalityMessage_LoadSRAMRecordByte_Data::
    db $94, $af, $ca, $af, $94, $ca, $af, $94, $ca, $ca, $e5

; implements script command type 5F (SCRIPT_SCENE_HOMECOMING): a cutscene step named after the scene
; its only script shows: 'Hehehe, no need to worry there!' ... 'Tara 0, congratulations! I was sad';
; reached through ScriptCommand5F in bank $10 (E-0038, E-0245)
SceneHomecoming::
    ld a, [wScriptStep]
    jumptable
    dw SceneHomecoming_RunFieldCommandTemp0
    dw SceneHomecoming_WriteScriptParam0AndScriptParam1Etc
    dw SceneHomecoming_ShowWarubouWaheyInsteadOf
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_ShowWarubouNoOneKnows
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_StepScriptParam0Counter_Bank0F
    dw SceneHomecoming_StartPaletteFadeAndStep
    dw SceneHomecoming_RunFieldCommandTemp0_SetTemp0
    dw SceneHomecoming_ToScriptStepSetObjectBit2AndWait
    dw SceneHomecoming_ShowWarubouWaheyIWas
    dw SceneHomecoming_ShowWarubouWaheyIWas
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_ShowKamehaIWentAnd
    dw SceneHomecoming_ShowKamehaIWentAnd
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_ShowWarubouWAHEYSomePrince
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_ShowKamehaYoureAGlutton
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_ClearBit2AtHL_Bank0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_AddStepDeltaToPointedByte
    dw SceneHomecoming_StepObjectTowardCoord
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_ShowKamehaNoOnesTaking
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_WritePlayerFacingAndPlayerYEtc
    dw SceneHomecoming_WriteObject2AndPlayerXEtc
    dw SceneHomecoming_WriteObject2AndPlayerXEtc_2
    dw SceneHomecoming_Msg0DB8_WarubouWaheyIHave
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_WriteFollowerRecords
    dw SceneHomecoming_ScriptApplyStepDeltaAtDE
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_WriteObject2AndPlayerXEtc
    dw SceneHomecoming_WriteObject2AndPlayerXEtc_2
    dw SceneHomecoming_WriteObject2AndPlayerXEtc
    dw SceneHomecoming_ScriptApplyStepDeltaAtDE_SetBit1AtHL_Bank0F
    dw SceneHomecoming_ToStartPaletteFadeAndStep
    dw SceneHomecoming_WaitFadeState
    dw SceneHomecoming_ShowTHEEND
    dw SceneHomecoming_WriteScriptParam0AndScriptParam1
    dw SceneHomecoming_WriteMapIdAndMapScreenXEtc
    dw SceneHomecoming_SetScriptStartRequestTo80

; step 44 of SceneHomecoming: sets wScriptStartRequest to $80
SceneHomecoming_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 43 of SceneHomecoming: sets hMapId to 6; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wGameMode to 2; sets wModeState to $0b; sets wWorldMapState to 0; sets wTemp0 to 0; ...
SceneHomecoming_WriteMapIdAndMapScreenXEtc::
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

; step 42 of SceneHomecoming: copies L to wScriptParam0; copies H to wScriptParam1; may return
; early; sets wScriptParam0 to 0; advances wScriptStep
SceneHomecoming_WriteScriptParam0AndScriptParam1::
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

; step 41 of SceneHomecoming: sets wSpriteSlotCount to 0; sets wObject5 to 0; sets hPlayerX to $e0;
; copies L to wTextWindowTileLo; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies
; H to wTextWindowWidth; ...
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
    ld hl, $425e
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

; CopyBytes copies these 8 bytes to wOBJPaletteBuffer + $20 (E-0264)
; record: 8 bytes copied to wOBJPaletteBuffer + $20
OBJPaletteBufferPlus20Init_2::
    db $de, $67, $1f, $33, $3c, $12, $00, $00 ; entry 0

; step 40 of SceneHomecoming: returns unless wFadeState is 0; advances wScriptStep
SceneHomecoming_WaitFadeState::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; step 39 of SceneHomecoming: calls StartPaletteFade; advances wScriptStep
SceneHomecoming_ToStartPaletteFadeAndStep::
    ld a, $3f
    call StartPaletteFade
    ld hl, wScriptStep
    inc [hl]
    ret

; step 38 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; calls SetBit1AtHL_Bank0F; decrements
; wObject2 + OBJ_X; returns unless wObject2 + OBJ_X is $40; sets wScriptParam0 to 0; advances
; wScriptStep
SceneHomecoming_ScriptApplyStepDeltaAtDE_SetBit1AtHL_Bank0F::
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

; step 33 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; may return early; calls
; StartMessageHL_B0F; advances wScriptStep
SceneHomecoming_ScriptApplyStepDeltaAtDE::
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

; step 32 of SceneHomecoming: may return early; sets wFollowerRecords to 2; advances wScriptStep
SceneHomecoming_WriteFollowerRecords::
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

; step 30 of SceneHomecoming: shows 'Warubou: Wa-hey… I have seen this…'; advances wScriptStep
SceneHomecoming_Msg0DB8_WarubouWaheyIHave::
    ld hl, $0db8 ; 'Warubou: Wa-hey… I have seen this…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 29 of SceneHomecoming: continues in SceneHomecoming_WriteObject2AndPlayerXEtc_ReadObject2
SceneHomecoming_WriteObject2AndPlayerXEtc_2::
    ld a, [wScriptParam0]
    ld hl, SceneHomecoming_WriteObject2AndPlayerXEtc_Data
    add_a_to_hl
    ld a, [hl]
    xor $ff
    inc a
    ld c, a
    jr SceneHomecoming_WriteObject2AndPlayerXEtc_ReadObject2

; step 28 of SceneHomecoming: sets wObject2 + OBJ_STATE to 1
SceneHomecoming_WriteObject2AndPlayerXEtc::
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScriptParam0]
    ld hl, SceneHomecoming_WriteObject2AndPlayerXEtc_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a

; Sets wObject2 + OBJ_X; sets hPlayerX; sets wObject5 + SCRIPTOBJ_X; increments wScriptParam0;
; returns unless wScriptParam0 is $40; sets wScriptParam0 to 0; advances wScriptStep
SceneHomecoming_WriteObject2AndPlayerXEtc_ReadObject2::
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

; data read by SceneHomecoming (64 bytes)
SceneHomecoming_WriteObject2AndPlayerXEtc_Data::
    db $01, $00, $01, $00, $01, $01, $00, $ff, $01, $00, $00, $ff, $00, $ff, $ff, $00
    db $01, $00, $00, $00, $01, $01, $ff, $00, $00, $ff, $00, $00, $00, $ff, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $ff, $00, $00, $00, $ff, $01
    db $ff, $00, $00, $01, $ff, $ff, $ff, $00, $00, $00, $ff, $00, $00, $ff, $ff, $00

; step 27 of SceneHomecoming: branches on wScriptParam0; sets hPlayerFacing to 2; decrements
; hPlayerY; returns unless hPlayerY is $30; increments wScriptParam0; sets hPlayerFacing to 3;
; decrements hPlayerX; ...
SceneHomecoming_WritePlayerFacingAndPlayerYEtc::
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

; step 25 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; may return early; shows 'Kameha: No
; one's taking this pie'; advances wScriptStep
SceneHomecoming_ShowKamehaNoOnesTaking::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db7 ; 'Kameha: No one's taking this pie'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 23 of SceneHomecoming: sets wStepPtrHi to 1; branches on wScriptParam0; sets wStepTarget to
; $80; sets wStepPtrLo to $40; calls StepObjectTowardCoord; returns if wStepArrived is 0; increments
; wScriptParam0; ...
SceneHomecoming_StepObjectTowardCoord::
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

; step 22 of SceneHomecoming: sets wObject1 + OBJ_STATE to 1; sets wObject2 + OBJ_STATE to 1; copies
; E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; calls
; ScriptApplyStepDeltaAtDE; may return early; ...
SceneHomecoming_AddStepDeltaToPointedByte::
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

; step 20 of SceneHomecoming: calls ClearBit2AtHL_Bank0F; sets wStepPtrLo to $80; calls
; StepPlayerLeftTowardStepPtrLo; returns if wStepArrived is 0; calls StartMessageHL_B0F; advances
; wScriptStep
SceneHomecoming_ClearBit2AtHL_Bank0F::
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

; step 18 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; may return early; shows 'Kameha:
; You're a glutton! You haven't'; advances wScriptStep
SceneHomecoming_ShowKamehaYoureAGlutton::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db3 ; 'Kameha: You're a glutton! You haven't'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 16 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; may return early; shows 'Warubou:
; WA-HEY! Some Prince! Always a'; advances wScriptStep
SceneHomecoming_ShowWarubouWAHEYSomePrince::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db2 ; 'Warubou: WA-HEY! Some Prince! Always a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; may return early; shows 'Kameha: I
; went and faced danger'; advances wScriptStep
SceneHomecoming_ShowKamehaIWentAnd::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db1 ; 'Kameha: I went and faced danger'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 10 of SceneHomecoming: calls ScriptApplyStepDeltaAtDE; may return early; shows 'Warubou:
; Wa-hey! I was the plug'; advances wScriptStep
SceneHomecoming_ShowWarubouWaheyIWas::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db0 ; 'Warubou: Wa-hey! I was the plug'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of SceneHomecoming: calls ScriptStepSetObjectBit2AndWait
SceneHomecoming_ToScriptStepSetObjectBit2AndWait::
    farcall ScriptStepSetObjectBit2AndWait
    ret

; step 8 of SceneHomecoming: sets hTemp0 to 1; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $68; sets wObject5 + SCRIPTOBJ_Y to $30; sets wObject5 to $80; advances wScriptStep
SceneHomecoming_RunFieldCommandTemp0_SetTemp0::
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

; step 7 of SceneHomecoming: calls StartPaletteFade; sets wGameMode to 0; sets wModeState to 8;
; increments wModeChangeRequest; advances wScriptStep
SceneHomecoming_StartPaletteFadeAndStep::
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

; step 6 of SceneHomecoming: sets hPlayerFacing to 1; calls StepScriptParam0Counter_Bank0F; may
; return early; advances wScriptStep
SceneHomecoming_StepScriptParam0Counter_Bank0F::
    ld a, $01
    ldh [hPlayerFacing], a
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneHomecoming: sets wObject5 to $80; decrements wObject5 + SCRIPTOBJ_Y; calls
; ScriptApplyStepDeltaAtDE; may return early; shows 'Warubou: No one knows how many'; advances
; wScriptStep
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

; step 2 of SceneHomecoming: sets hPlayerFacing to 3; copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; ...
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

; step 1 of SceneHomecoming: copies L to wScriptParam0; copies H to wScriptParam1; sets wObject3 +
; OBJ_Y; increments wObject3 + OBJ_X; returns unless wObject3 + OBJ_X is $40; sets wObject3 + OBJ_Y
; to $40; sets wScriptParam0 to 0; ...
SceneHomecoming_WriteScriptParam0AndScriptParam1Etc::
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

; step 0 of SceneHomecoming: sets hTemp0 to $13; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $40; copies L to wScriptParam0; copies H to
; wScriptParam1; plays sound $65; ...
SceneHomecoming_RunFieldCommandTemp0::
    ld a, $13
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, $fe80
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

; implements script command type 5E (SCRIPT_SCENE_DARCK_DEFEATED): a cutscene step named after the
; scene its only script shows: 'Darck Wha What? How could I' ... 'Darck Fwahahahah! Bravo!
; Splendid!'; reached through ScriptCommand5E in bank $10 (E-0038, E-0245)
SceneDarckDefeated::
    ld a, [wScriptStep]
    jumptable
    dw SceneDarckDefeated_ScriptStepBlinkObjectTemp0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepPlayerLeftTowardStepPtrLo
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_MoveSprite0Down
    dw SceneDarckDefeated_Msg055A_AVoiceEchoedFrom
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_Msg055B_WaheyCanYouHear
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_ShowWarubouWaheyYouDid
    dw SceneDarckDefeated_ToRunSceneScriptSubStep
    dw SceneDarckDefeated_RedrawColumnsBesideScreenAndStep
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ToScriptStepShakeScreen
    dw SceneDarckDefeated_ShowWarubouWaheyFeelThat
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteFieldEventKindAndFieldEventTimerEtc
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ShowWarubouWawaheyWeWere
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_ScriptStepDeltaThenNextStep
    dw SceneDarckDefeated_SetFieldEventArg
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_15
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_15
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_15
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_ShowWarubouWaheyThatsIt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_StepPlayerDownTowardStepPtrLo
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ShowWarubouWaheyGetGoing
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteFieldEventArgAndObject5
    dw SceneDarckDefeated_ShowWarubouWaheyGreatLogsLife
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_WriteFieldEventArgAndObject5
    dw SceneDarckDefeated_WriteFieldEventArgAndMapIdEtc
    dw SceneDarckDefeated_RunFieldCommandTemp0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F_3
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_4
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_7
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_7
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F_AdvanceScriptStep
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_5
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_13
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_12
    dw SceneDarckDefeated_WriteStepPtrHiAndStepPtrLoEtc
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_4
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_6
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_6
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_11
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_3
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_3
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_10
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo_2
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_5
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_5
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject1AndObject2Etc
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_3
    dw SceneDarckDefeated_WriteScriptParam0AndObject1Etc
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_2
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_4
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_4
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_9
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_8
    dw SceneDarckDefeated_AddStepDeltaToPointedByte
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_7
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_6
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F_2
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_3
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_3
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_5
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_4
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteStepPtrLoAndStepTargetEtc
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_3
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_2
    dw SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_2
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_2
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw ScriptStepMoveObjects2And3To0340
    dw ScriptStepFlickerObjectCB9B
    dw ScriptStepDeltaObject2CThenCopy
    dw ScriptStepMoveObjects2And3To81B0
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId
    dw SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0
    dw SceneDarckDefeated_WriteFieldEventArgAndObject5_SetFieldEventArg
    dw SceneDarckDefeated_WriteFieldEventArgAndObject5_SetFieldEventArg
    dw SceneDarckDefeated_SetObject5
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetFieldEventArg
    dw SceneDarckDefeated_Msg053B_KingIThankYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_QueueSoundEffect
    dw SceneDarckDefeated_ShowKingEvenThoughThe
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 147 of SceneDarckDefeated: shows 'King: Even though the island's crisis'; sets hTemp0 to 6;
; calls MarkKeyEntryKindTemp0Bit6; advances wScriptStep
SceneDarckDefeated_ShowKingEvenThoughThe::
    ld hl, $053c ; 'King: Even though the island's crisis'
    call StartMessageHL_B0F
    ld a, $06
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld hl, wScriptStep
    inc [hl]
    ret

; step 146 of SceneDarckDefeated: branches on wScriptParam0; increments wScriptParam0; plays sound
; $6d; sets wScriptParam0; may return early; calls RestartMapMusic; sets wScriptParam0 to 0; ...
SceneDarckDefeated_QueueSoundEffect::
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

; step 144 of SceneDarckDefeated: shows 'King: I thank you all for'; advances wScriptStep
SceneDarckDefeated_Msg053B_KingIThankYou::
    ld hl, $053b ; 'King: I thank you all for'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 143 of SceneDarckDefeated: sets wFieldEventArg to 0; sets hMapId to $19; sets hMapScreenX to
; 0; sets hMapScreenY to 0; sets wWarpDestX to $40; sets wWarpDestY to $40; sets
; wFieldTransitionKind to 3; ...
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetFieldEventArg::
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

; step 140 of SceneDarckDefeated: sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_SetObject5::
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 137 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $20; sets wObject5 + SCRIPTOBJ_Y to $50; sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0::
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

; step 136 of SceneDarckDefeated: sets hMapId to 3; sets hMapScreenX to 0; sets hMapScreenY to 0;
; sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30; calls
; SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId::
    ld a, $03
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; steps objects 2 and 3 toward ($81, $B0) and ($81, $C0) (StepObjectTowardCoord); advances
; wScriptStep once they arrive (E-0124)
ScriptStepMoveObjects2And3To81B0::
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

; ScriptApplyStepDeltaAtDE on wObject2 + $C, copies wObject2 + $C to wObject3 + $C, and when the
; move finishes (carry) wScriptStep += 1 (E-0119) (E-0340: the address in its name read as its RAM
; name; was ScriptStepDeltaObject2CThenCopy)
ScriptStepDeltaObject2CThenCopy::
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

; alternates wObject1 + $C between $E0 and $40 at a rate that slows with wScriptParam0; after $78
; frames sets $40 and advances wScriptStep (E-0125)
ScriptStepFlickerObjectCB9B::
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

; steps objects 2 and 3 toward ($03, $40) and ($03, $50); advances wScriptStep once they arrive
; (E-0124)
ScriptStepMoveObjects2And3To0340::
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

; step 127 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $20; sets wObject5 + SCRIPTOBJ_Y to $40; sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_2::
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

; step 126 of SceneDarckDefeated: sets hMapId to $71; sets hMapScreenX to 0; sets hMapScreenY to 0;
; sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30; calls
; SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_2::
    ld a, $71
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; step 121 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepPtrLo to $60; sets wStepTarget to
; 0; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi::
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

; step 120 of SceneDarckDefeated: sets wStepPtrHi to 1; sets wStepPtrLo to $30; sets wStepTarget to
; 3; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepPtrLo to $60; sets wStepTarget to
; 1; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_2::
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

; step 118 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepPtrLo to $50; sets wStepTarget to
; 0; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wObject1 + OBJ_STATE to 2; sets
; wObject2 + OBJ_STATE to 2; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_3::
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

; step 117 of SceneDarckDefeated: sets wStepPtrLo to $40; sets wStepTarget to 3; continues in
; SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo_SetStepPtrHiTo04
SceneDarckDefeated_WriteStepPtrLoAndStepTargetEtc::
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    jr SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo_SetStepPtrHiTo04

; step 115 of SceneDarckDefeated: sets wStepPtrLo to $50; sets wStepTarget to 1
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo::
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a

; Sets wStepPtrHi to 4; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wObject4 +
; OBJ_STATE to 2; advances wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo_SetStepPtrHiTo04::
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

; step 113 of SceneDarckDefeated: sets wStepPtrHi to 1; sets wStepPtrLo to $40; sets wStepTarget to
; $81; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepPtrLo to $50; sets wStepTarget
; to $83; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_4::
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

; step 112 of SceneDarckDefeated: sets wStepPtrHi to 4; sets wStepPtrLo to $70; sets wStepTarget to
; 2; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_5::
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

; step 110 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $60; sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_3::
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

; step 109 of SceneDarckDefeated: sets hMapId to $60; sets hMapScreenX to 0; sets hMapScreenY to 0;
; sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30; calls
; SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_3::
    ld a, $60
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; step 104 of SceneDarckDefeated: branches on wScriptParam0; calls StepScriptParam0Counter_Bank0F;
; may return early; advances wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F_2::
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

; step 102 of SceneDarckDefeated: sets wStepPtrHi to 3; sets wStepPtrLo to $b0; sets wStepTarget to
; $80; calls StepObjectTowardCoord; sets wStepPtrHi to 4; sets wStepPtrLo to $b0; sets wStepTarget
; to $80; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_6::
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

; step 101 of SceneDarckDefeated: branches on wScriptParam0; sets wStepPtrHi to 2; sets wStepPtrLo
; to $40; sets wStepTarget to $83; calls StepObjectTowardCoord; copies wObject2 + OBJ_X to wObject1
; + OBJ_X; returns if wStepArrived is 0; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_7::
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

; step 99 of SceneDarckDefeated: decrements wObject1 + OBJ_Y; increments wObject1 + OBJ_X; copies E
; to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments wScriptParam0;
; returns unless wScriptParam0 is $20; ...
SceneDarckDefeated_AddStepDeltaToPointedByte::
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

; step 98 of SceneDarckDefeated: sets wStepPtrHi to 1; sets wStepPtrLo to $70; sets wStepTarget to
; 0; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wObject1 + OBJ_STATE to 1;
; advances wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_8::
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

; step 96 of SceneDarckDefeated: calls ScriptApplyStepDeltaAtDE; may return early; advances
; wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 95 of SceneDarckDefeated: sets wStepPtrHi to 3; sets wStepPtrLo to $80; sets wStepTarget to
; 2; calls StepObjectTowardCoord; sets wStepPtrHi to 4; sets wStepPtrLo to $80; sets wStepTarget to
; 2; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_9::
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

; step 92 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30; sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_4::
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

; step 91 of SceneDarckDefeated: sets hMapId to $49; sets hMapScreenX to 0; sets hMapScreenY to 0;
; calls SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_4::
    ld a, $49
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; step 86 of SceneDarckDefeated: copies wObject1 + OBJ_STATE & $03 to wObject1 + OBJ_STATE; copies
; wObject1 + OBJ_STATE & $03 to wObject2 + OBJ_STATE; copies wObject1 + OBJ_STATE & $03 to wObject3
; + OBJ_STATE; calls ScriptApplyStepDeltaAtDE; copies wObject1 + OBJ_Y to wObject2 + OBJ_Y; copies
; wObject1 + OBJ_Y to wObject3 + OBJ_Y; may return early; ...
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_2::
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

; step 85 of SceneDarckDefeated: increments wScriptParam0; may return early; increments wObject1 +
; OBJ_X; sets wObject2 + OBJ_X; sets wObject3 + OBJ_X; may return early; sets wScriptParam0 to 0;
; ...
SceneDarckDefeated_WriteScriptParam0AndObject1Etc::
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

; step 84 of SceneDarckDefeated: copies wObject1 + OBJ_STATE & $03 to wObject1 + OBJ_STATE; copies
; wObject1 + OBJ_STATE & $03 to wObject2 + OBJ_STATE; copies wObject1 + OBJ_STATE & $03 to wObject3
; + OBJ_STATE; calls ScriptApplyStepDeltaAtDE; copies wObject1 + OBJ_Y to wObject2 + OBJ_Y; copies
; wObject1 + OBJ_Y to wObject3 + OBJ_Y; may return early; ...
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_3::
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

; step 83 of SceneDarckDefeated: sets wObject1 + OBJ_STATE to 3; sets wObject2 + OBJ_STATE to 3;
; sets wObject3 + OBJ_STATE to 3; increments wScriptParam0; may return early; decrements wObject1 +
; OBJ_X; sets wObject2 + OBJ_X; ...
SceneDarckDefeated_WriteObject1AndObject2Etc::
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

; step 81 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $20; sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_5::
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

; step 80 of SceneDarckDefeated: sets hMapId to $41; sets hMapScreenX to 0; sets hMapScreenY to 0;
; calls SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_5::
    ld a, $41
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; step 75 of SceneDarckDefeated: calls ScriptApplyStepDeltaAtDE; may return early; advances
; wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2::
    ld de, wObject3 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 74 of SceneDarckDefeated: branches on wScriptParam0; sets wStepPtrLo to $60; sets wStepPtrHi
; to 2; sets wStepTarget to 2; calls StepObjectTowardCoord; sets wStepPtrLo to $60; sets wStepPtrHi
; to 1; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrLo_2::
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

; step 72 of SceneDarckDefeated: sets wStepPtrHi to 1; branches on wScriptParam0; sets wStepPtrLo to
; $60; sets wStepTarget to $80; calls StepObjectTowardCoord; returns if wStepArrived is 0;
; increments wScriptParam0; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_10::
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

; step 69 of SceneDarckDefeated: calls ScriptApplyStepDeltaAtDE; may return early; advances
; wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_3::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 67 of SceneDarckDefeated: sets wStepPtrHi to 1; branches on wScriptParam0; sets wStepPtrLo to
; $60; sets wStepTarget to 2; calls StepObjectTowardCoord; returns if wStepArrived is 0; increments
; wScriptParam0; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_11::
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

; step 66 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $20; sets wObject5 + SCRIPTOBJ_Y to $40; sets wObject5 to 0; sets wScriptParam0 to
; 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_6::
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

; step 65 of SceneDarckDefeated: sets hMapId to $33; sets hMapScreenX to 0; sets hMapScreenY to 0;
; calls SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_6::
    ld a, $33
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; step 60 of SceneDarckDefeated: sets wObject2 + OBJ_STATE to 3; decrements wObject2 + OBJ_X; calls
; ScriptApplyStepDeltaAtDE; may return early; sets wObject2 + OBJ_STATE to 0; advances wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_4::
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

; step 59 of SceneDarckDefeated: sets wStepPtrHi to 2; sets wStepPtrLo to $60; continues in
; SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14_SetStepTargetTo80
SceneDarckDefeated_WriteStepPtrHiAndStepPtrLoEtc::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14_SetStepTargetTo80

; step 58 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepPtrLo to $e0; sets wStepTarget to
; $83; calls StepObjectTowardCoord; sets wObject1 + OBJ_STATE to 1; increments wObject1 + OBJ_X;
; calls ScriptApplyStepDeltaAtDE; ...
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_12::
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

; step 57 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepPtrLo to $e0; sets wStepTarget to
; $83; calls StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepPtrLo to $60; continues in
; SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14_SetStepTargetTo80
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_13::
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
    jr SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14_SetStepTargetTo80

; step 56 of SceneDarckDefeated: decrements wSpriteSlots + $b; calls ScriptApplyStepDeltaAtDE; may
; return early; sets wObject1 + OBJ_Y to $30; advances wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_5::
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

; step 55 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepPtrLo to $60
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a

; Sets wStepTarget to $80; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances
; wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_14_SetStepTargetTo80::
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

; step 54 of SceneDarckDefeated: calls StepScriptParam0Counter_Bank0F; may return early; advances
; wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F_AdvanceScriptStep::
    ld b, $5a
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 53 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $30; sets wObject5 + SCRIPTOBJ_Y to $60; sets wObject5 to 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_SetTemp0_7::
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

; step 52 of SceneDarckDefeated: sets hMapId to $2f; sets hMapScreenX to 1; sets hMapScreenY to 0;
; calls SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_SetMapId_7::
    ld a, $2f
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; step 49 of SceneDarckDefeated: sets wObject5 to $80; increments wScriptParam0; decrements wObject5
; + SCRIPTOBJ_Y; returns unless wScriptParam0 is $40; sets wObject5 to 0; sets wScriptParam0 to 0;
; advances wScriptStep
SceneDarckDefeated_WriteObject5AndScriptParam0::
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

; step 47 of SceneDarckDefeated: copies wObject3 + OBJ_STATE & $03 to wObject3 + OBJ_STATE; copies
; wObject3 + OBJ_STATE & $03 to wObject4 + OBJ_STATE; calls ScriptApplyStepDeltaAtDE; may return
; early; sets wObject3 + OBJ_STATE to 2; sets wObject4 + OBJ_STATE to 2; advances wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_4::
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

; step 46 of SceneDarckDefeated: copies wObject3 + OBJ_STATE & $03 to wObject3 + OBJ_STATE; copies
; wObject3 + OBJ_STATE & $03 to wObject4 + OBJ_STATE; calls StepScriptParam0Counter_Bank0F; may
; return early; advances wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F_3::
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

; step 45 of SceneDarckDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $10; sets wObject5 to 0; sets wScriptParam0 to
; 0; advances wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0::
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

; step 44 of SceneDarckDefeated: sets wFieldEventArg to 1; sets hMapId to $26; sets hMapScreenX to
; 0; sets hMapScreenY to 0
SceneDarckDefeated_WriteFieldEventArgAndMapIdEtc::
    ld a, $01
    ld [wFieldEventArg], a
    ld a, $26
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

; Sets wWarpDestX to $e0; copies hPlayerY to wWarpDestY; sets wFieldTransitionKind to 4; calls
; ScriptStartFadeAndAdvanceStep; sets wObject5 to 0
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep::
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

; step 41 of SceneDarckDefeated: sets wFieldEventArg to 1; shows 'Warubou: Wa-hey? GreatLog's life
; force is'; sets wObject5 to 0; advances wScriptStep
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

; step 37 of SceneDarckDefeated: sets wFieldEventArg to 1; shows 'Warubou: Wa-hey! Get going!'; sets
; hTemp0 to $11; calls RunFieldCommandTemp0; sets wObject5 to 0; sets wScriptSubStep to 0; advances
; wScriptStep
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

; step 35 of SceneDarckDefeated: sets wFieldEventArg to 0; branches on hPlayerY; sets wStepPtrLo to
; $40; calls StepPlayerDownTowardStepPtrLo; sets wStepPtrLo to $80; calls
; StepPlayerRightTowardStepPtrLo; returns if wStepArrived is 0; ...
SceneDarckDefeated_StepPlayerDownTowardStepPtrLo::
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

; step 33 of SceneDarckDefeated: shows 'Warubou: Wa-hey… That's it, then. There's'; sets
; wFieldEventArg to 1; copies wScriptTemp4 to wPartyCount; sets hFieldDrawFlags to 0; advances
; wScriptStep
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

; step 27 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to
; $40; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_SetStepPtrHi_15::
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

; step 26 of SceneDarckDefeated: sets wStepPtrHi to 0; sets wStepTarget to 2; sets wStepPtrLo to
; $20; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep
SceneDarckDefeated_StepObjectTowardCoord::
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

; step 24 of SceneDarckDefeated: sets wFieldEventArg to 0; calls ScriptStepDeltaThenNextStep
SceneDarckDefeated_ScriptStepDeltaThenNextStep::
    xor a
    ld [wFieldEventArg], a
    ld de, hPlayerY
    call ScriptStepDeltaThenNextStep
    ret

; step 22 of SceneDarckDefeated: sets wFieldEventArg to 1; shows 'Warubou: Wa-wa-hey! We were too
; late!'; advances wScriptStep
SceneDarckDefeated_ShowWarubouWawaheyWeWere::
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0537 ; 'Warubou: Wa-wa-hey! We were too late!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 19 of SceneDarckDefeated: sets wFieldEventKind to $0c; sets wFieldEventTimer to 0
SceneDarckDefeated_WriteFieldEventKindAndFieldEventTimerEtc::
    ld a, $0c
    ld [wFieldEventKind], a
    xor a
    ld [wFieldEventTimer], a

; step 25 of SceneDarckDefeated: sets wFieldEventArg to 0; advances wScriptStep
SceneDarckDefeated_SetFieldEventArg::
    xor a
    ld [wFieldEventArg], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 16 of SceneDarckDefeated: sets wFieldEventArg to 0; shows 'Warubou: Wa-hey? Feel that,
; warooh? Did'; advances wScriptStep
SceneDarckDefeated_ShowWarubouWaheyFeelThat::
    xor a
    ld [wFieldEventArg], a
    ld hl, $0df7 ; 'Warubou: Wa-hey? Feel that, warooh? Did'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 15 of SceneDarckDefeated: calls ScriptStepShakeScreen
SceneDarckDefeated_ToScriptStepShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

; step 13 of SceneDarckDefeated: sets wObject1 + OBJ_Y to $30; sets wObject5 to 0; calls
; RedrawColumnsBesideScreen; advances wScriptStep
SceneDarckDefeated_RedrawColumnsBesideScreenAndStep::
    ld a, $30
    ld [wObject1 + OBJ_Y], a
    xor a
    ld [wObject5], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; step 12 of SceneDarckDefeated: calls RunSceneScriptSubStep
SceneDarckDefeated_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

; step 11 of SceneDarckDefeated: sets hMapId to 5; sets hMapScreenX to 1; sets hMapScreenY to 0;
; sets wWarpDestX to $50; sets wWarpDestY to $30; sets wFieldTransitionKind to 4; sets
; wScreenTriggerCount to 0; ...
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

; step 9 of SceneDarckDefeated: shows 'Wa-hey! can you hear me,'; advances wScriptStep
SceneDarckDefeated_Msg055B_WaheyCanYouHear::
    ld hl, $055b ; '*: Wa-hey! can you hear me,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 7 of SceneDarckDefeated: shows 'A voice echoed from nowhere…'; advances wScriptStep
SceneDarckDefeated_Msg055A_AVoiceEchoedFrom::
    ld hl, $055a ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; increments the Y byte of sprite slot 0 (wSpriteSlots + $C)
SceneDarckDefeated_MoveSprite0Down::
    ld hl, wSpriteSlots + $c
    inc [hl]

; step 3 of SceneDarckDefeated: calls ScriptApplyStepDeltaAtDE; may return early; advances
; wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE::
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneDarckDefeated: branches on hPlayerX; sets wStepPtrLo to $40; calls
; StepPlayerLeftTowardStepPtrLo; sets wStepPtrLo to $20; calls StepPlayerUpTowardStepPtrLo; returns
; if wStepArrived is 0; calls DrawFullScreenBufferAtScroll; ...
SceneDarckDefeated_StepPlayerLeftTowardStepPtrLo::
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

; step 1 of SceneDarckDefeated: calls StepScriptParam0Counter_Bank0F; may return early; advances
; wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneDarckDefeated: sets hTemp0 to 1; sets hTemp1 to $30; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wSpriteSlotCount to 1; sets
; EVENT_SCENE_DARCK_DEFEATED; advances wScriptStep
SceneDarckDefeated_ScriptStepBlinkObjectTemp0::
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

; step 138 of SceneDarckDefeated: sets wFieldEventArg to 0; sets wObject5 to $80; dispatches on
; wScriptParam1 & $0f
SceneDarckDefeated_WriteFieldEventArgAndObject5_SetFieldEventArg::
    xor a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and $0f
    jumptable
    dw SceneDarckDefeated_WriteScriptSubStepAndObject5
    dw SceneDarckDefeated_WriteObject5AndScriptSubStepEtc

; step 0 of SceneDarckDefeated_WriteFieldEventArgAndObject5_SetFieldEventArg: branches on
; wScriptSubStep; increments wScriptSubStep; branches on wScriptSubStep; sets wObject5 +
; SCRIPTOBJ_Y; sets wObject5 + SCRIPTOBJ_X; increments wScriptSubStep; returns unless wScriptSubStep
; is $17; ...
SceneDarckDefeated_WriteScriptSubStepAndObject5::
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
    ld de, SceneDarckDefeated_WriteScriptSubStepAndObject5_ObjectPathTable
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

; step 1 of SceneDarckDefeated_WriteFieldEventArgAndObject5_SetFieldEventArg: sets wObject5 to 0;
; sets wScriptSubStep to 0; advances wScriptStep; sets wScriptParam1 to 0
SceneDarckDefeated_WriteObject5AndScriptSubStepEtc::
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

; step 40 of SceneDarckDefeated: sets wFieldEventArg to 0; sets wObject5 to $80; dispatches on
; wScriptParam1 & $0f
SceneDarckDefeated_WriteFieldEventArgAndObject5::
    xor a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and $0f
    jumptable
    dw SceneDarckDefeated_WriteScriptSubStepAndObject5_2
    dw SceneDarckDefeated_WriteScriptSubStepAndScriptParam1

; step 0 of SceneDarckDefeated_WriteFieldEventArgAndObject5: branches on wScriptSubStep; increments
; wScriptSubStep; branches on wScriptSubStep; sets wObject5 + SCRIPTOBJ_Y; sets wObject5 +
; SCRIPTOBJ_X; increments wScriptSubStep; returns unless wScriptSubStep is $17; ...
SceneDarckDefeated_WriteScriptSubStepAndObject5_2::
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, .skip
    inc a
    ld [wScriptSubStep], a
    ret

.skip:
    and $fe
    ld de, SceneDarckDefeated_WriteScriptSubStepAndObject5_ObjectPathTable
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

; step 1 of SceneDarckDefeated_WriteFieldEventArgAndObject5: sets wScriptSubStep to 0; advances
; wScriptStep; sets wScriptParam1 to 0
SceneDarckDefeated_WriteScriptSubStepAndScriptParam1::
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

; SceneDarckDefeated_WriteScriptSubStepAndObject5_2 reads, every other frame, the pair at $5284 +
; $30 * ((wScriptParam1 & $70) >> 4) + 2 * step into wObject5 + 5 and + 4, for 23 steps per path; 8
; paths end at SceneThreeItems (E-0206, C1)
; record: 24 steps of two bytes (wObject5 + 5, wObject5 + 4), 12 per line
SceneDarckDefeated_WriteScriptSubStepAndObject5_ObjectPathTable::
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

; implements script command type 58 (SCRIPT_SCENE_THREE_ITEMS): a cutscene step named after the
; scene its only script shows: 'Kameha If the three items that...'; reached through ScriptCommand58
; in bank $10 (E-0038, E-0245)
SceneThreeItems::
    ld a, [wScriptStep]
    jumptable
    dw SceneThreeItems_ToRedrawColumnsBesideScreenAndStep
    dw SceneThreeItems_ToScriptStepShakeScreen
    dw SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_QueueMusic
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_Msg0485_GreetingsIAmDarck
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_ToScriptStepDeltaThenMessage
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_Msg_DarckWellForMe
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_ShowDarckIImagineThat
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_StartMessageHL_B0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_Msg048D_HeroReceivedTheLimbo
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_Msg048E_DarckIWillBe
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_CopyBytes
    dw SceneThreeItems_WriteSpriteSlotCount
    dw SceneThreeItems_SetFlagBit
    dw SceneThreeItems_StepScriptParam0Counter_Bank0F
    dw SceneThreeItems_ToScriptStepDeltaThenMessage_3
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_Msg0490_AVoiceEchoedFrom
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_Msg0491_WaheyCanYouHear
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_ShowWarubouWaheyHeroAnd
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_QueueSoundEffect
    dw SceneThreeItems_ToScriptStepFlashScreenNegative
    dw SceneThreeItems_ShowWarubouThereAllHealed
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_ToRedrawColumnsBesideScreenAndStep
    dw SceneThreeItems_ToScriptStepShakeScreen
    dw SceneThreeItems_Msg0A7C_KamehaIIHave
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_ShowWarubouWaheyThereIs
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneThreeItems_ToScriptStepDeltaThenMessage_2
    dw SceneThreeItems_RunMessageBoxFar_Bank0F

; step 43 of SceneThreeItems: calls RunMessageBoxFar_Bank0F; may return early; sets hTemp0 to 5;
; calls MarkKeyEntryKindTemp0Bit6; calls CountKeysOrFull; sets hTemp1 to 6; calls
; WriteKeyEntryTemp0; ...
SceneThreeItems_RunMessageBoxFar_Bank0F::
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

; step 42 of SceneThreeItems: calls ScriptStepDeltaThenMessage
SceneThreeItems_ToScriptStepDeltaThenMessage_2::
    ld de, hPlayerY
    ld hl, $0a7e
    call ScriptStepDeltaThenMessage
    ret

; step 40 of SceneThreeItems: sets wStepPtrHi to 1; sets wStepTarget to $81; sets wStepPtrLo to $b0;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets EVENT_SCENE_THREE_ITEMS_0C3; calls
; PlayMapMusic; ...
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

; step 38 of SceneThreeItems: shows 'Kameha: I… I have to go'; advances wScriptStep
SceneThreeItems_Msg0A7C_KamehaIIHave::
    ld hl, $0a7c ; 'Kameha: I… I have to go'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 34 of SceneThreeItems: calls FullyHealParty; calls MoveIncapacitatedPartyMembersBack; calls
; LoadRecordListNameTiles; calls LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest
; to $7f; shows 'Warubou: There! All healed now! There'; advances wScriptStep
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

; step 30 of SceneThreeItems: sets hMapId to 5; sets hMapScreenX to 1; sets hMapScreenY to 0; sets
; wWarpDestX to $50; sets wWarpDestY to $30; sets EVENT_SCENE_THREE_ITEMS; sets wFieldTransitionKind
; to 4; ...
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

; step 28 of SceneThreeItems: shows 'Wa-hey! Can you hear me,'; advances wScriptStep
SceneThreeItems_Msg0491_WaheyCanYouHear::
    ld hl, $0491 ; '*: Wa-hey! Can you hear me,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 26 of SceneThreeItems: shows 'A voice echoed from nowhere…'; advances wScriptStep
SceneThreeItems_Msg0490_AVoiceEchoedFrom::
    ld hl, $0490 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 24 of SceneThreeItems: calls ScriptStepDeltaThenMessage
SceneThreeItems_ToScriptStepDeltaThenMessage_3::
    ld de, wObject2 + OBJ_Y
    ld hl, $048f
    call ScriptStepDeltaThenMessage
    ret

; step 23 of SceneThreeItems: calls StepScriptParam0Counter_Bank0F; may return early; advances
; wScriptStep
SceneThreeItems_StepScriptParam0Counter_Bank0F::
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

; step 22 of SceneThreeItems: sets EVENT_SCENE_THREE_ITEMS_0C2; copies hPlayerX to wWarpDestX;
; copies hPlayerY to wWarpDestY; calls StartPaletteFade; sets wFieldTransitionKind to 3; sets
; wModeState to 4; sets wFieldTransitionStep to 0; ...
SceneThreeItems_SetFlagBit::
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

; step 21 of SceneThreeItems: sets wSpriteSlotCount to 1
SceneThreeItems_WriteSpriteSlotCount::
    ld a, $01
    ld [wSpriteSlotCount], a

; step 33 of SceneThreeItems: calls ScriptStepFlashScreenNegative
SceneThreeItems_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

; step 32 of SceneThreeItems: plays sound $7a
SceneThreeItems_QueueSoundEffect::
    ld a, $7a
    call QueueSoundEffect

; step 20 of SceneThreeItems: branches on wIsCGB; calls CopyBytes; advances wScriptStep
SceneThreeItems_CopyBytes::
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

; step 18 of SceneThreeItems: shows 'Darck: I will be readying a'; advances wScriptStep
SceneThreeItems_Msg048E_DarckIWillBe::
    ld hl, $048e ; 'Darck: I will be readying a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 16 of SceneThreeItems: shows '0 received the Limbo Key.'; advances wScriptStep
SceneThreeItems_Msg048D_HeroReceivedTheLimbo::
    ld hl, $048d ; '0 received the Limbo Key.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 14 of SceneThreeItems: branches on wFrameCounterLo; sets wObject5 to 0; sets wObject5 to $80;
; increments wObject5 + SCRIPTOBJ_Y; returns unless wObject5 + SCRIPTOBJ_Y is c; sets wObject5 to 0;
; shows 'Darck: That key will bring you'; ...
SceneThreeItems_StartMessageHL_B0F::
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

; step 12 of SceneThreeItems: branches on wTextYesNoResult; calls StartMessageHL_B0F; decrements
; wScriptStep; calls StartMessageHL_B0F; sets hTemp0 to 4; calls RunFieldCommandTemp0; copies
; hPlayerX to wObject5 + SCRIPTOBJ_X; ...
SceneThreeItems_ShowDarckIImagineThat::
    ld a, [wTextYesNoResult]
    or a
    jr z, .call_start_message_hl_b0_f
    ld hl, wSGBPacketBuffer + $b
    call StartMessageHL_B0F
    ld hl, wScriptStep
    dec [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, vTiles0 + $48b
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

; step 10 of SceneThreeItems: shows 'Darck: Well, for me, anything that'; advances wScriptStep
SceneThreeItems_Msg_DarckWellForMe::
    ld hl, $4487 ; 'Darck: Well, for me, anything that'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 8 of SceneThreeItems: calls ScriptStepDeltaThenMessage
SceneThreeItems_ToScriptStepDeltaThenMessage::
    ld de, wSpriteSlots + $c
    ld hl, $0486
    call ScriptStepDeltaThenMessage
    ret

; step 6 of SceneThreeItems: shows 'Greetings! I am Darck, the'; advances wScriptStep
SceneThreeItems_Msg0485_GreetingsIAmDarck::
    ld hl, $0485 ; '*: Greetings! I am Darck, the'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneThreeItems: branches on wScriptParam0; plays music $1f; sets wObject3 + OBJ_Y to
; $18; branches on wScriptParam0; sets wObject1 + OBJ_Y to $10; sets wObject1 + OBJ_Y to $c0; calls
; StepScriptParam0Counter_Bank0F; ...
SceneThreeItems_QueueMusic::
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

; step 2 of SceneThreeItems: shows 'Kameha: Wha-wha whaaaat? What just happened'; advances
; wScriptStep
SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat::
    ld hl, $0483 ; 'Kameha: Wha-wha whaaaat? What just happened'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneThreeItems: calls ScriptStepShakeScreen
SceneThreeItems_ToScriptStepShakeScreen::
    ld b, $78
    call ScriptStepShakeScreen
    ret

; step 0 of SceneThreeItems: calls RedrawColumnsBesideScreen; advances wScriptStep
SceneThreeItems_ToRedrawColumnsBesideScreenAndStep::
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4E (SCRIPT_SCENE_GRAVE): a cutscene step named after the scene its
; only script shows: '0 checked the grave.' ... 'Fine! You've done well...'; reached through
; ScriptCommand4E in bank $10 (E-0038, E-0245)
SceneGrave::
    ld a, [wScriptStep]
    jumptable
    dw SceneGrave_StepScriptParam0Counter_Bank0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneGrave_ShowAhYoullDoIt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneGrave_ScriptStepBlinkObjectTemp0

; step 4 of SceneGrave: sets hTemp1 to $40; sets hTemp0 to 1; calls ScriptStepBlinkObjectTemp0;
; returns if hTemp0 is 0; sets wScriptStartRequest to $80
SceneGrave_ScriptStepBlinkObjectTemp0::
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

; step 2 of SceneGrave: advances wScriptStep; branches on wTextYesNoResult; calls
; StartMessageHL_B0F; sets EVENT_SCENE_GRAVE_0A6; calls StartMessageHL_B0F; sets
; EVENT_SCENE_GRAVE_0A5
SceneGrave_ShowAhYoullDoIt::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, vTiles0 + $416
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_GRAVE_0A6
    call SetFlagBit
    ret

.call_start_message_hl_b0_f:
    ld hl, vTiles0 + $417
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_GRAVE_0A5
    call SetFlagBit
    ret

; step 0 of SceneGrave: sets wObject1 + OBJ_Y to $40; branches on wScriptParam0; sets
; wSpriteSlotCount to 2; sets wSpriteSlotCount to 1; calls StepScriptParam0Counter_Bank0F; may
; return early; sets wSpriteSlotCount to 2; ...
SceneGrave_StepScriptParam0Counter_Bank0F::
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
    ld hl, $4415 ; '*: Who disturbs my sleep? A'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f2:
    ld hl, $4418 ; '*: Who disturbs my sleep? Oh,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f3:
    ld hl, $4419 ; '*: Well? Will you go look'
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

; implements script command type 4B (SCRIPT_SCENE_SHIELD_2): a cutscene step named after the scene
; its only script shows: after '0 checked the shield.'; reached through ScriptCommand4B in bank $10
; (E-0038, E-0245)
SceneShield2::
    ld a, [wScriptStep]
    jumptable
    dw SceneShield2_RunFieldCommandTemp0
    dw SceneShield2_ScriptApplyStepDeltaAtDE
    dw SceneShield2_StepScriptParam0Counter_Bank0F
    dw SceneShield2_ShowLetMeShowYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_StepScriptParam0Counter_Bank0F
    dw SceneShield2_ScriptStartFadeAndAdvanceStep_SetMapId_2
    dw SceneShield2_StepScriptParam0Counter_Bank0F
    dw SceneShield2_ScriptStartFadeAndAdvanceStep
    dw SceneShield2_StepScriptParam0Counter_Bank0F
    dw SceneShield2_ScriptStartFadeAndAdvanceStep_SetMapId
    dw SceneShield2_StepScriptParam0Counter_Bank0F_2
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_ShowHeroReceivedTheSky
    dw SceneShield2_ShowAVoiceEchoedFrom
    dw SceneShield2_ShowWaheyHeroCanYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_ShowWarubouWaheyYouDid
    dw SceneShield2_ToRunSceneScriptSubStep
    dw SceneShield2_RunFieldCommandTemp0_SetTemp0
    dw SceneShield2_ShowWarubouWaheyYouCan
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_SetFlagBit

; step 22 of SceneShield2: sets EVENT_SCENE_SHIELD2_023; sets hTemp0 to 4; calls
; MarkKeyEntryKindTemp0Bit6; sets wScriptStartRequest to $80
SceneShield2_SetFlagBit::
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

; step 20 of SceneShield2: increments wObject5 + SCRIPTOBJ_Y; returns unless wObject5 + SCRIPTOBJ_Y
; is c; sets wObject5 to 0; shows 'Warubou: Wa-hey, you can now fly'; sets EVENT_SCENE_SHIELD2;
; advances wScriptStep
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

; step 19 of SceneShield2: sets hTemp0 to $11; calls RunFieldCommandTemp0; copies hPlayerX to
; wObject5 + SCRIPTOBJ_X; sets wObject5 + SCRIPTOBJ_Y; sets wObject5 to $80; plays sound $85;
; advances wScriptStep
SceneShield2_RunFieldCommandTemp0_SetTemp0::
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

; step 18 of SceneShield2: calls RunSceneScriptSubStep
SceneShield2_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

; step 17 of SceneShield2: sets hMapId to 5; sets hMapScreenX to 1; sets hMapScreenY to 0; sets
; wWarpDestX to $50; sets wWarpDestY to $30; sets wFieldTransitionKind to 1; sets
; wScreenTriggerCount to 0; ...
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

; step 15 of SceneShield2: calls RunMessageBoxFar_Bank0F; may return early; shows '…Wa-hey! 0, can
; you hear'; advances wScriptStep
SceneShield2_ShowWaheyHeroCanYou::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0a0a ; '*: …Wa-hey! 0, can you hear'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 14 of SceneShield2: calls RunMessageBoxFar_Bank0F; may return early; shows 'A voice echoed
; from nowhere…'; advances wScriptStep
SceneShield2_ShowAVoiceEchoedFrom::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0a09 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of SceneShield2: increments wSpriteSlots + $c; calls ScriptApplyStepDeltaAtDE; may return
; early; shows '0 received the Sky Shield.'; sets EVENT_SCENE_SHIELD2_1E5; advances wScriptStep
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

; step 11 of SceneShield2: sets wObject2 + OBJ_Y to $18; branches on wScriptParam0; sets
; wSpriteSlotCount to 3; sets wSpriteSlotCount to 2; calls StepScriptParam0Counter_Bank0F; may
; return early; sets wSpriteSlotCount to 3; ...
SceneShield2_StepScriptParam0Counter_Bank0F_2::
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

; step 10 of SceneShield2: sets hMapId to $49; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestY to $40; calls ScriptStartFadeAndAdvanceStep
SceneShield2_ScriptStartFadeAndAdvanceStep_SetMapId::
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

; step 8 of SceneShield2: calls ScriptStartFadeAndAdvanceStep
SceneShield2_ScriptStartFadeAndAdvanceStep::
    ld a, [wStoryFlags + $63]
    set 1, a
    ld [wStoryFlags + $63], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; step 6 of SceneShield2: sets hMapId to $48; sets hMapScreenX to 7; sets hMapScreenY to 5; copies
; hPlayerX to wWarpDestX; sets wWarpDestY to $e0; sets wFieldTransitionKind to 3; calls
; ScriptStartFadeAndAdvanceStep
SceneShield2_ScriptStartFadeAndAdvanceStep_SetMapId_2::
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

; step 3 of SceneShield2: decrements wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE; may
; return early; sets wObject5 to 0; shows 'Let me show you my'; advances wScriptStep
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

; step 2 of SceneShield2: calls StepScriptParam0Counter_Bank0F; may return early; advances
; wScriptStep
SceneShield2_StepScriptParam0Counter_Bank0F::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneShield2: decrements wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE; may
; return early; advances wScriptStep
SceneShield2_ScriptApplyStepDeltaAtDE::
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneShield2: sets hTemp0 to $10; calls RunFieldCommandTemp0; copies hPlayerX to
; wObject5 + SCRIPTOBJ_X; copies hPlayerY to wObject5 + SCRIPTOBJ_Y; sets wObject5 to $80; advances
; wScriptStep
SceneShield2_RunFieldCommandTemp0::
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

; implements script command type 4A (SCRIPT_SCENE_SHIELD): a cutscene step named after the scene its
; only script shows: after '0 checked the shield.' (starts a scripted encounter); reached through
; ScriptCommand4A in bank $10 (E-0038, E-0245)
SceneShield::
    ld a, [wScriptStep]
    jumptable
    dw SceneShield_ShowTchObstinateAndFoolish
    dw SceneShield_ToScriptStepFlashScreenNegative
    dw SceneShield_StepScriptParam0Counter_Bank0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield_ShowImpetuousFoolIllShow
    dw SceneShield_RunMessageBoxFar_Bank0F
    dw SceneShield_ShowWhaNoMyMonsters
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield_ShowABeautifulVoiceEchoed
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield_ShowIBoreWitnessTo
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 10 of SceneShield: shows 'I bore witness to it'; sets EVENT_SCENE_SHIELD_1E4; advances
; wScriptStep
SceneShield_ShowIBoreWitnessTo::
    ld hl, $0a05 ; '*: I bore witness to it'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_SHIELD_1E4
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; step 8 of SceneShield: copies wScriptParam1 to hTemp1; sets hTemp0 to 1; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; shows 'A beautiful voice echoed…'; advances
; wScriptStep
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

; step 6 of SceneShield: shows 'Wha… No! My monsters! It'; copies wObject1 + OBJ_Y to wScriptParam1;
; advances wScriptStep
SceneShield_ShowWhaNoMyMonsters::
    ld hl, $0a04 ; '*: Wha… No! My monsters! It'
    call StartMessageHL_B0F
    ld a, [wObject1 + OBJ_Y]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneShield: calls RunMessageBoxFar_Bank0F; may return early; sets hTemp0 to $19; calls
; StartScriptedEncounterTemp0; advances wScriptStep
SceneShield_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $19
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneShield: branches on wTextYesNoResult; calls StartMessageHL_B0F; advances
; wScriptStep; calls StartMessageHL_B0F; sets wScriptStep to $0b
SceneShield_ShowImpetuousFoolIllShow::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, vTiles1 + $5d0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, vTiles1 + $5d1
    call StartMessageHL_B0F
    ld a, $0b
    ld [wScriptStep], a
    ret

; step 2 of SceneShield: branches on wScriptParam0; sets wObject1 + OBJ_Y to $20; sets wObject1 +
; OBJ_Y to $e0; calls StepScriptParam0Counter_Bank0F; may return early; sets wObject1 + OBJ_Y to
; $20; shows 'So it was you holding'; ...
SceneShield_StepScriptParam0Counter_Bank0F::
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
    ld hl, $4a02 ; '*: So it was you holding'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneShield: calls ScriptStepFlashScreenNegative
SceneShield_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

; step 0 of SceneShield: checks EVENT_SCENE_SHIELD; shows 'Tch, obstinate and foolish. You'; sets
; wScriptParam1 to 1; sets wScriptStep to 5; branches on wIsCGB; calls CopyBytes; sets
; EVENT_SCENE_SHIELD; ...
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

; implements script command type 66 (SCRIPT_SCENE_SHIELD_GUARDIAN): a cutscene step named after the
; scene its only script shows: before '0 checked the shield.' (encounter); reached through
; ScriptCommand66 in bank $10 (E-0038, E-0245)
SceneShieldGuardian::
    ld a, [wScriptStep]
    jumptable
    dw SceneShieldGuardian_ShowIWishYouWouldnt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_StepScriptParam0Counter_Bank0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_ShowISeeButI
    dw SceneShieldGuardian_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_Msg0AF0_WhatLoseToA
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_ShowOhMyGoodnessThank
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_ShowThatWasALovely
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_ScriptStepDeltaThenMessage
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShieldGuardian_ShowHelenIPutYou
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 14 of SceneShieldGuardian: shows 'Helen: I put you through trouble…'; sets
; EVENT_SCENE_SHIELD_GUARDIAN_1E2; advances wScriptStep
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

; step 12 of SceneShieldGuardian: sets wObject1 + OBJ_STATE to 2; calls ScriptStepDeltaThenMessage
SceneShieldGuardian_ScriptStepDeltaThenMessage::
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld de, wObject1 + OBJ_Y
    ld hl, $0af4
    call ScriptStepDeltaThenMessage
    ret

; step 10 of SceneShieldGuardian: calls DecompressToVRAM; shows 'That was a lovely sleep.'; advances
; wScriptStep
SceneShieldGuardian_ShowThatWasALovely::
    ld de, FieldSpriteGfx0F
    ld b, $7d
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

; step 8 of SceneShieldGuardian: sets hTemp0 to 2; sets hTemp1 to $20; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wSpriteSlotCount to 2; sets wObject1 +
; OBJ_STATE to 3; shows 'Oh, my goodness! Thank you!'; ...
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

; step 6 of SceneShieldGuardian: shows 'What? Lose to a child's'; advances wScriptStep
SceneShieldGuardian_Msg0AF0_WhatLoseToA::
    ld hl, $0af0 ; '*: What? Lose to a child's'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of SceneShieldGuardian: calls RunMessageBoxFar_Bank0F; may return early; sets hTemp0 to 4;
; calls StartScriptedEncounterTemp0; advances wScriptStep
SceneShieldGuardian_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $04
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneShieldGuardian: branches on wTextYesNoResult; calls StartMessageHL_B0F; advances
; wScriptStep; calls StartMessageHL_B0F; sets wScriptStep to $0f
SceneShieldGuardian_ShowISeeButI::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, vTiles1 + $5ce
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, vTiles1 + $5cf
    call StartMessageHL_B0F
    ld a, $0f
    ld [wScriptStep], a
    ret

; step 2 of SceneShieldGuardian: sets wObject2 + OBJ_Y to $20; branches on wScriptParam0; sets
; wSpriteSlotCount to 3; sets wSpriteSlotCount to 2; calls StepScriptParam0Counter_Bank0F; may
; return early; sets wSpriteSlotCount to 3; ...
SceneShieldGuardian_StepScriptParam0Counter_Bank0F::
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
    ld hl, $4aee ; '*: Our plan called for chaos'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneShieldGuardian: checks EVENT_SCENE_SHIELD_GUARDIAN; shows 'I wish you wouldn't do';
; sets hTemp0 to $34; calls FindTemp0InInventoryList; calls RemoveInventorySlotShiftDown; sets
; EVENT_SCENE_SHIELD_GUARDIAN; advances wScriptStep; ...
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

; implements script command type 49 (SCRIPT_SCENE_MEDICINE_GIVEN): a cutscene step named after the
; scene its only script shows: after 'Pardon me? You have medicine?'; reached through
; ScriptCommand49 in bank $10 (E-0038, E-0245)
SceneMedicineGiven::
    ld a, [wScriptStep]
    jumptable
    dw SceneMedicineGiven_StepObjectTowardCoord
    dw SceneMedicineGiven_UpdatePlayerMovement
    dw SceneMedicineGiven_StepObjectTowardCoord_SetStepPtrHi_2
    dw SceneMedicineGiven_StepObjectTowardCoord_SetStepPtrHi

; step 3 of SceneMedicineGiven: branches on wObject1 + OBJ_Y; sets wStepPtrHi to 1; sets wStepTarget
; to 2; sets wStepPtrLo to $40; calls StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget
; to 1; ...
SceneMedicineGiven_StepObjectTowardCoord_SetStepPtrHi::
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

; step 2 of SceneMedicineGiven: branches on wObject1 + OBJ_X; sets wStepPtrHi to 1; sets wStepTarget
; to 3; sets wStepPtrLo to $30; calls StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget
; to 2; ...
SceneMedicineGiven_StepObjectTowardCoord_SetStepPtrHi_2::
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

; step 1 of SceneMedicineGiven: calls UpdatePlayerMovement; calls RunFieldActionRequestActionIfBit7;
; returns if bit 7 of wFieldActionRequest is set; advances wScriptStep
SceneMedicineGiven_UpdatePlayerMovement::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneMedicineGiven: sets wStepPtrHi to 0; sets wStepTarget to 3; sets wStepPtrLo to $50;
; calls StepObjectTowardCoord; sets wStepPtrHi to 0; sets wStepTarget to 2; sets wStepPtrLo to $e0;
; ...
SceneMedicineGiven_StepObjectTowardCoord::
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
    ld hl, $ff80
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 48 (SCRIPT_SCENE_PRINCESS_MEDICINE): a cutscene step named after
; the scene its only script shows: 'STOP DON'T MEDDLE' ... 'Pardon me? You have medicine?'
; (encounter, removes an item); reached through ScriptCommand48 in bank $10 (E-0038, E-0245)
ScenePrincessMedicine::
    ld a, [wScriptStep]
    jumptable
    dw ScenePrincessMedicine_QueueSoundEffect
    dw ScenePrincessMedicine_AddStepDeltaToPointedByte
    dw ScenePrincessMedicine_ScriptApplyStepDeltaAtDE
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw ScenePrincessMedicine_FindTemp0InInventoryList
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw ScenePrincessMedicine_StartScriptedEncounterTemp0AndStep
    dw ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw ScenePrincessMedicine_ShowYunasSoulFilledHer
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw ScenePrincessMedicine_ShowIveFinallyRememberedIm
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 11 of ScenePrincessMedicine: shows 'I've finally remembered. I'm Yuna,'; sets
; EVENT_SCENE_PRINCESS_MEDICINE_09D; advances wScriptStep
ScenePrincessMedicine_ShowIveFinallyRememberedIm::
    ld hl, $0ad5 ; '*: I've finally remembered. I'm Yuna,'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_PRINCESS_MEDICINE_09D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of ScenePrincessMedicine: sets hTemp0 to 2; sets hTemp1 to $30; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; decrements wSpriteSlotCount; shows 'Yuna's
; soul filled her body.'; advances wScriptStep
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

; step 7 of ScenePrincessMedicine: shows 'H-HOW… BUT I… THIS ISN'T……'; advances wScriptStep
ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS::
    ld hl, $0ad4 ; '*: H-HOW… BUT I… THIS ISN'T……'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 6 of ScenePrincessMedicine: sets hTemp0 to $18; calls StartScriptedEncounterTemp0; advances
; wScriptStep
ScenePrincessMedicine_StartScriptedEncounterTemp0AndStep::
    ld a, $18
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of ScenePrincessMedicine: sets hTemp0 to $33; calls FindTemp0InInventoryList; branches on
; hTemp0; calls RemoveInventorySlotShiftDown; branches on wTextYesNoResult; calls
; StartMessageHL_B0F; advances wScriptStep; ...
ScenePrincessMedicine_FindTemp0InInventoryList::
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
    ld hl, vTiles1 + $5cc
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b0_f:
    ld hl, vTiles1 + $5cd
    call StartMessageHL_B0F
    ld a, $0c
    ld [wScriptStep], a
    ret

; step 2 of ScenePrincessMedicine: branches on wScriptParam1; decrements wSpriteSlots + $c;
; increments wSpriteSlots + $c; calls ScriptApplyStepDeltaAtDE; may return early; advances
; wScriptStep; checks EVENT_SCENE_PRINCESS_MEDICINE; ...
ScenePrincessMedicine_ScriptApplyStepDeltaAtDE::
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
    ld hl, $4ad2 ; '*: NEVER DID I EXPECT YUNA'S'
    call StartMessageHL_B0F
    ld de, EVENT_SCENE_PRINCESS_MEDICINE
    call SetFlagBit
    ret

.set_script_step_to_06:
    ld a, $06
    ld [wScriptStep], a
    ret

; step 1 of ScenePrincessMedicine: decrements wObject1 + OBJ_X; increments wObject1 + OBJ_Y; copies
; E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments
; wScriptParam0; copies wObject1 + OBJ_STATE & $03 to wObject1 + OBJ_STATE; ...
ScenePrincessMedicine_AddStepDeltaToPointedByte::
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

; step 0 of ScenePrincessMedicine: branches on wObject1 + OBJ_X; branches on wObject1 + OBJ_Y; plays
; sound $65; advances wScriptStep; sets wScriptStep to 6
ScenePrincessMedicine_QueueSoundEffect::
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

; implements script command type 46 (SCRIPT_SCENE_CHEER_YUNA): a cutscene step named after the scene
; its only script shows: 'You're here to cheer Lady Yuna.' ... 'King Magnificent!'; reached through
; ScriptCommand46 in bank $10 (E-0038, E-0245)
SceneCheerYuna::
    ld a, [wScriptStep]
    jumptable
    dw SceneCheerYuna_StepObjectTowardCoord
    dw SceneCheerYuna_SetBit2AtHL_B0F
    dw SceneCheerYuna_StepScriptParam0Counter_Bank0F
    dw SceneCheerYuna_SetBit2AtHL_B0F_StepScriptParam0Counter_Bank0F
    dw SceneCheerYuna_StepScriptParam0Counter_Bank0F_ClearBit1AtHL_Bank0F
    dw SceneCheerYuna_SetBit2AtHL_B0F_StepScriptParam0Counter_Bank0F
    dw SceneCheerYuna_StepScriptParam0Counter_Bank0F_ClearBit1AtHL_Bank0F
    dw SceneCheerYuna_ShowEnoughEnoughOfThat
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneCheerYuna_ToScriptStepDeltaThenNextStep
    dw SceneCheerYuna_StepObjectTowardCoord_SetBit2AtHL_B0F
    dw SceneCheerYuna_WritePlayerFacing
    dw SceneCheerYuna_ShowIAmTheKing
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneCheerYuna_SetScriptSubStep
    dw SceneCheerYuna_ToRunScriptSubStep
    dw SceneCheerYuna_WritePlayerFacingAndScriptStartRequest

; step 16 of SceneCheerYuna: sets hPlayerFacing to 2; sets wScriptStartRequest to $80
SceneCheerYuna_WritePlayerFacingAndScriptStartRequest::
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 15 of SceneCheerYuna: calls RunScriptSubStep
SceneCheerYuna_ToRunScriptSubStep::
    farcall RunScriptSubStep
    ret

; step 14 of SceneCheerYuna: sets wScriptSubStep to 0; sets wScriptParam0 to 0; advances wScriptStep
SceneCheerYuna_SetScriptSubStep::
    xor a
    ld [wScriptSubStep], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 12 of SceneCheerYuna: sets wStepPtrLo to $40; calls StepPlayerUpTowardStepPtrLo; returns if
; wStepArrived is 0; shows 'I am the King. What'; advances wScriptStep
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

; step 11 of SceneCheerYuna: branches on hPlayerX; advances wScriptStep; branches on hPlayerX; calls
; UpdateFollowersOnStep_Bank0F; sets hPlayerFacing to 1; increments hPlayerX; calls
; UpdateFollowersOnStep_Bank0F; ...
SceneCheerYuna_WritePlayerFacing::
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

; step 10 of SceneCheerYuna: sets wStepPtrHi to 2; sets wStepTarget to 0; sets wStepPtrLo to $a0;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; calls SetBit2AtHL_B0F; calls
; PlayMapMusic; ...
SceneCheerYuna_StepObjectTowardCoord_SetBit2AtHL_B0F::
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

; step 9 of SceneCheerYuna: calls ScriptStepDeltaThenNextStep
SceneCheerYuna_ToScriptStepDeltaThenNextStep::
    ld de, wObject2 + OBJ_Y
    call ScriptStepDeltaThenNextStep
    ret

; step 7 of SceneCheerYuna: sets wObject2 + OBJ_STATE to 2; calls ClearBit2AtHL_Bank0F; shows
; 'Enough… Enough of that dancing!'; advances wScriptStep
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

; step 4 of SceneCheerYuna: calls StepScriptParam0Counter_Bank0F; may return early; sets wObject2 +
; OBJ_STATE to 1; calls ClearBit1AtHL_Bank0F; advances wScriptStep
SceneCheerYuna_StepScriptParam0Counter_Bank0F_ClearBit1AtHL_Bank0F::
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

; step 3 of SceneCheerYuna: calls SetBit2AtHL_B0F; calls StepScriptParam0Counter_Bank0F; may return
; early; calls SetBit1AtHL_Bank0F; advances wScriptStep
SceneCheerYuna_SetBit2AtHL_B0F_StepScriptParam0Counter_Bank0F::
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

; step 2 of SceneCheerYuna: calls StepScriptParam0Counter_Bank0F; may return early; sets wObject2 +
; OBJ_STATE to 3; calls ClearBit1AtHL_Bank0F; advances wScriptStep
SceneCheerYuna_StepScriptParam0Counter_Bank0F::
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

; step 1 of SceneCheerYuna: calls SetBit2AtHL_B0F; copies wFrameCounterLo & $03 to wObject2 +
; OBJ_STATE; copies E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte;
; increments wObject2 + OBJ_X; increments wScriptParam0; ...
SceneCheerYuna_SetBit2AtHL_B0F::
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

; step 0 of SceneCheerYuna: branches on wScriptParam0; sets wStepPtrHi to 2; sets wStepTarget to 1;
; sets wStepPtrLo to $70; calls StepObjectTowardCoord; calls SceneCheerYuna_WriteObject2; returns if
; wStepArrived is 0; ...
SceneCheerYuna_StepObjectTowardCoord::
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
    call SceneCheerYuna_WriteObject2
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
    call SceneCheerYuna_WriteObject2
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
    call SceneCheerYuna_WriteObject2
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; called from SceneCheerYuna_StepObjectTowardCoord: copies wFrameCounterLo & $03 to wObject2 +
; OBJ_STATE
SceneCheerYuna_WriteObject2::
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and $03
    ld [wObject2 + OBJ_STATE], a
    ret

; implements script command type 41 (SCRIPT_SCENE_EXPLOSION): a cutscene step named after the scene
; its only script shows: 'What? What was that explosion?' (screen shake and flash); reached through
; ScriptCommand41 in bank $10 (E-0038, E-0245)
SceneExplosion::
    ld a, [wScriptStep]
    jumptable
    dw SceneExplosion_TestFlagBit
    dw SceneExplosion_StepObjectTowardCoord
    dw SceneExplosion_ScriptStepShakeScreen
    dw SceneExplosion_RunMessageBoxFar_Bank0F
    dw SceneExplosion_Msg0348_DarnTakeThisSACRIFICE
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneExplosion_SetBit2AtHL_B0F
    dw SceneExplosion_ScriptStepFlashScreenNegative
    dw SceneExplosion_ToScriptStepShakeScreen
    dw SceneExplosion_QueueSoundEffect

; step 9 of SceneExplosion: increments wObject5 + SCRIPTOBJ_Y; returns unless wObject5 + SCRIPTOBJ_Y
; is $10; plays sound $72; sets wObject2 + OBJ_SPRITE_ID to $52; sets hTemp0 to $52; sets hTemp1 to
; 0; sets hTemp2 to 1; ...
SceneExplosion_QueueSoundEffect::
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

; step 8 of SceneExplosion: calls ScriptStepShakeScreen
SceneExplosion_ToScriptStepShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

; step 7 of SceneExplosion: calls ScriptStepFlashScreenNegative
SceneExplosion_ScriptStepFlashScreenNegative::
    ld a, $e0
    ld [wSpriteSlots + $b], a
    farcall ScriptStepFlashScreenNegative
    ret

; step 6 of SceneExplosion: calls SetBit2AtHL_B0F; increments wScriptParam0; may return early;
; increments hPlayerY; returns unless hPlayerY is $40; sets hTemp0 to 9; calls RunFieldCommandTemp0;
; ...
SceneExplosion_SetBit2AtHL_B0F::
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

; step 4 of SceneExplosion: shows 'Darn! Take this! SACRIFICE!'; advances wScriptStep
SceneExplosion_Msg0348_DarnTakeThisSACRIFICE::
    ld hl, $0348 ; '*: Darn! Take this! SACRIFICE!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneExplosion: calls RunMessageBoxFar_Bank0F; may return early; sets hTemp0 to 3; calls
; StartScriptedEncounterTemp0; advances wScriptStep
SceneExplosion_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $03
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneExplosion: calls ScriptStepShakeScreen; increments hPlayerY; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments wFollowerRecords +
; $2; copies E to wStepPtrLo; ...
SceneExplosion_ScriptStepShakeScreen::
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

; step 1 of SceneExplosion: sets wStepPtrLo to $20; sets wStepPtrHi to 0; sets wStepTarget to $80;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; plays sound $66; advances wScriptStep
SceneExplosion_StepObjectTowardCoord::
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

; step 0 of SceneExplosion: checks EVENT_SCENE_EXPLOSION; calls RedrawColumnsBesideScreen; sets
; EVENT_SCENE_EXPLOSION; advances wScriptStep; shows 'You again? I'll have to'; sets wScriptStep to
; 3
SceneExplosion_TestFlagBit::
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

; implements script command type 45 (SCRIPT_SCENE_PLAN_RUINED): a cutscene step named after the
; scene its only script shows: 'Arrgh, you've ruined my plan' ... 'Bravo! We're saved!' (starts a
; scripted encounter); reached through ScriptCommand45 in bank $10 (E-0038, E-0245)
ScenePlanRuined::
    ld a, [wScriptStep]
    jumptable
    dw ScenePlanRuined_TestFlagBit
    dw ScenePlanRuined_StepScriptParam0Counter_Bank0F
    dw ScenePlanRuined_StartScriptedEncounterTemp0AndStep
    dw ScenePlanRuined_ScriptStepBlinkObjectTemp0

; step 3 of ScenePlanRuined: sets hTemp0 to 0; sets hTemp1 to $40; calls ScriptStepBlinkObjectTemp0;
; returns if hTemp0 is 0; sets wScriptStartRequest to $80
ScenePlanRuined_ScriptStepBlinkObjectTemp0::
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

; step 2 of ScenePlanRuined: sets hTemp0 to $0c; calls StartScriptedEncounterTemp0; advances
; wScriptStep
ScenePlanRuined_StartScriptedEncounterTemp0AndStep::
    ld a, $0c
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of ScenePlanRuined: calls StepScriptParam0Counter_Bank0F; may return early; sets
; EVENT_SCENE_PLAN_RUINED; advances wScriptStep
ScenePlanRuined_StepScriptParam0Counter_Bank0F::
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, EVENT_SCENE_PLAN_RUINED
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of ScenePlanRuined: checks EVENT_SCENE_PLAN_RUINED; advances wScriptStep; branches on
; wScriptParam0; sets wObject2 + OBJ_Y to $e0; sets wObject2 + OBJ_Y to $40; calls
; StepScriptParam0Counter_Bank0F; may return early; ...
ScenePlanRuined_TestFlagBit::
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

; implements script command type 43 (SCRIPT_SCENE_WALL_EXIT): a cutscene step named after the scene
; its only script shows: '0 tapped on the wall.' ... 'Kameha That's it! That's the exit!'; reached
; through ScriptCommand43 in bank $10 (E-0038, E-0245)
SceneWallExit::
    ld a, [wScriptStep]
    jumptable
    dw SceneWallExit_RedrawColumnsBesideScreen
    dw SceneWallExit_ShowKamehaSoThatsWhere
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWallExit_SetBit2AtHL_B0F
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_SetBit2AtHL_B0F_2
    dw SceneWallExit_WriteScriptParam0AndObject1
    dw SceneWallExit_StepObjectTowardCoord
    dw SceneWallExit_ShowKamehaHeroThatWasnt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWallExit_StepObjectTowardCoord_SetStepPtrLo

; step 12 of SceneWallExit: branches on wObject1 + OBJ_Y; sets wStepPtrLo to $50; sets wStepPtrHi to
; 1; sets wStepTarget to $80; calls StepObjectTowardCoord; branches on wObject1 + OBJ_X; decrements
; wObject1 + OBJ_X; ...
SceneWallExit_StepObjectTowardCoord_SetStepPtrLo::
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

; step 10 of SceneWallExit: increments wObject1 + OBJ_Y; copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; calls ScriptStepShakeScreen; increments
; wScriptParam0; returns unless wScriptParam0 is $20; ...
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

; step 9 of SceneWallExit: sets wStepPtrLo to 0; sets wStepPtrHi to 1; sets wStepTarget to $82;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep; branches on
; wScriptParam1; ...
SceneWallExit_StepObjectTowardCoord::
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

; step 8 of SceneWallExit: increments wScriptParam0; may return early; increments wObject1 + OBJ_Y;
; returns unless wObject1 + OBJ_Y is $30; sets wScriptParam0 to 0; advances wScriptStep
SceneWallExit_WriteScriptParam0AndObject1::
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

; step 7 of SceneWallExit: calls SetBit2AtHL_B0F; branches on wObject1 + OBJ_X; increments wObject1
; + OBJ_X; sets wObject1 + OBJ_STATE to 1; sets wStepPtrLo to $20; sets wStepPtrHi to 1; sets
; wStepTarget to $82; ...
SceneWallExit_SetBit2AtHL_B0F_2::
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

; step 3 of SceneWallExit: calls SetBit2AtHL_B0F; calls UpdateFollowersOnStep_Bank0F; branches on
; wScriptParam1; increments hPlayerX; sets hPlayerFacing to 1; decrements hPlayerX; sets
; hPlayerFacing to 3; ...
SceneWallExit_SetBit2AtHL_B0F::
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

; step 1 of SceneWallExit: calls StepScriptParam0Counter_Bank0F; may return early; sets wObject5 to
; 0; advances wScriptStep; copies hPlayerX to wScriptParam1; shows 'Kameha: So that's where the
; exit'
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

; step 0 of SceneWallExit: calls RedrawColumnsBesideScreen; sets hTemp0 to 5; calls
; RunFieldCommandTemp0; sets wObject5 + SCRIPTOBJ_X to $30; sets wObject5 + SCRIPTOBJ_Y to $40;
; advances wScriptStep
SceneWallExit_RedrawColumnsBesideScreen::
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

; implements script command type 42 (SCRIPT_SCENE_REPORT_TO_KING): a cutscene step named after the
; scene its only script shows: 'We reported to the King that...'; reached through ScriptCommand42 in
; bank $10 (E-0038, E-0245)
SceneReportToKing::
    ld a, [wScriptStep]
    jumptable
    dw SceneReportToKing_StepObjectTowardCoord
    dw SceneReportToKing_UpdatePlayerMovement
    dw SceneReportToKing_StepObjectTowardCoord_SetStepPtrLo_2
    dw SceneReportToKing_Msg035A_WhatIsItYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneReportToKing_ScriptStepDeltaThenNextStep
    dw SceneReportToKing_StepObjectTowardCoord_SetStepPtrLo
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneReportToKing_DrawFullScreenBufferAtScroll
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneReportToKing_WriteFieldDrawFlagsAndScriptStep
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneReportToKing_WriteFieldDrawFlagsAndScriptStep_AdvanceScriptStep
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneReportToKing_WriteFieldDrawFlags
    dw SceneReportToKing_ScriptStartFadeAndAdvanceStep
    dw SceneReportToKing_SetBit1AtHL_Bank0FAndStep
    dw SceneReportToKing_AddStepDeltaToPointedByte

; step 17 of SceneReportToKing: branches on wScriptParam1; branches on hPlayerY; increments
; wScriptParam1; branches on hPlayerY; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; ...
SceneReportToKing_AddStepDeltaToPointedByte::
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

; step 16 of SceneReportToKing: calls SetBit1AtHL_Bank0F; plays sound $65; advances wScriptStep
SceneReportToKing_SetBit1AtHL_Bank0FAndStep::
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

; step 15 of SceneReportToKing: sets hPlayerX to $e0; sets hFieldDrawFlags to 0; sets hMapId to $4d;
; sets hMapScreenX to 0; sets hMapScreenY to 1; sets wWarpDestX to $40; sets wWarpDestY to $e0; ...
SceneReportToKing_ScriptStartFadeAndAdvanceStep::
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

; step 14 of SceneReportToKing: sets hFieldDrawFlags to $0f; advances wScriptStep
SceneReportToKing_WriteFieldDrawFlags::
    ld a, $0f
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 12 of SceneReportToKing: advances wScriptStep; sets hFieldDrawFlags to 7; may return early;
; sets wScriptStep to $0f
SceneReportToKing_WriteFieldDrawFlagsAndScriptStep_AdvanceScriptStep::
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

; step 10 of SceneReportToKing: advances wScriptStep; sets hFieldDrawFlags to 3; may return early;
; sets wScriptStep to $0f
SceneReportToKing_WriteFieldDrawFlagsAndScriptStep::
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

; step 8 of SceneReportToKing: calls DrawFullScreenBufferAtScroll; sets hFieldDrawFlags to 1; plays
; sound $65; advances wScriptStep
SceneReportToKing_DrawFullScreenBufferAtScroll::
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

; step 6 of SceneReportToKing: branches on wObject1 + OBJ_X; sets wStepPtrLo to $60; sets wStepPtrHi
; to 1; sets wStepTarget to $81; calls StepObjectTowardCoord; sets wStepPtrLo to $a0; sets
; wStepPtrHi to 1; ...
SceneReportToKing_StepObjectTowardCoord_SetStepPtrLo::
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

; step 5 of SceneReportToKing: sets wObject1 + OBJ_STATE to 2; calls ScriptStepDeltaThenNextStep
SceneReportToKing_ScriptStepDeltaThenNextStep::
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld de, wObject1 + OBJ_Y
    call ScriptStepDeltaThenNextStep
    ret

; step 3 of SceneReportToKing: shows 'What is it, you whelp!?'; advances wScriptStep
SceneReportToKing_Msg035A_WhatIsItYou::
    ld hl, $035a ; '*: What is it, you whelp!?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 40 (SCRIPT_SCENE_SPIRIT_ENVOY): a cutscene step named after the
; scene its only script shows: 'Ah, you are the spirit's envoy.' ... 'We reported to the King
; that...'; reached through ScriptCommand40 in bank $10 (E-0038, E-0245)
SceneSpiritEnvoy::
    ld a, [wScriptStep]
    jumptable
    dw SceneReportToKing_StepObjectTowardCoord
    dw SceneReportToKing_UpdatePlayerMovement
    dw SceneReportToKing_StepObjectTowardCoord_SetStepPtrLo_2
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneSpiritEnvoy_StepPlayerDownTowardStepPtrLo
    dw SceneReportToKing_UpdatePlayerMovement
    dw SceneSpiritEnvoy_StepPlayerDownTowardStepPtrLo_SetStepPtrLo
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneSpiritEnvoy_SetScriptStartRequestTo80

; step 10 of SceneSpiritEnvoy: sets wScriptStartRequest to $80
SceneSpiritEnvoy_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 6 of SceneSpiritEnvoy: sets wStepPtrLo to $10; calls StepPlayerDownTowardStepPtrLo; returns
; if wStepArrived is 0; advances wScriptStep
SceneSpiritEnvoy_StepPlayerDownTowardStepPtrLo_SetStepPtrLo::
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneSpiritEnvoy: sets wStepPtrLo to $80; calls StepPlayerDownTowardStepPtrLo; returns
; if wStepArrived is 0; sets wFieldActionRequest to $80; sets wScreenScrollDir to 8; increments
; hMapScreenY; sets hPlayerStateFlags; ...
SceneSpiritEnvoy_StepPlayerDownTowardStepPtrLo::
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
    ld hl, $ff80
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneReportToKing: branches on wObject1 + OBJ_Y; sets wStepPtrLo to $60; sets wStepPtrHi
; to 1; sets wStepTarget to 2; calls StepObjectTowardCoord; branches on wObject1 + OBJ_X; sets
; wStepPtrLo to $30; ...
SceneReportToKing_StepObjectTowardCoord_SetStepPtrLo_2::
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

; step 1 of SceneReportToKing: calls UpdatePlayerMovement; calls RunFieldActionRequestActionIfBit7;
; returns if bit 7 of wFieldActionRequest is set; advances wScriptStep
SceneReportToKing_UpdatePlayerMovement::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneReportToKing: sets wStepPtrHi to 1; sets wStepTarget to 2; sets wStepPtrLo to $e0;
; calls StepObjectTowardCoord; sets wStepPtrLo to 0; calls StepPlayerUpTowardStepPtrLo; returns if
; wStepArrived is 0; ...
SceneReportToKing_StepObjectTowardCoord::
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

; implements script command type 39 (also 3B); reached through ScriptCommand39 in bank $10 (E-0038)
SceneMermaidKingdom::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidKingdom_WriteScriptStepAndStepPtrLoEtc
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidKingdom_ShowKamehaGaspHackI
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_SetBit2AtHL_B0F
    dw SceneMermaidKingdom_WriteScriptParam0AndObject1Etc
    dw SceneMermaidKingdom_StepScriptParam0Counter_Bank0F
    dw SceneMermaidKingdom_ToScriptStepDeltaThenMessage
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_StepObjectTowardCoord
    dw SceneMermaidKingdom_ShowKahahaha
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_DecompressGraphicsTemp0ToTemp4
    dw SceneMermaidKingdom_ToScriptStepDeltaThenMessage_3
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE
    dw SceneMermaidKingdom_ToScriptStepDeltaThenMessage_2
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_SetFlagBit
    dw SceneMermaidKingdom_QueueSoundEffect
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_SetSpriteSlotCount
    dw SceneMermaidKingdom_StepPlayerDownTowardStepPtrLo
    dw SceneMermaidKingdom_ShowKamehaIWasStupid
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_WriteStepTargetAndStepPtrLoEtc
    dw SceneMermaidKingdom_StepPlayerLeftTowardStepPtrLo
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep
    dw SceneMermaidKingdom_StepScriptParam0Counter_Bank0F_AdvanceScriptStep
    dw SceneMermaidKingdom_ShowAVoiceEchoedFrom
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_Msg0873_WaheyHeroHearMe
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_ShowWarubouWaheyYouDid
    dw SceneMermaidKingdom_ToRunSceneScriptSubStep
    dw SceneMermaidKingdom_RunFieldCommandTemp0
    dw SceneMermaidKingdom_ShowWarubouWaheyYouCan
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_SetFlagBit_MarkKeyEntryKindTemp0Bit6

; step 49 of SceneMermaidKingdom: sets EVENT_SCENE_MERMAID_KINGDOM_022; sets hTemp0 to 3; calls
; MarkKeyEntryKindTemp0Bit6; sets wFarmLevel to 2; sets wScriptStartRequest to $80
SceneMermaidKingdom_SetFlagBit_MarkKeyEntryKindTemp0Bit6::
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

; step 47 of SceneMermaidKingdom: increments wObject5 + SCRIPTOBJ_Y; returns unless wObject5 +
; SCRIPTOBJ_Y is c; sets wObject5 to 0; shows 'Warubou: Wa-hey, you can now crush'; sets
; EVENT_SCENE_MERMAID_KINGDOM; advances wScriptStep
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

; step 46 of SceneMermaidKingdom: sets hTemp0 to $11; calls RunFieldCommandTemp0; copies hPlayerX to
; wObject5 + SCRIPTOBJ_X; sets wObject5 + SCRIPTOBJ_Y; sets wObject5 to $80; plays sound $85;
; advances wScriptStep
SceneMermaidKingdom_RunFieldCommandTemp0::
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

; step 45 of SceneMermaidKingdom: calls RunSceneScriptSubStep
SceneMermaidKingdom_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

; step 44 of SceneMermaidKingdom: sets hMapId to 5; sets hMapScreenX to 1; sets hMapScreenY to 0;
; sets wWarpDestX to $50; sets wWarpDestY to $30; sets wFieldTransitionKind to 1; sets
; wScreenTriggerCount to 0; ...
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

; step 42 of SceneMermaidKingdom: shows '…Wa-hey! 0, hear me? I'; advances wScriptStep
SceneMermaidKingdom_Msg0873_WaheyHeroHearMe::
    ld hl, $0873 ; '*: …Wa-hey! 0, hear me? I'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 40 of SceneMermaidKingdom: increments wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE;
; may return early; sets wObject5 to 0; shows 'A voice echoed from nowhere…'; advances wScriptStep
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

; step 39 of SceneMermaidKingdom: calls StepScriptParam0Counter_Bank0F; may return early; advances
; wScriptStep
SceneMermaidKingdom_StepScriptParam0Counter_Bank0F_AdvanceScriptStep::
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 38 of SceneMermaidKingdom: increments wObject5 + SCRIPTOBJ_X; decrements wObject5 +
; SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE; may return early; advances wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep::
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

; step 37 of SceneMermaidKingdom: sets wStepPtrLo to $50; calls StepPlayerLeftTowardStepPtrLo;
; returns if wStepArrived is 0; sets EVENT_SCENE_MERMAID_KINGDOM_05F; advances wScriptStep
SceneMermaidKingdom_StepPlayerLeftTowardStepPtrLo::
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

; step 36 of SceneMermaidKingdom: branches on wScriptParam0; sets wStepTarget to $83; sets
; wStepPtrLo to $70; branches on wScriptParam0; sets wStepTarget to $82; sets wStepPtrLo to $30;
; branches on wScriptParam0; ...
SceneMermaidKingdom_WriteStepTargetAndStepPtrLoEtc::
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

; step 34 of SceneMermaidKingdom: calls StepScriptParam0Counter_Bank0F; may return early; calls
; DecompressToVRAM; shows 'Kameha: I was stupid to trust'; advances wScriptStep
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
    ld b, $7d
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $03
    ld [wSpriteSlots + $2], a
    ld hl, $0871 ; 'Kameha: I was stupid to trust'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 33 of SceneMermaidKingdom: branches on wScriptParam0; sets wStepPtrLo to $10; calls
; StepPlayerDownTowardStepPtrLo; returns if wStepArrived is 0; increments wScriptParam0; branches on
; wStepArrived; sets wStepPtrLo to $80; ...
SceneMermaidKingdom_StepPlayerDownTowardStepPtrLo::
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

; step 32 of SceneMermaidKingdom: decrements wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE;
; may return early; plays sound $65; sets wSpriteSlotCount to 1; advances wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_SetSpriteSlotCount::
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

; step 31 of SceneMermaidKingdom: increments wScriptParam0; branches on wScriptParam0+1; sets
; wObject1 + OBJ_STATE to 3; sets wObject2 + OBJ_STATE; may return early; sets wObject5 to $80;
; plays sound $65; ...
SceneMermaidKingdom_QueueSoundEffect::
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

; step 30 of SceneMermaidKingdom: sets EVENT_SCENE_MERMAID_KINGDOM_07F; copies hPlayerX to
; wWarpDestX; copies hPlayerY to wWarpDestY; sets wFieldTransitionKind to 0; calls
; ScriptStartFadeAndAdvanceStep
SceneMermaidKingdom_SetFlagBit::
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

; step 21 of SceneMermaidKingdom: calls ScriptStepShakeScreen
SceneMermaidKingdom_ToScriptStepShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

; step 20 of SceneMermaidKingdom: calls ScriptApplyStepDeltaAtDE; may return early; plays sound $63;
; advances wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_AdvanceScriptStep_2::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; step 18 of SceneMermaidKingdom: calls ScriptStepDeltaThenMessage
SceneMermaidKingdom_ToScriptStepDeltaThenMessage_2::
    ld de, wObject2 + OBJ_Y
    ld hl, $0870
    call ScriptStepDeltaThenMessage
    ret

; step 17 of SceneMermaidKingdom: increments wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE;
; may return early; sets wObject5 to 0; advances wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE::
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

; step 15 of SceneMermaidKingdom: calls ScriptStepDeltaThenMessage
SceneMermaidKingdom_ToScriptStepDeltaThenMessage_3::
    ld de, wSpriteSlots + $c
    ld hl, $086f
    call ScriptStepDeltaThenMessage
    ret

; step 14 of SceneMermaidKingdom: sets hTemp0 to $e3; sets hTemp1 to 0; sets hTemp2 to 0; sets
; hTemp3 to 5; copies L to hTemp4; copies H to hTemp5; calls DecompressGraphicsTemp0ToTemp4; ...
SceneMermaidKingdom_DecompressGraphicsTemp0ToTemp4::
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

; step 12 of SceneMermaidKingdom: decrements wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE;
; may return early; shows 'Kahahaha…'; advances wScriptStep
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

; step 11 of SceneMermaidKingdom: sets wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to
; $50; calls StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget to 0; sets wStepPtrLo to
; $50; ...
SceneMermaidKingdom_StepObjectTowardCoord::
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

; step 9 of SceneMermaidKingdom: calls ScriptStepDeltaThenMessage
SceneMermaidKingdom_ToScriptStepDeltaThenMessage::
    ld de, wObject2 + OBJ_Y
    ld hl, $086d
    call ScriptStepDeltaThenMessage
    ret

; step 8 of SceneMermaidKingdom: branches on wObject2 + OBJ_X; increments wObject2 + OBJ_X; calls
; StepScriptParam0Counter_Bank0F; may return early; advances wScriptStep
SceneMermaidKingdom_StepScriptParam0Counter_Bank0F::
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

; step 7 of SceneMermaidKingdom: branches on wScriptParam1; increments wScriptParam0; returns unless
; wScriptParam1 is 0; decrements wObject1 + OBJ_X; returns unless wObject1 + OBJ_X is $30; sets
; wScriptParam1 to 1; increments wObject1 + OBJ_X; ...
SceneMermaidKingdom_WriteScriptParam0AndObject1Etc::
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

; step 6 of SceneMermaidKingdom: calls SetBit2AtHL_B0F; branches on wScriptParam0; sets wObject1 +
; OBJ_STATE to 3; decrements wObject1 + OBJ_X; returns unless wObject1 + OBJ_X is $40; increments
; wScriptParam0; branches on wObject1 + OBJ_X; ...
SceneMermaidKingdom_SetBit2AtHL_B0F::
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
    ld b, $7d
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, $45
    ld [wObject2 + OBJ_SPRITE_ID], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneMermaidKingdom: sets wStepPtrHi to 0; sets wStepTarget to $80; sets wStepPtrLo to
; $40; calls StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget to $80; sets wStepPtrLo
; to $40; ...
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

; step 4 of SceneWallExit: calls ScriptStepMoveFollowersToLeader
SceneWallExit_ToScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ret

; step 0 of SceneMermaidKingdom: branches on hPlayerX; sets wScriptStep to 4; sets wStepPtrLo to
; $40; calls StepPlayerLeftTowardStepPtrLo; returns if wStepArrived is 0; sets hPlayerFacing to 0;
; advances wScriptStep
SceneMermaidKingdom_WriteScriptStepAndStepPtrLoEtc::
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

; implements script command type 38 (SCRIPT_SCENE_KAMEHA_FLEES): a cutscene step named after the
; scene its only script shows: 'Kameha Arrrrh, clear the way!' ... 'Kameha Aiyeeeeeh'; reached
; through ScriptCommand38 in bank $10 (E-0038, E-0245)
SceneKamehaFlees::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaFlees_ScriptStepMoveFollowersToLeader
    dw SceneKamehaFlees_ScriptStepMoveFollowersToLeader
    dw SceneKamehaFlees_ScriptStepMoveFollowersToLeader
    dw SceneKamehaFlees_StepScriptParam0Counter_Bank0F
    dw SceneKamehaFlees_ClearBit2AtHL_Bank0F
    dw SceneKamehaFlees_UpdateFollowersOnStep_Bank0F
    dw SceneKamehaFlees_UpdateFollowersOnStep_Bank0F_ClearBit1AtHL_Bank0F
    dw SceneKamehaFlees_StepScriptParam0Counter_Bank0F
    dw SceneKamehaFlees_WriteObject2AndTemp0Etc
    dw SceneKamehaFlees_RedrawColumnsBesideScreen
    dw SceneKamehaFlees_AddStepDeltaToPointedByte
    dw SceneKamehaFlees_StepObjectTowardCoord
    dw SceneKamehaFlees_ToSceneKamehaFlees_SetFlagBit

; step 12 of SceneKamehaFlees: calls SceneKamehaFlees_SetFlagBit
SceneKamehaFlees_ToSceneKamehaFlees_SetFlagBit::
    call SceneKamehaFlees_SetFlagBit
    ret

; Increments wObject5 + SCRIPTOBJ_X; copies wScriptParam0 & $07 to wScriptParam0; copies the byte at
; SceneKamehaFlees_SetFlagBit_Data to wObject5 + SCRIPTOBJ_Y; returns unless wObject5 + SCRIPTOBJ_X
; is $a0; sets EVENT_SCENE_KAMEHA_FLEES; sets wScriptStartRequest to $80
SceneKamehaFlees_SetFlagBit::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    and $07
    ld [wScriptParam0], a
    ld hl, SceneKamehaFlees_SetFlagBit_Data
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

; data read by SceneKamehaFlees (8 bytes)
SceneKamehaFlees_SetFlagBit_Data::
    db $40, $3f, $40, $3f, $40, $3e, $40, $41

; step 11 of SceneKamehaFlees: calls SceneKamehaFlees_SetFlagBit; sets wStepPtrHi to 0; sets
; wStepTarget to $81; sets wStepPtrLo to $a0; calls StepObjectTowardCoord; sets wStepPtrHi to 1;
; sets wStepTarget to $81; ...
SceneKamehaFlees_StepObjectTowardCoord::
    call SceneKamehaFlees_SetFlagBit
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

; step 10 of SceneKamehaFlees: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; copies E to wStepPtrLo; ...
SceneKamehaFlees_AddStepDeltaToPointedByte::
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

; step 9 of SceneKamehaFlees: increments wObject5 + SCRIPTOBJ_Y; returns unless wObject5 +
; SCRIPTOBJ_Y is $40; calls RedrawColumnsBesideScreen; plays sound $66; sets wScriptParam0 to 0;
; advances wScriptStep; sets hFieldDrawFlags to $0e
SceneKamehaFlees_RedrawColumnsBesideScreen::
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

; step 8 of SceneKamehaFlees: branches on the byte at wSpriteSlots + $c; sets wSpriteSlots + $c to
; 3; branches on the byte at wSpriteSlots + $c; may return early; sets wObject2 + OBJ_STATE to 3;
; calls ClearBit2AtHL_Bank0F; sets hTemp0 to 7; ...
SceneKamehaFlees_WriteObject2AndTemp0Etc::
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

; step 3 of SceneKamehaFlees: calls StepScriptParam0Counter_Bank0F; may return early; calls
; SetBit2AtHL_B0F; advances wScriptStep
SceneKamehaFlees_StepScriptParam0Counter_Bank0F::
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

; step 6 of SceneKamehaFlees: calls UpdateFollowersOnStep_Bank0F; increments wScriptParam0; returns
; unless wScriptParam0 is $1e; calls ClearBit1AtHL_Bank0F; sets wScriptParam0 to 0; advances
; wScriptStep
SceneKamehaFlees_UpdateFollowersOnStep_Bank0F_ClearBit1AtHL_Bank0F::
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

; step 5 of SceneKamehaFlees: calls UpdateFollowersOnStep_Bank0F; decrements hPlayerY; calls
; UpdateFollowersOnStep_Bank0F; decrements hPlayerY; returns unless hPlayerY is $30; advances
; wScriptStep
SceneKamehaFlees_UpdateFollowersOnStep_Bank0F::
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

; step 4 of SceneKamehaFlees: sets hPlayerFacing to 0; decrements wObject2 + OBJ_Y; decrements
; wObject1 + OBJ_Y; may return early; calls ClearBit2AtHL_Bank0F; calls SetBit1AtHL_Bank0F; plays
; sound $63; ...
SceneKamehaFlees_ClearBit2AtHL_Bank0F::
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

; step 0 of SceneKamehaFlees: calls ScriptStepMoveFollowersToLeader; calls SetBit2AtHL_B0F
SceneKamehaFlees_ScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B0F
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B0F
    ret

; implements script command type 37 (SCRIPT_SCENE_CREW_FOLLOWS): a cutscene step named after the
; scene its only script shows: 'Aye, aye, sir! Right behind you!'; reached through ScriptCommand37
; in bank $10 (E-0038, E-0245)
SceneCrewFollows::
    ld a, [wScriptStep]
    jumptable
    dw SceneCrewFollows_SetBit2AtHL_B0F
    dw SceneCrewFollows_StepScriptParam0Counter_Bank0F
    dw SceneCrewFollows_SetBit2AtHL_B0FAndStep
    dw SceneCrewFollows_WriteScriptParam0AndSpriteSlotsEtc

; step 3 of SceneCrewFollows: increments wScriptParam0; branches on wScriptParam0+1; sets wObject2 +
; OBJ_STATE to 3; sets wObject1 + OBJ_STATE; may return early; sets wScriptStartRequest to $80
SceneCrewFollows_WriteScriptParam0AndSpriteSlotsEtc::
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

; step 2 of SceneCrewFollows: calls SetBit2AtHL_B0F; sets wScriptParam0 to 0; advances wScriptStep
SceneCrewFollows_SetBit2AtHL_B0FAndStep::
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

; step 1 of SceneCrewFollows: branches on wFrameCounterLo & $03; sets hScrollX; calls
; StepScriptParam0Counter_Bank0F; may return early; sets hScrollX; sets
; EVENT_SCENE_CREW_FOLLOWS_07D; copies hPlayerX to wWarpDestX; ...
SceneCrewFollows_StepScriptParam0Counter_Bank0F::
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

; step 0 of SceneCrewFollows: calls SetBit2AtHL_B0F; may return early; calls ClearBit2AtHL_Bank0F;
; plays sound $7d; advances wScriptStep
SceneCrewFollows_SetBit2AtHL_B0F::
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

; implements script command type 36 (SCRIPT_SCENE_KAMEHA_CAUGHT): a cutscene step named after the
; scene its only script shows: 'Kameha Wahahahah! Thanks for guiding me' ... 'Kameha Urk! How you
; catch up?'; reached through ScriptCommand36 in bank $10 (E-0038, E-0245)
SceneKamehaCaught::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaCaught_SetBit2AtHL_B0FAndStep
    dw SceneKamehaCaught_WriteSpriteSlotCountAndScriptStartRequest

; step 0 of SceneKamehaCaught: calls SetBit2AtHL_B0F; sets wScriptParam0 to 0; advances wScriptStep
SceneKamehaCaught_SetBit2AtHL_B0FAndStep::
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

; step 1 of SceneKamehaCaught: branches on the byte at wSpriteSlots + $c; returns unless wObject2 +
; OBJ_Y is $e0; sets wSpriteSlotCount to 0; sets wScriptStartRequest to $80
SceneKamehaCaught_WriteSpriteSlotCountAndScriptStartRequest::
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

; implements script command type 32 (SCRIPT_GIVE_ITEM_BLINK): adds item wStepPtrLo to the inventory
; (AppendItemStepPtrLoToInventory) and blinks object hTemp0; '0 obtained YunaSoul.'; reached through
; ScriptCommand32 in bank $10 (E-0038, E-0245)
GiveItemBlink::
    ld a, [wScriptStep]
    jumptable
    dw GiveItemBlink_TestFlagBit

; step 0 of GiveItemBlink: checks EVENT_GIVE_ITEM_BLINK; sets hTemp0 to 0; sets hTemp1 to $20; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wSpriteSlotCount to 0; sets
; wScriptStartRequest to $80; ...
GiveItemBlink_TestFlagBit::
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

; implements script command type 29 (SCRIPT_SCENE_WHO_ARE_YOU): a cutscene step named after the
; scene its only script shows: after a sound and a 140-frame wait, before 'Who are you? This is
; our...' and 'Zzz Zzz Huh! Watch out!'; reached through ScriptCommand29 in bank $10 (E-0038,
; E-0246)
SceneWhoAreYou::
    ld a, [wScriptStep]
    jumptable
    dw SceneWhoAreYou_SetBit2AtHL_B0F
    dw SceneWhoAreYou_ShowTchMadeMeWaste
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWhoAreYou_ToScriptStepDeltaThenNextStep
    dw SceneWhoAreYou_ShowKamehaHeyYoureHero
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWhoAreYou_StepObjectTowardCoord
    dw SceneWhoAreYou_WriteScriptParam0AndSpriteSlotsEtc
    dw SceneWhoAreYou_UpdateFollowersOnStep_Bank0F
    dw SceneWhoAreYou_UpdateFollowersOnStep_Bank0F_SetScriptParam0

; step 9 of SceneWhoAreYou: calls UpdateFollowersOnStep_Bank0F; increments wScriptParam0; returns
; unless wScriptParam0 is $1e; copies hPlayerStateFlags & $fd to hPlayerStateFlags; sets
; EVENT_SCENE_WHO_ARE_YOU; sets wScriptStartRequest to $80
SceneWhoAreYou_UpdateFollowersOnStep_Bank0F_SetScriptParam0::
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

; step 8 of SceneWhoAreYou: calls UpdateFollowersOnStep_Bank0F; increments hPlayerX; calls
; UpdateFollowersOnStep_Bank0F; increments hPlayerX; returns unless hPlayerX is $70; sets
; wScriptParam0 to 0; advances wScriptStep
SceneWhoAreYou_UpdateFollowersOnStep_Bank0F::
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

; step 7 of SceneWhoAreYou: branches on wScriptParam1; increments wScriptParam0; returns unless
; wScriptParam1 is 0; may return early; sets wScriptParam1 to 1; sets wStepPtrHi to 0; sets
; wStepTarget to $81; ...
SceneWhoAreYou_WriteScriptParam0AndSpriteSlotsEtc::
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

; step 6 of SceneWhoAreYou: sets wStepPtrHi to 0; sets wStepTarget to 3; sets wStepPtrLo to $30;
; calls StepObjectTowardCoord; sets wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to $70;
; ...
SceneWhoAreYou_StepObjectTowardCoord::
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

; step 4 of SceneWhoAreYou: sets wObject1 + OBJ_STATE to 0; sets wObject2 + OBJ_STATE to 0; sets
; wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to $60; calls StepObjectTowardCoord;
; returns if wStepArrived is 0; ...
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

; step 3 of SceneWhoAreYou: calls ScriptStepDeltaThenNextStep
SceneWhoAreYou_ToScriptStepDeltaThenNextStep::
    ld de, wSpriteSlots + $c
    call ScriptStepDeltaThenNextStep
    ret

; step 1 of SceneWhoAreYou: calls RunMessageBoxFar_Bank0F; may return early; sets wObject1 +
; OBJ_STATE to 1; shows 'Tch, made me waste my'; advances wScriptStep
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

; step 0 of SceneWhoAreYou: calls SetBit2AtHL_B0F; may return early; calls ClearBit2AtHL_Bank0F;
; sets wObject2 + OBJ_STATE to 3; shows 'Heh, that old man, he'; advances wScriptStep
SceneWhoAreYou_SetBit2AtHL_B0F::
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

; implements script command type 28 (SCRIPT_SHAKE_SCREEN): shakes the screen (ScriptStepShakeScreen)
; with a sound effect; reached through ScriptCommand28 in bank $10 (E-0038, E-0245)
ShakeScreen::
    ld a, [wScriptStep]
    jumptable
    dw ShakeScreen_RedrawColumnsBesideScreenAndStep
    dw ShakeScreen_ToScriptStepShakeScreen
    dw ShakeScreen_QueueSoundEffect

; step 0 of ShakeScreen: calls RedrawColumnsBesideScreen; plays sound $7d; advances wScriptStep
ShakeScreen_RedrawColumnsBesideScreenAndStep::
    farcall RedrawColumnsBesideScreen
    ld a, $7d
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of ShakeScreen: calls ScriptStepShakeScreen
ShakeScreen_ToScriptStepShakeScreen::
    ld b, $78
    call ScriptStepShakeScreen
    ret

; step 2 of ShakeScreen: plays sound $00; sets wScriptStartRequest to $80
ShakeScreen_QueueSoundEffect::
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; called from SceneKamehaEscape_WriteStepPtrLo: works on registers only
SceneKamehaEscape_WriteScrollXAndScrollXHi::
    ld a, [wStepPtrLo]
    ld b, a

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

; implements script command type 27 (SCRIPT_SCENE_RIVAL_DEFEATED): a cutscene step named after the
; scene its only script shows: 'You defeated my monster? Urggh' ... 'You again! You're determined!';
; reached through ScriptCommand27 in bank $10 (E-0038, E-0245)
SceneRivalDefeated::
    ld a, [wScriptStep]
    jumptable
    dw SceneRivalDefeated_ScriptStepBlinkObjectTemp0
    dw SceneRivalDefeated_ShowKingYouThievesTheres
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_StepPlayerLeftTowardStepPtrLo
    dw SceneKamehaFlees_ScriptStepMoveFollowersToLeader
    dw SceneKamehaFlees_ScriptStepMoveFollowersToLeader
    dw SceneKamehaFlees_ScriptStepMoveFollowersToLeader
    dw SceneRivalDefeated_ShowKingSurrenderAndLive
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_QueueSoundEffect
    dw SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_QueueSoundEffect
    dw SceneRivalDefeated_Msg019C_UrgahMercyISurrender
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_DecompressToVRAM
    dw SceneRivalDefeated_StepObjectTowardCoord
    dw SceneRivalDefeated_ShowKingWahahWeveBagged
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_WriteObject5AndScriptTemp4Etc
    dw SceneRivalDefeated_ShowKingThisIsThe
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_ShowHeroObtainedTheTidalBell
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_Msg01A0_KingIveBeenA
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_ShowAVoiceEchoedFrom
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_Msg01A2_WaheyCanYouHear
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_ShowWarubouWaheyYouDid
    dw SceneRivalDefeated_ToRunSceneScriptSubStep
    dw SceneRivalDefeated_RunFieldCommandTemp0
    dw SceneRivalDefeated_ShowWarubouWaheyTheAbility
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_SetFlagBit

; step 35 of SceneRivalDefeated: sets EVENT_SCENE_RIVAL_DEFEATED_021; sets hTemp0 to 2; calls
; MarkKeyEntryKindTemp0Bit6; sets wFarmLevel to 1; sets wScriptStartRequest to $80
SceneRivalDefeated_SetFlagBit::
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

; step 33 of SceneRivalDefeated: increments wObject5 + SCRIPTOBJ_Y; returns unless wObject5 +
; SCRIPTOBJ_Y is c; sets wObject5 to 0; shows 'Warubou: Wa-hey, the ability to cross'; sets
; EVENT_SCENE_RIVAL_DEFEATED; advances wScriptStep
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

; step 32 of SceneRivalDefeated: sets hTemp0 to $11; calls RunFieldCommandTemp0; copies hPlayerX to
; wObject5 + SCRIPTOBJ_X; sets wObject5 + SCRIPTOBJ_Y; sets wObject5 to $80; plays sound $85;
; advances wScriptStep
SceneRivalDefeated_RunFieldCommandTemp0::
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

; step 31 of SceneRivalDefeated: calls RunSceneScriptSubStep
SceneRivalDefeated_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

; step 30 of SceneRivalDefeated: sets hMapId to 5; sets hMapScreenX to 1; sets hMapScreenY to 0;
; sets wWarpDestX to $50; sets wWarpDestY to $30; sets wFieldTransitionKind to 1; sets
; wScreenTriggerCount to 0; ...
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

; step 28 of SceneRivalDefeated: shows '…Wa-hey! Can you hear me?'; advances wScriptStep
SceneRivalDefeated_Msg01A2_WaheyCanYouHear::
    ld hl, $01a2 ; '*: …Wa-hey! Can you hear me?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 26 of SceneRivalDefeated: sets wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to
; $a0; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wSpriteSlotCount to 0; shows
; 'A voice echoed from nowhere…'; ...
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

; step 24 of SceneRivalDefeated: shows 'King: I've been a burden to'; advances wScriptStep
SceneRivalDefeated_Msg01A0_KingIveBeenA::
    ld hl, $01a0 ; 'King: I've been a burden to'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 22 of SceneRivalDefeated: decrements wObject5 + SCRIPTOBJ_X; increments wObject5 +
; SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE; may return early; shows '0 obtained the TidalBell.';
; sets wObject5 to 0; copies wScriptTemp4 to wPartyCount; ...
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

; step 20 of SceneRivalDefeated: decrements wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE;
; may return early; shows 'King: This is the TidalBell. It's'; advances wScriptStep
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

; step 19 of SceneRivalDefeated: sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to
; $20; sets wObject5 to $80; copies wPartyCount to wScriptTemp4; branches on wPartyCount; sets
; wPartyCount to 2; advances wScriptStep
SceneRivalDefeated_WriteObject5AndScriptTemp4Etc::
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

; step 17 of SceneRivalDefeated: sets wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to
; $20; calls StepObjectTowardCoord; returns if wStepArrived is 0; shows 'King: Wahah! We've bagged
; the lot!'; advances wScriptStep
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

; step 16 of SceneRivalDefeated: sets wStepTarget to 0; sets wStepPtrLo to $a0; sets wStepPtrHi to
; 0; calls StepObjectTowardCoord; sets wStepPtrHi to 1; calls StepObjectTowardCoord; sets wStepPtrHi
; to 2; ...
SceneRivalDefeated_StepObjectTowardCoord::
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
    ld b, $7d
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $22
    ld [wSpriteSlots + $2], a
    ld a, $e0
    ld [wSpriteSlots + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 15 of SceneRivalDefeated: sets wObject2 + OBJ_Y to $e0; sets wObject3 + OBJ_Y to $b0; sets
; wObject1 + OBJ_Y to $c0; calls DecompressToVRAM; sets wObject1 + OBJ_SPRITE_ID to $27; advances
; wScriptStep
SceneRivalDefeated_DecompressToVRAM::
    ld a, $e0
    ld [wObject2 + OBJ_Y], a
    ld a, $b0
    ld [wObject3 + OBJ_Y], a
    ld a, $d0
    ld [wSpriteSlots + $c], a
    ld a, $c0
    ld [wObject1 + OBJ_Y], a
    ld de, FieldSpriteGfx27
    ld b, $7d
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $27
    ld [wSpriteSlots + $2], a
    ld de, FieldSpriteGfx27
    ld b, $7d
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld a, $27
    ld [wObject1 + OBJ_SPRITE_ID], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of SceneRivalDefeated: shows 'Urgah! Mercy! I surrender!'; advances wScriptStep
SceneRivalDefeated_Msg019C_UrgahMercyISurrender::
    ld hl, $019c ; '*: Urgah! Mercy! I surrender!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 10 of SceneRivalDefeated: shows 'Aiyeeh! Help me, boss!'; advances wScriptStep
SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss::
    ld hl, $019b ; '*: Aiyeeh! Help me, boss!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of SceneRivalDefeated: branches on wScriptParam0; plays sound $7c; plays sound $81;
; increments wScriptParam0; returns unless wScriptParam0 is $78; sets wScriptParam0 to 0; advances
; wScriptStep
SceneRivalDefeated_QueueSoundEffect::
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

; step 7 of SceneRivalDefeated: sets wStepTarget to 2; sets wStepPtrLo to $e0; sets wStepPtrHi to 1;
; calls StepObjectTowardCoord; sets wStepPtrHi to 2; calls StepObjectTowardCoord; sets wStepPtrHi to
; 3; ...
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

; step 3 of SceneRivalDefeated: sets wStepPtrLo to $30; calls StepPlayerLeftTowardStepPtrLo; returns
; if wStepArrived is 0; sets hPlayerFacing to 1; advances wScriptStep
SceneRivalDefeated_StepPlayerLeftTowardStepPtrLo::
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

; step 1 of SceneRivalDefeated: sets wStepTarget to 2; sets wStepPtrLo to $40; sets wStepPtrHi to 3;
; calls StepObjectTowardCoord; sets wStepPtrHi to 2; calls StepObjectTowardCoord; sets wStepPtrHi to
; 1; ...
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

; step 0 of SceneRivalDefeated: sets hTemp0 to 0; sets hTemp1 to $10; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets EVENT_SCENE_RIVAL_DEFEATED_05A; advances
; wScriptStep
SceneRivalDefeated_ScriptStepBlinkObjectTemp0::
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

; implements script command type 23 (SCRIPT_SCENE_WATER_SHORTAGE): a cutscene step named after the
; scene its only script shows: 'King The town's water shortage seems...' ... 'King Wha-what? What
; happened?'; reached through ScriptCommand23 in bank $10 (E-0038, E-0245)
SceneWaterShortage::
    ld a, [wScriptStep]
    jumptable
    dw SceneWaterShortage_StepPlayerLeftTowardStepPtrLo
    dw SceneWaterShortage_ScriptStartFadeAndAdvanceStep
    dw SceneWaterShortage_StepPlayerDownTowardStepPtrLo
    dw SceneWaterShortage_StepPlayerLeftTowardStepPtrLo_SetStepPtrLo
    dw SceneWaterShortage_SetScriptStartRequestTo80

; step 4 of SceneWaterShortage: sets wScriptStartRequest to $80
SceneWaterShortage_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 3 of SceneWaterShortage: sets wStepPtrLo to $20; calls StepPlayerLeftTowardStepPtrLo; returns
; if wStepArrived is 0; sets hMapId to $2e; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $20; ...
SceneWaterShortage_StepPlayerLeftTowardStepPtrLo_SetStepPtrLo::
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

; step 2 of SceneWaterShortage: sets wStepPtrLo to $60; calls StepPlayerDownTowardStepPtrLo;
; branches on wStepArrived; increments wScriptParam0; sets wStepPtrLo to $30; calls
; StepPlayerLeftTowardStepPtrLo; sets wStepPtrHi to 0; ...
SceneWaterShortage_StepPlayerDownTowardStepPtrLo::
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

; step 1 of SceneWaterShortage: sets hMapId to $25; sets hMapScreenX to 0; sets hMapScreenY to 0;
; sets wWarpDestX to $40; sets wWarpDestY to 8; sets wFieldTransitionKind to 1; calls
; ScriptStartFadeAndAdvanceStep; ...
SceneWaterShortage_ScriptStartFadeAndAdvanceStep::
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

; step 0 of SceneWaterShortage: branches on hPlayerX; sets wStepPtrLo to $40; calls
; StepPlayerLeftTowardStepPtrLo; sets wStepPtrLo to $80; calls StepPlayerDownTowardStepPtrLo;
; returns if wStepArrived is 0; advances wScriptStep
SceneWaterShortage_StepPlayerLeftTowardStepPtrLo::
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

; implements script command type 1F (SCRIPT_SCENE_MONSTER_INSPECTION): a cutscene step named after
; the scene its only script shows: 'Ah, three healthy monsters! Very well' ... 'Very good show! That
; was splendid'; reached through ScriptCommand1F in bank $10 (E-0038, E-0245)
SceneMonsterInspection::
    ld a, [wScriptStep]
    jumptable
    dw SceneMonsterInspection_ShowAndThatWasThe
    dw SceneMonsterInspection_RunMessageBoxFar_Bank0F
    dw SceneMonsterInspection_ShowNextMonstersWillPerform
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMonsterInspection_StepPlayerUpTowardStepPtrLo
    dw SceneMonsterInspection_StepPlayerUpTowardStepPtrLo_ClearBit2AtHL_Bank0F
    dw SceneMonsterInspection_StepScriptParam0Counter_Bank0F
    dw SceneMonsterInspection_ToRunScriptSubStep
    dw SceneMonsterInspection_StepPlayerDownTowardStepPtrLo
    dw SceneMonsterInspection_PlayMapMusic

; step 0 of SceneMonsterInspection: sets hMapId to $25; sets hMapScreenX to 0; sets hMapScreenY to
; 0; sets wWarpDestX to $50; sets wWarpDestY to $30; sets wFieldTransitionKind to 3; calls
; ScriptStartFadeAndAdvanceStep; ...
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

; step 1 of SceneMonsterInspection: calls RunMessageBoxFar_Bank0F; may return early; plays sound
; $6d; sets wScriptParam0 to 0; advances wScriptStep
SceneMonsterInspection_RunMessageBoxFar_Bank0F::
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

; step 2 of SceneMonsterInspection: calls StepScriptParam0Counter_Bank0F; may return early; calls
; RestartMapMusic; shows 'Next, monsters will perform some'; advances wScriptStep
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

; step 4 of SceneMonsterInspection: sets wStepPtrLo to 0; calls StepPlayerUpTowardStepPtrLo; returns
; if wStepArrived is 0; sets hMapId to $26; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $50; ...
SceneMonsterInspection_StepPlayerUpTowardStepPtrLo::
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

; step 5 of SceneMonsterInspection: sets wStepPtrLo to $40; calls StepPlayerUpTowardStepPtrLo;
; returns if wStepArrived is 0; calls ClearBit2AtHL_Bank0F; sets hPlayerFacing to 2; plays sound
; $6d; sets wScriptParam0 to 0; ...
SceneMonsterInspection_StepPlayerUpTowardStepPtrLo_ClearBit2AtHL_Bank0F::
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

; step 6 of SceneMonsterInspection: calls StepScriptParam0Counter_Bank0F; may return early; calls
; RestartMapMusic; sets wScriptSubStep to 0; advances wScriptStep
SceneMonsterInspection_StepScriptParam0Counter_Bank0F::
    ld b, $b4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    xor a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 7 of SceneMonsterInspection: calls RunScriptSubStep
SceneMonsterInspection_ToRunScriptSubStep::
    farcall RunScriptSubStep
    ret

; step 8 of SceneMonsterInspection: branches on wScriptParam0; increments wScriptParam0; plays sound
; $6d; sets wStepPtrLo to $80; calls StepPlayerDownTowardStepPtrLo; returns if wStepArrived is 0;
; sets hMapId to $25; ...
SceneMonsterInspection_StepPlayerDownTowardStepPtrLo::
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

; step 9 of SceneMonsterInspection: calls PlayMapMusic; sets wScriptStartRequest to $80
SceneMonsterInspection_PlayMapMusic::
    farcall PlayMapMusic
    ld a, [wStoryFlags + $61]
    or $01
    ld [wStoryFlags + $61], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 1D (SCRIPT_SCENE_LONG_FACES): a cutscene step named after the scene
; its only script shows: 'Slash Hey, why the long faces?'; reached through ScriptCommand1D in bank
; $10 (E-0038, E-0245)
SceneLongFaces::
    ld a, [wScriptStep]
    jumptable
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneLongFaces_StartMessageHL_B0F
    dw SceneLongFaces_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneLongFaces_StepObjectTowardCoord
    dw SceneLongFaces_ShowSlashDontWorryIm
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneLongFaces_ShowSlashAndHeroHas
    dw SceneLongFaces_ShowTaraThenItsYour
    dw SceneLongFaces_ScriptApplyStepDeltaAtDE
    dw SceneLongFaces_ShowSlashThatsSettledThen
    dw SceneLongFaces_RunMessageBoxFar_Bank0F_ScriptStartFadeAndAdvanceStep
    dw SceneLongFaces_WriteStoryFlagsAndScriptStartRequest

; step 12 of SceneLongFaces: sets wScriptStartRequest to $80
SceneLongFaces_WriteStoryFlagsAndScriptStartRequest::
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 11 of SceneLongFaces: calls RunMessageBoxFar_Bank0F; may return early; sets
; wFieldTransitionKind to 1; calls ScriptStartFadeAndAdvanceStep; sets wPartyCount to 1; sets
; EVENT_SCENE_LONG_FACES_002
SceneLongFaces_RunMessageBoxFar_Bank0F_ScriptStartFadeAndAdvanceStep::
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

; step 10 of SceneLongFaces: calls RunMessageBoxFar_Bank0F; may return early; sets wScriptParam0 to
; 0; advances wScriptStep; shows 'Slash: That's settled, then! We'll leave'
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

; step 9 of SceneLongFaces: calls ScriptApplyStepDeltaAtDE; may return early; sets hPlayerFacing to
; 1; sets wFollowerRecords to 3; advances wScriptStep
SceneLongFaces_ScriptApplyStepDeltaAtDE::
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

; step 8 of SceneLongFaces: calls RunMessageBoxFar_Bank0F; may return early; sets wScriptParam0 to
; 0; advances wScriptStep; checks EVENT_NEVER_SET; shows 'Tara: Then it's your job, 0!'; shows
; 'Cobi: Fine, 0. It's up to'
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

; step 7 of SceneLongFaces: sets wStepPtrHi to 0; sets wStepTarget to 3; sets wStepPtrLo to $70;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wScriptParam0 to 0; advances
; wScriptStep; ...
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

; step 5 of SceneLongFaces: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; returns unless wScriptParam0 is $20; sets
; hPlayerFacing to 2; sets wFollowerRecords to 2; ...
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

; step 4 of SceneLongFaces: branches on wScriptParam0; sets wStepPtrHi to 0; sets wStepTarget to 3;
; sets wStepPtrLo to $60; calls StepObjectTowardCoord; returns if wStepArrived is 0; increments
; wScriptParam0; ...
SceneLongFaces_StepObjectTowardCoord::
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

; step 2 of SceneLongFaces: calls RunMessageBoxFar_Bank0F; may return early; copies L to
; wMessageIndex; copies H to wMessageGroup; decrements wScriptStep
SceneLongFaces_RunMessageBoxFar_Bank0F::
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

; step 1 of SceneLongFaces: branches on wTextYesNoResult; copies L to wMessageIndex; copies H to
; wMessageGroup; calls StartMessageHL_B0F; advances wScriptStep; copies L to wMessageIndex; copies H
; to wMessageGroup; ...
SceneLongFaces_StartMessageHL_B0F::
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

; implements script command type 1C (SCRIPT_SCENE_WARUBOU_WARNING): a cutscene step named after the
; scene its only script shows: 'Warubou Dangerous are other worlds!' ... 'Slash Hey, why the long
; faces?'; reached through ScriptCommand1C in bank $10 (E-0038, E-0245)
SceneWarubouWarning::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouWarning_RunMessageBoxFar_Bank0F
    dw SceneWarubouWarning_ShowTaraIfWeDont
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWarubouWarning_StartMessageHL_B0F
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 3 of SceneWarubouWarning: advances wScriptStep; branches on wTextYesNoResult; calls
; StartMessageHL_B0F
SceneWarubouWarning_StartMessageHL_B0F::
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

; step 1 of SceneWarubouWarning: sets wFollowerRecords to 1; may return early; sets hPlayerFacing to
; 1; sets wFollowerRecords to 3; advances wScriptStep; checks EVENT_NEVER_SET; shows 'Tara: If we
; don't go find'; ...
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
    ld hl, $4094 ; 'Tara: If we don't go find'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $4089 ; 'Cobi: If we don't find a'
    call StartMessageHL_B0F
    ret

; step 0 of SceneWarubouWarning: calls RunMessageBoxFar_Bank0F; may return early; sets hMapId to 6;
; sets hMapScreenX to 0; sets hMapScreenY to 0; sets wWarpDestX to $70; sets wWarpDestY to $50; ...
SceneWarubouWarning_RunMessageBoxFar_Bank0F::
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

; implements script command type 77 (SCRIPT_SCENE_LAND_HO): a cutscene step named after the scene
; its only script shows: 'Land ho! There's GreatLog!'; reached through ScriptCommand77 in bank $10
; (E-0038, E-0245)
SceneLandHo::
    ld a, [wScriptStep]
    jumptable
    dw SceneLandHo_ScriptStartFadeAndAdvanceStep
    dw SceneLandHo_StepScriptParam0Counter_Bank0F
    dw SceneLandHo_SetBit2AtHL_B0F
    dw SceneLandHo_ComputeSpriteScrollOffsets
    dw SceneLandHo_ComputeSpriteScrollOffsets
    dw SceneLandHo_ComputeSpriteScrollOffsets
    dw SceneLandHo_ComputeSpriteScrollOffsets
    dw SceneLandHo_ComputeSpriteScrollOffsets
    dw SceneLandHo_ComputeSpriteScrollOffsets
    dw SceneLandHo_SetFieldActionStep
    dw SceneLandHo_WriteScriptParam0AndScrollY
    dw SceneLandHo_ShowThisIsATale
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneLandHo_ScriptStartFadeAndAdvanceStep_SetMapId
    dw SceneLandHo_DispatchTalkEvent

; step 14 of SceneLandHo: sets wTalkEventIndex to $0a; sets wTalkEventGroup to 2; calls
; DispatchTalkEvent
SceneLandHo_DispatchTalkEvent::
    ld a, $0a
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    ret

; step 13 of SceneLandHo: sets hMapId to 0; sets hMapScreenX to 1; sets hMapScreenY to 2; sets
; wWarpDestX to $50; sets wWarpDestY to $50; sets wFieldTransitionKind to 1; calls
; ScriptStartFadeAndAdvanceStep; ...
SceneLandHo_ScriptStartFadeAndAdvanceStep_SetMapId::
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

; step 11 of SceneLandHo: calls StepScriptParam0Counter_Bank0F; may return early; shows 'This is a
; tale of children'; advances wScriptStep
SceneLandHo_ShowThisIsATale::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, $0014 ; 'This is a tale of children'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; step 10 of SceneLandHo: increments wScriptParam0; may return early; branches on D; calls
; SceneLandHo_WriteBGWriteDestLoAndBGWriteDestHiEtc; sets hScrollY; advances wFieldActionStep;
; branches on wFieldActionStep; ...
SceneLandHo_WriteScriptParam0AndScrollY::
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
    call SceneLandHo_WriteBGWriteDestLoAndBGWriteDestHiEtc
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

; called from SceneLandHo_WriteScriptParam0AndScrollY: copies E to wBGWriteDestLo; copies D to
; wBGWriteDestHi; sets wBGWriteVertical to 0; sets wBGWriteCount to $14; returns if wIsCGB is 0;
; copies E to wAttrWriteDestLo; copies D to wAttrWriteDestHi; ...
SceneLandHo_WriteBGWriteDestLoAndBGWriteDestHiEtc::
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

; step 9 of SceneLandHo: sets wFieldActionStep to 0; advances wScriptStep
SceneLandHo_SetFieldActionStep::
    xor a
    ld [wFieldActionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneLandHo: increments wScriptParam0; may return early; branches on wScriptParam0;
; decrements hScrollY; calls ComputeSpriteScrollOffsets; sets wScriptParam0 to 0; sets hScrollY to
; 0; ...
SceneLandHo_ComputeSpriteScrollOffsets::
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

; step 2 of SceneLandHo: calls SetBit2AtHL_B0F; increments wScriptParam0; may return early; sets
; wScriptParam0 to 0; advances wScriptStep
SceneLandHo_SetBit2AtHL_B0F::
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

; step 1 of SceneLandHo: calls StepScriptParam0Counter_Bank0F; may return early; decrements
; hMapScreenY; calls LoadMapScreen; advances wScriptStep
SceneLandHo_StepScriptParam0Counter_Bank0F::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, hMapScreenY
    dec [hl]
    call LoadMapScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneLandHo: sets hMapId to $1c; sets hMapScreenX to 0; sets hMapScreenY to 1; sets
; wWarpDestX to $e0; sets wWarpDestY to 0; sets wFieldTransitionKind to 3; calls
; ScriptStartFadeAndAdvanceStep
SceneLandHo_ScriptStartFadeAndAdvanceStep::
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

; implements script command type 76; reached through ScriptCommand76 in bank $10 (E-0038)
ScriptCommand76_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand76_Run_ShowTheIslandIsSinking
    dw ScriptCommand76_Run_ShowTheIslandIsSinking
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw ScriptCommand76_Run_SetFlagBit

; step 3 of ScriptCommand76_Run: plays sound $76; sets EVENT_SCENE_LAND_HO; sets wFollowerRecords to
; 3; sets wObject3 + OBJ_Y to $e0; sets wScriptStartRequest to $80
ScriptCommand76_Run_SetFlagBit::
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

; step 0 of ScriptCommand76_Run: calls ScriptApplyStepDeltaAtDE; may return early; sets
; wScriptParam0 to 0; advances wScriptStep; checks EVENT_IN_THE_MIDDLE_OF_THE; shows 'The island is
; sinking? Hahah,'; shows 'It's pointless if you're dead.'
ScriptCommand76_Run_ShowTheIslandIsSinking::
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

; implements script command type 75 (SCRIPT_SCENE_AT_SEA): a cutscene step named after the scene its
; only script shows: after 'In the middle of the sea'; reached through ScriptCommand75 in bank $10
; (E-0038, E-0245)
SceneAtSea::
    ld a, [wScriptStep]
    jumptable
    dw SceneAtSea_ScriptStartFadeAndAdvanceStep
    dw SceneAtSea_StepScriptParam0Counter_Bank0F
    dw SceneAtSea_WriteObject3
    dw SceneAtSea_ScriptApplyStepDeltaAtDE

; step 3 of SceneAtSea: decrements wObject3 + OBJ_X; increments wObject3 + OBJ_Y; calls
; ScriptApplyStepDeltaAtDE; may return early; sets wScriptStartRequest to $80
SceneAtSea_ScriptApplyStepDeltaAtDE::
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

; step 2 of SceneAtSea: increments wObject3 + OBJ_Y; returns unless wObject3 + OBJ_Y is $30; sets
; wObject3 + OBJ_STATE to 3; advances wScriptStep
SceneAtSea_WriteObject3::
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

; step 1 of SceneAtSea: calls StepScriptParam0Counter_Bank0F; may return early; advances wScriptStep
SceneAtSea_StepScriptParam0Counter_Bank0F::
    ld b, $5a
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneAtSea: sets hMapId to $1d; sets hMapScreenX to 1; sets hMapScreenY to 0; sets
; wWarpDestX to $50; sets wWarpDestY to $40; sets wFieldTransitionKind to 2; calls
; ScriptStartFadeAndAdvanceStep; ...
SceneAtSea_ScriptStartFadeAndAdvanceStep::
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

; implements script command type 6B (SCRIPT_SCENE_VAULT_SETTLED): a cutscene step named after the
; scene its only script shows: 'You've come at the right...' ... 'Good, that's settled then. The
; Vault...'; reached through ScriptCommand6B in bank $10 (E-0038, E-0245)
SceneVaultSettled::
    ld a, [wScriptStep]
    jumptable
    dw SceneVaultSettled_ScriptApplyStepDeltaAtDE
    dw SceneVaultSettled_ShowTaraWellBeOK
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; step 1 of SceneVaultSettled: advances wScriptStep; checks EVENT_NEVER_SET; shows 'Tara: We'll be
; OK! I'm going'; shows 'Cobi: Sure, Mama! We'll be fine.'
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

; step 0 of SceneVaultSettled: copies hPlayerFacing to wFollowerRecords; calls
; ScriptApplyStepDeltaAtDE; may return early; advances wScriptStep
SceneVaultSettled_ScriptApplyStepDeltaAtDE::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 6A (SCRIPT_SCENE_HORSING_AROUND): a cutscene step named after the
; scene its only script shows: before 'Listen you two! Quit your horsing...'; reached through
; ScriptCommand6A in bank $10 (E-0038, E-0245)
SceneHorsingAround::
    ld a, [wScriptStep]
    jumptable
    dw SceneHorsingAround_WriteMessageIndexAndMessageGroup
    dw SceneHorsingAround_StepObjectTowardCoord
    dw SceneHorsingAround_WriteMessageIndex
    dw SceneHorsingAround_ScriptApplyStepDeltaAtDE

; step 3 of SceneHorsingAround: calls SceneHorsingAround_StepPlayerLeftTowardStepPtrLo; calls
; ScriptApplyStepDeltaAtDE; may return early; calls ClearBit2AtHL_Bank0F; sets wScriptStartRequest
; to $80
SceneHorsingAround_ScriptApplyStepDeltaAtDE::
    call SceneHorsingAround_StepPlayerLeftTowardStepPtrLo
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 2 of SceneHorsingAround: calls SceneHorsingAround_StepPlayerLeftTowardStepPtrLo; increments
; wMessageIndex; returns unless wMessageIndex is $20; sets wMessageIndex to 0; advances wScriptStep
SceneHorsingAround_WriteMessageIndex::
    call SceneHorsingAround_StepPlayerLeftTowardStepPtrLo
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

; step 1 of SceneHorsingAround: calls SceneHorsingAround_StepPlayerLeftTowardStepPtrLo; sets
; wStepTarget to 0; sets wStepPtrHi to 0; sets wStepPtrLo to $50; calls StepObjectTowardCoord;
; returns if wStepArrived is 0; advances wScriptStep
SceneHorsingAround_StepObjectTowardCoord::
    call SceneHorsingAround_StepPlayerLeftTowardStepPtrLo
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

; step 0 of SceneHorsingAround: calls SceneHorsingAround_StepPlayerLeftTowardStepPtrLo; copies L to
; wMessageIndex; copies H to wMessageGroup; returns unless H is $01; returns unless L is $40; sets
; wMessageIndex to 0; sets wMessageGroup to 0; ...
SceneHorsingAround_WriteMessageIndexAndMessageGroup::
    call SceneHorsingAround_StepPlayerLeftTowardStepPtrLo
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

; Branches on wScriptParam1; sets wStepPtrLo to $40; calls StepPlayerLeftTowardStepPtrLo; sets
; wStepPtrLo to $80; calls StepPlayerDownTowardStepPtrLo; sets wStepPtrLo to $80; calls
; StepPlayerRightTowardStepPtrLo; ...
SceneHorsingAround_StepPlayerLeftTowardStepPtrLo::
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

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
SetBit1AtHL_Bank0F::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit1AtHL_Bank0F::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
SetBit2AtHL_B0F::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit2AtHL_Bank0F::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

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

; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0
StartMessageHL_B0F::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

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

; step 3 of SceneHomecoming: calls RunMessageBoxFar_Bank0F; may return early; advances wScriptStep
SceneHomecoming_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of PersonalityMessage: calls RunMessageBoxFar_Bank0F; may return early; sets
; wScriptStartRequest to $80
PersonalityMessage_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $62, $00
