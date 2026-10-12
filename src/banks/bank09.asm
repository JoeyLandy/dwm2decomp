SECTION "Bank 09", ROMX[$4000], BANK[$09]
    db $09

; ld de, this bank's string table / BeginStringDisplay
; 5 call sites from 5 routines (e.g. ShowString_Bank09, DebugMessageTest_Update_Case01, RunMessageBox_Bank12_Case01, RunMessageBoxStateIfActive_Bank12_Case01, ...)
BeginStringDisplay_Bank09::
Func_009_4001:: ; address name
    ld de, StringCategories_09_4016
    call BeginStringDisplay
    ret

; ld de, this bank's string table / CopyStringToBuffer
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case01_Case03, CopyItemStringToWC152)
CopyStringToBuffer_Bank09::
Func_009_4008:: ; address name
    ld de, StringCategories_09_4016
    call CopyStringToBuffer
    ret

; Func_009_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 16 call sites from 13 routines (e.g. ShowString0Bank09AtTiles16E0ThenItemDescription, ShowString1Bank09AtTiles16E0ThenDetails, PauseMenu_State3_Shared06, PauseMenu_State3_Shared07, ...)
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
    dw Data_009_4232 ; id 0
    dw Data_009_4259 ; id 1
    dw Data_009_4263 ; id 2

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_4030::
Data_009_4030:: ; address name
    dw Data_009_4294 ; id 0
    dw Data_009_42C8 ; id 1
    dw Data_009_42FB ; id 2
    dw Data_009_4331 ; id 3
    dw Data_009_437D ; id 4
    dw Data_009_43B6 ; id 5
    dw Data_009_43C8 ; id 6
    dw Data_009_43DD ; id 7
    dw Data_009_4408 ; id 8
    dw Data_009_4447 ; id 9
    dw Data_009_449F ; id 10
    dw Data_009_44B1 ; id 11
    dw Data_009_44C4 ; id 12
    dw Data_009_458A ; id 13
    dw Data_009_45D4 ; id 14
    dw Data_009_45F9 ; id 15
    dw Data_009_4616 ; id 16
    dw Data_009_4633 ; id 17
    dw Data_009_4675 ; id 18
    dw Data_009_4694 ; id 19
    dw Data_009_472C ; id 20
    dw Data_009_47D1 ; id 21
    dw Data_009_480D ; id 22
    dw Data_009_484D ; id 23
    dw Data_009_486E ; id 24
    dw Data_009_4893 ; id 25

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_4064::
Data_009_4064:: ; address name
    dw Data_009_48F0 ; id 0
    dw Data_009_48FC ; id 1
    dw Data_009_491C ; id 2
    dw Data_009_492A ; id 3
    dw Data_009_4936 ; id 4
    dw Data_009_4936 ; id 5
    dw Data_009_4947 ; id 6
    dw Data_009_4960 ; id 7
    dw Data_009_4968 ; id 8
    dw Data_009_4978 ; id 9

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_4078::
Data_009_4078:: ; address name
    dw Data_009_498A ; id 0
    dw Data_009_498C ; id 1
    dw Data_009_4990 ; id 2
    dw Data_009_4996 ; id 3
    dw Data_009_499C ; id 4
    dw Data_009_49A1 ; id 5
    dw Data_009_49A7 ; id 6
    dw Data_009_49AB ; id 7
    dw Data_009_49B1 ; id 8
    dw Data_009_49B7 ; id 9
    dw Data_009_49BD ; id 10
    dw Data_009_49C3 ; id 11
    dw Data_009_49C9 ; id 12
    dw Data_009_49CF ; id 13
    dw Data_009_49D5 ; id 14
    dw Data_009_49DB ; id 15
    dw Data_009_49E1 ; id 16
    dw Data_009_49E6 ; id 17
    dw Data_009_49EC ; id 18
    dw Data_009_49F2 ; id 19
    dw Data_009_49F8 ; id 20
    dw Data_009_49FD ; id 21
    dw Data_009_4A02 ; id 22
    dw Data_009_4A06 ; id 23
    dw Data_009_4A0C ; id 24
    dw Data_009_4A12 ; id 25
    dw Data_009_4A18 ; id 26
    dw Data_009_4A1E ; id 27
    dw Data_009_4A23 ; id 28
    dw Data_009_4A28 ; id 29
    dw Data_009_4A2D ; id 30
    dw Data_009_4A33 ; id 31
    dw Data_009_4A39 ; id 32
    dw Data_009_4A3D ; id 33
    dw Data_009_4A42 ; id 34
    dw Data_009_4A47 ; id 35
    dw Data_009_4A4D ; id 36
    dw Data_009_4A51 ; id 37
    dw Data_009_4A57 ; id 38
    dw Data_009_4A5D ; id 39
    dw Data_009_4A62 ; id 40
    dw Data_009_4A67 ; id 41
    dw Data_009_4A6D ; id 42
    dw Data_009_4A73 ; id 43
    dw Data_009_4A79 ; id 44
    dw Data_009_4A7E ; id 45
    dw Data_009_4A84 ; id 46
    dw Data_009_4A8A ; id 47
    dw Data_009_4A90 ; id 48
    dw Data_009_4A96 ; id 49
    dw Data_009_4A9C ; id 50
    dw Data_009_4AA1 ; id 51
    dw Data_009_4AA7 ; id 52
    dw Data_009_4AAB ; id 53
    dw Data_009_4AAF ; id 54
    dw Data_009_4AB3 ; id 55
    dw Data_009_4AB8 ; id 56
    dw Data_009_4ABE ; id 57
    dw Data_009_4AC4 ; id 58
    dw Data_009_4AC9 ; id 59
    dw Data_009_4ACF ; id 60
    dw Data_009_4AD5 ; id 61
    dw Data_009_4ADB ; id 62
    dw Data_009_4AE1 ; id 63
    dw Data_009_4AE6 ; id 64
    dw Data_009_4AEB ; id 65
    dw Data_009_4AF0 ; id 66
    dw Data_009_4AF5 ; id 67
    dw Data_009_4AFA ; id 68
    dw Data_009_4AFF ; id 69
    dw Data_009_4B05 ; id 70
    dw Data_009_4B0B ; id 71
    dw Data_009_4B11 ; id 72

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_410A::
Data_009_410A:: ; address name
    dw Data_009_4B16 ; id 0

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_410C::
Data_009_410C:: ; address name
    dw Data_009_4B17 ; id 0
    dw Data_009_4B3B ; id 1
    dw Data_009_4B5E ; id 2
    dw Data_009_4B76 ; id 3
    dw Data_009_4B98 ; id 4
    dw Data_009_4BC0 ; id 5
    dw Data_009_4BE2 ; id 6
    dw Data_009_4C29 ; id 7
    dw Data_009_4C76 ; id 8
    dw Data_009_4C8E ; id 9
    dw Data_009_4CB2 ; id 10
    dw Data_009_4CD8 ; id 11
    dw Data_009_4D3E ; id 12
    dw Data_009_4D7D ; id 13
    dw Data_009_4D96 ; id 14
    dw Data_009_4DB8 ; id 15
    dw Data_009_4DC6 ; id 16
    dw Data_009_4E24 ; id 17
    dw Data_009_4E48 ; id 18
    dw Data_009_4E93 ; id 19
    dw Data_009_4EE7 ; id 20
    dw Data_009_4F2F ; id 21
    dw Data_009_4F53 ; id 22
    dw Data_009_4FD5 ; id 23
    dw Data_009_5019 ; id 24
    dw Data_009_507B ; id 25
    dw Data_009_50B8 ; id 26
    dw Data_009_50FA ; id 27
    dw Data_009_510F ; id 28
    dw Data_009_5170 ; id 29
    dw Data_009_51B9 ; id 30
    dw Data_009_51DB ; id 31
    dw Data_009_521E ; id 32
    dw Data_009_522C ; id 33
    dw Data_009_524C ; id 34
    dw Data_009_5263 ; id 35
    dw Data_009_527A ; id 36
    dw Data_009_52E0 ; id 37
    dw Data_009_5325 ; id 38
    dw Data_009_5339 ; id 39
    dw Data_009_533A ; id 40
    dw Data_009_533D ; id 41
    dw Data_009_5340 ; id 42
    dw Data_009_5344 ; id 43
    dw Data_009_5348 ; id 44
    dw Data_009_534C ; id 45
    dw Data_009_5350 ; id 46
    dw Data_009_53C1 ; id 47
    dw Data_009_5431 ; id 48
    dw Data_009_5451 ; id 49
    dw Data_009_5471 ; id 50
    dw Data_009_5490 ; id 51
    dw Data_009_54D2 ; id 52
    dw Data_009_551E ; id 53
    dw Data_009_553A ; id 54
    dw Data_009_555C ; id 55
    dw Data_009_55AC ; id 56
    dw Data_009_55EE ; id 57
    dw Data_009_562B ; id 58
    dw Data_009_564A ; id 59
    dw Data_009_568D ; id 60
    dw Data_009_56D6 ; id 61
    dw Data_009_571C ; id 62
    dw Data_009_575D ; id 63
    dw Data_009_5780 ; id 64
    dw Data_009_57BF ; id 65
    dw Data_009_5803 ; id 66
    dw Data_009_5848 ; id 67
    dw Data_009_5866 ; id 68
    dw Data_009_5886 ; id 69
    dw Data_009_58A6 ; id 70
    dw Data_009_58C6 ; id 71
    dw Data_009_58E5 ; id 72
    dw Data_009_591E ; id 73
    dw Data_009_5967 ; id 74
    dw Data_009_5986 ; id 75
    dw Data_009_59C8 ; id 76
    dw Data_009_5A03 ; id 77
    dw Data_009_5A21 ; id 78
    dw Data_009_5A5D ; id 79
    dw Data_009_5A9A ; id 80
    dw Data_009_5AE3 ; id 81
    dw Data_009_5B08 ; id 82
    dw Data_009_5B2E ; id 83

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41B4::
Data_009_41B4:: ; address name
    dw Data_009_5B6F ; id 0
    dw Data_009_5B70 ; id 1
    dw Data_009_5B7A ; id 2
    dw Data_009_5B81 ; id 3
    dw Data_009_5B89 ; id 4
    dw Data_009_5B8E ; id 5
    dw Data_009_5B93 ; id 6
    dw Data_009_5B9A ; id 7
    dw Data_009_5B9F ; id 8
    dw Data_009_5BA7 ; id 9
    dw Data_009_5BB1 ; id 10
    dw Data_009_5BB8 ; id 11
    dw Data_009_5BC0 ; id 12

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41CE::
Data_009_41CE:: ; address name
    dw Data_009_5BC6 ; id 0
    dw Data_009_5BC9 ; id 1
    dw Data_009_5BDD ; id 2
    dw Data_009_5BF2 ; id 3
    dw Data_009_5C04 ; id 4
    dw Data_009_5C16 ; id 5
    dw Data_009_5C28 ; id 6
    dw Data_009_5C37 ; id 7
    dw Data_009_5C49 ; id 8
    dw Data_009_5C5E ; id 9
    dw Data_009_5C73 ; id 10
    dw Data_009_5C87 ; id 11
    dw Data_009_5C9C ; id 12
    dw Data_009_5CAF ; id 13
    dw Data_009_5CC3 ; id 14

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41EC::
Data_009_41EC:: ; address name
    dw Data_009_5CCF ; id 0

