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
    dw ScenePendantSeller_UpdateFollowersOnStep_Bank0F_Case03

ScenePendantSeller_UpdateFollowersOnStep_Bank0F_Case03::
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
    ld hl, $40de
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
    dw SceneHomecoming_RunFieldCommandTemp0_Case08
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
    dw SceneHomecoming_WriteObject2AndPlayerXEtc_Case1D
    dw SceneHomecoming_Msg0DB8_WarubouWaheyIHave
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_WriteFollowerRecords
    dw SceneHomecoming_ScriptApplyStepDeltaAtDE
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneHomecoming_WriteObject2AndPlayerXEtc
    dw SceneHomecoming_WriteObject2AndPlayerXEtc_Case1D
    dw SceneHomecoming_WriteObject2AndPlayerXEtc
    dw SceneHomecoming_ScriptApplyStepDeltaAtDE_Case26
    dw SceneHomecoming_ToStartPaletteFadeAndStep
    dw SceneHomecoming_WaitFadeState
    dw SceneHomecoming_ShowTHEEND
    dw SceneHomecoming_WriteScriptParam0AndScriptParam1
    dw SceneHomecoming_WriteMapIdAndMapScreenXEtc
    dw SceneHomecoming_SetScriptStartRequestTo80

SceneHomecoming_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

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
    ld [wGameMode2State], a
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ld hl, wScriptStep
    inc [hl]
    ret

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
    ld [wArenaByte37], a
    ld hl, wScriptStep
    inc [hl]
    ret

; CopyBytes copies these 8 bytes to wOBJPaletteBuffer + $20 (E-0264)
; record: 8 bytes copied to wOBJPaletteBuffer + $20
OBJPaletteBufferPlus20Init_0F_425E::
    db $de, $67, $1f, $33, $3c, $12, $00, $00 ; entry 0

SceneHomecoming_WaitFadeState::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_ToStartPaletteFadeAndStep::
    ld a, $3f
    call StartPaletteFade
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_ScriptApplyStepDeltaAtDE_Case26::
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

SceneHomecoming_Msg0DB8_WarubouWaheyIHave::
    ld hl, $0db8 ; 'Warubou: Wa-hey… I have seen this…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_WriteObject2AndPlayerXEtc_Case1D::
    ld a, [wScriptParam0]
    ld hl, $431f
    add_a_to_hl
    ld a, [hl]
    xor $ff
    inc a
    ld c, a
    jr SceneHomecoming_WriteObject2AndPlayerXEtc_ReadObject2

SceneHomecoming_WriteObject2AndPlayerXEtc::
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wScriptParam0]
    ld hl, $431f
    add_a_to_hl
    ld a, [hl]
    ld c, a

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
    db $01, $00, $01, $00, $01, $01, $00, $ff, $01, $00, $00, $ff, $00, $ff, $ff, $00
    db $01, $00, $00, $00, $01, $01, $ff, $00, $00, $ff, $00, $00, $00, $ff, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $ff, $00, $00, $00, $ff, $01
    db $ff, $00, $00, $01, $ff, $ff, $ff, $00, $00, $00, $ff, $00, $00, $ff, $ff, $00

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

SceneHomecoming_ShowKamehaNoOnesTaking::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db7 ; 'Kameha: No one's taking this pie'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneHomecoming_ClearBit2AtHL_Bank0F::
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
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

SceneHomecoming_ShowKamehaYoureAGlutton::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db3 ; 'Kameha: You're a glutton! You haven't'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_ShowWarubouWAHEYSomePrince::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db2 ; 'Warubou: WA-HEY! Some Prince! Always a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_ShowKamehaIWentAnd::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db1 ; 'Kameha: I went and faced danger'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_ShowWarubouWaheyIWas::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0db0 ; 'Warubou: Wa-hey! I was the plug'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneHomecoming_ToScriptStepSetObjectBit2AndWait::
    farcall ScriptStepSetObjectBit2AndWait
    ret

SceneHomecoming_RunFieldCommandTemp0_Case08::
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

