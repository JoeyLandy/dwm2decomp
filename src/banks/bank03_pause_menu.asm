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
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 2
GameMode2_Update::
    ld a, [wGameMode2State]
    bit 7, a
    jr z, PauseMenu_State4_CheckGameMode2State
    call GameMode2_Update_WriteGM2TimerFramesAndGM2TimerSecondsEtc
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

PauseMenu_State4_CheckGameMode2State::
    ld a, [wGameMode2State]
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
    ld bc, $1412
    call CopyRectToBGMap
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyTileBufferToBGMap
    ld hl, wGameMode2State
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
    call PauseMenu_State4_ReadModeState
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
    jr z, .set_game_mode2_state_to_80
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
    ld de, PauseMenu_State4_Data
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

.set_game_mode2_state_to_80:
    ld a, $80
    ld [wGameMode2State], a
    xor a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1c0
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld de, $0025
    call TestFlagBit
    ret c
    ld de, $019f
    call TestFlagBit
    ret nc
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    ld de, $0025
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

PauseMenu_State4_ReadModeState::
    ld a, [wModeState]
    and $07
    jumptable
    dw PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor
    dw PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage
    dw PauseMenu_State4_Sub01_LoadScreenBlocks1CAnd0C
    dw PauseMenu_State4_Sub01_TestFlagBit
    dw PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage

PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor::
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

PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage::
    call ResetInventoryMenuToFirstPage
    call BuildInventoryScreenBase
    call ShowString0Bank09AtTiles16E0ThenItemDescription
    ret

PauseMenu_State4_Sub01_LoadScreenBlocks1CAnd0C::
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

PauseMenu_State4_Sub01_TestFlagBit::
    ld a, [wModeState]
    bit 3, a
    jr z, .call_load_screen_block21
    ld de, $0025
    call TestFlagBit
    jr c, .set_temp0_to_01
    ld de, $019f
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

; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks)
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
; $1412)
CopyTileBufferToBGMap::
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

; HL = BG map address, DE = source, B = width, C = rows: writes B bytes per row with WriteVRAMByte
; (HL wraps inside its 32-entry row, then the source and destination each move down 32 and HL is
; masked with $9B)
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

WithSRAMDrawMemberRecordByte0D_Sub01_WriteTextWindowTileLoAndTextWindowTileHiEtc::
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
; (UpdateMenuCursor_WaitForVRAMAccess), play sound $69, store the row (clearing bit 7) and draw it
; (UpdateMenuCursor_WaitForVRAMAccess_Sub02). When wMenuPageCount >= 2, Left/Right (bits 5/4) step
; wMenuPage with wrap, clamp the row to wMenuLastPageRows - 1 on the last page, set bit 7 and play
; sound $69. With no input the cursor blinks every 16 frames. wFrameCounterLo is reset on each move
; (E-0060)
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
    jr z, .call_update_menu_cursor_wait_for_vram_access
    push de
    call UpdateMenuCursor_WaitForVRAMAccess
    pop de
    ld a, $69
    call QueueSoundEffect

.call_update_menu_cursor_wait_for_vram_access:
    ld [hl], b
    ld a, b
    call UpdateMenuCursor_WaitForVRAMAccess_Sub02
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
    call UpdateMenuCursor_WaitForVRAMAccess
    pop de
    pop af
    ld [hl], a
    call UpdateMenuCursor_WaitForVRAMAccess_Sub02

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
    jr z, .call_update_menu_cursor_wait_for_vram_access2
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_WaitForVRAMAccess_Sub02
    jr .return

.call_update_menu_cursor_wait_for_vram_access2:
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_WaitForVRAMAccess
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

.return:
    ret

UpdateMenuCursor_WaitForVRAMAccess::
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

UpdateMenuCursor_WaitForVRAMAccess_Sub02::
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

ShowStringBank08AtTilesHL_03_455B::
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

GameMode2_Update_WriteGM2TimerFramesAndGM2TimerSecondsEtc::
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

PauseMenu_Items_MemberList_UpdateMenuCursor_Data::
    db $29, $98, $69, $98, $a9, $98, $e9, $98

PauseMenu_Items_ChooseItem_UpdateMenuCursor_Data::
    db $a1, $98, $e1, $98

PauseMenu_Items_SubMenu_UpdateMenuCursor_Data::
    db $21, $99, $61, $99

PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case0E_Data::
    db $01, $99, $41, $99

PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Data::
    db $47, $99, $87, $99, $c7, $99, $07, $9a

PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case03_Data::
    db $61, $98, $a1, $98

PauseMenu_Plan_TileBufferMenu_UpdateMenuCursor_Data::
    db $4a, $99, $8a, $99, $ca, $99, $0a, $9a

PauseMenu_Plan_PagedMenu_UpdateMenuCursor_Data::
    db $64, $98, $a4, $98, $e4, $98

PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_Data::
    db $2f, $99, $6f, $99

MenuCursorAddressMenuCursor_Data::
    db $82, $99, $84, $99, $86, $99, $88, $99, $8a, $99, $8c, $99, $8e, $99, $90, $99

; runs the routine for wPauseMenuScreen (jump table of four screens) (E-0122)
RunPauseMenuScreen::
    ld a, [wPauseMenuScreen]
    jumptable
    dw RunPauseMenuScreen_SetMenuLastPageRows
    dw RunPauseMenuScreen_AdvancePauseMenuScreen
    dw RunPauseMenuScreen_RunSaveGameSteps_7347
    dw RunPauseMenuScreen_AdvancePauseMenuScreen_Case03

RunPauseMenuScreen_SetMenuLastPageRows::
    ld a, [wCurrentMusic]
    ld [wMenuLastPageRows], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

RunPauseMenuScreen_AdvancePauseMenuScreen::
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

RunPauseMenuScreen_RunSaveGameSteps_7347::
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

RunPauseMenuScreen_AdvancePauseMenuScreen_Case03::
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; GameMode2_Update, wModeState 0: INFO, chosen from the field menu: for each party monster its
; level, sex, personality, species and EXP page, its stats page (ATK, DEF, AGL, INT, WLD, HP, MP)
; and its skills page (C2 from E-0322: in game mode 2 wModeState is the field menu's choice, 0 INFO,
; 1 ITEM, 2 SKILLS, 3 PLAN; E-0046 read PLAN as part of this screen) (was PauseMenu_Main)
PauseMenu_Info::
    ld a, [wDataBankSave]
    or a
    jp nz, PauseMenu_Info_Blocks09And0A_Case01_LoadPartySpeciesSpriteGraphics_ReadTemp1
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Info_Blocks00To03
    dw PauseMenu_Info_Blocks04To06
    dw PauseMenu_Info_Blocks07And08
    dw PauseMenu_Info_Blocks09And0A
    dw PauseMenu_Info_ToExitPauseMenuToField

; builds screen blocks 0-3 (blanked first, with the cursor) and runs the menu cursor
PauseMenu_Info_Blocks00To03::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Blocks00To03_LoadBlankedBlocks00To03WithCursor
    dw PauseMenu_Info_Blocks00To03_LoadScreenBlocks00To03
    dw PauseMenu_Info_Blocks00To03_UpdateMenuCursor
    dw PauseMenu_Info_Blocks00To03_Return

PauseMenu_Info_Blocks00To03_LoadBlankedBlocks00To03WithCursor::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .skip
    call LoadBlankedBlocks00To03WithCursor
    call CopyTileBufferToBGMap

.skip:
    ld hl, wTemp1
    inc [hl]

PauseMenu_Info_Blocks00To03_Return::
    ret

