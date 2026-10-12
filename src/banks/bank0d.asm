SECTION "Bank 0D", ROMX[$4000], BANK[$0D]
    db $0D

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. ShowString_Bank0D, DebugMessageTest_Update_ToBeginStringDisplay_Bank0D, KeyAppraisalMenu_Case03_DrawBottomBoxForLinkAndSetScreenSubStep)
BeginStringDisplay_Bank0D::
Func_00D_4001:: ; address name
    ld de, StringCategories_0D_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_00D_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor_Case06, MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor)
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
    db $EA, $45, " Welcome to the", $F1
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
    db $EA, $45, " Don't come if", $F1
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
    db $EA, $45, " Appraisal will", $F1
    db "cost ", $F9, "0G. OK?", $F0

String_0D_00_06:: ; heuristic: string; C0
Data_00D_414D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hah? I'm not", $F1
    db "appraising any", $FA, $F7
    db $EF, $EE, "key if you don't", $EF, $EE, "pay my fee.", $F7
    db $F0

String_0D_00_08:: ; heuristic: string; C0
Data_00D_418C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which Magic Key", $F1
    db "should I appraise?", $F0

String_0D_00_09:: ; heuristic: string; C0
Data_00D_41B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That key's been", $F1
    db "appraised already.", $F7
    db $F0

String_0D_00_0A:: ; heuristic: string; C0
Data_00D_41D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You have no more", $F1
    db "Magic Keys that", $FA, $F7
    db $EF, $EE, "need appraisal, it", $EF, $EE, "seems to me.", $F7
    db $F0

String_0D_00_0B:: ; heuristic: string; C0
Data_00D_4221:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Should I save", $F1
    db "the results?", $F0

String_0D_00_0C:: ; heuristic: string; C0
Data_00D_423F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let's see the", $F1
    db "Magic Key, then.", $FA, $F7
    db $EF, $EE, $A4, "Hmmm", $A4, " Hah?", $EF, $EE, "Oh, right", $A4, $FA, $F7
    db $EF, $EE, "I got it! This is", $EF, $EE, "the ", $F9, "0!", $E5, "0", $E4, $D4, $F7
    db $E9, $FF, $F0

String_0D_00_10:: ; heuristic: string; C0
Data_00D_42A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, you have", $F1
    db "some TinyMedals?", $FA, $F7
    db $EF, $EE, "Let me relieve you", $EF, $EE, "of them.", $F7
    db $F0

String_0D_00_12:: ; heuristic: string; C0
Data_00D_42E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "But, I can't", $F1
    db "take this many.", $F7
    db $F0

String_0D_00_13:: ; heuristic: string; C0
Data_00D_4303:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I have ", $F9, "0 of", $F1
    db "your TinyMedals.", $F7
    db $F0

String_0D_00_14:: ; heuristic: string; C0
Data_00D_4325:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hope you'll", $F1
    db "find many medals!", $F7
    db $F0

String_0D_00_15:: ; heuristic: string; C0
Data_00D_4348:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Want to trade", $F1
    db "medals for prizes?", $F0

String_0D_00_16:: ; heuristic: string; C0
Data_00D_436C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which prize do", $F1
    db "you want?", $F0

String_0D_00_17:: ; heuristic: string; C0
Data_00D_4388:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll trade for", $F1
    db $F9, "0 TinyMedals. OK?", $F0

String_0D_00_18:: ; heuristic: string; C0
Data_00D_43AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That requires", $F1
    db "more TinyMedals.", $F7
    db $F0

String_0D_00_19:: ; heuristic: string; C0
Data_00D_43CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You don't have", $F1
    db "any room for that.", $F7
    db $F0

String_0D_00_1A:: ; heuristic: string; C0
Data_00D_43F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your key ring is", $F1
    db "already full.", $F7
    db $F0

String_0D_00_1B:: ; heuristic: string; C0
Data_00D_4417:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You have no more", $F1
    db "room for monsters.", $F7
    db $F0

String_0D_00_1C:: ; heuristic: string; C0
Data_00D_443F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine, we shall", $F1
    db "trade.", $F7
    db $F0

String_0D_00_1D:: ; heuristic: string; C0
Data_00D_4459:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll send the egg", $F1
    db "to the farm.", $F7
    db $F0

String_0D_00_1E:: ; heuristic: string; C0
Data_00D_447B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can't take", $F1
    db "any more items.", $F7
    db $F0

String_0D_00_1F:: ; heuristic: string; C0
Data_00D_449D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can't hold any", $F1
    db "more keys.", $F7
    db $F0

String_0D_00_20:: ; heuristic: string; C0
Data_00D_44BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You have no more", $F1
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
    db $EA, $45, " At minimum, you", $F1
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

; implements script command type EF (SCRIPT_EGG_SERVICE): egg appraisal and blessing: 'Which egg should I appraise?', 'Which egg should I bless?' (mode 6, bank $F2 strings); reached through ScriptCommandEF in bank $10 (E-0038, E-0244)
; 2 call sites from 2 routines (e.g. RenameMenu_ToEggServiceMenu, ScriptCommandEF)
; reads: wScreenState
EggServiceMenu::
Func_00D_45D1:: ; address name
    ld a, [wScreenState]
    rst $00
    dw EggServiceMenu_CopyBytesDEToHL_Bank0D
    dw EggServiceMenu_Case01
    dw EggServiceMenu_HandleThreeOptionMenuInput_15
    dw EggServiceMenu_ListRecordsInUseWithByte6ESet
    dw EggServiceMenu_Return
    dw EggServiceMenu_Case05
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_SwapMonstersMenu
    dw EggServiceMenu_Return_Return
    dw EggServiceMenu_Case0F

; entry 6 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Return_Return::
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

Jump_00D_45FC::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_45FC
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_4621
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_4621::
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

; entry 1 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Case01::
Jump_00D_4635:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw DrawPair4F81And4F9FAndStep
    dw EggServiceMenu_Case01_Number24ToPackedBCD
    dw EggServiceMenu_Case01_CopyRectTo20ByteRows_Bank0D

; runs Func_00D_4F3D for Data_00D_4F81 and Data_00D_4F9F, then wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. EggServiceMenu_Case0F_CopyGlyphTileListFromBank1F)
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

; entry 1 of the `rst $00` table in EggServiceMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wGoldLo, wGoldMid, wGoldHi, wScreenStep
; writes: wDigits, wScreenStep
; points at: wArg3
EggServiceMenu_Case01_Number24ToPackedBCD::
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

Jump_00D_467F::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00D_467F
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
EggServiceMenu_Case01_CopyRectTo20ByteRows_Bank0D::
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
    jr z, Jump_00D_46CA
    jr Jump_00D_46D0

Jump_00D_46CA::
    xor a, a
    ld [wScreenByteBD], a
    jr Jump_00D_46D5

Jump_00D_46D0::
    ld a, $01
    ld [wScreenByteBD], a

Jump_00D_46D5::
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wRecordsFlagged]
    and a, a
    jr z, Jump_00D_46FB
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

Jump_00D_46FB::
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

; entry 5 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Case05::
Jump_00D_4710:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_UpdatePagedListCursor
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_HandleTwoChoiceCursorInput_0D
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_ToBreedMenu
    dw EggServiceMenu_Case05_IsAmountInArg1AboveGold
    dw DrawBox5022WithPageIndicator
    dw EggServiceMenu_Case05_DrawRecordListPageMarks
    dw EggServiceMenu_Case05_Case12

; entry 0 of the `rst $00` table in EggServiceMenu_Case05
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Case05_ToBreedMenu::
Jump_00D_473A:: ; address name
    farcall BreedMenu
    ret

; entry 6 of the `rst $00` table in EggServiceMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep, wListCursor, wScreenByteBD
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenStep, wDigits, wScriptCommandType, wScriptStartRequest
; points at: wArg4, wTextBuf0, wTextWindowTileLo
EggServiceMenu_Case05_UpdatePagedListCursor::
Jump_00D_4741:: ; address name
    ld a, $02
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_4766
    cp a, $FC
    jr z, Jump_00D_4766
    cp a, $FD
    jr z, Jump_00D_476F
    cp a, $FE
    jr z, Jump_00D_4770
    cp a, $FF
    jr z, Jump_00D_478A
    ret

Jump_00D_4766::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_00D_476F::
    ret

Jump_00D_4770::
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

Jump_00D_478A::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $04
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_00D_5097
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenByteBD]
    and a, a
    jr z, Jump_00D_47E0
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

Jump_00D_47C4::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_47CF
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, Jump_00D_47C4

Jump_00D_47CF::
    ld de, wTextBuf0

Jump_00D_47D2::
    ld a, b
    and a, a
    jr z, Jump_00D_47DD
    ld a, [hl]
    ld [de], a
    inc de
    inc hl
    dec b
    jr Jump_00D_47D2

Jump_00D_47DD::
    ld a, $F0
    ld [de], a

Jump_00D_47E0::
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

; entry 12 of the `rst $00` table in EggServiceMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursor, wScreenStep
; writes: wArg5, wScreenByteB2, wScreenByteB3, wScreenState, wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, ...
EggServiceMenu_Case05_HandleTwoChoiceCursorInput_0D::
Jump_00D_47F7:: ; address name
    xor a, a
    ld [wArg5], a
    call HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_480C
    cp a, $FF
    jr z, Jump_00D_4822
    ret

Jump_00D_480C::
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

Jump_00D_4822::
    ld a, [wChoiceCursor]
    and a, a
    jp nz, Jump_00D_4852
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

Jump_00D_4852::
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

; entry 15 of the `rst $00` table in EggServiceMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteBD, wArg1, wScreenStep, wArg5, wArg6
; writes: wArg1, wArg2, wArg3, wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, ...
EggServiceMenu_Case05_IsAmountInArg1AboveGold::
Jump_00D_4869:: ; address name
    ld a, [wScreenByteBD]
    and a, a
    jr nz, Jump_00D_4894
    ld a, $14
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    and a, a
    jr nz, Jump_00D_48AF
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

Jump_00D_4894::
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
    jr z, Jump_00D_48C5

Jump_00D_48AF::
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

Jump_00D_48C5::
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
    ld c, $0E
    call SRAMRecordAddress
    ld a, [hl]
    and a, a
    jr z, Jump_00D_48E9
    xor a, a
    jr Jump_00D_48EB

Jump_00D_48E9::
    ld a, $01

Jump_00D_48EB::
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

; copies box Data_00D_5022 to wC3BB, runs Func_01E_71E1, draws the page-of-pages indicator when wD7B0 >= 2, and wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. EggServiceMenu_Case0F_DrawBox5022WithPageIndicator)
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
    jr c, Jump_00D_494A
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_00D_494A::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in EggServiceMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1, wArg2, wScreenStep, wScriptCommandType, wScriptStartRequest
EggServiceMenu_Case05_DrawRecordListPageMarks::
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

; entry 18 of the `rst $00` table in EggServiceMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
EggServiceMenu_Case05_Case12::
Jump_00D_4988:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw EggServiceMenu_Case05_Case12_EndScriptCommandAndIncScreenSubStep
    dw EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM
    dw EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case02
    dw EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case03
    dw EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case04
    dw EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case05
    dw EggServiceMenu_Case05_Case12_SubtractArg1AmountFromGold

; entry 0 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor
EggServiceMenu_Case05_Case12_EndScriptCommandAndIncScreenSubStep::
Jump_00D_499A:: ; address name
    xor a, a
    ld [wTwoChoiceCursor], a
    call EndScriptCommandAndIncScreenSubStep
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM::
Jump_00D_49A2:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld c, $00
    ld de, $0000

Jump_00D_49AA::
    push hl
    push bc
    push de
    ld a, c
    ld de, Data_00D_49FD
    add a, e
    ld e, a
    jr nc, Jump_00D_49B6
    inc d

Jump_00D_49B6::
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
    jr c, Jump_00D_49AA
    ld l, e
    ld h, d
    ld a, $06
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00D_49DC

Jump_00D_49D8::
    ld a, $03
    jr Jump_00D_49F2

Jump_00D_49DC::
    ld a, l
    cp a, $C9
    jr nc, Jump_00D_49D8
    cp a, $65
    jr nc, Jump_00D_49EC
    cp a, $33
    jr nc, Jump_00D_49F0
    xor a, a
    jr Jump_00D_49F2

Jump_00D_49EC::
    ld a, $02
    jr Jump_00D_49F2

Jump_00D_49F0::
    ld a, $01

Jump_00D_49F2::
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    call EndScriptCommandAndIncScreenSubStep
    ret

; address loaded by EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM
Data_00D_49FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $61, $63, $65, $67, $69

; entry 2 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case02::
Jump_00D_4A03:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, $3C
    call SRAMRecordAddress
    ld c, $00
    ld b, $00

