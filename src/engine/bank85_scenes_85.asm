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
    dw SceneKeyShop_WalkRight

; Key shop scene, step 1: object 0 walks right to X $60, stops animating, and the script resumes.
; (C1, E-0357)
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

; Key shop scene, step 0: goes on; when object 0 is not already at X $50 the script resumes at once.
; (C1, E-0357)
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
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_ShowTheFarmHasNo
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_Msg_PickTheMonsterTo
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_OpenPartyBox
    dw SceneWatchOut_BoxCursorStep
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_RestoreScreen
    dw SceneWatchOut_CreateMonster
    dw SceneWatchOut_Finish
    dw SceneWatchOut_ShowNHeadedOffTo
    dw SceneWatchOut_WalkObject1
    dw SceneWatchOut_BackToStep14

; Watch Out scene, step 16: creates the new monster on the farm (record kind 5, hTemp3 1), "<name>
; headed off to the farm.", one sprite slot fewer, back to step 15. (C1, E-0357)
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
    farcall ClearBit1OfPlayerAndObjectFlags
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
    farcall SetBit1OfPlayerAndObjectFlags
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

; Watch Out scene, step 0: sets the monster's five-glyph default name (in wNameGlyphBuf and
; wTextBuf1 + 7) and shows '... Hm, you are quite strong...' (message $0D0F). (C1, E-0357)
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
    dw SceneWatchOut_WaitMessage
    dw SceneWaterReward_ShowWaitTheFarmIs
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_Msg_PickTheMonsterTo
    dw SceneWatchOut_WaitMessage
    dw SceneWaterReward_OpenPartyBox
    dw SceneWatchOut_BoxCursorStep
    dw SceneWatchOut_ShowLetMeJoinYour
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
    dw SceneWatchOut_ReadScriptMsgSelect
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

; Watch Out scene, step 17: object 1 walks one tile (16 frames) the way it faces. (C1, E-0357)
SceneWatchOut_WalkObject1::
    ld hl, wObject1 + OBJ_STATE
    call StepObjectCoordByDirection16Frames
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; Water reward scene, step 16: creates the new monster on the farm (record kind 0), "<name> headed
; off to the farm.", back to step 15. (C1, E-0357)
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
    farcall ClearBit1OfPlayerAndObjectFlags
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

; Watch Out scene, step 10: with choice 3 goes on; otherwise moves the followers to the leader. (C1,
; E-0357)
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

; Watch Out scene, step 9 (B in the box): restores the screen, asks '... Let me join your party?'
; ($0D56) again and returns to step 1. (C1, E-0357)
SceneWatchOut_ShowLetMeJoinYour::
    farcall RestoreScreenBufferFromBGMap1
    call DrawScreenBufferAtScrollOrigin
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0d56 ; '*: Let me join your party?'
    call StartMessageHL_B85
    farcall ClearBit1OfPlayerAndObjectFlags
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
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, wScriptStep
    inc [hl]
    ret

; Watch Out scene, step 5: 'Pick the monster to go to ...' (message $0D50). (C1, E-0357)
SceneWatchOut_Msg_PickTheMonsterTo::
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

; Water reward scene, step 0: sets the monster's default name and shows '... Cooh, I heard from
; others ...' (message $01B7). (C1, E-0357)
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
    call PartyBoxCursor_WriteScriptMsgSelect
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
    call PartyBoxCursor_WriteScriptMsgSelect
    ld a, $c3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    dec [hl]
    ld a, $69
    call QueueSoundEffect
    jr .call_party_box_cursor_write_script_msg_select

.check_bit7:
    bit 7, a
    jr z, .call_party_box_cursor_write_script_msg_select
    call PartyBoxCursor_WriteScriptMsgSelect
    ld a, $c3
    call WriteVRAMByte
    ld hl, wScriptMsgSelect
    inc [hl]
    ld a, $69
    call QueueSoundEffect

.call_party_box_cursor_write_script_msg_select:
    call PartyBoxCursor_WriteScriptMsgSelect
    ld c, $bb
    ld a, [wFrameCounterLo]
    bit 3, a
    jr z, .call_write_vram_byte
    ld c, $c3

