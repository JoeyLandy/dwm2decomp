; ROM bank $0D: TinyMedal prizes, egg appraisal and blessing, key appraisal
; The annotated listing of this bank is build/listing/bank0d.asm.

SECTION "Bank 0D", ROMX[$4000], BANK[$0D]
    db $0d

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank0D::
    ld de, BeginStringDisplay_Bank0D_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank0D (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0353)
ShowString_Bank0D::
    call BeginStringDisplay_Bank0D
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank0D_StringCategories::
    dw StringList_Bank0D_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank0D_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank0D_StringCategories_0::
    dw String_0D_00_00 ; id 0
    dw String_0D_00_00 ; id 1
    dw String_0D_00_02 ; id 2
    dw String_0D_00_03 ; id 3
    dw String_0D_00_04 ; id 4
    dw String_0D_00_05 ; id 5
    dw String_0D_00_06 ; id 6
    dw String_0D_00_06 ; id 7
    dw String_0D_00_08 ; id 8
    dw String_0D_00_09 ; id 9
    dw String_0D_00_0A ; id 10
    dw String_0D_00_0B ; id 11
    dw String_0D_00_0C ; id 12
    dw String_0D_00_0C ; id 13
    dw String_0D_00_0C ; id 14
    dw String_0D_00_0C ; id 15
    dw String_0D_00_10 ; id 16
    dw String_0D_00_10 ; id 17
    dw String_0D_00_12 ; id 18
    dw String_0D_00_13 ; id 19
    dw String_0D_00_14 ; id 20
    dw String_0D_00_15 ; id 21
    dw String_0D_00_16 ; id 22
    dw String_0D_00_17 ; id 23
    dw String_0D_00_18 ; id 24
    dw String_0D_00_19 ; id 25
    dw String_0D_00_1A ; id 26
    dw String_0D_00_1B ; id 27
    dw String_0D_00_1C ; id 28
    dw String_0D_00_1D ; id 29
    dw String_0D_00_1E ; id 30
    dw String_0D_00_1F ; id 31
    dw String_0D_00_20 ; id 32
    dw String_0D_00_21 ; id 33
    dw String_0D_00_22 ; id 34
    dw String_0D_00_23 ; id 35
    dw String_0D_00_24 ; id 36
    dw String_0D_00_25 ; id 37
    dw String_0D_00_25 ; id 38
    dw String_0D_00_25 ; id 39
    dw String_0D_00_25 ; id 40
    dw String_0D_00_29 ; id 41
    dw String_0D_00_2A ; id 42
    dw String_0D_00_2B ; id 43
    dw String_0D_00_2C ; id 44
    dw String_0D_00_2D ; id 45
    dw String_0D_00_2E ; id 46
    dw EggServiceMenu ; id 47

String_0D_00_00::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Key Shop.<PROMPT>"
    db "<NEXT>Do you need any"
    db "<NEXT>keys appraised?@"

String_0D_00_02::
    db "<VOICE1>Okay. Come back if<LINE>"
    db "you find any Magic<PROMPT>"
    db "<NEXT>Keys."
    db "<NEXT><WAIT>"
    db "@"

String_0D_00_03::
    db "<VOICE1>*: Don't come if<LINE>"
    db "you have no keys.<WAIT>"
    db "@"

String_0D_00_04::
    db "<VOICE1>Which key should<LINE>"
    db "I appraise?<WAIT>"
    db "@"

String_0D_00_05::
    db "<VOICE1>*: Appraisal will<LINE>"
    db "cost <BUF0>G. OK?@"

String_0D_00_06::
    db "<VOICE1>*: Hah? I'm not<LINE>"
    db "appraising any<PROMPT>"
    db "<NEXT>key if you don't"
    db "<NEXT>pay my fee.<WAIT>"
    db "@"

String_0D_00_08::
    db "<VOICE1>*: Which Magic Key<LINE>"
    db "should I appraise?@"

String_0D_00_09::
    db "<VOICE1>*: That key's been<LINE>"
    db "appraised already.<WAIT>"
    db "@"

String_0D_00_0A::
    db "<VOICE1>*: You have no more<LINE>"
    db "Magic Keys that<PROMPT>"
    db "<NEXT>need appraisal, it"
    db "<NEXT>seems to me.<WAIT>"
    db "@"

String_0D_00_0B::
    db "<VOICE1>*: Should I save<LINE>"
    db "the results?@"

String_0D_00_0C::
    db "<VOICE1>*: Let's see the<LINE>"
    db "Magic Key, then.<PROMPT>"
    db "<NEXT>…Hmmm… Hah?"
    db "<NEXT>Oh, right…<PROMPT>"
    db "<NEXT>I got it! This is"
    db "<NEXT>the <BUF0>!<MUSIC_WAIT>", $00, "<SFX_WAIT>", $d4, "<WAIT>"
    db "<MAP_MUSIC>@"

String_0D_00_10::
    db "<VOICE1>*: Ah, you have<LINE>"
    db "some TinyMedals?<PROMPT>"
    db "<NEXT>Let me relieve you"
    db "<NEXT>of them.<WAIT>"
    db "@"

String_0D_00_12::
    db "<VOICE1>*: …But, I can't<LINE>"
    db "take this many.<WAIT>"
    db "@"

String_0D_00_13::
    db "<VOICE1>*: I have <BUF0> of<LINE>"
    db "your TinyMedals.<WAIT>"
    db "@"

String_0D_00_14::
    db "<VOICE1>*: I hope you'll<LINE>"
    db "find many medals!<WAIT>"
    db "@"

String_0D_00_15::
    db "<VOICE1>*: Want to trade<LINE>"
    db "medals for prizes?@"

String_0D_00_16::
    db "<VOICE1>*: Which prize do<LINE>"
    db "you want?@"

String_0D_00_17::
    db "<VOICE1>*: I'll trade for<LINE>"
    db "<BUF0> TinyMedals. OK?@"

String_0D_00_18::
    db "<VOICE1>*: That requires<LINE>"
    db "more TinyMedals.<WAIT>"
    db "@"

String_0D_00_19::
    db "<VOICE1>*: You don't have<LINE>"
    db "any room for that.<WAIT>"
    db "@"

String_0D_00_1A::
    db "<VOICE1>*: Your key ring is<LINE>"
    db "already full.<WAIT>"
    db "@"

String_0D_00_1B::
    db "<VOICE1>*: You have no more<LINE>"
    db "room for monsters.<WAIT>"
    db "@"

String_0D_00_1C::
    db "<VOICE1>*: Fine, we shall<LINE>"
    db "trade.<WAIT>"
    db "@"

String_0D_00_1D::
    db "<VOICE1>*: I'll send the egg<LINE>"
    db "to the farm.<WAIT>"
    db "@"

String_0D_00_1E::
    db "<VOICE1>*: You can't take<LINE>"
    db "any more items.<WAIT>"
    db "@"

String_0D_00_1F::
    db "<VOICE1>*: You can't hold any<LINE>"
    db "more keys.<WAIT>"
    db "@"

String_0D_00_20::
    db "<VOICE1>*: You have no more<LINE>"
    db "room for monsters.<WAIT>"
    db "@"

String_0D_00_21::
    db "Leads to another<LINE>"
    db "world.@"

String_0D_00_22::
    db "Tames a monster by<LINE>"
    db "a great amount.@"

String_0D_00_23::
    db "<BUF0>'s egg.@"

String_0D_00_24::
    db "<VOICE1>*: At minimum, you<LINE>"
    db "must have three<PROMPT>"
    db "<NEXT>TinyMedals if you"
    db "<NEXT>want me to trade.<PROMPT>"
    db "<NEXT>I hope you'll find"
    db "<NEXT>many medals!<WAIT>"
    db "@"

String_0D_00_25::
    db "MeteOrb@"

String_0D_00_29::
    db "MadCat@"

String_0D_00_2A::
    db "HornBeet@"

String_0D_00_2B::
    db "SkyDragon@"

String_0D_00_2C::
    db "Octogon@"

String_0D_00_2D::
    db "Servant@"

String_0D_00_2E::
    db "Darck@"

; implements script command type EF (SCRIPT_EGG_SERVICE): egg appraisal and blessing: 'Which egg
; should I appraise?', 'Which egg should I bless?' (mode 6, bank $F2 strings); reached through
; ScriptCommandEF in bank $10 (E-0038, E-0244) (C2 from E-0325: the Egg Evaluator's 'May I help
; you…' runs it with 'Evaluate / Bless / Exit')
EggServiceMenu::
    ld a, [wScreenState]
    jumptable
    dw EggServiceMenu_CopyBytesDEToHL_Bank0D
    dw EggServiceMenu_DrawPrice
    dw EggServiceMenu_HandleThreeOptionMenuInput_15
    dw EggServiceMenu_ListRecordsInUseEggs
    dw EggServiceMenu_Return
    dw EggServiceMenu_ChooseAndPay
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_SwapMonstersMenu
    dw EggServiceMenu_Return_2
    dw EggServiceMenu_DrawListAndPrice

; Egg service, state 6: nothing (the script runs its message). (C1, E-0357)
EggServiceMenu_Return_2::
    ret

; Egg service, state 0: clears the service's state, copies the screen to the window buffer and sets
; message mode 6 for its messages. (C1, E-0357)
EggServiceMenu_CopyBytesDEToHL_Bank0D::
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
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_06
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

.set_message_mode_to_06:
    ld a, $06
    ld [wMessageMode], a
    xor a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: two rectangles and a 24-bit number (Number24ToPackedBCD) (E-0293)
EggServiceMenu_DrawPrice::
    ld a, [wScreenStep]
    jumptable
    dw DrawPairAndStep
    dw EggServiceMenu_DrawPrice_Number24ToPackedBCD
    dw EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D

; runs CopyGlyphTileListFromBank1F for DrawPairAndStep_TileCopyDestList and
; DrawPairAndStep_TileCopySrcList, then wScreenStep += 1 (E-0122) (E-0344: the address in its name
; dropped or read as the label there; was DrawPairAndStep)
DrawPairAndStep::
    ld hl, DrawPairAndStep_TileCopyDestList
    ld de, DrawPairAndStep_TileCopySrcList
    call CopyGlyphTileListFromBank1F
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Egg service price display, step 1: draws the gold box with the five digits of wGold. (C1, E-0357)
EggServiceMenu_DrawPrice_Number24ToPackedBCD::
    ld de, EggServiceMenu_DrawPrice_Number24ToPackedBCD_TileRect
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
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

; Egg service price display, step 2: draws the service's choice box and moves on. (C1, E-0357)
EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D::
    ld de, EggServiceMenu_DrawPrice_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $07
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Egg service, state 2: the three-option menu (appraise, bless, cancel) through
; HandleThreeOptionMenuInput_15. (C1, E-0357)
EggServiceMenu_HandleThreeOptionMenuInput_15::
    ld a, $01
    ld [wThreeOptionResult], a
    farcall HandleThreeOptionMenuInput_15
    ret

; Egg service, state 3: lists the stored eggs (ListRecordsInUseEggs; wSharedMenuWork 0 for
; appraisal, 1 for blessing); with none it returns to the menu with a message, otherwise moves on
; with the sprites hidden. (C1, E-0357)
EggServiceMenu_ListRecordsInUseEggs::
    ld a, [wGridCursorX]
    and a
    jr z, .clear_shared_menu_work
    jr .set_shared_menu_work_to_01

.clear_shared_menu_work:
    xor a
    ld [wSharedMenuWork], a
    jr .call_list_records_in_use_eggs

.set_shared_menu_work_to_01:
    ld a, $01
    ld [wSharedMenuWork], a

.call_list_records_in_use_eggs:
    farcall ListRecordsInUseEggs
    ld a, [wRecordsFlagged]
    and a
    jr z, .set_two_choice_cursor_to_01
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Egg service, state 4: nothing. (C1, E-0357)
EggServiceMenu_Return::
    ret

; by wScreenStep: BreedMenu list steps, a two-choice confirmation and IsAmountInArg1AboveGold
; (E-0288)
EggServiceMenu_ChooseAndPay::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_UpdatePagedListCursor
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_HandleTwoChoiceCursorInput_0D
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_ToBreedMenu
    dw EggServiceMenu_ChooseAndPay_IsAmountInArg1AboveGold
    dw DrawBoxWithPageIndicator
    dw EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks
    dw EggServiceMenu_ChooseAndPay_CheckAndPay

; Choosing an egg, step 0: runs the breeding list's steps (BreedMenu) to show the eggs. (C1, E-0357)
EggServiceMenu_ChooseAndPay_ToBreedMenu::
    farcall BreedMenu
    ret

; Choosing an egg, step 6: the paged egg list cursor: page changes step back to redraw; A picks the
; egg (asking to confirm); B cancels. (C1, E-0357)
EggServiceMenu_ChooseAndPay_UpdatePagedListCursor::
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
    ld hl, EggServiceMenu_ChooseAndPay_UpdatePagedListCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wSharedMenuWork]
    and a
    jr z, .skip4
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld b, $04
    ld hl, wArg4

.loop:
    ld a, [hl]
    cp $e3
    jr nz, .skip
    dec b
    inc hl
    ld a, b
    and a
    jr nz, .loop

.skip:
    ld de, wTextBuf0

.skip2:
    ld a, b
    and a
    jr z, .skip3
    ld a, [hl]
    ld [de], a
    inc de
    inc hl
    dec b
    jr .skip2

.skip3:
    ld a, $f0
    ld [de], a

.skip4:
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

; Choosing an egg, step 12: the confirmation: yes opens the egg's details screen (SwapMonstersMenu
; at state $0D, returning to state 5, step 12); no or B goes back. (C1, E-0357)
EggServiceMenu_ChooseAndPay_HandleTwoChoiceCursorInput_0D::
    xor a
    ld [wArg5], a
    call HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a
    ret z
    cp $fe
    jr z, .set_two_choice_cursor_to_02
    cp $ff
    jr z, .check_choice_cursor
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

.check_choice_cursor:
    ld a, [wChoiceCursor]
    and a
    jp nz, .set_two_choice_cursor_to_01
    ld a, $05
    ld [wReturnScreenState], a
    ld a, $0c
    ld [wReturnScreenStep], a
    ld a, $0d
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

; Choosing an egg, step 15: checks the price: 20 gold for an appraisal; for a blessing 20 * (plus
; value + 1) (EggServiceMenu_SetArg5ToListEntriesCell4). With enough gold it pays and moves on;
; otherwise it refuses. (C1, E-0357)
EggServiceMenu_ChooseAndPay_IsAmountInArg1AboveGold::
    ld a, [wSharedMenuWork]
    and a
    jr nz, .call_egg_service_menu_set_arg5_to_list
    ld a, $14
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    and a
    jr nz, .set_two_choice_cursor_to_01
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

.call_egg_service_menu_set_arg5_to_list:
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    and a
    jr z, .call_set_arg5_to_list_entries_cell4

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

.call_set_arg5_to_list_entries_cell4:
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
    ld c, MON_SEX
    call SRAMRecordAddress
    ld a, [hl]
    and a
    jr z, .skip
    xor a
    jr .skip2