Jump_00D_4A10::
    ld a, [hl+]
    and a, a
    jr z, Jump_00D_4A19
    cp a, $FF
    jr z, Jump_00D_4A19
    inc b

Jump_00D_4A19::
    inc c
    ld a, c
    cp a, $19
    jr c, Jump_00D_4A10
    ld a, b
    cp a, $06
    jr c, Jump_00D_4A31
    cp a, $0B
    jr c, Jump_00D_4A35
    cp a, $10
    jr c, Jump_00D_4A3A
    ld a, $03
    jp Jump_00D_49F2

Jump_00D_4A31::
    xor a, a
    jp Jump_00D_49F2

Jump_00D_4A35::
    ld a, $01
    jp Jump_00D_49F2

Jump_00D_4A3A::
    ld a, $02
    jp Jump_00D_49F2

; entry 3 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case03::
Jump_00D_4A3F:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, $57
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $29
    jr c, Jump_00D_4A5B
    cp a, $3D
    jr c, Jump_00D_4A5F
    cp a, $51
    jr c, Jump_00D_4A64
    ld a, $03
    jp Jump_00D_49F2

Jump_00D_4A5B::
    xor a, a
    jp Jump_00D_49F2

Jump_00D_4A5F::
    ld a, $01
    jp Jump_00D_49F2

Jump_00D_4A64::
    ld a, $02
    jp Jump_00D_49F2

; entry 4 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hTemp1
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case04::
Jump_00D_4A69:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld b, $00
    push hl
    push bc
    ld a, [hl]
    ld c, $6F
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld e, a
    pop bc
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, $72
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, e
    jr c, Jump_00D_4A96
    jr nz, Jump_00D_4A8D
    jr Jump_00D_4A96

Jump_00D_4A8D::
    pop bc
    pop de
    ldh a, [hTemp0]
    ld e, a
    ld b, $01
    push de
    push bc

Jump_00D_4A96::
    pop bc
    pop de
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, $70
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, e
    jr c, Jump_00D_4AB8
    jr nz, Jump_00D_4AAB
    jr Jump_00D_4AB8

Jump_00D_4AAB::
    pop bc
    pop de
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld b, $02
    pop hl
    jr Jump_00D_4ABB

Jump_00D_4AB8::
    pop bc
    pop de
    pop hl

Jump_00D_4ABB::
    ld a, b
    jp Jump_00D_49F2

; entry 5 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: wTwoChoiceCursor, rRAMG2
EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case05::
Jump_00D_4ABF:: ; address name
    call GetListEntriesCell4AddressWithSRAM
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    jp Jump_00D_49F2

; entry 6 of the `rst $00` table in EggServiceMenu_Case05_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6
; writes: wArg1, wArg2, wArg3, rRAMG2, rRAMB, wScreenSubStep, wScreenStep, wScriptCommandType, ...
EggServiceMenu_Case05_Case12_SubtractArg1AmountFromGold::
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
    ld c, $6E
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

; enables SRAM (bank 0), far-calls SetArg5ToListEntriesCell4 and returns HL = wD7F5 (high) / wD7F6 (low) (E-0119)
; 5 call sites from 5 routines (e.g. EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case05, EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case04, EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case03, EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM_Case02, ...)
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

; wD782 += 1, wScriptCommandType = 0, wScriptStartRequest = $80 (E-0119)
; 2 call sites from 2 routines (e.g. EggServiceMenu_Case05_Case12_GetListEntriesCell4AddressWithSRAM, EggServiceMenu_Case05_Case12_EndScriptCommandAndIncScreenSubStep)
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

; entry 15 of the `rst $00` table in EggServiceMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Case0F::
Jump_00D_4B5D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Case0F_DecompressToVRAM
    dw EggServiceMenu_Case0F_CopyGlyphTileListFromBank1F
    dw EggServiceMenu_Case0F_FillTilesBxC
    dw EggServiceMenu_Case0F_DrawBox5022WithPageIndicator
    dw EggServiceMenu_Case0F_DrawRecordListPageSpeciesNames
    dw EggServiceMenu_Case0F_DrawRecordListPageMarks
    dw EggServiceMenu_Case0F_StoreBAtWordTableEntry_Bank0D
    dw EggServiceMenu_Case0F_Number24ToPackedBCD
    dw EggServiceMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics

; entry 0 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
EggServiceMenu_Case0F_DecompressToVRAM::
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

; entry 1 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Case0F_CopyGlyphTileListFromBank1F::
Jump_00D_4B98:: ; address name
    ld hl, TileCopyDestList_0D_509F
    ld de, TileCopySrcList_0D_50AF
    call CopyGlyphTileListFromBank1F
    call DrawPair4F81And4F9FAndStep
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
; points at: wTextWindowTileLo
EggServiceMenu_Case0F_FillTilesBxC::
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

; entry 3 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
EggServiceMenu_Case0F_DrawBox5022WithPageIndicator::
Jump_00D_4BDE:: ; address name
    call DrawBox5022WithPageIndicator

; entry 4 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
EggServiceMenu_Case0F_DrawRecordListPageSpeciesNames::
Jump_00D_4BE1:: ; address name
    ld a, $01
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
EggServiceMenu_Case0F_DrawRecordListPageMarks::
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

; entry 6 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
EggServiceMenu_Case0F_StoreBAtWordTableEntry_Bank0D::
Jump_00D_4C17:: ; address name
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_00D_5097
    call StoreBAtWordTableEntry_Bank0D
    ld de, TileRect_0D_50BD
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteBD, wScreenStep
; writes: wDigits, wStringIndex, wStringCategory, wScreenStep
; points at: wArg4, wTextBuf0, wTextWindowTileLo
EggServiceMenu_Case0F_Number24ToPackedBCD::
Jump_00D_4C36:: ; address name
    ld a, [wScreenByteBD]
    and a, a
    jr z, Jump_00D_4C78
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

Jump_00D_4C59::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_4C64
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, Jump_00D_4C59

Jump_00D_4C64::
    ld de, wTextBuf0

Jump_00D_4C67::
    ld a, b
    and a, a
    jr z, Jump_00D_4C71
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr Jump_00D_4C67

Jump_00D_4C71::
    ld a, $F0
    ld [de], a
    ld a, $08
    jr Jump_00D_4C7A

Jump_00D_4C78::
    ld a, $03

Jump_00D_4C7A::
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

; entry 8 of the `rst $00` table in EggServiceMenu_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
EggServiceMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics::
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
; 4 call sites from 3 routines (e.g. EggServiceMenu_Case05_IsAmountInArg1AboveGold, EggServiceMenu_Case05_UpdatePagedListCursor, EggServiceMenu_Case0F_Number24ToPackedBCD)
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
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    ld c, $14
    call Multiply8
    ld a, $14
    add_a_to_hl
    ret

; up/down moves wD7AD between two entries; A sets wD7F5 = $FF (with sound $69 and the arrow tile), B sets $FE; otherwise blinks the cursor and wD7F5 = 0 (E-0127)
; 5 call sites from 5 routines (e.g. EggServiceMenu_Case05_HandleTwoChoiceCursorInput_0D, EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0A, GameMode6_Update_Case04_HandleTwoChoiceCursorInput_0D, GameMode6_Update_Case05_HandleTwoChoiceCursorInput_0D, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wChoiceCursor
; writes: wArg5, wChoiceCursor
HandleTwoChoiceCursorInput_0D::
Func_00D_4D24:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00D_4D44
    bit 7, a
    jr nz, Jump_00D_4D62
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00D_4D72
    bit 1, a
    jp nz, Jump_00D_4D80
    call BlinkCursorBlinkAE_Bank0D
    xor a, a
    ld [wArg5], a
    ret

Jump_00D_4D44::
    call DrawBlankTileC3_Bank0D
    ld a, [wChoiceCursor]
    and a, a
    jr nz, Jump_00D_4D51
    ld a, $01
    jr Jump_00D_4D52

Jump_00D_4D51::
    dec a

Jump_00D_4D52::
    ld [wChoiceCursor], a
    ld a, $69
    call QueueSoundEffect
    call DrawCursorTileBB_Bank0D
    xor a, a
    ld [wArg5], a
    ret

Jump_00D_4D62::
    call DrawBlankTileC3_Bank0D
    ld a, [wChoiceCursor]
    cp a, $01
    jr c, Jump_00D_4D6F
    xor a, a
    jr Jump_00D_4D52

Jump_00D_4D6F::
    inc a
    jr Jump_00D_4D52

Jump_00D_4D72::
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtChoiceCursorEntry
    ld a, $FF
    ld [wArg5], a
    ret

Jump_00D_4D80::
    ld a, $FE
    ld [wArg5], a
    ret

; once the joypad repeat timer reaches $14, cycles wD7AE through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
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
    jr Jump_00D_4DAA

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleTwoChoiceCursorInput_0D)
; reads: wChoiceCursor
DrawBlankTileC3_Bank0D::
Func_00D_4DA4:: ; address name
    ld b, $C3
    jr Jump_00D_4DAA

; B = $BC, then writes B at the scroll position + Data_00D_4DC7[wD7AD] (the shared tile-at-entry draw) (E-0124)
; 1 call site from 1 routine (e.g. HandleTwoChoiceCursorInput_0D)
; reads: wChoiceCursor
DrawArrowTileBCAtChoiceCursorEntry::
Func_00D_4DA8:: ; address name
    ld b, $BC

Jump_00D_4DAA::
    ld a, [wChoiceCursor]
    add a, a
    ld hl, Data_00D_4DC7
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
Data_00D_4DC7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 21 call sites from 21 routines (e.g. EggServiceMenu_Case01_CopyRectTo20ByteRows_Bank0D, EggServiceMenu_Case01_Number24ToPackedBCD, DrawBox5022WithPageIndicator, EggServiceMenu_Case0F_StoreBAtWordTableEntry_Bank0D, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank0D::
Func_00D_4DCB:: ; address name
    push hl
    push bc

Jump_00D_4DCD::
    push bc
    push hl

Jump_00D_4DCF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00D_4DCF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00D_4DCD
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

Jump_00D_4DF1::
    push bc
    push hl

Jump_00D_4DF3::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_4DF3
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00D_4DF1
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 = HL + $1C1, replaced by $99C1 when that is $9B61 (E-0062)
; 30 call sites from 27 routines (e.g. MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D, EggServiceMenu_Case01_CopyRectTo20ByteRows_Bank0D, EggServiceMenu_Case05_DrawRecordListPageMarks, EggServiceMenu_Case0F_LoadPlayerAndFollowerSpriteGraphics, ...)
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
    jr nz, Jump_00D_4E39
    ld a, [wTextCursorHi]
    cp a, $9B
    jr nz, Jump_00D_4E39
    ld a, $C1
    ld [wTextCursorLo], a
    ld a, $99
    ld [wTextCursorHi], a

Jump_00D_4E39::
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
; 35 call sites from 32 routines (e.g. MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D, RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D, EggServiceMenu_Case01_CopyRectTo20ByteRows_Bank0D, EggServiceMenu_Case05_DrawRecordListPageMarks, ...)
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

Jump_00D_4E88::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_4E88
    xor a, a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 9 call sites from 9 routines (e.g. EggServiceMenu_Case05_UpdatePagedListCursor, EggServiceMenu_Case0F_StoreBAtWordTableEntry_Bank0D, EraseCEntriesOfWordTable_Bank0D, KeyAppraisalMenu_Case03_UpdatePagedListCursor, ...)
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
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_Case03_ClampKeyListPageCursor, MedalPrizeMenu_DrawC5BEC6AtScrollOffsetDE_Bank0D)
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
; 4 call sites from 4 routines (e.g. DrawBox5022WithPageIndicator, KeyAppraisalMenu_Case03_Case07_StoreC5BEC6AtHLStride2_Bank0D, KeyAppraisalMenu_Case03_ClampKeyListPageCursor, MedalPrizeMenu_DrawC5BEC6AtScrollOffsetDE_Bank0D)
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

; copies a wD7F1 x wD7F2 block inside the screen buffer from offset DE to offset HL, C rows, with CGB attributes (E-0127)
; 4 call sites from 4 routines (e.g. MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D, RenameMenu_Case03_CopyScreenBufferRectWithAttrs_0D, KeyAppraisalMenu_Case03_LoadPlayerAndFollowerSpriteGraphics_Case10, RunFunc4ED5At0278AndStep_0D)
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
    jr z, Jump_00D_4F16
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

Jump_00D_4F16::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_00D_4F25
    inc d

