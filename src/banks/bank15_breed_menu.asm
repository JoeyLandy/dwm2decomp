; ROM bank $15: the breeding menu
; The annotated listing of this bank is build/listing/bank15.asm.

SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

; implements script command type EE (SCRIPT_BREED_CLOSE): ends the breeding (and medal prize)
; session and clears wMessageMode; reached through ScriptCommandEE in bank $10 (E-0038, E-0244)
CloseBreedMenu::
    ld a, [wScreenList]
    jumptable
    dw CloseBreedMenu_CopyBytesDEToHL_Bank15
    dw CloseBreedMenu_CopyGlyphTileListFromBank1F_Bank15
    dw CloseBreedMenu_FillTilesBxC
    dw CloseBreedMenu_DrawRecordListNameTiles_Bank1D

CloseBreedMenu_CopyBytesDEToHL_Bank15::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank15
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

.call_bg_map_address_at_scroll_bank15:
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

CloseBreedMenu_CopyGlyphTileListFromBank1F_Bank15::
    ld hl, TileCopyDestList_15_72A9
    ld de, TileCopySrcList_15_72FF
    call CopyGlyphTileListFromBank1F_Bank15
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
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

CloseBreedMenu_FillTilesBxC::
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles1 + $4f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles_1F_4370
    ld hl, vTiles1 + $5f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

CloseBreedMenu_DrawRecordListNameTiles_Bank1D::
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
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
    ld hl, wTextBuf0
    ld b, $10

.loop2:
    ld a, $f0
    ld [hli], a
    dec b
    jr nz, .loop2
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, $80
    ldh [hSpriteHideTile], a
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

; implements script command type ED (SCRIPT_BREED): breeding: 'Which will be the base monster?',
; 'And what will its mate be?' (mode 5, bank $1B strings); reached through ScriptCommandED in bank
; $10 (E-0038, E-0244) (C2 from E-0328: started by its script, it shows Breed / Hatch / Exit, takes
; a base and a mate, removes both parents' records and adds the hatched, named child)
BreedMenu::
    ld a, [wScreenState]
    jumptable
    dw BreedMenu_Init
    dw BreedMenu_Setup
    dw BreedMenu_ToHandleThreeOptionMenuInput_15
    dw BreedMenu_WriteTwoChoiceCursorAndScreenStateEtc
    dw BreedMenu_ChooseParents
    dw BreedMenu_ChooseEgg
    dw BreedMenu_NameEntry
    dw BreedMenu_ReturnToMap
    dw BreedMenu_TalkEvent17ThenNameEntry
    dw BreedMenu_CopyToChildThenTalkEvent16
    dw BreedMenu_TalkEvent15
    dw BreedMenu_RestoreScreen
    dw BreedMenu_SwapMonstersMenu
    dw BreedMenu_SwapMonstersMenu_Case0D
    dw BreedMenu_SwapMonstersMenu_Case0D
    dw BreedMenu_RedrawListScreen
    dw BreedMenu_ClearListMarks
    dw BreedMenu_ListMonsters
    dw BreedMenu_ShowSelectedRecord

; state 0 of BreedMenu: clears $6F bytes from wScreenState (E-0277)
BreedMenu_Init::
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
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a
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
    xor a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; draws the two boxes and the gold box (E-0277)
BreedMenu_Setup::
    ld a, [wScreenStep]
    jumptable
    dw DrawPair72A9And72C5AndStep
    dw DrawGoldBoxAndStep_Bank15
    dw BreedMenu_Setup_CopyRectTo20ByteRows_Bank15

; runs CopyGlyphTileListFromBank1F_Bank15 for TileCopyDestList_15_72A9 and TileCopySrcList_15_72C5,
; then wScreenStep += 1 (E-0122)
DrawPair72A9And72C5AndStep::
    ld hl, TileCopyDestList_15_72A9
    ld de, TileCopySrcList_15_72C5
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies box TileRect_15_7291 to wWindowTileBuffer + $70 and writes the gold as five digit tiles at
; wWindowTileBuffer + $86, then wScreenStep += 1 (E-0125)
DrawGoldBoxAndStep_Bank15::
    ld de, TileRect_15_7291
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank15
    ld hl, wGoldLo
    ld de, wDigits
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
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
    add $e0
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $05
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_Setup_CopyRectTo20ByteRows_Bank15::
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140b
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

BreedMenu_ToHandleThreeOptionMenuInput_15::
    call HandleThreeOptionMenuInput_15
    ret

BreedMenu_WriteTwoChoiceCursorAndScreenStateEtc::
    ld a, [wGridCursorX]
    and a
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
    and a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; BreedMenu screen state 4, by wScreenStep: lists the records in use, takes two monsters from paged
; lists, then ComputeBreedingChild and the name-entry state
BreedMenu_ChooseParents::
    ld a, [wScreenStep]
    jumptable
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

BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case00::
    ld c, $0b
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_42F4
    ld hl, wWindowTileBuffer + $64
    ld bc, $080b
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wCursorBlinkAE], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 11 tiles, one row per line
TileRect_15_42F4::
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

BreedMenu_ChooseParents_ClearTileAreas1240_1700_14E0::
    call ClearTileAreas1240_1700_14E0
    ld de, TileRect_15_747D
    ld hl, wWindowTileBuffer + $64
    ld bc, $080b
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear::
    farcall ListRecordsInUseWithByte6EClear

BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5::
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank15
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank15
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

BreedMenu_ChooseParents_DrawRecordListPageNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

BreedMenu_ChooseParents_SetArg5ToListEntriesCell5::
    farcall SetArg5ToListEntriesCell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $c7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, TileRect_15_74D5
    ld hl, wWindowTileBuffer + $bc
    ld bc, $0c09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $d6
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    call DrawRecordField0EMarkAndField56Digits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_FillTilesBxC::
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

BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case06::
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

; DrawScreenBufferRect_Bank15 (20 x 13 from buffer offset $01CC at the scroll origin), then
; wScreenStep += 1 (E-0119)
DrawScreenBufferAtScrollAndIncScreenStep::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep::
    ld a, [wListCursor]
    ld b, $bb
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    call DrawScreenBufferAtScrollAndIncScreenStep
    ld a, [wListCursor]
    ld b, $c3
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    ret

BreedMenu_ChooseParents_UpdatePagedListCursor::
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
    add $04
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
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

BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15_Case09::
    ld c, $0b
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_6FA3
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A::
    call DrawPair72A9And72C5AndStep
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_CopyRectTo20ByteRows_Bank15::
    ld de, TileRect_15_7379
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_CopyGlyphTileListFromBank1F_Bank15::
    ld a, $6c
    call QueueSoundEffect
    ld hl, TileCopyDestList_15_72E1
    ld de, TileCopySrcList_15_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wTwoChoiceCursor], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep::
    ld de, BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep_Data
    ld hl, wWindowTileBuffer + $10c
    ld bc, $0c05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_BlankWordTableTargets_Case10::
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $08
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case11::
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
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    ld [wArg5], a
    ld hl, wListEntries
    ld c, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    ld b, a
    ld a, [wArg5]
    cp b
    jr nz, .restore
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr nz, .loop
    pop hl
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a
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
    cp $0a
    jr nc, .check_party_count
    pop hl
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_party_count:
    pop hl
    ld a, [wPartyCount]
    cp $02
    jr nc, .call_set_arg5_to_list_entries_cell5
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp b
    jr nz, .call_set_arg5_to_list_entries_cell5
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a
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
    xor a
    ld [rRAMG2], a
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_BlankWordTableTargets_Case12::
    ld a, $b6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $a0], a
    ld [wWindowTileBuffer + $c8], a
    ld de, TileRect_15_7541
    ld hl, wWindowTileBuffer + $94
    ld bc, $0c03
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep_Data
    ld hl, wWindowTileBuffer + $10c
    ld bc, $0c05
    call CopyRectTo20ByteRows_Bank15
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_ToBreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc::
    call BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc
    ret

BreedMenu_ChooseParents_ClearThreeTileRows::
    call ClearThreeTileRows
    ld de, TileRect_15_7565
    ld hl, wWindowTileBuffer + $94
    ld bc, $0c03
    call CopyRectTo20ByteRows_Bank15
    ld de, TileRect_15_7589
    ld hl, wWindowTileBuffer + $10c
    ld bc, $0c05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_FillTilesBxC_Case15::
    ld hl, vTiles1 + $240
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4e0
    ld bc, $1101
    call FillTilesBxC
    ld de, TileRect_15_747D
    ld hl, wWindowTileBuffer + $64
    ld bc, $080b
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_LoadRecordSelectedRecordByte0EBit0::
    call LoadRecordSelectedRecordByte0EBit0
    call BreedMenu_WriteListCountAndRAMG2Etc
    jp BreedMenu_ChooseParents_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5

; for the record at WD789 cell 5 loads its family icon tile and draws its mark and level at
; wWindowTileBuffer + $126, then wScreenStep += 1 (E-0124)
DrawListEntriesCell5IconAndLevelAndStep::
    farcall SetArg5ToListEntriesCell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $ff
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

BreedMenu_ChooseParents_ToClearThreeTileRowsAndStep::
    call ClearThreeTileRows
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; draws the name and species name of the record at WD789 cell 5, clears wNameEntryState and
; wNameEntrySubState and wScreenStep += 1 (E-0122)
DrawListEntriesCell5RecordNamesAndStep::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesName
    xor a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_WriteNameEntryStateAndNameEntrySubStateEtc::
    call BreedMenu_SetArg5ToListEntriesCell5
    xor a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_ComputeBreedingChild::
    xor a
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wArg7]
    cp $ff
    jr nz, .read_arg6
    ld a, [wArg6]
    cp $ff
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
    cp $ff
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
    cp $ff
    jr z, .read_arg62
    ld a, [wArg6]
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a
    jr nz, .read_arg62

.skip:
    ld c, $00
    ld hl, wNameGlyphBuf

.loop:
    ld a, $98
    ld [hli], a
    inc c
    ld a, c
    cp $09
    jr c, .loop
    ld a, $f0
    ld [hl], a
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $490
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    jr .set_arg5_to_04

.read_arg62:
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wChildRecord + MON_FAMILY
    ld a, [hl]
    and $0f
    ld [wWorkBuf], a
    ld a, $c9
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

