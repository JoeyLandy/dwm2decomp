SECTION "Bank 14", ROMX[$4000], BANK[$14]
    db $14

; implements script command type EC (SCRIPT_HIBERNATE_CLOSE): ends the hibernation session and clears wMessageMode; reached through ScriptCommandEC in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandEC)
; reads: wScreenList
CloseHibernateMenu::
Func_014_4001:: ; address name
    ld a, [wScreenList]
    rst $00
    dw CloseHibernateMenu_CopyBytesDEToHL_Bank14
    dw CloseHibernateMenu_LoadTileListSixPerCall
    dw CloseHibernateMenu_FillTilesBxC
    dw CloseHibernateMenu_DrawRecordListNameTiles_Bank1D

; entry 0 of the `rst $00` table in CloseHibernateMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenList
; writes: wScreenList
; points at: wScreenTileBuffer, wScreenAttrBuffer
CloseHibernateMenu_CopyBytesDEToHL_Bank14::
Jump_014_400D:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank14
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank14

.call_bg_map_address_at_scroll_bank14:
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 1 of the `rst $00` table in CloseHibernateMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenList
; writes: wArg1, wArg2, wArg3, wArg4, wGlyphListPos, wGlyphListStart, wScreenState, wScreenStep, ...
CloseHibernateMenu_LoadTileListSixPerCall::
Jump_014_403F:: ; address name
    ld a, $9C
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, $6D84
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in CloseHibernateMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenList
; writes: wScreenList
; points at: wTextWindowTileLo
CloseHibernateMenu_FillTilesBxC::
Jump_014_4080:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 3 of the `rst $00` table in CloseHibernateMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode, wScreenList, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
CloseHibernateMenu_DrawRecordListNameTiles_Bank1D::
Jump_014_409E:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    xor a, a
    ld [wMessageMode], a
    ld [wScreenList], a
    ld bc, $006F
    ld hl, wScreenState

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $80
    ldh [hSpriteHideTile], a
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type EB (SCRIPT_HIBERNATE): monster hibernation: 'Which monster will hibernate?', 'Who should I wake up?' (mode 4, bank $1D strings); reached through ScriptCommandEB in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandEB)
; reads: wScreenState
HibernateMenu::
Func_014_40CC:: ; address name
    ld a, [wScreenState]
    rst $00
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

; entry 0 of the `rst $00` table in HibernateMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
HibernateMenu_CopyBytesDEToHL_Bank14::
Jump_014_40E8:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
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
    xor a, a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: the tile map, the glyph list and ListPartyRecordsWithState2ToListEntries
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
HibernateMenu_SetupPartyList::
Jump_014_412B:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw HibernateMenu_SetupPartyList_ToSetupTileMap6D84AtBGMap1
    dw HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep
    dw HibernateMenu_SetupPartyList_RunFunc5925At0280

; entry 0 of the `rst $00` table in HibernateMenu_SetupPartyList
; no direct call (reached through a table, a jump or a vector)
HibernateMenu_SetupPartyList_ToSetupTileMap6D84AtBGMap1::
Jump_014_4137:: ; address name
    farcall SetupTileMap6D84AtBGMap1
    ret

; entry 1 of the `rst $00` table in HibernateMenu_SetupPartyList
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart::
Jump_014_413E:: ; address name
    ld hl, NamingScreenTileDestListA
    ld de, TileCopySrcList_14_5A84
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp a, $FF
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in HibernateMenu_SetupPartyList
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
HibernateMenu_SetupPartyList_ToListPartyRecordsWithState2ToListEntriesAndStep::
Jump_014_414F:: ; address name
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in HibernateMenu_SetupPartyList
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
HibernateMenu_SetupPartyList_RunFunc5925At0280::
Jump_014_415D:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in HibernateMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wGridCursorX, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState, wListCursor, wChoiceCursor, wListPageIndex, wGridCursorX
HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
Jump_014_418A:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_hibernate_menu_case02_read_grid_cursor_x
    bit 7, a
    jr nz, .call_hibernate_menu_case02_read_grid_cursor_x2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_03
    call HibernateMenu_Case02_WriteGridCursorY
    ret

.call_hibernate_menu_case02_read_grid_cursor_x:
    call HibernateMenu_Case02_ReadGridCursorX_Sub03
    ld a, [wGridCursorX]
    and a, a
    jr nz, .set_grid_cursor_x
    ld a, $03
    ld [wGridCursorX], a
    call HibernateMenu_Case02_WriteGridCursorY
    ld a, $69
    call QueueSoundEffect
    ret

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call HibernateMenu_Case02_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_hibernate_menu_case02_read_grid_cursor_x2:
    call HibernateMenu_Case02_ReadGridCursorX_Sub03
    ld a, [wGridCursorX]
    cp a, $03
    jr c, .skip
    xor a, a
    ld [wGridCursorX], a
    call HibernateMenu_Case02_WriteGridCursorY
    ld a, $69
    call QueueSoundEffect
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call HibernateMenu_Case02_BGMapAddressAtScroll_Bank14
    ld c, $00

.loop:
    ld a, c
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    push bc
    push hl
    call StoreBAtWordTableEntry_Bank14
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $04
    jr c, .loop
    ld a, [wGridCursorX]
    cp a, $03
    jr z, .set_two_choice_cursor_to_03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from HibernateMenu_Case02 (E-0047)
; 3 call sites from 1 routine (e.g. HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
HibernateMenu_Case02_WriteGridCursorY::
Func_014_423F:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, HibernateMenu_Case02_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, HibernateMenu_Case02_ReadGridCursorX
    cp a, $18
    jr c, HibernateMenu_Case02_ReadGridCursorX_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from HibernateMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wGridCursorX
HibernateMenu_Case02_ReadGridCursorX::
Func_014_4259:: ; address name
    ld b, $BB
    jr HibernateMenu_Case02_BGMapAddressAtScroll_Bank14_ReadGridCursorX

; only called from HibernateMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wGridCursorX
HibernateMenu_Case02_ReadGridCursorX_Sub03::
Func_014_425D:: ; address name
    ld b, $C3
    jr HibernateMenu_Case02_BGMapAddressAtScroll_Bank14_ReadGridCursorX

; only called from HibernateMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wGridCursorX
HibernateMenu_Case02_BGMapAddressAtScroll_Bank14::
Func_014_4261:: ; address name
    ld b, $BC

HibernateMenu_Case02_BGMapAddressAtScroll_Bank14_ReadGridCursorX::
Jump_014_4263:: ; address name
    ld a, [wGridCursorX]
    add a, a
    ld hl, HibernateMenu_Case02_BGMapAddressAtScroll_Bank14_Data
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

; address loaded by HibernateMenu_Case02_BGMapAddressAtScroll_Bank14
HibernateMenu_Case02_BGMapAddressAtScroll_Bank14_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_4280:: ; address name
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 3 of the `rst $00` table in HibernateMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wArg5, wScreenState, wListCount, wRecordsFlagged, wPartyCount
; writes: wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wListPageIndex, wListCursor
HibernateMenu_WriteTwoChoiceCursorAndScreenStateEtc::
Jump_014_428A:: ; address name
    ld a, [wGridCursorX]
    and a, a
    jr z, .call_list_records_state1_with_byte6_e_clear
    cp a, $01
    jp z, .call_count_flagged_sram_records
    cp a, $02
    jp z, StartRecordListOrNoneMessage_CallCountFlaggedSRAMRecords
    ret

.call_list_records_state1_with_byte6_e_clear:
    farcall ListRecordsState1WithByte6EClear
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, [wListCount]
    and a, a
    jr z, .set_two_choice_cursor_to_01
    farcall CountFlaggedSRAMRecords
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wArg5]
    cp a, c
    jr c, .clear_screen_step
    ld a, $1E
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wListPageIndex], a
    ld [wListCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wListPageIndex], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_count_flagged_sram_records:
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    and a, a
    jp z, .set_two_choice_cursor_to_03
    farcall ListRecordsInUseWithByte6EClear
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wListCount]
    cp a, c
    jr nc, .set_two_choice_cursor_to_012
    ld b, a
    ld a, [wRecordsFlagged]
    cp a, c
    jr nc, .set_two_choice_cursor_to_02
    add a, b
    cp a, c
    jr c, .call_list_records_state1_with_byte6_e_clear2
    ld a, [wPartyCount]
    cp a, b
    jr z, .set_two_choice_cursor_to_04

.set_two_choice_cursor_to_012:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $1B
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_list_records_state1_with_byte6_e_clear2:
    farcall ListRecordsState1WithByte6EClear
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_04:
    ld a, $04
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; lists the records; with none sets wTwoChoiceCursor = 1 and wD780 = 2, otherwise wD780 += 3; then requests script $80 (the next entry does the same with CountFlaggedSRAMRecords) (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wScreenState
; writes: wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
StartRecordListOrNoneMessage:: ; heuristic: follows a terminator; C0
Func_014_43CC:: ; address name
    farcall ListRecordsState1WithByte6EClear
    ld a, [wListCount]
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

StartRecordListOrNoneMessage_CallCountFlaggedSRAMRecords::
Jump_014_4409:: ; address name
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add a, $04
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; HibernateMenu screen state 5, by wScreenStep: paged record lists with two-choice confirmations and UnpackRecordFromBank1Slot
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
HibernateMenu_ChooseRecords::
Jump_014_4446:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Case03
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case06
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case12
    dw HibernateMenu_ChooseRecords_UnpackRecordFromBank1Slot
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_Case1B
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case1C
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1WithByte6EClear
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case21
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case23
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case25
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280_Case2C
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_Case2D
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_Case2E
    dw HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14
    dw DrawBox4965AndMenuAndStep
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case31
    dw HibernateMenu_ChooseRecords_DrawBox4965AndMenuAndStep
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Case03
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case06
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case3B
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E
    dw HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot
    dw HibernateMenu_ChooseRecords_Multiply8
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280

; entry 50 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wListCursor, wListPageIndex, wSelectedRecord
; writes: wSelectedRecord, wItemGridX, wItemGridY, wListCursor, wListPageIndex
HibernateMenu_ChooseRecords_DrawBox4965AndMenuAndStep::
Jump_014_44DA:: ; address name
    call DrawBox4965AndMenuAndStep
    farcall ListRecordsState1WithByte6EClear
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
    call HibernateMenu_ChooseRecords_Case32_CopyRecordNameToNameGlyphBuf
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ret

; entry 60 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wItemGridX, wItemGridY
; writes: wListCursor, wListPageIndex, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C::
Jump_014_450C:: ; address name
    call BGMapAddressAtScroll_Bank14
    push hl
    ld a, [wListCursor]
    add a, a
    ld hl, HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $BC
    ld [hl], a
    ei
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall ListRecordsState1WithByte6EClear
    call HibernateMenu_ClampRecordListPageCursor5
    call EraseFiveEntriesOf5B1E
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $0201
    call FillTilesBxC
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $20
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_4586:: ; address name
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; entry 62 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wListCursor
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E::
Jump_014_4590:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .call_hibernate_menu_write_svbk
    cp a, $FF
    jp z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .call_hibernate_menu_write_svbk
    farcall HibernateMenu_ChooseRecords_Case3E_CopyRecordNameToNameGlyphBuf
    call HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Shared01
    jp HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK

.call_hibernate_menu_write_svbk:
    call HibernateMenu_WriteSVBK
    ld a, [wListCursor]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $3B
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 63 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wSelectedRecord, wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wSelectedRecord, wScreenSubStep, ...
; points at: wRecordBufA, sCompactRecords, sRecords
HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot::
Jump_014_45DE:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, .call_set_arg5_to_list_entries_cell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    ld hl, wRecordBufA
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
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
    cp a, $1D
    jr z, .set_arg2_to_01
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
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
    cp a, $FF
    ret nz
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wArg5]
    ld [wSelectedRecord], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 64 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB, wItemGridX, wItemGridY, wSelectedRecord, wListCursor, wChoiceCursor, wListPageIndex, ...
; points at: sCompactRecords, wRecordBufA, sRecords
HibernateMenu_ChooseRecords_Multiply8::
Jump_014_46A1:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, .skip
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $01

.skip2:
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $6F

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wSelectedRecord], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 5 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
HibernateMenu_ChooseRecords_FillTilesBxC::
Jump_014_46F4:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14::
Jump_014_4718:: ; address name
    ld a, [wListCursor]
    ld b, $BB
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wListCursor]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14::
Jump_014_4742:: ; address name
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14::
Jump_014_475E:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart::
Jump_014_4772:: ; address name
    ld hl, TileCopyDestList_14_5C36
    ld de, TileCopySrcList_14_5C4A
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp a, $FF
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_Case2D::
Jump_014_4783:: ; address name
    ld hl, TileCopyDestList_14_5C8A
    ld de, TileCopySrcList_14_5C9A
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp a, $FF
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wChoiceCursor, wCursorBlinkAE, wScreenStep
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_Case2E::
Jump_014_4794:: ; address name
    ld de, TileRect_14_47C0
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wChoiceCursor], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_14_47C0::
Data_014_47C0:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $73, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $74, $75, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 47 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteB2, wScreenByteB3, wScreenState, wScreenSubStep, ...
HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14::
Jump_014_47E8:: ; address name
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
    and a, a
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
    cp a, $01
    jr c, .skip
    xor a, a
    jr .set_choice_cursor2

.skip:
    inc a
    jr .set_choice_cursor2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14
    ld a, [wChoiceCursor]
    and a, a
    jp nz, .check_screen_state
    ld a, [wScreenState]
    cp a, $05
    jr z, .check_screen_step2
    cp a, $04
    jr z, .check_screen_step

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $13
    jr c, .set_screen_byte_b2_to_04
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $3F
    ld [wScreenByteB3], a
    ld a, $09
    jp .set_screen_state

.set_screen_byte_b2_to_04:
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $12
    ld [wScreenByteB3], a
    ld a, $09
    jp .set_screen_state

.check_screen_step2:
    ld a, [wScreenStep]
    cp a, $2E
    jr c, .set_screen_byte_b2_to_042
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $2F
    ld [wScreenByteB3], a
    ld a, $09
    jp .set_screen_state

.set_screen_byte_b2_to_042:
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $25
    ld [wScreenByteB3], a
    ld a, $09

.set_screen_state:
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    farcall SaveAndHideSpriteState_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp a, $04
    jr nz, .set_two_choice_cursor_to_01
    ld a, [wScreenStep]
    cp a, $3F
    jr nz, .set_two_choice_cursor_to_01
    call HibernateMenu_ChooseRecords_Case2F_LoadRecordNameEntry0
    call HibernateMenu_ChooseRecords_Case2F_SetArg5ToListEntriesCell5

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; once the joypad repeat timer reaches $14, cycles wD7AE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
BlinkCursorBlinkAE_Bank14::
Func_014_48ED:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_Bank14
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, DrawCursorTileBB_Bank14
    cp a, $18
    jr c, DrawBlankTileC3_Bank14
    xor a, a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14)
; reads: wChoiceCursor
DrawCursorTileBB_Bank14::
Func_014_4907:: ; address name
    ld b, $BB
    jr HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14)
; reads: wChoiceCursor
DrawBlankTileC3_Bank14::
Func_014_490B:: ; address name
    ld b, $C3
    jr HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14_ReadChoiceCursor

; only called from HibernateMenu_ChooseRecords_Case2F (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14)
; reads: wChoiceCursor
HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14::
Func_014_490F:: ; address name
    ld b, $BC

HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14_ReadChoiceCursor::
Jump_014_4911:: ; address name
    ld a, [wChoiceCursor]
    add a, a
    ld hl, HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14_Data
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

; address loaded by HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14
HibernateMenu_ChooseRecords_Case2F_BGMapAddressAtScroll_Bank14_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_492E:: ; address name
    db $2D, $01, $6D, $01

; copies box Data_014_4965 to wC410, runs Func_014_5925, blanks the cursor entry wD7AB of Data_014_5B1E and wD781 += 1 (E-0124)
; 5 call sites from 5 routines (e.g. HibernateMenu_ChooseToHibernate_Multiply8, HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot, HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5, HibernateMenu_ChooseRecords_Multiply8, ...)
; reads: wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawBox4965AndMenuAndStep::
Func_014_4932:: ; address name
    ld de, TileRect_14_4965
    ld hl, wWindowTileBuffer + $110
    ld bc, $0801
    call CopyRectTo20ByteRows_Bank14
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld a, [wListCursor]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 1 tiles, one row per line
TileRect_14_4965::
Data_014_4965:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0

; entry 27 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_Case1B::
Jump_014_496D:: ; address name
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_14_49AE
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank14
    ld a, [wGridCursorX]
    ld b, $BC
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_14_49AE::
Data_014_49AE:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $EF, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 28 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wScreenState
HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case1C::
Jump_014_49CC:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.loop:
    call HibernateMenu_ChooseRecords_Case1C_BGMapAddressAtScroll_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $01
    ld [wScreenState], a
    ld a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    call HibernateMenu_ChooseRecords_Case1C_BGMapAddressAtScroll_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from HibernateMenu_ChooseRecords_Case1C (E-0047)
; 2 call sites from 1 routine (e.g. HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case1C)
; reads: wIsCGB, rSVBK
; writes: rSVBK
HibernateMenu_ChooseRecords_Case1C_BGMapAddressAtScroll_Bank14::
Func_014_4A1F:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $00
    call HibernateMenu_ChooseRecords_Case1C_Sub01_CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank14
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call HibernateMenu_ChooseRecords_Case1C_Sub01_CopyBytesDEToHL_Bank14
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank14:
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ret

; only called from HibernateMenu_ChooseRecords_Case1C_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. HibernateMenu_ChooseRecords_Case1C_BGMapAddressAtScroll_Bank14)
HibernateMenu_ChooseRecords_Case1C_Sub01_CopyBytesDEToHL_Bank14::
Func_014_4A54:: ; address name
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
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp a, $05
    jr c, HibernateMenu_ChooseRecords_Case1C_Sub01_CopyBytesDEToHL_Bank14
    ret

; entry 0 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wListPageIndex, wCursorBlinkAE, wScreenStep
HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14::
Jump_014_4A75:: ; address name
    ld de, TileRect_14_4AA8
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    ld de, TileRect_14_4B02
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    xor a, a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 9 tiles, one row per line
TileRect_14_4AA8::
Data_014_4AA8:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_14_4B02::
Data_014_4B02:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; clears four tile rows (vTiles1 + $240, $500, $700, $4E0), copies rectangle Data_014_5B36 to wC364 and wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_UpdatePagedListCursor)
; reads: wScreenStep
; writes: wScreenStep
ClearTilesAndDrawRect5B36AndStep::
Func_014_4B5A:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $0201
    call FillTilesBxC
    ld de, TileRect_14_5B36
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 31 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
HibernateMenu_ChooseRecords_ListRecordsState1WithByte6EClear::
Jump_014_4B92:: ; address name
    farcall ListRecordsState1WithByte6EClear
    jr HibernateMenu_ClampRecordListPageCursor5
    db $21, $2D, $5F, $06, $1D, $D7

