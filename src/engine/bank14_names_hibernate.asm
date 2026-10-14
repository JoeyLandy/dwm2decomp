; ROM bank $14: name entry, default and suggested names, hibernation
; The annotated listing of this bank is build/listing/bank14.asm.

SECTION "Bank 14", ROMX[$4000], BANK[$14]
    db $14

; implements script command type EC (SCRIPT_HIBERNATE_CLOSE): ends the hibernation session and
; clears wMessageMode; reached through ScriptCommandEC in bank $10 (E-0038, E-0244)
CloseHibernateMenu::
    ld a, [wScreenList]
    jumptable
    dw CloseHibernateMenu_CopyBytesDEToHL_Bank14
    dw CloseHibernateMenu_LoadTileListSixPerCall
    dw CloseHibernateMenu_FillTilesBxC
    dw CloseHibernateMenu_DrawRecordListNameTiles_Bank1D

; step 0 of CloseHibernateMenu: calls CopyBytesDEToHL_Bank14; branches on wIsCGB; calls
; CopyLow3BitsToWRAMBank2_Bank14; calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; increments wScreenList (E-0347)
; why: step 0 of CloseHibernateMenu (when wScreenList = 0); CloseHibernateMenu: implements script
; command type EC (SCRIPT_HIBERNATE_CLOSE): ends the hibernation session and clears wMessageMode
; (E-0352, E-0038, E-0244)
CloseHibernateMenu_CopyBytesDEToHL_Bank14::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank14
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

