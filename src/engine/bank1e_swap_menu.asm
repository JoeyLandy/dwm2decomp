; ROM bank $1E: the monster swap menu
; The annotated listing of this bank is build/listing/bank1e.asm.

SECTION "Bank 1E", ROMX[$4000], BANK[$1E]
    db $1e

; implements script command type E9 (SCRIPT_MENU_CLOSE): ends a menu session (runs CloseBreedMenu's
; code); follows the swap and NPC breeding menus; reached through ScriptCommandE9 in bank $10
; (E-0038, E-0244)
CloseMenuE9::
    ld a, [wScreenList]
    jumptable
    dw CloseMenuE9_CopyBytesDEToHL_Bank1E
    dw CloseMenuE9_ToCloseBreedMenu
    dw CloseMenuE9_DecompressToVRAM
    dw CloseMenuE9_ToCloseBreedMenu_2

; step 0 of CloseMenuE9: calls CopyBytesDEToHL_Bank1E; branches on wIsCGB; calls
; CopyLow3BitsToWRAMBank2_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; increments wScreenList (E-0347)
CloseMenuE9_CopyBytesDEToHL_Bank1E::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1E
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank1_e
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1E

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; step 1 of CloseMenuE9: calls CloseBreedMenu (E-0347)
CloseMenuE9_ToCloseBreedMenu::
    farcall CloseBreedMenu
    ret

; step 2 of CloseMenuE9: calls DecompressToVRAM; calls FillTilesBxC; increments wScreenList (E-0347)
CloseMenuE9_DecompressToVRAM::
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; step 3 of CloseMenuE9: calls CloseBreedMenu (E-0347)
CloseMenuE9_ToCloseBreedMenu_2::
    farcall CloseBreedMenu
    ret

; implements script command type E8 (SCRIPT_SWAP_MONSTERS): Cobi's swap of party and farm monsters:
; 'What'll you switch it with?', 'I switched 0.' (mode 3, bank $1F strings); reached through
; ScriptCommandE8 in bank $10 (E-0038, E-0244) (C2 from E-0335: Drop off / Pick up / Check / Release
; / Exit; Drop off sets a party record's MON_STATE to 1 and Pick up a kept one's to 2)
SwapMonstersMenu::
    ld a, [wScreenState]
    jumptable
    dw SwapMonstersMenu_CopyBytesDEToHL_Bank1E
    dw SwapMonstersMenu_SetupPartyList
    dw SwapMonstersMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc
    dw SwapMonstersMenu_ListPartyRecordsWithState2ToListEntries_2
    dw SwapMonstersMenu_MoveRecords
    dw SwapMonstersMenu_ChooseFromFarm
    dw SwapMonstersMenu_ChooseToView
    dw SwapMonstersMenu_ChooseToView2
    dw SwapMonstersMenu_ShowPartyMemberDetails
    dw SwapMonstersMenu_ShowMonsterDetails
    dw SwapMonstersMenu_ShowFarmMonsterDetails
    dw SwapMonstersMenu_ShowParents
    dw SwapMonstersMenu_ShowMonsterDetails2
    dw SwapMonstersMenu_ShowParents2
    dw SwapMonstersMenu_ShowMonsterDetails3

; step 0 of SwapMonstersMenu: calls CopyBytesDEToHL_Bank1E; branches on wIsCGB; calls
; CopyLow3BitsToWRAMBank2_Bank1E; sets wMessageMode to 3; sets hSpriteHideTile to $70; sets
; wAreaGraphicsIndex to 0; advances wScreenState; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_CopyBytesDEToHL_Bank1E::
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
    call CopyBytesDEToHL_Bank1E
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_03
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1E

.set_message_mode_to_03:
    ld a, $03
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wAreaGraphicsIndex], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: the tile map, ListPartyRecordsWithState2ToListEntries and CountRecordsInUse
; (E-0293)
SwapMonstersMenu_SetupPartyList::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_SetupPartyList_ToSetupTileMapAtBGMap1
    dw SwapMonstersMenu_SetupPartyList_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep
    dw SwapMonstersMenu_SetupPartyList_CountRecordsInUse

; step 0 of SwapMonstersMenu_SetupPartyList: calls SetupTileMapAtBGMap1 (E-0347)
SwapMonstersMenu_SetupPartyList_ToSetupTileMapAtBGMap1::
    farcall SetupTileMapAtBGMap1
    ret

; step 1 of SwapMonstersMenu_SetupPartyList: calls SwapMonstersMenu_WriteGlyphListPos; advances
; wScreenStep (E-0347)
SwapMonstersMenu_SetupPartyList_ToSwapMonstersMenu_WriteGlyphListPosAndStep::
    ld hl, GlyphCopyDestList0
    ld de, GlyphCopySrcList0
    call SwapMonstersMenu_WriteGlyphListPos
    ld hl, wScreenStep
    inc [hl]
    ret

; step 2 of SwapMonstersMenu_SetupPartyList: calls ListPartyRecordsWithState2ToListEntries;
; increments wScreenStep (E-0347)
SwapMonstersMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep::
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 3 of SwapMonstersMenu_SetupPartyList: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; calls CountRecordsInUse; sets
; wScreenStep to 0; increments wScreenState (E-0347)
SwapMonstersMenu_SetupPartyList_CountRecordsInUse::
    ld de, GlyphCopySrcList0 + $1fa
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $0b
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; step 2 of SwapMonstersMenu: branches on wJoypadPressedRepeat; branches on wJoypadPressed; calls
; SwapMonstersMenu_WriteGridCursorY; calls SwapMonstersMenu_ReadGridCursorX_2; branches on
; wGridCursorX; sets wGridCursorX to 4; calls SwapMonstersMenu_WriteGridCursorY; plays sound $69;
; sets wGridCursorX; sets wListCursor to 0; sets wChoiceCursor to 0; sets wListPageIndex to 0; then
; 21 more steps (see the code) (E-0347)
SwapMonstersMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_swap_monsters_menu_read_grid_cursor_x_2
    bit 7, a
    jr nz, .call_swap_monsters_menu_read_grid_cursor_x_22
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_04
    call SwapMonstersMenu_WriteGridCursorY
    ret

.call_swap_monsters_menu_read_grid_cursor_x_2:
    call SwapMonstersMenu_ReadGridCursorX_2
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x
    ld a, $04
    ld [wGridCursorX], a
    call SwapMonstersMenu_WriteGridCursorY
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
    call SwapMonstersMenu_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_swap_monsters_menu_read_grid_cursor_x_22:
    call SwapMonstersMenu_ReadGridCursorX_2
    ld a, [wGridCursorX]
    cp $04
    jr c, .skip
    xor a
    ld [wGridCursorX], a
    call SwapMonstersMenu_WriteGridCursorY
    ld a, $69
    call QueueSoundEffect
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap
    ld c, $00

.loop:
    ld a, c
    ld b, $c3
    ld hl, SwapMenuCursorCells
    push bc
    push hl
    call StoreBAtWordTableEntry_Bank1E
    pop hl
    pop bc
    inc c
    ld a, c
    cp $05
    jr c, .loop
    ld a, [wGridCursorX]
    cp $04
    jr z, .set_two_choice_cursor_to_04
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

.set_two_choice_cursor_to_04:
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; called from SwapMonstersMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: may continue in
; SwapMonstersMenu_ReadGridCursorX; increments wGridCursorY; may continue in
; SwapMonstersMenu_ReadGridCursorX; may continue in SwapMonstersMenu_ReadGridCursorX_2; sets
; wGridCursorY to 0 (E-0347)
SwapMonstersMenu_WriteGridCursorY::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, SwapMonstersMenu_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, SwapMonstersMenu_ReadGridCursorX
    cp $18
    jr c, SwapMonstersMenu_ReadGridCursorX_2
    xor a
    ld [wGridCursorY], a

; called from SwapMonstersMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: changes B; continues in
; SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_ReadGridCursorX (E-0347)
SwapMonstersMenu_ReadGridCursorX::
    ld b, $bb
    jr SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_ReadGridCursorX

; called from SwapMonstersMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: changes B; continues in
; SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_ReadGridCursorX (E-0347)
SwapMonstersMenu_ReadGridCursorX_2::
    ld b, $c3
    jr SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_ReadGridCursorX

; called from SwapMonstersMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc: takes BC; changes B
; (E-0347)
SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

; Calls BGMapAddressAtScroll_Bank1E; calls StepBGMapAddressBackOnScrollWrap (E-0347)
SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_ReadGridCursorX::
    ld a, [wGridCursorX]
    add a
    ld hl, SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by SwapMonstersMenu (10 bytes) (E-0347)
SwapMonstersMenu_StepBGMapAddressBackOnScrollWrap_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; step 3 of SwapMonstersMenu: calls SwapMonstersMenu_ListPartyRecordsWithState2ToListEntries
; (E-0347)
SwapMonstersMenu_ListPartyRecordsWithState2ToListEntries_2::
    farcall SwapMonstersMenu_ListPartyRecordsWithState2ToListEntries
    ret

; by wScreenStep: record lists of party and farm, StoreTemp0BytesToSRAMRecord, capacity from the
; farm level, CountRecordsInUse (E-0288)
SwapMonstersMenu_MoveRecords::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc
    dw SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E_SetArg1
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles_SetArg1
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_MoveRecords_UpdateListCursorListCursor
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_StoreTemp0BytesToSRAMRecord
    dw SwapMonstersMenu_MoveRecords_LoadRecordCapacityFromFarmLevelTable
    dw SwapMonstersMenu_MoveRecords_CopyFromBankWaitVRAM
    dw SwapMonstersMenu_MoveRecords_UpdateTwoChoiceCursor_Bank1D
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC
    dw ListRecordsState1ThenContinue
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_MoveRecords_UpdatePagedListCursor
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_MoveRecords_CountRecordsInUse_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_SetScreenStep_2
    dw SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf
    dw SwapMonstersMenu_MoveRecords_StoreTemp0BytesToSRAMRecord_SetTemp0
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_MoveRecords_CountRecordsInUse

; step 0 of SwapMonstersMenu_MoveRecords: changes A; may continue in
; SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip; may continue in
; SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf; continues in
; SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_CallListPartyRecordsWithState2ToListEntries
; (E-0347)
SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc::
    ld a, [wScreenSubStep]
    and a
    jp z, SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip
    cp $01
    jp z, SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf
    jp SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_CallListPartyRecordsWithState2ToListEntries

; Calls CopyRectTo20ByteRows_Bank1E; calls FillTilesBxC; increments wScreenSubStep (E-0347)
SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip::
    ld de, SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank1E
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; called from SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll_2: sets rRAMG2
; to $0a; sets rRAMB to 0; calls CopyRecordNameToNameGlyphBuf; calls CopyGlyphTilesToVRAM; branches
; on wPartyCount; sets rRAMG2 to 0; increments wScreenSubStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld b, $00

.loop:
    push bc
    ld hl, wPartyList
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    pop bc
    push bc
    ld a, b
    add a
    ld hl, SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc b
    ld a, [wPartyCount]
    cp b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Calls ListPartyRecordsWithState2ToListEntries; calls SwapMonstersMenu_LoadSRAMRecordByte; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; sets wScreenSubStep to 0;
; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_CallListPartyRecordsWithState2ToListEntries::
    farcall ListPartyRecordsWithState2ToListEntries
    ld hl, wWindowTileBuffer + $78
    ld c, $28
    call SwapMonstersMenu_LoadSRAMRecordByte
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_Data::
    db $00, $8d, $50, $8d, $a0, $8d

; step 1 of SwapMonstersMenu_MoveRecords: calls LoadFamilyIconTileForRecordB_Bank1E; calls
; CopyRectTo20ByteRows_Bank1E; sets wArg1; calls CallDrawRecordStatsBoxForArg1InBank1D; increments
; wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E_SetArg1::
    ld a, [wListCursor]
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank1E
    ld de, SwapMenuCursorCells + $dc
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank1E
    pop af
    ld b, a
    ld [wArg1], a
    call CallDrawRecordStatsBoxForArg1InBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 2 of SwapMonstersMenu_MoveRecords: calls FillTilesBxC; sets wTextWindowTileLo to $12;
; advances wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep::
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

; step 3 of SwapMonstersMenu_MoveRecords: copies the byte at wListEntries to wArg1; calls
; DrawRecordNameAndSpeciesNameTiles; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles_SetArg1::
    ld a, [wListCursor]
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 4 of SwapMonstersMenu_MoveRecords: calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; calls
; StoreBAtWordTableEntry_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E::
    ld a, [wListCursor]
    ld b, $bb
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wListCursor]
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 5 of SwapMonstersMenu_MoveRecords: sets wMenuInputResult to 0; calls
; UpdateListCursorListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets
; wScreenStep to 1; sets wTwoChoiceCursor to 1; increments wScreenStep; sets wScriptCommandType to
; 0; sets wScriptStartRequest to $80; calls StoreBAtWordTableEntry_Bank1E; sets wTwoChoiceCursor to
; 0; sets wScreenStep; then 2 more steps (see the code) (E-0347)
SwapMonstersMenu_MoveRecords_UpdateListCursorListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    jr z, .set_screen_step_to_01
    cp $fe
    jr z, .set_two_choice_cursor_to_01
    cp $ff
    jr z, .read_list_cursor
    ret

.set_screen_step_to_01:
    ld a, $01
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

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $05
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 6 of SwapMonstersMenu_MoveRecords: sets wArg1 to 0; sets wArg2 to $0c; calls
; CopyScreenBufferRectWithAttrs_1E; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E::
    ld c, $0d
    ld hl, $01d4
    ld de, $0008
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 7 of SwapMonstersMenu_MoveRecords: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 8 of SwapMonstersMenu_MoveRecords: calls SwapMonstersMenu_WriteGlyphListPos; advances
; wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep::
    ld hl, GlyphCopyDestList1
    ld de, GlyphCopySrcList1
    call SwapMonstersMenu_WriteGlyphListPos
    ld hl, wScreenStep
    inc [hl]
    ret

; step 9 of SwapMonstersMenu_MoveRecords: sets wScreenStep to 3; sets wScreenState to 1; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_MoveRecords_SetScreenStep::
    ld a, $03
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 10 of SwapMonstersMenu_MoveRecords: calls SwapMonstersMenu_WriteGlyphListPos; advances
; wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep::
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_WriteGlyphListPos
    ld hl, wScreenStep
    inc [hl]
    ret

; step 11 of SwapMonstersMenu_MoveRecords: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; plays sound $6c; sets
; wChoiceCursor to 0; sets wCursorBlinkAE to 0; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor::
    ld de, SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
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
SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; step 12 of SwapMonstersMenu_MoveRecords: branches on wJoypadPressedRepeat; branches on
; wJoypadPressed; calls BlinkCursorBlinkAE_Bank1E; calls DrawBlankTileC3_Bank1E; branches on
; wChoiceCursor; sets wChoiceCursor to 1; calls DrawCursorTileBB_Bank1E; plays sound $69; calls
; DrawBlankTileC3_Bank1E; branches on wChoiceCursor; plays sound $69; calls
; SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap; then 48 more steps (see the code)
; (E-0347)
SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank1_e
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank1_e2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call BlinkCursorBlinkAE_Bank1E
    ret

.call_draw_blank_tile_c3_bank1_e:
    call DrawBlankTileC3_Bank1E
    ld a, [wChoiceCursor]
    and a
    jr nz, .set_choice_cursor
    ld a, $01
    jr .set_choice_cursor2

.set_choice_cursor:
    dec a

.set_choice_cursor2:
    ld [wChoiceCursor], a
    call DrawCursorTileBB_Bank1E
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_bank1_e2:
    call DrawBlankTileC3_Bank1E
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
    call SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap
    ld a, [wChoiceCursor]
    and a
    jp nz, .check_screen_state
    ld a, [wScreenState]
    cp $07
    jp z, .check_screen_step3
    cp $04
    jr z, .check_screen_step2
    cp $05
    jr z, .check_screen_step

.check_screen_step:
    ld a, [wScreenStep]
    cp $13
    jr c, .set_return_screen_state_to_052
    cp $42
    jr c, .set_return_screen_state_to_05
    ld a, $05
    ld [wReturnScreenState], a
    ld a, $44
    ld [wReturnScreenStep], a
    ld a, $09
    jr .set_screen_state

.set_return_screen_state_to_05:
    ld a, $05
    ld [wReturnScreenState], a
    ld a, $2c
    ld [wReturnScreenStep], a
    ld a, $08
    jr .set_screen_state

.set_return_screen_state_to_052:
    ld a, $05
    ld [wReturnScreenState], a
    ld a, $12
    ld [wReturnScreenStep], a
    ld a, $09
    jr .set_screen_state

.check_screen_step2:
    ld a, [wScreenStep]
    cp $10
    jr nc, .set_return_screen_state_to_04
    ld a, $04
    ld [wReturnScreenState], a
    ld a, $0c
    ld [wReturnScreenStep], a
    ld a, $08
    jr .set_screen_state

.set_return_screen_state_to_04:
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
    call SaveAndHideSpriteState_Bank1E
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step3:
    ld a, [wScreenStep]
    cp $16
    jr nz, .set_return_screen_state_to_07
    ld a, $07
    ld [wReturnScreenState], a
    ld a, $16
    ld [wReturnScreenStep], a
    ld a, $0a
    jr .set_screen_state

.set_return_screen_state_to_07:
    ld a, $07
    ld [wReturnScreenState], a
    ld a, $2e
    ld [wReturnScreenStep], a
    ld a, $0b
    jr .set_screen_state

.check_screen_state:
    ld a, [wScreenState]
    cp $07
    jr nz, .check_screen_state2
    ld a, [wMenuChoice]
    and a
    jr nz, .check_screen_step4
    ld a, [wListCursor]
    and a
    jr nz, .check_screen_state2
    ld a, [wPartyCount]
    cp $02
    jr nc, .check_screen_state2
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp b
    jr nz, .check_screen_state2
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step4:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

.check_screen_state2:
    ld a, [wScreenState]
    cp $04
    jr nz, .set_two_choice_cursor_to_01
    ld a, [wScreenStep]
    cp $0c
    jr nz, .set_two_choice_cursor_to_01
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0

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