; only called from routines of HibernateMenu (E-0098)
; 2 call sites from 2 routines (e.g. HibernateMenu_ChooseToHibernate_WriteListCursorAndListPageIndexEtc, HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
HibernateMenu_ClampRecordListPageCursor5::
Func_014_4BA0:: ; address name
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank14
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank14
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12F
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

; entry 32 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
HibernateMenu_ChooseRecords_ToDrawRecordListPageNames::
Jump_014_4BE3:: ; address name
    farcall DrawRecordListPageNames
    ret

; entry 33 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case21::
Jump_014_4BEA:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    call LoadFamilyIconTileForRecordB_Bank14
    ld de, TileRect_14_5B8E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 35 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case23::
Jump_014_4C1C:: ; address name
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

; entry 37 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case25::
Jump_014_4C3C:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .read_screen_step3
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .read_screen_step2
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step3:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
HibernateMenu_ChooseRecords_WriteScreenStep::
Jump_014_4CA8:: ; address name
    ld hl, TileCopyDestList_14_5C5E
    ld de, TileCopySrcList_14_5C74
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp a, $FF
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D::
Jump_014_4CBC:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 44 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseRecords_RunFunc5925At0280_Case2C::
Jump_014_4CD0:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    ld a, [wGridCursorX]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    ld a, $1B
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 49 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case31::
Jump_014_4D10:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $25
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseRecords_RunFunc5925At0280::
Jump_014_4D2B:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    xor a, a
    ld [wScreenStep], a
    ld a, $02
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; screen state 4, reached from menu option 0: the list of farm records that are not eggs (ListRecordsState1WithByte6EClear) after a capacity check; the script asks Which monster will hibernate?
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
HibernateMenu_ChooseToHibernate::
Jump_014_4D64:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1WithByte6EClear
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case21
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case23
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case25
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_Case2D
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_Case2E
    dw HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14
    dw DrawBox4965AndMenuAndStep
    dw HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM_Case1B
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case1C
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Case03
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case06
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseToHibernate_RunFunc5925At0280
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D
    dw HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case32
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1WithByte6EClear
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case21
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case23
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case3B
    dw HibernateMenu_ChooseToHibernate_WriteListCursorAndListPageIndexEtc
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_Case2D
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_Case2E
    dw HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14
    dw DrawBox4965AndMenuAndStep
    dw HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14_Case41
    dw HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case42
    dw HibernateMenu_ChooseToHibernate_Multiply8
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280

; entry 2 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc::
Jump_014_4DFE:: ; address name
    farcall HibernateMenu_WriteListCountAndRAMG2Etc
    jp HibernateMenu_ClampRecordListPageCursor5

; entry 3 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Case03::
Jump_014_4E07:: ; address name
    farcall HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc
    ret

; entry 4 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5::
Jump_014_4E0E:: ; address name
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
    ld de, TileRect_14_5B8E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    pop af
    ld [wArg1], a
    farcall HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case06::
Jump_014_4E46:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    farcall HibernateMenu_ChooseRecords_Case06_RecordAddressWithBank1Slot1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 49 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wListCursor
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D::
Jump_014_4E66:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.loop:
    ld a, [wListCursor]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call HibernateMenu_WriteSVBK
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $28
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop

HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK::
Jump_014_4EA7:: ; address name
    call HibernateMenu_WriteSVBK
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of HibernateMenu (E-0098)
; 4 call sites from 3 routines (e.g. HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D, HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E, HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D)
; reads: wIsCGB, rSVBK
; writes: rSVBK
HibernateMenu_WriteSVBK::
Func_014_4EBF:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $00
    call HibernateMenu_Shared02_CopyBytesDEToHL_Bank14
    ld hl, wWindowTileBuffer + $112
    ld de, HibernateMenu_WriteSVBK_Data_4F24
    ld c, $04
    call HibernateMenu_Shared02_CopyBytesDEToHL_Bank14
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank14
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call HibernateMenu_Shared02_CopyBytesDEToHL_Bank14
    ld hl, wWindowAttrBuffer + $112
    ld de, HibernateMenu_WriteSVBK_Data_4F2A
    ld c, $04
    call HibernateMenu_Shared02_CopyBytesDEToHL_Bank14
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank14:
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld de, Tiles2Plus210Tiles_1F_4130
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4320
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; address loaded by HibernateMenu_WriteSVBK
HibernateMenu_WriteSVBK_Data_4F24:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_4F24:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B5

; address loaded by HibernateMenu_WriteSVBK
HibernateMenu_WriteSVBK_Data_4F2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_4F2A:: ; address name
    db $00, $00, $00, $00, $00, $00

; only called from HibernateMenu_Shared02 (E-0047)
; 4 call sites from 1 routine (e.g. HibernateMenu_WriteSVBK)
HibernateMenu_Shared02_CopyBytesDEToHL_Bank14::
Func_014_4F30:: ; address name
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
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp a, $05
    jr c, HibernateMenu_Shared02_CopyBytesDEToHL_Bank14
    ret

; entry 16 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM::
Jump_014_4F51:: ; address name
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_14_4FAE
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank14
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_14_4FAE::
Data_014_4FAE:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $76, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 60 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridX, wItemGridY
; writes: wListCursor, wListPageIndex, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
HibernateMenu_ChooseToHibernate_WriteListCursorAndListPageIndexEtc::
Jump_014_4FCC:: ; address name
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
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wScreenStep
; writes: rRAMG2, rRAMB, wArg2, wArg3, wArg4, wArg1, wListEntries2, wScreenByteBF, ...
; points at: sCompactRecords, sRecords
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case12::
Jump_014_5002:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr nc, .set_arg2_to_01
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
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
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip
    jr .set_arg1

.skip:
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1E
    jr c, .loop
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_arg1:
    ld a, c
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wArg1]
    ld [wListEntries2], a
    ld a, [wArg2]
    ld [wScreenByteBF], a
    ld a, [wArg3]
    ld [wScreenByteC0], a
    ld a, [wArg4]
    ld [wScreenByteC1], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 19 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wListEntries2, wScreenByteBF, wScreenByteC0, wScreenByteC1, wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, rRAMG2, rRAMB, wScreenStep, wScriptCommandType, ...
HibernateMenu_ChooseRecords_UnpackRecordFromBank1Slot::
Jump_014_5095:: ; address name
    ld a, [wListEntries2]
    ld [wArg1], a
    ld a, [wScreenByteBF]
    ld [wArg2], a
    ld a, [wScreenByteC0]
    ld [wArg3], a
    ld a, [wScreenByteC1]
    ld [wArg4], a
    farcall UnpackRecordFromBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wScreenByteBF]
    ld [rRAMB], a
    ld a, [wScreenByteC0]
    ld l, a
    ld a, [wScreenByteC1]
    ld h, a
    ld b, $6F

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14::
Jump_014_5104:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 21 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wScreenStep, wListCursor, wChoiceCursor, wListPageIndex, wListCursorAux, wCursorBlinkAE
HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5::
Jump_014_511F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    push hl
    call HibernateMenu_ChooseToHibernate_Case15_WriteRAMBAndArg6Etc
    pop hl
    cp a, $FF
    jr z, .check_screen_step
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_screen_step:
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 22 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArg7, wListPageIndex, wListCursor
; writes: wArg2, wArg3, wArg4, wArg1, rRAMG2, rRAMB, wListCursor, wChoiceCursor, ...
; points at: wListEntries
HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot::
Jump_014_5171:: ; address name
    ld a, [wArg5]
    ld [wArg2], a
    ld a, [wArg6]
    ld [wArg3], a
    ld a, [wArg7]
    ld [wArg4], a
    ld a, [wListPageIndex]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; entry 8 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseRecords_UpdatePagedListCursor::
Jump_014_51E9:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .call_clear_tiles_and_draw_rect5_b36_and_step
    cp a, $FC
    jr z, .call_clear_tiles_and_draw_rect5_b36_and_step
    cp a, $FD
    jr z, .read_screen_step
    cp a, $FE
    jr z, .set_two_choice_cursor_to_01
    cp a, $FF
    jr z, .call_erase_five_entries_of5_b1_e
    ret

.call_clear_tiles_and_draw_rect5_b36_and_step:
    call ClearTilesAndDrawRect5B36AndStep
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_erase_five_entries_of5_b1_e:
    call EraseFiveEntriesOf5B1E
    ld a, [wListCursor]
    ld b, $BC
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 47 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseToHibernate_RunFunc5925At0280::
Jump_014_525C:: ; address name
    ld de, TileRect_14_5AC4
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank14
    call RunFunc5925At0280
    ld a, [wGridCursorX]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    call BGMapAddressAtScroll_Bank14
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    farcall CountRecordsInUse
    ld a, $1E
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 50 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wListCursor, wArg5, wArg6, wListPageIndex
; writes: wScreenStep, wItemGridX, wSelectedRecord, wItemGridY, wListCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case32::
Jump_014_529C:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
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
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    farcall ListRecordsState1WithByte6EClear
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 59 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor, wScreenState
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
HibernateMenu_ChooseRecords_UpdatePagedListCursor_Case3B::
Jump_014_52E4:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .read_screen_step2
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .check_screen_step2
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wScreenState]
    cp a, $04
    jr z, .read_list_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $BC
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ret

.check_screen_step2:
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 65 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14_Case41::
Jump_014_5371:: ; address name
    call BGMapAddressAtScroll_Bank14
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank14
    ld a, $3B
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 66 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wArg5, wArg6, wSelectedRecord, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wScreenSubStep, wSelectedRecord, ...
; points at: wRecordBufA, sCompactRecords, sRecords
HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case42::
Jump_014_538C:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, .check_selected_record
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push af
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ld [wArg2], a
    ld hl, wRecordBufA
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall PackRecordFieldsToBank1Slot
    ld a, [wArg5]
    cp a, $FF
    jr z, .set_arg1
    pop af
    ret

.set_arg1:
    pop af
    ld [wArg1], a
    xor a, a
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
    cp a, $1D
    jr z, .set_arg2_to_01
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
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
    cp a, $FF
    ret nz
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wArg5]
    ld [wSelectedRecord], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 67 of the `rst $00` table in HibernateMenu_ChooseToHibernate
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB, wItemGridX, wItemGridY, wSelectedRecord, wListCursor, wChoiceCursor, wListPageIndex, ...
; points at: sCompactRecords, wRecordBufA, sRecords
HibernateMenu_ChooseToHibernate_Multiply8::
Jump_014_543F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, .skip
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $01

.skip2:
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $6F

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wSelectedRecord], a
    farcall ListPartyRecordsWithState2ToListEntries
    call DrawBox4965AndMenuAndStep
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

; screen state 6: a paged record list that marks party members (MarkPartyMembersInRecordListPage) and shows a stats box (DrawRecordStatsBoxForArg1)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
HibernateMenu_ChooseWithStats::
Jump_014_5492:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_ListRecordsState1WithByte6EClear
    dw HibernateMenu_ChooseRecords_ToDrawRecordListPageNames
    dw HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case23
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseWithStats_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280
    dw HibernateMenu_ChooseWithStats_SaveAndHideSpriteState_Bank1E

; entry 4 of the `rst $00` table in HibernateMenu_ChooseWithStats
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5::
Jump_014_54B8:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank14
    ld de, TileRect_14_5B8E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank14
    xor a, a
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

; entry 8 of the `rst $00` table in HibernateMenu_ChooseWithStats
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
HibernateMenu_ChooseWithStats_UpdatePagedListCursor::
Jump_014_5501:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .read_screen_step3
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .read_screen_step2
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step3:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; runs Func_014_5925 (C = 9, HL = $01D4, DE = 8, wD7F1/2 = 0/$0C), copies the 11 x 1 rectangle Data_014_5595 to wC40D and wD781 += 1 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawBox1D4AndCopyRect5595:: ; heuristic: follows a terminator; C0
Func_014_556D:: ; address name
    ld c, $09
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ld de, TileRect_14_5595
    ld hl, wWindowTileBuffer + $10D
    ld bc, $0B01
    call CopyRectTo20ByteRows_Bank14
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 1 tiles, one row per line
TileRect_14_5595::
Data_014_5595:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0

; entry 16 of the `rst $00` table in HibernateMenu_ChooseWithStats
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenByteB2, wScreenByteB3, wScreenStep, wScreenSubStep, wScreenState
HibernateMenu_ChooseWithStats_SaveAndHideSpriteState_Bank1E::
Jump_014_55A0:: ; address name
    ld hl, TileCopyDestList_14_5C8A
    ld de, TileCopySrcList_14_5C9A
    call HibernateMenu_WriteGlyphListPosAndGlyphListStart
    cp a, $FF
    ret nz
    ld a, $06
    ld [wScreenByteB2], a
    ld a, $08
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $09
    ld [wScreenState], a
    farcall SaveAndHideSpriteState_Bank1E
    ret

; screen state 7: takes the chosen list entry (SetArg5ToListEntriesCell5) and computes its index (Multiply8)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
HibernateMenu_IndexListEntry::
Jump_014_55C9:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw ClearTilesAndDrawRect5B36AndStep
    dw HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc
    dw HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Case03
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_FillTilesBxC
    dw HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case06
    dw HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14
    dw HibernateMenu_ChooseRecords_UpdatePagedListCursor
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280
    dw HibernateMenu_ChooseRecords_CopyFromBankWaitVRAM
    dw HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D
    dw HibernateMenu_IndexListEntry_SetArg5ToListEntriesCell5
    dw HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14
    dw HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14
    dw HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart
    dw HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14
    dw HibernateMenu_ChooseRecords_WriteScreenStep
    dw HibernateMenu_ChooseRecords_DrawRecordListNameTiles_Bank1D
    dw HibernateMenu_ChooseRecords_RunFunc5925At0280

; entry 17 of the `rst $00` table in HibernateMenu_ChooseRecords
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wListCursor
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D::
Jump_014_5601:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .call_hibernate_menu_write_svbk
    cp a, $FF
    jp z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .call_hibernate_menu_write_svbk
    call HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Shared01
    jp HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D_CallHibernateMenu_WriteSVBK

.call_hibernate_menu_write_svbk:
    call HibernateMenu_WriteSVBK
    ld a, [wListCursor]
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in HibernateMenu_IndexListEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wScreenStep
; points at: sCompactRecords, sRecords
HibernateMenu_IndexListEntry_SetArg5ToListEntriesCell5::
Jump_014_5649:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, .skip
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $01

.skip2:
    ld [rRAMB], a
    ld b, $6F

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall HibernateMenu_Multiply8
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in HibernateMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wAreaGraphicsIndex
HibernateMenu_SwapMonstersMenu::
Jump_014_56A4:: ; address name
    ld a, $01
    ld [wAreaGraphicsIndex], a
    farcall SwapMonstersMenu
    ret

; only called from HibernateMenu_ChooseRecords_Case32 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_DrawBox4965AndMenuAndStep)
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf0
HibernateMenu_ChooseRecords_Case32_CopyRecordNameToNameGlyphBuf::
Func_014_56B0:: ; address name
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    pop bc
    ld a, c
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop

.done:
    ld a, $F0
    ld [de], a
    ret

; only called from routines of HibernateMenu_ChooseRecords (E-0098)
; 2 call sites from 2 routines (e.g. HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E, HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D)
; reads: wArg5, wArg6, wTextBuf1
; writes: wArg2, wArg3, wArg4, wArg1, wNameGlyphBuf, wTextBuf1
; points at: sCompactRecords, wNameGlyphBuf, wTextBuf1, sRecords
HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Shared01::
Func_014_56EB:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, .set_arg2_to_01
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
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
    xor a, a
    ld [wArg1], a
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .check_text_buf1
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop

.check_text_buf1:
    ld a, $F0
    ld [de], a
    ld a, [wTextBuf1]
    cp a, $E0
    ret c
    ld a, $F0
    ld [wTextBuf1], a
    ret

