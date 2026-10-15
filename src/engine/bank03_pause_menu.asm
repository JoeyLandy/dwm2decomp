; ROM bank $03: pause menu (game mode 2): items, monsters, plan, info
; The annotated listing of this bank is build/listing/bank03.asm.

SECTION "Bank 03", ROMX[$4000], BANK[$03]
    db $03

; start-up for wGameMode = 2; forcing this mode on the emulator shows: monster status panel
; (incomplete when forced) (E-0029)
GameMode2_Init::
    xor a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $01
    jp ResumeAfterModeChange

; game mode 2, the pause menu: by wModeState, its pages Info, Items, Skills and Plan, and its
; closing state (E-0354; was: per-frame routine for wGameMode = 2)
GameMode2_Update::
    ld a, [wWorldMapState]
    bit 7, a
    jr z, GameMode2_Update_OpenPage
    call GameMode2_Update_CountPauseTime
    ld a, [wModeState]
    and $07
    jumptable
    dw PauseMenu_Info
    dw PauseMenu_Items
    dw PauseMenu_Skills
    dw PauseMenu_Plan
    dw PauseMenu_State4

; GameMode2_Update, wModeState 4: hands over to PauseMenu_State4_GiftMenu (state 4) (E-0046)
PauseMenu_State4::
    farcall PauseMenu_State4_GiftMenu
    ret

; Opens a pause menu page in two calls; GameMode2_Update jumps here while wWorldMapState bit 7 is
; clear. First call (wWorldMapState = 0): clears the screen (on CGB white palettes and zero
; attributes), fills the screen buffer with blank tile $C3 and resets the scroll, then
; wWorldMapState += 1. Second call: clears the menu variables, builds the page chosen by wModeState
; & 7 (GameMode2_Update_OpenPage_BuildPage), sets the menu palettes on CGB and marks the page open
; (wWorldMapState = $80). After the staff roll (EVENT_STAFF_ROLL_PARTY_SAVED set,
; EVENT_THANKS_FOR_COMING_BY_025 not yet) it also restores the party count from wScriptTemp4, sets
; that flag, and places the player, the followers and two scene objects for the scene that follows.
; (C1, E-0369)
GameMode2_Update_OpenPage::
    ld a, [wWorldMapState]
    or a
    jp nz, .call_fill_tiles_request
    xor a
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $ff
    call FillBytes
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $2020

.loop:
    xor a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld b, $20
    dec c
    jr nz, .loop
    xor a
    ldh [rVBK], a

.skip:
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
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
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld l, e
    ld h, d
    ld de, wScreenTileBuffer
    lb bc, $14, $12
    call CopyRectToBGMap
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyTileBufferToBGMap
    ld hl, wWorldMapState
    inc [hl]
    ret

.call_fill_tiles_request:
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vTiles2
    ld de, $1007
    call FillTilesRequest
    ld hl, wTemp0
    ld bc, $0020
    xor a
    call FillBytes
    ld hl, wWorkBuf
    ld bc, $0028
    xor a
    call FillBytes
    xor a
    ld [wMenuSelectedMember], a
    ld [wMenuCursor], a
    ld [wSubMenuCursor], a
    ld [wSubMenuCursor2], a
    ld [wMenuOption], a
    ld [wMenuOption2], a
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call GameMode2_Update_OpenPage_BuildPage
    xor a
    ld [rRAMG], a
    xor a
    ld [wLevelUpGains], a
    call CopyTileBufferToBGMap
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wIsCGB]
    or a
    jr z, .set_world_map_state_to_80
    ld hl, wBGPaletteBuffer
    ld a, $39
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld a, $7f
    ld [hli], a
    ld a, $3f
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld de, GameMode2_Update_OpenPage_Data
    ld b, $08

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

.set_world_map_state_to_80:
    ld a, $80
    ld [wWorldMapState], a
    xor a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1c0
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    ret c
    ld de, EVENT_STAFF_ROLL_PARTY_SAVED
    call TestFlagBit
    ret nc
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call SetFlagBit
    ld a, [wStoryFlags + $60]
    set 6, a
    ld [wStoryFlags + $60], a
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, $60
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ld a, $50
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ld a, [wSpriteSlotCount]
    ld [wSpriteSnapshotCount], a
    ld a, $00
    ld [wSpriteSlots], a
    ld a, $01
    ld [wSpriteSlots + $1], a
    ld a, $05
    ld [wSpriteSlots + $2], a
    ld a, $00
    ld [wSpriteSlots + $3], a
    ld a, $40
    ld [wSpriteSlots + $4], a
    ld [wSpriteSlots + $b], a
    ld a, $30
    ld [wSpriteSlots + $5], a
    ld [wSpriteSlots + $c], a
    ld a, $05
    ld [wSpriteSlots + $6], a
    ld a, $00
    ld [wSpriteSlots + $7], a
    ld a, $50
    ld [wSpriteSlots + $8], a
    ld a, $62
    ld [wSpriteSlots + $9], a
    xor a
    ld [wSpriteSlots + $a], a
    xor a
    ld [wSpriteSlots + $d], a
    ld a, $01
    ld [wSpriteSlots + $e], a
    ld a, $02
    ld [wSpriteSlots + $f], a
    ld a, $e0
    ld [wObject1 + $4], a
    ld [wObject1 + OBJ_X], a
    ld [wObject2 + $4], a
    ld [wObject2 + OBJ_X], a
    ret

; Builds the screen of the pause menu page wModeState & 7: 0 the party (Info), 1 and 4 the item
; list, 2 the skills page, 3 the plan page. (C1, E-0357)
GameMode2_Update_OpenPage_BuildPage::
    ld a, [wModeState]
    and $07
    jumptable
    dw PauseMenu_State4_BuildInfoPage
    dw PauseMenu_State4_BuildItemPage
    dw PauseMenu_State4_BuildSkillsPage
    dw PauseMenu_State4_BuildPlanPage
    dw PauseMenu_State4_BuildItemPage

; Builds the Info page: blocks 0-3 with the cursor, the menu tiles and the party's record tiles; the
; cursor ranges over the party (wMenuRowCount = wPartyCount). (C1, E-0357)
PauseMenu_State4_BuildInfoPage::
    call LoadBlankedBlocks00To03WithCursor
    call DecompressMenuTilesTo16E0
    farcall LoadTilesForPartyRecords
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld a, $00
    ld [wMenuPageCount], a
    ld a, $00
    ld [wMenuPage], a
    ret

; Builds the item page: the first inventory page, its frame and the item description. (C1, E-0357)
PauseMenu_State4_BuildItemPage::
    call ResetInventoryMenuToFirstPage
    call BuildInventoryScreenBase
    call ShowString0Bank09AtTiles16E0ThenItemDescription
    ret

; Builds the skills page (blocks $1C and $0C with its heading string) and clears its cursors. (C1,
; E-0357)
PauseMenu_State4_BuildSkillsPage::
    call LoadScreenBlocks1CAnd0C
    call ShowString1Bank09AtTiles16E0ThenDetails
    xor a
    ld [wMenuPageCount], a
    ld [wMenuPage], a
    ld [wMenuItemCount], a
    ld [wMenuSelectedMember], a
    ld [wMenuCursor], a
    ld [wSubMenuCursor], a
    ret

; Builds the plan page (block $21 with its heading string). With wModeState bit 3 set it instead
; jumps straight to the step chosen by the story so far: 6 after the staff roll party was saved (and
; before EVENT_THANKS_FOR_COMING_BY_025), otherwise 1. (C1, E-0357)
PauseMenu_State4_BuildPlanPage::
    ld a, [wModeState]
    bit 3, a
    jr z, .call_load_screen_block21
    ld de, EVENT_THANKS_FOR_COMING_BY_025
    call TestFlagBit
    jr c, .set_temp0_to_01
    ld de, EVENT_STAFF_ROLL_PARTY_SAVED
    call TestFlagBit
    jr c, .set_temp0_to_06

.set_temp0_to_01:
    ld a, $01
    ld [wTemp0], a
    jr .call_load_screen_block21

.set_temp0_to_06:
    ld a, $06
    ld [wTemp0], a
    ret

.call_load_screen_block21:
    call LoadScreenBlock21
    call ShowString2Bank09InWindowThenDefault
    ret

; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks) (E-0353)
ClearScreenTileBuffer_Bank03::
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ret

; HL = header (word offset, width, rows) followed by the tile bytes: copies the rectangle into
; wScreenTileBuffer + offset with rows 32 bytes apart (the same steps as ReadScreenBufferRectHeader
; then CopyRectToStride32) (E-0065) (the same 32 bytes appear in 2 banks)
CopyRecordRectToScreenBuffer_Bank03::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

; copies a rectangle record (offset, width, height, tiles) to the screen buffer, replacing tiles
; $15-$A3 with blank $C3 (E-0125)
CopyRectRecordBlankingText_Bank03::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    cp $15
    jr c, .skip
    cp $a4
    jr nc, .skip
    ld a, $c3

.skip:
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

; copies the 20 x 18 tiles at the start of wScreenTileBuffer to vBGMap0 (CopyRectToBGMap with BC =
; $1412) (E-0353)
CopyTileBufferToBGMap::
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $12

; HL = BG map address, DE = source, B = width, C = rows: writes B bytes per row with WriteVRAMByte
; (HL wraps inside its 32-entry row, then the source and destination each move down 32 and HL is
; masked with $9B) (E-0353)
CopyRectToBGMap::
    push bc
    push hl
    push de

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByte
    ld a, l
    and $1f
    cp $1f
    jr z, .skip
    inc hl
    jr .next

.skip:
    ld a, l
    and $e0
    ld l, a

.next:
    dec b
    jr nz, .loop
    pop de
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    ld a, h
    and $9b
    ld h, a
    pop bc
    dec c
    jr nz, CopyRectToBGMap
    ret

; B = width, C = rows, DE = source, HL = VRAM with rows 32 bytes apart: copies B bytes per row with
; WriteVRAMByteInc, then skips 14 source bytes (rows B + 14 bytes apart, 20 for a 6-wide rectangle);
; B kept, C = 0 (E-0067) (the same 28 bytes appear in 2 banks)
CopyRectToVRAMSourceStrideBPlus14_Bank03::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld a, e
    add $0e
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToVRAMSourceStrideBPlus14_Bank03
    ret

; far-calls RunMoveIncapacitatedPartyMembersBackTwice and reloads the record list name tiles
; (E-0122)
RefreshRecordListAndNameTiles::
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles
    ret

; clears the object flag bits, saves the player position to wWarpDestX/9, whitens the CGB palettes,
; blanks the screen and returns to game mode 1 through InitFieldScreen (E-0125)
ExitPauseMenuToField::
    call ClearBit1OfPlayerAndObjectFlags_Bank03
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    xor a
    ld [wWarpDestFacing], a
    xor a
    ld [rRAMG], a
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $ff
    call FillBytes
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

.skip:
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    call CopyTileBufferToBGMap
    ld hl, wFieldInitStage
    inc [hl]
    farcall InitFieldScreen
    xor a
    ld [wFieldInitStage], a
    ld a, $01
    ld [wGameMode], a
    ret

; clears bit 1 of hPlayerStateFlags and of the flags byte of the five objects at wSpriteSlots + $D,
; wObject1 + $D ... (stride $10) (E-0121)
ClearBit1OfPlayerAndObjectFlags_Bank03::
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld hl, wSpriteSlots + $d
    ld a, [hl]
    and $fd
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and $fd
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and $fd
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and $fd
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; HL = the word at HL + 2 * A; falls through (E-0122)
DerefWordTableEntryA_Bank03::
    add a
    add_a_to_hl
    deref_hl

; wStringCategory = 8, wStringIndex = 5, then falls into the window setup and display (E-0122)
SelectString5Category8ThenShow::
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a

; Shows a string at HL in a 5 x 1 window (falls into ShowStringBank08AtTilesHL_Bank03). (C1, E-0357)
ShowStringIn5x1Window::
    ld de, $0501

; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank08, then restores the window (restores in a different
; register order from the bank-$31 copy, same effect) (E-0067) (the same 59 bytes appear in 2 banks)
ShowStringBank08AtTilesHL_Bank03::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop bc
    ld a, c
    ld [wTextWindowRows], a
    ld a, b
    ld [wTextWindowWidth], a
    pop bc
    ld a, c
    ld [wTextWindowTileLo], a
    ld a, b
    ld [wTextWindowTileHi], a
    ret

; copies 10 bytes from HL to wTextBuf0 and writes $F0 after them; HL advances; BC kept (E-0101)
CopyTenBytesToTextBuf0::
    ld de, wTextBuf0
    push bc
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    pop bc
    ret

; HL = cursor byte (low nibble = row, bit 7 = page-changed flag). Up/Down (wJoypadPressedRepeat bits
; 6/7) move the row with wrap over wMenuRowCount, erase the old cursor
; (UpdateMenuCursor_EraseCursor), play sound $69, store the row (clearing bit 7) and draw it
; (UpdateMenuCursor_DrawCursor). When wMenuPageCount >= 2, Left/Right (bits 5/4) step wMenuPage with
; wrap, clamp the row to wMenuLastPageRows - 1 on the last page, set bit 7 and play sound $69. With
; no input the cursor blinks every 16 frames. wFrameCounterLo is reset on each move (E-0060)
UpdateMenuCursor::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .skip
    ld a, [wMenuRowCount]
    dec a
    jr .skip

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_menu_page_count
    ld a, [wMenuRowCount]
    ld c, a
    ld a, [hl]
    and $0f
    inc a
    cp c
    jr nz, .skip
    xor a
    jr .skip

.check_menu_page_count:
    ld a, [wMenuPageCount]
    or a
    jr z, .check_frame_counter_lo
    cp $01
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wMenuPage]
    dec a
    cp $ff
    jr nz, .set_menu_page
    ld a, b
    dec a
    jr .set_menu_page

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .check_frame_counter_lo
    ld a, [wMenuPage]
    inc a
    cp b
    jr nz, .set_menu_page
    xor a
    jr .set_menu_page

.skip:
    and $0f
    ld b, a
    ld a, [hl]
    and $0f
    cp b
    jr z, .call_update_menu_cursor_draw_cursor
    push de
    call UpdateMenuCursor_EraseCursor
    pop de
    ld a, $69
    call QueueSoundEffect

.call_update_menu_cursor_draw_cursor:
    ld [hl], b
    ld a, b
    call UpdateMenuCursor_DrawCursor
    xor a
    ld [wFrameCounterLo], a
    jr .return

.set_menu_page:
    ld [wMenuPage], a
    inc a
    cp b
    jr nz, .clear_frame_counter_lo
    ld a, [hl]
    and $0f
    ld c, a
    ld a, [wMenuLastPageRows]
    dec a
    cp c
    jr nc, .clear_frame_counter_lo
    jr z, .clear_frame_counter_lo
    push af
    push de
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_EraseCursor
    pop de
    pop af
    ld [hl], a
    call UpdateMenuCursor_DrawCursor

.clear_frame_counter_lo:
    set 7, [hl]
    xor a
    ld [wFrameCounterLo], a
    ld a, $69
    call QueueSoundEffect
    jr .return

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_update_menu_cursor_erase_cursor
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_DrawCursor
    jr .return

.call_update_menu_cursor_erase_cursor:
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_EraseCursor
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

.return:
    ret

; Erases the menu cursor: writes blank tile $C3 at the screen position of row A (from the word table
; at DE). (C1, E-0357)
UpdateMenuCursor_EraseCursor::
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call WaitForVRAMAccess
    ld a, $c3
    ld [de], a
    ei
    ret

; Draws the menu cursor: writes cursor tile $BB at the screen position of row A (from the word table
; at DE). (C1, E-0357)
UpdateMenuCursor_DrawCursor::
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call WaitForVRAMAccess
    ld a, $bb
    ld [de], a
    ei
    ret

; writes the cursor tile $BB into wScreenTileBuffer at the position of
; MenuCursorPositions_Bank03[wMenuSelectedMember & 3] (BG map address + $2998) (E-0101)
DrawMenuCursorTileInBuffer::
    ld a, [wMenuSelectedMember]
    and $03
    ld hl, MenuCursorPositions_Bank03
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $29
    ld h, a
    ld [hl], $bb
    ret

; HL = table of BG map addresses ($98xx), A = index: adds $2998 to entry A, which turns a $9800 BG
; map address into the same position in wScreenTileBuffer ($C198, 32-wide rows), and writes tile $BC
; there (E-0072) (the same 20 bytes appear in 2 banks)
WriteBCTileToScreenBufferAtTableEntry_Bank03::
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $29
    ld h, a
    ld [hl], $bc
    ret

; HL = table of VRAM addresses, A = index: writes tile $BC at the address in entry A (WriteVRAMByte)
; (E-0067) (the same 15 bytes appear in 3 banks)
WriteBCTileAtWordTableEntry_Bank03::
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ret

; The body of ShowStringBank08AtTilesHL_Bank03: saves the string window settings, shows the string
; chosen by wStringCategory/wStringIndex at tiles HL in a window of size DE (ShowString_Bank08), and
; restores the settings. (C1, E-0357)
ShowStringBank08AtTilesHL_Bank03_2::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; Counts time while the pause menu is open: a minutes/seconds/frames timer (wGM2TimerFrames, each
; part wrapping at 60), and the play time (wPlayFrames, seconds, minutes, then the 16-bit hours),
; which stops at 999 hours 59 minutes. (C1, E-0357)
GameMode2_Update_CountPauseTime::
    ld a, [wGM2TimerFrames]
    inc a
    cp $3c
    jr nc, .clear_gm2_timer_frames
    ld [wGM2TimerFrames], a
    jr .read_play_hours_lo

.clear_gm2_timer_frames:
    xor a
    ld [wGM2TimerFrames], a
    ld a, [wGM2TimerSeconds]
    inc a
    cp $3c
    jr nc, .clear_gm2_timer_seconds
    ld [wGM2TimerSeconds], a
    jr .read_play_hours_lo

.clear_gm2_timer_seconds:
    xor a
    ld [wGM2TimerSeconds], a
    ld a, [wGM2TimerMinutes]
    inc a
    cp $3c
    jr nc, .clear_gm2_timer_minutes
    ld [wGM2TimerMinutes], a
    jr .read_play_hours_lo

.clear_gm2_timer_minutes:
    xor a
    ld [wGM2TimerMinutes], a

.read_play_hours_lo:
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03e7
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    or a
    jr nz, .skip
    ld a, [wPlayMinutes]
    cp $3b
    ret z

.skip:
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hld], a
    ld [hl], c
    ret

; ten BG map addresses: rows 3, 5, 7, 9, 11 and 13 of column 1 ($9861 ... $99A1) and rows 1, 3, 5
; and 7 of column 9 ($9829 ... $98E9), indexed by the cursor slot (wMenuSelectedMember & 3 or & 7)
; by the bank-$03 menu cursor routines (E-0101)
MenuCursorPositions_Bank03::
    db $61, $98, $a1, $98, $e1, $98, $21, $99, $61, $99, $a1, $99

PauseMenu_Items_MemberList_Cursor_Data::
    db $29, $98, $69, $98, $a9, $98, $e9, $98

PauseMenu_Items_ChooseItem_ActionCursor_Data::
    db $a1, $98, $e1, $98

PauseMenu_Items_Discard_YesNoCursor_Data::
    db $21, $99, $61, $99

PauseMenu_Plan_Keys_YesNoCursor_Data::
    db $01, $99, $41, $99

PauseMenu_Plan_Keys_Cursor_Data::
    db $47, $99, $87, $99, $c7, $99, $07, $9a

PauseMenu_Plan_Keys_UseOrDiscard_Data::
    db $61, $98, $a1, $98

PauseMenu_Plan_Tactics_Cursor_Data::
    db $4a, $99, $8a, $99, $ca, $99, $0a, $9a

PauseMenu_Plan_PartyOrder_Cursor_Data::
    db $64, $98, $a4, $98, $e4, $98

PauseMenu_Items_UseItem_ChoiceCursor_Data::
    db $2f, $99, $6f, $99

MenuCursorAddressMenuCursor_Data::
    db $82, $99, $84, $99, $86, $99, $88, $99, $8a, $99, $8c, $99, $8e, $99, $90, $99

; runs the routine for wPauseMenuScreen (jump table of four screens) (E-0122)
RunPauseMenuScreen::
    ld a, [wPauseMenuScreen]
    jumptable
    dw RunPauseMenuScreen_PrepareSave
    dw RunPauseMenuScreen_BeforeSave
    dw RunPauseMenuScreen_Save
    dw RunPauseMenuScreen_AfterSave

; Saving from the pause menu, screen 0: remembers the current music (in wMenuLastPageRows) and
; clears the save step and record index. (C1, E-0357)
RunPauseMenuScreen_PrepareSave::
    ld a, [wCurrentMusic]
    ld [wMenuLastPageRows], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; Saving, screen 1: moves on at once. (C1, E-0357)
RunPauseMenuScreen_BeforeSave::
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; Saving, screen 2: runs one stage of the save (RunSaveGameSteps_2) per frame until it is done
; (wSaveStep bit 7). (C1, E-0357)
RunPauseMenuScreen_Save::
    farcall RunSaveGameSteps_2
    ld a, [wSaveStep]
    bit 7, a
    ret z
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; Saving, screen 3: moves on (the save is finished). (C1, E-0357)
RunPauseMenuScreen_AfterSave::
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; GameMode2_Update, wModeState 0: INFO, chosen from the field menu: for each party monster its
; level, sex, personality, species and EXP page, its stats page (ATK, DEF, AGL, INT, WLD, HP, MP)
; and its skills page (C2 from E-0322: in game mode 2 wModeState is the field menu's choice, 0 INFO,
; 1 ITEM, 2 SKILLS, 3 PLAN; E-0046 read PLAN as part of this screen) (was PauseMenu_Info)
PauseMenu_Info::
    ld a, [wDataBankSave]
    or a
    jp nz, PauseMenu_Info_PartyOverview
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Info_Page1
    dw PauseMenu_Info_Page2
    dw PauseMenu_Info_Page3
    dw PauseMenu_Info_Page4
    dw PauseMenu_Info_ExitToField

; builds screen blocks 0-3 (blanked first, with the cursor) and runs the menu cursor (renamed from
; PauseMenu_Info_Blocks00To03 from its E-0357 note, E-0367)
PauseMenu_Info_Page1::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Page1_Build
    dw PauseMenu_Info_Page1_Draw
    dw PauseMenu_Info_Page1_Cursor
    dw PauseMenu_Info_Page1_Idle

; Info page 1, step 0: on the first visit builds blocks 0-3 with the cursor and draws them. (C1,
; E-0357)
PauseMenu_Info_Page1_Build::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .skip
    call LoadBlankedBlocks00To03WithCursor
    call CopyTileBufferToBGMap

.skip:
    ld hl, wTemp1
    inc [hl]

; Info page 1, step 3: nothing (the page waits here). (C1, E-0357)
PauseMenu_Info_Page1_Idle::
    ret

; Info page 1, step 1: draws the selected member's picture and its level and status row, then copies
; the whole screen to the BG map. (C1, E-0357)
PauseMenu_Info_Page1_Draw::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .skip
    call LoadScreenBlocks00To03

