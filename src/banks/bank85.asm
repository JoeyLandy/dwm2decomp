SECTION "Bank 85", ROMX[$4000], BANK[$85]
    db $85

; implements script command type CF (SCRIPT_SCENE_KEY_SHOP): a cutscene step named after the scene its only script shows: 'How good of you to overcome' ... 'Welcome to my Key Shop!'; reached through ScriptCommandCF in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandCF)
; reads: wScriptStep
SceneKeyShop::
Func_085_4001:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKeyShop_Case00
    dw SceneKeyShop_Case01

; entry 1 of the `rst $00` table in SceneKeyShop
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, wScriptStartRequest
SceneKeyShop_Case01::
Jump_085_4009:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in SceneKeyShop
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wScriptStartRequest
; points at: wScriptStep
SceneKeyShop_Case00::
Jump_085_402D:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wSpriteSlots + $B]
    cp a, $50
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type CE (SCRIPT_HIDE_SPRITES): wSpriteSlotCount = 0; reached through ScriptCommandCE in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandCE)
; writes: wSpriteSlotCount, wScriptStartRequest
HideSprites::
Func_085_403D:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2A (SCRIPT_SCENE_WATCH_OUT): a cutscene step named after the scene its only script shows: 'You can keep trying, but you're...' ... 'Zzz Zzz Huh! Watch out!'; reached through ScriptCommand2A in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand2A)
; reads: wScriptStep
SceneWatchOut::
Func_085_4047:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWatchOut_ShowHmYouAreQuite
    dw SceneWatchOut_Case01
    dw SceneWatchOut_ShowTheFarmHasNo
    dw SceneWatchOut_Case03
    dw SceneWatchOut_Case01
    dw SceneWatchOut_Msg4D50_PickTheMonsterTo
    dw SceneWatchOut_Case01
    dw SceneWatchOut_CopyGlyphTilesToVRAMAndStep
    dw SceneWatchOut_Case08_Sub01_Case08
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_Case0A
    dw SceneWatchOut_Case0A
    dw SceneWatchOut_Case0A
    dw SceneWatchOut_Case0D
    dw SceneWatchOut_Case0E
    dw SceneWatchOut_Case0F
    dw SceneWatchOut_ShowNHeadedOffTo
    dw SceneWatchOut_Case11
    dw SceneWatchOut_Case12

; entry 16 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
; writes: hTemp1, hTemp2, hTemp3
; points at: wSpriteSlotCount, wScriptStep
SceneWatchOut_ShowNHeadedOffTo::
Jump_085_4071:: ; address name
    ld a, $05
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, $4D52 ; 'N headed off to the farm.'
    call StartMessageHL_B85
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 15 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wScriptStartRequest
; points at: wSpriteSlotCount
SceneWatchOut_Case0F::
Jump_085_4093:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank85
    ret nc
    farcall RestoreScreenBufferFromBGMap1
    ld hl, wSpriteSlotCount
    dec [hl]
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall PlayMapMusic
    ld de, $0078
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScriptMsgSelect, wSpriteSlots
; writes: hTemp1, hTemp2, hTemp3, wOBJPaletteUploadRequest
; points at: wPartyCount, wFollowerRecords, wPartyList, wSpriteSlotCount, wScriptStep
SceneWatchOut_Case0E::
Jump_085_40C3:: ; address name
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
    add a, a
    add a, a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wSpriteSlots + $7]
    ld [hl+], a
    ld a, [wSpriteSlots + $B]
    ld [hl+], a
    ld a, [wSpriteSlots + $C]
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, $4D51 ; 'N joined the party.'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptMsgSelect, wArg5, wSpriteSlots
; writes: wScriptStep, hTemp1, hTemp2, hTemp3, wOBJPaletteUploadRequest
; points at: wScriptMsgSelect, wPartyCount, wScriptStep, wFollowerRecords, wPartyList, wSpriteSlotCount
SceneWatchOut_Case0D::
Jump_085_412F:: ; address name
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld a, [wScriptMsgSelect]
    cp a, $03
    jr nz, Jump_085_4145
    ld a, $10
    ld [wScriptStep], a
    ret

Jump_085_4145::
    push af
    call CopyRecordFields5DTo5BAnd61To5FAndMark
    pop af
    ld hl, wScriptMsgSelect
    inc [hl]
    ld hl, wPartyCount
    dec [hl]
    ld hl, wScriptStep
    inc [hl]
    jp SceneWatchOut_Case0E

; entry 7 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptSubStep, wScriptMsgSelect
; points at: wScriptStep
SceneWatchOut_CopyGlyphTilesToVRAMAndStep::
Jump_085_4159:: ; address name
    ld de, vTiles1 + $6E0
    call CopyGlyphTilesToVRAM
    xor a, a
    ld [wScriptSubStep], a
    ld [wScriptMsgSelect], a
    call ShowBoxFromTable4583
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wArg5, wPartyCount
; writes: wScriptMsgSelect, wScriptStep
; points at: wScriptStep
SceneWatchOut_ShowTheFarmHasNo::
Jump_085_4174:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_085_41C1
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_085_4192
    ld hl, vTiles1 + $557
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4192::
    ld a, [wPartyCount]
    cp a, $03
    jr z, Jump_085_41B2
    ld hl, vTiles0 + $1B8
    call StartMessageHL_B85
    farcall SaveScreenBufferToBGMap1
    ld a, [wPartyCount]
    inc a
    ld [wScriptMsgSelect], a
    ld a, $11
    ld [wScriptStep], a
    ret

Jump_085_41B2::
    ld hl, vTiles1 + $511
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_41C1::
    ld hl, vTiles1 + $512
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; writes: wNameGlyphBuf, wTextBuf1
; points at: wScriptStep
SceneWatchOut_ShowHmYouAreQuite::
Jump_085_41CC:: ; address name
    ld a, $1C
    ld [wNameGlyphBuf], a
    ld [wTextBuf1 + $7], a
    ld a, $34
    ld [wNameGlyphBuf + $1], a
    ld [wTextBuf1 + $8], a
    ld a, $38
    ld [wNameGlyphBuf + $2], a
    ld [wTextBuf1 + $9], a
    ld a, $2C
    ld [wNameGlyphBuf + $3], a
    ld [wTextBuf1 + $A], a
    ld a, $3D
    ld [wNameGlyphBuf + $4], a
    ld [wTextBuf1 + $B], a
    ld a, $F0
    ld [wNameGlyphBuf + $5], a
    ld [wTextBuf1 + $C], a
    ld hl, $4D0F ; 'Hm, you are quite strong I'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4D (SCRIPT_SCENE_WATER_REWARD): a cutscene step named after the scene its only script shows: 'King This should solve the water...' (creates a monster record); reached through ScriptCommand4D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand4D)
; reads: wScriptStep
SceneWaterReward::
Func_085_4207:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWaterReward_ShowCoohIHeardFrom
    dw SceneWatchOut_Case01
    dw SceneWaterReward_ShowWaitTheFarmIs
    dw SceneWatchOut_Case03
    dw SceneWatchOut_Case01
    dw SceneWatchOut_Msg4D50_PickTheMonsterTo
    dw SceneWatchOut_Case01
    dw SceneWaterReward_CopyGlyphTilesToVRAMAndStep
    dw SceneWatchOut_Case08_Sub01_Case08
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_Case0A
    dw SceneWatchOut_Case0A
    dw SceneWatchOut_Case0A
    dw SceneWaterReward_Case0D
    dw SceneWaterReward_Case0E
    dw SceneWaterReward_Case0F
    dw SceneWaterReward_ShowNHeadedOffTo
    dw SceneWatchOut_Case11
    dw SceneWatchOut_Case12

; entry 18 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStep
SceneWatchOut_Case12::
Jump_085_4231:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank85
    ret nc
    ld a, $0E
    ld [wScriptStep], a
    ret

; entry 17 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWatchOut_Case11::
Jump_085_423C:: ; address name
    ld hl, wObject1 + $7
    call StepObjectCoordByDirection16Frames
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
; writes: hTemp1, hTemp2, hTemp3
; points at: wSpriteSlotCount, wScriptStep
SceneWaterReward_ShowNHeadedOffTo::
Jump_085_4249:: ; address name
    ld a, $00
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, $4D52 ; 'N headed off to the farm.'
    call StartMessageHL_B85
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 15 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; writes: hSpriteWindowClipMode, wScriptStartRequest
; points at: wSpriteSlotCount
SceneWaterReward_Case0F::
Jump_085_426B:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank85
    ret nc
    farcall RestoreScreenBufferFromBGMap1
    ld hl, wSpriteSlotCount
    dec [hl]
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall PlayMapMusic
    ld de, $005C
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScriptMsgSelect, wObject1
; writes: hTemp1, hTemp2, hTemp3, wOBJPaletteUploadRequest
; points at: wPartyCount, wFollowerRecords, wPartyList, wSpriteSlotCount, wScriptStep
SceneWaterReward_Case0E::
Jump_085_429B:: ; address name
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
    add a, a
    add a, a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wObject1 + $7]
    ld [hl+], a
    ld a, [wObject1 + $B]
    ld [hl+], a
    ld a, [wObject1 + $C]
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, $4D51 ; 'N joined the party.'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptMsgSelect, wArg5, wObject1
; writes: wScriptStep, hTemp1, hTemp2, hTemp3, wOBJPaletteUploadRequest
; points at: wScriptMsgSelect, wPartyCount, wScriptStep, wFollowerRecords, wPartyList, wSpriteSlotCount
SceneWaterReward_Case0D::
Jump_085_4307:: ; address name
    ld hl, wObject1 + $7
    call StepObjectCoordByDirection16Frames
    or a, a
    ret z
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld a, [wScriptMsgSelect]
    cp a, $03
    jr nz, Jump_085_4325
    ld a, $10
    ld [wScriptStep], a
    ret

Jump_085_4325::
    push af
    call CopyRecordFields5DTo5BAnd61To5FAndMark
    pop af
    ld hl, wScriptMsgSelect
    inc [hl]
    ld hl, wPartyCount
    dec [hl]
    ld hl, wScriptStep
    inc [hl]
    jp SceneWaterReward_Case0E

; moves the object at HL one unit in direction [HL] (bytes 4/5); A = 1 after 16 steps, else 0 (E-0125)
; 2 call sites from 2 routines (e.g. SceneWaterReward_Case0D, SceneWatchOut_Case11)
; reads: wScriptParam0
; writes: wScriptParam0
StepObjectCoordByDirection16Frames::
Func_085_4339:: ; address name
    ld a, [hl]
    or a, a
    jr nz, Jump_085_4347
    ld a, $05
    add_a_to_hl
    inc [hl]
    jr Jump_085_4369

Jump_085_4347::
    dec a
    jr nz, Jump_085_4354
    ld a, $04
    add_a_to_hl
    inc [hl]
    jr Jump_085_4369

Jump_085_4354::
    dec a
    jr nz, Jump_085_4361
    ld a, $05
    add_a_to_hl
    dec [hl]
    jr Jump_085_4369

Jump_085_4361::
    ld a, $04
    add_a_to_hl
    dec [hl]

Jump_085_4369::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    jr z, Jump_085_4376
    xor a, a
    ret

Jump_085_4376::
    xor a, a
    ld [wScriptParam0], a
    ld a, $01
    ret

; entry 10 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptMsgSelect
; points at: wScriptStep
SceneWatchOut_Case0A::
Jump_085_437D:: ; address name
    ld a, [wScriptMsgSelect]
    cp a, $03
    jr nz, Jump_085_4389
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4389::
    farcall ScriptStepMoveFollowersToLeader
    ret

; entry 9 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStep
SceneWatchOut_ShowLetMeJoinYour::
Jump_085_4390:: ; address name
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld hl, wKeyWorldBossMonsters + $6
    call StartMessageHL_B85
    farcall ClearBit1OfPlayerAndObjectFlags
    ld a, $01
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
SceneWatchOut_Case08_Sub01_Case08::
Jump_085_43AB:: ; address name
    call SceneWatchOut_Case08_Sub01
    ret

