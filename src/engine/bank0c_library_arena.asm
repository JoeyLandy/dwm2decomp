; ROM bank $0C: the monster library and the arena; script helpers
; The annotated listing of this bank is build/listing/bank0c.asm.

SECTION "Bank 0C", ROMX[$4000], BANK[$0C]
    db $0c

; implements script command type F6 (SCRIPT_LIBRARY): the monster library: 'Welcome to the library.
; Which family will you check?' (mode 9, bank $0B strings); reached through ScriptCommandF6 in bank
; $10 (E-0038, E-0244) (C2 from E-0329: started by its script it shows one count per family on two
; pages)
LibraryMenu::
    ld a, [wScreenState]
    jumptable
    dw LibraryMenu_WriteMessageModeAndScreenStateEtc
    dw LibraryMenu_WriteScrollYAndScrollXEtc
    dw LibraryMenu_ToClearStringWindowAt2020AndStep
    dw LibraryMenu_DrawFamilyChooser
    dw LibraryMenu_CountSeenMonsters
    dw LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc
    dw LibraryMenu_LeaveReloadMap
    dw LibraryMenu_LeaveRestoreScreen
    dw LibraryMenu_LeaveReloadNames
    dw LibraryMenu_ToClearStringWindowAt2200AndStep
    dw LibraryMenu_DrawMonsterList
    dw LibraryMenu_WriteScreenState
    dw LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_2
    dw LibraryMenu_BackToFamilies
    dw LibraryMenu_EraseFamilyMark
    dw LibraryMenu_ClearForEntry
    dw LibraryMenu_ShowMonsterEntry

; Library, state 0: clears the library's state bytes, sets message mode 9 and lets the script show
; the welcome ('Which family will you check?'). (C1, E-0357)
LibraryMenu_WriteMessageModeAndScreenStateEtc::
    ld hl, wScreenState
    ld bc, $0020

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $09
    ld [wMessageMode], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Library, state 1: clears the screen area, resets the scroll, saves the sprite clipping and hide
; tile (in wLibraryScrollY/X) and hides the field sprites, clears vTiles0 and blanks the window
; buffer. (C1, E-0357)
LibraryMenu_WriteScrollYAndScrollXEtc::
    call LibraryMenu_FillTileRectWithArg1Tile
    xor a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hSpriteWindowClipMode]
    ld [wLibraryScrollY], a
    ldh a, [hSpriteHideTile]
    ld [wLibraryScrollX], a
    ld a, $90
    ldh [hSpriteHideTile], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a
    ld a, $0f
    ldh [hFieldDrawFlags], a
    ld hl, vTiles0
    ld bc, $0800

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    call LibraryMenu_WriteSVBK
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 2: clears the string window tiles at vTiles2 + $20. (C1, E-0357)
LibraryMenu_ToClearStringWindowAt2020AndStep::
    call ClearStringWindowAt2020
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 3: draws the family chooser: the family panel (two rows of family icons, the second
; row with one fewer), the cursor on the current family, and the message window. (C1, E-0357)
LibraryMenu_DrawFamilyChooser::
    ld de, LibraryMenu_DrawFamilyChooser_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $09, $0d
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGridCursorY]
    and a
    jr z, .read_grid_cursor_x
    ld a, $c3
    ld [wWindowTileBuffer + $145], a

.read_grid_cursor_x:
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_DrawFamilyChooser_Data
    ld b, $bb
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_DrawFamilyChooser_Data
    ld b, $c3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call LibraryMenu_WriteWorkBuf
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 4: writes the page number (wGridCursorY) and, for each family on the shown row,
; counts how many of its monsters have been seen, for the counts shown beside the icons. (C1,
; E-0357)
LibraryMenu_CountSeenMonsters::
    call BGMapAddressAtScroll_Bank0C
    ld de, $0182
    add hl, de
    ld a, [wGridCursorY]
    add $e1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hli], a
    ei
    ld c, $00

.loop:
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld b, a
    ld a, c
    add b
    add a
    ld hl, LibraryMenu_CountSeenMonsters_Data1
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $00

.loop2:
    ld a, d
    cp $ff
    jp z, .clear_arg1
    push de
    push bc
    ld a, e
    ld [wArg1], a
    ld a, d
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
    cp $ff
    jr nz, .restore2

.restore:
    pop bc
    inc b
    push bc
    jr .restore3

.restore2:
    pop bc
    pop de
    push de
    push bc
    ld a, e
    ld [wSpeciesIdLo], a
    ld a, d
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a
    jr z, .restore3
    jr .restore

.restore3:
    pop bc
    pop de
    inc de
    ld a, [wGridCursorY]
    add a
    ld l, a
    add a
    add l
    ld l, a
    ld a, c
    add l
    add a
    ld hl, LibraryMenu_CountSeenMonsters_Data2
    add_a_to_hl
    push de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld a, d
    cp h
    jr c, .loop2
    jr nz, .read_grid_cursor_y
    ld a, e
    cp l
    jr c, .loop2

.read_grid_cursor_y:
    push bc
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    pop bc
    ld a, c
    add_a_to_hl
    ld a, b
    ld [hl], a
    ld a, [wGridCursorY]
    and a
    jr z, .skip
    ld b, $05
    jr .next

.skip:
    ld b, $06

.next:
    inc c
    ld a, c
    cp b
    jp c, .loop

.clear_arg1:
    xor a
    ld [wArg1], a
    call LibraryMenu_HLToDecimalDigits
    ld a, $01
    ld [wArg1], a
    call LibraryMenu_HLToDecimalDigits
    ld a, [wScreenState]
    inc a
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
    ret

; Library, state 5: the family cursor. Right/Left switch between the two rows, Up/Down move along
; the row; A opens the family; B leaves the library. The cursor blinks while waiting. (C1, E-0357)
LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc::
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .check_grid_cursor_y
    bit 5, a
    jr nz, .check_grid_cursor_y2
    bit 6, a
    jr nz, .call_library_menu_read_grid_cursor_x_2
    bit 7, a
    jr nz, .call_library_menu_read_grid_cursor_x_22
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .read_grid_cursor_y
    bit 1, a
    jp nz, .check_screen_state
    call LibraryMenu_WriteGlyphListStart
    ret

.check_grid_cursor_y:
    ld a, [wGridCursorY]
    cp $01
    jr c, .set_grid_cursor_y
    xor a
    jr .set_grid_cursor_y2

.set_grid_cursor_y:
    inc a

.set_grid_cursor_y2:
    ld [wGridCursorY], a
    cp $01
    jr c, .call_library_menu_read_grid_cursor_x
    ld a, [wGridCursorX]
    cp $05
    jr c, .call_library_menu_read_grid_cursor_x
    dec a
    ld [wGridCursorX], a

.call_library_menu_read_grid_cursor_x:
    call LibraryMenu_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    sub $03
    ld [wScreenState], a
    ret

.check_grid_cursor_y2:
    ld a, [wGridCursorY]
    and a
    jr nz, .skip
    ld a, $01
    jr .set_grid_cursor_y2

.skip:
    dec a
    jr .set_grid_cursor_y2

.call_library_menu_read_grid_cursor_x_2:
    call LibraryMenu_ReadGridCursorX_2
    ld a, [wGridCursorY]
    ld de, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Data
    add e
    ld e, a
    jr nc, .check_grid_cursor_x
    inc d

.check_grid_cursor_x:
    ld a, [de]
    ld b, a
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x
    ld a, b
    jr .set_grid_cursor_x2

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    call LibraryMenu_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_library_menu_read_grid_cursor_x_22:
    call LibraryMenu_ReadGridCursorX_2
    ld a, [wGridCursorY]
    ld de, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Data
    add e
    ld e, a
    jr nc, .check_grid_cursor_x2
    inc d

.check_grid_cursor_x2:
    ld a, [de]
    ld b, a
    ld a, [wGridCursorX]
    cp b
    jr c, .skip2
    xor a
    jr .set_grid_cursor_x2

.skip2:
    inc a
    jr .set_grid_cursor_x2

.read_grid_cursor_y:
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld b, a
    ld a, [wGridCursorX]
    add b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [hl]
    and a
    jr nz, .call_queue_sound_effect
    call LibraryMenu_BGMapAddressAtScroll_Bank0C
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call LibraryMenu_BGMapAddressAtScroll_Bank0C
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_DrawFamilyChooser_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wGridCursorY]
    add $e1
    ld [wWindowTileBuffer + $156], a
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

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    xor a
    ldh [hSpriteHideTile], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Blinks the library cursor: after the repeat timer, a 24-frame cycle shows the cursor for 16 frames
; and hides it for 8. (C1, E-0357)
LibraryMenu_WriteGlyphListStart::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, LibraryMenu_ReadGridCursorX
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    cp $10
    jr c, LibraryMenu_ReadGridCursorX
    cp $18
    jr c, LibraryMenu_ReadGridCursorX_2
    xor a
    ld [wGlyphListStart], a

; Draws the family cursor (tile $BB). (C1, E-0357)
LibraryMenu_ReadGridCursorX::
    ld b, $bb
    jr LibraryMenu_BGMapAddressAtScroll_Bank0C_ReadGridCursorX

; Hides the family cursor (tile $C3). (C1, E-0357)
LibraryMenu_ReadGridCursorX_2::
    ld b, $c3
    jr LibraryMenu_BGMapAddressAtScroll_Bank0C_ReadGridCursorX

; Marks the chosen family (tile $BC). (C1, E-0357)
LibraryMenu_BGMapAddressAtScroll_Bank0C::
    ld b, $bc

; Writes tile B at the family cursor position (from LibraryMenu_BGMapAddressAtScroll_Bank0C_Data by
; wGridCursorX). (C1, E-0357)
LibraryMenu_BGMapAddressAtScroll_Bank0C_ReadGridCursorX::
    ld a, [wGridCursorX]
    add a
    ld hl, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by LibraryMenu (12 bytes) (E-0347)
LibraryMenu_BGMapAddressAtScroll_Bank0C_Data::
    db $21, $00, $61, $00, $a1, $00, $e1, $00, $21, $01, $61, $01

; Library, state 6 (leaving): clears the screen area and reloads map $11's header, the player's
; sprites and the map objects. (C1, E-0357)
LibraryMenu_LeaveReloadMap::
    call LibraryMenu_FillTileRectWithArg1Tile
    ld a, $11
    ldh [hMapId], a
    call LoadMapHeader
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    farcall LoadMapObjectsForScreen
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 7 (leaving): restores the screen buffer and attributes to the BG map, the sprite
; clipping and hide tile, and the text window. (C1, E-0357)
LibraryMenu_LeaveRestoreScreen::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ld a, [wLibraryScrollY]
    ldh [hSpriteWindowClipMode], a
    ld a, [wLibraryScrollX]
    ldh [hSpriteHideTile], a
    xor a
    ldh [hFieldDrawFlags], a
    ld a, [wScreenState]
    inc a
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

; Library, state 8 (leaving): reloads the name and party tiles, clears the library's state and puts
; the player's name in the text buffer for the closing message. (C1, E-0357)
LibraryMenu_LeaveReloadNames::
    ld hl, $2940
    ld de, vTiles1 + $500
    call CopyTileBytesToVRAM_Bank0C
    call LibraryMenu_LeaveReloadNames_CopyTileBytesToVRAM_Bank0C
    call LibraryMenu_LeaveReloadNames_CopyTileBytesToVRAM_Bank0C
    call LibraryMenu_LeaveReloadNames_CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a
    ld [wMessageMode], a
    ld hl, wScreenState
    ld bc, $0020

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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Clears four tiles of the name area (the blank pattern at $2940). (C1, E-0357)
LibraryMenu_LeaveReloadNames_CopyTileBytesToVRAM_Bank0C::
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ret

; Library, state 9: clears the string window tiles at vTiles2 + $200. (C1, E-0357)
LibraryMenu_ToClearStringWindowAt2200AndStep::
    call ClearStringWindowAt2200
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 10: draws the monster list of the chosen family: its panel, the page count and the
; cursor, and the names of the monsters seen (LibraryMenu_GridIndexFromGridCursorXGridCursorY_2).
; (C1, E-0357)
LibraryMenu_DrawMonsterList::
    ld de, LibraryMenu_DrawMonsterList_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $0d
    call CopyRectTo20ByteRows_Bank0C
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .set_window_tile_buffer
    inc d

.set_window_tile_buffer:
    ld a, [de]
    add $e1
    ld [wWindowTileBuffer + $165], a
    ld a, [wGrid2CursorX]
    ld hl, LibraryMenu_DrawMonsterList_Data1
    ld b, $bb
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wGrid2CursorX]
    ld hl, LibraryMenu_DrawMonsterList_Data1
    ld b, $c3
    call StoreBAtWordTableEntry_Bank0C
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY_2
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 11: draws the list's page number and page count. (C1, E-0357)
LibraryMenu_WriteScreenState::
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Library, state 12: the monster cursor. Right/Left change page within the family, Up/Down move in
; the list; A opens the monster's entry; B returns to the family chooser. (C1, E-0357)
LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_2::
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .call_grid_index_from_grid_cursor_x_grid
    bit 5, a
    jr nz, .check_grid2_cursor_y2
    bit 6, a
    jp nz, .call_library_menu_read_grid2_cursor_x_2
    bit 7, a
    jp nz, .call_library_menu_read_grid2_cursor_x_22
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_grid_index_from_grid_cursor_x_grid2
    bit 1, a
    jp nz, .check_screen_state
    call LibraryMenu_WriteListEntries
    ret

.call_grid_index_from_grid_cursor_x_grid:
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .check_grid2_cursor_y
    inc d

.check_grid2_cursor_y:
    ld a, [de]
    ld b, a
    ld a, [wGrid2CursorY]
    cp b
    jr c, .set_grid2_cursor_y
    xor a
    jr .set_grid2_cursor_y2

.set_grid2_cursor_y:
    inc a

.set_grid2_cursor_y2:
    ld [wGrid2CursorY], a
    push af
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    pop af
    cp b
    jr c, .call_library_menu_read_grid2_cursor_x
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    cp b
    jr c, .call_library_menu_read_grid2_cursor_x
    ld a, b
    ld [wGrid2CursorX], a
    ld a, [wScreenState]
    sub $03
    ld [wScreenState], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_library_menu_read_grid2_cursor_x:
    call LibraryMenu_ReadGrid2CursorX
    ld a, [wScreenState]
    sub $03
    ld [wScreenState], a
    ld a, $69
    call QueueSoundEffect
    ret

.check_grid2_cursor_y2:
    ld a, [wGrid2CursorY]
    and a
    jr nz, .skip3
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    jr .set_grid2_cursor_y2

.skip3:
    dec a
    jr .set_grid2_cursor_y2

.call_library_menu_read_grid2_cursor_x_2:
    call LibraryMenu_ReadGrid2CursorX_2
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    and a
    jr nz, .set_grid2_cursor_x
    ld a, b
    jr .set_grid2_cursor_x2

.set_grid2_cursor_x:
    dec a

.set_grid2_cursor_x2:
    ld [wGrid2CursorX], a
    call LibraryMenu_ReadGrid2CursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_library_menu_read_grid2_cursor_x_22:
    call LibraryMenu_ReadGrid2CursorX_2
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    cp b
    jr c, .skip4
    xor a
    jr .set_grid2_cursor_x2

.skip4:
    inc a
    jr .set_grid2_cursor_x2

.call_grid_index_from_grid_cursor_x_grid2:
    call GridIndexFromGridCursorXGridCursorY
    add a
    ld de, LibraryMenu_CountSeenMonsters_Data1
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call GridIndexFromGrid2CursorXGrid2CursorY
    pop hl
    add_a_to_hl
    call LibraryMenu_TestBitInFieldAtArg3
    and a
    jr z, .call_library_menu_read_grid2_cursor_x2
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    add $03
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_library_menu_read_grid2_cursor_x2:
    call LibraryMenu_ReadGrid2CursorX
    ret

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Blinks the monster cursor: 16 frames shown, 8 hidden. (C1, E-0357)
LibraryMenu_WriteListEntries::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, LibraryMenu_ReadGrid2CursorX
    ld a, [wListEntries]
    inc a
    ld [wListEntries], a
    cp $10
    jr c, LibraryMenu_ReadGrid2CursorX
    cp $18
    jr c, LibraryMenu_ReadGrid2CursorX_2
    xor a
    ld [wListEntries], a

; Draws the monster cursor (tile $BB). (C1, E-0357)
LibraryMenu_ReadGrid2CursorX::
    ld b, $bb
    jr LibraryMenu_ReadGrid2CursorX_2_ReadGrid2CursorX

; Hides the monster cursor (tile $C3). (C1, E-0357)
LibraryMenu_ReadGrid2CursorX_2::
    ld b, $c3
    jr LibraryMenu_ReadGrid2CursorX_2_ReadGrid2CursorX
    db $06, $bc

; Writes tile B at the monster cursor position (from LibraryMenu_ReadGrid2CursorX_Data by
; wGrid2CursorX). (C1, E-0357)
LibraryMenu_ReadGrid2CursorX_2_ReadGrid2CursorX::
    ld a, [wGrid2CursorX]
    add a
    ld hl, LibraryMenu_ReadGrid2CursorX_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by LibraryMenu (12 bytes) (E-0347)
LibraryMenu_ReadGrid2CursorX_Data::
    db $29, $00, $69, $00, $a9, $00, $e9, $00, $29, $01, $69, $01

; Library, state 13 (back to the families): redraws the family panel with the seen counts and lets
; the script continue. (C1, E-0357)
LibraryMenu_BackToFamilies::
    ld de, LibraryMenu_BackToFamilies_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $0d
    call CopyRectTo20ByteRows_Bank0C
    ld a, $01
    ld [wArg1], a
    call LibraryMenu_HLToDecimalDigits
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
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

; Library, state 14: erases the chosen-family mark and returns to the family cursor (state 5). (C1,
; E-0357)
LibraryMenu_EraseFamilyMark::
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_DrawFamilyChooser_Data
    ld b, $c3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, $05
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Library, state 15: clears the screen area and the window buffer before showing an entry. (C1,
; E-0357)
LibraryMenu_ClearForEntry::
    call LibraryMenu_FillTileRectWithArg1Tile
    call LibraryMenu_WriteSVBK
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; LibraryMenu screen state $10, by wScreenStep: decompresses graphics, draws the three meta-sprite
; parts of a monster, sets the palette and the numbers (E-0288)
LibraryMenu_ShowMonsterEntry::
    ld a, [wScreenStep]
    jumptable
    dw LibraryMenu_ShowMonsterEntry_LoadTiles
    dw LibraryMenu_ShowMonsterEntry_LoadScreen
    dw LibraryMenu_ShowMonsterEntry_DrawPicture
    dw LibraryMenu_ShowMonsterEntry_LoadSprite
    dw LibraryMenu_ShowMonsterEntry_DrawEntry
    dw LibraryMenu_ShowMonsterEntry_DrawParents
    dw LibraryMenu_ShowMonsterEntry_ShowPedigree
    dw LibraryMenu_ShowMonsterEntry_ShowDescription2
    dw LibraryMenu_ShowMonsterEntry_BrowseFamily
    dw LibraryMenu_ShowMonsterEntry_Close
    dw LibraryMenu_ShowMonsterEntry_RedrawLists
    dw LibraryMenu_ShowMonsterEntry_RestorePalette
    dw LibraryMenu_ShowMonsterEntry_RedrawCounts
    dw LibraryMenu_ShowMonsterEntry_EraseListMark

; Library entry, step 0: clears the string tiles, loads the entry's frame tiles and four tiles from
; bank $1F. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_LoadTiles::
    call LibraryMenu_ShowMonsterEntry_FillTilesFromRequest
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
    call FillTilesFromRequest
    ld hl, LibraryMenu_ShowMonsterEntry_FillTilesFromRequest_Tiles
    ld de, vTiles2 + $610
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    ld de, Tiles2Plus250Tiles
    ld hl, vTiles2 + $7c0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles2 + $7d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus200Tiles
    ld hl, vTiles2 + $7e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus7F0Tiles
    ld hl, vTiles2 + $7f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; ScriptCommandF6 code loads HL = $4718 and DE = vTiles2 + $610 and calls CopyTileBytesToVRAM_Bank0C
; six times, 16 bytes each (E-0237, C1)
; record: tile (16 bytes, 2 bits per pixel)
LibraryMenu_ShowMonsterEntry_FillTilesFromRequest_Tiles::
    db $ff, $03, $ff, $03, $ff, $03, $ff, $ff, $ff, $ff, $ff, $03, $ff, $03, $ff, $03 ; id 0
    db $ff, $00, $ff, $00, $ff, $00, $ff, $03, $ff, $03, $ff, $03, $ff, $03, $ff, $03 ; id 1
    db $ff, $03, $ff, $03, $ff, $03, $ff, $03, $ff, $03, $ff, $00, $ff, $00, $ff, $00 ; id 2
    db $ff, $00, $ff, $00, $ff, $00, $ff, $ff, $ff, $ff, $ff, $00, $ff, $00, $ff, $00 ; id 3
    db $ff, $00, $ff, $00, $ff, $00, $ff, $ff, $ff, $ff, $ff, $60, $ff, $60, $ff, $60 ; id 4
    db $ff, $60, $ff, $60, $ff, $60, $ff, $ff, $ff, $ff, $ff, $00, $ff, $00, $ff, $00 ; id 5

; Library entry, step 1: decompresses the entry screen's tiles, map and attributes and the monster's
; icon kind
; (LibraryMenu_ShowMonsterEntry_LoadScreen_CallGridCellAddressFromGridCursorXAndGrid2CursorX), then
; draws them. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_LoadScreen::
    ld a, [wScreenSubStep]
    and a
    jr nz, .skip
    ld hl, vTiles1 + $220
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
    ld de, Tiles1Gfx_3
    ld hl, vTiles1
    ld b, $f1
    call DecompressToVRAM
    ld de, WindowTileBufferPlus64Gfx
    ld hl, wWindowTileBuffer + $64
    ld b, $f1
    call DecompressToVRAM
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_WindowTileBufferGfx
    ld hl, wWindowTileBuffer
    ld b, $f1
    call DecompressToVRAM
    ld a, [wIsCGB]
    and a
    jr z, .skip
    ld a, $02
    ldh [rSVBK], a
    ld de, WindowAttrBufferPlus64Gfx
    ld hl, wWindowAttrBuffer + $64
    ld b, $f1
    call DecompressToVRAM
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_WindowAttrBufferGfx
    ld hl, wWindowAttrBuffer
    ld b, $f1
    call DecompressToVRAM
    xor a
    ldh [rSVBK], a
    farcall LoadBGPalettesFromData
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

.skip:
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect
    ld hl, wWindowTileBuffer + $81
    lb bc, $0a, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_2
    ld hl, wWindowTileBuffer + $bd
    lb bc, $0a, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_3
    ld hl, wWindowTileBuffer + $e5
    lb bc, $0a, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_4
    ld hl, wWindowTileBuffer + $10d
    lb bc, $09, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_5
    ld hl, wWindowTileBuffer + $135
    lb bc, $09, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_6
    ld hl, wWindowTileBuffer + $15d
    lb bc, $09, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_7
    ld hl, wWindowTileBuffer + $15
    lb bc, $12, $01
    call CopyRectTo20ByteRows_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_8
    ld hl, wWindowTileBuffer + $3d
    lb bc, $12, $01
    call CopyRectTo20ByteRows_Bank0C
    call LibraryMenu_ShowMonsterEntry_LoadScreen_CallGridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, wLibraryEntryBlock
    ld hl, wWindowTileBuffer + $108
    lb bc, $02, $01
    call CopyRectTo20ByteRows_Bank0C
    call LibraryMenu_ShowMonsterEntry_LoadClassBlock
    ld de, wLibraryEntryBlock
    ld hl, wWindowTileBuffer + $130
    lb bc, $04, $01
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $130
    ld a, $02
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $02
    ld [hli], a
    xor a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 10 x 1 tiles, one row per line
LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect::
    db $2f, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e ; id 0

LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_2::
    db $42, $30, $31, $32, $33, $34, $35, $36, $37, $38 ; id 0

LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_3::
    db $43, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41 ; id 0

; record: 9 x 1 tiles, one row per line
LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_4::
    db $44, $45, $46, $47, $48, $49, $4a, $4b, $4c ; id 0

LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_5::
    db $4d, $4e, $4f, $50, $51, $52, $53, $54, $55 ; id 0

LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_6::
    db $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e ; id 0

; record: 18 x 1 tiles, one row per line
LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_7::
    db $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b0, $b1, $b2, $b3 ; id 0

LibraryMenu_ShowMonsterEntry_LoadScreen_TileRect_8::
    db $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf, $c0, $c1, $c2, $c3, $c4, $c5 ; id 0
    db $7e, $7f

; Library entry, step 2: draws the 6 x 6 picture frame and loads the monster's picture
; (LoadMonsterPicture) into it, then its CGB attributes. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_DrawPicture::
    ld a, [wScreenSubStep]
    and a
    jp nz, .call_grid_cell_address_from_grid_cursor_x_and
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect_2
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $00
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld e, l
    ld d, h
    push de
    ld hl, vTiles2 + $20
    ld c, $04
    call LoadMonsterPicture
    pop de
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_grid_cell_address_from_grid_cursor_x_and:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld e, l
    ld d, h
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $04
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, LibraryMenu_ShowMonsterEntry_DrawPicture_TileRect
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 3: decompresses the monster's sprite graphics (DecompressGraphicsArg1ToArg4).
; (C1, E-0357)
LibraryMenu_ShowMonsterEntry_LoadSprite::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 4: draws the monster's sprite and shows its name, its family's icon and name,
; and its description strings. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_DrawEntry::
    call DrawThreeMetaSpritePartsAtGridCursor
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, h
    add $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles2 + $260
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    call GridIndexFromGridCursorXGridCursorY
    and $0f
    ld [wWorkBuf], a
    ld a, $2f
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    call GridIndexFromGridCursorXGridCursorY
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $670
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall LoadSpeciesBytes8To10ToArg5
    farcall PermuteArg5To7ByMonster
    ld a, $04
    ld [wStringCategory], a
    ld hl, wArg5
    ld c, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    ld [wStringIndex], a
    ld a, c
    add a
    ld de, LibraryMenu_ShowMonsterEntry_DrawEntry_Data
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
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp $03
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; data read by LibraryMenu (6 bytes) (E-0347)
LibraryMenu_ShowMonsterEntry_DrawEntry_Data::
    db $40, $94, $d0, $94, $60, $95

; Library entry, step 5: for a monster not yet seen (LibraryMenu_TestBitInFieldAtArg3 = $FF) shows
; placeholder parents and skips the pedigree step. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_DrawParents::
    call DrawThreeMetaSpritePartsAtGridCursor
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call LibraryMenu_TestBitInFieldAtArg3
    cp $ff
    jr z, .check_screen_step
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles2 + $420
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles2 + $430
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    ld hl, vTiles2 + $390
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank0B
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 6: shows the monster's pedigree: the two parents from MonsterPedigreeTableA
; and MonsterPedigreeTableB, each a species (name and family icon) or a family. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_ShowPedigree::
    call DrawThreeMetaSpritePartsAtGridCursor
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableA
    add hl, de
    ld a, $42
    call LibraryMenu_ShowMonsterEntry_ShowPedigree_FamilyForSpeciesIdArg6
    pop hl
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableB
    add hl, de
    ld a, $43
    call LibraryMenu_ShowMonsterEntry_ShowPedigree_FamilyForSpeciesIdArg6
    pop hl
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableA
    add hl, de
    ld de, vTiles2 + $300
    call LibraryMenu_ShowMonsterEntry_ShowPedigree_ShowString_Bank08
    pop hl
    sla l
    rl h
    ld de, MonsterPedigreeTableB
    add hl, de
    ld de, vTiles2 + $390
    call LibraryMenu_ShowMonsterEntry_ShowPedigree_ShowString_Bank08
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 7: shows the monster's second description (string $10 entries on, bank $0B) in
; the text window. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_ShowDescription2::
    call DrawThreeMetaSpritePartsAtGridCursor
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, $10
    add_a_to_hl
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles1 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 8: Right/Left show the next or previous monster of the family (when the family
; has more than one page), A and B close the entry. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_BrowseFamily::
    call DrawThreeMetaSpritePartsAtGridCursor
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld b, a
    ld a, [wGridCursorX]
    add b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [hl]
    cp $01
    jr z, .check_joypad_pressed
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .loop
    bit 5, a
    jp nz, .loop3

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .check_screen_step
    ret

.loop:
    ld a, [wGrid2CursorX]
    cp $05
    jr c, .set_grid2_cursor_x
    xor a
    ld [wGrid2CursorX], a
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .check_grid2_cursor_y
    inc d

.check_grid2_cursor_y:
    ld a, [de]
    ld b, a
    ld a, [wGrid2CursorY]
    cp b
    jr c, .set_grid2_cursor_y

.loop2:
    xor a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    jr .call_grid_cell_address_from_grid_cursor_x_and

.set_grid2_cursor_y:
    inc a
    ld [wGrid2CursorY], a
    jr .call_grid_cell_address_from_grid_cursor_x_and

.set_grid2_cursor_x:
    inc a
    ld [wGrid2CursorX], a

.call_grid_cell_address_from_grid_cursor_x_and:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    call GridIndexFromGridCursorXGridCursorY
    add a
    ld hl, LibraryMenu_CountSeenMonsters_Data2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp d
    jr c, .call_grid_cell_address_from_grid_cursor_x_and2
    jr nz, .loop2
    ld a, l
    cp e
    jr c, .call_grid_cell_address_from_grid_cursor_x_and2
    jr .loop2