.skip:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call DrawRecordMonsterPictureForMenuSelectedMember
    xor a
    ld [rRAMG], a
    call WithSRAMDrawBuildRecordLevelAndStatusRow
    ld hl, vBGMap0
    lb bc, $14, $12
    ld de, wScreenTileBuffer
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 1, step 2: the party cursor. Up/Down redraw the page for the new member, A turns to the
; next page (sound $69), B leaves the menu, Select sets wDataBankSave to 1. (C1, E-0357)
PauseMenu_Info_Page1_Cursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    xor a
    ld [wTemp1], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld hl, wTemp0
    inc [hl]
    xor a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    call ExitPauseMenuToField
    ret

.check_bit2:
    bit 2, a
    jr z, .return
    ld a, $01
    ld [wDataBankSave], a
    xor a
    ld [wTemp1], a
    ret

.return:
    ret

; builds screen blocks 0 and 4-6 and draws meta-sprite part $C0 (the INFO panel's monster, E-0046)
; (renamed from PauseMenu_Info_Blocks04To06 from its E-0357 note, E-0367)
PauseMenu_Info_Page2::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Page2_Build
    dw PauseMenu_Info_Page2_Draw
    dw PauseMenu_Info_Page2_Cursor

; Info page 2, step 0: on the first visit builds blocks 0 and 4-6 with the cursor. (C1, E-0357)
PauseMenu_Info_Page2_Build::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .done
    call LoadBlankedBlocks00And04To06WithCursor
    call CopyTileBufferToBGMap

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 2, step 1: draws the member's stats (BuildRecordLevelAndStatusRow and the strings of
; WithSRAMDrawBuildRecordLevelAndStatusRow_2) and decompresses its sprite to vTiles0. (C1, E-0357)
PauseMenu_Info_Page2_Draw::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .call_with_sram_draw_build_record_level_and
    call LoadScreenBlocks00And04To06

.call_with_sram_draw_build_record_level_and:
    call WithSRAMDrawBuildRecordLevelAndStatusRow_2
    ld hl, vBGMap0 + $21
    lb bc, $13, $11
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    call DecompressRecordSpeciesGraphicsToTiles0
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 2, step 2: draws the member's sprite (DrawMetaSpritePartC0) and runs the cursor: Up/Down
; change member, A the next page, B the previous page, Select sets wDataBankSave to 1. (C1, E-0357)
PauseMenu_Info_Page2_Cursor::
    farcall DrawMetaSpritePartC0
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    xor a
    ld [wTemp1], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld hl, wTemp0
    inc [hl]
    xor a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    ld hl, wTemp0
    dec [hl]
    xor a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

.check_bit2:
    bit 2, a
    jr z, .return
    ld a, $01
    ld [wDataBankSave], a
    xor a
    ld [wTemp1], a
    ret

.return:
    ret

; builds screen blocks 0, 7 and 8 and runs the menu cursor (renamed from
; PauseMenu_Info_Blocks07And08 from its E-0357 note, E-0367)
PauseMenu_Info_Page3::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Page3_Build
    dw PauseMenu_Info_Page3_Draw
    dw PauseMenu_Info_Page3_Cursor

; Info page 3, step 0: on the first visit builds blocks 0, 7 and 8 with the cursor. (C1, E-0357)
PauseMenu_Info_Page3_Build::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .done
    call LoadBlankedBlocks00_07_08WithCursor
    call CopyTileBufferToBGMap

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 3, step 1: shows the member's species and skill names. (C1, E-0357)
PauseMenu_Info_Page3_Draw::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .call_with_sram_show_record_species_and_skill
    call LoadScreenBlocks00_07_08

.call_with_sram_show_record_species_and_skill:
    call WithSRAMShowRecordSpeciesAndSkillNames
    ld hl, vBGMap0 + $21
    lb bc, $13, $11
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 3, step 2: the cursor: Up/Down change member, A the next page, B the previous page,
; Select sets wDataBankSave to 1. (C1, E-0357)
PauseMenu_Info_Page3_Cursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    xor a
    ld [wTemp1], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld hl, wTemp0
    inc [hl]
    xor a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    ld hl, wTemp0
    dec [hl]
    xor a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

.check_bit2:
    bit 2, a
    jr z, .return
    ld a, $01
    ld [wDataBankSave], a
    xor a
    ld [wTemp1], a
    ret

.return:
    ret

; builds screen blocks 0, 9 and $0A and runs the menu cursor (renamed from
; PauseMenu_Info_Blocks09And0A from its E-0357 note, E-0367)
PauseMenu_Info_Page4::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Page4_Build
    dw PauseMenu_Info_Page4_Draw
    dw PauseMenu_Info_Page4_Cursor

; Info page 4, step 0: on the first visit builds blocks 0, 9 and $0A with the cursor. (C1, E-0357)
PauseMenu_Info_Page4_Build::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .done
    call LoadBlankedBlocks00_09_0AWithCursor
    call CopyTileBufferToBGMap

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 4, step 1: draws the member's family (parents' names and icons) and loads the party's
; sprite graphics. (C1, E-0357)
PauseMenu_Info_Page4_Draw::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .call_with_sram_draw_member_record_family
    call LoadScreenBlocks00_09_0A

.call_with_sram_draw_member_record_family:
    call WithSRAMDrawMemberRecordFamily
    ld hl, vBGMap0 + $21
    lb bc, $13, $11
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    call PauseMenu_Info_Page4_Draw_LoadPartySprites
    ld hl, wTemp1
    inc [hl]
    ret

; Info page 4, step 2: draws the party's sprites; Up/Down change member, A closes the pages
; (clearing the sprites), B goes back a page. (C1, E-0357)
PauseMenu_Info_Page4_Cursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    xor a
    ld [wTemp1], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .read_work_buf
    ld a, $69
    call QueueSoundEffect
    xor a
    ldh [hOamNextEntry], a
    ld hl, wShadowOAM
    ld bc, $00a0
    call FillBytes
    ld hl, wTemp0
    inc [hl]
    ret

.read_work_buf:
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall DrawPartySpeciesSprites
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit2
    ld hl, wTemp0
    dec [hl]
    xor a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

.check_bit2:
    bit 2, a
    jr z, .return
    ld a, $01
    ld [wDataBankSave], a
    xor a
    ld [wTemp1], a
    ret

.return:
    ret

; Info, step 4: leaves the pause menu for the field (ExitPauseMenuToField). (C1, E-0357)
PauseMenu_Info_ExitToField::
    call ExitPauseMenuToField
    ret

; clears the screen tile buffer, copies blocks $00-$03 into it, then wPauseMenuScreen += 1 (E-0117)
LoadScreenBlocks00To03::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $01
    farcall CopyBlockToTileBuffer
    ld e, $02
    farcall CopyBlockToTileBuffer
    ld e, $03
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $04, $05, $06, then wPauseMenuScreen += 1
; (E-0117)
LoadScreenBlocks00And04To06::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $04
    farcall CopyBlockToTileBuffer
    ld e, $05
    farcall CopyBlockToTileBuffer
    ld e, $06
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $07, $08, then wPauseMenuScreen += 1 (E-0117)
LoadScreenBlocks00_07_08::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $07
    farcall CopyBlockToTileBuffer
    ld e, $08
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $09, $0A, then wPauseMenuScreen += 1 (E-0117)
LoadScreenBlocks00_09_0A::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $09
    farcall CopyBlockToTileBuffer
    ld e, $0a
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies block $2D + wPartyCount and block $31, then wPauseMenuScreen
; += 1 (E-0117)
LoadScreenBlockForPartySize::
    call ClearScreenTileBuffer_Bank03
    ld a, [wPartyCount]
    add $2d
    ld e, a
    farcall CopyBlockToTileBuffer
    ld e, $31
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00-$03 with CopyBlockToTileBufferBlankingText, then
; DrawMenuCursorTileInBuffer (E-0117)
LoadBlankedBlocks00To03WithCursor::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $01
    farcall CopyBlockToTileBufferBlankingText
    ld e, $02
    farcall CopyBlockToTileBufferBlankingText
    ld e, $03
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; as LoadBlankedBlocks00To03WithCursor with blocks $00, $04, $05, $06 (E-0117)
LoadBlankedBlocks00And04To06WithCursor::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $04
    farcall CopyBlockToTileBufferBlankingText
    ld e, $05
    farcall CopyBlockToTileBufferBlankingText
    ld e, $06
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; as LoadBlankedBlocks00To03WithCursor with blocks $00, $07, $08 (E-0117)
LoadBlankedBlocks00_07_08WithCursor::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $07
    farcall CopyBlockToTileBufferBlankingText
    ld e, $08
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; as LoadBlankedBlocks00To03WithCursor with blocks $00, $09, $0A (E-0117)
LoadBlankedBlocks00_09_0AWithCursor::
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $09
    farcall CopyBlockToTileBufferBlankingText
    ld e, $0a
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; decompresses Tiles1Plus6E0Gfx (bank $16) to vTiles1 + $6E0, then runs
; DrawRecordMonsterPictureForMenuSelectedMember (E-0122)
DecompressMenuTilesTo16E0::
    ld b, $16
    ld de, Tiles1Plus6E0Gfx
    ld hl, vTiles1 + $6e0
    call DecompressToVRAM
    call DrawRecordMonsterPictureForMenuSelectedMember
    ret

; loads the picture of the species of record wMenuSelectedMember & $0F at vTiles2 + $5C0; on CGB
; also uploads palettes and copies its 6 x 6 attribute block to vBGMap0 + $161 (E-0125)
DrawRecordMonsterPictureForMenuSelectedMember::
    ld c, $0b
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld hl, vTiles2 + $5c0
    ld c, $01
    call LoadMonsterPicture
    pop de
    ld a, [wIsCGB]
    or a
    jr z, .return
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    pop de
    ld a, $01
    ldh [hTemp0], a
    ld hl, wScreenAttrBuffer
    call LoadMonsterPictureAttributeBlock
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld hl, vBGMap0 + $161
    ld de, wScreenAttrBuffer
    lb bc, $06, $06
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a

.return:
    ret

; with SRAM bank 0 enabled runs BuildRecordLevelAndStatusRow and
; WithSRAMDrawBuildRecordLevelAndStatusRow_DrawStats (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was WithSRAMDrawBuildRecordLevelAndStatusRow)
WithSRAMDrawBuildRecordLevelAndStatusRow::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call BuildRecordLevelAndStatusRow
    call WithSRAMDrawBuildRecordLevelAndStatusRow_DrawStats
    xor a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled runs BuildRecordLevelAndStatusRow and
; WithSRAMDrawBuildRecordLevelAndStatusRow_2_ShowStringBank08AtTilesHL_Bank03 (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was
; WithSRAMDrawBuildRecordLevelAndStatusRow_2)
WithSRAMDrawBuildRecordLevelAndStatusRow_2::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call BuildRecordLevelAndStatusRow
    call WithSRAMDrawBuildRecordLevelAndStatusRow_2_ShowStringBank08AtTilesHL_Bank03
    xor a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled runs ShowRecordSpeciesAndSkillNames (E-0122)
WithSRAMShowRecordSpeciesAndSkillNames::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call ShowRecordSpeciesAndSkillNames
    xor a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled, reads byte $0D of the selected member's record (wMenuSelectedMember) and
; draws species name and icon (ShowSpeciesNameAndIconForSlotB) from it and the following word unless
; it is $FFFF (E-0122, E-0259) (E-0345: record byte $0D is MON_FAMILY; was
; WithSRAMDrawMemberRecordFamily)
WithSRAMDrawMemberRecordFamily::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call WithSRAMDrawMemberRecordFamily_ShowSpeciesNameAndIconForSlotB
    xor a
    ld [rRAMG], a
    ret

; writes record wMenuSelectedMember's level (field $56, marked with tile $14 at the cap in field
; $57), status marks from field $55 and the field $0E mark into the row at wScreenTileBuffer + $29
; (E-0127)
BuildRecordLevelAndStatusRow::
    ld hl, wScreenTileBuffer + $29
    ld a, $c3
    ld [hli], a
    ld a, $ea
    ld [hli], a
    ld a, $ed
    ld [hli], a
    ld a, $c3
    ld [hli], a
    ld a, $c3
    ld [hli], a
    ld a, $c3
    ld [hli], a
    ld a, $c3
    ld [hli], a
    ld [hl], $c3
    ld c, $56
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    push hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $2c
    call WriteTwoDigitTilesFromDigits1
    pop hl
    ld a, [hli]
    cp [hl]
    jr c, .check_menu_selected_member
    ld a, $14
    ld [wScreenTileBuffer + $29], a

.check_menu_selected_member:
    ld c, $55
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    jr z, .check_menu_selected_member2
    bit 7, a
    call nz, SetScreenTileBufferRow2Col8TileC2
    bit 0, a
    call nz, SetScreenTileBufferRow2Col6TileC0
    bit 2, a
    call nz, SetScreenTileBufferRow2Col7TileC1

.check_menu_selected_member2:
    ld c, $0e
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hl]
    and $01
    add $cc
    ld [wScreenTileBuffer + $32], a
    ret

; wScreenTileBuffer + $30 = $C2; AF kept (E-0119) (E-0340: the address in its name read as its RAM
; name; was SetScreenTileBufferRow2Col8TileC2)
SetScreenTileBufferRow2Col8TileC2::
    push af
    ld a, $c2
    ld [wScreenTileBuffer + $30], a
    pop af
    ret

; wScreenTileBuffer + $2E = $C0; AF kept (E-0119) (E-0340: the address in its name read as its RAM
; name; was SetScreenTileBufferRow2Col6TileC0)
SetScreenTileBufferRow2Col6TileC0::
    push af
    ld a, $c0
    ld [wScreenTileBuffer + $2e], a
    pop af
    ret

; wScreenTileBuffer + $2F = $C1; AF kept (E-0119) (E-0340: the address in its name read as its RAM
; name; was SetScreenTileBufferRow2Col7TileC1)
SetScreenTileBufferRow2Col7TileC1::
    push af
    ld a, $c1
    ld [wScreenTileBuffer + $2f], a
    pop af
    ret

; Draws the selected member's stat numbers (record of wMenuSelectedMember & $0F, SRAM already
; enabled by WithSRAMDrawBuildRecordLevelAndStatusRow) as three digit tiles each (HLToDecimalDigits,
; WriteDecimalDigitTiles): MON_ATK, MON_DEF, MON_AGL and MON_INT into wScreenTileBuffer + $70, $B0,
; $F0 and $130, MON_WLD into wWindowTileBuffer + $8, then MON_HP, MON_MAX_HP, MON_MP and MON_MAX_MP
; into wWindowTileBuffer + $64, $68, $A4 and $A8. (C1, E-0369)
WithSRAMDrawBuildRecordLevelAndStatusRow_DrawStats::
    ld c, $63
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $70
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $b0
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $f0
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $130
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    push hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $8
    call WriteDecimalDigitTiles
    pop hl
    ld a, l
    add $f0
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $64
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $68
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a4
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a8
    call WriteDecimalDigitTiles
    ret

; Draws the member's details on Info page 2: its personality string (record byte $A4, category $0B);
; a string from category 7 picked by three record bytes from offset $6F (each below $40, $40-$BF or
; from $C0); its species name; the member number tile and its plus value (record byte $6D, '+' and
; up to two digits); its name; its experience (24-bit, from offset $58) and the experience still
; needed for the next level (from the species' growth curve, LoadExpTableEntryToTemp2), 0 at the
; level cap. (C1, E-0357)
WithSRAMDrawBuildRecordLevelAndStatusRow_2_ShowStringBank08AtTilesHL_Bank03::
    ld c, $a4
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $0b
    ld [wStringCategory], a
    ld hl, vTiles2 + $350
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $6f
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    cp $40
    jr c, .skip
    cp $c0
    jr c, .skip2
    ld c, $00
    jr .skip3

.skip:
    ld c, $12
    jr .skip3

.skip2:
    ld c, $09

.skip3:
    ld a, [hli]
    inc hl
    cp $40
    jr c, .skip4
    cp $c0
    jr c, .skip5
    ld b, $00
    jr .skip6

.skip4:
    ld b, $02
    jr .skip6

.skip5:
    ld b, $01

.skip6:
    ld a, [hl]
    cp $40
    jr c, .skip7
    cp $c0
    jr c, .skip8
    xor a
    jr .set_string_index

.skip7:
    ld a, $06
    jr .set_string_index

.skip8:
    ld a, $03

.set_string_index:
    add b
    add c
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, vTiles2 + $4c0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $0b
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    add $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $550
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    ld a, [wMenuSelectedMember]
    and $0f
    add $c7
    ld [wScreenTileBuffer + $e9], a
    ld a, $c3
    ld [wScreenTileBuffer + $ea], a
    ld [wScreenTileBuffer + $eb], a
    ld [wScreenTileBuffer + $ec], a
    ld c, $6d
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    jr z, .check_menu_selected_member
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld hl, wScreenTileBuffer + $eb
    ld a, [wDigits + $1]
    or a
    jr z, .read_digits
    add $e0
    ld [hli], a

.read_digits:
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, $fc
    ld [wScreenTileBuffer + $ea], a

.check_menu_selected_member:
    ld c, $0f
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    call CopyTenBytesToTextBuf0
    ld hl, vTiles2 + $470
    call SelectString5Category8ThenShow
    ld c, $58
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld [wDigits], a
    ld e, a
    ld a, [hli]
    ld [wDigits + $1], a
    ld d, a
    ld a, [hl]
    ld [wDigits + $2], a
    ld c, a
    push bc
    push de
    call Number24ToPackedBCD
    ld de, wWindowTileBuffer + $24
    call WithSRAMDraw_WriteDigitTilesNoLeadingZeros
    ld c, $0b
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    ld c, $56
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hl]
    ldh [hTemp1], a
    farcall LoadExpTableEntryToTemp2
    ld c, $56
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    pop de
    pop bc
    ld a, [hli]
    cp [hl]
    jr nc, .clear_digits
    ldh a, [hTemp2]
    sub e
    ld [wDigits], a
    ldh a, [hTemp3]
    sbc d
    ld [wDigits + $1], a
    ldh a, [hTemp4]
    sbc c
    ld [wDigits + $2], a
    jr .call_number24_to_packed_bcd

.clear_digits:
    xor a
    ld [wDigits], a
    ld [wDigits + $1], a
    ld [wDigits + $2], a

.call_number24_to_packed_bcd:
    call Number24ToPackedBCD
    ld de, wWindowTileBuffer + $a4
    call WithSRAMDraw_WriteDigitTilesNoLeadingZeros
    ret

; for SRAM record wMenuSelectedMember & $0F: shows the species category $0D string at vTiles2 + $2C0
; and the eight skills of field $34 in slots 0-7 (E-0121)
ShowRecordSpeciesAndSkillNames::
    ld c, $0b
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_FIELD_ABILITY]
    ld [wStringIndex], a
    ld a, $0d
    ld [wStringCategory], a
    ld hl, vTiles2 + $2c0
    ld de, $0602
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $34
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld b, $00
    call ShowRecordSpeciesAndSkillNames_EmptySlot
    ld a, [hli]
    ld b, $01
    call ShowSkillNameAtSlotB
    ld a, [hli]
    ld b, $02
    call ShowSkillNameAtSlotB
    ld a, [hli]
    ld b, $03
    call ShowSkillNameAtSlotB
    ld a, [hli]
    ld b, $04
    call ShowSkillNameAtSlotB
    ld a, [hli]
    ld b, $05
    call ShowSkillNameAtSlotB
    ld a, [hli]
    ld b, $06
    call ShowSkillNameAtSlotB
    ld a, [hl]
    ld b, $07
    call ShowSkillNameAtSlotB
    ret

; A skill slot holding $FF shows string $0E of category 8 (the empty-slot text) instead of a skill
; name. (C1, E-0357)
ShowRecordSpeciesAndSkillNames_EmptySlot::
    cp $ff
    jr nz, ShowSkillNameAtSlotB
    push hl
    ld a, $08
    ld [wStringCategory], a
    ld a, $0e
    ld [wStringIndex], a
    jr ShowSkillNameAtSlotB_Skip

; A = skill number ($FF shows entry 0), B = slot: wStringIndex = A, wStringCategory = 4
; (StringTable_SkillNames in the bank-$08 database), then ShowStringBank08AtTilesHL_Bank03 with the
; tile address from ShowSkillNameAtSlotB_Data[B] and size $0901; HL kept (E-0076)
ShowSkillNameAtSlotB::
    push hl
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a

; Shows the chosen string in skill slot B's 9 x 1 window (tile address from
; ShowSkillNameAtSlotB_Data). (C1, E-0357)
ShowSkillNameAtSlotB_Skip::
    ld a, b
    ld hl, ShowSkillNameAtSlotB_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop hl
    ret

; data read by ShowSkillNameAtSlotB (16 bytes) (E-0347)
ShowSkillNameAtSlotB_Data::
    db $80, $93, $10, $94, $a0, $94, $30, $95, $c0, $95, $50, $96, $e0, $96, $70, $97

; Draws the member's family on Info page 4 from its record: the two parents' species names and
; icons, their names, and their plus values; the order is set by the high nibble of record byte $0D.
; With no recorded parents ($FFFF) it clears the icon tiles and shows placeholder names. (C1,
; E-0357)
WithSRAMDrawMemberRecordFamily_ShowSpeciesNameAndIconForSlotB::
    ld c, $0d
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hl]
    swap a
    and $0f
    ld [wMenuLastPageRows], a
    ld a, l
    add $0d
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    and [hl]
    dec hl
    cp $ff
    jr z, .skip
    ld a, [wMenuLastPageRows]
    ld b, a
    call ShowSpeciesNameAndIconForSlotB
    ld a, [wMenuLastPageRows]
    xor $01
    ld b, a
    call ShowSpeciesNameAndIconForSlotB
    ld a, [wMenuLastPageRows]
    ld b, a
    call WithSRAMDrawMemberRecordFamily_ShowParentMaster
    ld a, [wMenuLastPageRows]
    xor $01
    ld b, a
    call WithSRAMDrawMemberRecordFamily_ShowParentMaster
    ld a, l
    add $5a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wMenuLastPageRows]
    ld b, a
    call WithSRAMDrawMemberRecordFamily_ShowParentName
    ld a, [wMenuLastPageRows]
    xor $01
    ld b, a
    call WithSRAMDrawMemberRecordFamily_ShowParentName
    ld a, [wMenuLastPageRows]
    add $cc
    ld [wScreenTileBuffer + $6e], a
    xor $01
    ld [wWindowTileBuffer + $26], a
    ret

.skip:
    ld hl, vTiles2 + $580
    ld bc, $0140

.loop:
    ld a, $ff
    call WriteVRAMByteInc
    xor a
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $c3
    ld hl, wScreenTileBuffer + $6a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    inc hl
    ld [hl], a
    ld hl, wWindowTileBuffer + $22
    ld [hli], a
    ld [hli], a
    ld [hli], a
    inc hl
    ld [hl], a
    ld hl, wTextBuf0
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld [hl], $f0
    ld hl, vTiles2 + $580
    call SelectString5Category8ThenShow
    ld hl, vTiles2 + $670
    call ShowStringIn5x1Window
    ld hl, vTiles2 + $6c0
    call ShowStringIn5x1Window
    ld hl, vTiles2 + $7b0
    call ShowStringIn5x1Window
    ret

