; ROM bank $15: the breeding menu
; The annotated listing of this bank is build/listing/bank15.asm.

SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

; Script command EE (ScriptCommandEE), and called by other menus as they close: by wScreenList runs
; CloseBreedMenu_RestoreScreen (restores the screen saved in the window buffer), _RestoreGlyphs
; (field glyph tiles back, menu state cleared), _BlankNameTiles and _RedrawNamesAndFinish (redraws
; the name tiles, clears wMessageMode and the menu state and puts the name of the player in
; wTextBuf0). (C1, E-0377)
; implements script command type EE (SCRIPT_BREED_CLOSE): ends the breeding (and medal prize)
; session and clears wMessageMode; reached through ScriptCommandEE in bank $10 (E-0038, E-0244)
CloseBreedMenu::
    ld a, [wScreenList]
    jumptable
    dw CloseBreedMenu_RestoreScreen
    dw CloseBreedMenu_RestoreGlyphs
    dw CloseBreedMenu_BlankNameTiles
    dw CloseBreedMenu_RedrawNamesAndFinish

; Closing the breeding menu, step 0: restores the screen saved in the window buffer (tiles and GBC
; attributes) and redraws it. (C1, E-0357)
CloseBreedMenu_RestoreScreen::
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
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; Closing the breeding menu, step 1: copies the field glyph tiles back, clears the menu state and
; puts the text window back in place. (C1, E-0357)
CloseBreedMenu_RestoreGlyphs::
    ld hl, CloseBreedMenu_RestoreGlyphs_TileCopyDestList
    ld de, CloseBreedMenu_RestoreGlyphs_TileCopySrcList
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

; Closing the breeding menu, step 2: blanks the name tiles and reloads three frame tiles. (C1,
; E-0357)
CloseBreedMenu_BlankNameTiles::
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
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
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

; Closing the breeding menu, step 3: redraws the record list name tiles and the party's tiles,
; clears message mode and the $6F bytes of menu state, refills wTextBuf0 with the player's name and
; resets the text window. (C1, E-0357)
CloseBreedMenu_RedrawNamesAndFinish::
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

; Script command ED (ScriptCommandED), breeding; other menus (NpcBreedMenu, EggServiceMenu, the link
; sessions) call it for its shared steps. Runs the state wScreenState: 0 _Init, 1 _Setup, 2
; _OptionCursor (Breed / Hatch / Exit), 3 _DoOption, 4 _ChooseParents, 5 _ChooseEgg, 6 _NameEntry, 7
; _ReturnToMap, 8 _TalkEvent17ThenNameEntry, 9 _CopyToChildThenTalkEvent16, $0A _TalkEvent15, $0B
; _RestoreScreen, $0C _RunStatsScreen, $0D-$0E _RunStatsScreenAgain, $0F _RedrawListScreen, $10
; _ClearListMarks, $11 _ListMonsters and $12 _ShowSelectedRecord. (C1, E-0377)
; implements script command type ED (SCRIPT_BREED): breeding: 'Which will be the base monster?',
; 'And what will its mate be?' (mode 5, bank $1B strings); reached through ScriptCommandED in bank
; $10 (E-0038, E-0244) (C2 from E-0328: started by its script, it shows Breed / Hatch / Exit, takes
; a base and a mate, removes both parents' records and adds the hatched, named child)
BreedMenu::
    ld a, [wScreenState]
    jumptable
    dw BreedMenu_Init
    dw BreedMenu_Setup
    dw BreedMenu_OptionCursor
    dw BreedMenu_DoOption
    dw BreedMenu_ChooseParents
    dw BreedMenu_ChooseEgg
    dw BreedMenu_NameEntry
    dw BreedMenu_ReturnToMap
    dw BreedMenu_TalkEvent17ThenNameEntry
    dw BreedMenu_CopyToChildThenTalkEvent16
    dw BreedMenu_TalkEvent15
    dw BreedMenu_RestoreScreen
    dw BreedMenu_RunStatsScreen
    dw BreedMenu_RunStatsScreenAgain
    dw BreedMenu_RunStatsScreenAgain
    dw BreedMenu_RedrawListScreen
    dw BreedMenu_ClearListMarks
    dw BreedMenu_ListMonsters
    dw BreedMenu_ShowSelectedRecord

; BreedMenu state 0: clears the $6F bytes from wScreenState, copies $104 bytes of wScreenTileBuffer
; to wWindowTileBuffer + $64 (and on CGB the attributes from wScreenAttrBuffer to wWindowAttrBuffer
; + $64, CopyLow3BitsToWRAMBank2_Bank15), sets wMessageMode = 5 and hSpriteHideTile = $70, moves
; wScreenState to 1 and requests script $80 with wScriptCommandType 0. (C2, E-0377)
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

; BreedMenu state 1, by wScreenStep: 0 DrawPairAndStep_2 (glyph tiles), 1 DrawGoldBoxAndStep_Bank15
; (the gold box), 2 BreedMenu_Setup_DrawOptionBox (the option box and screen, then state 2).
; BreedMenu_RestoreScreen_Finish also returns here. (C1, E-0377)
; draws the two boxes and the gold box (E-0277)
BreedMenu_Setup::
    ld a, [wScreenStep]
    jumptable
    dw DrawPairAndStep_2
    dw DrawGoldBoxAndStep_Bank15
    dw BreedMenu_Setup_DrawOptionBox

; Copies the glyph tiles of the pair of lists CloseBreedMenu_RestoreGlyphs_TileCopyDestList /
; DrawPairAndStep_2_TileCopySrcList from bank $1F (CopyGlyphTileListFromBank1F_Bank15), then adds 1
; to wScreenStep. A step of BreedMenu_Setup, BreedMenu_ShowSelectedRecord and the redraw steps of
; BreedMenu_ChooseParents. (C1, E-0377)
; runs CopyGlyphTileListFromBank1F_Bank15 for CloseBreedMenu_RestoreGlyphs_TileCopyDestList and
; DrawPairAndStep_2_TileCopySrcList, then wScreenStep += 1 (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was DrawPairAndStep_2)
DrawPairAndStep_2::
    ld hl, CloseBreedMenu_RestoreGlyphs_TileCopyDestList
    ld de, DrawPairAndStep_2_TileCopySrcList
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Copies the 8 x 3 gold box DrawGoldBoxAndStep_Bank15_TileRect to wWindowTileBuffer + $70, converts
; the gold (wGoldLo-wGoldHi through wDigits, Number24ToPackedBCD, UnpackBCDToDigitsArg1) and writes
; its last five digits (wArg3-wArg7) as tiles $E0 + digit at wWindowTileBuffer + $86, leading zeros
; as the blank tile $C3; then adds 1 to wScreenStep. (C2, E-0377)
; copies box DrawGoldBoxAndStep_Bank15_TileRect to wWindowTileBuffer + $70 and writes the gold as
; five digit tiles at wWindowTileBuffer + $86, then wScreenStep += 1 (E-0125)
DrawGoldBoxAndStep_Bank15::
    ld de, DrawGoldBoxAndStep_Bank15_TileRect
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
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

; Breeding set-up, step 2: draws the option box and the screen, then goes to the options (next
; state). (C1, E-0357)
BreedMenu_Setup_DrawOptionBox::
    ld de, BreedMenu_Setup_DrawOptionBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Breeding menu, state 2: the three-option cursor (Breed / Hatch / Exit,
; HandleThreeOptionMenuInput_15). (C1, E-0357)
BreedMenu_OptionCursor::
    call HandleThreeOptionMenuInput_15
    ret

; Breeding menu, state 3: acts on the option in wGridCursorX. Option 0 only adds 1 to wScreenState
; (no egg list, no script). Any other option lists the eggs (ListRecordsInUseEggs): with
; wRecordsFlagged 0 it sets wTwoChoiceCursor 1 and wScreenState 2 (back to the options); otherwise
; wTwoChoiceCursor 0 and wScreenState + 2. Both of those cases clear wScriptCommandType and set
; wScriptStartRequest to $80. (C2, E-0384)
BreedMenu_DoOption::
    ld a, [wGridCursorX]
    and a
    jr z, .check_screen_state
    jr .call_list_records_in_use_eggs

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

.call_list_records_in_use_eggs:
    farcall ListRecordsInUseEggs
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

; BreedMenu state 4, by wScreenStep (66 steps): the breeding of two farm monsters. Steps 0-8 list
; the monsters and take the base, 17 checks it, 21-30 list and take the mate, 28 computes the child
; (BreedMenu_ChooseParents_ComputeChild), 31-37 a yes/no, 38-41 check the mate and the child and
; start the counting script, 42-52 the link-session save prompt and redraw (53 returns to the
; options), 54 breeds (BreedMenu_ChooseParents_Breed), and 60-65 ask for and pay the fee
; (BreedMenu_ChooseParents_WriteFee, _ReadFeeAnswer, _FeeRefused, _PayAndMakeEgg, which goes to
; state 8). B returns to the options through BreedMenu_ChooseParents_BackToOptions. (C1, E-0377)
; BreedMenu screen state 4, by wScreenStep: lists the records in use, takes two monsters from paged
; lists, then ComputeBreedingChild and the name-entry state
BreedMenu_ChooseParents::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_ChooseParents_Init
    dw BreedMenu_ChooseParents_ClearList
    dw BreedMenu_ChooseParents_ListMonsters
    dw BreedMenu_ChooseParents_DrawNames
    dw BreedMenu_ChooseParents_DrawFamilySexLevel
    dw BreedMenu_ChooseParents_BlankNameTiles
    dw BreedMenu_ChooseParents_DrawNameAndSpecies
    dw BreedMenu_ChooseParents_ShowCursorMark
    dw BreedMenu_ChooseParents_ListCursor
    dw BreedMenu_ChooseParents_DrawOptionBox
    dw BreedMenu_ChooseParents_RedrawPairBox
    dw BreedMenu_ChooseParents_BackToOptions
    dw BreedMenu_ChooseParents_DrawYesNoArea
    dw BreedMenu_ChooseParents_AskYesNo
    dw BreedMenu_ChooseParents_YesNoCursor
    dw BreedMenu_ChooseParents_DrawLowerBox
    dw BreedMenu_ChooseParents_BlankCursors
    dw BreedMenu_ChooseParents_CheckBase
    dw BreedMenu_ChooseParents_DrawBaseFrame
    dw BreedMenu_ChooseParents_CopyListGlyphs
    dw BreedMenu_ChooseParents_ClearBoxes
    dw BreedMenu_ChooseParents_ClearMateList
    dw BreedMenu_ChooseParents_ListPartners
    dw BreedMenu_ChooseParents_DrawNames
    dw DrawListEntriesCell5IconAndLevelAndStep
    dw BreedMenu_ChooseParents_ClearTileAreas
    dw DrawListEntriesCell5RecordNamesAndStep
    dw BreedMenu_ChooseParents_KeepMate
    dw BreedMenu_ChooseParents_ComputeChild
    dw DrawScreenBufferAtScrollAndIncScreenStep
    dw BreedMenu_ChooseParents_MateCursor
    dw BreedMenu_ChooseParents_DrawPairBox
    dw BreedMenu_ChooseParents_ReloadTiles
    dw BreedMenu_ChooseParents_DrawYesNoArea
    dw BreedMenu_ChooseParents_AskYesNo
    dw BreedMenu_ChooseParents_YesNoCursor
    dw BreedMenu_ChooseParents_RedrawPair
    dw BreedMenu_ChooseParents_BlankCursorsAgain
    dw BreedMenu_ChooseParents_CheckMate
    dw BreedMenu_ChooseParents_CheckChildIsNew
    dw BreedMenu_ChooseParents_CheckChildSeen
    dw BreedMenu_ChooseParents_StartCountingScript
    dw DrawRectIfLinkModeAndStep
    dw BreedMenu_ChooseParents_ShowLinkSaveInfo
    dw BreedMenu_ChooseParents_ShowLinkPrompt
    dw BreedMenu_ChooseParents_ReloadFrameTilesIfLinked
    dw BreedMenu_ChooseParents_LinkYesNoBox
    dw BreedMenu_ChooseParents_LinkYesNo
    dw BreedMenu_ChooseParents_DrawLinkBoxAndSprites
    dw BreedMenu_ChooseParents_SaveScreenArea
    dw BreedMenu_ChooseParents_ReloadTilesAgain
    dw BreedMenu_ChooseParents_RedrawPairAndOptions
    dw BreedMenu_ChooseParents_MarkOption
    dw BreedMenu_ChooseParents_BackToOptions
    dw BreedMenu_ChooseParents_Breed
    dw BreedMenu_ChooseParents_DrawLinkBoxAndSprites
    dw BreedMenu_ChooseParents_SaveScreenArea
    dw BreedMenu_ChooseParents_ReloadTilesAgain
    dw BreedMenu_ChooseParents_RedrawPairAndGold
    dw BreedMenu_ChooseParents_MoveOn
    dw BreedMenu_ChooseParents_WriteFee
    dw BreedMenu_ChooseParents_ReloadLinkFrameTiles
    dw BreedMenu_ChooseParents_DrawPayYesNo
    dw BreedMenu_ChooseParents_ReadFeeAnswer
    dw BreedMenu_ChooseParents_FeeRefused
    dw BreedMenu_ChooseParents_PayAndMakeEgg

; Choosing parents, step 0: saves the screen area, draws the list box and resets the list cursor,
; page and choice. (C1, E-0357)
BreedMenu_ChooseParents_Init::
    ld c, $0b
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    ld de, BreedMenu_ChooseParents_Init_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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
BreedMenu_ChooseParents_Init_TileRect::
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

; Choosing parents, step 1: clears the list tile areas and draws the empty list box. (C1, E-0357)
BreedMenu_ChooseParents_ClearList::
    call ClearTileAreas1240_1700_14E0
    ld de, BreedMenu_ChooseParents_ClearList_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 2: lists the farm monsters that are not eggs, then the page cursor (below).
; (C1, E-0357)
BreedMenu_ChooseParents_ListMonsters::
    farcall ListRecordsInUseNotEggs

; Clamps the list's page cursor; with two or more pages draws the arrows and 'page/pages' on the
; screen and in the window buffer. (C1, E-0357)
BreedMenu_ChooseParents_UpdateListPages::
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

; Choosing parents, step 3: draws the page's names and marks the party members. (C1, E-0357)
BreedMenu_ChooseParents_DrawNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; Choosing parents, step 4: for the record under the cursor draws its family icon, its sex mark and
; level (DrawRecordField0EMarkAndField56Digits). (C1, E-0357)
BreedMenu_ChooseParents_DrawFamilySexLevel::
    farcall SetArg5ToListEntriesCell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $c7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, BreedMenu_FamilySexLevelTileRect
    ld hl, wWindowTileBuffer + $bc
    lb bc, $0c, $09
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

; Choosing parents, step 5: blanks the name and number tiles and puts the text window back in place.
; (C1, E-0357)
BreedMenu_ChooseParents_BlankNameTiles::
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

; Choosing parents, step 6: draws the name and species name of the record under the cursor. (C1,
; E-0357)
BreedMenu_ChooseParents_DrawNameAndSpecies::
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

; Draws the 20 x 13 rectangle of the screen buffer at offset $1CC to the BG map at the scroll origin
; (DrawScreenBufferRect_Bank15, the lower part of the view with the window boxes), then adds 1 to
; wScreenStep. Step 29 of BreedMenu_ChooseParents. (C1, E-0377)
; DrawScreenBufferRect_Bank15 (20 x 13 from buffer offset $01CC at the scroll origin), then
; wScreenStep += 1 (E-0119)
DrawScreenBufferAtScrollAndIncScreenStep::
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 7: shows the cursor mark, redraws the screen and clears the mark. (C1,
; E-0357)
BreedMenu_ChooseParents_ShowCursorMark::
    ld a, [wListCursor]
    ld b, $bb
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank15
    call DrawScreenBufferAtScrollAndIncScreenStep
    ld a, [wListCursor]
    ld b, $c3
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank15
    ret

; Choosing parents, step 8: the paged list cursor: a page change redraws the list (back 7 steps), a
; move redraws the record (back 4), B goes on one step, A marks the entry and goes on four with the
; answer cleared. (C1, E-0357)
BreedMenu_ChooseParents_ListCursor::
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
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
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

; Choosing parents, step 9: saves two screen areas, draws the option box and redraws. (C1, E-0357)
BreedMenu_ChooseParents_DrawOptionBox::
    ld c, $0b
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    ld de, BreedMenu_ChooseParents_DrawOptionBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 10: redraws the pair box and the option box with the option marked; answer
; 1. (C1, E-0357)
BreedMenu_ChooseParents_RedrawPairBox::
    call DrawPairAndStep_2
    ld de, BreedMenu_Setup_DrawOptionBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing parents, step 12: draws the yes/no area of the box and redraws. (C1, E-0357)
BreedMenu_ChooseParents_DrawYesNoArea::
    ld de, BreedMenu_ChooseParents_DrawYesNoArea_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 13: plays sound $6C, copies the box glyphs, draws the yes/no box and resets
; the answer and choice. (C1, E-0357)
BreedMenu_ChooseParents_AskYesNo::
    ld a, $6c
    call QueueSoundEffect
    ld hl, BreedMenu_ChooseParents_AskYesNo_TileCopyDestList
    ld de, BreedMenu_ChooseParents_AskYesNo_TileCopySrcList
    call CopyGlyphTileListFromBank1F_Bank15
    ld de, BreedMenu_ChooseParents_AskYesNo_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wTwoChoiceCursor], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 15: draws the 12 x 5 lower box in the window buffer. (C2, E-0357; probed
; E-0377)
BreedMenu_ChooseParents_DrawLowerBox::
    ld de, BreedMenu_ChooseParents_DrawLowerBox_Data
    ld hl, wWindowTileBuffer + $10c
    lb bc, $0c, $05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 16: blanks the five cursor places, redraws and returns to the list cursor
