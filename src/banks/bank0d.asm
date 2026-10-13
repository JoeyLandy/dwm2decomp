SECTION "Bank 0D", ROMX[$4000], BANK[$0D]
    db $0D

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. ShowString_Bank0D, DebugMessageTest_Update_ToBeginStringDisplay_Bank0D, KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep)
BeginStringDisplay_Bank0D::
Func_00D_4001:: ; address name
    ld de, StringCategories_0D_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_00D_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor_Case06, MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor)
ShowString_Bank0D::
Func_00D_400F:: ; address name
    call BeginStringDisplay_Bank0D
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_0D_4016::
Data_00D_4016:: ; address name
    dw StringList_0D_4018 ; id 0

; E-0217 (derived: category list of StringCategories_0D_4016; one pointer per wStringIndex)
; record: string
StringList_0D_4018::
Data_00D_4018:: ; address name
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

String_0D_00_00:: ; heuristic: string; C0
Data_00D_4078:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Welcome to the", $F1
    db "Key Shop.", $FA, $F7
    db $EF, $EE, "Do you need any", $EF, $EE, "keys appraised?", $F0

String_0D_00_02:: ; heuristic: string; C0
Data_00D_40B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Okay. Come back if", $F1
    db "you find any Magic", $FA, $F7
    db $EF, $EE, "Keys.", $EF, $EE, $F7
    db $F0

String_0D_00_03:: ; heuristic: string; C0
Data_00D_40EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Don't come if", $F1
    db "you have no keys.", $F7
    db $F0

String_0D_00_04:: ; heuristic: string; C0
Data_00D_410E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Which key should", $F1
    db "I appraise?", $F7
    db $F0

String_0D_00_05:: ; heuristic: string; C0
Data_00D_412D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Appraisal will", $F1
    db "cost ", $F9, "0G. OK?", $F0

String_0D_00_06:: ; heuristic: string; C0
Data_00D_414D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hah? I'm not", $F1
    db "appraising any", $FA, $F7
    db $EF, $EE, "key if you don't", $EF, $EE, "pay my fee.", $F7
    db $F0

String_0D_00_08:: ; heuristic: string; C0
Data_00D_418C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Which Magic Key", $F1
    db "should I appraise?", $F0

String_0D_00_09:: ; heuristic: string; C0
Data_00D_41B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: That key's been", $F1
    db "appraised already.", $F7
    db $F0

String_0D_00_0A:: ; heuristic: string; C0
Data_00D_41D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You have no more", $F1
    db "Magic Keys that", $FA, $F7
    db $EF, $EE, "need appraisal, it", $EF, $EE, "seems to me.", $F7
    db $F0

String_0D_00_0B:: ; heuristic: string; C0
Data_00D_4221:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Should I save", $F1
    db "the results?", $F0

String_0D_00_0C:: ; heuristic: string; C0
Data_00D_423F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Let's see the", $F1
    db "Magic Key, then.", $FA, $F7
    db $EF, $EE, $A4, "Hmmm", $A4, " Hah?", $EF, $EE, "Oh, right", $A4, $FA, $F7
    db $EF, $EE, "I got it! This is", $EF, $EE, "the ", $F9, "0!", $E5, "0", $E4, $D4, $F7
    db $E9, $FF, $F0

String_0D_00_10:: ; heuristic: string; C0
Data_00D_42A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Ah, you have", $F1
    db "some TinyMedals?", $FA, $F7
    db $EF, $EE, "Let me relieve you", $EF, $EE, "of them.", $F7
    db $F0

String_0D_00_12:: ; heuristic: string; C0
Data_00D_42E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: ", $A4, "But, I can't", $F1
    db "take this many.", $F7
    db $F0

String_0D_00_13:: ; heuristic: string; C0
Data_00D_4303:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I have ", $F9, "0 of", $F1
    db "your TinyMedals.", $F7
    db $F0

String_0D_00_14:: ; heuristic: string; C0
Data_00D_4325:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I hope you'll", $F1
    db "find many medals!", $F7
    db $F0

String_0D_00_15:: ; heuristic: string; C0
Data_00D_4348:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Want to trade", $F1
    db "medals for prizes?", $F0

String_0D_00_16:: ; heuristic: string; C0
Data_00D_436C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Which prize do", $F1
    db "you want?", $F0

String_0D_00_17:: ; heuristic: string; C0
Data_00D_4388:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I'll trade for", $F1
    db $F9, "0 TinyMedals. OK?", $F0

String_0D_00_18:: ; heuristic: string; C0
Data_00D_43AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: That requires", $F1
    db "more TinyMedals.", $F7
    db $F0

String_0D_00_19:: ; heuristic: string; C0
Data_00D_43CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You don't have", $F1
    db "any room for that.", $F7
    db $F0

String_0D_00_1A:: ; heuristic: string; C0
Data_00D_43F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Your key ring is", $F1
    db "already full.", $F7
    db $F0

String_0D_00_1B:: ; heuristic: string; C0
Data_00D_4417:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You have no more", $F1
    db "room for monsters.", $F7
    db $F0

String_0D_00_1C:: ; heuristic: string; C0
Data_00D_443F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Fine, we shall", $F1
    db "trade.", $F7
    db $F0

String_0D_00_1D:: ; heuristic: string; C0
Data_00D_4459:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I'll send the egg", $F1
    db "to the farm.", $F7
    db $F0

String_0D_00_1E:: ; heuristic: string; C0
Data_00D_447B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't take", $F1
    db "any more items.", $F7
    db $F0

String_0D_00_1F:: ; heuristic: string; C0
Data_00D_449D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You can't hold any", $F1
    db "more keys.", $F7
    db $F0

String_0D_00_20:: ; heuristic: string; C0
Data_00D_44BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You have no more", $F1
    db "room for monsters.", $F7
    db $F0

String_0D_00_21:: ; heuristic: string; C0
Data_00D_44E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Leads to another", $F1
    db "world.", $F0

String_0D_00_22:: ; heuristic: string; C0
Data_00D_44FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a monster by", $F1
    db "a great amount.", $F0

String_0D_00_23:: ; heuristic: string; C0
Data_00D_4521:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0's egg.", $F0

String_0D_00_24:: ; heuristic: string; C0
Data_00D_452A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: At minimum, you", $F1
    db "must have three", $FA, $F7
    db $EF, $EE, "TinyMedals if you", $EF, $EE, "want me to trade.", $FA, $F7
    db $EF, $EE, "I hope you'll find", $EF, $EE, "many medals!", $F7
    db $F0

String_0D_00_25:: ; heuristic: string; C0
Data_00D_4599:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MeteOrb", $F0

String_0D_00_29:: ; heuristic: string; C0
Data_00D_45A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCat", $F0

String_0D_00_2A:: ; heuristic: string; C0
Data_00D_45A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HornBeet", $F0

String_0D_00_2B:: ; heuristic: string; C0
Data_00D_45B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyDragon", $F0

String_0D_00_2C:: ; heuristic: string; C0
Data_00D_45BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octogon", $F0

String_0D_00_2D:: ; heuristic: string; C0
Data_00D_45C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Servant", $F0

String_0D_00_2E:: ; heuristic: string; C0
Data_00D_45CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck", $F0

; implements script command type EF (SCRIPT_EGG_SERVICE): egg appraisal and blessing: 'Which egg should I appraise?', 'Which egg should I bless?' (mode 6, bank $F2 strings); reached through ScriptCommandEF in bank $10 (E-0038, E-0244) (C2 from E-0325: the Egg Evaluator's 'May I help you…' runs it with 'Evaluate / Bless / Exit')
; 2 call sites from 2 routines (e.g. RenameMenu_ToEggServiceMenu, ScriptCommandEF)
; reads: wScreenState
EggServiceMenu::
Func_00D_45D1:: ; address name
    ld a, [wScreenState]
    rst $00
    dw EggServiceMenu_CopyBytesDEToHL_Bank0D
    dw EggServiceMenu_DrawPrice
    dw EggServiceMenu_HandleThreeOptionMenuInput_15
    dw EggServiceMenu_ListRecordsInUseWithByte6ESet
    dw EggServiceMenu_Return
    dw EggServiceMenu_ChooseAndPay
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_SwapMonstersMenu
    dw EggServiceMenu_Return_Case06
    dw EggServiceMenu_DrawListAndPrice

; entry 6 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Return_Case06::
Jump_00D_45F5:: ; address name
    ret

; entry 0 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
EggServiceMenu_CopyBytesDEToHL_Bank0D::
Jump_00D_45F6:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
    jr z, .set_message_mode_to_06
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

.set_message_mode_to_06:
    ld a, $06
    ld [wMessageMode], a
    xor a, a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: two rectangles and a 24-bit number (Number24ToPackedBCD)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_DrawPrice::
Jump_00D_4635:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw DrawPair4F81And4F9FAndStep
    dw EggServiceMenu_DrawPrice_Number24ToPackedBCD
    dw EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D

; runs Func_00D_4F3D for Data_00D_4F81 and Data_00D_4F9F, then wScreenStep += 1 (E-0122)
; 1 call site from 1 routine (e.g. EggServiceMenu_DrawListAndPrice_CopyGlyphTileListFromBank1F)
; reads: wScreenStep
; writes: wScreenStep
DrawPair4F81And4F9FAndStep::
Func_00D_463F:: ; address name
    ld hl, TileCopyDestList_0D_4F81
    ld de, TileCopySrcList_0D_4F9F
    call CopyGlyphTileListFromBank1F
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_DrawPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wGoldLo, wGoldMid, wGoldHi, wScreenStep
; writes: wDigits, wScreenStep
; points at: wArg3
EggServiceMenu_DrawPrice_Number24ToPackedBCD::
Jump_00D_4650:: ; address name
    ld de, TileRect_0D_4FBD
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
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
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_DrawPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D::
Jump_00D_4692:: ; address name
    ld de, TileRect_0D_4FD5
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B07
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wThreeOptionResult
EggServiceMenu_HandleThreeOptionMenuInput_15::
Jump_00D_46B6:: ; address name
    ld a, $01
    ld [wThreeOptionResult], a
    farcall HandleThreeOptionMenuInput_15
    ret

; entry 3 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wRecordsFlagged, wScreenState
; writes: wScreenByteBD, wTwoChoiceCursor, wScreenState, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
EggServiceMenu_ListRecordsInUseWithByte6ESet::
Jump_00D_46C2:: ; address name
    ld a, [wGridCursorX]
    and a, a
    jr z, .clear_screen_byte_bd
    jr .set_screen_byte_bd_to_01

.clear_screen_byte_bd:
    xor a, a
    ld [wScreenByteBD], a
    jr .call_list_records_in_use_with_byte6_e_set

.set_screen_byte_bd_to_01:
    ld a, $01
    ld [wScreenByteBD], a

.call_list_records_in_use_with_byte6_e_set:
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wRecordsFlagged]
    and a, a
    jr z, .set_two_choice_cursor_to_01
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Return::
Jump_00D_470F:: ; address name
    ret

; by wScreenStep: BreedMenu list steps, a two-choice confirmation and IsAmountInArg1AboveGold
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_ChooseAndPay::
Jump_00D_4710:: ; address name
    ld a, [wScreenStep]
    rst $00
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
    dw DrawBox5022WithPageIndicator
    dw EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks
    dw EggServiceMenu_ChooseAndPay_CheckAndPay

; entry 0 of the `rst $00` table in EggServiceMenu_ChooseAndPay
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_ChooseAndPay_ToBreedMenu::
Jump_00D_473A:: ; address name
    farcall BreedMenu
    ret

; entry 6 of the `rst $00` table in EggServiceMenu_ChooseAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor, wScreenByteBD
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wDigits, wScriptCommandType, wScriptStartRequest
; points at: wArg4, wTextBuf0, wTextWindowTileLo
EggServiceMenu_ChooseAndPay_UpdatePagedListCursor::
Jump_00D_4741:: ; address name
    ld a, $02
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .return
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $04
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
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, EggServiceMenu_ChooseAndPay_UpdatePagedListCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenByteBD]
    and a, a
    jr z, .skip4
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld b, $04
    ld hl, wArg4

.loop:
    ld a, [hl]
    cp a, $E3
    jr nz, .skip
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, .loop

.skip:
    ld de, wTextBuf0

.skip2:
    ld a, b
    and a, a
    jr z, .skip3
    ld a, [hl]
    ld [de], a
    inc de
    inc hl
    dec b
    jr .skip2

.skip3:
    ld a, $F0
    ld [de], a

.skip4:
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in EggServiceMenu_ChooseAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursor, wScreenStep
; writes: wArg5, wScreenByteB2, wScreenByteB3, wScreenState, wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, ...
EggServiceMenu_ChooseAndPay_HandleTwoChoiceCursorInput_0D::
Jump_00D_47F7:: ; address name
    xor a, a
    ld [wArg5], a
    call HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a, a
    ret z
    cp a, $FE
    jr z, .set_two_choice_cursor_to_02
    cp a, $FF
    jr z, .check_choice_cursor
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_choice_cursor:
    ld a, [wChoiceCursor]
    and a, a
    jp nz, .set_two_choice_cursor_to_01
    ld a, $05
    ld [wScreenByteB2], a
    ld a, $0C
    ld [wScreenByteB3], a
    ld a, $0D
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    farcall SaveAndHideSpriteState_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in EggServiceMenu_ChooseAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteBD, wArg1, wScreenStep, wArg5, wArg6
; writes: wArg1, wArg2, wArg3, wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, ...
EggServiceMenu_ChooseAndPay_IsAmountInArg1AboveGold::
Jump_00D_4869:: ; address name
    ld a, [wScreenByteBD]
    and a, a
    jr nz, .call_egg_service_menu_set_arg5_to_list
    ld a, $14
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    and a, a
    jr nz, .set_two_choice_cursor_to_01
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

.call_egg_service_menu_set_arg5_to_list:
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    and a, a
    jr z, .call_set_arg5_to_list_entries_cell4

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
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
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_SEX
    call SRAMRecordAddress
    ld a, [hl]
    and a, a
    jr z, .skip
    xor a, a
    jr .skip2

.skip:
    ld a, $01

.skip2:
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall SubtractArg1AmountFromGold
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; copies box Data_00D_5022 to wWindowTileBuffer + $BB, runs Func_01E_71E1, draws the page-of-pages indicator when wListPages >= 2, and wScreenStep += 1 (E-0124)
; 1 call site from 1 routine (e.g. EggServiceMenu_DrawListAndPrice_DrawBox5022WithPageIndicator)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawBox5022WithPageIndicator::
Func_00D_491A:: ; address name
    ld de, TileRect_0D_5022
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank0D
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
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

; entry 17 of the `rst $00` table in EggServiceMenu_ChooseAndPay
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wScreenStep, wScriptCommandType, wScriptStartRequest
EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks::
Jump_00D_4952:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $07
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenSubStep: reads bytes of the chosen record (LoadSRAMRecordByte/Word, MON_SEX), divides, and subtracts 20 gold (SubtractArg1AmountFromGold)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
EggServiceMenu_ChooseAndPay_CheckAndPay::
Jump_00D_4988:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_EndScriptCommandAndIncScreenSubStep
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case02
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case03
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case04
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case05
    dw EggServiceMenu_ChooseAndPay_CheckAndPay_SubtractArg1AmountFromGold

