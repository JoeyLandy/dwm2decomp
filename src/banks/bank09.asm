SECTION "Bank 09", ROMX[$4000], BANK[$09]
    db $09

; ld de, this bank's string table / BeginStringDisplay
; 5 call sites from 5 routines (e.g. ShowString_Bank09, DebugMessageTest_Update_ToBeginStringDisplay_Bank09, RunMessageBox_Bank12_BeginStringDisplay_Bank09, RunMessageBoxStateIfActive_Bank12_BeginStringDisplay_Bank09, ...)
BeginStringDisplay_Bank09::
Func_009_4001:: ; address name
    ld de, StringCategories_09_4016
    call BeginStringDisplay
    ret

; ld de, this bank's string table / CopyStringToBuffer
; 2 call sites from 2 routines (e.g. PauseMenu_State3_ChooseListEntry_UpdateMenuCursor_Case03, CopyItemStringToWC152)
CopyStringToBuffer_Bank09::
Func_009_4008:: ; address name
    ld de, StringCategories_09_4016
    call CopyStringToBuffer
    ret

; Func_009_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 16 call sites from 13 routines (e.g. ShowString0Bank09AtTiles16E0ThenItemDescription, ShowString1Bank09AtTiles16E0ThenDetails, PauseMenu_State3_ChooseListEntry_WriteTextWindowRowsAndTextWindowWidthEtc, PauseMenu_State3_ChooseListEntry_WaitPauseListCount, ...)
ShowString_Bank09::
Func_009_400F:: ; address name
    call BeginStringDisplay_Bank09
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_09_4016::
Data_009_4016:: ; address name
    dw StringList_09_402A ; id 0
    dw StringList_09_4030 ; id 1
    dw StringList_09_4064 ; id 2
    dw StringList_09_4078 ; id 3
    dw StringList_09_410A ; id 4
    dw StringList_09_410C ; id 5
    dw StringList_09_41B4 ; id 6
    dw StringList_09_41CE ; id 7
    dw StringList_09_41EC ; id 8
    dw StringList_09_41EE ; id 9

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_402A::
Data_009_402A:: ; address name
    dw String_09_00_00 ; id 0
    dw String_09_00_01 ; id 1
    dw String_09_00_02 ; id 2

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_4030::
Data_009_4030:: ; address name
    dw String_09_01_00 ; id 0
    dw String_09_01_01 ; id 1
    dw String_09_01_02 ; id 2
    dw String_09_01_03 ; id 3
    dw String_09_01_04 ; id 4
    dw String_09_01_05 ; id 5
    dw String_09_01_06 ; id 6
    dw String_09_01_07 ; id 7
    dw String_09_01_08 ; id 8
    dw String_09_01_09 ; id 9
    dw String_09_01_0A ; id 10
    dw String_09_01_0B ; id 11
    dw String_09_01_0C ; id 12
    dw String_09_01_0D ; id 13
    dw String_09_01_0E ; id 14
    dw String_09_01_0F ; id 15
    dw String_09_01_10 ; id 16
    dw String_09_01_11 ; id 17
    dw String_09_01_12 ; id 18
    dw String_09_01_13 ; id 19
    dw String_09_01_14 ; id 20
    dw String_09_01_15 ; id 21
    dw String_09_01_16 ; id 22
    dw String_09_01_17 ; id 23
    dw String_09_01_18 ; id 24
    dw String_09_01_19 ; id 25

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_4064::
Data_009_4064:: ; address name
    dw String_09_02_00 ; id 0
    dw String_09_02_01 ; id 1
    dw String_09_02_02 ; id 2
    dw String_09_02_03 ; id 3
    dw String_09_02_04 ; id 4
    dw String_09_02_04 ; id 5
    dw String_09_02_06 ; id 6
    dw String_09_02_07 ; id 7
    dw String_09_02_08 ; id 8
    dw String_09_02_09 ; id 9

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_4078::
Data_009_4078:: ; address name
    dw String_09_03_00 ; id 0
    dw String_09_03_01 ; id 1
    dw String_09_03_02 ; id 2
    dw String_09_03_03 ; id 3
    dw String_09_03_04 ; id 4
    dw String_09_03_05 ; id 5
    dw String_09_03_06 ; id 6
    dw String_09_03_07 ; id 7
    dw String_09_03_08 ; id 8
    dw String_09_03_09 ; id 9
    dw String_09_03_0A ; id 10
    dw String_09_03_0B ; id 11
    dw String_09_03_0C ; id 12
    dw String_09_03_0D ; id 13
    dw String_09_03_0E ; id 14
    dw String_09_03_0F ; id 15
    dw String_09_03_10 ; id 16
    dw String_09_03_11 ; id 17
    dw String_09_03_12 ; id 18
    dw String_09_03_13 ; id 19
    dw String_09_03_14 ; id 20
    dw String_09_03_15 ; id 21
    dw String_09_03_16 ; id 22
    dw String_09_03_17 ; id 23
    dw String_09_03_18 ; id 24
    dw String_09_03_19 ; id 25
    dw String_09_03_1A ; id 26
    dw String_09_03_1B ; id 27
    dw String_09_03_1C ; id 28
    dw String_09_03_1D ; id 29
    dw String_09_03_1E ; id 30
    dw String_09_03_1F ; id 31
    dw String_09_03_20 ; id 32
    dw String_09_03_21 ; id 33
    dw String_09_03_22 ; id 34
    dw String_09_03_23 ; id 35
    dw String_09_03_24 ; id 36
    dw String_09_03_25 ; id 37
    dw String_09_03_26 ; id 38
    dw String_09_03_27 ; id 39
    dw String_09_03_28 ; id 40
    dw String_09_03_29 ; id 41
    dw String_09_03_2A ; id 42
    dw String_09_03_2B ; id 43
    dw String_09_03_2C ; id 44
    dw String_09_03_2D ; id 45
    dw String_09_03_2E ; id 46
    dw String_09_03_2F ; id 47
    dw String_09_03_30 ; id 48
    dw String_09_03_31 ; id 49
    dw String_09_03_32 ; id 50
    dw String_09_03_33 ; id 51
    dw String_09_03_34 ; id 52
    dw String_09_03_35 ; id 53
    dw String_09_03_36 ; id 54
    dw String_09_03_37 ; id 55
    dw String_09_03_38 ; id 56
    dw String_09_03_39 ; id 57
    dw String_09_03_3A ; id 58
    dw String_09_03_3B ; id 59
    dw String_09_03_3C ; id 60
    dw String_09_03_3D ; id 61
    dw String_09_03_3E ; id 62
    dw String_09_03_3F ; id 63
    dw String_09_03_40 ; id 64
    dw String_09_03_41 ; id 65
    dw String_09_03_42 ; id 66
    dw String_09_03_43 ; id 67
    dw String_09_03_44 ; id 68
    dw String_09_03_45 ; id 69
    dw String_09_03_46 ; id 70
    dw String_09_03_47 ; id 71
    dw String_09_03_48 ; id 72

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_410A::
Data_009_410A:: ; address name
    dw String_09_04_00 ; id 0

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_410C::
Data_009_410C:: ; address name
    dw String_09_05_00 ; id 0
    dw String_09_05_01 ; id 1
    dw String_09_05_02 ; id 2
    dw String_09_05_03 ; id 3
    dw String_09_05_04 ; id 4
    dw String_09_05_05 ; id 5
    dw String_09_05_06 ; id 6
    dw String_09_05_07 ; id 7
    dw String_09_05_08 ; id 8
    dw String_09_05_09 ; id 9
    dw String_09_05_0A ; id 10
    dw String_09_05_0B ; id 11
    dw String_09_05_0C ; id 12
    dw String_09_05_0D ; id 13
    dw String_09_05_0E ; id 14
    dw String_09_05_0F ; id 15
    dw String_09_05_10 ; id 16
    dw String_09_05_11 ; id 17
    dw String_09_05_12 ; id 18
    dw String_09_05_13 ; id 19
    dw String_09_05_14 ; id 20
    dw String_09_05_15 ; id 21
    dw String_09_05_16 ; id 22
    dw String_09_05_17 ; id 23
    dw String_09_05_18 ; id 24
    dw String_09_05_19 ; id 25
    dw String_09_05_1A ; id 26
    dw String_09_05_1B ; id 27
    dw String_09_05_1C ; id 28
    dw String_09_05_1D ; id 29
    dw String_09_05_1E ; id 30
    dw String_09_05_1F ; id 31
    dw String_09_05_20 ; id 32
    dw String_09_05_21 ; id 33
    dw String_09_05_22 ; id 34
    dw String_09_05_23 ; id 35
    dw String_09_05_24 ; id 36
    dw String_09_05_25 ; id 37
    dw String_09_05_26 ; id 38
    dw String_09_05_27 ; id 39
    dw String_09_05_28 ; id 40
    dw String_09_05_29 ; id 41
    dw String_09_05_2A ; id 42
    dw String_09_05_2B ; id 43
    dw String_09_05_2C ; id 44
    dw String_09_05_2D ; id 45
    dw String_09_05_2E ; id 46
    dw String_09_05_2F ; id 47
    dw String_09_05_30 ; id 48
    dw String_09_05_31 ; id 49
    dw String_09_05_32 ; id 50
    dw String_09_05_33 ; id 51
    dw String_09_05_34 ; id 52
    dw String_09_05_35 ; id 53
    dw String_09_05_36 ; id 54
    dw String_09_05_37 ; id 55
    dw String_09_05_38 ; id 56
    dw String_09_05_39 ; id 57
    dw String_09_05_3A ; id 58
    dw String_09_05_3B ; id 59
    dw String_09_05_3C ; id 60
    dw String_09_05_3D ; id 61
    dw String_09_05_3E ; id 62
    dw String_09_05_3F ; id 63
    dw String_09_05_40 ; id 64
    dw String_09_05_41 ; id 65
    dw String_09_05_42 ; id 66
    dw String_09_05_43 ; id 67
    dw String_09_05_44 ; id 68
    dw String_09_05_45 ; id 69
    dw String_09_05_46 ; id 70
    dw String_09_05_47 ; id 71
    dw String_09_05_48 ; id 72
    dw String_09_05_49 ; id 73
    dw String_09_05_4A ; id 74
    dw String_09_05_4B ; id 75
    dw String_09_05_4C ; id 76
    dw String_09_05_4D ; id 77
    dw String_09_05_4E ; id 78
    dw String_09_05_4F ; id 79
    dw String_09_05_50 ; id 80
    dw String_09_05_51 ; id 81
    dw String_09_05_52 ; id 82
    dw String_09_05_53 ; id 83

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41B4::
Data_009_41B4:: ; address name
    dw String_09_06_00 ; id 0
    dw String_09_06_01 ; id 1
    dw String_09_06_02 ; id 2
    dw String_09_06_03 ; id 3
    dw String_09_06_04 ; id 4
    dw String_09_06_05 ; id 5
    dw String_09_06_06 ; id 6
    dw String_09_06_07 ; id 7
    dw String_09_06_08 ; id 8
    dw String_09_06_09 ; id 9
    dw String_09_06_0A ; id 10
    dw String_09_06_0B ; id 11
    dw String_09_06_0C ; id 12

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41CE::
Data_009_41CE:: ; address name
    dw String_09_07_00 ; id 0
    dw String_09_07_01 ; id 1
    dw String_09_07_02 ; id 2
    dw String_09_07_03 ; id 3
    dw String_09_07_04 ; id 4
    dw String_09_07_05 ; id 5
    dw String_09_07_06 ; id 6
    dw String_09_07_07 ; id 7
    dw String_09_07_08 ; id 8
    dw String_09_07_09 ; id 9
    dw String_09_07_0A ; id 10
    dw String_09_07_0B ; id 11
    dw String_09_07_0C ; id 12
    dw String_09_07_0D ; id 13
    dw String_09_07_0E ; id 14

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41EC::
Data_009_41EC:: ; address name
    dw String_09_08_00 ; id 0

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41EE::
Data_009_41EE:: ; address name
    dw String_09_09_00 ; id 0
    dw String_09_09_01 ; id 1
    dw String_09_09_02 ; id 2
    dw String_09_09_03 ; id 3
    dw String_09_09_04 ; id 4
    dw String_09_09_05 ; id 5
    dw String_09_09_06 ; id 6
    dw String_09_09_07 ; id 7
    dw String_09_09_08 ; id 8
    dw String_09_09_09 ; id 9
    dw String_09_09_0A ; id 10
    dw String_09_09_0B ; id 11
    dw String_09_09_0C ; id 12
    dw String_09_09_0D ; id 13
    dw String_09_09_0E ; id 14
    dw String_09_09_0F ; id 15
    dw String_09_09_10 ; id 16
    dw String_09_09_11 ; id 17
    dw String_09_09_12 ; id 18
    dw String_09_09_13 ; id 19
    dw String_09_09_14 ; id 20
    dw String_09_09_15 ; id 21
    dw String_09_09_16 ; id 22
    dw String_09_09_17 ; id 23
    dw String_09_09_18 ; id 24
    dw String_09_09_19 ; id 25
    dw String_09_09_1A ; id 26
    dw String_09_09_1B ; id 27
    dw String_09_09_1C ; id 28
    dw String_09_09_1D ; id 29
    dw String_09_09_1E ; id 30
    dw String_09_09_1F ; id 31
    dw String_09_09_20 ; id 32
    dw String_09_09_21 ; id 33

