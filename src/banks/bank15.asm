SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

; implements script command type EE (SCRIPT_BREED_CLOSE): ends the breeding (and medal prize) session and clears wMessageMode; reached through ScriptCommandEE in bank $10 (E-0038, E-0244)
; 4 call sites from 4 routines (e.g. CloseRenameMenu_ToCloseBreedMenu, ScriptCommandEE, CloseMenuE9_ToCloseBreedMenu, CloseMenuE9_ToCloseBreedMenu_CloseBreedMenu)
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
    jr z, Jump_015_402B
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

Jump_015_402B::
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

Jump_015_40C7::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_40C7
    ld hl, wTextBuf0
    ld b, $10

Jump_015_40D3::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_015_40D3
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
; 27 call sites from 27 routines (e.g. EggServiceMenu_Case05_ToBreedMenu, NpcBreedMenu_Case04_ToBreedMenu, NpcBreedMenu_Case04_BreedMenu, NpcBreedMenu_Case11_ToBreedMenu, ...)
; reads: wScreenState
BreedMenu::
Func_015_40FA:: ; address name
    ld a, [wScreenState]
    rst $00
    dw BreedMenu_Init
    dw BreedMenu_Setup
    dw BreedMenu_ToHandleThreeOptionMenuInput_15
    dw BreedMenu_Case03
    dw BreedMenu_Case04
    dw BreedMenu_Case05
    dw BreedMenu_NameEntry
    dw BreedMenu_ReturnToMap
    dw BreedMenu_TalkEvent17ThenNameEntry
    dw BreedMenu_CopyToChildThenTalkEvent16
    dw BreedMenu_TalkEvent15
    dw BreedMenu_Case0B
    dw BreedMenu_SwapMonstersMenu
    dw BreedMenu_SwapMonstersMenu_SwapMonstersMenu
    dw BreedMenu_SwapMonstersMenu_SwapMonstersMenu
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

Jump_015_412A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_412A
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_414F
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

Jump_015_414F::
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
; 4 call sites from 4 routines (e.g. BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case3A, BreedMenu_Case04_DrawPair72A9And72C5AndStep, BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case0A, BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15)
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
; 6 call sites from 6 routines (e.g. BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case3A, BreedMenu_Case04_DrawPair72A9And72C5AndStep, BreedMenu_Case04_DrawGoldBoxAndStep_Bank15, BreedMenu_Case05_DrawGoldBoxAndStep_Bank15, ...)
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

Jump_015_41AA::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_015_41AA
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
BreedMenu_Case03::
Jump_015_41E5:: ; address name
    ld a, [wGridCursorX]
    and a, a
    jr z, Jump_015_41ED
    jr Jump_015_41F5

Jump_015_41ED::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

Jump_015_41F5::
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wRecordsFlagged]
    and a, a
    jr nz, Jump_015_4215
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4215::
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

; entry 4 of the `rst $00` table in BreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
BreedMenu_Case04::
Jump_015_422B:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw BreedMenu_Case04_CopyRectTo20ByteRows_Bank15_Case00
    dw BreedMenu_Case04_ClearTileAreas1240_1700_14E0
    dw BreedMenu_Case04_ListRecordsInUseWithByte6EClear
    dw BreedMenu_Case04_DrawRecordListPageNames
    dw BreedMenu_Case04_SetArg5ToListEntriesCell5
    dw BreedMenu_Case04_FillTilesBxC
    dw BreedMenu_Case04_SetArg5ToListEntriesCell5_Case06
    dw BreedMenu_Case04_DrawScreenBufferAtScrollAndIncScreenStep
    dw BreedMenu_Case04_UpdatePagedListCursor
    dw BreedMenu_Case04_CopyRectTo20ByteRows_Bank15_Case09
    dw BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case0A
    dw BreedMenu_Case04_BlankWordTableTargets
    dw BreedMenu_Case04_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_Case04_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_Case04_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_Case04_ToCopyRectTo20ByteRows_Bank15AndStep
    dw BreedMenu_Case04_BlankWordTableTargets_Case10
    dw BreedMenu_Case04_SetArg5ToListEntriesCell5_Case11
    dw BreedMenu_Case04_BlankWordTableTargets_Case12
    dw BreedMenu_Case04_Case13
    dw BreedMenu_Case04_ClearThreeTileRows
    dw BreedMenu_Case04_FillTilesBxC_Case15
    dw BreedMenu_Case04_LoadRecordSelectedRecordByte0EBit0
    dw BreedMenu_Case04_DrawRecordListPageNames
    dw DrawListEntriesCell5IconAndLevelAndStep
    dw BreedMenu_Case04_ToClearThreeTileRowsAndStep
    dw DrawListEntriesCell5RecordNamesAndStep
    dw BreedMenu_Case04_BreedMenu_SetArg5ToListEntriesCell5
    dw BreedMenu_Case04_ComputeBreedingChild
    dw DrawScreenBufferAtScrollAndIncScreenStep
    dw BreedMenu_Case04_UpdatePagedListCursor_Case1E
    dw BreedMenu_Case04_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_Case04_LoadTileListSixPerCall
    dw BreedMenu_Case04_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_Case04_CopyGlyphTileListFromBank1F_Bank15
    dw BreedMenu_Case04_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_Case04_ClearTileAreas2700_1750_17D0
    dw BreedMenu_Case04_BlankWordTableTargets_Case25
    dw BreedMenu_Case04_SetArg5ToListEntriesCell5_Case26
    dw BreedMenu_Case04_TestBitInFieldAtArg3
    dw BreedMenu_Case04_TestBitInFieldAtArg3_Case28
    dw BreedMenu_Case04_PrepareWCF8BCountersAndRequestScript
    dw DrawRect70C5IfLinkModeAndStep
    dw BreedMenu_Case04_ShowSaveFileInfoWindow
    dw BreedMenu_Case04_DrawBottomBoxForLinkAndSetScreenSubStep
    dw BreedMenu_Case04_WriteScreenStep
    dw BreedMenu_Case04_WriteScreenStepAndTwoChoiceCursor
    dw BreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D
    dw BreedMenu_Case04_DrawRect70C5IfLinkModeAndStep
    dw BreedMenu_Case04_BGMapAddressAtScroll_Bank15
    dw BreedMenu_Case04_LoadTileListSixPerCall_Case32
    dw BreedMenu_Case04_DrawPair72A9And72C5AndStep
    dw BreedMenu_Case04_StoreBAtWordTableEntry_Bank15
    dw BreedMenu_Case04_BlankWordTableTargets
    dw BreedMenu_Case04_BreedMenu_WaitLinkMode
    dw BreedMenu_Case04_DrawRect70C5IfLinkModeAndStep
    dw BreedMenu_Case04_BGMapAddressAtScroll_Bank15
    dw BreedMenu_Case04_LoadTileListSixPerCall_Case32
    dw BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case3A
    dw BreedMenu_Case04_BGMapAddressAtScroll_Bank15_Case3B
    dw BreedMenu_Case04_TenTimesTemp0PlusTenToDigits
    dw BreedMenu_Case04_CopyFromBankWaitVRAM
    dw BreedMenu_Case04_CopyFromBankWaitVRAM_Case3E
    dw BreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D_Case3F
    dw BreedMenu_Case04_SetScreenStep
    dw BreedMenu_Case04_TenTimesTemp0PlusTen

; entry 0 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wListCursor, wListPageIndex, wCursorBlinkAE, wChoiceCursor, wScreenStep
BreedMenu_Case04_CopyRectTo20ByteRows_Bank15_Case00::
Jump_015_42B3:: ; address name
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call Func_015_6791
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

; entry 1 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_ClearTileAreas1240_1700_14E0::
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

; entry 2 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case04_ListRecordsInUseWithByte6EClear::
Jump_015_4363:: ; address name
    farcall ListRecordsInUseWithByte6EClear

Jump_015_4369::
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_015_43A4
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

Jump_015_43A4::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1
BreedMenu_Case04_DrawRecordListPageNames::
Jump_015_43AC:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 4 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
BreedMenu_Case04_SetArg5ToListEntriesCell5::
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

; entry 5 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
BreedMenu_Case04_FillTilesBxC::
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

; entry 6 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
BreedMenu_Case04_SetArg5ToListEntriesCell5_Case06::
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
; 1 call site from 1 routine (e.g. BreedMenu_Case04_DrawScreenBufferAtScrollAndIncScreenStep)
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

; entry 7 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
BreedMenu_Case04_DrawScreenBufferAtScrollAndIncScreenStep::
Jump_015_444D:: ; address name
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    call DrawScreenBufferAtScrollAndIncScreenStep
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    ret

; entry 8 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_Case04_UpdatePagedListCursor::
Jump_015_4467:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_448B
    cp a, $FC
    jr z, Jump_015_448B
    cp a, $FD
    jr z, Jump_015_44CA
    cp a, $FE
    jr z, Jump_015_4494
    cp a, $FF
    jr z, Jump_015_449C
    ret

Jump_015_448B::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_015_4494::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_015_449C::
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_015_73A1
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