PauseMenu_Info_Blocks00To03_LoadScreenBlocks00To03::
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
    call WithSRAMDraw4ACEAnd4B52
    ld hl, vBGMap0
    ld bc, $1412
    ld de, wScreenTileBuffer
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks00To03_UpdateMenuCursor::
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
PauseMenu_Info_Blocks04To06::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Blocks04To06_LoadBlankedBlocks00And04To06WithCursor
    dw PauseMenu_Info_Blocks04To06_LoadScreenBlocks00And04To06
    dw PauseMenu_Info_Blocks04To06_DrawMetaSpritePartC0

PauseMenu_Info_Blocks04To06_LoadBlankedBlocks00And04To06WithCursor::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .done
    call LoadBlankedBlocks00And04To06WithCursor
    call CopyTileBufferToBGMap

.done:
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks04To06_LoadScreenBlocks00And04To06::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .call_with_sram_draw4_ace_and4_be8
    call LoadScreenBlocks00And04To06

.call_with_sram_draw4_ace_and4_be8:
    call WithSRAMDraw4ACEAnd4BE8
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    call DecompressRecordSpeciesGraphicsToTiles0
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks04To06_DrawMetaSpritePartC0::
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

; builds screen blocks 0, 7 and 8 and runs the menu cursor
PauseMenu_Info_Blocks07And08::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Blocks07And08_LoadBlankedBlocks00_07_08WithCursor
    dw PauseMenu_Info_Blocks07And08_LoadScreenBlocks00_07_08
    dw PauseMenu_Info_Blocks07And08_UpdateMenuCursor

PauseMenu_Info_Blocks07And08_LoadBlankedBlocks00_07_08WithCursor::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .done
    call LoadBlankedBlocks00_07_08WithCursor
    call CopyTileBufferToBGMap

.done:
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks07And08_LoadScreenBlocks00_07_08::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .call_with_sram_show_record_species_and_skill
    call LoadScreenBlocks00_07_08

.call_with_sram_show_record_species_and_skill:
    call WithSRAMShowRecordSpeciesAndSkillNames
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks07And08_UpdateMenuCursor::
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

; builds screen blocks 0, 9 and $0A and runs the menu cursor
PauseMenu_Info_Blocks09And0A::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Blocks09And0A_LoadBlankedBlocks00_09_0AWithCursor
    dw PauseMenu_Info_Blocks09And0A_LoadScreenBlocks00_09_0A
    dw PauseMenu_Info_Blocks09And0A_UpdateMenuCursor

PauseMenu_Info_Blocks09And0A_LoadBlankedBlocks00_09_0AWithCursor::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .done
    call LoadBlankedBlocks00_09_0AWithCursor
    call CopyTileBufferToBGMap

.done:
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks09And0A_LoadScreenBlocks00_09_0A::
    ld a, [wPauseMenuScreen]
    or a
    jr nz, .call_with_sram_draw_member_record_byte0_d
    call LoadScreenBlocks00_09_0A

.call_with_sram_draw_member_record_byte0_d:
    call WithSRAMDrawMemberRecordByte0D
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    call PauseMenu_Info_Blocks09And0A_Case01_LoadPartySpeciesSpriteGraphics
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks09And0A_UpdateMenuCursor::
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

PauseMenu_Info_ToExitPauseMenuToField::
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

; decompresses Tiles1Plus6E0Gfx_16_7B7D (bank $16) to vTiles1 + $6E0, then runs
; DrawRecordMonsterPictureForMenuSelectedMember (E-0122)
DecompressMenuTilesTo16E0::
    ld b, $16
    ld de, Tiles1Plus6E0Gfx_16_7B7D
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
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a

.return:
    ret

; with SRAM bank 0 enabled runs BuildRecordLevelAndStatusRow and
; WithSRAMDraw4ACEAnd4B52_HLToDecimalDigits (E-0122)
WithSRAMDraw4ACEAnd4B52::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call BuildRecordLevelAndStatusRow
    call WithSRAMDraw4ACEAnd4B52_HLToDecimalDigits
    xor a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled runs BuildRecordLevelAndStatusRow and
; WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03 (E-0122)
WithSRAMDraw4ACEAnd4BE8::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call BuildRecordLevelAndStatusRow
    call WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03
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
; it is $FFFF (E-0122, E-0259)
WithSRAMDrawMemberRecordByte0D::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call WithSRAMDrawMemberRecordByte0D_ShowSpeciesNameAndIconForSlotB
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
    call WriteTwoDigitTilesFromWC8C1
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
    call nz, SetWC1C8TileC2
    bit 0, a
    call nz, SetWC1C6TileC0
    bit 2, a
    call nz, SetWC1C7TileC1

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

; wScreenTileBuffer + $30 = $C2; AF kept (E-0119)
SetWC1C8TileC2::
    push af
    ld a, $c2
    ld [wScreenTileBuffer + $30], a
    pop af
    ret

; wScreenTileBuffer + $2E = $C0; AF kept (E-0119)
SetWC1C6TileC0::
    push af
    ld a, $c0
    ld [wScreenTileBuffer + $2e], a
    pop af
    ret

; wScreenTileBuffer + $2F = $C1; AF kept (E-0119)
SetWC1C7TileC1::
    push af
    ld a, $c1
    ld [wScreenTileBuffer + $2f], a
    pop af
    ret

WithSRAMDraw4ACEAnd4B52_HLToDecimalDigits::
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

WithSRAMDraw4ACEAnd4BE8_ShowStringBank08AtTilesHL_Bank03::
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
    call WithSRAMDraw4ACEAnd4BE8_WriteDigitTilesNoLeadingZeros
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
    call WithSRAMDraw4ACEAnd4BE8_WriteDigitTilesNoLeadingZeros
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
    call ShowRecordSpeciesAndSkillNames_WriteStringCategoryAndStringIndex
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

ShowRecordSpeciesAndSkillNames_WriteStringCategoryAndStringIndex::
    cp $ff
    jr nz, ShowSkillNameAtSlotB
    push hl
    ld a, $08
    ld [wStringCategory], a
    ld a, $0e
    ld [wStringIndex], a
    jr ShowSkillNameAtSlotB_Skip

; A = skill number ($FF shows entry 0), B = slot: wStringIndex = A, wStringCategory = 4
; (StringTable_SkillNames in the bank-$08 database), then ShowStringBank08AtTilesHL with the tile
; address from ShowSkillNameAtSlotB_Data[B] and size $0901; HL kept (E-0076)
ShowSkillNameAtSlotB::
    push hl
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a

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

ShowSkillNameAtSlotB_Data::
    db $80, $93, $10, $94, $a0, $94, $30, $95, $c0, $95, $50, $96, $e0, $96, $70, $97

WithSRAMDrawMemberRecordByte0D_ShowSpeciesNameAndIconForSlotB::
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
    call WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0
    ld a, [wMenuLastPageRows]
    xor $01
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0
    ld a, l
    add $5a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wMenuLastPageRows]
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03
    ld a, [wMenuLastPageRows]
    xor $01
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03
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
    call WithSRAMDrawMemberRecordByte0D_Sub01_WriteTextWindowTileLoAndTextWindowTileHiEtc
    ld hl, vTiles2 + $6c0
    call WithSRAMDrawMemberRecordByte0D_Sub01_WriteTextWindowTileLoAndTextWindowTileHiEtc
    ld hl, vTiles2 + $7b0
    call WithSRAMDrawMemberRecordByte0D_Sub01_WriteTextWindowTileLoAndTextWindowTileHiEtc
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

WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0::
    call CopyTenBytesToTextBuf0
    inc hl
    push hl
    push bc
    ld a, b
    ld hl, WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Data
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    ret

WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03::
    call CopyTenBytesToTextBuf0
    push hl
    push bc
    ld a, b
    ld hl, WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03_Data1
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    push hl
    ld a, b
    ld hl, WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03_Data2
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
    ld hl, WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03_Data2
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

ShowSpeciesNameAndIconForSlotB_Data1::
    db $e0, $95, $20, $97