String_09_00_00:: ; heuristic: string; C0
Data_009_4232:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WHATUsoePersoHPMPATKDEFAGLINTWLDnality", $F0

String_09_00_01:: ; heuristic: string; C0
Data_009_4259:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TOWHOHPMP", $F0

String_09_00_02:: ; heuristic: string; C0
Data_009_4263:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RJadlnoprtuxy-fWATUCHPMDcgimhw    Dcgimh       ", $AC, $F0

String_09_01_00:: ; heuristic: string; C0
Data_009_4294:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "But it was empty.", $F7
    db $F0

String_09_01_01:: ; heuristic: string; C0
Data_009_42C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained", $F1
    db $F9, $4E, "G.", $F7
    db $F0

String_09_01_02:: ; heuristic: string; C0
Data_009_42FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained the", $F1
    db $F9, "Y.", $F7
    db $F0

String_09_01_03:: ; heuristic: string; C0
Data_009_4331:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "Found ", $F9, "Y.", $F1
    db $FA, $F7
    db $F2, "But there is no", $F1
    db "room for it.", $F7
    db $F0

String_09_01_04:: ; heuristic: string; C0
Data_009_437D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "The chest was a", $F1
    db "Mimic!", $F7
    db $F0

String_09_01_05:: ; heuristic: string; C0
Data_009_43B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained", $F1
    db $F9, $4E, "G.", $F7
    db $F0

