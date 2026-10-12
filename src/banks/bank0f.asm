SECTION "Bank 0F", ROMX[$4000], BANK[$0F]
    db $0F

; implements script command type C7 (SCRIPT_SCENE_PENDANT_SELLER): a cutscene step named after the scene its only script shows: 'This pendant is yours for 38,000G' ... 'You're going to regret seeing us.'; reached through ScriptCommandC7 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC7)
; reads: wScriptStep
ScenePendantSeller::
Func_00F_4001:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScenePendantSeller_SetBit2AtHL_B0F
    dw ScenePendantSeller_StepObjectTowardCoord
    dw ScenePendantSeller_UpdateFollowersOnStep_Bank0F
    dw ScenePendantSeller_UpdateFollowersOnStep_Bank0F_Case03

; entry 3 of the `rst $00` table in ScenePendantSeller
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0, hPlayerStateFlags
; writes: wScriptParam0, hPlayerStateFlags, wScriptStartRequest
ScenePendantSeller_UpdateFollowersOnStep_Bank0F_Case03::
Jump_00F_400D:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScenePendantSeller
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY, wScriptParam0
; points at: wScriptStep
ScenePendantSeller_UpdateFollowersOnStep_Bank0F::
Jump_00F_402D:: ; address name
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
    cp a, $80
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScenePendantSeller
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, hPlayerStateFlags
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, hPlayerStateFlags
; points at: wScriptStep
ScenePendantSeller_StepObjectTowardCoord::
Jump_00F_404D:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScenePendantSeller
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1
; points at: wScriptStep
ScenePendantSeller_SetBit2AtHL_B0F::
Jump_00F_4077:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret z
    ld a, [wObject1 + $C]
    dec a
    ld [wObject1 + $C], a
    cp a, $30
    ret nz
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 62 (SCRIPT_PERSONALITY_MESSAGE): shows a message chosen by a party monster's personality (PersonalityIndexOfRecord); reached through ScriptCommand62 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand62)
; reads: wScriptStep
PersonalityMessage::
Func_00F_409A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw PersonalityMessage_LoadSRAMRecordByte
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; entry 0 of the `rst $00` table in PersonalityMessage
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hTemp0
; writes: rRAMG
; points at: wPartyList, wScriptStep
PersonalityMessage_LoadSRAMRecordByte::
Jump_00F_40A2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList
    ld a, [wScriptParam1]
    add_a_to_hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld hl, $40DE
    add_a_to_hl
    ld a, [hl]
    ld e, a
    pop hl
    ld a, [hl]
    push de
    call PersonalityIndexOfRecord
    pop de
    add a, e
    ld l, a
    ld h, $05
    call StartMessageHL_B0F
    xor a, a
    ld [rRAMG], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $94, $AF, $CA, $AF, $94, $CA, $AF, $94, $CA, $CA, $E5

; implements script command type 5F (SCRIPT_SCENE_HOMECOMING): a cutscene step named after the scene its only script shows: 'Hehehe, no need to worry there!' ... 'Tara 0, congratulations! I was sad'; reached through ScriptCommand5F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand5F)
; reads: wScriptStep
SceneHomecoming::
Func_00F_40E9:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 44 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneHomecoming_SetScriptStartRequestTo80::
Jump_00F_4147:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 43 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wGameMode, wModeState, wGameMode2State, wTemp0, wTemp1
; points at: wScriptStep
SceneHomecoming_WriteMapIdAndMapScreenXEtc::
Jump_00F_414D:: ; address name
    ld a, $06
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $02
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    xor a, a
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 42 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptParam0, wScriptParam1
; points at: wScriptStep
SceneHomecoming_WriteScriptParam0AndScriptParam1::
Jump_00F_4171:: ; address name
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
    or a, h
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 41 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wSGBActive, wSGBPaletteSet
; writes: wSpriteSlotCount, wObject5, hPlayerX, wFollowerRecords, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wScreenTileBuffer, wScreenAttrBuffer, wScriptStep
SceneHomecoming_ShowTHEEND::
Jump_00F_418E:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wObject5], a
    ld a, $E0
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
    xor a, a
    ld [wStringCategory], a
    ld a, $FB
    ld [wStringIndex], a ; 'THE END'
    farcall ShowString_Bank28
    ld hl, wScreenTileBuffer
    ld a, $C3
    ld bc, $0168
    call FillBytes
    ld hl, wScreenTileBuffer + $BA
    ld b, $08
    ld a, $80

Jump_00F_41D4::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_00F_41D4
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_41F1
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    xor a, a
    ld bc, $0168
    call FillBytes
    ld a, $00
    ldh [rSVBK], a

Jump_00F_41F1::
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_00F_423E
    xor a, a
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
    ld hl, $425E
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

Jump_00F_423E::
    farcall DrawFullScreenBufferAtScroll
    ld a, $FE
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

; E-0264 (derived: Func_000_0952 copies these 8 bytes to wOBJPaletteBuffer + $20)
; record: 8 bytes copied to wOBJPaletteBuffer + $20
OBJPaletteBufferPlus20Init_0F_425E::
Data_00F_425E:: ; address name
    db $DE, $67, $1F, $33, $3C, $12, $00, $00 ; entry 0

; entry 40 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wScriptStep
SceneHomecoming_WaitFadeState::
Jump_00F_4266:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 39 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ToStartPaletteFadeAndStep::
Jump_00F_4270:: ; address name
    ld a, $3F
    call StartPaletteFade
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2, wSpriteSlots, wScriptParam0
; points at: wScriptStep
SceneHomecoming_ScriptApplyStepDeltaAtDE_Case26::
Jump_00F_427A:: ; address name
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank0F
    ld a, [wObject2 + $B]
    dec a
    dec a
    ld [wObject2 + $B], a
    cp a, $40
    ret nz
    ld a, $E0
    ld [wSpriteSlots + $B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ScriptApplyStepDeltaAtDE::
Jump_00F_429F:: ; address name
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $01
    add a, $B9
    ld l, a
    ld h, $0D
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneHomecoming_WriteFollowerRecords::
Jump_00F_42B5:: ; address name
    ld a, [wFollowerRecords + $1]
    dec a
    dec a
    ld [wFollowerRecords + $1], a
    cp a, $78
    ret nz
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_Msg0DB8_WarubouWaheyIHave::
Jump_00F_42CA:: ; address name
    ld hl, $0DB8 ; 'Warubou Wa-hey I have seen this'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 29 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, hPlayerX, wObject5
; writes: wObject2, hPlayerX, wObject5, wScriptParam0
; points at: wScriptStep
SceneHomecoming_WriteObject2AndPlayerXEtc_Case1D::
Jump_00F_42D5:: ; address name
    ld a, [wScriptParam0]
    ld hl, $431F
    add_a_to_hl
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_00F_42F9

; entry 28 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, hPlayerX, wObject5
; writes: wObject2, hPlayerX, wObject5, wScriptParam0
; points at: wScriptStep
SceneHomecoming_WriteObject2AndPlayerXEtc::
Jump_00F_42E7:: ; address name
    ld a, $01
    ld [wObject2 + $7], a
    ld a, [wScriptParam0]
    ld hl, $431F
    add_a_to_hl
    ld a, [hl]
    ld c, a

Jump_00F_42F9::
    ld a, [wObject2 + $B]
    add a, c
    ld [wObject2 + $B], a
    ldh a, [hPlayerX]
    add a, c
    ldh [hPlayerX], a
    ld a, [wObject5 + $4]
    add a, c
    ld [wObject5 + $4], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

; entry 27 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, hPlayerX
; writes: hPlayerFacing, hPlayerY, hPlayerX, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneHomecoming_WritePlayerFacingAndPlayerYEtc::
Jump_00F_435F:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4376
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4376::
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ShowKamehaNoOnesTaking::
Jump_00F_438B:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB7 ; 'Kameha No one's taking this pie'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wObject1, wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneHomecoming_StepObjectTowardCoord::
Jump_00F_439D:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_43C2
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_43C2::
    ld a, $83
    ld [wStepTarget], a
    ld a, $58
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ld [wObject1 + $7], a
    xor a, a
    ld [wObject2 + $7], a
    ld hl, $0DB6 ; 'Warubou Wa-hey! Now look, warooh! It's'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, wObject2, wStepPtrLo, wStepPtrHi
; points at: wScriptStep
SceneHomecoming_AddStepDeltaToPointedByte::
Jump_00F_43EF:: ; address name
    ld a, $01
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $03
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
SceneHomecoming_ClearBit2AtHL_Bank0F::
Jump_00F_4419:: ; address name
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    add a, $B4
    ld l, a
    ld h, $0D
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ShowKamehaYoureAGlutton::
Jump_00F_4444:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB3 ; 'Kameha You're a glutton! You haven't'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ShowWarubouWAHEYSomePrince::
Jump_00F_4456:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB2 ; 'Warubou WA-HEY! Some Prince! Always a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ShowKamehaIWentAnd::
Jump_00F_4468:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB1 ; 'Kameha I went and faced danger'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_ShowWarubouWaheyIWas::
Jump_00F_447A:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB0 ; 'Warubou Wa-hey! I was the plug'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
SceneHomecoming_ToScriptStepSetObjectBit2AndWait::
Jump_00F_448C:: ; address name
    farcall ScriptStepSetObjectBit2AndWait
    ret

; entry 8 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneHomecoming_RunFieldCommandTemp0_Case08::
Jump_00F_4493:: ; address name
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $68
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState
; points at: wModeChangeRequest, wScriptStep
SceneHomecoming_StartPaletteFadeAndStep::
Jump_00F_44B1:: ; address name
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

; entry 6 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing
; points at: wScriptStep
SceneHomecoming_StepScriptParam0Counter_Bank0F::
Jump_00F_44C9:: ; address name
    ld a, $01
    ldh [hPlayerFacing], a
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneHomecoming_ShowWarubouNoOneKnows::
Jump_00F_44D8:: ; address name
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0549 ; 'Warubou No one knows how many'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hPlayerFacing, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
SceneHomecoming_ShowWarubouWaheyInsteadOf::
Jump_00F_44F3:: ; address name
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld hl, $0548 ; 'Warubou Wa-hey! Instead of a quest'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wObject3
; writes: wScriptParam0, wScriptParam1, wObject3
; points at: wScriptStep
SceneHomecoming_WriteScriptParam0AndScriptParam1Etc::
Jump_00F_4532:: ; address name
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
    ld a, [wObject3 + $C]
    add a, c
    ld [wObject3 + $C], a
    ld a, [wObject3 + $B]
    inc a
    inc a
    ld [wObject3 + $B], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wObject3 + $C], a
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, wScriptParam0, wScriptParam1, hFieldDrawFlags
; points at: wScriptStep
SceneHomecoming_RunFieldCommandTemp0::
Jump_00F_456A:: ; address name
    ld a, $13
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld [wObject5 + $5], a
    ld hl, $FE80
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $65
    call QueueSoundEffect
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 5E (SCRIPT_SCENE_DARCK_DEFEATED): a cutscene step named after the scene its only script shows: 'Darck Wha What? How could I' ... 'Darck Fwahahahah! Bravo! Splendid!'; reached through ScriptCommand5E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand5E)
; reads: wScriptStep
SceneDarckDefeated::
Func_00F_4595:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneDarckDefeated_ScriptStepBlinkObjectTemp0
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepPlayerLeftTowardWC928
    dw SceneDarckDefeated_ScriptApplyStepDeltaAtDE
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_StepScriptParam0Counter_Bank0F
    dw SceneDarckDefeated_Case06
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

; entry 147 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneDarckDefeated_ShowKingEvenThoughThe::
Jump_00F_46C3:: ; address name
    ld hl, $053C ; 'King Even though the island's crisis'
    call StartMessageHL_B0F
    ld a, $06
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 146 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
SceneDarckDefeated_QueueSoundEffect::
Jump_00F_46D8:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_46E8
    inc a
    ld [wScriptParam0], a
    ld a, $6D
    call QueueSoundEffect
    ret

Jump_00F_46E8::
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    farcall RestartMapMusic
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 144 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_Msg053B_KingIThankYou::
Jump_00F_46FE:: ; address name
    ld hl, $053B ; 'King I thank you all for'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 143 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wFieldEventArg, wStoryFlags, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case8F::
Jump_00F_4709:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld a, [wStoryFlags + $60]
    set 5, a
    ld [wStoryFlags + $60], a
    ld a, $19
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $3F
    call StartPaletteFade
    ret

; entry 140 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneDarckDefeated_SetObject5::
Jump_00F_4737:: ; address name
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 137 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case89::
Jump_00F_4740:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $50
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 136 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wObject5
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case88::
Jump_00F_475D:: ; address name
    ld a, $03
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; steps objects 2 and 3 toward ($81, $B0) and ($81, $C0) (StepObjectTowardCoord); advances wScriptStep once they arrive (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptStepMoveObjects2And3To81B0::
Jump_00F_4774:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $C0
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; ScriptApplyStepDeltaAtDE on wCBAB, copies wCBAB to wCBBB, and when the move finishes (carry) wScriptStep += 1 (E-0119)
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject3
; points at: wScriptStep
ScriptStepDeltaWCBABThenCopy::
Jump_00F_47A8:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject2 + $C]
    ld [wObject3 + $C], a
    pop af
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; alternates wCB9B between $E0 and $40 at a rate that slows with wScriptParam0; after $78 frames sets $40 and advances wScriptStep (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1
; points at: wScriptStep
ScriptStepFlickerObjectCB9B::
Jump_00F_47BC:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_47C9
    bit 1, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47C9::
    cp a, $3C
    jr nc, Jump_00F_47D3
    bit 2, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47D3::
    bit 3, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47D9::
    ld a, $E0
    ld [wObject1 + $C], a
    jr Jump_00F_47E5

Jump_00F_47E0::
    ld a, $40
    ld [wObject1 + $C], a

Jump_00F_47E5::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $40
    ld [wObject1 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; steps objects 2 and 3 toward ($03, $40) and ($03, $50); advances wScriptStep once they arrive (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptStepMoveObjects2And3To0340::
Jump_00F_47F5:: ; address name
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
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 127 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case7F::
Jump_00F_4829:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 126 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wObject5
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case7E::
Jump_00F_4846:: ; address name
    ld a, $71
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; entry 121 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case79::
Jump_00F_485D:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 120 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case78::
Jump_00F_487C:: ; address name
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
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 118 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case76::
Jump_00F_48B7:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 117 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wStepTarget, wStepPtrHi, wObject4
; points at: wScriptStep
SceneDarckDefeated_WriteStepPtrLoAndStepTargetEtc::
Jump_00F_48DE:: ; address name
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    jr Jump_00F_48F4

; entry 115 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wStepTarget, wStepPtrHi, wObject4
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case73::
Jump_00F_48EA:: ; address name
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a

Jump_00F_48F4::
    ld a, $04
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ld [wObject4 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 113 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case71::
Jump_00F_490E:: ; address name
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
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 112 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case70::
Jump_00F_4949:: ; address name
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $70
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 110 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case6E::
Jump_00F_4968:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $60
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 109 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wObject5
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case6D::
Jump_00F_4985:: ; address name
    ld a, $60
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; entry 104 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots
; points at: wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case68::
Jump_00F_499C:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_49A9
    bit 1, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49A9::
    cp a, $3C
    jr nc, Jump_00F_49B3
    bit 2, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49B3::
    bit 3, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49B9::
    ld a, $E0
    ld [wSpriteSlots + $C], a
    jr Jump_00F_49C5

Jump_00F_49C0::
    ld a, $30
    ld [wSpriteSlots + $C], a

Jump_00F_49C5::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 102 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case66::
Jump_00F_49D5:: ; address name
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 101 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject3, wObject4, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case65::
Jump_00F_4A09:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4A42
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + $B]
    ld [wObject1 + $B], a
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld a, $01
    ld [wObject3 + $7], a
    ld a, $03
    ld [wObject4 + $7], a
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4A42::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $C0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + $C]
    sub a, $08
    ld [wObject1 + $C], a
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 99 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wObject1
; points at: wScriptStep
SceneDarckDefeated_AddStepDeltaToPointedByte::
Jump_00F_4A74:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4A7F
    ld hl, wObject1 + $C
    dec [hl]

Jump_00F_4A7F::
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_00F_4A8A
    ld hl, wObject1 + $B
    inc [hl]

Jump_00F_4A8A::
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $03
    ld [wObject1 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 98 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case62::
Jump_00F_4AB3:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $70
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 96 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case60::
Jump_00F_4AD7:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 95 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case5F::
Jump_00F_4AE3:: ; address name
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
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 92 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case5C::
Jump_00F_4B1B:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 91 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case5B::
Jump_00F_4B38:: ; address name
    ld a, $49
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; entry 86 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots, wObject1
; writes: wSpriteSlots, wObject1, wObject2, wObject3
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case56::
Jump_00F_4B45:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4B64
    ld a, [wSpriteSlots + $7]
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wObject1 + $7]
    inc a
    and a, $03
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a

Jump_00F_4B64::
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject1 + $C]
    ld [wObject2 + $C], a
    ld [wObject3 + $C], a
    sub a, $30
    ld [wSpriteSlots + $C], a
    pop af
    ret nc
    ld a, $02
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 85 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1, wObject2, wObject3
; points at: wScriptStep
SceneDarckDefeated_WriteScriptParam0AndObject1Etc::
Jump_00F_4B8F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    add a, $10
    ld [wObject2 + $B], a
    add a, $10
    ld [wObject3 + $B], a
    cp a, $60
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 84 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wObject2, wObject3
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case54::
Jump_00F_4BB6:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4BCC
    ld a, [wObject1 + $7]
    inc a
    and a, $03
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a

Jump_00F_4BCC::
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject1 + $C]
    ld [wObject2 + $C], a
    ld [wObject3 + $C], a
    pop af
    ret nc
    ld a, $01
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 83 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wObject2, wObject3, wScriptParam0
; points at: wScriptStep
SceneDarckDefeated_WriteObject1AndObject2Etc::
Jump_00F_4BEE:: ; address name
    ld a, $03
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    add a, $10
    ld [wObject2 + $B], a
    add a, $10
    ld [wObject3 + $B], a
    cp a, $50
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 81 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case51::
Jump_00F_4C20:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $20
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 80 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case50::
Jump_00F_4C3D:: ; address name
    ld a, $41
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; entry 75 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case4B::
Jump_00F_4C4A:: ; address name
    ld de, wObject3 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 74 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived, wObject2
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wObject3, wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case4A::
Jump_00F_4C56:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4C90
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
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4C90::
    dec a
    jr nz, Jump_00F_4CDA
    ld a, [wObject2 + $C]
    cp a, $60
    jr z, Jump_00F_4CA6
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    jr Jump_00F_4CB0

