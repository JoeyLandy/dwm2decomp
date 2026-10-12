SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

; implements script command type EE (SCRIPT_BREED_CLOSE): ends the breeding (and medal prize) session and clears wMessageMode; reached through ScriptCommandEE in bank $10 (E-0038, E-0244)
; 4 call sites from 4 routines (e.g. CloseRenameMenu_ToCloseBreedMenu, ScriptCommandEE, CloseMenuE9_ToCloseBreedMenu, CloseMenuE9_ToCloseBreedMenu_Case03)
; reads: wScreenList
CloseBreedMenu::
Func_015_4001:: ; address name
    ld a, [wScreenList]
    rst $00
    dw CloseBreedMenu_CopyBytesDEToHL_Bank15
    dw CloseBreedMenu_CopyGlyphTileListFromBank1F_Bank15
    dw CloseBreedMenu_FillTilesBxC
    dw CloseBreedMenu_DrawRecordListNameTiles_Bank1D

; entry 0 of the `rst $00` table in CloseBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenList
; writes: wScreenList
; points at: wScreenTileBuffer, wScreenAttrBuffer
CloseBreedMenu_CopyBytesDEToHL_Bank15::
Jump_015_400D:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank15
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

.call_bg_map_address_at_scroll_bank15:
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 1 of the `rst $00` table in CloseBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenList
; writes: wGlyphListPos, wGlyphListStart, wScreenState, wScreenStep, wMenuState, wScreenList, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
CloseBreedMenu_CopyGlyphTileListFromBank1F_Bank15::
Jump_015_403F:: ; address name
    ld hl, TileCopyDestList_15_72A9
    ld de, TileCopySrcList_15_72FF
    call CopyGlyphTileListFromBank1F_Bank15
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
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

; entry 2 of the `rst $00` table in CloseBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenList
; writes: wScreenList
CloseBreedMenu_FillTilesBxC::
Jump_015_4076:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
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
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; entry 3 of the `rst $00` table in CloseBreedMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode, wScreenList, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wTextBuf0, wTextWindowTileLo
CloseBreedMenu_DrawRecordListNameTiles_Bank1D::
Jump_015_40AE:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
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
    ld hl, wTextBuf0
    ld b, $10

.loop2:
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, .loop2
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, $80
    ldh [hSpriteHideTile], a
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

; implements script command type ED (SCRIPT_BREED): breeding: 'Which will be the base monster?', 'And what will its mate be?' (mode 5, bank $1B strings); reached through ScriptCommandED in bank $10 (E-0038, E-0244)
; 27 call sites from 27 routines (e.g. EggServiceMenu_ChooseAndPay_ToBreedMenu, NpcBreedMenu_ChooseAndBreed_ToBreedMenu, NpcBreedMenu_ChooseAndBreed_BreedMenu, NpcBreedMenu_Case11_ToBreedMenu, ...)
; reads: wScreenState
BreedMenu::
Func_015_40FA:: ; address name
    ld a, [wScreenState]
    rst $00
    dw BreedMenu_Init
    dw BreedMenu_Setup
    dw BreedMenu_ToHandleThreeOptionMenuInput_15
    dw BreedMenu_WriteTwoChoiceCursorAndScreenStateEtc
    dw BreedMenu_ChooseParents
    dw BreedMenu_Case05
    dw BreedMenu_NameEntry
    dw BreedMenu_ReturnToMap
    dw BreedMenu_TalkEvent17ThenNameEntry
    dw BreedMenu_CopyToChildThenTalkEvent16
    dw BreedMenu_TalkEvent15
    dw BreedMenu_Case0B
    dw BreedMenu_SwapMonstersMenu
    dw BreedMenu_SwapMonstersMenu_Case0D
    dw BreedMenu_SwapMonstersMenu_Case0D
    dw BreedMenu_Case0F
    dw BreedMenu_Case10
    dw BreedMenu_Case11
    dw BreedMenu_Case12

; state 0 of BreedMenu: clears $6F bytes from wScreenState (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
BreedMenu_Init::
Jump_015_4124:: ; address name
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
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, .set_message_mode_to_05
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

.set_message_mode_to_05:
    ld a, $05
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

; draws the two boxes and the gold box (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Setup::
Jump_015_4167:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw DrawPair72A9And72C5AndStep
    dw DrawGoldBoxAndStep_Bank15
    dw BreedMenu_Setup_CopyRectTo20ByteRows_Bank15

; runs Func_015_6374 for Data_015_72A9 and Data_015_72C5, then wD781 += 1 (E-0122)
; 4 call sites from 4 routines (e.g. BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case3A, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A, BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15)
; reads: wScreenStep
; writes: wScreenStep
DrawPair72A9And72C5AndStep::
Func_015_4171:: ; address name
    ld hl, TileCopyDestList_15_72A9
    ld de, TileCopySrcList_15_72C5
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies box Data_015_7291 to wC370 and writes the gold as five digit tiles at wC386, then wD781 += 1 (E-0125)
; 6 call sites from 6 routines (e.g. BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case3A, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep, BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15, BreedMenu_Case05_DrawGoldBoxAndStep_Bank15, ...)
; reads: wScreenStep
; writes: wScreenStep
; points at: wGoldLo, wDigits, wArg3
DrawGoldBoxAndStep_Bank15::
Func_015_4182:: ; address name
    ld de, TileRect_15_7291
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank15
    ld hl, wGoldLo
    ld de, wDigits
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1
    ld hl, wWindowTileBuffer + $86
    ld de, wArg3
    ld c, $00

.loop:
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in BreedMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
BreedMenu_Setup_CopyRectTo20ByteRows_Bank15::
Jump_015_41BD:: ; address name
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
BreedMenu_ToHandleThreeOptionMenuInput_15::
Jump_015_41E1:: ; address name
    call HandleThreeOptionMenuInput_15
    ret

; entry 3 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wRecordsFlagged, wScreenState
; writes: wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
BreedMenu_WriteTwoChoiceCursorAndScreenStateEtc::
Jump_015_41E5:: ; address name
    ld a, [wGridCursorX]
    and a, a
    jr z, .check_screen_state
    jr .call_list_records_in_use_with_byte6_e_set

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

.call_list_records_in_use_with_byte6_e_set:
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wRecordsFlagged]
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; BreedMenu screen state 4, by wScreenStep: lists the records in use, takes two monsters from paged lists, then ComputeBreedingChild and the name-entry state
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_ChooseParents::
Jump_015_422B:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case00
    dw BreedMenu_ChooseParents_ClearTileAreas1240_1700_14E0
    dw BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear
    dw BreedMenu_ChooseParents_DrawRecordListPageNames
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5
    dw BreedMenu_ChooseParents_FillTilesBxC
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case06
    dw BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep
    dw BreedMenu_ChooseParents_UpdatePagedListCursor
    dw BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case09
    dw BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A
    dw BreedMenu_ChooseParents_BlankWordTableTargets
    dw BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_ChooseParents_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep
    dw BreedMenu_ChooseParents_BlankWordTableTargets_Case10
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case11
    dw BreedMenu_ChooseParents_BlankWordTableTargets_Case12
    dw BreedMenu_ChooseParents_ToBreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc
    dw BreedMenu_ChooseParents_ClearThreeTileRows
    dw BreedMenu_ChooseParents_FillTilesBxC_Case15
    dw BreedMenu_ChooseParents_LoadRecordSelectedRecordByte0EBit0
    dw BreedMenu_ChooseParents_DrawRecordListPageNames
    dw DrawListEntriesCell5IconAndLevelAndStep
    dw BreedMenu_ChooseParents_ToClearThreeTileRowsAndStep
    dw DrawListEntriesCell5RecordNamesAndStep
    dw BreedMenu_ChooseParents_WriteNameEntryStateAndNameEntrySubStateEtc
    dw BreedMenu_ChooseParents_ComputeBreedingChild
    dw DrawScreenBufferAtScrollAndIncScreenStep
    dw BreedMenu_ChooseParents_UpdatePagedListCursor_Case1E
    dw BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ChooseParents_LoadTileListSixPerCall
    dw BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_ChooseParents_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_ChooseParents_ClearTileAreas2700_1750_17D0
    dw BreedMenu_ChooseParents_BlankWordTableTargets_Case25
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case26
    dw BreedMenu_ChooseParents_TestBitInFieldAtArg3
    dw BreedMenu_ChooseParents_TestBitInFieldAtArg3_Case28
    dw BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript
    dw DrawRect70C5IfLinkModeAndStep
    dw BreedMenu_ChooseParents_ShowSaveFileInfoWindow
    dw BreedMenu_ChooseParents_DrawBottomBoxForLinkAndSetScreenSubStep
    dw BreedMenu_ChooseParents_WriteScreenStep
    dw BreedMenu_ChooseParents_WriteScreenStepAndTwoChoiceCursor
    dw BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D
    dw BreedMenu_ChooseParents_DrawRect70C5IfLinkModeAndStep
    dw BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15
    dw BreedMenu_ChooseParents_LoadTileListSixPerCall_Case32
    dw BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep
    dw BreedMenu_ChooseParents_StoreBAtWordTableEntry_Bank15
    dw BreedMenu_ChooseParents_BlankWordTableTargets
    dw BreedMenu_ChooseParents_WriteScreenSubStepAndScreenStepEtc
    dw BreedMenu_ChooseParents_DrawRect70C5IfLinkModeAndStep
    dw BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15
    dw BreedMenu_ChooseParents_LoadTileListSixPerCall_Case32
    dw BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case3A
    dw BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15_Case3B
    dw BreedMenu_ChooseParents_TenTimesTemp0PlusTenToDigits
    dw BreedMenu_ChooseParents_CopyFromBankWaitVRAM
    dw BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E
    dw BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D_Case3F
    dw BreedMenu_ChooseParents_SetScreenStep
    dw BreedMenu_ChooseParents_TenTimesTemp0PlusTen

; entry 0 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wListCursor, wListPageIndex, wCursorBlinkAE, wChoiceCursor, wScreenStep
BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case00::
Jump_015_42B3:: ; address name
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_42F4
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_15_42F4::
Data_015_42F4:: ; address name
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

; entry 1 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_ClearTileAreas1240_1700_14E0::
Jump_015_434C:: ; address name
    call ClearTileAreas1240_1700_14E0
    ld de, TileRect_15_747D
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear::
Jump_015_4363:: ; address name
    farcall ListRecordsInUseWithByte6EClear

BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5::
Jump_015_4369:: ; address name
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank15
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank15
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

; entry 3 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1
BreedMenu_ChooseParents_DrawRecordListPageNames::
Jump_015_43AC:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 4 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
BreedMenu_ChooseParents_SetArg5ToListEntriesCell5::
Jump_015_43BD:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, TileRect_15_74D5
    ld hl, wWindowTileBuffer + $BC
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $D6
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    call DrawRecordField0EMarkAndField56Digits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
BreedMenu_ChooseParents_FillTilesBxC::
Jump_015_43F4:: ; address name
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

; entry 6 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case06::
Jump_015_4418:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; DrawScreenBufferRect_Bank15 (20 x 13 from buffer offset $01CC at the scroll origin), then wD781 += 1 (E-0119)
; 1 call site from 1 routine (e.g. BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep)
; reads: wScreenStep
; writes: wScreenStep
DrawScreenBufferAtScrollAndIncScreenStep::
Func_015_4439:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep::
Jump_015_444D:: ; address name
    ld a, [wListCursor]
    ld b, $BB
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    call DrawScreenBufferAtScrollAndIncScreenStep
    ld a, [wListCursor]
    ld b, $C3
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    ret

; entry 8 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_UpdatePagedListCursor::
Jump_015_4467:: ; address name
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
    add a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
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

; entry 9 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case09::
Jump_015_44D3:: ; address name
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_6FA3
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A::
Jump_015_451B:: ; address name
    call DrawPair72A9And72C5AndStep
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15::
Jump_015_4550:: ; address name
    ld de, TileRect_15_7379
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wChoiceCursor, wScreenStep
BreedMenu_ChooseParents_CopyGlyphTileListFromBank1F_Bank15::
Jump_015_4570:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld hl, TileCopyDestList_15_72E1
    ld de, TileCopySrcList_15_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep::
Jump_015_45A5:: ; address name
    ld de, BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep_Data
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_BlankWordTableTargets_Case10::
Jump_015_45B9:: ; address name
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $08
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wListCount, wScreenStep, wPartyCount, wPartyList, wListCursor, ...
; writes: rRAMG2, rRAMB, wArg5, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wSelectedRecord, ...
; points at: wListEntries
BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case11::
Jump_015_45DC:: ; address name
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
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wArg5], a
    ld hl, wListEntries
    ld c, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld b, a
    ld a, [wArg5]
    cp a, b
    jr nz, .restore
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr nz, .loop
    pop hl
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.restore:
    pop bc
    pop hl
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, .check_party_count
    pop hl
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_party_count:
    pop hl
    ld a, [wPartyCount]
    cp a, $02
    jr nc, .call_set_arg5_to_list_entries_cell5
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr nz, .call_set_arg5_to_list_entries_cell5
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_set_arg5_to_list_entries_cell5:
    farcall SetArg5ToListEntriesCell5
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
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wWindowTileBuffer, wScreenStep
BreedMenu_ChooseParents_BlankWordTableTargets_Case12::
Jump_015_46D3:: ; address name
    ld a, $B6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $A0], a
    ld [wWindowTileBuffer + $C8], a
    ld de, TileRect_15_7541
    ld hl, wWindowTileBuffer + $94
    ld bc, $0C03
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep_Data
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 19 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
BreedMenu_ChooseParents_ToBreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc::
Jump_015_4712:: ; address name
    call BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc
    ret

; entry 20 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_ClearThreeTileRows::
Jump_015_4716:: ; address name
    call ClearThreeTileRows
    ld de, TileRect_15_7565
    ld hl, wWindowTileBuffer + $94
    ld bc, $0C03
    call CopyRectTo20ByteRows_Bank15
    ld de, TileRect_15_7589
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 21 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_FillTilesBxC_Case15::
Jump_015_4739:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call FillTilesBxC
    ld de, TileRect_15_747D
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ChooseParents_LoadRecordSelectedRecordByte0EBit0::
Jump_015_4768:: ; address name
    call LoadRecordSelectedRecordByte0EBit0
    call BreedMenu_WriteListCountAndRAMG2Etc
    jp BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5