; (step 8). (C1, E-0357)
BreedMenu_ChooseParents_BlankCursors::
    ld c, $05
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $08
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing parents, step 17: checks the base chosen in list cell 5 (wListEntries + 5 *
; wListPageIndex + wListCursor). If every one of the wListCount listed records has the same bit 0 of
; MON_SEX as the base, no mate is possible: wTwoChoiceCursor 3. Otherwise a base with MON_LEVEL
; below 10 gives wTwoChoiceCursor 2, and the only party member (wPartyCount below 2 and
; wPartyList[0] equal to the record) gives wTwoChoiceCursor 1. Each of these three refusals takes 2
; off wScreenStep and requests the script ($80). A good base is kept in wSelectedRecord, wItemGridX
; and wItemGridY get wListCursor and wListPageIndex, both cursors and wTwoChoiceCursor are cleared
; and wScreenStep goes up by 1. (C2, E-0384)
BreedMenu_ChooseParents_CheckBase::
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

; Choosing parents, step 18: draws the base's frame and the lower box, blanks the cursor places and
; redraws. (C1, E-0357)
BreedMenu_ChooseParents_DrawBaseFrame::
    ld a, $b6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $a0], a
    ld [wWindowTileBuffer + $c8], a
    ld de, BreedMenu_ChooseParents_DrawBaseFrame_TileRect
    ld hl, wWindowTileBuffer + $94
    lb bc, $0c, $03
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_DrawLowerBox_Data
    ld hl, wWindowTileBuffer + $10c
    lb bc, $0c, $05
    call CopyRectTo20ByteRows_Bank15
    ld c, $05
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 19: BreedMenu_CopyParentListGlyphs. (C1, E-0357)
BreedMenu_ChooseParents_CopyListGlyphs::
    call BreedMenu_CopyParentListGlyphs
    ret

; Choosing parents, step 20: clears three tile rows and draws two empty boxes. (C1, E-0357)
BreedMenu_ChooseParents_ClearBoxes::
    call ClearThreeTileRows
    ld de, BreedMenu_ChooseParents_ClearBoxes_TileRect
    ld hl, wWindowTileBuffer + $94
    lb bc, $0c, $03
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_ClearBoxes_TileRect_2
    ld hl, wWindowTileBuffer + $10c
    lb bc, $0c, $05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 21: blanks three tile areas and draws the empty list box. (C1, E-0357)
BreedMenu_ChooseParents_ClearMateList::
    ld hl, vTiles1 + $240
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4e0
    ld bc, $1101
    call FillTilesBxC
    ld de, BreedMenu_ChooseParents_ClearList_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 22: notes the base's sex, lists the monsters of the other sex
; (BreedMenu_ListMates) and clamps the page. (C1, E-0357)
BreedMenu_ChooseParents_ListPartners::
    call LoadSelectedRecordSex
    call BreedMenu_ListMates
    jp BreedMenu_ChooseParents_UpdateListPages

; For the record in the list cell under the cursor (SetArg5ToListEntriesCell5, which leaves HL on
; that list entry): loads its family icon tile with wArg1 = $FF
; (LoadFamilyIconTileForRecordB_Bank15, tile $FF), then draws its sex mark and level at
; wWindowTileBuffer + $126 (DrawRecordField0EMarkAndField56Digits) and adds 1 to wScreenStep. Step
; 24 of BreedMenu_ChooseParents. (C1, E-0377)
; for the record at wListEntries cell 5 loads its family icon tile and draws its mark and level at
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

; Choosing parents, step 25: clears tile areas with FillTilesBxC through ClearThreeTileRows, which
; falls into ClearTileAreas2700_1750_17D0: 4 tiles at vTiles2 + $7C0, 3 at vTiles1 + $400, 2 at
; vTiles1 + $4A0, 9 at vTiles2 + $700, 3 at vTiles1 + $750 and 2 at vTiles1 + $7D0; then wScreenStep
; += 1. (C1, E-0370)
BreedMenu_ChooseParents_ClearTileAreas::
    call ClearThreeTileRows
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; For the record in the list cell under the cursor (SetArg5ToListEntriesCell5, pointer in
; wArg5/wArg6): sets wArg1 = the record and far-calls DrawRecordNameAndSpeciesName to draw its name
; and species name, clears wNameEntryState and wNameEntrySubState and adds 1 to wScreenStep. A step
; of BreedMenu_ChooseParents and BreedMenu_ShowSelectedRecord_DrawPairNames. (C1, E-0377)
; draws the name and species name of the record at wListEntries cell 5, clears wNameEntryState and
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

; Choosing parents, step 27: keeps the chosen mate and resets the name entry's state. (C2, E-0357;
; probed E-0384)
BreedMenu_ChooseParents_KeepMate::
    call BreedMenu_CopyParentRecords
    xor a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 28: computes the child (ComputeBreedingChild, kind 0) and draws its name:
; '?????????' with a blank icon for a species the library lists but has not yet seen (or no
; species), otherwise its species name and family icon. (C1, E-0357)
BreedMenu_ChooseParents_ComputeChild::
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
    ld de, BreedShowNameSpeciesBits
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
    ld de, Tiles2Plus420Tiles
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

; Choosing parents, step 30: the mate list's cursor: a page change goes back 9 steps, a move back 6,
; B on one, A marks the entry and goes on three. (C1, E-0357)
BreedMenu_ChooseParents_MateCursor::
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
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
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

; Choosing parents, step 31: draws the pair box with both parents, the gold box and the lower box,
; redraws; answer 1. (C1, E-0357)
BreedMenu_ChooseParents_DrawPairBox::
    ld c, $03
    ld hl, $01fc
    ld de, $0030
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    ld a, $b7
    ld [wWindowTileBuffer + $93], a
    ld [wWindowTileBuffer + $a7], a
    call DrawGoldBoxAndStep_Bank15
    ld de, BreedMenu_FamilySexLevelTileRect
    ld hl, wWindowTileBuffer + $bc
    lb bc, $0c, $01
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_DrawPairBox_Data
    ld hl, wWindowTileBuffer + $120
    lb bc, $0c, $04
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ChooseParents_DrawPairBox_TileRect
    ld hl, wWindowTileBuffer + $93
    lb bc, $01, $02
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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
BreedMenu_ChooseParents_DrawPairBox_TileRect::
    db $b7 ; id 0
    db $b7 ; id 1

; Choosing parents, step 32: reloads tiles six per call (from SRAMBank1RecordAddress, list $9D);
; when done restores the list position and returns to step 1. (C1, E-0357)
BreedMenu_ChooseParents_ReloadTiles::
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

; Choosing parents, step 36: redraws the yes/no area, the names, icons and levels of the pair, then
; goes to step $25 with the text window back in place. (C1, E-0357)
BreedMenu_ChooseParents_RedrawPair::
    ld de, BreedMenu_ChooseParents_RedrawPair_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawListEntriesCell5RecordNamesAndStep
    ld de, BreedMenu_ChooseParents_ClearBoxes_TileRect_2
    ld hl, wWindowTileBuffer + $10c
    lb bc, $0c, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call DrawListEntriesCell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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

; Choosing parents, step 37: blanks the cursor places, redraws and goes to step $1E. (C1, E-0357)
BreedMenu_ChooseParents_BlankCursorsAgain::
    ld c, $05
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $1e
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing parents, step 38: checks the chosen mate: below level 10 answer 3 (step $24); a choice
; that would take every party monster answer 2 (step $24); otherwise answer 0 and on. (C2, E-0357;
; probed E-0384)
BreedMenu_ChooseParents_CheckMate::
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

; Choosing parents, step 39: tests the species of wChildRecord (MON_SPECIES) in three bit fields:
; the list wMonsterLibraryBuf and BreedShowNameSpeciesBits with TestBitInFieldAtArg3 ($80 first in
; each byte) and wSpeciesFlags with TestSpeciesFlag. Only when the bit is clear in all three is
; wTwoChoiceCursor = 1 and wScreenStep raised by 2, skipping step 40
; (BreedMenu_ChooseParents_CheckChildSeen). When any of the three is set it builds '<species name>
; +<MON_PLUS>' in wTextBuf0 (the name from CopyMonsterNameToBuffer_B15, tile $A2, then the one or
; two digits of MON_PLUS with a leading zero blanked), sets wTwoChoiceCursor = 0 and raises
; wScreenStep by 1. Both paths clear wScriptCommandType and set wScriptStartRequest to $80. (C1,
; E-0378)
BreedMenu_ChooseParents_CheckChildIsNew::
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
    ld hl, BreedShowNameSpeciesBits
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

; Choosing parents, step 40: tests the species of wChildRecord (MON_SPECIES) in the bit field
; wMonsterLibraryBuf (TestBitInFieldAtArg3, $80-first order) and in wSpeciesFlags (TestSpeciesFlag);
; wTwoChoiceCursor = 1 only when both bits are clear, otherwise 0. Then adds 1 to wScreenStep and
; requests script $80. The old reading (in the library list but not yet seen) did not match the bit
; tests. (C2, E-0377)
BreedMenu_ChooseParents_CheckChildSeen::
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

; When wLinkMode is non-zero copies the 20 x 11 box into the window buffer and draws the lower
; screen (CopyRectToWindowTileBufferRow5AndDraw); in every case adds 1 to wScreenStep. Step 42 of
; BreedMenu_ChooseParents, the start of the link-session save prompt. (C1, E-0377)
; if wLinkMode is set, copies and draws rectangle $70C5 at wWindowTileBuffer + $64; wScreenStep += 1
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; DrawRectIfLinkModeAndStep)
DrawRectIfLinkModeAndStep::
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_step
    call CopyRectToWindowTileBufferRow5AndDraw

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 43: in a link session shows the save file window. (C1, E-0357)
BreedMenu_ChooseParents_ShowLinkSaveInfo::
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_step
    call ShowSaveFileInfoWindow

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 44: in a link session draws the bottom box and shows string $0D (bank $1B)
; until its text ends. (C1, E-0357)
BreedMenu_ChooseParents_ShowLinkPrompt::
    call BreedMenu_ChooseParents_DrawLinkSprite
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
    farcall BeginBreedingStringDisplay

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

; Choosing parents, step 41: starts the counting script once
; (PrepareCounterPtr0LoCountersAndRequestScript); in a link session redraws the pair's names, icons
; and levels; goes to step $2A. (C1, E-0357)
BreedMenu_ChooseParents_StartCountingScript::
    ld a, [wScreenSubStep]
    and a
    jr nz, .clear_screen_sub_step
    call PrepareCounterPtr0LoCountersAndRequestScript
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld a, [wLinkMode]
    and a
    jr z, .set_screen_step_to_2A
    ld de, BreedMenu_ChooseParents_RedrawPair_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawListEntriesCell5RecordNamesAndStep
    ld de, BreedMenu_ChooseParents_ClearBoxes_TileRect_2
    ld hl, wWindowTileBuffer + $10c
    lb bc, $0c, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call DrawListEntriesCell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15

.set_screen_step_to_2A:
    ld a, $2a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; Choosing parents, step 47: in a link session the yes/no answer: no goes on one step, yes seven;
; outside a link straight on seven. (C1, E-0357)
BreedMenu_ChooseParents_LinkYesNo::
    ld a, [wLinkMode]
    and a
    jr z, .read_screen_step
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    call BreedMenu_ChooseParents_DrawLinkSprite
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
    call BreedMenu_ChooseParents_DrawLinkSprite

.read_screen_step:
    ld a, [wScreenStep]
    add $07
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; Choosing parents, step 48: draws the 6 x 5 box (in a link session) and reloads the player's and
; followers' sprites. (C1, E-0357)
BreedMenu_ChooseParents_DrawLinkBoxAndSprites::
    ld de, BreedMenu_ChooseParents_CloseBoxTileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank15
    call DrawRectIfLinkModeAndStep
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

; Choosing parents, step 50: reloads tiles six per call until done. (C1, E-0357)
BreedMenu_ChooseParents_ReloadTilesAgain::
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

; Choosing parents, step 49: saves the 20 x 13 screen area. (C1, E-0357)
BreedMenu_ChooseParents_SaveScreenArea::
    ld c, $0d
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 51: redraws the pair, the gold box and the option box, then steps back one.
; (C1, E-0357)
BreedMenu_ChooseParents_RedrawPairAndOptions::
    call DrawPairAndStep_2
    call DrawGoldBoxAndStep_Bank15
    ld de, BreedMenu_Setup_DrawOptionBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; Choosing parents, step 52: marks the option. (C1, E-0357)
BreedMenu_ChooseParents_MarkOption::
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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

; Choosing parents, step 58: redraws the pair and the gold box, then steps back one. (C1, E-0357)
BreedMenu_ChooseParents_RedrawPairAndGold::
    call DrawPairAndStep_2
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; Choosing parents, step 59: moves on. (C1, E-0357)
BreedMenu_ChooseParents_MoveOn::
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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