SceneHomecoming_StepScriptParam0Counter_Bank0F::
    ld a, $01
    ldh [hPlayerFacing], a
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

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
    dw SceneDarckDefeated_StepPlayerLeftTowardWC928
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
    dw SceneDarckDefeated_StepObjectTowardCoord_Case1B
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_StepObjectTowardCoord_Case1B
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_StepObjectTowardCoord_Case1B
    dw SceneDarckDefeated_StepObjectTowardCoord
    dw SceneDarckDefeated_ShowWarubouWaheyThatsIt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_StepPlayerDownTowardWC928
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
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case2E
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case2F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case34
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case35
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case36
    dw SceneDarckDefeated_StepObjectTowardCoord_Case37
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case38
    dw SceneDarckDefeated_StepObjectTowardCoord_Case39
    dw SceneDarckDefeated_StepObjectTowardCoord_Case3A
    dw SceneDarckDefeated_WriteStepPtrHiAndStepPtrLoEtc
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case3C
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case41
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case42
    dw SceneDarckDefeated_StepObjectTowardCoord_Case43
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case45
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case45
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case48
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case4A
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case4B
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case50
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case51
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject1AndObject2Etc
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case54
    dw SceneDarckDefeated_WriteScriptParam0AndObject1Etc
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case56
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case5B
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case5C
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case5F
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case60
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case62
    dw SceneDarckDefeated_AddStepDeltaToPointedByte
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case65
    dw SceneDarckDefeated_StepObjectTowardCoord_Case66
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case68
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case6D
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case6E
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case70
    dw SceneDarckDefeated_StepObjectTowardCoord_Case71
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case73
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteStepPtrLoAndStepTargetEtc
    dw SceneDarckDefeated_StepObjectTowardCoord_Case76
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepObjectTowardCoord_Case78
    dw SceneDarckDefeated_StepObjectTowardCoord_Case79
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case7E
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case7F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw ScriptStepMoveObjects2And3To0340
    dw ScriptStepFlickerObjectCB9B
    dw ScriptStepDeltaWCBABThenCopy
    dw ScriptStepMoveObjects2And3To81B0
    dw SceneDarckDefeated_WriteObject5AndScriptParam0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case88
    dw SceneDarckDefeated_RunFieldCommandTemp0_Case89
    dw SceneDarckDefeated_WriteFieldEventArgAndObject5_Case8A
    dw SceneDarckDefeated_WriteFieldEventArgAndObject5_Case8A
    dw SceneDarckDefeated_SetObject5
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case8F
    dw SceneDarckDefeated_Msg053B_KingIThankYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneDarckDefeated_QueueSoundEffect
    dw SceneDarckDefeated_ShowKingEvenThoughThe
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

SceneDarckDefeated_ShowKingEvenThoughThe::
    ld hl, $053c ; 'King: Even though the island's crisis'
    call StartMessageHL_B0F
    ld a, $06
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneDarckDefeated_Msg053B_KingIThankYou::
    ld hl, $053b ; 'King: I thank you all for'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case8F::
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

SceneDarckDefeated_SetObject5::
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_RunFieldCommandTemp0_Case89::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case88::
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
; move finishes (carry) wScriptStep += 1 (E-0119)
ScriptStepDeltaWCBABThenCopy::
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

SceneDarckDefeated_RunFieldCommandTemp0_Case7F::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case7E::
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

SceneDarckDefeated_StepObjectTowardCoord_Case79::
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

SceneDarckDefeated_StepObjectTowardCoord_Case78::
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

SceneDarckDefeated_StepObjectTowardCoord_Case76::
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

SceneDarckDefeated_WriteStepPtrLoAndStepTargetEtc::
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    jr SceneDarckDefeated_StepObjectTowardCoord_Case73_SetStepPtrHiTo04

SceneDarckDefeated_StepObjectTowardCoord_Case73::
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a

SceneDarckDefeated_StepObjectTowardCoord_Case73_SetStepPtrHiTo04::
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

SceneDarckDefeated_StepObjectTowardCoord_Case71::
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

SceneDarckDefeated_StepObjectTowardCoord_Case70::
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

SceneDarckDefeated_RunFieldCommandTemp0_Case6E::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case6D::
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

SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case68::
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

SceneDarckDefeated_StepObjectTowardCoord_Case66::
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

SceneDarckDefeated_StepObjectTowardCoord_Case65::
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

SceneDarckDefeated_StepObjectTowardCoord_Case62::
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

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case60::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_StepObjectTowardCoord_Case5F::
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

SceneDarckDefeated_RunFieldCommandTemp0_Case5C::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case5B::
    ld a, $49
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case56::
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

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case54::
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

SceneDarckDefeated_RunFieldCommandTemp0_Case51::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case50::
    ld a, $41
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case4B::
    ld de, wObject3 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_StepObjectTowardCoord_Case4A::
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

SceneDarckDefeated_StepObjectTowardCoord_Case48::
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

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case45::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_StepObjectTowardCoord_Case43::
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

SceneDarckDefeated_RunFieldCommandTemp0_Case42::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case41::
    ld a, $33
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case3C::
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

SceneDarckDefeated_WriteStepPtrHiAndStepPtrLoEtc::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr SceneDarckDefeated_StepObjectTowardCoord_Case37_SetStepTargetTo80

SceneDarckDefeated_StepObjectTowardCoord_Case3A::
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

SceneDarckDefeated_StepObjectTowardCoord_Case39::
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
    jr SceneDarckDefeated_StepObjectTowardCoord_Case37_SetStepTargetTo80

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case38::
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

SceneDarckDefeated_StepObjectTowardCoord_Case37::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a

SceneDarckDefeated_StepObjectTowardCoord_Case37_SetStepTargetTo80::
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

SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case36::
    ld b, $5a
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $c], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_RunFieldCommandTemp0_Case35::
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

SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case34::
    ld a, $2f
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

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

SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case2F::
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

SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case2E::
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

SceneDarckDefeated_WriteFieldEventArgAndMapIdEtc::
    ld a, $01
    ld [wFieldEventArg], a
    ld a, $26
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

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

SceneDarckDefeated_StepPlayerDownTowardWC928::
    xor a
    ld [wFieldEventArg], a
    ldh a, [hPlayerY]
    cp $40
    jr z, .set_step_ptr_lo_to_80
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ret

.set_step_ptr_lo_to_80:
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneDarckDefeated_StepObjectTowardCoord_Case1B::
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

SceneDarckDefeated_ScriptStepDeltaThenNextStep::
    xor a
    ld [wFieldEventArg], a
    ld de, hPlayerY
    call ScriptStepDeltaThenNextStep
    ret

SceneDarckDefeated_ShowWarubouWawaheyWeWere::
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0537 ; 'Warubou: Wa-wa-hey! We were too late!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_WriteFieldEventKindAndFieldEventTimerEtc::
    ld a, $0c
    ld [wFieldEventKind], a
    xor a
    ld [wFieldEventTimer], a

SceneDarckDefeated_SetFieldEventArg::
    xor a
    ld [wFieldEventArg], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_ShowWarubouWaheyFeelThat::
    xor a
    ld [wFieldEventArg], a
    ld hl, $0df7 ; 'Warubou: Wa-hey? Feel that, warooh? Did'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_ToScriptStepShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

SceneDarckDefeated_RedrawColumnsBesideScreenAndStep::
    ld a, $30
    ld [wObject1 + OBJ_Y], a
    xor a
    ld [wObject5], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

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

SceneDarckDefeated_Msg055B_WaheyCanYouHear::
    ld hl, $055b ; '*: Wa-hey! can you hear me,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneDarckDefeated_ScriptApplyStepDeltaAtDE::
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_StepPlayerLeftTowardWC928::
    ldh a, [hPlayerX]
    cp $40
    jr z, .set_step_ptr_lo_to_20
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

.set_step_ptr_lo_to_20:
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
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

SceneDarckDefeated_StepScriptParam0Counter_Bank0F::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

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
    ld de, $00d1
    call SetFlagBit
    ld a, [wStoryFlags + $65]
    set 0, a
    ld [wStoryFlags + $65], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneDarckDefeated_WriteFieldEventArgAndObject5_Case8A::
    xor a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and $0f
    jumptable
    dw SceneDarckDefeated_Case8A_WriteScriptSubStepAndObject5
    dw SceneDarckDefeated_Case8A_WriteObject5AndScriptSubStepEtc

SceneDarckDefeated_Case8A_WriteScriptSubStepAndObject5::
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
    ld de, ObjectPathTable_5284
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

SceneDarckDefeated_Case8A_WriteObject5AndScriptSubStepEtc::
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

SceneDarckDefeated_WriteFieldEventArgAndObject5::
    xor a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and $0f
    jumptable
    dw SceneDarckDefeated_Case28_WriteScriptSubStepAndObject5
    dw SceneDarckDefeated_Case28_WriteScriptSubStepAndScriptParam1

SceneDarckDefeated_Case28_WriteScriptSubStepAndObject5::
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, .skip
    inc a
    ld [wScriptSubStep], a
    ret

.skip:
    and $fe
    ld de, ObjectPathTable_5284
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

SceneDarckDefeated_Case28_WriteScriptSubStepAndScriptParam1::
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

; SceneDarckDefeated_Case28_Case00 reads, every other frame, the pair at $5284 + $30 *
; ((wScriptParam1 & $70) >> 4) + 2 * step into wObject5 + 5 and + 4, for 23 steps per path; 8 paths
; end at SceneThreeItems (E-0206, C1)
; record: 24 steps of two bytes (wObject5 + 5, wObject5 + 4), 12 per line
ObjectPathTable_5284::
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
    dw SceneThreeItems_Msg4487_DarckWellForMe
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
    dw SceneThreeItems_ToScriptStepDeltaThenMessage_Case18
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
    dw SceneThreeItems_ToScriptStepDeltaThenMessage_Case2A
    dw SceneThreeItems_RunMessageBoxFar_Bank0F

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
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneThreeItems_ToScriptStepDeltaThenMessage_Case2A::
    ld de, hPlayerY
    ld hl, $0a7e
    call ScriptStepDeltaThenMessage
    ret

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
    ld de, $00c3
    call SetFlagBit
    farcall PlayMapMusic
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, $0a7d ; 'Warubou: Wa-hey, there is little time'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneThreeItems_Msg0A7C_KamehaIIHave::
    ld hl, $0a7c ; 'Kameha: I… I have to go'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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
    ld de, $0024
    call SetFlagBit
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0a7a ; 'Warubou: Wa-hey! 0 and Kameha! I'
    call StartMessageHL_B0F
    ret