String_09_01_06:: ; heuristic: string; C0
Data_009_43C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db $F9, "Y.", $F7
    db $F0

String_09_01_07:: ; heuristic: string; C0
Data_009_43DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Found ", $F9, "Y.", $F1
    db $FA, $F7
    db $F2, "But there is no", $F1
    db "room for it.", $F7
    db $F0

String_09_01_08:: ; heuristic: string; C0
Data_009_4408:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained a", $F1
    db "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_09_01_09:: ; heuristic: string; C0
Data_009_4447:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "A Magic Key was", $F1
    db "found.", $FA, $F7
    db $F2, "But there is no", $F1
    db "room for it.", $F7
    db $F0

String_09_01_0A:: ; heuristic: string; C0
Data_009_449F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N dropped", $F1
    db "dead.", $F7
    db $F0

String_09_01_0B:: ; heuristic: string; C0
Data_009_44B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F2, $F9, "N dropped", $F1
    db "dead.", $F7
    db $F0

String_09_01_0C:: ; heuristic: string; C0
Data_009_44C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Wiped out were", $EF, $EE, "you, warooh?", $FA, $F7
    db $EF, $EE, "GreatLog can't be", $EF, $EE, "saved if you're a", $FA, $F7
    db $EF, $EE, "waffling little", $EF, $EE, "wimp, warooh.", $FA, $F7
    db $EF, $EE, "I'm big-hearted,", $EF, $EE, "so I'll share some", $FA, $F7
    db $EF, $EE, "of GreatLog's power", $EF, $EE, "with you.", $F7
    db $F0

String_09_01_0D:: ; heuristic: string; C0
Data_009_458A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0! You're safe!", $FA, $F7
    db $EF, $EE, "I'll share some of", $EF, $EE, "GreatLog's power.", $F7
    db $F0

String_09_01_0E:: ; heuristic: string; C0
Data_009_45D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The two monsters", $F1
    db "went away quietly", $A4, $F7
    db $F0

String_09_01_0F:: ; heuristic: string; C0
Data_009_45F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Repellent's effect", $F1
    db "wore off.", $F7
    db $F0

String_09_01_10:: ; heuristic: string; C0
Data_009_4616:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StepGuard's effect", $F1
    db "wore off.", $F7
    db $F0

String_09_01_11:: ; heuristic: string; C0
Data_009_4633:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey.", $F1
    db "There. All healed!", $FA, $F7
    db $EF, $EE, "You be careful,", $EF, $EE, "warooh!", $F7
    db $F0

String_09_01_12:: ; heuristic: string; C0
Data_009_4675:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChangeStaff's", $F1
    db "effect wore off.", $F7
    db $F0

String_09_01_13:: ; heuristic: string; C0
Data_009_4694:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0, wiped out?", $FA, $F7
    db $EF, $EE, "That isn't good at", $EF, $EE, "all for a master!", $FA, $F7
    db $EF, $EE, "I'm big-hearted so", $EF, $EE, "I'll share some of", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "with you, warooh!", $F7
    db $F0

String_09_01_14:: ; heuristic: string; C0
Data_009_472C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " Hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Getting wiped out", $EF, $EE, "is wimpy!", $FA, $F7
    db $EF, $EE, "You're not much of", $EF, $EE, "a hero, are you?", $FA, $F7
    db $EF, $EE, "Peti's big-hearted,", $EF, $EE, "so I'll share some", $FA, $F7
    db $EF, $EE, "of GreatLog's power", $EF, $EE, "with you.", $F7
    db $F0

String_09_01_15:: ; heuristic: string; C0
Data_009_47D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " Back,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "I'll share some of", $EF, $EE, "GreatLog's power.", $F7
    db $F0

String_09_01_16:: ; heuristic: string; C0
Data_009_480D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " There.", $F1
    db "All healed now.", $FA, $F7
    db $EF, $EE, "You be careful out", $EF, $EE, "there!", $F7
    db $F0

String_09_01_17:: ; heuristic: string; C0
Data_009_484D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "X hatched.", $FA, $F7
    db $F1
    db "Please name it.", $EF, $EE, $F7
    db $F0

String_09_01_18:: ; heuristic: string; C0
Data_009_486E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "X", $A2, $F9, $4E, $F1
    db "hatched.", $FA, $F7
    db $EF, $EE, "Please name it.", $EF, $EE, $F7
    db $F0

String_09_01_19:: ; heuristic: string; C0
Data_009_4893:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained a", $F1
    db "DreamEgg.", $FA, $F7
    db $EF, $EE, "DreamEgg was sent", $EF, $EE, "to the farm.", $F7
    db $F0

String_09_02_00:: ; heuristic: string; C0
Data_009_48F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FIGHTEMPLAN", $F0

String_09_02_01:: ; heuristic: string; C0
Data_009_48FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChargeMixedDefense      Command", $F0

String_09_02_02:: ; heuristic: string; C0
Data_009_491C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FightSklGuard", $F0

String_09_02_03:: ; heuristic: string; C0
Data_009_492A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TOWHAlyEnem", $F0

String_09_02_04:: ; heuristic: string; C0
Data_009_4936:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOKMonsterEgg", $F0

String_09_02_06:: ; heuristic: string; C0
Data_009_4947:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skill On", $9E, "Off Orb ID Odds", $F0

String_09_02_07:: ; heuristic: string; C0
Data_009_4960:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No Skil", $F0

String_09_02_08:: ; heuristic: string; C0
Data_009_4968:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Special Command", $F0

