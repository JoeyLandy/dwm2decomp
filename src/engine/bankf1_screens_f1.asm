; ROM bank $F1: screens, item lists and pause-menu helpers
; The annotated listing of this bank is build/listing/bankf1.asm.

SECTION "Bank F1", ROMX[$4000], BANK[$F1]
    db $f1

; by its step: the 'Gift / Exit' window, a cursor on screen block $32, then a string (E-0293)
PauseMenu_State4_GiftMenu::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_State4_GiftMenu_ShowChoices
    dw PauseMenu_State4_GiftMenu_ChooseGift
    dw PauseMenu_State4_GiftMenu_GiveGift

; by its step: the 'Gift / Exit' window and its cursor (E-0294)
PauseMenu_State4_GiftMenu_ShowChoices::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit
    dw PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor

; The gift menu, step 0: refreshes the party names if levels changed, builds the item list screen
; with the selected item's description and shows 'Gift / Exit' (bank-$F0 string $1B). (C1, E-0357)
PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit::
    ld a, [wLevelUpGains]
    or a
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
    ld a, $1b
    ld [wStringIndex], a ; 'GiftExit'
    xor a
    ld [wStringCategory], a
    farcall ShowString_BankF0
    ld hl, wTemp1
    inc [hl]
    xor a
    ld [wCounterPtr0Lo], a
    ret

; The gift menu, step 1: the item cursor (with items): a move shows the item's description, a page
; change redraws the page; A (sound $69) picks the item, copies its name and the player's for the
; message, loads its record and goes on; B leaves the pause menu to the field; Select sorts the bag.
; (C1, E-0357)
PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor::
    ld a, [wInventory]
    or a
    jr nz, .call_update_menu_cursor_bank_f1
    ld a, [wJoypadPressed]
    jr .check_bit1

.call_update_menu_cursor_bank_f1:
    ld de, PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor_Data
    ld hl, wMenuCursor
    call UpdateMenuCursor_BankF1
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .skip
    ld a, [wMenuRowCount]
    cp $01
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

; by its step: screen block $32 with a cursor (E-0294)
PauseMenu_State4_GiftMenu_ChooseGift::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_State4_GiftMenu_ChooseGift_DrawYesNo
    dw PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor

; Choosing to give, step 0: draws the yes/no block with its cursor (two rows). (C1, E-0357)
PauseMenu_State4_GiftMenu_ChooseGift_DrawYesNo::
    call BuildScreenBlock32WithCursor_BankF1
    call CopyTileBufferToBGMap_BankF1
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; Choosing to give, step 1: A on yes goes to giving (state 2); no or B goes back to the item list.
; (C1, E-0357)
PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor::
    ld de, PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor_Data
    ld hl, wSubMenuCursor
    call UpdateMenuCursor_BankF1
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, [wSubMenuCursor]
    and $01
    and a
    jr z, .check_sub_menu_cursor
    jr .skip

.check_sub_menu_cursor:
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

.skip:
    ld hl, wTemp0
    dec [hl]
    xor a
    ld [wTemp1], a
    ret

; by its step: sets the amount and counter pointer, rebuilds block $32 and shows the result string
; (E-0294)
PauseMenu_State4_GiftMenu_GiveGift::
    ld a, [wTemp1]
    jumptable
    dw PauseMenu_State4_GiftMenu_GiveGift_Check
    dw PauseMenu_State4_GiftMenu_GiveGift_RedrawYesNo
    dw PauseMenu_State4_GiftMenu_GiveGift_ShowCantGive
    dw PauseMenu_State4_GiftMenu_GiveGift_BackToItems

; Giving, step 0: items that cannot be given (BeastTail, ShinyHarp, $2B-$2D, $2F-$3F) show 'Can't be
; given to ...' (string $22); any other is recorded as the gift (RecordGiftAndMaybeApplyPrevious),
; removed from the bag, and the pause menu closes. (A third range, $54-$59, is set up in B and C but
; never compared, so those items can be given.) (C1, E-0357)
PauseMenu_State4_GiftMenu_GiveGift_Check::
    ld a, [wItemId]
    cp ITEM_BEASTTAIL
    jr z, .skip3
    cp ITEM_SHINYHARP
    jr z, .skip3
    ld b, $2b
    ld c, $2e
    cp c
    jr nc, .skip
    cp b
    ccf

.skip:
    jr c, .skip3
    ld b, $2f
    ld c, $40
    cp c
    jr nc, .skip2
    cp b
    ccf

.skip2:
    jr c, .skip3
    ld b, $54
    ld c, $5a
    jr c, .skip3
    jr .set_arg1

.skip3:
    ld a, $22
    jr .set_string_index

.set_arg1:
    ld [wArg1], a
    farcall RecordGiftAndMaybeApplyPrevious
    ld a, $ff
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

; Giving, step 1: clears the window and redraws the yes/no block. (C1, E-0357)
PauseMenu_State4_GiftMenu_GiveGift_RedrawYesNo::
    call ClearWindowAndBuildBlock32WithCursor_BankF1
    call CopyTileBufferToBGMap_BankF1
    ld hl, wTemp1
    inc [hl]
    ret