Jump_015_44CA::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case04_CopyRectTo20ByteRows_Bank15_Case09::
Jump_015_44D3:: ; address name
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call Func_015_6791
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call Func_015_6791
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

; entry 10 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case0A::
Jump_015_451B:: ; address name
    call DrawPair72A9And72C5AndStep
    ld de, TileRect_15_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, Data_015_732D
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

; entry 12 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_CopyRectTo20ByteRows_Bank15::
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

; entry 13 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wChoiceCursor, wScreenStep
BreedMenu_Case04_CopyGlyphTileListFromBank1F_Bank15::
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

; entry 15 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_ToCopyRectTo20ByteRows_Bank15AndStep::
Jump_015_45A5:: ; address name
    ld de, Data_015_7505
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_BlankWordTableTargets_Case10::
Jump_015_45B9:: ; address name
    ld c, $05
    ld hl, Data_015_73A1
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

; entry 17 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wListCount, wScreenStep, wPartyCount, wPartyList, wListCursor, ...
; writes: rRAMG2, rRAMB, wArg5, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wSelectedRecord, ...
; points at: wListEntries
BreedMenu_Case04_SetArg5ToListEntriesCell5_Case11::
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

Jump_015_4606::
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
    jr nz, Jump_015_463F
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr nz, Jump_015_4606
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

Jump_015_463F::
    pop bc
    pop hl
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, Jump_015_466B
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

Jump_015_466B::
    pop hl
    ld a, [wPartyCount]
    cp a, $02
    jr nc, Jump_015_4696
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_015_4696
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

Jump_015_4696::
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

; entry 18 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wWindowTileBuffer, wScreenStep
BreedMenu_Case04_BlankWordTableTargets_Case12::
Jump_015_46D3:: ; address name
    ld a, $B6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $A0], a
    ld [wWindowTileBuffer + $C8], a
    ld de, TileRect_15_7541
    ld hl, wWindowTileBuffer + $94
    ld bc, $0C03
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7505
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld c, $05
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 19 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case04_Case13::
Jump_015_4712:: ; address name
    call BreedMenu_Case04_Case13_Sub01
    ret

; entry 20 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_ClearThreeTileRows::
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

; entry 21 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_FillTilesBxC_Case15::
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

; entry 22 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case04_LoadRecordSelectedRecordByte0EBit0::
Jump_015_4768:: ; address name
    call LoadRecordSelectedRecordByte0EBit0
    call BreedMenu_Shared03
    jp Jump_015_4369

; for the record at WD789 cell 5 loads its family icon tile and draws its mark and level at wC426, then wD781 += 1 (E-0124)
; 2 call sites from 2 routines (e.g. BreedMenu_Case04_PrepareWCF8BCountersAndRequestScript, BreedMenu_Case04_ClearTileAreas2700_1750_17D0)
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

; entry 25 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_ToClearThreeTileRowsAndStep::
Jump_015_479C:: ; address name
    call ClearThreeTileRows
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; draws the name and species name of the record at WD789 cell 5, clears wCFA8 and wCFA9 and wD781 += 1 (E-0122)
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_PrepareWCF8BCountersAndRequestScript, BreedMenu_Case04_ClearTileAreas2700_1750_17D0, BreedMenu_Case12_ClearThreeTileRows)
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

; entry 27 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wNameEntryState, wNameEntrySubState, wScreenStep
BreedMenu_Case04_BreedMenu_SetArg5ToListEntriesCell5::
Jump_015_47CF:: ; address name
    call BreedMenu_SetArg5ToListEntriesCell5
    xor a, a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 28 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg7, wArg6, wScreenStep
; writes: wArg1, wSpeciesIdLo, wArg2, wSpeciesIdHi, wArg3, wArg4, wArg5, wScreenStep, ...
; points at: wMonsterLibraryBuf, wNameGlyphBuf
BreedMenu_Case04_ComputeBreedingChild::
Jump_015_47E1:: ; address name
    xor a, a
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wArg7]
    cp a, $FF
    jr nz, Jump_015_47FF
    ld a, [wArg6]
    cp a, $FF
    jr z, Jump_015_485A

Jump_015_47FF::
    ld a, [wArg6]
    ld [wArg1], a
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wArg2], a
    ld [wSpeciesIdHi], a
    ld de, Data_015_75C5
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    call TestBitInFieldAtArg3
    ld a, [wArg5]
    cp a, $FF
    jr z, Jump_015_487A
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
    jr z, Jump_015_487A
    ld a, [wArg6]
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, Jump_015_487A

Jump_015_485A::
    ld c, $00
    ld hl, wNameGlyphBuf

Jump_015_485F::
    ld a, $98
    ld [hl+], a
    inc c
    ld a, c
    cp a, $09
    jr c, Jump_015_485F
    ld a, $F0
    ld [hl], a
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $490
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    jr Jump_015_4899

Jump_015_487A::
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

Jump_015_4899::
    ld c, $00
    ld a, $04
    ld [wArg5], a
    farcall DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor
; writes: wMenuInputResult, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_Case04_UpdatePagedListCursor_Case1E::
Jump_015_48AE:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_48D2
    cp a, $FC
    jr z, Jump_015_48D2
    cp a, $FD
    jr z, Jump_015_4911
    cp a, $FE
    jr z, Jump_015_48DB
    cp a, $FF
    jr z, Jump_015_48E3
    ret

Jump_015_48D2::
    ld a, [wScreenStep]
    sub a, $09
    ld [wScreenStep], a
    ret

Jump_015_48DB::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_015_48E3::
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_015_73A1
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

Jump_015_4911::
    ld a, [wScreenStep]
    sub a, $06
    ld [wScreenStep], a
    ret

; entry 31 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wWindowTileBuffer, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_Case04_DrawGoldBoxAndStep_Bank15::
Jump_015_491A:: ; address name
    ld c, $03
    ld hl, $01FC
    ld de, $0030
    xor a, a
    ld [wArg1], a
    ld a, $0C
    ld [wArg2], a
    call Func_015_6791
    ld a, $B7
    ld [wWindowTileBuffer + $93], a
    ld [wWindowTileBuffer + $A7], a
    call DrawGoldBoxAndStep_Bank15
    ld de, TileRect_15_74D5
    ld hl, wWindowTileBuffer + $BC
    ld bc, $0C01
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7511
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

; entry 32 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wItemGridX, wItemGridY
; writes: wArg1, wArg2, wArg3, wArg4, wListCursor, wListPageIndex, wTwoChoiceCursor, wChoiceCursor, ...
BreedMenu_Case04_LoadTileListSixPerCall::
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

; entry 36 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
BreedMenu_Case04_ClearTileAreas2700_1750_17D0::
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

; entry 37 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_BlankWordTableTargets_Case25::
Jump_015_4A2A:: ; address name
    ld c, $05
    ld hl, Data_015_73A1
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

; entry 38 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wPartyCount, wSelectedRecord, wPartyList, wScreenStep
; writes: rRAMG2, rRAMB, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_SetArg5ToListEntriesCell5_Case26::
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
    ld c, $56
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, Jump_015_4A88
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4A88::
    ld a, [wPartyCount]
    cp a, $03
    jr z, Jump_015_4AED
    cp a, $01
    jr z, Jump_015_4AD6
    ld a, [wSelectedRecord]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr z, Jump_015_4AA5
    ld a, [wPartyList + $1]
    cp a, b
    jr z, Jump_015_4AA5
    jr Jump_015_4AED

Jump_015_4AA5::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld b, [hl]
    ld a, [wPartyList]
    cp a, b
    jr z, Jump_015_4AC2
    ld a, [wPartyList + $1]
    cp a, b
    jr z, Jump_015_4AC2
    jr Jump_015_4AED

Jump_015_4AC2::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4AD6::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld b, [hl]
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_015_4AED
    jr Jump_015_4AC2

Jump_015_4AED::
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

; entry 39 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wDigits, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, ...
; points at: wMonsterLibraryBuf, wNameGlyphBuf, wTextBuf0
BreedMenu_Case04_TestBitInFieldAtArg3::
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
    jr nz, Jump_015_4B21
    jr Jump_015_4B55

Jump_015_4B21::
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr z, Jump_015_4B38
    jr Jump_015_4B55

Jump_015_4B38::
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld hl, Data_015_75C5
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    call TestBitInFieldAtArg3
    cp a, $FF
    jr nz, Jump_015_4BA7

Jump_015_4B55::
    ld de, wChildRecord + $B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

Jump_015_4B66::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_4B70
    ld [de], a
    inc de
    inc hl
    jr Jump_015_4B66

Jump_015_4B70::
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
    jr z, Jump_015_4B8A
    ld [de], a
    inc de

Jump_015_4B8A::
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

Jump_015_4BA7::
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

; entry 40 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wSpeciesIdLo, wSpeciesIdHi, wTwoChoiceCursor, wScreenStep, ...
; points at: wMonsterLibraryBuf
BreedMenu_Case04_TestBitInFieldAtArg3_Case28::
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
    jr z, Jump_015_4BF7
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, Jump_015_4BF7
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_015_4BFB