.call_grid_cell_address_from_grid_cursor_x_and2:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call LibraryMenu_TestBitInFieldAtArg3
    and a
    jr z, .loop
    ld a, $69
    call QueueSoundEffect
    call LibraryMenu_ShowMonsterEntry_FillTilesFromRequest
    ld hl, vTiles1 + $220
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
    ld a, $01
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

.loop3:
    ld a, [wGrid2CursorX]
    and a
    jr nz, .set_grid2_cursor_x2
    ld a, [wGrid2CursorY]
    and a
    jr nz, .set_grid2_cursor_y3

.loop4:
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .set_grid2_cursor_y2
    inc d

.set_grid2_cursor_y2:
    ld a, [de]
    ld [wGrid2CursorY], a
    call ReadGridCellByteForGridCursorXGridCursorY
    ld [wGrid2CursorX], a
    jr .call_grid_cell_address_from_grid_cursor_x_and3

.set_grid2_cursor_y3:
    dec a
    ld [wGrid2CursorY], a
    call ReadGridCellByteForGridCursorXGridCursorY
    ld [wGrid2CursorX], a
    jr .call_grid_cell_address_from_grid_cursor_x_and3

.set_grid2_cursor_x2:
    dec a
    ld [wGrid2CursorX], a

.call_grid_cell_address_from_grid_cursor_x_and3:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    call GridIndexFromGridCursorXGridCursorY
    add a
    ld hl, LibraryMenu_CountSeenMonsters_Data2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp d
    jr c, .call_grid_cell_address_from_grid_cursor_x_and4
    jr nz, .loop4
    ld a, l
    cp e
    jr c, .call_grid_cell_address_from_grid_cursor_x_and4
    jr nz, .loop4

.call_grid_cell_address_from_grid_cursor_x_and4:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call LibraryMenu_TestBitInFieldAtArg3
    and a
    jr z, .loop3
    ld a, $69
    call QueueSoundEffect
    call LibraryMenu_ShowMonsterEntry_FillTilesFromRequest
    ld hl, vTiles1 + $220
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
    ld a, $01
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 9 (closing): clears the screen area, restores the font tiles and blanks the
; window buffer. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_Close::
    call LibraryMenu_FillTileRectWithArg1Tile
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    call LibraryMenu_WriteSVBK
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 10: redraws the family panel and the monster list with their marks, and clears
; the string tiles. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_RedrawLists::
    ld de, LibraryMenu_DrawFamilyChooser_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $09, $0d
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGridCursorY]
    and a
    jr z, .read_grid_cursor_x
    ld a, $c3
    ld [wWindowTileBuffer + $145], a

.read_grid_cursor_x:
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_DrawFamilyChooser_Data
    ld b, $bc
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wGridCursorY]
    add $e1
    ld [wWindowTileBuffer + $156], a
    ld de, LibraryMenu_DrawMonsterList_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $0d
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGrid2CursorX]
    ld b, $bc
    ld hl, LibraryMenu_DrawMonsterList_Data1
    call StoreBAtWordTableEntry_Bank0C
    call ClearStringWindowAt2020
    call ClearStringWindowAt2200
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
    call FillTilesFromRequest
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 11: restores BG palette 0 and the family icons and list names. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_RestorePalette::
    call WriteBGPalette0FromData
    call LibraryMenu_WriteWorkBuf
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Library entry, step 12: redraws the family counts and the message window, and lets the script
; continue. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_RedrawCounts::
    ld a, $01
    ld [wArg1], a
    call LibraryMenu_HLToDecimalDigits
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld de, LibraryMenu_ShowMonsterEntry_RedrawCounts_TileRect
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY
    ld a, [wScreenStep]
    inc a
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

; Library entry, step 13: erases the list mark and returns to the monster cursor (library state
; $0C). (C1, E-0357)
LibraryMenu_ShowMonsterEntry_EraseListMark::
    ld a, [wGrid2CursorX]
    ld b, $c3
    ld hl, LibraryMenu_DrawMonsterList_Data1
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0c
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    xor a
    ld [wScreenStep], a
    ld a, $0c
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

; Shows one parent of a pedigree entry at DE: a species name (category = high byte + 2), or a family
; name when the entry is a family ($FE form), or nothing. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_ShowPedigree_ShowString_Bank08::
    push de
    inc hl
    ld a, [hld]
    cp $fe
    jr z, .skip
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hl]
    add $02
    ld [wStringCategory], a
    pop de
    ld a, e
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ret

.skip:
    ld a, [hl]
    cp $fe
    jr z, .clear_string_category
    and $0f
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    jr .set_text_window_tile_lo

.clear_string_category:
    xor a
    ld [wStringCategory], a
    ld [wStringIndex], a

.set_text_window_tile_lo:
    pop de
    ld a, e
    ld [wTextWindowTileLo], a
    ld a, d
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B
    ret

; Loads the family icon of one pedigree parent into tile A: the species' family
; (FamilyForSpeciesIdArg6) or the entry's family, or a blank tile. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_ShowPedigree_FamilyForSpeciesIdArg6::
    push af
    inc hl
    ld a, [hld]
    cp $fe
    jr z, .skip
    ld a, [hli]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    farcall FamilyForSpeciesIdArg6
    ld a, [wArg5]
    jr .set_work_buf

.skip:
    ld a, [hl]
    cp $fe
    jr z, .restore

.set_work_buf:
    and $0f
    ld [wWorkBuf], a
    pop af
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    ret

.restore:
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld de, vTiles2
    add hl, de
    ld de, Tiles2Plus420Tiles
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Draws the names of the seen monsters on the current page of the family list (6 per page): unseen
; ones stay blank, the others show their name. (C1, E-0357)
LibraryMenu_GridIndexFromGridCursorXGridCursorY_2::
    call GridIndexFromGridCursorXGridCursorY
    add a
    ld de, LibraryMenu_CountSeenMonsters_Data1
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
    ld a, [wGrid2CursorY]
    add a
    ld b, a
    add a
    add b
    add_a_to_hl
    ld c, $00

.loop:
    push hl
    push bc
    call LibraryMenu_TestBitInFieldAtArg3
    and a
    jr z, .restore
    pop bc
    pop hl
    push hl
    push bc
    ld a, h
    add $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld a, c
    add a
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data
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
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    jr .restore2

.restore:
    pop bc
    push bc
    xor a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld a, c
    add a
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data
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
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0B

.restore2:
    pop bc
    pop hl
    inc hl
    push hl
    inc c
    call ReadGridCellByteForGridCursorXGridCursorY
    inc a
    ld b, a
    pop hl
    ld a, c
    cp b
    jp c, .loop
    ret

; data read by LibraryMenu (12 bytes) (E-0347)
LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data::
    db $00, $92, $90, $92, $20, $93, $b0, $93, $40, $94, $d0, $94

; Loads the six family icons of the current family row into tiles 2-7. (C1, E-0357)
LibraryMenu_WriteWorkBuf::
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld de, LibraryMenu_WriteWorkBuf_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $00

.loop:
    ld a, [de]
    cp $ff
    jr z, .next
    push de
    push bc
    ld [wWorkBuf], a
    cp $06
    jr c, .set_work_buf
    sub $06

.set_work_buf:
    inc a
    inc a
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc
    pop de

.next:
    inc de
    inc c
    ld a, c
    cp $06
    jr c, .loop
    ret

; data read by LibraryMenu (24 bytes) (E-0347)
LibraryMenu_WriteWorkBuf_Data::
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $ff, $20, $90, $70, $90
    db $c0, $90, $10, $91, $60, $91, $b0, $91

; with the pointer from GridCellAddressFromGridCursorXAndGrid2CursorX draws sub-indices 0, 4 and 2
; (DrawThreeMetaSpritePartsAtGridCursor_WriteSpriteAttrXorAndSpriteTileOffsetEtc) at Y = $10, $24
; and $38, X = $6C (E-0121) (E-0344: the address in its name dropped or read as the label there; was
; DrawThreeMetaSpritePartsAtGridCursor; shortened from
; DrawThreeMetaSpritePartsForGridCellAddressFromGridCursorXAndGrid2CursorX)
DrawThreeMetaSpritePartsAtGridCursor::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld a, $10
    ld [wArg4], a
    ld a, $6c
    ld [wArg5], a
    xor a
    ld [wArg6], a
    ld c, $01
    xor a
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsAtGridCursor_WriteSpriteAttrXorAndSpriteTileOffsetEtc
    ld a, $24
    ld [wArg4], a
    ld a, $6c
    ld [wArg5], a
    xor a
    ld [wArg6], a
    ld c, $01
    ld a, $04
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsAtGridCursor_WriteSpriteAttrXorAndSpriteTileOffsetEtc
    ld a, $38
    ld [wArg4], a
    ld a, $6c
    ld [wArg5], a
    xor a
    ld [wArg6], a
    ld c, $01
    ld a, $02
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsAtGridCursor_WriteSpriteAttrXorAndSpriteTileOffsetEtc
    ret

; Draws the list page indicator: the current page and the family's page count as digit tiles. (C1,
; E-0357)
LibraryMenu_GridIndexFromGridCursorXGridCursorY::
    call BGMapAddressAtScroll_Bank0C
    ld de, $018f
    add hl, de
    push hl
    ld a, [wGrid2CursorY]
    add $e1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hli], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_DrawMonsterList_Data2
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add $e1
    ld b, a
    pop hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; HL = the word LibraryMenu_CountSeenMonsters_Data1[GridIndexFromGridCursorXGridCursorY] +
; GridIndexFromGrid2CursorXGrid2CursorY (E-0124)
GridCellAddressFromGridCursorXAndGrid2CursorX::
    call GridIndexFromGridCursorXGridCursorY
    add a
    ld de, LibraryMenu_CountSeenMonsters_Data1
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
    push hl
    call GridIndexFromGrid2CursorXGrid2CursorY
    pop hl
    add_a_to_hl
    ret

; A = the byte at
; ReadGridCellByteForGridCursorXGridCursorY_Data[GridIndexFromGridCursorXGridCursorY] +
; wGrid2CursorY (E-0122)
ReadGridCellByteForGridCursorXGridCursorY::
    call GridIndexFromGridCursorXGridCursorY
    add a
    ld hl, ReadGridCellByteForGridCursorXGridCursorY_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wGrid2CursorY]
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ret

; Draws the seen counts of the families on the current row (six on the first row, five on the
; second) as two digits beside each icon. (C1, E-0357)
LibraryMenu_HLToDecimalDigits::
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [wGridCursorY]
    and a
    jr nz, .skip
    ld b, $06
    jr .skip2

.skip:
    ld b, $05

.skip2:
    ld c, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank0_c
    add $e3
    ld [wDigits + $1], a

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    pop bc
    push bc
    ld a, c
    add a
    push hl
    push af
    ld a, [wArg1]
    and a
    jr z, .skip3
    ld hl, LibraryMenu_HLToDecimalDigits_Data2
    pop af
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld l, e
    ld h, d
    jr .call_wait_for_vram_access

.skip3:
    ld hl, LibraryMenu_HLToDecimalDigits_Data1
    pop af
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de

.call_wait_for_vram_access:
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
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; data read by LibraryMenu_HLToDecimalDigits (12 bytes) (E-0347)
LibraryMenu_HLToDecimalDigits_Data1::
    db $26, $00, $66, $00, $a6, $00, $e6, $00, $26, $01, $66, $01

LibraryMenu_HLToDecimalDigits_Data2::
    db $7e, $c3, $a6, $c3, $ce, $c3, $f6, $c3, $1e, $c4, $46, $c4

; Blanks the window buffer area (tiles $C3, attributes 0). (C1, E-0357)
LibraryMenu_WriteSVBK::
    ld hl, wWindowTileBuffer + $64
    ld bc, $0104

.loop:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, [wIsCGB]
    and a
    jr z, .return
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $64
    ld bc, $0104

.loop2:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld a, $00
    ldh [rSVBK], a

.return:
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; (E-0353)
CopyTileBytesToVRAM_Bank0C::
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank0C::
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

; Covers the 32 x 32 BG map with one fill tile (FillTileRectWithArg1Tile). (C1, E-0357)
LibraryMenu_FillTileRectWithArg1Tile::
    ld hl, LibraryMenu_FillTileRectWithArg1Tile_Tiles
    ld de, vTiles1 + $430
    call CopyTileBytesToVRAM_Bank0C
    call BGMapAddressAtScroll_Bank0C
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
    ret

; HL = $51AB and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
LibraryMenu_FillTileRectWithArg1Tile_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 0

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0353)
CopyRectTo20ByteRows_Bank0C::
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
; kept. wTextCursorLo/wTextCursorHi = HL + $1C1 (row 14, column 1 of the drawn area) when
; wStringIndex is $18 or $12, otherwise $99C1 (E-0062)
DrawScreenBufferRect_Bank0C::
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
    ld a, [wStringIndex]
    cp $18
    jr z, .restore
    cp $12
    jr z, .restore
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

; Arena: writes the blank tile $C3 at the first C entries of the address table at HL. (C1, E-0357)
ArenaMenu_CancelClass_StoreBAtWordTableEntry_Bank0C::
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $c3
    push hl
    call StoreBAtWordTableEntry_Bank0C
    pop hl
    pop bc
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0353)
StoreBAtWordTableEntry_Bank0C::
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

; sets the string window to tile destination vTiles2 + $20 and size word $1702, then
; FillTilesFromRequest (clears it) (E-0117)
ClearStringWindowAt2020::
    ld hl, vTiles2 + $20
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1702
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; sets the string window to tile destination vTiles2 + $200 and size word $5301, then
; FillTilesFromRequest (clears it) (E-0117)
ClearStringWindowAt2200::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    lb hl, $53, $01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; Clears the string tiles of the entry screen (vTiles2 and vTiles2 + $670). (C1, E-0357)
LibraryMenu_ShowMonsterEntry_FillTilesFromRequest::
    ld hl, vTiles2
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    lb hl, $61, $01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $670
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank0C::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank0C
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 19 bytes appear in 5 banks) (E-0353)
CopyLow3BitsToWRAMBank2_Bank0C::
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
    ld a, $00
    ldh [rSVBK], a
    ret

; A = 6 * wGridCursorY + wGridCursorX (row-major index in a 6-column grid: wGridCursorX column,
; wGridCursorY row); BC kept (E-0072)
GridIndexFromGridCursorXGridCursorY::
    push bc
    ld a, [wGridCursorY]
    add a
    ld b, a
    add a
    add b
    ld b, a
    ld a, [wGridCursorX]
    add b
    pop bc
    ret

; A = 6 * wGrid2CursorY + wGrid2CursorX (row-major index in a 6-column grid); BC kept (E-0117)
GridIndexFromGrid2CursorXGrid2CursorY::
    push bc
    ld a, [wGrid2CursorY]
    add a
    ld b, a
    add a
    add b
    ld b, a
    ld a, [wGrid2CursorX]
    add b
    pop bc
    ret

; Classifies a monster for the library: A = $FF when its bit in the library list
; (wMonsterLibraryBuf) is clear, $FE when it is listed and its species flag is set (seen), 0 when
; listed but not seen. (C1, E-0357)
LibraryMenu_TestBitInFieldAtArg3::
    push hl
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
    cp $ff
    jr nz, .restore
    pop hl
    ld a, $ff
    ret

.restore:
    pop hl
    push hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a
    jr nz, .done
    pop hl
    xor a
    ret

.done:
    pop hl
    ld a, $fe
    ret

; Copies the monster's two-byte icon block (by its kind in MonsterIconKindTable) to
; wLibraryEntryBlock. (C1, E-0357)
LibraryMenu_ShowMonsterEntry_LoadScreen_CallGridCellAddressFromGridCursorXAndGrid2CursorX::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, MonsterIconKindTable
    add hl, de
    ld a, [hl]
    ld hl, MonsterIconBlockPointers
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $02
    ld hl, wLibraryEntryBlock

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ret

; LibraryMenu_ShowMonsterEntry_LoadScreen_CallGridCellAddressFromGridCursorXAndGrid2CursorX reads
; the byte at $536A + the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX and
; copies the two tile bytes that MonsterIconBlockPointers[value] points to into wScreenBlock9C; 373
; bytes, one per monster id up to $174 (E-0206, C1)
; record: index into MonsterIconBlockPointers
MonsterIconKindTable::
    db $00 ; id 0
    db $00 ; id 1 DrakSlime
    db $00 ; id 2 SpotSlime
    db $01 ; id 3 WingSlime
    db $00 ; id 4 TreeSlime
    db $00 ; id 5 Snaily
    db $01 ; id 6 SlimeNite
    db $00 ; id 7 Babble
    db $00 ; id 8 BoxSlime
    db $00 ; id 9 PearlGel
    db $00 ; id 10 Slime
    db $00 ; id 11 Healer
    db $01 ; id 12 FangSlime
    db $00 ; id 13 RockSlime
    db $01 ; id 14 SlimeBorg
    db $00 ; id 15 Slabbit
    db $01 ; id 16 KingSlime
    db $00 ; id 17 Metaly
    db $00 ; id 18 Metabble
    db $01 ; id 19 SpotKing
    db $01 ; id 20 TropicGel
    db $01 ; id 21 MimeSlime
    db $00 ; id 22 HaloSlime
    db $01 ; id 23 MetalKing
    db $01 ; id 24 GoldSlime
    db $02 ; id 25 GranSlime
    db $00 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $00 ; id 36 DragonKid
    db $01 ; id 37 Tortragon
    db $01 ; id 38 Pteranod
    db $01 ; id 39 Gasgon
    db $00 ; id 40 FairyDrak
    db $02 ; id 41 LizardMan
    db $02 ; id 42 Poisongon
    db $02 ; id 43 Swordgon
    db $02 ; id 44 Drygon
    db $02 ; id 45 Dragon
    db $00 ; id 46 MiniDrak
    db $02 ; id 47 MadDragon
    db $02 ; id 48 Rayburn
    db $00 ; id 49 Chamelgon
    db $00 ; id 50 LizardFly
    db $02 ; id 51 Andreal
    db $00 ; id 52 KingCobra
    db $02 ; id 53 Vampirus
    db $00 ; id 54 SnakeBat
    db $02 ; id 55 Spikerous
    db $03 ; id 56 GreatDrak
    db $00 ; id 57 Crestpent
    db $00 ; id 58 WingSnake
    db $02 ; id 59 Coatol
    db $03 ; id 60 Orochi
    db $02 ; id 61 BattleRex
    db $02 ; id 62 SkyDragon
    db $02 ; id 63 Serpentia
    db $03 ; id 64 Divinegon
    db $03 ; id 65 Orligon
    db $04 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $01 ; id 71 Tonguella
    db $00 ; id 72 Almiraj
    db $00 ; id 73 CatFly
    db $00 ; id 74 PillowRat
    db $00 ; id 75 Saccer
    db $02 ; id 76 GulpBeast
    db $00 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $00 ; id 79 Beavern
    db $00 ; id 80 Antbear
    db $01 ; id 81 SuperTen
    db $01 ; id 82 IronTurt
    db $00 ; id 83 Mommonja
    db $00 ; id 84 HammerMan
    db $02 ; id 85 Grizzly
    db $02 ; id 86 Yeti
    db $00 ; id 87 ArrowDog
    db $02 ; id 88 NoctoKing
    db $01 ; id 89 BeastNite
    db $00 ; id 90 MadGopher
    db $00 ; id 91 FairyRat
    db $01 ; id 92 Unicorn
    db $01 ; id 93 Goategon
    db $01 ; id 94 WildApe
    db $03 ; id 95 Trumpeter
    db $02 ; id 96 KingLeo
    db $02 ; id 97 DarkHorn
    db $02 ; id 98 MadCat
    db $01 ; id 99 BigEye
    db $02 ; id 100 Gorago
    db $00 ; id 101 CatMage
    db $02 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $00 ; id 106 Picky
    db $01 ; id 107 Wyvern
    db $01 ; id 108 BullBird
    db $00 ; id 109 Florajay
    db $01 ; id 110 DuckKite
    db $00 ; id 111 MadPecker
    db $00 ; id 112 MadRaven
    db $00 ; id 113 MistyWing
    db $02 ; id 114 AquaHawk
    db $00 ; id 115 Dracky
    db $00 ; id 116 KiteHawk
    db $01 ; id 117 BigRoost
    db $00 ; id 118 StubBird
    db $01 ; id 119 LandOwl
    db $01 ; id 120 MadGoose
    db $01 ; id 121 MadCondor
    db $01 ; id 122 Emyu
    db $01 ; id 123 Blizzardy
    db $01 ; id 124 Phoenix
    db $01 ; id 125 ZapBird
    db $01 ; id 126 Garudian
    db $03 ; id 127 WhipBird
    db $01 ; id 128 FunkyBird
    db $02 ; id 129 RainHawk
    db $02 ; id 130 Azurile
    db $03 ; id 131 Shantak
    db $00 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $00 ; id 141 MadPlant
    db $00 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $02 ; id 144 WingTree
    db $00 ; id 145 CactiBall
    db $00 ; id 146 Gulpple
    db $00 ; id 147 Toadstool
    db $00 ; id 148 AmberWeed
    db $00 ; id 149 Slurperon
    db $00 ; id 150 Stubsuck
    db $00 ; id 151 Oniono
    db $01 ; id 152 DanceVegi
    db $00 ; id 153 TreeBoy
    db $00 ; id 154 Devipine
    db $03 ; id 155 FaceTree
    db $01 ; id 156 HerbMan
    db $01 ; id 157 BeanMan
    db $00 ; id 158 EvilSeed
    db $02 ; id 159 ManEater
    db $03 ; id 160 Snapper
    db $02 ; id 161 GhosTree
    db $03 ; id 162 Rosevine
    db $04 ; id 163 Egdracil
    db $00 ; id 164 Warubou
    db $00 ; id 165 Watabou
    db $00 ; id 166 Eggplaton
    db $00 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $00 ; id 176 GiantSlug
    db $00 ; id 177 Catapila
    db $00 ; id 178 Gophecada
    db $00 ; id 179 Butterfly
    db $00 ; id 180 WeedBug
    db $00 ; id 181 GiantWorm
    db $00 ; id 182 Lipsy
    db $00 ; id 183 StagBug
    db $01 ; id 184 Pyuro
    db $00 ; id 185 ArmyAnt
    db $00 ; id 186 GoHopper
    db $00 ; id 187 TailEater
    db $01 ; id 188 ArmorPede
    db $00 ; id 189 Eyeder
    db $01 ; id 190 GiantMoth
    db $00 ; id 191 Droll
    db $01 ; id 192 ArmyCrab
    db $01 ; id 193 MadHornet
    db $01 ; id 194 Belzebub
    db $02 ; id 195 WarMantis
    db $02 ; id 196 HornBeet
    db $00 ; id 197 Sickler
    db $02 ; id 198 Armorpion
    db $03 ; id 199 Digster
    db $03 ; id 200 Skularach
    db $02 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $00 ; id 211 Pixy
    db $00 ; id 212 MedusaEye
    db $01 ; id 213 AgDevil
    db $00 ; id 214 Demonite
    db $00 ; id 215 DarkEye
    db $00 ; id 216 EyeBall
    db $01 ; id 217 SkulRider
    db $02 ; id 218 EvilBeast
    db $02 ; id 219 Bubblemon
    db $00 ; id 220 1EyeClown
    db $00 ; id 221 Gremlin
    db $02 ; id 222 ArcDemon
    db $02 ; id 223 Lionex
    db $02 ; id 224 GoatHorn
    db $01 ; id 225 Orc
    db $02 ; id 226 Ogre
    db $01 ; id 227 GateGuard
    db $01 ; id 228 ChopClown
    db $03 ; id 229 BossTroll
    db $02 ; id 230 Grendal
    db $02 ; id 231 Akubar
    db $02 ; id 232 MadKnight
    db $01 ; id 233 EvilWell
    db $04 ; id 234 Gigantes
    db $02 ; id 235 Centasaur
    db $02 ; id 236 EvilArmor
    db $02 ; id 237 Jamirus
    db $02 ; id 238 Durran
    db $04 ; id 239 Titanis
    db $02 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $00 ; id 246 Spooky
    db $03 ; id 247 Skullgon
    db $00 ; id 248 PutrePup
    db $00 ; id 249 RotRaven
    db $01 ; id 250 Mummy
    db $01 ; id 251 DarkCrab
    db $01 ; id 252 DeadNite
    db $00 ; id 253 Shadow
    db $01 ; id 254 Skulpent
    db $01 ; id 255 Hork
    db $00 ; id 256 Mudron
    db $00 ; id 257 NiteWhip
    db $01 ; id 258 WindMerge
    db $00 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $00 ; id 261 FoxFire
    db $02 ; id 262 CaptDead
    db $02 ; id 263 DeadNoble
    db $01 ; id 264 WhiteKing
    db $01 ; id 265 BoneSlave
    db $01 ; id 266 Skeletor
    db $02 ; id 267 Servant
    db $01 ; id 268 Lazamanus
    db $00 ; id 269 Copycat
    db $00 ; id 270 MadSpirit
    db $01 ; id 271 PomPomBom
    db $02 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $00 ; id 281 JewelBag
    db $01 ; id 282 EvilWand
    db $00 ; id 283 MadCandle
    db $00 ; id 284 CoilBird
    db $02 ; id 285 Facer
    db $00 ; id 286 SpikyBoy
    db $01 ; id 287 MadMirror
    db $02 ; id 288 RogueNite
    db $00 ; id 289 Puppetor
    db $00 ; id 290 Goopi
    db $01 ; id 291 Voodoll
    db $03 ; id 292 MetalDrak
    db $02 ; id 293 Balzak
    db $00 ; id 294 SabreMan
    db $00 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $01 ; id 297 Roboster
    db $01 ; id 298 Roboster2
    db $00 ; id 299 EvilPot
    db $00 ; id 300 Gismo
    db $01 ; id 301 LavaMan
    db $01 ; id 302 IceMan
    db $01 ; id 303 Mimic
    db $01 ; id 304 Exaucers
    db $01 ; id 305 MudDoll
    db $02 ; id 306 Golem
    db $03 ; id 307 StoneMan
    db $01 ; id 308 BombCrag
    db $02 ; id 309 GoldGolem
    db $02 ; id 310 DarkMate
    db $01 ; id 311 ProtoMech
    db $04 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $00 ; id 316 Petiteel
    db $00 ; id 317 Moray
    db $01 ; id 318 WalrusMan
    db $01 ; id 319 RayGigas
    db $00 ; id 320 Anemon
    db $01 ; id 321 Aquarella
    db $01 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $01 ; id 325 Octoreach
    db $01 ; id 326 Angleron
    db $01 ; id 327 FishRider
    db $01 ; id 328 RushFish
    db $00 ; id 329 Gamanian
    db $01 ; id 330 Clawster
    db $01 ; id 331 CancerMan
    db $02 ; id 332 RogueWave
    db $00 ; id 333 Scallopa
    db $00 ; id 334 SeaHorse
    db $02 ; id 335 HoodSquid
    db $02 ; id 336 MerTiger
    db $02 ; id 337 AxeShark
    db $03 ; id 338 Octogon
    db $03 ; id 339 KingSquid
    db $02 ; id 340 Digong
    db $01 ; id 341 WhaleMage
    db $04 ; id 342 Aquadon
    db $02 ; id 343 Octoraid
    db $02 ; id 344 Grakos
    db $03 ; id 345 Poseidon
    db $00 ; id 346 Pumpoise
    db $00 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $01 ; id 351 DracoLord
    db $03 ; id 352 DracoLord
    db $03 ; id 353 LordDraco
    db $02 ; id 354 Hargon
    db $02 ; id 355 Sidoh
    db $03 ; id 356 Genosidoh
    db $02 ; id 357 Baramos
    db $02 ; id 358 Zoma
    db $02 ; id 359 AsuraZoma
    db $03 ; id 360 Pizzaro
    db $02 ; id 361 PsychoPiz
    db $02 ; id 362 Esterk
    db $01 ; id 363 Mirudraas
    db $03 ; id 364 Mirudraas
    db $02 ; id 365 Mudou
    db $01 ; id 366 DeathMore
    db $03 ; id 367 DeathMore
    db $04 ; id 368 DeathMore
    db $02 ; id 369 Darkdrium
    db $01 ; id 370 Orgodemir
    db $03 ; id 371 Orgodemir
    db $02 ; id 372 Darck

; the five words point at the two-byte icon blocks right after them; MonsterIconKindTable's values
; index this list (E-0206); was named after a step label since renamed (E-0367, C1)
; record: icon block (two tile bytes)
MonsterIconBlockPointers::
    dw MonsterIconBlocks ; entry 0
    dw MonsterIconBlocks_01 ; entry 1
    dw MonsterIconBlocks_02 ; entry 2
    dw MonsterIconBlocks_03 ; entry 3
    dw MonsterIconBlocks_04 ; entry 4

; the five two-byte icon blocks MonsterIconBlockPointers points at, copied to wLibraryEntryBlock by
; the library entry screen (E-0206) (E-0367, C1)
; record: tile pair
MonsterIconBlocks::
    db $7c, $80 ; entry 0
MonsterIconBlocks_01::
    db $7d, $80 ; entry 1
MonsterIconBlocks_02::
    db $7e, $80 ; entry 2
MonsterIconBlocks_03::
    db $7e, $7e ; entry 3
MonsterIconBlocks_04::
    db $7f, $80 ; entry 4

; takes the class byte of the grid cell
; (LibraryMenu_ShowMonsterEntry_LoadClassBlock_MonsterClassByteTable) and copies its four bytes to
; wLibraryEntryBlock (E-0305)
LibraryMenu_ShowMonsterEntry_LoadClassBlock::
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, LibraryMenu_ShowMonsterEntry_LoadClassBlock_MonsterClassByteTable
    add hl, de
    ld a, [hl]
    add a
    ld hl, LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $04
    ld hl, wLibraryEntryBlock

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ret