String_09_02_09:: ; heuristic: string; C0
Data_009_4978:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Betray", $F1
    db "Twin", $F1
    db "Guard", $F0

String_09_03_00:: ; heuristic: string; C0
Data_009_498A:: ; address name
    db $B8, $F0

String_09_03_01:: ; heuristic: string; C0
Data_009_498C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ylw", $F0

String_09_03_02:: ; heuristic: string; C0
Data_009_4990:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Plain", $F0

String_09_03_03:: ; heuristic: string; C0
Data_009_4996:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Green", $F0

String_09_03_04:: ; heuristic: string; C0
Data_009_499C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blue", $F0

String_09_03_05:: ; heuristic: string; C0
Data_009_49A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "First", $F0

String_09_03_06:: ; heuristic: string; C0
Data_009_49A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Red", $F0

String_09_03_07:: ; heuristic: string; C0
Data_009_49AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "White", $F0

String_09_03_08:: ; heuristic: string; C0
Data_009_49B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Quiet", $F0

String_09_03_09:: ; heuristic: string; C0
Data_009_49B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Black", $F0

String_09_03_0A:: ; heuristic: string; C0
Data_009_49BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gaudy", $F0

String_09_03_0B:: ; heuristic: string; C0
Data_009_49C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Silvr", $F0

String_09_03_0C:: ; heuristic: string; C0
Data_009_49C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dream", $F0

String_09_03_0D:: ; heuristic: string; C0
Data_009_49CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Misty", $F0

String_09_03_0E:: ; heuristic: string; C0
Data_009_49D5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Secrt", $F0

String_09_03_0F:: ; heuristic: string; C0
Data_009_49DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shiny", $F0

String_09_03_10:: ; heuristic: string; C0
Data_009_49E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Last", $F0

String_09_03_11:: ; heuristic: string; C0
Data_009_49E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_09_03_12:: ; heuristic: string; C0
Data_009_49EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Draco", $F0

String_09_03_13:: ; heuristic: string; C0
Data_009_49F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beast", $F0

String_09_03_14:: ; heuristic: string; C0
Data_009_49F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bird", $F0

String_09_03_15:: ; heuristic: string; C0
Data_009_49FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tree", $F0

String_09_03_16:: ; heuristic: string; C0
Data_009_4A02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bug", $F0

String_09_03_17:: ; heuristic: string; C0
Data_009_4A06:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devil", $F0

String_09_03_18:: ; heuristic: string; C0
Data_009_4A0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Death", $F0

String_09_03_19:: ; heuristic: string; C0
Data_009_4A12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thing", $F0

String_09_03_1A:: ; heuristic: string; C0
Data_009_4A18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

String_09_03_1B:: ; heuristic: string; C0
Data_009_4A1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lord", $F0

String_09_03_1C:: ; heuristic: string; C0
Data_009_4A23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cave", $F0

String_09_03_1D:: ; heuristic: string; C0
Data_009_4A28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Isle", $F0

String_09_03_1E:: ; heuristic: string; C0
Data_009_4A2D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Torch", $F0

String_09_03_1F:: ; heuristic: string; C0
Data_009_4A33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gardn", $F0

String_09_03_20:: ; heuristic: string; C0
Data_009_4A39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pit", $F0

String_09_03_21:: ; heuristic: string; C0
Data_009_4A3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bsmt", $F0

String_09_03_22:: ; heuristic: string; C0
Data_009_4A42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jail", $F0

String_09_03_23:: ; heuristic: string; C0
Data_009_4A47:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magma", $F0

String_09_03_24:: ; heuristic: string; C0
Data_009_4A4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sea", $F0

String_09_03_25:: ; heuristic: string; C0
Data_009_4A51:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Field", $F0

String_09_03_26:: ; heuristic: string; C0
Data_009_4A57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tower", $F0

String_09_03_27:: ; heuristic: string; C0
Data_009_4A5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine", $F0

String_09_03_28:: ; heuristic: string; C0
Data_009_4A62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hill", $F0

String_09_03_29:: ; heuristic: string; C0
Data_009_4A67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cstle", $F0

String_09_03_2A:: ; heuristic: string; C0
Data_009_4A6D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mound", $F0

String_09_03_2B:: ; heuristic: string; C0
Data_009_4A73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desrt", $F0

String_09_03_2C:: ; heuristic: string; C0
Data_009_4A79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake", $F0

String_09_03_2D:: ; heuristic: string; C0
Data_009_4A7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jungl", $F0

String_09_03_2E:: ; heuristic: string; C0
Data_009_4A84:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Haven", $F0

String_09_03_2F:: ; heuristic: string; C0
Data_009_4A8A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grass", $F0

String_09_03_30:: ; heuristic: string; C0
Data_009_4A90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Forst", $F0

String_09_03_31:: ; heuristic: string; C0
Data_009_4A96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grave", $F0

String_09_03_32:: ; heuristic: string; C0
Data_009_4A9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Crag", $F0

String_09_03_33:: ; heuristic: string; C0
Data_009_4AA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shore", $F0

String_09_03_34:: ; heuristic: string; C0
Data_009_4AA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log", $F0

String_09_03_35:: ; heuristic: string; C0
Data_009_4AAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sky", $F0

String_09_03_36:: ; heuristic: string; C0
Data_009_4AAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mtn", $F0

String_09_03_37:: ; heuristic: string; C0
Data_009_4AB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "View", $F0

String_09_03_38:: ; heuristic: string; C0
Data_009_4AB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cliff", $F0

String_09_03_39:: ; heuristic: string; C0
Data_009_4ABE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Islet", $F0

String_09_03_3A:: ; heuristic: string; C0
Data_009_4AC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Land", $F0

String_09_03_3B:: ; heuristic: string; C0
Data_009_4AC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grove", $F0

String_09_03_3C:: ; heuristic: string; C0
Data_009_4ACF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swamp", $F0

String_09_03_3D:: ; heuristic: string; C0
Data_009_4AD5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Manor", $F0

String_09_03_3E:: ; heuristic: string; C0
Data_009_4ADB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Depth", $F0

String_09_03_3F:: ; heuristic: string; C0
Data_009_4AE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hole", $F0

String_09_03_40:: ; heuristic: string; C0
Data_009_4AE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tomb", $F0

String_09_03_41:: ; heuristic: string; C0
Data_009_4AEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soil", $F0

String_09_03_42:: ; heuristic: string; C0
Data_009_4AF0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pond", $F0

String_09_03_43:: ; heuristic: string; C0
Data_009_4AF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hell", $F0

String_09_03_44:: ; heuristic: string; C0
Data_009_4AFA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moon", $F0

String_09_03_45:: ; heuristic: string; C0
Data_009_4AFF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ocean", $F0

String_09_03_46:: ; heuristic: string; C0
Data_009_4B05:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulch", $F0

String_09_03_47:: ; heuristic: string; C0
Data_009_4B0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "River", $F0