Jump_015_4BF7::
    xor a, a
    ld [wTwoChoiceCursor], a

Jump_015_4BFB::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; if wC58A is set, copies and draws rectangle $70C5 at wC364; wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. BreedMenu_Case04_DrawRect70C5IfLinkModeAndStep)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep
DrawRect70C5IfLinkModeAndStep::
Func_015_4C0C:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4C15
    call CopyRect70C5ToWC364AndDraw

Jump_015_4C15::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 43 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep
BreedMenu_Case04_ShowSaveFileInfoWindow::
Jump_015_4C1D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4C26
    call ShowSaveFileInfoWindow

Jump_015_4C26::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 44 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wTextFlags, wScreenStep, wLinkMode
; writes: wScreenSubStep, wScreenStep, wScriptCommandType, wScriptStartRequest, wStringIndex
; points at: wTextWindowTileLo
BreedMenu_Case04_DrawBottomBoxForLinkAndSetScreenSubStep::
Jump_015_4C2E:: ; address name
    call BreedMenu_WaitLinkMode
    ld a, [wScreenSubStep]
    cp a, $02
    jr z, Jump_015_4C4D
    cp a, $03
    jr z, Jump_015_4C66
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

Jump_015_4C4D::
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4C5E
    ld a, $0D
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

Jump_015_4C5E::
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_015_4C66::
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

; entry 41 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wLinkMode
; writes: wScreenSubStep, wScreenStep, wTwoChoiceCursor
BreedMenu_Case04_PrepareWCF8BCountersAndRequestScript::
Jump_015_4C80:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, Jump_015_4C8A
    call PrepareWCF8BCountersAndRequestScript
    ret

Jump_015_4C8A::
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4CD9
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

Jump_015_4CD9::
    ld a, $2A
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 47 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D::
Jump_015_4CE3:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4D1E
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp a, $FE
    jr z, Jump_015_4CFE
    cp a, $FF
    jr z, Jump_015_4D14
    call BreedMenu_WaitLinkMode
    ret

Jump_015_4CFE::
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

Jump_015_4D14::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_015_4CFE
    call BreedMenu_WaitLinkMode

Jump_015_4D1E::
    ld a, [wScreenStep]
    add a, $07
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 48 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest
BreedMenu_Case04_DrawRect70C5IfLinkModeAndStep::
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

; entry 50 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wScreenStep
BreedMenu_Case04_LoadTileListSixPerCall_Case32::
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

; entry 49 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case04_BGMapAddressAtScroll_Bank15::
Jump_015_4D6E:: ; address name
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call Func_015_6791
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 51 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_DrawPair72A9And72C5AndStep::
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

; entry 52 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: wScriptCommandType, wScriptStartRequest, wScreenStep
; points at: wTextWindowTileLo
BreedMenu_Case04_StoreBAtWordTableEntry_Bank15::
Jump_015_4DB0:: ; address name
    ld a, [wGridCursorX]
    ld hl, Data_015_732D
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

; entry 58 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case3A::
Jump_015_4DE5:: ; address name
    call DrawPair72A9And72C5AndStep
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; entry 59 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScriptCommandType, wScriptStartRequest, wScreenStep
; points at: wTextWindowTileLo
BreedMenu_Case04_BGMapAddressAtScroll_Bank15_Case3B::
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

; entry 60 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hTemp0, wScriptCommandType, wScriptStartRequest, wScreenStep
; points at: wTextWindowTileLo
BreedMenu_Case04_TenTimesTemp0PlusTenToDigits::
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

; entry 54 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wTextFlags, wScreenStep, wLinkMode, wSaveStep, wSelectedRecord, wArg5, wArg6, ...
; writes: wScreenSubStep, wScreenStep, wStringIndex, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wArg1, wArg2, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork
BreedMenu_Case04_BreedMenu_WaitLinkMode::
Jump_015_4E47:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr z, Jump_015_4EB1
    cp a, $01
    jr z, Jump_015_4E87
    cp a, $02
    jr z, Jump_015_4E6B
    ld a, [wTextFlags]
    and a, a
    jr z, Jump_015_4E5F
    call BreedMenu_WaitLinkMode
    ret

Jump_015_4E5F::
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_015_4E6B::
    call BreedMenu_WaitLinkMode
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4E7F
    ld a, $0E
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

Jump_015_4E7F::
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_015_4E87::
    call BreedMenu_WaitLinkMode
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4E9C
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z

Jump_015_4E9C::
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

Jump_015_4EB1::
    call BreedMenu_WaitLinkMode
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
    jr c, Jump_015_4EDE
    dec a

Jump_015_4EDE::
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

Jump_015_4F07::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_4F07
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

Jump_015_4F36::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_4F36
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

Jump_015_4F51::
    ld a, [hl]
    cp a, b
    jr nz, Jump_015_4F61
    ld a, $FF
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    jr Jump_015_4F69

Jump_015_4F61::
    inc hl
    inc c
    ld a, [wPartyCount]
    cp a, c
    jr nz, Jump_015_4F51

Jump_015_4F69::
    ld hl, wPartyList
    ld de, wPartyList
    ld c, $00

Jump_015_4F71::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_015_4F78
    jr Jump_015_4F7A

Jump_015_4F78::
    ld [de], a
    inc de

Jump_015_4F7A::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_4F71
    ld hl, wPartyList
    ld c, $00

Jump_015_4F86::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_015_4F90
    cp a, b
    jr z, Jump_015_4F90
    jr Jump_015_4F92

Jump_015_4F90::
    xor a, a
    ld [hl], a

Jump_015_4F92::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_4F86
    ret

; entry 63 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArg1, wScreenStep
; writes: hTemp0, wArg3, wArg2, wArg1, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, ...
BreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D_Case3F::
Jump_015_4F9A:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_015_4FAE
    cp a, $FF
    jr z, Jump_015_4FC4
    ret

Jump_015_4FAE::
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

Jump_015_4FC4::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_015_4FAE
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
    jr nz, Jump_015_5003
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

Jump_015_5003::
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

; entry 64 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenState, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_SetScreenStep::
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

; entry 65 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wListCursor, wListCount, wArg5, wArg6
; writes: hTemp0, wArg3, wArg2, wArg1, wListCursor, wListPageIndex, wListLastRow, wListPages, ...
; points at: wListEntries2, wListEntries
BreedMenu_Case04_TenTimesTemp0PlusTen::
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

Jump_015_504D::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_504D
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

Jump_015_5071::
    ld a, [hl]
    cp a, b
    jr z, Jump_015_5084
    inc c
    inc hl
    ld a, [wListCursor]
    inc a
    ld [wListCursor], a
    ld a, [wListCount]
    cp a, c
    jr nz, Jump_015_5071

Jump_015_5084::
    ld a, [wListCursor]
    srl a
    srl a
    ld [wListPageIndex], a
    ld a, [wListCursor]

Jump_015_5091::
    cp a, $04
    jr c, Jump_015_5099
    sub a, $04
    jr Jump_015_5091

Jump_015_5099::
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
    dw BreedMenu_Case05_Case00
    dw BreedMenu_Case05_ListRecordsInUseWithByte6ESet
    dw ClearTileRowsAndResetWindowAndStep
    dw BreedMenu_Case05_ClampRecordListPageCursor4_Case03
    dw BreedMenu_Case05_DrawRecordListPageSpeciesNames
    dw BreedMenu_Case05_DrawRecordListPageMarks
    dw BreedMenu_Case05_UpdatePagedListCursor
    dw BreedMenu_Case05_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_Case05_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_Case04_BlankWordTableTargets
    dw BreedMenu_Case05_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_Case05_QueueSoundEffect
    dw BreedMenu_Case04_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_Case05_ClampRecordListPageCursor4
    dw BreedMenu_Case05_LoadTile4990AndRun6320
    dw BreedMenu_Case05_SetArg5ToListEntriesCell4
    dw BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10

; entry 0 of the `rst $00` table in BreedMenu_Case05
; no direct call (reached through a table, a jump or a vector)
BreedMenu_Case05_Case00::
Jump_015_50F7:: ; address name
    call BreedMenu_Case05_Case00_Sub01
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
    ld hl, Data_015_732D
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
    jr c, Jump_015_51AC
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

Jump_015_51AC::
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_015_7333
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_015_7333
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
    jr z, Jump_015_5232
    cp a, $FC
    jr z, Jump_015_5232
    cp a, $FD
    jr z, Jump_015_523B
    cp a, $FE
    jr z, Jump_015_523C
    cp a, $FF
    jr z, Jump_015_525F
    ret

Jump_015_5232::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_015_523B::
    ret

Jump_015_523C::
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

Jump_015_525F::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_015_7333
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
    call Func_015_6791
    ld a, [wThreeOptionResult]
    or a, a
    jr z, Jump_015_52EB
    ld de, TileRect_15_7345
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0403
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_015_52EB::
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
    jr nz, Jump_015_5323
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

Jump_015_5323::
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