.call_bg_map_address_at_scroll_bank14:
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; step 1 of CloseHibernateMenu: sets wArg1 to $9c; sets wArg2 to 0; copies D to wArg3; copies E to
; wArg4; calls LoadTileListSixPerCall; returns unless wArg5 is $ff; sets wGlyphListPos to 0; sets
; wGlyphListStart to 0; sets wScreenState to 0; sets wScreenStep to 0; sets wMenuState to 0;
; increments wScreenList; then 2 more steps (see the code) (E-0347)
; why: step 1 of CloseHibernateMenu (when wScreenList = 1); CloseHibernateMenu: implements script
; command type EC (SCRIPT_HIBERNATE_CLOSE): ends the hibernation session and clears wMessageMode
; (E-0352, E-0038, E-0244)
CloseHibernateMenu_LoadTileListSixPerCall::
    ld a, $9c
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, CloseHibernateMenu_LoadTileListSixPerCall_Data
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp $ff
    ret nz
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 2 of CloseHibernateMenu: calls FillTilesBxC; sets wTextWindowTileLo to $12; increments
; wScreenList (E-0347)
; why: step 2 of CloseHibernateMenu (when wScreenList = 2); CloseHibernateMenu: implements script
; command type EC (SCRIPT_HIBERNATE_CLOSE): ends the hibernation session and clears wMessageMode
; (E-0352, E-0038, E-0244)
CloseHibernateMenu_FillTilesBxC::
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; step 3 of CloseHibernateMenu: calls DrawRecordListNameTiles_Bank1D; sets wMessageMode to 0; sets
; wScreenList to 0; sets hSpriteHideTile to $80; calls WritePlayerNameWithFlag0SuffixToTextBuf0;
; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 3 of CloseHibernateMenu (when wScreenList = 3); CloseHibernateMenu: implements script
; command type EC (SCRIPT_HIBERNATE_CLOSE): ends the hibernation session and clears wMessageMode
; (E-0352, E-0038, E-0244)
CloseHibernateMenu_DrawRecordListNameTiles_Bank1D::
    farcall DrawRecordListNameTiles_Bank1D
    xor a
    ld [wMessageMode], a
    ld [wScreenList], a
    ld bc, $006f
    ld hl, wScreenState

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $80
    ldh [hSpriteHideTile], a
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type EB (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will
; hibernate?', 'Who should I wake up?' (mode 4, bank $1D strings); reached through ScriptCommandEB
; in bank $10 (E-0038, E-0244)
HibernateMenu::
    ld a, [wScreenState]
    jumptable
    dw HibernateMenu_CopyBytesDEToHL_Bank14
    dw HibernateMenu_SetupPartyList
    dw HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc
    dw HibernateMenu_WriteTwoChoiceCursorAndScreenStateEtc
    dw HibernateMenu_ChooseToHibernate
    dw HibernateMenu_ChooseRecords
    dw HibernateMenu_ChooseWithStats
    dw HibernateMenu_IndexListEntry
    dw HibernateMenu_SwapMonstersMenu
    dw HibernateMenu_SwapMonstersMenu
    dw HibernateMenu_SwapMonstersMenu
    dw HibernateMenu_SwapMonstersMenu

; step 0 of HibernateMenu: calls CopyBytesDEToHL_Bank14; branches on wIsCGB; calls
; CopyLow3BitsToWRAMBank2_Bank14; sets wMessageMode to 4; sets hSpriteHideTile to $70; advances
; wScreenState; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 0 of HibernateMenu (when wScreenState = 0); HibernateMenu: implements script command
; type EB (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I
; wake up?' (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_CopyBytesDEToHL_Bank14::
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_04
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

.set_message_mode_to_04:
    ld a, $04
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: the tile map, the glyph list and ListPartyRecordsWithState2ToListEntries (E-0293)
HibernateMenu_SetupPartyList::
    ld a, [wScreenStep]
    jumptable
    dw HibernateMenu_SetupPartyList_ToSetupTileMapAtBGMap1
    dw HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep
    dw HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14

; step 0 of HibernateMenu_SetupPartyList: calls SetupTileMapAtBGMap1 (E-0347)
; why: step 0 of HibernateMenu_SetupPartyList (when wScreenStep = 0); HibernateMenu_SetupPartyList:
; by wScreenStep: the tile map, the glyph list and ListPartyRecordsWithState2ToListEntries (E-0352)
HibernateMenu_SetupPartyList_ToSetupTileMapAtBGMap1::
    farcall SetupTileMapAtBGMap1
    ret

; step 1 of HibernateMenu_SetupPartyList: calls HibernateMenu_WriteGlyphListPosAndGlyphListStart;
; may return early; advances wScreenStep (E-0347)
; why: step 1 of HibernateMenu_SetupPartyList (when wScreenStep = 1); HibernateMenu_SetupPartyList:
; by wScreenStep: the tile map, the glyph list and ListPartyRecordsWithState2ToListEntries (E-0352)
HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart::
    ld hl, NamingScreenTileDestListA
    ld de, HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopySrcList
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp $ff
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; step 2 of HibernateMenu_SetupPartyList: calls ListPartyRecordsWithState2ToListEntries; increments
; wScreenStep (E-0347)
; why: step 2 of HibernateMenu_SetupPartyList (when wScreenStep = 2); HibernateMenu_SetupPartyList:
; by wScreenStep: the tile map, the glyph list and ListPartyRecordsWithState2ToListEntries (E-0352)
HibernateMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep::
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 3 of HibernateMenu_SetupPartyList: calls CopyRectTo20ByteRows_Bank14; calls
; CopyScreenBufferRectAt0280_Bank14; calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; calls CountRecordsInUse; sets wScreenStep to 0; increments
; wScreenState (E-0347)
; why: step 3 of HibernateMenu_SetupPartyList (when wScreenStep = 3); HibernateMenu_SetupPartyList:
; by wScreenStep: the tile map, the glyph list and ListPartyRecordsWithState2ToListEntries (E-0352)
HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14::
    ld de, HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank14
    call CopyScreenBufferRectAt0280_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; step 2 of HibernateMenu: branches on wJoypadPressedRepeat; branches on wJoypadPressed; calls
; HibernateMenu_WriteGridCursorY; calls HibernateMenu_ReadGridCursorX_2; branches on wGridCursorX;
; sets wGridCursorX to 3; calls HibernateMenu_WriteGridCursorY; plays sound $69; sets wGridCursorX;
; sets wListCursor to 0; sets wChoiceCursor to 0; sets wListPageIndex to 0; then 21 more steps (see
; the code) (E-0347)
; why: step 2 of HibernateMenu (when wScreenState = 2); HibernateMenu: implements script command
; type EB (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I
; wake up?' (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_hibernate_menu_read_grid_cursor_x_2
    bit 7, a
    jr nz, .call_hibernate_menu_read_grid_cursor_x_22
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_03
    call HibernateMenu_WriteGridCursorY
    ret

.call_hibernate_menu_read_grid_cursor_x_2:
    call HibernateMenu_ReadGridCursorX_2
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x
    ld a, $03
    ld [wGridCursorX], a
    call HibernateMenu_WriteGridCursorY
    ld a, $69
    call QueueSoundEffect
    ret

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call HibernateMenu_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_hibernate_menu_read_grid_cursor_x_22:
    call HibernateMenu_ReadGridCursorX_2
    ld a, [wGridCursorX]
    cp $03
    jr c, .skip
    xor a
    ld [wGridCursorX], a
    call HibernateMenu_WriteGridCursorY
    ld a, $69
    call QueueSoundEffect
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call HibernateMenu_BGMapAddressAtScroll_Bank14
    ld c, $00

.loop:
    ld a, c
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    push bc
    push hl
    call StoreBAtWordTableEntry_Bank14
    pop hl
    pop bc
    inc c
    ld a, c
    cp $04
    jr c, .loop
    ld a, [wGridCursorX]
    cp $03
    jr z, .set_two_choice_cursor_to_03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; called from HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: may continue in
; HibernateMenu_ReadGridCursorX; increments wGridCursorY; may continue in
; HibernateMenu_ReadGridCursorX; may continue in HibernateMenu_ReadGridCursorX_2; sets wGridCursorY
; to 0 (E-0347)
; why: a helper of HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, in step 2 of
; HibernateMenu (when wScreenState = 2); HibernateMenu: implements script command type EB
; (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?'
; (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_WriteGridCursorY::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, HibernateMenu_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, HibernateMenu_ReadGridCursorX
    cp $18
    jr c, HibernateMenu_ReadGridCursorX_2
    xor a
    ld [wGridCursorY], a

; called from HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: changes B; continues in
; HibernateMenu_BGMapAddressAtScroll_Bank14_ReadGridCursorX (E-0347)
; why: a helper of HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, in step 2 of
; HibernateMenu (when wScreenState = 2); HibernateMenu: implements script command type EB
; (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?'
; (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_ReadGridCursorX::
    ld b, $bb
    jr HibernateMenu_BGMapAddressAtScroll_Bank14_ReadGridCursorX

; called from HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: changes B; continues in
; HibernateMenu_BGMapAddressAtScroll_Bank14_ReadGridCursorX (E-0347)
; why: a helper of HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, in step 2 of
; HibernateMenu (when wScreenState = 2); HibernateMenu: implements script command type EB
; (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?'
; (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_ReadGridCursorX_2::
    ld b, $c3
    jr HibernateMenu_BGMapAddressAtScroll_Bank14_ReadGridCursorX

; called from HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: takes BC; changes B
; (E-0347)
; why: a helper of HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, in step 2 of
; HibernateMenu (when wScreenState = 2); HibernateMenu: implements script command type EB
; (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?'
; (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_BGMapAddressAtScroll_Bank14::
    ld b, $bc

; Calls BGMapAddressAtScroll_Bank14 (E-0347)
; why: part of HibernateMenu_BGMapAddressAtScroll_Bank14, in a helper of
; HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, in step 2 of HibernateMenu (when
; wScreenState = 2); HibernateMenu: implements script command type EB (SCRIPT_HIBERNATE): monster
; hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode ... (E-0352, E-0038,
; E-0244)
HibernateMenu_BGMapAddressAtScroll_Bank14_ReadGridCursorX::
    ld a, [wGridCursorX]
    add a
    ld hl, HibernateMenu_BGMapAddressAtScroll_Bank14_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by HibernateMenu (10 bytes) (E-0347)
HibernateMenu_BGMapAddressAtScroll_Bank14_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; step 3 of HibernateMenu: branches on wGridCursorX; may continue in
; StartRecordListOrNoneMessage_CallCountFlaggedSRAMRecords; calls ListRecordsState1NotEggs;
; increments wScreenState; branches on wListCount; calls CountFlaggedSRAMRecords; calls
; LoadRecordCapacityFromFarmLevelTable; branches on wArg5; sets wScreenStep to $1e; sets
; wTwoChoiceCursor to 0; sets wListPageIndex to 0; sets wListCursor to 0; then 50 more steps (see
; the code) (E-0347)
; why: step 3 of HibernateMenu (when wScreenState = 3); HibernateMenu: implements script command
; type EB (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I
; wake up?' (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_WriteTwoChoiceCursorAndScreenStateEtc::
    ld a, [wGridCursorX]
    and a
    jr z, .call_list_records_state1_not_eggs
    cp $01
    jp z, .call_count_flagged_sram_records
    cp $02
    jp z, StartRecordListOrNoneMessage_CallCountFlaggedSRAMRecords
    ret

.call_list_records_state1_not_eggs:
    farcall ListRecordsState1NotEggs
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, [wListCount]
    and a
    jr z, .set_two_choice_cursor_to_01
    farcall CountFlaggedSRAMRecords
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wArg5]
    cp c
    jr c, .clear_screen_step
    ld a, $1e
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wListPageIndex], a
    ld [wListCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wListPageIndex], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_count_flagged_sram_records:
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    and a
    jp z, .set_two_choice_cursor_to_03
    farcall ListRecordsInUseNotEggs
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wListCount]
    cp c
    jr nc, .set_two_choice_cursor_to_012
    ld b, a
    ld a, [wRecordsFlagged]
    cp c
    jr nc, .set_two_choice_cursor_to_02
    add b
    cp c
    jr c, .call_list_records_state1_not_eggs2
    ld a, [wPartyCount]
    cp b
    jr z, .set_two_choice_cursor_to_04

.set_two_choice_cursor_to_012:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScreenSubStep], a
    ld a, $1b
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_list_records_state1_not_eggs2:
    farcall ListRecordsState1NotEggs
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_04:
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; lists the records; with none sets wTwoChoiceCursor = 1 and wScreenState = 2, otherwise
; wScreenState += 3; then requests script $80 (the next entry does the same with
; CountFlaggedSRAMRecords) (E-0127)
StartRecordListOrNoneMessage::
    farcall ListRecordsState1NotEggs
    ld a, [wListCount]
    and a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add $03
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Calls CountFlaggedSRAMRecords; branches on wArg5; sets wTwoChoiceCursor to 1; sets wScreenState to
; 2; sets wScreenStep to 0; sets wScreenSubStep to 0; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80; sets wTwoChoiceCursor to 0; sets wScreenState; sets wScriptCommandType
; to 0; sets wScriptStartRequest to $80 (E-0347)
; why: part of StartRecordListOrNoneMessage; StartRecordListOrNoneMessage: lists the records
; (E-0352, E-0127)
StartRecordListOrNoneMessage_CallCountFlaggedSRAMRecords::
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    and a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add $04
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0288)
HibernateMenu_ChooseRecords::
    ld a, [wScreenStep]
    jumptable
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_2
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_3
    dw HibernateMenu_ChooseRecords_UnpackRecordFromBank1Slot
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_SetScreenStep
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_3
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1NotEggs
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_DrawRecordNameAndSpeciesNameTiles
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_SetMenuInputResult
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14_SetScreenStep
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_SetChoiceCursor
    dw HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14
    dw DrawBoxAndMenuAndStep
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_SetScreenStep
    dw HibernateMenu_ChooseRecords_DrawBoxAndMenuAndStep
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_2
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_SetMenuInputResult_2
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_SetListCursor
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_2
    dw HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot
    dw HibernateMenu_ChooseRecords_Multiply8
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14

; step 50 of HibernateMenu_ChooseRecords: calls DrawBoxAndMenuAndStep; calls
; ListRecordsState1NotEggs; sets wSelectedRecord; copies wListCursor to wItemGridX; copies
; wListPageIndex to wItemGridY; calls HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf; sets
; wListCursor to 0; sets wListPageIndex to 0 (E-0347)
; why: step 50 of HibernateMenu_ChooseRecords (when wScreenStep = 50); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_DrawBoxAndMenuAndStep::
    call DrawBoxAndMenuAndStep
    farcall ListRecordsState1NotEggs
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wSelectedRecord], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    ld a, [wSelectedRecord]
    ld b, a
    ld c, $00
    call HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ret

; step 60 of HibernateMenu_ChooseRecords: calls BGMapAddressAtScroll_Bank14; copies wItemGridX to
; wListCursor; copies wItemGridY to wListPageIndex; calls ListRecordsState1NotEggs; calls
; HibernateMenu_ClampRecordListPageCursor5; calls EraseFiveTableEntries; calls FillTilesBxC; sets
; wTwoChoiceCursor to 1; sets wScreenStep to $20; sets wTextWindowTileLo to $12; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 60 of HibernateMenu_ChooseRecords (when wScreenStep = 60); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_SetListCursor::
    call BGMapAddressAtScroll_Bank14
    push hl
    ld a, [wListCursor]
    add a
    ld hl, HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $bc
    ld [hl], a
    ei
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall ListRecordsState1NotEggs
    call HibernateMenu_ClampRecordListPageCursor5
    call EraseFiveTableEntries
    ld hl, vTiles1 + $240
    ld bc, $0c01
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4e0
    ld bc, $0201
    call FillTilesBxC
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $20
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by HibernateMenu (10 bytes) (E-0347)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; step 62 of HibernateMenu_ChooseRecords: calls UpdateTwoChoiceCursor_Bank1D; returns if
; wMenuInputResult is 0; branches on wMenuInputResult; branches on wTwoChoiceCursor; calls
; HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf_2; calls
; HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_4; continues in
; HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK; calls
; HibernateMenu_WriteSVBK; calls StoreBAtWordTableEntry_Bank14; sets wTwoChoiceCursor to 1; sets
; wScreenStep to $3b; sets wScreenSubStep to 0; then 2 more steps (see the code) (E-0347)
; why: step 62 of HibernateMenu_ChooseRecords (when wScreenStep = 62); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_2::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_hibernate_menu_write_svbk
    cp $ff
    jp z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .call_hibernate_menu_write_svbk
    farcall HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf_2
    call HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_4
    jp HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK

.call_hibernate_menu_write_svbk:
    call HibernateMenu_WriteSVBK
    ld a, [wListCursor]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $3b
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 63 of HibernateMenu_ChooseRecords: branches on wScreenSubStep; sets rRAMG2 to $0a; sets rRAMB
; to 0; copies wSelectedRecord to wArg1; sets rRAMG2 to 0; sets wArg2 to 0; copies L to wArg3;
; copies H to wArg4; calls PackRecordFieldsToBank1Slot; returns unless wArg5 is $ff; copies
; wSelectedRecord to wArg1; sets wArg2 to 0; then 18 more steps (see the code) (E-0347)
; why: step 63 of HibernateMenu_ChooseRecords (when wScreenStep = 63); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot::
    ld a, [wScreenSubStep]
    and a
    jp nz, .call_set_arg5_to_list_entries_cell5
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ld [wArg2], a
    ld hl, wRecordBufA
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wSelectedRecord], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_set_arg5_to_list_entries_cell5:
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp $1d
    jr z, .set_arg2_to_01
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .set_arg2

.set_arg2_to_01:
    ld hl, sRecords
    ld a, $01

.set_arg2:
    ld [wArg2], a
    push hl
    ld a, [wSelectedRecord]
    ld [wArg1], a
    pop hl
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp $ff
    ret nz
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wArg5]
    ld [wSelectedRecord], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 64 of HibernateMenu_ChooseRecords: sets rRAMG2 to $0a; branches on wSelectedRecord; sets
; rRAMB to 1; sets rRAMG2 to 0; sets wItemGridX to 0; sets wItemGridY to 0; sets wSelectedRecord to
; 0; calls ListPartyRecordsWithState2ToListEntries; calls DrawBoxAndMenuAndStep; sets wListCursor to
; 0; sets wChoiceCursor to 0; sets wListPageIndex to 0; then 2 more steps (see the code) (E-0347)
; why: step 64 of HibernateMenu_ChooseRecords (when wScreenStep = 64); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_Multiply8::
    ld a, $0a
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    cp $1d
    jr z, .skip
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $01

.skip2:
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $6f

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wSelectedRecord], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBoxAndMenuAndStep
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; step 5 of HibernateMenu_ChooseRecords: calls FillTilesBxC; sets wTextWindowTileLo to $12; advances
; wScreenStep (E-0347)
; why: step 5 of HibernateMenu_ChooseRecords (when wScreenStep = 5); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_FillTilesBxC::
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; step 7 of HibernateMenu_ChooseRecords: calls StoreBAtWordTableEntry_Bank14; calls
; BGMapAddressAtScroll_Bank14; calls DrawScreenBufferRect_Bank14; calls
; StoreBAtWordTableEntry_Bank14; increments wScreenStep (E-0347)
; why: step 7 of HibernateMenu_ChooseRecords (when wScreenStep = 7); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14::
    ld a, [wListCursor]
    ld b, $bb
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, [wListCursor]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 9 of HibernateMenu_ChooseRecords: sets wArg1 to 0; sets wArg2 to $0c; calls
; CopyScreenBufferRectWithAttrs_Bank14; increments wScreenStep (E-0347)
; why: step 9 of HibernateMenu_ChooseRecords (when wScreenStep = 9); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14::
    ld c, $0d
    ld hl, $01d4
    ld de, $0008
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 10 of HibernateMenu_ChooseRecords: calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; increments wScreenStep (E-0347)
; why: step 10 of HibernateMenu_ChooseRecords (when wScreenStep = 10); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14::
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 11 of HibernateMenu_ChooseRecords: calls HibernateMenu_WriteGlyphListPosAndGlyphListStart;
; may return early; advances wScreenStep (E-0347)
; why: step 11 of HibernateMenu_ChooseRecords (when wScreenStep = 11); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart::
    ld hl, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopyDestList
    ld de, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopySrcList
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp $ff
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; step 45 of HibernateMenu_ChooseRecords: calls HibernateMenu_WriteGlyphListPosAndGlyphListStart;
; may return early; advances wScreenStep (E-0347)
; why: step 45 of HibernateMenu_ChooseRecords (when wScreenStep = 45); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep::
    ld hl, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep_TileCopyDestList
    ld de, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep_TileCopySrcList
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp $ff
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; step 46 of HibernateMenu_ChooseRecords: calls CopyRectTo20ByteRows_Bank14; calls
; BGMapAddressAtScroll_Bank14; calls DrawScreenBufferRect_Bank14; plays sound $6c; sets
; wChoiceCursor to 0; sets wCursorBlinkAE to 0; increments wScreenStep (E-0347)
; why: step 46 of HibernateMenu_ChooseRecords (when wScreenStep = 46); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_SetChoiceCursor::
    ld de, HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_SetChoiceCursor_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wChoiceCursor], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_SetChoiceCursor_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; step 47 of HibernateMenu_ChooseRecords: branches on wJoypadPressedRepeat; branches on
; wJoypadPressed; calls BlinkCursorBlinkAE_Bank14; calls DrawBlankTileC3_Bank14; branches on
; wChoiceCursor; sets wChoiceCursor to 1; calls DrawCursorTileBB_Bank14; plays sound $69; calls
; DrawBlankTileC3_Bank14; branches on wChoiceCursor; plays sound $69; calls
; HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2; then 31 more steps (see the code)
; (E-0347)
; why: step 47 of HibernateMenu_ChooseRecords (when wScreenStep = 47); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank14
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank142
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call BlinkCursorBlinkAE_Bank14
    ret

.call_draw_blank_tile_c3_bank14:
    call DrawBlankTileC3_Bank14
    ld a, [wChoiceCursor]
    and a
    jr nz, .set_choice_cursor
    ld a, $01
    jr .set_choice_cursor2

.set_choice_cursor:
    dec a

.set_choice_cursor2:
    ld [wChoiceCursor], a
    call DrawCursorTileBB_Bank14
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_bank142:
    call DrawBlankTileC3_Bank14
    ld a, [wChoiceCursor]
    cp $01
    jr c, .skip
    xor a
    jr .set_choice_cursor2

.skip:
    inc a
    jr .set_choice_cursor2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2
    ld a, [wChoiceCursor]
    and a
    jp nz, .check_screen_state
    ld a, [wScreenState]
    cp $05
    jr z, .check_screen_step2
    cp $04
    jr z, .check_screen_step

.check_screen_step:
    ld a, [wScreenStep]
    cp $13
    jr c, .set_return_screen_state_to_04
    ld a, $04
    ld [wReturnScreenState], a
    ld a, $3f
    ld [wReturnScreenStep], a
    ld a, $09
    jp .set_screen_state

.set_return_screen_state_to_04:
    ld a, $04
    ld [wReturnScreenState], a
    ld a, $12
    ld [wReturnScreenStep], a
    ld a, $09
    jp .set_screen_state

.check_screen_step2:
    ld a, [wScreenStep]
    cp $2e
    jr c, .set_return_screen_state_to_042
    ld a, $05
    ld [wReturnScreenState], a
    ld a, $2f
    ld [wReturnScreenStep], a
    ld a, $09
    jp .set_screen_state

.set_return_screen_state_to_042:
    ld a, $04
    ld [wReturnScreenState], a
    ld a, $25
    ld [wReturnScreenStep], a
    ld a, $09

.set_screen_state:
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    farcall SaveAndHideSpriteState_Bank1E
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $04
    jr nz, .set_two_choice_cursor_to_01
    ld a, [wScreenStep]
    cp $3f
    jr nz, .set_two_choice_cursor_to_01
    call HibernateMenu_ChooseRecords_LoadRecordNameEntry0
    call HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_5

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; once the joypad repeat timer reaches $14, cycles wCursorBlinkAE through 0-$17 and draws the cursor
; tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
BlinkCursorBlinkAE_Bank14::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank14
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp $10
    jr c, DrawCursorTileBB_Bank14
    cp $18
    jr c, DrawBlankTileC3_Bank14
    xor a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_Bank14::
    ld b, $bb
    jr HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_Bank14::
    ld b, $c3
    jr HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2_ReadChoiceCursor

; called from HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14: takes BC; changes B (E-0347)
; why: a helper of HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14, in step 47 of
; HibernateMenu_ChooseRecords (when wScreenStep = 47); HibernateMenu_ChooseRecords: HibernateMenu
; screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2::
    ld b, $bc

; Calls BGMapAddressAtScroll_Bank14 (E-0347)
; why: part of HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2, in a helper of
; HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14, in step 47 of HibernateMenu_ChooseRecords
; (when wScreenStep = 47); HibernateMenu_ChooseRecords: HibernateMenu screen state 5, by
; wScreenStep: paged record lists with two-choice confirmations and UnpackRecordFromBank1Slot
; (E-0352)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2_ReadChoiceCursor::
    ld a, [wChoiceCursor]
    add a
    ld hl, HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Data_2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_2_ReadChoiceCursor (4 bytes)
; (E-0347)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Data_2::
    db $2d, $01, $6d, $01

; copies box DrawBoxAndMenuAndStep_TileRect to wWindowTileBuffer + $110, runs
; CopyScreenBufferRectWithAttrs_Bank14, blanks the cursor entry wListCursor of
; HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data and wScreenStep += 1 (E-0124)
; (E-0344: the address in its name dropped or read as the label there; was DrawBoxAndMenuAndStep)
DrawBoxAndMenuAndStep::
    ld de, DrawBoxAndMenuAndStep_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $01
    call CopyRectTo20ByteRows_Bank14
    ld c, $04
    ld hl, $028c
    ld de, $00c0
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld a, [wListCursor]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
DrawBoxAndMenuAndStep_TileRect::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; step 27 of HibernateMenu_ChooseRecords: calls CopyFromBankWaitVRAM; plays sound $6c; calls
; CopyRectTo20ByteRows_Bank14; calls StoreBAtWordTableEntry_Bank14; calls
; BGMapAddressAtScroll_Bank14; calls DrawScreenBufferRect_Bank14; increments wScreenStep; sets
; wTwoChoiceCursor to 0 (E-0347)
; why: step 27 of HibernateMenu_ChooseRecords (when wScreenStep = 27); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_SetScreenStep::
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles2 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6c
    call QueueSoundEffect
    ld de, HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_SetScreenStep_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank14
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_SetScreenStep_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ef, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; step 28 of HibernateMenu_ChooseRecords: calls UpdateTwoChoiceCursor_Bank1D; returns if
; wMenuInputResult is 0; branches on wMenuInputResult; calls
; HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_3; sets wTwoChoiceCursor to 1; sets
; wScreenState to 1; sets wScreenStep to 3; sets wScreenSubStep to 0; sets wScriptCommandType to 0;
; sets wScriptStartRequest to $80; branches on wTwoChoiceCursor; calls
; HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_3; then 4 more steps (see the code)
; (E-0347)
; why: step 28 of HibernateMenu_ChooseRecords (when wScreenStep = 28); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_3::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    call HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_3
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $01
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    call HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_3
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; called from HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_3: calls
; HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14; branches on wIsCGB; sets rSVBK; calls
; HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14; sets rSVBK; calls BGMapAddressAtScroll_Bank14;
; calls DrawScreenBufferRect_Bank14 (E-0347)
; why: a helper of HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_3, in step 28 of
; HibernateMenu_ChooseRecords (when wScreenStep = 28); HibernateMenu_ChooseRecords: HibernateMenu
; screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_3::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $00
    call HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank14
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank14:
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ret

; Calls CopyBytesDEToHL_Bank14; may continue in HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14
; (E-0347)
; why: part of HibernateMenu_ChooseRecords; HibernateMenu_ChooseRecords: HibernateMenu screen state
; 5, by wScreenStep: paged record lists with two-choice confirmations and UnpackRecordFromBank1Slot
; (E-0352)
HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14::
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank14
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp $05
    jr c, HibernateMenu_ChooseRecords_CopyBytesDEToHL_Bank14
    ret

; step 0 of HibernateMenu_ChooseRecords: calls CopyRectTo20ByteRows_Bank14; calls
; BGMapAddressAtScroll_Bank14; calls DrawScreenBufferRect_Bank14; sets wListPageIndex to 0; sets
; wCursorBlinkAE to 0; increments wScreenStep (E-0347)
; why: step 0 of HibernateMenu_ChooseRecords (when wScreenStep = 0); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14::
    ld de, HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank14
    ld de, HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_TileRect_2
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    xor a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 10 x 9 tiles, one row per line
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 8 x 11 tiles, one row per line
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_TileRect_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

; clears four tile rows (vTiles1 + $240, $500, $700, $4E0), copies rectangle
; ClearTilesAndDrawRectAndStep_TileRect to wWindowTileBuffer + $64 and wScreenStep += 1 (E-0124)
; (E-0344: the address in its name dropped or read as the label there; was
; ClearTilesAndDrawRectAndStep)
ClearTilesAndDrawRectAndStep::
    ld hl, vTiles1 + $240
    ld bc, $0c01
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4e0
    ld bc, $0201
    call FillTilesBxC
    ld de, ClearTilesAndDrawRectAndStep_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 31 of HibernateMenu_ChooseRecords: calls ListRecordsState1NotEggs; continues in
; HibernateMenu_ClampRecordListPageCursor5 (E-0347)
; why: step 31 of HibernateMenu_ChooseRecords (when wScreenStep = 31); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_ListRecordsState1NotEggs::
    farcall ListRecordsState1NotEggs
    jr HibernateMenu_ClampRecordListPageCursor5
    db $21, $2d, $5f, $06, $1d, $d7

; Calls ClampRecordListPageCursor5; branches on wListPages; calls DrawC5BEC6AtScrollOffsetDE_Bank14;
; calls StoreC5BEC6AtHLStride2_Bank14; copies D to wArg1; copies E to wArg2; calls
; DrawPageOfPagesAtScrollOffset; copies H to wArg1; copies L to wArg2; calls
; DrawPageOfPagesAtArg1_Bank1E; increments wScreenStep (E-0347)
; why: part of HibernateMenu; HibernateMenu: implements script command type EB (SCRIPT_HIBERNATE):
; monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode ... (E-0352,
; E-0038, E-0244)
HibernateMenu_ClampRecordListPageCursor5::
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank14
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank14
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12f
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 32 of HibernateMenu_ChooseRecords: calls DrawRecordListPageNames (E-0347)
; why: step 32 of HibernateMenu_ChooseRecords (when wScreenStep = 32); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_ToDrawRecordListPageNames::
    farcall DrawRecordListPageNames
    ret

; step 33 of HibernateMenu_ChooseRecords: calls SetArg5ToListEntriesCell5; calls
; LoadFamilyIconTileForRecordB_Bank14; calls CopyRectTo20ByteRows_Bank14; sets wArg1; calls
; DrawRecordStatsBoxForArg1; increments wScreenStep (E-0347)
; why: step 33 of HibernateMenu_ChooseRecords (when wScreenStep = 33); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank14
    ld de, HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 35 of HibernateMenu_ChooseRecords: calls SetArg5ToListEntriesCell5; sets wArg1; calls
; DrawRecordNameAndSpeciesNameTiles; increments wScreenStep (E-0347)
; why: step 35 of HibernateMenu_ChooseRecords (when wScreenStep = 35); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_DrawRecordNameAndSpeciesNameTiles::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 37 of HibernateMenu_ChooseRecords: sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; increments
; wScreenStep; sets wScreenStep; sets wTwoChoiceCursor to 0; calls StoreBAtWordTableEntry_Bank14;
; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; sets wScriptStartRequest to $80; then
; 1 more step (see the code) (E-0347)
; why: step 37 of HibernateMenu_ChooseRecords (when wScreenStep = 37); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UpdatePagedListCursor_SetMenuInputResult::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fd
    jr z, .read_screen_step3
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .read_screen_step2
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $07
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add $08
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step3:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

; step 13 of HibernateMenu_ChooseRecords: calls HibernateMenu_WriteGlyphListPosAndGlyphListStart;
; may return early; increments wScreenStep (E-0347)
; why: step 13 of HibernateMenu_ChooseRecords (when wScreenStep = 13); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_WriteScreenStep::
    ld hl, HibernateMenu_ChooseRecords_WriteScreenStep_TileCopyDestList
    ld de, HibernateMenu_ChooseRecords_WriteScreenStep_TileCopySrcList
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp $ff
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 14 of HibernateMenu_ChooseRecords: calls DrawRecordListNameTiles_Bank1D; calls
; ListPartyRecordsWithState2ToListEntries; increments wScreenStep (E-0347)
; why: step 14 of HibernateMenu_ChooseRecords (when wScreenStep = 14); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D::
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 44 of HibernateMenu_ChooseRecords: calls CopyRectTo20ByteRows_Bank14; calls
; CopyScreenBufferRectAt0280_Bank14; calls StoreBAtWordTableEntry_Bank14; calls
; BGMapAddressAtScroll_Bank14; calls DrawScreenBufferRect_Bank14; calls CountRecordsInUse; sets
; wScreenStep to $1b; sets wTwoChoiceCursor to 1; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 44 of HibernateMenu_ChooseRecords (when wScreenStep = 44); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14_SetScreenStep::
    ld de, HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank14
    call CopyScreenBufferRectAt0280_Bank14
    ld a, [wGridCursorX]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    ld a, $1b
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 49 of HibernateMenu_ChooseRecords: calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; sets wScreenStep to $25; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 49 of HibernateMenu_ChooseRecords (when wScreenStep = 49); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_SetScreenStep::
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, $25
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 15 of HibernateMenu_ChooseRecords: calls CopyRectTo20ByteRows_Bank14; calls
; CopyScreenBufferRectAt0280_Bank14; calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; calls CountRecordsInUse; sets wScreenStep to 0; sets wScreenState to
; 2; sets wTwoChoiceCursor to 1; sets wScriptCommandType to 0; sets wScriptStartRequest to $80
; (E-0347)
; why: step 15 of HibernateMenu_ChooseRecords (when wScreenStep = 15); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14::
    ld de, HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank14
    call CopyScreenBufferRectAt0280_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    xor a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; screen state 4, reached from menu option 0: the list of farm records that are not eggs
; (ListRecordsState1NotEggs) after a capacity check; the script asks Which monster will hibernate?
; (E-0302)
HibernateMenu_ChooseToHibernate::
    ld a, [wScreenStep]
    jumptable
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1NotEggs
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_DrawRecordNameAndSpeciesNameTiles
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_SetMenuInputResult
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_SetChoiceCursor
    dw HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14
    dw DrawBoxAndMenuAndStep
    dw HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_SetScreenStep
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_3
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_2
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseToHibernate_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D
    dw HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_SetScreenStep
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1NotEggs
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_DrawRecordNameAndSpeciesNameTiles
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_SetMenuInputResult_2
    dw HibernateMenu_ChooseToHibernate_WriteListCursorAndListPageIndexEtc
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_SetChoiceCursor
    dw HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14
    dw DrawBoxAndMenuAndStep
    dw HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14_SetScreenStep
    dw HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_SetArg1
    dw HibernateMenu_ChooseToHibernate_Multiply8
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14

; step 2 of HibernateMenu_ChooseRecords: calls HibernateMenu_WriteListCountAndRAMG2Etc; continues in
; HibernateMenu_ClampRecordListPageCursor5 (E-0347)
; why: step 2 of HibernateMenu_ChooseRecords (when wScreenStep = 2); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc::
    farcall HibernateMenu_WriteListCountAndRAMG2Etc
    jp HibernateMenu_ClampRecordListPageCursor5

; step 3 of HibernateMenu_ChooseRecords: calls HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc_2
; (E-0347)
; why: step 3 of HibernateMenu_ChooseRecords (when wScreenStep = 3); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc::
    farcall HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc_2
    ret

; step 4 of HibernateMenu_ChooseRecords: calls SetArg5ToListEntriesCell5; sets wArg1; calls
; LoadFamilyIconTileForArg1Record; calls CopyRectTo20ByteRows_Bank14; sets wArg1; calls
; HibernateMenu_ChooseRecords_RecordAddressWithBank1Slot1D; increments wScreenStep (E-0347)
; why: step 4 of HibernateMenu_ChooseRecords (when wScreenStep = 4); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld [wArg1], a
    farcall LoadFamilyIconTileForArg1Record
    ld de, HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wArg1], a
    farcall HibernateMenu_ChooseRecords_RecordAddressWithBank1Slot1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 6 of HibernateMenu_ChooseRecords: calls SetArg5ToListEntriesCell5; sets wArg1; calls
; HibernateMenu_ChooseRecords_RecordAddressWithBank1Slot1D_2; increments wScreenStep (E-0347)
; why: step 6 of HibernateMenu_ChooseRecords (when wScreenStep = 6); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_2::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall HibernateMenu_ChooseRecords_RecordAddressWithBank1Slot1D_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 49 of HibernateMenu_ChooseToHibernate: calls UpdateTwoChoiceCursor_Bank1D; returns if
; wMenuInputResult is 0; branches on wMenuInputResult; calls StoreBAtWordTableEntry_Bank14; calls
; HibernateMenu_WriteSVBK; sets wTwoChoiceCursor to 1; sets wScreenStep to $28; sets wScreenSubStep
; to 0; sets wScriptCommandType to 0; sets wScriptStartRequest to $80; branches on wTwoChoiceCursor
; (E-0347)
; why: step 49 of HibernateMenu_ChooseToHibernate (when wScreenStep = 49);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    ld a, [wListCursor]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call HibernateMenu_WriteSVBK
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $28
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop

; Calls HibernateMenu_WriteSVBK; increments wScreenStep; sets wScreenSubStep to 0; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
; why: part of HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D, in step 49 of
; HibernateMenu_ChooseToHibernate (when wScreenStep = 49); HibernateMenu_ChooseToHibernate: screen
; state 4, reached from menu option 0: the list of farm records that are not eggs
; (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK::
    call HibernateMenu_WriteSVBK
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Calls HibernateMenu_CopyBytesDEToHL_Bank14_2; branches on wIsCGB; sets rSVBK; calls
; HibernateMenu_CopyBytesDEToHL_Bank14_2; sets rSVBK; calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; calls CopyFromBankWaitVRAM (E-0347)
; why: part of HibernateMenu; HibernateMenu: implements script command type EB (SCRIPT_HIBERNATE):
; monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode ... (E-0352,
; E-0038, E-0244)
HibernateMenu_WriteSVBK::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $00
    call HibernateMenu_CopyBytesDEToHL_Bank14_2
    ld hl, wWindowTileBuffer + $112
    ld de, HibernateMenu_WriteSVBK_Data1
    ld c, $04
    call HibernateMenu_CopyBytesDEToHL_Bank14_2
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank14
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call HibernateMenu_CopyBytesDEToHL_Bank14_2
    ld hl, wWindowAttrBuffer + $112
    ld de, HibernateMenu_WriteSVBK_Data2
    ld c, $04
    call HibernateMenu_CopyBytesDEToHL_Bank14_2
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank14:
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld de, Tiles2Plus210Tiles
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_2
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; data read by HibernateMenu_WriteSVBK (6 bytes) (E-0347)
HibernateMenu_WriteSVBK_Data1::
    db $b4, $b4, $b4, $b4, $b4, $b5

HibernateMenu_WriteSVBK_Data2::
    db $00, $00, $00, $00, $00, $00

; Calls CopyBytesDEToHL_Bank14; may continue in HibernateMenu_CopyBytesDEToHL_Bank14_2 (E-0347)
; why: part of HibernateMenu_CopyBytesDEToHL_Bank14, in step 0 of HibernateMenu (when wScreenState =
; 0); HibernateMenu: implements script command type EB (SCRIPT_HIBERNATE): monster hibernation:
; 'Which monster will hibernate?', 'Who should I wake up?' (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_CopyBytesDEToHL_Bank14_2::
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank14
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp $05
    jr c, HibernateMenu_CopyBytesDEToHL_Bank14_2
    ret

; step 16 of HibernateMenu_ChooseRecords: calls CopyFromBankWaitVRAM; plays sound $6c; calls
; CopyRectTo20ByteRows_Bank14; calls CopyFromBankWaitVRAM; calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; increments wScreenStep; sets wTwoChoiceCursor to 0 (E-0347)
; why: step 16 of HibernateMenu_ChooseRecords (when wScreenStep = 16); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM::
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles2 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6c
    call QueueSoundEffect
    ld de, HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank14
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; step 60 of HibernateMenu_ChooseToHibernate: copies wItemGridX to wListCursor; copies wItemGridY to
; wListPageIndex; calls HibernateMenu_WriteListCountAndRAMG2Etc; calls
; HibernateMenu_ClampRecordListPageCursor5; sets wTwoChoiceCursor to 1; sets wScreenStep to $20;
; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; sets wScriptStartRequest to $80
; (E-0347)
; why: step 60 of HibernateMenu_ChooseToHibernate (when wScreenStep = 60);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_WriteListCursorAndListPageIndexEtc::
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall HibernateMenu_WriteListCountAndRAMG2Etc
    call HibernateMenu_ClampRecordListPageCursor5
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $20
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 18 of HibernateMenu_ChooseRecords: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; SetArg5ToListEntriesCell5; sets wArg2 to 1; copies L to wArg3; copies H to wArg4; branches on the
; byte at sRecords; branches on C; sets rRAMG2 to 0; increments wScreenStep; sets wScriptCommandType
; to 0; sets wScriptStartRequest to $80; then 7 more steps (see the code) (E-0347)
; why: step 18 of HibernateMenu_ChooseRecords (when wScreenStep = 18); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_3::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp $1d
    jr nc, .set_arg2_to_01
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .set_arg2

.set_arg2_to_01:
    ld hl, sRecords
    ld a, $01

.set_arg2:
    ld [wArg2], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    ld hl, sRecords
    ld c, $00

.loop:
    ld a, [hl]
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip
    jr .set_arg1

.skip:
    ld a, $a5
    add_a_to_hl
    inc c
    ld a, c
    cp $1e
    jr c, .loop
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_arg1:
    ld a, c
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ld a, [wArg1]
    ld [wListEntries2], a
    ld a, [wArg2]
    ld [wMenuWordBuf], a
    ld a, [wArg3]
    ld [wMenuWordBuf1], a
    ld a, [wArg4]
    ld [wMenuWordBuf2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 19 of HibernateMenu_ChooseRecords: copies wListEntries2 to wArg1; copies wMenuWordBuf to
; wArg2; copies wMenuWordBuf1 to wArg3; copies wMenuWordBuf2 to wArg4; calls
; UnpackRecordFromBank1Slot; returns unless wArg5 is $ff; sets rRAMG2 to $0a; copies wMenuWordBuf to
; rRAMB; branches on wArg5; sets rRAMG2 to 0; calls SetArg5ToListEntriesCell5; sets wArg1; then 5
; more steps (see the code) (E-0347)
; why: step 19 of HibernateMenu_ChooseRecords (when wScreenStep = 19); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UnpackRecordFromBank1Slot::
    ld a, [wListEntries2]
    ld [wArg1], a
    ld a, [wMenuWordBuf]
    ld [wArg2], a
    ld a, [wMenuWordBuf1]
    ld [wArg3], a
    ld a, [wMenuWordBuf2]
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, $0a
    ld [rRAMG2], a
    ld a, [wMenuWordBuf]
    ld [rRAMB], a
    ld a, [wMenuWordBuf1]
    ld l, a
    ld a, [wMenuWordBuf2]
    ld h, a
    ld b, $6f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 20 of HibernateMenu_ChooseToHibernate: calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; sets wScreenStep to 8; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 20 of HibernateMenu_ChooseToHibernate (when wScreenStep = 20);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14::
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, $08
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 21 of HibernateMenu_ChooseToHibernate: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; SetArg5ToListEntriesCell5; calls HibernateMenu_ChooseToHibernate_WriteRAMBAndArg6Etc; sets rRAMG2
; to 0; increments wScreenStep; sets rRAMG2 to 0; increments wScreenStep; calls
; ListPartyRecordsWithState2ToListEntries; calls DrawBoxAndMenuAndStep; sets wListCursor to 0; sets
; wChoiceCursor to 0; then 3 more steps (see the code) (E-0347)
; why: step 21 of HibernateMenu_ChooseToHibernate (when wScreenStep = 21);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    push hl
    call HibernateMenu_ChooseToHibernate_WriteRAMBAndArg6Etc
    pop hl
    cp $ff
    jr z, .check_screen_step
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_screen_step:
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBoxAndMenuAndStep
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; step 22 of HibernateMenu_ChooseToHibernate: copies wArg5 to wArg2; copies wArg6 to wArg3; copies
; wArg7 to wArg4; copies the byte at wListEntries to wArg1; calls PackRecordFieldsToBank1Slot;
; returns unless wArg5 is $ff; sets rRAMG2 to $0a; sets rRAMB to 0; calls SetArg5ToListEntriesCell5;
; copies the byte at wListEntries to wArg1; sets rRAMG2 to 0; sets wArg2 to 0; then 8 more steps
; (see the code) (E-0347)
; why: step 22 of HibernateMenu_ChooseToHibernate (when wScreenStep = 22);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot::
    ld a, [wArg5]
    ld [wArg2], a
    ld a, [wArg6]
    ld [wArg3], a
    ld a, [wArg7]
    ld [wArg4], a
    ld a, [wListPageIndex]
    ld b, a
    add a
    add a
    add b
    ld b, a
    ld a, [wListCursor]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBoxAndMenuAndStep
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; step 8 of HibernateMenu_ChooseRecords: sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; calls
; ClearTilesAndDrawRectAndStep; sets wScreenStep; sets wTwoChoiceCursor to 1; increments
; wScreenStep; sets wScriptCommandType to 0; sets wScriptStartRequest to $80; calls
; EraseFiveTableEntries; calls StoreBAtWordTableEntry_Bank14; then 4 more steps (see the code)
; (E-0347)
; why: step 8 of HibernateMenu_ChooseRecords (when wScreenStep = 8); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UpdatePagedListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .call_clear_tiles_and_draw_rect_and_step
    cp $fc
    jr z, .call_clear_tiles_and_draw_rect_and_step
    cp $fd
    jr z, .read_screen_step
    cp $fe
    jr z, .set_two_choice_cursor_to_01
    cp $ff
    jr z, .call_erase_five_table_entries
    ret

.call_clear_tiles_and_draw_rect_and_step:
    call ClearTilesAndDrawRectAndStep
    ld a, [wScreenStep]
    sub $07
    ld [wScreenStep], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_erase_five_table_entries:
    call EraseFiveTableEntries
    ld a, [wListCursor]
    ld b, $bc
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $08
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 47 of HibernateMenu_ChooseToHibernate: calls CopyRectTo20ByteRows_Bank14; calls
; CopyScreenBufferRectAt0280_Bank14; calls StoreBAtWordTableEntry_Bank14; calls
; BGMapAddressAtScroll_Bank14; calls DrawScreenBufferRect_Bank14; calls CountRecordsInUse; sets
; wScreenStep to $1e; sets wTwoChoiceCursor to 1; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 47 of HibernateMenu_ChooseToHibernate (when wScreenStep = 47);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_CopyScreenBufferRectAt0280_Bank14::
    ld de, HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank14
    call CopyScreenBufferRectAt0280_Bank14
    ld a, [wGridCursorX]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    ld a, $1e
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 50 of HibernateMenu_ChooseToHibernate: calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; increments wScreenStep; copies wListCursor to wItemGridX; calls
; SetArg5ToListEntriesCell5; sets wSelectedRecord; copies wListPageIndex to wItemGridY; sets
; wListCursor to 0; sets wListPageIndex to 0; calls ListRecordsState1NotEggs; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
; why: step 50 of HibernateMenu_ChooseToHibernate (when wScreenStep = 50);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_SetScreenStep::
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wSelectedRecord], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    farcall ListRecordsState1NotEggs
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 59 of HibernateMenu_ChooseRecords: sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; increments
; wScreenStep; branches on wScreenState; sets wTwoChoiceCursor to 1; sets wScriptCommandType to 0;
; sets wScriptStartRequest to $80; calls StoreBAtWordTableEntry_Bank14; increments wScreenStep; then
; 6 more steps (see the code) (E-0347)
; why: step 59 of HibernateMenu_ChooseRecords (when wScreenStep = 59); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UpdatePagedListCursor_SetMenuInputResult_2::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fd
    jr z, .read_screen_step2
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .check_screen_step2
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $07
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wScreenState]
    cp $04
    jr z, .read_list_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ret

.check_screen_step2:
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

; step 65 of HibernateMenu_ChooseToHibernate: calls BGMapAddressAtScroll_Bank14; calls
; DrawScreenBufferRect_Bank14; sets wScreenStep to $3b; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
; why: step 65 of HibernateMenu_ChooseToHibernate (when wScreenStep = 65);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14_SetScreenStep::
    call BGMapAddressAtScroll_Bank14
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank14
    ld a, $3b
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 66 of HibernateMenu_ChooseToHibernate: branches on wScreenSubStep; sets rRAMG2 to $0a; sets
; rRAMB to 0; calls SetArg5ToListEntriesCell5; sets wArg1; sets rRAMG2 to 0; sets wArg2 to 0; copies
; L to wArg3; copies H to wArg4; calls PackRecordFieldsToBank1Slot; branches on wArg5; sets wArg1;
; then 16 more steps (see the code) (E-0347)
; why: step 66 of HibernateMenu_ChooseToHibernate (when wScreenStep = 66);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_SetArg1::
    ld a, [wScreenSubStep]
    and a
    jp nz, .check_selected_record
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push af
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ld [wArg2], a
    ld hl, wRecordBufA
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp $ff
    jr z, .set_arg1
    pop af
    ret

.set_arg1:
    pop af
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_selected_record:
    ld a, [wSelectedRecord]
    cp $1d
    jr z, .set_arg2_to_01
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .set_arg2

.set_arg2_to_01:
    ld hl, sRecords
    ld a, $01

.set_arg2:
    ld [wArg2], a
    push hl
    pop hl
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wArg5]
    ld [wSelectedRecord], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 67 of HibernateMenu_ChooseToHibernate: sets rRAMG2 to $0a; branches on wSelectedRecord; sets
; rRAMB to 1; sets rRAMG2 to 0; sets wItemGridX to 0; sets wItemGridY to 0; sets wSelectedRecord to
; 0; calls ListPartyRecordsWithState2ToListEntries; calls DrawBoxAndMenuAndStep; sets wListCursor to
; 0; sets wChoiceCursor to 0; sets wListPageIndex to 0; then 2 more steps (see the code) (E-0347)
; why: step 67 of HibernateMenu_ChooseToHibernate (when wScreenStep = 67);
; HibernateMenu_ChooseToHibernate: screen state 4, reached from menu option 0: the list of farm
; records that are not eggs (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_Multiply8::
    ld a, $0a
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    cp $1d
    jr z, .skip
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $01

.skip2:
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $6f

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wSelectedRecord], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBoxAndMenuAndStep
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; screen state 6: a paged record list that marks party members (MarkPartyMembersInRecordListPage)
; and shows a stats box (DrawRecordStatsBoxForArg1) (E-0304)
HibernateMenu_ChooseWithStats::
    ld a, [wScreenStep]
    jumptable
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1NotEggs
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_DrawRecordNameAndSpeciesNameTiles
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseWithStats_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseWithStats_SaveAndHideSpriteState_Bank1E

; step 4 of HibernateMenu_ChooseWithStats: calls SetArg5ToListEntriesCell5; calls
; LoadFamilyIconTileForRecordB_Bank14; calls CopyRectTo20ByteRows_Bank14; sets wArg1 to 0; calls
; MarkPartyMembersInRecordListPage; calls SetArg5ToListEntriesCell5; copies the byte at
; wWindowTileBuffer + $6c to wArg1; calls DrawRecordStatsBoxForArg1; increments wScreenStep (E-0347)
; why: step 4 of HibernateMenu_ChooseWithStats (when wScreenStep = 4);
; HibernateMenu_ChooseWithStats: screen state 6: a paged record list that marks party members
; (MarkPartyMembersInRecordListPage) and shows a stats box ... (E-0352)
HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank14
    ld de, HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank14
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 8 of HibernateMenu_ChooseWithStats: sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; increments
; wScreenStep; sets wScreenStep; sets wTwoChoiceCursor to 0; calls StoreBAtWordTableEntry_Bank14;
; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; sets wScriptStartRequest to $80; then
; 1 more step (see the code) (E-0347)
; why: step 8 of HibernateMenu_ChooseWithStats (when wScreenStep = 8);
; HibernateMenu_ChooseWithStats: screen state 6: a paged record list that marks party members
; (MarkPartyMembersInRecordListPage) and shows a stats box ... (E-0352)
HibernateMenu_ChooseWithStats_UpdatePagedListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fd
    jr z, .read_screen_step3
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .read_screen_step2
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $07
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add $08
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step3:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

; runs CopyScreenBufferRectWithAttrs_Bank14 (C = 9, HL = $01D4, DE = 8, wArg1/2 = 0/$0C), copies the
; 11 x 1 rectangle DrawBox1D4AndCopyRect_TileRect to wWindowTileBuffer + $10D and wScreenStep += 1
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; DrawBox1D4AndCopyRect)
DrawBox1D4AndCopyRect::
    ld c, $09
    ld hl, $01d4
    ld de, $0008
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld de, DrawBox1D4AndCopyRect_TileRect
    ld hl, wWindowTileBuffer + $10d
    lb bc, $0b, $01
    call CopyRectTo20ByteRows_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 11 x 1 tiles, one row per line