String_09_03_48:: ; heuristic: string; C0
Data_009_4B11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Star", $F0

String_09_04_00:: ; heuristic: string; C0
Data_009_4B16:: ; address name
    db $F0

String_09_05_00:: ; heuristic: string; C0
Data_009_4B17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Allow me to heal", $F1
    db "your injuries.", $F7
    db $F0

String_09_05_01:: ; heuristic: string; C0
Data_009_4B3B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I will pray for", $F1
    db "you. Farewell.", $F7
    db $F0

String_09_05_02:: ; heuristic: string; C0
Data_009_4B5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "Y! Only", $F1
    db $F9, $4E, "G! Well?", $FF, $F0

String_09_05_03:: ; heuristic: string; C0
Data_009_4B76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Thanks! Hope I", $F1
    db "see you again!", $F7
    db $F0

String_09_05_04:: ; heuristic: string; C0
Data_009_4B98:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hah? Not buying?", $F1
    db "Bah, another time.", $F7
    db $F0

String_09_05_05:: ; heuristic: string; C0
Data_009_4BC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll heal you", $F1
    db "for 1000G. Well?", $FF, $F0

String_09_05_06:: ; heuristic: string; C0
Data_009_4BE2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hehehe, money is", $F1
    db "my motivation.", $FA, $F7
    db $EF, $EE, "Hope you'll give", $EF, $EE, "me some again!", $F7
    db $F0

String_09_05_07:: ; heuristic: string; C0
Data_009_4C29:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, I hope your", $F1
    db "luck holds, kid!", $FA, $F7
    db $EF, $EE, "Don't blame me if", $EF, $EE, "you don't make it.", $F7
    db $F0

String_09_05_08:: ; heuristic: string; C0
Data_009_4C76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "Y! Just", $F1
    db $F9, $4E, "G! Well?", $FF, $F0

String_09_05_09:: ; heuristic: string; C0
Data_009_4C8E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heheheh, thanks!", $F1
    db "See you again!", $F7
    db $F0

String_09_05_0A:: ; heuristic: string; C0
Data_009_4CB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, tightwad", $A4, $F1
    db "You'll regret this.", $F7
    db $F0

String_09_05_0B:: ; heuristic: string; C0
Data_009_4CD8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm a wandering", $F1
    db "master.", $FA, $F7
    db $EF, $EE, "I", $42, "e been on the", $EF, $EE, "road for training.", $FA, $F7
    db $EF, $EE, "You look tough.", $EF, $EE, "Want to battle?", $FF, $F0

String_09_05_0C:: ; heuristic: string; C0
Data_009_4D3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Urgh. Tougher", $F1
    db "than me", $A4, $FA, $F7
    db $EF, $EE, "I", $44, " better redouble", $EF, $EE, "my training.", $F7
    db $F0

String_09_05_0D:: ; heuristic: string; C0
Data_009_4D7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained a", $F1
    db "WarpWing.", $F7
    db $F0

String_09_05_0E:: ; heuristic: string; C0
Data_009_4D96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hahahah! I", $F1
    db "overestimated you!", $F7
    db $F0

String_09_05_0F:: ; heuristic: string; C0
Data_009_4DB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 lost", $F1
    db $F9, $4E, "G.", $F7
    db $F0

String_09_05_10:: ; heuristic: string; C0
Data_009_4DC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm a traveling", $F1
    db "master.", $FA, $F7
    db $EF, $EE, "I'm training", $EF, $EE, "my monsters.", $FA, $F7
    db $EF, $EE, "You look strong.", $EF, $EE, "Will you battle?", $FF, $F0

String_09_05_11:: ; heuristic: string; C0
Data_009_4E24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Uh-oh, I lost!", $F1
    db "I can do better!", $F7
    db $F0

String_09_05_12:: ; heuristic: string; C0
Data_009_4E48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm sorry, but", $F1
    db "you didn't put up", $FA, $F7
    db $EF, $EE, "much resistance.", $EF, $EE, "I'm a little bored.", $F7
    db $F0

String_09_05_13:: ; heuristic: string; C0
Data_009_4E93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hi! Want to try", $F1
    db "your luck?", $FA, $F7
    db $EF, $EE, $F9, "Y is the", $EF, $EE, "prize!", $FA, $F7
    db $EF, $EE, "Want to try?", $EF, $EE, "It's just 100G!", $FF, $F0

String_09_05_14:: ; heuristic: string; C0
Data_009_4EE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'll pick a card", $F1
    db "between 1 and 13.", $FA, $F7
    db $EF, $EE, "Is the card I", $EF, $EE, "picked above 7?", $FF, $F0

String_09_05_15:: ; heuristic: string; C0
Data_009_4F2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'll have nice", $F1
    db "prizes next time.", $F7
    db $F0

String_09_05_16:: ; heuristic: string; C0
Data_009_4F53:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Wow! You win!", $FA, $F7
    db $EF, $EE, "Next, ", $F9, "Y is", $EF, $EE, "the prize.", $FA, $F7
    db $EF, $EE, "Want to bet what", $EF, $EE, "you", $42, "e won so far", $FA, $F7
    db $EF, $EE, "and ", $F9, $51, "G for a", $EF, $EE, "chance to win?", $FF, $F0

String_09_05_17:: ; heuristic: string; C0
Data_009_4FD5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Whoops, you lose.", $FA, $F7
    db $EF, $EE, "I'll take ", $F9, $51, "G", $EF, $EE, "and any prize.", $F7
    db $F0

String_09_05_18:: ; heuristic: string; C0
Data_009_5019:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Oh, same number?", $FA, $F7
    db $EF, $EE, "Sorry, I win in", $EF, $EE, "this case.", $FA, $F7
    db $EF, $EE, "I'll take ", $F9, $51, "G", $EF, $EE, "and any prize.", $F7
    db $F0

String_09_05_19:: ; heuristic: string; C0
Data_009_507B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do you think the", $F1
    db "next card I pick", $FA, $F7
    db $EF, $EE, "will be above ", $F9, $4E, "?", $EF, $EE, $FF, $F0

String_09_05_1A:: ; heuristic: string; C0
Data_009_50B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Awww, you won't", $F1
    db "play?", $FA, $F7
    db $EF, $EE, "Please come again", $EF, $EE, "and try your luck!", $F7
    db $F0

String_09_05_1B:: ; heuristic: string; C0
Data_009_50FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained", $F1
    db "the ", $F9, "Y.", $F7
    db $F0

String_09_05_1C:: ; heuristic: string; C0
Data_009_510F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Wow! You win!", $FA, $F7
    db $EF, $EE, "That was the last", $EF, $EE, "prize!", $FA, $F7
    db $EF, $EE, "Please try again", $EF, $EE, "the next time!", $F7
    db $F0