; Giving, step 2: starts string wStringIndex of category 0 from bank $F0's table
; (BeginStringDisplay_BankF0_2) and advances wTemp1. Only the refused branch of
; PauseMenu_State4_GiftMenu_GiveGift_Check reaches it, with wStringIndex = $22 ('... can't be given
; to ...'); a given item leaves the pause menu instead. (C1, E-0371)
PauseMenu_State4_GiftMenu_GiveGift_ShowCantGive::
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_BankF0_2
    ld hl, wTemp1
    inc [hl]
    ret

; Giving, step 3: after the text returns to the item list. (C1, E-0357)
PauseMenu_State4_GiftMenu_GiveGift_BackToItems::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

; clears the screen buffer, copies blocks $0B and $0C and, with items, block $0D and the page
; indicator (page wMenuPage of wMenuItemCount) (E-0124)
BuildInventoryScreenBase_BankF1::
    call ClearScreenTileBuffer_BankF1
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

; runs BuildInventoryScreenBase_BankF1, copies block $32 and draws the cursor for wMenuCursor & 7
; (E-0122)
BuildScreenBlock32WithCursor_BankF1::
    call BuildInventoryScreenBase_BankF1
    ld e, $32
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and $07
    ld hl, PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; builds block $32 with the cursor, blocks $11 and $1B and the rectangle chosen by wItemId, then
; runs BuildItemScreen_DrawEffect (E-0122)
BuildItemScreenForWItemId_BankF1::
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $11
    farcall CopyBlockToTileBuffer
    ld e, $1b
    farcall CopyBlockToTileBuffer
    ld a, [wItemId]
    ld hl, BuildItemScreenForWItemId_BankF1_Data1
    add_a_to_hl
    ld a, [hl]
    ld hl, BuildItemScreenForWItemId_BankF1_Data2
    add a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_BankF1
    call BuildItemScreen_DrawEffect
    ret

; fills tiles, builds the item screen, copies block $10 and draws the cursor for wMenuSelectedMember
; & 3 (E-0122)
BuildItemScreenWithRecordCursor_BankF1::
    call FillTilesFromRequest
    call BuildItemScreenForWItemId_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and $03
    ld hl, BuildItemScreenWithRecordCursor_BankF1_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; builds block $32 with the cursor and copies block $0F (E-0122)
BuildScreenBlocks32And0F_BankF1::
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $0f
    farcall CopyBlockToTileBuffer
    ret

; fills tiles, builds blocks $32 and $0F, copies block $10 and draws the cursor for wSubMenuCursor &
; 3 (E-0122)
BuildScreenBlocks32And0FWithCursor_BankF1::
    call FillTilesFromRequest
    call BuildScreenBlocks32And0F_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $03
    ld hl, PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; clears the default window, fills tiles, builds block $32, copies block $10 and draws the cursor
; for wSubMenuCursor & 3 (E-0122)
ClearWindowAndBuildBlock32WithCursor_BankF1::
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $03
    ld hl, PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor_Data
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

; the same instruction sequence as ShowSelectedItemDescription (bank $03) apart from label operands,
; which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
ShowSelectedItemDescription_BankF1::
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
    call ShowStringBank08AtTilesHL_BankF1
    ret

; shows the four item names of inventory page wMenuPage (or the empty-inventory text and wInventory
; + $1 entries) at vTiles2 + $5C0 onward, preserving the window (E-0129)
ShowInventoryPageItemNames_BankF1::
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
DrawMenuPageNumber_BankF1::
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
SetMenuRowsForPage_BankF1::
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

; counts wInventory items until a $00 or $FF byte (24 slots); a $FF ends the list and that slot and
; the rest are rewritten as $00. Pages of 4: wMenuPageCount = wMenuItemCount = ceil(count / 4), at
; least 1; wMenuLastPageRows = count mod 4, or 4; wMenuRowCount = wMenuLastPageRows when wMenuPage
; equals the page count, else 4 (E-0067) (the same 79 bytes appear in 2 banks)
SetupInventoryMenuPages_BankF1::
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

; Draws the item's effect on the chosen party member: by the item's kind
; (BuildItemScreenForWItemId_BankF1_Data1) the record's current and new values of the stat it
; changes (fields $5B, $5F, $6B, $63, $65, $67, $69) as digits, or its personality and the rest.
; (C1, E-0357)
BuildItemScreen_DrawEffect::
    ld a, [wMenuSelectedMember]
    ld c, a
    ld a, [wItemId]
    ld hl, BuildItemScreenForWItemId_BankF1_Data1
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
    ld hl, BuildItemScreen_DrawEffect_Data
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, vTiles2 + $1a0
    ld de, $0901
    call ShowStringBank08AtTilesHL_BankF1
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
    call ShowStringBank08AtTilesHL_BankF1
    pop af
    ld hl, RecordA4StringTileCounts_F1
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
    call nz, SetScreenTileBufferRow16Col7TileC2_BankF1
    bit 2, [hl]
    call nz, SetScreenTileBufferRow16Col7TileC1_BankF1
    bit 0, [hl]
    call nz, SetScreenTileBufferRow16Col6TileC0_BankF1

.done:
    xor a
    ld [rRAMG], a
    ret

; wScreenTileBuffer + $147 = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC2_BankF1::
    ld a, $c2
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $147 = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC1_BankF1::
    ld a, $c1
    ld [wScreenTileBuffer + $147], a
    ret

; wScreenTileBuffer + $146 = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col6TileC0_BankF1::
    ld a, $c0
    ld [wScreenTileBuffer + $146], a
    ret

; data read by BuildItemScreen_DrawEffect (27 bytes) (E-0347)
BuildItemScreen_DrawEffect_Data::
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

; after showing string category 5, index (record byte $A4) + $3F (when non-zero) into tiles from
; vTiles2 + $1A0, the code reads the pair at 2 * (record byte $A4): byte 0 tiles from $1A go into
; wScreenTileBuffer + $141 (the rest of 7 filled with $C3), byte 1 continues the tile numbers at
; wWindowTileBuffer + $19; 36 pairs; the bank $03 and $F1 copies are identical (E-0239, C1)
; record: tiles of the first row, tiles of the second row
RecordA4StringTileCounts_F1::
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

BuildItemScreenForWItemId_BankF1_Data1::
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

BuildItemScreenForWItemId_BankF1_Data2::
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry00
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry01
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry02
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry03
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry04
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry05
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry06
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry07
    dw BuildItemScreenForWItemId_BankF1_Data2_Entry08

; LZSS-compressed: 253 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry00::
    db $41, $01, $0c, $03, $fb, $fc, $ed
    ds $18, $c3
    db $be, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3

; LZSS-compressed: 258 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry01::
    db $41, $01, $0c, $03, $fd, $fe, $ed
    ds $18, $c3
    db $be, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3

; LZSS-compressed: 261 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry02::
    db $41, $01, $0c, $03, $f6, $f7, $f8, $f9, $fa, $0e, $0f, $10, $11, $12, $13, $c3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $1a, $1b, $1c, $1d
    db $1e, $1f, $20, $21, $22, $c3, $c3, $c3

; LZSS-compressed: 273 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry03::
    db $41, $01, $0c, $03, $0b, $0c, $0d, $ed
    ds $20, $c3

; LZSS-compressed: 302 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry04::
    db $41, $01, $0c, $03, $ff, $00, $01, $ed
    ds $20, $c3

; LZSS-compressed: 305 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry05::
    db $41, $01, $0c, $03, $02, $03, $04, $ed
    ds $20, $c3

; LZSS-compressed: 310 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry06::
    db $41, $01, $0c, $03, $05, $06, $07, $ed
    ds $20, $c3

; LZSS-compressed: 313 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry07::
    db $41, $01, $0c, $03, $08, $09, $0a, $ed
    ds $20, $c3

; LZSS-compressed: 317 bytes that expand to 321 (E-0016, E-0017)
BuildItemScreenForWItemId_BankF1_Data2_Entry08::
    db $41, $01, $0c, $03
    ds $24, $c3
    db $af, $ea, $a6, $c0, $af, $ea, $6e, $c4, $cd, $e0, $43, $21, $a6, $c0, $2a, $be
    db $38, $04, $2b, $35, $18, $f8, $cd, $07, $43, $af, $ea, $a0, $c0, $ea, $a1, $c0
    db $c9

; the same 57 bytes as CopyTileBufferToBGMap (CopyTileBufferToBGMap) (E-0353)
CopyTileBufferToBGMap_BankF1::
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
    jr nz, .loop2
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
    jr nz, .loop
    ret

; B = width, C = rows, DE = source, HL = VRAM with rows 32 bytes apart: copies B bytes per row with
; WriteVRAMByteInc, then skips 14 source bytes (rows B + 14 bytes apart, 20 for a 6-wide rectangle);
; B kept, C = 0 (E-0067) (the same 28 bytes appear in 2 banks)
CopyRectToVRAMSourceStrideBPlus14_BankF1::
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
    jr nz, CopyRectToVRAMSourceStrideBPlus14_BankF1
    ret

; far-calls RunMoveIncapacitatedPartyMembersBackTwice and reloads the record list name tiles
; (E-0122)
RefreshRecordListAndNameTiles_BankF1::
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles
    ret

; the same instruction sequence as UpdateMenuCursor (bank $03) apart from label operands, which
; refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
UpdateMenuCursor_BankF1::
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
    jr z, .call_update_menu_cursor_draw_cursor_bank_f1
    push de
    call UpdateMenuCursor_EraseCursor_BankF1
    pop de
    ld a, $69
    call QueueSoundEffect

.call_update_menu_cursor_draw_cursor_bank_f1:
    ld [hl], b
    ld a, b
    call UpdateMenuCursor_DrawCursor_BankF1
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
    call UpdateMenuCursor_EraseCursor_BankF1
    pop de
    pop af
    ld [hl], a
    call UpdateMenuCursor_DrawCursor_BankF1

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
    jr z, .call_update_menu_cursor_erase_cursor_bank_f1
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_DrawCursor_BankF1
    jr .return

.call_update_menu_cursor_erase_cursor_bank_f1:
    ld a, [hl]
    and $0f
    call UpdateMenuCursor_EraseCursor_BankF1
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

.return:
    ret

; Erases the menu cursor (tile $C3) at the place for row A in the table at DE. (C1, E-0357)
; the same 22 bytes as UpdateMenuCursor_EraseCursor (UpdateMenuCursor_EraseCursor) (E-0369)
UpdateMenuCursor_EraseCursor_BankF1::
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

; Draws the menu cursor (tile $BB) at the place for row A in the table at DE. (C1, E-0357)
; the same 22 bytes as UpdateMenuCursor_DrawCursor (UpdateMenuCursor_DrawCursor) (E-0369)
UpdateMenuCursor_DrawCursor_BankF1::
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
    db $fa, $6d, $c4, $e6, $03, $21, $5e, $4a, $87, $85, $6f, $30, $01, $24, $2a, $66
    db $6f, $7d, $c6, $98, $6f, $7c, $ce, $29, $67, $36, $bb, $c9

; HL = table of BG map addresses ($98xx), A = index: adds $2998 to entry A, which turns a $9800 BG
; map address into the same position in wScreenTileBuffer ($C198, 32-wide rows), and writes tile $BC
; there (E-0072) (the same 20 bytes appear in 2 banks)
WriteBCTileToScreenBufferAtTableEntry_BankF1::
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
WriteBCTileAtWordTableEntry_BankF1::
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ret

; Shows a bank-$08 string with its tiles at HL and size DE, keeping the text window. (C1, E-0357)
ShowStringBank08AtTilesHL_BankF1_2::
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

; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks) (E-0353)
ClearScreenTileBuffer_BankF1::
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ret

