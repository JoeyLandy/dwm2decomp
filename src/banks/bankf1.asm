SECTION "Bank F1", ROMX[$4000], BANK[$F1]
    db $F1

; by its step: the 'Gift / Exit' window, a cursor on screen block $32, then a string
; 1 call site from 1 routine (e.g. PauseMenu_State4)
; reads: wTemp0
PauseMenu_State4_GiftMenu::
Func_0F1_4001:: ; address name
    ld a, [wTemp0]
    rst $00
    dw PauseMenu_State4_GiftMenu_ShowChoices
    dw PauseMenu_State4_GiftMenu_ChooseGift
    dw PauseMenu_State4_GiftMenu_GiveGift

; by its step: the 'Gift / Exit' window and its cursor
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State4_GiftMenu_ShowChoices::
Jump_0F1_400B:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit
    dw PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1

; entry 0 of the `rst $00` table in PauseMenu_State4_GiftMenu_ShowChoices
; no direct call (reached through a table, a jump or a vector)
; reads: wLevelUpGains
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory, wCounterPtr0Lo
; points at: wTemp1
PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit::
Jump_0F1_4013:: ; address name
    ld a, [wLevelUpGains]
    or a, a
    call nz, RefreshRecordListAndNameTiles_BankF1
    call SetupInventoryMenuPages_BankF1
    call BuildInventoryScreenBase_BankF1
    call SetMenuRowsForPage_BankF1
    call ShowSelectedItemDescription_BankF1
    call CopyTileBufferToBGMap_BankF1
    ld hl, vTiles1 + $720
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0107
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $1B
    ld [wStringIndex], a ; 'GiftExit'
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_BankF0
    ld hl, wTemp1
    inc [hl]
    xor a, a
    ld [wCounterPtr0Lo], a
    ret

; entry 1 of the `rst $00` table in PauseMenu_State4_GiftMenu_ShowChoices
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory, wJoypadPressed, wJoypadPressedRepeat, wMenuRowCount, wMenuPage, wMenuCursor
; writes: wDataBankSave, wInventorySlot, wItemId, wTemp1, wSubMenuCursor
; points at: wMenuCursor, wInventory, wTextBuf2, wPlayerName, wTextBuf0, wTemp0
PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1::
Jump_0F1_4057:: ; address name
    ld a, [wInventory]
    or a, a
    jr nz, .call_update_menu_cursor_bank_f1
    ld a, [wJoypadPressed]
    jr .check_bit1

.call_update_menu_cursor_bank_f1:
    ld de, PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1_Data
    ld hl, wMenuCursor
    call UpdateMenuCursor_BankF1
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, .skip
    ld a, [wMenuRowCount]
    cp a, $01
    ret z
    call ShowSelectedItemDescription_BankF1
    ret

.skip:
    ld hl, wMenuCursor
    bit 7, [hl]
    jr z, .check_joypad_pressed
    res 7, [hl]
    call SetMenuRowsForPage_BankF1
    call ShowSelectedItemDescription_BankF1
    call ShowInventoryPageItemNames_BankF1
    call DrawMenuPageNumber_BankF1
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuPage]
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    add a, c
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
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wSubMenuCursor], a
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    ld a, $40
    ld [wDataBankSave], a
    farcall ExitPauseMenuToField
    ret

.check_bit2:
    bit 2, a
    ret z
    farcall SortInventory
    call ShowSelectedItemDescription_BankF1
    call ShowInventoryPageItemNames_BankF1
    ret

; by its step: screen block $32 with a cursor
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State4_GiftMenu_ChooseGift::
Jump_0F1_40FC:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State4_GiftMenu_ChooseGift_BuildScreenBlock32WithCursor_BankF1AndStep
    dw PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1

; entry 0 of the `rst $00` table in PauseMenu_State4_GiftMenu_ChooseGift
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_State4_GiftMenu_ChooseGift_BuildScreenBlock32WithCursor_BankF1AndStep::
Jump_0F1_4104:: ; address name
    call BuildScreenBlock32WithCursor_BankF1
    call CopyTileBufferToBGMap_BankF1
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State4_GiftMenu_ChooseGift
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor
; writes: wTemp1, wTemp0
; points at: wSubMenuCursor, wTemp0
PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1::
Jump_0F1_4119:: ; address name
    ld de, PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1_Data
    ld hl, wSubMenuCursor
    call UpdateMenuCursor_BankF1
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, [wSubMenuCursor]
    and a, $01
    and a, a
    jr z, .check_sub_menu_cursor
    jr .skip

.check_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    and a, $01
    add a, $02
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ret

.check_bit1:
    bit 1, a
    ret z

.skip:
    ld hl, wTemp0
    dec [hl]
    xor a, a
    ld [wTemp1], a
    ret

; by its step: sets the amount and counter pointer, rebuilds block $32 and shows the result string
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State4_GiftMenu_GiveGift::
Jump_0F1_414E:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State4_GiftMenu_GiveGift_WriteArg1AndCounterPtr0LoEtc
    dw PauseMenu_State4_GiftMenu_GiveGift_ClearWindowAndBuildBlock32WithCursor_BankF1
    dw PauseMenu_State4_GiftMenu_GiveGift_BeginStringDisplay_BankF0_48A0AndStep
    dw PauseMenu_State4_GiftMenu_GiveGift_WaitTextFlags

; entry 0 of the `rst $00` table in PauseMenu_State4_GiftMenu_GiveGift
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wInventorySlot
; writes: wArg1, wCounterPtr0Lo, wDataBankSave, wStringIndex
; points at: wInventory, wTemp1
PauseMenu_State4_GiftMenu_GiveGift_WriteArg1AndCounterPtr0LoEtc::
Jump_0F1_415A:: ; address name
    ld a, [wItemId]
    cp a, $1F
    jr z, .skip3
    cp a, $21
    jr z, .skip3
    ld b, $2B
    ld c, $2E
    cp a, c
    jr nc, .skip
    cp a, b
    ccf

.skip:
    jr c, .skip3
    ld b, $2F
    ld c, $40
    cp a, c
    jr nc, .skip2
    cp a, b
    ccf

.skip2:
    jr c, .skip3
    ld b, $54
    ld c, $5A
    jr c, .skip3
    jr .set_arg1

.skip3:
    ld a, $22
    jr .set_string_index

.set_arg1:
    ld [wArg1], a
    farcall RecordGiftAndMaybeApplyPrevious
    ld a, $FF
    ld [wCounterPtr0Lo], a
    ld a, $69
    call QueueSoundEffect
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $00
    farcall CompactInventory
    ld a, $40
    ld [wDataBankSave], a
    farcall ExitPauseMenuToField
    ret

.set_string_index:
    ld [wStringIndex], a
    ld hl, wTemp1
    inc [hl]
    ld a, $69
    call QueueSoundEffect
    ret

; entry 1 of the `rst $00` table in PauseMenu_State4_GiftMenu_GiveGift
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_State4_GiftMenu_GiveGift_ClearWindowAndBuildBlock32WithCursor_BankF1::
Jump_0F1_41C6:: ; address name
    call ClearWindowAndBuildBlock32WithCursor_BankF1
    call CopyTileBufferToBGMap_BankF1
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State4_GiftMenu_GiveGift
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wTemp1
PauseMenu_State4_GiftMenu_GiveGift_BeginStringDisplay_BankF0_48A0AndStep::
Jump_0F1_41D1:: ; address name
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_BankF0_48A0
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State4_GiftMenu_GiveGift
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp0, wTemp1
PauseMenu_State4_GiftMenu_GiveGift_WaitTextFlags::
Jump_0F1_41E0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ret

; clears the screen buffer, copies blocks $0B and $0C and, with items, block $0D and the page indicator (page wMenuPage of wC0A7) (E-0124)
; 2 call sites from 2 routines (e.g. PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit, BuildScreenBlock32WithCursor_BankF1)
; reads: wInventory, wMenuItemCount, wMenuPage
BuildInventoryScreenBase_BankF1::
Func_0F1_41EE:: ; address name
    call ClearScreenTileBuffer_BankF1
    ld e, $0B
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld a, [wInventory]
    or a, a
    ret z
    ld e, $0D
    farcall CopyBlockToTileBuffer
    ld a, [wMenuItemCount]
    cp a, $02
    jr c, .return
    ld hl, wScreenTileBuffer + $10E
    ld a, $C5
    ld [hl+], a
    ld a, [wMenuPage]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [wMenuItemCount]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6

.return:
    ret

; runs Func_0F1_41EE, copies block $32 and draws the cursor for wC46E & 7 (E-0122)
; 4 call sites from 4 routines (e.g. PauseMenu_State4_GiftMenu_ChooseGift_BuildScreenBlock32WithCursor_BankF1AndStep, ClearWindowAndBuildBlock32WithCursor_BankF1, BuildItemScreenForWItemId_BankF1, BuildScreenBlocks32And0F_BankF1)
; reads: wMenuCursor
BuildScreenBlock32WithCursor_BankF1::
Func_0F1_422D:: ; address name
    call BuildInventoryScreenBase_BankF1
    ld e, $32
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and a, $07
    ld hl, PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; builds block $32 with the cursor, blocks $11 and $1B and the rectangle chosen by wItemId, then runs Func_0F1_442F (E-0122)
; 1 call site from 1 routine (e.g. BuildItemScreenWithRecordCursor_BankF1)
; reads: wItemId
BuildItemScreenForWItemId_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_4244:: ; address name
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $11
    farcall CopyBlockToTileBuffer
    ld e, $1B
    farcall CopyBlockToTileBuffer
    ld a, [wItemId]
    ld hl, BuildItemScreenForWItemId_BankF1_Data_4613
    add_a_to_hl
    ld a, [hl]
    ld hl, BuildItemScreenForWItemId_BankF1_Data_4676
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_BankF1
    call BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc
    ret