; Choosing parents, step 60: writes the fee (TenTimesTemp0PlusTenToDigits of the child's plus value)
; into the text buffer. (C2, E-0357; probed E-0377)
BreedMenu_ChooseParents_WriteFee::
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

; Choosing parents, step 54: the breeding: in a link session shows string $0E and saves; then
; deletes both parents' records (the second index adjusted for the first) and writes the child's
; record (wChildRecord, $A5 bytes) into the freed slot. (C1, E-0357)
BreedMenu_ChooseParents_Breed::
    ld a, [wScreenSubStep]
    and a
    jr z, .call_breed_menu_choose_parents_draw_link3
    cp $01
    jr z, .call_breed_menu_choose_parents_draw_link2
    cp $02
    jr z, .call_breed_menu_choose_parents_draw_link
    ld a, [wTextFlags]
    and a
    jr z, .clear_screen_sub_step
    call BreedMenu_ChooseParents_DrawLinkSprite
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_breed_menu_choose_parents_draw_link:
    call BreedMenu_ChooseParents_DrawLinkSprite
    ld a, [wLinkMode]
    and a
    jr z, .check_screen_sub_step
    ld a, $0e
    ld [wStringIndex], a
    farcall BeginBreedingStringDisplay

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_breed_menu_choose_parents_draw_link2:
    call BreedMenu_ChooseParents_DrawLinkSprite
    ld a, [wLinkMode]
    and a
    jr z, .clear_two_choice_cursor
    farcall RunSaveGameSteps_2
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

.call_breed_menu_choose_parents_draw_link3:
    call BreedMenu_ChooseParents_DrawLinkSprite
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

; B = record: replaces its entry among the first wPartyCount of wPartyList with $FF and lowers
; wPartyCount, packs the entries of the three that are not $FF to the front, then writes 0 over
; entries that are $FF or still B. The places left after packing are not cleared, so removing a
; member other than the last leaves a copy of the last entry (1, 2, 3 without 2 gives 1, 3, 3).
; Nothing in src/ references it. (C2, E-0377)
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

; Choosing parents, step 63: the yes/no answer to the fee (TenTimesTemp0PlusTen of the plus value):
; no answers 1; not enough gold answers $FF; yes with the gold answers 0 and goes on two steps. (C1,
; E-0357)
BreedMenu_ChooseParents_ReadFeeAnswer::
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

; Choosing parents, step 64, reached when BreedMenu_ChooseParents_ReadFeeAnswer gets no, B, or a fee
; above the gold: sets wScreenStep = 0 and wScreenState = $0A (BreedMenu_TalkEvent15, talk event
; group $15 entry 0), clears wScriptCommandType and requests script $80. (C2, E-0370; probed E-0377)
BreedMenu_ChooseParents_FeeRefused::
    xor a
    ld [wScreenStep], a
    ld a, $0a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing parents, step 65: pays the fee, lists the eggs, finds the child in the list (page and
; cursor of four) and clears its MON_EGG byte, then screen state 8. (C2, E-0357; probed E-0384)
BreedMenu_ChooseParents_PayAndMakeEgg::
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
    farcall ListRecordsInUseEggs
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

; BreedMenu state 5 (option 1, Hatch), by wScreenStep (17 steps): lists the eggs with their species
; names and marks (steps 0-5), takes one with the paged cursor (6), draws the option frame and the
; gold box (7-8), asks yes/no (10-12), redraws the list (13-14), checks the gold for the fee (15,
; BreedMenu_ChooseEgg_CheckFee) and hatches it (16, BreedMenu_ChooseEgg_Hatch, then state 9). B
; returns to the options (step 9, BreedMenu_ChooseParents_BackToOptions). (C1, E-0377)
; BreedMenu screen state 5, by wScreenStep: the list of records with the egg flag set
; (ListRecordsInUseEggs), species names, marks, the gold box and a two-choice confirmation
BreedMenu_ChooseEgg::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_ChooseEgg_CopyListGlyphs
    dw BreedMenu_ChooseEgg_DrawEggList
    dw ClearTileRowsAndResetWindowAndStep
    dw BreedMenu_ChooseEgg_DrawPageFrame
    dw BreedMenu_ChooseEgg_DrawSpeciesNames
    dw BreedMenu_ChooseEgg_DrawMarks
    dw BreedMenu_ChooseEgg_ListCursor
    dw BreedMenu_ChooseEgg_DrawOptionFrame
    dw BreedMenu_ChooseEgg_DrawGoldBox
    dw BreedMenu_ChooseParents_BackToOptions
    dw BreedMenu_CopyBoxGlyphTiles
    dw BreedMenu_ChooseEgg_AskYesNo
    dw BreedMenu_ChooseParents_YesNoCursor
    dw BreedMenu_ChooseEgg_RedrawEggList
    dw BreedMenu_ChooseEgg_RedrawMarks
    dw BreedMenu_ChooseEgg_CheckFee
    dw BreedMenu_ChooseEgg_Hatch

; Choosing an egg, step 0: BreedMenu_CopyEggListGlyphs. (C1, E-0357)
BreedMenu_ChooseEgg_CopyListGlyphs::
    call BreedMenu_CopyEggListGlyphs
    ret

; Choosing an egg, step 1: draws the egg list box, marks the option and lists the eggs. (C1, E-0357)
BreedMenu_ChooseEgg_DrawEggList::
    ld de, BreedMenu_ChooseEgg_DrawEggList_TileRect
    ld hl, wWindowTileBuffer + $bb
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    farcall ListRecordsInUseEggs
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Fills tile areas with the plain pattern tile (FillTilesBxC: 3 tiles at vTiles1 + $400, 5 at
; vTiles1 + $470, 15 at vTiles1 + $500, 13 at vTiles1 + $700), puts the text window back ($8800,
; rows $02, width $12 in wTextWindowTileLo onward) and adds 1 to wScreenStep. Step 2 of
; BreedMenu_ChooseEgg and of BreedMenu_RedrawListScreen. (C1, E-0377)
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

; Choosing an egg, step 3: draws the box, clamps the page cursor of four, the page arrows and
; numbers, and shows then clears the cursor. (C1, E-0357)
BreedMenu_ChooseEgg_DrawPageFrame::
    ld de, BreedMenu_ChooseEgg_DrawPageFrame_TileRect
    ld hl, wWindowTileBuffer + $bb
    lb bc, $0d, $09
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
    ld hl, BreedMenu_ChooseEgg_DrawPageFrame_Data
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wListCursor]
    ld b, $c3
    ld hl, BreedMenu_ChooseEgg_DrawPageFrame_Data
    call StoreBAtWordTableEntry_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing an egg, step 4: draws the page's species names. (C1, E-0357)
BreedMenu_ChooseEgg_DrawSpeciesNames::
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing an egg, step 5: loads a mark tile and draws the page's marks. (C1, E-0357)
BreedMenu_ChooseEgg_DrawMarks::
    ld de, Tiles2Plus420Tiles
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

; Choosing an egg, step 6: the paged cursor: a page change goes back 4 steps; B answers 1 and goes
; on; A marks the egg, writes its fee (from its plus value) into the text buffer and goes on four
; steps. (C1, E-0357)
BreedMenu_ChooseEgg_ListCursor::
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
    ld hl, BreedMenu_ChooseEgg_DrawPageFrame_Data
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

; Choosing an egg, step 7: saves the screen area and draws the cursor's frame (after a three-option
; result, a wider one). (C2, E-0357; probed E-0377)
BreedMenu_ChooseEgg_DrawOptionFrame::
    ld c, $09
    ld hl, $0223
    ld de, $0057
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    ld a, [wThreeOptionResult]
    or a
    jr z, .skip
    ld de, BreedMenu_ChooseEgg_DrawOptionFrame_TileRect_2
    ld hl, wWindowTileBuffer + $bb
    lb bc, $04, $03
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld de, BreedMenu_ChooseEgg_DrawOptionFrame_TileRect
    ld hl, wWindowTileBuffer + $ba
    lb bc, $02, $03
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing an egg, step 8: draws the gold box once, then reloads tiles six per call until done. (C1,
; E-0357)
BreedMenu_ChooseEgg_DrawGoldBox::
    ld a, [wScreenSubStep]
    and a
    jr nz, .set_arg1_to_9C
    call DrawGoldBoxAndStep_Bank15
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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

; Writes the blank tile $C3 at the three option marks (BreedMenu_ChooseParents_RedrawPairBox_Data),
; clears wScreenStep and wScreenSubStep, sets wScreenState = 2 (BreedMenu_OptionCursor) and requests
; script $80. Steps 11 and 53 of BreedMenu_ChooseParents, step 9 of BreedMenu_ChooseEgg and the last
; step of BreedMenu_ReturnToMap. The old reading said state 0. (C2, E-0377)
BreedMenu_ChooseParents_BackToOptions::
    ld c, $03
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
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

; Copies the glyph tiles listed in BreedMenu_ChooseParents_AskYesNo_TileCopySrcList to
; BreedMenu_ChooseParents_AskYesNo_TileCopyDestList (CopyGlyphTileListFromBank1F_Bank15) and moves
; on (wScreenStep += 1); it is step 10 of BreedMenu_ChooseEgg, step 22 of BreedMenu_ReturnToMap and
; step 5 of BreedMenu_ShowSelectedRecord. (C1, E-0370)
BreedMenu_CopyBoxGlyphTiles::
    ld hl, BreedMenu_ChooseParents_AskYesNo_TileCopyDestList
    ld de, BreedMenu_ChooseParents_AskYesNo_TileCopySrcList
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing an egg, step 11: plays sound $6C, draws the yes/no box and resets the choice. (C1,
; E-0357)
BreedMenu_ChooseEgg_AskYesNo::
    ld a, $6c
    call QueueSoundEffect
    ld de, BreedMenu_ChooseParents_AskYesNo_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wMenuChoice], a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 14: the yes/no cursor; yes opens the record's stats screen (screen state
; $0C, $0D or $0E, returning to the right place), saving the sprites; no or B go back. (C1, E-0357)
BreedMenu_ChooseParents_YesNoCursor::
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
    call BreedMenu_ChooseParents_YesNoCursor_MarkChosen
    ld a, [wChoiceCursor]
    and a
    jp nz, .set_two_choice_cursor_to_01
    ld a, [wScreenState]
    cp $04
    jr z, .check_screen_step
    cp $05
    jr z, .set_return_screen_state_to_05
    jr .set_return_screen_state_to_07

.check_screen_step:
    ld a, [wScreenStep]
    cp $22
    jr c, .set_return_screen_state_to_04
    ld a, $04
    ld [wReturnScreenState], a
    ld a, $23
    ld [wReturnScreenStep], a
    ld a, $0c
    jr .set_screen_state

.set_return_screen_state_to_04:
    ld a, $04
    ld [wReturnScreenState], a
    ld a, $0e
    ld [wReturnScreenStep], a
    ld a, $0c
    jr .set_screen_state

.set_return_screen_state_to_05:
    ld a, $05
    ld [wReturnScreenState], a
    ld a, $0c
    ld [wReturnScreenStep], a
    ld a, $0d
    jr .set_screen_state

.set_return_screen_state_to_07:
    ld a, $07
    ld [wReturnScreenState], a
    ld a, $18
    ld [wReturnScreenStep], a
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

; Yes/no cursor blink of the breeding menu: while wJoypadRepeatTimer is below $14 draws the cursor
; tile $BB; otherwise adds 1 to wCursorBlinkAE and draws $BB for 1-$0F, the blank $C3 for $10-$17
; (DrawBlankTileC3_Bank15), and at $18 resets it to 0 and draws $BB; the tile goes to the place of
; wChoiceCursor (BreedMenu_ChooseParents_YesNoCursor_DrawTile). (C1, E-0377)
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
    jr BreedMenu_ChooseParents_YesNoCursor_DrawTile

; B = $C3 (the blank tile), then jumps to BreedMenu_ChooseParents_YesNoCursor_DrawTile at the yes/no
; place of wChoiceCursor. Used by BlinkCursorBlinkAE_Bank15 and BreedMenu_ChooseParents_YesNoCursor.
; (C1, E-0377)
; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_Bank15::
    ld b, $c3
    jr BreedMenu_ChooseParents_YesNoCursor_DrawTile

; Draws the chosen tile ($BC) at the yes/no cursor. (C1, E-0357)
BreedMenu_ChooseParents_YesNoCursor_MarkChosen::
    ld b, $bc

; Writes tile B at the yes/no cursor's place, stepping back on a scroll wrap, waiting for VRAM
; access. (C1, E-0357)
BreedMenu_ChooseParents_YesNoCursor_DrawTile::
    ld a, [wChoiceCursor]
    add a
    ld hl, BreedMenu_ChooseParents_YesNoCursor_DrawTile_Data
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

; Two little-endian word offsets into the BG map from the scroll position
; (BGMapAddressAtScroll_Bank15): $012D and $016D, which are row 9 and row 11 at column 13.
; BreedMenu_ChooseParents_YesNoCursor_DrawTile indexes it with wChoiceCursor times 2 and writes the
; tile B there, stepping back if the address wrapped. (C1, E-0381)
BreedMenu_ChooseParents_YesNoCursor_DrawTile_Data::
    db $2d, $01, $6d, $01

; Choosing an egg, step 14: redraws the page marks and returns to the cursor (step 6). (C1, E-0357)
BreedMenu_ChooseEgg_RedrawMarks::
    call LoadTilesAndDrawRecordListPageMarks
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing an egg, step 15: checks the gold for the egg's fee (TenTimesTemp0PlusTen of its plus
; value): too little answers 1 (step 7), otherwise answer 0 and on. (C2, E-0357; probed E-0384)
BreedMenu_ChooseEgg_CheckFee::
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

; Choosing an egg, step 16: hatches the egg (clears record byte $6E, MON_EGG), pays the fee, clears
; wListEntries2 and goes to screen state 9. (C2, E-0357; probed E-0384)
BreedMenu_ChooseEgg_Hatch::
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

; BreedMenu state 6: runs the name entry (RunNameEntryStateWhenNotFading) for the record in list
; cell 4 (SetArg5ToListEntriesCell4) with wArg1 = 1, wArg2 = its sex bit, wArg3 = its family
; (MON_FAMILY & $1F) and wArg4/wArg5 = its species; wSelectedRecord = the record. When the entry
; returns wArg5 = $FF it writes the name from wNameGlyphBuf into MON_NAME (up to 10 bytes, with $F0
; when shorter), copies the record to wRecordBufA, deletes it (DeleteSRAMRecordAndCompact, wArg2 =
; 0), writes the copy into the free record that returns (wSelectedRecord = its number) and moves to
; state 7. (C1, E-0377)
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

; BreedMenu state 7, after the child is named, by wScreenStep (33 steps): steps 0-3 reload the map
; screen (map $0D, the tiles, sprites and saved position), 4 copies the name into wTextBuf0, 5-6 ask
; yes/no; no goes back to the option cursor (7-9), yes adds the child to the party when there is
; room (10, BreedMenu_ReturnToMap_AddChildToParty). With a full party steps 11-29 list the party and
; the child and send the chosen one to the farm (BreedMenu_ReturnToMap_SendToFarm); 30-32 redraw and
; return to the options. Only steps 0-3 reload the map; the name covers only them. (C1, E-0377)
; reloads the map (LoadMapHeader), the player's position (RestorePlayerPositionState) and sprite
; graphics (E-0277)
BreedMenu_ReturnToMap::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_ReturnToMap_LoadTiles
    dw DrawPairAndStep_2_2
    dw BreedMenu_ReturnToMap_LoadMap
    dw BreedMenu_ReturnToMap_RestoreScreen
    dw BreedMenu_ReturnToMap_CopyName
    dw BreedMenu_ChooseParents_DrawPayYesNo
    dw BreedMenu_ReturnToMap_YesNo
    dw DrawGoldBoxAndStep_Bank15
    dw BreedMenu_ReturnToMap_DrawOptionBox
    dw BreedMenu_ReturnToMap_BackToOptions
    dw BreedMenu_ReturnToMap_AddChildToParty
    dw BreedMenu_ReturnToMap_DrawPartyBox
    dw BreedMenu_ReturnToMap_ClearPartyBox
    dw BreedMenu_ReturnToMap_ListPartyAndChild
    dw BreedMenu_ReturnToMap_DrawPageNames
    dw BreedMenu_ReturnToMap_DrawIconAndStats
    dw BreedMenu_ReturnToMap_MarkPartyMembers
    dw BreedMenu_ReturnToMap_DrawNameAndSpecies
    dw BreedMenu_ReturnToMap_RedrawScreen
    dw BreedMenu_ReturnToMap_ListCursor
    dw BreedMenu_ReturnToMap_DrawYesNoTop
    dw BreedMenu_ReturnToMap_RedrawPairBox
    dw BreedMenu_CopyBoxGlyphTiles
    dw BreedMenu_ChooseEgg_AskYesNo
    dw BreedMenu_ChooseParents_YesNoCursor
    dw BreedMenu_ReturnToMap_DrawYesNoBox
    dw BreedMenu_ReturnToMap_BackToList
    dw BreedMenu_ReturnToMap_CopyLeaverName
    dw BreedMenu_ReturnToMap_SendToFarm
    dw BreedMenu_ReturnToMap_ReloadSprites
    dw BreedMenu_ReturnToMap_DrawOptionAndGoldBoxes
    dw BreedMenu_ReturnToMap_MarkOption
    dw BreedMenu_ChooseParents_BackToOptions