; data read by LibraryMenu (8 words) (E-0347)
LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data::
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry00
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry01
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry02
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry03
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry04
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry05
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry06
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry07

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry00::
    db $81, $80, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry01::
    db $82, $80, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry02::
    db $82, $81, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry03::
    db $82, $82, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry04::
    db $82, $82, $81, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry05::
    db $82, $82, $82, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry06::
    db $82, $82, $82, $81

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry07::
    db $82, $82, $82, $82

; writes six bytes from WriteBGPalette0FromData_Data to the CGB background palette data (rBCPS =
; $80, auto-increment), waiting for VRAM access (E-0122) (E-0344: the address in its name dropped or
; read as the label there; was WriteBGPalette0FromData; a trailing preposition left by the dropped
; address removed)
WriteBGPalette0FromData::
    ld hl, WriteBGPalette0FromData_Data
    ld b, $80
    ld c, $68
    ld a, b
    ldh [c], a
    ld c, $69
    ld d, $06

.loop:
    ldh a, [rSTAT]
    and $02
    jr nz, .loop
    ld a, [hli]
    ldh [c], a
    dec d
    jr nz, .loop
    ret

; data read by WriteBGPalette0FromData (6 bytes) (E-0347)
WriteBGPalette0FromData_Data::
    db $86, $7d, $ff, $7f, $e1, $7f

; LibraryMenu_ShowMonsterEntry_LoadClassBlock reads the byte at $5562 + the monster number from
; GridCellAddressFromGridCursorXAndGrid2CursorX and copies the 4-byte tile block that
; LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data[class] points to into wScreenBlock9C; the same
; 373 values as MonsterClassByteTable_1 in bank $16 except at ids 26, 352, 355, 358, 360, 364, 366,
; 367, 372 (E-0206, C1)
; record: class 0-7
LibraryMenu_ShowMonsterEntry_LoadClassBlock_MonsterClassByteTable::
    db $00 ; id 0
    db $03 ; id 1 DrakSlime
    db $00 ; id 2 SpotSlime
    db $02 ; id 3 WingSlime
    db $01 ; id 4 TreeSlime
    db $00 ; id 5 Snaily
    db $03 ; id 6 SlimeNite
    db $01 ; id 7 Babble
    db $02 ; id 8 BoxSlime
    db $02 ; id 9 PearlGel
    db $01 ; id 10 Slime
    db $02 ; id 11 Healer
    db $03 ; id 12 FangSlime
    db $03 ; id 13 RockSlime
    db $03 ; id 14 SlimeBorg
    db $00 ; id 15 Slabbit
    db $05 ; id 16 KingSlime
    db $04 ; id 17 Metaly
    db $05 ; id 18 Metabble
    db $04 ; id 19 SpotKing
    db $01 ; id 20 TropicGel
    db $04 ; id 21 MimeSlime
    db $04 ; id 22 HaloSlime
    db $05 ; id 23 MetalKing
    db $06 ; id 24 GoldSlime
    db $07 ; id 25 GranSlime
    db $01 ; id 26 WonderEgg
    db $00 ; id 27 Butch
    db $00 ; id 28 ?
    db $00 ; id 29 ?
    db $00 ; id 30 ?
    db $00 ; id 31 ?
    db $00 ; id 32 ?
    db $00 ; id 33 ?
    db $00 ; id 34 ?
    db $00 ; id 35 ?
    db $02 ; id 36 DragonKid
    db $02 ; id 37 Tortragon
    db $02 ; id 38 Pteranod
    db $02 ; id 39 Gasgon
    db $00 ; id 40 FairyDrak
    db $04 ; id 41 LizardMan
    db $01 ; id 42 Poisongon
    db $03 ; id 43 Swordgon
    db $03 ; id 44 Drygon
    db $04 ; id 45 Dragon
    db $01 ; id 46 MiniDrak
    db $04 ; id 47 MadDragon
    db $03 ; id 48 Rayburn
    db $00 ; id 49 Chamelgon
    db $00 ; id 50 LizardFly
    db $04 ; id 51 Andreal
    db $01 ; id 52 KingCobra
    db $03 ; id 53 Vampirus
    db $01 ; id 54 SnakeBat
    db $04 ; id 55 Spikerous
    db $05 ; id 56 GreatDrak
    db $01 ; id 57 Crestpent
    db $02 ; id 58 WingSnake
    db $04 ; id 59 Coatol
    db $06 ; id 60 Orochi
    db $05 ; id 61 BattleRex
    db $05 ; id 62 SkyDragon
    db $05 ; id 63 Serpentia
    db $06 ; id 64 Divinegon
    db $07 ; id 65 Orligon
    db $06 ; id 66 GigaDraco
    db $00 ; id 67 ?
    db $00 ; id 68 ?
    db $00 ; id 69 ?
    db $00 ; id 70 ?
    db $02 ; id 71 Tonguella
    db $00 ; id 72 Almiraj
    db $00 ; id 73 CatFly
    db $00 ; id 74 PillowRat
    db $00 ; id 75 Saccer
    db $04 ; id 76 GulpBeast
    db $01 ; id 77 Skullroo
    db $01 ; id 78 WindBeast
    db $02 ; id 79 Beavern
    db $00 ; id 80 Antbear
    db $02 ; id 81 SuperTen
    db $02 ; id 82 IronTurt
    db $01 ; id 83 Mommonja
    db $01 ; id 84 HammerMan
    db $03 ; id 85 Grizzly
    db $03 ; id 86 Yeti
    db $01 ; id 87 ArrowDog
    db $02 ; id 88 NoctoKing
    db $02 ; id 89 BeastNite
    db $01 ; id 90 MadGopher
    db $00 ; id 91 FairyRat
    db $05 ; id 92 Unicorn
    db $03 ; id 93 Goategon
    db $03 ; id 94 WildApe
    db $04 ; id 95 Trumpeter
    db $06 ; id 96 KingLeo
    db $05 ; id 97 DarkHorn
    db $04 ; id 98 MadCat
    db $04 ; id 99 BigEye
    db $07 ; id 100 Gorago
    db $03 ; id 101 CatMage
    db $03 ; id 102 Dumbira
    db $00 ; id 103 ?
    db $00 ; id 104 ?
    db $00 ; id 105 ?
    db $00 ; id 106 Picky
    db $03 ; id 107 Wyvern
    db $02 ; id 108 BullBird
    db $01 ; id 109 Florajay
    db $03 ; id 110 DuckKite
    db $03 ; id 111 MadPecker
    db $01 ; id 112 MadRaven
    db $02 ; id 113 MistyWing
    db $02 ; id 114 AquaHawk
    db $00 ; id 115 Dracky
    db $01 ; id 116 KiteHawk
    db $01 ; id 117 BigRoost
    db $02 ; id 118 StubBird
    db $02 ; id 119 LandOwl
    db $03 ; id 120 MadGoose
    db $03 ; id 121 MadCondor
    db $03 ; id 122 Emyu
    db $04 ; id 123 Blizzardy
    db $04 ; id 124 Phoenix
    db $04 ; id 125 ZapBird
    db $05 ; id 126 Garudian
    db $05 ; id 127 WhipBird
    db $04 ; id 128 FunkyBird
    db $06 ; id 129 RainHawk
    db $07 ; id 130 Azurile
    db $06 ; id 131 Shantak
    db $02 ; id 132 CragDevil
    db $00 ; id 133 ?
    db $00 ; id 134 ?
    db $00 ; id 135 ?
    db $00 ; id 136 ?
    db $00 ; id 137 ?
    db $00 ; id 138 ?
    db $00 ; id 139 ?
    db $00 ; id 140 ?
    db $01 ; id 141 MadPlant
    db $02 ; id 142 FireWeed
    db $02 ; id 143 FloraMan
    db $01 ; id 144 WingTree
    db $00 ; id 145 CactiBall
    db $02 ; id 146 Gulpple
    db $00 ; id 147 Toadstool
    db $03 ; id 148 AmberWeed
    db $00 ; id 149 Slurperon
    db $02 ; id 150 Stubsuck
    db $01 ; id 151 Oniono
    db $02 ; id 152 DanceVegi
    db $03 ; id 153 TreeBoy
    db $03 ; id 154 Devipine
    db $05 ; id 155 FaceTree
    db $05 ; id 156 HerbMan
    db $03 ; id 157 BeanMan
    db $03 ; id 158 EvilSeed
    db $03 ; id 159 ManEater
    db $04 ; id 160 Snapper
    db $04 ; id 161 GhosTree
    db $06 ; id 162 Rosevine
    db $07 ; id 163 Egdracil
    db $07 ; id 164 Warubou
    db $07 ; id 165 Watabou
    db $00 ; id 166 Eggplaton
    db $03 ; id 167 FooHero
    db $00 ; id 168 ?
    db $00 ; id 169 ?
    db $00 ; id 170 ?
    db $00 ; id 171 ?
    db $00 ; id 172 ?
    db $00 ; id 173 ?
    db $00 ; id 174 ?
    db $00 ; id 175 ?
    db $00 ; id 176 GiantSlug
    db $03 ; id 177 Catapila
    db $01 ; id 178 Gophecada
    db $01 ; id 179 Butterfly
    db $03 ; id 180 WeedBug
    db $00 ; id 181 GiantWorm
    db $02 ; id 182 Lipsy
    db $02 ; id 183 StagBug
    db $02 ; id 184 Pyuro
    db $00 ; id 185 ArmyAnt
    db $01 ; id 186 GoHopper
    db $00 ; id 187 TailEater
    db $03 ; id 188 ArmorPede
    db $02 ; id 189 Eyeder
    db $03 ; id 190 GiantMoth
    db $03 ; id 191 Droll
    db $04 ; id 192 ArmyCrab
    db $03 ; id 193 MadHornet
    db $02 ; id 194 Belzebub
    db $05 ; id 195 WarMantis
    db $05 ; id 196 HornBeet
    db $04 ; id 197 Sickler
    db $06 ; id 198 Armorpion
    db $05 ; id 199 Digster
    db $07 ; id 200 Skularach
    db $03 ; id 201 MultiEyes
    db $00 ; id 202 ?
    db $00 ; id 203 ?
    db $00 ; id 204 ?
    db $00 ; id 205 ?
    db $00 ; id 206 ?
    db $00 ; id 207 ?
    db $00 ; id 208 ?
    db $00 ; id 209 ?
    db $00 ; id 210 ?
    db $00 ; id 211 Pixy
    db $02 ; id 212 MedusaEye
    db $04 ; id 213 AgDevil
    db $00 ; id 214 Demonite
    db $03 ; id 215 DarkEye
    db $02 ; id 216 EyeBall
    db $03 ; id 217 SkulRider
    db $04 ; id 218 EvilBeast
    db $04 ; id 219 Bubblemon
    db $01 ; id 220 1EyeClown
    db $01 ; id 221 Gremlin
    db $05 ; id 222 ArcDemon
    db $04 ; id 223 Lionex
    db $05 ; id 224 GoatHorn
    db $03 ; id 225 Orc
    db $04 ; id 226 Ogre
    db $05 ; id 227 GateGuard
    db $05 ; id 228 ChopClown
    db $05 ; id 229 BossTroll
    db $05 ; id 230 Grendal
    db $06 ; id 231 Akubar
    db $04 ; id 232 MadKnight
    db $05 ; id 233 EvilWell
    db $03 ; id 234 Gigantes
    db $05 ; id 235 Centasaur
    db $03 ; id 236 EvilArmor
    db $06 ; id 237 Jamirus
    db $06 ; id 238 Durran
    db $07 ; id 239 Titanis
    db $06 ; id 240 LampGenie
    db $00 ; id 241 ?
    db $00 ; id 242 ?
    db $00 ; id 243 ?
    db $00 ; id 244 ?
    db $00 ; id 245 ?
    db $00 ; id 246 Spooky
    db $05 ; id 247 Skullgon
    db $02 ; id 248 PutrePup
    db $01 ; id 249 RotRaven
    db $02 ; id 250 Mummy
    db $03 ; id 251 DarkCrab
    db $03 ; id 252 DeadNite
    db $02 ; id 253 Shadow
    db $02 ; id 254 Skulpent
    db $02 ; id 255 Hork
    db $01 ; id 256 Mudron
    db $02 ; id 257 NiteWhip
    db $02 ; id 258 WindMerge
    db $03 ; id 259 Reaper
    db $01 ; id 260 Inverzon
    db $01 ; id 261 FoxFire
    db $03 ; id 262 CaptDead
    db $06 ; id 263 DeadNoble
    db $06 ; id 264 WhiteKing
    db $03 ; id 265 BoneSlave
    db $04 ; id 266 Skeletor
    db $05 ; id 267 Servant
    db $07 ; id 268 Lazamanus
    db $06 ; id 269 Copycat
    db $03 ; id 270 MadSpirit
    db $02 ; id 271 PomPomBom
    db $06 ; id 272 Niterich
    db $00 ; id 273 ?
    db $00 ; id 274 ?
    db $00 ; id 275 ?
    db $00 ; id 276 ?
    db $00 ; id 277 ?
    db $00 ; id 278 ?
    db $00 ; id 279 ?
    db $00 ; id 280 ?
    db $01 ; id 281 JewelBag
    db $02 ; id 282 EvilWand
    db $00 ; id 283 MadCandle
    db $01 ; id 284 CoilBird
    db $00 ; id 285 Facer
    db $00 ; id 286 SpikyBoy
    db $03 ; id 287 MadMirror
    db $03 ; id 288 RogueNite
    db $02 ; id 289 Puppetor
    db $00 ; id 290 Goopi
    db $03 ; id 291 Voodoll
    db $04 ; id 292 MetalDrak
    db $05 ; id 293 Balzak
    db $03 ; id 294 SabreMan
    db $02 ; id 295 CurseLamp
    db $01 ; id 296 Brushead
    db $04 ; id 297 Roboster
    db $05 ; id 298 Roboster2
    db $03 ; id 299 EvilPot
    db $03 ; id 300 Gismo
    db $05 ; id 301 LavaMan
    db $05 ; id 302 IceMan
    db $04 ; id 303 Mimic
    db $03 ; id 304 Exaucers
    db $00 ; id 305 MudDoll
    db $04 ; id 306 Golem
    db $05 ; id 307 StoneMan
    db $04 ; id 308 BombCrag
    db $06 ; id 309 GoldGolem
    db $07 ; id 310 DarkMate
    db $02 ; id 311 ProtoMech
    db $04 ; id 312 CloudKing
    db $00 ; id 313 ?
    db $00 ; id 314 ?
    db $00 ; id 315 ?
    db $00 ; id 316 Petiteel
    db $00 ; id 317 Moray
    db $03 ; id 318 WalrusMan
    db $03 ; id 319 RayGigas
    db $02 ; id 320 Anemon
    db $02 ; id 321 Aquarella
    db $03 ; id 322 Merman
    db $01 ; id 323 Octokid
    db $00 ; id 324 PutreFish
    db $02 ; id 325 Octoreach
    db $03 ; id 326 Angleron
    db $03 ; id 327 FishRider
    db $04 ; id 328 RushFish
    db $01 ; id 329 Gamanian
    db $03 ; id 330 Clawster
    db $04 ; id 331 CancerMan
    db $02 ; id 332 RogueWave
    db $01 ; id 333 Scallopa
    db $04 ; id 334 SeaHorse
    db $04 ; id 335 HoodSquid
    db $04 ; id 336 MerTiger
    db $05 ; id 337 AxeShark
    db $05 ; id 338 Octogon
    db $06 ; id 339 KingSquid
    db $05 ; id 340 Digong
    db $05 ; id 341 WhaleMage
    db $06 ; id 342 Aquadon
    db $05 ; id 343 Octoraid
    db $06 ; id 344 Grakos
    db $07 ; id 345 Poseidon
    db $02 ; id 346 Pumpoise
    db $01 ; id 347 Starfish
    db $00 ; id 348 ?
    db $00 ; id 349 ?
    db $00 ; id 350 ?
    db $06 ; id 351 DracoLord
    db $06 ; id 352 DracoLord
    db $07 ; id 353 LordDraco
    db $06 ; id 354 Hargon
    db $06 ; id 355 Sidoh
    db $07 ; id 356 Genosidoh
    db $06 ; id 357 Baramos
    db $06 ; id 358 Zoma
    db $07 ; id 359 AsuraZoma
    db $06 ; id 360 Pizzaro
    db $07 ; id 361 PsychoPiz
    db $06 ; id 362 Esterk
    db $06 ; id 363 Mirudraas
    db $06 ; id 364 Mirudraas
    db $06 ; id 365 Mudou
    db $06 ; id 366 DeathMore
    db $06 ; id 367 DeathMore
    db $07 ; id 368 DeathMore
    db $07 ; id 369 Darkdrium
    db $07 ; id 370 Orgodemir
    db $07 ; id 371 Orgodemir
    db $06 ; id 372 Darck

LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Data::
    db $05, $04

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 9 x 13 tiles, one row per line
LibraryMenu_DrawFamilyChooser_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $02, $c3, $c3, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $03, $c3, $c3, $ed, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $04, $c3, $c3, $ed, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $05, $c3, $c3, $ed, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $06, $c3, $c3, $ed, $c3, $c3, $b7 ; id 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $07, $c3, $c3, $ed, $c3, $c3, $b7 ; id 11
    db $b3, $c5, $c3, $be, $e2, $c6, $b4, $b4, $b5 ; id 12

; record: 12 x 13 tiles, one row per line
LibraryMenu_DrawMonsterList_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $b7 ; id 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 10
    db $b6, $c3, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $b7 ; id 11
    db $b3, $b4, $b4, $b4, $b4, $b4, $c5, $c3, $be, $c3, $c6, $b5 ; id 12

LibraryMenu_BackToFamilies_TileRect::
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 7
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 8
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 9
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 10
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 11
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 12
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $66, $b9, $b9, $b9, $b9, $b9, $b9, $b9
    db $b9, $b9, $b9, $ba

; record: 20 x 5 tiles, one row per line
LibraryMenu_ShowMonsterEntry_RedrawCounts_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

LibraryMenu_DrawFamilyChooser_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4, $41, $c4

LibraryMenu_DrawMonsterList_Data1::
    db $81, $c3, $a9, $c3, $d1, $c3, $f9, $c3, $21, $c4, $49, $c4

LibraryMenu_CountSeenMonsters_Data1::
    db $01, $00, $24, $00, $47, $00, $6a, $00, $8d, $00, $b0, $00, $d3, $00, $f6, $00
    db $19, $01, $3c, $01, $5f, $01, $ff, $ff

LibraryMenu_CountSeenMonsters_Data2::
    db $1b, $00, $43, $00, $67, $00, $85, $00, $a8, $00, $ca, $00, $f1, $00, $11, $01
    db $39, $01, $5c, $01, $75, $01

LibraryMenu_DrawMonsterList_Data2::
    db $04, $05, $05, $04, $04, $04, $04, $04, $05, $05, $03

ReadGridCellByteForGridCursorXGridCursorY_Data::
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry00
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry01
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry02
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry03
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry04
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry05
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry06
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry07
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry08
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry09
    dw ReadGridCellByteForGridCursorXGridCursorY_Data_Entry0A

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry00::
    db $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry01::
    db $05, $05, $05, $05, $05, $00

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry02::
    db $05, $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry03::
    db $05, $05, $05, $05, $02

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry04::
    db $05, $05, $05, $05, $02

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry05::
    db $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry06::
    db $05, $05, $05, $05, $05

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry07::
    db $05, $05, $05, $05, $02

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry08::
    db $05, $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry09::
    db $05, $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry0A::
    db $05, $05, $05, $03

