; ROM bank $1E: the monster swap menu
; The annotated listing of this bank is build/listing/bank1e.asm.

SECTION "Bank 1E", ROMX
    db $1e

; Runner of script command E9 (SCRIPT_MENU_CLOSE), which ends a menu session: wScreenList picks one
; of four steps, CloseMenuE9_RestoreScreen, CloseMenuE9_RestoreGlyphs, CloseMenuE9_LoadTiles and
; CloseMenuE9_RedrawNamesAndFinish; steps 0 and 2 add 1 to wScreenList themselves, step 1 far-calls
; CloseBreedMenu, which advances it, and step 3 far-calls CloseBreedMenu, which finishes the close
; and clears it. Far-called by ScriptCommandE9. (C1, E-0379)
; implements script command type E9 (SCRIPT_MENU_CLOSE): ends a menu session (runs CloseBreedMenu's
; code); follows the swap and NPC breeding menus; reached through ScriptCommandE9 in bank $10
; (E-0038, E-0244)
CloseMenuE9::
    ld a, [wScreenList]
    jumptable
    dw CloseMenuE9_RestoreScreen
    dw CloseMenuE9_RestoreGlyphs
    dw CloseMenuE9_LoadTiles
    dw CloseMenuE9_RedrawNamesAndFinish

; Closing the menu session, step 0: restores the screen saved in the window buffer (tiles and GBC
; attributes) and redraws it. (C1, E-0357)
CloseMenuE9_RestoreScreen::
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

SECTION "Bank 1E CloseMenuE9_RestoreGlyphs", ROMX

; Closing the menu session, step 1: far-calls CloseBreedMenu, whose jump table on the same
; wScreenList value runs CloseBreedMenu_RestoreGlyphs (copies the field glyph tiles back, clears the
; menu state, advances wScreenList and puts the text window back). (C1, E-0370)
CloseMenuE9_RestoreGlyphs::
    farcall CloseBreedMenu
    ret

SECTION "Bank 1E CloseMenuE9_LoadTiles", ROMX

; Closing the menu session, step 2: decompresses LetterFrameIconDigitTiles (bank $46) into VRAM
; $8800 and blanks the name tiles. (C1, E-0357)
CloseMenuE9_LoadTiles::
    ld b, BANK(LetterFrameIconDigitTiles)
    ld de, LetterFrameIconDigitTiles
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles1 + $500
    ld bc, $0f01
    call FillTilesBxC
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
    ret

SECTION "Bank 1E CloseMenuE9_RedrawNamesAndFinish", ROMX

; Closing the menu session, step 3: far-calls CloseBreedMenu, which with wScreenList = 3 runs
; CloseBreedMenu_RedrawNamesAndFinish (redraws the name tiles, clears wMessageMode, wScreenList and
; the menu state, refills wTextBuf0 with the player's name, resets the text window and starts the
; script). (C1, E-0370)
CloseMenuE9_RedrawNamesAndFinish::
    farcall CloseBreedMenu
    ret

SECTION "Bank 1E SwapMonstersMenu", ROMX

; Runner of the swap menu (script command E8) and of the stats pages that other menus borrow from
; it: wScreenState picks one of 15 states, SwapMonstersMenu_Init (0),
; SwapMonstersMenu_SetupPartyList, SwapMonstersMenu_OptionCursor, SwapMonstersMenu_ListParty,
; SwapMonstersMenu_MoveRecords (Drop off), SwapMonstersMenu_ChooseFromFarm (Pick up),
; SwapMonstersMenu_Check, SwapMonstersMenu_Release, SwapMonstersMenu_ShowPartyMemberDetails,
; SwapMonstersMenu_ShowMonsterDetails, SwapMonstersMenu_ShowFarmMonsterDetails,
; SwapMonstersMenu_ShowParents, SwapMonstersMenu_ShowMonsterDetails2, SwapMonstersMenu_ShowParents2
; and SwapMonstersMenu_ShowMonsterDetails3. States 4 to 7 are entered from
; SwapMonstersMenu_ListParty_StartOption by the chosen option, and the stats pages by the screens
; that far-call this routine (ScriptCommandE8, the breed, hibernate, link, egg and prize menus).
; (C1, E-0379)
; implements script command type E8 (SCRIPT_SWAP_MONSTERS): Cobi's swap of party and farm monsters:
; 'What'll you switch it with?', 'I switched 0.' (mode 3, bank $1F strings); reached through
; ScriptCommandE8 in bank $10 (E-0038, E-0244) (C2 from E-0335: Drop off / Pick up / Check / Release
; / Exit; Drop off sets a party record's MON_STATE to 1 and Pick up a kept one's to 2)
SwapMonstersMenu::
    ld a, [wScreenState]
    jumptable
    dw SwapMonstersMenu_Init
    dw SwapMonstersMenu_SetupPartyList
    dw SwapMonstersMenu_OptionCursor
    dw SwapMonstersMenu_ListParty
    dw SwapMonstersMenu_MoveRecords
    dw SwapMonstersMenu_ChooseFromFarm
    dw SwapMonstersMenu_Check
    dw SwapMonstersMenu_Release
    dw SwapMonstersMenu_ShowPartyMemberDetails
    dw SwapMonstersMenu_ShowMonsterDetails
    dw SwapMonstersMenu_ShowFarmMonsterDetails
    dw SwapMonstersMenu_ShowParents
    dw SwapMonstersMenu_ShowMonsterDetails2
    dw SwapMonstersMenu_ShowParents2
    dw SwapMonstersMenu_ShowMonsterDetails3

; Swap menu, state 0: clears the $6F bytes of menu state, saves the screen to the window buffer,
; sets message mode 3, sprite hide tile $70 and wAreaGraphicsIndex 0, and lets the script greet.
; (C2, E-0357; probed E-0379)
SwapMonstersMenu_Init::
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

SECTION "Bank 1E SwapMonstersMenu_SetupPartyList", ROMX

; State 1 of SwapMonstersMenu, a runner by wScreenStep with four steps:
; SwapMonstersMenu_SetupPartyList_SaveTiles (saves the menu tiles into BG map 1),
; SwapMonstersMenu_SetupPartyList_CopyGlyphs, SwapMonstersMenu_SetupPartyList_ListParty (lists the
; party with ListPartyRecordsWithState2ToListEntries) and
; SwapMonstersMenu_SetupPartyList_DrawOptions (draws the option box, counts the records in use,
; resets wScreenStep and moves wScreenState on to 2, the option cursor). (C1, E-0379)
; by wScreenStep: the tile map, ListPartyRecordsWithState2ToListEntries and CountRecordsInUse
SwapMonstersMenu_SetupPartyList::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_SetupPartyList_SaveTiles
    dw SwapMonstersMenu_SetupPartyList_CopyGlyphs
    dw SwapMonstersMenu_SetupPartyList_ListParty
    dw SwapMonstersMenu_SetupPartyList_DrawOptions

; Swap menu party list, step 0: far-calls SaveTilesToBGMap1TopHalf, which copies the tiles at the
; VRAM addresses listed in CloseHibernateMenu_RestoreGlyphs_Data to $9C00 + 16 * n, six per frame,
; and goes to step 1 at the end of the list (CopyListedTilesSixPerFrame). (C1, E-0370)
SwapMonstersMenu_SetupPartyList_SaveTiles::
    farcall SaveTilesToBGMap1TopHalf
    ret

SECTION "Bank 1E SwapMonstersMenu_SetupPartyList_CopyGlyphs", ROMX

; Swap menu party list, step 1: copies the menu's glyph tiles (GlyphCopySrcList0). (C1, E-0357)
SwapMonstersMenu_SetupPartyList_CopyGlyphs::
    ld hl, GlyphCopyDestList0
    ld de, GlyphCopySrcList0
    call SwapMonstersMenu_CopyGlyphTiles
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 1E SwapMonstersMenu_SetupPartyList_ListParty", ROMX

; Swap menu party list, step 2: lists the party records in state 2 into wListEntries and wListCount
; (ListPartyRecordsWithState2ToListEntries) and goes to step 3. (C2, E-0370; probed E-0384)
SwapMonstersMenu_SetupPartyList_ListParty::
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_SetupPartyList_DrawOptions", ROMX

; Swap menu party list, step 3: draws the five-option box (Drop off, Pick up, Check, Release, Exit)
; and the screen, counts the records in use and goes to the option cursor. (C1, E-0357)
SwapMonstersMenu_SetupPartyList_DrawOptions::
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

SECTION "Bank 1E SwapMonstersMenu_OptionCursor", ROMX

; Swap menu, state 2: the option cursor over five options (Up/Down with wrap, blinking); A passes
; the option to the script in wTwoChoiceCursor (Exit or B gives 4). (C1, E-0357)
SwapMonstersMenu_OptionCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_swap_monsters_menu_option_cursor_hide
    bit 7, a
    jr nz, .call_swap_monsters_menu_option_cursor_hide2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_04
    call SwapMonstersMenu_OptionCursor_Blink
    ret

.call_swap_monsters_menu_option_cursor_hide:
    call SwapMonstersMenu_OptionCursor_Hide
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x
    ld a, $04
    ld [wGridCursorX], a
    call SwapMonstersMenu_OptionCursor_Blink
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
    call SwapMonstersMenu_OptionCursor_Show
    ld a, $69
    call QueueSoundEffect
    ret

.call_swap_monsters_menu_option_cursor_hide2:
    call SwapMonstersMenu_OptionCursor_Hide
    ld a, [wGridCursorX]
    cp $04
    jr c, .skip
    xor a
    ld [wGridCursorX], a
    call SwapMonstersMenu_OptionCursor_Blink
    ld a, $69
    call QueueSoundEffect
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call SwapMonstersMenu_OptionCursor_Mark
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

SECTION "Bank 1E SwapMonstersMenu_OptionCursor_Blink", ROMX

; Blinks the option cursor: after $14 frames of the repeat timer, shown for 16 counts and hidden for
; 8. (C1, E-0357)
SwapMonstersMenu_OptionCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, SwapMonstersMenu_OptionCursor_Show
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, SwapMonstersMenu_OptionCursor_Show
    cp $18
    jr c, SwapMonstersMenu_OptionCursor_Hide
    xor a
    ld [wGridCursorY], a

; Draws the cursor tile ($BB) at the current option. (C1, E-0357)
SwapMonstersMenu_OptionCursor_Show::
    ld b, $bb
    jr SwapMonstersMenu_OptionCursor_DrawTile

SECTION "Bank 1E SwapMonstersMenu_OptionCursor_Hide", ROMX

; Draws the blank tile ($C3) at the current option. (C1, E-0357)
SwapMonstersMenu_OptionCursor_Hide::
    ld b, $c3
    jr SwapMonstersMenu_OptionCursor_DrawTile

SECTION "Bank 1E SwapMonstersMenu_OptionCursor_Mark", ROMX

; Draws the chosen tile ($BC) at the current option. (C1, E-0357)
SwapMonstersMenu_OptionCursor_Mark::
    ld b, $bc

; Writes tile B at the current option's place (SwapMonstersMenu_OptionCursor_DrawTile_Data),
; stepping back on a scroll wrap, waiting for VRAM access. (C1, E-0357)
SwapMonstersMenu_OptionCursor_DrawTile::
    ld a, [wGridCursorX]
    add a
    ld hl, SwapMonstersMenu_OptionCursor_DrawTile_Data
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

SECTION "Bank 1E SwapMonstersMenu_OptionCursor_DrawTile_Data", ROMX

; Five little-endian words, $0021, $0061, $00A1, $00E1 and $0121: BG map offsets of 1, 3, 5, 7 and 9
; BG rows (32 tiles each) below the top-left screen tile, plus one column.
; SwapMonstersMenu_OptionCursor_DrawTile indexes it by wGridCursorX, adds the word to the
; BGMapAddressAtScroll_Bank1E result and writes tile B there (the cursor mark beside the option).
; (C1, E-0381)
SwapMonstersMenu_OptionCursor_DrawTile_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; Swap menu, state 3: lists the party (SwapMonstersMenu_ListParty_StartOption). (C2, E-0357; probed
; E-0384)
SwapMonstersMenu_ListParty::
    farcall SwapMonstersMenu_ListParty_StartOption
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords", ROMX

; State 4 of SwapMonstersMenu (the Drop off option), a runner by wScreenStep with 49 entries that
; draw the party and farm lists, run their cursors and the yes/no question and do the move (for
; example SwapMonstersMenu_MoveRecords_DropOff, SwapMonstersMenu_MoveRecords_FindFarmMonster,
; SwapMonstersMenu_MoveRecords_ReadAnswer, SwapMonstersMenu_MoveRecords_ListCursor and
; SwapMonstersMenu_MoveRecords_Swap). Several entries appear more than once in the table, for
; example SwapMonstersMenu_MoveRecords_SaveScreenArea at steps 6, 28 and 42. (C1, E-0379)
; by wScreenStep: record lists of party and farm, StoreTemp0BytesToSRAMRecord, capacity from the
; farm level, CountRecordsInUse
SwapMonstersMenu_MoveRecords::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_MoveRecords_DrawParty
    dw SwapMonstersMenu_MoveRecords_DrawMemberStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawMemberName
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_MoveRecords_PartyCursor
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_RestartOptionMenu
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_MoveRecords_BackToPartyCursor
    dw SwapMonstersMenu_MoveRecords_DropOff
    dw SwapMonstersMenu_MoveRecords_FindFarmMonster
    dw SwapMonstersMenu_MoveRecords_DrawYesNo
    dw SwapMonstersMenu_MoveRecords_ReadAnswer
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_ClearList
    dw ListRecordsState1ThenContinue
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_MoveRecords_DrawIconAndStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawNameAndSpecies
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_MoveRecords_ListCursor
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_MoveRecords_RedrawOptions
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_MoveRecords_BackToFarmCursor
    dw SwapMonstersMenu_MoveRecords_WriteSwapNames
    dw SwapMonstersMenu_MoveRecords_Swap
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_MoveRecords_BackToOptions

; Moving records, step 0: in three sub-steps draws the party box, the party's names and the list
; marks. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawParty::
    ld a, [wScreenSubStep]
    and a
    jp z, SwapMonstersMenu_MoveRecords_DrawPartyBox
    cp $01
    jp z, CopyPartyNamesToTiles
    jp SwapMonstersMenu_MoveRecords_ListAndNumberParty

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawPartyBox", ROMX

; Draws the party box and blanks the name tiles (sub-step 0). (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawPartyBox::
    ld de, SwapMonstersMenu_MoveRecords_DrawPartyBox_TileRect
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

SECTION "Bank 1E CopyPartyNamesToTiles", ROMX

; Copies each party member's name into its tiles (sub-step 1). (C1, E-0357)
CopyPartyNamesToTiles::
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
    ld hl, CopyPartyNamesToTiles_Data
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_ListAndNumberParty", ROMX

; Last sub-step (wScreenSubStep 2) of SwapMonstersMenu_MoveRecords_DrawParty and
; SwapMonstersMenu_ChooseFromFarm_DrawParty: lists the party
; (ListPartyRecordsWithState2ToListEntries), writes the party numbers (MarkPartyMembersInList: tile
; $E1 + index from wWindowTileBuffer + $78, two rows apart), redraws the 20 x 11 screen area, clears
; wScreenSubStep and advances wScreenStep. (C1, E-0370)
SwapMonstersMenu_MoveRecords_ListAndNumberParty::
    farcall ListPartyRecordsWithState2ToListEntries
    ld hl, wWindowTileBuffer + $78
    ld c, $28
    call MarkPartyMembersInList
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawPartyBox_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
SwapMonstersMenu_MoveRecords_DrawPartyBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

CopyPartyNamesToTiles_Data::
    db $00, $8d, $50, $8d, $a0, $8d

; Moving records, step 1: for the party member under the cursor draws its family icon and its stats
; box. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawMemberStats::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_BlankNameTiles", ROMX

; Moving records, step 2: blanks the name and number tiles and puts the text window back in place.
; (C1, E-0357)
SwapMonstersMenu_MoveRecords_BlankNameTiles::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawMemberName", ROMX

; Moving records, step 3: draws the name and species name of the party member under the cursor. (C1,
; E-0357)
SwapMonstersMenu_MoveRecords_DrawMemberName::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_ShowCursorMark", ROMX

; Moving records, step 4: shows the cursor mark, redraws and clears the mark. (C1, E-0357)
SwapMonstersMenu_MoveRecords_ShowCursorMark::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_PartyCursor", ROMX

; Moving records, step 5: the party cursor: a move goes back to step 1, B answers 1 and goes on, A
; marks the member and goes on five steps with answer 0. (C1, E-0357)
SwapMonstersMenu_MoveRecords_PartyCursor::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_SaveScreenArea", ROMX

; Moving records, step 6: saves a 12 x 13 screen area with attributes. (C2, E-0357; probed E-0379)
SwapMonstersMenu_MoveRecords_SaveScreenArea::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_RedrawScreen", ROMX

; Moving records, step 7: redraws the screen. (C1, E-0357)
SwapMonstersMenu_MoveRecords_RedrawScreen::
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_CopyBoxGlyphs", ROMX

; Moving records, step 8: copies the box glyph tiles (GlyphCopySrcList1). (C1, E-0357)
SwapMonstersMenu_MoveRecords_CopyBoxGlyphs::
    ld hl, GlyphCopyDestList1
    ld de, GlyphCopySrcList1
    call SwapMonstersMenu_CopyGlyphTiles
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_RestartOptionMenu", ROMX

; Moving records, step 9: returns to the option menu's last setup step (state 1, step 3:
; SwapMonstersMenu_SetupPartyList_DrawOptions, which redraws the options and goes to the option
; cursor) and starts the script. (C2, E-0370; probed E-0379)
SwapMonstersMenu_MoveRecords_RestartOptionMenu::
    ld a, $03
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs", ROMX

; Moving records, step 10: copies the yes/no glyph tiles (GlyphCopySrcList3). (C1, E-0357)
SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs::
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_CopyGlyphTiles
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawYesNoAgain", ROMX

; Moving records, step 11: draws the yes/no box, plays sound $6C and resets the choice. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawYesNoAgain::
    ld de, SwapMonstersMenu_YesNoAgainTileRect
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

SECTION "Bank 1E SwapMonstersMenu_YesNoAgainTileRect", ROMX