DrawBox1D4AndCopyRect_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0

; step 16 of HibernateMenu_ChooseWithStats: calls HibernateMenu_WriteGlyphListPosAndGlyphListStart;
; may return early; sets wReturnScreenState to 6; sets wReturnScreenStep to 8; sets wScreenStep to
; 0; sets wScreenSubStep to 0; sets wScreenState to 9; calls SaveAndHideSpriteState_Bank1E (E-0347)
; why: step 16 of HibernateMenu_ChooseWithStats (when wScreenStep = 16);
; HibernateMenu_ChooseWithStats: screen state 6: a paged record list that marks party members
; (MarkPartyMembersInRecordListPage) and shows a stats box ... (E-0352)
HibernateMenu_ChooseWithStats_SaveAndHideSpriteState_Bank1E::
    ld hl, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep_TileCopyDestList
    ld de, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep_TileCopySrcList
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp $ff
    ret nz
    ld a, $06
    ld [wReturnScreenState], a
    ld a, $08
    ld [wReturnScreenStep], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $09
    ld [wScreenState], a
    farcall SaveAndHideSpriteState_Bank1E
    ret

; screen state 7: takes the chosen list entry (SetArg5ToListEntriesCell5) and computes its index
; (Multiply8) (E-0304)
HibernateMenu_IndexListEntry::
    ld a, [wScreenStep]
    jumptable
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRectAndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_WriteRAMG2AndRAMBEtc
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_2
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D
    dw HibernateMenu_IndexListEntry_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectAt0280_Bank14

; step 17 of HibernateMenu_ChooseRecords: calls UpdateTwoChoiceCursor_Bank1D; returns if
; wMenuInputResult is 0; branches on wMenuInputResult; branches on wTwoChoiceCursor; calls
; HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_4; continues in
; HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK; calls
; HibernateMenu_WriteSVBK; calls StoreBAtWordTableEntry_Bank14; sets wTwoChoiceCursor to 1; sets
; wScreenStep to 8; sets wScreenSubStep to 0; sets wScriptCommandType to 0; then 1 more step (see
; the code) (E-0347)
; why: step 17 of HibernateMenu_ChooseRecords (when wScreenStep = 17); HibernateMenu_ChooseRecords:
; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_hibernate_menu_write_svbk
    cp $ff
    jp z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .call_hibernate_menu_write_svbk
    call HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_4
    jp HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK

.call_hibernate_menu_write_svbk:
    call HibernateMenu_WriteSVBK
    ld a, [wListCursor]
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $08
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 18 of HibernateMenu_IndexListEntry: sets rRAMG2 to $0a; calls SetArg5ToListEntriesCell5; sets
; rRAMB to 1; sets rRAMG2 to 0; calls SetArg5ToListEntriesCell5; copies the byte at sRecords to
; wArg1; sets wArg2 to 0; calls HibernateMenu_Multiply8; increments wScreenStep (E-0347)
; why: step 18 of HibernateMenu_IndexListEntry (when wScreenStep = 18);
; HibernateMenu_IndexListEntry: screen state 7: takes the chosen list entry
; (SetArg5ToListEntriesCell5) and computes its index (Multiply8) (E-0352)
HibernateMenu_IndexListEntry_SetArg5ToListEntriesCell5::
    ld a, $0a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp $1d
    jr z, .skip
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $01

.skip2:
    ld [rRAMB], a
    ld b, $6f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 8 of HibernateMenu: sets wAreaGraphicsIndex to 1; calls SwapMonstersMenu (E-0347)
; why: step 8 of HibernateMenu (when wScreenState = 8); HibernateMenu: implements script command
; type EB (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I
; wake up?' (mode ... (E-0352, E-0038, E-0244)
HibernateMenu_SwapMonstersMenu::
    ld a, $01
    ld [wAreaGraphicsIndex], a
    farcall SwapMonstersMenu
    ret

; called from HibernateMenu_ChooseRecords_DrawBoxAndMenuAndStep: sets rRAMG2 to $0a; sets rRAMB to
; 0; calls CopyRecordNameToNameGlyphBuf; sets rRAMG2 to 0; branches on the byte at wNameGlyphBuf;
; branches on C (E-0347)
; why: a helper of HibernateMenu_ChooseRecords_DrawBoxAndMenuAndStep, in step 50 of
; HibernateMenu_ChooseRecords (when wScreenStep = 50); HibernateMenu_ChooseRecords: HibernateMenu
; screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_CopyRecordNameToNameGlyphBuf::
    push bc
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    xor a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    pop bc
    ld a, c
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; Calls SetArg5ToListEntriesCell5; sets wArg2 to 1; copies L to wArg3; copies H to wArg4; sets wArg1
; to 0; calls LoadRecordNameEntry0; branches on the byte at wNameGlyphBuf; branches on C; returns if
; wTextBuf1 is below $e0; sets wTextBuf1 to $f0 (E-0347)
; why: part of HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5, in step 4 of
; HibernateMenu_ChooseRecords (when wScreenStep = 4); HibernateMenu_ChooseRecords: HibernateMenu
; screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_4::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp $1d
    jr z, .set_arg2_to_01
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .set_arg2

.set_arg2_to_01:
    ld hl, sRecords
    ld a, $01

.set_arg2:
    ld [wArg2], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    xor a
    ld [wArg1], a
    farcall LoadRecordNameEntry0
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .check_text_buf1
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.check_text_buf1:
    ld a, $f0
    ld [de], a
    ld a, [wTextBuf1]
    cp $e0
    ret c
    ld a, $f0
    ld [wTextBuf1], a
    ret

; called from HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14: calls
; SetArg5ToListEntriesCell5; sets rRAMG2 to $0a; sets rRAMB to 0; calls
; CopyRecordNameToNameGlyphBuf; sets rRAMG2 to 0; branches on the byte at wNameGlyphBuf; branches on
; C (E-0347)
; why: a helper of HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14, in step 47 of
; HibernateMenu_ChooseRecords (when wScreenStep = 47); HibernateMenu_ChooseRecords: HibernateMenu
; screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_5::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    xor a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; called from HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14: branches on wSelectedRecord;
; sets wArg2 to 1; copies L to wArg3; copies H to wArg4; sets wArg1 to 0; calls
; LoadRecordNameEntry0; branches on the byte at wNameGlyphBuf; branches on C; returns if wTextBuf0
; is below $e0 (E-0347)
; why: a helper of HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14, in step 47 of
; HibernateMenu_ChooseRecords (when wScreenStep = 47); HibernateMenu_ChooseRecords: HibernateMenu
; screen state 5, by wScreenStep: paged record lists with two-choice confirmations and
; UnpackRecordFromBank1Slot (E-0352)
HibernateMenu_ChooseRecords_LoadRecordNameEntry0::
    ld a, [wSelectedRecord]
    cp $1d
    jr z, .set_arg2_to_01
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    jr .set_arg2

.set_arg2_to_01:
    ld hl, sRecords
    ld a, $01

.set_arg2:
    ld [wArg2], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    xor a
    ld [wArg1], a
    farcall LoadRecordNameEntry0
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .check_text_buf0
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.check_text_buf0:
    ld a, $f0
    ld [de], a
    ld a, [wTextBuf0]
    cp $e0
    ret c
    ld a, $f0
    ld [wTextBuf0 + $2], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank14::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank14
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks) (E-0351)
CopyLow3BitsToWRAMBank2_Bank14::
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and $07
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    xor a
    ldh [rSVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0351)
BGMapAddressAtScroll_Bank14::
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0351)
CopyRectTo20ByteRows_Bank14::
    push hl
    push bc

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a
    ret z
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push bc
    push hl

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop3
    xor a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address:
; CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from
; wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are
; kept. wTextCursorLo/wTextCursorHi = HL + $1C1 (E-0062)
DrawScreenBufferRect_Bank14::
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add $c1
    ld [wTextCursorLo], a
    ld a, h
    adc $01
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyRectToBGMapWrapped
    xor a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; Sets wGlyphListPos to 0; calls CopyFromBankWaitVRAM; increments wGlyphListStart; increments
; wGlyphListPos; branches on wGlyphListPos; sets wGlyphListStart to 0; sets wGlyphListPos to 0
; (E-0347)
; why: part of HibernateMenu; HibernateMenu: implements script command type EB (SCRIPT_HIBERNATE):
; monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode ... (E-0352,
; E-0038, E-0244)
HibernateMenu_WriteGlyphListPosAndGlyphListStart::
    xor a
    ld [wGlyphListPos], a

.loop:
    push hl
    push de
    ld a, [wGlyphListStart]
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jp z, .restore
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wGlyphListStart]
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp $08
    jr c, .loop
    xor a
    ret

.restore:
    pop de
    pop hl
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ld a, $ff
    ret

; stores tile $C3 at the addresses of entries 0-4 of the word table
; HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data (E-0122) (E-0344: the address in
; its name dropped or read as the label there; was EraseFiveTableEntries; a trailing preposition
; left by the dropped address removed)
EraseFiveTableEntries::
    ld c, $00

.loop:
    push bc
    ld a, c
    ld b, $c3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    pop bc
    inc c
    ld a, c
    cp $05
    jr c, .loop
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0351)
StoreBAtWordTableEntry_Bank14::
    push bc
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; runs CopyScreenBufferRectWithAttrs_Bank14 with C = 2, HL = $0280, DE = $00B4, wArg1/2 = 0/8
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; CopyScreenBufferRectAt0280_Bank14; shortened from RunCopyScreenBufferRectWithAttrs_Bank14At0280)
CopyScreenBufferRectAt0280_Bank14::
    ld c, $02
    ld hl, $0280
    ld de, $00b4
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ret

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with
; CGB attributes (E-0127)
CopyScreenBufferRectWithAttrs_Bank14::
    push bc
    push hl
    push de
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank14
    pop de
    pop hl
    ld a, [wIsCGB]
    and a
    jr z, .restore
    push hl
    push de
    ld de, wScreenAttrBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank14
    pop de
    pop hl

.restore:
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_Bank14
    ret

; wWorkBuf = field $0D of SRAM record B & $0F (its family), wWorkBuf + $1 = $C7, then
; LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForRecordB_Bank14::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    ld [wWorkBuf], a
    ld a, $c7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a
    ld [rRAMG2], a
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll_Bank14 + DE, two entries apart
; (WaitForVRAMAccess, interrupts off) (E-0120)
DrawC5BEC6AtScrollOffsetDE_Bank14::
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $c5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $be
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $c6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks) (E-0351)
StoreC5BEC6AtHLStride2_Bank14::
    ld a, $c5
    ld [hl], a
    inc hl
    inc hl
    ld a, $be
    ld [hl], a
    inc hl
    inc hl
    ld a, $c6
    ld [hl], a
    ret

; called from HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5: branches on the byte at
; sCompactRecords; branches on C; sets rRAMB to 1; branches on the byte at sRecords; branches on C;
; copies L to wArg6; copies H to wArg7; sets wArg5 to 0; copies L to wArg6; copies H to wArg7; sets
; wArg5 to 1 (E-0347)
; why: a helper of HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5, in step 21 of
; HibernateMenu_ChooseToHibernate (when wScreenStep = 21); HibernateMenu_ChooseToHibernate: screen
; state 4, reached from menu option 0: the list of farm records that are not eggs
; (ListRecordsState1NotEggs) after a capacity check (E-0352)
HibernateMenu_ChooseToHibernate_WriteRAMBAndArg6Etc::
    ld hl, sCompactRecords
    ld c, $00

.loop:
    ld a, [hl]
    bit 7, a
    jr z, .skip
    ld a, $6f
    add_a_to_hl
    inc c
    ld a, c
    cp $1d
    jr c, .loop
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr z, .skip
    ld a, $ff
    ret

.skip:
    push bc
    ld a, c
    cp $1d
    jr z, .restore
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    xor a
    ld [wArg5], a
    pop bc
    xor a
    ret

.restore:
    pop bc
    ld hl, sRecords
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld a, $01
    ld [wArg5], a
    xor a
    ret

; HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart passes $5A28 with
; sources
; HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopySrcList to
; HibernateMenu_WriteGlyphListPosAndGlyphListStart, which copies one tile per destination until
; $FFFF (E-0224, C1)
; record: 27 VRAM destinations, then $FFFF
NamingScreenTileDestListA::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0 ; entry 0
    dw vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $2f0, vTiles1 + $6e0, vTiles1 + $6f0, vTiles1 + $700, vTiles1 + $710
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7a0, vTiles1 + $7b0, vTiles1 + $7c0, vTiles1 + $7d0

; the second $FFFF-terminated destination list, right after the first; it ends at the source list
; HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopySrcList
; (E-0224, C1)
; record: 17 VRAM destinations, then $FFFF
NamingScreenTileDestListB::
    dw vTiles1 + $7e0, vTiles1 + $7f0, vTiles1 + $6b0, rIE, vTiles1 + $400, vTiles1 + $410, vTiles1 + $420, vTiles1 + $470 ; entry 0
    dw vTiles1 + $480, vTiles1 + $490, vTiles1 + $4a0, vTiles1 + $4b0, vTiles1 + $3f0, vTiles1 + $6a0, vTiles1 + $6b0, vTiles1 + $6c0
    dw vTiles1 + $6d0, rIE

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: bank-$1F tile sources
HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopySrcList::
    dw $41d0, $4300, $4290, $4340, $4210, $4250, $42f0, $41c0 ; entry 0
    dw $4370, $40f0, $43c0, $42d0, $4380, $4180, $4910, $4910
    dw $4910, $4910, $4910, $4120, $4170, $41a0, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4a70, $4910, $ffff

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 10 x 9 tiles, one row per line
HibernateMenu_SetupPartyList_CopyScreenBufferRectAt0280_Bank14_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a4, $a5, $a6, $a6, $a7, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a8, $a9, $aa, $a6, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $ab, $a6, $a5, $a6, $a9, $ac, $a6, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $ad, $ae, $af, $ee, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4, $22, $c4, $4a, $c4, $80, $c3
    db $a8, $c3, $d0, $c3, $f8, $c3, $20, $c4

; record: 8 x 11 tiles, one row per line
ClearTilesAndDrawRectAndStep_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $a4, $a5, $a6, $ce, $cf, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

; record: 12 x 9 tiles, one row per line
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_LoadFamilyIconTileForRecordB_Bank14_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8
    db $70, $8a, $80, $8a, $90, $8a, $a0, $8a, $b0, $8a, $c0, $8a, $d0, $8a, $e0, $8a
    db $f0, $8a, $80, $8f, $90, $8f, $a0, $8f, $b0, $8f, $c0, $8f, $ff, $ff, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $ff, $ff

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopyDestList::
    dw vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0, vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0 ; entry 0
    dw vTiles1 + $2f0, rIE

; record: bank-$1F tile sources
HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_TileCopySrcList::
    dw $4340, $4210, $4250, $42f0, $41c0, $4370, $40f0, $43c0 ; entry 0
    dw $42d0, $ffff

HibernateMenu_ChooseRecords_WriteScreenStep_TileCopyDestList::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740 ; entry 0
    dw vTiles1 + $4e0, vTiles1 + $4f0, rIE

HibernateMenu_ChooseRecords_WriteScreenStep_TileCopySrcList::
    dw $41d0, $4300, $4290, $4910, $4910, $4910, $4910, $4910 ; entry 0
    dw $4230, $4290, $ffff

HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep_TileCopyDestList::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_AdvanceScreenStep_TileCopySrcList::
    dw $4130, $4320, $42a0, $4330, $4190, $4150, $ffff ; entry 0

; unless a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0122)
RunNameEntryStateWhenNotFading::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wNameEntryState]
    jumptable
    dw RunNameEntryStateWhenNotFading_Setup
    dw RunNameEntryStateWhenNotFading_ReadNameEntrySubState
    dw RunNameEntryStateWhenNotFading_ReadNameEntryStep
    dw RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    dw RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params
    dw RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc
    dw RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc_2
    dw RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc

; name-entry state 0: draws the entry rectangle, sets wNameEntrySubState and reads the record
; (E-0293)
RunNameEntryStateWhenNotFading_Setup::
    ld a, [wNameEntrySubState]
    jumptable
    dw RunNameEntryStateWhenNotFading_Setup_BGMapAddressAtScroll_Bank14_2
    dw RunNameEntryStateWhenNotFading_Setup_WriteNameEntrySubStateAndArg5
    dw RunNameEntryStateWhenNotFading_Setup_DrawTileRectFromArg1Params
    dw RunNameEntryStateWhenNotFading_Setup_CopyArgs
    dw RunNameEntryStateWhenNotFading_Setup_WriteRAMG2AndRAMBEtc