; reads a species id at [HL] (HL += 2), shows its name (category id-high + 2) at the window from
; ShowSpeciesNameAndIconForSlotB_Data1[B], loads the species record, sets wWorkBuf = family,
; wWorkBuf + $1 = ShowSpeciesNameAndIconForSlotB_Data2[B] and far-calls LoadFamilyIconTileForWorkBuf
; (E-0121)
ShowSpeciesNameAndIconForSlotB::
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld [wStringIndex], a
    ld a, [hli]
    ld [wSpeciesIdHi], a
    add $02
    ld [wStringCategory], a
    push hl
    push bc
    ld hl, ShowSpeciesNameAndIconForSlotB_Data1
    ld a, b
    add a
    add_a_to_hl
    deref_hl
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    ld [wWorkBuf], a
    pop bc
    ld a, b
    ld hl, ShowSpeciesNameAndIconForSlotB_Data2
    add_a_to_hl
    ld a, [hl]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop hl
    ret

; B = parent slot (0 or 1), HL = a 10-byte name in the record: copies it to wTextBuf0
; (CopyTenBytesToTextBuf0), skips one more byte, and shows it (string 5 of category 8, '<BUF0>',
; through DerefWordTableEntryA_Bank03) in a 5 x 1 window at tile address $9670 (B = 0) or $97B0 (B =
; 1); returns HL 11 bytes on, BC kept. WithSRAMDrawMemberRecordFamily_ShowSpeciesNameAndIconForSlotB
; calls it for MON_PARENT1_MASTER (skipping MON_UNUSED_28) and MON_PARENT2_MASTER, in slots B and B
; xor 1. (C1, E-0369)
WithSRAMDrawMemberRecordFamily_ShowParentMaster::
    call CopyTenBytesToTextBuf0
    inc hl
    push hl
    push bc
    ld a, b
    ld hl, WithSRAMDrawMemberRecordFamily_ShowParentMaster_Data
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    ret

; B = parent slot (0 or 1), HL = the parent's 10-byte name in the record: copies it to wTextBuf0 and
; shows it (string 5 of category 8) in a 5 x 1 window at tile address $9580 (B = 0) or $96C0 (B =
; 1); then blanks three tiles at wScreenTileBuffer + $6A (B = 0) or wWindowTileBuffer + $22 (B = 1)
; and, when the next byte (the plus value) is not 0, writes '+' (tile $FC), its tens digit when not
; 0, and its units digit (tiles $E0 + digit) there. Returns HL past the plus byte, BC kept.
; WithSRAMDrawMemberRecordFamily_ShowSpeciesNameAndIconForSlotB calls it for
; MON_PARENT1_NAME/MON_PARENT1_PLUS and MON_PARENT2_NAME/MON_PARENT2_PLUS. (C1, E-0369)
WithSRAMDrawMemberRecordFamily_ShowParentName::
    call CopyTenBytesToTextBuf0
    push hl
    push bc
    ld a, b
    ld hl, WithSRAMDrawMemberRecordFamily_ShowParentName_Data1
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    push hl
    ld a, b
    ld hl, WithSRAMDrawMemberRecordFamily_ShowParentName_Data2
    add a
    add_a_to_hl
    deref_hl
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ld a, [hli]
    push hl
    or a
    jr z, .done
    ld l, a
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, b
    ld hl, WithSRAMDrawMemberRecordFamily_ShowParentName_Data2
    add a
    add_a_to_hl
    deref_hl
    ld a, $fc
    ld [hli], a
    ld a, [wDigits + $1]
    or a
    jr z, .read_digits
    add $e0
    ld [hli], a

.read_digits:
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a

.done:
    pop hl
    ret

; data read by ShowSpeciesNameAndIconForSlotB (4 bytes) (E-0347)
ShowSpeciesNameAndIconForSlotB_Data1::
    db $e0, $95, $20, $97

ShowSpeciesNameAndIconForSlotB_Data2::
    db $5d, $71

WithSRAMDrawMemberRecordFamily_ShowParentMaster_Data::
    db $70, $96, $b0, $97

WithSRAMDrawMemberRecordFamily_ShowParentName_Data1::
    db $80, $95, $c0, $96

WithSRAMDrawMemberRecordFamily_ShowParentName_Data2::
    db $02, $c2, $22, $c3

; reads field $0B of SRAM record wMenuSelectedMember & $0F and decompresses its graphics to vTiles0
; (DecompressGraphicsArg1ToArg4); then sets wArg3-wArg6 = $00, $90, $40, $00 and
; hSpriteWindowClipMode = 0 (E-0121)
DecompressRecordSpeciesGraphicsToTiles0::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld c, $0b
    ld a, [wMenuSelectedMember]
    and $0f
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld hl, vTiles0
    ld a, l
    ld [wArg4], a
    ld a, h
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    xor a
    ld [rRAMG], a
    ld a, $00
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    ld a, $00
    ld [wArg6], a
    xor a
    ldh [hSpriteWindowClipMode], a
    ret

; Loads the sprite graphics of the party starting at the selected member
; (LoadPartySpeciesSpriteGraphics with wArg1 = that entry of wPartyList), with SRAM enabled. (C1,
; E-0357)
PauseMenu_Info_Page4_Draw_LoadPartySprites::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    ld hl, wPartyList
    add_a_to_hl
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    farcall LoadPartySpeciesSpriteGraphics
    xor a
    ld [rRAMG], a
    xor a
    ldh [hSpriteWindowClipMode], a
    ret

; The party overview's steps, by wTemp1: clear the screen, load the pictures, draw them, wait for
; Select, close. (C1, E-0357)
PauseMenu_Info_PartyOverview::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_PartyOverview_Blank
    dw PauseMenu_Info_PartyOverview_Build
    dw PauseMenu_Info_PartyOverview_Draw
    dw PauseMenu_Info_PartyOverview_CloseOnSelect
    dw PauseMenu_Info_PartyOverview_Close

; Party overview step 0: fills the visible BG map with blank tile $C3 (and zero attributes on CGB).
; (C1, E-0357)
PauseMenu_Info_PartyOverview_Blank::
    ld hl, vBGMap0
    ld bc, $1412

.loop:
    ld a, $c3
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld b, $14
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $1412

.loop2:
    xor a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    ld b, $14
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop2
    xor a
    ldh [rVBK], a

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Party overview step 1: builds the frame for the party size and loads each member's monster picture
; (LoadMonsterPicture into its own palette slot), with its HP, MP and level. (C1, E-0357)
PauseMenu_Info_PartyOverview_Build::
    call LoadScreenBlockForPartySize
    call FillTilesFromRequest
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wPartyCount]
    ld b, a
    ld c, $00

.loop:
    push bc
    push bc
    ld a, c
    ld c, MON_SPECIES
    call SRAMRecordAddressMapped
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld hl, PauseMenu_Info_PartyOverview_Build_Data1
    ld a, c
    add_a_to_hl
    ld a, c
    ld c, [hl]
    ld hl, PauseMenu_Info_PartyOverview_Build_Data2
    add a
    add_a_to_hl
    deref_hl
    push de
    call LoadMonsterPicture
    pop de
    pop bc
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_record_hpmp_and_level_for_row_c
    push bc
    ld a, c
    ld hl, PauseMenu_Info_PartyOverview_Build_Data1
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    ld a, c
    ld hl, PauseMenu_Info_PartyOverview_Build_Data3
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    call LoadMonsterPictureAttributeBlock
    pop bc

.call_draw_record_hpmp_and_level_for_row_c:
    call DrawRecordHPMPAndLevelForRowC
    call ShowRecordSpeciesNameForRowC
    call DrawRecordSexMarkTile
    inc c
    dec b
    jr nz, .loop
    ld hl, vTiles1
    ld de, $1202
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    xor a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; for record C writes HP (field $5B), MP (field $5F) and level (field $56) as digits at the
; screen-buffer position DrawRecordHPMPAndLevelForRowC_Data[C] (E-0127)
DrawRecordHPMPAndLevelForRowC::
    push bc
    ld a, c
    ld hl, DrawRecordHPMPAndLevelForRowC_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, c
    ld c, MON_HP
    call SRAMRecordAddressMapped
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    push de
    call HLToDecimalDigits
    pop de
    push de
    call WriteDecimalDigitTiles
    pop de
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop hl
    inc hl
    inc hl
    inc hl
    push hl
    deref_hl
    push de
    call HLToDecimalDigits
    pop de
    push de
    call WriteDecimalDigitTiles
    pop de
    ld a, e
    add $21
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop hl
    ld a, l
    add $f7
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld l, [hl]
    ld h, $00
    push de
    call HLToDecimalDigits
    pop de
    call WriteTwoDigitTilesFromDigits1
    pop bc
    ret

; shows the species name (field $0B) of SRAM record C in the window from
; ShowRecordSpeciesNameForRowC_Data[C], size $0109 (E-0121)
ShowRecordSpeciesNameForRowC::
    push bc
    ld a, c
    ld hl, ShowRecordSpeciesNameForRowC_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, $0901
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, c
    ld c, MON_SPECIES
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    add $02
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop bc
    ret

; C = record: writes tile $CC + (bit 0 of record byte $0E) at the address from
; DrawRecordSexMarkTile_Data[C]; BC kept (E-0120) (E-0345: record byte $0E is MON_SEX; was
; DrawRecordSexMarkTile)
DrawRecordSexMarkTile::
    push bc
    ld a, c
    ld hl, DrawRecordSexMarkTile_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld a, c
    ld c, MON_SEX
    call SRAMRecordAddressMapped
    ld a, [hl]
    pop hl
    and $01
    add $cc
    ld [hl], a
    pop bc
    ret

; data read by PauseMenu_Info_PartyOverview_Build (3 bytes) (E-0347)
PauseMenu_Info_PartyOverview_Build_Data1::
    db $01, $03, $05

PauseMenu_Info_PartyOverview_Build_Data2::
    db $40, $91, $80, $93, $c0, $95

PauseMenu_Info_PartyOverview_Build_Data3::
    db $00, $00, $80, $00, $00, $01

DrawRecordHPMPAndLevelForRowC_Data::
    db $fa, $c1, $00, $c2, $06, $c2

ShowRecordSpeciesNameForRowC_Data::
    db $00, $88, $90, $88, $20, $89

DrawRecordSexMarkTile_Data::
    db $66, $c3, $86, $c3, $a6, $c3

; Party overview step 2: draws the screen, and on CGB copies each member's 6 x 6 picture attributes
; (one, two or three pictures). (C1, E-0357)
PauseMenu_Info_PartyOverview_Draw::
    call CopyTileBufferToBGMap
    ld a, [wIsCGB]
    or a
    jr z, .done
    lb bc, $06, $06
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld hl, vBGMap0 + $e1
    ld de, wScreenAttrBuffer
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wPartyCount]
    cp $01
    jr z, .skip
    ld hl, vBGMap0 + $e7
    ld de, wScreenAttrBuffer + $80
    lb bc, $06, $06
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wPartyCount]
    cp $02
    jr z, .skip
    ld hl, vBGMap0 + $ed
    ld de, wScreenAttrBuffer + $100
    lb bc, $06, $06
    call CopyRectToVRAMSourceStrideBPlus14_Bank03

.skip:
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Party overview step 3: waits for Select. (C1, E-0357)
PauseMenu_Info_PartyOverview_CloseOnSelect::
    ld a, [wJoypadPressed]
    and $04
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

; Party overview step 4: blanks the screen again (tiles $C3, attributes 0), restores the tiles at
; vTiles2 + $140 and returns to the Info pages. (C1, E-0357)
PauseMenu_Info_PartyOverview_Close::
    ld hl, vBGMap0
    ld bc, $1412
    ld d, $c3
    call FillVRAMRowsWithD
    ld a, [wIsCGB]
    or a
    jr z, .call_write_sixteen_tiles_from_at_tiles2140
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $e0
    ld bc, $1406
    ld d, $00
    call FillVRAMRowsWithD
    xor a
    ldh [rVBK], a

.call_write_sixteen_tiles_from_at_tiles2140:
    call WriteSixteenTilesFromAtTiles2140
    xor a
    ld [wDataBankSave], a
    xor a
    ld [wTemp1], a
    xor a
    ld [wPauseMenuScreen], a
    ret

; D = tile, B = first-row width, C = rows: writes D with WriteVRAMByteInc; after each row moves 12
; entries on (to the next 32-entry row) and uses width 20 (E-0117)
FillVRAMRowsWithD::
    ld a, d
    call WriteVRAMByteInc
    dec b
    jr nz, FillVRAMRowsWithD
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $14
    dec c
    jr nz, FillVRAMRowsWithD
    ret

; writes the 16 bytes at WriteSixteenTilesFromAtTiles2140_Data to vTiles2 + $140 (E-0122) (E-0344:
; the address in its name dropped or read as the label there; was WriteSixteenTilesFromAtTiles2140)
WriteSixteenTilesFromAtTiles2140::
    ld de, WriteSixteenTilesFromAtTiles2140_Data
    ld hl, vTiles2 + $140
    ld b, $10

.loop:
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, .loop
    ret

; data read by WriteSixteenTilesFromAtTiles2140 (16 bytes) (E-0347)
WriteSixteenTilesFromAtTiles2140_Data::
    db $ff, $00, $ff, $10, $ff, $10, $ff, $fe, $ff, $7c, $ff, $38, $ff, $7c, $ff, $c6

; GameMode2_Update, wModeState 1: the ITEM list ('No items' at the start of a game) (E-0046)
PauseMenu_Items::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Items_MemberList
    dw PauseMenu_Items_ChooseItem
    dw PauseMenu_Items_UseItem
    dw PauseMenu_Items_Discard

; refreshes the record list and name tiles, then the menu cursor (E-0303)
PauseMenu_Items_MemberList::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_MemberList_Build
    dw PauseMenu_Items_MemberList_Cursor

; Item page, step 0: refreshes the party list after a level-up, then builds the inventory page with
; the selected item's description. (C1, E-0357)
PauseMenu_Items_MemberList_Build::
    ld a, [wLevelUpGains]
    or a
    call nz, RefreshRecordListAndNameTiles
    call SetupInventoryMenuPages_Bank03
    call BuildInventoryScreenBase
    call SetMenuRowsForPage_Bank03_2
    call ShowSelectedItemDescription
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Item page, step 1: the inventory cursor. Up/Down move and update the description; changing page
; redraws the item names; A takes the selected item (its name, the player's name and its item
; record) to the next step; B leaves the menu; Select sorts the inventory. (C1, E-0357)
PauseMenu_Items_MemberList_Cursor::
    ld a, [wInventory]
    or a
    jr nz, .call_update_menu_cursor
    ld a, [wJoypadPressed]
    jr .check_bit1

.call_update_menu_cursor:
    ld de, PauseMenu_Items_MemberList_Cursor_Data
    ld hl, wMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .skip
    ld a, [wMenuRowCount]
    cp $01
    ret z
    call ShowSelectedItemDescription
    ret

.skip:
    ld hl, wMenuCursor
    bit 7, [hl]
    jr z, .check_joypad_pressed
    res 7, [hl]
    call SetMenuRowsForPage_Bank03_2
    call ShowSelectedItemDescription
    call ShowInventoryPageItemNames_Bank03
    call DrawMenuPageNumber_Bank03
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuPage]
    add a
    add a
    ld c, a
    ld a, [wMenuCursor]
    add c
    ld [wInventorySlot], a
    ld hl, wInventory
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    ld l, a
    ld h, $05
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld de, wPlayerName
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    farcall LoadItemRecord
    ld hl, wTemp0
    inc [hl]
    xor a
    ld [wTemp1], a
    xor a
    ld [wSubMenuCursor], a
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    call ExitPauseMenuToField
    ret

.check_bit2:
    bit 2, a
    ret z
    farcall SortInventory
    call ShowSelectedItemDescription
    call ShowInventoryPageItemNames_Bank03
    ret

; by wTemp1: the item list (screen block $0E) with a cursor, before PauseMenu_Items_UseItem (E-0292)
PauseMenu_Items_ChooseItem::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_ChooseItem_BuildMenu
    dw PauseMenu_Items_ChooseItem_ActionCursor

; Item action menu (PauseMenu_Items_ChooseItem step 0): redraws the item list with its cursor
; (BuildScreenBlock0EWithCursor, then CopyTileBufferToBGMap), sets a two-choice cursor range
; (wMenuRowCount = 2, wMenuPageCount = 1) and moves on to the action cursor of step 1. (C1, E-0369)
PauseMenu_Items_ChooseItem_BuildMenu::
    call BuildScreenBlock0EWithCursor
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; Item action menu, step 1: A picks one of the two choices (wTemp0 = 2 or 3, sound $69), B goes
; back. (C1, E-0357)
PauseMenu_Items_ChooseItem_ActionCursor::
    ld de, PauseMenu_Items_ChooseItem_ActionCursor_Data
    ld hl, wSubMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and $01
    add $02
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    ret z
    ld hl, wTemp0
    dec [hl]
    xor a
    ld [wTemp1], a
    ret

; by wTemp1: picks an item and a member, CheckItemUsable, ApplyItemEffect ('But nothing happened',
; 'But it couldn't be used') and may leave for the field (E-0288)
PauseMenu_Items_UseItem::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_UseItem_ChoosePath
    dw PauseMenu_Items_UseItem_RedrawMenu
    dw PauseMenu_Items_UseItem_ShowTriedUsing
    dw PauseMenu_Items_UseItem_CloseTriedUsing
    dw PauseMenu_Items_UseItem_BuildTargetList
    dw PauseMenu_Items_UseItem_TargetCursor
    dw PauseMenu_Items_UseItem_RedrawTargetList
    dw PauseMenu_Items_UseItem_ShowMessage
    dw PauseMenu_Items_UseItem_CheckUsable
    dw PauseMenu_Items_UseItem_CannotUse
    dw PauseMenu_Items_UseItem_BackToFirstPage
    dw PauseMenu_Items_UseItem_Apply
    dw PauseMenu_Items_UseItem_BackToFirstPage
    dw PauseMenu_Items_UseItem_RedrawMenu
    dw PauseMenu_Items_UseItem_ShowMessage
    dw PauseMenu_Items_UseItem_CheckUsable
    dw PauseMenu_Items_UseItem_CannotUse
    dw PauseMenu_Items_UseItem_BackToFirstPage
    dw PauseMenu_Items_UseItem_Apply
    dw PauseMenu_Items_UseItem_BackToFirstPage
    dw PauseMenu_Items_UseItem_RedrawMenu
    dw PauseMenu_Items_UseItem_ShowMessage
    dw PauseMenu_Items_UseItem_RecheckUsable
    dw PauseMenu_Items_UseItem_ShowButNothingHappened
    dw PauseMenu_Items_UseItem_CloseNothingHappened
    dw PauseMenu_Items_UseItem_ApplyAgain
    dw PauseMenu_Items_UseItem_ExitToField
    dw PauseMenu_Items_UseItem_ShowButItCouldntBe
    dw PauseMenu_Items_UseItem_AskQuestion
    dw PauseMenu_Items_UseItem_ChoiceCursor
    dw PauseMenu_Items_UseItem_RunSaveScreens
    dw PauseMenu_Items_UseItem_CloseCouldntBeUsed
    dw PauseMenu_Items_UseItem_ShowYourProgressHasBeen
    dw PauseMenu_Items_UseItem_RestoreAndReturn

; Using an item, step 0: picks the path from the item record. When wItemRecord + 4 has bit 1 set it
; goes to step 1 (redraw, then message 6 of category 8, '... tried using' the item and 'But nothing
; happened.', then back to the item list); otherwise by the target kind in wItemRecord + 6: 0 and 4
; go to choosing a member (step 4), 7 to step $14, others to step $0D. (C1, E-0369)
PauseMenu_Items_UseItem_ChoosePath::
    ld a, [wItemRecord + $4]
    bit 1, a
    jr nz, .done
    ld a, [wItemRecord + $6]
    or a
    jr z, .set_temp1_to_04
    cp $04
    jr z, .set_temp1_to_04
    cp $07
    jr z, .set_temp1_to_14
    ld a, $0d
    ld [wTemp1], a
    ret

.set_temp1_to_04:
    ld a, $04
    ld [wTemp1], a
    ret

.set_temp1_to_14:
    ld a, $14
    ld [wTemp1], a
    ret

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, steps 1, 13 and 20: redraws the item list with block $10 and the action cursor at
; wSubMenuCursor (BuildScreenBlock0EWithSubMenuCursor, then CopyTileBufferToBGMap) and moves on to
; the message step after it. (C1, E-0369)
PauseMenu_Items_UseItem_RedrawMenu::
    call BuildScreenBlock0EWithSubMenuCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 2 (items with wItemRecord + 4 bit 1 set): shows message 6 of category 8
; (BeginStringDisplay_Bank08), the player '... tried using' the item named in wTextBuf2, then 'But
; nothing happened.', and moves on. (C1, E-0369)
PauseMenu_Items_UseItem_ShowTriedUsing::
    ld a, $08
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 3: after the message returns to the item list. (C1, E-0357)
PauseMenu_Items_UseItem_CloseTriedUsing::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

; Using an item, step 4: builds the member list for the item (BuildItemScreenForWItemId), the cursor
; over the party. (C1, E-0357)
PauseMenu_Items_UseItem_BuildTargetList::
    xor a
    ld [wMenuSelectedMember], a
    call BuildItemScreenForWItemId
    call CopyTileBufferToBGMap
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 5: the member cursor. Up/Down show what the item would change for that member
; (DrawItemTargetStatPreview); A picks the member as the target (wTargetRecord) and copies its name;
; B goes back. (C1, E-0357)
PauseMenu_Items_UseItem_TargetCursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    call DrawItemTargetStatPreview
    ld hl, vBGMap0 + $141
    lb bc, $09, $03
    ld de, wScreenTileBuffer + $141
    call CopyRectToBGMap
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and $03
    ld [wTargetRecord], a
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wTextBuf1
    call CopyFiveGlyphsPlusMarks
    xor a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, $01
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

; Using an item, step 6: redraws the item screen with the member cursor. (C1, E-0357)
PauseMenu_Items_UseItem_RedrawTargetList::
    call BuildItemScreenWithRecordCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 7: shows the item's message (wItemMessage, bank $37), or for message $25 jumps
; to step $1B. (C1, E-0357)
PauseMenu_Items_UseItem_ShowMessage::
    ld a, $00
    ld [wStringCategory], a
    ld a, [wItemMessage]
    ld [wStringIndex], a
    cp $25
    jr z, .set_temp1_to_1B
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

.set_temp1_to_1B:
    ld a, $1b
    ld [wTemp1], a
    ret

; Using an item, step 8: after the message checks whether the item can be used (CheckItemUsable);
; target kinds 0, 2 and 4 go on to apply it (step $0B), others to step $12. (C1, E-0357)
PauseMenu_Items_UseItem_CheckUsable::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall CheckItemUsable
    xor a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp $ff
    ret z
    ld a, [wItemRecord + $6]
    cp $00
    jr z, .set_temp1_to_0B
    cp $02
    jr z, .set_temp1_to_0B
    cp $04
    jr z, .set_temp1_to_0B
    ld a, $12
    ld [wTemp1], a
    ret

.set_temp1_to_0B:
    ld a, $0b
    ld [wTemp1], a
    ret

; Using an item, step 9: the 'cannot use' message: $32 for inventory items $40-$61, otherwise 2.
; (C1, E-0357)
PauseMenu_Items_UseItem_CannotUse::
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld a, [hl]
    cp $40
    jr c, .set_string_index_to_02
    cp $62
    jr nc, .set_string_index_to_02
    ld a, $32
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    jr .call_begin_string_display_bank37

.set_string_index_to_02:
    ld a, $02
    ld [wStringIndex], a ; 'But nothing happened!'
    ld a, $00
    ld [wStringCategory], a

.call_begin_string_display_bank37:
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 10: after the message returns to the first inventory page. (C1, E-0357)
PauseMenu_Items_UseItem_BackToFirstPage::
    ld a, [wTextFlags]
    or a
    ret nz
    call ResetInventoryMenuToFirstPage
    ret

; Using an item, step 11: applies the item (ApplyItemEffect) and shows its result message
; (wItemUseMessage; $27 becomes $31 when hTemp0 is set). (C1, E-0357)
PauseMenu_Items_UseItem_Apply::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a
    ld [rRAMG], a
    ld a, [wItemUseMessage]
    ld [wStringIndex], a
    cp $27
    jr z, .check_temp0

.loop:
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    xor a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    ret

.check_temp0:
    ldh a, [hTemp0]
    or a
    jr z, .loop
    ld a, $31
    ld [wStringIndex], a
    jr .loop

; Using an item, step 22: after the message checks the item again; $FF or $FE end here, otherwise
; the step skips one or two further steps by wItemUseMessage. (C1, E-0357)
PauseMenu_Items_UseItem_RecheckUsable::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall CheckItemUsable
    xor a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp $ff
    ret z
    cp $fe
    ret z
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemUseMessage]
    or a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 23: shows 'But nothing happened' (message 2, bank $37). (C1, E-0357)
PauseMenu_Items_UseItem_ShowButNothingHappened::
    ld a, $02
    ld [wStringIndex], a ; 'But nothing happened!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 24: after the message returns to the item list. (C1, E-0357)
PauseMenu_Items_UseItem_CloseNothingHappened::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; Using an item, step 25: applies the item (ApplyItemEffect) and shows its result message unless it
; is $FF. (C1, E-0357)
PauseMenu_Items_UseItem_ApplyAgain::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a
    ld [rRAMG], a
    ld a, [wItemUseMessage]
    ld [wStringIndex], a
    cp $ff
    jr z, .done
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 26: after the message leaves the pause menu for the field (an item that acts
; on the field). (C1, E-0357)
PauseMenu_Items_UseItem_ExitToField::
    ld a, [wTextFlags]
    or a
    ret nz
    call ExitPauseMenuToField
    ret

; Using an item, step 27: checks the item again; when it cannot be used ($FF) shows 'But it couldn't
; be used' (category 1, message $14) and skips three steps, otherwise shows its message. (C1,
; E-0357)
PauseMenu_Items_UseItem_ShowButItCouldntBe::
    farcall CheckItemUsable
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp $ff
    jr nz, .call_begin_string_display_bank37
    ld a, $01
    ld [wStringCategory], a
    ld a, $14
    ld [wStringIndex], a ; 'But it couldn't be used here.'
    ld hl, wTemp1
    inc [hl]
    inc [hl]
    inc [hl]