; Returning to the map, step 0: decompresses LetterFrameIconDigitTiles (bank $46) into VRAM $8800
; and restores the player's position. (C1, E-0357)
BreedMenu_ReturnToMap_LoadTiles::
    ld b, $46
    ld de, LetterFrameIconDigitTiles
    ld hl, vTiles1
    call DecompressToVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call RestorePlayerPositionState
    ret

; The same as DrawPairAndStep_2: copies the glyph tiles of
; CloseBreedMenu_RestoreGlyphs_TileCopyDestList / DrawPairAndStep_2_TileCopySrcList from bank $1F,
; then adds 1 to wScreenStep. Step 1 of BreedMenu_ReturnToMap and step 2 of BreedMenu_RestoreScreen,
; and called by two of their steps. (C1, E-0377)
; runs CopyGlyphTileListFromBank1F_Bank15 for CloseBreedMenu_RestoreGlyphs_TileCopyDestList and
; DrawPairAndStep_2_TileCopySrcList, then wScreenStep += 1 (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was DrawPairAndStep_2_2)
DrawPairAndStep_2_2::
    ld hl, CloseBreedMenu_RestoreGlyphs_TileCopyDestList
    ld de, DrawPairAndStep_2_TileCopySrcList
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Returning to the map, step 2: loads map $0D's header and screen, the player's and followers'
; sprites and the screen's objects, restores the position and shows the sprites. (C1, E-0357)
BreedMenu_ReturnToMap_LoadMap::
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

; Returning to the map, step 3: restores the screen and window areas from the window buffer (tiles
; and GBC attributes), redraws the bottom rows and sets sprite hide tile $70. (C1, E-0357)
BreedMenu_ReturnToMap_RestoreScreen::
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
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    ld a, $70
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Returning to the map, step 4: copies the name glyph buffer (up to 10 glyphs) into wTextBuf0 for
; the script's message. (C2, E-0357; probed E-0377)
BreedMenu_ReturnToMap_CopyName::
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

; Choosing parents, step 62: loads two box tiles, plays sound $6C and draws the 6 x 5 yes/no box;
; resets the answer. (C1, E-0357)
BreedMenu_ChooseParents_DrawPayYesNo::
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles2 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call BreedMenu_ChooseParents_DrawLinkSprite
    ld a, $6c
    call QueueSoundEffect
    ld de, BreedMenu_ChooseParents_DrawPayYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; Choosing parents, step 46: in a link session draws the yes/no box (as step 62); otherwise moves on
; with the answer cleared. (C1, E-0357)
BreedMenu_ChooseParents_LinkYesNoBox::
    ld a, [wLinkMode]
    and a
    jr nz, BreedMenu_ChooseParents_DrawPayYesNo
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; Returning to the map, step 6: the yes/no answer: no (or B) restores the box and goes on one step
; with answer 1; yes goes on four. (C1, E-0357)
BreedMenu_ReturnToMap_YesNo::
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
    call BreedMenu_ReturnToMap_RestoreYesNoBox
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

; Restores the 6 x 5 yes/no box area from the saved screen (tiles and GBC attributes) and redraws.
; (C1, E-0357)
BreedMenu_ReturnToMap_RestoreYesNoBox::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $05
    call BreedMenu_ReturnToMap_CopySixWideRows
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank15
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call BreedMenu_ReturnToMap_CopySixWideAttrRows

.call_bg_map_address_at_scroll_bank15:
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ret

; Copies C rows of six bytes from DE to HL, both with 20-byte rows. (C2, E-0357; probed E-0377)
BreedMenu_ReturnToMap_CopySixWideRows::
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
    jr nz, BreedMenu_ReturnToMap_CopySixWideRows
    ret

; Copies C rows of six attribute bytes (low three bits, into WRAM bank 2), 20-byte rows. (C2,
; E-0357; probed E-0377)
BreedMenu_ReturnToMap_CopySixWideAttrRows::
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
    jr nz, BreedMenu_ReturnToMap_CopySixWideAttrRows
    ret

; Returning to the map, step 8: reloads two frame tiles, draws the option box with the option marked
; and redraws. (C1, E-0357)
BreedMenu_ReturnToMap_DrawOptionBox::
    ld de, Tiles1Plus2D0Tiles
    ld hl, vTiles1 + $2d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_2
    ld hl, vTiles1 + $2e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, BreedMenu_Setup_DrawOptionBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank15
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0b
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

; Returning to the map, step 9: blanks the option marks and returns to the options (state 2). (C2,
; E-0357; probed E-0377)
BreedMenu_ReturnToMap_BackToOptions::
    ld c, $03
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
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

; After hatching, step 10: with room in the party (fewer than three) adds the child
; (wSelectedRecord) to the party (MON_STATE 2), reloads the sprites, answers 1 and steps back three;
; otherwise marks the yes/no choice and goes on to choose who leaves the party. (C1, E-0357)
BreedMenu_ReturnToMap_AddChildToParty::
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
    call BreedMenu_ReturnToMap_RestoreYesNoBox
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    ld b, $bc
    ld hl, BreedMenu_ReturnToMap_AddChildToParty_Data
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

; Choosing who leaves, step 11: draws the party box (16 tiles) and resets the list cursor. (C1,
; E-0357)
BreedMenu_ReturnToMap_DrawPartyBox::
    ld de, BreedMenu_ReturnToMap_DrawPartyBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $09
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
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
BreedMenu_ReturnToMap_DrawPartyBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; Copies 16 glyph tiles from bank $1F, for C = 16 down to 1: the tile of the glyph at
; BreedMenu_ReturnToMap_CopySixteenTiles_Data1 + C (GlyphFont + 16 x glyph) to the address in entry
; C of BreedMenu_ReturnToMap_CopySixteenTiles_Data2 (CopyFromBankWaitVRAM). Entry 0 of both tables
; is never used and C = 16 reads past both: the glyph is the first byte of _Data2 ($D0) and the
; destination the word $0021 from the code after _Data2, so those 16 bytes go to $0021-$0030, the
; cartridge RAM-enable range, not VRAM. Called by BreedMenu_ReturnToMap_DrawPartyBox. (C1, E-0377)
; copies 16 tiles by its source and destination tables
BreedMenu_ReturnToMap_CopySixteenTiles::
    ld c, $10

.loop:
    push bc
    ld a, c
    ld de, BreedMenu_ReturnToMap_CopySixteenTiles_Data1
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
    ld de, BreedMenu_ReturnToMap_CopySixteenTiles_Data2
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

; Sixteen glyph ids ($A3, $50, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14,
; $25). BreedMenu_ReturnToMap_CopySixteenTiles counts C from 16 down to 1 and reads the byte at
; offset C, so the byte at offset 0 is never read and for C = 16 it reads the byte after the table
; (the first byte of BreedMenu_ReturnToMap_CopySixteenTiles_Data2, $D0). The glyph tile is taken
; from GlyphFont in bank $1F (16 bytes each) and copied to word C of
; BreedMenu_ReturnToMap_CopySixteenTiles_Data2. (C1, E-0381)
BreedMenu_ReturnToMap_CopySixteenTiles_Data1::
    db $a3, $50, $44, $11, $16, $19, $48, $24, $a6, $12, $31, $29, $32, $18, $14, $25

; Sixteen words (32 bytes), each a VRAM tile address: $8ED0, $8EE0, $8EF0, $8F50, $8F60, $8F70,
; $8FD0, $8FE0, $8FF0, then $9700 to $9760 in steps of $10. BreedMenu_ReturnToMap_CopySixteenTiles
; counts C from 16 down to 1 and uses word C as the destination of the 16-byte tile it copies from
; GlyphFont for glyph BreedMenu_ReturnToMap_CopySixteenTiles_Data1[C], so word 0 is never used and
; the pass with C = 16 reads the two bytes after the table. (C1, E-0381)
BreedMenu_ReturnToMap_CopySixteenTiles_Data2::
    db $d0, $8e, $e0, $8e, $f0, $8e, $50, $8f, $60, $8f, $70, $8f, $d0, $8f, $e0, $8f
    db $f0, $8f, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; Choosing who leaves, step 12: blanks the name tiles and draws the empty party box. (C1, E-0357)
BreedMenu_ReturnToMap_ClearPartyBox::
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
    ld de, BreedMenu_ReturnToMap_ClearPartyBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $09
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing who leaves, step 13: lists the three party monsters and the child (four entries from
; wListEntries) and clamps the cursor. (C1, E-0357)
BreedMenu_ReturnToMap_ListPartyAndChild::
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

; Choosing who leaves, step 14: draws the four names. (C1, E-0357)
BreedMenu_ReturnToMap_DrawPageNames::
    farcall DrawRecordListPageNames
    ret

; Choosing who leaves, step 15: for the entry under the cursor draws its family icon and its stats
; box. (C1, E-0357)
BreedMenu_ReturnToMap_DrawIconAndStats::
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
    ld de, BreedMenu_ReturnToMap_DrawIconAndStats_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wArg1], a
    farcall DrawRecordStatsBoxForArg1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing who leaves, step 16: blanks the name tiles and marks the party members in the list
; (BreedMenu_ReturnToMap_MarkPartyMembers_DrawMarks). (C1, E-0357)
BreedMenu_ReturnToMap_MarkPartyMembers::
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
    call BreedMenu_ReturnToMap_MarkPartyMembers_DrawMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing who leaves, step 17: draws the name and species name of the entry under the cursor. (C1,
; E-0357)
BreedMenu_ReturnToMap_DrawNameAndSpecies::
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

; Choosing who leaves, step 18: redraws the screen. (C1, E-0357)
BreedMenu_ReturnToMap_RedrawScreen::
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing who leaves, step 19: the list cursor: a page change goes back 7 steps, a move back 4, B
; answers 1 and goes on, A marks the entry and goes on three. (C1, E-0357)
BreedMenu_ReturnToMap_ListCursor::
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
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
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

; Choosing who leaves, step 20: loads two box tiles, saves the screen area and draws the top row of
; the yes/no box. (C1, E-0357)
BreedMenu_ReturnToMap_DrawYesNoTop::
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
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
    call CopyScreenBufferRectWithAttrs_Bank15
    ld de, BreedMenu_ChooseParents_DrawPayYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $01
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing who leaves, step 21: redraws the pair box and goes to step 6 (the yes/no answer). (C1,
; E-0357)
BreedMenu_ReturnToMap_RedrawPairBox::
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call DrawPairAndStep_2_2
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing who leaves, step 25: loads the box tiles, saves a screen area, draws the yes/no box and
; the lower row, marks the first answer and blanks the four list marks. (C1, E-0357)
BreedMenu_ReturnToMap_DrawYesNoBox::
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
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
    call CopyScreenBufferRectWithAttrs_Bank15
    ld de, BreedMenu_ChooseParents_DrawPayYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank15
    ld de, BreedMenu_ReturnToMap_DrawYesNoBox_Data
    ld hl, wWindowTileBuffer + $10c
    lb bc, $0c, $01
    call CopyRectTo20ByteRows_Bank15
    xor a
    ld b, $bc
    ld hl, BreedMenu_ReturnToMap_AddChildToParty_Data
    call StoreBAtWordTableEntry_Bank15
    ld c, $04
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call BlankWordTableTargets
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing who leaves, step 26: returns to the list cursor (step $13). (C1, E-0357)
BreedMenu_ReturnToMap_BackToList::
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ld a, $13
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing who leaves, step 27: copies the chosen entry's name into wTextBuf0 for the script. (C2,
; E-0357; probed E-0384)
BreedMenu_ReturnToMap_CopyLeaverName::
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

; Choosing who leaves, step 28: sends the chosen monster to the farm (MON_STATE 1); unless it was
; the child (entry 3), rebuilds the party from the other three and marks them in the party (state
; 2). (C2, E-0357; probed E-0384)
BreedMenu_ReturnToMap_SendToFarm::
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

; Choosing who leaves, step 29: reloads the player's and followers' sprites. (C1, E-0357)
BreedMenu_ReturnToMap_ReloadSprites::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Returning to the map, step 30: saves the screen area, reloads two frame tiles and draws the option
; box and the gold box. (C1, E-0357)
BreedMenu_ReturnToMap_DrawOptionAndGoldBoxes::
    ld c, $0d
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_Bank15
    ld de, Tiles1Plus2D0Tiles
    ld hl, vTiles1 + $2d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_2
    ld hl, vTiles1 + $2e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, BreedMenu_Setup_DrawOptionBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRows_Bank15
    call DrawGoldBoxAndStep_Bank15
    ret

; Returning to the map, step 31: redraws the pair and marks the option. (C1, E-0357)
BreedMenu_ReturnToMap_MarkOption::
    call DrawPairAndStep_2_2
    ld a, [wGridCursorX]
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; BreedMenu state 8, after BreedMenu_ChooseParents_PayAndMakeEgg: saves the script position
; (wScriptStartRequest, wScriptPointerLo/Hi into wScriptReturnBank and wScriptReturnLo/Hi), runs
; talk event group $17 entry 0 (DispatchTalkEvent), clears wScriptInDataBank, and sets wScreenState
; = 6 (BreedMenu_NameEntry) with wNameEntryState and wNameEntrySubState 0. (C1, E-0377)
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

; BreedMenu state 9, after BreedMenu_ChooseEgg_Hatch: copies MON_SPECIES and MON_PLUS of the record
; in list cell 4 (SetArg5ToListEntriesCell4) into wChildRecord, saves the script position, runs talk
; event group $16 entry 0 (DispatchTalkEvent), clears wScriptInDataBank and sets wScreenState = 6
; (BreedMenu_NameEntry) with the name-entry state cleared. (C1, E-0377)
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

; BreedMenu state $0A, after BreedMenu_ChooseParents_FeeRefused: saves the script position, runs
; talk event group $15 entry 0 (DispatchTalkEvent), clears wScriptInDataBank and adds 1 to
; wScreenState (state $0B, BreedMenu_RestoreScreen). (C1, E-0377)
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