; entry 11 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep, wScreenState, wScriptCommandType, wScriptStartRequest
BreedMenu_Case04_BlankWordTableTargets::
Jump_015_5358:: ; address name
    ld c, $03
    ld hl, Data_015_732D
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

; entry 14 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteB2, wScreenByteB3, wScreenState, wScreenSubStep, ...
BreedMenu_Case04_BlinkCursorBlinkAE_Bank15::
Jump_015_53B3:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_015_53CF
    bit 7, a
    jr nz, Jump_015_53E9
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_015_53F9
    bit 1, a
    jp nz, Jump_015_5488
    call BlinkCursorBlinkAE_Bank15
    ret

Jump_015_53CF::
    call DrawBlankTileC3_Bank15
    ld a, [wChoiceCursor]
    and a, a
    jr nz, Jump_015_53DC
    ld a, $01
    jr Jump_015_53DD

Jump_015_53DC::
    dec a

Jump_015_53DD::
    ld [wChoiceCursor], a
    call BlinkCursorBlinkAE_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_53E9::
    call DrawBlankTileC3_Bank15
    ld a, [wChoiceCursor]
    cp a, $01
    jr c, Jump_015_53F6
    xor a, a
    jr Jump_015_53DD

Jump_015_53F6::
    inc a
    jr Jump_015_53DD

Jump_015_53F9::
    ld a, $69
    call QueueSoundEffect
    call BreedMenu_Case04_Case0E_StepBGMapAddressBackOnScrollWrap
    ld a, [wChoiceCursor]
    and a, a
    jp nz, Jump_015_5471
    ld a, [wScreenState]
    cp a, $04
    jr z, Jump_015_5415
    cp a, $05
    jr z, Jump_015_5438
    jr Jump_015_5446

Jump_015_5415::
    ld a, [wScreenStep]
    cp a, $22
    jr c, Jump_015_542A
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $23
    ld [wScreenByteB3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_542A::
    ld a, $04
    ld [wScreenByteB2], a
    ld a, $0E
    ld [wScreenByteB3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_5438::
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $0C
    ld [wScreenByteB3], a
    ld a, $0D
    jr Jump_015_5454

Jump_015_5446::
    ld a, $07
    ld [wScreenByteB2], a
    ld a, $18
    ld [wScreenByteB3], a
    ld a, $0E
    jr Jump_015_5454

Jump_015_5454::
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

Jump_015_5471::
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

Jump_015_5488::
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
; 2 call sites from 1 routine (e.g. BreedMenu_Case04_BlinkCursorBlinkAE_Bank15)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
BlinkCursorBlinkAE_Bank15::
Func_015_549E:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_015_54B8
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, Jump_015_54B8
    cp a, $18
    jr c, DrawBlankTileC3_Bank15
    xor a, a
    ld [wCursorBlinkAE], a

Jump_015_54B8::
    ld b, $BB
    jr Jump_015_54C2

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. BreedMenu_Case04_BlinkCursorBlinkAE_Bank15)
; reads: wChoiceCursor
DrawBlankTileC3_Bank15::
Func_015_54BC:: ; address name
    ld b, $C3
    jr Jump_015_54C2

; only called from BreedMenu_Case04_Case0E (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_Case04_BlinkCursorBlinkAE_Bank15)
; reads: wChoiceCursor
BreedMenu_Case04_Case0E_StepBGMapAddressBackOnScrollWrap::
Func_015_54C0:: ; address name
    ld b, $BC

Jump_015_54C2::
    ld a, [wChoiceCursor]
    add a, a
    ld hl, Data_015_54E2
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

; address loaded by BreedMenu_Case04_Case0E_StepBGMapAddressBackOnScrollWrap
Data_015_54E2:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    jr nz, Jump_015_5555
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $07
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5555::
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

Jump_015_55B7::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_55B7
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
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $1F
    ld [wArg3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0B
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
    ld c, $01
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $0A
    ld de, wNameGlyphBuf

Jump_015_5648::
    ld a, [de]
    cp a, $F0
    jr z, Jump_015_5654
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_015_5648
    jr Jump_015_5657

Jump_015_5654::
    ld a, $F0
    ld [hl], a

Jump_015_5657::
    ld a, [wSelectedRecord]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld de, wRecordBufA
    ld b, $A5

Jump_015_5668::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_5668
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

Jump_015_569E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_569E
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
    dw BreedMenu_ReturnToMap_Case04
    dw BreedMenu_Case04_CopyFromBankWaitVRAM_Case3E
    dw BreedMenu_ReturnToMap_UpdateTwoChoiceCursor_Bank1D
    dw DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM
    dw BreedMenu_ReturnToMap_BlankWordTableTargets
    dw BreedMenu_ReturnToMap_SRAMRecordAddress
    dw BreedMenu_ReturnToMap_CopyRectTo20ByteRows_Bank15
    dw BreedMenu_ReturnToMap_FillTilesBxC_WriteScreenStep
    dw BreedMenu_ReturnToMap_ClampRecordListPageCursor5
    dw BreedMenu_ReturnToMap_ToDrawRecordListPageNames
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5
    dw BreedMenu_ReturnToMap_FillTilesBxC
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_WriteArg1AndScreenStep
    dw BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15
    dw BreedMenu_ReturnToMap_UpdatePagedListCursor
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_CopyFromBankWaitVRAM
    dw BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C
    dw BreedMenu_Case05_ToCopyGlyphTileListFromBank1F_Bank15AndStep
    dw BreedMenu_Case05_QueueSoundEffect
    dw BreedMenu_Case04_BlinkCursorBlinkAE_Bank15
    dw BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_CopyFromBankWaitVRAM_Case19
    dw BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_BGMapAddressAtScroll_Bank15
    dw BreedMenu_ReturnToMap_CopyRecordNameToNameGlyphBuf
    dw BreedMenu_ReturnToMap_SRAMRecordAddress_SRAMRecordAddress
    dw BreedMenu_ReturnToMap_LoadPlayerAndFollowerSpriteGraphics
    dw BreedMenu_ReturnToMap_DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ReturnToMap_DrawPair72A9And72C5AndStep_570C_Case1F
    dw BreedMenu_Case04_BlankWordTableTargets

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
    jr z, Jump_015_577C
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank15

Jump_015_577C::
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
BreedMenu_ReturnToMap_Case04::
Jump_015_57A4:: ; address name
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $0A

Jump_015_57AC::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_57B7
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_015_57AC

Jump_015_57B7::
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

; entry 62 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
BreedMenu_Case04_CopyFromBankWaitVRAM_Case3E::
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
    call BreedMenu_WaitLinkMode
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

; entry 46 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
BreedMenu_Case04_WriteScreenStepAndTwoChoiceCursor::
Jump_015_5811:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, BreedMenu_Case04_CopyFromBankWaitVRAM_Case3E
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
    jr z, Jump_015_5837
    cp a, $FF
    jr z, Jump_015_5850
    ret

Jump_015_5837::
    call BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_ReadIsCGB
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

Jump_015_5850::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_015_5837
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
BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_ReadIsCGB::
Func_015_586D:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $05
    call BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_5889
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15

Jump_015_5889::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; only called from BreedMenu_ReturnToMap_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_ReadIsCGB)
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
    jr nc, Jump_015_58B0
    inc d

Jump_015_58B0::
    dec c
    jr nz, BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15
    ret

; only called from BreedMenu_ReturnToMap_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_ReadIsCGB)
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
    jr nc, Jump_015_58CE
    inc d

Jump_015_58CE::
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
    ld hl, Data_015_732D
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
    ld hl, Data_015_732D
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
    jr nc, Jump_015_5998
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
    ld c, $00
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
    call BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_ReadIsCGB
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5998::
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, Data_015_733B
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

Jump_015_5A2F::
    push bc
    ld a, c
    ld de, Data_015_5A67
    add a, e
    ld e, a
    jr nc, Jump_015_5A39
    inc d

Jump_015_5A39::
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
    ld de, Data_015_5A77
    add a, e
    ld e, a
    jr nc, Jump_015_5A55
    inc d

Jump_015_5A55::
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
    jr nz, Jump_015_5A2F
    ret

; address loaded by BreedMenu_ReturnToMap_Case0B_Sub01
Data_015_5A67:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A3, $50, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $25

; address loaded by BreedMenu_ReturnToMap_Case0B_Sub01
Data_015_5A77:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; entry 12 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
BreedMenu_ReturnToMap_FillTilesBxC_WriteScreenStep::
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
BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_WriteArg1AndScreenStep::
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
    jr z, Jump_015_5BBA
    cp a, $FC
    jr z, Jump_015_5BBA
    cp a, $FD
    jr z, Jump_015_5C10
    cp a, $FE
    jr z, Jump_015_5BC3
    cp a, $FF
    jr z, Jump_015_5BD9
    ret

Jump_015_5BBA::
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_015_5BC3::
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

Jump_015_5BD9::
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_015_73A1
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

