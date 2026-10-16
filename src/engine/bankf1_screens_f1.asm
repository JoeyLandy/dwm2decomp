; ROM bank $F1: screens, item lists and pause-menu helpers
; The annotated listing of this bank is build/listing/bankf1.asm.

SECTION "Bank F1", ROMX
    db $f1

; Runs one step of the gift menu of the pause menu (page 4 of GameMode2_Update, entered by farcall
; from PauseMenu_State4 in bank $03). The step is wTemp0: 0 PauseMenu_State4_GiftMenu_ShowChoices
; (item list with the 'Gift / Exit' window), 1 PauseMenu_State4_GiftMenu_ChooseGift (the yes/no
; block), 2 PauseMenu_State4_GiftMenu_GiveGift. The steps change wTemp0 themselves: A on an item
; moves to 1, A on yes to 2, no or B back to 0. (C1, E-0385)
; by its step: the 'Gift / Exit' window, a cursor on screen block $32, then a string
PauseMenu_State4_GiftMenu::
    ld a, [wTemp0]
    jumptable
    dw PauseMenu_State4_GiftMenu_ShowChoices
    dw PauseMenu_State4_GiftMenu_ChooseGift
    dw PauseMenu_State4_GiftMenu_GiveGift

; Gift menu step 0, split by wTemp1: 0 PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit draws the
; item list and the 'Gift / Exit' window, then 1 PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor
; runs the item cursor every frame. (C1, E-0385)
; by its step: the 'Gift / Exit' window and its cursor
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

SECTION "Bank F1 PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor", ROMX

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
    ld de, GiftMenu_ItemCursorAddresses
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

SECTION "Bank F1 PauseMenu_State4_GiftMenu_ChooseGift", ROMX

; Gift menu step 1, split by wTemp1: 0 PauseMenu_State4_GiftMenu_ChooseGift_DrawYesNo draws the
; yes/no block, then 1 PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor runs its cursor. (C1,
; E-0385)
; by its step: screen block $32 with a cursor
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

SECTION "Bank F1 PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor", ROMX

; Choosing to give, step 1: A on yes goes to giving (state 2); no or B goes back to the item list.
; (C1, E-0357)
PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor::
    ld de, GiftMenu_YesNoCursorAddresses
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

SECTION "Bank F1 PauseMenu_State4_GiftMenu_GiveGift", ROMX

; Gift menu step 2, split by wTemp1: 0 PauseMenu_State4_GiftMenu_GiveGift_Check (gives the item, or
; refuses it with string $22), then only after a refusal 1
; PauseMenu_State4_GiftMenu_GiveGift_RedrawYesNo, 2 PauseMenu_State4_GiftMenu_GiveGift_ShowCantGive
; and 3 PauseMenu_State4_GiftMenu_GiveGift_BackToItems. (C1, E-0385)
; by its step: sets the amount and counter pointer, rebuilds block $32 and shows the result string
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

SECTION "Bank F1 PauseMenu_State4_GiftMenu_GiveGift_RedrawYesNo", ROMX

; Giving, step 1: clears the window and redraws the yes/no block. (C1, E-0357)
PauseMenu_State4_GiftMenu_GiveGift_RedrawYesNo::
    call ClearWindowAndBuildBlock32WithCursor_BankF1
    call CopyTileBufferToBGMap_BankF1
    ld hl, wTemp1
    inc [hl]
    ret

SECTION "Bank F1 PauseMenu_State4_GiftMenu_GiveGift_ShowCantGive", ROMX

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

SECTION "Bank F1 PauseMenu_State4_GiftMenu_GiveGift_BackToItems", ROMX

; Giving, step 3: after the text returns to the item list. (C2, E-0357; probed E-0385)
PauseMenu_State4_GiftMenu_GiveGift_BackToItems::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTemp0], a
    xor a
    ld [wTemp1], a
    ret

SECTION "Bank F1 BuildInventoryScreenBase_BankF1", ROMX

; Starts a pause-menu item screen in wScreenTileBuffer: clears the $240 bytes to $C3
; (ClearScreenTileBuffer_BankF1), copies screen blocks $0B and $0C, and when the bag is not empty
; (wInventory first slot not 0) also block $0D. When wMenuItemCount is 2 or more it then writes the
; page indicator at wScreenTileBuffer + $10E: $C5, tile $E1 + wMenuPage, $BE, tile $E0 +
; wMenuItemCount, $C6. Called by PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit and
; BuildScreenBlock32WithCursor_BankF1. (C2, E-0385)
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

SECTION "Bank F1 BuildScreenBlock32WithCursor_BankF1", ROMX

; Builds the item list screen with a cursor: BuildInventoryScreenBase_BankF1, then block $32, then
; tile $BC (the cursor) at the place for wMenuCursor AND 7 of GiftMenu_ItemCursorAddresses (four
; places; WriteBCTileToScreenBufferAtTableEntry_BankF1 turns the BG map address into a buffer
; address). Called by PauseMenu_State4_GiftMenu_ChooseGift_DrawYesNo and the other screen builders
; of this bank. (C2, E-0385)
; runs BuildInventoryScreenBase_BankF1, copies block $32 and draws the cursor for wMenuCursor & 7
; (E-0122)
BuildScreenBlock32WithCursor_BankF1::
    call BuildInventoryScreenBase_BankF1
    ld e, $32
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and $07
    ld hl, GiftMenu_ItemCursorAddresses
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

SECTION "Bank F1 BuildItemScreenForWItemId_BankF1", ROMX

; Builds the screen that shows an item effect: BuildScreenBlock32WithCursor_BankF1, blocks $11 and
; $1B, then the 12 x 3 rectangle record that BuildItemScreenForWItemId_BankF1_Data2 lists for the
; item kind BuildItemScreenForWItemId_BankF1_Data1[wItemId] (CopyRecordRectToScreenBuffer_BankF1),
; then BuildItemScreen_DrawEffect, which writes what the item changes of the chosen record (HP and
; maximum HP, MP and maximum MP, one stat, the personality, or the equipped item). Only
; BuildItemScreenWithRecordCursor_BankF1 calls it, and nothing calls that one: this copy of a bank
; $03 routine is not reached. (C1, E-0385)
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

SECTION "Bank F1 BuildItemScreenWithRecordCursor_BankF1", ROMX

; Calls FillTilesFromRequest and BuildItemScreenForWItemId_BankF1, copies block $10, and puts the
; cursor tile $BC at the place for wMenuSelectedMember AND 3 of
; BuildItemScreenWithRecordCursor_BankF1_Data (WriteBCTileToScreenBufferAtTableEntry_BankF1). No
; caller or table entry for it was found in the ROM; it is the bank $F1 copy of a pause-menu routine
; of bank $03. (C1, E-0385)
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

SECTION "Bank F1 BuildScreenBlocks32And0F_BankF1", ROMX

; Builds the item list screen with its cursor (BuildScreenBlock32WithCursor_BankF1) and then copies
; block $0F over it. Only BuildScreenBlocks32And0FWithCursor_BankF1 calls it, and nothing calls that
; one. (C2, E-0385)
; builds block $32 with the cursor and copies block $0F (E-0122)
BuildScreenBlocks32And0F_BankF1::
    call BuildScreenBlock32WithCursor_BankF1
    ld e, $0f
    farcall CopyBlockToTileBuffer
    ret

SECTION "Bank F1 BuildScreenBlocks32And0FWithCursor_BankF1", ROMX

; Calls FillTilesFromRequest and BuildScreenBlocks32And0F_BankF1, copies block $10, and puts the
; cursor tile $BC at the place for wSubMenuCursor AND 3 of GiftMenu_YesNoCursorAddresses
; (WriteBCTileToScreenBufferAtTableEntry_BankF1). No caller or table entry for it was found in the
; ROM; it is a bank $F1 copy of a bank $03 routine. (C1, E-0385)
; fills tiles, builds blocks $32 and $0F, copies block $10 and draws the cursor for wSubMenuCursor &
; 3 (E-0122)
BuildScreenBlocks32And0FWithCursor_BankF1::
    call FillTilesFromRequest
    call BuildScreenBlocks32And0F_BankF1
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and $03
    ld hl, GiftMenu_YesNoCursorAddresses
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

SECTION "Bank F1 ClearWindowAndBuildBlock32WithCursor_BankF1", ROMX

; Blanks the default text window tiles (FillTilesRequest at vTiles1 with size $1202, then
; FillTilesFromRequest), builds the item list with block $32 (BuildScreenBlock32WithCursor_BankF1),
; copies block $10 and puts the cursor tile $BC at the place for wSubMenuCursor AND 3 of
; GiftMenu_YesNoCursorAddresses. PauseMenu_State4_GiftMenu_GiveGift_RedrawYesNo calls it after a
; refused gift. (C1, E-0385)
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
    ld hl, GiftMenu_YesNoCursorAddresses
    call WriteBCTileToScreenBufferAtTableEntry_BankF1
    ret

SECTION "Bank F1 ShowSelectedItemDescription_BankF1", ROMX

; Shows the description of the item under the cursor: slot (wMenuPage AND $0F) * 4 + (wMenuCursor
; AND $0F) of wInventory is the item id, which is wStringIndex (item $1F uses $6F instead);
; wStringCategory = 6 (item descriptions). The string is drawn at vTiles2 + $230 in an 18 x 3 window
; by ShowStringBank08AtTilesHL_BankF1. Same code as ShowSelectedItemDescription in bank $03. Called
; by the gift menu when the list is built and when the cursor moves. (C1, E-0385)
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

SECTION "Bank F1 ShowInventoryPageItemNames_BankF1", ROMX

; Draws the item names of the current bag page at vTiles2 + $5C0, one 9 x 1 window per row, $90 tile
; bytes apart, while keeping the text window (wTextWindowTileLo to wTextWindowWidth are saved and
; restored). With items it shows the 4 ids from wInventory + 4 * (wMenuPage AND $0F) as category 5
; strings ($FF counts as 0). With an empty bag (first slot 0) it shows string 0 of category 8 and
; then 3 more category 5 strings from wInventory + 1. (C1, E-0385)
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

SECTION "Bank F1 DrawMenuPageNumber_BankF1", ROMX

; When wMenuPageCount is not 0, writes tile $E1 + (wMenuPage AND $0F) at vBGMap0 + $10F
; (WriteVRAMByte): the page number on the item list. (C1, E-0385)
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

SECTION "Bank F1 SetMenuRowsForPage_BankF1", ROMX

; Sets the cursor rows of the current bag page. On the last page (wMenuPage AND $0F equals
; wMenuItemCount - 1) wMenuRowCount = wMenuLastPageRows and a wMenuCursor that is not below it is
; moved to the last row; on any other page wMenuRowCount = 4. Always clears bit 7 of wMenuPage. Same
; code as copies in two other banks. (C2, E-0385)
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

SECTION "Bank F1 SetupInventoryMenuPages_BankF1", ROMX