Jump_00F_4CA6::
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a

Jump_00F_4CB0::
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
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4CDA::
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
    or a, a
    ret z
    xor a, a
    ld [wObject3 + $7], a
    ld a, $02
    ld [wObject2 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 72 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case48::
Jump_00F_4D1B:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4D40
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4D40::
    dec a
    jr nz, Jump_00F_4D5D
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4D5D::
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 69 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case45::
Jump_00F_4D7B:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 67 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case43::
Jump_00F_4D87:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4DAC
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4DAC::
    dec a
    jr nz, Jump_00F_4DC9
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4DC9::
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 66 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, wScriptParam0
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case42::
Jump_00F_4DE7:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 65 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case41::
Jump_00F_4E08:: ; address name
    ld a, $33
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; entry 60 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case3C::
Jump_00F_4E15:: ; address name
    ld a, $03
    ld [wObject2 + $7], a
    ld a, [wObject2 + $B]
    dec a
    ld [wObject2 + $B], a
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 59 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wSpriteSlots
; points at: wScriptStep
SceneDarckDefeated_WriteStepPtrHiAndStepPtrLoEtc::
Jump_00F_4E31:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr Jump_00F_4EB0

; entry 58 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case3A::
Jump_00F_4E3D:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $E0
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wObject1 + $B
    inc [hl]
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject1 + $7], a
    ld a, $30
    ld [wObject2 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 57 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wSpriteSlots
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case39::
Jump_00F_4E70:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $E0
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr Jump_00F_4EB0

; entry 56 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case38::
Jump_00F_4E91:: ; address name
    ld hl, wSpriteSlots + $B
    dec [hl]
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $30
    ld [wObject1 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 55 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wSpriteSlots
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case37::
Jump_00F_4EA6:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a

Jump_00F_4EB0::
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 54 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case36::
Jump_00F_4ECA:: ; address name
    ld b, $5A
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 53 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0_Case35::
Jump_00F_4EDA:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $30
    ld [wObject5 + $4], a
    ld a, $60
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 52 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case34::
Jump_00F_4EF7:: ; address name
    ld a, $2F
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    call SceneDarckDefeated_ScriptStartFadeAndAdvanceStep
    ret

; entry 49 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject5, wScriptParam0
; points at: wScriptStep
SceneDarckDefeated_WriteObject5AndScriptParam0::
Jump_00F_4F06:: ; address name
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr z, Jump_00F_4F1A
    ld hl, wObject5 + $5
    dec [hl]

Jump_00F_4F1A::
    ld a, [wScriptParam0]
    cp a, $40
    ret nz
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 47 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject3
; writes: wObject3, wObject4
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE_Case2F::
Jump_00F_4F2D:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, Jump_00F_4F40
    ld a, [wObject3 + $7]
    inc a
    and a, $03
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a

Jump_00F_4F40::
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $02
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject3
; writes: wObject3, wObject4
; points at: wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F_Case2E::
Jump_00F_4F54:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4F67
    ld a, [wObject3 + $7]
    inc a
    and a, $03
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a

Jump_00F_4F67::
    ld b, $96
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, wScriptParam0
; points at: wScriptStep
SceneDarckDefeated_RunFieldCommandTemp0::
Jump_00F_4F72:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $10
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 44 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wFieldEventArg, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wObject5
SceneDarckDefeated_WriteFieldEventArgAndMapIdEtc::
Jump_00F_4F93:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

; only called from routines of SceneDarckDefeated (E-0098)
; 7 call sites from 7 routines (e.g. SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case88, SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case7E, SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case6D, SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case5B, ...)
; reads: hPlayerY
; writes: wWarpDestX, wWarpDestY, wFieldTransitionKind, wObject5
SceneDarckDefeated_ScriptStartFadeAndAdvanceStep::
Func_00F_4FA1:: ; address name
    ld a, $E0
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    xor a, a
    ld [wObject5], a
    ret

; entry 41 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg, wObject5
; points at: wScriptStep
SceneDarckDefeated_ShowWarubouWaheyGreatLogsLife::
Jump_00F_4FBB:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $053A ; 'Warubou Wa-hey? GreatLog's life force is'
    call StartMessageHL_B0F
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 37 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg, hTemp0, wObject5, wScriptSubStep
; points at: wScriptStep
SceneDarckDefeated_ShowWarubouWaheyGetGoing::
Jump_00F_4FCF:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0539 ; 'Warubou Wa-hey! Get going!'
    call StartMessageHL_B0F
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 35 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wStepArrived
; writes: wFieldEventArg, wStepPtrLo, hPlayerFacing
; points at: wScriptStep
SceneDarckDefeated_StepPlayerDownTowardWC928::
Jump_00F_4FF1:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_5007
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ret

Jump_00F_5007::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptTemp4
; writes: wSpriteSlots, wFieldEventArg, wPartyCount, hFieldDrawFlags
; points at: wScriptStep
SceneDarckDefeated_ShowWarubouWaheyThatsIt::
Jump_00F_5020:: ; address name
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, $0538 ; 'Warubou Wa-hey That's it, then. There's'
    call StartMessageHL_B0F
    ld a, $01
    ld [wFieldEventArg], a
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 27 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord_Case1B::
Jump_00F_503E:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneDarckDefeated_StepObjectTowardCoord::
Jump_00F_505D:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: hPlayerY
SceneDarckDefeated_ScriptStepDeltaThenNextStep::
Jump_00F_507C:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld de, hPlayerY
    call ScriptStepDeltaThenNextStep
    ret

; entry 22 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: wScriptStep
SceneDarckDefeated_ShowWarubouWawaheyWeWere::
Jump_00F_5087:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0537 ; 'Warubou Wa-wa-hey! We were too late!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventKind, wFieldEventTimer, wFieldEventArg
; points at: wScriptStep
SceneDarckDefeated_WriteFieldEventKindAndFieldEventTimerEtc::
Jump_00F_5097:: ; address name
    ld a, $0C
    ld [wFieldEventKind], a
    xor a, a
    ld [wFieldEventTimer], a

; entry 25 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: wScriptStep
SceneDarckDefeated_SetFieldEventArg::
Jump_00F_50A0:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: wScriptStep
SceneDarckDefeated_ShowWarubouWaheyFeelThat::
Jump_00F_50A9:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld hl, $0DF7 ; 'Warubou Wa-hey? Feel that, warooh? Did'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
SceneDarckDefeated_ToScriptStepShakeScreen::
Jump_00F_50B8:: ; address name
    ld b, $0F
    call ScriptStepShakeScreen
    ret

; entry 13 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, wObject5
; points at: wScriptStep
SceneDarckDefeated_RedrawColumnsBesideScreenAndStep::
Jump_00F_50BE:: ; address name
    ld a, $30
    ld [wObject1 + $C], a
    xor a, a
    ld [wObject5], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
SceneDarckDefeated_ToRunSceneScriptSubStep::
Jump_00F_50D2:: ; address name
    farcall RunSceneScriptSubStep
    ret

; entry 11 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wScriptSubStep
SceneDarckDefeated_ShowWarubouWaheyYouDid::
Jump_00F_50D9:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0533 ; 'Warubou Wa-hey, you did it, 0!'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ret

; entry 9 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_Msg055B_WaheyCanYouHear::
Jump_00F_5108:: ; address name
    ld hl, $055B ; 'Wa-hey! can you hear me, 0?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_Msg055A_AVoiceEchoedFrom::
Jump_00F_5113:: ; address name
    ld hl, $055A ; 'A voice echoed from nowhere'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_Case06::
Jump_00F_511E:: ; address name
    ld hl, wSpriteSlots + $C
    inc [hl]

; entry 3 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_ScriptApplyStepDeltaAtDE::
Jump_00F_5122:: ; address name
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wStepArrived
; writes: wStepPtrLo, wSpriteSlots, wScreenTileBuffer
; points at: wScriptStep
SceneDarckDefeated_StepPlayerLeftTowardWC928::
Jump_00F_512E:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_00F_5140
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

Jump_00F_5140::
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $10
    ld [wSpriteSlots + $C], a
    ld a, $54
    ld [wScreenTileBuffer + $30], a
    ld a, $55
    ld [wScreenTileBuffer + $31], a
    farcall DrawFullScreenBufferAtScroll
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneDarckDefeated_StepScriptParam0Counter_Bank0F::
Jump_00F_516A:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wStoryFlags
; writes: hTemp0, hTemp1, wSpriteSlotCount, wStoryFlags
; points at: wScriptStep
SceneDarckDefeated_ScriptStepBlinkObjectTemp0::
Jump_00F_5175:: ; address name
    ld a, $01
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, $00D1
    call SetFlagBit
    ld a, [wStoryFlags + $65]
    set 0, a
    ld [wStoryFlags + $65], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 138 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wFieldEventArg, wObject5
SceneDarckDefeated_WriteFieldEventArgAndObject5_Case8A::
Jump_00F_519F:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and a, $0F
    rst $00
    dw SceneDarckDefeated_Case8A_WriteScriptSubStepAndObject5
    dw SceneDarckDefeated_Case8A_WriteObject5AndScriptSubStepEtc

; entry 0 of the `rst $00` table in SceneDarckDefeated_Case8A
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptSubStep, wScriptParam1
; writes: wScriptSubStep, wObject5
; points at: wScriptParam1
SceneDarckDefeated_Case8A_WriteScriptSubStepAndObject5::
Jump_00F_51B2:: ; address name
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, Jump_00F_51BE
    inc a
    ld [wScriptSubStep], a
    ret

Jump_00F_51BE::
    srl a
    ld c, a
    ld a, $17
    sub a, c
    add a, a
    ld de, ObjectPathTable_5284
    add a, e
    ld e, a
    jr nc, Jump_00F_51CD
    inc d

Jump_00F_51CD::
    push de
    ld a, [wScriptParam1]
    and a, $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hl+]
    ld [wObject5 + $5], a
    ld a, [hl]
    add a, $10
    ld [wObject5 + $4], a
    ld a, [wScriptSubStep]
    inc a
    ld [wScriptSubStep], a
    srl a
    cp a, $17
    ret nz
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptParam1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneDarckDefeated_Case8A
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wObject5, wScriptSubStep, wScriptParam1
; points at: wScriptStep
SceneDarckDefeated_Case8A_WriteObject5AndScriptSubStepEtc::
Jump_00F_51FB:: ; address name
    xor a, a
    ld [wObject5], a
    ld a, [wScriptParam1]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5213
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a

Jump_00F_5213::
    ld [wScriptParam1], a
    ret

; entry 40 of the `rst $00` table in SceneDarckDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wFieldEventArg, wObject5
SceneDarckDefeated_WriteFieldEventArgAndObject5::
Jump_00F_5217:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and a, $0F
    rst $00
    dw SceneDarckDefeated_Case28_WriteScriptSubStepAndObject5
    dw SceneDarckDefeated_Case28_WriteScriptSubStepAndScriptParam1

; entry 0 of the `rst $00` table in SceneDarckDefeated_Case28
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptSubStep, wScriptParam1
; writes: wScriptSubStep, wObject5
; points at: wScriptParam1
SceneDarckDefeated_Case28_WriteScriptSubStepAndObject5::
Jump_00F_522A:: ; address name
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, Jump_00F_5236
    inc a
    ld [wScriptSubStep], a
    ret

Jump_00F_5236::
    and a, $FE
    ld de, ObjectPathTable_5284
    add a, e
    ld e, a
    jr nc, Jump_00F_5240
    inc d

Jump_00F_5240::
    push de
    ld a, [wScriptParam1]
    and a, $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hl+]
    ld [wObject5 + $5], a
    ld a, [hl]
    ld [wObject5 + $4], a
    ld a, [wScriptSubStep]
    inc a
    ld [wScriptSubStep], a
    srl a
    cp a, $17
    ret nz
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptParam1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneDarckDefeated_Case28
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptSubStep, wScriptParam1
; points at: wScriptStep
SceneDarckDefeated_Case28_WriteScriptSubStepAndScriptParam1::
Jump_00F_526C:: ; address name
    ld a, [wScriptParam1]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5280
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a

Jump_00F_5280::
    ld [wScriptParam1], a
    ret

; E-0206 (C1: SceneDarckDefeated_Case28_Case00 reads, every other frame, the pair at $5284 + $30 * ((wScriptParam1 & $70) >> 4) + 2 * step into wObject5 + 5 and + 4, for 23 steps per path; 8 paths end at SceneThreeItems).
; record: 24 steps of two bytes (wObject5 + 5, wObject5 + 4), 12 per line
ObjectPathTable_5284::
Data_00F_5284:: ; address name
    db $FE, $06, $00, $09, $02, $0C, $04, $0F, $06, $12, $08, $15, $0A, $18, $0C, $1B, $0E, $1E, $10, $21, $12, $23, $14, $26 ; id 0
    db $16, $28, $18, $2B, $1A, $2D, $1C, $30, $1E, $32, $20, $34, $22, $36, $24, $38, $26, $3A, $28, $3C, $2A, $3E, $2C, $40
    db $FE, $63, $00, $61, $02, $5F, $04, $5D, $06, $5B, $08, $59, $0A, $57, $0C, $55, $0E, $53, $10, $52, $12, $50, $14, $4F ; id 1
    db $16, $4D, $18, $4B, $1A, $4A, $1C, $48, $1E, $47, $20, $46, $22, $45, $24, $44, $26, $43, $28, $42, $2A, $41, $2C, $40
    db $FE, $1D, $00, $1F, $02, $21, $04, $23, $06, $25, $08, $27, $0A, $29, $0C, $2B, $0E, $2D, $10, $2F, $12, $30, $14, $32 ; id 2
    db $16, $33, $18, $35, $1A, $36, $1C, $38, $1E, $39, $20, $3A, $22, $3B, $24, $3C, $26, $3D, $28, $3E, $2A, $3F, $2C, $40
    db $FE, $76, $00, $74, $02, $71, $04, $6E, $06, $6C, $08, $69, $0A, $67, $0C, $64, $0E, $62, $10, $5F, $12, $5D, $14, $5A ; id 3
    db $16, $58, $18, $55, $1A, $53, $1C, $50, $1E, $4E, $20, $4C, $22, $4A, $24, $48, $26, $46, $28, $44, $2A, $42, $2C, $40
    db $0C, $FC, $0C, $FF, $0C, $03, $0D, $07, $0D, $0B, $0E, $0F, $0F, $13, $10, $17, $11, $1C, $13, $20, $14, $23, $16, $26 ; id 4
    db $17, $28, $19, $2B, $1A, $2D, $1C, $30, $1E, $32, $20, $34, $22, $36, $24, $38, $26, $3A, $28, $3C, $2A, $3E, $2C, $40
    db $FE, $63, $00, $61, $02, $5F, $04, $5D, $06, $5B, $08, $59, $0A, $57, $0C, $55, $0E, $53, $10, $52, $12, $50, $14, $4F ; id 5
    db $16, $4D, $18, $4B, $1A, $4A, $1C, $48, $1E, $47, $20, $46, $22, $45, $24, $44, $26, $43, $28, $42, $2A, $41, $2C, $40
    db $0C, $89, $0C, $85, $0C, $81, $0D, $7D, $0D, $79, $0E, $75, $0F, $71, $10, $6D, $11, $69, $13, $65, $14, $61, $16, $5E ; id 6
    db $17, $5A, $19, $57, $1A, $54, $1C, $51, $1E, $4E, $20, $4C, $22, $4A, $24, $48, $26, $46, $28, $44, $2A, $42, $2C, $40
    db $FE, $76, $00, $74, $02, $71, $04, $6E, $06, $6C, $08, $69, $0A, $67, $0C, $64, $0E, $62, $10, $5F, $12, $5D, $14, $5A ; id 7
    db $16, $58, $18, $55, $1A, $53, $1C, $50, $1E, $4E, $20, $4C, $22, $4A, $24, $48, $26, $46, $28, $44, $2A, $42, $2C, $40