; cycles wCursorBlinkAE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
BlinkCursorBlinkAE_Bank1E::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank1E
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp $10
    jr c, DrawCursorTileBB_Bank1E
    cp $18
    jr c, DrawBlankTileC3_Bank1E
    xor a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawCursorTileBB_Bank1E)
DrawCursorTileBB_Bank1E::
    ld b, $bb
    jr SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_Bank1E)
DrawBlankTileC3_Bank1E::
    ld b, $c3
    jr SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; called from SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E: takes BC; changes B (E-0347)
SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

; Calls BGMapAddressAtScroll_Bank1E; calls StepBGMapAddressBackOnScrollWrap (E-0347)
SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor::
    ld a, [wChoiceCursor]
    add a
    ld hl, SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by SwapMonstersMenu (4 bytes) (E-0347)
SwapMonstersMenu_MoveRecords_StepBGMapAddressBackOnScrollWrap_Data::
    db $2d, $01, $6d, $01

; copies box $4718 to wWindowTileBuffer + $110, runs CopyScreenBufferRectWithAttrs_1E, blanks the
; cursor entry wListCursor of table $7880 and wScreenStep += 1 (E-0124) (E-0344: the address in its
; name dropped or read as the label there; was DrawBoxAndMenuAndStep_1E)
DrawBoxAndMenuAndStep_1E::
    ld de, DrawBoxAndMenuAndStep_1E_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $01
    call CopyRectTo20ByteRows_Bank1E
    ld c, $04
    ld hl, $028c
    ld de, $00c0
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wListCursor]
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
DrawBoxAndMenuAndStep_1E_TileRect::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; step 14 of SwapMonstersMenu_MoveRecords: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; sets wScreenStep to 5; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_SetScreenStep::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $05
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 15 of SwapMonstersMenu_MoveRecords: sets rRAMG2 to $0a; sets rRAMB to 0; sets hTemp0 to 1;
; calls StoreTemp0BytesToSRAMRecord; sets hTemp0 to 0; calls StoreTemp0BytesToSRAMRecord; sets
; rRAMG2 to 0; branches on wPartyCount; decrements wPartyCount; calls
; ListPartyRecordsWithState2ToListEntries; calls LoadPlayerAndFollowerSpriteGraphics; sets
; wOBJPaletteUploadRequest to $7f; then 8 more steps (see the code) (E-0347)
SwapMonstersMenu_MoveRecords_StoreTemp0BytesToSRAMRecord::
    ld a, [wListCursor]
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, $01
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATUS
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a
    ld [rRAMG2], a
    ld a, [wPartyCount]
    and a
    jr z, .call_list_party_records_with_state2_to_list
    dec a
    ld [wPartyCount], a

.call_list_party_records_with_state2_to_list:
    farcall ListPartyRecordsWithState2ToListEntries
    ld hl, wListEntries
    ld de, wPartyList
    ld b, $03

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call DrawBoxAndMenuAndStep_1E
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 16 of SwapMonstersMenu_MoveRecords: calls LoadRecordCapacityFromFarmLevelTable; sets rRAMG2
; to $0a; sets rRAMB to 0; branches on the byte at sRecords; branches on C; branches on the byte at
; sRecords; sets wTwoChoiceCursor to 0; sets wScreenState to 1; sets wScreenStep to 3; sets
; wScreenSubStep to 0; sets rRAMG2 to 0; calls StoreBAtWordTableEntry_Bank1E; then 7 more steps (see
; the code) (E-0347)
SwapMonstersMenu_MoveRecords_LoadRecordCapacityFromFarmLevelTable::
    farcall LoadRecordCapacityFromFarmLevelTable
    ld d, c
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $00

.loop:
    ld a, [hl]
    cp $01
    jr z, .skip2

.skip:
    ld a, $a5
    add_a_to_hl
    inc c
    ld a, c
    cp d
    jr c, .loop
    jr .clear_two_choice_cursor

.skip2:
    push hl
    ld a, $6e
    add_a_to_hl
    ld a, [hl]
    and a
    jr z, .restore
    pop hl
    jr .skip

.restore:
    pop hl
    jr .set_two_choice_cursor_to_01

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $01
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [rRAMG2], a
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [rRAMG2], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 17 of SwapMonstersMenu_MoveRecords: calls CopyFromBankWaitVRAM; plays sound $6c; calls
; CopyRectTo20ByteRows_Bank1E; calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; increments wScreenStep; sets
; wTwoChoiceCursor to 0 (E-0347)
SwapMonstersMenu_MoveRecords_CopyFromBankWaitVRAM::
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6c
    call QueueSoundEffect
    ld de, SwapMonstersMenu_MoveRecords_CopyFromBankWaitVRAM_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
SwapMonstersMenu_MoveRecords_CopyFromBankWaitVRAM_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f3, $a6, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; step 18 of SwapMonstersMenu_MoveRecords: calls UpdateTwoChoiceCursor_Bank1D; returns if
; wMenuInputResult is 0; branches on wMenuInputResult; calls
; SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_2; sets wTwoChoiceCursor to 1; sets
; wScreenState to 1; sets wScreenStep to 3; sets wScreenSubStep to 0; sets wScriptCommandType to 0;
; sets wScriptStartRequest to $80; branches on wTwoChoiceCursor; calls
; SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_2; then 4 more steps (see the code)
; (E-0347)
SwapMonstersMenu_MoveRecords_UpdateTwoChoiceCursor_Bank1D::
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
    call SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_2
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
    call SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_2
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

; called from SwapMonstersMenu_MoveRecords_UpdateTwoChoiceCursor_Bank1D: calls
; SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E; branches on wIsCGB; sets rSVBK; calls
; SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E; sets rSVBK; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E (E-0347)
SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_2::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $05
    call SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank1_e
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ret

; Calls CopyBytesDEToHL_Bank1E; may continue in SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E
; (E-0347)
SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E::
    push bc
    push hl
    push de
    ld bc, $0006
    call CopyBytesDEToHL_Bank1E
    pop de
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    ld a, $14
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, SwapMonstersMenu_MoveRecords_CopyBytesDEToHL_Bank1E
    ret

; step 19 of SwapMonstersMenu_MoveRecords: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; sets wListPageIndex to 0; sets
; wCursorBlinkAE to 0; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E::
    ld de, SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    xor a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 11 tiles, one row per line
SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_TileRect::
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

; step 20 of SwapMonstersMenu_MoveRecords: calls FillTilesBxC; calls CopyRectTo20ByteRows_Bank1E;
; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_FillTilesBxC::
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
    ld de, SwapMenuCursorCells + $1c1
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls ListRecordsState1NotEggs and continues with
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5 (E-0122)
ListRecordsState1ThenContinue::
    farcall ListRecordsState1NotEggs
    jr SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5

; step 6 of SwapMonstersMenu_ChooseToView: calls ListRecordsInUseNotEggs (E-0347)
SwapMonstersMenu_ChooseToView_ListRecordsInUseNotEggs_2::
    farcall ListRecordsInUseNotEggs

; Calls ClampRecordListPageCursor5; branches on wListPages; calls DrawC5BEC6AtScrollOffsetDE_Bank1E;
; calls StoreC5BEC6AtHLStride2_Bank1E; copies D to wArg1; copies E to wArg2; calls
; DrawPageOfPagesAtScrollOffset; copies H to wArg1; copies L to wArg2; calls
; DrawPageOfPagesAtArg1_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5::
    call ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank1E
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12f
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls DrawRecordListPageNames (E-0122) (E-0344: the address in its name dropped or read as the
; label there; was CallDrawRecordListPageNamesInBank1F)
CallDrawRecordListPageNamesInBank1F::
    farcall DrawRecordListPageNames
    ret

; step 23 of SwapMonstersMenu_MoveRecords: calls GetListEntriesCell5Address; calls
; LoadFamilyIconTileForRecordB_Bank1E; calls CopyRectTo20ByteRows_Bank1E; sets wArg1; calls
; CallDrawRecordStatsBoxForArg1InBank1D; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank1E
    ld de, SwapMenuCursorCells + $dc
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank1E
    pop af
    ld b, a
    ld [wArg1], a
    call CallDrawRecordStatsBoxForArg1InBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 25 of SwapMonstersMenu_MoveRecords: calls GetListEntriesCell5Address; sets wArg1; calls
; DrawRecordNameAndSpeciesNameTiles; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 27 of SwapMonstersMenu_MoveRecords: sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; increments
; wScreenStep; sets wScreenStep; sets wTwoChoiceCursor to 0; calls StoreBAtWordTableEntry_Bank1E;
; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; sets wScriptStartRequest to $80; then
; 1 more step (see the code) (E-0347)
SwapMonstersMenu_MoveRecords_UpdatePagedListCursor::
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
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
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

; step 32 of SwapMonstersMenu_MoveRecords: calls SwapMonstersMenu_WriteGlyphListPos; increments
; wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep::
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 33 of SwapMonstersMenu_MoveRecords: calls DrawRecordListNameTiles_Bank1D; calls
; ListPartyRecordsWithState2ToListEntries; increments wScreenStep (E-0347)
SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D::
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 34 of SwapMonstersMenu_MoveRecords: calls CopyRectTo20ByteRows_Bank1E; calls
; StoreBAtWordTableEntry_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; calls CountRecordsInUse; sets wScreenStep to $11; sets
; wTwoChoiceCursor to 1; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_MoveRecords_CountRecordsInUse_SetScreenStep::
    ld de, SwapMenuCursorCells + $148
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $0b
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    ld a, $11
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 39 of SwapMonstersMenu_MoveRecords: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; sets wScreenStep to $1b; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E_SetScreenStep_2::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $1b
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 40 of SwapMonstersMenu_MoveRecords: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; CopyRecordNameToNameGlyphBuf (E-0347)
SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wPartyList]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

; May continue in SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf_Loop; calls
; GetListEntriesCell5Address; calls CopyRecordNameToNameGlyphBuf; branches on the byte at
; wNameGlyphBuf; sets rRAMG2 to 0; increments wScreenStep; sets wTextWindowTileLo to $12; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf_Loop::
    ld a, [hl]
    cp $f0
    jr z, .skip
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp $0a
    jr c, SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf_Loop

.skip:
    ld a, $90
    ld [de], a
    inc de
    ld a, $3a
    ld [de], a
    inc de
    ld a, $2c
    ld [de], a
    inc de
    ld a, $37
    ld [de], a
    inc de
    ld a, $2b
    ld [de], a
    inc de
    ld a, $90
    ld [de], a
    inc de
    push de
    call GetListEntriesCell5Address
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    pop de
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf

.skip2:
    ld a, [hl]
    cp $f0
    jr z, .skip3
    ld [de], a
    inc de
    inc hl
    jr .skip2

.skip3:
    ld [de], a
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
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

; step 41 of SwapMonstersMenu_MoveRecords: sets rRAMG2 to $0a; sets rRAMB to 0; sets hTemp0 to 1;
; calls StoreTemp0BytesToSRAMRecord; sets hTemp0 to 0; calls StoreTemp0BytesToSRAMRecord; calls
; GetListEntriesCell5Address; sets hTemp0 to 2; calls StoreTemp0BytesToSRAMRecord; sets rRAMG2 to 0;
; copies the byte at wPartyList to wPartyList; calls ListPartyRecordsWithState2ToListEntries; then 8
; more steps (see the code) (E-0347)
SwapMonstersMenu_MoveRecords_StoreTemp0BytesToSRAMRecord_SetTemp0::
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, $01
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATUS
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    call GetListEntriesCell5Address
    push hl
    ld a, $02
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a
    ld [rRAMG2], a
    pop hl
    ld a, [hl]
    ld [wPartyList], a
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call DrawBoxAndMenuAndStep_1E
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; step 48 of SwapMonstersMenu_MoveRecords: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; calls CountRecordsInUse; sets
; wScreenStep to 0; sets wScreenState to 2; sets wTwoChoiceCursor to 1; sets wScriptCommandType to
; 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_MoveRecords_CountRecordsInUse::
    ld de, SwapMenuCursorCells + $148
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $0b
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
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

; screen state 5, reached from menu option 1 when the farm list (ListRecordsState1NotEggs: records
; in use that are not eggs) is not empty: the MoveRecords list steps on that list (E-0302)
SwapMonstersMenu_ChooseFromFarm::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC
    dw ListRecordsState1ThenContinue
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_MoveRecords_UpdatePagedListCursor
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_MoveRecords_CountRecordsInUse
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_ChooseFromFarm_WritePlayerNameWithFlag0SuffixToTextBuf0
    dw SwapMonstersMenu_ChooseFromFarm_StoreTemp0BytesToSRAMRecord
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_MoveRecords_CountRecordsInUse
    dw SwapMonstersMenu_MoveRecords_CopyFromBankWaitVRAM
    dw SwapMonstersMenu_MoveRecords_UpdateTwoChoiceCursor_Bank1D
    dw SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc
    dw SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E_SetArg1
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles_SetArg1
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ChooseFromFarm_UpdateListCursorListCursor
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ChooseFromFarm_CountRecordsInUse
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_BGMapAddressAtScroll_Bank1E_SetScreenStep
    dw SwapMonstersMenu_ChooseFromFarm_DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_ListRecordsState1NotEggs
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC
    dw ListRecordsState1ThenContinue
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ChooseFromFarm_UpdatePagedListCursor
    dw SwapMonstersMenu_ChooseFromFarm_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_ChooseFromFarm_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ChooseFromFarm_CopyRectTo20ByteRows_Bank1E_SetListCursor
    dw SwapMonstersMenu_ChooseFromFarm_WriteScreenSubStepAndScreenStepEtc
    dw SwapMonstersMenu_MoveRecords_LoadFamilyIconTileForRecordB_Bank1E_SetArg1
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles_SetArg1
    dw SwapMonstersMenu_ChooseFromFarm_ListPartyRecordsWithState2ToListEntries
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_BGMapAddressAtScroll_Bank1E_SetScreenStep_2
    dw SwapMonstersMenu_ChooseFromFarm_CopyRecordNameToNameGlyphBuf
    dw SwapMonstersMenu_ChooseFromFarm_StoreTemp0BytesToSRAMRecord_GetListEntriesCell5Address
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_MoveRecords_CountRecordsInUse

; step 20 of SwapMonstersMenu_ChooseFromFarm: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; sets wScreenStep to 8; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_BGMapAddressAtScroll_Bank1E::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $08
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 21 of SwapMonstersMenu_ChooseFromFarm: calls WritePlayerNameWithFlag0SuffixToTextBuf0;
; increments wScreenStep; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_WritePlayerNameWithFlag0SuffixToTextBuf0::
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wScreenStep]
    inc a
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

; step 22 of SwapMonstersMenu_ChooseFromFarm: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell5Address; sets hTemp0 to 2; calls StoreTemp0BytesToSRAMRecord; calls
; GetListEntriesCell5Address; increments wPartyCount; sets rRAMG2 to 0; calls
; ListPartyRecordsWithState2ToListEntries; calls LoadPlayerAndFollowerSpriteGraphics; sets
; wOBJPaletteUploadRequest to $7f; calls DrawBoxAndMenuAndStep_1E; then 5 more steps (see the code)
; (E-0347)
SwapMonstersMenu_ChooseFromFarm_StoreTemp0BytesToSRAMRecord::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, $02
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    ld a, [wPartyCount]
    ld hl, wPartyList
    add_a_to_hl
    push hl
    call GetListEntriesCell5Address
    ld a, [hl]
    pop hl
    ld [hl], a
    ld a, [wPartyCount]
    inc a
    ld [wPartyCount], a
    xor a
    ld [rRAMG2], a
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call DrawBoxAndMenuAndStep_1E
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; step 37 of SwapMonstersMenu_ChooseFromFarm: sets wMenuInputResult to 0; calls
; UpdateListCursorListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets
; wScreenStep to $21; sets wTwoChoiceCursor to 1; increments wScreenStep; sets wScriptCommandType to
; 0; sets wScriptStartRequest to $80; calls StoreBAtWordTableEntry_Bank1E; sets wTwoChoiceCursor to
; 0; sets wScreenStep; then 2 more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseFromFarm_UpdateListCursorListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    jr z, .set_screen_step_to_21
    cp $fe
    jr z, .set_two_choice_cursor_to_01
    cp $ff
    jr z, .read_list_cursor
    ret

.set_screen_step_to_21:
    ld a, $21
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

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $05
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 41 of SwapMonstersMenu_ChooseFromFarm: calls CopyRectTo20ByteRows_Bank1E; calls
; StoreBAtWordTableEntry_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; calls CountRecordsInUse; sets wScreenStep to $1e; sets
; wTwoChoiceCursor to 1; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_CountRecordsInUse::
    ld de, SwapMenuCursorCells + $148
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $0b
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
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

; step 46 of SwapMonstersMenu_ChooseFromFarm: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; sets wScreenStep to $25; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_BGMapAddressAtScroll_Bank1E_SetScreenStep::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $25
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 48 of SwapMonstersMenu_ChooseFromFarm: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; increments wScreenStep; copies wListCursor to wItemGridX; copies the
; byte at wListEntries to wSelectedRecord; sets wListCursor to 0; sets wListPageIndex to 0; calls
; ListRecordsState1NotEggs; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_ListRecordsState1NotEggs::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld [wSelectedRecord], a
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    farcall ListRecordsState1NotEggs
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $c9

; step 58 of SwapMonstersMenu_ChooseFromFarm: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseFromFarm_CopyRectTo20ByteRows_Bank1E::
    ld de, SwapMenuCursorCells + $219
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 59 of SwapMonstersMenu_ChooseFromFarm: calls SwapMonstersMenu_WriteGlyphListPos; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ChooseFromFarm_ToSwapMonstersMenu_WriteGlyphListPosAndStep::
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 60 of SwapMonstersMenu_ChooseFromFarm: calls CopyRectTo20ByteRows_Bank1E; copies wItemGridX
; to wListCursor; sets wListPageIndex to 0; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseFromFarm_CopyRectTo20ByteRows_Bank1E_SetListCursor::
    ld de, SwapMenuCursorCells + $271
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wItemGridX]
    ld [wListCursor], a
    xor a
    ld [wListPageIndex], a
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 65 of SwapMonstersMenu_ChooseFromFarm: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; sets wScreenStep to $25; sets wTwoChoiceCursor to 1; calls
; ListPartyRecordsWithState2ToListEntries; sets wTextWindowTileLo to $12; sets wScriptCommandType to
; 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_ListPartyRecordsWithState2ToListEntries::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $25
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    farcall ListPartyRecordsWithState2ToListEntries
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