BreedMenu_ChooseParents_UpdatePagedListCursor_Case1E::
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
    sub $09
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
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
    sub $06
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15::
    ld c, $03
    ld hl, $01fc
    ld de, $0030
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld a, $b7
    ld [wWindowTileBuffer + $93], a
    ld [wWindowTileBuffer + $a7], a
    call DrawGoldBoxAndStep_Bank15
    ld de, TileRect_15_74D5
    ld hl, wWindowTileBuffer + $bc
    ld bc, $0c01
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15_Data
    ld hl, wWindowTileBuffer + $120
    ld bc, $0c04
    call CopyRectTo20ByteRows_Bank15
    ld de, TileRect_15_4985
    ld hl, wWindowTileBuffer + $93
    ld bc, $0102
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 1 x 2 tiles, one row per line
TileRect_15_4985::
    db $b7 ; id 0
    db $b7 ; id 1

BreedMenu_ChooseParents_LoadTileListSixPerCall::
    ld a, $9d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    xor a
    ld [wTwoChoiceCursor], a
    ld [wChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_ClearTileAreas2700_1750_17D0::
    ld de, TileRect_15_75F5
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawListEntriesCell5RecordNamesAndStep
    ld de, TileRect_15_7589
    ld hl, wWindowTileBuffer + $10c
    ld bc, $0c05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call DrawListEntriesCell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $25
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

BreedMenu_ChooseParents_BlankWordTableTargets_Case25::
    ld c, $05
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $1e
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case26::
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
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp $0a
    jr nc, .check_party_count
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .clear_two_choice_cursor
    cp $01
    jr z, .call_set_arg5_to_list_entries_cell52
    ld a, [wSelectedRecord]
    ld b, a
    ld a, [wPartyList]
    cp b
    jr z, .call_set_arg5_to_list_entries_cell5
    ld a, [wPartyList + $1]
    cp b
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
    cp b
    jr z, .set_two_choice_cursor_to_02
    ld a, [wPartyList + $1]
    cp b
    jr z, .set_two_choice_cursor_to_02
    jr .clear_two_choice_cursor

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wScreenStep], a
    xor a
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
    cp b
    jr nz, .clear_two_choice_cursor
    jr .set_two_choice_cursor_to_02

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_TestBitInFieldAtArg3::
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp $ff
    jr nz, .set_species_id_lo
    jr .skip

.set_species_id_lo:
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a
    jr z, .set_arg1
    jr .skip

.set_arg1:
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld hl, BreedMenu_ChooseParents_ComputeBreedingChild_Data
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp $ff
    jr nz, .set_two_choice_cursor_to_01

.skip:
    ld de, wChildRecord + MON_SPECIES
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
    cp $f0
    jr z, .skip3
    ld [de], a
    inc de
    inc hl
    jr .skip2

.skip3:
    ld a, $a2
    ld [de], a
    inc de
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15
    ld a, [wDigits + $1]
    cp $e3
    jr z, .read_digits
    ld [de], a
    inc de

.read_digits:
    ld a, [wDigits + $2]
    ld [de], a
    inc de
    ld a, $f0
    ld [de], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_TestBitInFieldAtArg3_Case28::
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp $ff
    jr z, .clear_two_choice_cursor
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr .check_screen_step

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; if wLinkMode is set, copies and draws rectangle $70C5 at wWindowTileBuffer + $64; wScreenStep += 1
; (E-0122)
DrawRect70C5IfLinkModeAndStep::
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_step
    call CopyRect70C5ToWC364AndDraw

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_ShowSaveFileInfoWindow::
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_step
    call ShowSaveFileInfoWindow

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_DrawBottomBoxForLinkAndSetScreenSubStep::
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, [wScreenSubStep]
    cp $02
    jr z, .check_link_mode
    cp $03
    jr z, .check_text_flags
    call DrawBottomBoxForLinkAndSetScreenSubStep
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ret

.check_link_mode:
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_sub_step
    ld a, $0d
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_PrepareWCF8BCountersAndRequestScript::
    ld a, [wScreenSubStep]
    and a
    jr nz, .clear_screen_sub_step
    call PrepareWCF8BCountersAndRequestScript
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld a, [wLinkMode]
    and a
    jr z, .set_screen_step_to_2A
    ld de, TileRect_15_75F5
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawListEntriesCell5RecordNamesAndStep
    ld de, TileRect_15_7589
    ld hl, wWindowTileBuffer + $10c
    ld bc, $0c05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call DrawListEntriesCell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15

.set_screen_step_to_2A:
    ld a, $2a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D::
    ld a, [wLinkMode]
    and a
    jr z, .read_screen_step
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    call BreedMenu_ChooseParents_WaitLinkMode
    ret

.loop:
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    call BreedMenu_ChooseParents_WaitLinkMode

.read_screen_step:
    ld a, [wScreenStep]
    add $07
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

BreedMenu_ChooseParents_DrawRect70C5IfLinkModeAndStep::
    ld de, TileRect_15_761D
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    call DrawRect70C5IfLinkModeAndStep
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

BreedMenu_ChooseParents_LoadTileListSixPerCall_Case32::
    ld a, $9d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, SRAMBank1RecordAddress
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

BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15::
    ld c, $0d
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep::
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

BreedMenu_ChooseParents_StoreBAtWordTableEntry_Bank15::
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case3A::
    call DrawPair72A9And72C5AndStep
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_BGMapAddressAtScroll_Bank15_Case3B::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_TenTimesTemp0PlusTenToDigits::
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesTemp0PlusTenToDigits
    call BreedMenu_CopyDigitsToTextBuf
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_WriteScreenSubStepAndScreenStepEtc::
    ld a, [wScreenSubStep]
    and a
    jr z, .call_breed_menu_choose_parents_wait_link_mode3
    cp $01
    jr z, .call_breed_menu_choose_parents_wait_link_mode2
    cp $02
    jr z, .call_breed_menu_choose_parents_wait_link_mode
    ld a, [wTextFlags]
    and a
    jr z, .clear_screen_sub_step
    call BreedMenu_ChooseParents_WaitLinkMode
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_breed_menu_choose_parents_wait_link_mode:
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_sub_step
    ld a, $0e
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
    and a
    jr z, .clear_two_choice_cursor
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a
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
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    pop bc
    ld a, [wSelectedRecord]
    cp b
    jr c, .set_arg1
    dec a

.set_arg1:
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wSelectedRecord], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wChildRecord
    ld b, $a5

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
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
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    farcall SetSpeciesFlag
    call IncrementTwoCountersCappedAt99
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; removes record B from the party list wPartyList (wPartyCount -= 1), compacts the three entries and
; zeroes the unused ones (E-0127)
RemoveRecordBFromParty::
    ld hl, wPartyList
    ld c, $00

.loop:
    ld a, [hl]
    cp b
    jr nz, .check_party_count
    ld a, $ff
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    jr .skip

.check_party_count:
    inc hl
    inc c
    ld a, [wPartyCount]
    cp c
    jr nz, .loop

.skip:
    ld hl, wPartyList
    ld de, wPartyList
    ld c, $00

.loop2:
    ld a, [hl]
    cp $ff
    jr nz, .skip2
    jr .next

.skip2:
    ld [de], a
    inc de

.next:
    inc hl
    inc c
    ld a, c
    cp $03
    jr c, .loop2
    ld hl, wPartyList
    ld c, $00

.loop3:
    ld a, [hl]
    cp $ff
    jr z, .skip3
    cp b
    jr z, .skip3
    jr .next2

.skip3:
    xor a
    ld [hl], a

.next2:
    inc hl
    inc c
    ld a, c
    cp $03
    jr c, .loop3
    ret

BreedMenu_ChooseParents_UpdateTwoChoiceCursor_Bank1D_Case3F::
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesTemp0PlusTen
    xor a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp $ff
    jr nz, .clear_two_choice_cursor
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

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_SetScreenStep::
    xor a
    ld [wScreenStep], a
    ld a, $0a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_TenTimesTemp0PlusTen::
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesTemp0PlusTen
    xor a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    call SubtractArg1AmountFromGold
    ld hl, wListEntries2
    ld c, $00

.loop:
    xor a
    ld [hli], a
    inc c
    ld a, c
    cp $1e
    jr c, .loop
    farcall ListRecordsInUseWithByte6ESet
    xor a
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
    cp b
    jr z, .read_list_cursor
    inc c
    inc hl
    ld a, [wListCursor]
    inc a
    ld [wListCursor], a
    ld a, [wListCount]
    cp c
    jr nz, .loop2

.read_list_cursor:
    ld a, [wListCursor]
    srl a
    srl a
    ld [wListPageIndex], a
    ld a, [wListCursor]

.cp_04:
    cp $04
    jr c, .set_list_cursor
    sub $04
    jr .cp_04

.set_list_cursor:
    ld [wListCursor], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_EGG
    call SRAMRecordAddress
    xor a
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld [wScreenStep], a
    ld a, $08
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; BreedMenu screen state 5, by wScreenStep: the list of records with the egg flag set
; (ListRecordsInUseWithByte6ESet), species names, marks, the gold box and a two-choice confirmation
BreedMenu_ChooseEgg::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_ChooseEgg_ToBreedMenu_ChooseEgg_Case00_WriteArg1AndArg2Etc
    dw BreedMenu_ChooseEgg_ListRecordsInUseWithByte6ESet
    dw ClearTileRowsAndResetWindowAndStep
    dw BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03
    dw BreedMenu_ChooseEgg_DrawRecordListPageSpeciesNames
    dw BreedMenu_ChooseEgg_DrawRecordListPageMarks
    dw BreedMenu_ChooseEgg_UpdatePagedListCursor
    dw BreedMenu_ChooseEgg_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_ChooseEgg_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ChooseParents_BlankWordTableTargets
    dw BreedMenu_ChooseEgg_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_ChooseEgg_QueueSoundEffect
    dw BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_ChooseEgg_ClampRecordListPageCursor4
    dw BreedMenu_ChooseEgg_LoadTile4990AndRun6320
    dw BreedMenu_ChooseEgg_SetArg5ToListEntriesCell4
    dw BreedMenu_ChooseEgg_SetArg5ToListEntriesCell4_Case10

BreedMenu_ChooseEgg_ToBreedMenu_ChooseEgg_Case00_WriteArg1AndArg2Etc::
    call BreedMenu_ChooseEgg_Case00_WriteArg1AndArg2Etc
    ret