; fills tiles, builds the item screen, copies block $10 and draws the cursor for wC46D & 3 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
BuildItemScreenWithRecordCursor_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_4276:: ; address name
    call FillTilesFromRequest
    call BuildItemScreenForWItemId_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and a, $03
    ld hl, BuildItemScreenWithRecordCursor_BankF1_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; builds block $32 with the cursor and copies block $0F (E-0122)
; 1 call site from 1 routine (e.g. BuildScreenBlocks32And0FWithCursor_BankF1)
BuildScreenBlocks32And0F_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_4290:: ; address name
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $0F
    farcall CopyBlockToTileBuffer
    ret

; fills tiles, builds blocks $32 and $0F, copies block $10 and draws the cursor for wC46F & 3 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor
BuildScreenBlocks32And0FWithCursor_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_429C:: ; address name
    call FillTilesFromRequest
    call BuildScreenBlocks32And0F_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and a, $03
    ld hl, PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; clears the default window, fills tiles, builds block $32, copies block $10 and draws the cursor for wC46F & 3 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_State4_GiftMenu_GiveGift_ClearWindowAndBuildBlock32WithCursor_BankF1)
; reads: wSubMenuCursor
ClearWindowAndBuildBlock32WithCursor_BankF1::
Func_0F1_42B6:: ; address name
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and a, $03
    ld hl, PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; the same instruction sequence as ShowSelectedItemDescription (bank $03) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 4 call sites from 2 routines (e.g. PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1, PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit)
; reads: wMenuPage, wMenuCursor
; writes: wStringIndex, wStringCategory
; points at: wInventory
ShowSelectedItemDescription_BankF1::
Func_0F1_42D9:: ; address name
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    and a, $0F
    add a, c
    ld c, a
    ld b, $00
    ld hl, wInventory
    add hl, bc
    ld a, [hl]
    cp a, $1F
    jr nz, .set_string_index
    ld a, $6F

.set_string_index:
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call ShowStringBank08AtTilesHL_BankF1
    ret

; shows the four item names of inventory page wMenuPage (or the empty-inventory text and wC61E entries) at vTiles2 + $5C0 onward, preserving the window (E-0129)
; 2 call sites from 1 routine (e.g. PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wInventory, wMenuPage
; writes: wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi
; points at: wInventory
ShowInventoryPageItemNames_BankF1::
Func_0F1_4307:: ; address name
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
    or a, a
    jr nz, .check_menu_page
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $5C0
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
    and a, $0F
    add a, a
    add a, a
    ld de, wInventory
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $04
    ld hl, vTiles2 + $5C0

.set_string_category_to_05:
    ld a, $05
    ld [wStringCategory], a

.loop:
    ld a, [de]
    cp a, $FF
    jr nz, .set_string_index
    xor a, a

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

; when wMenuPageCount is non-zero, writes tile $E1 + (wMenuPage & $0F) at vBGMap0 + $10F (E-0067) (the same 20 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1)
; reads: wMenuPageCount, wMenuPage
DrawMenuPageNumber_BankF1::
Func_0F1_43A0:: ; address name
    ld a, [wMenuPageCount]
    or a, a
    jr z, .return
    ld a, [wMenuPage]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte

.return:
    ret

; when wMenuPage & $0F = wC0A7 - 1 (the last page): wMenuRowCount = wMenuLastPageRows and the cursor row wC46E is clamped below it; otherwise wMenuRowCount = 4; then clears bit 7 of wMenuPage (E-0064) (the same 44 bytes appear in 3 banks)
; 2 call sites from 2 routines (e.g. PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1, PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit)
; reads: wMenuItemCount, wMenuPage, wMenuLastPageRows, wMenuCursor
; writes: wMenuRowCount, wMenuCursor
; points at: wMenuPage
SetMenuRowsForPage_BankF1::
Func_0F1_43B4:: ; address name
    ld a, [wMenuItemCount]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    cp a, c
    jr nz, .set_menu_row_count_to_04
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wMenuCursor]
    cp a, c
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

; counts wInventory items until a $00 or $FF byte (24 slots); a $FF ends the list and that slot and the rest are rewritten as $00. Pages of 4: wMenuPageCount = wC0A7 = ceil(count / 4), at least 1; wMenuLastPageRows = count mod 4, or 4; wMenuRowCount = wMenuLastPageRows when wMenuPage equals the page count, else 4 (E-0067) (the same 79 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit)
; reads: wMenuPage, wMenuLastPageRows
; writes: wMenuPageCount, wMenuItemCount, wMenuLastPageRows, wMenuRowCount
; points at: wInventory
SetupInventoryMenuPages_BankF1::
Func_0F1_43E0:: ; address name
    ld hl, wInventory
    ld bc, $1800

.loop:
    ld a, [hl+]
    or a, a
    jr z, .call_divide_b_by_a
    cp a, $FF
    jr z, .next
    inc c
    dec b
    jr nz, .loop
    jr .call_divide_b_by_a

.next:
    dec hl
    xor a, a

.loop2:
    ld [hl+], a
    dec b
    jr nz, .loop2

.call_divide_b_by_a:
    ld b, c
    ld a, $04
    call DivideBByA
    ld a, c
    and a, $03
    jr z, .skip
    inc b

.skip:
    ld a, b
    cp a, $00
    jr nz, .set_menu_page_count
    inc b
    ld a, b

.set_menu_page_count:
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    and a, $03
    or a, a
    jr nz, .set_menu_last_page_rows
    ld a, $04

.set_menu_last_page_rows:
    ld [wMenuLastPageRows], a
    ld a, [wMenuPage]
    cp a, b
    jr nz, .set_menu_row_count_to_04
    ld a, [wMenuLastPageRows]
    jr .set_menu_row_count

.set_menu_row_count_to_04:
    ld a, $04

.set_menu_row_count:
    ld [wMenuRowCount], a
    ret

; only called from BuildItemScreenForWItemId_BankF1 (E-0047)
; 1 call site from 1 routine (e.g. BuildItemScreenForWItemId_BankF1)
; reads: wMenuSelectedMember, wItemId, hTemp0, hTemp1
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, hTemp0, hTemp1, wScreenTileBuffer, wTextWindowTileLo, ...
BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc:: ; heuristic: follows a terminator; C0
Func_0F1_442F:: ; address name
    ld a, [wMenuSelectedMember]
    ld c, a
    ld a, [wItemId]
    ld hl, BuildItemScreenForWItemId_BankF1_Data_4613
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    pop af
    or a, a
    jr z, .skip
    cp a, $01
    jr z, .call_sram_record_address_mapped
    cp a, $02
    jr z, .call_map_index_via_party_list
    cp a, $03
    jr z, .skip2
    cp a, $04
    jr z, .skip3
    cp a, $05
    jr z, .skip4
    cp a, $06
    jr z, .skip5
    cp a, $07
    jr z, .call_sram_record_address_mapped3
    jp .call_sram_record_address_mapped5

.skip:
    ld a, c
    ld c, $5B
    jr .call_sram_record_address_mapped2

.call_sram_record_address_mapped:
    ld a, c
    ld c, $5F

.call_sram_record_address_mapped2:
    call SRAMRecordAddressMapped
    ld a, [hl+]
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
    ld c, $6B
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
    ld de, wWindowTileBuffer + $1D
    call WriteDecimalDigitTiles
    ld a, $C3
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
    ld hl, BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc_Data
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, vTiles2 + $1A0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankF1
    pop af
    ld hl, wWindowTileBuffer + $19
    ld c, a
    ld b, c
    ld a, $1A

.loop:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop
    ld a, $09
    sub a, c
    ld b, a
    or a, a
    jr z, .set_text_window_tile_lo
    ld a, $C3

.loop2:
    ld [hl+], a
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
    or a, a
    jr z, .set_string_index
    add a, $3F

.set_string_index:
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    ld hl, vTiles2 + $1A0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankF1
    pop af
    ld hl, RecordA4StringTileCounts_F1
    add a, a
    add_a_to_hl
    ld b, [hl]
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld hl, wScreenTileBuffer + $141
    ld a, b
    ld c, a
    or a, a
    jr z, .skip6
    ld a, $1A

.loop3:
    ld [hl+], a
    inc a
    dec b
    jr nz, .loop3
    ld d, a

.skip6:
    ld a, $07
    sub a, c
    cp a, $00
    jr z, .skip7
    ld b, a
    ld a, $C3

.loop4:
    ld [hl+], a
    dec b
    jr nz, .loop4

.skip7:
    ld hl, wWindowTileBuffer + $19
    ld b, $07
    ld a, c
    or a, a
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
    cp a, $00
    jr z, .skip8
    ld a, d
    ld [hl+], a
    inc d
    dec b
    jr nz, .loop5

.skip8:
    ld b, $03

.skip9:
    ld a, $C3

.loop6:
    ld [hl+], a
    dec b
    jr nz, .loop6
    jr .done

.read_menu_selected_member:
    ld a, [wMenuSelectedMember]
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    bit 7, [hl]
    call nz, SetWC2DFTileC2_BankF1
    bit 2, [hl]
    call nz, SetWC2DFTileC1_BankF1
    bit 0, [hl]
    call nz, SetWC2DETileC0_BankF1

.done:
    xor a, a
    ld [rRAMG], a
    ret

; wC2DF = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc)
; writes: wScreenTileBuffer
SetWC2DFTileC2_BankF1::
Func_0F1_459E:: ; address name
    ld a, $C2
    ld [wScreenTileBuffer + $147], a
    ret

