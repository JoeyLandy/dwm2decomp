SECTION "Bank 07", ROMX[$4000], BANK[$07]
    db $07

; ld de, this bank's string table / BeginStringDisplay
; 20 call sites from 20 routines (e.g. ShowString_Bank07, DebugMessageTest_Update_Case0E, ShowStringHL_Bank07, RunLinkScreenSubStateSubState_60E9_Case01, ...)
BeginStringDisplay_Bank07::
Func_007_4001:: ; address name
    ld de, $4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_007_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 11 call sites from 9 routines (e.g. PauseMenu_State3_Case06_Case00, GameMode5_Init_Case01, GameMode5_Init_Case04_Sub02, RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case00, ...)
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
; 1 call site from 1 routine (e.g. RunGameModeInit_Case05)
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
    dw GameMode5_Init_Case00
    dw GameMode5_Init_Case01
    dw GameMode5_Init_Case02
    dw GameMode5_Init_Case03
    dw GameMode5_Init_Case04
    dw GameMode5_Init_Case05
    dw GameMode5_Init_Case06
    dw GameMode5_Init_Case05

; entry 0 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wIsCGB
; writes: rBGP, rOBP0, rOBP1, hWindowX, hWindowY, hScrollX, hScrollY, wFrameCounterLo, ...
; points at: wSGBPaletteSet, wDMGPaletteBGP, wBGPaletteBuffer
GameMode5_Init_Case00::
Jump_007_48B2:: ; address name
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_48C8
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall LoadSGBObjectPalettesFromPointers
    jr Jump_007_48F3

Jump_007_48C8::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_48F3
    ld b, $40
    ld hl, wBGPaletteBuffer

Jump_007_48D3::
    ld a, $FF
    ld [hl+], a
    ld a, $7F
    ld [hl+], a
    dec b
    jr nz, Jump_007_48D3
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

Jump_007_48F3::
    ld b, $46
    ld de, Data_046_4001
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
    jp Jump_000_077A

; entry 1 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, sSavedLinkByte94, wIsCGB, hTemp0, wLinkScreenState
; writes: rRAMG, rRAMB, wLinkByte94, wMenuSaveByte34, wBattleKindFlags, wStringCategory, wStringIndex, rVBK, ...
; points at: wWorkBuf, wLinkRole, wSGBPaletteSet, hPlayerSpriteVariant, wPlayerName, wStoryFlags, wKeyWorldSlot, sRecords
GameMode5_Init_Case01::
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
    jr z, Jump_007_4985
    ld a, $02
    call LoadSGBBorderForSetA
    call SpinDelay
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket

Jump_007_4985::
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
    jr z, Jump_007_49B3
    cp a, $01
    jr z, Jump_007_49B3
    xor a, a

Jump_007_49B3::
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
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    ld hl, vTiles2
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld hl, vTiles2 + $700
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4A68
    ld a, $01
    ldh [rVBK], a
    ld d, $00
    call FillScreenTileBufferWithD
    call DrawScreenBufferToBGMap0_Bank07
    xor a, a
    ldh [rVBK], a

Jump_007_4A68::
    ld d, $C3
    call FillScreenTileBufferWithD
    call DrawScreenBufferToBGMap0_Bank07
    farcall CheckSaveData
    ldh a, [hTemp0]
    ld [wLinkScreenState], a
    or a, a
    jr z, Jump_007_4A9B
    ld hl, SaveCheckScreenRects
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, Jump_007_4A9B
    ld a, $02
    jr Jump_007_4A9D

Jump_007_4A9B::
    ld a, $09

Jump_007_4A9D::
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
    jp Jump_000_077A

; fills the 20 x 18 visible part of wScreenTileBuffer (32-byte rows) with D (E-0124)
; 5 call sites from 4 routines (e.g. GameMode5_Init_Case01, RunLinkScreenState_6C12_Case03_Case00, RunLinkScreenState_6C12_Case04_Case07, RunLinkScreenState_6C12_Case08_Case00)
; points at: wScreenTileBuffer
FillScreenTileBufferWithD::
Func_007_4AE4:: ; address name
    ld hl, wScreenTileBuffer
    ld bc, $1412
    ld a, d

Jump_007_4AEB::
    ld [hl+], a
    dec b
    jr nz, Jump_007_4AEB
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    ld b, $14
    dec c
    jr nz, Jump_007_4AEB
    ret

; the same effect as CopyRecordRectToScreenBuffer with the copy loop's instructions in a different order: HL = header (word offset, width, rows) followed by tile bytes, copied into wScreenTileBuffer + offset with rows 32 bytes apart (E-0071)
; 19 call sites from 19 routines (e.g. GameMode5_Init_Case04, GameMode5_Init_Case01, GameMode5_Update_Case01_Case08, GameMode5_Update_Case01_Case07, ...)
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

Jump_007_4B0C::
    push bc
    push hl

Jump_007_4B0E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_007_4B0E
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_007_4B0C
    ret

; copies the 20 x 18 entries of wScreenTileBuffer to vBGMap0 (rows 32 apart) with CopyRect32StrideToVRAM_Bank07 (E-0073)
; 12 call sites from 10 routines (e.g. GameMode5_Init_Case04, GameMode5_Init_Case01, RunLinkScreenState_6C12_Case05, RunLinkScreenSubStateSubState_60E9_Case00, ...)
; points at: wScreenTileBuffer
DrawScreenBufferToBGMap0_Bank07::
Func_007_4B1E:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

; the same instructions as CopyRect32StrideToVRAM_Bank16: B = width, C = rows, DE = source and HL = VRAM, both with rows 32 bytes apart; copies with WriteVRAMByteInc; B kept, C = 0 (E-0073)
; 10 call sites from 10 routines (e.g. GameMode5_Update_Case01_Case08, GameMode5_Update_Case01_Case07, GameMode5_Update_Case01_Case04, RunLinkScreenSubStateSubState_60E9_Case01, ...)
CopyRect32StrideToVRAM_Bank07::
Func_007_4B27:: ; address name
    push bc
    push de
    push hl

Jump_007_4B2A::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_007_4B2A
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
GameMode5_Init_Case02::
Jump_007_4B45:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_007_4B4B::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4B4B
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4B6F
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr Jump_007_4B7B

Jump_007_4B6F::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4B7B
    farcall LoadPalette0FromData4ACC

Jump_007_4B7B::
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, Jump_007_4B7B
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_007_4B95
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

Jump_007_4B95::
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Data_046_4001
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

Jump_007_4BC4::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_007_4BC4
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
    jp Jump_000_077A

; entry 3 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_Case03::
Jump_007_4C24:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_007_4C2A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4C2A
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4C4E
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr Jump_007_4C5A

Jump_007_4C4E::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4C5A
    farcall LoadPalette0FromData4ACC

Jump_007_4C5A::
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, Jump_007_4C5A
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_007_4C74
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

Jump_007_4C74::
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Data_046_4001
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

Jump_007_4CA3::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_007_4CA3
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
    jp Jump_000_077A

; entry 4 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wWorkBuf, hWindowX, hWindowY, hScrollY, hScrollX, wFrameCounterLo, ...
; points at: wSGBPaletteSet, wScreenTileBuffer, wMenuState, wLinkScreenState
GameMode5_Init_Case04::
Jump_007_4CFF:: ; address name
    call GameMode5_Init_Case04_Sub01
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4D1F
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr Jump_007_4D2B

Jump_007_4D1F::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4D2B
    farcall LoadPalette0FromData4ACC

Jump_007_4D2B::
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, Jump_007_4D2B
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_007_4D45
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

Jump_007_4D45::
    ld a, $FC
    call StartPaletteFade
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    ld hl, vTiles2 + $400
    ld de, $0B04
    call FillTilesRequest
    ld hl, $0300
    call GameMode5_Init_Case04_Sub02
    ld a, $00
    ld [wWorkBuf + $1], a
    farcall LoadAllFamilyIconTiles
    ld hl, vTiles2 + $B0
    ld de, $2501
    call FillTilesRequest
    ld hl, $0301
    call GameMode5_Init_Case04_Sub02
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
    jp Jump_000_077A

; only called from GameMode5_Init_Case04 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Init_Case04)
; reads: wLinkSetupMode
; points at: wLinkRules, wLinkRulesCopy
GameMode5_Init_Case04_Sub01::
Func_007_4DEC:: ; address name
    ld a, [wLinkSetupMode]
    cp a, $02
    jr z, Jump_007_4DF8
    ld hl, $4E07
    jr Jump_007_4DFB

Jump_007_4DF8::
    ld hl, wLinkRulesCopy

Jump_007_4DFB::
    ld de, wLinkRules
    ld b, $0A

Jump_007_4E00::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_007_4E00
    ret
    db $01, $00, $00, $63, $29, $01, $00, $00, $63, $80

; copies the 10 bytes at wD043 to wD04D (E-0122)
; 2 call sites from 2 routines (e.g. RunLinkScreenState_6C12_Case03_Case03, RunLinkScreenState_6C12_Case04_Case07)
; points at: wLinkRules, wLinkRulesCopy
CopyLinkRulesToLinkRulesCopy::
Func_007_4E11:: ; address name
    ld hl, wLinkRules
    ld de, wLinkRulesCopy
    ld b, $0A

Jump_007_4E19::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_007_4E19
    ret

; entry 5 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT, wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_Case05::
Jump_007_4E20:: ; address name
    ld hl, vTiles0
    ld bc, $0C00
    xor a, a

Jump_007_4E27::
    di

Jump_007_4E28::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_4E28
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4E27

; entry 6 of the `rst $00` table in GameMode5_Init
; no direct call (reached through a table, a jump or a vector)
; reads: wSGBActive, wSaveStep, wMapType, wTextWindowState, wIsCGB
; writes: wSaveStep, wSaveRecordIndex, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, hWindowX, hWindowY, hScrollY, ...
; points at: wScreenState, wSGBPaletteSet, wMenuState, wLinkScreenState
GameMode5_Init_Case06::
Jump_007_4E37:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_007_4E3D::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_4E3D
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_4E5F
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr Jump_007_4E6B

Jump_007_4E5F::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_4E6B
    farcall LoadPalette0FromData4ACC

Jump_007_4E6B::
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, Jump_007_4E6B
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_007_4E85
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

Jump_007_4E85::
    ld hl, vBGMap0
    ld bc, $1412

Jump_007_4E8B::
    ld a, $C3

Jump_007_4E8D::
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_007_4E8D
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $14
    dec c
    jr nz, Jump_007_4E8B
    call GameMode5_Init_Case06_Sub01
    farcall FullyHealParty
    ld a, $FC
    call StartPaletteFade
    ld b, $46
    ld de, Data_046_4001
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

Jump_007_4ED6::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_007_4ED6
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
    jp Jump_000_077A

; only called from GameMode5_Init_Case06 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Init_Case06)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
GameMode5_Init_Case06_Sub01::
Func_007_4F29:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

Jump_007_4F38::
    push hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, Jump_007_4F38
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
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case05)
; reads: wModeState
GameMode5_Update::
Func_007_4F7B:: ; address name
    ld a, [wModeState]
    rst $00
    dw GameMode5_Update_Case00
    dw GameMode5_Update_Case01
    dw GameMode5_Update_Case02
    dw GameMode5_Update_Case03
    dw GameMode5_Update_Case04
    dw GameMode5_Update_Case05
    dw GameMode5_Update_Case05
    dw GameMode5_Update_Case07

; entry 5 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
GameMode5_Update_Case05::
Jump_007_4F8F:: ; address name
    farcall GameMode5_Update_Case05_Sub01
    ret

; entry 7 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
GameMode5_Update_Case07::
Jump_007_4F96:: ; address name
    farcall GameMode5_Update_Case07_Sub01
    ret

; blinks the cursor of the list entry [HL] every 8 frames; up/down moves it (wrapping over wC46F entries) with sound $69 (E-0127)
; 6 call sites from 6 routines (e.g. GameMode5_Update_Case01_Case01, RunLinkScreenState_6C12_Case01, RunLinkScreenSubStateSubState_60E9_Case01, RunLinkScreenState_6C12_Case03_Case17, ...)
; reads: wFrameCounterLo, wSubMenuCursor, wJoypadPressedRepeat
; writes: wFrameCounterLo
MoveVerticalCursorInListHL::
Func_007_4F9D:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, Jump_007_4FB3
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, Jump_007_4FB0
    call EraseCursorAtEntryHL_Bank07
    jr Jump_007_4FB3