; entry 7 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptSubStep, wScriptMsgSelect
; points at: wScriptStep
SceneWaterReward_CopyGlyphTilesToVRAMAndStep::
Jump_085_43AF:: ; address name
    ld de, vTiles1 + $6E0
    call CopyGlyphTilesToVRAM
    xor a, a
    ld [wScriptSubStep], a
    ld [wScriptMsgSelect], a
    call ShowBoxFromTable4583
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWatchOut_Msg4D50_PickTheMonsterTo::
Jump_085_43CA:: ; address name
    ld hl, $4D50 ; 'Pick the monster to go to'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wArg5, wPartyCount
; writes: wScriptMsgSelect, wScriptStep
; points at: wScriptStep
SceneWaterReward_ShowWaitTheFarmIs::
Jump_085_43D5:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_085_4422
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_085_43F3
    ld hl, vTiles1 + $555
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_43F3::
    ld a, [wPartyCount]
    cp a, $03
    jr z, Jump_085_4413
    ld hl, vTiles0 + $1B8
    call StartMessageHL_B85
    farcall SaveScreenBufferToBGMap1
    ld a, [wPartyCount]
    inc a
    ld [wScriptMsgSelect], a
    ld a, $11
    ld [wScriptStep], a
    ret

Jump_085_4413::
    ld hl, vTiles0 + $1B9
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4422::
    ld hl, vTiles0 + $1BA
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneWaterReward
; no direct call (reached through a table, a jump or a vector)
; writes: wNameGlyphBuf, wTextBuf1
; points at: wScriptStep
SceneWaterReward_ShowCoohIHeardFrom::
Jump_085_442D:: ; address name
    ld a, $0B
    ld [wNameGlyphBuf], a
    ld [wTextBuf1 + $7], a
    ld a, $2C
    ld [wNameGlyphBuf + $1], a
    ld [wTextBuf1 + $8], a
    ld a, $2C
    ld [wNameGlyphBuf + $2], a
    ld [wTextBuf1 + $9], a
    ld a, $31
    ld [wNameGlyphBuf + $3], a
    ld [wTextBuf1 + $A], a
    ld a, $32
    ld [wNameGlyphBuf + $4], a
    ld [wTextBuf1 + $B], a
    ld a, $90
    ld [wNameGlyphBuf + $5], a
    ld a, $F0
    ld [wNameGlyphBuf + $6], a
    ld [wTextBuf1 + $C], a
    ld hl, $41B7 ; 'Cooh, I heard from others held'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from SceneWatchOut_Case08 (E-0047)
; 1 call site from 1 routine (e.g. SceneWatchOut_Case08_Sub01_Case08)
; reads: wJoypadPressed, wFrameCounterLo
; points at: wScriptStep, wScriptMsgSelect
SceneWatchOut_Case08_Sub01::
Func_085_446D:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_085_4479
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4479::
    bit 0, a
    jr z, Jump_085_4493
    call SceneWatchOut_Case08_Sub01_Sub01
    ld a, $BC
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4493::
    bit 6, a
    jr z, Jump_085_44AA
    call SceneWatchOut_Case08_Sub01_Sub01
    ld a, $C3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    dec [hl]
    ld a, $69
    call QueueSoundEffect
    jr Jump_085_44BF

Jump_085_44AA::
    bit 7, a
    jr z, Jump_085_44BF
    call SceneWatchOut_Case08_Sub01_Sub01
    ld a, $C3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    inc [hl]
    ld a, $69
    call QueueSoundEffect

Jump_085_44BF::
    call SceneWatchOut_Case08_Sub01_Sub01
    ld c, $BB
    ld a, [wFrameCounterLo]
    bit 3, a
    jr z, Jump_085_44CD
    ld c, $C3

Jump_085_44CD::
    ld a, c
    call WriteVRAMByte
    ret

; only called from SceneWatchOut_Case08_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. SceneWatchOut_Case08_Sub01)
; reads: wScriptMsgSelect, hScrollY, hScrollX
; writes: wScriptMsgSelect
SceneWatchOut_Case08_Sub01_Sub01::
Func_085_44D2:: ; address name
    ld a, [wScriptMsgSelect]
    and a, $03
    ld [wScriptMsgSelect], a
    swap a
    add a, $08
    ld c, a
    ldh a, [hScrollY]
    add a, c
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [hScrollX]
    add a, $08
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; saves the screen buffer to vBGMap1, copies the 8 x 9 box $4583 to wScreenTileBuffer (clearing CGB attributes), draws it and plays sound $6C (E-0125)
; 2 call sites from 2 routines (e.g. SceneWaterReward_CopyGlyphTilesToVRAMAndStep, SceneWatchOut_CopyGlyphTilesToVRAMAndStep)
; reads: wIsCGB
; writes: rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
ShowBoxFromTable4583::
Func_085_4505:: ; address name
    farcall SaveScreenBufferToBGMap1
    ld hl, wScreenTileBuffer
    ld de, TileRect_85_4583
    ld b, $09

Jump_085_4513::
    push hl
    ld c, $08

Jump_085_4516::
    ld a, [de]
    inc de
    ld [hl+], a
    dec c
    jr nz, Jump_085_4516
    pop hl
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, Jump_085_4513
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_085_454C
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    ld b, $09

Jump_085_4536::
    push hl
    ld c, $08

Jump_085_4539::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_085_4539
    pop hl
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, Jump_085_4536
    xor a, a
    ldh [rSVBK], a

Jump_085_454C::
    call DrawScreenBufferAtScrollOrigin
    ld a, $6C
    call QueueSoundEffect
    ret

; draws the screen buffer at the BG map address of the scroll position (Func_000_1EA5) (E-0125)
; 4 call sites from 4 routines (e.g. SceneWaterReward_Case0D, ShowBoxFromTable4583, SceneWatchOut_Case0D, SceneWatchOut_ShowLetMeJoinYour)
; reads: hScrollY, hScrollX
DrawScreenBufferAtScrollOrigin::
Func_085_4555:: ; address name
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
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_085_457D
    inc d

Jump_085_457D::
    ld l, e
    ld h, d
    call DrawScreenBufferToBGMapWithAttrs
    ret

; E-0239 (C1: no reference found; the bytes form an 8 x 9 window frame ($B0 $B1.. $B2 top, $B6/$B7 sides with $E1-$E3 in the left column of rows 1, 3 and 5, $B3 $B4.. $B5 bottom), after the ret of the routine that ends at $4582).
; record: 8 x 9 tiles, one row per line
TileRect_85_4583::
Data_085_4583:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $E1, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $E2, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $E3, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $EE, $EF, $F0, $F1, $F2, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; for record wC6FE[A]: field $5B = word field $5D, field $5F = word field $61, field $55 = 0, field 0 = 1 (E-0121)
; 2 call sites from 2 routines (e.g. SceneWaterReward_Case0D, SceneWatchOut_Case0D)
; reads: hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList
CopyRecordFields5DTo5BAnd61To5FAndMark::
Func_085_45CB:: ; address name
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [hl]
    push af
    ld c, $5D
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, $5B
    call SRAMRecordAddress
    ldh a, [hTemp0]
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl], a
    pop af
    push af
    ld c, $61
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, $5F
    call SRAMRecordAddress
    ldh a, [hTemp0]
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl], a
    pop af
    push af
    ld c, $55
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    pop af
    ld c, $00
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ret

; implements script command type 1B (SCRIPT_SCENE_WARUBOU_LEAVES): a cutscene step named after the scene its only script shows: 'C'mon, Warubou!' ... 'Have you heard about Magic Keys?'; reached through ScriptCommand1B in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand1B)
; reads: wScriptStep
SceneWarubouLeaves::
Func_085_4617:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWarubouLeaves_Case00
    dw SceneWarubouLeaves_Case01
    dw SceneWarubouLeaves_Case02
    dw SceneWarubouLeaves_Case03

; entry 3 of the `rst $00` table in SceneWarubouLeaves
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptStartRequest
SceneWarubouLeaves_Case03::
Jump_085_4623:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneWarubouLeaves
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneWarubouLeaves_Case02::
Jump_085_4658:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_085_46DA

; entry 1 of the `rst $00` table in SceneWarubouLeaves
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneWarubouLeaves_Case01::
Jump_085_4684:: ; address name
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
    jr Jump_085_46DA

; entry 0 of the `rst $00` table in SceneWarubouLeaves
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneWarubouLeaves_Case00::
Jump_085_46B0:: ; address name
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

Jump_085_46DA::
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7A (SCRIPT_SCENE_KAMEHA_MISSING): a cutscene step named after the scene its only script shows: before 'Prince Kameha has been missing from...'; reached through ScriptCommand7A in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand7A)
; reads: wScriptStep, wScriptParam0
; writes: hTemp0, wObject5, wScriptParam0, wScriptStartRequest
; points at: wScriptStep
SceneKamehaMissing::
Func_085_46E4:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_085_4703
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $10
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4703::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $28
    ret nz
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 78 (SCRIPT_SAVE_SCREEN): saves the screen buffer to BG map 1 (SaveScreenBufferToBGMap1); reached through ScriptCommand78 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand78)
; reads: wScriptStep
SaveScreen::
Func_085_4717:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SaveScreen_Case00
    dw SaveScreen_SetScriptStartRequestTo80

; entry 1 of the `rst $00` table in SaveScreen
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SaveScreen_SetScriptStartRequestTo80::
Jump_085_471F:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in SaveScreen
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldReturnPhase, wGameMode, wModeState, wGameMode2State, wTemp0, wTemp1, wJoypadHeld, wJoypadPressed, ...
; points at: wScriptStep
SaveScreen_Case00::
Jump_085_4725:: ; address name
    farcall SaveScreenBufferToBGMap1
    ld a, $01
    ld [wFieldReturnPhase], a
    ld a, $02
    ld [wGameMode], a
    ld a, $0C
    ld [wModeState], a
    xor a, a
    ld [wGameMode2State], a
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    xor a, a
    ld [wScriptRunning], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7D (SCRIPT_SCENE_THIS_WAY): a cutscene step named after the scene its only script shows: 'This way Here Here' ... 'I heard from Lord Darck, but...'; reached through ScriptCommand7D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand7D)
; reads: hMapScreenY, hMapScreenX
; writes: wScriptStartRequest
SceneThisWay::
Func_085_4755:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hMapScreenY]
    cp a, $02
    ret z
    ld de, $4783
    or a, a
    jr z, Jump_085_4768
    ld de, $478F

Jump_085_4768::
    ldh a, [hMapScreenX]
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_085_4771
    inc d

Jump_085_4771::
    ld hl, wSpriteSlots + $7

Jump_085_4774::
    ld a, [de]
    cp a, $FF
    ret z
    ld [hl], a
    ld a, $10
    add_a_to_hl
    inc de
    jr Jump_085_4774
    db $00, $00, $01, $FF, $00, $FF, $FF, $FF, $03, $01, $00, $FF, $01, $03, $02, $FF
    db $01, $FF, $FF, $FF, $02, $02, $01, $FF

; implements script command type 7F (SCRIPT_SCENE_CHEST_SERVANT): a cutscene step named after the scene its only script shows: '0 checked the treasure chest.' ... 'How may we serve your mortal...'; reached through ScriptCommand7F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand7F)
; reads: wScriptStep
SceneChestServant::
Func_085_479B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneChestServant_QueueSoundEffectAndStep
    dw SceneChestServant_Case01
    dw SceneChestServant_Case01
    dw SceneChestServant_Case01
    dw SceneChestServant_Case04
    dw SceneChestServant_SetScriptStartRequestTo80

; entry 5 of the `rst $00` table in SceneChestServant
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneChestServant_SetScriptStartRequestTo80::
Jump_085_47AB:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in SceneChestServant
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerX, wFollowerRecords, hFieldDrawFlags, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, ...
SceneChestServant_Case04::
Jump_085_47B1:: ; address name
    ld a, $E0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    xor a, a
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