SceneThreeItems_Msg0491_WaheyCanYouHear::
    ld hl, $0491 ; '*: Wa-hey! Can you hear me,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneThreeItems_Msg0490_AVoiceEchoedFrom::
    ld hl, $0490 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneThreeItems_ToScriptStepDeltaThenMessage_Case18::
    ld de, wObject2 + OBJ_Y
    ld hl, $048f
    call ScriptStepDeltaThenMessage
    ret

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

SceneThreeItems_SetFlagBit::
    ld a, [wStoryFlags + $64]
    set 3, a
    ld [wStoryFlags + $64], a
    ld de, $00c2
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

SceneThreeItems_WriteSpriteSlotCount::
    ld a, $01
    ld [wSpriteSlotCount], a

SceneThreeItems_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

SceneThreeItems_QueueSoundEffect::
    ld a, $7a
    call QueueSoundEffect

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

SceneThreeItems_Msg048E_DarckIWillBe::
    ld hl, $048e ; 'Darck: I will be readying a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneThreeItems_Msg048D_HeroReceivedTheLimbo::
    ld hl, $048d ; '0 received the Limbo Key.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneThreeItems_Msg4487_DarckWellForMe::
    ld hl, $4487 ; 'Darck: Well, for me, anything that'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneThreeItems_ToScriptStepDeltaThenMessage::
    ld de, wSpriteSlots + $c
    ld hl, $0486
    call ScriptStepDeltaThenMessage
    ret

SceneThreeItems_Msg0485_GreetingsIAmDarck::
    ld hl, $0485 ; '*: Greetings! I am Darck, the'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat::
    ld hl, $0483 ; 'Kameha: Wha-wha whaaaat? What just happened'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneThreeItems_ToScriptStepShakeScreen::
    ld b, $78
    call ScriptStepShakeScreen
    ret

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

SceneGrave_ShowAhYoullDoIt::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b0_f
    ld hl, vTiles0 + $416
    call StartMessageHL_B0F
    ld de, $00a6
    call SetFlagBit
    ret

.call_start_message_hl_b0_f:
    ld hl, vTiles0 + $417
    call StartMessageHL_B0F
    ld de, $00a5
    call SetFlagBit
    ret

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
    ld de, $00c2
    call TestFlagBit
    jp c, .call_start_message_hl_b0_f6
    ld de, $00a7
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f5
    ld de, $00a6
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f4
    ld de, $00a5
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f3
    ld de, $00a4
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld de, $00a0
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
    ld de, $00a0
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
    dw SceneShield2_ScriptStartFadeAndAdvanceStep_Case06
    dw SceneShield2_StepScriptParam0Counter_Bank0F
    dw SceneShield2_ScriptStartFadeAndAdvanceStep
    dw SceneShield2_StepScriptParam0Counter_Bank0F
    dw SceneShield2_ScriptStartFadeAndAdvanceStep_Case0A
    dw SceneShield2_StepScriptParam0Counter_Bank0F_Case0B
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_ShowHeroReceivedTheSky
    dw SceneShield2_ShowAVoiceEchoedFrom
    dw SceneShield2_ShowWaheyHeroCanYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_ShowWarubouWaheyYouDid
    dw SceneShield2_ToRunSceneScriptSubStep
    dw SceneShield2_RunFieldCommandTemp0_Case13
    dw SceneShield2_ShowWarubouWaheyYouCan
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneShield2_SetFlagBit

SceneShield2_SetFlagBit::
    ld de, $0023
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
    ld de, $001e
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SceneShield2_RunFieldCommandTemp0_Case13::
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

SceneShield2_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

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

SceneShield2_ShowWaheyHeroCanYou::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0a0a ; '*: …Wa-hey! 0, can you hear'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneShield2_ShowAVoiceEchoedFrom::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0a09 ; 'A voice echoed from nowhere…'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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
    ld de, $01e5
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SceneShield2_StepScriptParam0Counter_Bank0F_Case0B::
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

SceneShield2_ScriptStartFadeAndAdvanceStep_Case0A::
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

SceneShield2_ScriptStartFadeAndAdvanceStep::
    ld a, [wStoryFlags + $63]
    set 1, a
    ld [wStoryFlags + $63], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SceneShield2_ScriptStartFadeAndAdvanceStep_Case06::
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

SceneShield2_StepScriptParam0Counter_Bank0F::
    ld b, $3c
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SceneShield2_ScriptApplyStepDeltaAtDE::
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneShield_ShowIBoreWitnessTo::
    ld hl, $0a05 ; '*: I bore witness to it'
    call StartMessageHL_B0F
    ld de, $01e4
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneShield_ShowWhaNoMyMonsters::
    ld hl, $0a04 ; '*: Wha… No! My monsters! It'
    call StartMessageHL_B0F
    ld a, [wObject1 + OBJ_Y]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneShield_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

SceneShield_ShowTchObstinateAndFoolish::
    ld de, $01e3
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
    ld de, $01e3
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

SceneShieldGuardian_ShowHelenIPutYou::
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, $0af5 ; 'Helen: I put you through trouble…'
    call StartMessageHL_B0F
    ld de, $01e2
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