; only called from HibernateMenu_ChooseRecords_Case2F (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf1
HibernateMenu_ChooseRecords_Case2F_SetArg5ToListEntriesCell5::
Func_014_574E:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop

.done:
    ld a, $F0
    ld [de], a
    ret

; only called from HibernateMenu_ChooseRecords_Case2F (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_BlinkCursorBlinkAE_Bank14)
; reads: wSelectedRecord, wTextBuf0
; writes: wArg2, wArg3, wArg4, wArg1, wNameGlyphBuf, wTextBuf0
; points at: sCompactRecords, wNameGlyphBuf, wTextBuf0, sRecords
HibernateMenu_ChooseRecords_Case2F_LoadRecordNameEntry0::
Func_014_578E:: ; address name
    ld a, [wSelectedRecord]
    cp a, $1D
    jr z, .set_arg2_to_01
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
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
    xor a, a
    ld [wArg1], a
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .check_text_buf0
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop

.check_text_buf0:
    ld a, $F0
    ld [de], a
    ld a, [wTextBuf0]
    cp a, $E0
    ret c
    ld a, $F0
    ld [wTextBuf0 + $2], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 5 call sites from 5 routines (e.g. CloseHibernateMenu_CopyBytesDEToHL_Bank14, HibernateMenu_CopyBytesDEToHL_Bank14, CopyScreenBufferRectWithAttrs_Bank14, HibernateMenu_Shared02_CopyBytesDEToHL_Bank14, ...)
CopyBytesDEToHL_Bank14::
Func_014_57E5:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank14
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 3 call sites from 3 routines (e.g. CloseHibernateMenu_CopyBytesDEToHL_Bank14, HibernateMenu_CopyBytesDEToHL_Bank14, CopyScreenBufferRectWithAttrs_Bank14)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank14::
Func_014_57EE:: ; address name
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    xor a, a
    ldh [rSVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 21 call sites from 21 routines (e.g. CloseHibernateMenu_CopyBytesDEToHL_Bank14, HibernateMenu_Case02_BGMapAddressAtScroll_Bank14, HibernateMenu_SetupPartyList_RunFunc5925At0280, HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14_Case41, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank14::
Func_014_5800:: ; address name
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and a, $F8
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

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 15 call sites from 14 routines (e.g. HibernateMenu_SetupPartyList_RunFunc5925At0280, HibernateMenu_ChooseToHibernate_RunFunc5925At0280, DrawBox4965AndMenuAndStep, HibernateMenu_ChooseRecords_CopyRectTo20ByteRows_Bank14_Case2E, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank14::
Func_014_5821:: ; address name
    push hl
    push bc

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    ld [hl+], a
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
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push bc
    push hl

.loop4:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop4
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop3
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1 (E-0062)
; 17 call sites from 17 routines (e.g. CloseHibernateMenu_CopyBytesDEToHL_Bank14, HibernateMenu_SetupPartyList_RunFunc5925At0280, HibernateMenu_ChooseToHibernate_BGMapAddressAtScroll_Bank14_Case41, HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case32, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_Bank14::
Func_014_585B:: ; address name
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
    add a, $C1
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
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
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; only called from routines of HibernateMenu (E-0098)
; 5 call sites from 5 routines (e.g. HibernateMenu_SetupPartyList_HibernateMenu_WriteGlyphListPosAndGlyphListStart, HibernateMenu_ChooseRecords_HibernateMenu_WriteGlyphListPosAndGlyphListStart_Case2D, HibernateMenu_ChooseWithStats_SaveAndHideSpriteState_Bank1E, HibernateMenu_ChooseRecords_WriteScreenStep, ...)
; reads: wGlyphListStart, wGlyphListPos
; writes: wGlyphListPos, wGlyphListStart
HibernateMenu_WriteGlyphListPosAndGlyphListStart::
Func_014_5898:: ; address name
    xor a, a
    ld [wGlyphListPos], a

.loop:
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, .restore
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wGlyphListStart]
    add a, a
    add a, e
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
    ld b, $1F
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
    cp a, $08
    jr c, .loop
    xor a, a
    ret

.restore:
    pop de
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ld a, $FF
    ret

; stores tile $C3 at the addresses of entries 0-4 of the word table Data_014_5B1E (E-0122)
; 2 call sites from 2 routines (e.g. HibernateMenu_ChooseRecords_BGMapAddressAtScroll_Bank14_Case3C, HibernateMenu_ChooseRecords_UpdatePagedListCursor)
EraseFiveEntriesOf5B1E::
Func_014_58EE:: ; address name
    ld c, $00

.loop:
    push bc
    ld a, c
    ld b, $C3
    ld hl, HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data
    call StoreBAtWordTableEntry_Bank14
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 16 call sites from 14 routines (e.g. HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, HibernateMenu_ChooseToHibernate_UpdateTwoChoiceCursor_Bank1D, HibernateMenu_ChooseToHibernate_RunFunc5925At0280, HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E, ...)
StoreBAtWordTableEntry_Bank14::
Func_014_5902:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; runs Func_014_5925 with C = 2, HL = $0280, DE = $00B4, wD7F1/2 = 0/8 (E-0122)
; 4 call sites from 4 routines (e.g. HibernateMenu_SetupPartyList_RunFunc5925At0280, HibernateMenu_ChooseToHibernate_RunFunc5925At0280, HibernateMenu_ChooseRecords_RunFunc5925At0280_Case2C, HibernateMenu_ChooseRecords_RunFunc5925At0280)
; writes: wArg1, wArg2
RunFunc5925At0280::
Func_014_5910:: ; address name
    ld c, $02
    ld hl, $0280
    ld de, $00B4
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank14
    ret

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 4 call sites from 4 routines (e.g. RunFunc5925At0280, DrawBox4965AndMenuAndStep, HibernateMenu_ChooseRecords_CopyScreenBufferRectWithAttrs_Bank14, DrawBox1D4AndCopyRect5595)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_Bank14::
Func_014_5925:: ; address name
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
    and a, a
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
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_Bank14
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = $C7, then LoadFamilyIconTileForWorkBuf (E-0122)
; 2 call sites from 2 routines (e.g. HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case21, HibernateMenu_ChooseWithStats_SetArg5ToListEntriesCell5)
; reads: hTemp0
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank14::
Func_014_5979:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wWorkBuf], a
    ld a, $C7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (WaitForVRAMAccess, interrupts off) (E-0120)
; 1 call site from 1 routine (e.g. HibernateMenu_ClampRecordListPageCursor5)
DrawC5BEC6AtScrollOffsetDE_Bank14::
Func_014_599F:: ; address name
    push de
    call BGMapAddressAtScroll_Bank14
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 1 call site from 1 routine (e.g. HibernateMenu_ClampRecordListPageCursor5)
StoreC5BEC6AtHLStride2_Bank14::
Func_014_59C2:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; only called from HibernateMenu_ChooseToHibernate_Case15 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5)
; writes: rRAMB, wArg6, wArg7, wArg5
; points at: sCompactRecords, sRecords
HibernateMenu_ChooseToHibernate_Case15_WriteRAMBAndArg6Etc::
Func_014_59D0:: ; address name
    ld hl, sCompactRecords
    ld c, $00

.loop:
    ld a, [hl]
    bit 7, a
    jr z, .skip
    ld a, $6F
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1D
    jr c, .loop
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr z, .skip
    ld a, $FF
    ret

.skip:
    push bc
    ld a, c
    cp a, $1D
    jr z, .restore
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    xor a, a
    ld [wArg5], a
    pop bc
    xor a, a
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
    xor a, a
    ret

; E-0224 (C1: HibernateMenu_Case01_Case01 passes $5A28 with sources Data_014_5A84 to HibernateMenu_Shared04, which copies one tile per destination until $FFFF).
; record: 27 VRAM destinations, then $FFFF
NamingScreenTileDestListA::
Data_014_5A28:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0 ; entry 0
    dw vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $2F0, vTiles1 + $6E0, vTiles1 + $6F0, vTiles1 + $700, vTiles1 + $710
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7A0, vTiles1 + $7B0, vTiles1 + $7C0, vTiles1 + $7D0

; E-0224 (C1: the second $FFFF-terminated destination list, right after the first; it ends at the source list Data_014_5A84).
; record: 17 VRAM destinations, then $FFFF
NamingScreenTileDestListB::
Data_014_5A60:: ; address name
    dw vTiles1 + $7E0, vTiles1 + $7F0, vTiles1 + $6B0, rIE, vTiles1 + $400, vTiles1 + $410, vTiles1 + $420, vTiles1 + $470 ; entry 0
    dw vTiles1 + $480, vTiles1 + $490, vTiles1 + $4A0, vTiles1 + $4B0, vTiles1 + $3F0, vTiles1 + $6A0, vTiles1 + $6B0, vTiles1 + $6C0
    dw vTiles1 + $6D0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5A84::
Data_014_5A84:: ; address name
    dw $41D0, $4300, $4290, $4340, $4210, $4250, $42F0, $41C0 ; entry 0
    dw $4370, $40F0, $43C0, $42D0, $4380, $4180, $4910, $4910
    dw $4910, $4910, $4910, $4120, $4170, $41A0, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4A70, $4910, $FFFF

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 9 tiles, one row per line
TileRect_14_5AC4::
Data_014_5AC4:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A4, $A5, $A6, $A6, $A7, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A8, $A9, $AA, $A6, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $AB, $A6, $A5, $A6, $A9, $AC, $A6, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $AD, $AE, $AF, $EE, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; address loaded by HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, HibernateMenu_ChooseRecords_UpdateTwoChoiceCursor_Bank1D_Case3E, HibernateMenu_ChooseRecords_StoreBAtWordTableEntry_Bank14, DrawBox4965AndMenuAndStep and 10 more
HibernateMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_5B1E:: ; address name
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $22, $C4, $4A, $C4, $80, $C3
    db $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_14_5B36::
Data_014_5B36:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $A4, $A5, $A6, $CE, $CF, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 9 tiles, one row per line
TileRect_14_5B8E::
Data_014_5B8E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8
    db $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A, $C0, $8A, $D0, $8A, $E0, $8A
    db $F0, $8A, $80, $8F, $90, $8F, $A0, $8F, $B0, $8F, $C0, $8F, $FF, $FF, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $10, $49
    db $10, $49, $10, $49, $10, $49, $10, $49, $10, $49, $FF, $FF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_14_5C36::
Data_014_5C36:: ; address name
    dw vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0, vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0 ; entry 0
    dw vTiles1 + $2F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5C4A::
Data_014_5C4A:: ; address name
    dw $4340, $4210, $4250, $42F0, $41C0, $4370, $40F0, $43C0 ; entry 0
    dw $42D0, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_14_5C5E::
Data_014_5C5E:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740 ; entry 0
    dw vTiles1 + $4E0, vTiles1 + $4F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5C74::
Data_014_5C74:: ; address name
    dw $41D0, $4300, $4290, $4910, $4910, $4910, $4910, $4910 ; entry 0
    dw $4230, $4290, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_14_5C8A::
Data_014_5C8A:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_14_5C9A::
Data_014_5C9A:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; unless a fade is running, runs the routine for wCFA8 (jump table of eight) (E-0122)
; 5 call sites from 5 routines (e.g. GameMode5_Update_NewPlayerSetup_RunNameEntryStateWhenNotFading, RenameMenu_LoadSRAMRecordByte, BreedMenu_NameEntry, RunBattleEndStep5SubSteps_WriteArg1AndArg2Etc, ...)
; reads: wFadeState, wNameEntryState
RunNameEntryStateWhenNotFading::
Func_014_5CA8:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wNameEntryState]
    rst $00
    dw RunNameEntryStateWhenNotFading_Setup
    dw RunNameEntryStateWhenNotFading_ReadNameEntrySubState
    dw RunNameEntryStateWhenNotFading_ReadNameEntryStep
    dw RunNameEntryStateWhenNotFading_ReadNameEntryStep_Case03
    dw RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params
    dw RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc
    dw RunNameEntryStateWhenNotFading_ReadNameEntryStep_Case06
    dw RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Case07

; name-entry state 0: draws the entry rectangle, sets wNameEntrySubState and reads the record
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
RunNameEntryStateWhenNotFading_Setup::
Jump_014_5CC1:: ; address name
    ld a, [wNameEntrySubState]
    rst $00
    dw RunNameEntryStateWhenNotFading_Setup_BGMapAddressAtScroll_Bank14_6BCF
    dw RunNameEntryStateWhenNotFading_Setup_WriteNameEntrySubStateAndArg5
    dw RunNameEntryStateWhenNotFading_Setup_DrawTileRectFromArg1Params
    dw RunNameEntryStateWhenNotFading_Setup_CopyArgs
    dw RunNameEntryStateWhenNotFading_Setup_WriteRAMG2AndRAMBEtc

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: hSpriteWindowClipMode, wNameEntrySubState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, hScrollY, ...
; points at: wNameEntryState
RunNameEntryStateWhenNotFading_Setup_BGMapAddressAtScroll_Bank14_6BCF::
Jump_014_5CCF:: ; address name
    ld hl, wNameEntryState
    ld bc, $001D

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    call BGMapAddressAtScroll_Bank14_6BCF
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
    xor a, a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hSpriteWindowClipMode]
    ld [wSavedSpriteClipMode], a
    ld a, $01
    ldh [hSpriteHideTile], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld de, Tiles2Plus710Tiles_1F_4910
    ld hl, vTiles2
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles_1F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7E0Tiles_1F_4A80
    ld hl, vTiles1 + $4C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_1F_4A90
    ld hl, vTiles1 + $4D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
; writes: wNameEntrySubState, wArg5
RunNameEntryStateWhenNotFading_Setup_WriteNameEntrySubStateAndArg5::
Jump_014_5D72:: ; address name
    ld hl, NameEntryTileDestList
    ld de, NameEntryTileSrcListA
    call RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryByteAC
    cp a, $FF
    jr nz, .clear_arg5
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a

.clear_arg5:
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wArg2, wNameEntrySubState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntrySubState
RunNameEntryStateWhenNotFading_Setup_DrawTileRectFromArg1Params::
Jump_014_5D8B:: ; address name
    ld a, [wArg2]
    push af
    call BGMapAddressAtScroll_Bank14_6BCF
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_6FE7
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0043
    add hl, de
    di
    call WaitForVRAMAccess
    pop af
    and a, $01
    add a, $CC
    ld [hl], a
    ei
    ld hl, $6F3E
    ld de, vTiles2 + $550
    call CopyTileBytesToVRAM_Bank14
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; copies the eight wArg bytes to wCounterPtr0Lo onward and picks a data table by wArg1
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1, wArg2, wIsCGB, wNameEntrySubState, wArg4, wArg5
; writes: wSpriteSlotCount, wOBJPaletteUploadRequest, wNameEntrySubState, wArg5, wArg1, wArg2, wArg3, wArg4
; points at: wArg1, wCounterPtr0Lo, wSpriteSlots, hTemp0
RunNameEntryStateWhenNotFading_Setup_CopyArgs::
Jump_014_5DE0:: ; address name
    ld hl, wArg1
    ld de, wCounterPtr0Lo
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wArg1]
    or a, a
    jr nz, .read_arg4
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data_5E9F
    ld a, [wArg2]
    or a, a
    jr z, .call_copy_bytes_de_from_hl_bank14
    ld hl, SpriteSlotsInit_14_5EAF

.call_copy_bytes_de_from_hl_bank14:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank14
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data_5E93
    ld a, [wArg2]
    or a, a
    jr z, .call_copy_bytes_de_from_hl_bank142
    ld hl, RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data_5E99

.call_copy_bytes_de_from_hl_bank142:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank14
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    jr .skip

.read_arg4:
    ld a, [wArg4]
    ld [wArg1], a
    ld a, [wArg5]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4

.skip:
    ld hl, wCounterPtr0Lo
    ld de, wArg1
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Setup_CopyArgs)
CopyBytesDEFromHL_Bank14::
Func_014_5E8C:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank14
    ret

; address loaded by RunNameEntryStateWhenNotFading_Setup_CopyArgs
RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data_5E93:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_5E93:: ; address name
    db $00, $00, $01, $04, $00, $80

; address loaded by RunNameEntryStateWhenNotFading_Setup_CopyArgs
RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data_5E99:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_5E99:: ; address name
    db $01, $00, $01, $01, $00, $80

; address loaded by RunNameEntryStateWhenNotFading_Setup_CopyArgs
RunNameEntryStateWhenNotFading_Setup_CopyArgs_Data_5E9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_5E9F:: ; address name
    db $00, $01, $00, $00, $08, $08, $04, $00, $00, $00, $00, $08, $08, $04, $00, $00

; E-0264 (derived: Func_014_5E8C copies these 16 bytes to wSpriteSlots)
; record: 16 bytes copied to wSpriteSlots
SpriteSlotsInit_14_5EAF::
Data_014_5EAF:: ; address name
    db $00, $01, $01, $00, $08, $08, $01, $00, $00, $00, $00, $08, $08, $04, $00, $00 ; entry 0

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1, wGridCursorX, wNameEntryState
; writes: rRAMG2, rRAMB, wNameEntryCursorX, wNameEntryCursorY, wNameEntrySubState, wNameEntryState, wArg5, wNameEntryLength
; points at: wPartyList, wNameEntryText
RunNameEntryStateWhenNotFading_Setup_WriteRAMG2AndRAMBEtc::
Jump_014_5EBF:: ; address name
    call RunNameEntryStateWhenNotFading_ClearNameEntryText
    ld a, [wArg1]
    and a, a
    jp z, .call_test_flag_bit
    cp a, $01
    jp z, .call_run_name_entry_state_when_not_fading
    cp a, $02
    jp z, .call_run_name_entry_state_when_not_fading
    ld hl, wPartyList
    ld a, [wGridCursorX]
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
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
    cp a, $F0
    jr z, .restore
    call RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop
    jr .clear_name_entry_cursor_x

.restore:
    pop bc
    pop hl

.clear_name_entry_cursor_x:
    xor a, a
    ld [wNameEntryCursorX], a
    ld [wNameEntryCursorY], a
    jr .call_run_name_entry_state_when_not_fading

.call_test_flag_bit:
    ld de, $0000
    call TestFlagBit
    jr c, .skip
    ld hl, wNameEntryText
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    ld a, $04
    ld [wNameEntryLength], a
    jr .call_run_name_entry_state_when_not_fading

.skip:
    ld hl, wNameEntryText
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a
    ld a, $04
    ld [wNameEntryLength], a

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    xor a, a
    ld [wNameEntrySubState], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
RunNameEntryStateWhenNotFading_ReadNameEntrySubState::
Jump_014_5F57:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntrySubState]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5Etc
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntryByteC3AndNameEntryLengthEtc
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntryStateAndArg5
    dw RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM
    dw RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5Etc
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntryByteC3AndNameEntryLengthEtc
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntryStateAndArg5
    dw RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNameEntrySubState, wNameEntryCursorX, wNameEntryCursorY
; writes: wNameEntryCursorX, wNameEntryCursorY, wArg5, wNameEntrySubState
RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC::
Jump_014_5F72:: ; address name
    call RunNameEntryStateWhenNotFading_WriteNameEntryByteBC
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, .call_draw_blank_tile_c3_6189
    bit 7, a
    jp nz, .call_draw_blank_tile_c3_61892
    bit 4, a
    jp nz, .call_draw_blank_tile_c3_61893
    bit 5, a
    jp nz, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallDrawBlankTileC3_6189
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallQueueSoundEffect
    bit 1, a
    jp nz, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallQueueSoundEffect2
    bit 3, a
    jp nz, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallQueueSoundEffect3
    call RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte
    ret

.call_draw_blank_tile_c3_6189:
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorY]
    and a, a
    jr nz, .set_name_entry_cursor_y
    ld a, $04
    ld [wNameEntryCursorY], a
    ld a, [wNameEntryCursorX]
    cp a, $06
    jr c, .call_run_name_entry_state_when_not_fading
    ld a, $0D
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading

.set_name_entry_cursor_y:
    dec a
    ld [wNameEntryCursorY], a

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c3_61892:
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr c, .cp_02
    xor a, a
    ld [wNameEntryCursorY], a
    jr .call_run_name_entry_state_when_not_fading2

.cp_02:
    cp a, $02
    jr nz, .cp_03
    ld a, [wNameEntryCursorX]
    cp a, $0D
    jr c, .check_name_entry_cursor_y
    ld a, $0D
    ld [wNameEntryCursorX], a
    jr .check_name_entry_cursor_y

.cp_03:
    cp a, $03
    jr nz, .check_name_entry_cursor_y
    ld a, [wNameEntryCursorX]
    cp a, $06
    jr c, .check_name_entry_cursor_y
    ld a, $0D
    ld [wNameEntryCursorX], a

.check_name_entry_cursor_y:
    ld a, [wNameEntryCursorY]
    inc a
    ld [wNameEntryCursorY], a

.call_run_name_entry_state_when_not_fading2:
    call RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c3_61893:
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorY]
    ld hl, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data
    add_a_to_hl
    ld b, [hl]
    ld a, [wNameEntryCursorX]
    cp a, b
    jr c, .check_name_entry_cursor_y2
    xor a, a
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading3

.check_name_entry_cursor_y2:
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr nz, .check_name_entry_cursor_x
    ld a, [wNameEntryCursorX]
    cp a, $05
    jr c, .check_name_entry_cursor_x
    ld a, $0D
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading3

.check_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    inc a
    ld [wNameEntryCursorX], a

.call_run_name_entry_state_when_not_fading3:
    call RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

; address loaded by RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC
RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_605E:: ; address name
    db $10, $10, $10, $0D, $0D

RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallDrawBlankTileC3_6189::
Jump_014_6063:: ; address name
    call DrawBlankTileC3_6189
    ld a, [wNameEntryCursorX]
    and a, a
    jr nz, .check_name_entry_cursor_y
    ld a, [wNameEntryCursorY]
    ld hl, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data
    add_a_to_hl
    ld a, [hl]
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading

.check_name_entry_cursor_y:
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr nz, .check_name_entry_cursor_x
    ld a, [wNameEntryCursorX]
    cp a, $0D
    jr c, .check_name_entry_cursor_x
    ld a, $05
    ld [wNameEntryCursorX], a
    jr .call_run_name_entry_state_when_not_fading

.check_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    dec a
    ld [wNameEntryCursorX], a

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallQueueSoundEffect::
Jump_014_60A6:: ; address name
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF
    ld a, [wNameEntrySubState]
    inc a
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallQueueSoundEffect2::
Jump_014_60BB:: ; address name
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC_Data_CallQueueSoundEffect3::
Jump_014_60CF:: ; address name
    ld a, $69
    call QueueSoundEffect
    call DrawBlankTileC3_6189
    ld a, $0D
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a
    xor a, a
    ld [wArg5], a
    ret

; on the last glyph of the name entry wCFAD adds or cycles the marks $8D and $8E when the glyph allows them (lists Data_014_688A and 68CA), with sound $69 (E-0129)
; no direct call (reached through a table, a jump or a vector)
; writes: wArg5
; points at: wNameEntryText
ToggleVoicingMarkOnNameEntry:: ; heuristic: follows a terminator; C0
Func_014_60E6:: ; address name
    call CopyTileForNameEntryLength
    ld hl, wNameEntryText

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .next
    cp a, $9F
    jr z, .next
    inc hl
    jr .skip

.next:
    dec hl
    ld a, [hl]
    cp a, $8E
    jr z, .skip7
    cp a, $8D
    jr z, .next2
    ld b, $8D
    push bc
    call IsHLByteInList688A
    pop bc
    cp a, $FF
    jr nz, .call_queue_sound_effect
    xor a, a
    ld [wArg5], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld hl, wNameEntryText

.skip2:
    ld a, [hl]
    cp a, $9F
    jr z, .skip4
    cp a, $F0
    jr z, .skip3
    inc hl
    jr .skip2

.skip3:
    ld a, b
    ld [hl], a
    xor a, a
    ld [wArg5], a
    ret

.skip4:
    ld a, b
    ld [hl], a
    ld hl, wNameEntryText

.skip5:
    ld a, [hl]
    cp a, $F0
    jr z, .skip6
    inc hl
    jr .skip5

.skip6:
    ld a, $9F
    ld [hl], a
    xor a, a
    ld [wArg5], a
    ret

.skip7:
    ld a, $9F
    ld [hl], a

.loop:
    ld a, [hl+]
    cp a, $F0
    jr nz, .loop
    dec hl
    dec hl
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [wArg5], a
    ret

.next2:
    dec hl
    ld b, $8E
    push bc
    call IsHLByteInList68CA
    pop bc
    cp a, $FF
    jr nz, .next3
    inc hl
    jp .skip7

.next3:
    inc hl
    ld a, $8E
    ld [hl], a
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

; only called from RunNameEntryStateWhenNotFading_Case01_Case00 (E-0047)
; 6 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC)
; reads: wNameEntryCursorByte, wNameEntryCursorY, wNameEntryCursorX
; writes: wNameEntryCursorByte
RunNameEntryStateWhenNotFading_Case01_Case00_WriteNameEntryCursorByte::
Func_014_6172:: ; address name
    ld a, [wNameEntryCursorByte]
    inc a
    ld [wNameEntryCursorByte], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, DrawBlankTileC3_6189
    xor a, a
    ld [wNameEntryCursorByte], a

.skip:
    ld b, $55
    jr RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryCursorY

; B = $C3 (blank tile) and joins the tile draw at RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryCursorY (E-0122)
; 7 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC)
; reads: wNameEntryCursorY, wNameEntryCursorX
DrawBlankTileC3_6189::
Func_014_6189:: ; address name
    ld b, $C3
    jr RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryCursorY

; only called from RunNameEntryStateWhenNotFading_Case01_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC)
; reads: wNameEntryCursorY, wNameEntryCursorX
RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF::
Func_014_618D:: ; address name
    ld b, $55

RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryCursorY::
Jump_014_618F:: ; address name
    ld a, [wNameEntryCursorY]
    ld hl, NameEntryKeyPositions
    cp a, $00
    jr z, .read_name_entry_cursor_x
    ld e, $22
    ld d, $00

.loop:
    add hl, de
    dec a
    jr nz, .loop

.read_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14_6BCF
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld a, [wNameEntryCursorX]
    cp a, $0D
    ret nz
    ld a, [wNameEntryCursorY]
    cp a, $04
    jr z, .call_wait_for_vram_access
    cp a, $03
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
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; E-0224 (C1: RunNameEntryStateWhenNotFading_Case01_Case00_Sub02 reads row $22 * wNameEntryCursorY from $61E2, then the word for wNameEntryCursorX; 5 rows).
; record: 17 position words (one per key column) for a keyboard row
NameEntryKeyPositions::
Data_014_61E2:: ; address name
    dw $0101, $0102, $0103, $0104, $0105, $0106, $0107, $0108, $0109, $010A, $010B, $010C, $010D, $010F, $0110, $0111, $0112 ; id 0
    dw $0141, $0142, $0143, $0144, $0145, $0146, $0147, $0148, $0149, $014A, $014B, $014C, $014D, $014F, $0150, $0151, $0152 ; id 1
    dw $0181, $0182, $0183, $0184, $0185, $0186, $0187, $0188, $0189, $018A, $018B, $018C, $018D, $018F, $0190, $0191, $0192 ; id 2
    dw $01C1, $01C2, $01C3, $01C4, $01C5, $01C6, $01C7, $01C8, $01C9, $01CA, $01CB, $01CC, $01CD, $01CF, $01D0, $01D1, $01D2 ; id 3
    dw $0201, $0202, $0203, $0204, $0205, $0206, $0207, $0208, $0209, $020A, $020B, $020C, $020D, $020F, $0210, $0211, $0212 ; id 4

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryLength, wNameEntrySubState, wNameEntryByteC3
; writes: wNameEntrySubState, wArg5, wNameEntryByteC3, wNameEntryLength
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5Etc::
Jump_014_628C:: ; address name
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wNameEntryLength]
    and a, a
    jr nz, .call_write_tile_b_at_scroll_offset47_plus
    call RunNameEntryStateWhenNotFading_ClearNameEntryText
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