String_09_05_1D:: ; heuristic: string; C0
Data_009_5170:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you can beat", $F1
    db "me, I'll give you", $FA, $F7
    db $EF, $EE, "something good.", $EF, $EE, "Want to battle?", $FF, $F0

String_09_05_1E:: ; heuristic: string; C0
Data_009_51B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Very good. Here's", $F1
    db "your reward.", $F7
    db $F0

String_09_05_1F:: ; heuristic: string; C0
Data_009_51DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, that was", $F1
    db "unseemly.", $FA, $F7
    db $EF, $EE, "You shouldn't shirk", $EF, $EE, "from training.", $F7
    db $F0

String_09_05_20:: ; heuristic: string; C0
Data_009_521E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 lost", $F1
    db $F9, $4E, "G.", $F7
    db $F0

String_09_05_21:: ; heuristic: string; C0
Data_009_522C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Do you want a map?", $F1
    db "Just 200G.", $FF, $F0

String_09_05_22:: ; heuristic: string; C0
Data_009_524C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No?", $F1
    db "That's too bad.", $F7
    db $F0

String_09_05_23:: ; heuristic: string; C0
Data_009_5263:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 handed over", $F1
    db "200G.", $F7
    db $F0

String_09_05_24:: ; heuristic: string; C0
Data_009_527A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll give you", $F1
    db "special medicine", $FA, $F7
    db $EF, $EE, "if you manage to", $EF, $EE, "defeat me.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "challenge me?", $FF, $F0

String_09_05_25:: ; heuristic: string; C0
Data_009_52E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e won.", $F1
    db "As promised, let", $FA, $F7
    db $EF, $EE, "me give you some", $EF, $EE, "of my medicine.", $F7
    db $F0

String_09_05_26:: ; heuristic: string; C0
Data_009_5325:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N's ", $F9, "Y", $F1
    db "rose by ", $F9, $4E, ".", $F7
    db $F0

String_09_05_27:: ; heuristic: string; C0
Data_009_5339:: ; address name
    db $F0

String_09_05_28:: ; heuristic: string; C0
Data_009_533A:: ; address name
    db $11, $19, $F0

String_09_05_29:: ; heuristic: string; C0
Data_009_533D:: ; address name
    db $16, $19, $F0

String_09_05_2A:: ; heuristic: string; C0
Data_009_5340:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ATK", $F0

String_09_05_2B:: ; heuristic: string; C0
Data_009_5344:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DEF", $F0

String_09_05_2C:: ; heuristic: string; C0
Data_009_5348:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AGL", $F0

String_09_05_2D:: ; heuristic: string; C0
Data_009_534C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "INT", $F0

String_09_05_2E:: ; heuristic: string; C0
Data_009_5350:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome aboard", $F1
    db "the casino ship!", $FA, $F7
    db $EF, $EE, "Have a spin on the", $EF, $EE, "slots for 100G!", $FA, $F7
    db $EF, $EE, "There are prizes", $EF, $EE, "too. Try it out?", $FF, $F0

String_09_05_2F:: ; heuristic: string; C0
Data_009_53C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Stop the reels", $F1
    db "with the A Button.", $FA, $F7
    db $EF, $EE, "Depending on what", $EF, $EE, "marks you line up,", $FA, $F7
    db $EF, $EE, "the prizes will", $EF, $EE, "vary. Ready?", $F7
    db $F0

String_09_05_30:: ; heuristic: string; C0
Data_009_5431:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky! You win a", $F1
    db "TinyMedal!", $F7
    db $F0

String_09_05_31:: ; heuristic: string; C0
Data_009_5451:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There it is!", $F1
    db "You win 1000G!", $F7
    db $F0

String_09_05_32:: ; heuristic: string; C0
Data_009_5471:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whoa! You", $42, "e won", $F1
    db "a MeteOrb!", $F7
    db $F0

String_09_05_33:: ; heuristic: string; C0
Data_009_5490:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whoa", $A4, " Are you", $F1
    db "kidding me?", $FA, $F7
    db $EF, $EE, "You", $42, "e won some", $EF, $EE, "secret medicine.", $F7
    db $F0

String_09_05_34:: ; heuristic: string; C0
Data_009_54D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Are you serious?", $F1
    db "I don't believe it.", $FA, $F7
    db $EF, $EE, "You", $42, "e won some", $EF, $EE, "secret medicine.", $F7
    db $F0

String_09_05_35:: ; heuristic: string; C0
Data_009_551E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Too bad", $A4, $F1
    db "Try again, OK?", $F7
    db $F0

String_09_05_36:: ; heuristic: string; C0
Data_009_553A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That's too bad.", $F1
    db "See you again.", $F7
    db $F0

String_09_05_37:: ; heuristic: string; C0
Data_009_555C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I will heal your", $F1
    db "injuries for you", $A4, $FA, $F7
    db $EF, $EE, "If you can defeat", $EF, $EE, "me, that is. Well?", $FF, $F0

String_09_05_38:: ; heuristic: string; C0
Data_009_55AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine, fine,", $F1
    db "I surrender.", $FA, $F7
    db $EF, $EE, "I'll heal your", $EF, $EE, "party as promised.", $F7
    db $F0

String_09_05_39:: ; heuristic: string; C0
Data_009_55EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your lack of", $F1
    db "training is clear.", $FA, $F7
    db $EF, $EE, "Best of luck to", $EF, $EE, "you", $A4, $F7
    db $F0

String_09_05_3A:: ; heuristic: string; C0
Data_009_562B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let me lighten", $F1
    db "your purse.", $F7
    db $F0

String_09_05_3B:: ; heuristic: string; C0
Data_009_564A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I see an injured", $F1
    db "monster", $A4, $FA, $F7
    db $EF, $EE, "Heh, I think I can", $EF, $EE, "win this one.", $F7
    db $F0

String_09_05_3C:: ; heuristic: string; C0
Data_009_568D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, at least one", $F1
    db "monster tired?", $FA, $F7
    db $EF, $EE, "This works out", $EF, $EE, "perfectly for me.", $F7
    db $F0

String_09_05_3D:: ; heuristic: string; C0
Data_009_56D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, those are", $F1
    db "some weaklings!", $FA, $F7
    db $EF, $EE, "That makes things", $EF, $EE, "easy for me.", $F7
    db $F0

String_09_05_3E:: ; heuristic: string; C0
Data_009_571C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The fugitive", $F1
    db "master was", $FA, $F7
    db $EF, $EE, "captured and sent", $EF, $EE, "back to GreatLog.", $F7
    db $F0

String_09_05_3F:: ; heuristic: string; C0
Data_009_575D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll unburden", $F1
    db "you of your gold.", $F7
    db $F0

String_09_05_40:: ; heuristic: string; C0
Data_009_5780:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm not dirty-", $F1
    db "not at all.", $FA, $F7
    db $EF, $EE, "You shouldn't be", $EF, $EE, "so careless.", $F7
    db $F0