; entry 1 of the `rst $00` table in SceneChestServant
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived, hFieldDrawFlags
; writes: wStepPtrLo, hFieldDrawFlags
; points at: wScriptParam0, wScriptStep
SceneChestServant_Case01::
Jump_085_47E3:: ; address name
    ld a, [wScriptParam0]
    swap a
    ld c, a
    ld a, $10
    sub a, c
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ldh a, [hFieldDrawFlags]
    add a, a
    or a, $01
    ldh [hFieldDrawFlags], a
    ld hl, wScriptParam0
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneChestServant
; no direct call (reached through a table, a jump or a vector)
; writes: hFieldDrawFlags, wScriptParam0
; points at: wScriptStep
SceneChestServant_QueueSoundEffectAndStep::
Jump_085_480A:: ; address name
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7E (SCRIPT_SCENE_GOT_TO): a cutscene step named after the scene its only script shows: 'That's true I've got to...'; reached through ScriptCommand7E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand7E)
; reads: wScriptParam0
; writes: wObject5, wScriptParam0, wScriptStartRequest
SceneGotTo::
Func_085_481C:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_085_4829
    bit 3, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4829::
    cp a, $3C
    jr nc, Jump_085_4833
    bit 2, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4833::
    bit 1, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4839::
    ld a, $80
    ld [wObject5], a
    jr Jump_085_4844

Jump_085_4840::
    xor a, a
    ld [wObject5], a

Jump_085_4844::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 74 (SCRIPT_SET_FLAG_REDRAW): sets a story flag, applies the map-screen flag events and redraws the screen (treasure chests); reached through ScriptCommand74 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand74)
; reads: hPlayerX, hPlayerFacing
; writes: wScriptStartRequest
SetFlagRedraw::
Func_085_4858:: ; address name
    ld b, $00
    ldh a, [hPlayerX]
    ld c, a
    ldh a, [hPlayerFacing]
    cp a, $01
    jr z, Jump_085_4869
    cp a, $03
    jr z, Jump_085_486F
    jr Jump_085_4873

Jump_085_4869::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_085_4873

Jump_085_486F::
    ld a, c
    sub a, $10
    ld c, a

Jump_085_4873::
    ld hl, $489C

Jump_085_4876::
    ld a, [hl]
    cp a, c
    jr z, Jump_085_487E
    inc hl
    inc b
    jr Jump_085_4876

Jump_085_487E::
    ld de, $01CF
    ld a, b
    add a, e
    ld e, a
    jr nc, Jump_085_4887
    inc d

Jump_085_4887::
    call SetFlagBit
    farcall ApplyMapScreenFlagEvents
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $20, $40, $50, $80

; implements script command type 72 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2): a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_KAMEHA_KEY_BATTLE; reached through ScriptCommand72 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand72)
; reads: wScriptStep
SceneKamehaKeyBattle2::
Func_085_48A0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKamehaKeyBattle2_StartScriptedEncounterTemp0AndStep
    dw SceneKamehaKeyBattle2_Case01
    dw SceneWatchOut_Case01
    dw SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic
    dw SceneWatchOut_Case03

; entry 3 of the `rst $00` table in SceneKamehaKeyBattle2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; points at: wScriptStep
SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic::
Jump_085_48AE:: ; address name
    ld hl, $0B9D
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_48BA
    ld hl, $0BC2 ; '0 received the Magic Key.'

Jump_085_48BA::
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneKamehaKeyBattle2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, hTemp0
; writes: hTemp0, wScriptStep, hTemp1, wScriptParam0
; points at: wScriptStep
SceneKamehaKeyBattle2_Case01::
Jump_085_48C2:: ; address name
    ld a, [wBattleScene]
    or a, a
    jr nz, Jump_085_4932
    ld de, $003B
    call SetFlagBit
    ld a, $09
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_085_4912
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_085_48F5

Jump_085_48E9::
    ld hl, $0B9E ; 'Kameha That was a good warmup!'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_085_48F5::
    ld a, $09
    ldh [hTemp1], a
    ld de, $0205
    call TestFlagBit
    jr nc, Jump_085_4905
    ld a, $49
    ldh [hTemp1], a

Jump_085_4905::
    farcall WriteKeyEntryTemp0
    ld a, $01
    ld [wScriptParam0], a
    jr Jump_085_4921

Jump_085_4912::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_085_48E9
    xor a, a
    ld [wScriptParam0], a

Jump_085_4921::
    ld de, $003C
    call SetFlagBit
    ld hl, $0B9C ; 'Kameha That was a good warmup!'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4932::
    ld hl, $0B97 ; 'Kameha Wahahahah! You're weak! You're a'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in SceneKamehaKeyBattle2
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneKamehaKeyBattle2_StartScriptedEncounterTemp0AndStep::
Jump_085_493E:: ; address name
    ld a, $30
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 71 (SCRIPT_SCENE_KAMEHA_KEY_BATTLE): a cutscene step named after the scene its only script shows: 'Kameha So you're confident, huh?' (key entry and encounter); reached through ScriptCommand71 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand71)
; reads: wScriptStep
SceneKamehaKeyBattle::
Func_085_494D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKamehaKeyBattle_StartScriptedEncounterTemp0AndStep
    dw SceneKamehaKeyBattle_Case01
    dw SceneWatchOut_Case01
    dw SceneKamehaKeyBattle_ShowHeroReceivedTheMagic
    dw SceneWatchOut_Case03

; entry 3 of the `rst $00` table in SceneKamehaKeyBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; points at: wScriptStep
SceneKamehaKeyBattle_ShowHeroReceivedTheMagic::
Jump_085_495B:: ; address name
    ld hl, $0B93
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_4967
    ld hl, $0BC2 ; '0 received the Magic Key.'

Jump_085_4967::
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneKamehaKeyBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, hTemp0
; writes: hTemp0, wScriptStep, hTemp1, wScriptParam0
; points at: wScriptStep
SceneKamehaKeyBattle_Case01::
Jump_085_496F:: ; address name
    ld a, [wBattleScene]
    or a, a
    jr nz, Jump_085_49DF
    ld de, $0039
    call SetFlagBit
    ld a, $07
    ldh [hTemp0], a
    farcall KeyListHasKindTemp0
    ldh a, [hTemp0]
    or a, a
    jr nz, Jump_085_49BF
    farcall CountKeysOrFull
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_085_49A2

Jump_085_4996::
    ld hl, $0B94 ; 'Kameha Well, uh, luck and status'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_085_49A2::
    ld a, $07
    ldh [hTemp1], a
    ld de, $0203
    call TestFlagBit
    jr nc, Jump_085_49B2
    ld a, $47
    ldh [hTemp1], a

Jump_085_49B2::
    farcall WriteKeyEntryTemp0
    ld a, $01
    ld [wScriptParam0], a
    jr Jump_085_49CE

Jump_085_49BF::
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_085_4996
    xor a, a
    ld [wScriptParam0], a

Jump_085_49CE::
    ld de, $003A
    call SetFlagBit
    ld hl, $0B92 ; 'Kameha Well, uh, luck and status'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_49DF::
    ld hl, $0B97 ; 'Kameha Wahahahah! You're weak! You're a'
    call StartMessageHL_B85
    ld a, $04
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in SceneKamehaKeyBattle
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneKamehaKeyBattle_StartScriptedEncounterTemp0AndStep::
Jump_085_49EB:: ; address name
    ld a, $2F
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7B (SCRIPT_SCENE_ARENA_CHALLENGE): a cutscene step named after the scene its only script shows: 'Really? Let's go to the Arena!' (encounter); reached through ScriptCommand7B in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand7B)
; reads: wScriptStep
SceneArenaChallenge::
Func_085_49FA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneArenaChallenge_StartScriptedEncounterTemp0AndStep
    dw SceneArenaChallenge_ShowAwwILoseYou
    dw SceneWatchOut_Case03

; entry 1 of the `rst $00` table in SceneArenaChallenge
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; points at: wScriptStep
SceneArenaChallenge_ShowAwwILoseYou::
Jump_085_4A04:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, Jump_085_4A15
    ld hl, $0D82 ; 'Aww I lose. You are good!'
    call StartMessageHL_B85
    ret

Jump_085_4A15::
    ld hl, $0D83 ; 'Yay! I won! Am I awesome?'
    call StartMessageHL_B85
    ret

; entry 0 of the `rst $00` table in SceneArenaChallenge
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneArenaChallenge_StartScriptedEncounterTemp0AndStep::
Jump_085_4A1C:: ; address name
    ld a, $15
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 7C (SCRIPT_SCENE_TERRY_BATTLE): a cutscene step named after the scene its only script shows: 'Terry Humph Confident, huh?' (encounter); reached through ScriptCommand7C in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand7C)
; reads: wScriptStep
SceneTerryBattle::
Func_085_4A2B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneTerryBattle_SetFlagBitAndStep
    dw SceneTerryBattle_ShowTerryWellThisProves
    dw SceneWatchOut_Case03

; entry 1 of the `rst $00` table in SceneTerryBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; writes: wLinkByte94
; points at: wScriptStep
SceneTerryBattle_ShowTerryWellThisProves::
Jump_085_4A35:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, Jump_085_4A51
    ld hl, $0BB1 ; 'Terry Well, this proves that I'
    call StartMessageHL_B85
    ld a, $01
    ld [wLinkByte94], a
    ld de, $0038
    call SetFlagBit
    ret

Jump_085_4A51::
    ld hl, $0BB2 ; 'Terry Humph Don't take it hard.'
    call StartMessageHL_B85
    ret

; entry 0 of the `rst $00` table in SceneTerryBattle
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneTerryBattle_SetFlagBitAndStep::
Jump_085_4A58:: ; address name
    ld de, $0037
    call SetFlagBit
    ld a, $14
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 70 (SCRIPT_SCENE_TERRY): a cutscene step named after the scene its only script shows: '0 obtained the Magic Key.' ... 'Humph I'm Terry. I'm a master'; reached through ScriptCommand70 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand70)
; reads: wScriptStep, hPlayerX
; writes: wScriptStartRequest, hMapScreenX, hMapScreenY, wWarpDestY, wFieldTransitionKind, hMapId, wWarpDestX
SceneTerry::
Func_085_4A6D:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr z, Jump_085_4A79
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_085_4A79::
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    ldh a, [hPlayerX]
    cp a, $20
    jr nz, Jump_085_4ABC
    ld a, $0F
    ldh [hMapId], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_085_4AAB
    ld a, $20
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

Jump_085_4AAB::
    ld a, $20
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

Jump_085_4ABC::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_085_4AD9
    ld a, $10
    ldh [hMapId], a
    ld a, $70
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

Jump_085_4AD9::
    ld a, $0F
    ldh [hMapId], a
    ld a, $70
    ld [wWarpDestX], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

; implements script command type 6F (SCRIPT_DESK_KEY): the desk animation before '0 obtained the Brawn/Baffle/Soul/Magic Key.'; reached through ScriptCommand6F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand6F)
; reads: wScriptStep
; writes: wSpriteSlotCount, wScriptStartRequest
; points at: wScriptStep
DeskKey::
Func_085_4AEE:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, Jump_085_4B09
    ld hl, wObject1 + $C
    inc [hl]
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4B09::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 6E (SCRIPT_SCENE_LIMBO_MONSTER_2): a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_LIMBO_MONSTER; reached through ScriptCommand6E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand6E)
; reads: wScriptStep
SceneLimboMonster2::
Func_085_4B0F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneLimboMonster2_ShowWarubouWaheyIWas
    dw SceneWatchOut_Case03
    dw SceneWatchOut_Case01
    dw SceneLimboMonster2_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_Case01
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_Case08
    dw SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneWatchOut_Case01
    dw SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid
    dw SceneWatchOut_Case01
    dw SceneLimboMonster2_Case0E
    dw SceneLimboMonster2_Case0F