; implements script command type 58 (SCRIPT_SCENE_THREE_ITEMS): a cutscene step named after the scene its only script shows: 'Kameha If the three items that...'; reached through ScriptCommand58 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand58)
; reads: wScriptStep
SceneThreeItems::
Func_00F_5404:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 43 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, wGameFlags836
; writes: hTemp0, wStoryFlags, hTemp1, wGameFlags836, wScriptStartRequest
SceneThreeItems_RunMessageBoxFar_Bank0F::
Jump_00F_5460:: ; address name
    xor a, a
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

; entry 42 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: hPlayerY
SceneThreeItems_ToScriptStepDeltaThenMessage_Case2A::
Jump_00F_5495:: ; address name
    ld de, hPlayerY
    ld hl, $0A7E
    call ScriptStepDeltaThenMessage
    ret

; entry 40 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlotCount
; points at: wScriptStep
SceneThreeItems_ShowWarubouWaheyThereIs::
Jump_00F_549F:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $B0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld de, $00C3
    call SetFlagBit
    farcall PlayMapMusic
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, $0A7D ; 'Warubou Wa-hey, there is little time'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg0A7C_KamehaIIHave::
Jump_00F_54D5:: ; address name
    ld hl, $0A7C ; 'Kameha I I have to go'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 34 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest
; points at: wScriptStep
SceneThreeItems_ShowWarubouThereAllHealed::
Jump_00F_54E0:: ; address name
    farcall FullyHealParty
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, $0A7B ; 'Warubou There! All healed now! There'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneThreeItems_ShowWarubouWaheyHeroAnd::
Jump_00F_550B:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
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
    ld hl, $0A7A ; 'Warubou Wa-hey! 0 and Kameha! I'
    call StartMessageHL_B0F
    ret

; entry 28 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg0491_WaheyCanYouHear::
Jump_00F_5538:: ; address name
    ld hl, $0491 ; 'Wa-hey! Can you hear me, 0?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg0490_AVoiceEchoedFrom::
Jump_00F_5543:: ; address name
    ld hl, $0490 ; 'A voice echoed from nowhere'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
SceneThreeItems_ToScriptStepDeltaThenMessage_Case18::
Jump_00F_554E:: ; address name
    ld de, wObject2 + $C
    ld hl, $048F
    call ScriptStepDeltaThenMessage
    ret

; entry 23 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots
; points at: wScriptStep
SceneThreeItems_StepScriptParam0Counter_Bank0F::
Jump_00F_5558:: ; address name
    ld a, [wScriptParam0]
    swap a
    srl a
    srl a
    and a, $01
    add a, a
    inc a
    ld [wSpriteSlots + $7], a
    ld b, $B4
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, hPlayerX, hPlayerY
; writes: wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind, wModeState, wFieldTransitionStep
; points at: wScriptStep
SceneThreeItems_SetFlagBit::
Jump_00F_5577:: ; address name
    ld a, [wStoryFlags + $64]
    set 3, a
    ld [wStoryFlags + $64], a
    ld de, $00C2
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
    xor a, a
    ld [wFieldTransitionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
SceneThreeItems_WriteSpriteSlotCount::
Jump_00F_55A7:: ; address name
    ld a, $01
    ld [wSpriteSlotCount], a

; entry 33 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
SceneThreeItems_ToScriptStepFlashScreenNegative::
Jump_00F_55AC:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 32 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
SceneThreeItems_QueueSoundEffect::
Jump_00F_55B3:: ; address name
    ld a, $7A
    call QueueSoundEffect

; entry 20 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
SceneThreeItems_CopyBytes::
Jump_00F_55B8:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_55CA
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_00F_55CA::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg048E_DarckIWillBe::
Jump_00F_55CF:: ; address name
    ld hl, $048E ; 'Darck I will be readying a'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg048D_HeroReceivedTheLimbo::
Jump_00F_55DA:: ; address name
    ld hl, $048D ; '0 received the Limbo Key.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
SceneThreeItems_StartMessageHL_B0F::
Jump_00F_55E5:: ; address name
    ld a, [wFrameCounterLo]
    bit 2, a
    jr z, Jump_00F_55F2
    xor a, a
    ld [wObject5], a
    jr Jump_00F_55F7

Jump_00F_55F2::
    ld a, $80
    ld [wObject5], a

Jump_00F_55F7::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $048C ; 'Darck That key will bring you'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, hPlayerX
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneThreeItems_ShowDarckIImagineThat::
Jump_00F_5612:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr z, Jump_00F_5623
    ld hl, wSGBPacketBuffer + $B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    dec [hl]
    ret

Jump_00F_5623::
    ld hl, vTiles0 + $48B
    call StartMessageHL_B0F
    ld a, $04
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ld a, $E0
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg4487_DarckWellForMe::
Jump_00F_5642:: ; address name
    ld hl, $4487 ; 'Darck Well, for me, anything that'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
SceneThreeItems_ToScriptStepDeltaThenMessage::
Jump_00F_564D:: ; address name
    ld de, wSpriteSlots + $C
    ld hl, $0486
    call ScriptStepDeltaThenMessage
    ret

; entry 6 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg0485_GreetingsIAmDarck::
Jump_00F_5657:: ; address name
    ld hl, $0485 ; 'Greetings! I am Darck, the King'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject3, wObject1, wSpriteSlots
; points at: wScriptStep
SceneThreeItems_QueueMusic::
Jump_00F_5662:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_566D
    ld a, $1F
    call QueueMusic

Jump_00F_566D::
    ld a, $18
    ld [wObject3 + $C], a
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_567F
    bit 1, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_567F::
    cp a, $3C
    jr nc, Jump_00F_5689
    bit 2, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_5689::
    bit 3, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_568F::
    ld a, $10
    ld [wObject1 + $C], a
    jr Jump_00F_569B

Jump_00F_5696::
    ld a, $C0
    ld [wObject1 + $C], a

Jump_00F_569B::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld hl, $0484 ; 'Kameha Who are you to disturb'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_Msg0483_KamehaWhawhaWhaaaatWhat::
Jump_00F_56B1:: ; address name
    ld hl, $0483 ; 'Kameha Wha-wha whaaaat? What just happened'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
SceneThreeItems_ToScriptStepShakeScreen::
Jump_00F_56BC:: ; address name
    ld b, $78
    call ScriptStepShakeScreen
    ret

; entry 0 of the `rst $00` table in SceneThreeItems
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItems_ToRedrawColumnsBesideScreenAndStep::
Jump_00F_56C2:: ; address name
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4E (SCRIPT_SCENE_GRAVE): a cutscene step named after the scene its only script shows: '0 checked the grave.' ... 'Fine! You've done well...'; reached through ScriptCommand4E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand4E)
; reads: wScriptStep
SceneGrave::
Func_00F_56CD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneGrave_StepScriptParam0Counter_Bank0F
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneGrave_ShowAhYoullDoIt
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneGrave_ScriptStepBlinkObjectTemp0

; entry 4 of the `rst $00` table in SceneGrave
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp1, hTemp0, wScriptStartRequest
SceneGrave_ScriptStepBlinkObjectTemp0::
Jump_00F_56DB:: ; address name
    ld a, $40
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneGrave
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; points at: wScriptStep
SceneGrave_ShowAhYoullDoIt::
Jump_00F_56F3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_570A
    ld hl, vTiles0 + $416
    call StartMessageHL_B0F
    ld de, $00A6
    call SetFlagBit
    ret

Jump_00F_570A::
    ld hl, vTiles0 + $417
    call StartMessageHL_B0F
    ld de, $00A5
    call SetFlagBit
    ret

; entry 0 of the `rst $00` table in SceneGrave
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1, wSpriteSlotCount, wScriptParam0, wScriptStep
; points at: wScriptStep
SceneGrave_StepScriptParam0Counter_Bank0F::
Jump_00F_5717:: ; address name
    ld a, $40
    ld [wObject1 + $C], a
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_5729
    bit 1, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5729::
    cp a, $3C
    jr nc, Jump_00F_5733
    bit 2, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5733::
    bit 3, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5739::
    ld a, $02
    ld [wSpriteSlotCount], a
    jr Jump_00F_5745

Jump_00F_5740::
    ld a, $01
    ld [wSpriteSlotCount], a

Jump_00F_5745::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wScriptParam0], a
    ld de, $00C2
    call TestFlagBit
    jp c, Jump_00F_57DE
    ld de, $00A7
    call TestFlagBit
    jr c, Jump_00F_57D2
    ld de, $00A6
    call TestFlagBit
    jr c, Jump_00F_57C6
    ld de, $00A5
    call TestFlagBit
    jr c, Jump_00F_57BB
    ld de, $00A4
    call TestFlagBit
    jr c, Jump_00F_579D
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_00F_5791
    ld hl, $040C ; 'Who disturbs my sleep? A visitor'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_5791::
    ld hl, $040D ; 'What? You again? You seem to'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_579D::
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_00F_57B0
    ld hl, $4415 ; 'Who disturbs my sleep? A visitor'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57B0::
    ld hl, $4418 ; 'Who disturbs my sleep? Oh, it's'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57BB::
    ld hl, $4419 ; 'Well? Will you go look for'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57C6::
    ld hl, $0416 ; 'Ah, you'll do it? Excellent! But'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_57D2::
    ld hl, $0452 ; 'The Change Staff will open paths.'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_57DE::
    ld hl, $0493 ; 'Who disturbs my sleep? The visitor'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

; implements script command type 4B (SCRIPT_SCENE_SHIELD_2): a cutscene step named after the scene its only script shows: after '0 checked the shield.'; reached through ScriptCommand4B in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand4B)
; reads: wScriptStep
SceneShield2::
Func_00F_57EA:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 22 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: hTemp0, wStoryFlags, wScriptStartRequest
SceneShield2_SetFlagBit::
Jump_00F_581C:: ; address name
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

; entry 20 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
SceneShield2_ShowWarubouWaheyYouCan::
Jump_00F_583A:: ; address name
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $0DCB ; 'Warubou Wa-hey, you can now fly'
    call StartMessageHL_B0F
    ld de, $001E
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wSpriteSlots, hTemp0, wObject5
; points at: wScriptStep
SceneShield2_RunFieldCommandTemp0_Case13::
Jump_00F_585B:: ; address name
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
SceneShield2_ToRunSceneScriptSubStep::
Jump_00F_5889:: ; address name
    farcall RunSceneScriptSubStep
    ret

; entry 17 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wScriptSubStep
; points at: hPlayerStateFlags
SceneShield2_ShowWarubouWaheyYouDid::
Jump_00F_5890:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $02A7 ; 'Warubou Wa-hey! You did it, 0!'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ret

; entry 15 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneShield2_ShowWaheyHeroCanYou::
Jump_00F_58C5:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0A0A ; 'Wa-hey! 0, can you hear me?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneShield2_ShowAVoiceEchoedFrom::
Jump_00F_58D5:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0A09 ; 'A voice echoed from nowhere'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneShield2_ShowHeroReceivedTheSky::
Jump_00F_58E5:: ; address name
    ld hl, wSpriteSlots + $C
    inc [hl]
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld hl, $0A08 ; '0 received the Sky Shield.'
    call StartMessageHL_B0F
    ld de, $01E5
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject2, wSpriteSlotCount
; points at: wScriptStep
SceneShield2_StepScriptParam0Counter_Bank0F_Case0B::
Jump_00F_5906:: ; address name
    ld a, $18
    ld [wObject2 + $C], a
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_5918
    bit 1, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5918::
    cp a, $3C
    jr nc, Jump_00F_5922
    bit 2, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5922::
    bit 3, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5928::
    ld a, $03
    ld [wSpriteSlotCount], a
    jr Jump_00F_5934

Jump_00F_592F::
    ld a, $02
    ld [wSpriteSlotCount], a

Jump_00F_5934::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $0A07 ; 'The Kingdoms should return to their'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestY
SceneShield2_ScriptStartFadeAndAdvanceStep_Case0A::
Jump_00F_594A:: ; address name
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

; entry 8 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags
SceneShield2_ScriptStartFadeAndAdvanceStep::
Jump_00F_5962:: ; address name
    ld a, [wStoryFlags + $63]
    set 1, a
    ld [wStoryFlags + $63], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 6 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneShield2_ScriptStartFadeAndAdvanceStep_Case06::
Jump_00F_5971:: ; address name
    ld a, $48
    ldh [hMapId], a
    ld a, $07
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $E0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneShield2_ShowLetMeShowYou::
Jump_00F_5993:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, $0DCA ; 'Let me show you my resurrected'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneShield2_StepScriptParam0Counter_Bank0F::
Jump_00F_59AD:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneShield2_ScriptApplyStepDeltaAtDE::
Jump_00F_59B8:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneShield2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneShield2_RunFieldCommandTemp0::
Jump_00F_59C8:: ; address name
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4A (SCRIPT_SCENE_SHIELD): a cutscene step named after the scene its only script shows: after '0 checked the shield.' (starts a scripted encounter); reached through ScriptCommand4A in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand4A)
; reads: wScriptStep
SceneShield::
Func_00F_59E6:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 10 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneShield_ShowIBoreWitnessTo::
Jump_00F_5A02:: ; address name
    ld hl, $0A05 ; 'I bore witness to it all'
    call StartMessageHL_B0F
    ld de, $01E4
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hTemp0
; writes: hTemp1, hTemp0
; points at: wScriptStep
SceneShield_ShowABeautifulVoiceEchoed::
Jump_00F_5A13:: ; address name
    ld a, [wScriptParam1]
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld hl, $0DDF ; 'A beautiful voice echoed'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wScriptParam1
; points at: wScriptStep
SceneShield_ShowWhaNoMyMonsters::
Jump_00F_5A31:: ; address name
    ld hl, $0A04 ; 'Wha No! My monsters! It won't'
    call StartMessageHL_B0F
    ld a, [wObject1 + $C]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneShield_RunMessageBoxFar_Bank0F::
Jump_00F_5A42:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $19
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
SceneShield_ShowImpetuousFoolIllShow::
Jump_00F_5A56:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_5A67
    ld hl, vTiles1 + $5D0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5A67::
    ld hl, vTiles1 + $5D1
    call StartMessageHL_B0F
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1
; points at: wScriptStep
SceneShield_StepScriptParam0Counter_Bank0F::
Jump_00F_5A73:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_5A80
    bit 1, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A80::
    cp a, $3C
    jr nc, Jump_00F_5A8A
    bit 2, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A8A::
    bit 3, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A90::
    ld a, $20
    ld [wObject1 + $C], a
    jr Jump_00F_5A9C

Jump_00F_5A97::
    ld a, $E0
    ld [wObject1 + $C], a

Jump_00F_5A9C::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $20
    ld [wObject1 + $C], a
    ld hl, $4A02 ; 'So it was you holding up'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