Jump_015_5C10::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_CopyFromBankWaitVRAM::
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
    call Func_015_6791
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
BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_CopyFromBankWaitVRAM_Case19::
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
    call Func_015_6791
    ld de, TileRect_15_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7471
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C01
    call CopyRectTo20ByteRows_Bank15
    xor a, a
    ld b, $BC
    ld hl, Data_015_733B
    call StoreBAtWordTableEntry_Bank15
    ld c, $04
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in BreedMenu_ReturnToMap
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
BreedMenu_ReturnToMap_BGMapAddressAtScroll_Bank15_BGMapAddressAtScroll_Bank15::
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
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    xor a, a
    ld [rRAMG2], a
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

Jump_015_5D20::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_5D2A
    ld [de], a
    inc hl
    inc de
    jr Jump_015_5D20

Jump_015_5D2A::
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
BreedMenu_ReturnToMap_SRAMRecordAddress_SRAMRecordAddress::
Jump_015_5D3E:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld c, $00
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wListCursor]
    cp a, $03
    jr z, Jump_015_5DB3
    ld hl, wListEntries
    ld a, [wListCursor]
    add_a_to_hl
    ld a, $FF
    ld [hl], a
    ld hl, wListEntries
    ld de, wPartyList
    ld c, $00

Jump_015_5D7C::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_015_5D84
    inc hl
    jr Jump_015_5D88

Jump_015_5D84::
    ld [de], a
    inc hl
    inc de
    inc c

Jump_015_5D88::
    ld a, c
    cp a, $03
    jr c, Jump_015_5D7C
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wPartyList
    ld c, $00

Jump_015_5D9B::
    push bc
    push hl
    ld a, [hl]
    ld c, $00
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_5D9B
    xor a, a
    ld [rRAMG2], a

Jump_015_5DB3::
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
    call Func_015_6791
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
    ld hl, Data_015_732D
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
    ld c, $0B
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
    dw BreedMenu_Case0B_Case07

; entry 5 of the `rst $00` table in BreedMenu_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
BreedMenu_Case0B_DrawGoldBoxAndStep_Bank15::
Jump_015_5F0A:: ; address name
    call DrawGoldBoxAndStep_Bank15
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_015_5F1E
    farcall SendSGBPaletteSetForSGBPaletteSet
    ld a, $FC
    call StartPaletteFade

Jump_015_5F1E::
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

Jump_015_5F69::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_5F77
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_015_5F69

Jump_015_5F77::
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
BreedMenu_Case0B_Case07::
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
    jr nz, Jump_015_5FFC
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $06
    ld [wScreenState], a
    ret

Jump_015_5FFC::
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
BreedMenu_SwapMonstersMenu_SwapMonstersMenu::
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
    jr c, Jump_015_60A4
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_015_60A4::
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
    ld hl, Data_015_7333
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
    dw BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5_WriteArg1AndScreenStep
    dw BreedMenu_Case04_CopyFromBankWaitVRAM
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

; entry 45 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wScreenStep
; writes: wScreenStep
BreedMenu_Case04_WriteScreenStep::
Jump_015_61F5:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, BreedMenu_Case04_CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 61 of the `rst $00` table in BreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
BreedMenu_Case04_CopyFromBankWaitVRAM::
Jump_015_6203:: ; address name
    call BreedMenu_WaitLinkMode
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
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_015_73A1
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
    dw BreedMenu_Case04_ComputeBreedingChild
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
    call BreedMenu_Shared03
    jp Jump_015_62F7

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
    dw BreedMenu_Case04_SetArg5ToListEntriesCell5
    dw BreedMenu_Case04_FillTilesBxC
    dw BreedMenu_Case04_SetArg5ToListEntriesCell5_Case06
    dw CopyRect7351ToWC410AndIncScreenStep
    dw BreedMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics

; entry 2 of the `rst $00` table in BreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg1, wArg2, wScreenStep
BreedMenu_Case11_ListRecordsInUseWithByte6EClear::
Jump_015_62F1:: ; address name
    farcall ListRecordsInUseWithByte6EClear

Jump_015_62F7::
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_015_631B
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_015_631B::
    ld c, $05
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_015_73A1
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
; 6 call sites from 6 routines (e.g. CloseBreedMenu_CopyGlyphTileListFromBank1F_Bank15, BreedMenu_Case04_CopyGlyphTileListFromBank1F_Bank15, DrawPair72A9And72C5AndStep_570C, BreedMenu_Case0F_CopyGlyphTileListFromBank1F_Bank15, ...)
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
    jp z, Jump_015_63AE
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
    jr nc, Jump_015_6395
    inc d

Jump_015_6395::
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

Jump_015_63AE::
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

; only called from routines of BreedMenu (E-0098)
; 9 call sites from 5 routines (e.g. BreedMenu_Case04_BreedMenu_WaitLinkMode, BreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D, BreedMenu_Case04_DrawBottomBoxForLinkAndSetScreenSubStep, BreedMenu_Case04_CopyFromBankWaitVRAM_Case3E, ...)
; reads: wLinkMode, wScreenState, wScreenStep
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
; points at: sSavedPlayerName
BreedMenu_WaitLinkMode::
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
    jr nz, Jump_015_63F5

Jump_015_63ED::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_015_63F5::
    ld a, [wScreenState]
    cp a, $04
    jr nz, Jump_015_63ED
    ld a, [wScreenStep]
    cp a, $37
    jr nc, Jump_015_63ED

; with SRAM disabled draws sprite part $0090 at ($88, $28) (Func_01D_6A3F, C = 1) (E-0124)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_WriteRAMG2AndRAMB, GameMode5_Update_Case07_Sub01_WaitPickCount)
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
    farcall DrawSpritePart9000At88_28_Sub01
    ret

; outside link battles only sets wD782 = 2; otherwise copies the row Data_015_727D when wD782 is set, sets wD782 = 2 and draws the box at scroll + $1CC (E-0124)
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_DrawBottomBoxForLinkAndSetScreenSubStep, KeyAppraisalMenu_Case03_DrawBottomBoxForLinkAndSetScreenSubStep, RunLinkSession8Exchange_Case01_Sub01_Table4_Case03)
; reads: wLinkMode, wScreenSubStep
; writes: wScreenSubStep
DrawBottomBoxForLinkAndSetScreenSubStep::
Func_015_642D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, Jump_015_6439
    ld a, $02
    ld [wScreenSubStep], a
    ret

Jump_015_6439::
    ld a, [wScreenSubStep]
    and a, a
    jr nz, Jump_015_6441
    jr Jump_015_644D

Jump_015_6441::
    ld de, TileRect_15_727D
    ld hl, wWindowTileBuffer + $C8
    ld bc, $1401
    call CopyRectTo20ByteRows_Bank15

Jump_015_644D::
    ld a, $02
    ld [wScreenSubStep], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; copies the 20 x 11 rectangle Data_015_70C5 into wC364, then DrawScreenBufferRect_Bank15 (20 x 13 at the scroll origin) (E-0119)
; 3 call sites from 3 routines (e.g. DrawRect70C5IfLinkModeAndStep, KeyAppraisalMenu_Case03_ToCopyRect70C5ToWC364AndDrawAndStep, RunLinkSession8Exchange_Case01_Sub01_Table4_Case01)
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
    jr nz, Jump_015_6494
    bit 7, a
    jr nz, Jump_015_64C2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_015_64DC
    bit 1, a
    jp nz, Jump_015_6511
    call BlinkCursorGridCursorY_Bank15
    ret

Jump_015_6494::
    call DrawBlankTileC3_6542
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_015_64AB
    ld a, $02
    ld [wGridCursorX], a
    call BlinkCursorGridCursorY_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_64AB::
    dec a

Jump_015_64AC::
    ld [wGridCursorX], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call BlinkCursorGridCursorY_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_64C2::
    call DrawBlankTileC3_6542
    ld a, [wGridCursorX]
    cp a, $02
    jr c, Jump_015_64D9
    xor a, a
    ld [wGridCursorX], a
    call BlinkCursorGridCursorY_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_64D9::
    inc a
    jr Jump_015_64AC

Jump_015_64DC::
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtGridCursorXEntry_Bank15
    ld c, $03
    ld hl, Data_015_732D
    call BlankWordTableTargets
    ld a, [wGridCursorX]
    cp a, $02
    jr z, Jump_015_6511
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

Jump_015_6511::
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
    jr c, Jump_015_653E
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, Jump_015_653E
    cp a, $18
    jr c, DrawBlankTileC3_6542
    xor a, a
    ld [wGridCursorY], a

Jump_015_653E::
    ld b, $BB
    jr Jump_015_6548

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wGridCursorX
DrawBlankTileC3_6542::
Func_015_6542:: ; address name
    ld b, $C3
    jr Jump_015_6548

; B = $BC, then writes B at the scroll position + Data_015_6566[wD786] (E-0124)
; 1 call site from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wGridCursorX
DrawArrowTileBCAtGridCursorXEntry_Bank15::
Func_015_6546:: ; address name
    ld b, $BC