; step 57 of SwapMonstersMenu_ChooseFromFarm: sets wMenuInputResult to 0; calls
; UpdatePagedListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets
; wScreenStep; increments wScreenStep; sets wScreenStep; sets wTwoChoiceCursor to 0; calls
; StoreBAtWordTableEntry_Bank1E; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80; then 1 more step (see the code) (E-0347)
SwapMonstersMenu_ChooseFromFarm_UpdatePagedListCursor::
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
    add $09
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
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

; step 47 of SwapMonstersMenu_ChooseFromFarm: calls DrawBoxAndMenuAndStep_1E; calls
; StoreBAtWordTableEntry_Bank1E (E-0347)
SwapMonstersMenu_ChooseFromFarm_DrawBoxAndMenuAndStep_1E::
    call DrawBoxAndMenuAndStep_1E
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ret

; step 61 of SwapMonstersMenu_ChooseFromFarm: changes A; may continue in
; SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip; may continue in
; SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf; continues in
; SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_CallListPartyRecordsWithState2ToListEntries
; (E-0347)
SwapMonstersMenu_ChooseFromFarm_WriteScreenSubStepAndScreenStepEtc::
    ld a, [wScreenSubStep]
    and a
    jp z, SwapMonstersMenu_MoveRecords_WriteScreenSubStepAndScreenStepEtc_Skip
    cp $01
    jp z, SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf
    jp SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf_CallListPartyRecordsWithState2ToListEntries

; step 70 of SwapMonstersMenu_ChooseFromFarm: calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; sets wScreenStep to $39; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseFromFarm_BGMapAddressAtScroll_Bank1E_SetScreenStep_2::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $39
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 71 of SwapMonstersMenu_ChooseFromFarm: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; CopyRecordNameToNameGlyphBuf; continues in
; SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf_Loop (E-0347)
SwapMonstersMenu_ChooseFromFarm_CopyRecordNameToNameGlyphBuf::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00
    jp SwapMonstersMenu_MoveRecords_CopyRecordNameToNameGlyphBuf_Loop

; step 72 of SwapMonstersMenu_ChooseFromFarm: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell5Address; sets hTemp0 to 2; calls StoreTemp0BytesToSRAMRecord; sets hTemp0 to 1;
; calls StoreTemp0BytesToSRAMRecord; sets hTemp0 to 0; calls StoreTemp0BytesToSRAMRecord; calls
; GetListEntriesCell5Address; sets wItemGridX to 0; sets wSelectedRecord to 0; then 10 more steps
; (see the code) (E-0347)
SwapMonstersMenu_ChooseFromFarm_StoreTemp0BytesToSRAMRecord_GetListEntriesCell5Address::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, $02
    ldh [hTemp0], a
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    ld a, $01
    ldh [hTemp0], a
    ld a, [wSelectedRecord]
    ld c, MON_STATE
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    xor a
    ldh [hTemp0], a
    ld a, [wSelectedRecord]
    ld c, MON_STATUS
    ld b, $01
    call StoreTemp0BytesToSRAMRecord
    ld a, [wItemGridX]
    ld hl, wPartyList
    add_a_to_hl
    push hl
    call GetListEntriesCell5Address
    ld a, [hl]
    pop hl
    ld [hl], a
    xor a
    ld [wItemGridX], a
    ld [wSelectedRecord], a
    xor a
    ld [rRAMG2], a
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call DrawBoxAndMenuAndStep_1E
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; screen state 6 (menu option 2): a record list whose choice leads to the detail screen (state $0A)
; or the parents screen (state $0B) (E-0302)
SwapMonstersMenu_ChooseToView::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ChooseToView_WriteScreenStepAndMenuChoice
    dw SwapMonstersMenu_ChooseToView_ListRecordsInUseNotEggs
    dw SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2
    dw SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC
    dw SwapMonstersMenu_ChooseToView_ListRecordsInUseNotEggs_2
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_ChooseToView_LoadFamilyIconTileForRecordB_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ChooseToView_UpdatePagedListCursor
    dw SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_ChooseToView_CountRecordsInUse
    dw SwapMonstersMenu_ChooseToView_SaveAndHideSpriteState_Bank1E
    dw SwapMonstersMenu_ChooseToView_ToLoadTileListSixPerFrame
    dw SwapMonstersMenu_ChooseToView_ListRecordsInUseEggs
    dw SwapMonstersMenu_ChooseToView_FillTilesBxC
    dw SwapMonstersMenu_ChooseToView_ClampRecordListPageCursor4
    dw SwapMonstersMenu_ChooseToView_DrawRecordListPageSpeciesNames
    dw SwapMonstersMenu_ChooseToView_DrawRecordListPageMarks
    dw SwapMonstersMenu_ChooseToView_UpdatePagedListCursor_SetMenuInputResult
    dw SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1
    dw SwapMonstersMenu_ChooseToView_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_ChooseToView_LoadTileListSixPerCall

; step 0 of SwapMonstersMenu_ChooseToView: calls SwapMonstersMenu_WriteGlyphListPos; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_WriteScreenStepAndMenuChoice::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; step 1 of SwapMonstersMenu_ChooseToView: calls CopyRectTo20ByteRows_Bank1E; plays sound $6c; calls
; ListRecordsInUseNotEggs; calls HLToDecimalDigits; calls BlankLeadingZeroDigits_F; calls
; HLToDecimalDigits; calls BlankLeadingZeroDigits_F; calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; sets wMenuChoice to 0; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_ListRecordsInUseNotEggs::
    ld de, GlyphCopyDestList5 + $282
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $05
    call CopyRectTo20ByteRows_Bank1E
    ld a, $6c
    call QueueSoundEffect
    farcall ListRecordsInUseNotEggs
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    xor a
    ld [wMenuChoice], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 2 of SwapMonstersMenu_ChooseToView: calls
; SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D; returns if wMenuInputResult is 0; returns
; if wMenuInputResult is $fd; may continue in
; SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_SetTwoChoiceCursorTo03; may continue in
; SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckMenuChoice (E-0347)
SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2::
    farcall SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    ret z
    cp $fe
    jr z, SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_SetTwoChoiceCursorTo03
    cp $ff
    jr z, SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckMenuChoice
    ret

; Sets wTwoChoiceCursor to 3; sets wMenuChoice to 0; sets wListCursorBlink to 0; increments
; wScreenStep; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_SetTwoChoiceCursorTo03::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [wMenuChoice], a
    ld [wListCursorBlink], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; May continue in SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckRecordsFlagged;
; calls BlankTwoTableEntriesSwapMenuCursorCellsFrom5; calls StoreBAtWordTableEntry_Bank1E; sets
; wScreenStep; sets wTwoChoiceCursor to 0; sets wTextWindowTileLo to $12; sets wScriptCommandType to
; 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckMenuChoice::
    ld a, [wMenuChoice]
    and a
    jr nz, SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckRecordsFlagged
    call BlankTwoTableEntriesSwapMenuCursorCellsFrom5
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
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

; Branches on wRecordsFlagged; sets wTwoChoiceCursor to 2; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80; calls BlankTwoTableEntriesSwapMenuCursorCellsFrom5; calls
; StoreBAtWordTableEntry_Bank1E; sets wTwoChoiceCursor to 1; branches on wScreenState; sets
; wScreenStep to $15; sets wScriptCommandType to 0; sets wScriptStartRequest to $80; sets
; wScreenStep to $22; then 2 more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckRecordsFlagged::
    ld a, [wRecordsFlagged]
    and a
    jr nz, .call_blank_two_table_entries_swap_menu_cursor
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_blank_two_table_entries_swap_menu_cursor:
    call BlankTwoTableEntriesSwapMenuCursorCellsFrom5
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    cp $07
    jr z, .set_screen_step_to_22
    ld a, $15
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_step_to_22:
    ld a, $22
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 3 of SwapMonstersMenu_ChooseToView: sets wArg1 to 0; sets wArg2 to $0d; calls
; CopyScreenBufferRectWithAttrs_1E; calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; calls CopyFromBankWaitVRAM; calls
; CopyRectTo20ByteRows_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E;
; calls CountRecordsInUse; sets wScreenStep to 0; then 4 more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E::
    ld c, $05
    ld hl, $0273
    ld de, $00a7
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wGridCursorX]
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld de, Tiles1Plus7F0Tiles
    ld hl, vTiles1 + $7f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, GlyphCopyDestList5 + $8c
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $0b
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 8 of SwapMonstersMenu_ChooseToView: calls GetListEntriesCell5Address; calls
; LoadFamilyIconTileForRecordB_Bank1E; calls CopyRectTo20ByteRows_Bank1E; sets wArg1 to 0; calls
; MarkPartyMembersInRecordListPage; calls GetListEntriesCell5Address; copies the byte at
; wWindowTileBuffer + $6c to wArg1; calls CallDrawRecordStatsBoxForArg1InBank1D; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_LoadFamilyIconTileForRecordB_Bank1E::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ld de, GlyphCopyDestList5 + $20
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank1E
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    call CallDrawRecordStatsBoxForArg1InBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 12 of SwapMonstersMenu_ChooseToView: sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; increments
; wScreenStep; sets wListCursor to 0; sets wScreenStep; sets wTwoChoiceCursor to 0; calls
; StoreBAtWordTableEntry_Bank1E; sets wTextWindowTileLo to $12; sets wScriptCommandType to 0; then 2
; more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView_UpdatePagedListCursor::
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
    xor a
    ld [wListCursor], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add $08
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
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

; step 13 of SwapMonstersMenu_ChooseToView: sets wArg1 to 0; sets wArg2 to $0c; calls
; CopyScreenBufferRectWithAttrs_1E; calls CopyRectTo20ByteRows_Bank1E; calls HLToDecimalDigits;
; calls BlankLeadingZeroDigits_F; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1::
    ld c, $09
    ld hl, $01d4
    ld de, $0008
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld de, SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1_TileRect
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $03
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 3 tiles, one row per line
SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bc, $7c, $7d, $7e, $df, $7f, $fe, $ff, $76, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2

; step 19 of SwapMonstersMenu_ChooseToView: calls CopyRectTo20ByteRows_Bank1E; calls
; StoreBAtWordTableEntry_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; calls CountRecordsInUse; calls CopyRectTo20ByteRows_Bank1E; plays
; sound $6c; calls ListRecordsInUseNotEggs; calls HLToDecimalDigits; calls BlankLeadingZeroDigits_F;
; calls HLToDecimalDigits; calls BlankLeadingZeroDigits_F; then 8 more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView_CountRecordsInUse::
    ld de, GlyphCopyDestList5 + $8c
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $0b
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    farcall CountRecordsInUse
    ld de, GlyphCopyDestList5 + $282
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $05
    call CopyRectTo20ByteRows_Bank1E
    ld a, $6c
    call QueueSoundEffect
    farcall ListRecordsInUseNotEggs
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    xor a
    ld [wMenuChoice], a
    ld a, $02
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 20 of SwapMonstersMenu_ChooseToView: sets wReturnScreenState to 6; sets wReturnScreenStep to
; $0c; sets wScreenStep to 0; sets wScreenSubStep to 0; sets wScreenState to $0a; calls
; SaveAndHideSpriteState_Bank1E (E-0347)
SwapMonstersMenu_ChooseToView_SaveAndHideSpriteState_Bank1E::
    ld a, $06
    ld [wReturnScreenState], a
    ld a, $0c
    ld [wReturnScreenStep], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a
    ld [wScreenState], a
    call SaveAndHideSpriteState_Bank1E
    ret

; step 21 of SwapMonstersMenu_ChooseToView: calls LoadTileListSixPerFrame (E-0347)
SwapMonstersMenu_ChooseToView_ToLoadTileListSixPerFrame::
    farcall LoadTileListSixPerFrame
    ret

; step 22 of SwapMonstersMenu_ChooseToView: calls CopyRectTo20ByteRows_Bank1E; calls
; StoreBAtWordTableEntry_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; calls ListRecordsInUseEggs; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_ListRecordsInUseEggs::
    ld de, SwapMonstersMenu_ChooseToView_ListRecordsInUseEggs_TileRect
    ld hl, wWindowTileBuffer + $6b
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_Bank1E
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    farcall ListRecordsInUseEggs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 9 tiles, one row per line
SwapMonstersMenu_ChooseToView_ListRecordsInUseEggs_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; step 23 of SwapMonstersMenu_ChooseToView: calls FillTilesBxC; sets wTextWindowTileLo to $12;
; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_FillTilesBxC::
    ld hl, vTiles1 + $3f0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $6a0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0801
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 24 of SwapMonstersMenu_ChooseToView: calls CopyRectTo20ByteRows_Bank1E; calls
; ClampRecordListPageCursor4; branches on wListPages; calls DrawC5BEC6AtScrollOffsetDE_Bank1E; calls
; StoreC5BEC6AtHLStride2_Bank1E; copies D to wArg1; copies E to wArg2; calls
; DrawPageOfPagesAtScrollOffset; copies H to wArg1; copies L to wArg2; calls
; DrawPageOfPagesAtArg1_Bank1E; calls BGMapAddressAtScroll_Bank1E; then 2 more steps (see the code)
; (E-0347)
SwapMonstersMenu_ChooseToView_ClampRecordListPageCursor4::
    ld de, GlyphCopyDestList5 + $20d
    ld hl, wWindowTileBuffer + $6b
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_Bank1E
    call ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .call_bg_map_address_at_scroll_bank1_e
    ld de, $010e
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_Bank1E
    ld de, $010f
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $09
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 25 of SwapMonstersMenu_ChooseToView: sets wArg5 to 0; calls DrawRecordListPageSpeciesNames;
; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_DrawRecordListPageSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 26 of SwapMonstersMenu_ChooseToView: calls CopyFromBankWaitVRAM; sets wArg1 to 0; sets wArg2
; to 0; calls DrawRecordListPageMarks; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_DrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 27 of SwapMonstersMenu_ChooseToView: sets wMenuInputResult to 1; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; increments
; wScreenStep; sets wListCursor to 0; sets wReturnScreenState to 6; sets wReturnScreenStep to $1b;
; sets wScreenStep to 0; sets wScreenSubStep to 0; sets wScreenState to $0b; then 1 more step (see
; the code) (E-0347)
SwapMonstersMenu_ChooseToView_UpdatePagedListCursor_SetMenuInputResult::
    ld a, $01
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
    jr z, .return
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .set_return_screen_state_to_06
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.return:
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wListCursor], a
    ret

.set_return_screen_state_to_06:
    ld a, $06
    ld [wReturnScreenState], a
    ld a, $1b
    ld [wReturnScreenStep], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b
    ld [wScreenState], a
    call SaveAndHideSpriteState_Bank1E
    ret

; step 29 of SwapMonstersMenu_ChooseToView: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; calls CopyFromBankWaitVRAM;
; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView_CopyRectTo20ByteRows_Bank1E::
    ld de, GlyphCopyDestList5 + $2c3
    ld hl, wWindowTileBuffer + $6b
    lb bc, $04, $08
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $09
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles1 + $4f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles
    ld hl, vTiles1 + $750
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles1 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus770Tiles
    ld hl, vTiles1 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 30 of SwapMonstersMenu_ChooseToView: sets wArg1 to $9e; sets wArg2 to 0; copies D to wArg3;
; copies E to wArg4; calls LoadTileListSixPerCall; returns unless wArg5 is $ff; calls
; StoreBAtWordTableEntry_Bank1E; sets wScreenStep to 2; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView_LoadTileListSixPerCall::
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, LoadTileListSixPerFrame_Data
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wMenuChoice]
    ld b, $c3
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    ld a, $02
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; screen state 7 (menu option 3): the SwapMonstersMenu_ChooseToView steps for another list (E-0302)
SwapMonstersMenu_ChooseToView2::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ChooseToView_WriteScreenStepAndMenuChoice
    dw SwapMonstersMenu_ChooseToView_ListRecordsInUseNotEggs
    dw SwapMonstersMenu_ChooseToView2_WriteTwoChoiceCursorAndScriptCommandTypeEtc
    dw SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC
    dw SwapMonstersMenu_ChooseToView_ListRecordsInUseNotEggs_2
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_ChooseToView_LoadFamilyIconTileForRecordB_Bank1E
    dw SwapMonstersMenu_MoveRecords_FillTilesBxC_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_MoveRecords_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ChooseToView_UpdatePagedListCursor
    dw SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_ChooseToView_CountRecordsInUse
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs
    dw SwapMonstersMenu_ChooseToView2_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ChooseToView2_CopyRecordNameToNameGlyphBuf
    dw SwapMonstersMenu_ChooseToView2_DeleteSRAMRecordAndCompact
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_MoveRecords_BGMapAddressAtScroll_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_SetScreenStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_MoveRecords_CountRecordsInUse
    dw SwapMonstersMenu_ChooseToView_ToLoadTileListSixPerFrame
    dw SwapMonstersMenu_ChooseToView_ListRecordsInUseEggs
    dw SwapMonstersMenu_ChooseToView_FillTilesBxC
    dw SwapMonstersMenu_ChooseToView_ClampRecordListPageCursor4
    dw SwapMonstersMenu_ChooseToView_DrawRecordListPageSpeciesNames
    dw SwapMonstersMenu_ChooseToView_DrawRecordListPageMarks
    dw SwapMonstersMenu_ChooseToView2_UpdatePagedListCursor
    dw SwapMonstersMenu_ChooseToView_CopyScreenBufferRectWithAttrs_1E_SetArg1
    dw SwapMonstersMenu_ChooseToView_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_ChooseToView_LoadTileListSixPerCall
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep_AdvanceScreenStep
    dw SwapMonstersMenu_MoveRecords_CopyRectTo20ByteRows_Bank1E_SetChoiceCursor
    dw SwapMonstersMenu_MoveRecords_BlinkCursorBlinkAE_Bank1E
    dw SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_SetScreenStep
    dw SwapMonstersMenu_ChooseToView2_ListRecordsInUseEggs
    dw SwapMonstersMenu_ChooseToView2_StoreBAtWordTableEntry_Bank1E_SetScreenStep
    dw SwapMonstersMenu_ChooseToView2_SetScreenStep
    dw SwapMonstersMenu_ChooseToView2_DeleteSRAMRecordAndCompact_GetListEntriesCell4Address
    dw SwapMonstersMenu_MoveRecords_CopyScreenBufferRectWithAttrs_1E
    dw SwapMonstersMenu_ChooseToView2_CopyRectTo20ByteRows_Bank1E
    dw SwapMonstersMenu_ChooseToView2_LoadTileListSixPerCall
    dw SwapMonstersMenu_ChooseToView2_CopyFromBankWaitVRAM
    dw SwapMonstersMenu_MoveRecords_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_MoveRecords_DrawRecordListNameTiles_Bank1D
    dw SwapMonstersMenu_ChooseToView2_CountRecordsInUse