; for the record at WD789 cell 5 loads its family icon tile and draws its mark and level at wC426, then wD781 += 1 (E-0124)
; 2 call sites from 2 routines (e.g. BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript, BreedMenu_ChooseParents_ClearTileAreas2700_1750_17D0)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
DrawListEntriesCell5IconAndLevelAndStep::
Func_015_4771:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $126
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    call DrawRecordField0EMarkAndField56Digits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_ToClearThreeTileRowsAndStep::
Jump_015_479C:: ; address name
    call ClearThreeTileRows
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; draws the name and species name of the record at WD789 cell 5, clears wCFA8 and wCFA9 and wD781 += 1 (E-0122)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript, BreedMenu_ChooseParents_ClearTileAreas2700_1750_17D0, BreedMenu_Case12_ClearThreeTileRows)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wNameEntryState, wNameEntrySubState, wScreenStep
DrawListEntriesCell5RecordNamesAndStep::
Func_015_47A7:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesName
    xor a, a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wNameEntryState, wNameEntrySubState, wScreenStep
BreedMenu_ChooseParents_WriteNameEntryStateAndNameEntrySubStateEtc::
Jump_015_47CF:: ; address name
    call BreedMenu_SetArg5ToListEntriesCell5
    xor a, a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 28 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg7, wArg6, wScreenStep
; writes: wArg1, wSpeciesIdLo, wArg2, wSpeciesIdHi, wArg3, wArg4, wArg5, wScreenStep, ...
; points at: wMonsterLibraryBuf, wNameGlyphBuf
BreedMenu_ChooseParents_ComputeBreedingChild::
Jump_015_47E1:: ; address name
    xor a, a
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wArg7]
    cp a, $FF
    jr nz, .read_arg6
    ld a, [wArg6]
    cp a, $FF
    jr z, .skip

.read_arg6:
    ld a, [wArg6]
    ld [wArg1], a
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wArg2], a
    ld [wSpeciesIdHi], a
    ld de, BreedMenu_ChooseParents_ComputeBreedingChild_Data
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    call TestBitInFieldAtArg3
    ld a, [wArg5]
    cp a, $FF
    jr z, .read_arg62
    ld a, [wArg6]
    ld [wArg1], a
    ld a, [wArg7]
    ld [wArg2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp a, $FF
    jr z, .read_arg62
    ld a, [wArg6]
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, .read_arg62

.skip:
    ld c, $00
    ld hl, wNameGlyphBuf

.loop:
    ld a, $98
    ld [hl+], a
    inc c
    ld a, c
    cp a, $09
    jr c, .loop
    ld a, $F0
    ld [hl], a
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $490
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    jr .set_arg5_to_04

.read_arg62:
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wChildRecord + $D
    ld a, [hl]
    and a, $0F
    ld [wWorkBuf], a
    ld a, $C9
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf

.set_arg5_to_04:
    ld c, $00
    ld a, $04
    ld [wArg5], a
    farcall DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_UpdatePagedListCursor_Case1E::
Jump_015_48AE:: ; address name
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
    sub a, $09
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
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
    sub a, $06
    ld [wScreenStep], a
    ret

; entry 31 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wWindowTileBuffer, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15::
Jump_015_491A:: ; address name
    ld c, $03
    ld hl, $01FC
    ld de, $0030
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld a, $B7
    ld [wWindowTileBuffer + $93], a
    ld [wWindowTileBuffer + $A7], a
    call DrawGoldBoxAndStep_Bank15
    ld de, TileRect_15_74D5
    ld hl, wWindowTileBuffer + $BC
    ld bc, $0C01
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15_Data
    ld hl, wWindowTileBuffer + $120
    ld bc, $0C04
    call CopyRectTo20ByteRows_Bank15
    ld de, TileRect_15_4985
    ld hl, wWindowTileBuffer + $93
    ld bc, $0102
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 1 x 2 tiles, one row per line
TileRect_15_4985::
Data_015_4985:: ; address name
    db $B7 ; id 0
    db $B7 ; id 1

; entry 32 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wItemGridX, wItemGridY
; writes: wArg1, wArg2, wArg3, wArg4, wListCursor, wListPageIndex, wTwoChoiceCursor, wChoiceCursor, ...
BreedMenu_ChooseParents_LoadTileListSixPerCall::
Jump_015_4987:: ; address name
    ld a, $9D
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wScreenStep], a
    ret

; entry 36 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_ClearTileAreas2700_1750_17D0::
Jump_015_49C9:: ; address name
    ld de, TileRect_15_75F5
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawListEntriesCell5RecordNamesAndStep
    ld de, TileRect_15_7589
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call DrawListEntriesCell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $25
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

; entry 37 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_BlankWordTableTargets_Case25::
Jump_015_4A2A:: ; address name
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $1E
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 38 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wPartyCount, wSelectedRecord, wPartyList, wScreenStep
; writes: rRAMG2, rRAMB, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case26::
Jump_015_4A4D:: ; address name
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
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, .check_party_count
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp a, $03
    jr z, .clear_two_choice_cursor
    cp a, $01
    jr z, .call_set_arg5_to_list_entries_cell52
    ld a, [wSelectedRecord]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr z, .call_set_arg5_to_list_entries_cell5
    ld a, [wPartyList + $1]
    cp a, b
    jr z, .call_set_arg5_to_list_entries_cell5
    jr .clear_two_choice_cursor

.call_set_arg5_to_list_entries_cell5:
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld b, [hl]
    ld a, [wPartyList]
    cp a, b
    jr z, .set_two_choice_cursor_to_02
    ld a, [wPartyList + $1]
    cp a, b
    jr z, .set_two_choice_cursor_to_02
    jr .clear_two_choice_cursor

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_set_arg5_to_list_entries_cell52:
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld b, [hl]
    ld a, [wPartyList]
    cp a, b
    jr nz, .clear_two_choice_cursor
    jr .set_two_choice_cursor_to_02

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 39 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wDigits, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, ...
; points at: wMonsterLibraryBuf, wNameGlyphBuf, wTextBuf0
BreedMenu_ChooseParents_TestBitInFieldAtArg3::
Jump_015_4B02:: ; address name
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp a, $FF
    jr nz, .set_species_id_lo
    jr .skip

.set_species_id_lo:
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr z, .set_arg1
    jr .skip

.set_arg1:
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld hl, BreedMenu_ChooseParents_ComputeBreedingChild_Data
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp a, $FF
    jr nz, .set_two_choice_cursor_to_01

.skip:
    ld de, wChildRecord + $B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

.skip2:
    ld a, [hl]
    cp a, $F0
    jr z, .skip3
    ld [de], a
    inc de
    inc hl
    jr .skip2

.skip3:
    ld a, $A2
    ld [de], a
    inc de
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15
    ld a, [wDigits + $1]
    cp a, $E3
    jr z, .read_digits
    ld [de], a
    inc de

.read_digits:
    ld a, [wDigits + $2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 40 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wSpeciesIdLo, wSpeciesIdHi, wTwoChoiceCursor, wScreenStep, ...
; points at: wMonsterLibraryBuf
BreedMenu_ChooseParents_TestBitInFieldAtArg3_Case28::
Jump_015_4BBE:: ; address name
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr .check_screen_step

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; if wC58A is set, copies and draws rectangle $70C5 at wC364; wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. BreedMenu_ChooseParents_DrawRect70C5IfLinkModeAndStep)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep
DrawRect70C5IfLinkModeAndStep::
Func_015_4C0C:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .check_screen_step
    call CopyRect70C5ToWC364AndDraw

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 43 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_ShowSaveFileInfoWindow::
Jump_015_4C1D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .check_screen_step
    call ShowSaveFileInfoWindow

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 44 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wTextFlags, wScreenStep, wLinkMode
; writes: wScreenSubStep, wScreenStep, wScriptCommandType, wScriptStartRequest, wStringIndex
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_DrawBottomBoxForLinkAndSetScreenSubStep::
Jump_015_4C2E:: ; address name
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, [wScreenSubStep]
    cp a, $02
    jr z, .check_link_mode
    cp a, $03
    jr z, .check_text_flags
    call DrawBottomBoxForLinkAndSetScreenSubStep
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

.check_link_mode:
    ld a, [wLinkMode]
    and a, a
    jr z, .check_screen_sub_step
    ld a, $0D
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 41 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wLinkMode
; writes: wScreenSubStep, wScreenStep, wTwoChoiceCursor
BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript::
Jump_015_4C80:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .clear_screen_sub_step
    call PrepareWCF8BCountersAndRequestScript
    ret

.clear_screen_sub_step:
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wLinkMode]
    and a, a
    jr z, .set_screen_step_to_2A
    ld de, TileRect_15_75F5
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawListEntriesCell5RecordNamesAndStep
    ld de, TileRect_15_7589
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call DrawListEntriesCell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15

.set_screen_step_to_2A:
    ld a, $2A
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 47 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D::
Jump_015_4CE3:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, .read_screen_step
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    call BreedMenu_ChooseParents_WaitLinkMode
    ret

.loop:
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    call BreedMenu_ChooseParents_WaitLinkMode

.read_screen_step:
    ld a, [wScreenStep]
    add a, $07
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 48 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest
BreedMenu_ChooseParents_DrawRect70C5IfLinkModeAndStep::
Jump_015_4D2B:: ; address name
    ld de, TileRect_15_761D
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    call DrawRect70C5IfLinkModeAndStep
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; entry 50 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wScreenStep
BreedMenu_ChooseParents_LoadTileListSixPerCall_Case32::
Jump_015_4D46:: ; address name
    ld a, $9D
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 49 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15::
Jump_015_4D6E:: ; address name
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 51 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep::
Jump_015_4D96:: ; address name
    call DrawPair72A9And72C5AndStep
    call DrawGoldBoxAndStep_Bank15
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; entry 52 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScriptCommandType, wScriptStartRequest, wScreenStep
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_StoreBAtWordTableEntry_Bank15::
Jump_015_4DB0:: ; address name
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 58 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case3A::
Jump_015_4DE5:: ; address name
    call DrawPair72A9And72C5AndStep
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; entry 59 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScriptCommandType, wScriptStartRequest, wScreenStep
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15_Case3B::
Jump_015_4DF3:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 60 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hTemp0, wScriptCommandType, wScriptStartRequest, wScreenStep
; points at: wTextWindowTileLo
BreedMenu_ChooseParents_TenTimesTemp0PlusTenToDigits::
Jump_015_4E1D:: ; address name
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesTemp0PlusTenToDigits
    call BreedMenu_Shared02
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 54 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wTextFlags, wScreenStep, wLinkMode, wSaveStep, wSelectedRecord, wArg5, wArg6, ...
; writes: wScreenSubStep, wScreenStep, wStringIndex, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wArg1, wArg2, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork
BreedMenu_ChooseParents_WriteScreenSubStepAndScreenStepEtc::
Jump_015_4E47:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr z, .call_breed_menu_choose_parents_wait_link_mode3
    cp a, $01
    jr z, .call_breed_menu_choose_parents_wait_link_mode2
    cp a, $02
    jr z, .call_breed_menu_choose_parents_wait_link_mode
    ld a, [wTextFlags]
    and a, a
    jr z, .clear_screen_sub_step
    call BreedMenu_ChooseParents_WaitLinkMode
    ret

.clear_screen_sub_step:
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_breed_menu_choose_parents_wait_link_mode:
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, [wLinkMode]
    and a, a
    jr z, .check_screen_sub_step
    ld a, $0E
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_breed_menu_choose_parents_wait_link_mode2:
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, [wLinkMode]
    and a, a
    jr z, .clear_two_choice_cursor
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_breed_menu_choose_parents_wait_link_mode3:
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, [wSelectedRecord]
    ld b, a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld b, [hl]
    push bc
    ld a, b
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    pop bc
    ld a, [wSelectedRecord]
    cp a, b
    jr c, .set_arg1
    dec a

.set_arg1:
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wSelectedRecord], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wChildRecord
    ld b, $A5

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    call SetBitInFieldAtArg3
    ld hl, wPackWork
    ld b, $07

.loop2:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop2
    farcall SetSpeciesFlag
    call IncrementTwoCountersCappedAt99
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; removes record B from the party list wC6FE (wC6FD -= 1), compacts the three entries and zeroes the unused ones (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wPartyCount
; points at: wPartyList
RemoveRecordBFromParty:: ; heuristic: follows a terminator; C0
Func_015_4F4C:: ; address name
    ld hl, wPartyList
    ld c, $00

.loop:
    ld a, [hl]
    cp a, b
    jr nz, .check_party_count
    ld a, $FF
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    jr .skip

.check_party_count:
    inc hl
    inc c
    ld a, [wPartyCount]
    cp a, c
    jr nz, .loop

.skip:
    ld hl, wPartyList
    ld de, wPartyList
    ld c, $00

.loop2:
    ld a, [hl]
    cp a, $FF
    jr nz, .skip2
    jr .next

.skip2:
    ld [de], a
    inc de

.next:
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, .loop2
    ld hl, wPartyList
    ld c, $00

.loop3:
    ld a, [hl]
    cp a, $FF
    jr z, .skip3
    cp a, b
    jr z, .skip3
    jr .next2

.skip3:
    xor a, a
    ld [hl], a

.next2:
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, .loop3
    ret

; entry 63 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArg1, wScreenStep
; writes: hTemp0, wArg3, wArg2, wArg1, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, ...
BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D_Case3F::
Jump_015_4F9A:: ; address name
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesTemp0PlusTen
    xor a, a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, .clear_two_choice_cursor
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

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 64 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_SetScreenStep::
Jump_015_501D:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $0A
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 65 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wListCursor, wListCount, wArg5, wArg6
; writes: hTemp0, wArg3, wArg2, wArg1, wListCursor, wListPageIndex, wListLastRow, wListPages, ...
; points at: wListEntries2, wListEntries
BreedMenu_ChooseParents_TenTimesTemp0PlusTen::
Jump_015_5030:: ; address name
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesTemp0PlusTen
    xor a, a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    call SubtractArg1AmountFromGold
    ld hl, wListEntries2
    ld c, $00

.loop:
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, .loop
    farcall ListRecordsInUseWithByte6ESet
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wListLastRow], a
    ld [wListPages], a
    ld hl, wListEntries
    ld a, [wSelectedRecord]
    ld b, a
    ld c, $00

.loop2:
    ld a, [hl]
    cp a, b
    jr z, .read_list_cursor
    inc c
    inc hl
    ld a, [wListCursor]
    inc a
    ld [wListCursor], a
    ld a, [wListCount]
    cp a, c
    jr nz, .loop2