.call_write_vram_byte:
    ld a, c
    call WriteVRAMByte
    ret

; HL = the BG map place of box row wScriptMsgSelect (0-3, 16 pixels apart) at the scroll position.
; (C1, E-0357)
PartyBoxCursor_WriteScriptMsgSelect::
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
    dw SceneWarubouLeaves_WalkObjects
    dw SceneWarubouLeaves_WalkUp
    dw SceneWarubouLeaves_WalkAway
    dw SceneWarubouLeaves_WalkOff

; Warubou leaves, step 3: objects 1 and 2 walk left off the screen (X $E0); then the script resumes.
; (C1, E-0357)
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

; Warubou leaves, step 2: object 1 walks left to $E0 while object 2 walks up to Y $20. (C1, E-0357)
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
    jr SceneWarubouLeaves_WalkObjects_CheckStepArrived

; Warubou leaves, step 1: objects 2 and 1 walk up to Y $30 and $20. (C1, E-0357)
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
    jr SceneWarubouLeaves_WalkObjects_CheckStepArrived

; Warubou leaves, step 0: object 1 walks up to Y $50 and object 2 left to X $40. (C1, E-0357)
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

; When the walk has arrived goes to the next step. (C1, E-0357)
SceneWarubouLeaves_WalkObjects_CheckStepArrived::
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

; The save screen, step 1: the script resumes. (C1, E-0357)
SaveScreen_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The save screen, step 0: keeps the screen in BG map 1 and switches to game mode 2, state $0C (the
; save menu), stopping the script. (C1, E-0357)
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
    dw SceneChestServant_WalkUp
    dw SceneChestServant_WalkUp
    dw SceneChestServant_WalkUp
    dw SceneChestServant_Warp
    dw SceneChestServant_SetScriptStartRequestTo80

; Chest servant scene, step 5: the script resumes. (C1, E-0357)
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

; Chest servant scene, step 1: walks the player up to Y $10 - 16 x wScriptParam0, then shifts in
; another field draw flag bit and counts the walk. (C1, E-0357)
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

; Chest servant scene, step 0: plays sound $65 and starts the walk. (C1, E-0357)
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
    dw SceneKamehaKeyBattle2_AfterBattle
    dw SceneWatchOut_WaitMessage
    dw SceneKamehaKeyBattle2_ShowHeroReceivedTheMagic
    dw SceneWatchOut_Resume

; Kameha's second key battle, step 3: '<hero> received the Magic Key.' (message $0BC2) or, for a
; generated key, message $0B9D. (C1, E-0357)
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

; Kameha's second key battle, step 1: a lost battle gives "Kameha: Wahahahah! You're weak! ..."
; ($0B97); after a win sets EVENT_SCENE_KAMEHA_KEY_BATTLE2 and gives the story key of kind 9 ($49
; after EVENT_KEY_BOSS_BEATEN_2_205) or, when that key is already held, a generated key; with no
; room shows message $0B9E; on success sets EVENT_HERO_RECEIVED_THE_TRAVELER_KEY with 'Kameha: That
; was a good warmup!' ($0B9C). (C1, E-0357)
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
    dw SceneKamehaKeyBattle_AfterBattle
    dw SceneWatchOut_WaitMessage
    dw SceneKamehaKeyBattle_ShowHeroReceivedTheMagic
    dw SceneWatchOut_Resume

; Kameha's key battle, step 3: '<hero> received the Magic Key.' or, for a generated key, message
; $0B93. (C1, E-0357)
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

; Kameha's key battle, step 1: a lost battle gives "Kameha: Wahahahah! ..." ($0B97); after a win
; sets EVENT_SCENE_KAMEHA_KEY_BATTLE and gives the story key of kind 7 ($47 after
; EVENT_KEY_BOSS_BEATEN_203) or a generated one; with no room message $0B94; on success sets
; EVENT_HERO_RECEIVED_THE_ELF_KEY with 'Kameha: Well, uh, luck and status ...' ($0B92). (C1, E-0357)
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
    dw SceneWatchOut_Resume