ShowSpeciesNameAndIconForSlotB_Data2::
    db $5d, $71

WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Data::
    db $70, $96, $b0, $97

WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03_Data1::
    db $80, $95, $c0, $96

WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0_Sub03_Data2::
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

PauseMenu_Info_Blocks09And0A_Case01_LoadPartySpeciesSpriteGraphics::
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

PauseMenu_Info_Blocks09And0A_Case01_LoadPartySpeciesSpriteGraphics_ReadTemp1::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Info_Blocks09And0A_Case01_Sub01_WriteVRAMByteInc
    dw PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize
    dw PauseMenu_Info_Blocks09And0A_Case01_Sub01_CopyTileBufferToBGMap
    dw PauseMenu_Info_Blocks09And0A_Case01_Sub01_WaitJoypadPressed
    dw PauseMenu_Info_Blocks09And0A_Case01_Sub01_FillVRAMRowsWithD

PauseMenu_Info_Blocks09And0A_Case01_Sub01_WriteVRAMByteInc::
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

PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize::
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
    ld hl, PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data1
    ld a, c
    add_a_to_hl
    ld a, c
    ld c, [hl]
    ld hl, PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data2
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
    ld hl, PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data1
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    ld a, c
    ld hl, PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data3
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
    call DrawRecordByte0EMarkTile
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
    call WriteTwoDigitTilesFromWC8C1
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
; DrawRecordByte0EMarkTile_Data[C]; BC kept (E-0120)
DrawRecordByte0EMarkTile::
    push bc
    ld a, c
    ld hl, DrawRecordByte0EMarkTile_Data
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

PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data1::
    db $01, $03, $05

PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data2::
    db $40, $91, $80, $93, $c0, $95

PauseMenu_Info_Blocks09And0A_Case01_Sub01_LoadScreenBlockForPartySize_Data3::
    db $00, $00, $80, $00, $00, $01

DrawRecordHPMPAndLevelForRowC_Data::
    db $fa, $c1, $00, $c2, $06, $c2

ShowRecordSpeciesNameForRowC_Data::
    db $00, $88, $90, $88, $20, $89

DrawRecordByte0EMarkTile_Data::
    db $66, $c3, $86, $c3, $a6, $c3

PauseMenu_Info_Blocks09And0A_Case01_Sub01_CopyTileBufferToBGMap::
    call CopyTileBufferToBGMap
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld bc, $0606
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
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wPartyCount]
    cp $02
    jr z, .skip
    ld hl, vBGMap0 + $ed
    ld de, wScreenAttrBuffer + $100
    ld bc, $0606
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

PauseMenu_Info_Blocks09And0A_Case01_Sub01_WaitJoypadPressed::
    ld a, [wJoypadPressed]
    and $04
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Info_Blocks09And0A_Case01_Sub01_FillVRAMRowsWithD::
    ld hl, vBGMap0
    ld bc, $1412
    ld d, $c3
    call FillVRAMRowsWithD
    ld a, [wIsCGB]
    or a
    jr z, .call_write_sixteen_tiles_from5264_at
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $e0
    ld bc, $1406
    ld d, $00
    call FillVRAMRowsWithD
    xor a
    ldh [rVBK], a

.call_write_sixteen_tiles_from5264_at:
    call WriteSixteenTilesFrom5264AtTiles2140
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

; writes the 16 bytes at WriteSixteenTilesFrom5264AtTiles2140_Data to vTiles2 + $140 (E-0122)
WriteSixteenTilesFrom5264AtTiles2140::
    ld de, WriteSixteenTilesFrom5264AtTiles2140_Data
    ld hl, vTiles2 + $140
    ld b, $10

.loop:
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, .loop
    ret

WriteSixteenTilesFrom5264AtTiles2140_Data::
    db $ff, $00, $ff, $10, $ff, $10, $ff, $fe, $ff, $7c, $ff, $38, $ff, $7c, $ff, $c6

; GameMode2_Update, wModeState 1: the ITEM list ('No items' at the start of a game) (E-0046)
PauseMenu_Items::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Items_MemberList
    dw PauseMenu_Items_ChooseItem
    dw PauseMenu_Items_UseItem
    dw PauseMenu_Items_SubMenu

; refreshes the record list and name tiles, then the menu cursor
PauseMenu_Items_MemberList::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_MemberList_RefreshRecordListAndNameTiles
    dw PauseMenu_Items_MemberList_UpdateMenuCursor

PauseMenu_Items_MemberList_RefreshRecordListAndNameTiles::
    ld a, [wLevelUpGains]
    or a
    call nz, RefreshRecordListAndNameTiles
    call SetupInventoryMenuPages_Bank03
    call BuildInventoryScreenBase
    call SetMenuRowsForPage_Bank03_59DB
    call ShowSelectedItemDescription
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_MemberList_UpdateMenuCursor::
    ld a, [wInventory]
    or a
    jr nz, .call_update_menu_cursor
    ld a, [wJoypadPressed]
    jr .check_bit1

.call_update_menu_cursor:
    ld de, PauseMenu_Items_MemberList_UpdateMenuCursor_Data
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
    call SetMenuRowsForPage_Bank03_59DB
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

; by wTemp1: the item list (screen block $0E) with a cursor, before PauseMenu_Items_UseItem
PauseMenu_Items_ChooseItem::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_ChooseItem_BuildScreenBlock0EWithCursorAndStep
    dw PauseMenu_Items_ChooseItem_UpdateMenuCursor

PauseMenu_Items_ChooseItem_BuildScreenBlock0EWithCursorAndStep::
    call BuildScreenBlock0EWithCursor
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_ChooseItem_UpdateMenuCursor::
    ld de, PauseMenu_Items_ChooseItem_UpdateMenuCursor_Data
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
; 'But it couldn't be used') and may leave for the field
PauseMenu_Items_UseItem::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_UseItem_WriteTemp1
    dw PauseMenu_Items_UseItem_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_UseItem_BeginStringDisplay_Bank08AndStep
    dw PauseMenu_Items_UseItem_WaitTextFlags
    dw PauseMenu_Items_UseItem_BuildItemScreenForWItemIdAndStep
    dw PauseMenu_Items_UseItem_UpdateMenuCursor
    dw PauseMenu_Items_UseItem_BuildItemScreenWithRecordCursorAndStep
    dw PauseMenu_Items_UseItem_BeginStringDisplay_Bank37
    dw PauseMenu_Items_UseItem_CheckItemUsable
    dw PauseMenu_Items_UseItem_BeginStringDisplay_Bank37_Case09
    dw PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage
    dw PauseMenu_Items_UseItem_ApplyItemEffect
    dw PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage
    dw PauseMenu_Items_UseItem_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_UseItem_BeginStringDisplay_Bank37
    dw PauseMenu_Items_UseItem_CheckItemUsable
    dw PauseMenu_Items_UseItem_BeginStringDisplay_Bank37_Case09
    dw PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage
    dw PauseMenu_Items_UseItem_ApplyItemEffect
    dw PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage
    dw PauseMenu_Items_UseItem_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_UseItem_BeginStringDisplay_Bank37
    dw PauseMenu_Items_UseItem_CheckItemUsable_Case16
    dw PauseMenu_Items_UseItem_ShowButNothingHappened
    dw PauseMenu_Items_UseItem_WaitTextFlags_Case18
    dw PauseMenu_Items_UseItem_ApplyItemEffect_Case19
    dw PauseMenu_Items_UseItem_ExitPauseMenuToField
    dw PauseMenu_Items_UseItem_ShowButItCouldntBe
    dw PauseMenu_Items_UseItem_LoadScreenBlock2B
    dw PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D
    dw PauseMenu_Items_UseItem_RunPauseMenuScreen
    dw PauseMenu_Items_UseItem_WaitTextFlags_Case1F
    dw PauseMenu_Items_UseItem_ShowYourProgressHasBeen
    dw PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage_Case21

