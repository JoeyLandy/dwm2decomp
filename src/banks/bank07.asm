SECTION "Bank 07", ROMX[$4000], BANK[$07]
    db $07

; ld de, this bank's string table / BeginStringDisplay
; 20 call sites from 20 routines (e.g. ShowString_Bank07, DebugMessageTest_Update_ToBeginStringDisplay_Bank07, ShowStringHL_Bank07, RunGameMode5Case01SubStates_SerialSendByte_Case01, ...)
BeginStringDisplay_Bank07::
Func_007_4001:: ; address name
    ld de, $4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_007_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 11 call sites from 9 routines (e.g. PauseMenu_State3_RecordJourney_ShowMaster, GameMode5_Init_InitSoundHardware, GameMode5_Init_Case04_ShowString_Bank07, RunGameMode5Case01SubStates_Case02_Case00_ShowMaster, ...)
ShowString_Bank07::
Func_007_400F:: ; address name
    call BeginStringDisplay_Bank07
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_07_4016::
Data_007_4016:: ; address name
    dw StringList_07_4024 ; id 0
    dw StringList_07_4034 ; id 1
    dw StringList_07_4040 ; id 2
    dw StringList_07_4042 ; id 3
    dw StringList_07_4050 ; id 4
    dw StringList_07_4056 ; id 5
    dw StringList_07_408C ; id 6

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_4024::
Data_007_4024:: ; address name
    dw String_07_00_00 ; id 0
    dw String_07_00_01 ; id 1
    dw String_07_00_02 ; id 2
    dw String_07_00_03 ; id 3
    dw String_07_00_04 ; id 4
    dw String_07_00_05 ; id 5
    dw String_07_00_06 ; id 6
    dw String_07_00_07 ; id 7

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_4034::
Data_007_4034:: ; address name
    dw String_07_01_00 ; id 0
    dw String_07_01_01 ; id 1
    dw String_07_01_02 ; id 2
    dw String_07_01_03 ; id 3
    dw String_07_01_04 ; id 4
    dw String_07_01_05 ; id 5

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_4040::
Data_007_4040:: ; address name
    dw String_07_02_00 ; id 0

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_4042::
Data_007_4042:: ; address name
    dw String_07_03_00 ; id 0
    dw String_07_03_01 ; id 1
    dw String_07_03_02 ; id 2
    dw String_07_03_03 ; id 3
    dw String_07_03_04 ; id 4
    dw String_07_03_05 ; id 5
    dw String_07_03_06 ; id 6

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_4050::
Data_007_4050:: ; address name
    dw String_07_04_00 ; id 0
    dw String_07_04_01 ; id 1
    dw String_07_04_02 ; id 2

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_4056::
Data_007_4056:: ; address name
    dw String_07_05_00 ; id 0
    dw String_07_05_01 ; id 1
    dw String_07_05_02 ; id 2
    dw String_07_05_03 ; id 3
    dw String_07_05_04 ; id 4
    dw String_07_05_05 ; id 5
    dw String_07_05_06 ; id 6
    dw String_07_05_07 ; id 7
    dw String_07_05_08 ; id 8
    dw String_07_05_09 ; id 9
    dw String_07_05_0A ; id 10
    dw String_07_05_0B ; id 11
    dw String_07_05_0C ; id 12
    dw String_07_05_0D ; id 13
    dw String_07_05_0E ; id 14
    dw String_07_05_0F ; id 15
    dw String_07_05_10 ; id 16
    dw String_07_05_11 ; id 17
    dw String_07_05_12 ; id 18
    dw String_07_05_13 ; id 19
    dw String_07_05_14 ; id 20
    dw String_07_05_15 ; id 21
    dw String_07_05_16 ; id 22
    dw String_07_05_17 ; id 23
    dw String_07_05_18 ; id 24
    dw String_07_05_19 ; id 25
    dw String_07_05_1A ; id 26

; E-0217 (derived: category list of StringCategories_07_4016; one pointer per wStringIndex)
; record: string
StringList_07_408C::
Data_007_408C:: ; address name
    dw String_07_06_00 ; id 0
    dw String_07_06_01 ; id 1
    dw String_07_06_02 ; id 2
    dw String_07_06_03 ; id 3
    dw String_07_06_04 ; id 4
    dw String_07_06_05 ; id 5
    dw String_07_06_06 ; id 6
    dw String_07_06_07 ; id 7
    dw String_07_06_08 ; id 8

String_07_00_00:: ; heuristic: string; C0
Data_007_409E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ENIX", $F0

String_07_00_01:: ; heuristic: string; C0
Data_007_40A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DRAGON WARRIOR", $F1
    db "   MONSTERS 2 ", $F0

String_07_00_02:: ; heuristic: string; C0
Data_007_40C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CONTINUE NEW GAME BREEDING KEY TRADEVS MODE  TEAM MODETERRY "
    db "   ", $F0

String_07_00_03:: ; heuristic: string; C0
Data_007_4101:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saved data has", $F1
    db "been lost.", $F7
    db $F0

String_07_00_04:: ; heuristic: string; C0
Data_007_411C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Master", $F0

String_07_00_05:: ; heuristic: string; C0
Data_007_4123:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Game Link", $F1
    db "is not ready.", $FA, $F7
    db $F2, "Please check", $F1
    db "and try again.", $F7
    db $F0

String_07_00_06:: ; heuristic: string; C0
Data_007_415A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DREAM EGG", $F0

String_07_00_07:: ; heuristic: string; C0
Data_007_4164:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Game Link cannot", $F1
    db "be used with", $FA, $F7
    db $F2, "Super Game Boy.", $F7
    db $F0

String_07_01_00:: ; heuristic: string; C0
Data_007_4195:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DuoOwnWL", $A3, $F0

String_07_01_01:: ; heuristic: string; C0
Data_007_419F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yes", $F0

String_07_01_02:: ; heuristic: string; C0
Data_007_41A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kill A", $F1
    db $E8, "71Next B", $F0

String_07_01_03:: ; heuristic: string; C0
Data_007_41B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RESULTSDuoW", $A2, "LevelTurnsWin", $92, "RankOwnWDuoLOwnL", $F0

String_07_01_04:: ; heuristic: string; C0
Data_007_41DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GFDEBCAS", $F0

String_07_01_05:: ; heuristic: string; C0
Data_007_41E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GFEDCBAS", $F0

String_07_02_00:: ; heuristic: string; C0
Data_007_41F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Trade keys.", $F0

String_07_03_00:: ; heuristic: string; C0
Data_007_41FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FREE BATTLE", $F1
    db "ENIX RULES ", $F1
    db "LOCAL RULES", $F1
    db "EXIT       ", $F0

String_07_03_01:: ; heuristic: string; C0
Data_007_422D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ABEFILNORSTXYaceghiklmnrtuvxyKMDposb", $F0

String_07_03_02:: ; heuristic: string; C0
Data_007_4252:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Refused the VS", $F1
    db "battle.", $F0

String_07_03_03:: ; heuristic: string; C0
Data_007_4269:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The VS battle was", $F1
    db "refused.", $F0

String_07_03_04:: ; heuristic: string; C0
Data_007_4284:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choosing rules.", $F1
    db "Please wait.", $F0

String_07_03_05:: ; heuristic: string; C0
Data_007_42A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Receiving rules.", $F1
    db "Please wait.", $F0

String_07_03_06:: ; heuristic: string; C0
Data_007_42BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Confirming rules.", $F1
    db "Please wait.", $F0

String_07_04_00:: ; heuristic: string; C0
Data_007_42DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Play the boy's", $F1
    db "adventure?", $FF, $F0

String_07_04_01:: ; heuristic: string; C0
Data_007_42F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enter the boy's", $F1
    db "name.", $FA, $F7
    db $F0

String_07_04_02:: ; heuristic: string; C0
Data_007_430F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enter the girl's", $F1
    db "name.", $FA, $F7
    db $F0

String_07_05_00:: ; heuristic: string; C0
Data_007_4327:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not enough money.", $F1
    db "Please wait.", $F0

String_07_05_01:: ; heuristic: string; C0
Data_007_4346:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal doesn't", $F1
    db "have enough gold.", $FA, $F7
    db $F2, "Will you pay the", $F1
    db "1000G battle fee?", $FF, $F0

String_07_05_02:: ; heuristic: string; C0
Data_007_438E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You paid for both", $F1
    db "combatants.", $F0

String_07_05_03:: ; heuristic: string; C0
Data_007_43AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal paid your", $F1
    db "battle fee.", $F0

String_07_05_04:: ; heuristic: string; C0
Data_007_43CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Insufficient gold", $F1
    db "for Team Mode.", $F0

String_07_05_05:: ; heuristic: string; C0
Data_007_43EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused to pay", $F1
    db "the battle fee for", $FA, $F7
    db $F2, "your pal.", $F0

String_07_05_06:: ; heuristic: string; C0
Data_007_441E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "to pay the battle", $FA, $F7
    db $F2, "fee for you.", $F0

String_07_05_07:: ; heuristic: string; C0
Data_007_4450:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You paid the 1000G", $F1
    db "battle fee.", $FA, $F7
    db $F2, "You can now battle", $F1
    db "in Team Mode.", $F0

String_07_05_08:: ; heuristic: string; C0
Data_007_4492:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose a monster", $F1
    db "for the Team Mode.", $F0

String_07_05_09:: ; heuristic: string; C0
Data_007_44B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused the", $F1
    db "Team Mode.", $F0

String_07_05_0A:: ; heuristic: string; C0
Data_007_44D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "the Team Mode.", $F0

String_07_05_0B:: ; heuristic: string; C0
Data_007_44F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Send your monster", $F1
    db "into battle?", $F0

String_07_05_0C:: ; heuristic: string; C0
Data_007_4510:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

String_07_05_0D:: ; heuristic: string; C0
Data_007_451D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battle in Team", $F1
    db "Mode?", $F0

String_07_05_0E:: ; heuristic: string; C0
Data_007_4532:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The battle results", $F1
    db "will be recorded.", $FA, $F7
    db $F2, "Is that OK?", $FF, $F0

String_07_05_0F:: ; heuristic: string; C0
Data_007_4566:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "both have won.", $FA, $F7
    db $F0

String_07_05_10:: ; heuristic: string; C0
Data_007_4589:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "alone won.", $FA, $F7
    db $F0

String_07_05_11:: ; heuristic: string; C0
Data_007_45A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "both lost.", $E5, $42, $FA, $F7
    db $F0

String_07_05_12:: ; heuristic: string; C0
Data_007_45C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In Team Mode, you", $F1
    db "alone lost.", $FA, $F7
    db $F0

String_07_05_13:: ; heuristic: string; C0
Data_007_45E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " obtained an", $F1
    db "egg of ", $F9, "0.", $FA, $F7
    db $F0

String_07_05_14:: ; heuristic: string; C0
Data_007_4604:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0's ", $F9, "G", $F1
    db "rose by ", $F9, "W.", $FA, $F7
    db $F0

String_07_05_15:: ; heuristic: string; C0
Data_007_4619:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0's ", $F9, "G", $F1
    db "fell by ", $F9, "W.", $FA, $F7
    db $F0

String_07_05_16:: ; heuristic: string; C0
Data_007_462E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " received", $F1
    db $F9, "WG.", $F0

String_07_05_17:: ; heuristic: string; C0
Data_007_463E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no room", $F1
    db "for more monsters.", $FA, $F7
    db $F2, "Switch it with", $F1
    db "another monster?", $FF, $F0

String_07_05_18:: ; heuristic: string; C0
Data_007_4685:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "With no room for", $F1
    db "it , ", $F9, "0 was", $FA, $F7
    db $F2, "released in the", $F1
    db "wild.", $F0

String_07_05_19:: ; heuristic: string; C0
Data_007_46BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "For Team Mode,", $F1
    db "1000G is charged.", $FA, $F7
    db $F2, "Will you pay this", $F1
    db "fee?", $FF, $F0

String_07_05_1A:: ; heuristic: string; C0
Data_007_46F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saving", $A4, $F1
    db "Please wait.", $F0

String_07_06_00:: ; heuristic: string; C0
Data_007_470A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Team Mode battle", $F1
    db "No. 1!", $FA, $F7
    db $F0

String_07_06_01:: ; heuristic: string; C0
Data_007_4724:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Team Mode battle", $F1
    db "No. 2!", $FA, $F7
    db $F0

String_07_06_02:: ; heuristic: string; C0
Data_007_473E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Team Mode final", $F1
    db "battle!", $FA, $F7
    db $F0

String_07_06_03:: ; heuristic: string; C0
Data_007_4758:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The first monster", $F1
    db "is ", $F9, "0!", $FA, $F7
    db $F0

String_07_06_04:: ; heuristic: string; C0
Data_007_4773:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The second monster", $F1
    db "is ", $F9, "0!", $FA, $F7
    db $F0

String_07_06_05:: ; heuristic: string; C0
Data_007_478F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The third monster", $F1
    db "is ", $F9, "0!", $FA, $F7
    db $F0

String_07_06_06:: ; heuristic: string; C0
Data_007_47AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations", $F1
    db "for your victory!", $FA, $F7
    db $F2, "You", $42, "e cleared", $F1
    db "Round 1!", $FA, $F7
    db $F0

String_07_06_07:: ; heuristic: string; C0
Data_007_47E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations", $F1
    db "for your victory!", $FA, $F7
    db $F2, "There's just one", $F1
    db "round to go!", $FA, $F7
    db $F0

String_07_06_08:: ; heuristic: string; C0
Data_007_482A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations", $F1
    db "for your victory!", $FA, $F7
    db $F2, "You", $42, "e won the", $F1
    db "tournament!", $E5, "0", $E4, $7E, $FA, $F7
    db $F0

; start-up for wGameMode = 5; forcing this mode on the emulator shows: title screen; also sparkles and a victory screen when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode5_Init)
; reads: wModeState
; writes: wTextCursorLo, wTextCursorHi, wLinkReady
; points at: wMenuState, wTextWindowTileLo, wLinkScreenState
GameMode5_Init::
Func_007_486E:: ; address name
    xor a, a
    ld hl, wMenuState
    ld bc, $0008
    call FillBytes
    xor a, a
    ld hl, wTextWindowTileLo
    ld bc, $0012
    call FillBytes
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    xor a, a
    ld hl, wLinkScreenState
    ld bc, $0008
    call FillBytes
    call ClearSTATInterruptSources
    xor a, a
    ld [wLinkReady], a
    ld a, [wModeState]
    rst $00
    dw GameMode5_Init_LoadSGBObjectPalettesFromPointers
    dw GameMode5_Init_InitSoundHardware
    dw GameMode5_Init_SendSGBPaletteSetPacket
    dw GameMode5_Init_SendSGBPaletteSetPacket_Case03
    dw GameMode5_Init_SendSGBPaletteSetPacket_Case04
    dw GameMode5_Init_WriteSaveStepAndSaveRecordIndexEtc
    dw GameMode5_Init_SendSGBPaletteSetPacket_Case06
    dw GameMode5_Init_WriteSaveStepAndSaveRecordIndexEtc

; entry 0 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wIsCGB
; writes: rBGP, rOBP0, rOBP1, hWindowX, hWindowY, hScrollX, hScrollY, wFrameCounterLo, ...
; points at: wSGBPaletteSet, wDMGPaletteBGP, wBGPaletteBuffer
GameMode5_Init_LoadSGBObjectPalettesFromPointers::
Jump_007_48B2:: ; address name
    ld a, [wSGBActive]
    or a, a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall LoadSGBObjectPalettesFromPointers
    jr .skip

.check_is_cgb:
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    ld b, $40
    ld hl, wBGPaletteBuffer

.loop:
    ld a, $FF
    ld [hl+], a
    ld a, $7F
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0240
    xor a, a
    call FillBytes
    ld a, $00
    ldh [rVBK], a

.skip:
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    xor a, a
    ld hl, wDMGPaletteBGP
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, $C3
    ld hl, vBGMap0
    ld bc, $0800
    call FillBytes
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $00
    ldh [hScrollY], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wSTATSplitEnable], a
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkScreenStep], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ClearSGBPacketBuffer_CheckLinkMode

; entry 1 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, sSavedLinkByte94, wIsCGB, hTemp0, wLinkScreenState
; writes: rRAMG, rRAMB, wLinkByte94, wMenuSaveByte34, wBattleKindFlags, wStringCategory, wStringIndex, rVBK, ...
; points at: wWorkBuf, wLinkRole, wSGBPaletteSet, hPlayerSpriteVariant, wPlayerName, wStoryFlags, wKeyWorldSlot, sRecords
GameMode5_Init_InitSoundHardware::
Jump_007_4952:: ; address name
    call InitSoundHardware
    xor a, a
    ld hl, wWorkBuf
    ld bc, $0210
    call FillBytes
    xor a, a
    ld hl, wLinkRole
    ld bc, $0058
    call FillBytes
    ld a, [wSGBActive]
    or a, a
    jr z, .call_start_palette_fade
    ld a, $02
    call LoadSGBBorderForSetA
    call SpinDelay
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket

.call_start_palette_fade:
    ld a, $FC
    call StartPaletteFade
    ld hl, hPlayerSpriteVariant
    ld bc, $000E
    xor a, a
    call FillBytes
    ld hl, wPlayerName
    ld bc, $0291
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [sSavedLinkByte94]
    or a, a
    jr z, .set_link_byte94
    cp a, $01
    jr z, .set_link_byte94
    xor a, a

