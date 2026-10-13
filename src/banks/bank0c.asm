SECTION "Bank 0C", ROMX[$4000], BANK[$0C]
    db $0C

; implements script command type F6 (SCRIPT_LIBRARY): the monster library: 'Welcome to the library. Which family will you check?' (mode 9, bank $0B strings); reached through ScriptCommandF6 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF6)
; reads: wScreenState
LibraryMenu::
Func_00C_4001:: ; address name
    ld a, [wScreenState]
    rst $00
    dw LibraryMenu_WriteMessageModeAndScreenStateEtc
    dw LibraryMenu_WriteScrollYAndScrollXEtc
    dw LibraryMenu_ToClearStringWindowAt2020AndStep
    dw LibraryMenu_CopyRectTo20ByteRows_Bank0C
    dw LibraryMenu_BGMapAddressAtScroll_Bank0C
    dw LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc
    dw LibraryMenu_LoadMapHeader
    dw LibraryMenu_CopyBytesDEToHL_Bank0C
    dw LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C_Case08
    dw LibraryMenu_ToClearStringWindowAt2200AndStep
    dw LibraryMenu_GridIndexFromGridCursorXGridCursorY
    dw LibraryMenu_WriteScreenState
    dw LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C
    dw LibraryMenu_CopyRectTo20ByteRows_Bank0C_Case0D
    dw LibraryMenu_StoreBAtWordTableEntry_Bank0C
    dw LibraryMenu_WriteScreenState_Case0F
    dw LibraryMenu_ShowMonsterEntry

; entry 0 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wMessageMode, wScreenState, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
LibraryMenu_WriteMessageModeAndScreenStateEtc::
Jump_00C_4027:: ; address name
    ld hl, wScreenState
    ld bc, $0020

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $09
    ld [wMessageMode], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: hSpriteWindowClipMode, hSpriteHideTile, rSTAT, wScreenState
; writes: hScrollY, hScrollX, wScreenByte99, wScreenByte9A, hSpriteHideTile, hSpriteWindowClipMode, hFieldDrawFlags, wScreenState
LibraryMenu_WriteScrollYAndScrollXEtc::
Jump_00C_404A:: ; address name
    call LibraryMenu_FillTileRectWithArg1Tile
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hSpriteWindowClipMode]
    ld [wScreenByte99], a
    ldh a, [hSpriteHideTile]
    ld [wScreenByte9A], a
    ld a, $90
    ldh [hSpriteHideTile], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a
    ld a, $0F
    ldh [hFieldDrawFlags], a
    ld hl, vTiles0
    ld bc, $0800

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    call LibraryMenu_WriteSVBK
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
LibraryMenu_ToClearStringWindowAt2020AndStep::
Jump_00C_4087:: ; address name
    call ClearStringWindowAt2020
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 3 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wGridCursorX, wScreenState
; writes: wWindowTileBuffer, wScreenState
LibraryMenu_CopyRectTo20ByteRows_Bank0C::
Jump_00C_4092:: ; address name
    ld de, TileRect_0C_56D9
    ld hl, wWindowTileBuffer + $64
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGridCursorY]
    and a, a
    jr z, .read_grid_cursor_x
    ld a, $C3
    ld [wWindowTileBuffer + $145], a

.read_grid_cursor_x:
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_CopyRectTo20ByteRows_Bank0C_Data
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_CopyRectTo20ByteRows_Bank0C_Data
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call LibraryMenu_WriteWorkBuf
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 4 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wArg5, wScreenState
; writes: wArg1, wArg2, wArg3, wArg4, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
; points at: wMonsterLibraryBuf, wScreenCountPlusOne
LibraryMenu_BGMapAddressAtScroll_Bank0C::
Jump_00C_40E6:: ; address name
    call BGMapAddressAtScroll_Bank0C
    ld de, $0182
    add hl, de
    ld a, [wGridCursorY]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    ld c, $00

.loop:
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, c
    add a, b
    add a, a
    ld hl, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_5916
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $00

.loop2:
    ld a, d
    cp a, $FF
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
    cp a, $FF
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
    and a, a
    jr z, .restore3
    jr .restore

.restore3:
    pop bc
    pop de
    inc de
    ld a, [wGridCursorY]
    add a, a
    ld l, a
    add a, a
    add a, l
    ld l, a
    ld a, c
    add a, l
    add a, a
    ld hl, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_592E
    add_a_to_hl
    push de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld a, d
    cp a, h
    jr c, .loop2
    jr nz, .read_grid_cursor_y
    ld a, e
    cp a, l
    jr c, .loop2

.read_grid_cursor_y:
    push bc
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    pop bc
    ld a, c
    add_a_to_hl
    ld a, b
    ld [hl], a
    ld a, [wGridCursorY]
    and a, a
    jr z, .skip
    ld b, $05
    jr .next

.skip:
    ld b, $06

.next:
    inc c
    ld a, c
    cp a, b
    jp c, .loop

.clear_arg1:
    xor a, a
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

; entry 5 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenState, wGridCursorY, wGridCursorX
; writes: wScreenState, wTwoChoiceCursor, hSpriteWindowClipMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest, wWindowTileBuffer, wGridCursorX, ...
; points at: wScreenCountPlusOne
LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc::
Jump_00C_41D7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .check_grid_cursor_y
    bit 5, a
    jr nz, .check_grid_cursor_y2
    bit 6, a
    jr nz, .call_library_menu_case05_read_grid_cursor_x2
    bit 7, a
    jr nz, .call_library_menu_case05_read_grid_cursor_x3
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .read_grid_cursor_y
    bit 1, a
    jp nz, .check_screen_state
    call LibraryMenu_Case05_WriteGlyphListStart
    ret

.check_grid_cursor_y:
    ld a, [wGridCursorY]
    cp a, $01
    jr c, .set_grid_cursor_y
    xor a, a
    jr .set_grid_cursor_y2

.set_grid_cursor_y:
    inc a

.set_grid_cursor_y2:
    ld [wGridCursorY], a
    cp a, $01
    jr c, .call_library_menu_case05_read_grid_cursor_x
    ld a, [wGridCursorX]
    cp a, $05
    jr c, .call_library_menu_case05_read_grid_cursor_x
    dec a
    ld [wGridCursorX], a

.call_library_menu_case05_read_grid_cursor_x:
    call LibraryMenu_Case05_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    sub a, $03
    ld [wScreenState], a
    ret

.check_grid_cursor_y2:
    ld a, [wGridCursorY]
    and a, a
    jr nz, .skip
    ld a, $01
    jr .set_grid_cursor_y2

.skip:
    dec a
    jr .set_grid_cursor_y2

.call_library_menu_case05_read_grid_cursor_x2:
    call LibraryMenu_Case05_ReadGridCursorX_Sub03
    ld a, [wGridCursorY]
    ld de, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Data
    add a, e
    ld e, a
    jr nc, .check_grid_cursor_x
    inc d

.check_grid_cursor_x:
    ld a, [de]
    ld b, a
    ld a, [wGridCursorX]
    and a, a
    jr nz, .set_grid_cursor_x
    ld a, b
    jr .set_grid_cursor_x2

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    call LibraryMenu_Case05_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_library_menu_case05_read_grid_cursor_x3:
    call LibraryMenu_Case05_ReadGridCursorX_Sub03
    ld a, [wGridCursorY]
    ld de, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Data
    add a, e
    ld e, a
    jr nc, .check_grid_cursor_x2
    inc d

.check_grid_cursor_x2:
    ld a, [de]
    ld b, a
    ld a, [wGridCursorX]
    cp a, b
    jr c, .skip2
    xor a, a
    jr .set_grid_cursor_x2

.skip2:
    inc a
    jr .set_grid_cursor_x2

.read_grid_cursor_y:
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGridCursorX]
    add a, b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, .call_queue_sound_effect
    call LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_CopyRectTo20ByteRows_Bank0C_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wGridCursorY]
    add a, $E1
    ld [wWindowTileBuffer + $156], a
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

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    xor a, a
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from LibraryMenu_Case05 (E-0047)
; 1 call site from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc)
; reads: wJoypadRepeatTimer, wGlyphListStart, wGridCursorX
; writes: wGlyphListStart
LibraryMenu_Case05_WriteGlyphListStart::
Func_00C_42F0:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, LibraryMenu_Case05_ReadGridCursorX
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    cp a, $10
    jr c, LibraryMenu_Case05_ReadGridCursorX
    cp a, $18
    jr c, LibraryMenu_Case05_ReadGridCursorX_Sub03
    xor a, a
    ld [wGlyphListStart], a

; only called from LibraryMenu_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc)
; reads: wGridCursorX
LibraryMenu_Case05_ReadGridCursorX::
Func_00C_430A:: ; address name
    ld b, $BB
    jr LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C_ReadGridCursorX

; only called from LibraryMenu_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc)
; reads: wGridCursorX
LibraryMenu_Case05_ReadGridCursorX_Sub03::
Func_00C_430E:: ; address name
    ld b, $C3
    jr LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C_ReadGridCursorX

; only called from LibraryMenu_Case05 (E-0047)
; 2 call sites from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc)
; reads: wGridCursorX
LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C::
Func_00C_4312:: ; address name
    ld b, $BC

LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C_ReadGridCursorX::
Jump_00C_4314:: ; address name
    ld a, [wGridCursorX]
    add a, a
    ld hl, LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C_Data
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

; address loaded by LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C
LibraryMenu_Case05_BGMapAddressAtScroll_Bank0C_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_4331:: ; address name
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $61, $01

; entry 6 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: hMapId, wOBJPaletteUploadRequest, wScreenState
LibraryMenu_LoadMapHeader::
Jump_00C_433D:: ; address name
    call LibraryMenu_FillTileRectWithArg1Tile
    ld a, $11
    ldh [hMapId], a
    call LoadMapHeader
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    farcall LoadMapObjectsForScreen
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 7 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenByte99, wScreenByte9A, wScreenState
; writes: hSpriteWindowClipMode, hSpriteHideTile, hFieldDrawFlags, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wScreenTileBuffer, wScreenAttrBuffer
LibraryMenu_CopyBytesDEToHL_Bank0C::
Jump_00C_4360:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenByte99]
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenByte9A]
    ldh [hSpriteHideTile], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wTextBuf0
LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C_Case08::
Jump_00C_43CE:: ; address name
    ld hl, $2940
    ld de, vTiles1 + $500
    call CopyTileBytesToVRAM_Bank0C
    call LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C
    call LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C
    call LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a, a
    ld [wMessageMode], a
    ld hl, wScreenState
    ld bc, $0020

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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from LibraryMenu_Case08 (E-0047)
; 3 call sites from 1 routine (e.g. LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C_Case08)
LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C::
Func_00C_4424:: ; address name
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ret

; entry 9 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
LibraryMenu_ToClearStringWindowAt2200AndStep::
Jump_00C_443D:: ; address name
    call ClearStringWindowAt2200
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 10 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGrid2CursorX, wScreenState
; writes: wWindowTileBuffer, wScreenState
LibraryMenu_GridIndexFromGridCursorXGridCursorY::
Jump_00C_4448:: ; address name
    ld de, TileRect_0C_574E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
    ld e, a
    jr nc, .set_window_tile_buffer
    inc d

.set_window_tile_buffer:
    ld a, [de]
    add a, $E1
    ld [wWindowTileBuffer + $165], a
    ld a, [wGrid2CursorX]
    ld hl, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_590A
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wGrid2CursorX]
    ld hl, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_590A
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 11 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
LibraryMenu_WriteScreenState::
Jump_00C_4492:: ; address name
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared03
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 12 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenState, wGrid2CursorX, wGrid2CursorY
; writes: wScreenState, wTwoChoiceCursor, wGrid2CursorX, wGrid2CursorY, wScriptCommandType, wScriptStartRequest
LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C::
Jump_00C_449D:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .call_grid_index_from_grid_cursor_x_grid
    bit 5, a
    jr nz, .check_grid2_cursor_y2
    bit 6, a
    jp nz, .call_library_menu_case0_c_read_grid2_cursor_x2
    bit 7, a
    jp nz, .call_library_menu_case0_c_read_grid2_cursor_x3
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_grid_index_from_grid_cursor_x_grid2
    bit 1, a
    jp nz, .check_screen_state
    call LibraryMenu_Case0C_WriteListEntries
    ret

.call_grid_index_from_grid_cursor_x_grid:
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
    ld e, a
    jr nc, .check_grid2_cursor_y
    inc d

.check_grid2_cursor_y:
    ld a, [de]
    ld b, a
    ld a, [wGrid2CursorY]
    cp a, b
    jr c, .set_grid2_cursor_y
    xor a, a
    jr .set_grid2_cursor_y2

.set_grid2_cursor_y:
    inc a

.set_grid2_cursor_y2:
    ld [wGrid2CursorY], a
    push af
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    pop af
    cp a, b
    jr c, .call_library_menu_case0_c_read_grid2_cursor_x
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    cp a, b
    jr c, .call_library_menu_case0_c_read_grid2_cursor_x
    ld a, b
    ld [wGrid2CursorX], a
    ld a, [wScreenState]
    sub a, $03
    ld [wScreenState], a
    ld a, $69
    call QueueSoundEffect
    ret

.call_library_menu_case0_c_read_grid2_cursor_x:
    call LibraryMenu_Case0C_ReadGrid2CursorX
    ld a, [wScreenState]
    sub a, $03
    ld [wScreenState], a
    ld a, $69
    call QueueSoundEffect
    ret

.check_grid2_cursor_y2:
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, .skip3
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    jr .set_grid2_cursor_y2

.skip3:
    dec a
    jr .set_grid2_cursor_y2

.call_library_menu_case0_c_read_grid2_cursor_x2:
    call LibraryMenu_Case0C_ReadGrid2CursorX_Sub03
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, .set_grid2_cursor_x
    ld a, b
    jr .set_grid2_cursor_x2

.set_grid2_cursor_x:
    dec a

.set_grid2_cursor_x2:
    ld [wGrid2CursorX], a
    call LibraryMenu_Case0C_ReadGrid2CursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_library_menu_case0_c_read_grid2_cursor_x3:
    call LibraryMenu_Case0C_ReadGrid2CursorX_Sub03
    call ReadGridCellByteForGridCursorXGridCursorY
    ld b, a
    ld a, [wGrid2CursorX]
    cp a, b
    jr c, .skip4
    xor a, a
    jr .set_grid2_cursor_x2

.skip4:
    inc a
    jr .set_grid2_cursor_x2

.call_grid_index_from_grid_cursor_x_grid2:
    call GridIndexFromGridCursorXGridCursorY
    add a, a
    ld de, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_5916
    add a, e
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
    and a, a
    jr z, .call_library_menu_case0_c_read_grid2_cursor_x4
    ld a, $69
    call QueueSoundEffect
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_library_menu_case0_c_read_grid2_cursor_x4:
    call LibraryMenu_Case0C_ReadGrid2CursorX
    ret

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from LibraryMenu_Case0C (E-0047)
; 1 call site from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C)
; reads: wJoypadRepeatTimer, wListEntries, wGrid2CursorX
; writes: wListEntries
LibraryMenu_Case0C_WriteListEntries::
Func_00C_45BC:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, LibraryMenu_Case0C_ReadGrid2CursorX
    ld a, [wListEntries]
    inc a
    ld [wListEntries], a
    cp a, $10
    jr c, LibraryMenu_Case0C_ReadGrid2CursorX
    cp a, $18
    jr c, LibraryMenu_Case0C_ReadGrid2CursorX_Sub03
    xor a, a
    ld [wListEntries], a

; only called from LibraryMenu_Case0C (E-0047)
; 3 call sites from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C)
; reads: wGrid2CursorX
LibraryMenu_Case0C_ReadGrid2CursorX::
Func_00C_45D6:: ; address name
    ld b, $BB
    jr LibraryMenu_Case0C_ReadGrid2CursorX_Sub03_ReadGrid2CursorX

; only called from LibraryMenu_Case0C (E-0047)
; 2 call sites from 1 routine (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C)
; reads: wGrid2CursorX
LibraryMenu_Case0C_ReadGrid2CursorX_Sub03::
Func_00C_45DA:: ; address name
    ld b, $C3
    jr LibraryMenu_Case0C_ReadGrid2CursorX_Sub03_ReadGrid2CursorX
    db $06, $BC

LibraryMenu_Case0C_ReadGrid2CursorX_Sub03_ReadGrid2CursorX::
Jump_00C_45E0:: ; address name
    ld a, [wGrid2CursorX]
    add a, a
    ld hl, LibraryMenu_Case0C_ReadGrid2CursorX_Sub03_Data
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

; address loaded by LibraryMenu_Case0C_ReadGrid2CursorX_Sub03
LibraryMenu_Case0C_ReadGrid2CursorX_Sub03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_45FD:: ; address name
    db $29, $00, $69, $00, $A9, $00, $E9, $00, $29, $01, $69, $01

; entry 13 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wArg1, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
LibraryMenu_CopyRectTo20ByteRows_Bank0C_Case0D::
Jump_00C_4609:: ; address name
    ld de, TileRect_0C_57EA
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, $01
    ld [wArg1], a
    call LibraryMenu_HLToDecimalDigits
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX
; writes: wScreenState, wScriptCommandType, wScriptStartRequest
LibraryMenu_StoreBAtWordTableEntry_Bank0C::
Jump_00C_4650:: ; address name
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_CopyRectTo20ByteRows_Bank0C_Data
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $05
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in LibraryMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
LibraryMenu_WriteScreenState_Case0F::
Jump_00C_4676:: ; address name
    call LibraryMenu_FillTileRectWithArg1Tile
    call LibraryMenu_WriteSVBK
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; LibraryMenu screen state $10, by wScreenStep: decompresses graphics, draws the three meta-sprite parts of a monster, sets the palette and the numbers
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
LibraryMenu_ShowMonsterEntry::
Jump_00C_4684:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw LibraryMenu_ShowMonsterEntry_FillTilesFromRequest
    dw LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01
    dw LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params
    dw LibraryMenu_ShowMonsterEntry_GridCellAddressFromGridCursorXAndGrid2CursorX
    dw LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050
    dw LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case05
    dw LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case06
    dw LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case07
    dw LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08
    dw LibraryMenu_ShowMonsterEntry_DecompressToVRAM
    dw LibraryMenu_ShowMonsterEntry_CopyRectTo20ByteRows_Bank0C
    dw LibraryMenu_ShowMonsterEntry_WriteBGPalette0From555C
    dw LibraryMenu_ShowMonsterEntry_LibraryMenu_HLToDecimalDigits
    dw LibraryMenu_ShowMonsterEntry_StoreBAtWordTableEntry_Bank0C

; entry 0 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep, wScreenSubStep
LibraryMenu_ShowMonsterEntry_FillTilesFromRequest::
Jump_00C_46A4:: ; address name
    call LibraryMenu_ShowMonsterEntry_FillTilesFromRequest_Shared01
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
    ld hl, Tiles_0C_4718
    ld de, vTiles2 + $610
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    ld de, Tiles2Plus250Tiles_1F_41D0
    ld hl, vTiles2 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus240Tiles_1F_4170
    ld hl, vTiles2 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus200Tiles_1F_4160
    ld hl, vTiles2 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus7F0Tiles_1F_4110
    ld hl, vTiles2 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; E-0237 (C1: ScriptCommandF6 code loads HL = $4718 and DE = vTiles2 + $610 and calls CopyTileBytesToVRAM_Bank0C six times, 16 bytes each).
; record: tile (16 bytes, 2 bits per pixel)
Tiles_0C_4718::
Data_00C_4718:: ; address name
    db $FF, $03, $FF, $03, $FF, $03, $FF, $FF, $FF, $FF, $FF, $03, $FF, $03, $FF, $03 ; id 0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $03, $FF, $03, $FF, $03, $FF, $03, $FF, $03 ; id 1
    db $FF, $03, $FF, $03, $FF, $03, $FF, $03, $FF, $03, $FF, $00, $FF, $00, $FF, $00 ; id 2
    db $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00 ; id 3
    db $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $60, $FF, $60, $FF, $60 ; id 4
    db $FF, $60, $FF, $60, $FF, $60, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00 ; id 5

; entry 1 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wIsCGB, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, rSVBK, wBGPaletteUploadRequest, wScreenStep, wScreenSubStep
; points at: wWindowTileBuffer, wWindowAttrBuffer, wScreenBlock9C
LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01::
Jump_00C_4778:: ; address name
    ld a, [wScreenSubStep]
    and a, a
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
    ld de, Tiles1Gfx_F1_5C14
    ld hl, vTiles1
    ld b, $F1
    call DecompressToVRAM
    ld de, WindowTileBufferPlus64Gfx_F1_5D44
    ld hl, wWindowTileBuffer + $64
    ld b, $F1
    call DecompressToVRAM
    ld de, WindowTileBufferGfx_F1_5D9C
    ld hl, wWindowTileBuffer
    ld b, $F1
    call DecompressToVRAM
    ld a, [wIsCGB]
    and a, a
    jr z, .skip
    ld a, $02
    ldh [rSVBK], a
    ld de, WindowAttrBufferPlus64Gfx_F1_5DBC
    ld hl, wWindowAttrBuffer + $64
    ld b, $F1
    call DecompressToVRAM
    ld de, WindowAttrBufferGfx_F1_5DEE
    ld hl, wWindowAttrBuffer
    ld b, $F1
    call DecompressToVRAM
    xor a, a
    ldh [rSVBK], a
    farcall LoadBGPalettesFrom5E04
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

.skip:
    ld de, TileRect_0C_48AB
    ld hl, wWindowTileBuffer + $81
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48B5
    ld hl, wWindowTileBuffer + $BD
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48BF
    ld hl, wWindowTileBuffer + $E5
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48C9
    ld hl, wWindowTileBuffer + $10D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48D2
    ld hl, wWindowTileBuffer + $135
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48DB
    ld hl, wWindowTileBuffer + $15D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48E4
    ld hl, wWindowTileBuffer + $15
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    ld de, TileRect_0C_48F6
    ld hl, wWindowTileBuffer + $3D
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    call LibraryMenu_ShowMonsterEntry_Case01_CallGridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, wScreenBlock9C
    ld hl, wWindowTileBuffer + $108
    ld bc, $0201
    call CopyRectTo20ByteRows_Bank0C
    call LibraryMenu_ShowMonsterEntry_LoadClassBlock
    ld de, wScreenBlock9C
    ld hl, wWindowTileBuffer + $130
    ld bc, $0401
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $130
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 1 tiles, one row per line
TileRect_0C_48AB::
Data_00C_48AB:: ; address name
    db $2F, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 1 tiles, one row per line
TileRect_0C_48B5::
Data_00C_48B5:: ; address name
    db $42, $30, $31, $32, $33, $34, $35, $36, $37, $38 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 1 tiles, one row per line
TileRect_0C_48BF::
Data_00C_48BF:: ; address name
    db $43, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 1 tiles, one row per line
TileRect_0C_48C9::
Data_00C_48C9:: ; address name
    db $44, $45, $46, $47, $48, $49, $4A, $4B, $4C ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 1 tiles, one row per line
TileRect_0C_48D2::
Data_00C_48D2:: ; address name
    db $4D, $4E, $4F, $50, $51, $52, $53, $54, $55 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 1 tiles, one row per line
TileRect_0C_48DB::
Data_00C_48DB:: ; address name
    db $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 18 x 1 tiles, one row per line
TileRect_0C_48E4::
Data_00C_48E4:: ; address name
    db $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 18 x 1 tiles, one row per line
TileRect_0C_48F6::
Data_00C_48F6:: ; address name
    db $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3, $C4, $C5 ; id 0
    db $7E, $7F