.call_write_tile_b_at_scroll_offset47_plus:
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld hl, wNameEntryText

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .next
    cp a, $9F
    jr z, .next
    inc hl
    jr .skip

.next:
    dec hl
    ld a, [hl]
    cp a, $8D
    jr z, .skip2
    cp a, $8E
    jr z, .skip2
    jr .call_copy_tile_for_name_entry_length

.skip2:
    ld a, $9F
    ld [hl-], a
    ld a, $9F
    ld [hl], a
    ld hl, wNameEntryText

.skip3:
    ld a, [hl]
    cp a, $F0
    jr z, .next2
    inc hl
    jr .skip3

.next2:
    dec hl
    ld a, $F0
    ld [hl], a
    jr .call_copy_tile_for_name_entry_length2

.call_copy_tile_for_name_entry_length:
    ld a, $9F
    ld [hl-], a

.call_copy_tile_for_name_entry_length2:
    call CopyTileForNameEntryLength
    ld a, [wNameEntryByteC3]
    and a, a
    jr z, .check_name_entry_length
    xor a, a
    ld [wNameEntryByteC3], a
    jr .check_name_entry_sub_state

.check_name_entry_length:
    ld a, [wNameEntryLength]
    dec a
    ld [wNameEntryLength], a

.check_name_entry_sub_state:
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryCursorY, wNameEntryCursorX, wNameEntryLength, wNameEntrySubState, wNameEntryByteC3, wNameEntryState
; writes: wNameEntryByteC3, wNameEntryLength, wNameEntrySubState, wArg5, wNameEntryCursorX, wNameEntryCursorY, wNameEntryState
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case01_WriteNameEntryByteC3AndNameEntryLengthEtc::
Jump_014_6302:: ; address name
    ld a, [wNameEntryCursorY]
    ld hl, NameEntryKeyboard
    cp a, $00
    jr z, .read_name_entry_cursor_x
    ld e, $11
    ld d, $00

.loop:
    add hl, de
    dec a
    jr nz, .loop

.read_name_entry_cursor_x:
    ld a, [wNameEntryCursorX]
    add a, l
    ld l, a
    jr nc, RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter
    inc h

; handles the chosen entry: $FD, $FE and $FF are commands; otherwise appends the character to wNameEntryText, with the dakuten marks $8D/$8E
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Setup_WriteRAMG2AndRAMBEtc)
; reads: wNameEntryLength, wNameEntrySubState, wNameEntryByteC3, wNameEntryState
; writes: wNameEntryByteC3, wNameEntryLength, wNameEntrySubState, wArg5, wNameEntryCursorX, wNameEntryCursorY, wNameEntryState
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter::
Func_014_631C:: ; address name
    ld a, [hl]
    cp a, $FD
    jp z, .check_name_entry_sub_state
    cp a, $FE
    jp z, .check_name_entry_sub_state2
    cp a, $FF
    jp z, .check_name_entry_length2
    push af
    ld hl, wNameEntryText

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .restore
    cp a, $9F
    jr z, .restore
    inc hl
    jr .skip

.restore:
    pop af
    cp a, $8D
    jr z, .next2
    cp a, $8E
    jr z, .next2
    push af
    ld a, [wNameEntryLength]
    cp a, $04
    jr nz, .restore2
    ld a, $01
    ld [wNameEntryByteC3], a
    dec hl
    ld a, [hl]
    cp a, $8D
    jr z, .next
    cp a, $8E
    jr z, .next
    inc hl
    ld a, [hl]
    cp a, $9F
    jr z, .restore2
    dec hl
    jr .restore2

.next:
    inc hl
    ld a, [hl-]
    cp a, $9F
    jr nz, .skip2
    inc hl
    inc hl

.skip2:
    ld a, $F0
    ld [hl], a
    dec hl

.restore2:
    pop af
    ld [hl+], a
    jr .call_write_tile_b_at_scroll_offset47_plus

.next2:
    dec hl
    push af
    ld a, [hl]
    cp a, $8D
    jp z, .restore4
    cp a, $8E
    jp z, .restore5
    pop af
    push af
    cp a, $8D
    jr z, .call_is_hl_byte_in_list688_a
    call IsHLByteInList68CA
    cp a, $FF
    jp z, .loop3
    jr .restore3

.call_is_hl_byte_in_list688_a:
    call IsHLByteInList688A
    cp a, $FF
    jp z, .loop3

.restore3:
    pop af
    inc hl
    ld [hl], a
    ld a, [wNameEntryLength]
    cp a, $04
    jr z, .check_name_entry_byte_c3

.loop:
    ld b, $F0
    jr .skip3

.check_name_entry_byte_c3:
    ld a, [wNameEntryByteC3]
    and a, a
    jr z, .loop
    ld b, $9F

.skip3:
    ld hl, wNameEntryText
    ld c, $00

.skip4:
    ld a, [hl]
    cp a, b
    jr z, .skip5
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr z, .set_name_entry_byte_c3_to_01
    jr .skip4

.skip5:
    ld a, $9F
    ld [hl], a
    jr .loop2

.set_name_entry_byte_c3_to_01:
    ld a, $01
    ld [wNameEntryByteC3], a
    jr .check_name_entry_length

.call_write_tile_b_at_scroll_offset47_plus:
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld a, [wNameEntryLength]
    cp a, $04
    jr nc, .call_draw_blank_tile_c3_6189
    ld a, [wNameEntryLength]
    inc a
    ld [wNameEntryLength], a
    jr .loop2

.call_draw_blank_tile_c3_6189:
    call DrawBlankTileC3_6189
    ld a, $0D
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a

.loop2:
    ld a, [wNameEntrySubState]
    dec a
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

.loop3:
    pop af

.check_name_entry_length:
    ld a, [wNameEntryLength]
    cp a, $04
    jr c, .loop2
    ld a, [wNameEntryByteC3]
    and a, a
    jr z, .loop2
    call DrawBlankTileC3_6189
    ld a, $0D
    ld [wNameEntryCursorX], a
    ld a, $04
    ld [wNameEntryCursorY], a
    jr .loop2

.restore4:
    pop af
    push af
    cp a, $8D
    jr z, .loop3
    dec hl
    call IsHLByteInList68CA
    cp a, $FF
    jr z, .loop3
    inc hl
    ld a, $8E
    ld [hl], a
    call CopyTileForNameEntryLength
    jr .loop3

.restore5:
    pop af
    push af
    cp a, $8E
    jr z, .loop3
    ld a, $8D
    ld [hl], a
    call CopyTileForNameEntryLength
    jr .loop3

.check_name_entry_sub_state:
    ld a, [wNameEntrySubState]
    inc a
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

.check_name_entry_sub_state2:
    ld a, [wNameEntrySubState]
    dec a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

.check_name_entry_length2:
    ld a, [wNameEntryLength]
    and a, a
    jr z, .check_name_entry_sub_state3
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

.check_name_entry_sub_state3:
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wNameEntryState, wArg5
RunNameEntryStateWhenNotFading_Case01_WriteNameEntryStateAndArg5::
Jump_014_6476:: ; address name
    call RunNameEntryStateWhenNotFading_Case01_Case03_CheckArg1
    call RunNameEntryStateWhenNotFading_WriteNameEntryByteBC
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
; writes: wNameEntrySubState, wArg5
RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM::
Jump_014_6488:: ; address name
    ld hl, NameEntryTileDestListEmpty
    ld de, NameEntryTileSrcListB
    call RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryByteAC
    cp a, $FF
    jr nz, .clear_arg5
    ld a, [wNameEntrySubState]
    inc a
    ld [wNameEntrySubState], a
    ld de, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM_Data
    ld hl, vTiles2 + $480
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM

.clear_arg5:
    xor a, a
    ld [wArg5], a
    ret

; entry 9 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wNameEntrySubState, wArg5
RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5::
Jump_014_64AE:: ; address name
    ld hl, NameEntryTileDestListEmpty
    ld de, NameEntryTileSrcListA
    call RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryByteAC
    cp a, $FF
    jr nz, .clear_arg5
    xor a, a
    ld [wNameEntrySubState], a

.clear_arg5:
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
RunNameEntryStateWhenNotFading_ReadNameEntryStep::
Jump_014_64C4:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntryStep]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case02_FillTilesFromRequest
    dw RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params
    dw RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params_Case02
    dw RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params_Case03

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameEntryStep, wArg5
RunNameEntryStateWhenNotFading_Case02_FillTilesFromRequest::
Jump_014_64D3:: ; address name
    ld hl, vTiles2 + $5C0
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
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep
RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params::
Jump_014_64F8:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01E0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params_Data
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $01
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep
RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params_Case02::
Jump_014_6532:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01C0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_71B3
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $03
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep, ...
RunNameEntryStateWhenNotFading_Case02_DrawTileRectFromArg1Params_Case03::
Jump_014_656C:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $01A0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_714F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $05
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    xor a, a
    ld [wNameEntryStep], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
RunNameEntryStateWhenNotFading_ReadNameEntryStep_Case03::
Jump_014_65AA:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntryStep]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5
    dw RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc
    dw RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5_Case02
    dw RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5_Case03
    dw RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc_Case04
    dw RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc_Case05

; entry 5 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wStringCategory, wStringIndex, wNameEntryState, wNameEntryMenuCursor, wArg5
RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc_Case05::
Jump_014_65BD:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_FillTilesFromRequest
    cp a, $FF
    ret nz
    ld a, [wNameEntryState]
    add a, $04
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wArg1, wNameEntryStep
; writes: wNameEntryStep, wArg5
RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5::
Jump_014_65DC:: ; address name
    ld a, [wArg1]
    and a, a
    jp z, .call_run_name_entry_state_when_not_fading2
    call RunNameEntryStateWhenNotFading_Case03_Case00_ReadArg1
    cp a, $FF
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_ScanNameEntryText
    cp a, $FF
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_Case03_Case00_WriteRAMG2AndRAMB
    cp a, $FF
    jr nz, .call_run_name_entry_state_when_not_fading
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

.call_run_name_entry_state_when_not_fading:
    call RunNameEntryStateWhenNotFading_Case03_Case00_ReadArg1
    cp a, $FF
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_ScanNameEntryText
    cp a, $FF
    jr z, .read_name_entry_step
    ld a, [wNameEntryStep]
    add a, $03
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

.call_run_name_entry_state_when_not_fading2:
    call RunNameEntryStateWhenNotFading_Case03_Case00_ReadArg1
    cp a, $FF
    jr z, .read_name_entry_step
    call RunNameEntryStateWhenNotFading_ScanNameEntryText
    cp a, $FF
    jr z, .read_name_entry_step
    ld a, [wNameEntryStep]
    inc a
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

.read_name_entry_step:
    ld a, [wNameEntryStep]
    add a, $05
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 1 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wStringCategory, wStringIndex, wNameEntryStep, wArg5
RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc::
Jump_014_6647:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_FillTilesFromRequest
    cp a, $FF
    jr nz, .clear_arg5
    ld a, [wNameEntryStep]
    inc a
    inc a
    ld [wNameEntryStep], a

.clear_arg5:
    xor a, a
    ld [wArg5], a
    ret

; entry 2 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wNameEntryStep, wArg5
; points at: wTextBuf0, wNameEntryText
RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5_Case02::
Jump_014_6664:: ; address name
    ld de, wTextBuf0
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    jp RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5_Case03

; entry 3 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wNameEntryStep, wArg5
; points at: wNameEntryText, wTextBuf0
RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5_Case03::
Jump_014_6671:: ; address name
    ld hl, wNameEntryText
    ld de, wTextBuf0

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .check_name_entry_step
    cp a, $9F
    jr z, .check_name_entry_step
    ld [de], a
    inc hl
    inc de
    jr .skip

.check_name_entry_step:
    ld a, $F0
    ld [de], a
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wStringCategory, wStringIndex, wNameEntryStep, wNameEntryState, wArg5
RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc_Case04::
Jump_014_6694:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    call RunNameEntryStateWhenNotFading_FillTilesFromRequest
    cp a, $FF
    ret nz
    xor a, a
    ld [wNameEntryStep], a
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wArg5], a
    ret

; entry 4 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryState
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params::
Jump_014_66B1:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $010E
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_71EF
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $05
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wArg5], a
    ret

; entry 5 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryMenuCursor, wNameEntryState
; writes: wNameEntryState, wNameEntryMenuCursor, wArg5
RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc::
Jump_014_66F3:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    call RunNameEntryStateWhenNotFading_Case05_BlinkCursorNameEntryBlink_Bank14
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_name_entry_menu_cursor
    ret

.loop:
    ld a, [wNameEntryState]
    inc a
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

.check_name_entry_menu_cursor:
    ld a, [wNameEntryMenuCursor]
    and a, a
    jr nz, .loop
    ld a, [wNameEntryState]
    inc a
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryMenuCursor], a
    ld [wArg5], a
    ret

; entry 6 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
RunNameEntryStateWhenNotFading_ReadNameEntryStep_Case06::
Jump_014_6729:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    ld a, [wNameEntryStep]
    rst $00
    dw RunNameEntryStateWhenNotFading_Case06_FillTileRectWithArg1Tile
    dw RunNameEntryStateWhenNotFading_FinishNameEntry

; entry 0 of the `rst $00` table in RunNameEntryStateWhenNotFading_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntryStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryStep
RunNameEntryStateWhenNotFading_Case06_FillTileRectWithArg1Tile::
Jump_014_6734:: ; address name
    call BGMapAddressAtScroll_Bank14_6BCF
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
    xor a, a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    ld a, [wNameEntryStep]
    inc a
    ld [wNameEntryStep], a
    xor a, a
    ld [wArg5], a
    ret

; copies the entered name to wNameGlyphBuf (ending in $F0), clears the name-entry state and sets the text window
; no direct call (reached through a table, a jump or a vector)
; reads: wSavedSpriteClipMode
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, hSpriteHideTile, wArg5
; points at: wNameEntryText, wNameGlyphBuf, wNameEntryState
RunNameEntryStateWhenNotFading_FinishNameEntry::
Jump_014_676A:: ; address name
    ld hl, wNameEntryText
    ld de, wNameGlyphBuf

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .skip2
    cp a, $9F
    jr z, .skip2
    ld [de], a
    inc hl
    inc de
    jr .skip

.skip2:
    ld a, $F0
    ld [de], a
    ld hl, wNameEntryState
    ld bc, $001D

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
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
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wSavedSpriteClipMode]
    ld a, $FF
    ld [wArg5], a
    ret

; entry 7 of the `rst $00` table in RunNameEntryStateWhenNotFading
; no direct call (reached through a table, a jump or a vector)
; reads: wNameEntrySubState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wNameEntryState, ...
RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Case07::
Jump_014_67B0:: ; address name
    call RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc
    call BGMapAddressAtScroll_Bank14_6BCF
    ld de, $0100
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Case07_Data
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $0A
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ld a, $01
    ld [wNameEntryState], a
    xor a, a
    ld [wNameEntryStep], a
    ld a, [wNameEntrySubState]
    cp a, $04
    jr nc, .set_name_entry_sub_state_to_05
    xor a, a
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

.set_name_entry_sub_state_to_05:
    ld a, $05
    ld [wNameEntrySubState], a
    xor a, a
    ld [wArg5], a
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 8 call sites from 8 routines (e.g. RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Case07, RunNameEntryStateWhenNotFading_ReadNameEntryStep_Case06, RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params, ...)
; reads: wArg1, wArg4, wArg5
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
; points at: wArg1, wCounterPtr0Lo
RunNameEntryStateWhenNotFading_WriteArg1AndArg2Etc::
Func_014_6804:: ; address name
    ld hl, wArg1
    ld de, wCounterPtr0Lo
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [wArg1]
    or a, a
    jr nz, .read_arg4
    farcall UpdateAndDrawSpriteSlots
    jr .skip

.read_arg4:
    ld a, [wArg4]
    ld [wArg1], a
    ld a, [wArg5]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $10
    ld [wArg4], a
    ld a, $18
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $00
    farcall DrawMetaSpritePartC0

.skip:
    ld hl, wCounterPtr0Lo
    ld de, wArg1
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ret

; A = 0 when [HL] is in the $FF-terminated list Data_014_688A, else $FF (E-0124)
; 2 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter, ToggleVoicingMarkOnNameEntry)
IsHLByteInList688A::
Func_014_6875:: ; address name
    ld de, IsHLByteInList688A_Data

.skip:
    ld a, [de]
    cp a, $FF
    jr z, .return_FF
    ld b, a
    ld a, [hl]
    cp a, b
    jr z, .return_0
    inc de
    jr .skip

.return_0:
    xor a, a
    ret

.return_FF:
    ld a, $FF
    ret

; address loaded by IsHLByteInList688A
IsHLByteInList688A_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_688A:: ; address name
    db $3E, $3F, $40, $41, $42, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33
    db $34, $35, $37, $38, $75, $76, $77, $78, $79, $60, $61, $62, $63, $64, $65, $66
    db $67, $68, $69, $6A, $6B, $6C, $6E, $6F, $26, $5A, $FF

; A = 0 when [HL] is in the $FF-terminated list Data_014_68CA, else $FF (E-0124)
; 3 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter, ToggleVoicingMarkOnNameEntry)
IsHLByteInList68CA::
Func_014_68B5:: ; address name
    ld de, IsHLByteInList68CA_Data

.skip:
    ld a, [de]
    cp a, $FF
    jr z, .return_FF
    ld b, a
    ld a, [hl]
    cp a, b
    jr z, .return_0
    inc de
    jr .skip

.return_0:
    xor a, a
    ret

.return_FF:
    ld a, $FF
    ret

; address loaded by IsHLByteInList68CA
IsHLByteInList68CA_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_68CA:: ; address name
    db $3E, $3F, $40, $41, $42, $75, $76, $77, $78, $79, $FF

; only called from RunNameEntryStateWhenNotFading_Case05 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_WriteNameEntryStateAndNameEntryMenuCursorEtc)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNameEntryMenuCursor
; writes: wMenuInputResult, wNameEntryMenuCursor, wNameEntryBlink
RunNameEntryStateWhenNotFading_Case05_BlinkCursorNameEntryBlink_Bank14::
Func_014_68D5:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_695_a
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_695_a2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call BlinkCursorNameEntryBlink_Bank14
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_695_a:
    call DrawBlankTileC3_695A
    ld a, [wNameEntryMenuCursor]
    and a, a
    jr nz, .set_name_entry_menu_cursor
    ld a, $01
    ld [wNameEntryMenuCursor], a
    jr .clear_name_entry_blink

.set_name_entry_menu_cursor:
    dec a
    ld [wNameEntryMenuCursor], a
    jr .clear_name_entry_blink

.call_draw_blank_tile_c3_695_a2:
    call DrawBlankTileC3_695A
    ld a, [wNameEntryMenuCursor]
    cp a, $01
    jr c, .set_name_entry_menu_cursor2
    xor a, a
    ld [wNameEntryMenuCursor], a
    jr .clear_name_entry_blink

.set_name_entry_menu_cursor2:
    inc a
    ld [wNameEntryMenuCursor], a

.clear_name_entry_blink:
    xor a, a
    ld [wNameEntryBlink], a
    call BlinkCursorNameEntryBlink_Bank14
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; cycles wCFBE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05_BlinkCursorNameEntryBlink_Bank14)
; reads: wNameEntryBlink, wNameEntryMenuCursor
; writes: wNameEntryBlink
BlinkCursorNameEntryBlink_Bank14::
Func_014_6943:: ; address name
    ld a, [wNameEntryBlink]
    inc a
    ld [wNameEntryBlink], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, DrawBlankTileC3_695A
    xor a, a
    ld [wNameEntryBlink], a

.skip:
    ld b, $BB
    jr RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryMenuCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05_BlinkCursorNameEntryBlink_Bank14)