Jump_00D_4F25::
    dec c
    jr nz, CopyScreenBufferRectWithAttrs_0D
    ret

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL (StoreBAtWordTableEntry_Bank0D) (E-0122)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_Case03_EraseCEntriesOfWordTable_Bank0D, MedalPrizeMenu_Case05_EraseCEntriesOfWordTable_Bank0D)
EraseCEntriesOfWordTable_Bank0D::
Func_00D_4F29:: ; address name
    ld a, c
    ld b, a
    ld c, $00

Jump_00D_4F2D::
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
    jr c, Jump_00D_4F2D
    ret

; for each entry from wD785 of the destination list at HL and the source list at DE copies a 16-byte tile from bank $1F, until $FF; then clears wD784/5 (E-0125)
; 3 call sites from 3 routines (e.g. DrawPair4F81And4F9FAndStep, EggServiceMenu_Case0F_CopyGlyphTileListFromBank1F, NpcBreedMenu_Case11_CopyGlyphTileListFromBank1F)
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
    jp z, Jump_00D_4F77
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
    jr nc, Jump_00D_4F5E
    inc d

Jump_00D_4F5E::
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

Jump_00D_4F77::
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

; address loaded by EggServiceMenu_Case05_UpdatePagedListCursor, EggServiceMenu_Case0F_StoreBAtWordTableEntry_Bank0D
Data_00D_5097:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

; implements script command type F0 (SCRIPT_RENAME): the Christener's renaming: 'Pick the monster to rename.' (runs EggServiceMenu's first state, so mode 6); reached through ScriptCommandF0 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF0)
; reads: wScreenState
RenameMenu::
Func_00D_5159:: ; address name
    ld a, [wScreenState]
    rst $00
    dw RenameMenu_ToEggServiceMenu
    dw RenameMenu_Case01
    dw RenameMenu_UpdateTwoChoiceCursor_Bank1D
    dw RenameMenu_Case03
    dw RenameMenu_Case04
    dw RenameMenu_LoadSRAMRecordByte
    dw RenameMenu_Case06

; entry 0 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
RenameMenu_ToEggServiceMenu::
Jump_00D_516B:: ; address name
    farcall EggServiceMenu
    ret

; entry 1 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RenameMenu_Case01::
Jump_00D_5172:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw LoadFourFrameTilesAndStep
    dw RenameMenu_Case01_CopyRectTo20ByteRows_Bank0D

; copies four tiles from bank $1F to vTiles1 + $700-$730, then wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. RenameMenu_Case06_LoadFourFrameTilesAndStep)
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

; entry 1 of the `rst $00` table in RenameMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScreenState
RenameMenu_Case01_CopyRectTo20ByteRows_Bank0D::
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
    jr z, Jump_00D_51F6
    cp a, $FF
    jr z, Jump_00D_5205
    ret

Jump_00D_51F6::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_5205::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_51F6
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

; entry 3 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RenameMenu_Case03::
Jump_00D_5221:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RenameMenu_Case03_CopyScreenBufferRectWithAttrs_0D
    dw ClearStringWindowAt1500AndIncScreenStep
    dw RenameMenu_Case03_LoadRecordListNameTiles

; entry 0 of the `rst $00` table in RenameMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
RenameMenu_Case03_CopyScreenBufferRectWithAttrs_0D::
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

; sets the string window to tile destination vTiles1 + $500 and size word $0F01, then FillTilesFromRequest (clears it); then wD781 += 1 (E-0117)
; 1 call site from 1 routine (e.g. RenameMenu_Case06_LoadFourFrameTilesAndStep)
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

; entry 2 of the `rst $00` table in RenameMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
RenameMenu_Case03_LoadRecordListNameTiles::
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
RenameMenu_Case04::
Jump_00D_52A7:: ; address name
    call RenameMenu_Case04_Sub01_WriteGridCursorY_Sub01
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
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wArg2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $1F
    ld [wArg3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0B
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

; entry 6 of the `rst $00` table in RenameMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RenameMenu_Case06::
Jump_00D_530F:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RenameMenu_Case06_DecompressToVRAM
    dw RenameMenu_Case06_LoadFourFrameTilesAndStep
    dw RenameMenu_Case06_SRAMRecordAddress
    dw RenameMenu_Case06_ShowPickTheMonsterTo
    dw RenameMenu_Case06_LoadPlayerAndFollowerSpriteGraphics

; entry 0 of the `rst $00` table in RenameMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
RenameMenu_Case06_DecompressToVRAM::
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

; entry 1 of the `rst $00` table in RenameMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
RenameMenu_Case06_LoadFourFrameTilesAndStep::
Jump_00D_5342:: ; address name
    call LoadFourFrameTilesAndStep
    call ClearStringWindowAt1500AndIncScreenStep
    ld a, $02
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RenameMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorX, wScreenStep
; writes: rRAMG2, rRAMB, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
; points at: wPartyList, wNameGlyphBuf
RenameMenu_Case06_SRAMRecordAddress::
Jump_00D_534E:: ; address name
    ld a, [wGridCursorX]
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wNameGlyphBuf
    ld c, $00

Jump_00D_536D::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_537C
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_00D_536D
    jr Jump_00D_537F

Jump_00D_537C::
    ld a, $F0
    ld [hl], a

Jump_00D_537F::
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

; entry 3 of the `rst $00` table in RenameMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wScreenStep
RenameMenu_Case06_ShowPickTheMonsterTo::
Jump_00D_53A4:: ; address name
    xor a, a
    ld [wStringCategory], a
    ld a, $23
    ld [wStringIndex], a ; 'Pick the monster to rename.'
    farcall ShowString_BankF2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RenameMenu_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wScreenSubStep, wScreenStep, wScreenState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
RenameMenu_Case06_LoadPlayerAndFollowerSpriteGraphics::
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
; 1 call site from 1 routine (e.g. RenameMenu_Case04)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenState, wPartyCount, wGridCursorX
; writes: wTwoChoiceCursor, wScreenState, wListCursor, wChoiceCursor, wListPageIndex, wScriptCommandType, wScriptStartRequest, wNameEntryState, ...
RenameMenu_Case04_Sub01_WriteGridCursorY_Sub01::
Func_00D_5412:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00D_542E
    bit 7, a
    jr nz, Jump_00D_5460
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00D_5479
    bit 1, a
    jp nz, Jump_00D_54A6
    call RenameMenu_Case04_Sub01_WriteGridCursorY
    ret

Jump_00D_542E::
    call RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03
    ld a, [wPartyCount]
    cp a, $02
    jr c, Jump_00D_543E
    ld a, [wGridCursorX]
    and a, a
    jr nz, Jump_00D_5449

Jump_00D_543E::
    ld a, [wPartyCount]
    dec a
    ld [wGridCursorX], a
    call RenameMenu_Case04_Sub01_WriteGridCursorY
    ret

Jump_00D_5449::
    dec a

Jump_00D_544A::
    ld [wGridCursorX], a
    xor a, a
    ld [wListCursor], a
    ld [wChoiceCursor], a
    ld [wListPageIndex], a
    call RenameMenu_Case04_Sub01_ReadGridCursorX
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00D_5460::
    call RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03
    ld a, [wPartyCount]
    dec a
    ld b, a
    ld a, [wGridCursorX]
    cp a, b
    jr c, Jump_00D_5476
    xor a, a
    ld [wGridCursorX], a
    call RenameMenu_Case04_Sub01_WriteGridCursorY
    ret

Jump_00D_5476::
    inc a
    jr Jump_00D_544A

Jump_00D_5479::
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

Jump_00D_54A6::
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
; 3 call sites from 1 routine (e.g. RenameMenu_Case04_Sub01_WriteGridCursorY_Sub01)
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
; 1 call site from 1 routine (e.g. RenameMenu_Case04_Sub01_WriteGridCursorY_Sub01)
; reads: wGridCursorX
RenameMenu_Case04_Sub01_ReadGridCursorX::
Func_00D_54DB:: ; address name
    ld b, $BB
    jr Jump_00D_54E5

; only called from RenameMenu_Case04_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. RenameMenu_Case04_Sub01_WriteGridCursorY_Sub01)
; reads: wGridCursorX
RenameMenu_Case04_Sub01_ReadGridCursorX_Sub03::
Func_00D_54DF:: ; address name
    ld b, $C3
    jr Jump_00D_54E5

; only called from RenameMenu_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RenameMenu_Case04_Sub01_WriteGridCursorY_Sub01)
; reads: wGridCursorX
RenameMenu_Case04_Sub01_BGMapAddressAtScroll_Bank0D::
Func_00D_54E3:: ; address name
    ld b, $BC

Jump_00D_54E5::
    ld a, [wGridCursorX]
    sla a
    ld hl, Data_00D_5504
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
Data_00D_5504:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    dw KeyAppraisalMenu_Case01
    dw KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D
    dw KeyAppraisalMenu_Case03

; entry 0 of the `rst $00` table in KeyAppraisalMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
KeyAppraisalMenu_CopyBytesDEToHL_Bank0D::
Jump_00D_55CA:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_00D_55D0::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_55D0
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_55F5
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_55F5::
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

; entry 1 of the `rst $00` table in KeyAppraisalMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
KeyAppraisalMenu_Case01::
Jump_00D_5633:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw DrawGoldBoxAndStep
    dw KeyAppraisalMenu_Case01_CopyRectTo20ByteRows_Bank0D

; copies box Data_00D_4FBD to wC370 and writes the gold as five digit tiles at wC386, then wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_Case03_LoadPlayerAndFollowerSpriteGraphics_Case10)
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

Jump_00D_566A::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00D_566A
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in KeyAppraisalMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScreenState
KeyAppraisalMenu_Case01_CopyRectTo20ByteRows_Bank0D::
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
    jr z, Jump_00D_56BD
    cp a, $FF
    jr z, Jump_00D_56CC
    ret

Jump_00D_56BD::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_56CC::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_56BD
    call KeyAppraisalMenu_Case02_Sub01
    cp a, $FF
    jr nz, Jump_00D_56E9
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_56E9::
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

; only called from KeyAppraisalMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_UpdateTwoChoiceCursor_Bank1D)
KeyAppraisalMenu_Case02_Sub01::
Func_00D_5702:: ; address name
    ld c, $00

Jump_00D_5704::
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
    jr nz, Jump_00D_5720
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_00D_5704
    ld a, $FF
    ret

Jump_00D_5720::
    xor a, a
    ret

; entry 3 of the `rst $00` table in KeyAppraisalMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
KeyAppraisalMenu_Case03::
Jump_00D_5722:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw KeyAppraisalMenu_Case03_BuildKeyListIndexListEntries
    dw KeyAppraisalMenu_Case03_FillTilesFromRequest
    dw KeyAppraisalMenu_Case03_ClampKeyListPageCursor
    dw KeyAppraisalMenu_Case03_DrawKeyListPageNames
    dw KeyAppraisalMenu_Case03_BGMapAddressAtScroll_Bank0D
    dw KeyAppraisalMenu_Case03_UpdatePagedListCursor
    dw KeyAppraisalMenu_Case03_CopyRectTo20ByteRows_Bank0D
    dw KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D
    dw KeyAppraisalMenu_Case03_EraseCEntriesOfWordTable_Bank0D
    dw KeyAppraisalMenu_Case03_ToCopyRect70C5ToWC364AndDrawAndStep
    dw KeyAppraisalMenu_Case03_ShowSaveFileInfoWindow
    dw KeyAppraisalMenu_Case03_DrawBottomBoxForLinkAndSetScreenSubStep
    dw KeyAppraisalMenu_Case03_CopyRectTo20ByteRows_Bank0D
    dw KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D_Case0D
    dw KeyAppraisalMenu_Case03_RunSaveGameSteps_7347
    dw KeyAppraisalMenu_Case03_BlankTwoTilePairsAndDraw
    dw KeyAppraisalMenu_Case03_LoadPlayerAndFollowerSpriteGraphics_Case10
    dw KeyAppraisalMenu_Case03_Case11
    dw KeyAppraisalMenu_Case03_LoadPlayerAndFollowerSpriteGraphics

; entry 18 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_Case03_LoadPlayerAndFollowerSpriteGraphics::
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

; entry 0 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
KeyAppraisalMenu_Case03_BuildKeyListIndexListEntries::
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

; entry 1 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
KeyAppraisalMenu_Case03_FillTilesFromRequest::
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

; entry 2 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg5, wArg1, wArg2, wScreenStep
KeyAppraisalMenu_Case03_ClampKeyListPageCursor::
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
    jr c, Jump_00D_583D
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

Jump_00D_583D::
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_00D_62B0
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
KeyAppraisalMenu_Case03_DrawKeyListPageNames::
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