; entry 15 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, wArg5
; writes: hFieldDrawFlags, wStepTarget, wStepPtrHi, wStepPtrLo, hTemp1, hTemp2, hTemp3, wScriptStartRequest
SceneLimboMonster2_Case0F::
Jump_085_4B33:: ; address name
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $C0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $03
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld de, $002B
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneLimboMonster2_Case0E::
Jump_085_4B6F:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_4B94
    ld a, $01
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_085_4B94::
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid::
Jump_085_4BB2:: ; address name
    ld hl, $0BA7 ; 'Warubou Wa-hey, my kid has a'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85::
Jump_085_4BBD:: ; address name
    ld de, wObject2 + $C
    ld hl, $0BA6
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; entry 3 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wObject1
; writes: wObject2, wScriptStep
; points at: wScriptStep
SceneLimboMonster2_ShowWarubouWaheyGoodGood::
Jump_085_4BC7:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_085_4BEC
    ld hl, vTiles1 + $3A5
    call StartMessageHL_B85
    ld a, [wObject1 + $7]
    add a, a
    ld hl, $4BF8
    add_a_to_hl
    ld a, [hl+]
    ld [wObject2 + $B], a
    ld a, [hl]
    ld [wObject2 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4BEC::
    ld hl, vTiles1 + $595
    call StartMessageHL_B85
    ld a, $01
    ld [wScriptStep], a
    ret
    db $D0, $10, $C0, $20, $D0, $30, $E0, $20

; entry 0 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
; writes: wScriptStep
; points at: wScriptStep
SceneLimboMonster2_ShowWarubouWaheyIWas::
Jump_085_4C00:: ; address name
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_085_4C18
    ld hl, $0BA3 ; 'Warubou Wa-hey! I was thinking GreatLog'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4C18::
    ld hl, $4BA4 ; 'Warubou Wa-hey! I was thinking GreatLog'
    call StartMessageHL_B85
    ld a, $02
    ld [wScriptStep], a
    ret

; implements script command type 6D (SCRIPT_SCENE_LIMBO_MONSTER): a cutscene step named after the scene its only script shows: 'Limbo is the King's domain!' ... 'Prince Kameha has been missing' (creates a monster record); reached through ScriptCommand6D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand6D)
; reads: wScriptStep
SceneLimboMonster::
Func_085_4C24:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneLimboMonster_ShowWarubouWaheyIHave
    dw SceneWatchOut_Case03
    dw SceneWatchOut_Case01
    dw SceneLimboMonster_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_Case01
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_Case08
    dw SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneWatchOut_Case01
    dw SceneLimboMonster_Case0C
    dw SceneWatchOut_Case01
    dw SceneWatchOut_Case03

; entry 12 of the `rst $00` table in SceneLimboMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, wArg5
; writes: wScriptParam0, wStepPtrLo, wStepPtrHi, wObject2, hTemp1, hTemp2, hTemp3, hFieldDrawFlags
; points at: wScriptStep
SceneLimboMonster_Case0C::
Jump_085_4C46:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_4C51
    ld a, $65
    call QueueSoundEffect

Jump_085_4C51::
    ld a, [wScriptParam0]
    push af
    sra a
    ld [wScriptParam0], a
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_085_4C7F
    ld a, [wObject2 + $7]
    inc a
    and a, $03
    ld [wObject2 + $7], a

Jump_085_4C7F::
    ld a, [wObject2 + $B]
    dec a
    dec a
    ld [wObject2 + $B], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ld hl, $0B2C ; 'Warubou Wa-hey, my kid has a'
    call StartMessageHL_B85
    ld a, $04
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $01
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld de, $002A
    call SetFlagBit
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneLimboMonster
; no direct call (reached through a table, a jump or a vector)
SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85::
Jump_085_4CBC:: ; address name
    ld de, wObject2 + $C
    ld hl, $0B2B
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; entry 8 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, wObject1
; writes: hFieldDrawFlags, wScriptParam0, wStepPtrLo, wStepPtrHi, wObject2
; points at: wScriptStep
SceneLimboMonster2_Case08::
Jump_085_4CC6:: ; address name
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_4CD5
    ld a, $65
    call QueueSoundEffect

Jump_085_4CD5::
    ld a, [wScriptParam0]
    push af
    sra a
    ld [wScriptParam0], a
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_085_4D03
    ld a, [wObject2 + $7]
    inc a
    and a, $03
    ld [wObject2 + $7], a

Jump_085_4D03::
    ld a, [wObject2 + $B]
    inc a
    inc a
    ld [wObject2 + $B], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ld a, $72
    call QueueSoundEffect
    ld a, [wObject1 + $7]
    ld [wObject2 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneLimboMonster2
; no direct call (reached through a table, a jump or a vector)
SceneLimboMonster2_ToScriptStepMoveFollowersToLeader::
Jump_085_4D29:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ret

; entry 3 of the `rst $00` table in SceneLimboMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wObject1
; writes: wObject2, wScriptStep
; points at: wScriptStep
SceneLimboMonster_ShowWarubouWaheyGoodGood::
Jump_085_4D30:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_085_4D55
    ld hl, vTiles1 + $32A
    call StartMessageHL_B85
    ld a, [wObject1 + $7]
    add a, a
    ld hl, $4D61
    add_a_to_hl
    ld a, [hl+]
    ld [wObject2 + $B], a
    ld a, [hl]
    ld [wObject2 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4D55::
    ld hl, vTiles1 + $595
    call StartMessageHL_B85
    ld a, $01
    ld [wScriptStep], a
    ret
    db $D0, $10, $C0, $20, $D0, $30, $E0, $20

; entry 0 of the `rst $00` table in SceneLimboMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5
; writes: wScriptStep
; points at: wScriptStep
SceneLimboMonster_ShowWarubouWaheyIHave::
Jump_085_4D69:: ; address name
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr nz, Jump_085_4D81
    ld hl, $0B28 ; 'Warubou Wa-hey, I have a favor'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_4D81::
    ld hl, $4B29 ; 'Warubou Wa-hey, I have a favor'
    call StartMessageHL_B85
    ld a, $02
    ld [wScriptStep], a
    ret

; implements script command type 6C (SCRIPT_GIVE_MONSTER): creates a monster record of kind hTemp1 (CreateMonsterRecordOfKindTemp1); 'You'll take it? Excellent! I'll send...'; reached through ScriptCommand6C in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand6C)
; reads: wArg5
; writes: hTemp1, hTemp2, hTemp3, wScriptStartRequest
GiveMonster::
Func_085_4D8D:: ; address name
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

; implements script command type 79 (SCRIPT_SCENE_POOR_CHURCH): a cutscene step named after the scene its only script shows: ... 'Our church is impoverished, so I...'; reached through ScriptCommand79 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand79)
; reads: wScriptStep
ScenePoorChurch::
Func_085_4DA6:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScenePoorChurch_Case00
    dw ScenePoorChurch_Case01
    dw ScenePoorChurch_Case02
    dw ScenePoorChurch_Case03

; entry 3 of the `rst $00` table in ScenePoorChurch
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wKeyRandomLo, wKeyRandomHi
; writes: wScriptParam0, wScriptStartRequest
ScenePoorChurch_Case03::
Jump_085_4DB2:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, Jump_085_4DD8
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $03
    swap a
    ld hl, wSpriteSlots + $7
    add_a_to_hl
    push hl
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $01
    add a, a
    inc a
    pop hl
    ld [hl], a

Jump_085_4DD8::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScenePoorChurch
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wStoryFlags
; writes: wScriptParam0, wScriptParam1, wStoryFlags, wScriptStartRequest
; points at: wScriptStep
ScenePoorChurch_Case02::
Jump_085_4DE8:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $01
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld a, [wScriptParam1]
    cp a, $05
    jr z, Jump_085_4E06
    inc a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    dec [hl]
    ret

Jump_085_4E06::
    ld a, [wStoryFlags + $61]
    set 3, a
    ld [wStoryFlags + $61], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0056
    call TestFlagBit
    ret c
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScenePoorChurch
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wIsCGB
; writes: rSVBK, wScriptParam0
; points at: wScreenTileBuffer, wScreenAttrBuffer, wScriptStep
ScenePoorChurch_Case01::
Jump_085_4E1F:: ; address name
    ld a, [wScriptParam1]
    add a, a
    add a, a
    add a, a
    ld hl, ScreenAnimationTable
    add_a_to_hl
    ld a, [wScriptParam0]
    and a, $01
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $93
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_085_4E61
    ld a, [hl+]
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

Jump_085_4E61::
    farcall DrawFullScreenBufferAtScroll
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $04
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; E-0145 (C1: ScenePoorChurch_Case01 indexes it with 8 * wScriptParam1 + 4 * (wScriptParam0 & 1) and decompresses the two words from bank $93 into wScreenTileBuffer and, on CGB, wScreenAttrBuffer; it runs four steps, alternating the two frames; entries 0-5 decode to 360-byte screens, the bytes after them do not).
; record: frame 0 tile map (bank $93); frame 0 attribute map; frame 1 tile map; frame 1 attribute map
ScreenAnimationTable::
Data_085_4E7A:: ; address name
    dw Map2FScreens0_Y1X0 ; id 0: frame 0 tile map (bank $93)
    dw Map2FAttrs0_Y1X0 ; frame 0 attribute map
    dw Data_093_5B36 ; frame 1 tile map
    dw Data_093_6153 ; frame 1 attribute map
    dw Data_093_5B36 ; id 1: frame 0 tile map (bank $93)
    dw Data_093_6153 ; frame 0 attribute map
    dw Data_093_5BE9 ; frame 1 tile map
    dw Data_093_6194 ; frame 1 attribute map
    dw Data_093_5BE9 ; id 2: frame 0 tile map (bank $93)
    dw Data_093_6194 ; frame 0 attribute map
    dw Data_093_5C99 ; frame 1 tile map
    dw Data_093_61CF ; frame 1 attribute map
    dw Data_093_5C99 ; id 3: frame 0 tile map (bank $93)
    dw Data_093_61CF ; frame 0 attribute map
    dw Data_093_5D4B ; frame 1 tile map
    dw Data_093_6208 ; frame 1 attribute map
    dw Data_093_5D4B ; id 4: frame 0 tile map (bank $93)
    dw Data_093_6208 ; frame 0 attribute map
    dw Data_093_5DF5 ; frame 1 tile map
    dw Data_093_623C ; frame 1 attribute map
    dw Data_093_5DF5 ; id 5: frame 0 tile map (bank $93)
    dw Data_093_623C ; frame 0 attribute map
    dw Map2FScreens4_Y1X0 ; frame 1 tile map
    dw Map2FAttrs4_Y1X0 ; frame 1 attribute map

; entry 0 of the `rst $00` table in ScenePoorChurch
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptParam1
; points at: wScriptStep
ScenePoorChurch_Case00::
Jump_085_4EAA:: ; address name
    ld de, $0056
    call TestFlagBit
    jr nc, Jump_085_4F0B
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
    or a, a
    ret z

Jump_085_4F0B::
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type C2 (SCRIPT_SCENE_GIVE_BACK_CYAL): a cutscene step named after the scene its only script shows: 'Rolt Shut up! Give back Cyal!'; reached through ScriptCommandC2 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC2)
; reads: wScriptStep
SceneGiveBackCyal::
Func_085_4F14:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneGiveBackCyal_Case00
    dw SceneGiveBackCyal_Case00
    dw SceneGiveBackCyal_Case00
    dw SceneGiveBackCyal_Case00
    dw SceneGiveBackCyal_Case00
    dw SceneGiveBackCyal_ShowHumphHowBoring
    dw SceneWatchOut_Case01
    dw SceneGiveBackCyal_Case07
    dw SceneGiveBackCyal_Case08
    dw SceneGiveBackCyal_Case09_Sub01_Case09
    dw SceneGiveBackCyal_SetScriptStartRequestTo80