; reads: wNameEntryMenuCursor
DrawBlankTileC3_695A::
Func_014_695A:: ; address name
    ld b, $C3
    jr RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryMenuCursor

; only called from RunNameEntryStateWhenNotFading_Case05_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case05_BlinkCursorNameEntryBlink_Bank14)
; reads: wNameEntryMenuCursor
RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF::
Func_014_695E:: ; address name
    ld b, $BC

RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF_ReadNameEntryMenuCursor::
Jump_014_6960:: ; address name
    ld a, [wNameEntryMenuCursor]
    add a, a
    ld hl, RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank14_6BCF
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF
RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_697D:: ; address name
    db $2F, $01, $6F, $01

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. CopyTileForNameEntryLength, RunNameEntryStateWhenNotFading_Setup_DrawTileRectFromArg1Params)
; reads: rSTAT
CopyTileBytesToVRAM_Bank14::
Func_014_6981:: ; address name
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 2 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Case01_WriteNameEntryStateAndArg5, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC)
; writes: wNameEntryByteBC
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_WriteNameEntryByteBC::
Func_014_6992:: ; address name
    ld hl, wNameEntryText
    ld bc, $0000

.skip:
    ld a, [hl]
    cp a, $F0
    ret z
    ld [wNameEntryByteBC], a
    push hl
    ld hl, $4010
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
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
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    pop hl
    inc hl
    ld a, $10
    add a, c
    ld c, a
    jr nc, .skip2
    inc b

.skip2:
    jp .skip
    db $40, $95, $30, $95, $20, $95, $10, $95, $00, $95, $D9, $69, $AD, $CF, $D5, $FA
    db $2D, $C5, $EA, $31, $C5, $EA, $35, $C5, $FA, $2E, $C5, $EA, $32, $C5, $EA, $36
    db $C5, $D1, $CD, $40, $2E, $7B, $EA, $33, $C5, $EA, $37, $C5, $7A, $EA, $34, $C5
    db $EA, $38, $C5, $3E, $01, $EA, $2B, $C5, $AF, $EA, $2C, $C5, $EA, $4F, $C5, $C9

; writes B at the BG map entry BGMapAddressAtScroll + $47 (row 2, column 7 of the view) + wCFC2, with interrupts off after rSTAT bit 1 clears; BC kept (E-0079)
; 6 call sites from 4 routines (e.g. RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter, CopyF0StringAndRedrawNameEntry, RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5Etc, RunNameEntryStateWhenNotFading_Case01_CallWriteNameEntryByteBC)
; reads: wNameEntryLength, rSTAT
WriteTileBAtScrollOffset47PlusNameEntryLength::
Func_014_6A0D:: ; address name
    push bc
    call BGMapAddressAtScroll_Bank14_6BCF
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

; fills wNameEntryText with eleven $F0 bytes, then five $9F cursor marks
; 2 call sites from 2 routines (e.g. RunNameEntryStateWhenNotFading_Setup_WriteRAMG2AndRAMBEtc, RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5Etc)
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_ClearNameEntryText::
Func_014_6A28:: ; address name
    ld hl, wNameEntryText
    ld c, $00

.loop:
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0B
    jr c, .loop
    ld hl, wNameEntryText
    ld c, $00

.loop2:
    ld a, $9F
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, .loop2
    ret

; only called from RunNameEntryStateWhenNotFading_Case03_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5)
; reads: wArg1, wGridCursorX
; writes: rRAMG2, rRAMB
; points at: sRecords, wNameEntryText, wPartyList
RunNameEntryStateWhenNotFading_Case03_Case00_WriteRAMG2AndRAMB::
Func_014_6A45:: ; address name
    ld hl, sRecords
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .skip3
    push bc
    push hl
    inc hl
    ld de, wNameEntryText
    ld c, $00
    ld b, $00

.skip:
    ld a, [de]
    cp a, $9F
    jr nz, .skip2
    inc de
    jr .skip

.skip2:
    ld a, [de]
    cp a, $F0
    jr z, .skip4
    push bc
    ld b, a
    ld a, [hl]
    cp a, b
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
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1E
    jr c, .loop
    xor a, a
    ret

.skip4:
    ld a, c
    cp a, $0A
    jr z, .check_arg1
    ld a, [hl]
    cp a, $F0
    jr nz, .loop2

.check_arg1:
    ld a, [wArg1]
    cp a, $03
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
    cp a, e
    jr z, .loop2

.restore2:
    pop hl
    pop bc
    ld a, $FF
    ret

; only called from RunNameEntryStateWhenNotFading_Case03_Case00 (E-0047)
; 3 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5)
; reads: wArg1
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case03_Case00_ReadArg1::
Func_014_6AB7:: ; address name
    ld hl, RejectedNameList
    ld c, $00

.skip:
    ld a, [hl]
    cp a, $FF
    jr z, .return_0
    push bc
    push hl
    ld de, wNameEntryText
    ld c, $00
    ld b, $00

.skip2:
    ld a, [de]
    cp a, $9F
    jr nz, .skip3
    inc de
    jr .skip2

.skip3:
    ld a, [de]
    cp a, $F0
    jr z, .skip4
    push bc
    ld b, a
    ld a, [hl]
    cp a, b
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
    ld a, $0A
    add_a_to_hl
    jr .skip

.return_0:
    xor a, a
    ret

.skip4:
    ld a, c
    cp a, $0A
    jr z, .check_arg1
    ld a, [hl]
    cp a, $F0
    jr nz, .loop

.check_arg1:
    ld a, [wArg1]
    cp a, $03
    jr nz, .restore2

.restore2:
    pop hl
    pop bc
    ld a, $FF
    ret

; walks wNameEntryText to the $9F or $F0 end, tracking dakuten marks ($8D/$8E)
; 3 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case03_WriteNameEntryStepAndArg5)
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_ScanNameEntryText::
Func_014_6B08:: ; address name
    ld hl, wNameEntryText
    ld c, $00
    ld b, [hl]
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, .skip
    cp a, $8E
    jr z, .skip
    xor a, a
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
    cp a, $9F
    jr z, .next3
    cp a, $F0
    jr z, .skip5
    ld a, e
    and a, a
    jr z, .skip3
    ld a, [hl]
    cp a, $8D
    jr z, .skip4
    cp a, $8E
    jr z, .skip4
    ld a, [hl]
    cp a, b
    jr nz, .return_0
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, .next3
    cp a, $8E
    jr z, .next3
    jr .return_0

.skip3:
    ld a, [hl]
    cp a, b
    jr nz, .return_0
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, .next3
    cp a, $8E
    jr z, .next3
    jr .next2

.skip4:
    cp a, d
    jr nz, .return_0

.next2:
    inc c
    ld a, c
    cp a, $03
    jr nc, .skip5

.next3:
    inc hl
    jr .skip2

.skip5:
    ld a, c
    cp a, $03
    jr c, .skip6
    ld a, $FF
    ret

.skip6:
    ld a, b
    cp a, $90
    jr nz, .return_0
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 3 call sites from 3 routines (e.g. RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc_Case05, RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc_Case04, RunNameEntryStateWhenNotFading_Case03_WriteStringCategoryAndStringIndexEtc)
; reads: wNameEntryByteC4, wTextFlags, wArg1
; writes: wNameEntryByteC4, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunNameEntryStateWhenNotFading_FillTilesFromRequest::
Func_014_6B76:: ; address name
    ld a, [wNameEntryByteC4]
    and a, a
    jr z, .set_text_window_tile_lo
    cp a, $01
    jr z, .check_arg1
    jr .check_text_flags

.set_text_window_tile_lo:
    ld hl, vTiles2 + $5C0
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
    ld a, [wNameEntryByteC4]
    inc a
    ld [wNameEntryByteC4], a
    xor a, a
    ret

.check_arg1:
    ld a, [wArg1]
    cp a, $03
    jr z, .call_begin_string_display
    ld de, RunNameEntryStateWhenNotFading_FillTilesFromRequest_Data
    jr .call_begin_string_display2

.call_begin_string_display:
    ld de, StringCategories_14_706D

.call_begin_string_display2:
    call BeginStringDisplay
    ld a, [wNameEntryByteC4]
    inc a
    ld [wNameEntryByteC4], a
    xor a, a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    bit 0, a
    jr nz, .return_0
    xor a, a
    ld [wNameEntryByteC4], a
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 41 bytes appear in 3 banks)
; 12 call sites from 11 routines (e.g. RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params_Case07, RunNameEntryStateWhenNotFading_Case05_Sub01_BGMapAddressAtScroll_Bank14_6BCF, RunNameEntryStateWhenNotFading_DrawTileRectFromArg1Params, RunNameEntryStateWhenNotFading_Case01_Case00_BGMapAddressAtScroll_Bank14_6BCF, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank14_6BCF::
Func_014_6BCF:: ; address name
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
    jr nc, .skip
    inc d

.skip:
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

; only called from routines of RunNameEntryStateWhenNotFading (E-0098)
; 3 call sites from 3 routines (e.g. RunNameEntryStateWhenNotFading_Setup_WriteNameEntrySubStateAndArg5, RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5, RunNameEntryStateWhenNotFading_Case01_OrFromBankWaitVRAM)
; reads: wNameEntryTimer
; writes: wNameEntryTimer, wNameEntryByteAC
RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryByteAC::
Func_014_6BF8:: ; address name
    push hl
    push de
    ld a, [wNameEntryTimer]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, .restore
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wNameEntryTimer]
    add a, a
    add a, e
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
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wNameEntryTimer]
    inc a
    ld [wNameEntryTimer], a
    jr RunNameEntryStateWhenNotFading_WriteNameEntryTimerAndNameEntryByteAC

.restore:
    pop de
    pop hl
    xor a, a
    ld [wNameEntryTimer], a
    ld [wNameEntryByteAC], a
    ld a, $FF
    ret

; copies the 16-byte tile at Data_014_6C60 to the VRAM address from the word table Data_014_6C56 + 2 * wCFC2 (CopyTileBytesToVRAM_Bank14) (E-0119)
; 4 call sites from 3 routines (e.g. RunNameEntryStateWhenNotFading_Setup_ApplyChosenCharacter, RunNameEntryStateWhenNotFading_Case01_WriteNameEntrySubStateAndArg5Etc, ToggleVoicingMarkOnNameEntry)
; reads: wNameEntryLength
CopyTileForNameEntryLength::
Func_014_6C3F:: ; address name
    ld hl, CopyTileForNameEntryLength_Data_6C56
    ld a, [wNameEntryLength]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld de, CopyTileForNameEntryLength_Data_6C60
    call CopyTileBytesToVRAM_Bank14
    ret

; address loaded by CopyTileForNameEntryLength
CopyTileForNameEntryLength_Data_6C56:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_6C56:: ; address name
    db $00, $95, $10, $95, $20, $95, $30, $95, $40, $95

; address loaded by CopyTileForNameEntryLength
CopyTileForNameEntryLength_Data_6C60:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_6C60:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; only called from RunNameEntryStateWhenNotFading_Case01_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_WriteNameEntryStateAndArg5)
; reads: wArg1, wRandomLo, wArg3, wArg2
; writes: wNameEntryLength, wNameEntryByteC3
; points at: wNameEntryText
RunNameEntryStateWhenNotFading_Case01_Case03_CheckArg1::
Func_014_6C70:: ; address name
    ld a, [wArg1]
    or a, a
    jp z, CopyF0StringAndRedrawNameEntry_CheckArg2
    ld a, [wRandomLo]
    ld b, a

.skip:
    ld a, b
    cp a, $4D
    jr c, .skip2
    sub a, $4D
    ld b, a
    jr .skip

.skip2:
    and a, $7F
    cp a, $07
    jp nc, .skip4
    ld b, a
    ld hl, DefaultMonsterNameTable
    ld a, [wArg3]
    and a, $0F
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wArg2]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ld a, [wArg2]
    add a, a
    add a, a
    add a, c
    ld c, a
    ld a, b
    add a, c
    add a, a
    add a, e
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
    sub a, $07
    ld b, a
    push bc
    ld a, [wArg2]
    and a, $01
    ld c, $46
    call Multiply8
    pop bc
    ld a, b
    add a, l
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

; copies the $F0-terminated string at HL to DE, then erases the name-entry cursor tile and redraws wNameEntryText glyph by glyph (handling the $9F cursor end and the $8D/$8E voicing marks) (E-0175)
; 2 call sites from 1 routine (e.g. RunNameEntryStateWhenNotFading_Case01_Case03_CheckArg1)
; writes: wNameEntryLength, wNameEntryByteC3
; points at: wNameEntryText
CopyF0StringAndRedrawNameEntry::
Func_014_6CEA:: ; address name
    ld a, [hl]
    cp a, $F0
    jr z, CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL
    ld [de], a
    inc de
    inc hl
    jr CopyF0StringAndRedrawNameEntry

CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL::
Jump_014_6CF4:: ; address name
    ld b, $C3
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ld hl, wNameEntryText
    ld c, $00

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .set_name_entry_byte_c3_to_01
    cp a, $9F
    jr z, .skip2
    cp a, $8D
    jr z, .next
    cp a, $8E
    jr z, .next
    inc c

.next:
    inc hl
    jr .skip

.set_name_entry_byte_c3_to_01:
    ld a, $01
    ld [wNameEntryByteC3], a

.skip2:
    ld a, c
    cp a, $05
    jr c, .set_name_entry_length
    ld a, $04

.set_name_entry_length:
    ld [wNameEntryLength], a
    ld b, $55
    call WriteTileBAtScrollOffset47PlusNameEntryLength
    ret

CopyF0StringAndRedrawNameEntry_CheckArg2::
Jump_014_6D28:: ; address name
    ld a, [wArg2]
    or a, a
    jr nz, .skip
    ld hl, wNameEntryText
    ld hl, wNameEntryText
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    jr .skip2

.skip:
    ld hl, wNameEntryText
    ld hl, wNameEntryText
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a

.skip2:
    jr CopyF0StringAndRedrawNameEntry_CallWriteTileBAtScrollOffset47PlusNameEntryL

; E-0224 (C1: RunNameEntryStateWhenNotFading_Shared05 copies 16 bytes from bank $1F for each destination word (until a low byte of $FF) from the parallel source list in DE; CloseHibernateMenu_Case01 also passes $6D84, entry 23 of this list, to LoadTileListSixPerCall).
; record: 79 VRAM destinations, then $FFFF
NameEntryTileDestList::
Data_014_6D56:: ; address name
    dw vTiles2 + $20, vTiles2 + $30, vTiles2 + $40, vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90 ; entry 0
    dw vTiles2 + $A0, vTiles2 + $B0, vTiles2 + $C0, vTiles2 + $D0, vTiles2 + $E0, vTiles2 + $F0, vTiles2 + $100, vTiles2 + $110
    dw vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150, vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190
    dw vTiles2 + $1A0, vTiles2 + $1B0, vTiles2 + $1C0, vTiles2 + $1D0, vTiles2 + $1E0, vTiles2 + $1F0, vTiles2 + $200, vTiles2 + $210
    dw vTiles2 + $220, vTiles2 + $230, vTiles2 + $240, vTiles2 + $250, vTiles2 + $260, vTiles2 + $270, vTiles2 + $280, vTiles2 + $290
    dw vTiles2 + $2A0, vTiles2 + $2B0, vTiles2 + $2C0, vTiles2 + $2D0, vTiles2 + $2E0, vTiles2 + $2F0, vTiles2 + $300, vTiles2 + $310
    dw vTiles2 + $320, vTiles2 + $330, vTiles2 + $340, vTiles2 + $350, vTiles2 + $360, vTiles2 + $370, vTiles2 + $380, vTiles2 + $390
    dw vTiles2 + $3A0, vTiles2 + $3B0, vTiles2 + $3C0, vTiles2 + $3D0, vTiles2 + $3E0, vTiles2 + $3F0, vTiles2 + $400, vTiles2 + $410
    dw vTiles2 + $420, vTiles2 + $430, vTiles2 + $440, vTiles2 + $450, vTiles2 + $460, vTiles2 + $470, vTiles2 + $480, vTiles2 + $490
    dw vTiles2 + $4A0, vTiles2 + $4B0, vTiles2 + $500, vTiles2 + $510, vTiles2 + $520, vTiles2 + $530, vTiles2 + $540, rIE

; E-0224 (C1: RunNameEntryStateWhenNotFading_Case01_Case04 and _Case09 pass this list to RunNameEntryStateWhenNotFading_Shared05, which therefore copies nothing).
; record: $FFFF: no destinations
NameEntryTileDestListEmpty::
Data_014_6DF6:: ; address name
    dw $FFFF ; entry 0

; E-0224 (C1: the source list paired with NameEntryTileDestList (Case00_Case01) and with the empty list (Case01_Case09)).
; record: 80 bank-$1F tile sources (the last is $FFFF)
NameEntryTileSrcListA::
Data_014_6DF8:: ; address name
    dw $40B0, $40C0, $40D0, $40E0, $40F0, $4100, $4110, $4120 ; entry 0
    dw $4130, $4140, $4150, $4160, $4170, $4010, $4020, $4030
    dw $4040, $4180, $4190, $41A0, $41B0, $41C0, $41D0, $41E0
    dw $41F0, $4200, $4210, $4220, $4230, $4240, $4050, $4060
    dw $4070, $4080, $4250, $4260, $4270, $4280, $4290, $42A0
    dw $42B0, $42C0, $42D0, $42E0, $42F0, $4300, $4310, $4090
    dw $40A0, $49A0, $4990, $4320, $4330, $4340, $4350, $4360
    dw $4370, $4380, $4390, $43A0, $43B0, $43C0, $43D0, $43E0
    dw $40C0, $40B0, $40D0, $4150, $4960, $4AC0, $4B60, $4950
    dw $4940, $4B00, $4A00, $4A00, $4A00, $4A00, $4A00, $FFFF

; E-0224 (C1: passed with the empty destination list by Case01_Case04; 82 words and $FFFF, then 16 bytes of $FF before NameEntryKeyboard).
; record: 82 bank-$1F tile sources, then $FFFF
NameEntryTileSrcListB::
Data_014_6E98:: ; address name
    dw $4570, $4590, $45B0, $45D0, $45F0, $4610, $4620, $4630 ; entry 0
    dw $4640, $4650, $4660, $4670, $4680, $4690, $46A0, $46B0
    dw $46C0, $46D0, $46F0, $4700, $4710, $4720, $4730, $4740
    dw $4750, $4020, $4030, $4040, $4050, $4060, $4760, $4770
    dw $4780, $4790, $47A0, $47B0, $47C0, $47D0, $47E0, $47F0
    dw $4800, $4820, $4840, $4860, $4870, $4880, $4890, $48A0
    dw $48B0, $48C0, $48D0, $46E0, $49D0, $4070, $4080, $4090
    dw $40A0, $4010, $4580, $45A0, $45C0, $45E0, $4600, $4810
    dw $4830, $4850, $48E0, $48F0, $4400, $44F0, $42A0, $43A0
    dw $4480, $4510, $4290, $4540, $4510, $4A00, $4A00, $4A00
    dw $4A00, $4A00, $FFFF
    db $FF, $00, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; end

; E-0216 (C1: RunNameEntryStateWhenNotFading_Case01_Case02 reads the byte at $6F4E + 17 * wNameEntryCursorY + wNameEntryCursorX as the chosen character; rows 0-3 are A-M 0-3, N-Z 4-7, a-m 8 9 ! ?, n-z; 10 rows, then 11 bytes not placed in a row).
; record: one row of 17 character codes (charmap.inc; codes without a charmap entry print as bytes)
NameEntryKeyboard::
Data_014_6F4E:: ; address name
    db "ABCDEFGHIJKLM0123" ; id 0
    db "NOPQRSTUVWXYZ4567" ; id 1
    db "abcdefghijklm89!?" ; id 2
    db "nopqrstuvwxyz", $FE, $FF, $FF, $FF ; id 3
    db $95, ",.", $94, $93, " ", $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; id 4
    db $56, $58, $5A, $5C, $5E, $75, $76, $77, $78, $79, $57, $59, $5B, $5D, $5F, $FF, $60 ; id 5
    db $61, $62, $63, $64, $7A, $7B, $7C, $7D, $7E, $80, $82, $84, $8D, $8E, $FF, $65, $66 ; id 6
    db $67, $68, $69, $7F, $FF, $81, $FF, $83, $FF, $FF, $FF, $FF, $FF, $FF, $6A, $6B, $6C ; id 7
    db $6E, $6F, $85, $86, $87, $88, $89, $FD, $FF, $FF, $FF, $FF, $FF, $70, $71, $72, $73 ; id 8
    db $74, $8A, $8B, $8C, $6D, "-", $FE, $FF, $FF, $FF, $FF, $FF, "12345" ; id 9
    db $06, $07, $08, $09, $00, $FF, $FF, $FF, $FF, $FF, $FF ; end