; entry 4 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
KeyAppraisalMenu_Case03_BGMapAddressAtScroll_Bank0D::
Jump_00D_5872:: ; address name
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_00D_62B0
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuInputResult, wArg5, wArg6, wListCursor, wScreenStep
; writes: wMenuInputResult, wTwoChoiceCursor, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest, ...
; points at: wTextBuf0
KeyAppraisalMenu_Case03_UpdatePagedListCursor::
Jump_00D_5891:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, Jump_00D_58B9
    ld a, $03
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_58C0
    cp a, $FC
    jr z, Jump_00D_58C0
    cp a, $FE
    jr z, Jump_00D_58C9
    cp a, $FF
    jr z, Jump_00D_58D8
    ret

Jump_00D_58B9::
    farcall KeyAppraisalMenu_Case03_Case05_CopyWD09EToKeyList
    ret

Jump_00D_58C0::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_00D_58C9::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_58D8::
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
    jr z, Jump_00D_591E
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

Jump_00D_591E::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_00D_62B0
    call StoreBAtWordTableEntry_Bank0D
    ld de, wTextBuf0
    ld a, $01
    call KeyAppraisalMenu_WriteDigits
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

; entry 7 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArg1, wScreenStep
; writes: wArg1, wArg2, wArg3, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep, wScreenSubStep, ...
KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_595C:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_5970
    cp a, $FF
    jr z, Jump_00D_599F
    ret

Jump_00D_5970::
    call KeyAppraisalMenu_Case03_Case07_StoreC5BEC6AtHLStride2_Bank0D
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

Jump_00D_599F::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_5970
    xor a, a
    call KeyAppraisalMenu_WriteDigits
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr nz, Jump_00D_59D2
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_59D2::
    call KeyAppraisalMenu_Case03_Case07_StoreC5BEC6AtHLStride2_Bank0D
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

; only called from KeyAppraisalMenu_Case03_Case07 (E-0047)
; 2 call sites from 1 routine (e.g. KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D)
; reads: wListPages
; writes: wArg1, wArg2
KeyAppraisalMenu_Case03_Case07_StoreC5BEC6AtHLStride2_Bank0D::
Func_00D_5A05:: ; address name
    ld de, TileRect_0D_6292
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_00D_5A2F
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank0D
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_00D_5A2F::
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; entry 9 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
KeyAppraisalMenu_Case03_ToCopyRect70C5ToWC364AndDrawAndStep::
Jump_00D_5A3C:: ; address name
    farcall CopyRect70C5ToWC364AndDraw
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wScreenStep
KeyAppraisalMenu_Case03_ShowSaveFileInfoWindow::
Jump_00D_5A4A:: ; address name
    farcall ShowSaveFileInfoWindow
    xor a, a
    ld [wStringCategory], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wTextFlags, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenSubStep, wScreenStep, wScriptCommandType, wScriptStartRequest, ...
KeyAppraisalMenu_Case03_DrawBottomBoxForLinkAndSetScreenSubStep::
Jump_00D_5A5C:: ; address name
    call KeyAppraisalMenu_WriteRAMG2AndRAMB
    ld a, [wScreenSubStep]
    cp a, $02
    jr z, Jump_00D_5A87
    cp a, $03
    jr z, Jump_00D_5A9A
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

Jump_00D_5A87::
    ld a, $0B
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank0D
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_00D_5A9A::
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

; entry 6 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep
KeyAppraisalMenu_Case03_CopyRectTo20ByteRows_Bank0D::
Jump_00D_5AB4:: ; address name
    call KeyAppraisalMenu_WriteRAMG2AndRAMB
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

; entry 8 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_Case03_EraseCEntriesOfWordTable_Bank0D::
Jump_00D_5AE3:: ; address name
    ld c, $04
    ld hl, Data_00D_62B0
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

; entry 13 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D_Case0D::
Jump_00D_5B06:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp a, $FE
    jr z, Jump_00D_5B1B
    cp a, $FF
    jr z, Jump_00D_5B27
    call KeyAppraisalMenu_WriteRAMG2AndRAMB
    ret

Jump_00D_5B1B::
    call BlankTwoTilePairsAndDraw
    ld a, [wScreenStep]
    add a, $05
    ld [wScreenStep], a
    ret

Jump_00D_5B27::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_5B1B
    call KeyAppraisalMenu_WriteRAMG2AndRAMB
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

; entry 14 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wSaveStep, wScreenStep, wArg5, wArg6
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep, wScriptCommandType, wScriptByte68, wScriptStartRequest, wSaveStep, wSaveRecordIndex, ...
KeyAppraisalMenu_Case03_RunSaveGameSteps_7347::
Jump_00D_5B4A:: ; address name
    call KeyAppraisalMenu_WriteRAMG2AndRAMB
    ld a, [wScreenSubStep]
    and a, a
    jr z, Jump_00D_5B7C
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

Jump_00D_5B7C::
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
    call KeyAppraisalMenu_WriteDigits
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

; entry 15 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wScreenStep
; points at: wTextBuf0
KeyAppraisalMenu_Case03_BlankTwoTilePairsAndDraw::
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

; entry 16 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest, wArg1, wArg2, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_Case03_LoadPlayerAndFollowerSpriteGraphics_Case10::
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

; entry 17 of the `rst $00` table in KeyAppraisalMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScreenState, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
KeyAppraisalMenu_Case03_Case11::
Jump_00D_5C17:: ; address name
    call KeyAppraisalMenu_Case03_Case11_Sub01
    cp a, $FF
    jr nz, Jump_00D_5C38
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

Jump_00D_5C38::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; writes $C3 to wC3B0-wC3B1 and wC3C4-wC3C5, then DrawScreenBufferRect_Bank0D (20 x 13 at the scroll origin) (E-0119)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_Case03_BlankTwoTilePairsAndDraw, KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D_Case0D)
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

; only called from KeyAppraisalMenu_Case03_Case11 (E-0047)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_Case03_Case11)
; points at: wKeyList
KeyAppraisalMenu_Case03_Case11_Sub01::
Func_00D_5C60:: ; address name
    ld hl, wKeyList
    ld c, $00
    ld b, $00

Jump_00D_5C67::
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00D_5C83
    cp a, $FF
    jr z, Jump_00D_5C72
    inc b

Jump_00D_5C72::
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
    jr c, Jump_00D_5C67
    xor a, a
    ret

Jump_00D_5C83::
    pop hl
    ld a, $FF
    ret

; wD7B0 = the number of 4-entry pages of wD7A9 keys; clamps the page wD7AF and the cursor wD7AB to the last page's size (wD7B1) (E-0127)
; 3 call sites from 3 routines (e.g. KeyAppraisalMenu_Case03_ClampKeyListPageCursor, MedalPrizeMenu_Case05_ClampKeyListPageCursor, RunScreenStateWhenNotFading_1B_Case01_ClampKeyListPageCursor)
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
    jr z, Jump_00D_5C97
    inc l

Jump_00D_5C97::
    ld a, l
    ld [wListPages], a
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr c, Jump_00D_5CD2
    pop af
    push af
    and a, a
    jr nz, Jump_00D_5CB7
    ld a, [wListPageIndex]
    inc a
    cp a, l
    jr z, Jump_00D_5CD2
    ld a, [wListPageIndex]
    dec a
    ld [wListPageIndex], a
    jr Jump_00D_5CD2

Jump_00D_5CB7::
    pop af
    dec a
    ld [wListLastRow], a
    ld b, a
    ld a, [wListCursor]
    cp a, b
    jr c, Jump_00D_5CD8
    jr z, Jump_00D_5CD8
    push bc
    push hl
    call EraseCursorForArg5Layout
    pop hl
    pop bc
    ld a, b
    ld [wListCursor], a
    jr Jump_00D_5CD8

Jump_00D_5CD2::
    pop af
    ld a, $03
    ld [wListLastRow], a

Jump_00D_5CD8::
    ret

; writes blank $C3 at the scroll position + the cursor offset for wD7AB from table Data_00D_5D0E, 5D16 or 5D1E (by wD7F5) (E-0125)
; 1 call site from 1 routine (e.g. ClampKeyListPageCursor)
; reads: wArg5, wListCursor
EraseCursorForArg5Layout::
Func_00D_5CD9:: ; address name
    ld b, $C3
    ld a, [wArg5]
    and a, a
    jr z, Jump_00D_5CEF
    cp a, $01
    jr z, Jump_00D_5CEA
    ld hl, Data_00D_5D1E
    jr Jump_00D_5CF2

Jump_00D_5CEA::
    ld hl, Data_00D_5D16
    jr Jump_00D_5CF2

Jump_00D_5CEF::
    ld hl, Data_00D_5D0E

Jump_00D_5CF2::
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
Data_00D_5D0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A6, $00, $C6, $00, $E6, $00, $06, $01

; address loaded by EraseCursorForArg5Layout
Data_00D_5D16:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A4, $00, $C4, $00, $E4, $00, $04, $01

; address loaded by EraseCursorForArg5Layout
Data_00D_5D1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $C2, $00, $E2, $00, $02, $01

; blanks the four mark positions and draws marks for the keys on the current page of wD789 (E-0130)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_Case03_DrawKeyListPageNames, RunScreenStateWhenNotFading_1B_Case01_DrawKeyListPageNames)
; reads: wArg5, wListPageIndex, wListLastRow, wListCount, wListPages
; points at: wListEntries, wKeyList
DrawKeyListPageMarks::
Func_00D_5D26:: ; address name
    ld a, [wArg5]
    and a, a
    jr nz, Jump_00D_5D31
    ld de, Data_00D_5DDD
    jr Jump_00D_5D34

Jump_00D_5D31::
    ld de, Data_00D_5DE5

Jump_00D_5D34::
    ld b, $04

Jump_00D_5D36::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, $C3
    ld [hl], a
    inc de
    dec b
    jr nz, Jump_00D_5D36
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld a, [hl]
    ld c, $00

Jump_00D_5D54::
    ld a, [wListLastRow]
    cp a, $03
    jr c, Jump_00D_5D60
    ld a, [wListCount]
    jr Jump_00D_5D6F

Jump_00D_5D60::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_00D_5D6C
    ld a, [wListCount]
    jr Jump_00D_5D6F

Jump_00D_5D6C::
    ld a, [wListCount]

Jump_00D_5D6F::
    ld b, a
    ld a, [wListPageIndex]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_5DDC
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
    jr z, Jump_00D_5DCC
    cp a, $FF
    jr z, Jump_00D_5DCC
    bit 6, a
    jr z, Jump_00D_5DA1
    ld b, $CA
    jr Jump_00D_5DA3

Jump_00D_5DA1::
    ld b, $C3

Jump_00D_5DA3::
    ld a, [wArg5]
    and a, a
    jr nz, Jump_00D_5DAE
    ld de, Data_00D_5DDD
    jr Jump_00D_5DB8

Jump_00D_5DAE::
    ld de, Data_00D_5DE5
    ld a, b
    cp a, $C3
    jr z, Jump_00D_5DB8
    ld b, $70

Jump_00D_5DB8::
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_5DC0
    inc d

Jump_00D_5DC0::
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

Jump_00D_5DCC::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_00D_5DDC
    ld a, c
    cp a, $04
    jp c, Jump_00D_5D54

Jump_00D_5DDC::
    ret

; address loaded by DrawKeyListPageMarks
Data_00D_5DDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CD, $C3, $F5, $C3, $1D, $C4, $45, $C4

; address loaded by DrawKeyListPageMarks
Data_00D_5DE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

; for the keys on the current page writes their names to wC8CF and draws them; generated keys (kind $FE) are shown as "Magic Key" (E-0130)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_Case03_DrawKeyListPageNames, RunScreenStateWhenNotFading_1B_Case01_DrawKeyListPageNames)
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

Jump_00D_5DFE::
    ld a, [wListLastRow]
    cp a, $03
    jr c, Jump_00D_5E0A
    ld a, [wListCount]
    jr Jump_00D_5E19

Jump_00D_5E0A::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_00D_5E16
    ld a, [wListCount]
    jr Jump_00D_5E19

Jump_00D_5E16::
    ld a, [wListCount]

Jump_00D_5E19::
    ld b, a
    ld a, [wListPageIndex]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_5ED5
    push hl
    push bc
    ld a, [hl]
    sla a
    sla a
    ld de, wKeyList
    add a, e
    ld e, a
    jr nc, Jump_00D_5E35
    inc d

Jump_00D_5E35::
    ld a, [de]
    cp a, $FE
    jr nz, Jump_00D_5E60
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
    jr Jump_00D_5EC0

Jump_00D_5E60::
    inc de
    inc de
    inc de
    ld a, [de]
    bit 7, a
    jr z, Jump_00D_5EB2
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
    jr Jump_00D_5EC0

Jump_00D_5EB2::
    ld a, [hl]
    ld de, wNameGlyphBuf
    call WriteKeyNameToDE
    ld a, $5B
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a