; LibraryMenu_ShowMonsterEntry_ShowPedigree takes the monster number from
; GridCellAddressFromGridCursorXAndGrid2CursorX (page base from LibraryMenu_CountSeenMonsters_Data1
; plus the grid position) and reads the word at $599F + 2 * number: the first word
; LibraryMenu_ShowMonsterEntry_ShowPedigree draws (graphics at vTiles2 + $300, sprite part $42); the
; two parents shown for the monster: for all 95 monsters whose two entries are families,
; FamilyPairResultTable (bank $0E) row A, column B gives that monster or parent A's species (C2 for
; those entries); 384 words (E-0211, C1)
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableA::
    dw $fe00 ; id 0 family 0
    dw $fe00 ; id 1 DrakSlime family 0
    dw $fe00 ; id 2 SpotSlime family 0
    dw $fe00 ; id 3 WingSlime family 0
    dw $fe00 ; id 4 TreeSlime family 0
    dw $fe00 ; id 5 Snaily family 0
    dw $fe00 ; id 6 SlimeNite family 0
    dw $fe00 ; id 7 Babble family 0
    dw $fe00 ; id 8 BoxSlime family 0
    dw $fe00 ; id 9 PearlGel family 0
    dw $fefe ; id 10 Slime none
    dw $fe00 ; id 11 Healer family 0
    dw $fe00 ; id 12 FangSlime family 0
    dw $fe00 ; id 13 RockSlime family 0
    dw MONSTER_DRAKSLIME ; id 14 SlimeBorg
    dw $fe00 ; id 15 Slabbit family 0
    dw $fe00 ; id 16 KingSlime family 0
    dw $fe00 ; id 17 Metaly family 0
    dw MONSTER_METALY ; id 18 Metabble
    dw MONSTER_KINGSLIME ; id 19 SpotKing
    dw MONSTER_TREESLIME ; id 20 TropicGel
    dw MONSTER_HEALER ; id 21 MimeSlime
    dw MONSTER_MIMESLIME ; id 22 HaloSlime
    dw MONSTER_SPOTKING ; id 23 MetalKing
    dw MONSTER_METALKING ; id 24 GoldSlime
    dw MONSTER_GOLDSLIME ; id 25 GranSlime
    dw $fefe ; id 26 WonderEgg none
    dw $fefe ; id 27 Butch none
    dw $fefe ; id 28 ? none
    dw $fefe ; id 29 ? none
    dw $fefe ; id 30 ? none
    dw $fefe ; id 31 ? none
    dw $fefe ; id 32 ? none
    dw $fefe ; id 33 ? none
    dw $fefe ; id 34 ? none
    dw $fefe ; id 35 ? none
    dw $fe01 ; id 36 DragonKid family 1
    dw $fe01 ; id 37 Tortragon family 1
    dw $fe01 ; id 38 Pteranod family 1
    dw $fe01 ; id 39 Gasgon family 1
    dw $fe01 ; id 40 FairyDrak family 1
    dw $fe01 ; id 41 LizardMan family 1
    dw $fe01 ; id 42 Poisongon family 1
    dw $fe01 ; id 43 Swordgon family 1
    dw $fe01 ; id 44 Drygon family 1
    dw MONSTER_DRAGONKID ; id 45 Dragon
    dw $fe01 ; id 46 MiniDrak family 1
    dw MONSTER_GASGON ; id 47 MadDragon
    dw MONSTER_LIZARDMAN ; id 48 Rayburn
    dw $fe01 ; id 49 Chamelgon family 1
    dw $fe01 ; id 50 LizardFly family 1
    dw $fe01 ; id 51 Andreal family 1
    dw $fe01 ; id 52 KingCobra family 1
    dw $fe01 ; id 53 Vampirus family 1
    dw MONSTER_KINGCOBRA ; id 54 SnakeBat
    dw $fe01 ; id 55 Spikerous family 1
    dw MONSTER_DRAGON ; id 56 GreatDrak
    dw $fe01 ; id 57 Crestpent family 1
    dw MONSTER_CRESTPENT ; id 58 WingSnake
    dw MONSTER_WINGSNAKE ; id 59 Coatol
    dw MONSTER_ANDREAL ; id 60 Orochi
    dw $fe01 ; id 61 BattleRex family 1
    dw $fe01 ; id 62 SkyDragon family 1
    dw MONSTER_GREATDRAK ; id 63 Serpentia
    dw MONSTER_SKYDRAGON ; id 64 Divinegon
    dw MONSTER_DIVINEGON ; id 65 Orligon
    dw MONSTER_GREATDRAK ; id 66 GigaDraco
    dw $fefe ; id 67 ? none
    dw $fefe ; id 68 ? none
    dw $fefe ; id 69 ? none
    dw $fefe ; id 70 ? none
    dw $fe02 ; id 71 Tonguella family 2
    dw $fe02 ; id 72 Almiraj family 2
    dw $fe02 ; id 73 CatFly family 2
    dw $fe02 ; id 74 PillowRat family 2
    dw $fe02 ; id 75 Saccer family 2
    dw MONSTER_GRIZZLY ; id 76 GulpBeast
    dw $fe02 ; id 77 Skullroo family 2
    dw $fe02 ; id 78 WindBeast family 2
    dw $fe02 ; id 79 Beavern family 2
    dw MONSTER_SACCER ; id 80 Antbear
    dw MONSTER_TONGUELLA ; id 81 SuperTen
    dw $fe02 ; id 82 IronTurt family 2
    dw $fe02 ; id 83 Mommonja family 2
    dw $fe02 ; id 84 HammerMan family 2
    dw $fe02 ; id 85 Grizzly family 2
    dw MONSTER_WILDAPE ; id 86 Yeti
    dw $fe02 ; id 87 ArrowDog family 2
    dw MONSTER_ARROWDOG ; id 88 NoctoKing
    dw $fe02 ; id 89 BeastNite family 2
    dw $fe02 ; id 90 MadGopher family 2
    dw $fe02 ; id 91 FairyRat family 2
    dw MONSTER_YETI ; id 92 Unicorn
    dw $fe02 ; id 93 Goategon family 2
    dw MONSTER_ALMIRAJ ; id 94 WildApe
    dw MONSTER_WILDAPE ; id 95 Trumpeter
    dw MONSTER_TRUMPETER ; id 96 KingLeo
    dw $fe02 ; id 97 DarkHorn family 2
    dw $fe02 ; id 98 MadCat family 2
    dw $fe02 ; id 99 BigEye family 2
    dw MONSTER_DARKHORN ; id 100 Gorago
    dw MONSTER_CATFLY ; id 101 CatMage
    dw MONSTER_SUPERTEN ; id 102 Dumbira
    dw $fefe ; id 103 ? none
    dw $fefe ; id 104 ? none
    dw $fefe ; id 105 ? none
    dw $fe03 ; id 106 Picky family 3
    dw $fe03 ; id 107 Wyvern family 3
    dw $fe03 ; id 108 BullBird family 3
    dw $fe03 ; id 109 Florajay family 3
    dw $fe03 ; id 110 DuckKite family 3
    dw $fe03 ; id 111 MadPecker family 3
    dw $fe03 ; id 112 MadRaven family 3
    dw $fe03 ; id 113 MistyWing family 3
    dw $fe03 ; id 114 AquaHawk family 3
    dw MONSTER_PICKY ; id 115 Dracky
    dw MONSTER_DUCKKITE ; id 116 KiteHawk
    dw $fefe ; id 117 BigRoost none
    dw $fe03 ; id 118 StubBird family 3
    dw MONSTER_BULLBIRD ; id 119 LandOwl
    dw MONSTER_WYVERN ; id 120 MadGoose
    dw MONSTER_LANDOWL ; id 121 MadCondor
    dw MONSTER_MADPECKER ; id 122 Emyu
    dw $fe03 ; id 123 Blizzardy family 3
    dw $fe03 ; id 124 Phoenix family 3
    dw MONSTER_PHOENIX ; id 125 ZapBird
    dw MONSTER_ZAPBIRD ; id 126 Garudian
    dw $fe03 ; id 127 WhipBird family 3
    dw $fe03 ; id 128 FunkyBird family 3
    dw MONSTER_BLIZZARDY ; id 129 RainHawk
    dw MONSTER_RAINHAWK ; id 130 Azurile
    dw MONSTER_WHIPBIRD ; id 131 Shantak
    dw MONSTER_EMYU ; id 132 CragDevil
    dw $fefe ; id 133 ? none
    dw $fefe ; id 134 ? none
    dw $fefe ; id 135 ? none
    dw $fefe ; id 136 ? none
    dw $fefe ; id 137 ? none
    dw $fefe ; id 138 ? none
    dw $fefe ; id 139 ? none
    dw $fefe ; id 140 ? none
    dw $fe04 ; id 141 MadPlant family 4
    dw $fe04 ; id 142 FireWeed family 4
    dw $fe04 ; id 143 FloraMan family 4
    dw $fe04 ; id 144 WingTree family 4
    dw $fe04 ; id 145 CactiBall family 4
    dw $fe04 ; id 146 Gulpple family 4
    dw $fe04 ; id 147 Toadstool family 4
    dw $fe04 ; id 148 AmberWeed family 4
    dw $fe04 ; id 149 Slurperon family 4
    dw MONSTER_AMBERWEED ; id 150 Stubsuck
    dw $fe04 ; id 151 Oniono family 4
    dw $fe04 ; id 152 DanceVegi family 4
    dw $fe04 ; id 153 TreeBoy family 4
    dw $fe04 ; id 154 Devipine family 4
    dw MONSTER_HERBMAN ; id 155 FaceTree
    dw $fe04 ; id 156 HerbMan family 4
    dw $fe04 ; id 157 BeanMan family 4
    dw $fe04 ; id 158 EvilSeed family 4
    dw MONSTER_EVILSEED ; id 159 ManEater
    dw MONSTER_MANEATER ; id 160 Snapper
    dw MONSTER_STUBSUCK ; id 161 GhosTree
    dw $fe04 ; id 162 Rosevine family 4
    dw MONSTER_ROSEVINE ; id 163 Egdracil
    dw $fefe ; id 164 Warubou none
    dw $fefe ; id 165 Watabou none
    dw $fe04 ; id 166 Eggplaton family 4
    dw MONSTER_TREEBOY ; id 167 FooHero
    dw $fefe ; id 168 ? none
    dw $fefe ; id 169 ? none
    dw $fefe ; id 170 ? none
    dw $fefe ; id 171 ? none
    dw $fefe ; id 172 ? none
    dw $fefe ; id 173 ? none
    dw $fefe ; id 174 ? none
    dw $fefe ; id 175 ? none
    dw $fe05 ; id 176 GiantSlug family 5
    dw $fe05 ; id 177 Catapila family 5
    dw $fe05 ; id 178 Gophecada family 5
    dw $fe05 ; id 179 Butterfly family 5
    dw $fe05 ; id 180 WeedBug family 5
    dw $fe05 ; id 181 GiantWorm family 5
    dw $fe05 ; id 182 Lipsy family 5
    dw $fe05 ; id 183 StagBug family 5
    dw $fe05 ; id 184 Pyuro family 5
    dw MONSTER_GIANTSLUG ; id 185 ArmyAnt
    dw $fefe ; id 186 GoHopper none
    dw MONSTER_WEEDBUG ; id 187 TailEater
    dw MONSTER_GIANTWORM ; id 188 ArmorPede
    dw $fe05 ; id 189 Eyeder family 5
    dw MONSTER_BUTTERFLY ; id 190 GiantMoth
    dw $fe05 ; id 191 Droll family 5
    dw $fe05 ; id 192 ArmyCrab family 5
    dw MONSTER_PYURO ; id 193 MadHornet
    dw MONSTER_MADHORNET ; id 194 Belzebub
    dw MONSTER_SICKLER ; id 195 WarMantis
    dw MONSTER_STAGBUG ; id 196 HornBeet
    dw $fe05 ; id 197 Sickler family 5
    dw MONSTER_HORNBEET ; id 198 Armorpion
    dw $fe05 ; id 199 Digster family 5
    dw MONSTER_ARMORPION ; id 200 Skularach
    dw MONSTER_CATAPILA ; id 201 MultiEyes
    dw $fefe ; id 202 ? none
    dw $fefe ; id 203 ? none
    dw $fefe ; id 204 ? none
    dw $fefe ; id 205 ? none
    dw $fefe ; id 206 ? none
    dw $fefe ; id 207 ? none
    dw $fefe ; id 208 ? none
    dw $fefe ; id 209 ? none
    dw $fefe ; id 210 ? none
    dw $fe06 ; id 211 Pixy family 6
    dw $fe06 ; id 212 MedusaEye family 6
    dw MONSTER_GREMLIN ; id 213 AgDevil
    dw $fe06 ; id 214 Demonite family 6
    dw $fe06 ; id 215 DarkEye family 6
    dw $fe06 ; id 216 EyeBall family 6
    dw $fe06 ; id 217 SkulRider family 6
    dw $fe06 ; id 218 EvilBeast family 6
    dw $fe06 ; id 219 Bubblemon family 6
    dw MONSTER_EYEBALL ; id 220 1EyeClown
    dw $fe06 ; id 221 Gremlin family 6
    dw MONSTER_OGRE ; id 222 ArcDemon
    dw $fe06 ; id 223 Lionex family 6
    dw MONSTER_ARCDEMON ; id 224 GoatHorn
    dw $fe06 ; id 225 Orc family 6
    dw $fe06 ; id 226 Ogre family 6
    dw MONSTER_DEMONITE ; id 227 GateGuard
    dw MONSTER_1EYECLOWN ; id 228 ChopClown
    dw MONSTER_GOATHORN ; id 229 BossTroll
    dw $fe06 ; id 230 Grendal family 6
    dw MONSTER_GRENDAL ; id 231 Akubar
    dw $fe06 ; id 232 MadKnight family 6
    dw MONSTER_BOSSTROLL ; id 233 EvilWell
    dw MONSTER_EVILBEAST ; id 234 Gigantes
    dw MONSTER_OGRE ; id 235 Centasaur
    dw $fe06 ; id 236 EvilArmor family 6
    dw MONSTER_AKUBAR ; id 237 Jamirus
    dw MONSTER_JAMIRUS ; id 238 Durran
    dw MONSTER_DURRAN ; id 239 Titanis
    dw MONSTER_CENTASAUR ; id 240 LampGenie
    dw $fefe ; id 241 ? none
    dw $fefe ; id 242 ? none
    dw $fefe ; id 243 ? none
    dw $fefe ; id 244 ? none
    dw $fefe ; id 245 ? none
    dw $fe07 ; id 246 Spooky family 7
    dw MONSTER_SKULPENT ; id 247 Skullgon
    dw MONSTER_SKULPENT ; id 248 PutrePup
    dw $fe07 ; id 249 RotRaven family 7
    dw $fe07 ; id 250 Mummy family 7
    dw $fe07 ; id 251 DarkCrab family 7
    dw $fe07 ; id 252 DeadNite family 7
    dw $fe07 ; id 253 Shadow family 7
    dw $fe07 ; id 254 Skulpent family 7
    dw MONSTER_SPOOKY ; id 255 Hork
    dw $fe07 ; id 256 Mudron family 7
    dw $fe07 ; id 257 NiteWhip family 7
    dw $fe07 ; id 258 WindMerge family 7
    dw MONSTER_SPOOKY ; id 259 Reaper
    dw MONSTER_HORK ; id 260 Inverzon
    dw MONSTER_NITEWHIP ; id 261 FoxFire
    dw MONSTER_BONESLAVE ; id 262 CaptDead
    dw MONSTER_DEADNITE ; id 263 DeadNoble
    dw MONSTER_DEADNOBLE ; id 264 WhiteKing
    dw MONSTER_MUMMY ; id 265 BoneSlave
    dw MONSTER_BONESLAVE ; id 266 Skeletor
    dw MONSTER_SKELETOR ; id 267 Servant
    dw MONSTER_WHITEKING ; id 268 Lazamanus
    dw $fefe ; id 269 Copycat none
    dw $fe07 ; id 270 MadSpirit family 7
    dw MONSTER_COPYCAT ; id 271 PomPomBom
    dw MONSTER_SKELETOR ; id 272 Niterich
    dw $fefe ; id 273 ? none
    dw $fefe ; id 274 ? none
    dw $fefe ; id 275 ? none
    dw $fefe ; id 276 ? none
    dw $fefe ; id 277 ? none
    dw $fefe ; id 278 ? none
    dw $fefe ; id 279 ? none
    dw $fefe ; id 280 ? none
    dw $fe08 ; id 281 JewelBag family 8
    dw $fe08 ; id 282 EvilWand family 8
    dw $fe08 ; id 283 MadCandle family 8
    dw $fe08 ; id 284 CoilBird family 8
    dw $fe08 ; id 285 Facer family 8
    dw $fe08 ; id 286 SpikyBoy family 8
    dw $fe08 ; id 287 MadMirror family 8
    dw $fe08 ; id 288 RogueNite family 8
    dw $fe08 ; id 289 Puppetor family 8
    dw MONSTER_JEWELBAG ; id 290 Goopi
    dw MONSTER_PUPPETOR ; id 291 Voodoll
    dw $fe08 ; id 292 MetalDrak family 8
    dw $fe08 ; id 293 Balzak family 8
    dw $fe08 ; id 294 SabreMan family 8
    dw $fe08 ; id 295 CurseLamp family 8
    dw $fe08 ; id 296 Brushead family 8
    dw MONSTER_SABREMAN ; id 297 Roboster
    dw MONSTER_ROBOSTER ; id 298 Roboster2
    dw $fe08 ; id 299 EvilPot family 8
    dw MONSTER_MADCANDLE ; id 300 Gismo
    dw MONSTER_METALDRAK ; id 301 LavaMan
    dw MONSTER_METALDRAK ; id 302 IceMan
    dw $fe08 ; id 303 Mimic family 8
    dw $fe08 ; id 304 Exaucers family 8
    dw MONSTER_GOOPI ; id 305 MudDoll
    dw MONSTER_MUDDOLL ; id 306 Golem
    dw MONSTER_GOLEM ; id 307 StoneMan
    dw MONSTER_SPIKYBOY ; id 308 BombCrag
    dw MONSTER_ICEMAN ; id 309 GoldGolem
    dw MONSTER_GOLDGOLEM ; id 310 DarkMate
    dw MONSTER_ROGUENITE ; id 311 ProtoMech
    dw MONSTER_GISMO ; id 312 CloudKing
    dw $fefe ; id 313 ? none
    dw $fefe ; id 314 ? none
    dw $fefe ; id 315 ? none
    dw $fe09 ; id 316 Petiteel family 9
    dw $fe09 ; id 317 Moray family 9
    dw $fe09 ; id 318 WalrusMan family 9
    dw $fe09 ; id 319 RayGigas family 9
    dw $fe09 ; id 320 Anemon family 9
    dw $fe09 ; id 321 Aquarella family 9
    dw $fe09 ; id 322 Merman family 9
    dw $fe09 ; id 323 Octokid family 9
    dw $fe09 ; id 324 PutreFish family 9
    dw MONSTER_PETITEEL ; id 325 Octoreach
    dw MONSTER_PETITEEL ; id 326 Angleron
    dw MONSTER_ANGLERON ; id 327 FishRider
    dw MONSTER_ANGLERON ; id 328 RushFish
    dw MONSTER_AQUARELLA ; id 329 Gamanian
    dw MONSTER_GAMANIAN ; id 330 Clawster
    dw MONSTER_CLAWSTER ; id 331 CancerMan
    dw $fe09 ; id 332 RogueWave family 9
    dw MONSTER_ROGUEWAVE ; id 333 Scallopa
    dw MONSTER_PETITEEL ; id 334 SeaHorse
    dw MONSTER_CANCERMAN ; id 335 HoodSquid
    dw MONSTER_MERMAN ; id 336 MerTiger
    dw MONSTER_CANCERMAN ; id 337 AxeShark
    dw MONSTER_OCTOREACH ; id 338 Octogon
    dw MONSTER_OCTOGON ; id 339 KingSquid
    dw MONSTER_RUSHFISH ; id 340 Digong
    dw MONSTER_HOODSQUID ; id 341 WhaleMage
    dw MONSTER_DIGONG ; id 342 Aquadon
    dw MONSTER_OCTOGON ; id 343 Octoraid
    dw $fe09 ; id 344 Grakos family 9
    dw MONSTER_GRAKOS ; id 345 Poseidon
    dw $fe09 ; id 346 Pumpoise family 9
    dw MONSTER_OCTOREACH ; id 347 Starfish
    dw $fefe ; id 348 ? none
    dw $fefe ; id 349 ? none
    dw $fefe ; id 350 ? none
    dw MONSTER_SERVANT ; id 351 DracoLord
    dw MONSTER_DRACOLORD ; id 352 DracoLord
    dw MONSTER_DRACOLORD_160 ; id 353 LordDraco
    dw MONSTER_WHITEKING ; id 354 Hargon
    dw MONSTER_JAMIRUS ; id 355 Sidoh
    dw MONSTER_SIDOH ; id 356 Genosidoh
    dw MONSTER_HARGON ; id 357 Baramos
    dw MONSTER_DRACOLORD ; id 358 Zoma
    dw MONSTER_ZOMA ; id 359 AsuraZoma
    dw MONSTER_DURRAN ; id 360 Pizzaro
    dw MONSTER_PIZZARO ; id 361 PsychoPiz
    dw MONSTER_PIZZARO ; id 362 Esterk
    dw MONSTER_ESTERK ; id 363 Mirudraas
    dw MONSTER_MIRUDRAAS ; id 364 Mirudraas
    dw MONSTER_BARAMOS ; id 365 Mudou
    dw MONSTER_MIRUDRAAS ; id 366 DeathMore
    dw MONSTER_DEATHMORE ; id 367 DeathMore
    dw MONSTER_DEATHMORE_16F ; id 368 DeathMore
    dw MONSTER_DEATHMORE_170 ; id 369 Darkdrium
    dw MONSTER_PSYCHOPIZ ; id 370 Orgodemir
    dw MONSTER_ORGODEMIR ; id 371 Orgodemir
    dw $fefe ; id 372 Darck none
    dw $fefe ; id 373 Tatsu none
    dw $fefe ; id 374 Diago none
    dw $fefe ; id 375 Samsi none
    dw $fefe ; id 376 Bazoo none
    dw $fefe ; id 377 ? none
    dw $fefe ; id 378 ? none
    dw $fefe ; id 379 ? none
    dw $fefe ; id 380 Lamia none
    dw $fefe ; id 381 Dimensaur none
    dw $fefe ; id 382 Kagebou none
    dw $fefe ; id 383 ? none

; a second copy of MonsterPedigreeTableA, paired with MonsterPedigreeTableB_Alt at $629F; the pair
; differs from A/B for 7 monsters only, and its 95 family-pair entries agree with
; FamilyPairResultTable too; no reader found (E-0211, C1)
MonsterPedigreeTableA_Alt::
    dw $fe00 ; id 0 family 0
    dw $fe00 ; id 1 DrakSlime family 0
    dw $fe00 ; id 2 SpotSlime family 0
    dw $fe00 ; id 3 WingSlime family 0
    dw $fe00 ; id 4 TreeSlime family 0
    dw $fe00 ; id 5 Snaily family 0
    dw $fe00 ; id 6 SlimeNite family 0
    dw $fe00 ; id 7 Babble family 0
    dw $fe00 ; id 8 BoxSlime family 0
    dw $fe00 ; id 9 PearlGel family 0
    dw $fefe ; id 10 Slime none
    dw $fe00 ; id 11 Healer family 0
    dw $fe00 ; id 12 FangSlime family 0
    dw $fe00 ; id 13 RockSlime family 0
    dw MONSTER_DRAKSLIME ; id 14 SlimeBorg
    dw $fe00 ; id 15 Slabbit family 0
    dw $fe00 ; id 16 KingSlime family 0
    dw $fe00 ; id 17 Metaly family 0
    dw MONSTER_METALY ; id 18 Metabble
    dw MONSTER_KINGSLIME ; id 19 SpotKing
    dw MONSTER_TREESLIME ; id 20 TropicGel
    dw MONSTER_HEALER ; id 21 MimeSlime
    dw MONSTER_MIMESLIME ; id 22 HaloSlime
    dw MONSTER_SPOTKING ; id 23 MetalKing
    dw MONSTER_METALKING ; id 24 GoldSlime
    dw MONSTER_GOLDSLIME ; id 25 GranSlime
    dw $fefe ; id 26 WonderEgg none
    dw $fefe ; id 27 Butch none
    dw $fefe ; id 28 ? none
    dw $fefe ; id 29 ? none
    dw $fefe ; id 30 ? none
    dw $fefe ; id 31 ? none
    dw $fefe ; id 32 ? none
    dw $fefe ; id 33 ? none
    dw $fefe ; id 34 ? none
    dw $fefe ; id 35 ? none
    dw $fe01 ; id 36 DragonKid family 1
    dw $fe01 ; id 37 Tortragon family 1
    dw $fe01 ; id 38 Pteranod family 1
    dw $fe01 ; id 39 Gasgon family 1
    dw $fe01 ; id 40 FairyDrak family 1
    dw $fe01 ; id 41 LizardMan family 1
    dw $fe01 ; id 42 Poisongon family 1
    dw $fe01 ; id 43 Swordgon family 1
    dw $fe01 ; id 44 Drygon family 1
    dw MONSTER_DRAGONKID ; id 45 Dragon
    dw $fe01 ; id 46 MiniDrak family 1
    dw MONSTER_GASGON ; id 47 MadDragon
    dw MONSTER_LIZARDMAN ; id 48 Rayburn
    dw $fe01 ; id 49 Chamelgon family 1
    dw $fe01 ; id 50 LizardFly family 1
    dw $fe01 ; id 51 Andreal family 1
    dw $fe01 ; id 52 KingCobra family 1
    dw $fe01 ; id 53 Vampirus family 1
    dw MONSTER_KINGCOBRA ; id 54 SnakeBat
    dw $fe01 ; id 55 Spikerous family 1
    dw MONSTER_DRAGON ; id 56 GreatDrak
    dw $fe01 ; id 57 Crestpent family 1
    dw MONSTER_CRESTPENT ; id 58 WingSnake
    dw MONSTER_WINGSNAKE ; id 59 Coatol
    dw MONSTER_ANDREAL ; id 60 Orochi
    dw $fe01 ; id 61 BattleRex family 1
    dw $fe01 ; id 62 SkyDragon family 1
    dw MONSTER_GREATDRAK ; id 63 Serpentia
    dw MONSTER_SKYDRAGON ; id 64 Divinegon
    dw MONSTER_DIVINEGON ; id 65 Orligon
    dw MONSTER_GREATDRAK ; id 66 GigaDraco
    dw $fefe ; id 67 ? none
    dw $fefe ; id 68 ? none
    dw $fefe ; id 69 ? none
    dw $fefe ; id 70 ? none
    dw $fe02 ; id 71 Tonguella family 2
    dw $fe02 ; id 72 Almiraj family 2
    dw $fe02 ; id 73 CatFly family 2
    dw $fe02 ; id 74 PillowRat family 2
    dw $fe02 ; id 75 Saccer family 2
    dw MONSTER_GRIZZLY ; id 76 GulpBeast
    dw $fe02 ; id 77 Skullroo family 2
    dw $fe02 ; id 78 WindBeast family 2
    dw $fe02 ; id 79 Beavern family 2
    dw MONSTER_SACCER ; id 80 Antbear
    dw $fe02 ; id 81 SuperTen family 2
    dw $fe02 ; id 82 IronTurt family 2
    dw $fe02 ; id 83 Mommonja family 2
    dw $fe02 ; id 84 HammerMan family 2
    dw $fe02 ; id 85 Grizzly family 2
    dw MONSTER_WILDAPE ; id 86 Yeti
    dw $fe02 ; id 87 ArrowDog family 2
    dw MONSTER_ARROWDOG ; id 88 NoctoKing
    dw $fe02 ; id 89 BeastNite family 2
    dw $fe02 ; id 90 MadGopher family 2
    dw $fe02 ; id 91 FairyRat family 2
    dw MONSTER_YETI ; id 92 Unicorn
    dw $fe02 ; id 93 Goategon family 2
    dw MONSTER_ALMIRAJ ; id 94 WildApe
    dw MONSTER_WILDAPE ; id 95 Trumpeter
    dw MONSTER_TRUMPETER ; id 96 KingLeo
    dw $fe02 ; id 97 DarkHorn family 2
    dw $fe02 ; id 98 MadCat family 2
    dw $fe02 ; id 99 BigEye family 2
    dw MONSTER_DARKHORN ; id 100 Gorago
    dw MONSTER_CATFLY ; id 101 CatMage
    dw MONSTER_SUPERTEN ; id 102 Dumbira
    dw $fefe ; id 103 ? none
    dw $fefe ; id 104 ? none
    dw $fefe ; id 105 ? none
    dw $fe03 ; id 106 Picky family 3
    dw $fe03 ; id 107 Wyvern family 3
    dw $fe03 ; id 108 BullBird family 3
    dw $fe03 ; id 109 Florajay family 3
    dw $fe03 ; id 110 DuckKite family 3
    dw $fe03 ; id 111 MadPecker family 3
    dw $fe03 ; id 112 MadRaven family 3
    dw $fe03 ; id 113 MistyWing family 3
    dw $fe03 ; id 114 AquaHawk family 3
    dw MONSTER_PICKY ; id 115 Dracky
    dw $fe03 ; id 116 KiteHawk family 3
    dw $fefe ; id 117 BigRoost none
    dw $fe03 ; id 118 StubBird family 3
    dw MONSTER_BULLBIRD ; id 119 LandOwl
    dw MONSTER_WYVERN ; id 120 MadGoose
    dw MONSTER_LANDOWL ; id 121 MadCondor
    dw MONSTER_MADPECKER ; id 122 Emyu
    dw $fe03 ; id 123 Blizzardy family 3
    dw $fe03 ; id 124 Phoenix family 3
    dw MONSTER_PHOENIX ; id 125 ZapBird
    dw MONSTER_ZAPBIRD ; id 126 Garudian
    dw $fe03 ; id 127 WhipBird family 3
    dw $fe03 ; id 128 FunkyBird family 3
    dw MONSTER_BLIZZARDY ; id 129 RainHawk
    dw MONSTER_RAINHAWK ; id 130 Azurile
    dw MONSTER_WHIPBIRD ; id 131 Shantak
    dw MONSTER_EMYU ; id 132 CragDevil
    dw $fefe ; id 133 ? none
    dw $fefe ; id 134 ? none
    dw $fefe ; id 135 ? none
    dw $fefe ; id 136 ? none
    dw $fefe ; id 137 ? none
    dw $fefe ; id 138 ? none
    dw $fefe ; id 139 ? none
    dw $fefe ; id 140 ? none
    dw $fe04 ; id 141 MadPlant family 4
    dw $fe04 ; id 142 FireWeed family 4
    dw $fe04 ; id 143 FloraMan family 4
    dw $fe04 ; id 144 WingTree family 4
    dw $fe04 ; id 145 CactiBall family 4
    dw $fe04 ; id 146 Gulpple family 4
    dw $fe04 ; id 147 Toadstool family 4
    dw $fe04 ; id 148 AmberWeed family 4
    dw $fe04 ; id 149 Slurperon family 4
    dw MONSTER_AMBERWEED ; id 150 Stubsuck
    dw $fe04 ; id 151 Oniono family 4
    dw MONSTER_MADPLANT ; id 152 DanceVegi
    dw $fe04 ; id 153 TreeBoy family 4
    dw $fe04 ; id 154 Devipine family 4
    dw $fe04 ; id 155 FaceTree family 4
    dw $fe04 ; id 156 HerbMan family 4
    dw $fe04 ; id 157 BeanMan family 4
    dw $fe04 ; id 158 EvilSeed family 4
    dw MONSTER_EVILSEED ; id 159 ManEater
    dw MONSTER_MANEATER ; id 160 Snapper
    dw MONSTER_STUBSUCK ; id 161 GhosTree
    dw $fe04 ; id 162 Rosevine family 4
    dw MONSTER_ROSEVINE ; id 163 Egdracil
    dw $fefe ; id 164 Warubou none
    dw $fefe ; id 165 Watabou none
    dw $fe04 ; id 166 Eggplaton family 4
    dw MONSTER_TREEBOY ; id 167 FooHero
    dw $fefe ; id 168 ? none
    dw $fefe ; id 169 ? none
    dw $fefe ; id 170 ? none
    dw $fefe ; id 171 ? none
    dw $fefe ; id 172 ? none
    dw $fefe ; id 173 ? none
    dw $fefe ; id 174 ? none
    dw $fefe ; id 175 ? none
    dw $fe05 ; id 176 GiantSlug family 5
    dw $fe05 ; id 177 Catapila family 5
    dw $fe05 ; id 178 Gophecada family 5
    dw $fe05 ; id 179 Butterfly family 5
    dw $fe05 ; id 180 WeedBug family 5
    dw $fe05 ; id 181 GiantWorm family 5
    dw $fe05 ; id 182 Lipsy family 5
    dw $fe05 ; id 183 StagBug family 5
    dw $fe05 ; id 184 Pyuro family 5
    dw MONSTER_GIANTSLUG ; id 185 ArmyAnt
    dw $fefe ; id 186 GoHopper none
    dw MONSTER_WEEDBUG ; id 187 TailEater
    dw MONSTER_GIANTWORM ; id 188 ArmorPede
    dw $fe05 ; id 189 Eyeder family 5
    dw MONSTER_BUTTERFLY ; id 190 GiantMoth
    dw $fe05 ; id 191 Droll family 5
    dw $fe05 ; id 192 ArmyCrab family 5
    dw MONSTER_PYURO ; id 193 MadHornet
    dw MONSTER_MADHORNET ; id 194 Belzebub
    dw MONSTER_SICKLER ; id 195 WarMantis
    dw MONSTER_STAGBUG ; id 196 HornBeet
    dw $fe05 ; id 197 Sickler family 5
    dw MONSTER_HORNBEET ; id 198 Armorpion
    dw $fe05 ; id 199 Digster family 5
    dw MONSTER_ARMORPION ; id 200 Skularach
    dw MONSTER_CATAPILA ; id 201 MultiEyes
    dw $fefe ; id 202 ? none
    dw $fefe ; id 203 ? none
    dw $fefe ; id 204 ? none
    dw $fefe ; id 205 ? none
    dw $fefe ; id 206 ? none
    dw $fefe ; id 207 ? none
    dw $fefe ; id 208 ? none
    dw $fefe ; id 209 ? none
    dw $fefe ; id 210 ? none
    dw $fe06 ; id 211 Pixy family 6
    dw $fe06 ; id 212 MedusaEye family 6
    dw MONSTER_GREMLIN ; id 213 AgDevil
    dw $fe06 ; id 214 Demonite family 6
    dw $fe06 ; id 215 DarkEye family 6
    dw $fe06 ; id 216 EyeBall family 6
    dw $fe06 ; id 217 SkulRider family 6
    dw $fe06 ; id 218 EvilBeast family 6
    dw $fe06 ; id 219 Bubblemon family 6
    dw MONSTER_EYEBALL ; id 220 1EyeClown
    dw $fe06 ; id 221 Gremlin family 6
    dw MONSTER_OGRE ; id 222 ArcDemon
    dw $fe06 ; id 223 Lionex family 6
    dw MONSTER_ARCDEMON ; id 224 GoatHorn
    dw $fe06 ; id 225 Orc family 6
    dw $fe06 ; id 226 Ogre family 6
    dw MONSTER_DEMONITE ; id 227 GateGuard
    dw MONSTER_1EYECLOWN ; id 228 ChopClown
    dw MONSTER_GOATHORN ; id 229 BossTroll
    dw $fe06 ; id 230 Grendal family 6
    dw MONSTER_GRENDAL ; id 231 Akubar
    dw $fe06 ; id 232 MadKnight family 6
    dw MONSTER_BOSSTROLL ; id 233 EvilWell
    dw MONSTER_EVILBEAST ; id 234 Gigantes
    dw MONSTER_OGRE ; id 235 Centasaur
    dw $fe06 ; id 236 EvilArmor family 6
    dw MONSTER_AKUBAR ; id 237 Jamirus
    dw MONSTER_JAMIRUS ; id 238 Durran
    dw MONSTER_DURRAN ; id 239 Titanis
    dw MONSTER_CENTASAUR ; id 240 LampGenie
    dw $fefe ; id 241 ? none
    dw $fefe ; id 242 ? none
    dw $fefe ; id 243 ? none
    dw $fefe ; id 244 ? none
    dw $fefe ; id 245 ? none
    dw $fe07 ; id 246 Spooky family 7
    dw MONSTER_SKULPENT ; id 247 Skullgon
    dw MONSTER_SKULPENT ; id 248 PutrePup
    dw $fe07 ; id 249 RotRaven family 7
    dw $fe07 ; id 250 Mummy family 7
    dw $fe07 ; id 251 DarkCrab family 7
    dw $fe07 ; id 252 DeadNite family 7
    dw $fe07 ; id 253 Shadow family 7
    dw $fe07 ; id 254 Skulpent family 7
    dw MONSTER_SPOOKY ; id 255 Hork
    dw $fe07 ; id 256 Mudron family 7
    dw $fe07 ; id 257 NiteWhip family 7
    dw $fe07 ; id 258 WindMerge family 7
    dw MONSTER_SPOOKY ; id 259 Reaper
    dw MONSTER_HORK ; id 260 Inverzon
    dw MONSTER_NITEWHIP ; id 261 FoxFire
    dw MONSTER_BONESLAVE ; id 262 CaptDead
    dw MONSTER_DEADNITE ; id 263 DeadNoble
    dw MONSTER_DEADNOBLE ; id 264 WhiteKing
    dw MONSTER_MUMMY ; id 265 BoneSlave
    dw MONSTER_BONESLAVE ; id 266 Skeletor
    dw MONSTER_SKELETOR ; id 267 Servant
    dw MONSTER_WHITEKING ; id 268 Lazamanus
    dw $fefe ; id 269 Copycat none
    dw $fe07 ; id 270 MadSpirit family 7
    dw MONSTER_COPYCAT ; id 271 PomPomBom
    dw MONSTER_SKELETOR ; id 272 Niterich
    dw $fefe ; id 273 ? none
    dw $fefe ; id 274 ? none
    dw $fefe ; id 275 ? none
    dw $fefe ; id 276 ? none
    dw $fefe ; id 277 ? none
    dw $fefe ; id 278 ? none
    dw $fefe ; id 279 ? none
    dw $fefe ; id 280 ? none
    dw $fe08 ; id 281 JewelBag family 8
    dw $fe08 ; id 282 EvilWand family 8
    dw $fe08 ; id 283 MadCandle family 8
    dw $fe08 ; id 284 CoilBird family 8
    dw $fe08 ; id 285 Facer family 8
    dw $fe08 ; id 286 SpikyBoy family 8
    dw $fe08 ; id 287 MadMirror family 8
    dw $fe08 ; id 288 RogueNite family 8
    dw $fe08 ; id 289 Puppetor family 8
    dw MONSTER_JEWELBAG ; id 290 Goopi
    dw MONSTER_PUPPETOR ; id 291 Voodoll
    dw $fe08 ; id 292 MetalDrak family 8
    dw $fe08 ; id 293 Balzak family 8
    dw $fe08 ; id 294 SabreMan family 8
    dw $fe08 ; id 295 CurseLamp family 8
    dw $fe08 ; id 296 Brushead family 8
    dw MONSTER_SABREMAN ; id 297 Roboster
    dw MONSTER_ROBOSTER ; id 298 Roboster2
    dw $fe08 ; id 299 EvilPot family 8
    dw MONSTER_MADCANDLE ; id 300 Gismo
    dw MONSTER_METALDRAK ; id 301 LavaMan
    dw MONSTER_METALDRAK ; id 302 IceMan
    dw $fe08 ; id 303 Mimic family 8
    dw $fe08 ; id 304 Exaucers family 8
    dw MONSTER_GOOPI ; id 305 MudDoll
    dw MONSTER_MUDDOLL ; id 306 Golem
    dw MONSTER_GOLEM ; id 307 StoneMan
    dw MONSTER_SPIKYBOY ; id 308 BombCrag
    dw MONSTER_ICEMAN ; id 309 GoldGolem
    dw MONSTER_GOLDGOLEM ; id 310 DarkMate
    dw MONSTER_ROGUENITE ; id 311 ProtoMech
    dw MONSTER_GISMO ; id 312 CloudKing
    dw $fefe ; id 313 ? none
    dw $fefe ; id 314 ? none
    dw $fefe ; id 315 ? none
    dw $fe09 ; id 316 Petiteel family 9
    dw $fe09 ; id 317 Moray family 9
    dw $fe09 ; id 318 WalrusMan family 9
    dw $fe09 ; id 319 RayGigas family 9
    dw $fe09 ; id 320 Anemon family 9
    dw $fe09 ; id 321 Aquarella family 9
    dw $fe09 ; id 322 Merman family 9
    dw $fe09 ; id 323 Octokid family 9
    dw $fe09 ; id 324 PutreFish family 9
    dw MONSTER_PETITEEL ; id 325 Octoreach
    dw MONSTER_PETITEEL ; id 326 Angleron
    dw MONSTER_ANGLERON ; id 327 FishRider
    dw MONSTER_ANGLERON ; id 328 RushFish
    dw MONSTER_AQUARELLA ; id 329 Gamanian
    dw MONSTER_GAMANIAN ; id 330 Clawster
    dw MONSTER_CLAWSTER ; id 331 CancerMan
    dw $fe09 ; id 332 RogueWave family 9
    dw MONSTER_ROGUEWAVE ; id 333 Scallopa
    dw MONSTER_PETITEEL ; id 334 SeaHorse
    dw MONSTER_CANCERMAN ; id 335 HoodSquid
    dw MONSTER_MERMAN ; id 336 MerTiger
    dw MONSTER_CANCERMAN ; id 337 AxeShark
    dw MONSTER_OCTOREACH ; id 338 Octogon
    dw MONSTER_OCTOGON ; id 339 KingSquid
    dw MONSTER_RUSHFISH ; id 340 Digong
    dw MONSTER_HOODSQUID ; id 341 WhaleMage
    dw MONSTER_DIGONG ; id 342 Aquadon
    dw MONSTER_OCTOGON ; id 343 Octoraid
    dw $fe09 ; id 344 Grakos family 9
    dw MONSTER_GRAKOS ; id 345 Poseidon
    dw $fe09 ; id 346 Pumpoise family 9
    dw MONSTER_OCTOREACH ; id 347 Starfish
    dw $fefe ; id 348 ? none
    dw $fefe ; id 349 ? none
    dw $fefe ; id 350 ? none
    dw MONSTER_SERVANT ; id 351 DracoLord
    dw MONSTER_DRACOLORD ; id 352 DracoLord
    dw MONSTER_DRACOLORD_160 ; id 353 LordDraco
    dw MONSTER_WHITEKING ; id 354 Hargon
    dw MONSTER_JAMIRUS ; id 355 Sidoh
    dw MONSTER_SIDOH ; id 356 Genosidoh
    dw MONSTER_HARGON ; id 357 Baramos
    dw MONSTER_DRACOLORD ; id 358 Zoma
    dw MONSTER_ZOMA ; id 359 AsuraZoma
    dw MONSTER_DURRAN ; id 360 Pizzaro
    dw MONSTER_PIZZARO ; id 361 PsychoPiz
    dw MONSTER_PIZZARO ; id 362 Esterk
    dw MONSTER_ESTERK ; id 363 Mirudraas
    dw MONSTER_MIRUDRAAS ; id 364 Mirudraas
    dw MONSTER_BARAMOS ; id 365 Mudou
    dw MONSTER_MIRUDRAAS ; id 366 DeathMore
    dw MONSTER_DEATHMORE ; id 367 DeathMore
    dw MONSTER_DEATHMORE_16F ; id 368 DeathMore
    dw MONSTER_DEATHMORE_170 ; id 369 Darkdrium
    dw MONSTER_PSYCHOPIZ ; id 370 Orgodemir
    dw MONSTER_ORGODEMIR ; id 371 Orgodemir
    dw $fefe ; id 372 Darck none
    dw $fefe ; id 373 Tatsu none
    dw $fefe ; id 374 Diago none
    dw $fefe ; id 375 Samsi none
    dw $fefe ; id 376 Bazoo none
    dw $fefe ; id 377 ? none
    dw $fefe ; id 378 ? none
    dw $fefe ; id 379 ? none
    dw $fefe ; id 380 Lamia none
    dw $fefe ; id 381 Dimensaur none
    dw $fefe ; id 382 Kagebou none
    dw $fefe ; id 383 ? none