; Counts the items of the 24-slot wInventory up to the first slot that is 0 or $FF; an $FF ends the
; list and that slot and all later ones are rewritten as 0. Pages hold 4 items: wMenuPageCount =
; wMenuItemCount = ceil(count / 4), at least 1; wMenuLastPageRows = count mod 4, or 4 when that is
; 0; wMenuRowCount = wMenuLastPageRows when wMenuPage equals the page count, else 4.
; PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit calls it. (C2, E-0385)
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

SECTION "Bank F1 BuildItemScreen_DrawEffect", ROMX

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

SECTION "Bank F1 SetScreenTileBufferRow16Col7TileC2_BankF1", ROMX

; Writes tile $C2 at wScreenTileBuffer + $147 (row 16, column 7 of the 20-wide screen) and returns.
; BuildItemScreen_DrawEffect calls it when bit 7 of MON_STATUS of the chosen party record is set
; (bit 7 is the dead flag). The same 6 bytes appear in 3 banks. (C2, E-0385)
; wScreenTileBuffer + $147 = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC2_BankF1::
    ld a, $c2
    ld [wScreenTileBuffer + $147], a
    ret

SECTION "Bank F1 SetScreenTileBufferRow16Col7TileC1_BankF1", ROMX

; Writes tile $C1 at wScreenTileBuffer + $147 (row 16, column 7) and returns.
; BuildItemScreen_DrawEffect calls it when bit 2 of MON_STATUS of the chosen party record is set
; (bit 2 is read as poison); it runs after the dead check and replaces the tile that one wrote. (C2,
; E-0385)
; wScreenTileBuffer + $147 = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col7TileC1_BankF1::
    ld a, $c1
    ld [wScreenTileBuffer + $147], a
    ret

SECTION "Bank F1 SetScreenTileBufferRow16Col6TileC0_BankF1", ROMX

; Writes tile $C0 at wScreenTileBuffer + $146 (row 16, column 6) and returns.
; BuildItemScreen_DrawEffect calls it when bit 0 of MON_STATUS of the chosen party record is set;
; what that bit means is not known. (C2, E-0385)
; wScreenTileBuffer + $146 = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
SetScreenTileBufferRow16Col6TileC0_BankF1::
    ld a, $c0
    ld [wScreenTileBuffer + $146], a
    ret

SECTION "Bank F1 BuildItemScreen_DrawEffect_Data", ROMX

; Twenty-seven bytes, each the number of tiles (3 to 9) used by the category 7 string for one
; personality index. BuildItemScreen_DrawEffect indexes it with the personality index of the
; selected record (PersonalityIndexOfRecord, also the string index in category 7), writes that many
; consecutive tile numbers starting at $1A into wWindowTileBuffer + $19 and fills the rest of the
; nine places with blank $C3. (C1, E-0381)
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

; Copies the 20 x 18 tiles at the start of wScreenTileBuffer (rows 32 bytes apart) to vBGMap0, one
; byte at a time with WriteVRAMByte. A column that reaches the end of a BG map row wraps to the
; start of the same row, and the BG map address wraps back to $9800 after $9BFF. Same code as
; CopyTileBufferToBGMap in bank $03. (C1, E-0385)
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

SECTION "Bank F1 CopyRectToVRAMSourceStrideBPlus14_BankF1", ROMX

; B = width, C = rows, DE = source, HL = VRAM destination: copies B bytes per row with
; WriteVRAMByteInc, VRAM rows 32 bytes apart and source rows B + 14 bytes apart (20 for a 6-wide
; rectangle). B is kept, C ends 0. Nothing calls it from outside (its loop jumps to its own start);
; it is a copy of a routine in another bank. (C1, E-0385)
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

SECTION "Bank F1 RefreshRecordListAndNameTiles_BankF1", ROMX

; Far-calls RunMoveIncapacitatedPartyMembersBackTwice, then reloads the party name tiles
; (LoadRecordListNameTiles). PauseMenu_State4_GiftMenu_ShowChoices_ShowGiftExit calls it when
; wLevelUpGains is not 0. (C1, E-0385)
; far-calls RunMoveIncapacitatedPartyMembersBackTwice and reloads the record list name tiles
; (E-0122)
RefreshRecordListAndNameTiles_BankF1::
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles
    ret

SECTION "Bank F1 UpdateMenuCursor_BankF1", ROMX

; HL = cursor byte (low nibble = row, bit 7 = page-changed flag), DE = table of BG map addresses,
; one per row. Up and Down (bits 6 and 7 of wJoypadPressedRepeat) move the row with wrap over
; wMenuRowCount: the old cursor is erased ($C3, UpdateMenuCursor_EraseCursor_BankF1) with sound $69
; when the row changed, the row is stored (clearing bit 7) and the cursor tile $BB is drawn
; (UpdateMenuCursor_DrawCursor_BankF1); wFrameCounterLo is cleared. When wMenuPageCount is 2 or
; more, Left and Right (bits 5 and 4) step wMenuPage with wrap, move the row up to wMenuLastPageRows
; - 1 on the last page, set bit 7 of [HL] and play sound $69. With no input the cursor blinks: drawn
; when wFrameCounterLo AND $1F is $10, erased when it is 0. Same code as UpdateMenuCursor in bank
; $03. (C1, E-0385)
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

SECTION "Bank F1 UpdateMenuCursor_EraseCursor_BankF1", ROMX

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

SECTION "Bank F1 UpdateMenuCursor_DrawCursor_BankF1", ROMX

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

; HL = table of BG map addresses (words), A = entry number: adds $2998 to the address of that entry,
; which turns a $98xx BG map address into the same place in wScreenTileBuffer, and writes the cursor
; tile $BC there. (C2, E-0385)
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

SECTION "Bank F1 WriteBCTileAtWordTableEntry_BankF1", ROMX

; HL = table of VRAM addresses (words), A = entry number: writes the cursor tile $BC at the address
; of that entry (WriteVRAMByte). No caller was found in the ROM. (C1, E-0385)
; HL = table of VRAM addresses, A = index: writes tile $BC at the address in entry A (WriteVRAMByte)
; (E-0067) (the same 15 bytes appear in 3 banks)
WriteBCTileAtWordTableEntry_BankF1::
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ret

SECTION "Bank F1 ShowStringBank08AtTilesHL_BankF1_2", ROMX

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

SECTION "Bank F1 ClearScreenTileBuffer_BankF1", ROMX

; Fills the $240 bytes of wScreenTileBuffer with the blank tile $C3. (C2, E-0385)
; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks)
ClearScreenTileBuffer_BankF1::
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ret

SECTION "Bank F1 CopyRecordRectToScreenBuffer_BankF1", ROMX

; HL = a rectangle record: word offset, width, rows, then width * rows tile bytes. Copies the tiles
; into wScreenTileBuffer + offset, rows 32 bytes apart. Used by BuildItemScreenForWItemId_BankF1.
; (C2, E-0385)
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

SECTION "Bank F1 DerefWordTableEntryA_BankF1", ROMX

; HL = word table, A = index: HL = the word at HL + 2 * A, then sets wStringCategory = 8,
; wStringIndex = 5 and DE = $0501 and falls into ShowStringBank08AtTilesHL_BankF1, so string 5 of
; category 8 is drawn at the tile address taken from the table in a 5 x 1 window. No caller was
; found in the ROM. (C1, E-0385)
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

; HL = VRAM tile address, DE = window size (D = width, E = rows): saves the text window
; (wTextWindowTileLo to wTextWindowWidth), points it at HL and DE, far-calls ShowString_Bank08 to
; draw string wStringIndex of category wStringCategory, and restores the window. Used for the item
; descriptions and effect pictures of the bank $F1 menus. (C1, E-0385)
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

SECTION "Bank F1 BuildItemScreenWithRecordCursor_BankF1_Data", ROMX

; Six BG map addresses, $9861, $98A1, $98E1, $9921, $9961, $99A1 (vBGMap0 rows 3, 5, 7, 9, 11 and 13
; at column 1), the item list cursor places. BuildItemScreenWithRecordCursor_BankF1 passes the table
; with wMenuSelectedMember & 3 to WriteBCTileToScreenBufferAtTableEntry_BankF1, which adds $2998 to
; the address to reach wScreenTileBuffer and writes tile $BC there. (C1, E-0381)
BuildItemScreenWithRecordCursor_BankF1_Data::
    db $61, $98, $a1, $98, $e1, $98, $21, $99, $61, $99, $a1, $99

; Four little-endian BG map addresses, $9829, $9869, $98A9 and $98E9 (vBGMap0 rows 1, 3, 5 and 7 at
; column 9): the item cursor places of the gift menu.
; PauseMenu_State4_GiftMenu_ShowChoices_ItemCursor passes it to UpdateMenuCursor_BankF1 with
; wMenuCursor, and BuildScreenBlock32WithCursor_BankF1 marks entry wMenuCursor & 7 with
; WriteBCTileToScreenBufferAtTableEntry_BankF1. The same bytes follow MenuCursorPositions_Bank03 in
; bank $03 (PauseMenu_Items_MemberList_Cursor_Data). (C1, E-0373)
GiftMenu_ItemCursorAddresses::
    db $29, $98, $69, $98, $a9, $98, $e9, $98

; Twenty-seven little-endian BG map addresses, of which the gift menu reads the first ones: $98A1
; and $98E1 (vBGMap0 rows 5 and 7, column 1) are the two places of the yes/no cursor of
; PauseMenu_State4_GiftMenu_ChooseGift_YesNoCursor (UpdateMenuCursor_BankF1 with wSubMenuCursor, two
; rows), and BuildScreenBlocks32And0FWithCursor_BankF1 and
; ClearWindowAndBuildBlock32WithCursor_BankF1 mark entry wSubMenuCursor & 3. The words after them
; ($9921, $9961, $9947 to $9A07, $9861, $98A1, $994A to $9A0A, $9864, $98A4, $98E4, $992F, $996F and
; $9982 to $9990 in steps of 2) continue a copy of the bank-$03 cursor tables that start with
; PauseMenu_Items_ChooseItem_ActionCursor_Data; no reader of them in bank $F1 was found. (C1,
; E-0373)
GiftMenu_YesNoCursorAddresses::
    db $a1, $98, $e1, $98, $21, $99, $61, $99, $47, $99, $87, $99, $c7, $99, $07, $9a
    db $61, $98, $a1, $98, $4a, $99, $8a, $99, $ca, $99, $0a, $9a, $64, $98, $a4, $98
    db $e4, $98, $2f, $99, $6f, $99, $82, $99, $84, $99, $86, $99, $88, $99, $8a, $99
    db $8c, $99, $8e, $99, $90, $99