.call_begin_string_display_bank37:
    farcall BeginStringDisplay_Bank37
    ret

; Using an item, step 28: after the message plays sound $6C and builds a two-choice question (block
; $2B). (C1, E-0357)
PauseMenu_Items_UseItem_AskQuestion::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    call LoadScreenBlock2B
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wSubMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 29: the two-choice question. The first choice applies the item and starts the
; save screens (on a key-world map with a pending field event it first sets the sprites and
; saved-screen flag aside); the second (or B) returns to the item list. (C1, E-0357)
PauseMenu_Items_UseItem_ChoiceCursor::
    ld hl, wSubMenuCursor
    ld de, PauseMenu_Items_UseItem_ChoiceCursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and $01
    jr nz, PauseMenu_Items_UseItem_BackToList
    ld a, [wMapType]
    cp $80
    jr nz, .skip
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, .skip
    ld a, [wSpriteSlotCount]
    ld [wItemMenuSavedSpriteCount], a
    ld a, [wScreenSavedFlag]
    ld [wItemMenuSavedScreenFlag], a
    xor a
    ld [wSpriteSlotCount], a
    ld [wScreenSavedFlag], a

.skip:
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a
    ld [rRAMG], a
    xor a
    ld [wPauseMenuScreen], a
    ld hl, wTemp1
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z

; Returns to the item list (wTemp0 and wTemp1 = 0). (C1, E-0357)
PauseMenu_Items_UseItem_BackToList::
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; Using an item, step 30: runs the save screens (RunPauseMenuScreen) until all four are done, then
; skips a step. (C1, E-0357)
PauseMenu_Items_UseItem_RunSaveScreens::
    call RunPauseMenuScreen
    ld a, [wPauseMenuScreen]
    cp $04
    ret nz
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 31, reached from step 27 (PauseMenu_Items_UseItem_ShowButItCouldntBe skips
; three steps) when the item cannot be used: once 'But it couldn't be used here.' is done
; (wTextFlags = 0) returns to the item list (PauseMenu_Items_UseItem_BackToList). (C1, E-0369)
PauseMenu_Items_UseItem_CloseCouldntBeUsed::
    ld a, [wTextFlags]
    or a
    ret nz
    jr PauseMenu_Items_UseItem_BackToList

; Using an item, step 32: shows 'Your progress has been ...' (message $26, bank $37) after the save.
; (C1, E-0357)
PauseMenu_Items_UseItem_ShowYourProgressHasBeen::
    ld a, $26
    ld [wStringIndex], a ; 'Your progress has been recorded.'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Using an item, step 33: after the message restores the sprites and saved-screen flag set aside in
; step 29 and returns to the first inventory page. (C1, E-0357)
PauseMenu_Items_UseItem_RestoreAndReturn::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wMapType]
    cp $80
    jr nz, .call_reset_inventory_menu_to_first_page
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, .call_reset_inventory_menu_to_first_page
    ld a, [wItemMenuSavedSpriteCount]
    ld [wSpriteSlotCount], a
    ld a, [wItemMenuSavedScreenFlag]
    ld [wScreenSavedFlag], a

.call_reset_inventory_menu_to_first_page:
    call ResetInventoryMenuToFirstPage
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

; screen blocks $0E and $0F with the sub-menu cursor, strings, and the inventory reset to its first
; page (renamed from PauseMenu_Items_SubMenu from its E-0357 note, E-0367)
PauseMenu_Items_Discard::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_Discard_RedrawMenu
    dw PauseMenu_Items_Discard_AskToss
    dw PauseMenu_Items_Discard_DrawYesNo
    dw PauseMenu_Items_Discard_YesNoCursor
    dw PauseMenu_Items_Discard_ThrowAway
    dw PauseMenu_Items_Discard_BackToFirstPage
    dw PauseMenu_Items_Discard_Cancel

; Item action 'discard', step 0: redraws the item list with block $10 and the action cursor at
; wSubMenuCursor (BuildScreenBlock0EWithSubMenuCursor, then CopyTileBufferToBGMap) and moves on to
; the question. (C1, E-0369)
PauseMenu_Items_Discard_RedrawMenu::
    call BuildScreenBlock0EWithSubMenuCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Discard, step 1: asks 'Toss this away?' (message 1 of category 8, BeginStringDisplay_Bank08) and
; moves on. (C1, E-0369)
PauseMenu_Items_Discard_AskToss::
    ld a, $08
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Discard, step 2: after the message builds the yes/no choice (blocks $0E and $0F) and plays sound
; $6C. (C1, E-0357)
PauseMenu_Items_Discard_DrawYesNo::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wSubMenuCursor2], a
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    call BuildScreenBlocks0EAnd0FWithCursor
    call CopyTileBufferToBGMap
    ld a, $6c
    call QueueSoundEffect
    ld hl, wTemp1
    inc [hl]
    ret

; Discard, step 3: the yes/no cursor. A marks the choice and goes to step 4 (yes) or 6 (no); B
; returns to the item action menu. (C1, E-0357)
PauseMenu_Items_Discard_YesNoCursor::
    ld de, PauseMenu_Items_Discard_YesNoCursor_Data
    ld hl, wSubMenuCursor2
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor2]
    and $01
    ld hl, PauseMenu_Items_Discard_YesNoCursor_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ld a, [wSubMenuCursor2]
    and $01
    add a
    add $04
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, $01
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

; Discard, step 4: an item flagged in byte 8 bit 1 of its record cannot be thrown away (message 2 of
; category 8); otherwise the slot is emptied, message 4 is shown and the inventory is compacted.
; (C1, E-0357)
PauseMenu_Items_Discard_ThrowAway::
    ld a, [wItemRecord + $8]
    bit 1, a
    jr z, .read_inventory_slot
    ld a, $08
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

.read_inventory_slot:
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $00
    ld a, $08
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    farcall CompactInventory
    ld hl, wTemp1
    inc [hl]
    ret

; Discard, step 5: after the message returns to the first inventory page. (C1, E-0357)
PauseMenu_Items_Discard_BackToFirstPage::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    call ResetInventoryMenuToFirstPage
    ret

; Discard, step 6 (no): returns to the first inventory page. (C1, E-0357)
PauseMenu_Items_Discard_Cancel::
    call ResetInventoryMenuToFirstPage
    ret

; clears the screen buffer, copies blocks $0B and $0C and, with items, block $0D and the page
; indicator (page wMenuPage of wMenuItemCount) (E-0124)
BuildInventoryScreenBase::
    call ClearScreenTileBuffer_Bank03
    ld e, $0b
    farcall CopyBlockToTileBuffer
    ld e, $0c
    farcall CopyBlockToTileBuffer
    ld a, [wInventory]
    or a
    ret z
    ld e, $0d
    farcall CopyBlockToTileBuffer
    ld a, [wMenuItemCount]
    cp $02
    jr c, .return
    ld hl, wScreenTileBuffer + $10e
    ld a, $c5
    ld [hli], a
    ld a, [wMenuPage]
    add $e1
    ld [hli], a
    ld a, $be
    ld [hli], a
    ld a, [wMenuItemCount]
    add $e0
    ld [hli], a
    ld [hl], $c6

.return:
    ret

; runs BuildInventoryScreenBase, copies screen block $0E to the tile buffer and draws the cursor for
; wMenuCursor & 7 (E-0122)
BuildScreenBlock0EWithCursor::
    call BuildInventoryScreenBase
    ld e, $0e
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_Items_MemberList_Cursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; builds block $0E with the cursor, blocks $11 and $1B, and the rectangle chosen by wItemId
; (BuildItemScreenForWItemId_Data1 to BuildItemScreenForWItemId_Data2), then runs
; DrawItemTargetStatPreview (E-0122)
BuildItemScreenForWItemId::
    call BuildScreenBlock0EWithCursor
    ld e, $11
    farcall CopyBlockToTileBuffer
    ld e, $1b
    farcall CopyBlockToTileBuffer
    ld a, [wItemId]
    ld hl, BuildItemScreenForWItemId_Data1
    add_a_to_hl
    ld a, [hl]
    ld hl, BuildItemScreenForWItemId_Data2
    add a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    call DrawItemTargetStatPreview
    ret

; fills tiles, builds the item screen, copies block $10 and draws the cursor for wMenuSelectedMember
; & 3 (E-0122)
BuildItemScreenWithRecordCursor::
    call FillTilesFromRequest
    call BuildItemScreenForWItemId
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; builds block $0E with the cursor and copies block $0F (E-0122)
BuildScreenBlocks0EAnd0F::
    call BuildScreenBlock0EWithCursor
    ld e, $0f
    farcall CopyBlockToTileBuffer
    ret
    db $cd, $0e, $29

; builds blocks $0E and $0F, copies block $10 and draws the cursor for wSubMenuCursor & 3 (E-0122)
BuildScreenBlocks0EAnd0FWithCursor::
    call BuildScreenBlocks0EAnd0F
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $03
    ld hl, PauseMenu_Items_ChooseItem_ActionCursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; fills tiles, builds block $0E with the cursor, copies block $10 and draws the cursor for
; wSubMenuCursor & 3 (E-0122)
BuildScreenBlock0EWithSubMenuCursor::
    call FillTilesFromRequest
    call BuildScreenBlock0EWithCursor
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $03
    ld hl, PauseMenu_Items_ChooseItem_ActionCursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; inventory slot = (wMenuPage & $0F) * 4 + (wMenuCursor & $0F): shows that item's string of category
; 6 (the item descriptions of the bank-$08 database; item $1F uses string $6F) at vTiles2 + $230
; with size $1203 (ShowStringBank08AtTilesHL_Bank03) (E-0101)
ShowSelectedItemDescription::
    ld a, [wMenuPage]
    and $0f
    add a
    add a
    ld c, a
    ld a, [wMenuCursor]
    and $0f
    add c
    ld c, a
    ld b, $00
    ld hl, wInventory
    add hl, bc
    ld a, [hl]
    cp $1f
    jr nz, .set_string_index
    ld a, $6f

.set_string_index:
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call ShowStringBank08AtTilesHL_Bank03
    ret

; shows the four item names of inventory page wMenuPage (or the empty-inventory text and wInventory
; + $1 entries) at vTiles2 + $5C0 onward, preserving the window (E-0129)
ShowInventoryPageItemNames_Bank03::
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wInventory]
    or a
    jr nz, .check_menu_page
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $5c0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    ld de, wInventory + $1
    ld hl, vTiles2 + $650
    ld b, $03
    jr .set_string_category_to_05

.check_menu_page:
    ld a, [wMenuPage]
    and $0f
    add a
    add a
    ld de, wInventory
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $04
    ld hl, vTiles2 + $5c0

.set_string_category_to_05:
    ld a, $05
    ld [wStringCategory], a

.loop:
    ld a, [de]
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    inc de
    ld [wStringIndex], a
    push bc
    push de
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, .loop
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; when wMenuPageCount is non-zero, writes tile $E1 + (wMenuPage & $0F) at vBGMap0 + $10F (E-0067)
; (the same 20 bytes appear in 2 banks)
DrawMenuPageNumber_Bank03::
    ld a, [wMenuPageCount]
    or a
    jr z, .return
    ld a, [wMenuPage]
    and $0f
    add $e1
    ld hl, vBGMap0 + $10f
    call WriteVRAMByte

.return:
    ret

; A second copy in this bank of SetMenuRowsForPage_Bank03 (same 44 bytes), used by the item list
; (PauseMenu_Items_MemberList_Build and PauseMenu_Items_MemberList_Cursor): when wMenuPage & $0F is
; the last page (wMenuItemCount - 1), wMenuRowCount = wMenuLastPageRows and wMenuCursor is clamped
; to at most wMenuLastPageRows - 1; otherwise wMenuRowCount = 4; then clears bit 7 of wMenuPage.
; (C1, E-0369)
; when wMenuPage & $0F = wMenuItemCount - 1 (the last page): wMenuRowCount = wMenuLastPageRows and
; the cursor row wMenuCursor is clamped below it; otherwise wMenuRowCount = 4; then clears bit 7 of
; wMenuPage (E-0064) (the same 44 bytes appear in 3 banks)
SetMenuRowsForPage_Bank03_2::
    ld a, [wMenuItemCount]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and $0f
    cp c
    jr nz, .set_menu_row_count_to_04
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wMenuCursor]
    cp c
    jr c, .done
    dec c
    ld a, c
    ld [wMenuCursor], a
    jr .done

.set_menu_row_count_to_04:
    ld a, $04
    ld [wMenuRowCount], a

.done:
    ld hl, wMenuPage
    res 7, [hl]
    ret

; shows string 0 of category 0 (ShowString_Bank09) at vTiles1 + $6E0 with size $0127, preserving the
; window, then ShowSelectedItemDescription and ShowInventoryPageItemNames_Bank03 (E-0121)
ShowString0Bank09AtTiles16E0ThenItemDescription::
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles1 + $6e0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $2701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a ; 'WHATUsoePersoHPMPATKDEFAGLINTWLDnality'
    farcall ShowString_Bank09
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call ShowSelectedItemDescription
    call ShowInventoryPageItemNames_Bank03
    ret

; counts wInventory items until a $00 or $FF byte (24 slots); a $FF ends the list and that slot and
; the rest are rewritten as $00. Pages of 4: wMenuPageCount = wMenuItemCount = ceil(count / 4), at
; least 1; wMenuLastPageRows = count mod 4, or 4; wMenuRowCount = wMenuLastPageRows when wMenuPage
; equals the page count, else 4 (E-0067) (the same 79 bytes appear in 2 banks)
SetupInventoryMenuPages_Bank03::
    ld hl, wInventory
    ld bc, $1800

.loop:
    ld a, [hli]
    or a
    jr z, .call_divide_b_by_a
    cp $ff
    jr z, .next
    inc c
    dec b
    jr nz, .loop
    jr .call_divide_b_by_a

.next:
    dec hl
    xor a

.loop2:
    ld [hli], a
    dec b
    jr nz, .loop2

.call_divide_b_by_a:
    ld b, c
    ld a, $04
    call DivideBByA
    ld a, c
    and $03
    jr z, .skip
    inc b

.skip:
    ld a, b
    cp $00
    jr nz, .set_menu_page_count
    inc b
    ld a, b

.set_menu_page_count:
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    and $03
    or a
    jr nz, .set_menu_last_page_rows
    ld a, $04

.set_menu_last_page_rows:
    ld [wMenuLastPageRows], a
    ld a, [wMenuPage]
    cp b
    jr nz, .set_menu_row_count_to_04
    ld a, [wMenuLastPageRows]
    jr .set_menu_row_count

.set_menu_row_count_to_04:
    ld a, $04

.set_menu_row_count:
    ld [wMenuRowCount], a
    ret

; for item wItemId (kind BuildItemScreenForWItemId_Data1) writes the target record's affected value
; (HP, MP or a stat word) as digits in the item screen (E-0131)
DrawItemTargetStatPreview::
    ld a, [wMenuSelectedMember]
    ld c, a
    ld a, [wItemId]
    ld hl, BuildItemScreenForWItemId_Data1
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    pop af
    or a
    jr z, .skip
    cp $01
    jr z, .call_sram_record_address_mapped
    cp $02
    jr z, .call_map_index_via_party_list
    cp $03
    jr z, .skip2
    cp $04
    jr z, .skip3
    cp $05
    jr z, .skip4
    cp $06
    jr z, .skip5
    cp $07
    jr z, .call_sram_record_address_mapped3
    jp .call_sram_record_address_mapped5

.skip:
    ld a, c
    ld c, $5b
    jr .call_sram_record_address_mapped2

.call_sram_record_address_mapped:
    ld a, c
    ld c, $5f

.call_sram_record_address_mapped2:
    call SRAMRecordAddressMapped
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $19
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    jr .call_hl_to_decimal_digits

.skip2:
    ld a, c
    ld c, $6b
    jr .call_sram_record_address_mapped4

.skip3:
    ld a, c
    ld c, $63
    jr .call_sram_record_address_mapped4

.skip4:
    ld a, c
    ld c, $65
    jr .call_sram_record_address_mapped4

.skip5:
    ld a, c
    ld c, $67
    jr .call_sram_record_address_mapped4

.call_sram_record_address_mapped3:
    ld a, c
    ld c, $69

.call_sram_record_address_mapped4:
    call SRAMRecordAddressMapped

.call_hl_to_decimal_digits:
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $1d
    call WriteDecimalDigitTiles
    ld a, $c3
    ld [wScreenTileBuffer + $146], a
    ld [wScreenTileBuffer + $147], a
    jp .read_menu_selected_member

.call_map_index_via_party_list:
    ld a, c
    call MapIndexViaPartyList
    call PersonalityIndexOfRecord
    ld c, a
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, DrawItemTargetStatPreview_Data
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, vTiles2 + $1a0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop af
    ld hl, wWindowTileBuffer + $19
    ld c, a
    ld b, c
    ld a, $1a

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ld a, $09
    sub c
    ld b, a
    or a
    jr z, .set_text_window_tile_lo
    ld a, $c3

.loop2:
    ld [hli], a
    dec b
    jr nz, .loop2

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
    jr .read_menu_selected_member

.call_sram_record_address_mapped5:
    ld a, c
    ld c, MON_ITEM
    call SRAMRecordAddressMapped
    ld a, [hl]
    push af
    or a
    jr z, .set_string_index
    add $3f

.set_string_index:
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    ld hl, vTiles2 + $1a0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop af
    ld hl, RecordA4StringTileCounts_03
    add a
    add_a_to_hl
    ld b, [hl]
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld hl, wScreenTileBuffer + $141
    ld a, b
    ld c, a
    or a
    jr z, .skip6
    ld a, $1a

.loop3:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop3
    ld d, a

.skip6:
    ld a, $07
    sub c
    cp $00
    jr z, .skip7
    ld b, a
    ld a, $c3

.loop4:
    ld [hli], a
    dec b
    jr nz, .loop4

.skip7:
    ld hl, wWindowTileBuffer + $19
    ld b, $07
    ld a, c
    or a
    jr z, .skip9
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    ld b, [hl]
    pop hl

.loop5:
    ld a, b
    cp $00
    jr z, .skip8
    ld a, d
    ld [hli], a
    inc d
    dec b
    jr nz, .loop5

.skip8:
    ld b, $03

.skip9:
    ld a, $c3

.loop6:
    ld [hli], a
    dec b
    jr nz, .loop6
    jr .done

.read_menu_selected_member:
    ld a, [wMenuSelectedMember]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    call nz, SetScreenTileBufferRow16Col7TileC2_Bank03_2
    bit 2, [hl]
    call nz, SetScreenTileBufferRow16Col7TileC1_Bank03_2
    bit 0, [hl]
    call nz, SetScreenTileBufferRow16Col6TileC0_Bank03_2

.done:
    xor a
    ld [rRAMG], a
    ret

; wScreenTileBuffer + $147 = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC2_Bank03_2::
    ld a, $c2
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $147 = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC1_Bank03_2::
    ld a, $c1
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $146 = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col6TileC0_Bank03_2::
    ld a, $c0
    ld [wScreenTileBuffer + $146], a
    ret

; data read by DrawItemTargetStatPreview (27 bytes) (E-0347)
DrawItemTargetStatPreview_Data::
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

; after showing string category 5, index (record byte $A4) + $3F (when non-zero) into tiles from
; vTiles2 + $1A0, the code reads the pair at 2 * (record byte $A4): byte 0 tiles from $1A go into
; wScreenTileBuffer + $141 (the rest of 7 filled with $C3), byte 1 continues the tile numbers at
; wWindowTileBuffer + $19; 36 pairs; the bank $03 and $F1 copies are identical (E-0239, C1)
; record: tiles of the first row, tiles of the second row
RecordA4StringTileCounts_03::
    db $00, $00 ; id 0
    db $03, $04 ; id 1
    db $05, $04 ; id 2
    db $05, $04 ; id 3
    db $03, $04 ; id 4
    db $05, $04 ; id 5
    db $05, $04 ; id 6
    db $04, $05 ; id 7
    db $04, $05 ; id 8
    db $04, $00 ; id 9
    db $07, $00 ; id 10
    db $06, $00 ; id 11
    db $05, $00 ; id 12
    db $05, $04 ; id 13
    db $05, $04 ; id 14
    db $05, $04 ; id 15
    db $04, $04 ; id 16
    db $05, $04 ; id 17
    db $04, $04 ; id 18
    db $05, $04 ; id 19
    db $07, $00 ; id 20
    db $00, $00 ; id 21
    db $00, $00 ; id 22
    db $00, $00 ; id 23
    db $00, $00 ; id 24
    db $00, $00 ; id 25
    db $00, $00 ; id 26
    db $05, $00 ; id 27
    db $07, $00 ; id 28
    db $04, $00 ; id 29
    db $05, $00 ; id 30
    db $06, $00 ; id 31
    db $07, $00 ; id 32
    db $06, $00 ; id 33
    db $07, $00 ; id 34
    db $00, $00 ; id 35