.set_link_byte94:
    ld [wLinkByte94], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ld hl, wStoryFlags
    ld bc, $006B
    xor a, a
    call FillBytes
    ld hl, wKeyWorldSlot
    ld bc, $00B5
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $006F
    xor a, a
    call FillBytes
    ld a, $02
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a, a
    call FillBytes
    xor a, a
    ld [rRAMG], a
    ld a, $04
    ld [wMenuSaveByte34], a
    ld a, $01
    ld [wBattleKindFlags], a
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    ld hl, vTiles2
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a ; 'CONTINUE NEW GAME BREEDING KEY TRADEVS'
    farcall ShowString_Bank07
    ld hl, vTiles2 + $700
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a ; 'DREAM EGG'
    farcall ShowString_Bank07
    ld a, [wIsCGB]
    or a, a
    jr z, .call_fill_screen_tile_buffer_with_d
    ld a, $01
    ldh [rVBK], a
    ld d, $00
    call FillScreenTileBufferWithD
    call DrawScreenBufferToBGMap0_Bank07
    xor a, a
    ldh [rVBK], a

.call_fill_screen_tile_buffer_with_d:
    ld d, $C3
    call FillScreenTileBufferWithD
    call DrawScreenBufferToBGMap0_Bank07
    farcall CheckSaveData
    ldh a, [hTemp0]
    ld [wLinkScreenState], a
    or a, a
    jr z, .call_queue_music
    ld hl, SaveCheckScreenRects
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, .call_queue_music
    ld a, $02
    jr .call_queue_music2

.call_queue_music:
    ld a, $09

.call_queue_music2:
    call QueueMusic
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $07
    ldh [hWindowX], a
    ld a, $00
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wSTATSplitEnable], a
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkMode], a
    xor a, a
    ld [wLinkScreenStep], a
    xor a, a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; fills the 20 x 18 visible part of wScreenTileBuffer (32-byte rows) with D (E-0124)
; 5 call sites from 4 routines (e.g. GameMode5_Init_InitSoundHardware, RunLinkSession4ScreenState_Case03_WriteSubMenuCursorAndLinkSendByteEtc, RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD, RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD)
; points at: wScreenTileBuffer
FillScreenTileBufferWithD::
Func_007_4AE4:: ; address name
    ld hl, wScreenTileBuffer
    ld bc, $1412
    ld a, d

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    ld b, $14
    dec c
    jr nz, .loop
    ret

; the same effect as CopyRecordRectToScreenBuffer with the copy loop's instructions in a different order: HL = header (word offset, width, rows) followed by tile bytes, copied into wScreenTileBuffer + offset with rows 32 bytes apart (E-0071)
; 19 call sites from 19 routines (e.g. GameMode5_Init_SendSGBPaletteSetPacket_Case04, GameMode5_Init_InitSoundHardware, GameMode5_Update_Case01_SerialSendByte_Case08, GameMode5_Update_Case01_ShowGameLinkCannotBe, ...)
; points at: wScreenTileBuffer
CopyRecordRectToScreenBuffer_Bank07::
Func_007_4AFE:: ; address name
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
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

; copies the 20 x 18 entries of wScreenTileBuffer to vBGMap0 (rows 32 apart) with CopyRect32StrideToVRAM_Bank07 (E-0073)
; 12 call sites from 10 routines (e.g. GameMode5_Init_SendSGBPaletteSetPacket_Case04, GameMode5_Init_InitSoundHardware, RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc, RunGameMode5Case01SubStates_SerialSendByte, ...)
; points at: wScreenTileBuffer
DrawScreenBufferToBGMap0_Bank07::
Func_007_4B1E:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

; the same instructions as CopyRect32StrideToVRAM_Bank16: B = width, C = rows, DE = source and HL = VRAM, both with rows 32 bytes apart; copies with WriteVRAMByteInc; B kept, C = 0 (E-0073)
; 10 call sites from 10 routines (e.g. GameMode5_Update_Case01_SerialSendByte_Case08, GameMode5_Update_Case01_ShowGameLinkCannotBe, GameMode5_Update_Case01_ShowGameLinkIsNot, RunGameMode5Case01SubStates_SerialSendByte_Case01, ...)
CopyRect32StrideToVRAM_Bank07::
Func_007_4B27:: ; address name
    push bc
    push de
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, CopyRect32StrideToVRAM_Bank07
    ret

; entry 2 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_SendSGBPaletteSetPacket::
Jump_007_4B45:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop2

.check_is_cgb:
    ld a, [wIsCGB]
    or a, a
    jr z, .loop2
    farcall LoadPalette0FromData4ACC

.loop2:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld a, [wMapType]
    bit 7, a
    jr z, .call_start_palette_fade
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.call_start_palette_fade:
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vBGMap0
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop3:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, .loop3
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wMenuState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wLinkScreenState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wSTATSplitEnable], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; entry 3 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_SendSGBPaletteSetPacket_Case03::
Jump_007_4C24:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop2

.check_is_cgb:
    ld a, [wIsCGB]
    or a, a
    jr z, .loop2
    farcall LoadPalette0FromData4ACC

.loop2:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld a, [wMapType]
    bit 7, a
    jr z, .call_start_palette_fade
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.call_start_palette_fade:
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vBGMap0
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop3:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, .loop3
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wMenuState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wLinkScreenState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wSTATSplitEnable], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; entry 4 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wWorkBuf, hWindowX, hWindowY, hScrollY, hScrollX, wFrameCounterLo, ...
; points at: wSGBPaletteSet, wScreenTileBuffer, wMenuState, wLinkScreenState
GameMode5_Init_SendSGBPaletteSetPacket_Case04::
Jump_007_4CFF:: ; address name
    call GameMode5_Init_Case04_ReadLinkSetupMode
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop

.check_is_cgb:
    ld a, [wIsCGB]
    or a, a
    jr z, .loop
    farcall LoadPalette0FromData4ACC

.loop:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop
    ld a, [wMapType]
    bit 7, a
    jr z, .call_start_palette_fade
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.call_start_palette_fade:
    ld a, $FC
    call StartPaletteFade
    ld b, $31
    ld de, Tiles1Plus240Gfx_31_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx_31_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    ld hl, vTiles2 + $400
    ld de, $0B04
    call FillTilesRequest
    ld hl, $0300
    call GameMode5_Init_Case04_ShowString_Bank07
    ld a, $00
    ld [wWorkBuf + $1], a
    farcall LoadAllFamilyIconTiles
    ld hl, vTiles2 + $B0
    ld de, $2501
    call FillTilesRequest
    ld hl, $0301
    call GameMode5_Init_Case04_ShowString_Bank07
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld hl, $5447
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld hl, wMenuState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wLinkScreenState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wSTATSplitEnable], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; only called from GameMode5_Init_Case04 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Init_SendSGBPaletteSetPacket_Case04)
; reads: wLinkSetupMode
; points at: wLinkRules, wLinkRulesCopy
GameMode5_Init_Case04_ReadLinkSetupMode::
Func_007_4DEC:: ; address name
    ld a, [wLinkSetupMode]
    cp a, $02
    jr z, .skip
    ld hl, $4E07
    jr .skip2

.skip:
    ld hl, wLinkRulesCopy

.skip2:
    ld de, wLinkRules
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret
    db $01, $00, $00, $63, $29, $01, $00, $00, $63, $80

; copies the 10 bytes at wD043 to wD04D (E-0122)
; 2 call sites from 2 routines (e.g. RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc, RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD)
; points at: wLinkRules, wLinkRulesCopy
CopyLinkRulesToLinkRulesCopy::
Func_007_4E11:: ; address name
    ld hl, wLinkRules
    ld de, wLinkRulesCopy
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; entry 5 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT, wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_WriteSaveStepAndSaveRecordIndexEtc::
Jump_007_4E20:: ; address name
    ld hl, vTiles0
    ld bc, $0C00
    xor a, a

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, .loop

; entry 6 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_SendSGBPaletteSetPacket_Case06::
Jump_007_4E37:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop2

.check_is_cgb:
    ld a, [wIsCGB]
    or a, a
    jr z, .loop2
    farcall LoadPalette0FromData4ACC

.loop2:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld a, [wMapType]
    bit 7, a
    jr z, .skip
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.skip:
    ld hl, vBGMap0
    ld bc, $1412

.loop3:
    ld a, $C3

.loop4:
    call WriteVRAMByteInc
    dec b
    jr nz, .loop4
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $14
    dec c
    jr nz, .loop3
    call GameMode5_Init_Case06_LoadSRAMRecordWord
    farcall FullyHealParty
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

.loop5:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, .loop5
    ld hl, wMenuState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wLinkScreenState
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $FF
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a, a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a, a
    ld [wSTATSplitEnable], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; only called from GameMode5_Init_Case06 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Init_SendSGBPaletteSetPacket_Case06)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
GameMode5_Init_Case06_LoadSRAMRecordWord::
Func_007_4F29:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

.loop:
    push hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ld a, [wPartyCount]
    cp a, $03
    ret z
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

; per-frame routine for wGameMode = 5
; 1 call site from 1 routine (e.g. RunGameModeUpdate_ToGameMode5_Update)
; reads: wModeState
GameMode5_Update::
Func_007_4F7B:: ; address name
    ld a, [wModeState]
    rst $00
    dw GameMode5_Update_LoadScreens
    dw GameMode5_Update_WaitFadeState
    dw GameMode5_Update_LinkExchangeJoypadPerFrame
    dw GameMode5_Update_LinkExchangeJoypadPerFrame_Case03
    dw GameMode5_Update_LinkExchangeJoypadPerFrame_Case04
    dw GameMode5_Update_ToGameMode5_Update_Case05_LinkExchangeJoypadPerFrame
    dw GameMode5_Update_ToGameMode5_Update_Case05_LinkExchangeJoypadPerFrame
    dw GameMode5_Update_ToGameMode5_Update_Case07_LinkExchangeJoypadPerFrame

; entry 5 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
GameMode5_Update_ToGameMode5_Update_Case05_LinkExchangeJoypadPerFrame::
Jump_007_4F8F:: ; address name
    farcall GameMode5_Update_Case05_LinkExchangeJoypadPerFrame
    ret

; entry 7 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
GameMode5_Update_ToGameMode5_Update_Case07_LinkExchangeJoypadPerFrame::
Jump_007_4F96:: ; address name
    farcall GameMode5_Update_Case07_LinkExchangeJoypadPerFrame
    ret

; blinks the cursor of the list entry [HL] every 8 frames; up/down moves it (wrapping over wC46F entries) with sound $69 (E-0127)
; 6 call sites from 6 routines (e.g. GameMode5_Update_Case01_SerialSendByte, RunLinkSession4ScreenState_WriteLinkScreenSubStateAndLinkScreenFlagEtc, RunGameMode5Case01SubStates_SerialSendByte_Case01, RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case17, ...)
; reads: wFrameCounterLo, wSubMenuCursor, wJoypadPressedRepeat
; writes: wFrameCounterLo
MoveVerticalCursorInListHL::
Func_007_4F9D:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, .check_sub_menu_cursor
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .call_write_bb_tile_at_word_table_entry_c
    call EraseCursorAtEntryHL_Bank07
    jr .check_sub_menu_cursor

.call_write_bb_tile_at_word_table_entry_c:
    call WriteBBTileAtWordTableEntryC_Bank07

.check_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    cp a, $01
    jr z, .return
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, .clear_frame_counter_lo
    ld a, [wSubMenuCursor]
    dec a
    ld [hl], a
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, .return
    ld a, [wSubMenuCursor]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, .clear_frame_counter_lo
    xor a, a
    ld [hl], a
    jr .clear_frame_counter_lo

.return:
    ret

.clear_frame_counter_lo:
    xor a, a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    ld a, $69
    call QueueSoundEffect
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; only called from routines of RunLinkSession4ScreenState (E-0098)
; 15 call sites from 15 routines (e.g. RunLinkSession4ScreenState_Case03_QueueSoundEffect_Case1E, RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case1B, RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case18, RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case15, ...)
; reads: wFrameCounterLo, wJoypadPressedRepeat, wSubMenuCursor2
; writes: wFrameCounterLo
RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07::
Func_007_4FF5:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, .check_joypad_pressed_repeat
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .call_write_bb_tile_at_word_table_entry_c
    call EraseCursorAtEntryHL_Bank07
    jr .check_joypad_pressed_repeat

.call_write_bb_tile_at_word_table_entry_c:
    call WriteBBTileAtWordTableEntryC_Bank07

.check_joypad_pressed_repeat:
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, .clear_frame_counter_lo
    ld a, [wSubMenuCursor2]
    dec a
    ld [hl], a
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, .return
    ld a, [wSubMenuCursor2]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, .clear_frame_counter_lo
    xor a, a
    ld [hl], a
    jr .clear_frame_counter_lo

.return:
    ret

.clear_frame_counter_lo:
    xor a, a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    ld a, $69
    call QueueSoundEffect
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; C = [HL]; writes the cursor tile $BB at the VRAM address in entry C of the word table at DE, waiting for VRAM access (E-0124)
; 6 call sites from 3 routines (e.g. MoveVerticalCursorInListHL, RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07, RunLinkSession4ScreenState_Case03_Case1A_EraseCursorAtEntryHL_Bank07)
; reads: rSTAT
WriteBBTileAtWordTableEntryC_Bank07::
Func_007_5046:: ; address name
    ld c, [hl]
    push hl
    ld a, c
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    deref_hl
    ld a, $BB
    push af

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    pop af
    ld [hl], a
    pop hl
    ret

; C = [HL], then falls into WriteC3TileAtWordTableEntryC_Bank07 (E-0126)
; 5 call sites from 5 routines (e.g. GameMode5_Update_Case01_SerialSendByte_Case08, MoveVerticalCursorInListHL, RunGameMode5Case01SubStates_SerialSendByte_Case01, RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07, ...)
; reads: rSTAT
EraseCursorAtEntryHL_Bank07::
Func_007_5066:: ; address name
    ld c, [hl]

; writes the blank tile $C3 at the VRAM address in entry C of the word table at DE, waiting for VRAM access (E-0124)
; 3 call sites from 3 routines (e.g. MoveVerticalCursorInListHL, RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07, RunLinkSession4ScreenState_Case03_Case1A_EraseCursorAtEntryHL_Bank07)
; reads: rSTAT
WriteC3TileAtWordTableEntryC_Bank07::
Func_007_5067:: ; address name
    push hl
    ld a, c
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    deref_hl
    ld a, $C3
    push af

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    pop af
    ld [hl], a
    pop hl
    ret

; E-0220 (C1: menu code in bank $07 passes $5086, $5096, $509E, $50AA ... $50FA to WriteBCTileAtWordTableEntry_Bank07, EraseCursorAtEntryHL_Bank07 and MoveVerticalCursorInListHL; each run indexed by a menu position; 60 words in all).
; record: 60 BG map addresses, used in runs of up to 8 by the menus of bank $07
CursorPositionWords_07_5086::
Data_007_5086:: ; address name
    dw vBGMap0 + $21, vBGMap0 + $61, vBGMap0 + $A1, vBGMap0 + $E1, vBGMap0 + $121, vBGMap0 + $161, vBGMap0 + $1A1, vBGMap0 + $1E1 ; entry 0
    dw vBGMap0 + $A3, vBGMap0 + $E3, vBGMap0 + $123, vBGMap0 + $163, vBGMap0 + $61, vBGMap0 + $C1, vBGMap0 + $101, vBGMap0 + $141
    dw vBGMap0 + $181, vBGMap0 + $1C1, vBGMap0 + $68, vBGMap0 + $6E, vBGMap0 + $CE, vBGMap0 + $D1, vBGMap0 + $10E, vBGMap0 + $111
    dw vBGMap0 + $14E, vBGMap0 + $151, vBGMap0 + $18E, vBGMap0 + $191, vBGMap0 + $1CE, vBGMap0 + $1D1, vBGMap0 + $81, vBGMap0 + $C1
    dw vBGMap0 + $101, vBGMap0 + $141, vBGMap0 + $181, vBGMap0 + $1C1, vBGMap0 + $201, vBGMap0 + $8C, vBGMap0 + $8E, vBGMap0 + $90
    dw vBGMap0 + $CC, vBGMap0 + $CE, vBGMap0 + $D0, vBGMap0 + $10C, vBGMap0 + $10E, vBGMap0 + $110, vBGMap0 + $14C, vBGMap0 + $14E
    dw vBGMap0 + $150, vBGMap0 + $18C, vBGMap0 + $18E, vBGMap0 + $190, vBGMap0 + $1CC, vBGMap0 + $1CE, vBGMap0 + $1D0, vBGMap0 + $20C
    dw vBGMap0 + $20E, vBGMap0 + $210, vBGMap0 + $101, vBGMap0 + $141

; HL = table of VRAM addresses, A = index: writes tile $BC at the address in entry A (WriteVRAMByte) (E-0067) (the same 15 bytes appear in 3 banks)
; 10 call sites from 10 routines (e.g. RunGameMode5Case01SubStates_SerialSendByte_Case01, RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case14, RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case13, RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case12, ...)
WriteBCTileAtWordTableEntry_Bank07::
Func_007_50FE:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ret

; writes blank tile $C3 to the 20 x 18 visible area of vBGMap0 (E-0124)
; no direct call (reached through a table, a jump or a vector)
ClearBGMap0Screen20x18:: ; heuristic: follows a terminator; C0
Func_007_510D:: ; address name
    ld hl, vBGMap0
    ld bc, $1412
    ld a, $C3

.loop:
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, $C3
    ld b, $14
    dec c
    jr nz, .loop
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank07 (E-0114)
; 4 call sites from 4 routines (e.g. RunLinkSession4ScreenState_Case02_ShowStringHL_Bank07, RunLinkSession4ScreenState_Case03_ToShowStringHL_Bank07AndStep, RunLinkSession4ScreenState_StartWithPresetRules_Case03, RunLinkSession4ScreenState_StartWithPresetRules_ShowStringHL_Bank07AndStep)
; writes: wStringCategory, wStringIndex
ShowStringHL_Bank07::
Func_007_512B:: ; address name
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ret

; only called from GameMode5_Init_Case04 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode5_Init_SendSGBPaletteSetPacket_Case04)
; writes: wStringCategory, wStringIndex
GameMode5_Init_Case04_ShowString_Bank07::
Func_007_513A:: ; address name
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ret