Jump_007_4FB0::
    call WriteBBTileAtWordTableEntryC_Bank07

Jump_007_4FB3::
    ld a, [wSubMenuCursor]
    cp a, $01
    jr z, Jump_007_4FE4
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_007_4FD0
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, Jump_007_4FE5
    ld a, [wSubMenuCursor]
    dec a
    ld [hl], a
    jr Jump_007_4FE5

Jump_007_4FD0::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_007_4FE4
    ld a, [wSubMenuCursor]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, Jump_007_4FE5
    xor a, a
    ld [hl], a
    jr Jump_007_4FE5

Jump_007_4FE4::
    ret

Jump_007_4FE5::
    xor a, a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    ld a, $69
    call QueueSoundEffect
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; only called from routines of RunLinkScreenState_6C12 (E-0098)
; 15 call sites from 15 routines (e.g. RunLinkScreenState_6C12_Case03_Case1E, RunLinkScreenState_6C12_Case03_Case1B, RunLinkScreenState_6C12_Case03_Case18, RunLinkScreenState_6C12_Case03_Case15, ...)
; reads: wFrameCounterLo, wJoypadPressedRepeat, wSubMenuCursor2
; writes: wFrameCounterLo
RunLinkScreenState_6C12_Shared01::
Func_007_4FF5:: ; address name
    ld a, [wFrameCounterLo]
    and a, $07
    jr nz, Jump_007_500B
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, Jump_007_5008
    call EraseCursorAtEntryHL_Bank07
    jr Jump_007_500B

Jump_007_5008::
    call WriteBBTileAtWordTableEntryC_Bank07

Jump_007_500B::
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_5021
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, Jump_007_5036
    ld a, [wSubMenuCursor2]
    dec a
    ld [hl], a
    jr Jump_007_5036

Jump_007_5021::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_007_5035
    ld a, [wSubMenuCursor2]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, Jump_007_5036
    xor a, a
    ld [hl], a
    jr Jump_007_5036

Jump_007_5035::
    ret

Jump_007_5036::
    xor a, a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    ld a, $69
    call QueueSoundEffect
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; C = [HL]; writes the cursor tile $BB at the VRAM address in entry C of the word table at DE, waiting for VRAM access (E-0124)
; 6 call sites from 3 routines (e.g. MoveVerticalCursorInListHL, RunLinkScreenState_6C12_Shared01, RunLinkScreenState_6C12_Case03_Case1A_Sub02)
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

Jump_007_5056::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_5056

Jump_007_505C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_505C
    pop af
    ld [hl], a
    pop hl
    ret

; C = [HL], then falls into WriteC3TileAtWordTableEntryC_Bank07 (E-0126)
; 5 call sites from 5 routines (e.g. GameMode5_Update_Case01_Case08, MoveVerticalCursorInListHL, RunLinkScreenSubStateSubState_60E9_Case01, RunLinkScreenState_6C12_Shared01, ...)
; reads: rSTAT
EraseCursorAtEntryHL_Bank07::
Func_007_5066:: ; address name
    ld c, [hl]

; writes the blank tile $C3 at the VRAM address in entry C of the word table at DE, waiting for VRAM access (E-0124)
; 3 call sites from 3 routines (e.g. MoveVerticalCursorInListHL, RunLinkScreenState_6C12_Shared01, RunLinkScreenState_6C12_Case03_Case1A_Sub02)
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

Jump_007_5076::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_5076

Jump_007_507C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_007_507C
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
; 10 call sites from 10 routines (e.g. RunLinkScreenSubStateSubState_60E9_Case01, RunLinkScreenState_6C12_Case03_Case14, RunLinkScreenState_6C12_Case03_Case13, RunLinkScreenState_6C12_Case03_Case12, ...)
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

Jump_007_5115::
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_007_5115
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, $C3
    ld b, $14
    dec c
    jr nz, Jump_007_5115
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank07 (E-0114)
; 4 call sites from 4 routines (e.g. RunLinkScreenState_6C12_Case02_Case04, RunLinkScreenState_6C12_Case03_Case08, RunLinkScreenState_6C12_Case04_Case03, RunLinkScreenState_6C12_Case04_Case01)
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
; 2 call sites from 1 routine (e.g. GameMode5_Init_Case04)
; writes: wStringCategory, wStringIndex
GameMode5_Init_Case04_Sub02::
Func_007_513A:: ; address name
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ret

; E-0220 (C1: after CheckSaveData, Jump_007_4A68 reads the word at $5149 + 2 * hTemp0 (hTemp0 >= 1) and passes it to CopyRecordRectToScreenBuffer_Bank07; three words, so index 3 would read the offset word ($0000) of TileRect_07_514F, which follows; entry 0 is not read on that path).
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
    dw $0000 ; entry 0
    db $0C, $0F
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $00, $01, $02, $03, $04, $05, $06, $07, $08, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $70, $71, $72, $73, $74, $75, $76, $77, $78, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 12 x 17 tiles
TileRect_07_5207::
Data_007_5207:: ; address name
    dw $0000 ; entry 0
    db $0C, $11
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $00, $01, $02, $03, $04, $05, $06, $07, $08, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $70, $71, $72, $73, $74, $75, $76, $77, $78, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0220 (C1: a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer format: offset, width, rows, tiles).
; record: offset $0000; 12 x 3 tiles
TileRect_07_52D7::
Data_007_52D7:: ; address name
    dw $0000 ; entry 0
    db $0C, $03
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0220 (C1: a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer format: offset, width, rows, tiles).
; record: offset $01A0; 20 x 5 tiles
TileRect_07_52FF::
Data_007_52FF:: ; address name
    dw $01A0 ; entry 0
    db $14, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0060 (row 3, column 0); 20 x 11 tiles
TileRect_07_5367::
Data_007_5367:: ; address name
    dw $0060 ; entry 0
    db $14, $0B
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $68, $69, $6A, $6B, $6C, $6D, $ED, $40, $41, $42, $43, $44, $C3, $C3, $C3, $ED, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $45, $46, $47, $48, $49, $4A, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $57, $58, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $59, $5A, $C3, $C3, $B7
    db $B6, $4B, $4C, $4D, $4E, $4F, $50, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $51, $52, $53, $54, $55, $56, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0082 (row 4, column 2); 16 x 9 tiles
TileRect_07_5447::
Data_007_5447:: ; address name
    dw $0082 ; entry 0
    db $10, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $61, $62, $63, $64, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0020 (row 1, column 0); 20 x 16 tiles
TileRect_07_54DB::
Data_007_54DB:: ; address name
    dw $0020 ; entry 0
    db $14, $10
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $0C, $0B, $15, $15, $10, $0D, $C3, $14, $15, $0B, $13, $15, $C3, $0D, $16, $0F, $15, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $14, $1E, $1D, $1F, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $17, $C3, $C3, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $10, $1A, $25, $1A, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $17, $C3, $C3, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $0E, $18, $20, $1D, $1F, $27, $10, $1D, $20, $1D, $23, $C3, $C3, $17, $C3, $C3, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C3, $17, $C3, $C3, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $0D, $26, $19, $1C, $18, $21, $1B, $1A, $C3, $C3, $C3, $C3, $C3, $17, $C3, $C3, $11, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0000 (row 0, column 0); 20 x 18 tiles
TileRect_07_561F::
Data_007_561F:: ; address name
    dw $0000 ; entry 0
    db $14, $12
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $C3, $14, $28, $0F, $10, $10, $C3, $10, $0F, $29, $0F, $15, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $10, $0F, $29, $0F, $15, $C3, $B7
    db $B6, $C3, $0B, $23, $1E, $C3, $29, $18, $1B, $1D, $19, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $14, $24, $2B, $2B, $2C, $22, $23, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $13, $1A, $19, $2C, $25, $1A, $22, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $0C, $22, $1A, $18, $23, $1C, $C3, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $2A, $18, $21, $19, $1A, $C3, $C3, $C3, $C3, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $0B, $23, $1E, $C3, $14, $1E, $1D, $1F, $1F, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $29, $1A, $1B, $18, $20, $18, $1B, $1D, $19, $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $00E0 (row 7, column 0); 20 x 5 tiles
TileRect_07_578B::
Data_007_578B:: ; address name
    dw $00E0 ; entry 0
    db $14, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $15, $2C, $23, $18, $1F, $C3, $10, $1A, $25, $1A, $1F, $2D, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $29, $18, $26, $C3, $10, $1A, $25, $1A, $1F, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0062 (row 3, column 2); 15 x 11 tiles
TileRect_07_57F3::
Data_007_57F3:: ; address name
    dw $0062 ; entry 0
    db $0F, $0B
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $0B, $25, $18, $1D, $1F, $1D, $2E, $1F, $1A, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $0E, $18, $20, $1D, $1F, $1D, $1A, $2D, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $00, $C3, $01, $C3, $02, $C3, $03, $C3, $04, $C3, $05, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $06, $C3, $07, $C3, $08, $C3, $09, $C3, $0A, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $00E1 (row 7, column 1); 18 x 5 tiles
TileRect_07_589C::
Data_007_589C:: ; address name
    dw $00E1 ; entry 0
    db $12, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C5, $C3, $C3, $C6, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $DE, $67, $1F, $33, $3C, $12, $00, $00

; entry 0 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenState
GameMode5_Update_Case00::
Jump_007_5902:: ; address name
    ld a, [wLinkScreenState]
    rst $00
    dw GameMode5_Update_Case00_Case00
    dw GameMode5_Update_Case00_Case01
    dw GameMode5_Update_Case00_Case02
    dw GameMode5_Update_Case00_Case03
    dw GameMode5_Update_Case00_Case04

; entry 0 of the `rst $00` table in GameMode5_Update_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_Case00_Case00::
Jump_007_5910:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_Case00_Case00_Case00
    dw GameMode5_Update_Case00_Case00_Case00
    dw GameMode5_Update_Case00_Case00_Case02

; entry 0 of the `rst $00` table in GameMode5_Update_Case00_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wIsCGB
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
GameMode5_Update_Case00_Case00_Case00::
Jump_007_591A:: ; address name
    ld a, [wLinkScreenSubState]
    or a, a
    jr z, Jump_007_596A
    ld b, $E1
    ld de, Data_0E1_4001
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_40D6
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_595C
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_40FB
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_410E
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_595C::
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade

Jump_007_596A::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_Case00_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wJoypadPressed
; writes: wWorkBuf, wLinkScreenSubState
; points at: wLinkScreenState
GameMode5_Update_Case00_Case00_Case02::
Jump_007_5976:: ; address name
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp a, $3C
    jr c, Jump_007_5993
    xor a, a
    ld [wWorkBuf], a
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    cp a, $03
    jr nc, Jump_007_59A8
    cp a, $02
    ret c

Jump_007_5993::
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

Jump_007_59A8::
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_Case00_Case01::
Jump_007_59B6:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_Case00_Case01_Case00
    dw GameMode5_Update_Case00_Case01_Case00
    dw GameMode5_Update_Case00_Case01_Case02

; entry 0 of the `rst $00` table in GameMode5_Update_Case00_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wIsCGB
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
GameMode5_Update_Case00_Case01_Case00::
Jump_007_59C0:: ; address name
    ld a, [wLinkScreenSubState]
    or a, a
    jr z, Jump_007_5A10
    ld b, $E1
    ld de, Data_0E1_4116
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_45A7
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5A02
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_45FC
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_460F
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5A02::
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade

Jump_007_5A10::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_Case00_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wJoypadPressed
; writes: wWorkBuf, wLinkScreenSubState
; points at: wLinkScreenState
GameMode5_Update_Case00_Case01_Case02::
Jump_007_5A1C:: ; address name
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp a, $3C
    jr c, Jump_007_5A39
    xor a, a
    ld [wWorkBuf], a
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    cp a, $03
    jr nc, Jump_007_5A4E
    cp a, $02
    ret c

Jump_007_5A39::
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

Jump_007_5A4E::
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_Case00_Case02::
Jump_007_5A5C:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_Case00_Case02_Case00
    dw GameMode5_Update_Case00_Case02_Case00
    dw GameMode5_Update_Case00_Case02_Case02

; entry 0 of the `rst $00` table in GameMode5_Update_Case00_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wIsCGB
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
GameMode5_Update_Case00_Case02_Case00::
Jump_007_5A66:: ; address name
    ld a, [wLinkScreenSubState]
    or a, a
    jr z, Jump_007_5AB6
    ld b, $E1
    ld de, Data_0E1_4617
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_4946
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5AA8
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_49BE
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_49D2
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5AA8::
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade

Jump_007_5AB6::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_Case00_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wJoypadPressed
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenState
; points at: wLinkScreenState
GameMode5_Update_Case00_Case02_Case02::
Jump_007_5AC2:: ; address name
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp a, $5A
    jr nc, Jump_007_5AE9
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

Jump_007_5AE9::
    xor a, a
    ld [wWorkBuf], a
    ld hl, wLinkScreenState
    inc [hl]
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; entry 3 of the `rst $00` table in GameMode5_Update_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wLinkScreenSubState
; writes: wLinkScreenState, wLinkScreenSubState
GameMode5_Update_Case00_Case03::
Jump_007_5AFB:: ; address name
    ld a, [wJoypadPressed]
    and a, $0B
    jr z, RunLinkScreenSubStateSubState_5B14
    call RunLinkScreenSubStateSubState_5B14
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; runs the routine for wD06B (jump table of nine sub-states) (E-0122)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case00_Case03)
; reads: wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14::
Func_007_5B14:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenSubStateSubState_5B14_Case00
    dw RunLinkScreenSubStateSubState_5B14_Case01
    dw RunLinkScreenSubStateSubState_5B14_Case02
    dw RunLinkScreenSubStateSubState_5B14_Case03
    dw RunLinkScreenSubStateSubState_5B14_Case04
    dw RunLinkScreenSubStateSubState_5B14_Case05
    dw RunLinkScreenSubStateSubState_5B14_Case06
    dw RunLinkScreenSubStateSubState_5B14_Case07
    dw RunLinkScreenSubStateSubState_5B14_Case08

; entry 0 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB
; writes: rVBK, wWorkBuf, wLinkMenuCounter
; points at: wBGPaletteBuffer, wOBJPaletteBuffer, wWorkBuf, wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case00::
Jump_007_5B2A:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $7E
    ld de, Data_07E_4CED
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7E
    ld de, Data_07E_5706
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $10
    ld hl, vTiles2

Jump_007_5B4A::
    di
    ld a, $FF
    call WriteVRAMByteInc
    ei
    dec b
    jr nz, Jump_007_5B4A
    ld hl, vBGMap0
    ld bc, $0400

Jump_007_5B5A::
    di
    ld a, $00
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_5B5A
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5BAA
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400

Jump_007_5B76::
    di
    ld a, $FF
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_5B76
    ld a, $00
    ldh [rVBK], a
    xor a, a
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    call FillBytes
    ld b, $7E
    ld de, ObjPalettes_7E_4BBD
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4CAD
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5BAA::
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
    call RunLinkScreenSubStateSubState_5B14_Shared02
    call ResetLinkScreenPalettes
    ld a, $FC
    call StartPaletteFade
    ld a, $DD
    call QueueSoundEffect
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkMenuCounter, wLinkMenuEntry
; writes: wLinkMenuEntry, wLinkMenuCounter
; points at: wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case01::
Jump_007_5BDC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunLinkScreenSubStateSubState_5B14_Shared01
    ld a, [wLinkMenuEntry]
    inc a
    ld [wLinkMenuEntry], a
    and a, $07
    ret nz
    ld a, [wLinkMenuCounter]
    ld hl, $5EE3
    call ReadWordTableEntry_Bank00
    call RunLinkScreenSubStateSubState_5B14_Shared02
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

; entry 2 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wLinkMenuCounter
; writes: wWorkBuf
; points at: wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case02::
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
    call RunLinkScreenSubStateSubState_5B14_Shared01
    ld a, [wWorkBuf + $1]
    cp a, $50
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMenuCounter, wLinkMenuEntry
; writes: wLinkMenuEntry
; points at: wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case03::
Jump_007_5C40:: ; address name
    call DrawMetaSprite0AtX50YWD09E
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunLinkScreenSubStateSubState_5B14_Shared01
    ld a, [wLinkMenuEntry]
    dec a
    ld [wLinkMenuEntry], a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

; entry 4 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMenuCounter, wFadeState, wIsCGB, wWorkBuf, wLinkScreenSubState
; writes: rSVBK, wWorkBuf
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case04::
Jump_007_5C5F:: ; address name
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    ld a, [wFadeState]
    or a, a
    jp nz, RunLinkScreenSubStateSubState_5B14_Shared01
    ld b, $E1
    ld de, Data_0E1_5405
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_590F
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5CA9
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_5974
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_5A67
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_007_5CA9::
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

; entry 5 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wWorkBuf
; writes: wWorkBuf
; points at: wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case05::
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

; entry 6 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB
; writes: rVBK, wLinkMenuCounter, wWorkBuf, rSCY
; points at: wBGPaletteBuffer, wWorkBuf, wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case06::
Jump_007_5CD8:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $E1
    ld de, Data_0E1_49DA
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_4E67
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_5987
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5D24
    ld a, $01
    ldh [rVBK], a
    ld b, $E1
    ld de, Data_0E1_59F7
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, $00
    ldh [rVBK], a
    ld b, $E1
    ld de, Data_0E1_5A27
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM

Jump_007_5D24::
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
    call RunLinkScreenSubStateSubState_5B14_Shared02
    call SetScrollYFromWD09E
    ldh [rSCY], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkMenuCounter, wLinkMenuEntry, wWorkBuf
; writes: wLinkMenuEntry, wLinkMenuCounter, wWorkBuf
; points at: wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Case07::
Jump_007_5D56:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunLinkScreenSubStateSubState_5B14_Shared01
    ld a, [wLinkMenuCounter]
    cp a, $0A
    jr nc, Jump_007_5D8B
    ld a, [wLinkMenuEntry]
    inc a
    ld [wLinkMenuEntry], a
    and a, $07
    jr nz, Jump_007_5D8B
    ld a, [wLinkMenuCounter]
    ld hl, $5EE3
    call ReadWordTableEntry_Bank00
    call RunLinkScreenSubStateSubState_5B14_Shared02
    ld a, [wLinkMenuCounter]
    inc a
    ld [wLinkMenuCounter], a
    ret

Jump_007_5D8B::
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

; entry 8 of the `rst $00` table in RunLinkScreenSubStateSubState_5B14
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMenuCounter, wWorkBuf
; writes: wWorkBuf, wLinkScreenSubState
; points at: wLinkScreenState
RunLinkScreenSubStateSubState_5B14_Case08::
Jump_007_5DB6:: ; address name
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunLinkScreenSubStateSubState_5B14_Shared01
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
; 2 call sites from 2 routines (e.g. RunLinkScreenSubStateSubState_5B14_Case03, RunLinkScreenSubStateSubState_5B14_Case02)
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
; 2 call sites from 2 routines (e.g. RunLinkScreenSubStateSubState_5B14_Case07, RunLinkScreenSubStateSubState_5B14_Case06)
; reads: wWorkBuf
; writes: hScrollY
SetScrollYFromWD09E::
Func_007_5DEF:: ; address name
    ld a, [wWorkBuf + $1]
    ldh [hScrollY], a
    ret

; only called from routines of RunLinkScreenSubStateSubState_5B14 (E-0098)
; 5 call sites from 5 routines (e.g. RunLinkScreenSubStateSubState_5B14_Case08, RunLinkScreenSubStateSubState_5B14_Case07, RunLinkScreenSubStateSubState_5B14_Case03, RunLinkScreenSubStateSubState_5B14_Case02, ...)
; reads: wWorkBuf, wLinkScreenSubState
RunLinkScreenSubStateSubState_5B14_Shared01::
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
    jr nz, Jump_007_5E11
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
    jr Jump_007_5E56

Jump_007_5E11::
    dec a
    jr nz, Jump_007_5E22
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
    jr Jump_007_5E56

Jump_007_5E22::
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
    jr nz, Jump_007_5E56
    ld a, [wLinkScreenSubState]
    cp a, $08
    jr nc, Jump_007_5E47
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
    jr Jump_007_5E56

Jump_007_5E47::
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

Jump_007_5E56::
    push hl
    call z, RunLinkScreenSubStateSubState_5B14_Shared02
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
    jr nc, Jump_007_5E6B
    inc d

Jump_007_5E6B::
    ld a, [de]
    pop de
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_007_5E77
    ld a, [hl]
    inc a
    ld [hl-], a
    xor a, a
    ld [hl+], a

Jump_007_5E77::
    call RunLinkScreenSubStateSubState_5B14_Shared01_Sub01
    pop bc
    dec b
    jp nz, RunLinkScreenSubStateSubState_5B14_Shared01
    ret

; only called from RunLinkScreenSubStateSubState_5B14_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkScreenSubStateSubState_5B14_Shared01)
; writes: hSpriteSubIndex, hSpriteOriginX, hSpriteOriginY, hSpriteSetIndex, hSpriteTileOffset, hSpriteAttrXor
RunLinkScreenSubStateSubState_5B14_Shared01_Sub01::
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

; only called from routines of RunLinkScreenSubStateSubState_5B14 (E-0098)
; 5 call sites from 5 routines (e.g. RunLinkScreenSubStateSubState_5B14_Shared01, RunLinkScreenSubStateSubState_5B14_Case07, RunLinkScreenSubStateSubState_5B14_Case06, RunLinkScreenSubStateSubState_5B14_Case01, ...)
; reads: wLinkScreenSubState, wWorkBuf
RunLinkScreenSubStateSubState_5B14_Shared02::
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
    jr nc, Jump_007_5EBE
    ld a, [wWorkBuf + $1]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ret

Jump_007_5EBE::
    cp a, $05
    jr nc, Jump_007_5ED7
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

Jump_007_5ED7::
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

; entry 4 of the `rst $00` table in GameMode5_Update_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_Case00_Case04::
Jump_007_5EFF:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_Case00_Case04_Case00
    dw GameMode5_Update_Case00_Case04_Case01
    dw GameMode5_Update_Case00_Case04_Case02

; entry 0 of the `rst $00` table in GameMode5_Update_Case00_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB
; writes: rSVBK, wWorkBuf, hScrollY
; points at: wScreenTileBuffer, wScreenAttrBuffer, wBGPaletteBuffer, wOBJPaletteBuffer, wLinkScreenSubState
GameMode5_Update_Case00_Case04_Case00::
Jump_007_5F09:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld b, $E1
    ld de, Data_0E1_577C
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_49DA
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_4E67
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $E1
    ld de, Data_0E1_582B
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_007_5F6D
    ld a, $02
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_58C3
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $E1
    ld de, Data_0E1_5A27
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $E1
    ld de, Data_0E1_5AA7
    ld hl, wOBJPaletteBuffer
    ld c, $10
    call CopyFromBankWaitVRAM

Jump_007_5F6D::
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

; entry 1 of the `rst $00` table in GameMode5_Update_Case00_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wWorkBuf
; points at: wLinkScreenSubState
GameMode5_Update_Case00_Case04_Case01::
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

; entry 2 of the `rst $00` table in GameMode5_Update_Case00_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSoundChannel2, wWorkBuf
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenState, wModeState, wGameMode2State, wGameMode2Arg
; points at: wSoundChannel3, wSoundChannel4, wSoundChannel5, wModeChangeRequest
GameMode5_Update_Case00_Case04_Case02::
Jump_007_5F9D:: ; address name
    ld a, [wJoypadPressed]
    and a, $0B
    jr nz, Jump_007_5FCF
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
    jr z, Jump_007_5FC0
    ret

Jump_007_5FC0::
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $02
    ld [wLinkScreenState], a
    ret

Jump_007_5FCF::
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
; 7 call sites from 7 routines (e.g. GameMode5_Update_Case00_Case00_Case00, GameMode5_Update_Case00_Case01_Case00, GameMode5_Update_Case00_Case02_Case00, RunLinkScreenSubStateSubState_5B14_Case06, ...)
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
    jr z, Jump_007_608F
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

Jump_007_608F::
    ret

; entry 1 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkScreenState
; writes: wScreenStep
GameMode5_Update_Case01::
Jump_007_6090:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, $02
    ld [wScreenStep], a
    ld a, [wLinkScreenState]
    rst $00
    dw GameMode5_Update_Case01_Case00
    dw GameMode5_Update_Case01_Case01
    dw GameMode5_Update_Case01_Case02
    dw GameMode5_Update_Case01_Case03
    dw GameMode5_Update_Case01_Case04
    dw GameMode5_Update_Case01_Case05
    dw GameMode5_Update_Case01_Case06
    dw GameMode5_Update_Case01_Case07
    dw GameMode5_Update_Case01_Case08