; HL = header (word offset, width, rows) followed by the tile bytes: copies the rectangle into
; wScreenTileBuffer + offset with rows 32 bytes apart (the same steps as ReadScreenBufferRectHeader
; then CopyRectToStride32) (E-0065) (the same 32 bytes appear in 2 banks)
CopyRecordRectToScreenBuffer_BankF1::
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

; the same 81 bytes as DerefWordTableEntryA_Bank03 (DerefWordTableEntryA_Bank03) (E-0122)
DerefWordTableEntryA_BankF1::
    add a
    add_a_to_hl
    deref_hl
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld de, $0501

; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank08, then restores the window (restores in a different
; register order from the bank-$31 copy, same effect) (E-0067) (the same 59 bytes appear in 2 banks)
ShowStringBank08AtTilesHL_BankF1::
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

; data read by BuildItemScreenWithRecordCursor (12 bytes) (E-0347)
BuildItemScreenWithRecordCursor_BankF1_Data::
    db $61, $98, $a1, $98, $e1, $98, $21, $99, $61, $99, $a1, $99

PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor_Data::
    db $29, $98, $69, $98, $a9, $98, $e9, $98

PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor_Data::
    db $a1, $98, $e1, $98, $21, $99, $61, $99, $47, $99, $87, $99, $c7, $99, $07, $9a
    db $61, $98, $a1, $98, $4a, $99, $8a, $99, $ca, $99, $0a, $9a, $64, $98, $a4, $98
    db $e4, $98, $2f, $99, $6f, $99, $82, $99, $84, $99, $86, $99, $88, $99, $8a, $99
    db $8c, $99, $8e, $99, $90, $99

; fills the $2D0 bytes $C198-$C467 (wScreenTileBuffer, $240 bytes, and the $90 bytes after it) with
; $C3; on CGB continues with the attribute buffer (not fully read) (E-0077)
ClearScreenBufferAndAttributes_BankF1::
    ld hl, wScreenTileBuffer
    ld bc, $02d0

.loop:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, [wIsCGB]
    and a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    ld bc, $02d0

.loop2:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    xor a
    ldh [rSVBK], a
    ret

; the link breeding and record screens (link sessions 2 and 6, the egg service menu): while no fade
; runs, by wScreenState: the swap menu, 'Ready to start breeding?', choosing the breeding monster,
; link breeding, record stats and the chosen record (E-0354; was: unless a fade is running, runs the
; routine for wScreenState (jump table of eighteen) (E-0124))
RunScreenStateWhenNotFading_F1::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw RunScreenStateWhenNotFading_F1_SwapMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ShowReadyToStartBreeding
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster
    dw RunScreenStateWhenNotFading_F1_LinkBreed
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_RunStatsScreen
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats
    dw RunScreenStateWhenNotFading_F1_ResetListAndShowString
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ExitToLinkMenu
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord

; Link breeding screens, state 0: runs the swap menu (SwapMonstersMenu) and goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_SwapMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Link breeding screens, states 1, 5-11, 15 and 16: once the text is done (wTextFlags bit 0 clear)
; clears the $6F bytes from wScreenState and requests game mode 5, state 1 (wGameMode, wModeState,
; wModeChangeRequest). (C1, E-0371)
RunScreenStateWhenNotFading_F1_ExitToLinkMenu::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; Link breeding screens, state 2: 'Ready to start breeding.' (bank-$0E string 1) and goes on. (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_ShowReadyToStartBreeding::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wStringCategory], a
    ld a, $01 ; 'Ready to start breeding.'
    call BeginString_Bank0E_Cat0
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenState
    inc [hl]
    ret

; by its step: 'Please wait.', 'Choose the monster for breeding.' (E-0294)
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_ChooseSendSync
    dw RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_ChooseFinish

; Choosing the breeding monster, step 0: after the text 'Please wait.' (string 7). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the breeding monster, step 1: after the text sends 1. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChooseSendSync::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the breeding monster, step 2: on the partner's 1 'Choose the monster for breeding.'
; (string 9). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChooseBreedingMonster_ShowChooseTheMonsterFor::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $09 ; 'Choose the monster for breeding.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the breeding monster, step 3: after the text the next state. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChooseFinish::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: BreedMenu list steps, link messages, a two-choice confirmation and
; ComputeBreedingChild (E-0288)
RunScreenStateWhenNotFading_F1_LinkBreed::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_ShowYourPalRefusedBreeding
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitPartner
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextThenPartner
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowIsThisOneOK
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_ListOrPalRefusal
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitText
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ShowThisOneIsToo
    dw RunScreenStateWhenNotFading_F1_LinkBreed_PleaseWait
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SendReady
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ExchangeRecords
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitExchange
    dw RunScreenStateWhenNotFading_F1_ShowIdenticalGendersCantBreed
    dw RunScreenStateWhenNotFading_F1_LinkBreed_DrawChoiceBox
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ReadChoice
    dw RunScreenStateWhenNotFading_F1_LinkBreed_PrepareCounters
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ReadAnswer
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SendReady
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitPartnerAnswer
    dw RunScreenStateWhenNotFading_F1_ShowTheMonstersLikeEach
    dw RunScreenStateWhenNotFading_F1_LinkBreed_StoreChild
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SendReady
    dw RunScreenStateWhenNotFading_F1_LinkBreed_Finish

; Link breeding, step 14: the partner's refusal ($FE) shows 'Your pal refused breeding.' (string 3)
; and step 9, answering $FE; otherwise the list's steps. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ListOrPalRefusal::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ret

; Link breeding, step 8: the partner's refusal as above; otherwise the list's steps, and B there
; shows 'You refused breeding.' (string 2), step 9, sending $FE. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowYourPalRefusedBreeding::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_breed_menu
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld a, [wMenuInputResult]
    cp $fe
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $02 ; 'You refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