; Arena challenge, step 1: after the battle '... Aww... I lose. You are ...' ($0D82) or, when the
; player lost, '... Yay! I won! ...' ($0D83). (C1, E-0357)
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
    dw SceneTerryBattle_Start
    dw SceneTerryBattle_ShowTerryWellThisProves
    dw SceneWatchOut_Resume

; Terry's battle, step 1: after a win 'Terry: Well, this proves that I ...' ($0BB1), sets
; wLinkSetting 1 and EVENT_SCENE_TERRY_BATTLE_038; after a loss "Terry: Humph... Don't take it
; hard." ($0BB2). (C1, E-0357)
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
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_SpinRight
    dw SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_WalkObject1
    dw SceneLimboMonster2_WalkOffAndCreate

; Limbo monster 2, step 15: object 1 walks right to $C0; then creates the monster on the farm
; (record kind 3), sets EVENT_SCENE_LIMBO_MONSTER2 and resumes the script. (C1, E-0357)
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

; Limbo monster 2, step 14: object 1 walks right to X $70, then down to Y $40. (C1, E-0357)
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

; Limbo monster 2, step 12: 'Warubou: Wa-hey, my kid has a ...' (message $0BA7). (C1, E-0357)
SceneLimboMonster2_Msg0BA7_WarubouWaheyMyKid::
    ld hl, $0ba7 ; 'Warubou: Wa-hey, my kid has a'
    call StartMessageHL_B85
    ld hl, wScriptStep
    inc [hl]
    ret

; Limbo monster 2, step 9: object 2 hops for 32 frames, then message $0BA6. (C1, E-0357)
SceneLimboMonster2_ToScriptStepAdjust32TimesThenMessage_Bank85::
    ld de, wObject2 + OBJ_Y
    ld hl, $0ba6
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; Limbo monster 2, step 3: after the yes/no: yes gives 'Warubou: Wa-hey! Good, good, good! ...'
; ($0BA5) and places object 2 beside the player by its facing; no gives "Warubou: Wa-hey... That's
; cold of you." ($0D95) and back to step 1. (C1, E-0357)
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

; data read by SceneLimboMonster2 (8 bytes) (E-0347)
SceneLimboMonster2_ShowWarubouWaheyGoodGood_Data::
    db $d0, $10, $c0, $20, $d0, $30, $e0, $20

; Limbo monster 2, step 0: with a full farm 'Warubou: Wa-hey! I was thinking... GreatLog ...'
; ($0BA3); otherwise the same opening ($0BA4) and the question (step 2). (C1, E-0357)
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
    dw SceneWatchOut_Resume
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster_ShowWarubouWaheyGoodGood
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_ToScriptStepMoveFollowersToLeader
    dw SceneLimboMonster2_SpinRight
    dw SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85
    dw SceneWatchOut_WaitMessage
    dw SceneLimboMonster_SpinLeft
    dw SceneWatchOut_WaitMessage
    dw SceneWatchOut_Resume

; Limbo monster, step 12: object 2 spins and hops leftward for 64 frames (sound $65 first); then
; 'Warubou: Wa-hey, my kid has a ...' ($0B2C), creates the monster on the farm (record kind 4) and
; sets EVENT_SCENE_LIMBO_MONSTER. (C1, E-0357)
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

; Limbo monster, step 9: object 2 hops for 32 frames, then message $0B2B. (C1, E-0357)
SceneLimboMonster_ToScriptStepAdjust32TimesThenMessage_Bank85::
    ld de, wObject2 + OBJ_Y
    ld hl, $0b2b
    call ScriptStepAdjust32TimesThenMessage_Bank85
    ret

; Limbo monster 2, step 8: object 2 spins and hops rightward for 64 frames (sound $65 first, $72 at
; the end), then faces like the player. (C1, E-0357)
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

; Limbo monster 2, step 5: moves the followers to the leader. (C1, E-0357)
SceneLimboMonster2_ToScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ret

; Limbo monster, step 3: after the yes/no: yes gives 'Warubou: Wa-hey! Good, good, good! ...'
; ($0B2A) and places object 2 beside the player; no gives "... That's cold of you." and back to step
; 1. (C1, E-0357)
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

; data read by SceneLimboMonster (8 bytes) (E-0347)
SceneLimboMonster_ShowWarubouWaheyGoodGood_Data::
    db $d0, $10, $c0, $20, $d0, $30, $e0, $20