; entry 0 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor
EggServiceMenu_ChooseAndPay_CheckAndPay_EndScriptCommandAndIncScreenSubStep::
Jump_00D_499A:: ; address name
    xor a, a
    ld [wTwoChoiceCursor], a
    call EndScriptCommandAndIncScreenSubStep
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM::
Jump_00D_49A2:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld c, $00
    ld de, $0000

.loop:
    push hl
    push bc
    push de
    ld a, c
    ld de, EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Data
    add a, e
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
    add a, e
    ld e, a
    ldh a, [hTemp1]
    adc a, d
    ld d, a
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, $06
    jr c, .loop
    ld l, e
    ld h, d
    ld a, $06
    call DivideHLByA
    ld a, h
    and a, a
    jr z, .skip2

.loop2:
    ld a, $03
    jr EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip2:
    ld a, l
    cp a, $C9
    jr nc, .loop2
    cp a, $65
    jr nc, .skip3
    cp a, $33
    jr nc, .skip4
    xor a, a
    jr EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip3:
    ld a, $02
    jr EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip4:
    ld a, $01

EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor::
Jump_00D_49F2:: ; address name
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    call EndScriptCommandAndIncScreenSubStep
    ret

; address loaded by EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_49FD:: ; address name
    db $5D, $61, $63, $65, $67, $69

; entry 2 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case02::
Jump_00D_4A03:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, MON_SKILL_LIST
    call SRAMRecordAddress
    ld c, $00
    ld b, $00

.loop:
    ld a, [hl+]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc b

.next:
    inc c
    ld a, c
    cp a, $19
    jr c, .loop
    ld a, b
    cp a, $06
    jr c, .skip
    cp a, $0B
    jr c, .skip2
    cp a, $10
    jr c, .skip3
    ld a, $03
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip:
    xor a, a
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip2:
    ld a, $01
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip3:
    ld a, $02
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

; entry 3 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case03::
Jump_00D_4A3F:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, MON_MAX_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $29
    jr c, .skip
    cp a, $3D
    jr c, .skip2
    cp a, $51
    jr c, .skip3
    ld a, $03
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip:
    xor a, a
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip2:
    ld a, $01
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

.skip3:
    ld a, $02
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

; entry 4 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case04::
Jump_00D_4A69:: ; address name
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
    cp a, e
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
    cp a, e
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
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

; entry 5 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case05::
Jump_00D_4ABF:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    jp EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_SetTwoChoiceCursor

; entry 6 of the `rst $00` table in EggServiceMenu_ChooseAndPay_CheckAndPay
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6
; writes: wArg1, wArg2, wArg3, rRAMG2, rRAMB, wScreenSubStep, wScreenStep, wScriptCommandType, ...
EggServiceMenu_ChooseAndPay_CheckAndPay_SubtractArg1AmountFromGold::
Jump_00D_4ACF:: ; address name
    ld a, $14
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld [wArg3], a
    farcall SubtractArg1AmountFromGold
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_EGG
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $10
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; enables SRAM (bank 0), far-calls SetArg5ToListEntriesCell4 and returns HL = wArg5 (high) / wArg6 (low) (E-0119)
; 5 call sites from 5 routines (e.g. EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case05, EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case04, EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case03, EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM_Case02, ...)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB
GetListEntriesCell4AddressWithSRAM::
Func_00D_4B18:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ret

; wScreenSubStep += 1, wScriptCommandType = 0, wScriptStartRequest = $80 (E-0119)
; 2 call sites from 2 routines (e.g. EggServiceMenu_ChooseAndPay_CheckAndPay_GetListEntriesCell4AddressWithSRAM, EggServiceMenu_ChooseAndPay_CheckAndPay_EndScriptCommandAndIncScreenSubStep)
; reads: wScreenSubStep
; writes: wScreenSubStep, wScriptCommandType, wScriptStartRequest
EndScriptCommandAndIncScreenSubStep::
Func_00D_4B30:: ; address name
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
EggServiceMenu_SwapMonstersMenu::
Jump_00D_4B41:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: decompresses graphics, draws the record list page (species names, marks) and a 24-bit number (Number24ToPackedBCD)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_DrawListAndPrice::
Jump_00D_4B5D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_DrawListAndPrice_DecompressToVRAM
    dw EggServiceMenu_DrawListAndPrice_CopyGlyphTileListFromBank1F
    dw EggServiceMenu_DrawListAndPrice_FillTilesBxC
    dw EggServiceMenu_DrawListAndPrice_DrawBox5022WithPageIndicator
    dw EggServiceMenu_DrawListAndPrice_DrawRecordListPageSpeciesNames
    dw EggServiceMenu_DrawListAndPrice_DrawRecordListPageMarks
    dw EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D
    dw EggServiceMenu_DrawListAndPrice_Number24ToPackedBCD
    dw EggServiceMenu_DrawListAndPrice_LoadPlayerAndFollowerSpriteGraphics

; entry 0 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
EggServiceMenu_DrawListAndPrice_DecompressToVRAM::
Jump_00D_4B73:: ; address name
    ld hl, vTiles2
    ld de, Map0ATileset
    ld b, $49
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, BGPaletteBufferData_49_46DC
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_DrawListAndPrice_CopyGlyphTileListFromBank1F::
Jump_00D_4B98:: ; address name
    ld hl, TileCopyDestList_0D_509F
    ld de, TileCopySrcList_0D_50AF
    call CopyGlyphTileListFromBank1F
    call DrawPair4F81And4F9FAndStep
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
EggServiceMenu_DrawListAndPrice_FillTilesBxC::
Jump_00D_4BA5:: ; address name
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
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

; entry 3 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
EggServiceMenu_DrawListAndPrice_DrawBox5022WithPageIndicator::
Jump_00D_4BDE:: ; address name
    call DrawBox5022WithPageIndicator

; entry 4 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
EggServiceMenu_DrawListAndPrice_DrawRecordListPageSpeciesNames::
Jump_00D_4BE1:: ; address name
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
EggServiceMenu_DrawListAndPrice_DrawRecordListPageMarks::
Jump_00D_4BF4:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
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

; entry 6 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D::
Jump_00D_4C17:: ; address name
    ld a, [wListCursor]
    ld b, $BC
    ld hl, EggServiceMenu_ChooseAndPay_UpdatePagedListCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld de, TileRect_0D_50BD
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteBD, wScreenStep
; writes: wDigits, wStringIndex, wStringCategory, wScreenStep
; points at: wArg4, wTextBuf0, wTextWindowTileLo
EggServiceMenu_DrawListAndPrice_Number24ToPackedBCD::
Jump_00D_4C36:: ; address name
    ld a, [wScreenByteBD]
    and a, a
    jr z, .set_string_index_to_03
    call EggServiceMenu_SetArg5ToListEntriesCell4
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld b, $04
    ld hl, wArg4

.loop:
    ld a, [hl]
    cp a, $E3
    jr nz, .skip
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, .loop

.skip:
    ld de, wTextBuf0

.skip2:
    ld a, b
    and a, a
    jr z, .skip3
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr .skip2

.skip3:
    ld a, $F0
    ld [de], a
    ld a, $08
    jr .set_string_index

.set_string_index_to_03:
    ld a, $03

.set_string_index:
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    farcall ShowString_BankF2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in EggServiceMenu_DrawListAndPrice
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
EggServiceMenu_DrawListAndPrice_LoadPlayerAndFollowerSpriteGraphics::
Jump_00D_4C9C:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0D
    farcall RestoreSpriteStateFromSavedFieldDrawFlags
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of EggServiceMenu (E-0098)
; 4 call sites from 3 routines (e.g. EggServiceMenu_ChooseAndPay_IsAmountInArg1AboveGold, EggServiceMenu_ChooseAndPay_UpdatePagedListCursor, EggServiceMenu_DrawListAndPrice_Number24ToPackedBCD)
; reads: wArg5, wArg6, hTemp0
; writes: rRAMG2, rRAMB
EggServiceMenu_SetArg5ToListEntriesCell4::
Func_00D_4CF4:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_PLUS
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld c, $14
    call Multiply8
    ld a, $14
    add_a_to_hl
    ret

; up/down moves wChoiceCursor between two entries; A sets wArg5 = $FF (with sound $69 and the arrow tile), B sets $FE; otherwise blinks the cursor and wArg5 = 0 (E-0127)
; 5 call sites from 5 routines (e.g. EggServiceMenu_ChooseAndPay_HandleTwoChoiceCursorInput_0D, EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo_Case0A, GameMode6_Update_ChooseRecordList_HandleTwoChoiceCursorInput_0D, GameMode6_Update_ChooseRecordAndSave_HandleTwoChoiceCursorInput_0D, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wChoiceCursor
; writes: wArg5, wChoiceCursor
HandleTwoChoiceCursorInput_0D::
Func_00D_4D24:: ; address name
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
    xor a, a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c3_bank0_d:
    call DrawBlankTileC3_Bank0D
    ld a, [wChoiceCursor]
    and a, a
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
    xor a, a
    ld [wArg5], a
    ret

.call_draw_blank_tile_c3_bank0_d2:
    call DrawBlankTileC3_Bank0D
    ld a, [wChoiceCursor]
    cp a, $01
    jr c, .skip
    xor a, a
    jr .set_choice_cursor2

.skip:
    inc a
    jr .set_choice_cursor2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtChoiceCursorEntry
    ld a, $FF
    ld [wArg5], a
    ret

.set_arg5_to_FE:
    ld a, $FE
    ld [wArg5], a
    ret

; once the joypad repeat timer reaches $14, cycles wCursorBlinkAE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 1 call site from 1 routine (e.g. HandleTwoChoiceCursorInput_0D)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
BlinkCursorBlinkAE_Bank0D::
Func_00D_4D86:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_Bank0D
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, DrawCursorTileBB_Bank0D
    cp a, $18
    jr c, DrawBlankTileC3_Bank0D
    xor a, a
    ld [wCursorBlinkAE], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. HandleTwoChoiceCursorInput_0D)
; reads: wChoiceCursor
DrawCursorTileBB_Bank0D::
Func_00D_4DA0:: ; address name
    ld b, $BB
    jr DrawArrowTileBCAtChoiceCursorEntry_ReadChoiceCursor

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleTwoChoiceCursorInput_0D)
; reads: wChoiceCursor
DrawBlankTileC3_Bank0D::
Func_00D_4DA4:: ; address name
    ld b, $C3
    jr DrawArrowTileBCAtChoiceCursorEntry_ReadChoiceCursor

; B = $BC, then writes B at the scroll position + Data_00D_4DC7[wChoiceCursor] (the shared tile-at-entry draw) (E-0124)
; 1 call site from 1 routine (e.g. HandleTwoChoiceCursorInput_0D)
; reads: wChoiceCursor
DrawArrowTileBCAtChoiceCursorEntry::
Func_00D_4DA8:: ; address name
    ld b, $BC

DrawArrowTileBCAtChoiceCursorEntry_ReadChoiceCursor::
Jump_00D_4DAA:: ; address name
    ld a, [wChoiceCursor]
    add a, a
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

; address loaded by DrawArrowTileBCAtChoiceCursorEntry
DrawArrowTileBCAtChoiceCursorEntry_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_4DC7:: ; address name
    db $2D, $01, $6D, $01

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 21 call sites from 21 routines (e.g. EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D, EggServiceMenu_DrawPrice_Number24ToPackedBCD, DrawBox5022WithPageIndicator, EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank0D::
Func_00D_4DCB:: ; address name
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

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wTextCursorLo/wTextCursorHi = HL + $1C1, replaced by $99C1 when that is $9B61 (E-0062)
; 30 call sites from 27 routines (e.g. MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D, EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D, EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks, EggServiceMenu_DrawListAndPrice_LoadPlayerAndFollowerSpriteGraphics, ...)
; reads: wTextCursorLo, wTextCursorHi, wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRect_Bank0D::
Func_00D_4E05:: ; address name
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
    ld a, [wTextCursorLo]
    cp a, $61
    jr nz, .restore
    ld a, [wTextCursorHi]
    cp a, $9B
    jr nz, .restore
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 35 call sites from 32 routines (e.g. MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D, RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D, EggServiceMenu_DrawPrice_CopyRectTo20ByteRows_Bank0D, EggServiceMenu_ChooseAndPay_DrawRecordListPageMarks, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank0D::
Func_00D_4E5A:: ; address name
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 6 call sites from 5 routines (e.g. CopyScreenBufferRectWithAttrs_0D, MedalPrizeMenu_CopyBytesDEToHL_Bank0D, KeyAppraisalMenu_CopyBytesDEToHL_Bank0D, EggServiceMenu_CopyBytesDEToHL_Bank0D, ...)
CopyBytesDEToHL_Bank0D::
Func_00D_4E7B:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank0D
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 6 call sites from 5 routines (e.g. CopyScreenBufferRectWithAttrs_0D, MedalPrizeMenu_CopyBytesDEToHL_Bank0D, KeyAppraisalMenu_CopyBytesDEToHL_Bank0D, EggServiceMenu_CopyBytesDEToHL_Bank0D, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank0D::
Func_00D_4E84:: ; address name
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 9 call sites from 9 routines (e.g. EggServiceMenu_ChooseAndPay_UpdatePagedListCursor, EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D, EraseCEntriesOfWordTable_Bank0D, KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor, ...)
StoreBAtWordTableEntry_Bank0D::
Func_00D_4E96:: ; address name
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

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (WaitForVRAMAccess, interrupts off) (E-0120)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor, MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D)
DrawC5BEC6AtScrollOffsetDE_Bank0D::
Func_00D_4EA4:: ; address name
    push de
    call BGMapAddressAtScroll_Bank0D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 4 call sites from 4 routines (e.g. DrawBox5022WithPageIndicator, KeyAppraisalMenu_ChooseKey_Case07_StoreC5BEC6AtHLStride2_Bank0D, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor, MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D)
StoreC5BEC6AtHLStride2_Bank0D::
Func_00D_4EC7:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; copies a wArg1 x wArg2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 4 call sites from 4 routines (e.g. MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D, RenameMenu_DrawNameList_CopyScreenBufferRectWithAttrs_0D, KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics_Case10, RunFunc4ED5At0278AndStep_0D)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
CopyScreenBufferRectWithAttrs_0D::
Func_00D_4ED5:: ; address name
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
    call CopyLow3BitsToWRAMBank2_Bank0D
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
    jr nz, CopyScreenBufferRectWithAttrs_0D
    ret

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL (StoreBAtWordTableEntry_Bank0D) (E-0122)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_EraseCEntriesOfWordTable_Bank0D, MedalPrizeMenu_ChoosePrize_EraseCEntriesOfWordTable_Bank0D)
EraseCEntriesOfWordTable_Bank0D::
Func_00D_4F29:: ; address name
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank0D
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ret

; for each entry from wGlyphListStart of the destination list at HL and the source list at DE copies a 16-byte tile from bank $1F, until $FF; then clears wGlyphListPos/5 (E-0125)
; 3 call sites from 3 routines (e.g. DrawPair4F81And4F9FAndStep, EggServiceMenu_DrawListAndPrice_CopyGlyphTileListFromBank1F, NpcBreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F)
; reads: wGlyphListStart
; writes: wGlyphListStart, wGlyphListPos
CopyGlyphTileListFromBank1F::
Func_00D_4F3D:: ; address name
    push hl
    push de
    ld a, [wGlyphListStart]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, .restore
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wGlyphListStart]
    add a, a
    add a, e
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
    ld b, $1F
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
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_0D_4F81::
Data_00D_4F81:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290, vTiles1 + $2A0, vTiles1 + $2B0 ; entry 0
    dw vTiles1 + $2C0, vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $2F0, vTiles1 + $6E0, vTiles1 + $6F0, rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_0D_4F9F::