; LibraryMenu_ShowMonsterEntry_ShowPedigree takes the monster number from
; GridCellAddressFromGridCursorXAndGrid2CursorX (page base from LibraryMenu_CountSeenMonsters_Data1
; plus the grid position) and reads the word at $5F9F + 2 * number: the second word (vTiles2 + $390,
; sprite part $43); the two parents shown for the monster: for all 95 monsters whose two entries are
; families, FamilyPairResultTable (bank $0E) row A, column B gives that monster or parent A's
; species (C2 for those entries); 384 words (E-0211, C1)
MonsterPedigreeTableB::
    dw $fefe ; id 0 none
    dw $fe01 ; id 1 DrakSlime family 1
    dw $fe02 ; id 2 SpotSlime family 2
    dw $fe03 ; id 3 WingSlime family 3
    dw $fe04 ; id 4 TreeSlime family 4
    dw $fe05 ; id 5 Snaily family 5
    dw $fe06 ; id 6 SlimeNite family 6
    dw $fe07 ; id 7 Babble family 7
    dw $fe08 ; id 8 BoxSlime family 8
    dw $fe09 ; id 9 PearlGel family 9
    dw $fefe ; id 10 Slime none
    dw MONSTER_PILLOWRAT ; id 11 Healer
    dw MONSTER_ALMIRAJ ; id 12 FangSlime
    dw MONSTER_GOLEM ; id 13 RockSlime
    dw MONSTER_SWORDGON ; id 14 SlimeBorg
    dw MONSTER_SKULLROO ; id 15 Slabbit
    dw $fe0a ; id 16 KingSlime family 10
    dw MONSTER_METALDRAK ; id 17 Metaly
    dw MONSTER_METALY ; id 18 Metabble
    dw MONSTER_UNICORN ; id 19 SpotKing
    dw $fe02 ; id 20 TropicGel family 2
    dw MONSTER_1EYECLOWN ; id 21 MimeSlime
    dw $fe07 ; id 22 HaloSlime family 7
    dw MONSTER_METALDRAK ; id 23 MetalKing
    dw MONSTER_METALKING ; id 24 GoldSlime
    dw MONSTER_GOLDSLIME ; id 25 GranSlime
    dw $fefe ; id 26 WonderEgg none
    dw $fefe ; id 27 Butch none
    dw $fefe ; id 28 ? none
    dw $fefe ; id 29 ? none
    dw $fefe ; id 30 ? none
    dw $fefe ; id 31 ? none
    dw $fefe ; id 32 ? none
    dw $fefe ; id 33 ? none
    dw $fefe ; id 34 ? none
    dw $fefe ; id 35 ? none
    dw $fe00 ; id 36 DragonKid family 0
    dw $fe02 ; id 37 Tortragon family 2
    dw $fe03 ; id 38 Pteranod family 3
    dw $fe04 ; id 39 Gasgon family 4
    dw $fe05 ; id 40 FairyDrak family 5
    dw $fe06 ; id 41 LizardMan family 6
    dw $fe07 ; id 42 Poisongon family 7
    dw $fe08 ; id 43 Swordgon family 8
    dw $fe09 ; id 44 Drygon family 9
    dw MONSTER_DRAGONKID ; id 45 Dragon
    dw MONSTER_PICKY ; id 46 MiniDrak
    dw $fe02 ; id 47 MadDragon family 2
    dw MONSTER_WINGSLIME ; id 48 Rayburn
    dw MONSTER_VOODOLL ; id 49 Chamelgon
    dw MONSTER_GOHOPPER ; id 50 LizardFly
    dw MONSTER_GULPPLE ; id 51 Andreal
    dw MONSTER_BABBLE ; id 52 KingCobra
    dw MONSTER_MADGOOSE ; id 53 Vampirus
    dw MONSTER_DRACKY ; id 54 SnakeBat
    dw MONSTER_ARMYCRAB ; id 55 Spikerous
    dw MONSTER_DRAGON ; id 56 GreatDrak
    dw MONSTER_BIGROOST ; id 57 Crestpent
    dw MONSTER_CRESTPENT ; id 58 WingSnake
    dw MONSTER_WINGSNAKE ; id 59 Coatol
    dw MONSTER_MEDUSAEYE ; id 60 Orochi
    dw MONSTER_MADKNIGHT ; id 61 BattleRex
    dw MONSTER_PHOENIX ; id 62 SkyDragon
    dw MONSTER_LIONEX ; id 63 Serpentia
    dw MONSTER_OROCHI ; id 64 Divinegon
    dw MONSTER_GOLDGOLEM ; id 65 Orligon
    dw MONSTER_GIGANTES ; id 66 GigaDraco
    dw $fefe ; id 67 ? none
    dw $fefe ; id 68 ? none
    dw $fefe ; id 69 ? none
    dw $fefe ; id 70 ? none
    dw $fe00 ; id 71 Tonguella family 0
    dw $fe01 ; id 72 Almiraj family 1
    dw $fe03 ; id 73 CatFly family 3
    dw $fe04 ; id 74 PillowRat family 4
    dw $fe05 ; id 75 Saccer family 5
    dw $fe01 ; id 76 GulpBeast family 1
    dw $fe07 ; id 77 Skullroo family 7
    dw $fe08 ; id 78 WindBeast family 8
    dw $fe09 ; id 79 Beavern family 9
    dw $fe01 ; id 80 Antbear family 1
    dw MONSTER_DEMONITE ; id 81 SuperTen
    dw MONSTER_TORTRAGON ; id 82 IronTurt
    dw MONSTER_DUCKKITE ; id 83 Mommonja
    dw MONSTER_STUBSUCK ; id 84 HammerMan
    dw $fe06 ; id 85 Grizzly family 6
    dw MONSTER_SWORDGON ; id 86 Yeti
    dw MONSTER_PUTREPUP ; id 87 ArrowDog
    dw MONSTER_SHADOW ; id 88 NoctoKing
    dw MONSTER_EVILARMOR ; id 89 BeastNite
    dw MONSTER_SABREMAN ; id 90 MadGopher
    dw MONSTER_LIZARDFLY ; id 91 FairyRat
    dw $fe00 ; id 92 Unicorn family 0
    dw MONSTER_LIZARDMAN ; id 93 Goategon
    dw $fe01 ; id 94 WildApe family 1
    dw MONSTER_WILDAPE ; id 95 Trumpeter
    dw MONSTER_TRUMPETER ; id 96 KingLeo
    dw $fe0a ; id 97 DarkHorn family 10
    dw MONSTER_DRAGON ; id 98 MadCat
    dw MONSTER_EYEBALL ; id 99 BigEye
    dw MONSTER_OROCHI ; id 100 Gorago
    dw MONSTER_TREEBOY ; id 101 CatMage
    dw MONSTER_SABREMAN ; id 102 Dumbira
    dw $fefe ; id 103 ? none
    dw $fefe ; id 104 ? none
    dw $fefe ; id 105 ? none
    dw $fe00 ; id 106 Picky family 0
    dw $fe01 ; id 107 Wyvern family 1
    dw $fe02 ; id 108 BullBird family 2
    dw $fe04 ; id 109 Florajay family 4
    dw $fe05 ; id 110 DuckKite family 5
    dw $fe06 ; id 111 MadPecker family 6
    dw $fe07 ; id 112 MadRaven family 7
    dw $fe08 ; id 113 MistyWing family 8
    dw $fe09 ; id 114 AquaHawk family 9
    dw $fe00 ; id 115 Dracky family 0
    dw $fe08 ; id 116 KiteHawk family 8
    dw $fefe ; id 117 BigRoost none
    dw MONSTER_ROCKSLIME ; id 118 StubBird
    dw $fe06 ; id 119 LandOwl family 6
    dw $fe07 ; id 120 MadGoose family 7
    dw $fe06 ; id 121 MadCondor family 6
    dw MONSTER_DARKEYE ; id 122 Emyu
    dw MONSTER_METALY ; id 123 Blizzardy
    dw MONSTER_DRAKSLIME ; id 124 Phoenix
    dw MONSTER_GISMO ; id 125 ZapBird
    dw MONSTER_LIONEX ; id 126 Garudian
    dw MONSTER_RAYBURN ; id 127 WhipBird
    dw MONSTER_DANCEVEGI ; id 128 FunkyBird
    dw MONSTER_PHOENIX ; id 129 RainHawk
    dw $fe0a ; id 130 Azurile family 10
    dw MONSTER_GREATDRAK ; id 131 Shantak
    dw $fe02 ; id 132 CragDevil family 2
    dw $fefe ; id 133 ? none
    dw $fefe ; id 134 ? none
    dw $fefe ; id 135 ? none
    dw $fefe ; id 136 ? none
    dw $fefe ; id 137 ? none
    dw $fefe ; id 138 ? none
    dw $fefe ; id 139 ? none
    dw $fefe ; id 140 ? none
    dw $fe00 ; id 141 MadPlant family 0
    dw $fe01 ; id 142 FireWeed family 1
    dw $fe02 ; id 143 FloraMan family 2
    dw $fe03 ; id 144 WingTree family 3
    dw $fe05 ; id 145 CactiBall family 5
    dw $fe06 ; id 146 Gulpple family 6
    dw $fe07 ; id 147 Toadstool family 7
    dw $fe08 ; id 148 AmberWeed family 8
    dw $fe09 ; id 149 Slurperon family 9
    dw $fe02 ; id 150 Stubsuck family 2
    dw MONSTER_ANEMON ; id 151 Oniono
    dw MONSTER_FACER ; id 152 DanceVegi
    dw MONSTER_PIXY ; id 153 TreeBoy
    dw MONSTER_GULPPLE ; id 154 Devipine
    dw $fe01 ; id 155 FaceTree family 1
    dw MONSTER_FUNKYBIRD ; id 156 HerbMan
    dw MONSTER_PILLOWRAT ; id 157 BeanMan
    dw MONSTER_ROCKSLIME ; id 158 EvilSeed
    dw MONSTER_EVILSEED ; id 159 ManEater
    dw MONSTER_MANEATER ; id 160 Snapper
    dw $fe07 ; id 161 GhosTree family 7
    dw $fe0a ; id 162 Rosevine family 10
    dw MONSTER_GIGANTES ; id 163 Egdracil
    dw $fefe ; id 164 Warubou none
    dw $fefe ; id 165 Watabou none
    dw MONSTER_LIPSY ; id 166 Eggplaton
    dw MONSTER_SLIMENITE ; id 167 FooHero
    dw $fefe ; id 168 ? none
    dw $fefe ; id 169 ? none
    dw $fefe ; id 170 ? none
    dw $fefe ; id 171 ? none
    dw $fefe ; id 172 ? none
    dw $fefe ; id 173 ? none
    dw $fefe ; id 174 ? none
    dw $fefe ; id 175 ? none
    dw $fe00 ; id 176 GiantSlug family 0
    dw $fe01 ; id 177 Catapila family 1
    dw $fe02 ; id 178 Gophecada family 2
    dw $fe03 ; id 179 Butterfly family 3
    dw $fe04 ; id 180 WeedBug family 4
    dw $fe06 ; id 181 GiantWorm family 6
    dw $fe07 ; id 182 Lipsy family 7
    dw $fe08 ; id 183 StagBug family 8
    dw $fe09 ; id 184 Pyuro family 9
    dw $fe00 ; id 185 ArmyAnt family 0
    dw $fefe ; id 186 GoHopper none
    dw $fe04 ; id 187 TailEater family 4
    dw $fe08 ; id 188 ArmorPede family 8
    dw MONSTER_GAMANIAN ; id 189 Eyeder
    dw $fe06 ; id 190 GiantMoth family 6
    dw MONSTER_SPOOKY ; id 191 Droll
    dw MONSTER_DARKCRAB ; id 192 ArmyCrab
    dw $fe07 ; id 193 MadHornet family 7
    dw $fe07 ; id 194 Belzebub family 7
    dw $fe06 ; id 195 WarMantis family 6
    dw MONSTER_STAGBUG ; id 196 HornBeet
    dw MONSTER_1EYECLOWN ; id 197 Sickler
    dw MONSTER_HORNBEET ; id 198 Armorpion
    dw $fe0a ; id 199 Digster family 10
    dw MONSTER_WHITEKING ; id 200 Skularach
    dw MONSTER_CATAPILA ; id 201 MultiEyes
    dw $fefe ; id 202 ? none
    dw $fefe ; id 203 ? none
    dw $fefe ; id 204 ? none
    dw $fefe ; id 205 ? none
    dw $fefe ; id 206 ? none
    dw $fefe ; id 207 ? none
    dw $fefe ; id 208 ? none
    dw $fefe ; id 209 ? none
    dw $fefe ; id 210 ? none
    dw $fe00 ; id 211 Pixy family 0
    dw $fe01 ; id 212 MedusaEye family 1
    dw $fe01 ; id 213 AgDevil family 1
    dw $fe03 ; id 214 Demonite family 3
    dw $fe04 ; id 215 DarkEye family 4
    dw $fe05 ; id 216 EyeBall family 5
    dw $fe07 ; id 217 SkulRider family 7
    dw $fe08 ; id 218 EvilBeast family 8
    dw $fe09 ; id 219 Bubblemon family 9
    dw $fe00 ; id 220 1EyeClown family 0
    dw $fe02 ; id 221 Gremlin family 2
    dw $fe01 ; id 222 ArcDemon family 1
    dw MONSTER_LIZARDMAN ; id 223 Lionex
    dw $fe02 ; id 224 GoatHorn family 2
    dw MONSTER_BEANMAN ; id 225 Orc
    dw MONSTER_HAMMERMAN ; id 226 Ogre
    dw MONSTER_DEMONITE ; id 227 GateGuard
    dw MONSTER_1EYECLOWN ; id 228 ChopClown
    dw $fe02 ; id 229 BossTroll family 2
    dw MONSTER_BEASTNITE ; id 230 Grendal
    dw MONSTER_GRENDAL ; id 231 Akubar
    dw MONSTER_ROGUENITE ; id 232 MadKnight
    dw MONSTER_ICEMAN ; id 233 EvilWell
    dw $fe07 ; id 234 Gigantes family 7
    dw $fe02 ; id 235 Centasaur family 2
    dw MONSTER_ARMORPEDE ; id 236 EvilArmor
    dw MONSTER_RAINHAWK ; id 237 Jamirus
    dw MONSTER_SERPENTIA ; id 238 Durran
    dw MONSTER_DARKHORN ; id 239 Titanis
    dw $fe0a ; id 240 LampGenie family 10
    dw $fefe ; id 241 ? none
    dw $fefe ; id 242 ? none
    dw $fefe ; id 243 ? none
    dw $fefe ; id 244 ? none
    dw $fefe ; id 245 ? none
    dw $fe00 ; id 246 Spooky family 0
    dw $fe01 ; id 247 Skullgon family 1
    dw $fe02 ; id 248 PutrePup family 2
    dw $fe03 ; id 249 RotRaven family 3
    dw $fe04 ; id 250 Mummy family 4
    dw $fe05 ; id 251 DarkCrab family 5
    dw $fe06 ; id 252 DeadNite family 6
    dw $fe08 ; id 253 Shadow family 8
    dw $fe09 ; id 254 Skulpent family 9
    dw $fe02 ; id 255 Hork family 2
    dw MONSTER_DROLL ; id 256 Mudron
    dw MONSTER_MISTYWING ; id 257 NiteWhip
    dw MONSTER_WINDBEAST ; id 258 WindMerge
    dw $fe06 ; id 259 Reaper family 6
    dw MONSTER_HORK ; id 260 Inverzon
    dw $fe02 ; id 261 FoxFire family 2
    dw $fe09 ; id 262 CaptDead family 9
    dw MONSTER_DEADNITE ; id 263 DeadNoble
    dw MONSTER_SPOTKING ; id 264 WhiteKing
    dw MONSTER_FLORAMAN ; id 265 BoneSlave
    dw MONSTER_BONESLAVE ; id 266 Skeletor
    dw MONSTER_SKELETOR ; id 267 Servant
    dw MONSTER_DRACOLORD ; id 268 Lazamanus
    dw $fefe ; id 269 Copycat none
    dw $fe01 ; id 270 MadSpirit family 1
    dw MONSTER_GASGON ; id 271 PomPomBom
    dw MONSTER_ROBOSTER2 ; id 272 Niterich
    dw $fefe ; id 273 ? none
    dw $fefe ; id 274 ? none
    dw $fefe ; id 275 ? none
    dw $fefe ; id 276 ? none
    dw $fefe ; id 277 ? none
    dw $fefe ; id 278 ? none
    dw $fefe ; id 279 ? none
    dw $fefe ; id 280 ? none
    dw $fe00 ; id 281 JewelBag family 0
    dw $fe01 ; id 282 EvilWand family 1
    dw $fe02 ; id 283 MadCandle family 2
    dw $fe03 ; id 284 CoilBird family 3
    dw $fe04 ; id 285 Facer family 4
    dw $fe05 ; id 286 SpikyBoy family 5
    dw $fe06 ; id 287 MadMirror family 6
    dw $fe07 ; id 288 RogueNite family 7
    dw MONSTER_GREMLIN ; id 289 Puppetor
    dw $fe08 ; id 290 Goopi family 8
    dw $fe06 ; id 291 Voodoll family 6
    dw MONSTER_ANDREAL ; id 292 MetalDrak
    dw $fe0a ; id 293 Balzak family 10
    dw MONSTER_GIANTWORM ; id 294 SabreMan
    dw MONSTER_WINGTREE ; id 295 CurseLamp
    dw $fe09 ; id 296 Brushead family 9
    dw MONSTER_SLIMEBORG ; id 297 Roboster
    dw MONSTER_ROBOSTER ; id 298 Roboster2
    dw MONSTER_SNAILY ; id 299 EvilPot
    dw MONSTER_WYVERN ; id 300 Gismo
    dw MONSTER_ZAPBIRD ; id 301 LavaMan
    dw MONSTER_SKULLGON ; id 302 IceMan
    dw MONSTER_BOXSLIME ; id 303 Mimic
    dw MONSTER_DRACKY ; id 304 Exaucers
    dw MONSTER_GOOPI ; id 305 MudDoll
    dw MONSTER_MUDDOLL ; id 306 Golem
    dw MONSTER_GOLEM ; id 307 StoneMan
    dw MONSTER_SPIKYBOY ; id 308 BombCrag
    dw MONSTER_LAVAMAN ; id 309 GoldGolem
    dw MONSTER_METALKING ; id 310 DarkMate
    dw $fe06 ; id 311 ProtoMech family 6
    dw MONSTER_SKYDRAGON ; id 312 CloudKing
    dw $fefe ; id 313 ? none
    dw $fefe ; id 314 ? none
    dw $fefe ; id 315 ? none
    dw $fe00 ; id 316 Petiteel family 0
    dw $fe01 ; id 317 Moray family 1
    dw $fe02 ; id 318 WalrusMan family 2
    dw $fe03 ; id 319 RayGigas family 3
    dw $fe04 ; id 320 Anemon family 4
    dw $fe05 ; id 321 Aquarella family 5
    dw $fe06 ; id 322 Merman family 6
    dw $fe08 ; id 323 Octokid family 8
    dw $fe07 ; id 324 PutreFish family 7
    dw $fe02 ; id 325 Octoreach family 2
    dw $fe08 ; id 326 Angleron family 8
    dw MONSTER_SKULRIDER ; id 327 FishRider
    dw $fe01 ; id 328 RushFish family 1
    dw $fe05 ; id 329 Gamanian family 5
    dw MONSTER_ARMYCRAB ; id 330 Clawster
    dw MONSTER_CLAWSTER ; id 331 CancerMan
    dw MONSTER_JEWELBAG ; id 332 RogueWave
    dw $fe06 ; id 333 Scallopa family 6
    dw $fe01 ; id 334 SeaHorse family 1
    dw MONSTER_WHALEMAGE ; id 335 HoodSquid
    dw MONSTER_MADCAT ; id 336 MerTiger
    dw MONSTER_BATTLEREX ; id 337 AxeShark
    dw MONSTER_OCTOREACH ; id 338 Octogon
    dw MONSTER_OCTOGON ; id 339 KingSquid
    dw MONSTER_SPIKEROUS ; id 340 Digong
    dw MONSTER_1EYECLOWN ; id 341 WhaleMage
    dw MONSTER_GREATDRAK ; id 342 Aquadon
    dw MONSTER_LIONEX ; id 343 Octoraid
    dw $fe0a ; id 344 Grakos family 10
    dw MONSTER_MUDOU ; id 345 Poseidon
    dw MONSTER_SPIKYBOY ; id 346 Pumpoise
    dw $fe00 ; id 347 Starfish family 0
    dw $fefe ; id 348 ? none
    dw $fefe ; id 349 ? none
    dw $fefe ; id 350 ? none
    dw MONSTER_ANDREAL ; id 351 DracoLord
    dw MONSTER_DIVINEGON ; id 352 DracoLord
    dw MONSTER_ORLIGON ; id 353 LordDraco
    dw MONSTER_METALKING ; id 354 Hargon
    dw MONSTER_ROSEVINE ; id 355 Sidoh
    dw MONSTER_TITANIS ; id 356 Genosidoh
    dw MONSTER_OROCHI ; id 357 Baramos
    dw MONSTER_SIDOH ; id 358 Zoma
    dw MONSTER_PSYCHOPIZ ; id 359 AsuraZoma
    dw MONSTER_DIVINEGON ; id 360 Pizzaro
    dw MONSTER_ESTERK ; id 361 PsychoPiz
    dw MONSTER_GORAGO ; id 362 Esterk
    dw MONSTER_GOLDSLIME ; id 363 Mirudraas
    dw MONSTER_ORLIGON ; id 364 Mirudraas
    dw MONSTER_GORAGO ; id 365 Mudou
    dw MONSTER_AZURILE ; id 366 DeathMore
    dw MONSTER_TITANIS ; id 367 DeathMore
    dw MONSTER_DARKMATE ; id 368 DeathMore
    dw MONSTER_GRANSLIME ; id 369 Darkdrium
    dw MONSTER_NITERICH ; id 370 Orgodemir
    dw MONSTER_LORDDRACO ; id 371 Orgodemir
    dw $fefe ; id 372 Darck none
    dw $fefe ; id 373 Tatsu none
    dw $fefe ; id 374 Diago none
    dw $fefe ; id 375 Samsi none
    dw $fefe ; id 376 Bazoo none
    dw $fefe ; id 377 ? none
    dw $fefe ; id 378 ? none
    dw $fefe ; id 379 ? none
    dw $fefe ; id 380 Lamia none
    dw $fefe ; id 381 Dimensaur none
    dw $fefe ; id 382 Kagebou none
    dw $fefe ; id 383 ? none