; wC2DF = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc)
; writes: wScreenTileBuffer
SetWC2DFTileC1_BankF1::
Func_0F1_45A4:: ; address name
    ld a, $C1
    ld [wScreenTileBuffer + $147], a
    ret

; wC2DE = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc)
; writes: wScreenTileBuffer
SetWC2DETileC0_BankF1::
Func_0F1_45AA:: ; address name
    ld a, $C0
    ld [wScreenTileBuffer + $146], a
    ret

; address loaded by BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc
BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_45B0:: ; address name
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

; E-0239 (C1: after showing string category 5, index (record byte $A4) + $3F (when non-zero) into tiles from vTiles2 + $1A0, the code reads the pair at 2 * (record byte $A4): byte 0 tiles from $1A go into wScreenTileBuffer + $141 (the rest of 7 filled with $C3), byte 1 continues the tile numbers at wWindowTileBuffer + $19; 36 pairs; the bank $03 and $F1 copies are identical).
; record: tiles of the first row, tiles of the second row
RecordA4StringTileCounts_F1::
Data_0F1_45CB:: ; address name
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

; address loaded by BuildItemScreenForWItemId_BankF1, BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc
BuildItemScreenForWItemId_BankF1_Data_4613:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_4613:: ; address name
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

; address loaded by BuildItemScreenForWItemId_BankF1
BuildItemScreenForWItemId_BankF1_Data_4676:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_4676:: ; address name
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry00
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry01
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry02
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry03
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry04
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry05
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry06
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry07
    dw BuildItemScreenForWItemId_BankF1_Data_4676_Entry08

; LZSS-compressed asset: 253 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_4688:: ; address name
    db $41, $01, $0C, $03, $FB, $FC, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 258 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_46B0:: ; address name
    db $41, $01, $0C, $03, $FD, $FE, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 261 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_46D8:: ; address name
    db $41, $01, $0C, $03, $F6, $F7, $F8, $F9, $FA, $0E, $0F, $10, $11, $12, $13, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $1A, $1B, $1C, $1D
    db $1E, $1F, $20, $21, $22, $C3, $C3, $C3

; LZSS-compressed asset: 273 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_4700:: ; address name
    db $41, $01, $0C, $03, $0B, $0C, $0D, $ED
    ds $20, $C3

; LZSS-compressed asset: 302 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_4728:: ; address name
    db $41, $01, $0C, $03, $FF, $00, $01, $ED
    ds $20, $C3

; LZSS-compressed asset: 305 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_4750:: ; address name
    db $41, $01, $0C, $03, $02, $03, $04, $ED
    ds $20, $C3

; LZSS-compressed asset: 310 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_4778:: ; address name
    db $41, $01, $0C, $03, $05, $06, $07, $ED
    ds $20, $C3

; LZSS-compressed asset: 313 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_47A0:: ; address name
    db $41, $01, $0C, $03, $08, $09, $0A, $ED
    ds $20, $C3

; LZSS-compressed asset: 317 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BuildItemScreenForWItemId_BankF1_Data_4676_Entry08:: ; heuristic: target of a monotone pointer table; C0
Data_0F1_47C8:: ; address name
    db $41, $01, $0C, $03
    ds $24, $C3
    db $AF, $EA, $A6, $C0, $AF, $EA, $6E, $C4, $CD, $E0, $43, $21, $A6, $C0, $2A, $BE
    db $38, $04, $2B, $35, $18, $F8, $CD, $07, $43, $AF, $EA, $A0, $C0, $EA, $A1, $C0
    db $C9

; the same 57 bytes as CopyTileBufferToBGMap (03:42DA)
; 3 call sites from 3 routines (e.g. PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit, PauseMenu_State4_GiftMenu_ChooseGift_BuildScreenBlock32WithCursor_BankF1AndStep, PauseMenu_State4_GiftMenu_GiveGift_ClearWindowAndBuildBlock32WithCursor_BankF1)
; points at: wScreenTileBuffer
CopyTileBufferToBGMap_BankF1::
Func_0F1_4811:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

.loop:
    push bc
    push hl
    push de

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByte
    ld a, l
    and a, $1F
    cp a, $1F
    jr z, .skip
    inc hl
    jr .next

.skip:
    ld a, l
    and a, $E0
    ld l, a

.next:
    dec b
    jr nz, .loop2
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    ld a, h
    and a, $9B
    ld h, a
    pop bc
    dec c
    jr nz, .loop
    ret

; B = width, C = rows, DE = source, HL = VRAM with rows 32 bytes apart: copies B bytes per row with WriteVRAMByteInc, then skips 14 source bytes (rows B + 14 bytes apart, 20 for a 6-wide rectangle); B kept, C = 0 (E-0067) (the same 28 bytes appear in 2 banks)
; no direct call (reached through a table, a jump or a vector)
CopyRectToVRAMSourceStrideBPlus14_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_484A:: ; address name
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToVRAMSourceStrideBPlus14_BankF1
    ret

; far-calls Func_002_5E82 and reloads the record list name tiles (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit)
RefreshRecordListAndNameTiles_BankF1::
Func_0F1_4866:: ; address name
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles
    ret

; the same instruction sequence as UpdateMenuCursor (bank $03) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 2 call sites from 2 routines (e.g. PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1, PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1)
; reads: wJoypadPressedRepeat, wMenuRowCount, wMenuPageCount, wMenuPage, wMenuLastPageRows, wFrameCounterLo
; writes: wFrameCounterLo, wMenuPage
UpdateMenuCursor_BankF1::
Func_0F1_4870:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, .skip
    ld a, [wMenuRowCount]
    dec a
    jr .skip

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, .check_menu_page_count
    ld a, [wMenuRowCount]
    ld c, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, c
    jr nz, .skip
    xor a, a
    jr .skip

.check_menu_page_count:
    ld a, [wMenuPageCount]
    or a, a
    jr z, .check_frame_counter_lo
    cp a, $01
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wMenuPage]
    dec a
    cp a, $FF
    jr nz, .set_menu_page
    ld a, b
    dec a
    jr .set_menu_page

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, .check_frame_counter_lo
    ld a, [wMenuPage]
    inc a
    cp a, b
    jr nz, .set_menu_page
    xor a, a
    jr .set_menu_page

.skip:
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, .call_update_menu_cursor_bank_f1_wait_for_vram
    push de
    call UpdateMenuCursor_BankF1_WaitForVRAMAccess
    pop de
    ld a, $69
    call QueueSoundEffect

.call_update_menu_cursor_bank_f1_wait_for_vram:
    ld [hl], b
    ld a, b
    call UpdateMenuCursor_BankF1_WaitForVRAMAccess_Sub02
    xor a, a
    ld [wFrameCounterLo], a
    jr .return

.set_menu_page:
    ld [wMenuPage], a
    inc a
    cp a, b
    jr nz, .clear_frame_counter_lo
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [wMenuLastPageRows]
    dec a
    cp a, c
    jr nc, .clear_frame_counter_lo
    jr z, .clear_frame_counter_lo
    push af
    push de
    ld a, [hl]
    and a, $0F
    call UpdateMenuCursor_BankF1_WaitForVRAMAccess
    pop de
    pop af
    ld [hl], a
    call UpdateMenuCursor_BankF1_WaitForVRAMAccess_Sub02

.clear_frame_counter_lo:
    set 7, [hl]
    xor a, a
    ld [wFrameCounterLo], a
    ld a, $69
    call QueueSoundEffect
    jr .return

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, .return
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, .call_update_menu_cursor_bank_f1_wait_for_vram2
    ld a, [hl]
    and a, $0F
    call UpdateMenuCursor_BankF1_WaitForVRAMAccess_Sub02
    jr .return

.call_update_menu_cursor_bank_f1_wait_for_vram2:
    ld a, [hl]
    and a, $0F
    call UpdateMenuCursor_BankF1_WaitForVRAMAccess
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

.return:
    ret

; only called from UpdateMenuCursor_BankF1 (E-0047)
; 3 call sites from 1 routine (e.g. UpdateMenuCursor_BankF1)
UpdateMenuCursor_BankF1_WaitForVRAMAccess::
Func_0F1_493B:: ; address name
    add a, a
    add a, e
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
    ld a, $C3
    ld [de], a
    ei
    ret

; only called from UpdateMenuCursor_BankF1 (E-0047)
; 3 call sites from 1 routine (e.g. UpdateMenuCursor_BankF1)
UpdateMenuCursor_BankF1_WaitForVRAMAccess_Sub02::
Func_0F1_4951:: ; address name
    add a, a
    add a, e
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
    ld a, $BB
    ld [de], a
    ei
    ret
    db $FA, $6D, $C4, $E6, $03, $21, $5E, $4A, $87, $85, $6F, $30, $01, $24, $2A, $66
    db $6F, $7D, $C6, $98, $6F, $7C, $CE, $29, $67, $36, $BB, $C9

; HL = table of BG map addresses ($98xx), A = index: adds $2998 to entry A, which turns a $9800 BG map address into the same position in wScreenTileBuffer ($C198, 32-wide rows), and writes tile $BC there (E-0072) (the same 20 bytes appear in 2 banks)
; 4 call sites from 4 routines (e.g. BuildScreenBlock32WithCursor_BankF1, ClearWindowAndBuildBlock32WithCursor_BankF1, BuildItemScreenWithRecordCursor_BankF1, BuildScreenBlocks32And0FWithCursor_BankF1)
WriteBCTileToScreenBufferAtTableEntry_BankF1::
Func_0F1_4983:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ret

; HL = table of VRAM addresses, A = index: writes tile $BC at the address in entry A (WriteVRAMByte) (E-0067) (the same 15 bytes appear in 3 banks)
; no direct call (reached through a table, a jump or a vector)
WriteBCTileAtWordTableEntry_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_4997:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_F1_49A6:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 03:43D9; C0
Func_0F1_49A6:: ; address name
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

; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. BuildInventoryScreenBase_BankF1)
; points at: wScreenTileBuffer
ClearScreenTileBuffer_BankF1::
Func_0F1_49E1:: ; address name
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ret

; HL = header (word offset, width, rows) followed by the tile bytes: copies the rectangle into wScreenTileBuffer + offset with rows 32 bytes apart (the same steps as ReadScreenBufferRectHeader then CopyRectToStride32) (E-0065) (the same 32 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. BuildItemScreenForWItemId_BankF1)
; points at: wScreenTileBuffer
CopyRecordRectToScreenBuffer_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_49ED:: ; address name
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
    ld [hl+], a
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

; the same 81 bytes as DerefWordTableEntryA_Bank03 (03:43C3)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
DerefWordTableEntryA_BankF1:: ; heuristic: follows a terminator; C0
Func_0F1_4A0D:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld de, $0501

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (restores in a different register order from the bank-$31 copy, same effect) (E-0067) (the same 59 bytes appear in 2 banks)
; 3 call sites from 2 routines (e.g. ShowSelectedItemDescription_BankF1, BuildItemScreenForWItemId_BankF1_WriteRAMGAndRAMBEtc)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_BankF1::
Func_0F1_4A23:: ; address name
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

; address loaded by BuildItemScreenWithRecordCursor_BankF1
BuildItemScreenWithRecordCursor_BankF1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_4A5E:: ; address name
    db $61, $98, $A1, $98, $E1, $98, $21, $99, $61, $99, $A1, $99

; address loaded by PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1, BuildScreenBlock32WithCursor_BankF1
PauseMenu_State4_GiftMenu_ShowChoices_UpdateMenuCursor_BankF1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_4A6A:: ; address name
    db $29, $98, $69, $98, $A9, $98, $E9, $98

; address loaded by PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1, BuildScreenBlocks32And0FWithCursor_BankF1, ClearWindowAndBuildBlock32WithCursor_BankF1
PauseMenu_State4_GiftMenu_ChooseGift_UpdateMenuCursor_BankF1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_4A72:: ; address name
    db $A1, $98, $E1, $98, $21, $99, $61, $99, $47, $99, $87, $99, $C7, $99, $07, $9A
    db $61, $98, $A1, $98, $4A, $99, $8A, $99, $CA, $99, $0A, $9A, $64, $98, $A4, $98
    db $E4, $98, $2F, $99, $6F, $99, $82, $99, $84, $99, $86, $99, $88, $99, $8A, $99
    db $8C, $99, $8E, $99, $90, $99

; fills the $2D0 bytes $C198-$C467 (wScreenTileBuffer, $240 bytes, and the $90 bytes after it) with $C3; on CGB continues with the attribute buffer (not fully read) (E-0077)
; 7 call sites from 7 routines (e.g. GameMode5_Init_SendSGBPaletteSetPacket, GameMode5_Init_SendSGBPaletteSetPacket_Case03, GameMode5_Init_SendSGBPaletteSetPacket_Case06, UnreferencedScreenInitFromBank46, ...)
; reads: wIsCGB
; writes: rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
ClearScreenBufferAndAttributes_BankF1::
Func_0F1_4AA8:: ; address name
    ld hl, wScreenTileBuffer
    ld bc, $02D0

.loop:
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    ld bc, $02D0

.loop2:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    xor a, a
    ldh [rSVBK], a
    ret

; unless a fade is running, runs the routine for wD780 (jump table of eighteen) (E-0124)
; 3 call sites from 3 routines (e.g. RunLinkSession2Exchange_LinkReceiveStepWithBuffer, EggServiceMenu_Bank1B_RunScreenStateWhenNotFading_F1, RunLinkSession6Exchange_Case01_Sub01_Table2_Case0D)
; reads: wFadeState, wScreenState
RunScreenStateWhenNotFading_F1::
Func_0F1_4AD0:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wScreenState]
    rst $00
    dw RunScreenStateWhenNotFading_F1_ToSwapMonstersMenuAndStep
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_ShowReadyToStartBreeding
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster
    dw RunScreenStateWhenNotFading_F1_LinkBreed
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_SwapMonstersMenu
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats
    dw RunScreenStateWhenNotFading_F1_Case0E
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_Case11

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
RunScreenStateWhenNotFading_F1_ToSwapMonstersMenuAndStep::
Jump_0F1_4AFD:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
RunScreenStateWhenNotFading_F1_WaitTextFlags::
Jump_0F1_4B0B:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState, wStringCategory, wLinkSendByte
; points at: wLinkScreenState
RunScreenStateWhenNotFading_F1_ShowReadyToStartBreeding::
Jump_0F1_4B2E:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wStringCategory], a
    ld a, $01 ; 'Ready to start breeding.'
    call BeginString_Bank0E_Cat0
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenState
    inc [hl]
    ret

; by its step: 'Please wait.', 'Choose the monster for breeding.'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster::
Jump_0F1_4B47:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_WaitTextFlags_Case03

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ChooseBreedingMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowPleaseWait::
Jump_0F1_4B53:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ChooseBreedingMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_WaitTextFlags::
Jump_0F1_4B65:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ChooseBreedingMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowChooseTheMonsterFor::
Jump_0F1_4B77:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $09 ; 'Choose the monster for breeding.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ChooseBreedingMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenState
; writes: wScreenStep, wScreenState
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_WaitTextFlags_Case03::
Jump_0F1_4B8E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: BreedMenu list steps, link messages, a two-choice confirmation and ComputeBreedingChild
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_F1_LinkBreed::
Jump_0F1_4B9F:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SetArg5ToListEntriesCell5
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitLinkMessage
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_LinkBreed_Case0B
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowIsThisOneOK
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case0E
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowThisOneIsToo
    dw RunScreenStateWhenNotFading_F1_LinkBreed_BeginString_Bank0E_Cat0
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case13
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case14
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitLinkMessage_Case15
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowIdenticalGendersCantBreed
    dw RunScreenStateWhenNotFading_F1_LinkBreed_QueueSoundEffect
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18
    dw RunScreenStateWhenNotFading_F1_LinkBreed_PrepareWCF8BCountersAndRequestScript
    dw RunScreenStateWhenNotFading_F1_LinkBreed_UpdateTwoChoiceCursor_Bank1D
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case13
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case1C
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowTheMonstersLikeEach
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case1E
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case13
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case20

; entry 14 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case0E::
Jump_0F1_4BE5:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ret

; entry 8 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wMenuInputResult
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding::
Jump_0F1_4C08:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld a, [wMenuInputResult]
    cp a, $FE
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $02 ; 'You refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
RunScreenStateWhenNotFading_F1_LinkBreed_BreedMenu::
Jump_0F1_4C40:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ret

; entry 16 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wTextFlags, wScreenSubStep
RunScreenStateWhenNotFading_F1_LinkBreed_ShowChooseTheMonsterFor::
Jump_0F1_4C4C:: ; address name
    ld a, [wSelectedRecord]
    cp a, $FF
    jr z, .read_screen_sub_step
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ld a, $09 ; 'Choose the monster for breeding.'
    call BeginString_Bank0E_Cat0
    ret

.read_screen_sub_step:
    ld a, [wScreenSubStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_Table2_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_Table2_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_Table2_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_Table2_BreedMenu
    dw RunScreenStateWhenNotFading_F1_Table2_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_Table2_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_Table2_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_Table2_BreedMenu

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_F1_Table2_ShowPleaseWait::
Jump_0F1_4C78:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wScreenSubStep, wLinkSendByte
RunScreenStateWhenNotFading_F1_Table2_WaitTextFlags::
Jump_0F1_4C8E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_F1_Table2_ShowChooseTheMonsterFor::
Jump_0F1_4CA0:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $09 ; 'Choose the monster for breeding.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wSelectedRecord, wScreenSubStep
RunScreenStateWhenNotFading_F1_Table2_BreedMenu::
Jump_0F1_4CB7:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    xor a, a
    ld [wSelectedRecord], a
    ld [wScreenSubStep], a
    ret

; entry 12 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wScreenSubStep
RunScreenStateWhenNotFading_F1_LinkBreed_ShowIsThisOneOK::
Jump_0F1_4CCA:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .call_breed_menu
    ld a, $04 ; 'Is this one OK for breeding?'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld de, Tiles1Plus6E0Tiles_1F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
RunScreenStateWhenNotFading_F1_LinkBreed_SetArg5ToListEntriesCell5::
Jump_0F1_4D07:: ; address name
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
    call LoadFamilyIconTileForRecordB_BankF1
    ld de, TileRect_F1_5A36
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C05
    call CopyRectTo20ByteRows_BankF1
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $86
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    farcall DrawRecordField0EMarkAndField56Digits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wArg1, wArg2, wScreenStep, wSelectedRecord
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags::
Jump_0F1_4D49:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz

; runs Func_0F1_58FA (C = 5, HL = $0278, DE = $00AC, wD7F1/2 = 0/8), wD781 += 1 and clears wD7B4 (E-0122)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_BeginString_Bank0E_Cat0)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep, wSelectedRecord
RunFunc58FAAt0278AndStep_BankF1::
Func_0F1_4D4E:: ; address name
    ld bc, $0005
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wSelectedRecord], a
    ret

; entry 17 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wArg5, wArg6, hTemp0, wScreenStep, wPartyCount, wListCursor, wListPageIndex
; writes: rRAMG2, rRAMB, wScreenStep, wSelectedRecord, wItemGridX, wItemGridY
; points at: wPartyList
RunScreenStateWhenNotFading_F1_LinkBreed_ShowThisOneIsToo::
Jump_0F1_4D6F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
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
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, .read_party_count
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $05 ; 'This one is too young to'
    call BeginString_Bank0E_Cat0
    ret