BreedMenu_ChooseEgg_ListRecordsInUseWithByte6ESet::
    ld de, TileRect_15_6FDB
    ld hl, wWindowTileBuffer + $bb
    ld bc, $0d09
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears four tile rows, sets the default window ($8800, $1202) and wScreenStep += 1 (E-0124)
ClearTileRowsAndResetWindowAndStep::
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0d01
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

BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03::
    ld de, TileRect_15_7050
    ld hl, wWindowTileBuffer + $bb
    ld bc, $0d09
    call CopyRectTo20ByteRows_Bank15
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .read_list_cursor
    ld de, $018e
    call DrawC5BEC6AtScrollOffsetDE_Bank15
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank15
    ld de, $018f
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
    ld b, $bb
    ld hl, BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wListCursor]
    ld b, $c3
    ld hl, BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseEgg_DrawRecordListPageSpeciesNames::
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseEgg_DrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseEgg_UpdatePagedListCursor::
    ld a, $02
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
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_PLUS
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTenToDigits
    call BreedMenu_CopyDigitsToTextBuf
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
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseEgg_CopyRectTo20ByteRows_Bank15::
    ld c, $09
    ld hl, $0223
    ld de, $0057
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld a, [wThreeOptionResult]
    or a
    jr z, .skip
    ld de, TileRect_15_7345
    ld hl, wWindowTileBuffer + $bb
    ld bc, $0403
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld de, TileRect_15_733F
    ld hl, wWindowTileBuffer + $ba
    ld bc, $0203
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseEgg_DrawGoldBoxAndStep_Bank15::
    ld a, [wScreenSubStep]
    and a
    jr nz, .set_arg1_to_9C
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.set_arg1_to_9C:
    ld a, $9c
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wArg3], a
    ld a, e
    ld [wArg4], a
    farcall LoadTileListSixPerCall
    ld a, [wArg5]
    cp $ff
    ret nz
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_BlankWordTableTargets::
    ld c, $03
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    call BlankWordTableTargets
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

BreedMenu_ChooseEgg_ToCopyGlyphTileListFromBank1F_Bank15AndStep::
    ld hl, TileCopyDestList_15_72E1
    ld de, TileCopySrcList_15_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseEgg_QueueSoundEffect::
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wChoiceCursorF0], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15::
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
    and a
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
    call BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap
    ld a, [wChoiceCursor]
    and a
    jp nz, .set_two_choice_cursor_to_01
    ld a, [wScreenState]
    cp $04
    jr z, .check_screen_step
    cp $05
    jr z, .set_screen_byte_b2_to_05
    jr .set_screen_byte_b2_to_07

.check_screen_step:
    ld a, [wScreenStep]
    cp $22
    jr c, .set_screen_byte_b2_to_04
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $23
    ld [wScreenByteB3], a
    ld a, $0c
    jr .set_screen_state

.set_screen_byte_b2_to_04:
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $0e
    ld [wScreenByteB3], a
    ld a, $0c
    jr .set_screen_state

.set_screen_byte_b2_to_05:
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $0c
    ld [wScreenByteB3], a
    ld a, $0d
    jr .set_screen_state

.set_screen_byte_b2_to_07:
    ld a, $07
    ld [wScreenByteB2], a
    ld a, $18
    ld [wScreenByteB3], a
    ld a, $0e
    jr .set_screen_state

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
; tile ($BB) or a blank ($C3) (E-0122)
BlinkCursorBlinkAE_Bank15::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, .skip
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp $10
    jr c, .skip
    cp $18
    jr c, DrawBlankTileC3_Bank15
    xor a
    ld [wCursorBlinkAE], a

.skip:
    ld b, $bb
    jr BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_Bank15::
    ld b, $c3
    jr BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor::
    ld a, [wChoiceCursor]
    add a
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

BreedMenu_ChooseParents_Case0E_StepBGMapAddressBackOnScrollWrap_Data::
    db $2d, $01, $6d, $01

BreedMenu_ChooseEgg_LoadTile4990AndRun6320::
    call LoadTile4990AndRun6320
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseEgg_SetArg5ToListEntriesCell4::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_PLUS
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTen
    xor a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp $ff
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $07
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseEgg_SetArg5ToListEntriesCell4_Case10::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $6e
    add_a_to_hl
    xor a
    ld [hl], a
    pop hl
    ld a, [hl]
    ld c, MON_PLUS
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTen
    xor a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    call SubtractArg1AmountFromGold
    ld hl, wListEntries2
    ld c, $00

.loop:
    xor a
    ld [hli], a
    inc c
    ld a, c
    cp $1e
    jr c, .loop
    xor a
    ld [wScreenStep], a
    ld a, $09
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs the name entry screen (RunNameEntryStateWhenNotFading) on the record selected in list cell 4,
; and removes a record with DeleteSRAMRecordAndCompact (E-0277)
BreedMenu_NameEntry::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    ld [wArg2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $1f
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
    xor a
    ld [rRAMG2], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wSelectedRecord]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld c, $0a
    ld de, wNameGlyphBuf

.loop:
    ld a, [de]
    cp $f0
    jr z, .read_selected_record
    ld [hli], a
    inc de
    dec c
    jr nz, .loop
    jr .read_selected_record2

.read_selected_record:
    ld a, $f0
    ld [hl], a

.read_selected_record2:
    ld a, [wSelectedRecord]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $a5

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG2], a
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld [wSelectedRecord], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wRecordBufA
    ld b, $a5

.loop3:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop3
    xor a
    ld [rRAMG2], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; reloads the map (LoadMapHeader), the player's position (RestorePlayerPositionState) and sprite
; graphics (E-0277)
BreedMenu_ReturnToMap::
    ld a, [wScreenStep]
    jumptable
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
    dw BreedMenu_ReturnToMap_CopySixteenTiles_Case0B
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
    dw BreedMenu_ChooseEgg_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_ChooseEgg_QueueSoundEffect
    dw BreedMenu_ChooseParents_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19
    dw BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Case1A
    dw BreedMenu_ReturnToMap_CopyRecordNameToNameGlyphBuf
    dw BreedMenu_ReturnToMap_SRAMRecordAddress_Case1C
    dw BreedMenu_ReturnToMap_LoadPlayerAndFollowerSpriteGraphics
    dw BreedMenu_ReturnToMap_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C_Case1F
    dw BreedMenu_ChooseParents_BlankWordTableTargets

BreedMenu_ReturnToMap_DecompressToVRAM::
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call RestorePlayerPositionState
    ret

; runs CopyGlyphTileListFromBank1F_Bank15 for TileCopyDestList_15_72A9 and TileCopySrcList_15_72C5,
; then wScreenStep += 1 (E-0122)
DrawPair72A9And72C5AndStep_570C::
    ld hl, TileCopyDestList_15_72A9
    ld de, TileCopySrcList_15_72C5
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_LoadMapHeader::
    ld a, $0d
    ldh [hMapId], a
    call LoadMapHeader
    call LoadMapScreen
    farcall LoadPlayerAndFollowerSpriteGraphics
    farcall LoadMapObjectsForScreen
    call RestorePlayerPositionState
    xor a
    ldh [hFieldDrawFlags], a
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_CopyBytesDEToHL_Bank15::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a
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
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01a0
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

BreedMenu_ReturnToMap_WriteScreenStepAndScriptCommandTypeEtc::
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $0a

.loop:
    ld a, [hl]
    cp $f0
    jr z, .check_screen_step
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .loop

.check_screen_step:
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E::
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call BreedMenu_ChooseParents_WaitLinkMode
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_15_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

BreedMenu_ChooseParents_WriteScreenStepAndTwoChoiceCursor::
    ld a, [wLinkMode]
    and a
    jr nz, BreedMenu_ChooseParents_CopyFromBankWaitVRAM_Case3E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

BreedMenu_ReturnToMap_UpdateTwoChoiceCursor_Bank1D::
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
    call BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld a, [wScreenStep]
    add $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $05
    call BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank15
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15

.call_bg_map_address_at_scroll_bank15:
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ret

BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15::
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
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15
    ret

BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15::
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
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15
    ret

BreedMenu_ReturnToMap_CopyFromBankWaitVRAM::
    ld de, Tiles1Plus2D0Tiles_1F_43C0
    ld hl, vTiles1 + $2d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_1F_42D0
    ld hl, vTiles1 + $2e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140b
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ReturnToMap_BlankWordTableTargets::
    ld c, $03
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    call BlankWordTableTargets
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