String_09_05_41:: ; heuristic: string; C0
Data_009_57BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll need more", $F1
    db "experience to", $FA, $F7
    db $EF, $EE, "catch me, much", $EF, $EE, "more, hahahah!", $F7
    db $F0

String_09_05_42:: ; heuristic: string; C0
Data_009_5803:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heheheh, your", $F1
    db "looks don't lie!", $FA, $F7
    db $EF, $EE, "That'll teach you", $EF, $EE, "to stay away!", $F7
    db $F0

String_09_05_43:: ; heuristic: string; C0
Data_009_5848:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_09_05_44:: ; heuristic: string; C0
Data_009_5866:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 500G!", $F7
    db $F0

String_09_05_45:: ; heuristic: string; C0
Data_009_5886:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 200G!", $F7
    db $F0

String_09_05_46:: ; heuristic: string; C0
Data_009_58A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 100G!", $F7
    db $F0

String_09_05_47:: ; heuristic: string; C0
Data_009_58C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 50G!", $F7
    db $F0

String_09_05_48:: ; heuristic: string; C0
Data_009_58E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e no courage", $F1
    db "to battle?", $FA, $F7
    db $EF, $EE, "Shame, it really", $EF, $EE, "is.", $F7
    db $F0

String_09_05_49:: ; heuristic: string; C0
Data_009_591E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I take being a", $F1
    db "master seriously.", $FA, $F7
    db $EF, $EE, "I won't hold back", $EF, $EE, "from anything!", $F7
    db $F0

String_09_05_4A:: ; heuristic: string; C0
Data_009_5967:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No? You're rather", $F1
    db "cowardly.", $F7
    db $F0

String_09_05_4B:: ; heuristic: string; C0
Data_009_5986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, the sparkle", $F1
    db "in your eyes", $A4, $FA, $F7
    db $EF, $EE, "I", $44, " best not", $EF, $EE, "disappoint you!", $F7
    db $F0

String_09_05_4C:: ; heuristic: string; C0
Data_009_59C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What?", $F1
    db "Little chicken!", $FA, $F7
    db $EF, $EE, "Go home to your", $EF, $EE, "mommy, baby!", $F7
    db $F0

String_09_05_4D:: ; heuristic: string; C0
Data_009_5A03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good answer!", $F1
    db "Let's battle!", $F7
    db $F0

String_09_05_4E:: ; heuristic: string; C0
Data_009_5A21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you poor", $F1
    db "monsters.", $FA, $F7
    db $EF, $EE, "You have such a", $EF, $EE, "poor master", $A4, $F7
    db $F0

String_09_05_4F:: ; heuristic: string; C0
Data_009_5A5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you're ready,", $F1
    db "are you?", $FA, $F7
    db $EF, $EE, "But I don't plan", $EF, $EE, "on losing!", $F7
    db $F0

String_09_05_50:: ; heuristic: string; C0
Data_009_5A9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I thought you", $F1
    db "were dedicated", $A4, $FA, $F7
    db $EF, $EE, "But my eyes must", $EF, $EE, "have been misled.", $F7
    db $F0

String_09_05_51:: ; heuristic: string; C0
Data_009_5AE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My eyes didn't", $F1
    db "mislead me. Ready?", $F7
    db $F0

String_09_05_52:: ; heuristic: string; C0
Data_009_5B08:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Now you can see", $F1
    db "the entire world!", $F7
    db $F0

String_09_05_53:: ; heuristic: string; C0
Data_009_5B2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hope you'll", $F1
    db "put up more of a", $FA, $F7
    db $EF, $EE, "fight next time", $EF, $EE, "than this", $A4, $F7
    db $F0

String_09_06_00:: ; heuristic: string; C0
Data_009_5B6F:: ; address name
    db $F0

String_09_06_01:: ; heuristic: string; C0
Data_009_5B70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog", $5B, $F0

String_09_06_02:: ; heuristic: string; C0
Data_009_5B7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Oasis", $5B, $F0

String_09_06_03:: ; heuristic: string; C0
Data_009_5B81:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pirate", $5B, $F0

String_09_06_04:: ; heuristic: string; C0
Data_009_5B89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ice", $5B, $F0

String_09_06_05:: ; heuristic: string; C0
Data_009_5B8E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sky", $5B, $F0

String_09_06_06:: ; heuristic: string; C0
Data_009_5B93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Limbo", $5B, $F0

String_09_06_07:: ; heuristic: string; C0
Data_009_5B9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Elf", $5B, $F0

String_09_06_08:: ; heuristic: string; C0
Data_009_5B9F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lonely", $5B, $F0

String_09_06_09:: ; heuristic: string; C0
Data_009_5BA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traveler", $5B, $F0

String_09_06_0A:: ; heuristic: string; C0
Data_009_5BB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brawn", $5B, $F0

String_09_06_0B:: ; heuristic: string; C0
Data_009_5BB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle", $5B, $F0

String_09_06_0C:: ; heuristic: string; C0
Data_009_5BC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul", $5B, $F0

String_09_07_00:: ; heuristic: string; C0
Data_009_5BC6:: ; address name
    db $F1, $F1, $F0

String_09_07_01:: ; heuristic: string; C0
Data_009_5BC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "return", $F1
    db "home.", $F0

String_09_07_02:: ; heuristic: string; C0
Data_009_5BDD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Desert", $F1
    db "World.", $F0

String_09_07_03:: ; heuristic: string; C0
Data_009_5BF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Sea", $F1
    db "World.", $F0

String_09_07_04:: ; heuristic: string; C0
Data_009_5C04:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Ice", $F1
    db "World.", $F0

String_09_07_05:: ; heuristic: string; C0
Data_009_5C16:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Sky", $F1
    db "World.", $F0

String_09_07_06:: ; heuristic: string; C0
Data_009_5C28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Limbo.", $F1
    db $F0

String_09_07_07:: ; heuristic: string; C0
Data_009_5C37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Elf", $F1
    db "World.", $F0

String_09_07_08:: ; heuristic: string; C0
Data_009_5C49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Lonely", $F1
    db "World.", $F0

String_09_07_09:: ; heuristic: string; C0
Data_009_5C5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Travel", $F1
    db "World.", $F0

String_09_07_0A:: ; heuristic: string; C0
Data_009_5C73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Power", $F1
    db "World.", $F0

String_09_07_0B:: ; heuristic: string; C0
Data_009_5C87:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Baffle", $F1
    db "World.", $F0

String_09_07_0C:: ; heuristic: string; C0
Data_009_5C9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Soul", $F1
    db "World.", $F0

String_09_07_0D:: ; heuristic: string; C0
Data_009_5CAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic", $F1
    db "Key to", $F1
    db "where?", $F0

String_09_07_0E:: ; heuristic: string; C0
Data_009_5CC3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db $F9, "0.", $F1
    db $F0