; entry 0 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenStep, wModeChangeRequest, wLinkStatus
; writes: wLinkScreenStep, wGridCursorX, wLinkTimerLo
GameMode5_Update_Case01_Case00::
Jump_007_60B0:: ; address name
    call RunLinkScreenSubStateSubState_60E9
    ld a, [wLinkScreenStep]
    or a, a
    jr z, Jump_007_60E8
    ld a, [wLinkScreenStep]
    ld b, a
    xor a, a
    ld [wLinkScreenStep], a
    ld a, [wModeChangeRequest]
    or a, a
    jr nz, Jump_007_60E8
    ld a, $0F
    ld [wGridCursorX], a
    ld a, b
    ld [wLinkTimerLo], a
    call StartSerialTransferInternalClock
    ld a, $01
    ld [wGridCursorX], a

Jump_007_60D8::
    ld a, [wLinkStatus]
    and a, $03
    cp a, $03
    jr nz, Jump_007_60D8
    ld a, [wModeChangeRequest]
    and a, a
    jr nz, Jump_007_60E7

Jump_007_60E7::
    ret

Jump_007_60E8::
    ret

; runs the routine for wD06B (jump table of three sub-states) (E-0122)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case01_Case00)
; reads: wLinkScreenSubState
RunLinkScreenSubStateSubState_60E9::
Func_007_60E9:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenSubStateSubState_60E9_Case00
    dw RunLinkScreenSubStateSubState_60E9_Case01
    dw RunLinkScreenSubStateSubState_60E9_Case02

; entry 0 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkByte94, wMenuState
; writes: wScreenStep, wScreenSubStep, wSubMenuCursor, wSubMenuCursor2, wMenuOption, wLinkScreenStep, wLinkTimerLo
; points at: wScreenTileBuffer, wLinkScreenSubState
RunLinkScreenSubStateSubState_60E9_Case00::
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
    jr z, Jump_007_611B
    ld hl, $5207

Jump_007_611B::
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld a, [wLinkByte94]
    and a, $01
    ld a, $07
    jr z, Jump_007_612C
    ld a, $08

Jump_007_612C::
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

; entry 1 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wTextFlags, wJoypadPressed, wSGBActive, wMenuState, wMenuOption
; writes: wScreenStep, wScreenSubStep, wStringCategory, wStringIndex, wLinkScreenState, wLinkScreenFlag, wMenuOption
; points at: wLinkScreenSubState, wMenuState
RunLinkScreenSubStateSubState_60E9_Case01::
Jump_007_6145:: ; address name
    ld a, [wFadeState]
    and a, a
    jr z, Jump_007_615D
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

Jump_007_615D::
    ld a, [wTextFlags]
    bit 0, a
    jr z, Jump_007_6176
    xor a, a
    ld [wScreenStep], a
    ld a, $F4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

Jump_007_6176::
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_007_6182
    call SendLinkByteForMenuOption
    jr Jump_007_6187

Jump_007_6182::
    ld a, $C0
    call SerialSendByte

Jump_007_6187::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_007_61F8
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_61CE
    ld a, [wMenuState]
    and a, $0F
    cp a, $02
    jr c, Jump_007_61CE
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
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

Jump_007_61CE::
    ld a, [wMenuState]
    and a, $0F
    ld b, $02
    ld c, $08
    cp a, c
    jr nc, Jump_007_61DC
    cp a, b
    ccf

Jump_007_61DC::
    jr c, Jump_007_61EE
    ld a, [wMenuState]
    ld hl, CursorPositionWords_07_5086
    and a, $07
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $69
    call QueueSoundEffect

Jump_007_61EE::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    jr Jump_007_6212

Jump_007_61F8::
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

Jump_007_6212::
    ret

; wD781 = 0, sends the byte at $65BD + (wC471 & $0F) through SerialSendByte (stored in wD782), then wD781 = 1 (E-0122)
; 1 call site from 1 routine (e.g. RunLinkScreenSubStateSubState_60E9_Case01)
; reads: wMenuOption
; writes: wScreenStep, wScreenSubStep
SendLinkByteForMenuOption::
Func_007_6213:: ; address name
    ld a, [wMenuOption]
    ld de, $65BD
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_007_6220
    inc d

Jump_007_6220::
    xor a, a
    ld [wScreenStep], a
    ld a, [de]
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuState
RunLinkScreenSubStateSubState_60E9_Case02::
Jump_007_6231:: ; address name
    ld a, [wMenuState]
    and a, $0F
    rst $00
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case00
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case01
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case02
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case03
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case04
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case05
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case06
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case07

; entry 0 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenFlag
; writes: wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case00::
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
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case00
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case01
    dw RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case02

; entry 0 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenTileBuffer
; points at: wLinkScreenFlag
RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case00::
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
    ld [wStringIndex], a
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
    call RunLinkScreenSubStateSubState_60E9_Shared01
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wSaveStep, wSaveRecordIndex, wLinkScreenFlag, wLinkScreenSubState
; points at: wLinkScreenFlag, wScreenTileBuffer
RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case01::
Jump_007_62BA:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_62CE
    ld hl, wLinkScreenFlag
    inc [hl]
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    jr Jump_007_62E9

Jump_007_62CE::
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_62E9
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    xor a, a
    ld [wLinkScreenFlag], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_62E9::
    call RunLinkScreenSubStateSubState_60E9_Shared01
    ret

; entry 2 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep, wMapType, wKeyWorldWidth, wKeyWorldHeight, hPlayerFacing, hPlayerX, hPlayerY
; writes: wMapWidthScreens, wMapHeightScreens, wFieldReturnPhase, wTalkCountdown, wEncounterDelay, wFollowerRecords, wLinkScreenState
RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case02::
Jump_007_62ED:: ; address name
    call RunLinkScreenSubStateSubState_60E9_Shared01
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_007_6319
    cp a, $80
    jr nz, Jump_007_6319
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a

Jump_007_6319::
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

; only called from routines of RunLinkScreenSubStateSubState_60E9 (E-0098)
; 3 call sites from 3 routines (e.g. RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case02, RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case01, RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case00)
; reads: wBattlerRecords, wTitleByte0A
; writes: rRAMG, rRAMB, hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, ...
RunLinkScreenSubStateSubState_60E9_Shared01::
Func_007_635A:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wBattlerRecords]
    or a, a
    jr z, Jump_007_639C
    ld a, [wTitleByte0A]
    or a, a
    jr z, Jump_007_639C
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

Jump_007_639C::
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ret

; entry 1 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
RunLinkScreenSubStateSubState_60E9_Case02_Case01::
Jump_007_63A5:: ; address name
    call ClearScreenStateBlock
    call InitLinkScreenStateBlock
    ret

; clears the $80 bytes from wD780 (E-0122)
; 3 call sites from 3 routines (e.g. GameMode5_Update_Case01_Case03, RunLinkScreenSubStateSubState_60E9_Case02_Case01, RunLinkScreenSubStateSubState_60E9_Case02_Case00_Case02)
; points at: wScreenState
ClearScreenStateBlock::
Func_007_63AC:: ; address name
    ld hl, wScreenState
    ld b, $80

Jump_007_63B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_63B1
    ret

; entry 2 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case02::
Jump_007_63B7:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, Jump_007_63CD
    cp a, $FE
    jr z, Jump_007_63E7
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $F5
    ld [wLinkScreenStep], a
    ret

Jump_007_63CD::
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

Jump_007_63E7::
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
; 6 call sites from 6 routines (e.g. RunLinkScreenSubStateSubState_60E9_Case02_Case07, RunLinkScreenSubStateSubState_60E9_Case02_Case06, RunLinkScreenSubStateSubState_60E9_Case02_Case05, RunLinkScreenSubStateSubState_60E9_Case02_Case04, ...)
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

; entry 3 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case03::
Jump_007_641C:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, Jump_007_6432
    cp a, $FE
    jr z, Jump_007_644C
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $F6
    ld [wLinkScreenStep], a
    ret

Jump_007_6432::
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

Jump_007_644C::
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

; entry 4 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case04::
Jump_007_646B:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, Jump_007_6481
    cp a, $FE
    jr z, Jump_007_649B
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $B7
    ld [wLinkScreenStep], a
    ret

Jump_007_6481::
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

Jump_007_649B::
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

; entry 6 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case06::
Jump_007_64BA:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, Jump_007_64D0
    cp a, $FE
    jr z, Jump_007_64EA
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $E0
    ld [wLinkScreenStep], a
    ret

Jump_007_64D0::
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

Jump_007_64EA::
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

; entry 7 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case07::
Jump_007_6509:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, Jump_007_651F
    cp a, $FE
    jr z, Jump_007_6539
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $F1
    ld [wLinkScreenStep], a
    ret

Jump_007_651F::
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

Jump_007_6539::
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

; entry 5 of the `rst $00` table in RunLinkScreenSubStateSubState_60E9_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSubMenuCursor2
; writes: wJoypadReadFlag, wLinkScreenStep, wGridCursorX, wScreenStep, wScreenSubStep
RunLinkScreenSubStateSubState_60E9_Case02_Case05::
Jump_007_6558:: ; address name
    ld a, [wSubMenuCursor2]
    cp a, $FF
    jr z, Jump_007_656E
    cp a, $FE
    jr z, Jump_007_6588
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $DC
    ld [wLinkScreenStep], a
    ret

Jump_007_656E::
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

Jump_007_6588::
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
; 6 call sites from 6 routines (e.g. RunLinkScreenSubStateSubState_60E9_Case02_Case07, RunLinkScreenSubStateSubState_60E9_Case02_Case06, RunLinkScreenSubStateSubState_60E9_Case02_Case05, RunLinkScreenSubStateSubState_60E9_Case02_Case04, ...)
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
GameMode5_Update_Case01_Case01::
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
; 1 call site from 1 routine (e.g. RunLinkScreenSubStateSubState_60E9_Case02_Case01)
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

; entry 2 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_Case01_Case02::
Jump_007_65FC:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_Case01_Case02_Case00
    dw GameMode5_Update_Case01_Case02_Case01
    dw GameMode5_Update_Case01_Case02_Case02

; entry 0 of the `rst $00` table in GameMode5_Update_Case01_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wStringCategory, wStringIndex
; points at: wLinkScreenSubState
GameMode5_Update_Case01_Case02_Case00::
Jump_007_6606:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ld a, $52
    call QueueMusic
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_Case01_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; points at: wSoundChannel1, wLinkScreenSubState
GameMode5_Update_Case01_Case02_Case01::
Jump_007_6624:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in GameMode5_Update_Case01_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: rRAMG, rRAMB, wLinkScreenSubState
; points at: sRecords, wScreenTileBuffer, wLinkScreenState
GameMode5_Update_Case01_Case02_Case02::
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
GameMode5_Update_Case01_Case03::
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
    jr nz, Jump_007_66D2
    ld a, [wMapType]
    bit 7, a
    ld a, $05
    jr nz, Jump_007_66D2
    ld a, $00

Jump_007_66D2::
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
GameMode5_Update_Case01_Case07::
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
    ld [wStringIndex], a
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
GameMode5_Update_Case01_Case08::
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
    ld [wStringIndex], a
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
GameMode5_Update_Case01_Case04::
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
    ld [wStringIndex], a
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
GameMode5_Update_Case01_Case05::
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

; entry 6 of the `rst $00` table in GameMode5_Update_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
GameMode5_Update_Case01_Case06::
Jump_007_683A:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw GameMode5_Update_Case01_Case06_Case00
    dw GameMode5_Update_Case01_Case06_Case01
    dw GameMode5_Update_Case01_Case06_Case02
    dw GameMode5_Update_Case01_Case06_Case03
    dw GameMode5_Update_Case01_Case06_Case04
    dw GameMode5_Update_Case01_Case06_Case05
    dw GameMode5_Update_Case01_Case06_Case06

; entry 0 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
GameMode5_Update_Case01_Case06_Case00::
Jump_007_684C:: ; address name
    ld a, $04
    call StartPaletteFade
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wIsCGB, wSGBActive
; writes: rSVBK, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wScreenTileBuffer, wScreenAttrBuffer, wOBJPaletteBuffer, wLinkScreenSubState
GameMode5_Update_Case01_Case06_Case01::
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
    jr z, Jump_007_687D
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    ld hl, wScreenAttrBuffer
    ld bc, $02D0
    call FillBytes
    xor a, a
    ldh [rSVBK], a