BreedMenu_ReturnToMap_SRAMRecordAddress::
    ld a, [wPartyCount]
    cp $03
    jr nc, .read_two_choice_cursor
    ld hl, wPartyList
    ld a, [wPartyCount]
    add_a_to_hl
    ld a, [wSelectedRecord]
    ld [hl], a
    ld a, [wPartyCount]
    inc a
    ld [wPartyCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    xor a
    ld [rRAMG2], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    call BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Shared01
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    ld b, $bc
    ld hl, BreedMenu_ReturnToMap_SRAMRecordAddress_Data
    call StoreBAtWordTableEntry_Bank15
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ReturnToMap_CopySixteenTiles_Case0B::
    ld de, TileRect_15_59E5
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call BreedMenu_ReturnToMap_CopySixteenTiles
    xor a
    ld [wListPageIndex], a
    ld [wListCursor], a
    ld [wCursorBlinkAE], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 9 tiles, one row per line
TileRect_15_59E5::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; copies 16 tiles by its source and destination tables
BreedMenu_ReturnToMap_CopySixteenTiles::
    ld c, $10

.loop:
    push bc
    ld a, c
    ld de, BreedMenu_ReturnToMap_CopySixteenTiles_Data_5A67
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
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a
    ld de, BreedMenu_ReturnToMap_CopySixteenTiles_Data_5A77
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
    dec c
    jr nz, .loop
    ret

BreedMenu_ReturnToMap_CopySixteenTiles_Data_5A67::
    db $a3, $50, $44, $11, $16, $19, $48, $24, $a6, $12, $31, $29, $32, $18, $14, $25

BreedMenu_ReturnToMap_CopySixteenTiles_Data_5A77::
    db $d0, $8e, $e0, $8e, $f0, $8e, $50, $8f, $60, $8f, $70, $8f, $d0, $8f, $e0, $8f
    db $f0, $8f, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

BreedMenu_ReturnToMap_FillTilesBxC_Case0C::
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $700
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
    ld de, TileRect_15_73C9
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_ClampRecordListPageCursor5::
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

BreedMenu_ReturnToMap_ToDrawRecordListPageNames::
    farcall DrawRecordListPageNames
    ret

BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $c7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, TileRect_15_7411
    ld hl, wWindowTileBuffer + $6c
    ld bc, $0c09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_FillTilesBxC::
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
    ld hl, wWindowTileBuffer + $78
    ld c, $28
    call BreedMenu_ReturnToMap_Case10_LoadSRAMRecordByte
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_Case11::
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

BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140b
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_UpdatePagedListCursor::
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
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $bc
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

BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case14::
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $09
    ld hl, $01cc
    ld de, $0000
    xor a
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

BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call DrawPair72A9And72C5AndStep_570C
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19::
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $05
    ld hl, $0278
    ld de, $00ac
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, TileRect_15_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19_Data
    ld hl, wWindowTileBuffer + $10c
    ld bc, $0c01
    call CopyRectTo20ByteRows_Bank15
    xor a
    ld b, $bc
    ld hl, BreedMenu_ReturnToMap_SRAMRecordAddress_Data
    call StoreBAtWordTableEntry_Bank15
    ld c, $04
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_Case1A::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $13
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ReturnToMap_CopyRecordNameToNameGlyphBuf::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    xor a
    ld [rRAMG2], a
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

.skip:
    ld a, [hl]
    cp $f0
    jr z, .check_screen_step
    ld [de], a
    inc hl
    inc de
    jr .skip

.check_screen_step:
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_ReturnToMap_SRAMRecordAddress_Case1C::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld c, MON_STATE
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a
    ld [rRAMG2], a
    ld a, [wListCursor]
    cp $03
    jr z, .check_screen_step
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, $ff
    ld [hl], a
    ld hl, wListEntries
    ld de, wPartyList
    ld c, $00

.loop:
    ld a, [hl]
    cp $ff
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
    cp $03
    jr c, .loop
    ld a, $0a
    ld [rRAMG2], a
    xor a
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
    cp $03
    jr c, .loop2
    xor a
    ld [rRAMG2], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ReturnToMap_DrawGoldBoxAndStep_Bank15::
    ld c, $0d
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call BreedMenu_CopyBytesDEToHL_Bank15
    ld de, Tiles1Plus2D0Tiles_1F_43C0
    ld hl, vTiles1 + $2d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_1F_42D0
    ld hl, vTiles1 + $2e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call DrawGoldBoxAndStep_Bank15
    ret

BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C_Case1F::
    call DrawPair72A9And72C5AndStep_570C
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; saves the script return position, dispatches talk event group $17 index 0, then sets wScreenState
; = 6 (BreedMenu_NameEntry) (E-0277)
BreedMenu_TalkEvent17ThenNameEntry::
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $17
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    ld a, $06
    ld [wScreenState], a
    xor a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ret

; copies word $0B and byte $6D of the record in list cell 4 to wChildRecord, saves the script
; return, dispatches talk event group $16, then sets wScreenState = 6 (E-0277)
BreedMenu_CopyToChildThenTalkEvent16::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    push hl
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wChildRecord + MON_SPECIES], a
    ldh a, [hTemp1]
    ld [wChildRecord + MON_SPECIES + 1], a
    pop hl
    ld a, [hl]
    ld c, MON_PLUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [wChildRecord + MON_PLUS], a
    xor a
    ld [rRAMG2], a
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $16
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    ld a, $06
    ld [wScreenState], a
    xor a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ret

; saves the script return position and dispatches talk event group $15 index 0 (E-0277)
BreedMenu_TalkEvent15::
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $15
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    ld hl, wScreenState
    inc [hl]
    ret

; BreedMenu screen state $0B: redraws the window, the map's graphics and palettes
; (SendSGBPaletteSetForSGBPaletteSet, StartPaletteFade), the gold box and the monster name
BreedMenu_RestoreScreen::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RestoreScreen_FillTileRectWithArg1Tile
    dw BreedMenu_ReturnToMap_DecompressToVRAM
    dw DrawPair72A9And72C5AndStep_570C
    dw BreedMenu_ReturnToMap_LoadMapHeader
    dw BreedMenu_ReturnToMap_CopyBytesDEToHL_Bank15
    dw BreedMenu_RestoreScreen_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_RestoreScreen_CopyMonsterNameToBuffer_B15
    dw BreedMenu_RestoreScreen_WriteScreenStepAndScreenSubStepEtc

BreedMenu_RestoreScreen_DrawGoldBoxAndStep_Bank15::
    call DrawGoldBoxAndStep_Bank15
    ld a, [wIsCGB]
    and a
    jr nz, .return
    farcall SendSGBPaletteSetForSGBPaletteSet
    ld a, $fc
    call StartPaletteFade

.return:
    ret

BreedMenu_RestoreScreen_FillTileRectWithArg1Tile::
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
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_RestoreScreen_CopyMonsterNameToBuffer_B15::
    ld a, [wFadeState]
    and a
    ret nz
    ld de, wChildRecord + MON_SPECIES
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
    cp $f0
    jr z, .check_screen_step
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp $10
    jr c, .loop

.check_screen_step:
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_RestoreScreen_WriteScreenStepAndScreenSubStepEtc::
    xor a
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

BreedMenu_SwapMonstersMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    ld a, [wScreenByteB3]
    cp $23
    jr nz, .clear_screen_step
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add $06
    ld [wScreenState], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add $05
    ld [wScreenState], a
    ret

BreedMenu_SwapMonstersMenu_Case0D::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

; BreedMenu screen state $0F: decompresses graphics, uploads the palette, loads glyph tiles and
; draws the record list page
BreedMenu_RedrawListScreen::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_DecompressToVRAM
    dw BreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_RedrawListScreen_ToClearTileRowsAndResetWindowAndStep
    dw BreedMenu_ChooseEgg_ClampRecordListPageCursor4
    dw BreedMenu_RedrawListScreen_DrawRecordListPageSpeciesNames
    dw LoadTile4990AndRun6320
    dw BreedMenu_RedrawListScreen_StoreBAtWordTableEntry_Bank15
    dw BreedMenu_RedrawListScreen_SetArg5ToListEntriesCell4
    dw BreedMenu_RedrawListScreen_LoadPlayerAndFollowerSpriteGraphics

BreedMenu_RedrawListScreen_DecompressToVRAM::
    ld hl, vTiles2
    ld de, Map0DTileset
    ld b, $47
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, BGPaletteBufferData_47_67E2
    ld b, $47
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F_Bank15::
    ld hl, TileCopyDestList_15_72E1
    ld de, TileCopySrcList_15_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    call DrawPair72A9And72C5AndStep
    ret

BreedMenu_RedrawListScreen_ToClearTileRowsAndResetWindowAndStep::
    call ClearTileRowsAndResetWindowAndStep
    ret

BreedMenu_ChooseEgg_ClampRecordListPageCursor4::
    ld de, TileRect_15_7050
    ld hl, wWindowTileBuffer + $bb
    ld bc, $0d09
    call CopyRectTo20ByteRows_Bank15
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
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

BreedMenu_RedrawListScreen_DrawRecordListPageSpeciesNames::
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies a tile from bank $1F to vTiles1 + $4E0, runs DrawRecordListPageMarks with wArg1 = wArg2 =
; 1, then wScreenStep += 1 (E-0122)
LoadTile4990AndRun6320::
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4e0
    ld b, $1f
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

BreedMenu_RedrawListScreen_StoreBAtWordTableEntry_Bank15::
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03_Data
    call StoreBAtWordTableEntry_Bank15
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_RedrawListScreen_SetArg5ToListEntriesCell4::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_PLUS
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    call TenTimesTemp0PlusTenToDigits
    call BreedMenu_CopyDigitsToTextBuf
    xor a
    ld [wStringCategory], a
    ld a, $1b
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

BreedMenu_RedrawListScreen_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01a0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    farcall RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; BreedMenu screen state $10: blanks the list marks (BlankWordTableTargets), fills tiles and resets
; the cursor
BreedMenu_ClearListMarks::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_DecompressToVRAM
    dw BreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_ClearListMarks_FillTilesBxC
    dw BreedMenu_ReturnToMap_ToDrawRecordListPageNames
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5
    dw BreedMenu_ReturnToMap_FillTilesBxC
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_Case11
    dw BreedMenu_ChooseParents_CopyFromBankWaitVRAM
    dw BreedMenu_ClearListMarks_BlankWordTableTargets
    dw BreedMenu_RedrawListScreen_LoadPlayerAndFollowerSpriteGraphics

BreedMenu_ClearListMarks_FillTilesBxC::
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $700
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_WriteScreenStep::
    ld a, [wLinkMode]
    and a
    jr nz, BreedMenu_ChooseParents_CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ChooseParents_CopyFromBankWaitVRAM::
    call BreedMenu_ChooseParents_WaitLinkMode
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles1 + $4f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles_1F_4370
    ld hl, vTiles1 + $5f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ClearListMarks_BlankWordTableTargets::
    ld c, $04
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $bc
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

; BreedMenu screen state $12: the selected record's sex bit, family icon, name and species
BreedMenu_ShowSelectedRecord::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_DecompressToVRAM
    dw BreedMenu_ShowSelectedRecord_LoadRecordSelectedRecordByte0EBit0
    dw DrawPair72A9And72C5AndStep
    dw BreedMenu_ShowSelectedRecord_FillTilesBxC
    dw BreedMenu_ShowSelectedRecord_ClearThreeTileRows
    dw BreedMenu_ChooseEgg_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_ShowSelectedRecord_ToDrawRecordListPageNames
    dw BreedMenu_ShowSelectedRecord_DrawRecordNameAndSpeciesNameTiles
    dw BreedMenu_ChooseParents_ComputeBreedingChild
    dw BreedMenu_ShowSelectedRecord_LoadFamilyIconTileForRecordB_Bank15
    dw BreedMenu_RedrawListScreen_LoadPlayerAndFollowerSpriteGraphics

BreedMenu_ShowSelectedRecord_DrawRecordNameAndSpeciesNameTiles::
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

BreedMenu_ShowSelectedRecord_LoadFamilyIconTileForRecordB_Bank15::
    ld a, $c7
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
    ld a, $ff
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    pop af
    call CopyRect7351ToWC410AndIncScreenStep
    ret