Jump_00D_5EC0::
    pop bc
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wListCount]
    cp a, c
    jr z, Jump_00D_5ED5
    ld a, c
    cp a, $04
    jp c, Jump_00D_5DFE

Jump_00D_5ED5::
    ret

; draws the $F0-terminated text at wC8CF glyph by glyph; marks $8D and $8E are ORed onto the previous tile instead of taking a new one (E-0125)
; 2 call sites from 2 routines (e.g. DrawKeyListPageNames, MedalPrizeMenu_Case05_Case03_Sub01)
; reads: wGlyphListPos, wGlyphListStart
; writes: wGlyphListPos, wGlyphListStart
; points at: wNameGlyphBuf
DrawNameGlyphBufGlyphsOverlaying8DAnd8E::
Func_00D_5ED6:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wGlyphListStart], a
    ld hl, wNameGlyphBuf

Jump_00D_5EE0::
    ld a, [wGlyphListPos]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_00D_5F23
    cp a, $8D
    jr z, Jump_00D_5F01
    cp a, $8E
    jr z, Jump_00D_5F01
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_ReadArg5AndGlyphListStart
    call CopyFromBankWaitVRAM
    pop bc
    jr Jump_00D_5F12

Jump_00D_5F01::
    push af
    ld a, [wGlyphListStart]
    dec a
    ld [wGlyphListStart], a
    pop af
    push bc
    call DrawNameGlyphBufGlyphsOverlaying8DAnd8E_ReadArg5AndGlyphListStart
    call OrFromBankWaitVRAM
    pop bc

Jump_00D_5F12::
    pop hl
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jr Jump_00D_5EE0

Jump_00D_5F23::
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
    jr z, Jump_00D_5F63
    cp a, $01
    jr z, Jump_00D_5F5E
    cp a, $02
    jr z, Jump_00D_5F59
    ld de, GlyphTileDestTable3
    jr Jump_00D_5F66

Jump_00D_5F59::
    ld de, GlyphTileDestTable2
    jr Jump_00D_5F66

Jump_00D_5F5E::
    ld de, GlyphTileDestTable1
    jr Jump_00D_5F66

Jump_00D_5F63::
    ld de, GlyphTileDestTable0

Jump_00D_5F66::
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_5F6E
    inc d

Jump_00D_5F6E::
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

; clears wD789 ($20 bytes), then lists the indexes of the used wKeyList entries there and stores their count in wD7A9 (E-0125)
; 2 call sites from 2 routines (e.g. KeyAppraisalMenu_Case03_BuildKeyListIndexListEntries, RunScreenStateWhenNotFading_1B_Case01_BuildKeyListIndexListEntries)
; writes: wListCount
; points at: wListEntries, wKeyList
BuildKeyListIndexListEntries::
Func_00D_60C3:: ; address name
    ld hl, wListEntries
    ld b, $20

Jump_00D_60C8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_60C8
    xor a, a
    ld [wListCount], a
    ld de, wKeyList
    ld hl, wListEntries
    ld b, $00
    ld c, $00

Jump_00D_60DB::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00D_60E3
    inc c
    ld a, b
    ld [hl+], a

Jump_00D_60E3::
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_00D_60EA
    inc d

Jump_00D_60EA::
    inc b
    ld a, b
    cp a, $20
    jr c, Jump_00D_60DB
    ld a, c
    ld [wListCount], a
    ret

; only called from KeyAppraisalMenu_Shared01 (E-0047)
; 2 call sites from 1 routine (e.g. KeyAppraisalMenu_WriteDigits)
; reads: wListPageIndex, wListCursor
; points at: wListEntries, wKeyList
KeyAppraisalMenu_Shared01_ReadListPageIndexAndListCursor::
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

; only called from routines of KeyAppraisalMenu (E-0098)
; 3 call sites from 3 routines (e.g. KeyAppraisalMenu_Case03_RunSaveGameSteps_7347, KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D, KeyAppraisalMenu_Case03_UpdatePagedListCursor)
; writes: wDigits
; points at: wArg1
KeyAppraisalMenu_WriteDigits::
Func_00D_6120:: ; address name
    and a, a
    jr nz, Jump_00D_6127
    call KeyAppraisalMenu_Shared01_ReadListPageIndexAndListCursor
    ret

Jump_00D_6127::
    call KeyAppraisalMenu_Shared01_ReadListPageIndexAndListCursor
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

Jump_00D_6146::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_6154
    inc hl
    dec c
    jr nz, Jump_00D_6146
    xor a, a
    ld [de], a
    inc de
    jr Jump_00D_615A

Jump_00D_6154::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_00D_6154

Jump_00D_615A::
    ld a, $F0
    ld [de], a
    ret

; only called from routines of KeyAppraisalMenu (E-0098)
; 5 call sites from 4 routines (e.g. KeyAppraisalMenu_Case03_RunSaveGameSteps_7347, KeyAppraisalMenu_Case03_UpdateTwoChoiceCursor_Bank1D_Case0D, KeyAppraisalMenu_Case03_DrawBottomBoxForLinkAndSetScreenSubStep, KeyAppraisalMenu_Case03_CopyRectTo20ByteRows_Bank0D)
; reads: wScreenStep
; writes: rRAMG2, rRAMB
; points at: sSavedPlayerName
KeyAppraisalMenu_WriteRAMG2AndRAMB::
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
    jr nz, Jump_00D_617B

Jump_00D_6173::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_00D_617B::
    ld a, [wScreenStep]
    cp a, $0B
    jr c, Jump_00D_6173
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

; address loaded by KeyAppraisalMenu_Case03_ClampKeyListPageCursor, KeyAppraisalMenu_Case03_BGMapAddressAtScroll_Bank0D, KeyAppraisalMenu_Case03_UpdatePagedListCursor, KeyAppraisalMenu_Case03_EraseCEntriesOfWordTable_Bank0D
Data_00D_62B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    script_message $8003 ; 'Don't come if you have no'
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
    script_message $C009 ; 'That key's been appraised already.'
    script_message $C008 ; 'Which Magic Key should I appraise?'
    script_jump Script_0D_62CD
Script_0D_62DE:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'Appraisal will cost 0G. OK?'
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_62F3, Script_0D_62ED, Script_0D_62E6
Script_0D_62E6:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'Which Magic Key should I appraise?'
    script_command SCRIPT_KEY_APPRAISAL
    script_jump Script_0D_62CD
Script_0D_62ED:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $8007 ; 'Hah? I'm not appraising any key'
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
    script_message $C00F ; 'Let's see the Magic Key, then.'
    script_command SCRIPT_KEY_APPRAISAL
    script_choice_jump Script_0D_630A, Script_0D_6304
Script_0D_6304:: ; heuristic: event script entry or jump target; C0
    script_message $C00A ; 'You have no more Magic Keys'
    script_jump Script_0D_62BE
Script_0D_630A:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'Which Magic Key should I appraise?'
    script_jump Script_0D_62CD

; implements script command type F3 (SCRIPT_MEDAL_PRIZES): the TinyMedal prize exchange: 'Which prize do you want?', 'I'll trade for 0 TinyMedals. OK?' (mode 7); reached through ScriptCommandF3 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandF3)
; reads: wScreenState
MedalPrizeMenu::
Func_00D_6310:: ; address name
    ld a, [wScreenState]
    rst $00
    dw MedalPrizeMenu_CopyBytesDEToHL_Bank0D
    dw MedalPrizeMenu_Case01
    dw MedalPrizeMenu_Case02
    dw MedalPrizeMenu_Case03
    dw MedalPrizeMenu_UpdateTwoChoiceCursor_Bank1D
    dw MedalPrizeMenu_Case05

; entry 2 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArenaWinsHi, wArenaWinsLo, wScreenState
; writes: wScreenState, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextBuf0, wDigits
MedalPrizeMenu_Case02::
Jump_00D_6320:: ; address name
    ld a, [wArenaWinsHi]
    and a, a
    jr nz, Jump_00D_6345
    ld a, [wArenaWinsLo]
    and a, a
    jr z, Jump_00D_6336
    cp a, $01
    jr z, Jump_00D_6336
    cp a, $02
    jr z, Jump_00D_6336
    jr Jump_00D_6345

Jump_00D_6336::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_6345::
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
    jr z, Jump_00D_6362
    ld [hl+], a

Jump_00D_6362::
    inc de
    ld a, [de]
    cp a, $E3
    jr z, Jump_00D_6369
    ld [hl+], a

Jump_00D_6369::
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
MedalPrizeMenu_Case01::
Jump_00D_6384:: ; address name
    call MedalPrizeMenu_Shared04
    push af
    ld a, [wArenaWinsLo]
    ld l, a
    ld a, [wArenaWinsHi]
    ld h, a
    pop af
    cp a, $FF
    jr nz, Jump_00D_6397
    jr Jump_00D_63CB

Jump_00D_6397::
    push af
    add_a_to_hl
    ld a, h
    cp a, $03
    jr c, Jump_00D_63CF
    jr nz, Jump_00D_63A9
    ld a, l
    cp a, $E8
    jr c, Jump_00D_63CF

Jump_00D_63A9::
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
    jr z, Jump_00D_63C1
    ld hl, wInventory
    ld c, $00
    call MedalPrizeMenu_Case01_Sub01

Jump_00D_63C1::
    ld a, $03
    ld [wArenaWinsHi], a
    ld a, $E7
    ld [wArenaWinsLo], a

Jump_00D_63CB::
    ld a, $01
    jr Jump_00D_63E2

Jump_00D_63CF::
    pop af
    ld b, a
    ld a, l
    ld [wArenaWinsLo], a
    ld a, h
    ld [wArenaWinsHi], a
    ld hl, wInventory
    ld c, $00
    call MedalPrizeMenu_Case01_Sub01
    xor a, a

Jump_00D_63E2::
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from MedalPrizeMenu_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. MedalPrizeMenu_Case01)
; points at: wInventory
MedalPrizeMenu_Case01_Sub01::
Func_00D_63F6:: ; address name
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, Jump_00D_640D
    xor a, a
    ld [hl], a
    pop bc
    pop hl
    push hl
    push bc
    dec b
    ld a, b
    and a, a
    jr nz, Jump_00D_640D
    pop hl
    pop bc
    jr Jump_00D_6416
    db $C9

Jump_00D_640D::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, MedalPrizeMenu_Case01_Sub01

Jump_00D_6416::
    ld hl, wInventory
    ld de, wInventory + $1
    ld b, $17

Jump_00D_641E::
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6428
    inc hl
    inc de
    dec b
    jr nz, Jump_00D_641E
    ret

Jump_00D_6428::
    ld a, [de]
    and a, a
    jr nz, Jump_00D_6431
    inc de
    dec b
    jr nz, Jump_00D_6428
    ret

Jump_00D_6431::
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_641E
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

Jump_00D_6440::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_6440
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank0D
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_6465
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_6465::
    ld a, $07
    ld [wMessageMode], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    call MedalPrizeMenu_Shared04
    cp a, $FF
    jr z, Jump_00D_6488
    xor a, a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_6488::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
MedalPrizeMenu_Case03::
Jump_00D_649C:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw MedalPrizeMenu_Case03_CopyFromBankWaitVRAM
    dw DrawArenaWinsLoCountBoxAndStep
    dw MedalPrizeMenu_Case03_CopyRectTo20ByteRows_Bank0D

; entry 0 of the `rst $00` table in MedalPrizeMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
MedalPrizeMenu_Case03_CopyFromBankWaitVRAM::
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

; copies box Data_00D_6EB7 to wC36D and writes the word wC838 as three digits (leading blanks) at wC388, then wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0D)
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

Jump_00D_652E::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00D_652E
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in MedalPrizeMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wTwoChoiceCursor, wScreenStep, wScreenState
MedalPrizeMenu_Case03_CopyRectTo20ByteRows_Bank0D::
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
    jr z, Jump_00D_6581
    cp a, $FF
    jr z, Jump_00D_6590
    ret

Jump_00D_6581::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_6590::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_6581
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

; entry 5 of the `rst $00` table in MedalPrizeMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
MedalPrizeMenu_Case05::
Jump_00D_65D0:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw MedalPrizeMenu_Case05_CopyRectTo20ByteRows_Bank0D
    dw MedalPrizeMenu_Case05_FillTilesFromRequest
    dw MedalPrizeMenu_Case05_ClampKeyListPageCursor
    dw MedalPrizeMenu_Case05_WriteArg5AndScreenStep
    dw MedalPrizeMenu_Case05_BGMapAddressAtScroll_Bank0D
    dw MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor
    dw MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor_Case06
    dw MedalPrizeMenu_Case05_Case07
    dw MedalPrizeMenu_Case05_CopyRectTo20ByteRows_Bank0D_Case08
    dw MedalPrizeMenu_Case05_UpdateTwoChoiceCursor_Bank1D
    dw MedalPrizeMenu_Case05_EraseCEntriesOfWordTable_Bank0D
    dw MedalPrizeMenu_Case05_MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D
    dw MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4
    dw MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0D
    dw MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0E