Jump_015_6548::
    ld a, [wGridCursorX]
    add a, a
    ld hl, Data_015_6566
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
Data_015_6566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; only called from BreedMenu_ReturnToMap_Case10 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_ReturnToMap_FillTilesBxC)
; reads: hTemp0, rSTAT, wPartyCount
; writes: rRAMG2, rRAMB
; points at: wListEntries
BreedMenu_ReturnToMap_Case10_LoadSRAMRecordByte::
Func_015_656C:: ; address name
    ld b, $00

Jump_015_656E::
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
    ld c, $00
    ld b, $01
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $02
    jr nz, Jump_015_65AD
    pop hl
    pop bc
    push bc
    di

Jump_015_659B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_015_659B
    ld a, b
    add a, $E1
    ld [hl], a
    ei
    ld a, c
    add_a_to_hl
    push hl

Jump_015_65AD::
    pop hl
    pop bc
    inc b
    ld a, [wPartyCount]
    cp a, b
    jr nz, Jump_015_656E
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 45 call sites from 37 routines (e.g. BreedMenu_Setup_CopyRectTo20ByteRows_Bank15, BreedMenu_Case04_DrawPair72A9And72C5AndStep, BreedMenu_Case04_DrawRect70C5IfLinkModeAndStep, DrawBottomBoxForLinkAndSetScreenSubStep, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank15::
Func_015_65B7:: ; address name
    push hl
    push bc

Jump_015_65B9::
    push bc
    push hl

Jump_015_65BB::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_015_65BB
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_015_65B9
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

Jump_015_65DD::
    push bc
    push hl

Jump_015_65DF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_65DF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_015_65DD
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 unchanged when wStringIndex is $10-$12; otherwise HL + $1C1, replaced by $99C1 when that is $9B61 (E-0062)
; 41 call sites from 35 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_Setup_CopyRectTo20ByteRows_Bank15, BreedMenu_Case04_BGMapAddressAtScroll_Bank15_Case3B, BreedMenu_Case04_StoreBAtWordTableEntry_Bank15, ...)
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
    jr z, Jump_015_6634
    cp a, $11
    jr z, Jump_015_6634
    cp a, $12
    jr z, Jump_015_6634
    ld a, l
    add a, $C1
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a
    ld a, [wTextCursorHi]
    cp a, $9B
    jr nz, Jump_015_6634
    ld a, [wTextCursorLo]
    cp a, $61
    jr nz, Jump_015_6634
    ld a, $C1
    ld [wTextCursorLo], a
    ld a, $99
    ld [wTextCursorHi], a

Jump_015_6634::
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
; 45 call sites from 39 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, DrawArrowTileBCAtGridCursorXEntry_Bank15, BreedMenu_Setup_CopyRectTo20ByteRows_Bank15, BreedMenu_Case04_BGMapAddressAtScroll_Bank15_Case3B, ...)
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
; 9 call sites from 9 routines (e.g. TenTimesTemp0PlusTenToDigits, DrawGoldBoxAndStep_Bank15, EggServiceMenu_Case01_Number24ToPackedBCD, EggServiceMenu_Case05_UpdatePagedListCursor, ...)
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

Jump_015_66A4::
    ld a, [hl]
    and a, a
    jr nz, Jump_015_66AE
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, Jump_015_66A4

Jump_015_66AE::
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 6 call sites from 5 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_Init, Func_015_6791, BreedMenu_ReturnToMap_Shared01_CopyBytesDEToHL_Bank15, ...)
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
; 6 call sites from 5 routines (e.g. CloseBreedMenu_CopyBytesDEToHL_Bank15, BreedMenu_Init, Func_015_6791, BreedMenu_ReturnToMap_Shared01_CopyLow3BitsToWRAMBank2_Bank15, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank15::
Func_015_66B8:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_015_66BC::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_66BC
    xor a, a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 19 call sites from 17 routines (e.g. BlankWordTableTargets, BreedMenu_Case04_StoreBAtWordTableEntry_Bank15, BreedMenu_Case04_UpdatePagedListCursor_Case1E, BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case0A, ...)
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

; only called from BreedMenu_Case04_Case13 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_Case04_Case13)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
BreedMenu_Case04_Case13_Sub01::
Func_015_66D8:: ; address name
    ld hl, Data_015_731B
    ld a, $9D
    jr Jump_015_66E4

; only called from BreedMenu_Case05_Case00 (E-0047)
; 1 call site from 1 routine (e.g. BreedMenu_Case05_Case00)
; reads: wGlyphListStart, wArg1, wArg2, wGlyphListPos
; writes: wArg1, wArg2, wGlyphListPos, wGlyphListStart
; points at: wScreenStep
BreedMenu_Case05_Case00_Sub01::
Func_015_66DF:: ; address name
    ld hl, Data_015_731B
    ld a, $9C

Jump_015_66E4::
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    xor a, a
    ld [wGlyphListPos], a

Jump_015_66EF::
    push hl
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_015_6734
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
    jr c, Jump_015_66EF
    ret

Jump_015_6734::
    pop de
    pop hl
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wScreenStep
    inc [hl]
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (E-0121)
; 2 call sites from 2 routines (e.g. BreedMenu_Case04_ListRecordsInUseWithByte6EClear, BreedMenu_Case05_ClampRecordListPageCursor4_Case03)
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
; 4 call sites from 4 routines (e.g. BreedMenu_Case04_ListRecordsInUseWithByte6EClear, BreedMenu_Case05_ClampRecordListPageCursor4_Case03, BreedMenu_Case05_ClampRecordListPageCursor4, BreedMenu_Case11_ListRecordsInUseWithByte6EClear)
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
; 2 call sites from 2 routines (e.g. ShowSaveFileInfoWindow, BreedMenu_Case05_Case00_Sub01)
; reads: rSTAT
CopyTileBytesToVRAM_Bank15::
Func_015_6780:: ; address name
    ld c, $10

Jump_015_6782::
    di

Jump_015_6783::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_015_6783
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_015_6782
    ret

; 9 call sites from 8 routines (e.g. BreedMenu_Case04_BGMapAddressAtScroll_Bank15, BreedMenu_Case04_DrawGoldBoxAndStep_Bank15, BreedMenu_Case04_CopyRectTo20ByteRows_Bank15_Case09, BreedMenu_Case04_CopyRectTo20ByteRows_Bank15_Case00, ...)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
Func_015_6791::
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
    jr z, Jump_015_67D2
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

Jump_015_67D2::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_67E1
    inc d

Jump_015_67E1::
    dec c
    jr nz, Func_015_6791
    ret

; HL = table of addresses, C = count: stores tile $C3 at the address in each of the first C entries (StoreBAtWordTableEntry_Bank15) (E-0074)
; 9 call sites from 9 routines (e.g. HandleThreeOptionMenuInput_15, BreedMenu_Case04_BlankWordTableTargets_Case25, BreedMenu_Case04_BlankWordTableTargets_Case12, BreedMenu_Case04_BlankWordTableTargets_Case10, ...)
BlankWordTableTargets::
Func_015_67E5:: ; address name
    ld a, c
    ld b, a
    ld c, $00

Jump_015_67E9::
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
    jr c, Jump_015_67E9
    ret

; TenTimesTemp0PlusTen, then converts it to packed BCD (Number24ToPackedBCD) and unpacks the digits to wD7F1 onward (E-0117)
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_TenTimesTemp0PlusTenToDigits, BreedMenu_Case05_UpdatePagedListCursor, BreedMenu_Case0F_SetArg5ToListEntriesCell4)
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
; 5 call sites from 5 routines (e.g. BreedMenu_Case04_TenTimesTemp0PlusTen, BreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D_Case3F, TenTimesTemp0PlusTenToDigits, BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10, ...)
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
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_TenTimesTemp0PlusTenToDigits, BreedMenu_Case05_UpdatePagedListCursor, BreedMenu_Case0F_SetArg5ToListEntriesCell4)
; points at: wArg4, wTextBuf0
BreedMenu_Shared02::
Func_015_6822:: ; address name
    ld hl, wArg4
    ld de, wTextBuf0
    ld c, $00

Jump_015_682A::
    ld a, [hl]
    cp a, $E3
    jr z, Jump_015_6831
    ld [de], a
    inc de

Jump_015_6831::
    inc hl
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_015_682A
    ld a, $F0
    ld [de], a
    ret