Jump_007_687D::
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_007_6897
    ld hl, wOBJPaletteBuffer
    ld de, wOBJPaletteBuffer + $20
    ld b, $20

Jump_007_6891::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_6891

Jump_007_6897::
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

; entry 2 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wLinkScreenSubState
GameMode5_Update_Case01_Case06_Case02::
Jump_007_68B7:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wWorkBuf
; points at: wLinkScreenSubState
GameMode5_Update_Case01_Case06_Case03::
Jump_007_68C1:: ; address name
    ld e, $01
    ld d, $00
    call SetFlagBit
    ld a, $01
    ld [wWorkBuf], a
    ld de, $0000
    call TestFlagBit
    jr c, Jump_007_68D9
    xor a, a
    ld [wWorkBuf], a

Jump_007_68D9::
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
GameMode5_Update_Case01_Case06_Case04::
Jump_007_68DE:: ; address name
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wWorkBuf, wRandomLo, wArg5
; writes: wSaveByte16
; points at: wArg1, wNameGlyphBuf, wPlayerName, wLinkScreenSubState
GameMode5_Update_Case01_Case06_Case05::
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

Jump_007_690E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_690E
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in GameMode5_Update_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, hPlayerX, wFollowerRecords, hPlayerY, hPlayerFacing, wPartyCount, ...
; points at: wKeyList
GameMode5_Update_Case01_Case06_Case06::
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
    call GameMode5_Update_Case01_Case06_Case06_Sub01
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
; 1 call site from 1 routine (e.g. GameMode5_Update_Case01_Case06_Case06)
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

; only called from GameMode5_Update_Case01_Case06_Case06 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case01_Case06_Case06)
; reads: wRecordBuffer, wRecordBufferData, wScreenAttrBuffer, wSpeciesRecord
; writes: rRAMG, rRAMB, wMonsterId, wSpeciesIdLo, wSpeciesIdHi
; points at: sRecords, wPlayerName
GameMode5_Update_Case01_Case06_Case06_Sub01::
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
    ld a, [wSpeciesRecord + $8]
    ld [hl+], a
    ld a, [wSpeciesRecord + $9]
    ld [hl+], a
    ld a, [wSpeciesRecord + $A]
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
    ld a, [wSpeciesRecord + $6]
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
    ld de, wSpeciesRecord + $12
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
    call GameMode5_Update_Case01_Case06_Case06_Sub01_Sub01
    ld hl, sRecords + $99
    call GameMode5_Update_Case01_Case06_Case06_Sub01_Sub01
    ld hl, sRecords + $1E
    call GameMode5_Update_Case01_Case06_Case06_Sub01_Sub01
    ld hl, sRecords + $29
    call GameMode5_Update_Case01_Case06_Case06_Sub01_Sub01
    farcall SetSpeciesFlag
    ret

; stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0 (E-0065) (the same 5 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case01_Case06_Case06_Sub01)
FillBBytesAtHL_Bank07::
Func_007_6AD0:: ; address name
    ld [hl+], a
    dec b
    jr nz, FillBBytesAtHL_Bank07
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
; 2 call sites from 1 routine (e.g. GameMode5_Update_Case01_Case06_Case06_Sub01)
CopyBBytesDEToHL_Bank07::
Func_007_6AD5:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank07
    ret

; only called from GameMode5_Update_Case01_Case06_Case06_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. GameMode5_Update_Case01_Case06_Case06_Sub01)
GameMode5_Update_Case01_Case06_Case06_Sub01_Sub01::
Func_007_6ADC:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld b, $07

Jump_007_6AE9::
    ld [hl+], a
    dec b
    jr nz, Jump_007_6AE9
    ret

; entry 2 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkSession, wLinkScreenState, wScreenState, wScreenByteEE, wSaveStep, wLinkSceneByte4B, wSaveStateFlag, wScreenStep, ...
; writes: wScreenByteEE, wGameMode, wModeChangeRequest, wMapType, wTalkEventIndex, wTalkEventGroup, hPlayerX, hPlayerY, ...
GameMode5_Update_Case02::
Jump_007_6AEE:: ; address name
    ld a, [wLinkSession]
    cp a, $05
    jp z, Jump_007_7D38
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, Jump_007_6B01
    ret

Jump_007_6B01::
    ld a, [wScreenState]
    cp a, $0C
    jr z, Jump_007_6B7D
    cp a, $0D
    jp z, Jump_007_6B9C
    ld a, [wScreenByteEE]
    and a, a
    jr z, Jump_007_6B23
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a, a
    ld [wScreenByteEE], a

Jump_007_6B23::
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

Jump_007_6B7D::
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $15
    jr z, Jump_007_6B8E
    cp a, $20
    jr z, Jump_007_6B95
    ret

Jump_007_6B8E::
    farcall DrawListEntriesCell5SpeciesSprite
    ret

Jump_007_6B95::
    farcall CallFunc6899PreservingArg1AndTemp0
    ret

Jump_007_6B9C::
    ld a, [wScreenStep]
    cp a, $15
    jr z, Jump_007_6BA8
    cp a, $20
    jr z, Jump_007_6BAF
    ret

Jump_007_6BA8::
    farcall DrawWCA36SpritePart_BankF1
    ret

Jump_007_6BAF::
    farcall DrawRecordBufBSpeciesSprites
    ret
    db $C9

; entry 3 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenState
GameMode5_Update_Case03::
Jump_007_6BB7:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, Jump_007_6BC2
    ret

Jump_007_6BC2::
    ret

; entry 4 of the `rst $00` table in GameMode5_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenState, wScreenState, wScreenStep, wScreenSubStep
GameMode5_Update_Case04::
Jump_007_6BC3:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    or a, a
    jr nz, Jump_007_6BCD
    ret

Jump_007_6BCD::
    ld a, [wScreenState]
    cp a, $0C
    jr z, Jump_007_6BD9
    cp a, $0D
    jr z, Jump_007_6BF8
    ret

Jump_007_6BD9::
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $20
    jr z, Jump_007_6BF1
    cp a, $15
    jr z, Jump_007_6BEA
    ret

Jump_007_6BEA::
    farcall DrawListEntriesCell5SpeciesSprite
    ret

Jump_007_6BF1::
    farcall CallFunc6899PreservingArg1AndTemp0
    ret

Jump_007_6BF8::
    ld a, [wScreenStep]
    cp a, $15
    jr z, Jump_007_6C04
    cp a, $20
    jr z, Jump_007_6C0B
    ret

Jump_007_6C04::
    farcall DrawWCA36SpritePart_BankF1
    ret

Jump_007_6C0B::
    farcall DrawRecordBufBSpeciesSprites
    ret

; runs the routine for wD06A (jump table of nine states) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_449F_Case01)
; reads: wLinkScreenState
RunLinkScreenState_6C12::
Func_007_6C12:: ; address name
    ld a, [wLinkScreenState]
    rst $00
    dw RunLinkScreenState_6C12_Case00
    dw RunLinkScreenState_6C12_Case01
    dw RunLinkScreenState_6C12_Case02
    dw RunLinkScreenState_6C12_Case03
    dw RunLinkScreenState_6C12_Case04
    dw RunLinkScreenState_6C12_Case05
    dw RunLinkScreenState_6C12_Case06
    dw RunLinkScreenState_6C12_Case07
    dw RunLinkScreenState_6C12_Case08

; entry 0 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkScreenState_6C12_Case00::
Jump_007_6C28:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenState_6C12_Case00_Case00
    dw RunLinkScreenState_6C12_Case00_Case01
    dw RunLinkScreenState_6C12_Case00_Case02

; entry 0 of the `rst $00` table in RunLinkScreenState_6C12_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wLinkScreenSubState
; writes: wSubMenuCursor, wLinkSendByte, wLinkScreenSubState
RunLinkScreenState_6C12_Case00_Case00::
Jump_007_6C32:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    di
    farcall RunSaveSteps
    ei
    call RunLinkScreenState_6C12_Case00_Case00_Sub01
    farcall FullyHealParty
    ld a, $04
    ld [wSubMenuCursor], a
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wLinkScreenSubState]
    inc a
    ld [wLinkScreenSubState], a
    ret

; only called from RunLinkScreenState_6C12_Case00_Case00 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkScreenState_6C12_Case00_Case00)
; reads: wPartyCount, hTemp0, hTemp1
; writes: rRAMG
; points at: wPartyList, wBattleBuffer72
RunLinkScreenState_6C12_Case00_Case00_Sub01::
Func_007_6C59:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleBuffer72

Jump_007_6C68::
    push hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, Jump_007_6C68
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

; entry 1 of the `rst $00` table in RunLinkScreenState_6C12_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
; writes: wLinkScreenSubState, wLinkSendByte
RunLinkScreenState_6C12_Case00_Case01::
Jump_007_6CAB:: ; address name
    ld a, [wLinkScreenSubState]
    inc a
    ld [wLinkScreenSubState], a
    ld a, $D3
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in RunLinkScreenState_6C12_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkScreenState
; writes: wLinkSendByte, wLinkScreenSubState, wLinkScreenState
RunLinkScreenState_6C12_Case00_Case02::
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

; entry 1 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wJoypadPressed, wMenuState
; writes: wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte, wBattleKind, wLinkSetupMode, wLinkScreenState
; points at: wLinkScreenState, wMenuState
RunLinkScreenState_6C12_Case01::
Jump_007_6CCD:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_007_6CEA
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenState
    inc [hl]
    jp Jump_007_6DA8

Jump_007_6CEA::
    cp a, $FD
    jr nz, Jump_007_6D06
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
    jp Jump_007_6DA8

Jump_007_6D06::
    cp a, $FC
    jr nz, Jump_007_6D19
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    jr Jump_007_6D2A

Jump_007_6D19::
    cp a, $FB
    jr nz, Jump_007_6D32
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a

Jump_007_6D2A::
    ld a, $08
    ld [wLinkScreenState], a
    jp Jump_007_6DA8

Jump_007_6D32::
    ld de, $5096
    ld hl, wMenuState
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_6D90
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    and a, $03
    cp a, $03
    jr z, Jump_007_6D97
    or a, a
    jr z, Jump_007_6D64
    cp a, $01
    jr z, Jump_007_6D76
    call LoadInvertedBit7FlagsToWorkBuf
    ld a, $08
    ld [wBattleKind], a
    ld de, $FD03
    jr Jump_007_6D86

Jump_007_6D64::
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld de, $FB05
    jr Jump_007_6D86

Jump_007_6D76::
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld de, $FC05

Jump_007_6D86::
    ld a, e
    ld [wLinkScreenState], a
    ld a, d
    ld [wLinkSendByte], a
    jr Jump_007_6DA8

Jump_007_6D90::
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_6DA8

Jump_007_6D97::
    ld a, $FE
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkScreenFlag], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld hl, wLinkScreenState
    inc [hl]

Jump_007_6DA8::
    ret

; stores 0, 0, 0, $63, $29, $01, 0, 0, $63, $80 at wD043-wD04C (E-0120)
; 6 call sites from 5 routines (e.g. RunLinkScreenState_6C12_Case05, RunLinkScreenState_6C12_Case01, RunLinkScreenState_6C12_Case02_Case00, RunLinkScreenState_6C12_Case03_Case00, ...)
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
; 6 call sites from 5 routines (e.g. RunLinkScreenState_6C12_Case05, RunLinkScreenState_6C12_Case01, RunLinkScreenState_6C12_Case02_Case00, RunLinkScreenState_6C12_Case03_Case00, ...)
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
; 3 call sites from 3 routines (e.g. RunLinkScreenState_6C12_Case01, RunLinkScreenState_6C12_Case04_Case07, RunLinkScreenState_6C12_Case08_Case00)
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

; entry 2 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkScreenState_6C12_Case02::
Jump_007_6E16:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenState_6C12_Case02_Case00
    dw RunLinkScreenState_6C12_Case02_Case01
    dw RunLinkScreenState_6C12_Case02_Case02
    dw RunLinkScreenState_6C12_Case02_Case03
    dw RunLinkScreenState_6C12_Case02_Case04
    dw RunLinkScreenState_6C12_Case02_Case05
    dw RunLinkScreenState_6C12_Case02_Case06
    dw RunLinkScreenState_6C12_Case02_Case07