SceneShield_ToScriptStepFlashScreenNegative::
Jump_00F_5AB2:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 0 of the `rst $00` table in SceneShield
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wScriptParam1, wScriptStep
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
SceneShield_ShowTchObstinateAndFoolish::
Jump_00F_5AB9:: ; address name
    ld de, $01E3
    call TestFlagBit
    jr nc, Jump_00F_5AD2
    ld hl, $0A03 ; 'Tch, obstinate and foolish. You need'
    call StartMessageHL_B0F
    ld a, $01
    ld [wScriptParam1], a
    ld a, $05
    ld [wScriptStep], a
    ret

Jump_00F_5AD2::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_5AE4
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_00F_5AE4::
    ld de, $01E3
    call SetFlagBit
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 66 (SCRIPT_SCENE_SHIELD_GUARDIAN): a cutscene step named after the scene its only script shows: before '0 checked the shield.' (encounter); reached through ScriptCommand66 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand66)
; reads: wScriptStep
SceneShieldGuardian::
Func_00F_5AF3:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 14 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneShieldGuardian_ShowHelenIPutYou::
Jump_00F_5B17:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, $0AF5 ; 'Helen I put you through trouble'
    call StartMessageHL_B0F
    ld de, $01E2
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
SceneShieldGuardian_ScriptStepDeltaThenMessage::
Jump_00F_5B2C:: ; address name
    ld a, $02
    ld [wObject1 + $7], a
    ld de, wObject1 + $C
    ld hl, $0AF4
    call ScriptStepDeltaThenMessage
    ret

; entry 10 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneShieldGuardian_ShowThatWasALovely::
Jump_00F_5B3B:: ; address name
    ld de, FieldSpriteGfx0F
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    xor a, a
    ld [wSpriteSlots + $7], a
    ld a, $0F
    ld [wSpriteSlots + $2], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, $0AF3 ; 'That was a lovely sleep. I'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wObject1
; points at: wScriptStep
SceneShieldGuardian_ShowOhMyGoodnessThank::
Jump_00F_5B5F:: ; address name
    ld a, $02
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $03
    ld [wObject1 + $7], a
    ld hl, $0AF2 ; 'Oh, my goodness! Thank you! You'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneShieldGuardian_Msg0AF0_WhatLoseToA::
Jump_00F_5B86:: ; address name
    ld hl, $0AF0 ; 'What? Lose to a child's monsters?'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneShieldGuardian_RunMessageBoxFar_Bank0F::
Jump_00F_5B91:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $04
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
SceneShieldGuardian_ShowISeeButI::
Jump_00F_5BA5:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_5BB6
    ld hl, vTiles1 + $5CE
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5BB6::
    ld hl, vTiles1 + $5CF
    call StartMessageHL_B0F
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject2, wSpriteSlotCount
; points at: wScriptStep
SceneShieldGuardian_StepScriptParam0Counter_Bank0F::
Jump_00F_5BC2:: ; address name
    ld a, $20
    ld [wObject2 + $C], a
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_5BD4
    bit 1, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BD4::
    cp a, $3C
    jr nc, Jump_00F_5BDE
    bit 2, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BDE::
    bit 3, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BE4::
    ld a, $03
    ld [wSpriteSlotCount], a
    jr Jump_00F_5BF0

Jump_00F_5BEB::
    ld a, $02
    ld [wSpriteSlotCount], a

Jump_00F_5BF0::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $4AEE ; 'Our plan called for chaos in'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneShieldGuardian
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wScriptStep
; points at: wScriptStep
SceneShieldGuardian_ShowIWishYouWouldnt::
Jump_00F_5C06:: ; address name
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_00F_5C2F
    ld hl, $0AED ; 'I wish you wouldn't do that'
    call StartMessageHL_B0F
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, $01E1
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5C2F::
    ld hl, $0AEF ; 'Heh, such a show of false'
    call StartMessageHL_B0F
    ld a, $05
    ld [wScriptStep], a
    ret

; implements script command type 49 (SCRIPT_SCENE_MEDICINE_GIVEN): a cutscene step named after the scene its only script shows: after 'Pardon me? You have medicine?'; reached through ScriptCommand49 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand49)
; reads: wScriptStep
SceneMedicineGiven::
Func_00F_5C3B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMedicineGiven_StepObjectTowardCoord
    dw SceneMedicineGiven_UpdatePlayerMovement
    dw SceneMedicineGiven_StepObjectTowardCoord_Case02
    dw SceneMedicineGiven_StepObjectTowardCoord_Case03

; entry 3 of the `rst $00` table in SceneMedicineGiven
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, hPlayerY, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, hPlayerFacing, wObject1, wScriptStartRequest
SceneMedicineGiven_StepObjectTowardCoord_Case03::
Jump_00F_5C47:: ; address name
    ld a, [wObject1 + $C]
    cp a, $40
    jr z, Jump_00F_5C65
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5C7A

Jump_00F_5C65::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_00F_5C7A::
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_5C8C
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ret

Jump_00F_5C8C::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wObject1 + $7], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneMedicineGiven
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, hPlayerY, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneMedicineGiven_StepObjectTowardCoord_Case02::
Jump_00F_5CA9:: ; address name
    ld a, [wObject1 + $B]
    cp a, $30
    jr z, Jump_00F_5CC7
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5CDC

Jump_00F_5CC7::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_00F_5CDC::
    ldh a, [hPlayerY]
    cp a, $70
    jr z, Jump_00F_5CEE
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ret

Jump_00F_5CEE::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneMedicineGiven
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest
; points at: wScriptStep
SceneMedicineGiven_UpdatePlayerMovement::
Jump_00F_5D03:: ; address name
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneMedicineGiven
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, hPlayerX, wStepArrived, hPlayerStateFlags
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, hFF80, wScriptStep
SceneMedicineGiven_StepObjectTowardCoord::
Jump_00F_5D1A:: ; address name
    ld a, [wSpriteSlots + $B]
    cp a, $50
    jr z, Jump_00F_5D38
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5D4D

Jump_00F_5D38::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_00F_5D4D::
    ldh a, [hPlayerX]
    cp a, $50
    jr z, Jump_00F_5D5F
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

Jump_00F_5D5F::
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    dec [hl]
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

; implements script command type 48 (SCRIPT_SCENE_PRINCESS_MEDICINE): a cutscene step named after the scene its only script shows: 'STOP DON'T MEDDLE' ... 'Pardon me? You have medicine?' (encounter, removes an item); reached through ScriptCommand48 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand48)
; reads: wScriptStep
ScenePrincessMedicine::
Func_00F_5D9D:: ; address name
    ld a, [wScriptStep]
    rst $00
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
    dw ScenePrincessMedicine_ShowIEFinallyRemembered
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; entry 11 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScenePrincessMedicine_ShowIEFinallyRemembered::
Jump_00F_5DBB:: ; address name
    ld hl, $0AD5 ; 'I e finally remembered. I'm Yuna,'
    call StartMessageHL_B0F
    ld de, $009D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1
; points at: wSpriteSlotCount, wScriptStep
ScenePrincessMedicine_ShowYunasSoulFilledHer::
Jump_00F_5DCC:: ; address name
    ld a, $02
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, $0AD0 ; 'Yuna's soul filled her body.'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScenePrincessMedicine_Msg0AD4_HHOWBUTITHIS::
Jump_00F_5DED:: ; address name
    ld hl, $0AD4 ; 'H-HOW BUT I THIS ISN T'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScenePrincessMedicine_StartScriptedEncounterTemp0AndStep::
Jump_00F_5DF8:: ; address name
    ld a, $18
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wTextYesNoResult
; writes: hTemp0, wScriptStep
; points at: wScriptStep
ScenePrincessMedicine_FindTemp0InInventoryList::
Jump_00F_5E07:: ; address name
    ld a, $33
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_00F_5E1D
    farcall RemoveInventorySlotShiftDown

Jump_00F_5E1D::
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_5E2E
    ld hl, vTiles1 + $5CC
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5E2E::
    ld hl, vTiles1 + $5CD
    call StartMessageHL_B0F
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStep
; points at: wScriptStep
ScenePrincessMedicine_ScriptApplyStepDeltaAtDE::
Jump_00F_5E3A:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_5E46
    ld hl, wSpriteSlots + $C
    dec [hl]
    jr Jump_00F_5E4A

Jump_00F_5E46::
    ld hl, wSpriteSlots + $C
    inc [hl]

Jump_00F_5E4A::
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld de, $009C
    call TestFlagBit
    jr c, Jump_00F_5E6A
    ld hl, $4AD2 ; 'NEVER DID I EXPECT YUNA S'
    call StartMessageHL_B0F
    ld de, $009C
    call SetFlagBit
    ret

Jump_00F_5E6A::
    ld a, $06
    ld [wScriptStep], a
    ret

; entry 1 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1, wSpriteSlots, hPlayerY, wPartyCount, wFollowerRecords
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wObject1, wObject2, wScriptParam1
; points at: wScriptStep
ScenePrincessMedicine_AddStepDeltaToPointedByte::
Jump_00F_5E70:: ; address name
    ld hl, wObject1 + $B
    dec [hl]
    ld hl, wObject1 + $C
    inc [hl]
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    jr nz, Jump_00F_5E9D
    ld a, [wObject1 + $7]
    inc a
    and a, $03
    ld [wObject1 + $7], a

Jump_00F_5E9D::
    ld a, [wScriptParam0]
    cp a, $20
    ret nz
    ld a, [wSpriteSlots + $7]
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld a, [wObject1 + $B]
    ld [wObject2 + $B], a
    ld a, [wObject1 + $C]
    ld [wObject2 + $C], a
    ld a, $E0
    ld [wObject1 + $B], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam1], a
    ldh a, [hPlayerY]
    cp a, $20
    jr z, Jump_00F_5EE2
    cp a, $40
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    ld a, [wFollowerRecords + $7]
    cp a, $20
    ret nz

Jump_00F_5EE2::
    ld a, $01
    ld [wScriptParam1], a
    ret

; entry 0 of the `rst $00` table in ScenePrincessMedicine
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wScriptStep
; points at: wScriptStep
ScenePrincessMedicine_QueueSoundEffect::
Jump_00F_5EE8:: ; address name
    ld a, [wObject1 + $B]
    cp a, $80
    jr nz, Jump_00F_5F00
    ld a, [wObject1 + $C]
    cp a, $10
    jr nz, Jump_00F_5F00
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5F00::
    ld a, $06
    ld [wScriptStep], a
    ret

; implements script command type 46 (SCRIPT_SCENE_CHEER_YUNA): a cutscene step named after the scene its only script shows: 'You're here to cheer Lady Yuna.' ... 'King Magnificent!'; reached through ScriptCommand46 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand46)
; reads: wScriptStep
SceneCheerYuna::
Func_00F_5F06:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 16 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wScriptStartRequest
SceneCheerYuna_WritePlayerFacingAndScriptStartRequest::
Jump_00F_5F2C:: ; address name
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
SceneCheerYuna_ToRunScriptSubStep::
Jump_00F_5F36:: ; address name
    farcall RunScriptSubStep
    ret

; entry 14 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptSubStep, wScriptParam0
; points at: wScriptStep
SceneCheerYuna_SetScriptSubStep::
Jump_00F_5F3D:: ; address name
    xor a, a
    ld [wScriptSubStep], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
SceneCheerYuna_ShowIAmTheKing::
Jump_00F_5F4A:: ; address name
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $03A1 ; 'I am the King. What is'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hPlayerFacing
; points at: wScriptStep, hPlayerX
SceneCheerYuna_WritePlayerFacing::
Jump_00F_5F65:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_00F_5F70
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5F70::
    jr nc, Jump_00F_5F80
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    inc [hl]
    ret

Jump_00F_5F80::
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    dec [hl]
    ret

; entry 10 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: hPlayerStateFlags, wScriptStep
SceneCheerYuna_StepObjectTowardCoord_Case0A::
Jump_00F_5F8E:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    farcall PlayMapMusic
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
SceneCheerYuna_ToScriptStepDeltaThenNextStep::
Jump_00F_5FB9:: ; address name
    ld de, wObject2 + $C
    call ScriptStepDeltaThenNextStep
    ret

; entry 7 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
SceneCheerYuna_ShowEnoughEnoughOfThat::
Jump_00F_5FC0:: ; address name
    ld a, $02
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, $03A0 ; 'Enough Enough of that dancing!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
SceneCheerYuna_StepScriptParam0Counter_Bank0F_Case04::
Jump_00F_5FD6:: ; address name
    ld b, $4B
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $01
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneCheerYuna_SetBit2AtHL_B0F_Case03::
Jump_00F_5FEC:: ; address name
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld b, $1E
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
SceneCheerYuna_StepScriptParam0Counter_Bank0F::
Jump_00F_6003:: ; address name
    ld b, $4B
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wScriptParam0
; writes: wObject2, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
SceneCheerYuna_SetBit2AtHL_B0F::
Jump_00F_6019:: ; address name
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld a, [wFrameCounterLo]
    srl a
    srl a
    srl a
    and a, $03
    ld [wObject2 + $7], a
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_00F_6049
    ld hl, wObject2 + $B
    inc [hl]

Jump_00F_6049::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneCheerYuna
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneCheerYuna_StepObjectTowardCoord::
Jump_00F_6066:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_608E
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call SceneCheerYuna_Case00_WriteObject2
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_608E::
    dec a
    jr nz, Jump_00F_60B3
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call SceneCheerYuna_Case00_WriteObject2
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_60B3::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call SceneCheerYuna_Case00_WriteObject2
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from SceneCheerYuna_Case00 (E-0047)
; 3 call sites from 1 routine (e.g. SceneCheerYuna_StepObjectTowardCoord)
; reads: wFrameCounterLo
; writes: wObject2
SceneCheerYuna_Case00_WriteObject2::
Func_00F_60D9:: ; address name
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and a, $03
    ld [wObject2 + $7], a
    ret

; implements script command type 41 (SCRIPT_SCENE_EXPLOSION): a cutscene step named after the scene its only script shows: 'What? What was that explosion?' (screen shake and flash); reached through ScriptCommand41 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand41)
; reads: wScriptStep
SceneExplosion::
Func_00F_60E6:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 9 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5, wObject2, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, ...
SceneExplosion_QueueSoundEffect::
Jump_00F_60FE:: ; address name
    ld a, [wObject5 + $5]
    inc a
    inc a
    ld [wObject5 + $5], a
    cp a, $10
    ret nz
    ld a, $72
    call QueueSoundEffect
    ld a, $52
    ld [wObject2 + $2], a
    ldh [hTemp0], a
    xor a, a
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
SceneExplosion_ToScriptStepShakeScreen::
Jump_00F_613A:: ; address name
    ld b, $0F
    call ScriptStepShakeScreen
    ret

; entry 7 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
SceneExplosion_ScriptStepFlashScreenNegative::
Jump_00F_6140:: ; address name
    ld a, $E0
    ld [wSpriteSlots + $B], a
    farcall ScriptStepFlashScreenNegative
    ret

; entry 6 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, wIsCGB
; writes: wScriptParam0, hPlayerY, wFollowerRecords, hTemp0
; points at: hPlayerStateFlags, wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
SceneExplosion_SetBit2AtHL_B0F::
Jump_00F_614C:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    cp a, $40
    ret nz
    ld a, $09
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_6189
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_00F_6189::
    ld a, $7A
    call QueueSoundEffect
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneExplosion_Msg0348_DarnTakeThisSACRIFICE::
Jump_00F_619D:: ; address name
    ld hl, $0348 ; 'Darn! Take this! SACRIFICE!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneExplosion_RunMessageBoxFar_Bank0F::
Jump_00F_61A8:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $03
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
SceneExplosion_ScriptStepShakeScreen::
Jump_00F_61BC:: ; address name
    ld b, $3C
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
    ld hl, wFollowerRecords + $C
    inc [hl]
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld hl, $0346 ; 'Don't you touch that. If you'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
SceneExplosion_StepObjectTowardCoord::
Jump_00F_622E:: ; address name
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $66
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneExplosion
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStep
; points at: wScriptStep
SceneExplosion_TestFlagBit::
Jump_00F_6252:: ; address name
    ld de, $0085
    call TestFlagBit
    jr c, Jump_00F_626B
    farcall RedrawColumnsBesideScreen
    ld de, $0085
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_626B::
    ld hl, $0347 ; 'You again? I'll have to get'
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

; implements script command type 45 (SCRIPT_SCENE_PLAN_RUINED): a cutscene step named after the scene its only script shows: 'Arrgh, you've ruined my plan' ... 'Bravo! We're saved!' (starts a scripted encounter); reached through ScriptCommand45 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand45)
; reads: wScriptStep
ScenePlanRuined::
Func_00F_6277:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScenePlanRuined_TestFlagBit
    dw ScenePlanRuined_StepScriptParam0Counter_Bank0F
    dw ScenePlanRuined_StartScriptedEncounterTemp0AndStep
    dw ScenePlanRuined_ScriptStepBlinkObjectTemp0