; E-0217 (derived: category list of StringCategories_09_4016; one pointer per wStringIndex)
; record: string
StringList_09_41EE::
Data_009_41EE:: ; address name
    dw Data_009_5D06 ; id 0
    dw Data_009_5D44 ; id 1
    dw Data_009_5DA1 ; id 2
    dw Data_009_5E03 ; id 3
    dw Data_009_5E63 ; id 4
    dw Data_009_5EBE ; id 5
    dw Data_009_5EE3 ; id 6
    dw Data_009_5F08 ; id 7
    dw Data_009_5F2D ; id 8
    dw Data_009_5F52 ; id 9
    dw Data_009_5F77 ; id 10
    dw Data_009_5F9C ; id 11
    dw Data_009_5FF5 ; id 12
    dw Data_009_6019 ; id 13
    dw Data_009_603C ; id 14
    dw Data_009_605E ; id 15
    dw Data_009_6082 ; id 16
    dw Data_009_60A3 ; id 17
    dw Data_009_610F ; id 18
    dw Data_009_6130 ; id 19
    dw Data_009_614B ; id 20
    dw Data_009_6166 ; id 21
    dw Data_009_61A2 ; id 22
    dw Data_009_61E3 ; id 23
    dw Data_009_6207 ; id 24
    dw Data_009_624C ; id 25
    dw Data_009_626E ; id 26
    dw Data_009_6290 ; id 27
    dw Data_009_62F5 ; id 28
    dw Data_009_6361 ; id 29
    dw Data_009_63CC ; id 30
    dw Data_009_643A ; id 31
    dw Data_009_64A4 ; id 32
    dw Data_009_650C ; id 33