; address loaded by RunNameEntryStateWhenNotFading_FillTilesFromRequest
RunNameEntryStateWhenNotFading_FillTilesFromRequest_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_014_7003:: ; address name
    db $05, $70, $0D, $70, $1C, $70, $2B, $70, $4D, $70
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is ", $F9, "0 correct?", $F0, "Is ", $F9, "0 correct?", $F0, "A monster already", $F1
    db "has that name.", $F7
    db $F0, "Sorry, that name", $F1
    db "can't be used.", $F7
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_14_706D::
Data_014_706D:: ; address name
    dw StringList_14_706F ; id 0

; E-0217 (derived: category list of StringCategories_14_706D; one pointer per wStringIndex)
; record: string
StringList_14_706F::
Data_014_706F:: ; address name
    dw String_14_00_00 ; id 0
    dw String_14_00_01 ; id 1
    dw String_14_00_02 ; id 2
    dw String_14_00_03 ; id 3

String_14_00_00:: ; heuristic: string; C0
Data_014_7077:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Is ", $F9, "0 OK?", $F0

String_14_00_01:: ; heuristic: string; C0
Data_014_7084:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Is ", $F9, "0 OK?", $F0

String_14_00_02:: ; heuristic: string; C0
Data_014_7091:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That name is", $F1
    db "already in use.", $F7
    db $F0

String_14_00_03:: ; heuristic: string; C0
Data_014_70B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That name can't", $F1
    db "be used.", $FA, $F7
    db $F2, "You'll have to use", $F1
    db "another name.", $F7
    db $F0

; E-0191 (C1: RunNameEntryStateWhenNotFading_Case03_Case00_Sub02 walks 10-byte records from $70F0 until a first byte of $FF, comparing each with wNameEntryText (skipping $9F bytes) up to its $F0; 84 records, each in mixed case and capitals, then the $FF terminator).
; record: a name the name entry screen refuses: text ending in $F0, zero padded to 10 bytes
RejectedNameList::
Data_014_70F0:: ; address name
    db "Ass", $F0, $00, $00, $00, $00, $00, $00 ; id 0
    db "ASS", $F0, $00, $00, $00, $00, $00, $00 ; id 1
    db "Dink", $F0, $00, $00, $00, $00, $00 ; id 2
    db "DINK", $F0, $00, $00, $00, $00, $00 ; id 3
    db "Dork", $F0, $00, $00, $00, $00, $00 ; id 4
    db "DORK", $F0, $00, $00, $00, $00, $00 ; id 5
    db "Cunt", $F0, $00, $00, $00, $00, $00 ; id 6
    db "CUNT", $F0, $00, $00, $00, $00, $00 ; id 7
    db "Kunt", $F0, $00, $00, $00, $00, $00 ; id 8
    db "KUNT", $F0, $00, $00, $00, $00, $00 ; id 9
    db "Fuck", $F0, $00, $00, $00, $00, $00 ; id 10
    db "FUCK", $F0, $00, $00, $00, $00, $00 ; id 11
    db "Shit", $F0, $00, $00, $00, $00, $00 ; id 12
    db "SHIT", $F0, $00, $00, $00, $00, $00 ; id 13
    db "Sex", $F0, $00, $00, $00, $00, $00, $00 ; id 14
    db "SEX", $F0, $00, $00, $00, $00, $00, $00 ; id 15
    db "Poop", $F0, $00, $00, $00, $00, $00 ; id 16
    db "POOP", $F0, $00, $00, $00, $00, $00 ; id 17
    db "Dong", $F0, $00, $00, $00, $00, $00 ; id 18
    db "DONG", $F0, $00, $00, $00, $00, $00 ; id 19
    db "Pene", $F0, $00, $00, $00, $00, $00 ; id 20
    db "PENE", $F0, $00, $00, $00, $00, $00 ; id 21
    db "Clit", $F0, $00, $00, $00, $00, $00 ; id 22
    db "CLIT", $F0, $00, $00, $00, $00, $00 ; id 23
    db "Twat", $F0, $00, $00, $00, $00, $00 ; id 24
    db "TWAT", $F0, $00, $00, $00, $00, $00 ; id 25
    db "Snot", $F0, $00, $00, $00, $00, $00 ; id 26
    db "SNOT", $F0, $00, $00, $00, $00, $00 ; id 27
    db "Fag", $F0, $00, $00, $00, $00, $00, $00 ; id 28
    db "FAG", $F0, $00, $00, $00, $00, $00, $00 ; id 29
    db "Homo", $F0, $00, $00, $00, $00, $00 ; id 30
    db "HOMO", $F0, $00, $00, $00, $00, $00 ; id 31
    db "Poon", $F0, $00, $00, $00, $00, $00 ; id 32
    db "POON", $F0, $00, $00, $00, $00, $00 ; id 33
    db "Piss", $F0, $00, $00, $00, $00, $00 ; id 34
    db "PISS", $F0, $00, $00, $00, $00, $00 ; id 35
    db "Prick", $F0, $00, $00, $00, $00 ; id 36
    db "PRICK", $F0, $00, $00, $00, $00 ; id 37
    db "Fukk", $F0, $00, $00, $00, $00, $00 ; id 38
    db "FUKK", $F0, $00, $00, $00, $00, $00 ; id 39
    db "Coon", $F0, $00, $00, $00, $00, $00 ; id 40
    db "COON", $F0, $00, $00, $00, $00, $00 ; id 41
    db "Nazi", $F0, $00, $00, $00, $00, $00 ; id 42
    db "NAZI", $F0, $00, $00, $00, $00, $00 ; id 43
    db "Niga", $F0, $00, $00, $00, $00, $00 ; id 44
    db "NIGA", $F0, $00, $00, $00, $00, $00 ; id 45
    db "Nigga", $F0, $00, $00, $00, $00 ; id 46
    db "NIGGA", $F0, $00, $00, $00, $00 ; id 47
    db "Jap", $F0, $00, $00, $00, $00, $00, $00 ; id 48
    db "JAP", $F0, $00, $00, $00, $00, $00, $00 ; id 49
    db "Jew", $F0, $00, $00, $00, $00, $00, $00 ; id 50
    db "JEW", $F0, $00, $00, $00, $00, $00, $00 ; id 51
    db "Wop", $F0, $00, $00, $00, $00, $00, $00 ; id 52
    db "WOP", $F0, $00, $00, $00, $00, $00, $00 ; id 53
    db "Spic", $F0, $00, $00, $00, $00, $00 ; id 54
    db "SPIC", $F0, $00, $00, $00, $00, $00 ; id 55
    db "Butt", $F0, $00, $00, $00, $00, $00 ; id 56
    db "BUTT", $F0, $00, $00, $00, $00, $00 ; id 57
    db "Perv", $F0, $00, $00, $00, $00, $00 ; id 58
    db "PERV", $F0, $00, $00, $00, $00, $00 ; id 59
    db "Dumb", $F0, $00, $00, $00, $00, $00 ; id 60
    db "DUMB", $F0, $00, $00, $00, $00, $00 ; id 61
    db "Dolt", $F0, $00, $00, $00, $00, $00 ; id 62
    db "DOLT", $F0, $00, $00, $00, $00, $00 ; id 63
    db "Anus", $F0, $00, $00, $00, $00, $00 ; id 64
    db "ANUS", $F0, $00, $00, $00, $00, $00 ; id 65
    db "Anal", $F0, $00, $00, $00, $00, $00 ; id 66
    db "ANAL", $F0, $00, $00, $00, $00, $00 ; id 67
    db "Jerk", $F0, $00, $00, $00, $00, $00 ; id 68
    db "JERK", $F0, $00, $00, $00, $00, $00 ; id 69
    db "Puke", $F0, $00, $00, $00, $00, $00 ; id 70
    db "PUKE", $F0, $00, $00, $00, $00, $00 ; id 71
    db "Snot", $F0, $00, $00, $00, $00, $00 ; id 72
    db "SNOT", $F0, $00, $00, $00, $00, $00 ; id 73
    db "Barf", $F0, $00, $00, $00, $00, $00 ; id 74
    db "BARF", $F0, $00, $00, $00, $00, $00 ; id 75
    db "Pus", $F0, $00, $00, $00, $00, $00, $00 ; id 76
    db "PUS", $F0, $00, $00, $00, $00, $00, $00 ; id 77
    db "Pussy", $F0, $00, $00, $00, $00 ; id 78
    db "PUSSY", $F0, $00, $00, $00, $00 ; id 79
    db "Bung", $F0, $00, $00, $00, $00, $00 ; id 80
    db "BUNG", $F0, $00, $00, $00, $00, $00 ; id 81
    db "Suck", $F0, $00, $00, $00, $00, $00 ; id 82
    db "SUCK", $F0, $00, $00, $00, $00, $00 ; id 83
    db $FF ; end

; E-0254 (C1: the code before RunNameEntryStateWhenNotFading_Case01_Case03_CheckArg1.skip3 indexes it with wArg3 & $0F (the family as StringTable_MonsterFamilies: 0 Slime, 1 Dragon, 2 Beast, 3 Bird, 4 Plant, 5 Bug, 6 Demon, 7 Zombie, 8 Material, 9 Water, 10 '????' (boss)) and then takes name 7 * wArg2 + n; CreateMonsterRecordOfKindTemp1_Sub01_Sub01_Sub01 indexes it with wWorkBuf and wWorkBuf + 1 and copies the name (up to $F0, with $9F handled) to the address in wWorkBuf + 2/3; 11 families of 14 names).
; record: 14 name pointers for this family
DefaultMonsterNameTable::
Data_014_7439:: ; address name
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

; E-0254 (C1: family 0 (Slime) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Slime::
Data_014_744F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Slime).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Slime::
DefaultName_Slime_00:: ; heuristic: default monster name; C0
Data_014_746B:: ; address name
    db "Slib", $9F, $F0 ; id 0
DefaultName_Slime_01:: ; heuristic: default monster name; C0
Data_014_7471:: ; address name
    db "Darce", $F0 ; id 1
DefaultName_Slime_02:: ; heuristic: default monster name; C0
Data_014_7477:: ; address name
    db "Bono", $9F, $F0 ; id 2
DefaultName_Slime_03:: ; heuristic: default monster name; C0
Data_014_747D:: ; address name
    db "Miles", $F0 ; id 3
DefaultName_Slime_04:: ; heuristic: default monster name; C0
Data_014_7483:: ; address name
    db "Rabba", $F0 ; id 4
DefaultName_Slime_05:: ; heuristic: default monster name; C0
Data_014_7489:: ; address name
    db "Terio", $F0 ; id 5
DefaultName_Slime_06:: ; heuristic: default monster name; C0
Data_014_748F:: ; address name
    db "Oneo", $9F, $F0 ; id 6
DefaultName_Slime_07:: ; heuristic: default monster name; C0
Data_014_7495:: ; address name
    db "Slari", $F0 ; id 7
DefaultName_Slime_08:: ; heuristic: default monster name; C0
Data_014_749B:: ; address name
    db "Stera", $F0 ; id 8
DefaultName_Slime_09:: ; heuristic: default monster name; C0
Data_014_74A1:: ; address name
    db "Purla", $F0 ; id 9
DefaultName_Slime_0A:: ; heuristic: default monster name; C0
Data_014_74A7:: ; address name
    db "Cikor", $F0 ; id 10
DefaultName_Slime_0B:: ; heuristic: default monster name; C0
Data_014_74AD:: ; address name
    db "Ripp", $9F, $F0 ; id 11
DefaultName_Slime_0C:: ; heuristic: default monster name; C0
Data_014_74B3:: ; address name
    db "Petti", $F0 ; id 12
DefaultName_Slime_0D:: ; heuristic: default monster name; C0
Data_014_74B9:: ; address name
    db "Chalo", $F0 ; id 13

; E-0254 (C1: family 1 (Dragon) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Dragon::
Data_014_74BF:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Dragon).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Dragon::
DefaultName_Dragon_00:: ; heuristic: default monster name; C0
Data_014_74DB:: ; address name
    db "Horry", $F0 ; id 0
DefaultName_Dragon_01:: ; heuristic: default monster name; C0
Data_014_74E1:: ; address name
    db "Kabel", $F0 ; id 1
DefaultName_Dragon_02:: ; heuristic: default monster name; C0
Data_014_74E7:: ; address name
    db "Galet", $F0 ; id 2
DefaultName_Dragon_03:: ; heuristic: default monster name; C0
Data_014_74ED:: ; address name
    db "Porpo", $F0 ; id 3
DefaultName_Dragon_04:: ; heuristic: default monster name; C0
Data_014_74F3:: ; address name
    db "Kejet", $F0 ; id 4
DefaultName_Dragon_05:: ; heuristic: default monster name; C0
Data_014_74F9:: ; address name
    db "Dorad", $F0 ; id 5
DefaultName_Dragon_06:: ; heuristic: default monster name; C0
Data_014_74FF:: ; address name
    db "Baron", $F0 ; id 6
DefaultName_Dragon_07:: ; heuristic: default monster name; C0
Data_014_7505:: ; address name
    db "Rouge", $F0 ; id 7
DefaultName_Dragon_08:: ; heuristic: default monster name; C0
Data_014_750B:: ; address name
    db "Azari", $F0 ; id 8
DefaultName_Dragon_09:: ; heuristic: default monster name; C0
Data_014_7511:: ; address name
    db "Chabo", $F0 ; id 9
DefaultName_Dragon_0A:: ; heuristic: default monster name; C0
Data_014_7517:: ; address name
    db "Triss", $F0 ; id 10
DefaultName_Dragon_0B:: ; heuristic: default monster name; C0
Data_014_751D:: ; address name
    db "Runar", $F0 ; id 11
DefaultName_Dragon_0C:: ; heuristic: default monster name; C0
Data_014_7523:: ; address name
    db "Rudi", $9F, $F0 ; id 12
DefaultName_Dragon_0D:: ; heuristic: default monster name; C0
Data_014_7529:: ; address name
    db "Vuy", $9F, $9F, $F0 ; id 13

; E-0254 (C1: family 2 (Beast) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Beast::
Data_014_752F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Beast).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Beast::
DefaultName_Beast_00:: ; heuristic: default monster name; C0
Data_014_754B:: ; address name
    db "Uwing", $F0 ; id 0
DefaultName_Beast_01:: ; heuristic: default monster name; C0
Data_014_7551:: ; address name
    db "Iver", $9F, $F0 ; id 1
DefaultName_Beast_02:: ; heuristic: default monster name; C0
Data_014_7557:: ; address name
    db "Rodma", $F0 ; id 2
DefaultName_Beast_03:: ; heuristic: default monster name; C0
Data_014_755D:: ; address name
    db "Didie", $F0 ; id 3
DefaultName_Beast_04:: ; heuristic: default monster name; C0
Data_014_7563:: ; address name
    db "Margg", $F0 ; id 4
DefaultName_Beast_05:: ; heuristic: default monster name; C0
Data_014_7569:: ; address name
    db "Ogami", $F0 ; id 5
DefaultName_Beast_06:: ; heuristic: default monster name; C0
Data_014_756F:: ; address name
    db "Carro", $F0 ; id 6
DefaultName_Beast_07:: ; heuristic: default monster name; C0
Data_014_7575:: ; address name
    db "Nikit", $F0 ; id 7
DefaultName_Beast_08:: ; heuristic: default monster name; C0
Data_014_757B:: ; address name
    db "Messa", $F0 ; id 8
DefaultName_Beast_09:: ; heuristic: default monster name; C0
Data_014_7581:: ; address name
    db "Larma", $F0 ; id 9
DefaultName_Beast_0A:: ; heuristic: default monster name; C0
Data_014_7587:: ; address name
    db "Jannu", $F0 ; id 10
DefaultName_Beast_0B:: ; heuristic: default monster name; C0
Data_014_758D:: ; address name
    db "Fevri", $F0 ; id 11
DefaultName_Beast_0C:: ; heuristic: default monster name; C0
Data_014_7593:: ; address name
    db "Javel", $F0 ; id 12
DefaultName_Beast_0D:: ; heuristic: default monster name; C0
Data_014_7599:: ; address name
    db "Gurri", $F0 ; id 13

; E-0254 (C1: family 3 (Bird) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Bird::
Data_014_759F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Bird).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Bird::
DefaultName_Bird_00:: ; heuristic: default monster name; C0
Data_014_75BB:: ; address name
    db "Patta", $F0 ; id 0
DefaultName_Bird_01:: ; heuristic: default monster name; C0
Data_014_75C1:: ; address name
    db "Venjy", $F0 ; id 1
DefaultName_Bird_02:: ; heuristic: default monster name; C0
Data_014_75C7:: ; address name
    db "Angy", $9F, $F0 ; id 2
DefaultName_Bird_03:: ; heuristic: default monster name; C0
Data_014_75CD:: ; address name
    db "Rovyn", $F0 ; id 3
DefaultName_Bird_04:: ; heuristic: default monster name; C0
Data_014_75D3:: ; address name
    db "Leit", $9F, $F0 ; id 4
DefaultName_Bird_05:: ; heuristic: default monster name; C0
Data_014_75D9:: ; address name
    db "Cyron", $F0 ; id 5
DefaultName_Bird_06:: ; heuristic: default monster name; C0
Data_014_75DF:: ; address name
    db "Nilse", $F0 ; id 6
DefaultName_Bird_07:: ; heuristic: default monster name; C0
Data_014_75E5:: ; address name
    db "Pakin", $F0 ; id 7
DefaultName_Bird_08:: ; heuristic: default monster name; C0
Data_014_75EB:: ; address name
    db "Aerr", $9F, $F0 ; id 8
DefaultName_Bird_09:: ; heuristic: default monster name; C0
Data_014_75F1:: ; address name
    db "Samar", $F0 ; id 9
DefaultName_Bird_0A:: ; heuristic: default monster name; C0
Data_014_75F7:: ; address name
    db "Kacis", $F0 ; id 10
DefaultName_Bird_0B:: ; heuristic: default monster name; C0
Data_014_75FD:: ; address name
    db "Taki", $9F, $F0 ; id 11
DefaultName_Bird_0C:: ; heuristic: default monster name; C0
Data_014_7603:: ; address name
    db "Ralli", $F0 ; id 12
DefaultName_Bird_0D:: ; heuristic: default monster name; C0
Data_014_7609:: ; address name
    db "Moko", $9F, $F0 ; id 13

; E-0254 (C1: family 4 (Plant) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Plant::
Data_014_760F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Plant).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Plant::
DefaultName_Plant_00:: ; heuristic: default monster name; C0
Data_014_762B:: ; address name
    db "Ganim", $F0 ; id 0
DefaultName_Plant_01:: ; heuristic: default monster name; C0
Data_014_7631:: ; address name
    db "Belri", $F0 ; id 1
DefaultName_Plant_02:: ; heuristic: default monster name; C0
Data_014_7637:: ; address name
    db "Taim", $9F, $F0 ; id 2
DefaultName_Plant_03:: ; heuristic: default monster name; C0
Data_014_763D:: ; address name
    db "Sarzz", $F0 ; id 3
DefaultName_Plant_04:: ; heuristic: default monster name; C0
Data_014_7643:: ; address name
    db "Cita", $9F, $F0 ; id 4
DefaultName_Plant_05:: ; heuristic: default monster name; C0
Data_014_7649:: ; address name
    db "Peyot", $F0 ; id 5
DefaultName_Plant_06:: ; heuristic: default monster name; C0
Data_014_764F:: ; address name
    db "Muppa", $F0 ; id 6
DefaultName_Plant_07:: ; heuristic: default monster name; C0
Data_014_7655:: ; address name
    db "Laven", $F0 ; id 7
DefaultName_Plant_08:: ; heuristic: default monster name; C0
Data_014_765B:: ; address name
    db "Sarad", $F0 ; id 8
DefaultName_Plant_09:: ; heuristic: default monster name; C0
Data_014_7661:: ; address name
    db "Gyam", $9F, $F0 ; id 9
DefaultName_Plant_0A:: ; heuristic: default monster name; C0
Data_014_7667:: ; address name
    db "Gummy", $F0 ; id 10
DefaultName_Plant_0B:: ; heuristic: default monster name; C0
Data_014_766D:: ; address name
    db "Pupul", $F0 ; id 11
DefaultName_Plant_0C:: ; heuristic: default monster name; C0
Data_014_7673:: ; address name
    db "Vanyl", $F0 ; id 12
DefaultName_Plant_0D:: ; heuristic: default monster name; C0
Data_014_7679:: ; address name
    db "Popla", $F0 ; id 13

; E-0254 (C1: family 5 (Bug) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Bug::
Data_014_767F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Bug).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Bug::
DefaultName_Bug_00:: ; heuristic: default monster name; C0
Data_014_769B:: ; address name
    db "Abii", $9F, $F0 ; id 0