; entry 0 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole
; writes: wBattleKind, wLinkScreenState, wLinkSendByte, wLinkSetupMode
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case00::
Jump_007_6E2A:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_007_6E8C
    cp a, $FE
    jr z, Jump_007_6E8C
    cp a, $FB
    jr z, Jump_007_6E42
    cp a, $FC
    jr z, Jump_007_6E5C
    cp a, $FD
    jr z, Jump_007_6E76
    ret

Jump_007_6E42::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6E8C
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

Jump_007_6E5C::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6E8C
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

Jump_007_6E76::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6E8C
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkSendByte], a
    ret

Jump_007_6E8C::
    xor a, a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case01::
Jump_007_6E9A:: ; address name
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $02
    ld [wLinkSendByte], a
    ret

; entry 2 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case02::
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

; entry 3 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case03::
Jump_007_6EC5:: ; address name
    ld a, [wLinkMessage]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case04::
Jump_007_6ECF:: ; address name
    ld hl, $0302
    ld a, [wLinkScreenFlag]
    or a, a
    jr z, Jump_007_6ED9
    inc l

Jump_007_6ED9::
    call ShowStringHL_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case05::
Jump_007_6EE1:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case02_Case06::
Jump_007_6EF0:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkScreenState_6C12_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSession, wLinkExchangeState, wLinkRole, wLinkStatus, wLinkMode, wLinkMessage, wLinkSendByte, wLinkScreenStep
; points at: wWorkBuf, wModeChangeRequest, wGameMode
RunLinkScreenState_6C12_Case02_Case07::
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

; entry 3 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkScreenState_6C12_Case03::
Jump_007_6F34:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenState_6C12_Case03_Case00
    dw RunLinkScreenState_6C12_Case03_Case01
    dw RunLinkScreenState_6C12_Case03_Case02
    dw RunLinkScreenState_6C12_Case03_Case03
    dw RunLinkScreenState_6C12_Case03_Case04
    dw RunLinkScreenState_6C12_Case03_Case05
    dw RunLinkScreenState_6C12_Case03_Case06
    dw RunLinkScreenState_6C12_Case03_Case07
    dw RunLinkScreenState_6C12_Case03_Case08
    dw RunLinkScreenState_6C12_Case03_Case09
    dw RunLinkScreenState_6C12_Case03_Case0A
    dw RunLinkScreenState_6C12_Case03_Case0B
    dw RunLinkScreenState_6C12_Case03_Case0C
    dw RunLinkScreenState_6C12_Case03_Case0D
    dw RunLinkScreenState_6C12_Case03_Case0E
    dw RunLinkScreenState_6C12_Case03_Case0F
    dw RunLinkScreenState_6C12_Case03_Case10
    dw RunLinkScreenState_6C12_Case03_Case11
    dw RunLinkScreenState_6C12_Case03_Case12
    dw RunLinkScreenState_6C12_Case03_Case13
    dw RunLinkScreenState_6C12_Case03_Case14
    dw RunLinkScreenState_6C12_Case03_Case15
    dw RunLinkScreenState_6C12_Case03_Case16
    dw RunLinkScreenState_6C12_Case03_Case17
    dw RunLinkScreenState_6C12_Case03_Case18
    dw RunLinkScreenState_6C12_Case03_Case19
    dw RunLinkScreenState_6C12_Case03_Case1A
    dw RunLinkScreenState_6C12_Case03_Case1B
    dw RunLinkScreenState_6C12_Case03_Case1C
    dw RunLinkScreenState_6C12_Case03_Case1D
    dw RunLinkScreenState_6C12_Case03_Case1E

; entry 0 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole
; writes: wSubMenuCursor, wLinkSendByte, wBattleKind, wLinkSetupMode, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case00::
Jump_007_6F76:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, Jump_007_6F8B
    cp a, $FD
    jr z, Jump_007_6FA7
    cp a, $FB
    jr z, Jump_007_6FBD
    cp a, $FC
    jr z, Jump_007_6FD7
    jr Jump_007_6FF1

Jump_007_6F8B::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6FF1
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    ret

Jump_007_6FA7::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6FF1
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkSendByte], a
    ret

Jump_007_6FBD::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6FF1
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

Jump_007_6FD7::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_6FF1
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

Jump_007_6FF1::
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

; entry 1 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSubState
; writes: wSubMenuCursor2, wMenuSelectedMember, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSubState, wWorkBuf
RunLinkScreenState_6C12_Case03_Case01::
Jump_007_7010:: ; address name
    ld hl, wMenuSubState
    ld de, $509E
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_7021
    ret

Jump_007_7021::
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

; entry 2 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkScreenState_6C12_Case03_Case02::
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

; entry 3 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember, wWorkBuf
; writes: wWorkBuf, wLinkScreenSubState, wLinkSetupMode, wLinkSendByte
; points at: wMenuSelectedMember, wLinkRules, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case03::
Jump_007_707C:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50AA
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_7097
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_7097::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr z, Jump_007_70AF
    ld a, $02
    ld [wLinkScreenSubState], a
    ret

Jump_007_70AF::
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
; 5 call sites from 1 routine (e.g. RunLinkScreenState_6C12_Case03_Case03)
SetHLBit7FromInverseABit0::
Func_007_70E9:: ; address name
    rrca
    and a, $80
    xor a, $80
    res 7, [hl]
    or a, [hl]
    ld [hl+], a
    ret

; entry 4 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case04::
Jump_007_70F3:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkBufferCountLo, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkReady, wLinkSendByte
; points at: wLinkRules, wLinkPartnerName, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case05::
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

; entry 6 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case06::
Jump_007_712D:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case07::
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

; entry 8 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case08::
Jump_007_7153:: ; address name
    ld hl, $0306
    call ShowStringHL_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case09::
Jump_007_715E:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte
RunLinkScreenState_6C12_Case03_Case0A::
Jump_007_7168:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_007_7183
    ld a, $02
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

Jump_007_7183::
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

; entry 11 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case0B::
Jump_007_719B:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50AE
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_71B6
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $1], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_71B6::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $1], a
    or a, a
    jr z, Jump_007_71CF
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_71CF::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 12 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRules
; writes: wMenuCursor, wSubMenuCursor, wSubMenuCursor2
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case0C::
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
    jr z, Jump_007_71FA
    ld a, b
    rlca
    rlca
    and a, $01

Jump_007_71FA::
    ld [de], a
    inc de
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    ld a, $02
    bit 5, c
    jr z, Jump_007_720B
    ld a, b
    rrca
    swap a
    and a, $01

Jump_007_720B::
    ld [de], a
    inc de
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    ld a, $02
    bit 4, c
    jr z, Jump_007_721B
    ld a, b
    swap a
    and a, $01

Jump_007_721B::
    ld [de], a
    inc de
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    ld a, $02
    bit 3, c
    jr z, Jump_007_722C
    ld a, b
    rrca
    rrca
    rrca
    and a, $01

Jump_007_722C::
    ld [de], a
    inc de
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    ld a, $02
    bit 2, c
    jr z, Jump_007_723C
    ld a, b
    rrca
    rrca
    and a, $01

Jump_007_723C::
    ld [de], a
    inc de
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    ld a, $02
    bit 1, c
    jr z, Jump_007_724B
    ld a, b
    rrca
    and a, $01

Jump_007_724B::
    ld [de], a
    inc de
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    ld a, $02
    bit 0, c
    jr z, Jump_007_7259
    ld a, b
    and a, $01

Jump_007_7259::
    ld [de], a
    call RunLinkScreenState_6C12_Case03_Case0C_Sub01
    xor a, a
    ld [wMenuCursor], a
    ld a, $07
    ld [wSubMenuCursor], a
    ld a, $03
    ld [wSubMenuCursor2], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; only called from RunLinkScreenState_6C12_Case03_Case0C (E-0047)
; 7 call sites from 1 routine (e.g. RunLinkScreenState_6C12_Case03_Case0C)
RunLinkScreenState_6C12_Case03_Case0C_Sub01::
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

; entry 13 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuCursor, wWorkBuf
; writes: wLinkRules, wLinkScreenSubState
; points at: wMenuCursor, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case0D::
Jump_007_7284:: ; address name
    ld hl, wMenuCursor
    ld de, $50C2
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_72AE
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

Jump_007_72AE::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld bc, $0000
    ld a, [wWorkBuf + $6]
    cp a, $02
    jr z, Jump_007_72C6
    rrca
    rrca
    and a, $40
    or a, b
    ld b, a
    set 6, c

Jump_007_72C6::
    ld a, [wWorkBuf + $7]
    cp a, $02
    jr z, Jump_007_72D6
    swap a
    rlca
    and a, $20
    or a, b
    ld b, a
    set 5, c

Jump_007_72D6::
    ld a, [wWorkBuf + $8]
    cp a, $02
    jr z, Jump_007_72E5
    swap a
    and a, $10
    or a, b
    ld b, a
    set 4, c

Jump_007_72E5::
    ld a, [wWorkBuf + $9]
    cp a, $02
    jr z, Jump_007_72F5
    swap a
    rrca
    and a, $08
    or a, b
    ld b, a
    set 3, c

Jump_007_72F5::
    ld a, [wWorkBuf + $A]
    cp a, $02
    jr z, Jump_007_7304
    rlca
    rlca
    and a, $04
    or a, b
    ld b, a
    set 2, c

Jump_007_7304::
    ld a, [wWorkBuf + $B]
    cp a, $02
    jr z, Jump_007_7312
    rlca
    and a, $02
    or a, b
    ld b, a
    set 1, c

Jump_007_7312::
    ld a, [wWorkBuf + $C]
    cp a, $02
    jr z, Jump_007_731F
    and a, $01
    or a, b
    ld b, a
    set 0, c

Jump_007_731F::
    ld a, c
    ld [wLinkRules + $1], a
    ld a, b
    ld [wLinkRules + $2], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

; entry 14 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case0E::
Jump_007_732C:: ; address name
    ld hl, wWorkBuf + $6
    ld de, $50D0
    call RunLinkScreenState_6C12_Shared01
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

; entry 15 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case0F::
Jump_007_7351:: ; address name
    ld hl, wWorkBuf + $7
    ld de, $50D6
    call RunLinkScreenState_6C12_Shared01
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

; entry 16 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case10::
Jump_007_7376:: ; address name
    ld hl, wWorkBuf + $8
    ld de, $50DC
    call RunLinkScreenState_6C12_Shared01
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

; entry 17 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case11::
Jump_007_739B:: ; address name
    ld hl, wWorkBuf + $9
    ld de, $50E2
    call RunLinkScreenState_6C12_Shared01
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

; entry 18 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case12::
Jump_007_73C0:: ; address name
    ld hl, wWorkBuf + $A
    ld de, $50E8
    call RunLinkScreenState_6C12_Shared01
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

; entry 19 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case13::
Jump_007_73E5:: ; address name
    ld hl, wWorkBuf + $B
    ld de, $50EE
    call RunLinkScreenState_6C12_Shared01
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

; entry 20 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case14::
Jump_007_740A:: ; address name
    ld hl, wWorkBuf + $C
    ld de, $50F4
    call RunLinkScreenState_6C12_Shared01
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

; entry 21 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case15::
Jump_007_742F:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50B2
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_744A
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $2], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_744A::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $2], a
    or a, a
    jr z, Jump_007_7463
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_7463::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 22 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRules
; writes: wMenuCursor, wSubMenuCursor
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case16::
Jump_007_746C:: ; address name
    ld hl, $578B
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $E0
    ld de, wScreenTileBuffer + $E0
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkScreenState_6C12_Shared02
    call RunLinkScreenState_6C12_Shared03
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

; entry 23 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuCursor, wLinkRules, wJoypadPressed
; writes: wLinkRules, wLinkScreenSubState
; points at: wMenuCursor
RunLinkScreenState_6C12_Case03_Case17::
Jump_007_7498:: ; address name
    ld hl, wMenuCursor
    ld de, $50FA
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_007_7514
    ld a, [wMenuCursor]
    and a, $01
    jr nz, Jump_007_74EF
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
    jr z, Jump_007_74D5
    dec hl
    ld a, h
    or a, a
    jr nz, Jump_007_74E1
    ld a, l
    cp a, $03
    jr nc, Jump_007_74E1
    ld hl, $0003
    jr Jump_007_74E1

Jump_007_74D5::
    inc hl
    ld a, l
    sub a, $29
    ld a, h
    sbc a, $01
    jr c, Jump_007_74E1
    ld hl, $0129

Jump_007_74E1::
    pop af
    or a, h
    ld [wLinkRules + $5], a
    ld a, l
    ld [wLinkRules + $4], a
    call RunLinkScreenState_6C12_Shared02
    jr Jump_007_7514