; Limbo monster, step 0: with a full farm 'Warubou: Wa-hey, I have a favor ...' ($0B28); otherwise
; the same opening ($0B29) and the question. (C1, E-0357)
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
    dw ScenePoorChurch_WalkUp
    dw ScenePoorChurch_LoadFrame
    dw ScenePoorChurch_StepFrames
    dw ScenePoorChurch_TurnRandomly

; Poor church scene, step 3: every eight frames turns a random one of four objects a random way (1
; or 3) for $3C frames; then the script resumes. (C1, E-0357)
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

; Poor church scene, step 2: steps through screen animation frames 0-5 (back to step 1 each time);
; after the last sets story flag byte $61 bit 3 and, unless EVENT_SCENE_TREASURE_THEFT is set,
; resumes the script. (C1, E-0357)
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

; Poor church scene, step 0: after the treasure theft (EVENT_SCENE_TREASURE_THEFT) objects 1, 2, 3
; and 0 walk up to Y $10, $40, $20 and $30 first; then resets the animation frame and goes on. (C1,
; E-0357)
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

; Cyal's return, step 10: the script resumes. (C1, E-0357)
SceneGiveBackCyal_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Cyal's return, step 9: shakes the screen sideways for 30 frames. (C1, E-0357)
SceneGiveBackCyal_Shake::
    ld b, $1e
    call ShakeScreenSideways
    ret

; Cyal's return, step 8: object 2 moves right four pixels a frame to X $60, then stops animating.
; (C1, E-0357)
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

; Cyal's return, step 7: object 0 faces left, after 4 frames plays sound $66 and faces down, at 8
; faces right; object 2 starts moving left (state 3). (C1, E-0357)
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

; Cyal's return, step 5: object 0 faces left and '... Humph... How boring...' (message $0737). (C1,
; E-0357)
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

; Shakes the screen sideways (hScrollX by +2 / -2 on alternate even frames) for B frames, then
; resets the scroll. (C1, E-0357)
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

; implements script command type CD (SCRIPT_SCENE_YOU_DID_IT): a cutscene step named after the scene
; its only script shows: ... 'Warubou Wa-hey! You did it, 0!'; reached through ScriptCommandCD in
; bank $10 (E-0038, E-0245)
SceneYouDidIt::
    ld a, [wScriptStep]
    jumptable
    dw SceneYouDidIt_ShowMessage
    dw SceneWatchOut_Resume

; You did it scene, step 0: looks up the map in SceneYouDidIt_ShowMessage_Data and starts its
; message (group $0C). (C1, E-0357)
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

; data read by SceneYouDidIt (25 bytes) (E-0347)
SceneYouDidIt_ShowMessage_Data::
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
    dw GrowthLimitInfo_ShowGrowthLimit
    dw SceneWatchOut_WaitMessage
    dw GrowthLimitInfo_NextMember

; Growth limit info, step 2: moves to the next party member; after the last the script resumes. (C1,
; E-0357)
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

; Growth limit info, step 0: copies the party member's name and shows '<name> has reached its growth
; limit.' (message $0A56) when its level equals MON_MAX_LEVEL, otherwise "<name>'s growth limit is
; Lv <n>." ($0A55). (C1, E-0357)
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
    dw SceneBarrel_WriteScriptParam0
    dw SceneWatchOut_WaitMessage
    dw SceneBarrel_Flicker
    dw SceneBarrel_ShowRobosterStoppedMoving
    dw SceneWatchOut_Resume

; Barrel scene, step 8: keeps the second sprite shown and '...Roboster stopped moving...' (message
; $078D). (C1, E-0357)
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

; Barrel scene, step 7: flickers between two sprites for $78 frames, switching every 2, then 4, then
; 8 frames (the flicker slows down). (C1, E-0357)
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

; Barrel scene, step 5: for $78 frames jiggles object 1's X around $40 on alternate frames. (C1,
; E-0357)
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

; Sets object 1's X to $3F, $40 or $41 at random. (C1, E-0357)
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