Data_009_4232:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WHATUsoePersoHPMPATKDEFAGLINTWLDnality", $F0

Data_009_4259:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TOWHOHPMP", $F0

Data_009_4263:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RJadlnoprtuxy-fWATUCHPMDcgimhw    Dcgimh       ", $AC, $F0

Data_009_4294:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "But it was empty.", $F7
    db $F0

Data_009_42C8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained", $F1
    db $F9, $4E, "G.", $F7
    db $F0

Data_009_42FB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained the", $F1
    db $F9, "Y.", $F7
    db $F0

Data_009_4331:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "Found ", $F9, "Y.", $F1
    db $FA, $F7
    db $F2, "But there is no", $F1
    db "room for it.", $F7
    db $F0

Data_009_437D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "The chest was a", $F1
    db "Mimic!", $F7
    db $F0

Data_009_43B6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained", $F1
    db $F9, $4E, "G.", $F7
    db $F0

Data_009_43C8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db $F9, "Y.", $F7
    db $F0

Data_009_43DD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Found ", $F9, "Y.", $F1
    db $FA, $F7
    db $F2, "But there is no", $F1
    db "room for it.", $F7
    db $F0

Data_009_4408:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained a", $F1
    db "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Data_009_4447:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, "A Magic Key was", $F1
    db "found.", $FA, $F7
    db $F2, "But there is no", $F1
    db "room for it.", $F7
    db $F0

Data_009_449F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N dropped", $F1
    db "dead.", $F7
    db $F0

Data_009_44B1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F2, $F9, "N dropped", $F1
    db "dead.", $F7
    db $F0

Data_009_44C4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Wiped out were", $EF, $EE, "you, warooh?", $FA, $F7
    db $EF, $EE, "GreatLog can't be", $EF, $EE, "saved if you're a", $FA, $F7
    db $EF, $EE, "waffling little", $EF, $EE, "wimp, warooh.", $FA, $F7
    db $EF, $EE, "I'm big-hearted,", $EF, $EE, "so I'll share some", $FA, $F7
    db $EF, $EE, "of GreatLog's power", $EF, $EE, "with you.", $F7
    db $F0

Data_009_458A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0! You're safe!", $FA, $F7
    db $EF, $EE, "I'll share some of", $EF, $EE, "GreatLog's power.", $F7
    db $F0

Data_009_45D4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The two monsters", $F1
    db "went away quietly", $A4, $F7
    db $F0