.read_party_count:
    pop hl
    ld c, [hl]
    ld a, [wPartyCount]
    ld b, a
    ld de, wPartyList

.loop:
    ld a, [de]
    cp a, c
    jr z, .check_screen_step
    inc de
    dec b
    jr nz, .loop
    jr .call_set_arg5_to_list_entries_cell5

.check_screen_step:
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    ld a, $06 ; 'Choose from the farm's roster.'
    call BeginString_Bank0E_Cat0
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSelectedRecord
; writes: rRAMG2, rRAMB
; points at: sRecords, wRecordBufA
RunScreenStateWhenNotFading_F1_LinkBreed_BeginString_Bank0E_Cat0::
Jump_0F1_4DFA:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
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
    xor a, a
    ld [rRAMG2], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    call RunFunc58FAAt0278AndStep_BankF1
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF1
    ret

; entry 19 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case13::
Jump_0F1_4E38:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 20 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wLinkSendByte, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, ...
; points at: wRecordBufA, wRecordBufB
RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case14::
Jump_0F1_4E4A:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, .check_screen_step
    cp a, $FE
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $A5
    ld [wLinkBufferCountLo], a
    xor a, a
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufA
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wRecordBufB
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 21 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkReady, wScreenStep
RunScreenStateWhenNotFading_F1_LinkBreed_WaitLinkMessage_Case15::
Jump_0F1_4E95:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wRecordBufA, wRecordBufB, wArg5, wScreenStep
; writes: wScreenStep, wScreenSubStep, wSelectedRecord, wLinkSendByte, wStringIndex, wStringCategory
; points at: wTextWindowTileLo
RunScreenStateWhenNotFading_F1_LinkBreed_ShowIdenticalGendersCantBreed::
Jump_0F1_4EA7:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wRecordBufA + $E
    ld a, [wRecordBufA + $E]
    and a, $01
    ld b, a
    ld a, [wRecordBufB + $E]
    and a, $01
    cp a, b
    jr nz, .call_personality_pair_value_to_arg5
    ld a, $08 ; 'Identical genders can't breed.'
    call BeginString_Bank0E_Cat0
    ld a, $10
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $FF
    ld [wSelectedRecord], a
    ret

.call_personality_pair_value_to_arg5:
    farcall PersonalityPairValueToArg5
    ld a, [wArg5]
    cp a, $03
    jr nz, .cp_02

.loop:
    ld a, $0A ; 'The couple is incompatible.'
    call BeginString_Bank0E_Cat0
    ld a, $10
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $FF
    ld [wSelectedRecord], a
    ret

.cp_02:
    cp a, $02
    jr nz, .clear_link_send_byte
    ld a, [wRecordBufA + $56]
    cp a, $28
    jr c, .loop
    ld a, [wRecordBufA + $6D]
    cp a, $05
    jr c, .loop
    ld a, [wRecordBufB + $56]
    cp a, $28
    jr c, .loop
    ld a, [wRecordBufB + $6D]
    cp a, $05
    jr c, .loop

.clear_link_send_byte:
    xor a, a
    ld [wLinkSendByte], a
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank0E
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $0B ; 'Proceed with breeding?'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 29 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wArg5, wScreenStep
; writes: wArg1, wScreenStep
RunScreenStateWhenNotFading_F1_LinkBreed_ShowTheMonstersLikeEach::
Jump_0F1_4F4C:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $02
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $0D ; 'The monsters like each other. Breeding'
    call BeginString_Bank0E_Cat0
    ret

; entry 23 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
; points at: wTextWindowTileLo
RunScreenStateWhenNotFading_F1_LinkBreed_QueueSoundEffect::
Jump_0F1_4F6F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_F1_5A90
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRows_BankF1
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage, wTwoChoiceCursor, wScreenStep, wScreenState, wListCursor, wListPageIndex
; writes: wScreenStep, wLinkSendByte, wScreenSubStep, wScreenByteB2, wScreenByteB3, wItemGridX, wItemGridY, wListCursor, ...
RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18::
Jump_0F1_4FAA:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .call_handle_three_choice_cursor_input_f1
    call RunFunc58FAAt024FAndDrawBox_BankF1
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

.call_handle_three_choice_cursor_input_f1:
    call HandleThreeChoiceCursorInput_F1
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.loop:
    call RunFunc58FAAt024FAndDrawBox_BankF1
    ld a, $09
    ld [wScreenStep], a
    ld a, $02 ; 'You refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $02
    jr z, .loop
    cp a, $01
    jr z, .read_screen_state
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18_Data
    call StoreBAtWordTableEntry_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

.read_screen_state:
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $0D
    ld [wScreenState], a
    ret

; entry 25 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep, wScreenStep, wTwoChoiceCursor
; writes: wScreenSubStep, wTwoChoiceCursor, wScreenStep
RunScreenStateWhenNotFading_F1_LinkBreed_PrepareWCF8BCountersAndRequestScript::
Jump_0F1_5037:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    and a, a
    jr z, .call_prepare_wcf8_b_counters_and_request
    cp a, $01
    jr z, .call_begin_string_bank0_e_cat0
    jr .clear_screen_sub_step

.call_prepare_wcf8_b_counters_and_request:
    farcall PrepareWCF8BCountersAndRequestScript
    ld a, [wTwoChoiceCursor]
    and a, a
    jr z, .return
    ld a, $16 ; 'Accessories will be in the Vault.'
    call BeginString_Bank0E_Cat0

.return:
    ret

.call_begin_string_bank0_e_cat0:
    ld a, $0C ; 'Is it OK to record the'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.clear_screen_sub_step:
    xor a, a
    ld [wScreenSubStep], a
    ld de, Tiles2Plus700Tiles_1F_4230
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4290
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles_1F_4370
    ld hl, vTiles2 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wTwoChoiceCursor], a
    ld de, TileRect_F1_5A72
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_BankF1
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep
RunScreenStateWhenNotFading_F1_LinkBreed_UpdateTwoChoiceCursor_Bank1D::
Jump_0F1_50C3:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
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
    ld a, $0B ; 'Proceed with breeding?'
    call BeginString_Bank0E_Cat0
    ld a, $17
    ld [wScreenStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ret

; entry 30 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep, wScreenByteEE, wScreenStep, wItemGridX, wItemGridY, wArg5, wArg6, ...
; writes: wScreenSubStep, wScreenStep, wListCursor, wListPageIndex, wArg1, wArg2, rRAMG2, rRAMB, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case1E::
Jump_0F1_50FF:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    and a, a
    jr z, .read_item_grid_x
    ld a, [wScreenByteEE]
    and a, a
    ret nz
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_item_grid_x:
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
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
    farcall SetBitInFieldAtArg3
    ld hl, wPackWork
    ld b, $07

.loop2:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop2
    farcall IncrementTwoCountersCappedAt99
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wScreenByteEE], a
    ret

; entry 28 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case1C::
Jump_0F1_51A4:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, .clear_link_send_byte
    cp a, $FE
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $FE
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunScreenStateWhenNotFading_F1_LinkBreed_WaitLinkMessage::
Jump_0F1_51CA:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep, wScreenSubStep
RunScreenStateWhenNotFading_F1_LinkBreed_ShowPleaseWait::
Jump_0F1_51DC:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunScreenStateWhenNotFading_F1_LinkBreed_Case0B::
Jump_0F1_51F2:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_LinkBreed_Case0B_WaitTextFlags
    dw RunScreenStateWhenNotFading_F1_LinkBreed_Case0B_WaitLinkMessage

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_F1_LinkBreed_Case0B_WaitTextFlags::
Jump_0F1_51FA:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wScreenStep, wScreenState
RunScreenStateWhenNotFading_F1_LinkBreed_Case0B_WaitLinkMessage::
Jump_0F1_520C:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    ret

; entry 32 of the `rst $00` table in RunScreenStateWhenNotFading_F1_LinkBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wLinkMessage
; writes: wLinkSendByte, wLinkSceneByte4B
; points at: wScreenState
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextFlags_Case20::
Jump_0F1_5220:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $01
    ld [wLinkSceneByte4B], a
    ret

; entry 12 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
RunScreenStateWhenNotFading_F1_SwapMonstersMenu::
Jump_0F1_5242:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $05
    ld [wScreenState], a
    ret

; entry 17 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_F1_Case11::
Jump_0F1_525E:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_Case11_AdvanceScreenStep
    dw ShowString0EAndStep_BankF1
    dw RunScreenStateWhenNotFading_F1_Case11_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_Case11_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_Case11_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SetArg5ToListEntriesCell5
    dw RunScreenStateWhenNotFading_F1_Case11_FillTilesBxC
    dw RunScreenStateWhenNotFading_F1_Case11_SetArg5ToListEntriesCell5
    dw RunScreenStateWhenNotFading_F1_Case11_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_Case11_ToBreedMenu

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case11
; no direct call (reached through a table, a jump or a vector)
RunScreenStateWhenNotFading_F1_Case11_ToBreedMenu::
Jump_0F1_5276:: ; address name
    farcall BreedMenu
    ret

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_Case11_AdvanceScreenStep::
Jump_0F1_527D:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls ShowString0EBank0EAtTiles2700AndLoadTiles, then wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawRects5E13And66DF)
; reads: wScreenStep
; writes: wScreenStep
ShowString0EAndStep_BankF1::
Func_0F1_5285:: ; address name
    farcall ShowString0EBank0EAtTiles2700AndLoadTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case11
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wScreenStep
RunScreenStateWhenNotFading_F1_Case11_FillTilesBxC::
Jump_0F1_5293:: ; address name
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