PauseMenu_Items_UseItem_WriteTemp1::
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

PauseMenu_Items_UseItem_BuildScreenBlock0EWithSubMenuCursorAndStep::
    call BuildScreenBlock0EWithSubMenuCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_BeginStringDisplay_Bank08AndStep::
    ld a, $08
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

PauseMenu_Items_UseItem_BuildItemScreenForWItemIdAndStep::
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

PauseMenu_Items_UseItem_UpdateMenuCursor::
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    call DrawItemTargetStatPreview
    ld hl, vBGMap0 + $141
    ld bc, $0903
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

PauseMenu_Items_UseItem_BuildItemScreenWithRecordCursorAndStep::
    call BuildItemScreenWithRecordCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_BeginStringDisplay_Bank37::
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

PauseMenu_Items_UseItem_CheckItemUsable::
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

PauseMenu_Items_UseItem_BeginStringDisplay_Bank37_Case09::
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

PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage::
    ld a, [wTextFlags]
    or a
    ret nz
    call ResetInventoryMenuToFirstPage
    ret

PauseMenu_Items_UseItem_ApplyItemEffect::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a
    ld [rRAMG], a
    ld a, [wItemRecordByte0A]
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

PauseMenu_Items_UseItem_CheckItemUsable_Case16::
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
    ld a, [wItemRecordByte0A]
    or a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_ShowButNothingHappened::
    ld a, $02
    ld [wStringIndex], a ; 'But nothing happened!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_WaitTextFlags_Case18::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

PauseMenu_Items_UseItem_ApplyItemEffect_Case19::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a
    ld [rRAMG], a
    ld a, [wItemRecordByte0A]
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

PauseMenu_Items_UseItem_ExitPauseMenuToField::
    ld a, [wTextFlags]
    or a
    ret nz
    call ExitPauseMenuToField
    ret

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

PauseMenu_Items_UseItem_LoadScreenBlock2B::
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

PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D::
    ld hl, wSubMenuCursor
    ld de, PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and $01
    jr nz, PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_ClearTemp0
    ld a, [wMapType]
    cp $80
    jr nz, .skip
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, .skip
    ld a, [wSpriteSlotCount]
    ld [wItemMenuByte6D], a
    ld a, [wScreenSavedFlag]
    ld [wItemMenuByte6E], a
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

PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_ClearTemp0::
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

PauseMenu_Items_UseItem_RunPauseMenuScreen::
    call RunPauseMenuScreen
    ld a, [wPauseMenuScreen]
    cp $04
    ret nz
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_WaitTextFlags_Case1F::
    ld a, [wTextFlags]
    or a
    ret nz
    jr PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_ClearTemp0

PauseMenu_Items_UseItem_ShowYourProgressHasBeen::
    ld a, $26
    ld [wStringIndex], a ; 'Your progress has been recorded.'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_UseItem_ResetInventoryMenuToFirstPage_Case21::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wMapType]
    cp $80
    jr nz, .call_reset_inventory_menu_to_first_page
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, .call_reset_inventory_menu_to_first_page
    ld a, [wItemMenuByte6D]
    ld [wSpriteSlotCount], a
    ld a, [wItemMenuByte6E]
    ld [wScreenSavedFlag], a

.call_reset_inventory_menu_to_first_page:
    call ResetInventoryMenuToFirstPage
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

; screen blocks $0E and $0F with the sub-menu cursor, strings, and the inventory reset to its first
; page
PauseMenu_Items_SubMenu::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Items_SubMenu_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_SubMenu_BeginStringDisplay_Bank08AndStep
    dw PauseMenu_Items_SubMenu_BuildScreenBlocks0EAnd0FWithCursor
    dw PauseMenu_Items_SubMenu_UpdateMenuCursor
    dw PauseMenu_Items_SubMenu_BeginStringDisplay_Bank08
    dw PauseMenu_Items_SubMenu_ResetInventoryMenuToFirstPage
    dw PauseMenu_Items_SubMenu_ToResetInventoryMenuToFirstPage

PauseMenu_Items_SubMenu_BuildScreenBlock0EWithSubMenuCursorAndStep::
    call BuildScreenBlock0EWithSubMenuCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_SubMenu_BeginStringDisplay_Bank08AndStep::
    ld a, $08
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Items_SubMenu_BuildScreenBlocks0EAnd0FWithCursor::
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

PauseMenu_Items_SubMenu_UpdateMenuCursor::
    ld de, PauseMenu_Items_SubMenu_UpdateMenuCursor_Data
    ld hl, wSubMenuCursor2
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor2]
    and $01
    ld hl, PauseMenu_Items_SubMenu_UpdateMenuCursor_Data
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

PauseMenu_Items_SubMenu_BeginStringDisplay_Bank08::
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

PauseMenu_Items_SubMenu_ResetInventoryMenuToFirstPage::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    call ResetInventoryMenuToFirstPage
    ret

PauseMenu_Items_SubMenu_ToResetInventoryMenuToFirstPage::
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
    ld hl, PauseMenu_Items_MemberList_UpdateMenuCursor_Data
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
    ld hl, PauseMenu_Items_ChooseItem_UpdateMenuCursor_Data
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
    ld hl, PauseMenu_Items_ChooseItem_UpdateMenuCursor_Data
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

; when wMenuPage & $0F = wMenuItemCount - 1 (the last page): wMenuRowCount = wMenuLastPageRows and
; the cursor row wMenuCursor is clamped below it; otherwise wMenuRowCount = 4; then clears bit 7 of
; wMenuPage (E-0064) (the same 44 bytes appear in 3 banks)
SetMenuRowsForPage_Bank03_59DB::
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
    call nz, SetWC2DFTileC2_Bank03_5C16
    bit 2, [hl]
    call nz, SetWC2DFTileC1_Bank03_5C1C
    bit 0, [hl]
    call nz, SetWC2DETileC0_Bank03_5C22

.done:
    xor a
    ld [rRAMG], a
    ret

; wScreenTileBuffer + $147 = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
SetWC2DFTileC2_Bank03_5C16::
    ld a, $c2
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $147 = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
SetWC2DFTileC1_Bank03_5C1C::
    ld a, $c1
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $146 = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
SetWC2DETileC0_Bank03_5C22::
    ld a, $c0
    ld [wScreenTileBuffer + $146], a
    ret

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
PauseMenu_Skills_ChooseMember::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_ChooseMember_RefreshRecordListAndNameTiles
    dw PauseMenu_Skills_ChooseMember_UpdateMenuCursor
    dw PauseMenu_Skills_ChooseMember_BuildScreenBlocks1CAnd0CWithCursorAndStep
    dw PauseMenu_Skills_ChooseMember_ShowADeadMonsterCant
    dw PauseMenu_Skills_ChooseMember_WaitTextFlags

PauseMenu_Skills_ChooseMember_RefreshRecordListAndNameTiles::
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
    call PauseMenu_Skills_ChooseMember_SRAMRecordAddressMapped
    call PauseMenu_Skills_CopyRectToBGMap
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ret

PauseMenu_Skills_ChooseMember_UpdateMenuCursor::
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
    call PauseMenu_Skills_ChooseMember_SRAMRecordAddressMapped
    call PauseMenu_Skills_CopyRectToBGMap
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
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

PauseMenu_Skills_ChooseMember_BuildScreenBlocks1CAnd0CWithCursorAndStep::
    call BuildScreenBlocks1CAnd0CWithCursor
    ld hl, vBGMap0 + $1a0
    ld bc, $1405
    ld de, wWindowTileBuffer + $38
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseMember_ShowADeadMonsterCant::
    ld a, $01
    ld [wStringCategory], a
    ld a, $1a
    ld [wStringIndex], a ; 'A dead monster can't use a'
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseMember_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ret