; E-0220 (C1: after CheckSaveData, GameMode5_Init_InitSoundHardware.call_fill_screen_tile_buffer_with_d reads the word at $5149 + 2 * hTemp0 (hTemp0 >= 1) and passes it to CopyRecordRectToScreenBuffer_Bank07; three words, so index 3 would read the offset word ($0000) of TileRect_07_514F, which follows; entry 0 is not read on that path).
; record: rectangle record for this CheckSaveData result ($0000 = none)
SaveCheckScreenRects::
Data_007_5149:: ; address name
    dw TileRect_07_514F ; id 0
    dw TileRect_07_52D7 ; id 1
    dw TileRect_07_52FF ; id 2

; E-0220 (C1: a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer format: offset, width, rows, tiles).
; record: offset $0000; 12 x 15 tiles
TileRect_07_514F::
Data_007_514F:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0C, $0F ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $00, $01, $02, $03, $04, $05, $06, $07, $08, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $C3, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $C3, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $B7 ; row 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $C3, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $B7 ; row 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 10
    db $B6, $C3, $70, $71, $72, $73, $74, $75, $76, $77, $78, $B7 ; row 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 12
    db $B6, $C3, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $B7 ; row 13
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 14

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 12 x 17 tiles
TileRect_07_5207::
Data_007_5207:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0C, $11 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $00, $01, $02, $03, $04, $05, $06, $07, $08, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $C3, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $C3, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $B7 ; row 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $C3, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $B7 ; row 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 10
    db $B6, $C3, $70, $71, $72, $73, $74, $75, $76, $77, $78, $B7 ; row 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 12
    db $B6, $C3, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $B7 ; row 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 14
    db $B6, $C3, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $B7 ; row 15
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 16

; E-0220 (C1: a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer format: offset, width, rows, tiles).
; record: offset $0000; 12 x 3 tiles
TileRect_07_52D7::
Data_007_52D7:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0C, $03 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $B7 ; row 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 2

; E-0220 (C1: a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer format: offset, width, rows, tiles).
; record: offset $01A0; 20 x 5 tiles
TileRect_07_52FF::
Data_007_52FF:: ; address name
    dw $01A0 ; entry 0: offset into wScreenTileBuffer
    db $14, $05 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7 ; row 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 4

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0060 (row 3, column 0); 20 x 11 tiles
TileRect_07_5367::
Data_007_5367:: ; address name
    dw $0060 ; entry 0: offset into wScreenTileBuffer
    db $14, $0B ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $68, $69, $6A, $6B, $6C, $6D, $ED, $40, $41, $42, $43, $44, $C3, $C3, $C3, $ED, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $45, $46, $47, $48, $49, $4A, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $57, $58, $C3, $C3, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $59, $5A, $C3, $C3, $B7 ; row 4
    db $B6, $4B, $4C, $4D, $4E, $4F, $50, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $51, $52, $53, $54, $55, $56, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $C3, $C3, $C3, $C3, $C3, $B7 ; row 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 10

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0082 (row 4, column 2); 16 x 9 tiles
TileRect_07_5447::
Data_007_5447:: ; address name
    dw $0082 ; entry 0: offset into wScreenTileBuffer
    db $10, $09 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $C3, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $C3, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $C3, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $C3, $C3, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $C3, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $C3, $C3, $61, $62, $63, $64, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 8

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0020 (row 1, column 0); 20 x 16 tiles
TileRect_07_54DB::
Data_007_54DB:: ; address name
    dw $0020 ; entry 0: offset into wScreenTileBuffer
    db $14, $10 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $0C, $0B, $15, $15, $10, $0D, $C3, $14, $15, $0B, $13, $15, $C3, $0D, $16, $0F, $15, $B7 ; row 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $C3, $14, $1E, $1D, $1F, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $17, $C3, $C3, $11, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $C3, $10, $1A, $25, $1A, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $17, $C3, $C3, $11, $B7 ; row 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $C3, $0E, $18, $20, $1D, $1F, $27, $10, $1D, $20, $1D, $23, $C3, $C3, $17, $C3, $C3, $11, $B7 ; row 9
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 10
    db $B6, $C3, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C3, $17, $C3, $C3, $11, $B7 ; row 11
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 12
    db $B6, $C3, $0D, $26, $19, $1C, $18, $21, $1B, $1A, $C3, $C3, $C3, $C3, $C3, $17, $C3, $C3, $11, $B7 ; row 13
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 14
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 15

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 20 x 18 tiles
TileRect_07_561F::
Data_007_561F:: ; address name
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $12 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $C3, $C3, $14, $28, $0F, $10, $10, $C3, $10, $0F, $29, $0F, $15, $C3, $C3, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $10, $0F, $29, $0F, $15, $C3, $B7 ; row 3
    db $B6, $C3, $0B, $23, $1E, $C3, $29, $18, $1B, $1D, $19, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B6, $C3, $14, $24, $2B, $2B, $2C, $22, $23, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 7
    db $B6, $C3, $13, $1A, $19, $2C, $25, $1A, $22, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 8
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 9
    db $B6, $C3, $0C, $22, $1A, $18, $23, $1C, $C3, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 10
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 11
    db $B6, $C3, $2A, $18, $21, $19, $1A, $C3, $C3, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 12
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 13
    db $B6, $C3, $0B, $23, $1E, $C3, $14, $1E, $1D, $1F, $1F, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 14
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 15
    db $B6, $C3, $29, $1A, $1B, $18, $20, $18, $1B, $1D, $19, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7 ; row 16
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 17

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $00E0 (row 7, column 0); 20 x 5 tiles
TileRect_07_578B::
Data_007_578B:: ; address name
    dw $00E0 ; entry 0: offset into wScreenTileBuffer
    db $14, $05 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $15, $2C, $23, $18, $1F, $C3, $10, $1A, $25, $1A, $1F, $2D, $C3, $C3, $C3, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $29, $18, $26, $C3, $10, $1A, $25, $1A, $1F, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 4

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0062 (row 3, column 2); 15 x 11 tiles
TileRect_07_57F3::
Data_007_57F3:: ; address name
    dw $0062 ; entry 0: offset into wScreenTileBuffer
    db $0F, $0B ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $C3, $0B, $25, $18, $1D, $1F, $1D, $2E, $1F, $1A, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $C3, $0E, $18, $20, $1D, $1F, $1D, $1A, $2D, $C3, $C3, $C3, $B7 ; row 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 6
    db $B6, $C3, $00, $C3, $01, $C3, $02, $C3, $03, $C3, $04, $C3, $05, $C3, $B7 ; row 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 8
    db $B6, $C3, $06, $C3, $07, $C3, $08, $C3, $09, $C3, $0A, $C3, $C3, $C3, $B7 ; row 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 10

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $00E1 (row 7, column 1); 18 x 5 tiles
TileRect_07_589C::
Data_007_589C:: ; address name
    dw $00E1 ; entry 0: offset into wScreenTileBuffer
    db $12, $05 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 1
    db $B6, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C5, $C3, $C3, $C6, $B7 ; row 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 4

; E-0264 (derived: Func_000_0952 copies these 8 bytes to wOBJPaletteBuffer + $20)
; record: 8 bytes copied to wOBJPaletteBuffer + $20
OBJPaletteBufferPlus20Init_07_58FA::
Data_007_58FA:: ; address name
    db $DE, $67, $1F, $33, $3C, $12, $00, $00 ; entry 0

; by wLinkScreenState: steps that decompress screen graphics (two DecompressToVRAM each), one with music, and RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenState
GameMode5_Update_LoadScreens::
Jump_007_5902:: ; address name
    ld a, [wLinkScreenState]
    rst $00
    dw GameMode5_Update_LoadScreens_Case00
    dw GameMode5_Update_LoadScreens_Case01
    dw GameMode5_Update_LoadScreens_Case02
    dw GameMode5_Update_LoadScreens_RunGameMode5Case00SubStates
    dw GameMode5_Update_LoadScreens_Case04

; entry 0 of the `rst $00` table in GameMode5_Update_LoadScreens
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_LoadScreens_Case00::
Jump_007_5910:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_LoadScreens_Case00_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case00_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case00_WriteWorkBufAndLinkScreenSubState

; entry 0 of the `rst $00` table in GameMode5_Update_LoadScreens_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wIsCGB
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
GameMode5_Update_LoadScreens_Case00_DecompressToVRAM::
Jump_007_591A:: ; address name
    ld a, [wLinkScreenSubState]
    or a, a
    jr z, .skip
    ld b, $E1
    ld de, Tiles2Gfx_E1_4001
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, ScreenTileBufferGfx_E1_40D6
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, ScreenAttrBufferGfx_E1_40FB
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, BGPaletteBufferData_E1_410E
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_LoadScreens_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wJoypadPressed
; writes: wWorkBuf, wLinkScreenSubState
; points at: wLinkScreenState
GameMode5_Update_LoadScreens_Case00_WriteWorkBufAndLinkScreenSubState::
Jump_007_5976:: ; address name
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp a, $3C
    jr c, .check_joypad_pressed
    xor a, a
    ld [wWorkBuf], a
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    cp a, $03
    jr nc, StartFadeToLinkScreenState1_Skip
    cp a, $02
    ret c

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $0B
    ret

; wD06B = 0, wD06A = 1 and starts palette fade 4; the following entry advances wD06A instead (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkScreenSubState, wLinkScreenState
StartFadeToLinkScreenState1:: ; heuristic: follows a terminator; C0
Func_007_5999:: ; address name
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenState], a
    ld a, $04
    call StartPaletteFade
    ret

StartFadeToLinkScreenState1_Skip::
Jump_007_59A8:: ; address name
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_LoadScreens
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_LoadScreens_Case01::
Jump_007_59B6:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_LoadScreens_Case01_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case01_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case01_WriteWorkBufAndLinkScreenSubState

; entry 0 of the `rst $00` table in GameMode5_Update_LoadScreens_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wIsCGB
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
GameMode5_Update_LoadScreens_Case01_DecompressToVRAM::
Jump_007_59C0:: ; address name
    ld a, [wLinkScreenSubState]
    or a, a
    jr z, .skip
    ld b, $E1
    ld de, Tiles2Gfx_E1_4116
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, ScreenTileBufferGfx_E1_45A7
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, ScreenAttrBufferGfx_E1_45FC
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, BGPaletteBufferData_E1_460F
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_LoadScreens_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wJoypadPressed
; writes: wWorkBuf, wLinkScreenSubState
; points at: wLinkScreenState
GameMode5_Update_LoadScreens_Case01_WriteWorkBufAndLinkScreenSubState::
Jump_007_5A1C:: ; address name
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp a, $3C
    jr c, .check_joypad_pressed
    xor a, a
    ld [wWorkBuf], a
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    cp a, $03
    jr nc, StartFadeToLinkScreenState2_Skip
    cp a, $02
    ret c

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $0B
    ret

; wD06B = 0, wD06A = 2 and starts palette fade 4; the following entry advances wD06A instead (E-0122)
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkScreenSubState, wLinkScreenState
StartFadeToLinkScreenState2:: ; heuristic: follows a terminator; C0
Func_007_5A3F:: ; address name
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $02
    ld [wLinkScreenState], a
    ld a, $04
    call StartPaletteFade
    ret

StartFadeToLinkScreenState2_Skip::
Jump_007_5A4E:: ; address name
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_LoadScreens
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_LoadScreens_Case02::
Jump_007_5A5C:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_LoadScreens_Case02_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case02_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case02_StartPaletteFade

; entry 0 of the `rst $00` table in GameMode5_Update_LoadScreens_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wIsCGB
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
GameMode5_Update_LoadScreens_Case02_DecompressToVRAM::
Jump_007_5A66:: ; address name
    ld a, [wLinkScreenSubState]
    or a, a
    jr z, .skip
    ld b, $E1
    ld de, Tiles2Gfx_E1_4617
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, ScreenTileBufferGfx_E1_4946
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, ScreenAttrBufferGfx_E1_49BE
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, BGPaletteBufferData_E1_49D2
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_LoadScreens_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wJoypadPressed
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenState
; points at: wLinkScreenState
GameMode5_Update_LoadScreens_Case02_StartPaletteFade::
Jump_007_5AC2:: ; address name
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp a, $5A
    jr nc, .clear_work_buf
    cp a, $3C
    ret c
    ld a, [wJoypadPressed]
    and a, $0B
    ret z
    xor a, a
    ld [wWorkBuf], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $03
    ld [wLinkScreenState], a
    ld a, $04
    call StartPaletteFade
    ret

.clear_work_buf:
    xor a, a
    ld [wWorkBuf], a
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 3 of the `rst $00` table in GameMode5_Update_LoadScreens
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wLinkScreenSubState
; writes: wLinkScreenState, wLinkScreenSubState
GameMode5_Update_LoadScreens_RunGameMode5Case00SubStates::
Jump_007_5AFB:: ; address name
    ld a, [wJoypadPressed]
    and a, $0B
    jr z, RunGameMode5Case00SubStates
    call RunGameMode5Case00SubStates
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; runs the routine for wD06B (jump table of nine sub-states) (E-0122)
; 1 call site from 1 routine (e.g. GameMode5_Update_LoadScreens_RunGameMode5Case00SubStates)
; reads: wLinkScreenSubState
RunGameMode5Case00SubStates::
Func_007_5B14:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunGameMode5Case00SubStates_DecompressToVRAM
    dw RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00
    dw RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E
    dw RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E_Case03
    dw RunGameMode5Case00SubStates_DecompressToVRAM_Case04
    dw RunGameMode5Case00SubStates_StartPaletteFade
    dw RunGameMode5Case00SubStates_DecompressToVRAM_Case06
    dw RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Case07
    dw RunGameMode5Case00SubStates_StartPaletteFade_Case08

; entry 0 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB
; writes: rVBK, wWorkBuf, wLinkMenuCounter
; points at: wBGPaletteBuffer, wOBJPaletteBuffer, wWorkBuf, wLinkScreenSubState
RunGameMode5Case00SubStates_DecompressToVRAM::
Jump_007_5B2A:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $7E
    ld de, Tiles0Gfx_7E_4CED
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7E
    ld de, Tiles0Plus100Gfx_7E_5706
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $10
    ld hl, vTiles2

.loop:
    di
    ld a, $FF
    call WriteVRAMByteInc
    ei
    dec b
    jr nz, .loop
    ld hl, vBGMap0
    ld bc, $0400

.loop2:
    di
    ld a, $00
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400

.loop3:
    di
    ld a, $FF
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, .loop3
    ld a, $00
    ldh [rVBK], a
    xor a, a
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    call FillBytes
    ld b, $7E
    ld de, OBJPaletteBufferData_7E_4BBD
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, OBJPaletteBufferPlus8Data_7E_4CAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM

.skip:
    xor a, a
    ld hl, wWorkBuf
    ld bc, $004C
    call FillBytes
    ld hl, $E000
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld a, $01
    ld [wLinkMenuCounter], a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_NextTableByte
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade
    ld a, $DD
    call QueueSoundEffect
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkMenuCounter, wLinkMenuEntry
; writes: wLinkMenuEntry, wLinkMenuCounter
; points at: wLinkScreenSubState
RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00::
Jump_007_5BDC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ld a, [wLinkMenuEntry]
    inc a
    ld [wLinkMenuEntry], a
    and a, $07
    ret nz
    ld a, [wLinkMenuCounter]
    ld hl, $5EE3
    call ReadWordTableEntry_Bank00
    call RunGameMode5Case00SubStates_NextTableByte
    ld a, [wLinkMenuCounter]
    inc a
    ld [wLinkMenuCounter], a
    cp a, $0A
    ret c
    xor a, a
    ld [wLinkMenuEntry], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wLinkMenuCounter
; writes: wWorkBuf
; points at: wLinkScreenSubState
RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E::
Jump_007_5C14:: ; address name
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld de, $0040
    add hl, de
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    call DrawMetaSprite0AtX50YWD09E
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ld a, [wWorkBuf + $1]
    cp a, $50
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMenuCounter, wLinkMenuEntry
; writes: wLinkMenuEntry
; points at: wLinkScreenSubState
RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E_Case03::
Jump_007_5C40:: ; address name
    call DrawMetaSprite0AtX50YWD09E
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ld a, [wLinkMenuEntry]
    dec a
    ld [wLinkMenuEntry], a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

; entry 4 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMenuCounter, wFadeState, wIsCGB, wWorkBuf, wLinkScreenSubState
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
RunGameMode5Case00SubStates_DecompressToVRAM_Case04::
Jump_007_5C5F:: ; address name
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    ld a, [wFadeState]
    or a, a
    jp nz, RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ld b, $E1
    ld de, Tiles2Gfx_E1_5405
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, ScreenTileBufferGfx_E1_590F
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, ScreenAttrBufferGfx_E1_5974
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, BGPaletteBufferData_E1_5A67
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $5A
    ld [wWorkBuf], a
    ret

; entry 5 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wWorkBuf
; writes: wWorkBuf
; points at: wLinkScreenSubState
RunGameMode5Case00SubStates_StartPaletteFade::
Jump_007_5CC1:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

; entry 6 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB
; writes: rVBK, wLinkMenuCounter, wWorkBuf, rSCY
; points at: wBGPaletteBuffer, wWorkBuf, wLinkScreenSubState
RunGameMode5Case00SubStates_DecompressToVRAM_Case06::
Jump_007_5CD8:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $E1
    ld de, Tiles1Gfx_E1_49DA
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $E1
    ld de, Tiles2Gfx_E1_4E67
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, BGMap0Gfx_E1_5987
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, .call_reset_link_screen_palettes
    ld a, $01
    ldh [rVBK], a
    ld b, $E1
    ld de, BGMap0Gfx_E1_59F7
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, $00
    ldh [rVBK], a
    ld b, $E1
    ld de, BGPaletteBufferData_E1_5A27
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM

.call_reset_link_screen_palettes:
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade
    xor a, a
    ld hl, wWorkBuf
    ld bc, $004C
    call FillBytes
    ld a, $01
    ld [wLinkMenuCounter], a
    ld hl, $6800
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_NextTableByte
    call SetScrollYFromWD09E
    ldh [rSCY], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkMenuCounter, wLinkMenuEntry, wWorkBuf
; writes: wLinkMenuEntry, wLinkMenuCounter, wWorkBuf
; points at: wLinkScreenSubState
RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Case07::
Jump_007_5D56:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ld a, [wLinkMenuCounter]
    cp a, $0A
    jr nc, .read_work_buf
    ld a, [wLinkMenuEntry]
    inc a
    ld [wLinkMenuEntry], a
    and a, $07
    jr nz, .read_work_buf
    ld a, [wLinkMenuCounter]
    ld hl, $5EE3
    call ReadWordTableEntry_Bank00
    call RunGameMode5Case00SubStates_NextTableByte
    ld a, [wLinkMenuCounter]
    inc a
    ld [wLinkMenuCounter], a
    ret

.read_work_buf:
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld de, $0080
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    call SetScrollYFromWD09E
    ld a, [wWorkBuf + $1]
    or a, a
    ret nz
    ld a, $3C
    ld [wWorkBuf], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunGameMode5Case00SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMenuCounter, wWorkBuf
; writes: wWorkBuf, wLinkScreenSubState
; points at: wLinkScreenState
RunGameMode5Case00SubStates_StartPaletteFade_Case08::
Jump_007_5DB6:: ; address name
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    ret nz
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; draws metasprite set 0, sub-index 0, at X = $50, Y = wD09E (E-0122)
; 2 call sites from 2 routines (e.g. RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E_Case03, RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E)
; reads: wWorkBuf
; writes: hSpriteOriginX, hSpriteOriginY, hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor
DrawMetaSprite0AtX50YWD09E::
Func_007_5DD6:: ; address name
    ld a, $50
    ldh [hSpriteOriginX], a
    ld a, [wWorkBuf + $1]
    ldh [hSpriteOriginY], a
    xor a, a
    ldh [hSpriteSetIndex], a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    farcall DrawMetaSprite
    ret

; hScrollY = wD09E (E-0114)
; 2 call sites from 2 routines (e.g. RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Case07, RunGameMode5Case00SubStates_DecompressToVRAM_Case06)
; reads: wWorkBuf
; writes: hScrollY
SetScrollYFromWD09E::
Func_007_5DEF:: ; address name
    ld a, [wWorkBuf + $1]
    ldh [hScrollY], a
    ret

; only called from routines of RunGameMode5Case00SubStates (E-0098)
; 5 call sites from 5 routines (e.g. RunGameMode5Case00SubStates_StartPaletteFade_Case08, RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Case07, RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E_Case03, RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWD09E, ...)
; reads: wWorkBuf, wLinkScreenSubState
RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState::
Func_007_5DF5:: ; address name
    push bc
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    pop hl
    or a, a
    jr nz, .skip
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $1]
    add a, $50
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, c
    pop hl
    jr .skip4

.skip:
    dec a
    jr nz, .skip2
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $30
    pop hl
    jr .skip4

.skip2:
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    add a, $40
    ld [hl], a
    pop hl
    jr nz, .skip4
    ld a, [wLinkScreenSubState]
    cp a, $08
    jr nc, .skip3
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $1]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub a, $28
    cp a, c
    pop hl
    jr .skip4

.skip3:
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $1]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub a, $18
    cp a, c
    pop hl

.skip4:
    push hl
    call z, RunGameMode5Case00SubStates_NextTableByte
    pop hl
    ld a, [hl]
    inc a
    ld [hl+], a
    ld c, a
    ld a, [hl]
    and a, $03
    push de
    ld de, $5EFB
    add a, e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    pop de
    ld b, a
    ld a, c
    cp a, b
    jr c, .call_run_game_mode5_case00_sub_states
    ld a, [hl]
    inc a
    ld [hl-], a
    xor a, a
    ld [hl+], a

.call_run_game_mode5_case00_sub_states:
    call RunGameMode5Case00SubStates_Shared01_DrawMetaSprite
    pop bc
    dec b
    jp nz, RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState
    ret

; only called from RunGameMode5Case00SubStates_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState)
; writes: hSpriteSubIndex, hSpriteOriginX, hSpriteOriginY, hSpriteSetIndex, hSpriteTileOffset, hSpriteAttrXor
RunGameMode5Case00SubStates_Shared01_DrawMetaSprite::
Func_007_5E80:: ; address name
    ld a, [hl+]
    and a, $03
    ldh [hSpriteSubIndex], a
    ld a, [hl+]
    ldh [hSpriteOriginX], a
    ld a, [hl+]
    ldh [hSpriteOriginY], a
    ld a, $1E
    ldh [hSpriteSetIndex], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    inc hl
    inc hl
    push hl
    farcall DrawMetaSprite
    pop hl
    ret

; only called from routines of RunGameMode5Case00SubStates (E-0098)
; 5 call sites from 5 routines (e.g. RunGameMode5Case00SubStates_ReadWorkBufAndLinkScreenSubState, RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Case07, RunGameMode5Case00SubStates_DecompressToVRAM_Case06, RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00, ...)
; reads: wLinkScreenSubState, wWorkBuf
RunGameMode5Case00SubStates_NextTableByte::
Func_007_5EA2:: ; address name
    xor a, a
    ld [hl+], a
    ld [hl+], a
    push hl
    call NextTableByte
    pop hl
    and a, $3F
    add a, $30
    ld [hl+], a
    ld a, [wLinkScreenSubState]
    cp a, $03
    jr nc, .cp_05
    ld a, [wWorkBuf + $1]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ret

.cp_05:
    cp a, $05
    jr nc, .read_work_buf
    push hl
    call NextTableByte
    pop hl
    and a, $3F
    ld e, a
    ld a, [wWorkBuf + $1]
    sub a, $20
    add a, e
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

.read_work_buf:
    ld a, [wWorkBuf + $1]
    sub a, $20
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret
    db $9F, $D0, $A5, $D0, $AB, $D0, $B1, $D0, $B7, $D0, $BD, $D0, $C3, $D0, $C9, $D0
    db $CF, $D0, $D5, $D0, $DB, $D0, $E1, $D0, $04, $07, $07, $04

; entry 4 of the `rst $00` table in GameMode5_Update_LoadScreens
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_LoadScreens_Case04::
Jump_007_5EFF:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_LoadScreens_Case04_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Case04_QueueMusic
    dw GameMode5_Update_LoadScreens_Case04_WriteWorkBufAndLinkScreenSubStateEtc

; entry 0 of the `rst $00` table in GameMode5_Update_LoadScreens_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB
; writes: rSVBK, wWorkBuf, hScrollY
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wLinkScreenSubState
GameMode5_Update_LoadScreens_Case04_DecompressToVRAM::
Jump_007_5F09:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $E1
    ld de, Tiles0Gfx_E1_577C
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $E1
    ld de, Tiles1Gfx_E1_49DA
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $E1
    ld de, Tiles2Gfx_E1_4E67
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, ScreenTileBufferGfx_E1_582B
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, ScreenAttrBufferGfx_E1_58C3
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, BGPaletteBufferData_E1_5A27
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $E1
    ld de, OBJPaletteBufferData_E1_5AA7
    ld hl, wOBJPaletteBuffer
    ld c, $10
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ldh [hScrollY], a
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_LoadScreens_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wWorkBuf
; points at: wLinkScreenSubState
GameMode5_Update_LoadScreens_Case04_QueueMusic::
Jump_007_5F89:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $B4
    ld [wWorkBuf], a
    ld a, $06
    call QueueMusic
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_LoadScreens_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSoundChannel2, wWorkBuf
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenState, wModeState, wGameMode2State, wGameMode2Arg
; points at: wSoundChannel3, wSoundChannel4, wSoundChannel5, wModeChangeRequest
GameMode5_Update_LoadScreens_Case04_WriteWorkBufAndLinkScreenSubStateEtc::
Jump_007_5F9D:: ; address name
    ld a, [wJoypadPressed]
    and a, $0B
    jr nz, .call_start_palette_fade2
    ld a, [wSoundChannel2]
    ld hl, wSoundChannel3
    and a, [hl]
    ld hl, wSoundChannel4
    and a, [hl]
    ld hl, wSoundChannel5
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    jr z, .call_start_palette_fade
    ret

.call_start_palette_fade:
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $02
    ld [wLinkScreenState], a
    ret

.call_start_palette_fade2:
    ld a, $04
    call StartPaletteFade
    ld a, $01
    ld [wModeState], a
    ld a, $00
    ld [wGameMode2State], a
    ld a, $00
    ld [wGameMode2Arg], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; on CGB only: draws sprite set 0, sub-index 1, at ($38, $30) through RunE15AC0For5ABE (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginXHi, hSpriteOriginYHi, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginY
DrawCGBMetaSpriteAt38_30:: ; heuristic: follows a terminator; C0
Func_007_5FE8:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    xor a, a
    ldh [hSpriteSetIndex], a
    ld a, $01
    xor a, $01
    ldh [hSpriteSubIndex], a
    xor a, a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    ldh [hSpriteAttrXor], a
    ld a, $38
    ldh [hSpriteOriginX], a
    ld a, $30
    ldh [hSpriteOriginY], a
    farcall RunE15AC0For5ABE
    ret

; sets the DMG palettes $D2/$D2/$E2 (also in wD040) and resets the fade; on the Super Game Boy blanks rBGP/rOBP, sends PAL_SET for wC51F and copies 8 bytes from $58FA to wC4FF (E-0128)
; 7 call sites from 7 routines (e.g. GameMode5_Update_LoadScreens_Case00_DecompressToVRAM, GameMode5_Update_LoadScreens_Case01_DecompressToVRAM, GameMode5_Update_LoadScreens_Case02_DecompressToVRAM, RunGameMode5Case00SubStates_DecompressToVRAM_Case06, ...)
; reads: wDMGPaletteBGP, wDMGPaletteOBP0, wDMGPaletteOBP1, wSGBActive, wSGBPaletteSet, wSGBAttrFile
; writes: rBGP, rOBP0, rOBP1, wSGBPaletteNum0Lo, wSGBPaletteNum0Hi, wSGBPaletteNum1Lo, wSGBPaletteNum1Hi, wSGBPaletteNum2Lo, ...
; points at: wDMGPaletteBGP, wDMGPaletteBytes
ResetLinkScreenPalettes::
Func_007_600E:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hl+], a
    ld a, [wDMGPaletteOBP0]
    ld [hl+], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    call ResetFadeFromDMGPaletteBGP
    ld a, [wSGBActive]
    or a, a
    jr z, .return
    xor a, a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ld hl, $58FA
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

.return:
    ret

; entry 1 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkScreenState
; writes: wScreenStep
GameMode5_Update_WaitFadeState::
Jump_007_6090:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, $02
    ld [wScreenStep], a
    ld a, [wLinkScreenState]
    rst $00
    dw GameMode5_Update_Case01_RunGameMode5Case01SubStates
    dw GameMode5_Update_Case01_SerialSendByte
    dw GameMode5_Update_SaveDataLost
    dw GameMode5_Update_Case01_SerialSendByte_Case03
    dw GameMode5_Update_Case01_ShowGameLinkIsNot
    dw GameMode5_Update_Case01_SerialSendByte_Case05
    dw GameMode5_Update_NewPlayerSetup
    dw GameMode5_Update_Case01_ShowGameLinkCannotBe
    dw GameMode5_Update_Case01_SerialSendByte_Case08

; entry 0 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenStep, wModeChangeRequest, wLinkStatus
; writes: wLinkScreenStep, wGridCursorX, wLinkTimerLo
GameMode5_Update_Case01_RunGameMode5Case01SubStates::
Jump_007_60B0:: ; address name
    call RunGameMode5Case01SubStates
    ld a, [wLinkScreenStep]
    or a, a
    jr z, .return2
    ld a, [wLinkScreenStep]
    ld b, a
    xor a, a
    ld [wLinkScreenStep], a
    ld a, [wModeChangeRequest]
    or a, a
    jr nz, .return2
    ld a, $0F
    ld [wGridCursorX], a
    ld a, b
    ld [wLinkTimerLo], a
    call StartSerialTransferInternalClock
    ld a, $01
    ld [wGridCursorX], a

.loop:
    ld a, [wLinkStatus]
    and a, $03
    cp a, $03
    jr nz, .loop
    ld a, [wModeChangeRequest]
    and a, a
    jr nz, .return

.return:
    ret

.return2:
    ret

; runs the routine for wD06B (jump table of three sub-states) (E-0122)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case01_RunGameMode5Case01SubStates)
; reads: wLinkScreenSubState
RunGameMode5Case01SubStates::
Func_007_60E9:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunGameMode5Case01SubStates_SerialSendByte
    dw RunGameMode5Case01SubStates_SerialSendByte_Case01
    dw RunGameMode5Case01SubStates_ReadMenuState

; entry 0 of the `rst $00` table in RunGameMode5Case01SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkByte94, wMenuState
; writes: wScreenStep, wScreenSubStep, wSubMenuCursor, wSubMenuCursor2, wMenuOption, wLinkScreenStep, wLinkTimerLo
; points at: wScreenTileBuffer, wLinkScreenSubState
RunGameMode5Case01SubStates_SerialSendByte::
Jump_007_60F3:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld hl, TileRect_07_514F
    ld a, [wLinkByte94]
    or a, a
    jr z, .call_copy_record_rect_to_screen_buffer_bank07
    ld hl, $5207

.call_copy_record_rect_to_screen_buffer_bank07:
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld a, [wLinkByte94]
    and a, $01
    ld a, $07
    jr z, .set_sub_menu_cursor
    ld a, $08

.set_sub_menu_cursor:
    ld [wSubMenuCursor], a
    xor a, a
    ld [wSubMenuCursor2], a
    ld a, [wMenuState]
    ld [wMenuOption], a
    xor a, a
    ld [wLinkScreenStep], a
    ld [wLinkTimerLo], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunGameMode5Case01SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wTextFlags, wJoypadPressed, wSGBActive, wMenuState, wMenuOption
; writes: wScreenStep, wScreenSubStep, wStringCategory, wStringIndex, wLinkScreenState, wLinkScreenFlag, wMenuOption
; points at: wLinkScreenSubState, wMenuState
RunGameMode5Case01SubStates_SerialSendByte_Case01::
Jump_007_6145:: ; address name
    ld a, [wFadeState]
    and a, a
    jr z, .check_text_flags
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    bit 0, a
    jr z, .check_joypad_pressed
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_serial_send_byte
    call SendLinkByteForMenuOption
    jr .check_joypad_pressed2

.call_serial_send_byte:
    ld a, $C0
    call SerialSendByte

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_menu_option
    ld a, [wSGBActive]
    or a, a
    jr z, .check_menu_state
    ld a, [wMenuState]
    and a, $0F
    cp a, $02
    jr c, .check_menu_state
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a ; 'Game Link cannot be used with'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld a, $05
    ld [wLinkScreenState], a
    ret

.check_menu_state:
    ld a, [wMenuState]
    and a, $0F
    ld b, $02
    ld c, $08
    cp a, c
    jr nc, .skip
    cp a, b
    ccf

.skip:
    jr c, .skip2
    ld a, [wMenuState]
    ld hl, CursorPositionWords_07_5086
    and a, $07
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $69
    call QueueSoundEffect

.skip2:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    jr .return

.check_menu_option:
    ld de, CursorPositionWords_07_5086
    ld hl, wMenuState
    ld a, [wMenuOption]
    cp a, [hl]
    call nz, EraseCursorAtEntryHL_Bank07
    ld a, [wMenuOption]
    ld [hl], a
    call MoveVerticalCursorInListHL
    ld a, [wMenuState]
    ld [wMenuOption], a

.return:
    ret

; wD781 = 0, sends the byte at $65BD + (wC471 & $0F) through SerialSendByte (stored in wD782), then wD781 = 1 (E-0122)
; 1 call site from 1 routine (e.g. RunGameMode5Case01SubStates_SerialSendByte_Case01)
; reads: wMenuOption
; writes: wScreenStep, wScreenSubStep
SendLinkByteForMenuOption::
Func_007_6213:: ; address name
    ld a, [wMenuOption]
    ld de, $65BD
    and a, $0F
    add a, e
    ld e, a
    jr nc, .clear_screen_step
    inc d

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, [de]
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunGameMode5Case01SubStates
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
RunGameMode5Case01SubStates_ReadMenuState::
Jump_007_6231:: ; address name
    ld a, [wMenuState]
    and a, $0F
    rst $00
    dw RunGameMode5Case01SubStates_Case02_SerialSendByte
    dw RunGameMode5Case01SubStates_Case02_ClearScreenStateBlock
    dw RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc
    dw RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case03
    dw RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case04
    dw RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case05
    dw RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case06
    dw RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case07

; entry 0 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenFlag
; writes: wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_SerialSendByte::
Jump_007_6247:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, [wLinkScreenFlag]
    rst $00
    dw RunGameMode5Case01SubStates_Case02_Case00_ShowMaster
    dw RunGameMode5Case01SubStates_Case02_Case00_FillBytes
    dw RunGameMode5Case01SubStates_Case02_Case00_RunSaveSteps

; entry 0 of the `rst $00` table in RunGameMode5Case01SubStates_Case02_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenTileBuffer
; points at: wLinkScreenFlag
RunGameMode5Case01SubStates_Case02_Case00_ShowMaster::
Jump_007_6262:: ; address name
    ld hl, vTiles2 + $680
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
    ld hl, $5367
    call CopyRecordRectToScreenBuffer_Bank07
    farcall DecompressA4GraphicsAndContinue
    ld a, $BC
    ld [wScreenTileBuffer + $21], a
    call DrawScreenBufferToBGMap0_Bank07
    call RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunGameMode5Case01SubStates_Case02_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wSaveStep, wSaveRecordIndex, wLinkScreenFlag, wLinkScreenSubState