; A tile rectangle 8 tiles wide and 5 rows high, one row per db line: a frame (tiles $B0-$B7 around
; the edge) with blank tile $C3 inside and tiles $70-$73 on row 1 and $74-$75 on row 3 as the two
; answer lines. SwapMonstersMenu_MoveRecords_DrawYesNoAgain copies it to wWindowTileBuffer + $110
; (row 13, column 12) and draws it. (C1, E-0381)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
SwapMonstersMenu_YesNoAgainTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; Moving records, step 12: the yes/no cursor; yes opens the record's stats screen (screen state 8 or
; 9) with the return state and step chosen from where the menu stands, saving the sprites; no or B
; answer 2. (C1, E-0357)
SwapMonstersMenu_MoveRecords_YesNoCursor::
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
    call SwapMonstersMenu_MoveRecords_YesNoCursor_Mark
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

SECTION "Bank 1E BlinkCursorBlinkAE_Bank1E", ROMX

; Blinks the yes/no cursor when no button was pressed (SwapMonstersMenu_MoveRecords_YesNoCursor
; calls it). While wJoypadRepeatTimer is below $14 it only draws the cursor tile $BB
; (DrawCursorTileBB_Bank1E). From $14 on it adds 1 to wCursorBlinkAE on every call: counts 1-$0F
; draw the cursor tile, counts $10-$17 draw the blank tile $C3 (DrawBlankTileC3_Bank1E), and at $18
; the counter drops back to 0 and the cursor tile is drawn, so the cursor shows for 16 counts and is
; hidden for 8. (C1, E-0379)
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

; Sets B = $BB (the cursor tile) and jumps to SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile,
; which writes tile B into the BG map at the cursor place for wChoiceCursor (0 or 1; the offsets are
; in SwapMonstersMenu_YesNoCursorOffsets). SwapMonstersMenu_MoveRecords_YesNoCursor calls it after
; it moves the cursor, and BlinkCursorBlinkAE_Bank1E branches to it for the shown half of the blink.
; (C1, E-0379)
; B = $BB (cursor tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawCursorTileBB_Bank1E)
DrawCursorTileBB_Bank1E::
    ld b, $bb
    jr SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile

SECTION "Bank 1E DrawBlankTileC3_Bank1E", ROMX

; Sets B = $C3 (the blank tile) and jumps to SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile,
; which writes it at the cursor place for wChoiceCursor, hiding the yes/no cursor there.
; SwapMonstersMenu_MoveRecords_YesNoCursor calls it to erase the old place before it moves the
; cursor, and BlinkCursorBlinkAE_Bank1E branches to it for the hidden half of the blink. (C1,
; E-0379)
; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_Bank1E)
DrawBlankTileC3_Bank1E::
    ld b, $c3
    jr SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_YesNoCursor_Mark", ROMX

; Draws the chosen tile ($BC) at the yes/no cursor. (C1, E-0357)
SwapMonstersMenu_MoveRecords_YesNoCursor_Mark::
    ld b, $bc

; Writes tile B at the yes/no cursor's place, stepping back on a scroll wrap, waiting for VRAM
; access. (C1, E-0357)
SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile::
    ld a, [wChoiceCursor]
    add a
    ld hl, SwapMonstersMenu_YesNoCursorOffsets
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

SECTION "Bank 1E SwapMonstersMenu_YesNoCursorOffsets", ROMX

; Two little-endian words, $012D and $016D: BG map offsets from the scroll origin (row 9 column 13,
; row 11 column 13) of the yes/no cursor for wChoiceCursor 0 and 1.
; SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile adds the entry to BGMapAddressAtScroll_Bank1E,
; steps back on a scroll wrap and writes tile B there. (C1, E-0372)
SwapMonstersMenu_YesNoCursorOffsets::
    db $2d, $01, $6d, $01

; Takes the yes/no box (8 x 5 tiles at row 8, column 12 of the menu screen, drawn by
; SwapMonstersMenu_MoveRecords_DrawYesNoAgain) off the menu screen buffer and goes on one step. It
; copies the 8 x 1 row DrawBoxAndMenuAndStep_1E_TileRect (tiles $B4 x 7 and $B5, a bottom edge) to
; wWindowTileBuffer + $110, restores the 8 x 4 block below it (row 9, column 12) from the saved
; field screen in wScreenTileBuffer with CopyScreenBufferRectWithAttrs_1E (C = 4, wArg1 = 0, wArg2 =
; 8), writes the blank tile $C3 at entry wListCursor (0-4) of SwapMenuCursorCells and adds 1 to
; wScreenStep. It is a step of SwapMonstersMenu_MoveRecords (13, 38) and
; SwapMonstersMenu_ChooseFromFarm (19, 45, 69), and SwapMonstersMenu_MoveRecords_DropOff,
; SwapMonstersMenu_MoveRecords_Swap, SwapMonstersMenu_ChooseFromFarm_PickUp,
; SwapMonstersMenu_ChooseFromFarm_Swap and SwapMonstersMenu_ChooseFromFarm_RedrawMenu call it. (C2,
; E-0379)
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

SECTION "Bank 1E DrawBoxAndMenuAndStep_1E_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
DrawBoxAndMenuAndStep_1E_TileRect::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; Moving records, step 14: redraws and returns to the party cursor (step 5). (C1, E-0357)
SwapMonstersMenu_MoveRecords_BackToPartyCursor::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DropOff", ROMX

; Dropping off, step 15: the chosen party member goes to the farm (MON_STATE 1, status cleared); the
; party count drops, the party list is rebuilt and the sprites reloaded; then back to step 6. (C1,
; E-0357)
SwapMonstersMenu_MoveRecords_DropOff::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_FindFarmMonster", ROMX

; Moving records, step 16: looks for a farm monster (state 1, not an egg) among the records within
; the farm level's capacity: with one answers 1 and goes on; without returns to the options with
; answer 0. (C2, E-0357; probed E-0384)
SwapMonstersMenu_MoveRecords_FindFarmMonster::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawYesNo", ROMX