; entry 7 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
RunScreenStateWhenNotFading_F1_Case11_SetArg5ToListEntriesCell5::
Jump_0F1_52B7:: ; address name
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

; by wScreenStep: the stats screens of record buffer B (picture, name, personality, family icon, level and status, skills, category string) with a paged cursor
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats::
Jump_0F1_52D8:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ClearBGMapAndLoadFrameTiles
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_AdvanceScreenStep
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawRecordBufBStatsScreen
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawWCA36MonsterPictureInTwoSteps
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_FillTileRectWithArg1Tile
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ToFillTilesBxCAndStep
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_FillTilesBxC
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawWCA2CNameAndWCA36String
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1_Case11
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ShowPersonalityNameAndWCA3AName
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawFamilyIconAndCountForWCA38
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DecompressGraphicsArg1ToArg4
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case15
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawLevelAndStatusRowForWCA81
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ToDrawRects6B4FAnd6C27AndStep
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ClearTilesAndDrawRects6C5FAnd6D37
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ShowRecordBufBSkillNamesOrNone
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep_Case1A
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case1B
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawRects5E13And66DF
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1_Case1E
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_RunF24C3DAnd4D72
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case20

; entry 8 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Return::
Jump_0F1_531E:: ; address name
    ret

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_ClearBGMapAndLoadFrameTiles::
Jump_0F1_531F:: ; address name
    farcall ClearBGMapAndLoadFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep::
Jump_0F1_532D:: ; address name
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    farcall LoadSixteenGlyphTilesFromTable73BC
    call DrawShortStringWCA2CAtTiles1500

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_AdvanceScreenStep::
Jump_0F1_533C:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears a 5 x 1 tile area at vTiles1 + $500 (FillTilesBxC), copies the short string at wCA2C to wC8CF (CopyShortStringToWC8CF_BankF1) and draws its glyphs at vTiles1 + $500 (E-0116)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep)
DrawShortStringWCA2CAtTiles1500::
Func_0F1_5344:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0501
    call FillTilesBxC
    ld hl, wRecordBufB + $1
    call CopyShortStringToNameGlyphBuf_BankF1
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1::
Jump_0F1_535A:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld de, TileRect_1F_687F
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawRecordBufBStatsScreen::
Jump_0F1_5379:: ; address name
    farcall DrawRecordBufBStatsScreen
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawWCA36MonsterPictureInTwoSteps::
Jump_0F1_5387:: ; address name
    farcall DrawWCA36MonsterPictureInTwoSteps
    ret

; entry 6 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
; writes: wJoypadPressedRepeat, wMenuInputResult, wArg3, wArg4, wArg7, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor::
Jump_0F1_538E:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .call_bg_map_address_at_scroll_bank_f1
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_bg_map_address_at_scroll_bank_f1:
    call BGMapAddressAtScroll_BankF1
    ld de, $0161
    add hl, de
    ld de, TileRect_1F_651B
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, $0E
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, wArg7, wScreenStep, ...
RunScreenStateWhenNotFading_F1_ShowRecordStats_FillTileRectWithArg1Tile::
Jump_0F1_53D9:: ; address name
    call BGMapAddressAtScroll_BankF1
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
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 14 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_ToFillTilesBxCAndStep::
Jump_0F1_5412:: ; address name
    ld hl, vTiles2 + $200
    ld bc, $0F02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_FillTilesBxC::
Jump_0F1_5423:: ; address name
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

; entry 16 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawWCA2CNameAndWCA36String::
Jump_0F1_543D:: ; address name
    call DrawWCA2CNameAndWCA36String
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1_Case11::
Jump_0F1_5448:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld de, $0068
    add hl, de
    ld de, TileRect_1F_6577
    ld a, $0C
    ld [wArg3], a
    ld a, $0F
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wRecordBufB
; writes: wScreenStep, wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, wArg7
RunScreenStateWhenNotFading_F1_ShowRecordStats_ShowPersonalityNameAndWCA3AName::
Jump_0F1_546B:: ; address name
    farcall ShowPersonalityNameAndWCA3AName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 19 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wRecordBufB
; writes: wArg1, wArg2, wArg3, wArg4, wScreenStep, wArg5, hSpriteHideTile, wArg7
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawFamilyIconAndCountForWCA38::
Jump_0F1_5478:: ; address name
    ld a, $6D
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld a, $EA
    ld [wArg3], a
    ld a, $C7
    ld [wArg4], a
    farcall DrawFamilyIconAndCountForWCA38
    farcall DrawWCA83ExpAndToNextLevel
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 20 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wScreenStep
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, hSpriteHideTile, wArg7, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DecompressGraphicsArg1ToArg4::
Jump_0F1_549E:: ; address name
    ld a, [wRecordBufB + $B]
    ld [wArg1], a
    ld a, [wRecordBufB + $C]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, $F0
    ldh [hSpriteHideTile], a
    farcall ShowWCACFCategory11StringAtTiles2320
    call BGMapAddressAtScroll_BankF1
    ld de, $0160
    add hl, de
    ld de, TileRect_1F_66DF
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 21 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
; writes: wJoypadPressedRepeat, wMenuInputResult, hSpriteHideTile, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case15::
Jump_0F1_54E9:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .clear_sprite_hide_tile2
    cp a, $FF
    jr z, .clear_sprite_hide_tile
    ret

.clear_sprite_hide_tile:
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a, a
    ldh [hSpriteHideTile], a
    farcall DrawRects662BAnd653F
    ld a, $04
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawLevelAndStatusRowForWCA81::
Jump_0F1_5526:: ; address name
    farcall DrawLevelAndStatusRowForWCA81
    ld a, $0F
    ld [wScreenStep], a
    ret

; entry 23 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_ToDrawRects6B4FAnd6C27AndStep::
Jump_0F1_5532:: ; address name
    farcall DrawRects6B4FAnd6C27
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_ClearTilesAndDrawRects6C5FAnd6D37::
Jump_0F1_5540:: ; address name
    farcall ClearTilesAndDrawRects6C5FAnd6D37
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_ShowRecordBufBSkillNamesOrNone::
Jump_0F1_554E:: ; address name
    farcall ShowRecordBufBSkillNamesOrNone
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 26 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep_Case1A::
Jump_0F1_555B:: ; address name
    farcall ShowSpeciesCategory13StringAtTiles2680
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
; writes: wJoypadPressedRepeat, wMenuInputResult, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case1B::
Jump_0F1_5569:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .call_fill_tiles_from_request
    cp a, $FF
    jr z, .call_upload_tiles_from_data5757_bank_f1
    ret

.call_fill_tiles_from_request:
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_upload_tiles_from_data5757_bank_f1:
    call UploadTilesFromData5757_BankF1
    farcall DrawSummaryFrames6E47And6D6F
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    ret

; entry 28 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenSubStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawRects5E13And66DF::
Jump_0F1_55AE:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .call_show_string10_bank0_e_at_tiles2020_then
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1504
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    farcall DrawRects5E13And66DF
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_show_string10_bank0_e_at_tiles2020_then:
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    call ShowString0EAndStep_BankF1
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 29 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
; points at: wTextWindowTileLo
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D::
Jump_0F1_55E9:: ; address name
    farcall DrawLevelAndStatusRowForWCA81
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    call DrawWCA2CNameAndWCA36String
    ld de, Tiles1Plus4A0Tiles_1F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $11
    ld [wScreenStep], a
    ret

; entry 30 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg3, wArg4, wArg7, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1_Case1E::
Jump_0F1_561B:: ; address name
    call BGMapAddressAtScroll_BankF1
    ld de, $0008
    add hl, de
    ld de, TileRect_1F_63D7
    ld a, $0C
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a, a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    farcall DecompressRecordBufBSpeciesGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 31 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hSpriteHideTile, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_RunF24C3DAnd4D72::
Jump_0F1_5644:: ; address name
    farcall RunF24C3DAnd4D72
    ld a, $F0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in RunScreenStateWhenNotFading_F1_ShowRecordStats
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult
; writes: wJoypadPressedRepeat, wMenuInputResult, hSpriteHideTile, wScreenStep
RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case20::
Jump_0F1_5656:: ; address name
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    jr z, .return
    cp a, $FE
    jr z, .clear_sprite_hide_tile
    cp a, $FF
    jr z, .clear_sprite_hide_tile2

.return:
    ret

.clear_sprite_hide_tile:
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a, a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in RunScreenStateWhenNotFading_F1
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_F1_Case0E::
Jump_0F1_568B:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_F1_Case0E_SetListCursor
    dw ShowString0EAndStep_BankF1
    dw RunScreenStateWhenNotFading_F1_Case0E_BreedMenu
    dw RunScreenStateWhenNotFading_F1_Case0E_BreedMenu
    dw RunScreenStateWhenNotFading_F1_Case0E_BreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SetArg5ToListEntriesCell5
    dw RunScreenStateWhenNotFading_F1_Case11_FillTilesBxC
    dw RunScreenStateWhenNotFading_F1_Case11_SetArg5ToListEntriesCell5
    dw RunScreenStateWhenNotFading_F1_Case0E_ShowString_Bank0E
    dw RunScreenStateWhenNotFading_F1_Case0E_BreedMenu_Case09

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridX, wItemGridY, wScreenStep
; writes: wListCursor, wListPageIndex, wScreenStep
RunScreenStateWhenNotFading_F1_Case0E_SetListCursor::
Jump_0F1_56A3:: ; address name
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
RunScreenStateWhenNotFading_F1_Case0E_BreedMenu_Case09::
Jump_0F1_56B7:: ; address name
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
RunScreenStateWhenNotFading_F1_Case0E_BreedMenu::
Jump_0F1_56C8:: ; address name
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ld [wScreenState], a
    ret