; entry 2 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wIsCGB, wScreenStep
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenSubStep, ...
LibraryMenu_ShowMonsterEntry_DrawTileRectFromArg1Params::
Jump_00C_490A:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jp nz, .call_grid_cell_address_from_grid_cursor_x_and
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld de, TileRect_1F_651B
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
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld e, l
    ld d, h
    push de
    ld a, $7F
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
    ld de, TileRect_1F_64D3
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
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wScreenStep
LibraryMenu_ShowMonsterEntry_GridCellAddressFromGridCursorXAndGrid2CursorX::
Jump_00C_49B5:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wWorkBuf, wArg1, ...
; points at: wArg5
LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050::
Jump_00C_49DA:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, h
    add a, $02
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
    and a, $0F
    ld [wWorkBuf], a
    ld a, $2F
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
    add a, a
    ld de, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Data
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
    cp a, $03
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050
LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_4AA0:: ; address name
    db $40, $94, $D0, $94, $60, $95

; entry 5 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case05::
Jump_00C_4AA6:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call LibraryMenu_TestBitInFieldAtArg3
    cp a, $FF
    jr z, .check_screen_step
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles2 + $420
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles2 + $430
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
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

; entry 6 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case06::
Jump_00C_4B12:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableA
    add hl, de
    ld a, $42
    call LibraryMenu_ShowMonsterEntry_Case06_FamilyForSpeciesIdArg6
    pop hl
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableB
    add hl, de
    ld a, $43
    call LibraryMenu_ShowMonsterEntry_Case06_FamilyForSpeciesIdArg6
    pop hl
    push hl
    sla l
    rl h
    ld de, MonsterPedigreeTableA
    add hl, de
    ld de, vTiles2 + $300
    call LibraryMenu_ShowMonsterEntry_Case06_ShowString_Bank08
    pop hl
    sla l
    rl h
    ld de, MonsterPedigreeTableB
    add hl, de
    ld de, vTiles2 + $390
    call LibraryMenu_ShowMonsterEntry_Case06_ShowString_Bank08
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case07::
Jump_00C_4B5C:: ; address name
    call DrawThreeMetaSpritePartsFor5050
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

; entry 8 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wGridCursorX, wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wGrid2CursorX, wGrid2CursorY
; writes: wScreenStep, wGrid2CursorY, wGrid2CursorX, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenSubStep
; points at: wScreenCountPlusOne
LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08::
Jump_00C_4B95:: ; address name
    call DrawThreeMetaSpritePartsFor5050
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGridCursorX]
    add a, b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [hl]
    cp a, $01
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
    cp a, $05
    jr c, .set_grid2_cursor_x
    xor a, a
    ld [wGrid2CursorX], a
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
    ld e, a
    jr nc, .check_grid2_cursor_y
    inc d

.check_grid2_cursor_y:
    ld a, [de]
    ld b, a
    ld a, [wGrid2CursorY]
    cp a, b
    jr c, .set_grid2_cursor_y

.loop2:
    xor a, a
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
    add a, a
    ld hl, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_592E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, .call_grid_cell_address_from_grid_cursor_x_and2
    jr nz, .loop2
    ld a, l
    cp a, e
    jr c, .call_grid_cell_address_from_grid_cursor_x_and2
    jr .loop2

.call_grid_cell_address_from_grid_cursor_x_and2:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call LibraryMenu_TestBitInFieldAtArg3
    and a, a
    jr z, .loop
    ld a, $69
    call QueueSoundEffect
    call LibraryMenu_ShowMonsterEntry_FillTilesFromRequest_Shared01
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
    and a, a
    jr nz, .set_grid2_cursor_x2
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, .set_grid2_cursor_y3

.loop4:
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
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
    add a, a
    ld hl, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_592E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, .call_grid_cell_address_from_grid_cursor_x_and4
    jr nz, .loop4
    ld a, l
    cp a, e
    jr c, .call_grid_cell_address_from_grid_cursor_x_and4
    jr nz, .loop4

.call_grid_cell_address_from_grid_cursor_x_and4:
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    call LibraryMenu_TestBitInFieldAtArg3
    and a, a
    jr z, .loop3
    ld a, $69
    call QueueSoundEffect
    call LibraryMenu_ShowMonsterEntry_FillTilesFromRequest_Shared01
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

; entry 9 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
LibraryMenu_ShowMonsterEntry_DecompressToVRAM::
Jump_00C_4CE2:: ; address name
    call LibraryMenu_FillTileRectWithArg1Tile
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    call LibraryMenu_WriteSVBK
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY, wGridCursorX, wGrid2CursorX, wScreenStep
; writes: wWindowTileBuffer, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wBGPaletteUploadRequest, wScreenStep
LibraryMenu_ShowMonsterEntry_CopyRectTo20ByteRows_Bank0C::
Jump_00C_4CFB:: ; address name
    ld de, TileRect_0C_56D9
    ld hl, wWindowTileBuffer + $64
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGridCursorY]
    and a, a
    jr z, .read_grid_cursor_x
    ld a, $C3
    ld [wWindowTileBuffer + $145], a

.read_grid_cursor_x:
    ld a, [wGridCursorX]
    ld hl, LibraryMenu_CopyRectTo20ByteRows_Bank0C_Data
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wGridCursorY]
    add a, $E1
    ld [wWindowTileBuffer + $156], a
    ld de, TileRect_0C_574E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wGrid2CursorX]
    ld b, $BC
    ld hl, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_590A
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
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
LibraryMenu_ShowMonsterEntry_WriteBGPalette0From555C::
Jump_00C_4D6B:: ; address name
    call WriteBGPalette0From555C
    call LibraryMenu_WriteWorkBuf
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
; points at: wWindowTileBuffer
LibraryMenu_ShowMonsterEntry_LibraryMenu_HLToDecimalDigits::
Jump_00C_4D7C:: ; address name
    ld a, $01
    ld [wArg1], a
    call LibraryMenu_HLToDecimalDigits
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld de, TileRect_0C_589A
    ld hl, wWindowTileBuffer
    ld bc, $1405
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    call LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared03
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in LibraryMenu_ShowMonsterEntry
; no direct call (reached through a table, a jump or a vector)
; reads: wGrid2CursorX
; writes: wScreenStep, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
LibraryMenu_ShowMonsterEntry_StoreBAtWordTableEntry_Bank0C::
Jump_00C_4DD6:: ; address name
    ld a, [wGrid2CursorX]
    ld b, $C3
    ld hl, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_590A
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140C
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    xor a, a
    ld [wScreenStep], a
    ld a, $0C
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

; only called from LibraryMenu_ShowMonsterEntry_Case06 (E-0047)
; 2 call sites from 1 routine (e.g. LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case06)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
LibraryMenu_ShowMonsterEntry_Case06_ShowString_Bank08::
Func_00C_4E16:: ; address name
    push de
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, .skip
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
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
    cp a, $FE
    jr z, .clear_string_category
    and a, $0F
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    jr .set_text_window_tile_lo

.clear_string_category:
    xor a, a
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

; only called from LibraryMenu_ShowMonsterEntry_Case06 (E-0047)
; 2 call sites from 1 routine (e.g. LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case06)
; reads: wArg5
; writes: wArg6, wArg7, wWorkBuf
LibraryMenu_ShowMonsterEntry_Case06_FamilyForSpeciesIdArg6::
Func_00C_4E75:: ; address name
    push af
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, .skip
    ld a, [hl+]
    ld [wArg6], a
    ld a, [hl]
    ld [wArg7], a
    farcall FamilyForSpeciesIdArg6
    ld a, [wArg5]
    jr .set_work_buf

.skip:
    ld a, [hl]
    cp a, $FE
    jr z, .restore

.set_work_buf:
    and a, $0F
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
    ld de, Tiles2Plus420Tiles_1F_4990
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; only called from routines of LibraryMenu (E-0098)
; 2 call sites from 2 routines (e.g. LibraryMenu_GridIndexFromGridCursorXGridCursorY, LibraryMenu_ShowMonsterEntry_WriteBGPalette0From555C)
; reads: wGrid2CursorY
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01::
Func_00C_4EC7:: ; address name
    call GridIndexFromGridCursorXGridCursorY
    add a, a
    ld de, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_5916
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
    ld a, [wGrid2CursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    ld c, $00

.loop:
    push hl
    push bc
    call LibraryMenu_TestBitInFieldAtArg3
    and a, a
    jr z, .restore
    pop bc
    pop hl
    push hl
    push bc
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01_Data
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
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01_Data
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
    cp a, b
    jp c, .loop
    ret

; address loaded by LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01
LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_4F68:: ; address name
    db $00, $92, $90, $92, $20, $93, $B0, $93, $40, $94, $D0, $94

; only called from routines of LibraryMenu (E-0098)
; 2 call sites from 2 routines (e.g. LibraryMenu_CopyRectTo20ByteRows_Bank0C, LibraryMenu_ShowMonsterEntry_WriteBGPalette0From555C)
; reads: wGridCursorY
; writes: wWorkBuf
LibraryMenu_WriteWorkBuf::
Func_00C_4F74:: ; address name
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld de, LibraryMenu_WriteWorkBuf_Data
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld c, $00

.loop:
    ld a, [de]
    cp a, $FF
    jr z, .next
    push de
    push bc
    ld [wWorkBuf], a
    cp a, $06
    jr c, .set_work_buf
    sub a, $06

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
    cp a, $06
    jr c, .loop
    ret

; address loaded by LibraryMenu_WriteWorkBuf
LibraryMenu_WriteWorkBuf_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_4FAA:: ; address name
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $FF, $20, $90, $70, $90
    db $C0, $90, $10, $91, $60, $91, $B0, $91

; with the pointer from Func_00C_5050 draws sub-indices 0, 4 and 2 (Func_01D_6A36) at Y = $10, $24 and $38, X = $6C (E-0121)
; 5 call sites from 5 routines (e.g. LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case07, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case06, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case05, ...)
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6, hSpriteSubIndex
DrawThreeMetaSpritePartsFor5050::
Func_00C_4FC2:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $10
    ld [wArg4], a
    ld a, $6C
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    xor a, a
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_WriteSpriteAttrXorAndSpriteTileOffsetEtc
    ld a, $24
    ld [wArg4], a
    ld a, $6C
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    ld a, $04
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_WriteSpriteAttrXorAndSpriteTileOffsetEtc
    ld a, $38
    ld [wArg4], a
    ld a, $6C
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    ld c, $01
    ld a, $02
    ldh [hSpriteSubIndex], a
    farcall DrawThreeMetaSpritePartsFor5050_WriteSpriteAttrXorAndSpriteTileOffsetEtc
    ret

; only called from routines of LibraryMenu (E-0098)
; 2 call sites from 2 routines (e.g. LibraryMenu_WriteScreenState, LibraryMenu_ShowMonsterEntry_LibraryMenu_HLToDecimalDigits)
; reads: wGrid2CursorY
LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared03::
Func_00C_501F:: ; address name
    call BGMapAddressAtScroll_Bank0C
    ld de, $018F
    add hl, de
    push hl
    ld a, [wGrid2CursorY]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call GridIndexFromGridCursorXGridCursorY
    ld de, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a, $E1
    ld b, a
    pop hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; HL = the word Data_00C_5916[GridIndexFromGridCursorXGridCursorY] + GridIndexFromGrid2CursorXGrid2CursorY (E-0124)
; 15 call sites from 10 routines (e.g. LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08, DrawThreeMetaSpritePartsFor5050, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case07, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case06, ...)
GridCellAddressFromGridCursorXAndGrid2CursorX::
Func_00C_5050:: ; address name
    call GridIndexFromGridCursorXGridCursorY
    add a, a
    ld de, LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_5916
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
    push hl
    call GridIndexFromGrid2CursorXGrid2CursorY
    pop hl
    add_a_to_hl
    ret

; A = the byte at Data_00C_594F[GridIndexFromGridCursorXGridCursorY] + wGrid2CursorY (E-0122)
; 6 call sites from 3 routines (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08)
; reads: wGrid2CursorY
ReadGridCellByteForGridCursorXGridCursorY::
Func_00C_506C:: ; address name
    call GridIndexFromGridCursorXGridCursorY
    add a, a
    ld hl, ReadGridCellByteForGridCursorXGridCursorY_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wGrid2CursorY]
    add a, e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ret

; only called from routines of LibraryMenu (E-0098)
; 4 call sites from 3 routines (e.g. LibraryMenu_CopyRectTo20ByteRows_Bank0C_Case0D, LibraryMenu_BGMapAddressAtScroll_Bank0C, LibraryMenu_ShowMonsterEntry_LibraryMenu_HLToDecimalDigits)
; reads: wGridCursorY, wDigits, wArg1
; writes: wDigits
; points at: wScreenCountPlusOne
LibraryMenu_HLToDecimalDigits::
Func_00C_5085:: ; address name
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wScreenCountPlusOne
    add_a_to_hl
    ld a, [wGridCursorY]
    and a, a
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
    and a, a
    jr nz, .call_bg_map_address_at_scroll_bank0_c
    add a, $E3
    ld [wDigits + $1], a

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    pop bc
    push bc
    ld a, c
    add a, a
    push hl
    push af
    ld a, [wArg1]
    and a, a
    jr z, .skip3
    ld hl, LibraryMenu_HLToDecimalDigits_Data_510F
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
    ld hl, LibraryMenu_HLToDecimalDigits_Data_5103
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
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ret

; address loaded by LibraryMenu_HLToDecimalDigits
LibraryMenu_HLToDecimalDigits_Data_5103:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_5103:: ; address name
    db $26, $00, $66, $00, $A6, $00, $E6, $00, $26, $01, $66, $01

; address loaded by LibraryMenu_HLToDecimalDigits
LibraryMenu_HLToDecimalDigits_Data_510F:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_510F:: ; address name
    db $7E, $C3, $A6, $C3, $CE, $C3, $F6, $C3, $1E, $C4, $46, $C4

; only called from routines of LibraryMenu (E-0098)
; 3 call sites from 3 routines (e.g. LibraryMenu_WriteScreenState_Case0F, LibraryMenu_WriteScrollYAndScrollXEtc, LibraryMenu_ShowMonsterEntry_DecompressToVRAM)
; reads: wIsCGB
; writes: rSVBK
LibraryMenu_WriteSVBK::
Func_00C_511B:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld bc, $0104

.loop:
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, [wIsCGB]
    and a, a
    jr z, .return
    ld a, $02
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $64
    ld bc, $0104

.loop2:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld a, $00
    ldh [rSVBK], a