; by wTemp1: the screen built from the member's record field $5F (MP) with a cursor, then the
; skill's string
PauseMenu_Skills_ChooseSkill::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_ChooseSkill_BuildRecordField5FValueScreen
    dw PauseMenu_Skills_ChooseSkill_UpdateMenuCursor
    dw PauseMenu_Skills_ChooseSkill_BuildRecordField5FValueScreenWithCursorAndStep
    dw PauseMenu_Skills_ChooseSkill_BeginStringDisplay_Bank37AndStep
    dw PauseMenu_Skills_ChooseSkill_WaitTextFlags

PauseMenu_Skills_ChooseSkill_BuildRecordField5FValueScreen::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call BuildRecordField5FValueScreen
    call PauseMenu_Skills_ChooseSkill_SRAMRecordAddressMapped
    ld a, $00
    ld [rRAMG], a
    call PauseMenu_Skills_CopyRectToBGMap
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
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
    call PauseMenu_Skills_ChooseSkill_Case00_WriteMenuPageCountAndMenuItemCountEtc
    ld [wMenuRowCount], a
    call PauseMenu_Skills_CopyRectToBGMap
    call SetMenuRowsForPage_Bank03
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseSkill_UpdateMenuCursor::
    ld de, PauseMenu_Items_MemberList_UpdateMenuCursor_Data
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
    call PauseMenu_Skills_ChooseSkill_SRAMRecordAddressMapped
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $206
    ld bc, $0301
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
    call PauseMenu_Skills_ChooseSkill_SRAMRecordAddressMapped
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
    ld hl, vBGMap0 + $206
    ld bc, $0301
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
    call PauseMenu_Skills_ChooseSkill_Case01_SRAMRecordAddressMapped
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

PauseMenu_Skills_ChooseSkill_BuildRecordField5FValueScreenWithCursorAndStep::
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_CopyRectToBGMap
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseSkill_BeginStringDisplay_Bank37AndStep::
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseSkill_WaitTextFlags::
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
PauseMenu_Skills_ChooseTarget::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_ChooseTarget_BuildRecordField5FValueScreenWithCursor
    dw PauseMenu_Skills_ChooseTarget_CopyTileBufferToBGMap
    dw PauseMenu_Skills_ChooseTarget_UpdateMenuCursor

PauseMenu_Skills_ChooseTarget_BuildRecordField5FValueScreenWithCursor::
    ld a, [wRecordBufferData + $4]
    cp $21
    jr z, .done
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_CopyRectToBGMap
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
    call CopyTileBufferToBGMap
    ld hl, wTemp0
    inc [hl]
    ret

.done:
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseTarget_CopyTileBufferToBGMap::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_ChooseTarget_Case01_ClearScreenTileBuffer_Bank03
    call PauseMenu_Skills_ChooseTarget_HLToDecimalDigits
    ld a, $00
    ld [rRAMG], a
    call PauseMenu_Skills_CopyRectToBGMap
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
    call CopyTileBufferToBGMap
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_ChooseTarget_UpdateMenuCursor::
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
    call PauseMenu_Skills_ChooseTarget_HLToDecimalDigits
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $141
    ld bc, $0703
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
    call PauseMenu_Skills_ChooseTarget_HLToDecimalDigits
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
; the field ('Hero returned with ...', ExitPauseMenuToField)
PauseMenu_Skills_UseFieldSkill::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Skills_UseFieldSkill_CopyTileBufferToBGMap
    dw PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37
    dw PauseMenu_Skills_UseFieldSkill_WaitTextFlags
    dw PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37_Case03
    dw PauseMenu_Skills_UseFieldSkill_WaitTextFlags_Case04
    dw PauseMenu_Skills_UseFieldSkill_SRAMRecordAddressMapped
    dw PauseMenu_Skills_UseFieldSkill_QueueSoundEffect
    dw PauseMenu_Skills_UseFieldSkill_WriteRAMGAndRAMBEtc
    dw PauseMenu_Skills_UseFieldSkill_WaitTextFlags_Case08
    dw PauseMenu_Skills_UseFieldSkill_CopyStringHLToDE
    dw PauseMenu_Skills_UseFieldSkill_ShowHeroReturnedWithAn
    dw PauseMenu_Skills_UseFieldSkill_ExitPauseMenuToField

PauseMenu_Skills_UseFieldSkill_CopyTileBufferToBGMap::
    call PauseMenu_Skills_CopyRectToBGMap
    call PauseMenu_Skills_CopyRectToBGMap_Shared02
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

PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37::
    ld a, [wInventorySlot]
    ld hl, PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37_Data1
    add_a_to_hl
    ld a, [hl]
    cp $ff
    call nz, QueueSoundEffect
    ld a, [wInventorySlot]
    ld hl, PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37_Data2
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_UseFieldSkill_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wSubMenuCursor]
    ld [wTargetRecord], a
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall PauseMenu_Skills_UseFieldSkill_Case02_WriteItemId
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

PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37_Case03::
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

PauseMenu_Skills_UseFieldSkill_WaitTextFlags_Case04::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a
    ld [wMenuPage], a
    ret

PauseMenu_Skills_UseFieldSkill_SRAMRecordAddressMapped::
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

PauseMenu_Skills_UseFieldSkill_QueueSoundEffect::
    ld a, [wInventorySlot]
    ld hl, PauseMenu_Skills_UseFieldSkill_QueueSoundEffect_Data
    add_a_to_hl
    ld a, [hl]
    cp $ff
    call nz, QueueSoundEffect
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Skills_UseFieldSkill_WriteRAMGAndRAMBEtc::
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall PauseMenu_Skills_UseFieldSkill_Case07_WaitItemId
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

PauseMenu_Skills_UseFieldSkill_WaitTextFlags_Case08::
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

PauseMenu_Skills_UseFieldSkill_CopyStringHLToDE::
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

PauseMenu_Skills_UseFieldSkill_ExitPauseMenuToField::
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

PauseMenu_Skills_CopyRectToBGMap::
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
    ld de, TileRect_03_6A98
    ld bc, $0501
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

PauseMenu_Skills_ChooseTarget_Case01_ClearScreenTileBuffer_Bank03::
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
    ld hl, PauseMenu_Items_MemberList_UpdateMenuCursor_Data
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
    ld hl, TileRectTable_03_6921
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
    ld hl, PauseMenu_Items_MemberList_UpdateMenuCursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills the screen tile buffer: blocks $20 and $0C, cursor marks for wMenuCursor and wSubMenuCursor,
; the rectangle chosen by the skill wRecordBuffer (table $6851 to TileRectTable_03_6921), then block
; $10 (E-0121)
BuildSkillScreenTileBuffer::
    call FillTilesFromRequest
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0c
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_Items_MemberList_UpdateMenuCursor_Data
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
    ld hl, TileRectTable_03_6921
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

PauseMenu_Skills_ChooseSkill_SRAMRecordAddressMapped::
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

PauseMenu_Skills_ChooseTarget_HLToDecimalDigits::
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
    call nz, SetWC2DFTileC2_Bank03
    bit 2, [hl]
    call nz, SetWC2DFTileC1_Bank03
    bit 0, [hl]
    call nz, SetWC2DETileC0_Bank03
    ret

; wScreenTileBuffer + $147 = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
SetWC2DFTileC2_Bank03::
    ld a, $c2
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $147 = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
SetWC2DFTileC1_Bank03::
    ld a, $c1
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $146 = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
SetWC2DETileC0_Bank03::
    ld a, $c0
    ld [wScreenTileBuffer + $146], a
    ret

PauseMenu_Skills_ChooseSkill_Case01_SRAMRecordAddressMapped::
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
TileRectTable_03_6921::
    dw TileRect_03_6925 ; id 0
    dw TileRect_03_6956 ; id 1