; step 2 of SwapMonstersMenu_ChooseToView2: calls
; SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D; returns if wMenuInputResult is 0; returns
; if wMenuInputResult is $fd; may continue in
; SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_SetTwoChoiceCursorTo03; branches on
; wMenuInputResult; may continue in
; SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckRecordsFlagged; calls
; ListRecordsInUseNotEggs; branches on wListCount; sets wTwoChoiceCursor to 4; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80; sets wScreenStep; then 6 more steps (see
; the code) (E-0347)
SwapMonstersMenu_ChooseToView2_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
    farcall SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    ret z
    cp $fe
    jp z, SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_SetTwoChoiceCursorTo03
    cp $ff
    jr z, .check_menu_choice
    ret

.check_menu_choice:
    ld a, [wMenuChoice]
    and a
    jp nz, SwapMonstersMenu_ChooseToView_BlinkCursorBlinkB8_Bank1D_2_CheckRecordsFlagged
    farcall ListRecordsInUseNotEggs
    ld a, [wListCount]
    cp $02
    jr nc, .read_screen_step
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    call BlankTwoTableEntriesSwapMenuCursorCellsFrom5
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
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

; step 23 of SwapMonstersMenu_ChooseToView2: calls CopyRectTo20ByteRows_Bank1E; calls
; ListRecordsInUseNotEggs; calls HLToDecimalDigits; calls BlankLeadingZeroDigits_F; calls
; HLToDecimalDigits; calls BlankLeadingZeroDigits_F; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs::
    ld de, GlyphCopyDestList5 + $282
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $05
    call CopyRectTo20ByteRows_Bank1E
    ld de, SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_TileRect
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $01
    call CopyRectTo20ByteRows_Bank1E
    ld de, SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_TileRect_2
    ld hl, wWindowTileBuffer + $11f
    lb bc, $01, $02
    call CopyRectTo20ByteRows_Bank1E
    farcall ListRecordsInUseNotEggs
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 1 tiles, one row per line
SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_TileRect::
    db $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; record: 1 x 2 tiles, one row per line
SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_TileRect_2::
    db $b7 ; id 0
    db $b5 ; id 1

; step 24 of SwapMonstersMenu_ChooseToView2: calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; sets wScreenStep to $0c; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView2_StoreBAtWordTableEntry_Bank1E::
    ld a, [wListCursor]
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $0c
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 25 of SwapMonstersMenu_ChooseToView2: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell5Address; calls CopyRecordNameToNameGlyphBuf; branches on the byte at
; wNameGlyphBuf; branches on C; sets rRAMG2 to 0; increments wScreenStep; sets wTextWindowTileLo to
; $12; sets wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView2_CopyRecordNameToNameGlyphBuf::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .skip
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.skip:
    ld a, $f0
    ld [de], a
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
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

; step 26 of SwapMonstersMenu_ChooseToView2: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell5Address; sets wArg1; sets rRAMG2 to 0; sets wArg2 to 0; calls
; DeleteSRAMRecordAndCompact; calls ListPartyRecordsWithState2ToListEntries; calls
; LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest to $7f; calls
; SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E; sets wListCursor to 0; then 4
; more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView2_DeleteSRAMRecordAndCompact::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; step 40 of SwapMonstersMenu_ChooseToView2: sets wMenuInputResult to 1; calls
; UpdatePagedListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets
; wScreenStep; increments wScreenStep; sets wListCursor to 0; sets wTwoChoiceCursor to 1; sets
; wTextWindowTileLo to $12; sets wTwoChoiceCursor to 0; sets wScreenStep; calls
; StoreBAtWordTableEntry_Bank1E; then 3 more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView2_UpdatePagedListCursor::
    ld a, $01
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
    jr z, .return
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .clear_two_choice_cursor
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.return:
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wListCursor], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5 + $4
    call StoreBAtWordTableEntry_Bank1E
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

; step 47 of SwapMonstersMenu_ChooseToView2: calls CopyRectTo20ByteRows_Bank1E; calls
; ListRecordsInUseNotEggs; calls HLToDecimalDigits; calls BlankLeadingZeroDigits_F; calls
; HLToDecimalDigits; calls BlankLeadingZeroDigits_F; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_SetScreenStep::
    ld de, GlyphCopyDestList5 + $282
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $05
    call CopyRectTo20ByteRows_Bank1E
    ld de, SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_SetScreenStep_TileRect
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $01
    call CopyRectTo20ByteRows_Bank1E
    farcall ListRecordsInUseNotEggs
    ld a, [wListCount]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $129
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wRecordsFlagged]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    ld hl, wWindowTileBuffer + $151
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 1 tiles, one row per line
SwapMonstersMenu_ChooseToView2_ListRecordsInUseNotEggs_SetScreenStep_TileRect::
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; step 48 of SwapMonstersMenu_ChooseToView2: calls ListRecordsInUseEggs; calls
; ClampRecordListPageCursor4; branches on wListPages; calls DrawC5BEC6AtScrollOffsetDE_Bank1E; calls
; StoreC5BEC6AtHLStride2_Bank1E; copies D to wArg1; copies E to wArg2; calls
; DrawPageOfPagesAtScrollOffset; copies H to wArg1; copies L to wArg2; calls
; DrawPageOfPagesAtArg1_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView2_ListRecordsInUseEggs::
    farcall ListRecordsInUseEggs
    call ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld de, $010e
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_Bank1E
    ld de, $010f
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 49 of SwapMonstersMenu_ChooseToView2: calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; sets wScreenStep to $28; sets
; wScriptCommandType to 0; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView2_StoreBAtWordTableEntry_Bank1E_SetScreenStep::
    ld a, [wListCursor]
    ld b, $c3
    ld hl, SwapMenuCursorCellsFrom5 + $4
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wMenuChoice]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, $28
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 50 of SwapMonstersMenu_ChooseToView2: increments wScreenStep; sets wScriptCommandType to 0;
; sets wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView2_SetScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 51 of SwapMonstersMenu_ChooseToView2: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell4Address; sets wArg1; sets rRAMG2 to 0; sets wArg2 to 0; calls
; DeleteSRAMRecordAndCompact; calls ListPartyRecordsWithState2ToListEntries; calls
; SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E; sets wListCursor to 0; sets
; wChoiceCursor to 0; sets wListPageIndex to 0; then 2 more steps (see the code) (E-0347)
SwapMonstersMenu_ChooseToView2_DeleteSRAMRecordAndCompact_GetListEntriesCell4Address::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell4Address
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    call SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; Calls CopyRectTo20ByteRows_Bank1E; sets wArg1 to 0; sets wArg2 to $0d; calls
; CopyScreenBufferRectWithAttrs_1E; calls StoreBAtWordTableEntry_Bank1E; increments wScreenStep
; (E-0347)
SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E::
    ld de, SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $01
    call CopyRectTo20ByteRows_Bank1E
    ld c, $05
    ld hl, $0287
    ld de, $00bb
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld a, [wListCursor]
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
SwapMonstersMenu_ChooseToView2_CopyScreenBufferRectWithAttrs_1E_TileRect::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; step 54 of SwapMonstersMenu_ChooseToView2: sets wArg1 to $9e; sets wArg2 to 0; copies D to wArg3;
; copies E to wArg4; calls LoadTileListSixPerCall; returns unless wArg5 is $ff; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView2_LoadTileListSixPerCall::
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, LoadTileListSixPerFrame_Data
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 55 of SwapMonstersMenu_ChooseToView2: calls CopyFromBankWaitVRAM; increments wScreenStep
; (E-0347)
SwapMonstersMenu_ChooseToView2_CopyFromBankWaitVRAM::
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles1 + $4f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles
    ld hl, vTiles1 + $750
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles1 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus770Tiles
    ld hl, vTiles1 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 53 of SwapMonstersMenu_ChooseToView2: calls CopyRectTo20ByteRows_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ChooseToView2_CopyRectTo20ByteRows_Bank1E::
    ld de, GlyphCopyDestList5 + $2c3
    ld hl, wWindowTileBuffer + $6b
    lb bc, $04, $08
    call CopyRectTo20ByteRows_Bank1E
    ld de, GlyphCopyDestList5 + $2e3
    ld hl, wWindowTileBuffer + $10b
    lb bc, $04, $03
    call CopyRectTo20ByteRows_Bank1E
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 58 of SwapMonstersMenu_ChooseToView2: calls CountRecordsInUse; sets wScreenStep to 0; sets
; wScreenState to 2; sets wTwoChoiceCursor to 1; sets wScriptCommandType to 0; sets
; wScriptStartRequest to $80 (E-0347)
SwapMonstersMenu_ChooseToView2_CountRecordsInUse::
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

; by wScreenStep: draws the selected record's name, species, personality, level and status, category
; string and parent names (E-0288)
SwapMonstersMenu_ShowMonsterDetails::
    ld a, [wScreenStep]
    jumptable
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex
    dw SwapMonstersMenu_ShowMonsterDetails_StoreBAtWordTableEntry_Bank1E
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPlayerAndFollowerSpriteGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_ToFillTilesBxCAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4
    dw SwapMonstersMenu_ShowMonsterDetails_ShowRecordPersonalityName
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4
    dw SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address_SetTemp5
    dw SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordParentNames
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3

; step 3 of SwapMonstersMenu_ShowMonsterDetails: calls BGMapAddressAtScroll_Bank1E; sets wArg3 to
; $14; sets wArg4 to $12; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; branches on
; wListPages; calls DrawC5BEC6AtScrollOffsetDE_Bank1E; copies D to wArg1; copies E to wArg2; calls
; DrawPageOfPagesAtScrollOffset; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3::
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1E
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    call DrawPageOfPagesAtScrollOffset

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; moves the paged cursor, clears the panel, redraws the list and continues
; (ListRecordsState1ThenContinue) (E-0303)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList_UpdatePagedListCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList_CallListRecordsState1ThenContinue