; Link breeding, step 0: after the text the list's steps (BreedMenu). (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_RunList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

; Link breeding, step 16: with a pick runs the list and asks 'Choose the monster for breeding.';
; after a cancel ($FF) runs its four sub-steps (wait, 1, ask, list) again. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk::
    ld a, [wSelectedRecord]
    cp $ff
    jr z, .read_screen_sub_step
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ld a, $09 ; 'Choose the monster for breeding.'
    call BeginString_Bank0E_Cat0
    ret

.read_screen_sub_step:
    ld a, [wScreenSubStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_ReAskSendSync
    dw RunScreenStateWhenNotFading_F1_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk_RunList
    dw RunScreenStateWhenNotFading_F1_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_ReAskSendSync
    dw RunScreenStateWhenNotFading_F1_ShowChooseTheMonsterFor
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk_RunList

; Re-asking, sub-step 0: after the text 'Please wait.'. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ret

; Re-asking, sub-step 1: after the text sends 1. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ReAskSendSync::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Re-asking, sub-step 2: on the partner's 1 'Choose the monster for breeding.'. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowChooseTheMonsterFor::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $09 ; 'Choose the monster for breeding.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Re-asking, sub-step 3: after the text runs the list and clears the pick. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk_RunList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    xor a
    ld [wSelectedRecord], a
    ld [wScreenSubStep], a
    ret

; Link breeding, step 12: 'Is this one OK for breeding?' (string 4), then the list's next step with
; two cursor tiles reloaded. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ShowIsThisOneOK::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_breed_menu
    ld a, $04 ; 'Is this one OK for breeding?'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_breed_menu:
    farcall BreedMenu
    ld de, Tiles1Plus6E0Tiles_2
    ld hl, vTiles1 + $6e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_2
    ld hl, vTiles1 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wScreenSubStep], a
    ret

; Link breeding, step 4: loads the chosen record's family icon and draws its 12 x 5 panel with the
; name and details. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel::
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
    call LoadFamilyIconTileForRecordB_BankF1
    ld de, RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $05
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

; Link breeding, step 15: waits for the text. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitText::
    ld a, [wTextFlags]
    and a
    ret nz

; runs CopyScreenBufferRectWithAttrs_F1 (C = 5, HL = $0278, DE = $00AC, wArg1/2 = 0/8), wScreenStep
; += 1 and clears wSelectedRecord (E-0122) (E-0344: the address in its name dropped or read as the
; label there; was CopyScreenBufferRectAt0278AndStep_BankF1; shortened from
; RunCopyScreenBufferRectWithAttrs_F1At0278AndStep_BankF1)
CopyScreenBufferRectAt0278AndStep_BankF1::
    lb bc, $00, $05
    ld hl, $0278
    ld de, $00ac
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wSelectedRecord], a
    ret

; Link breeding, step 17: a pick below level 10 gives 'This one is too young to ...' (string 5) and
; a party member 'Choose from the farm's roster.' (string 6), both two steps back; otherwise keeps
; the record and the list place and goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ShowThisOneIsToo::
    ld a, [wTextFlags]
    and a
    ret nz
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
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp $0a
    jr nc, .read_party_count
    pop hl
    xor a
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
    cp c
    jr z, .check_screen_step
    inc de
    dec b
    jr nz, .loop
    jr .call_set_arg5_to_list_entries_cell5

.check_screen_step:
    xor a
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
    xor a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 18: copies the chosen SRAM record into wRecordBufA, shows 'Please wait.' and
; redraws. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_PleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
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
    xor a
    ld [rRAMG2], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    call CopyScreenBufferRectAt0278AndStep_BankF1
    call BGMapAddressAtScroll_BankF1
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF1
    ret

; Link breeding, step 19: after the text sends 1. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_SendReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Link breeding, step 20: on the partner's 1 starts the $A5-byte record exchange (wRecordBufA out,
; the partner's into wRecordBufB); on $FE 'Your pal refused breeding.' (step 9). (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ExchangeRecords::
    ld a, [wLinkMessage]
    cp $01
    jr z, .check_screen_step
    cp $fe
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $a5
    ld [wLinkBufferCountLo], a
    xor a
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; Link breeding, step 21: when the exchange ends ($F0) goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitExchange::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 22: the pair's check: the same sex gives 'Identical genders can't breed.'
; (string 8); a personality pair value of 3, or of 2 unless both are level 40 and up with a plus of
; 5 and up, gives 'The couple is incompatible.' (string $0A), both back to choosing (step $10);
; otherwise shows the partner's monster (string $0F in a 13 x 1 window at VRAM $9600) and asks
; 'Proceed with breeding?' (string $0B). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowIdenticalGendersCantBreed::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wRecordBufA + MON_SEX
    ld a, [wRecordBufA + MON_SEX]
    and $01
    ld b, a
    ld a, [wRecordBufB + MON_SEX]
    and $01
    cp b
    jr nz, .call_personality_pair_value_to_arg5
    ld a, $08 ; 'Identical genders can't breed.'
    call BeginString_Bank0E_Cat0
    ld a, $10
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld a, $ff
    ld [wSelectedRecord], a
    ret

.call_personality_pair_value_to_arg5:
    farcall PersonalityPairValueToArg5
    ld a, [wArg5]
    cp $03
    jr nz, .cp_02

.loop:
    ld a, $0a ; 'The couple is incompatible.'
    call BeginString_Bank0E_Cat0
    ld a, $10
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld a, $ff
    ld [wSelectedRecord], a
    ret

.cp_02:
    cp $02
    jr nz, .clear_link_send_byte
    ld a, [wRecordBufA + MON_LEVEL]
    cp $28
    jr c, .loop
    ld a, [wRecordBufA + MON_PLUS]
    cp $05
    jr c, .loop
    ld a, [wRecordBufB + MON_LEVEL]
    cp $28
    jr c, .loop
    ld a, [wRecordBufB + MON_PLUS]
    cp $05
    jr c, .loop

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, $0f
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $96
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $0d
    farcall ShowString_Bank0E
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, $0b ; 'Proceed with breeding?'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 29: works out the child (ComputeBreedingChild, wArg1 2) and, when done, 'The
; monsters like each other. Breeding ...' (string $0D). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowTheMonstersLikeEach::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $02
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $0d ; 'The monsters like each other. Breeding'
    call BeginString_Bank0E_Cat0
    ret