; Moving records, step 17: loads a box tile, plays sound $6C and draws the yes/no box with the
; option marked. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawYesNo::
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, BANK(Tiles2Plus720Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6c
    call QueueSoundEffect
    ld de, SwapMonstersMenu_MoveRecords_DrawYesNo_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawYesNo_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
SwapMonstersMenu_MoveRecords_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f3, $a6, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; Moving records, step 18: the yes/no answer: no (or B) restores the box and returns to the options
; (state 1, step 3); yes restores it and goes on. (C1, E-0357)
SwapMonstersMenu_MoveRecords_ReadAnswer::
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
    call SwapMonstersMenu_MoveRecords_ReadAnswer_EraseBox
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
    call SwapMonstersMenu_MoveRecords_ReadAnswer_EraseBox
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_ReadAnswer_EraseBox", ROMX

; Restores the 6 x 5 yes/no box area from the saved screen (tiles and GBC attributes) and redraws.
; (C1, E-0357)
SwapMonstersMenu_MoveRecords_ReadAnswer_EraseBox::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $05
    call SwapMonstersMenu_MoveRecords_ReadAnswer_CopyRows
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank1_e
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $05
    call SwapMonstersMenu_MoveRecords_ReadAnswer_CopyRows
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank1_e:
    call BGMapAddressAtScroll_Bank1E
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank1E
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_ReadAnswer_CopyRows", ROMX

; Copies C rows of six bytes from DE to HL, both with 20-byte rows. (C2, E-0357; probed E-0379)
SwapMonstersMenu_MoveRecords_ReadAnswer_CopyRows::
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
    jr nz, SwapMonstersMenu_MoveRecords_ReadAnswer_CopyRows
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawListBox", ROMX

; Moving records, step 19: draws the list box and redraws; clears the page and blink. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawListBox::
    ld de, SwapMonstersMenu_MoveRecords_DrawListBox_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawListBox_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 11 tiles, one row per line
SwapMonstersMenu_MoveRecords_DrawListBox_TileRect::
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

; Moving records, step 20: blanks four tile areas and draws the empty list box. (C1, E-0357)
SwapMonstersMenu_MoveRecords_ClearList::
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

SECTION "Bank 1E ListRecordsState1ThenContinue", ROMX

; Far-calls ListRecordsState1NotEggs, which lists the records in state 1 (kept, not in the party)
; that are not eggs into wListEntries and sets wListCount, then jumps to
; SwapMonstersMenu_ClampListPage (clamps the page cursor, draws the page indicator when there are
; two pages or more, adds 1 to wScreenStep). It is a step of SwapMonstersMenu_MoveRecords (21) and
; SwapMonstersMenu_ChooseFromFarm (2, 51), and the stats screens call it to relist the farm
; (SwapMonstersMenu_ShowMonsterDetails_Relist, SwapMonstersMenu_ShowMonsterDetails_RelistFarm and
; others). (C1, E-0379)
; far-calls ListRecordsState1NotEggs and continues with SwapMonstersMenu_ClampListPage (E-0122)
ListRecordsState1ThenContinue::
    farcall ListRecordsState1NotEggs
    jr SwapMonstersMenu_ClampListPage

SECTION "Bank 1E SwapMonstersMenu_Check_ListMonsters", ROMX

; Choosing to view, step 6: lists the farm monsters that are not eggs, then the page (below). (C1,
; E-0357)
SwapMonstersMenu_Check_ListMonsters::
    farcall ListRecordsInUseNotEggs

; Clamps the list's page cursor (ClampRecordListPageCursor5); when wListPages >= 2 draws the page
; marks (tiles $C5, $BE, $C6) at scroll offset $0142 and at wWindowTileBuffer + $12E, and the
; page-of-pages at scroll offset $0143 (DrawPageOfPagesAtScrollOffset) and at wWindowTileBuffer +
; $12F (DrawPageOfPagesAtArg1_Bank1E). Then adds 1 to wScreenStep. ListRecordsState1ThenContinue and
; SwapMonstersMenu_Check_ListMonsters run into it, and five steps of the stats screens call it. (C1,
; E-0372)
SwapMonstersMenu_ClampListPage::
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

SECTION "Bank 1E CallDrawRecordListPageNamesInBank1F", ROMX

; Far-calls DrawRecordListPageNames (bank $1F), which draws the names of the records on page
; wListPageIndex of the record list into VRAM tiles and adds 1 to wScreenStep. It is a step of
; SwapMonstersMenu_MoveRecords (22), SwapMonstersMenu_ChooseFromFarm (3, 52), SwapMonstersMenu_Check
; (7) and SwapMonstersMenu_Release (7); RedrawRecordListAndNextStep also calls it and then undoes
; the step. (C1, E-0379)
; far-calls DrawRecordListPageNames (E-0122) (E-0344: the address in its name dropped or read as the
; label there; was CallDrawRecordListPageNamesInBank1F)
CallDrawRecordListPageNamesInBank1F::
    farcall DrawRecordListPageNames
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawIconAndStats", ROMX

; Moving records, step 23: for the farm record under the cursor draws its family icon and stats box.
; (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawIconAndStats::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_DrawNameAndSpecies", ROMX

; Moving records, step 25: draws the name and species name of the farm record under the cursor. (C1,
; E-0357)
SwapMonstersMenu_MoveRecords_DrawNameAndSpecies::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_ListCursor", ROMX

; Moving records, step 27: the paged list cursor: a page change goes back 7 steps, a move back 4, B
; on one, A marks the entry and goes on eight with the answer cleared. (C1, E-0357)
SwapMonstersMenu_MoveRecords_ListCursor::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_CopyListGlyphs", ROMX

; Moving records, step 32: copies the list glyph tiles (GlyphCopySrcList2). (C1, E-0357)
SwapMonstersMenu_MoveRecords_CopyListGlyphs::
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_RedrawPartyList", ROMX

; Moving records, step 33: redraws the record list name tiles and lists the party. (C1, E-0357)
SwapMonstersMenu_MoveRecords_RedrawPartyList::
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_RedrawOptions", ROMX

; Moving records, step 34: redraws the option box and screen, counts the records in use and goes to
; step $11 with answer 1. (C1, E-0357)
SwapMonstersMenu_MoveRecords_RedrawOptions::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_BackToFarmCursor", ROMX

; Moving records, step 39: redraws and returns to the farm list cursor (step $1B). (C1, E-0357)
SwapMonstersMenu_MoveRecords_BackToFarmCursor::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_WriteSwapNames", ROMX

; Moving records, step 40: writes '<first party member> with <chosen farm monster>' into wTextBuf0
; for the swap message. (C2, E-0357; probed E-0384)
SwapMonstersMenu_MoveRecords_WriteSwapNames::
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

; Shared tail of SwapMonstersMenu_MoveRecords_WriteSwapNames and
; SwapMonstersMenu_ChooseFromFarm_WriteSwapNames (HL = wNameGlyphBuf with the first name, DE =
; wTextBuf0, C = 0, SRAM enabled): copies up to 10 bytes until $F0, appends ' with ', then the name
; of the list entry at GetListEntriesCell5Address (CopyRecordNameToNameGlyphBuf) up to its $F0, ends
; wTextBuf0 with $F0, disables SRAM, advances wScreenStep, resets the text window and starts the
; script. (C2, E-0370; probed E-0384)
SwapMonstersMenu_JoinSwapNames::
    ld a, [hl]
    cp $f0
    jr z, .skip
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp $0a
    jr c, SwapMonstersMenu_JoinSwapNames

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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_Swap", ROMX

; Moving records, step 41: the swap: the first party member goes to the farm (state 1, status
; cleared) and the chosen farm monster takes its place in the party (state 2); relists the party,
; reloads the sprites and redraws. (C1, E-0357)
SwapMonstersMenu_MoveRecords_Swap::
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

SECTION "Bank 1E SwapMonstersMenu_MoveRecords_BackToOptions", ROMX

; Moving records, step 48: redraws the option box and screen, counts the records in use and returns
; to the option cursor (state 2) with answer 1. (C1, E-0357)
SwapMonstersMenu_MoveRecords_BackToOptions::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm", ROMX

; Screen state 5 of SwapMonstersMenu (menu option 1, Pick up): wScreenStep picks one of 80 steps.
; SwapMonstersMenu_ListParty_StartOption enters it at step 0 when the party has room (wPartyCount
; below 3) and at step 30 when it is full. Steps 0-8 draw the list box, list the farm monsters that
; are not eggs and run the paged cursor (SwapMonstersMenu_MoveRecords_ListCursor at 8): B goes to
; steps 9-15, which redraw and return to the option cursor (state 2), and A goes to the two-entry
; box at 16-18. In that box (SwapMonstersMenu_MoveRecords_YesNoCursor) the first entry opens the
; stats screen of the monster (state 9, returning to step 18), B returns to step 8 through 19-20,
; and the second entry goes to 21-22, where SwapMonstersMenu_ChooseFromFarm_PickUp makes the monster
; a party member; 23-29 return to the options. With a full party, 30-31 ask a yes/no question, 32-37
; show the party and run its cursor (SwapMonstersMenu_ChooseFromFarm_PartyCursor at 37) to pick the
; member to replace (B goes back to step 30 through 38-41), 42-47 ask with the two-entry box, 48-57
; list the farm monsters again and run their cursor (SwapMonstersMenu_ChooseFromFarm_ListCursor at
; 57), 58-65 return to the party cursor on B, and 66-72 ask with the box again and swap
; (SwapMonstersMenu_ChooseFromFarm_WriteSwapNames at 71, SwapMonstersMenu_ChooseFromFarm_Swap at
; 72); 73-79 return to the options. (C1, E-0379)
; screen state 5, reached from menu option 1 when the farm list (ListRecordsState1NotEggs: records
; in use that are not eggs) is not empty: the MoveRecords list steps on that list
SwapMonstersMenu_ChooseFromFarm::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_ClearList
    dw ListRecordsState1ThenContinue
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_MoveRecords_DrawIconAndStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawNameAndSpecies
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_MoveRecords_ListCursor
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_MoveRecords_BackToOptions
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_Redraw
    dw SwapMonstersMenu_ChooseFromFarm_ResetText
    dw SwapMonstersMenu_ChooseFromFarm_PickUp
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_MoveRecords_BackToOptions
    dw SwapMonstersMenu_MoveRecords_DrawYesNo
    dw SwapMonstersMenu_MoveRecords_ReadAnswer
    dw SwapMonstersMenu_MoveRecords_DrawParty
    dw SwapMonstersMenu_MoveRecords_DrawMemberStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawMemberName
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_ChooseFromFarm_PartyCursor
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_ChooseFromFarm_BackToOptions
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_RedrawAndContinue
    dw SwapMonstersMenu_ChooseFromFarm_RedrawMenu
    dw SwapMonstersMenu_ChooseFromFarm_ListFarm
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_ClearList
    dw ListRecordsState1ThenContinue
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_MoveRecords_DrawIconAndStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawNameAndSpecies
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_ChooseFromFarm_ListCursor
    dw SwapMonstersMenu_ChooseFromFarm_DrawListBox
    dw SwapMonstersMenu_ChooseFromFarm_CopyListGlyphs
    dw SwapMonstersMenu_ChooseFromFarm_DrawPartyBox
    dw SwapMonstersMenu_ChooseFromFarm_DrawParty
    dw SwapMonstersMenu_MoveRecords_DrawMemberStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawMemberName
    dw SwapMonstersMenu_ChooseFromFarm_BackToParty
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw DrawBoxAndMenuAndStep_1E
    dw SwapMonstersMenu_ChooseFromFarm_RedrawAndContinue2
    dw SwapMonstersMenu_ChooseFromFarm_WriteSwapNames
    dw SwapMonstersMenu_ChooseFromFarm_Swap
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_MoveRecords_BackToOptions

; Choosing from the farm, step 20: redraws and goes to step 8. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_Redraw::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_ResetText", ROMX

; Choosing from the farm, step 21: puts the player's name in wTextBuf0 and resets the text window.
; (C2, E-0357; probed E-0379)
SwapMonstersMenu_ChooseFromFarm_ResetText::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_PickUp", ROMX

; Picking up, step 22: the chosen farm monster joins the party (state 2, appended to wPartyList);
; relists the party, reloads the sprites and redraws. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_PickUp::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_PartyCursor", ROMX

; Choosing from the farm, step 37: the party cursor: a move goes to step $21, B answers 1 and goes
; on, A marks the member and goes on five steps. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_PartyCursor::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_BackToOptions", ROMX

; Choosing from the farm, step 41: redraws the option box with the option marked, counts the records
; in use and goes to step $1E with answer 1. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_BackToOptions::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_RedrawAndContinue", ROMX

; Choosing from the farm, step 46: redraws and goes to step $25. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_RedrawAndContinue::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_ListFarm", ROMX

; Choosing from the farm, step 48: redraws, keeps the chosen party member and its place, and lists
; the farm monsters; an unreached $C9 byte follows. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_ListFarm::
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

; Choosing from the farm, step 58: draws the list box and redraws. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_DrawListBox::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_CopyListGlyphs", ROMX

; Choosing from the farm, step 59: copies the list glyph tiles. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_CopyListGlyphs::
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_DrawPartyBox", ROMX

; Choosing from the farm, step 60: draws the party box and restores the cursor. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_DrawPartyBox::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_BackToParty", ROMX

; Choosing from the farm, step 65: redraws, goes to step $25 with answer 1, lists the party and
; resets the text window. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_BackToParty::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_ListCursor", ROMX

; Choosing from the farm, step 57: the paged list cursor: a page change goes back 7 steps, a move
; back 4, B on one, A marks the entry and goes on nine. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_ListCursor::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_RedrawMenu", ROMX

; Choosing from the farm, step 47: redraws the box and menu and marks the cursor entry. (C2, E-0357;
; probed E-0379)
SwapMonstersMenu_ChooseFromFarm_RedrawMenu::
    call DrawBoxAndMenuAndStep_1E
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ret

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_DrawParty", ROMX

; Choosing from the farm, step 61: the party box, names and marks in three sub-steps (as moving
; records' step 0). (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_DrawParty::
    ld a, [wScreenSubStep]
    and a
    jp z, SwapMonstersMenu_MoveRecords_DrawPartyBox
    cp $01
    jp z, CopyPartyNamesToTiles
    jp SwapMonstersMenu_MoveRecords_ListAndNumberParty

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_RedrawAndContinue2", ROMX

; Choosing from the farm, step 70: redraws and goes to step $39. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_RedrawAndContinue2::
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

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_WriteSwapNames", ROMX

; Choosing from the farm, step 71: writes '<chosen party member> with <farm monster>' into wTextBuf0
; (the swap message's names). (C2, E-0357; probed E-0384)
SwapMonstersMenu_ChooseFromFarm_WriteSwapNames::
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
    jp SwapMonstersMenu_JoinSwapNames

SECTION "Bank 1E SwapMonstersMenu_ChooseFromFarm_Swap", ROMX

; Choosing from the farm, step 72: the swap: the chosen farm monster joins the party (state 2) in
; the chosen member's place, and the member goes to the farm (state 1, status cleared); relists the
; party, reloads the sprites and redraws. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_Swap::
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

SECTION "Bank 1E SwapMonstersMenu_Check", ROMX

; Screen state 6 of SwapMonstersMenu (menu option 2, Check): wScreenStep picks one of 31 steps.
; Steps 0-1 draw the Monsters / Eggs count box and 2 is its cursor
; (SwapMonstersMenu_Check_ChoiceCursor): B answers 3 and goes to step 3, back to the options (state
; 2); A on Monsters goes to step 4 and A on Eggs, when some are flagged, to step 21. Steps 4-12 draw
; the list of farm monsters that are not eggs with the paged cursor at 12: A opens the stats screen
; (step 20, screen state $0A, returning to step $0C), B goes through 13-19 and back to the choice
; box at step 2. Steps 21-30 do the same for the eggs, with the egg cursor at 27: A opens the egg
; pedigree screen (state $0B, returning to step $1B), B goes through 28-30 and back to step 2. (C1,
; E-0379)
; screen state 6 (menu option 2): a record list whose choice leads to the detail screen (state $0A)
; or the parents screen (state $0B) (renamed from SwapMonstersMenu_ChooseToView from its E-0357
; note, E-0367)
SwapMonstersMenu_Check::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_Check_CopyGlyphs
    dw SwapMonstersMenu_Check_DrawCounts
    dw SwapMonstersMenu_Check_ChoiceCursor
    dw SwapMonstersMenu_Check_BackToOptions
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_ClearList
    dw SwapMonstersMenu_Check_ListMonsters
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_Check_DrawIconAndStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawNameAndSpecies
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_Check_ListCursor
    dw SwapMonstersMenu_Check_DrawCountBox
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_Check_RedrawCounts
    dw SwapMonstersMenu_Check_OpenStats
    dw SwapMonstersMenu_Check_SaveTiles
    dw SwapMonstersMenu_Check_ListEggs
    dw SwapMonstersMenu_Check_BlankTiles
    dw SwapMonstersMenu_Check_DrawEggBox
    dw SwapMonstersMenu_Check_DrawEggNames
    dw SwapMonstersMenu_Check_DrawEggMarks
    dw SwapMonstersMenu_Check_EggCursor
    dw SwapMonstersMenu_Check_DrawCountBox
    dw SwapMonstersMenu_Check_DrawSmallBox
    dw SwapMonstersMenu_Check_ReloadTiles

; Checking, step 0: copies the view menu's glyph tiles (GlyphCopySrcList5). (C1, E-0357)
SwapMonstersMenu_Check_CopyGlyphs::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; Checking, step 1: draws the Monsters / Eggs box with the farm's monster count and egg count, plays
; sound $6C and marks the option. (C1, E-0357)
SwapMonstersMenu_Check_DrawCounts::
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

SECTION "Bank 1E SwapMonstersMenu_Check_ChoiceCursor", ROMX

; Checking, step 2: the Monsters / Eggs cursor (in bank $1D); B answers 3 and goes on; A chooses
; (below). (C1, E-0357)
SwapMonstersMenu_Check_ChoiceCursor::
    farcall SwapMonstersMenu_MonstersOrEggsCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    ret z
    cp $fe
    jr z, SwapMonstersMenu_Check_ChoiceCursor_Cancel
    cp $ff
    jr z, SwapMonstersMenu_Check_ChoiceCursor_Confirm
    ret

SECTION "Bank 1E SwapMonstersMenu_Check_ChoiceCursor_Cancel", ROMX

; B on the Monsters / Eggs cursor (checking, and releasing by a jump from
; SwapMonstersMenu_Release_ChoiceCursor): answers 3 in wTwoChoiceCursor, clears wMenuChoice and
; wListCursorBlink, advances wScreenStep (in checking to step 3,
; SwapMonstersMenu_Check_BackToOptions) and starts the script. (C2, E-0370; probed E-0379)
SwapMonstersMenu_Check_ChoiceCursor_Cancel::
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

SECTION "Bank 1E SwapMonstersMenu_Check_ChoiceCursor_Confirm", ROMX

; A on the checking menu's Monsters / Eggs cursor: Eggs (wMenuChoice non-zero) goes to
; SwapMonstersMenu_Check_ChoiceCursor_PickEggs; Monsters blanks the two choice marks
; (BlankTwoTableEntriesSwapMenuCursorCellsFrom5), marks the choice with $BC, goes on two steps with
; wTwoChoiceCursor 0, resets the text window and starts the script. (C2, E-0370; probed E-0379)
SwapMonstersMenu_Check_ChoiceCursor_Confirm::
    ld a, [wMenuChoice]
    and a
    jr nz, SwapMonstersMenu_Check_ChoiceCursor_PickEggs
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

SECTION "Bank 1E SwapMonstersMenu_Check_ChoiceCursor_PickEggs", ROMX

; Eggs chosen: with no eggs answers 2; otherwise marks the choice, answers 1 and goes to step $15
; (or $22 in the release menu, state 7). (C2, E-0357; probed E-0379)
SwapMonstersMenu_Check_ChoiceCursor_PickEggs::
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

SECTION "Bank 1E SwapMonstersMenu_Check_BackToOptions", ROMX

; Checking, step 3: restores the box area, unmarks the option, reloads two tiles, redraws the option
; box and returns to the option cursor (state 2). (C1, E-0357)
SwapMonstersMenu_Check_BackToOptions::
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
    ld b, BANK(Tiles1Plus7F0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, BANK(Tiles2Plus720Tiles)
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

SECTION "Bank 1E SwapMonstersMenu_Check_DrawIconAndStats", ROMX

; Checking, step 8: for the monster under the cursor draws its family icon, marks the party members
; on the page and draws its stats box. (C1, E-0357)
SwapMonstersMenu_Check_DrawIconAndStats::
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

SECTION "Bank 1E SwapMonstersMenu_Check_ListCursor", ROMX

; Checking, step 12: the paged list cursor: a page change goes back 7 steps, a move back 4, B on one
; (cursor reset), A marks the entry and goes on eight. (C1, E-0357)
SwapMonstersMenu_Check_ListCursor::
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

SECTION "Bank 1E SwapMonstersMenu_Check_DrawCountBox", ROMX

; Checking, steps 13 and 28 (releasing 13 and 41): first restores the 12 x 9 block at row 0, column
; 8 of the menu screen buffer from the saved field screen in wScreenTileBuffer
; (CopyScreenBufferRectWithAttrs_1E, offset $0008 to $01D4, C = 9, wArg1 = 0, wArg2 = $0C; the last
; row lies under the top row of the box), then draws the 13 x 3 count box
; SwapMonstersMenu_Check_DrawCountBox_TileRect at wWindowTileBuffer + $10B with wListCount as two
; digit tiles ($E0 + digit, a leading zero left blank), and adds 1 to wScreenStep. (C2, E-0379)
SwapMonstersMenu_Check_DrawCountBox::
    ld c, $09
    ld hl, $01d4
    ld de, $0008
    xor a
    ld [wArg1], a
    ld a, $0c
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_1E
    ld de, SwapMonstersMenu_Check_DrawCountBox_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_Check_DrawCountBox_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 3 tiles, one row per line
SwapMonstersMenu_Check_DrawCountBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bc, $7c, $7d, $7e, $df, $7f, $fe, $ff, $76, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2

; Checking, step 19: redraws the option box, counts the records, draws the Monsters / Eggs box with
; both counts again and returns to its cursor (step 2) with answer 1. (C1, E-0357)
SwapMonstersMenu_Check_RedrawCounts::
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

SECTION "Bank 1E SwapMonstersMenu_Check_OpenStats", ROMX

; Checking, step 20: opens the monster's stats screen (screen state $0A, returning to state 6 step
; $0C), saving the sprites. (C2, E-0357; probed E-0379)
SwapMonstersMenu_Check_OpenStats::
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

SECTION "Bank 1E SwapMonstersMenu_Check_SaveTiles", ROMX

; Checking, step 21 (and the same entry in the releasing table): far-calls
; SaveTilesToBGMap1BottomHalf, which copies the tiles at the VRAM addresses in
; SaveTilesToBGMap1BottomHalf_Data to $9E00 + 16 * n, six per frame, and advances wScreenStep at the
; end of the list (CopyListedTilesSixPerFrame); SwapMonstersMenu_Check_ReloadTiles and
; SwapMonstersMenu_Release_ReloadTiles copy them back with LoadTileListSixPerCall. (C1, E-0370)
SwapMonstersMenu_Check_SaveTiles::
    farcall SaveTilesToBGMap1BottomHalf
    ret

SECTION "Bank 1E SwapMonstersMenu_Check_ListEggs", ROMX

; Checking, step 22: draws the egg list box, marks the choice, redraws and lists the eggs. (C1,
; E-0357)
SwapMonstersMenu_Check_ListEggs::
    ld de, SwapMonstersMenu_Check_ListEggs_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_Check_ListEggs_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 9 tiles, one row per line
SwapMonstersMenu_Check_ListEggs_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; Checking, step 23: blanks five tile areas and puts the text window back in place. (C1, E-0357)
SwapMonstersMenu_Check_BlankTiles::
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

SECTION "Bank 1E SwapMonstersMenu_Check_DrawEggBox", ROMX

; Checking, step 24: draws the egg box, clamps the page cursor of four, draws the page arrows and
; numbers, and redraws. (C1, E-0357)
SwapMonstersMenu_Check_DrawEggBox::
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

SECTION "Bank 1E SwapMonstersMenu_Check_DrawEggNames", ROMX

; Checking, step 25: draws the page's egg species names. (C1, E-0357)
SwapMonstersMenu_Check_DrawEggNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_Check_DrawEggMarks", ROMX

; Checking, step 26: loads a mark tile and draws the page's egg marks. (C1, E-0357)
SwapMonstersMenu_Check_DrawEggMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, BANK(Tiles2Plus420Tiles)
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

SECTION "Bank 1E SwapMonstersMenu_Check_EggCursor", ROMX

; Checking, step 27: the egg cursor: a page change goes back 4 steps, B on one (cursor reset), A
; opens the egg's stats screen (screen state $0B, returning to state 6 step $1B). (C1, E-0357)
SwapMonstersMenu_Check_EggCursor::
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

SECTION "Bank 1E SwapMonstersMenu_Check_DrawSmallBox", ROMX

; Checking, step 29: draws a 4 x 8 box and reloads five frame tiles. (C1, E-0357)
SwapMonstersMenu_Check_DrawSmallBox::
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
    ld b, BANK(Tiles2Plus710Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles1 + $4e0
    ld b, BANK(Tiles2Plus700Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles
    ld hl, vTiles1 + $750
    ld b, BANK(Tiles1Plus710Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles1 + $760
    ld b, BANK(Tiles2Plus240Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus770Tiles
    ld hl, vTiles1 + $770
    ld b, BANK(Tiles1Plus770Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_Check_ReloadTiles", ROMX

; Checking, step 30: reloads tiles six per call (list $9E); when done unmarks the choice and returns
; to the Monsters / Eggs cursor (step 2). (C1, E-0357)
SwapMonstersMenu_Check_ReloadTiles::
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, SaveTilesToBGMap1BottomHalf_Data
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

SECTION "Bank 1E SwapMonstersMenu_Release", ROMX

; Screen state 7 of SwapMonstersMenu (menu option 3, Release): wScreenStep picks one of 59 steps,
; most of them the Check steps. Step 2 is its own Monsters / Eggs cursor
; (SwapMonstersMenu_Release_ChoiceCursor: Monsters needs at least two farm monsters, otherwise it
; answers 4). Steps 4-19 list the farm monsters that are not eggs and run the paged cursor at 12; A
; there goes on 8 steps to the two-entry box at 20-22 (SwapMonstersMenu_MoveRecords_YesNoCursor):
; its first entry opens the stats screen (state $0A, returning to step 22), B goes through 23-24
; back to the cursor at 12, and the second entry goes to 25-26, which copy the monster name to
; wTextBuf0 and delete the record (SwapMonstersMenu_Release_DeleteMonster); 27-33 redraw and return
; to the options. Steps 34-46 list the eggs and run SwapMonstersMenu_Release_EggCursor at 40 (B goes
; through 41-43 to step 2, A to the box at 44-46, whose first entry opens the egg pedigree, state
; $0B); B in that box goes through 47-49 back to step 40, and the second entry goes to 50-51, which
; delete the egg record (SwapMonstersMenu_Release_DeleteEgg at 51). 52-58 redraw and return to the
; options. (C1, E-0379)
; screen state 7 (menu option 3): the SwapMonstersMenu_Check steps for another list (renamed from
; SwapMonstersMenu_ChooseToView2 from its E-0357 note, E-0367)
SwapMonstersMenu_Release::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_Check_CopyGlyphs
    dw SwapMonstersMenu_Check_DrawCounts
    dw SwapMonstersMenu_Release_ChoiceCursor
    dw SwapMonstersMenu_Check_BackToOptions
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_ClearList
    dw SwapMonstersMenu_Check_ListMonsters
    dw CallDrawRecordListPageNamesInBank1F
    dw SwapMonstersMenu_Check_DrawIconAndStats
    dw SwapMonstersMenu_MoveRecords_BlankNameTiles
    dw SwapMonstersMenu_MoveRecords_DrawNameAndSpecies
    dw SwapMonstersMenu_MoveRecords_ShowCursorMark
    dw SwapMonstersMenu_Check_ListCursor
    dw SwapMonstersMenu_Check_DrawCountBox
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_Check_RedrawCounts
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw SwapMonstersMenu_Release_DrawCounts
    dw SwapMonstersMenu_Release_MarkChoice
    dw SwapMonstersMenu_Release_CopyName
    dw SwapMonstersMenu_Release_DeleteMonster
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_MoveRecords_RedrawScreen
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawListBox
    dw SwapMonstersMenu_MoveRecords_CopyListGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_MoveRecords_BackToOptions
    dw SwapMonstersMenu_Check_SaveTiles
    dw SwapMonstersMenu_Check_ListEggs
    dw SwapMonstersMenu_Check_BlankTiles
    dw SwapMonstersMenu_Check_DrawEggBox
    dw SwapMonstersMenu_Check_DrawEggNames
    dw SwapMonstersMenu_Check_DrawEggMarks
    dw SwapMonstersMenu_Release_EggCursor
    dw SwapMonstersMenu_Check_DrawCountBox
    dw SwapMonstersMenu_Check_DrawSmallBox
    dw SwapMonstersMenu_Check_ReloadTiles
    dw SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs
    dw SwapMonstersMenu_MoveRecords_DrawYesNoAgain
    dw SwapMonstersMenu_MoveRecords_YesNoCursor
    dw SwapMonstersMenu_Release_DrawCountsAgain
    dw SwapMonstersMenu_Release_ListEggs
    dw SwapMonstersMenu_Release_UnmarkEgg
    dw SwapMonstersMenu_Release_ScriptThenDeleteEgg
    dw SwapMonstersMenu_Release_DeleteEgg
    dw SwapMonstersMenu_MoveRecords_SaveScreenArea
    dw SwapMonstersMenu_Release_DrawBoxes
    dw SwapMonstersMenu_Release_ReloadTiles
    dw SwapMonstersMenu_Release_ReloadFrameTiles
    dw SwapMonstersMenu_MoveRecords_CopyBoxGlyphs
    dw SwapMonstersMenu_MoveRecords_RedrawPartyList
    dw SwapMonstersMenu_Release_BackToOptions

; Releasing, step 2: the Monsters / Eggs cursor; B answers 3; Eggs as in checking; Monsters needs at
; least two farm monsters (otherwise answer 4), then marks the choice and goes on two steps. (C1,
; E-0357)
SwapMonstersMenu_Release_ChoiceCursor::
    farcall SwapMonstersMenu_MonstersOrEggsCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fd
    ret z
    cp $fe
    jp z, SwapMonstersMenu_Check_ChoiceCursor_Cancel
    cp $ff
    jr z, .check_menu_choice
    ret

.check_menu_choice:
    ld a, [wMenuChoice]
    and a
    jp nz, SwapMonstersMenu_Check_ChoiceCursor_PickEggs
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

SECTION "Bank 1E SwapMonstersMenu_Release_DrawCounts", ROMX

; Releasing, step 23: draws the count box with both counts. (C2, E-0357; probed E-0384)
SwapMonstersMenu_Release_DrawCounts::
    ld de, GlyphCopyDestList5 + $282
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $05
    call CopyRectTo20ByteRows_Bank1E
    ld de, SwapMonstersMenu_Release_DrawCounts_TileRect
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $01
    call CopyRectTo20ByteRows_Bank1E
    ld de, SwapMonstersMenu_Release_DrawCounts_TileRect_2
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

SECTION "Bank 1E SwapMonstersMenu_Release_DrawCounts_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 1 tiles, one row per line
SwapMonstersMenu_Release_DrawCounts_TileRect::
    db $b7, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; record: 1 x 2 tiles, one row per line
SwapMonstersMenu_Release_DrawCounts_TileRect_2::
    db $b7 ; id 0
    db $b5 ; id 1

; Releasing, step 24: unmarks the entry, marks the choice, redraws and returns to step $0C. (C1,
; E-0357)
SwapMonstersMenu_Release_MarkChoice::
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

SECTION "Bank 1E SwapMonstersMenu_Release_CopyName", ROMX

; Releasing, step 25: copies the chosen monster's name into wTextBuf0 for the script. (C2, E-0357;
; probed E-0384)
SwapMonstersMenu_Release_CopyName::
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

SECTION "Bank 1E SwapMonstersMenu_Release_DeleteMonster", ROMX

; Releasing, step 26: deletes the chosen monster's record (DeleteSRAMRecordAndCompact), relists the
; party, reloads the sprites and restores the box. (C1, E-0357)
SwapMonstersMenu_Release_DeleteMonster::
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
    call SwapMonstersMenu_Release_RestoreBox
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

SECTION "Bank 1E SwapMonstersMenu_Release_EggCursor", ROMX

; Releasing, step 40: the egg cursor: a page change goes back 4 steps, B answers 1 and goes on, A
; marks the egg and goes on four. (C1, E-0357)
SwapMonstersMenu_Release_EggCursor::
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

SECTION "Bank 1E SwapMonstersMenu_Release_DrawCountsAgain", ROMX

; Releasing, step 47: draws the count box with both counts. (C2, E-0357; probed E-0384)
SwapMonstersMenu_Release_DrawCountsAgain::
    ld de, GlyphCopyDestList5 + $282
    ld hl, wWindowTileBuffer + $10b
    lb bc, $0d, $05
    call CopyRectTo20ByteRows_Bank1E
    ld de, SwapMonstersMenu_Release_DrawCountsAgain_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_Release_DrawCountsAgain_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 1 tiles, one row per line
SwapMonstersMenu_Release_DrawCountsAgain_TileRect::
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; Releasing, step 48: lists the eggs, clamps the page cursor of four and draws the page arrows and
; numbers. (C1, E-0357)
SwapMonstersMenu_Release_ListEggs::
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

SECTION "Bank 1E SwapMonstersMenu_Release_UnmarkEgg", ROMX

; Releasing, step 49: unmarks the egg, marks the choice, redraws and returns to step $28. (C1,
; E-0357)
SwapMonstersMenu_Release_UnmarkEgg::
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

SECTION "Bank 1E SwapMonstersMenu_Release_ScriptThenDeleteEgg", ROMX

; Releasing, step 50: advances to step 51 (SwapMonstersMenu_Release_DeleteEgg) and starts the script
; (wScriptCommandType 0, wScriptStartRequest = $80). (C2, E-0370; probed E-0379)
SwapMonstersMenu_Release_ScriptThenDeleteEgg::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 1E SwapMonstersMenu_Release_DeleteEgg", ROMX

; Releasing, step 51: deletes the chosen egg's record, relists the party and restores the box. (C2,
; E-0357; probed E-0384)
SwapMonstersMenu_Release_DeleteEgg::
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
    call SwapMonstersMenu_Release_RestoreBox
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wListCursorAux], a
    ld [wCursorBlinkAE], a
    ret

SECTION "Bank 1E SwapMonstersMenu_Release_RestoreBox", ROMX

; Shared by SwapMonstersMenu_Release_DeleteMonster and SwapMonstersMenu_Release_DeleteEgg: copies
; the 8 x 1 border row SwapMonstersMenu_Release_RestoreBox_TileRect ($B4 x 7, $B5) to
; wWindowTileBuffer + $110, copies a 13 x 5 block back inside the screen buffer with attributes
; (CopyScreenBufferRectWithAttrs_1E: C = 5, HL = $0287, DE = $00BB, wArg1 = 0, wArg2 = $0D), writes
; the blank tile $C3 at SwapMenuCursorCells entry wListCursor and advances wScreenStep. (C2, E-0370;
; probed E-0379)
SwapMonstersMenu_Release_RestoreBox::
    ld de, SwapMonstersMenu_Release_RestoreBox_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_Release_RestoreBox_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
SwapMonstersMenu_Release_RestoreBox_TileRect::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0

; Releasing, step 54: reloads tiles six per call (list $9E). (C1, E-0357)
SwapMonstersMenu_Release_ReloadTiles::
    ld a, $9e
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld de, SaveTilesToBGMap1BottomHalf_Data
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

SECTION "Bank 1E SwapMonstersMenu_Release_ReloadFrameTiles", ROMX

; Releasing, step 55: reloads six frame tiles. (C1, E-0357)
SwapMonstersMenu_Release_ReloadFrameTiles::
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, BANK(Tiles2Plus720Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles1 + $4f0
    ld b, BANK(Tiles2Plus710Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles1 + $4e0
    ld b, BANK(Tiles2Plus700Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles
    ld hl, vTiles1 + $750
    ld b, BANK(Tiles1Plus710Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles1 + $760
    ld b, BANK(Tiles2Plus240Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus770Tiles
    ld hl, vTiles1 + $770
    ld b, BANK(Tiles1Plus770Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_Release_DrawBoxes", ROMX

; Releasing, step 53: draws two boxes and redraws. (C1, E-0357)
SwapMonstersMenu_Release_DrawBoxes::
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

SECTION "Bank 1E SwapMonstersMenu_Release_BackToOptions", ROMX

; Releasing, step 58: counts the records and returns to the option cursor (state 2) with answer 1.
; (C2, E-0357; probed E-0384)
SwapMonstersMenu_Release_BackToOptions::
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails", ROMX

; Screen state 9 of SwapMonstersMenu: the stats screen of a farm monster chosen in the farm lists of
; the Drop off and Pick up screens (SwapMonstersMenu_MoveRecords_YesNoCursor opens it, saving
; wReturnScreenState and wReturnScreenStep and setting wScreenStep to 0). wScreenStep picks one of
; 33 steps: 0-5 clear the BG map, copy the glyph tiles, draw the frame, the level row, stats and
; picture (DrawListEntriesCell5RecordDetails); 6 is the first page cursor
; (SwapMonstersMenu_ShowMonsterDetails_ListPage): B goes through 7-13, which redraw the list behind
; and let SwapMonstersMenu_ShowMonsterDetails_Leave restore the saved state and step, and A goes on
; to 14-20, which draw the second page (frame, personality, experience, sprite); 21 is its cursor (a
; move redraws the level row at 22 and returns to 15, A goes to 23, B returns to step 4); 23-27 draw
; and run the skills page (cursor at 27: B goes through 28-29 back to the second page at 17, A goes
; to the pedigree at 30); 30-32 draw the parents and run the pedigree cursor at 32 (B back to 23, A
; to 7). (C1, E-0379)
; by wScreenStep: draws the selected record's name, species, personality, level and status, category
; string and parent names
SwapMonstersMenu_ShowMonsterDetails::
    ld a, [wScreenStep]
    jumptable
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFrame
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails_ListPage
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadArea
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_Personality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails_StatsPage
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails_SkillsPage
    dw SwapMonstersMenu_ShowMonsterDetails_StatsFrames
    dw SwapMonstersMenu_ShowMonsterDetails_LevelAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigree
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails_PedigreePage

; Stats screen, step 3: draws the screen frame and, with two or more pages, the arrows and
; 'page/pages'. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, MonsterDetailsScreenTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_ListPage", ROMX

; Stats screen, step 6: runs sub-step wScreenSubStep: 0 SwapMonstersMenu_ShowMonsterDetails_Cursor1
; (the paged list cursor), 1 ClearTileAreasAndIncScreenSubStep, 2 RedrawRecordListAndNextStep
; (redraws the page names, wScreenStep -= 1), 3 SwapMonstersMenu_ShowMonsterDetails_RelistFarm
; (relists, then step 4). (C1, E-0372)
; moves the paged cursor, clears the panel, redraws the list and continues
; (ListRecordsState1ThenContinue)
SwapMonstersMenu_ShowMonsterDetails_ListPage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor1
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_RelistFarm

; Stats screen (cursor and redraw), sub-step 0: the paged cursor: a page change redraws the list
; (next sub-step), a move goes to step 4, B on one step, A draws a 6 x 6 box and goes to step $0E.
; (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_Cursor1::
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
    ld de, BlankPictureTileRect
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

SECTION "Bank 1E ClearTileAreasAndIncScreenSubStep", ROMX

; Sub-step 1 of the paged cursor steps of the stats screens (the redraw after a page change): clears
; four tile areas with FillTilesBxC (12 x 1 tiles at vTiles1 + $240, 15 x 1 at vTiles1 + $500, 5 x 1
; at vTiles1 + $700 and 2 x 1 at vTiles1 + $4E0), then adds 1 to wScreenSubStep. (C1, E-0379)
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

SECTION "Bank 1E RedrawRecordListAndNextStep", ROMX

; Sub-step 2 of the paged cursor steps of the stats screens: clamps the page and cursor of the
; five-entry list (ClampRecordListPageCursor5), redraws the names of the page
; (CallDrawRecordListPageNamesInBank1F, which adds 1 to wScreenStep), then subtracts 1 from
; wScreenStep so the screen stays on the same step, and adds 1 to wScreenSubStep. (C1, E-0379)
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_RelistFarm", ROMX

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails_ListPage: relists the farm monsters that are not
; eggs and redraws the page arrows (ListRecordsState1ThenContinue, which also advances wScreenStep),
; then sets wScreenStep to 4 and clears wScreenSubStep. (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails_RelistFarm::
    call ListRecordsState1ThenContinue
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_Leave", ROMX

; Stats screen, step 13 (leaving): reloads the sprites, erases the five marks, marks the entry again
; when returning to a list, redraws the screen and the bottom rows, restores the sprite state and
; hide tile $70, and returns to the saved screen state and step. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_Leave::
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_StatsPage", ROMX

; Stats screen, step 21 (after the personality, experience and sprite steps): runs sub-step
; wScreenSubStep: 0 SwapMonstersMenu_ShowMonsterDetails_StatsCursor (sprite and cursor), 1
; ClearTileAreasAndIncScreenSubStep, 2 RedrawRecordListAndNextStep, 3
; SwapMonstersMenu_ShowMonsterDetails_Relist. (C1, E-0372)
; draws the species sprite, clears the panel, redraws the list and continues
SwapMonstersMenu_ShowMonsterDetails_StatsPage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_StatsCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_Relist

; Sub-step 0 of stats step 21: unless wGameMode is 5 draws the record's species sprite
; (DrawListEntriesCell5SpeciesSprite), then runs UpdatePagedListCursor; every result clears
; hSpriteHideTile. $FB/$FC (a page change) go on one sub-step (redraw), $FD (a row move) goes on one
; step, A ($FF) goes on two steps, and B ($FE) draws the 12 x 15 rectangle
; MonsterDetailsStatsTileRect at scroll offset $68 and the 8 x 7 rectangle
; MonsterDetailsStatsLowerLeftTileRect at offset $160, then sets wScreenStep to 4. Also sub-step 0
; of SwapMonstersMenu_ShowMonsterDetails3_StatsPage. (C1, E-0372)
SwapMonstersMenu_ShowMonsterDetails_StatsCursor::
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
    ld de, MonsterDetailsStatsTileRect
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
    ld de, MonsterDetailsStatsLowerLeftTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_Relist", ROMX

; Sub-step 3 of stats step 21: ListRecordsState1ThenContinue (relists the non-egg records, clamps
; the page, draws the page marks and adds 1 to wScreenStep, undoing the decrement of
; RedrawRecordListAndNextStep), then clears wScreenSubStep. (C1, E-0372)
SwapMonstersMenu_ShowMonsterDetails_Relist::
    call ListRecordsState1ThenContinue
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_SkillsPage", ROMX

; Stats screen, step 27 (after the skill list and field ability steps): runs sub-step
; wScreenSubStep: 0 SwapMonstersMenu_ShowMonsterDetails_Cursor2, 1
; ClearTileAreasAndIncScreenSubStep, 2 RedrawRecordListAndNextStep, 3
; SwapMonstersMenu_ShowMonsterDetails_RelistToFrames. (C1, E-0372)
; as SwapMonstersMenu_ShowMonsterDetails_ListPage
SwapMonstersMenu_ShowMonsterDetails_SkillsPage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor2
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_RelistToFrames

; Stats screen (cursor and redraw 2), sub-step 0: the cursor: a page change redraws, a move back two
; steps, B blanks the text tiles and goes on, A loads the stats page's tiles and frames and goes on
; three. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_Cursor2::
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
    ld b, BANK(Tiles1Plus2E0Tiles_2)
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, MonsterDetailsPedigreeLowerLeftTileRect
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
    ld de, MonsterDetailsEmptyPedigreeTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_RelistToFrames", ROMX

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails_SkillsPage (screen step 27 of
; SwapMonstersMenu_ShowMonsterDetails), reached after a page change has cleared the tiles and
; redrawn the list (RedrawRecordListAndNextStep, wScreenStep -= 1): relists the farm monsters that
; are not eggs and redraws the page arrows (ListRecordsState1ThenContinue, wScreenStep += 1), then
; wScreenStep -= 4 and wScreenSubStep = 0. Together that goes back four steps from the cursor's
; step, to step 23 (SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames). (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails_RelistToFrames::
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames", ROMX

; Stats screen, step 23: draws the two frames of a stats page. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, MonsterDetailsBlankPageTileRect
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
    ld de, MonsterDetailsBlankPageLowerLeftTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_DrawNextPage", ROMX

; Stats screen, step 24: blanks the text tiles and draws the next page's two frames. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawNextPage::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, MonsterDetailsSkillsPageTileRect
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
    ld de, MonsterDetailsSkillsLowerLeftTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_PedigreePage", ROMX

; Stats screen, step 32 (after the pedigree frame and parents): runs sub-step wScreenSubStep: 0
; SwapMonstersMenu_ShowMonsterDetails_Cursor3, 1 ClearTileAreasAndIncScreenSubStep, 2
; RedrawRecordListAndNextStep, 3 SwapMonstersMenu_ShowMonsterDetails_RelistBack1. (C1, E-0372)
; as SwapMonstersMenu_ShowMonsterDetails_ListPage
SwapMonstersMenu_ShowMonsterDetails_PedigreePage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor3
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_RelistBack1

; Stats screen (cursor and redraw 3), sub-step 0: the cursor; with no input draws the party's
; species sprites (not in game mode 5); a page change redraws, a move goes back two steps, B to step
; $17, A to step 7. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_Cursor3::
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
    jr z, SwapMonstersMenu_ShowMonsterDetails_BackTwoSteps
    cp $fe
    jr z, SwapMonstersMenu_ShowMonsterDetails_BackToSkills
    cp $ff
    jr z, SwapMonstersMenu_ShowMonsterDetails_BackToList

.check_game_mode:
    ld a, [wGameMode]
    cp $05
    ret z
    farcall DrawListEntriesCell5PedigreeSprites
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_BackTwoSteps", ROMX

; Clears hSpriteHideTile, subtracts 2 from wScreenStep, blanks 8 x 5 tiles at vTiles2 + $200
; (FillTilesBxC) and resets the text window to vTiles1 with size $02, $12. Reached from
; SwapMonstersMenu_ShowMonsterDetails_Cursor3 on a row move ($FD) and as the tail of
; SwapMonstersMenu_ShowMonsterDetails_RelistBack1 and
; SwapMonstersMenu_ShowMonsterDetails3_MarkBack1. (C1, E-0372)
SwapMonstersMenu_ShowMonsterDetails_BackTwoSteps::
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_BackToSkills", ROMX

; B on the pedigree page (SwapMonstersMenu_ShowMonsterDetails_Cursor3): clears hSpriteHideTile and
; sets wScreenStep to $17 (step 23, SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames, which leads
; to the skill list page). (C2, E-0372; probed E-0379)
SwapMonstersMenu_ShowMonsterDetails_BackToSkills::
    xor a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_BackToList", ROMX

; A on the pedigree page (SwapMonstersMenu_ShowMonsterDetails_Cursor3): clears hSpriteHideTile and
; sets wScreenStep to 7, which in SwapMonstersMenu_ShowMonsterDetails starts the return to the
; record list (ClearBGMapAtScrollAndResetScroll, then the area graphics and the list) and in
; SwapMonstersMenu_ShowMonsterDetails2 and SwapMonstersMenu_ShowMonsterDetails3 is
; SwapMonstersMenu_ShowMonsterDetails3_DrawParty (then the list again). (C2, E-0372; probed E-0379)
SwapMonstersMenu_ShowMonsterDetails_BackToList::
    xor a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_RelistBack1", ROMX

; Stats screen, sub-step 3: relists the farm monsters and goes back one step (and two more with the
; text reset). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_RelistBack1::
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    jp SwapMonstersMenu_ShowMonsterDetails_BackTwoSteps

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3", ROMX

; Screen state $0E of SwapMonstersMenu: the same stats screen as
; SwapMonstersMenu_ShowMonsterDetails, for a list that another menu sets up
; (BattleEnd_AddJoinedMonster_OpenPickStats sets wScreenState = $0E, and
; BattleEnd_AddJoinedMonster_RunStatsScreen far-calls SwapMonstersMenu). wScreenStep picks one of 33
; steps and the page cursor steps are the party-mark versions
; (SwapMonstersMenu_ShowMonsterDetails3_ListPage, SwapMonstersMenu_ShowMonsterDetails3_StatsPage and
; others), which redraw the party marks (MarkPartyMembersInRecordListPage) after each page change;
; step 3 draws the screen frame without the page arrows
; (SwapMonstersMenu_ShowMonsterDetails3_DrawFrame) and step 7 redraws the party
; (SwapMonstersMenu_ShowMonsterDetails3_DrawParty). (C1, E-0379)
; screen state $0E: as SwapMonstersMenu_ShowMonsterDetails2
SwapMonstersMenu_ShowMonsterDetails3::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawFrame
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails3_ListPage
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawParty
    dw SwapMonstersMenu_ShowMonsterDetails3_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails3_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails3_ListRecords
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_Personality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails3_StatsPage
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails3_SkillsPage
    dw SwapMonstersMenu_ShowMonsterDetails_StatsFrames
    dw SwapMonstersMenu_ShowMonsterDetails_LevelAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigree
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails3_PedigreePage

; Stats screen (the party version), step 3: draws the screen frame. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_DrawFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, MonsterDetails3ScreenTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails2", ROMX

; Screen state $0C of SwapMonstersMenu: the stats screen for a list that another menu sets up
; (BattleEnd_AskToJoin_OpenPickStats sets wScreenState = $0C and lists the records with
; ListRecordsInUseNotEggs). It has the same 33 steps as SwapMonstersMenu_ShowMonsterDetails3 except
; step 3, which draws the screen frame with the page arrows
; (SwapMonstersMenu_ShowMonsterDetails_DrawFrame). (C1, E-0379)
; screen state $0C: the detail steps for the listed records
; (ListRecordsAndDrawListEntriesCell5Panel)
SwapMonstersMenu_ShowMonsterDetails2::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFrame
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails3_ListPage
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawParty
    dw SwapMonstersMenu_ShowMonsterDetails3_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails3_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails3_ListRecords
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_Personality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails3_StatsPage
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails3_SkillsPage
    dw SwapMonstersMenu_ShowMonsterDetails_StatsFrames
    dw SwapMonstersMenu_ShowMonsterDetails_LevelAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigree
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails3_PedigreePage

; Step 1 of SwapMonstersMenu_ShowMonsterDetails2 and SwapMonstersMenu_ShowMonsterDetails3: copies
; the tiles of GlyphCopyDestList4/GlyphCopySrcList4 (SwapMonstersMenu_CopyGlyphTiles) and 16
; GlyphFont glyphs (SwapMonstersMenu_CopySixteenTiles), blanks the tile areas
; (ClearTileAreasAndIncScreenSubStep), redraws the page names (RedrawRecordListAndNextStep), clamps
; the page and draws the page marks (SwapMonstersMenu_ClampListPage), then sets wScreenSubStep to 0
; and wScreenStep to 2. (C1, E-0372)
SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphs::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_CopyGlyphTiles
    call SwapMonstersMenu_CopySixteenTiles
    call ClearTileAreasAndIncScreenSubStep
    call RedrawRecordListAndNextStep
    call SwapMonstersMenu_ClampListPage
    xor a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_CopySixteenTiles", ROMX

; Copies 16 glyph tiles into VRAM. For index n = 0-15 byte n of
; SwapMonstersMenu_CopySixteenTiles_Data1 is a glyph number (the tile is GlyphFont + 16 * number,
; read from bank $1F) and word n of SwapMonstersMenu_CopySixteenTiles_Data2 is the VRAM address it
; goes to; each 16-byte tile is copied with CopyFromBankWaitVRAM (B = $1F, C = $10). Called from the
; first steps of the stats and pedigree screens (SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphs,
; SwapMonstersMenu_ShowParents2_CopyGlyphTiles); clobbers A, BC, DE and HL. (C1, E-0379)
; copies 16 tiles by the tables at $60B1 and $60C1
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

SECTION "Bank 1E SwapMonstersMenu_CopySixteenTiles_Data1", ROMX

; Sixteen glyph numbers, $A3 $54 $44 $11 $16 $19 $48 $24 $A6 $12 $31 $29 $32 $18 $14 $A3 (in the
; text charmap: colon, H, M, P, a, I, n, f, o, O, K, colon, and four numbers the charmap does not
; list). SwapMonstersMenu_CopySixteenTiles takes byte n as the glyph to copy from GlyphFont (bank
; $1F, 16 bytes per glyph) to the VRAM address in word n of SwapMonstersMenu_CopySixteenTiles_Data2.
; (C1, E-0381)
SwapMonstersMenu_CopySixteenTiles_Data1::
    db $a3, $54, $44, $11, $16, $19, $48, $24, $a6, $12, $31, $29, $32, $18, $14, $a3

; Sixteen little-endian VRAM addresses: $8ED0, $8EE0, $8EF0, $8F50, $8F60, $8F70, $8FD0, $8FE0,
; $8FF0, then $9700 to $9760 in steps of $10. SwapMonstersMenu_CopySixteenTiles copies the glyph
; given by byte n of SwapMonstersMenu_CopySixteenTiles_Data1 to word n. (C1, E-0381)
SwapMonstersMenu_CopySixteenTiles_Data2::
    db $d0, $8e, $e0, $8e, $f0, $8e, $50, $8f, $60, $8f, $70, $8f, $d0, $8f, $e0, $8f
    db $f0, $8f, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; Clears the BG map from the scroll origin and resets the scroll (ClearBGMapAtScrollAndResetScroll,
; which adds 1 to wScreenStep), copies each party member's name into its tiles
; (CopyPartyNamesToTiles) and clears wScreenSubStep. Step 7 of SwapMonstersMenu_ShowMonsterDetails2
; and SwapMonstersMenu_ShowMonsterDetails3, and step 9 of SwapMonstersMenu_ShowParents2. (C1,
; E-0372)
SwapMonstersMenu_ShowMonsterDetails3_DrawParty::
    call ClearBGMapAtScrollAndResetScroll
    call CopyPartyNamesToTiles
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_MoveOn", ROMX

; Stats screen (the party version), step 8: moves on. (C2, E-0357; probed E-0379)
SwapMonstersMenu_ShowMonsterDetails3_MoveOn::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowFarmMonsterDetails", ROMX

; Screen state $0A of SwapMonstersMenu: the stats screen of a farm monster chosen in the Check list
; (SwapMonstersMenu_Check_OpenStats opens it, returning to state 6 step $0C). It has the same 33
; steps as SwapMonstersMenu_ShowMonsterDetails3 except steps 1, 3 and 7-10: step 1 copies the glyph
; tiles of SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs, step 3 draws the frame with the page
; arrows, steps 7-9 clear the BG map, reload the area graphics and mark the entry like state 9, and
; step 10 (SwapMonstersMenu_ShowFarmMonsterDetails_ListFarm) copies the glyph tiles, relists the
; farm monsters (ListRecordsInUseNotEggs) and draws the family icon and stats box of the one under
; the cursor. (C1, E-0379)
; screen state $0A: the details of a farm record (ListRecordsInUseNotEggs)
SwapMonstersMenu_ShowFarmMonsterDetails::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFrame
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails3_ListPage
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadArea
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw SwapMonstersMenu_ShowFarmMonsterDetails_ListFarm
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_Personality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails3_StatsPage
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails3_SkillsPage
    dw SwapMonstersMenu_ShowMonsterDetails_StatsFrames
    dw SwapMonstersMenu_ShowMonsterDetails_LevelAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigree
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails3_PedigreePage

; Farm monster stats, step 10: copies the glyph tiles, lists the farm monsters and draws the family
; icon and stats box of the one under the cursor. (C1, E-0357)
SwapMonstersMenu_ShowFarmMonsterDetails_ListFarm::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_CopyGlyphTiles
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_DrawDetails", ROMX

; Party stats screen, step 4: draws the record's details (level, status and stats) and marks the
; party members on the page twice (wArg1 1, then 0). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_DrawDetails::
    call DrawListEntriesCell5RecordDetails
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_ListPage", ROMX

; Step 6 of SwapMonstersMenu_ShowMonsterDetails2, SwapMonstersMenu_ShowMonsterDetails3 and
; SwapMonstersMenu_ShowFarmMonsterDetails: runs sub-step wScreenSubStep: 0
; SwapMonstersMenu_ShowMonsterDetails_Cursor1, 1 ClearTileAreasAndIncScreenSubStep, 2
; RedrawRecordListAndNextStep, 3 SwapMonstersMenu_ShowMonsterDetails3_RedrawPage. (C1, E-0372)
; moves the paged cursor, clears the panel and redraws the list
SwapMonstersMenu_ShowMonsterDetails3_ListPage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor1
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_RedrawPage

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails3_ListPage: clamps the page cursor and draws the
; page arrows (SwapMonstersMenu_ClampListPage), writes tile $B6 (the boxes' left-edge tile) over the
; five rows of the party-mark column (SwapMonstersMenu_ShowMonsterDetails3_ClearMarks), then sets
; wScreenStep to 4 and clears wScreenSubStep; step 4
; (SwapMonstersMenu_ShowMonsterDetails3_DrawDetails) marks the party members again. (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails3_RedrawPage::
    call SwapMonstersMenu_ClampListPage
    call SwapMonstersMenu_ShowMonsterDetails3_ClearMarks
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_ListRecords", ROMX

; Party stats screen, step 10: copies the glyph tiles, lists the records with the panel of the one
; under the cursor and loads its family icon. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_ListRecords::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_CopyGlyphTiles
    call ListRecordsAndDrawListEntriesCell5Panel
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank1E
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_Clear", ROMX

; Party stats screen, step 0: clears the BG map, resets the scroll and loads a frame tile. (C1,
; E-0357)
SwapMonstersMenu_ShowMonsterDetails3_Clear::
    call ClearBGMapAtScrollAndResetScroll
    ld de, Tiles1Plus7F0Tiles
    ld hl, vTiles1 + $7f0
    ld b, BANK(Tiles1Plus7F0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_StatsPage", ROMX

; Step 21 of SwapMonstersMenu_ShowMonsterDetails2, SwapMonstersMenu_ShowMonsterDetails3 and
; SwapMonstersMenu_ShowFarmMonsterDetails: runs sub-step wScreenSubStep: 0
; SwapMonstersMenu_ShowMonsterDetails_StatsCursor, 1 ClearTileAreasAndIncScreenSubStep, 2
; RedrawRecordListAndNextStep, 3 SwapMonstersMenu_ShowMonsterDetails3_MarkListPage. (C1, E-0372)
; draws the species sprite, clears the panel and redraws the list
SwapMonstersMenu_ShowMonsterDetails3_StatsPage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_StatsCursor
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_MarkListPage

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails3_StatsPage (screen step 21 of
; SwapMonstersMenu_ShowFarmMonsterDetails, SwapMonstersMenu_ShowMonsterDetails2 and
; SwapMonstersMenu_ShowMonsterDetails3), reached after a page change has cleared the tiles and
; redrawn the list (RedrawRecordListAndNextStep, wScreenStep -= 1): clamps the page cursor and draws
; the page arrows and 'page/pages' (SwapMonstersMenu_ClampListPage, wScreenStep += 1), draws the
; party column's divider (SwapMonstersMenu_ShowMonsterDetails3_ClearMarks) and the party marks
; through MarkPartyMembersInRecordListPage, once with wArg1 = 1 (screen) and once with wArg1 = 0
; (window buffer). Then clears wScreenSubStep, so the screen stays on step 21 and goes back to its
; cursor (sub-step 0). (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails3_MarkListPage::
    call SwapMonstersMenu_ClampListPage
    call SwapMonstersMenu_ShowMonsterDetails3_ClearMarks
    ld a, $01
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_SkillsPage", ROMX

; Step 27 of SwapMonstersMenu_ShowMonsterDetails2, SwapMonstersMenu_ShowMonsterDetails3 and
; SwapMonstersMenu_ShowFarmMonsterDetails: runs sub-step wScreenSubStep: 0
; SwapMonstersMenu_ShowMonsterDetails_Cursor2, 1 ClearTileAreasAndIncScreenSubStep, 2
; RedrawRecordListAndNextStep, 3 SwapMonstersMenu_ShowMonsterDetails3_MarkBack4. (C1, E-0372)
; as SwapMonstersMenu_ShowMonsterDetails_ListPage
SwapMonstersMenu_ShowMonsterDetails3_SkillsPage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor2
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_MarkBack4

; Party stats screen, sub-step 3 (second version): clamps the page cursor, draws the marks and goes
; back four steps. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_MarkBack4::
    call SwapMonstersMenu_ClampListPage
    call SwapMonstersMenu_ShowMonsterDetails3_ClearMarks
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_PedigreePage", ROMX

; Step 32 of SwapMonstersMenu_ShowMonsterDetails2, SwapMonstersMenu_ShowMonsterDetails3 and
; SwapMonstersMenu_ShowFarmMonsterDetails: runs sub-step wScreenSubStep: 0
; SwapMonstersMenu_ShowMonsterDetails_Cursor3, 1 ClearTileAreasAndIncScreenSubStep, 2
; RedrawRecordListAndNextStep, 3 SwapMonstersMenu_ShowMonsterDetails3_MarkBack1. (C1, E-0372)
; as SwapMonstersMenu_ShowMonsterDetails_ListPage
SwapMonstersMenu_ShowMonsterDetails3_PedigreePage::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor3
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_MarkBack1

; Party stats screen, sub-step 3 (third version): clamps the page cursor, draws the marks, goes back
; one step and resets the text tiles. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_MarkBack1::
    call SwapMonstersMenu_ClampListPage
    call SwapMonstersMenu_ShowMonsterDetails3_ClearMarks
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
    jp SwapMonstersMenu_ShowMonsterDetails_BackTwoSteps

SECTION "Bank 1E SwapMonstersMenu_ShowParents2", ROMX

; Screen state $0D of SwapMonstersMenu: the pedigree screen of an egg for a list that another menu
; sets up (BattleEnd_AskToJoin_OpenEggStats sets wScreenState = $0D). wScreenStep picks one of 18
; steps: 0-3 clear the BG map, copy the glyph tiles and turn the paged cursor into a plain index,
; 4-6 draw the frame, the parents and the monster picture, 7 is the cursor
; (SwapMonstersMenu_ShowParents2_Cursor: result $FD with two or more flagged records goes to 8,
; which blanks the tiles and goes back to step 4; $FE and $FF go to 9), and 9-17 leave: clear the BG
; map and copy the party names, reload the area graphics, redraw the egg list and marks and return
; (SwapMonstersMenu_ShowParents2_Leave). It differs from SwapMonstersMenu_ShowParents in steps 1 and
; 9. (C1, E-0379)
; screen state $0D: as ShowParents
SwapMonstersMenu_ShowParents2::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowParents2_CopyGlyphTiles
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowParents2_ClearText
    dw SwapMonstersMenu_ShowParents2_DrawFrame
    dw SwapMonstersMenu_ShowParents2_DrawParents
    dw SwapMonstersMenu_ShowParents2_LoadPicture
    dw SwapMonstersMenu_ShowParents2_Cursor
    dw SwapMonstersMenu_ShowParents2_BlankTiles
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawParty
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadArea
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw SwapMonstersMenu_ShowParents2_CopyListGlyphs
    dw SwapMonstersMenu_Check_BlankTiles
    dw SwapMonstersMenu_ShowParents2_DrawEggBox
    dw SwapMonstersMenu_Check_DrawEggNames
    dw SwapMonstersMenu_ShowParents2_DrawMarks
    dw SwapMonstersMenu_ShowParents2_Leave

; Pedigree screen, step 1: copies the glyph tiles and sixteen frame tiles, then step 2. (C1, E-0357)
SwapMonstersMenu_ShowParents2_CopyGlyphTiles::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_CopyGlyphTiles
    call SwapMonstersMenu_CopySixteenTiles
    xor a
    ld [wScreenSubStep], a
    ld a, $02
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowParents", ROMX

; Screen state $0B of SwapMonstersMenu: the pedigree screen of an egg chosen in the Check or Release
; egg list (SwapMonstersMenu_Check_EggCursor and the box of SwapMonstersMenu_Release open it).
; wScreenStep picks one of 18 steps: 0-3 clear the BG map, copy the glyph tiles and turn the paged
; cursor into a plain index, 4-6 draw the frame, the parents (DrawRecordParentNames,
; DrawRecordFamilyEntries) and the monster picture, 7 is the cursor
; (SwapMonstersMenu_ShowParents2_Cursor: result $FD with two or more flagged records goes to 8,
; which blanks the tiles and goes back to step 4; $FE and $FF go to 9), and 9-17 leave by clearing
; the BG map, redrawing the egg list and marks and returning to the saved state and step
; (SwapMonstersMenu_ShowParents2_Leave). (C1, E-0379)
; screen state $0B: DrawRecordParentNames with a cursor, then the record list page
SwapMonstersMenu_ShowParents::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowParents2_ClearText
    dw SwapMonstersMenu_ShowParents2_DrawFrame
    dw SwapMonstersMenu_ShowParents2_DrawParents
    dw SwapMonstersMenu_ShowParents2_LoadPicture
    dw SwapMonstersMenu_ShowParents2_Cursor
    dw SwapMonstersMenu_ShowParents2_BlankTiles
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadArea
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw SwapMonstersMenu_ShowParents2_CopyListGlyphs
    dw SwapMonstersMenu_Check_BlankTiles
    dw SwapMonstersMenu_ShowParents2_DrawEggBox
    dw SwapMonstersMenu_Check_DrawEggNames
    dw SwapMonstersMenu_ShowParents2_DrawMarks
    dw SwapMonstersMenu_ShowParents2_Leave

; Pedigree screen, step 3: blanks the text tiles, loads a frame tile and turns the paged cursor into
; a plain index (page x 4 + row). (C1, E-0357)
SwapMonstersMenu_ShowParents2_ClearText::
    ld hl, vTiles2 + $200
    ld bc, $1304
    call FillTilesBxC
    ld de, Tiles1Plus7D0Tiles
    ld hl, vTiles1 + $6d0
    ld b, BANK(Tiles1Plus7D0Tiles)
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

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_DrawFrame", ROMX

; Pedigree screen, step 4: draws the screen frame and loads the party's species sprites
; (LoadPedigreeSpeciesSpriteGraphics). (C1, E-0357)
SwapMonstersMenu_ShowParents2_DrawFrame::
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowParents2_DrawFrame_TileRect
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
    farcall LoadPedigreeSpeciesSpriteGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_DrawParents", ROMX

; Pedigree screen, step 5: draws the record's parents' names and its family entries, the arrow tiles
; $6C/$6D, and with two or more entries the scroll arrows. (C1, E-0357)
SwapMonstersMenu_ShowParents2_DrawParents::
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
    ld b, BANK(Tiles2Plus20Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus30Tiles
    ld hl, vTiles2 + $30
    ld b, BANK(Tiles2Plus30Tiles)
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

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_LoadPicture", ROMX

; Pedigree screen, step 6: in two sub-steps loads the monster's picture into VRAM $9480
; (LoadMonsterPicture) and, on the GBC, its palette and attributes, then draws its 6 x 6 frame. (C1,
; E-0357)
SwapMonstersMenu_ShowParents2_LoadPicture::
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
    ld de, SwapMonstersMenu_ShowParents2_LoadPicture_TileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_Cursor", ROMX

; Pedigree screen, step 7: the cursor; with no input draws the party's species sprites (skipped in
; link session 8); A with two or more entries goes on, B or Start split the cursor back into page
; and row and go on two steps. (C1, E-0357)
SwapMonstersMenu_ShowParents2_Cursor::
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
    farcall DrawPedigreeSpeciesSprites
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

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_BlankTiles", ROMX

; Pedigree screen, step 8: blanks the text and picture tiles and goes back four steps. (C1, E-0357)
SwapMonstersMenu_ShowParents2_BlankTiles::
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

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_CopyListGlyphs", ROMX

; Pedigree screen, step 12: copies the list glyph tiles. (C1, E-0357)
SwapMonstersMenu_ShowParents2_CopyListGlyphs::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_Leave", ROMX

; Pedigree screen, step 17 (leaving): reloads the sprites, redraws the screen and bottom rows,
; restores the sprite state and hide tile $70 and returns to the saved screen state and step. (C1,
; E-0357)
SwapMonstersMenu_ShowParents2_Leave::
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

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_DrawEggBox", ROMX

; Pedigree screen, step 14: draws the egg box, clamps the page cursor of four and draws the page
; numbers (or the release box's top row when returning to state 7). (C1, E-0357)
SwapMonstersMenu_ShowParents2_DrawEggBox::
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
    ld de, SwapMonstersMenu_ShowParents2_DrawEggBox_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $01
    call CopyRectTo20ByteRows_Bank1E
    jr .loop

SECTION "Bank 1E SwapMonstersMenu_ShowParents2_DrawEggBox_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 1 tiles, one row per line
SwapMonstersMenu_ShowParents2_DrawEggBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0

; Pedigree screen, step 16: loads a mark tile, draws the page's marks and marks the option (and the
; entry when returning to state 7). (C1, E-0357)
SwapMonstersMenu_ShowParents2_DrawMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, BANK(Tiles2Plus420Tiles)
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

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails", ROMX

; Screen state 8 of SwapMonstersMenu: the stats screen of a party member chosen in the party lists
; of the Drop off and Pick up screens (SwapMonstersMenu_MoveRecords_YesNoCursor opens it). It has
; the same 33 steps as SwapMonstersMenu_ShowMonsterDetails, but its cursor steps use the party
; cursor (UpdateListCursorListCursor: SwapMonstersMenu_ShowPartyMemberDetails_ListPage at 6,
; SwapMonstersMenu_ShowPartyMemberDetails_StatsPage at 21,
; SwapMonstersMenu_ShowPartyMemberDetails_Cursor at 27,
; SwapMonstersMenu_ShowPartyMemberDetails_Pedigree at 32), step 3 also draws the party marks of the
; list (SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame), and step 13
; (SwapMonstersMenu_ShowPartyMemberDetails_Leave) relists the party before returning to the saved
; state and step. (C1, E-0379)
; screen state 8: the details of a party record (ListPartyRecordsWithState2ToListEntries; name,
; species, personality, level and status)
SwapMonstersMenu_ShowPartyMemberDetails::
    ld a, [wScreenStep]
    jumptable
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowPartyMemberDetails_ListPage
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadArea
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowPartyMemberDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_Personality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowPartyMemberDetails_StatsPage
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowPartyMemberDetails_Cursor
    dw SwapMonstersMenu_ShowMonsterDetails_StatsFrames
    dw SwapMonstersMenu_ShowMonsterDetails_LevelAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigree
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowPartyMemberDetails_Pedigree

; Fills the 32 x 32 BG map from BGMapAddressAtScroll_Bank1E with BGFillTile (wArg1/wArg2 = its
; address, wArg3 = wArg4 = $20, wArg7 = 0) through FillTileRectWithArg1Tile, then sets hScrollX and
; hScrollY to 0 and adds 1 to wScreenStep. Steps 0 and 7 of the stats screens and the first step of
; the pedigree screens run it. (C1, E-0379)
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs", ROMX

; Stats screen, step 1: copies the glyph tiles (GlyphCopySrcList4). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_MoveOn", ROMX

; Stats screen, step 2: moves on. (C2, E-0357; probed E-0379)
SwapMonstersMenu_ShowMonsterDetails_MoveOn::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame", ROMX

; Party member stats, step 3: draws the screen frame and the party marks in the list. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, PartyMemberDetailsScreenTileRect
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
    call MarkPartyMembersInList
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E DrawListEntriesCell5RecordDetails", ROMX

; Stats screen step 4 (also called by SwapMonstersMenu_ShowMonsterDetails3_DrawDetails): for the
; record at GetListEntriesCell5Address, with SRAM bank 0 enabled, draws its level and status row
; (DrawRecordLevelAndStatusRow_1E), the five stat values ATK to WLD
; (DrawListEntriesCell5RecordDetails_DrawStats) and HP, maximum HP, MP and maximum MP
; (DrawListEntriesCell5RecordDetails_DrawHPAndMP) into the BG map, closes SRAM and adds 1 to
; wScreenStep. (C1, E-0379)
; for the record at wListEntries cell 5, with SRAM enabled, runs DrawRecordLevelAndStatusRow_1E,
; 7332 and 7399; wScreenStep += 1 (E-0122)
DrawListEntriesCell5RecordDetails::
    call GetListEntriesCell5Address
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call DrawRecordLevelAndStatusRow_1E
    call DrawListEntriesCell5RecordDetails_DrawStats
    call DrawListEntriesCell5RecordDetails_DrawHPAndMP
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_LoadPicture", ROMX

; Stats screen, step 5: in two sub-steps draws a 6 x 6 frame and loads the monster's picture into
; VRAM $9200 (LoadMonsterPicture), then on the GBC its palette and attributes, and draws the
; picture. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_LoadPicture::
    ld a, [wScreenSubStep]
    and a
    jp nz, .call_get_list_entries_cell5_address
    call BGMapAddressAtScroll_Bank1E
    ld de, $0161
    add hl, de
    ld de, BlankPictureTileRect
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
    ld de, MonsterDetailsPictureTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails_ListPage", ROMX

; Party member stats, step 6: the party cursor: a move goes to step 4, B on one, A draws a 6 x 6 box
; and goes to step $0E. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_ListPage::
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
    ld de, BlankPictureTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_ReloadArea", ROMX

; Stats screen, step 8: reloads the area graphics (LoadAreaGraphicsForAreaGraphicsIndex) and the
; background palettes. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ReloadArea::
    farcall LoadAreaGraphicsForAreaGraphicsIndex
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_MarkEntry", ROMX

; Stats screen, step 9: copies the yes/no glyph tiles, blanks the menu marks (three, or five outside
; state 8) and marks the entry outside states $0A and $0B. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_MarkEntry::
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_CopyGlyphTiles
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

SECTION "Bank 1E ListRecordsAndDrawListEntriesCell5Panel", ROMX

; Stats screen step 10: lists the party (ListPartyRecordsWithState2ToListEntries) when wScreenState
; is 8, otherwise the farm monsters that are not eggs (ListRecordsState1NotEggs), then loads the
; family icon of the record at GetListEntriesCell5Address (LoadFamilyIconTileForRecordB_Bank1E),
; draws its stats box (CallDrawRecordStatsBoxForArg1InBank1D with wArg1 = the record) and adds 1 to
; wScreenStep. (C1, E-0379)
; lists the records (ListPartyRecordsWithState2ToListEntries in state 8, else
; ListRecordsState1NotEggs), loads the family icon of the record at wListEntries cell 5 and draws
; it, then wScreenStep += 1 (E-0124)
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles", ROMX

; Stats screen, step 11: blanks the name and number tiles. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles::
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_DrawNames", ROMX

; Stats screen, step 12: draws the record's name and species name. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawNames::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails_Leave", ROMX

; Party member stats, step 13 (leaving): relists the party, loads the icon, reloads the sprites,
; redraws, restores the sprite state and returns to the saved screen state and step. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_Leave::
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_BlankText", ROMX

; Stats screen, step 14: blanks the text tiles at VRAM $9200. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_BlankText::
    ld hl, vTiles2 + $200
    ld bc, $0f02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame", ROMX

; Stats screen, step 17: draws the 12 x 15 page frame. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, MonsterDetailsPage2TileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_Personality", ROMX

; Stats screen, step 18: for the record under the cursor (GetListEntriesCell5Address), with SRAM
; bank 0 enabled, shows its personality name (ShowRecordPersonalityName) and draws its
; MON_MASTER_NAME at vTiles2 + $290 (DrawRecordMasterNameTiles), disables SRAM, then falls into step
; 19 (SwapMonstersMenu_ShowMonsterDetails_DrawExperience) in the same call. (C1, E-0372)
SwapMonstersMenu_ShowMonsterDetails_Personality::
    call GetListEntriesCell5Address
    ld a, [hl]
    push hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    call ShowRecordPersonalityName
    pop hl
    call DrawRecordMasterNameTiles
    xor a
    ld [rRAMG2], a

; Stats screen, step 19: loads the family icon and draws the experience and the experience still
; needed (below). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawExperience::
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
    call LoadFamilyIconForRecordB_Bank1E
    pop hl
    call DrawRecordExperience
    xor a
    ld [rRAMG2], a

; Stats screen, step 20: decompresses the species' graphics, hides sprites, shows the record's
; category-$11 string (ShowListEntriesCell5RecordItemName) and draws the 8 x 7 frame; goes on three
; steps. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_LoadSprite::
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
    farcall ShowListEntriesCell5RecordItemName
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, MonsterDetailsItemBoxTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails_StatsPage", ROMX

; Party member stats, step 21: draws the species metasprite at (64, 144) and runs the cursor: a move
; goes on one step, A on two, B draws the page frames and goes to step 4. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_StatsPage::
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
    ld de, MonsterDetailsStatsTileRect
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
    ld de, MonsterDetailsStatsLowerLeftTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow", ROMX

; Stats screen, step 22: draws the level and status row and goes to step $0F. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow::
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_ListSkills", ROMX

; Stats screen, step 25: lists the record's eight skills (MON_SKILLS, strings of category 4), or
; string $0E of category 8 when it knows none, in a 9 x 1 window per skill. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ListSkills::
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

; Stats screen, step 26: shows the species' category-$13 string and goes on two steps. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ShowCategory::
    farcall ShowCursorRecordFieldAbility
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails_Cursor", ROMX

; Party member stats, step 27: the cursor: a move goes back two steps, B blanks the text and goes
; on, A loads the pedigree page's tiles and frames and goes on three. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_Cursor::
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
    ld b, BANK(Tiles1Plus2E0Tiles_2)
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, MonsterDetailsPedigreeLowerLeftTileRect
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
    ld de, MonsterDetailsEmptyPedigreeTileRect
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_StatsFrames", ROMX

; Stats screen, step 28: in two sub-steps draws the page frames, then copies the yes/no glyphs. (C1,
; E-0357)
SwapMonstersMenu_ShowMonsterDetails_StatsFrames::
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_swap_monsters_menu_copy_glyph_tiles
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, MonsterDetailsPanelTopTileRect
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
    ld de, MonsterDetailsItemBoxTileRect
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

.call_swap_monsters_menu_copy_glyph_tiles:
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_CopyGlyphTiles
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_LevelAndName", ROMX

; Stats screen, step 29: draws the level and status row and the name and species, loads a tile and
; goes to step $11. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_LevelAndName::
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
    ld b, BANK(Tiles1Plus4A0Tiles)
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

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails_DrawPedigree", ROMX

; Stats screen, step 30: draws the pedigree frame and loads the party's species sprites, then falls
; into the parents (below). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawPedigree::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, MonsterDetailsPedigreeTileRect
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
    farcall LoadPedigreeSpeciesSpriteGraphics
    pop hl

; Stats screen, step 31: draws the record's parents' names and family entries and goes on two steps.
; (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawParents::
    ld b, [hl]
    call DrawRecordParentNames
    call DrawRecordFamilyEntries
    ld a, $f0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowPartyMemberDetails_Pedigree", ROMX

; Party member stats, step 32: runs UpdateListCursorListCursor; with no input draws the party's
; species sprites for the entry (DrawPedigreeSpeciesSprites with wArg1/wArg2 =
; GetListEntriesCell5Address, C = 0). Every press clears hSpriteHideTile: a row move ($FD) goes back
; two steps, blanking 8 x 5 tiles at vTiles2 + $200 and resetting the text window; B ($FE) sets
; wScreenStep to $17; A ($FF) sets it to 7. (C1, E-0372)
SwapMonstersMenu_ShowPartyMemberDetails_Pedigree::
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
    farcall DrawPedigreeSpeciesSprites
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

SECTION "Bank 1E DrawRect6x6FromAtScroll41", ROMX

; Draws the blank 6 x 6 picture frame BlankPictureTileRect at BGMapAddressAtScroll_Bank1E + $41
; through DrawTileRectAtHLFromDE_Bank1E (wArg3 = wArg4 = 6, wArg7 = 0). Only
; SwapMonstersMenu_ShowParents2_LoadPicture calls it (sub-step 0), before the monster picture is
; loaded. (C1, E-0379)
; draws a 6 x 6 tile rectangle from $651B at BGMapAddressAtScroll_Bank1E + $41
; (DrawTileRectAtHLFromDE_Bank1E, attributes cleared) (E-0118) (E-0344: the address in its name
; dropped or read as the label there; was DrawRect6x6FromAtScroll41)
DrawRect6x6FromAtScroll41::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0041
    add hl, de
    ld de, BlankPictureTileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_Bank1E
    ret

SECTION "Bank 1E DrawTileRectAtHLFromDE_Bank1E", ROMX

; HL = BG map address, DE = tile rectangle, wArg3 = width and wArg4 = rows set by the caller: stores
; HL in wArg5/wArg6 and DE in wArg1/wArg2 and far-calls DrawTileRectFromArg1Params, which draws the
; rectangle (with wArg7 = 0 it also clears the CGB attributes of those cells). The stats and
; pedigree screens use it for their frames and the monster picture. (C1, E-0379)
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

SECTION "Bank 1E ShowRecordPersonalityName", ROMX

; HL = address of a byte holding the record number, SRAM enabled: shows the personality name of that
; record (string PersonalityIndexOfRecord, 0-26, of category 7 in the bank $08 string database) with
; ShowString_Bank08 in a window of 1 row and width 9 at vTiles2 + $200, then puts the text window
; back to its default (vTiles1, 2 rows, width $12). Step 18 of the stats screens
; (SwapMonstersMenu_ShowMonsterDetails_Personality) calls it. (C1, E-0379)
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

SECTION "Bank 1E DrawRecordParentNames", ROMX

; Draws record B's parents (field offsets from DrawRecordParentNames_Data1, or _Data2 when family
; bit 4 is set): for each parent its name into VRAM tiles ($8A00, $8B40), or '???' when its species
; word is $FFFF, its species name at ($92, $50) / ($93, $90) (DrawMonsterNameOfRecordField), and one
; more name field ($8AF0, $8C30); SRAM is enabled for the reads and disabled after. (C1, E-0357)
; for record B draws the names of its parents (fields from $6ED2 or $6EDA by bit 4 of field $0D), or
; '???' when unknown (E-0131)
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

SECTION "Bank 1E DrawMonsterNameOfRecordField", ROMX

; B = record number, wArg3 = offset of a word field of the record that holds a monster id,
; wArg1/wArg2 = VRAM address (high, low), SRAM enabled: reads that word, looks up the monster name
; (category 2 of the bank $08 string database, wDataBank is set to $08 for the reads and restored),
; copies 16 bytes of it to wNameGlyphBuf and draws its glyphs at the VRAM address with
; CopyGlyphTilesToVRAM. Keeps BC. DrawRecordParentNames calls it for the species name of each
; parent. (C1, E-0379)
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
    ld a, BANK(StringDatabase)
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

SECTION "Bank 1E DrawRecordParentNames_Data1", ROMX

; Eight record field offsets in two groups of four, one group per parent: $1A (MON_PARENT1_SPECIES),
; $8E (MON_PARENT1_NAME), $1A again, $1E (MON_PARENT1_MASTER), then $1C (MON_PARENT2_SPECIES), $99
; (MON_PARENT2_NAME), $1C, $29 (MON_PARENT2_MASTER). DrawRecordParentNames walks it in order when
; bit 4 of the record MON_FAMILY byte is clear: the first byte of a group is tested for an unknown
; parent, the second is the name to draw, the third the species word whose name is drawn, the fourth
; the master name. (C1, E-0381)
DrawRecordParentNames_Data1::
    db $1a, $8e, $1a, $1e, $1c, $99, $1c, $29

; The same eight field offsets as DrawRecordParentNames_Data1 with the two groups swapped: $1C, $99,
; $1C, $29 (parent 2), then $1A, $8E, $1A, $1E (parent 1). DrawRecordParentNames walks it in order
; when bit 4 of the record MON_FAMILY byte is set, so the second parent is drawn first. (C1, E-0381)
DrawRecordParentNames_Data2::
    db $1c, $99, $1c, $29, $1a, $8e, $1a, $1e

; HL = address of a byte holding the record number, SRAM enabled: first overwrites the five tiles at
; vTiles2 + $290 with the 16-byte tile pattern at SolidColor1Tile (five CopyTileBytesToVRAM_Bank1E
; calls), then copies MON_MASTER_NAME of the record to wNameGlyphBuf, ends it with $F0 and draws its
; glyphs at vTiles2 + $290 with CopyGlyphTilesToVRAM. Step 18 of the stats screens
; (SwapMonstersMenu_ShowMonsterDetails_Personality) calls it after the personality name. (C1,
; E-0379)
; clears five tiles at vTiles2 + $290 (copying the tile at SolidColor1Tile), then copies the name at
; record [HL] field $0F (CopyRecordNameToNameGlyphBuf) and draws it there (E-0120)
DrawRecordMasterNameTiles::
    push hl
    ld hl, SolidColor1Tile
    ld de, vTiles2 + $290
    call CopyTileBytesToVRAM_Bank1E
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAM_Bank1E
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAM_Bank1E
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAM_Bank1E
    ld hl, SolidColor1Tile
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

SECTION "Bank 1E DrawRecordExperience", ROMX

; Draws the record's experience (seven digits) and, below its level cap, the experience still needed
; for the next level (the exp table entry for its curve minus MON_EXP). (C1, E-0357)
DrawRecordExperience::
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

SECTION "Bank 1E LinkRecordScreen_DrawParents_DrawNamesAndFamily", ROMX

; E = SRAM record (the list entry LinkRecordScreen_DrawParents reads through
; GetListEntriesCell4Address_BankF0): sets B = E and draws its parents' names
; (DrawRecordParentNames) and family entries (DrawRecordFamilyEntries). (C1, E-0370)
LinkRecordScreen_DrawParents_DrawNamesAndFamily::
    ld b, e
    call DrawRecordParentNames
    call DrawRecordFamilyEntries
    ret

SECTION "Bank 1E DrawRecordFamilyEntries", ROMX

; B = record number: draws the family strip of the pedigree page for the two parents, with SRAM
; enabled and closed again at the end. Bit 4 of MON_FAMILY picks the table
; DrawRecordFamilyEntries_Data1 or DrawRecordFamilyEntries_Data2 (the order of the two parents). For
; each parent it reads the species word (MON_PARENT1_SPECIES or MON_PARENT2_SPECIES); when its high
; byte is $FF (parent unknown) it only copies one 16-byte tile from vTiles1 + $430 to vTiles2 + $6C0
; (the second parent: $6D0). Otherwise it shows the family icon of the parent in tile $6C (second:
; $6D) and the plus value (MON_PARENT1_PLUS or MON_PARENT2_PLUS) at BG map offset $6A (second: $18A)
; through LoadRecordWordFieldAndContinue, and writes the mark tile B returned by
; DrawRecordFamilyEntries_PickMarkTile at offset $6E (second: $18E). (C1, E-0379)
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
    call DrawRecordFamilyEntries_PickMarkTile
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
    call DrawRecordFamilyEntries_PickMarkTile
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

SECTION "Bank 1E DrawRecordFamilyEntries_PickMarkTile", ROMX

; DE points at a byte of a family field table (DrawRecordFamilyEntries_Data1 or _Data2): returns BC
; = wNameBufPlaceholder ($CCCD) when [DE] is $98 (MON_PARENT1_PLUS) and BC = wNameBufAlt ($CDCC)
; otherwise. The two names are only used as the constants $CCCD and $CDCC here:
; DrawRecordFamilyEntries writes B ($CC for the first parent, $CD for the second) as a mark tile
; next to the entry of that parent. The routine has no other effect. (C2, E-0379)
; BC = wNameBufPlaceholder when the byte at DE is $98 (the '???' placeholder), else wNameBufAlt
; (E-0122)
DrawRecordFamilyEntries_PickMarkTile::
    ld a, [de]
    cp $98
    jr z, .done
    ld bc, wNameBufAlt
    jr .return

.done:
    ld bc, wNameBufPlaceholder

.return:
    ret

SECTION "Bank 1E DrawRecordFamilyEntries_Data1", ROMX

; Six record field offsets in two groups of three, one group per parent: $1A (MON_PARENT1_SPECIES),
; $98 (MON_PARENT1_PLUS), $1A, then $1C (MON_PARENT2_SPECIES), $A3 (MON_PARENT2_PLUS), $1C.
; DrawRecordFamilyEntries walks it in order when bit 4 of the record MON_FAMILY byte is clear: the
; first byte tests whether the parent is known, the second is the plus value field, the third the
; species word given to LoadRecordWordFieldAndContinue. DrawRecordFamilyEntries_PickMarkTile tests
; the plus offset ($98 or not). (C1, E-0381)
DrawRecordFamilyEntries_Data1::
    db $1a, $98, $1a, $1c, $a3, $1c

; The same six field offsets as DrawRecordFamilyEntries_Data1 with the two groups swapped: $1C
; (MON_PARENT2_SPECIES), $A3 (MON_PARENT2_PLUS), $1C, then $1A, $98, $1A. DrawRecordFamilyEntries
; walks it in order when bit 4 of the record MON_FAMILY byte is set. (C1, E-0381)
DrawRecordFamilyEntries_Data2::
    db $1c, $a3, $1c, $1a, $98, $1a

; B = record number (SRAM enabled), wArg5 = offset of a word field, wArg4 = tile number: far-calls
; LoadRecordWordFieldArg5AndShowIcon, which loads that word of the record as a monster id and writes
; the family icon of that monster to tile wArg4, then jumps to DrawRecordPlusValue with the same B
; (wArg1 = field of the plus value, wArg2/wArg3 = BG map offset). DrawRecordFamilyEntries calls it
; once for each known parent. (C1, E-0379)
; far-calls LoadRecordWordFieldArg5AndShowIcon for record B and continues at DrawRecordPlusValue
; (E-0126) (E-0344: the address in its name dropped or read as the label there; was
; LoadRecordWordFieldAndContinue)
LoadRecordWordFieldAndContinue::
    push bc
    ld c, b
    farcall LoadRecordWordFieldArg5AndShowIcon
    pop bc
    jp DrawRecordPlusValue

SECTION "Bank 1E LoadFamilyIconForRecordB_Bank1E", ROMX

; Loads the family icon of record B (MON_FAMILY low nibble, icon slot wArg4). (C1, E-0357)
LoadFamilyIconForRecordB_Bank1E::
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

; B = SRAM record (SRAM enabled), wArg1 = record field, wArg2/wArg3 = BG map offset (high, low) from
; the scroll origin: when the record's byte wArg1 is non-zero writes tile $1E there and then the
; value's tens digit (left out when blank) and units digit as tiles $E0 + digit (the hundreds digit
; is not drawn); a zero value draws nothing. Reached by LoadFamilyIconForRecordB_Bank1E
; (SwapMonstersMenu_ShowMonsterDetails_DrawExperience passes MON_PLUS) and
; LoadRecordWordFieldAndContinue (DrawRecordFamilyEntries passes MON_PARENT1_PLUS or
; MON_PARENT2_PLUS). (C1, E-0370)
DrawRecordPlusValue::
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

SECTION "Bank 1E ClampRecordListPageCursor5", ROMX

; Sets wListPages to the number of five-entry pages of wListCount records and wListLastRow to the
; last used row of the current page: 4 when wListPageIndex is not on the last page or the last page
; is full, otherwise the remainder minus 1. A page index past the end of a full list is moved back
; by 1, and when wListCursor is below the last row it is left alone, while a cursor beyond it is
; erased (ClampRecordListPageCursor5_EraseCursor) and set to the last row. Called by
; SwapMonstersMenu_ClampListPage, RedrawRecordListAndNextStep and the paged-list screens of other
; banks (far-call). (C1, E-0379)
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
    call ClampRecordListPageCursor5_EraseCursor
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

SECTION "Bank 1E ClampRecordListPageCursor5_EraseCursor", ROMX

; Writes the blank tile $C3 at BGMapAddressAtScroll_Bank1E + the word
; ClampRecordListPageCursor5_EraseCursor_Data[wListCursor] (the cursor mark places in column 1 of
; rows 1, 3, 5, 7 and 9 of a five-entry list), stepping back on a scroll wrap
; (StepBGMapAddressBackOnScrollWrap) and waiting for VRAM access. Only ClampRecordListPageCursor5
; calls it, to hide the old cursor mark before it moves the cursor up. (C1, E-0379)
; writes tile $C3 at BGMapAddressAtScroll_Bank1E + the offset from the word table $71D7 + 2 *
; wListCursor (E-0120) (E-0344: the address in its name dropped or read as the label there; was
; ClampRecordListPageCursor5_EraseCursor)
ClampRecordListPageCursor5_EraseCursor::
    ld b, $c3
    ld a, [wListCursor]
    add a
    ld hl, ClampRecordListPageCursor5_EraseCursor_Data
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

SECTION "Bank 1E ClampRecordListPageCursor5_EraseCursor_Data", ROMX

; Five little-endian words, $0021, $0061, $00A1, $00E1 and $0121: BG map offsets of column 1 in rows
; 1, 3, 5, 7 and 9 (32 tiles per BG row) from the top-left screen tile, the cursor mark places of a
; five-entry list. ClampRecordListPageCursor5_EraseCursor indexes it by wListCursor and writes the
; blank tile $C3 there. (C1, E-0381)
ClampRecordListPageCursor5_EraseCursor_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; Sets wListPages to the number of four-entry pages of wListCount records and wListLastRow to the
; last used row of the current page: 3 when wListPageIndex is not on the last page or the last page
; is full, otherwise the remainder minus 1. A page index past the end of a full list is moved back
; by 1, and a wListCursor beyond the last row is erased (ClampRecordListPageCursor4_EraseCursor) and
; set to the last row. Called by the egg lists of this bank (SwapMonstersMenu_Check_DrawEggBox,
; SwapMonstersMenu_Release_ListEggs, SwapMonstersMenu_ShowParents2_DrawEggBox) and by other banks
; (far-call). (C1, E-0379)
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
    call ClampRecordListPageCursor4_EraseCursor
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

SECTION "Bank 1E ClampRecordListPageCursor4_EraseCursor", ROMX

; Writes the blank tile $C3 at BGMapAddressAtScroll_Bank1E + the word
; ClampRecordListPageCursor4_EraseCursor_Data[wListCursor] (the cursor mark places in column 8 of
; rows 1, 3, 5 and 7 of a four-entry list), stepping back on a scroll wrap and waiting for VRAM
; access. Only ClampRecordListPageCursor4 calls it, to hide the old cursor mark before it moves the
; cursor up. (C1, E-0379)
; writes tile $C3 at BGMapAddressAtScroll_Bank1E + the offset from the word table $7255 + 2 *
; wListCursor (E-0120) (E-0344: the address in its name dropped or read as the label there; was
; ClampRecordListPageCursor4_EraseCursor)
ClampRecordListPageCursor4_EraseCursor::
    ld b, $c3
    ld a, [wListCursor]
    add a
    ld hl, ClampRecordListPageCursor4_EraseCursor_Data
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

SECTION "Bank 1E ClampRecordListPageCursor4_EraseCursor_Data", ROMX

; Four little-endian words, $0028, $0068, $00A8 and $00E8: BG map offsets of column 8 in rows 1, 3,
; 5 and 7 (32 tiles per BG row) from the top-left screen tile, the cursor mark places of a
; four-entry list. ClampRecordListPageCursor4_EraseCursor indexes it by wListCursor and writes the
; blank tile $C3 there. (C1, E-0381)
ClampRecordListPageCursor4_EraseCursor_Data::
    db $28, $00, $68, $00, $a8, $00, $e8, $00

; HL = address of a byte holding the record number, SRAM enabled; HL is kept. Draws the level row of
; a stats screen into the BG map at BGMapAddressAtScroll_Bank1E + $29
; (StepBGMapAddressBackOnScrollWrap, each tile written after WaitForVRAMAccess): the cap mark $6F
; when MON_LEVEL is at least MON_MAX_LEVEL (otherwise the blank tile $C3), the two label tiles $EA
; and $ED, the level as two digit tiles ($E0 + digit, leading zero blank), then three status tiles
; ($C0 when MON_STATUS bit 0 is set, $C1 for bit 2, $C2 for bit 7, else $C3) and, two tiles on, the
; sex mark $CC + bit 0 of MON_SEX. Called by DrawListEntriesCell5RecordDetails,
; SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow and
; SwapMonstersMenu_ShowMonsterDetails_LevelAndName. (C1, E-0379)
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

SECTION "Bank 1E WriteThreeC3TilesAtHL_Bank1E", ROMX

; Writes the blank tile $C3 to the three VRAM bytes from HL (each after WaitForVRAMAccess with
; interrupts off); HL is kept, C and E are clobbered. DrawRecordLevelAndStatusRow_1E calls it to
; clear the three status tile places before it sets the ones that apply. (C1, E-0379)
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

SECTION "Bank 1E WriteTileC0AtHL_Bank1E", ROMX

; Writes tile $C0 at VRAM address HL (after WaitForVRAMAccess, interrupts off); clobbers A.
; DrawRecordLevelAndStatusRow_1E calls it when bit 0 of MON_STATUS is set. (C1, E-0379)
; writes tile $C0 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC0AtHL_Bank1E::
    di
    call WaitForVRAMAccess
    ld a, $c0
    ld [hl], a
    ei
    ret

SECTION "Bank 1E WriteTileC1AtHL_Bank1E", ROMX

; Writes tile $C1 at VRAM address HL (after WaitForVRAMAccess, interrupts off); clobbers A.
; DrawRecordLevelAndStatusRow_1E calls it when bit 2 of MON_STATUS is set. (C1, E-0379)
; writes tile $C1 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC1AtHL_Bank1E::
    di
    call WaitForVRAMAccess
    ld a, $c1
    ld [hl], a
    ei
    ret

SECTION "Bank 1E WriteTileC2AtHL_Bank1E", ROMX

; Writes tile $C2 at VRAM address HL (after WaitForVRAMAccess, interrupts off); clobbers A.
; DrawRecordLevelAndStatusRow_1E calls it when bit 7 of MON_STATUS is set. (C1, E-0379)
; writes tile $C2 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC2AtHL_Bank1E::
    di
    call WaitForVRAMAccess
    ld a, $c2
    ld [hl], a
    ei
    ret

SECTION "Bank 1E DrawListEntriesCell5RecordDetails_DrawStats", ROMX

; HL = address of the record number (SRAM enabled): draws MON_ATK, MON_DEF, MON_AGL, MON_INT and
; MON_WLD (the field list after it) as three digit tiles each ($E0 + digit, leading zeros blanked by
; BlankLeadingZeroDigits_F), from BG map offset $70 past the scroll origin, one value every $40
; bytes (two map rows). (C1, E-0370)
DrawListEntriesCell5RecordDetails_DrawStats::
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
    ld de, DrawListEntriesCell5RecordDetails_DrawStats_Data
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

SECTION "Bank 1E DrawListEntriesCell5RecordDetails_DrawStats_Data", ROMX

; Five record field offsets, $63 (MON_ATK), $65 (MON_DEF), $67 (MON_AGL), $69 (MON_INT) and $6B
; (MON_WLD), each a word. DrawListEntriesCell5RecordDetails_DrawStats loops over index 0 to 4, reads
; that word of the record, and draws it as three digit tiles two BG rows below the previous value,
; starting at BG offset $70 from the screen origin. (C1, E-0381)
DrawListEntriesCell5RecordDetails_DrawStats_Data::
    db $63, $65, $67, $69, $6b

; HL = address of the record number (SRAM enabled): draws MON_HP, MON_MAX_HP, MON_MP and MON_MAX_MP
; as three digit tiles each ($E0 + digit, leading zeros blanked) at BG map offsets $1CC, $1D0, $20C
; and $210 from the scroll origin, with the scroll wrap (StepBGMapAddressBackOnScrollWrap). (C1,
; E-0370)
DrawListEntriesCell5RecordDetails_DrawHPAndMP::
    ld c, $00

.loop:
    push hl
    ld a, [hl]
    ld b, a
    push bc
    ld a, c
    ld hl, DrawListEntriesCell5RecordDetails_HPMPFields
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
    ld hl, DrawListEntriesCell5RecordDetails_HPMPOffsets
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

SECTION "Bank 1E DrawListEntriesCell5RecordDetails_HPMPFields", ROMX

; Four record field offsets, MON_HP, MON_MAX_HP, MON_MP and MON_MAX_MP ($5B, $5D, $5F, $61).
; DrawListEntriesCell5RecordDetails_DrawHPAndMP reads entry C (0-3) as the field for
; LoadSRAMRecordWord and draws that word as three digit tiles. (C1, E-0372)
DrawListEntriesCell5RecordDetails_HPMPFields::
    db $5b, $5d, $5f, $61

; Four words, the BG map offsets from the scroll origin where
; DrawListEntriesCell5RecordDetails_DrawHPAndMP puts each value's three digits: $1CC (HP), $1D0 (max
; HP), $20C (MP) and $210 (max MP), that is rows 14 and 16, columns 12 and 16 of the 32-wide map.
; The reader adds entry C to BGMapAddressAtScroll_Bank1E and steps back over the scroll wrap
; (StepBGMapAddressBackOnScrollWrap). (C1, E-0372)
DrawListEntriesCell5RecordDetails_HPMPOffsets::
    db $cc, $01, $d0, $01, $0c, $02, $10, $02

; HL = table of 16-bit addresses, C = count: stores the blank tile $C3 at the addresses of entries 0
; to C - 1 of the table (StoreBAtWordTableEntry_Bank1E for each). With C = 0 it still erases entry
; 0, because the loop body runs once before the count is tested.
; SwapMonstersMenu_ShowMonsterDetails_Leave calls it with SwapMenuCursorCells and C = 5 to erase the
; five option marks. (C2, E-0379)
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

SECTION "Bank 1E StoreBAtWordTableEntry_Bank1E", ROMX

; HL = table of 16-bit addresses, A = index: stores B at the address held in entry A (two bytes per
; entry, low byte first); BC is kept, A ends equal to B, DE ends as the address written and HL ends
; on the high byte of the entry. The swap menu uses it with SwapMenuCursorCells and
; SwapMenuCursorCellsFrom5 to put cursor mark tiles into wWindowTileBuffer. (C2, E-0379)
; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks)
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

SECTION "Bank 1E CopyBytesDEToHL_Bank1E", ROMX

; DE = source, HL = destination, BC = count (a 16-bit number; BC = 0 would copy 65536 bytes): copies
; BC bytes upward; DE and HL end just past the copy, BC and A end as 0. (C2, E-0379)
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

SECTION "Bank 1E CopyLow3BitsToWRAMBank2_Bank1E", ROMX

; DE = source, HL = destination, BC = count: sets rSVBK to 2 first, so a source in $D000-$DFFF is
; read from WRAM bank 2, copies BC bytes with each byte ANDed with $07 (the low three bits of a CGB
; attribute), then sets rSVBK back to 0. DE and HL end past the copy, BC ends as 0.
; CopyScreenBufferRectWithAttrs_1E and the screen save and restore steps use it for the attribute
; buffers. (C2, E-0379)
; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks)
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

SECTION "Bank 1E CopyTileBytesToVRAM_Bank1E", ROMX

; HL = source, DE = VRAM destination: copies 16 bytes (one tile), each written with interrupts off
; after rSTAT bit 1 is clear; HL and DE end past the tile, C ends as 0 and A is clobbered.
; DrawRecordMasterNameTiles calls it five times in a row and DrawRecordFamilyEntries calls it for
; the unknown-parent tile. (C1, E-0379)
; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
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

SECTION "Bank 1E SwapMonstersMenu_CopyGlyphTiles", ROMX

; HL = list of VRAM destinations, DE = list of source addresses in bank $1F: from entry 0 copies one
; 16-byte tile per entry (CopyFromBankWaitVRAM) until the destination list's $FF, then clears
; wGlyphListPos. Used by the swap menu's glyph steps (SwapMonstersMenu_SetupPartyList_CopyGlyphs,
; SwapMonstersMenu_Check_CopyGlyphs and others). (C1, E-0370)
SwapMonstersMenu_CopyGlyphTiles::
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

SECTION "Bank 1E CopyRectTo20ByteRows_Bank1E", ROMX

; DE = source, HL = destination, B = width, C = rows: copies B bytes per row from [DE] on, the rows
; of the destination 20 ($14) bytes apart (the width of a screen buffer), and DE ends past the
; source. When wIsCGB is 0 it then returns with BC and HL as they were; on CGB it also zero-fills
; the same B x C rectangle at HL + $0E68 (the attribute buffer of the window buffer) with rSVBK = 2,
; restores rSVBK to 0 and ends with HL at the row after that rectangle and C = 0. (C2, E-0379)
; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks)
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

SECTION "Bank 1E DrawScreenBufferRect_Bank1E", ROMX

; HL = BG map address, B = width, C = rows, DE = offset into wScreenTileBuffer: draws that rectangle
; of the screen buffer to the BG map (CopyRectToBGMapWrapped). When HL is exactly $9800 it also sets
; wTextCursorLo and wTextCursorHi to HL + $01C1. On CGB it then draws the same rectangle from
; wScreenAttrBuffer + DE (WRAM bank 2) into VRAM bank 1, the attributes, and restores rSVBK and rVBK
; to 0; on DMG BC, DE and HL are kept. The swap menu calls it with DE = $01CC (the menu screen
; buffer at wWindowTileBuffer + $64) and B = $14. (C1, E-0379)
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

SECTION "Bank 1E BGMapAddressAtScroll_Bank1E", ROMX

; Returns HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry at the top left of
; the screen for the current scroll (row hScrollY / 8, column hScrollX / 8, with no wrap); clobbers
; A and DE. The swap menu adds an offset to it before it writes tiles or draws a rectangle. (C1,
; E-0379)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
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

SECTION "Bank 1E DrawC5BEC6AtScrollOffsetDE_Bank1E", ROMX

; DE = offset: draws the frame tiles of the page indicator at BGMapAddressAtScroll_Bank1E + DE, tile
; $C5 at that place, $BE two entries on and $C6 two further on (each written after WaitForVRAMAccess
; with interrupts off); only the first address is stepped back on a scroll wrap
; (StepBGMapAddressBackOnScrollWrap). DrawPageOfPagesAtScrollOffset puts the page numbers between
; them, one entry to the right of the offset and three entries on. Called with DE = $0142 or $010E
; by SwapMonstersMenu_ClampListPage, SwapMonstersMenu_Check_DrawEggBox,
; SwapMonstersMenu_Release_ListEggs and SwapMonstersMenu_ShowMonsterDetails_DrawFrame. (C1, E-0379)
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

SECTION "Bank 1E StoreC5BEC6AtHLStride2_Bank1E", ROMX

; HL = tile buffer address: stores $C5 at [HL], $BE at [HL + 2] and $C6 at [HL + 4], the same three
; page indicator tiles as DrawC5BEC6AtScrollOffsetDE_Bank1E but into a tile buffer; HL ends as HL +
; 4 and A as $C6. SwapMonstersMenu_ClampListPage calls it with wWindowTileBuffer + $12E and
; SwapMonstersMenu_Check_DrawEggBox with wWindowTileBuffer + $112. (C2, E-0379)
; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks)
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

SECTION "Bank 1E DrawPageOfPagesAtScrollOffset", ROMX

; wArg1 (high) and wArg2 (low) = offset: with HL = BGMapAddressAtScroll_Bank1E + that offset, writes
; tile $E0 + wListPageIndex + 1 (the current page, counted from 1) at HL and tile $E0 + wListPages
; (the page count) two entries on, each stepped back on a scroll wrap and written after
; WaitForVRAMAccess. The page indicator of the record lists, drawn between the tiles of
; DrawC5BEC6AtScrollOffsetDE_Bank1E. (C1, E-0379)
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

SECTION "Bank 1E DrawPageOfPagesAtArg1_Bank1E", ROMX

; wArg1 (high) and wArg2 (low) = a tile buffer address: writes tile $E0 + wListPageIndex + 1 (the
; current page, counted from 1) there and tile $E0 + wListPages (the page count) two bytes later; HL
; ends on that second byte. The tile buffer version of DrawPageOfPagesAtScrollOffset;
; SwapMonstersMenu_ClampListPage calls it with wWindowTileBuffer + $12F. (C2, E-0379)
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

SECTION "Bank 1E BlankLeadingZeroDigits_F", ROMX

; Blanks leading zeros of the three digits in wDigits: when wDigits is 0 it becomes $E3, and then
; when wDigits + 1 is also 0 it becomes $E3 as well; the last digit is never changed. Adding $E0 to
; $E3 gives the blank tile $C3, so the callers (which add $E0 to each digit when they draw it) show
; a leading zero as blank. Clobbers A and HL. (C2, E-0379)
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

SECTION "Bank 1E LoadFamilyIconTileForRecordB_Bank1E", ROMX

; B = record number: with SRAM bank 0 enabled, reads MON_FAMILY of the record, sets wWorkBuf to its
; low nibble (the family) and wWorkBuf + 1 to $C7 and far-calls LoadFamilyIconTileForWorkBuf, which
; writes the 16-byte icon of that family to tile $C7; then disables SRAM. The stats and list steps
; (for example SwapMonstersMenu_MoveRecords_DrawIconAndStats) call it for the record under the
; cursor. (C1, E-0379)
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

SECTION "Bank 1E CallDrawRecordStatsBoxForArg1InBank1D", ROMX

; wArg1 = record number: far-calls DrawRecordStatsBoxForArg1 (bank $1D), which draws the stats box
; of that record (its mark, level and four stat words, per its own comment) into the screen buffer.
; The list steps call it after the family icon was loaded by LoadFamilyIconTileForRecordB_Bank1E.
; (C2, E-0379; probed E-0384)
; far-calls DrawRecordStatsBoxForArg1 (E-0122) (E-0344: the address in its name dropped or read as
; the label there; was CallDrawRecordStatsBoxForArg1InBank1D)
CallDrawRecordStatsBoxForArg1InBank1D::
    farcall DrawRecordStatsBoxForArg1
    ret

SECTION "Bank 1E CopyScreenBufferRectWithAttrs_1E", ROMX

; HL = destination offset and DE = source offset (both from wScreenTileBuffer), C = rows,
; wArg1:wArg2 = bytes per row as a 16-bit number (wArg1 is 0 in every call here): for each row
; copies that many bytes with CopyBytesDEToHL_Bank1E; on CGB it also copies the same bytes of
; wScreenAttrBuffer with each byte ANDed with $07 (CopyLow3BitsToWRAMBank2_Bank1E). Each row moves
; both offsets on by 20 bytes. The swap menu uses it to put an area of the saved field screen in
; wScreenTileBuffer back into the menu screen buffer (wWindowTileBuffer + $64 is wScreenTileBuffer +
; $1CC). Returns with C = 0. (C2, E-0379)
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

SECTION "Bank 1E MarkPartyMembersInList", ROMX

; Marks the party members in the list: for each entry in state 2 writes tile $E1 + its number at HL,
; stepping C bytes. (C1, E-0357)
MarkPartyMembersInList::
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

SECTION "Bank 1E UnpackBCDToDigitsArg1_Bank1E", ROMX

; Unpacks the packed decimal number left by Number24ToPackedBCD (hTemp3 = millions, hTemp2 =
; hundred-thousands and ten-thousands, hTemp1 = thousands and hundreds, hTemp0 = tens and ones) into
; the seven bytes wArg1 to wArg7, one digit each, and turns leading zeros into $E3 (so adding $E0
; gives the blank tile $C3); the last digit wArg7 is never blanked. DrawRecordExperience calls it
; before DrawSevenDigitsFromArg1_Bank1E. (C2, E-0379)
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

SECTION "Bank 1E DrawSevenDigitsFromArg1_Bank1E", ROMX

; HL = VRAM address: writes the seven bytes wArg1 to wArg7 as tiles $E0 + value from HL on, each
; after WaitForVRAMAccess with interrupts off; HL ends 7 past the start and DE past wArg7.
; DrawRecordExperience calls it twice, for the experience and for the experience still needed. (C1,
; E-0379)
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

SECTION "Bank 1E StoreTemp0BytesToSRAMRecord", ROMX

; A = record number, C = field offset, B = count, SRAM enabled by the caller: copies B bytes from
; hTemp0 onward to sRecords + A * $A5 + C (the record address of SRAMRecordAddress); HL and DE are
; kept. The swap menu uses it with hTemp0 = 1 or 2 for MON_STATE (to move a record between farm and
; party) and hTemp0 = 0 for MON_STATUS. (C2, E-0379)
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

SECTION "Bank 1E GetListEntriesCell5Address", ROMX

; Returns HL = the address of one list entry: wListEntries + 5 * wListPageIndex + wListCursor, which
; treats the list as pages of five entries with wListCursor the place on the page. It far-calls
; SetArg5ToListEntriesCell5, which leaves the address in wArg5 (high byte) and wArg6 (low byte),
; then continues into ListEntriesCellAddressToHL to read it back. The sum is done in bytes, so it is
; only right while 5 * wListPageIndex + wListCursor stays under 256. (C2, E-0378)
; far-calls SetArg5ToListEntriesCell5, then HL = wArg5 (high) / wArg6 (low) (E-0075)
GetListEntriesCell5Address::
    farcall SetArg5ToListEntriesCell5
    jr ListEntriesCellAddressToHL

SECTION "Bank 1E GetListEntriesCell4Address", ROMX

; Returns HL = the address of one list entry: wListEntries + 4 * wListPageIndex + wListCursor, the
; pages-of-four twin of GetListEntriesCell5Address. It far-calls SetArg5ToListEntriesCell4, which
; leaves the address in wArg5 (high byte) and wArg6 (low byte), and then falls into
; ListEntriesCellAddressToHL to load it into HL. SplitListCursorBy4_Bank1E builds the page index and
; place on the page that this routine reads back. (C2, E-0378)
; far-calls SetArg5ToListEntriesCell4, then HL = wArg5 (high) / wArg6 (low) (E-0075)
GetListEntriesCell4Address::
    farcall SetArg5ToListEntriesCell4

; Shared tail of GetListEntriesCell5Address and GetListEntriesCell4Address: returns HL = the list
; entry address left in wArg5 (high) and wArg6 (low) by SetArg5ToListEntriesCell5 or
; SetArg5ToListEntriesCell4. (C2, E-0370; probed E-0378)
ListEntriesCellAddressToHL::
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

SECTION "Bank 1E SwapMonstersMenu_ShowMonsterDetails3_ClearMarks", ROMX

; Writes tile $B6 (the boxes' left-edge tile) over the five party-mark places of the record list: on
; the BG map at the scroll origin + $20 + $40 * k (k = 0-4, through BGMapAddressAtScroll_Bank1E and
; StepBGMapAddressBackOnScrollWrap, waiting for VRAM access) and in wWindowTileBuffer + $78, $A0,
; $C8, $F0 and $118. These are the places MarkPartyMembersInRecordListPage draws its marks
; (MarkPartyMembersInRecordListPage_Data2 and MarkPartyMembersInRecordListPage_Data1), so the old
; marks are erased before the callers draw them again. Clobbers A, C, DE, HL. (C1, E-0372)
SwapMonstersMenu_ShowMonsterDetails3_ClearMarks::
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

SECTION "Bank 1E SplitListCursorBy4_Bank1E", ROMX

; Turns a flat list position into a page and a place on the page for lists of four entries per page:
; wListPageIndex = wListCursor / 4 and wListCursor = wListCursor mod 4, using DivideHLByA. Returns A
; = the new page index; DE and HL are clobbered. Its only caller is in this bank (the record list
; page code), and GetListEntriesCell4Address is the reader of the pair it leaves. (C2, E-0378)
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

SECTION "Bank 1E SaveAndHideSpriteState_Bank1E", ROMX

; Saves the sprite drawing state and then hides all sprites: wSavedSpriteClipMode =
; hSpriteWindowClipMode, wSavedFieldDrawFlags = hFieldDrawFlags and wSavedSpriteSlotCount =
; wSpriteSlotCount. Then hSpriteWindowClipMode and hSpriteHideTile are cleared to 0, hFieldDrawFlags
; is set to $FF and wSpriteSlotCount to 0. The old hSpriteHideTile is not saved.
; RestoreSpriteStateFromSavedFieldDrawFlags undoes it; farcalled by menus in banks $0D, $14, $15 and
; $16. (C2, E-0378)
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

SECTION "Bank 1E RestoreSpriteStateFromSavedFieldDrawFlags", ROMX

; Puts back what SaveAndHideSpriteState_Bank1E stored: hSpriteWindowClipMode = wSavedSpriteClipMode,
; hFieldDrawFlags = wSavedFieldDrawFlags and wSpriteSlotCount = wSavedSpriteSlotCount.
; hSpriteHideTile is not restored from a copy but set to $80, its usual value. Called by the swap
; menu and farcalled from banks $0D and $15. (C2, E-0378)
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

SECTION "Bank 1E BlankTwoTableEntriesSwapMenuCursorCellsFrom5", ROMX

; Writes tile $C3 into the two window tile buffer cells that are entries 0 and 1 of
; SwapMenuCursorCellsFrom5 (wWindowTileBuffer + $120 and + $148, two text rows apart), through
; StoreBAtWordTableEntry_Bank1E. Clobbers A, B, DE and HL. Judging by the table name these are the
; cursor cells of the swap menu; the swap menu code calls it three times. What tile $C3 looks like
; is not read. (C2, E-0378)
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

SECTION "Bank 1E GlyphCopyDestList0", ROMX

; passed in HL, with GlyphCopySrcList0 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
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
    dw GlyphFont + $1b0, GlyphFont + $2c0, GlyphFont + $320, GlyphFont + $330, GlyphFont + $290, GlyphFont + $d0, GlyphFont + $260, GlyphFont + $2e0 ; entry 0
    dw GlyphFont + $380, GlyphFont + $c0, GlyphFont + $2b0, GlyphFont + $350, GlyphFont + $2f0, GlyphFont + $240, GlyphFont + $e0, GlyphFont + $3b0
    dw GlyphFont + $370, GlyphFont + $170, GlyphFont + $190, GlyphFont + $110, GlyphFont + $160, GlyphFont + $190, GlyphFont + $900, GlyphFont + $900
    dw GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $a30
    dw $ffff

; passed in HL, with GlyphCopySrcList1 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 9 VRAM tile addresses, then $FFFF
GlyphCopyDestList1::
    dw vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0, vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0 ; entry 0
    dw vTiles1 + $2f0, rIE

; the source list paired with GlyphCopyDestList1; its own $FFFF is not read (E-0200, C1)
; record: 9 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList1::
    dw GlyphFont + $330, GlyphFont + $290, GlyphFont + $d0, GlyphFont + $260, GlyphFont + $2e0, GlyphFont + $380, GlyphFont + $c0, GlyphFont + $2b0 ; entry 0
    dw GlyphFont + $350, $ffff

; passed in HL, with GlyphCopySrcList2 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 10 VRAM tile addresses, then $FFFF
GlyphCopyDestList2::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740 ; entry 0
    dw vTiles1 + $4e0, vTiles1 + $4f0, rIE

; the source list paired with GlyphCopyDestList2; its own $FFFF is not read (E-0200, C1)
; record: 10 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList2::
    dw GlyphFont + $1b0, GlyphFont + $2c0, GlyphFont + $320, GlyphFont + $e0, GlyphFont + $3b0, GlyphFont + $370, GlyphFont + $170, GlyphFont + $190 ; entry 0
    dw GlyphFont + $220, GlyphFont + $280, $ffff

; passed in HL, with GlyphCopySrcList3 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
; bytes from bank $1F at each source to each destination until a destination of $FFFF (E-0200, C1)
; record: 6 VRAM tile addresses, then $FFFF
GlyphCopyDestList3::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, rIE ; entry 0

; the source list paired with GlyphCopyDestList3; its own $FFFF is not read (E-0200, C1)
; record: 6 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList3::
    dw GlyphFont + $120, GlyphFont + $310, GlyphFont + $290, GlyphFont + $320, GlyphFont + $180, GlyphFont + $140, $ffff ; entry 0

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

; passed in HL, with GlyphCopySrcList4 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
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
    dw GlyphFont + $a0, GlyphFont + $1d0, GlyphFont + $140, GlyphFont + $d0, GlyphFont + $e0, GlyphFont + $f0, GlyphFont + $100, GlyphFont + $150 ; entry 0
    dw GlyphFont + $120, GlyphFont + $170, GlyphFont + $200, GlyphFont + $160, GlyphFont + $280, GlyphFont + $3b0, GlyphFont + $370, GlyphFont + $390
    dw GlyphFont + $2f0, GlyphFont + $b0, GlyphFont + $240, GlyphFont + $360, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900
    dw GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $900, GlyphFont + $a20, GlyphFont + $900, GlyphFont + $ac0, GlyphFont + $a60
    dw $ffff

; the source list paired with GlyphCopyDestList5; its own $FFFF is not read (E-0200, C1)
; record: 15 source addresses in bank $1F, then $FFFF (not read)
GlyphCopySrcList5::
    dw GlyphFont + $160, GlyphFont + $320, GlyphFont + $310, GlyphFont + $370, GlyphFont + $360, GlyphFont + $280, GlyphFont + $350, GlyphFont + $e0 ; entry 0
    dw GlyphFont + $2a0, GlyphFont + $120, GlyphFont + $310, GlyphFont + $290, GlyphFont + $320, GlyphFont + $180, GlyphFont + $140, $ffff

; passed in HL, with GlyphCopySrcList5 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
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