BuildItemScreenForWItemId_Data1::
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

BuildItemScreenForWItemId_Data2::
    dw BuildItemScreenForWItemId_Data2_Entry00
    dw BuildItemScreenForWItemId_Data2_Entry01
    dw BuildItemScreenForWItemId_Data2_Entry02
    dw BuildItemScreenForWItemId_Data2_Entry03
    dw BuildItemScreenForWItemId_Data2_Entry04
    dw BuildItemScreenForWItemId_Data2_Entry05
    dw BuildItemScreenForWItemId_Data2_Entry06
    dw BuildItemScreenForWItemId_Data2_Entry07
    dw BuildItemScreenForWItemId_Data2_Entry08

; LZSS-compressed: 253 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry00::
    db $41, $01, $0c, $03, $fb, $fc, $ed
    ds $18, $c3
    db $be, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3

; LZSS-compressed: 258 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry01::
    db $41, $01, $0c, $03, $fd, $fe, $ed
    ds $18, $c3
    db $be, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3

; LZSS-compressed: 261 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry02::
    db $41, $01, $0c, $03, $f6, $f7, $f8, $f9, $fa, $0e, $0f, $10, $11, $12, $13, $c3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $1a, $1b, $1c, $1d
    db $1e, $1f, $20, $21, $22, $c3, $c3, $c3

; LZSS-compressed: 273 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry03::
    db $41, $01, $0c, $03, $0b, $0c, $0d, $ed
    ds $20, $c3

; LZSS-compressed: 302 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry04::
    db $41, $01, $0c, $03, $ff, $00, $01, $ed
    ds $20, $c3

; LZSS-compressed: 305 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry05::
    db $41, $01, $0c, $03, $02, $03, $04, $ed
    ds $20, $c3

; LZSS-compressed: 311 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry06::
    db $41, $01, $0c, $03, $05, $06, $07, $ed
    ds $20, $c3

; LZSS-compressed: 320 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry07::
    db $41, $01, $0c, $03, $08, $09, $0a, $ed
    ds $20, $c3

; LZSS-compressed: 324 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_Data2_Entry08::
    db $41, $01, $0c, $03
    ds $24, $c3

; wMenuPage = 0, wMenuCursor = 0, sets up the inventory pages, clamps the page, runs
; ShowInventoryPageItemNames_Bank03 and clears wTemp0/1 (E-0124)
ResetInventoryMenuToFirstPage::
    xor a
    ld [wMenuPage], a
    xor a
    ld [wMenuCursor], a
    call SetupInventoryMenuPages_Bank03
    ld hl, wMenuPage

.skip:
    ld a, [hli]
    cp [hl]
    jr c, .call_show_inventory_page_item_names_bank03
    dec hl
    dec [hl]
    jr .skip

.call_show_inventory_page_item_names_bank03:
    call ShowInventoryPageItemNames_Bank03
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; GameMode2_Update, wModeState 2: the SKILLS list ('No skills' at the start) (E-0046)
PauseMenu_Skills::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Skills_ChooseMember
    dw PauseMenu_Skills_ChooseSkill
    dw PauseMenu_Skills_ChooseTarget
    dw PauseMenu_Skills_UseFieldSkill

; by wTemp1: the record list and cursor; a dead member is refused ('A dead monster can't use a ...')
; (E-0292)
PauseMenu_Skills_ChooseMember::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_ChooseMember_Build
    dw PauseMenu_Skills_ChooseMember_Cursor
    dw PauseMenu_Skills_ChooseMember_Redraw
    dw PauseMenu_Skills_ChooseMember_ShowADeadMonsterCant
    dw PauseMenu_Skills_ChooseMember_CloseMessage

; Skills page, step 0: refreshes the party list after a level-up, redraws the skill list when a page
; is open, and sets the cursor over the party. (C1, E-0357)
PauseMenu_Skills_ChooseMember_Build::
    ld a, [wLevelUpGains]
    or a
    call nz, RefreshRecordListAndNameTiles
    ld a, [wMenuPageCount]
    or a
    jr z, .read_party_count
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call LoadScreenBlocks1CAnd0C
    call ShowRecordSkillPageNames_Bank03
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap

.read_party_count:
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_ChooseMember_CountSkills
    call PauseMenu_Skills_DrawPageIndicator
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ret

; Skills page, step 1: the party cursor. Up/Down show the next member's skills; A picks a member who
; has skills, or for a fallen member (status bit 7) shows 'A dead monster can't ...'; B leaves the
; menu. (C1, E-0357)
PauseMenu_Skills_ChooseMember_Cursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    xor a
    ld [wMenuPage], a
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_ChooseMember_CountSkills
    call PauseMenu_Skills_DrawPageIndicator
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_DrawPageNumber
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a
    jr z, .done
    cp $ff
    jr z, .done
    ld a, [wMenuSelectedMember]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, .set_temp1_to_02
    ld a, $01
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    xor a
    ld [wMenuPage], a
    xor a
    ld [wMenuCursor], a
    jr .done

.set_temp1_to_02:
    ld a, $02
    ld [wTemp1], a

.done:
    ld a, $00
    ld [rRAMG], a
    ret

.check_bit1:
    bit 1, a
    ret z
    call ExitPauseMenuToField
    ret

; Skills page, step 2: redraws the page with the cursor and the message window area. (C1, E-0357)
PauseMenu_Skills_ChooseMember_Redraw::
    call BuildScreenBlocks1CAnd0CWithCursor
    ld hl, vBGMap0 + $1a0
    lb bc, $14, $05
    ld de, wWindowTileBuffer + $38
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Skills page, step 3: shows 'A dead monster can't ...' (category 1, message $1A). (C1, E-0357)
PauseMenu_Skills_ChooseMember_ShowADeadMonsterCant::
    ld a, $01
    ld [wStringCategory], a
    ld a, $1a
    ld [wStringIndex], a ; 'A dead monster can't use a'
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Skills page, step 4: once 'A dead monster can't use a skill.' is done (wTextFlags = 0), returns to
; step 0 (wTemp1 = 0), which rebuilds the page and the party cursor. (C1, E-0369)
PauseMenu_Skills_ChooseMember_CloseMessage::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ret

; by wTemp1: the screen built from the member's record field $5F (MP) with a cursor, then the
; skill's string (E-0292)
PauseMenu_Skills_ChooseSkill::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_ChooseSkill_Build
    dw PauseMenu_Skills_ChooseSkill_Cursor
    dw PauseMenu_Skills_ChooseSkill_Redraw
    dw PauseMenu_Skills_ChooseSkill_ShowRefusal
    dw PauseMenu_Skills_ChooseSkill_CloseRefusal

; Choosing a skill, step 0: builds the skill screen with the member's MP and counts its skills (up
; to 8) to set up the skill pages (4 per page). (C1, E-0357)
PauseMenu_Skills_ChooseSkill_Build::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call BuildRecordField5FValueScreen
    call PauseMenu_Skills_ChooseSkill_ShowSelected
    ld a, $00
    ld [rRAMG], a
    call PauseMenu_Skills_DrawPageIndicator
    call PauseMenu_Skills_DrawPageNumber
    call CopyTileBufferToBGMap
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld bc, $0800

.loop:
    ld a, [hli]
    or a
    jr z, .next
    cp $ff
    jr z, .next
    inc c

.next:
    dec b
    jr nz, .loop
    call PauseMenu_Skills_SetSkillPages
    ld [wMenuRowCount], a
    call PauseMenu_Skills_DrawPageIndicator
    call SetMenuRowsForPage_Bank03
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_DrawPageNumber
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Choosing a skill, step 1: the skill cursor. Moving shows the selected skill's MP cost; changing
; page redraws the skill names; A on a skill that can be used in the field and is affordable goes to
; choosing a target, otherwise shows message $1B (not usable here) or $19 (not enough MP); B goes
; back to the party. (C1, E-0357)
PauseMenu_Skills_ChooseSkill_Cursor::
    ld de, PauseMenu_Items_MemberList_Cursor_Data
    ld hl, wMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .skip
    ld a, [wMenuRowCount]
    cp $01
    ret z
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_ChooseSkill_ShowSelected
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $206
    lb bc, $03, $01
    ld de, wWindowTileBuffer + $9e
    call CopyRectToBGMap
    ret

.skip:
    ld hl, wMenuCursor
    bit 7, [hl]
    jr z, .check_joypad_pressed
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    res 7, [hl]
    call SetMenuRowsForPage_Bank03
    call PauseMenu_Skills_ChooseSkill_ShowSelected
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_DrawPageNumber
    ld hl, vBGMap0 + $206
    lb bc, $03, $01
    ld de, wWindowTileBuffer + $9e
    call CopyRectToBGMap
    ld a, $00
    ld [rRAMG], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call LookupInventorySlotForRecordBuffer
    jr z, .set_string_index_to_1B
    call PauseMenu_Skills_ChooseSkill_Cursor_CheckMP
    jr nz, .set_string_index_to_19
    ld a, $02
    ld [wTemp0], a
    xor a
    ld [wSubMenuCursor], a
    xor a
    ld [wTemp1], a
    ret

.set_string_index_to_1B:
    ld a, $1b
    ld [wStringIndex], a
    jr .done

.set_string_index_to_19:
    ld a, $19
    ld [wStringIndex], a

.done:
    ld hl, wTemp1
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ld [wMenuPage], a
    ret

; Choosing a skill, step 2: redraws the skill screen with the cursor. (C1, E-0357)
PauseMenu_Skills_ChooseSkill_Redraw::
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_DrawPageIndicator
    call PauseMenu_Skills_DrawPageNumber
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Choosing a skill, step 3: shows the message picked in step 1 (wStringIndex) from category 1 of
; bank $37: $1B 'That can't be used in the field.' or $19 'Not enough MP!', and moves on. (C1,
; E-0369)
PauseMenu_Skills_ChooseSkill_ShowRefusal::
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Choosing a skill, step 4: once the message is done (wTextFlags = 0) returns to choosing a member
; (wTemp0, wTemp1 and wMenuPage = 0). (C1, E-0369)
PauseMenu_Skills_ChooseSkill_CloseRefusal::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    xor a
    ld [wMenuPage], a
    ret

; by wTemp1: the record field $5F screen with a cursor, before PauseMenu_Skills_UseFieldSkill
; (E-0292)
PauseMenu_Skills_ChooseTarget::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_ChooseTarget_Build
    dw PauseMenu_Skills_ChooseTarget_Draw
    dw PauseMenu_Skills_ChooseTarget_Cursor

; Choosing a target, step 0: a skill whose record byte 4 is $21 needs no target and goes straight
; on; otherwise redraws the skill screen with the cursor and moves to target selection. (C1, E-0357)
PauseMenu_Skills_ChooseTarget_Build::
    ld a, [wRecordBufferData + $4]
    cp $21
    jr z, .done
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_DrawPageIndicator
    call PauseMenu_Skills_DrawPageNumber
    call CopyTileBufferToBGMap
    ld hl, wTemp0
    inc [hl]
    ret

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Choosing a target, step 1: draws the target screen (block $20 with MP and cost) and puts the
; cursor over the party. (C1, E-0357)
PauseMenu_Skills_ChooseTarget_Draw::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_ChooseTarget_Draw_BuildScreen
    call PauseMenu_Skills_ChooseTarget_ShowHPOrMP
    ld a, $00
    ld [rRAMG], a
    call PauseMenu_Skills_DrawPageIndicator
    call PauseMenu_Skills_DrawPageNumber
    call CopyTileBufferToBGMap
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; Choosing a target, step 2: the target cursor shows each member's HP or MP; A picks the target
; (wTargetRecord) and copies its name; B returns to choosing a skill. (C1, E-0357)
PauseMenu_Skills_ChooseTarget_Cursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wSubMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_ChooseTarget_ShowHPOrMP
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $141
    lb bc, $07, $03
    ld de, wScreenTileBuffer + $141
    call CopyRectToBGMap
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wSubMenuCursor]
    and $03
    ld [wTargetRecord], a
    call BuildSkillScreenTileBuffer
    call PauseMenu_Skills_ChooseTarget_ShowHPOrMP
    call CopyTileBufferToBGMap
    ld a, [wTargetRecord]
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wTextBuf1
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp0
    inc [hl]
    xor a
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, $01
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    xor a
    ld [wMenuPage], a
    ret

; by wTemp1: shows the skill's strings, applies it to the SRAM record and leaves the pause menu for
; the field ('Hero returned with ...', ExitPauseMenuToField) (E-0288)
PauseMenu_Skills_UseFieldSkill::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_UseFieldSkill_Prepare
    dw PauseMenu_Skills_UseFieldSkill_ShowMessage
    dw PauseMenu_Skills_UseFieldSkill_CheckUsable
    dw PauseMenu_Skills_UseFieldSkill_ShowFailure
    dw PauseMenu_Skills_UseFieldSkill_CloseFailure
    dw PauseMenu_Skills_UseFieldSkill_PayMP
    dw PauseMenu_Skills_UseFieldSkill_PlaySound
    dw PauseMenu_Skills_UseFieldSkill_RunEffect
    dw PauseMenu_Skills_UseFieldSkill_PickResultStep
    dw PauseMenu_Skills_UseFieldSkill_ShowResultLines
    dw PauseMenu_Skills_UseFieldSkill_ShowHeroReturnedWithAn
    dw PauseMenu_Skills_UseFieldSkill_Finish

; Using a field skill, step 0: redraws the screen and copies the user's name and the skill's name
; for the messages. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_Prepare::
    call PauseMenu_Skills_DrawPageIndicator
    call PauseMenu_Skills_DrawPageNumber
    call CopyTileBufferToBGMap
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, [wRecordBuffer]
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 1: plays the skill's sound and shows its first message (both from tables
; indexed by the skill's field-skill number in wInventorySlot). (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_ShowMessage::
    ld a, [wInventorySlot]
    ld hl, PauseMenu_Skills_UseFieldSkill_ShowMessage_Data1
    add_a_to_hl
    ld a, [hl]
    cp $ff
    call nz, QueueSoundEffect
    ld a, [wInventorySlot]
    ld hl, PauseMenu_Skills_UseFieldSkill_ShowMessage_Data2
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 2: after the message applies the skill to the target (FieldSkillUsable);
; when it had no effect ($FF) the next step shows why, otherwise two steps are skipped. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_CheckUsable::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wSubMenuCursor]
    ld [wTargetRecord], a
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall FieldSkillUsable
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp $ff
    ret z
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 3: shows the failure message (wItemMessage, category 1). (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_ShowFailure::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wItemMessage]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 4: once the failure message of step 3 is done (wTextFlags = 0) returns
; to choosing a member (wTemp0, wTemp1 and wMenuPage = 0). (C1, E-0369)
PauseMenu_Skills_UseFieldSkill_CloseFailure::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a
    ld [wMenuPage], a
    ret

; Using a field skill, step 5: subtracts the MP cost from the user's MP (a cost of $FF uses all of
; it); for ITEM_METEORB a random bit decides whether it fails instead (message $13). (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_PayMP::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wRecordBufferData]
    cp $ff
    jr nz, .skip
    ld a, [wMenuSelectedMember]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    ld a, l
    ld [wItemEffectAmount], a
    ld a, h
    ld [wItemEffectRange], a
    jr .read_menu_selected_member

.skip:
    ld l, a
    ld h, $00

.read_menu_selected_member:
    push hl
    ld a, [wMenuSelectedMember]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    pop bc
    ld a, [hl]
    sub c
    ld [hli], a
    ld a, [hl]
    sbc b
    ld [hl], a
    ld hl, wTemp1
    inc [hl]
    ld a, $00
    ld [rRAMG], a
    ld a, [wItemId]
    cp ITEM_METEORB
    ret nz
    call NextTableByte
    ld a, [wRandomLo]
    bit 7, a
    ret z
    ld a, $13
    ld [wItemMessage], a
    ld a, $03
    ld [wTemp1], a
    ret

; Using a field skill, step 6: plays the skill's effect sound from
; PauseMenu_Skills_UseFieldSkill_QueueSoundEffect_Data. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_PlaySound::
    ld a, [wInventorySlot]
    ld hl, PauseMenu_Skills_UseFieldSkill_PlaySound_Data
    add_a_to_hl
    ld a, [hl]
    cp $ff
    call nz, QueueSoundEffect
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 7: runs the skill's effect (FieldSkillEffect) and shows its message
; (category 0 for ITEM_BEEFJERKY, ITEM_PORKCHOP and ITEM_WIND, otherwise 1). (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_RunEffect::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall FieldSkillEffect
    ld a, $00
    ld [rRAMG], a
    ld a, [wItemId]
    cp ITEM_BEEFJERKY
    jr z, .set_string_category_to_00
    cp ITEM_PORKCHOP
    jr z, .set_string_category_to_00
    cp ITEM_WIND
    jr z, .set_string_category_to_00
    ld a, $01
    ld [wStringCategory], a
    jr .read_item_message

.set_string_category_to_00:
    ld a, $00
    ld [wStringCategory], a

.read_item_message:
    ld a, [wItemMessage]
    ld [wStringIndex], a
    cp $ff
    jr z, .done
    farcall BeginStringDisplay_Bank37

.done:
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 8: after the message picks the next step by skill: field skill $10 goes
; to step 9, $11 to step 10, others to step 11. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_PickResultStep::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ld a, [wInventorySlot]
    cp $10
    ret z
    ld hl, wTemp1
    inc [hl]
    ld a, [wInventorySlot]
    cp $11
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

; Using a field skill, step 9: shows the next result line (message $0C with a name from the list at
; wWorkBuf + 2) until the list is done. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_ShowResultLines::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wItemId]
    cp $ff
    jr z, .set_temp1_to_0B
    ld a, [wWorkBuf + $1]
    ld hl, wWorkBuf + $2
    add a
    add_a_to_hl
    deref_hl
    ld a, h
    add $02
    ld h, a
    ld de, wTextBuf3
    call CopyStringHLToDE
    ld a, $01
    ld [wStringCategory], a
    ld a, $0c
    ld [wStringIndex], a ; '0: There are m around.'
    farcall BeginStringDisplay_Bank37
    ld hl, wWorkBuf + $1
    ld a, [hl]
    inc a
    ld [hld], a
    cp [hl]
    ret c
    ld a, $ff
    ld [wItemId], a
    ret

.set_temp1_to_0B:
    ld a, $0b
    ld [wTemp1], a
    ret

; Using a field skill, step 10: shows 'Hero returned with ...' (message $0F) or, when nothing was
; found, message $10. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_ShowHeroReturnedWithAn::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wItemId]
    cp $ff
    jr z, .set_string_index_to_10
    ld a, $0f
    ld [wStringIndex], a ; '0 returned with an item. obtained'
    jr .set_string_category_to_01

.set_string_index_to_10:
    ld a, $10
    ld [wStringIndex], a ; '0 came back with nothing…'

.set_string_category_to_01:
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld a, $0b
    ld [wTemp1], a
    ret

; Using a field skill, step 11: after the message leaves for the field when the skill asked for it
; (wDataBankSave), otherwise returns to the skill list. (C1, E-0357)
PauseMenu_Skills_UseFieldSkill_Finish::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ld a, [wDataBankSave]
    or a
    jr z, .check_item_id
    call ExitPauseMenuToField
    ret

.check_item_id:
    ld a, [wItemId]
    cp $ff
    ret z
    xor a
    ld [wMenuPage], a
    xor a
    ld [wMenuCursor], a
    ret

; clears the screen tile buffer and copies blocks $1C and $0C into it (CopyBlockToTileBuffer)
; (E-0101)
LoadScreenBlocks1CAnd0C::
    call ClearScreenTileBuffer_Bank03
    ld e, $1c
    farcall CopyBlockToTileBuffer
    ld e, $0c
    farcall CopyBlockToTileBuffer
    ret

; Draws the skill list's page indicator into wScreenTileBuffer + $10E for the selected member
; (wMenuSelectedMember & 3; SRAM enabled by the caller): '(page/count)' as tiles $C5, $E1 +
; wMenuPage, $BE, $E0 + wMenuItemCount, $C6; when the member's first MON_SKILLS slot is $FF or there
; is only one page (wMenuItemCount = 1) it writes five $B4 tiles there instead (CopyRectToBGMap from
; a 5 x 1 tile rectangle). (C1, E-0369)
PauseMenu_Skills_DrawPageIndicator::
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp $ff
    jr nz, .check_menu_item_count

.loop:
    ld de, PauseMenu_Skills_DrawPageIndicator_TileRect
    lb bc, $05, $01
    ld hl, wScreenTileBuffer + $10e
    call CopyRectToBGMap
    ret

.check_menu_item_count:
    ld a, [wMenuItemCount]
    cp $01
    jr z, .loop
    ld hl, wScreenTileBuffer + $10e
    ld a, $c5
    ld [hli], a
    ld a, [wMenuPage]
    add $e1
    ld [hli], a
    ld a, $be
    ld [hli], a
    ld a, [wMenuItemCount]
    add $e0
    ld [hli], a
    ld [hl], $c6
    ret

; loads blocks $1C, $0C and $1D, writes field $5F of record wMenuSelectedMember & 3 as decimal
; digits at wWindowTileBuffer + $A2 and draws the cursor for wMenuSelectedMember & 3 (E-0122)
BuildRecordField5FValueScreen::
    call LoadScreenBlocks1CAnd0C
    ld e, $1d
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a2
    call WriteDecimalDigitTiles
    ld a, [wMenuSelectedMember]
    and $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; Builds the target screen: blocks $20, $0C and $1D, the user's MP and the skill's cost (all of it
; when the cost is $FF), the skill cursor mark and the rectangle for the skill's kind. (C1, E-0357)
PauseMenu_Skills_ChooseTarget_Draw_BuildScreen::
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0c
    farcall CopyBlockToTileBuffer
    ld e, $1d
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a2
    call WriteDecimalDigitTiles
    ld a, [wRecordBufferData]
    cp $ff
    jr z, .call_write_decimal_digit_tiles
    ld l, a
    ld h, $00
    call HLToDecimalDigits

.call_write_decimal_digit_tiles:
    ld de, wWindowTileBuffer + $9e
    call WriteDecimalDigitTiles
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_Items_MemberList_Cursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    add $51
    ld l, a
    ld a, h
    adc $68
    ld h, a
    ld a, [hl]
    ld hl, PauseMenu_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable
    add a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    ret