; Link breeding, step 23: plays sound $6C and draws the 9 x 7 three-way choice box. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_DrawChoiceBox::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $6c
    call QueueSoundEffect
    ld de, RunScreenStateWhenNotFading_F1_LinkBreed_DrawChoiceBox_TileRect
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectTo20ByteRows_BankF1
    call BGMapAddressAtScroll_BankF1
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 24: the partner's refusal ($FE) restores the area and gives 'Your pal refused
; breeding.'; the choice: B or the third entry 'You refused breeding.' (string 2, sending $FE); the
; second entry opens the stats screen (state $0D) and returns here; the first marks it and goes on.
; (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ReadChoice::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_handle_three_choice_cursor_input_f1
    call CopyScreenBufferRectAt024FAndDrawBox_BankF1
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_handle_three_choice_cursor_input_f1:
    call HandleThreeChoiceCursorInput_F1
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    call CopyScreenBufferRectAt024FAndDrawBox_BankF1
    ld a, $09
    ld [wScreenStep], a
    ld a, $02 ; 'You refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $02
    jr z, .loop
    cp $01
    jr z, .read_screen_state
    ld a, [wTwoChoiceCursor]
    ld b, $bc
    ld hl, RunScreenStateWhenNotFading_F1_LinkBreed_ReadChoice_Data
    call StoreBAtWordTableEntry_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

.read_screen_state:
    ld a, [wScreenState]
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $0d
    ld [wScreenState], a
    ret

; Link breeding, step 25: by sub-step: prepares the counters (and, with the second choice, '...
; Accessories will be in the ...', string $16); asks 'Is it OK to record the ...' (string $0C); then
; loads the yes/no tiles and draws its box. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_PrepareCounters::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr z, .call_prepare_counter_ptr0_lo_counters_and
    cp $01
    jr z, .call_begin_string_bank0_e_cat0
    jr .clear_screen_sub_step

.call_prepare_counter_ptr0_lo_counters_and:
    farcall PrepareCounterPtr0LoCountersAndRequestScript
    ld a, [wTwoChoiceCursor]
    and a
    jr z, .return
    ld a, $16 ; '*: Accessories will be in the'
    call BeginString_Bank0E_Cat0

.return:
    ret

.call_begin_string_bank0_e_cat0:
    ld a, $0c ; 'Is it OK to record the'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld de, Tiles2Plus700Tiles
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles2 + $720
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wTwoChoiceCursor], a
    ld de, RunScreenStateWhenNotFading_F1_LinkBreed_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_BankF1
    call BGMapAddressAtScroll_BankF1
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 26: the yes/no: no or B asks 'Proceed with breeding?' again (step $17); yes
; shows 'Please wait.' and goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ReadAnswer::
    ld a, [wTextFlags]
    and a
    ret nz
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
    ld a, $0b ; 'Proceed with breeding?'
    call BeginString_Bank0E_Cat0
    ld a, $17
    ld [wScreenStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ret

; Link breeding, step 30: replaces the chosen parent's SRAM record with the child
; (DeleteSRAMRecordAndCompact, then wChildRecord copied in), sets its species bit in the library,
; clears the pack work and counts the two counters; once wMenuCounter clears goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_StoreChild::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr z, .read_item_grid_x
    ld a, [wMenuCounter]
    and a
    ret nz
    xor a
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
    farcall SetBitInFieldAtArg3
    ld hl, wPackWork
    ld b, $07

.loop2:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    farcall IncrementTwoCountersCappedAt99
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ld a, $01
    ld [wMenuCounter], a
    ret

; Link breeding, step 28: on the partner's 1 goes on; on $FE 'Your pal refused breeding.'. (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitPartnerAnswer::
    ld a, [wLinkMessage]
    cp $01
    jr z, .clear_link_send_byte
    cp $fe
    ret nz
    ld a, $09
    ld [wScreenStep], a
    ld a, $03 ; 'Your pal refused breeding.'
    call BeginString_Bank0E_Cat0
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 9: on the partner's $FE goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitPartner::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Link breeding, step 10: after the text 'Please wait.'. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; waits for the text, then for the partner's link message (E-0303)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextThenPartner::
    ld a, [wScreenSubStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextThenPartner_SendReady
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextThenPartner_WaitPartner

; Waiting, sub-step 0: after the text sends 1. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextThenPartner_SendReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Waiting, sub-step 1: on the partner's 1 returns to state 1. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitTextThenPartner_WaitPartner::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenState], a
    ret

; Link breeding, step 32: after the text, on the partner's 1 clears $6F bytes of screen state and
; sets wLinkScene 1. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_Finish::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $01
    ld [wLinkScene], a
    ret

; Link breeding screens, state 12: runs the stats screen until its step $0A, then state 17. (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_RunStatsScreen::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add $05
    ld [wScreenState], a
    ret

; by wScreenStep: a string, BreedMenu list steps and the chosen record's name and species (E-0304)
RunScreenStateWhenNotFading_F1_ShowChosenRecord::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_ChosenRecordStart
    dw ShowString0EAndStep_BankF1
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ClearTiles
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_DrawName
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ToBreedMenu
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ToBreedMenu

; The chosen record, step 2: the list's steps (BreedMenu). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowChosenRecord_ToBreedMenu::
    farcall BreedMenu
    ret

; The chosen record, step 0: moves on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChosenRecordStart::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; far-calls ShowString0EBank0EAtTiles2700AndLoadTiles, then wScreenStep += 1 (E-0122)
ShowString0EAndStep_BankF1::
    farcall ShowString0EBank0EAtTiles2700AndLoadTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The chosen record, step 6: clears the name and species tile areas and resets the text window. (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_ShowChosenRecord_ClearTiles::
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

; The chosen record, step 7: draws the chosen record's name and species name. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowChosenRecord_DrawName::
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

; by wScreenStep: the stats screens of record buffer B (picture, name, personality, family icon,
; level and status, skills, category string) with a paged cursor (E-0288)
RunScreenStateWhenNotFading_F1_ShowRecordStats::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Clear
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep
    dw RunScreenStateWhenNotFading_F1_PartnerStatsNext
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawFrame
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawStats
    dw RunScreenStateWhenNotFading_F1_DrawPartnerPicture
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_PageKeys
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Leave
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Return
    dw RunScreenStateWhenNotFading_F1_Page2ClearTiles
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Clear
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_2
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Frame
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_ShowPersonality
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawFamilyIcon
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Sprite
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Keys
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2LevelRow
    dw RunScreenStateWhenNotFading_F1_SkillsPageFrames
    dw RunScreenStateWhenNotFading_F1_SkillsPageClear
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_SkillNames
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Description
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_SkillsKeys
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_SummaryFrames
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_SummaryLevelRow
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_PedigreeFrame
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_Pedigree
    dw RunScreenStateWhenNotFading_F1_ShowRecordStats_PedigreeKeys

; The partner's monster stats, step 8: nothing (a bare ret). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Return::
    ret

; The partner's monster stats, step 0: clears the BG map and loads the frame tiles. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Clear::
    farcall ClearBGMapAndLoadFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 1: shows the heading (bank-$0E string $10), loads sixteen glyph
; tiles and draws the monster's short name. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_WriteScreenStep::
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    farcall LoadSixteenGlyphTilesFromTable
    call DrawShortStringRecordBufBNameAtTiles1500

; The partner's monster stats, step 2: moves on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_PartnerStatsNext::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears a 5 x 1 tile area at vTiles1 + $500 (FillTilesBxC), copies the short string at wRecordBufB
; + $1 to wNameGlyphBuf (CopyShortStringToNameGlyphBuf_BankF1) and draws its glyphs at vTiles1 +
; $500 (E-0116) (E-0340: the address in its name read as its RAM name; was
; DrawShortStringRecordBufBNameAtTiles1500)
DrawShortStringRecordBufBNameAtTiles1500::
    ld hl, vTiles1 + $500
    ld bc, $0501
    call FillTilesBxC
    ld hl, wRecordBufB + MON_NAME
    call CopyShortStringToNameGlyphBuf_BankF1
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ret

; The partner's monster stats, step 3: draws the 20 x 18 stats frame. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawFrame::
    call BGMapAddressAtScroll_BankF1
    ld de, PartnerStats_DrawFrame_TileRect
    ld a, $14
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 4: draws its level, status and stats
; (DrawRecordBufBStatsScreen). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawStats::
    farcall DrawRecordBufBStatsScreen
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 5: draws its picture in two calls. (C1, E-0357)
RunScreenStateWhenNotFading_F1_DrawPartnerPicture::
    farcall DrawRecordBufBSpeciesMonsterPictureInTwoSteps
    ret

; The partner's monster stats, step 6: the page keys (Up/Down ignored): B goes on (leaving), A
; redraws the picture frame and turns to the second page (step $0E). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_PageKeys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .check_screen_step
    cp $ff
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
    ld de, BlankPictureTileRect
    ld a, $06
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, $0e
    ld [wScreenStep], a
    ret

; The partner's monster stats, step 7 (leaving): fills the BG map with the fill tile and goes to the
; next state. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Leave::
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
    xor a
    ld [wArg7], a
    farcall FillTileRectWithArg1Tile
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; The second page, step 14: clears $0F x 2 tiles at VRAM $9200. (C1, E-0357)
RunScreenStateWhenNotFading_F1_Page2ClearTiles::
    ld hl, vTiles2 + $200
    ld bc, $0f02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 15: clears the name and species tile areas. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Clear::
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

; The second page, step 16: draws the name and species name. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_2::
    call DrawRecordBufBNameNameAndRecordBufBSpeciesString
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 17: draws the 12 x 15 page frame. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Frame::
    call BGMapAddressAtScroll_BankF1
    ld de, $0068
    add hl, de
    ld de, MonsterDetailsPage2TileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $0f
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 18: shows its personality name and master's name. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_ShowPersonality::
    farcall ShowPersonalityNameAndRecordBufBMasterNameName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The second page, step 19: draws the family icon with its count and the experience still needed.
; (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_DrawFamilyIcon::
    ld a, $6d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld a, $ea
    ld [wArg3], a
    ld a, $c7
    ld [wArg4], a
    farcall DrawFamilyIconAndCountForRecordBufBFamily
    farcall DrawRecordBufBExpExpAndToNextLevel
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The second page, step 20: decompresses the species' sprite graphics, shows its item string and
; draws the 8 x 7 sprite frame. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Sprite::
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wArg1], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wArg2], a
    xor a
    ld [wArg3], a
    ld [wArg4], a
    ld a, $80
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    ld a, $f0
    ldh [hSpriteHideTile], a
    farcall ShowRecordBufBItemCategory11StringAtTiles2320
    call BGMapAddressAtScroll_BankF1
    ld de, $0160
    add hl, de
    ld de, MonsterDetailsItemBoxTileRect
    ld a, $08
    ld [wArg3], a
    ld a, $07
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The second page, step 21: B redraws and goes back to the first page (step 4); A goes on to the
; skills (two steps). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2Keys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .clear_sprite_hide_tile2
    cp $ff
    jr z, .clear_sprite_hide_tile
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    farcall DrawRects
    ld a, $04
    ld [wScreenStep], a
    ret

; The second page, step 22: draws the level and status row, then step $0F. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Page2LevelRow::
    farcall DrawLevelAndStatusRowForRecordBufBLevel
    ld a, $0f
    ld [wScreenStep], a
    ret

; The skills page, step 23: draws its frames. (C1, E-0357)
RunScreenStateWhenNotFading_F1_SkillsPageFrames::
    farcall DrawRects_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The skills page, step 24: clears the text tiles and draws the frames. (C1, E-0357)
RunScreenStateWhenNotFading_F1_SkillsPageClear::
    farcall ClearTilesAndDrawRects
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The skills page, step 25: shows the eight skill names, or none. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_SkillNames::
    farcall ShowRecordBufBSkillNamesOrNone
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The skills page, step 26: shows the species' description (category $0D). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Description::
    farcall ShowSpeciesCategory13StringAtTiles2680
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The skills page, step 27: B clears the text and goes on; A loads the summary tiles and frames and
; goes on three steps. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_SkillsKeys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_fill_tiles_from_request
    cp $ff
    jr z, .call_upload_tiles_from_data_bank_f1
    ret

.call_fill_tiles_from_request:
    ld hl, vTiles2 + $200
    ld bc, $1504
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.call_upload_tiles_from_data_bank_f1:
    call UploadTilesFromData_BankF1
    farcall DrawSummaryFrames
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    ret

; The summary page, step 28: clears the text and draws its frames, then shows the headings and goes
; on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_SummaryFrames::
    ld a, [wScreenSubStep]
    and a
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
    farcall DrawRects_3
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_show_string10_bank0_e_at_tiles2020_then:
    farcall ShowString10Bank0EAtTiles2020ThenDefault
    call ShowString0EAndStep_BankF1
    xor a
    ld [wScreenSubStep], a
    ret

; The summary page, step 29: draws the level row, the name and species and a tile, then step $11.
; (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_SummaryLevelRow::
    farcall DrawLevelAndStatusRowForRecordBufBLevel
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    call DrawRecordBufBNameNameAndRecordBufBSpeciesString
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

; The pedigree page, step 30: draws the 12 x 18 frame and decompresses the parents' species
; graphics. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_PedigreeFrame::
    call BGMapAddressAtScroll_BankF1
    ld de, $0008
    add hl, de
    ld de, MonsterDetailsPedigreeTileRect
    ld a, $0c
    ld [wArg3], a
    ld a, $12
    ld [wArg4], a
    xor a
    ld [wArg7], a
    call DrawTileRectAtHLFromDE_BankF1
    farcall DecompressRecordBufBSpeciesGraphics
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The pedigree page, step 31: draws the parents (RunF2) and hides sprite tile $F0. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_Pedigree::
    farcall RunF2
    ld a, $f0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The pedigree page, step 32: B goes back to the skills page (step $17); A to leaving (step 7). (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_ShowRecordStats_PedigreeKeys::
    ld a, [wJoypadPressedRepeat]
    res 7, a
    res 6, a
    ld [wJoypadPressedRepeat], a
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    jr z, .return
    cp $fe
    jr z, .clear_sprite_hide_tile
    cp $ff
    jr z, .clear_sprite_hide_tile2

.return:
    ret

.clear_sprite_hide_tile:
    xor a
    ldh [hSpriteHideTile], a
    ld a, $17
    ld [wScreenStep], a
    ret

.clear_sprite_hide_tile2:
    xor a
    ldh [hSpriteHideTile], a
    ld a, $07
    ld [wScreenStep], a
    ret

; by wScreenStep: resets the list and grid cursors, shows a string (ShowString_Bank0E) and runs
; BreedMenu steps (E-0304)
RunScreenStateWhenNotFading_F1_ResetListAndShowString::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_RestoreListCursor
    dw ShowString0EAndStep_BankF1
    dw RunScreenStateWhenNotFading_F1_ResetListAndShowString_RunList
    dw RunScreenStateWhenNotFading_F1_ResetListAndShowString_RunList
    dw RunScreenStateWhenNotFading_F1_ResetListAndShowString_RunList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_ClearTiles
    dw RunScreenStateWhenNotFading_F1_ShowChosenRecord_DrawName
    dw RunScreenStateWhenNotFading_F1_ResetListAndShowString_ShowPartnerMonster
    dw RunScreenStateWhenNotFading_F1_ResetListAndShowString_RunListAgain

; Back to the list, step 0: restores the list cursor and page. (C1, E-0357)
RunScreenStateWhenNotFading_F1_RestoreListCursor::
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the list, step 9: runs the list's steps as state $11 (the stored state not restored). (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_ResetListAndShowString_RunListAgain::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ret

; Back to the list, step 2: runs the list's steps as state $11. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ResetListAndShowString_RunList::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ld [wScreenState], a
    ret

; Back to the list, step 8: draws the choice box and shows the partner's monster (bank-$0E string
; $0F, 13 x 1 at VRAM $9600). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ResetListAndShowString_ShowPartnerMonster::
    ld de, RunScreenStateWhenNotFading_F1_LinkBreed_DrawChoiceBox_TileRect
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectTo20ByteRows_BankF1
    ld a, $0f
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $96
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $0d
    farcall ShowString_Bank0E
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

; wArg1/2 = the species wRecordBufB + $B/7, wArg3-6 = $00, $90, $40, $00, then far-calls
; DrawMetaSpritePartC0 (E-0122) (E-0340: the address in its name read as its RAM name; was
; DrawRecordBufBSpeciesSpritePart_BankF1)
DrawRecordBufBSpeciesSpritePart_BankF1::
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wArg1], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
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
    ret

; copies tiles from UploadTilesFromData_BankF1_Tiles: two to vTiles2 + $6E0 and three to vTiles2 +
; $7C0 (E-0118) (E-0344: the address in its name dropped or read as the label there; was
; UploadTilesFromData_BankF1)
UploadTilesFromData_BankF1::
    ld hl, UploadTilesFromData_BankF1_Tiles
    ld de, vTiles2 + $6e0
    call CopyTileBytesToVRAM_BankF1
    call CopyTileBytesToVRAM_BankF1
    ld de, vTiles2 + $7c0
    call CopyTileBytesToVRAM_BankF1
    call CopyTileBytesToVRAM_BankF1
    call CopyTileBytesToVRAM_BankF1
    ret

; HL = $5757 and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
UploadTilesFromData_BankF1_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $ff ; entry 0
    db $ff, $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 1
    db $ff, $ff, $ff, $ff, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 2
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $ff, $ff, $ff ; entry 3
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 4

; copies 16 bytes from [HL] to [DE], each written with interrupts off after waiting for rSTAT bit 1
; to clear; HL and DE advance (a counter variant of CopyTileBytesToVRAM_BankF1) (E-0238)
CopyTileBytesToVRAM_BankF1::
    ld a, $10

.loop:
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    ei
    inc de
    pop af
    dec a
    jr nz, .loop
    ret

; Copies up to 10 bytes from [HL] to wNameGlyphBuf, stopping at a $F0 byte, then stores a $F0
; terminator (the same 19 bytes appear in 2 banks) (E-0353)
CopyShortStringToNameGlyphBuf_BankF1::
    ld de, wNameGlyphBuf
    ld c, $0a

.loop:
    ld a, [hli]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    dec c
    jr nz, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; draws the name at wRecordBufB + $1 at vTiles1 + $780 and shows string [wRecordBufB + $B] of
; category [wRecordBufB + $C] + 2 at $8A70 with size $0109 (E-0121) (E-0340: the address in its name
; read as its RAM name; was DrawRecordBufBNameNameAndRecordBufBSpeciesString)
DrawRecordBufBNameNameAndRecordBufBSpeciesString::
    ld hl, wRecordBufB + MON_NAME
    call CopyShortStringToNameGlyphBuf_BankF1
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    ld hl, wRecordBufB + MON_SPECIES
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hl]
    add $02
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    ld a, $70
    ld [hli], a
    ld a, $8a
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $09
    farcall ShowString_Bank08
    ret

; wArg5/wArg6 = HL (destination), wArg1/wArg2 = DE (source), then far-calls
; DrawTileRectFromArg1Params (width and rows already in wArg3/wArg4) (E-0093) (the same 23 bytes
; appear in 4 banks)
DrawTileRectAtHLFromDE_BankF1::
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

; runs CopyScreenBufferRectWithAttrs_F1 (C = 7, HL = $024F, DE = $0083, wArg1/2 = 0/9), then draws
; the box at scroll + $1CC (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was CopyScreenBufferRectAt024FAndDrawBox_BankF1; shortened from
; RunCopyScreenBufferRectWithAttrs_F1At024FAndDrawBox_BankF1)
CopyScreenBufferRectAt024FAndDrawBox_BankF1::
    lb bc, $00, $07
    ld hl, $024f
    ld de, $0083
    xor a
    ld [wArg1], a
    ld a, $09
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_F1
    call BGMapAddressAtScroll_BankF1
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_BankF1
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank0E (E-0353)
BeginString_Bank0E_Cat0::
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank0E
    ret

; up/down moves wTwoChoiceCursor over three entries (wMenuInputResult = $FD), A and B select or
; cancel; otherwise blinks the cursor (E-0127)
HandleThreeChoiceCursorInput_F1::
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
    xor a
    ld [wMenuInputResult], a
    ret

.call_draw_blank_tile_c3_bank_f1:
    call DrawBlankTileC3_BankF1
    ld a, [wTwoChoiceCursor]
    and a
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
    cp $02
    jr c, .set_two_choice_cursor2
    xor a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor2:
    inc a
    ld [wTwoChoiceCursor], a

.clear_screen_counter:
    xor a
    ld [wScreenCounter], a
    call DrawCursorTileBB_BankF1
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_draw_arrow_tile_bc_at_two_choice_entry:
    call DrawArrowTileBCAtTwoChoiceEntry_BankF1
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wScreenCounter through 0-$17 and draws the cursor
; tile ($BB) or a blank ($C3) (E-0122)
BlinkCursorScreenCounter_BankF1::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_BankF1
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, DrawCursorTileBB_BankF1
    cp $18
    jr c, DrawBlankTileC3_BankF1
    xor a
    ld [wScreenCounter], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_BankF1::
    ld b, $bb
    jr DrawTileBAtTwoChoiceEntry_BankF1

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_BankF1::
    ld b, $c3
    jr DrawTileBAtTwoChoiceEntry_BankF1

; B = $BC, then writes B at the scroll position +
; DrawTileBAtTwoChoiceEntry_BankF1_Data[wTwoChoiceCursor] (E-0124)
DrawArrowTileBCAtTwoChoiceEntry_BankF1::
    ld b, $bc

; Writes tile B at choice wTwoChoiceCursor's place (DrawTileBAtTwoChoiceEntry_BankF1_Data), stepping
; back on a scroll wrap. (C1, E-0357)
DrawTileBAtTwoChoiceEntry_BankF1::
    ld a, [wTwoChoiceCursor]
    add a
    ld hl, DrawTileBAtTwoChoiceEntry_BankF1_Data
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

; data read by DrawTileBAtTwoChoiceEntry_BankF1 (6 bytes) (E-0347)
DrawTileBAtTwoChoiceEntry_BankF1_Data::
    db $ec, $00, $2c, $01, $6c, $01

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with
; CGB attributes (E-0127)
CopyScreenBufferRectWithAttrs_F1::
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
    call CopyLow3BitsToWRAMBank2_BankF1
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
    jr nz, CopyScreenBufferRectWithAttrs_F1
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_BankF1::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_BankF1
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks) (E-0353)
CopyLow3BitsToWRAMBank2_BankF1::
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

; wWorkBuf = field $0D of SRAM record B & $0F (its family), wWorkBuf + $1 = wArg1, then
; LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForRecordB_BankF1::
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

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0353)
CopyRectTo20ByteRows_BankF1::
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
; kept. wTextCursorLo/wTextCursorHi = HL + $1C1 (E-0062)
DrawScreenBufferRect_BankF1::
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
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a
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
BGMapAddressAtScroll_BankF1::
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0353)
StoreBAtWordTableEntry_BankF1::
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

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 5 tiles, one row per line
RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
RunScreenStateWhenNotFading_F1_LinkBreed_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 9 x 7 tiles, one row per line
RunScreenStateWhenNotFading_F1_LinkBreed_DrawChoiceBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $60, $61, $62, $62, $63, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $64, $65, $66, $67, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $68, $69, $6a, $6b, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