.return:
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 14 call sites from 4 routines (e.g. LibraryMenu_FillTileRectWithArg1Tile, LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C_Case08, LibraryMenu_Case08_CopyTileBytesToVRAM_Bank0C, LibraryMenu_ShowMonsterEntry_FillTilesFromRequest)
; reads: rSTAT
CopyTileBytesToVRAM_Bank0C::
Func_00C_5145:: ; address name
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 40 call sites from 31 routines (e.g. ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case26, RedrawFullScreenBoxes_0C, ArenaMenu_SubtractArg1AmountFromGold_Case19, ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank0C::
Func_00C_5156:: ; address name
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

; only called from routines of LibraryMenu (E-0098)
; 4 call sites from 4 routines (e.g. LibraryMenu_WriteScreenState_Case0F, LibraryMenu_LoadMapHeader, LibraryMenu_WriteScrollYAndScrollXEtc, LibraryMenu_ShowMonsterEntry_DecompressToVRAM)
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7
LibraryMenu_FillTileRectWithArg1Tile::
Func_00C_5177:: ; address name
    ld hl, Tiles_0C_51AB
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
    xor a, a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    ret

; E-0238 (derived: HL = $51AB and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_0C_51AB::
Data_00C_51AB:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 0

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 23 call sites from 13 routines (e.g. ArenaMenu_Number24ToPackedBCD, ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18, ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case11, ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case10, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank0C::
Func_00C_51BB:: ; address name
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

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wTextCursorLo/wTextCursorHi = HL + $1C1 (row 14, column 1 of the drawn area) when wStringIndex is $18 or $12, otherwise $99C1 (E-0062)
; 29 call sites from 22 routines (e.g. ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case26, RedrawFullScreenBoxes_0C, ArenaMenu_SubtractArg1AmountFromGold_Case19, ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18, ...)
; reads: wStringIndex, wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_Bank0C::
Func_00C_51F5:: ; address name
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
    ld a, [wStringIndex]
    cp a, $18
    jr z, .restore
    cp a, $12
    jr z, .restore
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

; only called from ArenaMenu_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_BGMapAddressAtScroll_Bank0C)
ArenaMenu_Case05_StoreBAtWordTableEntry_Bank0C::
Func_00C_5247:: ; address name
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank0C
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 12 call sites from 9 routines (e.g. ArenaMenu_WriteTextBuf0AndScreenStateEtc, ArenaMenu_Case05_StoreBAtWordTableEntry_Bank0C, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, LibraryMenu_StoreBAtWordTableEntry_Bank0C, ...)
StoreBAtWordTableEntry_Bank0C::
Func_00C_525B:: ; address name
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

; sets the string window to tile destination vTiles2 + $20 and size word $1702, then FillTilesFromRequest (clears it) (E-0117)
; 2 call sites from 2 routines (e.g. LibraryMenu_ToClearStringWindowAt2020AndStep, LibraryMenu_ShowMonsterEntry_CopyRectTo20ByteRows_Bank0C)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ClearStringWindowAt2020::
Func_00C_5269:: ; address name
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

; sets the string window to tile destination vTiles2 + $200 and size word $5301, then FillTilesFromRequest (clears it) (E-0117)
; 2 call sites from 2 routines (e.g. LibraryMenu_ToClearStringWindowAt2200AndStep, LibraryMenu_ShowMonsterEntry_CopyRectTo20ByteRows_Bank0C)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ClearStringWindowAt2200::
Func_00C_5283:: ; address name
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $5301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ret

; only called from routines of LibraryMenu_ShowMonsterEntry (E-0098)
; 3 call sites from 2 routines (e.g. LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08, LibraryMenu_ShowMonsterEntry_FillTilesFromRequest)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
LibraryMenu_ShowMonsterEntry_FillTilesFromRequest_Shared01::
Func_00C_529D:: ; address name
    ld hl, vTiles2
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $6101
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 4 call sites from 4 routines (e.g. CopyScreenBufferRectWithAttrs_0C, RedrawFullScreenBoxes_0C, ArenaMenu_CopyBytesDEToHL_Bank0C, LibraryMenu_CopyBytesDEToHL_Bank0C)
CopyBytesDEToHL_Bank0C::
Func_00C_52D0:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank0C
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 4 call sites from 4 routines (e.g. CopyScreenBufferRectWithAttrs_0C, RedrawFullScreenBoxes_0C, ArenaMenu_CopyBytesDEToHL_Bank0C, LibraryMenu_CopyBytesDEToHL_Bank0C)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank0C::
Func_00C_52D9:: ; address name
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
    ld a, $00
    ldh [rSVBK], a
    ret

; A = 6 * wGridCursorY + wGridCursorX (row-major index in a 6-column grid: wGridCursorX column, wGridCursorY row); BC kept (E-0072)
; 15 call sites from 8 routines (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C, ReadGridCellByteForGridCursorXGridCursorY, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared03, LibraryMenu_GridIndexFromGridCursorXGridCursorY, ...)
; reads: wGridCursorY, wGridCursorX
GridIndexFromGridCursorXGridCursorY::
Func_00C_52EC:: ; address name
    push bc
    ld a, [wGridCursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGridCursorX]
    add a, b
    pop bc
    ret

; A = 6 * wGrid2CursorY + wGrid2CursorX (row-major index in a 6-column grid); BC kept (E-0117)
; 2 call sites from 2 routines (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C, GridCellAddressFromGridCursorXAndGrid2CursorX)
; reads: wGrid2CursorY, wGrid2CursorX
GridIndexFromGrid2CursorXGrid2CursorY::
Func_00C_52FB:: ; address name
    push bc
    ld a, [wGrid2CursorY]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wGrid2CursorX]
    add a, b
    pop bc
    ret

; only called from routines of LibraryMenu (E-0098)
; 5 call sites from 4 routines (e.g. LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case05)
; reads: wArg5
; writes: wArg1, wArg2, wArg3, wArg4, wSpeciesIdLo, wSpeciesIdHi
; points at: wMonsterLibraryBuf
LibraryMenu_TestBitInFieldAtArg3::
Func_00C_530A:: ; address name
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
    cp a, $FF
    jr nz, .restore
    pop hl
    ld a, $FF
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
    and a, a
    jr nz, .done
    pop hl
    xor a, a
    ret

.done:
    pop hl
    ld a, $FE
    ret

; only called from LibraryMenu_ShowMonsterEntry_Case01 (E-0047)
; 1 call site from 1 routine (e.g. LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01)
; points at: wScreenBlock9C
LibraryMenu_ShowMonsterEntry_Case01_CallGridCellAddressFromGridCursorXAndGrid2CursorX::
Func_00C_534A:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, MonsterIconKindTable_536A
    add hl, de
    ld a, [hl]
    ld hl, LibraryMenu_ShowMonsterEntry_Case01_CallGridCellAddressFromGridCursorXAndGrid2CursorX_Data
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $02
    ld hl, wScreenBlock9C

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ret

; E-0206 (C1: LibraryMenu_Case10_Case01_Sub01 reads the byte at $536A + the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX and copies the two tile bytes that Data_00C_54DF[value] points to into wScreenBlock9C; 373 bytes, one per monster id up to $174).
; record: index into Data_00C_54DF
MonsterIconKindTable_536A::
Data_00C_536A:: ; address name
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

; address loaded by LibraryMenu_ShowMonsterEntry_Case01_CallGridCellAddressFromGridCursorXAndGrid2CursorX
LibraryMenu_ShowMonsterEntry_Case01_CallGridCellAddressFromGridCursorXAndGrid2CursorX_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_54DF:: ; address name
    db $E9, $54, $EB, $54, $ED, $54, $EF, $54, $F1, $54, $7C, $80, $7D, $80, $7E, $80
    db $7E, $7E, $7F, $80

; takes the class byte of the grid cell (MonsterClassByteTable_5562) and copies its four bytes to wScreenBlock9C
; 1 call site from 1 routine (e.g. LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01)
; points at: wScreenBlock9C
LibraryMenu_ShowMonsterEntry_LoadClassBlock::
Func_00C_54F3:: ; address name
    call GridCellAddressFromGridCursorXAndGrid2CursorX
    ld de, MonsterClassByteTable_5562
    add hl, de
    ld a, [hl]
    add a, a
    ld hl, LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $04
    ld hl, wScreenBlock9C

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ret

; address loaded by LibraryMenu_ShowMonsterEntry_LoadClassBlock
LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_5513:: ; address name
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry00
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry01
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry02
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry03
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry04
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry05
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry06
    dw LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry07

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5523:: ; address name
    db $81, $80, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5527:: ; address name
    db $82, $80, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_00C_552B:: ; address name
    db $82, $81, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_00C_552F:: ; address name
    db $82, $82, $80, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5533:: ; address name
    db $82, $82, $81, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5537:: ; address name
    db $82, $82, $82, $80

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_00C_553B:: ; address name
    db $82, $82, $82, $81

LibraryMenu_ShowMonsterEntry_LoadClassBlock_Data_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_00C_553F:: ; address name
    db $82, $82, $82, $82

; writes six bytes from Data_00C_555C to the CGB background palette data (rBCPS = $80, auto-increment), waiting for VRAM access (E-0122)
; 1 call site from 1 routine (e.g. LibraryMenu_ShowMonsterEntry_WriteBGPalette0From555C)
; reads: rSTAT
WriteBGPalette0From555C::
Func_00C_5543:: ; address name
    ld hl, WriteBGPalette0From555C_Data
    ld b, $80
    ld c, $68
    ld a, b
    ldh [c], a
    ld c, $69
    ld d, $06

.loop:
    ldh a, [rSTAT]
    and a, $02
    jr nz, .loop
    ld a, [hl+]
    ldh [c], a
    dec d
    jr nz, .loop
    ret

; address loaded by WriteBGPalette0From555C
WriteBGPalette0From555C_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_555C:: ; address name
    db $86, $7D, $FF, $7F, $E1, $7F

; E-0206 (C1: LibraryMenu_Case10_Case01_Sub02 reads the byte at $5562 + the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX and copies the 4-byte tile block that Data_00C_5513[class] points to into wScreenBlock9C; the same 373 values as MonsterClassByteTable_71AC in bank $16 except at ids 26, 352, 355, 358, 360, 364, 366, 367, 372).
; record: class 0-7
MonsterClassByteTable_5562::
Data_00C_5562:: ; address name
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

; address loaded by LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc
LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_56D7:: ; address name
    db $05, $04

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 13 tiles, one row per line
TileRect_0C_56D9::
Data_00C_56D9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $02, $C3, $C3, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $03, $C3, $C3, $ED, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $04, $C3, $C3, $ED, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $05, $C3, $C3, $ED, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $06, $C3, $C3, $ED, $C3, $C3, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $07, $C3, $C3, $ED, $C3, $C3, $B7 ; id 11
    db $B3, $C5, $C3, $BE, $E2, $C6, $B4, $B4, $B5 ; id 12

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 13 tiles, one row per line
TileRect_0C_574E::
Data_00C_574E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $B7 ; id 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 10
    db $B6, $C3, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $B7 ; id 11
    db $B3, $B4, $B4, $B4, $B4, $B4, $C5, $C3, $BE, $C3, $C6, $B5 ; id 12

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 13 tiles, one row per line
TileRect_0C_57EA::
Data_00C_57EA:: ; address name
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 7
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 8
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 9
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 10
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 11
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 12
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $66, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_0C_589A::
Data_00C_589A:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by LibraryMenu_CopyRectTo20ByteRows_Bank0C, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc, LibraryMenu_StoreBAtWordTableEntry_Bank0C, LibraryMenu_ShowMonsterEntry_CopyRectTo20ByteRows_Bank0C
LibraryMenu_CopyRectTo20ByteRows_Bank0C_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_58FE:: ; address name
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

; address loaded by LibraryMenu_GridIndexFromGridCursorXGridCursorY, LibraryMenu_ShowMonsterEntry_CopyRectTo20ByteRows_Bank0C, LibraryMenu_ShowMonsterEntry_StoreBAtWordTableEntry_Bank0C
LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_590A:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_590A:: ; address name
    db $81, $C3, $A9, $C3, $D1, $C3, $F9, $C3, $21, $C4, $49, $C4

; address loaded by LibraryMenu_BGMapAddressAtScroll_Bank0C, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared01, GridCellAddressFromGridCursorXAndGrid2CursorX
LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_5916:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_5916:: ; address name
    db $01, $00, $24, $00, $47, $00, $6A, $00, $8D, $00, $B0, $00, $D3, $00, $F6, $00
    db $19, $01, $3C, $01, $5F, $01, $FF, $FF

; address loaded by LibraryMenu_BGMapAddressAtScroll_Bank0C, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08
LibraryMenu_BGMapAddressAtScroll_Bank0C_Data_592E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_592E:: ; address name
    db $1B, $00, $43, $00, $67, $00, $85, $00, $A8, $00, $CA, $00, $F1, $00, $11, $01
    db $39, $01, $5C, $01, $75, $01

; address loaded by LibraryMenu_GridIndexFromGridCursorXGridCursorY, LibraryMenu_WriteScreenStateAndTwoChoiceCursorEtc_Case0C, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case08, LibraryMenu_GridIndexFromGridCursorXGridCursorY_Shared03
LibraryMenu_GridIndexFromGridCursorXGridCursorY_Data_5944:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_5944:: ; address name
    db $04, $05, $05, $04, $04, $04, $04, $04, $05, $05, $03

; address loaded by ReadGridCellByteForGridCursorXGridCursorY
ReadGridCellByteForGridCursorXGridCursorY_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_594F:: ; address name
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

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5965:: ; address name
    db $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_00C_596A:: ; address name
    db $05, $05, $05, $05, $05, $00

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5970:: ; address name
    db $05, $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5976:: ; address name
    db $05, $05, $05, $05, $02

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_00C_597B:: ; address name
    db $05, $05, $05, $05, $02

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5980:: ; address name
    db $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5985:: ; address name
    db $05, $05, $05, $05, $05

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_00C_598A:: ; address name
    db $05, $05, $05, $05, $02

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry08:: ; heuristic: target of a monotone pointer table; C0
Data_00C_598F:: ; address name
    db $05, $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry09:: ; heuristic: target of a monotone pointer table; C0
Data_00C_5995:: ; address name
    db $05, $05, $05, $05, $05, $01

ReadGridCellByteForGridCursorXGridCursorY_Data_Entry0A:: ; heuristic: target of a monotone pointer table; C0
Data_00C_599B:: ; address name
    db $05, $05, $05, $03

; E-0211 (C1: LibraryMenu_Case10_Case06 takes the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX (page base from Data_00C_5916 plus the grid position) and reads the word at $599F + 2 * number: the first word LibraryMenu_Case10_Case06 draws (graphics at vTiles2 + $300, sprite part $42); the two parents shown for the monster: for all 95 monsters whose two entries are families, FamilyPairResultTable (bank $0E) row A, column B gives that monster or parent A's species (C2 for those entries); 384 words).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableA::
Data_00C_599F:: ; address name
    dw $FE00 ; id 0 family 0
    dw $FE00 ; id 1 DrakSlime family 0
    dw $FE00 ; id 2 SpotSlime family 0
    dw $FE00 ; id 3 WingSlime family 0
    dw $FE00 ; id 4 TreeSlime family 0
    dw $FE00 ; id 5 Snaily family 0
    dw $FE00 ; id 6 SlimeNite family 0
    dw $FE00 ; id 7 Babble family 0
    dw $FE00 ; id 8 BoxSlime family 0
    dw $FE00 ; id 9 PearlGel family 0
    dw $FEFE ; id 10 Slime none
    dw $FE00 ; id 11 Healer family 0
    dw $FE00 ; id 12 FangSlime family 0
    dw $FE00 ; id 13 RockSlime family 0
    dw $0001 ; id 14 SlimeBorg DrakSlime
    dw $FE00 ; id 15 Slabbit family 0
    dw $FE00 ; id 16 KingSlime family 0
    dw $FE00 ; id 17 Metaly family 0
    dw $0011 ; id 18 Metabble Metaly
    dw $0010 ; id 19 SpotKing KingSlime
    dw $0004 ; id 20 TropicGel TreeSlime
    dw $000B ; id 21 MimeSlime Healer
    dw $0015 ; id 22 HaloSlime MimeSlime
    dw $0013 ; id 23 MetalKing SpotKing
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE01 ; id 36 DragonKid family 1
    dw $FE01 ; id 37 Tortragon family 1
    dw $FE01 ; id 38 Pteranod family 1
    dw $FE01 ; id 39 Gasgon family 1
    dw $FE01 ; id 40 FairyDrak family 1
    dw $FE01 ; id 41 LizardMan family 1
    dw $FE01 ; id 42 Poisongon family 1
    dw $FE01 ; id 43 Swordgon family 1
    dw $FE01 ; id 44 Drygon family 1
    dw $0024 ; id 45 Dragon DragonKid
    dw $FE01 ; id 46 MiniDrak family 1
    dw $0027 ; id 47 MadDragon Gasgon
    dw $0029 ; id 48 Rayburn LizardMan
    dw $FE01 ; id 49 Chamelgon family 1
    dw $FE01 ; id 50 LizardFly family 1
    dw $FE01 ; id 51 Andreal family 1
    dw $FE01 ; id 52 KingCobra family 1
    dw $FE01 ; id 53 Vampirus family 1
    dw $0034 ; id 54 SnakeBat KingCobra
    dw $FE01 ; id 55 Spikerous family 1
    dw $002D ; id 56 GreatDrak Dragon
    dw $FE01 ; id 57 Crestpent family 1
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $0033 ; id 60 Orochi Andreal
    dw $FE01 ; id 61 BattleRex family 1
    dw $FE01 ; id 62 SkyDragon family 1
    dw $0038 ; id 63 Serpentia GreatDrak
    dw $003E ; id 64 Divinegon SkyDragon
    dw $0040 ; id 65 Orligon Divinegon
    dw $0038 ; id 66 GigaDraco GreatDrak
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE02 ; id 71 Tonguella family 2
    dw $FE02 ; id 72 Almiraj family 2
    dw $FE02 ; id 73 CatFly family 2
    dw $FE02 ; id 74 PillowRat family 2
    dw $FE02 ; id 75 Saccer family 2
    dw $0055 ; id 76 GulpBeast Grizzly
    dw $FE02 ; id 77 Skullroo family 2
    dw $FE02 ; id 78 WindBeast family 2
    dw $FE02 ; id 79 Beavern family 2
    dw $004B ; id 80 Antbear Saccer
    dw $0047 ; id 81 SuperTen Tonguella
    dw $FE02 ; id 82 IronTurt family 2
    dw $FE02 ; id 83 Mommonja family 2
    dw $FE02 ; id 84 HammerMan family 2
    dw $FE02 ; id 85 Grizzly family 2
    dw $005E ; id 86 Yeti WildApe
    dw $FE02 ; id 87 ArrowDog family 2
    dw $0057 ; id 88 NoctoKing ArrowDog
    dw $FE02 ; id 89 BeastNite family 2
    dw $FE02 ; id 90 MadGopher family 2
    dw $FE02 ; id 91 FairyRat family 2
    dw $0056 ; id 92 Unicorn Yeti
    dw $FE02 ; id 93 Goategon family 2
    dw $0048 ; id 94 WildApe Almiraj
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE02 ; id 97 DarkHorn family 2
    dw $FE02 ; id 98 MadCat family 2
    dw $FE02 ; id 99 BigEye family 2
    dw $0061 ; id 100 Gorago DarkHorn
    dw $0049 ; id 101 CatMage CatFly
    dw $0051 ; id 102 Dumbira SuperTen
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE03 ; id 106 Picky family 3
    dw $FE03 ; id 107 Wyvern family 3
    dw $FE03 ; id 108 BullBird family 3
    dw $FE03 ; id 109 Florajay family 3
    dw $FE03 ; id 110 DuckKite family 3
    dw $FE03 ; id 111 MadPecker family 3
    dw $FE03 ; id 112 MadRaven family 3
    dw $FE03 ; id 113 MistyWing family 3
    dw $FE03 ; id 114 AquaHawk family 3
    dw $006A ; id 115 Dracky Picky
    dw $006E ; id 116 KiteHawk DuckKite
    dw $FEFE ; id 117 BigRoost none
    dw $FE03 ; id 118 StubBird family 3
    dw $006C ; id 119 LandOwl BullBird
    dw $006B ; id 120 MadGoose Wyvern
    dw $0077 ; id 121 MadCondor LandOwl
    dw $006F ; id 122 Emyu MadPecker
    dw $FE03 ; id 123 Blizzardy family 3
    dw $FE03 ; id 124 Phoenix family 3
    dw $007C ; id 125 ZapBird Phoenix
    dw $007D ; id 126 Garudian ZapBird
    dw $FE03 ; id 127 WhipBird family 3
    dw $FE03 ; id 128 FunkyBird family 3
    dw $007B ; id 129 RainHawk Blizzardy
    dw $0081 ; id 130 Azurile RainHawk
    dw $007F ; id 131 Shantak WhipBird
    dw $007A ; id 132 CragDevil Emyu
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE04 ; id 141 MadPlant family 4
    dw $FE04 ; id 142 FireWeed family 4
    dw $FE04 ; id 143 FloraMan family 4
    dw $FE04 ; id 144 WingTree family 4
    dw $FE04 ; id 145 CactiBall family 4
    dw $FE04 ; id 146 Gulpple family 4
    dw $FE04 ; id 147 Toadstool family 4
    dw $FE04 ; id 148 AmberWeed family 4
    dw $FE04 ; id 149 Slurperon family 4
    dw $0094 ; id 150 Stubsuck AmberWeed
    dw $FE04 ; id 151 Oniono family 4
    dw $FE04 ; id 152 DanceVegi family 4
    dw $FE04 ; id 153 TreeBoy family 4
    dw $FE04 ; id 154 Devipine family 4
    dw $009C ; id 155 FaceTree HerbMan
    dw $FE04 ; id 156 HerbMan family 4
    dw $FE04 ; id 157 BeanMan family 4
    dw $FE04 ; id 158 EvilSeed family 4
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $0096 ; id 161 GhosTree Stubsuck
    dw $FE04 ; id 162 Rosevine family 4
    dw $00A2 ; id 163 Egdracil Rosevine
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $FE04 ; id 166 Eggplaton family 4
    dw $0099 ; id 167 FooHero TreeBoy
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE05 ; id 176 GiantSlug family 5
    dw $FE05 ; id 177 Catapila family 5
    dw $FE05 ; id 178 Gophecada family 5
    dw $FE05 ; id 179 Butterfly family 5
    dw $FE05 ; id 180 WeedBug family 5
    dw $FE05 ; id 181 GiantWorm family 5
    dw $FE05 ; id 182 Lipsy family 5
    dw $FE05 ; id 183 StagBug family 5
    dw $FE05 ; id 184 Pyuro family 5
    dw $00B0 ; id 185 ArmyAnt GiantSlug
    dw $FEFE ; id 186 GoHopper none
    dw $00B4 ; id 187 TailEater WeedBug
    dw $00B5 ; id 188 ArmorPede GiantWorm
    dw $FE05 ; id 189 Eyeder family 5
    dw $00B3 ; id 190 GiantMoth Butterfly
    dw $FE05 ; id 191 Droll family 5
    dw $FE05 ; id 192 ArmyCrab family 5
    dw $00B8 ; id 193 MadHornet Pyuro
    dw $00C1 ; id 194 Belzebub MadHornet
    dw $00C5 ; id 195 WarMantis Sickler
    dw $00B7 ; id 196 HornBeet StagBug
    dw $FE05 ; id 197 Sickler family 5
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE05 ; id 199 Digster family 5
    dw $00C6 ; id 200 Skularach Armorpion
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE06 ; id 211 Pixy family 6
    dw $FE06 ; id 212 MedusaEye family 6
    dw $00DD ; id 213 AgDevil Gremlin
    dw $FE06 ; id 214 Demonite family 6
    dw $FE06 ; id 215 DarkEye family 6
    dw $FE06 ; id 216 EyeBall family 6
    dw $FE06 ; id 217 SkulRider family 6
    dw $FE06 ; id 218 EvilBeast family 6
    dw $FE06 ; id 219 Bubblemon family 6
    dw $00D8 ; id 220 1EyeClown EyeBall
    dw $FE06 ; id 221 Gremlin family 6
    dw $00E2 ; id 222 ArcDemon Ogre
    dw $FE06 ; id 223 Lionex family 6
    dw $00DE ; id 224 GoatHorn ArcDemon
    dw $FE06 ; id 225 Orc family 6
    dw $FE06 ; id 226 Ogre family 6
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $00E0 ; id 229 BossTroll GoatHorn
    dw $FE06 ; id 230 Grendal family 6
    dw $00E6 ; id 231 Akubar Grendal
    dw $FE06 ; id 232 MadKnight family 6
    dw $00E5 ; id 233 EvilWell BossTroll
    dw $00DA ; id 234 Gigantes EvilBeast
    dw $00E2 ; id 235 Centasaur Ogre
    dw $FE06 ; id 236 EvilArmor family 6
    dw $00E7 ; id 237 Jamirus Akubar
    dw $00ED ; id 238 Durran Jamirus
    dw $00EE ; id 239 Titanis Durran
    dw $00EB ; id 240 LampGenie Centasaur
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE07 ; id 246 Spooky family 7
    dw $00FE ; id 247 Skullgon Skulpent
    dw $00FE ; id 248 PutrePup Skulpent
    dw $FE07 ; id 249 RotRaven family 7
    dw $FE07 ; id 250 Mummy family 7
    dw $FE07 ; id 251 DarkCrab family 7
    dw $FE07 ; id 252 DeadNite family 7
    dw $FE07 ; id 253 Shadow family 7
    dw $FE07 ; id 254 Skulpent family 7
    dw $00F6 ; id 255 Hork Spooky
    dw $FE07 ; id 256 Mudron family 7
    dw $FE07 ; id 257 NiteWhip family 7
    dw $FE07 ; id 258 WindMerge family 7
    dw $00F6 ; id 259 Reaper Spooky
    dw $00FF ; id 260 Inverzon Hork
    dw $0101 ; id 261 FoxFire NiteWhip
    dw $0109 ; id 262 CaptDead BoneSlave
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0107 ; id 264 WhiteKing DeadNoble
    dw $00FA ; id 265 BoneSlave Mummy
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $0108 ; id 268 Lazamanus WhiteKing
    dw $FEFE ; id 269 Copycat none
    dw $FE07 ; id 270 MadSpirit family 7
    dw $010D ; id 271 PomPomBom Copycat
    dw $010A ; id 272 Niterich Skeletor
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE08 ; id 281 JewelBag family 8
    dw $FE08 ; id 282 EvilWand family 8
    dw $FE08 ; id 283 MadCandle family 8
    dw $FE08 ; id 284 CoilBird family 8
    dw $FE08 ; id 285 Facer family 8
    dw $FE08 ; id 286 SpikyBoy family 8
    dw $FE08 ; id 287 MadMirror family 8
    dw $FE08 ; id 288 RogueNite family 8
    dw $FE08 ; id 289 Puppetor family 8
    dw $0119 ; id 290 Goopi JewelBag
    dw $0121 ; id 291 Voodoll Puppetor
    dw $FE08 ; id 292 MetalDrak family 8
    dw $FE08 ; id 293 Balzak family 8
    dw $FE08 ; id 294 SabreMan family 8
    dw $FE08 ; id 295 CurseLamp family 8
    dw $FE08 ; id 296 Brushead family 8
    dw $0126 ; id 297 Roboster SabreMan
    dw $0129 ; id 298 Roboster2 Roboster
    dw $FE08 ; id 299 EvilPot family 8
    dw $011B ; id 300 Gismo MadCandle
    dw $0124 ; id 301 LavaMan MetalDrak
    dw $0124 ; id 302 IceMan MetalDrak
    dw $FE08 ; id 303 Mimic family 8
    dw $FE08 ; id 304 Exaucers family 8
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012E ; id 309 GoldGolem IceMan
    dw $0135 ; id 310 DarkMate GoldGolem
    dw $0120 ; id 311 ProtoMech RogueNite
    dw $012C ; id 312 CloudKing Gismo
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE09 ; id 316 Petiteel family 9
    dw $FE09 ; id 317 Moray family 9
    dw $FE09 ; id 318 WalrusMan family 9
    dw $FE09 ; id 319 RayGigas family 9
    dw $FE09 ; id 320 Anemon family 9
    dw $FE09 ; id 321 Aquarella family 9
    dw $FE09 ; id 322 Merman family 9
    dw $FE09 ; id 323 Octokid family 9
    dw $FE09 ; id 324 PutreFish family 9
    dw $013C ; id 325 Octoreach Petiteel
    dw $013C ; id 326 Angleron Petiteel
    dw $0146 ; id 327 FishRider Angleron
    dw $0146 ; id 328 RushFish Angleron
    dw $0141 ; id 329 Gamanian Aquarella
    dw $0149 ; id 330 Clawster Gamanian
    dw $014A ; id 331 CancerMan Clawster
    dw $FE09 ; id 332 RogueWave family 9
    dw $014C ; id 333 Scallopa RogueWave
    dw $013C ; id 334 SeaHorse Petiteel
    dw $014B ; id 335 HoodSquid CancerMan
    dw $0142 ; id 336 MerTiger Merman
    dw $014B ; id 337 AxeShark CancerMan
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0148 ; id 340 Digong RushFish
    dw $014F ; id 341 WhaleMage HoodSquid
    dw $0154 ; id 342 Aquadon Digong
    dw $0152 ; id 343 Octoraid Octogon
    dw $FE09 ; id 344 Grakos family 9
    dw $0158 ; id 345 Poseidon Grakos
    dw $FE09 ; id 346 Pumpoise family 9
    dw $0145 ; id 347 Starfish Octoreach
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $010B ; id 351 DracoLord Servant
    dw $015F ; id 352 DracoLord DracoLord
    dw $0160 ; id 353 LordDraco DracoLord
    dw $0108 ; id 354 Hargon WhiteKing
    dw $00ED ; id 355 Sidoh Jamirus
    dw $0163 ; id 356 Genosidoh Sidoh
    dw $0162 ; id 357 Baramos Hargon
    dw $015F ; id 358 Zoma DracoLord
    dw $0166 ; id 359 AsuraZoma Zoma
    dw $00EE ; id 360 Pizzaro Durran
    dw $0168 ; id 361 PsychoPiz Pizzaro
    dw $0168 ; id 362 Esterk Pizzaro
    dw $016A ; id 363 Mirudraas Esterk
    dw $016B ; id 364 Mirudraas Mirudraas
    dw $0165 ; id 365 Mudou Baramos
    dw $016B ; id 366 DeathMore Mirudraas
    dw $016E ; id 367 DeathMore DeathMore
    dw $016F ; id 368 DeathMore DeathMore
    dw $0170 ; id 369 Darkdrium DeathMore
    dw $0169 ; id 370 Orgodemir PsychoPiz
    dw $0172 ; id 371 Orgodemir Orgodemir
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; E-0211 (C1: a second copy of MonsterPedigreeTableA, paired with MonsterPedigreeTableB_Alt at $629F; the pair differs from A/B for 7 monsters only, and its 95 family-pair entries agree with FamilyPairResultTable too; no reader found).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableA_Alt::
Data_00C_5C9F:: ; address name
    dw $FE00 ; id 0 family 0
    dw $FE00 ; id 1 DrakSlime family 0
    dw $FE00 ; id 2 SpotSlime family 0
    dw $FE00 ; id 3 WingSlime family 0
    dw $FE00 ; id 4 TreeSlime family 0
    dw $FE00 ; id 5 Snaily family 0
    dw $FE00 ; id 6 SlimeNite family 0
    dw $FE00 ; id 7 Babble family 0
    dw $FE00 ; id 8 BoxSlime family 0
    dw $FE00 ; id 9 PearlGel family 0
    dw $FEFE ; id 10 Slime none
    dw $FE00 ; id 11 Healer family 0
    dw $FE00 ; id 12 FangSlime family 0
    dw $FE00 ; id 13 RockSlime family 0
    dw $0001 ; id 14 SlimeBorg DrakSlime
    dw $FE00 ; id 15 Slabbit family 0
    dw $FE00 ; id 16 KingSlime family 0
    dw $FE00 ; id 17 Metaly family 0
    dw $0011 ; id 18 Metabble Metaly
    dw $0010 ; id 19 SpotKing KingSlime
    dw $0004 ; id 20 TropicGel TreeSlime
    dw $000B ; id 21 MimeSlime Healer
    dw $0015 ; id 22 HaloSlime MimeSlime
    dw $0013 ; id 23 MetalKing SpotKing
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE01 ; id 36 DragonKid family 1
    dw $FE01 ; id 37 Tortragon family 1
    dw $FE01 ; id 38 Pteranod family 1
    dw $FE01 ; id 39 Gasgon family 1
    dw $FE01 ; id 40 FairyDrak family 1
    dw $FE01 ; id 41 LizardMan family 1
    dw $FE01 ; id 42 Poisongon family 1
    dw $FE01 ; id 43 Swordgon family 1
    dw $FE01 ; id 44 Drygon family 1
    dw $0024 ; id 45 Dragon DragonKid
    dw $FE01 ; id 46 MiniDrak family 1
    dw $0027 ; id 47 MadDragon Gasgon
    dw $0029 ; id 48 Rayburn LizardMan
    dw $FE01 ; id 49 Chamelgon family 1
    dw $FE01 ; id 50 LizardFly family 1
    dw $FE01 ; id 51 Andreal family 1
    dw $FE01 ; id 52 KingCobra family 1
    dw $FE01 ; id 53 Vampirus family 1
    dw $0034 ; id 54 SnakeBat KingCobra
    dw $FE01 ; id 55 Spikerous family 1
    dw $002D ; id 56 GreatDrak Dragon
    dw $FE01 ; id 57 Crestpent family 1
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $0033 ; id 60 Orochi Andreal
    dw $FE01 ; id 61 BattleRex family 1
    dw $FE01 ; id 62 SkyDragon family 1
    dw $0038 ; id 63 Serpentia GreatDrak
    dw $003E ; id 64 Divinegon SkyDragon
    dw $0040 ; id 65 Orligon Divinegon
    dw $0038 ; id 66 GigaDraco GreatDrak
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE02 ; id 71 Tonguella family 2
    dw $FE02 ; id 72 Almiraj family 2
    dw $FE02 ; id 73 CatFly family 2
    dw $FE02 ; id 74 PillowRat family 2
    dw $FE02 ; id 75 Saccer family 2
    dw $0055 ; id 76 GulpBeast Grizzly
    dw $FE02 ; id 77 Skullroo family 2
    dw $FE02 ; id 78 WindBeast family 2
    dw $FE02 ; id 79 Beavern family 2
    dw $004B ; id 80 Antbear Saccer
    dw $FE02 ; id 81 SuperTen family 2
    dw $FE02 ; id 82 IronTurt family 2
    dw $FE02 ; id 83 Mommonja family 2
    dw $FE02 ; id 84 HammerMan family 2
    dw $FE02 ; id 85 Grizzly family 2
    dw $005E ; id 86 Yeti WildApe
    dw $FE02 ; id 87 ArrowDog family 2
    dw $0057 ; id 88 NoctoKing ArrowDog
    dw $FE02 ; id 89 BeastNite family 2
    dw $FE02 ; id 90 MadGopher family 2
    dw $FE02 ; id 91 FairyRat family 2
    dw $0056 ; id 92 Unicorn Yeti
    dw $FE02 ; id 93 Goategon family 2
    dw $0048 ; id 94 WildApe Almiraj
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE02 ; id 97 DarkHorn family 2
    dw $FE02 ; id 98 MadCat family 2
    dw $FE02 ; id 99 BigEye family 2
    dw $0061 ; id 100 Gorago DarkHorn
    dw $0049 ; id 101 CatMage CatFly
    dw $0051 ; id 102 Dumbira SuperTen
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE03 ; id 106 Picky family 3
    dw $FE03 ; id 107 Wyvern family 3
    dw $FE03 ; id 108 BullBird family 3
    dw $FE03 ; id 109 Florajay family 3
    dw $FE03 ; id 110 DuckKite family 3
    dw $FE03 ; id 111 MadPecker family 3
    dw $FE03 ; id 112 MadRaven family 3
    dw $FE03 ; id 113 MistyWing family 3
    dw $FE03 ; id 114 AquaHawk family 3
    dw $006A ; id 115 Dracky Picky
    dw $FE03 ; id 116 KiteHawk family 3
    dw $FEFE ; id 117 BigRoost none
    dw $FE03 ; id 118 StubBird family 3
    dw $006C ; id 119 LandOwl BullBird
    dw $006B ; id 120 MadGoose Wyvern
    dw $0077 ; id 121 MadCondor LandOwl
    dw $006F ; id 122 Emyu MadPecker
    dw $FE03 ; id 123 Blizzardy family 3
    dw $FE03 ; id 124 Phoenix family 3
    dw $007C ; id 125 ZapBird Phoenix
    dw $007D ; id 126 Garudian ZapBird
    dw $FE03 ; id 127 WhipBird family 3
    dw $FE03 ; id 128 FunkyBird family 3
    dw $007B ; id 129 RainHawk Blizzardy
    dw $0081 ; id 130 Azurile RainHawk
    dw $007F ; id 131 Shantak WhipBird
    dw $007A ; id 132 CragDevil Emyu
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE04 ; id 141 MadPlant family 4
    dw $FE04 ; id 142 FireWeed family 4
    dw $FE04 ; id 143 FloraMan family 4
    dw $FE04 ; id 144 WingTree family 4
    dw $FE04 ; id 145 CactiBall family 4
    dw $FE04 ; id 146 Gulpple family 4
    dw $FE04 ; id 147 Toadstool family 4
    dw $FE04 ; id 148 AmberWeed family 4
    dw $FE04 ; id 149 Slurperon family 4
    dw $0094 ; id 150 Stubsuck AmberWeed
    dw $FE04 ; id 151 Oniono family 4
    dw $008D ; id 152 DanceVegi MadPlant
    dw $FE04 ; id 153 TreeBoy family 4
    dw $FE04 ; id 154 Devipine family 4
    dw $FE04 ; id 155 FaceTree family 4
    dw $FE04 ; id 156 HerbMan family 4
    dw $FE04 ; id 157 BeanMan family 4
    dw $FE04 ; id 158 EvilSeed family 4
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $0096 ; id 161 GhosTree Stubsuck
    dw $FE04 ; id 162 Rosevine family 4
    dw $00A2 ; id 163 Egdracil Rosevine
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $FE04 ; id 166 Eggplaton family 4
    dw $0099 ; id 167 FooHero TreeBoy
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE05 ; id 176 GiantSlug family 5
    dw $FE05 ; id 177 Catapila family 5
    dw $FE05 ; id 178 Gophecada family 5
    dw $FE05 ; id 179 Butterfly family 5
    dw $FE05 ; id 180 WeedBug family 5
    dw $FE05 ; id 181 GiantWorm family 5
    dw $FE05 ; id 182 Lipsy family 5
    dw $FE05 ; id 183 StagBug family 5
    dw $FE05 ; id 184 Pyuro family 5
    dw $00B0 ; id 185 ArmyAnt GiantSlug
    dw $FEFE ; id 186 GoHopper none
    dw $00B4 ; id 187 TailEater WeedBug
    dw $00B5 ; id 188 ArmorPede GiantWorm
    dw $FE05 ; id 189 Eyeder family 5
    dw $00B3 ; id 190 GiantMoth Butterfly
    dw $FE05 ; id 191 Droll family 5
    dw $FE05 ; id 192 ArmyCrab family 5
    dw $00B8 ; id 193 MadHornet Pyuro
    dw $00C1 ; id 194 Belzebub MadHornet
    dw $00C5 ; id 195 WarMantis Sickler
    dw $00B7 ; id 196 HornBeet StagBug
    dw $FE05 ; id 197 Sickler family 5
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE05 ; id 199 Digster family 5
    dw $00C6 ; id 200 Skularach Armorpion
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE06 ; id 211 Pixy family 6
    dw $FE06 ; id 212 MedusaEye family 6
    dw $00DD ; id 213 AgDevil Gremlin
    dw $FE06 ; id 214 Demonite family 6
    dw $FE06 ; id 215 DarkEye family 6
    dw $FE06 ; id 216 EyeBall family 6
    dw $FE06 ; id 217 SkulRider family 6
    dw $FE06 ; id 218 EvilBeast family 6
    dw $FE06 ; id 219 Bubblemon family 6
    dw $00D8 ; id 220 1EyeClown EyeBall
    dw $FE06 ; id 221 Gremlin family 6
    dw $00E2 ; id 222 ArcDemon Ogre
    dw $FE06 ; id 223 Lionex family 6
    dw $00DE ; id 224 GoatHorn ArcDemon
    dw $FE06 ; id 225 Orc family 6
    dw $FE06 ; id 226 Ogre family 6
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $00E0 ; id 229 BossTroll GoatHorn
    dw $FE06 ; id 230 Grendal family 6
    dw $00E6 ; id 231 Akubar Grendal
    dw $FE06 ; id 232 MadKnight family 6
    dw $00E5 ; id 233 EvilWell BossTroll
    dw $00DA ; id 234 Gigantes EvilBeast
    dw $00E2 ; id 235 Centasaur Ogre
    dw $FE06 ; id 236 EvilArmor family 6
    dw $00E7 ; id 237 Jamirus Akubar
    dw $00ED ; id 238 Durran Jamirus
    dw $00EE ; id 239 Titanis Durran
    dw $00EB ; id 240 LampGenie Centasaur
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE07 ; id 246 Spooky family 7
    dw $00FE ; id 247 Skullgon Skulpent
    dw $00FE ; id 248 PutrePup Skulpent
    dw $FE07 ; id 249 RotRaven family 7
    dw $FE07 ; id 250 Mummy family 7
    dw $FE07 ; id 251 DarkCrab family 7
    dw $FE07 ; id 252 DeadNite family 7
    dw $FE07 ; id 253 Shadow family 7
    dw $FE07 ; id 254 Skulpent family 7
    dw $00F6 ; id 255 Hork Spooky
    dw $FE07 ; id 256 Mudron family 7
    dw $FE07 ; id 257 NiteWhip family 7
    dw $FE07 ; id 258 WindMerge family 7
    dw $00F6 ; id 259 Reaper Spooky
    dw $00FF ; id 260 Inverzon Hork
    dw $0101 ; id 261 FoxFire NiteWhip
    dw $0109 ; id 262 CaptDead BoneSlave
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0107 ; id 264 WhiteKing DeadNoble
    dw $00FA ; id 265 BoneSlave Mummy
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $0108 ; id 268 Lazamanus WhiteKing
    dw $FEFE ; id 269 Copycat none
    dw $FE07 ; id 270 MadSpirit family 7
    dw $010D ; id 271 PomPomBom Copycat
    dw $010A ; id 272 Niterich Skeletor
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE08 ; id 281 JewelBag family 8
    dw $FE08 ; id 282 EvilWand family 8
    dw $FE08 ; id 283 MadCandle family 8
    dw $FE08 ; id 284 CoilBird family 8
    dw $FE08 ; id 285 Facer family 8
    dw $FE08 ; id 286 SpikyBoy family 8
    dw $FE08 ; id 287 MadMirror family 8
    dw $FE08 ; id 288 RogueNite family 8
    dw $FE08 ; id 289 Puppetor family 8
    dw $0119 ; id 290 Goopi JewelBag
    dw $0121 ; id 291 Voodoll Puppetor
    dw $FE08 ; id 292 MetalDrak family 8
    dw $FE08 ; id 293 Balzak family 8
    dw $FE08 ; id 294 SabreMan family 8
    dw $FE08 ; id 295 CurseLamp family 8
    dw $FE08 ; id 296 Brushead family 8
    dw $0126 ; id 297 Roboster SabreMan
    dw $0129 ; id 298 Roboster2 Roboster
    dw $FE08 ; id 299 EvilPot family 8
    dw $011B ; id 300 Gismo MadCandle
    dw $0124 ; id 301 LavaMan MetalDrak
    dw $0124 ; id 302 IceMan MetalDrak
    dw $FE08 ; id 303 Mimic family 8
    dw $FE08 ; id 304 Exaucers family 8
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012E ; id 309 GoldGolem IceMan
    dw $0135 ; id 310 DarkMate GoldGolem
    dw $0120 ; id 311 ProtoMech RogueNite
    dw $012C ; id 312 CloudKing Gismo
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE09 ; id 316 Petiteel family 9
    dw $FE09 ; id 317 Moray family 9
    dw $FE09 ; id 318 WalrusMan family 9
    dw $FE09 ; id 319 RayGigas family 9
    dw $FE09 ; id 320 Anemon family 9
    dw $FE09 ; id 321 Aquarella family 9
    dw $FE09 ; id 322 Merman family 9
    dw $FE09 ; id 323 Octokid family 9
    dw $FE09 ; id 324 PutreFish family 9
    dw $013C ; id 325 Octoreach Petiteel
    dw $013C ; id 326 Angleron Petiteel
    dw $0146 ; id 327 FishRider Angleron
    dw $0146 ; id 328 RushFish Angleron
    dw $0141 ; id 329 Gamanian Aquarella
    dw $0149 ; id 330 Clawster Gamanian
    dw $014A ; id 331 CancerMan Clawster
    dw $FE09 ; id 332 RogueWave family 9
    dw $014C ; id 333 Scallopa RogueWave
    dw $013C ; id 334 SeaHorse Petiteel
    dw $014B ; id 335 HoodSquid CancerMan
    dw $0142 ; id 336 MerTiger Merman
    dw $014B ; id 337 AxeShark CancerMan
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0148 ; id 340 Digong RushFish
    dw $014F ; id 341 WhaleMage HoodSquid
    dw $0154 ; id 342 Aquadon Digong
    dw $0152 ; id 343 Octoraid Octogon
    dw $FE09 ; id 344 Grakos family 9
    dw $0158 ; id 345 Poseidon Grakos
    dw $FE09 ; id 346 Pumpoise family 9
    dw $0145 ; id 347 Starfish Octoreach
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $010B ; id 351 DracoLord Servant
    dw $015F ; id 352 DracoLord DracoLord
    dw $0160 ; id 353 LordDraco DracoLord
    dw $0108 ; id 354 Hargon WhiteKing
    dw $00ED ; id 355 Sidoh Jamirus
    dw $0163 ; id 356 Genosidoh Sidoh
    dw $0162 ; id 357 Baramos Hargon
    dw $015F ; id 358 Zoma DracoLord
    dw $0166 ; id 359 AsuraZoma Zoma
    dw $00EE ; id 360 Pizzaro Durran
    dw $0168 ; id 361 PsychoPiz Pizzaro
    dw $0168 ; id 362 Esterk Pizzaro
    dw $016A ; id 363 Mirudraas Esterk
    dw $016B ; id 364 Mirudraas Mirudraas
    dw $0165 ; id 365 Mudou Baramos
    dw $016B ; id 366 DeathMore Mirudraas
    dw $016E ; id 367 DeathMore DeathMore
    dw $016F ; id 368 DeathMore DeathMore
    dw $0170 ; id 369 Darkdrium DeathMore
    dw $0169 ; id 370 Orgodemir PsychoPiz
    dw $0172 ; id 371 Orgodemir Orgodemir
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; E-0211 (C1: LibraryMenu_Case10_Case06 takes the monster number from GridCellAddressFromGridCursorXAndGrid2CursorX (page base from Data_00C_5916 plus the grid position) and reads the word at $5F9F + 2 * number: the second word (vTiles2 + $390, sprite part $43); the two parents shown for the monster: for all 95 monsters whose two entries are families, FamilyPairResultTable (bank $0E) row A, column B gives that monster or parent A's species (C2 for those entries); 384 words).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableB::
Data_00C_5F9F:: ; address name
    dw $FEFE ; id 0 none
    dw $FE01 ; id 1 DrakSlime family 1
    dw $FE02 ; id 2 SpotSlime family 2
    dw $FE03 ; id 3 WingSlime family 3
    dw $FE04 ; id 4 TreeSlime family 4
    dw $FE05 ; id 5 Snaily family 5
    dw $FE06 ; id 6 SlimeNite family 6
    dw $FE07 ; id 7 Babble family 7
    dw $FE08 ; id 8 BoxSlime family 8
    dw $FE09 ; id 9 PearlGel family 9
    dw $FEFE ; id 10 Slime none
    dw $004A ; id 11 Healer PillowRat
    dw $0048 ; id 12 FangSlime Almiraj
    dw $0132 ; id 13 RockSlime Golem
    dw $002B ; id 14 SlimeBorg Swordgon
    dw $004D ; id 15 Slabbit Skullroo
    dw $FE0A ; id 16 KingSlime family 10
    dw $0124 ; id 17 Metaly MetalDrak
    dw $0011 ; id 18 Metabble Metaly
    dw $005C ; id 19 SpotKing Unicorn
    dw $FE02 ; id 20 TropicGel family 2
    dw $00DC ; id 21 MimeSlime 1EyeClown
    dw $FE07 ; id 22 HaloSlime family 7
    dw $0124 ; id 23 MetalKing MetalDrak
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE00 ; id 36 DragonKid family 0
    dw $FE02 ; id 37 Tortragon family 2
    dw $FE03 ; id 38 Pteranod family 3
    dw $FE04 ; id 39 Gasgon family 4
    dw $FE05 ; id 40 FairyDrak family 5
    dw $FE06 ; id 41 LizardMan family 6
    dw $FE07 ; id 42 Poisongon family 7
    dw $FE08 ; id 43 Swordgon family 8
    dw $FE09 ; id 44 Drygon family 9
    dw $0024 ; id 45 Dragon DragonKid
    dw $006A ; id 46 MiniDrak Picky
    dw $FE02 ; id 47 MadDragon family 2
    dw $0003 ; id 48 Rayburn WingSlime
    dw $0123 ; id 49 Chamelgon Voodoll
    dw $00BA ; id 50 LizardFly GoHopper
    dw $0092 ; id 51 Andreal Gulpple
    dw $0007 ; id 52 KingCobra Babble
    dw $0078 ; id 53 Vampirus MadGoose
    dw $0073 ; id 54 SnakeBat Dracky
    dw $00C0 ; id 55 Spikerous ArmyCrab
    dw $002D ; id 56 GreatDrak Dragon
    dw $0075 ; id 57 Crestpent BigRoost
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $00D4 ; id 60 Orochi MedusaEye
    dw $00E8 ; id 61 BattleRex MadKnight
    dw $007C ; id 62 SkyDragon Phoenix
    dw $00DF ; id 63 Serpentia Lionex
    dw $003C ; id 64 Divinegon Orochi
    dw $0135 ; id 65 Orligon GoldGolem
    dw $00EA ; id 66 GigaDraco Gigantes
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE00 ; id 71 Tonguella family 0
    dw $FE01 ; id 72 Almiraj family 1
    dw $FE03 ; id 73 CatFly family 3
    dw $FE04 ; id 74 PillowRat family 4
    dw $FE05 ; id 75 Saccer family 5
    dw $FE01 ; id 76 GulpBeast family 1
    dw $FE07 ; id 77 Skullroo family 7
    dw $FE08 ; id 78 WindBeast family 8
    dw $FE09 ; id 79 Beavern family 9
    dw $FE01 ; id 80 Antbear family 1
    dw $00D6 ; id 81 SuperTen Demonite
    dw $0025 ; id 82 IronTurt Tortragon
    dw $006E ; id 83 Mommonja DuckKite
    dw $0096 ; id 84 HammerMan Stubsuck
    dw $FE06 ; id 85 Grizzly family 6
    dw $002B ; id 86 Yeti Swordgon
    dw $00F8 ; id 87 ArrowDog PutrePup
    dw $00FD ; id 88 NoctoKing Shadow
    dw $00EC ; id 89 BeastNite EvilArmor
    dw $0126 ; id 90 MadGopher SabreMan
    dw $0032 ; id 91 FairyRat LizardFly
    dw $FE00 ; id 92 Unicorn family 0
    dw $0029 ; id 93 Goategon LizardMan
    dw $FE01 ; id 94 WildApe family 1
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE0A ; id 97 DarkHorn family 10
    dw $002D ; id 98 MadCat Dragon
    dw $00D8 ; id 99 BigEye EyeBall
    dw $003C ; id 100 Gorago Orochi
    dw $0099 ; id 101 CatMage TreeBoy
    dw $0126 ; id 102 Dumbira SabreMan
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE00 ; id 106 Picky family 0
    dw $FE01 ; id 107 Wyvern family 1
    dw $FE02 ; id 108 BullBird family 2
    dw $FE04 ; id 109 Florajay family 4
    dw $FE05 ; id 110 DuckKite family 5
    dw $FE06 ; id 111 MadPecker family 6
    dw $FE07 ; id 112 MadRaven family 7
    dw $FE08 ; id 113 MistyWing family 8
    dw $FE09 ; id 114 AquaHawk family 9
    dw $FE00 ; id 115 Dracky family 0
    dw $FE08 ; id 116 KiteHawk family 8
    dw $FEFE ; id 117 BigRoost none
    dw $000D ; id 118 StubBird RockSlime
    dw $FE06 ; id 119 LandOwl family 6
    dw $FE07 ; id 120 MadGoose family 7
    dw $FE06 ; id 121 MadCondor family 6
    dw $00D7 ; id 122 Emyu DarkEye
    dw $0011 ; id 123 Blizzardy Metaly
    dw $0001 ; id 124 Phoenix DrakSlime
    dw $012C ; id 125 ZapBird Gismo
    dw $00DF ; id 126 Garudian Lionex
    dw $0030 ; id 127 WhipBird Rayburn
    dw $0098 ; id 128 FunkyBird DanceVegi
    dw $007C ; id 129 RainHawk Phoenix
    dw $FE0A ; id 130 Azurile family 10
    dw $0038 ; id 131 Shantak GreatDrak
    dw $FE02 ; id 132 CragDevil family 2
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE00 ; id 141 MadPlant family 0
    dw $FE01 ; id 142 FireWeed family 1
    dw $FE02 ; id 143 FloraMan family 2
    dw $FE03 ; id 144 WingTree family 3
    dw $FE05 ; id 145 CactiBall family 5
    dw $FE06 ; id 146 Gulpple family 6
    dw $FE07 ; id 147 Toadstool family 7
    dw $FE08 ; id 148 AmberWeed family 8
    dw $FE09 ; id 149 Slurperon family 9
    dw $FE02 ; id 150 Stubsuck family 2
    dw $0140 ; id 151 Oniono Anemon
    dw $011D ; id 152 DanceVegi Facer
    dw $00D3 ; id 153 TreeBoy Pixy
    dw $0092 ; id 154 Devipine Gulpple
    dw $FE01 ; id 155 FaceTree family 1
    dw $0080 ; id 156 HerbMan FunkyBird
    dw $004A ; id 157 BeanMan PillowRat
    dw $000D ; id 158 EvilSeed RockSlime
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $FE07 ; id 161 GhosTree family 7
    dw $FE0A ; id 162 Rosevine family 10
    dw $00EA ; id 163 Egdracil Gigantes
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $00B6 ; id 166 Eggplaton Lipsy
    dw $0006 ; id 167 FooHero SlimeNite
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE00 ; id 176 GiantSlug family 0
    dw $FE01 ; id 177 Catapila family 1
    dw $FE02 ; id 178 Gophecada family 2
    dw $FE03 ; id 179 Butterfly family 3
    dw $FE04 ; id 180 WeedBug family 4
    dw $FE06 ; id 181 GiantWorm family 6
    dw $FE07 ; id 182 Lipsy family 7
    dw $FE08 ; id 183 StagBug family 8
    dw $FE09 ; id 184 Pyuro family 9
    dw $FE00 ; id 185 ArmyAnt family 0
    dw $FEFE ; id 186 GoHopper none
    dw $FE04 ; id 187 TailEater family 4
    dw $FE08 ; id 188 ArmorPede family 8
    dw $0149 ; id 189 Eyeder Gamanian
    dw $FE06 ; id 190 GiantMoth family 6
    dw $00F6 ; id 191 Droll Spooky
    dw $00FB ; id 192 ArmyCrab DarkCrab
    dw $FE07 ; id 193 MadHornet family 7
    dw $FE07 ; id 194 Belzebub family 7
    dw $FE06 ; id 195 WarMantis family 6
    dw $00B7 ; id 196 HornBeet StagBug
    dw $00DC ; id 197 Sickler 1EyeClown
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE0A ; id 199 Digster family 10
    dw $0108 ; id 200 Skularach WhiteKing
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE00 ; id 211 Pixy family 0
    dw $FE01 ; id 212 MedusaEye family 1
    dw $FE01 ; id 213 AgDevil family 1
    dw $FE03 ; id 214 Demonite family 3
    dw $FE04 ; id 215 DarkEye family 4
    dw $FE05 ; id 216 EyeBall family 5
    dw $FE07 ; id 217 SkulRider family 7
    dw $FE08 ; id 218 EvilBeast family 8
    dw $FE09 ; id 219 Bubblemon family 9
    dw $FE00 ; id 220 1EyeClown family 0
    dw $FE02 ; id 221 Gremlin family 2
    dw $FE01 ; id 222 ArcDemon family 1
    dw $0029 ; id 223 Lionex LizardMan
    dw $FE02 ; id 224 GoatHorn family 2
    dw $009D ; id 225 Orc BeanMan
    dw $0054 ; id 226 Ogre HammerMan
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $FE02 ; id 229 BossTroll family 2
    dw $0059 ; id 230 Grendal BeastNite
    dw $00E6 ; id 231 Akubar Grendal
    dw $0120 ; id 232 MadKnight RogueNite
    dw $012E ; id 233 EvilWell IceMan
    dw $FE07 ; id 234 Gigantes family 7
    dw $FE02 ; id 235 Centasaur family 2
    dw $00BC ; id 236 EvilArmor ArmorPede
    dw $0081 ; id 237 Jamirus RainHawk
    dw $003F ; id 238 Durran Serpentia
    dw $0061 ; id 239 Titanis DarkHorn
    dw $FE0A ; id 240 LampGenie family 10
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE00 ; id 246 Spooky family 0
    dw $FE01 ; id 247 Skullgon family 1
    dw $FE02 ; id 248 PutrePup family 2
    dw $FE03 ; id 249 RotRaven family 3
    dw $FE04 ; id 250 Mummy family 4
    dw $FE05 ; id 251 DarkCrab family 5
    dw $FE06 ; id 252 DeadNite family 6
    dw $FE08 ; id 253 Shadow family 8
    dw $FE09 ; id 254 Skulpent family 9
    dw $FE02 ; id 255 Hork family 2
    dw $00BF ; id 256 Mudron Droll
    dw $0071 ; id 257 NiteWhip MistyWing
    dw $004E ; id 258 WindMerge WindBeast
    dw $FE06 ; id 259 Reaper family 6
    dw $00FF ; id 260 Inverzon Hork
    dw $FE02 ; id 261 FoxFire family 2
    dw $FE09 ; id 262 CaptDead family 9
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0013 ; id 264 WhiteKing SpotKing
    dw $008F ; id 265 BoneSlave FloraMan
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $015F ; id 268 Lazamanus DracoLord
    dw $FEFE ; id 269 Copycat none
    dw $FE01 ; id 270 MadSpirit family 1
    dw $0027 ; id 271 PomPomBom Gasgon
    dw $012A ; id 272 Niterich Roboster2
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE00 ; id 281 JewelBag family 0
    dw $FE01 ; id 282 EvilWand family 1
    dw $FE02 ; id 283 MadCandle family 2
    dw $FE03 ; id 284 CoilBird family 3
    dw $FE04 ; id 285 Facer family 4
    dw $FE05 ; id 286 SpikyBoy family 5
    dw $FE06 ; id 287 MadMirror family 6
    dw $FE07 ; id 288 RogueNite family 7
    dw $00DD ; id 289 Puppetor Gremlin
    dw $FE08 ; id 290 Goopi family 8
    dw $FE06 ; id 291 Voodoll family 6
    dw $0033 ; id 292 MetalDrak Andreal
    dw $FE0A ; id 293 Balzak family 10
    dw $00B5 ; id 294 SabreMan GiantWorm
    dw $0090 ; id 295 CurseLamp WingTree
    dw $FE09 ; id 296 Brushead family 9
    dw $000E ; id 297 Roboster SlimeBorg
    dw $0129 ; id 298 Roboster2 Roboster
    dw $0005 ; id 299 EvilPot Snaily
    dw $006B ; id 300 Gismo Wyvern
    dw $007D ; id 301 LavaMan ZapBird
    dw $00F7 ; id 302 IceMan Skullgon
    dw $0008 ; id 303 Mimic BoxSlime
    dw $0073 ; id 304 Exaucers Dracky
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012D ; id 309 GoldGolem LavaMan
    dw $0017 ; id 310 DarkMate MetalKing
    dw $FE06 ; id 311 ProtoMech family 6
    dw $003E ; id 312 CloudKing SkyDragon
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE00 ; id 316 Petiteel family 0
    dw $FE01 ; id 317 Moray family 1
    dw $FE02 ; id 318 WalrusMan family 2
    dw $FE03 ; id 319 RayGigas family 3
    dw $FE04 ; id 320 Anemon family 4
    dw $FE05 ; id 321 Aquarella family 5
    dw $FE06 ; id 322 Merman family 6
    dw $FE08 ; id 323 Octokid family 8
    dw $FE07 ; id 324 PutreFish family 7
    dw $FE02 ; id 325 Octoreach family 2
    dw $FE08 ; id 326 Angleron family 8
    dw $00D9 ; id 327 FishRider SkulRider
    dw $FE01 ; id 328 RushFish family 1
    dw $FE05 ; id 329 Gamanian family 5
    dw $00C0 ; id 330 Clawster ArmyCrab
    dw $014A ; id 331 CancerMan Clawster
    dw $0119 ; id 332 RogueWave JewelBag
    dw $FE06 ; id 333 Scallopa family 6
    dw $FE01 ; id 334 SeaHorse family 1
    dw $0155 ; id 335 HoodSquid WhaleMage
    dw $0062 ; id 336 MerTiger MadCat
    dw $003D ; id 337 AxeShark BattleRex
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0037 ; id 340 Digong Spikerous
    dw $00DC ; id 341 WhaleMage 1EyeClown
    dw $0038 ; id 342 Aquadon GreatDrak
    dw $00DF ; id 343 Octoraid Lionex
    dw $FE0A ; id 344 Grakos family 10
    dw $016D ; id 345 Poseidon Mudou
    dw $011E ; id 346 Pumpoise SpikyBoy
    dw $FE00 ; id 347 Starfish family 0
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $0033 ; id 351 DracoLord Andreal
    dw $0040 ; id 352 DracoLord Divinegon
    dw $0041 ; id 353 LordDraco Orligon
    dw $0017 ; id 354 Hargon MetalKing
    dw $00A2 ; id 355 Sidoh Rosevine
    dw $00EF ; id 356 Genosidoh Titanis
    dw $003C ; id 357 Baramos Orochi
    dw $0163 ; id 358 Zoma Sidoh
    dw $0169 ; id 359 AsuraZoma PsychoPiz
    dw $0040 ; id 360 Pizzaro Divinegon
    dw $016A ; id 361 PsychoPiz Esterk
    dw $0064 ; id 362 Esterk Gorago
    dw $0018 ; id 363 Mirudraas GoldSlime
    dw $0041 ; id 364 Mirudraas Orligon
    dw $0064 ; id 365 Mudou Gorago
    dw $0082 ; id 366 DeathMore Azurile
    dw $00EF ; id 367 DeathMore Titanis
    dw $0136 ; id 368 DeathMore DarkMate
    dw $0019 ; id 369 Darkdrium GranSlime
    dw $0110 ; id 370 Orgodemir Niterich
    dw $0161 ; id 371 Orgodemir LordDraco
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; E-0211 (C1: the partner of MonsterPedigreeTableA_Alt, a variant of MonsterPedigreeTableB; 384 words end at ArenaMenu ($659F); no reader found).
; record: monster id, or $FExx = any monster of family xx ($FEFE = none)
MonsterPedigreeTableB_Alt::
Data_00C_629F:: ; address name
    dw $FEFE ; id 0 none
    dw $FE01 ; id 1 DrakSlime family 1
    dw $FE02 ; id 2 SpotSlime family 2
    dw $FE03 ; id 3 WingSlime family 3
    dw $FE04 ; id 4 TreeSlime family 4
    dw $FE05 ; id 5 Snaily family 5
    dw $FE06 ; id 6 SlimeNite family 6
    dw $FE07 ; id 7 Babble family 7
    dw $FE08 ; id 8 BoxSlime family 8
    dw $FE09 ; id 9 PearlGel family 9
    dw $FEFE ; id 10 Slime none
    dw $004A ; id 11 Healer PillowRat
    dw $0048 ; id 12 FangSlime Almiraj
    dw $0132 ; id 13 RockSlime Golem
    dw $002B ; id 14 SlimeBorg Swordgon
    dw $004D ; id 15 Slabbit Skullroo
    dw $FE0A ; id 16 KingSlime family 10
    dw $0124 ; id 17 Metaly MetalDrak
    dw $0011 ; id 18 Metabble Metaly
    dw $005C ; id 19 SpotKing Unicorn
    dw $FE02 ; id 20 TropicGel family 2
    dw $00DC ; id 21 MimeSlime 1EyeClown
    dw $FE07 ; id 22 HaloSlime family 7
    dw $0124 ; id 23 MetalKing MetalDrak
    dw $0017 ; id 24 GoldSlime MetalKing
    dw $0018 ; id 25 GranSlime GoldSlime
    dw $FEFE ; id 26 WonderEgg none
    dw $FEFE ; id 27 Butch none
    dw $FEFE ; id 28 ? none
    dw $FEFE ; id 29 ? none
    dw $FEFE ; id 30 ? none
    dw $FEFE ; id 31 ? none
    dw $FEFE ; id 32 ? none
    dw $FEFE ; id 33 ? none
    dw $FEFE ; id 34 ? none
    dw $FEFE ; id 35 ? none
    dw $FE00 ; id 36 DragonKid family 0
    dw $FE02 ; id 37 Tortragon family 2
    dw $FE03 ; id 38 Pteranod family 3
    dw $FE04 ; id 39 Gasgon family 4
    dw $FE05 ; id 40 FairyDrak family 5
    dw $FE06 ; id 41 LizardMan family 6
    dw $FE07 ; id 42 Poisongon family 7
    dw $FE08 ; id 43 Swordgon family 8
    dw $FE09 ; id 44 Drygon family 9
    dw $0024 ; id 45 Dragon DragonKid
    dw $006A ; id 46 MiniDrak Picky
    dw $FE02 ; id 47 MadDragon family 2
    dw $0003 ; id 48 Rayburn WingSlime
    dw $0123 ; id 49 Chamelgon Voodoll
    dw $00BA ; id 50 LizardFly GoHopper
    dw $0092 ; id 51 Andreal Gulpple
    dw $0007 ; id 52 KingCobra Babble
    dw $0078 ; id 53 Vampirus MadGoose
    dw $0073 ; id 54 SnakeBat Dracky
    dw $00C0 ; id 55 Spikerous ArmyCrab
    dw $002D ; id 56 GreatDrak Dragon
    dw $0075 ; id 57 Crestpent BigRoost
    dw $0039 ; id 58 WingSnake Crestpent
    dw $003A ; id 59 Coatol WingSnake
    dw $00D4 ; id 60 Orochi MedusaEye
    dw $00E8 ; id 61 BattleRex MadKnight
    dw $007C ; id 62 SkyDragon Phoenix
    dw $00DF ; id 63 Serpentia Lionex
    dw $003C ; id 64 Divinegon Orochi
    dw $0135 ; id 65 Orligon GoldGolem
    dw $00EA ; id 66 GigaDraco Gigantes
    dw $FEFE ; id 67 ? none
    dw $FEFE ; id 68 ? none
    dw $FEFE ; id 69 ? none
    dw $FEFE ; id 70 ? none
    dw $FE00 ; id 71 Tonguella family 0
    dw $FE01 ; id 72 Almiraj family 1
    dw $FE03 ; id 73 CatFly family 3
    dw $FE04 ; id 74 PillowRat family 4
    dw $FE05 ; id 75 Saccer family 5
    dw $FE01 ; id 76 GulpBeast family 1
    dw $FE07 ; id 77 Skullroo family 7
    dw $FE08 ; id 78 WindBeast family 8
    dw $FE09 ; id 79 Beavern family 9
    dw $FE01 ; id 80 Antbear family 1
    dw $0100 ; id 81 SuperTen Mudron
    dw $0025 ; id 82 IronTurt Tortragon
    dw $006E ; id 83 Mommonja DuckKite
    dw $0096 ; id 84 HammerMan Stubsuck
    dw $FE06 ; id 85 Grizzly family 6
    dw $002B ; id 86 Yeti Swordgon
    dw $00F8 ; id 87 ArrowDog PutrePup
    dw $00FD ; id 88 NoctoKing Shadow
    dw $00EC ; id 89 BeastNite EvilArmor
    dw $0126 ; id 90 MadGopher SabreMan
    dw $0032 ; id 91 FairyRat LizardFly
    dw $FE00 ; id 92 Unicorn family 0
    dw $0029 ; id 93 Goategon LizardMan
    dw $FE01 ; id 94 WildApe family 1
    dw $005E ; id 95 Trumpeter WildApe
    dw $005F ; id 96 KingLeo Trumpeter
    dw $FE0A ; id 97 DarkHorn family 10
    dw $002D ; id 98 MadCat Dragon
    dw $00D8 ; id 99 BigEye EyeBall
    dw $003C ; id 100 Gorago Orochi
    dw $0099 ; id 101 CatMage TreeBoy
    dw $0126 ; id 102 Dumbira SabreMan
    dw $FEFE ; id 103 ? none
    dw $FEFE ; id 104 ? none
    dw $FEFE ; id 105 ? none
    dw $FE00 ; id 106 Picky family 0
    dw $FE01 ; id 107 Wyvern family 1
    dw $FE02 ; id 108 BullBird family 2
    dw $FE04 ; id 109 Florajay family 4
    dw $FE05 ; id 110 DuckKite family 5
    dw $FE06 ; id 111 MadPecker family 6
    dw $FE07 ; id 112 MadRaven family 7
    dw $FE08 ; id 113 MistyWing family 8
    dw $FE09 ; id 114 AquaHawk family 9
    dw $FE00 ; id 115 Dracky family 0
    dw $011D ; id 116 KiteHawk Facer
    dw $FEFE ; id 117 BigRoost none
    dw $000D ; id 118 StubBird RockSlime
    dw $FE06 ; id 119 LandOwl family 6
    dw $FE07 ; id 120 MadGoose family 7
    dw $FE06 ; id 121 MadCondor family 6
    dw $00D7 ; id 122 Emyu DarkEye
    dw $0011 ; id 123 Blizzardy Metaly
    dw $0001 ; id 124 Phoenix DrakSlime
    dw $012C ; id 125 ZapBird Gismo
    dw $00DF ; id 126 Garudian Lionex
    dw $0030 ; id 127 WhipBird Rayburn
    dw $0128 ; id 128 FunkyBird Brushead
    dw $007C ; id 129 RainHawk Phoenix
    dw $FE0A ; id 130 Azurile family 10
    dw $0038 ; id 131 Shantak GreatDrak
    dw $FE02 ; id 132 CragDevil family 2
    dw $FEFE ; id 133 ? none
    dw $FEFE ; id 134 ? none
    dw $FEFE ; id 135 ? none
    dw $FEFE ; id 136 ? none
    dw $FEFE ; id 137 ? none
    dw $FEFE ; id 138 ? none
    dw $FEFE ; id 139 ? none
    dw $FEFE ; id 140 ? none
    dw $FE00 ; id 141 MadPlant family 0
    dw $FE01 ; id 142 FireWeed family 1
    dw $FE02 ; id 143 FloraMan family 2
    dw $FE03 ; id 144 WingTree family 3
    dw $FE05 ; id 145 CactiBall family 5
    dw $FE06 ; id 146 Gulpple family 6
    dw $FE07 ; id 147 Toadstool family 7
    dw $FE08 ; id 148 AmberWeed family 8
    dw $FE09 ; id 149 Slurperon family 9
    dw $FE02 ; id 150 Stubsuck family 2
    dw $00B2 ; id 151 Oniono Gophecada
    dw $FE02 ; id 152 DanceVegi family 2
    dw $00D3 ; id 153 TreeBoy Pixy
    dw $0092 ; id 154 Devipine Gulpple
    dw $0101 ; id 155 FaceTree NiteWhip
    dw $0080 ; id 156 HerbMan FunkyBird
    dw $004A ; id 157 BeanMan PillowRat
    dw $000D ; id 158 EvilSeed RockSlime
    dw $009E ; id 159 ManEater EvilSeed
    dw $009F ; id 160 Snapper ManEater
    dw $FE07 ; id 161 GhosTree family 7
    dw $FE0A ; id 162 Rosevine family 10
    dw $00EA ; id 163 Egdracil Gigantes
    dw $FEFE ; id 164 Warubou none
    dw $FEFE ; id 165 Watabou none
    dw $00B6 ; id 166 Eggplaton Lipsy
    dw $0006 ; id 167 FooHero SlimeNite
    dw $FEFE ; id 168 ? none
    dw $FEFE ; id 169 ? none
    dw $FEFE ; id 170 ? none
    dw $FEFE ; id 171 ? none
    dw $FEFE ; id 172 ? none
    dw $FEFE ; id 173 ? none
    dw $FEFE ; id 174 ? none
    dw $FEFE ; id 175 ? none
    dw $FE00 ; id 176 GiantSlug family 0
    dw $FE01 ; id 177 Catapila family 1
    dw $FE02 ; id 178 Gophecada family 2
    dw $FE03 ; id 179 Butterfly family 3
    dw $FE04 ; id 180 WeedBug family 4
    dw $FE06 ; id 181 GiantWorm family 6
    dw $FE07 ; id 182 Lipsy family 7
    dw $FE08 ; id 183 StagBug family 8
    dw $FE09 ; id 184 Pyuro family 9
    dw $FE00 ; id 185 ArmyAnt family 0
    dw $FEFE ; id 186 GoHopper none
    dw $FE04 ; id 187 TailEater family 4
    dw $FE08 ; id 188 ArmorPede family 8
    dw $0145 ; id 189 Eyeder Octoreach
    dw $FE06 ; id 190 GiantMoth family 6
    dw $00F6 ; id 191 Droll Spooky
    dw $00FB ; id 192 ArmyCrab DarkCrab
    dw $FE07 ; id 193 MadHornet family 7
    dw $FE07 ; id 194 Belzebub family 7
    dw $FE06 ; id 195 WarMantis family 6
    dw $00B7 ; id 196 HornBeet StagBug
    dw $00DC ; id 197 Sickler 1EyeClown
    dw $00C4 ; id 198 Armorpion HornBeet
    dw $FE0A ; id 199 Digster family 10
    dw $0108 ; id 200 Skularach WhiteKing
    dw $00B1 ; id 201 MultiEyes Catapila
    dw $FEFE ; id 202 ? none
    dw $FEFE ; id 203 ? none
    dw $FEFE ; id 204 ? none
    dw $FEFE ; id 205 ? none
    dw $FEFE ; id 206 ? none
    dw $FEFE ; id 207 ? none
    dw $FEFE ; id 208 ? none
    dw $FEFE ; id 209 ? none
    dw $FEFE ; id 210 ? none
    dw $FE00 ; id 211 Pixy family 0
    dw $FE01 ; id 212 MedusaEye family 1
    dw $FE01 ; id 213 AgDevil family 1
    dw $FE03 ; id 214 Demonite family 3
    dw $FE04 ; id 215 DarkEye family 4
    dw $FE05 ; id 216 EyeBall family 5
    dw $FE07 ; id 217 SkulRider family 7
    dw $FE08 ; id 218 EvilBeast family 8
    dw $FE09 ; id 219 Bubblemon family 9
    dw $FE00 ; id 220 1EyeClown family 0
    dw $FE02 ; id 221 Gremlin family 2
    dw $FE01 ; id 222 ArcDemon family 1
    dw $0029 ; id 223 Lionex LizardMan
    dw $FE02 ; id 224 GoatHorn family 2
    dw $009D ; id 225 Orc BeanMan
    dw $0054 ; id 226 Ogre HammerMan
    dw $00D6 ; id 227 GateGuard Demonite
    dw $00DC ; id 228 ChopClown 1EyeClown
    dw $FE02 ; id 229 BossTroll family 2
    dw $0059 ; id 230 Grendal BeastNite
    dw $00E6 ; id 231 Akubar Grendal
    dw $0120 ; id 232 MadKnight RogueNite
    dw $012E ; id 233 EvilWell IceMan
    dw $FE07 ; id 234 Gigantes family 7
    dw $FE02 ; id 235 Centasaur family 2
    dw $00BC ; id 236 EvilArmor ArmorPede
    dw $0081 ; id 237 Jamirus RainHawk
    dw $003F ; id 238 Durran Serpentia
    dw $0061 ; id 239 Titanis DarkHorn
    dw $FE0A ; id 240 LampGenie family 10
    dw $FEFE ; id 241 ? none
    dw $FEFE ; id 242 ? none
    dw $FEFE ; id 243 ? none
    dw $FEFE ; id 244 ? none
    dw $FEFE ; id 245 ? none
    dw $FE00 ; id 246 Spooky family 0
    dw $FE01 ; id 247 Skullgon family 1
    dw $FE02 ; id 248 PutrePup family 2
    dw $FE03 ; id 249 RotRaven family 3
    dw $FE04 ; id 250 Mummy family 4
    dw $FE05 ; id 251 DarkCrab family 5
    dw $FE06 ; id 252 DeadNite family 6
    dw $FE08 ; id 253 Shadow family 8
    dw $FE09 ; id 254 Skulpent family 9
    dw $FE02 ; id 255 Hork family 2
    dw $00BF ; id 256 Mudron Droll
    dw $0071 ; id 257 NiteWhip MistyWing
    dw $004E ; id 258 WindMerge WindBeast
    dw $FE06 ; id 259 Reaper family 6
    dw $00FF ; id 260 Inverzon Hork
    dw $FE02 ; id 261 FoxFire family 2
    dw $FE09 ; id 262 CaptDead family 9
    dw $00FC ; id 263 DeadNoble DeadNite
    dw $0013 ; id 264 WhiteKing SpotKing
    dw $008F ; id 265 BoneSlave FloraMan
    dw $0109 ; id 266 Skeletor BoneSlave
    dw $010A ; id 267 Servant Skeletor
    dw $015F ; id 268 Lazamanus DracoLord
    dw $FEFE ; id 269 Copycat none
    dw $FE01 ; id 270 MadSpirit family 1
    dw $0027 ; id 271 PomPomBom Gasgon
    dw $012A ; id 272 Niterich Roboster2
    dw $FEFE ; id 273 ? none
    dw $FEFE ; id 274 ? none
    dw $FEFE ; id 275 ? none
    dw $FEFE ; id 276 ? none
    dw $FEFE ; id 277 ? none
    dw $FEFE ; id 278 ? none
    dw $FEFE ; id 279 ? none
    dw $FEFE ; id 280 ? none
    dw $FE00 ; id 281 JewelBag family 0
    dw $FE01 ; id 282 EvilWand family 1
    dw $FE02 ; id 283 MadCandle family 2
    dw $FE03 ; id 284 CoilBird family 3
    dw $FE04 ; id 285 Facer family 4
    dw $FE05 ; id 286 SpikyBoy family 5
    dw $FE06 ; id 287 MadMirror family 6
    dw $FE07 ; id 288 RogueNite family 7
    dw $00DD ; id 289 Puppetor Gremlin
    dw $FE08 ; id 290 Goopi family 8
    dw $FE06 ; id 291 Voodoll family 6
    dw $0033 ; id 292 MetalDrak Andreal
    dw $FE0A ; id 293 Balzak family 10
    dw $00B5 ; id 294 SabreMan GiantWorm
    dw $0090 ; id 295 CurseLamp WingTree
    dw $FE09 ; id 296 Brushead family 9
    dw $000E ; id 297 Roboster SlimeBorg
    dw $0129 ; id 298 Roboster2 Roboster
    dw $0005 ; id 299 EvilPot Snaily
    dw $006B ; id 300 Gismo Wyvern
    dw $007D ; id 301 LavaMan ZapBird
    dw $00F7 ; id 302 IceMan Skullgon
    dw $0008 ; id 303 Mimic BoxSlime
    dw $0073 ; id 304 Exaucers Dracky
    dw $0122 ; id 305 MudDoll Goopi
    dw $0131 ; id 306 Golem MudDoll
    dw $0132 ; id 307 StoneMan Golem
    dw $011E ; id 308 BombCrag SpikyBoy
    dw $012D ; id 309 GoldGolem LavaMan
    dw $0017 ; id 310 DarkMate MetalKing
    dw $FE06 ; id 311 ProtoMech family 6
    dw $003E ; id 312 CloudKing SkyDragon
    dw $FEFE ; id 313 ? none
    dw $FEFE ; id 314 ? none
    dw $FEFE ; id 315 ? none
    dw $FE00 ; id 316 Petiteel family 0
    dw $FE01 ; id 317 Moray family 1
    dw $FE02 ; id 318 WalrusMan family 2
    dw $FE03 ; id 319 RayGigas family 3
    dw $FE04 ; id 320 Anemon family 4
    dw $FE05 ; id 321 Aquarella family 5
    dw $FE06 ; id 322 Merman family 6
    dw $FE08 ; id 323 Octokid family 8
    dw $FE07 ; id 324 PutreFish family 7
    dw $FE02 ; id 325 Octoreach family 2
    dw $FE08 ; id 326 Angleron family 8
    dw $00D9 ; id 327 FishRider SkulRider
    dw $FE01 ; id 328 RushFish family 1
    dw $FE05 ; id 329 Gamanian family 5
    dw $00C0 ; id 330 Clawster ArmyCrab
    dw $014A ; id 331 CancerMan Clawster
    dw $0119 ; id 332 RogueWave JewelBag
    dw $FE06 ; id 333 Scallopa family 6
    dw $FE01 ; id 334 SeaHorse family 1
    dw $0155 ; id 335 HoodSquid WhaleMage
    dw $0062 ; id 336 MerTiger MadCat
    dw $003D ; id 337 AxeShark BattleRex
    dw $0145 ; id 338 Octogon Octoreach
    dw $0152 ; id 339 KingSquid Octogon
    dw $0037 ; id 340 Digong Spikerous
    dw $00DC ; id 341 WhaleMage 1EyeClown
    dw $0038 ; id 342 Aquadon GreatDrak
    dw $00DF ; id 343 Octoraid Lionex
    dw $FE0A ; id 344 Grakos family 10
    dw $016D ; id 345 Poseidon Mudou
    dw $011E ; id 346 Pumpoise SpikyBoy
    dw $FE00 ; id 347 Starfish family 0
    dw $FEFE ; id 348 ? none
    dw $FEFE ; id 349 ? none
    dw $FEFE ; id 350 ? none
    dw $0033 ; id 351 DracoLord Andreal
    dw $0040 ; id 352 DracoLord Divinegon
    dw $0041 ; id 353 LordDraco Orligon
    dw $0017 ; id 354 Hargon MetalKing
    dw $00A2 ; id 355 Sidoh Rosevine
    dw $00EF ; id 356 Genosidoh Titanis
    dw $003C ; id 357 Baramos Orochi
    dw $0163 ; id 358 Zoma Sidoh
    dw $0169 ; id 359 AsuraZoma PsychoPiz
    dw $0040 ; id 360 Pizzaro Divinegon
    dw $016A ; id 361 PsychoPiz Esterk
    dw $0064 ; id 362 Esterk Gorago
    dw $0018 ; id 363 Mirudraas GoldSlime
    dw $0041 ; id 364 Mirudraas Orligon
    dw $0064 ; id 365 Mudou Gorago
    dw $0082 ; id 366 DeathMore Azurile
    dw $00EF ; id 367 DeathMore Titanis
    dw $0136 ; id 368 DeathMore DarkMate
    dw $0019 ; id 369 Darkdrium GranSlime
    dw $0110 ; id 370 Orgodemir Niterich
    dw $0161 ; id 371 Orgodemir LordDraco
    dw $FEFE ; id 372 Darck none
    dw $FEFE ; id 373 Tatsu none
    dw $FEFE ; id 374 Diago none
    dw $FEFE ; id 375 Samsi none
    dw $FEFE ; id 376 Bazoo none
    dw $FEFE ; id 377 ? none
    dw $FEFE ; id 378 ? none
    dw $FEFE ; id 379 ? none
    dw $FEFE ; id 380 Lamia none
    dw $FEFE ; id 381 Dimensaur none
    dw $FEFE ; id 382 Kagebou none
    dw $FEFE ; id 383 ? none

; implements script command type F7 (SCRIPT_ARENA): the arena: 'The E Class should do. Which...', 'Congratulations! You did it!' (mode 10, bank $33 strings); reached through ScriptCommandF7 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF7)
; reads: wScreenState
ArenaMenu::
Func_00C_659F:: ; address name
    ld a, [wScreenState]
    rst $00
    dw ArenaMenu_CopyBytesDEToHL_Bank0C
    dw ArenaMenu_CopyRectTo20ByteRows_Bank0C
    dw ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc
    dw ShowTwoChoiceBoxAtWC412
    dw ArenaMenu_UpdateTwoChoiceCursor_Bank1D
    dw ArenaMenu_BGMapAddressAtScroll_Bank0C
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_SubtractArg1AmountFromGold
    dw ArenaMenu_SetupScreenCountPlusOneFromRecordCapacity
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_CallArenaMenu_DispatchTalkEvent
    dw ArenaMenu_ShowTwoChoiceBoxAtWC412
    dw ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case0C
    dw ArenaMenu_AdvanceScreenState_Case0D
    dw ArenaMenu_SetScreenState
    dw ArenaMenu_CopyScreenBufferRectWithAttrs_0C
    dw ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case10
    dw ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case11
    dw ArenaMenu_WriteTextBuf0AndScreenStateEtc
    dw ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case13
    dw ArenaMenu_AdvanceScreenState_Case14
    dw ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc
    dw ShowTwoChoiceBoxAtWC412
    dw ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case17
    dw ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18
    dw ArenaMenu_SubtractArg1AmountFromGold_Case19
    dw ArenaMenu_RedrawFullScreenBoxes_0C
    dw ArenaMenu_IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea
    dw ArenaMenu_ToArenaMenu_Case1C_ReadArenaRound
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_RedrawFullScreenBoxes_0C_Case1E
    dw ArenaMenu_SetupScreenCountPlusOneFromRecordCapacity
    dw ArenaMenu_AdvanceScreenState
    dw ArenaMenu_ToArenaMenu_DispatchTalkEvent
    dw ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Case22
    dw ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Case23
    dw ArenaMenu_SetFlagBit
    dw ShowTwoChoiceBoxAtWC412
    dw ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case26
    dw ArenaMenu_RandomModulo52

; entry 39 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wAreaGraphicsIndex, hTemp0
; writes: wArg1, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wAreaGraphicsIndex
ArenaMenu_RandomModulo52::
Jump_00C_65F3:: ; address name
    ld a, [wAreaGraphicsIndex]
    add a, a
    ld hl, ArenaMenu_RandomModulo52_Data_75D2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld b, $1F
    call RandomModulo52
    pop de
    ld b, $00

.skip:
    ld a, [de]
    cp a, $FF
    jp z, .call_arena_menu_add_arg1_to_gold_capped999992
    cp a, l
    jr nc, .read_area_graphics_index
    inc de
    inc b
    jr .skip

.read_area_graphics_index:
    ld a, [wAreaGraphicsIndex]
    add a, a
    ld hl, ArenaMenu_RandomModulo52_Data_7602
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    cp a, $FE
    jr z, .call_generate_new_key_entry
    cp a, $FD
    jr z, .call_arena_menu_case27_random_modulo52
    ld [wArg1], a
    call ArenaMenu_Case27_ArenaMenu_AddArg1ToGoldCapped99999
    jp .set_two_choice_cursor

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    and a, a
    jr z, .call_arena_menu_add_arg1_to_gold_capped99999
    ld a, $01
    jr .set_two_choice_cursor

.call_arena_menu_add_arg1_to_gold_capped99999:
    call ArenaMenu_AddArg1ToGoldCapped99999
    ld a, $03
    jr .set_two_choice_cursor

.call_arena_menu_case27_random_modulo52:
    call ArenaMenu_Case27_RandomModulo52
    call ArenaMenu_Case27_ArenaMenu_AddArg1ToGoldCapped99999
    jp .set_two_choice_cursor

.call_arena_menu_add_arg1_to_gold_capped999992:
    call ArenaMenu_AddArg1ToGoldCapped99999
    ld a, $03

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wAreaGraphicsIndex], a
    ret

; entry 38 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wScreenState, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor, wArg1, wArg2
ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case26::
Jump_00C_6674:: ; address name
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
    ld a, [wScreenState]
    dec a
    ld [wScreenState], a
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .loop
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wArenaRank, wScreenTableIndex, wScreenState
; writes: wMessageMode, wScreenState, wTwoChoiceCursor, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, ...
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
ArenaMenu_CopyBytesDEToHL_Bank0C::
Jump_00C_66D7:: ; address name
    ld hl, wScreenState
    ld b, $6F

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, .set_message_mode_to_0A
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

.set_message_mode_to_0A:
    ld a, $0A
    ld [wMessageMode], a
    ld a, [wArenaRank]
    cp a, $05
    jr nc, .set_two_choice_cursor_to_01
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, [wScreenTableIndex]
    cp a, $1F
    jr z, .set_screen_state
    ld a, $1D

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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wStringCategory], a
    ld a, $17
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0A01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank33_649E
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    jr .check_screen_table_index

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1A
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0A01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank33_649E
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $18
    ld [wStringIndex], a
    farcall ShowString_Bank33_649E
    ld a, $0B
    ld [wScreenState], a