SceneShieldGuardian_ScriptStepDeltaThenMessage::
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld de, wObject1 + OBJ_Y
    ld hl, $0af4
    call ScriptStepDeltaThenMessage
    ret

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

SceneShieldGuardian_Msg0AF0_WhatLoseToA::
    ld hl, $0af0 ; '*: What? Lose to a child's'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneShieldGuardian_ShowIWishYouWouldnt::
    ld de, $01e1
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $0aed ; '*: I wish you wouldn't do'
    call StartMessageHL_B0F
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, $01e1
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
    dw SceneMedicineGiven_StepObjectTowardCoord_Case02
    dw SceneMedicineGiven_StepObjectTowardCoord_Case03

SceneMedicineGiven_StepObjectTowardCoord_Case03::
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
    farcall StepPlayerUpTowardWC928
    ret

.set_step_ptr_lo_to_40:
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wObject1 + OBJ_STATE], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneMedicineGiven_StepObjectTowardCoord_Case02::
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
    farcall StepPlayerUpTowardWC928
    ret

.set_step_ptr_lo_to_30:
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SceneMedicineGiven_UpdatePlayerMovement::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

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
    farcall StepPlayerLeftTowardWC928
    ret

.set_step_ptr_lo_to_00:
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
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

ScenePrincessMedicine_ShowIveFinallyRememberedIm::
    ld hl, $0ad5 ; '*: I've finally remembered. I'm Yuna,'
    call StartMessageHL_B0F
    ld de, $009d
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

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

ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS::
    ld hl, $0ad4 ; '*: H-HOW… BUT I… THIS ISN'T……'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

ScenePrincessMedicine_StartScriptedEncounterTemp0AndStep::
    ld a, $18
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

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
    ld de, $009c
    call TestFlagBit
    jr c, .set_script_step_to_06
    ld hl, $4ad2 ; '*: NEVER DID I EXPECT YUNA'S'
    call StartMessageHL_B0F
    ld de, $009c
    call SetFlagBit
    ret

.set_script_step_to_06:
    ld a, $06
    ld [wScriptStep], a
    ret

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
    dw SceneCheerYuna_SetBit2AtHL_B0F_Case03
    dw SceneCheerYuna_StepScriptParam0Counter_Bank0F_Case04
    dw SceneCheerYuna_SetBit2AtHL_B0F_Case03
    dw SceneCheerYuna_StepScriptParam0Counter_Bank0F_Case04
    dw SceneCheerYuna_ShowEnoughEnoughOfThat
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneCheerYuna_ToScriptStepDeltaThenNextStep
    dw SceneCheerYuna_StepObjectTowardCoord_Case0A
    dw SceneCheerYuna_WritePlayerFacing
    dw SceneCheerYuna_ShowIAmTheKing
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneCheerYuna_SetScriptSubStep
    dw SceneCheerYuna_ToRunScriptSubStep
    dw SceneCheerYuna_WritePlayerFacingAndScriptStartRequest

SceneCheerYuna_WritePlayerFacingAndScriptStartRequest::
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneCheerYuna_ToRunScriptSubStep::
    farcall RunScriptSubStep
    ret

SceneCheerYuna_SetScriptSubStep::
    xor a
    ld [wScriptSubStep], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneCheerYuna_ShowIAmTheKing::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $03a1 ; '*: I am the King. What'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneCheerYuna_StepObjectTowardCoord_Case0A::
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

SceneCheerYuna_ToScriptStepDeltaThenNextStep::
    ld de, wObject2 + OBJ_Y
    call ScriptStepDeltaThenNextStep
    ret

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

SceneCheerYuna_StepScriptParam0Counter_Bank0F_Case04::
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

SceneCheerYuna_SetBit2AtHL_B0F_Case03::
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
    call SceneCheerYuna_Case00_WriteObject2
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
    call SceneCheerYuna_Case00_WriteObject2
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
    call SceneCheerYuna_Case00_WriteObject2
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneCheerYuna_Case00_WriteObject2::
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

SceneExplosion_ToScriptStepShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

SceneExplosion_ScriptStepFlashScreenNegative::
    ld a, $e0
    ld [wSpriteSlots + $b], a
    farcall ScriptStepFlashScreenNegative
    ret

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

SceneExplosion_Msg0348_DarnTakeThisSACRIFICE::
    ld hl, $0348 ; '*: Darn! Take this! SACRIFICE!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneExplosion_TestFlagBit::
    ld de, $0085
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    farcall RedrawColumnsBesideScreen
    ld de, $0085
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

ScenePlanRuined_StartScriptedEncounterTemp0AndStep::
    ld a, $0c
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

ScenePlanRuined_StepScriptParam0Counter_Bank0F::
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, $0093
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