; entry 3 of the `rst $00` table in ScenePlanRuined
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlots, wScriptStartRequest
ScenePlanRuined_ScriptStepBlinkObjectTemp0::
Jump_00F_6283:: ; address name
    ld a, $00
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScenePlanRuined
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScenePlanRuined_StartScriptedEncounterTemp0AndStep::
Jump_00F_62A0:: ; address name
    ld a, $0C
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScenePlanRuined
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScenePlanRuined_StepScriptParam0Counter_Bank0F::
Jump_00F_62AF:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, $0093
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScenePlanRuined
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wScriptParam0
; writes: wSpriteSlots, wObject2
; points at: wScriptStep
ScenePlanRuined_TestFlagBit::
Jump_00F_62C0:: ; address name
    ld de, $0093
    call TestFlagBit
    jr nc, Jump_00F_62D1
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_62D1::
    ld a, [wObject2 + $7]
    ld [wSpriteSlots + $7], a
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_00F_62E4
    bit 1, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62E4::
    cp a, $3C
    jr nc, Jump_00F_62EE
    bit 2, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62EE::
    bit 3, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62F4::
    ld a, $40
    ld [wSpriteSlots + $C], a
    ld a, $E0
    ld [wObject2 + $C], a
    jr Jump_00F_630A

Jump_00F_6300::
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $40
    ld [wObject2 + $C], a

Jump_00F_630A::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $40
    ld [wSpriteSlots + $C], a
    ld a, $E0
    ld [wObject2 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 43 (SCRIPT_SCENE_WALL_EXIT): a cutscene step named after the scene its only script shows: '0 tapped on the wall.' ... 'Kameha That's it! That's the exit!'; reached through ScriptCommand43 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand43)
; reads: wScriptStep
SceneWallExit::
Func_00F_631F:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 12 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wObject1, wScriptStartRequest
SceneWallExit_StepObjectTowardCoord_Case0C::
Jump_00F_633D:: ; address name
    ld a, [wObject1 + $C]
    cp a, $50
    jr z, Jump_00F_635A
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_635A::
    ld a, [wObject1 + $B]
    cp a, $30
    jr z, Jump_00F_6372
    dec a
    dec a
    ld [wObject1 + $B], a
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld a, $03
    ld [wObject1 + $7], a
    ret

Jump_00F_6372::
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wStoryFlags
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wStoryFlags, wScreenTileBuffer, wScriptStartRequest
; points at: wScriptStep
SceneWallExit_ShowKamehaHeroThatWasnt::
Jump_00F_6383:: ; address name
    ld hl, wObject1 + $C
    inc [hl]
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $3C
    call ScriptStepShakeScreen
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, [wScriptParam1]
    cp a, $30
    jr z, Jump_00F_63BD
    ld hl, $0362 ; 'Kameha 0 That wasn't it'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_63BD::
    ld a, [wStoryFlags + $63]
    set 0, a
    ld [wStoryFlags + $63], a
    ld a, $38
    ld [wScreenTileBuffer + $6], a
    ld a, $39
    ld [wScreenTileBuffer + $7], a
    ld a, $3A
    ld [wScreenTileBuffer + $1A], a
    ld a, $3B
    ld [wScreenTileBuffer + $1B], a
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, wScriptParam1
; writes: wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
SceneWallExit_StepObjectTowardCoord::
Jump_00F_63E5:: ; address name
    ld a, $00
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam1]
    cp a, $30
    jr z, Jump_00F_6410
    ld a, $63
    call QueueSoundEffect
    ret

Jump_00F_6410::
    ld a, $66
    call QueueSoundEffect
    ret

; entry 8 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1
; points at: wScriptStep
SceneWallExit_WriteScriptParam0AndObject1::
Jump_00F_6416:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $07
    ret nz
    ld a, [wObject1 + $C]
    inc a
    ld [wObject1 + $C], a
    cp a, $30
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wObject1, wStepArrived
; writes: wObject1, wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
SceneWallExit_SetBit2AtHL_B0F_Case07::
Jump_00F_6433:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wObject1 + $B]
    cp a, c
    jr z, Jump_00F_644E
    inc a
    inc a
    ld [wObject1 + $B], a
    ld a, $01
    ld [wObject1 + $7], a
    ret

Jump_00F_644E::
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam1, wScriptParam0, hPlayerFacing
; writes: hPlayerX, hPlayerFacing, wScriptParam0
; points at: hPlayerStateFlags, wScriptStep
SceneWallExit_SetBit2AtHL_B0F::
Jump_00F_6473:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam1]
    cp a, $40
    jr nc, Jump_00F_6490
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    ld a, $01
    ldh [hPlayerFacing], a
    jr Jump_00F_6499

Jump_00F_6490::
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    ld a, $03
    ldh [hPlayerFacing], a

Jump_00F_6499::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ret

; entry 1 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wObject5, wScriptParam1
; points at: wScriptStep
SceneWallExit_ShowKamehaSoThatsWhere::
Jump_00F_64BA:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    ld [wScriptParam1], a
    ld hl, $0361 ; 'Kameha So that's where the exit'
    call StartMessageHL_B0F
    ret

; entry 0 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneWallExit_RedrawColumnsBesideScreen::
Jump_00F_64D4:: ; address name
    farcall RedrawColumnsBesideScreen
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $30
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 42 (SCRIPT_SCENE_REPORT_TO_KING): a cutscene step named after the scene its only script shows: 'We reported to the King that...'; reached through ScriptCommand42 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand42)
; reads: wScriptStep
SceneReportToKing::
Func_00F_64F3:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 17 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY, wFollowerRecords
; writes: hPlayerY, wFollowerRecords, wScriptStartRequest, wStepPtrLo, wStepPtrHi
; points at: wScriptParam1, hPlayerStateFlags
SceneReportToKing_AddStepDeltaToPointedByte::
Jump_00F_651B:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_652D
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_00F_654D
    ld hl, wScriptParam1
    inc [hl]
    jr Jump_00F_654D

Jump_00F_652D::
    dec a
    jr nz, Jump_00F_654D
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    jr nc, Jump_00F_654D
    ld hl, wScriptParam1
    inc [hl]

Jump_00F_654D::
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_6557
    inc a
    inc a
    ldh [hPlayerY], a

Jump_00F_6557::
    ld a, [wFollowerRecords + $2]
    cp a, $40
    jr z, Jump_00F_6563
    inc a
    inc a
    ld [wFollowerRecords + $2], a

Jump_00F_6563::
    ld a, [wFollowerRecords + $7]
    cp a, $40
    jr z, Jump_00F_656F
    inc a
    inc a
    ld [wFollowerRecords + $7], a

Jump_00F_656F::
    ld a, [wFollowerRecords + $C]
    inc a
    inc a
    ld [wFollowerRecords + $C], a
    cp a, $40
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerRecords
; points at: hPlayerStateFlags, wScriptStep
SceneReportToKing_SetBit1AtHL_Bank0FAndStep::
Jump_00F_6586:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank0F
    ld a, $D0
    ld [wFollowerRecords + $2], a
    ld a, $C0
    ld [wFollowerRecords + $7], a
    ld a, $B0
    ld [wFollowerRecords + $C], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerX, wFollowerRecords, hFieldDrawFlags, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, ...
SceneReportToKing_ScriptStartFadeAndAdvanceStep::
Jump_00F_65A5:: ; address name
    ld a, $E0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $4D
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $E0
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 14 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; writes: hFieldDrawFlags
; points at: wScriptStep
SceneReportToKing_WriteFieldDrawFlags::
Jump_00F_65D6:: ; address name
    ld a, $0F
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: hFieldDrawFlags, wScriptStep
; points at: wScriptStep
SceneReportToKing_WriteFieldDrawFlagsAndScriptStep_Case0C::
Jump_00F_65DF:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $07
    ldh [hFieldDrawFlags], a
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 10 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: hFieldDrawFlags, wScriptStep
; points at: wScriptStep
SceneReportToKing_WriteFieldDrawFlagsAndScriptStep::
Jump_00F_65F3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hFieldDrawFlags], a
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTileBuffer, hFieldDrawFlags
; points at: wScriptStep
SceneReportToKing_DrawFullScreenBufferAtScroll::
Jump_00F_6606:: ; address name
    ld a, $6A
    ld [wScreenTileBuffer + $A8], a
    ld [wScreenTileBuffer + $A9], a
    ld [wScreenTileBuffer + $BC], a
    ld [wScreenTileBuffer + $BD], a
    farcall DrawFullScreenBufferAtScroll
    ld a, $01
    ldh [hFieldDrawFlags], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
SceneReportToKing_StepObjectTowardCoord_Case06::
Jump_00F_6628:: ; address name
    ld a, [wObject1 + $B]
    cp a, $40
    jr z, Jump_00F_6645
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_6645::
    ld a, $A0
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $035B ; 'You're no envoy of the spirit!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
SceneReportToKing_ScriptStepDeltaThenNextStep::
Jump_00F_666A:: ; address name
    ld a, $02
    ld [wObject1 + $7], a
    ld de, wObject1 + $C
    call ScriptStepDeltaThenNextStep
    ret

; entry 3 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneReportToKing_Msg035A_WhatIsItYou::
Jump_00F_6676:: ; address name
    ld hl, $035A ; 'What is it, you whelp!? You'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 40 (SCRIPT_SCENE_SPIRIT_ENVOY): a cutscene step named after the scene its only script shows: 'Ah, you are the spirit's envoy.' ... 'We reported to the King that...'; reached through ScriptCommand40 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand40)
; reads: wScriptStep
SceneSpiritEnvoy::
Func_00F_6681:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 10 of the `rst $00` table in SceneSpiritEnvoy
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneSpiritEnvoy_SetScriptStartRequestTo80::
Jump_00F_669B:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in SceneSpiritEnvoy
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
SceneSpiritEnvoy_StepPlayerDownTowardWC928_Case06::
Jump_00F_66A1:: ; address name
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneSpiritEnvoy
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, hPlayerStateFlags
; writes: wStepPtrLo, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, hFF80, wScriptStep
SceneSpiritEnvoy_StepPlayerDownTowardWC928::
Jump_00F_66B6:: ; address name
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
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

; entry 2 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wObject1
; points at: wScriptStep
SceneReportToKing_StepObjectTowardCoord_Case02::
Jump_00F_66F4:: ; address name
    ld a, [wObject1 + $C]
    cp a, $60
    jr z, Jump_00F_6712
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    jr Jump_00F_6735

Jump_00F_6712::
    ld a, [wObject1 + $B]
    cp a, $30
    jr z, Jump_00F_6730
    ld a, $30
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    jr Jump_00F_6735

Jump_00F_6730::
    ld a, $01
    ld [wObject1 + $7], a

Jump_00F_6735::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $0322 ; 'You're the envoy? Well, no matter!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest
; points at: wScriptStep
SceneReportToKing_UpdatePlayerMovement::
Jump_00F_6750:: ; address name
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneReportToKing
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, hPlayerStateFlags
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, wScriptStep
SceneReportToKing_StepObjectTowardCoord::
Jump_00F_6767:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    dec [hl]
    ldh a, [hPlayerStateFlags]
    or a, $01
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
; 2 call sites from 2 routines (e.g. ScriptCommand39, ScriptCommand3B)
; reads: wScriptStep
SceneMermaidKingdom::
Func_00F_67BA:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 49 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: hTemp0, wStoryFlags, wFarmLevel, wScriptStartRequest
SceneMermaidKingdom_SetFlagBit_Case31::
Jump_00F_6822:: ; address name
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

; entry 47 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
SceneMermaidKingdom_ShowWarubouWaheyYouCan::
Jump_00F_6845:: ; address name
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $0DC1 ; 'Warubou Wa-hey, you can now crush'
    call StartMessageHL_B0F
    ld de, $001F
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wSpriteSlots, hTemp0, wObject5
; points at: wScriptStep
SceneMermaidKingdom_RunFieldCommandTemp0::
Jump_00F_6866:: ; address name
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
SceneMermaidKingdom_ToRunSceneScriptSubStep::
Jump_00F_6894:: ; address name
    farcall RunSceneScriptSubStep
    ret

; entry 44 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wObject5, ...
; points at: hPlayerStateFlags
SceneMermaidKingdom_ShowWarubouWaheyYouDid::
Jump_00F_689B:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, $02A7 ; 'Warubou Wa-hey! You did it, 0!'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ldh a, [hPlayerStateFlags]
    and a, $BF
    ldh [hPlayerStateFlags], a
    ret

; entry 42 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneMermaidKingdom_Msg0873_WaheyHeroHearMe::
Jump_00F_68E0:: ; address name
    ld hl, $0873 ; 'Wa-hey! 0, hear me? I felt'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 40 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneMermaidKingdom_ShowAVoiceEchoedFrom::
Jump_00F_68EB:: ; address name
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, $0872 ; 'A voice echoed from nowhere'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 39 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneMermaidKingdom_StepScriptParam0Counter_Bank0F_Case27::
Jump_00F_6905:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case26::
Jump_00F_6910:: ; address name
    ld hl, wObject5 + $4
    inc [hl]
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 37 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
SceneMermaidKingdom_StepPlayerLeftTowardWC928::
Jump_00F_6924:: ; address name
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld de, $005F
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 36 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wScriptParam0, wSpriteSlotCount
; points at: wScriptStep
SceneMermaidKingdom_WriteStepTargetAndStepPtrLoEtc::
Jump_00F_693F:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_6951
    ld a, $83
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    jr Jump_00F_6979

Jump_00F_6951::
    dec a
    jr nz, Jump_00F_6960
    ld a, $82
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr Jump_00F_6979

Jump_00F_6960::
    dec a
    jr nz, Jump_00F_696F
    ld a, $83
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr Jump_00F_6979

Jump_00F_696F::
    ld a, $82
    ld [wStepTarget], a
    ld a, $00
    ld [wStepPtrLo], a

Jump_00F_6979::
    ld a, $00
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $04
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    farcall PlayMapMusic
    ret

; entry 34 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots
; points at: wScriptStep
SceneMermaidKingdom_ShowKamehaIWasStupid::
Jump_00F_69A6:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    srl a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld b, $38
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, FieldSpriteGfx03
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $03
    ld [wSpriteSlots + $2], a
    ld hl, $0871 ; 'Kameha I was stupid to trust'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrLo, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneMermaidKingdom_StepPlayerDownTowardWC928::
Jump_00F_69D5:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_69F0
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_69F0::
    dec a
    jr nz, Jump_00F_6A08
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6A08::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5, wSpriteSlotCount
; points at: wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case20::
Jump_00F_6A21:: ; address name
    ld a, [wObject5 + $5]
    dec a
    dec a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 31 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wObject1, wObject2, wObject5
; points at: wScriptStep
SceneMermaidKingdom_QueueSoundEffect::
Jump_00F_6A3F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    push af
    bit 4, a
    jr z, Jump_00F_6A4F
    ld a, $01
    jr Jump_00F_6A51

Jump_00F_6A4F::
    ld a, $03