; entry 10 of the `rst $00` table in SceneGiveBackCyal
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneGiveBackCyal_SetScriptStartRequestTo80::
Jump_085_4F2E:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in SceneGiveBackCyal
; no direct call (reached through a table, a jump or a vector)
SceneGiveBackCyal_Case09_Sub01_Case09::
Jump_085_4F34:: ; address name
    ld b, $1E
    call SceneGiveBackCyal_Case09_Sub01
    ret

; entry 8 of the `rst $00` table in SceneGiveBackCyal
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
SceneGiveBackCyal_Case08::
Jump_085_4F3A:: ; address name
    ld a, [wObject2 + $B]
    inc a
    inc a
    inc a
    inc a
    ld [wObject2 + $B], a
    cp a, $60
    ret nz
    ld hl, wObject2 + $D
    call ClearBit1AtHL_Bank85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneGiveBackCyal
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots, wScriptParam0, wObject2
; points at: wScriptStep
SceneGiveBackCyal_Case07::
Jump_085_4F52:: ; address name
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $04
    ret c
    push af
    ld a, $66
    call QueueSoundEffect
    xor a, a
    ld [wSpriteSlots + $7], a
    pop af
    cp a, $08
    ret nz
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank85
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank85
    ld a, $03
    ld [wObject2 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneGiveBackCyal
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneGiveBackCyal_ShowHumphHowBoring::
Jump_085_4F8E:: ; address name
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, $0737 ; 'Humph How boring'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneGiveBackCyal
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2
; writes: wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneGiveBackCyal_Case00::
Jump_085_4F9E:: ; address name
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F_Bank85
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_4FBE
    ld a, [wObject2 + $C]
    inc a
    ld [wObject2 + $C], a
    cp a, $48
    ret nz
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_085_4FBE::
    ld a, [wObject2 + $C]
    dec a
    dec a
    ld [wObject2 + $C], a
    cp a, $40
    ret nz
    farcall RedrawColumnsBesideScreen
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from SceneGiveBackCyal_Case09 (E-0047)
; 1 call site from 1 routine (e.g. SceneGiveBackCyal_Case09_Sub01_Case09)
; reads: wFrameCounterLo, hScrollX, hScrollXHi, wScriptParam0
; writes: hScrollX, hScrollXHi, wScriptParam0
; points at: wScriptStep
SceneGiveBackCyal_Case09_Sub01::
Func_085_4FD8:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_085_5003
    dec a
    add a, a
    ld c, a
    bit 7, a
    jr z, Jump_085_4FF8
    cpl
    inc a
    ld c, a
    ldh a, [hScrollX]
    sub a, c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    sbc a, $00
    ldh [hScrollXHi], a
    jr Jump_085_5003

Jump_085_4FF8::
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hScrollXHi], a

Jump_085_5003::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    ret nz
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type CD (SCRIPT_SCENE_YOU_DID_IT): a cutscene step named after the scene its only script shows: ... 'Warubou Wa-hey! You did it, 0!'; reached through ScriptCommandCD in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandCD)
; reads: wScriptStep
SceneYouDidIt::
Func_085_501A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneYouDidIt_Case00
    dw SceneWatchOut_Case03

; entry 0 of the `rst $00` table in SceneYouDidIt
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; points at: wScriptStep
SceneYouDidIt_Case00::
Jump_085_5022:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hMapId]
    ld c, a
    ld de, $5041

Jump_085_502C::
    ld a, [de]
    cp a, $FF
    ret z
    ld a, [de]
    cp a, c
    jr z, Jump_085_5038
    inc de
    inc de
    jr Jump_085_502C

Jump_085_5038::
    inc de
    ld a, [de]
    ld l, a
    ld h, $0C
    call StartMessageHL_B85
    ret
    db $CA, $4A, $CB, $4B, $CC, $4C, $CD, $4D, $D3, $4E, $D4, $4F, $D5, $50, $D6, $51
    db $DC, $52, $DD, $53, $DE, $54, $DF, $55, $FF

; implements script command type 73 (SCRIPT_FOLLOWER_FACE_PLAYER): copies hPlayerFacing to the first follower record; reached through ScriptCommand73 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand73)
; reads: hPlayerFacing
; writes: wFollowerRecords, wScriptStartRequest
FollowerFacePlayer::
Func_085_505A:: ; address name
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 65 (SCRIPT_GROWTH_LIMIT_INFO): shows a monster's name and a record byte as digits: 'Everyone has a growth limit. Whether...'; reached through ScriptCommand65 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand65)
; reads: wScriptStep
GrowthLimitInfo::
Func_085_5065:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GrowthLimitInfo_Case00
    dw SceneWatchOut_Case01
    dw GrowthLimitInfo_Case02

; entry 2 of the `rst $00` table in GrowthLimitInfo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wPartyCount
; writes: wScriptStep, wScriptParam1, wScriptStartRequest
GrowthLimitInfo_Case02::
Jump_085_506F:: ; address name
    xor a, a
    ld [wScriptStep], a
    ld a, [wScriptParam1]
    inc a
    ld [wScriptParam1], a
    ld c, a
    ld a, [wPartyCount]
    cp a, c
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in GrowthLimitInfo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hTemp0, wDigits
; writes: rRAMG
; points at: wScriptStep, wPartyList, wNameGlyphBuf, wTextNumber
GrowthLimitInfo_Case00::
Jump_085_5086:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList
    ld a, [wScriptParam1]
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld b, $0A

Jump_085_50A9::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_085_50A9
    ld a, $F0
    ld [de], a
    pop af
    push af
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld e, a
    pop af
    ld c, $57
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp0]
    cp a, e
    jr nz, Jump_085_50D2
    ld hl, wRecordBufB + $2B
    call StartMessageHL_B85
    ret

Jump_085_50D2::
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wTextNumber
    ld a, [wDigits + $1]
    or a, a
    jr z, Jump_085_50E3
    ld [de], a
    inc de

Jump_085_50E3::
    ld a, [wDigits + $2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ld hl, wRecordBufB + $2A
    call StartMessageHL_B85
    ret

; implements script command type C4 (SCRIPT_SCENE_BARREL): a cutscene step named after the scene its only script shows: '0 peered into the barrel.' ... 'Kiral Ah! Back!' (encounter); reached through ScriptCommandC4 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC4)
; reads: wScriptStep
SceneBarrel::
Func_085_50F2:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneBarrel_Case00
    dw SceneBarrel_Case01
    dw SceneWatchOut_Case01
    dw SceneBarrel_Case03
    dw SceneBarrel_Case04
    dw SceneBarrel_Case05
    dw SceneWatchOut_Case01
    dw SceneBarrel_Case07
    dw SceneBarrel_ShowRobosterStoppedMoving
    dw SceneWatchOut_Case03

; entry 8 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots, wObject1, wScriptParam0
; points at: wScriptStep
SceneBarrel_ShowRobosterStoppedMoving::
Jump_085_510A:: ; address name
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $20
    ld [wObject1 + $C], a
    ld hl, $078D ; 'Roboster stopped moving'
    call StartMessageHL_B85
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots, wObject1, wScriptParam0
; points at: wScriptStep
SceneBarrel_Case07::
Jump_085_5123:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_085_5130
    bit 1, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_5130::
    cp a, $3C
    jr nc, Jump_085_513A
    bit 2, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_513A::
    bit 3, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_5140::
    ld a, $20
    ld [wSpriteSlots + $C], a
    ld a, $E0
    ld [wObject1 + $C], a
    jr Jump_085_5156

Jump_085_514C::
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $20
    ld [wObject1 + $C], a

Jump_085_5156::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $20
    ld [wObject1 + $C], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
SceneBarrel_Case05::
Jump_085_5173:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr z, Jump_085_5181
    call SceneBarrel_Case05_Sub01

Jump_085_5181::
    ld a, [wScriptParam0]
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from SceneBarrel_Case05 (E-0047)
; 1 call site from 1 routine (e.g. SceneBarrel_Case05)
; reads: wRandomHi
; writes: wObject1
SceneBarrel_Case05_Sub01::
Func_085_5190:: ; address name
    call NextTableByte
    ld a, [wRandomHi]
    and a, $03
    cp a, $03
    jr z, SceneBarrel_Case05_Sub01
    dec a
    ld c, a
    ld a, $40
    add a, c
    ld [wObject1 + $B], a
    ret

; entry 4 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStartRequest, wScriptParam0
; points at: wScriptStep
SceneBarrel_Case04::
Jump_085_51A5:: ; address name
    ld a, [wScriptParam1]
    and a, $03
    cp a, $03
    jr z, Jump_085_51B9
    ld de, $015F
    add a, e
    ld e, a
    jr nc, Jump_085_51B6
    inc d

Jump_085_51B6::
    call SetFlagBit

Jump_085_51B9::
    ld de, $0162
    call TestFlagBit
    jr c, Jump_085_51C7
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_085_51C7::
    ld de, $0163
    call SetFlagBit
    ld hl, $0779 ; 'PROFE SOR ORDER MUST OBEY'
    call StartMessageHL_B85
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: hTemp0
; points at: wScriptStep
SceneBarrel_Case03::
Jump_085_51DC:: ; address name
    ld a, [wScriptParam1]
    and a, $03
    ld de, $51F7
    add a, e
    ld e, a
    jr nc, Jump_085_51E9
    inc d

Jump_085_51E9::
    ld a, [de]
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret
    db $0D, $0E, $0F, $10

; entry 1 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; points at: wScriptStep
SceneBarrel_Case01::
Jump_085_51FB:: ; address name
    ld a, [wScriptParam1]
    and a, $03
    add a, a
    ld de, $5216
    add a, e
    ld e, a
    jr nc, Jump_085_5209
    inc d

Jump_085_5209::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret
    db $6C, $07, $6F, $07, $72, $07, $75, $07

; entry 0 of the `rst $00` table in SceneBarrel
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam1
; points at: wScriptStep, wScriptParam1
SceneBarrel_Case00::
Jump_085_521E:: ; address name
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam1], a
    ld de, $015F
    call TestFlagBit
    ret nc
    ld hl, wScriptParam1
    inc [hl]
    ld de, $0160
    call TestFlagBit
    ret nc
    ld hl, wScriptParam1
    inc [hl]
    ld de, $0161
    call TestFlagBit
    ret nc
    ld hl, wScriptParam1
    inc [hl]
    ret

; implements script command type 5B (SCRIPT_SCENE_LIMBO): a cutscene step named after the scene its only script shows: 'Warubou Wa-hey! Take the treasures that...' ... 'Limbo is the King's domain!'; reached through ScriptCommand5B in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand5B)
; reads: wScriptStep
SceneLimbo::
Func_085_5248:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneLimbo_Case00
    dw SceneLimbo_Case01
    dw SceneLimbo_Case02
    dw SceneLimbo_Case03
    dw SceneWatchOut_Case01
    dw SceneLimbo_Case00
    dw SceneLimbo_Case01
    dw SceneLimbo_Case02
    dw SceneLimbo_Case03
    dw SceneWatchOut_Case01
    dw SceneLimbo_Case00
    dw SceneLimbo_Case01
    dw SceneLimbo_Case02
    dw SceneLimbo_Case03
    dw SceneWatchOut_Case01
    dw SceneLimbo_Case0F

; entry 15 of the `rst $00` table in SceneLimbo
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: wGameFlags836, wScriptStartRequest
; points at: wInventory
SceneLimbo_Case0F::
Jump_085_526C:: ; address name
    ld hl, wInventory

Jump_085_526F::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_085_527A
    or a, a
    jr z, Jump_085_527A
    inc hl
    jr Jump_085_526F

Jump_085_527A::
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $38
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in SceneLimbo
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject5
; writes: wObject5
; points at: wScriptStep
SceneLimbo_Case03::
Jump_085_5290:: ; address name
    ld a, [wSpriteSlots + $7]
    or a, a
    jr nz, Jump_085_52A0
    ld a, [wObject5 + $5]
    inc a
    inc a
    ld [wObject5 + $5], a
    jr Jump_085_52B8

Jump_085_52A0::
    dec a
    jr nz, Jump_085_52AD
    ld hl, wObject5 + $4
    inc [hl]
    ld hl, wObject5 + $5
    inc [hl]
    jr Jump_085_52B8