; wGold -= the 24-bit amount wD7F3:wD7F2:wD7F1 (no floor; callers check first, for example with IsAmountInArg1AboveGold) (E-0106)
; 9 call sites from 9 routines (e.g. BreedMenu_Case04_TenTimesTemp0PlusTen, BreedMenu_Case05_SetArg5ToListEntriesCell4_Case10, ArenaMenu_SubtractArg1AmountFromGold, ArenaMenu_SubtractArg1AmountFromGold_SubtractArg1AmountFromGold, ...)
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
; 5 call sites from 4 routines (e.g. DrawListEntriesCell5IconAndLevelAndStep, BreedMenu_ReturnToMap_SetArg5ToListEntriesCell5, BreedMenu_Case04_SetArg5ToListEntriesCell5, BreedMenu_Case12_LoadFamilyIconTileForRecordB_Bank15)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank15::
Func_015_6866:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
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
; 5 call sites from 5 routines (e.g. DrawListEntriesCell5IconAndLevelAndStep, BreedMenu_Case04_SetArg5ToListEntriesCell5, NpcBreedMenu_Case04_SetArg5ToListEntriesCell5, RunLinkSession5Exchange_Case01_Sub01_Case04_SetArg5ToListEntriesCell5, ...)
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
    ld c, $56
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
; 7 call sites from 7 routines (e.g. BreedMenu_Case04_TestBitInFieldAtArg3, DrawRecordField0EMarkAndField56Digits, MedalPrizeMenu_Case02, DrawArenaWinsLoCountBoxAndStep, ...)
; reads: wDigits
; writes: wDigits
BlankLeadingZeroDigits_F_Bank15::
Func_015_68DC:: ; address name
    ld a, [wDigits]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [wDigits + $1], a

Jump_015_68F2::
    ret

; TestBitInFieldAtArg3, then ORs its mask into the byte, setting bit wD7F1/wD7F2 of the field at wD7F3/wD7F4 (E-0114)
; 5 call sites from 5 routines (e.g. BreedMenu_Case04_BreedMenu_WaitLinkMode, RunLinkSession4ScreenState_Case08_Case04_ComputeBreedingChild, NpcBreedMenu_Case04_Case17, StoreReceivedRecordIntoSRAM, ...)
SetBitInFieldAtArg3::
Func_015_68F3:: ; address name
    call TestBitInFieldAtArg3
    ld a, [hl]
    or a, b
    ld [hl], a
    ret

; index = the word wD7F1/wD7F2, field = the address in wD7F3/wD7F4: wD7F5 = $FF when bit index of the field is set (bit order $80 first within each byte), else 0 (E-0074)
; 12 call sites from 9 routines (e.g. SetBitInFieldAtArg3, BreedMenu_Case04_TestBitInFieldAtArg3_Case28, BreedMenu_Case04_TestBitInFieldAtArg3, BreedMenu_Case04_ComputeBreedingChild, ...)
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
    ld hl, Data_015_6937
    add_a_to_hl
    ld a, [hl]
    ld b, a
    pop hl
    ld a, [hl]
    and a, b
    jr nz, Jump_015_6931
    xor a, a
    ld [wArg5], a
    ret

Jump_015_6931::
    ld a, $FF
    ld [wArg5], a
    ret

; address loaded by TestBitInFieldAtArg3
Data_015_6937:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

; only called from routines of BreedMenu (E-0098)
; 2 call sites from 2 routines (e.g. BreedMenu_Case04_LoadRecordSelectedRecordByte0EBit0, BreedMenu_Case12_LoadRecordSelectedRecordByte0EBit0)
; reads: wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, wListEntries2, sRecords, wArg1
BreedMenu_Shared03::
Func_015_693F:: ; address name
    ld hl, wListEntries
    ld b, $1E

Jump_015_6944::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_6944
    ld hl, wListEntries2
    ld b, $1E

Jump_015_694E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_694E
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

Jump_015_696D::
    ld a, [de]
    cp a, $01
    jr z, Jump_015_6978
    cp a, $02
    jr z, Jump_015_6978
    jr Jump_015_69AA

Jump_015_6978::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_015_6980
    inc d

Jump_015_6980::
    ld a, [de]
    and a, a
    jr nz, Jump_015_69A2
    pop de
    push de
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_015_698D
    inc d

Jump_015_698D::
    ld a, [de]
    and a, $01
    push hl
    ld hl, wArg1
    cp a, [hl]
    jr nz, Jump_015_699B
    pop hl
    pop de
    jr Jump_015_69AA

Jump_015_699B::
    pop hl
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_015_69AA

Jump_015_69A2::
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

Jump_015_69AA::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_015_69B1
    inc d

Jump_015_69B1::
    inc b
    ld a, b
    cp a, $1E
    jr c, Jump_015_696D
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; with SRAM bank 0 enabled: wD7F1 = bit 0 of byte $0E of record wD7B4 (LoadSRAMRecordByte) (E-0119)
; 2 call sites from 2 routines (e.g. BreedMenu_Case04_LoadRecordSelectedRecordByte0EBit0, BreedMenu_Case12_LoadRecordSelectedRecordByte0EBit0)
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
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_ToClearThreeTileRowsAndStep, BreedMenu_Case04_ClearThreeTileRows, BreedMenu_Case12_ClearThreeTileRows)
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
; 2 call sites from 2 routines (e.g. BreedMenu_Case04_PrepareWCF8BCountersAndRequestScript, BreedMenu_Case04_ClearTileAreas2700_1750_17D0)
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
; 1 call site from 1 routine (e.g. BreedMenu_Case04_ClearTileAreas1240_1700_14E0)
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
    ld c, $01
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
    ld c, $0B
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
; 2 call sites from 2 routines (e.g. BreedMenu_Case04_BreedMenu_SetArg5ToListEntriesCell5, BreedMenu_Case12_DrawRecordNameAndSpeciesNameTiles)
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

Jump_015_6A9C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6A9C
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

Jump_015_6ABF::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6ABF
    xor a, a
    ld [rRAMG2], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 4 call sites from 4 routines (e.g. BreedMenu_Case04_TestBitInFieldAtArg3, DrawRecordNameAndSpeciesName, BreedMenu_Case0B_CopyMonsterNameToBuffer_B15, BreedMenu_Case04_ComputeBreedingChild)
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
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_ShowSaveFileInfoWindow, KeyAppraisalMenu_Case03_ShowSaveFileInfoWindow, RunLinkSession8Exchange_Case01_Sub01_Table4_Case02)
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
    jr z, Jump_015_6B6B
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

Jump_015_6B6B::
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
    jr z, Jump_015_6BA1
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

Jump_015_6BA1::
    ld hl, sSavedPlayerName
    ld de, wNameGlyphBuf
    ld c, $0A

Jump_015_6BA9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_6BB4
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_015_6BA9

Jump_015_6BB4::
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

Jump_015_6C0C::
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
    ld hl, Data_015_6E0E
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
    jr c, Jump_015_6C0C
    ld c, $00

Jump_015_6C3F::
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
    jr c, Jump_015_6C3F
    ld c, $00

Jump_015_6C6F::
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
    ld hl, Data_015_6E08
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wDigits + $1]
    and a, a
    jr z, Jump_015_6CB4
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl], a
    ei
    inc hl

Jump_015_6CB4::
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
    jr c, Jump_015_6C6F
    ld c, $00

Jump_015_6CC8::
    push hl
    push bc
    ld hl, Data_015_6DD0
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
    jr c, Jump_015_6CC8
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
    jr nz, Jump_015_6D9A
    ld hl, sSavedMapType
    ld a, [hl]
    bit 7, a
    jr z, Jump_015_6D98
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
    jr Jump_015_6DB4

Jump_015_6D98::
    ld a, $0D

Jump_015_6D9A::
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

Jump_015_6DB4::
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
Data_015_6DD0:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
Data_015_6E08:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $C3, $D2, $C3, $FA, $C3

; address loaded by ShowSaveFileInfoWindow
Data_015_6E0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_BreedMenu_WaitLinkMode, NpcBreedMenu_Case04_Case17, RunScreenStateWhenNotFading_F1_Case04_WaitTextFlags_Case1E)
; reads: wCounterPtr0Hi, wCounterPtr0Lo, wCounterArg0, wCounterPtr1Hi, wCounterPtr1Lo, wCounterArg1
; points at: wCounterPtr0Lo, wCounterPtr1Lo
IncrementTwoCountersCappedAt99::
Func_015_6E64:: ; address name
    ld a, [wCounterPtr0Hi]
    cp a, $FF
    jr z, Jump_015_6E86
    ld b, a
    ld a, [wCounterPtr0Lo]
    or a, b
    and a, a
    jr z, Jump_015_6E86
    ld de, wCounterPtr0Lo
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    jr nc, Jump_015_6E86
    inc a
    ld [hl-], a
    ld a, [wCounterArg0]
    ld [hl], a

Jump_015_6E86::
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
; 3 call sites from 3 routines (e.g. BreedMenu_Case04_PrepareWCF8BCountersAndRequestScript, NpcBreedMenu_Case04_PrepareWCF8BCountersAndRequestScript, RunScreenStateWhenNotFading_F1_Case04_PrepareWCF8BCountersAndRequestScript)
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
    jr nz, Jump_015_6EDF
    ld de, wCounterPtr1Lo
    ld a, [wRecordBufB + $A4]
    and a, a
    call nz, PrepareWCF8BCountersAndRequestScript_WriteTemp0AndArg1

Jump_015_6EDF::
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

Jump_015_6F07::
    ld a, [hl+]
    cp a, c
    jr z, Jump_015_6F14
    and a, a
    jr z, Jump_015_6F1B

Jump_015_6F0E::
    inc hl
    dec b
    jr nz, Jump_015_6F07
    jr Jump_015_6F5C