Data_009_45F9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Repellent's effect", $F1
    db "wore off.", $F7
    db $F0

Data_009_4616:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StepGuard's effect", $F1
    db "wore off.", $F7
    db $F0

Data_009_4633:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey.", $F1
    db "There. All healed!", $FA, $F7
    db $EF, $EE, "You be careful,", $EF, $EE, "warooh!", $F7
    db $F0

Data_009_4675:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChangeStaff's", $F1
    db "effect wore off.", $F7
    db $F0

Data_009_4694:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0, wiped out?", $FA, $F7
    db $EF, $EE, "That isn't good at", $EF, $EE, "all for a master!", $FA, $F7
    db $EF, $EE, "I'm big-hearted so", $EF, $EE, "I'll share some of", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "with you, warooh!", $F7
    db $F0

Data_009_472C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " Hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Getting wiped out", $EF, $EE, "is wimpy!", $FA, $F7
    db $EF, $EE, "You're not much of", $EF, $EE, "a hero, are you?", $FA, $F7
    db $EF, $EE, "Peti's big-hearted,", $EF, $EE, "so I'll share some", $FA, $F7
    db $EF, $EE, "of GreatLog's power", $EF, $EE, "with you.", $F7
    db $F0

Data_009_47D1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " Back,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "I'll share some of", $EF, $EE, "GreatLog's power.", $F7
    db $F0

Data_009_480D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " There.", $F1
    db "All healed now.", $FA, $F7
    db $EF, $EE, "You be careful out", $EF, $EE, "there!", $F7
    db $F0

Data_009_484D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "X hatched.", $FA, $F7
    db $F1
    db "Please name it.", $EF, $EE, $F7
    db $F0

Data_009_486E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "X", $A2, $F9, $4E, $F1
    db "hatched.", $FA, $F7
    db $EF, $EE, "Please name it.", $EF, $EE, $F7
    db $F0

Data_009_4893:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $F2, $F9, "0 obtained a", $F1
    db "DreamEgg.", $FA, $F7
    db $EF, $EE, "DreamEgg was sent", $EF, $EE, "to the farm.", $F7
    db $F0

Data_009_48F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FIGHTEMPLAN", $F0

Data_009_48FC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChargeMixedDefense      Command", $F0

Data_009_491C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FightSklGuard", $F0

Data_009_492A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TOWHAlyEnem", $F0

Data_009_4936:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOKMonsterEgg", $F0

Data_009_4947:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skill On", $9E, "Off Orb ID Odds", $F0

Data_009_4960:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No Skil", $F0

Data_009_4968:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Special Command", $F0

Data_009_4978:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Betray", $F1
    db "Twin", $F1
    db "Guard", $F0

Data_009_498A:: ; heuristic: string; C0
    db $B8, $F0

Data_009_498C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ylw", $F0

Data_009_4990:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Plain", $F0

Data_009_4996:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Green", $F0

Data_009_499C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blue", $F0

Data_009_49A1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "First", $F0

Data_009_49A7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Red", $F0

Data_009_49AB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "White", $F0

Data_009_49B1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Quiet", $F0

Data_009_49B7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Black", $F0

Data_009_49BD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gaudy", $F0

Data_009_49C3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Silvr", $F0

Data_009_49C9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dream", $F0

Data_009_49CF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Misty", $F0

Data_009_49D5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Secrt", $F0

Data_009_49DB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shiny", $F0

Data_009_49E1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Last", $F0

Data_009_49E6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

Data_009_49EC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Draco", $F0

Data_009_49F2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beast", $F0

Data_009_49F8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bird", $F0

Data_009_49FD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tree", $F0

Data_009_4A02:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bug", $F0

Data_009_4A06:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devil", $F0

Data_009_4A0C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Death", $F0

Data_009_4A12:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thing", $F0

Data_009_4A18:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

Data_009_4A1E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lord", $F0

Data_009_4A23:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cave", $F0

Data_009_4A28:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Isle", $F0

Data_009_4A2D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Torch", $F0

Data_009_4A33:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gardn", $F0

Data_009_4A39:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pit", $F0

Data_009_4A3D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bsmt", $F0

Data_009_4A42:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jail", $F0

Data_009_4A47:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magma", $F0

Data_009_4A4D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sea", $F0

Data_009_4A51:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Field", $F0

Data_009_4A57:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tower", $F0

Data_009_4A5D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine", $F0

Data_009_4A62:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hill", $F0

Data_009_4A67:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cstle", $F0

Data_009_4A6D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mound", $F0

Data_009_4A73:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desrt", $F0

Data_009_4A79:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake", $F0

Data_009_4A7E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jungl", $F0

Data_009_4A84:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Haven", $F0

Data_009_4A8A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grass", $F0

Data_009_4A90:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Forst", $F0

Data_009_4A96:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grave", $F0

Data_009_4A9C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Crag", $F0

Data_009_4AA1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shore", $F0

Data_009_4AA7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log", $F0

Data_009_4AAB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sky", $F0

Data_009_4AAF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mtn", $F0

Data_009_4AB3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "View", $F0

Data_009_4AB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cliff", $F0

Data_009_4ABE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Islet", $F0

Data_009_4AC4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Land", $F0