.read_list_cursor:
    ld a, [wListCursor]
    srl a
    srl a
    ld [wListPageIndex], a
    ld a, [wListCursor]

.cp_04:
    cp a, $04
    jr c, .set_list_cursor
    sub a, $04
    jr .cp_04

.set_list_cursor:
    ld [wListCursor], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6E
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [wScreenStep], a
    ld a, $08
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case05::
Jump_015_50D1:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case05_ToBreedMenu_Case05_Case00_WriteArg1AndArg2Etc
    dw BreedMenu_Case05_ListRecordsInUseWithByte6ESet
    dw ClearTileRowsAndResetWindowAndStep
    dw BreedMenu_Case05_ClampRecordListPageCursor4_Case03
    dw BreedMenu_Case05_DrawRecordListPageSpeciesNames
    dw BreedMenu_Case05_DrawRecordListPageMarks
    dw BreedMenu_Case05_UpdatePagedListCursor
    dw BreedMenu_Case05_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_Case05_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ChooseParents_BlankWordTableTargets
    dw BreedMenu_Case05_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_Case05_QueueSoundEffect
    dw BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_Case05_ClampRecordListPageCursor4
    dw BreedMenu_Case05_LoadTile4990AndRun6320
    dw BreedMenu_Case05_SetArg5ToListEntriesCell4
    dw BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10

; entry 0 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case05_ToBreedMenu_Case05_Case00_WriteArg1AndArg2Etc::
Jump_015_50F7:: ; address name
    call BreedMenu_Case05_Case00_WriteArg1AndArg2Etc
    ret

; entry 1 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScreenStep
BreedMenu_Case05_ListRecordsInUseWithByte6ESet::
Jump_015_50FB:: ; address name
    ld de, TileRect_15_6FDB
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears four tile rows, sets the default window ($8800, $1202) and wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. BreedMenu_Case0F_ToClearTileRowsAndResetWindowAndStep)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
ClearTileRowsAndResetWindowAndStep::
Func_015_512C:: ; address name
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case05_ClampRecordListPageCursor4_Case03::
Jump_015_5165:: ; address name
    ld de, TileRect_15_7050
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank15
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, .read_list_cursor
    ld de, $018E
    call DrawC5BEC6AtScrollOffsetDE_Bank15
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank15
    ld de, $018F
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $BB
    ld hl, BreedMenu_Case05_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wListCursor]
    ld b, $C3
    ld hl, BreedMenu_Case05_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
BreedMenu_Case05_DrawRecordListPageSpeciesNames::
Jump_015_51D6:: ; address name
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case05_DrawRecordListPageMarks::
Jump_015_51E9:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor, wArg5, wArg6
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, rRAMG2, rRAMB, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
BreedMenu_Case05_UpdatePagedListCursor::
Jump_015_520D:: ; address name
    ld a, $02
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
    jr z, .return
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

.return:
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
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
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_Case05_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTenToDigits
    call BreedMenu_Shared02
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
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wThreeOptionResult, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case05_CopyRectTo20ByteRows_Bank15::
Jump_015_52BD:: ; address name
    ld c, $09
    ld hl, $0223
    ld de, $0057
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld a, [wThreeOptionResult]
    or a, a
    jr z, .skip
    ld de, TileRect_15_7345
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0403
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld de, TileRect_15_733F
    ld hl, wWindowTileBuffer + $BA
    ld bc, $0203
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep, wArg5
; writes: wScreenStep, wScreenSubStep, wArg1, wArg2, wArg3, wArg4, wScriptCommandType, wScriptStartRequest
BreedMenu_Case05_DrawGoldBoxAndStep_Bank15::
Jump_015_52FF:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .set_arg1_to_9C
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.set_arg1_to_9C:
    ld a, $9C
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp a, $FF
    ret nz
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep, wScreenState, wScriptCommandType, wScriptStartRequest
BreedMenu_ChooseParents_BlankWordTableTargets::
Jump_015_5358:: ; address name
    ld c, $03
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    call BlankWordTableTargets
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case05_ToCopyGlyphTileListFromBank1F_Bank15AndStep::
Jump_015_5376:: ; address name
    ld hl, TileCopyDestList_15_72E1
    ld de, TileCopySrcList_15_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wChoiceCursorF0, wChoiceCursor, wScreenStep
BreedMenu_Case05_QueueSoundEffect::
Jump_015_5387:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wChoiceCursorF0], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteB2, wScreenByteB3, wScreenState, wScreenSubStep, ...
BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15::
Jump_015_53B3:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank15
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank152
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call BlinkCursorBlinkAE_Bank15
    ret

.call_draw_blank_tile_c3_bank15:
    call DrawBlankTileC3_Bank15
    ld a, [wChoiceCursor]
    and a, a
    jr nz, .set_choice_cursor
    ld a, $01
    jr .set_choice_cursor2

.set_choice_cursor:
    dec a

.set_choice_cursor2:
    ld [wChoiceCursor], a
    call BlinkCursorBlinkAE_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_bank152:
    call DrawBlankTileC3_Bank15
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
    call BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap
    ld a, [wChoiceCursor]
    and a, a
    jp nz, .set_two_choice_cursor_to_01
    ld a, [wScreenState]
    cp a, $04
    jr z, .check_screen_step
    cp a, $05
    jr z, .set_screen_byte_b2_to_05
    jr .set_screen_byte_b2_to_07

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $22
    jr c, .set_screen_byte_b2_to_04
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $23
    ld [wScreenByteB3], a
    ld a, $0C
    jr .set_screen_state

.set_screen_byte_b2_to_04:
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $0E
    ld [wScreenByteB3], a
    ld a, $0C
    jr .set_screen_state

.set_screen_byte_b2_to_05:
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $0C
    ld [wScreenByteB3], a
    ld a, $0D
    jr .set_screen_state

.set_screen_byte_b2_to_07:
    ld a, $07
    ld [wScreenByteB2], a
    ld a, $18
    ld [wScreenByteB3], a
    ld a, $0E
    jr .set_screen_state

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

; once the joypad repeat timer reaches $14, cycles wD7AE through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 2 call sites from 1 routine (e.g. BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
BlinkCursorBlinkAE_Bank15::
Func_015_549E:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, .skip
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, DrawBlankTileC3_Bank15
    xor a, a
    ld [wCursorBlinkAE], a

.skip:
    ld b, $BB
    jr BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15)
; reads: wChoiceCursor
DrawBlankTileC3_Bank15::
Func_015_54BC:: ; address name
    ld b, $C3
    jr BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; only called from BreedMenu_ChooseParents_Case0E (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15)
; reads: wChoiceCursor
BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap::
Func_015_54C0:: ; address name
    ld b, $BC

BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor::
Jump_015_54C2:: ; address name
    ld a, [wChoiceCursor]
    add a, a
    ld hl, BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap
BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_54E2:: ; address name
    db $2D, $01, $6D, $01

; entry 14 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_Case05_LoadTile4990AndRun6320::
Jump_015_54E6:: ; address name
    call LoadTile4990AndRun6320
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $06
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArg1, wScreenStep
; writes: rRAMG2, rRAMB, wArg3, wArg2, wArg1, wTwoChoiceCursor, wScreenStep, wScriptCommandType, ...
BreedMenu_Case05_SetArg5ToListEntriesCell4::
Jump_015_5504:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTen
    xor a, a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $07
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB, wArg3, wArg2, wArg1, wScreenStep, wScreenState, wScriptCommandType, ...
; points at: sRecords, wListEntries2
BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10::
Jump_015_556A:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $6E
    add_a_to_hl
    xor a, a
    ld [hl], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTen
    xor a, a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    call SubtractArg1AmountFromGold
    ld hl, wListEntries2
    ld c, $00

.loop:
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, .loop
    xor a, a
    ld [wScreenStep], a
    ld a, $09
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs the name entry screen (RunNameEntryStateWhenNotFading) on the record selected in list cell 4, and removes a record with DeleteSRAMRecordAndCompact (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, hTemp1, wSelectedRecord, wArg7, wScreenState
; writes: rRAMG2, rRAMB, wArg2, wArg3, wArg4, wArg5, wSelectedRecord, wArg1, ...
; points at: wNameGlyphBuf, sRecords, wRecordBufA
BreedMenu_NameEntry::
Jump_015_55D2:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wArg2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $1F
    ld [wArg3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wArg4], a
    ldh a, [hTemp1]
    ld [wArg5], a
    pop hl
    ld a, [hl]
    ld [wSelectedRecord], a
    ld a, $01
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wSelectedRecord]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $0A
    ld de, wNameGlyphBuf

.loop:
    ld a, [de]
    cp a, $F0
    jr z, .read_selected_record
    ld [hl+], a
    inc de
    dec c
    jr nz, .loop
    jr .read_selected_record2

.read_selected_record:
    ld a, $F0
    ld [hl], a

.read_selected_record2:
    ld a, [wSelectedRecord]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $A5

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    xor a, a
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wSelectedRecord], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wRecordBufA
    ld b, $A5

.loop3:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop3
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; reloads the map (LoadMapHeader), the player's position (RestorePlayerPositionState) and sprite graphics (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_ReturnToMap::
Jump_015_56B0:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_ReturnToMap_DecompressToVRAM
    dw DrawPair72A9And72C5AndStep_570C
    dw BreedMenu_ReturnToMap_LoadMapHeader
    dw BreedMenu_ReturnToMap_CopyBytesDEToHL_Bank15
    dw BreedMenu_ReturnToMap_WriteScreenStepAndScriptCommandTypeEtc
    dw BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E
    dw BreedMenu_ReturnToMap_UpdateTwoChoiceCursor_Bank1D
    dw DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM
    dw BreedMenu_ReturnToMap_BlankWordTableTargets
    dw BreedMenu_ReturnToMap_SRAMRecordAddress
    dw BreedMenu_ReturnToMap_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_ReturnToMap_FillTilesBxC_Case0C
    dw BreedMenu_ReturnToMap_ClampRecordListPageCursor5
    dw BreedMenu_ReturnToMap_ToDrawRecordListPageNames
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5
    dw BreedMenu_ReturnToMap_FillTilesBxC
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_Case11
    dw BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15
    dw BreedMenu_ReturnToMap_UpdatePagedListCursor
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case14
    dw BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C
    dw BreedMenu_Case05_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_Case05_QueueSoundEffect
    dw BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19
    dw BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Case1A
    dw BreedMenu_ReturnToMap_CopyRecordNameToNameGlyphBuf
    dw BreedMenu_ReturnToMap_SRAMRecordAddress_Case1C
    dw BreedMenu_ReturnToMap_LoadPlayerAndFollowerSpriteGraphics
    dw BreedMenu_ReturnToMap_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C_Case1F
    dw BreedMenu_ChooseParents_BlankWordTableTargets

; entry 0 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ReturnToMap_DecompressToVRAM::
Jump_015_56F6:: ; address name
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call RestorePlayerPositionState
    ret

; runs Func_015_6374 for Data_015_72A9 and Data_015_72C5, then wD781 += 1 (E-0122)
; 2 call sites from 2 routines (e.g. BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C_Case1F, BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C)
; reads: wScreenStep
; writes: wScreenStep
DrawPair72A9And72C5AndStep_570C::
Func_015_570C:: ; address name
    ld hl, TileCopyDestList_15_72A9
    ld de, TileCopySrcList_15_72C5
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hMapId, hFieldDrawFlags, wOBJPaletteUploadRequest, wScreenStep
BreedMenu_ReturnToMap_LoadMapHeader::
Jump_015_571D:: ; address name
    ld a, $0D
    ldh [hMapId], a
    call LoadMapHeader
    call LoadMapScreen
    farcall LoadPlayerAndFollowerSpriteGraphics
    farcall LoadMapObjectsForScreen
    call RestorePlayerPositionState
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenStep
; writes: hSpriteHideTile, wScreenStep
; points at: wScreenTileBuffer, wWindowTileBuffer, wScreenAttrBuffer, wWindowAttrBuffer
BreedMenu_ReturnToMap_CopyBytesDEToHL_Bank15::
Jump_015_5746:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank15
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank15

.call_bg_map_address_at_scroll_bank15:
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    ld a, $70
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0
BreedMenu_ReturnToMap_WriteScreenStepAndScriptCommandTypeEtc::
Jump_015_57A4:: ; address name
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $0A

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .check_screen_step
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .loop

.check_screen_step:
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 62 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E::
Jump_015_57CB:: ; address name
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_15_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 46 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
BreedMenu_ChooseParents_WriteScreenStepAndTwoChoiceCursor::
Jump_015_5811:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 6 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
BreedMenu_ReturnToMap_UpdateTwoChoiceCursor_Bank1D::
Jump_015_5823:: ; address name
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
    call BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of BreedMenu_ReturnToMap (E-0098)
; 2 call sites from 2 routines (e.g. BreedMenu_ReturnToMap_SRAMRecordAddress, BreedMenu_ReturnToMap_UpdateTwoChoiceCursor_Bank1D)
; reads: wIsCGB
BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01::
Func_015_586D:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $05
    call BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank15
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15

.call_bg_map_address_at_scroll_bank15:
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; only called from BreedMenu_ReturnToMap_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01)
BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15::
Func_015_5896:: ; address name
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank15
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
    dec c
    jr nz, BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15
    ret

; only called from BreedMenu_ReturnToMap_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01)
BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15::
Func_015_58B4:: ; address name
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyLow3BitsToWRAMBank2_Bank15
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
    dec c
    jr nz, BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15
    ret