; the partner of MonsterPedigreeTableA_Alt, a variant of MonsterPedigreeTableB; 384 words end at
; ArenaMenu ($659F); no reader found (E-0211, C1)
MonsterPedigreeTableB_Alt::
    dw $fefe ; id 0 none
    dw $fe01 ; id 1 DrakSlime family 1
    dw $fe02 ; id 2 SpotSlime family 2
    dw $fe03 ; id 3 WingSlime family 3
    dw $fe04 ; id 4 TreeSlime family 4
    dw $fe05 ; id 5 Snaily family 5
    dw $fe06 ; id 6 SlimeNite family 6
    dw $fe07 ; id 7 Babble family 7
    dw $fe08 ; id 8 BoxSlime family 8
    dw $fe09 ; id 9 PearlGel family 9
    dw $fefe ; id 10 Slime none
    dw MONSTER_PILLOWRAT ; id 11 Healer
    dw MONSTER_ALMIRAJ ; id 12 FangSlime
    dw MONSTER_GOLEM ; id 13 RockSlime
    dw MONSTER_SWORDGON ; id 14 SlimeBorg
    dw MONSTER_SKULLROO ; id 15 Slabbit
    dw $fe0a ; id 16 KingSlime family 10
    dw MONSTER_METALDRAK ; id 17 Metaly
    dw MONSTER_METALY ; id 18 Metabble
    dw MONSTER_UNICORN ; id 19 SpotKing
    dw $fe02 ; id 20 TropicGel family 2
    dw MONSTER_1EYECLOWN ; id 21 MimeSlime
    dw $fe07 ; id 22 HaloSlime family 7
    dw MONSTER_METALDRAK ; id 23 MetalKing
    dw MONSTER_METALKING ; id 24 GoldSlime
    dw MONSTER_GOLDSLIME ; id 25 GranSlime
    dw $fefe ; id 26 WonderEgg none
    dw $fefe ; id 27 Butch none
    dw $fefe ; id 28 ? none
    dw $fefe ; id 29 ? none
    dw $fefe ; id 30 ? none
    dw $fefe ; id 31 ? none
    dw $fefe ; id 32 ? none
    dw $fefe ; id 33 ? none
    dw $fefe ; id 34 ? none
    dw $fefe ; id 35 ? none
    dw $fe00 ; id 36 DragonKid family 0
    dw $fe02 ; id 37 Tortragon family 2
    dw $fe03 ; id 38 Pteranod family 3
    dw $fe04 ; id 39 Gasgon family 4
    dw $fe05 ; id 40 FairyDrak family 5
    dw $fe06 ; id 41 LizardMan family 6
    dw $fe07 ; id 42 Poisongon family 7
    dw $fe08 ; id 43 Swordgon family 8
    dw $fe09 ; id 44 Drygon family 9
    dw MONSTER_DRAGONKID ; id 45 Dragon
    dw MONSTER_PICKY ; id 46 MiniDrak
    dw $fe02 ; id 47 MadDragon family 2
    dw MONSTER_WINGSLIME ; id 48 Rayburn
    dw MONSTER_VOODOLL ; id 49 Chamelgon
    dw MONSTER_GOHOPPER ; id 50 LizardFly
    dw MONSTER_GULPPLE ; id 51 Andreal
    dw MONSTER_BABBLE ; id 52 KingCobra
    dw MONSTER_MADGOOSE ; id 53 Vampirus
    dw MONSTER_DRACKY ; id 54 SnakeBat
    dw MONSTER_ARMYCRAB ; id 55 Spikerous
    dw MONSTER_DRAGON ; id 56 GreatDrak
    dw MONSTER_BIGROOST ; id 57 Crestpent
    dw MONSTER_CRESTPENT ; id 58 WingSnake
    dw MONSTER_WINGSNAKE ; id 59 Coatol
    dw MONSTER_MEDUSAEYE ; id 60 Orochi
    dw MONSTER_MADKNIGHT ; id 61 BattleRex
    dw MONSTER_PHOENIX ; id 62 SkyDragon
    dw MONSTER_LIONEX ; id 63 Serpentia
    dw MONSTER_OROCHI ; id 64 Divinegon
    dw MONSTER_GOLDGOLEM ; id 65 Orligon
    dw MONSTER_GIGANTES ; id 66 GigaDraco
    dw $fefe ; id 67 ? none
    dw $fefe ; id 68 ? none
    dw $fefe ; id 69 ? none
    dw $fefe ; id 70 ? none
    dw $fe00 ; id 71 Tonguella family 0
    dw $fe01 ; id 72 Almiraj family 1
    dw $fe03 ; id 73 CatFly family 3
    dw $fe04 ; id 74 PillowRat family 4
    dw $fe05 ; id 75 Saccer family 5
    dw $fe01 ; id 76 GulpBeast family 1
    dw $fe07 ; id 77 Skullroo family 7
    dw $fe08 ; id 78 WindBeast family 8
    dw $fe09 ; id 79 Beavern family 9
    dw $fe01 ; id 80 Antbear family 1
    dw MONSTER_MUDRON ; id 81 SuperTen
    dw MONSTER_TORTRAGON ; id 82 IronTurt
    dw MONSTER_DUCKKITE ; id 83 Mommonja
    dw MONSTER_STUBSUCK ; id 84 HammerMan
    dw $fe06 ; id 85 Grizzly family 6
    dw MONSTER_SWORDGON ; id 86 Yeti
    dw MONSTER_PUTREPUP ; id 87 ArrowDog
    dw MONSTER_SHADOW ; id 88 NoctoKing
    dw MONSTER_EVILARMOR ; id 89 BeastNite
    dw MONSTER_SABREMAN ; id 90 MadGopher
    dw MONSTER_LIZARDFLY ; id 91 FairyRat
    dw $fe00 ; id 92 Unicorn family 0
    dw MONSTER_LIZARDMAN ; id 93 Goategon
    dw $fe01 ; id 94 WildApe family 1
    dw MONSTER_WILDAPE ; id 95 Trumpeter
    dw MONSTER_TRUMPETER ; id 96 KingLeo
    dw $fe0a ; id 97 DarkHorn family 10
    dw MONSTER_DRAGON ; id 98 MadCat
    dw MONSTER_EYEBALL ; id 99 BigEye
    dw MONSTER_OROCHI ; id 100 Gorago
    dw MONSTER_TREEBOY ; id 101 CatMage
    dw MONSTER_SABREMAN ; id 102 Dumbira
    dw $fefe ; id 103 ? none
    dw $fefe ; id 104 ? none
    dw $fefe ; id 105 ? none
    dw $fe00 ; id 106 Picky family 0
    dw $fe01 ; id 107 Wyvern family 1
    dw $fe02 ; id 108 BullBird family 2
    dw $fe04 ; id 109 Florajay family 4
    dw $fe05 ; id 110 DuckKite family 5
    dw $fe06 ; id 111 MadPecker family 6
    dw $fe07 ; id 112 MadRaven family 7
    dw $fe08 ; id 113 MistyWing family 8
    dw $fe09 ; id 114 AquaHawk family 9
    dw $fe00 ; id 115 Dracky family 0
    dw MONSTER_FACER ; id 116 KiteHawk
    dw $fefe ; id 117 BigRoost none
    dw MONSTER_ROCKSLIME ; id 118 StubBird
    dw $fe06 ; id 119 LandOwl family 6
    dw $fe07 ; id 120 MadGoose family 7
    dw $fe06 ; id 121 MadCondor family 6
    dw MONSTER_DARKEYE ; id 122 Emyu
    dw MONSTER_METALY ; id 123 Blizzardy
    dw MONSTER_DRAKSLIME ; id 124 Phoenix
    dw MONSTER_GISMO ; id 125 ZapBird
    dw MONSTER_LIONEX ; id 126 Garudian
    dw MONSTER_RAYBURN ; id 127 WhipBird
    dw MONSTER_BRUSHEAD ; id 128 FunkyBird
    dw MONSTER_PHOENIX ; id 129 RainHawk
    dw $fe0a ; id 130 Azurile family 10
    dw MONSTER_GREATDRAK ; id 131 Shantak
    dw $fe02 ; id 132 CragDevil family 2
    dw $fefe ; id 133 ? none
    dw $fefe ; id 134 ? none
    dw $fefe ; id 135 ? none
    dw $fefe ; id 136 ? none
    dw $fefe ; id 137 ? none
    dw $fefe ; id 138 ? none
    dw $fefe ; id 139 ? none
    dw $fefe ; id 140 ? none
    dw $fe00 ; id 141 MadPlant family 0
    dw $fe01 ; id 142 FireWeed family 1
    dw $fe02 ; id 143 FloraMan family 2
    dw $fe03 ; id 144 WingTree family 3
    dw $fe05 ; id 145 CactiBall family 5
    dw $fe06 ; id 146 Gulpple family 6
    dw $fe07 ; id 147 Toadstool family 7
    dw $fe08 ; id 148 AmberWeed family 8
    dw $fe09 ; id 149 Slurperon family 9
    dw $fe02 ; id 150 Stubsuck family 2
    dw MONSTER_GOPHECADA ; id 151 Oniono
    dw $fe02 ; id 152 DanceVegi family 2
    dw MONSTER_PIXY ; id 153 TreeBoy
    dw MONSTER_GULPPLE ; id 154 Devipine
    dw MONSTER_NITEWHIP ; id 155 FaceTree
    dw MONSTER_FUNKYBIRD ; id 156 HerbMan
    dw MONSTER_PILLOWRAT ; id 157 BeanMan
    dw MONSTER_ROCKSLIME ; id 158 EvilSeed
    dw MONSTER_EVILSEED ; id 159 ManEater
    dw MONSTER_MANEATER ; id 160 Snapper
    dw $fe07 ; id 161 GhosTree family 7
    dw $fe0a ; id 162 Rosevine family 10
    dw MONSTER_GIGANTES ; id 163 Egdracil
    dw $fefe ; id 164 Warubou none
    dw $fefe ; id 165 Watabou none
    dw MONSTER_LIPSY ; id 166 Eggplaton
    dw MONSTER_SLIMENITE ; id 167 FooHero
    dw $fefe ; id 168 ? none
    dw $fefe ; id 169 ? none
    dw $fefe ; id 170 ? none
    dw $fefe ; id 171 ? none
    dw $fefe ; id 172 ? none
    dw $fefe ; id 173 ? none
    dw $fefe ; id 174 ? none
    dw $fefe ; id 175 ? none
    dw $fe00 ; id 176 GiantSlug family 0
    dw $fe01 ; id 177 Catapila family 1
    dw $fe02 ; id 178 Gophecada family 2
    dw $fe03 ; id 179 Butterfly family 3
    dw $fe04 ; id 180 WeedBug family 4
    dw $fe06 ; id 181 GiantWorm family 6
    dw $fe07 ; id 182 Lipsy family 7
    dw $fe08 ; id 183 StagBug family 8
    dw $fe09 ; id 184 Pyuro family 9
    dw $fe00 ; id 185 ArmyAnt family 0
    dw $fefe ; id 186 GoHopper none
    dw $fe04 ; id 187 TailEater family 4
    dw $fe08 ; id 188 ArmorPede family 8
    dw MONSTER_OCTOREACH ; id 189 Eyeder
    dw $fe06 ; id 190 GiantMoth family 6
    dw MONSTER_SPOOKY ; id 191 Droll
    dw MONSTER_DARKCRAB ; id 192 ArmyCrab
    dw $fe07 ; id 193 MadHornet family 7
    dw $fe07 ; id 194 Belzebub family 7
    dw $fe06 ; id 195 WarMantis family 6
    dw MONSTER_STAGBUG ; id 196 HornBeet
    dw MONSTER_1EYECLOWN ; id 197 Sickler
    dw MONSTER_HORNBEET ; id 198 Armorpion
    dw $fe0a ; id 199 Digster family 10
    dw MONSTER_WHITEKING ; id 200 Skularach
    dw MONSTER_CATAPILA ; id 201 MultiEyes
    dw $fefe ; id 202 ? none
    dw $fefe ; id 203 ? none
    dw $fefe ; id 204 ? none
    dw $fefe ; id 205 ? none
    dw $fefe ; id 206 ? none
    dw $fefe ; id 207 ? none
    dw $fefe ; id 208 ? none
    dw $fefe ; id 209 ? none
    dw $fefe ; id 210 ? none
    dw $fe00 ; id 211 Pixy family 0
    dw $fe01 ; id 212 MedusaEye family 1
    dw $fe01 ; id 213 AgDevil family 1
    dw $fe03 ; id 214 Demonite family 3
    dw $fe04 ; id 215 DarkEye family 4
    dw $fe05 ; id 216 EyeBall family 5
    dw $fe07 ; id 217 SkulRider family 7
    dw $fe08 ; id 218 EvilBeast family 8
    dw $fe09 ; id 219 Bubblemon family 9
    dw $fe00 ; id 220 1EyeClown family 0
    dw $fe02 ; id 221 Gremlin family 2
    dw $fe01 ; id 222 ArcDemon family 1
    dw MONSTER_LIZARDMAN ; id 223 Lionex
    dw $fe02 ; id 224 GoatHorn family 2
    dw MONSTER_BEANMAN ; id 225 Orc
    dw MONSTER_HAMMERMAN ; id 226 Ogre
    dw MONSTER_DEMONITE ; id 227 GateGuard
    dw MONSTER_1EYECLOWN ; id 228 ChopClown
    dw $fe02 ; id 229 BossTroll family 2
    dw MONSTER_BEASTNITE ; id 230 Grendal
    dw MONSTER_GRENDAL ; id 231 Akubar
    dw MONSTER_ROGUENITE ; id 232 MadKnight
    dw MONSTER_ICEMAN ; id 233 EvilWell
    dw $fe07 ; id 234 Gigantes family 7
    dw $fe02 ; id 235 Centasaur family 2
    dw MONSTER_ARMORPEDE ; id 236 EvilArmor
    dw MONSTER_RAINHAWK ; id 237 Jamirus
    dw MONSTER_SERPENTIA ; id 238 Durran
    dw MONSTER_DARKHORN ; id 239 Titanis
    dw $fe0a ; id 240 LampGenie family 10
    dw $fefe ; id 241 ? none
    dw $fefe ; id 242 ? none
    dw $fefe ; id 243 ? none
    dw $fefe ; id 244 ? none
    dw $fefe ; id 245 ? none
    dw $fe00 ; id 246 Spooky family 0
    dw $fe01 ; id 247 Skullgon family 1
    dw $fe02 ; id 248 PutrePup family 2
    dw $fe03 ; id 249 RotRaven family 3
    dw $fe04 ; id 250 Mummy family 4
    dw $fe05 ; id 251 DarkCrab family 5
    dw $fe06 ; id 252 DeadNite family 6
    dw $fe08 ; id 253 Shadow family 8
    dw $fe09 ; id 254 Skulpent family 9
    dw $fe02 ; id 255 Hork family 2
    dw MONSTER_DROLL ; id 256 Mudron
    dw MONSTER_MISTYWING ; id 257 NiteWhip
    dw MONSTER_WINDBEAST ; id 258 WindMerge
    dw $fe06 ; id 259 Reaper family 6
    dw MONSTER_HORK ; id 260 Inverzon
    dw $fe02 ; id 261 FoxFire family 2
    dw $fe09 ; id 262 CaptDead family 9
    dw MONSTER_DEADNITE ; id 263 DeadNoble
    dw MONSTER_SPOTKING ; id 264 WhiteKing
    dw MONSTER_FLORAMAN ; id 265 BoneSlave
    dw MONSTER_BONESLAVE ; id 266 Skeletor
    dw MONSTER_SKELETOR ; id 267 Servant
    dw MONSTER_DRACOLORD ; id 268 Lazamanus
    dw $fefe ; id 269 Copycat none
    dw $fe01 ; id 270 MadSpirit family 1
    dw MONSTER_GASGON ; id 271 PomPomBom
    dw MONSTER_ROBOSTER2 ; id 272 Niterich
    dw $fefe ; id 273 ? none
    dw $fefe ; id 274 ? none
    dw $fefe ; id 275 ? none
    dw $fefe ; id 276 ? none
    dw $fefe ; id 277 ? none
    dw $fefe ; id 278 ? none
    dw $fefe ; id 279 ? none
    dw $fefe ; id 280 ? none
    dw $fe00 ; id 281 JewelBag family 0
    dw $fe01 ; id 282 EvilWand family 1
    dw $fe02 ; id 283 MadCandle family 2
    dw $fe03 ; id 284 CoilBird family 3
    dw $fe04 ; id 285 Facer family 4
    dw $fe05 ; id 286 SpikyBoy family 5
    dw $fe06 ; id 287 MadMirror family 6
    dw $fe07 ; id 288 RogueNite family 7
    dw MONSTER_GREMLIN ; id 289 Puppetor
    dw $fe08 ; id 290 Goopi family 8
    dw $fe06 ; id 291 Voodoll family 6
    dw MONSTER_ANDREAL ; id 292 MetalDrak
    dw $fe0a ; id 293 Balzak family 10
    dw MONSTER_GIANTWORM ; id 294 SabreMan
    dw MONSTER_WINGTREE ; id 295 CurseLamp
    dw $fe09 ; id 296 Brushead family 9
    dw MONSTER_SLIMEBORG ; id 297 Roboster
    dw MONSTER_ROBOSTER ; id 298 Roboster2
    dw MONSTER_SNAILY ; id 299 EvilPot
    dw MONSTER_WYVERN ; id 300 Gismo
    dw MONSTER_ZAPBIRD ; id 301 LavaMan
    dw MONSTER_SKULLGON ; id 302 IceMan
    dw MONSTER_BOXSLIME ; id 303 Mimic
    dw MONSTER_DRACKY ; id 304 Exaucers
    dw MONSTER_GOOPI ; id 305 MudDoll
    dw MONSTER_MUDDOLL ; id 306 Golem
    dw MONSTER_GOLEM ; id 307 StoneMan
    dw MONSTER_SPIKYBOY ; id 308 BombCrag
    dw MONSTER_LAVAMAN ; id 309 GoldGolem
    dw MONSTER_METALKING ; id 310 DarkMate
    dw $fe06 ; id 311 ProtoMech family 6
    dw MONSTER_SKYDRAGON ; id 312 CloudKing
    dw $fefe ; id 313 ? none
    dw $fefe ; id 314 ? none
    dw $fefe ; id 315 ? none
    dw $fe00 ; id 316 Petiteel family 0
    dw $fe01 ; id 317 Moray family 1
    dw $fe02 ; id 318 WalrusMan family 2
    dw $fe03 ; id 319 RayGigas family 3
    dw $fe04 ; id 320 Anemon family 4
    dw $fe05 ; id 321 Aquarella family 5
    dw $fe06 ; id 322 Merman family 6
    dw $fe08 ; id 323 Octokid family 8
    dw $fe07 ; id 324 PutreFish family 7
    dw $fe02 ; id 325 Octoreach family 2
    dw $fe08 ; id 326 Angleron family 8
    dw MONSTER_SKULRIDER ; id 327 FishRider
    dw $fe01 ; id 328 RushFish family 1
    dw $fe05 ; id 329 Gamanian family 5
    dw MONSTER_ARMYCRAB ; id 330 Clawster
    dw MONSTER_CLAWSTER ; id 331 CancerMan
    dw MONSTER_JEWELBAG ; id 332 RogueWave
    dw $fe06 ; id 333 Scallopa family 6
    dw $fe01 ; id 334 SeaHorse family 1
    dw MONSTER_WHALEMAGE ; id 335 HoodSquid
    dw MONSTER_MADCAT ; id 336 MerTiger
    dw MONSTER_BATTLEREX ; id 337 AxeShark
    dw MONSTER_OCTOREACH ; id 338 Octogon
    dw MONSTER_OCTOGON ; id 339 KingSquid
    dw MONSTER_SPIKEROUS ; id 340 Digong
    dw MONSTER_1EYECLOWN ; id 341 WhaleMage
    dw MONSTER_GREATDRAK ; id 342 Aquadon
    dw MONSTER_LIONEX ; id 343 Octoraid
    dw $fe0a ; id 344 Grakos family 10
    dw MONSTER_MUDOU ; id 345 Poseidon
    dw MONSTER_SPIKYBOY ; id 346 Pumpoise
    dw $fe00 ; id 347 Starfish family 0
    dw $fefe ; id 348 ? none
    dw $fefe ; id 349 ? none
    dw $fefe ; id 350 ? none
    dw MONSTER_ANDREAL ; id 351 DracoLord
    dw MONSTER_DIVINEGON ; id 352 DracoLord
    dw MONSTER_ORLIGON ; id 353 LordDraco
    dw MONSTER_METALKING ; id 354 Hargon
    dw MONSTER_ROSEVINE ; id 355 Sidoh
    dw MONSTER_TITANIS ; id 356 Genosidoh
    dw MONSTER_OROCHI ; id 357 Baramos
    dw MONSTER_SIDOH ; id 358 Zoma
    dw MONSTER_PSYCHOPIZ ; id 359 AsuraZoma
    dw MONSTER_DIVINEGON ; id 360 Pizzaro
    dw MONSTER_ESTERK ; id 361 PsychoPiz
    dw MONSTER_GORAGO ; id 362 Esterk
    dw MONSTER_GOLDSLIME ; id 363 Mirudraas
    dw MONSTER_ORLIGON ; id 364 Mirudraas
    dw MONSTER_GORAGO ; id 365 Mudou
    dw MONSTER_AZURILE ; id 366 DeathMore
    dw MONSTER_TITANIS ; id 367 DeathMore
    dw MONSTER_DARKMATE ; id 368 DeathMore
    dw MONSTER_GRANSLIME ; id 369 Darkdrium
    dw MONSTER_NITERICH ; id 370 Orgodemir
    dw MONSTER_LORDDRACO ; id 371 Orgodemir
    dw $fefe ; id 372 Darck none
    dw $fefe ; id 373 Tatsu none
    dw $fefe ; id 374 Diago none
    dw $fefe ; id 375 Samsi none
    dw $fefe ; id 376 Bazoo none
    dw $fefe ; id 377 ? none
    dw $fefe ; id 378 ? none
    dw $fefe ; id 379 ? none
    dw $fefe ; id 380 Lamia none
    dw $fefe ; id 381 Dimensaur none
    dw $fefe ; id 382 Kagebou none
    dw $fefe ; id 383 ? none

; implements script command type F7 (SCRIPT_ARENA): the arena: 'The E Class should do. Which...',
; 'Congratulations! You did it!' (mode 10, bank $33 strings); reached through ScriptCommandF7 in
; bank $10 (E-0038, E-0244)
ArenaMenu::
    ld a, [wScreenState]
    jumptable
    dw ArenaMenu_Init
    dw ArenaMenu_DrawClassChooser
    dw ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc
    dw ShowTwoChoiceBoxAtWindowTileBufferRow13Col14
    dw ArenaMenu_AskEnterClass
    dw ArenaMenu_CancelClass
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_PayEntryFee
    dw ArenaMenu_AfterRound
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_CallArenaMenu_DispatchTalkEvent
    dw ArenaMenu_ShowGoldAndYesNo
    dw ArenaMenu_ReadAnswer
    dw ArenaMenu_AdvanceScreenState_SetScreenState
    dw ArenaMenu_SetScreenState
    dw ArenaMenu_RestoreClassPanels
    dw ArenaMenu_DrawClassPanel
    dw ArenaMenu_DrawClassPanelGold
    dw ArenaMenu_WriteTextBuf0AndScreenStateEtc
    dw ArenaMenu_RestorePanel
    dw ArenaMenu_AdvanceScreenState_SetScreenState_2
    dw ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc
    dw ShowTwoChoiceBoxAtWindowTileBufferRow13Col14
    dw ArenaMenu_ReadFeeAnswer
    dw ArenaMenu_ClosePanelBox
    dw ArenaMenu_PayEntryFeeAgain
    dw ArenaMenu_StartArenaTalk
    dw ArenaMenu_AfterRoundAgain
    dw ArenaMenu_ToArenaMenu_ReadArenaRound
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_StartTalkAndClearRun
    dw ArenaMenu_AfterRound
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_ToArenaMenu_DispatchTalkEvent
    dw ArenaMenu_SetTwoChoiceCursor
    dw ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_2
    dw ArenaMenu_GiveRankReward
    dw ShowTwoChoiceBoxAtWindowTileBufferRow13Col14
    dw ArenaMenu_ReadQuestion
    dw ArenaMenu_PickPrize

; Arena, state 39, the prize: picks a random prize for the class (wAreaGraphicsIndex) from its
; chance list; the prize may be gold, a new key (GenerateNewKeyEntry) or another draw. (C1, E-0357)
ArenaMenu_PickPrize::
    ld a, [wAreaGraphicsIndex]
    add a
    ld hl, ArenaMenu_PickPrize_Data1
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld b, $1f
    call RandomModulo52
    pop de
    ld b, $00

.skip:
    ld a, [de]
    cp $ff
    jp z, .call_arena_menu_pick_prize_add_arg1_to_gold2
    cp l
    jr nc, .read_area_graphics_index
    inc de
    inc b
    jr .skip

.read_area_graphics_index:
    ld a, [wAreaGraphicsIndex]
    add a
    ld hl, ArenaMenu_PickPrize_Data2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    cp $fe
    jr z, .call_generate_new_key_entry
    cp $fd
    jr z, .call_arena_menu_pick_prize_random_modulo52
    ld [wArg1], a
    call ArenaMenu_PickPrize_AddArg1ToGoldCapped99999_2
    jp .set_two_choice_cursor

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    and a
    jr z, .call_arena_menu_pick_prize_add_arg1_to_gold
    ld a, $01
    jr .set_two_choice_cursor

.call_arena_menu_pick_prize_add_arg1_to_gold:
    call ArenaMenu_PickPrize_AddArg1ToGoldCapped99999
    ld a, $03
    jr .set_two_choice_cursor

.call_arena_menu_pick_prize_random_modulo52:
    call ArenaMenu_PickPrize_RandomModulo52
    call ArenaMenu_PickPrize_AddArg1ToGoldCapped99999_2
    jp .set_two_choice_cursor

.call_arena_menu_pick_prize_add_arg1_to_gold2:
    call ArenaMenu_PickPrize_AddArg1ToGoldCapped99999
    ld a, $03

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a
    ld [wAreaGraphicsIndex], a
    ret

; Arena, state 38: a yes/no question; yes moves on, no redraws the screen and steps back. (C1,
; E-0357)
ArenaMenu_ReadQuestion::
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
    ld a, [wScreenState]
    dec a
    ld [wScreenState], a
    ld b, $00
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 0: clears the arena state, copies the screen to the window buffer, sets message mode
; $0A and picks the starting state by the arena rank (wArenaRank): the first visit, a class choice,
; or the champion's state. (C1, E-0357)
ArenaMenu_Init::
    ld hl, wScreenState
    ld b, $6f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_0A
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

.set_message_mode_to_0A:
    ld a, $0a
    ld [wMessageMode], a
    ld a, [wArenaRank]
    cp $05
    jr nc, .set_two_choice_cursor_to_01
    and a
    jr nz, .clear_two_choice_cursor
    ld a, [wScreenTableIndex]
    cp $1f
    jr z, .set_screen_state
    ld a, $1d

.set_screen_state:
    ld [wScreenState], a
    ld a, $02
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld [wStringCategory], a
    ld a, $17
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0a01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank33
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    jr .check_screen_table_index

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wStringCategory], a
    ld a, $1a
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0a01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank33
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $18
    ld [wStringIndex], a
    farcall ShowString_Bank33
    ld a, $0b
    ld [wScreenState], a

.check_screen_table_index:
    ld a, [wScreenTableIndex]
    cp $08
    jr z, .set_screen_state2
    cp $1b
    jr z, .set_screen_state2
    jr .set_text_window_tile_lo

.set_screen_state2:
    ld [wScreenState], a

.set_text_window_tile_lo:
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

; Arena, state 1: draws the class chooser with the current rank and the prize money. (C1, E-0357)
ArenaMenu_DrawClassChooser::
    ld de, ArenaMenu_DrawClassChooser_TileRect
    ld hl, wWindowTileBuffer + $b4
    lb bc, $11, $09
    call CopyRectTo20ByteRows_Bank0C
    call ArenaMenu_DrawClassChooser_ReadArenaRank
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Arena, state 2: the class cursor: Up/Down move over the four classes (wrapping), A chooses one, B
; cancels (wTwoChoiceCursor = 3). (C1, E-0357)
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_arena_menu_read_grid_cursor_x_2
    bit 7, a
    jr nz, .call_arena_menu_read_grid_cursor_x_22
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_03
    bit 0, a
    jr nz, .call_arena_menu_read_grid_cursor_x
    call ArenaMenu_WriteGridCursorY
    ret

.call_arena_menu_read_grid_cursor_x_2:
    call ArenaMenu_ReadGridCursorX_2
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x
    ld a, $03
    jr .set_grid_cursor_x2

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    call ArenaMenu_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_arena_menu_read_grid_cursor_x_22:
    call ArenaMenu_ReadGridCursorX_2
    ld a, [wGridCursorX]
    cp $03
    jr c, .skip
    xor a
    jr .set_grid_cursor_x2

.skip:
    inc a
    jr .set_grid_cursor_x2

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_arena_menu_read_grid_cursor_x:
    call ArenaMenu_ReadGridCursorX
    ld a, [wArenaRank]
    dec a
    ld b, a
    ld a, [wGridCursorX]
    cp b
    jr c, .set_two_choice_cursor_to_01
    jr z, .call_queue_sound_effect
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data1
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $f0
    ld [wTextBuf0 + $1], a
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data2
    ld b, $bc
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc (4 bytes) (E-0347)
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data1::
    db $0c, $0b, $0a, $1c

; Blinks the arena class cursor: 16 frames shown, 8 hidden. (C1, E-0357)
ArenaMenu_WriteGridCursorY::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, ArenaMenu_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, ArenaMenu_ReadGridCursorX
    cp $18
    jr c, ArenaMenu_ReadGridCursorX_2
    xor a
    ld [wGridCursorY], a

; Draws the arena class cursor (tile $BB). (C1, E-0357)
ArenaMenu_ReadGridCursorX::
    ld b, $bb
    jr ArenaMenu_ReadGridCursorX_2_ReadGridCursorX

; Hides the arena class cursor (tile $C3). (C1, E-0357)
ArenaMenu_ReadGridCursorX_2::
    ld b, $c3
    jr ArenaMenu_ReadGridCursorX_2_ReadGridCursorX
    db $06, $bc

; Writes tile B at the class cursor position (ArenaMenu_ReadGridCursorX_Data by wGridCursorX),
; allowing for the scroll wrap. (C1, E-0357)
ArenaMenu_ReadGridCursorX_2_ReadGridCursorX::
    ld a, [wGridCursorX]
    sla a
    ld hl, ArenaMenu_ReadGridCursorX_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by ArenaMenu (8 bytes) (E-0347)
ArenaMenu_ReadGridCursorX_Data::
    db $a2, $00, $e2, $00, $22, $01, $62, $01

; plays sound $6C, copies the 6 x 5 box ShowTwoChoiceBoxAtWindowTileBufferRow13Col14_TileRect to
; wWindowTileBuffer + $112, draws it at the scroll position + $1CC, wScreenState += 1 and
; wTwoChoiceCursor = 0 (E-0122) (E-0340: the address in its name read as its RAM name; was
; ShowTwoChoiceBoxAtWindowTileBufferRow13Col14)
ShowTwoChoiceBoxAtWindowTileBufferRow13Col14::
    ld a, $6c
    call QueueSoundEffect
    ld de, ShowTwoChoiceBoxAtWindowTileBufferRow13Col14_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; Arena, state 4: the yes/no question on entering the chosen class; yes checks the class's entry fee
; (ArenaMenu_AskEnterClass_Data), no closes the question and moves on. (C1, E-0357)
ArenaMenu_AskEnterClass::
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
    call ArenaMenu_CopyScreenBufferRectWithAttrs_0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    ld a, [wGridCursorX]
    sla a
    ld de, ArenaMenu_AskEnterClass_Data
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
    ld a, [wScreenState]
    inc a
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

; Closes the arena's yes/no box: restores the screen behind it and redraws the box frame. (C1,
; E-0357)
ArenaMenu_CopyScreenBufferRectWithAttrs_0C::
    ld b, $00
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld de, ArenaMenu_CopyScreenBufferRectWithAttrs_0C_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $03, $05
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ret