Jump_085_52AD::
    dec a
    jr z, Jump_085_52B8
    ld hl, wObject5 + $4
    dec [hl]
    ld hl, wObject5 + $5
    inc [hl]

Jump_085_52B8::
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneLimbo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptParam0
; points at: wScriptParam1, wScriptStep
SceneLimbo_Case02::
Jump_085_52C8:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    ld a, [wScriptParam1]
    ld hl, $052C
    add_a_to_hl
    call StartMessageHL_B85
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptParam1
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneLimbo
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneLimbo_Case01::
Jump_085_52ED:: ; address name
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneLimbo
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneLimbo_Case00::
Jump_085_5302:: ; address name
    ld a, [wScriptParam1]
    ld hl, $5329
    add_a_to_hl
    ld a, [hl]
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
    db $03, $08, $0A

; implements script command type 69 (SCRIPT_SCENE_FOUND_ME_BATTLE): a cutscene step named after the scene its only script shows: 'I'm surprised anyone managed to find...' ... 'Ah, so good of you to...' (encounter); reached through ScriptCommand69 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand69)
; reads: wScriptStep
SceneFoundMeBattle::
Func_085_532C:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneFoundMeBattle_Case00
    dw SceneWatchOut_Case01
    dw SceneFoundMeBattle_Case02
    dw SceneFoundMeBattle_Case03
    dw SceneFoundMeBattle_Case04
    dw SceneFoundMeBattle_Case05

; entry 5 of the `rst $00` table in SceneFoundMeBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId, hMapScreenX
; writes: wSpriteSlotCount, wScriptStartRequest
SceneFoundMeBattle_Case05::
Jump_085_533C:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ldh a, [hMapId]
    cp a, $96
    jr nz, Jump_085_534B
    ld de, $0201
    jr Jump_085_5358

Jump_085_534B::
    ld de, $00B9
    ldh a, [hMapScreenX]
    or a, a
    jr z, Jump_085_5358
    inc de
    dec a
    jr z, Jump_085_5358
    inc de

Jump_085_5358::
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in SceneFoundMeBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wSpriteSlots
; points at: wScriptStep
SceneFoundMeBattle_Case04::
Jump_085_5361:: ; address name
    ld a, $E0
    ld [wStepPtrLo], a
    xor a, a
    ld [wStepPtrHi], a
    ldh a, [hMapId]
    cp a, $96
    jr z, Jump_085_5389
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_5389::
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneFoundMeBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId, hTemp0
; writes: hTemp1, hTemp0, wScriptStep
SceneFoundMeBattle_Case03::
Jump_085_53A2:: ; address name
    ld a, $20
    ldh [hTemp1], a
    ldh a, [hMapId]
    cp a, $96
    jr nz, Jump_085_53B0
    ld a, $40
    ldh [hTemp1], a

Jump_085_53B0::
    xor a, a
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $05
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in SceneFoundMeBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStep, hTemp0
; points at: wScriptStep
SceneFoundMeBattle_Case02::
Jump_085_53C3:: ; address name
    ld a, [wScriptParam1]
    cp a, $01
    jr nz, Jump_085_53D0
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_085_53D0::
    ld a, $1B
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneFoundMeBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerSpriteOverride, hPlayerSpriteStreamHi, hPlayerSpriteStreamLo
; writes: wScriptParam1
; points at: wScriptStep
SceneFoundMeBattle_Case00::
Jump_085_53DF:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, Jump_085_53ED
    and a, $01
    jr z, Jump_085_53F9

Jump_085_53ED::
    ld a, $00
    ld [wScriptParam1], a
    ld hl, $0473 ; 'You! I e never seen you'
    call StartMessageHL_B85
    ret

Jump_085_53F9::
    ldh a, [hPlayerSpriteStreamHi]
    cp a, $00
    jr nz, Jump_085_53ED
    ldh a, [hPlayerSpriteStreamLo]
    cp a, $D6
    jr nz, Jump_085_5411
    ld a, $01
    ld [wScriptParam1], a
    ld hl, $0475 ; 'Oh, you're the cooking crew. Do'
    call StartMessageHL_B85
    ret

Jump_085_5411::
    cp a, $EC
    jr nz, Jump_085_53ED
    ld a, $02
    ld [wScriptParam1], a
    ld hl, $0474 ; 'Hm? Are you a new recruit?'
    call StartMessageHL_B85
    ret

; implements script command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS): a cutscene step named after the scene its only script shows: 'How could we die before enjoying...' ... 'The treasures are ours'; reached through ScriptCommand31 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand31)
; reads: wScriptStep
ScenePirateGhosts::
Func_085_5421:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScenePirateGhosts_Case00
    dw SceneWatchOut_Case01
    dw ScenePirateGhosts_Case02

; entry 0 of the `rst $00` table in ScenePirateGhosts
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; points at: wScriptStep
ScenePirateGhosts_Case00::
Jump_085_542B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hMapId]
    cp a, $43
    jr z, Jump_085_543A
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_085_543A::
    ld hl, $085D ; 'Check the wooden crate'
    call StartMessageHL_B85
    ret

; entry 2 of the `rst $00` table in ScenePirateGhosts
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId, hTemp0
; writes: hTemp1, hTemp0, wSpriteSlotCount, wScriptStartRequest
ScenePirateGhosts_Case02::
Jump_085_5441:: ; address name
    ldh a, [hMapId]
    cp a, $37
    jr nz, Jump_085_544B
    ld a, $10
    jr Jump_085_5455

Jump_085_544B::
    cp a, $42
    jr nz, Jump_085_5453
    ld a, $60
    jr Jump_085_5455

Jump_085_5453::
    ld a, $30

Jump_085_5455::
    ldh [hTemp1], a
    ld a, $00
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the scene its only script shows: 'King What? Arrrrgh! Round up all...' ... 'King I apologize, but my treasures...'; reached through ScriptCommand24 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand24)
; reads: wScriptStep
SceneTreasureTheft::
Func_085_546F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneTreasureTheft_ShowKingTheHideoutOf
    dw SceneTreasureTheft_Case01
    dw SceneWatchOut_Case01
    dw SceneTreasureTheft_Case03
    dw SceneTreasureTheft_Case04
    dw SceneTreasureTheft_Case05
    dw SceneTreasureTheft_ShowKingGoodYourValor
    dw SceneWatchOut_Case01
    dw SceneTreasureTheft_Case08

; entry 8 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; reads: wObject3, wScriptParam0, wObject4, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptParam0, wSpriteSlotCount, hFieldDrawFlags, wScriptStartRequest
; points at: wStepPtrHi
SceneTreasureTheft_Case08::
Jump_085_5485:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld b, $03
    ld hl, wObject1 + $B

Jump_085_548F::
    push bc
    push hl
    ld a, [hl]
    cp a, $50
    jr z, Jump_085_54A8
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_085_54B8

Jump_085_54A8::
    ld a, $00
    ld [wStepTarget], a
    ld a, $B0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_085_54B8::
    ld hl, wStepPtrHi
    inc [hl]
    pop hl
    ld a, $10
    add_a_to_hl
    pop bc
    dec b
    jr nz, Jump_085_548F
    ld a, [wObject3 + $B]
    cp a, $50
    jr nz, Jump_085_54D4
    ld a, $01
    ld [wScriptParam0], a

Jump_085_54D4::
    ld a, [wScriptParam0]
    or a, a
    ret z
    ld a, [wObject4 + $B]
    cp a, $50
    jr z, Jump_085_54F1
    ld a, $03
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

Jump_085_54F1::
    ld a, $00
    ld [wStepTarget], a
    ld a, $B0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi
; points at: wScriptStep
SceneTreasureTheft_ShowKingGoodYourValor::
Jump_085_5514:: ; address name
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
    or a, a
    ret z
    ld hl, $0186 ; 'King Good! Your valor be praised!'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
SceneTreasureTheft_Case05::
Jump_085_554F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneTreasureTheft_Case04::
Jump_085_5562:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
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

; entry 3 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wKeyRandomLo, wRandomHi
; writes: wScriptParam0, wObject1, wObject2, wObject3
; points at: wScriptStep
SceneTreasureTheft_Case03::
Jump_085_5581:: ; address name
    ld a, [wScriptParam0]
    and a, $0F
    jr nz, Jump_085_55A9
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $03
    inc a
    swap a
    ld hl, wSpriteSlots + $7
    add_a_to_hl
    push hl
    call NextTableByte
    ld a, [wRandomHi]
    and a, $01
    sla a
    inc a
    pop hl
    ld [hl], a

Jump_085_55A9::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $F0
    ret nz
    ld a, $02
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; writes: hFieldDrawFlags
; points at: wScriptStep
SceneTreasureTheft_Case01::
Jump_085_55C7:: ; address name
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneTreasureTheft
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneTreasureTheft_ShowKingTheHideoutOf::
Jump_085_55D0:: ; address name
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wWarpDestX], a
    ld a, $20
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0185 ; 'King The hideout of the thieves'
    call StartMessageHL_B85
    ret

; implements script command type 22 (SCRIPT_SCENE_CANAL_GATE): a cutscene step named after the scene its only script shows: 'What? Open the Canal Gate more?'; reached through ScriptCommand22 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand22)
; reads: wScriptStep
SceneCanalGate::
Func_085_55F5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneCanalGate_Case00
    dw SceneCanalGate_Case00
    dw SceneCanalGate_Msg0172_KingArrghIKnow
    dw SceneWatchOut_Case01
    dw SceneCanalGate_Case04
    dw SceneCanalGate_Case05
    dw SceneCanalGate_Case06

; entry 6 of the `rst $00` table in SceneCanalGate
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wObject1, wScriptStartRequest
SceneCanalGate_Case06::
Jump_085_5607:: ; address name
    ld a, [wObject1 + $C]
    dec a
    dec a
    ld [wObject1 + $C], a
    cp a, $10
    ret nz
    ld hl, wObject1 + $D
    call ClearBit1AtHL_Bank85
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in SceneCanalGate
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneCanalGate_Case05::
Jump_085_561E:: ; address name
    xor a, a
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wObject1 + $D
    call SetBit1AtHL_Bank85
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneCanalGate
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: wScriptParam0, wSpriteSlots
; points at: wScriptStep
SceneCanalGate_Case04::
Jump_085_5647:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret z
    ld a, [wSpriteSlots + $C]
    inc a
    ld [wSpriteSlots + $C], a
    cp a, $60
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneCanalGate
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneCanalGate_Msg0172_KingArrghIKnow::
Jump_085_5664:: ; address name
    ld hl, $0172 ; 'King Arrgh! I know that! I'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneCanalGate
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneCanalGate_Case00::
Jump_085_566F:: ; address name
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 18 (SCRIPT_SCENE_GREATLOG_KEY): a cutscene step named after the scene its only script shows: before '0 received the GreatLog Key.'; reached through ScriptCommand18 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand18)
; reads: wScriptStep
SceneGreatlogKey::
Func_085_567B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneGreatlogKey_ShowWarubouWaheyForgotSomething
    dw SceneWatchOut_Case01
    dw SceneGreatlogKey_ShowWarubouThisYouUse
    dw SceneWatchOut_Case01
    dw SceneGreatlogKey_Case04

; entry 4 of the `rst $00` table in SceneGreatlogKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wObject5
; writes: wObject5, wStepPtrLo, wStepPtrHi, wScriptParam0, wScriptStartRequest
SceneGreatlogKey_Case04::
Jump_085_5689:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_085_5694
    ld a, $65
    call QueueSoundEffect

Jump_085_5694::
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_085_56A4
    ld a, [wObject5 + $4]
    dec a
    dec a
    ld [wObject5 + $4], a
    jr Jump_085_56B3

Jump_085_56A4::
    ld a, [wScriptParam0]
    ld hl, $56DF
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + $4], a