; step 0 of RunNameEntryStateWhenNotFading_Setup: calls BGMapAddressAtScroll_Bank14_2; copies H to
; wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to $20; sets wArg4 to
; $20; sets wArg7 to 0; calls FillTileRectWithArg1Tile; sets hScrollY to 0; sets hScrollX to 0;
; copies hSpriteWindowClipMode to wSavedSpriteClipMode; then 5 more steps (see the code) (E-0347)
; why: step 0 of RunNameEntryStateWhenNotFading_Setup (when wNameEntrySubState = 0);
; RunNameEntryStateWhenNotFading_Setup: name-entry state 0: draws the entry rectangle, sets
; wNameEntrySubState and reads the record (E-0352)
RunNameEntryStateWhenNotFading_Setup_BGMapAddressAtScroll_Bank14_2::
    ld hl, wNameEntryState
    ld bc, $001d

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    call BGMapAddressAtScroll_Bank14_2
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, BGFillTile
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $20
    ld [wArg3], a
    ld a, $20
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    xor a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    ld a, $01
    ldh [hSpriteHideTile], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld de, Tiles2Plus710Tiles_3
    ld hl, vTiles2
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles1 + $4f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7E0Tiles
    ld hl, vTiles1 + $4c0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_2
    ld hl, vTiles1 + $4d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; step 1 of RunNameEntryStateWhenNotFading_Setup: calls
; RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2; increments
; wNameEntrySubState; sets wArg5 to 0 (E-0347)
; why: step 1 of RunNameEntryStateWhenNotFading_Setup (when wNameEntrySubState = 1);
; RunNameEntryStateWhenNotFading_Setup: name-entry state 0: draws the entry rectangle, sets
; wNameEntrySubState and reads the record (E-0352)
RunNameEntryStateWhenNotFading_Setup_WriteNameEntrySubStateAndArg5::
    ld hl, NameEntryTileDestList
    ld de, NameEntryTileSrcListA
    call RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2
    cp $ff
    jr nz, .clear_arg5
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a

.clear_arg5:
    xor a
    ld [wArg5], a
    ret

; step 2 of RunNameEntryStateWhenNotFading_Setup: calls BGMapAddressAtScroll_Bank14_2; copies H to
; wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to $14; sets wArg4 to
; $12; sets wArg7 to 0; calls DrawTileRectFromArg1Params; calls BGMapAddressAtScroll_Bank14_2; calls
; CopyTileBytesToVRAM_Bank14; increments wNameEntrySubState; then 1 more step (see the code)
; (E-0347)
; why: step 2 of RunNameEntryStateWhenNotFading_Setup (when wNameEntrySubState = 2);
; RunNameEntryStateWhenNotFading_Setup: name-entry state 0: draws the entry rectangle, sets
; wNameEntrySubState and reads the record (E-0352)
RunNameEntryStateWhenNotFading_Setup_DrawTileRectFromArg1Params::
    ld a, [wArg2]
    push af
    call BGMapAddressAtScroll_Bank14_2
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_Setup_DrawTileRectFromArg1Params_TileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank14_2
    ld de, $0043
    add hl, de
    di
    call WaitForVRAMAccess
    pop af
    and $01
    add $cc
    ld [hl], a
    ei
    ld hl, NameEntryTileSrcListB + $a6
    ld de, vTiles2 + $550
    call CopyTileBytesToVRAM_Bank14
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; copies the eight wArg bytes to wCounterPtr0Lo onward and picks a data table by wArg1 (E-0305)
RunNameEntryStateWhenNotFading_Setup_CopyArgs::
    ld hl, wArg1
    ld de, wCounterPtr0Lo
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [wArg1]
    or a
    jr nz, .read_arg4
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data3
    ld a, [wArg2]
    or a
    jr z, .call_copy_bytes_de_from_hl_bank14
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_SpriteSlotsInit

.call_copy_bytes_de_from_hl_bank14:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank14
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data1
    ld a, [wArg2]
    or a
    jr z, .call_copy_bytes_de_from_hl_bank142
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data2

.call_copy_bytes_de_from_hl_bank142:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank14
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    jr .skip

.read_arg4:
    ld a, [wArg4]
    ld [wArg1], a
    ld a, [wArg5]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4

.skip:
    ld hl, wCounterPtr0Lo
    ld de, wArg1
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0105)
CopyBytesDEFromHL_Bank14::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank14
    ret

; data read by RunNameEntryStateWhenNotFading_Setup_CopyArgs (6 bytes) (E-0347)
RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data1::
    db $00, $00, $01, $04, $00, $80

RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data2::
    db $01, $00, $01, $01, $00, $80

RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data3::
    db $00, $01, $00, $00, $08, $08, $04, $00, $00, $00, $00, $08, $08, $04, $00, $00

; CopyBytesDEFromHL_Bank14 copies these 16 bytes to wSpriteSlots (E-0264)
; record: 16 bytes copied to wSpriteSlots
RunNameEntryStateWhenNotFading_Setup_CopyArgs_SpriteSlotsInit::
    db $00, $01, $01, $00, $08, $08, $01, $00, $00, $00, $00, $08, $08, $04, $00, $00 ; entry 0

; step 4 of RunNameEntryStateWhenNotFading_Setup: calls
; RunNameEntryStateWhenNotFading_ClearNameEntryText; branches on wArg1; sets rRAMG2 to $0a; sets
; rRAMB to 0; calls SRAMRecordAddress; branches on the byte at wPartyList; calls
; RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter; branches on C; sets wNameEntryCursorX
; to 0; sets wNameEntryCursorY to 0; checks EVENT_NEVER_SET; sets wNameEntryLength to 4; then 4 more
; steps (see the code) (E-0347)
; why: step 4 of RunNameEntryStateWhenNotFading_Setup (when wNameEntrySubState = 4);
; RunNameEntryStateWhenNotFading_Setup: name-entry state 0: draws the entry rectangle, sets
; wNameEntrySubState and reads the record (E-0352)
RunNameEntryStateWhenNotFading_Setup_WriteRAMG2AndRAMBEtc::
    call RunNameEntryStateWhenNotFading_ClearNameEntryText
    ld a, [wArg1]
    and a
    jp z, .call_test_flag_bit
    cp $01
    jp z, .call_run_name_entry_state_when_not_fading
    cp $02
    jp z, .call_run_name_entry_state_when_not_fading
    ld hl, wPartyList
    ld a, [wGridCursorX]
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld de, wNameEntryText
    ld c, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    cp $f0
    jr z, .restore
    call RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp $0a
    jr c, .loop
    jr .clear_name_entry_cursor_x

.restore:
    pop bc
    pop hl

.clear_name_entry_cursor_x:
    xor a
    ld [wNameEntryCursorX], a
    ld [wNameEntryCursorY], a
    jr .call_run_name_entry_state_when_not_fading

.call_test_flag_bit:
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip
    ld hl, wNameEntryText
    ld a, $0c
    ld [hli], a
    ld a, $32
    ld [hli], a
    ld a, $25
    ld [hli], a
    ld a, $2c
    ld [hl], a
    ld a, $04
    ld [wNameEntryLength], a
    jr .call_run_name_entry_state_when_not_fading

.skip:
    ld hl, wNameEntryText
    ld a, $1d
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld a, $35
    ld [hli], a
    ld a, $24
    ld [hl], a
    ld a, $04
    ld [wNameEntryLength], a

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    xor a
    ld [wNameEntrySubState], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wArg5], a
    ret

; step 1 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; dispatches on wNameEntrySubState (E-0347)
; why: step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_ReadNameEntrySubState::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntrySubState]
    jumptable
    dw RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag
    dw RunNameEntryStateWhenNotFading_WriteNameEntrySubStateAndArg5Etc
    dw RunNameEntryStateWhenNotFading_ReadNameEntryCursorY
    dw RunNameEntryStateWhenNotFading_WriteNameEntryStateAndArg5
    dw RunNameEntryStateWhenNotFading_OrFromBankWaitVRAM
    dw RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag
    dw RunNameEntryStateWhenNotFading_WriteNameEntrySubStateAndArg5Etc
    dw RunNameEntryStateWhenNotFading_ReadNameEntryCursorY
    dw RunNameEntryStateWhenNotFading_WriteNameEntryStateAndArg5
    dw RunNameEntryStateWhenNotFading_WriteNameEntrySubStateAndArg5

; step 0 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState: calls
; RunNameEntryStateWhenNotFading_WriteNameEntryFlag; calls
; WriteTileBAtScrollOffset47PlusNameEntryLength; branches on wJoypadPressedRepeat; may continue in
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallDrawBlankTileC3; may continue in
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect; may continue in
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect2; may continue in
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect3; calls
; RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte; calls DrawBlankTileC3; branches on
; wNameEntryCursorY; sets wNameEntryCursorY to 4; branches on wNameEntryCursorX; then 28 more steps
; (see the code) (E-0347)
; why: step 0 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0),
; in step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag::
    call RunNameEntryStateWhenNotFading_WriteNameEntryFlag
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, .call_draw_blank_tile_c3
    bit 7, a
    jp nz, .call_draw_blank_tile_c32
    bit 4, a
    jp nz, .call_draw_blank_tile_c33
    bit 5, a
    jp nz, RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallDrawBlankTileC3
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect
    bit 1, a
    jp nz, RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect2
    bit 3, a
    jp nz, RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect3
    call RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte
    ret

.call_draw_blank_tile_c3:
    call DrawBlankTileC3
    ld a, [wNameEntryCursorY]
    and a
    jr nz, .set_name_entry_cursor_y
    ld a, $04
    ld [wNameEntryCursorY], a
    ld a, [wNameEntryCursorX]
    cp $06
    jr c, .call_run_name_entry_state_when_not_fading
    ld a, $0d
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading

.set_name_entry_cursor_y:
    dec a
    ld [wNameEntryCursorY], a

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c32:
    call DrawBlankTileC3
    ld a, [wNameEntryCursorY]
    cp $04
    jr c, .cp_02
    xor a
    ld [wNameEntryCursorY], a
    jr .call_run_name_entry_state_when_not_fading2

.cp_02:
    cp $02
    jr nz, .cp_03
    ld a, [wNameEntryCursorX]
    cp $0d
    jr c, .check_name_entry_cursor_y
    ld a, $0d
    ld [wNameEntryCursorX], a
    jr .check_name_entry_cursor_y

.cp_03:
    cp $03
    jr nz, .check_name_entry_cursor_y
    ld a, [wNameEntryCursorX]
    cp $06
    jr c, .check_name_entry_cursor_y
    ld a, $0d
    ld [wNameEntryCursorX], a

.check_name_entry_cursor_y:
    ld a, [wNameEntryCursorY]
    inc a
    ld [wNameEntryCursorY], a

.call_run_name_entry_state_when_not_fading2:
    call RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c33:
    call DrawBlankTileC3
    ld a, [wNameEntryCursorY]
    ld hl, RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data
    add_a_to_hl
    ld b, [hl]
    ld a, [wNameEntryCursorX]
    cp b
    jr c, .check_name_entry_cursor_y2
    xor a
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading3

.check_name_entry_cursor_y2:
    ld a, [wNameEntryCursorY]
    cp $04
    jr nz, .check_name_entry_cursor_x
    ld a, [wNameEntryCursorX]
    cp $05
    jr c, .check_name_entry_cursor_x
    ld a, $0d
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading3

.check_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    inc a
    ld [wNameEntryCursorX], a

.call_run_name_entry_state_when_not_fading3:
    call RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wArg5], a
    ret

; data read by RunNameEntryStateWhenNotFading (5 bytes) (E-0347)
RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data::
    db $10, $10, $10, $0d, $0d

; Calls DrawBlankTileC3; branches on wNameEntryCursorX; copies the byte at
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data to wNameEntryCursorX; branches on
; wNameEntryCursorY; branches on wNameEntryCursorX; sets wNameEntryCursorX to 5; decrements
; wNameEntryCursorX; calls RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte; plays sound $69;
; sets wArg5 to 0 (E-0347)
; why: part of RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data, in part of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallDrawBlankTileC3::
    call DrawBlankTileC3
    ld a, [wNameEntryCursorX]
    and a
    jr nz, .check_name_entry_cursor_y
    ld a, [wNameEntryCursorY]
    ld hl, RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data
    add_a_to_hl
    ld a, [hl]
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading

.check_name_entry_cursor_y:
    ld a, [wNameEntryCursorY]
    cp $04
    jr nz, .check_name_entry_cursor_x
    ld a, [wNameEntryCursorX]
    cp $0d
    jr c, .check_name_entry_cursor_x
    ld a, $05
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading

.check_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    dec a
    ld [wNameEntryCursorX], a

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wArg5], a
    ret

; Plays sound $69; calls RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2; increments
; wNameEntrySubState; sets wArg5 to 0 (E-0347)
; why: part of RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data, in part of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect::
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2
    ld a, [wNameEntrySubState]
    inc a
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; Plays sound $69; calls RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte; increments
; wNameEntrySubState; sets wArg5 to 0 (E-0347)
; why: part of RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data, in part of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect2::
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; Plays sound $69; calls DrawBlankTileC3; sets wNameEntryCursorX to $0d; sets wNameEntryCursorY to
; 4; sets wArg5 to 0 (E-0347)
; why: part of RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data, in part of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag_Data_CallQueueSoundEffect3::
    ld a, $69
    call QueueSoundEffect
    call DrawBlankTileC3
    ld a, $0d
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a
    xor a
    ld [wArg5], a
    ret

; on the last glyph of the name entry wNameEntryText adds or cycles the marks $8D and $8E when the
; glyph allows them (lists IsHLByteInList_Data and 68CA), with sound $69 (E-0129)
ToggleVoicingMarkOnNameEntry::
    call CopyTileForNameEntryLength
    ld hl, wNameEntryText

.skip:
    ld a, [hl]
    cp $f0
    jr z, .next
    cp $9f
    jr z, .next
    inc hl
    jr .skip

.next:
    dec hl
    ld a, [hl]
    cp $8e
    jr z, .skip7
    cp $8d
    jr z, .next2
    ld b, $8d
    push bc
    call IsHLByteInList
    pop bc
    cp $ff
    jr nz, .call_queue_sound_effect
    xor a
    ld [wArg5], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld hl, wNameEntryText

.skip2:
    ld a, [hl]
    cp $9f
    jr z, .skip4
    cp $f0
    jr z, .skip3
    inc hl
    jr .skip2

.skip3:
    ld a, b
    ld [hl], a
    xor a
    ld [wArg5], a
    ret

.skip4:
    ld a, b
    ld [hl], a
    ld hl, wNameEntryText

.skip5:
    ld a, [hl]
    cp $f0
    jr z, .skip6
    inc hl
    jr .skip5

.skip6:
    ld a, $9f
    ld [hl], a
    xor a
    ld [wArg5], a
    ret

.skip7:
    ld a, $9f
    ld [hl], a

.loop:
    ld a, [hli]
    cp $f0
    jr nz, .loop
    dec hl
    dec hl
    ld a, $f0
    ld [hl], a
    xor a
    ld [wArg5], a
    ret

.next2:
    dec hl
    ld b, $8e
    push bc
    call IsHLByteInList_2
    pop bc
    cp $ff
    jr nz, .next3
    inc hl
    jp .skip7

.next3:
    inc hl
    ld a, $8e
    ld [hl], a
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wArg5], a
    ret

; called from RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag: increments
; wNameEntryCursorByte; branches on wNameEntryCursorByte; may continue in DrawBlankTileC3; sets
; wNameEntryCursorByte to 0; continues in
; RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_ReadNameEntryCursorY (E-0347)
; why: a helper of RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryCursorByte::
    ld a, [wNameEntryCursorByte]
    inc a
    ld [wNameEntryCursorByte], a
    cp $10
    jr c, .skip
    cp $18
    jr c, DrawBlankTileC3
    xor a
    ld [wNameEntryCursorByte], a

.skip:
    ld b, $55
    jr RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_ReadNameEntryCursorY

; B = $C3 (blank tile) and joins the tile draw at
; RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_ReadNameEntryCursorY (E-0122)
; (E-0344: the address in its name dropped or read as the label there; was DrawBlankTileC3)
DrawBlankTileC3::
    ld b, $c3
    jr RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_ReadNameEntryCursorY

; called from RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag: changes B (E-0347)
; why: a helper of RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2::
    ld b, $55

; Branches on wNameEntryCursorY; calls BGMapAddressAtScroll_Bank14_2; returns unless
; wNameEntryCursorX is $0d; branches on wNameEntryCursorY; returns unless wNameEntryCursorY is $03
; (E-0347)
; why: part of RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2, in a helper of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_ReadNameEntryCursorY::
    ld a, [wNameEntryCursorY]
    ld hl, NameEntryKeyPositions
    cp $00
    jr z, .read_name_entry_cursor_x
    ld e, $22
    ld d, $00

.loop:
    add hl, de
    dec a
    jr nz, .loop

.read_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14_2
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld a, [wNameEntryCursorX]
    cp $0d
    ret nz
    ld a, [wNameEntryCursorY]
    cp $04
    jr z, .call_wait_for_vram_access
    cp $03
    ret nz
    inc hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei

.call_wait_for_vram_access:
    inc hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2 reads row $22 * wNameEntryCursorY
; from $61E2, then the word for wNameEntryCursorX; 5 rows (E-0224, C1)
; record: 17 position words (one per key column) for a keyboard row
NameEntryKeyPositions::
    dw $0101, $0102, $0103, $0104, $0105, $0106, $0107, $0108, $0109, $010a, $010b, $010c, $010d, $010f, $0110, $0111, $0112 ; id 0
    dw $0141, $0142, $0143, $0144, $0145, $0146, $0147, $0148, $0149, $014a, $014b, $014c, $014d, $014f, $0150, $0151, $0152 ; id 1
    dw $0181, $0182, $0183, $0184, $0185, $0186, $0187, $0188, $0189, $018a, $018b, $018c, $018d, $018f, $0190, $0191, $0192 ; id 2
    dw $01c1, $01c2, $01c3, $01c4, $01c5, $01c6, $01c7, $01c8, $01c9, $01ca, $01cb, $01cc, $01cd, $01cf, $01d0, $01d1, $01d2 ; id 3
    dw $0201, $0202, $0203, $0204, $0205, $0206, $0207, $0208, $0209, $020a, $020b, $020c, $020d, $020f, $0210, $0211, $0212 ; id 4

; step 1 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState: calls
; WriteTileBAtScrollOffset47PlusNameEntryLength; branches on wNameEntryLength; calls
; RunNameEntryStateWhenNotFading_ClearNameEntryText; decrements wNameEntrySubState; sets wArg5 to 0;
; calls WriteTileBAtScrollOffset47PlusNameEntryLength; branches on the byte at wNameEntryText; calls
; CopyTileForNameEntryLength; branches on wNameEntryMarkPending; sets wNameEntryMarkPending to 0;
; decrements wNameEntryLength; decrements wNameEntrySubState; then 1 more step (see the code)
; (E-0347)
; why: step 1 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 1),
; in step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntrySubStateAndArg5Etc::
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wNameEntryLength]
    and a
    jr nz, .call_write_tile_b_at_scroll_offset47_plus
    call RunNameEntryStateWhenNotFading_ClearNameEntryText
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

.call_write_tile_b_at_scroll_offset47_plus:
    ld b, $c3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld hl, wNameEntryText

.skip:
    ld a, [hl]
    cp $f0
    jr z, .next
    cp $9f
    jr z, .next
    inc hl
    jr .skip

.next:
    dec hl
    ld a, [hl]
    cp $8d
    jr z, .skip2
    cp $8e
    jr z, .skip2
    jr .call_copy_tile_for_name_entry_length

.skip2:
    ld a, $9f
    ld [hld], a
    ld a, $9f
    ld [hl], a
    ld hl, wNameEntryText

.skip3:
    ld a, [hl]
    cp $f0
    jr z, .next2
    inc hl
    jr .skip3

.next2:
    dec hl
    ld a, $f0
    ld [hl], a
    jr .call_copy_tile_for_name_entry_length2

.call_copy_tile_for_name_entry_length:
    ld a, $9f
    ld [hld], a

.call_copy_tile_for_name_entry_length2:
    call CopyTileForNameEntryLength
    ld a, [wNameEntryMarkPending]
    and a
    jr z, .check_name_entry_length
    xor a
    ld [wNameEntryMarkPending], a
    jr .check_name_entry_sub_state

.check_name_entry_length:
    ld a, [wNameEntryLength]
    dec a
    ld [wNameEntryLength], a

.check_name_entry_sub_state:
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; step 2 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState: changes HL, DE and A; branches on
; wNameEntryCursorY; may continue in RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter
; (E-0347)
; why: step 2 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 2),
; in step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_ReadNameEntryCursorY::
    ld a, [wNameEntryCursorY]
    ld hl, NameEntryKeyboard
    cp $00
    jr z, .read_name_entry_cursor_x
    ld e, $11
    ld d, $00

.loop:
    add hl, de
    dec a
    jr nz, .loop

.read_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    add l
    ld l, a
    jr nc, RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter
    inc h

; handles the chosen entry: $FD, $FE and $FF are commands; otherwise appends the character to
; wNameEntryText, with the dakuten marks $8D/$8E (E-0305)
RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter::
    ld a, [hl]
    cp $fd
    jp z, .check_name_entry_sub_state
    cp $fe
    jp z, .check_name_entry_sub_state2
    cp $ff
    jp z, .check_name_entry_length2
    push af
    ld hl, wNameEntryText

.skip:
    ld a, [hl]
    cp $f0
    jr z, .restore
    cp $9f
    jr z, .restore
    inc hl
    jr .skip

.restore:
    pop af
    cp $8d
    jr z, .next2
    cp $8e
    jr z, .next2
    push af
    ld a, [wNameEntryLength]
    cp $04
    jr nz, .restore2
    ld a, $01
    ld [wNameEntryMarkPending], a
    dec hl
    ld a, [hl]
    cp $8d
    jr z, .next
    cp $8e
    jr z, .next
    inc hl
    ld a, [hl]
    cp $9f
    jr z, .restore2
    dec hl
    jr .restore2

.next:
    inc hl
    ld a, [hld]
    cp $9f
    jr nz, .skip2
    inc hl
    inc hl

.skip2:
    ld a, $f0
    ld [hl], a
    dec hl

.restore2:
    pop af
    ld [hli], a
    jr .call_write_tile_b_at_scroll_offset47_plus

.next2:
    dec hl
    push af
    ld a, [hl]
    cp $8d
    jp z, .restore4
    cp $8e
    jp z, .restore5
    pop af
    push af
    cp $8d
    jr z, .call_is_hl_byte_in_list
    call IsHLByteInList_2
    cp $ff
    jp z, .loop3
    jr .restore3

.call_is_hl_byte_in_list:
    call IsHLByteInList
    cp $ff
    jp z, .loop3

.restore3:
    pop af
    inc hl
    ld [hl], a
    ld a, [wNameEntryLength]
    cp $04
    jr z, .check_name_entry_mark_pending

.loop:
    ld b, $f0
    jr .skip3

.check_name_entry_mark_pending:
    ld a, [wNameEntryMarkPending]
    and a
    jr z, .loop
    ld b, $9f

.skip3:
    ld hl, wNameEntryText
    ld c, $00

.skip4:
    ld a, [hl]
    cp b
    jr z, .skip5
    inc hl
    inc c
    ld a, c
    cp $0a
    jr z, .set_name_entry_mark_pending_to_01
    jr .skip4

.skip5:
    ld a, $9f
    ld [hl], a
    jr .loop2

.set_name_entry_mark_pending_to_01:
    ld a, $01
    ld [wNameEntryMarkPending], a
    jr .check_name_entry_length