.skip:
    ld a, $01

.skip2:
    ld [hl], a
    xor a
    ld [rRAMG2], a
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    farcall SubtractArg1AmountFromGold
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

; copies box DrawBoxWithPageIndicator_TileRect to wWindowTileBuffer + $BB, runs
; ClampRecordListPageCursor4, draws the page-of-pages indicator when wListPages >= 2, and
; wScreenStep += 1 (E-0124) (E-0344: the address in its name dropped or read as the label there; was
; DrawBoxWithPageIndicator)
DrawBoxWithPageIndicator::
    ld de, DrawBoxWithPageIndicator_TileRect
    ld hl, wWindowTileBuffer + $bb
    lb bc, $0d, $09
    call CopyRectTo20ByteRows_Bank0D
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
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

; Choosing an egg, step 17: redraws the egg list marks and returns to the list (step 7). (C1,
; E-0357)
EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $07
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenSubStep: reads bytes of the chosen record (LoadSRAMRecordByte/Word, MON_SEX), divides,
; and subtracts 20 gold (SubtractArg1AmountFromGold) (E-0304)
EggServiceMenu_ChooseAndPay_CheckAndPay::
    ld a, [wScreenSubStep]
    jumptable
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_EndScriptCommandAndIncScreenSubStep
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_2
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_3
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_4
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_5
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_SubtractArg1AmountFromGold

; Appraisal, sub-step 0: clears the result and moves on. (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_EndScriptCommandAndIncScreenSubStep::
    xor a
    ld [wTwoChoiceCursor], a
    call EndScriptCommandAndIncScreenSubStep
    ret

; Appraisal, sub-step 1: rates the egg's stats: the average of six stat words (fields from
; EggServiceMenu_ChooseAndPay_CheckAndPay_Data), reduced to a rating 0-3 for the message. (C1,
; E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM::
    call GetListEntriesCell4AddressWithSRAM
    ld c, $00
    ld de, $0000

.loop:
    push hl
    push bc
    push de
    ld a, c
    ld de, EggServiceMenu_ChooseAndPay_CheckAndPay_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    pop de
    ldh a, [hTemp0]
    add e
    ld e, a
    ldh a, [hTemp1]
    adc d
    ld d, a
    pop bc
    pop hl
    inc c
    ld a, c
    cp $06
    jr c, .loop
    ld l, e
    ld h, d
    ld a, $06
    call DivideHLByA
    ld a, h
    and a
    jr z, .skip2

.loop2:
    ld a, $03
    jr EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip2:
    ld a, l
    cp $c9
    jr nc, .loop2
    cp $65
    jr nc, .skip3
    cp $33
    jr nc, .skip4
    xor a
    jr EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip3:
    ld a, $02
    jr EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip4:
    ld a, $01

; Stores the appraisal result in wTwoChoiceCursor (it picks the message), closes SRAM and moves to
; the next appraisal step. (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor::
    ld [wTwoChoiceCursor], a
    xor a
    ld [rRAMG2], a
    call EndScriptCommandAndIncScreenSubStep
    ret

; data read by EggServiceMenu (6 bytes) (E-0347)
EggServiceMenu_ChooseAndPay_CheckAndPay_Data::
    db $5d, $61, $63, $65, $67, $69

; Appraisal, sub-step 2: rates the number of skills the egg can learn (entries of MON_SKILL_LIST):
; below 6 is 0, below 11 is 1, below 16 is 2, otherwise 3. (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_2::
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, MON_SKILL_LIST
    call SRAMRecordAddress
    ld c, $00
    ld b, $00

.loop:
    ld a, [hli]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    inc b

.next:
    inc c
    ld a, c
    cp $19
    jr c, .loop
    ld a, b
    cp $06
    jr c, .skip
    cp $0b
    jr c, .skip2
    cp $10
    jr c, .skip3
    ld a, $03
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip:
    xor a
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip2:
    ld a, $01
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip3:
    ld a, $02
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

; Appraisal, sub-step 3: rates the egg's maximum level: below 41 is 0, below 61 is 1, below 81 is 2,
; otherwise 3. (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_3::
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, MON_MAX_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp $29
    jr c, .skip
    cp $3d
    jr c, .skip2
    cp $51
    jr c, .skip3
    ld a, $03
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip:
    xor a
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip2:
    ld a, $01
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

.skip3:
    ld a, $02
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

; Appraisal, sub-step 4: names the egg's strongest personality trait: the largest of its personality
; bytes (MON_PERSONALITY onward). (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_4::
    call GetListEntriesCell4AddressWithSRAM
    ld b, $00
    push hl
    push bc
    ld a, [hl]
    ld c, MON_PERSONALITY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld e, a
    pop bc
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, MON_PERSONALITY + 3
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp e
    jr c, .restore
    jr nz, .read_temp0
    jr .restore

.read_temp0:
    pop bc
    pop de
    ldh a, [hTemp0]
    ld e, a
    ld b, $01
    push de
    push bc

.restore:
    pop bc
    pop de
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, MON_PERSONALITY + 1
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp e
    jr c, .restore2
    jr nz, .read_temp02
    jr .restore2

.read_temp02:
    pop bc
    pop de
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld b, $02
    pop hl
    jr .skip

.restore2:
    pop bc
    pop de
    pop hl

.skip:
    ld a, b
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

; Appraisal, sub-step 5: the egg's sex (MON_SEX bit 0). (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_5::
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_SetTwoChoiceCursor

; Appraisal, sub-step 6: pays the 20-gold fee, sets the egg's MON_EGG byte to 2 (appraised, as read
; here) and moves to the closing step. (C1, E-0357)
EggServiceMenu_ChooseAndPay_CheckAndPay_SubtractArg1AmountFromGold::
    ld a, $14
    ld [wArg1], a
    xor a
    ld [wArg2], a
    ld [wArg3], a
    farcall SubtractArg1AmountFromGold
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
    ld a, $02
    ld [hl], a
    xor a
    ld [rRAMG2], a
    xor a
    ld [wScreenSubStep], a
    ld a, $10
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; enables SRAM (bank 0), far-calls SetArg5ToListEntriesCell4 and returns HL = wArg5 (high) / wArg6
; (low) (E-0119)
GetListEntriesCell4AddressWithSRAM::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; wScreenSubStep += 1, wScriptCommandType = 0, wScriptStartRequest = $80 (E-0119)
EndScriptCommandAndIncScreenSubStep::
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Egg service, state 13: runs the monster details screen (SwapMonstersMenu) until it finishes (step
; $0A), then skips a state. (C1, E-0357)
EggServiceMenu_SwapMonstersMenu::
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

; by wScreenStep: decompresses graphics, draws the record list page (species names, marks) and a
; 24-bit number (Number24ToPackedBCD) (E-0293)
EggServiceMenu_DrawListAndPrice::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_DrawListAndPrice_DecompressToVRAM
    dw EggServiceMenu_DrawListAndPrice_CopyGlyphTileListFromBank1F
    dw EggServiceMenu_DrawListAndPrice_FillTilesBxC
    dw EggServiceMenu_DrawListAndPrice_DrawBoxWithPageIndicator
    dw EggServiceMenu_DrawListAndPrice_DrawRecordListPageSpeciesNames
    dw EggServiceMenu_DrawListAndPrice_DrawRecordListPageMarks
    dw EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D
    dw EggServiceMenu_DrawListAndPrice_Number24ToPackedBCD
    dw EggServiceMenu_DrawListAndPrice_LoadPlayerAndFollowerSpriteGraphics

; Egg list screen, step 0: decompresses map $0A's tiles and loads its palettes. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_DecompressToVRAM::
    ld hl, vTiles2
    ld de, Map0ATileset
    ld b, $49
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, EggServiceMenu_DrawListAndPrice_BGPaletteBufferData
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Egg list screen, step 1: copies the glyph tiles and draws the frame pair. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_CopyGlyphTileListFromBank1F::
    ld hl, EggServiceMenu_DrawListAndPrice_TileCopyDestList
    ld de, EggServiceMenu_DrawListAndPrice_TileCopySrcList
    call CopyGlyphTileListFromBank1F
    call DrawPairAndStep
    ret

; Egg list screen, step 2: clears the name and number tiles and sets the text window. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_FillTilesBxC::
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

; Egg list screen, step 3: draws the list box with its page indicator. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_DrawBoxWithPageIndicator::
    call DrawBoxWithPageIndicator

; Egg list screen, step 4: draws the species names of the page. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_DrawRecordListPageSpeciesNames::
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Egg list screen, step 5: draws the page's marks. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_DrawRecordListPageMarks::
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

; Egg list screen, step 6: marks the chosen entry and draws the price box frame. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D::
    ld a, [wListCursor]
    ld b, $bc
    ld hl, EggServiceMenu_ChooseAndPay_UpdatePagedListCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld de, EggServiceMenu_DrawListAndPrice_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Egg list screen, step 7: shows the price (for a blessing the computed amount as digits without
; leading zeros in the text buffer, message 8; for an appraisal message 3). (C1, E-0357)
EggServiceMenu_DrawListAndPrice_Number24ToPackedBCD::
    ld a, [wSharedMenuWork]
    and a
    jr z, .set_string_index_to_03
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld b, $04
    ld hl, wArg4

.loop:
    ld a, [hl]
    cp $e3
    jr nz, .skip
    dec b
    inc hl
    ld a, b
    and a
    jr nz, .loop

.skip:
    ld de, wTextBuf0

.skip2:
    ld a, b
    and a
    jr z, .skip3
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr .skip2

.skip3:
    ld a, $f0
    ld [de], a
    ld a, $08
    jr .set_string_index

.set_string_index_to_03:
    ld a, $03

.set_string_index:
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    farcall ShowString_BankF2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Egg list screen, step 8: reloads the player's sprites, redraws the screen and returns to the saved
; state and step. (C1, E-0357)
EggServiceMenu_DrawListAndPrice_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0D
    farcall RestoreSpriteStateFromSavedFieldDrawFlags
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

; The blessing price of the chosen egg: 20 * its plus value + 20. (C1, E-0357)
EggServiceMenu_SetArg5ToListEntriesCell4::
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
    ldh a, [hTemp0]
    ld c, $14
    call Multiply8
    ld a, $14
    add_a_to_hl
    ret

; up/down moves wChoiceCursor between two entries; A sets wArg5 = $FF (with sound $69 and the arrow
; tile), B sets $FE; otherwise blinks the cursor and wArg5 = 0 (E-0127)
HandleTwoChoiceCursorInput_0D::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_bank0_d
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_bank0_d2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_arg5_to_FE
    call BlinkCursorBlinkAE_Bank0D
    xor a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c3_bank0_d:
    call DrawBlankTileC3_Bank0D
    ld a, [wChoiceCursor]
    and a
    jr nz, .set_choice_cursor
    ld a, $01
    jr .set_choice_cursor2

.set_choice_cursor:
    dec a

.set_choice_cursor2:
    ld [wChoiceCursor], a
    ld a, $69
    call QueueSoundEffect
    call DrawCursorTileBB_Bank0D
    xor a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c3_bank0_d2:
    call DrawBlankTileC3_Bank0D
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
    call DrawArrowTileBCAtChoiceCursorEntry
    ld a, $ff
    ld [wArg5], a
    ret

.set_arg5_to_FE:
    ld a, $fe
    ld [wArg5], a
    ret

; once the joypad repeat timer reaches $14, cycles wCursorBlinkAE through 0-$17 and draws the cursor
; tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
BlinkCursorBlinkAE_Bank0D::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, DrawCursorTileBB_Bank0D
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp $10
    jr c, DrawCursorTileBB_Bank0D
    cp $18
    jr c, DrawBlankTileC3_Bank0D
    xor a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
DrawCursorTileBB_Bank0D::
    ld b, $bb
    jr DrawArrowTileBCAtChoiceCursorEntry_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_Bank0D::
    ld b, $c3
    jr DrawArrowTileBCAtChoiceCursorEntry_ReadChoiceCursor

; B = $BC, then writes B at the scroll position +
; DrawArrowTileBCAtChoiceCursorEntry_Data[wChoiceCursor] (the shared tile-at-entry draw) (E-0124)
DrawArrowTileBCAtChoiceCursorEntry::
    ld b, $bc

; Writes tile B at the choice cursor's position (DrawArrowTileBCAtChoiceCursorEntry_Data by
; wChoiceCursor). (C1, E-0357)
DrawArrowTileBCAtChoiceCursorEntry_ReadChoiceCursor::
    ld a, [wChoiceCursor]
    add a
    ld hl, DrawArrowTileBCAtChoiceCursorEntry_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by DrawArrowTileBCAtChoiceCursorEntry (4 bytes) (E-0347)
DrawArrowTileBCAtChoiceCursorEntry_Data::
    db $2d, $01, $6d, $01

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0353)
CopyRectTo20ByteRows_Bank0D::
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
; kept. wTextCursorLo/wTextCursorHi = HL + $1C1, replaced by $99C1 when that is $9B61 (E-0062)
DrawScreenBufferRect_Bank0D::
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
    ld a, [wTextCursorLo]
    cp $61
    jr nz, .restore
    ld a, [wTextCursorHi]
    cp $9b
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank0D::
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank0D::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank0D
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks) (E-0353)
CopyLow3BitsToWRAMBank2_Bank0D::
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0353)
StoreBAtWordTableEntry_Bank0D::
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

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll_Bank0D + DE, two entries apart
; (WaitForVRAMAccess, interrupts off) (E-0120)
DrawC5BEC6AtScrollOffsetDE_Bank0D::
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
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
StoreC5BEC6AtHLStride2_Bank0D::
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

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with
; CGB attributes (E-0127)
CopyScreenBufferRectWithAttrs_0D::
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
    call CopyBytesDEToHL_Bank0D
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
    call CopyLow3BitsToWRAMBank2_Bank0D
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
    jr nz, CopyScreenBufferRectWithAttrs_0D
    ret

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL
; (StoreBAtWordTableEntry_Bank0D) (E-0122)
EraseCEntriesOfWordTable_Bank0D::
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $c3
    push hl
    call StoreBAtWordTableEntry_Bank0D
    pop hl
    pop bc
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; for each entry from wGlyphListStart of the destination list at HL and the source list at DE copies
; a 16-byte tile from bank $1F, until $FF; then clears wGlyphListPos/5 (E-0125)
CopyGlyphTileListFromBank1F::
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
    jr CopyGlyphTileListFromBank1F

.restore:
    pop de
    pop hl
    xor a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
DrawPairAndStep_TileCopyDestList::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2a0, vTiles1 + $2b0 ; entry 0
    dw vTiles1 + $2c0, vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $2f0, vTiles1 + $6e0, vTiles1 + $6f0, rIE