; BreedMenu state $0B, by wScreenStep: blanks the BG map, reloads the map screen
; (BreedMenu_ReturnToMap_LoadTiles, DrawPairAndStep_2_2, _LoadMap, _RestoreScreen), draws the gold
; box (with the SGB palette and fade $FC), copies the child species name into wTextBuf0 after the
; fade, and returns to state 1 (BreedMenu_RestoreScreen_Finish). (C1, E-0377)
; BreedMenu screen state $0B: redraws the window, the map's graphics and palettes
; (SendSGBPaletteSetForSGBPaletteSet, StartPaletteFade), the gold box and the monster name
BreedMenu_RestoreScreen::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RestoreScreen_BlankBGMap
    dw BreedMenu_ReturnToMap_LoadTiles
    dw DrawPairAndStep_2_2
    dw BreedMenu_ReturnToMap_LoadMap
    dw BreedMenu_ReturnToMap_RestoreScreen
    dw BreedMenu_RestoreScreen_DrawGoldBox
    dw BreedMenu_RestoreScreen_CopyChildName
    dw BreedMenu_RestoreScreen_Finish

; Restoring the screen, step 5: draws the gold box; on the SGB sends the palette set and starts
; palette fade $FC. (C1, E-0357)
BreedMenu_RestoreScreen_DrawGoldBox::
    call DrawGoldBoxAndStep_Bank15
    ld a, [wIsCGB]
    and a
    jr nz, .return
    farcall SendSGBPaletteSetForSGBPaletteSet
    ld a, $fc
    call StartPaletteFade

.return:
    ret

; Restoring the screen, step 0: fills the BG map with the blank tile. (C1, E-0357)
BreedMenu_RestoreScreen_BlankBGMap::
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

; Restoring the screen, step 6: once the fade has finished, copies the child's species name into
; wTextBuf0 and resets the text window. (C1, E-0357)
BreedMenu_RestoreScreen_CopyChildName::
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
    lb bc, $14, $0d
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

; Restoring the screen, step 7: returns to the breeding menu's state 1 with the text window reset.
; (C1, E-0357)
BreedMenu_RestoreScreen_Finish::
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

; Breeding menu, state 12: runs the record stats screen (SwapMonstersMenu); when it reaches its step
; $0A returns six states on (from step $23) or five. (C1, E-0357)
BreedMenu_RunStatsScreen::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    ld a, [wReturnScreenStep]
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

; Breeding menu, state 13: runs the record stats screen until its step $0A, then goes on two states.
; (C1, E-0357)
BreedMenu_RunStatsScreenAgain::
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

; BreedMenu state $0F, by wScreenStep (nine steps): reloads map $0D tiles and palettes, the glyphs
; and the pair, clears the tile rows, redraws the egg list with its species names and page marks
; (LoadTilesAndDrawRecordListPageMarks), marks the cursor entry, shows the egg fee and restores the
; sprites, returning to the saved screen state and step (BreedMenu_RedrawListScreen_RestoreSprites).
; (C1, E-0377)
; BreedMenu screen state $0F: decompresses graphics, uploads the palette, loads glyph tiles and
; draws the record list page
BreedMenu_RedrawListScreen::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_LoadTileset
    dw BreedMenu_RedrawListScreen_LoadGlyphsAndPair
    dw BreedMenu_RedrawListScreen_ClearTiles
    dw BreedMenu_ChooseEgg_RedrawEggList
    dw BreedMenu_RedrawListScreen_DrawSpeciesNames
    dw LoadTilesAndDrawRecordListPageMarks
    dw BreedMenu_RedrawListScreen_MarkCursorEntry
    dw BreedMenu_RedrawListScreen_ShowEggFee
    dw BreedMenu_RedrawListScreen_RestoreSprites

; Redrawing the list screen, step 0: decompresses map $0D's tileset (bank $47) into VRAM $9000 and
; its background palettes. (C1, E-0357)
BreedMenu_RedrawListScreen_LoadTileset::
    ld hl, vTiles2
    ld de, Map0DTileset
    ld b, $47
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, Map0DPalettes
    ld b, $47
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Redrawing the list screen, step 1: copies the list glyph tiles and redraws the pair. (C1, E-0357)
BreedMenu_RedrawListScreen_LoadGlyphsAndPair::
    ld hl, BreedMenu_ChooseParents_AskYesNo_TileCopyDestList
    ld de, BreedMenu_ChooseParents_AskYesNo_TileCopySrcList
    call CopyGlyphTileListFromBank1F_Bank15
    call DrawPairAndStep_2
    ret

; Redrawing the list screen, step 2: clears the tile rows and resets the window
; (ClearTileRowsAndResetWindowAndStep). (C1, E-0357)
BreedMenu_RedrawListScreen_ClearTiles::
    call ClearTileRowsAndResetWindowAndStep
    ret

; Choosing an egg, step 13: redraws the egg list box, clamps the page cursor of four and draws the
; page arrows and numbers. (C1, E-0357)
BreedMenu_ChooseEgg_RedrawEggList::
    ld de, BreedMenu_ChooseEgg_DrawPageFrame_TileRect
    ld hl, wWindowTileBuffer + $bb
    lb bc, $0d, $09
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

; Redrawing the list screen, step 4: draws the page's species names. (C1, E-0357)
BreedMenu_RedrawListScreen_DrawSpeciesNames::
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Copies the 16-byte tile Tiles2Plus420Tiles from bank $1F to vTiles1 + $4E0, sets wArg1 = wArg2 = 1
; and far-calls DrawRecordListPageMarks (the sex and party marks beside the visible records of the
; page), then adds 1 to wScreenStep. Step 5 of BreedMenu_RedrawListScreen;
; BreedMenu_ChooseEgg_RedrawMarks calls it. (C1, E-0377)
; copies a tile from bank $1F to vTiles1 + $4E0, runs DrawRecordListPageMarks with wArg1 = wArg2 =
; 1, then wScreenStep += 1 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was LoadTilesAndDrawRecordListPageMarks; shortened from
; LoadTileTiles2Plus420TilesAndRunDrawRecordListPageMarks)
LoadTilesAndDrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles
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

; Redrawing the list screen, step 6: marks the cursor entry and draws the yes/no area. (C2, E-0357;
; probed E-0377)
BreedMenu_RedrawListScreen_MarkCursorEntry::
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseEgg_DrawPageFrame_Data
    call StoreBAtWordTableEntry_Bank15
    ld de, BreedMenu_ChooseParents_AskYesNo_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Redrawing the list screen, step 7: writes the egg's fee (from its plus value) and shows string $1B
; (bank $1B). (C1, E-0357)
BreedMenu_RedrawListScreen_ShowEggFee::
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
    farcall ShowBreedingString
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Redrawing the list screen, step 8: reloads the player's sprites, redraws the bottom rows, restores
; the sprite state and hide tile $70, and returns to the saved screen state and step. (C1, E-0357)
BreedMenu_RedrawListScreen_RestoreSprites::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    farcall RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
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

; BreedMenu state $10, by wScreenStep (ten steps): reloads the tiles and glyphs, blanks the name
; tiles, draws the four names, the icon and stats of the entry under the cursor, marks the party
; members and the name and species (the steps of BreedMenu_ReturnToMap), reloads two frame tiles,
; blanks the marks and marks the cursor entry, then restores the sprites and the saved state. (C1,
; E-0377)
; BreedMenu screen state $10: blanks the list marks (BlankWordTableTargets), fills tiles and resets
; the cursor
BreedMenu_ClearListMarks::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_LoadTileset
    dw BreedMenu_RedrawListScreen_LoadGlyphsAndPair
    dw BreedMenu_ClearListMarks_BlankNameTiles
    dw BreedMenu_ReturnToMap_DrawPageNames
    dw BreedMenu_ReturnToMap_DrawIconAndStats
    dw BreedMenu_ReturnToMap_MarkPartyMembers
    dw BreedMenu_ReturnToMap_DrawNameAndSpecies
    dw BreedMenu_ChooseParents_ReloadLinkFrameTiles
    dw BreedMenu_ClearListMarks_MarkCursorEntry
    dw BreedMenu_RedrawListScreen_RestoreSprites

; Clearing the list marks, step 2: blanks the name tiles. (C1, E-0357)
BreedMenu_ClearListMarks_BlankNameTiles::
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

; Choosing parents, step 45: in a link session reloads three frame tiles (as step 61); otherwise
; moves on. (C1, E-0357)
BreedMenu_ChooseParents_ReloadFrameTilesIfLinked::
    ld a, [wLinkMode]
    and a
    jr nz, BreedMenu_ChooseParents_ReloadLinkFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing parents, step 61: (in a link session) reloads three frame tiles and moves on. (C1,
; E-0357)
BreedMenu_ChooseParents_ReloadLinkFrameTiles::
    call BreedMenu_ChooseParents_DrawLinkSprite
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Clearing the list marks, step 8: blanks the four marks, marks the cursor entry and draws the
; yes/no area. (C2, E-0357; probed E-0377)
BreedMenu_ClearListMarks_MarkCursorEntry::
    ld c, $04
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank15
    ld de, BreedMenu_ChooseParents_AskYesNo_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; BreedMenu state $12, by wScreenStep (11 steps): reloads the tiles, lists the possible mates of the
; chosen record by sex (BreedMenu_ShowSelectedRecord_ListMates), copies the glyphs, draws the pair
; names, the page names and the chosen record name and species, computes the child
; (BreedMenu_ChooseParents_ComputeChild), draws the family icons and the yes/no box, then restores
; the sprites and the saved state. (C1, E-0377)
; BreedMenu screen state $12: the selected record's sex bit, family icon, name and species
BreedMenu_ShowSelectedRecord::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_LoadTileset
    dw BreedMenu_ShowSelectedRecord_ListMates
    dw DrawPairAndStep_2
    dw BreedMenu_ShowSelectedRecord_BlankTiles
    dw BreedMenu_ShowSelectedRecord_DrawPairNames
    dw BreedMenu_CopyBoxGlyphTiles
    dw BreedMenu_DrawListPageNames
    dw BreedMenu_ShowSelectedRecord_DrawRecordName
    dw BreedMenu_ChooseParents_ComputeChild
    dw BreedMenu_ShowSelectedRecord_DrawIcons
    dw BreedMenu_RedrawListScreen_RestoreSprites

; Showing the chosen record, step 7: blanks the name tiles and draws the chosen record's name and
; species, then keeps both parents' records. (C1, E-0357)
BreedMenu_ShowSelectedRecord_DrawRecordName::
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld a, [wSelectedRecord]
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    call BreedMenu_CopyParentRecords
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Showing the chosen record, step 9: loads the family icons of the chosen record and of the one
; under the cursor and draws its box. (C1, E-0357)
BreedMenu_ShowSelectedRecord_DrawIcons::
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
    call BreedMenu_DrawYesNoBox
    ret

; Showing the chosen record, step 1: notes the chosen record's sex, lists the possible mates and
; clamps the page. (C1, E-0357)
BreedMenu_ShowSelectedRecord_ListMates::
    call LoadSelectedRecordSex
    call BreedMenu_ListMates
    jp BreedMenu_ListMonsters_UpdateListPages

; Showing the chosen record, step 4: clears three tile rows and draws the pair's names. (C1, E-0357)
BreedMenu_ShowSelectedRecord_DrawPairNames::
    call ClearThreeTileRows
    call DrawListEntriesCell5RecordNamesAndStep
    ret

; BreedMenu state $11, by wScreenStep (ten steps): reloads the tiles and glyphs, lists the farm
; monsters that are not eggs (BreedMenu_ListMonsters_ListNonEggs), blanks the tiles, draws the page
; names, the family, sex and level and the name and species of the entry under the cursor, the
; yes/no box (BreedMenu_DrawYesNoBox), then restores the sprites and the saved state. (C1, E-0377)
; BreedMenu screen state $11: the list of records that are not eggs (ListRecordsInUseNotEggs) with
; page-of-pages
BreedMenu_ListMonsters::
    ld a, [wScreenStep]
    jumptable
    dw BreedMenu_RedrawListScreen_LoadTileset
    dw BreedMenu_RedrawListScreen_LoadGlyphsAndPair
    dw BreedMenu_ListMonsters_ListNonEggs
    dw BreedMenu_ShowSelectedRecord_BlankTiles
    dw BreedMenu_DrawListPageNames
    dw BreedMenu_ChooseParents_DrawFamilySexLevel
    dw BreedMenu_ChooseParents_BlankNameTiles
    dw BreedMenu_ChooseParents_DrawNameAndSpecies
    dw BreedMenu_DrawYesNoBox
    dw BreedMenu_RedrawListScreen_RestoreSprites

; Listing monsters, step 2: lists the farm monsters that are not eggs, then the page (below). (C1,
; E-0357)
BreedMenu_ListMonsters_ListNonEggs::
    farcall ListRecordsInUseNotEggs

; Clamps the list's page cursor; with two or more pages draws the page numbers in the window buffer;
; blanks the five marks and marks the cursor entry. (C1, E-0357)
BreedMenu_ListMonsters_UpdateListPages::
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
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call BlankWordTableTargets
    ld a, [wListCursor]
    ld b, $bc
    ld hl, BreedMenu_ChooseParents_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Showing the chosen record, step 3: blanks three tile areas. (C1, E-0357)
BreedMenu_ShowSelectedRecord_BlankTiles::
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

; Far-calls DrawRecordListPageNames, which draws the names of the visible records of page
; wListPageIndex and adds 1 to wScreenStep. Step 6 of BreedMenu_ShowSelectedRecord and step 4 of
; BreedMenu_ListMonsters. (C1, E-0372)
BreedMenu_DrawListPageNames::
    farcall DrawRecordListPageNames
    ret

; Copies the 8 x 5 yes/no box BreedMenu_ChooseParents_AskYesNo_TileRect into wWindowTileBuffer +
; $110 (CopyRectTo20ByteRows_Bank15) and adds 1 to wScreenStep; it does not redraw the screen. Step
; 8 of BreedMenu_ListMonsters and the end of BreedMenu_ShowSelectedRecord_DrawIcons (step 9 of
; BreedMenu_ShowSelectedRecord). (C2, E-0372; probed E-0377)
; copies the 8 x 5 rectangle BreedMenu_ChooseParents_AskYesNo_TileRect into wWindowTileBuffer + $110
; (CopyRectTo20ByteRows_Bank15), then wScreenStep += 1 (E-0119) (E-0340: the address in its name
; read as its RAM name; was BreedMenu_DrawYesNoBox) (E-0344: the address in its name dropped or read
; as the label there; was BreedMenu_DrawYesNoBox)
BreedMenu_DrawYesNoBox::
    ld de, BreedMenu_ChooseParents_AskYesNo_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; HL = list of VRAM destinations, DE = list of sources, both words and read from entry
; wGlyphListStart: copies one 16-byte tile from bank $1F per entry (CopyFromBankWaitVRAM), adding 1
; to wGlyphListStart, until a destination entry whose first (low) byte is $FF ends the list; then
; clears wGlyphListStart and wGlyphListPos. Unlike CopyGlyphTilesFromLists_Bank14 it copies the
; whole list in one call. (C1, E-0377)
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

; Far-calls DecompressGraphicsArg1ToArg4 with graphics number $00A4 (wArg1 = $A4, wArg2 = 0), wArg3
; = 0 and destination wArg4/wArg5 = $8000 (vTiles0). Called at the end of ShowSaveFileInfoWindow and
; by DecompressA4GraphicsAndContinue. (C1, E-0377)
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

; Outside a link session (wLinkMode 0) returns at once. In one, it enables SRAM bank 1 and, when the
; byte at sSavedPlayerName + $022B is non-zero while wScreenState is 4 and wScreenStep is below $37,
; continues into DrawSpritePart9000At88_28, which disables SRAM and draws sprite part $0090 at ($88,
; $28); otherwise it disables SRAM and returns. (C1, E-0370)
BreedMenu_ChooseParents_DrawLinkSprite::
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