BreedMenu_ShowSelectedRecord_LoadRecordSelectedRecordByte0EBit0::
    call LoadRecordSelectedRecordByte0EBit0
    call BreedMenu_WriteListCountAndRAMG2Etc
    jp BreedMenu_ListMonsters_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5

BreedMenu_ShowSelectedRecord_ClearThreeTileRows::
    call ClearThreeTileRows
    call DrawListEntriesCell5RecordNamesAndStep
    ret

; BreedMenu screen state $11: the list of records that are not eggs
; (ListRecordsInUseWithByte6EClear) with page-of-pages
BreedMenu_ListMonsters::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_DecompressToVRAM
    dw BreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_ListMonsters_ListRecordsInUseWithByte6EClear
    dw BreedMenu_ShowSelectedRecord_FillTilesBxC
    dw BreedMenu_ShowSelectedRecord_ToDrawRecordListPageNames
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5
    dw BreedMenu_ChooseParents_FillTilesBxC
    dw BreedMenu_ChooseParents_SetArg5ToListEntriesCell5_Case06
    dw CopyRect7351ToWC410AndIncScreenStep
    dw BreedMenu_RedrawListScreen_LoadPlayerAndFollowerSpriteGraphics

BreedMenu_ListMonsters_ListRecordsInUseWithByte6EClear::
    farcall ListRecordsInUseWithByte6EClear

BreedMenu_ListMonsters_ListRecordsInUseWithByte6EClear_CallClampRecordListPageCursor5::
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .call_blank_word_table_targets
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $12f
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
    ld b, $bc
    ld hl, BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data
    call StoreBAtWordTableEntry_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ShowSelectedRecord_FillTilesBxC::
    ld hl, vTiles1 + $240
    ld bc, $0c01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0d01
    call FillTilesBxC
    ld hl, vTiles1 + $4e0
    ld bc, $1101
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

BreedMenu_ShowSelectedRecord_ToDrawRecordListPageNames::
    farcall DrawRecordListPageNames
    ret

; copies the 8 x 5 rectangle TileRect_15_7351 into wWindowTileBuffer + $110
; (CopyRectTo20ByteRows_Bank15), then wScreenStep += 1 (E-0119)
CopyRect7351ToWC410AndIncScreenStep::
    ld de, TileRect_15_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; for each entry from wGlyphListStart of the destination list at HL and the source list at DE copies
; a 16-byte tile from bank $1F, until $FF; then clears wGlyphListPos/5 (E-0125)
CopyGlyphTileListFromBank1F_Bank15::
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
    ld e, l
    pop hl
    ld b, $1f
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
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DecompressGraphicsArg1ToArg4 with graphics number $00A4 and destination $8000 (vTiles0) (E-0117)
DecompressGraphicsA4ToTiles0::
    ld a, $a4
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ret

BreedMenu_ChooseParents_WaitLinkMode::
    ld a, [wLinkMode]
    and a
    ret z
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedPlayerName
    ld de, $022b
    add hl, de
    ld a, [hl]
    and a
    jr nz, .check_screen_state

.loop:
    xor a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $04
    jr nz, .loop
    ld a, [wScreenStep]
    cp $37
    jr nc, .loop

; with SRAM disabled draws sprite part $0090 at ($88, $28)
; (DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc, C = 1) (E-0124)
DrawSpritePart9000At88_28::
    xor a
    ld [rRAMB], a
    ld [rRAMG2], a
    ld a, $90
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld [wArg3], a
    ld a, $88
    ld [wArg4], a
    ld a, $28
    ld [wArg5], a
    xor a
    ld [wArg6], a
    ld c, $01
    farcall DrawSpritePart9000At88_28_WriteSpriteAttrXorAndSpriteSubIndexEtc
    ret

; outside link battles only sets wScreenSubStep = 2; otherwise copies the row TileRect_15_727D when
; wScreenSubStep is set, sets wScreenSubStep = 2 and draws the box at scroll + $1CC (E-0124)
DrawBottomBoxForLinkAndSetScreenSubStep::
    ld a, [wLinkMode]
    and a
    jr nz, .check_screen_sub_step
    ld a, $02
    ld [wScreenSubStep], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a
    jr nz, .skip
    jr .set_screen_sub_step_to_02

.skip:
    ld de, TileRect_15_727D
    ld hl, wWindowTileBuffer + $c8
    ld bc, $1401
    call CopyRectTo20ByteRows_Bank15

.set_screen_sub_step_to_02:
    ld a, $02
    ld [wScreenSubStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ret

; copies the 20 x 11 rectangle TileRect_15_70C5 into wWindowTileBuffer + $64, then
; DrawScreenBufferRect_Bank15 (20 x 13 at the scroll origin) (E-0119)
CopyRect70C5ToWC364AndDraw::
    ld de, TileRect_15_70C5
    ld hl, wWindowTileBuffer + $64
    ld bc, $140b
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ret

; up/down moves wGridCursorX over three options with sound $69; A chooses (option 2 cancels), sets
; wTwoChoiceCursor and requests script $80; B cancels (E-0129)
HandleThreeOptionMenuInput_15::
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
    and a
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
    xor a
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
    cp $02
    jr c, .skip
    xor a
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
    cp $02
    jr z, .set_two_choice_cursor_to_02
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

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a
    ld [wThreeOptionResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wGridCursorY through 0-$17 and draws the cursor
; tile ($BB) or a blank ($C3) (E-0122)
BlinkCursorGridCursorY_Bank15::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, .skip
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, .skip
    cp $18
    jr c, DrawBlankTileC3_6542
    xor a
    ld [wGridCursorY], a

.skip:
    ld b, $bb
    jr DrawArrowTileBCAtGridCursorXEntry_Bank15_ReadGridCursorX

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_6542::
    ld b, $c3
    jr DrawArrowTileBCAtGridCursorXEntry_Bank15_ReadGridCursorX

; B = $BC, then writes B at the scroll position +
; DrawArrowTileBCAtGridCursorXEntry_Bank15_Data[wGridCursorX] (E-0124)
DrawArrowTileBCAtGridCursorXEntry_Bank15::
    ld b, $bc

DrawArrowTileBCAtGridCursorXEntry_Bank15_ReadGridCursorX::
    ld a, [wGridCursorX]
    add a
    ld hl, DrawArrowTileBCAtGridCursorXEntry_Bank15_Data
    add_a_to_hl
    ld a, [hli]
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

DrawArrowTileBCAtGridCursorXEntry_Bank15_Data::
    db $21, $00, $61, $00, $a1, $00

BreedMenu_ReturnToMap_Case10_LoadSRAMRecordByte::
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
    ld [rRAMB], a
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

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks)
CopyRectTo20ByteRows_Bank15::
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
; kept. wTextCursorLo/wTextCursorHi unchanged when wStringIndex is $10-$12; otherwise HL + $1C1,
; replaced by $99C1 when that is $9B61 (E-0062)
DrawScreenBufferRect_Bank15::
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
    cp $10
    jr z, .restore
    cp $11
    jr z, .restore
    cp $12
    jr z, .restore
    ld a, l
    add $c1
    ld [wTextCursorLo], a
    ld a, h
    adc $01
    ld [wTextCursorHi], a
    ld a, [wTextCursorHi]
    cp $9b
    jr nz, .restore
    ld a, [wTextCursorLo]
    cp $61
    jr nz, .restore
    ld a, $c1
    ld [wTextCursorLo], a
    ld a, $99
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
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank15::
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

; wArg1 = hTemp3, then the high and low digits of hTemp2, hTemp1 and hTemp0 go to wArg2-wArg7 (seven
; digits of a packed-BCD number, most significant first); the loop that follows (C = 6) is not read
; (E-0106)
UnpackBCDToDigitsArg1::
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank15::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank15
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks)
CopyLow3BitsToWRAMBank2_Bank15::
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks)
StoreBAtWordTableEntry_Bank15::
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

BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc::
    ld hl, BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc_Data
    ld a, $9d
    jr BreedMenu_ChooseEgg_Case00_WriteArg1AndArg2Etc_SetArg1

BreedMenu_ChooseEgg_Case00_WriteArg1AndArg2Etc::
    ld hl, BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc_Data
    ld a, $9c

BreedMenu_ChooseEgg_Case00_WriteArg1AndArg2Etc_SetArg1::
    ld [wArg1], a
    xor a
    ld [wArg2], a
    xor a
    ld [wGlyphListPos], a

.loop:
    push hl
    ld a, [wGlyphListStart]
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jp z, .restore
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld a, [wGlyphListStart]
    swap a
    ld h, a
    and $f0
    ld l, a
    ld a, h
    and $0f
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
    cp $06
    jr c, .loop
    ret

.restore:
    pop de
    pop hl
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wScreenStep
    inc [hl]
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (E-0121)
DrawC5BEC6AtScrollOffsetDE_Bank15::
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $c5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $be
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $c6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks)
StoreC5BEC6AtHLStride2_Bank15::
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

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
CopyTileBytesToVRAM_Bank15::
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

BreedMenu_CopyBytesDEToHL_Bank15::
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
    call CopyLow3BitsToWRAMBank2_Bank15
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
    jr nz, BreedMenu_CopyBytesDEToHL_Bank15
    ret

; HL = table of addresses, C = count: stores tile $C3 at the address in each of the first C entries
; (StoreBAtWordTableEntry_Bank15) (E-0074)
BlankWordTableTargets::
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $c3
    push hl
    call StoreBAtWordTableEntry_Bank15
    pop hl
    pop bc
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; TenTimesTemp0PlusTen, then converts it to packed BCD (Number24ToPackedBCD) and unpacks the digits
; to wArg1 onward (E-0117)
TenTimesTemp0PlusTenToDigits::
    call TenTimesTemp0PlusTen
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsArg1
    ret

; HL = 10 * hTemp0 + 10 (E-0117)
TenTimesTemp0PlusTen::
    ldh a, [hTemp0]
    ld c, $0a
    ld hl, $0000
    call Multiply8
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; copies the four bytes at wArg4, skipping $E3 (a blank digit), to wTextBuf0 and ends it with $F0
BreedMenu_CopyDigitsToTextBuf::
    ld hl, wArg4
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp $e3
    jr z, .next
    ld [de], a
    inc de

.next:
    inc hl
    inc c
    ld a, c
    cp $04
    jr c, .loop
    ld a, $f0
    ld [de], a
    ret

