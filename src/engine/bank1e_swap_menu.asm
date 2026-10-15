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

; Closing the menu session, step 1: far-calls CloseBreedMenu, whose jump table on the same
; wScreenList value runs CloseBreedMenu_RestoreGlyphs (copies the field glyph tiles back, clears the
; menu state, advances wScreenList and puts the text window back). (C1, E-0370)
CloseMenuE9_RestoreGlyphs::
    farcall CloseBreedMenu
    ret

; Closing the menu session, step 2: decompresses Tiles1Gfx (bank $46) into VRAM $8800 and blanks the
; name tiles. (C1, E-0357)
CloseMenuE9_LoadTiles::
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

; Closing the menu session, step 3: far-calls CloseBreedMenu, which with wScreenList = 3 runs
; CloseBreedMenu_RedrawNamesAndFinish (redraws the name tiles, clears wMessageMode, wScreenList and
; the menu state, refills wTextBuf0 with the player's name, resets the text window and starts the
; script). (C1, E-0370)
CloseMenuE9_RedrawNamesAndFinish::
    farcall CloseBreedMenu
    ret

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
; (C1, E-0357)
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

; by wScreenStep: the tile map, ListPartyRecordsWithState2ToListEntries and CountRecordsInUse
; (E-0293)
SwapMonstersMenu_SetupPartyList::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_SetupPartyList_SaveTiles
    dw SwapMonstersMenu_SetupPartyList_CopyGlyphs
    dw SwapMonstersMenu_SetupPartyList_ListParty
    dw SwapMonstersMenu_SetupPartyList_DrawOptions

; Swap menu party list, step 0: far-calls SetupTileMapAtBGMap1, which copies the tiles at the VRAM
; addresses listed in CloseHibernateMenu_RestoreGlyphs_Data to $9C00 + 16 * n, six per frame, and
; goes to step 1 at the end of the list (CopyListedTilesSixPerFrame). (C1, E-0370)
SwapMonstersMenu_SetupPartyList_SaveTiles::
    farcall SetupTileMapAtBGMap1
    ret

; Swap menu party list, step 1: copies the menu's glyph tiles (GlyphCopySrcList0). (C1, E-0357)
SwapMonstersMenu_SetupPartyList_CopyGlyphs::
    ld hl, GlyphCopyDestList0
    ld de, GlyphCopySrcList0
    call SwapMonstersMenu_CopyGlyphTiles
    ld hl, wScreenStep
    inc [hl]
    ret

; Swap menu party list, step 2: lists the party records in state 2 into wListEntries and wListCount
; (ListPartyRecordsWithState2ToListEntries) and goes to step 3. (C1, E-0370)
SwapMonstersMenu_SetupPartyList_ListParty::
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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

; Draws the blank tile ($C3) at the current option. (C1, E-0357)
SwapMonstersMenu_OptionCursor_Hide::
    ld b, $c3
    jr SwapMonstersMenu_OptionCursor_DrawTile

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

; data read by SwapMonstersMenu (10 bytes) (E-0347)
SwapMonstersMenu_OptionCursor_DrawTile_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01

; Swap menu, state 3: lists the party (SwapMonstersMenu_ListParty_StartOption). (C1, E-0357)
SwapMonstersMenu_ListParty::
    farcall SwapMonstersMenu_ListParty_StartOption
    ret

; by wScreenStep: record lists of party and farm, StoreTemp0BytesToSRAMRecord, capacity from the
; farm level, CountRecordsInUse (E-0288)
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

; Moving records, step 6: saves a 12 x 13 screen area with attributes. (C1, E-0357)
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

; Moving records, step 8: copies the box glyph tiles (GlyphCopySrcList1). (C1, E-0357)
SwapMonstersMenu_MoveRecords_CopyBoxGlyphs::
    ld hl, GlyphCopyDestList1
    ld de, GlyphCopySrcList1
    call SwapMonstersMenu_CopyGlyphTiles
    ld hl, wScreenStep
    inc [hl]
    ret

; Moving records, step 9: returns to the option menu's last setup step (state 1, step 3:
; SwapMonstersMenu_SetupPartyList_DrawOptions, which redraws the options and goes to the option
; cursor) and starts the script. (C1, E-0370)
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