; entry 8 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM::
Jump_015_58D2:: ; address name
    ld de, Tiles1Plus2D0Tiles_1F_43C0
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_1F_42D0
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep, wScreenState, wScriptCommandType, wScriptStartRequest
BreedMenu_ReturnToMap_BlankWordTableTargets::
Jump_015_5920:: ; address name
    ld c, $03
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    call BlankWordTableTargets
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wSelectedRecord, wScreenStep, wTwoChoiceCursor
; writes: wPartyCount, rRAMG2, rRAMB, wOBJPaletteUploadRequest, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wPartyList
BreedMenu_ReturnToMap_SRAMRecordAddress::
Jump_015_593E:: ; address name
    ld a, [wPartyCount]
    cp a, $03
    jr nc, .read_two_choice_cursor
    ld hl, wPartyList
    ld a, [wPartyCount]
    add_a_to_hl
    ld a, [wSelectedRecord]
    ld [hl], a
    ld a, [wPartyCount]
    inc a
    ld [wPartyCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    call BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, BreedMenu_ReturnToMap_SRAMRecordAddress_Data
    call StoreBAtWordTableEntry_Bank15
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wListPageIndex, wListCursor, wCursorBlinkAE, wScreenStep
BreedMenu_ReturnToMap_CopyRectTo20ByteRows_Bank15::
Jump_015_59B8:: ; address name
    ld de, TileRect_15_59E5
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call BreedMenu_ReturnToMap_Case0B_Sub01
    xor a, a
    ld [wListPageIndex], a
    ld [wListCursor], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 9 tiles, one row per line
TileRect_15_59E5::
Data_015_59E5:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; only called from BreedMenu_ReturnToMap_Case0B (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_CopyRectTo20ByteRows_Bank15)
BreedMenu_ReturnToMap_Case0B_Sub01::
Func_015_5A2D:: ; address name
    ld c, $10

.loop:
    push bc
    ld a, c
    ld de, BreedMenu_ReturnToMap_Case0B_Sub01_Data_5A67
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a, a
    ld de, BreedMenu_ReturnToMap_Case0B_Sub01_Data_5A77
    add a, e
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
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    dec c
    jr nz, .loop
    ret

; address loaded by BreedMenu_ReturnToMap_Case0B_Sub01
BreedMenu_ReturnToMap_Case0B_Sub01_Data_5A67:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_5A67:: ; address name
    db $A3, $50, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $25

; address loaded by BreedMenu_ReturnToMap_Case0B_Sub01
BreedMenu_ReturnToMap_Case0B_Sub01_Data_5A77:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_5A77:: ; address name
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; entry 12 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
BreedMenu_ReturnToMap_FillTilesBxC_Case0C::
Jump_015_5A97:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
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
    ld de, TileRect_15_73C9
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyList, wSelectedRecord, wScreenStep
; writes: wListEntries, wGrid2CursorX, wGrid2CursorY, wScreenArea, wListCount, wScreenStep
BreedMenu_ReturnToMap_ClampRecordListPageCursor5::
Jump_015_5ACA:: ; address name
    ld a, [wPartyList]
    ld [wListEntries], a
    ld a, [wPartyList + $1]
    ld [wGrid2CursorX], a
    ld a, [wPartyList + $2]
    ld [wGrid2CursorY], a
    ld a, [wSelectedRecord]
    ld [wScreenArea], a
    ld a, $04
    ld [wListCount], a
    farcall ClampRecordListPageCursor5
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
BreedMenu_ReturnToMap_ToDrawRecordListPageNames::
Jump_015_5AF5:: ; address name
    farcall DrawRecordListPageNames
    ret

; entry 15 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5::
Jump_015_5AFC:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, TileRect_15_7411
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
BreedMenu_ReturnToMap_FillTilesBxC::
Jump_015_5B33:: ; address name
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
    ld hl, wWindowTileBuffer + $78
    ld c, $28
    call BreedMenu_ReturnToMap_Case10_LoadSRAMRecordByte
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_Case11::
Jump_015_5B62:: ; address name
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

; entry 18 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15::
Jump_015_5B82:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 19 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, ...
BreedMenu_ReturnToMap_UpdatePagedListCursor::
Jump_015_5B96:: ; address name
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
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
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
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step3:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case14::
Jump_015_5C19:: ; address name
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $09
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0601
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 21 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C::
Jump_015_5C5B:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call DrawPair72A9And72C5AndStep_570C
    ld a, $06
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 25 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19::
Jump_015_5C7D:: ; address name
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19_Data
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C01
    call CopyRectTo20ByteRows_Bank15
    xor a, a
    ld b, $BC
    ld hl, BreedMenu_ReturnToMap_SRAMRecordAddress_Data
    call StoreBAtWordTableEntry_Bank15
    ld c, $04
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Case1A::
Jump_015_5CDC:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $13
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 27 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wListEntries, wNameGlyphBuf, wTextBuf0
BreedMenu_ReturnToMap_CopyRecordNameToNameGlyphBuf::
Jump_015_5CF7:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    xor a, a
    ld [rRAMG2], a
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .check_screen_step
    ld [de], a
    inc hl
    inc de
    jr .skip

.check_screen_step:
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 28 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: rRAMG2, rRAMB, wScreenStep
; points at: wListEntries, wPartyList
BreedMenu_ReturnToMap_SRAMRecordAddress_Case1C::
Jump_015_5D3E:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wListCursor]
    cp a, $03
    jr z, .check_screen_step
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, $FF
    ld [hl], a
    ld hl, wListEntries
    ld de, wPartyList
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $FF
    jr nz, .skip
    inc hl
    jr .skip2

.skip:
    ld [de], a
    inc hl
    inc de
    inc c

.skip2:
    ld a, c
    cp a, $03
    jr c, .loop
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wPartyList
    ld c, $00

.loop2:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, .loop2
    xor a, a
    ld [rRAMG2], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 29 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wOBJPaletteUploadRequest, wScreenStep
BreedMenu_ReturnToMap_LoadPlayerAndFollowerSpriteGraphics::
Jump_015_5DBB:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2
BreedMenu_ReturnToMap_DrawGoldBoxAndStep_Bank15::
Jump_015_5DCE:: ; address name
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, Tiles1Plus2D0Tiles_1F_43C0
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_1F_42D0
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call DrawGoldBoxAndStep_Bank15
    ret

; entry 31 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScriptCommandType, wScriptStartRequest
BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C_Case1F::
Jump_015_5E0C:: ; address name
    call DrawPair72A9And72C5AndStep_570C
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; saves the script return position, dispatches talk event group $17 index 0, then sets wScreenState = 6 (BreedMenu_NameEntry) (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, wScreenState, wNameEntryState, ...
BreedMenu_TalkEvent17ThenNameEntry::
Jump_015_5E30:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $17
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    ld a, $06
    ld [wScreenState], a
    xor a, a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ret

; copies word $0B and byte $6D of the record in list cell 4 to wChildRecord, saves the script return, dispatches talk event group $16, then sets wScreenState = 6 (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, hTemp1, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi
; writes: rRAMG2, rRAMB, wChildRecord, wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, ...
BreedMenu_CopyToChildThenTalkEvent16::
Jump_015_5E62:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    push hl
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wChildRecord + $B], a
    ldh a, [hTemp1]
    ld [wChildRecord + $C], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [wChildRecord + $6D], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $16
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    ld a, $06
    ld [wScreenState], a
    xor a, a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ret

; saves the script return position and dispatches talk event group $15 index 0 (E-0277)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank
; points at: wScreenState
BreedMenu_TalkEvent15::
Jump_015_5ECC:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $15
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    ld hl, wScreenState
    inc [hl]
    ret

; entry 11 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case0B::
Jump_015_5EF6:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case0B_FillTileRectWithArg1Tile
    dw BreedMenu_ReturnToMap_DecompressToVRAM
    dw DrawPair72A9And72C5AndStep_570C
    dw BreedMenu_ReturnToMap_LoadMapHeader
    dw BreedMenu_ReturnToMap_CopyBytesDEToHL_Bank15
    dw BreedMenu_Case0B_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_Case0B_CopyMonsterNameToBuffer_B15
    dw BreedMenu_Case0B_WriteScreenStepAndScreenSubStepEtc

; entry 5 of the `rst $00` table in BreedMenu_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
BreedMenu_Case0B_DrawGoldBoxAndStep_Bank15::
Jump_015_5F0A:: ; address name
    call DrawGoldBoxAndStep_Bank15
    ld a, [wIsCGB]
    and a, a
    jr nz, .return
    farcall SendSGBPaletteSetForSGBPaletteSet
    ld a, $FC
    call StartPaletteFade

.return:
    ret

; entry 0 of the `rst $00` table in BreedMenu_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenStep
BreedMenu_Case0B_FillTileRectWithArg1Tile::
Jump_015_5F1F:: ; address name
    call BGMapAddressAtScroll_Bank15
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in BreedMenu_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wScreenStep
; writes: wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0
BreedMenu_Case0B_CopyMonsterNameToBuffer_B15::
Jump_015_5F51:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld de, wChildRecord + $B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .check_screen_step
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $10
    jr c, .loop

.check_screen_step:
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
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
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in BreedMenu_Case0B
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, ...
BreedMenu_Case0B_WriteScreenStepAndScreenSubStepEtc::
Jump_015_5FAD:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wScreenState], a
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
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenByteB3, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
BreedMenu_SwapMonstersMenu::
Jump_015_5FD9:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    ld a, [wScreenByteB3]
    cp a, $23
    jr nz, .clear_screen_step
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $06
    ld [wScreenState], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $05
    ld [wScreenState], a
    ret

; entry 13 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
BreedMenu_SwapMonstersMenu_Case0D::
Jump_015_600C:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

; entry 15 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case0F::
Jump_015_6028:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case0F_DecompressToVRAM
    dw BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_Case0F_ToClearTileRowsAndResetWindowAndStep
    dw BreedMenu_Case05_ClampRecordListPageCursor4
    dw BreedMenu_Case0F_DrawRecordListPageSpeciesNames
    dw LoadTile4990AndRun6320
    dw BreedMenu_Case0F_StoreBAtWordTableEntry_Bank15
    dw BreedMenu_Case0F_SetArg5ToListEntriesCell4
    dw BreedMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics

; entry 0 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
BreedMenu_Case0F_DecompressToVRAM::
Jump_015_603E:: ; address name
    ld hl, vTiles2
    ld de, Map0DTileset
    ld b, $47
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, BGPaletteBufferData_47_67E2
    ld b, $47
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15::
Jump_015_6063:: ; address name
    ld hl, TileCopyDestList_15_72E1
    ld de, TileCopySrcList_15_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    call DrawPair72A9And72C5AndStep
    ret

; entry 2 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case0F_ToClearTileRowsAndResetWindowAndStep::
Jump_015_6070:: ; address name
    call ClearTileRowsAndResetWindowAndStep
    ret

; entry 13 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case05_ClampRecordListPageCursor4::
Jump_015_6074:: ; address name
    ld de, TileRect_15_7050
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank15
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $163
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

; entry 4 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
BreedMenu_Case0F_DrawRecordListPageSpeciesNames::
Jump_015_60AC:: ; address name
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies a tile from bank $1F to vTiles1 + $4E0, runs Func_01D_6320 with wD7F1 = wD7F2 = 1, then wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. BreedMenu_Case05_LoadTile4990AndRun6320)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
LoadTile4990AndRun6320::
Func_015_60BF:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
BreedMenu_Case0F_StoreBAtWordTableEntry_Bank15::
Jump_015_60E2:: ; address name
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_Case05_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: rRAMG2, rRAMB, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
BreedMenu_Case0F_SetArg5ToListEntriesCell4::
Jump_015_6101:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTenToDigits
    call BreedMenu_Shared02
    xor a, a
    ld [wStringCategory], a
    ld a, $1B
    ld [wStringIndex], a
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
    farcall ShowString_Bank1B_4C94
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in BreedMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
BreedMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics::
Jump_015_6155:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    farcall RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
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
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case10::
Jump_015_61B6:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case0F_DecompressToVRAM
    dw BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_Case10_FillTilesBxC
    dw BreedMenu_ReturnToMap_ToDrawRecordListPageNames
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5
    dw BreedMenu_ReturnToMap_FillTilesBxC
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_Case11
    dw BreedMenu_ChooseParents_CopyFromBankWaitVRAM
    dw BreedMenu_Case10_BlankWordTableTargets
    dw BreedMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics

; entry 2 of the `rst $00` table in BreedMenu_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
BreedMenu_Case10_FillTilesBxC::
Jump_015_61CE:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 45 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_WriteScreenStep::
Jump_015_61F5:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, BreedMenu_ChooseParents_CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 61 of the `rst $00` table in BreedMenu_ChooseParents
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_ChooseParents_CopyFromBankWaitVRAM::
Jump_015_6203:: ; address name
    call BreedMenu_ChooseParents_WaitLinkMode
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in BreedMenu_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
BreedMenu_Case10_BlankWordTableTargets::
Jump_015_6235:: ; address name
    ld c, $04
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case12::
Jump_015_625C:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case0F_DecompressToVRAM
    dw BreedMenu_Case12_LoadRecordSelectedRecordByte0EBit0
    dw DrawPair72A9And72C5AndStep
    dw BreedMenu_Case12_FillTilesBxC
    dw BreedMenu_Case12_ClearThreeTileRows
    dw BreedMenu_Case05_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_Case12_ToDrawRecordListPageNames
    dw BreedMenu_Case12_DrawRecordNameAndSpeciesNameTiles
    dw BreedMenu_ChooseParents_ComputeBreedingChild
    dw BreedMenu_Case12_LoadFamilyIconTileForRecordB_Bank15
    dw BreedMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics

; entry 7 of the `rst $00` table in BreedMenu_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wScreenStep
; writes: wArg1, wScreenStep
BreedMenu_Case12_DrawRecordNameAndSpeciesNameTiles::
Jump_015_6276:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld a, [wSelectedRecord]
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    call BreedMenu_SetArg5ToListEntriesCell5
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in BreedMenu_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wArg5, wArg6
; writes: wArg1
BreedMenu_Case12_LoadFamilyIconTileForRecordB_Bank15::
Jump_015_629F:: ; address name
    ld a, $C7
    ld [wArg1], a
    ld a, [wSelectedRecord]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank15
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    pop af
    call CopyRect7351ToWC410AndIncScreenStep
    ret

; entry 1 of the `rst $00` table in BreedMenu_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case12_LoadRecordSelectedRecordByte0EBit0::
Jump_015_62C9:: ; address name
    call LoadRecordSelectedRecordByte0EBit0
    call BreedMenu_WriteListCountAndRAMG2Etc
    jp BreedMenu_Case11_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5

; entry 4 of the `rst $00` table in BreedMenu_Case12
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case12_ClearThreeTileRows::
Jump_015_62D2:: ; address name
    call ClearThreeTileRows
    call DrawListEntriesCell5RecordNamesAndStep
    ret

; entry 17 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case11::
Jump_015_62D9:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case0F_DecompressToVRAM
    dw BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_Case11_ListRecordsInUseWithByte6EClear
    dw BreedMenu_Case12_FillTilesBxC
    dw BreedMenu_Case12_ToDrawRecordListPageNames
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5
    dw BreedMenu_ChooseParents_FillTilesBxC
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case06
    dw CopyRect7351ToWC410AndIncScreenStep
    dw BreedMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics

; entry 2 of the `rst $00` table in BreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case11_ListRecordsInUseWithByte6EClear::
Jump_015_62F1:: ; address name
    farcall ListRecordsInUseWithByte6EClear