; entry 8 of the `rst $00` table in RunScreenStateWhenNotFading_F1_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringIndex, wStringCategory, wScreenStep
; points at: wTextWindowTileLo
RunScreenStateWhenNotFading_F1_Case0E_ShowString_Bank0E::
Jump_0F1_56DC:: ; address name
    ld de, TileRect_F1_5A90
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRows_BankF1
    ld a, $0F
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank0E
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

; wD7F1/2 = the species wCA36/7, wD7F3-6 = $00, $90, $40, $00, then far-calls DrawMetaSpritePartC0 (E-0122)
; 4 call sites from 4 routines (e.g. GameMode5_Update_LinkExchangeJoypadPerFrame, GameMode5_Update_LinkExchangeJoypadPerFrame_Case04, RunLinkSession4ScreenState_Case08_SetLinkSendByte_Case04, GameMode5_Update_Case05_LinkExchangeJoypadPerFrame)
; reads: wRecordBufB
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wArg6
DrawWCA36SpritePart_BankF1::
Func_0F1_5719:: ; address name
    ld a, [wRecordBufB + $B]
    ld [wArg1], a
    ld a, [wRecordBufB + $C]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    xor a, a
    ld [wArg6], a
    farcall DrawMetaSpritePartC0
    ret

; copies tiles from Data_0F1_5757: two to vTiles2 + $6E0 and three to vTiles2 + $7C0 (E-0118)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor_Case1B)
UploadTilesFromData5757_BankF1::
Func_0F1_573E:: ; address name
    ld hl, Tiles_F1_5757
    ld de, vTiles2 + $6E0
    call CopyTileBytesToVRAM_BankF1
    call CopyTileBytesToVRAM_BankF1
    ld de, vTiles2 + $7C0
    call CopyTileBytesToVRAM_BankF1
    call CopyTileBytesToVRAM_BankF1
    call CopyTileBytesToVRAM_BankF1
    ret

; E-0238 (derived: HL = $5757 and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_F1_5757::
Data_0F1_5757:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $FF ; entry 0
    db $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 1
    db $FF, $FF, $FF, $FF, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0 ; entry 2
    db $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $FF, $FF, $FF ; entry 3
    db $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0, $FF, $C0 ; entry 4

; copies 16 bytes from [HL] to [DE], each written with interrupts off after waiting for rSTAT bit 1 to clear; HL and DE advance (a counter variant of CopyTileBytesToVRAM) (E-0238)
; 5 call sites from 1 routine (e.g. UploadTilesFromData5757_BankF1)
; reads: rSTAT
CopyTileBytesToVRAM_BankF1::
Func_0F1_57A7:: ; address name
    ld a, $10

.loop:
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    pop af
    dec a
    jr nz, .loop
    ret

; Copies up to 10 bytes from [HL] to wC8CF, stopping at a $F0 byte, then stores a $F0 terminator (the same 19 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. DrawWCA2CNameAndWCA36String, DrawShortStringWCA2CAtTiles1500)
; points at: wNameGlyphBuf
CopyShortStringToNameGlyphBuf_BankF1::
Func_0F1_57BA:: ; address name
    ld de, wNameGlyphBuf
    ld c, $0A

.loop:
    ld a, [hl+]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc de
    dec c
    jr nz, .loop

.done:
    ld a, $F0
    ld [de], a
    ret

; draws the name at wCA2C at vTiles1 + $780 and shows string [wCA36] of category [wCA37] + 2 at $8A70 with size $0109 (E-0121)
; 2 call sites from 2 routines (e.g. RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawLevelAndStatusRowForWCA81_Case1D, RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawWCA2CNameAndWCA36String)
; writes: wStringIndex, wStringCategory
; points at: wTextWindowTileLo
DrawWCA2CNameAndWCA36String::
Func_0F1_57CD:: ; address name
    ld hl, wRecordBufB + $1
    call CopyShortStringToNameGlyphBuf_BankF1
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    ld hl, wRecordBufB + $B
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    ld a, $70
    ld [hl+], a
    ld a, $8A
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    farcall ShowString_Bank08
    ret

; wD7F5/wD7F6 = HL (destination), wD7F1/wD7F2 = DE (source), then far-calls DrawTileRectFromArg1Params (width and rows already in wD7F3/wD7F4) (E-0093) (the same 23 bytes appear in 4 banks)
; 5 call sites from 5 routines (e.g. RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1_Case1E, RunScreenStateWhenNotFading_F1_ShowRecordStats_DecompressGraphicsArg1ToArg4, RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawTileRectAtHLFromDE_BankF1_Case11, RunScreenStateWhenNotFading_F1_ShowRecordStats_UpdatePagedListCursor, ...)
; writes: wArg5, wArg6, wArg1, wArg2
DrawTileRectAtHLFromDE_BankF1::
Func_0F1_57FB:: ; address name
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

; runs Func_0F1_58FA (C = 7, HL = $024F, DE = $0083, wD7F1/2 = 0/9), then draws the box at scroll + $1CC (E-0122)
; 2 call sites from 1 routine (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18)
; writes: wArg1, wArg2
RunFunc58FAAt024FAndDrawBox_BankF1::
Func_0F1_5812:: ; address name
    ld bc, $0007
    ld hl, $024F
    ld de, $0083
    xor a, a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F1
    call BGMapAddressAtScroll_BankF1
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_BankF1
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank0E
; 26 call sites from 19 routines (e.g. RunScreenStateWhenNotFading_F1_ShowReadyToStartBreeding, RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowChooseTheMonsterFor, RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowPleaseWait, RunScreenStateWhenNotFading_F1_LinkBreed_ShowTheMonstersLikeEach, ...)
; writes: wStringIndex, wStringCategory
BeginString_Bank0E_Cat0::
Func_0F1_5834:: ; address name
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank0E
    ret

; up/down moves wTwoChoiceCursor over three entries (wMenuInputResult = $FD), A and B select or cancel; otherwise blinks the cursor (E-0127)
; 3 call sites from 3 routines (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18, EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo_Case07, RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case06)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenCounter
HandleThreeChoiceCursorInput_F1::
Func_0F1_5842:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank_f1
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank_f12
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_draw_arrow_tile_bc_at_two_choice_entry
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call BlinkCursorScreenCounter_BankF1
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank_f1:
    call DrawBlankTileC3_BankF1
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .set_two_choice_cursor
    ld a, $02
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor:
    dec a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.call_draw_blank_tile_c3_bank_f12:
    call DrawBlankTileC3_BankF1
    ld a, [wTwoChoiceCursor]
    cp a, $02
    jr c, .set_two_choice_cursor2
    xor a, a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor2:
    inc a
    ld [wTwoChoiceCursor], a

.clear_screen_counter:
    xor a, a
    ld [wScreenCounter], a
    call DrawCursorTileBB_BankF1
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_draw_arrow_tile_bc_at_two_choice_entry:
    call DrawArrowTileBCAtTwoChoiceEntry_BankF1
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wD783 through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 1 call site from 1 routine (e.g. HandleThreeChoiceCursorInput_F1)
; reads: wJoypadRepeatTimer, wScreenCounter, wTwoChoiceCursor
; writes: wScreenCounter
BlinkCursorScreenCounter_BankF1::
Func_0F1_58B0:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_BankF1
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    jr c, DrawCursorTileBB_BankF1
    cp a, $18
    jr c, DrawBlankTileC3_BankF1
    xor a, a
    ld [wScreenCounter], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. HandleThreeChoiceCursorInput_F1)
; reads: wTwoChoiceCursor
DrawCursorTileBB_BankF1::
Func_0F1_58CA:: ; address name
    ld b, $BB
    jr DrawArrowTileBCAtTwoChoiceEntry_BankF1_ReadTwoChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleThreeChoiceCursorInput_F1)
; reads: wTwoChoiceCursor
DrawBlankTileC3_BankF1::
Func_0F1_58CE:: ; address name
    ld b, $C3
    jr DrawArrowTileBCAtTwoChoiceEntry_BankF1_ReadTwoChoiceCursor

; B = $BC, then writes B at the scroll position + Data_0F1_58F4[wTwoChoiceCursor] (E-0124)
; 1 call site from 1 routine (e.g. HandleThreeChoiceCursorInput_F1)
; reads: wTwoChoiceCursor
DrawArrowTileBCAtTwoChoiceEntry_BankF1::
Func_0F1_58D2:: ; address name
    ld b, $BC