; fills tiles, builds the field-$5F screen, draws the cursor for wMenuCursor & 7 and copies block
; $10 (E-0122)
BuildRecordField5FValueScreenWithCursor::
    call FillTilesFromRequest
    call BuildRecordField5FValueScreen
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_Items_MemberList_Cursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills the screen tile buffer: blocks $20 and $0C, cursor marks for wMenuCursor and wSubMenuCursor,
; the rectangle chosen by the skill wRecordBuffer (table $6851 to
; PauseMenu_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable), then block $10 (E-0121)
BuildSkillScreenTileBuffer::
    call FillTilesFromRequest
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0c
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_Items_MemberList_Cursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wSubMenuCursor]
    and $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    add $51
    ld l, a
    ld a, h
    adc $68
    ld h, a
    ld a, [hl]
    ld hl, PauseMenu_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable
    add a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills tiles, loads blocks $1C and $0C, draws the cursor for wMenuSelectedMember & 3 and copies
; block $10 (E-0122)
BuildScreenBlocks1CAnd0CWithCursor::
    call FillTilesFromRequest
    call LoadScreenBlocks1CAnd0C
    ld a, [wMenuSelectedMember]
    and $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; shows string 1 of category 0 (ShowString_Bank09) at vTiles1 + $6E0 with size $0107, preserving the
; window, then ShowRecordSkillPageNames_Bank03 (E-0121)
ShowString1Bank09AtTiles16E0ThenDetails::
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles1 + $6e0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a ; 'TOWHOHPMP'
    farcall ShowString_Bank09
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call ShowRecordSkillPageNames_Bank03
    ret

; Loads the skill under the cursor (MON_SKILLS slot wMenuPage * 4 + wMenuCursor of member
; wMenuSelectedMember & 3; an empty $FF slot reads as skill 0) into wStringIndex, wRecordBuffer
; (word) and wItemId and loads its record (LoadSkillRecord); writes its MP cost (wRecordBufferData;
; all of the member's MON_MP when the cost is $FF) at wWindowTileBuffer + $9E, and shows the skill's
; string of category 9 in an 18 x 3 window at vTiles2 + $230 (ShowStringBank08AtTilesHL_Bank03).
; SRAM must be enabled by the caller. (C1, E-0369)
PauseMenu_Skills_ChooseSkill_ShowSelected::
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld a, [wMenuCursor]
    and $07
    ld c, a
    ld a, [wMenuPage]
    and $0f
    add a
    add a
    add c
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    ld [wStringIndex], a
    ld [wRecordBuffer], a
    ld [wItemId], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp $ff
    jr z, .check_menu_selected_member
    ld l, a
    ld h, $00
    jr .call_hl_to_decimal_digits

.check_menu_selected_member:
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $9e
    call WriteDecimalDigitTiles
    ld a, $09
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call ShowStringBank08AtTilesHL_Bank03
    ret

; Shows the target's HP or MP (by the skill's kind from its table byte) as current and maximum, and
; its status mark. (C1, E-0357)
PauseMenu_Skills_ChooseTarget_ShowHPOrMP::
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    add $51
    ld l, a
    ld a, h
    adc $68
    ld h, a
    ld a, [hl]
    or a
    jr nz, .check_sub_menu_cursor
    ld c, $5b
    jr .check_sub_menu_cursor2

.check_sub_menu_cursor:
    ld c, $5f

.check_sub_menu_cursor2:
    ld a, [wSubMenuCursor]
    and $03
    call SRAMRecordAddressMapped
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $19
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $1d
    call WriteDecimalDigitTiles
    ld a, [wSubMenuCursor]
    and $03
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    ld a, $c3
    ld [wScreenTileBuffer + $146], a
    ld [wScreenTileBuffer + $147], a
    bit 7, [hl]
    call nz, SetScreenTileBufferRow16Col7TileC2_Bank03
    bit 2, [hl]
    call nz, SetScreenTileBufferRow16Col7TileC1_Bank03
    bit 0, [hl]
    call nz, SetScreenTileBufferRow16Col6TileC0_Bank03
    ret

; wScreenTileBuffer + $147 = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC2_Bank03::
    ld a, $c2
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $147 = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC1_Bank03::
    ld a, $c1
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $146 = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col6TileC0_Bank03::
    ld a, $c0
    ld [wScreenTileBuffer + $146], a
    ret

; Returns the user's MP minus the skill's cost in DE (the whole MP when the cost is $FF), with Z
; clear when that is negative (bit 7 of D). (C1, E-0357)
PauseMenu_Skills_ChooseSkill_Cursor_CheckMP::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_MP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, $00
    ld [rRAMG], a
    ld a, [wRecordBufferData]
    cp $ff
    jr nz, .skip
    ld h, d
    ld l, e
    jr .skip2

.skip:
    ld l, a
    ld h, $00

.skip2:
    ld a, e
    sub l
    ld e, a
    ld a, d
    sbc h
    ld d, a
    bit 7, d
    ret

; wInventorySlot = LookupInventorySlotForRecordBuffer_Data[wRecordBuffer]; Z set when it is $FF
; (E-0119)
LookupInventorySlotForRecordBuffer::
    ld a, [wRecordBuffer]
    ld hl, LookupInventorySlotForRecordBuffer_Data
    add_a_to_hl
    ld a, [hl]
    ld [wInventorySlot], a
    cp $ff
    ret

; data read by LookupInventorySlotForRecordBuffer (29 bytes) (E-0347)
LookupInventorySlotForRecordBuffer_Data::
    ds $16, $ff
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $ff, $0a, $ff, $ff, $0b
    ds $7d, $ff
    db $0c, $0d, $0e, $0f, $10, $11, $12, $13, $ff, $ff, $ff, $ff, $ff, $ff

; shows four skill names of record wMenuSelectedMember & 3 for page wMenuPage (or string $0E when it
; has none) at vTiles2 + $5C0 onward, preserving the window (E-0129)
ShowRecordSkillPageNames_Bank03::
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp $ff
    jr nz, .check_menu_page
    ld a, $08
    ld [wStringCategory], a
    ld a, $0e
    ld [wStringIndex], a
    ld hl, vTiles2 + $5c0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    push de
    farcall ShowString_Bank08
    pop de
    inc de
    ld hl, vTiles2 + $650
    ld b, $03
    jr .set_string_category_to_04

.check_menu_page:
    ld a, [wMenuPage]
    and $0f
    add a
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $04
    ld hl, vTiles2 + $5c0

.set_string_category_to_04:
    ld a, $04
    ld [wStringCategory], a

.loop:
    ld a, [de]
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    inc de
    ld [wStringIndex], a
    push bc
    push de
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, .loop
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret
    ds $1b, $00
    db $01, $01, $01
    ds $b2, $00

; a word table of tile-rectangle records; the code derefs one entry into HL for a record copier
; (E-0221)
; record: rectangle record
PauseMenu_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable::
    dw TileRect_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable_0 ; id 0
    dw TileRect_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable_1 ; id 1

; a tile-rectangle record for CopyRecordRectToScreenBuffer_Bank03 (E-0161)
; record: offset $0120 (row 9, column 0); 9 x 5 tiles
TileRect_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable_0::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $09, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f3, $f4, $ed, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

TileRect_Skills_ChooseTarget_Draw_BuildScreen_TileRectTable_1::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $09, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f5, $f6, $ed, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

PauseMenu_Skills_UseFieldSkill_ShowMessage_Data1::
    db $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff

PauseMenu_Skills_UseFieldSkill_PlaySound_Data::
    db $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff

PauseMenu_Skills_UseFieldSkill_ShowMessage_Data2::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $00
    db $03, $04, $05, $00

; Counts the selected member's skills (MON_SKILLS bytes up to the first $FF; the count is not capped
; at 8) and sets the skill pages: wMenuPageCount = wMenuItemCount = 0 for none, 1 for 1-4 skills, 2
; for more; wMenuLastPageRows = the count mod 4, or 4 when that is 0 or the count is 9 or more. SRAM
; must be enabled by the caller. (C1, E-0369)
PauseMenu_Skills_ChooseMember_CountSkills::
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld c, $00

.skip:
    ld a, [hli]
    cp $ff
    jr z, .skip2
    inc c
    jr .skip

.skip2:
    ld a, c
    cp $00
    jr z, .set_menu_page_count2
    cp $05
    jr c, .set_menu_page_count
    ld a, $02
    jr .set_menu_page_count2

.set_menu_page_count:
    ld a, $01

.set_menu_page_count2:
    ld b, a
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    cp $09
    jr c, .skip3
    ld a, $04

.skip3:
    and $03
    or a
    jr nz, .set_menu_last_page_rows
    ld a, $04

.set_menu_last_page_rows:
    ld [wMenuLastPageRows], a
    ret

; Sets the skill pages from the count in C (as PauseMenu_Skills_ChooseMember_CountSkills) and
; returns the rows of the current page: the last page's rows on the last page, otherwise 4. (C1,
; E-0357)
PauseMenu_Skills_SetSkillPages::
    ld a, c
    cp $00
    jr z, .set_menu_page_count2
    cp $05
    jr c, .set_menu_page_count
    ld a, $02
    jr .set_menu_page_count2

.set_menu_page_count:
    ld a, $01

.set_menu_page_count2:
    ld b, a
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    cp $09
    jr c, .skip
    ld a, $04

.skip:
    and $03
    or a
    jr nz, .set_menu_last_page_rows
    ld a, $04

.set_menu_last_page_rows:
    ld [wMenuLastPageRows], a
    ld a, [wMenuPage]
    cp b
    jr nz, .return_04
    ld a, [wMenuLastPageRows]
    jr .return

.return_04:
    ld a, $04

.return:
    ret

; when wMenuPage & $0F = wMenuItemCount - 1 (the last page): wMenuRowCount = wMenuLastPageRows and
; the cursor row wMenuCursor is clamped below it; otherwise wMenuRowCount = 4; then clears bit 7 of
; wMenuPage (E-0064) (the same 44 bytes appear in 3 banks)
SetMenuRowsForPage_Bank03::
    ld a, [wMenuItemCount]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and $0f
    cp c
    jr nz, .set_menu_row_count_to_04
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wMenuCursor]
    cp c
    jr c, .done
    dec c
    ld a, c
    ld [wMenuCursor], a
    jr .done

.set_menu_row_count_to_04:
    ld a, $04
    ld [wMenuRowCount], a

.done:
    ld hl, wMenuPage
    res 7, [hl]
    ret

; Draws the skill list's page number for the selected member (SRAM enabled by the caller): when its
; first MON_SKILLS slot is $FF or wMenuItemCount is 1, writes five $B4 tiles into wScreenTileBuffer
; + $10E (as PauseMenu_Skills_DrawPageIndicator); otherwise, when wMenuPageCount is not 0, writes
; tile $E1 + wMenuPage straight to vBGMap0 + $10F (WriteVRAMByte). (C1, E-0369)
PauseMenu_Skills_DrawPageNumber::
    ld a, [wMenuSelectedMember]
    and $03
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp $ff
    jr nz, .check_menu_item_count

.loop:
    ld de, PauseMenu_Skills_DrawPageIndicator_TileRect
    lb bc, $05, $01
    ld hl, wScreenTileBuffer + $10e
    call CopyRectToBGMap
    ret

.check_menu_item_count:
    ld a, [wMenuItemCount]
    cp $01
    jr z, .loop
    ld a, [wMenuPageCount]
    or a
    ret z
    ld a, [wMenuPage]
    and $0f
    add $e1
    ld hl, vBGMap0 + $10f
    call WriteVRAMByte
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 5 x 1 tiles, one row per line
PauseMenu_Skills_DrawPageIndicator_TileRect::
    db $b4, $b4, $b4, $b4, $b4 ; id 0

; GameMode2_Update, wModeState 3: PLAN, chosen from the field menu: Keys, Plan, Text Speed,
; Re-Order, Info, Journal (C2 from E-0322; E-0046 read it as an item list screen) (was
; PauseMenu_Plan)
PauseMenu_Plan::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Plan_Block21Menu
    dw PauseMenu_Plan_Keys
    dw PauseMenu_Plan_Tactics
    dw PauseMenu_Plan_MessageSpeed
    dw PauseMenu_Plan_PartyOrder
    dw PauseMenu_Plan_PlayerRecord
    dw PauseMenu_Plan_Record

; screen block $21, the menu cursor, a rectangle and a text wait (E-0303)
PauseMenu_Plan_Block21Menu::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Build
    dw PauseMenu_Plan_Cursor
    dw PauseMenu_Plan_CannotSave
    dw PauseMenu_Plan_Block21Menu_CloseRefusal

; Plan page, step 0: builds block $21 with the record name and party tiles; the cursor ranges over
; its six entries. (C1, E-0357)
PauseMenu_Plan_Build::
    call LoadScreenBlock21
    call CopyTileBufferToBGMap
    call LoadRecordListNameTiles
    farcall LoadTilesForPartyRecords
    ld a, $06
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    call FillTiles21E0PreservingWindow
    ret

; Plan page, step 1: the six-entry cursor. A marks the entry and opens it (wTemp0 = entry + 1);
; entry 6, the Journal, shows a refusal where saving is forbidden (TestSaveForbiddenHere); B leaves
; the menu. (C1, E-0357)
PauseMenu_Plan_Cursor::
    ld hl, wMenuSelectedMember
    ld de, MenuCursorPositions_Bank03
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wMenuSelectedMember]
    and $07
    inc a
    ld [wTemp0], a
    cp $06
    jr nz, .clear_temp1
    call TestSaveForbiddenHere
    jr z, .clear_temp1
    ld e, $10
    farcall CopyBlockToTileBuffer
    xor a
    ld [wTemp0], a
    ld hl, wTemp1
    inc [hl]
    ret

.clear_temp1:
    xor a
    ld [wTemp1], a
    xor a
    ld [wMenuPage], a
    xor a
    ld [wMenuCursor], a
    ret

.check_bit1:
    bit 1, a
    ret z
    call ExitPauseMenuToField
    ret

; Plan page, step 2: shows message $0D of category 8 (saving is not possible here) in the window.
; (C1, E-0357)
PauseMenu_Plan_CannotSave::
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRectToBGMap
    ld a, $08
    ld [wStringCategory], a
    ld a, $0d
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Plan page, step 3: once the refusal message of step 2 is done (wTextFlags = 0), returns to step 0
; (wTemp1 = 0), which rebuilds the plan page and its six-entry cursor. (C1, E-0369)
PauseMenu_Plan_Block21Menu_CloseRefusal::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ret

; far-calls SaveForbiddenHere and sets Z from its result C: Z when saving is allowed; PLAN's Journal
; (the save) shows 'You can't save here.' otherwise (C2 from E-0322) (was TestSaveForbiddenHere)
TestSaveForbiddenHere::
    farcall SaveForbiddenHere
    ld a, c
    or a
    ret

; by wTemp1: menu rows and pages, a list-entry bit-7 test, strings, and an exit to the field
; (renamed from PauseMenu_Plan_ChooseListEntry from its E-0357 note, E-0367)
PauseMenu_Plan_Keys::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Keys_Build
    dw PauseMenu_Plan_Keys_Cursor
    dw PauseMenu_Plan_Keys_DrawUseDiscard
    dw PauseMenu_Plan_Keys_UseOrDiscard
    dw PauseMenu_Plan_Keys_RedrawForUse
    dw PauseMenu_Plan_Keys_UseKey
    dw PauseMenu_Plan_Keys_AfterMessage
    dw PauseMenu_Plan_Keys_RedrawForRefusal
    dw PauseMenu_Plan_Keys_ShowCantToss
    dw PauseMenu_Plan_Keys_CloseCantToss
    dw PauseMenu_Plan_Keys_RedrawForDiscard
    dw PauseMenu_Plan_Keys_AskToss
    dw PauseMenu_Plan_Keys_AfterTossQuestion
    dw PauseMenu_Plan_Keys_DrawYesNo
    dw PauseMenu_Plan_Keys_YesNoCursor
    dw PauseMenu_Plan_Keys_ShowThrewAway
    dw PauseMenu_Plan_Keys_DeleteKey

; Plan, key list, step 0: loads three cursor tiles, builds the key list screen (blocks $21-$23),
; clears the name area, and draws the keys of the current page and the selected key's details. (C1,
; E-0357)
PauseMenu_Plan_Keys_Build::
    ld hl, vTiles2 + $710
    ld de, Tiles2Plus710Tiles_3
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $720
    ld de, Tiles2Plus710Tiles_3
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $730
    ld de, Tiles2Plus710Tiles_3
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    call BuildScreenBlocks21To23
    ld hl, wTextWindowTileLo
    ld a, $50
    ld [hli], a
    ld a, $93
    ld [hli], a
    ld a, $05
    ld [hli], a
    ld a, $0c
    ld [hli], a
    call FillTilesFromRequest
    call CopyTileBufferToBGMap
    call PauseMenu_Plan_Keys_DrawKeyNames
    call PauseMenu_Plan_Keys_ShowKeyDetails
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 1: the key cursor. Select switches the list between its two orders
; (wInventorySortFlags bit 1) and rebuilds it; Up/Down show the selected key's details; Left/Right
; turn pages when there are several; A picks the key; B leaves the key list (and, when the plan page
; was opened from a key-world exit, wModeState bit 3, returns to the field with wDataBankSave =
; $40). (C1, E-0357)
PauseMenu_Plan_Keys_Cursor::
    ld a, [wPauseListCount]
    or a
    jr z, .check_joypad_pressed2
    ld hl, wMenuCursor
    ld de, PauseMenu_Plan_Keys_Cursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    and $04
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    ld a, [wInventorySortFlags]
    bit 7, a
    jr nz, .set_inventory_sort_flags
    xor $02

.set_inventory_sort_flags:
    res 7, a
    ld [wInventorySortFlags], a
    xor a
    ld [wTemp1], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat2
    call PauseMenu_Plan_Keys_ShowKeyDetails
    ret

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_joypad_pressed
    ld a, [wMenuPageCount]
    cp $02
    ret c
    call PauseMenu_Plan_Keys_DrawKeyNames
    call PauseMenu_Plan_Keys_ShowKeyDetails
    ld a, [wMenuPageCount]
    cp $02
    ret c
    call ComputeMenuPagesForPauseListCountItems
    ld hl, vBGMap0 + $22f
    ld a, [wWindowTileBuffer + $c7]
    call WriteVRAMByte
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_joypad_pressed2
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_Plan_Keys_Cursor_Data
    call WriteBCTileAtWordTableEntry_Bank03
    ld hl, wTemp1
    inc [hl]
    ret

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    bit 1, a
    ret z
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ld a, [wModeState]
    bit 3, a
    ret z
    ld a, $40
    ld [wDataBankSave], a
    call ExitPauseMenuToField
    ret

; Key list, step 2: builds the use/discard choice (block $24) next to the list. (C1, E-0357)
PauseMenu_Plan_Keys_DrawUseDiscard::
    call BuildScreenBlocks21To24
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $07, $09
    call CopyRectToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wSubMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 3: the use/discard choice. Use (first choice) goes to step 4. Discard: a key that
; is the one in use inside its key world cannot be thrown away (step 7); a key whose kind is 7 or
; more names its contents (string of category 6) for the question, others their key name; then step
; $0A asks. (C1, E-0357)
PauseMenu_Plan_Keys_UseOrDiscard::
    ld hl, wSubMenuCursor
    ld de, PauseMenu_Plan_Keys_UseOrDiscard_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and $01
    jr nz, .call_test_list_entry_bit7
    ld hl, wTemp1
    inc [hl]
    ret

.call_test_list_entry_bit7:
    call TestListEntryBit7
    jr nz, .skip
    push af
    ld c, a
    ld a, [wCurrentKeyIndex]
    cp c
    jr nz, .restore
    ld a, [wMapType]
    bit 7, a
    jr z, .restore
    pop af
    jr .set_temp1_to_07

.restore:
    pop af
    push af
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    cp $fe
    jr nz, .call_write_key_name_to_de
    pop af
    ld a, [hl]
    jr .call_write_key_name_to_de2

.call_write_key_name_to_de:
    pop af

.call_write_key_name_to_de2:
    ld de, wTextBuf2
    call WriteKeyNameToDE
    ld a, $0a
    ld [wTemp1], a
    ret

.skip:
    and $7f
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    and $3f
    cp $07
    jr c, .set_temp1_to_07
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    ld hl, wTextBuf2
    ld a, l
    ld [wStringDestLo], a
    ld a, h
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank09
    ld a, $0a
    ld [wTemp1], a
    ret

.set_temp1_to_07:
    ld a, $07
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    ret z
    xor a
    ld [wTemp1], a
    ret

; Key list, step 4: redraws the list with the choice cursor. (C1, E-0357)
PauseMenu_Plan_Keys_RedrawForUse::
    call PauseMenu_Plan_Keys_RedrawWithChoice
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 5: uses the key. A key entry marked $FE shows message $0C (and, from a key-world
; exit, asks the field to restart with wDataBankSave = $40). From a key-world exit (wModeState bit
; 3) a normal key is chosen for travel: wDataBankSave = the key's index with bit 7 set and message
; $0B; elsewhere message 9 says it cannot be used here. (C1, E-0357)
PauseMenu_Plan_Keys_UseKey::
    call TestListEntryBit7
    jr nz, .check_mode_state
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    cp $fe
    jr nz, .check_mode_state
    ld a, [wModeState]
    bit 3, a
    jr z, .skip
    ld a, $40
    ld [wDataBankSave], a

.skip:
    ld a, $0c
    jr .set_string_index

.check_mode_state:
    ld a, [wModeState]
    bit 3, a
    jr nz, .call_test_list_entry_bit7
    ld a, $09

.set_string_index:
    ld [wStringIndex], a
    ld a, $08
    ld [wStringCategory], a
    jr .call_begin_string_display_bank08

.call_test_list_entry_bit7:
    call TestListEntryBit7
    set 7, a
    ld [wDataBankSave], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0b
    ld [wStringIndex], a

.call_begin_string_display_bank08:
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 6: after the message returns to the list; from a key-world exit it leaves for the
; field, which acts on wDataBankSave. (C1, E-0357)
PauseMenu_Plan_Keys_AfterMessage::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ld a, [wModeState]
    bit 3, a
    ret z
    call ExitPauseMenuToField
    ret

; Key list, step 7: redraws the list (the key cannot be discarded now). (C1, E-0357)
PauseMenu_Plan_Keys_RedrawForRefusal::
    call PauseMenu_Plan_Keys_RedrawWithChoice
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 8: shows 'You can't toss that out!' (message 8 of category 8,
; BeginStringDisplay_Bank08) and moves on. (C1, E-0369)
PauseMenu_Plan_Keys_ShowCantToss::
    ld a, $08
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 9: once the message is done (wTextFlags = 0), returns to step 0 (wTemp1 = 0), which
; rebuilds the key list. (C1, E-0369)
PauseMenu_Plan_Keys_CloseCantToss::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ret