RunScreenStateWhenNotFading_F1_LinkBreed_ReadChoice_Data::
    db $fc, $c3, $24, $c4, $4c, $c4

; Game mode 5, state 7 frame: exchanges the joypad over the link (LinkExchangeJoypadPerFrame); only
; with wTitleScreenState 1 does it do more: at wMenuCounter 2 it sends the SGB palettes, starts a
; fade ($FC) and clears wMenuCounter; otherwise it draws the completion mark, and from wScreenState
; 7 on the sprite slots, the link screens' sprites (DrawLinkScreenSprites) and, while wMenuCounter
; is non-zero, the naming of the gift egg's monster. (C1, E-0369)
ExchangeJoypadAndDrawSprites::
    call LinkExchangeJoypadPerFrame
    ld a, [wTitleScreenState]
    cp $01
    jr z, .check_menu_counter
    ret

.check_menu_counter:
    ld a, [wMenuCounter]
    cp $02
    jr nz, .call_exchange_joypad_and_draw_sprites_draw
    farcall SendSGBPaletteSetForSGBPaletteSet
    ld a, $fc
    call StartPaletteFade
    xor a
    ld [wMenuCounter], a
    ret

.call_exchange_joypad_and_draw_sprites_draw:
    call ExchangeJoypadAndDrawSprites_DrawCompletionMark
    ld a, [wScreenState]
    cp $07
    ret c
    call ExchangeJoypadAndDrawSprites_DrawSpriteSlots
    call DrawLinkScreenSprites
    ld a, [wMenuCounter]
    and a
    ret z
    call ExchangeJoypadAndDrawSprites_NameGiftEgg
    ret