.call_write_tile_b_at_scroll_offset47_plus:
    ld b, $c3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wNameEntryLength]
    cp $04
    jr nc, .call_draw_blank_tile_c3
    ld a, [wNameEntryLength]
    inc a
    ld [wNameEntryLength], a
    jr .loop2

.call_draw_blank_tile_c3:
    call DrawBlankTileC3
    ld a, $0d
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a

.loop2:
    ld a, [wNameEntrySubState]
    dec a
    dec a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

.loop3:
    pop af

.check_name_entry_length:
    ld a, [wNameEntryLength]
    cp $04
    jr c, .loop2
    ld a, [wNameEntryMarkPending]
    and a
    jr z, .loop2
    call DrawBlankTileC3
    ld a, $0d
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a
    jr .loop2

.restore4:
    pop af
    push af
    cp $8d
    jr z, .loop3
    dec hl
    call IsHLByteInList_2
    cp $ff
    jr z, .loop3
    inc hl
    ld a, $8e
    ld [hl], a
    call CopyTileForNameEntryLength
    jr .loop3

.restore5:
    pop af
    push af
    cp $8e
    jr z, .loop3
    ld a, $8d
    ld [hl], a
    call CopyTileForNameEntryLength
    jr .loop3

.check_name_entry_sub_state:
    ld a, [wNameEntrySubState]
    inc a
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

.check_name_entry_sub_state2:
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

.check_name_entry_length2:
    ld a, [wNameEntryLength]
    and a
    jr z, .check_name_entry_sub_state3
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wArg5], a
    ret

.check_name_entry_sub_state3:
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; step 3 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState: calls
; RunNameEntryStateWhenNotFading_CheckArg1; calls RunNameEntryStateWhenNotFading_WriteNameEntryFlag;
; increments wNameEntryState; sets wArg5 to 0 (E-0347)
; why: step 3 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 3),
; in step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryStateAndArg5::
    call RunNameEntryStateWhenNotFading_CheckArg1
    call RunNameEntryStateWhenNotFading_WriteNameEntryFlag
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wArg5], a
    ret

; step 4 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState: calls
; RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2; increments
; wNameEntrySubState; calls OrFromBankWaitVRAM; sets wArg5 to 0 (E-0347)
; why: step 4 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 4),
; in step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_OrFromBankWaitVRAM::
    ld hl, NameEntryTileDestListEmpty
    ld de, NameEntryTileSrcListB
    call RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2
    cp $ff
    jr nz, .clear_arg5
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    ld de, CopyGlyphTilesToVRAM_Data1
    ld hl, vTiles2 + $480
    ld b, $1f
    ld c, $10
    call OrFromBankWaitVRAM

.clear_arg5:
    xor a
    ld [wArg5], a
    ret

; step 9 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState: calls
; RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2; sets wNameEntrySubState to
; 0; sets wArg5 to 0 (E-0347)
; why: step 9 of RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 9),
; in step 1 of RunNameEntryStateWhenNotFading (when wNameEntryState = 1);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntrySubStateAndArg5::
    ld hl, NameEntryTileDestListEmpty
    ld de, NameEntryTileSrcListA
    call RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2
    cp $ff
    jr nz, .clear_arg5
    xor a
    ld [wNameEntrySubState], a

.clear_arg5:
    xor a
    ld [wArg5], a
    ret

; step 2 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; dispatches on wNameEntryStep (E-0347)
; why: step 2 of RunNameEntryStateWhenNotFading (when wNameEntryState = 2);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_ReadNameEntryStep::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntryStep]
    jumptable
    dw RunNameEntryStateWhenNotFading_FillTilesFromRequest_2
    dw RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_2
    dw RunNameEntryStateWhenNotFading_SetArg5
    dw RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_SetArg5

; step 0 of RunNameEntryStateWhenNotFading_ReadNameEntryStep: copies L to wTextWindowTileLo; copies
; H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to wTextWindowWidth; calls
; FillTilesFromRequest; increments wNameEntryStep; sets wArg5 to 0 (E-0347)
; why: step 0 of RunNameEntryStateWhenNotFading_ReadNameEntryStep (when wNameEntryStep = 0), in step
; 2 of RunNameEntryStateWhenNotFading (when wNameEntryState = 2); RunNameEntryStateWhenNotFading:
; unless a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352,
; E-0122)
RunNameEntryStateWhenNotFading_FillTilesFromRequest_2::
    ld hl, vTiles2 + $5c0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

; step 1 of RunNameEntryStateWhenNotFading_ReadNameEntryStep: calls BGMapAddressAtScroll_Bank14_2;
; copies H to wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to $14;
; sets wArg4 to 1; sets wArg7 to 0; calls DrawTileRectFromArg1Params; increments wNameEntryStep;
; sets wArg5 to 0 (E-0347)
; why: step 1 of RunNameEntryStateWhenNotFading_ReadNameEntryStep (when wNameEntryStep = 1), in step
; 2 of RunNameEntryStateWhenNotFading (when wNameEntryState = 2); RunNameEntryStateWhenNotFading:
; unless a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352,
; E-0122)
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_2::
    call BGMapAddressAtScroll_Bank14_2
    ld de, $01e0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Data_2
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $01
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

; step 2 of RunNameEntryStateWhenNotFading_ReadNameEntryStep: calls BGMapAddressAtScroll_Bank14_2;
; copies H to wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to $14;
; sets wArg4 to 3; sets wArg7 to 0; calls DrawTileRectFromArg1Params; increments wNameEntryStep;
; sets wArg5 to 0 (E-0347)
; why: step 2 of RunNameEntryStateWhenNotFading_ReadNameEntryStep (when wNameEntryStep = 2), in step
; 2 of RunNameEntryStateWhenNotFading (when wNameEntryState = 2); RunNameEntryStateWhenNotFading:
; unless a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352,
; E-0122)
RunNameEntryStateWhenNotFading_SetArg5::
    call BGMapAddressAtScroll_Bank14_2
    ld de, $01c0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_SetArg5_TileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

; step 3 of RunNameEntryStateWhenNotFading_ReadNameEntryStep: calls BGMapAddressAtScroll_Bank14_2;
; copies H to wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to $14;
; sets wArg4 to 5; sets wArg7 to 0; calls DrawTileRectFromArg1Params; sets wNameEntryStep to 0;
; increments wNameEntryState; sets wArg5 to 0 (E-0347)
; why: step 3 of RunNameEntryStateWhenNotFading_ReadNameEntryStep (when wNameEntryStep = 3), in step
; 2 of RunNameEntryStateWhenNotFading (when wNameEntryState = 2); RunNameEntryStateWhenNotFading:
; unless a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352,
; E-0122)
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_SetArg5::
    call BGMapAddressAtScroll_Bank14_2
    ld de, $01a0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_SetArg5_TileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $05
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    xor a
    ld [wNameEntryStep], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wArg5], a
    ret

; step 3 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; dispatches on wNameEntryStep (E-0347)
; why: step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntryStep]
    jumptable
    dw RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5
    dw RunNameEntryStateWhenNotFading_WriteStringCategoryAndStringIndexEtc
    dw RunNameEntryStateWhenNotFading_SetNameEntryStep
    dw RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5_2
    dw RunNameEntryStateWhenNotFading_WriteStringCategoryAndStringIndexEtc_SetStringCategory
    dw RunNameEntryStateWhenNotFading_SetStringCategory

; step 5 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc:
; sets wStringCategory to 0; sets wStringIndex to 3; calls
; RunNameEntryStateWhenNotFading_FillTilesFromRequest; may return early; sets wNameEntryState; sets
; wNameEntryMenuCursor to 0; sets wArg5 to 0 (E-0347)
; why: step 5 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 5), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_SetStringCategory::
    xor a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_FillTilesFromRequest
    cp $ff
    ret nz
    ld a, [wNameEntryState]
    add $04
    ld [wNameEntryState], a
    xor a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

; step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc:
; branches on wArg1; calls RunNameEntryStateWhenNotFading_ReadArg1; calls
; RunNameEntryStateWhenNotFading_ScanNameEntryText; calls
; RunNameEntryStateWhenNotFading_WriteRAMG2AndRAMB; increments wNameEntryStep; sets wArg5 to 0;
; calls RunNameEntryStateWhenNotFading_ReadArg1; calls
; RunNameEntryStateWhenNotFading_ScanNameEntryText; sets wNameEntryStep; sets wArg5 to 0; calls
; RunNameEntryStateWhenNotFading_ReadArg1; calls RunNameEntryStateWhenNotFading_ScanNameEntryText;
; then 4 more steps (see the code) (E-0347)
; why: step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 0), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5::
    ld a, [wArg1]
    and a
    jp z, .call_run_name_entry_state_when_not_fading2
    call RunNameEntryStateWhenNotFading_ReadArg1
    cp $ff
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_ScanNameEntryText
    cp $ff
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_WriteRAMG2AndRAMB
    cp $ff
    jr nz, .call_run_name_entry_state_when_not_fading
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_ReadArg1
    cp $ff
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_ScanNameEntryText
    cp $ff
    jr z, .read_name_entry_step
    ld a, [wNameEntryStep]
    add $03
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

.call_run_name_entry_state_when_not_fading2:
    call RunNameEntryStateWhenNotFading_ReadArg1
    cp $ff
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_ScanNameEntryText
    cp $ff
    jr z, .read_name_entry_step
    ld a, [wNameEntryStep]
    inc a
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

.read_name_entry_step:
    ld a, [wNameEntryStep]
    add $05
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

; step 1 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc:
; sets wStringCategory to 0; sets wStringIndex to 2; calls
; RunNameEntryStateWhenNotFading_FillTilesFromRequest; increments wNameEntryStep; sets wArg5 to 0
; (E-0347)
; why: step 1 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 1), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteStringCategoryAndStringIndexEtc::
    xor a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_FillTilesFromRequest
    cp $ff
    jr nz, .clear_arg5
    ld a, [wNameEntryStep]
    inc a
    inc a
    ld [wNameEntryStep], a

.clear_arg5:
    xor a
    ld [wArg5], a
    ret

; step 2 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc:
; increments wNameEntryStep; continues in RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5_2
; (E-0347)
; why: step 2 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 2), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_SetNameEntryStep::
    ld de, wTextBuf0
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    jp RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5_2

; step 3 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc:
; branches on the byte at wNameEntryText; increments wNameEntryStep; sets wArg5 to 0 (E-0347)
; why: step 3 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 3), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5_2::
    ld hl, wNameEntryText
    ld de, wTextBuf0

.skip:
    ld a, [hl]
    cp $f0
    jr z, .check_name_entry_step
    cp $9f
    jr z, .check_name_entry_step
    ld [de], a
    inc hl
    inc de
    jr .skip

.check_name_entry_step:
    ld a, $f0
    ld [de], a
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

; step 4 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc:
; sets wStringCategory to 0; sets wStringIndex to 0; calls
; RunNameEntryStateWhenNotFading_FillTilesFromRequest; may return early; sets wNameEntryStep to 0;
; increments wNameEntryState; sets wArg5 to 0 (E-0347)
; why: step 4 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 4), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteStringCategoryAndStringIndexEtc_SetStringCategory::
    xor a
    ld [wStringCategory], a
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_FillTilesFromRequest
    cp $ff
    ret nz
    xor a
    ld [wNameEntryStep], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wArg5], a
    ret

; step 4 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; calls BGMapAddressAtScroll_Bank14_2; copies H
; to wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to 6; sets wArg4 to
; 5; sets wArg7 to 0; calls DrawTileRectFromArg1Params; increments wNameEntryState; plays sound $6c;
; then 1 more step (see the code) (E-0347)
; why: step 4 of RunNameEntryStateWhenNotFading (when wNameEntryState = 4);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    call BGMapAddressAtScroll_Bank14_2
    ld de, $010e
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_TileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $05
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wArg5], a
    ret

; step 5 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; calls
; RunNameEntryStateWhenNotFading_BlinkCursorNameEntryBlink_Bank14; may return early; increments
; wNameEntryState; sets wNameEntryMenuCursor to 0; sets wArg5 to 0; branches on
; wNameEntryMenuCursor; increments wNameEntryState; sets wNameEntryMenuCursor to 0; sets wArg5 to 0
; (E-0347)
; why: step 5 of RunNameEntryStateWhenNotFading (when wNameEntryState = 5);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    call RunNameEntryStateWhenNotFading_BlinkCursorNameEntryBlink_Bank14
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_name_entry_menu_cursor
    ret

.loop:
    ld a, [wNameEntryState]
    inc a
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

.check_name_entry_menu_cursor:
    ld a, [wNameEntryMenuCursor]
    and a
    jr nz, .loop
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

; step 6 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; dispatches on wNameEntryStep (E-0347)
; why: step 6 of RunNameEntryStateWhenNotFading (when wNameEntryState = 6);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc_2::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntryStep]
    jumptable
    dw RunNameEntryStateWhenNotFading_FillTileRectWithArg1Tile
    dw RunNameEntryStateWhenNotFading_FinishNameEntry

; step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc_2:
; calls BGMapAddressAtScroll_Bank14_2; copies H to wArg5; copies L to wArg6; copies D to wArg1;
; copies E to wArg2; sets wArg3 to $20; sets wArg4 to $20; sets wArg7 to 0; calls
; FillTileRectWithArg1Tile; increments wNameEntryStep; sets wArg5 to 0 (E-0347)
; why: step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc_2
; (when wNameEntryStep = 0), in step 6 of RunNameEntryStateWhenNotFading (when wNameEntryState = 6);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_FillTileRectWithArg1Tile::
    call BGMapAddressAtScroll_Bank14_2
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, BGFillTile
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $20
    ld [wArg3], a
    ld a, $20
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a
    ld [wArg5], a
    ret

; copies the entered name to wNameGlyphBuf (ending in $F0), clears the name-entry state and sets the
; text window (E-0305)
RunNameEntryStateWhenNotFading_FinishNameEntry::
    ld hl, wNameEntryText
    ld de, wNameGlyphBuf

.skip:
    ld a, [hl]
    cp $f0
    jr z, .skip2
    cp $9f
    jr z, .skip2
    ld [de], a
    inc hl
    inc de
    jr .skip

.skip2:
    ld a, $f0
    ld [de], a
    ld hl, wNameEntryState
    ld bc, $001d

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wSavedSpriteClipMode]
    ld a, $ff
    ld [wArg5], a
    ret

; step 7 of RunNameEntryStateWhenNotFading: calls
; RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc; calls BGMapAddressAtScroll_Bank14_2; copies H
; to wArg5; copies L to wArg6; copies D to wArg1; copies E to wArg2; sets wArg3 to $14; sets wArg4
; to $0a; sets wArg7 to 0; calls DrawTileRectFromArg1Params; sets wNameEntryState to 1; sets
; wNameEntryStep to 0; then 5 more steps (see the code) (E-0347)
; why: step 7 of RunNameEntryStateWhenNotFading (when wNameEntryState = 7);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc::
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    call BGMapAddressAtScroll_Bank14_2
    ld de, $0100
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Data
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $0a
    ld [wArg4], a
    xor a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, $01
    ld [wNameEntryState], a
    xor a
    ld [wNameEntryStep], a
    ld a, [wNameEntrySubState]
    cp $04
    jr nc, .set_name_entry_sub_state_to_05
    xor a
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

.set_name_entry_sub_state_to_05:
    ld a, $05
    ld [wNameEntrySubState], a
    xor a
    ld [wArg5], a
    ret

; Branches on wArg1; calls UpdateAndDrawSpriteSlots; copies wArg4 to wArg1; copies wArg5 to wArg2;
; sets wArg3 to 0; sets wArg4 to $10; sets wArg5 to $18; sets wArg6 to 0; calls DrawMetaSpritePartC0
; (E-0347)
; why: part of RunNameEntryStateWhenNotFading; RunNameEntryStateWhenNotFading: unless a fade is
; running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc::
    ld hl, wArg1
    ld de, wCounterPtr0Lo
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [wArg1]
    or a
    jr nz, .read_arg4
    farcall UpdateAndDrawSpriteSlots
    jr .skip

.read_arg4:
    ld a, [wArg4]
    ld [wArg1], a
    ld a, [wArg5]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld a, $10
    ld [wArg4], a
    ld a, $18
    ld [wArg5], a
    xor a
    ld [wArg6], a
    ld c, $00
    farcall DrawMetaSpritePartC0

.skip:
    ld hl, wCounterPtr0Lo
    ld de, wArg1
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ret

; A = 0 when [HL] is in the $FF-terminated list IsHLByteInList_Data, else $FF (E-0124) (E-0344: the
; address in its name dropped or read as the label there; was IsHLByteInList)
IsHLByteInList::
    ld de, IsHLByteInList_Data

.skip:
    ld a, [de]
    cp $ff
    jr z, .return_FF
    ld b, a
    ld a, [hl]
    cp b
    jr z, .return_0
    inc de
    jr .skip

.return_0:
    xor a
    ret

.return_FF:
    ld a, $ff
    ret

; data read by IsHLByteInList (43 bytes) (E-0347)
IsHLByteInList_Data::
    db $3e, $3f, $40, $41, $42, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $33
    db $34, $35, $37, $38, $75, $76, $77, $78, $79, $60, $61, $62, $63, $64, $65, $66
    db $67, $68, $69, $6a, $6b, $6c, $6e, $6f, $26, $5a, $ff

; A = 0 when [HL] is in the $FF-terminated list IsHLByteInList_2_Data, else $FF (E-0124) (E-0344:
; the address in its name dropped or read as the label there; was IsHLByteInList_2)
IsHLByteInList_2::
    ld de, IsHLByteInList_2_Data

.skip:
    ld a, [de]
    cp $ff
    jr z, .return_FF
    ld b, a
    ld a, [hl]
    cp b
    jr z, .return_0
    inc de
    jr .skip

.return_0:
    xor a
    ret

.return_FF:
    ld a, $ff
    ret

; data read by IsHLByteInList (11 bytes) (E-0347)
IsHLByteInList_2_Data::
    db $3e, $3f, $40, $41, $42, $75, $76, $77, $78, $79, $ff

; called from RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc: branches
; on wJoypadPressedRepeat; branches on wJoypadPressed; calls BlinkCursorNameEntryBlink_Bank14; sets
; wMenuInputResult to 0; calls DrawBlankTileC3_3; branches on wNameEntryMenuCursor; sets
; wNameEntryMenuCursor to 1; calls DrawBlankTileC3_3; branches on wNameEntryMenuCursor; sets
; wNameEntryMenuCursor to 0; sets wNameEntryBlink to 0; calls BlinkCursorNameEntryBlink_Bank14; then
; 6 more steps (see the code) (E-0347)
; why: a helper of RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc, in
; step 5 of RunNameEntryStateWhenNotFading (when wNameEntryState = 5);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_BlinkCursorNameEntryBlink_Bank14::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_3
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_32
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call BlinkCursorNameEntryBlink_Bank14
    xor a
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_3:
    call DrawBlankTileC3_3
    ld a, [wNameEntryMenuCursor]
    and a
    jr nz, .set_name_entry_menu_cursor
    ld a, $01
    ld [wNameEntryMenuCursor], a
    jr .clear_name_entry_blink

.set_name_entry_menu_cursor:
    dec a
    ld [wNameEntryMenuCursor], a
    jr .clear_name_entry_blink

.call_draw_blank_tile_c3_32:
    call DrawBlankTileC3_3
    ld a, [wNameEntryMenuCursor]
    cp $01
    jr c, .set_name_entry_menu_cursor2
    xor a
    ld [wNameEntryMenuCursor], a
    jr .clear_name_entry_blink

.set_name_entry_menu_cursor2:
    inc a
    ld [wNameEntryMenuCursor], a

.clear_name_entry_blink:
    xor a
    ld [wNameEntryBlink], a
    call BlinkCursorNameEntryBlink_Bank14
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_2
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; cycles wNameEntryBlink through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (E-0122)
BlinkCursorNameEntryBlink_Bank14::
    ld a, [wNameEntryBlink]
    inc a
    ld [wNameEntryBlink], a
    cp $10
    jr c, .skip
    cp $18
    jr c, DrawBlankTileC3_3
    xor a
    ld [wNameEntryBlink], a

.skip:
    ld b, $bb
    jr RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_2_ReadNameEntryMenuCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_3)
DrawBlankTileC3_3::
    ld b, $c3
    jr RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_2_ReadNameEntryMenuCursor

; Takes BC; changes B (E-0347)
; why: part of RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2, in a helper of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_2::
    ld b, $bc

; Calls BGMapAddressAtScroll_Bank14_2 (E-0347)
; why: part of RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_2, in part of
; RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2, in a helper of
; RunNameEntryStateWhenNotFading_CallWriteNameEntryFlag, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 0), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_2_ReadNameEntryMenuCursor::
    ld a, [wNameEntryMenuCursor]
    add a
    ld hl, RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14_2
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by RunNameEntryStateWhenNotFading (4 bytes) (E-0347)
RunNameEntryStateWhenNotFading_BGMapAddressAtScroll_Bank14_2_Data::
    db $2f, $01, $6f, $01

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; (E-0351)
CopyTileBytesToVRAM_Bank14::
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; Returns if the byte at wNameEntryText is $f0; copies the byte at wNameEntryText to wNameEntryFlag;
; calls CopyFromBankWaitVRAM (E-0347)
; why: part of RunNameEntryStateWhenNotFading; RunNameEntryStateWhenNotFading: unless a fade is
; running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryFlag::
    ld hl, wNameEntryText
    ld bc, $0000

.skip:
    ld a, [hl]
    cp $f0
    ret z
    ld [wNameEntryFlag], a
    push hl
    ld hl, GlyphFont
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld e, c
    ld d, b
    ld hl, vTiles2 + $500
    add hl, de
    pop de
    push bc
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    pop hl
    inc hl
    ld a, $10
    add c
    ld c, a
    jr nc, .skip2
    inc b

.skip2:
    jp .skip
    db $40, $95, $30, $95, $20, $95, $10, $95, $00, $95, $d9, $69, $ad, $cf, $d5, $fa
    db $2d, $c5, $ea, $31, $c5, $ea, $35, $c5, $fa, $2e, $c5, $ea, $32, $c5, $ea, $36
    db $c5, $d1, $cd, $40, $2e, $7b, $ea, $33, $c5, $ea, $37, $c5, $7a, $ea, $34, $c5
    db $ea, $38, $c5, $3e, $01, $ea, $2b, $c5, $af, $ea, $2c, $c5, $ea, $4f, $c5, $c9

; writes B at the BG map entry BGMapAddressAtScroll_Bank14 + $47 (row 2, column 7 of the view) +
; wNameEntryLength, with interrupts off after rSTAT bit 1 clears; BC kept (E-0079)
WriteTileBAtScrollOffset47PlusNameEntryLength::
    push bc
    call BGMapAddressAtScroll_Bank14_2
    ld de, $0047
    add hl, de
    ld a, [wNameEntryLength]
    add_a_to_hl
    pop bc
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld [hl], b
    ei
    ret

; fills wNameEntryText with eleven $F0 bytes, then five $9F cursor marks (E-0305)
RunNameEntryStateWhenNotFading_ClearNameEntryText::
    ld hl, wNameEntryText
    ld c, $00

.loop:
    ld a, $f0
    ld [hli], a
    inc c
    ld a, c
    cp $0b
    jr c, .loop
    ld hl, wNameEntryText
    ld c, $00

.loop2:
    ld a, $9f
    ld [hli], a
    inc c
    ld a, c
    cp $05
    jr c, .loop2
    ret

; called from RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5: sets rRAMG2 to $0a; sets
; rRAMB to 0; branches on the byte at sRecords; branches on the byte at wNameEntryText; branches on
; the byte at sRecords; branches on C; branches on the byte at sRecords; branches on wArg1; branches
; on C (E-0347)
; why: a helper of RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 0), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteRAMG2AndRAMB::
    ld hl, sRecords
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .skip3
    push bc
    push hl
    inc hl
    ld de, wNameEntryText
    ld c, $00
    ld b, $00