ScenePlanRuined_TestFlagBit::
    ld de, $0093
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
    dw SceneWallExit_SetBit2AtHL_B0F_Case07
    dw SceneWallExit_WriteScriptParam0AndObject1
    dw SceneWallExit_StepObjectTowardCoord
    dw SceneWallExit_ShowKamehaHeroThatWasnt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWallExit_StepObjectTowardCoord_Case0C

SceneWallExit_StepObjectTowardCoord_Case0C::
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

SceneWallExit_SetBit2AtHL_B0F_Case07::
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
    dw SceneReportToKing_StepObjectTowardCoord_Case02
    dw SceneReportToKing_Msg035A_WhatIsItYou
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneReportToKing_ScriptStepDeltaThenNextStep
    dw SceneReportToKing_StepObjectTowardCoord_Case06
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneReportToKing_DrawFullScreenBufferAtScroll
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneReportToKing_WriteFieldDrawFlagsAndScriptStep
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneReportToKing_WriteFieldDrawFlagsAndScriptStep_Case0C
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneReportToKing_WriteFieldDrawFlags
    dw SceneReportToKing_ScriptStartFadeAndAdvanceStep
    dw SceneReportToKing_SetBit1AtHL_Bank0FAndStep
    dw SceneReportToKing_AddStepDeltaToPointedByte

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

SceneReportToKing_WriteFieldDrawFlags::
    ld a, $0f
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneReportToKing_WriteFieldDrawFlagsAndScriptStep_Case0C::
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

SceneReportToKing_StepObjectTowardCoord_Case06::
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

SceneReportToKing_ScriptStepDeltaThenNextStep::
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld de, wObject1 + OBJ_Y
    call ScriptStepDeltaThenNextStep
    ret

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
    dw SceneReportToKing_StepObjectTowardCoord_Case02
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneSpiritEnvoy_StepPlayerDownTowardWC928
    dw SceneReportToKing_UpdatePlayerMovement
    dw SceneSpiritEnvoy_StepPlayerDownTowardWC928_Case06
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneWallExit_ToScriptStepMoveFollowersToLeader
    dw SceneSpiritEnvoy_SetScriptStartRequestTo80

SceneSpiritEnvoy_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneSpiritEnvoy_StepPlayerDownTowardWC928_Case06::
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

SceneSpiritEnvoy_StepPlayerDownTowardWC928::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
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

SceneReportToKing_StepObjectTowardCoord_Case02::
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
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, $0322 ; '*: You're the envoy? …Well, no'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneReportToKing_UpdatePlayerMovement::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

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
    farcall StepPlayerUpTowardWC928
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
    dw SceneMermaidKingdom_ToScriptStepDeltaThenMessage_Case0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE
    dw SceneMermaidKingdom_ToScriptStepDeltaThenMessage_Case12
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14
    dw SceneMermaidKingdom_ToScriptStepShakeScreen
    dw SceneMermaidKingdom_SetFlagBit
    dw SceneMermaidKingdom_QueueSoundEffect
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case20
    dw SceneMermaidKingdom_StepPlayerDownTowardWC928
    dw SceneMermaidKingdom_ShowKamehaIWasStupid
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_WriteStepTargetAndStepPtrLoEtc
    dw SceneMermaidKingdom_StepPlayerLeftTowardWC928
    dw SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case26
    dw SceneMermaidKingdom_StepScriptParam0Counter_Bank0F_Case27
    dw SceneMermaidKingdom_ShowAVoiceEchoedFrom
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_Msg0873_WaheyHeroHearMe
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_ShowWarubouWaheyYouDid
    dw SceneMermaidKingdom_ToRunSceneScriptSubStep
    dw SceneMermaidKingdom_RunFieldCommandTemp0
    dw SceneMermaidKingdom_ShowWarubouWaheyYouCan
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneMermaidKingdom_SetFlagBit_Case31

SceneMermaidKingdom_SetFlagBit_Case31::
    ld de, $0022
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
    ld de, $001f
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneMermaidKingdom_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

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

SceneMermaidKingdom_Msg0873_WaheyHeroHearMe::
    ld hl, $0873 ; '*: …Wa-hey! 0, hear me? I'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneMermaidKingdom_StepScriptParam0Counter_Bank0F_Case27::
    ld b, $1e
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case26::
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

SceneMermaidKingdom_StepPlayerLeftTowardWC928::
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld de, $005f
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneMermaidKingdom_StepPlayerDownTowardWC928::
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
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
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_lo_to_30:
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case20::
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

SceneMermaidKingdom_SetFlagBit::
    ld a, [wStoryFlags + $62]
    set 3, a
    ld [wStoryFlags + $62], a
    ld de, $007f
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

SceneMermaidKingdom_ToScriptStepShakeScreen::
    ld b, $0f
    call ScriptStepShakeScreen
    ret

SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

SceneMermaidKingdom_ToScriptStepDeltaThenMessage_Case12::
    ld de, wObject2 + OBJ_Y
    ld hl, $0870
    call ScriptStepDeltaThenMessage
    ret

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