DefaultName_Bug_01:: ; heuristic: default monster name; C0
Data_014_76A1:: ; address name
    db "Ulrik", $F0 ; id 1
DefaultName_Bug_02:: ; heuristic: default monster name; C0
Data_014_76A7:: ; address name
    db "Werth", $F0 ; id 2
DefaultName_Bug_03:: ; heuristic: default monster name; C0
Data_014_76AD:: ; address name
    db "Grunt", $F0 ; id 3
DefaultName_Bug_04:: ; heuristic: default monster name; C0
Data_014_76B3:: ; address name
    db "Glath", $F0 ; id 4
DefaultName_Bug_05:: ; heuristic: default monster name; C0
Data_014_76B9:: ; address name
    db "Gamha", $F0 ; id 5
DefaultName_Bug_06:: ; heuristic: default monster name; C0
Data_014_76BF:: ; address name
    db "Moahm", $F0 ; id 6
DefaultName_Bug_07:: ; heuristic: default monster name; C0
Data_014_76C5:: ; address name
    db "Maron", $F0 ; id 7
DefaultName_Bug_08:: ; heuristic: default monster name; C0
Data_014_76CB:: ; address name
    db "Quii", $9F, $F0 ; id 8
DefaultName_Bug_09:: ; heuristic: default monster name; C0
Data_014_76D1:: ; address name
    db "Kokis", $F0 ; id 9
DefaultName_Bug_0A:: ; heuristic: default monster name; C0
Data_014_76D7:: ; address name
    db "Juddi", $F0 ; id 10
DefaultName_Bug_0B:: ; heuristic: default monster name; C0
Data_014_76DD:: ; address name
    db "Sherr", $F0 ; id 11
DefaultName_Bug_0C:: ; heuristic: default monster name; C0
Data_014_76E3:: ; address name
    db "Pliss", $F0 ; id 12
DefaultName_Bug_0D:: ; heuristic: default monster name; C0
Data_014_76E9:: ; address name
    db "Guvri", $F0 ; id 13

; E-0254 (C1: family 6 (Demon) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Demon::
Data_014_76EF:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Demon).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Demon::
DefaultName_Demon_00:: ; heuristic: default monster name; C0
Data_014_770B:: ; address name
    db "Damia", $F0 ; id 0
DefaultName_Demon_01:: ; heuristic: default monster name; C0
Data_014_7711:: ; address name
    db "Qube", $9F, $F0 ; id 1
DefaultName_Demon_02:: ; heuristic: default monster name; C0
Data_014_7717:: ; address name
    db "Rigg", $9F, $F0 ; id 2
DefaultName_Demon_03:: ; heuristic: default monster name; C0
Data_014_771D:: ; address name
    db "Jaxon", $F0 ; id 3
DefaultName_Demon_04:: ; heuristic: default monster name; C0
Data_014_7723:: ; address name
    db "Phel", $9F, $F0 ; id 4
DefaultName_Demon_05:: ; heuristic: default monster name; C0
Data_014_7729:: ; address name
    db "Fauss", $F0 ; id 5
DefaultName_Demon_06:: ; heuristic: default monster name; C0
Data_014_772F:: ; address name
    db "Ancho", $F0 ; id 6
DefaultName_Demon_07:: ; heuristic: default monster name; C0
Data_014_7735:: ; address name
    db "Iyan", $9F, $F0 ; id 7
DefaultName_Demon_08:: ; heuristic: default monster name; C0
Data_014_773B:: ; address name
    db "Irris", $F0 ; id 8
DefaultName_Demon_09:: ; heuristic: default monster name; C0
Data_014_7741:: ; address name
    db "Kerig", $F0 ; id 9
DefaultName_Demon_0A:: ; heuristic: default monster name; C0
Data_014_7747:: ; address name
    db "Kaico", $F0 ; id 10
DefaultName_Demon_0B:: ; heuristic: default monster name; C0
Data_014_774D:: ; address name
    db "Calor", $F0 ; id 11
DefaultName_Demon_0C:: ; heuristic: default monster name; C0
Data_014_7753:: ; address name
    db "Aknes", $F0 ; id 12
DefaultName_Demon_0D:: ; heuristic: default monster name; C0
Data_014_7759:: ; address name
    db "Nivel", $F0 ; id 13

; E-0254 (C1: family 7 (Zombie) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Zombie::
Data_014_775F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Zombie).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Zombie::
DefaultName_Zombie_00:: ; heuristic: default monster name; C0
Data_014_777B:: ; address name
    db "Gley", $9F, $F0 ; id 0
DefaultName_Zombie_01:: ; heuristic: default monster name; C0
Data_014_7781:: ; address name
    db "Veron", $F0 ; id 1
DefaultName_Zombie_02:: ; heuristic: default monster name; C0
Data_014_7787:: ; address name
    db "Donad", $F0 ; id 2
DefaultName_Zombie_03:: ; heuristic: default monster name; C0
Data_014_778D:: ; address name
    db "Fobos", $F0 ; id 3
DefaultName_Zombie_04:: ; heuristic: default monster name; C0
Data_014_7793:: ; address name
    db "Junas", $F0 ; id 4
DefaultName_Zombie_05:: ; heuristic: default monster name; C0
Data_014_7799:: ; address name
    db "Dupel", $F0 ; id 5
DefaultName_Zombie_06:: ; heuristic: default monster name; C0
Data_014_779F:: ; address name
    db "Drolo", $F0 ; id 6
DefaultName_Zombie_07:: ; heuristic: default monster name; C0
Data_014_77A5:: ; address name
    db "Tumi", $9F, $F0 ; id 7
DefaultName_Zombie_08:: ; heuristic: default monster name; C0
Data_014_77AB:: ; address name
    db "Kyar", $9F, $F0 ; id 8
DefaultName_Zombie_09:: ; heuristic: default monster name; C0
Data_014_77B1:: ; address name
    db "Rozar", $F0 ; id 9
DefaultName_Zombie_0A:: ; heuristic: default monster name; C0
Data_014_77B7:: ; address name
    db "Kyrie", $F0 ; id 10
DefaultName_Zombie_0B:: ; heuristic: default monster name; C0
Data_014_77BD:: ; address name
    db "Pina", $9F, $F0 ; id 11
DefaultName_Zombie_0C:: ; heuristic: default monster name; C0
Data_014_77C3:: ; address name
    db "Myran", $F0 ; id 12
DefaultName_Zombie_0D:: ; heuristic: default monster name; C0
Data_014_77C9:: ; address name
    db "Pando", $F0 ; id 13

; E-0254 (C1: family 8 (Material) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Material::
Data_014_77CF:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Material).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Material::
DefaultName_Material_00:: ; heuristic: default monster name; C0
Data_014_77EB:: ; address name
    db "Kheri", $F0 ; id 0
DefaultName_Material_01:: ; heuristic: default monster name; C0
Data_014_77F1:: ; address name
    db "Nesta", $F0 ; id 1
DefaultName_Material_02:: ; heuristic: default monster name; C0
Data_014_77F7:: ; address name
    db "Anvar", $F0 ; id 2
DefaultName_Material_03:: ; heuristic: default monster name; C0
Data_014_77FD:: ; address name
    db "Vyng", $9F, $F0 ; id 3
DefaultName_Material_04:: ; heuristic: default monster name; C0
Data_014_7803:: ; address name
    db "Olyva", $F0 ; id 4
DefaultName_Material_05:: ; heuristic: default monster name; C0
Data_014_7809:: ; address name
    db "Fridz", $F0 ; id 5
DefaultName_Material_06:: ; heuristic: default monster name; C0
Data_014_780F:: ; address name
    db "Iwan", $9F, $F0 ; id 6
DefaultName_Material_07:: ; heuristic: default monster name; C0
Data_014_7815:: ; address name
    db "Yssa", $9F, $F0 ; id 7
DefaultName_Material_08:: ; heuristic: default monster name; C0
Data_014_781B:: ; address name
    db "Revvi", $F0 ; id 8
DefaultName_Material_09:: ; heuristic: default monster name; C0
Data_014_7821:: ; address name
    db "Opall", $F0 ; id 9
DefaultName_Material_0A:: ; heuristic: default monster name; C0
Data_014_7827:: ; address name
    db "Jidda", $F0 ; id 10
DefaultName_Material_0B:: ; heuristic: default monster name; C0
Data_014_782D:: ; address name
    db "Murri", $F0 ; id 11
DefaultName_Material_0C:: ; heuristic: default monster name; C0
Data_014_7833:: ; address name
    db "Thina", $F0 ; id 12
DefaultName_Material_0D:: ; heuristic: default monster name; C0
Data_014_7839:: ; address name
    db "Yoori", $F0 ; id 13

; E-0254 (C1: family 9 (Water) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Water::
Data_014_783F:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Water).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Water::
DefaultName_Water_00:: ; heuristic: default monster name; C0
Data_014_785B:: ; address name
    db "Izak", $9F, $F0 ; id 0
DefaultName_Water_01:: ; heuristic: default monster name; C0
Data_014_7861:: ; address name
    db "Walli", $F0 ; id 1
DefaultName_Water_02:: ; heuristic: default monster name; C0
Data_014_7867:: ; address name
    db "Soda", $9F, $F0 ; id 2
DefaultName_Water_03:: ; heuristic: default monster name; C0
Data_014_786D:: ; address name
    db "Evi", $9F, $9F, $F0 ; id 3
DefaultName_Water_04:: ; heuristic: default monster name; C0
Data_014_7873:: ; address name
    db "Reny", $9F, $F0 ; id 4
DefaultName_Water_05:: ; heuristic: default monster name; C0
Data_014_7879:: ; address name
    db "Jawah", $F0 ; id 5
DefaultName_Water_06:: ; heuristic: default monster name; C0
Data_014_787F:: ; address name
    db "Tavin", $F0 ; id 6
DefaultName_Water_07:: ; heuristic: default monster name; C0
Data_014_7885:: ; address name
    db "Cyaci", $F0 ; id 7
DefaultName_Water_08:: ; heuristic: default monster name; C0
Data_014_788B:: ; address name
    db "Mizur", $F0 ; id 8
DefaultName_Water_09:: ; heuristic: default monster name; C0
Data_014_7891:: ; address name
    db "Purll", $F0 ; id 9
DefaultName_Water_0A:: ; heuristic: default monster name; C0
Data_014_7897:: ; address name
    db "Oasiz", $F0 ; id 10
DefaultName_Water_0B:: ; heuristic: default monster name; C0
Data_014_789D:: ; address name
    db "Nadea", $F0 ; id 11
DefaultName_Water_0C:: ; heuristic: default monster name; C0
Data_014_78A3:: ; address name
    db "Lua", $9F, $9F, $F0 ; id 12
DefaultName_Water_0D:: ; heuristic: default monster name; C0
Data_014_78A9:: ; address name
    db "Dovin", $F0 ; id 13

; E-0254 (C1: family 10 (Boss) of DefaultMonsterNameTable).
; record: name
DefaultMonsterNames_Boss::
Data_014_78AF:: ; address name
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

; E-0254 (C1: the 14 six-byte names of DefaultMonsterNames_Boss).
; record: name, then $F0 (and padding)
DefaultMonsterNameStrings_Boss::
DefaultName_Boss_00:: ; heuristic: default monster name; C0
Data_014_78CB:: ; address name
    db "Hevnz", $F0 ; id 0
DefaultName_Boss_01:: ; heuristic: default monster name; C0
Data_014_78D1:: ; address name
    db "Hadez", $F0 ; id 1
DefaultName_Boss_02:: ; heuristic: default monster name; C0
Data_014_78D7:: ; address name
    db "Makro", $F0 ; id 2
DefaultName_Boss_03:: ; heuristic: default monster name; C0
Data_014_78DD:: ; address name
    db "Oskro", $F0 ; id 3
DefaultName_Boss_04:: ; heuristic: default monster name; C0
Data_014_78E3:: ; address name
    db "Mirio", $F0 ; id 4
DefaultName_Boss_05:: ; heuristic: default monster name; C0
Data_014_78E9:: ; address name
    db "Fasis", $F0 ; id 5
DefaultName_Boss_06:: ; heuristic: default monster name; C0
Data_014_78EF:: ; address name
    db "Akull", $F0 ; id 6
DefaultName_Boss_07:: ; heuristic: default monster name; C0
Data_014_78F5:: ; address name
    db "Ledah", $F0 ; id 7
DefaultName_Boss_08:: ; heuristic: default monster name; C0
Data_014_78FB:: ; address name
    db "Ulph", $9F, $F0 ; id 8
DefaultName_Boss_09:: ; heuristic: default monster name; C0
Data_014_7901:: ; address name
    db "Wyll", $9F, $F0 ; id 9
DefaultName_Boss_0A:: ; heuristic: default monster name; C0
Data_014_7907:: ; address name
    db "Wev", $9F, $9F, $F0 ; id 10
DefaultName_Boss_0B:: ; heuristic: default monster name; C0
Data_014_790D:: ; address name
    db "Sesil", $F0 ; id 11
DefaultName_Boss_0C:: ; heuristic: default monster name; C0
Data_014_7913:: ; address name
    db "Syall", $F0 ; id 12
DefaultName_Boss_0D:: ; heuristic: default monster name; C0
Data_014_7919:: ; address name
    db "Waltz", $F0 ; id 13

; E-0254 (C1: the routine ending at $6CE9 copies the name at word [$791F + 2 * (70 * (wArg2 & 1) + B)] to wNameEntryText (CopyF0StringAndRedrawNameEntry); 140 words, two sets of 70).
; record: suggested name
NameEntrySuggestionTable::
Data_014_791F:: ; address name
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

; E-0254 (C1: the 140 six-byte names of NameEntrySuggestionTable, $7A37-$7D7F).
; record: name, then $F0 (and padding)
NameEntrySuggestions::
SuggestedName_00:: ; heuristic: name entry suggestion; C0
Data_014_7A37:: ; address name
    db "Ryken", $F0 ; id 0
SuggestedName_01:: ; heuristic: name entry suggestion; C0
Data_014_7A3D:: ; address name
    db "Li", $9F, $9F, $9F, $F0 ; id 1
SuggestedName_02:: ; heuristic: name entry suggestion; C0
Data_014_7A43:: ; address name
    db "Pynn", $9F, $F0 ; id 2
SuggestedName_03:: ; heuristic: name entry suggestion; C0
Data_014_7A49:: ; address name
    db "Pazu", $9F, $F0 ; id 3
SuggestedName_04:: ; heuristic: name entry suggestion; C0
Data_014_7A4F:: ; address name
    db "Kordi", $F0 ; id 4
SuggestedName_05:: ; heuristic: name entry suggestion; C0
Data_014_7A55:: ; address name
    db "Symbo", $F0 ; id 5
SuggestedName_06:: ; heuristic: name entry suggestion; C0
Data_014_7A5B:: ; address name
    db "Whest", $F0 ; id 6
SuggestedName_07:: ; heuristic: name entry suggestion; C0
Data_014_7A61:: ; address name
    db "Zerro", $F0 ; id 7
SuggestedName_08:: ; heuristic: name entry suggestion; C0
Data_014_7A67:: ; address name
    db "Alyah", $F0 ; id 8
SuggestedName_09:: ; heuristic: name entry suggestion; C0
Data_014_7A6D:: ; address name
    db "Cerol", $F0 ; id 9
SuggestedName_0A:: ; heuristic: name entry suggestion; C0
Data_014_7A73:: ; address name
    db "Varel", $F0 ; id 10
SuggestedName_0B:: ; heuristic: name entry suggestion; C0
Data_014_7A79:: ; address name
    db "Garon", $F0 ; id 11
SuggestedName_0C:: ; heuristic: name entry suggestion; C0
Data_014_7A7F:: ; address name
    db "Altho", $F0 ; id 12
SuggestedName_0D:: ; heuristic: name entry suggestion; C0
Data_014_7A85:: ; address name
    db "Munon", $F0 ; id 13
SuggestedName_0E:: ; heuristic: name entry suggestion; C0
Data_014_7A8B:: ; address name
    db "Alfer", $F0 ; id 14
SuggestedName_0F:: ; heuristic: name entry suggestion; C0
Data_014_7A91:: ; address name
    db "Totum", $F0 ; id 15
SuggestedName_10:: ; heuristic: name entry suggestion; C0
Data_014_7A97:: ; address name
    db "Junno", $F0 ; id 16
SuggestedName_11:: ; heuristic: name entry suggestion; C0
Data_014_7A9D:: ; address name
    db "Weib", $9F, $F0 ; id 17
SuggestedName_12:: ; heuristic: name entry suggestion; C0
Data_014_7AA3:: ; address name
    db "Torma", $F0 ; id 18
SuggestedName_13:: ; heuristic: name entry suggestion; C0
Data_014_7AA9:: ; address name
    db "Hukku", $F0 ; id 19
SuggestedName_14:: ; heuristic: name entry suggestion; C0
Data_014_7AAF:: ; address name
    db "Gettu", $F0 ; id 20
SuggestedName_15:: ; heuristic: name entry suggestion; C0
Data_014_7AB5:: ; address name
    db "Pidza", $F0 ; id 21
SuggestedName_16:: ; heuristic: name entry suggestion; C0
Data_014_7ABB:: ; address name
    db "Nakk", $9F, $F0 ; id 22
SuggestedName_17:: ; heuristic: name entry suggestion; C0
Data_014_7AC1:: ; address name
    db "Sulo", $9F, $F0 ; id 23
SuggestedName_18:: ; heuristic: name entry suggestion; C0
Data_014_7AC7:: ; address name
    db "Olgan", $F0 ; id 24
SuggestedName_19:: ; heuristic: name entry suggestion; C0
Data_014_7ACD:: ; address name
    db "Sefti", $F0 ; id 25
SuggestedName_1A:: ; heuristic: name entry suggestion; C0
Data_014_7AD3:: ; address name
    db "Oshan", $F0 ; id 26
SuggestedName_1B:: ; heuristic: name entry suggestion; C0
Data_014_7AD9:: ; address name
    db "Nocko", $F0 ; id 27
SuggestedName_1C:: ; heuristic: name entry suggestion; C0
Data_014_7ADF:: ; address name
    db "Oltho", $F0 ; id 28
SuggestedName_1D:: ; heuristic: name entry suggestion; C0
Data_014_7AE5:: ; address name
    db "Mazer", $F0 ; id 29
SuggestedName_1E:: ; heuristic: name entry suggestion; C0
Data_014_7AEB:: ; address name
    db "Hyde", $9F, $F0 ; id 30
SuggestedName_1F:: ; heuristic: name entry suggestion; C0
Data_014_7AF1:: ; address name
    db "Orora", $F0 ; id 31
SuggestedName_20:: ; heuristic: name entry suggestion; C0
Data_014_7AF7:: ; address name
    db "Varli", $F0 ; id 32
SuggestedName_21:: ; heuristic: name entry suggestion; C0
Data_014_7AFD:: ; address name
    db "Offsi", $F0 ; id 33
SuggestedName_22:: ; heuristic: name entry suggestion; C0
Data_014_7B03:: ; address name
    db "Kapta", $F0 ; id 34
SuggestedName_23:: ; heuristic: name entry suggestion; C0
Data_014_7B09:: ; address name
    db "Jass", $9F, $F0 ; id 35
SuggestedName_24:: ; heuristic: name entry suggestion; C0
Data_014_7B0F:: ; address name
    db "Zeik", $9F, $F0 ; id 36
SuggestedName_25:: ; heuristic: name entry suggestion; C0
Data_014_7B15:: ; address name
    db "Yunn", $9F, $F0 ; id 37
SuggestedName_26:: ; heuristic: name entry suggestion; C0
Data_014_7B1B:: ; address name
    db "Junia", $F0 ; id 38
SuggestedName_27:: ; heuristic: name entry suggestion; C0
Data_014_7B21:: ; address name
    db "Vul", $9F, $9F, $F0 ; id 39
SuggestedName_28:: ; heuristic: name entry suggestion; C0
Data_014_7B27:: ; address name
    db "Piell", $F0 ; id 40
SuggestedName_29:: ; heuristic: name entry suggestion; C0
Data_014_7B2D:: ; address name
    db "Bolto", $F0 ; id 41
SuggestedName_2A:: ; heuristic: name entry suggestion; C0
Data_014_7B33:: ; address name
    db "Vulo", $9F, $F0 ; id 42
SuggestedName_2B:: ; heuristic: name entry suggestion; C0
Data_014_7B39:: ; address name
    db "Jikil", $F0 ; id 43
SuggestedName_2C:: ; heuristic: name entry suggestion; C0
Data_014_7B3F:: ; address name
    db "Sevin", $F0 ; id 44