.skip:
    ld a, [de]
    cp $9f
    jr nz, .skip2
    inc de
    jr .skip

.skip2:
    ld a, [de]
    cp $f0
    jr z, .skip4
    push bc
    ld b, a
    ld a, [hl]
    cp b
    jr nz, .restore
    pop bc
    inc de
    inc hl
    inc c
    inc b
    jr .skip

.restore:
    pop bc

.loop2:
    pop hl
    pop bc

.skip3:
    ld a, $a5
    add_a_to_hl
    inc c
    ld a, c
    cp $1e
    jr c, .loop
    xor a
    ret

.skip4:
    ld a, c
    cp $0a
    jr z, .check_arg1
    ld a, [hl]
    cp $f0
    jr nz, .loop2

.check_arg1:
    ld a, [wArg1]
    cp $03
    jr nz, .restore2
    ld hl, wPartyList
    ld a, [wGridCursorX]
    add_a_to_hl
    ld e, [hl]
    pop hl
    pop bc
    push bc
    push hl
    ld a, c
    cp e
    jr z, .loop2

.restore2:
    pop hl
    pop bc
    ld a, $ff
    ret

; called from RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5: takes B; changes HL, DE, BC
; and A; branches on the byte at RejectedNameList; branches on the byte at wNameEntryText; branches
; on the byte at RejectedNameList; branches on C; branches on the byte at RejectedNameList; branches
; on wArg1 (E-0347)
; why: a helper of RunNameEntryStateWhenNotFading_WriteNameEntryStepAndArg5, in step 0 of
; RunNameEntryStateWhenNotFading_ReadNameEntryStep_RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
; (when wNameEntryStep = 0), in step 3 of RunNameEntryStateWhenNotFading (when wNameEntryState = 3);
; RunNameEntryStateWhenNotFading: unless a fade is running, runs the routine for wNameEntryState
; (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_ReadArg1::
    ld hl, RejectedNameList
    ld c, $00

.skip:
    ld a, [hl]
    cp $ff
    jr z, .return_0
    push bc
    push hl
    ld de, wNameEntryText
    ld c, $00
    ld b, $00

.skip2:
    ld a, [de]
    cp $9f
    jr nz, .skip3
    inc de
    jr .skip2

.skip3:
    ld a, [de]
    cp $f0
    jr z, .skip4
    push bc
    ld b, a
    ld a, [hl]
    cp b
    jr nz, .restore
    pop bc
    inc de
    inc hl
    inc c
    inc b
    jr .skip2

.restore:
    pop bc

.loop:
    pop hl
    pop bc
    ld a, $0a
    add_a_to_hl
    jr .skip

.return_0:
    xor a
    ret

.skip4:
    ld a, c
    cp $0a
    jr z, .check_arg1
    ld a, [hl]
    cp $f0
    jr nz, .loop

.check_arg1:
    ld a, [wArg1]
    cp $03
    jr nz, .restore2

.restore2:
    pop hl
    pop bc
    ld a, $ff
    ret

; walks wNameEntryText to the $9F or $F0 end, tracking dakuten marks ($8D/$8E) (E-0305)
RunNameEntryStateWhenNotFading_ScanNameEntryText::
    ld hl, wNameEntryText
    ld c, $00
    ld b, [hl]
    inc hl
    ld a, [hld]
    cp $8d
    jr z, .skip
    cp $8e
    jr z, .skip
    xor a
    ld e, $00
    jr .next

.skip:
    ld d, a
    ld e, $01
    inc hl

.next:
    inc hl

.skip2:
    ld a, [hl]
    cp $9f
    jr z, .next3
    cp $f0
    jr z, .skip5
    ld a, e
    and a
    jr z, .skip3
    ld a, [hl]
    cp $8d
    jr z, .skip4
    cp $8e
    jr z, .skip4
    ld a, [hl]
    cp b
    jr nz, .return_0
    inc hl
    ld a, [hld]
    cp $8d
    jr z, .next3
    cp $8e
    jr z, .next3
    jr .return_0

.skip3:
    ld a, [hl]
    cp b
    jr nz, .return_0
    inc hl
    ld a, [hld]
    cp $8d
    jr z, .next3
    cp $8e
    jr z, .next3
    jr .next2

.skip4:
    cp d
    jr nz, .return_0

.next2:
    inc c
    ld a, c
    cp $03
    jr nc, .skip5

.next3:
    inc hl
    jr .skip2

.skip5:
    ld a, c
    cp $03
    jr c, .skip6
    ld a, $ff
    ret

.skip6:
    ld a, b
    cp $90
    jr nz, .return_0
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; Branches on wNameEntryDrawStep; copies L to wTextWindowTileLo; copies H to wTextWindowTileHi;
; copies L to wTextWindowRows; copies H to wTextWindowWidth; calls FillTilesFromRequest; increments
; wNameEntryDrawStep; branches on wArg1; calls BeginStringDisplay; increments wNameEntryDrawStep;
; branches on wTextFlags; sets wNameEntryDrawStep to 0 (E-0347)
; why: part of RunNameEntryStateWhenNotFading; RunNameEntryStateWhenNotFading: unless a fade is
; running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_FillTilesFromRequest::
    ld a, [wNameEntryDrawStep]
    and a
    jr z, .set_text_window_tile_lo
    cp $01
    jr z, .check_arg1
    jr .check_text_flags

.set_text_window_tile_lo:
    ld hl, vTiles2 + $5c0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wNameEntryDrawStep]
    inc a
    ld [wNameEntryDrawStep], a
    xor a
    ret

.check_arg1:
    ld a, [wArg1]
    cp $03
    jr z, .call_begin_string_display
    ld de, RunNameEntryStateWhenNotFading_FillTilesFromRequest_StringCategories
    jr .call_begin_string_display2

.call_begin_string_display:
    ld de, RunNameEntryStateWhenNotFading_FillTilesFromRequest_StringCategories_2

.call_begin_string_display2:
    call BeginStringDisplay
    ld a, [wNameEntryDrawStep]
    inc a
    ld [wNameEntryDrawStep], a
    xor a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    bit 0, a
    jr nz, .return_0
    xor a
    ld [wNameEntryDrawStep], a
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY);
; clobbers A, DE (the same 41 bytes appear in 3 banks) (E-0351)
BGMapAddressAtScroll_Bank14_2::
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
    ld l, a
    ld a, d
    ld h, a
    ret

; Calls CopyFromBankWaitVRAM; increments wNameEntryTimer; continues in
; RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2; sets wNameEntryTimer to 0;
; sets wNameEntryTimer2 to 0 (E-0347)
; why: part of RunNameEntryStateWhenNotFading; RunNameEntryStateWhenNotFading: unless a fade is
; running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2::
    push hl
    push de
    ld a, [wNameEntryTimer]
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jp z, .restore
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wNameEntryTimer]
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wNameEntryTimer]
    inc a
    ld [wNameEntryTimer], a
    jr RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2

.restore:
    pop de
    pop hl
    xor a
    ld [wNameEntryTimer], a
    ld [wNameEntryTimer2], a
    ld a, $ff
    ret

; copies the 16-byte tile at CopyTileForNameEntryLength_Data2 to the VRAM address from the word
; table CopyTileForNameEntryLength_Data1 + 2 * wNameEntryLength (CopyTileBytesToVRAM_Bank14)
; (E-0119)
CopyTileForNameEntryLength::
    ld hl, CopyTileForNameEntryLength_Data1
    ld a, [wNameEntryLength]
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld de, CopyTileForNameEntryLength_Data2
    call CopyTileBytesToVRAM_Bank14
    ret

; data read by CopyTileForNameEntryLength (10 bytes) (E-0347)
CopyTileForNameEntryLength_Data1::
    db $00, $95, $10, $95, $20, $95, $30, $95, $40, $95

CopyTileForNameEntryLength_Data2::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00

; called from RunNameEntryStateWhenNotFading_WriteNameEntryStateAndArg5: may continue in
; CopyF0StringAndRedrawNameEntry_CheckArg2; branches on B; calls CopyF0StringAndRedrawNameEntry
; (E-0347)
; why: a helper of RunNameEntryStateWhenNotFading_WriteNameEntryStateAndArg5, in step 3 of
; RunNameEntryStateWhenNotFading_ReadNameEntrySubState (when wNameEntrySubState = 3), in step 1 of
; RunNameEntryStateWhenNotFading (when wNameEntryState = 1); RunNameEntryStateWhenNotFading: unless
; a fade is running, runs the routine for wNameEntryState (jump table of eight) (E-0352, E-0122)
RunNameEntryStateWhenNotFading_CheckArg1::
    ld a, [wArg1]
    or a
    jp z, CopyF0StringAndRedrawNameEntry_CheckArg2
    ld a, [wRandomLo]
    ld b, a

.skip:
    ld a, b
    cp $4d
    jr c, .skip2
    sub $4d
    ld b, a
    jr .skip

.skip2:
    and $7f
    cp $07
    jp nc, .skip4
    ld b, a
    ld hl, DefaultMonsterNameTable
    ld a, [wArg3]
    and $0f
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wArg2]
    ld c, a
    add a
    add c
    ld c, a
    ld a, [wArg2]
    add a
    add a
    add c
    ld c, a
    ld a, b
    add c
    add a
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wNameEntryText
    call CopyF0StringAndRedrawNameEntry
    ret

.skip4:
    sub $07
    ld b, a
    push bc
    ld a, [wArg2]
    and $01
    ld c, $46
    call Multiply8
    pop bc
    ld a, b
    add l
    ld de, NameEntrySuggestionTable
    ld l, a
    ld h, $00
    sla l
    rl h
    add hl, de
    ld e, l
    ld d, h
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wNameEntryText
    call CopyF0StringAndRedrawNameEntry
    ret

; copies the $F0-terminated string at HL to DE, then erases the name-entry cursor tile and redraws
; wNameEntryText glyph by glyph (handling the $9F cursor end and the $8D/$8E voicing marks) (E-0175)
CopyF0StringAndRedrawNameEntry::
    ld a, [hl]
    cp $f0
    jr z, CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL
    ld [de], a
    inc de
    inc hl
    jr CopyF0StringAndRedrawNameEntry