Data_00D_4F9F:: ; address name
    dw $40F0, $43A0, $4250, $4300, $4390, $4380, $4290, $40C0 ; entry 0
    dw $4370, $43C0, $42D0, $4910, $4910, $4910, $FFFF

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_0D_4FBD::
Data_00D_4FBD:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 7 tiles, one row per line
TileRect_0D_4FD5::
Data_00D_4FD5:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A4, $A5, $A6, $A7, $A8, $A6, $A9, $AA, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $AB, $A7, $AA, $AC, $AC, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $A4, $AD, $AE, $A9, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_0D_5022::
Data_00D_5022:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C0, $C1, $C2, $C7, $C8, $C9, $CA, $CB, $FC, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; address loaded by EggServiceMenu_ChooseAndPay_UpdatePagedListCursor, EggServiceMenu_DrawListAndPrice_StoreBAtWordTableEntry_Bank0D
EggServiceMenu_ChooseAndPay_UpdatePagedListCursor_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5097:: ; address name
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_0D_509F::
Data_00D_509F:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_0D_50AF::
Data_00D_50AF:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_0D_50BD::
Data_00D_50BD:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $70, $71, $72, $73, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $74, $75, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; implements script command type F1 (SCRIPT_RENAME_CLOSE): ends the renaming session (runs CloseBreedMenu's code); reached through ScriptCommandF1 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF1)
; reads: wScreenList
CloseRenameMenu::
Func_00D_50E5:: ; address name
    ld a, [wScreenList]
    rst $00
    dw CloseRenameMenu_ToCloseBreedMenu
    dw CloseRenameMenu_LoadRecordListNameTiles
    dw CloseRenameMenu_ToCloseBreedMenu
    dw CloseRenameMenu_ToCloseBreedMenu

; entry 0 of the `rst $00` table in CloseRenameMenu
; no direct call (reached through a table, a jump or a vector)
CloseRenameMenu_ToCloseBreedMenu::
Jump_00D_50F1:: ; address name
    farcall CloseBreedMenu
    ret

; entry 1 of the `rst $00` table in CloseRenameMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenList
; writes: wGlyphListPos, wGlyphListStart, wScreenState, wScreenStep, wMenuState, wScreenList, wTextWindowTileLo, wTextWindowTileHi, ...
CloseRenameMenu_LoadRecordListNameTiles::
Jump_00D_50F8:: ; address name
    call LoadRecordListNameTiles
    ld de, Tiles2Plus710Tiles_1F_4910
    ld hl, vTiles1 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4910
    ld hl, vTiles1 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus710Tiles_1F_4910
    ld hl, vTiles1 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type F0 (SCRIPT_RENAME): the Christener's renaming: 'Pick the monster to rename.' (runs EggServiceMenu's first state, so mode 6); reached through ScriptCommandF0 in bank $10 (E-0038, E-0244) (C2 from E-0325: the Christener runs it and its name entry changes MON_NAME)
; 1 call site from 1 routine (e.g. ScriptCommandF0)
; reads: wScreenState
RenameMenu::
Func_00D_5159:: ; address name
    ld a, [wScreenState]
    rst $00
    dw RenameMenu_ToEggServiceMenu
    dw RenameMenu_DrawFrame
    dw RenameMenu_UpdateTwoChoiceCursor_Bank1D
    dw RenameMenu_DrawNameList
    dw RenameMenu_ToRenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc
    dw RenameMenu_LoadSRAMRecordByte
    dw RenameMenu_PickMonster

; entry 0 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
RenameMenu_ToEggServiceMenu::
Jump_00D_516B:: ; address name
    farcall EggServiceMenu
    ret

; by wScreenStep: loads four frame tiles and copies a rectangle
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RenameMenu_DrawFrame::
Jump_00D_5172:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw LoadFourFrameTilesAndStep
    dw RenameMenu_DrawFrame_CopyRectTo20ByteRows_Bank0D

; copies four tiles from bank $1F to vTiles1 + $700-$730, then wScreenStep += 1 (E-0124)
; 1 call site from 1 routine (e.g. RenameMenu_PickMonster_LoadFourFrameTilesAndStep)
; reads: wScreenStep
; writes: wScreenStep
LoadFourFrameTilesAndStep::
Func_00D_517A:: ; address name
    ld de, Tiles1Plus700Tiles_1F_4210
    ld hl, vTiles1 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus710Tiles_1F_4120
    ld hl, vTiles1 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles2Plus230Tiles_1F_4190
    ld hl, vTiles1 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles1 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RenameMenu_DrawFrame
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScreenState
RenameMenu_DrawFrame_CopyRectTo20ByteRows_Bank0D::
Jump_00D_51B6:: ; address name
    ld de, TileRect_0D_550A
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
RenameMenu_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_51E2:: ; address name
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
    cp a, $01
    jr z, .loop
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: a rectangle, a cleared string window and the record list name tiles
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RenameMenu_DrawNameList::
Jump_00D_5221:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RenameMenu_DrawNameList_CopyScreenBufferRectWithAttrs_0D
    dw ClearStringWindowAt1500AndIncScreenStep
    dw RenameMenu_DrawNameList_LoadRecordListNameTiles

; entry 0 of the `rst $00` table in RenameMenu_DrawNameList
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RenameMenu_DrawNameList_CopyScreenBufferRectWithAttrs_0D::
Jump_00D_522B:: ; address name
    ld de, TileRect_0D_552E
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank0D
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; sets the string window to tile destination vTiles1 + $500 and size word $0F01, then FillTilesFromRequest (clears it); then wScreenStep += 1 (E-0117)
; 1 call site from 1 routine (e.g. RenameMenu_PickMonster_LoadFourFrameTilesAndStep)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
ClearStringWindowAt1500AndIncScreenStep::
Func_00D_525F:: ; address name
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0F01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RenameMenu_DrawNameList
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
RenameMenu_DrawNameList_LoadRecordListNameTiles::
Jump_00D_5280:: ; address name
    call LoadRecordListNameTiles
    ld de, TileRect_0D_5576
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 4 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
RenameMenu_ToRenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc::
Jump_00D_52A7:: ; address name
    call RenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc
    ret

; entry 5 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, hTemp0, hTemp1, wArg5, wScreenState
; writes: rRAMG2, rRAMB, wArg2, wArg3, wArg4, wArg5, wSelectedRecord, wArg1, ...
; points at: wPartyList
RenameMenu_LoadSRAMRecordByte::
Jump_00D_52AB:: ; address name
    ld a, [wGridCursorX]
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, MON_SEX
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wArg2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $1F
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
    cp a, $FF
    ret nz
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: frame tiles, the record and 'Pick the monster to rename.'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RenameMenu_PickMonster::
Jump_00D_530F:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RenameMenu_PickMonster_DecompressToVRAM
    dw RenameMenu_PickMonster_LoadFourFrameTilesAndStep
    dw RenameMenu_PickMonster_SRAMRecordAddress
    dw RenameMenu_PickMonster_ShowPickTheMonsterTo
    dw RenameMenu_PickMonster_LoadPlayerAndFollowerSpriteGraphics

; entry 0 of the `rst $00` table in RenameMenu_PickMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
RenameMenu_PickMonster_DecompressToVRAM::
Jump_00D_531D:: ; address name
    ld hl, vTiles2
    ld de, Map13Tileset
    ld b, $49
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, BGPaletteBufferData_49_4AC5
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RenameMenu_PickMonster
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
RenameMenu_PickMonster_LoadFourFrameTilesAndStep::
Jump_00D_5342:: ; address name
    call LoadFourFrameTilesAndStep
    call ClearStringWindowAt1500AndIncScreenStep
    ld a, $02
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RenameMenu_PickMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: rRAMG2, rRAMB, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
; points at: wPartyList, wNameGlyphBuf
RenameMenu_PickMonster_SRAMRecordAddress::
Jump_00D_534E:: ; address name
    ld a, [wGridCursorX]
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld de, wNameGlyphBuf
    ld c, $00

.loop:
    ld a, [de]
    cp a, $F0
    jr z, .skip
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop
    jr .call_load_record_list_name_tiles

.skip:
    ld a, $F0
    ld [hl], a

.call_load_record_list_name_tiles:
    xor a, a
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

; entry 3 of the `rst $00` table in RenameMenu_PickMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wScreenStep
RenameMenu_PickMonster_ShowPickTheMonsterTo::
Jump_00D_53A4:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $23
    ld [wStringIndex], a ; '*: Pick the monster to rename.'
    farcall ShowString_BankF2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RenameMenu_PickMonster
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenStep, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
RenameMenu_PickMonster_LoadPlayerAndFollowerSpriteGraphics::
Jump_00D_53BB:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0D
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from RenameMenu_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RenameMenu_ToRenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenState, wPartyCount, wGridCursorX
; writes: wTwoChoiceCursor, wScreenState, wListCursor, wChoiceCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest, wNameEntryState, ...
RenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc::
Func_00D_5412:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_rename_menu_case04_sub01_read_grid
    bit 7, a
    jr nz, .call_rename_menu_case04_sub01_read_grid2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_01
    call RenameMenu_Case04_Sub01_WriteGridCursorY
    ret

.call_rename_menu_case04_sub01_read_grid:
    call RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03
    ld a, [wPartyCount]
    cp a, $02
    jr c, .check_party_count
    ld a, [wGridCursorX]
    and a, a
    jr nz, .set_grid_cursor_x

.check_party_count:
    ld a, [wPartyCount]
    dec a
    ld [wGridCursorX], a
    call RenameMenu_Case04_Sub01_WriteGridCursorY
    ret

.set_grid_cursor_x:
    dec a

.set_grid_cursor_x2:
    ld [wGridCursorX], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call RenameMenu_Case04_Sub01_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

.call_rename_menu_case04_sub01_read_grid2:
    call RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03
    ld a, [wPartyCount]
    dec a
    ld b, a
    ld a, [wGridCursorX]
    cp a, b
    jr c, .skip
    xor a, a
    ld [wGridCursorX], a
    call RenameMenu_Case04_Sub01_WriteGridCursorY
    ret

.skip:
    inc a
    jr .set_grid_cursor_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    ld [wNameEntryState], a
    ld [wNameEntrySubState], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from RenameMenu_Case04_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. RenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc)
; reads: wJoypadRepeatTimer, wGridCursorY, wGridCursorX
; writes: wGridCursorY
RenameMenu_Case04_Sub01_WriteGridCursorY::
Func_00D_54C1:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, RenameMenu_Case04_Sub01_ReadGridCursorX
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    cp a, $10
    jr c, RenameMenu_Case04_Sub01_ReadGridCursorX
    cp a, $18
    jr c, RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03
    xor a, a
    ld [wGridCursorY], a

; only called from RenameMenu_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc)
; reads: wGridCursorX
RenameMenu_Case04_Sub01_ReadGridCursorX::
Func_00D_54DB:: ; address name
    ld b, $BB
    jr RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D_ReadGridCursorX

; only called from RenameMenu_Case04_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. RenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc)
; reads: wGridCursorX
RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03::
Func_00D_54DF:: ; address name
    ld b, $C3
    jr RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D_ReadGridCursorX

; only called from RenameMenu_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RenameMenu_Case04_WriteTwoChoiceCursorAndScreenStateEtc)
; reads: wGridCursorX
RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D::
Func_00D_54E3:: ; address name
    ld b, $BC

RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D_ReadGridCursorX::
Jump_00D_54E5:: ; address name
    ld a, [wGridCursorX]
    sla a
    ld hl, RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D_Data
    add_a_to_hl
    ld a, [hl+]
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

; address loaded by RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D
RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5504:: ; address name
    db $61, $00, $A1, $00, $E1, $00

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0D_550A::
Data_00D_550A:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A5, $F3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4
    db $A1, $C3, $C9, $C3, $F1, $C3

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 9 tiles, one row per line
TileRect_0D_552E::
Data_00D_552E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $F0, $F1, $F2, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 9 tiles, one row per line
TileRect_0D_5576::
Data_00D_5576:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $F0, $F1, $F2, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; implements script command type F2 (SCRIPT_KEY_APPRAISAL): Magic Key appraisal: 'Which Magic Key should I appraise?', 'Appraisal will cost 0G. OK?' (mode 7, bank $0D strings); reached through ScriptCommandF2 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF2)
; reads: wScreenState
KeyAppraisalMenu::
Func_00D_55BE:: ; address name
    ld a, [wScreenState]
    rst $00
    dw KeyAppraisalMenu_CopyBytesDEToHL_Bank0D
    dw KeyAppraisalMenu_DrawGoldBox
    dw KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D
    dw KeyAppraisalMenu_ChooseKey

; entry 0 of the `rst $00` table in KeyAppraisalMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
KeyAppraisalMenu_CopyBytesDEToHL_Bank0D::
Jump_00D_55CA:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
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
    ld de, Tiles1Plus4A0Tiles_1F_4AD0
    ld hl, vTiles1 + $4A0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: the gold box and a rectangle
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
KeyAppraisalMenu_DrawGoldBox::
Jump_00D_5633:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw DrawGoldBoxAndStep
    dw KeyAppraisalMenu_DrawGoldBox_CopyRectTo20ByteRows_Bank0D

; copies box Data_00D_4FBD to wWindowTileBuffer + $70 and writes the gold as five digit tiles at wWindowTileBuffer + $86, then wScreenStep += 1 (E-0124)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics_Case10)
; reads: wGoldLo, wGoldMid, wGoldHi, wScreenStep
; writes: wDigits, wScreenStep
; points at: wArg3
DrawGoldBoxAndStep::
Func_00D_563B:: ; address name
    ld de, TileRect_0D_4FBD
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
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
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in KeyAppraisalMenu_DrawGoldBox
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScreenState
KeyAppraisalMenu_DrawGoldBox_CopyRectTo20ByteRows_Bank0D::
Jump_00D_567D:: ; address name
    ld de, TileRect_0D_6189
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in KeyAppraisalMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState, wScreenStep
KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_56A9:: ; address name
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    call KeyAppraisalMenu_HasAnyKey
    cp a, $FF
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
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
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; A = 0 when one of the 32 key entries is not $FF, else $FF
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D)
KeyAppraisalMenu_HasAnyKey::
Func_00D_5702:: ; address name
    ld c, $00