; wGold -= the 24-bit amount wArg3:wArg2:wArg1 (no floor; callers check first, for example with
; IsAmountInArg1AboveGold) (E-0106) (C2 from E-0327: buying a Herb at 10G turns 99,999 into 99,989)
SubtractArg1AmountFromGold::
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
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    ld a, d
    sbc e
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

; wWorkBuf = field $0D of SRAM record B & $0F (its family), wWorkBuf + $1 = wArg1, then
; LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForRecordB_Bank15::
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
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a
    ld [rRAMG2], a
    ret

; record wArg1 (bank 0): writes tile $CC + (field $0E & 1) at the address in wArg2/3 and, three
; tiles on, field $56 as two digits with leading blanks (E-0121)
DrawRecordField0EMarkAndField56Digits::
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld l, a
    ld a, [wArg3]
    ld h, a
    push bc
    push hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_SEX
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    add $cc
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
    add $e0
    pop hl
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    pop bc
    ret

; when wDigits is 0 it becomes $E3, and then when wDigits + $1 is 0 too it becomes $E3: a digit byte
; of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros
; are blanked (E-0093) (the same 23 bytes appear in 2 banks)
BlankLeadingZeroDigits_F_Bank15::
    ld a, [wDigits]
    and a
    jr nz, .return
    add $e3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a
    jr nz, .return
    add $e3
    ld [wDigits + $1], a

.return:
    ret

; TestBitInFieldAtArg3, then ORs its mask into the byte, setting bit wArg1/wArg2 of the field at
; wArg3/wArg4 (E-0114)
SetBitInFieldAtArg3::
    call TestBitInFieldAtArg3
    ld a, [hl]
    or b
    ld [hl], a
    ret

; index = the word wArg1/wArg2, field = the address in wArg3/wArg4: wArg5 = $FF when bit index of
; the field is set (bit order $80 first within each byte), else 0 (E-0074)
TestBitInFieldAtArg3::
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
    and $07
    ld hl, TestBitInFieldAtArg3_Data
    add_a_to_hl
    ld a, [hl]
    ld b, a
    pop hl
    ld a, [hl]
    and b
    jr nz, .set_arg5_to_FF
    xor a
    ld [wArg5], a
    ret

.set_arg5_to_FF:
    ld a, $ff
    ld [wArg5], a
    ret

TestBitInFieldAtArg3_Data::
    db $80, $40, $20, $10, $08, $04, $02, $01

BreedMenu_WriteListCountAndRAMG2Etc::
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wListEntries2
    ld b, $1e

.loop2:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop3:
    ld a, [de]
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip
    jr .skip4

.skip:
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a
    jr nz, .check_records_flagged
    pop de
    push de
    ld a, $0e
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    and $01
    push hl
    ld hl, wArg1
    cp [hl]
    jr nz, .restore
    pop hl
    pop de
    jr .skip4

.restore:
    pop hl
    pop de
    inc c
    ld a, b
    ld [hli], a
    jr .skip4

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip4:
    ld a, $a5
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp $1e
    jr c, .loop3
    ld a, c
    ld [wListCount], a
    xor a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; with SRAM bank 0 enabled: wArg1 = bit 0 of byte $0E of record wSelectedRecord (LoadSRAMRecordByte)
; (E-0119)
LoadRecordSelectedRecordByte0EBit0::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    ld [wArg1], a
    xor a
    ld [rRAMG2], a
    ret

; clears 4 tiles at vTiles2 + $7C0, 3 at vTiles1 + $400 and 2 at vTiles1 + $4A0 (FillTilesBxC);
; falls through (E-0122)
ClearThreeTileRows::
    ld hl, vTiles2 + $7c0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $4a0
    ld bc, $0201
    call FillTilesBxC

; clears tile areas with FillTilesBxC: 9 x 1 at vTiles2 + $700, 3 x 1 at vTiles1 + $750, 2 x 1 at
; vTiles1 + $7D0 (E-0117)
ClearTileAreas2700_1750_17D0::
    ld hl, vTiles2 + $700
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $7d0
    ld bc, $0201
    call FillTilesBxC
    ret

; clears tile areas: 12 x 1 at vTiles1 + $240, 13 x 1 at vTiles1 + $700, 17 x 1 at vTiles1 + $4E0
; (E-0117)
ClearTileAreas1240_1700_14E0::
    ld hl, vTiles1 + $240
    ld bc, $0c01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0d01
    call FillTilesBxC
    ld hl, vTiles1 + $4e0
    ld bc, $1101
    call FillTilesBxC
    ret

; record wArg1: draws its name (field 1) as text line 2 and the name of its species (field $0B) as
; line 3 (DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D) (E-0121)
DrawRecordNameAndSpeciesName::
    ld a, [wArg1]
    ld b, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    xor a
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
    xor a
    ld c, a
    ld a, $03
    ld [wArg5], a
    farcall DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    xor a
    ld [rRAMG2], a
    ret

BreedMenu_SetArg5ToListEntriesCell5::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wSelectedRecord]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $a5

.loop:
    ld a, [hli]
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
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufB
    ld b, $a5

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG2], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via
; wDataBank) to wNameGlyphBuf; wDataBank is restored
CopyMonsterNameToBuffer_B15::
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

; clears the text tiles and, when the save is valid, shows the save details (player name, play time,
; party) from SRAM in the window (E-0131)
ShowSaveFileInfoWindow::
    ld hl, vTiles1 + $240
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0d01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    farcall CheckSaveData
    ldh a, [hTemp0]
    or a
    jr z, .skip
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $8d
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $0f
    xor a
    ld [wStringCategory], a
    ld a, $28
    ld [wStringIndex], a ; 'Unused.'
    farcall ShowString_Bank1B_4C94
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, $01
    ld [wScreenSubStep], a
    ret

.skip:
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld de, TileRect_15_71A1
    ld hl, wWindowTileBuffer + $64
    ld bc, $140b
    call CopyRectTo20ByteRows_Bank15
    ld hl, sSavedPlayerName
    ld de, $022b
    add hl, de
    ld a, [hl]
    and a
    jr z, .skip2
    ld hl, Tiles_15_763B
    ld de, vTiles2 + $6f0
    call CopyTileBytesToVRAM_Bank15
    ld a, $6f
    ld hl, wWindowTileBuffer + $b0
    ld [hli], a
    ld [hl], a
    ld hl, wWindowTileBuffer + $c4
    ld [hli], a
    ld [hl], a

.skip2:
    ld hl, sSavedPlayerName
    ld de, wNameGlyphBuf
    ld c, $0a

.loop:
    ld a, [hl]
    cp $f0
    jr z, .skip3
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .loop

.skip3:
    ld a, $f0
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
    ld a, $f0
    ld [wNameGlyphBuf + $4], a
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $28
    ld [wNameGlyphBuf], a
    ld a, $35
    ld [wNameGlyphBuf + $1], a
    ld a, $f0
    ld [wNameGlyphBuf + $2], a
    ld de, vTiles2 + $780
    call CopyGlyphTilesToVRAM
    ld hl, sSavedPlayerName
    ld a, $f1
    add_a_to_hl
    ld b, [hl]
    ld hl, sSavedPlayerName
    ld a, $f2
    add_a_to_hl
    ld c, $00
    xor a
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
    add a
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
    cp b
    jr c, .loop2
    ld c, $00

.loop3:
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and $0f
    ld [wWorkBuf], a
    xor a
    ld [rRAMG2], a
    pop bc
    push bc
    ld a, c
    add $c7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc
    pop hl
    inc c
    ld a, c
    cp b
    jr c, .loop3
    ld c, $00

.loop4:
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, $62
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and $7f
    ld l, a
    ld h, $00
    xor a
    ld [rRAMG2], a
    call HLToDecimalDigits
    pop bc
    push bc
    ld a, c
    add a
    ld hl, ShowSaveFileInfoWindow_Data_6E08
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wDigits + $1]
    and a
    jr z, .call_wait_for_vram_access
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hl], a
    ei
    inc hl

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp b
    jr c, .loop4
    ld c, $00

.loop5:
    push hl
    push bc
    ld hl, ShowSaveFileInfoWindow_Data_6DD0
    ld a, c
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    di
    call WaitForVRAMAccess
    ld a, $ea
    ld [de], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, $ed
    ld [de], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp b
    jr c, .loop5
    ld hl, sSavedPlayerName
    ld de, $0221
    add hl, de
    push hl
    inc hl
    inc hl
    inc hl
    ld a, $0a
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
    xor a
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
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    add $0a
    cp $0d
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
    ld a, [hli]
    inc a
    push hl
    call CopyKeyNameWordToDE
    pop hl
    dec de
    ld a, [hl]
    add $11
    call CopyKeyNameWordToDE
    dec de
    ld a, $f0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $8f
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $0d
    farcall ShowString_Bank08
    jr .skip4

.set_string_index_to_0D:
    ld a, $0d

.set_string_index:
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $8f
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $0d
    farcall ShowString_Bank08

.skip4:
    xor a
    ld [rRAMB], a
    ld [rRAMG2], a
    call DecompressGraphicsA4ToTiles0
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wScreenSubStep], a
    ret

ShowSaveFileInfoWindow_Data_6DD0::
    db $a8, $c3, $d0, $c3, $f8, $c3

; writes the digits at DE as tiles $E0 + digit to HL (WaitForVRAMAccess, interrupts off), counting C
; up to B (E-0117)
WriteDigitTilesFromDEToVRAM::
    di
    call WaitForVRAMAccess
    ld a, [de]
    add $e0
    ld [hli], a
    ei
    inc de
    inc c
    ld a, c
    cp b
    jr c, WriteDigitTilesFromDEToVRAM
    ret

; with SRAM bank 1 selected, HL = sBank1Records + $6F * [HL + C] (a $6F-byte record in bank 1); then
; selects bank 0 and disables SRAM (E-0117)
SRAMBank1RecordAddress::
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, $6f
    call Multiply8
    ld de, sBank1Records
    add hl, de
    xor a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

ShowSaveFileInfoWindow_Data_6E08::
    db $aa, $c3, $d2, $c3, $fa, $c3

ShowSaveFileInfoWindow_Data_6E0E::
    db $00, $8d, $50, $8d, $a0, $8d