; record: bank-$1F tile sources
DrawPairAndStep_TileCopySrcList::
    dw $40f0, $43a0, $4250, $4300, $4390, $4380, $4290, $40c0 ; entry 0
    dw $4370, $43c0, $42d0, $4910, $4910, $4910, $ffff

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 3 tiles, one row per line
EggServiceMenu_DrawPrice_Number24ToPackedBCD_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; record: 11 x 7 tiles, one row per line
EggServiceMenu_DrawPrice_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a4, $a5, $a6, $a7, $a8, $a6, $a9, $aa, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ab, $a7, $aa, $ac, $ac, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $a4, $ad, $ae, $a9, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 13 x 9 tiles, one row per line
DrawBoxWithPageIndicator_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d9, $da, $db, $dc, $dd, $de, $f9, $fa, $fb, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c0, $c1, $c2, $c7, $c8, $c9, $ca, $cb, $fc, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

EggServiceMenu_ChooseAndPay_UpdatePagedListCursor_Data::
    db $d0, $c3, $f8, $c3, $20, $c4, $48, $c4

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
EggServiceMenu_DrawListAndPrice_TileCopyDestList::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; record: bank-$1F tile sources
EggServiceMenu_DrawListAndPrice_TileCopySrcList::
    dw $4130, $4320, $42a0, $4330, $4190, $4150, $ffff ; entry 0

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
EggServiceMenu_DrawListAndPrice_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $70, $71, $72, $73, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $74, $75, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; implements script command type F1 (SCRIPT_RENAME_CLOSE): ends the renaming session (runs
; CloseBreedMenu's code); reached through ScriptCommandF1 in bank $10 (E-0038, E-0244)
CloseRenameMenu::
    ld a, [wScreenList]
    jumptable
    dw CloseRenameMenu_ToCloseBreedMenu
    dw CloseRenameMenu_LoadRecordListNameTiles
    dw CloseRenameMenu_ToCloseBreedMenu
    dw CloseRenameMenu_ToCloseBreedMenu

; Closing the renaming, step 0: runs the breeding close (CloseBreedMenu). (C1, E-0357)
CloseRenameMenu_ToCloseBreedMenu::
    farcall CloseBreedMenu
    ret

; Closing the renaming, step 1: reloads the name tiles and three frame tiles, clears the list state
; and lets the script continue. (C1, E-0357)
CloseRenameMenu_LoadRecordListNameTiles::
    call LoadRecordListNameTiles
    ld de, Tiles2Plus710Tiles_3
    ld hl, vTiles1 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_3
    ld hl, vTiles1 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_3
    ld hl, vTiles1 + $720
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld a, [wScreenList]
    inc a
    ld [wScreenList], a
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

; implements script command type F0 (SCRIPT_RENAME): the Christener's renaming: 'Pick the monster to
; rename.' (runs EggServiceMenu's first state, so mode 6); reached through ScriptCommandF0 in bank
; $10 (E-0038, E-0244) (C2 from E-0325: the Christener runs it and its name entry changes MON_NAME)
RenameMenu::
    ld a, [wScreenState]
    jumptable
    dw RenameMenu_ToEggServiceMenu
    dw RenameMenu_DrawFrame
    dw RenameMenu_UpdateTwoChoiceCursor_Bank1D
    dw RenameMenu_DrawNameList
    dw RenameMenu_ToRenameMenu_WriteTwoChoiceCursorAndScreenStateEtc
    dw RenameMenu_LoadSRAMRecordByte
    dw RenameMenu_PickMonster

; Renaming, state 0: runs the egg service's first state (EggServiceMenu) to set up the screen. (C1,
; E-0357)
RenameMenu_ToEggServiceMenu::
    farcall EggServiceMenu
    ret

; by wScreenStep: loads four frame tiles and copies a rectangle (E-0293)
RenameMenu_DrawFrame::
    ld a, [wScreenStep]
    jumptable
    dw LoadFourFrameTilesAndStep
    dw RenameMenu_DrawFrame_CopyRectTo20ByteRows_Bank0D

; copies four tiles from bank $1F to vTiles1 + $700-$730, then wScreenStep += 1 (E-0124)
LoadFourFrameTilesAndStep::
    ld de, Tiles1Plus700Tiles
    ld hl, vTiles1 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles
    ld hl, vTiles1 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus230Tiles
    ld hl, vTiles1 + $720
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles1 + $730
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Renaming frame, step 1: draws the yes/no box and plays sound $6C. (C1, E-0357)
RenameMenu_DrawFrame_CopyRectTo20ByteRows_Bank0D::
    ld de, RenameMenu_DrawFrame_CopyRectTo20ByteRows_Bank0D_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Renaming, state 2: the yes/no answer: yes moves on to choosing the monster; no ends. (C1, E-0357)
RenameMenu_UpdateTwoChoiceCursor_Bank1D::
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
    cp $01
    jr z, .loop
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: a rectangle, a cleared string window and the record list name tiles (E-0293)
RenameMenu_DrawNameList::
    ld a, [wScreenStep]
    jumptable
    dw RenameMenu_DrawNameList_CopyScreenBufferRectWithAttrs_0D
    dw ClearStringWindowAt1500AndIncScreenStep
    dw RenameMenu_DrawNameList_LoadRecordListNameTiles

; Renaming name list, step 0: draws the party list frame. (C1, E-0357)
RenameMenu_DrawNameList_CopyScreenBufferRectWithAttrs_0D::
    ld de, RenameMenu_DrawNameList_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $09
    call CopyRectTo20ByteRows_Bank0D
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; sets the string window to tile destination vTiles1 + $500 and size word $0F01, then
; FillTilesFromRequest (clears it); then wScreenStep += 1 (E-0117)
ClearStringWindowAt1500AndIncScreenStep::
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0f01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Renaming name list, step 2: loads the name tiles, draws the list and moves on. (C1, E-0357)
RenameMenu_DrawNameList_LoadRecordListNameTiles::
    call LoadRecordListNameTiles
    ld de, RenameMenu_DrawNameList_LoadRecordListNameTiles_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $09
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Renaming, state 4: the party cursor (RenameMenu_WriteTwoChoiceCursorAndScreenStateEtc). (C1,
; E-0357)
RenameMenu_ToRenameMenu_WriteTwoChoiceCursorAndScreenStateEtc::
    call RenameMenu_WriteTwoChoiceCursorAndScreenStateEtc
    ret

; Renaming, state 5: runs the name entry for the chosen party member (mode 3, with its sex, family
; and species); when it finishes moves on. (C1, E-0357)
RenameMenu_LoadSRAMRecordByte::
    ld a, [wGridCursorX]
    ld hl, wPartyList
    add_a_to_hl
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
    ld a, $03
    ld [wArg1], a
    ld [rRAMG2], a
    farcall RunNameEntryStateWhenNotFading
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: frame tiles, the record and 'Pick the monster to rename.' (E-0293)
RenameMenu_PickMonster::
    ld a, [wScreenStep]
    jumptable
    dw RenameMenu_PickMonster_DecompressToVRAM
    dw RenameMenu_PickMonster_LoadFourFrameTilesAndStep
    dw RenameMenu_PickMonster_SRAMRecordAddress
    dw RenameMenu_PickMonster_ShowPickTheMonsterTo
    dw RenameMenu_PickMonster_LoadPlayerAndFollowerSpriteGraphics

; Choosing the monster to rename, step 0: decompresses map $13's tiles and palettes. (C1, E-0357)
RenameMenu_PickMonster_DecompressToVRAM::
    ld hl, vTiles2
    ld de, Map13Tileset
    ld b, $49
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, RenameMenu_PickMonster_DecompressToVRAM_BGPaletteBufferData
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the monster, step 1: loads four frame tiles and clears the name tiles. (C1, E-0357)
RenameMenu_PickMonster_LoadFourFrameTilesAndStep::
    call LoadFourFrameTilesAndStep
    call ClearStringWindowAt1500AndIncScreenStep
    ld a, $02
    ld [wScreenStep], a
    ret

; Choosing the monster, step 2: writes the name just entered (wNameGlyphBuf, up to 10 glyphs) into
; the chosen member's record and reloads the name tiles. (C1, E-0357)
RenameMenu_PickMonster_SRAMRecordAddress::
    ld a, [wGridCursorX]
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld de, wNameGlyphBuf
    ld c, $00

.loop:
    ld a, [de]
    cp $f0
    jr z, .skip
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop
    jr .call_load_record_list_name_tiles

.skip:
    ld a, $f0
    ld [hl], a

.call_load_record_list_name_tiles:
    xor a
    ld [rRAMG2], a
    call LoadRecordListNameTiles
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the monster, step 3: shows 'Pick the monster to rename.' (message $23 of bank $F2). (C1,
; E-0357)
RenameMenu_PickMonster_ShowPickTheMonsterTo::
    xor a
    ld [wStringCategory], a
    ld a, $23
    ld [wStringIndex], a ; '*: Pick the monster to rename.'
    farcall ShowString_BankF2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the monster, step 4: reloads the sprites, redraws the screen and goes to the party cursor
; (state 4). (C1, E-0357)
RenameMenu_PickMonster_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0D
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld [wScreenStep], a
    ld a, $04
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

; The renaming party cursor: Up/Down move over the party (wrapping), A picks the member, B cancels;
; the cursor blinks. (C1, E-0357)
RenameMenu_WriteTwoChoiceCursorAndScreenStateEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_rename_menu_read_grid_cursor_x_2
    bit 7, a
    jr nz, .call_rename_menu_read_grid_cursor_x_22
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_01
    call RenameMenu_WriteGridCursorY
    ret

.call_rename_menu_read_grid_cursor_x_2:
    call RenameMenu_ReadGridCursorX_2
    ld a, [wPartyCount]
    cp $02
    jr c, .check_party_count
    ld a, [wGridCursorX]
    and a
    jr nz, .set_grid_cursor_x

.check_party_count:
    ld a, [wPartyCount]
    dec a
    ld [wGridCursorX], a
    call RenameMenu_WriteGridCursorY
    ret

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call RenameMenu_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_rename_menu_read_grid_cursor_x_22:
    call RenameMenu_ReadGridCursorX_2
    ld a, [wPartyCount]
    dec a
    ld b, a
    ld a, [wGridCursorX]
    cp b
    jr c, .skip
    xor a
    ld [wGridCursorX], a
    call RenameMenu_WriteGridCursorY
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call RenameMenu_BGMapAddressAtScroll_Bank0D
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld [wScreenState], a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Blinks the renaming cursor: 16 frames shown, 8 hidden. (C1, E-0357)
RenameMenu_WriteGridCursorY::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, RenameMenu_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp $10
    jr c, RenameMenu_ReadGridCursorX
    cp $18
    jr c, RenameMenu_ReadGridCursorX_2
    xor a
    ld [wGridCursorY], a

; Draws the renaming cursor (tile $BB). (C1, E-0357)
RenameMenu_ReadGridCursorX::
    ld b, $bb
    jr RenameMenu_BGMapAddressAtScroll_Bank0D_ReadGridCursorX

; Hides the renaming cursor (tile $C3). (C1, E-0357)
RenameMenu_ReadGridCursorX_2::
    ld b, $c3
    jr RenameMenu_BGMapAddressAtScroll_Bank0D_ReadGridCursorX

; Marks the chosen party member on the renaming list (tile $BC). (C1, E-0357)
RenameMenu_BGMapAddressAtScroll_Bank0D::
    ld b, $bc

; Writes tile B at the renaming cursor position (RenameMenu_BGMapAddressAtScroll_Bank0D_Data by
; wGridCursorX). (C1, E-0357)
RenameMenu_BGMapAddressAtScroll_Bank0D_ReadGridCursorX::
    ld a, [wGridCursorX]
    sla a
    ld hl, RenameMenu_BGMapAddressAtScroll_Bank0D_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by RenameMenu (6 bytes) (E-0347)
RenameMenu_BGMapAddressAtScroll_Bank0D_Data::
    db $61, $00, $a1, $00, $e1, $00

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
RenameMenu_DrawFrame_CopyRectTo20ByteRows_Bank0D_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a5, $f3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4
    db $a1, $c3, $c9, $c3, $f1, $c3

; record: 8 x 9 tiles, one row per line
RenameMenu_DrawNameList_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $f0, $f1, $f2, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

RenameMenu_DrawNameList_LoadRecordListNameTiles_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $f0, $f1, $f2, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; implements script command type F2 (SCRIPT_KEY_APPRAISAL): Magic Key appraisal: 'Which Magic Key
; should I appraise?', 'Appraisal will cost 0G. OK?' (mode 7, bank $0D strings); reached through
; ScriptCommandF2 in bank $10 (E-0038, E-0244) (C2 from E-0334: with a generated key it lists the
; key, charges 140G and names it ('I got it! This is the WhiteMtn!'); with no key
; KeyAppraisalMenu_HasAnyKey ends it at once)
KeyAppraisalMenu::
    ld a, [wScreenState]
    jumptable
    dw KeyAppraisalMenu_CopyBytesDEToHL_Bank0D
    dw KeyAppraisalMenu_DrawGoldBox
    dw KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D
    dw KeyAppraisalMenu_ChooseKey

; Key appraisal, state 0: clears the state, copies the screen to the window buffer, sets message
; mode 7, hides the field sprites and loads the frame and choice tiles. (C1, E-0357)
KeyAppraisalMenu_CopyBytesDEToHL_Bank0D::
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
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_07
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

.set_message_mode_to_07:
    ld a, $07
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    ld de, Tiles1Plus4A0Tiles
    ld hl, vTiles1 + $4a0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: the gold box and a rectangle (E-0293)
KeyAppraisalMenu_DrawGoldBox::
    ld a, [wScreenStep]
    jumptable
    dw DrawGoldBoxAndStep
    dw KeyAppraisalMenu_DrawGoldBox_CopyRectTo20ByteRows_Bank0D

; copies box EggServiceMenu_DrawPrice_Number24ToPackedBCD_TileRect to wWindowTileBuffer + $70 and
; writes the gold as five digit tiles at wWindowTileBuffer + $86, then wScreenStep += 1 (E-0124)
DrawGoldBoxAndStep::
    ld de, EggServiceMenu_DrawPrice_Number24ToPackedBCD_TileRect
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
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

; Key appraisal gold box, step 1: draws the yes/no box and plays sound $6C. (C1, E-0357)
KeyAppraisalMenu_DrawGoldBox_CopyRectTo20ByteRows_Bank0D::
    ld de, KeyAppraisalMenu_DrawGoldBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Key appraisal, state 2: the yes/no answer: yes with at least one key moves on to choosing a key;
; yes with none, or no, ends (with the matching message). (C1, E-0357)
KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D::
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    call KeyAppraisalMenu_HasAnyKey
    cp $ff
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
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
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; A = 0 when one of the 32 key entries is not $FF, else $FF (E-0305)
KeyAppraisalMenu_HasAnyKey::
    ld c, $00