SuggestedName_2D:: ; heuristic: name entry suggestion; C0
Data_014_7B45:: ; address name
    db "Betha", $F0 ; id 45
SuggestedName_2E:: ; heuristic: name entry suggestion; C0
Data_014_7B4B:: ; address name
    db "Raiss", $F0 ; id 46
SuggestedName_2F:: ; heuristic: name entry suggestion; C0
Data_014_7B51:: ; address name
    db "Kunon", $F0 ; id 47
SuggestedName_30:: ; heuristic: name entry suggestion; C0
Data_014_7B57:: ; address name
    db "Zakul", $F0 ; id 48
SuggestedName_31:: ; heuristic: name entry suggestion; C0
Data_014_7B5D:: ; address name
    db "Kirua", $F0 ; id 49
SuggestedName_32:: ; heuristic: name entry suggestion; C0
Data_014_7B63:: ; address name
    db "Corbi", $F0 ; id 50
SuggestedName_33:: ; heuristic: name entry suggestion; C0
Data_014_7B69:: ; address name
    db "Fitey", $F0 ; id 51
SuggestedName_34:: ; heuristic: name entry suggestion; C0
Data_014_7B6F:: ; address name
    db "Evin", $9F, $F0 ; id 52
SuggestedName_35:: ; heuristic: name entry suggestion; C0
Data_014_7B75:: ; address name
    db "Kuloe", $F0 ; id 53
SuggestedName_36:: ; heuristic: name entry suggestion; C0
Data_014_7B7B:: ; address name
    db "Tudi", $9F, $F0 ; id 54
SuggestedName_37:: ; heuristic: name entry suggestion; C0
Data_014_7B81:: ; address name
    db "Ithy", $9F, $F0 ; id 55
SuggestedName_38:: ; heuristic: name entry suggestion; C0
Data_014_7B87:: ; address name
    db "Ruu", $9F, $9F, $F0 ; id 56
SuggestedName_39:: ; heuristic: name entry suggestion; C0
Data_014_7B8D:: ; address name
    db "Garri", $F0 ; id 57
SuggestedName_3A:: ; heuristic: name entry suggestion; C0
Data_014_7B93:: ; address name
    db "Dabu", $9F, $F0 ; id 58
SuggestedName_3B:: ; heuristic: name entry suggestion; C0
Data_014_7B99:: ; address name
    db "Vehda", $F0 ; id 59
SuggestedName_3C:: ; heuristic: name entry suggestion; C0
Data_014_7B9F:: ; address name
    db "Karto", $F0 ; id 60
SuggestedName_3D:: ; heuristic: name entry suggestion; C0
Data_014_7BA5:: ; address name
    db "Bia", $9F, $9F, $F0 ; id 61
SuggestedName_3E:: ; heuristic: name entry suggestion; C0
Data_014_7BAB:: ; address name
    db "Mutah", $F0 ; id 62
SuggestedName_3F:: ; heuristic: name entry suggestion; C0
Data_014_7BB1:: ; address name
    db "Monsu", $F0 ; id 63
SuggestedName_40:: ; heuristic: name entry suggestion; C0
Data_014_7BB7:: ; address name
    db "Pulk", $9F, $F0 ; id 64
SuggestedName_41:: ; heuristic: name entry suggestion; C0
Data_014_7BBD:: ; address name
    db "Saiz", $9F, $F0 ; id 65
SuggestedName_42:: ; heuristic: name entry suggestion; C0
Data_014_7BC3:: ; address name
    db "Zeil", $9F, $F0 ; id 66
SuggestedName_43:: ; heuristic: name entry suggestion; C0
Data_014_7BC9:: ; address name
    db "Kazna", $F0 ; id 67
SuggestedName_44:: ; heuristic: name entry suggestion; C0
Data_014_7BCF:: ; address name
    db "Pikka", $F0 ; id 68
SuggestedName_45:: ; heuristic: name entry suggestion; C0
Data_014_7BD5:: ; address name
    db "Derzo", $F0 ; id 69
SuggestedName_46:: ; heuristic: name entry suggestion; C0
Data_014_7BDB:: ; address name
    db "Muey", $9F, $F0 ; id 70
SuggestedName_47:: ; heuristic: name entry suggestion; C0
Data_014_7BE1:: ; address name
    db "Mysti", $F0 ; id 71
SuggestedName_48:: ; heuristic: name entry suggestion; C0
Data_014_7BE7:: ; address name
    db "Saman", $F0 ; id 72
SuggestedName_49:: ; heuristic: name entry suggestion; C0
Data_014_7BED:: ; address name
    db "Iana", $9F, $F0 ; id 73
SuggestedName_4A:: ; heuristic: name entry suggestion; C0
Data_014_7BF3:: ; address name
    db "Mikko", $F0 ; id 74
SuggestedName_4B:: ; heuristic: name entry suggestion; C0
Data_014_7BF9:: ; address name
    db "Topaz", $F0 ; id 75
SuggestedName_4C:: ; heuristic: name entry suggestion; C0
Data_014_7BFF:: ; address name
    db "Pulam", $F0 ; id 76
SuggestedName_4D:: ; heuristic: name entry suggestion; C0
Data_014_7C05:: ; address name
    db "Nyar", $9F, $F0 ; id 77
SuggestedName_4E:: ; heuristic: name entry suggestion; C0
Data_014_7C0B:: ; address name
    db "Zonia", $F0 ; id 78
SuggestedName_4F:: ; heuristic: name entry suggestion; C0
Data_014_7C11:: ; address name
    db "Pulin", $F0 ; id 79
SuggestedName_50:: ; heuristic: name entry suggestion; C0
Data_014_7C17:: ; address name
    db "Knull", $F0 ; id 80
SuggestedName_51:: ; heuristic: name entry suggestion; C0
Data_014_7C1D:: ; address name
    db "Rauli", $F0 ; id 81
SuggestedName_52:: ; heuristic: name entry suggestion; C0
Data_014_7C23:: ; address name
    db "Carin", $F0 ; id 82
SuggestedName_53:: ; heuristic: name entry suggestion; C0
Data_014_7C29:: ; address name
    db "Mylki", $F0 ; id 83
SuggestedName_54:: ; heuristic: name entry suggestion; C0
Data_014_7C2F:: ; address name
    db "Alfua", $F0 ; id 84
SuggestedName_55:: ; heuristic: name entry suggestion; C0
Data_014_7C35:: ; address name
    db "Furil", $F0 ; id 85
SuggestedName_56:: ; heuristic: name entry suggestion; C0
Data_014_7C3B:: ; address name
    db "Hamen", $F0 ; id 86
SuggestedName_57:: ; heuristic: name entry suggestion; C0
Data_014_7C41:: ; address name
    db "Ligg", $9F, $F0 ; id 87
SuggestedName_58:: ; heuristic: name entry suggestion; C0
Data_014_7C47:: ; address name
    db "Limme", $F0 ; id 88
SuggestedName_59:: ; heuristic: name entry suggestion; C0
Data_014_7C4D:: ; address name
    db "Hohmi", $F0 ; id 89
SuggestedName_5A:: ; heuristic: name entry suggestion; C0
Data_014_7C53:: ; address name
    db "Liset", $F0 ; id 90
SuggestedName_5B:: ; heuristic: name entry suggestion; C0
Data_014_7C59:: ; address name
    db "Katua", $F0 ; id 91
SuggestedName_5C:: ; heuristic: name entry suggestion; C0
Data_014_7C5F:: ; address name
    db "Paela", $F0 ; id 92
SuggestedName_5D:: ; heuristic: name entry suggestion; C0
Data_014_7C65:: ; address name
    db "Putti", $F0 ; id 93
SuggestedName_5E:: ; heuristic: name entry suggestion; C0
Data_014_7C6B:: ; address name
    db "Mymee", $F0 ; id 94
SuggestedName_5F:: ; heuristic: name entry suggestion; C0
Data_014_7C71:: ; address name
    db "Annis", $F0 ; id 95
SuggestedName_60:: ; heuristic: name entry suggestion; C0
Data_014_7C77:: ; address name
    db "Makki", $F0 ; id 96
SuggestedName_61:: ; heuristic: name entry suggestion; C0
Data_014_7C7D:: ; address name
    db "Jemni", $F0 ; id 97
SuggestedName_62:: ; heuristic: name entry suggestion; C0
Data_014_7C83:: ; address name
    db "Chaar", $F0 ; id 98
SuggestedName_63:: ; heuristic: name entry suggestion; C0
Data_014_7C89:: ; address name
    db "Mafin", $F0 ; id 99
SuggestedName_64:: ; heuristic: name entry suggestion; C0
Data_014_7C8F:: ; address name
    db "Piann", $F0 ; id 100
SuggestedName_65:: ; heuristic: name entry suggestion; C0
Data_014_7C95:: ; address name
    db "Malin", $F0 ; id 101
SuggestedName_66:: ; heuristic: name entry suggestion; C0
Data_014_7C9B:: ; address name
    db "Capli", $F0 ; id 102
SuggestedName_67:: ; heuristic: name entry suggestion; C0
Data_014_7CA1:: ; address name
    db "Multy", $F0 ; id 103
SuggestedName_68:: ; heuristic: name entry suggestion; C0
Data_014_7CA7:: ; address name
    db "Schai", $F0 ; id 104
SuggestedName_69:: ; heuristic: name entry suggestion; C0
Data_014_7CAD:: ; address name
    db "Hylda", $F0 ; id 105
SuggestedName_6A:: ; heuristic: name entry suggestion; C0
Data_014_7CB3:: ; address name
    db "Sharo", $F0 ; id 106
SuggestedName_6B:: ; heuristic: name entry suggestion; C0
Data_014_7CB9:: ; address name
    db "Millk", $F0 ; id 107
SuggestedName_6C:: ; heuristic: name entry suggestion; C0
Data_014_7CBF:: ; address name
    db "Milda", $F0 ; id 108
SuggestedName_6D:: ; heuristic: name entry suggestion; C0
Data_014_7CC5:: ; address name
    db "Konni", $F0 ; id 109
SuggestedName_6E:: ; heuristic: name entry suggestion; C0
Data_014_7CCB:: ; address name
    db "Sundi", $F0 ; id 110
SuggestedName_6F:: ; heuristic: name entry suggestion; C0
Data_014_7CD1:: ; address name
    db "Komet", $F0 ; id 111
SuggestedName_70:: ; heuristic: name entry suggestion; C0
Data_014_7CD7:: ; address name
    db "Melan", $F0 ; id 112
SuggestedName_71:: ; heuristic: name entry suggestion; C0
Data_014_7CDD:: ; address name
    db "Moura", $F0 ; id 113
SuggestedName_72:: ; heuristic: name entry suggestion; C0
Data_014_7CE3:: ; address name
    db "Monez", $F0 ; id 114
SuggestedName_73:: ; heuristic: name entry suggestion; C0
Data_014_7CE9:: ; address name
    db "Ellan", $F0 ; id 115
SuggestedName_74:: ; heuristic: name entry suggestion; C0
Data_014_7CEF:: ; address name
    db "Eriss", $F0 ; id 116
SuggestedName_75:: ; heuristic: name entry suggestion; C0
Data_014_7CF5:: ; address name
    db "Suloe", $F0 ; id 117
SuggestedName_76:: ; heuristic: name entry suggestion; C0
Data_014_7CFB:: ; address name
    db "Flora", $F0 ; id 118
SuggestedName_77:: ; heuristic: name entry suggestion; C0
Data_014_7D01:: ; address name
    db "Nithe", $F0 ; id 119
SuggestedName_78:: ; heuristic: name entry suggestion; C0
Data_014_7D07:: ; address name
    db "Yuwmi", $F0 ; id 120
SuggestedName_79:: ; heuristic: name entry suggestion; C0
Data_014_7D0D:: ; address name
    db "Yurro", $F0 ; id 121
SuggestedName_7A:: ; heuristic: name entry suggestion; C0
Data_014_7D13:: ; address name
    db "Paize", $F0 ; id 122
SuggestedName_7B:: ; heuristic: name entry suggestion; C0
Data_014_7D19:: ; address name
    db "Celen", $F0 ; id 123
SuggestedName_7C:: ; heuristic: name entry suggestion; C0
Data_014_7D1F:: ; address name
    db "Heren", $F0 ; id 124
SuggestedName_7D:: ; heuristic: name entry suggestion; C0
Data_014_7D25:: ; address name
    db "Velah", $F0 ; id 125
SuggestedName_7E:: ; heuristic: name entry suggestion; C0
Data_014_7D2B:: ; address name
    db "Minto", $F0 ; id 126
SuggestedName_7F:: ; heuristic: name entry suggestion; C0
Data_014_7D31:: ; address name
    db "Ritto", $F0 ; id 127
SuggestedName_80:: ; heuristic: name entry suggestion; C0
Data_014_7D37:: ; address name
    db "Luman", $F0 ; id 128
SuggestedName_81:: ; heuristic: name entry suggestion; C0
Data_014_7D3D:: ; address name
    db "Venni", $F0 ; id 129
SuggestedName_82:: ; heuristic: name entry suggestion; C0
Data_014_7D43:: ; address name
    db "Teryl", $F0 ; id 130
SuggestedName_83:: ; heuristic: name entry suggestion; C0
Data_014_7D49:: ; address name
    db "Krim", $9F, $F0 ; id 131
SuggestedName_84:: ; heuristic: name entry suggestion; C0
Data_014_7D4F:: ; address name
    db "Atch", $9F, $F0 ; id 132
SuggestedName_85:: ; heuristic: name entry suggestion; C0
Data_014_7D55:: ; address name
    db "Arle", $9F, $F0 ; id 133
SuggestedName_86:: ; heuristic: name entry suggestion; C0
Data_014_7D5B:: ; address name
    db "Phes", $9F, $F0 ; id 134
SuggestedName_87:: ; heuristic: name entry suggestion; C0
Data_014_7D61:: ; address name
    db "Riza", $9F, $F0 ; id 135
SuggestedName_88:: ; heuristic: name entry suggestion; C0
Data_014_7D67:: ; address name
    db "Pestl", $F0 ; id 136
SuggestedName_89:: ; heuristic: name entry suggestion; C0
Data_014_7D6D:: ; address name
    db "Almmo", $F0 ; id 137
SuggestedName_8A:: ; heuristic: name entry suggestion; C0
Data_014_7D73:: ; address name
    db "Forte", $F0 ; id 138
SuggestedName_8B:: ; heuristic: name entry suggestion; C0
Data_014_7D79:: ; address name
    db "Soffi", $F0 ; id 139

; only called from routines of HibernateMenu (E-0098)
; 4 call sites from 4 routines (e.g. HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot, HibernateMenu_ChooseRecords_UnpackRecordFromBank1Slot, HibernateMenu_ChooseToHibernate_SetArg5ToListEntriesCell5_Case42, HibernateMenu_IndexListEntry_SetArg5ToListEntriesCell5)
; reads: wArg1
; writes: rRAMG2, rRAMB, wArg5, wArg6, wArg7
; points at: sCompactRecords, sRecords, wRecordBufB
HibernateMenu_Multiply8::
Func_014_7D7F:: ; address name
    ld a, [wArg1]
    cp a, $1E
    jr nc, .skip3
    cp a, $1D
    jr z, .skip
    ld c, $6F
    call Multiply8
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, sCompactRecords
    add hl, de
    jr .skip2

.skip:
    ld hl, sRecords
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a

.skip2:
    ld b, $6F

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop

.skip3:
    ld hl, sCompactRecords
    ld de, sCompactRecords + $6F
    xor a, a
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
    ld a, $6F
    add_a_to_hl
    push hl

.restore2:
    pop hl
    pop de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp a, $1D
    jr c, .loop2
    jr .skip4

.restore3:
    pop hl
    pop de
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    ld b, $6E

.loop3:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop3
    jr .next

.skip4:
    ld hl, sCompactRecords
    xor a, a
    ld [rRAMB], a
    ld c, $00

.loop4:
    ld a, [hl]
    bit 7, a
    jr z, .skip5
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $1D
    jr c, .loop4
    jr .skip6

.skip5:
    push hl
    ld de, wRecordBufB
    ld hl, sRecords
    ld a, $01
    ld [rRAMB], a
    ld b, $6F

.loop5:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop5
    ld hl, sRecords
    ld b, $6F

.loop6:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop6
    pop hl
    xor a, a
    ld [rRAMB], a
    ld de, wRecordBufB
    ld b, $6F

.loop7:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop7

.skip6:
    xor a, a
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
    ld b, $6F

.loop9:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop9
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

.skip7:
    ld a, $6F
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1D
    jr c, .loop8
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld a, [hl]
    bit 7, a
    jr nz, .set_arg5_to_FF
    jr .set_arg5

.set_arg5_to_FF:
    ld a, $FF
    ld [wArg5], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; clears SRAM record wD7F1 (when below 30) and moves the later stored records up to fill the gap, updating the party list (E-0131)
; 19 call sites from 18 routines (e.g. RunLinkSession4ScreenState_ResetAndSignal_Case04_ComputeBreedingChild, NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc, HibernateMenu_ChooseRecords_PackRecordFieldsToBank1Slot, HibernateMenu_ChooseToHibernate_PackRecordFieldsToBank1Slot, ...)
; reads: wArg1, wArg2, wPartyCount
; writes: rRAMG2, rRAMB, wArg3, wArg5, wArg6, wArg7, wPartyCount
; points at: sRecords, sRecord1, wPartyList
DeleteSRAMRecordAndCompact::
Func_014_7E96:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg1]
    cp a, $1E
    jr nc, .skip
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld b, $A5

.loop:
    xor a, a
    ld [hl+], a
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
    cp a, $01
    jr z, .restore
    cp a, $02
    jr z, .restore
    ld a, [de]
    cp a, $01
    jr z, .restore3
    cp a, $02
    jr z, .restore3
    jr .restore2

.restore:
    pop hl
    ld a, $A5
    add_a_to_hl
    push hl

.restore2:
    pop hl
    pop de
    ld a, $A5
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp a, $1E
    jr c, .loop2
    jr .clear_arg3

.restore3:
    pop hl
    pop de
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    ld b, $A4

.loop3:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop3
    jr .next

.clear_arg3:
    xor a, a
    ld [wArg3], a
    ld a, [wArg2]
    and a, a
    jr nz, .check_arg1
    ld a, [wArg1]
    cp a, $1E
    jr nc, .check_arg1
    ld b, a
    ld a, [wPartyCount]
    ld e, a
    ld c, $00
    ld hl, wPartyList

.loop4:
    ld a, [hl]
    cp a, b
    jr z, .skip2
    inc hl
    inc c
    ld a, c
    cp a, e
    jr c, .loop4
    jp .check_arg1

.skip2:
    ld a, c
    cp a, $02
    jr z, .check_party_count
    inc hl
    ld a, [hl-]
    ld [hl+], a
    inc c
    jr .skip2

.check_party_count:
    xor a, a
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    ld a, $01
    ld [wArg3], a

.check_arg1:
    ld hl, wPartyList
    ld a, [wArg1]
    cp a, $1E
    jr nc, .skip3
    ld c, $00

.loop5:
    ld a, [hl]
    ld b, a
    ld a, [wArg1]
    cp a, b
    jr nc, .next2
    ld a, b
    dec a
    ld [hl], a

.next2:
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, .loop5

.skip3:
    ld hl, sRecords
    ld c, $00

.loop6:
    ld a, [hl]
    cp a, $01
    jr z, .skip4
    cp a, $02
    jr z, .skip4
    ld a, c
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, h
    ld [wArg7], a
    ld b, $A5

.loop7:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop7
    xor a, a
    ld [rRAMG2], a
    ret

.skip4:
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, $1E
    jr c, .loop6
    ld a, $FF
    ld [wArg5], a
    xor a, a
    ld [rRAMG2], a
    ret

; only called from CreateMonsterRecordOfKindTemp1_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord)
; reads: wWorkBuf
CreateMonsterRecordOfKindTemp1_Sub01_Sub01_ReadWorkBuf::
Func_014_7F9C:: ; address name
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
    db $FA, $9E, $D0, $4F, $06, $00, $21, $1F, $79

.skip:
    add hl, bc
    add hl, bc
    deref_hl
    ld a, [wWorkBuf + $2]
    ld e, a
    ld a, [wWorkBuf + $3]
    ld d, a

.loop:
    ld a, [hl+]
    cp a, $9F
    jr z, .loop
    ld [de], a
    cp a, $F0
    jr z, .return
    inc de
    jr .loop

.return:
    ret

; no direct call (reached through a table, a jump or a vector)
RunBattleActions_StatusChecks_CheckAction_NopRun_Bank14:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 32:7A49; C0
Func_014_7FD4:: ; address name
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