Data_009_4AC9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grove", $F0

Data_009_4ACF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swamp", $F0

Data_009_4AD5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Manor", $F0

Data_009_4ADB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Depth", $F0

Data_009_4AE1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hole", $F0

Data_009_4AE6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tomb", $F0

Data_009_4AEB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soil", $F0

Data_009_4AF0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pond", $F0

Data_009_4AF5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hell", $F0

Data_009_4AFA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moon", $F0

Data_009_4AFF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ocean", $F0

Data_009_4B05:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulch", $F0

Data_009_4B0B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "River", $F0

Data_009_4B11:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Star", $F0

Data_009_4B16:: ; heuristic: string; C0
    db $F0

Data_009_4B17:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Allow me to heal", $F1
    db "your injuries.", $F7
    db $F0

Data_009_4B3B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I will pray for", $F1
    db "you. Farewell.", $F7
    db $F0

Data_009_4B5E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "Y! Only", $F1
    db $F9, $4E, "G! Well?", $FF, $F0

Data_009_4B76:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Thanks! Hope I", $F1
    db "see you again!", $F7
    db $F0

Data_009_4B98:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hah? Not buying?", $F1
    db "Bah, another time.", $F7
    db $F0

Data_009_4BC0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll heal you", $F1
    db "for 1000G. Well?", $FF, $F0

Data_009_4BE2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hehehe, money is", $F1
    db "my motivation.", $FA, $F7
    db $EF, $EE, "Hope you'll give", $EF, $EE, "me some again!", $F7
    db $F0

Data_009_4C29:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, I hope your", $F1
    db "luck holds, kid!", $FA, $F7
    db $EF, $EE, "Don't blame me if", $EF, $EE, "you don't make it.", $F7
    db $F0

Data_009_4C76:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "Y! Just", $F1
    db $F9, $4E, "G! Well?", $FF, $F0

Data_009_4C8E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heheheh, thanks!", $F1
    db "See you again!", $F7
    db $F0

Data_009_4CB2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, tightwad", $A4, $F1
    db "You'll regret this.", $F7
    db $F0

Data_009_4CD8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm a wandering", $F1
    db "master.", $FA, $F7
    db $EF, $EE, "I", $42, "e been on the", $EF, $EE, "road for training.", $FA, $F7
    db $EF, $EE, "You look tough.", $EF, $EE, "Want to battle?", $FF, $F0

Data_009_4D3E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Urgh. Tougher", $F1
    db "than me", $A4, $FA, $F7
    db $EF, $EE, "I", $44, " better redouble", $EF, $EE, "my training.", $F7
    db $F0

Data_009_4D7D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained a", $F1
    db "WarpWing.", $F7
    db $F0

Data_009_4D96:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hahahah! I", $F1
    db "overestimated you!", $F7
    db $F0

Data_009_4DB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 lost", $F1
    db $F9, $4E, "G.", $F7
    db $F0

Data_009_4DC6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm a traveling", $F1
    db "master.", $FA, $F7
    db $EF, $EE, "I'm training", $EF, $EE, "my monsters.", $FA, $F7
    db $EF, $EE, "You look strong.", $EF, $EE, "Will you battle?", $FF, $F0

Data_009_4E24:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Uh-oh, I lost!", $F1
    db "I can do better!", $F7
    db $F0

Data_009_4E48:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm sorry, but", $F1
    db "you didn't put up", $FA, $F7
    db $EF, $EE, "much resistance.", $EF, $EE, "I'm a little bored.", $F7
    db $F0

Data_009_4E93:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hi! Want to try", $F1
    db "your luck?", $FA, $F7
    db $EF, $EE, $F9, "Y is the", $EF, $EE, "prize!", $FA, $F7
    db $EF, $EE, "Want to try?", $EF, $EE, "It's just 100G!", $FF, $F0

Data_009_4EE7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'll pick a card", $F1
    db "between 1 and 13.", $FA, $F7
    db $EF, $EE, "Is the card I", $EF, $EE, "picked above 7?", $FF, $F0

Data_009_4F2F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'll have nice", $F1
    db "prizes next time.", $F7
    db $F0

Data_009_4F53:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Wow! You win!", $FA, $F7
    db $EF, $EE, "Next, ", $F9, "Y is", $EF, $EE, "the prize.", $FA, $F7
    db $EF, $EE, "Want to bet what", $EF, $EE, "you", $42, "e won so far", $FA, $F7
    db $EF, $EE, "and ", $F9, $51, "G for a", $EF, $EE, "chance to win?", $FF, $F0

Data_009_4FD5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Whoops, you lose.", $FA, $F7
    db $EF, $EE, "I'll take ", $F9, $51, "G", $EF, $EE, "and any prize.", $F7
    db $F0

Data_009_5019:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Oh, same number?", $FA, $F7
    db $EF, $EE, "Sorry, I win in", $EF, $EE, "this case.", $FA, $F7
    db $EF, $EE, "I'll take ", $F9, $51, "G", $EF, $EE, "and any prize.", $F7
    db $F0

Data_009_507B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do you think the", $F1
    db "next card I pick", $FA, $F7
    db $EF, $EE, "will be above ", $F9, $4E, "?", $EF, $EE, $FF, $F0