Jump_007_74EF::
    ld a, [wLinkRules + $3]
    ld l, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_7504
    dec hl
    ld a, l
    or a, a
    jr nz, Jump_007_750D
    ld hl, $0001
    jr Jump_007_750D

Jump_007_7504::
    inc l
    ld a, l
    cp a, $64
    jr c, Jump_007_750D
    ld hl, $0063

Jump_007_750D::
    ld a, l
    ld [wLinkRules + $3], a
    call RunLinkScreenState_6C12_Shared03

Jump_007_7514::
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

; only called from routines of RunLinkScreenState_6C12 (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkScreenState_6C12_Case03_Case17, RunLinkScreenState_6C12_Case03_Case16)
; reads: wLinkRules, wDigits
RunLinkScreenState_6C12_Shared02::
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
    jr nc, Jump_007_7550
    ld b, $C3

Jump_007_7550::
    ld hl, vBGMap0 + $10E
    ld a, b
    call WriteVRAMByteInc
    ld c, $01
    ld a, [wDigits]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7566
    ld c, $00
    ld a, $C3

Jump_007_7566::
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7578
    bit 0, c
    jr nz, Jump_007_7578
    ld a, $C3

Jump_007_7578::
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByteInc
    ld b, $C6
    ld a, e
    sub a, $29
    ld a, d
    sbc a, $01
    jr c, Jump_007_758F
    ld b, $C3

Jump_007_758F::
    ld a, b
    call WriteVRAMByte
    ret

; only called from routines of RunLinkScreenState_6C12 (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkScreenState_6C12_Case03_Case17, RunLinkScreenState_6C12_Case03_Case16)
; reads: wLinkRules, wDigits
RunLinkScreenState_6C12_Shared03::
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
    jr nc, Jump_007_75A8
    ld b, $C3

Jump_007_75A8::
    ld hl, vBGMap0 + $14E
    ld a, b
    call WriteVRAMByteInc
    ld a, $C3
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_75BF
    ld a, $C3

Jump_007_75BF::
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByteInc
    ld b, $C6
    ld a, e
    cp a, $63
    jr c, Jump_007_75D3
    ld b, $C3

Jump_007_75D3::
    ld a, b
    call WriteVRAMByte
    ret

; entry 24 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case18::
Jump_007_75D8:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50B6
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_75F3
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $3], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_75F3::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $3], a
    or a, a
    jr z, Jump_007_760C
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_760C::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 25 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case19::
Jump_007_7615:: ; address name
    ld hl, $57F3
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $62
    ld de, wScreenTileBuffer + $62
    ld bc, $0F0B
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkScreenState_6C12_Case03_Case19_Sub01
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 26 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wLinkRules, wMenuCursor
; writes: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case1A::
Jump_007_762F:: ; address name
    call RunLinkScreenState_6C12_Case03_Case1A_Sub02
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_7656
    ld a, [wLinkRules + $6]
    and a, $7F
    cp a, $7F
    jr nz, Jump_007_7651
    ld a, [wLinkRules + $7]
    and a, $F0
    cp a, $F0
    jr nz, Jump_007_7651
    ld a, $84
    call QueueSoundEffect
    ret

Jump_007_7651::
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_7656::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    call RunLinkScreenState_6C12_Case03_Case1A_Sub01
    ld a, [wMenuCursor]
    call RunLinkScreenState_6C12_Shared05
    ret

; only called from RunLinkScreenState_6C12_Case03_Case1A (E-0047)
; 1 call site from 1 routine (e.g. RunLinkScreenState_6C12_Case03_Case1A)
; reads: wMenuCursor
RunLinkScreenState_6C12_Case03_Case1A_Sub01::
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
    jr z, Jump_007_768C
    ld a, [hl]
    and a, e
    jr Jump_007_768E

Jump_007_768C::
    ld a, [hl]
    or a, d

Jump_007_768E::
    ld [hl], a
    ret

; only called from RunLinkScreenState_6C12_Case03_Case1A (E-0047)
; 1 call site from 1 routine (e.g. RunLinkScreenState_6C12_Case03_Case1A)
; reads: wFrameCounterLo, wJoypadPressedRepeat
; writes: wFrameCounterLo
; points at: wMenuCursor
RunLinkScreenState_6C12_Case03_Case1A_Sub02::
Func_007_7690:: ; address name
    ld hl, wMenuCursor
    ld de, $7700
    ld a, [wFrameCounterLo]
    and a, $07
    jr z, Jump_007_76AC
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, Jump_007_76A9
    call EraseCursorAtEntryHL_Bank07
    jr Jump_007_76AC

Jump_007_76A9::
    call WriteBBTileAtWordTableEntryC_Bank07

Jump_007_76AC::
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_007_76C3
    ld a, [hl]
    cp a, $05
    jr c, Jump_007_76BF
    jr z, Jump_007_76F4
    sub a, $06
    jr Jump_007_76F4

Jump_007_76BF::
    add a, $06
    jr Jump_007_76F4

Jump_007_76C3::
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_76DD
    ld a, [hl]
    or a, a
    jr z, Jump_007_76D5
    cp a, $06
    jr z, Jump_007_76D9
    dec a
    jr Jump_007_76F4

Jump_007_76D5::
    ld a, $05
    jr Jump_007_76F4

Jump_007_76D9::
    ld a, $0A
    jr Jump_007_76F4

Jump_007_76DD::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    ret z
    ld a, [hl]
    cp a, $05
    jr z, Jump_007_76EF
    cp a, $0A
    jr z, Jump_007_76F2
    inc a
    jr Jump_007_76F4

Jump_007_76EF::
    xor a, a
    jr Jump_007_76F4

Jump_007_76F2::
    ld a, $06

Jump_007_76F4::
    ld [hl], a
    xor a, a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    call WriteBBTileAtWordTableEntryC_Bank07
    ret
    db $43, $99, $45, $99, $47, $99, $49, $99, $4B, $99, $4D, $99, $83, $99, $85, $99
    db $87, $99, $89, $99, $8B, $99

; only called from RunLinkScreenState_6C12_Case03_Case19 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkScreenState_6C12_Case03_Case19)
RunLinkScreenState_6C12_Case03_Case19_Sub01::
Func_007_7716:: ; address name
    ld bc, $0B00

Jump_007_7719::
    push bc
    ld a, c
    call RunLinkScreenState_6C12_Shared05
    pop bc
    inc c
    dec b
    jr nz, Jump_007_7719
    ret

; only called from routines of RunLinkScreenState_6C12 (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkScreenState_6C12_Case03_Case1A, RunLinkScreenState_6C12_Case03_Case19_Sub01)
RunLinkScreenState_6C12_Shared05::
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
    jr nz, Jump_007_7749
    ld a, c

Jump_007_7749::
    call WriteVRAMByte
    ret
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $01, $80
    db $01, $40, $01, $20, $01, $10

; entry 27 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case1B::
Jump_007_7763:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50BA
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $02
    jr z, Jump_007_777E
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $4], a
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_777E::
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $4], a
    or a, a
    jr z, Jump_007_7797
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_7797::
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 28 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case03_Case1C::
Jump_007_77A0:: ; address name
    ld hl, $589C
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $E1
    ld de, wScreenTileBuffer + $E1
    ld bc, $1205
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkScreenState_6C12_Shared04
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 29 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wLinkRuleTurnLimit
; writes: wLinkScreenSubState, wLinkRuleTurnLimit
RunLinkScreenState_6C12_Case03_Case1D::
Jump_007_77BA:: ; address name
    ld a, [wJoypadPressed]
    and a, $03
    jr z, Jump_007_77CB
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ld [wLinkScreenSubState], a
    ret

Jump_007_77CB::
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_007_77E8
    ld a, [wLinkRuleTurnLimit]
    and a, $80
    ld d, a
    ld a, [wLinkRuleTurnLimit]
    and a, $7F
    cp a, $0B
    jr c, Jump_007_7806
    dec a
    or a, d
    ld [wLinkRuleTurnLimit], a
    jr Jump_007_7803

Jump_007_77E8::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_007_7806
    ld a, [wLinkRuleTurnLimit]
    and a, $80
    ld d, a
    ld a, [wLinkRuleTurnLimit]
    and a, $7F
    cp a, $63
    jr nc, Jump_007_7806
    inc a
    or a, d
    ld [wLinkRuleTurnLimit], a

Jump_007_7803::
    call RunLinkScreenState_6C12_Shared04

Jump_007_7806::
    ret

; only called from routines of RunLinkScreenState_6C12 (E-0098)
; 2 call sites from 2 routines (e.g. RunLinkScreenState_6C12_Case03_Case1D, RunLinkScreenState_6C12_Case03_Case1C)
; reads: wLinkRuleTurnLimit, wDigits
; points at: wLinkTradeByte
RunLinkScreenState_6C12_Shared04::
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
    jr nc, Jump_007_781D
    ld b, $C3

Jump_007_781D::
    cp a, $63
    jr c, Jump_007_7823
    ld c, $C3

Jump_007_7823::
    ld hl, vBGMap0 + $12E
    ld a, b
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7835
    ld a, $C3

Jump_007_7835::
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add a, $E0
    call WriteVRAMByteInc
    ld a, c
    call WriteVRAMByte
    ret

; entry 30 of the `rst $00` table in RunLinkScreenState_6C12_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wWorkBuf, wLinkScreenSubState
; points at: wMenuSelectedMember
RunLinkScreenState_6C12_Case03_Case1E::
Jump_007_7845:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50BE
    call RunLinkScreenState_6C12_Shared01
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

; entry 4 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkScreenState_6C12_Case04::
Jump_007_7864:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenState_6C12_Case04_Case00
    dw RunLinkScreenState_6C12_Case04_Case01
    dw RunLinkScreenState_6C12_Case04_Case02
    dw RunLinkScreenState_6C12_Case04_Case03
    dw RunLinkScreenState_6C12_Case04_Case04
    dw RunLinkScreenState_6C12_Case04_Case05
    dw RunLinkScreenState_6C12_Case04_Case06
    dw RunLinkScreenState_6C12_Case04_Case07
    dw RunLinkScreenState_6C12_Case04_Case08
    dw RunLinkScreenState_6C12_Case04_Case09
    dw RunLinkScreenState_6C12_Case04_Case0A
    dw RunLinkScreenState_6C12_Case04_Case0B

; entry 0 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wBattleKind, wLinkScreenState, wLinkSetupMode
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case00::
Jump_007_7880:: ; address name
    ld a, [wLinkMessage]
    cp a, $FB
    jr z, Jump_007_7891
    cp a, $FC
    jr z, Jump_007_78A4
    cp a, $FD
    jr z, Jump_007_78B7
    jr Jump_007_78C2

Jump_007_7891::
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

Jump_007_78A4::
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    ret

Jump_007_78B7::
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    ret

Jump_007_78C2::
    ld hl, TileRect_07_52FF
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case01::
Jump_007_78D9:: ; address name
    ld hl, $0304
    call ShowStringHL_Bank07
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case02::
Jump_007_78E8:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case03::
Jump_007_78F2:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_007_790E
    ld a, $02
    ld [wLinkScreenState], a
    ld a, $00
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

Jump_007_790E::
    cp a, $01
    ret nz
    ld hl, $0305
    call ShowStringHL_Bank07
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case04::
Jump_007_791C:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkBufferCountLo, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkReady, wLinkSendByte
; points at: wLinkRecvBuffer, wLinkRules, wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case05::
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

; entry 6 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case06::
Jump_007_795B:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wSubMenuCursor2, wMenuSelectedMember
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case07::
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

; entry 8 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wLinkSetupMode, wLinkSendByte
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case08::
Jump_007_7990:: ; address name
    ld hl, wMenuSelectedMember
    ld de, $50AA
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_79BB
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr nz, Jump_007_79C1
    ld a, $02
    ld [wLinkSetupMode], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_007_79BB::
    ld a, [wJoypadPressed]
    and a, $02
    ret z

Jump_007_79C1::
    ld a, $FE
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkScreenState_6C12_Case04_Case09::
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

; entry 10 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case0A::
Jump_007_79E4:: ; address name
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunLinkScreenState_6C12_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenFlag, wLinkScreenSubState
RunLinkScreenState_6C12_Case04_Case0B::
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