.check_screen_table_index:
    ld a, [wScreenTableIndex]
    cp a, $08
    jr z, .set_screen_state2
    cp a, $1B
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ArenaMenu_CopyRectTo20ByteRows_Bank0C::
Jump_00C_67E5:: ; address name
    ld de, TileRect_0C_762E
    ld hl, wWindowTileBuffer + $B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ArenaMenu_Case01_ReadArenaRank
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wArenaRank, wGridCursorX, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wTextBuf0, wScreenState, wGridCursorX
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
Jump_00C_680B:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_arena_menu_case02_read_grid_cursor_x
    bit 7, a
    jr nz, .call_arena_menu_case02_read_grid_cursor_x2
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_03
    bit 0, a
    jr nz, .call_arena_menu_case02_read_grid_cursor_x3
    call ArenaMenu_Case02_WriteGridCursorY
    ret

.call_arena_menu_case02_read_grid_cursor_x:
    call ArenaMenu_Case02_ReadGridCursorX_Sub03
    ld a, [wGridCursorX]
    and a, a
    jr nz, .set_grid_cursor_x
    ld a, $03
    jr .set_grid_cursor_x2

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    call ArenaMenu_Case02_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_arena_menu_case02_read_grid_cursor_x2:
    call ArenaMenu_Case02_ReadGridCursorX_Sub03
    ld a, [wGridCursorX]
    cp a, $03
    jr c, .skip
    xor a, a
    jr .set_grid_cursor_x2