.loop:
    ld a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FF
    jr nz, .return_0
    inc c
    ld a, c
    cp a, $20
    jr c, .loop
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; KeyAppraisalMenu screen state 3, by wScreenStep: the paged key list (BuildKeyListIndexListEntries), a two-choice confirmation and saving
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
KeyAppraisalMenu_ChooseKey::
Jump_00D_5722:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw KeyAppraisalMenu_ChooseKey_BuildKeyListIndexListEntries
    dw KeyAppraisalMenu_ChooseKey_FillTilesFromRequest
    dw KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor
    dw KeyAppraisalMenu_ChooseKey_DrawKeyListPageNames
    dw KeyAppraisalMenu_ChooseKey_BGMapAddressAtScroll_Bank0D
    dw KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor
    dw KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D
    dw KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D
    dw KeyAppraisalMenu_ChooseKey_EraseCEntriesOfWordTable_Bank0D
    dw KeyAppraisalMenu_ChooseKey_ToCopyRect70C5ToWC364AndDrawAndStep
    dw KeyAppraisalMenu_ChooseKey_ShowSaveFileInfoWindow
    dw KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep
    dw KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D
    dw KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D_Case0D
    dw KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_7347
    dw KeyAppraisalMenu_ChooseKey_BlankTwoTilePairsAndDraw
    dw KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics_Case10
    dw KeyAppraisalMenu_ChooseKey_CountKeys_Case11
    dw KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics

; entry 18 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics::
Jump_00D_574C:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
KeyAppraisalMenu_ChooseKey_BuildKeyListIndexListEntries::
Jump_00D_5766:: ; address name
    ld de, TileRect_0D_61A7
    ld hl, wWindowTileBuffer + $B8
    ld bc, $1009
    call CopyRectTo20ByteRows_Bank0D
    call BuildKeyListIndexListEntries
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
KeyAppraisalMenu_ChooseKey_FillTilesFromRequest::
Jump_00D_5789:: ; address name
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
    ld hl, $0C01
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
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $6E0
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

; entry 2 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg5, wArg1, wArg2, wScreenStep
KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor::
Jump_00D_57F5:: ; address name
    ld de, TileRect_0D_6237
    ld hl, wWindowTileBuffer + $CE
    ld bc, $0D07
    call CopyRectTo20ByteRows_Bank0D
    xor a, a
    ld [wArg5], a
    call ClampKeyListPageCursor
    ld a, [wListPages]
    cp a, $02
    jr c, .read_list_cursor
    ld de, $018E
    call DrawC5BEC6AtScrollOffsetDE_Bank0D
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
    ld de, $018F
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
    ld b, $BB
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
KeyAppraisalMenu_ChooseKey_DrawKeyListPageNames::
Jump_00D_585C:: ; address name
    xor a, a
    ld [wArg5], a
    call DrawKeyListPageNames
    xor a, a
    ld [wArg5], a
    call DrawKeyListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
KeyAppraisalMenu_ChooseKey_BGMapAddressAtScroll_Bank0D::
Jump_00D_5872:: ; address name
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wListCursor]
    ld b, $C3
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wArg5, wArg6, wListCursor, wScreenStep
; writes: wMenuInputResult, wTwoChoiceCursor, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest, ...
; points at: wTextBuf0
KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor::
Jump_00D_5891:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, .call_key_appraisal_menu_choose_key_case05
    ld a, $03
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FE
    jr z, .set_two_choice_cursor_to_02
    cp a, $FF
    jr z, .call_set_arg5_to_list_entries_cell4
    ret

.call_key_appraisal_menu_choose_key_case05:
    farcall KeyAppraisalMenu_ChooseKey_Case05_CopyWD09EToKeyList
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
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
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FE
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $BC
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank0D
    ld de, wTextBuf0
    ld a, $01
    call KeyAppraisalMenu_ChooseKey_WriteDigits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
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

; entry 7 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArg1, wScreenStep
; writes: wArg1, wArg2, wArg3, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep, wScreenSubStep, ...
KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_595C:: ; address name
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
    call KeyAppraisalMenu_ChooseKey_Case07_StoreC5BEC6AtHLStride2_Bank0D
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    xor a, a
    call KeyAppraisalMenu_ChooseKey_WriteDigits
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, .call_key_appraisal_menu_choose_key_case07
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_key_appraisal_menu_choose_key_case07:
    call KeyAppraisalMenu_ChooseKey_Case07_StoreC5BEC6AtHLStride2_Bank0D
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from KeyAppraisalMenu_ChooseKey_Case07 (E-0047)
; 2 call sites from 1 routine (e.g. KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D)
; reads: wListPages
; writes: wArg1, wArg2
KeyAppraisalMenu_ChooseKey_Case07_StoreC5BEC6AtHLStride2_Bank0D::
Func_00D_5A05:: ; address name
    ld de, TileRect_0D_6292
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wListPages]
    cp a, $02
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
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; entry 9 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
KeyAppraisalMenu_ChooseKey_ToCopyRect70C5ToWC364AndDrawAndStep::
Jump_00D_5A3C:: ; address name
    farcall CopyRect70C5ToWC364AndDraw
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wScreenStep
KeyAppraisalMenu_ChooseKey_ShowSaveFileInfoWindow::
Jump_00D_5A4A:: ; address name
    farcall ShowSaveFileInfoWindow
    xor a, a
    ld [wStringCategory], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wTextFlags, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenSubStep, wScreenStep, wScriptCommandType, wScriptStartRequest, ...
KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep::
Jump_00D_5A5C:: ; address name
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ld a, [wScreenSubStep]
    cp a, $02
    jr z, .set_string_index_to_0B
    cp a, $03
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
    ld a, $0B
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0D
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep
KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D::
Jump_00D_5AB4:: ; address name
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ld de, TileRect_0D_6189
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_ChooseKey_EraseCEntriesOfWordTable_Bank0D::
Jump_00D_5AE3:: ; address name
    ld c, $04
    ld hl, KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data
    call EraseCEntriesOfWordTable_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $05
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D_Case0D::
Jump_00D_5B06:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ret

.loop:
    call BlankTwoTilePairsAndDraw
    ld a, [wScreenStep]
    add a, $05
    ld [wScreenStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wSaveStep, wScreenStep, wArg5, wArg6
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep, wScriptCommandType, wScriptByte68, wScriptStartRequest, wSaveStep, wSaveRecordIndex, ...
KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_7347::
Jump_00D_5B4A:: ; address name
    call KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB
    ld a, [wScreenSubStep]
    and a, a
    jr z, .clear_save_step
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptByte68], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_save_step:
    xor a, a
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
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    xor a, a
    ld [hl], a
    xor a, a
    call KeyAppraisalMenu_ChooseKey_WriteDigits
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall SubtractArg1AmountFromGold
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 15 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wScreenStep
; points at: wTextBuf0
KeyAppraisalMenu_ChooseKey_BlankTwoTilePairsAndDraw::
Jump_00D_5BBF:: ; address name
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

; entry 16 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, wArg1, wArg2, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_ChooseKey_LoadPlayerAndFollowerSpriteGraphics_Case10::
Jump_00D_5BDF:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wArg1], a
    ld a, $14
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    call DrawGoldBoxAndStep
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in KeyAppraisalMenu_ChooseKey
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_ChooseKey_CountKeys_Case11::
Jump_00D_5C17:: ; address name
    call KeyAppraisalMenu_ChooseKey_CountKeys
    cp a, $FF
    jr nz, .set_two_choice_cursor_to_01
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $03
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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

; writes $C3 to wWindowTileBuffer + $B0-wWindowTileBuffer + $B1 and wWindowTileBuffer + $C4-wWindowTileBuffer + $C5, then DrawScreenBufferRect_Bank0D (20 x 13 at the scroll origin) (E-0119)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_BlankTwoTilePairsAndDraw, KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D_Case0D)
BlankTwoTilePairsAndDraw::
Func_00D_5C47:: ; address name
    ld a, $C3
    ld hl, wWindowTileBuffer + $B0
    ld [hl+], a
    ld [hl], a
    ld hl, wWindowTileBuffer + $C4
    ld [hl+], a
    ld [hl], a
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; counts the wKeyList entries that are not $FF, up to a $FE end (A = $FF at the end)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_ChooseKey_CountKeys_Case11)
; points at: wKeyList
KeyAppraisalMenu_ChooseKey_CountKeys::
Func_00D_5C60:: ; address name
    ld hl, wKeyList
    ld c, $00
    ld b, $00

.loop:
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, .done
    cp a, $FF
    jr z, .restore
    inc b

.restore:
    pop hl
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $20
    jr c, .loop
    xor a, a
    ret

.done:
    pop hl
    ld a, $FF
    ret

; wListPages = the number of 4-entry pages of wListCount keys; clamps the page wListPageIndex and the cursor wListCursor to the last page's size (wListLastRow) (E-0127)
; 3 call sites from 3 routines (e.g. KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor, LinkKeyTrade_ClampKeyListPageCursor)
; reads: wListCount, wListPageIndex, wListCursor
; writes: wListPages, wListPageIndex, wListLastRow, wListCursor
ClampKeyListPageCursor::
Func_00D_5C87:: ; address name
    ld a, [wListCount]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, .set_list_pages
    inc l

.set_list_pages:
    ld a, l
    ld [wListPages], a
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr c, .set_list_last_row_to_03
    pop af
    push af
    and a, a
    jr nz, .set_list_last_row
    ld a, [wListPageIndex]
    inc a
    cp a, l
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
    cp a, b
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

; writes blank $C3 at the scroll position + the cursor offset for wListCursor from table Data_00D_5D0E, 5D16 or 5D1E (by wArg5) (E-0125)
; 1 call site from 1 routine (e.g. ClampKeyListPageCursor)
; reads: wArg5, wListCursor
EraseCursorForArg5Layout::
Func_00D_5CD9:: ; address name
    ld b, $C3
    ld a, [wArg5]
    and a, a
    jr z, .read_list_cursor
    cp a, $01
    jr z, .skip
    ld hl, EraseCursorForArg5Layout_Data_5D1E
    jr .read_list_cursor2

.skip:
    ld hl, EraseCursorForArg5Layout_Data_5D16
    jr .read_list_cursor2

.read_list_cursor:
    ld hl, EraseCursorForArg5Layout_Data_5D0E

.read_list_cursor2:
    ld a, [wListCursor]
    sla a
    add_a_to_hl
    ld a, [hl+]
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

; address loaded by EraseCursorForArg5Layout
EraseCursorForArg5Layout_Data_5D0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5D0E:: ; address name
    db $A6, $00, $C6, $00, $E6, $00, $06, $01

; address loaded by EraseCursorForArg5Layout
EraseCursorForArg5Layout_Data_5D16:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5D16:: ; address name
    db $A4, $00, $C4, $00, $E4, $00, $04, $01

; address loaded by EraseCursorForArg5Layout
EraseCursorForArg5Layout_Data_5D1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5D1E:: ; address name
    db $A2, $00, $C2, $00, $E2, $00, $02, $01

; blanks the four mark positions and draws marks for the keys on the current page of wListEntries (E-0130)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_DrawKeyListPageNames, LinkKeyTrade_DrawKeyListPageNames)
; reads: wArg5, wListPageIndex, wListLastRow, wListCount, wListPages
; points at: wListEntries, wKeyList
DrawKeyListPageMarks::
Func_00D_5D26:: ; address name
    ld a, [wArg5]
    and a, a
    jr nz, .skip
    ld de, DrawKeyListPageMarks_Data_5DDD
    jr .skip2

.skip:
    ld de, DrawKeyListPageMarks_Data_5DE5

.skip2:
    ld b, $04

.loop:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, $C3
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
    cp a, $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp a, $01
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
    add a, c
    cp a, b
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
    cp a, $FE
    jr z, .restore
    cp a, $FF
    jr z, .restore
    bit 6, a
    jr z, .check_arg5
    ld b, $CA
    jr .check_arg52

.check_arg5:
    ld b, $C3

.check_arg52:
    ld a, [wArg5]
    and a, a
    jr nz, .skip3
    ld de, DrawKeyListPageMarks_Data_5DDD
    jr .skip4

.skip3:
    ld de, DrawKeyListPageMarks_Data_5DE5
    ld a, b
    cp a, $C3
    jr z, .skip4
    ld b, $70

.skip4:
    ld a, c
    sla a
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
    cp a, c
    jr z, .return
    ld a, c
    cp a, $04
    jp c, .loop2

.return:
    ret

; address loaded by DrawKeyListPageMarks
DrawKeyListPageMarks_Data_5DDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5DDD:: ; address name
    db $CD, $C3, $F5, $C3, $1D, $C4, $45, $C4

; address loaded by DrawKeyListPageMarks
DrawKeyListPageMarks_Data_5DE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_5DE5:: ; address name
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

; for the keys on the current page writes their names to wNameGlyphBuf and draws them; generated keys (kind $FE) are shown as "Magic Key" (E-0130)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_DrawKeyListPageNames, LinkKeyTrade_DrawKeyListPageNames)
; reads: wListPageIndex, wListLastRow, wListCount, wDataBank, wListPages
; writes: wDataBank, wNameGlyphBuf
; points at: wListEntries, wKeyList, wNameGlyphBuf
DrawKeyListPageNames::
Func_00D_5DED:: ; address name
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp a, $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp a, $01
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
    add a, c
    cp a, b
    jp nc, .return
    push hl
    push bc
    ld a, [hl]
    sla a
    sla a
    ld de, wKeyList
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, $FE
    jr nz, .next
    ld hl, wNameGlyphBuf
    ld a, $16
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $2A
    ld [hl+], a
    ld a, $2C
    ld [hl+], a
    ld a, $26
    ld [hl+], a
    ld a, $90
    ld [hl+], a
    ld a, $14
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $3C
    ld [hl+], a
    ld a, $5B
    ld [hl+], a
    ld a, $F0
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
    and a, $3F
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, StringCategories_09_4016
    ld a, $0C
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
    ld a, $F0
    ld [wNameGlyphBuf + $D], a
    jr .call_draw_name_glyph_buf_glyphs_overlaying8_d

.call_write_key_name_to_de:
    ld a, [hl]
    ld de, wNameGlyphBuf
    call WriteKeyNameToDE
    ld a, $5B
    ld [de], a
    inc de
    ld a, $F0
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
    cp a, c
    jr z, .return
    ld a, c
    cp a, $04
    jp c, .loop

.return:
    ret

; draws the $F0-terminated text at wNameGlyphBuf glyph by glyph; marks $8D and $8E are ORed onto the previous tile instead of taking a new one (E-0125)
; 2 call sites from 2 routines (e.g. DrawKeyListPageNames, MedalPrizeMenu_ChoosePrize_Case03_ReadListPageIndexAndListLastRowEtc)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
DrawNameGlyphBufGlyphsOverlaying8DAnd8E::
Func_00D_5ED6:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, .clear_glyph_list_start
    cp a, $8D
    jr z, .check_glyph_list_start
    cp a, $8E
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
    xor a, a
    ld [wGlyphListStart], a
    ld [wGlyphListPos], a
    ret

; only called from DrawNameGlyphBufGlyphsOverlaying8DAnd8E (E-0047)
; 2 call sites from 1 routine (e.g. DrawNameGlyphBufGlyphsOverlaying8DAnd8E)
; reads: wArg5, wGlyphListStart
DrawNameGlyphBufGlyphsOverlaying8DAnd8E_ReadArg5AndGlyphListStart::
Func_00D_5F2C:: ; address name
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
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wArg5]
    and a, a
    jr z, .skip3
    cp a, $01
    jr z, .skip2
    cp a, $02
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
    ld a, [wGlyphListStart]
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