; restores the player position, facing, wFollowerRecords, wFollowerRecords + $1-wFollowerRecords +
; $C and wSpriteSlots + $7 from wSavedPlayerState-wSavedPlayerState + $C and clears
; wSavedPositionValid (E-0121)
RestorePlayerPositionState::
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
    ld a, [wSavedPlayerState + $a]
    ld [wFollowerRecords + $a], a
    ld a, [wSavedPlayerState + $b]
    ld [wFollowerRecords + $b], a
    ld a, [wSavedPlayerState + $c]
    ld [wFollowerRecords + $c], a
    ld a, [wSavedPlayerState]
    ld [wSpriteSlots + $7], a
    xor a
    ld [wSavedPositionValid], a
    ret

; for each of the pointers wCounterPtr0Lo and wCounterPtr1Lo (when set): increments the byte it
; points to, up to 99, and stores wCounterArg0 / wCounterArg1 in the byte before (E-0125)
IncrementTwoCountersCappedAt99::
    ld a, [wCounterPtr0Hi]
    cp $ff
    jr z, .check_counter_ptr1_hi
    ld b, a
    ld a, [wCounterPtr0Lo]
    or b
    and a
    jr z, .check_counter_ptr1_hi
    ld de, wCounterPtr0Lo
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp $63
    jr nc, .check_counter_ptr1_hi
    inc a
    ld [hld], a
    ld a, [wCounterArg0]
    ld [hl], a

.check_counter_ptr1_hi:
    ld a, [wCounterPtr1Hi]
    cp $ff
    ret z
    ld b, a
    ld a, [wCounterPtr1Lo]
    or b
    ret z
    ld de, wCounterPtr1Lo
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp $63
    ret nc
    inc a
    ld [hld], a
    ld a, [wCounterArg1]
    ld [hl], a
    ret

; clears wCounterPtr0Lo-wCounterArg1, fills them through
; PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1 for wRecordBufA + $A4 and (outside link
; battles) wRecordBufB + $A4, wTwoChoiceCursor = wArg1, wScreenSubStep += 1 and requests script $80
; (E-0125)
PrepareWCF8BCountersAndRequestScript::
    xor a
    ld [wCounterPtr0Lo], a
    ld [wCounterPtr0Hi], a
    ld [wCounterArg0], a
    ld [wCounterPtr1Lo], a
    ld [wCounterPtr1Hi], a
    ld [wCounterArg1], a
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    xor a
    ld [wArg1], a
    ld de, wCounterPtr0Lo
    ld a, [wRecordBufA + MON_ITEM]
    and a
    call nz, PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1
    ld a, [wLinkMode]
    and a
    jr nz, .skip
    ld de, wCounterPtr1Lo
    ld a, [wRecordBufB + MON_ITEM]
    and a
    call nz, PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1

.skip:
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, [wArg1]
    ld [wTwoChoiceCursor], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1::
    add $3f
    ldh [hTemp0], a
    ld c, a
    ld hl, wItemStorage
    ld b, $64

.loop:
    ld a, [hli]
    cp c
    jr z, .skip
    and a
    jr z, .skip2

.next:
    inc hl
    dec b
    jr nz, .loop
    jr .skip3

.skip:
    ld a, [hl]
    cp $63
    jr c, .read_temp02
    jr .skip3

.skip2:
    push hl
    ld hl, wCounterPtr0Lo
    ld a, l
    cp e
    jr nz, .read_counter_arg0
    ld a, h
    cp d
    jr nz, .read_counter_arg0
    pop hl
    jr .read_temp02

.read_counter_arg0:
    ld a, [wCounterArg0]
    ld l, a
    ldh a, [hTemp0]
    cp l
    jr z, .read_temp0
    pop hl
    push hl
    ld a, [wCounterPtr0Lo]
    cp l
    jr nz, .read_temp0
    ld a, [wCounterPtr0Hi]
    cp h
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
    ld a, $ff
    ld [de], a
    inc de
    ld [de], a
    ld a, [wArg1]
    and a
    ret nz
    xor a
    ld [wArg1], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
TileRect_15_6F6B::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a4, $a5, $ee, $ee, $a6, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a7, $a8, $a9, $aa, $ab, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $ac, $ad, $ae, $a9, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

TileRect_15_6FA3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 13 x 9 tiles, one row per line
TileRect_15_6FDB::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

TileRect_15_7050::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d9, $da, $db, $dc, $dd, $de, $f9, $fa, $fb, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c0, $c1, $c2, $c7, $c8, $c9, $ca, $cb, $fc, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 20 x 11 tiles, one row per line
TileRect_15_70C5::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

TileRect_15_71A1::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $a4, $a5, $a6, $a7, $78, $79, $ed, $a8, $a9, $aa, $ab, $ac, $c3, $c3, $c3, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $d0, $d1, $d2, $d3, $d4, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c8, $d5, $d6, $d7, $d8, $d9, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c9, $da, $db, $dc, $dd, $de, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $c3, $c3, $c3, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

; record: 20 x 1 tiles, one row per line
TileRect_15_727D::
    db $b6, $c3, $c3, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $d9, $da, $db, $dc, $dd, $de, $b7 ; id 0

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 3 tiles, one row per line
TileRect_15_7291::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
TileCopyDestList_15_72A9::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0 ; entry 0
    dw vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $6e0, vTiles1 + $6f0, rIE

; record: bank-$1F tile sources
TileCopySrcList_15_72C5::
    dw $40c0, $4360, $4280, $4120, $4250, $4380, $4270, $42c0 ; entry 0
    dw $40f0, $43c0, $42d0, $4290, $4910, $ffff

TileCopyDestList_15_72E1::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

TileCopySrcList_15_72F1::
    dw $4130, $4320, $42a0, $4330, $4190, $4150, $ffff ; entry 0

TileCopySrcList_15_72FF::
    dw $4130, $4180, $4100, $4190, $41e0, $40f0, $41d0, $4150 ; entry 0
    dw $4160, $41a0, $40b0, $4910, $4910, $ffff

BreedMenu_ChooseParents_Case13_WriteArg1AndArg2Etc_Data::
    db $00, $8c, $10, $8c, $20, $8c, $70, $8c, $80, $8c, $90, $8c, $a0, $8c, $b0, $8c
    db $ff, $ff

BreedMenu_ChooseParents_DrawPair72A9And72C5AndStep_Case0A_Data::
    db $79, $c3, $a1, $c3, $c9, $c3

BreedMenu_ChooseEgg_ClampRecordListPageCursor4_Case03_Data::
    db $d0, $c3, $f8, $c3, $20, $c4, $48, $c4

BreedMenu_ReturnToMap_SRAMRecordAddress_Data::
    db $27, $c4, $4f, $c4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 2 x 3 tiles, one row per line
TileRect_15_733F::
    db $c3, $b7 ; id 0
    db $c3, $b7 ; id 1
    db $b4, $b5 ; id 2

; record: 4 x 3 tiles, one row per line
TileRect_15_7345::
    db $c3, $c3, $c3, $b7 ; id 0
    db $c3, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b5 ; id 2

; record: 8 x 5 tiles, one row per line
TileRect_15_7351::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $70, $71, $72, $73, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $74, $75, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

TileRect_15_7379::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

BreedMenu_ChooseParents_DrawScreenBufferAtScrollAndIncScreenStep_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; record: 6 x 5 tiles, one row per line
TileRect_15_73AB::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $77, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 9 tiles, one row per line
TileRect_15_73C9::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 12 x 9 tiles, one row per line
TileRect_15_7411::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 7
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_Case19_Data::
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 8 x 11 tiles, one row per line
TileRect_15_747D::
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

TileRect_15_74D5::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
BreedMenu_ChooseParents_ToCopyRectTo20ByteRows_Bank15AndStep_Data::
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 4
BreedMenu_ChooseParents_DrawGoldBoxAndStep_Bank15_Data::
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 12 x 3 tiles, one row per line
TileRect_15_7541::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
TileRect_15_7565::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c9, $7c, $7d, $7e, $7f, $c0, $c1, $c2, $ca, $cb, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2

; record: 12 x 5 tiles, one row per line
TileRect_15_7589::
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 0
    db $b6, $f5, $f6, $f7, $fd, $fe, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $ff, $77, $78, $70, $71, $72, $73, $74, $75, $76, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

BreedMenu_ChooseParents_ComputeBreedingChild_Data::
    db $ff, $ff, $dc, $00, $0f, $ff, $ff, $f1, $01, $ff, $ff, $3f, $36, $3f, $ff, $e2
    db $88, $07, $ff, $ff, $c3, $00, $ff, $ff, $fc, $40, $1f, $ff, $fe, $f8, $83, $ff
    db $fe, $63, $00, $7f, $fb, $f9, $f9, $0f, $ff, $ff, $c4, $30, $00, $00, $00, $00

; record: 8 x 5 tiles, one row per line
TileRect_15_75F5::
    db $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
TileRect_15_761D::
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 2
    db $72, $73, $74, $75, $76, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; HL = $763B and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_15_763B::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_15_764B::
    script_command SCRIPT_BREED
Script_15_764C::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_765A, Script_15_7657, Script_15_7651
Script_15_7651::
    script_command SCRIPT_BREED_CLOSE
    script_message $8020 ; '*: Become a great master!'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_15_7657::
    script_jump Script_15_7724
Script_15_765A::
    script_message $c002 ; '*: Which will be the base'
Script_15_765D::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7668, Script_15_7661
Script_15_7661::
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_7668::
    script_message $c003 ; '*: This is the one you'
    script_command SCRIPT_BREED
Script_15_766C::
    script_choice_jump Script_15_7677, Script_15_767B, Script_15_7670
Script_15_7670::
    script_message $c002 ; '*: Which will be the base'
    script_command SCRIPT_BREED
    script_jump Script_15_765D
Script_15_7677::
    script_command SCRIPT_BREED
    script_jump Script_15_766C
Script_15_767B::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7697, Script_15_7691, Script_15_768B, Script_15_7681
Script_15_7681::
    script_message $c008 ; '*: There's no potential mate.'
Script_15_7684::
    script_message $c002 ; '*: Which will be the base'
    script_command SCRIPT_BREED
    script_jump Script_15_765D
Script_15_768B::
    script_message $c006 ; '*: That's too low in level'
    script_jump Script_15_7684
Script_15_7691::
    script_message $c005 ; '*: You won't have a monster'
    script_jump Script_15_7684
Script_15_7697::
    script_message $c007 ; '*: And what will its mate'
Script_15_769A::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76A5, Script_15_769E
Script_15_769E::
    script_message $c002 ; '*: Which will be the base'
    script_command SCRIPT_BREED
    script_jump Script_15_765D