; Selects SRAM bank 0 and disables SRAM, then far-calls DrawSpritePart9000At88_28_SetAttrs with
; wArg1/wArg2 = $0090 (the sprite part), wArg3 = 0, wArg4/wArg5 = ($88, $28) (X, Y), wArg6 = 0 and C
; = 1 (frame 0, no alternation). Called by KeyAppraisalMenu_DrawCompletionMark and
; ExchangeJoypadAndDrawSprites_DrawCompletionMark. (C1, E-0377)
; with SRAM disabled draws sprite part $0090 at ($88, $28) (DrawSpritePart9000At88_28_SetAttrs, C =
; 1) (E-0124)
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
    farcall DrawSpritePart9000At88_28_SetAttrs
    ret

; With wLinkMode 0 only sets wScreenSubStep = 2. In a link: when wScreenSubStep is non-zero first
; copies the 20 x 1 row DrawBottomBoxForLinkAndSetScreenSubStep_TileRect to wWindowTileBuffer + $C8;
; then sets wScreenSubStep = 2 and draws the 20 x 13 screen buffer area at offset $1CC to the BG map
; at the scroll origin. Used by BreedMenu_ChooseParents_ShowLinkPrompt,
; KeyAppraisalMenu_ChooseKey_ShowLinkMessage and RunLinkSession8Exchange_Saving_DrawBottomBox. (C1,
; E-0377)
; outside link battles only sets wScreenSubStep = 2; otherwise copies the row
; DrawBottomBoxForLinkAndSetScreenSubStep_TileRect when wScreenSubStep is set, sets wScreenSubStep =
; 2 and draws the box at scroll + $1CC (E-0124)
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
    ld de, DrawBottomBoxForLinkAndSetScreenSubStep_TileRect
    ld hl, wWindowTileBuffer + $c8
    lb bc, $14, $01
    call CopyRectTo20ByteRows_Bank15

.set_screen_sub_step_to_02:
    ld a, $02
    ld [wScreenSubStep], a
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ret

; Copies the 20 x 11 box CopyRectToWindowTileBufferRow5AndDraw_TileRect into wWindowTileBuffer +
; $64, then draws the 20 x 13 screen buffer area at offset $1CC to the BG map at the scroll origin
; (DrawScreenBufferRect_Bank15). Used by DrawRectIfLinkModeAndStep and two link and key-appraisal
; steps. (C1, E-0377)
; copies the 20 x 11 rectangle CopyRectToWindowTileBufferRow5AndDraw_TileRect into wWindowTileBuffer
; + $64, then DrawScreenBufferRect_Bank15 (20 x 13 at the scroll origin) (E-0119) (E-0340: the
; address in its name read as its RAM name; was CopyRectToWindowTileBufferRow5AndDraw) (E-0344: the
; address in its name dropped or read as the label there; was CopyRectToWindowTileBufferRow5AndDraw)
CopyRectToWindowTileBufferRow5AndDraw::
    ld de, CopyRectToWindowTileBufferRow5AndDraw_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $14, $0b
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank15
    ret

; The three-option cursor of BreedMenu_OptionCursor and EggServiceMenu_ChooseOption. Up and Down
; (wJoypadPressedRepeat) move wGridCursorX over 0-2 with wrap-around and sound $69, a move without
; wrap also clearing wListCursor, wChoiceCursor and wListPageIndex; with no input the cursor blinks
; (BlinkCursorGridCursorY_Bank15). A plays sound $69, draws the arrow tile $BC at the option and
; blanks the three window marks; option 0 or 1 sets wTwoChoiceCursor = the option, adds 1 to
; wScreenState and clears the list cursors. Option 2 and B set wTwoChoiceCursor = 2 and
; wThreeOptionResult = 0 without changing the state; each choice requests script $80. (C1, E-0377)
; up/down moves wGridCursorX over three options with sound $69; A chooses (option 2 cancels), sets
; wTwoChoiceCursor and requests script $80; B cancels (E-0129)
HandleThreeOptionMenuInput_15::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_2
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_22
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call BlinkCursorGridCursorY_Bank15
    ret

.call_draw_blank_tile_c3_2:
    call DrawBlankTileC3_2
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

.call_draw_blank_tile_c3_22:
    call DrawBlankTileC3_2
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
    ld hl, BreedMenu_ChooseParents_RedrawPairBox_Data
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

; Blink of the three-option cursor, using wGridCursorY as its counter: while wJoypadRepeatTimer is
; below $14 draws the cursor tile $BB; otherwise adds 1 to wGridCursorY and draws $BB for 1-$0F, the
; blank $C3 for $10-$17, and at $18 resets it to 0 and draws $BB; the tile goes to option
; wGridCursorX (DrawThreeOptionCursorTile). (C1, E-0377)
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
    jr c, DrawBlankTileC3_2
    xor a
    ld [wGridCursorY], a

.skip:
    ld b, $bb
    jr DrawThreeOptionCursorTile

; B = $C3 (the blank tile), then jumps to DrawThreeOptionCursorTile at option wGridCursorX.
; HandleThreeOptionMenuInput_15 calls it before moving the cursor, and BlinkCursorGridCursorY_Bank15
; jumps to it. (C1, E-0377)
; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_2)
DrawBlankTileC3_2::
    ld b, $c3
    jr DrawThreeOptionCursorTile

; B = $BC (the arrow tile), then falls through to DrawThreeOptionCursorTile, which writes it on the
; BG map at the place of option wGridCursorX (DrawThreeOptionCursorTile_Data).
; HandleThreeOptionMenuInput_15 marks the chosen option with it. (C1, E-0377)
; B = $BC, then writes B at the scroll position + DrawThreeOptionCursorTile_Data[wGridCursorX]
; (E-0124)
DrawArrowTileBCAtGridCursorXEntry_Bank15::
    ld b, $bc

; Writes tile B at the option wGridCursorX's place (DrawThreeOptionCursorTile_Data), waiting for
; VRAM access. (C1, E-0357)
DrawThreeOptionCursorTile::
    ld a, [wGridCursorX]
    add a
    ld hl, DrawThreeOptionCursorTile_Data
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

; Three words that are offsets from the BG map entry at the top left of the visible screen
; (BGMapAddressAtScroll_Bank15): $0021, $0061, $00A1, which are rows 1, 3 and 5 of column 1.
; DrawThreeOptionCursorTile indexes them with wGridCursorX and writes tile B (the cursor or blank
; tile its caller chose) at that entry. (C1, E-0381)
DrawThreeOptionCursorTile_Data::
    db $21, $00, $61, $00, $a1, $00

; HL = destination, C = step: for each of the first wPartyCount entries of wListEntries (index B
; from 0) whose record has MON_STATE 2 (LoadSRAMRecordByte, SRAM bank 0), writes tile $E1 + B at HL
; after rSTAT bit 1 clears and then advances HL by C; an entry in another state leaves HL where it
; is. (C1, E-0370)
BreedMenu_ReturnToMap_MarkPartyMembers_DrawMarks::
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

; Copies a rectangle of B bytes by C rows from DE (packed) to HL, the destination rows 20 bytes
; apart; DE ends past the source, HL and BC are kept. On CGB (wIsCGB non-zero) it also zero-fills
; the same rectangle at HL + $0E68 with rSVBK = 2 (wWindowAttrBuffer for the window buffer) and sets
; rSVBK = 0. (C2, E-0377)
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

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: copies that
; rectangle of the screen buffer to the BG map (CopyRectToBGMapWrapped). Unless wStringIndex is $10,
; $11 or $12 it sets wTextCursorLo/wTextCursorHi = HL + $1C1, replaced by $99C1 when that is $9B61.
; On CGB it then copies the same rectangle of wScreenAttrBuffer (rSVBK = 2) into VRAM bank 1 and
; sets rSVBK and rVBK back to 0. (C1, E-0377)
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8: the BG map entry at the top-left corner of the
; visible screen. Clobbers A and DE. The drawing steps of this bank add their offset to it. (C1,
; E-0377)
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

; Unpacks the BCD number in hTemp3-hTemp0 into seven digits at wArg1, most significant first: wArg1
; = hTemp3 as one digit, then the high and low digits of hTemp2, hTemp1 and hTemp0. Leading zeros
; among the first six become $E3, which callers turn into the blank tile $C3 by adding $E0 (or skip,
; BreedMenu_CopyDigitsToTextBuf); the last digit stays even when 0. The old reading called $E3 the
; blank tile itself. (C2, E-0377)
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
; past the copy, BC = 0. Used by the screen-buffer copies of this bank and BreedMenu_Init. (C2,
; E-0377)
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

; Sets rSVBK = 2, copies BC bytes from DE to HL with each byte ANDed with 7 (the CGB attribute
; palette bits), then sets rSVBK = 0; both addresses are read in WRAM bank 2 when they are in
; $D000-$DFFF. Used for the attribute half of the screen-buffer copies. (C2, E-0377)
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

; HL = table of 16-bit addresses, A = index: writes B at the address in entry A; returns with DE =
; that address and BC kept, A and HL clobbered. The breeding menus use it to put a mark ($BC) or
; blank ($C3) at a list position. (C2, E-0377)
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

; Copies the list's glyph tiles (list $9D) six per call (below). (C1, E-0357)
BreedMenu_CopyParentListGlyphs::
    ld hl, BreedMenu_CopyParentListGlyphs_Data
    ld a, $9d
    jr BreedMenu_CopyGlyphsSixPerCall

; Copies the egg list's glyph tiles (list $9C) six per call (below). (C1, E-0357)
BreedMenu_CopyEggListGlyphs::
    ld hl, BreedMenu_CopyParentListGlyphs_Data
    ld a, $9c

; Copies six glyph tiles per call from the tile list at HL to VRAM (the source offset from
; wArg1/wArg2), then moves on a step when the list ends. (C1, E-0357)
BreedMenu_CopyGlyphsSixPerCall::
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

; DE = offset from the scroll origin: writes tiles $C5, $BE and $C6 to the BG map at
; BGMapAddressAtScroll_Bank15 + DE, + 2 and + 4, each place first corrected by
; StepBGMapAddressBackOnScrollWrap (back one row when it wrapped past column 31) and written with
; interrupts off after WaitForVRAMAccess. Used for the 'page/pages' numbers row of the breeding
; lists. (C1, E-0377)
; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll_Bank15 + DE, two entries apart (E-0121)
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

; Writes $C5 at HL, $BE at HL + 2 and $C6 at HL + 4, leaving the bytes between; HL ends at HL + 4.
; The breeding list steps use it on the window buffer beside DrawC5BEC6AtScrollOffsetDE_Bank15. (C2,
; E-0377)
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

; HL = source, DE = VRAM destination: copies 16 bytes (one tile), each with interrupts off after
; rSTAT bit 1 clears; HL and DE advance, C = 0. Used by ShowSaveFileInfoWindow and
; BreedMenu_CopyGlyphsSixPerCall. (C1, E-0377)
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

; HL = destination offset, DE = source offset (both inside wScreenTileBuffer), C = rows: for each
; row copies BC bytes with B = wArg1 and C = wArg2 (CopyBytesDEToHL_Bank15; every caller here sets
; wArg1 = 0), and on CGB the same bytes of wScreenAttrBuffer (CopyLow3BitsToWRAMBank2_Bank15); rows
; are 20 bytes apart. (C2, E-0370; probed E-0377)
CopyScreenBufferRectWithAttrs_Bank15::
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
    jr nz, CopyScreenBufferRectWithAttrs_Bank15
    ret

; HL = table of 16-bit addresses, C = count: writes the blank tile $C3 at the address in each of the
; first C entries (StoreBAtWordTableEntry_Bank15); C = 0 still blanks entry 0. The breeding menus
; erase their option and list marks with it. (C2, E-0377)
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

; Computes 10 x hTemp0 + 10 (TenTimesTemp0PlusTen), converts it (wDigits, Number24ToPackedBCD) and
; unpacks it to seven digits at wArg1 with leading zeros as $E3 (UnpackBCDToDigitsArg1). The
; breeding and hatching fee from MON_PLUS: BreedMenu_ChooseParents_WriteFee,
; BreedMenu_ChooseEgg_ListCursor and BreedMenu_RedrawListScreen_ShowEggFee. (C2, E-0377)
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

; HL = 10 x hTemp0 + 10 (Multiply8, then adds 10); hTemp0 is a MON_PLUS value, so this is the
; breeding or hatching fee. Clobbers A, B and C. (C2, E-0377)
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

; Copies the four bytes wArg4-wArg7 (the last four digits from UnpackBCDToDigitsArg1) to wTextBuf0,
; skipping every $E3, and ends it with $F0, so the fee prints without leading blanks. (C2, E-0377)
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

; wGoldHi:wGoldMid:wGoldLo -= the 24-bit amount wArg3:wArg2:wArg1, with no floor (the callers check
; the gold first, for example IsAmountInArg1AboveGold); an amount above the gold wraps. Used for the
; breeding and hatching fees, the arena entry fee and other payments. (C2, E-0377)
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

; B = SRAM record: with SRAM bank 0 enabled reads its MON_FAMILY byte, sets wWorkBuf = the family
; (low 4 bits) and wWorkBuf + 1 = wArg1 (the tile number), and far-calls
; LoadFamilyIconTileForWorkBuf to write the family icon to that VRAM tile; then disables SRAM. (C1,
; E-0377)
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

; Record wArg1, with SRAM bank 0 enabled (left enabled): writes the sex mark $CC + (MON_SEX & 1) at
; the address in wArg2/wArg3 and, three bytes on, MON_LEVEL as two digit tiles ($E0 + digit,
; HLToDecimalDigits and BlankLeadingZeroDigits_F_Bank15, so a leading 0 becomes the blank $C3);
; returns with B = wArg1 and C kept. Used by the breeding lists and the link breeding panel. (C2,
; E-0377; probed E-0384)
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

; When wDigits is 0 sets it to $E3, and then when wDigits + 1 is 0 too sets that to $E3; a non-zero
; digit stops it. Adding the $E0 digit-tile base turns $E3 into the blank tile $C3, so leading zeros
; of a three-digit number (HLToDecimalDigits) are blank. (C2, E-0377)
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

; Index = the word wArg1/wArg2, field = the address in wArg3/wArg4: TestBitInFieldAtArg3 (which also
; sets wArg5), then ORs the mask into the byte, setting bit index of the field (byte index / 8, mask
; $80 >> (index & 7)). Used when a breeding or received record is stored, on the species bit fields.
; (C2, E-0377)
; TestBitInFieldAtArg3, then ORs its mask into the byte, setting bit wArg1/wArg2 of the field at
; wArg3/wArg4 (E-0114)
SetBitInFieldAtArg3::
    call TestBitInFieldAtArg3
    ld a, [hl]
    or b
    ld [hl], a
    ret

; Index = the word wArg1/wArg2, field = the address in wArg3/wArg4: HL = field + index / 8 and B =
; the mask TestBitInFieldAtArg3_Data[index & 7] ($80 first); returns A = wArg5 = $FF when that bit
; is set, else 0. Note the order is the reverse of wSpeciesFlags (TestSpeciesFlag uses 1 << (id &
; 7)). (C2, E-0377)
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

; Eight single-bit masks $80, $40, $20, $10, $08, $04, $02, $01. TestBitInFieldAtArg3 takes the bit
; number in wArg1:wArg2, finds the byte at wArg3:wArg4 plus bit number / 8, ANDs it with entry (bit
; number AND 7) and sets wArg5 to $FF when the bit is set, else 0; bit 0 of the field is therefore
; the top bit of its first byte. (C1, E-0381)
TestBitInFieldAtArg3_Data::
    db $80, $40, $20, $10, $08, $04, $02, $01