; entry 5 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState, wLinkMessage, wMenuState, wLinkRole
; writes: wLinkSendByte, wLinkReady, wLinkScreenState, wLinkScreenSubState, wBattleKind, wLinkSetupMode, wLinkScreenFlag
; points at: wScreenTileBuffer, wLinkScreenState
RunLinkScreenState_6C12_Case05::
Jump_007_79FC:: ; address name
    ld a, [wLinkScreenSubState]
    and a, a
    jr z, Jump_007_7A05
    jp Jump_007_7AA7

Jump_007_7A05::
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, Jump_007_7A12
    cp a, $FD
    jr z, Jump_007_7A2F
    jr Jump_007_7A45

Jump_007_7A12::
    ld a, [wLinkRole]
    bit 1, a
    jp z, Jump_007_7A9C
    ld a, $01
    ld [wLinkScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wLinkScreenState], a
    ret

Jump_007_7A2F::
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_7A9C
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkSendByte], a
    ret

Jump_007_7A45::
    ld a, [wLinkMessage]
    cp a, $FC
    jr z, Jump_007_7A52
    cp a, $FB
    jr z, Jump_007_7A52
    jr Jump_007_7A9C

Jump_007_7A52::
    ld a, [wMenuState]
    and a, a
    jr z, Jump_007_7A7A
    ld a, [wLinkMessage]
    cp a, $FC
    jr z, Jump_007_7A9C
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_7A9C
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    jr Jump_007_7A9C

Jump_007_7A7A::
    ld a, [wLinkMessage]
    cp a, $FB
    jr z, Jump_007_7A9C
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_007_7A9C
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wLinkScreenState], a
    jr Jump_007_7A9C

Jump_007_7A9C::
    ld a, $08
    ld [wLinkScreenState], a
    ld a, $00
    ld [wLinkScreenSubState], a
    ret

Jump_007_7AA7::
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

; entry 6 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenState
RunLinkScreenState_6C12_Case06::
Jump_007_7AC2:: ; address name
    farcall RunLinkScreenState_6C12_Case06_Sub01
    ld hl, wLinkScreenState
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
RunLinkScreenState_6C12_Case07::
Jump_007_7ACD:: ; address name
    farcall EggServiceMenu_Bank1B
    ret

; draws a tile at wC200, wC266, wC2A6, wC2E6, wC326 or wC366 (or 6/3 past it) depending on wD09D-wD0A2, then runs the four panel routines Func_007_7B30, 7B9D, 7C07 and 7C5F (E-0121)
; 3 call sites from 3 routines (e.g. RunLinkScreenState_6C12_Case03_Case00, RunLinkScreenState_6C12_Case04_Case07, RunLinkScreenState_6C12_Case08_Case00)
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
    call DrawWorkBufSelectionTilesAndPanels_Sub01
    call DrawWorkBufSelectionTilesAndPanels_Sub02
    call DrawWorkBufSelectionTilesAndPanels_Sub03
    call DrawWorkBufSelectionTilesAndPanels_Sub04
    ret

; writes tile $BC at HL when A = 0, else at HL + BC (E-0079)
; 6 call sites from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
WriteBCTileAtHLOrHLPlusBC::
Func_007_7B29:: ; address name
    or a, a
    jr z, Jump_007_7B2D
    add hl, bc

Jump_007_7B2D::
    ld [hl], $BC
    ret

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRules
DrawWorkBufSelectionTilesAndPanels_Sub01::
Func_007_7B30:: ; address name
    ld a, [wLinkRules + $1]
    ld c, a
    ld a, [wLinkRules + $2]
    ld b, a
    ld hl, wScreenTileBuffer + $E7
    ld a, $16
    bit 6, c
    jr z, Jump_007_7B48
    ld a, b
    rlca
    rlca
    and a, $01
    add a, $E0

Jump_007_7B48::
    ld [hl+], a
    ld a, $16
    bit 5, c
    jr z, Jump_007_7B57
    ld a, b
    rrca
    swap a
    and a, $01
    add a, $E0

Jump_007_7B57::
    ld [hl+], a
    ld a, $16
    bit 4, c
    jr z, Jump_007_7B65
    ld a, b
    swap a
    and a, $01
    add a, $E0

Jump_007_7B65::
    ld [hl+], a
    ld a, $16
    bit 3, c
    jr z, Jump_007_7B74
    ld a, b
    rlca
    swap a
    and a, $01
    add a, $E0

Jump_007_7B74::
    ld [hl+], a
    ld a, $16
    bit 2, c
    jr z, Jump_007_7B82
    ld a, b
    rrca
    rrca
    and a, $01
    add a, $E0

Jump_007_7B82::
    ld [hl+], a
    ld a, $16
    bit 1, c
    jr z, Jump_007_7B8F
    ld a, b
    rrca
    and a, $01
    add a, $E0

Jump_007_7B8F::
    ld [hl+], a
    ld a, $16
    bit 0, c
    jr z, Jump_007_7B9B
    ld a, b
    and a, $01
    add a, $E0

Jump_007_7B9B::
    ld [hl+], a
    ret

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRules, wDigits
DrawWorkBufSelectionTilesAndPanels_Sub02::
Func_007_7B9D:: ; address name
    ld de, $7BFD
    ld a, [wLinkRules + $5]
    bit 6, a
    jr z, Jump_007_7BB2
    ld de, $7C02
    ld a, [wLinkRules + $3]
    ld c, a
    ld b, $00
    jr Jump_007_7BBC

Jump_007_7BB2::
    ld a, [wLinkRules + $4]
    ld c, a
    ld a, [wLinkRules + $5]
    and a, $01
    ld b, a

Jump_007_7BBC::
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
    jr nz, Jump_007_7BE5
    ld c, $00
    ld a, $C3

Jump_007_7BE5::
    ld [hl+], a
    ld a, [wDigits + $1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7BF5
    bit 0, c
    jr nz, Jump_007_7BF5
    ld a, $C3

Jump_007_7BF5::
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ret
    db $15, $12, $15, $0B, $10, $29, $0B, $16, $C3, $C3

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRules
DrawWorkBufSelectionTilesAndPanels_Sub03::
Func_007_7C07:: ; address name
    ld a, [wLinkRules + $6]
    ld e, a
    ld a, [wLinkRules + $7]
    ld d, a
    ld hl, wScreenTileBuffer + $163
    xor a, a
    bit 6, e
    jr nz, Jump_007_7C18
    ld [hl], a

Jump_007_7C18::
    inc a
    inc hl
    bit 5, e
    jr nz, Jump_007_7C1F
    ld [hl], a

Jump_007_7C1F::
    inc a
    inc hl
    bit 4, e
    jr nz, Jump_007_7C26
    ld [hl], a

Jump_007_7C26::
    inc a
    inc hl
    bit 3, e
    jr nz, Jump_007_7C2D
    ld [hl], a

Jump_007_7C2D::
    inc a
    inc hl
    bit 2, e
    jr nz, Jump_007_7C34
    ld [hl], a

Jump_007_7C34::
    inc a
    inc hl
    bit 1, e
    jr nz, Jump_007_7C3B
    ld [hl], a

Jump_007_7C3B::
    inc a
    inc hl
    bit 0, e
    jr nz, Jump_007_7C42
    ld [hl], a

Jump_007_7C42::
    inc a
    inc hl
    bit 7, d
    jr nz, Jump_007_7C49
    ld [hl], a

Jump_007_7C49::
    inc a
    inc hl
    bit 6, d
    jr nz, Jump_007_7C50
    ld [hl], a

Jump_007_7C50::
    inc a
    inc hl
    bit 5, d
    jr nz, Jump_007_7C57
    ld [hl], a

Jump_007_7C57::
    inc a
    inc hl
    bit 4, d
    jr nz, Jump_007_7C5E
    ld [hl], a

Jump_007_7C5E::
    ret

; only called from DrawWorkBufSelectionTilesAndPanels (E-0047)
; 1 call site from 1 routine (e.g. DrawWorkBufSelectionTilesAndPanels)
; reads: wLinkRuleTurnLimit, wDigits
DrawWorkBufSelectionTilesAndPanels_Sub04::
Func_007_7C5F:: ; address name
    ld a, [wLinkRuleTurnLimit]
    ld l, a
    res 7, l
    ld h, $00
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $46
    ld a, [wDigits + $1]
    or a, a
    jr z, Jump_007_7C76
    add a, $E0
    ld [hl], a

Jump_007_7C76::
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ret

; entry 8 of the `rst $00` table in RunLinkScreenState_6C12
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenSubState
RunLinkScreenState_6C12_Case08::
Jump_007_7C7E:: ; address name
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkScreenState_6C12_Case08_Case00
    dw RunLinkScreenState_6C12_Case08_Case01
    dw RunLinkScreenState_6C12_Case08_Case02
    dw RunLinkScreenState_6C12_Case08_Case03
    dw RunLinkScreenState_6C12_Case08_Case04

; entry 0 of the `rst $00` table in RunLinkScreenState_6C12_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wSubMenuCursor2, wMenuSelectedMember, wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkScreenState_6C12_Case08_Case00::
Jump_007_7C8C:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jp z, RunLinkScreenState_6C12_Case08_Case04
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

; entry 1 of the `rst $00` table in RunLinkScreenState_6C12_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wJoypadPressed, wMenuSelectedMember
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
; points at: wMenuSelectedMember, wLinkScreenSubState
RunLinkScreenState_6C12_Case08_Case01::
Jump_007_7CB7:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, RunLinkScreenState_6C12_Case08_Case04
    ld hl, wMenuSelectedMember
    ld de, $50AA
    call RunLinkScreenState_6C12_Shared01
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_007_7CE4
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $01
    jr nz, Jump_007_7CEA
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_007_7CE4::
    ld a, [wJoypadPressed]
    and a, $02
    ret z

Jump_007_7CEA::
    ld a, $FE
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunLinkScreenState_6C12_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag, wLinkSendByte
RunLinkScreenState_6C12_Case08_Case02::
Jump_007_7CF8:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, RunLinkScreenState_6C12_Case08_Case04
    cp a, $01
    ret nz
    ld a, $05
    ld [wLinkScreenState], a
    ld a, $01
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 3 of the `rst $00` table in RunLinkScreenState_6C12_Case08
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkScreenState_6C12_Case08_Case03::
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

; entry 4 of the `rst $00` table in RunLinkScreenState_6C12_Case08
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wLinkScreenFlag
RunLinkScreenState_6C12_Case08_Case04::
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

Jump_007_7D38::
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    cp a, $01
    jr z, Jump_007_7D43
    ret

Jump_007_7D43::
    ld a, [wScreenState]
    cp a, $0C
    jr z, Jump_007_7DAB
    cp a, $0D
    jr z, Jump_007_7DCA
    ld a, [wLinkSceneByte4B]
    or a, a
    ret z
    call RunLinkScreenState_6C12_Case08_Case04_Sub01
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

Jump_007_7DAB::
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $15
    jr z, Jump_007_7DBC
    cp a, $20
    jr z, Jump_007_7DC3
    ret

Jump_007_7DBC::
    farcall DrawListEntriesCell5SpeciesSprite
    ret

Jump_007_7DC3::
    farcall CallFunc6899PreservingArg1AndTemp0
    ret

Jump_007_7DCA::
    ld a, [wScreenStep]
    cp a, $15
    jr z, Jump_007_7DD6
    cp a, $20
    jr z, Jump_007_7DDD
    ret

Jump_007_7DD6::
    farcall DrawWCA36SpritePart_BankF1
    ret

Jump_007_7DDD::
    farcall DrawRecordBufBSpeciesSprites
    ret
    db $C9

; only called from RunLinkScreenState_6C12_Case08_Case04 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkScreenState_6C12_Case08_Case04)
; reads: wLinkRole, wItemGridX, wItemGridY, wArg5, wArg6, wArg7, wSaveStep
; writes: wArg1, wListCursor, wListPageIndex, wArg2, rRAMG2, rRAMB, wSaveStep, wSaveRecordIndex, ...
; points at: wChildRecord, wMonsterLibraryBuf, wPackWork, wScreenState
RunLinkScreenState_6C12_Case08_Case04_Sub01::
Func_007_7DE5:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jp z, Jump_007_7E6E
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

Jump_007_7E37::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_7E37
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

Jump_007_7E69::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_7E69

Jump_007_7E6E::
    xor a, a
    ld [wLinkByteEB], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a

Jump_007_7E79::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, Jump_007_7E79
    ld hl, wScreenState
    ld bc, $006F

Jump_007_7E8C::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_7E8C
    ret
    ds $16C, $00