Jump_00F_6A51::
    ld [wObject1 + $7], a
    inc a
    inc a
    and a, $03
    ld [wObject2 + $7], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [wObject5], a
    ld a, $65
    call QueueSoundEffect
    ld a, $E0
    ld [wObject1 + $B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, hPlayerX, hPlayerY
; writes: wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneMermaidKingdom_SetFlagBit::
Jump_00F_6A77:: ; address name
    ld a, [wStoryFlags + $62]
    set 3, a
    ld [wStoryFlags + $62], a
    ld de, $007F
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 21 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
SceneMermaidKingdom_ToScriptStepShakeScreen::
Jump_00F_6A9B:: ; address name
    ld b, $0F
    call ScriptStepShakeScreen
    ret

; entry 20 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE_Case14::
Jump_00F_6AA1:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
SceneMermaidKingdom_ToScriptStepDeltaThenMessage_Case12::
Jump_00F_6AB2:: ; address name
    ld de, wObject2 + $C
    ld hl, $0870
    call ScriptStepDeltaThenMessage
    ret

; entry 17 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5
; points at: wScriptStep
SceneMermaidKingdom_ScriptApplyStepDeltaAtDE::
Jump_00F_6ABC:: ; address name
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
SceneMermaidKingdom_ToScriptStepDeltaThenMessage_Case0F::
Jump_00F_6AD3:: ; address name
    ld de, wSpriteSlots + $C
    ld hl, $086F
    call ScriptStepDeltaThenMessage
    ret

; entry 14 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wObject1, ...
; points at: wScriptStep
SceneMermaidKingdom_DecompressGraphicsTemp0ToTemp4::
Jump_00F_6ADD:: ; address name
    xor a, a
    ld [wSpriteSlots + $1], a
    ld a, $E3
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a, a
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
    xor a, a
    ld [wObject1 + $1], a
    ld a, $D6
    ld [wObject1 + $2], a
    ldh [hTemp0], a
    xor a, a
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5
; points at: wScriptStep
SceneMermaidKingdom_ShowKahahaha::
Jump_00F_6B31:: ; address name
    ld a, [wObject5 + $5]
    dec a
    dec a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $086E ; 'Kahahaha'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, hTemp0, wObject5
; points at: wScriptStep
SceneMermaidKingdom_StepObjectTowardCoord::
Jump_00F_6B4B:: ; address name
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
    or a, a
    ret z
    ld a, $08
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $60
    ld a, a
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
SceneMermaidKingdom_ToScriptStepDeltaThenMessage::
Jump_00F_6B99:: ; address name
    ld de, wObject2 + $C
    ld hl, $086D
    call ScriptStepDeltaThenMessage
    ret

; entry 8 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
SceneMermaidKingdom_StepScriptParam0Counter_Bank0F::
Jump_00F_6BA3:: ; address name
    ld a, [wObject2 + $B]
    cp a, $80
    jr z, Jump_00F_6BAF
    inc a
    inc a
    ld [wObject2 + $B], a

Jump_00F_6BAF::
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wObject1
; writes: wScriptParam0, wObject1, wScriptParam1
; points at: wScriptStep
SceneMermaidKingdom_WriteScriptParam0AndObject1Etc::
Jump_00F_6BBA:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_6BDA
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    cp a, $30
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_00F_6BDA::
    ld a, [wObject1 + $B]
    inc a
    inc a
    ld [wObject1 + $B], a
    cp a, $40
    ret nz
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneMermaidKingdom_SetBit2AtHL_B0F::
Jump_00F_6BF6:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_6C17
    ld a, $03
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    dec a
    dec a
    ld [wObject1 + $B], a
    cp a, $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C17::
    dec a
    jr nz, Jump_00F_6C2F
    ld a, $00
    ld [wObject1 + $7], a
    ld a, [wObject1 + $C]
    inc a
    inc a
    ld [wObject1 + $C], a
    cp a, $50
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C2F::
    dec a
    jr nz, Jump_00F_6C47
    ld a, $01
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    inc a
    inc a
    ld [wObject1 + $B], a
    cp a, $60
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C47::
    dec a
    jr nz, Jump_00F_6C5F
    ld a, $02
    ld [wObject1 + $7], a
    ld a, [wObject1 + $C]
    dec a
    dec a
    ld [wObject1 + $C], a
    cp a, $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C5F::
    dec a
    jr nz, Jump_00F_6C77
    ld a, $03
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    dec a
    dec a
    ld [wObject1 + $B], a
    cp a, $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C77::
    ld a, $00
    ld [wObject1 + $7], a
    ld a, [wObject1 + $C]
    inc a
    inc a
    ld [wObject1 + $C], a
    cp a, $40
    ret nz
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld de, FieldSpriteGfx45
    ld b, $7D
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, $45
    ld [wObject2 + $2], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneMermaidKingdom_ShowKamehaGaspHackI::
Jump_00F_6CAB:: ; address name
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
    or a, a
    ret z
    farcall RedrawColumnsBesideScreen
    ld hl, $086C ; 'Kameha Gasp Hack I did it'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneWallExit
; no direct call (reached through a table, a jump or a vector)
SceneWallExit_ToScriptStepMoveFollowersToLeader::
Jump_00F_6D00:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ret

; entry 0 of the `rst $00` table in SceneMermaidKingdom
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wStepArrived
; writes: wScriptStep, wStepPtrLo, hPlayerFacing
; points at: wScriptStep
SceneMermaidKingdom_WriteScriptStepAndStepPtrLoEtc::
Jump_00F_6D07:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_00F_6D13
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_00F_6D13::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 38 (SCRIPT_SCENE_KAMEHA_FLEES): a cutscene step named after the scene its only script shows: 'Kameha Arrrrh, clear the way!' ... 'Kameha Aiyeeeeeh'; reached through ScriptCommand38 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand38)
; reads: wScriptStep
SceneKamehaFlees::
Func_00F_6D2B:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 12 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
SceneKamehaFlees_ToSceneKamehaFlees_SetFlagBit::
Jump_00F_6D49:: ; address name
    call SceneKamehaFlees_SetFlagBit
    ret

; only called from routines of SceneKamehaFlees (E-0098)
; 2 call sites from 2 routines (e.g. SceneKamehaFlees_ToSceneKamehaFlees_SetFlagBit, SceneKamehaFlees_StepObjectTowardCoord)
; reads: wScriptParam0, wObject5
; writes: wScriptParam0, wObject5, wScriptStartRequest
SceneKamehaFlees_SetFlagBit::
Func_00F_6D4D:: ; address name
    ld hl, wObject5 + $4
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    and a, $07
    ld [wScriptParam0], a
    ld hl, $6D78
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + $5], a
    ld a, [wObject5 + $4]
    cp a, $A0
    ret nz
    ld de, $007E
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $40, $3F, $40, $3F, $40, $3E, $40, $41

; entry 11 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlotCount
; points at: wScriptStep
SceneKamehaFlees_StepObjectTowardCoord::
Jump_00F_6D80:: ; address name
    call SceneKamehaFlees_SetFlagBit
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + $B]
    cp a, $A0
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hScrollX
; writes: wStepPtrLo, wStepPtrHi, hScrollX, hFieldDrawFlags
; points at: wScriptStep
SceneKamehaFlees_AddStepDeltaToPointedByte::
Jump_00F_6DD1:: ; address name
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_6E16
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a

Jump_00F_6E16::
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add a, $07
    and a, $F8
    ldh [hScrollX], a
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ldh [hFieldDrawFlags], a
    ret

; entry 9 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5, wScriptParam0, hFieldDrawFlags
; points at: wScriptStep
SceneKamehaFlees_RedrawColumnsBesideScreen::
Jump_00F_6E31:: ; address name
    ld a, [wObject5 + $5]
    inc a
    inc a
    ld [wObject5 + $5], a
    cp a, $40
    ret nz
    farcall RedrawColumnsBesideScreen
    ld a, $66
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ret

; entry 8 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wObject2, hTemp0, wObject5
; points at: wScriptStep
SceneKamehaFlees_WriteObject2AndTemp0Etc::
Jump_00F_6E54:: ; address name
    ld b, $03
    ld hl, wSpriteSlots + $C

Jump_00F_6E59::
    push hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_00F_6E64
    dec a
    dec a
    ld [hl], a
    jr Jump_00F_6E6F

Jump_00F_6E64::
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

Jump_00F_6E6F::
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_6E59
    ld a, [wSpriteSlots + $B]
    cp a, $40
    ret nz
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
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

; entry 3 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneKamehaFlees_StepScriptParam0Counter_Bank0F::
Jump_00F_6EB0:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wScriptParam0
; points at: hPlayerStateFlags, wScriptStep
SceneKamehaFlees_UpdateFollowersOnStep_Bank0F_Case06::
Jump_00F_6ECD:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: wScriptStep
SceneKamehaFlees_UpdateFollowersOnStep_Bank0F::
Jump_00F_6EF0:: ; address name
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
    cp a, $30
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wObject1, wSpriteSlots
; writes: hPlayerFacing, wObject2, wObject1, wSpriteSlots
; points at: hPlayerStateFlags, wScriptStep
SceneKamehaFlees_ClearBit2AtHL_Bank0F::
Jump_00F_6F0C:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wObject2 + $C]
    dec a
    dec a
    ld [wObject2 + $C], a
    ld a, [wObject1 + $C]
    dec a
    dec a
    ld [wObject1 + $C], a
    ld a, [wSpriteSlots + $C]
    dec a
    dec a
    ld [wSpriteSlots + $C], a
    cp a, $70
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank0F
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneKamehaFlees
; no direct call (reached through a table, a jump or a vector)
SceneKamehaFlees_ScriptStepMoveFollowersToLeader::
Jump_00F_6F4C:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ret

; implements script command type 37 (SCRIPT_SCENE_CREW_FOLLOWS): a cutscene step named after the scene its only script shows: 'Aye, aye, sir! Right behind you!'; reached through ScriptCommand37 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand37)
; reads: wScriptStep
SceneCrewFollows::
Func_00F_6F65:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneCrewFollows_SetBit2AtHL_B0F
    dw SceneCrewFollows_StepScriptParam0Counter_Bank0F
    dw SceneCrewFollows_SetBit2AtHL_B0FAndStep
    dw SceneCrewFollows_WriteScriptParam0AndSpriteSlotsEtc

; entry 3 of the `rst $00` table in SceneCrewFollows
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wSpriteSlots, wObject2, wObject1, wScriptStartRequest
SceneCrewFollows_WriteScriptParam0AndSpriteSlotsEtc::
Jump_00F_6F71:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    push af
    bit 4, a
    jr z, Jump_00F_6F81
    ld a, $01
    jr Jump_00F_6F83

Jump_00F_6F81::
    ld a, $03

Jump_00F_6F83::
    ld [wSpriteSlots + $7], a
    ld [wObject2 + $7], a
    inc a
    inc a
    and a, $03
    ld [wObject1 + $7], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneCrewFollows
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
SceneCrewFollows_SetBit2AtHL_B0FAndStep::
Jump_00F_6F9A:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneCrewFollows
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hScrollX, wStoryFlags, hPlayerX, hPlayerY
; writes: hScrollX, wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind, wFieldReturnPhase
SceneCrewFollows_StepScriptParam0Counter_Bank0F::
Jump_00F_6FB5:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_6FC7
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a

Jump_00F_6FC7::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add a, $07
    and a, $F8
    ldh [hScrollX], a
    ld de, $007D
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
    xor a, a
    ld [wFieldReturnPhase], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call QueueSoundEffect
    ret

; entry 0 of the `rst $00` table in SceneCrewFollows
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; points at: wScriptStep
SceneCrewFollows_SetBit2AtHL_B0F::
Jump_00F_7002:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld b, $03
    ld hl, wSpriteSlots + $B

Jump_00F_7019::
    ld a, [hl]
    inc a
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_7019
    ld a, [wSpriteSlots + $B]
    cp a, $60
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 36 (SCRIPT_SCENE_KAMEHA_CAUGHT): a cutscene step named after the scene its only script shows: 'Kameha Wahahahah! Thanks for guiding me' ... 'Kameha Urk! How you catch up?'; reached through ScriptCommand36 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand36)
; reads: wScriptStep
SceneKamehaCaught::
Func_00F_7049:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKamehaCaught_SetBit2AtHL_B0FAndStep
    dw SceneKamehaCaught_WriteSpriteSlotCountAndScriptStartRequest

; entry 0 of the `rst $00` table in SceneKamehaCaught
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
SceneKamehaCaught_SetBit2AtHL_B0FAndStep::
Jump_00F_7051:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneKamehaCaught
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wSpriteSlotCount, wScriptStartRequest
SceneKamehaCaught_WriteSpriteSlotCountAndScriptStartRequest::
Jump_00F_706C:: ; address name
    ld b, $03
    ld hl, wSpriteSlots + $C

Jump_00F_7071::
    ld a, [hl]
    cp a, $E0
    jr z, Jump_00F_7079
    dec a
    dec a
    ld [hl], a

Jump_00F_7079::
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_7071
    ld a, [wObject2 + $C]
    cp a, $E0
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 32 (SCRIPT_GIVE_ITEM_BLINK): adds item wC928 to the inventory (AppendItemWC928ToInventory) and blinks object hTemp0; '0 obtained YunaSoul.'; reached through ScriptCommand32 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand32)
; reads: wScriptStep
GiveItemBlink::
Func_00F_7093:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GiveItemBlink_TestFlagBit

; entry 0 of the `rst $00` table in GiveItemBlink
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wScriptStartRequest, wStepPtrLo
GiveItemBlink_TestFlagBit::
Jump_00F_7099:: ; address name
    ld de, $0075
    call TestFlagBit
    jr c, Jump_00F_70BD
    ld a, $00
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00F_70BD::
    ld a, $00
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld de, $009B
    call TestFlagBit
    jr nc, Jump_00F_70E2
    ld a, $33
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory

Jump_00F_70E2::
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 29 (SCRIPT_SCENE_WHO_ARE_YOU): a cutscene step named after the scene its only script shows: after a sound and a 140-frame wait, before 'Who are you? This is our...' and 'Zzz Zzz Huh! Watch out!'; reached through ScriptCommand29 in bank $10 (E-0038, E-0246)
; 1 call site from 1 routine (e.g. ScriptCommand29)
; reads: wScriptStep
SceneWhoAreYou::
Func_00F_70EC:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 9 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam0, hPlayerStateFlags
; writes: wScriptParam0, hPlayerStateFlags, wScriptStartRequest
SceneWhoAreYou_UpdateFollowersOnStep_Bank0F_Case09::
Jump_00F_7104:: ; address name
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld de, $0064
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hPlayerX, wScriptParam0
; points at: wScriptStep
SceneWhoAreYou_UpdateFollowersOnStep_Bank0F::
Jump_00F_712A:: ; address name
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
    cp a, $70
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wSpriteSlots, wStepArrived, hPlayerStateFlags
; writes: wScriptParam0, wSpriteSlots, wScriptParam1, wStepPtrHi, wStepTarget, wStepPtrLo, hPlayerStateFlags
; points at: wScriptStep
SceneWhoAreYou_WriteScriptParam0AndSpriteSlotsEtc::
Jump_00F_714A:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_716A
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $20
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_00F_716A::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, hPlayerFacing
; points at: wScriptStep
SceneWhoAreYou_StepObjectTowardCoord::
Jump_00F_7198:: ; address name
    ld a, [wSpriteSlots + $B]
    cp a, $30
    jr z, Jump_00F_71B5
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_71B5::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wObject1, wObject2, wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneWhoAreYou_ShowKamehaHeyYoureHero::
Jump_00F_71DD:: ; address name
    xor a, a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $0833 ; 'Kameha Hey! You're 0, the farmer!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
SceneWhoAreYou_ToScriptStepDeltaThenNextStep::
Jump_00F_7209:: ; address name
    ld de, wSpriteSlots + $C
    call ScriptStepDeltaThenNextStep
    ret

; entry 1 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
; points at: wScriptStep
SceneWhoAreYou_ShowTchMadeMeWaste::
Jump_00F_7210:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, $0832 ; 'Tch, made me waste my time'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneWhoAreYou
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wObject2
; points at: wScriptStep
SceneWhoAreYou_SetBit2AtHL_B0F::
Jump_00F_7225:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld hl, wSpriteSlots + $C
    ld b, $03

Jump_00F_723C::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_723C
    ld a, [wSpriteSlots + $C]
    cp a, $40
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, $0831 ; 'Heh, that old man, he was'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 28 (SCRIPT_SHAKE_SCREEN): shakes the screen (ScriptStepShakeScreen) with a sound effect; reached through ScriptCommand28 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand28)
; reads: wScriptStep
ShakeScreen::
Func_00F_7271:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ShakeScreen_RedrawColumnsBesideScreenAndStep
    dw ShakeScreen_ToScriptStepShakeScreen
    dw ShakeScreen_QueueSoundEffect

; entry 0 of the `rst $00` table in ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ShakeScreen_RedrawColumnsBesideScreenAndStep::
Jump_00F_727B:: ; address name
    farcall RedrawColumnsBesideScreen
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ShakeScreen
; no direct call (reached through a table, a jump or a vector)
ShakeScreen_ToScriptStepShakeScreen::
Jump_00F_728B:: ; address name
    ld b, $78
    call ScriptStepShakeScreen
    ret

; entry 2 of the `rst $00` table in ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ShakeScreen_QueueSoundEffect::
Jump_00F_7291:: ; address name
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from SceneKamehaEscape_Case02 (E-0047)
; 1 call site from 1 routine (e.g. SceneKamehaEscape_WriteStepPtrLo)
; reads: wStepPtrLo, wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wScriptStep
SceneKamehaEscape_Case02_WriteScrollXAndScrollXHi::
Func_00F_729C:: ; address name
    ld a, [wStepPtrLo]
    ld b, a