; a tile-rectangle record for CopyRecordRectToScreenBuffer (E-0161)
; record: offset $0120 (row 9, column 0); 9 x 5 tiles
TileRect_03_6925::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $09, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f3, $f4, $ed, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

TileRect_03_6956::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $09, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f5, $f6, $ed, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37_Data1::
    db $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $7a, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff

PauseMenu_Skills_UseFieldSkill_QueueSoundEffect_Data::
    db $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff

PauseMenu_Skills_UseFieldSkill_BeginStringDisplay_Bank37_Data2::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $00
    db $03, $04, $05, $00

PauseMenu_Skills_ChooseMember_SRAMRecordAddressMapped::
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

PauseMenu_Skills_ChooseSkill_Case00_WriteMenuPageCountAndMenuItemCountEtc::
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

PauseMenu_Skills_CopyRectToBGMap_Shared02::
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
    ld de, TileRect_03_6A98
    ld bc, $0501
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
TileRect_03_6A98::
    db $b4, $b4, $b4, $b4, $b4 ; id 0

; GameMode2_Update, wModeState 3: PLAN, chosen from the field menu: Keys, Plan, Text Speed,
; Re-Order, Info, Journal (C2 from E-0322; E-0046 read it as an item list screen) (was
; PauseMenu_State3)
PauseMenu_Plan::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_Plan_Block21Menu
    dw PauseMenu_Plan_ChooseListEntry
    dw PauseMenu_Plan_TileBufferMenu
    dw PauseMenu_Plan_Blocks21And2C
    dw PauseMenu_Plan_PagedMenu
    dw PauseMenu_Plan_Block2DNumber
    dw PauseMenu_Plan_RecordJourney

; screen block $21, the menu cursor, a rectangle and a text wait
PauseMenu_Plan_Block21Menu::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Block21Menu_LoadScreenBlock21
    dw PauseMenu_Plan_Block21Menu_UpdateMenuCursor
    dw PauseMenu_Plan_Block21Menu_CopyRectToBGMap
    dw PauseMenu_Plan_Block21Menu_WaitTextFlags

PauseMenu_Plan_Block21Menu_LoadScreenBlock21::
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

PauseMenu_Plan_Block21Menu_UpdateMenuCursor::
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

PauseMenu_Plan_Block21Menu_CopyRectToBGMap::
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRectToBGMap
    ld a, $08
    ld [wStringCategory], a
    ld a, $0d
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_Block21Menu_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ret

; far-calls SaveForbiddenHere and sets Z from its result C: Z when saving is allowed; PLAN's Journal
; (the save) shows 'You can't save here.' otherwise (C2 from E-0322) (was Bank16Func4645ResultTest)
TestSaveForbiddenHere::
    farcall SaveForbiddenHere
    ld a, c
    or a
    ret

; by wTemp1: menu rows and pages, a list-entry bit-7 test, strings, and an exit to the field
PauseMenu_Plan_ChooseListEntry::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To23
    dw PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor
    dw PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To24
    dw PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case03
    dw PauseMenu_Plan_ChooseListEntry_CallChooseListEntry_BuildScreenBlocks21To24
    dw PauseMenu_Plan_ChooseListEntry_TestListEntryBit7
    dw PauseMenu_Plan_ChooseListEntry_ExitPauseMenuToField
    dw PauseMenu_Plan_ChooseListEntry_CallChooseListEntry_BuildScreenBlocks21To24_Case07
    dw PauseMenu_Plan_ChooseListEntry_BeginStringDisplay_Bank08AndStep
    dw PauseMenu_Plan_ChooseListEntry_WaitTextFlags
    dw PauseMenu_Plan_ChooseListEntry_WriteMenuRowCountAndMenuPageCount
    dw PauseMenu_Plan_ChooseListEntry_BeginStringDisplay_Bank08AndStep_Case0B
    dw PauseMenu_Plan_ChooseListEntry_WaitTextFlags_Case0C
    dw PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To25WithCursor
    dw PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case0E
    dw PauseMenu_Plan_ChooseListEntry_BeginStringDisplay_Bank08AndStep_Case0F
    dw PauseMenu_Plan_ChooseListEntry_TestListEntryBit7_Case10

PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To23::
    ld hl, vTiles2 + $710
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $720
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $730
    ld de, Tiles2Plus710Tiles_1F_4910
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
    call PauseMenu_Plan_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc
    call PauseMenu_Plan_ChooseListEntry_WaitPauseListCount
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor::
    ld a, [wPauseListCount]
    or a
    jr z, .check_joypad_pressed2
    ld hl, wMenuCursor
    ld de, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    and $04
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    ld a, [wGameFlags836]
    bit 7, a
    jr nz, .set_game_flags836
    xor $02

.set_game_flags836:
    res 7, a
    ld [wGameFlags836], a
    xor a
    ld [wTemp1], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat2
    call PauseMenu_Plan_ChooseListEntry_WaitPauseListCount
    ret

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_joypad_pressed
    ld a, [wMenuPageCount]
    cp $02
    ret c
    call PauseMenu_Plan_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc
    call PauseMenu_Plan_ChooseListEntry_WaitPauseListCount
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
    ld hl, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Data
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

PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To24::
    call BuildScreenBlocks21To24
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $0709
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

PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case03::
    ld hl, wSubMenuCursor
    ld de, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case03_Data
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

PauseMenu_Plan_ChooseListEntry_CallChooseListEntry_BuildScreenBlocks21To24::
    call PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To24_Shared01
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_TestListEntryBit7::
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

PauseMenu_Plan_ChooseListEntry_ExitPauseMenuToField::
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

PauseMenu_Plan_ChooseListEntry_CallChooseListEntry_BuildScreenBlocks21To24_Case07::
    call PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To24_Shared01
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_BeginStringDisplay_Bank08AndStep::
    ld a, $08
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp1], a
    ret

PauseMenu_Plan_ChooseListEntry_WriteMenuRowCountAndMenuPageCount::
    call PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To24_Shared01
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_BeginStringDisplay_Bank08AndStep_Case0B::
    ld a, $08
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_WaitTextFlags_Case0C::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To25WithCursor::
    call BuildScreenBlocks21To25WithCursor
    ld hl, vBGMap0 + $e0
    ld de, wScreenTileBuffer + $e0
    ld bc, $0605
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

PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case0E::
    ld hl, wSubMenuCursor2
    ld de, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case0E_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor2]
    and $01
    ld hl, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case0E_Data
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
    ld bc, $0609
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRectToBGMap
    call PauseMenu_Plan_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a
    ld [wSubMenuCursor], a
    ld a, $03
    ld [wTemp1], a
    ret

PauseMenu_Plan_ChooseListEntry_BeginStringDisplay_Bank08AndStep_Case0F::
    ld a, $04
    ld [wStringIndex], a
    ld a, $08
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_ChooseListEntry_TestListEntryBit7_Case10::
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

; copies the tile buffer and a rectangle, then the menu cursor
PauseMenu_Plan_TileBufferMenu::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_TileBufferMenu_CopyTileBufferToBGMapAndStep
    dw PauseMenu_Plan_TileBufferMenu_CopyRectToBGMap
    dw PauseMenu_Plan_TileBufferMenu_UpdateMenuCursor

PauseMenu_Plan_TileBufferMenu_CopyTileBufferToBGMapAndStep::
    xor a
    ld [wPauseMenuStep], a
    call PauseMenu_Plan_TileBufferMenu_Case00_LoadScreenBlock21WithCursor
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

PauseMenu_Plan_TileBufferMenu_CopyRectToBGMap::
    ld a, [wPauseMenuStep]
    ld hl, PauseMenu_Plan_TileBufferMenu_CopyRectToBGMap_Data
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
    ld bc, $090a
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