; Lists the possible mates: clears both lists, then lists every farm or party record that is not an
; egg and whose sex differs from wArg1 (counting the eggs in wRecordsFlagged), and moves the party
; members to the front. (C2, E-0357; probed E-0384)
BreedMenu_ListMates::
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

; With SRAM bank 0 enabled reads MON_SEX of record wSelectedRecord (LoadSRAMRecordByte), sets wArg1
; = its bit 0 (the sex) and disables SRAM. Used by BreedMenu_ChooseParents_ListPartners and
; BreedMenu_ShowSelectedRecord_ListMates to list mates of the other sex. (C2, E-0377; probed E-0384)
; with SRAM bank 0 enabled: wArg1 = bit 0 of byte $0E of record wSelectedRecord (LoadSRAMRecordByte)
; (E-0119) (E-0345: record byte $0E bit 0 is the sex (MON_SEX); was LoadSelectedRecordSex)
LoadSelectedRecordSex::
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

; Fills tile areas with the plain pattern tile (FillTilesBxC): 4 tiles at vTiles2 + $7C0, 3 at
; vTiles1 + $400 and 2 at vTiles1 + $4A0, then falls through to ClearTileAreas2700_1750_17D0 (9 at
; vTiles2 + $700, 3 at vTiles1 + $750, 2 at vTiles1 + $7D0). Used before the breeding pair names are
; redrawn. (C1, E-0377)
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

; Fills tile areas with the plain pattern tile (FillTilesBxC): 9 tiles at vTiles2 + $700, 3 at
; vTiles1 + $750 and 2 at vTiles1 + $7D0. ClearThreeTileRows falls into it;
; BreedMenu_ChooseParents_StartCountingScript and _RedrawPair call it. (C1, E-0377)
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

; Fills tile areas with the plain pattern tile (FillTilesBxC): 12 tiles at vTiles1 + $240, 13 at
; vTiles1 + $700 and 17 at vTiles1 + $4E0. Called by BreedMenu_ChooseParents_ClearList before the
; list is drawn. (C1, E-0377)
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

; Record wArg1, with SRAM bank 0 enabled: copies its MON_NAME into wNameGlyphBuf
; (CopyRecordNameToNameGlyphBuf, $F0 at + $A) and draws it with wArg5 = 2, then copies the name of
; its species (MON_SPECIES, CopyMonsterNameToBuffer_B15) and draws it with wArg5 = 3
; (DrawNameGlyphBufGlyphsOverlaying8DAnd8E_Bank1D, which ORs the marks $8D/$8E onto the glyph
; before); then disables SRAM. Far-called by DrawListEntriesCell5RecordNamesAndStep. (C1, E-0377)
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

; Copies the chosen base (wSelectedRecord) into wRecordBufA and the mate under the cursor into
; wRecordBufB ($A5 bytes each) for ComputeBreedingChild. (C2, E-0357; probed E-0384)
BreedMenu_CopyParentRecords::
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

; HL = monster (species) number: reads the pointer of the monster names from entry 2 of
; StringDatabase in bank $08 (wDataBank set to 8 and restored), then the name pointer at that list +
; 2 x HL, and copies 16 bytes of that string from bank $08 to wNameGlyphBuf (CopyFromBankWaitVRAM).
; Used by DrawRecordNameAndSpeciesName and the breeding child steps. (C1, E-0377)
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

; Clears the text tiles and checks the save (CheckSaveData). Without a valid save it shows string
; $28 ('Unused.') and sets wScreenSubStep = 1. With one it draws the window: the saved name of the
; player and the glyphs 'Mast' and 'er', a 2 x 2 mark when sSavedGameCompleted is set, for each
; saved party member (sSavedPartyCount, sSavedPartyList, compact records in SRAM bank 1) its name,
; family icon and level, the play time (the word at sSavedPlayTime + 3 as three digits and the byte
; at + 2 as two digits) and the place: for saved map 3 a key world name (sSavedMapType bit 7, from
; sSavedKeyList, string 5 of category 8) or string $0D, otherwise string map + $0A
; (ShowString_Bank08). Then loads graphics $A4 (DecompressGraphicsA4ToTiles0), resets the text
; window and sets wScreenSubStep = 0. Used by the link save prompts (breeding, key appraisal, link
; exchange). (C1, E-0377)
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
    ld [wStringIndex], a
    farcall ShowBreedingString
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
    ld de, ShowSaveFileInfoWindow_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $14, $0b
    call CopyRectTo20ByteRows_Bank15
    ld hl, sSavedPlayerName
    ld de, $022b
    add hl, de
    ld a, [hl]
    and a
    jr z, .skip2
    ld hl, ShowSaveFileInfoWindow_Tiles
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
    ld hl, ShowSaveFileInfoWindow_Data3
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
    ld hl, ShowSaveFileInfoWindow_Data2
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
    ld hl, ShowSaveFileInfoWindow_Data1
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

; Three words, addresses of cells in wWindowTileBuffer (rows of 20 bytes): $C3A8, $C3D0, $C3F8,
; which are rows 8, 10 and 12 of column 8. ShowSaveFileInfoWindow indexes them with the entry number
; (0 up to the count byte read at sSavedPlayerName + $F1) and stores tile $EA in the cell and tile
; $ED in the cell after it. (C1, E-0381)
ShowSaveFileInfoWindow_Data1::
    db $a8, $c3, $d0, $c3, $f8, $c3

; Writes the digits at DE as tiles $E0 + digit from HL on (one per byte, with interrupts off after
; WaitForVRAMAccess), counting C up to B; HL and DE advance. ShowSaveFileInfoWindow draws the play
; time with it. (C1, E-0377)
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

; With SRAM bank 1 enabled reads the record number at HL + C and returns HL = sBank1Records + $6F x
; that number (a compact record of the saved party); then selects SRAM bank 0 and disables SRAM.
; Clobbers A, B, C and DE. Used by ShowSaveFileInfoWindow for the saved party list. (C2, E-0377;
; probed E-0384)
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

; Three words, addresses in wWindowTileBuffer: $C3AA, $C3D2, $C3FA, which are rows 8, 10 and 12 of
; column 10. For each saved entry ShowSaveFileInfoWindow takes the number in byte $62 of its record
; (masked with $7F), makes digit tiles ($E0 + digit) with HLToDecimalDigits and writes the tens
; digit (only when it is not 0) at the word picked by the entry number and the ones digit in the
; next cell. (C1, E-0381)
ShowSaveFileInfoWindow_Data2::
    db $aa, $c3, $d2, $c3, $fa, $c3

; Three words, VRAM tile addresses $8D00, $8D50, $8DA0 (vTiles1 + $500, + $550, + $5A0).
; ShowSaveFileInfoWindow loads the name of saved entry c with LoadRecordNameEntry0 and
; CopyGlyphTilesToVRAM draws its glyph tiles at word c, c being the entry number. (C1, E-0381)
ShowSaveFileInfoWindow_Data3::
    db $00, $8d, $50, $8d, $a0, $8d

; Restores what wSavedPlayerState holds: + 1-3 to hPlayerX, hPlayerY and hPlayerFacing, + 4-6 to
; wFollowerRecords + 0-2, + 7-9 to wFollowerRecords + 5-7, + $A-$C to wFollowerRecords + $A-$C, and
; + 0 to wSpriteSlots + 7; then clears wSavedPositionValid. Called by
; BreedMenu_ReturnToMap_LoadTiles and _LoadMap. (C2, E-0377)
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

; For each of the pointers wCounterPtr0Lo/wCounterPtr0Hi and wCounterPtr1Lo/wCounterPtr1Hi (skipped
; when its high byte is $FF or the word is 0): adds 1 to the byte it points to unless that byte is
; already 99 or more, and then stores wCounterArg0 / wCounterArg1 in the byte before. With pointers
; from PrepareCounterEntry this adds one item (the id) to a vault entry (count). Called by
; BreedMenu_ChooseParents_Breed, NpcBreedMenu_ChooseAndBreed_ReplaceParent and
; RunScreenStateWhenNotFading_F1_BreedStoreChild. (C2, E-0377)
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

; Clears the six bytes wCounterPtr0Lo-wCounterArg1, enables SRAM bank 0 and clears wArg1; when
; wRecordBufA + MON_ITEM (the equipped item) is non-zero prepares counter 0 for it
; (PrepareCounterEntry), and outside a link (wLinkMode 0) counter 1 for wRecordBufB + MON_ITEM;
; disables SRAM, sets wTwoChoiceCursor = wArg1 (1 when an entry was prepared), adds 1 to
; wScreenSubStep and requests script $80. In link breeding
; (RunScreenStateWhenNotFading_F1_BreedAskToRecord) a prepared entry is followed by '*: Accessories
; will be in the Vault.' (C2, E-0377)
; clears wCounterPtr0Lo-wCounterArg1, fills them through PrepareCounterEntry for wRecordBufA + $A4
; and (outside link battles) wRecordBufB + $A4, wTwoChoiceCursor = wArg1, wScreenSubStep += 1 and
; requests script $80 (E-0125) (E-0340: the address in its name read as its RAM name; was
; PrepareCounterPtr0LoCountersAndRequestScript)
PrepareCounterPtr0LoCountersAndRequestScript::
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
    call nz, PrepareCounterEntry
    ld a, [wLinkMode]
    and a
    jr nz, .skip
    ld de, wCounterPtr1Lo
    ld a, [wRecordBufB + MON_ITEM]
    and a
    call nz, PrepareCounterEntry

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

; A = equipped item (MON_ITEM), DE = wCounterPtr0Lo or wCounterPtr1Lo: hTemp0 = A + $3F, the item
; id. Walks the 100 entries of wItemStorage and stops at the first that holds that item or is empty
; (id 0): for the item it takes the entry when the count is below 99, else writes $FF, $FF at DE (no
; counter); an empty entry is taken, except that for the second counter one already taken by counter
; 0 for a different item is passed over. A taken entry writes the address of its count byte and then
; the item at DE and sets wArg1 = 1; with no entry found it writes $FF, $FF. (C2, E-0377)
PrepareCounterEntry::
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
BreedMenu_Setup_DrawOptionBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a4, $a5, $ee, $ee, $a6, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a7, $a8, $a9, $aa, $ab, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $ac, $ad, $ae, $a9, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

BreedMenu_ChooseParents_DrawOptionBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 13 x 9 tiles, one row per line
BreedMenu_ChooseEgg_DrawEggList_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

BreedMenu_ChooseEgg_DrawPageFrame_TileRect::
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
CopyRectToWindowTileBufferRow5AndDraw_TileRect::
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

ShowSaveFileInfoWindow_TileRect::
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
DrawBottomBoxForLinkAndSetScreenSubStep_TileRect::
    db $b6, $c3, $c3, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $d9, $da, $db, $dc, $dd, $de, $b7 ; id 0

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 3 tiles, one row per line
DrawGoldBoxAndStep_Bank15_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
CloseBreedMenu_RestoreGlyphs_TileCopyDestList::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0 ; entry 0
    dw vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $6e0, vTiles1 + $6f0, rIE

; record: bank-$1F tile sources
DrawPairAndStep_2_TileCopySrcList::
    dw GlyphFont + $b0, GlyphFont + $350, GlyphFont + $270, GlyphFont + $110, GlyphFont + $240, GlyphFont + $370, GlyphFont + $260, GlyphFont + $2b0 ; entry 0
    dw GlyphFont + $e0, GlyphFont + $3b0, GlyphFont + $2c0, GlyphFont + $280, GlyphFont + $900, $ffff

BreedMenu_ChooseParents_AskYesNo_TileCopyDestList::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

BreedMenu_ChooseParents_AskYesNo_TileCopySrcList::
    dw GlyphFont + $120, GlyphFont + $310, GlyphFont + $290, GlyphFont + $320, GlyphFont + $180, GlyphFont + $140, $ffff ; entry 0

CloseBreedMenu_RestoreGlyphs_TileCopySrcList::
    dw GlyphFont + $120, GlyphFont + $170, GlyphFont + $f0, GlyphFont + $180, GlyphFont + $1d0, GlyphFont + $e0, GlyphFont + $1c0, GlyphFont + $140 ; entry 0
    dw GlyphFont + $150, GlyphFont + $190, GlyphFont + $a0, GlyphFont + $900, GlyphFont + $900, $ffff

BreedMenu_CopyParentListGlyphs_Data::
    db $00, $8c, $10, $8c, $20, $8c, $70, $8c, $80, $8c, $90, $8c, $a0, $8c, $b0, $8c
    db $ff, $ff

BreedMenu_ChooseParents_RedrawPairBox_Data::
    db $79, $c3, $a1, $c3, $c9, $c3

BreedMenu_ChooseEgg_DrawPageFrame_Data::
    db $d0, $c3, $f8, $c3, $20, $c4, $48, $c4

BreedMenu_ReturnToMap_AddChildToParty_Data::
    db $27, $c4, $4f, $c4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 2 x 3 tiles, one row per line
BreedMenu_ChooseEgg_DrawOptionFrame_TileRect::
    db $c3, $b7 ; id 0
    db $c3, $b7 ; id 1
    db $b4, $b5 ; id 2

; record: 4 x 3 tiles, one row per line
BreedMenu_ChooseEgg_DrawOptionFrame_TileRect_2::
    db $c3, $c3, $c3, $b7 ; id 0
    db $c3, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b5 ; id 2

; record: 8 x 5 tiles, one row per line
BreedMenu_ChooseParents_AskYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $70, $71, $72, $73, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $74, $75, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

BreedMenu_ChooseParents_DrawYesNoArea_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

BreedMenu_ChooseParents_ShowCursorMark_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; record: 6 x 5 tiles, one row per line
BreedMenu_ChooseParents_DrawPayYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $77, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 9 tiles, one row per line
BreedMenu_ReturnToMap_ClearPartyBox_TileRect::
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
BreedMenu_ReturnToMap_DrawIconAndStats_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $f5, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $f6, $f7, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; id 7
BreedMenu_ReturnToMap_DrawYesNoBox_Data::
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 8 x 11 tiles, one row per line
BreedMenu_ChooseParents_ClearList_TileRect::
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