Jump_015_6F14::
    ld a, [hl]
    cp a, $63
    jr c, Jump_015_6F45
    jr Jump_015_6F5C

Jump_015_6F1B::
    push hl
    ld hl, wCounterPtr0Lo
    ld a, l
    cp a, e
    jr nz, Jump_015_6F2A
    ld a, h
    cp a, d
    jr nz, Jump_015_6F2A
    pop hl
    jr Jump_015_6F45

Jump_015_6F2A::
    ld a, [wCounterArg0]
    ld l, a
    ldh a, [hTemp0]
    cp a, l
    jr z, Jump_015_6F44
    pop hl
    push hl
    ld a, [wCounterPtr0Lo]
    cp a, l
    jr nz, Jump_015_6F44
    ld a, [wCounterPtr0Hi]
    cp a, h
    jr nz, Jump_015_6F44
    pop hl
    jr Jump_015_6F0E

Jump_015_6F44::
    pop hl

Jump_015_6F45::
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
    jr Jump_015_6F56

Jump_015_6F56::
    ld a, $01
    ld [wArg1], a
    ret

Jump_015_6F5C::
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

; address loaded by BreedMenu_Case04_Case13_Sub01, BreedMenu_Case05_Case00_Sub01
Data_015_731B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $FF, $FF

; address loaded by BreedMenu_Case04_DrawPair72A9And72C5AndStep_Case0A, BreedMenu_Case04_StoreBAtWordTableEntry_Bank15, BreedMenu_Case05_ListRecordsInUseWithByte6ESet, BreedMenu_Case04_BlankWordTableTargets and 4 more
Data_015_732D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3

; address loaded by BreedMenu_Case05_ClampRecordListPageCursor4_Case03, BreedMenu_Case05_UpdatePagedListCursor, BreedMenu_Case0F_StoreBAtWordTableEntry_Bank15
Data_015_7333:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

; address loaded by BreedMenu_ReturnToMap_SRAMRecordAddress, BreedMenu_ReturnToMap_CopyFromBankWaitVRAM_CopyFromBankWaitVRAM_Case19
Data_015_733B:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

; address loaded by BreedMenu_Case04_DrawScreenBufferAtScrollAndIncScreenStep, BreedMenu_Case04_UpdatePagedListCursor, BreedMenu_Case04_BlankWordTableTargets_Case10, BreedMenu_Case04_BlankWordTableTargets_Case12 and 6 more
Data_015_73A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
Data_015_7471:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
Data_015_7505:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 4
Data_015_7511:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

; address loaded by BreedMenu_Case04_ComputeBreedingChild, BreedMenu_Case04_TestBitInFieldAtArg3
Data_015_75C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
; 2 call sites from 2 routines (e.g. HibernateMenu_Case05_Case02, HibernateMenu_Case04_HibernateMenu_ClampRecordListPageCursor5)
; writes: wListCount, rRAMG2, rRAMB
; points at: wListEntries, sCompactRecords, sRecords
HibernateMenu_Shared06::
Func_015_77AC:: ; address name
    ld hl, wListEntries
    ld b, $1E

Jump_015_77B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_77B1
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

Jump_015_77CD::
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77D5
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77D5::
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_015_77DC
    inc d

Jump_015_77DC::
    inc b
    ld a, b
    cp a, $1D
    jr c, Jump_015_77CD
    ld de, sRecords
    ld a, $01
    ld [rRAMB], a
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77F2
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77F2::
    ld a, c
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    ret

; only called from HibernateMenu_Case05_Case03 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_Case05_Case03)
; reads: wListPageIndex, wListLastRow, wListCount, wScreenStep, wListPages
; writes: rRAMG2, rRAMB, wArg1, wArg2, wArg3, wArg4, wNameGlyphBuf, wScreenStep
; points at: wListEntries, sCompactRecords, sRecords
HibernateMenu_Case05_Case03_Sub01::
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

Jump_015_7817::
    ld a, [wListLastRow]
    cp a, $04
    jr c, Jump_015_7823
    ld a, [wListCount]
    jr Jump_015_7832

Jump_015_7823::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_015_782F
    ld a, [wListCount]
    jr Jump_015_7832

Jump_015_782F::
    ld a, [wListCount]

Jump_015_7832::
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
    jr nc, Jump_015_78AF
    push hl
    push bc
    xor a, a
    ld [wArg1], a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_015_7864
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    ld [wArg2], a

Jump_015_785A::
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    jr Jump_015_7876

Jump_015_7864::
    ld a, $01
    ld [wArg2], a
    ld hl, sRecords
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    jr Jump_015_785A

Jump_015_7876::
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, Jump_015_788D
    call HibernateMenu_Case05_Case03_Sub01_GlyphCopyArgsForA_Bank15
    jr Jump_015_789F

Jump_015_788D::
    ld a, c
    sla a
    ld hl, Data_015_78BB
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call CopyGlyphTilesToVRAM

Jump_015_789F::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_015_78AF
    ld a, c
    cp a, $05
    jp c, Jump_015_7817

Jump_015_78AF::
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by HibernateMenu_Case05_Case03_Sub01
Data_015_78BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; only called from HibernateMenu_Case05_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_Case05_Case03_Sub01)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
HibernateMenu_Case05_Case03_Sub01_GlyphCopyArgsForA_Bank15::
Func_015_78C5:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

Jump_015_78CF::
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_015_790E
    cp a, $8D
    jr z, Jump_015_78EE
    cp a, $8E
    jr z, Jump_015_78EE
    call GlyphCopyArgsForA_Bank15
    call CopyFromBankWaitVRAM
    jr Jump_015_78FD

Jump_015_78EE::
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    call GlyphCopyArgsForA_Bank15
    call OrFromBankWaitVRAM

Jump_015_78FD::
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr Jump_015_78CF

Jump_015_790E::
    pop hl
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; DE = $4010 + 16 * A (the glyph's tile), HL = the VRAM address from Data_015_794A + 2 * wD785, B = $1F (bank), C = 16 (bytes) (E-0121)
; 2 call sites from 1 routine (e.g. HibernateMenu_Case05_Case03_Sub01_GlyphCopyArgsForA_Bank15)
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
    ld hl, Data_015_794A
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
Data_015_794A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; wD09D = the family nibble of the record selected by wD7F1 (Func_015_7A43), wD09E = $C7, then LoadFamilyIconTileForWorkBuf (E-0122)
; 1 call site from 1 routine (e.g. HibernateMenu_Case05_SetArg5ToListEntriesCell5)
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

; only called from HibernateMenu_Case05_Case04 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_Case05_SetArg5ToListEntriesCell5)
; reads: wArg1, wDigits
; writes: rRAMG2, wWindowTileBuffer, wArg1, wArg3, wArg5, wArg7, wArg2, wArg4, ...
; points at: wArg1
HibernateMenu_Case05_Case04_RecordAddressWithBank1Slot1D::
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

Jump_015_79F5::
    push bc
    ld a, c
    sla a
    ld de, wArg1
    add a, e
    ld e, a
    jr nc, Jump_015_7A01
    inc d

Jump_015_7A01::
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
    ld hl, Data_015_7A3B
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
    jr c, Jump_015_79F5
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by HibernateMenu_Case05_Case04_RecordAddressWithBank1Slot1D
Data_015_7A3B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; HL = sB356 + $6F * B in SRAM bank 0, except record $1D, which is at sA000 in SRAM bank 1 (E-0122)
; 3 call sites from 3 routines (e.g. HibernateMenu_Case05_Case04_RecordAddressWithBank1Slot1D, LoadFamilyIconTileForArg1Record, HibernateMenu_Case05_Case06_RecordAddressWithBank1Slot1D)
; writes: rRAMB
; points at: sCompactRecords, sRecords
RecordAddressWithBank1Slot1D::
Func_015_7A43:: ; address name
    ld a, b
    cp a, $1D
    jr z, Jump_015_7A56
    ld c, $6F
    call Multiply8
    ld de, sCompactRecords
    add hl, de
    xor a, a
    ld [rRAMB], a
    ret

Jump_015_7A56::
    ld hl, sRecords
    ld a, $01
    ld [rRAMB], a
    ret

; only called from HibernateMenu_Case05_Case06 (E-0047)
; 1 call site from 1 routine (e.g. HibernateMenu_Case05_SetArg5ToListEntriesCell5_Case06)
; reads: wArg1, wDataBank
; writes: rRAMG2, wArg2, wArg1, wArg3, wArg4, wNameGlyphBuf, wDataBank
; points at: wNameGlyphBuf
HibernateMenu_Case05_Case06_RecordAddressWithBank1Slot1D::
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
; 2 call sites from 1 routine (e.g. HibernateMenu_Case05_Case04_RecordAddressWithBank1Slot1D)
; reads: wDigits
; writes: wDigits
BlankLeadingZeroDigits_F_Bank15_7ADB::
Func_015_7ADB:: ; address name
    ld a, [wDigits]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [wDigits + $1], a

Jump_015_7AF1::
    ret
    ds $50E, $00