SceneMermaidKingdom_ToScriptStepDeltaThenMessage_Case0F::
    ld de, wSpriteSlots + $c
    ld hl, $086f
    call ScriptStepDeltaThenMessage
    ret

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

SceneMermaidKingdom_ToScriptStepDeltaThenMessage::
    ld de, wObject2 + OBJ_Y
    ld hl, $086d
    call ScriptStepDeltaThenMessage
    ret

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

SceneWallExit_ToScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ret

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
    farcall StepPlayerLeftTowardWC928
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
    dw SceneKamehaFlees_UpdateFollowersOnStep_Bank0F_Case06
    dw SceneKamehaFlees_StepScriptParam0Counter_Bank0F
    dw SceneKamehaFlees_WriteObject2AndTemp0Etc
    dw SceneKamehaFlees_RedrawColumnsBesideScreen
    dw SceneKamehaFlees_AddStepDeltaToPointedByte
    dw SceneKamehaFlees_StepObjectTowardCoord
    dw SceneKamehaFlees_ToSceneKamehaFlees_SetFlagBit

SceneKamehaFlees_ToSceneKamehaFlees_SetFlagBit::
    call SceneKamehaFlees_SetFlagBit
    ret

SceneKamehaFlees_SetFlagBit::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    and $07
    ld [wScriptParam0], a
    ld hl, $6d78
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, [wObject5 + SCRIPTOBJ_X]
    cp $a0
    ret nz
    ld de, $007e
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $40, $3f, $40, $3f, $40, $3e, $40, $41

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

SceneKamehaFlees_UpdateFollowersOnStep_Bank0F_Case06::
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
    ld de, $007d
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
; (AppendItemWC928ToInventory) and blinks object hTemp0; '0 obtained YunaSoul.'; reached through
; ScriptCommand32 in bank $10 (E-0038, E-0245)
GiveItemBlink::
    ld a, [wScriptStep]
    jumptable
    dw GiveItemBlink_TestFlagBit

GiveItemBlink_TestFlagBit::
    ld de, $0075
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
    ld de, $009b
    call TestFlagBit
    jr nc, .clear_sprite_slot_count
    ld a, $33
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory

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
    dw SceneWhoAreYou_UpdateFollowersOnStep_Bank0F_Case09

SceneWhoAreYou_UpdateFollowersOnStep_Bank0F_Case09::
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
    ld de, $0064
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

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

SceneWhoAreYou_ToScriptStepDeltaThenNextStep::
    ld de, wSpriteSlots + $c
    call ScriptStepDeltaThenNextStep
    ret

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

ShakeScreen_RedrawColumnsBesideScreenAndStep::
    farcall RedrawColumnsBesideScreen
    ld a, $7d
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

ShakeScreen_ToScriptStepShakeScreen::
    ld b, $78
    call ScriptStepShakeScreen
    ret

ShakeScreen_QueueSoundEffect::
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneKamehaEscape_Case02_WriteScrollXAndScrollXHi::
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
    dw SceneRivalDefeated_StepPlayerLeftTowardWC928
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

SceneRivalDefeated_SetFlagBit::
    ld de, $0021
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
    ld de, $001d
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneRivalDefeated_ToRunSceneScriptSubStep::
    farcall RunSceneScriptSubStep
    ret

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

SceneRivalDefeated_Msg01A2_WaheyCanYouHear::
    ld hl, $01a2 ; '*: …Wa-hey! Can you hear me?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneRivalDefeated_Msg01A0_KingIveBeenA::
    ld hl, $01a0 ; 'King: I've been a burden to'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneRivalDefeated_Msg019C_UrgahMercyISurrender::
    ld hl, $019c ; '*: Urgah! Mercy! I surrender!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss::
    ld hl, $019b ; '*: Aiyeeh! Help me, boss!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneRivalDefeated_StepPlayerLeftTowardWC928::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

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
    ld de, $005a
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
    dw SceneWaterShortage_StepPlayerLeftTowardWC928
    dw SceneWaterShortage_ScriptStartFadeAndAdvanceStep
    dw SceneWaterShortage_StepPlayerDownTowardWC928
    dw SceneWaterShortage_StepPlayerLeftTowardWC928_Case03
    dw SceneWaterShortage_SetScriptStartRequestTo80

SceneWaterShortage_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneWaterShortage_StepPlayerLeftTowardWC928_Case03::
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
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

SceneWaterShortage_StepPlayerDownTowardWC928::
    ld a, [wScriptParam0]
    and $0f
    jr nz, .set_step_ptr_lo_to_30
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a
    jr z, .set_step_ptr_hi_to_00
    ld hl, wScriptParam0
    inc [hl]
    jr .set_step_ptr_hi_to_00

.set_step_ptr_lo_to_30:
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928

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

SceneWaterShortage_StepPlayerLeftTowardWC928::
    ldh a, [hPlayerX]
    cp $40
    jr z, .set_step_ptr_lo_to_80
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