; entry 0 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
MedalPrizeMenu_Case05_CopyRectTo20ByteRows_Bank0D::
Jump_00D_65F2:: ; address name
    ld de, TileRect_0D_6ED8
    ld hl, wWindowTileBuffer + $B7
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0D
    call MedalPrizeMenu_Case05_Case00_WriteListCount
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
MedalPrizeMenu_Case05_FillTilesFromRequest::
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

; entry 2 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListPageIndex, wListPages, wListCursor, wScreenStep, wArenaByte37
; writes: wArg5, wScreenStep
MedalPrizeMenu_Case05_ClampKeyListPageCursor::
Jump_00D_6668:: ; address name
    ld a, [wListPageIndex]
    and a, a
    jr nz, Jump_00D_6678
    ld de, Data_00D_6F71
    jr Jump_00D_6681

Jump_00D_6673::
    ld de, Data_00D_7043
    jr Jump_00D_6681

Jump_00D_6678::
    ld a, [wArenaByte37]
    and a, a
    jr nz, Jump_00D_6673
    ld de, TileRect_0D_6FDA

Jump_00D_6681::
    ld hl, wWindowTileBuffer + $CC
    ld bc, $0F07
    call CopyRectTo20ByteRows_Bank0D
    ld a, $01
    ld [wArg5], a
    call ClampKeyListPageCursor
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_00D_669C
    call MedalPrizeMenu_DrawC5BEC6AtScrollOffsetDE_Bank0D

Jump_00D_669C::
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_00D_7106
    call StoreBAtWordTableEntry_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
MedalPrizeMenu_Case05_WriteArg5AndScreenStep::
Jump_00D_66BB:: ; address name
    ld a, $01
    ld [wArg5], a
    call MedalPrizeMenu_Case05_Case03_Sub01
    call MedalPrizeMenu_Shared05
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
MedalPrizeMenu_Case05_BGMapAddressAtScroll_Bank0D::
Jump_00D_66CE:: ; address name
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_00D_7106
    call StoreBAtWordTableEntry_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wTwoChoiceCursor, wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep, ...
; points at: wTextBuf0
MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor::
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
    jr c, Jump_00D_6707
    ld a, $01

Jump_00D_6707::
    ld [wTwoChoiceCursor], a
    cp a, $01
    jr z, Jump_00D_6744
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

Jump_00D_6744::
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

Jump_00D_6761::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_676A
    ld [hl+], a
    inc de
    jr Jump_00D_6761

Jump_00D_676A::
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

; entry 6 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wTextFlags, wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenByteBD
MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor_Case06::
Jump_00D_67A3:: ; address name
    ld b, $BB
    call WriteTileBAtCursorListCursor
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00D_67E4
    bit 7, a
    jr nz, Jump_00D_67E8
    bit 4, a
    jr nz, Jump_00D_67EC
    bit 5, a
    jr nz, Jump_00D_67F0
    bit 1, a
    jr nz, Jump_00D_67CB
    bit 0, a
    jr nz, Jump_00D_67CB
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    jr Jump_00D_67CE

Jump_00D_67CB::
    call ShowString_Bank0D

Jump_00D_67CE::
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

Jump_00D_67E4::
    ld a, $01
    jr Jump_00D_67F2

Jump_00D_67E8::
    ld a, $02
    jr Jump_00D_67F2

Jump_00D_67EC::
    ld a, $03
    jr Jump_00D_67F2

Jump_00D_67F0::
    ld a, $04

Jump_00D_67F2::
    ld [wScreenByteBD], a
    jr Jump_00D_67CE

; entry 7 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteBD, wMenuInputResult, wScreenStep, wListCursor, wArg5, wArg6, wDigits
; writes: wJoypadPressedRepeat, wMenuInputResult, wTwoChoiceCursor, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wTextBuf0
MedalPrizeMenu_Case05_Case07::
Jump_00D_67F7:: ; address name
    ld a, [wScreenByteBD]
    and a, a
    jr z, Jump_00D_6827
    cp a, $01
    jr z, Jump_00D_6822
    cp a, $02
    jr z, Jump_00D_681B
    cp a, $03
    jr z, Jump_00D_6814
    cp a, $04
    jr z, Jump_00D_680D

Jump_00D_680D::
    ld a, $20
    ld [wJoypadPressedRepeat], a
    jr Jump_00D_6827

Jump_00D_6814::
    ld a, $10
    ld [wJoypadPressedRepeat], a
    jr Jump_00D_6827

Jump_00D_681B::
    ld a, $80
    ld [wJoypadPressedRepeat], a
    jr Jump_00D_6827

Jump_00D_6822::
    ld a, $40
    ld [wJoypadPressedRepeat], a

Jump_00D_6827::
    ld a, $04
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_684C
    cp a, $FC
    jr z, Jump_00D_684C
    cp a, $FD
    jr z, Jump_00D_6867
    cp a, $FE
    jr z, Jump_00D_6882
    cp a, $FF
    jr z, Jump_00D_6891
    ret

Jump_00D_684C::
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

Jump_00D_6867::
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

Jump_00D_6882::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_6891::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_00D_7106
    call StoreBAtWordTableEntry_Bank0D
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_68BE
    inc d

Jump_00D_68BE::
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld hl, wTextBuf0
    ld a, [wDigits + $1]
    cp a, $E3
    jr z, Jump_00D_68D6
    ld [hl+], a

Jump_00D_68D6::
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

; entry 8 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep
MedalPrizeMenu_Case05_CopyRectTo20ByteRows_Bank0D_Case08::
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

; entry 9 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wArg5, wArg6, wArenaWinsHi, wArenaWinsLo, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenSubStep
MedalPrizeMenu_Case05_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_6929:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_693D
    cp a, $FF
    jr z, Jump_00D_6956
    ret

Jump_00D_693D::
    call MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D
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

Jump_00D_6956::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_693D
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6974
    inc d

Jump_00D_6974::
    ld a, [de]
    ld b, a
    ld a, [wArenaWinsHi]
    and a, a
    jr nz, Jump_00D_6999
    ld a, [wArenaWinsLo]
    cp a, b
    jr nc, Jump_00D_6999
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

Jump_00D_6999::
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

; only called from routines of MedalPrizeMenu (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_Case05_MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D, MedalPrizeMenu_Case05_UpdateTwoChoiceCursor_Bank1D)
; reads: wListPageIndex, wArenaByte37
MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D::
Func_00D_69B3:: ; address name
    ld a, [wListPageIndex]
    and a, a
    jr nz, Jump_00D_69C3
    ld de, Data_00D_70AC
    jr Jump_00D_69CC

Jump_00D_69BE::
    ld de, Data_00D_70CA
    jr Jump_00D_69CC

Jump_00D_69C3::
    ld a, [wArenaByte37]
    and a, a
    jr nz, Jump_00D_69BE
    ld de, TileRect_0D_70E8

Jump_00D_69CC::
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0D
    call MedalPrizeMenu_Shared05
    call MedalPrizeMenu_DrawC5BEC6AtScrollOffsetDE_Bank0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; entry 10 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_Case05_EraseCEntriesOfWordTable_Bank0D::
Jump_00D_69E8:: ; address name
    ld c, $04
    ld hl, Data_00D_7106
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

; entry 11 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_Case05_MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D::
Jump_00D_6A0B:: ; address name
    call MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4::
Jump_00D_6A1F:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6A63
    call MedalPrizeMenu_WriteRAMG2AndRAMB
    cp a, $FF
    jr nz, Jump_00D_6A4E
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

Jump_00D_6A4E::
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

Jump_00D_6A63::
    call MedalPrizeMenu_Shared03
    cp a, $FF
    jr nz, Jump_00D_6A4E
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

; if the key list is full (FindFreeKeySlotToTemp0 returns bit 7), wTwoChoiceCursor = 2, steps wD781 back and requests script $80; otherwise continues at Jump_00D_6A4E (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptStepCheckKeyListFull_6A80:: ; heuristic: follows a terminator; C0
Func_00D_6A80:: ; address name
    farcall FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_00D_6A4E
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

; entry 13 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wArenaWinsLo, wArenaWinsHi
; writes: wArenaWinsHi, wArenaWinsLo, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0D::
Jump_00D_6AA2:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push hl
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6ABA
    inc d

Jump_00D_6ABA::
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
    jr nc, Jump_00D_6ADD
    xor a, a
    jr Jump_00D_6ADF

Jump_00D_6ADD::
    ld a, $01

Jump_00D_6ADF::
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 14 of the `rst $00` table in MedalPrizeMenu_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0E::
Jump_00D_6AEC:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    push af
    and a, a
    jr z, Jump_00D_6B07
    call MedalPrizeMenu_WriteRAMG2AndRAMB
    call MedalPrizeMenu_Case05_Case0E_SetArg5ToListEntriesCell4
    jr Jump_00D_6B15

Jump_00D_6B07::
    call MedalPrizeMenu_Shared03
    ld a, $1E
    ld [hl], a
    jr Jump_00D_6B15
    db $21, $9A, $68, $06, $12, $D7

Jump_00D_6B15::
    pop af
    and a, a
    jr z, Jump_00D_6B3A
    call MedalPrizeMenu_WriteRAMG2AndRAMB
    cp a, $FF
    jr nz, Jump_00D_6B24
    ld a, $03
    jr Jump_00D_6B25

Jump_00D_6B24::
    xor a, a

Jump_00D_6B25::
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_6B3A::
    call MedalPrizeMenu_Shared03
    cp a, $FF
    jr nz, Jump_00D_6B24
    ld a, $01
    jr Jump_00D_6B25

; if the key list is full, continues with A = 2 at Jump_00D_6B25; otherwise at Jump_00D_6B24 (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
ScriptStepCheckKeyListFull_6B45:: ; heuristic: follows a terminator; C0
Func_00D_6B45:: ; address name
    farcall FindFreeKeySlotToTemp0
    ldh a, [hTemp0]
    bit 7, a
    jr z, Jump_00D_6B24
    ld a, $02
    jr Jump_00D_6B25

; only called from MedalPrizeMenu_Case05_Case0E (E-0047)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0E)
; reads: wArg5, wArg6, wRecordBuffer, wSpeciesRecord, wChildRecord, wRecordBufferData, wScreenAttrBuffer
; writes: wMonsterId, wSpeciesIdLo, wSpeciesIdHi, wChildRecord, rRAMG2, rRAMB
; points at: wRecordBufA, wPlayerName
MedalPrizeMenu_Case05_Case0E_SetArg5ToListEntriesCell4::
Func_00D_6B55:: ; address name
    push hl
    ld hl, wRecordBufA
    ld b, $A5

Jump_00D_6B5B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6B5B
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
    ld [wChildRecord + $B], a
    ld a, [wRecordBuffer + $1]
    ld [hl+], a
    ld [wChildRecord + $C], a
    ld a, [wSpeciesRecord]
    ld [hl+], a
    push hl
    farcall RollWCADEFromSpeciesFlag
    pop hl
    ld a, [wChildRecord + $E]
    ld [hl+], a
    ld de, wPlayerName
    ld c, $00

Jump_00D_6BCB::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_6BDA
    ld [hl+], a
    inc c
    inc de
    ld a, c
    cp a, $0A
    jr c, Jump_00D_6BCB
    jr Jump_00D_6BED

Jump_00D_6BDA::
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0A
    jr z, Jump_00D_6BED
    ld a, $0A
    sub a, c
    ld b, a

Jump_00D_6BE7::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6BE7

Jump_00D_6BED::
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

Jump_00D_6C01::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6C01
    push hl
    ld b, $19

Jump_00D_6C0A::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6C0A
    pop hl
    ld a, [wSpeciesRecord + $8]
    ld [hl+], a
    ld a, [wSpeciesRecord + $9]
    ld [hl+], a
    ld a, [wSpeciesRecord + $A]
    ld [hl+], a
    ld a, $16
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wSpeciesRecord + $6]
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
    ld de, wSpeciesRecord + $12
    ld b, $1B

Jump_00D_6C8E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_6C8E
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

Jump_00D_6CAF::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_6CAF
    xor a, a
    ld [rRAMG2], a
    ret

; writes ten $F0 (blank) bytes at HL, without a terminator (E-0122)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_Case05_Case0E_SetArg5ToListEntriesCell4)
WriteBlankName10_Bank0D::
Func_00D_6CBA:: ; address name
    ld b, $0A
    jr Jump_00D_6CC5