; Calls WriteTileBAtScrollOffset47PlusNameEntryLength; branches on the byte at wNameEntryText; sets
; wNameEntryMarkPending to 1; branches on C; sets wNameEntryLength to 4; calls
; WriteTileBAtScrollOffset47PlusNameEntryLength (E-0347)
; why: part of CopyF0StringAndRedrawNameEntry; CopyF0StringAndRedrawNameEntry: copies the
; $F0-terminated string at HL to DE, then erases the name-entry cursor tile and redraws
; wNameEntryText glyph by glyph (handling ... (E-0352, E-0175)
CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL::
    ld b, $c3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld hl, wNameEntryText
    ld c, $00

.skip:
    ld a, [hl]
    cp $f0
    jr z, .set_name_entry_mark_pending_to_01
    cp $9f
    jr z, .skip2
    cp $8d
    jr z, .next
    cp $8e
    jr z, .next
    inc c

.next:
    inc hl
    jr .skip

.set_name_entry_mark_pending_to_01:
    ld a, $01
    ld [wNameEntryMarkPending], a

.skip2:
    ld a, c
    cp $05
    jr c, .set_name_entry_length
    ld a, $04

.set_name_entry_length:
    ld [wNameEntryLength], a
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ret

; Changes HL and A; branches on wArg2; continues in
; CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL (E-0347)
; why: part of CopyF0StringAndRedrawNameEntry; CopyF0StringAndRedrawNameEntry: copies the
; $F0-terminated string at HL to DE, then erases the name-entry cursor tile and redraws
; wNameEntryText glyph by glyph (handling ... (E-0352, E-0175)
CopyF0StringAndRedrawNameEntry_CheckArg2::
    ld a, [wArg2]
    or a
    jr nz, .skip
    ld hl, wNameEntryText
    ld hl, wNameEntryText
    ld a, $0c
    ld [hli], a
    ld a, $32
    ld [hli], a
    ld a, $25
    ld [hli], a
    ld a, $2c
    ld [hl], a
    jr .skip2

.skip:
    ld hl, wNameEntryText
    ld hl, wNameEntryText
    ld a, $1d
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld a, $35
    ld [hli], a
    ld a, $24
    ld [hl], a

.skip2:
    jr CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL

; RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2 copies 16 bytes from bank $1F
; for each destination word (until a low byte of $FF) from the parallel source list in DE;
; CloseHibernateMenu_LoadTileListSixPerCall also passes $6D84, entry 23 of this list, to
; LoadTileListSixPerCall (E-0224, C1)
; record: 79 VRAM destinations, then $FFFF
NameEntryTileDestList::
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $a0, vTiles2 + $b0, vTiles2 + $c0, vTiles2 + $d0, vTiles2 + $e0, vTiles2 + $f0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1a0, vTiles2 + $1b0, vTiles2 + $1c0, vTiles2 + $1d0, vTiles2 + $1e0, vTiles2 + $1f0, vTiles2 + $200, vTiles2 + $210
    dw vTiles2 + $220, vTiles2 + $230, vTiles2 + $240, vTiles2 + $250, vTiles2 + $260, vTiles2 + $270, vTiles2 + $280, vTiles2 + $290
    dw vTiles2 + $2a0, vTiles2 + $2b0, vTiles2 + $2c0, vTiles2 + $2d0, vTiles2 + $2e0, vTiles2 + $2f0, vTiles2 + $300, vTiles2 + $310
    dw vTiles2 + $320, vTiles2 + $330, vTiles2 + $340, vTiles2 + $350, vTiles2 + $360, vTiles2 + $370, vTiles2 + $380, vTiles2 + $390
    dw vTiles2 + $3a0, vTiles2 + $3b0, vTiles2 + $3c0, vTiles2 + $3d0, vTiles2 + $3e0, vTiles2 + $3f0, vTiles2 + $400, vTiles2 + $410
    dw vTiles2 + $420, vTiles2 + $430, vTiles2 + $440, vTiles2 + $450, vTiles2 + $460, vTiles2 + $470, vTiles2 + $480, vTiles2 + $490
    dw vTiles2 + $4a0, vTiles2 + $4b0, vTiles2 + $500, vTiles2 + $510, vTiles2 + $520, vTiles2 + $530, vTiles2 + $540, rIE

; RunNameEntryStateWhenNotFading_OrFromBankWaitVRAM and _Case09 pass this list to
; RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryTimer2, which therefore copies
; nothing (E-0224, C1)
; record: $FFFF: no destinations
NameEntryTileDestListEmpty::
    dw $ffff ; entry 0

; the source list paired with NameEntryTileDestList
; (RunNameEntryStateWhenNotFading_Setup_WriteNameEntrySubStateAndArg5) and with the empty list
; (RunNameEntryStateWhenNotFading_WriteNameEntrySubStateAndArg5) (E-0224, C1)
; record: 80 bank-$1F tile sources (the last is $FFFF)
NameEntryTileSrcListA::
    dw $40b0, $40c0, $40d0, $40e0, $40f0, $4100, $4110, $4120 ; entry 0
    dw $4130, $4140, $4150, $4160, $4170, $4010, $4020, $4030
    dw $4040, $4180, $4190, $41a0, $41b0, $41c0, $41d0, $41e0
    dw $41f0, $4200, $4210, $4220, $4230, $4240, $4050, $4060
    dw $4070, $4080, $4250, $4260, $4270, $4280, $4290, $42a0
    dw $42b0, $42c0, $42d0, $42e0, $42f0, $4300, $4310, $4090
    dw $40a0, $49a0, $4990, $4320, $4330, $4340, $4350, $4360
    dw $4370, $4380, $4390, $43a0, $43b0, $43c0, $43d0, $43e0
    dw $40c0, $40b0, $40d0, $4150, $4960, $4ac0, $4b60, $4950
    dw $4940, $4b00, $4a00, $4a00, $4a00, $4a00, $4a00, $ffff

; passed with the empty destination list by RunNameEntryStateWhenNotFading_OrFromBankWaitVRAM; 82
; words and $FFFF, then 16 bytes of $FF before NameEntryKeyboard (E-0224, C1)
; record: 82 bank-$1F tile sources, then $FFFF
NameEntryTileSrcListB::
    dw $4570, $4590, $45b0, $45d0, $45f0, $4610, $4620, $4630 ; entry 0
    dw $4640, $4650, $4660, $4670, $4680, $4690, $46a0, $46b0
    dw $46c0, $46d0, $46f0, $4700, $4710, $4720, $4730, $4740
    dw $4750, $4020, $4030, $4040, $4050, $4060, $4760, $4770
    dw $4780, $4790, $47a0, $47b0, $47c0, $47d0, $47e0, $47f0
    dw $4800, $4820, $4840, $4860, $4870, $4880, $4890, $48a0
    dw $48b0, $48c0, $48d0, $46e0, $49d0, $4070, $4080, $4090
    dw $40a0, $4010, $4580, $45a0, $45c0, $45e0, $4600, $4810
    dw $4830, $4850, $48e0, $48f0, $4400, $44f0, $42a0, $43a0
    dw $4480, $4510, $4290, $4540, $4510, $4a00, $4a00, $4a00
    dw $4a00, $4a00, $ffff
    db $ff, $00, $ff, $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; end

; RunNameEntryStateWhenNotFading_ReadNameEntryCursorY reads the byte at $6F4E + 17 *
; wNameEntryCursorY + wNameEntryCursorX as the chosen character; rows 0-3 are A-M 0-3, N-Z 4-7, a-m
; 8 9 ! ?, n-z; 10 rows, then 11 bytes not placed in a row (E-0216, C1)
; record: one row of 17 character codes (charmap.inc; codes without a charmap entry print as bytes)
NameEntryKeyboard::
    db "ABCDEFGHIJKLM0123" ; id 0
    db "NOPQRSTUVWXYZ4567" ; id 1
    db "abcdefghijklm89!?" ; id 2
    db "nopqrstuvwxyz<BEEP_OFF><CHOICE>", "<CHOICE>", "<CHOICE>" ; id 3
    db "',.", $94, $93, " <CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>" ; id 4
    db $56, $58, $5a, $5c, $5e, $75, $76, $77, $78, $79, $57, $59, $5b, $5d, $5f, "<CHOICE>", $60 ; id 5
    db $61, $62, $63, $64, $7a, $7b, $7c, $7d, $7e, $80, $82, $84, $8d, $8e, "<CHOICE>", $65, $66 ; id 6
    db $67, $68, $69, $7f, "<CHOICE>", $81, "<CHOICE>", $83, "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", $6a, $6b, $6c ; id 7
    db $6e, $6f, $85, $86, $87, $88, $89, "<BEEP_ON><CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", $70, $71, $72, $73 ; id 8
    db $74, $8a, $8b, $8c, $6d, "-<BEEP_OFF><CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "<CHOICE>", "12345" ; id 9
    db $06, $07, $08, $09, $00, $ff, $ff, $ff, $ff, $ff, $ff ; end

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
RunNameEntryStateWhenNotFading_FillTilesFromRequest_StringCategories::
    dw StringList_FillTilesFromRequest_StringCategories_0 ; id 0

; category list of RunNameEntryStateWhenNotFading_FillTilesFromRequest_StringCategories; one pointer
; per wStringIndex (E-0217)
; record: string
StringList_FillTilesFromRequest_StringCategories_0::
    dw Text_IsCorrect ; id 0
    dw Text_IsCorrect_2 ; id 1
    dw Text_AMonsterAlreadyHas ; id 2
    dw Text_SorryThatNameCant ; id 3

Text_IsCorrect::
    db "Is <BUF0> correct?@"

Text_IsCorrect_2::
    db "Is <BUF0> correct?@"

Text_AMonsterAlreadyHas::
    db "A monster already<LINE>"
    db "has that name.<WAIT>"
    db "@"

Text_SorryThatNameCant::
    db "Sorry, that name<LINE>"
    db "can't be used.<WAIT>"
    db "@"

RunNameEntryStateWhenNotFading_FillTilesFromRequest_StringCategories_2::
    dw StringList_FillTilesFromRequest_StringCategories_2_0 ; id 0

; category list of RunNameEntryStateWhenNotFading_FillTilesFromRequest_StringCategories_2; one
; pointer per wStringIndex (E-0217)
StringList_FillTilesFromRequest_StringCategories_2_0::
    dw Text_IsOK ; id 0
    dw Text_IsOK_2 ; id 1
    dw Text_ThatNameIsAlready ; id 2
    dw Text_ThatNameCantBe ; id 3

Text_IsOK::
    db "<VOICE2>*: Is <BUF0> OK?@"

Text_IsOK_2::
    db "<VOICE2>*: Is <BUF0> OK?@"

Text_ThatNameIsAlready::
    db "<VOICE2>*: That name is<LINE>"
    db "already in use.<WAIT>"
    db "@"

Text_ThatNameCantBe::
    db "<VOICE2>*: That name can't<LINE>"
    db "be used.<PROMPT>"
    db "<CLEAR>You'll have to use<LINE>"
    db "another name.<WAIT>"
    db "@"

; RunNameEntryStateWhenNotFading_ReadArg1 walks 10-byte records from $70F0 until a first byte of
; $FF, comparing each with wNameEntryText (skipping $9F bytes) up to its $F0; 84 records, each in
; mixed case and capitals, then the $FF terminator (E-0191, C1)
; record: a name the name entry screen refuses: text ending in $F0, zero padded to 10 bytes
RejectedNameList::
    db "Ass@", $00, $00, $00, $00, $00, $00 ; id 0
    db "ASS@", $00, $00, $00, $00, $00, $00 ; id 1
    db "Dink@", $00, $00, $00, $00, $00 ; id 2
    db "DINK@", $00, $00, $00, $00, $00 ; id 3
    db "Dork@", $00, $00, $00, $00, $00 ; id 4
    db "DORK@", $00, $00, $00, $00, $00 ; id 5
    db "Cunt@", $00, $00, $00, $00, $00 ; id 6
    db "CUNT@", $00, $00, $00, $00, $00 ; id 7
    db "Kunt@", $00, $00, $00, $00, $00 ; id 8
    db "KUNT@", $00, $00, $00, $00, $00 ; id 9
    db "Fuck@", $00, $00, $00, $00, $00 ; id 10
    db "FUCK@", $00, $00, $00, $00, $00 ; id 11
    db "Shit@", $00, $00, $00, $00, $00 ; id 12
    db "SHIT@", $00, $00, $00, $00, $00 ; id 13
    db "Sex@", $00, $00, $00, $00, $00, $00 ; id 14
    db "SEX@", $00, $00, $00, $00, $00, $00 ; id 15
    db "Poop@", $00, $00, $00, $00, $00 ; id 16
    db "POOP@", $00, $00, $00, $00, $00 ; id 17
    db "Dong@", $00, $00, $00, $00, $00 ; id 18
    db "DONG@", $00, $00, $00, $00, $00 ; id 19
    db "Pene@", $00, $00, $00, $00, $00 ; id 20
    db "PENE@", $00, $00, $00, $00, $00 ; id 21
    db "Clit@", $00, $00, $00, $00, $00 ; id 22
    db "CLIT@", $00, $00, $00, $00, $00 ; id 23
    db "Twat@", $00, $00, $00, $00, $00 ; id 24
    db "TWAT@", $00, $00, $00, $00, $00 ; id 25
    db "Snot@", $00, $00, $00, $00, $00 ; id 26
    db "SNOT@", $00, $00, $00, $00, $00 ; id 27
    db "Fag@", $00, $00, $00, $00, $00, $00 ; id 28
    db "FAG@", $00, $00, $00, $00, $00, $00 ; id 29
    db "Homo@", $00, $00, $00, $00, $00 ; id 30
    db "HOMO@", $00, $00, $00, $00, $00 ; id 31
    db "Poon@", $00, $00, $00, $00, $00 ; id 32
    db "POON@", $00, $00, $00, $00, $00 ; id 33
    db "Piss@", $00, $00, $00, $00, $00 ; id 34
    db "PISS@", $00, $00, $00, $00, $00 ; id 35
    db "Prick@", $00, $00, $00, $00 ; id 36
    db "PRICK@", $00, $00, $00, $00 ; id 37
    db "Fukk@", $00, $00, $00, $00, $00 ; id 38
    db "FUKK@", $00, $00, $00, $00, $00 ; id 39
    db "Coon@", $00, $00, $00, $00, $00 ; id 40
    db "COON@", $00, $00, $00, $00, $00 ; id 41
    db "Nazi@", $00, $00, $00, $00, $00 ; id 42
    db "NAZI@", $00, $00, $00, $00, $00 ; id 43
    db "Niga@", $00, $00, $00, $00, $00 ; id 44
    db "NIGA@", $00, $00, $00, $00, $00 ; id 45
    db "Nigga@", $00, $00, $00, $00 ; id 46
    db "NIGGA@", $00, $00, $00, $00 ; id 47
    db "Jap@", $00, $00, $00, $00, $00, $00 ; id 48
    db "JAP@", $00, $00, $00, $00, $00, $00 ; id 49
    db "Jew@", $00, $00, $00, $00, $00, $00 ; id 50
    db "JEW@", $00, $00, $00, $00, $00, $00 ; id 51
    db "Wop@", $00, $00, $00, $00, $00, $00 ; id 52
    db "WOP@", $00, $00, $00, $00, $00, $00 ; id 53
    db "Spic@", $00, $00, $00, $00, $00 ; id 54
    db "SPIC@", $00, $00, $00, $00, $00 ; id 55
    db "Butt@", $00, $00, $00, $00, $00 ; id 56
    db "BUTT@", $00, $00, $00, $00, $00 ; id 57
    db "Perv@", $00, $00, $00, $00, $00 ; id 58
    db "PERV@", $00, $00, $00, $00, $00 ; id 59
    db "Dumb@", $00, $00, $00, $00, $00 ; id 60
    db "DUMB@", $00, $00, $00, $00, $00 ; id 61
    db "Dolt@", $00, $00, $00, $00, $00 ; id 62
    db "DOLT@", $00, $00, $00, $00, $00 ; id 63
    db "Anus@", $00, $00, $00, $00, $00 ; id 64
    db "ANUS@", $00, $00, $00, $00, $00 ; id 65
    db "Anal@", $00, $00, $00, $00, $00 ; id 66
    db "ANAL@", $00, $00, $00, $00, $00 ; id 67
    db "Jerk@", $00, $00, $00, $00, $00 ; id 68
    db "JERK@", $00, $00, $00, $00, $00 ; id 69
    db "Puke@", $00, $00, $00, $00, $00 ; id 70
    db "PUKE@", $00, $00, $00, $00, $00 ; id 71
    db "Snot@", $00, $00, $00, $00, $00 ; id 72
    db "SNOT@", $00, $00, $00, $00, $00 ; id 73
    db "Barf@", $00, $00, $00, $00, $00 ; id 74
    db "BARF@", $00, $00, $00, $00, $00 ; id 75
    db "Pus@", $00, $00, $00, $00, $00, $00 ; id 76
    db "PUS@", $00, $00, $00, $00, $00, $00 ; id 77
    db "Pussy@", $00, $00, $00, $00 ; id 78
    db "PUSSY@", $00, $00, $00, $00 ; id 79
    db "Bung@", $00, $00, $00, $00, $00 ; id 80
    db "BUNG@", $00, $00, $00, $00, $00 ; id 81
    db "Suck@", $00, $00, $00, $00, $00 ; id 82
    db "SUCK@", $00, $00, $00, $00, $00 ; id 83
    db $ff ; end

; the code before RunNameEntryStateWhenNotFading_CheckArg1.skip3 indexes it with wArg3 & $0F (the
; family as StringTable_MonsterFamilies: 0 Slime, 1 Dragon, 2 Beast, 3 Bird, 4 Plant, 5 Bug, 6
; Demon, 7 Zombie, 8 Material, 9 Water, 10 '????' (boss)) and then takes name 7 * wArg2 + n;
; CreateMonsterRecordOfKindTemp1_ReadWorkBuf indexes it with wWorkBuf and wWorkBuf + 1 and copies
; the name (up to $F0, with $9F handled) to the address in wWorkBuf + 2/3; 11 families of 14 names
; (E-0254, C1)
; record: 14 name pointers for this family
DefaultMonsterNameTable::
    dw DefaultMonsterNames_Slime ; id 0
    dw DefaultMonsterNames_Dragon ; id 1
    dw DefaultMonsterNames_Beast ; id 2
    dw DefaultMonsterNames_Bird ; id 3
    dw DefaultMonsterNames_Plant ; id 4
    dw DefaultMonsterNames_Bug ; id 5
    dw DefaultMonsterNames_Demon ; id 6
    dw DefaultMonsterNames_Zombie ; id 7
    dw DefaultMonsterNames_Material ; id 8
    dw DefaultMonsterNames_Water ; id 9
    dw DefaultMonsterNames_Boss ; id 10

; family 0 (Slime) of DefaultMonsterNameTable (E-0254, C1)
; record: name
DefaultMonsterNames_Slime::
    dw DefaultMonsterNameStrings_Slime ; id 0
    dw DefaultName_Slime_01 ; id 1
    dw DefaultName_Slime_02 ; id 2
    dw DefaultName_Slime_03 ; id 3
    dw DefaultName_Slime_04 ; id 4
    dw DefaultName_Slime_05 ; id 5
    dw DefaultName_Slime_06 ; id 6
    dw DefaultName_Slime_07 ; id 7
    dw DefaultName_Slime_08 ; id 8
    dw DefaultName_Slime_09 ; id 9
    dw DefaultName_Slime_0A ; id 10
    dw DefaultName_Slime_0B ; id 11
    dw DefaultName_Slime_0C ; id 12
    dw DefaultName_Slime_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Slime (E-0254, C1)
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Slime::
DefaultName_Slime_00::
    db "Slib", $9f, "@" ; id 0
DefaultName_Slime_01::
    db "Darce@" ; id 1
DefaultName_Slime_02::
    db "Bono", $9f, "@" ; id 2
DefaultName_Slime_03::
    db "Miles@" ; id 3
DefaultName_Slime_04::
    db "Rabba@" ; id 4
DefaultName_Slime_05::
    db "Terio@" ; id 5
DefaultName_Slime_06::
    db "Oneo", $9f, "@" ; id 6
DefaultName_Slime_07::
    db "Slari@" ; id 7
DefaultName_Slime_08::
    db "Stera@" ; id 8
DefaultName_Slime_09::
    db "Purla@" ; id 9
DefaultName_Slime_0A::
    db "Cikor@" ; id 10
DefaultName_Slime_0B::
    db "Ripp", $9f, "@" ; id 11
DefaultName_Slime_0C::
    db "Petti@" ; id 12
DefaultName_Slime_0D::
    db "Chalo@" ; id 13

; family 1 (Dragon) of DefaultMonsterNameTable (E-0254, C1)
DefaultMonsterNames_Dragon::
    dw DefaultMonsterNameStrings_Dragon ; id 0
    dw DefaultName_Dragon_01 ; id 1
    dw DefaultName_Dragon_02 ; id 2
    dw DefaultName_Dragon_03 ; id 3
    dw DefaultName_Dragon_04 ; id 4
    dw DefaultName_Dragon_05 ; id 5
    dw DefaultName_Dragon_06 ; id 6
    dw DefaultName_Dragon_07 ; id 7
    dw DefaultName_Dragon_08 ; id 8
    dw DefaultName_Dragon_09 ; id 9
    dw DefaultName_Dragon_0A ; id 10
    dw DefaultName_Dragon_0B ; id 11
    dw DefaultName_Dragon_0C ; id 12
    dw DefaultName_Dragon_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Dragon (E-0254, C1)
DefaultMonsterNameStrings_Dragon::
DefaultName_Dragon_00::
    db "Horry@" ; id 0
DefaultName_Dragon_01::
    db "Kabel@" ; id 1
DefaultName_Dragon_02::
    db "Galet@" ; id 2
DefaultName_Dragon_03::
    db "Porpo@" ; id 3
DefaultName_Dragon_04::
    db "Kejet@" ; id 4
DefaultName_Dragon_05::
    db "Dorad@" ; id 5
DefaultName_Dragon_06::
    db "Baron@" ; id 6
DefaultName_Dragon_07::
    db "Rouge@" ; id 7
DefaultName_Dragon_08::
    db "Azari@" ; id 8
DefaultName_Dragon_09::
    db "Chabo@" ; id 9
DefaultName_Dragon_0A::
    db "Triss@" ; id 10
DefaultName_Dragon_0B::
    db "Runar@" ; id 11
DefaultName_Dragon_0C::
    db "Rudi", $9f, "@" ; id 12
DefaultName_Dragon_0D::
    db "Vuy", $9f, $9f, "@" ; id 13

; family 2 (Beast) of DefaultMonsterNameTable (E-0254, C1)
; record: name
DefaultMonsterNames_Beast::
    dw DefaultMonsterNameStrings_Beast ; id 0
    dw DefaultName_Beast_01 ; id 1
    dw DefaultName_Beast_02 ; id 2
    dw DefaultName_Beast_03 ; id 3
    dw DefaultName_Beast_04 ; id 4
    dw DefaultName_Beast_05 ; id 5
    dw DefaultName_Beast_06 ; id 6
    dw DefaultName_Beast_07 ; id 7
    dw DefaultName_Beast_08 ; id 8
    dw DefaultName_Beast_09 ; id 9
    dw DefaultName_Beast_0A ; id 10
    dw DefaultName_Beast_0B ; id 11
    dw DefaultName_Beast_0C ; id 12
    dw DefaultName_Beast_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Beast (E-0254, C1)
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Beast::
DefaultName_Beast_00::
    db "Uwing@" ; id 0
DefaultName_Beast_01::
    db "Iver", $9f, "@" ; id 1
DefaultName_Beast_02::
    db "Rodma@" ; id 2
DefaultName_Beast_03::
    db "Didie@" ; id 3
DefaultName_Beast_04::
    db "Margg@" ; id 4
DefaultName_Beast_05::
    db "Ogami@" ; id 5
DefaultName_Beast_06::
    db "Carro@" ; id 6
DefaultName_Beast_07::
    db "Nikit@" ; id 7
DefaultName_Beast_08::
    db "Messa@" ; id 8
DefaultName_Beast_09::
    db "Larma@" ; id 9
DefaultName_Beast_0A::
    db "Jannu@" ; id 10
DefaultName_Beast_0B::
    db "Fevri@" ; id 11
DefaultName_Beast_0C::
    db "Javel@" ; id 12
DefaultName_Beast_0D::
    db "Gurri@" ; id 13

; family 3 (Bird) of DefaultMonsterNameTable (E-0254, C1)
DefaultMonsterNames_Bird::
    dw DefaultMonsterNameStrings_Bird ; id 0
    dw DefaultName_Bird_01 ; id 1
    dw DefaultName_Bird_02 ; id 2
    dw DefaultName_Bird_03 ; id 3
    dw DefaultName_Bird_04 ; id 4
    dw DefaultName_Bird_05 ; id 5
    dw DefaultName_Bird_06 ; id 6
    dw DefaultName_Bird_07 ; id 7
    dw DefaultName_Bird_08 ; id 8
    dw DefaultName_Bird_09 ; id 9
    dw DefaultName_Bird_0A ; id 10
    dw DefaultName_Bird_0B ; id 11
    dw DefaultName_Bird_0C ; id 12
    dw DefaultName_Bird_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Bird (E-0254, C1)
DefaultMonsterNameStrings_Bird::
DefaultName_Bird_00::
    db "Patta@" ; id 0
DefaultName_Bird_01::
    db "Venjy@" ; id 1
DefaultName_Bird_02::
    db "Angy", $9f, "@" ; id 2
DefaultName_Bird_03::
    db "Rovyn@" ; id 3
DefaultName_Bird_04::
    db "Leit", $9f, "@" ; id 4
DefaultName_Bird_05::
    db "Cyron@" ; id 5
DefaultName_Bird_06::
    db "Nilse@" ; id 6
DefaultName_Bird_07::
    db "Pakin@" ; id 7
DefaultName_Bird_08::
    db "Aerr", $9f, "@" ; id 8
DefaultName_Bird_09::
    db "Samar@" ; id 9
DefaultName_Bird_0A::
    db "Kacis@" ; id 10
DefaultName_Bird_0B::
    db "Taki", $9f, "@" ; id 11
DefaultName_Bird_0C::
    db "Ralli@" ; id 12
DefaultName_Bird_0D::
    db "Moko", $9f, "@" ; id 13

; family 4 (Plant) of DefaultMonsterNameTable (E-0254, C1)
; record: name
DefaultMonsterNames_Plant::
    dw DefaultMonsterNameStrings_Plant ; id 0
    dw DefaultName_Plant_01 ; id 1
    dw DefaultName_Plant_02 ; id 2
    dw DefaultName_Plant_03 ; id 3
    dw DefaultName_Plant_04 ; id 4
    dw DefaultName_Plant_05 ; id 5
    dw DefaultName_Plant_06 ; id 6
    dw DefaultName_Plant_07 ; id 7
    dw DefaultName_Plant_08 ; id 8
    dw DefaultName_Plant_09 ; id 9
    dw DefaultName_Plant_0A ; id 10
    dw DefaultName_Plant_0B ; id 11
    dw DefaultName_Plant_0C ; id 12
    dw DefaultName_Plant_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Plant (E-0254, C1)
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Plant::
DefaultName_Plant_00::
    db "Ganim@" ; id 0
DefaultName_Plant_01::
    db "Belri@" ; id 1
DefaultName_Plant_02::
    db "Taim", $9f, "@" ; id 2
DefaultName_Plant_03::
    db "Sarzz@" ; id 3
DefaultName_Plant_04::
    db "Cita", $9f, "@" ; id 4
DefaultName_Plant_05::
    db "Peyot@" ; id 5
DefaultName_Plant_06::
    db "Muppa@" ; id 6
DefaultName_Plant_07::
    db "Laven@" ; id 7
DefaultName_Plant_08::
    db "Sarad@" ; id 8
DefaultName_Plant_09::
    db "Gyam", $9f, "@" ; id 9
DefaultName_Plant_0A::
    db "Gummy@" ; id 10
DefaultName_Plant_0B::
    db "Pupul@" ; id 11
DefaultName_Plant_0C::
    db "Vanyl@" ; id 12
DefaultName_Plant_0D::
    db "Popla@" ; id 13

; family 5 (Bug) of DefaultMonsterNameTable (E-0254, C1)
DefaultMonsterNames_Bug::
    dw DefaultMonsterNameStrings_Bug ; id 0
    dw DefaultName_Bug_01 ; id 1
    dw DefaultName_Bug_02 ; id 2
    dw DefaultName_Bug_03 ; id 3
    dw DefaultName_Bug_04 ; id 4
    dw DefaultName_Bug_05 ; id 5
    dw DefaultName_Bug_06 ; id 6
    dw DefaultName_Bug_07 ; id 7
    dw DefaultName_Bug_08 ; id 8
    dw DefaultName_Bug_09 ; id 9
    dw DefaultName_Bug_0A ; id 10
    dw DefaultName_Bug_0B ; id 11
    dw DefaultName_Bug_0C ; id 12
    dw DefaultName_Bug_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Bug (E-0254, C1)
DefaultMonsterNameStrings_Bug::
DefaultName_Bug_00::
    db "Abii", $9f, "@" ; id 0
DefaultName_Bug_01::
    db "Ulrik@" ; id 1
DefaultName_Bug_02::
    db "Werth@" ; id 2
DefaultName_Bug_03::
    db "Grunt@" ; id 3
DefaultName_Bug_04::
    db "Glath@" ; id 4
DefaultName_Bug_05::
    db "Gamha@" ; id 5
DefaultName_Bug_06::
    db "Moahm@" ; id 6
DefaultName_Bug_07::
    db "Maron@" ; id 7
DefaultName_Bug_08::
    db "Quii", $9f, "@" ; id 8
DefaultName_Bug_09::
    db "Kokis@" ; id 9
DefaultName_Bug_0A::
    db "Juddi@" ; id 10
DefaultName_Bug_0B::
    db "Sherr@" ; id 11
DefaultName_Bug_0C::
    db "Pliss@" ; id 12
DefaultName_Bug_0D::
    db "Guvri@" ; id 13

; family 6 (Demon) of DefaultMonsterNameTable (E-0254, C1)
; record: name
DefaultMonsterNames_Demon::
    dw DefaultMonsterNameStrings_Demon ; id 0
    dw DefaultName_Demon_01 ; id 1
    dw DefaultName_Demon_02 ; id 2
    dw DefaultName_Demon_03 ; id 3
    dw DefaultName_Demon_04 ; id 4
    dw DefaultName_Demon_05 ; id 5
    dw DefaultName_Demon_06 ; id 6
    dw DefaultName_Demon_07 ; id 7
    dw DefaultName_Demon_08 ; id 8
    dw DefaultName_Demon_09 ; id 9
    dw DefaultName_Demon_0A ; id 10
    dw DefaultName_Demon_0B ; id 11
    dw DefaultName_Demon_0C ; id 12
    dw DefaultName_Demon_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Demon (E-0254, C1)
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Demon::
DefaultName_Demon_00::
    db "Damia@" ; id 0
DefaultName_Demon_01::
    db "Qube", $9f, "@" ; id 1
DefaultName_Demon_02::
    db "Rigg", $9f, "@" ; id 2
DefaultName_Demon_03::
    db "Jaxon@" ; id 3
DefaultName_Demon_04::
    db "Phel", $9f, "@" ; id 4
DefaultName_Demon_05::
    db "Fauss@" ; id 5
DefaultName_Demon_06::
    db "Ancho@" ; id 6
DefaultName_Demon_07::
    db "Iyan", $9f, "@" ; id 7
DefaultName_Demon_08::
    db "Irris@" ; id 8
DefaultName_Demon_09::
    db "Kerig@" ; id 9
DefaultName_Demon_0A::
    db "Kaico@" ; id 10
DefaultName_Demon_0B::
    db "Calor@" ; id 11
DefaultName_Demon_0C::
    db "Aknes@" ; id 12
DefaultName_Demon_0D::
    db "Nivel@" ; id 13

; family 7 (Zombie) of DefaultMonsterNameTable (E-0254, C1)
DefaultMonsterNames_Zombie::
    dw DefaultMonsterNameStrings_Zombie ; id 0
    dw DefaultName_Zombie_01 ; id 1
    dw DefaultName_Zombie_02 ; id 2
    dw DefaultName_Zombie_03 ; id 3
    dw DefaultName_Zombie_04 ; id 4
    dw DefaultName_Zombie_05 ; id 5
    dw DefaultName_Zombie_06 ; id 6
    dw DefaultName_Zombie_07 ; id 7
    dw DefaultName_Zombie_08 ; id 8
    dw DefaultName_Zombie_09 ; id 9
    dw DefaultName_Zombie_0A ; id 10
    dw DefaultName_Zombie_0B ; id 11
    dw DefaultName_Zombie_0C ; id 12
    dw DefaultName_Zombie_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Zombie (E-0254, C1)
DefaultMonsterNameStrings_Zombie::
DefaultName_Zombie_00::
    db "Gley", $9f, "@" ; id 0
DefaultName_Zombie_01::
    db "Veron@" ; id 1
DefaultName_Zombie_02::
    db "Donad@" ; id 2
DefaultName_Zombie_03::
    db "Fobos@" ; id 3
DefaultName_Zombie_04::
    db "Junas@" ; id 4
DefaultName_Zombie_05::
    db "Dupel@" ; id 5
DefaultName_Zombie_06::
    db "Drolo@" ; id 6
DefaultName_Zombie_07::
    db "Tumi", $9f, "@" ; id 7
DefaultName_Zombie_08::
    db "Kyar", $9f, "@" ; id 8
DefaultName_Zombie_09::
    db "Rozar@" ; id 9
DefaultName_Zombie_0A::
    db "Kyrie@" ; id 10
DefaultName_Zombie_0B::
    db "Pina", $9f, "@" ; id 11
DefaultName_Zombie_0C::
    db "Myran@" ; id 12
DefaultName_Zombie_0D::
    db "Pando@" ; id 13

; family 8 (Material) of DefaultMonsterNameTable (E-0254, C1)
; record: name
DefaultMonsterNames_Material::
    dw DefaultMonsterNameStrings_Material ; id 0
    dw DefaultName_Material_01 ; id 1
    dw DefaultName_Material_02 ; id 2
    dw DefaultName_Material_03 ; id 3
    dw DefaultName_Material_04 ; id 4
    dw DefaultName_Material_05 ; id 5
    dw DefaultName_Material_06 ; id 6
    dw DefaultName_Material_07 ; id 7
    dw DefaultName_Material_08 ; id 8
    dw DefaultName_Material_09 ; id 9
    dw DefaultName_Material_0A ; id 10
    dw DefaultName_Material_0B ; id 11
    dw DefaultName_Material_0C ; id 12
    dw DefaultName_Material_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Material (E-0254, C1)
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Material::
DefaultName_Material_00::
    db "Kheri@" ; id 0
DefaultName_Material_01::
    db "Nesta@" ; id 1
DefaultName_Material_02::
    db "Anvar@" ; id 2
DefaultName_Material_03::
    db "Vyng", $9f, "@" ; id 3
DefaultName_Material_04::
    db "Olyva@" ; id 4
DefaultName_Material_05::
    db "Fridz@" ; id 5
DefaultName_Material_06::
    db "Iwan", $9f, "@" ; id 6
DefaultName_Material_07::
    db "Yssa", $9f, "@" ; id 7
DefaultName_Material_08::
    db "Revvi@" ; id 8
DefaultName_Material_09::
    db "Opall@" ; id 9
DefaultName_Material_0A::
    db "Jidda@" ; id 10
DefaultName_Material_0B::
    db "Murri@" ; id 11
DefaultName_Material_0C::
    db "Thina@" ; id 12
DefaultName_Material_0D::
    db "Yoori@" ; id 13

; family 9 (Water) of DefaultMonsterNameTable (E-0254, C1)
DefaultMonsterNames_Water::
    dw DefaultMonsterNameStrings_Water ; id 0
    dw DefaultName_Water_01 ; id 1
    dw DefaultName_Water_02 ; id 2
    dw DefaultName_Water_03 ; id 3
    dw DefaultName_Water_04 ; id 4
    dw DefaultName_Water_05 ; id 5
    dw DefaultName_Water_06 ; id 6
    dw DefaultName_Water_07 ; id 7
    dw DefaultName_Water_08 ; id 8
    dw DefaultName_Water_09 ; id 9
    dw DefaultName_Water_0A ; id 10
    dw DefaultName_Water_0B ; id 11
    dw DefaultName_Water_0C ; id 12
    dw DefaultName_Water_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Water (E-0254, C1)
DefaultMonsterNameStrings_Water::
DefaultName_Water_00::
    db "Izak", $9f, "@" ; id 0
DefaultName_Water_01::
    db "Walli@" ; id 1
DefaultName_Water_02::
    db "Soda", $9f, "@" ; id 2
DefaultName_Water_03::
    db "Evi", $9f, $9f, "@" ; id 3
DefaultName_Water_04::
    db "Reny", $9f, "@" ; id 4
DefaultName_Water_05::
    db "Jawah@" ; id 5
DefaultName_Water_06::
    db "Tavin@" ; id 6
DefaultName_Water_07::
    db "Cyaci@" ; id 7
DefaultName_Water_08::
    db "Mizur@" ; id 8
DefaultName_Water_09::
    db "Purll@" ; id 9
DefaultName_Water_0A::
    db "Oasiz@" ; id 10
DefaultName_Water_0B::
    db "Nadea@" ; id 11
DefaultName_Water_0C::
    db "Lua", $9f, $9f, "@" ; id 12
DefaultName_Water_0D::
    db "Dovin@" ; id 13

; family 10 (Boss) of DefaultMonsterNameTable (E-0254, C1)
; record: name
DefaultMonsterNames_Boss::
    dw DefaultMonsterNameStrings_Boss ; id 0
    dw DefaultName_Boss_01 ; id 1
    dw DefaultName_Boss_02 ; id 2
    dw DefaultName_Boss_03 ; id 3
    dw DefaultName_Boss_04 ; id 4
    dw DefaultName_Boss_05 ; id 5
    dw DefaultName_Boss_06 ; id 6
    dw DefaultName_Boss_07 ; id 7
    dw DefaultName_Boss_08 ; id 8
    dw DefaultName_Boss_09 ; id 9
    dw DefaultName_Boss_0A ; id 10
    dw DefaultName_Boss_0B ; id 11
    dw DefaultName_Boss_0C ; id 12
    dw DefaultName_Boss_0D ; id 13

; the 14 six-byte names of DefaultMonsterNames_Boss (E-0254, C1)
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Boss::
DefaultName_Boss_00::
    db "Hevnz@" ; id 0
DefaultName_Boss_01::
    db "Hadez@" ; id 1
DefaultName_Boss_02::
    db "Makro@" ; id 2
DefaultName_Boss_03::
    db "Oskro@" ; id 3
DefaultName_Boss_04::
    db "Mirio@" ; id 4
DefaultName_Boss_05::
    db "Fasis@" ; id 5
DefaultName_Boss_06::
    db "Akull@" ; id 6
DefaultName_Boss_07::
    db "Ledah@" ; id 7
DefaultName_Boss_08::
    db "Ulph", $9f, "@" ; id 8
DefaultName_Boss_09::
    db "Wyll", $9f, "@" ; id 9
DefaultName_Boss_0A::
    db "Wev", $9f, $9f, "@" ; id 10
DefaultName_Boss_0B::
    db "Sesil@" ; id 11
DefaultName_Boss_0C::
    db "Syall@" ; id 12
DefaultName_Boss_0D::
    db "Waltz@" ; id 13

; the routine ending at $6CE9 copies the name at word [$791F + 2 * (70 * (wArg2 & 1) + B)] to
; wNameEntryText (CopyF0StringAndRedrawNameEntry); 140 words, two sets of 70 (E-0254, C1)
; record: suggested name
NameEntrySuggestionTable::
    dw NameEntrySuggestions ; id 0
    dw SuggestedName_01 ; id 1
    dw SuggestedName_02 ; id 2
    dw SuggestedName_03 ; id 3
    dw SuggestedName_04 ; id 4
    dw SuggestedName_05 ; id 5
    dw SuggestedName_06 ; id 6
    dw SuggestedName_07 ; id 7
    dw SuggestedName_08 ; id 8
    dw SuggestedName_09 ; id 9
    dw SuggestedName_0A ; id 10
    dw SuggestedName_0B ; id 11
    dw SuggestedName_0C ; id 12
    dw SuggestedName_0D ; id 13
    dw SuggestedName_0E ; id 14
    dw SuggestedName_0F ; id 15
    dw SuggestedName_10 ; id 16
    dw SuggestedName_11 ; id 17
    dw SuggestedName_12 ; id 18
    dw SuggestedName_13 ; id 19
    dw SuggestedName_14 ; id 20
    dw SuggestedName_15 ; id 21
    dw SuggestedName_16 ; id 22
    dw SuggestedName_17 ; id 23
    dw SuggestedName_18 ; id 24
    dw SuggestedName_19 ; id 25
    dw SuggestedName_1A ; id 26
    dw SuggestedName_1B ; id 27
    dw SuggestedName_1C ; id 28
    dw SuggestedName_1D ; id 29
    dw SuggestedName_1E ; id 30
    dw SuggestedName_1F ; id 31
    dw SuggestedName_20 ; id 32
    dw SuggestedName_21 ; id 33
    dw SuggestedName_22 ; id 34
    dw SuggestedName_23 ; id 35
    dw SuggestedName_24 ; id 36
    dw SuggestedName_25 ; id 37
    dw SuggestedName_26 ; id 38
    dw SuggestedName_27 ; id 39
    dw SuggestedName_28 ; id 40
    dw SuggestedName_29 ; id 41
    dw SuggestedName_2A ; id 42
    dw SuggestedName_2B ; id 43
    dw SuggestedName_2C ; id 44
    dw SuggestedName_2D ; id 45
    dw SuggestedName_2E ; id 46
    dw SuggestedName_2F ; id 47
    dw SuggestedName_30 ; id 48
    dw SuggestedName_31 ; id 49
    dw SuggestedName_32 ; id 50
    dw SuggestedName_33 ; id 51
    dw SuggestedName_34 ; id 52
    dw SuggestedName_35 ; id 53
    dw SuggestedName_36 ; id 54
    dw SuggestedName_37 ; id 55
    dw SuggestedName_38 ; id 56
    dw SuggestedName_39 ; id 57
    dw SuggestedName_3A ; id 58
    dw SuggestedName_3B ; id 59
    dw SuggestedName_3C ; id 60
    dw SuggestedName_3D ; id 61
    dw SuggestedName_3E ; id 62
    dw SuggestedName_3F ; id 63
    dw SuggestedName_40 ; id 64
    dw SuggestedName_41 ; id 65
    dw SuggestedName_42 ; id 66
    dw SuggestedName_43 ; id 67
    dw SuggestedName_44 ; id 68
    dw SuggestedName_45 ; id 69
    dw SuggestedName_46 ; id 70
    dw SuggestedName_47 ; id 71
    dw SuggestedName_48 ; id 72
    dw SuggestedName_49 ; id 73
    dw SuggestedName_4A ; id 74
    dw SuggestedName_4B ; id 75
    dw SuggestedName_4C ; id 76
    dw SuggestedName_4D ; id 77
    dw SuggestedName_4E ; id 78
    dw SuggestedName_4F ; id 79
    dw SuggestedName_50 ; id 80
    dw SuggestedName_51 ; id 81
    dw SuggestedName_52 ; id 82
    dw SuggestedName_53 ; id 83
    dw SuggestedName_54 ; id 84
    dw SuggestedName_55 ; id 85
    dw SuggestedName_56 ; id 86
    dw SuggestedName_57 ; id 87
    dw SuggestedName_58 ; id 88
    dw SuggestedName_59 ; id 89
    dw SuggestedName_5A ; id 90
    dw SuggestedName_5B ; id 91
    dw SuggestedName_5C ; id 92
    dw SuggestedName_5D ; id 93
    dw SuggestedName_5E ; id 94
    dw SuggestedName_5F ; id 95
    dw SuggestedName_60 ; id 96
    dw SuggestedName_61 ; id 97
    dw SuggestedName_62 ; id 98
    dw SuggestedName_63 ; id 99
    dw SuggestedName_64 ; id 100
    dw SuggestedName_65 ; id 101
    dw SuggestedName_66 ; id 102
    dw SuggestedName_67 ; id 103
    dw SuggestedName_68 ; id 104
    dw SuggestedName_69 ; id 105
    dw SuggestedName_6A ; id 106
    dw SuggestedName_6B ; id 107
    dw SuggestedName_6C ; id 108
    dw SuggestedName_6D ; id 109
    dw SuggestedName_6E ; id 110
    dw SuggestedName_6F ; id 111
    dw SuggestedName_70 ; id 112
    dw SuggestedName_71 ; id 113
    dw SuggestedName_72 ; id 114
    dw SuggestedName_73 ; id 115
    dw SuggestedName_74 ; id 116
    dw SuggestedName_75 ; id 117
    dw SuggestedName_76 ; id 118
    dw SuggestedName_77 ; id 119
    dw SuggestedName_78 ; id 120
    dw SuggestedName_79 ; id 121
    dw SuggestedName_7A ; id 122
    dw SuggestedName_7B ; id 123
    dw SuggestedName_7C ; id 124
    dw SuggestedName_7D ; id 125
    dw SuggestedName_7E ; id 126
    dw SuggestedName_7F ; id 127
    dw SuggestedName_80 ; id 128
    dw SuggestedName_81 ; id 129
    dw SuggestedName_82 ; id 130
    dw SuggestedName_83 ; id 131
    dw SuggestedName_84 ; id 132
    dw SuggestedName_85 ; id 133
    dw SuggestedName_86 ; id 134
    dw SuggestedName_87 ; id 135
    dw SuggestedName_88 ; id 136
    dw SuggestedName_89 ; id 137
    dw SuggestedName_8A ; id 138
    dw SuggestedName_8B ; id 139

; the 140 six-byte names of NameEntrySuggestionTable, $7A37-$7D7F (E-0254, C1)
NameEntrySuggestions::
SuggestedName_00::
    db "Ryken@" ; id 0
SuggestedName_01::
    db "Li", $9f, $9f, $9f, "@" ; id 1
SuggestedName_02::
    db "Pynn", $9f, "@" ; id 2
SuggestedName_03::
    db "Pazu", $9f, "@" ; id 3
SuggestedName_04::
    db "Kordi@" ; id 4
SuggestedName_05::
    db "Symbo@" ; id 5
SuggestedName_06::
    db "Whest@" ; id 6
SuggestedName_07::
    db "Zerro@" ; id 7
SuggestedName_08::
    db "Alyah@" ; id 8
SuggestedName_09::
    db "Cerol@" ; id 9
SuggestedName_0A::
    db "Varel@" ; id 10
SuggestedName_0B::
    db "Garon@" ; id 11
SuggestedName_0C::
    db "Altho@" ; id 12
SuggestedName_0D::
    db "Munon@" ; id 13
SuggestedName_0E::
    db "Alfer@" ; id 14
SuggestedName_0F::
    db "Totum@" ; id 15
SuggestedName_10::
    db "Junno@" ; id 16
SuggestedName_11::
    db "Weib", $9f, "@" ; id 17
SuggestedName_12::
    db "Torma@" ; id 18
SuggestedName_13::
    db "Hukku@" ; id 19
SuggestedName_14::
    db "Gettu@" ; id 20
SuggestedName_15::
    db "Pidza@" ; id 21
SuggestedName_16::
    db "Nakk", $9f, "@" ; id 22
SuggestedName_17::
    db "Sulo", $9f, "@" ; id 23
SuggestedName_18::
    db "Olgan@" ; id 24
SuggestedName_19::
    db "Sefti@" ; id 25
SuggestedName_1A::
    db "Oshan@" ; id 26
SuggestedName_1B::
    db "Nocko@" ; id 27
SuggestedName_1C::
    db "Oltho@" ; id 28
SuggestedName_1D::
    db "Mazer@" ; id 29
SuggestedName_1E::
    db "Hyde", $9f, "@" ; id 30
SuggestedName_1F::
    db "Orora@" ; id 31
SuggestedName_20::
    db "Varli@" ; id 32
SuggestedName_21::
    db "Offsi@" ; id 33
SuggestedName_22::
    db "Kapta@" ; id 34
SuggestedName_23::
    db "Jass", $9f, "@" ; id 35
SuggestedName_24::
    db "Zeik", $9f, "@" ; id 36
SuggestedName_25::
    db "Yunn", $9f, "@" ; id 37
SuggestedName_26::
    db "Junia@" ; id 38
SuggestedName_27::
    db "Vul", $9f, $9f, "@" ; id 39
SuggestedName_28::
    db "Piell@" ; id 40
SuggestedName_29::
    db "Bolto@" ; id 41
SuggestedName_2A::
    db "Vulo", $9f, "@" ; id 42
SuggestedName_2B::
    db "Jikil@" ; id 43
SuggestedName_2C::
    db "Sevin@" ; id 44
SuggestedName_2D::
    db "Betha@" ; id 45
SuggestedName_2E::
    db "Raiss@" ; id 46
SuggestedName_2F::
    db "Kunon@" ; id 47
SuggestedName_30::
    db "Zakul@" ; id 48
SuggestedName_31::
    db "Kirua@" ; id 49
SuggestedName_32::
    db "Corbi@" ; id 50
SuggestedName_33::
    db "Fitey@" ; id 51
SuggestedName_34::
    db "Evin", $9f, "@" ; id 52
SuggestedName_35::
    db "Kuloe@" ; id 53
SuggestedName_36::
    db "Tudi", $9f, "@" ; id 54
SuggestedName_37::
    db "Ithy", $9f, "@" ; id 55
SuggestedName_38::
    db "Ruu", $9f, $9f, "@" ; id 56
SuggestedName_39::
    db "Garri@" ; id 57
SuggestedName_3A::
    db "Dabu", $9f, "@" ; id 58
SuggestedName_3B::
    db "Vehda@" ; id 59
SuggestedName_3C::
    db "Karto@" ; id 60
SuggestedName_3D::
    db "Bia", $9f, $9f, "@" ; id 61
SuggestedName_3E::
    db "Mutah@" ; id 62
SuggestedName_3F::
    db "Monsu@" ; id 63
SuggestedName_40::
    db "Pulk", $9f, "@" ; id 64
SuggestedName_41::
    db "Saiz", $9f, "@" ; id 65
SuggestedName_42::
    db "Zeil", $9f, "@" ; id 66
SuggestedName_43::
    db "Kazna@" ; id 67
SuggestedName_44::
    db "Pikka@" ; id 68
SuggestedName_45::
    db "Derzo@" ; id 69
SuggestedName_46::
    db "Muey", $9f, "@" ; id 70
SuggestedName_47::
    db "Mysti@" ; id 71
SuggestedName_48::
    db "Saman@" ; id 72
SuggestedName_49::
    db "Iana", $9f, "@" ; id 73
SuggestedName_4A::
    db "Mikko@" ; id 74
SuggestedName_4B::
    db "Topaz@" ; id 75
SuggestedName_4C::
    db "Pulam@" ; id 76
SuggestedName_4D::
    db "Nyar", $9f, "@" ; id 77
SuggestedName_4E::
    db "Zonia@" ; id 78
SuggestedName_4F::
    db "Pulin@" ; id 79
SuggestedName_50::
    db "Knull@" ; id 80
SuggestedName_51::
    db "Rauli@" ; id 81
SuggestedName_52::
    db "Carin@" ; id 82
SuggestedName_53::
    db "Mylki@" ; id 83
SuggestedName_54::
    db "Alfua@" ; id 84
SuggestedName_55::
    db "Furil@" ; id 85
SuggestedName_56::
    db "Hamen@" ; id 86
SuggestedName_57::
    db "Ligg", $9f, "@" ; id 87
SuggestedName_58::
    db "Limme@" ; id 88
SuggestedName_59::
    db "Hohmi@" ; id 89
SuggestedName_5A::
    db "Liset@" ; id 90
SuggestedName_5B::
    db "Katua@" ; id 91
SuggestedName_5C::
    db "Paela@" ; id 92
SuggestedName_5D::
    db "Putti@" ; id 93
SuggestedName_5E::
    db "Mymee@" ; id 94
SuggestedName_5F::
    db "Annis@" ; id 95
SuggestedName_60::
    db "Makki@" ; id 96
SuggestedName_61::
    db "Jemni@" ; id 97
SuggestedName_62::
    db "Chaar@" ; id 98
SuggestedName_63::
    db "Mafin@" ; id 99
SuggestedName_64::
    db "Piann@" ; id 100
SuggestedName_65::
    db "Malin@" ; id 101
SuggestedName_66::
    db "Capli@" ; id 102
SuggestedName_67::
    db "Multy@" ; id 103
SuggestedName_68::
    db "Schai@" ; id 104
SuggestedName_69::
    db "Hylda@" ; id 105
SuggestedName_6A::
    db "Sharo@" ; id 106
SuggestedName_6B::
    db "Millk@" ; id 107
SuggestedName_6C::
    db "Milda@" ; id 108
SuggestedName_6D::
    db "Konni@" ; id 109
SuggestedName_6E::
    db "Sundi@" ; id 110
SuggestedName_6F::
    db "Komet@" ; id 111
SuggestedName_70::
    db "Melan@" ; id 112
SuggestedName_71::
    db "Moura@" ; id 113
SuggestedName_72::
    db "Monez@" ; id 114
SuggestedName_73::
    db "Ellan@" ; id 115
SuggestedName_74::
    db "Eriss@" ; id 116
SuggestedName_75::
    db "Suloe@" ; id 117
SuggestedName_76::
    db "Flora@" ; id 118
SuggestedName_77::
    db "Nithe@" ; id 119
SuggestedName_78::
    db "Yuwmi@" ; id 120
SuggestedName_79::
    db "Yurro@" ; id 121
SuggestedName_7A::
    db "Paize@" ; id 122
SuggestedName_7B::
    db "Celen@" ; id 123
SuggestedName_7C::
    db "Heren@" ; id 124
SuggestedName_7D::
    db "Velah@" ; id 125
SuggestedName_7E::
    db "Minto@" ; id 126
SuggestedName_7F::
    db "Ritto@" ; id 127
SuggestedName_80::
    db "Luman@" ; id 128
SuggestedName_81::
    db "Venni@" ; id 129
SuggestedName_82::
    db "Teryl@" ; id 130
SuggestedName_83::
    db "Krim", $9f, "@" ; id 131
SuggestedName_84::
    db "Atch", $9f, "@" ; id 132
SuggestedName_85::
    db "Arle", $9f, "@" ; id 133
SuggestedName_86::
    db "Phes", $9f, "@" ; id 134
SuggestedName_87::
    db "Riza", $9f, "@" ; id 135
SuggestedName_88::
    db "Pestl@" ; id 136
SuggestedName_89::
    db "Almmo@" ; id 137
SuggestedName_8A::
    db "Forte@" ; id 138
SuggestedName_8B::
    db "Soffi@" ; id 139

; Branches on wArg1; sets rRAMG2 to $0a; sets rRAMB to 0; sets rRAMG2 to $0a; sets rRAMB to 1; sets
; rRAMB to 0; branches on the byte at sCompactRecords; branches on the byte at sCompactRecords +
; $6f; branches on C; sets rRAMB to 0; branches on the byte at sCompactRecords; branches on C; then
; 18 more steps (see the code) (E-0347)
; why: part of HibernateMenu; HibernateMenu: implements script command type EB (SCRIPT_HIBERNATE):
; monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode ... (E-0352,
; E-0038, E-0244)
HibernateMenu_Multiply8::
    ld a, [wArg1]
    cp $1e
    jr nc, .skip3
    cp $1d
    jr z, .skip
    ld c, $6f
    call Multiply8
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld de, sCompactRecords
    add hl, de
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a

.skip2:
    ld b, $6f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop

.skip3:
    ld hl, sCompactRecords
    ld de, sCompactRecords + $6f
    xor a
    ld [rRAMB], a
    ld bc, $0000

.loop2:
    push de
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, .restore
    ld a, [de]
    bit 7, a
    jr nz, .restore3
    jr .restore2

.restore:
    pop hl
    ld a, $6f
    add_a_to_hl
    push hl

.restore2:
    pop hl
    pop de
    ld a, $6f
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp $1d
    jr c, .loop2
    jr .skip4

.restore3:
    pop hl
    pop de
    ld a, [de]
    ld [hli], a
    xor a
    ld [de], a
    inc de
    ld b, $6e

.loop3:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop3
    jr .next

.skip4:
    ld hl, sCompactRecords
    xor a
    ld [rRAMB], a
    ld c, $00

.loop4:
    ld a, [hl]
    bit 7, a
    jr z, .skip5
    ld a, l
    add $6f
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    ld a, c
    cp $1d
    jr c, .loop4
    jr .skip6

.skip5:
    push hl
    ld de, wRecordBufB
    ld hl, sRecords
    ld a, $01
    ld [rRAMB], a
    ld b, $6f

.loop5:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop5
    ld hl, sRecords
    ld b, $6f

.loop6:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop6
    pop hl
    xor a
    ld [rRAMB], a
    ld de, wRecordBufB
    ld b, $6f

.loop7:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop7

.skip6:
    xor a
    ld [rRAMB], a
    ld hl, sCompactRecords
    ld c, $00

.loop8:
    ld a, [hl]
    bit 7, a
    jr nz, .skip7

.set_arg5:
    ld a, c
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld b, $6f

.loop9:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop9
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

.skip7:
    ld a, $6f
    add_a_to_hl
    inc c
    ld a, c
    cp $1d
    jr c, .loop8
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr nz, .set_arg5_to_FF
    jr .set_arg5

.set_arg5_to_FF:
    ld a, $ff
    ld [wArg5], a
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; clears SRAM record wArg1 (when below 30) and moves the later stored records up to fill the gap,
; updating the party list (E-0131)
DeleteSRAMRecordAndCompact::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg1]
    cp $1e
    jr nc, .skip
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld b, $a5

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop

.skip:
    ld hl, sRecords
    ld de, sRecord1
    ld bc, $0000

.loop2:
    push de
    push hl
    ld a, [hl]
    cp $01
    jr z, .restore
    cp $02
    jr z, .restore
    ld a, [de]
    cp $01
    jr z, .restore3
    cp $02
    jr z, .restore3
    jr .restore2

.restore:
    pop hl
    ld a, $a5
    add_a_to_hl
    push hl

.restore2:
    pop hl
    pop de
    ld a, $a5
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp $1e
    jr c, .loop2
    jr .clear_arg3

.restore3:
    pop hl
    pop de
    ld a, [de]
    ld [hli], a
    xor a
    ld [de], a
    inc de
    ld b, $a4

.loop3:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop3
    jr .next

.clear_arg3:
    xor a
    ld [wArg3], a
    ld a, [wArg2]
    and a
    jr nz, .check_arg1
    ld a, [wArg1]
    cp $1e
    jr nc, .check_arg1
    ld b, a
    ld a, [wPartyCount]
    ld e, a
    ld c, $00
    ld hl, wPartyList

.loop4:
    ld a, [hl]
    cp b
    jr z, .skip2
    inc hl
    inc c
    ld a, c
    cp e
    jr c, .loop4
    jp .check_arg1

.skip2:
    ld a, c
    cp $02
    jr z, .check_party_count
    inc hl
    ld a, [hld]
    ld [hli], a
    inc c
    jr .skip2

.check_party_count:
    xor a
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    ld a, $01
    ld [wArg3], a

.check_arg1:
    ld hl, wPartyList
    ld a, [wArg1]
    cp $1e
    jr nc, .skip3
    ld c, $00

.loop5:
    ld a, [hl]
    ld b, a
    ld a, [wArg1]
    cp b
    jr nc, .next2
    ld a, b
    dec a
    ld [hl], a

.next2:
    inc hl
    inc c
    ld a, c
    cp $03
    jr c, .loop5

.skip3:
    ld hl, sRecords
    ld c, $00

.loop6:
    ld a, [hl]
    cp $01
    jr z, .skip4
    cp $02
    jr z, .skip4
    ld a, c
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld b, $a5

.loop7:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop7
    xor a
    ld [rRAMG2], a
    ret

.skip4:
    ld a, $a5
    add_a_to_hl
    inc c
    ld a, c
    cp $1e
    jr c, .loop6
    ld a, $ff
    ld [wArg5], a
    xor a
    ld [rRAMG2], a
    ret

; Changes HL, DE, BC and A; branches on the byte at DefaultMonsterNameTable (E-0347)
; why: part of CreateMonsterRecordOfKindTemp1; CreateMonsterRecordOfKindTemp1: with SRAM enabled
; creates a record from the template CreateMonsterRecordOfKindTemp1_Data[hTemp1] (wBattleArg1 =
; hTemp1, level hTemp2) (E-0352, E-0124)
CreateMonsterRecordOfKindTemp1_ReadWorkBuf::
    ld a, [wWorkBuf]
    ld c, a
    ld b, $00
    ld hl, DefaultMonsterNameTable
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wWorkBuf + $1]
    ld c, a
    jr .skip
    db $fa, $9e, $d0, $4f, $06, $00, $21, $1f, $79

.skip:
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wWorkBuf + $2]
    ld e, a
    ld a, [wWorkBuf + $3]
    ld d, a

.loop:
    ld a, [hli]
    cp $9f
    jr z, .loop
    ld [de], a
    cp $f0
    jr z, .return
    inc de
    jr .loop

.return:
    ret
    ds $2c, $00