BreedMenu_Case11_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5::
Jump_015_62F7:: ; address name
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, .call_blank_word_table_targets
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.call_blank_word_table_targets:
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $BC
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in BreedMenu_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case12_FillTilesBxC::
Jump_015_6336:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in BreedMenu_Case12
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case12_ToDrawRecordListPageNames::
Jump_015_6359:: ; address name
    farcall DrawRecordListPageNames
    ret

; copies the 8 x 5 rectangle Data_015_7351 into wC410 (CopyRectTo20ByteRows_Bank15), then wD781 += 1 (E-0119)
; 1 call site from 1 routine (e.g. BreedMenu_Case12_LoadFamilyIconTileForRecordB_Bank15)
; reads: wScreenStep
; writes: wScreenStep
CopyRect7351ToWC410AndIncScreenStep::
Func_015_6360:: ; address name
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; for each entry from wD785 of the destination list at HL and the source list at DE copies a 16-byte tile from bank $1F, until $FF; then clears wD784/5 (E-0125)
; 6 call sites from 6 routines (e.g. CloseBreedMenu_CopyGlyphTileListFromBank1F_Bank15, BreedMenu_ChooseParents_CopyGlyphTileListFromBank1F_Bank15, DrawPair72A9And72C5AndStep_570C, BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15, ...)
; reads: wGlyphListStart
; writes: wGlyphListStart, wGlyphListPos
CopyGlyphTileListFromBank1F_Bank15::
Func_015_6374:: ; address name
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
    ld e, l
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    jr CopyGlyphTileListFromBank1F_Bank15

.restore:
    pop de
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DecompressGraphicsArg1ToArg4 with graphics number $00A4 and destination $8000 (vTiles0) (E-0117)
; 2 call sites from 2 routines (e.g. ShowSaveFileInfoWindow, DecompressA4GraphicsAndContinue)
; writes: wArg1, wArg2, wArg3, wArg4, wArg5
DecompressGraphicsA4ToTiles0::
Func_015_63B8:: ; address name
    ld a, $A4
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ret

; only called from routines of BreedMenu_ChooseParents (E-0098)
; 9 call sites from 5 routines (e.g. BreedMenu_ChooseParents_WriteScreenSubStepAndScreenStepEtc, BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D, BreedMenu_ChooseParents_DrawBottomBoxForLinkAndSetScreenSubStep, BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E, ...)
; reads: wLinkMode, wScreenState, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
; points at: sSavedPlayerName
BreedMenu_ChooseParents_WaitLinkMode::
Func_015_63D3:: ; address name
    ld a, [wLinkMode]
    and a, a
    ret z
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedPlayerName
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, .check_screen_state

.loop:
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp a, $04
    jr nz, .loop
    ld a, [wScreenStep]
    cp a, $37
    jr nc, .loop

; with SRAM disabled draws sprite part $0090 at ($88, $28) (Func_01D_6A3F, C = 1) (E-0124)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB, GameMode5_Update_Case07_Sub01_WaitPickCount)
; writes: rRAMB, rRAMG2, wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
DrawSpritePart9000At88_28::
Func_015_6403:: ; address name
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ld a, $90
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld [wArg3], a
    ld a, $88
    ld [wArg4], a
    ld a, $28
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    farcall DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc
    ret

; outside link battles only sets wD782 = 2; otherwise copies the row Data_015_727D when wD782 is set, sets wD782 = 2 and draws the box at scroll + $1CC (E-0124)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_DrawBottomBoxForLinkAndSetScreenSubStep, KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep, RunLinkSession8Exchange_Case01_Sub01_Table4_Case03)
; reads: wLinkMode, wScreenSubStep
; writes: wScreenSubStep
DrawBottomBoxForLinkAndSetScreenSubStep::
Func_015_642D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, .check_screen_sub_step
    ld a, $02
    ld [wScreenSubStep], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .skip
    jr .set_screen_sub_step_to_02

.skip:
    ld de, TileRect_15_727D
    ld hl, wWindowTileBuffer + $C8
    ld bc, $1401
    call CopyRectTo20ByteRows_Bank15

.set_screen_sub_step_to_02:
    ld a, $02
    ld [wScreenSubStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; copies the 20 x 11 rectangle Data_015_70C5 into wC364, then DrawScreenBufferRect_Bank15 (20 x 13 at the scroll origin) (E-0119)
; 3 call sites from 3 routines (e.g. DrawRect70C5IfLinkModeAndStep, KeyAppraisalMenu_ChooseKey_ToCopyRect70C5ToWC364AndDrawAndStep, RunLinkSession8Exchange_Case01_Sub01_Table4_Case01)
CopyRect70C5ToWC364AndDraw::
Func_015_645F:: ; address name
    ld de, TileRect_15_70C5
    ld hl, wWindowTileBuffer + $64
    ld bc, $140B
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; up/down moves wD786 over three options with sound $69; A chooses (option 2 cancels), sets wTwoChoiceCursor and requests script $80; B cancels (E-0129)
; 2 call sites from 2 routines (e.g. BreedMenu_ToHandleThreeOptionMenuInput_15, EggServiceMenu_HandleThreeOptionMenuInput_15)
; reads: wJoypadPressedRepeat, wJoypadPressed, wGridCursorX, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wThreeOptionResult, wScreenState, wListCursor, wChoiceCursor, wListPageIndex, ...
HandleThreeOptionMenuInput_15::
Func_015_6478:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_6542
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_65422
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call BlinkCursorGridCursorY_Bank15
    ret

.call_draw_blank_tile_c3_6542:
    call DrawBlankTileC3_6542
    ld a, [wGridCursorX]
    and a, a
    jr nz, .set_grid_cursor_x
    ld a, $02
    ld [wGridCursorX], a
    call BlinkCursorGridCursorY_Bank15
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
    call BlinkCursorGridCursorY_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_65422:
    call DrawBlankTileC3_6542
    ld a, [wGridCursorX]
    cp a, $02
    jr c, .skip
    xor a, a
    ld [wGridCursorX], a
    call BlinkCursorGridCursorY_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtGridCursorXEntry_Bank15
    ld c, $03
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    call BlankWordTableTargets
    ld a, [wGridCursorX]
    cp a, $02
    jr z, .set_two_choice_cursor_to_02
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

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wThreeOptionResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wD787 through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 4 call sites from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
BlinkCursorGridCursorY_Bank15::
Func_015_6524:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, .skip
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, DrawBlankTileC3_6542
    xor a, a
    ld [wGridCursorY], a

.skip:
    ld b, $BB
    jr DrawArrowTileBCAtGridCursorXEntry_Bank15_ReadGridCursorX

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wGridCursorX
DrawBlankTileC3_6542::
Func_015_6542:: ; address name
    ld b, $C3
    jr DrawArrowTileBCAtGridCursorXEntry_Bank15_ReadGridCursorX

; B = $BC, then writes B at the scroll position + Data_015_6566[wD786] (E-0124)
; 1 call site from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wGridCursorX
DrawArrowTileBCAtGridCursorXEntry_Bank15::
Func_015_6546:: ; address name
    ld b, $BC

DrawArrowTileBCAtGridCursorXEntry_Bank15_ReadGridCursorX::
Jump_015_6548:: ; address name
    ld a, [wGridCursorX]
    add a, a
    ld hl, DrawArrowTileBCAtGridCursorXEntry_Bank15_Data
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by DrawArrowTileBCAtGridCursorXEntry_Bank15
DrawArrowTileBCAtGridCursorXEntry_Bank15_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_6566:: ; address name
    db $21, $00, $61, $00, $A1, $00

; only called from BreedMenu_ReturnToMap_Case10 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_FillTilesBxC)
; reads: hTemp0, rSTAT, wPartyCount
; writes: rRAMG2, rRAMB
; points at: wListEntries
BreedMenu_ReturnToMap_Case10_LoadSRAMRecordByte::
Func_015_656C:: ; address name
    ld b, $00

.loop:
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld c, MON_STATE
    ld b, $01
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $02
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
    add a, $E1
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
    cp a, b
    jr nz, .loop
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 45 call sites from 37 routines (e.g. BreedMenu_Setup_CopyRectTo20ByteRows_Bank15, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep, BreedMenu_ChooseParents_DrawRect70C5IfLinkModeAndStep, DrawBottomBoxForLinkAndSetScreenSubStep, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank15::
Func_015_65B7:: ; address name
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

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 unchanged when wStringIndex is $10-$12; otherwise HL + $1C1, replaced by $99C1 when that is $9B61 (E-0062)
; 41 call sites from 35 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_Setup_CopyRectTo20ByteRows_Bank15, BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15_Case3B, BreedMenu_ChooseParents_StoreBAtWordTableEntry_Bank15, ...)
; reads: wStringIndex, wTextCursorHi, wTextCursorLo, wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_Bank15::
Func_015_65F1:: ; address name
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
    ld a, [wStringIndex]
    cp a, $10
    jr z, .restore
    cp a, $11
    jr z, .restore
    cp a, $12
    jr z, .restore
    ld a, l
    add a, $C1
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a
    ld a, [wTextCursorHi]
    cp a, $9B
    jr nz, .restore
    ld a, [wTextCursorLo]
    cp a, $61
    jr nz, .restore
    ld a, $C1
    ld [wTextCursorLo], a
    ld a, $99
    ld [wTextCursorHi], a

.restore:
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a, a
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 45 call sites from 39 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, DrawArrowTileBCAtGridCursorXEntry_Bank15, BreedMenu_Setup_CopyRectTo20ByteRows_Bank15, BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15_Case3B, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank15::
Func_015_6655:: ; address name
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

; wD7F1 = hFFC9, then the high and low digits of hFFC8, hFFC7 and hFFC6 go to wD7F2-wD7F7 (seven digits of a packed-BCD number, most significant first); the loop that follows (C = 6) is not read (E-0106)
; 9 call sites from 9 routines (e.g. TenTimesTemp0PlusTenToDigits, DrawGoldBoxAndStep_Bank15, EggServiceMenu_Case01_Number24ToPackedBCD, EggServiceMenu_ChooseAndPay_UpdatePagedListCursor, ...)
; points at: hTemp3, wArg1
UnpackBCDToDigitsArg1::
Func_015_6676:: ; address name
    ld de, hTemp3
    ld hl, wArg1
    ld a, [de]
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl], a
    ld c, $06
    ld hl, wArg1

.loop:
    ld a, [hl]
    and a, a
    jr nz, .return
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, .loop

.return:
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 6 call sites from 5 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_Init, BreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15, ...)
CopyBytesDEToHL_Bank15::
Func_015_66AF:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank15
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 6 call sites from 5 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_Init, BreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank15::
Func_015_66B8:: ; address name
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 19 call sites from 17 routines (e.g. BlankWordTableTargets, BreedMenu_ChooseParents_StoreBAtWordTableEntry_Bank15, BreedMenu_ChooseParents_UpdatePagedListCursor_Case1E, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A, ...)
StoreBAtWordTableEntry_Bank15::
Func_015_66CA:: ; address name
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

; only called from BreedMenu_ChooseParents_Case13 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ChooseParents_ToBreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc::
Func_015_66D8:: ; address name
    ld hl, BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc_Data
    ld a, $9D
    jr BreedMenu_Case05_Case00_WriteArg1AndArg2Etc_SetArg1

; only called from BreedMenu_Case05_Case00 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_Case05_ToBreedMenu_Case05_Case00_WriteArg1AndArg2Etc)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
BreedMenu_Case05_Case00_WriteArg1AndArg2Etc::
Func_015_66DF:: ; address name
    ld hl, BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc_Data
    ld a, $9C

BreedMenu_Case05_Case00_WriteArg1AndArg2Etc_SetArg1::
Jump_015_66E4:: ; address name
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    xor a, a
    ld [wGlyphListPos], a

.loop:
    push hl
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, .restore
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld a, [wGlyphListStart]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wArg1]
    ld d, a
    ld a, [wArg2]
    ld e, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyTileBytesToVRAM_Bank15
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $06
    jr c, .loop
    ret

.restore:
    pop de
    pop hl
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wScreenStep
    inc [hl]
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (E-0121)
; 2 call sites from 2 routines (e.g. BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear, BreedMenu_Case05_ClampRecordListPageCursor4_Case03)
DrawC5BEC6AtScrollOffsetDE_Bank15::
Func_015_6742:: ; address name
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 4 call sites from 4 routines (e.g. BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear, BreedMenu_Case05_ClampRecordListPageCursor4_Case03, BreedMenu_Case05_ClampRecordListPageCursor4, BreedMenu_Case11_ListRecordsInUseWithByte6EClear)
StoreC5BEC6AtHLStride2_Bank15::
Func_015_6772:: ; address name
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

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. ShowSaveFileInfoWindow, BreedMenu_Case05_Case00_WriteArg1AndArg2Etc)
; reads: rSTAT
CopyTileBytesToVRAM_Bank15::
Func_015_6780:: ; address name
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

; only called from routines of BreedMenu (E-0098)
; 9 call sites from 8 routines (e.g. BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15, BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15, BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case09, BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case00, ...)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
BreedMenu_CopyBytesDEToHL_Bank15::
Func_015_6791:: ; address name
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
    call CopyBytesDEToHL_Bank15
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
    call CopyLow3BitsToWRAMBank2_Bank15
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
    jr nz, BreedMenu_CopyBytesDEToHL_Bank15
    ret

; HL = table of addresses, C = count: stores tile $C3 at the address in each of the first C entries (StoreBAtWordTableEntry_Bank15) (E-0074)
; 9 call sites from 9 routines (e.g. HandleThreeOptionMenuInput_15, BreedMenu_ChooseParents_BlankWordTableTargets_Case25, BreedMenu_ChooseParents_BlankWordTableTargets_Case12, BreedMenu_ChooseParents_BlankWordTableTargets_Case10, ...)
BlankWordTableTargets::
Func_015_67E5:: ; address name
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank15
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ret

; TenTimesTemp0PlusTen, then converts it to packed BCD (Number24ToPackedBCD) and unpacks the digits to wD7F1 onward (E-0117)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_TenTimesTemp0PlusTenToDigits, BreedMenu_Case05_UpdatePagedListCursor, BreedMenu_Case0F_SetArg5ToListEntriesCell4)
; writes: wDigits
TenTimesTemp0PlusTenToDigits::
Func_015_67F9:: ; address name
    call TenTimesTemp0PlusTen
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1
    ret