.skip:
    inc a
    jr .set_grid_cursor_x2

.set_two_choice_cursor_to_03:
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_arena_menu_case02_read_grid_cursor_x3:
    call ArenaMenu_Case02_ReadGridCursorX
    ld a, [wArenaRank]
    dec a
    ld b, a
    ld a, [wGridCursorX]
    cp a, b
    jr c, .set_two_choice_cursor_to_01
    jr z, .call_queue_sound_effect
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data_68D1
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data_784F
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data_68D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_68D1:: ; address name
    db $0C, $0B, $0A, $1C

; only called from ArenaMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
ArenaMenu_Case02_WriteGridCursorY::
Func_00C_68D5:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ArenaMenu_Case02_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, ArenaMenu_Case02_ReadGridCursorX
    cp a, $18
    jr c, ArenaMenu_Case02_ReadGridCursorX_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from ArenaMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wGridCursorX
ArenaMenu_Case02_ReadGridCursorX::
Func_00C_68EF:: ; address name
    ld b, $BB
    jr ArenaMenu_Case02_ReadGridCursorX_Sub03_ReadGridCursorX

; only called from ArenaMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc)
; reads: wGridCursorX
ArenaMenu_Case02_ReadGridCursorX_Sub03::
Func_00C_68F3:: ; address name
    ld b, $C3
    jr ArenaMenu_Case02_ReadGridCursorX_Sub03_ReadGridCursorX
    db $06, $BC