.loop:
    ld a, c
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
    cp $ff
    jr nz, .return_0
    inc c
    ld a, c
    cp $20
    jr c, .loop
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; KeyAppraisalMenu screen state 3, by wScreenStep: the paged key list
; (BuildKeyListIndexListEntries), a two-choice confirmation and saving (E-0288)
KeyAppraisalMenu_ChooseKey::
    ld a, [wScreenStep]
    jumptable
    dw KeyAppraisalMenu_ChooseKey_BuildKeyListIndexListEntries
    dw KeyAppraisalMenu_ChooseKey_FillTilesFromRequest
    dw KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor
    dw KeyAppraisalMenu_ChooseKey_DrawKeyListPageNames
    dw KeyAppraisalMenu_ChooseKey_BGMapAddressAtScroll_Bank0D
    dw KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor
    dw KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D
    dw KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D
    dw KeyAppraisalMenu_ChooseKey_EraseCEntriesOfWordTable_Bank0D
    dw KeyAppraisalMenu_ToCopyRectToWindowTileBufferRow5AndDrawAndStep
    dw KeyAppraisalMenu_ChooseKey_ShowSaveFileInfoWindow
    dw KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep
    dw KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D
    dw KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D_WriteRAMG2AndRAMB
    dw KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_2
    dw KeyAppraisalMenu_ChooseKey_BlankTwoTilePairsAndDraw
    dw KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics_CopyScreenBufferRectWithAttrs_0D
    dw KeyAppraisalMenu_ChooseKey_CountKeys_SetTwoChoiceCursor
    dw KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics

; Choosing a key, step 18: reloads the player's sprites and ends with the refusal message. (C1,
; E-0357)
KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a key, step 0: draws the key list frame and builds the list of keys owned
; (BuildKeyListIndexListEntries). (C1, E-0357)
KeyAppraisalMenu_ChooseKey_BuildKeyListIndexListEntries::
    ld de, KeyAppraisalMenu_ChooseKey_TileRect
    ld hl, wWindowTileBuffer + $b8
    lb bc, $10, $09
    call CopyRectTo20ByteRows_Bank0D
    call BuildKeyListIndexListEntries
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 1: clears the name and message tiles. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_FillTilesFromRequest::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0601
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $6e0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 2: draws the list box, clamps the page and cursor, draws the page indicator
; when there are several pages and the cursor. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor::
    ld de, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_TileRect
    ld hl, wWindowTileBuffer + $ce
    lb bc, $0d, $07
    call CopyRectTo20ByteRows_Bank0D
    xor a
    ld [wArg5], a
    call ClampKeyListPageCursor
    ld a, [wListPages]
    cp $02
    jr c, .read_list_cursor
    ld de, $018e
    call DrawC5BEC6AtScrollOffsetDE_Bank0D
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
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
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 3: draws the names and marks of the keys on the page. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_DrawKeyListPageNames::
    xor a
    ld [wArg5], a
    call DrawKeyListPageNames
    xor a
    ld [wArg5], a
    call DrawKeyListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 4: draws the screen and hides the cursor (it blinks in the next step). (C1,
; E-0357)
KeyAppraisalMenu_ChooseKey_BGMapAddressAtScroll_Bank0D::
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wListCursor]
    ld b, $c3
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 5: the paged key cursor: Select copies a key list back
; (KeyAppraisalMenu_ChooseKey_CopyWorkBuf1ToKeyList); page changes redraw; A picks the key and asks
; to confirm the price; B cancels. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor::
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, .call_key_appraisal_menu_choose_key_copy_work
    ld a, $03
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fe
    jr z, .set_two_choice_cursor_to_02
    cp $ff
    jr z, .call_set_arg5_to_list_entries_cell4
    ret

.call_key_appraisal_menu_choose_key_copy_work:
    farcall KeyAppraisalMenu_ChooseKey_CopyWorkBuf1ToKeyList
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_set_arg5_to_list_entries_cell4:
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
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
    jr z, .read_list_cursor
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
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld de, wTextBuf0
    ld a, $01
    call KeyAppraisalMenu_ChooseKey_WriteDigits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
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

; Choosing a key, step 7: the price confirmation: yes checks the gold against the price (10 * (key
; level + 1)) and, with enough, skips to the result window; without enough gold it ends with the
; refusal; no redraws the list. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D::
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
    call KeyAppraisalMenu_ChooseKey_StoreC5BEC6AtHLStride2_Bank0D
    ld a, $02
    ld [wTwoChoiceCursor], a
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    xor a
    call KeyAppraisalMenu_ChooseKey_WriteDigits
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp $ff
    jr nz, .call_key_appraisal_menu_choose_key_store_c5
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_key_appraisal_menu_choose_key_store_c5:
    call KeyAppraisalMenu_ChooseKey_StoreC5BEC6AtHLStride2_Bank0D
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
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

; Redraws the key list box with its page indicator. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_StoreC5BEC6AtHLStride2_Bank0D::
    ld de, KeyAppraisalMenu_ChooseKey_StoreC5BEC6AtHLStride2_Bank0D_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wListPages]
    cp $02
    jr c, .call_bg_map_address_at_scroll_bank0_d
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.call_bg_map_address_at_scroll_bank0_d:
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ret

; Choosing a key, step 9: draws the result window (CopyRectToWindowTileBufferRow5AndDraw). (C1,
; E-0357)
KeyAppraisalMenu_ToCopyRectToWindowTileBufferRow5AndDrawAndStep::
    farcall CopyRectToWindowTileBufferRow5AndDraw
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 10: shows the save details window (ShowSaveFileInfoWindow). (C1, E-0357)
KeyAppraisalMenu_ChooseKey_ShowSaveFileInfoWindow::
    farcall ShowSaveFileInfoWindow
    xor a
    ld [wStringCategory], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 11: in link mode draws the bottom box; then shows message $0B and, after it,
; moves on. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep::
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ld a, [wScreenSubStep]
    cp $02
    jr z, .set_string_index_to_0B
    cp $03
    jr z, .check_text_flags
    farcall DrawBottomBoxForLinkAndSetScreenSubStep
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

.set_string_index_to_0B:
    ld a, $0b
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0D
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

; Choosing a key, step 6: draws the yes/no box (sound $6C) and moves on. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D::
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ld de, KeyAppraisalMenu_DrawGoldBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 8: erases the cursor marks and returns to the cursor (step 5). (C1, E-0357)
KeyAppraisalMenu_ChooseKey_EraseCEntriesOfWordTable_Bank0D::
    ld c, $04
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call EraseCEntriesOfWordTable_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $05
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a key, step 13: the save question: yes moves on to saving, no skips five steps. (C1,
; E-0357)
KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D_WriteRAMG2AndRAMB::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ret

.loop:
    call BlankTwoTilePairsAndDraw
    ld a, [wScreenStep]
    add $05
    ld [wScreenStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    xor a
    ld [wTwoChoiceCursor], a
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

; Choosing a key, step 14: on the first call clears a byte of the chosen key's 4-byte entry (marking
; it appraised, as read here) and pays the price (10 * (level + 1)); on later calls saves the game
; in stages (RunSaveGameSteps_2); when done sets wGreatLogEventFlag and moves on. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_2::
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ld a, [wScreenSubStep]
    and a
    jr z, .clear_save_step
    farcall RunSaveGameSteps_2
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $01
    ld [wGreatLogEventFlag], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_save_step:
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
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
    xor a
    ld [hl], a
    xor a
    call KeyAppraisalMenu_ChooseKey_WriteDigits
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a
    ld [wArg3], a
    farcall SubtractArg1AmountFromGold
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Choosing a key, step 15: blanks two tile pairs and puts the key's name in the text buffer for the
; result message. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_BlankTwoTilePairsAndDraw::
    call BlankTwoTilePairsAndDraw
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, wTextBuf0
    call WriteKeyNameToDE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a key, step 16: reloads the player's sprites, restores the screen and redraws the gold
; box. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics_CopyScreenBufferRectWithAttrs_0D::
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld c, $0d
    ld hl, $01cc
    ld de, $0000
    xor a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    call DrawGoldBoxAndStep
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a key, step 17: with keys left returns to choosing (state 3); otherwise ends. (C1,
; E-0357)
KeyAppraisalMenu_ChooseKey_CountKeys_SetTwoChoiceCursor::
    call KeyAppraisalMenu_ChooseKey_CountKeys
    cp $ff
    jr nz, .set_two_choice_cursor_to_01
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $03
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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

; writes $C3 to wWindowTileBuffer + $B0-wWindowTileBuffer + $B1 and wWindowTileBuffer +
; $C4-wWindowTileBuffer + $C5, then DrawScreenBufferRect_Bank0D (20 x 13 at the scroll origin)
; (E-0119)
BlankTwoTilePairsAndDraw::
    ld a, $c3
    ld hl, wWindowTileBuffer + $b0
    ld [hli], a
    ld [hl], a
    ld hl, wWindowTileBuffer + $c4
    ld [hli], a
    ld [hl], a
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ret

; counts the wKeyList entries that are not $FF, up to a $FE end (A = $FF at the end) (E-0305)
KeyAppraisalMenu_ChooseKey_CountKeys::
    ld hl, wKeyList
    ld c, $00
    ld b, $00

.loop:
    push hl
    ld a, [hl]
    cp $fe
    jr z, .done
    cp $ff
    jr z, .restore
    inc b

.restore:
    pop hl
    ld a, l
    add $04
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    ld a, c
    cp $20
    jr c, .loop
    xor a
    ret

.done:
    pop hl
    ld a, $ff
    ret

; wListPages = the number of 4-entry pages of wListCount keys; clamps the page wListPageIndex and
; the cursor wListCursor to the last page's size (wListLastRow) (E-0127)
ClampKeyListPageCursor::
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
    call EraseCursorForArg5Layout
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

; writes blank $C3 at the scroll position + the cursor offset for wListCursor from table
; EraseCursorForArg5Layout_Data1, 5D16 or 5D1E (by wArg5) (E-0125)
EraseCursorForArg5Layout::
    ld b, $c3
    ld a, [wArg5]
    and a
    jr z, .read_list_cursor
    cp $01
    jr z, .skip
    ld hl, EraseCursorForArg5Layout_Data3
    jr .read_list_cursor2

.skip:
    ld hl, EraseCursorForArg5Layout_Data2
    jr .read_list_cursor2

.read_list_cursor:
    ld hl, EraseCursorForArg5Layout_Data1

.read_list_cursor2:
    ld a, [wListCursor]
    sla a
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by EraseCursorForArg5Layout (8 bytes) (E-0347)
EraseCursorForArg5Layout_Data1::
    db $a6, $00, $c6, $00, $e6, $00, $06, $01

EraseCursorForArg5Layout_Data2::
    db $a4, $00, $c4, $00, $e4, $00, $04, $01

EraseCursorForArg5Layout_Data3::
    db $a2, $00, $c2, $00, $e2, $00, $02, $01

; blanks the four mark positions and draws marks for the keys on the current page of wListEntries
; (E-0130)
DrawKeyListPageMarks::
    ld a, [wArg5]
    and a
    jr nz, .skip
    ld de, DrawKeyListPageMarks_Data1
    jr .skip2

.skip:
    ld de, DrawKeyListPageMarks_Data2

.skip2:
    ld b, $04

.loop:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, $c3
    ld [hl], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld a, [hl]
    ld c, $00

.loop2:
    ld a, [wListLastRow]
    cp $03
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
    sla a
    sla a
    add c
    cp b
    jp nc, .return
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld de, wKeyList
    add hl, de
    ld e, l
    ld d, h
    ld a, [de]
    cp $fe
    jr z, .restore
    cp $ff
    jr z, .restore
    bit 6, a
    jr z, .check_arg5
    ld b, $ca
    jr .check_arg52

.check_arg5:
    ld b, $c3

.check_arg52:
    ld a, [wArg5]
    and a
    jr nz, .skip3
    ld de, DrawKeyListPageMarks_Data1
    jr .skip4

.skip3:
    ld de, DrawKeyListPageMarks_Data2
    ld a, b
    cp $c3
    jr z, .skip4
    ld b, $70

.skip4:
    ld a, c
    sla a
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
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr z, .return
    ld a, c
    cp $04
    jp c, .loop2

.return:
    ret

; data read by DrawKeyListPageMarks (8 bytes) (E-0347)
DrawKeyListPageMarks_Data1::
    db $cd, $c3, $f5, $c3, $1d, $c4, $45, $c4

DrawKeyListPageMarks_Data2::
    db $c9, $c3, $f1, $c3, $19, $c4, $41, $c4

; for the keys on the current page writes their names to wNameGlyphBuf and draws them; generated
; keys (kind $FE) are shown as "Magic Key" (E-0130)
DrawKeyListPageNames::
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp $03
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
    sla a
    sla a
    add c
    cp b
    jp nc, .return
    push hl
    push bc
    ld a, [hl]
    sla a
    sla a
    ld de, wKeyList
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $fe
    jr nz, .next
    ld hl, wNameGlyphBuf
    ld a, $16
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld a, $2a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $90
    ld [hli], a
    ld a, $14
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld a, $3c
    ld [hli], a
    ld a, $5b
    ld [hli], a
    ld a, $f0
    ld [hl], a
    jr .call_draw_name_glyph_buf_glyphs_overlaying8_d

.next:
    inc de
    inc de
    inc de
    ld a, [de]
    bit 7, a
    jr z, .call_write_key_name_to_de
    dec de
    dec de
    dec de
    ld a, [de]
    and $3f
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, BeginStringDisplay_Bank09_StringCategories
    ld a, $0c
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
    ld b, $09
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $f0
    ld [wNameGlyphBuf + $d], a
    jr .call_draw_name_glyph_buf_glyphs_overlaying8_d

.call_write_key_name_to_de:
    ld a, [hl]
    ld de, wNameGlyphBuf
    call WriteKeyNameToDE
    ld a, $5b
    ld [de], a
    inc de
    ld a, $f0
    ld [de], a

.call_draw_name_glyph_buf_glyphs_overlaying8_d:
    pop bc
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr z, .return
    ld a, c
    cp $04
    jp c, .loop

.return:
    ret

; draws the $F0-terminated text at wNameGlyphBuf glyph by glyph; marks $8D and $8E are ORed onto the
; previous tile instead of taking a new one (E-0125)
DrawNameGlyphBufGlyphsOverlaying8DAnd8E::
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
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_ReadArg5AndGlyphListStart
    call CopyFromBankWaitVRAM
    pop bc
    jr .check_glyph_list_start2

.check_glyph_list_start:
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_ReadArg5AndGlyphListStart
    call OrFromBankWaitVRAM
    pop bc

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

; Draws one glyph of wNameGlyphBuf: copies its font tile (GlyphFont + 16 * glyph) to the destination
; for position C from one of four tables (GlyphTileDestTable0-3, by wArg5). (C1, E-0357)
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_ReadArg5AndGlyphListStart::
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
    ld a, [wArg5]
    and a
    jr z, .skip3
    cp $01
    jr z, .skip2
    cp $02
    jr z, .skip
    ld de, GlyphTileDestTable3
    jr .skip4

.skip:
    ld de, GlyphTileDestTable2
    jr .skip4

.skip2:
    ld de, GlyphTileDestTable1
    jr .skip4

.skip3:
    ld de, GlyphTileDestTable0

.skip4:
    ld a, c
    sla a
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

; the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 *
; C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address)
; with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 0 (E-0235,
; C1)
; record: list of VRAM tile addresses
GlyphTileDestTable0::
    dw GlyphTileDests0_0 ; id 0
    dw GlyphTileDests0_1 ; id 1
    dw GlyphTileDests0_2 ; id 2
    dw GlyphTileDests0_3 ; id 3