Script_15_76A5::
    script_message $c003 ; '*: This is the one you'
Script_15_76A8::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76B5, Script_15_76B9, Script_15_76AD
Script_15_76AD::
    script_command SCRIPT_BREED
    script_message $c007 ; '*: And what will its mate'
    script_command SCRIPT_BREED
    script_jump Script_15_769A
Script_15_76B5::
    script_command SCRIPT_BREED
    script_jump Script_15_76A8
Script_15_76B9::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76CB, Script_15_76C5, Script_15_76C5, Script_15_76BF
Script_15_76BF::
    script_message $c006 ; '*: That's too low in level'
    script_jump Script_15_76AD
Script_15_76C5::
    script_message $c005 ; '*: You won't have a monster'
    script_jump Script_15_76AD
Script_15_76CB::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76D5, Script_15_76CF
Script_15_76CF::
    script_message $c00a ; '*: A great monster will be'
    script_jump Script_15_76E5
Script_15_76D5::
    script_message $c009 ; '*: 0 will result from this.'
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76E2, Script_15_76DC
Script_15_76DC::
    script_message $c00c ; '*: You've never had that monster.'
    script_jump Script_15_76E5
Script_15_76E2::
    script_message $c00b ; '*: You already had that monster.'
Script_15_76E5::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76E9, Script_15_76EC
Script_15_76E9::
    script_jump Script_15_76EF
Script_15_76EC::
    script_message $c029 ; '*: Accessories will be in the'
Script_15_76EF::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_choice_jump Script_15_76FC, Script_15_76F4
Script_15_76F4::
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_76FC::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_message $c00f ; '*: Hatching that will cost 0G.'
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7706, Script_15_7712, Script_15_770C
Script_15_7706::
    script_message $c010 ; '*: I'll hatch the egg too,'
    script_jump Script_15_7764
Script_15_770C::
    script_message $c012 ; '*: You don't have enough gold,'
    script_jump Script_15_7715
Script_15_7712::
    script_message $c011 ; '*: I won't hatch the egg,'
Script_15_7715::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_message $401e ; '*: You got the egg of'
    script_message $c019 ; '*: 0 is going to the'
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_jump Script_15_764C
Script_15_7724::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7731, Script_15_7728
Script_15_7728::
    script_message $c01c ; '*: There isn't a single egg'
    script_message $c004 ; '*: Is there anything else?'
    script_jump Script_15_764C
Script_15_7731::
    script_message $c01a ; '*: Which egg should I hatch?'
Script_15_7734::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_773F, Script_15_7738
Script_15_7738::
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_773F::
    script_message $c01b ; '*: That will cost 0G. OK?'
Script_15_7742::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_774E, Script_15_7752, Script_15_7747
Script_15_7747::
    script_message $c01a ; '*: Which egg should I hatch?'
    script_command SCRIPT_BREED
    script_jump Script_15_7734
Script_15_774E::
    script_command SCRIPT_BREED
    script_jump Script_15_7742
Script_15_7752::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7761, Script_15_7756
Script_15_7756::
    script_message $c01d ; '*: You don't have enough gold.'
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_7761::
    script_message $c021 ; '*: Fine, fine. Just wait here.'
Script_15_7764::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
Script_15_7766::
    script_message $4014 ; '*: Will you take 0 with'
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7778, Script_15_776D
Script_15_776D::
    script_message $c016 ; '*: I'll send 0 to the'
Script_15_7770::
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C
Script_15_7778::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_7782, Script_15_777C
Script_15_777C::
    script_message $c015 ; '*: Raise it with love and'
    script_jump Script_15_7770
Script_15_7782::
    script_message $c017 ; '*: Which will go back to'
Script_15_7785::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_778D, Script_15_7789
Script_15_7789::
    script_command SCRIPT_BREED
    script_jump Script_15_7766
Script_15_778D::
    script_message $c018 ; '*: Is this the one to'
Script_15_7790::
    script_command SCRIPT_BREED
    script_choice_jump Script_15_779C, Script_15_77A0, Script_15_7795
Script_15_7795::
    script_command SCRIPT_BREED
    script_message $c017 ; '*: Which will go back to'
    script_jump Script_15_7785
Script_15_779C::
    script_command SCRIPT_BREED
    script_jump Script_15_7790
Script_15_77A0::
    script_command SCRIPT_BREED
    script_message $c019 ; '*: 0 is going to the'
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_15_764C

HibernateMenu_WriteListCountAndRAMG2Etc::
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
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
    ld [hli], a

.skip:
    ld a, $6f
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp $1d
    jr c, .loop2
    ld de, sRecords
    ld a, $01
    ld [rRAMB], a
    ld a, [de]
    bit 7, a
    jr z, .set_list_count
    inc c
    ld a, b
    ld [hli], a

.set_list_count:
    ld a, c
    ld [wListCount], a
    xor a
    ld [rRAMG2], a
    ret

HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListPageIndex]
    ld b, a
    sla a
    sla a
    add b
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp $04
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp $01
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
    add c
    pop bc
    add c
    cp b
    jr nc, .check_screen_step
    push hl
    push bc
    xor a
    ld [wArg1], a
    ld a, [hl]
    cp $1d
    jr z, .set_arg2_to_01
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
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
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    pop bc
    push bc
    ld a, c
    cp $04
    jr nz, .skip
    call HibernateMenu_ChooseRecords_Case03_Sub01_GlyphCopyArgsForA_Bank15
    jr .restore

.skip:
    ld a, c
    sla a
    ld hl, HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Data
    add_a_to_hl
    ld a, [hli]
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
    cp c
    jr z, .check_screen_step
    ld a, c
    cp $05
    jp c, .loop

.check_screen_step:
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

HibernateMenu_ChooseRecords_Case03_WriteRAMG2AndRAMBEtc_Data::
    db $00, $8d, $50, $8d, $a0, $8d, $00, $8f, $40, $8a

HibernateMenu_ChooseRecords_Case03_Sub01_GlyphCopyArgsForA_Bank15::
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp $f0
    jp z, .clear_glyph_list_start
    cp $8d
    jr z, .check_glyph_list_start
    cp $8e
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
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DE = $4010 + 16 * A (the glyph's tile), HL = the VRAM address from GlyphCopyArgsForA_Bank15_Data +
; 2 * wGlyphListStart, B = $1F (bank), C = 16 (bytes) (E-0121)
GlyphCopyArgsForA_Bank15::
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
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld h, d
    ld l, e
    pop de
    ld b, $1f
    ld c, $10
    ret

GlyphCopyArgsForA_Bank15_Data::
    db $40, $8a, $50, $8a, $60, $8a, $e0, $8c, $f0, $8c

; wWorkBuf = the family nibble of the record selected by wArg1 (RecordAddressWithBank1Slot1D),
; wWorkBuf + $1 = $C7, then LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForArg1Record::
    ld a, [wArg1]
    ld b, a
    ld a, $0a
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    ld a, [hl]
    and $0f
    ld [wWorkBuf], a
    ld a, $c7
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a
    ld [rRAMG2], a
    ret

HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D::
    ld a, [wArg1]
    ld b, a
    ld a, $0a
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    push hl
    inc hl
    ld a, [hl]
    and $08
    sla a
    swap a
    pop hl
    add $cc
    ld [wWindowTileBuffer + $86], a
    push hl
    ld a, $62
    add_a_to_hl
    ld a, [hl]
    and $7f
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15_7ADB
    ld a, [wDigits + $1]
    add $e0
    ld [wWindowTileBuffer + $89], a
    ld a, [wDigits + $2]
    add $e0
    ld [wWindowTileBuffer + $8a], a
    pop hl
    push hl
    ld a, $57
    add_a_to_hl
    ld a, [hli]
    ld [wArg1], a
    ld a, [hli]
    ld [wArg3], a
    ld a, [hli]
    ld [wArg5], a
    ld a, [hli]
    ld [wArg7], a
    ld a, [hl]
    and $c0
    srl a
    srl a
    swap a
    ld [wArg2], a
    ld a, [hl]
    and $30
    swap a
    ld [wArg4], a
    ld a, [hl]
    and $0c
    srl a
    srl a
    ld [wArg6], a
    ld a, [hl]
    and $03
    ld [wArg8], a
    pop hl
    ld c, $00

.loop:
    push bc
    ld a, c
    sla a
    ld de, wArg1
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
    call HLToDecimalDigits
    call BlankLeadingZeroDigits_F_Bank15_7ADB
    pop bc
    ld a, c
    sla a
    ld hl, HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wDigits]
    add $e0
    ld [de], a
    inc de
    ld a, [wDigits + $1]
    add $e0
    ld [de], a
    inc de
    ld a, [wDigits + $2]
    add $e0
    ld [de], a
    inc c
    ld a, c
    cp $04
    jr c, .loop
    xor a
    ld [rRAMG2], a
    ret

HibernateMenu_ChooseRecords_Case04_RecordAddressWithBank1Slot1D_Data::
    db $d4, $c3, $d8, $c3, $fc, $c3, $00, $c4

; HL = sCompactRecords + $6F * B in SRAM bank 0, except record $1D, which is at sRecords in SRAM
; bank 1 (E-0122)
RecordAddressWithBank1Slot1D::
    ld a, b
    cp $1d
    jr z, .skip
    ld c, $6f
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a
    ld [rRAMB], a
    ret

.skip:
    ld hl, sRecords
    ld a, $01
    ld [rRAMB], a
    ret

HibernateMenu_ChooseRecords_Case06_RecordAddressWithBank1Slot1D::
    ld a, [wArg1]
    ld b, a
    ld a, $0a
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    push hl
    ld [wArg2], a
    xor a
    ld [wArg1], a
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall LoadRecordNameEntry0
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop hl
    inc hl
    ld a, [hli]
    and $01
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
    xor a
    ld [rRAMG2], a
    ret

; when wDigits is 0 it becomes $E3, and then when wDigits + $1 is 0 too it becomes $E3: a digit byte
; of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros
; are blanked (E-0093) (the same 23 bytes appear in 2 banks)
BlankLeadingZeroDigits_F_Bank15_7ADB::
    ld a, [wDigits]
    and a
    jr nz, .return
    add $e3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a
    jr nz, .return
    add $e3
    ld [wDigits + $1], a

.return:
    ret
    ds $50e, $00