; step 0 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList: sets wMenuInputResult to 0;
; calls UpdatePagedListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult;
; increments wScreenSubStep; sets wScreenStep to 4; increments wScreenStep; calls
; BGMapAddressAtScroll_Bank1E; sets wArg3 to 6; sets wArg4 to 6; sets wArg7 to 0; calls
; DrawTileRectAtHLFromDE_Bank1E; then 1 more step (see the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList_UpdatePagedListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .check_screen_sub_step
    cp $fc
    jr z, .check_screen_sub_step
    cp $fd
    jr z, .set_screen_step_to_04
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .call_bg_map_address_at_scroll_bank1_e
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.set_screen_step_to_04:
    ld a, $04
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params_TileRect_2
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $0e
    ld [wScreenStep], a
    ret

; clears tile areas with FillTilesBxC (12 x 1 at vTiles1 + $240, 15 x 1 at + $500, 5 x 1 at + $700,
; 2 x 1 at + $4E0), then wScreenSubStep += 1 (E-0118)
ClearTileAreasAndIncScreenSubStep::
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
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; runs ClampRecordListPageCursor5 and DrawRecordListPageNames, wScreenStep -= 1 and wScreenSubStep
; += 1 (E-0122)
RedrawRecordListAndNextStep::
    call ClampRecordListPageCursor5
    call CallDrawRecordListPageNamesInBank1F
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; step 3 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList: calls
; ListRecordsState1ThenContinue; sets wScreenStep to 4; sets wScreenSubStep to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList_CallListRecordsState1ThenContinue::
    call ListRecordsState1ThenContinue
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; step 13 of SwapMonstersMenu_ShowMonsterDetails: calls LoadPlayerAndFollowerSpriteGraphics; sets
; wOBJPaletteUploadRequest to $7f; calls EraseCEntriesOfWordTable_Bank1E; branches on wDataBank;
; branches on wReturnScreenState; branches on wReturnScreenStep; branches on wScreenState; branches
; on wReturnScreenState; branches on wScriptCommandType; calls StoreBAtWordTableEntry_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; then 10 more steps (see the code)
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld c, $05
    ld hl, SwapMenuCursorCells
    call EraseCEntriesOfWordTable_Bank1E
    ld a, [wDataBank]
    cp $1f
    jr z, .check_screen_state
    ld a, [wReturnScreenState]
    cp $04
    jr z, .read_list_cursor
    cp $05
    jr nz, .call_bg_map_address_at_scroll_bank1_e
    ld a, [wReturnScreenStep]
    cp $2f
    jr c, .call_bg_map_address_at_scroll_bank1_e
    jr .read_list_cursor

.check_screen_state:
    ld a, [wScreenState]
    cp $0a
    jr nz, .read_list_cursor
    ld a, [wReturnScreenState]
    cp $06
    jr z, .call_bg_map_address_at_scroll_bank1_e
    ld a, [wScriptCommandType]
    cp $e8
    jr z, .read_list_cursor
    jr .call_bg_map_address_at_scroll_bank1_e

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank1E
    call RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
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

; draws the species sprite, clears the panel, redraws the list and continues (E-0303)
SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_WriteScreenSubStep

; step 0 of SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList: branches on wGameMode; calls
; DrawListEntriesCell5SpeciesSprite; sets wMenuInputResult to 0; calls UpdatePagedListCursor;
; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets hSpriteHideTile to 0;
; increments wScreenSubStep; sets hSpriteHideTile to 0; increments wScreenStep; sets hSpriteHideTile
; to 0; increments wScreenStep; then 12 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode::
    ld a, [wGameMode]
    cp $05
    jr z, .clear_menu_input_result
    farcall DrawListEntriesCell5SpeciesSprite

.clear_menu_input_result:
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .clear_sprite_hide_tile
    cp $fc
    jr z, .clear_sprite_hide_tile
    cp $fd
    jr z, .clear_sprite_hide_tile2
    cp $fe
    jr z, .clear_sprite_hide_tile4
    cp $ff
    jr z, .clear_sprite_hide_tile3
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile3:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile4:
    xor a
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode_TileRect_2
    ld a, $0c
    ld [wArg3], a
    ld a, $0f
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode_TileRect
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $04
    ld [wScreenStep], a
    ret

; step 3 of SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList: calls
; ListRecordsState1ThenContinue; sets wScreenSubStep to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_WriteScreenSubStep::
    call ListRecordsState1ThenContinue
    xor a
    ld [wScreenSubStep], a
    ret

; as SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList (E-0303)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_CallListRecordsState1ThenContinue

; step 0 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2: sets wMenuInputResult to 0;
; calls UpdatePagedListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult;
; increments wScreenSubStep; sets wScreenStep; calls FillTilesBxC; increments wScreenStep; calls
; CopyFromBankWaitVRAM; calls UploadTilesFromData; calls BGMapAddressAtScroll_Bank1E; sets wArg3 to
; 8; then 12 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .check_screen_sub_step
    cp $fc
    jr z, .check_screen_sub_step
    cp $fd
    jr z, .read_screen_step
    cp $fe
    jr z, .call_fill_tiles_bx_c
    cp $ff
    jr z, .skip
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $02
    ld [wScreenStep], a
    ret

.call_fill_tiles_bx_c:
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld hl, vTiles2 + $730
    ld de, Tiles1Plus2E0Tiles_2
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor_TileRect_2
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $6c0
    ld bc, $0201
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    ret

; step 3 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2: calls
; ListRecordsState1ThenContinue; sets wScreenStep; sets wScreenSubStep to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_CallListRecordsState1ThenContinue::
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; step 23 of SwapMonstersMenu_ShowMonsterDetails: calls BGMapAddressAtScroll_Bank1E; sets wArg3 to
; $0c; sets wArg4 to $12; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; sets wArg3 to 8; sets wArg4 to 7; sets wArg7 to 0; calls
; DrawTileRectAtHLFromDE_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2_TileRect_2
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 24 of SwapMonstersMenu_ShowMonsterDetails: calls FillTilesBxC; calls
; BGMapAddressAtScroll_Bank1E; sets wArg3 to $0c; sets wArg4 to $12; sets wArg7 to 0; calls
; DrawTileRectAtHLFromDE_Bank1E; calls BGMapAddressAtScroll_Bank1E; sets wArg3 to 8; sets wArg4 to
; 7; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3_TileRect_2
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; as SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList (E-0303)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_CallListRecordsState1ThenContinue

; step 0 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3: sets wMenuInputResult to 0;
; calls UpdatePagedListCursor; branches on wMenuInputResult; may continue in
; SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile;
; may continue in
; SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile2;
; may continue in
; SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile3;
; returns if wGameMode is $05; calls CallDrawPartySpeciesSpritesPreservingArg1AndTemp0; sets
; hSpriteHideTile to 0; increments wScreenSubStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    jr z, .check_game_mode
    cp $fb
    jr z, .clear_sprite_hide_tile
    cp $fc
    jr z, .clear_sprite_hide_tile
    cp $fd
    jr z, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile
    cp $fe
    jr z, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile2
    cp $ff
    jr z, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile3

.check_game_mode:
    ld a, [wGameMode]
    cp $05
    ret z
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Sets hSpriteHideTile to 0; decrements wScreenStep; calls FillTilesBxC; sets wTextWindowTileLo to
; $12 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile::
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

; Sets hSpriteHideTile to 0; sets wScreenStep to $17 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile2::
    xor a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

; Sets hSpriteHideTile to 0; sets wScreenStep to 7 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile3::
    xor a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; step 3 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3: calls
; ListRecordsState1ThenContinue; decrements wScreenStep; sets wScreenSubStep to 0; continues in
; SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_CallListRecordsState1ThenContinue::
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    jp SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile

; screen state $0E: as SwapMonstersMenu_ShowMonsterDetails2 (E-0302)
SwapMonstersMenu_ShowMonsterDetails3::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails3_SwapMonstersMenu_CopySixteenTiles
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawTileRectAtHLFromDE_Bank1E
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll_2
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPlayerAndFollowerSpriteGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_ToFillTilesBxCAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4
    dw SwapMonstersMenu_ShowMonsterDetails_ShowRecordPersonalityName
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address_SetTemp5
    dw SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordParentNames
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3

; step 3 of SwapMonstersMenu_ShowMonsterDetails3: calls BGMapAddressAtScroll_Bank1E; sets wArg3 to
; $14; sets wArg4 to $12; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_DrawTileRectAtHLFromDE_Bank1E::
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowMonsterDetails3_DrawTileRectAtHLFromDE_Bank1E_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; screen state $0C: the detail steps for the listed records
; (ListRecordsAndDrawListEntriesCell5Panel) (E-0302)
SwapMonstersMenu_ShowMonsterDetails2::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails3_SwapMonstersMenu_CopySixteenTiles
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll_2
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPlayerAndFollowerSpriteGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_ToFillTilesBxCAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4
    dw SwapMonstersMenu_ShowMonsterDetails_ShowRecordPersonalityName
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address_SetTemp5
    dw SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordParentNames
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3

; step 1 of SwapMonstersMenu_ShowMonsterDetails3: calls SwapMonstersMenu_WriteGlyphListPos; calls
; SwapMonstersMenu_CopySixteenTiles; calls ClearTileAreasAndIncScreenSubStep; calls
; RedrawRecordListAndNextStep; calls
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5; sets wScreenSubStep to 0; sets
; wScreenStep to 2 (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_SwapMonstersMenu_CopySixteenTiles::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_WriteGlyphListPos
    call SwapMonstersMenu_CopySixteenTiles
    call ClearTileAreasAndIncScreenSubStep
    call RedrawRecordListAndNextStep
    call SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5
    xor a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenStep], a
    ret

; copies 16 tiles by the tables at $60B1 and $60C1 (E-0305)
SwapMonstersMenu_CopySixteenTiles::
    ld c, $00
    ld b, $10

.loop:
    push bc
    ld a, c
    ld de, SwapMonstersMenu_CopySixteenTiles_Data1
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    ld hl, GlyphFont
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a
    ld de, SwapMonstersMenu_CopySixteenTiles_Data2
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; data read by SwapMonstersMenu_CopySixteenTiles (16 bytes) (E-0347)
SwapMonstersMenu_CopySixteenTiles_Data1::
    db $a3, $54, $44, $11, $16, $19, $48, $24, $a6, $12, $31, $29, $32, $18, $14, $a3

SwapMonstersMenu_CopySixteenTiles_Data2::
    db $d0, $8e, $e0, $8e, $f0, $8e, $50, $8f, $60, $8f, $70, $8f, $d0, $8f, $e0, $8f
    db $f0, $8f, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; step 7 of SwapMonstersMenu_ShowMonsterDetails3: calls ClearBGMapAtScrollAndResetScroll; calls
; SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf; sets wScreenSubStep to 0
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll_2::
    call ClearBGMapAtScrollAndResetScroll
    call SwapMonstersMenu_ShowMonsterDetails3_CopyRecordNameToNameGlyphBuf
    xor a
    ld [wScreenSubStep], a
    ret

; step 8 of SwapMonstersMenu_ShowMonsterDetails3: increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; screen state $0A: the details of a farm record (ListRecordsInUseNotEggs) (E-0302)
SwapMonstersMenu_ShowFarmMonsterDetails::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex
    dw SwapMonstersMenu_ShowMonsterDetails_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ShowFarmMonsterDetails_ListRecordsInUseNotEggs
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPlayerAndFollowerSpriteGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_ToFillTilesBxCAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4
    dw SwapMonstersMenu_ShowMonsterDetails_ShowRecordPersonalityName
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address_SetTemp5
    dw SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordParentNames
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3

; step 10 of SwapMonstersMenu_ShowFarmMonsterDetails: calls SwapMonstersMenu_WriteGlyphListPos;
; calls ListRecordsInUseNotEggs; calls GetListEntriesCell5Address; calls
; LoadFamilyIconTileForRecordB_Bank1E; copies the byte at GlyphCopyDestList5 to wArg1; calls
; CallDrawRecordStatsBoxForArg1InBank1D; calls LoadFamilyIconTileForRecordB_Bank1E; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ShowFarmMonsterDetails_ListRecordsInUseNotEggs::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_WriteGlyphListPos
    farcall ListRecordsInUseNotEggs
    call GetListEntriesCell5Address
    push hl
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    pop hl
    push hl
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    call CallDrawRecordStatsBoxForArg1InBank1D
    pop hl
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 4 of SwapMonstersMenu_ShowMonsterDetails3: calls DrawListEntriesCell5RecordDetails; sets
; wArg1 to 1; calls MarkPartyMembersInRecordListPage; sets wArg1 to 0; calls
; MarkPartyMembersInRecordListPage (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_DrawListEntriesCell5RecordDetails::
    call DrawListEntriesCell5RecordDetails
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; moves the paged cursor, clears the panel and redraws the list (E-0303)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList_UpdatePagedListCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList_CallClampRecordListPageCursor5

; step 3 of SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList: calls
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5; calls
; SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap; sets wScreenStep to 4; sets
; wScreenSubStep to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList_CallClampRecordListPageCursor5::
    call SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5
    call SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; step 10 of SwapMonstersMenu_ShowMonsterDetails3: calls SwapMonstersMenu_WriteGlyphListPos; calls
; ListRecordsAndDrawListEntriesCell5Panel; calls GetListEntriesCell5Address; calls
; LoadFamilyIconTileForRecordB_Bank1E (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_ListRecordsAndDrawListEntriesCell5Panel::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_WriteGlyphListPos
    call ListRecordsAndDrawListEntriesCell5Panel
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ret

; step 0 of SwapMonstersMenu_ShowMonsterDetails3: calls ClearBGMapAtScrollAndResetScroll; calls
; CopyFromBankWaitVRAM (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll::
    call ClearBGMapAtScrollAndResetScroll
    ld de, Tiles1Plus7F0Tiles
    ld hl, vTiles1 + $7f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; draws the species sprite, clears the panel and redraws the list (E-0303)
SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList_CallClampRecordListPageCursor5

; step 3 of SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList: calls
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5; calls
; SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap; sets wArg1 to 1; calls
; MarkPartyMembersInRecordListPage; sets wArg1 to 0; calls MarkPartyMembersInRecordListPage; sets
; wScreenSubStep to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList_CallClampRecordListPageCursor5::
    call SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5
    call SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wScreenSubStep], a
    ret

; as SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList (E-0303)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2_CallClampRecordListPageCursor5

; step 3 of SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2: calls
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5; calls
; SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap; sets wArg1 to 1; calls
; MarkPartyMembersInRecordListPage; sets wArg1 to 0; calls MarkPartyMembersInRecordListPage; sets
; wScreenStep; sets wScreenSubStep to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2_CallClampRecordListPageCursor5::
    call SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5
    call SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; as SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList (E-0303)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3_CallClampRecordListPageCursor5

; step 3 of SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3: calls
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5; calls
; SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap; sets wArg1 to 1; calls
; MarkPartyMembersInRecordListPage; sets wArg1 to 0; calls MarkPartyMembersInRecordListPage;
; decrements wScreenStep; sets wScreenSubStep to 0; continues in
; SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3_CallClampRecordListPageCursor5::
    call SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5
    call SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    jp SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3_UpdatePagedListCursor_ClearSpriteHideTile

; screen state $0D: as ShowParents (E-0302)
SwapMonstersMenu_ShowParents2::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowParents2_SwapMonstersMenu_CopySixteenTiles
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowParents2_FillTilesBxC_SetListCursor
    dw SwapMonstersMenu_ShowParents2_UploadTilesFromData
    dw SwapMonstersMenu_ShowParents2_DrawRecordParentNames
    dw SwapMonstersMenu_ShowParents2_DrawRect6x6FromAtScroll41
    dw SwapMonstersMenu_ShowParents2_HandleListCursorInput_1D
    dw SwapMonstersMenu_ShowParents2_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll_2
    dw SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex
    dw SwapMonstersMenu_ShowMonsterDetails_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ShowParents2_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ChooseToView_FillTilesBxC
    dw SwapMonstersMenu_ShowParents2_ClampRecordListPageCursor4
    dw SwapMonstersMenu_ChooseToView_DrawRecordListPageSpeciesNames
    dw SwapMonstersMenu_ShowParents2_DrawRecordListPageMarks
    dw SwapMonstersMenu_ShowParents2_LoadPlayerAndFollowerSpriteGraphics

; step 1 of SwapMonstersMenu_ShowParents2: calls SwapMonstersMenu_WriteGlyphListPos; calls
; SwapMonstersMenu_CopySixteenTiles; sets wScreenSubStep to 0; sets wScreenStep to 2 (E-0347)
SwapMonstersMenu_ShowParents2_SwapMonstersMenu_CopySixteenTiles::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_WriteGlyphListPos
    call SwapMonstersMenu_CopySixteenTiles
    xor a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenStep], a
    ret

; screen state $0B: DrawRecordParentNames with a cursor, then the record list page (E-0302)
SwapMonstersMenu_ShowParents::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowParents2_FillTilesBxC_SetListCursor
    dw SwapMonstersMenu_ShowParents2_UploadTilesFromData
    dw SwapMonstersMenu_ShowParents2_DrawRecordParentNames
    dw SwapMonstersMenu_ShowParents2_DrawRect6x6FromAtScroll41
    dw SwapMonstersMenu_ShowParents2_HandleListCursorInput_1D
    dw SwapMonstersMenu_ShowParents2_FillTilesBxC
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex
    dw SwapMonstersMenu_ShowMonsterDetails_StoreBAtWordTableEntry_Bank1E
    dw SwapMonstersMenu_ShowParents2_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ChooseToView_FillTilesBxC
    dw SwapMonstersMenu_ShowParents2_ClampRecordListPageCursor4
    dw SwapMonstersMenu_ChooseToView_DrawRecordListPageSpeciesNames
    dw SwapMonstersMenu_ShowParents2_DrawRecordListPageMarks
    dw SwapMonstersMenu_ShowParents2_LoadPlayerAndFollowerSpriteGraphics

; step 3 of SwapMonstersMenu_ShowParents2: calls FillTilesBxC; calls CopyFromBankWaitVRAM; sets
; wListCursor; sets wListPageIndex to 0; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowParents2_FillTilesBxC_SetListCursor::
    ld hl, vTiles2 + $200
    ld bc, $1304
    call FillTilesBxC
    ld de, Tiles1Plus7D0Tiles
    ld hl, vTiles1 + $6d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wListPageIndex]
    add a
    add a
    ld b, a
    ld a, [wListCursor]
    add b
    ld [wListCursor], a
    xor a
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 4 of SwapMonstersMenu_ShowParents2: calls UploadTilesFromData; calls
; BGMapAddressAtScroll_Bank1E; sets wArg3 to $14; sets wArg4 to $12; sets wArg7 to 0; calls
; DrawTileRectAtHLFromDE_Bank1E; calls GetListEntriesCell4Address; copies L to wArg1; copies H to
; wArg2; calls LoadPartySpeciesSpriteGraphics; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowParents2_UploadTilesFromData::
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowParents2_UploadTilesFromData_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call GetListEntriesCell4Address
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall LoadPartySpeciesSpriteGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 5 of SwapMonstersMenu_ShowParents2: calls GetListEntriesCell4Address; calls
; DrawRecordParentNames; calls DrawRecordFamilyEntries; sets hSpriteHideTile to $f0; calls
; BGMapAddressAtScroll_Bank1E; calls StepBGMapAddressBackOnScrollWrap; branches on wListCount; calls
; CopyFromBankWaitVRAM; calls BGMapAddressAtScroll_Bank1E; calls StepBGMapAddressBackOnScrollWrap;
; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowParents2_DrawRecordParentNames::
    call GetListEntriesCell4Address
    ld a, [hl]
    ld b, a
    call DrawRecordParentNames
    call DrawRecordFamilyEntries
    ld a, $f0
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0069
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $6c
    ld [hl], a
    ei
    ld de, $0120
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $6d
    ld [hl], a
    ei
    ld a, [wListCount]
    cp $02
    jr c, .check_screen_step
    ld de, Tiles2Plus20Tiles
    ld hl, vTiles2 + $20
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus30Tiles
    ld hl, vTiles2 + $30
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank1E
    ld de, $0012
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $02
    ld [hl], a
    ei
    ld de, $0220
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $03
    ld [hl], a
    ei

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 6 of SwapMonstersMenu_ShowParents2: branches on wScreenSubStep; calls
; DrawRect6x6FromAtScroll41; calls GetListEntriesCell4Address; sets rRAMG2 to $0a; sets rRAMB to 0;
; calls LoadSRAMRecordWord; calls LoadMonsterPicture; sets rRAMG2 to 0; increments wScreenSubStep;
; calls GetListEntriesCell4Address; sets rRAMG2 to $0a; sets rRAMB to 0; then 15 more steps (see the
; code) (E-0347)
SwapMonstersMenu_ShowParents2_DrawRect6x6FromAtScroll41::
    ld a, [wScreenSubStep]
    and a
    jp nz, .call_get_list_entries_cell4_address
    call DrawRect6x6FromAtScroll41
    call GetListEntriesCell4Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld hl, vTiles2 + $480
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_get_list_entries_cell4_address:
    call GetListEntriesCell4Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a
    jr z, .restore
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.restore:
    pop hl
    xor a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    ld de, SwapMonstersMenu_ShowParents2_DrawRect6x6FromAtScroll41_TileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 7 of SwapMonstersMenu_ShowParents2: calls HandleListCursorInput_1D; branches on
; wMenuInputResult; branches on wLinkMode; branches on wLinkSession; calls
; GetListEntriesCell4Address; copies L to wArg1; copies H to wArg2; calls DrawPartySpeciesSprites;
; branches on wRecordsFlagged; sets hSpriteHideTile to 0; increments wScreenStep; calls
; SplitListCursorBy4_Bank1E; then 2 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowParents2_HandleListCursorInput_1D::
    farcall HandleListCursorInput_1D
    ld a, [wMenuInputResult]
    and a
    jr z, .loop
    cp $fd
    jr z, .check_records_flagged
    cp $fe
    jr z, .call_split_list_cursor_by4_bank1_e
    cp $ff
    jr z, .call_split_list_cursor_by4_bank1_e

.loop:
    ld a, [wLinkMode]
    and a
    jr z, .call_get_list_entries_cell4_address
    ld a, [wLinkSession]
    cp $08
    jr nz, .call_get_list_entries_cell4_address
    ret

.call_get_list_entries_cell4_address:
    call GetListEntriesCell4Address
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall DrawPartySpeciesSprites
    ret

.check_records_flagged:
    ld a, [wRecordsFlagged]
    cp $02
    jr c, .loop
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_split_list_cursor_by4_bank1_e:
    call SplitListCursorBy4_Bank1E
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; step 8 of SwapMonstersMenu_ShowParents2: calls FillTilesBxC; sets wScreenStep (E-0347)
SwapMonstersMenu_ShowParents2_FillTilesBxC::
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, vTiles2 + $480
    ld bc, $0904
    call FillTilesBxC
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

; step 12 of SwapMonstersMenu_ShowParents2: calls SwapMonstersMenu_WriteGlyphListPos; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ShowParents2_ToSwapMonstersMenu_WriteGlyphListPosAndStep::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 17 of SwapMonstersMenu_ShowParents2: calls LoadPlayerAndFollowerSpriteGraphics; sets
; wOBJPaletteUploadRequest to $7f; calls BGMapAddressAtScroll_Bank1E; calls
; DrawScreenBufferRect_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E;
; calls RestoreSpriteStateFromSavedFieldDrawFlags; sets hSpriteHideTile to $70; sets wScreenSubStep
; to 0; copies wReturnScreenState to wScreenState; copies wReturnScreenStep to wScreenStep; sets
; wTextWindowTileLo to $12; then 3 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowParents2_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank1E
    call RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wReturnScreenState]
    cp $07
    ret nz
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 14 of SwapMonstersMenu_ShowParents2: calls CopyRectTo20ByteRows_Bank1E; calls
; ClampRecordListPageCursor4; branches on wListPages; branches on wReturnScreenState; calls
; StoreC5BEC6AtHLStride2_Bank1E; copies H to wArg1; copies L to wArg2; calls
; DrawPageOfPagesAtArg1_Bank1E; increments wScreenStep; branches on wReturnScreenState; calls
; CopyRectTo20ByteRows_Bank1E (E-0347)
SwapMonstersMenu_ShowParents2_ClampRecordListPageCursor4::
    ld de, GlyphCopyDestList5 + $20d
    ld hl, wWindowTileBuffer + $6b
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_Bank1E
    call ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .check_return_screen_state
    ld a, [wReturnScreenState]
    cp $07
    jr z, .skip
    ld hl, wWindowTileBuffer + $112
    call StoreC5BEC6AtHLStride2_Bank1E
    ld hl, wWindowTileBuffer + $113
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    call DrawPageOfPagesAtArg1_Bank1E

.loop:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_return_screen_state:
    ld a, [wReturnScreenState]
    cp $07
    jr nz, .loop

.skip:
    ld de, SwapMonstersMenu_ShowParents2_ClampRecordListPageCursor4_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $01
    call CopyRectTo20ByteRows_Bank1E
    jr .loop

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
SwapMonstersMenu_ShowParents2_ClampRecordListPageCursor4_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0

; step 16 of SwapMonstersMenu_ShowParents2: calls CopyFromBankWaitVRAM; sets wArg1 to 1; sets wArg2
; to 0; calls DrawRecordListPageMarks; calls StoreBAtWordTableEntry_Bank1E; branches on
; wReturnScreenState; increments wScreenStep; calls StoreBAtWordTableEntry_Bank1E; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ShowParents2_DrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wGridCursorX]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wReturnScreenState]
    cp $07
    jr z, .read_list_cursor
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCellsFrom5 + $4
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; screen state 8: the details of a party record (ListPartyRecordsWithState2ToListEntries; name,
; species, personality, level and status) (E-0302)
SwapMonstersMenu_ShowPartyMemberDetails::
    ld a, [wScreenStep]
    jumptable
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ToSwapMonstersMenu_WriteGlyphListPosAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep
    dw SwapMonstersMenu_ShowPartyMemberDetails_DrawTileRectAtHLFromDE_Bank1E
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E
    dw SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex
    dw SwapMonstersMenu_ShowMonsterDetails_StoreBAtWordTableEntry_Bank1E
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowPartyMemberDetails_ListPartyRecordsWithState2ToListEntries
    dw SwapMonstersMenu_ShowMonsterDetails_ToFillTilesBxCAndStep
    dw SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4
    dw SwapMonstersMenu_ShowMonsterDetails_ShowRecordPersonalityName
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4
    dw SwapMonstersMenu_ShowPartyMemberDetails_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_3
    dw SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address_SetTemp5
    dw SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep
    dw SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor_SetMenuInputResult
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address
    dw SwapMonstersMenu_ShowMonsterDetails_DrawRecordParentNames
    dw SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor_SetMenuInputResult_2