; E-0235 (C1: the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 0).
; record: list of VRAM tile addresses
GlyphTileDestTable0::
Data_00D_5F89:: ; address name
    dw GlyphTileDests0_0 ; id 0
    dw GlyphTileDests0_1 ; id 1
    dw GlyphTileDests0_2 ; id 2
    dw GlyphTileDests0_3 ; id 3

; E-0235 (C1: list 0 of GlyphTileDestTable0; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests0_0::
Data_00D_5F91:: ; address name
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580, vTiles1 + $590, vTiles1 + $5A0, vTiles1 + $5B0

; E-0235 (C1: list 1 of GlyphTileDestTable0; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests0_1::
Data_00D_5FA9:: ; address name
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790, vTiles1 + $7A0, vTiles1 + $7B0

; E-0235 (C1: list 2 of GlyphTileDestTable0; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests0_2::
Data_00D_5FC1:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290 ; entry 0
    dw vTiles1 + $2A0, vTiles1 + $2B0, vTiles1 + $2C0, vTiles1 + $6E0, vTiles1 + $6F0, vTiles1 + $7C0

; E-0235 (C1: list 3 of GlyphTileDestTable0; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests0_3::
Data_00D_5FD9:: ; address name
    dw vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $2F0, vTiles1 + $7D0, vTiles1 + $7E0, vTiles1 + $7F0 ; entry 0
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750

; E-0235 (C1: the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 1).
; record: list of VRAM tile addresses
GlyphTileDestTable1::
Data_00D_5FF1:: ; address name
    dw GlyphTileDests1_0 ; id 0
    dw GlyphTileDests1_1 ; id 1
    dw GlyphTileDests1_2 ; id 2
    dw GlyphTileDests1_3 ; id 3

; E-0235 (C1: list 0 of GlyphTileDestTable1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests1_0::
Data_00D_5FF9:: ; address name
    dw vTiles1 + $240, vTiles1 + $250, vTiles1 + $260, vTiles1 + $270, vTiles1 + $280, vTiles1 + $290 ; entry 0
    dw vTiles1 + $2A0, vTiles1 + $2B0, vTiles1 + $2C0

; E-0235 (C1: list 1 of GlyphTileDestTable1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests1_1::
Data_00D_600B:: ; address name
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $580

; E-0235 (C1: list 2 of GlyphTileDestTable1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests1_2::
Data_00D_601D:: ; address name
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $780

; E-0235 (C1: list 3 of GlyphTileDestTable1; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests1_3::
Data_00D_602F:: ; address name
    dw vTiles1 + $590, vTiles1 + $5A0, vTiles1 + $5B0, vTiles1 + $5C0, vTiles1 + $5D0, vTiles1 + $5E0 ; entry 0
    dw vTiles1 + $790, vTiles1 + $7A0, vTiles1 + $7B0

; E-0235 (C1: the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 2).
; record: list of VRAM tile addresses
GlyphTileDestTable2::
Data_00D_6041:: ; address name
    dw GlyphTileDests2_0 ; id 0
    dw GlyphTileDests2_1 ; id 1
    dw GlyphTileDests2_2 ; id 2
    dw GlyphTileDests2_3 ; id 3

; E-0235 (C1: list 0 of GlyphTileDestTable2; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests2_0::
Data_00D_6049:: ; address name
    dw vTiles2 + $100, vTiles2 + $110, vTiles2 + $120, vTiles2 + $130, vTiles2 + $140, vTiles2 + $150 ; entry 0
    dw vTiles2 + $160, vTiles2 + $170, vTiles2 + $180, vTiles2 + $190, vTiles2 + $1A0, vTiles2 + $1B0

; E-0235 (C1: list 1 of GlyphTileDestTable2; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests2_1::
Data_00D_6061:: ; address name
    dw vTiles2 + $200, vTiles2 + $210, vTiles2 + $220, vTiles2 + $230, vTiles2 + $240, vTiles2 + $250 ; entry 0
    dw vTiles2 + $260, vTiles2 + $270, vTiles2 + $280, vTiles2 + $290, vTiles2 + $2A0, vTiles2 + $2B0

; E-0235 (C1: list 2 of GlyphTileDestTable2; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests2_2::
Data_00D_6079:: ; address name
    dw vTiles2 + $300, vTiles2 + $310, vTiles2 + $320, vTiles2 + $330, vTiles2 + $340, vTiles2 + $350 ; entry 0
    dw vTiles2 + $360, vTiles2 + $370, vTiles2 + $380, vTiles2 + $390, vTiles2 + $3A0, vTiles2 + $3B0

; E-0235 (C1: list 3 of GlyphTileDestTable2; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests2_3::
Data_00D_6091:: ; address name
    dw vTiles2 + $400, vTiles2 + $410, vTiles2 + $420, vTiles2 + $430, vTiles2 + $440, vTiles2 + $450 ; entry 0
    dw vTiles2 + $460, vTiles2 + $470, vTiles2 + $480, vTiles2 + $490, vTiles2 + $4A0, vTiles2 + $4B0

; E-0235 (C1: the routine ending at $5F86 picks this table by wArg5 (0, 1, 2, else $60A9), reads the word at 2 * C, then the word at 2 * wGlyphListStart of that list, and returns it as HL (a VRAM tile address) with DE = $4010 + 16 * glyph, B = $1F and C = $10 for a bank-$1F tile copy); wArg5 = 3 or more).
; record: list of VRAM tile addresses
GlyphTileDestTable3::
Data_00D_60A9:: ; address name
    dw GlyphTileDests3_0 ; id 0

; E-0235 (C1: list 0 of GlyphTileDestTable3; 12 words).
; record: VRAM tile addresses, indexed by wGlyphListStart
GlyphTileDests3_0::
Data_00D_60AB:: ; address name
    dw vTiles2 + $600, vTiles2 + $610, vTiles2 + $620, vTiles2 + $630, vTiles2 + $640, vTiles2 + $650 ; entry 0
    dw vTiles2 + $660, vTiles2 + $670, vTiles2 + $680, vTiles2 + $690, vTiles2 + $6A0, vTiles2 + $6B0

; clears wListEntries ($20 bytes), then lists the indexes of the used wKeyList entries there and stores their count in wListCount (E-0125)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_ChooseKey_BuildKeyListIndexListEntries, LinkKeyTrade_BuildKeyListIndexListEntries)
; writes: wListCount
; points at: wListEntries, wKeyList
BuildKeyListIndexListEntries::
Func_00D_60C3:: ; address name
    ld hl, wListEntries
    ld b, $20

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [wListCount], a
    ld de, wKeyList
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop2:
    ld a, [de]
    cp a, $FF
    jr z, .skip
    inc c
    ld a, b
    ld [hl+], a

.skip:
    ld a, $04
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp a, $20
    jr c, .loop2
    ld a, c
    ld [wListCount], a
    ret

; only called from KeyAppraisalMenu_ChooseKey_Shared01 (E-0047)
; 2 call sites from 1 routine (e.g. KeyAppraisalMenu_ChooseKey_WriteDigits)
; reads: wListPageIndex, wListCursor
; points at: wListEntries, wKeyList
KeyAppraisalMenu_ChooseKey_Shared01_ReadListPageIndexAndListCursor::
Func_00D_60F5:: ; address name
    ld hl, wListEntries
    ld a, [wListPageIndex]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [wListCursor]
    add_a_to_hl
    ld a, [hl]
    ld hl, wKeyList
    add a, a
    add a, a
    add_a_to_hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld c, $0A
    call Multiply8
    ret

; only called from routines of KeyAppraisalMenu_ChooseKey (E-0098)
; 3 call sites from 3 routines (e.g. KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_7347, KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D, KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor)
; writes: wDigits
; points at: wArg1
KeyAppraisalMenu_ChooseKey_WriteDigits::
Func_00D_6120:: ; address name
    and a, a
    jr nz, .call_key_appraisal_menu_choose_key_shared01
    call KeyAppraisalMenu_ChooseKey_Shared01_ReadListPageIndexAndListCursor
    ret

.call_key_appraisal_menu_choose_key_shared01:
    call KeyAppraisalMenu_ChooseKey_Shared01_ReadListPageIndexAndListCursor
    push de
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    pop de
    ld hl, wArg1
    ld c, $07

.loop:
    ld a, [hl]
    cp a, $E3
    jr nz, .loop2
    inc hl
    dec c
    jr nz, .loop
    xor a, a
    ld [de], a
    inc de
    jr .done

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .loop2

.done:
    ld a, $F0
    ld [de], a
    ret

; only called from routines of KeyAppraisalMenu_ChooseKey (E-0098)
; 5 call sites from 4 routines (e.g. KeyAppraisalMenu_ChooseKey_RunSaveGameSteps_7347, KeyAppraisalMenu_ChooseKey_UpdateTwoChoiceCursor_Bank1D_Case0D, KeyAppraisalMenu_ChooseKey_DrawBottomBoxForLinkAndSetScreenSubStep, KeyAppraisalMenu_ChooseKey_CopyRectTo20ByteRows_Bank0D)
; reads: wScreenStep
; writes: rRAMG2, rRAMB
; points at: sSavedPlayerName
KeyAppraisalMenu_ChooseKey_WriteRAMG2AndRAMB::
Func_00D_615E:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sSavedPlayerName
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, .check_screen_step

.loop:
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $0B
    jr c, .loop
    farcall DrawSpritePart9000At88_28
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0D_6189::
Data_00D_6189:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $76, $77, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 16 x 9 tiles, one row per line
TileRect_0D_61A7::
Data_00D_61A7:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 7 tiles, one row per line
TileRect_0D_6237::
Data_00D_6237:: ; address name
    db $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $EE, $EF, $FC ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $AD, $AE, $AF, $FD, $FE, $FF, $70, $71, $72, $73, $74, $75 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0D_6292::
Data_00D_6292:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 0
    db $AB, $AC, $EE, $EF, $FC, $B7 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $71, $72, $73, $74, $75, $B7 ; id 3
    db $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor, KeyAppraisalMenu_ChooseKey_BGMapAddressAtScroll_Bank0D, KeyAppraisalMenu_ChooseKey_UpdatePagedListCursor, KeyAppraisalMenu_ChooseKey_EraseCEntriesOfWordTable_Bank0D
KeyAppraisalMenu_ChooseKey_ClampKeyListPageCursor_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_62B0:: ; address name
    db $CE, $C3, $F6, $C3, $1E, $C4, $46, $C4

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_0D_62B8:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_APPRAISAL
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_62CA, Script_0D_62C4, Script_0D_62BE
Script_0D_62BE:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8002 ; 'Okay. Come back if you find'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_0D_62C4:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8003 ; '*: Don't come if you have'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_0D_62CA:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'Which key should I appraise?'
Script_0D_62CD:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_62DE, Script_0D_62D5, Script_0D_62D2
Script_0D_62D2:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0D_62BE
Script_0D_62D5:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; '*: That key's been appraised already.'
    script_message $C008 ; '*: Which Magic Key should I'
    script_jump Script_0D_62CD
Script_0D_62DE:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; '*: Appraisal will cost 0G. OK?'
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_62F3, Script_0D_62ED, Script_0D_62E6
Script_0D_62E6:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; '*: Which Magic Key should I'
    script_command SCRIPT_KEY_APPRAISAL
    script_jump Script_0D_62CD
Script_0D_62ED:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8007 ; '*: Hah? I'm not appraising any'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_0D_62F3:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_APPRAISAL
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_62FB, Script_0D_62F8
Script_0D_62F8:: ; heuristic: event script entry or jump target; C0
    script_jump Script_0D_62BE
Script_0D_62FB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_APPRAISAL
    script_command SCRIPT_KEY_APPRAISAL
    script_message $C00F ; '*: Let's see the Magic Key,'
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_630A, Script_0D_6304
Script_0D_6304:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; '*: You have no more Magic'
    script_jump Script_0D_62BE
Script_0D_630A:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; '*: Which Magic Key should I'
    script_jump Script_0D_62CD

; implements script command type F3 (SCRIPT_MEDAL_PRIZES): the TinyMedal prize exchange: 'Which prize do you want?', 'I'll trade for 0 TinyMedals. OK?' (mode 7); reached through ScriptCommandF3 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF3)
; reads: wScreenState
MedalPrizeMenu::
Func_00D_6310:: ; address name
    ld a, [wScreenState]
    rst $00
    dw MedalPrizeMenu_CopyBytesDEToHL_Bank0D
    dw MedalPrizeMenu_CountItem2C_Case01
    dw MedalPrizeMenu_WriteScreenStateAndTwoChoiceCursorEtc
    dw MedalPrizeMenu_DrawCountBox
    dw MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D
    dw MedalPrizeMenu_ChoosePrize

; entry 2 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaWinsHi, wArenaWinsLo, wScreenState
; writes: wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextBuf0, wDigits
MedalPrizeMenu_WriteScreenStateAndTwoChoiceCursorEtc::
Jump_00D_6320:: ; address name
    ld a, [wArenaWinsHi]
    and a, a
    jr nz, .read_arena_wins_lo
    ld a, [wArenaWinsLo]
    and a, a
    jr z, .set_two_choice_cursor_to_01
    cp a, $01
    jr z, .set_two_choice_cursor_to_01
    cp a, $02
    jr z, .set_two_choice_cursor_to_01
    jr .read_arena_wins_lo

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_arena_wins_lo:
    ld a, [wArenaWinsLo]
    ld l, a
    ld a, [wArenaWinsHi]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld hl, wTextBuf0
    ld de, wDigits
    ld a, [de]
    cp a, $E3
    jr z, .next
    ld [hl+], a

.next:
    inc de
    ld a, [de]
    cp a, $E3
    jr z, .next2
    ld [hl+], a

.next2:
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, $F0
    ld [hl], a
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

; entry 1 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaWinsLo, wArenaWinsHi, wScreenState
; writes: wTwoChoiceCursor, wScreenState, wScriptCommandType, wScriptStartRequest, wArenaWinsHi, wArenaWinsLo
; points at: wInventory
MedalPrizeMenu_CountItem2C_Case01::
Jump_00D_6384:: ; address name
    call MedalPrizeMenu_CountItem2C
    push af
    ld a, [wArenaWinsLo]
    ld l, a
    ld a, [wArenaWinsHi]
    ld h, a
    pop af
    cp a, $FF
    jr nz, .skip
    jr .skip3

.skip:
    push af
    add_a_to_hl
    ld a, h
    cp a, $03
    jr c, .restore
    jr nz, .skip2
    ld a, l
    cp a, $E8
    jr c, .restore

.skip2:
    ld a, l
    sub a, $E7
    ld l, a
    ld a, h
    sbc a, $03
    ld h, a
    pop af
    ld b, a
    ld a, l
    sub a, b
    ld b, a
    and a, a
    jr z, .set_arena_wins_hi_to_03
    ld hl, wInventory
    ld c, $00
    call MedalPrizeMenu_RemoveItem2C

.set_arena_wins_hi_to_03:
    ld a, $03
    ld [wArenaWinsHi], a
    ld a, $E7
    ld [wArenaWinsLo], a

.skip3:
    ld a, $01
    jr .set_two_choice_cursor

.restore:
    pop af
    ld b, a
    ld a, l
    ld [wArenaWinsLo], a
    ld a, h
    ld [wArenaWinsHi], a
    ld hl, wInventory
    ld c, $00
    call MedalPrizeMenu_RemoveItem2C
    xor a, a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; clears B inventory slots that hold item $2C, then compacts the inventory
; 2 call sites from 1 routine (e.g. MedalPrizeMenu_CountItem2C_Case01)
; points at: wInventory
MedalPrizeMenu_RemoveItem2C::
Func_00D_63F6:: ; address name
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, .restore
    xor a, a
    ld [hl], a
    pop bc
    pop hl
    push hl
    push bc
    dec b
    ld a, b
    and a, a
    jr nz, .restore
    pop hl
    pop bc
    jr .skip
    db $C9

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, MedalPrizeMenu_RemoveItem2C

.skip:
    ld hl, wInventory
    ld de, wInventory + $1
    ld b, $17

.loop:
    ld a, [hl]
    and a, a
    jr z, .loop2
    inc hl
    inc de
    dec b
    jr nz, .loop
    ret

.loop2:
    ld a, [de]
    and a, a
    jr nz, .skip2
    inc de
    dec b
    jr nz, .loop2
    ret

.skip2:
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; entry 0 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenState
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
MedalPrizeMenu_CopyBytesDEToHL_Bank0D::
Jump_00D_643A:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
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
    xor a, a
    call MedalPrizeMenu_CountItem2C
    cp a, $FF
    jr z, .set_two_choice_cursor_to_01
    xor a, a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; by wScreenStep: copies tiles and draws the count box (DrawArenaWinsLoCountBoxAndStep)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
MedalPrizeMenu_DrawCountBox::
Jump_00D_649C:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw MedalPrizeMenu_DrawCountBox_CopyFromBankWaitVRAM
    dw DrawArenaWinsLoCountBoxAndStep
    dw MedalPrizeMenu_DrawCountBox_CopyRectTo20ByteRows_Bank0D

; entry 0 of the `rst $00` table in MedalPrizeMenu_DrawCountBox
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
MedalPrizeMenu_DrawCountBox_CopyFromBankWaitVRAM::
Jump_00D_64A6:: ; address name
    ld de, Tiles2Plus240Tiles_1F_4170
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2E0Tiles_1F_4280
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus2F0Tiles_1F_4250
    ld hl, vTiles1 + $2F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7C0Tiles_1F_4300
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7D0Tiles_1F_4A40
    ld hl, vTiles1 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies box Data_00D_6EB7 to wWindowTileBuffer + $6D and writes the word wArenaWinsLo as three digits (leading blanks) at wWindowTileBuffer + $88, then wScreenStep += 1 (E-0124)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0D)
; reads: wArenaWinsLo, wArenaWinsHi, wScreenStep
; writes: wScreenStep
; points at: wDigits
DrawArenaWinsLoCountBoxAndStep::
Func_00D_6509:: ; address name
    ld de, TileRect_0D_6EB7
    ld hl, wWindowTileBuffer + $6D
    ld bc, $0B03
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wArenaWinsLo]
    ld l, a
    ld a, [wArenaWinsHi]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld hl, wWindowTileBuffer + $88
    ld de, wDigits
    ld c, $00

.loop:
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $03
    jr c, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in MedalPrizeMenu_DrawCountBox
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScreenState
MedalPrizeMenu_DrawCountBox_CopyRectTo20ByteRows_Bank0D::
Jump_00D_6541:: ; address name
    ld de, TileRect_0D_6189
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 4 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenState
; writes: wArg1, wArg2, wTwoChoiceCursor, wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_656D:: ; address name
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
    cp a, $01
    jr z, .loop
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; MedalPrizeMenu screen state 5, by wScreenStep: a paged list with a cursor and a two-choice confirmation
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
MedalPrizeMenu_ChoosePrize::
Jump_00D_65D0:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D
    dw MedalPrizeMenu_ChoosePrize_FillTilesFromRequest
    dw MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor
    dw MedalPrizeMenu_ChoosePrize_WriteArg5AndScreenStep
    dw MedalPrizeMenu_ChoosePrize_BGMapAddressAtScroll_Bank0D
    dw MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor
    dw MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor_Case06
    dw MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc
    dw MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Case08
    dw MedalPrizeMenu_ChoosePrize_UpdateTwoChoiceCursor_Bank1D
    dw MedalPrizeMenu_ChoosePrize_EraseCEntriesOfWordTable_Bank0D
    dw MedalPrizeMenu_ChoosePrize_WriteScreenStepAndScriptCommandTypeEtc
    dw MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4
    dw MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0D
    dw MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E

; entry 0 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D::
Jump_00D_65F2:: ; address name
    ld de, TileRect_0D_6ED8
    ld hl, wWindowTileBuffer + $B7
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0D
    call MedalPrizeMenu_ChoosePrize_Case00_WriteListCount
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
MedalPrizeMenu_ChoosePrize_FillTilesFromRequest::
Jump_00D_6615:: ; address name
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
    ld hl, $0F01
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
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wListPageIndex, wListPages, wListCursor, wScreenStep, wArenaByte37
; writes: wArg5, wScreenStep
MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor::
Jump_00D_6668:: ; address name
    ld a, [wListPageIndex]
    and a, a
    jr nz, .check_arena_byte37
    ld de, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_6F71
    jr .call_copy_rect_to20_byte_rows_bank0_d

.loop:
    ld de, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7043
    jr .call_copy_rect_to20_byte_rows_bank0_d

.check_arena_byte37:
    ld a, [wArenaByte37]
    and a, a
    jr nz, .loop
    ld de, TileRect_0D_6FDA

.call_copy_rect_to20_byte_rows_bank0_d:
    ld hl, wWindowTileBuffer + $CC
    ld bc, $0F07
    call CopyRectTo20ByteRows_Bank0D
    ld a, $01
    ld [wArg5], a
    call ClampKeyListPageCursor
    ld a, [wListPages]
    cp a, $02
    jr c, .read_list_cursor
    call MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $BB
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7106
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
MedalPrizeMenu_ChoosePrize_WriteArg5AndScreenStep::
Jump_00D_66BB:: ; address name
    ld a, $01
    ld [wArg5], a
    call MedalPrizeMenu_ChoosePrize_Case03_ReadListPageIndexAndListLastRowEtc
    call MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
MedalPrizeMenu_ChoosePrize_BGMapAddressAtScroll_Bank0D::
Jump_00D_66CE:: ; address name
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wListCursor]
    ld b, $C3
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7106
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wTwoChoiceCursor, wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep, ...
; points at: wTextBuf0
MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor::
Jump_00D_66ED:: ; address name
    ld b, $BB
    call WriteTileBAtCursorListCursor
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    cp a, $01
    jr c, .set_two_choice_cursor
    ld a, $01

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    cp a, $01
    jr z, .skip
    add a, $22
    ld [wStringIndex], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.skip:
    ld a, [hl]
    add a, $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, StringCategories_0D_4016
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wTextBuf0
    ld c, $00

.skip2:
    ld a, [de]
    cp a, $F0
    jr z, .skip3
    ld [hl+], a
    inc de
    jr .skip2

.skip3:
    ld a, $F0
    ld [hl], a
    ld a, $23
    ld [wStringIndex], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wTextFlags, wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteBD
MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor_Case06::
Jump_00D_67A3:: ; address name
    ld b, $BB
    call WriteTileBAtCursorListCursor
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .skip
    bit 7, a
    jr nz, .skip2
    bit 4, a
    jr nz, .skip3
    bit 5, a
    jr nz, .set_screen_byte_bd_to_04
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld b, $BB
    call WriteTileBAtCursorListCursor
    ret

.skip:
    ld a, $01
    jr .set_screen_byte_bd

.skip2:
    ld a, $02
    jr .set_screen_byte_bd

.skip3:
    ld a, $03
    jr .set_screen_byte_bd

.set_screen_byte_bd_to_04:
    ld a, $04

.set_screen_byte_bd:
    ld [wScreenByteBD], a
    jr .check_screen_step

; entry 7 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteBD, wMenuInputResult, wScreenStep, wListCursor, wArg5, wArg6, wDigits
; writes: wJoypadPressedRepeat, wMenuInputResult, wTwoChoiceCursor, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wTextBuf0
MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc::
Jump_00D_67F7:: ; address name
    ld a, [wScreenByteBD]
    and a, a
    jr z, .set_menu_input_result_to_04
    cp a, $01
    jr z, .set_joypad_pressed_repeat_to_40
    cp a, $02
    jr z, .set_joypad_pressed_repeat_to_80
    cp a, $03
    jr z, .set_joypad_pressed_repeat_to_10
    cp a, $04
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
    and a, a
    ret z
    cp a, $FB
    jr z, .clear_screen_byte_bd
    cp a, $FC
    jr z, .clear_screen_byte_bd
    cp a, $FD
    jr z, .clear_screen_byte_bd2
    cp a, $FE
    jr z, .set_two_choice_cursor_to_02
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ret

.clear_screen_byte_bd:
    xor a, a
    ld [wScreenByteBD], a
    ld a, [wScreenStep]
    sub a, $06
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_screen_byte_bd2:
    xor a, a
    ld [wScreenByteBD], a
    ld a, [wScreenStep]
    sub a, $02
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7106
    call StoreBAtWordTableEntry_Bank0D
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add a, e
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
    cp a, $E3
    jr z, .read_digits
    ld [hl+], a

.read_digits:
    ld a, [wDigits + $2]
    ld [hl+], a
    ld a, $F0
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Case08::
Jump_00D_68FD:: ; address name
    ld de, TileRect_0D_6189
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $6C
    call QueueSoundEffect
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArg5, wArg6, wArenaWinsHi, wArenaWinsLo, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenSubStep
MedalPrizeMenu_ChoosePrize_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_6929:: ; address name
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
    call MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, .loop
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add a, e
    ld e, a
    jr nc, .check_arena_wins_hi
    inc d

.check_arena_wins_hi:
    ld a, [de]
    ld b, a
    ld a, [wArenaWinsHi]
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, [wArenaWinsLo]
    cp a, b
    jr nc, .clear_two_choice_cursor
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of MedalPrizeMenu_ChoosePrize (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_WriteScreenStepAndScriptCommandTypeEtc, MedalPrizeMenu_ChoosePrize_UpdateTwoChoiceCursor_Bank1D)
; reads: wListPageIndex, wArenaByte37
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01::
Func_00D_69B3:: ; address name
    ld a, [wListPageIndex]
    and a, a
    jr nz, .check_arena_byte37
    ld de, MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01_Data_70AC
    jr .call_copy_rect_to20_byte_rows_bank0_d

.loop:
    ld de, MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01_Data_70CA
    jr .call_copy_rect_to20_byte_rows_bank0_d

.check_arena_byte37:
    ld a, [wArenaByte37]
    and a, a
    jr nz, .loop
    ld de, TileRect_0D_70E8

.call_copy_rect_to20_byte_rows_bank0_d:
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc
    call MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; entry 10 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_ChoosePrize_EraseCEntriesOfWordTable_Bank0D::
Jump_00D_69E8:: ; address name
    ld c, $04
    ld hl, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7106
    call EraseCEntriesOfWordTable_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, $05
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_ChoosePrize_WriteScreenStepAndScriptCommandTypeEtc::
Jump_00D_6A0B:: ; address name
    call MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4::
Jump_00D_6A1F:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    and a, a
    jr z, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_CallMedalPrizeMenu_ChoosePrize_InventoryHasF
    call MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
    cp a, $FF
    jr nz, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop::
Jump_00D_6A4E:: ; address name
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_CallMedalPrizeMenu_ChoosePrize_InventoryHasF::
Jump_00D_6A63:: ; address name
    call MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot
    cp a, $FF
    jr nz, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; if the key list is full (FindFreeKeySlotToTemp0 returns bit 7), wTwoChoiceCursor = 2, steps wScreenStep back and requests script $80; otherwise continues at MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptStepCheckKeyListFull_6A80:: ; heuristic: follows a terminator; C0
Func_00D_6A80:: ; address name
    farcall FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Loop
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArenaWinsLo, wArenaWinsHi
; writes: wArenaWinsHi, wArenaWinsLo, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0D::
Jump_00D_6AA2:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push hl
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add a, e
    ld e, a
    jr nc, .read_arena_wins_lo
    inc d

.read_arena_wins_lo:
    ld a, [de]
    ld b, a
    ld a, [wArenaWinsLo]
    ld l, a
    ld a, [wArenaWinsHi]
    ld h, a
    ld a, l
    sub a, b
    ld l, a
    ld a, h
    sbc a, $00
    ld [wArenaWinsHi], a
    ld a, l
    ld [wArenaWinsLo], a
    call DrawArenaWinsLoCountBoxAndStep
    pop hl
    ld a, [hl]
    cp a, $01
    jr nc, .set_two_choice_cursor_to_01
    xor a, a
    jr .set_two_choice_cursor

.set_two_choice_cursor_to_01:
    ld a, $01

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in MedalPrizeMenu_ChoosePrize
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E::
Jump_00D_6AEC:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push af
    and a, a
    jr z, .call_medal_prize_menu_choose_prize_inventory
    call MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
    call MedalPrizeMenu_ChoosePrize_Case0E_SetArg5ToListEntriesCell4
    jr .restore

.call_medal_prize_menu_choose_prize_inventory:
    call MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot
    ld a, $1E
    ld [hl], a
    jr .restore
    db $21, $9A, $68, $06, $12, $D7

.restore:
    pop af
    and a, a
    jr z, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_CallMedalPrizeMenu_ChoosePrize_InventoryHasF
    call MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
    cp a, $FF
    jr nz, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_Loop
    ld a, $03
    jr MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_SetTwoChoiceCursor

MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_Loop::
Jump_00D_6B24:: ; address name
    xor a, a

MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_SetTwoChoiceCursor::
Jump_00D_6B25:: ; address name
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_CallMedalPrizeMenu_ChoosePrize_InventoryHasF::
Jump_00D_6B3A:: ; address name
    call MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot
    cp a, $FF
    jr nz, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_Loop
    ld a, $01
    jr MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_SetTwoChoiceCursor

; if the key list is full, continues with A = 2 at MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_SetTwoChoiceCursor; otherwise at MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_Loop (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptStepCheckKeyListFull_6B45:: ; heuristic: follows a terminator; C0
Func_00D_6B45:: ; address name
    farcall FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_Loop
    ld a, $02
    jr MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E_SetTwoChoiceCursor

; only called from MedalPrizeMenu_ChoosePrize_Case0E (E-0047)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E)
; reads: wArg5, wArg6, wRecordBuffer, wSpeciesRecord, wChildRecord, wRecordBufferData, wScreenAttrBuffer
; writes: wMonsterId, wSpeciesIdLo, wSpeciesIdHi, wChildRecord, rRAMG2, rRAMB
; points at: wRecordBufA, wPlayerName
MedalPrizeMenu_ChoosePrize_Case0E_SetArg5ToListEntriesCell4::
Func_00D_6B55:: ; address name
    push hl
    ld hl, wRecordBufA
    ld b, $A5

.loop:
    xor a, a
    ld [hl+], a
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
    ld [hl+], a
    call WriteBlankName10_Bank0D
    ld a, [wRecordBuffer]
    ld [hl+], a
    ld [wChildRecord + MON_SPECIES], a
    ld a, [wRecordBuffer + $1]
    ld [hl+], a
    ld [wChildRecord + MON_SPECIES + 1], a
    ld a, [wSpeciesRecord]
    ld [hl+], a
    push hl
    farcall RollChildSexFromSpecies
    pop hl
    ld a, [wChildRecord + MON_SEX]
    ld [hl+], a
    ld de, wPlayerName
    ld c, $00

.loop2:
    ld a, [de]
    cp a, $F0
    jr z, .skip
    ld [hl+], a
    inc c
    inc de
    ld a, c
    cp a, $0A
    jr c, .loop2
    jr .skip2

.skip:
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0A
    jr z, .skip2
    ld a, $0A
    sub a, c
    ld b, a

.loop3:
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, .loop3

.skip2:
    xor a, a
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call WriteUnknownNamePlaceholder_Bank0D
    xor a, a
    ld [hl+], a
    call WriteUnknownNamePlaceholder_Bank0D
    xor a, a
    ld [hl+], a
    ld b, $08

.loop4:
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, .loop4
    push hl
    ld b, $19

.loop5:
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, .loop5
    pop hl
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [hl+], a
    ld a, $16
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wRecordBufferData + $8]
    ld [hl+], a
    ld a, [wRecordBufferData + $9]
    ld [hl+], a
    ld a, [wRecordBufferData + $8]
    ld [hl+], a
    ld a, [wRecordBufferData + $9]
    ld [hl+], a
    ld a, [wRecordBufferData + $A]
    ld [hl+], a
    ld a, [wRecordBufferData + $B]
    ld [hl+], a
    ld a, [wRecordBufferData + $A]
    ld [hl+], a
    ld a, [wRecordBufferData + $B]
    ld [hl+], a
    ld a, [wRecordBufferData + $C]
    ld [hl+], a
    ld a, [wRecordBufferData + $D]
    ld [hl+], a
    ld a, [wRecordBufferData + $E]
    ld [hl+], a
    ld a, [wRecordBufferData + $F]
    ld [hl+], a
    ld a, [wRecordBufferData + $10]
    ld [hl+], a
    ld a, [wRecordBufferData + $11]
    ld [hl+], a
    ld a, [wScreenAttrBuffer]
    ld [hl+], a
    ld a, [wRecordBufferData + $13]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wRecordBufferData + $14]
    ld [hl+], a
    ld a, [wRecordBufferData + $15]
    ld [hl+], a
    ld a, [wRecordBufferData + $17]
    ld [hl+], a
    ld a, [wRecordBufferData + $16]
    ld [hl+], a
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1B

.loop6:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop6
    call WriteUnknownNamePlaceholder_Bank0D
    xor a, a
    ld [hl+], a
    call WriteUnknownNamePlaceholder_Bank0D
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    pop hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $A5

.loop7:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop7
    xor a, a
    ld [rRAMG2], a
    ret

; writes ten $F0 (blank) bytes at HL, without a terminator (E-0122)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_ChoosePrize_Case0E_SetArg5ToListEntriesCell4)
WriteBlankName10_Bank0D::
Func_00D_6CBA:: ; address name
    ld b, $0A
    jr WriteUnknownNamePlaceholder_Bank0D_Loop

; writes '???' ($98 x 3) and seven $F0 bytes at HL, without a terminator (E-0122)
; 4 call sites from 1 routine (e.g. MedalPrizeMenu_ChoosePrize_Case0E_SetArg5ToListEntriesCell4)
WriteUnknownNamePlaceholder_Bank0D::
Func_00D_6CBE:: ; address name
    ld a, $98
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld b, $07

WriteUnknownNamePlaceholder_Bank0D_Loop::
Jump_00D_6CC5:: ; address name
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, WriteUnknownNamePlaceholder_Bank0D_Loop
    ret

; only called from routines of MedalPrizeMenu_ChoosePrize (E-0098)
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4)
; reads: wFarmLevel
; writes: rRAMG2, rRAMB
; points at: sRecords
MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB::
Func_00D_6CCC:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $00
    ld a, [wFarmLevel]
    ld de, MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Data
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a

.loop:
    push hl
    ld a, [hl]
    and a, a
    jr z, .restore
    cp a, $FF
    jr z, .restore
    pop hl
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ld a, $FF
    ret

.restore:
    pop hl
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB
MedalPrizeMenu_ChoosePrize_WriteRAMG2AndRAMB_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_6D06:: ; address name
    db $0A, $14, $1E

; A = 0 when one of the 24 inventory slots is empty, else $FF
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0E, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4)
; points at: wInventory
MedalPrizeMenu_ChoosePrize_InventoryHasFreeSlot::
Func_00D_6D09:: ; address name
    ld hl, wInventory
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .return_0
    cp a, $FF
    jr z, .return_0
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, .loop
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; A = 0 when one of the 12 four-byte wKeyList entries is free ($FF), else $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wKeyList
KeyListHasFreeSlot:: ; heuristic: follows a terminator; C0
Func_00D_6D22:: ; address name
    ld hl, wKeyList
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $FF
    jr z, .return_0
    ld a, $04
    add_a_to_hl
    inc c
    ld a, c
    cp a, $0C
    jr c, .loop
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; only called from routines of MedalPrizeMenu_ChoosePrize (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01, MedalPrizeMenu_ChoosePrize_WriteArg5AndScreenStep)
; reads: wListPageIndex, wArenaByte37, wDigits
MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc::
Func_00D_6D3E:: ; address name
    ld a, [wListPageIndex]
    add a, a
    add a, a
    ld de, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data
    add a, e
    ld e, a
    jr nc, .check_list_page_index
    inc d

.check_list_page_index:
    ld a, [wListPageIndex]
    and a, a
    jr z, .skip
    ld a, [wArenaByte37]
    and a, a
    jr nz, .skip2
    ld a, [wListPageIndex]
    ld b, a
    ld a, $03
    sub a, b
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
    ld de, MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc_Data
    pop bc
    push bc
    ld a, c
    sla a
    add a, e
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
    add a, $E0
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    pop bc
    pop de
    inc de
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ret

; address loaded by MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc
MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_6D9F:: ; address name
    db $D7, $C3, $FF, $C3, $27, $C4, $4F, $C4

; writes B at BGMapAddressAtScroll + the offset from Data_00D_6DC8[wListCursor] (WaitForVRAMAccess, interrupts off); BC kept (E-0120)
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor_Case06, MedalPrizeMenu_ChoosePrize_WriteTileBAtCursorListCursor)
; reads: wListCursor
WriteTileBAtCursorListCursor::
Func_00D_6DA7:: ; address name
    push bc
    ld a, [wListCursor]
    sla a
    ld hl, WriteTileBAtCursorListCursor_Data
    add_a_to_hl
    ld a, [hl+]
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

; address loaded by WriteTileBAtCursorListCursor
WriteTileBAtCursorListCursor_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_6DC8:: ; address name
    db $A4, $00, $E4, $00, $24, $01, $64, $01

; counts inventory slots holding item $2C; $FF when there are none
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_CountItem2C_Case01, MedalPrizeMenu_CopyBytesDEToHL_Bank0D)
; points at: wInventory
MedalPrizeMenu_CountItem2C::
Func_00D_6DD0:: ; address name
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop:
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
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
    cp a, $18
    jr c, .loop
    ld a, b
    and a, a
    jr z, .return_FF
    ret