; Arena, state 5: closes the box, blanks the four class marks and returns to the class cursor (state
; 2). (C1, E-0357)
ArenaMenu_CancelClass::
    call ArenaMenu_CopyScreenBufferRectWithAttrs_0C
    ld c, $04
    ld hl, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data2
    call ArenaMenu_CancelClass_StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, $02
    ld [wScreenState], a
    ret

; Arena, state 6: moves on. (C1, E-0357)
ArenaMenu_AdvanceScreenState::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Arena, state 7: pays the class's entry fee (SubtractArg1AmountFromGold), records the class
; (wAreaGraphicsIndex) and the round count, starts the arena talk event and redraws the screen. (C1,
; E-0357)
ArenaMenu_PayEntryFee::
    call ArenaMenu_DispatchTalkEvent_SetScriptReturnBank
    ld a, [wGridCursorX]
    sla a
    ld de, ArenaMenu_AskEnterClass_Data
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
    xor a
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    ld a, [wScreenCountPlusOne]
    ld [wRecordCapacity], a
    ld a, [wGridCursorX]
    ld [wAreaGraphicsIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; Arena, state 8, after a round: when the battle was lost (wBattleScene set) the run ends; before
; the third round it prepares the next one; after the third the arena rank goes up and the run ends.
; (C1, E-0357)
ArenaMenu_AfterRound::
    ld a, [wBattleScene]
    and a
    jr nz, .set_two_choice_cursor_to_02
    ld a, [wRecordCapacity]
    cp $02
    jr nc, .check_arena_rank
    call SetupScreenCountPlusOneFromRecordCapacity
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

.check_arena_rank:
    ld a, [wArenaRank]
    inc a
    ld [wArenaRank], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    jr .clear_area_graphics_index

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a

.clear_area_graphics_index:
    xor a
    ld [wAreaGraphicsIndex], a
    ld [wScreenTableIndex], a
    ld [wRecordCapacity], a
    ld a, [wArenaRank]
    and a
    ret z
    ld a, $22
    ld [wScreenState], a
    ret

; Arena, state 10: starts the arena talk event. (C1, E-0357)
ArenaMenu_CallArenaMenu_DispatchTalkEvent::
    call ArenaMenu_DispatchTalkEvent_SetScriptReturnBank
    ret

; Arena, state 11: shows the gold and the yes/no box. (C1, E-0357)
ArenaMenu_ShowGoldAndYesNo::
    call ArenaMenu_Number24ToPackedBCD
    call ShowTwoChoiceBoxAtWindowTileBufferRow13Col14
    ret

; Arena, state 12: the yes/no answer: yes closes the box and moves on, no leaves the question for
; the script. (C1, E-0357)
ArenaMenu_ReadAnswer::
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    call ArenaMenu_CopyScreenBufferRectWithAttrs_0C
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 13: moves on. (C1, E-0357)
ArenaMenu_AdvanceScreenState_SetScreenState::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Arena, state 14: skips a state. (C1, E-0357)
ArenaMenu_SetScreenState::
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 15: restores the screen areas behind the class panels and steps back four states.
; (C1, E-0357)
ArenaMenu_RestoreClassPanels::
    ld b, $00
    ld c, $03
    ld hl, $01e0
    ld de, $0014
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a
    ld [wArg1], a
    ld a, $0d
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    sub $04
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 16: draws the class panel with the gold, judges the party's strength
; (ArenaMenu_WriteTwoChoiceCursor) and skips a state. (C1, E-0357)
ArenaMenu_DrawClassPanel::
    ld de, ArenaMenu_DrawClassPanel_TileRect
    ld hl, wWindowTileBuffer + $b4
    lb bc, $11, $09
    call CopyRectTo20ByteRows_Bank0C
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call ArenaMenu_WriteTwoChoiceCursor
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 17: draws the class panel with the gold. (C1, E-0357)
ArenaMenu_DrawClassPanelGold::
    ld de, ArenaMenu_DrawClassPanel_TileRect
    ld hl, wWindowTileBuffer + $b4
    lb bc, $11, $09
    call CopyRectTo20ByteRows_Bank0C
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Arena, state 18: the class cursor of the second panel: Up/Down move over the four classes, A
; chooses, B cancels. (C1, E-0357)
ArenaMenu_WriteTextBuf0AndScreenStateEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_arena_menu_read_grid_cursor_x_4
    bit 7, a
    jr nz, .call_arena_menu_read_grid_cursor_x_42
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_01
    bit 0, a
    jr nz, .call_arena_menu_read_grid_cursor_x_3
    call ArenaMenu_WriteGridCursorY_2
    ret

.call_arena_menu_read_grid_cursor_x_4:
    call ArenaMenu_ReadGridCursorX_4
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x
    ld a, $03
    jr .set_grid_cursor_x2

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    call ArenaMenu_ReadGridCursorX_3
    ld a, $69
    call QueueSoundEffect
    ret

.call_arena_menu_read_grid_cursor_x_42:
    call ArenaMenu_ReadGridCursorX_4
    ld a, [wGridCursorX]
    cp $03
    jr c, .skip
    xor a
    jr .set_grid_cursor_x2

.skip:
    inc a
    jr .set_grid_cursor_x2

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_arena_menu_read_grid_cursor_x_3:
    call ArenaMenu_ReadGridCursorX_3
    ld a, $69
    call QueueSoundEffect
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data1
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $f0
    ld [wTextBuf0 + $1], a
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data2
    ld b, $bc
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by ArenaMenu_WriteTextBuf0AndScreenStateEtc (4 bytes) (E-0347)
ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data1::
    db $0c, $0b, $0a, $1c

; Blinks the second panel's cursor: 16 frames shown, 8 hidden. (C1, E-0357)
ArenaMenu_WriteGridCursorY_2::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, ArenaMenu_ReadGridCursorX_3
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, ArenaMenu_ReadGridCursorX_3
    cp $18
    jr c, ArenaMenu_ReadGridCursorX_4
    xor a
    ld [wGridCursorY], a

; Draws the second panel's cursor (tile $BB). (C1, E-0357)
ArenaMenu_ReadGridCursorX_3::
    ld b, $bb
    jr ArenaMenu_ReadGridCursorX_4_ReadGridCursorX

; Hides the second panel's cursor (tile $C3). (C1, E-0357)
ArenaMenu_ReadGridCursorX_4::
    ld b, $c3
    jr ArenaMenu_ReadGridCursorX_4_ReadGridCursorX
    db $06, $bc

; Writes tile B at the second panel's cursor position (ArenaMenu_ReadGridCursorX_Data_2). (C1,
; E-0357)
ArenaMenu_ReadGridCursorX_4_ReadGridCursorX::
    ld a, [wGridCursorX]
    sla a
    ld hl, ArenaMenu_ReadGridCursorX_Data_2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by ArenaMenu_ReadGridCursorX_4_ReadGridCursorX (8 bytes) (E-0347)
ArenaMenu_ReadGridCursorX_Data_2::
    db $a1, $00, $e1, $00, $21, $01, $61, $01

; Arena, state 19: restores the screen behind the panel and goes back to state $0D. (C1, E-0357)
ArenaMenu_RestorePanel::
    ld b, $00
    ld c, $05
    ld hl, $01e0
    ld de, $0014
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, $0d
    ld [wScreenState], a
    xor a
    ld [wGrid2CursorX], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 20: moves on. (C1, E-0357)
ArenaMenu_AdvanceScreenState_SetScreenState_2::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Arena, state 21: sets the chosen class's area (wScreenArea = class + 2) and its entry fee from
; ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc_Data. (C1, E-0357)
ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc::
    ld a, [wGridCursorX]
    inc a
    inc a
    ld [wScreenArea], a
    ld a, $02
    ld [wGrid2CursorX], a
    ld a, [wGridCursorX]
    add a
    ld hl, ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc_Data
    add_a_to_hl
    ld a, [hl]
    ld [wArenaFeeLo], a
    inc hl
    ld a, [hl]
    ld [wArenaFeeHi], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by ArenaMenu (8 bytes) (E-0347)
ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc_Data::
    db $e8, $03, $d0, $07, $b8, $0b, $88, $13

; Arena, state 23: the fee question: yes checks the gold (IsAmountInArg1AboveGold) and moves on when
; there is not enough (to the refusal) or pays; no moves on. (C1, E-0357)
ArenaMenu_ReadFeeAnswer::
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
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    ld a, [wArenaFeeLo]
    ld [wArg1], a
    ld a, [wArenaFeeHi]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp $ff
    jr nz, .check_screen_state
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 24: closes the box, redraws the panel, judges the party and returns to state $11.
; (C1, E-0357)
ArenaMenu_ClosePanelBox::
    ld b, $00
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld de, ArenaMenu_ClosePanelBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $03, $05
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call ArenaMenu_WriteTwoChoiceCursor
    ld a, $11
    ld [wScreenState], a
    xor a
    ld [wGrid2CursorX], a
    ld [wScreenArea], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 25: pays the entry fee and redraws the gold. (C1, E-0357)
ArenaMenu_PayEntryFeeAgain::
    xor a
    ld [wArg3], a
    ld a, [wArenaFeeHi]
    ld [wArg2], a
    ld a, [wArenaFeeLo]
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 26: records the area, starts talk event group $1F and redraws the screen. (C1,
; E-0357)
ArenaMenu_StartArenaTalk::
    ld a, [wScreenArea]
    ld [wAreaGraphicsIndex], a
    call ArenaMenu_StartArenaTalk_DispatchTalkEvent
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; Arena, state 27, after a round: a lost battle clears the prize; before the third round the round
; count goes up for the next battle; after it the run ends (state $23). (C1, E-0357)
ArenaMenu_AfterRoundAgain::
    ld a, [wBattleScene]
    and a
    jr nz, .clear_arg3
    ld a, [wArenaRound]
    cp $02
    jr nc, .call_arena_menu_after_round_again_return
    call IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScreenState]
    ld [wScreenTableIndex], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

.call_arena_menu_after_round_again_return:
    call ArenaMenu_AfterRoundAgain_Return
    xor a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a
    ld [wScreenTableIndex], a
    ld [wRecordCapacity], a
    ld a, $23
    ld [wScreenState], a
    ret

.clear_arg3:
    xor a
    ld [wArg3], a
    ld [wArg2], a
    ld [wArg1], a
    ld a, $02
    jr .set_two_choice_cursor

; Arena, state 28: loads the next round's three foes from the round list (ArenaMenu_ReadArenaRound).
; (C1, E-0357)
ArenaMenu_ToArenaMenu_ReadArenaRound::
    call ArenaMenu_ReadArenaRound
    ret

; Arena, state 30: starts the arena talk event, clears the run's record and redraws the screen. (C1,
; E-0357)
ArenaMenu_StartTalkAndClearRun::
    call ArenaMenu_DispatchTalkEvent
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    ld a, [wScreenCountPlusOne]
    xor a
    ld [wRecordCapacity], a
    ld a, [wGridCursorX]
    xor a
    ld [wAreaGraphicsIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; Arena, state 33: starts the arena talk event. (C1, E-0357)
ArenaMenu_ToArenaMenu_DispatchTalkEvent::
    call ArenaMenu_DispatchTalkEvent
    ret

; Arena, state 34, the result message: after a lost battle picks the message by rank (below 3 or
; not); otherwise the message index is the rank - 2, and for ranks 1-4 two states are skipped. (C1,
; E-0357)
ArenaMenu_SetTwoChoiceCursor::
    ld a, [wBattleScene]
    and a
    jr nz, .check_arena_rank
    ld a, [wArenaRank]
    dec a
    dec a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wArenaRank]
    cp $01
    jr c, .return
    cp $05
    jr nc, .return
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a

.return:
    ret

.check_arena_rank:
    ld a, [wArenaRank]
    cp $03
    jr nc, .set_two_choice_cursor_to_01
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 35: puts the player's name (and, after a win, the class letter) in the text buffer
; for the message. (C1, E-0357)
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_2::
    ld a, [wBattleScene]
    and a
    jr nz, .skip
    jr .call_arena_menu_write_player_name_with_flag0

.skip:
    jr .call_write_player_name_with_flag0_suffix_to

.call_arena_menu_write_player_name_with_flag0:
    call ArenaMenu_WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

.call_write_player_name_with_flag0_suffix_to:
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Arena, state 36, the reward: at rank 1 gives the first key (EVENT_ARENA_RANK1_KEY_GIVEN, a key of
; kind 3, and sets EVENT_WARUBOU_WA_HEY_THIS_TIME); otherwise generates a new key
; (GenerateNewKeyEntry), noting when the list is full; then the player's name goes in the text
; buffer. (C1, E-0357)
ArenaMenu_GiveRankReward::
    ld a, [wArenaRank]
    cp $01
    jr nz, .call_generate_new_key_entry
    ld de, EVENT_ARENA_RANK1_KEY_GIVEN
    call SetFlagBit
    farcall CountKeysOrFull
    ld a, $03
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld de, EVENT_WARUBOU_WA_HEY_THIS_TIME
    call SetFlagBit
    jr .skip

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    ld [wArenaOutcome], a
    and a
    jr z, .set_two_choice_cursor_to_01

.skip:
    ld hl, wTextBuf0
    ld de, wPlayerName
    ld b, $0a

.loop:
    ld a, [de]
    cp $f0
    jr z, .skip2
    ld [hli], a
    inc de
    dec b
    jr nz, .loop

.skip2:
    ld a, $f0
    ld [hl], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs CopyScreenBufferRectWithAttrs_0C for the bottom box, copies $64 bytes of tiles (and CGB
; attributes) and draws the two screen-buffer rectangles at scroll + $1CC and + $1A0 (E-0125)
RedrawFullScreenBoxes_0C::
    ld b, $00
    ld c, $0d
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0C

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ret

; Puts the player's name and the class letter of wAreaGraphicsIndex (from
; ArenaMenu_WritePlayerNameWithFlag0SuffixToTextBuf0_Data) in the text buffer. (C1, E-0357)
ArenaMenu_WritePlayerNameWithFlag0SuffixToTextBuf0::
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wAreaGraphicsIndex]
    ld hl, ArenaMenu_WritePlayerNameWithFlag0SuffixToTextBuf0_Data
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $f0
    ld [wTextBuf0 + $1], a
    ret

; data read by ArenaMenu (6 bytes) (E-0347)
ArenaMenu_WritePlayerNameWithFlag0SuffixToTextBuf0_Data::
    db $0c, $0c, $0c, $0b, $0a, $1c

; Advance the eight-bit random-arena round counter, wrapping at $FF, and copy wAreaGraphicsIndex to
; wScreenArea. Called after the first and second battles before rebuilding the remaining foe list.
; (C1, E-0359)
IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea::
    ld a, [wArenaRound]
    inc a
    ld [wArenaRound], a
    ld a, [wAreaGraphicsIndex]
    ld [wScreenArea], a
    ret

; Refresh the grid-arena selection: increment the reused arena counter modulo 256, store the result
; in both wScreenCountPlusOne and wRecordCapacity, copy wAreaGraphicsIndex to wGridCursorX and set
; wTwoChoiceCursor = 1. The caller uses the refreshed index for the next three-foe encounter. (C1,
; E-0359)
SetupScreenCountPlusOneFromRecordCapacity::
    ld a, [wRecordCapacity]
    inc a
    ld [wScreenCountPlusOne], a
    ld a, [wAreaGraphicsIndex]
    ld [wGridCursorX], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenCountPlusOne]
    ld [wRecordCapacity], a
    ret

; Marks the cleared classes on the class panel: tile $AD beside each class below the arena rank.
; (C1, E-0357)
ArenaMenu_DrawClassChooser_ReadArenaRank::
    ld hl, wWindowTileBuffer + $c9
    ld a, [wArenaRank]
    cp $02
    jr c, .check_arena_rank
    ld a, $ad
    ld [hl], a

.check_arena_rank:
    ld a, [wArenaRank]
    cp $03
    jr c, .check_arena_rank2
    ld hl, wWindowTileBuffer + $f1
    ld a, $ad
    ld [hl], a

.check_arena_rank2:
    ld a, [wArenaRank]
    cp $04
    jr c, .check_arena_rank3
    ld hl, wWindowTileBuffer + $119
    ld a, $ad
    ld [hl], a

.check_arena_rank3:
    ld a, [wArenaRank]
    cp $05
    ret c
    ld hl, wWindowTileBuffer + $141
    ld a, $ad
    ld [hl], a
    ret

; Draws the gold on the arena panel: the frame and the five digits of wGold. (C1, E-0357)
ArenaMenu_Number24ToPackedBCD::
    ld de, ArenaMenu_Number24ToPackedBCD_TileRect
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
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
    ret

; The party's average strength: the sum of the per-member strengths in wArenaEntry divided by the
; party size, capped at 255. (C1, E-0357)
ArenaMenu_DivideHLByA::
    ld hl, $0000
    ld de, wArenaEntry
    ld c, $00

.loop:
    push de
    push bc
    ld a, [de]
    add l
    ld l, a
    ld a, h
    adc $00
    ld h, a
    pop bc
    pop de
    inc de
    inc c
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp b
    jr c, .loop
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, h
    and a
    ret z
    ld h, $00
    ld l, $ff
    ret

; Computes each party member's strength for the arena from its SRAM record: max HP, max MP, ATK and
; the other stats added together and scaled, into wArenaEntry. (C1, E-0357)
ArenaMenu_AddTemp0WordToHL::
    xor a
    ld [wArenaEntry], a
    ld [wArenaEntry + $1], a
    ld [wArenaEntry + $2], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld de, wPartyList
    ld c, $00

.loop:
    push bc
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_ATK
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_DEF
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_AGL
    call LoadSRAMRecordWord
    ld hl, $0000
    call AddTemp0WordToHL
    ld c, l
    ld b, h
    pop hl
    pop de
    push de
    push hl
    push bc
    ld a, [de]
    ld c, MON_INT
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    srl h
    rr l
    ld c, l
    ld b, h
    pop hl
    add hl, bc
    ld a, $32
    call DivideHLByA
    ld a, h
    and a
    jr z, .skip
    ld h, $00
    ld l, $63
    jr .restore

.skip:
    ld a, l
    cp $64
    jr c, .restore
    ld h, $00
    ld l, $63

.restore:
    pop de
    pop bc
    push bc
    push de
    ld de, wArenaEntry
    ld a, c
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, l
    ld [de], a
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_ATK
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_DEF
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_AGL
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_INT
    call LoadSRAMRecordWord
    pop hl
    call AddTemp0WordToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld c, $18
    call Multiply8
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, $32
    call DivideHLByA
    ld a, h
    and a
    jr z, .skip3
    ld h, $00
    ld l, $63
    jr .restore2

.skip3:
    ld a, l
    cp $64
    jr c, .restore2
    ld h, $00
    ld l, $63

.restore2:
    pop de
    pop bc
    push bc
    push de
    ld de, wArenaEntry
    ld a, c
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add l
    ld [de], a
    pop de
    pop bc
    inc de
    inc c
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp b
    jp c, .loop
    xor a
    ld [rRAMG2], a
    ret

; HL += the word in hTemp0/hTemp1; clobbers A (E-0073)
AddTemp0WordToHL::
    ldh a, [hTemp0]
    add l
    ld l, a
    ldh a, [hTemp1]
    adc h
    ld h, a
    ret

; HL = the word PickTableEntryByPartyLevelTotal_Data[band] for the party's total level (bands at 49,
; 91, 139, 181, 220 and 256) (E-0128)
PickTableEntryByPartyLevelTotal::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, wPartyList
    ld de, $0000
    ld c, $00

.loop:
    push bc
    push hl
    push de
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    pop de
    ldh a, [hTemp0]
    add e
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp b
    jr c, .loop
    xor a
    ld [rRAMG2], a
    ld a, d
    and a
    jr nz, .skip
    ld a, e
    cp $dc
    jr nc, .skip
    cp $b5
    jr nc, .skip2
    cp $8b
    jr nc, .skip3
    cp $5b
    jr nc, .skip4
    cp $31
    jr nc, .skip5
    xor a
    jr .skip6

.skip:
    ld a, $05
    jr .skip6

.skip2:
    ld a, $04
    jr .skip6

.skip3:
    ld a, $03
    jr .skip6

.skip4:
    ld a, $02
    jr .skip6

.skip5:
    ld a, $01

.skip6:
    sla a
    ld de, PickTableEntryByPartyLevelTotal_Data
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ret

; data read by PickTableEntryByPartyLevelTotal (12 bytes) (E-0347)
PickTableEntryByPartyLevelTotal_Data::
    db $90, $01, $58, $02, $20, $03, $b0, $04, $78, $05, $78, $05

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL for rows B to C,
; with CGB attributes (E-0128)
CopyScreenBufferRectWithAttrs_0C::
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
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank0C
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
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank0C
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
    inc b
    ld a, b
    cp c
    jr c, CopyScreenBufferRectWithAttrs_0C
    ret

; Build individual foe words for rounds wArenaRound through 2, three words per round in wArenaList2.
; Clear all forty wArenaList usage bytes, draw through RandomModulo52 using its L quotient, fold the
; chosen index to the class list size and skip indexes already used three times in this rebuild.
; Preserve earlier round words. ArenaEncounterLists supplies one encounter word per selected index,
; not a whole three-foe group; valid starting rounds are 0-2 and class indexes 0-5. (C1, E-0359)
ArenaRounds_RandomModulo52::
    ld hl, wArenaList
    ld b, $28

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wArenaRound]
    ld b, a
    ld c, $00

.loop2:
    push bc
    ld b, $1f
    call RandomModulo52

.read_area_graphics_index:
    ld de, ArenaEncounterListSizes
    ld a, [wAreaGraphicsIndex]
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a

.skip2:
    ld a, l
    cp b
    jr c, .skip3
    sub b
    ld l, a
    jr .read_area_graphics_index

.skip3:
    push hl
    ld hl, wArenaList
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr c, .skip4
    pop hl
    inc l
    jr .skip2

.skip4:
    inc a
    ld [hl], a
    pop hl
    ld b, l
    ld hl, ArenaEncounterLists
    ld a, [wAreaGraphicsIndex]
    sla a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop bc
    push bc
    ld a, b
    sla a
    ld l, a
    sla a
    add l
    ld hl, wArenaList2
    add_a_to_hl
    ld a, c
    sla a
    add_a_to_hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hl], a
    pop bc
    inc c
    ld a, c
    cp $03
    jp c, .loop2
    ld c, $00
    inc b
    ld a, b
    cp $03
    jp c, .loop2
    ret

; NextTableByte; L = wRandomLo, H = (wRandomLo rotated left through carry) & B; returns A = HL mod
; $52 (E-0117)
RandomModulo52::
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
    ld l, a
    rl a
    and b
    ld h, a
    ld a, $52
    call DivideHLByA
    ret

; A shared return. (C1, E-0357)
ArenaMenu_AfterRoundAgain_Return::
    ret

; Starts talk event group $1F, saving the script position to return to (wScriptReturn). (C1, E-0357)
ArenaMenu_StartArenaTalk_DispatchTalkEvent::
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $1f
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; Sets up an arena round battle: battle intro kind 4, encounter kind 2, and builds the round list.
; (C1, E-0357)
ArenaRounds_RandomModulo52_SetBattleIntroKind::
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    call ArenaRounds_RandomModulo52

; Copies the three foes (6 bytes) of round wArenaRound from wArenaList2 into wEncounterMonsters.
; (C1, E-0357)
ArenaMenu_ReadArenaRound::
    ld a, [wArenaRound]
    sla a
    ld b, a
    sla a
    add b
    ld hl, wArenaList2
    add_a_to_hl
    ld de, wEncounterMonsters
    ld b, $06

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; Starts the arena talk event (group $18), saving the script position to return to. (C1, E-0357)
ArenaMenu_DispatchTalkEvent::
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $18
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; Sets up an arena grid battle: intro kind 4, encounter kind 2, and the three foes of entry
; wScreenCountPlusOne from the grid table. (C1, E-0357)
ArenaGridBattle_WriteBattleIntroKindAndEncounterKind::
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    ld hl, ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_Data
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wScreenCountPlusOne]
    sla a
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
    ld de, wEncounterMonsters
    ld b, $06

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; Starts the arena talk event (group $18), saving the script position to return to. (C1, E-0357)
ArenaMenu_DispatchTalkEvent_SetScriptReturnBank::
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $18
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; Sets up a grid battle from GridEncounterTable: the table chosen by wGridCursorX, entry
; wScreenCountPlusOne, three foes into wEncounterMonsters. (C1, E-0357)
ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_SetBattleIntroKind::
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    ld a, [wGridCursorX]
    sla a
    ld hl, GridEncounterTable
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wScreenCountPlusOne]
    sla a
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
    ld de, wEncounterMonsters
    ld b, $06

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; Judges the party for the arena: from the average strength picks a message level 0-5 (80 or more,
; 60, 40, 30, any, none) in wTwoChoiceCursor. (C1, E-0357)
ArenaMenu_WriteTwoChoiceCursor::
    call ArenaMenu_AddTemp0WordToHL
    call ArenaMenu_DivideHLByA
    ld a, l
    cp $50
    jr nc, .skip
    cp $3c
    jr nc, .skip2
    cp $28
    jr nc, .skip3
    cp $1e
    jr nc, .skip4
    cp $00
    jr nc, .set_two_choice_cursor_to_04
    ld a, $05
    jr .set_two_choice_cursor

.skip:
    xor a
    jr .set_two_choice_cursor

.skip2:
    ld a, $01
    jr .set_two_choice_cursor

.skip3:
    ld a, $02
    jr .set_two_choice_cursor

.skip4:
    ld a, $03
    jr .set_two_choice_cursor

.set_two_choice_cursor_to_04:
    ld a, $04

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    ret

; Picks a random item prize: one of seven entries of the list chosen by the random value's low two
; bits (ArenaMenu_PickPrize_RandomModulo52_Data), into wArg1. (C1, E-0357)
ArenaMenu_PickPrize_RandomModulo52::
    ld b, $1f
    call RandomModulo52
    ld c, l
    ld a, l
    and $03
    sla a
    ld hl, ArenaMenu_PickPrize_RandomModulo52_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, c

.cp_07:
    cp $07
    jr c, .skip
    sub $07
    jr .cp_07

.skip:
    add e
    ld e, a
    jr nc, .set_arg1
    inc d

.set_arg1:
    ld a, [de]
    ld [wArg1], a
    ret

; data read by ArenaMenu (36 bytes) (E-0347)
ArenaMenu_PickPrize_RandomModulo52_Data::
    db $40, $75, $47, $75, $4e, $75, $55, $75, $40, $41, $42, $43, $44, $45, $46, $47
    db $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $5a, $5b, $5c, $5d
    db $5e, $5f, $60, $61

; Gives item prize wArg1: put in the first free inventory slot (A = 0), or, with a full inventory,
; 6,000 gold instead (A = 2); the item's name goes in the text buffer either way. (C1, E-0357)
ArenaMenu_PickPrize_AddArg1ToGoldCapped99999_2::
    ld hl, wInventory
    ld c, $18

.loop:
    ld a, [hl]
    and a
    jr z, .read_arg1
    cp $ff
    jr z, .read_arg1
    inc hl
    dec c
    jr nz, .loop
    ld a, [wArg1]
    push af
    call ArenaMenu_PickPrize_AddArg1ToGoldCapped99999
    pop af
    ld [wArg1], a
    call ArenaMenu_PickPrize_ReadFarPointerAtDEInBankB
    ld a, $02
    ret

.read_arg1:
    ld a, [wArg1]
    ld [hl], a
    call ArenaMenu_PickPrize_ReadFarPointerAtDEInBankB
    xor a
    ret

; Copies the name of item wArg1 (through the far pointer table in bank $08) to wTextBuf1. (C1,
; E-0357)
ArenaMenu_PickPrize_ReadFarPointerAtDEInBankB::
    ld de, ArenaMenu_PickPrize_ReadFarPointerAtDEInBankB_Data
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld c, l
    ld b, h
    ld a, [wArg1]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld l, c
    ld h, b
    add hl, de
    ld e, l
    ld d, h
    ld b, $08
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld hl, wTextBuf1

.call_read_byte_in_bank:
    ld b, $08
    call ReadByteInBank
    ld a, c
    cp $f0
    jr z, .done
    ld [hli], a
    inc de
    jr .call_read_byte_in_bank

.done:
    ld a, $f0
    ld [hli], a
    ret

; Adds 6,000 ($1770) gold, capped at 99,999. (C1, E-0357)
ArenaMenu_PickPrize_AddArg1ToGoldCapped99999::
    ld hl, $1770
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    farcall AddArg1ToGoldCapped99999
    ret

; data read by ArenaMenu_PickPrize (48 bytes) (E-0347)
ArenaMenu_PickPrize_Data1::
    db $de, $75, $de, $75, $de, $75, $e7, $75, $f0, $75, $f9, $75, $19, $23, $2d, $37
    db $41, $4b, $5f, $64, $ff, $14, $1f, $2a, $35, $40, $4b, $5a, $64, $ff, $0f, $17
    db $1f, $27, $2f, $37, $50, $64, $ff, $0a, $15, $20, $2b, $36, $41, $50, $64, $ff

ArenaMenu_PickPrize_Data2::
    db $0e, $76, $0e, $76, $0e, $76, $16, $76, $1e, $76, $26, $76, $01, $53, $05, $0c
    db $24, $0b, $1c, $44, $02, $18, $0f, $10, $13, $15, $45, $fe, $03, $0d, $11, $12
    db $17, $2c, $fd, $fe, $23, $2c, $0d, $0e, $17, $fd, $1e, $fe

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 17 x 9 tiles, one row per line
ArenaMenu_DrawClassChooser_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $aa, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $c3, $e1, $e0, $e0, $bf, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $a9, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $c3, $e5, $e0, $e0, $bf, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $a8, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $e1, $e0, $e0, $e0, $bf, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $a7, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $e5, $e0, $e0, $e0, $bf, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 3 x 5 tiles, one row per line
ArenaMenu_CopyScreenBufferRectWithAttrs_0C_TileRect::
    db $c3, $c3, $b7 ; id 0
    db $e0, $bf, $b7 ; id 1
    db $c3, $c3, $b7 ; id 2
    db $e0, $bf, $b7 ; id 3
    db $b4, $b4, $b5 ; id 4