; HL = 10 * hFFC6 + 10 (E-0117)
; 5 call sites from 5 routines (e.g. BreedMenu_ChooseParents_TenTimesTemp0PlusTen, BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D_Case3F, TenTimesTemp0PlusTenToDigits, BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10, ...)
; reads: hTemp0
TenTimesTemp0PlusTen::
Func_015_680F:: ; address name
    ldh a, [hTemp0]
    ld c, $0A
    ld hl, $0000
    call Multiply8
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from routines of BreedMenu (E-0098)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_TenTimesTemp0PlusTenToDigits, BreedMenu_Case05_UpdatePagedListCursor, BreedMenu_Case0F_SetArg5ToListEntriesCell4)
; points at: wArg4, wTextBuf0
BreedMenu_Shared02::
Func_015_6822:: ; address name
    ld hl, wArg4
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $E3
    jr z, .next
    ld [de], a
    inc de

.next:
    inc hl
    inc c
    ld a, c
    cp a, $04
    jr c, .loop
    ld a, $F0
    ld [de], a
    ret

; wGold -= the 24-bit amount wD7F3:wD7F2:wD7F1 (no floor; callers check first, for example with IsAmountInArg1AboveGold) (E-0106)
; 9 call sites from 9 routines (e.g. BreedMenu_ChooseParents_TenTimesTemp0PlusTen, BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10, ArenaMenu_SubtractArg1AmountFromGold, ArenaMenu_SubtractArg1AmountFromGold_Case19, ...)
; reads: wArg3, wArg2, wArg1, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
SubtractArg1AmountFromGold::
Func_015_683C:: ; address name
    ld a, [wArg3]
    ld e, a
    ld a, [wArg2]
    ld h, a
    ld a, [wArg1]
    ld l, a
    ld a, [wGoldHi]
    ld d, a
    ld a, [wGoldMid]
    ld b, a
    ld a, [wGoldLo]
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, d
    sbc a, e
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = wD7F1, then LoadFamilyIconTileForWorkBuf (E-0122)
; 5 call sites from 4 routines (e.g. DrawListEntriesCell5IconAndLevelAndStep, BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5, BreedMenu_ChooseParents_SetArg5ToListEntriesCell5, BreedMenu_Case12_LoadFamilyIconTileForRecordB_Bank15)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank15::
Func_015_6866:: ; address name
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
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ret

; record wD7F1 (bank 0): writes tile $CC + (field $0E & 1) at the address in wD7F2/3 and, three tiles on, field $56 as two digits with leading blanks (E-0121)
; 5 call sites from 5 routines (e.g. DrawListEntriesCell5IconAndLevelAndStep, BreedMenu_ChooseParents_SetArg5ToListEntriesCell5, NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5, RunLinkSession5Exchange_LinkBreed_SetArg5ToListEntriesCell5, ...)
; reads: wArg1, wArg2, wArg3, hTemp0, wDigits
; writes: rRAMG2, rRAMB
DrawRecordField0EMarkAndField56Digits::
Func_015_688D:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld l, a
    ld a, [wArg3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    pop bc
    push bc
    inc hl
    inc hl
    inc hl
    push hl
    ld a, b
    ld c, MON_LEVEL
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15
    ld a, [wDigits + $1]
    add a, $E0
    pop hl
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl+], a
    pop bc
    ret

; when wC8C0 is 0 it becomes $E3, and then when wC8C1 is 0 too it becomes $E3: a digit byte of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros are blanked (E-0093) (the same 23 bytes appear in 2 banks)
; 7 call sites from 7 routines (e.g. BreedMenu_ChooseParents_TestBitInFieldAtArg3, DrawRecordField0EMarkAndField56Digits, MedalPrizeMenu_WriteScreenStateAndTwoChoiceCursorEtc, DrawArenaWinsLoCountBoxAndStep, ...)
; reads: wDigits
; writes: wDigits
BlankLeadingZeroDigits_F_Bank15::
Func_015_68DC:: ; address name
    ld a, [wDigits]
    and a, a
    jr nz, .return
    add a, $E3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a, a
    jr nz, .return
    add a, $E3
    ld [wDigits + $1], a

.return:
    ret

; TestBitInFieldAtArg3, then ORs its mask into the byte, setting bit wD7F1/wD7F2 of the field at wD7F3/wD7F4 (E-0114)
; 5 call sites from 5 routines (e.g. BreedMenu_ChooseParents_WriteScreenSubStepAndScreenStepEtc, RunLinkSession4ScreenState_Case08_Case04_ComputeBreedingChild, NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc, StoreReceivedRecordIntoSRAM, ...)
SetBitInFieldAtArg3::
Func_015_68F3:: ; address name
    call TestBitInFieldAtArg3
    ld a, [hl]
    or a, b
    ld [hl], a
    ret

; index = the word wD7F1/wD7F2, field = the address in wD7F3/wD7F4: wD7F5 = $FF when bit index of the field is set (bit order $80 first within each byte), else 0 (E-0074)
; 12 call sites from 9 routines (e.g. SetBitInFieldAtArg3, BreedMenu_ChooseParents_TestBitInFieldAtArg3_Case28, BreedMenu_ChooseParents_TestBitInFieldAtArg3, BreedMenu_ChooseParents_ComputeBreedingChild, ...)
; reads: wArg1, wArg2, wArg3, wArg4
; writes: wArg5
TestBitInFieldAtArg3::
Func_015_68FA:: ; address name
    ld a, [wArg1]
    ld e, a
    ld a, [wArg2]
    ld d, a
    push de
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wArg3]
    ld l, a
    ld a, [wArg4]
    ld h, a
    add hl, de
    pop de
    push hl
    ld a, e
    and a, $07
    ld hl, TestBitInFieldAtArg3_Data
    add_a_to_hl
    ld a, [hl]
    ld b, a
    pop hl
    ld a, [hl]
    and a, b
    jr nz, .set_arg5_to_FF
    xor a, a
    ld [wArg5], a
    ret

.set_arg5_to_FF:
    ld a, $FF
    ld [wArg5], a
    ret

; address loaded by TestBitInFieldAtArg3
TestBitInFieldAtArg3_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_6937:: ; address name
    db $80, $40, $20, $10, $08, $04, $02, $01

; only called from routines of BreedMenu (E-0098)
; 2 call sites from 2 routines (e.g. BreedMenu_ChooseParents_LoadRecordSelectedRecordByte0EBit0, BreedMenu_Case12_LoadRecordSelectedRecordByte0EBit0)
; reads: wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, wListEntries2, sRecords, wArg1
BreedMenu_WriteListCountAndRAMG2Etc::
Func_015_693F:: ; address name
    ld hl, wListEntries
    ld b, $1E

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    ld hl, wListEntries2
    ld b, $1E

.loop2:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop2
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop3:
    ld a, [de]
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip
    jr .skip4

.skip:
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a, a
    jr nz, .check_records_flagged
    pop de
    push de
    ld a, $0E
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    and a, $01
    push hl
    ld hl, wArg1
    cp a, [hl]
    jr nz, .restore
    pop hl
    pop de
    jr .skip4

.restore:
    pop hl
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr .skip4

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip4:
    ld a, $A5
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp a, $1E
    jr c, .loop3
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; with SRAM bank 0 enabled: wD7F1 = bit 0 of byte $0E of record wD7B4 (LoadSRAMRecordByte) (E-0119)
; 2 call sites from 2 routines (e.g. BreedMenu_ChooseParents_LoadRecordSelectedRecordByte0EBit0, BreedMenu_Case12_LoadRecordSelectedRecordByte0EBit0)
; reads: wSelectedRecord, hTemp0
; writes: rRAMG2, rRAMB, wArg1
LoadRecordSelectedRecordByte0EBit0::
Func_015_69C6:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wArg1], a
    xor a, a
    ld [rRAMG2], a
    ret

; clears 4 tiles at vTiles2 + $7C0, 3 at vTiles1 + $400 and 2 at vTiles1 + $4A0 (FillTilesBxC); falls through (E-0122)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_ToClearThreeTileRowsAndStep, BreedMenu_ChooseParents_ClearThreeTileRows, BreedMenu_Case12_ClearThreeTileRows)
ClearThreeTileRows::
Func_015_69E3:: ; address name
    ld hl, vTiles2 + $7C0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $4A0
    ld bc, $0201
    call FillTilesBxC

; clears tile areas with FillTilesBxC: 9 x 1 at vTiles2 + $700, 3 x 1 at vTiles1 + $750, 2 x 1 at vTiles1 + $7D0 (E-0117)
; 2 call sites from 2 routines (e.g. BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript, BreedMenu_ChooseParents_ClearTileAreas2700_1750_17D0)
ClearTileAreas2700_1750_17D0::
Func_015_69FE:: ; address name
    ld hl, vTiles2 + $700
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $7D0
    ld bc, $0201
    call FillTilesBxC
    ret

; clears tile areas: 12 x 1 at vTiles1 + $240, 13 x 1 at vTiles1 + $700, 17 x 1 at vTiles1 + $4E0 (E-0117)
; 1 call site from 1 routine (e.g. BreedMenu_ChooseParents_ClearTileAreas1240_1700_14E0)
ClearTileAreas1240_1700_14E0::
Func_015_6A1A:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call FillTilesBxC
    ret

; record wD7F1: draws its name (field 1) as text line 2 and the name of its species (field $0B) as line 3 (Func_01D_6129) (E-0121)
; 1 call site from 1 routine (e.g. DrawListEntriesCell5RecordNamesAndStep)
; reads: wArg1, hTemp0, hTemp1
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wArg5
DrawRecordNameAndSpeciesName::
Func_015_6A36:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld c, a
    ld a, $02
    ld [wArg5], a
    farcall DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    push bc
    ld a, b
    ld c, MON_SPECIES
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    xor a, a
    ld c, a
    ld a, $03
    ld [wArg5], a
    farcall DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; only called from routines of BreedMenu (E-0098)
; 2 call sites from 2 routines (e.g. BreedMenu_ChooseParents_WriteNameEntryStateAndNameEntrySubStateEtc, BreedMenu_Case12_DrawRecordNameAndSpeciesNameTiles)
; reads: wSelectedRecord, wArg5, wArg6
; writes: rRAMG2, rRAMB
; points at: sRecords, wRecordBufA, wRecordBufB
BreedMenu_SetArg5ToListEntriesCell5::
Func_015_6A82:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $A5

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufB
    ld b, $A5

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    xor a, a
    ld [rRAMG2], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 4 call sites from 4 routines (e.g. BreedMenu_ChooseParents_TestBitInFieldAtArg3, DrawRecordNameAndSpeciesName, BreedMenu_Case0B_CopyMonsterNameToBuffer_B15, BreedMenu_ChooseParents_ComputeBreedingChild)
; reads: wDataBank
; writes: wDataBank
; points at: wNameGlyphBuf
CopyMonsterNameToBuffer_B15::
Func_015_6ACA:: ; address name
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
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
    ret

; clears the text tiles and, when the save is valid, shows the save details (player name, play time, party) from SRAM in the window (E-0131)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_ShowSaveFileInfoWindow, KeyAppraisalMenu_ChooseKey_ShowSaveFileInfoWindow, RunLinkSession8Exchange_Case01_Sub01_Table4_Case02)
; reads: hTemp0, wDigits
; writes: wStringCategory, wStringIndex, wScreenSubStep, rRAMG2, rRAMB, wNameGlyphBuf, wArg3, wArg4, ...
; points at: wTextWindowTileLo, sSavedPlayerName, wNameGlyphBuf, wDigits, sSaveData, sSavedMapType, sSavedKeyIndex, sSavedKeyList, ...
ShowSaveFileInfoWindow::
Func_015_6B00:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    farcall CheckSaveData
    ldh a, [hTemp0]
    or a, a
    jr z, .skip
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8D
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0F
    xor a, a
    ld [wStringCategory], a
    ld a, $28
    ld [wStringIndex], a ; 'Unused.'
    farcall ShowString_Bank1B_4C94
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [wScreenSubStep], a
    ret

.skip:
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld de, TileRect_15_71A1
    ld hl, wWindowTileBuffer + $64
    ld bc, $140B
    call CopyRectTo20ByteRows_Bank15
    ld hl, sSavedPlayerName
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr z, .skip2
    ld hl, Tiles_15_763B
    ld de, vTiles2 + $6F0
    call CopyTileBytesToVRAM_Bank15
    ld a, $6F
    ld hl, wWindowTileBuffer + $B0
    ld [hl+], a
    ld [hl], a
    ld hl, wWindowTileBuffer + $C4
    ld [hl+], a
    ld [hl], a

.skip2:
    ld hl, sSavedPlayerName
    ld de, wNameGlyphBuf
    ld c, $0A

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .skip3
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .loop

.skip3:
    ld a, $F0
    ld [de], a
    ld de, vTiles1 + $280
    call CopyGlyphTilesToVRAM
    ld a, $16
    ld [wNameGlyphBuf], a
    ld a, $24
    ld [wNameGlyphBuf + $1], a
    ld a, $36
    ld [wNameGlyphBuf + $2], a
    ld a, $37
    ld [wNameGlyphBuf + $3], a
    ld a, $F0
    ld [wNameGlyphBuf + $4], a
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $28
    ld [wNameGlyphBuf], a
    ld a, $35
    ld [wNameGlyphBuf + $1], a
    ld a, $F0
    ld [wNameGlyphBuf + $2], a
    ld de, vTiles2 + $780
    call CopyGlyphTilesToVRAM
    ld hl, sSavedPlayerName
    ld a, $F1
    add_a_to_hl
    ld b, [hl]
    ld hl, sSavedPlayerName
    ld a, $F2
    add_a_to_hl
    ld c, $00
    xor a, a
    ld [rRAMG2], a

.loop2:
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    ld a, $01
    ld [wArg2], a
    farcall LoadRecordNameEntry0
    pop bc
    push bc
    ld a, c
    add a, a
    ld hl, ShowSaveFileInfoWindow_Data_6E0E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, .loop2
    ld c, $00

.loop3:
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and a, $0F
    ld [wWorkBuf], a
    xor a, a
    ld [rRAMG2], a
    pop bc
    push bc
    ld a, c
    add a, $C7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, .loop3
    ld c, $00

.loop4:
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, $62
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    xor a, a
    ld [rRAMG2], a
    call HLToDecimalDigits
    pop bc
    push bc
    ld a, c
    add a, a
    ld hl, ShowSaveFileInfoWindow_Data_6E08
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wDigits + $1]
    and a, a
    jr z, .call_wait_for_vram_access
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl], a
    ei
    inc hl

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, .loop4
    ld c, $00