.return_FF:
    ld a, $FF
    ret

; only called from MedalPrizeMenu_ChoosePrize_Case00 (E-0047)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D)
; reads: wArenaByte37
; writes: wListCount
; points at: wListEntries
MedalPrizeMenu_ChoosePrize_Case00_WriteListCount::
Func_00D_6DF2:: ; address name
    ld a, [wArenaByte37]
    and a, a
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
    ld [hl+], a
    inc c
    ld a, c
    cp a, b
    jr c, .loop
    ld [wListCount], a
    ret

; only called from MedalPrizeMenu_ChoosePrize_Case03 (E-0047)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_ChoosePrize_WriteArg5AndScreenStep)
; reads: wListPageIndex, wListLastRow, wListCount, wListPages
; points at: wListEntries, wNameGlyphBuf
MedalPrizeMenu_ChoosePrize_Case03_ReadListPageIndexAndListLastRowEtc::
Func_00D_6E0E:: ; address name
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

.loop:
    ld a, [wListLastRow]
    cp a, $03
    jr c, .check_list_pages
    ld a, [wListCount]
    jr .read_list_page_index

.check_list_pages:
    ld a, [wListPages]
    cp a, $01
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
    add a, c
    cp a, b
    jp nc, .return
    push hl
    push bc
    ld a, [hl]
    add a, $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, StringCategories_0D_4016
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wNameGlyphBuf
    ld c, $00