; When wPickCount is non-zero and the save's sSavedGameCompleted ($022B past sSavedPlayerName, SRAM
; bank 1) is set, draws the completion mark (DrawSpritePart9000At88_28: sprite part $0090 at ($88,
; $28)), as KeyAppraisalMenu_DrawCompletionMark does; otherwise it maps SRAM bank 0 and disables
; SRAM. (C1, E-0369)
ExchangeJoypadAndDrawSprites_DrawCompletionMark::
    ld a, [wPickCount]
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
    jr nz, .call_draw_sprite_part9000_at88_28
    xor a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

.call_draw_sprite_part9000_at88_28:
    farcall DrawSpritePart9000At88_28
    ret

; Draws the link screens' monster sprites: in hatch state $0C the list entry's sprite (step $15) or
; the party sprites (step $20); in state $0D step 7 the party sprites of the list's page. (C1,
; E-0357)
DrawLinkScreenSprites::
    ld a, [wLinkSceneSpeciesLo]
    cp $0c
    jr z, .check_link_scene_family
    cp $0d
    jp z, .check_link_scene_family2
    ret

.check_link_scene_family:
    ld a, [wLinkSceneFamily]
    and a
    ret nz
    ld a, [wLinkSceneSpeciesHi]
    cp $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    cp $20
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