.loop5:
    push hl
    push bc
    ld hl, ShowSaveFileInfoWindow_Data_6DD0
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    di
    call WaitForVRAMAccess
    ld a, $EA
    ld [de], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, $ED
    ld [de], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, .loop5
    ld hl, sSavedPlayerName
    ld de, $0221
    add hl, de
    push hl
    inc hl
    inc hl
    inc hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $85
    ld c, $00
    ld de, wDigits
    ld b, $03
    call WriteDigitTilesFromDEToVRAM
    pop hl
    inc hl
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    xor a, a
    ld [rRAMG2], a
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $89
    ld c, $00
    ld de, wDigits + $1
    ld b, $02
    call WriteDigitTilesFromDEToVRAM
    ld hl, sSaveData
    ld a, $06
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    add a, $0A
    cp a, $0D
    jr nz, .set_string_index
    ld hl, sSavedMapType
    ld a, [hl]
    bit 7, a
    jr z, .set_string_index_to_0D
    ld hl, sSavedKeyIndex
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, sSavedKeyList
    add hl, de
    inc hl
    ld de, wTextBuf0
    ld a, [hl+]
    inc a
    push hl
    call CopyKeyNameWordToDE
    pop hl
    dec de
    ld a, [hl]
    add a, $11
    call CopyKeyNameWordToDE
    dec de
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank08
    jr .skip4

.set_string_index_to_0D:
    ld a, $0D

.set_string_index:
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank08

.skip4:
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    call DecompressGraphicsA4ToTiles0
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScreenSubStep], a
    ret

; address loaded by ShowSaveFileInfoWindow
ShowSaveFileInfoWindow_Data_6DD0:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_6DD0:: ; address name
    db $A8, $C3, $D0, $C3, $F8, $C3

; writes the digits at DE as tiles $E0 + digit to HL (WaitForVRAMAccess, interrupts off), counting C up to B (E-0117)
; 2 call sites from 1 routine (e.g. ShowSaveFileInfoWindow)
WriteDigitTilesFromDEToVRAM::
Func_015_6DD6:: ; address name
    di
    call WaitForVRAMAccess
    ld a, [de]
    add a, $E0
    ld [hl+], a
    ei
    inc de
    inc c
    ld a, c
    cp a, b
    jr c, WriteDigitTilesFromDEToVRAM
    ret

; with SRAM bank 1 selected, HL = sA06F + $6F * [HL + C] (a $6F-byte record in bank 1); then selects bank 0 and disables SRAM (E-0117)
; 3 call sites from 1 routine (e.g. ShowSaveFileInfoWindow)
; writes: rRAMG2, rRAMB
; points at: sBank1Records
SRAMBank1RecordAddress::
Func_015_6DE6:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, $6F
    call Multiply8
    ld de, sBank1Records
    add hl, de
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

; address loaded by ShowSaveFileInfoWindow
ShowSaveFileInfoWindow_Data_6E08:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_6E08:: ; address name
    db $AA, $C3, $D2, $C3, $FA, $C3

; address loaded by ShowSaveFileInfoWindow
ShowSaveFileInfoWindow_Data_6E0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_6E0E:: ; address name
    db $00, $8D, $50, $8D, $A0, $8D

; restores the player position, facing, wFollowerRecords, wC8F0-wC8FB and wCB86 from wC937-wC943 and clears wC936 (E-0121)
; 2 call sites from 2 routines (e.g. BreedMenu_ReturnToMap_LoadMapHeader, BreedMenu_ReturnToMap_DecompressToVRAM)
; reads: wSavedPlayerState
; writes: hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords, wSpriteSlots, wSavedPositionValid
RestorePlayerPositionState::
Func_015_6E14:: ; address name
    ld a, [wSavedPlayerState + $1]
    ldh [hPlayerX], a
    ld a, [wSavedPlayerState + $2]
    ldh [hPlayerY], a
    ld a, [wSavedPlayerState + $3]
    ldh [hPlayerFacing], a
    ld a, [wSavedPlayerState + $4]
    ld [wFollowerRecords], a
    ld a, [wSavedPlayerState + $5]
    ld [wFollowerRecords + $1], a
    ld a, [wSavedPlayerState + $6]
    ld [wFollowerRecords + $2], a
    ld a, [wSavedPlayerState + $7]
    ld [wFollowerRecords + $5], a
    ld a, [wSavedPlayerState + $8]
    ld [wFollowerRecords + $6], a
    ld a, [wSavedPlayerState + $9]
    ld [wFollowerRecords + $7], a
    ld a, [wSavedPlayerState + $A]
    ld [wFollowerRecords + $A], a
    ld a, [wSavedPlayerState + $B]
    ld [wFollowerRecords + $B], a
    ld a, [wSavedPlayerState + $C]
    ld [wFollowerRecords + $C], a
    ld a, [wSavedPlayerState]
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wSavedPositionValid], a
    ret

; for each of the pointers wCF8B and wCF8E (when set): increments the byte it points to, up to 99, and stores wCF8D / wCF90 in the byte before (E-0125)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_WriteScreenSubStepAndScreenStepEtc, NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc, RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case1E)
; reads: wCounterPtr0Hi, wCounterPtr0Lo, wCounterArg0, wCounterPtr1Hi, wCounterPtr1Lo, wCounterArg1
; points at: wCounterPtr0Lo, wCounterPtr1Lo
IncrementTwoCountersCappedAt99::
Func_015_6E64:: ; address name
    ld a, [wCounterPtr0Hi]
    cp a, $FF
    jr z, .check_counter_ptr1_hi
    ld b, a
    ld a, [wCounterPtr0Lo]
    or a, b
    and a, a
    jr z, .check_counter_ptr1_hi
    ld de, wCounterPtr0Lo
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    jr nc, .check_counter_ptr1_hi
    inc a
    ld [hl-], a
    ld a, [wCounterArg0]
    ld [hl], a

.check_counter_ptr1_hi:
    ld a, [wCounterPtr1Hi]
    cp a, $FF
    ret z
    ld b, a
    ld a, [wCounterPtr1Lo]
    or a, b
    ret z
    ld de, wCounterPtr1Lo
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    ret nc
    inc a
    ld [hl-], a
    ld a, [wCounterArg1]
    ld [hl], a
    ret

; clears wCF8B-wCF90, fills them through Func_015_6EFD for wCA2A and (outside link battles) wCACF, wTwoChoiceCursor = wD7F1, wD782 += 1 and requests script $80 (E-0125)
; 3 call sites from 3 routines (e.g. BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript, NpcBreedMenu_ChooseAndBreed_PrepareWCF8BCountersAndRequestScript, RunScreenStateWhenNotFading_F1_LinkBreed_PrepareWCF8BCountersAndRequestScript)
; reads: wRecordBufA, wLinkMode, wRecordBufB, wArg1, wScreenSubStep
; writes: wCounterPtr0Lo, wCounterPtr0Hi, wCounterArg0, wCounterPtr1Lo, wCounterPtr1Hi, wCounterArg1, rRAMG, rRAMB, ...
; points at: wCounterPtr0Lo, wCounterPtr1Lo
PrepareWCF8BCountersAndRequestScript::
Func_015_6EA5:: ; address name
    xor a, a
    ld [wCounterPtr0Lo], a
    ld [wCounterPtr0Hi], a
    ld [wCounterArg0], a
    ld [wCounterPtr1Lo], a
    ld [wCounterPtr1Hi], a
    ld [wCounterArg1], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wArg1], a
    ld de, wCounterPtr0Lo
    ld a, [wRecordBufA + $A4]
    and a, a
    call nz, PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1
    ld a, [wLinkMode]
    and a, a
    jr nz, .skip
    ld de, wCounterPtr1Lo
    ld a, [wRecordBufB + $A4]
    and a, a
    call nz, PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1

.skip:
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, [wArg1]
    ld [wTwoChoiceCursor], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from PrepareWCF8BCountersAndRequestScript (E-0047)
; 2 call sites from 1 routine (e.g. PrepareWCF8BCountersAndRequestScript)
; reads: wArg1, hTemp0, wCounterArg0, wCounterPtr0Lo, wCounterPtr0Hi
; writes: hTemp0, wArg1
; points at: wItemStorage, wCounterPtr0Lo
PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1::
Func_015_6EFD:: ; address name
    add a, $3F
    ldh [hTemp0], a
    ld c, a
    ld hl, wItemStorage
    ld b, $64

.loop:
    ld a, [hl+]
    cp a, c
    jr z, .skip
    and a, a
    jr z, .skip2

.next:
    inc hl
    dec b
    jr nz, .loop
    jr .skip3

.skip:
    ld a, [hl]
    cp a, $63
    jr c, .read_temp02
    jr .skip3

.skip2:
    push hl
    ld hl, wCounterPtr0Lo
    ld a, l
    cp a, e
    jr nz, .read_counter_arg0
    ld a, h
    cp a, d
    jr nz, .read_counter_arg0
    pop hl
    jr .read_temp02

.read_counter_arg0:
    ld a, [wCounterArg0]
    ld l, a
    ldh a, [hTemp0]
    cp a, l
    jr z, .read_temp0
    pop hl
    push hl
    ld a, [wCounterPtr0Lo]
    cp a, l
    jr nz, .read_temp0
    ld a, [wCounterPtr0Hi]
    cp a, h
    jr nz, .read_temp0
    pop hl
    jr .next

.read_temp0:
    pop hl

.read_temp02:
    ldh a, [hTemp0]
    push af
    push de
    push hl
    pop hl
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop af
    ld [de], a
    jr .set_arg1_to_01

.set_arg1_to_01:
    ld a, $01
    ld [wArg1], a
    ret

.skip3:
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    ld a, [wArg1]
    and a, a
    ret nz
    xor a, a
    ld [wArg1], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_15_6F6B::
Data_015_6F6B:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A4, $A5, $EE, $EE, $A6, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A7, $A8, $A9, $AA, $AB, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $AC, $AD, $AE, $A9, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_15_6FA3::
Data_015_6FA3:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_15_6FDB::
Data_015_6FDB:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_15_7050::
Data_015_7050:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C0, $C1, $C2, $C7, $C8, $C9, $CA, $CB, $FC, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 11 tiles, one row per line
TileRect_15_70C5::
Data_015_70C5:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 11 tiles, one row per line
TileRect_15_71A1::
Data_015_71A1:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $A4, $A5, $A6, $A7, $78, $79, $ED, $A8, $A9, $AA, $AB, $AC, $C3, $C3, $C3, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C7, $D0, $D1, $D2, $D3, $D4, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C8, $D5, $D6, $D7, $D8, $D9, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C9, $DA, $DB, $DC, $DD, $DE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $C3, $C3, $C3, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 1 tiles, one row per line
TileRect_15_727D::
Data_015_727D:: ; address name
    db $B6, $C3, $C3, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $B7 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_15_7291::
Data_015_7291:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_15_72A9::
Data_015_72A9:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0 ; entry 0
    dw vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $6E0, vTiles1 + $6F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_15_72C5::
Data_015_72C5:: ; address name
    dw $40C0, $4360, $4280, $4120, $4250, $4380, $4270, $42C0 ; entry 0
    dw $40F0, $43C0, $42D0, $4290, $4910, $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_15_72E1::
Data_015_72E1:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_15_72F1::
Data_015_72F1:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_15_72FF::
Data_015_72FF:: ; address name
    dw $4130, $4180, $4100, $4190, $41E0, $40F0, $41D0, $4150 ; entry 0
    dw $4160, $41A0, $40B0, $4910, $4910, $FFFF

; address loaded by BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc, BreedMenu_Case05_Case00_WriteArg1AndArg2Etc
BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_731B:: ; address name
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $FF, $FF

; address loaded by BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A, BreedMenu_ChooseParents_StoreBAtWordTableEntry_Bank15, BreedMenu_Case05_ListRecordsInUseWithByte6ESet, BreedMenu_ChooseParents_BlankWordTableTargets and 4 more
BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_732D:: ; address name
    db $79, $C3, $A1, $C3, $C9, $C3

; address loaded by BreedMenu_Case05_ClampRecordListPageCursor4_Case03, BreedMenu_Case05_UpdatePagedListCursor, BreedMenu_Case0F_StoreBAtWordTableEntry_Bank15
BreedMenu_Case05_ClampRecordListPageCursor4_Case03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_7333:: ; address name
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

; address loaded by BreedMenu_ReturnToMap_SRAMRecordAddress, BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19
BreedMenu_ReturnToMap_SRAMRecordAddress_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_733B:: ; address name
    db $27, $C4, $4F, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 2 x 3 tiles, one row per line
TileRect_15_733F::
Data_015_733F:: ; address name
    db $C3, $B7 ; id 0
    db $C3, $B7 ; id 1
    db $B4, $B5 ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 4 x 3 tiles, one row per line
TileRect_15_7345::
Data_015_7345:: ; address name
    db $C3, $C3, $C3, $B7 ; id 0
    db $C3, $C3, $C3, $B7 ; id 1
    db $B4, $B4, $B4, $B5 ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_15_7351::
Data_015_7351:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $70, $71, $72, $73, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $74, $75, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_15_7379::
Data_015_7379:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep, BreedMenu_ChooseParents_UpdatePagedListCursor, BreedMenu_ChooseParents_BlankWordTableTargets_Case10, BreedMenu_ChooseParents_BlankWordTableTargets_Case12 and 6 more
BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_73A1:: ; address name
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_15_73AB::
Data_015_73AB:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $77, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 9 tiles, one row per line
TileRect_15_73C9::
Data_015_73C9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 9 tiles, one row per line
TileRect_15_7411::
Data_015_7411:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $F5, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $F6, $F7, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; id 7
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_7471:: ; address name
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_15_747D::
Data_015_747D:: ; address name
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
TileRect_15_74D5::
Data_015_74D5:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_7505:: ; address name
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 4
BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_7511:: ; address name
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 3 tiles, one row per line
TileRect_15_7541::
Data_015_7541:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 3 tiles, one row per line
TileRect_15_7565::
Data_015_7565:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C9, $7C, $7D, $7E, $7F, $C0, $C1, $C2, $CA, $CB, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 5 tiles, one row per line
TileRect_15_7589::
Data_015_7589:: ; address name
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 0
    db $B6, $F5, $F6, $F7, $FD, $FE, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $FF, $77, $78, $70, $71, $72, $73, $74, $75, $76, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by BreedMenu_ChooseParents_ComputeBreedingChild, BreedMenu_ChooseParents_TestBitInFieldAtArg3