; list 0 of GlyphTileDestTable0; 12 words (E-0235, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests0_0::
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580, vTiles1 + $590, vTiles1 + $5a0, vTiles1 + $5b0

; list 1 of GlyphTileDestTable0; 12 words (E-0235, C1)
GlyphTileDests0_1::
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790, vTiles1 + $7a0, vTiles1 + $7b0

; list 2 of GlyphTileDestTable0; 12 words (E-0235, C1)
GlyphTileDests0_2::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290 ; entry 0
    dw vTiles1 + $2a0, vTiles1 + $2b0, vTiles1 + $2c0, vTiles1 + $6e0, vTiles1 + $6f0, vTiles1 + $7c0

; list 3 of GlyphTileDestTable0; 12 words (E-0235, C1)
GlyphTileDests0_3::
    dw vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $2f0, vTiles1 + $7d0, vTiles1 + $7e0, vTiles1 + $7f0 ; entry 0
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750

; the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 *
; C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address)
; with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 1 (E-0235,
; C1)
; record: list of VRAM tile addresses
GlyphTileDestTable1::
    dw GlyphTileDests1_0 ; id 0
    dw GlyphTileDests1_1 ; id 1
    dw GlyphTileDests1_2 ; id 2
    dw GlyphTileDests1_3 ; id 3

; list 0 of GlyphTileDestTable1; 9 words (E-0235, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests1_0::
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290 ; entry 0
    dw vTiles1 + $2a0, vTiles1 + $2b0, vTiles1 + $2c0

; list 1 of GlyphTileDestTable1; 9 words (E-0235, C1)
GlyphTileDests1_1::
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580

; list 2 of GlyphTileDestTable1; 9 words (E-0235, C1)
GlyphTileDests1_2::
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $780

; list 3 of GlyphTileDestTable1; 9 words (E-0235, C1)
GlyphTileDests1_3::
    dw vTiles1 + $590, vTiles1 + $5a0, vTiles1 + $5b0, vTiles1 + $5c0, vTiles1 + $5d0, vTiles1 + $5e0 ; entry 0
    dw vTiles1 + $790, vTiles1 + $7a0, vTiles1 + $7b0

; the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 *
; C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address)
; with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 2 (E-0235,
; C1)
; record: list of VRAM tile addresses
GlyphTileDestTable2::
    dw GlyphTileDests2_0 ; id 0
    dw GlyphTileDests2_1 ; id 1
    dw GlyphTileDests2_2 ; id 2
    dw GlyphTileDests2_3 ; id 3

; list 0 of GlyphTileDestTable2; 12 words (E-0235, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests2_0::
    dw vTiles2 + $100, vTiles2 + $110, vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150 ; entry 0
    dw vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190, vTiles2 + $1a0, vTiles2 + $1b0

; list 1 of GlyphTileDestTable2; 12 words (E-0235, C1)
GlyphTileDests2_1::
    dw vTiles2 + $200, vTiles2 + $210, vTiles2 + $220, vTiles2 + $230, vTiles2 + $240, vTiles2 + $250 ; entry 0
    dw vTiles2 + $260, vTiles2 + $270, vTiles2 + $280, vTiles2 + $290, vTiles2 + $2a0, vTiles2 + $2b0

; list 2 of GlyphTileDestTable2; 12 words (E-0235, C1)
GlyphTileDests2_2::
    dw vTiles2 + $300, vTiles2 + $310, vTiles2 + $320, vTiles2 + $330, vTiles2 + $340, vTiles2 + $350 ; entry 0
    dw vTiles2 + $360, vTiles2 + $370, vTiles2 + $380, vTiles2 + $390, vTiles2 + $3a0, vTiles2 + $3b0

; list 3 of GlyphTileDestTable2; 12 words (E-0235, C1)
GlyphTileDests2_3::
    dw vTiles2 + $400, vTiles2 + $410, vTiles2 + $420, vTiles2 + $430, vTiles2 + $440, vTiles2 + $450 ; entry 0
    dw vTiles2 + $460, vTiles2 + $470, vTiles2 + $480, vTiles2 + $490, vTiles2 + $4a0, vTiles2 + $4b0

; the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 *
; C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address)
; with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 3 or more
; (E-0235, C1)
; record: list of VRAM tile addresses
GlyphTileDestTable3::
    dw GlyphTileDests3_0 ; id 0

; list 0 of GlyphTileDestTable3; 12 words (E-0235, C1)
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests3_0::
    dw vTiles2 + $600, vTiles2 + $610, vTiles2 + $620, vTiles2 + $630, vTiles2 + $640, vTiles2 + $650 ; entry 0
    dw vTiles2 + $660, vTiles2 + $670, vTiles2 + $680, vTiles2 + $690, vTiles2 + $6a0, vTiles2 + $6b0

; clears wListEntries ($20 bytes), then lists the indexes of the used wKeyList entries there and
; stores their count in wListCount (E-0125)
BuildKeyListIndexListEntries::
    ld hl, wListEntries
    ld b, $20

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wListCount], a
    ld de, wKeyList
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop2:
    ld a, [de]
    cp $ff
    jr z, .skip
    inc c
    ld a, b
    ld [hli], a

.skip:
    ld a, $04
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp $20
    jr c, .loop2
    ld a, c
    ld [wListCount], a
    ret

; The appraisal price of the key under the cursor: 10 * (its level byte + 1). (C1, E-0357)
KeyAppraisalMenu_ChooseKey_ReadListPageIndexAndListCursor::
    ld hl, wListEntries
    ld a, [wListPageIndex]
    add a
    add a
    add_a_to_hl
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld hl, wKeyList
    add a
    add a
    add_a_to_hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld c, $0a
    call Multiply8
    ret

; With A = 0 returns the price in HL; otherwise also writes it as digits (without leading zeros) to
; DE, ending with $F0. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_WriteDigits::
    and a
    jr nz, .call_key_appraisal_menu_choose_key_read_list
    call KeyAppraisalMenu_ChooseKey_ReadListPageIndexAndListCursor
    ret

.call_key_appraisal_menu_choose_key_read_list:
    call KeyAppraisalMenu_ChooseKey_ReadListPageIndexAndListCursor
    push de
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    pop de
    ld hl, wArg1
    ld c, $07

.loop:
    ld a, [hl]
    cp $e3
    jr nz, .loop2
    inc hl
    dec c
    jr nz, .loop
    xor a
    ld [de], a
    inc de
    jr .done

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop2

.done:
    ld a, $f0
    ld [de], a
    ret

; Draws the save's completion mark during the key appraisal (sprite part $90 at ($88, $28)) when the
; saved game has the flag at sSavedPlayerName + $22B and the step is past $0A. (C1, E-0357)
KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB::
    ld a, $0a
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedPlayerName
    ld de, $022b
    add hl, de
    ld a, [hl]
    and a
    jr nz, .check_screen_step

.loop:
    xor a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $0b
    jr c, .loop
    farcall DrawSpritePart9000At88_28
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
KeyAppraisalMenu_DrawGoldBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $77, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 16 x 9 tiles, one row per line
KeyAppraisalMenu_ChooseKey_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 13 x 7 tiles, one row per line
KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_TileRect::
    db $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $d9, $da, $db ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $fa, $fb ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ee, $ef, $fc ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $ad, $ae, $af, $fd, $fe, $ff, $70, $71, $72, $73, $74, $75 ; id 6

KeyAppraisalMenu_ChooseKey_StoreC5BEC6AtHLStride2_Bank0D_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 0
    db $ab, $ac, $ee, $ef, $fc, $b7 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $71, $72, $73, $74, $75, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data::
    db $ce, $c3, $f6, $c3, $1e, $c4, $46, $c4

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_KeyAppraisal::
    script_command SCRIPT_KEY_APPRAISAL
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_WhichKeyShouldI, Script_Don, Script_OkayComeBackIf
Script_OkayComeBackIf::
    script_command SCRIPT_BREED_CLOSE
    script_message $8002 ; 'Okay. Come back if you find'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_Don::
    script_command SCRIPT_BREED_CLOSE
    script_message $8003 ; '*: Don't come if you have'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_WhichKeyShouldI::
    script_message $c004 ; 'Which key should I appraise?'
Script_KeyAppraisal_2::
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_AppraisalWillCostHero, Script_ThatKey, Script_ToOkayComeBackIf
Script_ToOkayComeBackIf::
    script_jump Script_OkayComeBackIf
Script_ThatKey::
    script_message $c009 ; '*: That key's been appraised already.'
    script_message $c008 ; '*: Which Magic Key should I'
    script_jump Script_KeyAppraisal_2
Script_AppraisalWillCostHero::
    script_message $c005 ; '*: Appraisal will cost 0G. OK?'
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_KeyAppraisal_3, Script_HahI, Script_WhichMagicKeyShould
Script_WhichMagicKeyShould::
    script_message $c008 ; '*: Which Magic Key should I'
    script_command SCRIPT_KEY_APPRAISAL
    script_jump Script_KeyAppraisal_2
Script_HahI::
    script_command SCRIPT_BREED_CLOSE
    script_message $8007 ; '*: Hah? I'm not appraising any'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_KeyAppraisal_3::
    script_command SCRIPT_KEY_APPRAISAL
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_Let, Script_ToOkayComeBackIf_2
Script_ToOkayComeBackIf_2::
    script_jump Script_OkayComeBackIf
Script_Let::
    script_command SCRIPT_KEY_APPRAISAL
    script_command SCRIPT_KEY_APPRAISAL
    script_message $c00f ; '*: Let's see the Magic Key,'
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_WhichMagicKeyShould_2, Script_YouHaveNoMore_3
Script_YouHaveNoMore_3::
    script_message $c00a ; '*: You have no more Magic'
    script_jump Script_OkayComeBackIf
Script_WhichMagicKeyShould_2::
    script_message $c008 ; '*: Which Magic Key should I'
    script_jump Script_KeyAppraisal_2

; implements script command type F3 (SCRIPT_MEDAL_PRIZES): the TinyMedal prize exchange: 'Which
; prize do you want?', 'I'll trade for 0 TinyMedals. OK?' (mode 7); reached through ScriptCommandF3
; in bank $10 (E-0038, E-0244)
MedalPrizeMenu::
    ld a, [wScreenState]
    jumptable
    dw MedalPrizeMenu_CopyBytesDEToHL_Bank0D
    dw MedalPrizeMenu_CountItem2C_2
    dw MedalPrizeMenu_WriteScreenStateAndTwoChoiceCursorEtc
    dw MedalPrizeMenu_DrawCountBox
    dw MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D
    dw MedalPrizeMenu_ChoosePrize

; Medal prizes, state 2: with fewer than 3 tiny medals ends with the refusal; otherwise writes the
; medal count as digits (leading zeros dropped) to the text buffer for the message. (C1, E-0357)
MedalPrizeMenu_WriteScreenStateAndTwoChoiceCursorEtc::
    ld a, [wTinyMedalsHi]
    and a
    jr nz, .read_tiny_medals_lo
    ld a, [wTinyMedalsLo]
    and a
    jr z, .set_two_choice_cursor_to_01
    cp $01
    jr z, .set_two_choice_cursor_to_01
    cp $02
    jr z, .set_two_choice_cursor_to_01
    jr .read_tiny_medals_lo

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_tiny_medals_lo:
    ld a, [wTinyMedalsLo]
    ld l, a
    ld a, [wTinyMedalsHi]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld hl, wTextBuf0
    ld de, wDigits
    ld a, [de]
    cp $e3
    jr z, .next
    ld [hli], a

.next:
    inc de
    ld a, [de]
    cp $e3
    jr z, .next2
    ld [hli], a

.next2:
    inc de
    ld a, [de]
    ld [hli], a
    ld a, $f0
    ld [hl], a
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

; Medal prizes, state 1: converts the medals carried as items ($2C) into the tiny medal count,
; capped at 999: items beyond the cap stay in the inventory, the rest are removed. (C1, E-0357)
MedalPrizeMenu_CountItem2C_2::
    call MedalPrizeMenu_CountItem2C
    push af
    ld a, [wTinyMedalsLo]
    ld l, a
    ld a, [wTinyMedalsHi]
    ld h, a
    pop af
    cp $ff
    jr nz, .skip
    jr .skip3

.skip:
    push af
    add_a_to_hl
    ld a, h
    cp $03
    jr c, .restore
    jr nz, .skip2
    ld a, l
    cp $e8
    jr c, .restore

.skip2:
    ld a, l
    sub $e7
    ld l, a
    ld a, h
    sbc $03
    ld h, a
    pop af
    ld b, a
    ld a, l
    sub b
    ld b, a
    and a
    jr z, .set_tiny_medals_hi_to_03
    ld hl, wInventory
    ld c, $00
    call MedalPrizeMenu_RemoveItem2C

.set_tiny_medals_hi_to_03:
    ld a, $03
    ld [wTinyMedalsHi], a
    ld a, $e7
    ld [wTinyMedalsLo], a

.skip3:
    ld a, $01
    jr .set_two_choice_cursor

.restore:
    pop af
    ld b, a
    ld a, l
    ld [wTinyMedalsLo], a
    ld a, h
    ld [wTinyMedalsHi], a
    ld hl, wInventory
    ld c, $00
    call MedalPrizeMenu_RemoveItem2C
    xor a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; clears B inventory slots that hold item $2C, then compacts the inventory (E-0305)
MedalPrizeMenu_RemoveItem2C::
    push hl
    push bc
    ld a, [hl]
    cp $2c
    jr nz, .restore
    xor a
    ld [hl], a
    pop bc
    pop hl
    push hl
    push bc
    dec b
    ld a, b
    and a
    jr nz, .restore
    pop hl
    pop bc
    jr .skip
    db $c9

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp $18
    jr c, MedalPrizeMenu_RemoveItem2C

.skip:
    ld hl, wInventory
    ld de, wInventory + $1
    ld b, $17

.loop:
    ld a, [hl]
    and a
    jr z, .loop2
    inc hl
    inc de
    dec b
    jr nz, .loop
    ret

.loop2:
    ld a, [de]
    and a
    jr nz, .skip2
    inc de
    dec b
    jr nz, .loop2
    ret

.skip2:
    ld a, [de]
    ld [hli], a
    xor a
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; Medal prizes, state 0: clears the state, copies the screen, sets message mode 7, hides the
; sprites; with medal items ($2C) in the inventory moves on to count them, otherwise skips. (C1,
; E-0357)
MedalPrizeMenu_CopyBytesDEToHL_Bank0D::
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
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_07
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

.set_message_mode_to_07:
    ld a, $07
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    call MedalPrizeMenu_CountItem2C
    cp $ff
    jr z, .set_two_choice_cursor_to_01
    xor a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: copies tiles and draws the count box (DrawTinyMedalCountBoxAndStep) (E-0293)
MedalPrizeMenu_DrawCountBox::
    ld a, [wScreenStep]
    jumptable
    dw MedalPrizeMenu_DrawCountBox_CopyFromBankWaitVRAM
    dw DrawTinyMedalCountBoxAndStep
    dw MedalPrizeMenu_DrawCountBox_CopyRectTo20ByteRows_Bank0D