; writes '???' ($98 x 3) and seven $F0 bytes at HL, without a terminator (E-0122)
; 4 call sites from 1 routine (e.g. MedalPrizeMenu_Case05_Case0E_SetArg5ToListEntriesCell4)
WriteUnknownNamePlaceholder_Bank0D::
Func_00D_6CBE:: ; address name
    ld a, $98
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld b, $07

Jump_00D_6CC5::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6CC5
    ret

; only called from routines of MedalPrizeMenu (E-0098)
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0E, MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4)
; reads: wFarmLevel
; writes: rRAMG2, rRAMB
; points at: sRecords
MedalPrizeMenu_WriteRAMG2AndRAMB::
Func_00D_6CCC:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld c, $00
    ld a, [wFarmLevel]
    ld de, Data_00D_6D06
    add a, e
    ld e, a
    jr nc, Jump_00D_6CE5
    inc d

Jump_00D_6CE5::
    ld a, [de]
    ld b, a

Jump_00D_6CE7::
    push hl
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6D00
    cp a, $FF
    jr z, Jump_00D_6D00
    pop hl
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6CE7
    ld a, $FF
    ret

Jump_00D_6D00::
    pop hl
    xor a, a
    ld [rRAMG2], a
    ret

; address loaded by MedalPrizeMenu_WriteRAMG2AndRAMB
Data_00D_6D06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

; only called from routines of MedalPrizeMenu (E-0098)
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0E, MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4)
; points at: wInventory
MedalPrizeMenu_Shared03::
Func_00D_6D09:: ; address name
    ld hl, wInventory
    ld c, $00

Jump_00D_6D0E::
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6D20
    cp a, $FF
    jr z, Jump_00D_6D20
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_00D_6D0E
    ld a, $FF
    ret

Jump_00D_6D20::
    xor a, a
    ret

; A = 0 when one of the 12 four-byte wKeyList entries is free ($FF), else $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wKeyList
KeyListHasFreeSlot:: ; heuristic: follows a terminator; C0
Func_00D_6D22:: ; address name
    ld hl, wKeyList
    ld c, $00

Jump_00D_6D27::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00D_6D3C
    ld a, $04
    add_a_to_hl
    inc c
    ld a, c
    cp a, $0C
    jr c, Jump_00D_6D27
    ld a, $FF
    ret

Jump_00D_6D3C::
    xor a, a
    ret

; only called from routines of MedalPrizeMenu (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D, MedalPrizeMenu_Case05_WriteArg5AndScreenStep)
; reads: wListPageIndex, wArenaByte37, wDigits
MedalPrizeMenu_Shared05::
Func_00D_6D3E:: ; address name
    ld a, [wListPageIndex]
    add a, a
    add a, a
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6D4B
    inc d

Jump_00D_6D4B::
    ld a, [wListPageIndex]
    and a, a
    jr z, Jump_00D_6D60
    ld a, [wArenaByte37]
    and a, a
    jr nz, Jump_00D_6D64
    ld a, [wListPageIndex]
    ld b, a
    ld a, $03
    sub a, b
    jr Jump_00D_6D66

Jump_00D_6D60::
    ld a, $04
    jr Jump_00D_6D66

Jump_00D_6D64::
    ld a, $03

Jump_00D_6D66::
    ld b, a
    ld c, $00

Jump_00D_6D69::
    push de
    push bc
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    ld de, Data_00D_6D9F
    pop bc
    push bc
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_6D85
    inc d

Jump_00D_6D85::
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
    jr c, Jump_00D_6D69
    ret

; address loaded by MedalPrizeMenu_Shared05
Data_00D_6D9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D7, $C3, $FF, $C3, $27, $C4, $4F, $C4

; writes B at BGMapAddressAtScroll + the offset from Data_00D_6DC8[wD7AB] (WaitForVRAMAccess, interrupts off); BC kept (E-0120)
; 3 call sites from 2 routines (e.g. MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor_Case06, MedalPrizeMenu_Case05_WriteTileBAtCursorListCursor)
; reads: wListCursor
WriteTileBAtCursorListCursor::
Func_00D_6DA7:: ; address name
    push bc
    ld a, [wListCursor]
    sla a
    ld hl, Data_00D_6DC8
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
Data_00D_6DC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A4, $00, $E4, $00, $24, $01, $64, $01

; only called from routines of MedalPrizeMenu (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_Case01, MedalPrizeMenu_CopyBytesDEToHL_Bank0D)
; points at: wInventory
MedalPrizeMenu_Shared04::
Func_00D_6DD0:: ; address name
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_00D_6DD7::
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, Jump_00D_6DE1
    pop bc
    inc b
    push bc

Jump_00D_6DE1::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_00D_6DD7
    ld a, b
    and a, a
    jr z, Jump_00D_6DEF
    ret

Jump_00D_6DEF::
    ld a, $FF
    ret

; only called from MedalPrizeMenu_Case05_Case00 (E-0047)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_Case05_CopyRectTo20ByteRows_Bank0D)
; reads: wArenaByte37
; writes: wListCount
; points at: wListEntries
MedalPrizeMenu_Case05_Case00_WriteListCount::
Func_00D_6DF2:: ; address name
    ld a, [wArenaByte37]
    and a, a
    jr nz, Jump_00D_6DFC
    ld b, $06
    jr Jump_00D_6DFE

Jump_00D_6DFC::
    ld b, $07

Jump_00D_6DFE::
    ld hl, wListEntries
    ld c, $00

Jump_00D_6E03::
    ld a, c
    ld [hl+], a
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6E03
    ld [wListCount], a
    ret

; only called from MedalPrizeMenu_Case05_Case03 (E-0047)
; 1 call site from 1 routine (e.g. MedalPrizeMenu_Case05_WriteArg5AndScreenStep)
; reads: wListPageIndex, wListLastRow, wListCount, wListPages
; points at: wListEntries, wNameGlyphBuf
MedalPrizeMenu_Case05_Case03_Sub01::
Func_00D_6E0E:: ; address name
    ld hl, wListEntries
    ld a, [wListPageIndex]
    sla a
    sla a
    add_a_to_hl
    ld c, $00

Jump_00D_6E1F::
    ld a, [wListLastRow]
    cp a, $03
    jr c, Jump_00D_6E2B
    ld a, [wListCount]
    jr Jump_00D_6E3A

Jump_00D_6E2B::
    ld a, [wListPages]
    cp a, $01
    jr nz, Jump_00D_6E37
    ld a, [wListCount]
    jr Jump_00D_6E3A

Jump_00D_6E37::
    ld a, [wListCount]

Jump_00D_6E3A::
    ld b, a
    ld a, [wListPageIndex]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_6E87
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

Jump_00D_6E66::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_6E6F
    ld [hl+], a
    inc de
    jr Jump_00D_6E66

Jump_00D_6E6F::
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
    jr z, Jump_00D_6E87
    ld a, c
    cp a, $04
    jp c, Jump_00D_6E1F

Jump_00D_6E87::
    ret

; only called from routines of MedalPrizeMenu (E-0098)
; 2 call sites from 2 routines (e.g. MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D, MedalPrizeMenu_Case05_ClampKeyListPageCursor)
; writes: wArg1, wArg2
MedalPrizeMenu_DrawC5BEC6AtScrollOffsetDE_Bank0D::
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

; address loaded by MedalPrizeMenu_Case05_ClampKeyListPageCursor
Data_00D_6F71:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

; address loaded by MedalPrizeMenu_Case05_ClampKeyListPageCursor
Data_00D_7043:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3

; address loaded by MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D
Data_00D_70AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

; address loaded by MedalPrizeMenu_CopyRectTo20ByteRows_Bank0D
Data_00D_70CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

; address loaded by MedalPrizeMenu_Case05_ClampKeyListPageCursor, MedalPrizeMenu_Case05_BGMapAddressAtScroll_Bank0D, MedalPrizeMenu_Case05_Case07, MedalPrizeMenu_Case05_EraseCEntriesOfWordTable_Bank0D
Data_00D_7106:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $C3, $F4, $C3, $1C, $C4, $44, $C4

; address loaded by MedalPrizeMenu_Case05_Case07, MedalPrizeMenu_Case05_UpdateTwoChoiceCursor_Bank1D, MedalPrizeMenu_Case05_SetArg5ToListEntriesCell4_Case0D, MedalPrizeMenu_Shared05
Data_00D_710E:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    dw NpcBreedMenu_Case04
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_SwapMonstersMenu_SwapMonstersMenu
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Return
    dw NpcBreedMenu_Case11

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

; entry 4 of the `rst $00` table in NpcBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
NpcBreedMenu_Case04::
Jump_00D_7159:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_SetArg5ToListEntriesCell5
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_SetTwoChoiceCursor
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_BreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw RunFunc4ED5At0278AndStep_0D
    dw NpcBreedMenu_Case04_ToBreedMenu
    dw NpcBreedMenu_Case04_SetArg5ToListEntriesCell5_Case11
    dw NpcBreedMenu_Case04_PrepareWCF8BCountersAndRequestScript
    dw NpcBreedMenu_Case04_WriteScreenStep
    dw NpcBreedMenu_Case04_ComputeBreedingChild
    dw NpcBreedMenu_Case04_QueueSoundEffect
    dw NpcBreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D
    dw NpcBreedMenu_Case04_Case17
    dw NpcBreedMenu_Case04_ToRedrawFullScreenBoxes_0CAndStep
    dw NpcBreedMenu_Case04_DispatchTalkEvent
    dw NpcBreedMenu_Case04_ToRestorePlayerPositionState_Bank0DAndStep
    dw NpcBreedMenu_Case04_CopyBytesDEToHL_Bank0D

; entry 0 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_Case04_ToBreedMenu::
Jump_00D_7195:: ; address name
    farcall BreedMenu
    ret

; entry 12 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_Case04_BreedMenu::
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

; entry 4 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
NpcBreedMenu_Case04_SetArg5ToListEntriesCell5::
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

; entry 9 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
NpcBreedMenu_Case04_SetTwoChoiceCursor::
Jump_00D_71FF:: ; address name
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; runs Func_00D_4ED5 (C = 5, HL = $0278, DE = $00AC, wD7F1/2 = 0/8), then wD781 += 1 (E-0126)
; 1 call site from 1 routine (e.g. NpcBreedMenu_Case04_PrepareWCF8BCountersAndRequestScript)
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

; entry 17 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wScreenStep, wPartyCount, wPartyList, wListCursor, wListPageIndex
; writes: rRAMG2, rRAMB, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wSelectedRecord, wItemGridX, ...
NpcBreedMenu_Case04_SetArg5ToListEntriesCell5_Case11::
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
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, Jump_00D_726A
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

Jump_00D_726A::
    pop hl
    ld a, [wPartyCount]
    cp a, $02
    jr nc, Jump_00D_7295
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_00D_7295
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

Jump_00D_7295::
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

; entry 18 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep
NpcBreedMenu_Case04_PrepareWCF8BCountersAndRequestScript::
Jump_00D_72D0:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr nz, Jump_00D_72E0
    call NpcBreedMenu_Multiply8
    farcall PrepareWCF8BCountersAndRequestScript
    ret

Jump_00D_72E0::
    xor a, a
    ld [wScreenSubStep], a
    call RunFunc4ED5At0278AndStep_0D
    call BGMapAddressAtScroll_Bank0D
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank0D
    ret

; entry 19 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTableIndex, wScreenStep
; writes: wScreenStep
; points at: wRecordBufB
NpcBreedMenu_Case04_WriteScreenStep::
Jump_00D_72F4:: ; address name
    call NpcBreedMenu_Multiply8
    ld a, [wScreenTableIndex]
    sla a
    ld de, PresetMonsterRecordTable
    add a, e
    ld e, a
    jr nc, Jump_00D_7304
    inc d

Jump_00D_7304::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wRecordBufB
    ld b, $A5

Jump_00D_730E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_730E
    ld hl, wRecordBufA + $E
    ld a, [hl]
    and a, $01
    inc a
    and a, $01
    ld hl, wRecordBufB + $E
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wScreenStep
; writes: wArg1, wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenSubStep
NpcBreedMenu_Case04_ComputeBreedingChild::
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
    call NpcBreedMenu_Case04_Case14_TestBitInFieldAtArg3
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 21 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
NpcBreedMenu_Case04_QueueSoundEffect::
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

; entry 22 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wScreenSubStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
NpcBreedMenu_Case04_UpdateTwoChoiceCursor_Bank1D::
Jump_00D_73AF:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_73C3
    cp a, $FF
    jr z, Jump_00D_73D2
    ret