BreedMenu_ChooseParents_ComputeBreedingChild_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_75C5:: ; address name
    db $FF, $FF, $DC, $00, $0F, $FF, $FF, $F1, $01, $FF, $FF, $3F, $36, $3F, $FF, $E2
    db $88, $07, $FF, $FF, $C3, $00, $FF, $FF, $FC, $40, $1F, $FF, $FE, $F8, $83, $FF
    db $FE, $63, $00, $7F, $FB, $F9, $F9, $0F, $FF, $FF, $C4, $30, $00, $00, $00, $00

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_15_75F5::
Data_015_75F5:: ; address name
    db $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_15_761D::
Data_015_761D:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B4, $B4, $B4, $B4, $B4, $B5 ; id 2
    db $72, $73, $74, $75, $76, $B7 ; id 3
    db $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0238 (derived: HL = $763B and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_15_763B::
Data_015_763B:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_15_764B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
Script_15_764C:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_765A, Script_15_7657, Script_15_7651
Script_15_7651:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8020 ; 'Become a great master!'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_15_7657:: ; heuristic: event script entry or jump target; C0
    script_jump Script_15_7724
Script_15_765A:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Which will be the base monster?'
Script_15_765D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7668, Script_15_7661
Script_15_7661:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_7668:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'This is the one you want?'
    script_command SCRIPT_BREED
Script_15_766C:: ; heuristic: event script entry or jump target; C0
    script_choice_jump Script_15_7677, Script_15_767B, Script_15_7670
Script_15_7670:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Which will be the base monster?'
    script_command SCRIPT_BREED
    script_jump Script_15_765D
Script_15_7677:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_jump Script_15_766C
Script_15_767B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7697, Script_15_7691, Script_15_768B, Script_15_7681
Script_15_7681:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'There's no potential mate.'
Script_15_7684:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Which will be the base monster?'
    script_command SCRIPT_BREED
    script_jump Script_15_765D
Script_15_768B:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'That's too low in level to'
    script_jump Script_15_7684
Script_15_7691:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'You won't have a monster with'
    script_jump Script_15_7684
Script_15_7697:: ; heuristic: event script entry or jump target; C0
    script_message $C007 ; 'And what will its mate be?'
Script_15_769A:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76A5, Script_15_769E
Script_15_769E:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Which will be the base monster?'
    script_command SCRIPT_BREED
    script_jump Script_15_765D
Script_15_76A5:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'This is the one you want?'
Script_15_76A8:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76B5, Script_15_76B9, Script_15_76AD
Script_15_76AD:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_message $C007 ; 'And what will its mate be?'
    script_command SCRIPT_BREED
    script_jump Script_15_769A
Script_15_76B5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_jump Script_15_76A8
Script_15_76B9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76CB, Script_15_76C5, Script_15_76C5, Script_15_76BF
Script_15_76BF:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'That's too low in level to'
    script_jump Script_15_76AD
Script_15_76C5:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'You won't have a monster with'
    script_jump Script_15_76AD
Script_15_76CB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76D5, Script_15_76CF
Script_15_76CF:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'A great monster will be born!'
    script_jump Script_15_76E5
Script_15_76D5:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; '0 will result from this.'
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76E2, Script_15_76DC
Script_15_76DC:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; 'You e never had that monster.'
    script_jump Script_15_76E5
Script_15_76E2:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'You already had that monster.'
Script_15_76E5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76E9, Script_15_76EC
Script_15_76E9:: ; heuristic: event script entry or jump target; C0
    script_jump Script_15_76EF
Script_15_76EC:: ; heuristic: event script entry or jump target; C0
    script_message $C029 ; 'Accessories will be in the Vault.'
Script_15_76EF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76FC, Script_15_76F4
Script_15_76F4:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_message $C004 ; 'Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_76FC:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_message $C00F ; 'Hatching that will cost 0G. Should'
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7706, Script_15_7712, Script_15_770C
Script_15_7706:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; 'I'll hatch the egg too, then.'
    script_jump Script_15_7764
Script_15_770C:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; 'You don't have enough gold, so'
    script_jump Script_15_7715
Script_15_7712:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; 'I won't hatch the egg, then.'
Script_15_7715:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_message $401E ; 'You got the egg of 0.'
    script_message $C019 ; '0 is going to the farm.'
    script_command SCRIPT_BREED
    script_message $C004 ; 'Is there anything else?'
    script_jump Script_15_764C
Script_15_7724:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7731, Script_15_7728
Script_15_7728:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; 'There isn't a single egg here.'
    script_message $C004 ; 'Is there anything else?'
    script_jump Script_15_764C
Script_15_7731:: ; heuristic: event script entry or jump target; C0
    script_message $C01A ; 'Which egg should I hatch?'
Script_15_7734:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_773F, Script_15_7738
Script_15_7738:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_773F:: ; heuristic: event script entry or jump target; C0
    script_message $C01B ; 'That will cost 0G. OK?'
Script_15_7742:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_774E, Script_15_7752, Script_15_7747
Script_15_7747:: ; heuristic: event script entry or jump target; C0
    script_message $C01A ; 'Which egg should I hatch?'
    script_command SCRIPT_BREED
    script_jump Script_15_7734
Script_15_774E:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_jump Script_15_7742
Script_15_7752:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7761, Script_15_7756
Script_15_7756:: ; heuristic: event script entry or jump target; C0
    script_message $C01D ; 'You don't have enough gold.'
    script_command SCRIPT_BREED
    script_message $C004 ; 'Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_7761:: ; heuristic: event script entry or jump target; C0
    script_message $C021 ; 'Fine, fine. Just wait here.'
Script_15_7764:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
Script_15_7766:: ; heuristic: event script entry or jump target; C0
    script_message $4014 ; 'Will you take 0 with you?'
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7778, Script_15_776D
Script_15_776D:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; 'I'll send 0 to the farm,'
Script_15_7770:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_message $C004 ; 'Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_7778:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7782, Script_15_777C
Script_15_777C:: ; heuristic: event script entry or jump target; C0
    script_message $C015 ; 'Raise it with love and care!'
    script_jump Script_15_7770
Script_15_7782:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'Which will go back to the'
Script_15_7785:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_778D, Script_15_7789
Script_15_7789:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_jump Script_15_7766
Script_15_778D:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is this the one to send'
Script_15_7790:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_choice_jump Script_15_779C, Script_15_77A0, Script_15_7795
Script_15_7795:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_message $C017 ; 'Which will go back to the'
    script_jump Script_15_7785
Script_15_779C:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_jump Script_15_7790
Script_15_77A0:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED
    script_message $C019 ; '0 is going to the farm.'
    script_command SCRIPT_BREED
    script_message $C004 ; 'Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C

; only called from routines of HibernateMenu (E-0098)
; 2 call sites from 2 routines (e.g. HibernateMenu_ChooseRecords_WriteArg1AndArg2Etc, HibernateMenu_Case04_WriteListCursorAndListPageIndexEtc)
; writes: wListCount, rRAMG2, rRAMB
; points at: wListEntries, sCompactRecords, sRecords
HibernateMenu_WriteListCountAndRAMG2Etc::
Func_015_77AC:: ; address name
    ld hl, wListEntries
    ld b, $1E

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, sCompactRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop2:
    ld a, [de]
    bit 7, a
    jr z, .skip
    inc c
    ld a, b
    ld [hl+], a

.skip:
    ld a, $6F
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp a, $1D
    jr c, .loop2
    ld de, sRecords
    ld a, $01
    ld [rRAMB], a
    ld a, [de]
    bit 7, a
    jr z, .set_list_count
    inc c
    ld a, b
    ld [hl+], a

.set_list_count:
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    ret

; only called from HibernateMenu_ChooseRecords_Case03 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Case03)
; reads: wListPageIndex, wListLastRow, wListCount, wScreenStep, wListPages
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wNameGlyphBuf, wScreenStep
; points at: wListEntries, sCompactRecords, sRecords
HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc::
Func_015_77FB:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    ld b, a
    sla a
    sla a
    add a, b
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp a, $04
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp a, $01
    jr nz, .read_list_count
    ld a, [wListCount]
    jr .read_list_page_index

.read_list_count:
    ld a, [wListCount]

.read_list_page_index:
    ld b, a
    ld a, [wListPageIndex]
    push bc
    ld c, a
    sla a
    sla a
    add a, c
    pop bc
    add a, c
    cp a, b
    jr nc, .check_screen_step
    push hl
    push bc
    xor a, a
    ld [wArg1], a
    ld a, [hl]
    cp a, $1D
    jr z, .set_arg2_to_01
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    ld [wArg2], a

.set_arg3:
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    jr .call_load_record_name_entry0

.set_arg2_to_01:
    ld a, $01
    ld [wArg2], a
    ld hl, sRecords
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    jr .set_arg3

.call_load_record_name_entry0:
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, .skip
    call HibernateMenu_ChooseRecords_Case03_Sub01_GlyphCopyArgsForA_Bank15
    jr .restore

.skip:
    ld a, c
    sla a
    ld hl, HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Data
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call CopyGlyphTilesToVRAM

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, .check_screen_step
    ld a, c
    cp a, $05
    jp c, .loop

.check_screen_step:
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc
HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_78BB:: ; address name
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; only called from HibernateMenu_ChooseRecords_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
HibernateMenu_ChooseRecords_Case03_Sub01_GlyphCopyArgsForA_Bank15::
Func_015_78C5:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, .clear_glyph_list_start
    cp a, $8D
    jr z, .check_glyph_list_start
    cp a, $8E
    jr z, .check_glyph_list_start
    call GlyphCopyArgsForA_Bank15
    call CopyFromBankWaitVRAM
    jr .check_glyph_list_start2

.check_glyph_list_start:
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    call GlyphCopyArgsForA_Bank15
    call OrFromBankWaitVRAM

.check_glyph_list_start2:
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr .read_glyph_list_pos

.clear_glyph_list_start:
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DE = $4010 + 16 * A (the glyph's tile), HL = the VRAM address from Data_015_794A + 2 * wD785, B = $1F (bank), C = 16 (bytes) (E-0121)
; 2 call sites from 1 routine (e.g. HibernateMenu_ChooseRecords_Case03_Sub01_GlyphCopyArgsForA_Bank15)
; reads: wGlyphListStart
GlyphCopyArgsForA_Bank15::
Func_015_7917:: ; address name
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, GlyphCopyArgsForA_Bank15_Data
    ld a, [wGlyphListStart]
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

; address loaded by GlyphCopyArgsForA_Bank15
GlyphCopyArgsForA_Bank15_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_794A:: ; address name
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; wD09D = the family nibble of the record selected by wD7F1 (Func_015_7A43), wD09E = $C7, then LoadFamilyIconTileForWorkBuf (E-0122)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5)
; reads: wArg1
; writes: rRAMG2, wWorkBuf
LoadFamilyIconTileForArg1Record::
Func_015_7954:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    ld a, [hl]
    and a, $0F
    ld [wWorkBuf], a
    ld a, $C7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ret

; only called from HibernateMenu_ChooseRecords_Case04 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5)
; reads: wArg1, wDigits
; writes: rRAMG2, wWindowTileBuffer, wArg1, wArg3, wArg5, wArg7, wArg2, wArg4, ...
; points at: wArg1
HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D::
Func_015_7976:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    push hl
    inc hl
    ld a, [hl]
    and a, $08
    sla a
    swap a
    pop hl
    add a, $CC
    ld [wWindowTileBuffer + $86], a
    push hl
    ld a, $62
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15_7ADB
    ld a, [wDigits + $1]
    add a, $E0
    ld [wWindowTileBuffer + $89], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [wWindowTileBuffer + $8A], a
    pop hl
    push hl
    ld a, $57
    add_a_to_hl
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl+]
    ld [wArg3], a
    ld a, [hl+]
    ld [wArg5], a
    ld a, [hl+]
    ld [wArg7], a
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wArg2], a
    ld a, [hl]
    and a, $30
    swap a
    ld [wArg4], a
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wArg6], a
    ld a, [hl]
    and a, $03
    ld [wArg8], a
    pop hl
    ld c, $00

.loop:
    push bc
    ld a, c
    sla a
    ld de, wArg1
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15_7ADB
    pop bc
    ld a, c
    sla a
    ld hl, HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D_Data
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wDigits]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wDigits + $1]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wDigits + $2]
    add a, $E0
    ld [de], a
    inc c
    ld a, c
    cp a, $04
    jr c, .loop
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D
HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_015_7A3B:: ; address name
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; HL = sB356 + $6F * B in SRAM bank 0, except record $1D, which is at sA000 in SRAM bank 1 (E-0122)
; 3 call sites from 3 routines (e.g. HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D, LoadFamilyIconTileForArg1Record, HibernateMenu_ChooseRecords_Case06_RecordAddressWithBank1Slot1D)
; writes: rRAMB
; points at: sCompactRecords, sRecords
RecordAddressWithBank1Slot1D::
Func_015_7A43:: ; address name
    ld a, b
    cp a, $1D
    jr z, .skip
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    ld [rRAMB], a
    ret

.skip:
    ld hl, sRecords
    ld a, $01
    ld [rRAMB], a
    ret

; only called from HibernateMenu_ChooseRecords_Case06 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_ChooseRecords_SetArg5ToListEntriesCell5_Case06)
; reads: wArg1, wDataBank
; writes: rRAMG2, wArg2, wArg1, wArg3, wArg4, wNameGlyphBuf, wDataBank
; points at: wNameGlyphBuf
HibernateMenu_ChooseRecords_Case06_RecordAddressWithBank1Slot1D::
Func_015_7A5F:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    push hl
    ld [wArg2], a
    xor a, a
    ld [wArg1], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop hl
    inc hl
    ld a, [hl+]
    and a, $01
    ld e, a
    ld a, [hl]
    ld l, a
    ld a, e
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld b, a
    ld a, e
    ld c, a
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, vTiles1 + $270
    call CopyGlyphTilesToVRAM
    xor a, a
    ld [rRAMG2], a
    ret

; when wC8C0 is 0 it becomes $E3, and then when wC8C1 is 0 too it becomes $E3: a digit byte of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros are blanked (E-0093) (the same 23 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D)
; reads: wDigits
; writes: wDigits
BlankLeadingZeroDigits_F_Bank15_7ADB::
Func_015_7ADB:: ; address name
    ld a, [wDigits]
    and a, a
    jr nz, .return
    add a, $E3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a, a
    jr nz, .return
    add a, $E3
    ld [wDigits + $1], a

.return:
    ret
    ds $50E, $00