; points at: wLinkScreenFlag, wScreenTileBuffer
RunGameMode5Case01SubStates_Case02_Case00_FillBytes::
Jump_007_62BA:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld hl, wLinkScreenFlag
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    jr .call_run_game_mode5_case01_sub_states_write

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .call_run_game_mode5_case01_sub_states_write
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    xor a, a
    ld [wLinkScreenFlag], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.call_run_game_mode5_case01_sub_states_write:
    call RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc
    ret

; entry 2 of the `rst $00` table in RunGameMode5Case01SubStates_Case02_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep, wMapType, wKeyWorldWidth, wKeyWorldHeight, hPlayerFacing, hPlayerX, hPlayerY
; writes: wMapWidthScreens, wMapHeightScreens, wFieldReturnPhase, wTalkCountdown, wEncounterDelay, wFollowerRecords, wLinkScreenState
RunGameMode5Case01SubStates_Case02_Case00_RunSaveSteps::
Jump_007_62ED:: ; address name
    call RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot
    ld a, [wMapType]
    bit 7, a
    jr z, .clear_field_return_phase
    cp a, $80
    jr nz, .clear_field_return_phase
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a

.clear_field_return_phase:
    xor a, a
    ld [wFieldReturnPhase], a
    xor a, a
    ld [wTalkCountdown], a
    ld [wEncounterDelay], a
    farcall ClearBit1OfPlayerAndObjectFlags
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    call ClearScreenStateBlock
    farcall PickRandomEncounterCountdownFromTable478F
    ld a, $03
    ld [wLinkScreenState], a
    ret

; only called from routines of RunGameMode5Case01SubStates (E-0098)
; 3 call sites from 3 routines (e.g. RunGameMode5Case01SubStates_Case02_Case00_RunSaveSteps, RunGameMode5Case01SubStates_Case02_Case00_FillBytes, RunGameMode5Case01SubStates_Case02_Case00_ShowMaster)
; reads: wBattlerRecords, wTitleByte0A
; writes: rRAMG, rRAMB, hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, ...
RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc::
Func_007_635A:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wBattlerRecords]
    or a, a
    jr z, .skip
    ld a, [wTitleByte0A]
    or a, a
    jr z, .skip
    ld a, $29
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    ld hl, $0080
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ld hl, $0040
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    farcall DrawMetaSprite
    ret

.skip:
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ret

; entry 1 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
RunGameMode5Case01SubStates_Case02_ClearScreenStateBlock::
Jump_007_63A5:: ; address name
    call ClearScreenStateBlock
    call InitLinkScreenStateBlock
    ret

; clears the $80 bytes from wD780 (E-0122)
; 3 call sites from 3 routines (e.g. GameMode5_Update_Case01_SerialSendByte_Case03, RunGameMode5Case01SubStates_Case02_ClearScreenStateBlock, RunGameMode5Case01SubStates_Case02_Case00_RunSaveSteps)
; points at: wScreenState
ClearScreenStateBlock::
Func_007_63AC:: ; address name
    ld hl, wScreenState
    ld b, $80

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; entry 2 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc::
Jump_007_63B7:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, .clear_screen_step
    cp a, $FE
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $F5
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $A1
    ld a, $BC
    call WriteTileSound69ThenWD06A4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $A1
    ld a, $BC
    call WriteTileSound69ThenWD06A7
    ret

; writes A to VRAM at HL, plays sound $69, clears wC58B and wC470 and sets wD06A = 7 (E-0122)
; 6 call sites from 6 routines (e.g. RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case07, RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case06, RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case05, RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case04, ...)
; writes: wLinkScreenStep, wLinkScreenState, wSubMenuCursor2
WriteTileSound69ThenWD06A7::
Func_007_6406:: ; address name
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wLinkScreenStep], a
    ld a, $07
    ld [wLinkScreenState], a
    xor a, a
    ld [wSubMenuCursor2], a
    ret

; entry 3 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case03::
Jump_007_641C:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, .clear_screen_step
    cp a, $FE
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $F6
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $E1
    ld a, $BC
    call WriteTileSound69ThenWD06A4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $E1
    ld a, $BC
    call WriteTileSound69ThenWD06A7
    ret

; entry 4 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case04::
Jump_007_646B:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, .clear_screen_step
    cp a, $FE
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $B7
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $121
    ld a, $BC
    call WriteTileSound69ThenWD06A4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $121
    ld a, $BC
    call WriteTileSound69ThenWD06A7
    ret

; entry 6 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case06::
Jump_007_64BA:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, .clear_screen_step
    cp a, $FE
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $E0
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1A1
    ld a, $BC
    call WriteTileSound69ThenWD06A4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1A1
    ld a, $BC
    call WriteTileSound69ThenWD06A7
    ret

; entry 7 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case07::
Jump_007_6509:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, .clear_screen_step
    cp a, $FE
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $F1
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1E1
    ld a, $BC
    call WriteTileSound69ThenWD06A4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1E1
    ld a, $BC
    call WriteTileSound69ThenWD06A7
    ret

; entry 5 of the `rst $00` table in RunGameMode5Case01SubStates_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case05::
Jump_007_6558:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, .clear_screen_step
    cp a, $FE
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $DC
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $161
    ld a, $BC
    call WriteTileSound69ThenWD06A4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $161
    ld a, $BC
    call WriteTileSound69ThenWD06A7
    ret

; writes A to VRAM at HL, plays sound $69, clears wC58B and wC470 and sets wD06A = 4 (E-0122)
; 6 call sites from 6 routines (e.g. RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case07, RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case06, RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case05, RunGameMode5Case01SubStates_Case02_WriteJoypadReadFlagAndLinkScreenStepEtc_Case04, ...)
; writes: wLinkScreenStep, wLinkScreenState, wSubMenuCursor2
WriteTileSound69ThenWD06A4::
Func_007_65A7:: ; address name
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wLinkScreenStep], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wSubMenuCursor2], a
    ret
    db $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3

; entry 1 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wScreenStep, wScreenSubStep, wMenuState, wSubMenuCursor
; points at: wWorkBuf, wLinkScreenState
GameMode5_Update_Case01_SerialSendByte::
Jump_007_65C5:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, $01
    ld [wMenuState], a
    ld a, $01
    ld [wSubMenuCursor], a
    ld hl, wWorkBuf
    ld [hl], $00
    ld de, CursorPositionWords_07_5086
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $01
    ret z

; wD06A = 6 and the three bytes after it = 0 (E-0114)
; 1 call site from 1 routine (e.g. RunGameMode5Case01SubStates_Case02_ClearScreenStateBlock)
; points at: wLinkScreenState
InitLinkScreenStateBlock::
Func_007_65F1:: ; address name
    ld hl, wLinkScreenState
    ld a, $06
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

; by wLinkScreenSubState: 'Saved data has been lost.', then clears memory
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_SaveDataLost::
Jump_007_65FC:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_SaveDataLost_ShowSavedDataHasBeen
    dw GameMode5_Update_SaveDataLost_ReadSoundChannelSlots
    dw GameMode5_Update_SaveDataLost_FillBytes

; entry 0 of the `rst $00` table in GameMode5_Update_SaveDataLost
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wStringCategory, wStringIndex
; points at: wLinkScreenSubState
GameMode5_Update_SaveDataLost_ShowSavedDataHasBeen::
Jump_007_6606:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a ; 'Saved data has been lost.'
    farcall BeginStringDisplay_Bank07
    ld a, $52
    call QueueMusic
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_SaveDataLost
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; points at: wSoundChannel1, wLinkScreenSubState
GameMode5_Update_SaveDataLost_ReadSoundChannelSlots::
Jump_007_6624:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_SaveDataLost
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: rRAMG, rRAMB, wLinkScreenSubState
; points at: sRecords, wScreenTileBuffer, wLinkScreenState
GameMode5_Update_SaveDataLost_FillBytes::
Jump_007_6633:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $02
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a, a
    call FillBytes
    ld a, $03
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a, a
    call FillBytes
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ld hl, TileRect_07_52D7
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    xor a, a
    ld [wLinkScreenSubState], a
    ld hl, wLinkScreenState
    dec [hl]
    ld a, $09
    call QueueMusic
    ret

; entry 3 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptRunning, wMapType
; writes: wScreenStep, wScreenSubStep
; points at: wGameMode, wModeChangeRequest
GameMode5_Update_Case01_SerialSendByte_Case03::
Jump_007_66A2:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, $04
    call StartPaletteFade
    ld hl, wGameMode
    ld a, $01
    ld [hl+], a
    ld a, [wScriptRunning]
    bit 0, a
    ld a, $01
    jr nz, .skip
    ld a, [wMapType]
    bit 7, a
    ld a, $05
    jr nz, .skip
    ld a, $00

.skip:
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl], $00
    call ClearScreenStateBlock
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; entry 7 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkTimerLo, wGridCursorY, wScreenState
; writes: wScreenStep, wScreenSubStep, wTextBuf0, wStringCategory, wStringIndex, wLinkScreenState
GameMode5_Update_Case01_ShowGameLinkCannotBe::
Jump_007_66E0:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wLinkTimerLo]
    ld b, a
    and a, $F0
    swap a
    ld [wTextBuf0], a
    ld a, b
    and a, $0F
    ld [wTextBuf0 + $1], a
    ld a, $F0
    ld [wTextBuf0 + $2], a
    ld a, [wGridCursorY]
    ld [wTextBuf0 + $4], a
    ld a, $F0
    ld [wTextBuf0 + $5], a
    ld a, [wScreenState]
    ld b, a
    and a, $F0
    swap a
    ld [wTextBuf0 + $8], a
    ld a, b
    and a, $0F
    ld [wTextBuf0 + $9], a
    ld a, $F0
    ld [wTextBuf0 + $A], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a ; 'Game Link cannot be used with'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld a, $05
    ld [wLinkScreenState], a
    ret

; entry 8 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuOption, wScreenCounter, wGlyphListPos, wGlyphListStart
; writes: wScreenStep, wScreenSubStep, wMenuState, wTextBuf0, wStringCategory, wStringIndex, wLinkScreenState
GameMode5_Update_Case01_SerialSendByte_Case08::
Jump_007_6759:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    call EraseCursorAtEntryHL_Bank07
    ld a, [wMenuOption]
    ld [wMenuState], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wScreenCounter]
    ld b, a
    and a, $F0
    swap a
    ld [wTextBuf0], a
    ld a, b
    and a, $0F
    ld [wTextBuf0 + $1], a
    ld a, $F0
    ld [wTextBuf0 + $2], a
    ld a, [wGlyphListPos]
    ld [wTextBuf0 + $4], a
    ld a, $F0
    ld [wTextBuf0 + $5], a
    ld a, [wGlyphListStart]
    ld b, a
    and a, $F0
    swap a
    ld [wTextBuf0 + $8], a
    ld a, b
    and a, $0F
    ld [wTextBuf0 + $9], a
    ld a, $F0
    ld [wTextBuf0 + $A], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a ; 'DuoOwnWL'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld a, $05
    ld [wLinkScreenState], a
    ret

; entry 4 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep, wStringCategory, wStringIndex
; points at: wLinkScreenState
GameMode5_Update_Case01_ShowGameLinkIsNot::
Jump_007_67DB:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a ; 'Game Link is not ready. Please'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wLinkScreenState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wScreenStep, wScreenSubStep, wLinkScreenState, wLinkScreenSubState
GameMode5_Update_Case01_SerialSendByte_Case05::
Jump_007_681C:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wLinkScreenState], a
    ld [wLinkScreenSubState], a
    ret

; by wLinkScreenSubState: fades, sets a flag, runs name entry, then InitGoldAndClearInventory
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_NewPlayerSetup::
Jump_007_683A:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_NewPlayerSetup_ToStartPaletteFadeAndStep
    dw GameMode5_Update_NewPlayerSetup_DrawFullScreenBufferToBGMap
    dw GameMode5_Update_NewPlayerSetup_WaitFadeState
    dw GameMode5_Update_NewPlayerSetup_SetFlagBit
    dw GameMode5_Update_NewPlayerSetup_AdvanceLinkScreenSubState
    dw GameMode5_Update_NewPlayerSetup_RunNameEntryStateWhenNotFading
    dw GameMode5_Update_NewPlayerSetup_InitGoldAndClearInventory

; entry 0 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
GameMode5_Update_NewPlayerSetup_ToStartPaletteFadeAndStep::
Jump_007_684C:: ; address name
    ld a, $04
    call StartPaletteFade
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB, wSGBActive
; writes: rSVBK, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wScreenTileBuffer, wScreenAttrBuffer, wOBJPaletteBuffer, wLinkScreenSubState
GameMode5_Update_NewPlayerSetup_DrawFullScreenBufferToBGMap::
Jump_007_6856:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $C3
    ld hl, wScreenTileBuffer
    ld bc, $02D0
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    ld hl, wScreenAttrBuffer
    ld bc, $02D0
    call FillBytes
    xor a, a
    ldh [rSVBK], a

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, [wSGBActive]
    or a, a
    jr z, .set_text_window_tile_lo
    ld hl, wOBJPaletteBuffer
    ld de, wOBJPaletteBuffer + $20
    ld b, $20

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop

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
    ld a, $FC
    call StartPaletteFade
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wLinkScreenSubState
GameMode5_Update_NewPlayerSetup_WaitFadeState::
Jump_007_68B7:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; writes: wWorkBuf
; points at: wLinkScreenSubState
GameMode5_Update_NewPlayerSetup_SetFlagBit::
Jump_007_68C1:: ; address name
    ld e, $01
    ld d, $00
    call SetFlagBit
    ld a, $01
    ld [wWorkBuf], a
    ld de, $0000
    call TestFlagBit
    jr c, .done
    xor a, a
    ld [wWorkBuf], a

.done:
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
GameMode5_Update_NewPlayerSetup_AdvanceLinkScreenSubState::
Jump_007_68DE:: ; address name
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wRandomLo, wArg5
; writes: wSaveByte16
; points at: wArg1, wNameGlyphBuf, wPlayerName, wLinkScreenSubState
GameMode5_Update_NewPlayerSetup_RunNameEntryStateWhenNotFading::
Jump_007_68E3:: ; address name
    ld hl, wArg1
    ld a, $00
    ld [hl+], a
    ld a, [wWorkBuf]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall RunNameEntryStateWhenNotFading
    call NextTableByte
    ld a, [wRandomLo]
    ld [wSaveByte16], a
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld de, wNameGlyphBuf
    ld hl, wPlayerName
    ld b, $0A

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in GameMode5_Update_NewPlayerSetup
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, hPlayerX, wFollowerRecords, hPlayerY, hPlayerFacing, wPartyCount, ...
; points at: wKeyList
GameMode5_Update_NewPlayerSetup_InitGoldAndClearInventory::
Jump_007_6919:: ; address name
    ld a, $38
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    xor a, a
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld a, $00
    ld [wPartyCount], a
    ld a, $00
    ld [wPartyList], a
    call InitGoldAndClearInventory
    call GameMode5_Update_NewPlayerSetup_Case06_LoadMonsterRecord
    ld hl, wKeyList
    ld bc, $0080
    ld a, $FF
    call FillBytes
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, $03
    ld [wLinkScreenState], a
    ret

; wGold = 100 and the 24 wInventory slots = 0 (the new-game setup path, Func_007_65F1) (E-0074)
; 1 call site from 1 routine (e.g. GameMode5_Update_NewPlayerSetup_InitGoldAndClearInventory)
; writes: wGoldLo, wGoldMid, wGoldHi
; points at: wInventory
InitGoldAndClearInventory::
Func_007_695A:: ; address name
    ld a, $64
    ld [wGoldLo], a
    ld a, $00
    ld [wGoldMid], a
    ld a, $00
    ld [wGoldHi], a
    ld hl, wInventory
    ld bc, $0018
    ld a, $00
    call FillBytes
    ret

; only called from GameMode5_Update_NewPlayerSetup_Case06 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_NewPlayerSetup_InitGoldAndClearInventory)
; reads: wRecordBuffer, wRecordBufferData, wScreenAttrBuffer, wSpeciesRecord
; writes: rRAMG, rRAMB, wMonsterId, wSpeciesIdLo, wSpeciesIdHi
; points at: sRecords, wPlayerName
GameMode5_Update_NewPlayerSetup_Case06_LoadMonsterRecord::
Func_007_6975:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, $0001
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld hl, sRecords
    ld a, $02
    ld [hl+], a
    ld a, $1C
    ld [hl+], a
    ld a, $2F
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $2B
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wRecordBuffer]
    ld [hl+], a
    ld a, [wRecordBuffer + $1]
    ld [hl+], a
    inc hl
    xor a, a
    ld [hl+], a
    ld de, wPlayerName
    ld b, $0B
    call CopyBBytesDEToHL_Bank07
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wRecordBufferData]
    ld [hl+], a
    ld a, [wRecordBufferData + $1]
    ld [hl+], a
    ld a, [wRecordBufferData + $2]
    ld [hl+], a
    ld a, [wRecordBufferData + $3]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    xor a, a
    ld [hl+], a
    ld a, [wRecordBufferData + $7]
    ld [hl+], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
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
    ld [hl+], a
    ld [hl+], a
    ld a, [wRecordBufferData + $14]
    ld [hl+], a
    ld a, [wRecordBufferData + $15]
    ld [hl+], a
    ld a, [wRecordBufferData + $16]
    ld [hl+], a
    ld a, [wRecordBufferData + $17]
    ld [hl+], a
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, sRecords + $D
    ld a, [wSpeciesRecord]
    ld [hl], a
    ld a, l
    add a, $2F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [hl+], a
    ld b, $16
    ld a, $FF
    call FillBBytesAtHL_Bank07
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $18
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1B
    call CopyBBytesDEToHL_Bank07
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld [hl], $00
    ld hl, sRecords + $8E
    call GameMode5_Update_NewPlayerSetup_Case06_Sub01_Sub01
    ld hl, sRecords + $99
    call GameMode5_Update_NewPlayerSetup_Case06_Sub01_Sub01
    ld hl, sRecords + $1E
    call GameMode5_Update_NewPlayerSetup_Case06_Sub01_Sub01
    ld hl, sRecords + $29
    call GameMode5_Update_NewPlayerSetup_Case06_Sub01_Sub01
    farcall SetSpeciesFlag
    ret

; stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0 (E-0065) (the same 5 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. GameMode5_Update_NewPlayerSetup_Case06_LoadMonsterRecord)
FillBBytesAtHL_Bank07::
Func_007_6AD0:: ; address name
    ld [hl+], a
    dec b
    jr nz, FillBBytesAtHL_Bank07
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
; 2 call sites from 1 routine (e.g. GameMode5_Update_NewPlayerSetup_Case06_LoadMonsterRecord)
CopyBBytesDEToHL_Bank07::
Func_007_6AD5:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank07
    ret

; only called from GameMode5_Update_NewPlayerSetup_Case06_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. GameMode5_Update_NewPlayerSetup_Case06_LoadMonsterRecord)
GameMode5_Update_NewPlayerSetup_Case06_Sub01_Sub01::
Func_007_6ADC:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld b, $07

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; entry 2 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkSession, wLinkScreenState, wScreenState, wScreenByteEE, wSaveStep, wLinkSceneByte4B, wSaveStateFlag, wScreenStep, ...
; writes: wScreenByteEE, wGameMode, wModeChangeRequest, wMapType, wTalkEventIndex, wTalkEventGroup, hPlayerX, hPlayerY, ...
GameMode5_Update_LinkExchangeJoypadPerFrame::
Jump_007_6AEE:: ; address name
    ld a, [wLinkSession]
    cp a, $05
    jp z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04_CallLinkExchangeJoypadPerFrame
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp a, $0C
    jr z, .check_screen_sub_step
    cp a, $0D
    jp z, .check_screen_step
    ld a, [wScreenByteEE]
    and a, a
    jr z, .check_link_scene_byte4_b
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a, a
    ld [wScreenByteEE], a

.check_link_scene_byte4_b:
    ld a, [wLinkSceneByte4B]
    or a, a
    ret z
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wMapType], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $21
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    ld a, $E0
    ldh [hPlayerX], a
    ld a, $00
    ldh [hPlayerY], a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $14
    ldh [hMapId], a
    xor a, a
    ldh [hPlayerStateFlags], a
    ld [wPartyCount], a
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, [wSaveStateFlag]
    ld [wScriptByte65], a
    xor a, a
    ld [wSaveStateFlag], a
    xor a, a
    ld [wLinkMode], a
    ld [wLinkSceneByte4B], a
    ld [wScriptInDataBank], a
    ld [wMessageMode], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    cp a, $20
    jr z, .call_call_draw_party_species_sprites
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $15
    jr z, .call_draw_wca36_sprite_part_bank_f1
    cp a, $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_wca36_sprite_part_bank_f1:
    farcall DrawWCA36SpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret
    db $C9

; entry 3 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenState
GameMode5_Update_LinkExchangeJoypadPerFrame_Case03::
Jump_007_6BB7:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, .return
    ret

.return:
    ret

; entry 4 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenState, wScreenState, wScreenStep, wScreenSubStep
GameMode5_Update_LinkExchangeJoypadPerFrame_Case04::
Jump_007_6BC3:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    or a, a
    jr nz, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp a, $0C
    jr z, .check_screen_sub_step
    cp a, $0D
    jr z, .check_screen_step
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $20
    jr z, .call_call_draw_party_species_sprites
    cp a, $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $15
    jr z, .call_draw_wca36_sprite_part_bank_f1
    cp a, $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_wca36_sprite_part_bank_f1:
    farcall DrawWCA36SpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret

; runs the routine for wD06A (jump table of nine states) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession4Exchange_LinkReceiveStepWithBuffer)
; reads: wLinkScreenState
RunLinkSession4ScreenState::
Func_007_6C12:: ; address name
    ld a, [wLinkScreenState]
    rst $00
    dw RunLinkSession4ScreenState_SaveAndSync
    dw RunLinkSession4ScreenState_WriteLinkScreenSubStateAndLinkScreenFlagEtc
    dw RunLinkSession4ScreenState_Case02
    dw RunLinkSession4ScreenState_Case03
    dw RunLinkSession4ScreenState_StartWithPresetRules
    dw RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc
    dw RunLinkSession4ScreenState_Case06_DecompressToVRAMAndStep
    dw RunLinkSession4ScreenState_ToEggServiceMenu_Bank1B
    dw RunLinkSession4ScreenState_ResetAndSignal

; by wLinkScreenSubState: RunSaveSteps, then a link message wait
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkSession4ScreenState_SaveAndSync::
Jump_007_6C28:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkSession4ScreenState_SaveAndSync_RunSaveSteps
    dw RunLinkSession4ScreenState_SaveAndSync_SetLinkScreenSubState
    dw RunLinkSession4ScreenState_SaveAndSync_WaitLinkMessage

; entry 0 of the `rst $00` table in RunLinkSession4ScreenState_SaveAndSync
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkScreenSubState
; writes: wSubMenuCursor, wLinkSendByte, wLinkScreenSubState
RunLinkSession4ScreenState_SaveAndSync_RunSaveSteps::
Jump_007_6C32:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    di
    farcall RunSaveSteps
    ei
    call RunLinkSession4ScreenState_SaveAndSync_Case00_LoadSRAMRecordWord
    farcall FullyHealParty
    ld a, $04
    ld [wSubMenuCursor], a
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wLinkScreenSubState]
    inc a
    ld [wLinkScreenSubState], a
    ret

; only called from RunLinkSession4ScreenState_SaveAndSync_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession4ScreenState_SaveAndSync_RunSaveSteps)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
RunLinkSession4ScreenState_SaveAndSync_Case00_LoadSRAMRecordWord::
Func_007_6C59:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

.loop:
    push hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [rRAMG], a
    ld a, [wPartyCount]
    cp a, $03
    ret z
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

; entry 1 of the `rst $00` table in RunLinkSession4ScreenState_SaveAndSync
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
; writes: wLinkScreenSubState, wLinkSendByte
RunLinkSession4ScreenState_SaveAndSync_SetLinkScreenSubState::
Jump_007_6CAB:: ; address name
    ld a, [wLinkScreenSubState]
    inc a
    ld [wLinkScreenSubState], a
    ld a, $D3
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession4ScreenState_SaveAndSync
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkScreenState
; writes: wLinkSendByte, wLinkScreenSubState, wLinkScreenState
RunLinkSession4ScreenState_SaveAndSync_WaitLinkMessage::
Jump_007_6CB8:: ; address name
    ld a, [wLinkMessage]
    cp a, $D3
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld [wLinkScreenSubState], a
    ld a, [wLinkScreenState]
    inc a
    ld [wLinkScreenState], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession4ScreenState
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wJoypadPressed, wMenuState
; writes: wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte, wBattleKind, wLinkSetupMode, wLinkScreenState
; points at: wLinkScreenState, wMenuState
RunLinkSession4ScreenState_WriteLinkScreenSubStateAndLinkScreenFlagEtc::
Jump_007_6CCD:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .cp_FD
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenState
    inc [hl]
    jp .return

.cp_FD:
    cp a, $FD
    jr nz, .cp_FC
    ld a, $08
    ld [wBattleKind], a
    ld hl, wLinkScreenState
    inc [hl]
    ld hl, wLinkScreenState
    inc [hl]
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    jp .return

.cp_FC:
    cp a, $FC
    jr nz, .cp_FB
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    jr .set_link_screen_state_to_08

.cp_FB:
    cp a, $FB
    jr nz, .call_move_vertical_cursor_in_list_hl
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a

.set_link_screen_state_to_08:
    ld a, $08
    ld [wLinkScreenState], a
    jp .return

.call_move_vertical_cursor_in_list_hl:
    ld de, $5096
    ld hl, wMenuState
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    and a, $03
    cp a, $03
    jr z, .set_link_send_byte_to_FE
    or a, a
    jr z, .call_init_link_rules_preset_a
    cp a, $01
    jr z, .call_init_link_rules_preset_b
    call LoadInvertedBit7FlagsToWorkBuf
    ld a, $08
    ld [wBattleKind], a
    ld de, $FD03
    jr .set_link_screen_state

.call_init_link_rules_preset_a:
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld de, $FB05
    jr .set_link_screen_state

.call_init_link_rules_preset_b:
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld de, $FC05

.set_link_screen_state:
    ld a, e
    ld [wLinkScreenState], a
    ld a, d
    ld [wLinkSendByte], a
    jr .return

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .return

.set_link_send_byte_to_FE:
    ld a, $FE
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkScreenFlag], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld hl, wLinkScreenState
    inc [hl]

.return:
    ret

; stores 0, 0, 0, $63, $29, $01, 0, 0, $63, $80 at wD043-wD04C (E-0120)
; 6 call sites from 5 routines (e.g. RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc, RunLinkSession4ScreenState_WriteLinkScreenSubStateAndLinkScreenFlagEtc, RunLinkSession4ScreenState_Case02_WriteBattleKindAndLinkScreenStateEtc, RunLinkSession4ScreenState_Case03_WriteSubMenuCursorAndLinkSendByteEtc, ...)
; points at: wLinkRules
InitLinkRulesPresetA::
Func_007_6DA9:: ; address name
    ld hl, wLinkRules
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld a, $29
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld [hl], $80
    ret

; stores $01, $81, $01, $63, $29, $01, $80, $01, $9E, $00 at wD043-wD04C (E-0120)
; 6 call sites from 5 routines (e.g. RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc, RunLinkSession4ScreenState_WriteLinkScreenSubStateAndLinkScreenFlagEtc, RunLinkSession4ScreenState_Case02_WriteBattleKindAndLinkScreenStateEtc, RunLinkSession4ScreenState_Case03_WriteSubMenuCursorAndLinkSendByteEtc, ...)
; points at: wLinkRules
InitLinkRulesPresetB::
Func_007_6DC2:: ; address name
    ld hl, wLinkRules
    ld a, $01
    ld [hl+], a
    ld a, $81
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld a, $29
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $80
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $9E
    ld [hl+], a
    ld [hl], $00
    ret

; wD09D = 0, then wD09E-wD0A2 = the inverted bit 7 of wD044, wD048, wD049, wD04B and wD04C (E-0121)
; 3 call sites from 3 routines (e.g. RunLinkSession4ScreenState_WriteLinkScreenSubStateAndLinkScreenFlagEtc, RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD, RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD)
; reads: wLinkRules, wLinkRuleTurnLimit
; points at: wWorkBuf
LoadInvertedBit7FlagsToWorkBuf::
Func_007_6DE3:: ; address name
    ld hl, wWorkBuf
    xor a, a
    ld [hl+], a
    ld a, [wLinkRules + $1]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wLinkRules + $5]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wLinkRules + $6]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wLinkRuleTurnLimit]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [wLinkRules + $9]
    rlca
    and a, $01
    xor a, $01
    ld [hl], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession4ScreenState
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkSession4ScreenState_Case02::
Jump_007_6E16:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkSession4ScreenState_Case02_WriteBattleKindAndLinkScreenStateEtc
    dw RunLinkSession4ScreenState_Case02_SetLinkScreenSubState
    dw RunLinkSession4ScreenState_Case02_CopyRecordRectToScreenBuffer_Bank07
    dw RunLinkSession4ScreenState_Case02_WaitLinkMessage
    dw RunLinkSession4ScreenState_Case02_ShowStringHL_Bank07
    dw RunLinkSession4ScreenState_Case02_WaitTextFlags
    dw RunLinkSession4ScreenState_Case02_WaitLinkMessage_Case06
    dw RunLinkSession4ScreenState_Case02_FillBytes

; entry 0 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole
; writes: wBattleKind, wLinkScreenState, wLinkSendByte, wLinkSetupMode
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_WriteBattleKindAndLinkScreenStateEtc::
Jump_007_6E2A:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, .clear_link_send_byte
    cp a, $FE
    jr z, .clear_link_send_byte
    cp a, $FB
    jr z, .check_link_role
    cp a, $FC
    jr z, .check_link_role2
    cp a, $FD
    jr z, .check_link_role3
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .clear_link_send_byte
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

.check_link_role2:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .clear_link_send_byte
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

.check_link_role3:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .clear_link_send_byte
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a, a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_SetLinkScreenSubState::
Jump_007_6E9A:: ; address name
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $02
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_CopyRecordRectToScreenBuffer_Bank07::
Jump_007_6EA4:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_WaitLinkMessage::
Jump_007_6EC5:: ; address name
    ld a, [wLinkMessage]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_ShowStringHL_Bank07::
Jump_007_6ECF:: ; address name
    ld hl, $0302
    ld a, [wLinkScreenFlag]
    or a, a
    jr z, .call_show_string_hl_bank07
    inc l

.call_show_string_hl_bank07:
    call ShowStringHL_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_WaitTextFlags::
Jump_007_6EE1:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case02_WaitLinkMessage_Case06::
Jump_007_6EF0:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkSession4ScreenState_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSession, wLinkExchangeState, wLinkRole, wLinkStatus, wLinkMode, wLinkMessage, wLinkSendByte, wLinkScreenStep
; points at: wWorkBuf, wModeChangeRequest, wGameMode
RunLinkSession4ScreenState_Case02_FillBytes::
Jump_007_6EFB:: ; address name
    xor a, a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    ld [wLinkMode], a
    ld [wLinkMessage], a
    ld [wLinkSendByte], a
    ld [wLinkScreenStep], a
    ld hl, wWorkBuf
    ld bc, $001E
    xor a, a
    call FillBytes
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 3 of the `rst $00` table in RunLinkSession4ScreenState
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkSession4ScreenState_Case03::
Jump_007_6F34:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkSession4ScreenState_Case03_WriteSubMenuCursorAndLinkSendByteEtc
    dw RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL
    dw RunLinkSession4ScreenState_Case03_SetLinkSendByte
    dw RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc
    dw RunLinkSession4ScreenState_Case03_WaitLinkMessage
    dw RunLinkSession4ScreenState_Case03_WriteLinkBufferCountLoAndLinkTimeoutLoEtc
    dw RunLinkSession4ScreenState_Case03_WaitLinkMessage_Case06
    dw RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep
    dw RunLinkSession4ScreenState_Case03_ToShowStringHL_Bank07AndStep
    dw RunLinkSession4ScreenState_Case03_WaitTextFlags
    dw RunLinkSession4ScreenState_Case03_WriteLinkScreenStateAndLinkScreenSubStateEtc
    dw RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case0B
    dw RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07
    dw RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case0D
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case0F
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case10
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case11
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case12
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case13
    dw RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case14
    dw RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case15
    dw RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07_Case16
    dw RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case17
    dw RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case18
    dw RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep_Case19
    dw RunLinkSession4ScreenState_Case03_QueueSoundEffect
    dw RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case1B
    dw RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep_Case1C
    dw RunLinkSession4ScreenState_Case03_QueueSoundEffect_Case1D
    dw RunLinkSession4ScreenState_Case03_QueueSoundEffect_Case1E

; entry 0 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole
; writes: wSubMenuCursor, wLinkSendByte, wBattleKind, wLinkSetupMode, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteSubMenuCursorAndLinkSendByteEtc::
Jump_007_6F76:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, .check_link_role
    cp a, $FD
    jr z, .check_link_role2
    cp a, $FB
    jr z, .check_link_role3
    cp a, $FC
    jr z, .check_link_role4
    jr .call_fill_screen_tile_buffer_with_d

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    ret

.check_link_role2:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkSendByte], a
    ret

.check_link_role3:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

.check_link_role4:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

.call_fill_screen_tile_buffer_with_d:
    ld d, $C3
    call FillScreenTileBufferWithD
    ld hl, $54DB
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawWorkBufSelectionTilesAndPanels
    call DrawScreenBufferToBGMap0_Bank07
    ld a, $06
    ld [wSubMenuCursor], a
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 1 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState
; writes: wSubMenuCursor2, wMenuSelectedMember, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSubState, wWorkBuf
RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL::
Jump_007_7010:: ; address name
    ld hl, wMenuSubState
    ld de, $509E
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSubState]
    ld hl, $509E
    and a, $07
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $02
    ld [wSubMenuCursor2], a
    ld a, [wMenuSubState]
    and a, $07
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSelectedMember], a
    ld a, [wMenuSubState]
    and a, $07
    ld hl, $7063
    add_a_to_hl
    ld a, [hl]
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ret
    db $03, $0B, $15, $18, $1B, $1E

; entry 2 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkSession4ScreenState_Case03_SetLinkSendByte::
Jump_007_7069:: ; address name
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 3 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember, wWorkBuf
; writes: wWorkBuf, wLinkScreenSubState, wLinkSetupMode, wLinkSendByte
; points at: wMenuSelectedMember, wLinkRules, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc::
Jump_007_707C:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50AA
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr z, .skip
    ld a, $02
    ld [wLinkScreenSubState], a
    ret

.skip:
    ld hl, wLinkRules
    ld a, $01
    ld [hl+], a
    ld a, [wWorkBuf + $1]
    call SetHLBit7FromInverseABit0
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $2]
    call SetHLBit7FromInverseABit0
    ld a, [wWorkBuf + $3]
    call SetHLBit7FromInverseABit0
    inc hl
    ld a, [wWorkBuf + $4]
    call SetHLBit7FromInverseABit0
    ld a, [wWorkBuf + $5]
    call SetHLBit7FromInverseABit0
    ld a, $02
    ld [wLinkSetupMode], a
    call CopyLinkRulesToLinkRulesCopy
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; bit 7 of [HL] = NOT bit 0 of A (the other bits kept); HL += 1 (E-0119)
; 5 call sites from 1 routine (e.g. RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc)
SetHLBit7FromInverseABit0::
Func_007_70E9:: ; address name
    rrca
    and a, $80
    xor a, $80
    res 7, [hl]
    or a, [hl]
    ld [hl+], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WaitLinkMessage::