Data_009_50B8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Awww, you won't", $F1
    db "play?", $FA, $F7
    db $EF, $EE, "Please come again", $EF, $EE, "and try your luck!", $F7
    db $F0

Data_009_50FA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained", $F1
    db "the ", $F9, "Y.", $F7
    db $F0

Data_009_510F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I picked", $A4, " ", $F9, $4E, "!", $F1
    db "Wow! You win!", $FA, $F7
    db $EF, $EE, "That was the last", $EF, $EE, "prize!", $FA, $F7
    db $EF, $EE, "Please try again", $EF, $EE, "the next time!", $F7
    db $F0

Data_009_5170:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you can beat", $F1
    db "me, I'll give you", $FA, $F7
    db $EF, $EE, "something good.", $EF, $EE, "Want to battle?", $FF, $F0

Data_009_51B9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Very good. Here's", $F1
    db "your reward.", $F7
    db $F0

Data_009_51DB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, that was", $F1
    db "unseemly.", $FA, $F7
    db $EF, $EE, "You shouldn't shirk", $EF, $EE, "from training.", $F7
    db $F0

Data_009_521E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 lost", $F1
    db $F9, $4E, "G.", $F7
    db $F0

Data_009_522C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Do you want a map?", $F1
    db "Just 200G.", $FF, $F0

Data_009_524C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No?", $F1
    db "That's too bad.", $F7
    db $F0

Data_009_5263:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 handed over", $F1
    db "200G.", $F7
    db $F0

Data_009_527A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll give you", $F1
    db "special medicine", $FA, $F7
    db $EF, $EE, "if you manage to", $EF, $EE, "defeat me.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "challenge me?", $FF, $F0

Data_009_52E0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e won.", $F1
    db "As promised, let", $FA, $F7
    db $EF, $EE, "me give you some", $EF, $EE, "of my medicine.", $F7
    db $F0

Data_009_5325:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "N's ", $F9, "Y", $F1
    db "rose by ", $F9, $4E, ".", $F7
    db $F0

Data_009_5339:: ; heuristic: string; C0
    db $F0

Data_009_533A:: ; heuristic: string; C0
    db $11, $19, $F0

Data_009_533D:: ; heuristic: string; C0
    db $16, $19, $F0

Data_009_5340:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ATK", $F0

Data_009_5344:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DEF", $F0

Data_009_5348:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AGL", $F0

Data_009_534C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "INT", $F0

Data_009_5350:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome aboard", $F1
    db "the casino ship!", $FA, $F7
    db $EF, $EE, "Have a spin on the", $EF, $EE, "slots for 100G!", $FA, $F7
    db $EF, $EE, "There are prizes", $EF, $EE, "too. Try it out?", $FF, $F0

Data_009_53C1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Stop the reels", $F1
    db "with the A Button.", $FA, $F7
    db $EF, $EE, "Depending on what", $EF, $EE, "marks you line up,", $FA, $F7
    db $EF, $EE, "the prizes will", $EF, $EE, "vary. Ready?", $F7
    db $F0

Data_009_5431:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky! You win a", $F1
    db "TinyMedal!", $F7
    db $F0

Data_009_5451:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There it is!", $F1
    db "You win 1000G!", $F7
    db $F0

Data_009_5471:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whoa! You", $42, "e won", $F1
    db "a MeteOrb!", $F7
    db $F0

Data_009_5490:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whoa", $A4, " Are you", $F1
    db "kidding me?", $FA, $F7
    db $EF, $EE, "You", $42, "e won some", $EF, $EE, "secret medicine.", $F7
    db $F0

Data_009_54D2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Are you serious?", $F1
    db "I don't believe it.", $FA, $F7
    db $EF, $EE, "You", $42, "e won some", $EF, $EE, "secret medicine.", $F7
    db $F0

Data_009_551E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Too bad", $A4, $F1
    db "Try again, OK?", $F7
    db $F0

Data_009_553A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That's too bad.", $F1
    db "See you again.", $F7
    db $F0

Data_009_555C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I will heal your", $F1
    db "injuries for you", $A4, $FA, $F7
    db $EF, $EE, "If you can defeat", $EF, $EE, "me, that is. Well?", $FF, $F0

Data_009_55AC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine, fine,", $F1
    db "I surrender.", $FA, $F7
    db $EF, $EE, "I'll heal your", $EF, $EE, "party as promised.", $F7
    db $F0

Data_009_55EE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Your lack of", $F1
    db "training is clear.", $FA, $F7
    db $EF, $EE, "Best of luck to", $EF, $EE, "you", $A4, $F7
    db $F0

Data_009_562B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let me lighten", $F1
    db "your purse.", $F7
    db $F0

Data_009_564A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I see an injured", $F1
    db "monster", $A4, $FA, $F7
    db $EF, $EE, "Heh, I think I can", $EF, $EE, "win this one.", $F7
    db $F0

Data_009_568D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, at least one", $F1
    db "monster tired?", $FA, $F7
    db $EF, $EE, "This works out", $EF, $EE, "perfectly for me.", $F7
    db $F0

Data_009_56D6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, those are", $F1
    db "some weaklings!", $FA, $F7
    db $EF, $EE, "That makes things", $EF, $EE, "easy for me.", $F7
    db $F0