; The first four rows (48 bytes) of a 12-wide box: top frame, tile ids $F8-$FC, $EA, $ED, a blank
; row, and the family icon tile $C7 with $A7-$AF. The rows below are labelled
; BreedMenu_ChooseParents_DrawLowerBox_Data and BreedMenu_ChooseParents_DrawPairBox_Data.
; BreedMenu_ChooseParents_DrawFamilySexLevel copies 12 x 9 from here (through the end of
; BreedMenu_ChooseParents_DrawPairBox_Data) to wWindowTileBuffer + $BC; a second reader at
; bank15:1230 copies only its top row (12 x 1) to the same place. (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
BreedMenu_FamilySexLevelTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
BreedMenu_ChooseParents_DrawLowerBox_Data::
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 4
BreedMenu_ChooseParents_DrawPairBox_Data::
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 12 x 3 tiles, one row per line
BreedMenu_ChooseParents_DrawBaseFrame_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2

BreedMenu_ChooseParents_ClearBoxes_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c9, $7c, $7d, $7e, $7f, $c0, $c1, $c2, $ca, $cb, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2

; record: 12 x 5 tiles, one row per line
BreedMenu_ChooseParents_ClearBoxes_TileRect_2::
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 0
    db $b6, $f5, $f6, $f7, $fd, $fe, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $ff, $77, $78, $70, $71, $72, $73, $74, $75, $76, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; A bit field of 48 bytes (384 bits, one per species id, bit $80 first in each byte); 237 bits are
; set, all for ids below 348. TestBitInFieldAtArg3 reads it with the species id in wArg1/wArg2. In
; BreedMenu_ChooseParents_ComputeChild a set bit shows the child's species name and family icon
; instead of '?????????'; in BreedMenu_ChooseParents_CheckChildIsNew and
; NpcBreedMenu_ChooseAndBreed_ComputeChild_PickMsg a set bit gives answer 0 and the '<species>
; +<plus>' text. The bank-$0D reader passes this bank-$15 address to the far-called
; TestBitInFieldAtArg3, which is in bank $15. (C1, E-0372)
BreedShowNameSpeciesBits::
    db $ff, $ff, $dc, $00, $0f, $ff, $ff, $f1, $01, $ff, $ff, $3f, $36, $3f, $ff, $e2
    db $88, $07, $ff, $ff, $c3, $00, $ff, $ff, $fc, $40, $1f, $ff, $fe, $f8, $83, $ff
    db $fe, $63, $00, $7f, $fb, $f9, $f9, $0f, $ff, $ff, $c4, $30, $00, $00, $00, $00

; record: 8 x 5 tiles, one row per line
BreedMenu_ChooseParents_RedrawPair_TileRect::
    db $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; A 6 x 5 tile rectangle (30 bytes): two rows of blanks ending in the right border $B7, a bottom
; border row ($B4, corner $B5), tile ids $72-$76 with $B7, and another bottom border row.
; BreedMenu_ChooseParents_DrawLinkBoxAndSprites copies it to wWindowTileBuffer + $112
; (CopyRectTo20ByteRows_Bank15) on every call, before DrawRectIfLinkModeAndStep. (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
BreedMenu_ChooseParents_CloseBoxTileRect::
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 2
    db $72, $73, $74, $75, $76, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; HL = $763B and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
ShowSaveFileInfoWindow_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_Breed::
    script_command SCRIPT_BREED
Script_Breed_2::
    script_command SCRIPT_BREED
    script_choice_jump Script_WhichWillBeThe, Script_ToBreed_13, Script_BecomeAGreatMaster
Script_BecomeAGreatMaster::
    script_command SCRIPT_BREED_CLOSE
    script_message $8020 ; '*: Become a great master!'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_ToBreed_13::
    script_jump Script_Breed_13
Script_WhichWillBeThe::
    script_message $c002 ; '*: Which will be the base'
Script_Breed_3::
    script_command SCRIPT_BREED
    script_choice_jump Script_ThisIsTheOne, Script_IsThereAnythingElse
Script_IsThereAnythingElse::
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_2
Script_ThisIsTheOne::
    script_message $c003 ; '*: This is the one you'
    script_command SCRIPT_BREED
Script_ChoiceJump_3::
    script_choice_jump Script_Breed_4, Script_Breed_5, Script_WhichWillBeThe_2
Script_WhichWillBeThe_2::
    script_message $c002 ; '*: Which will be the base'
    script_command SCRIPT_BREED
    script_jump Script_Breed_3
Script_Breed_4::
    script_command SCRIPT_BREED
    script_jump Script_ChoiceJump_3
Script_Breed_5::
    script_command SCRIPT_BREED
    script_choice_jump Script_AndWhatWillIts, Script_YouWon, Script_That, Script_There
Script_There::
    script_message $c008 ; '*: There's no potential mate.'
Script_WhichWillBeThe_3::
    script_message $c002 ; '*: Which will be the base'
    script_command SCRIPT_BREED
    script_jump Script_Breed_3
Script_That::
    script_message $c006 ; '*: That's too low in level'
    script_jump Script_WhichWillBeThe_3
Script_YouWon::
    script_message $c005 ; '*: You won't have a monster'
    script_jump Script_WhichWillBeThe_3
Script_AndWhatWillIts::
    script_message $c007 ; '*: And what will its mate'
Script_Breed_6::
    script_command SCRIPT_BREED
    script_choice_jump Script_ThisIsTheOne_2, Script_WhichWillBeThe_4
Script_WhichWillBeThe_4::
    script_message $c002 ; '*: Which will be the base'
    script_command SCRIPT_BREED
    script_jump Script_Breed_3
Script_ThisIsTheOne_2::
    script_message $c003 ; '*: This is the one you'
Script_Breed_7::
    script_command SCRIPT_BREED
    script_choice_jump Script_Breed_8, Script_Breed_9, Script_AndWhatWillIts_2
Script_AndWhatWillIts_2::
    script_command SCRIPT_BREED
    script_message $c007 ; '*: And what will its mate'
    script_command SCRIPT_BREED
    script_jump Script_Breed_6
Script_Breed_8::
    script_command SCRIPT_BREED
    script_jump Script_Breed_7
Script_Breed_9::
    script_command SCRIPT_BREED
    script_choice_jump Script_Breed_10, Script_YouWon_2, Script_YouWon_2, Script_That_2
Script_That_2::
    script_message $c006 ; '*: That's too low in level'
    script_jump Script_AndWhatWillIts_2
Script_YouWon_2::
    script_message $c005 ; '*: You won't have a monster'
    script_jump Script_AndWhatWillIts_2
Script_Breed_10::
    script_command SCRIPT_BREED
    script_choice_jump Script_HeroWillResultFrom, Script_AGreatMonsterWill
Script_AGreatMonsterWill::
    script_message $c00a ; '*: A great monster will be'
    script_jump Script_Breed_11
Script_HeroWillResultFrom::
    script_message $c009 ; '*: 0 will result from this.'
    script_command SCRIPT_BREED
    script_choice_jump Script_YouAlreadyHadThat, Script_You_2
Script_You_2::
    script_message $c00c ; '*: You've never had that monster.'
    script_jump Script_Breed_11
Script_YouAlreadyHadThat::
    script_message $c00b ; '*: You already had that monster.'
Script_Breed_11::
    script_command SCRIPT_BREED
    script_choice_jump Script_ToBreed_12, Script_AccessoriesWillBeIn
Script_ToBreed_12::
    script_jump Script_Breed_12
Script_AccessoriesWillBeIn::
    script_message $c029 ; '*: Accessories will be in the'
Script_Breed_12::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_choice_jump Script_HatchingThatWillCost, Script_IsThereAnythingElse_2
Script_IsThereAnythingElse_2::
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_2
Script_HatchingThatWillCost::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_message $c00f ; '*: Hatching that will cost 0G.'
    script_command SCRIPT_BREED
    script_choice_jump Script_I_2, Script_IWon, Script_YouDon_2
Script_I_2::
    script_message $c010 ; '*: I'll hatch the egg too,'
    script_jump Script_Breed_18
Script_YouDon_2::
    script_message $c012 ; '*: You don't have enough gold,'
    script_jump Script_YouGotTheEgg
Script_IWon::
    script_message $c011 ; '*: I won't hatch the egg,'
Script_YouGotTheEgg::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
    script_message $401e ; '*: You got the egg of'
    script_message $c019 ; '*: 0 is going to the'
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_jump Script_Breed_2
Script_Breed_13::
    script_command SCRIPT_BREED
    script_choice_jump Script_WhichEggShouldI, Script_ThereIsn
Script_ThereIsn::
    script_message $c01c ; '*: There isn't a single egg'
    script_message $c004 ; '*: Is there anything else?'
    script_jump Script_Breed_2
Script_WhichEggShouldI::
    script_message $c01a ; '*: Which egg should I hatch?'
Script_Breed_14::
    script_command SCRIPT_BREED
    script_choice_jump Script_ThatWillCostHero, Script_IsThereAnythingElse_3
Script_IsThereAnythingElse_3::
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_2
Script_ThatWillCostHero::
    script_message $c01b ; '*: That will cost 0G. OK?'
Script_Breed_15::
    script_command SCRIPT_BREED
    script_choice_jump Script_Breed_16, Script_Breed_17, Script_WhichEggShouldI_2
Script_WhichEggShouldI_2::
    script_message $c01a ; '*: Which egg should I hatch?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_14
Script_Breed_16::
    script_command SCRIPT_BREED
    script_jump Script_Breed_15
Script_Breed_17::
    script_command SCRIPT_BREED
    script_choice_jump Script_FineFineJustWait, Script_YouDon_3
Script_YouDon_3::
    script_message $c01d ; '*: You don't have enough gold.'
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_2
Script_FineFineJustWait::
    script_message $c021 ; '*: Fine, fine. Just wait here.'
Script_Breed_18::
    script_command SCRIPT_BREED
    script_command SCRIPT_BREED
Script_WillYouTakeHero::
    script_message $4014 ; '*: Will you take 0 with'
    script_command SCRIPT_BREED
    script_choice_jump Script_Breed_19, Script_I_3
Script_I_3::
    script_message $c016 ; '*: I'll send 0 to the'
Script_IsThereAnythingElse_4::
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_2
Script_Breed_19::
    script_command SCRIPT_BREED
    script_choice_jump Script_WhichWillGoBack, Script_RaiseItWithLove
Script_RaiseItWithLove::
    script_message $c015 ; '*: Raise it with love and'
    script_jump Script_IsThereAnythingElse_4
Script_WhichWillGoBack::
    script_message $c017 ; '*: Which will go back to'
Script_Breed_20::
    script_command SCRIPT_BREED
    script_choice_jump Script_IsThisTheOne, Script_Breed_21
Script_Breed_21::
    script_command SCRIPT_BREED
    script_jump Script_WillYouTakeHero
Script_IsThisTheOne::
    script_message $c018 ; '*: Is this the one to'
Script_Breed_22::
    script_command SCRIPT_BREED
    script_choice_jump Script_Breed_23, Script_HeroIsGoingTo, Script_WhichWillGoBack_2
Script_WhichWillGoBack_2::
    script_command SCRIPT_BREED
    script_message $c017 ; '*: Which will go back to'
    script_jump Script_Breed_20
Script_Breed_23::
    script_command SCRIPT_BREED
    script_jump Script_Breed_22
Script_HeroIsGoingTo::
    script_command SCRIPT_BREED
    script_message $c019 ; '*: 0 is going to the'
    script_command SCRIPT_BREED
    script_message $c004 ; '*: Is there anything else?'
    script_command SCRIPT_BREED
    script_jump Script_Breed_2

; Counts the sleepers: the compact records with byte 0 bit 7 set (29 in bank 0, one in bank 1) into
; wListCount, after clearing wListEntries. (C2, E-0357; probed E-0384)
HibernateMenu_CountSleepers::
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

; Draws the sleeper list's page: for each entry on the page loads its name from the compact record
; (LoadRecordNameEntry0) and copies its glyphs to the row's tiles. (C1, E-0357)
HibernateMenu_DrawSleeperPage::
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
    call HibernateMenu_DrawSleeperPage_FifthNameGlyphs
    jr .restore

.skip:
    ld a, c
    sla a
    ld hl, HibernateMenu_DrawSleeperPage_Data
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

; Five words, VRAM tile addresses $8D00, $8D50, $8DA0, $8F00 and $8A40 (vTiles1 + $500, $550, $5A0,
; $700, $240). HibernateMenu_DrawSleeperPage draws the name of sleeper c of the page with
; CopyGlyphTilesToVRAM at word c for c = 0 to 3; the fifth sleeper goes to
; HibernateMenu_DrawSleeperPage_FifthNameGlyphs, which does not read this table, so the last word is
; not reached from here. (C1, E-0381)
HibernateMenu_DrawSleeperPage_Data::
    db $00, $8d, $50, $8d, $a0, $8d, $00, $8f, $40, $8a

; Draws the fifth sleeper name of the page: copies the glyphs of wNameGlyphBuf (GlyphFont, bank $1F)
; one by one to the VRAM tiles listed in GlyphCopyArgsForA_Bank15_Data ($8A40, $8A50, $8A60, $8CE0,
; $8CF0), ORing a voicing mark ($8D or $8E) onto the tile of the glyph before it instead of giving
; it a tile; stops at $F0 and clears wGlyphListPos and wGlyphListStart. (C1, E-0370)
HibernateMenu_DrawSleeperPage_FifthNameGlyphs::
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

; A = glyph: returns the arguments of a CopyFromBank copy of its tile: DE = GlyphFont + 16 x A, HL =
; the VRAM address in entry wGlyphListStart of GlyphCopyArgsForA_Bank15_Data ($8A40, $8A50, $8A60,
; $8CE0, $8CF0), B = $1F (the bank) and C = $10 (bytes). Used by
; HibernateMenu_DrawSleeperPage_FifthNameGlyphs. (C2, E-0377)
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
    ld hl, GlyphFont
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

; Five words, VRAM tile addresses $8A40, $8A50, $8A60, $8CE0, $8CF0 (vTiles1 + $240, $250, $260,
; $4E0, $4F0). GlyphCopyArgsForA_Bank15 returns the word numbered wGlyphListStart as the destination
; of the glyph tile it is asked to copy; HibernateMenu_DrawSleeperPage_FifthNameGlyphs advances
; wGlyphListStart for each ordinary glyph and not for the mark glyphs $8D and $8E, so the first five
; tiles of the fifth sleeper name land at these addresses. (C1, E-0381)
GlyphCopyArgsForA_Bank15_Data::
    db $40, $8a, $50, $8a, $60, $8a, $e0, $8c, $f0, $8c

; Sleeper wArg1: with SRAM enabled finds its compact record (RecordAddressWithBank1Slot1D) and sets
; wWorkBuf = its first byte & $0F (the family) and wWorkBuf + 1 = $C7, far-calls
; LoadFamilyIconTileForWorkBuf (icon to tile $C7), then disables SRAM. Used by
; HibernateMenu_ChooseRecords_DrawSleeperStats. (C1, E-0377)
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

; Draws a sleeper's stats box from its compact record (RecordAddressWithBank1Slot1D): the sex mark,
; the level and the packed stat fields as digits. (C2, E-0357; probed E-0384)
HibernateMenu_DrawSleeperStatsBox::
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
    call BlankLeadingZeroDigits_F_Bank15_2
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
    call BlankLeadingZeroDigits_F_Bank15_2
    pop bc
    ld a, c
    sla a
    ld hl, HibernateMenu_DrawSleeperStatsBox_Data
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

; Four words, addresses of cells in wWindowTileBuffer (rows of 20 bytes): $C3D4, $C3D8, $C3FC,
; $C400, which are row 10 column 12, row 10 column 16, row 12 column 12 and row 12 column 16.
; HibernateMenu_DrawSleeperStatsBox unpacks four values of the record from
; RecordAddressWithBank1Slot1D (low bytes at offsets $57 to $5A, two high bits each in $5B) and
; draws value c as three digit tiles ($E0 + digit, leading zeros blanked) starting at word c. (C1,
; E-0381)
HibernateMenu_DrawSleeperStatsBox_Data::
    db $d4, $c3, $d8, $c3, $fc, $c3, $00, $c4

; B = sleeper slot: HL = sCompactRecords + $6F x B with SRAM bank 0 selected, except slot $1D, which
; is sRecords with SRAM bank 1 selected. A = 0 or 1, the bank. Used by the hibernation sleeper
; drawing routines. (C2, E-0377)
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

; Draws a sleeper's name and its species name (from StringDatabase entry 4 in bank $08) from its
; compact record into VRAM. (C1, E-0357)
HibernateMenu_DrawSleeperNameTiles::
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

; The same as BlankLeadingZeroDigits_F_Bank15: wDigits 0 becomes $E3, then wDigits + 1 when it is 0
; too, so the leading zeros of a three-digit number draw as the blank tile $C3 after the $E0 digit
; base. Used by HibernateMenu_DrawSleeperStatsBox; padding fills the rest of the bank after it. (C2,
; E-0377)
; when wDigits is 0 it becomes $E3, and then when wDigits + $1 is 0 too it becomes $E3: a digit byte
; of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros
; are blanked (E-0093) (the same 23 bytes appear in 2 banks)
BlankLeadingZeroDigits_F_Bank15_2::
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