Jump_00D_73C3::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00D_73D2::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_00D_73C3
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

; entry 23 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep, wSelectedRecord, wArg6, wArg7, wScreenTableIndex
; writes: wTwoChoiceCursor, wScreenSubStep, wScreenStep, wScriptCommandType, wScriptStartRequest, wArg1, wArg2, rRAMG2, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork
NpcBreedMenu_Case04_Case17::
Jump_00D_73F1:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr z, Jump_00D_740F
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

Jump_00D_740F::
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

Jump_00D_7435::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_7435
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
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

Jump_00D_7472::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_7472
    ld a, [wScreenTableIndex]
    sla a
    ld hl, Data_00D_7499
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

; address loaded by NpcBreedMenu_Case04_Case17
Data_00D_7499:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $01, $18, $01, $1A, $01, $25, $01, $29, $01, $32, $00, $33, $00, $34, $00
    db $35, $00, $36, $00

; entry 24 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
NpcBreedMenu_Case04_ToRedrawFullScreenBoxes_0CAndStep::
Jump_00D_74AD:: ; address name
    farcall RedrawFullScreenBoxes_0C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 25 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScreenStep
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, hSpriteWindowClipMode, wScreenStep
NpcBreedMenu_Case04_DispatchTalkEvent::
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

; entry 26 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
NpcBreedMenu_Case04_ToRestorePlayerPositionState_Bank0DAndStep::
Jump_00D_74F1:: ; address name
    call RestorePlayerPositionState_Bank0D
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in NpcBreedMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wScreenTileBuffer, wWindowTileBuffer, wScreenAttrBuffer, wWindowAttrBuffer
NpcBreedMenu_Case04_CopyBytesDEToHL_Bank0D::
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
    jr z, Jump_00D_7532
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0D
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0D

Jump_00D_7532::
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
NpcBreedMenu_SwapMonstersMenu_SwapMonstersMenu::
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

; entry 17 of the `rst $00` table in NpcBreedMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
NpcBreedMenu_Case11::
Jump_00D_7578:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw NpcBreedMenu_Case11_DecompressToVRAM
    dw NpcBreedMenu_Case11_CopyGlyphTileListFromBank1F
    dw NpcBreedMenu_Case11_ToBreedMenu
    dw NpcBreedMenu_Case11_ToBreedMenu
    dw NpcBreedMenu_Case11_ToBreedMenu
    dw NpcBreedMenu_Case04_SetArg5ToListEntriesCell5
    dw NpcBreedMenu_Case11_FillTilesFromRequest
    dw NpcBreedMenu_Case11_SetArg5ToListEntriesCell5
    dw NpcBreedMenu_Case11_ToBreedMenu
    dw NpcBreedMenu_Case11_ToBreedMenu

; entry 2 of the `rst $00` table in NpcBreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
NpcBreedMenu_Case11_ToBreedMenu::
Jump_00D_7590:: ; address name
    farcall BreedMenu
    ret

; entry 0 of the `rst $00` table in NpcBreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenTableIndex, wScreenStep
; writes: wBGPaletteUploadRequest, wScreenStep
; points at: wBGPaletteBuffer
NpcBreedMenu_Case11_DecompressToVRAM::
Jump_00D_7597:: ; address name
    ld a, [wScreenTableIndex]
    ld b, a
    sla a
    add a, b
    push af
    ld hl, Data_00D_75D7
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
    ld hl, Data_00D_7607
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

; address loaded by NpcBreedMenu_Case11_DecompressToVRAM
Data_00D_75D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9
    db $49, $48, $A9, $49, $48, $A9, $49, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B
    db $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48

; address loaded by NpcBreedMenu_Case11_DecompressToVRAM
Data_00D_7607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87
    db $4C, $48, $87, $4C, $48, $87, $4C, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F
    db $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48

; entry 1 of the `rst $00` table in NpcBreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
NpcBreedMenu_Case11_CopyGlyphTileListFromBank1F::
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

; entry 6 of the `rst $00` table in NpcBreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wScreenStep
NpcBreedMenu_Case11_FillTilesFromRequest::
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

; entry 7 of the `rst $00` table in NpcBreedMenu_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wScreenStep
NpcBreedMenu_Case11_SetArg5ToListEntriesCell5::
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

; only called from NpcBreedMenu_Case04_Case14 (E-0047)
; 1 call site from 1 routine (e.g. NpcBreedMenu_Case04_ComputeBreedingChild)
; reads: wArg6, wArg7, wArg5, wChildRecord
; writes: wArg1, wSpeciesIdLo, wArg2, wSpeciesIdHi, wArg3, wArg4, wTwoChoiceCursor
; points at: wMonsterLibraryBuf, wNameGlyphBuf, wTextBuf0, wDigits
NpcBreedMenu_Case04_Case14_TestBitInFieldAtArg3::
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
    jr z, Jump_00D_7737
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
    jr z, Jump_00D_7737
    ld a, [wArg6]
    ld [wSpeciesIdLo], a
    ld a, [wArg7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, Jump_00D_7737
    ld a, $01
    ld [wTwoChoiceCursor], a
    ret

Jump_00D_7737::
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

Jump_00D_774E::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_00D_7758
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_774E

Jump_00D_7758::
    ld a, $90
    ld [de], a
    inc de
    ld a, $A2
    ld [de], a
    inc de
    push de
    ld a, [wChildRecord + $6D]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F_Bank15
    pop de
    ld hl, wDigits
    ld b, $03

Jump_00D_7776::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_7782
    inc hl
    dec b
    ld a, b
    cp a, $01
    jr nz, Jump_00D_7776

Jump_00D_7782::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_7782
    ld a, $F0
    ld [de], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 1 call site from 1 routine (e.g. NpcBreedMenu_Case04_Case14_TestBitInFieldAtArg3)
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
; 1 call site from 1 routine (e.g. NpcBreedMenu_Case04_ToRestorePlayerPositionState_Bank0DAndStep)
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
; 1 call site from 1 routine (e.g. NpcBreedMenu_Case04_SetArg5ToListEntriesCell5)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
LoadFamilyIconTileForRecordB_Bank0D::
Func_00D_7812:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
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

; only called from routines of NpcBreedMenu (E-0098)
; 2 call sites from 2 routines (e.g. NpcBreedMenu_Case04_WriteScreenStep, NpcBreedMenu_Case04_PrepareWCF8BCountersAndRequestScript)
; reads: wSelectedRecord
; writes: rRAMG2, rRAMB
; points at: sRecords, wRecordBufA
NpcBreedMenu_Multiply8::
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

Jump_00D_7853::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_7853
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
    dw Data_00D_799B ; id 1
    dw Data_00D_7A40 ; id 2
    dw Data_00D_7AE5 ; id 3
    dw Data_00D_7B8A ; id 4
    dw Data_00D_7C2F ; id 5
    dw Data_00D_7CD4 ; id 6
    dw Data_00D_7D79 ; id 7
    dw Data_00D_7E1E ; id 8
    dw Data_00D_7EC3 ; id 9
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
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $25, $36, $61, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $12 ; $56: level (E-0122)
    db $23 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0058, $0058, $005C, $005C ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $7F, $00, $5D, $00, $45, $00, $7F, $01, $00, $00, $00, $00 ; $63-$6E
    db $C8, $C8, $96, $50 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $02, $02, $00, $00 ; $73-$82
    db $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_799B:: ; heuristic: preset monster record; C0
    db $01 ; id 1: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $011E ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $08 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $07, $0D, $6B, $6F, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2A ; $56: level (E-0122)
    db $2A ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $00E6, $00E6, $00E0, $00E0 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $E2, $00, $10, $01, $32, $01, $F1, $02, $00, $00, $00, $00 ; $63-$6E
    db $0A, $C8, $B4, $DC ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $00, $00, $02, $00, $01, $02, $00, $00, $01, $00, $00, $02, $00 ; $73-$82
    db $00, $02, $01, $01, $01, $00, $00, $00, $01, $01, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7A40:: ; heuristic: preset monster record; C0
    db $01 ; id 2: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $00BC ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $05 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $13, $33, $6D, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $1C ; $56: level (E-0122)
    db $23 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $007B, $007B, $00AD, $00AD ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $77, $00, $A6, $00, $B4, $00, $65, $01, $00, $00, $00, $00 ; $63-$6E
    db $46, $64, $AA, $D2 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $01, $01, $01, $00, $02, $00, $00, $00, $02, $00, $00, $00, $00 ; $73-$82
    db $01, $01, $02, $02, $02, $01, $01, $01, $03, $03, $00, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7AE5:: ; heuristic: preset monster record; C0
    db $01 ; id 3: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0092 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $04 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $19, $2F, $3C, $9B, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $25 ; $56: level (E-0122)
    db $25 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $00A6, $00A6, $009F, $009F ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $D6, $00, $D4, $00, $9B, $00, $EB, $02, $00, $00, $00, $00 ; $63-$6E
    db $D2, $28, $96, $D2 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $02, $02, $01, $00, $00, $01, $02, $02, $00, $00, $00, $01, $00 ; $73-$82
    db $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7B8A:: ; heuristic: preset monster record; C0
    db $01 ; id 4: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $005E ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $02 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $20, $34, $63, $90, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $20 ; $56: level (E-0122)
    db $23 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0090, $0090, $0040, $0040 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $C6, $00, $4F, $00, $98, $00, $C5, $01, $00, $00, $00, $00 ; $63-$6E
    db $C8, $96, $96, $1E ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $00, $02, $02, $01, $00 ; $73-$82
    db $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7C2F:: ; heuristic: preset monster record; C0
    db $01 ; id 5: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0080 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $03 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $79, $7B, $92, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2E ; $56: level (E-0122)
    db $32 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0174, $0174, $015F, $015F ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $69, $01, $47, $01, $CB, $01, $B1, $01, $00, $00, $00, $00 ; $63-$6E
    db $64, $96, $64, $82 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $03, $03, $00, $01, $00, $02, $01, $01, $01, $00, $00, $03, $00 ; $73-$82
    db $00, $00, $00, $02, $00, $03, $03, $03, $02, $02, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7CD4:: ; heuristic: preset monster record; C0
    db $01 ; id 6: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $010D ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $3A, $3B, $A0, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $35 ; $56: level (E-0122)
    db $35 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0173, $0173, $0246, $0246 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $F8, $00, $A1, $01, $CA, $01, $F4, $01, $00, $00, $00, $00 ; $63-$6E
    db $14, $C8, $64, $B4 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $00, $00, $00, $00, $02, $02, $03, $00, $00, $02, $00, $00, $02, $00 ; $73-$82
    db $00, $00, $02, $03, $02, $01, $00, $00, $00, $00, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7D79:: ; heuristic: preset monster record; C0
    db $01 ; id 7: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0033 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $01 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $19, $82, $9C, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $3B ; $56: level (E-0122)
    db $3B ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $01F6, $01F6, $0147, $0147 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $AD, $01, $BF, $01, $E9, $01, $AB, $01, $00, $00, $00, $00 ; $63-$6E
    db $B4, $8C, $64, $8C ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $02, $00, $00, $02, $00 ; $73-$82
    db $02, $02, $00, $00, $00, $01, $01, $01, $00, $00, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7E1E:: ; heuristic: preset monster record; C0
    db $01 ; id 8: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $010A ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $50, $51, $52, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $2B ; $56: level (E-0122)
    db $37 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0155, $0155, $0135, $0135 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $5D, $01, $3D, $01, $0B, $01, $91, $01, $00, $00, $00, $00 ; $63-$6E
    db $78, $82, $64, $5A ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $00, $00, $01, $02, $00, $02, $02, $02, $03, $01, $01, $02, $00, $00, $03, $00 ; $73-$82
    db $00, $01, $02, $02, $02, $00, $00, $00, $00, $00, $01, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
Data_00D_7EC3:: ; heuristic: preset monster record; C0
    db $01 ; id 9: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $0133 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $08 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; second name, bytes 15-24 (E-0034)
    db $00, $FF, $FF, $FF, $FF, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $19-$28
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $29-$33
    db $6F, $81, $91, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $36 ; $56: level (E-0122)
    db $36 ; $57
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $01D3, $01D3, $01BA, $01BA ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    db $AC, $01, $78, $01, $4B, $01, $E0, $01, $00, $00, $00, $00 ; $63-$6E
    db $78, $64, $64, $82 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $01, $00, $03, $01, $01, $03, $00, $01, $00, $00, $00, $03, $00 ; $73-$82
    db $01, $03, $00, $02, $01, $01, $01, $01, $01, $01, $02, $98, $98, $98, $F0, $F0 ; $83-$92
    db $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00 ; $93-$A3
    db $00 ; $A4: equipped item (E-0125)
    ds $98, $00