; Medal count box, step 0: loads the box and digit tiles from bank $1F. (C1, E-0357)
MedalPrizeMenu_DrawCountBox_CopyFromBankWaitVRAM::
    ld de, Tiles2Plus240Tiles
    ld hl, vTiles1 + $2d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles
    ld hl, vTiles1 + $2e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2F0Tiles
    ld hl, vTiles1 + $2f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7C0Tiles
    ld hl, vTiles1 + $7c0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7D0Tiles
    ld hl, vTiles1 + $7d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles
    ld hl, vTiles2 + $760
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles2 + $770
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies box DrawTinyMedalCountBoxAndStep_TileRect to wWindowTileBuffer + $6D and writes the word
; wTinyMedalsLo as three digits (leading blanks) at wWindowTileBuffer + $88, then wScreenStep += 1
; (E-0124) (C2 from E-0331: it draws 'Medal: 80') (was DrawTinyMedalCountBoxAndStep)
DrawTinyMedalCountBoxAndStep::
    ld de, DrawTinyMedalCountBoxAndStep_TileRect
    ld hl, wWindowTileBuffer + $6d
    lb bc, $0b, $03
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wTinyMedalsLo]
    ld l, a
    ld a, [wTinyMedalsHi]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld hl, wWindowTileBuffer + $88
    ld de, wDigits
    ld c, $00

.loop:
    ld a, [de]
    add $e0
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $03
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Medal count box, step 2: draws the yes/no box (sound $6C) and moves on. (C1, E-0357)
MedalPrizeMenu_DrawCountBox_CopyRectTo20ByteRows_Bank0D::
    ld de, KeyAppraisalMenu_DrawGoldBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Medal prizes, state 4: the yes/no answer: yes closes the box and moves on to the prize list; no
; ends. (C1, E-0357)
MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D::
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
    cp $01
    jr z, .loop
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; MedalPrizeMenu screen state 5, by wScreenStep: a paged list with a cursor and a two-choice
; confirmation (E-0288)
MedalPrizeMenu_ChoosePrize::
    ld a, [wScreenStep]
    jumptable
    dw MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D
    dw MedalPrizeMenu_ChoosePrize_FillTilesFromRequest
    dw MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor
    dw MedalPrizeMenu_ChoosePrize_WriteArg5AndScreenStep
    dw MedalPrizeMenu_ChoosePrize_BGMapAddressAtScroll_Bank0D
    dw MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor
    dw MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor_2
    dw MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc
    dw MedalPrizeMenu_ChoosePrize_SetTwoChoiceCursor
    dw MedalPrizeMenu_ChoosePrize_UpdateTwoChoiceCursor_Bank1D
    dw MedalPrizeMenu_ChoosePrize_EraseCEntriesOfWordTable_Bank0D
    dw MedalPrizeMenu_WriteScreenStepAndScriptCommandTypeEtc
    dw MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4
    dw MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_2
    dw MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB

; Choosing a prize, step 0: draws the prize list frame and sets the list count. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D::
    ld de, MedalPrizeMenu_ChoosePrize_TileRect
    ld hl, wWindowTileBuffer + $b7
    lb bc, $11, $09
    call CopyRectTo20ByteRows_Bank0D
    call MedalPrizeMenu_ChoosePrize_WriteListCount
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a prize, step 1: clears the name and message tiles. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_FillTilesFromRequest::
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0f01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a prize, step 2: draws the list box for the page (the second page's box depends on
; whether the game was completed), the page indicator and the cursor. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor::
    ld a, [wListPageIndex]
    and a
    jr nz, .check_game_completed
    ld de, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data1
    jr .call_copy_rect_to20_byte_rows_bank0_d

.loop:
    ld de, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data2
    jr .call_copy_rect_to20_byte_rows_bank0_d

.check_game_completed:
    ld a, [wGameCompleted]
    and a
    jr nz, .loop
    ld de, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_TileRect

.call_copy_rect_to20_byte_rows_bank0_d:
    ld hl, wWindowTileBuffer + $cc
    lb bc, $0f, $07
    call CopyRectTo20ByteRows_Bank0D
    ld a, $01
    ld [wArg5], a
    call ClampKeyListPageCursor
    ld a, [wListPages]
    cp $02
    jr c, .read_list_cursor
    call MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bb
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data3
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a prize, step 3: draws the prize names and their prices for the page. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteArg5AndScreenStep::
    ld a, $01
    ld [wArg5], a
    call MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndListLastRowEtc
    call MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndGameCompletedEtc
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a prize, step 4: draws the screen and hides the cursor. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_BGMapAddressAtScroll_Bank0D::
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wListCursor]
    ld b, $c3
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data3
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a prize, step 5: shows the description of the prize under the cursor (string $22 +
; entry), or for entry 0 the following lines' text. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor::
    ld b, $bb
    call WriteTileBAtCursorListCursor
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp $01
    jr c, .set_two_choice_cursor
    ld a, $01

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    cp $01
    jr z, .skip
    add $22
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
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
    farcall ShowString_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.skip:
    ld a, [hl]
    add $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, BeginStringDisplay_Bank0D_StringCategories
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wTextBuf0
    ld c, $00

.skip2:
    ld a, [de]
    cp $f0
    jr z, .skip3
    ld [hli], a
    inc de
    jr .skip2

.skip3:
    ld a, $f0
    ld [hl], a
    ld a, $23
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
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
    farcall ShowString_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a prize, step 6: while the description shows, remembers a direction pressed (Up, Down,
; Right, Left as 1-4) so the cursor can move at once; A or B end the description. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor_2::
    ld b, $bb
    call WriteTileBAtCursorListCursor
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .skip
    bit 7, a
    jr nz, .skip2
    bit 4, a
    jr nz, .skip3
    bit 5, a
    jr nz, .set_shared_menu_work_to_04
    bit 1, a
    jr nz, .call_show_string_bank0_d
    bit 0, a
    jr nz, .call_show_string_bank0_d
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    jr .check_screen_step

.call_show_string_bank0_d:
    call ShowString_Bank0D

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld b, $bb
    call WriteTileBAtCursorListCursor
    ret

.skip:
    ld a, $01
    jr .set_shared_menu_work

.skip2:
    ld a, $02
    jr .set_shared_menu_work

.skip3:
    ld a, $03
    jr .set_shared_menu_work

.set_shared_menu_work_to_04:
    ld a, $04

.set_shared_menu_work:
    ld [wSharedMenuWork], a
    jr .check_screen_step

; Choosing a prize, step 7: replays the remembered direction into the paged list cursor
; (UpdatePagedListCursor) and acts on the result: page or row changes redraw, A asks to confirm, B
; ends. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc::
    ld a, [wSharedMenuWork]
    and a
    jr z, .set_menu_input_result_to_04
    cp $01
    jr z, .set_joypad_pressed_repeat_to_40
    cp $02
    jr z, .set_joypad_pressed_repeat_to_80
    cp $03
    jr z, .set_joypad_pressed_repeat_to_10
    cp $04
    jr z, .set_joypad_pressed_repeat_to_20

.set_joypad_pressed_repeat_to_20:
    ld a, $20
    ld [wJoypadPressedRepeat], a
    jr .set_menu_input_result_to_04

.set_joypad_pressed_repeat_to_10:
    ld a, $10
    ld [wJoypadPressedRepeat], a
    jr .set_menu_input_result_to_04

.set_joypad_pressed_repeat_to_80:
    ld a, $80
    ld [wJoypadPressedRepeat], a
    jr .set_menu_input_result_to_04

.set_joypad_pressed_repeat_to_40:
    ld a, $40
    ld [wJoypadPressedRepeat], a

.set_menu_input_result_to_04:
    ld a, $04
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .clear_shared_menu_work
    cp $fc
    jr z, .clear_shared_menu_work
    cp $fd
    jr z, .clear_shared_menu_work2
    cp $fe
    jr z, .set_two_choice_cursor_to_02
    cp $ff
    jr z, .clear_two_choice_cursor
    ret

.clear_shared_menu_work:
    xor a
    ld [wSharedMenuWork], a
    ld a, [wScreenStep]
    sub $06
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_shared_menu_work2:
    xor a
    ld [wSharedMenuWork], a
    ld a, [wScreenStep]
    sub $02
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
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
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data3
    call StoreBAtWordTableEntry_Bank0D
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld hl, wTextBuf0
    ld a, [wDigits + $1]
    cp $e3
    jr z, .read_digits
    ld [hli], a

.read_digits:
    ld a, [wDigits + $2]
    ld [hli], a
    ld a, $f0
    ld [hl], a
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

; Choosing a prize, step 8: draws the yes/no box (sound $6C) and moves on. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_SetTwoChoiceCursor::
    ld de, KeyAppraisalMenu_DrawGoldBox_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $6c
    call QueueSoundEffect
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a prize, step 9: the confirmation: yes checks the medals against the prize's price
; (MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data) and trades them;
; no redraws the list. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_UpdateTwoChoiceCursor_Bank1D::
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
    call MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_2
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
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add e
    ld e, a
    jr nc, .check_tiny_medals_hi
    inc d

.check_tiny_medals_hi:
    ld a, [de]
    ld b, a
    ld a, [wTinyMedalsHi]
    and a
    jr nz, .clear_two_choice_cursor
    ld a, [wTinyMedalsLo]
    cp b
    jr nc, .clear_two_choice_cursor
    ld a, $02
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

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $03
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Redraws the prize list box (by page and game completion), the prices and the page indicator. (C1,
; E-0357)
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_2::
    ld a, [wListPageIndex]
    and a
    jr nz, .check_game_completed
    ld de, MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Data1
    jr .call_copy_rect_to20_byte_rows_bank0_d

.loop:
    ld de, MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Data2
    jr .call_copy_rect_to20_byte_rows_bank0_d

.check_game_completed:
    ld a, [wGameCompleted]
    and a
    jr nz, .loop
    ld de, MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_2_TileRect

.call_copy_rect_to20_byte_rows_bank0_d:
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndGameCompletedEtc
    call MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ret

; Choosing a prize, step 10: erases the cursor marks and returns to the cursor (step 5). (C1,
; E-0357)
MedalPrizeMenu_ChoosePrize_EraseCEntriesOfWordTable_Bank0D::
    ld c, $04
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data3
    call EraseCEntriesOfWordTable_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, $05
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a prize, step 11: redraws the list box and steps back one step. (C1, E-0357)
MedalPrizeMenu_WriteScreenStepAndScriptCommandTypeEtc::
    call MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_2
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a prize, step 12: checks there is room for the prize: an item prize (entry 0) needs a
; free inventory slot, a monster prize a free SRAM record slot
; (MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB); without room it steps back with the matching
; refusal (1 or 3). (C1, E-0357)
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    and a
    jr z, MedalPrizeMenu_CallMedalPrizeMenu_ChoosePrize_InventoryHasF
    call MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
    cp $ff
    jr nz, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; There is room: clears the result and moves on to the trade. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop::
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

; For an item prize: moves on when an inventory slot is free, otherwise steps back with refusal 1.
; (C1, E-0357)
MedalPrizeMenu_CallMedalPrizeMenu_ChoosePrize_InventoryHasF::
    call MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot
    cp $ff
    jr nz, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; if the key list is full (FindFreeKeySlotToTemp0 returns bit 7), wTwoChoiceCursor = 2, steps
; wScreenStep back and requests script $80; otherwise continues at
; MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop (E-0126) (E-0344: the address in its
; name dropped or read as the label there; was ScriptStepCheckKeyListFull)
ScriptStepCheckKeyListFull::
    farcall FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a prize, step 13: trades the medals: subtracts the prize's price (from the price table by
; entry) from wTinyMedals, redraws the count, and sets the message by prize kind (item or monster).
; (C1, E-0357)
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_2::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push hl
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add e
    ld e, a
    jr nc, .read_tiny_medals_lo
    inc d

.read_tiny_medals_lo:
    ld a, [de]
    ld b, a
    ld a, [wTinyMedalsLo]
    ld l, a
    ld a, [wTinyMedalsHi]
    ld h, a
    ld a, l
    sub b
    ld l, a
    ld a, h
    sbc $00
    ld [wTinyMedalsHi], a
    ld a, l
    ld [wTinyMedalsLo], a
    call DrawTinyMedalCountBoxAndStep
    pop hl
    ld a, [hl]
    cp $01
    jr nc, .set_two_choice_cursor_to_01
    xor a
    jr .set_two_choice_cursor

.set_two_choice_cursor_to_01:
    ld a, $01

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Choosing a prize, step 14: gives the prize: item entry 0 puts item $1E in a free inventory slot; a
; monster prize creates its record (MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_3); then,
; if no room is left for another, steps back with the refusal. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push af
    and a
    jr z, .call_medal_prize_menu_choose_prize_inventory
    call MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
    call MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_3
    jr .restore

.call_medal_prize_menu_choose_prize_inventory:
    call MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot
    ld a, $1e
    ld [hl], a
    jr .restore
    db $21, $9a, $68, $06, $12, $d7

.restore:
    pop af
    and a
    jr z, MedalPrizeMenu_ChoosePrize_CallMedalPrizeMenu_ChoosePrize_InventoryHasF
    call MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
    cp $ff
    jr nz, MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Loop
    ld a, $03
    jr MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_SetTwoChoiceCursor

; Clears the result before stepping back. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Loop::
    xor a

; Sets the result (A) and steps back three steps to the list. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_SetTwoChoiceCursor::
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; After an item prize: with a free inventory slot left goes back with no message, otherwise with
; refusal 1. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_CallMedalPrizeMenu_ChoosePrize_InventoryHasF::
    call MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot
    cp $ff
    jr nz, MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Loop
    ld a, $01
    jr MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_SetTwoChoiceCursor

; if the key list is full, continues with A = 2 at
; MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_SetTwoChoiceCursor; otherwise at
; MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Loop (E-0126) (E-0344: the address in its name
; dropped or read as the label there; was ScriptStepCheckKeyListFull_2)
ScriptStepCheckKeyListFull_2::
    farcall FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Loop
    ld a, $02
    jr MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_SetTwoChoiceCursor

; Creates a prize monster's record: from MonsterTable entry $179 + prize (LoadMonsterRecord) and its
; species (LoadSpeciesRecord, marked seen with SetSpeciesFlag), builds a new record in wRecordBufA
; (state 1, blank name, species, family and the rest) and stores it in a free SRAM slot. (C1,
; E-0357)
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_3::
    push hl
    ld hl, wRecordBufA
    ld b, $a5

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    pop hl
    push hl
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld hl, $0179
    add_a_to_hl
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wRecordBuffer]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBuffer + $1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    farcall SetSpeciesFlag
    ld hl, wRecordBufA
    ld a, $01
    ld [hli], a
    call WriteBlankName10_Bank0D
    ld a, [wRecordBuffer]
    ld [hli], a
    ld [wChildRecord + MON_SPECIES], a
    ld a, [wRecordBuffer + $1]
    ld [hli], a
    ld [wChildRecord + MON_SPECIES + 1], a
    ld a, [wSpeciesRecord]
    ld [hli], a
    push hl
    farcall RollChildSexFromSpecies
    pop hl
    ld a, [wChildRecord + MON_SEX]
    ld [hli], a
    ld de, wPlayerName
    ld c, $00