ArenaMenu_Case02_ReadGridCursorX_Sub03_ReadGridCursorX::
Jump_00C_68F9:: ; address name
    ld a, [wGridCursorX]
    sla a
    ld hl, ArenaMenu_Case02_ReadGridCursorX_Sub03_Data
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

; address loaded by ArenaMenu_Case02_ReadGridCursorX_Sub03
ArenaMenu_Case02_ReadGridCursorX_Sub03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_691A:: ; address name
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; plays sound $6C, copies the 6 x 5 box Data_00C_7831 to wWindowTileBuffer + $112, draws it at the scroll position + $1CC, wScreenState += 1 and wTwoChoiceCursor = 0 (E-0122)
; 1 call site from 1 routine (e.g. ArenaMenu_ShowTwoChoiceBoxAtWC412)
; reads: wScreenState
; writes: wScreenState, wTwoChoiceCursor
ShowTwoChoiceBoxAtWC412::
Func_00C_6922:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_0C_7831
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 4 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wGridCursorX, wArg1, wScreenState
; writes: wArg3, wArg2, wArg1, wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
ArenaMenu_UpdateTwoChoiceCursor_Bank1D::
Jump_00C_694B:: ; address name
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
    call ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Shared01
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .loop
    ld a, [wGridCursorX]
    sla a
    ld de, ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Data
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
    ld a, [wScreenState]
    inc a
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

; only called from routines of ArenaMenu (E-0098)
; 3 call sites from 3 routines (e.g. ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case0C, ArenaMenu_BGMapAddressAtScroll_Bank0C, ArenaMenu_UpdateTwoChoiceCursor_Bank1D)
; writes: wArg1, wArg2
ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Shared01::
Func_00C_69D5:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld de, TileRect_0C_76C7
    ld hl, wWindowTileBuffer + $112
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ret

; entry 5 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenState
ArenaMenu_BGMapAddressAtScroll_Bank0C::
Jump_00C_6A04:: ; address name
    call ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Shared01
    ld c, $04
    ld hl, ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data_784F
    call ArenaMenu_Case05_StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $02
    ld [wScreenState], a
    ret

; entry 6 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ArenaMenu_AdvanceScreenState::
Jump_00C_6A21:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 7 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenState, wScreenCountPlusOne
; writes: wArg3, wArg2, wArg1, wScreenState, wScreenTableIndex, wRecordCapacity, wAreaGraphicsIndex
ArenaMenu_SubtractArg1AmountFromGold::
Jump_00C_6A29:: ; address name
    call ArenaMenu_DispatchTalkEvent_Shared04
    ld a, [wGridCursorX]
    sla a
    ld de, ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Data
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
    xor a, a
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

; entry 8 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wRecordCapacity, wScreenState, wArenaRank
; writes: wScriptCommandType, wScriptStartRequest, wScreenState, wArenaRank, wTwoChoiceCursor, wAreaGraphicsIndex, wScreenTableIndex, wRecordCapacity
ArenaMenu_SetupScreenCountPlusOneFromRecordCapacity::
Jump_00C_6A6A:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, .set_two_choice_cursor_to_02
    ld a, [wRecordCapacity]
    cp a, $02
    jr nc, .check_arena_rank
    call SetupScreenCountPlusOneFromRecordCapacity
    xor a, a
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
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    jr .clear_area_graphics_index

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a

.clear_area_graphics_index:
    xor a, a
    ld [wAreaGraphicsIndex], a
    ld [wScreenTableIndex], a
    ld [wRecordCapacity], a
    ld a, [wArenaRank]
    and a, a
    ret z
    ld a, $22
    ld [wScreenState], a
    ret

; entry 10 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
ArenaMenu_CallArenaMenu_DispatchTalkEvent::
Jump_00C_6AC4:: ; address name
    call ArenaMenu_DispatchTalkEvent_Shared04
    ret

; entry 11 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
ArenaMenu_ShowTwoChoiceBoxAtWC412::
Jump_00C_6AC8:: ; address name
    call ArenaMenu_Number24ToPackedBCD
    call ShowTwoChoiceBoxAtWC412
    ret

; entry 12 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case0C::
Jump_00C_6ACF:: ; address name
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .loop
    call ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Shared01
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ArenaMenu_AdvanceScreenState_Case0D::
Jump_00C_6B10:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 14 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ArenaMenu_SetScreenState::
Jump_00C_6B18:: ; address name
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wArg1, wArg2, wScreenState, wScriptCommandType, wScriptStartRequest
ArenaMenu_CopyScreenBufferRectWithAttrs_0C::
Jump_00C_6B2E:: ; address name
    ld b, $00
    ld c, $03
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [wArg1], a
    ld a, $0D
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    sub a, $04
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState, wScriptCommandType, wScriptStartRequest
ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case10::
Jump_00C_6B78:: ; address name
    ld de, TileRect_0C_76D6
    ld hl, wWindowTileBuffer + $B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call ArenaMenu_WriteTwoChoiceCursor
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case11::
Jump_00C_6BB4:: ; address name
    ld de, TileRect_0C_76D6
    ld hl, wWindowTileBuffer + $B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 18 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wGridCursorX, wScreenState
; writes: wTextBuf0, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wGridCursorX
ArenaMenu_WriteTextBuf0AndScreenStateEtc::
Jump_00C_6BE3:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_arena_menu_case12_read_grid_cursor_x
    bit 7, a
    jr nz, .call_arena_menu_case12_read_grid_cursor_x2
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, .set_two_choice_cursor_to_01
    bit 0, a
    jr nz, .call_arena_menu_case12_read_grid_cursor_x3
    call ArenaMenu_Case12_WriteGridCursorY
    ret

.call_arena_menu_case12_read_grid_cursor_x:
    call ArenaMenu_Case12_ReadGridCursorX_Sub03
    ld a, [wGridCursorX]
    and a, a
    jr nz, .set_grid_cursor_x
    ld a, $03
    jr .set_grid_cursor_x2

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    call ArenaMenu_Case12_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_arena_menu_case12_read_grid_cursor_x2:
    call ArenaMenu_Case12_ReadGridCursorX_Sub03
    ld a, [wGridCursorX]
    cp a, $03
    jr c, .skip
    xor a, a
    jr .set_grid_cursor_x2

.skip:
    inc a
    jr .set_grid_cursor_x2

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_arena_menu_case12_read_grid_cursor_x3:
    call ArenaMenu_Case12_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data_6C7F
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a
    ld a, [wGridCursorX]
    ld hl, ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data_7857
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ArenaMenu_WriteTextBuf0AndScreenStateEtc
ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data_6C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_6C7F:: ; address name
    db $0C, $0B, $0A, $1C

; only called from ArenaMenu_Case12 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_WriteTextBuf0AndScreenStateEtc)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
ArenaMenu_Case12_WriteGridCursorY::
Func_00C_6C83:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ArenaMenu_Case12_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, ArenaMenu_Case12_ReadGridCursorX
    cp a, $18
    jr c, ArenaMenu_Case12_ReadGridCursorX_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from ArenaMenu_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. ArenaMenu_WriteTextBuf0AndScreenStateEtc)
; reads: wGridCursorX
ArenaMenu_Case12_ReadGridCursorX::
Func_00C_6C9D:: ; address name
    ld b, $BB
    jr ArenaMenu_Case12_ReadGridCursorX_Sub03_ReadGridCursorX

; only called from ArenaMenu_Case12 (E-0047)
; 2 call sites from 1 routine (e.g. ArenaMenu_WriteTextBuf0AndScreenStateEtc)
; reads: wGridCursorX
ArenaMenu_Case12_ReadGridCursorX_Sub03::
Func_00C_6CA1:: ; address name
    ld b, $C3
    jr ArenaMenu_Case12_ReadGridCursorX_Sub03_ReadGridCursorX
    db $06, $BC

ArenaMenu_Case12_ReadGridCursorX_Sub03_ReadGridCursorX::
Jump_00C_6CA7:: ; address name
    ld a, [wGridCursorX]
    sla a
    ld hl, ArenaMenu_Case12_ReadGridCursorX_Sub03_Data
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

; address loaded by ArenaMenu_Case12_ReadGridCursorX_Sub03
ArenaMenu_Case12_ReadGridCursorX_Sub03_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_6CC8:: ; address name
    db $A1, $00, $E1, $00, $21, $01, $61, $01

; entry 19 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wScreenState, wGrid2CursorX, wScriptCommandType, wScriptStartRequest
ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case13::
Jump_00C_6CD0:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, $0D
    ld [wScreenState], a
    xor a, a
    ld [wGrid2CursorX], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
ArenaMenu_AdvanceScreenState_Case14::
Jump_00C_6D05:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 21 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenState
; writes: wScreenArea, wGrid2CursorX, wArenaByte86, wArenaByte87, wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc::
Jump_00C_6D0D:: ; address name
    ld a, [wGridCursorX]
    inc a
    inc a
    ld [wScreenArea], a
    ld a, $02
    ld [wGrid2CursorX], a
    ld a, [wGridCursorX]
    add a, a
    ld hl, ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc_Data
    add_a_to_hl
    ld a, [hl]
    ld [wArenaByte86], a
    inc hl
    ld a, [hl]
    ld [wArenaByte87], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc
ArenaMenu_WriteScreenAreaAndGrid2CursorXEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_6D44:: ; address name
    db $E8, $03, $D0, $07, $B8, $0B, $88, $13

; entry 23 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArenaByte86, wArenaByte87, wArg1, wScreenState
; writes: wArg1, wArg2, wArg3, wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest
ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case17::
Jump_00C_6D4C:: ; address name
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
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .loop
    ld a, [wArenaByte86]
    ld [wArg1], a
    ld a, [wArenaByte87]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, .check_screen_state
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 24 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wScreenState, wGrid2CursorX, wScreenArea, wScriptCommandType, wScriptStartRequest
ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18::
Jump_00C_6DC5:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld de, TileRect_0C_776F
    ld hl, wWindowTileBuffer + $112
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call ArenaMenu_WriteTwoChoiceCursor
    ld a, $11
    ld [wScreenState], a
    xor a, a
    ld [wGrid2CursorX], a
    ld [wScreenArea], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 25 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaByte87, wArenaByte86, wScreenState