; Moving records, step 10: copies the yes/no glyph tiles (GlyphCopySrcList3). (C1, E-0357)
SwapMonstersMenu_MoveRecords_CopyYesNoGlyphs::
    ld hl, GlyphCopyDestList3
    ld de, GlyphCopySrcList3
    call SwapMonstersMenu_CopyGlyphTiles
    ld hl, wScreenStep
    inc [hl]
    ret

; Moving records, step 11: draws the yes/no box, plays sound $6C and resets the choice. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawYesNoAgain::
    ld de, SwapMonstersMenu_MoveRecords_DrawYesNoAgain_TileRect
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
SwapMonstersMenu_MoveRecords_DrawYesNoAgain_TileRect::
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
    jr SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile

; B = $C3 (blank tile) and joins the cursor draw (E-0122) (E-0344: the address in its name dropped
; or read as the label there; was DrawBlankTileC3_Bank1E)
DrawBlankTileC3_Bank1E::
    ld b, $c3
    jr SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile

; Draws the chosen tile ($BC) at the yes/no cursor. (C1, E-0357)
SwapMonstersMenu_MoveRecords_YesNoCursor_Mark::
    ld b, $bc

; Writes tile B at the yes/no cursor's place, stepping back on a scroll wrap, waiting for VRAM
; access. (C1, E-0357)
SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile::
    ld a, [wChoiceCursor]
    add a
    ld hl, SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile_Data
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
SwapMonstersMenu_MoveRecords_YesNoCursor_DrawTile_Data::
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

; Moving records, step 16: looks for a farm monster (state 1, not an egg) among the records within
; the farm level's capacity: with one answers 1 and goes on; without returns to the options with
; answer 0. (C1, E-0357)
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

; Moving records, step 17: loads a box tile, plays sound $6C and draws the yes/no box with the
; option marked. (C1, E-0357)
SwapMonstersMenu_MoveRecords_DrawYesNo::
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles1 + $5f0
    ld b, $1f
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

; Copies C rows of six bytes from DE to HL, both with 20-byte rows. (C1, E-0357)
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

; far-calls ListRecordsState1NotEggs and continues with
; SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5 (E-0122)
ListRecordsState1ThenContinue::
    farcall ListRecordsState1NotEggs
    jr SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5

; Choosing to view, step 6: lists the farm monsters that are not eggs, then the page (below). (C1,
; E-0357)
SwapMonstersMenu_Check_ListMonsters::
    farcall ListRecordsInUseNotEggs

; Clamps the list's page cursor; with two or more pages draws the arrows and 'page/pages' on the
; screen and in the window buffer. (C1, E-0357)
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

; Moving records, step 32: copies the list glyph tiles (GlyphCopySrcList2). (C1, E-0357)
SwapMonstersMenu_MoveRecords_CopyListGlyphs::
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Moving records, step 33: redraws the record list name tiles and lists the party. (C1, E-0357)
SwapMonstersMenu_MoveRecords_RedrawPartyList::
    farcall DrawRecordListNameTiles_Bank1D
    farcall ListPartyRecordsWithState2ToListEntries
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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

; Moving records, step 40: writes '<first party member> with <chosen farm monster>' into wTextBuf0
; for the swap message. (C1, E-0357)
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
; script. (C1, E-0370)
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

; screen state 5, reached from menu option 1 when the farm list (ListRecordsState1NotEggs: records
; in use that are not eggs) is not empty: the MoveRecords list steps on that list (E-0302)
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

; Choosing from the farm, step 21: puts the player's name in wTextBuf0 and resets the text window.
; (C1, E-0357)
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

; Choosing from the farm, step 59: copies the list glyph tiles. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_CopyListGlyphs::
    ld hl, GlyphCopyDestList2
    ld de, GlyphCopySrcList2
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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