PauseMenu_Plan_TileBufferMenu_UpdateMenuCursor::
    ld hl, wMenuCursor
    ld de, PauseMenu_Plan_TileBufferMenu_UpdateMenuCursor_Data
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

PauseMenu_Plan_TileBufferMenu_CopyRectToBGMap_Data::
    db $d0, $d5, $da

; screen block $21 with the cursor and block $2C, then a sound
PauseMenu_Plan_Blocks21And2C::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Blocks21And2C_LoadScreenBlock21CursorAnd2CAndStep
    dw PauseMenu_Plan_Blocks21And2C_QueueSoundEffect

PauseMenu_Plan_Blocks21And2C_LoadScreenBlock21CursorAnd2CAndStep::
    call LoadScreenBlock21CursorAnd2C
    call CopyTileBufferToBGMap
    ld a, [wBattleTextSpeed]
    ld [wMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_Blocks21And2C_QueueSoundEffect::
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

; sets the page count, the cursor and screen block $21
PauseMenu_Plan_PagedMenu::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_PagedMenu_WriteWorkBufAndMenuPageCountEtc
    dw PauseMenu_Plan_PagedMenu_WriteMenuCursor
    dw PauseMenu_Plan_PagedMenu_UpdateMenuCursor
    dw PauseMenu_Plan_PagedMenu_LoadScreenBlock21AndStep
    dw PauseMenu_Plan_PagedMenu_WriteTemp0AndTemp1
    dw PauseMenu_Plan_PagedMenu_CopyTileBufferToBGMap

PauseMenu_Plan_PagedMenu_WriteWorkBufAndMenuPageCountEtc::
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
    call PauseMenu_Plan_PagedMenu_LoadScreenBlock21WithCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_PagedMenu_WriteMenuCursor::
    call PauseMenu_Plan_PagedMenu_LoadScreenBlock28
    xor a
    ld [wMenuCursor], a
    call PauseMenu_Plan_PagedMenu_ShowStringBank08AtTilesHL_Bank03
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_PagedMenu_UpdateMenuCursor::
    ld hl, wMenuCursor
    ld de, PauseMenu_Plan_PagedMenu_UpdateMenuCursor_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed
    call PauseMenu_Plan_PagedMenu_ShowStringBank08AtTilesHL_Bank03
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
    call PauseMenu_Plan_PagedMenu_WriteWorkBuf
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
    jr nz, PauseMenu_Plan_PagedMenu_Case05_WritePauseMenuStep
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

PauseMenu_Plan_PagedMenu_Case05_WritePauseMenuStep::
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
    call PauseMenu_Plan_PagedMenu_WriteWorkBuf
    ld hl, wTemp1
    dec [hl]
    ret

PauseMenu_Plan_PagedMenu_LoadScreenBlock21AndStep::
    call LoadScreenBlock21
    ld a, [wMenuSelectedMember]
    and $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    call PauseMenu_Plan_PagedMenu_LoadScreenBlock28
    ld de, wScreenTileBuffer + $128
    ld hl, vBGMap0 + $128
    ld bc, $0c09
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_PagedMenu_WriteTemp0AndTemp1::
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    call PauseMenu_Plan_PagedMenu_Case04_WritePartyList
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

PauseMenu_Plan_PagedMenu_CopyTileBufferToBGMap::
    call PauseMenu_Plan_PagedMenu_LoadScreenBlock21WithCursor
    call PauseMenu_Plan_PagedMenu_Case05_WritePauseMenuStep
    call PauseMenu_Plan_PagedMenu_LoadScreenBlock28
    xor a
    ld [wMenuCursor], a
    call PauseMenu_Plan_PagedMenu_ShowStringBank08AtTilesHL_Bank03
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    dec [hl]
    ld hl, wTemp1
    dec [hl]
    ret

PauseMenu_Plan_PagedMenu_Case04_WritePartyList::
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

PauseMenu_Plan_PagedMenu_LoadScreenBlock28::
    call LoadScreenBlock28
    ld a, [wWorkBuf + $2]
    inc a
    ld [wMenuRowCount], a
    ld de, wScreenTileBuffer + $63
    ld a, [wWorkBuf + $3]
    call PauseMenu_Plan_PagedMenu_Shared01_CpFF
    ld de, wScreenTileBuffer + $a3
    ld a, [wWorkBuf + $4]
    call PauseMenu_Plan_PagedMenu_Shared01_CpFF
    ld de, wScreenTileBuffer + $e3
    ld a, [wWorkBuf + $5]
    call PauseMenu_Plan_PagedMenu_Shared01_CpFF
    ld de, wScreenTileBuffer + $6c
    ld a, [wWorkBuf + $6]
    ld b, $e1
    call PauseMenu_Plan_PagedMenu_Shared01_CpFF_Sub02
    ld de, wScreenTileBuffer + $ac
    ld a, [wWorkBuf + $7]
    ld b, $e2
    call PauseMenu_Plan_PagedMenu_Shared01_CpFF_Sub02
    ld de, wScreenTileBuffer + $ec
    ld a, [wWorkBuf + $8]
    ld b, $e3
    call PauseMenu_Plan_PagedMenu_Shared01_CpFF_Sub02
    ld de, wScreenTileBuffer + $63
    ld hl, vBGMap0 + $63
    ld bc, $1005
    call CopyRectToBGMap
    ret

PauseMenu_Plan_PagedMenu_LoadScreenBlock28_Next::
    inc de
    inc de

; writes five consecutive tile numbers, starting at the table byte for A, at DE
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

PauseMenu_Plan_PagedMenu_Shared01_CpFF::
    cp $ff
    ret z
    push af
    add $e1
    ld [de], a
    pop af
    jr PauseMenu_Plan_PagedMenu_LoadScreenBlock28_Next

PauseMenu_Plan_PagedMenu_Shared01_CpFF_Sub02::
    cp $ff
    ret z
    push af
    ld a, b
    ld [de], a
    pop af
    jr PauseMenu_Plan_PagedMenu_LoadScreenBlock28_Next

PauseMenu_Plan_PagedMenu_ShowStringBank08AtTilesHL_Bank03::
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
    call WriteTwoDigitTilesFromWC8C1
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
    ld bc, $0a07
    call CopyRectToBGMap
    ret

PauseMenu_Plan_PagedMenu_WriteWorkBuf::
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

PauseMenu_Plan_PagedMenu_WriteFiveTileRun_Data::
    db $d0, $d5, $da

; screen block $2D and a decimal number
PauseMenu_Plan_Block2DNumber::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_Block2DNumber_LoadScreenBlock2D
    dw PauseMenu_Plan_Block2DNumber_ByteAToDecimalDigits

PauseMenu_Plan_Block2DNumber_LoadScreenBlock2D::
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
    call WriteTwoDigitTilesWC8C1NoBlank_Bank03
    call PauseMenu_Plan_Block2DNumber_Case00_WriteRAMGAndRAMBEtc
    ld a, [wWorkBuf]
    ld de, wScreenTileBuffer + $ab
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $1]
    ld de, wScreenTileBuffer + $b1
    call WriteByteAAsTwoDigitTiles
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    ld de, wScreenTileBuffer + $eb
    call WriteByteAAsTwoDigitTiles
    farcall CountSpeciesPerFamilyFlaggedOrListed
    ld a, [wWorkBuf]
    ld de, wWindowTileBuffer + $1b
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $1]
    ld de, wWindowTileBuffer + $1f
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $2]
    ld de, wWindowTileBuffer + $23
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $3]
    ld de, wWindowTileBuffer + $27
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $4]
    ld de, wWindowTileBuffer + $5b
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $5]
    ld de, wWindowTileBuffer + $5f
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $6]
    ld de, wWindowTileBuffer + $63
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $7]
    ld de, wWindowTileBuffer + $67
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $8]
    ld de, wWindowTileBuffer + $9b
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $9]
    ld de, wWindowTileBuffer + $9f
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $a]
    ld de, wWindowTileBuffer + $a3
    call WriteByteAAsTwoDigitTiles
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