; Key list, step 10: redraws the list for the discard question. (C1, E-0357)
PauseMenu_Plan_Keys_RedrawForDiscard::
    call PauseMenu_Plan_Keys_RedrawWithChoice
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 11: asks 'Toss out the ...?' (message 7 of category 8, with the key's name or
; contents placed in wTextBuf2 by step 3) and moves on. (C1, E-0369)
PauseMenu_Plan_Keys_AskToss::
    ld a, $08
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 12: waits for the question to finish. (C1, E-0357)
PauseMenu_Plan_Keys_AfterTossQuestion::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 13: builds the yes/no choice (block $25) with the cursor on 'no' and plays sound
; $6C. (C1, E-0357)
PauseMenu_Plan_Keys_DrawYesNo::
    call BuildScreenBlocks21To25WithCursor
    ld hl, vBGMap0 + $e0
    ld de, wScreenTileBuffer + $e0
    lb bc, $06, $05
    call CopyRectToBGMap
    ld a, $6c
    call QueueSoundEffect
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wSubMenuCursor2], a
    ld a, $01
    ld [wSubMenuCursor2], a
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 14: the yes/no choice. Yes goes on to the discard; no (or B) redraws the list and
; returns to the use/discard choice. (C1, E-0357)
PauseMenu_Plan_Keys_YesNoCursor::
    ld hl, wSubMenuCursor2
    ld de, PauseMenu_Plan_Keys_YesNoCursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor2]
    and $01
    ld hl, PauseMenu_Plan_Keys_YesNoCursor_Data
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wSubMenuCursor2]
    and $01
    jr nz, .call_build_screen_blocks21_to24
    ld hl, wTemp1
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z

.call_build_screen_blocks21_to24:
    call BuildScreenBlocks21To24
    ld hl, vBGMap0 + $80
    ld de, wScreenTileBuffer + $80
    lb bc, $06, $09
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRectToBGMap
    call PauseMenu_Plan_Keys_DrawKeyNames
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wSubMenuCursor], a
    ld a, $03
    ld [wTemp1], a
    ret

; Key list, step 15 (yes to the toss question): shows '... threw away the ...' (message 4 of
; category 8, with the player's name and the key name in wTextBuf2) and moves on to deleting the
; key. (C1, E-0369)
PauseMenu_Plan_Keys_ShowThrewAway::
    ld a, $04
    ld [wStringIndex], a
    ld a, $08
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; Key list, step 16: after the message deletes the key entry (DeleteKeyEntryTemp0, its index with
; bit 7 and the high bits cleared) and returns to the first page. (C1, E-0357)
PauseMenu_Plan_Keys_DeleteKey::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    call TestListEntryBit7
    jr z, .set_temp0
    res 7, a
    and $3f

.set_temp0:
    ldh [hTemp0], a
    farcall DeleteKeyEntryTemp0
    xor a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    ret

; index = wMenuPage * 4 + (wMenuCursor & 7): A = wWorkBuf + $A[index], Z clear when its bit 7 is set
; (E-0117)
TestListEntryBit7::
    ld a, [wMenuPage]
    ld b, a
    add a
    add a
    ld b, a
    ld a, [wMenuCursor]
    and $07
    add b
    ld hl, wWorkBuf + $a
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    ret

; copies the tile buffer and a rectangle, then the menu cursor (renamed from
; PauseMenu_Plan_TileBufferMenu from its E-0357 note, E-0367)
PauseMenu_Plan_Tactics::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Tactics_Build
    dw PauseMenu_Plan_Tactics_ShowCurrent
    dw PauseMenu_Plan_Tactics_Cursor

; Plan, tactics: builds the tactics screen for the first party member (wPauseMenuStep = 0) with four
; choices. (C1, E-0357)
PauseMenu_Plan_Tactics_Build::
    xor a
    ld [wPauseMenuStep], a
    call PauseMenu_Plan_Tactics_Build_DrawScreen
    call CopyTileBufferToBGMap
    ld a, $04
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld a, $00
    ld [wMenuPage], a
    ld hl, wTemp1
    inc [hl]
    ret

; Tactics, step 1: shows the current member's tile number and sets the cursor to its current tactic
; (bits 4-5 of record byte MON_SEX). (C1, E-0357)
PauseMenu_Plan_Tactics_ShowCurrent::
    ld a, [wPauseMenuStep]
    ld hl, PauseMenu_Plan_Tactics_ShowCurrent_Data
    add_a_to_hl
    ld a, [hl]
    ld hl, wScreenTileBuffer + $ee
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hl], a
    ld hl, vBGMap0 + $ea
    ld de, wScreenTileBuffer + $ea
    lb bc, $09, $0a
    call CopyRectToBGMap
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wPauseMenuStep]
    ld c, MON_SEX
    call SRAMRecordAddressMapped
    ld a, [hl]
    swap a
    and $03
    ld [wMenuCursor], a
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ret

; Tactics, step 2: the tactic cursor. A rebuilds the high nibble of the member's MON_SEX byte from
; the chosen tactic, keeping its low nibble (the sex), and moves to the next member; after the last
; member, or B on the first, it returns to the plan page; B on a later member goes back one. (C1,
; E-0357)
PauseMenu_Plan_Tactics_Cursor::
    ld hl, wMenuCursor
    ld de, PauseMenu_Plan_Tactics_Cursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld a, [wPauseMenuStep]
    or a
    jr z, .loop
    dec a
    ld [wPauseMenuStep], a
    ld hl, wTemp1
    dec [hl]
    ret

.loop:
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

.check_bit0:
    bit 0, a
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wPauseMenuStep]
    ld c, MON_SEX
    call SRAMRecordAddressMapped
    ld a, [wMenuCursor]
    and $03
    swap a
    ld c, a
    cp $30
    jr nz, .skip
    ld a, [hl]
    and $c0
    jr .skip2

.skip:
    rlca
    rlca

.skip2:
    or c
    ld c, a
    ld a, [hl]
    and $0f
    or c
    ld [hl], a
    ld a, $00
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld c, a
    ld a, [wPauseMenuStep]
    inc a
    ld [wPauseMenuStep], a
    cp c
    jr z, .loop
    ld hl, wTemp1
    dec [hl]
    ret

; data read by PauseMenu_Plan_Tactics_ShowCurrent (3 bytes) (E-0347)
PauseMenu_Plan_Tactics_ShowCurrent_Data::
    db $d0, $d5, $da

; screen block $21 with the cursor and block $2C, then a sound (renamed from
; PauseMenu_Plan_Blocks21And2C from its E-0357 note, E-0367)
PauseMenu_Plan_MessageSpeed::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_MessageSpeed_Build
    dw PauseMenu_Plan_MessageSpeed_Cursor

; Plan, message speed: builds the screen with the cursor on the current wBattleTextSpeed. (C1,
; E-0357)
PauseMenu_Plan_MessageSpeed_Build::
    call LoadScreenBlock21CursorAnd2C
    call CopyTileBufferToBGMap
    ld a, [wBattleTextSpeed]
    ld [wMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; Message speed, step 1: Left/Right move among the eight speeds (redrawing the cursor, sound $69); A
; stores the choice in wBattleTextSpeed; A or B return to the plan page. (C1, E-0357)
PauseMenu_Plan_MessageSpeed_Cursor::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    and $07
    ld [wBattleTextSpeed], a
    jr .clear_temp0

.check_bit1:
    bit 1, a
    jr z, .check_joypad_pressed_repeat

.clear_temp0:
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_bit4
    call EraseMenuCursorMenuCursor
    ld a, [wMenuCursor]
    dec a
    jr .set_menu_cursor

.check_bit4:
    bit 4, a
    jr z, .check_frame_counter_lo
    call EraseMenuCursorMenuCursor
    ld a, [wMenuCursor]
    inc a

.set_menu_cursor:
    and $07
    ld [wMenuCursor], a
    call DrawMenuCursorMenuCursor
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a
    ld a, $69
    call QueueSoundEffect
    ret

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_erase_menu_cursor_menu_cursor
    call DrawMenuCursorMenuCursor
    jr .return

.call_erase_menu_cursor_menu_cursor:
    call EraseMenuCursorMenuCursor
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

.return:
    ret

; writes the cursor tile $BB at MenuCursorAddressMenuCursor (E-0114)
DrawMenuCursorMenuCursor::
    call MenuCursorAddressMenuCursor
    ld a, $bb
    call WriteVRAMByte
    ret

; writes the blank tile $C3 at MenuCursorAddressMenuCursor (E-0114)
EraseMenuCursorMenuCursor::
    call MenuCursorAddressMenuCursor
    ld a, $c3
    call WriteVRAMByte
    ret

; HL = the word at MenuCursorAddressMenuCursor_Data + 2 * wMenuCursor (the cursor row's VRAM
; address) (E-0114)
MenuCursorAddressMenuCursor::
    ld a, [wMenuCursor]
    ld hl, MenuCursorAddressMenuCursor_Data
    add a
    add_a_to_hl
    deref_hl
    ret

; sets the page count, the cursor and screen block $21 (renamed from PauseMenu_Plan_PagedMenu from
; its E-0357 note, E-0367)
PauseMenu_Plan_PartyOrder::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_PartyOrder_Start
    dw PauseMenu_Plan_PartyOrder_NextPlacement
    dw PauseMenu_Plan_PartyOrder_Cursor
    dw PauseMenu_Plan_PartyOrder_RedrawForConfirm
    dw PauseMenu_Plan_PartyOrder_Finish
    dw PauseMenu_Plan_PartyOrder_Redraw

; Plan, party order: starts the reordering: the members still to place (wWorkBuf + 3..5, $FF for
; absent ones), the new order (wWorkBuf + 6..8, empty), and the screen. (C1, E-0357)
PauseMenu_Plan_PartyOrder_Start::
    ld a, [wPartyCount]
    dec a
    ld [wWorkBuf + $2], a
    ld c, $00
    ld a, c
    ld [wWorkBuf + $3], a
    ld a, [wPartyCount]
    cp $01
    jr z, .set_work_buf
    inc c
    jr .set_work_buf2

.set_work_buf:
    ld c, $ff

.set_work_buf2:
    ld a, c
    ld [wWorkBuf + $4], a
    ld a, [wPartyCount]
    cp $03
    jr nz, .set_work_buf3
    inc c
    jr .set_work_buf4

.set_work_buf3:
    ld c, $ff

.set_work_buf4:
    ld a, c
    ld [wWorkBuf + $5], a
    ld a, $ff
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld [wWorkBuf + $8], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wMenuPage], a
    ld [wPauseMenuStep], a
    call PauseMenu_Plan_PartyOrder_BuildScreen
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Party order, step 1: draws the two columns and shows the first unplaced member's details. (C1,
; E-0357)
PauseMenu_Plan_PartyOrder_NextPlacement::
    call PauseMenu_Plan_PartyOrder_DrawColumns
    xor a
    ld [wMenuCursor], a
    call PauseMenu_Plan_PartyOrder_ShowStringBank08AtTilesHL_Bank03
    ld hl, wTemp1
    inc [hl]
    ret

; Party order, step 2: the cursor over the unplaced members (showing each one's details). A moves
; the chosen member to the next place of the new order and re-sorts the rest; after all are placed
; it goes to the confirmation; B undoes the last placement (step 5) or leaves when none is placed.
; (C1, E-0357)
PauseMenu_Plan_PartyOrder_Cursor::
    ld hl, wMenuCursor
    ld de, PauseMenu_Plan_PartyOrder_Cursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    call PauseMenu_Plan_PartyOrder_ShowStringBank08AtTilesHL_Bank03
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    and $03
    ld hl, wWorkBuf + $3
    add_a_to_hl
    ld c, [hl]
    ld [hl], $ff
    ld a, [wPauseMenuStep]
    ld hl, wWorkBuf + $6
    add_a_to_hl
    ld [hl], c
    call PauseMenu_Plan_PartyOrder_SortUnplaced
    ld hl, wWorkBuf + $2
    dec [hl]
    ld a, [wPartyCount]
    ld b, a
    ld a, [wPauseMenuStep]
    inc a
    ld [wPauseMenuStep], a
    cp b
    jr z, .done
    ld hl, wTemp1
    dec [hl]
    ret

.done:
    ld hl, wTemp1
    inc [hl]
    ret

.check_bit1:
    bit 1, a
    ret z
    ld a, [wPauseMenuStep]
    or a
    jr nz, PauseMenu_Plan_PartyOrder_UndoPlacement
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; Undoes the last placement in the party order: wWorkBuf + 2 += 1 and wPauseMenuStep -= 1; the
; member at that place of the new order (wWorkBuf + 6..8, set back to $FF) returns to the unplaced
; list at wWorkBuf + 3 + (new wWorkBuf + 2), which is re-sorted
; (PauseMenu_Plan_PartyOrder_SortUnplaced); then wTemp1 -= 1. B in step 2 jumps here (back to step
; 1); step 5 (PauseMenu_Plan_PartyOrder_Redraw) calls it. (C1, E-0369)
PauseMenu_Plan_PartyOrder_UndoPlacement::
    ld hl, wWorkBuf + $2
    inc [hl]
    ld a, [wPauseMenuStep]
    dec a
    ld [wPauseMenuStep], a
    ld hl, wWorkBuf + $6
    add_a_to_hl
    ld c, [hl]
    ld [hl], $ff
    ld a, [wWorkBuf + $2]
    ld hl, wWorkBuf + $3
    add_a_to_hl
    ld [hl], c
    call PauseMenu_Plan_PartyOrder_SortUnplaced
    ld hl, wTemp1
    dec [hl]
    ret

; Party order, step 3: redraws the plan page and the order columns for the confirmation. (C1,
; E-0357)
PauseMenu_Plan_PartyOrder_RedrawForConfirm::
    call LoadScreenBlock21
    ld a, [wMenuSelectedMember]
    and $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    call PauseMenu_Plan_PartyOrder_DrawColumns
    ld de, wScreenTileBuffer + $128
    ld hl, vBGMap0 + $128
    lb bc, $0c, $09
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Party order, step 4: A writes the new order into wPartyList and returns to the plan page; B undoes
; the last placement. (C1, E-0357)
PauseMenu_Plan_PartyOrder_Finish::
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    call PauseMenu_Plan_PartyOrder_Finish_ApplyOrder
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

; Party order, step 5: redraws the screen after undoing a placement and returns to step 2. (C1,
; E-0357)
PauseMenu_Plan_PartyOrder_Redraw::
    call PauseMenu_Plan_PartyOrder_BuildScreen
    call PauseMenu_Plan_PartyOrder_UndoPlacement
    call PauseMenu_Plan_PartyOrder_DrawColumns
    xor a
    ld [wMenuCursor], a
    call PauseMenu_Plan_PartyOrder_ShowStringBank08AtTilesHL_Bank03
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    dec [hl]
    ld hl, wTemp1
    dec [hl]
    ret

; Writes the new party order (wWorkBuf + 6..8, ignoring $FF) into the first entries of wPartyList.
; (C1, E-0357)
PauseMenu_Plan_PartyOrder_Finish_ApplyOrder::
    ld a, [wWorkBuf + $6]
    ld hl, wPartyList
    add_a_to_hl
    ld c, [hl]
    ld a, [wWorkBuf + $7]
    cp $ff
    jr z, .set_party_list2
    ld hl, wPartyList
    add_a_to_hl
    ld b, [hl]
    ld a, [wWorkBuf + $8]
    cp $ff
    jr z, .set_party_list
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wPartyList + $2], a

.set_party_list:
    ld a, b
    ld [wPartyList + $1], a

.set_party_list2:
    ld a, c
    ld [wPartyList], a
    ret

; Draws the two order columns into the screen buffer, after block $28 (LoadScreenBlock28): for the
; unplaced slots wWorkBuf + 3..5 each member's number and five tiles on rows from wScreenTileBuffer
; + $63 (PauseMenu_Plan_PartyOrder_DrawUnplacedEntry), for the places wWorkBuf + 6..8 tiles $E1,
; $E2, $E3 and the placed member's five tiles on rows from wScreenTileBuffer + $6C
; (PauseMenu_Plan_PartyOrder_DrawPlacedEntry), skipping $FF entries; sets wMenuRowCount to the
; members left (wWorkBuf + 2 + 1) and copies the 16 x 5 area at $63 to the BG map. (C1, E-0369)
PauseMenu_Plan_PartyOrder_DrawColumns::
    call LoadScreenBlock28
    ld a, [wWorkBuf + $2]
    inc a
    ld [wMenuRowCount], a
    ld de, wScreenTileBuffer + $63
    ld a, [wWorkBuf + $3]
    call PauseMenu_Plan_PartyOrder_DrawUnplacedEntry
    ld de, wScreenTileBuffer + $a3
    ld a, [wWorkBuf + $4]
    call PauseMenu_Plan_PartyOrder_DrawUnplacedEntry
    ld de, wScreenTileBuffer + $e3
    ld a, [wWorkBuf + $5]
    call PauseMenu_Plan_PartyOrder_DrawUnplacedEntry
    ld de, wScreenTileBuffer + $6c
    ld a, [wWorkBuf + $6]
    ld b, $e1
    call PauseMenu_Plan_PartyOrder_DrawPlacedEntry
    ld de, wScreenTileBuffer + $ac
    ld a, [wWorkBuf + $7]
    ld b, $e2
    call PauseMenu_Plan_PartyOrder_DrawPlacedEntry
    ld de, wScreenTileBuffer + $ec
    ld a, [wWorkBuf + $8]
    ld b, $e3
    call PauseMenu_Plan_PartyOrder_DrawPlacedEntry
    ld de, wScreenTileBuffer + $63
    ld hl, vBGMap0 + $63
    lb bc, $10, $05
    call CopyRectToBGMap
    ret

; Shared tail of PauseMenu_Plan_PartyOrder_DrawUnplacedEntry and
; PauseMenu_Plan_PartyOrder_DrawPlacedEntry: DE += 2, then falls into
; PauseMenu_Plan_PagedMenu_WriteFiveTileRun, which writes the five consecutive tiles starting at
; $D0, $D5 or $DA for member A at DE. (C1, E-0369)
PauseMenu_Plan_PartyOrder_DrawMemberTiles::
    inc de
    inc de

; writes five consecutive tile numbers, starting at the table byte for A, at DE (E-0305)
PauseMenu_Plan_PagedMenu_WriteFiveTileRun::
    ld hl, PauseMenu_Plan_PagedMenu_WriteFiveTileRun_Data
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

; A = member index or $FF, DE = row position: unless A is $FF (an empty slot, nothing drawn), writes
; the member number tile $E1 + A at DE and, two tiles further on, the member's five tiles
; (PauseMenu_Plan_PartyOrder_DrawMemberTiles). (C1, E-0369)
PauseMenu_Plan_PartyOrder_DrawUnplacedEntry::
    cp $ff
    ret z
    push af
    add $e1
    ld [de], a
    pop af
    jr PauseMenu_Plan_PartyOrder_DrawMemberTiles

; A = member index or $FF, B = place tile ($E1-$E3), DE = row position: unless A is $FF (nothing
; drawn), writes tile B at DE and, two tiles further on, the five tiles of member A
; (PauseMenu_Plan_PartyOrder_DrawMemberTiles). (C1, E-0369)
PauseMenu_Plan_PartyOrder_DrawPlacedEntry::
    cp $ff
    ret z
    push af
    ld a, b
    ld [de], a
    pop af
    jr PauseMenu_Plan_PartyOrder_DrawMemberTiles

; Shows the details of the unplaced member under the cursor: species name, sex mark, level and
; further numbers from its record. (C1, E-0357)
PauseMenu_Plan_PartyOrder_ShowStringBank08AtTilesHL_Bank03::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuCursor]
    and $03
    ld hl, wWorkBuf + $3
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, MON_SPECIES
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hli]
    push hl
    add $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $200
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop hl
    inc hl
    ld a, [hl]
    and $01
    add $cc
    ld [wScreenTileBuffer + $14e], a
    ld a, l
    add $48
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $151
    call WriteTwoDigitTilesFromDigits1
    pop hl
    ld a, l
    add $05
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $64
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $68
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hli]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a4
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a8
    call WriteDecimalDigitTiles
    pop af
    push af
    add $c7
    ld [wWindowTileBuffer + $21], a
    pop af
    ld de, wScreenTileBuffer + $149
    call PauseMenu_Plan_PagedMenu_WriteFiveTileRun
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $149
    ld de, wScreenTileBuffer + $149
    lb bc, $0a, $07
    call CopyRectToBGMap
    ret

; Sorts the three unplaced-member slots (wWorkBuf + 3..5) into ascending order, so the empty $FF
; slots go last. (C1, E-0357)
PauseMenu_Plan_PartyOrder_SortUnplaced::
    ld a, [wWorkBuf + $3]
    ld c, a
    ld a, [wWorkBuf + $4]
    ld b, a
    ld a, [wWorkBuf + $5]
    ld e, a
    cp b
    jr c, .skip
    cp c
    jr c, .set_work_buf4
    ld [wWorkBuf + $5], a
    ld a, b
    cp c
    jr c, .set_work_buf
    ld [wWorkBuf + $4], a
    ld a, c
    ld [wWorkBuf + $3], a
    jr .return

.set_work_buf:
    ld [wWorkBuf + $3], a
    ld a, c
    ld [wWorkBuf + $4], a
    jr .return

.skip:
    cp c
    jr c, .set_work_buf2
    ld [wWorkBuf + $4], a
    ld a, c
    ld [wWorkBuf + $3], a
    ld a, b
    ld [wWorkBuf + $5], a
    jr .return

.set_work_buf2:
    ld [wWorkBuf + $3], a
    ld a, b
    cp c
    jr c, .set_work_buf3
    ld [wWorkBuf + $5], a
    ld a, c
    ld [wWorkBuf + $4], a
    jr .return

.set_work_buf3:
    ld [wWorkBuf + $4], a
    ld a, c
    ld [wWorkBuf + $5], a
    jr .return

.set_work_buf4:
    ld [wWorkBuf + $4], a
    ld a, b
    ld [wWorkBuf + $3], a
    ld a, c
    ld [wWorkBuf + $5], a

.return:
    ret

; data read by PauseMenu_Plan_PagedMenu_WriteFiveTileRun (3 bytes) (E-0347)
PauseMenu_Plan_PagedMenu_WriteFiveTileRun_Data::
    db $d0, $d5, $da

; screen block $2D and a decimal number (renamed from PauseMenu_Plan_Block2DNumber from its E-0357
; note, E-0367)
PauseMenu_Plan_PlayerRecord::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_PlayerRecord_Build
    dw PauseMenu_Plan_PlayerRecord_UpdateTime

; Plan, the player's record page: player name, play time (hours and minutes), counts of the stored
; monsters, the number of flagged records (CountFlaggedSRAMRecords), the number of species seen per
; family (11 family icons) and their total. (C1, E-0357)
PauseMenu_Plan_PlayerRecord_Build::
    call LoadScreenBlock2D
    ld a, $20
    ld [wWorkBuf + $1], a
    farcall LoadAllFamilyIconTiles
    ld hl, wPlayerName
    call CopyTenBytesToTextBuf0
    ld hl, vTiles2 + $300
    call SelectString5Category8ThenShow
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $68
    call WriteThreeDigitTilesDigits_Bank03
    ld a, [wPlayMinutes]
    call ByteAToDecimalDigits
    ld de, wScreenTileBuffer + $6c
    call WriteTwoDigitTilesDigits1NoBlank_Bank03
    call PauseMenu_Plan_PlayerRecord_CountMonsters
    ld a, [wWorkBuf]
    ld de, wScreenTileBuffer + $ab
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $1]
    ld de, wScreenTileBuffer + $b1
    call WriteAAsTwoDigitTiles
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    ld de, wScreenTileBuffer + $eb
    call WriteAAsTwoDigitTiles
    farcall CountSpeciesPerFamilyFlaggedOrListed
    ld a, [wWorkBuf]
    ld de, wWindowTileBuffer + $1b
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $1]
    ld de, wWindowTileBuffer + $1f
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $2]
    ld de, wWindowTileBuffer + $23
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $3]
    ld de, wWindowTileBuffer + $27
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $4]
    ld de, wWindowTileBuffer + $5b
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $5]
    ld de, wWindowTileBuffer + $5f
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $6]
    ld de, wWindowTileBuffer + $63
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $7]
    ld de, wWindowTileBuffer + $67
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $8]
    ld de, wWindowTileBuffer + $9b
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $9]
    ld de, wWindowTileBuffer + $9f
    call WriteAAsTwoDigitTiles
    ld a, [wWorkBuf + $a]
    ld de, wWindowTileBuffer + $a3
    call WriteAAsTwoDigitTiles
    ld hl, $0000
    ld de, wWorkBuf
    ld b, $0b