DrawArrowTileBCAtTwoChoiceEntry_BankF1_ReadTwoChoiceCursor::
Jump_0F1_58D4:: ; address name
    ld a, [wTwoChoiceCursor]
    add a, a
    ld hl, DrawArrowTileBCAtTwoChoiceEntry_BankF1_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_BankF1
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by DrawArrowTileBCAtTwoChoiceEntry_BankF1
DrawArrowTileBCAtTwoChoiceEntry_BankF1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_58F4:: ; address name
    db $EC, $00, $2C, $01, $6C, $01

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 2 call sites from 2 routines (e.g. RunFunc58FAAt024FAndDrawBox_BankF1, RunFunc58FAAt0278AndStep_BankF1)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_F1::
Func_0F1_58FA:: ; address name
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
    call CopyBytesDEToHL_BankF1
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
    call CopyLow3BitsToWRAMBank2_BankF1
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
    jr nz, CopyScreenBufferRectWithAttrs_F1
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 1 call site from 1 routine (e.g. CopyScreenBufferRectWithAttrs_F1)
CopyBytesDEToHL_BankF1::
Func_0F1_594E:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_BankF1
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 1 call site from 1 routine (e.g. CopyScreenBufferRectWithAttrs_F1)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_BankF1::
Func_0F1_5957:: ; address name
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

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = wD7F1, then LoadFamilyIconTileForWorkBuf (E-0122)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_SetArg5ToListEntriesCell5)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_BankF1::
Func_0F1_5969:: ; address name
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

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 4 call sites from 4 routines (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_PrepareWCF8BCountersAndRequestScript, RunScreenStateWhenNotFading_F1_LinkBreed_QueueSoundEffect, RunScreenStateWhenNotFading_F1_Case0E_ShowString_Bank0E, RunScreenStateWhenNotFading_F1_LinkBreed_SetArg5ToListEntriesCell5)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_BankF1::
Func_0F1_5990:: ; address name
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

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1 (E-0062)
; 4 call sites from 4 routines (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_PrepareWCF8BCountersAndRequestScript, RunFunc58FAAt024FAndDrawBox_BankF1, RunScreenStateWhenNotFading_F1_LinkBreed_QueueSoundEffect, RunScreenStateWhenNotFading_F1_LinkBreed_BeginString_Bank0E_Cat0)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_BankF1::
Func_0F1_59CA:: ; address name
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
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
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
; 11 call sites from 11 routines (e.g. DrawArrowTileBCAtTwoChoiceEntry_BankF1, RunScreenStateWhenNotFading_F1_LinkBreed_PrepareWCF8BCountersAndRequestScript, RunFunc58FAAt024FAndDrawBox_BankF1, RunScreenStateWhenNotFading_F1_LinkBreed_QueueSoundEffect, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_BankF1::
Func_0F1_5A07:: ; address name
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18)
StoreBAtWordTableEntry_BankF1::
Func_0F1_5A28:: ; address name
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 5 tiles, one row per line
TileRect_F1_5A36::
Data_0F1_5A36:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_F1_5A72::
Data_0F1_5A72:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $76, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 7 tiles, one row per line
TileRect_F1_5A90::
Data_0F1_5A90:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $60, $61, $62, $62, $63, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $64, $65, $66, $67, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $68, $69, $6A, $6B, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; address loaded by RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18
RunScreenStateWhenNotFading_F1_LinkBreed_ShowYourPalRefusedBreeding_Case18_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_5ACF:: ; address name
    db $FC, $C3, $24, $C4, $4C, $C4

; only called from GameMode5_Update_Case07 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_ToGameMode5_Update_Case07_LinkExchangeJoypadPerFrame)
; reads: wLinkScreenState, wScreenByteEE, wScreenState
; writes: wScreenByteEE
GameMode5_Update_Case07_LinkExchangeJoypadPerFrame::
Func_0F1_5AD5:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, .check_screen_byte_ee
    ret

.check_screen_byte_ee:
    ld a, [wScreenByteEE]
    cp a, $02
    jr nz, .call_game_mode5_update_case07_sub01_wait_pick
    farcall SendSGBPaletteSetForSGBPaletteSet
    ld a, $FC
    call StartPaletteFade
    xor a, a
    ld [wScreenByteEE], a
    ret

.call_game_mode5_update_case07_sub01_wait_pick:
    call GameMode5_Update_Case07_Sub01_WaitPickCount
    ld a, [wScreenState]
    cp a, $07
    ret c
    call GameMode5_Update_Case07_Sub01_UpdateAndDrawSpriteSlots
    call GameMode5_Update_Case07_Sub01_WriteArg1AndArg2Etc
    ld a, [wScreenByteEE]
    and a, a
    ret z
    call GameMode5_Update_Case07_Sub01_RunNameEntryStateWhenNotFading
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_LinkExchangeJoypadPerFrame)
; reads: wPickCount
; writes: rRAMG2, rRAMB
; points at: sSavedPlayerName
GameMode5_Update_Case07_Sub01_WaitPickCount::
Func_0F1_5B0F:: ; address name
    ld a, [wPickCount]
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
    jr nz, .call_draw_sprite_part9000_at88_28
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

.call_draw_sprite_part9000_at88_28:
    farcall DrawSpritePart9000At88_28
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_LinkExchangeJoypadPerFrame)
; reads: wLinkByteE8, wLinkByteEA, wLinkByteE9
; writes: wArg1, wArg2, hSpriteWindowClipMode
GameMode5_Update_Case07_Sub01_WriteArg1AndArg2Etc::
Func_0F1_5B38:: ; address name
    ld a, [wLinkByteE8]
    cp a, $0C
    jr z, .check_link_byte_ea
    cp a, $0D
    jp z, .check_link_byte_ea2
    ret

.check_link_byte_ea:
    ld a, [wLinkByteEA]
    and a, a
    ret nz
    ld a, [wLinkByteE9]
    cp a, $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    cp a, $20
    jr z, .set_sprite_window_clip_mode_to_01
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.set_sprite_window_clip_mode_to_01:
    ld a, $01
    ldh [hSpriteWindowClipMode], a
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_link_byte_ea2:
    ld a, [wLinkByteEA]
    and a, a
    ret nz
    ld a, [wLinkByteE9]
    cp a, $07
    ret nz
    farcall GetListEntriesCell4Address
    ld c, $00
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a
    farcall DrawPartySpeciesSprites
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_LinkExchangeJoypadPerFrame)
; reads: wSpriteSlotCount, wArg1
GameMode5_Update_Case07_Sub01_UpdateAndDrawSpriteSlots::
Func_0F1_5B8E:: ; address name
    ld a, [wSpriteSlotCount]
    and a, a
    ret z
    farcall UpdateAndDrawSpriteSlots
    ld a, [wArg1]
    and a, a
    ret z
    farcall DrawFieldSprites
    ret

; only called from GameMode5_Update_Case07_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case07_LinkExchangeJoypadPerFrame)
; reads: wTopSpeciesByteDC, wTopSpeciesByte, wTopSpeciesLo, wTopSpeciesHi, wArg5
; writes: wArg1, wArg2, wArg3, wArg4, wArg5, wRecordBufB, wScreenByteEE
; points at: wNameGlyphBuf, wTopSpeciesName, wGM2Mode, wRecordBufB, wGM2TimerFrames
GameMode5_Update_Case07_Sub01_RunNameEntryStateWhenNotFading::
Func_0F1_5BA5:: ; address name
    ld a, $01
    ld [wArg1], a
    ld a, [wTopSpeciesByteDC]
    ld [wArg2], a
    ld a, [wTopSpeciesByte]
    ld [wArg3], a
    ld a, [wTopSpeciesLo]
    ld [wArg4], a
    ld a, [wTopSpeciesHi]
    ld [wArg5], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld hl, wNameGlyphBuf
    ld de, wTopSpeciesName
    ld b, $0A

.loop:
    ld a, [hl+]
    cp a, $F0
    jr z, .skip
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    jr .skip2

.skip:
    ld a, $F0
    ld [de], a

.skip2:
    ld hl, wGM2Mode
    ld de, wRecordBufB
    ld b, $A5

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld hl, wGM2TimerFrames
    ld b, $D8

.loop3:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop3
    xor a, a
    ld [wRecordBufB + $6E], a
    ld [wScreenByteEE], a
    ret

; copies the $40 bytes at Data_0F1_5E04 to wBGPaletteBuffer (E-0122)
; 1 call site from 1 routine (e.g. LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01)
; points at: wBGPaletteBuffer
LoadBGPalettesFrom5E04::
Func_0F1_5C05:: ; address name
    ld hl, LoadBGPalettesFrom5E04_Data
    ld de, wBGPaletteBuffer
    ld c, $40

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

; address loaded by LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01
; LZSS-compressed asset: 304 bytes expand to 544 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles1Gfx_F1_5C14:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0F1_5C14:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $3C5C14, $130

; address loaded by LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01
; LZSS-compressed asset: 88 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
WindowTileBufferPlus64Gfx_F1_5D44:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0F1_5D44:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $3C5D44, $58

; address loaded by LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01
; LZSS-compressed asset: 32 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
WindowTileBufferGfx_F1_5D9C:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0F1_5D9C:: ; address name
    db $64, $00, $00, $9C, $80, $00, $01, $02, $90, $91, $00, $09, $04, $92, $9D, $00
    db $00, $04, $00, $15, $07, $00, $13, $0F, $16, $9E, $9F, $A0, $00, $52, $0C, $A1

; address loaded by LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01
; LZSS-compressed asset: 50 bytes expand to 260 (tools/lzss_gfx.py, E-0016/E-0017; C1)
WindowAttrBufferPlus64Gfx_F1_5DBC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0F1_5DBC:: ; address name
    db $04, $01, $03, $01, $03, $00, $0F, $01, $03, $EE, $FF, $01, $03, $F8, $FD, $03
    db $26, $07, $03, $1D, $0F, $01, $03, $45, $0F, $28, $03, $08, $0F, $01, $03, $14
    db $06, $03, $9E, $07, $03, $09, $0B, $02, $02, $02, $02, $03, $A8, $0F, $11, $03
    db $A4, $0C

; address loaded by LibraryMenu_ShowMonsterEntry_DecompressToVRAM_Case01
; LZSS-compressed asset: 22 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
WindowAttrBufferGfx_F1_5DEE:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0F1_5DEE:: ; address name
    db $64, $00, $02, $01, $02, $F9, $F4, $02, $08, $08, $02, $EE, $FF, $00, $02, $14
    db $0F, $16, $02, $4F, $0F, $00

; address loaded by LoadBGPalettesFrom5E04
LoadBGPalettesFrom5E04_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0F1_5E04:: ; address name
    db $EE, $3D, $FF, $7F, $D6, $5A, $63, $00, $12, $36, $FF, $7F, $D8, $42, $66, $00
    db $12, $36, $FF, $7F, $D8, $42, $BF, $30, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    ds $21BC, $00