.skip:
    ld a, [de]
    cp a, $F0
    jr z, .skip2
    ld [hl+], a
    inc de
    jr .skip

.skip2:
    ld a, $F0
    ld [hl], a
    pop bc
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, .return
    ld a, c
    cp a, $04
    jp c, .loop

.return:
    ret

; only called from routines of MedalPrizeMenu_ChoosePrize (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01, MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor)
; writes: wArg1, wArg2
MedalPrizeMenu_ChoosePrize_DrawC5BEC6AtScrollOffsetDE_Bank0D::
Func_00D_6E88:: ; address name
    ld de, $018E
    call DrawC5BEC6AtScrollOffsetDE_Bank0D
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
    ld de, $018F
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 3 tiles, one row per line
TileRect_0D_6EB7::
Data_00D_6EB7:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $AD, $CF, $AE, $AF, $FC, $FD, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 9 tiles, one row per line
TileRect_0D_6ED8::
Data_00D_6ED8:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; address loaded by MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor
MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_6F71:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_6F71:: ; address name
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $FD, $C3, $C3, $C3, $C3

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 15 x 7 tiles, one row per line
TileRect_0D_6FDA::
Data_00D_6FDA:: ; address name
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3 ; id 6

; address loaded by MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor
MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7043:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_7043:: ; address name
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3

; address loaded by MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01_Data_70AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_70AC:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

; address loaded by MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01
MedalPrizeMenu_ChoosePrize_CopyRectTo20ByteRows_Bank0D_Shared01_Data_70CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_70CA:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0D_70E8::
Data_00D_70E8:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor, MedalPrizeMenu_ChoosePrize_BGMapAddressAtScroll_Bank0D, MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc, MedalPrizeMenu_ChoosePrize_EraseCEntriesOfWordTable_Bank0D
MedalPrizeMenu_ChoosePrize_ClampKeyListPageCursor_Data_7106:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_7106:: ; address name
    db $CC, $C3, $F4, $C3, $1C, $C4, $44, $C4

; address loaded by MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc, MedalPrizeMenu_ChoosePrize_UpdateTwoChoiceCursor_Bank1D, MedalPrizeMenu_ChoosePrize_SetArg5ToListEntriesCell4_Case0D, MedalPrizeMenu_ChoosePrize_ReadListPageIndexAndArenaByte37Etc
MedalPrizeMenu_ChoosePrize_WriteJoypadPressedRepeatAndMenuInputResultEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_710E:: ; address name
    db $03, $03, $04, $04, $05, $05, $0A

; far-calls CloseMenuE9 (E-0119)
; 1 call site from 1 routine (e.g. CallScriptCommandE9Far)
ScriptCommandE9_RunFar::
Func_00D_7115:: ; address name
    farcall CloseMenuE9
    ret

; implements script command type F4 (SCRIPT_NPC_BREED): breeding with a townsperson's monster picked by wScreenTableIndex: 'Who will breed with my SpikyBoy?' (mode 8, message bank $0E, + 16 * wScreenTableIndex); reached through ScriptCommandF4 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF4)
; reads: wScreenState
NpcBreedMenu::
Func_00D_711C:: ; address name
    ld a, [wScreenState]
    rst $00
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
    dw NpcBreedMenu_SwapMonstersMenu_Case0C
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_RedrawListScreen

; entry 0 of the `rst $00` table in NpcBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wMessageMode, wScreenState
NpcBreedMenu_SwapMonstersMenu::
Jump_00D_7144:: ; address name
    farcall SwapMonstersMenu
    ld a, $08
    ld [wMessageMode], a
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in NpcBreedMenu
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_Return::
Jump_00D_7158:: ; address name
    ret

; by wScreenStep: BreedMenu list steps, a two-choice confirmation, ComputeBreedingChild, then a talk event
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
NpcBreedMenu_ChooseAndBreed::
Jump_00D_7159:: ; address name
    ld a, [wScreenStep]
    rst $00
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
    dw RunFunc4ED5At0278AndStep_0D
    dw NpcBreedMenu_ChooseAndBreed_ToBreedMenu
    dw NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5_Case11
    dw NpcBreedMenu_ChooseAndBreed_PrepareWCF8BCountersAndRequestScript
    dw NpcBreedMenu_ChooseAndBreed_WriteScreenStep
    dw NpcBreedMenu_ChooseAndBreed_ComputeBreedingChild
    dw NpcBreedMenu_ChooseAndBreed_QueueSoundEffect
    dw NpcBreedMenu_ChooseAndBreed_UpdateTwoChoiceCursor_Bank1D
    dw NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc
    dw NpcBreedMenu_ChooseAndBreed_ToRedrawFullScreenBoxes_0CAndStep
    dw NpcBreedMenu_ChooseAndBreed_DispatchTalkEvent
    dw NpcBreedMenu_ChooseAndBreed_ToRestorePlayerPositionState_Bank0DAndStep
    dw NpcBreedMenu_ChooseAndBreed_CopyBytesDEToHL_Bank0D

; entry 0 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_ChooseAndBreed_ToBreedMenu::
Jump_00D_7195:: ; address name
    farcall BreedMenu
    ret

; entry 12 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_ChooseAndBreed_BreedMenu::
Jump_00D_719C:: ; address name
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
    ret

; entry 4 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5::
Jump_00D_71BD:: ; address name
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
    call LoadFamilyIconTileForRecordB_Bank0D
    ld de, TileRect_0D_785E
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C05
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

; entry 9 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
NpcBreedMenu_ChooseAndBreed_SetTwoChoiceCursor::
Jump_00D_71FF:: ; address name
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs Func_00D_4ED5 (C = 5, HL = $0278, DE = $00AC, wArg1/2 = 0/8), then wScreenStep += 1 (E-0126)
; 1 call site from 1 routine (e.g. NpcBreedMenu_ChooseAndBreed_PrepareWCF8BCountersAndRequestScript)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunFunc4ED5At0278AndStep_0D::
Func_00D_720E:: ; address name
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wArg1], a
    ld a, $08
    ld [wArg2], a
    call CopyScreenBufferRectWithAttrs_0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wScreenStep, wPartyCount, wPartyList, wListCursor, wListPageIndex