.loop2:
    ld a, [de]
    cp $f0
    jr z, .skip
    ld [hli], a
    inc c
    inc de
    ld a, c
    cp $0a
    jr c, .loop2
    jr .skip2

.skip:
    ld a, $f0
    ld [hli], a
    inc c
    ld a, c
    cp $0a
    jr z, .skip2
    ld a, $0a
    sub c
    ld b, a

.loop3:
    ld a, $f0
    ld [hli], a
    dec b
    jr nz, .loop3

.skip2:
    xor a
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call WriteUnknownNamePlaceholder_Bank0D
    xor a
    ld [hli], a
    call WriteUnknownNamePlaceholder_Bank0D
    xor a
    ld [hli], a
    ld b, $08

.loop4:
    ld a, $ff
    ld [hli], a
    dec b
    jr nz, .loop4
    push hl
    ld b, $19

.loop5:
    ld a, $ff
    ld [hli], a
    dec b
    jr nz, .loop5
    pop hl
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [hli], a
    ld a, $16
    add_a_to_hl
    xor a
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, [wRecordBufferData + $8]
    ld [hli], a
    ld a, [wRecordBufferData + $9]
    ld [hli], a
    ld a, [wRecordBufferData + $8]
    ld [hli], a
    ld a, [wRecordBufferData + $9]
    ld [hli], a
    ld a, [wRecordBufferData + $a]
    ld [hli], a
    ld a, [wRecordBufferData + $b]
    ld [hli], a
    ld a, [wRecordBufferData + $a]
    ld [hli], a
    ld a, [wRecordBufferData + $b]
    ld [hli], a
    ld a, [wRecordBufferData + $c]
    ld [hli], a
    ld a, [wRecordBufferData + $d]
    ld [hli], a
    ld a, [wRecordBufferData + $e]
    ld [hli], a
    ld a, [wRecordBufferData + $f]
    ld [hli], a
    ld a, [wRecordBufferData + $10]
    ld [hli], a
    ld a, [wRecordBufferData + $11]
    ld [hli], a
    ld a, [wRecordBufferData + $12]
    ld [hli], a
    ld a, [wRecordBufferData + $13]
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    xor a
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, [wRecordBufferData + $14]
    ld [hli], a
    ld a, [wRecordBufferData + $15]
    ld [hli], a
    ld a, [wRecordBufferData + $17]
    ld [hli], a
    ld a, [wRecordBufferData + $16]
    ld [hli], a
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1b

.loop6:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop6
    call WriteUnknownNamePlaceholder_Bank0D
    xor a
    ld [hli], a
    call WriteUnknownNamePlaceholder_Bank0D
    xor a
    ld [hli], a
    xor a
    ld [hli], a
    pop hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $a5

.loop7:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop7
    xor a
    ld [rRAMG2], a
    ret

; writes ten $F0 (blank) bytes at HL, without a terminator (E-0122)
WriteBlankName10_Bank0D::
    ld b, $0a
    jr WriteUnknownNamePlaceholder_Bank0D_Loop

; writes '???' ($98 x 3) and seven $F0 bytes at HL, without a terminator (E-0122)
WriteUnknownNamePlaceholder_Bank0D::
    ld a, $98
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld b, $07

; Fills the rest of a name with $F0: the end of WriteUnknownNamePlaceholder_Bank0D. (C1, E-0357)
WriteUnknownNamePlaceholder_Bank0D_Loop::
    ld a, $f0
    ld [hli], a
    dec b
    jr nz, WriteUnknownNamePlaceholder_Bank0D_Loop
    ret

; Finds a free SRAM record slot within the farm's capacity
; (MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Data by wFarmLevel): returns A = 0 with HL at it, or
; $FF when every slot is in use. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $00
    ld a, [wFarmLevel]
    ld de, MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a

.loop:
    push hl
    ld a, [hl]
    and a
    jr z, .restore
    cp $ff
    jr z, .restore
    pop hl
    ld a, $a5
    add_a_to_hl
    inc c
    ld a, c
    cp b
    jr c, .loop
    ld a, $ff
    ret

.restore:
    pop hl
    xor a
    ld [rRAMG2], a
    ret

; data read by MedalPrizeMenu (3 bytes) (E-0347)
MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Data::
    db $0a, $14, $1e

; A = 0 when one of the 24 inventory slots is empty, else $FF (E-0305)
MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot::
    ld hl, wInventory
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .return_0
    cp $ff
    jr z, .return_0
    inc hl
    inc c
    ld a, c
    cp $18
    jr c, .loop
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; A = 0 when one of the 12 four-byte wKeyList entries is free ($FF), else $FF (E-0124)
KeyListHasFreeSlot::
    ld hl, wKeyList
    ld c, $00

.loop:
    ld a, [hl]
    cp $ff
    jr z, .return_0
    ld a, $04
    add_a_to_hl
    inc c
    ld a, c
    cp $0c
    jr c, .loop
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; Draws the medal prices of the prizes on the current page: four on the first page, three or fewer
; on the second (by game completion), each as up to three digits. (C1, E-0357)
MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndGameCompletedEtc::
    ld a, [wListPageIndex]
    add a
    add a
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add e
    ld e, a
    jr nc, .check_list_page_index
    inc d

.check_list_page_index:
    ld a, [wListPageIndex]
    and a
    jr z, .skip
    ld a, [wGameCompleted]
    and a
    jr nz, .skip2
    ld a, [wListPageIndex]
    ld b, a
    ld a, $03
    sub b
    jr .skip3

.skip:
    ld a, $04
    jr .skip3

.skip2:
    ld a, $03

.skip3:
    ld b, a
    ld c, $00

.loop:
    push de
    push bc
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld de, MedalPrizeMenu_ChoosePrize_Data
    pop bc
    push bc
    ld a, c
    sla a
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    pop bc
    pop de
    inc de
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; data read by MedalPrizeMenu (8 bytes) (E-0347)
MedalPrizeMenu_ChoosePrize_Data::
    db $d7, $c3, $ff, $c3, $27, $c4, $4f, $c4

; writes B at BGMapAddressAtScroll_Bank0D + the offset from
; WriteTileBAtCursorListCursor_Data[wListCursor] (WaitForVRAMAccess, interrupts off); BC kept
; (E-0120)
WriteTileBAtCursorListCursor::
    push bc
    ld a, [wListCursor]
    sla a
    ld hl, WriteTileBAtCursorListCursor_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by WriteTileBAtCursorListCursor (8 bytes) (E-0347)
WriteTileBAtCursorListCursor_Data::
    db $a4, $00, $e4, $00, $24, $01, $64, $01

; counts inventory slots holding item $2C; $FF when there are none (E-0305)
MedalPrizeMenu_CountItem2C::
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    cp $2c
    jr nz, .restore
    pop bc
    inc b
    push bc

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp $18
    jr c, .loop
    ld a, b
    and a
    jr z, .return_FF
    ret

.return_FF:
    ld a, $ff
    ret

; Fills the prize list with entries 0-5, or 0-6 after the game is completed, and sets wListCount.
; (C1, E-0357)
MedalPrizeMenu_ChoosePrize_WriteListCount::
    ld a, [wGameCompleted]
    and a
    jr nz, .skip
    ld b, $06
    jr .skip2

.skip:
    ld b, $07

.skip2:
    ld hl, wListEntries
    ld c, $00

.loop:
    ld a, c
    ld [hli], a
    inc c
    ld a, c
    cp b
    jr c, .loop
    ld [wListCount], a
    ret

; Draws the names of the prizes on the current page from their strings (category from
; BeginStringDisplay_Bank0D_StringCategories, index $28 + entry). (C1, E-0357)
MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndListLastRowEtc::
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp $03
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
    sla a
    sla a
    add c
    cp b
    jp nc, .return
    push hl
    push bc
    ld a, [hl]
    add $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, BeginStringDisplay_Bank0D_StringCategories
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wNameGlyphBuf
    ld c, $00

.skip:
    ld a, [de]
    cp $f0
    jr z, .skip2
    ld [hli], a
    inc de
    jr .skip

.skip2:
    ld a, $f0
    ld [hl], a
    pop bc
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp c
    jr z, .return
    ld a, c
    cp $04
    jp c, .loop

.return:
    ret

; Draws the prize list's page indicator ('page/pages' on screen and in the window buffer). (C1,
; E-0357)
MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D::
    ld de, $018e
    call DrawC5BEC6AtScrollOffsetDE_Bank0D
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
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
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 11 x 3 tiles, one row per line
DrawTinyMedalCountBoxAndStep_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $ad, $cf, $ae, $af, $fc, $fd, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; record: 17 x 9 tiles, one row per line
MedalPrizeMenu_ChoosePrize_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data1::
    db $c3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $fd
    ds $14, $c3
    db $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $fd
    ds $14, $c3
    db $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $fd
    ds $14, $c3
    db $d9, $da, $db, $dc, $dd, $de, $f9, $fa, $fb, $fd, $c3, $c3, $c3, $c3

; record: 15 x 7 tiles, one row per line
MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_TileRect::
    db $c3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $fd, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $fd, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $d9, $da, $db, $dc, $dd, $de, $f9, $fa, $fb, $c3, $c3, $c3, $c3, $c3 ; id 6

MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data2::
    db $c3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $fd
    ds $14, $c3
    db $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $fd
    ds $14, $c3
    db $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $fd
    ds $14, $c3
    db $d9, $da, $db, $dc, $dd, $de, $f9, $fa, $fb, $c3, $c3, $c3, $c3, $c3

MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Data1::
    db $c3, $c3, $c3, $c3, $c3, $b7, $fd, $c3, $c3, $c3, $c3, $b7, $c3, $c3, $c3, $c3
    db $c3, $b7, $fd, $c3, $c3, $c3, $c3, $b7, $b4, $b4, $b4, $b4, $b4, $b5

MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Data2::
    db $c3, $c3, $c3, $c3, $c3, $b7, $fd, $c3, $c3, $c3, $c3, $b7, $c3, $c3, $c3, $c3
    db $c3, $b7, $c3, $c3, $c3, $c3, $c3, $b7, $b4, $b4, $b4, $b4, $b4, $b5

; record: 6 x 5 tiles, one row per line
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_2_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data3::
    db $cc, $c3, $f4, $c3, $1c, $c4, $44, $c4

MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data::
    db $03, $03, $04, $04, $05, $05, $0a

; far-calls CloseMenuE9 (E-0119)
ScriptCommandE9_RunFar::
    farcall CloseMenuE9
    ret

; implements script command type F4 (SCRIPT_NPC_BREED): breeding with a townsperson's monster picked
; by wScreenTableIndex: 'Who will breed with my SpikyBoy?' (mode 8, message bank $0E, + 16 *
; wScreenTableIndex); reached through ScriptCommandF4 in bank $10 (E-0038, E-0244)
NpcBreedMenu::
    ld a, [wScreenState]
    jumptable
    dw NpcBreedMenu_SwapMonstersMenu
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_ChooseAndBreed
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_SwapMonstersMenu_SetScreenStep
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_RedrawListScreen

; Breeding with a townsperson's monster, state 0: runs the monster screen set-up (SwapMonstersMenu),
; sets message mode 8 and skips to state 3. (C1, E-0357)
NpcBreedMenu_SwapMonstersMenu::
    farcall SwapMonstersMenu
    ld a, $08
    ld [wMessageMode], a
    ld a, [wScreenState]
    add $03
    ld [wScreenState], a
    ret

; Townsperson breeding, state 1: nothing. (C1, E-0357)
NpcBreedMenu_Return::
    ret

; by wScreenStep: BreedMenu list steps, a two-choice confirmation, ComputeBreedingChild, then a talk
; event (E-0288)
NpcBreedMenu_ChooseAndBreed::
    ld a, [wScreenStep]
    jumptable
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_SetTwoChoiceCursor
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_BreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw CopyScreenBufferRectAt0278AndStep_0D
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5_SetTwoChoiceCursor
    dw NpcBreedMenu_ChooseAndBreed_PrepareCounterPtr0LoCountersAndRequestScript
    dw NpcBreedMenu_ChooseAndBreed_WriteScreenStep
    dw NpcBreedMenu_ChooseAndBreed_ComputeBreedingChild
    dw NpcBreedMenu_ChooseAndBreed_QueueSoundEffect
    dw NpcBreedMenu_ChooseAndBreed_UpdateTwoChoiceCursor_Bank1D
    dw NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc
    dw NpcBreedMenu_ToRedrawFullScreenBoxes_0CAndStep
    dw NpcBreedMenu_ChooseAndBreed_DispatchTalkEvent
    dw NpcBreedMenu_ToRestorePlayerPositionState_Bank0DAndStep
    dw NpcBreedMenu_ChooseAndBreed_CopyBytesDEToHL_Bank0D

; Choosing a parent, step 0: runs the breeding list's steps (BreedMenu). (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_ToBreedMenu::
    farcall BreedMenu
    ret

; Choosing a parent, step 12: runs the breeding list's steps and reloads two frame tiles. (C1,
; E-0357)
NpcBreedMenu_ChooseAndBreed_BreedMenu::
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
    ret

; Choosing a parent, step 4: draws the family icon and the sex mark and level of the monster under
; the cursor. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5::
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
    call LoadFamilyIconTileForRecordB_Bank0D
    ld de, NpcBreedMenu_ChooseAndBreed_TileRect
    ld hl, wWindowTileBuffer + $6c
    lb bc, $0c, $05
    call CopyRectTo20ByteRows_Bank0D
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

; Choosing a parent, step 9: sets the refusal message. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_SetTwoChoiceCursor::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs CopyScreenBufferRectWithAttrs_0D (C = 5, HL = $0278, DE = $00AC, wArg1/2 = 0/8), then
; wScreenStep += 1 (E-0126) (E-0344: the address in its name dropped or read as the label there; was
; CopyScreenBufferRectAt0278AndStep_0D; shortened from
; RunCopyScreenBufferRectWithAttrs_0DAt0278AndStep_0D)
CopyScreenBufferRectAt0278AndStep_0D::
    ld c, $05
    ld hl, $0278
    ld de, $00ac
    xor a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing a parent, step 17: checks the chosen monster: below level 10 it steps back with refusal