; writes: wArg3, wArg2, wArg1, wScreenState, wScriptCommandType, wScriptStartRequest
ArenaMenu_SubtractArg1AmountFromGold_Case19::
Jump_00C_6E0C:: ; address name
    xor a, a
    ld [wArg3], a
    ld a, [wArenaByte87]
    ld [wArg2], a
    ld a, [wArenaByte86]
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    call ArenaMenu_Number24ToPackedBCD
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 26 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenArea, wScreenState
; writes: wAreaGraphicsIndex, wScreenState, wScreenTableIndex
ArenaMenu_RedrawFullScreenBoxes_0C::
Jump_00C_6E42:: ; address name
    ld a, [wScreenArea]
    ld [wAreaGraphicsIndex], a
    call ArenaMenu_Case1A_DispatchTalkEvent
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; entry 27 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wArenaRound, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenTableIndex, wScreenState, wRecordCapacity, wArg3, wArg2, ...
ArenaMenu_IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea::
Jump_00C_6E59:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, .clear_arg3
    ld a, [wArenaRound]
    cp a, $02
    jr nc, .call_arena_menu_case1_b_return
    call IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScreenState]
    ld [wScreenTableIndex], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

.call_arena_menu_case1_b_return:
    call ArenaMenu_Case1B_Return
    xor a, a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wScreenTableIndex], a
    ld [wRecordCapacity], a
    ld a, $23
    ld [wScreenState], a
    ret

.clear_arg3:
    xor a, a
    ld [wArg3], a
    ld [wArg2], a
    ld [wArg1], a
    ld a, $02
    jr .set_two_choice_cursor

; entry 28 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
ArenaMenu_ToArenaMenu_Case1C_ReadArenaRound::
Jump_00C_6EB0:: ; address name
    call ArenaMenu_Case1C_ReadArenaRound
    ret

; entry 30 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wScreenCountPlusOne, wGridCursorX
; writes: wScreenState, wScreenTableIndex, wRecordCapacity, wAreaGraphicsIndex
ArenaMenu_RedrawFullScreenBoxes_0C_Case1E::
Jump_00C_6EB4:: ; address name
    call ArenaMenu_DispatchTalkEvent
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld [wScreenTableIndex], a
    ld a, [wScreenCountPlusOne]
    xor a, a
    ld [wRecordCapacity], a
    ld a, [wGridCursorX]
    xor a, a
    ld [wAreaGraphicsIndex], a
    call RedrawFullScreenBoxes_0C
    ret

; entry 33 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
ArenaMenu_ToArenaMenu_DispatchTalkEvent::
Jump_00C_6ED3:: ; address name
    call ArenaMenu_DispatchTalkEvent
    ret

; entry 34 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wArenaRank, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Case22::
Jump_00C_6ED7:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, .check_arena_rank
    ld a, [wArenaRank]
    dec a
    dec a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wArenaRank]
    cp a, $01
    jr c, .return
    cp a, $05
    jr nc, .return
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a

.return:
    ret

.check_arena_rank:
    ld a, [wArenaRank]
    cp a, $03
    jr nc, .set_two_choice_cursor_to_01
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 35 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Case23::
Jump_00C_6F26:: ; address name
    ld a, [wBattleScene]
    and a, a
    jr nz, .skip
    jr .call_arena_menu_case23_write_player_name_with

.skip:
    jr .call_write_player_name_with_flag0_suffix_to

.call_arena_menu_case23_write_player_name_with:
    call ArenaMenu_Case23_WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 36 of the `rst $00` table in ArenaMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaRank, wGameFlags836, hTemp0
; writes: hTemp1, wGameFlags836, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wTalkEventByte92
; points at: wTextBuf0, wPlayerName
ArenaMenu_SetFlagBit::
Jump_00C_6F5E:: ; address name
    ld a, [wArenaRank]
    cp a, $01
    jr nz, .call_generate_new_key_entry
    ld de, $0188
    call SetFlagBit
    farcall CountKeysOrFull
    ld a, $03
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld de, $012F
    call SetFlagBit
    jr .skip

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    ld [wTalkEventByte92], a
    and a, a
    jr z, .set_two_choice_cursor_to_01

.skip:
    ld hl, wTextBuf0
    ld de, wPlayerName
    ld b, $0A

.loop:
    ld a, [de]
    cp a, $F0
    jr z, .skip2
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop

.skip2:
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs Func_00C_72CC for the bottom box, copies $64 bytes of tiles (and CGB attributes) and draws the two screen-buffer rectangles at scroll + $1CC and + $1A0 (E-0125)
; 4 call sites from 4 routines (e.g. ArenaMenu_RedrawFullScreenBoxes_0C_Case1E, ArenaMenu_RedrawFullScreenBoxes_0C, ArenaMenu_SubtractArg1AmountFromGold, NpcBreedMenu_ChooseAndBreed_ToRedrawFullScreenBoxes_0CAndStep)
; reads: wIsCGB
; writes: wArg1, wArg2
; points at: wWindowTileBuffer, wWindowAttrBuffer
RedrawFullScreenBoxes_0C::
Func_00C_6FCB:: ; address name
    ld b, $00
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0C
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank0_c
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0C

.call_bg_map_address_at_scroll_bank0_c:
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0C
    ret

; only called from ArenaMenu_Case23 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Case23)
; reads: wAreaGraphicsIndex
; writes: wTextBuf0
ArenaMenu_Case23_WritePlayerNameWithFlag0SuffixToTextBuf0::
Func_00C_701C:: ; address name
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    ld a, [wAreaGraphicsIndex]
    ld hl, ArenaMenu_Case23_WritePlayerNameWithFlag0SuffixToTextBuf0_Data
    add_a_to_hl
    ld a, [hl]
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a
    ret

; address loaded by ArenaMenu_Case23_WritePlayerNameWithFlag0SuffixToTextBuf0
ArenaMenu_Case23_WritePlayerNameWithFlag0SuffixToTextBuf0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_7037:: ; address name
    db $0C, $0C, $0C, $0B, $0A, $1C

; wArenaRound += 1 and wScreenArea = wAreaGraphicsIndex (E-0122)
; 3 call sites from 3 routines (e.g. ArenaMenu_IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea, ArenaRounds_StartArenaRankMessage_Case0D, ArenaRounds_StartArenaRankMessage_Case05)
; reads: wArenaRound, wAreaGraphicsIndex
; writes: wArenaRound, wScreenArea
IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea::
Func_00C_703D:: ; address name
    ld a, [wArenaRound]
    inc a
    ld [wArenaRound], a
    ld a, [wAreaGraphicsIndex]
    ld [wScreenArea], a
    ret

; wScreenCountPlusOne = wRecordCapacity + 1 (and stored back to wRecordCapacity), wGridCursorX = wAreaGraphicsIndex, wTwoChoiceCursor = 1 (E-0122)
; 5 call sites from 3 routines (e.g. ArenaMenu_SetupScreenCountPlusOneFromRecordCapacity, ArenaGridBattle_StartArenaRankMessage_Case0E, ArenaGridBattle_StartArenaRankMessage_Case06)
; reads: wRecordCapacity, wAreaGraphicsIndex, wScreenCountPlusOne
; writes: wScreenCountPlusOne, wGridCursorX, wTwoChoiceCursor, wRecordCapacity
SetupScreenCountPlusOneFromRecordCapacity::
Func_00C_704B:: ; address name
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

; only called from ArenaMenu_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_CopyRectTo20ByteRows_Bank0C)
; reads: wArenaRank
ArenaMenu_Case01_ReadArenaRank::
Func_00C_7064:: ; address name
    ld hl, wWindowTileBuffer + $C9
    ld a, [wArenaRank]
    cp a, $02
    jr c, .check_arena_rank
    ld a, $AD
    ld [hl], a

.check_arena_rank:
    ld a, [wArenaRank]
    cp a, $03
    jr c, .check_arena_rank2
    ld hl, wWindowTileBuffer + $F1
    ld a, $AD
    ld [hl], a

.check_arena_rank2:
    ld a, [wArenaRank]
    cp a, $04
    jr c, .check_arena_rank3
    ld hl, wWindowTileBuffer + $119
    ld a, $AD
    ld [hl], a

.check_arena_rank3:
    ld a, [wArenaRank]
    cp a, $05
    ret c
    ld hl, wWindowTileBuffer + $141
    ld a, $AD
    ld [hl], a
    ret

; only called from routines of ArenaMenu (E-0098)
; 5 call sites from 5 routines (e.g. ArenaMenu_SubtractArg1AmountFromGold_Case19, ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case11, ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case10, ArenaMenu_ShowTwoChoiceBoxAtWC412, ...)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wDigits
; points at: wArg3
ArenaMenu_Number24ToPackedBCD::
Func_00C_7098:: ; address name
    ld de, TileRect_0C_777E
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
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
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
    ret

; only called from ArenaMenu_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_WriteTwoChoiceCursor)
; reads: wPartyCount
; points at: wArenaEntry
ArenaMenu_Shared05_DivideHLByA::
Func_00C_70D3:: ; address name
    ld hl, $0000
    ld de, wArenaEntry
    ld c, $00

.loop:
    push de
    push bc
    ld a, [de]
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    pop de
    inc de
    inc c
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp a, b
    jr c, .loop
    ld a, [wPartyCount]
    call DivideHLByA
    ld a, h
    and a, a
    ret z
    ld h, $00
    ld l, $FF
    ret

; only called from ArenaMenu_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_WriteTwoChoiceCursor)
; reads: hTemp0, wPartyCount
; writes: wArenaEntry, rRAMG2, rRAMB
; points at: wPartyList, wArenaEntry
ArenaMenu_Shared05_AddTemp0WordToHL::
Func_00C_70FE:: ; address name
    xor a, a
    ld [wArenaEntry], a
    ld [wArenaEntry + $1], a
    ld [wArenaEntry + $2], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
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
    and a, a
    jr z, .skip
    ld h, $00
    ld l, $63
    jr .restore

.skip:
    ld a, l
    cp a, $64
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
    add a, e
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
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, $32
    call DivideHLByA
    ld a, h
    and a, a
    jr z, .skip3
    ld h, $00
    ld l, $63
    jr .restore2

.skip3:
    ld a, l
    cp a, $64
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
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add a, l
    ld [de], a
    pop de
    pop bc
    inc de
    inc c
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp a, b
    jp c, .loop
    xor a, a
    ld [rRAMG2], a
    ret

; HL += the word in hTemp0/hTemp1; clobbers A (E-0073)
; 12 call sites from 1 routine (e.g. ArenaMenu_Shared05_AddTemp0WordToHL)
; reads: hTemp0, hTemp1
AddTemp0WordToHL::
Func_00C_7246:: ; address name
    ldh a, [hTemp0]
    add a, l
    ld l, a
    ldh a, [hTemp1]
    adc a, h
    ld h, a
    ret

; HL = the word Data_00C_72C0[band] for the party's total level (bands at 49, 91, 139, 181, 220 and 256) (E-0128)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wPartyCount
; writes: rRAMG2, rRAMB
; points at: wPartyList
PickTableEntryByPartyLevelTotal:: ; heuristic: follows a terminator; C0
Func_00C_724F:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
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
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, [wPartyCount]
    ld b, a
    ld a, c
    cp a, b
    jr c, .loop
    xor a, a
    ld [rRAMG2], a
    ld a, d
    and a, a
    jr nz, .skip
    ld a, e
    cp a, $DC
    jr nc, .skip
    cp a, $B5
    jr nc, .skip2
    cp a, $8B
    jr nc, .skip3
    cp a, $5B
    jr nc, .skip4
    cp a, $31
    jr nc, .skip5
    xor a, a
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
    add a, e
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

; address loaded by PickTableEntryByPartyLevelTotal
PickTableEntryByPartyLevelTotal_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_72C0:: ; address name
    db $90, $01, $58, $02, $20, $03, $B0, $04, $78, $05, $78, $05

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL for rows B to C, with CGB attributes (E-0128)
; 7 call sites from 6 routines (e.g. ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case26, RedrawFullScreenBoxes_0C, ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18, ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case13, ...)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_0C::
Func_00C_72CC:: ; address name
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
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp a, c
    jr c, CopyScreenBufferRectWithAttrs_0C
    ret

; only called from ArenaRounds_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. ArenaRounds_WriteBattleIntroKindAndEncounterKind)
; reads: wArenaRound, wAreaGraphicsIndex
; points at: wArenaList, wArenaList2
ArenaRounds_Shared01_RandomModulo52::
Func_00C_7326:: ; address name
    ld hl, wArenaList
    ld b, $28

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, [wArenaRound]
    ld b, a
    ld c, $00

.loop2:
    push bc
    ld b, $1F
    call RandomModulo52

.read_area_graphics_index:
    ld de, ArenaEncounterListSizes
    ld a, [wAreaGraphicsIndex]
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a

.skip2:
    ld a, l
    cp a, b
    jr c, .skip3
    sub a, b
    ld l, a
    jr .read_area_graphics_index

.skip3:
    push hl
    ld hl, wArenaList
    add_a_to_hl
    ld a, [hl]
    cp a, $03
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
    add a, a
    add a, e
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
    add a, l
    ld hl, wArenaList2
    add_a_to_hl
    ld a, c
    sla a
    add_a_to_hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop bc
    inc c
    ld a, c
    cp a, $03
    jp c, .loop2
    ld c, $00
    inc b
    ld a, b
    cp a, $03
    jp c, .loop2
    ret

; NextTableByte; L = wRandomLo, H = (wRandomLo rotated left through carry) & B; returns A = HL mod $52 (E-0117)
; 3 call sites from 3 routines (e.g. ArenaMenu_RandomModulo52, ArenaMenu_Case27_RandomModulo52, ArenaRounds_Shared01_RandomModulo52)
; reads: wRandomLo
RandomModulo52::
Func_00C_73B3:: ; address name
    push bc
    call NextTableByte
    pop bc
    ld a, [wRandomLo]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $52
    call DivideHLByA
    ret

; only called from ArenaMenu_Case1B (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_IncArenaRoundAndCopyAreaGraphicsIndexToScreenArea)
ArenaMenu_Case1B_Return::
Func_00C_73C6:: ; address name
    ret

; only called from ArenaMenu_Case1A (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_RedrawFullScreenBoxes_0C)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wArenaRound
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wBattleIntroKind, ...
; points at: wArenaList2, wEncounterMonsters
ArenaMenu_Case1A_DispatchTalkEvent::
Func_00C_73C7:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $1F
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ArenaRounds (E-0098)
; 2 call sites from 2 routines (e.g. ArenaRounds_StartArenaRankMessage_Case0D, ArenaRounds_StartArenaRankMessage_Case05)
; reads: wArenaRound
; writes: wBattleIntroKind, wEncounterKind
; points at: wArenaList2, wEncounterMonsters
ArenaRounds_WriteBattleIntroKindAndEncounterKind::
Func_00C_73F5:: ; address name
    ld a, $04
    ld [wBattleIntroKind], a
    ld a, $02
    ld [wEncounterKind], a
    call ArenaRounds_Shared01_RandomModulo52

; only called from ArenaMenu_Case1C (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_ToArenaMenu_Case1C_ReadArenaRound)
; reads: wArenaRound
; points at: wArenaList2, wEncounterMonsters
ArenaMenu_Case1C_ReadArenaRound::
Func_00C_7402:: ; address name
    ld a, [wArenaRound]
    sla a
    ld b, a
    sla a
    add a, b
    ld hl, wArenaList2
    add_a_to_hl
    ld de, wEncounterMonsters
    ld b, $06

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; only called from routines of ArenaMenu (E-0098)
; 2 call sites from 2 routines (e.g. ArenaMenu_ToArenaMenu_DispatchTalkEvent, ArenaMenu_RedrawFullScreenBoxes_0C_Case1E)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScreenCountPlusOne
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wBattleIntroKind, ...
; points at: wEncounterMonsters
ArenaMenu_DispatchTalkEvent::
Func_00C_741F:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $18
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ArenaGridBattle (E-0098)
; 2 call sites from 2 routines (e.g. ArenaGridBattle_StartArenaRankMessage_Case0E, ArenaGridBattle_StartArenaRankMessage_Case06)
; reads: wScreenCountPlusOne
; writes: wBattleIntroKind, wEncounterKind
; points at: wEncounterMonsters
ArenaGridBattle_WriteBattleIntroKindAndEncounterKind::
Func_00C_744D:: ; address name
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
    ld de, wEncounterMonsters
    ld b, $06

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; only called from routines of ArenaMenu (E-0098)
; 2 call sites from 2 routines (e.g. ArenaMenu_CallArenaMenu_DispatchTalkEvent, ArenaMenu_SubtractArg1AmountFromGold)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wGridCursorX, wScreenCountPlusOne
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wBattleIntroKind, ...
; points at: wEncounterMonsters
ArenaMenu_DispatchTalkEvent_Shared04::
Func_00C_7478:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $18
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags

; only called from routines of ArenaGridBattle (E-0098)
; 2 call sites from 2 routines (e.g. ArenaGridBattle_StartArenaRankMessage_Case0E, ArenaGridBattle_StartArenaRankMessage_Case06)
; reads: wGridCursorX, wScreenCountPlusOne
; writes: wBattleIntroKind, wEncounterKind
; points at: wEncounterMonsters
ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_Shared02::
Func_00C_74A6:: ; address name
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
    ld de, wEncounterMonsters
    ld b, $06

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; only called from routines of ArenaMenu (E-0098)
; 2 call sites from 2 routines (e.g. ArenaMenu_CopyScreenBufferRectWithAttrs_0C_Case18, ArenaMenu_CopyRectTo20ByteRows_Bank0C_Case10)
; writes: wTwoChoiceCursor
ArenaMenu_WriteTwoChoiceCursor::
Func_00C_74DB:: ; address name
    call ArenaMenu_Shared05_AddTemp0WordToHL
    call ArenaMenu_Shared05_DivideHLByA
    ld a, l
    cp a, $50
    jr nc, .skip
    cp a, $3C
    jr nc, .skip2
    cp a, $28
    jr nc, .skip3
    cp a, $1E
    jr nc, .skip4
    cp a, $00
    jr nc, .set_two_choice_cursor_to_04
    ld a, $05
    jr .set_two_choice_cursor

.skip:
    xor a, a
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

; only called from ArenaMenu_Case27 (E-0047)
; 1 call site from 1 routine (e.g. ArenaMenu_RandomModulo52)
; writes: wArg1
ArenaMenu_Case27_RandomModulo52::
Func_00C_750F:: ; address name
    ld b, $1F
    call RandomModulo52
    ld c, l
    ld a, l
    and a, $03
    sla a
    ld hl, ArenaMenu_Case27_RandomModulo52_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, c

.cp_07:
    cp a, $07
    jr c, .skip
    sub a, $07
    jr .cp_07

.skip:
    add a, e
    ld e, a
    jr nc, .set_arg1
    inc d

.set_arg1:
    ld a, [de]
    ld [wArg1], a
    ret

; address loaded by ArenaMenu_Case27_RandomModulo52
ArenaMenu_Case27_RandomModulo52_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_7538:: ; address name
    db $40, $75, $47, $75, $4E, $75, $55, $75, $40, $41, $42, $43, $44, $45, $46, $47
    db $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $5A, $5B, $5C, $5D
    db $5E, $5F, $60, $61

; only called from ArenaMenu_Case27 (E-0047)
; 2 call sites from 1 routine (e.g. ArenaMenu_RandomModulo52)
; reads: wArg1
; writes: wArg1
; points at: wInventory
ArenaMenu_Case27_ArenaMenu_AddArg1ToGoldCapped99999::
Func_00C_755C:: ; address name
    ld hl, wInventory
    ld c, $18

.loop:
    ld a, [hl]
    and a, a
    jr z, .read_arg1
    cp a, $FF
    jr z, .read_arg1
    inc hl
    dec c
    jr nz, .loop
    ld a, [wArg1]
    push af
    call ArenaMenu_AddArg1ToGoldCapped99999
    pop af
    ld [wArg1], a
    call ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB
    ld a, $02
    ret

.read_arg1:
    ld a, [wArg1]
    ld [hl], a
    call ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB
    xor a, a
    ret

; only called from ArenaMenu_Case27_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. ArenaMenu_Case27_ArenaMenu_AddArg1ToGoldCapped99999)
; reads: wArg1
; points at: wTextBuf1
ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB::
Func_00C_7587:: ; address name
    ld de, ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB_Data
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
    cp a, $F0
    jr z, .done
    ld [hl+], a
    inc de
    jr .call_read_byte_in_bank

.done:
    ld a, $F0
    ld [hl+], a
    ret

; only called from routines of ArenaMenu (E-0098)
; 3 call sites from 2 routines (e.g. ArenaMenu_Case27_ArenaMenu_AddArg1ToGoldCapped99999, ArenaMenu_RandomModulo52)
; writes: wArg1, wArg2, wArg3
ArenaMenu_AddArg1ToGoldCapped99999::
Func_00C_75BC:: ; address name
    ld hl, $1770
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall AddArg1ToGoldCapped99999
    ret

; address loaded by ArenaMenu_RandomModulo52
ArenaMenu_RandomModulo52_Data_75D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_75D2:: ; address name
    db $DE, $75, $DE, $75, $DE, $75, $E7, $75, $F0, $75, $F9, $75, $19, $23, $2D, $37
    db $41, $4B, $5F, $64, $FF, $14, $1F, $2A, $35, $40, $4B, $5A, $64, $FF, $0F, $17
    db $1F, $27, $2F, $37, $50, $64, $FF, $0A, $15, $20, $2B, $36, $41, $50, $64, $FF

; address loaded by ArenaMenu_RandomModulo52
ArenaMenu_RandomModulo52_Data_7602:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_7602:: ; address name
    db $0E, $76, $0E, $76, $0E, $76, $16, $76, $1E, $76, $26, $76, $01, $53, $05, $0C
    db $24, $0B, $1C, $44, $02, $18, $0F, $10, $13, $15, $45, $FE, $03, $0D, $11, $12
    db $17, $2C, $FD, $FE, $23, $2C, $0D, $0E, $17, $FD, $1E, $FE

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 9 tiles, one row per line
TileRect_0C_762E::
Data_00C_762E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $AA, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $C3, $E1, $E0, $E0, $BF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $A9, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $C3, $E5, $E0, $E0, $BF, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $A8, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E1, $E0, $E0, $E0, $BF, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $A7, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E5, $E0, $E0, $E0, $BF, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 3 x 5 tiles, one row per line
TileRect_0C_76C7::
Data_00C_76C7:: ; address name
    db $C3, $C3, $B7 ; id 0
    db $E0, $BF, $B7 ; id 1
    db $C3, $C3, $B7 ; id 2
    db $E0, $BF, $B7 ; id 3
    db $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 9 tiles, one row per line
TileRect_0C_76D6::
Data_00C_76D6:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $AA, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E1, $E0, $E0, $E0, $BF, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A9, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E2, $E0, $E0, $E0, $BF, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $A8, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E3, $E0, $E0, $E0, $BF, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $A7, $C3, $AA, $A4, $A5, $A6, $A6, $C3, $E5, $E0, $E0, $E0, $BF, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 3 x 5 tiles, one row per line
TileRect_0C_776F::
Data_00C_776F:: ; address name
    db $C3, $C3, $B7 ; id 0
    db $BF, $C3, $B7 ; id 1
    db $C3, $C3, $B7 ; id 2
    db $BF, $C3, $B7 ; id 3
    db $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_0C_777E::