; writes: rRAMG2, rRAMB, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wSelectedRecord, wItemGridX, ...
NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5_Case11::
Jump_00D_722A:: ; address name
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
    jr nc, .check_party_count
    pop hl
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_party_count:
    pop hl
    ld a, [wPartyCount]
    cp a, $02
    jr nc, .call_set_arg5_to_list_entries_cell5
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr nz, .call_set_arg5_to_list_entries_cell5
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScreenStep]
    dec a
    dec a
    ld [wScreenStep], a
    xor a, a
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
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep
NpcBreedMenu_ChooseAndBreed_PrepareWCF8BCountersAndRequestScript::
Jump_00D_72D0:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .clear_screen_sub_step
    call NpcBreedMenu_ChooseAndBreed_Multiply8
    farcall PrepareWCF8BCountersAndRequestScript
    ret

.clear_screen_sub_step:
    xor a, a
    ld [wScreenSubStep], a
    call RunFunc4ED5At0278AndStep_0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; entry 19 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTableIndex, wScreenStep
; writes: wScreenStep
; points at: wRecordBufB
NpcBreedMenu_ChooseAndBreed_WriteScreenStep::
Jump_00D_72F4:: ; address name
    call NpcBreedMenu_ChooseAndBreed_Multiply8
    ld a, [wScreenTableIndex]
    sla a
    ld de, PresetMonsterRecordTable
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
    ld de, wRecordBufB
    ld b, $A5

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wRecordBufA + MON_SEX
    ld a, [hl]
    and a, $01
    inc a
    and a, $01
    ld hl, wRecordBufB + MON_SEX
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenStep
; writes: wArg1, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenSubStep
NpcBreedMenu_ChooseAndBreed_ComputeBreedingChild::
Jump_00D_7329:: ; address name
    ld a, $01
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call NpcBreedMenu_ChooseAndBreed_Case14_TestBitInFieldAtArg3
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 21 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
NpcBreedMenu_ChooseAndBreed_QueueSoundEffect::
Jump_00D_7352:: ; address name
    ld a, $6C
    call QueueSoundEffect
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
    ld de, TileRect_0D_78B8
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
NpcBreedMenu_ChooseAndBreed_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_73AF:: ; address name
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
    cp a, $01
    jr z, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 23 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep, wSelectedRecord, wArg6, wArg7, wScreenTableIndex
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep, wScriptCommandType, wScriptStartRequest, wArg1, wArg2, rRAMG2, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork
NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc::
Jump_00D_73F1:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr z, .read_selected_record
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_selected_record:
    ld a, [wSelectedRecord]
    ld [wArg1], a
    xor a, a
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
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wChildRecord + MON_SPECIES
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
    ld a, [wScreenTableIndex]
    sla a
    ld hl, NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc_Data
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    farcall IncrementTwoCountersCappedAt99
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; address loaded by NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc
NpcBreedMenu_ChooseAndBreed_WriteTwoChoiceCursorAndScreenSubStepEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_7499:: ; address name
    db $0E, $01, $18, $01, $1A, $01, $25, $01, $29, $01, $32, $00, $33, $00, $34, $00
    db $35, $00, $36, $00

; entry 24 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
NpcBreedMenu_ChooseAndBreed_ToRedrawFullScreenBoxes_0CAndStep::
Jump_00D_74AD:: ; address name
    farcall RedrawFullScreenBoxes_0C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScreenStep
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wScreenStep
NpcBreedMenu_ChooseAndBreed_DispatchTalkEvent::
Jump_00D_74BB:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $20
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    farcall ClearBit1OfPlayerAndObjectFlags
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 26 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
NpcBreedMenu_ChooseAndBreed_ToRestorePlayerPositionState_Bank0DAndStep::
Jump_00D_74F1:: ; address name
    call RestorePlayerPositionState_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in NpcBreedMenu_ChooseAndBreed
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenTileBuffer, wWindowTileBuffer, wScreenAttrBuffer, wWindowAttrBuffer
NpcBreedMenu_ChooseAndBreed_CopyBytesDEToHL_Bank0D::
Jump_00D_74FC:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
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
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank0D
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in NpcBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
NpcBreedMenu_SwapMonstersMenu_Case0C::
Jump_00D_755C:: ; address name
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

; NpcBreedMenu screen state $11: graphics, palette and glyph tiles, then BreedMenu list steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
NpcBreedMenu_RedrawListScreen::
Jump_00D_7578:: ; address name
    ld a, [wScreenStep]
    rst $00
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

; entry 2 of the `rst $00` table in NpcBreedMenu_RedrawListScreen
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_RedrawListScreen_ToBreedMenu::
Jump_00D_7590:: ; address name
    farcall BreedMenu
    ret

; entry 0 of the `rst $00` table in NpcBreedMenu_RedrawListScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTableIndex, wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
NpcBreedMenu_RedrawListScreen_DecompressToVRAM::
Jump_00D_7597:: ; address name
    ld a, [wScreenTableIndex]
    ld b, a
    sla a
    add a, b
    push af
    ld hl, NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data_75D7
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data_7607
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; address loaded by NpcBreedMenu_RedrawListScreen_DecompressToVRAM
NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data_75D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_75D7:: ; address name
    db $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9
    db $49, $48, $A9, $49, $48, $A9, $49, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B
    db $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48

; address loaded by NpcBreedMenu_RedrawListScreen_DecompressToVRAM
NpcBreedMenu_RedrawListScreen_DecompressToVRAM_Data_7607:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_00D_7607:: ; address name
    db $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87
    db $4C, $48, $87, $4C, $48, $87, $4C, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F
    db $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48

; entry 1 of the `rst $00` table in NpcBreedMenu_RedrawListScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
NpcBreedMenu_RedrawListScreen_CopyGlyphTileListFromBank1F::
Jump_00D_7637:: ; address name
    ld hl, TileCopyDestList_0D_789A
    ld de, TileCopySrcList_0D_78AA
    call CopyGlyphTileListFromBank1F
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in NpcBreedMenu_RedrawListScreen
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wScreenStep
NpcBreedMenu_RedrawListScreen_FillTilesFromRequest::
Jump_00D_7662:: ; address name
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

; entry 7 of the `rst $00` table in NpcBreedMenu_RedrawListScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
NpcBreedMenu_RedrawListScreen_SetArg5ToListEntriesCell5::
Jump_00D_76AF:: ; address name
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

; only called from NpcBreedMenu_ChooseAndBreed_Case14 (E-0047)
; 1 call site from 1 routine (e.g. NpcBreedMenu_ChooseAndBreed_ComputeBreedingChild)
; reads: wArg6, wArg7, wArg5, wChildRecord
; writes: wArg1, wSpeciesIdLo, wArg2, wSpeciesIdHi, wArg3, wArg4, wTwoChoiceCursor
; points at: wMonsterLibraryBuf, wNameGlyphBuf, wTextBuf0, wDigits
NpcBreedMenu_ChooseAndBreed_Case14_TestBitInFieldAtArg3::
Func_00D_76D0:: ; address name
    ld a, [wArg6]
    ld [wArg1], a
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wArg2], a
    ld [wSpeciesIdHi], a
    ld de, $75C5
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
    cp a, $FF
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
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld a, [wArg6]
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    ret

.clear_two_choice_cursor:
    xor a, a
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
    ld a, [hl+]
    cp a, $F0
    jr z, .skip
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.skip:
    ld a, $90
    ld [de], a
    inc de
    ld a, $A2
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
    cp a, $E3
    jr nz, .loop3
    inc hl
    dec b
    ld a, b
    cp a, $01
    jr nz, .loop2

.loop3:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ld a, $F0
    ld [de], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wNameGlyphBuf; wDataBank is restored
; 1 call site from 1 routine (e.g. NpcBreedMenu_ChooseAndBreed_Case14_TestBitInFieldAtArg3)
; reads: wDataBank
; writes: wDataBank
; points at: wNameGlyphBuf
CopyMonsterNameToBuffer_B0D::
Func_00D_778C:: ; address name
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

; the same 80 bytes as RestorePlayerPositionState (15:6E14)
; 1 call site from 1 routine (e.g. NpcBreedMenu_ChooseAndBreed_ToRestorePlayerPositionState_Bank0DAndStep)
; reads: wSavedPlayerState
; writes: hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords, wSpriteSlots, wSavedPositionValid
RestorePlayerPositionState_Bank0D::
Func_00D_77C2:: ; address name
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
    ld a, [wSavedPlayerState + $A]
    ld [wFollowerRecords + $A], a
    ld a, [wSavedPlayerState + $B]
    ld [wFollowerRecords + $B], a
    ld a, [wSavedPlayerState + $C]
    ld [wFollowerRecords + $C], a
    ld a, [wSavedPlayerState]
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wSavedPositionValid], a
    ret

; the same 39 bytes as LoadFamilyIconTileForRecordB_Bank15 (15:6866)
; 1 call site from 1 routine (e.g. NpcBreedMenu_ChooseAndBreed_SetArg5ToListEntriesCell5)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank0D::
Func_00D_7812:: ; address name
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

; only called from routines of NpcBreedMenu_ChooseAndBreed (E-0098)
; 2 call sites from 2 routines (e.g. NpcBreedMenu_ChooseAndBreed_WriteScreenStep, NpcBreedMenu_ChooseAndBreed_PrepareWCF8BCountersAndRequestScript)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB
; points at: sRecords, wRecordBufA
NpcBreedMenu_ChooseAndBreed_Multiply8::
Func_00D_7839:: ; address name
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
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 12 x 5 tiles, one row per line
TileRect_0D_785E::
Data_00D_785E:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $F8, $F9, $FA, $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_0D_789A::
Data_00D_789A:: ; address name
    dw vTiles2 + $700, vTiles2 + $710, vTiles2 + $720, vTiles2 + $730, vTiles2 + $740, vTiles2 + $750, vTiles2 + $760, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_0D_78AA::
Data_00D_78AA:: ; address name
    dw $4130, $4320, $42A0, $4330, $4190, $4150, $FFFF ; entry 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_0D_78B8::
Data_00D_78B8:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $76, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0235 (C1: NpcBreedMenu_Case04_Case13 reads the word at $78D6 + 2 * wScreenTableIndex and copies $A5 bytes from it to wRecordBufB; the first ten words point at ten consecutive records and the last six repeat the first).
; record: $A5-byte monster record
PresetMonsterRecordTable::
Data_00D_78D6:: ; address name
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

; E-0235 (C1: the ten records PresetMonsterRecordTable points at, $A5 bytes apart; only bytes 0, 1-10 and 15-24 have read meanings, the rest are kept as bytes; fields from E-0034, E-0104, E-0122, E-0125 and E-0237, laid out in E-0262).
; record: one $A5-byte monster record in the SRAM record format
PresetMonsterRecords::
Data_00D_78F6:: ; address name
    db $01 ; id 0: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $004A ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $02 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $25, $36, $61, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $12 ; $56: level (E-0122)
    db $23 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0058, $0058, $005C, $005C ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $007F, $005D, $0045, $017F ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $C8, $C8, $96, $50 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_01:: ; heuristic: preset monster record; C0
Data_00D_799B:: ; address name
    db $01 ; id 1: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $011E ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $08 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $07, $0D, $6B, $6F, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2A ; $56: level (E-0122)
    db $2A ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $00E6, $00E6, $00E0, $00E0 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00E2, $0110, $0132, $02F1 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $0A, $C8, $B4, $DC ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $00, $00, $02, $00, $01, $02, $00, $00, $01, $00, $00, $02, $00, $00, $02, $01, $01, $01, $00, $00, $00, $01, $01, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_02:: ; heuristic: preset monster record; C0
Data_00D_7A40:: ; address name
    db $01 ; id 2: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $00BC ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $05 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $13, $33, $6D, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $1C ; $56: level (E-0122)
    db $23 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $007B, $007B, $00AD, $00AD ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $0077, $00A6, $00B4, $0165 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $46, $64, $AA, $D2 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $01, $01, $01, $00, $02, $00, $00, $00, $02, $00, $00, $00, $00, $01, $01, $02, $02, $02, $01, $01, $01, $03, $03, $00 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_03:: ; heuristic: preset monster record; C0
Data_00D_7AE5:: ; address name
    db $01 ; id 3: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0092 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $04 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $19, $2F, $3C, $9B, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $25 ; $56: level (E-0122)
    db $25 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $00A6, $00A6, $009F, $009F ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00D6, $00D4, $009B, $02EB ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $D2, $28, $96, $D2 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $02, $02, $01, $00, $00, $01, $02, $02, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_04:: ; heuristic: preset monster record; C0
Data_00D_7B8A:: ; address name
    db $01 ; id 4: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $005E ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $02 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $20, $34, $63, $90, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $20 ; $56: level (E-0122)
    db $23 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0090, $0090, $0040, $0040 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00C6, $004F, $0098, $01C5 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $C8, $96, $96, $1E ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_05:: ; heuristic: preset monster record; C0
Data_00D_7C2F:: ; address name
    db $01 ; id 5: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0080 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $03 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $79, $7B, $92, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2E ; $56: level (E-0122)
    db $32 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0174, $0174, $015F, $015F ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $0169, $0147, $01CB, $01B1 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $64, $96, $64, $82 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $03, $03, $00, $01, $00, $02, $01, $01, $01, $00, $00, $03, $00, $00, $00, $00, $02, $00, $03, $03, $03, $02, $02, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_06:: ; heuristic: preset monster record; C0
Data_00D_7CD4:: ; address name
    db $01 ; id 6: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $010D ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $3A, $3B, $A0, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $35 ; $56: level (E-0122)
    db $35 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0173, $0173, $0246, $0246 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $00F8, $01A1, $01CA, $01F4 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $14, $C8, $64, $B4 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $00, $00, $00, $02, $02, $03, $00, $00, $02, $00, $00, $02, $00, $00, $00, $02, $03, $02, $01, $00, $00, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_07:: ; heuristic: preset monster record; C0
Data_00D_7D79:: ; address name
    db $01 ; id 7: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0033 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $01 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $19, $82, $9C, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $3B ; $56: level (E-0122)
    db $3B ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $01F6, $01F6, $0147, $0147 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $01AD, $01BF, $01E9, $01AB ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $B4, $8C, $64, $8C ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $02, $00, $00, $02, $00, $02, $02, $00, $00, $00, $01, $01, $01, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_08:: ; heuristic: preset monster record; C0
Data_00D_7E1E:: ; address name
    db $01 ; id 8: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $010A ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $50, $51, $52, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2B ; $56: level (E-0122)
    db $37 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0155, $0155, $0135, $0135 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $015D, $013D, $010B, $0191 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $78, $82, $64, $5A ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $01, $02, $00, $02, $02, $02, $03, $01, $01, $02, $00, $00, $03, $00, $00, $01, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
PresetMonsterRecords_09:: ; heuristic: preset monster record; C0
Data_00D_7EC3:: ; address name
    db $01 ; id 9: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0133 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $08 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $6F, $81, $91, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $36 ; $56: level (E-0122)
    db $36 ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $01D3, $01D3, $01BA, $01BA ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $01AC, $0178, $014B, $01E0 ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $78, $64, $64, $82 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $01, $00, $03, $01, $01, $03, $00, $01, $00, $00, $00, $03, $00, $01, $03, $00, $02, $01, $01, $01, $01, $01, $01, $02 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)
    ds $98, $00