Jump_085_56B3::
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
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
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $42, $45, $47, $4A, $4C, $4F, $51, $54, $56, $59, $5B, $5E, $60, $63, $65, $68
    db $6A, $6D, $6F, $72, $74, $77, $79, $7C, $7E, $81, $83, $86, $88, $8B, $8D, $90

; entry 2 of the `rst $00` table in SceneGreatlogKey
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneGreatlogKey_ShowWarubouThisYouUse::
Jump_085_56FF:: ; address name
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank85
    ret nc
    ld hl, $0084 ; 'Warubou This you use to come'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneGreatlogKey
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hTemp0, wObject5, hPlayerFacing, wFollowerRecords, wSpriteSlots, wScriptParam1
; points at: wScriptStep
SceneGreatlogKey_ShowWarubouWaheyForgotSomething::
Jump_085_571A:: ; address name
    ld a, $02
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, $0083 ; 'Warubou Wa-hey! Forgot something!'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    or a, a
    jr nz, Jump_085_574E
    ld a, $01
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wScriptParam1], a
    ret

Jump_085_574E::
    ld a, $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $01
    ld [wScriptParam1], a
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. SceneGiveBackCyal_Case07, SceneCanalGate_Case05)
SetBit1AtHL_Bank85::
Func_085_5760:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. SceneGiveBackCyal_Case08, SceneCanalGate_Case06)
ClearBit1AtHL_Bank85::
Func_085_5765:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; the same 5 bytes as SetBit2AtHL_B0F (0F:7ECE)
; 1 call site from 1 routine (e.g. SceneGiveBackCyal_Case00)
SetBit2AtHL_B0F_Bank85::
Func_085_576A:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. SceneGiveBackCyal_Case07)
ClearBit2AtHL_Bank85::
Func_085_576F:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
RotateDirectionAtDEEvery32_Bank85:: ; heuristic: follows a terminator; C0
Func_085_5774:: ; address name
    ld a, [wScriptParam0]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; the same 34 bytes as ScriptApplyStepDeltaAtDE (0F:7EE9)
; 5 call sites from 5 routines (e.g. DeskKey, SceneLimbo_Case03, SceneLimbo_Case01, SceneCanalGate_Case00, ...)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
ScriptApplyStepDeltaAtDE_Bank85::
Func_085_5780:: ; address name
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
    jr z, Jump_085_579C
    sub a, a
    ret

Jump_085_579C::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; stores DE in wC928/9 and far-calls AddStepDeltaToPointedByte each frame; after 32 frames starts message HL, clears wScriptParam0 and advances wScriptStep (E-0121)
; 2 call sites from 2 routines (e.g. SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85, SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
ScriptStepAdjust32TimesThenMessage_Bank85::
Func_085_57A2:: ; address name
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
    cp a, $20
    ret nz
    call StartMessageHL_B85
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 56 call sites from 37 routines (e.g. SceneYouDidIt_Case00, SceneBarrel_ShowRobosterStoppedMoving, SceneBarrel_Case04, SceneBarrel_Case01, ...)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B85::
Func_085_57C8:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; wC928 = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
; 5 call sites from 5 routines (e.g. SceneWaterReward_Case0F, SceneWatchOut_Case12, SceneWatchOut_Case0F, SceneWatchOut_Case03, ...)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxFar_Bank85::
Func_085_57D5:: ; address name
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, Jump_085_57E7
    sub a, a
    ret

Jump_085_57E7::
    scf
    ret

; entry 1 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWatchOut_Case01::
Jump_085_57E9:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank85
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneWatchOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneWatchOut_Case03::
Jump_085_57F3:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank85
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; hFFC6 = 1 when a party record has field $6F >= $C0 and bit 7 of field $55 clear, else 0 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, hTemp0
; writes: hTemp0, rRAMG
; points at: wPartyList
PartyHasField6FAtLeastC0Without55Bit7:: ; heuristic: follows a terminator; C0
Func_085_57FE:: ; address name
    ld a, [wPartyCount]
    or a, a
    jr nz, Jump_085_5808

Jump_085_5804::
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_5808::
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList

Jump_085_5811::
    push bc
    ld a, [hl]
    ld c, $6F
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    cp a, $C0
    jr c, Jump_085_582D
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_085_5837

Jump_085_582D::
    inc hl
    dec b
    jr nz, Jump_085_5811
    xor a, a
    ld [rRAMG], a
    jr Jump_085_5804

Jump_085_5837::
    xor a, a
    ld [rRAMG], a
    ld a, $01
    ldh [hTemp0], a
    ret

; only called from DispatchTalkEvent_Case05_Case0F (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case05_ShowBeGoneIfYour)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG, hTemp0
; points at: wPartyList
DispatchTalkEvent_Case05_Case0F_Sub01::
Func_085_5840:: ; address name
    ld a, [wPartyCount]
    or a, a
    jr nz, Jump_085_584E

Jump_085_5846::
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_584E::
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList

Jump_085_5857::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_085_5875
    push bc
    ld a, [hl]
    ld c, $6B
    call LoadSRAMRecordWord
    pop bc
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp1]
    or a, c
    jr nz, Jump_085_5846

Jump_085_5875::
    inc hl
    dec b
    jr nz, Jump_085_5857
    xor a, a
    ld [rRAMG], a
    ld a, $01
    ldh [hTemp0], a
    ret

; only called from DispatchTalkEvent_Case05_Case29 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case05_Case29)
; reads: hPlayerSpriteOverride, hPlayerSpriteStreamLo, hPlayerSpriteStreamHi, wPartyCount, hTemp0, hTemp1
; writes: hTemp0, rRAMG
; points at: wPartyList
DispatchTalkEvent_Case05_Case29_Sub01::
Func_085_5882:: ; address name
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, Jump_085_58B3
    and a, $01
    jr nz, Jump_085_58B3
    ld de, TalkEvent29WordList
    ldh a, [hPlayerSpriteStreamLo]
    ld l, a
    ldh a, [hPlayerSpriteStreamHi]
    ld h, a

Jump_085_5895::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_58B2
    ld a, [de]
    cp a, l
    jr nz, Jump_085_58AD
    inc de
    ld a, [de]
    cp a, h
    jr nz, Jump_085_58AD
    pop de
    ld a, $01
    ldh [hTemp0], a
    ret

Jump_085_58AD::
    pop de
    inc de
    inc de
    jr Jump_085_5895

Jump_085_58B2::
    pop de

Jump_085_58B3::
    ld a, [wPartyCount]
    or a, a
    jr nz, Jump_085_58BD
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_58BD::
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList

Jump_085_58C6::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_085_58FD
    push bc
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    pop bc
    ld de, TalkEvent29WordList

Jump_085_58DF::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_58FC
    ldh a, [hTemp0]
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_085_58F7
    inc de
    ldh a, [hTemp1]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_085_5909

Jump_085_58F7::
    pop de
    inc de
    inc de
    jr Jump_085_58DF

Jump_085_58FC::
    pop de

Jump_085_58FD::
    inc hl
    dec b
    jr nz, Jump_085_58C6
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_5909::
    pop de
    ld a, [wPartyCount]
    sub a, b
    inc a
    ldh [hTemp0], a
    ret

; E-0236 (C1: DispatchTalkEvent_Case05_Case29_Sub01 compares the words of this list, up to $0000, with hPlayerSpriteStreamLo/Hi when hPlayerSpriteOverride bit 7 is set and bit 0 clear, and otherwise with the word at byte $0B of each party record whose byte $55 bit 7 is clear (LoadSRAMRecordWord); a match sets hTemp0 to 1 or to the party position; 29 words; what the words identify is not read).
; record: words to match, then $0000
TalkEvent29WordList::
Data_085_5912:: ; address name
    dw $0009, $000E, $0011, $0012, $0016, $0018, $0019, $002B ; entry 0
    dw $0038, $0040, $0041, $0094, $00C6, $00EC, $0101, $0105
    dw $0119, $011B, $011F, $0120, $0124, $0126, $0127, $0129
    dw $012A, $012F, $0130, $0135, $0137, $0000

; only called from DispatchTalkEvent_Case05_Case47 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case05_ShowHeroCheckedTheSmall)
; reads: hPlayerSpriteOverride, hPlayerSpriteStreamLo, hPlayerSpriteStreamHi
; writes: hTemp0
DispatchTalkEvent_Case05_Case47_Sub01::
Func_085_594E:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, Jump_085_598C
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, Jump_085_5960
    and a, $01
    jr z, Jump_085_5964

Jump_085_5960::
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_5964::
    ld de, TalkEvent47WordList
    ldh a, [hPlayerSpriteStreamLo]
    ld l, a
    ldh a, [hPlayerSpriteStreamHi]
    ld h, a

Jump_085_596D::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr nz, Jump_085_597B
    pop de
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_597B::
    ld a, [de]
    cp a, l
    jr nz, Jump_085_5987
    inc de
    ld a, [de]
    cp a, h
    jr nz, Jump_085_5987
    pop de
    jr Jump_085_598C

Jump_085_5987::
    pop de
    inc de
    inc de
    jr Jump_085_596D

Jump_085_598C::
    ld a, $02
    ldh [hTemp0], a
    ret

; E-0236 (C1: DispatchTalkEvent_Case05_Case47_Sub01 (unless flag 0 is set) compares the words of this list, up to $0000, with hPlayerSpriteStreamLo/Hi when hPlayerSpriteOverride bit 7 is set and bit 0 clear; a match sets hTemp0 to 2; 113 words; what the words identify is not read).
; record: words to match, then $0000
TalkEvent47WordList::
Data_085_5991:: ; address name
    dw $0001, $0002, $0004, $0005, $0007, $0008, $0009, $000A ; entry 0
    dw $000B, $000D, $000F, $0011, $0012, $0016, $001A, $0024
    dw $0028, $002E, $0031, $0032, $0034, $0036, $0039, $003A
    dw $0048, $0049, $004A, $004B, $004D, $004F, $0050, $0053
    dw $0054, $0057, $005A, $005B, $0065, $006A, $006D, $006F
    dw $0070, $0071, $0073, $0074, $0076, $0084, $008D, $008E
    dw $0091, $0092, $0093, $0094, $0095, $0096, $0097, $0099
    dw $009A, $009E, $00A4, $00A5, $00A6, $00A7, $00B0, $00B1
    dw $00B2, $00B3, $00B4, $00B5, $00B6, $00B7, $00B9, $00BA
    dw $00BB, $00BD, $00BF, $00C5, $00D3, $00D6, $00D7, $00D8
    dw $00DC, $00DD, $00D4, $00F0, $00F6, $00F8, $00F9, $00FD
    dw $0100, $0101, $0103, $0105, $010D, $010E, $0119, $011B
    dw $011C, $011E, $0121, $0122, $0126, $0127, $012B, $012C
    dw $013C, $013D, $0140, $015A, $0149, $014D, $014E, $015B
    dw $0144, $0000

; only called from routines of DispatchTalkEvent (E-0098)
; 3 call sites from 3 routines (e.g. DispatchTalkEvent_Case05_Case4C, DispatchTalkEvent_Case05_Case6E, DispatchTalkEvent_Case05_Case6F)
; reads: hPlayerSpriteOverride, hPlayerSpriteStreamHi, hPlayerSpriteStreamLo
; writes: hTemp0, hTemp1
DispatchTalkEvent_Shared01::
Func_085_5A75:: ; address name
    ldh a, [hPlayerSpriteOverride]
    bit 7, a
    jr z, Jump_085_5A7F
    and a, $01
    jr z, Jump_085_5A83

Jump_085_5A7F::
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_5A83::
    ldh a, [hPlayerSpriteStreamHi]
    cp a, $00
    jr nz, Jump_085_5A91
    ldh a, [hPlayerSpriteStreamLo]
    cp a, $F6
    jr c, Jump_085_5A7F
    jr Jump_085_5A98

Jump_085_5A91::
    dec a
    jr nz, Jump_085_5A7F
    cp a, $11
    jr nc, Jump_085_5A7F

Jump_085_5A98::
    ld a, $01
    ldh [hTemp1], a
    ret