.loop:
    ld a, [de]
    inc de
    add_a_to_hl
    dec b
    jr nz, .loop
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $14e
    call WriteDecimalDigitTiles
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; Player record page, step 1: refreshes the play time each new minute; A or B return to the plan
; page. (C1, E-0357)
PauseMenu_Plan_PlayerRecord_UpdateTime::
    ld a, [wJoypadPressed]
    and $03
    jr nz, .clear_temp0
    ld a, [wPlayFrames]
    or a
    ret nz
    ld a, [wPlaySeconds]
    or a
    ret nz
    ld a, [wPlayMinutes]
    call ByteAToDecimalDigits
    ld de, wScreenTileBuffer + $6c
    call WriteTwoDigitTilesDigits1NoBlank_Bank03
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $68
    call WriteThreeDigitTilesDigits_Bank03
    ld de, wScreenTileBuffer + $68
    ld hl, vBGMap0 + $68
    lb bc, $06, $01
    call CopyRectToBGMap
    ret

.clear_temp0:
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; HL = A (zero-extended), then HLToDecimalDigits (E-0101)
ByteAToDecimalDigits::
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ret

; ByteAToDecimalDigits, then WriteTwoDigitTilesFromDigits1 at DE (leading zero blank); DE kept
; across the conversion (E-0114) (E-0345: was WriteAAsTwoDigitTiles)
WriteAAsTwoDigitTiles::
    push de
    call ByteAToDecimalDigits
    pop de
    call WriteTwoDigitTilesFromDigits1
    ret

; writes wDigits as a digit tile at DE and falls into WriteTwoDigitTilesDigits1NoBlank_Bank03
; (E-0126)
WriteThreeDigitTilesDigits_Bank03::
    ld hl, wDigits
    ld a, [hl]
    add $e0
    ld [de], a
    inc de

; writes wDigits + $1 and wDigits + $2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank)
; (E-0117) (the same 13 bytes appear in 2 banks)
WriteTwoDigitTilesDigits1NoBlank_Bank03::
    ld hl, wDigits + $1
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hl]
    add $e0
    ld [de], a
    ret

; by wTemp1: 'Want to record your journey?', then 'Your progress has been recorded.' (renamed from
; PauseMenu_Plan_RecordJourney from its E-0357 note, E-0367)
PauseMenu_Plan_Record::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Record_ShowMaster
    dw PauseMenu_Plan_Record_DrawYesNo
    dw PauseMenu_Plan_Record_YesNoCursor
    dw PauseMenu_Plan_Record_RunSaveScreens
    dw PauseMenu_Plan_Record_ShowYourProgressHasBeen
    dw PauseMenu_Plan_Record_Return
    dw PauseMenu_Plan_RecordJourney_RestartGame

; Plan, recording the journey, step 0: builds the save screen and shows the 'Master' title string
; from bank $07 in a 4 x 1 window. (C1, E-0357)
PauseMenu_Plan_Record_ShowMaster::
    xor a
    ldh [hSpriteWindowClipMode], a
    call PauseMenu_Plan_Record_BuildScreen
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles2 + $50
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0401
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a ; 'Master'
    farcall ShowString_Bank07
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $c3
    ld [wScreenTileBuffer + $61], a
    call CopyTileBufferToBGMap
    ld a, $00
    ld [wStringCategory], a
    ld a, $25
    ld [wStringIndex], a ; 'Want to record your journey?'
    farcall BeginStringDisplay_Bank37
    call DrawSaveCompletionMark
    ld hl, wTemp1
    inc [hl]
    ret

; Recording, step 1: after the question loads the choice tiles, plays sound $6C and builds the
; yes/no choice (block $2B). (C1, E-0357)
PauseMenu_Plan_Record_DrawYesNo::
    call DrawSaveCompletionMark
    ld a, [wTextFlags]
    or a
    ret nz
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles1 + $740
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6c
    call QueueSoundEffect
    call LoadScreenBlock2B
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wSubMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; Recording, step 2: yes starts the save screens; no or B returns to the plan page, or restarts the
; game when the page was opened from a key-world exit (wModeState bit 3). The record sprite is
; redrawn each frame. (C1, E-0357)
PauseMenu_Plan_Record_YesNoCursor::
    ld hl, wSubMenuCursor
    ld de, PauseMenu_Items_UseItem_ChoiceCursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and $01
    ld hl, PauseMenu_Items_UseItem_ChoiceCursor_Data
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wSubMenuCursor]
    and $01
    jr nz, .loop
    call DrawSaveCompletionMark
    xor a
    ld [wPauseMenuScreen], a
    ld hl, wTemp1
    inc [hl]
    ret

.loop:
    ld a, [wModeState]
    bit 3, a
    jr nz, PauseMenu_Plan_Record_PrepareRestart
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    jr nz, .loop
    call DrawSaveCompletionMark
    ret

; Recording, step 3: runs the save screens until all four are done. (C1, E-0357)
PauseMenu_Plan_Record_RunSaveScreens::
    call DrawSaveCompletionMark
    call RunPauseMenuScreen
    ld a, [wPauseMenuScreen]
    cp $04
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

; Recording, step 4: shows 'Your progress has been recorded' (message $26, bank $37). (C1, E-0357)
PauseMenu_Plan_Record_ShowYourProgressHasBeen::
    call DrawSaveCompletionMark
    ld a, $00
    ld [wStringCategory], a
    ld a, $26
    ld [wStringIndex], a ; 'Your progress has been recorded.'
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; Recording, step 5: after the message returns to the plan page, or restarts from a key-world exit.
; (C1, E-0357)
PauseMenu_Plan_Record_Return::
    ld a, [wTextFlags]
    or a
    jr z, .check_mode_state
    call DrawSaveCompletionMark
    ret

.check_mode_state:
    ld a, [wModeState]
    bit 3, a
    jr nz, PauseMenu_Plan_Record_PrepareRestart
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; jumps to BootAndMainLoop (restarts the game) (E-0305)
PauseMenu_Plan_RecordJourney_RestartGame::
    jp BootAndMainLoop_StartUp

; Blanks the screen (wScreenTileBuffer filled with $C3, CopyTileBufferToBGMap) and sets wTemp1 = 6,
; the recording step PauseMenu_Plan_RecordJourney_RestartGame, which restarts the game.
; PauseMenu_Plan_Record_YesNoCursor (no or B) and PauseMenu_Plan_Record_Return jump here when the
; plan page was opened from a key-world exit (wModeState bit 3). (C1, E-0369)
PauseMenu_Plan_Record_PrepareRestart::
    ld bc, $0240
    ld hl, wScreenTileBuffer
    ld a, $c3
    call FillBytes
    call CopyTileBufferToBGMap
    ld a, $06
    ld [wTemp1], a
    ret

; Draws the completion mark on the save screen: when the save in SRAM bank 1 has a battle record
; (wBattlerRecords) and the game was completed (wTitleGameCompleted), draws meta-sprite set $29 at
; (128, 48). (C1, E-0357)
DrawSaveCompletionMark::
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wBattlerRecords]
    or a
    jr z, .skip
    ld a, [wTitleGameCompleted]
    or a
    jr z, .skip
    ld a, $29
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    ld hl, $0080
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ld hl, $0030
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a
    farcall DrawMetaSprite
    ret

.skip:
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a
    ret

; clears the screen tile buffer (ClearScreenTileBuffer_Bank03) and copies block $21 into it
; (CopyBlockToTileBuffer, E = $21) (E-0101)
LoadScreenBlock21::
    call ClearScreenTileBuffer_Bank03
    ld e, $21
    farcall CopyBlockToTileBuffer
    ret

; LoadScreenBlock21, then writes tile $BC at MenuCursorPositions_Bank03[wMenuSelectedMember & 7] in
; the buffer (WriteBCTileToScreenBufferAtTableEntry_Bank03) (E-0101)
LoadScreenBlock21WithCursor::
    call LoadScreenBlock21
    ld a, [wMenuSelectedMember]
    and $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; loads block $21 with its cursor and block $23, adds block $22 when
; BuildScreenBlocks21To23_BuildKeyList returns NZ, then runs ComputeMenuPagesForPauseListCountItems
; (E-0122)
BuildScreenBlocks21To23::
    call LoadScreenBlock21WithCursor
    ld e, $23
    farcall CopyBlockToTileBuffer
    call BuildScreenBlocks21To23_BuildKeyList
    jr z, .call_compute_menu_pages_for_pause_list_count
    ld e, $22
    farcall CopyBlockToTileBuffer

.call_compute_menu_pages_for_pause_list_count:
    call ComputeMenuPagesForPauseListCountItems
    ret

; builds blocks $21-$23 and copies block $24 (E-0122)
BuildScreenBlocks21To24::
    call BuildScreenBlocks21To23
    ld e, $24
    farcall CopyBlockToTileBuffer
    ret

; Redraws the key list with the choice cursor (block $10 and the cursor from the choice table) and
; its message window. (C1, E-0357)
PauseMenu_Plan_Keys_RedrawWithChoice::
    call BuildScreenBlocks21To24
    call FillTilesFromRequest
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $07
    ld hl, PauseMenu_Plan_Keys_UseOrDiscard_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld hl, vBGMap0 + $80
    ld de, wScreenTileBuffer + $80
    lb bc, $06, $09
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRectToBGMap
    ret

; builds blocks $21-$24, draws the cursor for wSubMenuCursor & 7 and copies blocks $25 and $10
; (E-0122)
BuildScreenBlocks21To25WithCursor::
    call BuildScreenBlocks21To24
    ld a, [wSubMenuCursor]
    and $07
    ld hl, PauseMenu_Plan_Keys_UseOrDiscard_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $25
    farcall CopyBlockToTileBuffer
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; Builds the tactics screen: the plan page with the cursor, tiles from bank $1F, and blocks $26 and
; $27. (C1, E-0357)
PauseMenu_Plan_Tactics_Build_DrawScreen::
    call LoadScreenBlock21WithCursor
    ld hl, PauseMenu_Plan_Tactics_Build_DrawScreen_TileCopyDestList
    ld de, PauseMenu_Plan_Tactics_Build_DrawScreen_TileCopySrcList
    call PauseMenu_Plan_TileBufferMenu_CopyTileListFromBank1F
    ld e, $26
    farcall CopyBlockToTileBuffer
    ld e, $27
    farcall CopyBlockToTileBuffer
    ret

; LoadScreenBlock21WithCursor, then block $2C (E-0114)
LoadScreenBlock21CursorAnd2C::
    call LoadScreenBlock21WithCursor
    ld e, $2c
    farcall CopyBlockToTileBuffer
    ret

; Builds the party order screen: the plan page with its cursor (LoadScreenBlock21WithCursor) and
; block $29, then falls into LoadScreenBlock28 (block $28). (C1, E-0369)
PauseMenu_Plan_PartyOrder_BuildScreen::
    call LoadScreenBlock21WithCursor
    ld e, $29
    farcall CopyBlockToTileBuffer

; copies screen block $28 into the tile buffer (CopyBlockToTileBuffer) (E-0114)
LoadScreenBlock28::
    ld e, $28
    farcall CopyBlockToTileBuffer
    ret

; copies screen block $2D into the tile buffer (E-0114)
LoadScreenBlock2D::
    ld e, $2d
    farcall CopyBlockToTileBuffer
    ret

; Builds the save screen: block $2A with the plan cursor, the message window (block $10) and the
; save summary graphics. (C1, E-0357)
PauseMenu_Plan_Record_BuildScreen::
    ld e, $2a
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    call FillTilesFromRequest
    ld e, $10
    farcall CopyBlockToTileBuffer
    farcall DecompressA4GraphicsAndContinue
    ret

; copies screen block $2B into the tile buffer (E-0114)
LoadScreenBlock2B::
    ld e, $2b
    farcall CopyBlockToTileBuffer
    ret

; Draws the names of the four keys on the current page of the key list (12 x 1 windows), or the
; empty-list text when there are none. (C1, E-0357)
PauseMenu_Plan_Keys_DrawKeyNames::
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wMenuPage]
    ld b, a
    add a
    add a
    ld de, wWorkBuf + $a
    add e
    ld e, a
    jr nc, .check_pause_list_count
    inc d

.check_pause_list_count:
    ld bc, $0400
    ld a, [wPauseListCount]
    or a
    jr nz, .loop
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $440
    ld de, $0c01
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    ld bc, $0301
    ld de, wWorkBuf + $b

.loop:
    push bc
    push de
    ld a, c
    ld hl, PauseMenu_Plan_Keys_DrawKeyNames_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, [de]
    call PauseMenu_Plan_ChooseListEntry_DrawKeyEntryMark
    cp $ff
    jr z, .set_string_category_to_06
    and $3f
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    bit 7, a
    jr nz, .next
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp $fe
    jr z, .call_write_key_name_to_de
    ld a, [de]

.call_write_key_name_to_de:
    ld de, wTextBuf0
    call WriteKeyNameToDE
    ld a, $5b
    ld [de], a
    inc de
    ld a, $f0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr .restore

.next:
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $3f
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall ShowString_Bank09
    jr .restore

.set_string_category_to_06:
    ld a, $06
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank09

.restore:
    pop de
    pop bc
    inc de
    inc c
    dec b
    jp nz, .loop
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

; reads the key entry byte for A (bit flags) and writes a mark tile for list row C (E-0305)
PauseMenu_Plan_ChooseListEntry_DrawKeyEntryMark::
    push af
    cp $ff
    jr z, .skip
    and $3f
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    and $f0
    cp $f0

.skip:
    push af
    ld a, c
    ld hl, PauseMenu_Plan_ChooseListEntry_DrawKeyEntryMark_Data
    add a
    add_a_to_hl
    deref_hl
    pop af
    jr z, .call_write_vram_byte
    bit 6, a
    jr z, .call_write_vram_byte
    ld a, $1d
    jr .call_write_vram_byte2

.call_write_vram_byte:
    ld a, $c3

.call_write_vram_byte2:
    call WriteVRAMByte
    pop af
    ret

; data read by PauseMenu_Plan_Keys_DrawKeyNames (10 bytes) (E-0347)
PauseMenu_Plan_Keys_DrawKeyNames_Data::
    db $40, $94, $00, $95, $c0, $95, $80, $96, $40, $97

PauseMenu_Plan_ChooseListEntry_DrawKeyEntryMark_Data::
    db $46, $99, $86, $99, $c6, $99, $06, $9a

; When the key list is not empty (wPauseListCount), shows the details of the key under the cursor
; (list entry wWorkBuf + $A + wMenuPage * 4 + wMenuCursor) in a 12 x 3 window at vTiles2 + $200, as
; a string of category 7 (ShowString_Bank09): for a key whose wKeyList entry has byte 3 bit 7 set,
; string (byte 0 & $3F); for a key whose byte 0 is $FE, string $0D ('Magic Key to where?');
; otherwise string $0E ('Key to' the key's name, written to wTextBuf0 by WriteKeyNameToDE). Then
; sets the text window back to vTiles1, 18 x 2. (C1, E-0369)
PauseMenu_Plan_Keys_ShowKeyDetails::
    ld a, [wPauseListCount]
    or a
    ret z
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c03
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wMenuPage]
    ld b, a
    add a
    add a
    ld b, a
    ld hl, wWorkBuf + $a
    add_a_to_hl
    ld a, [wMenuCursor]
    and $07
    add_a_to_hl
    ld a, [hl]
    and $3f
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    bit 7, [hl]
    jr nz, .next
    ld de, wWorkBuf + $a
    ld a, [wMenuPage]
    ld b, a
    add a
    add a
    add e
    ld e, a
    jr nc, .check_menu_cursor
    inc d

.check_menu_cursor:
    ld a, [wMenuCursor]
    and $03
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    cp $fe
    jr z, .skip2
    ld a, [de]
    ld de, wTextBuf0
    call WriteKeyNameToDE
    ld a, $0e
    jr .set_string_index

.skip2:
    ld a, $0d
    jr .set_string_index

.next:
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $3f

.set_string_index:
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    farcall ShowString_Bank09
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

; Builds the key list in wWorkBuf + $A ($20 bytes, filled with $FF first) from the 32 entries of
; wKeyList and returns A = wPauseListCount, Z when the list is empty. Entries whose byte 0 is $FF
; are skipped; entries with byte 3 bit 7 clear are listed as their index, entries with byte 3 bit 7
; set (and byte 0 not 0) as index + $80. With wInventorySortFlags bit 1 clear the bit-7-clear group
; comes first, with it set the bit-7-set group comes first. (C1, E-0369)
BuildScreenBlocks21To23_BuildKeyList::
    ld hl, wWorkBuf + $a
    ld bc, $0020
    ld a, $ff
    call FillBytes
    ld hl, wWorkBuf + $a
    ld de, wKeyList
    ld bc, $2000
    xor a
    ld [wPauseListCount], a
    ld a, [wInventorySortFlags]
    bit 1, a
    jr nz, .loop3

.loop:
    ld a, [de]
    cp $ff
    jr z, .next
    push de
    ld a, e
    add $03
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr nz, .next
    ld [hl], c
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

.next:
    inc c
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, .loop
    ld de, wKeyList
    ld bc, $2000

.loop2:
    ld a, [de]
    or a
    jr z, .next2
    cp $ff
    jr z, .next2
    push de
    ld a, e
    add $03
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr z, .next2
    ld [hl], c
    set 7, [hl]
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

.next2:
    inc c
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, .loop2
    jr .check_pause_list_count

.loop3:
    ld a, [de]
    or a
    jr z, .next3
    cp $ff
    jr z, .next3
    push de
    ld a, e
    add $03
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr z, .next3
    ld [hl], c
    set 7, [hl]
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

.next3:
    inc c
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, .loop3
    ld de, wKeyList
    ld bc, $2000

.loop4:
    ld a, [de]
    cp $ff
    jr z, .next4
    push de
    ld a, e
    add $03
    ld e, a
    ld a, d
    adc $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr nz, .next4
    ld [hl], c
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

.next4:
    inc c
    ld a, e
    add $04
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, .loop4

.check_pause_list_count:
    ld a, [wPauseListCount]
    or a
    ret

; from wPauseListCount items computes wMenuPageCount (4 rows per page, up to 8 pages),
; wMenuLastPageRows and wMenuRowCount for wMenuPage, and draws the page indicator (E-0128)
ComputeMenuPagesForPauseListCountItems::
    ld a, [wPauseListCount]
    or a
    jr z, .skip
    cp $05
    jr c, .skip2
    cp $09
    jr c, .skip3
    cp $0d
    jr c, .skip4
    cp $11
    jr c, .skip5
    cp $15
    jr c, .skip6
    cp $19
    jr c, .skip7
    cp $1d
    jr c, .skip8
    ld b, $08
    sub $1c
    jr .set_menu_last_page_rows

.skip:
    ld b, $00
    jr .set_menu_last_page_rows

.skip2:
    ld b, $01
    jr .set_menu_last_page_rows

.skip3:
    ld b, $02
    sub $04
    jr .set_menu_last_page_rows

.skip4:
    ld b, $03
    sub $08
    jr .set_menu_last_page_rows

.skip5:
    ld b, $04
    sub $0c
    jr .set_menu_last_page_rows

.skip6:
    ld b, $05
    sub $10
    jr .set_menu_last_page_rows

.skip7:
    ld b, $06
    sub $14
    jr .set_menu_last_page_rows

.skip8:
    ld b, $07
    sub $18
    jr .set_menu_last_page_rows

.set_menu_last_page_rows:
    ld [wMenuLastPageRows], a
    ld a, b
    ld [wMenuPageCount], a
    ld a, [wMenuPage]
    inc a
    cp b
    jr nz, .set_menu_row_count_to_04
    ld a, [wMenuLastPageRows]
    jr .set_menu_row_count

.set_menu_row_count_to_04:
    ld a, $04

.set_menu_row_count:
    ld [wMenuRowCount], a
    ld a, [wMenuPageCount]
    cp $02
    ret c
    add $e0
    ld [wWindowTileBuffer + $c9], a
    ld a, [wMenuPage]
    inc a
    add $e0
    ld [wWindowTileBuffer + $c7], a
    ld a, $c5
    ld [wWindowTileBuffer + $c6], a
    ld a, $be
    ld [wWindowTileBuffer + $c8], a
    ld a, $c6
    ld [wWindowTileBuffer + $ca], a
    ret

; shows string 2 of category 0 (ShowString_Bank09) in a window at vTiles1 + $6E0 with size $1003,
; then restores the default window (vTiles1, $1202) (E-0120)
ShowString2Bank09InWindowThenDefault::
    ld hl, vTiles1 + $6e0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1003
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a ; 'RJadlnoprtuxy-fWATUCHPMDcgimhw Dcgimh ★'
    farcall ShowString_Bank09
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

; Counts the stored monsters in SRAM: of the 30 records with state 1, those with byte $6E zero
; (wWorkBuf) and non-zero (wWorkBuf + 1). (C1, E-0357)
PauseMenu_Plan_PlayerRecord_CountMonsters::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    xor a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ld de, sRecords
    ld b, $1e

.loop:
    ld a, [de]
    cp $01
    jr nz, .skip3
    ld hl, $006e
    add hl, de
    ld a, [hl]
    or a
    jr z, .skip
    ld hl, wWorkBuf + $1
    jr .skip2

.skip:
    ld hl, wWorkBuf

.skip2:
    inc [hl]

.skip3:
    ld a, e
    add $a5
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; fills the tiles at vTiles2 + $1E0 (size $0162) through FillTilesFromRequest, preserving the window
; settings wTextWindowTileLo-wTextWindowWidth (E-0121)
FillTiles21E0PreservingWindow::
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles2 + $1e0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    lb hl, $62, $01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
PauseMenu_Plan_Tactics_Build_DrawScreen_TileCopyDestList::
    dw vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90, vTiles2 + $a0, vTiles2 + $b0, rIE ; entry 0

; record: bank-$1F tile sources
PauseMenu_Plan_Tactics_Build_DrawScreen_TileCopySrcList::
    dw $40e0, $4370, $42b0, $42d0, $4310, $42c0, $43b0, $ffff ; entry 0

; copies $10-byte tiles from bank $1F by a list of source and destination words until $FF (E-0305)
PauseMenu_Plan_TileBufferMenu_CopyTileListFromBank1F::
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
    ret

; data read by GameMode2_Update_OpenPage (6 bytes) (E-0347)
GameMode2_Update_OpenPage_Data::
    db $11, $20, $ff, $7f, $7d, $3d
    ds $405, $00