; shakes hScrollX left and right with the frame counter until the wC921 counter expires, then resets the scroll and advances wScriptStep (E-0125)
; 7 call sites from 7 routines (e.g. SceneDarckDefeated_ToScriptStepShakeScreen, SceneThreeItems_ToScriptStepShakeScreen, SceneWallExit_ShowKamehaHeroThatWasnt, SceneExplosion_ToScriptStepShakeScreen, ...)
; reads: wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wScriptStep
ScriptStepShakeScreen::
Func_00F_72A0:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_72CB
    dec a
    add a, a
    ld c, a
    bit 7, a
    jr z, Jump_00F_72C0
    cpl
    inc a
    ld c, a
    ldh a, [hScrollX]
    sub a, c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    sbc a, $00
    ldh [hScrollXHi], a
    jr Jump_00F_72CB

Jump_00F_72C0::
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hScrollXHi], a

Jump_00F_72CB::
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 27 (SCRIPT_SCENE_RIVAL_DEFEATED): a cutscene step named after the scene its only script shows: 'You defeated my monster? Urggh' ... 'You again! You're determined!'; reached through ScriptCommand27 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand27)
; reads: wScriptStep
SceneRivalDefeated::
Func_00F_72D9:: ; address name
    ld a, [wScriptStep]
    rst $00
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
    dw SceneRivalDefeated_ShowKingWahahWeE
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_WriteObject5AndScriptTemp4Etc
    dw SceneRivalDefeated_ShowKingThisIsThe
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_ShowHeroObtainedTheTidalBell
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneRivalDefeated_Msg01A0_KingIEBeen
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

; entry 35 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: hTemp0, wStoryFlags, wFarmLevel, wScriptStartRequest
SceneRivalDefeated_SetFlagBit::
Jump_00F_7325:: ; address name
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

; entry 33 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
SceneRivalDefeated_ShowWarubouWaheyTheAbility::
Jump_00F_7348:: ; address name
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $0DC0 ; 'Warubou Wa-hey, the ability to cross'
    call StartMessageHL_B0F
    ld de, $001D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wSpriteSlots, hTemp0, wObject5
; points at: wScriptStep
SceneRivalDefeated_RunFieldCommandTemp0::
Jump_00F_7369:: ; address name
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 31 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
SceneRivalDefeated_ToRunSceneScriptSubStep::
Jump_00F_7397:: ; address name
    farcall RunSceneScriptSubStep
    ret

; entry 30 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wScriptSubStep
SceneRivalDefeated_ShowWarubouWaheyYouDid::
Jump_00F_739E:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0125 ; 'Warubou Wa-hey! You did it, 0!'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ret

; entry 28 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneRivalDefeated_Msg01A2_WaheyCanYouHear::
Jump_00F_73CD:: ; address name
    ld hl, $01A2 ; 'Wa-hey! Can you hear me? I'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlotCount
; points at: wScriptStep
SceneRivalDefeated_ShowAVoiceEchoedFrom::
Jump_00F_73D8:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, $01A1 ; 'A voice echoed from nowhere'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneRivalDefeated_Msg01A0_KingIEBeen::
Jump_00F_7401:: ; address name
    ld hl, $01A0 ; 'King I e been a burden'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptTemp4
; writes: wObject5, wPartyCount
; points at: wScriptStep
SceneRivalDefeated_ShowHeroObtainedTheTidalBell::
Jump_00F_740C:: ; address name
    ld hl, wObject5 + $4
    dec [hl]
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $019F ; '0 obtained the TidalBell.'
    call StartMessageHL_B0F
    xor a, a
    ld [wObject5], a
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneRivalDefeated_ShowKingThisIsThe::
Jump_00F_743A:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $019E ; 'King This is the TidalBell. It's'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wObject5, wScriptTemp4, wPartyCount
; points at: wScriptStep
SceneRivalDefeated_WriteObject5AndScriptTemp4Etc::
Jump_00F_7450:: ; address name
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    cp a, $03
    jr nz, Jump_00F_746E
    ld a, $02
    ld [wPartyCount], a

Jump_00F_746E::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots
; points at: wScriptStep
SceneRivalDefeated_ShowKingWahahWeE::
Jump_00F_7473:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $019D ; 'King Wahah! We e bagged the'
    call StartMessageHL_B0F
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wSpriteSlotCount, wSpriteSlots
; points at: wScriptStep
SceneRivalDefeated_StepObjectTowardCoord::
Jump_00F_749D:: ; address name
    ld a, $00
    ld [wStepTarget], a
    ld a, $A0
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
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, FieldSpriteGfx22
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $22
    ld [wSpriteSlots + $2], a
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2, wObject3, wSpriteSlots, wObject1
; points at: wScriptStep
SceneRivalDefeated_DecompressToVRAM::
Jump_00F_74F7:: ; address name
    ld a, $E0
    ld [wObject2 + $C], a
    ld a, $B0
    ld [wObject3 + $C], a
    ld a, $D0
    ld [wSpriteSlots + $C], a
    ld a, $C0
    ld [wObject1 + $C], a
    ld de, FieldSpriteGfx27
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $27
    ld [wSpriteSlots + $2], a
    ld de, FieldSpriteGfx27
    ld b, $7D
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld a, $27
    ld [wObject1 + $2], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneRivalDefeated_Msg019C_UrgahMercyISurrender::
Jump_00F_7530:: ; address name
    ld hl, $019C ; 'Urgah! Mercy! I surrender!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneRivalDefeated_Msg019B_AiyeehHelpMeBoss::
Jump_00F_753B:: ; address name
    ld hl, $019B ; 'Aiyeeh! Help me, boss!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
SceneRivalDefeated_QueueSoundEffect::
Jump_00F_7546:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_7553
    ld a, $7C
    call QueueSoundEffect
    jr Jump_00F_755C

Jump_00F_7553::
    cp a, $3C
    jr nz, Jump_00F_755C
    ld a, $81
    call QueueSoundEffect

Jump_00F_755C::
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

; entry 7 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi
; points at: wScriptStep
SceneRivalDefeated_ShowKingSurrenderAndLive::
Jump_00F_756F:: ; address name
    ld a, $02
    ld [wStepTarget], a
    ld a, $E0
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
    or a, a
    ret z
    ld hl, $019A ; 'King Surrender and live!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hPlayerFacing
; points at: wScriptStep
SceneRivalDefeated_StepPlayerLeftTowardWC928::
Jump_00F_75AA:: ; address name
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, hPlayerFacing
; points at: wScriptStep
SceneRivalDefeated_ShowKingYouThievesTheres::
Jump_00F_75C3:: ; address name
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
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, $0199 ; 'King You thieves! There's no escape!'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneRivalDefeated
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wStoryFlags
; writes: hTemp0, hTemp1, wStoryFlags
; points at: wScriptStep
SceneRivalDefeated_ScriptStepBlinkObjectTemp0::
Jump_00F_7601:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $10
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, [wStoryFlags + $61]
    set 5, a
    ld [wStoryFlags + $61], a
    ld de, $005A
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 23 (SCRIPT_SCENE_WATER_SHORTAGE): a cutscene step named after the scene its only script shows: 'King The town's water shortage seems...' ... 'King Wha-what? What happened?'; reached through ScriptCommand23 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand23)
; reads: wScriptStep
SceneWaterShortage::
Func_00F_7625:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWaterShortage_StepPlayerLeftTowardWC928
    dw SceneWaterShortage_ScriptStartFadeAndAdvanceStep
    dw SceneWaterShortage_StepPlayerDownTowardWC928
    dw SceneWaterShortage_StepPlayerLeftTowardWC928_Case03
    dw SceneWaterShortage_SetScriptStartRequestTo80

; entry 4 of the `rst $00` table in SceneWaterShortage
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneWaterShortage_SetScriptStartRequestTo80::
Jump_00F_7633:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in SceneWaterShortage
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneWaterShortage_StepPlayerLeftTowardWC928_Case03::
Jump_00F_7639:: ; address name
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $2E
    ldh [hMapId], a
    xor a, a
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

; entry 2 of the `rst $00` table in SceneWaterShortage
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wScriptParam0, wSpriteSlots
; points at: wScriptParam0, wScriptStep
SceneWaterShortage_StepPlayerDownTowardWC928::
Jump_00F_766D:: ; address name
    ld a, [wScriptParam0]
    and a, $0F
    jr nz, Jump_00F_768B
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    jr z, Jump_00F_7696
    ld hl, wScriptParam0
    inc [hl]
    jr Jump_00F_7696

Jump_00F_768B::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928

Jump_00F_7696::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    and a, $F0
    jr nz, Jump_00F_76C0
    ld a, $00
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, [wScriptParam0]
    or a, $10
    ld [wScriptParam0], a
    ret

Jump_00F_76C0::
    ld a, $03
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $E0
    ld [wSpriteSlots + $B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneWaterShortage
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneWaterShortage_ScriptStartFadeAndAdvanceStep::
Jump_00F_76E3:: ; address name
    ld a, $25
    ldh [hMapId], a
    xor a, a
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

; entry 0 of the `rst $00` table in SceneWaterShortage
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
SceneWaterShortage_StepPlayerLeftTowardWC928::
Jump_00F_7707:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_00F_7719
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

Jump_00F_7719::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 1F (SCRIPT_SCENE_MONSTER_INSPECTION): a cutscene step named after the scene its only script shows: 'Ah, three healthy monsters! Very well' ... 'Very good show! That was splendid'; reached through ScriptCommand1F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand1F)
; reads: wScriptStep
SceneMonsterInspection::
Func_00F_772E:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 0 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneMonsterInspection_ShowAndThatWasThe::
Jump_00F_7746:: ; address name
    ld a, $25
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0151 ; 'And that was the firebreather! Let's'
    call StartMessageHL_B0F
    ret

; entry 1 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
SceneMonsterInspection_RunMessageBoxFar_Bank0F::
Jump_00F_776B:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneMonsterInspection_ShowNextMonstersWillPerform::
Jump_00F_777E:: ; address name
    ld b, $B4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    ld hl, $0152 ; 'Next, monsters will perform some amazing,'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneMonsterInspection_StepPlayerUpTowardWC928::
Jump_00F_7795:: ; address name
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $26
    ldh [hMapId], a
    xor a, a
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

; entry 5 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hPlayerFacing, wScriptParam0
; points at: hPlayerStateFlags, wScriptStep
SceneMonsterInspection_StepPlayerUpTowardWC928_Case05::
Jump_00F_77C9:: ; address name
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptSubStep
; points at: wScriptStep
SceneMonsterInspection_StepScriptParam0Counter_Bank0F::
Jump_00F_77F1:: ; address name
    ld b, $B4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
SceneMonsterInspection_ToRunScriptSubStep::
Jump_00F_7806:: ; address name
    farcall RunScriptSubStep
    ret

; entry 8 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wScriptParam0, wStepPtrLo, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneMonsterInspection_StepPlayerDownTowardWC928::
Jump_00F_780D:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_781C
    inc a
    ld [wScriptParam0], a
    ld a, $6D
    call QueueSoundEffect

Jump_00F_781C::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $25
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
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
    xor a, a
    ld [wScriptParam0], a
    ret

; entry 9 of the `rst $00` table in SceneMonsterInspection
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, wScriptStartRequest
SceneMonsterInspection_PlayMapMusic::
Jump_00F_785B:: ; address name
    farcall PlayMapMusic
    ld a, [wStoryFlags + $61]
    or a, $01
    ld [wStoryFlags + $61], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 1D (SCRIPT_SCENE_LONG_FACES): a cutscene step named after the scene its only script shows: 'Slash Hey, why the long faces?'; reached through ScriptCommand1D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand1D)
; reads: wScriptStep
SceneLongFaces::
Func_00F_786F:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 12 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, wScriptStartRequest
SceneLongFaces_WriteStoryFlagsAndScriptStartRequest::
Jump_00F_788D:: ; address name
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldTransitionKind, wPartyCount
SceneLongFaces_RunMessageBoxFar_Bank0F_Case0B::
Jump_00F_789B:: ; address name
    xor a, a
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

; entry 10 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
SceneLongFaces_ShowSlashThatsSettledThen::
Jump_00F_78B7:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0093 ; 'Slash That's settled, then! We'll leave'
    call StartMessageHL_B0F
    ret

; entry 9 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wFollowerRecords, hPlayerFacing
; points at: hPlayerY, wScriptStep
SceneLongFaces_ScriptApplyStepDeltaAtDE::
Jump_00F_78CB:: ; address name
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

; entry 8 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
SceneLongFaces_ShowTaraThenItsYour::
Jump_00F_78E7:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7903
    ld hl, $009A ; 'Tara Then it's your job, 0!'
    call StartMessageHL_B0F
    ret

Jump_00F_7903::
    ld hl, $0092 ; 'Cobi Fine, 0. It's up to'
    call StartMessageHL_B0F
    ret

; entry 7 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, wScriptParam0
; points at: wScriptStep
SceneLongFaces_ShowSlashAndHeroHas::
Jump_00F_790A:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0091 ; 'Slash And 0 has potential, I'
    call StartMessageHL_B0F
    ret

; entry 5 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, hPlayerFacing, wFollowerRecords
; points at: wScriptStep
SceneLongFaces_ShowSlashDontWorryIm::
Jump_00F_7937:: ; address name
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld hl, $0090 ; 'Slash Don't worry! I'm riding along!'
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived, wSpriteSlots
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneLongFaces_StepObjectTowardCoord::
Jump_00F_7968:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_798D
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_798D::
    ld a, [wSpriteSlots + $C]
    cp a, $40
    jr z, Jump_00F_79AA
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_79AA::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $78
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneLongFaces_RunMessageBoxFar_Bank0F::
Jump_00F_79D1:: ; address name
    xor a, a
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

; entry 1 of the `rst $00` table in SceneLongFaces
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wMessageIndex, wMessageGroup
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneLongFaces_StartMessageHL_B0F::
Jump_00F_79EC:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_7A12
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

Jump_00F_7A12::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld h, $C0
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 1C (SCRIPT_SCENE_WARUBOU_WARNING): a cutscene step named after the scene its only script shows: 'Warubou Dangerous are other worlds!' ... 'Slash Hey, why the long faces?'; reached through ScriptCommand1C in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand1C)
; reads: wScriptStep
SceneWarubouWarning::
Func_00F_7A2D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWarubouWarning_RunMessageBoxFar_Bank0F
    dw SceneWarubouWarning_ShowTaraIfWeDont
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw SceneWarubouWarning_StartMessageHL_B0F
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; entry 3 of the `rst $00` table in SceneWarubouWarning
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneWarubouWarning_StartMessageHL_B0F::
Jump_00F_7A3B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_7A5A
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    call StartMessageHL_B0F
    ret

Jump_00F_7A5A::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    inc hl
    call StartMessageHL_B0F
    ret

; entry 1 of the `rst $00` table in SceneWarubouWarning
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords, hPlayerFacing
; points at: wScriptStep
SceneWarubouWarning_ShowTaraIfWeDont::
Jump_00F_7A70:: ; address name
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    inc a
    ld [wFollowerRecords + $1], a
    cp a, $80
    ret nz
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7A9B
    ld hl, $4094 ; 'Tara If we don't go find'
    call StartMessageHL_B0F
    ret

Jump_00F_7A9B::
    ld hl, $4089 ; 'Cobi If we don't find a'
    call StartMessageHL_B0F
    ret

; entry 0 of the `rst $00` table in SceneWarubouWarning
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneWarubouWarning_RunMessageBoxFar_Bank0F::
Jump_00F_7AA2:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $06
    ldh [hMapId], a
    xor a, a
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

; implements script command type 77 (SCRIPT_SCENE_LAND_HO): a cutscene step named after the scene its only script shows: 'Land ho! There's GreatLog!'; reached through ScriptCommand77 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand77)
; reads: wScriptStep
SceneLandHo::
Func_00F_7AC6:: ; address name
    ld a, [wScriptStep]
    rst $00
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

; entry 14 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; writes: wTalkEventIndex, wTalkEventGroup
SceneLandHo_DispatchTalkEvent::
Jump_00F_7AE8:: ; address name
    ld a, $0A
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    ret

; entry 13 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, hPlayerSpriteMode, wMessageIndex, ...
SceneLandHo_ScriptStartFadeAndAdvanceStep_Case0D::
Jump_00F_7AF9:: ; address name
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
    ld de, $001B
    call SetFlagBit
    ld a, $01
    ldh [hPlayerSpriteMode], a
    xor a, a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ret

; entry 11 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneLandHo_ShowThisIsATale::
Jump_00F_7B2A:: ; address name
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, $0014 ; 'This is a tale of children'
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hScrollY, hScrollX, wFieldActionStep
; writes: wScriptParam0, hScrollY
; points at: wFieldActionStep, wScriptStep
SceneLandHo_WriteScriptParam0AndScrollY::
Jump_00F_7B3B:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_00F_7B69
    inc d