; only called from Talk04CB_ThatKeyIUsed (E-0047)
; 1 call site from 1 routine (e.g. Talk04CB_ThatKeyIUsed)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG, hTemp0
; points at: wPartyList
Talk04CB_ThatKeyIUsed_Sub01::
Func_085_5A9D:: ; address name
    ld a, [wPartyCount]
    or a, a
    ret z
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList

Jump_085_5AAB::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_085_5AE2
    push bc
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    pop bc
    ld de, $5AF8

Jump_085_5AC4::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_5AE1
    ldh a, [hTemp0]
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_085_5ADC
    inc de
    ldh a, [hTemp1]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_085_5AEE

Jump_085_5ADC::
    pop de
    inc de
    inc de
    jr Jump_085_5AC4

Jump_085_5AE1::
    pop de

Jump_085_5AE2::
    inc hl
    dec b
    jr nz, Jump_085_5AAB
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hTemp0], a
    ret

Jump_085_5AEE::
    pop de
    xor a, a
    ld [rRAMG], a
    ld a, $01
    ldh [hTemp0], a
    ret
    db $61, $01, $64, $01, $67, $01, $69, $01, $74, $01, $00, $00

; runs CountSpeciesPerFamilyFlaggedOrListed and sums the eleven per-family counts at wD09D into hFFC6/hFFC7 (E-0122)
; 14 call sites from 9 routines (e.g. DispatchTalkEvent_Case0A_Sub01_Case0A, TalkMsg0016_ItSeemsToMeThatThe, DispatchTalkEvent_Case01_Case19, TalkMsg0A3C_KingIfYouSee, ...)
; writes: hTemp0, hTemp1
; points at: wWorkBuf
TotalSpeciesFlaggedOrListed::
Func_085_5B04:: ; address name
    farcall CountSpeciesPerFamilyFlaggedOrListed
    ld hl, $0000
    ld de, wWorkBuf
    ld b, $0B

Jump_085_5B12::
    ld a, [de]
    add_a_to_hl
    inc de
    dec b
    jr nz, Jump_085_5B12
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ret

; hFFC6 = 1 when a used key entry has kind hFFC6, else 0 (E-0125)
; 7 call sites from 4 routines (e.g. TalkMsg0512_KamehaYo0Thanks, DispatchTalkEvent_Case01_ShowHeroFoundAMagic, SceneKamehaKeyBattle2_Case01, SceneKamehaKeyBattle_Case01)
; reads: hTemp0
; writes: hTemp0
; points at: wKeyList
KeyListHasKindTemp0::
Func_085_5B23:: ; address name
    ldh a, [hTemp0]
    ld c, a
    ld hl, wKeyList
    ld b, $20

Jump_085_5B2B::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_085_5B4E
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_085_5B45
    pop hl
    ld a, [hl]
    and a, $3F
    cp a, c
    jr nz, Jump_085_5B46
    ld a, $01
    ldh [hTemp0], a
    ret

Jump_085_5B45::
    pop hl

Jump_085_5B46::
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_085_5B2B
    ret

Jump_085_5B4E::
    pop hl
    xor a, a
    ldh [hTemp0], a
    ret

; on map $0B places four monster objects and picks the monster for the wC82C / wD7FF entry (table $5C5E) or a random one (E-0130)
; 3 call sites from 2 routines (e.g. InitFieldScreen, ArenaRounds_Case07)
; reads: hMapId, wArenaFlags, wRecordCapacity, wArenaRank, hTemp0, hTemp1, wKeyRandomHi
; writes: wSpriteSlots, wObject1, wObject2, wObject3, wFollowerRecords, wSpriteSlotCount, hTemp0, hTemp1, ...
; points at: wEncounterMonsters, hTemp0
SetupMap0BMonsterObjects::
Func_085_5B53:: ; address name
    ldh a, [hMapId]
    cp a, $0B
    ret nz
    ld a, [wArenaFlags]
    bit 7, a
    jr nz, Jump_085_5B67
    ld a, [wRecordCapacity]
    or a, a
    jr z, Jump_085_5BA9
    jr Jump_085_5B6B

Jump_085_5B67::
    and a, $03
    jr z, Jump_085_5BA9

Jump_085_5B6B::
    ld a, $50
    ld [wSpriteSlots + $B], a
    ld [wObject1 + $B], a
    ld [wObject2 + $B], a
    ld [wObject3 + $B], a
    ld a, $00
    ld [wSpriteSlots + $C], a
    ld a, $F0
    ld [wObject1 + $C], a
    ld a, $E0
    ld [wObject2 + $C], a
    ld a, $D0
    ld [wObject3 + $C], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    ld a, $30
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    xor a, a
    ld [wSpriteSlotCount], a

Jump_085_5BA9::
    ld a, [wArenaFlags]
    bit 7, a
    jr nz, Jump_085_5BD0
    ld a, [wArenaRank]
    add a, a
    add a, a
    ld hl, $5C5E
    add_a_to_hl
    ld a, [wRecordCapacity]
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    jr Jump_085_5BE9

Jump_085_5BD0::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $1F
    ld hl, $5C72
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a

Jump_085_5BE9::
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

Jump_085_5C08::
    push hl
    push de
    push bc
    ld a, b
    add a, $05
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
    ld hl, wObject1 + $2
    add_a_to_hl
    ldh a, [hTemp0]
    ld [hl+], a
    ldh a, [hTemp1]
    ld [hl], a
    xor a, a
    ldh [hTemp2], a
    farcall DecompressGraphicsTemp0ToTemp4
    pop bc
    pop de
    pop hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    inc de
    inc de
    inc b
    ld a, b
    cp a, $03
    jr nz, Jump_085_5C08
    ret
    db $06, $19, $18, $00, $15, $09, $16, $00, $14, $1E, $2A, $00, $0D, $2B, $12, $00
    db $28, $11, $20, $00, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $10, $11, $12, $13
    db $14, $15, $16, $1A, $1B, $1C, $1D, $21, $24, $25, $26, $28, $29, $2A, $2E, $2F
    db $33, $38, $39, $3D

; only called from Talk00Event02_Case04 (E-0047)
; 1 call site from 1 routine (e.g. Talk00Event02_Case04_Sub01_Case04)
; reads: wTriggerKind, wPendingFieldEvent, wInventory, wRandomLo, wMapSpriteKind, wMessageIndex, wMessageGroup, wKeyRandomHi, ...
; writes: wTriggerMarkerFlags, wScriptStartRequest, wScriptParam1, wTriggerKind, wTriggerCell, wTriggerIndex, wScriptParam0
; points at: wScriptStep
Talk00Event02_Case04_Sub01::
Func_085_5C92:: ; address name
    ld a, [wTriggerKind]
    cp a, $FF
    jr nz, Jump_085_5CB4
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr nz, Jump_085_5CB4
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, Jump_085_5CAA
    or a, a
    jr nz, Jump_085_5CB4

Jump_085_5CAA::
    call NextRandomSeed
    ld a, [wRandomLo]
    and a, $1F
    jr z, Jump_085_5CBE

Jump_085_5CB4::
    xor a, a
    ld [wTriggerMarkerFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_085_5CBE::
    ld a, [wMapSpriteKind]
    swap a
    and a, $0F
    dec a
    jr nz, Jump_085_5CFC
    call Talk00Event02_Case04_Sub01_Sub02
    cp a, $05
    jr nc, Jump_085_5CD8
    ld a, $80
    ld [wTriggerMarkerFlags], a
    ld a, $2C
    jr Jump_085_5D41

Jump_085_5CD8::
    farcall ComputePartyStrengthLevelPartyStrength
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $1F
    sub a, $10
    ld c, a
    ld a, [wPartyStrength]
    add a, c
    bit 7, a
    jr z, Jump_085_5CF3
    ld a, $01

Jump_085_5CF3::
    or a, $80
    ld [wTriggerMarkerFlags], a
    ld a, $2C
    jr Jump_085_5D41

Jump_085_5CFC::
    push af
    ld a, $80
    ld [wTriggerMarkerFlags], a
    call Talk00Event02_Case04_Sub01_Sub02
    cp a, $32
    jr nc, Jump_085_5D0D
    ld a, $00
    jr Jump_085_5D2F

Jump_085_5D0D::
    cp a, $46
    jr nc, Jump_085_5D15
    ld a, $01
    jr Jump_085_5D2F

Jump_085_5D15::
    cp a, $50
    jr nc, Jump_085_5D1D
    ld a, $02
    jr Jump_085_5D2F

Jump_085_5D1D::
    cp a, $5A
    jr nc, Jump_085_5D25
    ld a, $03
    jr Jump_085_5D2F

Jump_085_5D25::
    cp a, $5F
    jr nc, Jump_085_5D2D
    ld a, $04
    jr Jump_085_5D2F

Jump_085_5D2D::
    ld a, $05

Jump_085_5D2F::
    ld c, a
    pop af
    dec a
    and a, $01
    add a, a
    add a, a
    add a, a
    add a, c
    ld hl, $5D7C
    add_a_to_hl
    ld a, [hl]

Jump_085_5D41::
    ld [wScriptParam1], a
    ld hl, $5D8C
    add_a_to_hl
    ld a, [hl]
    or a, a
    jp z, Jump_085_5CB4
    ld [wTriggerKind], a
    farcall Talk00Event02_Case04_Sub01_Sub01
    ld a, [wMessageIndex]
    ld [wTriggerCell], a
    ld a, [wMessageGroup]
    ld [wTriggerIndex], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from Talk00Event02_Case04_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. Talk00Event02_Case04_Sub01)
; reads: wKeyRandomLo
Talk00Event02_Case04_Sub01_Sub02::
Func_085_5D6F:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $7F
    cp a, $63
    jr nc, Talk00Event02_Case04_Sub01_Sub02
    ret
    db $19, $1A, $1B, $1B, $1C, $2C, $00, $00, $01, $07, $28, $22, $0C, $2C, $00, $00
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0A, $06, $00, $01

; for each party record adds 100 to the INT word (field $69), capped at 999; far-called by Talk00FC_YouHaveToEat (E-0129)
; 1 call site from 1 routine (e.g. Talk00FC_YouHaveToEat)
; reads: wPartyCount
; writes: rRAMG
; points at: wPartyList
AddHundredToPartyINTCapped999::
Func_085_5DB9:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_085_5DC5::
    push hl
    ld a, [hl]
    ld c, $69
    call SRAMRecordAddress
    push hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, $0064
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, d
    cp a, $03
    jr c, Jump_085_5DE7
    jr nz, Jump_085_5DE4
    ld a, e
    cp a, $E7
    jr c, Jump_085_5DE7

Jump_085_5DE4::
    ld de, $03E7

Jump_085_5DE7::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_085_5DC5
    xor a, a
    ld [rRAMG], a
    ret

; copies the 48-byte preset $5E11, $5E41 or $5E71 (C = 0, 1, other) to wSpeciesFlags (E-0124)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case01_CaseE6)
; points at: wSpeciesFlags
LoadSpeciesFlagsPresetC::
Func_085_5DF5:: ; address name
    ld a, c
    ld de, $5E11
    or a, a
    jr z, Jump_085_5E05
    ld de, $5E41
    dec a
    jr z, Jump_085_5E05
    ld de, $5E71

Jump_085_5E05::
    ld b, $30
    ld hl, wSpeciesFlags

Jump_085_5E0A::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_085_5E0A
    ret
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $3F
    ds $21, $00
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $FF, $FF
    db $1F, $E0, $FF, $FF, $FF, $00, $FF, $FF, $FF, $03, $F8, $FF, $FF, $FF, $C1
    ds $11, $00
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $FF, $FF
    db $1F, $E0, $FF, $FF, $FF, $00, $FF, $FF, $FF, $03, $F8, $FF, $FF, $FF, $C1, $FF
    db $FF, $FF, $01, $FE, $FF, $FF, $FF, $F1, $FF, $FF, $FF, $8F, $FF, $FF, $1F
    ds $2160, $00