ArenaMenu_DrawClassPanel_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $aa, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $e1, $e0, $e0, $e0, $bf, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a9, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $e2, $e0, $e0, $e0, $bf, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $a8, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $e3, $e0, $e0, $e0, $bf, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $a7, $c3, $aa, $a4, $a5, $a6, $a6, $c3, $e5, $e0, $e0, $e0, $bf, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

ArenaMenu_ClosePanelBox_TileRect::
    db $c3, $c3, $b7 ; id 0
    db $bf, $c3, $b7 ; id 1
    db $c3, $c3, $b7 ; id 2
    db $bf, $c3, $b7 ; id 3
    db $b4, $b4, $b5 ; id 4

; record: 8 x 3 tiles, one row per line
ArenaMenu_Number24ToPackedBCD_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; no reference found; the bytes form a window frame with the frame tiles used by the referenced
; rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5
; (E-0234, C1)
; record: 13 x 7 tiles, one row per line
TileRect0C_1::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f0, $f1, $f2, $f3, $f4, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $a4, $a5, $a6, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f5, $f6, $f7, $f8, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

TileRect0C_2::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $e1, $c3, $e2, $c3, $e3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; record: 8 x 5 tiles, one row per line
TileRect0C_3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ac, $c3, $ab, $c3, $aa, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a9, $c3, $a8, $c3, $a7, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
ShowTwoChoiceBoxAtWindowTileBufferRow13Col14_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ae, $af, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data2::
    db $ca, $c3, $f2, $c3, $1a, $c4, $42, $c4

ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data2::
    db $c9, $c3, $f1, $c3, $19, $c4, $41, $c4, $8d, $c3, $8f, $c3, $91, $c3, $8d, $c3
    db $8f, $c3, $91, $c3, $b5, $c3, $b7, $c3, $b9, $c3

ArenaMenu_AskEnterClass_Data::
    db $64, $00, $f4, $01, $e8, $03, $88, $13, $02, $04, $08, $10

ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_Data::
    db $7f, $78, $85, $78, $8b, $78, $91, $78, $83, $00, $84, $00, $83, $00, $85, $00
    db $86, $00, $87, $00, $88, $00, $89, $00, $88, $00

; ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_SetBattleIntroKind sets battle intro 4 and
; encounter kind 2, reads the word at $7897 + 2 * wGridCursorX, then the word at that pointer + 2 *
; wScreenCountPlusOne, and copies 6 bytes from it to wEncounterMonsters (three encounter words, as
; E-0202) (E-0236, C1)
; record: encounter list for this wGridCursorX
GridEncounterTable::
    dw GridEncounterList0 ; id 0
    dw GridEncounterList1 ; id 1
    dw GridEncounterList2 ; id 2
    dw GridEncounterList3 ; id 3

; list 0 of GridEncounterTable (E-0236, C1)
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList0::
    dw GridEncounters0 ; id 0
    dw GridEncounters0_01 ; id 1
    dw GridEncounters0_02 ; id 2

; the three records of GridEncounterList0 (E-0236, C1)
; record: three encounter words copied to wEncounterMonsters
GridEncounters0::
    dw $008a ; id 0 MonsterTable $08A: WindBeast
    dw $008b ; MonsterTable $08B: Gismo
    dw $008c ; MonsterTable $08C: PomPomBom
GridEncounters0_01::
    dw $008d ; id 1 MonsterTable $08D: Devipine
    dw $008e ; MonsterTable $08E: Gulpple
    dw $008f ; MonsterTable $08F: Eggplaton
GridEncounters0_02::
    dw $0090 ; id 2 MonsterTable $090: HammerMan
    dw $0091 ; MonsterTable $091: Stubsuck
    dw $0090 ; MonsterTable $090: HammerMan

; list 1 of GridEncounterTable (E-0236, C1)
GridEncounterList1::
    dw GridEncounters1 ; id 0
    dw GridEncounters1_01 ; id 1
    dw GridEncounters1_02 ; id 2

; the three records of GridEncounterList1 (E-0236, C1)
GridEncounters1::
    dw $0092 ; id 0 MonsterTable $092: TreeBoy
    dw $0093 ; MonsterTable $093: FooHero
    dw $0092 ; MonsterTable $092: TreeBoy
GridEncounters1_01::
    dw $0094 ; id 1 MonsterTable $094: Mommonja
    dw $0095 ; MonsterTable $095: Drygon
    dw $0094 ; MonsterTable $094: Mommonja
GridEncounters1_02::
    dw $0096 ; id 2 MonsterTable $096: HerbMan
    dw $0097 ; MonsterTable $097: DanceVegi
    dw $0098 ; MonsterTable $098: MudDoll

; list 2 of GridEncounterTable (E-0236, C1)
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList2::
    dw GridEncounters2 ; id 0
    dw GridEncounters2_01 ; id 1
    dw GridEncounters2_02 ; id 2

; the three records of GridEncounterList2 (E-0236, C1)
; record: three encounter words copied to wEncounterMonsters
GridEncounters2::
    dw $0099 ; id 0 MonsterTable $099: Shadow
    dw $009a ; MonsterTable $09A: MadCondor
    dw $009b ; MonsterTable $09B: CloudKing
GridEncounters2_01::
    dw $009c ; id 1 MonsterTable $09C: Octoreach
    dw $009d ; MonsterTable $09D: Octogon
    dw $009e ; MonsterTable $09E: KingSquid
GridEncounters2_02::
    dw $009f ; id 2 MonsterTable $09F: MistyWing
    dw $00a0 ; MonsterTable $0A0: Copycat
    dw $00a1 ; MonsterTable $0A1: NiteWhip

; list 3 of GridEncounterTable (E-0236, C1)
GridEncounterList3::
    dw GridEncounters3 ; id 0
    dw GridEncounters3_01 ; id 1
    dw GridEncounters3_02 ; id 2

; the three records of GridEncounterList3 (E-0236, C1)
GridEncounters3::
    dw $00a2 ; id 0 MonsterTable $0A2: Goopi
    dw $00a3 ; MonsterTable $0A3: Servant
    dw $00a2 ; MonsterTable $0A2: Goopi
GridEncounters3_01::
    dw $00a4 ; id 1 MonsterTable $0A4: ArmyCrab
    dw $00a5 ; MonsterTable $0A5: DarkCrab
    dw $00a4 ; MonsterTable $0A4: ArmyCrab
GridEncounters3_02::
    dw $00a6 ; id 2 MonsterTable $0A6: Orochi
    dw $00a7 ; MonsterTable $0A7: Serpentia
    dw $00a8 ; MonsterTable $0A8: GigaDraco

; ArenaRounds_RandomModulo52 reads the byte at $78FF + wAreaGraphicsIndex and reduces a random
; number below it by repeated subtraction before indexing the list (E-0183, C1)
; record: number of usable entries in the list (39 each)
ArenaEncounterListSizes::
    db $27 ; id 0
    db $27 ; id 1
    db $27 ; id 2
    db $27 ; id 3
    db $27 ; id 4
    db $27 ; id 5

; ArenaRounds_RandomModulo52 doubles wAreaGraphicsIndex, reads the word at $7905 + 2 * index and
; then the word at that pointer + 2 * the chosen entry; indexes 0-2 share one list (E-0183, C1)
; record: encounter word list for this wAreaGraphicsIndex
ArenaEncounterLists::
    dw ArenaEncounterList0 ; id 0
    dw ArenaEncounterList0 ; id 1
    dw ArenaEncounterList0 ; id 2
    dw ArenaEncounterList1 ; id 3
    dw ArenaEncounterList2 ; id 4
    dw ArenaEncounterList3 ; id 5

; the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ArenaMenu_ReadArenaRound copies
; one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in
; wArenaList (E-0183, C1)
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList0::
    dw $0104 ; entry 0 MonsterTable $104: Lipsy
    dw $0105 ; MonsterTable $105: MultiEyes
    dw $0106 ; MonsterTable $106: Shadow
    dw $0107 ; MonsterTable $107: CaptDead
    dw $0108 ; MonsterTable $108: CurseLamp
    dw $0109 ; MonsterTable $109: Angleron
    dw $010a ; MonsterTable $10A: Gamanian
    dw $010b ; MonsterTable $10B: WhaleMage
    dw $010c ; MonsterTable $10C: SpotKing
    dw $010d ; MonsterTable $10D: SkyDragon
    dw $010e ; MonsterTable $10E: Tonguella
    dw $010f ; MonsterTable $10F: Saccer
    dw $0110 ; MonsterTable $110: Wyvern
    dw $0111 ; MonsterTable $111: AquaHawk
    dw $0112 ; MonsterTable $112: Garudian
    dw $0113 ; MonsterTable $113: Eyeder
    dw $0114 ; MonsterTable $114: ArcDemon
    dw $0115 ; MonsterTable $115: Lionex
    dw $0116 ; MonsterTable $116: GateGuard
    dw $0117 ; MonsterTable $117: Centasaur
    dw $0118 ; MonsterTable $118: Roboster
    dw $0119 ; MonsterTable $119: Eggplaton
    dw $011a ; MonsterTable $11A: Clawster
    dw $011b ; MonsterTable $11B: MerTiger
    dw $0152 ; MonsterTable $152: DragonKid
    dw $0153 ; MonsterTable $153: DuckKite
    dw $0154 ; MonsterTable $154: WingTree
    dw $0155 ; MonsterTable $155: GiantSlug
    dw $0156 ; MonsterTable $156: Gophecada
    dw $0157 ; MonsterTable $157: RotRaven
    dw $0158 ; MonsterTable $158: Chamelgon
    dw $0159 ; MonsterTable $159: MadPecker
    dw $015a ; MonsterTable $15A: MadPlant
    dw $015b ; MonsterTable $15B: FaceTree
    dw $015c ; MonsterTable $15C: BeanMan
    dw $015d ; MonsterTable $15D: Catapila
    dw $015e ; MonsterTable $15E: Facer
    dw $015f ; MonsterTable $15F: Voodoll
    dw $0160 ; MonsterTable $160: Golem
    dw $0161 ; MonsterTable $161: RogueWave

ArenaEncounterList1::
    dw $0136 ; entry 0 MonsterTable $136: Skeletor
    dw $0137 ; MonsterTable $137: StoneMan
    dw $0138 ; MonsterTable $138: FishRider
    dw $0139 ; MonsterTable $139: AxeShark
    dw $013a ; MonsterTable $13A: Aquadon
    dw $013b ; MonsterTable $13B: Digong
    dw $013c ; MonsterTable $13C: MetalKing
    dw $013d ; MonsterTable $13D: Serpentia
    dw $013e ; MonsterTable $13E: Coatol
    dw $013f ; MonsterTable $13F: Orochi
    dw $0140 ; MonsterTable $140: BattleRex
    dw $0141 ; MonsterTable $141: WhipBird
    dw $0142 ; MonsterTable $142: Shantak
    dw $0143 ; MonsterTable $143: Rosevine
    dw $0144 ; MonsterTable $144: Grendal
    dw $0145 ; MonsterTable $145: Akubar
    dw $0146 ; MonsterTable $146: Jamirus
    dw $0147 ; MonsterTable $147: LampGenie
    dw $0148 ; MonsterTable $148: WhiteKing
    dw $0149 ; MonsterTable $149: Niterich
    dw $014a ; MonsterTable $14A: KingSquid
    dw $014b ; MonsterTable $14B: Grakos
    dw $0162 ; MonsterTable $162: BoxSlime
    dw $0163 ; MonsterTable $163: SlimeBorg
    dw $0164 ; MonsterTable $164: DarkHorn
    dw $0165 ; MonsterTable $165: ManEater
    dw $0166 ; MonsterTable $166: Snapper
    dw $0167 ; MonsterTable $167: GhosTree
    dw $0168 ; MonsterTable $168: SkulRider
    dw $0169 ; MonsterTable $169: Gigantes
    dw $016a ; MonsterTable $16A: Skulpent
    dw $016b ; MonsterTable $16B: Aquarella
    dw $016c ; MonsterTable $16C: GoldSlime
    dw $016d ; MonsterTable $16D: GranSlime
    dw $016e ; MonsterTable $16E: Divinegon
    dw $016f ; MonsterTable $16F: KingLeo
    dw $0170 ; MonsterTable $170: RainHawk
    dw $0171 ; MonsterTable $171: Durran
    dw $0172 ; MonsterTable $172: Lazamanus
    dw $0173 ; MonsterTable $173: GoldGolem

ArenaEncounterList2::
    dw $021e ; entry 0 MonsterTable $21E: Phoenix
    dw $021f ; MonsterTable $21F: Shantak
    dw $0220 ; MonsterTable $220: Blizzardy
    dw $0221 ; MonsterTable $221: Skullgon
    dw $0222 ; MonsterTable $222: Akubar
    dw $0223 ; MonsterTable $223: DarkHorn
    dw $0224 ; MonsterTable $224: Serpentia
    dw $0225 ; MonsterTable $225: SuperTen
    dw $0226 ; MonsterTable $226: Unicorn
    dw $0227 ; MonsterTable $227: KiteHawk
    dw $0228 ; MonsterTable $228: FoxFire
    dw $0229 ; MonsterTable $229: MetalDrak
    dw $022a ; MonsterTable $22A: AxeShark
    dw $022b ; MonsterTable $22B: StoneMan
    dw $022c ; MonsterTable $22C: MedusaEye
    dw $022d ; MonsterTable $22D: MadHornet
    dw $022e ; MonsterTable $22E: Oniono
    dw $022f ; MonsterTable $22F: TailEater
    dw $0230 ; MonsterTable $230: BeastNite
    dw $0231 ; MonsterTable $231: MimeSlime
    dw $0232 ; MonsterTable $232: MadDragon
    dw $0233 ; MonsterTable $233: WingSnake
    dw $0234 ; MonsterTable $234: Orochi
    dw $0235 ; MonsterTable $235: Trumpeter
    dw $0236 ; MonsterTable $236: Wyvern
    dw $0237 ; MonsterTable $237: Devipine
    dw $0238 ; MonsterTable $238: Snapper
    dw $0239 ; MonsterTable $239: StagBug
    dw $023a ; MonsterTable $23A: ArmyCrab
    dw $023b ; MonsterTable $23B: ArcDemon
    dw $023c ; MonsterTable $23C: 1EyeClown
    dw $023d ; MonsterTable $23D: MadKnight
    dw $023e ; MonsterTable $23E: CaptDead
    dw $023f ; MonsterTable $23F: Servant
    dw $0240 ; MonsterTable $240: LavaMan
    dw $0241 ; MonsterTable $241: BombCrag
    dw $0242 ; MonsterTable $242: RushFish
    dw $0243 ; MonsterTable $243: WhaleMage
    dw $0244 ; MonsterTable $244: SpotKing
    dw $0245 ; MonsterTable $245: SlimeBorg

ArenaEncounterList3::
    dw $01ff ; entry 0 MonsterTable $1FF: Bubblemon
    dw $0200 ; MonsterTable $200: RogueNite
    dw $0201 ; MonsterTable $201: Puppetor
    dw $0202 ; MonsterTable $202: Exaucers
    dw $0203 ; MonsterTable $203: WhaleMage
    dw $0204 ; MonsterTable $204: MedusaEye
    dw $0246 ; MonsterTable $246: LizardMan
    dw $0247 ; MonsterTable $247: GreatDrak
    dw $0248 ; MonsterTable $248: MadCat
    dw $0249 ; MonsterTable $249: Emyu
    dw $024a ; MonsterTable $24A: HornBeet
    dw $024b ; MonsterTable $24B: Ogre
    dw $024c ; MonsterTable $24C: PutrePup
    dw $024d ; MonsterTable $24D: Roboster2
    dw $024e ; MonsterTable $24E: GoldGolem
    dw $024f ; MonsterTable $24F: WhiteKing
    dw $0250 ; MonsterTable $250: GoldSlime
    dw $0251 ; MonsterTable $251: Divinegon
    dw $0252 ; MonsterTable $252: KingLeo
    dw $0253 ; MonsterTable $253: RainHawk
    dw $0254 ; MonsterTable $254: Rosevine
    dw $0255 ; MonsterTable $255: Armorpion
    dw $0256 ; MonsterTable $256: Durran
    dw $0257 ; MonsterTable $257: Aquadon
    dw $0267 ; MonsterTable $267: MetalKing
    dw $0268 ; MonsterTable $268: Serpentia
    dw $0269 ; MonsterTable $269: IronTurt
    dw $026a ; MonsterTable $26A: ZapBird
    dw $026b ; MonsterTable $26B: FooHero
    dw $026c ; MonsterTable $26C: GoatHorn
    dw $026d ; MonsterTable $26D: Inverzon
    dw $026e ; MonsterTable $26E: Voodoll
    dw $026f ; MonsterTable $26F: AxeShark
    dw $0270 ; MonsterTable $270: Digong
    dw $0271 ; MonsterTable $271: Swordgon
    dw $0272 ; MonsterTable $272: GigaDraco
    dw $0273 ; MonsterTable $273: SuperTen
    dw $0274 ; MonsterTable $274: BigRoost
    dw $0275 ; MonsterTable $275: GhosTree
    dw $0276 ; MonsterTable $276: WarMantis

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_Arena::
    script_command SCRIPT_ARENA
    script_choice_jump Script_ToArena_3, Script_ToArena_9, Script_ToArena_2
Script_ToArena_2::
    script_jump Script_Arena_2
Script_ToArena_9::
    script_jump Script_Arena_9
Script_ToArena_3::
    script_jump Script_Arena_3
Script_Arena_2::
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
    script_choice_jump Script_CongratulationsYouDidIt, Script_ToArena_2_2, Script_TooBadYouDidn
Script_TooBadYouDidn::
    script_command SCRIPT_MENU_CLOSE
    script_message $0025 ; '*: Too bad you didn't make'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_ToArena_2_2::
    script_jump Script_Arena_2
Script_CongratulationsYouDidIt::
    script_message $4020 ; '*: Congratulations! You did it! You've'
    script_command SCRIPT_ARENA
    script_jump Script_Arena_7
Script_Arena_3::
    script_command SCRIPT_ARENA
    script_choice_jump Script_LetMeConfirmThat, Script_You, Script_YouCan, Script_TrainSomeMoreAnd
Script_TrainSomeMoreAnd::
    script_command SCRIPT_MENU_CLOSE
    script_message $8003 ; '*: Train some more, and see'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_YouCan::
    script_message $c016 ; '*: You can't try that Class'
    script_jump Script_Arena_3
Script_You::
    script_message $c001 ; '*: You've finished that Class.'
    script_jump Script_Arena_3
Script_LetMeConfirmThat::
    script_message $c004 ; '*: Let me confirm that-the 0'
    script_command SCRIPT_ARENA
    script_choice_jump Script_GoodLuckI, Script_NotEnoughGoldFor, Script_ToArena_3_2
Script_ToArena_3_2::
    script_jump Script_Arena_3
Script_NotEnoughGoldFor::
    script_message $c006 ; '*: Not enough gold for that'
    script_jump Script_Arena_3
Script_GoodLuckI::
    script_message $c005 ; '*: Good luck! I'll cheer for'
Script_Arena_4::
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
    script_choice_jump Script_ToArena_5, Script_ToArena_4, Script_ToArena_8
Script_ToArena_8::
    script_jump Script_Arena_8
Script_ToArena_4::
    script_jump Script_Arena_4
Script_ToArena_5::
    script_jump Script_Arena_5
Script_Arena_5::
    script_command SCRIPT_ARENA
    script_choice_jump Script_CongratulationsYouDidIt_5, Script_CongratulationsYouDidIt_4, Script_CongratulationsYouDidIt_3, Script_CongratulationsYouDidIt_2
Script_CongratulationsYouDidIt_2::
    script_command SCRIPT_MENU_CLOSE
    script_message $0024 ; '*: Congratulations! You did it! You've'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_CongratulationsYouDidIt_3::
    script_message $4023 ; '*: Congratulations! You did it! You've'
    script_jump Script_Arena_6
Script_CongratulationsYouDidIt_4::
    script_message $4022 ; '*: Congratulations! You did it! You've'
    script_jump Script_Arena_6
Script_CongratulationsYouDidIt_5::
    script_message $4021 ; '*: Congratulations! You did it! You've'
Script_Arena_6::
    script_command SCRIPT_ARENA
    script_choice_jump Script_HeroReceivedTheMagic, Script_OhButYourKey
Script_HeroReceivedTheMagic::
    script_command SCRIPT_MENU_CLOSE
    script_message $802a ; '0 received the Magic Key.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_OhButYourKey::
    script_command SCRIPT_MENU_CLOSE
    script_message $802b ; '*: …Oh, but your key ring'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_Arena_7::
    script_command SCRIPT_ARENA
    script_choice_jump Script_HeroReceivedThePirate, Script_OhButYourKey_2
Script_HeroReceivedThePirate::
    script_command SCRIPT_MENU_CLOSE
    script_message $802d ; '0 received the Pirate Key.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_OhButYourKey_2::
    script_command SCRIPT_MENU_CLOSE
    script_message $802b ; '*: …Oh, but your key ring'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_Arena_8::
    script_command SCRIPT_ARENA
    script_choice_jump Script_TooBadYouDidn_3, Script_TooBadYouDidn_2
Script_TooBadYouDidn_2::
    script_command SCRIPT_MENU_CLOSE
    script_message $0026 ; '*: Too bad you didn't make'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_TooBadYouDidn_3::
    script_command SCRIPT_MENU_CLOSE
    script_message $0025 ; '*: Too bad you didn't make'
    script_command SCRIPT_MENU_CLOSE
    script_end
    db $00, $0b, $c0

Script_Arena_9::
    script_command SCRIPT_ARENA
    script_choice_jump Script_Arena_10, Script_OhTheCrowdWanted
Script_OhTheCrowdWanted::
    script_command SCRIPT_MENU_CLOSE
    script_message $8009 ; '*: Oh… The crowd wanted to'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_Arena_10::
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
Script_ChoiceJump::
    script_choice_jump Script_TheSClassShould, Script_TheAClassShould, Script_TheBClassShould, Script_ItCouldGetRough_2, Script_ItCouldGetRough, Script_TheEClassShould
Script_TheEClassShould::
    script_message $c011 ; '*: The E Class should do.'
    script_jump Script_Arena_11
Script_ItCouldGetRough::
    script_message $c010 ; '*: It could get rough out'
    script_jump Script_Arena_11
Script_ItCouldGetRough_2::
    script_message $c00f ; '*: It could get rough out'
    script_jump Script_Arena_11
Script_TheBClassShould::
    script_message $c00e ; '*: The B Class should be'
    script_jump Script_Arena_11
Script_TheAClassShould::
    script_message $c00d ; '*: The A Class should be'
    script_jump Script_Arena_11
Script_TheSClassShould::
    script_message $c00c ; '*: The S Class should be'
Script_Arena_11::
    script_command SCRIPT_ARENA
    script_choice_jump Script_IsHeroClassOK, Script_OhTheCrowdWanted_2
Script_OhTheCrowdWanted_2::
    script_command SCRIPT_MENU_CLOSE
    script_message $8009 ; '*: Oh… The crowd wanted to'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_IsHeroClassOK::
    script_command SCRIPT_ARENA
    script_message $c012 ; '*: Is 0 Class OK?'
    script_command SCRIPT_ARENA
    script_choice_jump Script_IHopeYouDo, Script_YouNeedMoreGold, Script_Arena_12
Script_Arena_12::
    script_command SCRIPT_ARENA
    script_jump Script_ChoiceJump
Script_YouNeedMoreGold::
    script_message $c014 ; '*: You need more gold to'
    script_command SCRIPT_ARENA
    script_jump Script_ChoiceJump
Script_IHopeYouDo::
    script_command SCRIPT_ARENA
    script_message $c013 ; '*: I hope you do well!'
Script_Arena_13::
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
    script_choice_jump Script_ToCongratulationsYouDidIt_6, Script_ToArena_13, Script_ToArena_16
Script_ToArena_16::
    script_jump Script_Arena_16
Script_ToArena_13::
    script_jump Script_Arena_13
Script_ToCongratulationsYouDidIt_6::
    script_jump Script_CongratulationsYouDidIt_6
Script_CongratulationsYouDidIt_6::
    script_command SCRIPT_ARENA
    script_message $402f ; '*: Congratulations! You did it! You've'
    script_message $c031 ; '*: Do you want the right'
Script_Arena_14::
    script_command SCRIPT_ARENA
    script_choice_jump Script_Arena_15, Script_DoYouWantThe
Script_DoYouWantThe::
    script_message $c030 ; '*: Do you want the left'
    script_command SCRIPT_ARENA
    script_choice_jump Script_Arena_15, Script_DoYouWantThe_2
Script_DoYouWantThe_2::
    script_message $c031 ; '*: Do you want the right'
    script_jump Script_Arena_14
Script_Arena_15::
    script_command SCRIPT_ARENA
    script_choice_jump Script_YourPrizeIsOne, Script_YourPrizeIsA, Script_OhButYouHave, Script_OhButYourKey_3
Script_YourPrizeIsOne::
    script_command SCRIPT_MENU_CLOSE
    script_message $8032 ; '*: Your prize is one G!'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_YourPrizeIsA::
    script_command SCRIPT_MENU_CLOSE
    script_message $8033 ; '*: Your prize is a Magic'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_OhButYouHave::
    script_command SCRIPT_MENU_CLOSE
    script_message $8034 ; '*: …Oh, but you have no'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_OhButYourKey_3::
    script_command SCRIPT_MENU_CLOSE
    script_message $8035 ; '*: …Oh, but your key ring'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_Arena_16::
    script_command SCRIPT_ARENA
    script_choice_jump Script_YouLostThat_2, Script_YouLostThat
Script_YouLostThat::
    script_command SCRIPT_MENU_CLOSE
    script_message $0029 ; '*: You lost? That's too bad.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_YouLostThat_2::
    script_command SCRIPT_MENU_CLOSE
    script_message $0028 ; '*: You lost? That's too bad.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_MedalPrizes::
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_AhYouHaveSome, Script_ToMedalPrizes_2
Script_ToMedalPrizes_2::
    script_jump Script_MedalPrizes_2
Script_AhYouHaveSome::
    script_message $c011 ; '*: Ah, you have some TinyMedals?'
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_MedalPrizes_2, Script_ButICan
Script_ButICan::
    script_message $c012 ; '*: …But, I can't take this'
Script_MedalPrizes_2::
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_IHaveHeroOf, Script_ToAtMinimumYouMust
Script_ToAtMinimumYouMust::
    script_jump Script_AtMinimumYouMust
Script_IHaveHeroOf::
    script_message $c013 ; '*: I have 0 of your'
    script_message $c015 ; '*: Want to trade medals for'
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_WhichPrizeDoYou, Script_IHopeYou
Script_IHopeYou::
    script_command SCRIPT_BREED_CLOSE
    script_message $8014 ; '*: I hope you'll find many'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_WhichPrizeDoYou::
    script_message $c016 ; '*: Which prize do you want?'
Script_MedalPrizes_3::
    script_command SCRIPT_MEDAL_PRIZES
    script_command SCRIPT_MEDAL_PRIZES
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_I, Script_ToMedalPrizes_3, Script_IHopeYou_2
Script_IHopeYou_2::
    script_command SCRIPT_BREED_CLOSE
    script_message $8014 ; '*: I hope you'll find many'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_ToMedalPrizes_3::
    script_jump Script_MedalPrizes_3
Script_I::
    script_message $c017 ; '*: I'll trade for 0 TinyMedals.'
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_MedalPrizes_4, Script_WhichPrizeDoYou_2, Script_ThatRequiresMoreTinyMedals
Script_ThatRequiresMoreTinyMedals::
    script_message $c018 ; '*: That requires more TinyMedals.'
    script_command SCRIPT_MEDAL_PRIZES
Script_WhichPrizeDoYou_2::
    script_message $c016 ; '*: Which prize do you want?'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_MedalPrizes_3
Script_MedalPrizes_4::
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_MedalPrizes_5, Script_YouDon, Script_YourKeyRingIs, Script_YouHaveNoMore
Script_YouHaveNoMore::
    script_message $c01b ; '*: You have no more room'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_YourKeyRingIs::
    script_message $c01a ; '*: Your key ring is already'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_YouDon::
    script_message $c019 ; '*: You don't have any room'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_MedalPrizes_5::
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_FineWeShallTrade_2, Script_FineWeShallTrade
Script_FineWeShallTrade::
    script_message $c01c ; '*: Fine, we shall trade.'
    script_message $c01d ; '*: I'll send the egg to'
    script_jump Script_MedalPrizes_6
Script_FineWeShallTrade_2::
    script_message $c01c ; '*: Fine, we shall trade.'
Script_MedalPrizes_6::
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_MedalPrizes_7, Script_YouCan_3, Script_YouCan_2, Script_YouHaveNoMore_2
Script_YouHaveNoMore_2::
    script_message $c020 ; '*: You have no more room'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_YouCan_2::
    script_message $c01f ; '*: You can't hold any more'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_YouCan_3::
    script_message $c01e ; '*: You can't take any more'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_MedalPrizes_7::
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_WhichPrizeDoYou_2
Script_AtMinimumYouMust::
    script_command SCRIPT_BREED_CLOSE
    script_message $8024 ; '*: At minimum, you must have'
    script_command SCRIPT_BREED_CLOSE
    script_end
    ds $3b9, $00