Jump_007_70F3:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkBufferCountLo, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkReady, wLinkSendByte
; points at: wLinkRules, wLinkPartnerName, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteLinkBufferCountLoAndLinkTimeoutLoEtc::
Jump_007_7103:: ; address name
    ld a, $0A
    ld [wLinkBufferCountLo], a
    ld hl, wLinkRules
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $01
    ld [wLinkReady], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WaitLinkMessage_Case06::
Jump_007_712D:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep::
Jump_007_713C:: ; address name
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_ToShowStringHL_Bank07AndStep::
Jump_007_7153:: ; address name
    ld hl, $0306
    call ShowStringHL_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WaitTextFlags::
Jump_007_715E:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte
RunLinkSession4ScreenState_Case03_WriteLinkScreenStateAndLinkScreenSubStateEtc::
Jump_007_7168:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .cp_01
    ld a, $02
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

.cp_01:
    cp a, $01
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $05
    ld [wLinkScreenState], a
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $00
    ld [wLinkScreenFlag], a
    ret

; entry 11 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case0B::
Jump_007_719B:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50AE
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $1], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $1], a
    or a, a
    jr z, .skip
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 12 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRules
; writes: wMenuCursor, wSubMenuCursor, wSubMenuCursor2
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07::
Jump_007_71D8:: ; address name
    ld hl, $561F
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld de, wWorkBuf + $6
    ld hl, vBGMap0 + $8C
    ld a, [wLinkRules + $1]
    ld c, a
    ld a, [wLinkRules + $2]
    ld b, a
    ld a, $02
    bit 6, c
    jr z, .call_run_link_session4_screen_state_case03
    ld a, b
    rlca
    rlca
    and a, $01

.call_run_link_session4_screen_state_case03:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    ld a, $02
    bit 5, c
    jr z, .call_run_link_session4_screen_state_case032
    ld a, b
    rrca
    swap a
    and a, $01

.call_run_link_session4_screen_state_case032:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    ld a, $02
    bit 4, c
    jr z, .call_run_link_session4_screen_state_case033
    ld a, b
    swap a
    and a, $01

.call_run_link_session4_screen_state_case033:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    ld a, $02
    bit 3, c
    jr z, .call_run_link_session4_screen_state_case034
    ld a, b
    rrca
    rrca
    rrca
    and a, $01

.call_run_link_session4_screen_state_case034:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    ld a, $02
    bit 2, c
    jr z, .call_run_link_session4_screen_state_case035
    ld a, b
    rrca
    rrca
    and a, $01

.call_run_link_session4_screen_state_case035:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    ld a, $02
    bit 1, c
    jr z, .call_run_link_session4_screen_state_case036
    ld a, b
    rrca
    and a, $01

.call_run_link_session4_screen_state_case036:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    ld a, $02
    bit 0, c
    jr z, .call_run_link_session4_screen_state_case037
    ld a, b
    and a, $01

.call_run_link_session4_screen_state_case037:
    ld [de], a
    call RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte
    xor a, a
    ld [wMenuCursor], a
    ld a, $07
    ld [wSubMenuCursor], a
    ld a, $03
    ld [wSubMenuCursor2], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; only called from RunLinkSession4ScreenState_Case03_Case0C (E-0047)
; 7 call sites from 1 routine (e.g. RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07)
RunLinkSession4ScreenState_Case03_Case0C_WriteVRAMByte::
Func_007_7270:: ; address name
    push bc
    push hl
    add a, a
    add_a_to_hl
    ld a, $BC
    call WriteVRAMByte
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    ret

; entry 13 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuCursor, wWorkBuf
; writes: wLinkRules, wLinkScreenSubState
; points at: wMenuCursor, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case0D::
Jump_007_7284:: ; address name
    ld hl, wMenuCursor
    ld de, $50C2
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    ld hl, $50C2
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, [wMenuCursor]
    and a, $07
    inc a
    ld hl, wLinkScreenSubState
    add a, [hl]
    ld [hl], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld bc, $0000
    ld a, [wWorkBuf + $6]
    cp a, $02
    jr z, .check_work_buf
    rrca
    rrca
    and a, $40
    or a, b
    ld b, a
    set 6, c

.check_work_buf:
    ld a, [wWorkBuf + $7]
    cp a, $02
    jr z, .check_work_buf2
    swap a
    rlca
    and a, $20
    or a, b
    ld b, a
    set 5, c

.check_work_buf2:
    ld a, [wWorkBuf + $8]
    cp a, $02
    jr z, .check_work_buf3
    swap a
    and a, $10
    or a, b
    ld b, a
    set 4, c

.check_work_buf3:
    ld a, [wWorkBuf + $9]
    cp a, $02
    jr z, .check_work_buf4
    swap a
    rrca
    and a, $08
    or a, b
    ld b, a
    set 3, c

.check_work_buf4:
    ld a, [wWorkBuf + $A]
    cp a, $02
    jr z, .check_work_buf5
    rlca
    rlca
    and a, $04
    or a, b
    ld b, a
    set 2, c

.check_work_buf5:
    ld a, [wWorkBuf + $B]
    cp a, $02
    jr z, .check_work_buf6
    rlca
    and a, $02
    or a, b
    ld b, a
    set 1, c

.check_work_buf6:
    ld a, [wWorkBuf + $C]
    cp a, $02
    jr z, .set_link_rules
    and a, $01
    or a, b
    ld b, a
    set 0, c

.set_link_rules:
    ld a, c
    ld [wLinkRules + $1], a
    ld a, b
    ld [wLinkRules + $2], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

; entry 14 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07::
Jump_007_732C:: ; address name
    ld hl, wWorkBuf + $6
    ld de, $50D0
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $6]
    and a, $03
    ld hl, $50D0
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 15 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case0F::
Jump_007_7351:: ; address name
    ld hl, wWorkBuf + $7
    ld de, $50D6
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $7]
    and a, $03
    ld hl, $50D6
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 16 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case10::
Jump_007_7376:: ; address name
    ld hl, wWorkBuf + $8
    ld de, $50DC
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $8]
    and a, $03
    ld hl, $50DC
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 17 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case11::
Jump_007_739B:: ; address name
    ld hl, wWorkBuf + $9
    ld de, $50E2
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $9]
    and a, $03
    ld hl, $50E2
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 18 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case12::
Jump_007_73C0:: ; address name
    ld hl, wWorkBuf + $A
    ld de, $50E8
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $A]
    and a, $03
    ld hl, $50E8
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 19 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case13::
Jump_007_73E5:: ; address name
    ld hl, wWorkBuf + $B
    ld de, $50EE
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $B]
    and a, $03
    ld hl, $50EE
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 20 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteBCTileAtWordTableEntry_Bank07_Case14::
Jump_007_740A:: ; address name
    ld hl, wWorkBuf + $C
    ld de, $50F4
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $C]
    and a, $03
    ld hl, $50F4
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0D
    ld [wLinkScreenSubState], a
    ret

; entry 21 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case15::
Jump_007_742F:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50B2
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $2], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $2], a
    or a, a
    jr z, .skip
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 22 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRules
; writes: wMenuCursor, wSubMenuCursor
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07_Case16::
Jump_007_746C:: ; address name
    ld hl, $578B
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $E0
    ld de, wScreenTileBuffer + $E0
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkSession4ScreenState_HLToDecimalDigits_Shared02
    call RunLinkSession4ScreenState_HLToDecimalDigits_Shared03
    ld a, [wLinkRules + $4]
    rlca
    rlca
    and a, $01
    ld [wMenuCursor], a
    ld a, $02
    ld [wSubMenuCursor], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 23 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuCursor, wLinkRules, wJoypadPressed
; writes: wLinkRules, wLinkScreenSubState
; points at: wMenuCursor
RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case17::
Jump_007_7498:: ; address name
    ld hl, wMenuCursor
    ld de, $50FA
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, .check_joypad_pressed
    ld a, [wMenuCursor]
    and a, $01
    jr nz, .read_link_rules
    ld a, [wLinkRules + $4]
    ld l, a
    ld a, [wLinkRules + $5]
    and a, $C0
    push af
    ld a, [wLinkRules + $5]
    and a, $3F
    ld h, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .next
    dec hl
    ld a, h
    or a, a
    jr nz, .set_link_rules
    ld a, l
    cp a, $03
    jr nc, .set_link_rules
    ld hl, $0003
    jr .set_link_rules

.next:
    inc hl
    ld a, l
    sub a, $29
    ld a, h
    sbc a, $01
    jr c, .set_link_rules
    ld hl, $0129

.set_link_rules:
    pop af
    or a, h
    ld [wLinkRules + $5], a
    ld a, l
    ld [wLinkRules + $4], a
    call RunLinkSession4ScreenState_HLToDecimalDigits_Shared02
    jr .check_joypad_pressed

.read_link_rules:
    ld a, [wLinkRules + $3]
    ld l, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .skip
    dec hl
    ld a, l
    or a, a
    jr nz, .set_link_rules2
    ld hl, $0001
    jr .set_link_rules2

.skip:
    inc l
    ld a, l
    cp a, $64
    jr c, .set_link_rules2
    ld hl, $0063

.set_link_rules2:
    ld a, l
    ld [wLinkRules + $3], a
    call RunLinkSession4ScreenState_HLToDecimalDigits_Shared03

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    rrca
    rrca
    and a, $40
    ld h, a
    ld a, [wLinkRules + $5]
    and a, $BF
    or a, h
    ld [wLinkRules + $5], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

; only called from routines of RunLinkSession4ScreenState (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case17, RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07_Case16)
; reads: wLinkRules, wDigits
RunLinkSession4ScreenState_HLToDecimalDigits_Shared02::
Func_007_7535:: ; address name
    ld a, [wLinkRules + $4]
    ld l, a
    ld a, [wLinkRules + $5]
    and a, $3F
    ld h, a
    push hl
    call HLToDecimalDigits
    pop de
    ld b, $C5
    ld a, e
    sub a, $04
    ld a, d
    sbc a, $00
    jr nc, .call_write_vram_byte_inc
    ld b, $C3

.call_write_vram_byte_inc:
    ld hl, vBGMap0 + $10E
    ld a, b
    call WriteVRAMByteInc
    ld c, $01
    ld a, [wDigits]
    add a, $E0
    cp a, $E0
    jr nz, .call_write_vram_byte_inc2
    ld c, $00
    ld a, $C3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, .call_write_vram_byte_inc3
    bit 0, c
    jr nz, .call_write_vram_byte_inc3
    ld a, $C3

.call_write_vram_byte_inc3:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByteInc
    ld b, $C6
    ld a, e
    sub a, $29
    ld a, d
    sbc a, $01
    jr c, .call_write_vram_byte
    ld b, $C3

.call_write_vram_byte:
    ld a, b
    call WriteVRAMByte
    ret

; only called from routines of RunLinkSession4ScreenState (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkSession4ScreenState_Case03_MoveVerticalCursorInListHL_Case17, RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07_Case16)
; reads: wLinkRules, wDigits
RunLinkSession4ScreenState_HLToDecimalDigits_Shared03::
Func_007_7594:: ; address name
    ld a, [wLinkRules + $3]
    ld l, a
    ld h, $00
    push hl
    call HLToDecimalDigits
    pop de
    ld b, $C5
    ld a, e
    cp a, $02
    jr nc, .call_write_vram_byte_inc
    ld b, $C3

.call_write_vram_byte_inc:
    ld hl, vBGMap0 + $14E
    ld a, b
    call WriteVRAMByteInc
    ld a, $C3
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, .call_write_vram_byte_inc2
    ld a, $C3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByteInc
    ld b, $C6
    ld a, e
    cp a, $63
    jr c, .call_write_vram_byte
    ld b, $C3

.call_write_vram_byte:
    ld a, b
    call WriteVRAMByte
    ret

; entry 24 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case18::
Jump_007_75D8:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50B6
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $3], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $3], a
    or a, a
    jr z, .skip
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 25 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep_Case19::
Jump_007_7615:: ; address name
    ld hl, $57F3
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $62
    ld de, wScreenTileBuffer + $62
    ld bc, $0F0B
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkSession4ScreenState_Case03_Case19_Sub01
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 26 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wLinkRules, wMenuCursor
; writes: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_QueueSoundEffect::
Jump_007_762F:: ; address name
    call RunLinkSession4ScreenState_Case03_Case1A_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ld a, [wLinkRules + $6]
    and a, $7F
    cp a, $7F
    jr nz, .clear_link_screen_sub_state
    ld a, [wLinkRules + $7]
    and a, $F0
    cp a, $F0
    jr nz, .clear_link_screen_sub_state
    ld a, $84
    call QueueSoundEffect
    ret

.clear_link_screen_sub_state:
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    call RunLinkSession4ScreenState_Case03_Case1A_ReadMenuCursor
    ld a, [wMenuCursor]
    call RunLinkSession4ScreenState_Shared05
    ret

; only called from RunLinkSession4ScreenState_Case03_Case1A (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession4ScreenState_Case03_QueueSoundEffect)
; reads: wMenuCursor
RunLinkSession4ScreenState_Case03_Case1A_ReadMenuCursor::
Func_007_766B:: ; address name
    ld a, [wMenuCursor]
    ld hl, $774D
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld hl, wLinkRules + $6
    add_a_to_hl
    ld a, d
    cpl
    ld e, a
    ld a, [hl]
    and a, d
    jr z, .skip
    ld a, [hl]
    and a, e
    jr .done

.skip:
    ld a, [hl]
    or a, d

.done:
    ld [hl], a
    ret

; only called from RunLinkSession4ScreenState_Case03_Case1A (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession4ScreenState_Case03_QueueSoundEffect)
; reads: wFrameCounterLo, wJoypadPressedRepeat
; writes: wFrameCounterLo
; points at: wMenuCursor
RunLinkSession4ScreenState_Case03_Case1A_EraseCursorAtEntryHL_Bank07::
Func_007_7690:: ; address name
    ld hl, wMenuCursor
    ld de, $7700
    ld a, [wFrameCounterLo]
    and a, $07
    jr z, .check_joypad_pressed_repeat
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .call_write_bb_tile_at_word_table_entry_c
    call EraseCursorAtEntryHL_Bank07
    jr .check_joypad_pressed_repeat

.call_write_bb_tile_at_word_table_entry_c:
    call WriteBBTileAtWordTableEntryC_Bank07

.check_joypad_pressed_repeat:
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, .check_joypad_pressed_repeat2
    ld a, [hl]
    cp a, $05
    jr c, .skip
    jr z, .clear_frame_counter_lo
    sub a, $06
    jr .clear_frame_counter_lo

.skip:
    add a, $06
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed_repeat3
    ld a, [hl]
    or a, a
    jr z, .skip2
    cp a, $06
    jr z, .skip3
    dec a
    jr .clear_frame_counter_lo

.skip2:
    ld a, $05
    jr .clear_frame_counter_lo

.skip3:
    ld a, $0A
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat3:
    ld a, [wJoypadPressedRepeat]
    and a, $10
    ret z
    ld a, [hl]
    cp a, $05
    jr z, .skip4
    cp a, $0A
    jr z, .skip5
    inc a
    jr .clear_frame_counter_lo

.skip4:
    xor a, a
    jr .clear_frame_counter_lo

.skip5:
    ld a, $06

.clear_frame_counter_lo:
    ld [hl], a
    xor a, a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    call WriteBBTileAtWordTableEntryC_Bank07
    ret
    db $43, $99, $45, $99, $47, $99, $49, $99, $4B, $99, $4D, $99, $83, $99, $85, $99
    db $87, $99, $89, $99, $8B, $99

; only called from RunLinkSession4ScreenState_Case03_Case19 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep_Case19)
RunLinkSession4ScreenState_Case03_Case19_Sub01::
Func_007_7716:: ; address name
    ld bc, $0B00

.loop:
    push bc
    ld a, c
    call RunLinkSession4ScreenState_Shared05
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; only called from routines of RunLinkSession4ScreenState (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkSession4ScreenState_Case03_QueueSoundEffect, RunLinkSession4ScreenState_Case03_Case19_Sub01)
RunLinkSession4ScreenState_Shared05::
Func_007_7724:: ; address name
    ld c, a
    ld hl, $774D
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld hl, wLinkRules + $6
    add_a_to_hl
    ld e, [hl]
    ld a, c
    ld hl, vBGMap0 + $E4
    add_a_to_hl
    ld a, e
    and a, d
    ld a, $C3
    jr nz, .call_write_vram_byte
    ld a, c

.call_write_vram_byte:
    call WriteVRAMByte
    ret
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $01, $80
    db $01, $40, $01, $20, $01, $10

; entry 27 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkSession4ScreenState_Case03_WriteWorkBufAndLinkScreenSubStateEtc_Case1B::
Jump_007_7763:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50BA
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $4], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $4], a
    or a, a
    jr z, .skip
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.skip:
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 28 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep_Case1C::
Jump_007_77A0:: ; address name
    ld hl, $589C
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $E1
    ld de, wScreenTileBuffer + $E1
    ld bc, $1205
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkSession4ScreenState_HLToDecimalDigits
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 29 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wLinkRuleTurnLimit
; writes: wLinkScreenSubState, wLinkRuleTurnLimit
RunLinkSession4ScreenState_Case03_QueueSoundEffect_Case1D::
Jump_007_77BA:: ; address name
    ld a, [wJoypadPressed]
    and a, $03
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wLinkScreenSubState], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wLinkRuleTurnLimit]
    and a, $80
    ld d, a
    ld a, [wLinkRuleTurnLimit]
    and a, $7F
    cp a, $0B
    jr c, .return
    dec a
    or a, d
    ld [wLinkRuleTurnLimit], a
    jr .call_run_link_session4_screen_state_hl_to

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, .return
    ld a, [wLinkRuleTurnLimit]
    and a, $80
    ld d, a
    ld a, [wLinkRuleTurnLimit]
    and a, $7F
    cp a, $63
    jr nc, .return
    inc a
    or a, d
    ld [wLinkRuleTurnLimit], a