; Choosing from the farm, step 47: redraws the box and menu and marks the cursor entry. (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_RedrawMenu::
    call DrawBoxAndMenuAndStep_1E
    ld a, [wListCursor]
    ld b, $bc
    ld hl, SwapMenuCursorCells
    call StoreBAtWordTableEntry_Bank1E
    ret

; Choosing from the farm, step 61: the party box, names and marks in three sub-steps (as moving
; records' step 0). (C1, E-0357)
SwapMonstersMenu_ChooseFromFarm_DrawParty::
    ld a, [wScreenSubStep]
    and a
    jp z, SwapMonstersMenu_MoveRecords_DrawPartyBox
    cp $01
    jp z, CopyPartyNamesToTiles
    jp SwapMonstersMenu_MoveRecords_ListAndNumberParty

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

; Choosing from the farm, step 71: writes '<chosen party member> with <farm monster>' into wTextBuf0
; (the swap message's names). (C1, E-0357)
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

; Checking, step 2: the Monsters / Eggs cursor (in bank $1D); B answers 3 and goes on; A chooses
; (below). (C1, E-0357)
SwapMonstersMenu_Check_ChoiceCursor::
    farcall SwapMonstersMenu_BlinkCursorBlinkB8_Bank1D
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

; B on the Monsters / Eggs cursor (checking, and releasing by a jump from
; SwapMonstersMenu_Release_ChoiceCursor): answers 3 in wTwoChoiceCursor, clears wMenuChoice and
; wListCursorBlink, advances wScreenStep (in checking to step 3,
; SwapMonstersMenu_Check_BackToOptions) and starts the script. (C1, E-0370)
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

; A on the checking menu's Monsters / Eggs cursor: Eggs (wMenuChoice non-zero) goes to
; SwapMonstersMenu_Check_ChoiceCursor_PickEggs; Monsters blanks the two choice marks
; (BlankTwoTableEntriesSwapMenuCursorCellsFrom5), marks the choice with $BC, goes on two steps with
; wTwoChoiceCursor 0, resets the text window and starts the script. (C1, E-0370)
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

; Eggs chosen: with no eggs answers 2; otherwise marks the choice, answers 1 and goes to step $15
; (or $22 in the release menu, state 7). (C1, E-0357)
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

; Checking, step 13: saves a screen area and draws the count box with the monster count. (C1,
; E-0357)
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

; Checking, step 20: opens the monster's stats screen (screen state $0A, returning to state 6 step
; $0C), saving the sprites. (C1, E-0357)
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

; Checking, step 21 (and the same entry in the releasing table): far-calls LoadTileListSixPerFrame,
; which copies the tiles at the VRAM addresses in LoadTileListSixPerFrame_Data to $9E00 + 16 * n,
; six per frame, and advances wScreenStep at the end of the list (CopyListedTilesSixPerFrame);
; SwapMonstersMenu_Check_ReloadTiles and SwapMonstersMenu_Release_ReloadTiles copy them back with
; LoadTileListSixPerCall. (C1, E-0370)
SwapMonstersMenu_Check_SaveTiles::
    farcall LoadTileListSixPerFrame
    ret

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

; Checking, step 25: draws the page's egg species names. (C1, E-0357)
SwapMonstersMenu_Check_DrawEggNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Checking, step 26: loads a mark tile and draws the page's egg marks. (C1, E-0357)
SwapMonstersMenu_Check_DrawEggMarks::
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

; Checking, step 30: reloads tiles six per call (list $9E); when done unmarks the choice and returns
; to the Monsters / Eggs cursor (step 2). (C1, E-0357)
SwapMonstersMenu_Check_ReloadTiles::
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
    farcall SwapMonstersMenu_BlinkCursorBlinkB8_Bank1D
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

; Releasing, step 23: draws the count box with both counts. (C1, E-0357)
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

; Releasing, step 25: copies the chosen monster's name into wTextBuf0 for the script. (C1, E-0357)
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

; Releasing, step 47: draws the count box with both counts. (C1, E-0357)
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

; Releasing, step 50: advances to step 51 (SwapMonstersMenu_Release_DeleteEgg) and starts the script
; (wScriptCommandType 0, wScriptStartRequest = $80). (C1, E-0370)
SwapMonstersMenu_Release_ScriptThenDeleteEgg::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Releasing, step 51: deletes the chosen egg's record, relists the party and restores the box. (C1,
; E-0357)
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

; Shared by SwapMonstersMenu_Release_DeleteMonster and SwapMonstersMenu_Release_DeleteEgg: copies
; the 8 x 1 border row SwapMonstersMenu_Release_RestoreBox_TileRect ($B4 x 7, $B5) to
; wWindowTileBuffer + $110, copies a 13 x 5 block back inside the screen buffer with attributes
; (CopyScreenBufferRectWithAttrs_1E: C = 5, HL = $0287, DE = $00BB, wArg1 = 0, wArg2 = $0D), writes
; the blank tile $C3 at SwapMenuCursorCells entry wListCursor and advances wScreenStep. (C1, E-0370)
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

; Releasing, step 55: reloads six frame tiles. (C1, E-0357)
SwapMonstersMenu_Release_ReloadFrameTiles::
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

; Releasing, step 58: counts the records and returns to the option cursor (state 2) with answer 1.
; (C1, E-0357)
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

; by wScreenStep: draws the selected record's name, species, personality, level and status, category
; string and parent names (E-0288)
SwapMonstersMenu_ShowMonsterDetails::
    ld a, [wScreenStep]
    jumptable
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails_DrawScreenFrame
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadAreaGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_ShowPersonality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFramesAndGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRowAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList3

; Stats screen, step 3: draws the screen frame and, with two or more pages, the arrows and
; 'page/pages'. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawScreenFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawScreenFrame_TileRect
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
    ld de, LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect_2
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

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList: relists the farm monsters
; that are not eggs and redraws the page arrows (ListRecordsState1ThenContinue, which also advances
; wScreenStep), then sets wScreenStep to 4 and clears wScreenSubStep. (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails_RelistFarm::
    call ListRecordsState1ThenContinue
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

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

; draws the species sprite, clears the panel, redraws the list and continues (E-0303)
SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_CheckGameMode
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails_WriteScreenSubStep

; Stats screen (sprite and redraw), sub-step 0: draws the monster's species sprite (not in game mode
; 5); the cursor: a page change or move redraws, B on two steps, A draws the stats pages' frame and
; goes to step 4. (C1, E-0357)
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_2
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

; Stats screen, sub-step 3: relists the farm monsters. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_WriteScreenSubStep::
    call ListRecordsState1ThenContinue
    xor a
    ld [wScreenSubStep], a
    ret

; as SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList (E-0303)
SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2::
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
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_Cursor2_TileRect_2
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_Cursor2_TileRect
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

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails_CursorThenRedrawList2 (screen step 27 of
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

; Stats screen, step 23: draws the two frames of a stats page. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames_TileRect
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames_2
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

; Stats screen, step 24: blanks the text tiles and draws the next page's two frames. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawNextPage::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesBxC
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawNextPage_TileRect
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawNextPage_TileRect_2
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
    jr z, SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile
    cp $fe
    jr z, SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile2
    cp $ff
    jr z, SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile3

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

; Goes back two steps, blanking the text tiles and resetting the text window. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile::
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

; Goes to step $17. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile2::
    xor a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

; Goes to step 7. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile3::
    xor a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; Stats screen, sub-step 3: relists the farm monsters and goes back one step (and two more with the
; text reset). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_RelistBack1::
    call ListRecordsState1ThenContinue
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    jp SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile

; screen state $0E: as SwapMonstersMenu_ShowMonsterDetails2 (E-0302)
SwapMonstersMenu_ShowMonsterDetails3::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphTiles
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawFrame
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawPartyNames
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_ListRecords
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_ShowPersonality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFramesAndGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRowAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3

; Stats screen (the party version), step 3: draws the screen frame. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_DrawFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowMonsterDetails3_DrawFrame_TileRect
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
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphTiles
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails_DrawScreenFrame
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawPartyNames
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep
    dw SwapMonstersMenu_ShowMonsterDetails3_ListRecords
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_ShowPersonality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFramesAndGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRowAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3

; Stats screen (the party version), step 1: copies the glyph tiles, draws the frames, clears the
; tiles and redraws the list, then step 2. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_CopyGlyphTiles::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_CopyGlyphTiles
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

; Stats screen (the party version), step 7: clears the BG map and draws the party's names. (C1,
; E-0357)
SwapMonstersMenu_ShowMonsterDetails3_DrawPartyNames::
    call ClearBGMapAtScrollAndResetScroll
    call CopyPartyNamesToTiles
    xor a
    ld [wScreenSubStep], a
    ret

; Stats screen (the party version), step 8: moves on. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; screen state $0A: the details of a farm record (ListRecordsInUseNotEggs) (E-0302)
SwapMonstersMenu_ShowFarmMonsterDetails::
    ld a, [wScreenStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails3_Clear
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowMonsterDetails_DrawScreenFrame
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadAreaGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw SwapMonstersMenu_ShowFarmMonsterDetails_ListFarm
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_ShowPersonality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList2
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFramesAndGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRowAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList3

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

; moves the paged cursor, clears the panel and redraws the list (E-0303)
SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList::
    ld a, [wScreenSubStep]
    jumptable
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor1
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_RedrawPage

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails3_CursorThenRedrawList: clamps the page cursor
; and draws the page arrows (SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5),
; writes tile $B6 (the boxes' left-edge tile) over the five rows of the party-mark column
; (SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap), then sets wScreenStep to
; 4 and clears wScreenSubStep; step 4 (SwapMonstersMenu_ShowMonsterDetails3_DrawDetails) marks the
; party members again. (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails3_RedrawPage::
    call SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5
    call SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

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

; Party stats screen, step 0: clears the BG map, resets the scroll and loads a frame tile. (C1,
; E-0357)
SwapMonstersMenu_ShowMonsterDetails3_Clear::
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
    dw SwapMonstersMenu_ShowMonsterDetails3_MarkListPage

; Sub-step 3 of SwapMonstersMenu_ShowMonsterDetails3_SpriteThenRedrawList (screen step 21 of
; SwapMonstersMenu_ShowFarmMonsterDetails, SwapMonstersMenu_ShowMonsterDetails2 and
; SwapMonstersMenu_ShowMonsterDetails3), reached after a page change has cleared the tiles and
; redrawn the list (RedrawRecordListAndNextStep, wScreenStep -= 1): clamps the page cursor and draws
; the page arrows and 'page/pages' (SwapMonstersMenu_ShowMonsterDetails3_ClampRecordListPageCursor5,
; wScreenStep += 1), draws the party column's divider
; (SwapMonstersMenu_ShowMonsterDetails3_StepBGMapAddressBackOnScrollWrap) and the party marks
; through MarkPartyMembersInRecordListPage, once with wArg1 = 1 (screen) and once with wArg1 = 0
; (window buffer). Then clears wScreenSubStep, so the screen stays on step 21 and goes back to its
; cursor (sub-step 0). (C1, E-0370)
SwapMonstersMenu_ShowMonsterDetails3_MarkListPage::
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
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor2
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_MarkBack4

; Party stats screen, sub-step 3 (second version): clamps the page cursor, draws the marks and goes
; back four steps. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_MarkBack4::
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
    dw SwapMonstersMenu_ShowMonsterDetails_Cursor3
    dw ClearTileAreasAndIncScreenSubStep
    dw RedrawRecordListAndNextStep
    dw SwapMonstersMenu_ShowMonsterDetails3_MarkBack1

; Party stats screen, sub-step 3 (third version): clamps the page cursor, draws the marks, goes back
; one step and resets the text tiles. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails3_MarkBack1::
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
    jp SwapMonstersMenu_ShowMonsterDetails_ClearSpriteHideTile

; screen state $0D: as ShowParents (E-0302)
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
    dw SwapMonstersMenu_ShowMonsterDetails3_DrawPartyNames
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadAreaGraphics
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

; screen state $0B: DrawRecordParentNames with a cursor, then the record list page (E-0302)
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
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadAreaGraphics
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

; Pedigree screen, step 4: draws the screen frame and loads the party's species sprites
; (LoadPartySpeciesSpriteGraphics). (C1, E-0357)
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
    farcall LoadPartySpeciesSpriteGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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

; Pedigree screen, step 12: copies the list glyph tiles. (C1, E-0357)
SwapMonstersMenu_ShowParents2_CopyListGlyphs::
    ld hl, GlyphCopyDestList5
    ld de, GlyphCopySrcList5
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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
    dw SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_MoveOn
    dw SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame
    dw DrawListEntriesCell5RecordDetails
    dw SwapMonstersMenu_ShowMonsterDetails_LoadPicture
    dw SwapMonstersMenu_ShowPartyMemberDetails_PartyCursor
    dw ClearBGMapAtScrollAndResetScroll
    dw SwapMonstersMenu_ShowMonsterDetails_ReloadAreaGraphics
    dw SwapMonstersMenu_ShowMonsterDetails_MarkEntry
    dw ListRecordsAndDrawListEntriesCell5Panel
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowPartyMemberDetails_Leave
    dw SwapMonstersMenu_ShowMonsterDetails_BlankText
    dw SwapMonstersMenu_ShowMonsterDetails_BlankNameTiles
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame
    dw SwapMonstersMenu_ShowMonsterDetails_ShowPersonality
    dw SwapMonstersMenu_ShowMonsterDetails_DrawExperience
    dw SwapMonstersMenu_ShowMonsterDetails_LoadSprite
    dw SwapMonstersMenu_ShowPartyMemberDetails_SpriteCursor
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRow
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPageFrames
    dw SwapMonstersMenu_ShowMonsterDetails_DrawNextPage
    dw SwapMonstersMenu_ShowMonsterDetails_ListSkills
    dw SwapMonstersMenu_ShowMonsterDetails_ShowCategory
    dw SwapMonstersMenu_ShowPartyMemberDetails_Cursor
    dw SwapMonstersMenu_ShowMonsterDetails_DrawFramesAndGlyphs
    dw SwapMonstersMenu_ShowMonsterDetails_DrawLevelRowAndName
    dw SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame
    dw SwapMonstersMenu_ShowMonsterDetails_DrawParents
    dw SwapMonstersMenu_ShowPartyMemberDetails_PedigreeCursor

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

; Stats screen, step 1: copies the glyph tiles (GlyphCopySrcList4). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_CopyGlyphs::
    ld hl, GlyphCopyDestList4
    ld de, GlyphCopySrcList4
    call SwapMonstersMenu_CopyGlyphTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Stats screen, step 2: moves on. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_MoveOn::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Party member stats, step 3: draws the screen frame and the party marks in the list. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, SwapMonstersMenu_ShowPartyMemberDetails_DrawFrame_TileRect
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
    ld de, LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect_2
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_LoadPicture_TileRect
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

; Party member stats, step 6: the party cursor: a move goes to step 4, B on one, A draws a 6 x 6 box
; and goes to step $0E. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_PartyCursor::
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
    ld de, LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect_2
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

; Stats screen, step 8: reloads the area graphics (LoadAreaGraphicsForAreaGraphicsIndex) and the
; background palettes. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ReloadAreaGraphics::
    farcall LoadAreaGraphicsForAreaGraphicsIndex
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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

; Stats screen, step 12: draws the record's name and species name. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawNameAndSpecies::
    call GetListEntriesCell5Address
    ld a, [hl]
    ld b, a
    ld [wArg1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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

; Stats screen, step 14: blanks the text tiles at VRAM $9200. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_BlankText::
    ld hl, vTiles2 + $200
    ld bc, $0f02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Stats screen, step 17: draws the 12 x 15 page frame. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0068
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawPageFrame_TileRect
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

; Stats screen, step 18: shows the monster's personality name and its master's name. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_ShowPersonality::
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
; category-$11 string (ShowCategory11StringOfListEntriesCell5Record) and draws the 8 x 7 frame; goes
; on three steps. (C1, E-0357)
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
    farcall ShowCategory11StringOfListEntriesCell5Record
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_LoadSprite_TileRect
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

; Party member stats, step 21: draws the species metasprite at (64, 144) and runs the cursor: a move
; goes on one step, A on two, B draws the page frames and goes to step 4. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_SpriteCursor::
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_SpriteThenRedrawList_2
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
    farcall ShowSpeciesCategory13StringOfListEntriesCell5Record
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

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
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall UploadTilesFromData
    call BGMapAddressAtScroll_Bank1E
    ld de, $0160
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_Cursor2_TileRect_2
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_Cursor2_TileRect
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

; Stats screen, step 28: in two sub-steps draws the page frames, then copies the yes/no glyphs. (C1,
; E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawFramesAndGlyphs::
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_swap_monsters_menu_copy_glyph_tiles
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_TileRect
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
    ld de, SwapMonstersMenu_ShowMonsterDetails_LoadSprite_TileRect
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

; Stats screen, step 29: draws the level and status row and the name and species, loads a tile and
; goes to step $11. (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawLevelRowAndName::
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

; Stats screen, step 30: draws the pedigree frame and loads the party's species sprites, then falls
; into the parents (below). (C1, E-0357)
SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame::
    call BGMapAddressAtScroll_Bank1E
    ld de, $0008
    add hl, de
    ld de, SwapMonstersMenu_ShowMonsterDetails_DrawPedigreeFrame_TileRect
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

; Party member stats, step 32: the cursor; with no input draws the party's species sprites; a move
; goes back two steps (text reset), A to step $17, B to step 7. (C1, E-0357)
SwapMonstersMenu_ShowPartyMemberDetails_PedigreeCursor::
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
    ld de, LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect_2
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

; E = SRAM record (the list entry LinkRecordScreen_DrawParents reads through
; GetListEntriesCell4Address_BankF0): sets B = E and draws its parents' names
; (DrawRecordParentNames) and family entries (DrawRecordFamilyEntries). (C1, E-0370)
LinkRecordScreen_DrawParents_DrawNamesAndFamily::
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

; far-calls LoadRecordWordFieldArg5AndShowIcon for record B and continues at DrawRecordPlusValue
; (E-0126) (E-0344: the address in its name dropped or read as the label there; was
; LoadRecordWordFieldAndContinue)
LoadRecordWordFieldAndContinue::
    push bc
    ld c, b
    farcall LoadRecordWordFieldArg5AndShowIcon
    pop bc
    jp DrawRecordPlusValue

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

; data read by DrawListEntriesCell5RecordDetails (5 bytes) (E-0347)
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
    ld hl, DrawListEntriesCell5RecordDetails_DrawHPAndMP_Data1
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
    ld hl, DrawListEntriesCell5RecordDetails_DrawHPAndMP_Data2
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

; data read by DrawListEntriesCell5RecordDetails_DrawHPAndMP (4 bytes) (E-0347)
DrawListEntriesCell5RecordDetails_DrawHPAndMP_Data1::
    db $5b, $5d, $5f, $61

DrawListEntriesCell5RecordDetails_DrawHPAndMP_Data2::
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
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0353)
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
; 18 bytes appear in 7 banks) (E-0353)
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
; (E-0353)
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

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0353)
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
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
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
; banks) (E-0353)
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
    jr ListEntriesCellAddressToHL

; far-calls SetArg5ToListEntriesCell4, then HL = wArg5 (high) / wArg6 (low) (E-0075)
GetListEntriesCell4Address::
    farcall SetArg5ToListEntriesCell4

; Shared tail of GetListEntriesCell5Address and GetListEntriesCell4Address: returns HL = the list
; entry address left in wArg5 (high) and wArg6 (low) by SetArg5ToListEntriesCell5 or
; SetArg5ToListEntriesCell4. (C1, E-0370)
ListEntriesCellAddressToHL::
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; Draws the party column's divider tile $B6 on five rows of the screen and the window buffer. (C1,
; E-0357)
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
    dw $41c0, $42d0, $4330, $4340, $42a0, $40e0, $4270, $42f0 ; entry 0
    dw $4390, $40d0, $42c0, $4360, $4300, $4250, $40f0, $43c0
    dw $4380, $4180, $41a0, $4120, $4170, $41a0, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4a40
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
    dw $4340, $42a0, $40e0, $4270, $42f0, $4390, $40d0, $42c0 ; entry 0
    dw $4360, $ffff

; passed in HL, with GlyphCopySrcList2 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
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

; passed in HL, with GlyphCopySrcList3 in DE, to SwapMonstersMenu_CopyGlyphTiles, which copies 16
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