; fills the 32 x 32 BG map from the scroll origin with BGFillTile (tile $C3) through
; FillTileRectWithArg1Tile with wArg7 = 0, then hScrollX = hScrollY = 0 and wScreenStep += 1
; (E-0120; fill, not a tile map: E-0186)
ClearBGMapAtScrollAndResetScroll::
    call BGMapAddressAtScroll_Bank1E
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
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 1 of SwapMonstersMenu_ShowMonsterDetails: calls SwapMonstersMenu_WriteGlyphListPos;
; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_ToSwapMonstersMenu_WriteGlyphListPosAndStep::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_WriteGlyphListPos
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 2 of SwapMonstersMenu_ShowMonsterDetails: increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 3 of SwapMonstersMenu_ShowPartyMemberDetails: calls BGMapAddressAtScroll_Bank1E; sets wArg3
; to $14; sets wArg4 to $12; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; calls
; BGMapAddressAtScroll_Bank1E; calls StepBGMapAddressBackOnScrollWrap; calls
; SwapMonstersMenu_LoadSRAMRecordByte; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowPartyMemberDetails_DrawTileRectAtHLFromDE_Bank1E::
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowPartyMemberDetails_DrawTileRectAtHLFromDE_Bank1E_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0020
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $40
    call SwapMonstersMenu_LoadSRAMRecordByte
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; for the record at WD789 cell 5, with SRAM enabled, runs DrawRecordLevelAndStatusRow_1E, 7332 and
; 7399; wScreenStep += 1 (E-0122)
DrawListEntriesCell5RecordDetails::
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call DrawRecordLevelAndStatusRow_1E
    call DrawListEntriesCell5RecordDetails_StepBGMapAddressBackOnScrollWrap
    call DrawListEntriesCell5RecordDetails_HLToDecimalDigits
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 5 of SwapMonstersMenu_ShowMonsterDetails: branches on wScreenSubStep; calls
; BGMapAddressAtScroll_Bank1E; sets wArg3 to 6; sets wArg4 to 6; sets wArg7 to 0; calls
; DrawTileRectAtHLFromDE_Bank1E; calls GetListEntriesCell5Address; sets rRAMG2 to $0a; sets rRAMB to
; 0; calls LoadSRAMRecordWord; calls LoadMonsterPicture; sets rRAMG2 to 0; then 19 more steps (see
; the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E::
    ld a, [wScreenSubStep]
    and a
    jp nz, .call_get_list_entries_cell5_address
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params_TileRect_2
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a
    ld [rRAMG2], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_get_list_entries_cell5_address:
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a
    jr z, .restore
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.restore:
    pop hl
    xor a
    ld [rRAMG2], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_TileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 6 of SwapMonstersMenu_ShowPartyMemberDetails: sets wMenuInputResult to 0; calls
; UpdateListCursorListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets
; wScreenStep to 4; increments wScreenStep; calls BGMapAddressAtScroll_Bank1E; sets wArg3 to 6; sets
; wArg4 to 6; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; sets wScreenStep to $0e (E-0347)
SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor::
    xor a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    jr z, .set_screen_step_to_04
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .call_bg_map_address_at_scroll_bank1_e
    ret

.set_screen_step_to_04:
    ld a, $04
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params_TileRect_2
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $0e
    ld [wScreenStep], a
    ret

; step 8 of SwapMonstersMenu_ShowMonsterDetails: calls LoadAreaGraphicsForAreaGraphicsIndex; sets
; wBGPaletteUploadRequest to $7f; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_LoadAreaGraphicsForAreaGraphicsIndex::
    farcall LoadAreaGraphicsForAreaGraphicsIndex
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 9 of SwapMonstersMenu_ShowMonsterDetails: calls SwapMonstersMenu_WriteGlyphListPos; calls
; StoreBAtWordTableEntry_Bank1E; branches on wScreenState; calls StoreBAtWordTableEntry_Bank1E;
; branches on wScreenState; calls StoreBAtWordTableEntry_Bank1E; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_StoreBAtWordTableEntry_Bank1E::
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_WriteGlyphListPos
    xor a
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, $01
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, $02
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, [wScreenState]
    cp $08
    jr z, .check_screen_state
    ld a, $03
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ld a, $04
    ld b, $c3
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E

.check_screen_state:
    ld a, [wScreenState]
    cp $0a
    jr z, .check_screen_step
    cp $0b
    jr z, .check_screen_step
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; lists the records (ListPartyRecordsWithState2ToListEntries in state 8, else
; ListRecordsState1NotEggs), loads the family icon of the record at WD789 cell 5 and draws it, then
; wScreenStep += 1 (E-0124)
ListRecordsAndDrawListEntriesCell5Panel::
    ld a, [wScreenState]
    cp $08
    jr nz, .call_list_records_state1_not_eggs
    farcall ListPartyRecordsWithState2ToListEntries
    jr .call_get_list_entries_cell5_address

.call_list_records_state1_not_eggs:
    farcall ListRecordsState1NotEggs

.call_get_list_entries_cell5_address:
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    call CallDrawRecordStatsBoxForArg1InBank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 11 of SwapMonstersMenu_ShowMonsterDetails: calls FillTilesBxC; increments wScreenStep
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails_FillTilesBxC::
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 12 of SwapMonstersMenu_ShowMonsterDetails: calls GetListEntriesCell5Address; sets wArg1;
; calls DrawRecordNameAndSpeciesNameTiles; increments wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawRecordNameAndSpeciesNameTiles::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 13 of SwapMonstersMenu_ShowPartyMemberDetails: calls ListPartyRecordsWithState2ToListEntries;
; calls GetListEntriesCell4Address; calls LoadFamilyIconTileForRecordB_Bank1E; calls
; LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest to $7f; calls
; BGMapAddressAtScroll_Bank1E; calls DrawScreenBufferRect_Bank1E; calls BGMapAddressAtScroll_Bank1E;
; calls DrawScreenBufferRect_Bank1E; calls RestoreSpriteStateFromSavedFieldDrawFlags; sets
; hSpriteHideTile to $70; sets wScreenSubStep to 0; then 5 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowPartyMemberDetails_ListPartyRecordsWithState2ToListEntries::
    farcall ListPartyRecordsWithState2ToListEntries
    call GetListEntriesCell4Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank1E
    call RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
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

; step 14 of SwapMonstersMenu_ShowMonsterDetails: calls FillTilesBxC; increments wScreenStep
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails_ToFillTilesBxCAndStep::
    ld hl, vTiles2 + $200
    ld bc, $0f02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 17 of SwapMonstersMenu_ShowMonsterDetails: calls BGMapAddressAtScroll_Bank1E; sets wArg3 to
; $0c; sets wArg4 to $0f; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; increments
; wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_4_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $0f
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 18 of SwapMonstersMenu_ShowMonsterDetails: calls GetListEntriesCell5Address; sets rRAMG2 to
; $0a; sets rRAMB to 0; calls ShowRecordPersonalityName; calls DrawRecordName0FAtTiles2290; sets
; rRAMG2 to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_ShowRecordPersonalityName::
    call GetListEntriesCell5Address
    ld a, [hl]
    push hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call ShowRecordPersonalityName
    pop hl
    call DrawRecordName0FAtTiles2290
    xor a
    ld [rRAMG2], a

; step 19 of SwapMonstersMenu_ShowMonsterDetails: calls GetListEntriesCell5Address; sets rRAMG2 to
; $0a; sets rRAMB to 0; sets wArg1 to $6d; sets wArg2 to 0; sets wArg3 to $ea; sets wArg4 to $c7;
; calls SwapMonstersMenu_ShowMonsterDetails_LoadFamilyIconTileForWorkBuf; calls
; SwapMonstersMenu_ShowMonsterDetails_LoadRecordThreeBytesToTemp0; sets rRAMG2 to 0 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address::
    call GetListEntriesCell5Address
    push hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld b, a
    ld a, $6d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld a, $ea
    ld [wArg3], a
    ld a, $c7
    ld [wArg4], a
    call SwapMonstersMenu_ShowMonsterDetails_LoadFamilyIconTileForWorkBuf
    pop hl
    call SwapMonstersMenu_ShowMonsterDetails_LoadRecordThreeBytesToTemp0
    xor a
    ld [rRAMG2], a

; step 20 of SwapMonstersMenu_ShowMonsterDetails: calls GetListEntriesCell5Address; sets rRAMG2 to
; $0a; sets rRAMB to 0; calls LoadSRAMRecordWord; sets rRAMG2 to 0; copies hTemp0 to wArg1; copies
; hTemp1 to wArg2; sets wArg3 to 0; sets wArg4 to 0; sets wArg5 to $80; calls
; DecompressGraphicsArg1ToArg4; sets hSpriteHideTile to $f0; then 7 more steps (see the code)
; (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4::
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, $f0
    ldh [hSpriteHideTile], a
    farcall ShowCategory11StringOfListEntriesCell5Record
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4_TileRect
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    ret

; step 21 of SwapMonstersMenu_ShowPartyMemberDetails: calls GetListEntriesCell5Address; sets rRAMG2
; to $0a; sets rRAMB to 0; calls LoadSRAMRecordWord; sets rRAMG2 to 0; copies hTemp0 to wArg1;
; copies hTemp1 to wArg2; sets wArg3 to 0; sets wArg4 to $90; sets wArg5 to $40; sets wArg6 to 0;
; calls DrawMetaSpritePartC0; then 20 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowPartyMemberDetails_GetListEntriesCell5Address::
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    xor a
    ld [wArg6], a
    farcall DrawMetaSpritePartC0
    xor a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    jr z, .clear_sprite_hide_tile
    cp $fe
    jr z, .clear_sprite_hide_tile3
    cp $ff
    jr z, .clear_sprite_hide_tile2
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile3:
    xor a
    ldh [hSpriteHideTile], a
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode_TileRect_2
    ld a, $0c
    ld [wArg3], a
    ld a, $0f
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode_TileRect
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, $04
    ld [wScreenStep], a
    ret

; step 22 of SwapMonstersMenu_ShowMonsterDetails: calls GetListEntriesCell5Address; sets rRAMG2 to
; $0a; sets rRAMB to 0; calls DrawRecordLevelAndStatusRow_1E; sets rRAMG2 to 0; sets wScreenStep to
; $0f (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E::
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call DrawRecordLevelAndStatusRow_1E
    xor a
    ld [rRAMG2], a
    ld a, $0f
    ld [wScreenStep], a
    ret

; step 25 of SwapMonstersMenu_ShowMonsterDetails: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell5Address; sets hTemp5; calls LoadSRAMRecordByte; branches on hTemp0; calls
; FillTilesBxC; sets wTextWindowTileLo to 9; sets wStringCategory to 8; sets wStringIndex to $0e;
; calls ShowString_Bank08; sets wTextWindowRows to 1; then 11 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address_SetTemp5::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ldh [hTemp5], a
    ld c, MON_SKILLS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp $ff
    jr z, .call_fill_tiles_bx_c
    and a
    jr z, .call_fill_tiles_bx_c
    jr .skip

.call_fill_tiles_bx_c:
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $92
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $09
    ld a, $08
    ld [wStringCategory], a
    ld a, $0e
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr .skip2

.skip:
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08
    ld a, $01
    ld [wTextWindowRows], a
    ld a, $09
    ld [wTextWindowWidth], a
    ld a, $04
    ld [wStringCategory], a

.loop:
    push bc
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ldh a, [hTemp5]
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a
    jr z, .call_fill_tiles_from_request
    cp $ff
    jr z, .call_fill_tiles_from_request
    jr .set_string_index

.call_fill_tiles_from_request:
    call FillTilesFromRequest
    jr .restore

.set_string_index:
    ld [wStringIndex], a
    farcall ShowString_Bank08

.restore:
    pop hl
    ld bc, $0090
    add hl, bc
    pop bc
    inc c
    dec b
    jr nz, .loop

.skip2:
    xor a
    ld [rRAMG2], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12

; step 26 of SwapMonstersMenu_ShowMonsterDetails: calls
; ShowSpeciesCategory13StringOfListEntriesCell5Record; sets wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_WriteScreenStep::
    farcall ShowSpeciesCategory13StringOfListEntriesCell5Record
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; step 27 of SwapMonstersMenu_ShowPartyMemberDetails: sets wMenuInputResult to 0; calls
; UpdateListCursorListCursor; returns if wMenuInputResult is 0; branches on wMenuInputResult; sets
; wScreenStep; calls FillTilesBxC; increments wScreenStep; calls CopyFromBankWaitVRAM; calls
; UploadTilesFromData; calls BGMapAddressAtScroll_Bank1E; sets wArg3 to 8; sets wArg4 to 7; then 11
; more steps (see the code) (E-0347)
SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor_SetMenuInputResult::
    xor a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    jr z, .read_screen_step
    cp $fe
    jr z, .call_fill_tiles_bx_c
    cp $ff
    jr z, .skip
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $02
    ld [wScreenStep], a
    ret

.call_fill_tiles_bx_c:
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld hl, vTiles2 + $730
    ld de, Tiles1Plus2E0Tiles_2
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor_TileRect_2
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $6c0
    ld bc, $0201
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2_UpdatePagedListCursor_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    ret

; step 28 of SwapMonstersMenu_ShowMonsterDetails: branches on wScreenSubStep; calls
; BGMapAddressAtScroll_Bank1E; sets wArg3 to $0c; sets wArg4 to 3; sets wArg7 to 0; calls
; DrawTileRectAtHLFromDE_Bank1E; calls BGMapAddressAtScroll_Bank1E; sets wArg3 to 8; sets wArg4 to
; 7; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; increments wScreenSubStep; then 3 more
; steps (see the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5::
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_swap_monsters_menu_write_glyph_list_pos
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_SetArg3_5_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DecompressGraphicsArg1ToArg4_TileRect
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_swap_monsters_menu_write_glyph_list_pos:
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_WriteGlyphListPos
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 29 of SwapMonstersMenu_ShowMonsterDetails: sets rRAMG2 to $0a; sets rRAMB to 0; calls
; GetListEntriesCell5Address; calls DrawRecordLevelAndStatusRow_1E; sets rRAMG2 to 0; calls
; FillTilesBxC; copies B to wArg1; calls DrawRecordNameAndSpeciesNameTiles; calls
; CopyFromBankWaitVRAM; sets wTextWindowTileLo to $12; sets wScreenStep to $11 (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawRecordLevelAndStatusRow_1E_GetListEntriesCell5Address::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    push bc
    call DrawRecordLevelAndStatusRow_1E
    xor a
    ld [rRAMG2], a
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    pop bc
    ld a, b
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld de, Tiles1Plus4A0Tiles
    ld hl, vTiles2 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, $11
    ld [wScreenStep], a
    ret

; step 30 of SwapMonstersMenu_ShowMonsterDetails: calls BGMapAddressAtScroll_Bank1E; sets wArg3 to
; $0c; sets wArg4 to $12; sets wArg7 to 0; calls DrawTileRectAtHLFromDE_Bank1E; calls
; GetListEntriesCell5Address; copies L to wArg1; copies H to wArg2; calls
; LoadPartySpeciesSpriteGraphics (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawTileRectAtHLFromDE_Bank1E_GetListEntriesCell5Address_TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    call GetListEntriesCell5Address
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    push hl
    farcall LoadPartySpeciesSpriteGraphics
    pop hl

; step 31 of SwapMonstersMenu_ShowMonsterDetails: calls DrawRecordParentNames; calls
; DrawRecordFamilyEntries; sets hSpriteHideTile to $f0; sets wScreenStep (E-0347)
SwapMonstersMenu_ShowMonsterDetails_DrawRecordParentNames::
    ld b, [hl]
    call DrawRecordParentNames
    call DrawRecordFamilyEntries
    ld a, $f0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; step 32 of SwapMonstersMenu_ShowPartyMemberDetails: sets wMenuInputResult to 0; calls
; UpdateListCursorListCursor; branches on wMenuInputResult; calls GetListEntriesCell5Address; copies
; L to wArg1; copies H to wArg2; calls DrawPartySpeciesSprites; sets hSpriteHideTile to 0;
; decrements wScreenStep; calls FillTilesBxC; sets wTextWindowTileLo to $12; sets hSpriteHideTile to
; 0; then 3 more steps (see the code) (E-0347)
SwapMonstersMenu_ShowPartyMemberDetails_UpdateListCursorListCursor_SetMenuInputResult_2::
    xor a
    ld [wMenuInputResult], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    jr z, .call_get_list_entries_cell5_address
    cp $fd
    jr z, .clear_sprite_hide_tile
    cp $fe
    jr z, .clear_sprite_hide_tile2
    cp $ff
    jr z, .clear_sprite_hide_tile3

.call_get_list_entries_cell5_address:
    call GetListEntriesCell5Address
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall DrawPartySpeciesSprites
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld hl, vTiles2 + $200
    ld bc, $0805
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile3:
    xor a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; draws a 6 x 6 tile rectangle from $651B at BGMapAddressAtScroll_Bank1E + $41
; (DrawTileRectAtHLFromDE_Bank1E, attributes cleared) (E-0118) (E-0344: the address in its name
; dropped or read as the label there; was DrawRect6x6FromAtScroll41)
DrawRect6x6FromAtScroll41::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    ld de, LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params_TileRect_2
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ret

; wArg5/wArg6 = HL (destination), wArg1/wArg2 = DE (source), then far-calls
; DrawTileRectFromArg1Params (width and rows already in wArg3/wArg4) (E-0093) (the same 23 bytes
; appear in 4 banks)
DrawTileRectAtHLFromDE_Bank1E::
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawTileRectFromArg1Params
    ret

; A = [HL] (a record): shows string PersonalityIndexOfRecord of category 7 (personality names) in a
; window at $9200 with size $0109 (ShowString_Bank08), then restores the default window ($8800,
; $1202) (E-0120)
ShowRecordPersonalityName::
    ld a, [hl]
    call PersonalityIndexOfRecord
    ld c, a
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $92
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $09
    farcall ShowString_Bank08
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

; for record B draws the names of its parents (fields from $6ED2 or $6EDA by bit 4 of field $0D), or
; '???' when unknown (E-0131)
; code: sets rRAMG2 to $0a; sets rRAMB to 0; calls LoadSRAMRecordByte; branches on hTemp0 & $10;
; calls LoadSRAMRecordWord; branches on hTemp1; sets wNameGlyphBuf to $98; calls
; CopyGlyphTilesToVRAM; calls CopyRecordNameToNameGlyphBuf; calls CopyGlyphTilesToVRAM; sets wArg1
; to $92; sets wArg2 to $50; then 17 more steps (see the code) (E-0347)
DrawRecordParentNames::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $10
    and a
    jr nz, .skip
    ld de, DrawRecordParentNames_Data1
    jr .restore

.skip:
    ld de, DrawRecordParentNames_Data2

.restore:
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .next
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $f0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    ld a, $03
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip3

.next:
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    push bc
    ld a, $92
    ld [wArg1], a
    ld a, $50
    ld [wArg2], a
    ld a, [de]
    inc de
    push de
    ld [wArg3], a
    call DrawMonsterNameOfRecordField
    pop de
    pop bc

.skip3:
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld de, vTiles2 + $2f0
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .next2
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $f0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    ld a, $03
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    jr .skip5

.next2:
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    pop bc
    push bc
    ld a, $93
    ld [wArg1], a
    ld a, $90
    ld [wArg2], a
    ld a, [de]
    inc de
    push de
    ld [wArg3], a
    call DrawMonsterNameOfRecordField
    pop de
    pop bc

.skip5:
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    call CopyRecordNameToNameGlyphBuf
    ld de, vTiles2 + $430
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    call CopyGlyphTilesToVRAM
    pop bc
    xor a
    ld [rRAMG2], a
    ret

; reads word field wArg3 of record B, copies that monster name (category 2 of the bank-08 string
; database) to wNameGlyphBuf and draws its glyphs at the address in wArg1/2 (E-0121)
DrawMonsterNameOfRecordField::
    push bc
    ld a, [wArg3]
    ld c, a
    ld a, b
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld bc, $0004
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    call CopyGlyphTilesToVRAM
    pop bc
    ret

; data read by DrawRecordParentNames (8 bytes) (E-0347)
DrawRecordParentNames_Data1::
    db $1a, $8e, $1a, $1e, $1c, $99, $1c, $29

DrawRecordParentNames_Data2::
    db $1c, $99, $1c, $29, $1a, $8e, $1a, $1e

; clears five tiles at vTiles2 + $290 (copying the tile at $2940), then copies the name at record
; [HL] field $0F (CopyRecordNameToNameGlyphBuf) and draws it there (E-0120)
DrawRecordName0FAtTiles2290::
    push hl
    ld hl, $2940
    ld de, vTiles2 + $290
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank1E
    pop hl
    ld a, [hl]
    ld c, MON_MASTER_NAME
    call CopyRecordNameToNameGlyphBuf
    ld de, vTiles2 + $290
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    call CopyGlyphTilesToVRAM
    ret

; called from SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address: calls
; GetListEntriesCell5Address; calls LoadRecordThreeBytesToTemp0; copies hTemp0 to wDigits; calls
; Number24ToPackedBCD; calls UnpackBCDToDigitsArg1_Bank1E; calls BGMapAddressAtScroll_Bank1E; calls
; StepBGMapAddressBackOnScrollWrap; calls DrawSevenDigitsFromArg1_Bank1E; calls LoadSRAMRecordWord;
; branches on hTemp0; calls LoadSRAMRecordWord; copies hTemp0 to wSpeciesIdLo; then 19 more steps
; (see the code) (E-0347)
SwapMonstersMenu_ShowMonsterDetails_LoadRecordThreeBytesToTemp0::
    call GetListEntriesCell5Address
    push hl
    ld a, [hl]
    ld c, MON_EXP
    call LoadRecordThreeBytesToTemp0
    ldh a, [hTemp0]
    ld [wDigits], a
    ldh a, [hTemp1]
    ld [wDigits + $1], a
    ldh a, [hTemp2]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1_Bank1E
    call BGMapAddressAtScroll_Bank1E
    ld de, $018c
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_Bank1E
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordWord
    ldh a, [hTemp1]
    ld b, a
    ldh a, [hTemp0]
    cp b
    jp nc, .set_arg1_to_E3
    ldh a, [hTemp0]
    ld b, a
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wSpeciesIdLo], a
    ldh a, [hTemp1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    pop bc
    ld a, b
    ldh [hTemp1], a
    farcall LoadExpTableEntryToTemp2
    ld de, hTemp2
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    pop hl
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, MON_EXP
    call LoadRecordThreeBytesToTemp0
    pop de
    pop bc
    ldh a, [hTemp0]
    ld l, a
    ld a, c
    sub l
    ld c, a
    ldh a, [hTemp1]
    ld l, a
    ld a, b
    sbc l
    ld b, a
    ldh a, [hTemp2]
    ld l, a
    ld a, e
    sbc l
    ld e, a
    ld a, c
    ld [wDigits], a
    ld a, b
    ld [wDigits + $1], a
    ld a, e
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1_Bank1E

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    ld de, $020c
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_Bank1E
    pop hl
    ret

.set_arg1_to_E3:
    ld a, $e3
    ld [wArg1], a
    ld [wArg2], a
    ld [wArg3], a
    ld [wArg4], a
    ld [wArg5], a
    ld [wArg6], a
    xor a
    ld [wArg7], a
    jr .call_bg_map_address_at_scroll_bank1_e

; called from RunLinkSession8Case03Steps_GetListEntriesCell4Address_BankF0: calls
; DrawRecordParentNames; calls DrawRecordFamilyEntries (E-0347)
RunLinkSession8Case03Steps_DrawRecordParentNames::
    ld b, e
    call DrawRecordParentNames
    call DrawRecordFamilyEntries
    ret

; for record B draws the species names and marks named by the field lists $70D7 or $70DD (by bit 4
; of field $0D), or a blank tile for missing entries (E-0130) (E-0344: the address in its name
; dropped or read as the label there; was DrawRecordFamilyEntries)
DrawRecordFamilyEntries::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $10
    and a
    jr nz, .skip
    ld de, DrawRecordFamilyEntries_Data1
    jr .restore

.skip:
    ld de, DrawRecordFamilyEntries_Data2

.restore:
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .next
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6c0
    call CopyTileBytesToVRAM_Bank1E
    pop de
    inc de
    inc de
    inc de
    jr .restore2

.next:
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    xor a
    ld [wArg2], a
    ld a, $6a
    ld [wArg3], a
    ld a, $6c
    ld [wArg4], a
    call LoadRecordWordFieldAndContinue
    pop de
    pop bc
    push bc
    call PickNameBufferForFirstByte
    inc de
    inc de
    push de
    call BGMapAddressAtScroll_Bank1E
    ld de, $006e
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, b
    ld [hl], a
    ei
    pop de

.restore2:
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .next2
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6d0
    call CopyTileBytesToVRAM_Bank1E
    pop de
    inc de
    inc de
    inc de
    jr .restore3

.next2:
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    ld a, $01
    ld [wArg2], a
    ld a, $8a
    ld [wArg3], a
    ld a, $6d
    ld [wArg4], a
    call LoadRecordWordFieldAndContinue
    pop de
    pop bc
    push bc
    call PickNameBufferForFirstByte
    push de
    call BGMapAddressAtScroll_Bank1E
    ld de, $018e
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, b
    ld [hl], a
    ei
    pop de

.restore3:
    pop bc
    xor a
    ld [rRAMG2], a
    ret

; BC = wNameBufPlaceholder when the byte at DE is $98 (the '???' placeholder), else wNameBufAlt
; (E-0122)
PickNameBufferForFirstByte::
    ld a, [de]
    cp $98
    jr z, .done
    ld bc, wNameBufAlt
    jr .return

.done:
    ld bc, wNameBufPlaceholder

.return:
    ret

; data read by DrawRecordFamilyEntries (6 bytes) (E-0347)
DrawRecordFamilyEntries_Data1::
    db $1a, $98, $1a, $1c, $a3, $1c

DrawRecordFamilyEntries_Data2::
    db $1c, $a3, $1c, $1a, $98, $1a

; far-calls LoadRecordWordFieldArg5AndShowIcon for record B and continues at
; SwapMonstersMenu_ShowMonsterDetails_LoadFamilyIconTileForWorkBuf_ReadArg1 (E-0126) (E-0344: the
; address in its name dropped or read as the label there; was LoadRecordWordFieldAndContinue)
LoadRecordWordFieldAndContinue::
    push bc
    ld c, b
    farcall LoadRecordWordFieldArg5AndShowIcon
    pop bc
    jp SwapMonstersMenu_ShowMonsterDetails_LoadFamilyIconTileForWorkBuf_ReadArg1

; called from SwapMonstersMenu_ShowMonsterDetails_GetListEntriesCell5Address: calls
; LoadSRAMRecordByte; copies hTemp0 & $0f to wWorkBuf; calls LoadFamilyIconTileForWorkBuf (E-0347)
SwapMonstersMenu_ShowMonsterDetails_LoadFamilyIconTileForWorkBuf::
    push bc
    ld c, MON_FAMILY
    ld a, b
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc

; Calls LoadSRAMRecordByte; branches on hTemp0; calls BGMapAddressAtScroll_Bank1E; calls
; StepBGMapAddressBackOnScrollWrap; branches on rSTAT; calls HLToDecimalDigits; calls
; BlankLeadingZeroDigits_F; branches on rSTAT (E-0347)
SwapMonstersMenu_ShowMonsterDetails_LoadFamilyIconTileForWorkBuf_ReadArg1::
    ld a, [wArg1]
    ld c, a
    ld a, b
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_e
    ret

.call_bg_map_address_at_scroll_bank1_e:
    push af
    call BGMapAddressAtScroll_Bank1E
    ld a, [wArg2]
    ld d, a
    ld a, [wArg3]
    ld e, a
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, $1e
    ld [hli], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    cp $e3
    jr z, .skip
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei

.skip:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    ei
    ret

; wListPages = the number of 5-entry pages of wListCount records; clamps the page wListPageIndex and
; the cursor wListCursor to the last page (wListLastRow) (E-0127)
ClampRecordListPageCursor5::
    ld a, [wListCount]
    ld l, a
    ld h, $00
    ld a, $05
    call DivideHLByA
    push af
    and a
    jr z, .set_list_pages
    inc l

.set_list_pages:
    ld a, l
    ld [wListPages], a
    ld a, [wListPageIndex]
    inc a
    cp l
    jr c, .set_list_last_row_to_04
    pop af
    push af
    and a
    jr nz, .set_list_last_row
    ld a, [wListPageIndex]
    inc a
    cp l
    jr z, .set_list_last_row_to_04
    ld a, [wListPageIndex]
    dec a
    ld [wListPageIndex], a
    jr .set_list_last_row_to_04

.set_list_last_row:
    pop af
    dec a
    ld [wListLastRow], a
    ld b, a
    ld a, [wListCursor]
    cp b
    jr c, .return
    jr z, .return
    push bc
    push hl
    call EraseCursorAtForListCursor
    pop hl
    pop bc
    ld a, b
    ld [wListCursor], a
    jr .return

.set_list_last_row_to_04:
    pop af
    ld a, $04
    ld [wListLastRow], a

.return:
    ret

; writes tile $C3 at BGMapAddressAtScroll_Bank1E + the offset from the word table $71D7 + 2 *
; wListCursor (E-0120) (E-0344: the address in its name dropped or read as the label there; was
; EraseCursorAtForListCursor)
EraseCursorAtForListCursor::
    ld b, $c3
    ld a, [wListCursor]
    add a
    ld hl, EraseCursorAtForListCursor_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by EraseCursorAtForListCursor (10 bytes) (E-0347)
EraseCursorAtForListCursor_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; wListPages = the number of 4-entry pages of wListCount records; clamps the page wListPageIndex and
; the cursor wListCursor to the last page (wListLastRow) (E-0127)
ClampRecordListPageCursor4::
    ld a, [wListCount]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a
    jr z, .set_list_pages
    inc l

.set_list_pages:
    ld a, l
    ld [wListPages], a
    ld a, [wListPageIndex]
    inc a
    cp l
    jr c, .set_list_last_row_to_03
    pop af
    push af
    and a
    jr nz, .set_list_last_row
    ld a, [wListPageIndex]
    inc a
    cp l
    jr z, .set_list_last_row_to_03
    ld a, [wListPageIndex]
    dec a
    ld [wListPageIndex], a
    jr .set_list_last_row_to_03

.set_list_last_row:
    pop af
    dec a
    ld [wListLastRow], a
    ld b, a
    ld a, [wListCursor]
    cp b
    jr c, .return
    jr z, .return
    push bc
    push hl
    call EraseCursorAtForListCursor_2
    pop hl
    pop bc
    ld a, b
    ld [wListCursor], a
    jr .return

.set_list_last_row_to_03:
    pop af
    ld a, $03
    ld [wListLastRow], a

.return:
    ret

; writes tile $C3 at BGMapAddressAtScroll_Bank1E + the offset from the word table $7255 + 2 *
; wListCursor (E-0120) (E-0344: the address in its name dropped or read as the label there; was
; EraseCursorAtForListCursor_2)
EraseCursorAtForListCursor_2::
    ld b, $c3
    ld a, [wListCursor]
    add a
    ld hl, EraseCursorAtForListCursor_2_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by EraseCursorAtForListCursor (8 bytes) (E-0347)
EraseCursorAtForListCursor_2_Data::
    db $28, $00, $68, $00, $a8, $00, $e8, $00

; writes the record's level (field $56, marked $6F at the cap in field $57) and its status marks
; into the BG map at scroll + $29 (E-0130)
DrawRecordLevelAndStatusRow_1E::
    push hl
    ld a, [hl]
    ld c, MON_LEVEL
    ld b, $02
    call LoadSRAMRecordWord
    call BGMapAddressAtScroll_Bank1E
    ld de, $0029
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ldh a, [hTemp1]
    ld b, a
    ldh a, [hTemp0]
    cp b
    jr c, .call_wait_for_vram_access
    di
    call WaitForVRAMAccess
    ld a, $6f
    ld [hl], a
    ei
    jr .call_wait_for_vram_access2

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, $c3
    ld [hl], a
    ei

.call_wait_for_vram_access2:
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $ea
    ld [hli], a
    ld a, $ed
    ld [hli], a
    ei
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    add $e0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld a, [wDigits + $2]
    add $e0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop de
    ld l, e
    ld h, d
    call WriteThreeC3TilesAtHL_Bank1E
    ldh a, [hTemp0]
    push af
    bit 0, a
    call nz, WriteTileC0AtHL_Bank1E
    pop af
    inc hl
    push af
    bit 2, a
    call nz, WriteTileC1AtHL_Bank1E
    pop af
    inc hl
    bit 7, a
    call nz, WriteTileC2AtHL_Bank1E
    inc hl
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, MON_SEX
    ld b, $01
    call LoadSRAMRecordByte
    pop de
    ld l, e
    ld h, d
    ldh a, [hTemp0]
    and $01
    add $cc
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    pop hl
    ret

; writes tile $C3 to the 3 VRAM bytes from HL (WaitForVRAMAccess, interrupts off per byte); HL kept;
; clobbers C, E (E-0067) (the same 17 bytes appear in 2 banks)
WriteThreeC3TilesAtHL_Bank1E::
    push hl
    ld e, $c3
    ld c, $03

.loop:
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, .loop
    pop hl
    ret

; writes tile $C0 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC0AtHL_Bank1E::
    di
    call WaitForVRAMAccess
    ld a, $c0
    ld [hl], a
    ei
    ret

; writes tile $C1 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC1AtHL_Bank1E::
    di
    call WaitForVRAMAccess
    ld a, $c1
    ld [hl], a
    ei
    ret

; writes tile $C2 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC2AtHL_Bank1E::
    di
    call WaitForVRAMAccess
    ld a, $c2
    ld [hl], a
    ei
    ret

; called from DrawListEntriesCell5RecordDetails: calls BGMapAddressAtScroll_Bank1E; calls
; StepBGMapAddressBackOnScrollWrap; calls LoadSRAMRecordWord; calls HLToDecimalDigits; calls
; BlankLeadingZeroDigits_F; branches on C (E-0347)
DrawListEntriesCell5RecordDetails_StepBGMapAddressBackOnScrollWrap::
    push hl
    call BGMapAddressAtScroll_Bank1E
    ld de, $0070
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld e, l
    ld d, h
    pop hl
    ld c, $00

.loop:
    push bc
    push hl
    push de
    ld a, c
    ld de, DrawListEntriesCell5RecordDetails_StepBGMapAddressBackOnScrollWrap_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop de
    ld l, e
    ld h, d
    di
    call WaitForVRAMAccess
    ld a, [wDigits]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    ei
    ld a, $40
    add e
    ld e, a
    jr nc, .restore
    inc d

.restore:
    pop hl
    pop bc
    inc c
    ld a, c
    cp $05
    jr c, .loop
    ret

; data read by DrawListEntriesCell5RecordDetails (5 bytes) (E-0347)
DrawListEntriesCell5RecordDetails_StepBGMapAddressBackOnScrollWrap_Data::
    db $63, $65, $67, $69, $6b

; called from DrawListEntriesCell5RecordDetails: calls LoadSRAMRecordWord; calls HLToDecimalDigits;
; calls BlankLeadingZeroDigits_F; calls BGMapAddressAtScroll_Bank1E; calls
; StepBGMapAddressBackOnScrollWrap; branches on C (E-0347)
DrawListEntriesCell5RecordDetails_HLToDecimalDigits::
    ld c, $00

.loop:
    push hl
    ld a, [hl]
    ld b, a
    push bc
    ld a, c
    ld hl, DrawListEntriesCell5RecordDetails_HLToDecimalDigits_Data1
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, b
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F
    pop bc
    ld a, c
    add a
    ld hl, DrawListEntriesCell5RecordDetails_HLToDecimalDigits_Data2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ei
    pop hl
    inc c
    ld a, c
    cp $04
    jr c, .loop
    ret

; data read by DrawListEntriesCell5RecordDetails_HLToDecimalDigits (4 bytes) (E-0347)
DrawListEntriesCell5RecordDetails_HLToDecimalDigits_Data1::
    db $5b, $5d, $5f, $61

DrawListEntriesCell5RecordDetails_HLToDecimalDigits_Data2::
    db $cc, $01, $d0, $01, $0c, $02, $10, $02

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL (E-0122)
EraseCEntriesOfWordTable_Bank1E::
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $c3
    push hl
    call StoreBAtWordTableEntry_Bank1E
    pop hl
    pop bc
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0351)
StoreBAtWordTableEntry_Bank1E::
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank1E::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank1E
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks) (E-0351)
CopyLow3BitsToWRAMBank2_Bank1E::
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

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; (E-0351)
CopyTileBytesToVRAM_Bank1E::
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

; Calls CopyFromBankWaitVRAM; sets wGlyphListPos to 0 (E-0347)
SwapMonstersMenu_WriteGlyphListPos::
    ld b, $00

.skip:
    push bc
    push hl
    push de
    ld a, b
    add a
    add_a_to_hl
    ld a, [hli]
    cp $ff
    jr z, .restore
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop de
    push de
    push hl
    ld l, e
    ld h, d
    ld a, b
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    pop bc
    inc b
    jr .skip

.restore:
    pop de
    pop hl
    pop bc
    xor a
    ld [wGlyphListPos], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0351)
CopyRectTo20ByteRows_Bank1E::
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
; kept. wTextCursorLo/wTextCursorHi = HL + $1C1 only when HL = $9800 (E-0062)
DrawScreenBufferRect_Bank1E::
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
    cp $00
    jr nz, .restore
    ld a, h
    cp $98
    jr nz, .restore
    ld a, l
    add $c1
    ld [wTextCursorLo], a
    ld a, h
    adc $01
    ld [wTextCursorHi], a

.restore:
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0351)
BGMapAddressAtScroll_Bank1E::
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

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll_Bank1E + DE, two entries apart
; (WaitForVRAMAccess, interrupts off), through StepBGMapAddressBackOnScrollWrap (E-0120)
DrawC5BEC6AtScrollOffsetDE_Bank1E::
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
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
StoreC5BEC6AtHLStride2_Bank1E::
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

; HL = BGMapAddressAtScroll_Bank1E + the offset in wArg1 (high) / wArg2 (low): writes tile $E0 +
; wListPageIndex + 1 there and tile $E0 + wListPages two entries later, each through
; StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (current page and page count) (E-0106)
DrawPageOfPagesAtScrollOffset::
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    push de
    call BGMapAddressAtScroll_Bank1E
    pop de
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wListPageIndex]
    inc a
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    add $e0
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    ld a, [wListPages]
    ld b, a
    pop hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    add $e0
    ld [hl], a
    ei
    ret

; HL = the address in wArg1 (high) / wArg2 (low): writes tile $E0 + wListPageIndex + 1 there and
; tile $E0 + wListPages two bytes later (current page and page count, 1-based display) (E-0093) (the
; same 25 bytes appear in 2 banks)
DrawPageOfPagesAtArg1_Bank1E::
    ld a, [wArg1]
    ld h, a
    ld a, [wArg2]
    ld l, a
    ld a, [wListPageIndex]
    inc a
    add $e0
    ld [hli], a
    inc hl
    ld a, [wListPages]
    ld b, a
    ld a, b
    add $e0
    ld [hl], a
    ret

; when wDigits is 0 it becomes $E3, and then when wDigits + $1 is 0 too it becomes $E3 (the same
; effect as the bank-$15 copy, coded through HL): leading zeros become the blank tile once $E0 is
; added (E-0093)
BlankLeadingZeroDigits_F::
    ld hl, wDigits
    ld a, [hl]
    and a
    jr nz, .return
    add $e3
    ld [hli], a
    ld a, [hl]
    and a
    jr nz, .return
    add $e3
    ld [hl], a

.return:
    ret

; wWorkBuf = field $0D of SRAM record B & $0F (its family), wWorkBuf + $1 = $C7, then
; LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForRecordB_Bank1E::
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

; far-calls DrawRecordStatsBoxForArg1 (E-0122) (E-0344: the address in its name dropped or read as
; the label there; was CallDrawRecordStatsBoxForArg1InBank1D)
CallDrawRecordStatsBoxForArg1InBank1D::
    farcall DrawRecordStatsBoxForArg1
    ret

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with
; CGB attributes (E-0127)
CopyScreenBufferRectWithAttrs_1E::
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
    call CopyBytesDEToHL_Bank1E
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
    call CopyLow3BitsToWRAMBank2_Bank1E
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
    jr nz, CopyScreenBufferRectWithAttrs_1E
    ret

; Sets rRAMG2 to $0a; sets rRAMB to 0; calls LoadSRAMRecordByte; sets rRAMG2 to 0; branches on
; hTemp0; branches on rSTAT; branches on wPartyCount (E-0347)
SwapMonstersMenu_LoadSRAMRecordByte::
    ld b, $00

.loop:
    push bc
    push hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp $02
    jr nz, .restore
    pop hl
    pop bc
    push bc
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, b
    add $e1
    ld [hl], a
    ei
    ld a, c
    add_a_to_hl
    push hl

.restore:
    pop hl
    pop bc
    inc b
    ld a, [wPartyCount]
    cp b
    jr nz, .loop
    ret

; the same 57 bytes as UnpackBCDToDigitsArg1 (UnpackBCDToDigitsArg1) (E-0106)
UnpackBCDToDigitsArg1_Bank1E::
    ld de, hTemp3
    ld hl, wArg1
    ld a, [de]
    ld [hli], a
    dec de
    ld a, [de]
    and $f0
    swap a
    ld [hli], a
    ld a, [de]
    and $0f
    ld [hli], a
    dec de
    ld a, [de]
    and $f0
    swap a
    ld [hli], a
    ld a, [de]
    and $0f
    ld [hli], a
    dec de
    ld a, [de]
    and $f0
    swap a
    ld [hli], a
    ld a, [de]
    and $0f
    ld [hl], a
    ld c, $06
    ld hl, wArg1

.loop:
    ld a, [hl]
    and a
    jr nz, .return
    add $e3
    ld [hli], a
    dec c
    jr nz, .loop

.return:
    ret

; HL = VRAM address: writes the 7 bytes at wArg1 as tiles $E0 + digit to HL onward
; (WaitForVRAMAccess, interrupts off per byte) (E-0067) (the same 19 bytes appear in 2 banks)
DrawSevenDigitsFromArg1_Bank1E::
    ld de, wArg1
    ld c, $07

.loop:
    di
    call WaitForVRAMAccess
    ld a, [de]
    add $e0
    ld [hli], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; A = record, C = field offset (SRAMRecordAddress), B = count: copies B bytes from hTemp0 onward
; into the SRAM record (SRAM must be enabled); DE and HL kept (E-0074) (E-0335: the swap menu's Drop
; off and Pick up write MON_STATE through it)
StoreTemp0BytesToSRAMRecord::
    push hl
    push de
    call SRAMRecordAddress
    ld de, hTemp0

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop de
    pop hl
    ret

; far-calls SetArg5ToListEntriesCell5, then HL = wArg5 (high) / wArg6 (low) (E-0075)
GetListEntriesCell5Address::
    farcall SetArg5ToListEntriesCell5
    jr GetListEntriesCell4Address_ReadArg5

; far-calls SetArg5ToListEntriesCell4, then HL = wArg5 (high) / wArg6 (low) (E-0075)
GetListEntriesCell4Address::
    farcall SetArg5ToListEntriesCell4

; Changes HL and A (E-0347)
GetListEntriesCell4Address_ReadArg5::
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; Calls BGMapAddressAtScroll_Bank1E; calls StepBGMapAddressBackOnScrollWrap (E-0347)
SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0020
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $05

.loop:
    di
    call WaitForVRAMAccess
    ld a, $b6
    ld [hl], a
    ei
    ld a, $40
    add_a_to_hl
    dec c
    jr nz, .loop
    ld a, $b6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $a0], a
    ld [wWindowTileBuffer + $c8], a
    ld [wWindowTileBuffer + $f0], a
    ld [wWindowTileBuffer + $118], a
    ret