; 2; the only party member cannot be chosen; otherwise it continues (the following lines check
; more). (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5_SetTwoChoiceCursor::
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
    ld [wTwoChoiceCursor], a
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

; Choosing a parent, step 18: copies the chosen record into wRecordBufA and starts the counting
; script (PrepareCounterPtr0LoCountersAndRequestScript); on the next call closes the box. (C1,
; E-0357)
NpcBreedMenu_ChooseAndBreed_PrepareCounterPtr0LoCountersAndRequestScript::
    ld a, [wScreenSubStep]
    and a
    jr nz, .clear_screen_sub_step
    call NpcBreedMenu_ChooseAndBreed_Multiply8
    farcall PrepareCounterPtr0LoCountersAndRequestScript
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    call CopyScreenBufferRectAt0278AndStep_0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ret

; Choosing a parent, step 19: copies the townsperson's preset monster (PresetMonsterRecordTable by
; wScreenTableIndex) into wRecordBufB, giving it the opposite sex of the player's monster. (C1,
; E-0357)
NpcBreedMenu_ChooseAndBreed_WriteScreenStep::
    call NpcBreedMenu_ChooseAndBreed_Multiply8
    ld a, [wScreenTableIndex]
    sla a
    ld de, PresetMonsterRecordTable
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
    ld de, wRecordBufB
    ld b, $a5

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wRecordBufA + MON_SEX
    ld a, [hl]
    and $01
    inc a
    and $01
    ld hl, wRecordBufB + MON_SEX
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Breeding, step 20: computes the child (ComputeBreedingChild, kind 1); when done, checks whether
; the child is new to the library and moves on. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_ComputeBreedingChild::
    ld a, $01
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call NpcBreedMenu_ChooseAndBreed_TestBitInFieldAtArg3
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a
    ld [wScreenSubStep], a
    ret

; Breeding, step 21: plays sound $6C, loads the box tiles and draws the yes/no box. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_QueueSoundEffect::
    ld a, $6c
    call QueueSoundEffect
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
    ld de, NpcBreedMenu_ChooseAndBreed_QueueSoundEffect_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Breeding, step 22: the yes/no answer: yes moves on to the breeding, no leaves the decision to the
; script. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_UpdateTwoChoiceCursor_Bank1D::
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
    cp $01
    jr z, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Breeding, step 23: deletes the parent's record (DeleteSRAMRecordAndCompact), writes the child's
; record in its place and saves; the next call moves on. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc::
    ld a, [wScreenSubStep]
    and a
    jr z, .read_selected_record
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_selected_record:
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a
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
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
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
    ld a, [wScreenTableIndex]
    sla a
    ld hl, NpcBreedMenu_ChooseAndBreed_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    farcall IncrementTwoCountersCappedAt99
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; data read by NpcBreedMenu (20 bytes) (E-0347)
NpcBreedMenu_ChooseAndBreed_Data::
    db $0e, $01, $18, $01, $1a, $01, $25, $01, $29, $01, $32, $00, $33, $00, $34, $00
    db $35, $00, $36, $00

; Breeding, step 24: redraws the screen boxes. (C1, E-0357)
NpcBreedMenu_ToRedrawFullScreenBoxes_0CAndStep::
    farcall RedrawFullScreenBoxes_0C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Breeding, step 25: starts talk event group $20 (the result), saving the script position to return
; to. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_DispatchTalkEvent::
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $20
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a
    ld [wScriptInDataBank], a
    xor a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Breeding, step 26: restores the player's position state. (C1, E-0357)
NpcBreedMenu_ToRestorePlayerPositionState_Bank0DAndStep::
    call RestorePlayerPositionState_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Breeding, step 27: restores the field screen from the window buffer and lets the script continue.
; (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_CopyBytesDEToHL_Bank0D::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank0_d
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0D

.call_bg_map_address_at_scroll_bank0_d:
    call BGMapAddressAtScroll_Bank0D
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRect_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRect_Bank0D
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Townsperson breeding, state 12: runs the monster screen (SwapMonstersMenu) until it finishes, then
; skips five states. (C1, E-0357)
NpcBreedMenu_SwapMonstersMenu_SetScreenStep::
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

; NpcBreedMenu screen state $11: graphics, palette and glyph tiles, then BreedMenu list steps
; (E-0304)
NpcBreedMenu_RedrawListScreen::
    ld a, [wScreenStep]
    jumptable
    dw NpcBreedMenu_RedrawListScreen_DecompressToVRAM
    dw NpcBreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F
    dw NpcBreedMenu_RedrawListScreen_ToBreedMenu
    dw NpcBreedMenu_RedrawListScreen_ToBreedMenu
    dw NpcBreedMenu_RedrawListScreen_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5
    dw NpcBreedMenu_RedrawListScreen_FillTilesFromRequest
    dw NpcBreedMenu_RedrawListScreen_SetArg5ToListEntriesCell5
    dw NpcBreedMenu_RedrawListScreen_ToBreedMenu
    dw NpcBreedMenu_RedrawListScreen_ToBreedMenu

; Redrawing the breeding list, step 2: runs the breeding list's steps. (C1, E-0357)
NpcBreedMenu_RedrawListScreen_ToBreedMenu::
    farcall BreedMenu
    ret

; Redrawing the breeding list, step 0: decompresses the townsperson's map tiles and palettes (by
; wScreenTableIndex). (C1, E-0357)
NpcBreedMenu_RedrawListScreen_DecompressToVRAM::
    ld a, [wScreenTableIndex]
    ld b, a
    sla a
    add b
    push af
    ld hl, NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data1
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data2
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; data read by NpcBreedMenu_RedrawListScreen_DecompressToVRAM (48 bytes) (E-0347)
NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data1::
    db $82, $6b, $48, $a9, $49, $48, $82, $6b, $48, $a9, $49, $48, $82, $6b, $48, $a9
    db $49, $48, $a9, $49, $48, $a9, $49, $48, $82, $6b, $48, $82, $6b, $48, $82, $6b
    db $48, $82, $6b, $48, $82, $6b, $48, $82, $6b, $48, $82, $6b, $48, $82, $6b, $48

NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data2::
    db $34, $6f, $48, $87, $4c, $48, $34, $6f, $48, $87, $4c, $48, $34, $6f, $48, $87
    db $4c, $48, $87, $4c, $48, $87, $4c, $48, $34, $6f, $48, $34, $6f, $48, $34, $6f
    db $48, $34, $6f, $48, $34, $6f, $48, $34, $6f, $48, $34, $6f, $48, $34, $6f, $48

; Redrawing the breeding list, step 1: copies the glyph tiles and two frame tiles. (C1, E-0357)
NpcBreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F::
    ld hl, NpcBreedMenu_RedrawListScreen_TileCopyDestList
    ld de, NpcBreedMenu_RedrawListScreen_TileCopySrcList
    call CopyGlyphTileListFromBank1F
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Redrawing the breeding list, step 6: clears the name tiles and sets the text window. (C1, E-0357)
NpcBreedMenu_RedrawListScreen_FillTilesFromRequest::
    ld hl, vTiles1 + $270
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $780
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
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
    ld hl, wScreenStep
    inc [hl]
    ret

; Redrawing the breeding list, step 7: draws the name and species name of the monster under the
; cursor. (C1, E-0357)
NpcBreedMenu_RedrawListScreen_SetArg5ToListEntriesCell5::
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

; Checks whether the child is new: when its species is in the list at
; NpcBreedMenu_ChooseAndBreed_TestBitInFieldAtArg3_Data and the library list but not yet seen
; (TestSpeciesFlag), wTwoChoiceCursor = 1 (the 'new monster' message); otherwise 0. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_TestBitInFieldAtArg3::
    ld a, [wArg6]
    ld [wArg1], a
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wArg2], a
    ld [wSpeciesIdHi], a
    ld de, NpcBreedMenu_ChooseAndBreed_TestBitInFieldAtArg3_Data
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, [wArg6]
    ld [wArg1], a
    ld a, [wArg7]
    ld [wArg2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, [wArg6]
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    call CopyMonsterNameToBuffer_B0D
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld b, $10

.loop:
    ld a, [hli]
    cp $f0
    jr z, .skip
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.skip:
    ld a, $90
    ld [de], a
    inc de
    ld a, $a2
    ld [de], a
    inc de
    push de
    ld a, [wChildRecord + MON_PLUS]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    pop de
    ld hl, wDigits
    ld b, $03

.loop2:
    ld a, [hl]
    cp $e3
    jr nz, .loop3
    inc hl
    dec b
    ld a, b
    cp $01
    jr nz, .loop2

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld a, $f0
    ld [de], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via
; wDataBank) to wNameGlyphBuf; wDataBank is restored (E-0026)
CopyMonsterNameToBuffer_B0D::
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

; the same 80 bytes as RestorePlayerPositionState (RestorePlayerPositionState) (E-0121)
RestorePlayerPositionState_Bank0D::
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

; the same 39 bytes as LoadFamilyIconTileForRecordB_Bank15 (LoadFamilyIconTileForRecordB_Bank15)
; (E-0122)
LoadFamilyIconTileForRecordB_Bank0D::
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

; Copies SRAM record wSelectedRecord into wRecordBufA. (C1, E-0357)
NpcBreedMenu_ChooseAndBreed_Multiply8::
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
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 12 x 5 tiles, one row per line
NpcBreedMenu_ChooseAndBreed_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $f8, $f9, $fa, $fb, $fc, $c3, $ea, $ed, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c7, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
NpcBreedMenu_RedrawListScreen_TileCopyDestList::
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; record: bank-$1F tile sources
NpcBreedMenu_RedrawListScreen_TileCopySrcList::
    dw $4130, $4320, $42a0, $4330, $4190, $4150, $ffff ; entry 0

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
NpcBreedMenu_ChooseAndBreed_QueueSoundEffect_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $76, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; NpcBreedMenu_ChooseAndBreed_WriteScreenStep reads the word at $78D6 + 2 * wScreenTableIndex and
; copies $A5 bytes from it to wRecordBufB; the first ten words point at ten consecutive records and
; the last six repeat the first (E-0235, C1)
; record: $A5-byte monster record
PresetMonsterRecordTable::
    dw PresetMonsterRecords ; id 0
    dw PresetMonsterRecords_01 ; id 1
    dw PresetMonsterRecords_02 ; id 2
    dw PresetMonsterRecords_03 ; id 3
    dw PresetMonsterRecords_04 ; id 4
    dw PresetMonsterRecords_05 ; id 5
    dw PresetMonsterRecords_06 ; id 6
    dw PresetMonsterRecords_07 ; id 7
    dw PresetMonsterRecords_08 ; id 8
    dw PresetMonsterRecords_09 ; id 9
    dw PresetMonsterRecords ; id 10
    dw PresetMonsterRecords ; id 11
    dw PresetMonsterRecords ; id 12
    dw PresetMonsterRecords ; id 13
    dw PresetMonsterRecords ; id 14
    dw PresetMonsterRecords ; id 15

; the ten records PresetMonsterRecordTable points at, $A5 bytes apart; only bytes 0, 1-10 and 15-24
; have read meanings, the rest are kept as bytes; fields from E-0034, E-0104, E-0122, E-0125 and
; E-0237, laid out in E-0262 (E-0235, C1)
; record: one $A5-byte monster record in the SRAM record format
PresetMonsterRecords::
    db $01 ; id 0: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $004a ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $02 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_UPPER, SKILL_MAGICBACK, SKILL_NAPATTACK, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $12 ; $56: level (E-0122)
    db $23 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0058, $0058, $005c, $005c ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $007f, $005d, $0045, $017f ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $c8, $c8, $96, $50 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_01::
    db $01 ; id 1: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $011e ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $08 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_BANG, SKILL_BOLT, SKILL_EVILSLASH, SKILL_RAMMING, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2a ; $56: level (E-0122)
    db $2a ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $00e6, $00e6, $00e0, $00e0 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00e2, $0110, $0132, $02f1 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $0a, $c8, $b4, $dc ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $00, $00, $02, $00, $01, $02, $00, $00, $01, $00, $00, $02, $00, $00, $02, $01, $01, $01, $00, $00, $00, $01, $01, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_02::
    db $01 ; id 2: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $00bc ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $05 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_BEAT, SKILL_STOPSPELL, SKILL_TWINSLASH, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $1c ; $56: level (E-0122)
    db $23 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $007b, $007b, $00ad, $00ad ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $0077, $00a6, $00b4, $0165 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $46, $64, $aa, $d2 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $01, $01, $01, $00, $02, $00, $00, $00, $02, $00, $00, $00, $00, $01, $01, $02, $02, $02, $01, $01, $01, $03, $03, $00 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_03::
    db $01 ; id 3: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $0092 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $04 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_HEALUS, SKILL_SLEEP, SKILL_CHANCE, SKILL_AQUAWALL, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $25 ; $56: level (E-0122)
    db $25 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $00a6, $00a6, $009f, $009f ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00d6, $00d4, $009b, $02eb ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $d2, $28, $96, $d2 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $02, $02, $01, $00, $00, $01, $02, $02, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_04::
    db $01 ; id 4: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $005e ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $02 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_FAREWELL, SKILL_PANICALL, SKILL_BIATTACK, SKILL_WARCRY, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $20 ; $56: level (E-0122)
    db $23 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0090, $0090, $0040, $0040 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00c6, $004f, $0098, $01c5 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $c8, $96, $96, $1e ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_05::
    db $01 ; id 5: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $0080 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $03 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_KODANCE, SKILL_LIFEDANCE, SKILL_DANCESHUT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2e ; $56: level (E-0122)
    db $32 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0174, $0174, $015f, $015f ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $0169, $0147, $01cb, $01b1 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $64, $96, $64, $82 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $03, $03, $00, $01, $00, $02, $01, $01, $01, $00, $00, $03, $00, $00, $00, $00, $02, $00, $03, $03, $03, $02, $02, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_06::
    db $01 ; id 6: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $010d ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_TRANSFORM, SKILL_BEDRAGON, SKILL_LIFESONG, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $35 ; $56: level (E-0122)
    db $35 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0173, $0173, $0246, $0246 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00f8, $01a1, $01ca, $01f4 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $14, $c8, $64, $b4 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $00, $00, $00, $02, $02, $03, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $03, $02, $01, $00, $00, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_07::
    db $01 ; id 7: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $0033 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $01 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_HEALUS, SKILL_ULTRADOWN, SKILL_SEALPRAY, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $3b ; $56: level (E-0122)
    db $3b ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $01f6, $01f6, $0147, $0147 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $01ad, $01bf, $01e9, $01ab ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $b4, $8c, $64, $8c ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $02, $00, $00, $02, $00, $02, $02, $00, $00, $00, $01, $01, $01, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_08::
    db $01 ; id 8: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $010a ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_FIRESLASH, SKILL_VACUSLASH, SKILL_BOLTSLASH, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2b ; $56: level (E-0122)
    db $37 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0155, $0155, $0135, $0135 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $015d, $013d, $010b, $0191 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $78, $82, $64, $5a ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $01, $02, $00, $02, $02, $02, $03, $01, $01, $02, $00, $00, $03, $00, $00, $01, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_09::
    db $01 ; id 9: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $0133 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $08 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_RAMMING, SKILL_SURGE, SKILL_GEYSER, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $36 ; $56: level (E-0122)
    db $36 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $01d3, $01d3, $01ba, $01ba ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $01ac, $0178, $014b, $01e0 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $78, $64, $64, $82 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $01, $00, $03, $01, $01, $03, $00, $01, $00, $00, $00, $03, $00, $01, $03, $00, $02, $01, $01, $01, $01, $01, $01, $02 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)
    ds $98, $00