PauseMenu_Plan_Block2DNumber_ByteAToDecimalDigits::
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
    call WriteTwoDigitTilesWC8C1NoBlank_Bank03
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $68
    call WriteThreeDigitTilesDigits_Bank03
    ld de, wScreenTileBuffer + $68
    ld hl, vBGMap0 + $68
    ld bc, $0601
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

; ByteAToDecimalDigits, then WriteTwoDigitTilesFromWC8C1 at DE (leading zero blank); DE kept across
; the conversion (E-0114)
WriteByteAAsTwoDigitTiles::
    push de
    call ByteAToDecimalDigits
    pop de
    call WriteTwoDigitTilesFromWC8C1
    ret

; writes wDigits as a digit tile at DE and falls into WriteTwoDigitTilesWC8C1NoBlank_Bank03 (E-0126)
WriteThreeDigitTilesDigits_Bank03::
    ld hl, wDigits
    ld a, [hl]
    add $e0
    ld [de], a
    inc de

; writes wDigits + $1 and wDigits + $2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank)
; (E-0117) (the same 13 bytes appear in 2 banks)
WriteTwoDigitTilesWC8C1NoBlank_Bank03::
    ld hl, wDigits + $1
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ld a, [hl]
    add $e0
    ld [de], a
    ret

; by wTemp1: 'Want to record your journey?', then 'Your progress has been recorded.'
PauseMenu_Plan_RecordJourney::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_Plan_RecordJourney_ShowMaster
    dw PauseMenu_Plan_RecordJourney_LoadScreenBlock2B
    dw PauseMenu_Plan_RecordJourney_UpdateMenuCursor
    dw PauseMenu_Plan_RecordJourney_RunPauseMenuScreen
    dw PauseMenu_Plan_RecordJourney_ShowYourProgressHasBeen
    dw PauseMenu_Plan_RecordJourney_WriteTemp0AndTemp1
    dw PauseMenu_Plan_RecordJourney_RestartGame

PauseMenu_Plan_RecordJourney_ShowMaster::
    xor a
    ldh [hSpriteWindowClipMode], a
    call PauseMenu_Plan_RecordJourney_Case00_CopyBlockToTileBuffer
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
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_RecordJourney_LoadScreenBlock2B::
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    ld a, [wTextFlags]
    or a
    ret nz
    ld de, Tiles1Plus6F0Tiles_1F_4330
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

PauseMenu_Plan_RecordJourney_UpdateMenuCursor::
    ld hl, wSubMenuCursor
    ld de, PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_Data
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and $01
    ld hl, PauseMenu_Items_UseItem_UpdateMenuCursor_Case1D_Data
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wSubMenuCursor]
    and $01
    jr nz, .loop
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    xor a
    ld [wPauseMenuScreen], a
    ld hl, wTemp1
    inc [hl]
    ret

.loop:
    ld a, [wModeState]
    bit 3, a
    jr nz, PauseMenu_Plan_RecordJourney_RestartGame_Skip
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    jr nz, .loop
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    ret

PauseMenu_Plan_RecordJourney_RunPauseMenuScreen::
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    call RunPauseMenuScreen
    ld a, [wPauseMenuScreen]
    cp $04
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_RecordJourney_ShowYourProgressHasBeen::
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    ld a, $00
    ld [wStringCategory], a
    ld a, $26
    ld [wStringIndex], a ; 'Your progress has been recorded.'
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

PauseMenu_Plan_RecordJourney_WriteTemp0AndTemp1::
    ld a, [wTextFlags]
    or a
    jr z, .check_mode_state
    call PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc
    ret

.check_mode_state:
    ld a, [wModeState]
    bit 3, a
    jr nz, PauseMenu_Plan_RecordJourney_RestartGame_Skip
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; jumps to BootAndMainLoop (restarts the game)
PauseMenu_Plan_RecordJourney_RestartGame::
    jp BootAndMainLoop_CallDisableVBlankTimerSerialJoypadInterrupts

PauseMenu_Plan_RecordJourney_RestartGame_Skip::
    ld bc, $0240
    ld hl, wScreenTileBuffer
    ld a, $c3
    call FillBytes
    call CopyTileBufferToBGMap
    ld a, $06
    ld [wTemp1], a
    ret

PauseMenu_Plan_RecordJourney_WriteRAMGAndRAMBEtc::
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wBattlerRecords]
    or a
    jr z, .skip
    ld a, [wTitleByte0A]
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
; BuildScreenBlocks21To23_FillBytes returns NZ, then runs ComputeMenuPagesForPauseListCountItems
; (E-0122)
BuildScreenBlocks21To23::
    call LoadScreenBlock21WithCursor
    ld e, $23
    farcall CopyBlockToTileBuffer
    call BuildScreenBlocks21To23_FillBytes
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

PauseMenu_Plan_ChooseListEntry_BuildScreenBlocks21To24_Shared01::
    call BuildScreenBlocks21To24
    call FillTilesFromRequest
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $07
    ld hl, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case03_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld hl, vBGMap0 + $80
    ld de, wScreenTileBuffer + $80
    ld bc, $0609
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRectToBGMap
    ret

; builds blocks $21-$24, draws the cursor for wSubMenuCursor & 7 and copies blocks $25 and $10
; (E-0122)
BuildScreenBlocks21To25WithCursor::
    call BuildScreenBlocks21To24
    ld a, [wSubMenuCursor]
    and $07
    ld hl, PauseMenu_Plan_ChooseListEntry_UpdateMenuCursor_Case03_Data
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $25
    farcall CopyBlockToTileBuffer
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

PauseMenu_Plan_TileBufferMenu_Case00_LoadScreenBlock21WithCursor::
    call LoadScreenBlock21WithCursor
    ld hl, TileCopyDestList_03_7B9F
    ld de, TileCopySrcList_03_7BAF
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

PauseMenu_Plan_PagedMenu_LoadScreenBlock21WithCursor::
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

PauseMenu_Plan_RecordJourney_Case00_CopyBlockToTileBuffer::
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

PauseMenu_Plan_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc::
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
    ld hl, PauseMenu_Plan_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc_Data
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

; reads the key entry byte for A (bit flags) and writes a mark tile for list row C
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

PauseMenu_Plan_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc_Data::
    db $40, $94, $00, $95, $c0, $95, $80, $96, $40, $97

PauseMenu_Plan_ChooseListEntry_DrawKeyEntryMark_Data::
    db $46, $99, $86, $99, $c6, $99, $06, $9a

PauseMenu_Plan_ChooseListEntry_WaitPauseListCount::
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

BuildScreenBlocks21To23_FillBytes::
    ld hl, wWorkBuf + $a
    ld bc, $0020
    ld a, $ff
    call FillBytes
    ld hl, wWorkBuf + $a
    ld de, wKeyList
    ld bc, $2000
    xor a
    ld [wPauseListCount], a
    ld a, [wGameFlags836]
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

PauseMenu_Plan_Block2DNumber_Case00_WriteRAMGAndRAMBEtc::
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
    ld hl, $6201
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
TileCopyDestList_03_7B9F::
    dw vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90, vTiles2 + $a0, vTiles2 + $b0, rIE ; entry 0

; record: bank-$1F tile sources
TileCopySrcList_03_7BAF::
    dw $40e0, $4370, $42b0, $42d0, $4310, $42c0, $43b0, $ffff ; entry 0

; copies $10-byte tiles from bank $1F by a list of source and destination words until $FF
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

PauseMenu_State4_Data::
    db $11, $20, $ff, $7f, $7d, $3d
    ds $405, $00