; wListPageIndex = wListCursor / 4 and wListCursor = wListCursor mod 4 (DivideHLByA) (E-0067) (the
; same 19 bytes appear in 2 banks)
SplitListCursorBy4_Bank1E::
    ld a, [wListCursor]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    ld [wListCursor], a
    ld a, l
    ld [wListPageIndex], a
    ret

; wSavedSpriteClipMode = hSpriteWindowClipMode, then hSpriteWindowClipMode = hSpriteHideTile = 0;
; wSavedFieldDrawFlags = hFieldDrawFlags, wSavedSpriteSlotCount = wSpriteSlotCount; then
; hFieldDrawFlags = $FF and wSpriteSlotCount = 0 (E-0078) (the same 30 bytes appear in 2 banks)
SaveAndHideSpriteState_Bank1E::
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    xor a
    ldh [hSpriteWindowClipMode], a
    ldh [hSpriteHideTile], a
    ldh a, [hFieldDrawFlags]
    ld [wSavedFieldDrawFlags], a
    ld a, [wSpriteSlotCount]
    ld [wSavedSpriteSlotCount], a
    ld a, $ff
    ldh [hFieldDrawFlags], a
    xor a
    ld [wSpriteSlotCount], a
    ret

; hSpriteWindowClipMode = wSavedSpriteClipMode, hSpriteHideTile = $80, hFieldDrawFlags =
; wSavedFieldDrawFlags, wSpriteSlotCount = wSavedSpriteSlotCount: puts back the values
; SaveAndHideSpriteState_Bank1E stored (hSpriteHideTile is set to $80 rather than restored) (E-0078)
RestoreSpriteStateFromSavedFieldDrawFlags::
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    ld [wSpriteSlotCount], a
    ret