; Fills the $2D0 bytes from wScreenTileBuffer with the blank tile $C3 (the screen tile buffer and
; the window tile buffer after it). When wIsCGB is not 0 it then switches rSVBK to WRAM bank 2,
; clears the $2D0 bytes from wScreenAttrBuffer (the attribute buffers wScreenAttrBuffer and
; wWindowAttrBuffer) to 0 and switches rSVBK back to 0. Far-called by the link title, link egg, link
; priest and bank $F2 screens. (C2, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1", ROMX

; Per-frame runner of the link breeding and record screens (far-called by the link egg code of banks
; $1B and $33): returns while a palette fade runs (wFadeState not 0), otherwise jumps by
; wScreenState to one of 18 states listed in the table right after it: 0 swap menu, 2 'Ready to
; start breeding.', 3 choosing the monster, 4 RunScreenStateWhenNotFading_F1_LinkBreed, 12 the stats
; screen runner, 13 RunScreenStateWhenNotFading_F1_ShowRecordStats, 14 the breed screen redraw, 17
; RunScreenStateWhenNotFading_F1_ShowChosenRecord; states 1, 5-11, 15 and 16 all run
; RunScreenStateWhenNotFading_F1_ExitToLinkMenu. (C1, E-0385)
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
    dw RunScreenStateWhenNotFading_F1_ReadyToBreed
    dw RunScreenStateWhenNotFading_F1_ChooseMonster
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
    dw RunScreenStateWhenNotFading_F1_RedrawBreedScreen
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ExitToLinkMenu", ROMX

; Link breeding screens, states 1, 5-11, 15 and 16: once the text is done (wTextFlags bit 0 clear)
; clears the $6F bytes from wScreenState and requests game mode 5, state 1 (wGameMode, wModeState,
; wModeChangeRequest). (C2, E-0371; probed E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ReadyToBreed", ROMX

; Link breeding screens, state 2: advances wScreenState to 3
; (RunScreenStateWhenNotFading_F1_ChooseMonster), starts 'Ready to start breeding.' (string 1 of
; category 0 with BeginString_Bank0E_Cat0), clears wLinkSendByte and increments wTitleScreenState.
; (C1, E-0373)
RunScreenStateWhenNotFading_F1_ReadyToBreed::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ChooseMonster", ROMX

; Link breeding screens, state 3: by wScreenStep runs
; RunScreenStateWhenNotFading_F1_ChoosePleaseWait ('Please wait.'),
; RunScreenStateWhenNotFading_F1_ChooseSendSync (sends 1 after the text),
; RunScreenStateWhenNotFading_F1_ChoosePrompt (when the partner sends 1, 'Choose the monster for
; breeding.') and RunScreenStateWhenNotFading_F1_ChooseFinish (after the text, wScreenStep = 0 and
; state 4, RunScreenStateWhenNotFading_F1_LinkBreed). (C1, E-0373)
; by its step: 'Please wait.', 'Choose the monster for breeding.'
RunScreenStateWhenNotFading_F1_ChooseMonster::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_ChoosePleaseWait
    dw RunScreenStateWhenNotFading_F1_ChooseSendSync
    dw RunScreenStateWhenNotFading_F1_ChoosePrompt
    dw RunScreenStateWhenNotFading_F1_ChooseFinish

; Choosing the breeding monster, step 0: after the text 'Please wait.' (string 7). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChoosePleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank0E_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ChooseSendSync", ROMX

; Choosing the breeding monster, step 1: returns while wTextFlags is not 0; after the text sends 1
; (wLinkSendByte) and adds 1 to wScreenStep. (C2, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ChoosePrompt", ROMX

; Choosing the breeding monster, step 2: on the partner's 1 'Choose the monster for breeding.'
; (string 9). (C1, E-0357)
RunScreenStateWhenNotFading_F1_ChoosePrompt::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ChooseFinish", ROMX

; Choosing the breeding monster, step 3: after the text the next state. (C2, E-0357; probed E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed", ROMX

; Link breeding, screen state 4: jumps by wScreenStep to one of 33 steps listed in the table right
; after it; each step is documented at its own label. Most of the list steps (0-3, 5-7, 13) run the
; breeding list menu; steps 19, 27 and 31 share RunScreenStateWhenNotFading_F1_LinkBreed_SendReady;
; 9, 10 and 11 are the refusal sequence (RunScreenStateWhenNotFading_F1_RefusalHandshake,
; RunScreenStateWhenNotFading_F1_RefusalClosing); 20 and 21 exchange the records
; (RunScreenStateWhenNotFading_F1_BreedStartExchange,
; RunScreenStateWhenNotFading_F1_BreedEndExchange); 29 makes the child and 30 stores it
; (RunScreenStateWhenNotFading_F1_BreedStoreChild); 32 is
; RunScreenStateWhenNotFading_F1_LinkBreed_Finish. (C1, E-0385)
; by wScreenStep: BreedMenu list steps, link messages, a two-choice confirmation and
; ComputeBreedingChild
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
    dw RunScreenStateWhenNotFading_F1_ListOrRefusal
    dw RunScreenStateWhenNotFading_F1_RefusalHandshake
    dw RunScreenStateWhenNotFading_F1_RefusalPleaseWait
    dw RunScreenStateWhenNotFading_F1_RefusalClosing
    dw RunScreenStateWhenNotFading_F1_LinkBreed_AskOK
    dw RunScreenStateWhenNotFading_F1_LinkBreed_RunList
    dw RunScreenStateWhenNotFading_F1_ListOrPalRefusal
    dw RunScreenStateWhenNotFading_F1_LinkBreed_WaitText
    dw RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk
    dw RunScreenStateWhenNotFading_F1_LinkBreed_CheckPick
    dw RunScreenStateWhenNotFading_F1_BreedLoadPick
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SendReady
    dw RunScreenStateWhenNotFading_F1_BreedStartExchange
    dw RunScreenStateWhenNotFading_F1_BreedEndExchange
    dw RunScreenStateWhenNotFading_F1_BreedCheckPair
    dw RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox
    dw RunScreenStateWhenNotFading_F1_BreedHandleChoice
    dw RunScreenStateWhenNotFading_F1_BreedAskToRecord
    dw RunScreenStateWhenNotFading_F1_BreedRecordYesNo
    dw RunScreenStateWhenNotFading_F1_LinkBreed_SendReady
    dw RunScreenStateWhenNotFading_F1_BreedPartnerReady
    dw RunScreenStateWhenNotFading_F1_BreedMakeChild
    dw RunScreenStateWhenNotFading_F1_BreedStoreChild
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ListOrRefusal", ROMX

; Link breeding, step 8: the partner's refusal as above; otherwise the list's steps, and B there
; shows 'You refused breeding.' (string 2), step 9, sending $FE. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ListOrRefusal::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_RunList", ROMX

; Link breeding, step 0: after the text the list's steps (BreedMenu). (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_RunList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk", ROMX

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
    dw RunScreenStateWhenNotFading_F1_ReAskPrompt
    dw RunScreenStateWhenNotFading_F1_ReAskShowList
    dw RunScreenStateWhenNotFading_F1_ShowPleaseWait
    dw RunScreenStateWhenNotFading_F1_ReAskSendSync
    dw RunScreenStateWhenNotFading_F1_ReAskPrompt
    dw RunScreenStateWhenNotFading_F1_ReAskShowList

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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ReAskSendSync", ROMX

; Re-asking after a cancelled pick, sub-steps 1 and 5 of wScreenSubStep: returns while wTextFlags is
; not 0; after the text adds 1 to wScreenSubStep and sends 1 (wLinkSendByte). (C2, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ReAskPrompt", ROMX

; Re-asking, sub-step 2: on the partner's 1 'Choose the monster for breeding.'. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ReAskPrompt::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ReAskShowList", ROMX

; Re-asking, sub-step 3: after the text runs the list and clears the pick. (C1, E-0357)
RunScreenStateWhenNotFading_F1_ReAskShowList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    xor a
    ld [wSelectedRecord], a
    ld [wScreenSubStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_AskOK", ROMX

; Link breeding, step 12: 'Is this one OK for breeding?' (string 4), then the list's next step with
; two cursor tiles reloaded. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_AskOK::
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
    ld b, BANK(Tiles1Plus6E0Tiles_2)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_2
    ld hl, vTiles1 + $6f0
    ld b, BANK(Tiles1Plus6F0Tiles_2)
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel", ROMX

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
    ld de, BreedRecordPanelTileRect
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_WaitText", ROMX

; Link breeding, step 15: returns while wTextFlags is not 0; after the text it falls into
; CopyScreenBufferRectAt0278AndStep_BankF1, which copies the 5 x 8 tile rectangle from
; wScreenTileBuffer + $AC to + $278 (also the CGB attributes), adds 1 to wScreenStep and clears
; wSelectedRecord. (C2, E-0385)
RunScreenStateWhenNotFading_F1_LinkBreed_WaitText::
    ld a, [wTextFlags]
    and a
    ret nz

; Copies 5 rows of 8 tiles inside the screen buffer from wScreenTileBuffer + $AC to
; wScreenTileBuffer + $278 (rows 20 bytes apart; CopyScreenBufferRectWithAttrs_F1 with wArg1 = 0,
; wArg2 = 8, which also copies the attributes on a CGB), then wScreenStep += 1 and wSelectedRecord =
; 0. Called by RunScreenStateWhenNotFading_F1_BreedLoadPick;
; RunScreenStateWhenNotFading_F1_LinkBreed_WaitText falls into it. (C2, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_CheckPick", ROMX

; Link breeding, step 17: a pick below level 10 gives 'This one is too young to ...' (string 5) and
; a party member 'Choose from the farm's roster.' (string 6), both two steps back; otherwise keeps
; the record and the list place and goes on. (C1, E-0357)
RunScreenStateWhenNotFading_F1_LinkBreed_CheckPick::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedLoadPick", ROMX

; Link breeding, step 18: once the text is done copies the $A5-byte SRAM record wSelectedRecord
; (sRecords + $A5 * wSelectedRecord, SRAM bank 0) into wRecordBufA, shows 'Please wait.' (string 7),
; runs CopyScreenBufferRectAt0278AndStep_BankF1 (a buffer copy, wScreenStep += 1, wSelectedRecord =
; 0) and redraws the 20 x 13 area (DrawScreenBufferRect_BankF1). The next step sends 1
; (RunScreenStateWhenNotFading_F1_LinkBreed_SendReady). (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedLoadPick::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_SendReady", ROMX

; Link breeding, steps 19, 27 and 31: returns while wTextFlags is not 0; after the text adds 1 to
; wScreenStep and sends 1 (wLinkSendByte), the ready signal the partner waits for in the next step.
; (C2, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedStartExchange", ROMX

; Link breeding, step 20: on a 1 from the partner starts the $A5-byte record exchange
; (wLinkBufferCountLo/Hi = $A5, wLinkTimeoutLo/Hi = wRecordBufA, the record sent;
; wLinkBufferPtrLo/Hi = wRecordBufB, where the record of the partner goes; wLinkSendByte = $FF,
; wLinkReady = 1) and goes on; on $FE shows 'Your pal refused breeding.' (string 3), sends $FE and
; goes to step 9 (RunScreenStateWhenNotFading_F1_RefusalHandshake); any other byte waits. (C1,
; E-0373)
RunScreenStateWhenNotFading_F1_BreedStartExchange::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedEndExchange", ROMX

; Link breeding, step 21: when wLinkMessage is $F0 (the exchange has ended) clears wLinkReady and
; goes on (wScreenStep += 1) to the pair check RunScreenStateWhenNotFading_F1_BreedCheckPair;
; otherwise waits. (C2, E-0373; probed E-0385)
RunScreenStateWhenNotFading_F1_BreedEndExchange::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedCheckPair", ROMX

; Link breeding, step 22: after the text checks the pair in wRecordBufA and wRecordBufB. The same
; sex (bit 0 of MON_SEX) shows 'Identical genders' (string 8); a PersonalityPairValueToArg5 result
; of 3, or of 2 unless both records have MON_LEVEL 40 or more and MON_PLUS 5 or more, shows 'The
; couple is incompatible.' (string $0A); both go back to step $10
; (RunScreenStateWhenNotFading_F1_LinkBreed_ReAsk) with wScreenSubStep = 0 and wSelectedRecord =
; $FF. Otherwise clears wLinkSendByte, draws string $0F ('BredInfoExit', the labels of the choice
; box of the next step) at VRAM $9600 in a 13 x 1 text window, sets the window back to $8800 ($02,
; $12), asks 'Proceed with breeding?' (string $0B) and goes on to
; RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox. (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedCheckPair::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedMakeChild", ROMX

; Link breeding, step 29: after the text calls ComputeBreedingChild with wArg1 = 2 and, once it
; leaves wArg5 = $FF, goes on (wScreenStep += 1) and shows 'The monsters like each other. Breeding
; will be started.' (string $0D); the next step stores the child
; (RunScreenStateWhenNotFading_F1_BreedStoreChild). (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedMakeChild::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox", ROMX

; Link breeding, step 23: after the text sets the text window to $8800 ($02, $12), clears
; wTwoChoiceCursor, plays sound $6C, copies the 9 x 7 choice box BreedChoiceBoxTileRect into
; wWindowTileBuffer + $E7 (CopyRectTo20ByteRows_BankF1), redraws the 20 x 13 area and goes on to
; RunScreenStateWhenNotFading_F1_BreedHandleChoice. (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox::
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
    ld de, BreedChoiceBoxTileRect
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedHandleChoice", ROMX

; Link breeding, step 24, after the text: a refusal ($FE) from the partner restores the area
; (CopyScreenBufferRectAt024FAndDrawBox_BankF1), shows 'Your pal refused breeding.' (string 3),
; sends $FE and goes to step 9. Otherwise HandleThreeChoiceCursorInput_F1 moves wTwoChoiceCursor
; over the three entries of the box (string $0F 'BredInfoExit'): B, or A on the third entry,
; restores the area, shows 'You refused breeding.' (string 2), sends $FE and goes to step 9; A on
; the second saves wScreenState and wScreenStep in wReturnScreenState and wReturnScreenStep and the
; list place in wItemGridX and wItemGridY, clears wScreenStep, wScreenSubStep, wListCursor and
; wListPageIndex and opens the stats screen (wScreenState $0D,
; RunScreenStateWhenNotFading_F1_ShowRecordStats); A on the first stores the mark tile $BC at its
; place in wWindowTileBuffer (BreedChoiceMarkBufAddrs) and goes on with wScreenSubStep = 0. (C1,
; E-0373)
RunScreenStateWhenNotFading_F1_BreedHandleChoice::
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
    ld hl, BreedChoiceMarkBufAddrs
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedAskToRecord", ROMX

; Link breeding, step 25, after the text, by wScreenSubStep: sub-step 0 runs
; PrepareCounterPtr0LoCountersAndRequestScript, which prepares a vault (wItemStorage) entry for the
; equipped item of wRecordBufA (MON_ITEM; wRecordBufB too when wLinkMode is 0), copies its result
; wArg1 to wTwoChoiceCursor, advances the sub-step and requests script $80; when an entry was
; prepared (wTwoChoiceCursor not 0) it shows '*: Accessories will be in the Vault.' (string $16).
; Sub-step 1 asks 'Is it OK to record the results?' (string $0C). Sub-step 2 clears the sub-step,
; loads four tiles from bank $1F (Tiles2Plus700Tiles, Tiles2Plus710Tiles and Tiles2Plus720Tiles to
; vTiles2 + $700-$720, Tiles1Plus6E0Tiles to vTiles2 + $760), clears wTwoChoiceCursor, copies the 6
; x 5 yes/no box BreedYesNoBoxTileRect into wWindowTileBuffer + $112, redraws the 20 x 13 area and
; goes on. (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedAskToRecord::
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
    ld b, BANK(Tiles2Plus700Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles
    ld hl, vTiles2 + $710
    ld b, BANK(Tiles2Plus710Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus720Tiles
    ld hl, vTiles2 + $720
    ld b, BANK(Tiles2Plus720Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $760
    ld b, BANK(Tiles1Plus6E0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wTwoChoiceCursor], a
    ld de, BreedYesNoBoxTileRect
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedRecordYesNo", ROMX

; Link breeding, step 26: after the text runs the yes/no cursor (UpdateTwoChoiceCursor_Bank1D); B
; ($FE), or A on no (wTwoChoiceCursor 1), asks 'Proceed with breeding?' (string $0B) again and goes
; back to step $17 (RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox); A on yes goes on with
; wScreenSubStep = 0 and shows 'Please wait.' (string 7). (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedRecordYesNo::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedStoreChild", ROMX

; Link breeding, step 30, after the text: sub-step 0 restores wListCursor and wListPageIndex from
; wItemGridX and wItemGridY, deletes the chosen record (the list entry from
; SetArg5ToListEntriesCell5) with DeleteSRAMRecordAndCompact (wArg2 = 1), copies the $A5 bytes of
; wChildRecord to the SRAM address in wArg6/wArg7 after that call, clears wSaveStep and
; wSaveRecordIndex, sets the child species bit in wMonsterLibraryBuf (SetBitInFieldAtArg3), clears 7
; bytes at wPackWork, adds the vault entries prepared at step 25 (IncrementTwoCountersCappedAt99),
; then sets wScreenSubStep = 1 and wMenuCounter = 1. Sub-step 1 waits until wMenuCounter is 0, then
; clears the sub-step and goes on. (C2, E-0373; probed E-0385)
RunScreenStateWhenNotFading_F1_BreedStoreChild::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_BreedPartnerReady", ROMX

; Link breeding, step 28 (after step 27 sent 1): on a 1 from the partner clears wLinkSendByte and
; goes on to RunScreenStateWhenNotFading_F1_BreedMakeChild; on $FE shows 'Your pal refused
; breeding.' (string 3), sends $FE and goes to step 9; any other byte waits. (C1, E-0373)
RunScreenStateWhenNotFading_F1_BreedPartnerReady::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RefusalHandshake", ROMX

; Link breeding, step 9, which every refusal path of this table selects after sending $FE: waits for
; a $FE from the partner, then clears wLinkSendByte and goes on to
; RunScreenStateWhenNotFading_F1_RefusalPleaseWait. (C2, E-0373; probed E-0385)
RunScreenStateWhenNotFading_F1_RefusalHandshake::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RefusalPleaseWait", ROMX

; Link breeding, step 10: after the text shows 'Please wait.' (string 7), goes on and clears
; wScreenSubStep for the closing exchange RunScreenStateWhenNotFading_F1_RefusalClosing. (C1,
; E-0373)
RunScreenStateWhenNotFading_F1_RefusalPleaseWait::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RefusalClosing", ROMX

; Link breeding, step 11, by wScreenSubStep: sub-step 0 sends 1 after the text
; (RunScreenStateWhenNotFading_F1_RefusalClosingSend); sub-step 1 waits for a 1 from the partner and
; then leaves for wScreenState 1 (RunScreenStateWhenNotFading_F1_RefusalClosingEnd). (C2, E-0373;
; probed E-0385)
; waits for the text, then for the partner's link message
RunScreenStateWhenNotFading_F1_RefusalClosing::
    ld a, [wScreenSubStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_RefusalClosingSend
    dw RunScreenStateWhenNotFading_F1_RefusalClosingEnd

; Waiting, sub-step 0: after the text sends 1. (C2, E-0357; probed E-0385)
RunScreenStateWhenNotFading_F1_RefusalClosingSend::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RefusalClosingEnd", ROMX

; Closing exchange, sub-step 1: on a 1 from the partner clears wLinkSendByte and wScreenStep and
; sets wScreenState to 1, which RunScreenStateWhenNotFading_F1 runs as
; RunScreenStateWhenNotFading_F1_ExitToLinkMenu; otherwise waits. (C2, E-0373; probed E-0385)
RunScreenStateWhenNotFading_F1_RefusalClosingEnd::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_LinkBreed_Finish", ROMX

; Link breeding, step 32: returns while wTextFlags is not 0, and then until wLinkMessage is 1 (the
; partner is done); then clears wLinkSendByte and the $6F bytes from wScreenState and sets
; wLinkScene to 1. (C2, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RunStatsScreen", ROMX

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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ShowChosenRecord", ROMX

; Screen state 17: jumps by wScreenStep to one of 10 steps listed in the table right after it: 0
; RunScreenStateWhenNotFading_F1_ChosenRecordStart, 1 ShowString0EAndStep_BankF1, steps 2-4, 8 and 9
; each run one call of the breeding list menu, 5 RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel,
; 6 and 7 clear and draw the name tiles of the chosen record. (C1, E-0385)
; by wScreenStep: a string, BreedMenu list steps and the chosen record's name and species
RunScreenStateWhenNotFading_F1_ShowChosenRecord::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_ChosenRecordStart
    dw ShowString0EAndStep_BankF1
    dw RunScreenStateWhenNotFading_F1_ChosenRecordList
    dw RunScreenStateWhenNotFading_F1_ChosenRecordList
    dw RunScreenStateWhenNotFading_F1_ChosenRecordList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel
    dw RunScreenStateWhenNotFading_F1_ClearNameTiles
    dw RunScreenStateWhenNotFading_F1_DrawChosenName
    dw RunScreenStateWhenNotFading_F1_ChosenRecordList
    dw RunScreenStateWhenNotFading_F1_ChosenRecordList

; The chosen record (wScreenState $11), steps 2-4, 8 and 9: runs one call of BreedMenu (the list
; steps). (C1, E-0373)
RunScreenStateWhenNotFading_F1_ChosenRecordList::
    farcall BreedMenu
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ChosenRecordStart", ROMX

; The chosen record, step 0: moves on. (C2, E-0357; probed E-0385)
RunScreenStateWhenNotFading_F1_ChosenRecordStart::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 ShowString0EAndStep_BankF1", ROMX

; Far-calls ShowInfoOKLabelTiles, then wScreenStep += 1. It is a step of the chosen-record screen
; and is also used as a step by other screen tables. (C1, E-0385)
; far-calls ShowInfoOKLabelTiles, then wScreenStep += 1 (E-0122)
ShowString0EAndStep_BankF1::
    farcall ShowInfoOKLabelTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ClearNameTiles", ROMX

; Step 6 of RunScreenStateWhenNotFading_F1_ShowChosenRecord and of
; RunScreenStateWhenNotFading_F1_RedrawBreedScreen: clears the species name tiles (9 x 1 at vTiles1
; + $270) and the name tiles (5 x 1 at vTiles1 + $780) with FillTilesBxC, sets the text window back
; to $8800 ($02, $12) and goes on. (C1, E-0373)
RunScreenStateWhenNotFading_F1_ClearNameTiles::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_DrawChosenName", ROMX

; Step 7 of RunScreenStateWhenNotFading_F1_ShowChosenRecord and of
; RunScreenStateWhenNotFading_F1_RedrawBreedScreen: reads the record index of the list entry
; (SetArg5ToListEntriesCell5), draws its name and species name (DrawRecordNameAndSpeciesNameTiles
; with B = wArg1 = the index) and goes on. (C1, E-0373)
RunScreenStateWhenNotFading_F1_DrawChosenName::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_ShowRecordStats", ROMX

; Screen state 13, the stats screens of the record in wRecordBufB: jumps by wScreenStep to one of 33
; steps listed in the table right after it, each documented at its own label. Steps 0-5 draw the
; first page (clear, heading, frame, values, picture; step 2 is
; RunScreenStateWhenNotFading_F1_PartnerStatsNext), 6 reads its keys, 7 leaves, 8-13 are
; RunScreenStateWhenNotFading_F1_StatsIdle (a bare ret), 14-22 draw and run the second page, 23-29
; the skills page and 30-32 the pedigree page. (C1, E-0385)
; by wScreenStep: the stats screens of record buffer B (picture, name, personality, family icon,
; level and status, skills, category string) with a paged cursor
RunScreenStateWhenNotFading_F1_ShowRecordStats::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_StatsClearScreen
    dw RunScreenStateWhenNotFading_F1_StatsShowHeading
    dw RunScreenStateWhenNotFading_F1_PartnerStatsNext
    dw RunScreenStateWhenNotFading_F1_StatsDrawFrame
    dw RunScreenStateWhenNotFading_F1_StatsDrawValues
    dw RunScreenStateWhenNotFading_F1_DrawPartnerPicture
    dw RunScreenStateWhenNotFading_F1_StatsPage1Keys
    dw RunScreenStateWhenNotFading_F1_StatsLeave
    dw RunScreenStateWhenNotFading_F1_StatsIdle
    dw RunScreenStateWhenNotFading_F1_StatsIdle
    dw RunScreenStateWhenNotFading_F1_StatsIdle
    dw RunScreenStateWhenNotFading_F1_StatsIdle
    dw RunScreenStateWhenNotFading_F1_StatsIdle
    dw RunScreenStateWhenNotFading_F1_StatsIdle
    dw RunScreenStateWhenNotFading_F1_Page2ClearTiles
    dw RunScreenStateWhenNotFading_F1_StatsClearNames
    dw RunScreenStateWhenNotFading_F1_StatsPage2Names
    dw RunScreenStateWhenNotFading_F1_StatsPage2Frame
    dw RunScreenStateWhenNotFading_F1_StatsPersonality
    dw RunScreenStateWhenNotFading_F1_StatsFamilyIcon
    dw RunScreenStateWhenNotFading_F1_StatsLoadSprite
    dw RunScreenStateWhenNotFading_F1_StatsPage2Keys
    dw RunScreenStateWhenNotFading_F1_StatsPage2LevelRow
    dw RunScreenStateWhenNotFading_F1_SkillsPageFrames
    dw RunScreenStateWhenNotFading_F1_SkillsPageClear
    dw RunScreenStateWhenNotFading_F1_StatsSkillNames
    dw RunScreenStateWhenNotFading_F1_StatsDescription
    dw RunScreenStateWhenNotFading_F1_StatsSkillsKeys
    dw RunScreenStateWhenNotFading_F1_StatsLeaveSkills
    dw RunScreenStateWhenNotFading_F1_StatsBackToPage2
    dw RunScreenStateWhenNotFading_F1_StatsPedigreeFrame
    dw RunScreenStateWhenNotFading_F1_StatsDrawParents
    dw RunScreenStateWhenNotFading_F1_StatsPedigreeKeys

; The record stats screen (wScreenState $0D), steps 8-13: a bare ret. No step of
; RunScreenStateWhenNotFading_F1_ShowRecordStats writes 8-13 to wScreenStep (step 7 leaves the
; state, step 6 jumps to $0E), so what reaches them is not found. (C2, E-0373; probed E-0385)
RunScreenStateWhenNotFading_F1_StatsIdle::
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsClearScreen", ROMX

; The partner's monster stats, step 0: clears the BG map and loads the frame tiles. (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsClearScreen::
    farcall ClearBGMapAndLoadFrameTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsShowHeading", ROMX

; The record stats screen, step 1: shows the heading (string $10, ShowStatsHeadingTiles), loads
; sixteen glyph tiles (LoadSixteenGlyphTilesFromTable), draws the short name of wRecordBufB
; (DrawShortStringRecordBufBNameAtTiles1500) and falls into
; RunScreenStateWhenNotFading_F1_PartnerStatsNext (wScreenStep += 1). (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsShowHeading::
    farcall ShowStatsHeadingTiles
    farcall LoadSixteenGlyphTilesFromTable
    call DrawShortStringRecordBufBNameAtTiles1500

; The partner's monster stats, step 2: moves on. (C2, E-0357; probed E-0385)
RunScreenStateWhenNotFading_F1_PartnerStatsNext::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 DrawShortStringRecordBufBNameAtTiles1500", ROMX

; Blanks a 5 x 1 tile area at vTiles1 + $500 (FillTilesBxC), copies the name at wRecordBufB +
; MON_NAME as a short string to wNameGlyphBuf (CopyShortStringToNameGlyphBuf_BankF1) and draws its
; glyphs there (CopyGlyphTilesToVRAM). Called by RunScreenStateWhenNotFading_F1_StatsShowHeading,
; whose step falls on into RunScreenStateWhenNotFading_F1_PartnerStatsNext. (C1, E-0385)
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsDrawFrame", ROMX

; The partner's monster stats, step 3: draws the 20 x 18 stats frame. (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsDrawFrame::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsDrawValues", ROMX

; The partner's monster stats, step 4: draws its level, status and stats
; (DrawRecordBufBStatsScreen). (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsDrawValues::
    farcall DrawRecordBufBStatsScreen
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_DrawPartnerPicture", ROMX

; The partner's monster stats, step 5: draws its picture in two calls. (C1, E-0357)
RunScreenStateWhenNotFading_F1_DrawPartnerPicture::
    farcall DrawRecordBufBSpeciesMonsterPictureInTwoSteps
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPage1Keys", ROMX

; The record stats screen, step 6: clears the Up and Down bits (7, 6) of wJoypadPressedRepeat and
; runs UpdatePagedListCursor; B ($FE) goes on to step 7 (RunScreenStateWhenNotFading_F1_StatsLeave);
; A ($FF) covers the picture with the blank BlankPictureTileRect (6 x 6 at the scroll origin + $161)
; and turns to the second page (step $0E, RunScreenStateWhenNotFading_F1_Page2ClearTiles). (C1,
; E-0373)
RunScreenStateWhenNotFading_F1_StatsPage1Keys::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsLeave", ROMX

; The record stats screen, step 7 (leaving): fills the 32 x 32 BG map from the scroll origin with
; BGFillTile (FillTileRectWithArg1Tile), clears wScreenStep and wScreenSubStep and goes on to the
; next state ($0E, RunScreenStateWhenNotFading_F1_RedrawBreedScreen). (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsLeave::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_Page2ClearTiles", ROMX

; The second page, step 14: clears $0F x 2 tiles at VRAM $9200. (C1, E-0357)
RunScreenStateWhenNotFading_F1_Page2ClearTiles::
    ld hl, vTiles2 + $200
    ld bc, $0f02
    call FillTilesBxC
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsClearNames", ROMX

; The second page, step 15: clears the name and species tile areas. (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsClearNames::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPage2Names", ROMX

; The second page, step 16: draws the name and species name. (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsPage2Names::
    call DrawRecordBufBNameNameAndRecordBufBSpeciesString
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPage2Frame", ROMX

; The second page, step 17: draws the 12 x 15 page frame. (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsPage2Frame::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPersonality", ROMX

; The second page, step 18: shows the personality name and the master name of wRecordBufB
; (ShowRecordBufBPersonalityAndMasterName), wScreenStep += 1, and falls into
; RunScreenStateWhenNotFading_F1_StatsFamilyIcon and RunScreenStateWhenNotFading_F1_StatsLoadSprite,
; so steps 18-20 run in one call and leave wScreenStep at 21. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsPersonality::
    farcall ShowRecordBufBPersonalityAndMasterName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The second page, step 19: with wArg1-wArg4 = $6D, 0, $EA, $C7 draws the family icon and count
; (DrawRecordBufBFamilyIconAndPlus) and the experience and the amount still needed
; (DrawRecordBufBExpAndExpToNextLevel), wScreenStep += 1, and falls into
; RunScreenStateWhenNotFading_F1_StatsLoadSprite. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsFamilyIcon::
    ld a, $6d
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld a, $ea
    ld [wArg3], a
    ld a, $c7
    ld [wArg4], a
    farcall DrawRecordBufBFamilyIconAndPlus
    farcall DrawRecordBufBExpAndExpToNextLevel
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The second page, step 20: decompresses the graphics of the species of wRecordBufB
; (DecompressGraphicsArg1ToArg4, wArg1/wArg2 = MON_SPECIES, wArg4/wArg5 = $00, $80), sets
; hSpriteHideTile = $F0, shows its item name (ShowRecordBufBEquippedItemName), draws the 8 x 7 item
; box MonsterDetailsItemBoxTileRect at the scroll origin + $160 and goes on. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsLoadSprite::
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
    farcall ShowRecordBufBEquippedItemName
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPage2Keys", ROMX

; The second page, step 21: clears the Up and Down bits of wJoypadPressedRepeat and runs
; UpdatePagedListCursor; B ($FE) clears hSpriteHideTile, redraws the first page frames
; (MonsterDetails_DrawStatsPageFrames) and goes back to step 4
; (RunScreenStateWhenNotFading_F1_StatsDrawValues); A ($FF) clears hSpriteHideTile and goes on two
; steps to the skills page (step 23, RunScreenStateWhenNotFading_F1_SkillsPageFrames). (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsPage2Keys::
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
    farcall MonsterDetails_DrawStatsPageFrames
    ld a, $04
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPage2LevelRow", ROMX

; The second page, step 22: draws the level and status row
; (DrawLevelAndStatusRowForRecordBufBLevel), then sets wScreenStep to $0F
; (RunScreenStateWhenNotFading_F1_StatsClearNames). No step of the table moves to 22 (step 21 goes
; to 4 or 23), so what reaches it is not found. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsPage2LevelRow::
    farcall DrawLevelAndStatusRowForRecordBufBLevel
    ld a, $0f
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_SkillsPageFrames", ROMX

; The skills page, step 23: draws its frames. (C1, E-0357)
RunScreenStateWhenNotFading_F1_SkillsPageFrames::
    farcall MonsterDetails_DrawBlankPageFrames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_SkillsPageClear", ROMX

; The skills page, step 24: clears the text tiles and draws the frames. (C1, E-0357)
RunScreenStateWhenNotFading_F1_SkillsPageClear::
    farcall MonsterDetails_DrawSkillsPageFrames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsSkillNames", ROMX

; The skills page, step 25: shows the eight skill names of wRecordBufB, or none
; (ShowRecordBufBSkillNamesOrNone), wScreenStep += 1, and falls into
; RunScreenStateWhenNotFading_F1_StatsDescription, so steps 25 and 26 run in one call. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsSkillNames::
    farcall ShowRecordBufBSkillNamesOrNone
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; The skills page, step 26: shows the species' description (category $0D). (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsDescription::
    farcall ShowSpeciesFieldAbilityName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsSkillsKeys", ROMX

; The skills page, step 27: clears the Up and Down bits of wJoypadPressedRepeat and runs
; UpdatePagedListCursor. B ($FE) clears the tiles of the current text window (FillTilesFromRequest
; reads wTextWindowTileLo to wTextWindowWidth, so the HL = vTiles2 + $200 and BC = $1504 loaded
; before it go unused) and goes on to step 28 (RunScreenStateWhenNotFading_F1_StatsLeaveSkills),
; which leads back to the second page. A ($FF) uploads five tiles (UploadTilesFromData_BankF1),
; draws DrawSummaryFrames and goes on three steps to the pedigree page (step 30,
; RunScreenStateWhenNotFading_F1_StatsPedigreeFrame). (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsSkillsKeys::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsLeaveSkills", ROMX

; The record stats screen, step 28 (B on the skills page), by wScreenSubStep: sub-step 0 sets the
; text window to vTiles2 + $200 with size $1504, clears it (FillTilesFromRequest), draws
; MonsterDetails_DrawSummaryPanelFrames (a 12 x 3 frame at the scroll origin + 8 and the item box)
; and advances the sub-step; sub-step 1 shows the heading (ShowStatsHeadingTiles) and string $0E
; 'InfoOK' with its tiles (ShowString0EAndStep_BankF1, wScreenStep += 1) and clears the sub-step.
; (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsLeaveSkills::
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_show_stats_heading_tiles
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
    farcall MonsterDetails_DrawSummaryPanelFrames
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_show_stats_heading_tiles:
    farcall ShowStatsHeadingTiles
    call ShowString0EAndStep_BankF1
    xor a
    ld [wScreenSubStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsBackToPage2", ROMX

; The record stats screen, step 29: draws the level and status row
; (DrawLevelAndStatusRowForRecordBufBLevel), clears the species name tiles (9 x 1 at vTiles1 +
; $270), draws the name and species (DrawRecordBufBNameNameAndRecordBufBSpeciesString), loads a tile
; from bank $1F (Tiles1Plus4A0Tiles) to vTiles2 + $6F0, sets the text window back to $8800 ($02,
; $12) and sets wScreenStep to $11 (RunScreenStateWhenNotFading_F1_StatsPage2Frame), so B on the
; skills page returns to the second page. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsBackToPage2::
    farcall DrawLevelAndStatusRowForRecordBufBLevel
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    call DrawRecordBufBNameNameAndRecordBufBSpeciesString
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPedigreeFrame", ROMX

; The pedigree page, step 30: draws the 12 x 18 MonsterDetailsPedigreeTileRect at the scroll origin
; + 8, decompresses the graphics of the three species words of wRecordBufB
; (DecompressRecordBufBSpeciesGraphics) and goes on. (C1, E-0373)
RunScreenStateWhenNotFading_F1_StatsPedigreeFrame::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsDrawParents", ROMX

; The pedigree page, step 31: draws the parents (DrawRecordBufBParents) and hides sprite tile $F0.
; (C1, E-0357)
RunScreenStateWhenNotFading_F1_StatsDrawParents::
    farcall DrawRecordBufBParents
    ld a, $f0
    ldh [hSpriteHideTile], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_StatsPedigreeKeys", ROMX

; The pedigree page, step 32: B goes back to the skills page (step $17); A to leaving (step 7). (C1,
; E-0357)
RunScreenStateWhenNotFading_F1_StatsPedigreeKeys::
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

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RedrawBreedScreen", ROMX

; Back to the breeding list after the stats screen (wScreenState $0E), by wScreenStep: 0 restores
; the list place (RunScreenStateWhenNotFading_F1_RestoreListCursor), 1 shows string $0E 'InfoOK'
; with its tiles (ShowString0EAndStep_BankF1), 2-4 run the list
; (RunScreenStateWhenNotFading_F1_RunBreedList), 5 draws the record panel
; (RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel), 6 and 7 clear and draw the chosen name
; (RunScreenStateWhenNotFading_F1_ClearNameTiles, RunScreenStateWhenNotFading_F1_DrawChosenName), 8
; rebuilds the choice box (RunScreenStateWhenNotFading_F1_RedrawChoiceBox) and 9 runs the list once
; more as state $11 (RunScreenStateWhenNotFading_F1_RunBreedListFinal). (C1, E-0373)
; by wScreenStep: resets the list and grid cursors, shows a string (ShowString_Bank0E) and runs
; BreedMenu steps
RunScreenStateWhenNotFading_F1_RedrawBreedScreen::
    ld a, [wScreenStep]
    jumptable
    dw RunScreenStateWhenNotFading_F1_RestoreListCursor
    dw ShowString0EAndStep_BankF1
    dw RunScreenStateWhenNotFading_F1_RunBreedList
    dw RunScreenStateWhenNotFading_F1_RunBreedList
    dw RunScreenStateWhenNotFading_F1_RunBreedList
    dw RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel
    dw RunScreenStateWhenNotFading_F1_ClearNameTiles
    dw RunScreenStateWhenNotFading_F1_DrawChosenName
    dw RunScreenStateWhenNotFading_F1_RedrawChoiceBox
    dw RunScreenStateWhenNotFading_F1_RunBreedListFinal

; Back to the list, step 0: restores the list cursor and page. (C2, E-0357; probed E-0386)
RunScreenStateWhenNotFading_F1_RestoreListCursor::
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RunBreedListFinal", ROMX

; Step 9 (the last) of RunScreenStateWhenNotFading_F1_RedrawBreedScreen: sets wScreenState to $11
; and runs BreedMenu once, but pops the saved wScreenState into A without storing it, so
; wScreenState keeps what BreedMenu left there ($11,
; RunScreenStateWhenNotFading_F1_ShowChosenRecord, unless BreedMenu changed it). (C1, E-0373)
RunScreenStateWhenNotFading_F1_RunBreedListFinal::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RunBreedList", ROMX

; Steps 2-4 of RunScreenStateWhenNotFading_F1_RedrawBreedScreen: runs BreedMenu once with
; wScreenState set to $11 for the call, then restores wScreenState. (C1, E-0373)
RunScreenStateWhenNotFading_F1_RunBreedList::
    ld a, [wScreenState]
    push af
    ld a, $11
    ld [wScreenState], a
    farcall BreedMenu
    pop af
    ld [wScreenState], a
    ret

SECTION "Bank F1 RunScreenStateWhenNotFading_F1_RedrawChoiceBox", ROMX

; Step 8 of RunScreenStateWhenNotFading_F1_RedrawBreedScreen: copies the 9 x 7 choice box
; BreedChoiceBoxTileRect into wWindowTileBuffer + $E7, draws string $0F ('BredInfoExit', its entry
; labels) at VRAM $9600 in a 13 x 1 text window (ShowString_Bank0E), sets the window back to $8800
; ($02, $12) and goes on. (C1, E-0373)
RunScreenStateWhenNotFading_F1_RedrawChoiceBox::
    ld de, BreedChoiceBoxTileRect
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

SECTION "Bank F1 DrawRecordBufBSpeciesSpritePart_BankF1", ROMX

; Draws the monster of wRecordBufB (the partner record on the link screens) as a meta-sprite on the
; record stats screen: wArg1 and wArg2 = its species word (MON_SPECIES), wArg3 = 0 (tile offset),
; wArg4 = $90 and wArg5 = $40 (screen position, added to the scroll), wArg6 = 0 (attribute xor),
; then far-calls DrawMetaSpritePartC0, which takes the animation frame from bit 4 of wFrameCounterLo
; and draws the meta-sprite set. The link-session update routines (GameMode5_Update_LinkSession,
; GameMode5_Update_ExchangeJoypadOnRecords, GameMode5_Update_LinkSession_Breeding and
; ExchangeJoypadAndDrawMonsters) far-call it every frame while wScreenState is $0D and wScreenStep
; is $15 (RunScreenStateWhenNotFading_F1_StatsPage2Keys); at step $20
; (RunScreenStateWhenNotFading_F1_StatsPedigreeKeys) they call DrawRecordBufBSpeciesSprites instead.
; (C1, E-0386)
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

SECTION "Bank F1 UploadTilesFromData_BankF1", ROMX

; Copies the five 16-byte tiles of UploadTilesFromData_BankF1_Tiles to VRAM with
; CopyTileBytesToVRAM_BankF1: the first two to vTiles2 + $6E0 (BG tiles $6E and $6F) and the next
; three to vTiles2 + $7C0 (tiles $7C, $7D and $7E). These are the tile numbers
; MonsterDetailsPedigreeLowerLeftTileRect uses, the small shape that DrawSummaryFrames draws at BG
; row 11, column 0. Its only caller, RunScreenStateWhenNotFading_F1_StatsSkillsKeys, runs it when A
; is pressed on the skills page, just before DrawSummaryFrames. It clobbers A, HL and DE. (C1,
; E-0386)
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

SECTION "Bank F1 UploadTilesFromData_BankF1_Tiles", ROMX

; HL = $5757 and 5 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
UploadTilesFromData_BankF1_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $ff ; entry 0
    db $ff, $ff, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 1
    db $ff, $ff, $ff, $ff, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 2
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $ff, $ff, $ff ; entry 3
    db $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0, $ff, $c0 ; entry 4

; HL = source, DE = VRAM destination: copies 16 bytes (one tile) one byte at a time, each with
; interrupts off after waiting for rSTAT bit 1 to clear, so the write happens while the LCD allows
; VRAM access. HL and DE end 16 bytes further, A = 0 and interrupts are enabled again.
; UploadTilesFromData_BankF1 calls it five times in a row. (C1, E-0386)
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

SECTION "Bank F1 CopyShortStringToNameGlyphBuf_BankF1", ROMX

; HL = source: copies up to 10 bytes to wNameGlyphBuf, stopping before a $F0 byte, then stores a $F0
; terminator after the copied bytes; when the first 10 bytes hold no $F0 the 11th byte is not read.
; HL ends after the last byte read (after the $F0 when it stopped the copy), DE at the terminator, A
; = $F0. Both callers pass HL = wRecordBufB + MON_NAME and then draw the glyph tiles of the buffer
; with CopyGlyphTilesToVRAM: DrawShortStringRecordBufBNameAtTiles1500 and
; DrawRecordBufBNameNameAndRecordBufBSpeciesString. (C2, E-0386)
; Copies up to 10 bytes from [HL] to wNameGlyphBuf, stopping at a $F0 byte, then stores a $F0
; terminator (the same 19 bytes appear in 2 banks)
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

SECTION "Bank F1 DrawRecordBufBNameNameAndRecordBufBSpeciesString", ROMX

; Draws the name and the species name of the record in wRecordBufB for the record stats screen. The
; name (MON_NAME, copied with CopyShortStringToNameGlyphBuf_BankF1) becomes glyph tiles at vTiles1 +
; $780 (CopyGlyphTilesToVRAM). Then wStringIndex = the low byte and wStringCategory = the high byte
; + 2 of the species word (MON_SPECIES), the text window is set to vTiles1 + $270 ($8A70) with 1 row
; of 9 tiles (wTextWindowTileLo/Hi, wTextWindowRows, wTextWindowWidth), and ShowString_Bank08 prints
; that string, the monster name, into those tiles at once. Called by
; RunScreenStateWhenNotFading_F1_StatsPage2Names (second page, step 16) and
; RunScreenStateWhenNotFading_F1_StatsBackToPage2 (step 29, back from the skills page). (C1, E-0386)
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

SECTION "Bank F1 DrawTileRectAtHLFromDE_BankF1", ROMX

; HL = BG map address, DE = packed tiles: stores H and L in wArg5 and wArg6 and D and E in wArg1 and
; wArg2, then far-calls DrawTileRectFromArg1Params. That routine takes the width from wArg3, the
; rows from wArg4, and wArg7 (non-zero keeps the CGB attributes); every caller sets those three
; first, with wArg7 = 0. Callers, all stats screen steps:
; RunScreenStateWhenNotFading_F1_StatsDrawFrame, RunScreenStateWhenNotFading_F1_StatsPage1Keys (the
; blank picture cover), RunScreenStateWhenNotFading_F1_StatsPage2Frame,
; RunScreenStateWhenNotFading_F1_StatsLoadSprite and
; RunScreenStateWhenNotFading_F1_StatsPedigreeFrame. (C1, E-0386)
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

SECTION "Bank F1 CopyScreenBufferRectAt024FAndDrawBox_BankF1", ROMX

; Takes the three-entry choice box off the breeding screen. It copies 7 rows of 9 bytes from
; wScreenTileBuffer + $83 to wScreenTileBuffer + $24F, which is wWindowTileBuffer + $E7, where
; BreedChoiceBoxTileRect was copied (CopyScreenBufferRectWithAttrs_F1 with B = 0, C = 7, HL = $024F,
; DE = $0083, wArg1 = 0, wArg2 = 9; the CGB attributes too), then redraws the 20 x 13 area at
; wScreenTileBuffer + $1CC onto the BG map from the scroll origin (DrawScreenBufferRect_BankF1).
; Both calls are in RunScreenStateWhenNotFading_F1_BreedHandleChoice, before it shows 'Your pal
; refused breeding.' or 'You refused breeding.'. (C1, E-0386)
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

SECTION "Bank F1 BeginString_Bank0E_Cat0", ROMX

; A = string index: sets wStringIndex = A and wStringCategory = 0, then far-calls
; BeginStringDisplay_Bank0E, which starts showing that string of the breeding text list (for example
; 7 'Please wait.', 2 'You refused breeding.'). The text is printed over the following frames
; (wTextFlags stays non-zero until it is done), so the link breeding steps of this bank wait for
; wTextFlags = 0 before they go on. (C1, E-0386)
; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank0E
BeginString_Bank0E_Cat0::
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank0E
    ret

SECTION "Bank F1 HandleThreeChoiceCursorInput_F1", ROMX

; Input handler of a three-entry choice box; the cursor is wTwoChoiceCursor (0-2). Up (bit 6 of
; wJoypadPressedRepeat) or Down (bit 7), Up tested first: draws the blank tile $C3 over the old
; cursor, moves wTwoChoiceCursor with wrap-around (Up from 0 goes to 2, Down from 2 goes to 0),
; clears wScreenCounter, draws the cursor tile $BB at the new entry, queues sound effect $69 and
; returns wMenuInputResult = A = $FD. Otherwise A (bit 0 of wJoypadPressed) draws the tile $BC at
; the current entry, queues sound $69 and returns $FF; B (bit 1) returns $FE with no sound; with no
; press it calls BlinkCursorScreenCounter_BankF1 and returns 0. The three entries are at BG rows 7,
; 9 and 11, column 12 from the scroll origin (DrawTileBAtTwoChoiceEntry_BankF1_Data). Callers:
; RunScreenStateWhenNotFading_F1_BreedHandleChoice (the 'BredInfoExit' box) and, by farcall,
; RunLinkSession6Exchange_FightInfo_Choice (Fight, Info, Ex) and
; EggServiceMenu_Bank1B_StartLinkBattle_ReadChoice (Battle, Prize, Exit). (C1, E-0386)
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

SECTION "Bank F1 BlinkCursorScreenCounter_BankF1", ROMX

; Blinks the choice cursor, called once per frame while no button is pressed. While
; wJoypadRepeatTimer is below $14 (a button is held and the repeat timer is counting down) it just
; draws the cursor tile $BB (DrawCursorTileBB_BankF1). At $14 or more (no button held, or the frame
; a button is first pressed) it adds 1 to wScreenCounter: below $10 it draws the cursor tile $BB,
; from $10 to $17 the blank tile $C3 (DrawBlankTileC3_BankF1), and at $18 it resets the counter to 0
; and draws $BB. So the cursor shows for 16 calls and is blank for 8. (C1, E-0386)
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

; B = $BB, the cursor tile, then jumps to DrawTileBAtTwoChoiceEntry_BankF1, which writes tile B into
; the BG map at the entry chosen by wTwoChoiceCursor (BG rows 7, 9 and 11, column 12 from the scroll
; origin). Used by HandleThreeChoiceCursorInput_F1 after the cursor moves and by
; BlinkCursorScreenCounter_BankF1 for the visible phase. (C1, E-0386)
; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_BankF1::
    ld b, $bb
    jr DrawTileBAtTwoChoiceEntry_BankF1

SECTION "Bank F1 DrawBlankTileC3_BankF1", ROMX

; B = $C3, the blank tile, then jumps to DrawTileBAtTwoChoiceEntry_BankF1, which writes it at the
; entry chosen by wTwoChoiceCursor. It erases the cursor: HandleThreeChoiceCursorInput_F1 calls it
; before moving the cursor, and BlinkCursorScreenCounter_BankF1 uses it for the hidden phase of the
; blink. (C1, E-0386)
; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_BankF1::
    ld b, $c3
    jr DrawTileBAtTwoChoiceEntry_BankF1

SECTION "Bank F1 DrawArrowTileBCAtTwoChoiceEntry_BankF1", ROMX

; B = $BC, then falls into DrawTileBAtTwoChoiceEntry_BankF1, which writes tile $BC at the entry
; chosen by wTwoChoiceCursor. HandleThreeChoiceCursorInput_F1 calls it when A is pressed, so the
; chosen entry shows $BC; the breeding choice later stores the same $BC for entry 0 in its window
; buffer (RunScreenStateWhenNotFading_F1_BreedHandleChoice). (C1, E-0386)
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

SECTION "Bank F1 DrawTileBAtTwoChoiceEntry_BankF1_Data", ROMX

; Three offsets, $00EC, $012C and $016C (rows 7, 9 and 11 at column 12).
; DrawTileBAtTwoChoiceEntry_BankF1 indexes them with wTwoChoiceCursor, adds the offset to the BG map
; address of the scroll position (BGMapAddressAtScroll_BankF1) and writes tile B there. (C1, E-0381)
DrawTileBAtTwoChoiceEntry_BankF1_Data::
    db $ec, $00, $2c, $01, $6c, $01

; Copies a block inside the screen buffers, row by row. C = number of rows, DE = source offset and
; HL = destination offset in wScreenTileBuffer, wArg1:wArg2 = the number of bytes in each row as a
; 16-bit count (the callers pass wArg1 = 0 and the width in wArg2). Each row is copied with
; CopyBytesDEToHL_BankF1, then DE and HL each advance by 20 for the next row. On a CGB (wIsCGB
; non-zero) the same rectangle is also copied inside wScreenAttrBuffer with
; CopyLow3BitsToWRAMBank2_BankF1, so each attribute byte keeps only its low 3 bits (the palette
; number). On return HL and DE are 20 * C further, C = 0 and B is unchanged. Callers:
; CopyScreenBufferRectAt0278AndStep_BankF1 and CopyScreenBufferRectAt024FAndDrawBox_BankF1. (C2,
; E-0386)
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

SECTION "Bank F1 CopyBytesDEToHL_BankF1", ROMX

; DE = source, HL = destination, BC = count: copies BC bytes (the count is tested after the first
; byte, so BC = 0 would copy 65536). On return DE and HL are past the copy, BC = 0, A = 0 and Z is
; set. CopyScreenBufferRectWithAttrs_F1 uses it for one row at a time. (C2, E-0386)
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

SECTION "Bank F1 CopyLow3BitsToWRAMBank2_BankF1", ROMX

; DE = source, HL = destination, BC = count: sets rSVBK = 2, copies BC bytes with each byte ANDed
; with $07 (a CGB attribute byte keeps only its palette number), then sets rSVBK = 0. While the loop
; runs, addresses from $D000 are WRAM bank 2; CopyScreenBufferRectWithAttrs_F1 passes
; wScreenAttrBuffer addresses. On return DE and HL are past the copy, BC = 0, A = 0, and rSVBK is 0
; whatever it was before. (C2, E-0386)
; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks)
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

SECTION "Bank F1 LoadFamilyIconTileForRecordB_BankF1", ROMX

; B = number of a record in save RAM (sRecords), wArg1 = BG tile number: enables SRAM bank 0, reads
; the byte MON_FAMILY of record B (LoadSRAMRecordByte), keeps its low nibble, the family, in
; wWorkBuf, sets wWorkBuf + 1 = wArg1 and far-calls LoadFamilyIconTileForWorkBuf, which writes the
; 16-byte icon of that family to tile wArg1; then disables SRAM again (rRAMG2 = 0). Its one caller,
; RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel, passes wArg1 = $C7, the tile in column 1 of
; the fourth row of BreedRecordPanelTileRect. (C1, E-0386)
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

SECTION "Bank F1 CopyRectTo20ByteRows_BankF1", ROMX

; DE = source (packed rows), HL = destination, B = width, C = rows: copies the rectangle into a
; buffer whose rows are 20 bytes apart. On a DMG (wIsCGB = 0) it returns with Z set, HL and BC as
; they were and DE past the source. On a CGB it then zero-fills the same-shaped rectangle at HL +
; $0E68 with rSVBK = 2 (for HL inside wWindowTileBuffer that is wWindowAttrBuffer, so the new tiles
; get attribute 0), sets rSVBK = 0 and returns with HL = HL + $0E68 + 20 * C and C = 0. Callers draw
; boxes into wWindowTileBuffer: RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel (12 x 5 panel),
; RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox and
; RunScreenStateWhenNotFading_F1_RedrawChoiceBox (9 x 7 choice box) and
; RunScreenStateWhenNotFading_F1_BreedAskToRecord (6 x 5 yes/no box). (C2, E-0386)
; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks)
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

SECTION "Bank F1 DrawScreenBufferRect_BankF1", ROMX

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: copies that
; rectangle of wScreenTileBuffer to the BG map with CopyRectToBGMapWrapped, then sets wTextCursorLo
; and wTextCursorHi to HL + $1C1 (the BG address where the next text row starts: 14 rows and one
; column on from HL). On a CGB it also copies the matching rectangle of wScreenAttrBuffer + DE (WRAM
; bank 2) into VRAM bank 1 at the same BG address, then sets rVBK and rSVBK back to 0. On a DMG BC,
; DE and HL come back unchanged; on a CGB they do not. The callers redraw the 20 x 13 area (B = $14,
; C = $0D, DE = $01CC, HL from BGMapAddressAtScroll_BankF1):
; CopyScreenBufferRectAt024FAndDrawBox_BankF1, RunScreenStateWhenNotFading_F1_BreedLoadPick,
; RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox and
; RunScreenStateWhenNotFading_F1_BreedAskToRecord. (C1, E-0386)
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

SECTION "Bank F1 BGMapAddressAtScroll_BankF1", ROMX

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8: the address in BG map 0 of the tile at the
; current scroll position (32 entries per row). Clobbers A and DE. Nearly every drawing step of this
; bank starts with it to place a rectangle or a cursor tile relative to the visible screen. (C1,
; E-0386)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
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

SECTION "Bank F1 StoreBAtWordTableEntry_BankF1", ROMX

; HL = table of words, A = index, B = value: reads the word at HL + 2 * A as an address and stores B
; there. BC is kept; on return A = B, DE = the address and HL = the table + 2 * A + 1. Its one
; caller, RunScreenStateWhenNotFading_F1_BreedHandleChoice, passes the table BreedChoiceMarkBufAddrs
; with A = wTwoChoiceCursor and B = $BC, to put the mark tile at the chosen entry of the choice box
; in wWindowTileBuffer. (C2, E-0386)
; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks)
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

SECTION "Bank F1 BreedRecordPanelTileRect", ROMX

; A 12 by 5 tile rectangle, 60 bytes in row order: a frame of tiles $B0-$B7 around blanks, with
; $F8-$FC, $EA and $ED in the second row and $C7 followed by $A7-$AF in the fourth.
; RunScreenStateWhenNotFading_F1_LinkBreed_DrawPanel copies it with CopyRectTo20ByteRows_BankF1 to
; wWindowTileBuffer + $6C (rows 20 bytes apart); it first sets wArg1 to $C7 and calls
; LoadFamilyIconTileForRecordB_BankF1 and afterwards draws the record field marks and digits over
; the second row. (C1, E-0381)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 5 tiles, one row per line
BreedRecordPanelTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; A 6 x 5 framed box (border tiles $B0-$B7, blank $C3) holding the yes/no glyph tiles $70-$72 on row
; 1 and $76, $73 on row 3; the link breeding step that asks for the answer copies it into the screen
; buffer. (C1, E-0373)
; record: 6 x 5 tiles, one row per line
BreedYesNoBoxTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; A 9 x 7 framed box (border tiles $B0-$B7) with three entry rows: tiles $60 $61 $62 $62 $63,
; $64-$67 and $68-$6B at columns 3-7 of rows 1, 3 and 5, the tiles where string $0F ('BredInfoExit')
; is drawn at VRAM $9600; column 1 of those rows is the cursor place. Copied into wWindowTileBuffer
; + $E7 by RunScreenStateWhenNotFading_F1_BreedDrawChoiceBox and
; RunScreenStateWhenNotFading_F1_RedrawChoiceBox. (C1, E-0373)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 9 x 7 tiles, one row per line
BreedChoiceBoxTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $60, $61, $62, $62, $63, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $64, $65, $66, $67, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $68, $69, $6a, $6b, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; Three little-endian words $C3FC, $C424, $C44C: the wWindowTileBuffer addresses (+ $FC, + $124, +
; $14C; column 12 of rows 12, 14 and 16) of the cursor column of the three entries of
; BreedChoiceBoxTileRect. RunScreenStateWhenNotFading_F1_BreedHandleChoice stores the mark tile $BC
; at entry wTwoChoiceCursor (StoreBAtWordTableEntry_BankF1), which is 0 there, so the mark on the
; first entry stays when the buffer is redrawn. (C1, E-0373)
BreedChoiceMarkBufAddrs::
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

SECTION "Bank F1 ExchangeJoypadAndDrawSprites_DrawCompletionMark", ROMX

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

SECTION "Bank F1 DrawLinkScreenSprites", ROMX

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
    farcall DrawListEntriesCell5PedigreeSprites
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
    farcall DrawPedigreeSpeciesSprites
    ret

SECTION "Bank F1 ExchangeJoypadAndDrawSprites_DrawSpriteSlots", ROMX

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

SECTION "Bank F1 ExchangeJoypadAndDrawSprites_NameGiftEgg", ROMX

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

SECTION "Bank F1 LoadBGPalettesFromData", ROMX

; Copies the $40 bytes at LoadBGPalettesFromData_Data, eight CGB palettes of four RGB555 colours, to
; wBGPaletteBuffer. Palette 0 is $3DEE, $7FFF, $5AD6, $0063; palette 1 is $3612, $7FFF, $42D8,
; $0066; palette 2 is $3612, $7FFF, $42D8, $30BF; palettes 3 to 7 are $7FFF (white) in all four
; colours. Its one caller, LibraryMenu_ShowMonsterEntry_LoadScreen, far-calls it on a CGB only, then
; sets wBGPaletteUploadRequest = $7F and calls UploadBGPalettes, so the monster library entry page
; uses these palettes. (C2, E-0386)
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

SECTION "Bank F1 LibraryEntryPageTiles", ROMX

; Tiles, 544 bytes decompressed (34 tiles). LibraryMenu_ShowMonsterEntry_LoadScreen decompresses it
; to vTiles1 (BG tiles $80-$A1) when it builds a monster library entry page. Render: a book page:
; the dithered page edge and page-curl corners, a pill-shaped name bar, a bracket, the labels Size :
; and Rare : in the game font, and a framed box with corner studs and dashed rules. (C1, E-0383)
; LZSS-compressed: 304 bytes that expand to 544 (E-0016, E-0017)
LibraryEntryPageTiles::
    INCBIN "gfx/misc/library_entry_page_tiles.lz"

; Tile map, 260 bytes decompressed (13 rows of 20 cells, tile numbers $80-$A1 from Tiles1Gfx_3).
; LibraryMenu_ShowMonsterEntry_LoadScreen decompresses it to wWindowTileBuffer + $64 (the rows below
; the first five, which LibraryEntryBottomBoxTileMap supplies) with WindowAttrBufferPlus64Gfx as its
; attribute map; the page text, icon and class blocks are then copied over it. Rendered with
; LibraryEntryPageTiles and the five bottom rows: the library entry page, Size and Rare labels, a
; name bar near the top and a framed box on the right. (C1, E-0383)
; LZSS-compressed: 88 bytes that expand to 260 (E-0016, E-0017)
LibraryEntryPageTilemap::
    INCBIN "gfx/misc/library_entry_page_tilemap.lz"

; LZSS-compressed: 32 bytes that expand to 100, the first five 20-byte rows of wWindowTileBuffer for
; the library entry screen: a 20 x 5 box with tile $80 inside, side tiles $9C and $9D, bottom row
; $9E $9F $A0 ... $A1 and a top row of $9C, seven $80, then $90, nine $91, $92 and $9D.
; LibraryMenu_ShowMonsterEntry_LoadScreen decompresses it to wWindowTileBuffer after
; LibraryEntryPageTilemap fills the rows from + $64, and draws these five rows at BG rows 13-17
; (DrawScreenBufferRect_Bank0C from offset $0168, the scroll origin + $1A0). (C1, E-0373)
; LZSS-compressed: 32 bytes that expand to 100 (E-0016, E-0017)
LibraryEntryBottomBoxTileMap::
    db $64, $00, $00, $9c, $80, $00, $01, $02, $90, $91, $00, $09, $04, $92, $9d, $00
    db $00, $04, $00, $15, $07, $00, $13, $0f, $16, $9e, $9f, $a0, $00, $52, $0c, $a1

; LZSS-compressed: 50 bytes that expand to 260 (E-0016, E-0017)
WindowAttrBufferPlus64Gfx::
    db $04, $01, $03, $01, $03, $00, $0f, $01, $03, $ee, $ff, $01, $03, $f8, $fd, $03
    db $26, $07, $03, $1d, $0f, $01, $03, $45, $0f, $28, $03, $08, $0f, $01, $03, $14
    db $06, $03, $9e, $07, $03, $09, $0b, $02, $02, $02, $02, $03, $a8, $0f, $11, $03
    db $a4, $0c

; LZSS-compressed: 22 bytes that expand to 100, the CGB attributes of the same five rows
; (LibraryEntryBottomBoxTileMap): palette 1 on the side and bottom tiles and on columns 8-19 of the
; top row, palette 0 elsewhere. LibraryMenu_ShowMonsterEntry_LoadScreen decompresses it to
; wWindowAttrBuffer (WRAM bank 2) on CGB only. (C1, E-0373)
; LZSS-compressed: 22 bytes that expand to 100 (E-0016, E-0017)
LibraryEntryBottomBoxAttrMap::
    db $64, $00, $02, $01, $02, $f9, $f4, $02, $08, $08, $02, $ee, $ff, $00, $02, $14
    db $0f, $16, $02, $4f, $0f, $00

LoadBGPalettesFromData_Data::
    db $ee, $3d, $ff, $7f, $d6, $5a, $63, $00, $12, $36, $ff, $7f, $d8, $42, $66, $00
    db $12, $36, $ff, $7f, $d8, $42, $bf, $30, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f
    db $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f
    db $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f
    ds $21bc, $00