.check_link_scene_family2:
    ld a, [wLinkSceneFamily]
    and a
    ret nz
    ld a, [wLinkSceneSpeciesHi]
    cp $07
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

; Draws the sprite slots and, with wArg1 set, the field sprites. (C1, E-0357)
ExchangeJoypadAndDrawSprites_DrawSpriteSlots::
    ld a, [wSpriteSlotCount]
    and a
    ret z
    farcall UpdateAndDrawSpriteSlots
    ld a, [wArg1]
    and a
    ret z
    farcall DrawFieldSprites
    ret

; Names the gift egg's monster (wGiftRecord): runs the name entry (RunNameEntryStateWhenNotFading
; with wArg1 = 1, wArg2 = MON_SEX, wArg3 = MON_FAMILY, wArg4/wArg5 = MON_SPECIES); when wArg5 comes
; back $FF it writes the name from wNameGlyphBuf (up to 10 bytes or $F0) to wGiftRecord + MON_NAME,
; copies the $A5-byte record to wRecordBufB with MON_EGG cleared, clears the $D8 bytes from
; wGM2TimerFrames and clears wMenuCounter, which stops these calls. (C1, E-0369)
ExchangeJoypadAndDrawSprites_NameGiftEgg::
    ld a, $01
    ld [wArg1], a
    ld a, [wGiftRecord + MON_SEX]
    ld [wArg2], a
    ld a, [wGiftRecord + MON_FAMILY]
    ld [wArg3], a
    ld a, [wGiftRecord + MON_SPECIES]
    ld [wArg4], a
    ld a, [wGiftRecord + MON_SPECIES + 1]
    ld [wArg5], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp $ff
    ret nz
    ld hl, wNameGlyphBuf
    ld de, wGiftRecord + MON_NAME
    ld b, $0a

.loop:
    ld a, [hli]
    cp $f0
    jr z, .skip
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    jr .skip2

.skip:
    ld a, $f0
    ld [de], a

.skip2:
    ld hl, wGiftRecord
    ld de, wRecordBufB
    ld b, $a5

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld hl, wGM2TimerFrames
    ld b, $d8

.loop3:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop3
    xor a
    ld [wRecordBufB + MON_EGG], a
    ld [wMenuCounter], a
    ret

; copies the $40 bytes at LoadBGPalettesFromData_Data to wBGPaletteBuffer (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was LoadBGPalettesFromData; a trailing
; preposition left by the dropped address removed)
LoadBGPalettesFromData::
    ld hl, LoadBGPalettesFromData_Data
    ld de, wBGPaletteBuffer
    ld c, $40

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

; LZSS-compressed: 304 bytes that expand to 544 (E-0016, E-0017)
Tiles1Gfx_3::
    INCBIN "gfx/misc/tiles1_gfx_3.lz"

; LZSS-compressed: 88 bytes that expand to 260 (E-0016, E-0017)
WindowTileBufferPlus64Gfx::
    INCBIN "gfx/misc/window_tile_buffer_plus64_gfx.lz"

; LZSS-compressed: 32 bytes that expand to 100 (E-0016, E-0017)
LibraryMenu_ShowMonsterEntry_LoadScreen_WindowTileBufferGfx::
    db $64, $00, $00, $9c, $80, $00, $01, $02, $90, $91, $00, $09, $04, $92, $9d, $00
    db $00, $04, $00, $15, $07, $00, $13, $0f, $16, $9e, $9f, $a0, $00, $52, $0c, $a1

; LZSS-compressed: 50 bytes that expand to 260 (E-0016, E-0017)
WindowAttrBufferPlus64Gfx::
    db $04, $01, $03, $01, $03, $00, $0f, $01, $03, $ee, $ff, $01, $03, $f8, $fd, $03
    db $26, $07, $03, $1d, $0f, $01, $03, $45, $0f, $28, $03, $08, $0f, $01, $03, $14
    db $06, $03, $9e, $07, $03, $09, $0b, $02, $02, $02, $02, $03, $a8, $0f, $11, $03
    db $a4, $0c

; LZSS-compressed: 22 bytes that expand to 100 (E-0016, E-0017)
LibraryMenu_ShowMonsterEntry_LoadScreen_WindowAttrBufferGfx::
    db $64, $00, $02, $01, $02, $f9, $f4, $02, $08, $08, $02, $ee, $ff, $00, $02, $14
    db $0f, $16, $02, $4f, $0f, $00

LoadBGPalettesFromData_Data::
    db $ee, $3d, $ff, $7f, $d6, $5a, $63, $00, $12, $36, $ff, $7f, $d8, $42, $66, $00
    db $12, $36, $ff, $7f, $d8, $42, $bf, $30, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f
    db $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f
    db $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f
    ds $21bc, $00