Data_009_571C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The fugitive", $F1
    db "master was", $FA, $F7
    db $EF, $EE, "captured and sent", $EF, $EE, "back to GreatLog.", $F7
    db $F0

Data_009_575D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll unburden", $F1
    db "you of your gold.", $F7
    db $F0

Data_009_5780:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm not dirty-", $F1
    db "not at all.", $FA, $F7
    db $EF, $EE, "You shouldn't be", $EF, $EE, "so careless.", $F7
    db $F0

Data_009_57BF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll need more", $F1
    db "experience to", $FA, $F7
    db $EF, $EE, "catch me, much", $EF, $EE, "more, hahahah!", $F7
    db $F0

Data_009_5803:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heheheh, your", $F1
    db "looks don't lie!", $FA, $F7
    db $EF, $EE, "That'll teach you", $EF, $EE, "to stay away!", $F7
    db $F0

Data_009_5848:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Data_009_5866:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 500G!", $F7
    db $F0

Data_009_5886:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 200G!", $F7
    db $F0

Data_009_58A6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 100G!", $F7
    db $F0

Data_009_58C6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lucky, kid!", $F1
    db "You", $42, "e won 50G!", $F7
    db $F0

Data_009_58E5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e no courage", $F1
    db "to battle?", $FA, $F7
    db $EF, $EE, "Shame, it really", $EF, $EE, "is.", $F7
    db $F0

Data_009_591E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I take being a", $F1
    db "master seriously.", $FA, $F7
    db $EF, $EE, "I won't hold back", $EF, $EE, "from anything!", $F7
    db $F0

Data_009_5967:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No? You're rather", $F1
    db "cowardly.", $F7
    db $F0

Data_009_5986:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, the sparkle", $F1
    db "in your eyes", $A4, $FA, $F7
    db $EF, $EE, "I", $44, " best not", $EF, $EE, "disappoint you!", $F7
    db $F0

Data_009_59C8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What?", $F1
    db "Little chicken!", $FA, $F7
    db $EF, $EE, "Go home to your", $EF, $EE, "mommy, baby!", $F7
    db $F0

Data_009_5A03:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good answer!", $F1
    db "Let's battle!", $F7
    db $F0

Data_009_5A21:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you poor", $F1
    db "monsters.", $FA, $F7
    db $EF, $EE, "You have such a", $EF, $EE, "poor master", $A4, $F7
    db $F0

Data_009_5A5D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you're ready,", $F1
    db "are you?", $FA, $F7
    db $EF, $EE, "But I don't plan", $EF, $EE, "on losing!", $F7
    db $F0

Data_009_5A9A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I thought you", $F1
    db "were dedicated", $A4, $FA, $F7
    db $EF, $EE, "But my eyes must", $EF, $EE, "have been misled.", $F7
    db $F0

Data_009_5AE3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My eyes didn't", $F1
    db "mislead me. Ready?", $F7
    db $F0

Data_009_5B08:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Now you can see", $F1
    db "the entire world!", $F7
    db $F0

Data_009_5B2E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hope you'll", $F1
    db "put up more of a", $FA, $F7
    db $EF, $EE, "fight next time", $EF, $EE, "than this", $A4, $F7
    db $F0

Data_009_5B6F:: ; heuristic: string; C0
    db $F0

Data_009_5B70:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog", $5B, $F0

Data_009_5B7A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Oasis", $5B, $F0

Data_009_5B81:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pirate", $5B, $F0

Data_009_5B89:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ice", $5B, $F0

Data_009_5B8E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sky", $5B, $F0

Data_009_5B93:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Limbo", $5B, $F0

Data_009_5B9A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Elf", $5B, $F0

Data_009_5B9F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lonely", $5B, $F0

Data_009_5BA7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traveler", $5B, $F0

Data_009_5BB1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brawn", $5B, $F0

Data_009_5BB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle", $5B, $F0

Data_009_5BC0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul", $5B, $F0

Data_009_5BC6:: ; heuristic: string; C0
    db $F1, $F1, $F0

Data_009_5BC9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "return", $F1
    db "home.", $F0

Data_009_5BDD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Desert", $F1
    db "World.", $F0

Data_009_5BF2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Sea", $F1
    db "World.", $F0

Data_009_5C04:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Ice", $F1
    db "World.", $F0

Data_009_5C16:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Sky", $F1
    db "World.", $F0

Data_009_5C28:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Limbo.", $F1
    db $F0

Data_009_5C37:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Elf", $F1
    db "World.", $F0

Data_009_5C49:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Lonely", $F1
    db "World.", $F0

Data_009_5C5E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Travel", $F1
    db "World.", $F0

Data_009_5C73:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Power", $F1
    db "World.", $F0

Data_009_5C87:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Baffle", $F1
    db "World.", $F0

Data_009_5C9C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db "Soul", $F1
    db "World.", $F0

Data_009_5CAF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic", $F1
    db "Key to", $F1
    db "where?", $F0

Data_009_5CC3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key to", $F1
    db $F9, "0.", $F1
    db $F0

Data_009_5CCF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "New gameContinueVS battleBreedTrade ", $B8, "Journal datalost", $A4, $F0