.call_run_link_session4_screen_state_hl_to:
    call RunLinkSession4ScreenState_HLToDecimalDigits

.return:
    ret

; only called from routines of RunLinkSession4ScreenState (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkSession4ScreenState_Case03_QueueSoundEffect_Case1D, RunLinkSession4ScreenState_Case03_CopyRecordRectToScreenBuffer_Bank07AndStep_Case1C)
; reads: wLinkRuleTurnLimit, wDigits
; points at: wLinkTradeByte
RunLinkSession4ScreenState_HLToDecimalDigits::
Func_007_7807:: ; address name
    ld a, [wLinkRuleTurnLimit]
    and a, $7F
    push af
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld bc, wLinkTradeByte
    pop af
    cp a, $0B
    jr nc, .cp_63
    ld b, $C3

.cp_63:
    cp a, $63
    jr c, .call_write_vram_byte_inc
    ld c, $C3

.call_write_vram_byte_inc:
    ld hl, vBGMap0 + $12E
    ld a, b
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, .call_write_vram_byte_inc2
    ld a, $C3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByteInc
    ld a, c
    call WriteVRAMByte
    ret

; entry 30 of the `rst $00` table in RunLinkSession4ScreenState_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState
; points at: wMenuSelectedMember
RunLinkSession4ScreenState_Case03_QueueSoundEffect_Case1E::
Jump_007_7845:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50BE
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $5], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

; by wLinkScreenSubState: InitLinkRulesPresetA, a message, then link message exchange
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules::
Jump_007_7864:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkSession4ScreenState_StartWithPresetRules_InitLinkRulesPresetA
    dw RunLinkSession4ScreenState_StartWithPresetRules_ShowStringHL_Bank07AndStep
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags
    dw RunLinkSession4ScreenState_StartWithPresetRules_Case03
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags_Case04
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage_Case06
    dw RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD
    dw RunLinkSession4ScreenState_StartWithPresetRules_QueueSoundEffect
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage_Case09
    dw RunLinkSession4ScreenState_StartWithPresetRules_AdvanceLinkScreenSubState
    dw RunLinkSession4ScreenState_StartWithPresetRules_SetLinkSendByte

; entry 0 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wBattleKind, wLinkScreenState, wLinkSetupMode
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_InitLinkRulesPresetA::
Jump_007_7880:: ; address name
    ld a, [wLinkMessage]
    cp a, $FB
    jr z, .call_init_link_rules_preset_a
    cp a, $FC
    jr z, .call_init_link_rules_preset_b
    cp a, $FD
    jr z, .set_battle_kind_to_08
    jr .call_copy_record_rect_to_screen_buffer_bank07

.call_init_link_rules_preset_a:
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

.call_init_link_rules_preset_b:
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

.set_battle_kind_to_08:
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    ret

.call_copy_record_rect_to_screen_buffer_bank07:
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_ShowStringHL_Bank07AndStep::
Jump_007_78D9:: ; address name
    ld hl, $0304
    call ShowStringHL_Bank07
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags::
Jump_007_78E8:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_Case03::
Jump_007_78F2:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, .cp_01
    ld a, $02
    ld [wLinkScreenState], a
    ld a, $00
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

.cp_01:
    cp a, $01
    ret nz
    ld hl, $0305
    call ShowStringHL_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags_Case04::
Jump_007_791C:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkBufferCountLo, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkReady, wLinkSendByte
; points at: wLinkRecvBuffer, wLinkRules, wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage::
Jump_007_792B:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    ld a, $0A
    ld [wLinkBufferCountLo], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkRules
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $01
    ld [wLinkReady], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage_Case06::
Jump_007_795B:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; writes: wSubMenuCursor2, wMenuSelectedMember
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD::
Jump_007_796A:: ; address name
    ld d, $C3
    call FillScreenTileBufferWithD
    ld hl, $54DB
    call CopyRecordRectToScreenBuffer_Bank07
    call LoadInvertedBit7FlagsToWorkBuf
    call DrawWorkBufSelectionTilesAndPanels
    call DrawScreenBufferToBGMap0_Bank07
    ld a, $02
    ld [wSubMenuCursor2], a
    ld a, $00
    ld [wMenuSelectedMember], a
    ld hl, wLinkScreenSubState
    inc [hl]
    call CopyLinkRulesToLinkRulesCopy
    ret

; entry 8 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wLinkSetupMode, wLinkSendByte
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_QueueSoundEffect::
Jump_007_7990:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50AA
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr nz, .set_link_send_byte_to_FE
    ld a, $02
    ld [wLinkSetupMode], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    ret z

.set_link_send_byte_to_FE:
    ld a, $FE
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage_Case09::
Jump_007_79CF:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, $05
    ld [wLinkScreenState], a
    ld a, $01
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 10 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_AdvanceLinkScreenSubState::
Jump_007_79E4:: ; address name
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunLinkSession4ScreenState_StartWithPresetRules
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenFlag, wLinkScreenSubState
RunLinkSession4ScreenState_StartWithPresetRules_SetLinkSendByte::
Jump_007_79E9:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenFlag], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

; entry 5 of the `rst $00` table in RunLinkSession4ScreenState
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wLinkMessage, wMenuState, wLinkRole
; writes: wLinkSendByte, wLinkReady, wLinkScreenState, wLinkScreenSubState, wBattleKind, wLinkSetupMode, wLinkScreenFlag
; points at: wScreenTileBuffer, wLinkScreenState
RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc::
Jump_007_79FC:: ; address name
    ld a, [wLinkScreenSubState]
    and a, a
    jr z, .check_link_message
    jp .skip

.check_link_message:
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, .check_link_role
    cp a, $FD
    jr z, .check_link_role2
    jr .check_link_message2

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jp z, .set_link_screen_state_to_08
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    ret

.check_link_role2:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_link_screen_state_to_08
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkSendByte], a
    ret

.check_link_message2:
    ld a, [wLinkMessage]
    cp a, $FC
    jr z, .check_menu_state
    cp a, $FB
    jr z, .check_menu_state
    jr .set_link_screen_state_to_08

.check_menu_state:
    ld a, [wMenuState]
    and a, a
    jr z, .check_link_message3
    ld a, [wLinkMessage]
    cp a, $FC
    jr z, .set_link_screen_state_to_08
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_link_screen_state_to_08
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    jr .set_link_screen_state_to_08

.check_link_message3:
    ld a, [wLinkMessage]
    cp a, $FB
    jr z, .set_link_screen_state_to_08
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_link_screen_state_to_08
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    jr .set_link_screen_state_to_08

.set_link_screen_state_to_08:
    ld a, $08
    ld [wLinkScreenState], a
    ld a, $00
    ld [wLinkScreenSubState], a
    ret

.skip:
    ld hl, wScreenTileBuffer
    ld bc, $0280
    ld a, $C3
    call FillBytes
    call DrawScreenBufferToBGMap0_Bank07
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld hl, wLinkScreenState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunLinkSession4ScreenState
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenState
RunLinkSession4ScreenState_Case06_DecompressToVRAMAndStep::
Jump_007_7AC2:: ; address name
    farcall RunLinkSession4ScreenState_Case06_DecompressToVRAM
    ld hl, wLinkScreenState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkSession4ScreenState
; no direct call (reached through a table, a jump or a vector)
RunLinkSession4ScreenState_ToEggServiceMenu_Bank1B::
Jump_007_7ACD:: ; address name
    farcall EggServiceMenu_Bank1B
    ret

; draws a tile at wC200, wC266, wC2A6, wC2E6, wC326 or wC366 (or 6/3 past it) depending on wD09D-wD0A2, then runs the four panel routines Func_007_7B30, 7B9D, 7C07 and 7C5F (E-0121)
; 3 call sites from 3 routines (e.g. RunLinkSession4ScreenState_Case03_WriteSubMenuCursorAndLinkSendByteEtc, RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD, RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD)
; reads: wWorkBuf
DrawWorkBufSelectionTilesAndPanels::
Func_007_7AD4:: ; address name
    ld a, [wWorkBuf]
    ld hl, wScreenTileBuffer + $68
    ld bc, $0006
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $1]
    ld hl, wScreenTileBuffer + $CE
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $2]
    ld hl, wScreenTileBuffer + $10E
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $3]
    ld hl, wScreenTileBuffer + $14E
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $4]
    ld hl, wWindowTileBuffer + $26
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $5]
    ld hl, wWindowTileBuffer + $66
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    call DrawWorkBufSelectionTilesAndPanels_ReadLinkRules
    call DrawWorkBufSelectionTilesAndPanels_ReadLinkRulesAndDigits
    call DrawWorkBufSelectionTilesAndPanels_ReadLinkRules_Sub03
    call DrawWorkBufSelectionTilesAndPanels_HLToDecimalDigits
    ret

; writes tile $BC at HL when A = 0, else at HL + BC (E-0079)
; 6 call sites from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
WriteBCTileAtHLOrHLPlusBC::
Func_007_7B29:: ; address name
    or a, a
    jr z, .done
    add hl, bc

.done:
    ld [hl], $BC
    ret

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRules
DrawWorkBufSelectionTilesAndPanels_ReadLinkRules::
Func_007_7B30:: ; address name
    ld a, [wLinkRules + $1]
    ld c, a
    ld a, [wLinkRules + $2]
    ld b, a
    ld hl, wScreenTileBuffer + $E7
    ld a, $16
    bit 6, c
    jr z, .skip
    ld a, b
    rlca
    rlca
    and a, $01
    add a, $E0

.skip:
    ld [hl+], a
    ld a, $16
    bit 5, c
    jr z, .skip2
    ld a, b
    rrca
    swap a
    and a, $01
    add a, $E0

.skip2:
    ld [hl+], a
    ld a, $16
    bit 4, c
    jr z, .skip3
    ld a, b
    swap a
    and a, $01
    add a, $E0

.skip3:
    ld [hl+], a
    ld a, $16
    bit 3, c
    jr z, .skip4
    ld a, b
    rlca
    swap a
    and a, $01
    add a, $E0

.skip4:
    ld [hl+], a
    ld a, $16
    bit 2, c
    jr z, .skip5
    ld a, b
    rrca
    rrca
    and a, $01
    add a, $E0

.skip5:
    ld [hl+], a
    ld a, $16
    bit 1, c
    jr z, .skip6
    ld a, b
    rrca
    and a, $01
    add a, $E0

.skip6:
    ld [hl+], a
    ld a, $16
    bit 0, c
    jr z, .done
    ld a, b
    and a, $01
    add a, $E0

.done:
    ld [hl+], a
    ret

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRules, wDigits
DrawWorkBufSelectionTilesAndPanels_ReadLinkRulesAndDigits::
Func_007_7B9D:: ; address name
    ld de, $7BFD
    ld a, [wLinkRules + $5]
    bit 6, a
    jr z, .read_link_rules
    ld de, $7C02
    ld a, [wLinkRules + $3]
    ld c, a
    ld b, $00
    jr .skip

.read_link_rules:
    ld a, [wLinkRules + $4]
    ld c, a
    ld a, [wLinkRules + $5]
    and a, $01
    ld b, a

.skip:
    push bc
    ld hl, wScreenTileBuffer + $126
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    pop hl
    call HLToDecimalDigits
    ld c, $01
    ld hl, wScreenTileBuffer + $12C
    ld a, [wDigits]
    add a, $E0
    cp a, $E0
    jr nz, .read_digits
    ld c, $00
    ld a, $C3

.read_digits:
    ld [hl+], a
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, .read_digits2
    bit 0, c
    jr nz, .read_digits2
    ld a, $C3

.read_digits2:
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ret
    db $15, $12, $15, $0B, $10, $29, $0B, $16, $C3, $C3

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRules
DrawWorkBufSelectionTilesAndPanels_ReadLinkRules_Sub03::
Func_007_7C07:: ; address name
    ld a, [wLinkRules + $6]
    ld e, a
    ld a, [wLinkRules + $7]
    ld d, a
    ld hl, wScreenTileBuffer + $163
    xor a, a
    bit 6, e
    jr nz, .skip
    ld [hl], a

.skip:
    inc a
    inc hl
    bit 5, e
    jr nz, .skip2
    ld [hl], a

.skip2:
    inc a
    inc hl
    bit 4, e
    jr nz, .skip3
    ld [hl], a

.skip3:
    inc a
    inc hl
    bit 3, e
    jr nz, .skip4
    ld [hl], a

.skip4:
    inc a
    inc hl
    bit 2, e
    jr nz, .skip5
    ld [hl], a

.skip5:
    inc a
    inc hl
    bit 1, e
    jr nz, .skip6
    ld [hl], a

.skip6:
    inc a
    inc hl
    bit 0, e
    jr nz, .skip7
    ld [hl], a

.skip7:
    inc a
    inc hl
    bit 7, d
    jr nz, .skip8
    ld [hl], a

.skip8:
    inc a
    inc hl
    bit 6, d
    jr nz, .skip9
    ld [hl], a

.skip9:
    inc a
    inc hl
    bit 5, d
    jr nz, .skip10
    ld [hl], a

.skip10:
    inc a
    inc hl
    bit 4, d
    jr nz, .return
    ld [hl], a

.return:
    ret

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRuleTurnLimit, wDigits
DrawWorkBufSelectionTilesAndPanels_HLToDecimalDigits::
Func_007_7C5F:: ; address name
    ld a, [wLinkRuleTurnLimit]
    ld l, a
    res 7, l
    ld h, $00
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $46
    ld a, [wDigits + $1]
    or a, a
    jr z, .read_digits
    add a, $E0
    ld [hl], a

.read_digits:
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ret

; fills the screen buffer, plays a sound, sets the link state and send bytes
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkSession4ScreenState_ResetAndSignal::
Jump_007_7C7E:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD
    dw RunLinkSession4ScreenState_ResetAndSignal_QueueSoundEffect
    dw RunLinkSession4ScreenState_ResetAndSignal_Case02
    dw RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte
    dw RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04

; entry 0 of the `rst $00` table in RunLinkSession4ScreenState_ResetAndSignal
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wSubMenuCursor2, wMenuSelectedMember, wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD::
Jump_007_7C8C:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jp z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04
    ld d, $C3
    call FillScreenTileBufferWithD
    ld hl, $54DB
    call CopyRecordRectToScreenBuffer_Bank07
    call LoadInvertedBit7FlagsToWorkBuf
    call DrawWorkBufSelectionTilesAndPanels
    call DrawScreenBufferToBGMap0_Bank07
    ld a, $02
    ld [wSubMenuCursor2], a
    ld a, $00
    ld [wMenuSelectedMember], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkSession4ScreenState_ResetAndSignal
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wJoypadPressed, wMenuSelectedMember
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkSession4ScreenState_ResetAndSignal_QueueSoundEffect::
Jump_007_7CB7:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04
    ld hl, wMenuSelectedMember
    ld de, $50AA
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr nz, .set_link_send_byte_to_FE
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    ret z

.set_link_send_byte_to_FE:
    ld a, $FE
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunLinkSession4ScreenState_ResetAndSignal
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte
RunLinkSession4ScreenState_ResetAndSignal_Case02::
Jump_007_7CF8:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04
    cp a, $01
    ret nz
    ld a, $05
    ld [wLinkScreenState], a
    ld a, $01
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 3 of the `rst $00` table in RunLinkSession4ScreenState_ResetAndSignal
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte::
Jump_007_7D11:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 4 of the `rst $00` table in RunLinkSession4ScreenState_ResetAndSignal
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04::
Jump_007_7D24:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ret

RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04_CallLinkExchangeJoypadPerFrame::
Jump_007_7D38:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp a, $0C
    jr z, .check_screen_sub_step
    cp a, $0D
    jr z, .check_screen_step
    ld a, [wLinkSceneByte4B]
    or a, a
    ret z
    call RunLinkSession4ScreenState_ResetAndSignal_Case04_ComputeBreedingChild
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wMapType], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $21
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    ld a, $E0
    ldh [hPlayerX], a
    ld a, $00
    ldh [hPlayerY], a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $14
    ldh [hMapId], a
    xor a, a
    ldh [hPlayerStateFlags], a
    ld [wPartyCount], a
    xor a, a
    ld [wFieldReturnPhase], a
    ld a, [wSaveStateFlag]
    ld [wScriptByte65], a
    xor a, a
    ld [wSaveStateFlag], a
    xor a, a
    ld [wLinkMode], a
    ld [wLinkSceneByte4B], a
    ld [wScriptInDataBank], a
    ld [wMessageMode], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    cp a, $20
    jr z, .call_call_draw_party_species_sprites
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $15
    jr z, .call_draw_wca36_sprite_part_bank_f1
    cp a, $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_wca36_sprite_part_bank_f1:
    farcall DrawWCA36SpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret
    db $C9

; only called from RunLinkSession4ScreenState_ResetAndSignal_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_Case04)
; reads: wLinkRole, wItemGridX, wItemGridY, wArg5, wArg6, wArg7, wSaveStep
; writes: wArg1, wListCursor, wListPageIndex, wArg2, rRAMG2, rRAMB, wSaveStep, wSaveRecordIndex, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork, wScreenState
RunLinkSession4ScreenState_ResetAndSignal_Case04_ComputeBreedingChild::
Func_007_7DE5:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jp z, .clear_link_byte_eb
    ld a, $02
    ld [wArg1], a
    farcall ComputeBreedingChild
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

.clear_link_byte_eb:
    xor a, a
    ld [wLinkByteEB], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a

.loop3:
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop3
    ld hl, wScreenState
    ld bc, $006F

.loop4:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop4
    ret
    ds $16C, $00