String_09_08_00:: ; heuristic: string; C0
Data_009_5CCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "New gameContinueVS battleBreedTrade ", $B8, "Journal datalost", $A4, $F0

String_09_09_00:: ; heuristic: string; C0
Data_009_5D06:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "We have a special", $EF, $EE, "team with us!", $F7
    db $F0

String_09_09_01:: ; heuristic: string; C0
Data_009_5D44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For today's C", $EF, $EE, "Class Challenge,", $FA, $F7
    db $EF, $EE, "we have a little", $EF, $EE, "challenger!", $F7
    db $F0

String_09_09_02:: ; heuristic: string; C0
Data_009_5DA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For today's B", $EF, $EE, "Class Tournament,", $FA, $F7
    db $EF, $EE, "we have a brave,", $EF, $EE, "new challenger!", $F7
    db $F0

String_09_09_03:: ; heuristic: string; C0
Data_009_5E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For today's A", $EF, $EE, "Class Tournament,", $FA, $F7
    db $EF, $EE, "we have a hot, new", $EF, $EE, "challenger!", $F7
    db $F0

String_09_09_04:: ; heuristic: string; C0
Data_009_5E63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ladies and", $F1
    db "gentlemen!", $FA, $F7
    db $EF, $EE, "For today's S", $EF, $EE, "Class Tournament,", $FA, $F7
    db $EF, $EE, "we have a brand", $EF, $EE, "new hero!", $F7
    db $F0

String_09_09_05:: ; heuristic: string; C0
Data_009_5EBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " E Class battles", $F1
    db "are ready to go!", $F7
    db $F0

String_09_09_06:: ; heuristic: string; C0
Data_009_5EE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " D Class battles", $F1
    db "are ready to go!", $F7
    db $F0

String_09_09_07:: ; heuristic: string; C0
Data_009_5F08:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " C Class battles", $F1
    db "are ready to go!", $F7
    db $F0

String_09_09_08:: ; heuristic: string; C0
Data_009_5F2D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " B Class battles", $F1
    db "are ready to go!", $F7
    db $F0

String_09_09_09:: ; heuristic: string; C0
Data_009_5F52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A Class battles", $F1
    db "are ready to go!", $F7
    db $F0

String_09_09_0A:: ; heuristic: string; C0
Data_009_5F77:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " S Class battles", $F1
    db "are ready to go!", $F7
    db $F0

String_09_09_0B:: ; heuristic: string; C0
Data_009_5F9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ladies and", $F1
    db "gentlemen!", $FA, $F7
    db $EF, $EE, "Get ready for a", $EF, $EE, "Special Match!", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0", $EF, $EE, "will take on", $A4, $F7
    db $F0

String_09_09_0C:: ; heuristic: string; C0
Data_009_5FF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "the farm friends!", $F7
    db $F0

String_09_09_0D:: ; heuristic: string; C0
Data_009_6019:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "the fun friends!", $F7
    db $F0

String_09_09_0E:: ; heuristic: string; C0
Data_009_603C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "trusty friends!", $F7
    db $F0

String_09_09_0F:: ; heuristic: string; C0
Data_009_605E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "powerful friends!", $F7
    db $F0

String_09_09_10:: ; heuristic: string; C0
Data_009_6082:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "brave friends!", $F7
    db $F0

String_09_09_11:: ; heuristic: string; C0
Data_009_60A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This next battle", $F1
    db "will feature the", $FA, $F7
    db $EF, $EE, "up-and-coming", $EF, $EE, "monster master", $A4, $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the farm friends!", $F7
    db $F0

String_09_09_12:: ; heuristic: string; C0
Data_009_610F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ????????? and", $F1
    db "????? friends!", $F7
    db $F0

String_09_09_13:: ; heuristic: string; C0
Data_009_6130:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Battle one!", $F1
    db "Ready? Go!", $F7
    db $F0

String_09_09_14:: ; heuristic: string; C0
Data_009_614B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Battle two!", $F1
    db "Ready? Go!", $F7
    db $F0

String_09_09_15:: ; heuristic: string; C0
Data_009_6166:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This decides the", $F1
    db "champion!", $FA, $F7
    db $EF, $EE, "Final battle!", $EF, $EE, "Ready? Go!", $F7
    db $F0

String_09_09_16:: ; heuristic: string; C0
Data_009_61A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is it! The", $F1
    db "deciding battle!", $FA, $F7
    db $EF, $EE, "Are you ready?", $EF, $EE, "Let's go!", $F7
    db $F0

String_09_09_17:: ; heuristic: string; C0
Data_009_61E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The challenger", $F1
    db "wins battle one!", $F7
    db $F0

String_09_09_18:: ; heuristic: string; C0
Data_009_6207:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That's amazing!", $F1
    db "Is this true?", $FA, $F7
    db $EF, $EE, "The challenger", $EF, $EE, "wins battle two!", $F7
    db $F0

String_09_09_19:: ; heuristic: string; C0
Data_009_624C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 has", $F1
    db "won battle one!", $F7
    db $F0

String_09_09_1A:: ; heuristic: string; C0
Data_009_626E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 has", $F1
    db "won battle two!", $F7
    db $F0

String_09_09_1B:: ; heuristic: string; C0
Data_009_6290:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Incredible!", $F1
    db "The winners are", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the fun friends!", $E5, $48, $FA, $F7
    db $E9, $FF, $EF, $EE, "What an impressive", $EF, $EE, "debut!", $F7
    db $F0

String_09_09_1C:: ; heuristic: string; C0
Data_009_62F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The C Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the fun friends!", $E5, $4A, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's hear it for", $EF, $EE, "the champion!", $F7
    db $F0

String_09_09_1D:: ; heuristic: string; C0
Data_009_6361:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The B Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "trusty friends!", $E5, $4A, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's hear it for", $EF, $EE, "the champion!", $F7
    db $F0

String_09_09_1E:: ; heuristic: string; C0
Data_009_63CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The A Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "powerful friends!", $E5, $4A, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's have a huge", $EF, $EE, "hand for them!", $F7
    db $F0

String_09_09_1F:: ; heuristic: string; C0
Data_009_643A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The S Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "brave friends!", $E5, $4D, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's hear it for", $EF, $EE, "the new hero!", $F7
    db $F0

String_09_09_20:: ; heuristic: string; C0
Data_009_64A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This match's", $F1
    db "winners are", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the farm friends!", $FA, $F7
    db $EF, $EE, "Let's hear it for", $EF, $EE, "the winning party!", $F7
    db $F0

String_09_09_21:: ; heuristic: string; C0
Data_009_650C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Special", $F1
    db "Match winners are", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the farm friends!", $FA, $F7
    db $EF, $EE, "Let's hear it for", $EF, $EE, "the winning party!", $F7
    db $F0
    ds $1A86, $00