Data_009_5D06:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "We have a special", $EF, $EE, "team with us!", $F7
    db $F0

Data_009_5D44:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For today's C", $EF, $EE, "Class Challenge,", $FA, $F7
    db $EF, $EE, "we have a little", $EF, $EE, "challenger!", $F7
    db $F0

Data_009_5DA1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For today's B", $EF, $EE, "Class Tournament,", $FA, $F7
    db $EF, $EE, "we have a brave,", $EF, $EE, "new challenger!", $F7
    db $F0

Data_009_5E03:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Arena!", $FA, $F7
    db $EF, $EE, "For today's A", $EF, $EE, "Class Tournament,", $FA, $F7
    db $EF, $EE, "we have a hot, new", $EF, $EE, "challenger!", $F7
    db $F0

Data_009_5E63:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ladies and", $F1
    db "gentlemen!", $FA, $F7
    db $EF, $EE, "For today's S", $EF, $EE, "Class Tournament,", $FA, $F7
    db $EF, $EE, "we have a brand", $EF, $EE, "new hero!", $F7
    db $F0

Data_009_5EBE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " E Class battles", $F1
    db "are ready to go!", $F7
    db $F0

Data_009_5EE3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " D Class battles", $F1
    db "are ready to go!", $F7
    db $F0

Data_009_5F08:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " C Class battles", $F1
    db "are ready to go!", $F7
    db $F0

Data_009_5F2D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " B Class battles", $F1
    db "are ready to go!", $F7
    db $F0

Data_009_5F52:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A Class battles", $F1
    db "are ready to go!", $F7
    db $F0

Data_009_5F77:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " S Class battles", $F1
    db "are ready to go!", $F7
    db $F0

Data_009_5F9C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ladies and", $F1
    db "gentlemen!", $FA, $F7
    db $EF, $EE, "Get ready for a", $EF, $EE, "Special Match!", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0", $EF, $EE, "will take on", $A4, $F7
    db $F0

Data_009_5FF5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "the farm friends!", $F7
    db $F0

Data_009_6019:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "the fun friends!", $F7
    db $F0

Data_009_603C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "trusty friends!", $F7
    db $F0

Data_009_605E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "powerful friends!", $F7
    db $F0

Data_009_6082:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 and", $F1
    db "brave friends!", $F7
    db $F0

Data_009_60A3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This next battle", $F1
    db "will feature the", $FA, $F7
    db $EF, $EE, "up-and-coming", $EF, $EE, "monster master", $A4, $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the farm friends!", $F7
    db $F0

Data_009_610F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ????????? and", $F1
    db "????? friends!", $F7
    db $F0

Data_009_6130:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Battle one!", $F1
    db "Ready? Go!", $F7
    db $F0

Data_009_614B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Battle two!", $F1
    db "Ready? Go!", $F7
    db $F0

Data_009_6166:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This decides the", $F1
    db "champion!", $FA, $F7
    db $EF, $EE, "Final battle!", $EF, $EE, "Ready? Go!", $F7
    db $F0

Data_009_61A2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is it! The", $F1
    db "deciding battle!", $FA, $F7
    db $EF, $EE, "Are you ready?", $EF, $EE, "Let's go!", $F7
    db $F0

Data_009_61E3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The challenger", $F1
    db "wins battle one!", $F7
    db $F0

Data_009_6207:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That's amazing!", $F1
    db "Is this true?", $FA, $F7
    db $EF, $EE, "The challenger", $EF, $EE, "wins battle two!", $F7
    db $F0

Data_009_624C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 has", $F1
    db "won battle one!", $F7
    db $F0

Data_009_626E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master ", $F9, "0 has", $F1
    db "won battle two!", $F7
    db $F0

Data_009_6290:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Incredible!", $F1
    db "The winners are", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the fun friends!", $E5, $48, $FA, $F7
    db $E9, $FF, $EF, $EE, "What an impressive", $EF, $EE, "debut!", $F7
    db $F0

Data_009_62F5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The C Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the fun friends!", $E5, $4A, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's hear it for", $EF, $EE, "the champion!", $F7
    db $F0

Data_009_6361:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The B Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "trusty friends!", $E5, $4A, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's hear it for", $EF, $EE, "the champion!", $F7
    db $F0

Data_009_63CC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The A Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "powerful friends!", $E5, $4A, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's have a huge", $EF, $EE, "hand for them!", $F7
    db $F0

Data_009_643A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The S Class", $F1
    db "champion party is", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "brave friends!", $E5, $4D, $FA, $F7
    db $E9, $FF, $EF, $EE, "Let's hear it for", $EF, $EE, "the new hero!", $F7
    db $F0

Data_009_64A4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This match's", $F1
    db "winners are", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the farm friends!", $FA, $F7
    db $EF, $EE, "Let's hear it for", $EF, $EE, "the winning party!", $F7
    db $F0

Data_009_650C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Special", $F1
    db "Match winners are", $FA, $F7
    db $EF, $EE, "Master ", $F9, "0 and", $EF, $EE, "the farm friends!", $FA, $F7
    db $EF, $EE, "Let's hear it for", $EF, $EE, "the winning party!", $F7
    db $F0
    ds $1A86, $00