; Barrel scene, step 4: sets story flag $015F + the barrel number (unless it is 3); without
; EVENT_KIRAL_PLEASE_GO_STOP_HIM the script resumes; with it sets EVENT_SCENE_BARREL and shows '...
; PROFE... SOR... ORDER... MUST... OBEY...' ($0779). (C1, E-0357)
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

; data read by SceneBarrel (4 bytes) (E-0347)
SceneBarrel_StartBattle_Data::
    db $0d, $0e, $0f, $10

; Barrel scene, step 1: starts the barrel's message (SceneBarrel_ShowMessage_Data). (C1, E-0357)
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

; data read by SceneBarrel (8 bytes) (E-0347)
SceneBarrel_ShowMessage_Data::
    db $6c, $07, $6f, $07, $72, $07, $75, $07

; Barrel scene, step 0: counts which barrel this is (0-3) from EVENT_KIRAL_FETCH_ME_MY and the two
; Roboster flags. (C1, E-0357)
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
; sort flag bit 6 and resumes the script. (C1, E-0357)
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

; The Limbo scene, step 3: the item drops by the way object 0 faces (down; down-right; straight;
; down-left) along the hop curve; then hides it. (C1, E-0357)
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
; item. (C1, E-0357)
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

; The Limbo scene, step 1: the item rises along the hop curve. (C1, E-0357)
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

; data read by SceneLimbo (3 bytes) (E-0347)
SceneLimbo_PlaceItem_Data::
    db $03, $08, $0a

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

; Found me battle, step 5: sets the guard's story flag ($0201 on map $96, otherwise $00B9 + the
; screen column) and resumes the script. (C1, E-0357)
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

; Found me battle, step 4: object 0 walks off (up, or left on map $96) to $E0 and stops animating.
; (C1, E-0357)
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
; (C1, E-0357)
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
; You! I've never seen you ..." ($0473). (C1, E-0357)
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

; implements script command type 31 (SCRIPT_SCENE_PIRATE_GHOSTS): a cutscene step named after the
; scene its only script shows: 'How could we die before enjoying...' ... 'The treasures are ours';
; reached through ScriptCommand31 in bank $10 (E-0038, E-0245)
ScenePirateGhosts::
    ld a, [wScriptStep]
    jumptable
    dw ScenePirateGhosts_ReadMapId
    dw SceneWatchOut_WaitMessage
    dw ScenePirateGhosts_BlinkOut

; Pirate ghosts, step 0: on map $43 '... Check the wooden crate...' ($085D); elsewhere skips a step.
; (C1, E-0357)
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

; Pirate ghosts, step 2: blinks object 0 at Y $10, $60 or $30 (by map) for $78 frames, then removes
; the sprites and resumes the script. (C1, E-0357)
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

; implements script command type 24 (SCRIPT_SCENE_TREASURE_THEFT): a cutscene step named after the
; scene its only script shows: 'King What? Arrrrgh! Round up all...' ... 'King I apologize, but my
; treasures...'; reached through ScriptCommand24 in bank $10 (E-0038, E-0245)
SceneTreasureTheft::
    ld a, [wScriptStep]
    jumptable
    dw SceneTreasureTheft_ShowKingTheHideoutOf
    dw SceneTreasureTheft_WriteFieldDrawFlags
    dw SceneWatchOut_WaitMessage
    dw SceneTreasureTheft_TurnRandomly
    dw SceneTreasureTheft_WalkObject2
    dw SceneTreasureTheft_WriteScriptParam0
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

; Treasure theft, step 1: sets field draw flags $0E. (C1, E-0357)
SceneTreasureTheft_WriteFieldDrawFlags::
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

; data read by SceneGreatlogKey (32 bytes) (E-0347)
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

; hTemp0 = 1 when a living party member's species is in
; Talk04CB_ThatKeyIUsed_LoadSRAMRecordByte_Data, otherwise 0. (C1, E-0357)
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

; data read by RandomGoldOrItem_PickFind_RollFind (16 bytes) (E-0347)
RandomGoldOrItem_PickFind_RollFind_Data1::
    db $19, $1a, $1b, $1b, $1c, $2c, $00, $00, $01, $07, $28, $22, $0c, $2c, $00, $00

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