Jump_00F_7B69::
    ld a, e
    sub a, $20
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, d
    cp a, $97
    jr nz, Jump_00F_7B7E
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $04
    ld d, a

Jump_00F_7B7E::
    ld a, [wFieldActionStep]
    srl a
    srl a
    srl a
    ld c, a
    ld a, $11
    sub a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call SceneLandHo_Case0A_WriteBGWriteDestLoAndBGWriteDestHiEtc
    ldh a, [hScrollY]
    sub a, $01
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp a, $90
    jr nc, Jump_00F_7BB4
    ret

Jump_00F_7BB4::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from SceneLandHo_Case0A (E-0047)
; 1 call site from 1 routine (e.g. SceneLandHo_WriteScriptParam0AndScrollY)
; reads: wIsCGB, hTemp0
; writes: wBGWriteDestLo, wBGWriteDestHi, wBGWriteVertical, wBGWriteCount, wAttrWriteDestLo, wAttrWriteDestHi, wAttrWriteVertical, wAttrWriteCount, ...
; points at: wBGWriteData, wAttrWriteData
SceneLandHo_Case0A_WriteBGWriteDestLoAndBGWriteDestHiEtc::
Func_00F_7BC3:: ; address name
    ld a, e
    ld [wBGWriteDestLo], a
    ld a, d
    ld [wBGWriteDestHi], a
    xor a, a
    ld [wBGWriteVertical], a
    ld a, $14
    ld [wBGWriteCount], a
    push hl
    push de
    ld b, $14
    ld de, wBGWriteData

Jump_00F_7BDB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7BDB
    pop de
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, e
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $00
    ld [wAttrWriteVertical], a
    ld a, $14
    ld [wAttrWriteCount], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, wAttrWriteData

Jump_00F_7C03::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7C03
    ret

; entry 9 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldActionStep
; points at: wScriptStep
SceneLandHo_SetFieldActionStep::
Jump_00F_7C19:: ; address name
    xor a, a
    ld [wFieldActionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hScrollY, hScrollYHi
; points at: hScrollY, wScriptStep
SceneLandHo_ComputeSpriteScrollOffsets::
Jump_00F_7C22:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $10
    jr z, Jump_00F_7C3F
    ld hl, hScrollY
    dec [hl]
    call ComputeSpriteScrollOffsets
    ret

Jump_00F_7C3F::
    xor a, a
    ld [wScriptParam0], a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    call ComputeSpriteScrollOffsets
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: wScriptParam0, wSpriteSlots
; points at: wScriptStep
SceneLandHo_SetBit2AtHL_B0F::
Jump_00F_7C4F:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wSpriteSlots + $C]
    dec a
    ld [wSpriteSlots + $C], a
    cp a, $50
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; points at: hMapScreenY, wScriptStep
SceneLandHo_StepScriptParam0Counter_Bank0F::
Jump_00F_7C72:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, hMapScreenY
    dec [hl]
    call LoadMapScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneLandHo
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneLandHo_ScriptStartFadeAndAdvanceStep::
Jump_00F_7C84:: ; address name
    ld a, $1C
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; implements script command type 76; reached through ScriptCommand76 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand76)
; reads: wScriptStep
ScriptCommand76_Run::
Func_00F_7CA5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand76_Run_ShowTheIslandIsSinking
    dw ScriptCommand76_Run_ShowTheIslandIsSinking
    dw SceneHomecoming_RunMessageBoxFar_Bank0F
    dw ScriptCommand76_Run_SetFlagBit

; entry 3 of the `rst $00` table in ScriptCommand76_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerRecords, wObject3, wScriptStartRequest
ScriptCommand76_Run_SetFlagBit::
Jump_00F_7CB1:: ; address name
    ld a, $76
    call QueueSoundEffect
    ld de, $001B
    call SetFlagBit
    ld a, $03
    ld [wFollowerRecords], a
    ld a, $60
    ld [wFollowerRecords + $1], a
    ld a, $50
    ld [wFollowerRecords + $2], a
    ld a, $E0
    ld [wObject3 + $C], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand76_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand76_Run_ShowTheIslandIsSinking::
Jump_00F_7CD6:: ; address name
    ld de, wObject3 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0001
    call TestFlagBit
    jr nc, Jump_00F_7CF4
    ld hl, $0076 ; 'The island is sinking? Hahah, no'
    call StartMessageHL_B0F
    ret

Jump_00F_7CF4::
    ld hl, $0078 ; 'It's pointless if you're dead. I'm'
    call StartMessageHL_B0F
    ret

; implements script command type 75 (SCRIPT_SCENE_AT_SEA): a cutscene step named after the scene its only script shows: after 'In the middle of the sea'; reached through ScriptCommand75 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand75)
; reads: wScriptStep
SceneAtSea::
Func_00F_7CFB:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneAtSea_ScriptStartFadeAndAdvanceStep
    dw SceneAtSea_StepScriptParam0Counter_Bank0F
    dw SceneAtSea_WriteObject3
    dw SceneAtSea_ScriptApplyStepDeltaAtDE

; entry 3 of the `rst $00` table in SceneAtSea
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneAtSea_ScriptApplyStepDeltaAtDE::
Jump_00F_7D07:: ; address name
    ld hl, wObject3 + $B
    dec [hl]
    ld hl, wObject3 + $C
    inc [hl]
    ld de, wObject3 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneAtSea
; no direct call (reached through a table, a jump or a vector)
; reads: wObject3
; writes: wObject3
; points at: wScriptStep
SceneAtSea_WriteObject3::
Jump_00F_7D1C:: ; address name
    ld a, [wObject3 + $C]
    inc a
    inc a
    ld [wObject3 + $C], a
    cp a, $30
    ret nz
    ld a, $03
    ld [wObject3 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneAtSea
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneAtSea_StepScriptParam0Counter_Bank0F::
Jump_00F_7D31:: ; address name
    ld b, $5A
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneAtSea
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, hPlayerSpriteMode
SceneAtSea_ScriptStartFadeAndAdvanceStep::
Jump_00F_7D3C:: ; address name
    ld a, $1D
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

; implements script command type 6B (SCRIPT_SCENE_VAULT_SETTLED): a cutscene step named after the scene its only script shows: 'You've come at the right...' ... 'Good, that's settled then. The Vault...'; reached through ScriptCommand6B in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand6B)
; reads: wScriptStep
SceneVaultSettled::
Func_00F_7D62:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneVaultSettled_ScriptApplyStepDeltaAtDE
    dw SceneVaultSettled_ShowTaraWellBeOK
    dw PersonalityMessage_RunMessageBoxFar_Bank0F

; entry 1 of the `rst $00` table in SceneVaultSettled
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneVaultSettled_ShowTaraWellBeOK::
Jump_00F_7D6C:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7D7F
    ld hl, $0021 ; 'Tara We'll be OK! I'm going'
    call StartMessageHL_B0F
    ret

Jump_00F_7D7F::
    ld hl, $001F ; 'Cobi Sure, Mama! We'll be fine.'
    call StartMessageHL_B0F
    ret

; entry 0 of the `rst $00` table in SceneVaultSettled
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing
; writes: wFollowerRecords
; points at: wScriptStep
SceneVaultSettled_ScriptApplyStepDeltaAtDE::
Jump_00F_7D86:: ; address name
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 6A (SCRIPT_SCENE_HORSING_AROUND): a cutscene step named after the scene its only script shows: before 'Listen you two! Quit your horsing...'; reached through ScriptCommand6A in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand6A)
; reads: wScriptStep
SceneHorsingAround::
Func_00F_7D97:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneHorsingAround_WriteMessageIndexAndMessageGroup
    dw SceneHorsingAround_StepObjectTowardCoord
    dw SceneHorsingAround_WriteMessageIndex
    dw SceneHorsingAround_ScriptApplyStepDeltaAtDE

; entry 3 of the `rst $00` table in SceneHorsingAround
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
; points at: hPlayerStateFlags
SceneHorsingAround_ScriptApplyStepDeltaAtDE::
Jump_00F_7DA3:: ; address name
    call SceneHorsingAround_StepPlayerLeftTowardWC928
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneHorsingAround
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex
; writes: wMessageIndex
; points at: wScriptStep
SceneHorsingAround_WriteMessageIndex::
Jump_00F_7DB9:: ; address name
    call SceneHorsingAround_StepPlayerLeftTowardWC928
    ld a, [wMessageIndex]
    inc a
    ld [wMessageIndex], a
    cp a, $20
    ret nz
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneHorsingAround
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrHi, wStepPtrLo, wSpriteSlots
; points at: wScriptStep
SceneHorsingAround_StepObjectTowardCoord::
Jump_00F_7DCF:: ; address name
    call SceneHorsingAround_StepPlayerLeftTowardWC928
    ld a, $00
    ld [wStepTarget], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneHorsingAround
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneHorsingAround_WriteMessageIndexAndMessageGroup::
Jump_00F_7DF6:: ; address name
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
    cp a, $01
    ret nz
    ld a, l
    cp a, $40
    ret nz
    xor a, a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from routines of SceneHorsingAround (E-0098)
; 4 call sites from 4 routines (e.g. SceneHorsingAround_ScriptApplyStepDeltaAtDE, SceneHorsingAround_WriteMessageIndex, SceneHorsingAround_StepObjectTowardCoord, SceneHorsingAround_WriteMessageIndexAndMessageGroup)
; reads: wScriptParam1, wStepArrived
; writes: wStepPtrLo, wScriptParam1
SceneHorsingAround_StepPlayerLeftTowardWC928::
Func_00F_7E1E:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_7E37
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    farcall StepPlayerLeftTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E37::
    dec a
    jr nz, Jump_00F_7E4D
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    farcall StepPlayerDownTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E4D::
    dec a
    jr nz, Jump_00F_7E63
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    farcall StepPlayerRightTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E63::
    dec a
    jr nz, Jump_00F_7E79
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    farcall StepPlayerUpTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E79::
    dec a
    jr nz, Jump_00F_7E8F
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    farcall StepPlayerLeftTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E8F::
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    farcall StepPlayerUpTowardWC928

Jump_00F_7EA0::
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, [wScriptParam1]
    inc a
    cp a, $06
    jr nz, Jump_00F_7EAE
    xor a, a

Jump_00F_7EAE::
    ld [wScriptParam1], a
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 34 call sites from 34 routines (e.g. SceneLandHo_ShowThisIsATale, SceneLandHo_StepScriptParam0Counter_Bank0F, SceneAtSea_StepScriptParam0Counter_Bank0F, ScriptStepDeltaThenMessage, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepScriptParam0Counter_Bank0F::
Func_00F_7EB2:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    jr z, Jump_00F_7EBE
    sub a, a
    ret

Jump_00F_7EBE::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 5 call sites from 5 routines (e.g. SceneHomecoming_ScriptApplyStepDeltaAtDE_Case26, SceneCheerYuna_SetBit2AtHL_B0F_Case03, SceneCheerYuna_SetBit2AtHL_B0F, SceneReportToKing_SetBit1AtHL_Bank0FAndStep, ...)
SetBit1AtHL_Bank0F::
Func_00F_7EC4:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 4 call sites from 4 routines (e.g. SceneCheerYuna_StepScriptParam0Counter_Bank0F_Case04, SceneCheerYuna_StepScriptParam0Counter_Bank0F, SceneReportToKing_AddStepDeltaToPointedByte, SceneKamehaFlees_UpdateFollowersOnStep_Bank0F_Case06)
ClearBit1AtHL_Bank0F::
Func_00F_7EC9:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 28 call sites from 16 routines (e.g. ScenePendantSeller_SetBit2AtHL_B0F, SceneLandHo_SetBit2AtHL_B0F, SceneCheerYuna_StepObjectTowardCoord_Case0A, SceneCheerYuna_SetBit2AtHL_B0F_Case03, ...)
SetBit2AtHL_B0F::
Func_00F_7ECE:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 24 call sites from 15 routines (e.g. SceneHorsingAround_ScriptApplyStepDeltaAtDE, SceneHomecoming_ClearBit2AtHL_Bank0F, SceneShield2_ShowWarubouWaheyYouDid, SceneCheerYuna_ShowEnoughEnoughOfThat, ...)
ClearBit2AtHL_Bank0F::
Func_00F_7ED3:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same 17 bytes appear in 3 banks)
; 15 call sites from 8 routines (e.g. ScenePendantSeller_UpdateFollowersOnStep_Bank0F_Case03, ScenePendantSeller_UpdateFollowersOnStep_Bank0F, SceneCheerYuna_WritePlayerFacing, SceneWallExit_SetBit2AtHL_B0F, ...)
UpdateFollowersOnStep_Bank0F::
Func_00F_7ED8:: ; address name
    and a, $0F
    jr nz, Jump_00F_7EE2
    farcall SetFollowerTargetsFromLeader

Jump_00F_7EE2::
    farcall StepFollowersTowardTargets
    ret

; DE = address of a byte: adds the step delta for wScriptParam0 (AddStepDeltaToPointedByte), then wScriptParam0 += 2; when it reaches $20 it is reset to 0 and carry is set, otherwise A = 0 and carry is clear (16 calls per move) (E-0062)
; 38 call sites from 38 routines (e.g. ScriptCommand76_Run_ShowTheIslandIsSinking, SceneAtSea_ScriptApplyStepDeltaAtDE, SceneVaultSettled_ScriptApplyStepDeltaAtDE, SceneHorsingAround_ScriptApplyStepDeltaAtDE, ...)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
ScriptApplyStepDeltaAtDE::
Func_00F_7EE9:: ; address name
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
    jr z, Jump_00F_7F05
    sub a, a
    ret

Jump_00F_7F05::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wC928/wC929) and counts wC921 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps, wScriptStep += 1 (E-0117)
; 4 call sites from 4 routines (e.g. SceneDarckDefeated_ScriptStepDeltaThenNextStep, SceneCheerYuna_ToScriptStepDeltaThenNextStep, SceneReportToKing_ScriptStepDeltaThenNextStep, SceneWhoAreYou_ToScriptStepDeltaThenNextStep)
; writes: wStepPtrLo, wStepPtrHi
; points at: wScriptStep
ScriptStepDeltaThenNextStep::
Func_00F_7F0B:: ; address name
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

; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wC928/wC929) and counts wC921 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps, StartMessageHL_B0F with the caller's HL and wScriptStep += 1 (E-0117)
; 7 call sites from 7 routines (e.g. SceneShieldGuardian_ScriptStepDeltaThenMessage, SceneThreeItems_ToScriptStepDeltaThenMessage_Case2A, SceneThreeItems_ToScriptStepDeltaThenMessage_Case18, SceneThreeItems_ToScriptStepDeltaThenMessage, ...)
; writes: wStepPtrLo, wStepPtrHi
; points at: wScriptStep
ScriptStepDeltaThenMessage::
Func_00F_7F24:: ; address name
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

; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wC928/wC929) and counts wC921 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps, wScriptStartRequest = $80 (E-0117)
; no direct call (reached through a table, a jump or a vector)
; writes: wStepPtrLo, wStepPtrHi, wScriptStartRequest
ScriptStepDeltaThenRequestFetch:: ; heuristic: follows a terminator; C0
Func_00F_7F42:: ; address name
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

; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
RotateDirectionAtDEEvery32_Bank0F:: ; heuristic: follows a terminator; C0
Func_00F_7F5C:: ; address name
    ld a, [wScriptParam0]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 127 call sites from 108 routines (e.g. SceneLandHo_ShowThisIsATale, ScriptCommand76_Run_ShowTheIslandIsSinking, SceneVaultSettled_ShowTaraWellBeOK, SceneShieldGuardian_ShowHelenIPutYou, ...)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B0F::
Func_00F_7F68:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; wC928 = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
; 15 call sites from 15 routines (e.g. SceneShieldGuardian_RunMessageBoxFar_Bank0F, SceneThreeItems_RunMessageBoxFar_Bank0F, SceneShield2_ShowWaheyHeroCanYou, SceneShield2_ShowAVoiceEchoedFrom, ...)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxFar_Bank0F::
Func_00F_7F75:: ; address name
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, Jump_00F_7F87
    sub a, a
    ret

Jump_00F_7F87::
    scf
    ret

; entry 3 of the `rst $00` table in SceneHomecoming
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneHomecoming_RunMessageBoxFar_Bank0F::
Jump_00F_7F89:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PersonalityMessage
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
PersonalityMessage_RunMessageBoxFar_Bank0F::
Jump_00F_7F93:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $62, $00