Data_00C_777E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 13 x 7 tiles, one row per line
TileRect_0C_7796::
Data_00C_7796:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F0, $F1, $F2, $F3, $F4, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $A4, $A5, $A6, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F5, $F6, $F7, $F8, $ED, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 8 x 3 tiles, one row per line
TileRect_0C_77F1::
Data_00C_77F1:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $E1, $C3, $E2, $C3, $E3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0234 (C1: no reference found; the bytes form a window frame with the frame tiles used by the referenced rectangles beside it: top row $B0 $B1.. $B2, side columns $B6/$B7, bottom row $B3 $B4.. $B5).
; record: 8 x 5 tiles, one row per line
TileRect_0C_7809::
Data_00C_7809:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $AC, $C3, $AB, $C3, $AA, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A9, $C3, $A8, $C3, $A7, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0C_7831::
Data_00C_7831:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $AE, $AF, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc, ArenaMenu_BGMapAddressAtScroll_Bank0C
ArenaMenu_WriteTwoChoiceCursorAndScriptCommandTypeEtc_Data_784F:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_784F:: ; address name
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

; address loaded by ArenaMenu_WriteTextBuf0AndScreenStateEtc
ArenaMenu_WriteTextBuf0AndScreenStateEtc_Data_7857:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_7857:: ; address name
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4, $8D, $C3, $8F, $C3, $91, $C3, $8D, $C3
    db $8F, $C3, $91, $C3, $B5, $C3, $B7, $C3, $B9, $C3

; address loaded by ArenaMenu_UpdateTwoChoiceCursor_Bank1D, ArenaMenu_SubtractArg1AmountFromGold
ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_7871:: ; address name
    db $64, $00, $F4, $01, $E8, $03, $88, $13, $02, $04, $08, $10

; address loaded by ArenaGridBattle_WriteBattleIntroKindAndEncounterKind
ArenaGridBattle_WriteBattleIntroKindAndEncounterKind_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00C_787D:: ; address name
    db $7F, $78, $85, $78, $8B, $78, $91, $78, $83, $00, $84, $00, $83, $00, $85, $00
    db $86, $00, $87, $00, $88, $00, $89, $00, $88, $00

; E-0236 (C1: ArenaGridBattle_Shared02 sets battle intro 4 and encounter kind 2, reads the word at $7897 + 2 * wGridCursorX, then the word at that pointer + 2 * wScreenCountPlusOne, and copies 6 bytes from it to wEncounterMonsters (three encounter words, as E-0202)).
; record: encounter list for this wGridCursorX
GridEncounterTable::
Data_00C_7897:: ; address name
    dw GridEncounterList0 ; id 0
    dw GridEncounterList1 ; id 1
    dw GridEncounterList2 ; id 2
    dw GridEncounterList3 ; id 3

; E-0236 (C1: list 0 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList0::
Data_00C_789F:: ; address name
    dw GridEncounters0 ; id 0
    dw GridEncounters0_01 ; id 1
    dw GridEncounters0_02 ; id 2

; E-0236 (C1: the three records of GridEncounterList0).
; record: three encounter words copied to wEncounterMonsters
GridEncounters0::
Data_00C_78A5:: ; address name
    dw $008A ; id 0 MonsterTable $08A: WindBeast
    dw $008B ; MonsterTable $08B: Gismo
    dw $008C ; MonsterTable $08C: PomPomBom
GridEncounters0_01:: ; heuristic: grid encounter; C0
Data_00C_78AB:: ; address name
    dw $008D ; id 1 MonsterTable $08D: Devipine
    dw $008E ; MonsterTable $08E: Gulpple
    dw $008F ; MonsterTable $08F: Eggplaton
GridEncounters0_02:: ; heuristic: grid encounter; C0
Data_00C_78B1:: ; address name
    dw $0090 ; id 2 MonsterTable $090: HammerMan
    dw $0091 ; MonsterTable $091: Stubsuck
    dw $0090 ; MonsterTable $090: HammerMan

; E-0236 (C1: list 1 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList1::
Data_00C_78B7:: ; address name
    dw GridEncounters1 ; id 0
    dw GridEncounters1_01 ; id 1
    dw GridEncounters1_02 ; id 2

; E-0236 (C1: the three records of GridEncounterList1).
; record: three encounter words copied to wEncounterMonsters
GridEncounters1::
Data_00C_78BD:: ; address name
    dw $0092 ; id 0 MonsterTable $092: TreeBoy
    dw $0093 ; MonsterTable $093: FooHero
    dw $0092 ; MonsterTable $092: TreeBoy
GridEncounters1_01:: ; heuristic: grid encounter; C0
Data_00C_78C3:: ; address name
    dw $0094 ; id 1 MonsterTable $094: Mommonja
    dw $0095 ; MonsterTable $095: Drygon
    dw $0094 ; MonsterTable $094: Mommonja
GridEncounters1_02:: ; heuristic: grid encounter; C0
Data_00C_78C9:: ; address name
    dw $0096 ; id 2 MonsterTable $096: HerbMan
    dw $0097 ; MonsterTable $097: DanceVegi
    dw $0098 ; MonsterTable $098: MudDoll

; E-0236 (C1: list 2 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList2::
Data_00C_78CF:: ; address name
    dw GridEncounters2 ; id 0
    dw GridEncounters2_01 ; id 1
    dw GridEncounters2_02 ; id 2

; E-0236 (C1: the three records of GridEncounterList2).
; record: three encounter words copied to wEncounterMonsters
GridEncounters2::
Data_00C_78D5:: ; address name
    dw $0099 ; id 0 MonsterTable $099: Shadow
    dw $009A ; MonsterTable $09A: MadCondor
    dw $009B ; MonsterTable $09B: CloudKing
GridEncounters2_01:: ; heuristic: grid encounter; C0
Data_00C_78DB:: ; address name
    dw $009C ; id 1 MonsterTable $09C: Octoreach
    dw $009D ; MonsterTable $09D: Octogon
    dw $009E ; MonsterTable $09E: KingSquid
GridEncounters2_02:: ; heuristic: grid encounter; C0
Data_00C_78E1:: ; address name
    dw $009F ; id 2 MonsterTable $09F: MistyWing
    dw $00A0 ; MonsterTable $0A0: Copycat
    dw $00A1 ; MonsterTable $0A1: NiteWhip

; E-0236 (C1: list 3 of GridEncounterTable).
; record: three encounter words for this wScreenCountPlusOne
GridEncounterList3::
Data_00C_78E7:: ; address name
    dw GridEncounters3 ; id 0
    dw GridEncounters3_01 ; id 1
    dw GridEncounters3_02 ; id 2

; E-0236 (C1: the three records of GridEncounterList3).
; record: three encounter words copied to wEncounterMonsters
GridEncounters3::
Data_00C_78ED:: ; address name
    dw $00A2 ; id 0 MonsterTable $0A2: Goopi
    dw $00A3 ; MonsterTable $0A3: Servant
    dw $00A2 ; MonsterTable $0A2: Goopi
GridEncounters3_01:: ; heuristic: grid encounter; C0
Data_00C_78F3:: ; address name
    dw $00A4 ; id 1 MonsterTable $0A4: ArmyCrab
    dw $00A5 ; MonsterTable $0A5: DarkCrab
    dw $00A4 ; MonsterTable $0A4: ArmyCrab
GridEncounters3_02:: ; heuristic: grid encounter; C0
Data_00C_78F9:: ; address name
    dw $00A6 ; id 2 MonsterTable $0A6: Orochi
    dw $00A7 ; MonsterTable $0A7: Serpentia
    dw $00A8 ; MonsterTable $0A8: GigaDraco

; E-0183 (C1: ArenaRounds_Shared01_Sub01 reads the byte at $78FF + wAreaGraphicsIndex and reduces a random number below it by repeated subtraction before indexing the list).
; record: number of usable entries in the list (39 each)
ArenaEncounterListSizes::
Data_00C_78FF:: ; address name
    db $27 ; id 0
    db $27 ; id 1
    db $27 ; id 2
    db $27 ; id 3
    db $27 ; id 4
    db $27 ; id 5

; E-0183 (C1: ArenaRounds_Shared01_Sub01 doubles wAreaGraphicsIndex, reads the word at $7905 + 2 * index and then the word at that pointer + 2 * the chosen entry; indexes 0-2 share one list).
; record: encounter word list for this wAreaGraphicsIndex
ArenaEncounterLists::
Data_00C_7905:: ; address name
    dw ArenaEncounterList0 ; id 0
    dw ArenaEncounterList0 ; id 1
    dw ArenaEncounterList0 ; id 2
    dw ArenaEncounterList1 ; id 3
    dw ArenaEncounterList2 ; id 4
    dw ArenaEncounterList3 ; id 5

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ArenaMenu_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList0::
Data_00C_7911:: ; address name
    dw $0104 ; entry 0 MonsterTable $104: Lipsy
    dw $0105 ; MonsterTable $105: MultiEyes
    dw $0106 ; MonsterTable $106: Shadow
    dw $0107 ; MonsterTable $107: CaptDead
    dw $0108 ; MonsterTable $108: CurseLamp
    dw $0109 ; MonsterTable $109: Angleron
    dw $010A ; MonsterTable $10A: Gamanian
    dw $010B ; MonsterTable $10B: WhaleMage
    dw $010C ; MonsterTable $10C: SpotKing
    dw $010D ; MonsterTable $10D: SkyDragon
    dw $010E ; MonsterTable $10E: Tonguella
    dw $010F ; MonsterTable $10F: Saccer
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
    dw $011A ; MonsterTable $11A: Clawster
    dw $011B ; MonsterTable $11B: MerTiger
    dw $0152 ; MonsterTable $152: DragonKid
    dw $0153 ; MonsterTable $153: DuckKite
    dw $0154 ; MonsterTable $154: WingTree
    dw $0155 ; MonsterTable $155: GiantSlug
    dw $0156 ; MonsterTable $156: Gophecada
    dw $0157 ; MonsterTable $157: RotRaven
    dw $0158 ; MonsterTable $158: Chamelgon
    dw $0159 ; MonsterTable $159: MadPecker
    dw $015A ; MonsterTable $15A: MadPlant
    dw $015B ; MonsterTable $15B: FaceTree
    dw $015C ; MonsterTable $15C: BeanMan
    dw $015D ; MonsterTable $15D: Catapila
    dw $015E ; MonsterTable $15E: Facer
    dw $015F ; MonsterTable $15F: Voodoll
    dw $0160 ; MonsterTable $160: Golem
    dw $0161 ; MonsterTable $161: RogueWave

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ArenaMenu_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList1::
Data_00C_7961:: ; address name
    dw $0136 ; entry 0 MonsterTable $136: Skeletor
    dw $0137 ; MonsterTable $137: StoneMan
    dw $0138 ; MonsterTable $138: FishRider
    dw $0139 ; MonsterTable $139: AxeShark
    dw $013A ; MonsterTable $13A: Aquadon
    dw $013B ; MonsterTable $13B: Digong
    dw $013C ; MonsterTable $13C: MetalKing
    dw $013D ; MonsterTable $13D: Serpentia
    dw $013E ; MonsterTable $13E: Coatol
    dw $013F ; MonsterTable $13F: Orochi
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
    dw $014A ; MonsterTable $14A: KingSquid
    dw $014B ; MonsterTable $14B: Grakos
    dw $0162 ; MonsterTable $162: BoxSlime
    dw $0163 ; MonsterTable $163: SlimeBorg
    dw $0164 ; MonsterTable $164: DarkHorn
    dw $0165 ; MonsterTable $165: ManEater
    dw $0166 ; MonsterTable $166: Snapper
    dw $0167 ; MonsterTable $167: GhosTree
    dw $0168 ; MonsterTable $168: SkulRider
    dw $0169 ; MonsterTable $169: Gigantes
    dw $016A ; MonsterTable $16A: Skulpent
    dw $016B ; MonsterTable $16B: Aquarella
    dw $016C ; MonsterTable $16C: GoldSlime
    dw $016D ; MonsterTable $16D: GranSlime
    dw $016E ; MonsterTable $16E: Divinegon
    dw $016F ; MonsterTable $16F: KingLeo
    dw $0170 ; MonsterTable $170: RainHawk
    dw $0171 ; MonsterTable $171: Durran
    dw $0172 ; MonsterTable $172: Lazamanus
    dw $0173 ; MonsterTable $173: GoldGolem

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ArenaMenu_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList2::
Data_00C_79B1:: ; address name
    dw $021E ; entry 0 MonsterTable $21E: Phoenix
    dw $021F ; MonsterTable $21F: Shantak
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
    dw $022A ; MonsterTable $22A: AxeShark
    dw $022B ; MonsterTable $22B: StoneMan
    dw $022C ; MonsterTable $22C: MedusaEye
    dw $022D ; MonsterTable $22D: MadHornet
    dw $022E ; MonsterTable $22E: Oniono
    dw $022F ; MonsterTable $22F: TailEater
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
    dw $023A ; MonsterTable $23A: ArmyCrab
    dw $023B ; MonsterTable $23B: ArcDemon
    dw $023C ; MonsterTable $23C: 1EyeClown
    dw $023D ; MonsterTable $23D: MadKnight
    dw $023E ; MonsterTable $23E: CaptDead
    dw $023F ; MonsterTable $23F: Servant
    dw $0240 ; MonsterTable $240: LavaMan
    dw $0241 ; MonsterTable $241: BombCrag
    dw $0242 ; MonsterTable $242: RushFish
    dw $0243 ; MonsterTable $243: WhaleMage
    dw $0244 ; MonsterTable $244: SpotKing
    dw $0245 ; MonsterTable $245: SlimeBorg

; E-0183 (C1: the chosen word is stored in wArenaList2 (3 rounds x 3 words) and ArenaMenu_Case1C_Sub01 copies one round's three words to wEncounterMonsters; each entry is drawn at most three times, counted in wArenaList).
; record: 40 encounter words (entries 0-38 are drawn; entry 39 is not reached)
ArenaEncounterList3::
Data_00C_7A01:: ; address name
    dw $01FF ; entry 0 MonsterTable $1FF: Bubblemon
    dw $0200 ; MonsterTable $200: RogueNite
    dw $0201 ; MonsterTable $201: Puppetor
    dw $0202 ; MonsterTable $202: Exaucers
    dw $0203 ; MonsterTable $203: WhaleMage
    dw $0204 ; MonsterTable $204: MedusaEye
    dw $0246 ; MonsterTable $246: LizardMan
    dw $0247 ; MonsterTable $247: GreatDrak
    dw $0248 ; MonsterTable $248: MadCat
    dw $0249 ; MonsterTable $249: Emyu
    dw $024A ; MonsterTable $24A: HornBeet
    dw $024B ; MonsterTable $24B: Ogre
    dw $024C ; MonsterTable $24C: PutrePup
    dw $024D ; MonsterTable $24D: Roboster2
    dw $024E ; MonsterTable $24E: GoldGolem
    dw $024F ; MonsterTable $24F: WhiteKing
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
    dw $026A ; MonsterTable $26A: ZapBird
    dw $026B ; MonsterTable $26B: FooHero
    dw $026C ; MonsterTable $26C: GoatHorn
    dw $026D ; MonsterTable $26D: Inverzon
    dw $026E ; MonsterTable $26E: Voodoll
    dw $026F ; MonsterTable $26F: AxeShark
    dw $0270 ; MonsterTable $270: Digong
    dw $0271 ; MonsterTable $271: Swordgon
    dw $0272 ; MonsterTable $272: GigaDraco
    dw $0273 ; MonsterTable $273: SuperTen
    dw $0274 ; MonsterTable $274: BigRoost
    dw $0275 ; MonsterTable $275: GhosTree
    dw $0276 ; MonsterTable $276: WarMantis

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_0C_7A51:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7A5C, Script_0C_7A59, Script_0C_7A56
Script_0C_7A56:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A5F
Script_0C_7A59:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AFE
Script_0C_7A5C:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A75
Script_0C_7A5F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7A6E, Script_0C_7A6B, Script_0C_7A65
Script_0C_7A65:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $0025 ; '*: Too bad you didn't make'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7A6B:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A5F
Script_0C_7A6E:: ; heuristic: event script entry or jump target; C0
    script_message $4020 ; '*: Congratulations! You did it! You've'
    script_command SCRIPT_ARENA
    script_jump Script_0C_7ADB
Script_0C_7A75:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7A8D, Script_0C_7A87, Script_0C_7A81, Script_0C_7A7B
Script_0C_7A7B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8003 ; '*: Train some more, and see'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7A81:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; '*: You can't try that Class'
    script_jump Script_0C_7A75
Script_0C_7A87:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; '*: You've finished that Class.'
    script_jump Script_0C_7A75
Script_0C_7A8D:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; '*: Let me confirm that-the 0'
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7A9E, Script_0C_7A98, Script_0C_7A95
Script_0C_7A95:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7A75
Script_0C_7A98:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; '*: Not enough gold for that'
    script_jump Script_0C_7A75
Script_0C_7A9E:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; '*: Good luck! I'll cheer for'
Script_0C_7AA1:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7AAD, Script_0C_7AAA, Script_0C_7AA7
Script_0C_7AA7:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AEB
Script_0C_7AAA:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AA1
Script_0C_7AAD:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7AB0
Script_0C_7AB0:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7AC8, Script_0C_7AC2, Script_0C_7ABC, Script_0C_7AB6
Script_0C_7AB6:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $0024 ; '*: Congratulations! You did it! You've'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7ABC:: ; heuristic: event script entry or jump target; C0
    script_message $4023 ; '*: Congratulations! You did it! You've'
    script_jump Script_0C_7ACB
Script_0C_7AC2:: ; heuristic: event script entry or jump target; C0
    script_message $4022 ; '*: Congratulations! You did it! You've'
    script_jump Script_0C_7ACB
Script_0C_7AC8:: ; heuristic: event script entry or jump target; C0
    script_message $4021 ; '*: Congratulations! You did it! You've'
Script_0C_7ACB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7ACF, Script_0C_7AD5
Script_0C_7ACF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $802A ; '0 received the Magic Key.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7AD5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $802B ; '*: Oh, but your key ring'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7ADB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7ADF, Script_0C_7AE5
Script_0C_7ADF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $802D ; '0 received the Pirate Key.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7AE5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $802B ; '*: Oh, but your key ring'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7AEB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7AF5, Script_0C_7AEF
Script_0C_7AEF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $0026 ; '*: Too bad you didn't make'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7AF5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $0025 ; '*: Too bad you didn't make'
    script_command SCRIPT_MENU_CLOSE
    script_end
    db $00, $0B, $C0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_0C_7AFE:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B08, Script_0C_7B02
Script_0C_7B02:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8009 ; '*: Oh The crowd wanted to'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7B08:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
Script_0C_7B0A:: ; heuristic: event script entry or jump target; C0
    script_choice_jump Script_0C_7B2F, Script_0C_7B29, Script_0C_7B23, Script_0C_7B1D, Script_0C_7B17, Script_0C_7B11
Script_0C_7B11:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '*: The E Class should do.'
    script_jump Script_0C_7B32
Script_0C_7B17:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; '*: It could get rough out'
    script_jump Script_0C_7B32
Script_0C_7B1D:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; '*: It could get rough out'
    script_jump Script_0C_7B32
Script_0C_7B23:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; '*: The B Class should be'
    script_jump Script_0C_7B32
Script_0C_7B29:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; '*: The A Class should be'
    script_jump Script_0C_7B32
Script_0C_7B2F:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; '*: The S Class should be'
Script_0C_7B32:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B3C, Script_0C_7B36
Script_0C_7B36:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8009 ; '*: Oh The crowd wanted to'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7B3C:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_message $C012 ; '*: Is 0 Class OK?'
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B50, Script_0C_7B49, Script_0C_7B45
Script_0C_7B45:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_jump Script_0C_7B0A
Script_0C_7B49:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; '*: You need more gold to'
    script_command SCRIPT_ARENA
    script_jump Script_0C_7B0A
Script_0C_7B50:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_message $C013 ; '*: I hope you do well!'
Script_0C_7B54:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B60, Script_0C_7B5D, Script_0C_7B5A
Script_0C_7B5A:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7B99
Script_0C_7B5D:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7B54
Script_0C_7B60:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7B63
Script_0C_7B63:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_message $402F ; '*: Congratulations! You did it! You've'
    script_message $C031 ; '*: Do you want the right'
Script_0C_7B6A:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B7B, Script_0C_7B6E
Script_0C_7B6E:: ; heuristic: event script entry or jump target; C0
    script_message $C030 ; '*: Do you want the left'
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B7B, Script_0C_7B75
Script_0C_7B75:: ; heuristic: event script entry or jump target; C0
    script_message $C031 ; '*: Do you want the right'
    script_jump Script_0C_7B6A
Script_0C_7B7B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7B81, Script_0C_7B87, Script_0C_7B8D, Script_0C_7B93
Script_0C_7B81:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8032 ; '*: Your prize is one G!'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7B87:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8033 ; '*: Your prize is a Magic'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7B8D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8034 ; '*: Oh, but you have no'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7B93:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $8035 ; '*: Oh, but your key ring'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7B99:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ARENA
    script_choice_jump Script_0C_7BA3, Script_0C_7B9D
Script_0C_7B9D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $0029 ; '*: You lost? That's too bad.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7BA3:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MENU_CLOSE
    script_message $0028 ; '*: You lost? That's too bad.'
    script_command SCRIPT_MENU_CLOSE
    script_end
Script_0C_7BA9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7BB0, Script_0C_7BAD
Script_0C_7BAD:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7BBA
Script_0C_7BB0:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '*: Ah, you have some TinyMedals?'
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7BBA, Script_0C_7BB7
Script_0C_7BB7:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; '*: But, I can't take this'
Script_0C_7BBA:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7BC1, Script_0C_7BBE
Script_0C_7BBE:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7C41
Script_0C_7BC1:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; '*: I have 0 of your'
    script_message $C015 ; '*: Want to trade medals for'
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7BD1, Script_0C_7BCB
Script_0C_7BCB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8014 ; '*: I hope you'll find many'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_0C_7BD1:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; '*: Which prize do you want?'
Script_0C_7BD4:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_command SCRIPT_MEDAL_PRIZES
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7BE4, Script_0C_7BE1, Script_0C_7BDB
Script_0C_7BDB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8014 ; '*: I hope you'll find many'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_0C_7BE1:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0C_7BD4
Script_0C_7BE4:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; '*: I'll trade for 0 TinyMedals.'
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7BF7, Script_0C_7BF0, Script_0C_7BEC
Script_0C_7BEC:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; '*: That requires more TinyMedals.'
    script_command SCRIPT_MEDAL_PRIZES
Script_0C_7BF0:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; '*: Which prize do you want?'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BD4
Script_0C_7BF7:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7C12, Script_0C_7C0B, Script_0C_7C04, Script_0C_7BFD
Script_0C_7BFD:: ; heuristic: event script entry or jump target; C0
    script_message $C01B ; '*: You have no more room'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C04:: ; heuristic: event script entry or jump target; C0
    script_message $C01A ; '*: Your key ring is already'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C0B:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; '*: You don't have any room'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C12:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7C1F, Script_0C_7C16
Script_0C_7C16:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; '*: Fine, we shall trade.'
    script_message $C01D ; '*: I'll send the egg to'
    script_jump Script_0C_7C22
Script_0C_7C1F:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; '*: Fine, we shall trade.'
Script_0C_7C22:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_choice_jump Script_0C_7C3D, Script_0C_7C36, Script_0C_7C2F, Script_0C_7C28
Script_0C_7C28:: ; heuristic: event script entry or jump target; C0
    script_message $C020 ; '*: You have no more room'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C2F:: ; heuristic: event script entry or jump target; C0
    script_message $C01F ; '*: You can't hold any more'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C36:: ; heuristic: event script entry or jump target; C0
    script_message $C01E ; '*: You can't take any more'
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C3D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MEDAL_PRIZES
    script_jump Script_0C_7BF0
Script_0C_7C41:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8024 ; '*: At minimum, you must have'
    script_command SCRIPT_BREED_CLOSE
    script_end
    ds $3B9, $00