.set_step_ptr_lo_to_80:
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
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
    dw SceneMonsterInspection_StepPlayerUpTowardWC928
    dw SceneMonsterInspection_StepPlayerUpTowardWC928_Case05
    dw SceneMonsterInspection_StepScriptParam0Counter_Bank0F
    dw SceneMonsterInspection_ToRunScriptSubStep
    dw SceneMonsterInspection_StepPlayerDownTowardWC928
    dw SceneMonsterInspection_PlayMapMusic

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

SceneMonsterInspection_StepPlayerUpTowardWC928::
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
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

SceneMonsterInspection_StepPlayerUpTowardWC928_Case05::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
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

SceneMonsterInspection_ToRunScriptSubStep::
    farcall RunScriptSubStep
    ret

SceneMonsterInspection_StepPlayerDownTowardWC928::
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
    farcall StepPlayerDownTowardWC928
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
    dw SceneLongFaces_RunMessageBoxFar_Bank0F_Case0B
    dw SceneLongFaces_WriteStoryFlagsAndScriptStartRequest

SceneLongFaces_WriteStoryFlagsAndScriptStartRequest::
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneLongFaces_RunMessageBoxFar_Bank0F_Case0B::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wPartyCount], a
    ld de, $0002
    call SetFlagBit
    ret

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

SceneLongFaces_ShowTaraThenItsYour::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $009a ; 'Tara: Then it's your job, 0!'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $0092 ; 'Cobi: Fine, 0. It's up to'
    call StartMessageHL_B0F
    ret

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
    ld de, $0000
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $4094 ; 'Tara: If we don't go find'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $4089 ; 'Cobi: If we don't find a'
    call StartMessageHL_B0F
    ret

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
    dw SceneLandHo_ScriptStartFadeAndAdvanceStep_Case0D
    dw SceneLandHo_DispatchTalkEvent

SceneLandHo_DispatchTalkEvent::
    ld a, $0a
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    ret

SceneLandHo_ScriptStartFadeAndAdvanceStep_Case0D::
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
    ld de, $001b
    call SetFlagBit
    ld a, $01
    ldh [hPlayerSpriteMode], a
    xor a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ret

SceneLandHo_ShowThisIsATale::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, $0014 ; 'This is a tale of children'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

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
    call SceneLandHo_Case0A_WriteBGWriteDestLoAndBGWriteDestHiEtc
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

SceneLandHo_Case0A_WriteBGWriteDestLoAndBGWriteDestHiEtc::
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

SceneLandHo_SetFieldActionStep::
    xor a
    ld [wFieldActionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

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

ScriptCommand76_Run_SetFlagBit::
    ld a, $76
    call QueueSoundEffect
    ld de, $001b
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

ScriptCommand76_Run_ShowTheIslandIsSinking::
    ld de, wObject3 + OBJ_Y
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0001
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

SceneAtSea_StepScriptParam0Counter_Bank0F::
    ld b, $5a
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

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

SceneVaultSettled_ShowTaraWellBeOK::
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, .call_start_message_hl_b0_f
    ld hl, $0021 ; 'Tara: We'll be OK! I'm going'
    call StartMessageHL_B0F
    ret

.call_start_message_hl_b0_f:
    ld hl, $001f ; 'Cobi: Sure, Mama! We'll be fine.'
    call StartMessageHL_B0F
    ret

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

SceneHorsingAround_ScriptApplyStepDeltaAtDE::
    call SceneHorsingAround_StepPlayerLeftTowardWC928
    ld de, wSpriteSlots + $c
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SceneHorsingAround_WriteMessageIndex::
    call SceneHorsingAround_StepPlayerLeftTowardWC928
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

SceneHorsingAround_StepObjectTowardCoord::
    call SceneHorsingAround_StepPlayerLeftTowardWC928
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

SceneHorsingAround_WriteMessageIndexAndMessageGroup::
    call SceneHorsingAround_StepPlayerLeftTowardWC928
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

SceneHorsingAround_StepPlayerLeftTowardWC928::
    ld a, [wScriptParam1]
    or a
    jr nz, .skip
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    farcall StepPlayerLeftTowardWC928
    jr .check_step_arrived

.skip:
    dec a
    jr nz, .skip2
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    farcall StepPlayerDownTowardWC928
    jr .check_step_arrived

.skip2:
    dec a
    jr nz, .skip3
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    farcall StepPlayerRightTowardWC928
    jr .check_step_arrived

.skip3:
    dec a
    jr nz, .skip4
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    farcall StepPlayerUpTowardWC928
    jr .check_step_arrived

.skip4:
    dec a
    jr nz, .set_step_ptr_lo_to_50
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    farcall StepPlayerLeftTowardWC928
    jr .check_step_arrived

.set_step_ptr_lo_to_50:
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    farcall StepPlayerUpTowardWC928

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
; and counts wScriptParam0 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps,
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
; and counts wScriptParam0 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps,
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
; and counts wScriptParam0 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps,
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

SceneHomecoming_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

PersonalityMessage_RunMessageBoxFar_Bank0F::
    xor a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $62, $00