; stores tile $C3 at the addresses in entries 0 and 1 of the table at $788A
; (StoreBAtWordTableEntry_Bank1E) (E-0118) (E-0344: the address in its name dropped or read as the
; label there; was BlankTwoTableEntriesSwapMenuCursorCellsFrom5)
BlankTwoTableEntriesSwapMenuCursorCellsFrom5::
    xor a
    ld b, $c3
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    ld a, $01
    ld b, $c3
    ld hl, SwapMenuCursorCellsFrom5
    call StoreBAtWordTableEntry_Bank1E
    ret

; passed in HL, with GlyphCopySrcList0 in DE, to SwapMonstersMenu_WriteGlyphListPos, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 32 VRAM tile addresses, then $FFFF
GlyphCopyDestList0::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0 ; entry 0
    dw vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $2f0, vTiles1 + $6e0, vTiles1 + $6f0, vTiles1 + $700, vTiles1 + $710
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7a0, vTiles1 + $7b0, vTiles1 + $7c0, vTiles1 + $7d0, vTiles1 + $7e0, vTiles1 + $7f0, vTiles1 + $6b0, vTiles2 + $760
    dw rIE

; the source list paired with GlyphCopyDestList0; its own $FFFF is not read (E-0200, C1)
; record: 32 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList0::
    dw $41c0, $42d0, $4330, $4340, $42a0, $40e0, $4270, $42f0 ; entry 0
    dw $4390, $40d0, $42c0, $4360, $4300, $4250, $40f0, $43c0
    dw $4380, $4180, $41a0, $4120, $4170, $41a0, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4a40
    dw $ffff

; passed in HL, with GlyphCopySrcList1 in DE, to SwapMonstersMenu_WriteGlyphListPos, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 9 VRAM tile addresses, then $FFFF
GlyphCopyDestList1::
    dw vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0, vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0 ; entry 0
    dw vTiles1 + $2f0, rIE

; the source list paired with GlyphCopyDestList1; its own $FFFF is not read (E-0200, C1)
; record: 9 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList1::
    dw $4340, $42a0, $40e0, $4270, $42f0, $4390, $40d0, $42c0 ; entry 0
    dw $4360, $ffff

; passed in HL, with GlyphCopySrcList2 in DE, to SwapMonstersMenu_WriteGlyphListPos, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 10 VRAM tile addresses, then $FFFF
GlyphCopyDestList2::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740 ; entry 0
    dw vTiles1 + $4e0, vTiles1 + $4f0, rIE

; the source list paired with GlyphCopyDestList2; its own $FFFF is not read (E-0200, C1)
; record: 10 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList2::
    dw $41c0, $42d0, $4330, $40f0, $43c0, $4380, $4180, $41a0 ; entry 0
    dw $4230, $4290, $ffff

; passed in HL, with GlyphCopySrcList3 in DE, to SwapMonstersMenu_WriteGlyphListPos, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 6 VRAM tile addresses, then $FFFF
GlyphCopyDestList3::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, rIE ; entry 0

; the source list paired with GlyphCopyDestList3; its own $FFFF is not read (E-0200, C1)
; record: 6 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList3::
    dw $4130, $4320, $42a0, $4330, $4190, $4150, $ffff ; entry 0

; StoreBAtWordTableEntry_Bank1E writes a tile at entry wListCursor of $7880 (cursor blanking);
; entries from 5 on are SwapMenuCursorCellsFrom5, the table at $788A; E-0345: were
; SwapMenuCursorCells/788A (E-0200, C1)
; record: screen buffer address
SwapMenuCursorCells::
    dw wWindowTileBuffer + $79 ; id 0
    dw wWindowTileBuffer + $a1 ; id 1
    dw wWindowTileBuffer + $c9 ; id 2
    dw wWindowTileBuffer + $f1 ; id 3
    dw wWindowTileBuffer + $119 ; id 4

; BlankTwoTableEntriesSwapMenuCursorCellsFrom5 stores tile $C3 at entries 0 and 1 through
; StoreBAtWordTableEntry_Bank1E; 7 words end at GlyphCopyDestList4 (E-0200, C1)
SwapMenuCursorCellsFrom5::
    dw wWindowTileBuffer + $120 ; id 0
    dw wWindowTileBuffer + $148 ; id 1
    dw wWindowTileBuffer + $80 ; id 2
    dw wWindowTileBuffer + $a8 ; id 3
    dw wWindowTileBuffer + $d0 ; id 4
    dw wWindowTileBuffer + $f8 ; id 5
    dw wWindowTileBuffer + $120 ; id 6

; passed in HL, with GlyphCopySrcList4 in DE, to SwapMonstersMenu_WriteGlyphListPos, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 32 VRAM tile addresses, then $FFFF
GlyphCopyDestList4::
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $a0, vTiles2 + $b0, vTiles2 + $c0, vTiles2 + $d0, vTiles2 + $e0, vTiles2 + $f0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1a0, vTiles2 + $1b0, vTiles2 + $1c0, vTiles2 + $1d0, vTiles2 + $1e0, vTiles2 + $1f0, vTiles2 + $6f0, vTiles1 + $7f0
    dw rIE

; the source list paired with GlyphCopyDestList4; its own $FFFF is not read (E-0200, C1)
; record: 32 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList4::
    dw $40b0, $41e0, $4150, $40e0, $40f0, $4100, $4110, $4160 ; entry 0
    dw $4130, $4180, $4210, $4170, $4290, $43c0, $4380, $43a0
    dw $4300, $40c0, $4250, $4370, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4a30, $4910, $4ad0, $4a70
    dw $ffff

; the source list paired with GlyphCopyDestList5; its own $FFFF is not read (E-0200, C1)
; record: 15 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList5::
    dw $4170, $4330, $4320, $4380, $4370, $4290, $4360, $40f0 ; entry 0
    dw $42b0, $4130, $4320, $42a0, $4330, $4190, $4150, $ffff

; passed in HL, with GlyphCopySrcList5 in DE, to SwapMonstersMenu_WriteGlyphListPos, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 15 VRAM tile addresses, then $FFFF
GlyphCopyDestList5::
    dw vTiles2 + $7c0, vTiles2 + $7d0, vTiles2 + $7e0, vTiles2 + $7f0, vTiles1 + $5f0, vTiles1 + $7e0, vTiles1 + $7f0, vTiles2 + $770 ; entry 0
    dw vTiles2 + $780, vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, rIE

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 9 tiles, one row per line
TileRect1E_1::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 11 x 11 tiles, one row per line
TileRect1E_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a9, $af, $a6, $a7, $c3, $a6, $a8, $a8, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f4, $a5, $aa, $ab, $c3, $ac, $a7, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $ad, $ae, $cf, $aa, $ab, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $a4, $cf, $ee, $cf, $ef, $df, $cf, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $f0, $f1, $a5, $f2, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

; record: 8 x 11 tiles, one row per line
TileRect1E_3::
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

TileRect1E_4::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

TileRect1E_5::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6
    db $b6, $c3, $a4, $cf, $ee, $cf, $ef, $df ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 8
    db $b6, $c3, $f0, $f1, $a5, $f2, $c3, $c3 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4 ; id 10

; record: 13 x 9 tiles, one row per line
TileRect1E_6::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d9, $da, $db, $dc, $dd, $de, $c0, $c1, $c2, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f5, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $bf, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c7, $c8, $c9, $ca, $cb, $ea, $eb, $ec, $ed, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 5 tiles, one row per line
TileRect1E_7::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $7c, $7d, $7e, $df, $7f, $fe, $ff, $76, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $77, $78, $78, $76, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 4 x 8 tiles, one row per line
TileRect1E_8::
    db $b1, $b1, $b1, $b2 ; id 0
    db $a6, $a8, $a8, $b7 ; id 1
    db $c3, $c3, $c3, $b7 ; id 2
    db $ac, $a7, $c3, $b7 ; id 3
    db $c3, $c3, $c3, $b7 ; id 4
    db $c3, $c3, $c3, $b7 ; id 5
    db $c3, $c3, $c3, $b7 ; id 6
    db $df, $cf, $c3, $b7 ; id 7

; record: 4 x 3 tiles, one row per line
TileRect1E_9::
    db $c3, $c3, $c3, $b7 ; id 0
    db $c3, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b5 ; id 2
    ds $3d5, $00
